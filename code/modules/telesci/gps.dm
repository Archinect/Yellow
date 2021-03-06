var/list/GPS_list = list()
/obj/item/device/gps
	name = "global positioning system"
	desc = "Helping lost spacemen find their way through the planets since 2016. Alt+click to toggle power."
	icon = 'icons/obj/telescience.dmi'
	icon_state = "gps-c"
	w_class = 2
	slot_flags = SLOT_BELT
	origin_tech = "materials=2;magnets=1;bluespace=2"
	var/gpstag = "COM0"
	var/emped = 0
	var/turf/locked_location
	var/tracking = TRUE
	var/intelligent

/obj/item/device/gps/examine(mob/user)
	..()
	if(intelligent)
		user << "<span class='notice'>This GPS is upgraded with intelligent software. It will label other GPS's with a tag based on it's location from you.</span>"
		user << "<span class='red'>The \[Adjacent\] tag means they are within 20 feet.</span>"
		user << "<span class='blue'>The \[Close-By\] tag means they are within 40 feet.</span>"
		user << "<span class='white'>The \[Away\] tag means they are anywhere farther than that.</span>"

/obj/item/device/gps/New()
	..()
	GPS_list.Add(src)
	name = "global positioning system ([gpstag])"
	add_overlay("working")

/obj/item/device/gps/Destroy()
	GPS_list.Remove(src)
	return ..()

/obj/item/device/gps/emp_act(severity)
	emped = TRUE
	overlays -= "working"
	add_overlay("emp")
	addtimer(src, "reboot", 300)

/obj/item/device/gps/proc/reboot()
	emped = FALSE
	overlays -= "emp"
	add_overlay("working")

/obj/item/device/gps/AltClick(mob/user)
	if(!user.canUseTopic(src, be_close=TRUE))
		return //user not valid to use gps
	if(emped)
		user.text2tab("It's busted!")
	if(tracking)
		overlays -= "working"
		user.text2tab("[src] is no longer tracking, or visible to other GPS devices.")
		tracking = FALSE
	else
		add_overlay("working")
		user.text2tab("[src] is now tracking, and visible to other GPS devices.")
		tracking = TRUE

/obj/item/device/gps/attack_self(mob/user)
	if(!tracking)
		user.text2tab("[src] is turned off. Use alt+click to toggle it back on.")
		return

	var/obj/item/device/gps/t = ""
	var/gps_window_height = 110 + GPS_list.len * 20 // Variable window height, depending on how many GPS units there are to show
	if(emped)
		t += "ERROR"
	else
		t += "<BR><A href='?src=\ref[src];tag=1'>Set Tag</A> "
		t += "<BR>Tag: [gpstag]"
		if(locked_location && locked_location.loc)
			t += "<BR>Bluespace coordinates saved: [locked_location.loc]"
			gps_window_height += 20

		for(var/obj/item/device/gps/G in GPS_list)
			var/turf/pos = get_turf(G)
			var/area/gps_area = get_area(G)
			var/tracked_gpstag = G.gpstag
			if(G.emped == 1)
				t += "<BR>[tracked_gpstag]: ERROR"
			else if(G.tracking)
				var/code
				if(intelligent)
					if(get_dist(get_turf(user), pos) <= 20)
						code = "\[Adjacent\]"
					else if (get_dist(get_turf(user), pos) <= 40)
						code = "\[Close-By\]"
					else
						code = "\[Away\]"
					code += " | " // so we have room.
				t += "<BR>[code][tracked_gpstag]: [format_text(gps_area.name)] ([pos.x], [pos.y], [pos.z])"
			else
				continue
	var/datum/browser/popup = new(user, "GPS", name, 360, min(gps_window_height, 800))
	popup.set_content(t)
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()

/obj/item/device/gps/Topic(href, href_list)
	..()
	if(href_list["tag"] )
		var/a = input("Please enter desired tag.", name, gpstag) as text
		a = uppertext(copytext(sanitize(a), 1, 5))
		if(in_range(src, usr))
			gpstag = a
			name = "global positioning system ([gpstag])"
			attack_self(usr)

/obj/item/device/gps/science
	icon_state = "gps-s"
	gpstag = "SCI0"

/obj/item/device/gps/engineering
	icon_state = "gps-e"
	gpstag = "ENG0"

/obj/item/device/gps/mining
	icon_state = "gps-m"
	gpstag = "MINE0"
	desc = "A positioning system helpful for rescuing trapped or injured miners, keeping one on you at all times while mining might just save your life."
	intelligent = TRUE

/obj/item/device/gps/cyborg
	icon_state = "gps-b"
	gpstag = "BORG0"
	desc = "A mining cyborg internal positioning system. Used as a recovery beacon for damaged cyborg assets, or a collaboration tool for mining teams."
	flags = NODROP

/obj/item/device/gps/internal
	icon_state = null
	flags = ABSTRACT
	gpstag = "Eerie Signal"
	desc = "Report to a coder immediately."
	invisibility = INVISIBILITY_MAXIMUM

/obj/item/device/gps/mining/internal
	icon_state = "gps-m"
	gpstag = "MINER"
	desc = "A positioning system helpful for rescuing trapped or injured miners, keeping one on you at all times while mining might just save your life."
