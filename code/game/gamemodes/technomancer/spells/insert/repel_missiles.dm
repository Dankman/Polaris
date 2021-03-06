/datum/technomancer/spell/repel_missiles
	name = "Repel Missiles"
	desc = "Places a repulsion field around you, which attempts to deflect incoming bullets and lasers, making them 30% less likely \
	to hit you.  The field lasts for five minutes and can be granted to yourself or an ally."
	spell_power_desc = "Projectiles will be more likely to be deflected."
	cost = 25
	obj_path = /obj/item/weapon/spell/insert/repel_missiles
	ability_icon_state = "tech_repelmissiles"
	category = SUPPORT_SPELLS

/obj/item/weapon/spell/insert/repel_missiles
	name = "repel missiles"
	desc = "Use it before they start shooting at you!"
	icon_state = "generic"
	cast_methods = CAST_RANGED
	aspect = ASPECT_FORCE
	light_color = "#FF5C5C"
	inserting = /obj/item/weapon/inserted_spell/repel_missiles

/obj/item/weapon/inserted_spell/repel_missiles
	var/evasion_increased = 2 // We store this here because spell power may change when the spell expires.

/obj/item/weapon/inserted_spell/repel_missiles/on_insert()
	spawn(1)
		if(isliving(host))
			var/mob/living/L = host
			evasion_increased = round(2 * spell_power_at_creation, 1)
			L.evasion += evasion_increased
			L << "<span class='notice'>You have a repulsion field around you, which will attempt to deflect projectiles.</span>"
			spawn(5 MINUTES)
				if(src)
					on_expire()

/obj/item/weapon/inserted_spell/repel_missiles/on_expire()
	if(isliving(host))
		var/mob/living/L = host
		L.evasion -= evasion_increased
		L << "<span class='warning'>Your repulsion field has expired.</span>"
		..()