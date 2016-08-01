/*
* All clothing related stuff goes here.
*/

var/global/list/perseus_items = list(
									/obj/item/clothing/shoes/perc_combat,
									/obj/item/clothing/under/space/skinsuit,
									/obj/item/clothing/mask/chameleon/perseus,
									/obj/item/clothing/under/space/skinsuit,
									/obj/item/clothing/suit/armor/riot/riotvest,
									/obj/item/clothing/suit/armor/lightarmor,
									/obj/item/weapon/storage/backpack/blackpack,
									/obj/item/clothing/gloves/specops,
									/obj/item/clothing/suit/blackjacket,
									/obj/item/clothing/under/perseus_uniform,
									/obj/item/clothing/under/perseus_fatigues,
									/obj/item/weapon/shield/riot/perc,
									/obj/item/clothing/head/helmet/space/beret/perseus,
									/obj/item/clothing/head/helmet/space/pershelmet,
									/obj/item/clothing/suit/hooded/wintercoat/perseus,
									/obj/item/clothing/head/winterhood/perseus,
									/obj/item/weapon/gun/energy/ep90,
									/obj/item/projectile/bullet/fiveseven,
									/obj/item/weapon/stun_knife,
									/obj/item/device/tablet/perseus,
									/obj/item/device/tablet/laptop/perseus
									)
/*
* Combat Boots
*/

/obj/item/clothing/shoes/perc_combat
	name = "combat boots"
	icon_state = "swat"
	flags = NOSLIP
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 10, rad = 0)
	var/obj/item/weapon/stun_knife/knife
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT

	attack_hand(var/mob/living/M)
		if(knife)
			knife.loc = get_turf(src)
			if(M.put_in_active_hand(knife))
				M.text2tab("<div class='notice'>You slide the [knife] out of the [src].</div>")
				knife = 0
				update_icon()
			return
		..()

	attackby(var/obj/item/I, var/mob/living/M)
		if(istype(I, /obj/item/weapon/stun_knife))
			if(knife)	return
			M.drop_item()
			knife = I
			I.loc = src
			M.text2tab("<div class='notice'>You slide the [I] into the [src].</div>")
			update_icon()

	update_icon()
		if(knife)
			icon_state = "[initial(icon_state)][knife.mode == 1 ? "k" : "kl"]"
		else
			icon_state = initial(icon_state)

/*
* Skin Suit
*/

/obj/item/clothing/under/space/skinsuit
	name = "Perseus skin suit"
	icon_state = "pers_skinsuit"
	item_state = "syndicate-blue"
	item_color = "pers_skinsuit"
	desc = "Standard issue to Perseus Security personnel in space assignments. Maintains a safe internal atmosphere for the user."
	w_class = 3
	flags = STOPSPRESSUREDMAGE


/*
* Voice Mask
*/

/obj/item/clothing/mask/chameleon/var/locked = 0

/obj/item/clothing/mask/chameleon/perseus
	name = "perseus combat mask"
	desc = "A close-fitting mask that can filter some environmental toxins or be connected to an air supply."
	icon_state = "persmask"
	item_state = "gas_alt"
	locked = /obj/item/weapon/implant/enforcer
	flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR
	gas_transfer_coefficient = 0
	permeability_coefficient = 0
	flags_cover = MASKCOVERSEYES
	burn_state = FIRE_PROOF
	vchange = 1
	show_action = 0

	attack_self()
		return 0

/*
* Riot Vest
*/

/obj/item/clothing/suit/armor/riot/riotvest
	name = "perseus riot vest"
	desc = "A heavily reinforced vest with added plating to help protect the wearer's arms."
	icon_state = "perseus_vest"
	item_state = "perseus_vest"
	armor = list(melee = 82, bullet = 35, laser = 32, taser = 42, bomb = 15, bio = 0, rad = 0)

/*
* Light Armor
*/

/obj/item/clothing/suit/armor/lightarmor
	name = "perseus light armor"
	desc = "An armored vest that protects against some damage."
	icon_state = "persarmour"
	item_state = "persarmour"
	armor = list(melee = 50, bullet = 15, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/*
* BlackPack
*/

/obj/item/weapon/storage/backpack/blackpack
	name = "backpack"
	desc = "A darkened backpack."
	icon_state = "blackpack"

/*
* Gloves
*/

/obj/item/clothing/gloves/specops
	desc = "Made of a slightly more resilient material for longer durability."
	name = "PercTech Combat Gloves"
	icon_state = "persgloves"
	item_state = "persgloves"
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	cold_protection = HANDS
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/*
* Black Jacket
*/

/obj/item/clothing/suit/blackjacket
	name = "Black jacket"
	desc = "A black jacket."
	icon_state = "blackjacket"
	item_state = "blackjacket"

/*
* Perseus Uniform
*/

/obj/item/clothing/under/perseus_uniform
	name = "Perseus uniform"
	desc = "A very plain dark blue jumpsuit."
	icon_state = "pers_blue"
	item_state = "bl_suit"
	item_color = "pers_blue"


/*
* Commander Fatigues
*/

/obj/item/clothing/under/perseus_fatigues
	name = "Commander's Fatigues"
	desc = "Casual clothing for a commanding officer."
	icon_state = "persjumpsuit"
	item_state = "bl_suit"
	item_color = "persfatigues"


/*
* Riot Shield
*/

/obj/item/weapon/shield/riot/perc
	name = "PercTech Riot Shield"
	desc = "A PercTech shield adept at blocking blunt objects from connecting with the torso of the shield wielder."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "perc_shield"
	item_state = "p_riot"
	materials = list(MAT_METAL = 8500)

/*
* Perseus Beret
*/

/obj/item/clothing/head/helmet/space/beret/perseus
	name = "perseus commander beret"
	desc = "Only given to the elite of the Perseus elite."
	icon_state = "persberet"

/*
* Perseus Helmet
*/

/obj/item/clothing/head/helmet/space/pershelmet
	name = "perseus security helmet"
	desc = "Standard issue to Perseus' specialist enforcer team."
	icon_state = "pershelmet"
	flags_inv = HIDEEARS|HIDEHAIR
	armor = list(melee = 70, bullet = 55, laser = 45, taser = 10, bomb = 25, bio = 10, rad = 0)

/*
* Perseus Winter Coat
*/
/obj/item/clothing/suit/hooded/wintercoat/perseus
	name = "perseus winter coat"
	icon_state = "coatperc"
	hoodtype = /obj/item/clothing/head/winterhood/perseus

/obj/item/clothing/head/winterhood/perseus
	icon_state = "winterhood_perc"
