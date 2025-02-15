--- STEAMODDED HEADER
--- MOD_NAME: Miser's Menagerie
--- MOD_ID: MisersMenagerie
--- MOD_AUTHOR: [Miser]
--- MOD_DESCRIPTION: This Mod is filled with a bunch of stupid stuff. I coded the "Aw Dangit" text and most of the new Jokers (with a lot of help from elbebeta of the balatro discord and my pal Something Funny), along with making art for both, and a friend Pupco made the art for Tiff-Taff, Oops All Blover and Pupperton Company.
----------------------------------------------
------------MOD CODE -------------------------
sendDebugMessage("no way is that a Miser's Menagerie reference vikram is my favorite troll yo page yo page yo page yo page my brain is melting help")

SMODS.Atlas{
    key = 'Tarot',
    path = 'Tarots.png',
    px = 71,
    py = 95,
}

SMODS.Atlas{
    key = 'Joker',
    path = 'Jokers.png',
    px = 71,
    py = 95,
}

SMODS.Atlas({
	key = "modicon",
	path = "ModIcon.png",
	px = 32,
	py = 32,
}):register()

SMODS.Atlas{
	key = "MisersMenagerieDecks",
	path = "MisersMenagerieDecks.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
  key = "MisersMenagerieJokers",
  path = "MisersMenagerieJokers.png",
  px = 71,
  py = 95
}

--thanks jen for this banger code
local etref = Card.set_eternal
function Card:set_eternal(e)
	if ((self.config or {}).center or {}).permaeternal then
		self.ability.eternal = true
	else
		etref(self, e)
	end
end

SMODS.Joker {
	key = 'vikram',
	loc_txt = {
		name = 'Vikram Aquasi',
		text = {
      			"This Joker gains {C:mult}+#2#{} Mult",
      			"For every {C:attention}3{} played.",
      			"{s:0.8}(not scored, take that hack fans){}",
		"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
      			"{s:0.5}Really likes space too...{}",
   		 }
	},
	config = { extra = { mult = 0, mult_mod = 3 } },
	rarity = 2,
	atlas = 'MisersMenagerieJokers',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
    		return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
  	end,
	calculate = function(self, card, context)
		if context.before then
			for k, _ in ipairs(context.full_hand) do
				if context.full_hand[k]:get_id() == 3 then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					context.full_hand[k]:juice_up(0.7)
					G.E_MANAGER:add_event(Event({
						func = function()
							card:juice_up(0.7)
							card_eval_status_text(card,'extra', nil, nil, nil, {message = localize("k_upgrade_ex"), colour = G.C.MULT, instant = true})
							play_sound('chips2')
						return true; end}))
					end
				end
			end
		if context.joker_main then
      		return {
			mult_mod = card.ability.extra.mult,
		        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
	      		}
   		end
	end
}

SMODS.Joker {
	key = 'page',
	loc_txt = {
		name = 'The Page of Space',
		text = {
      			"This Joker gains {X:mult,C:white} X#2# {} Mult",
      			"For every {C:attention}3{} played.",
      			"{s:0.8}(still not scored, hack fans in shambles){}",
		"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
      			"{s:1.5,C:green}The Page of Space has Awoken.{}",
   		 }
	},
	config = { extra = { x_mult = 1, Xmult_mod = 0.5 } },
	rarity = 4,
	atlas = 'MisersMenagerieJokers',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 3, y = 0 },
	cost = 20,
	loc_vars = function(self, info_queue, card)
    		return { vars = { card.ability.extra.x_mult, card.ability.extra.Xmult_mod } }
  	end,
	calculate = function(self, card, context)
		if context.before then
			for k, _ in ipairs(context.full_hand) do
				if context.full_hand[k]:get_id() == 3 then
					card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.Xmult_mod
					context.full_hand[k]:juice_up(0.7)
					G.E_MANAGER:add_event(Event({
						func = function()
							card:juice_up(0.7)
							card_eval_status_text(card,'extra', nil, nil, nil, {message = localize("k_upgrade_ex"), colour = G.C.MULT, instant = true})
							play_sound('chips2')
						return true; end}))
					end
				end
			end
		if context.joker_main then
      		return {
			Xmult_mod = card.ability.extra.x_mult,
		        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
	      		}
   		end
	end
}

SMODS.Joker {
	key = 'loswig',
	loc_txt = {
		name = 'Loswig',
		text = {
			"This Joker gains {C:chips}+#2#{} Chips",
			"if hand contains only {C:attention}Aces, 4s or 9s{}.",
		"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
			"For some reason too, {X:mult,C:white} X#3# {} Mult when",
			"an {C:attention}Ace of Spades{} is scored... {s:0.5}Why?{}",
		}
	},
	config = { extra = { chips = 0, chip_mod = 10, x_mult = 2} },
	rarity = 2,
	atlas = 'MisersMenagerieJokers',
	pos = { x = 4, y = 0 },
	soul_pos = { x = 5, y = 0},
	cost = 6,
	loc_vars = function(self, info_queue, card)
    		return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.x_mult } }
  	end,
	calculate = function(self, card, context)
		local check = true
		if context.individual and context.cardarea == G.play and context.other_card:is_suit('Spades') then
			if context.other_card:get_id() == 14 then
				return {
					x_mult = card.ability.extra.x_mult,
					colour = G.C.RED,
					card = card,
				}
			end
		end
		local check = true
		if context.cardarea == G.jokers and context.joker_main and not context.blueprint then
			if context.scoring_hand then
				for k, v in ipairs(context.full_hand) do
					if not
						(v:get_id() == 4
						or v:get_id() == 9
						or v:get_id() == 14)
					then
						check = false
						break
					end
				end
			end
			if check then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
				return {
					chip_mod = card.ability.extra.chips,
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_upgrade_ex"),
						colour = G.C.CHIPS,
					}),
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'circloopa',
	loc_txt = {
		name = 'Circloopa',
		text = {
			"{C:mult}+#1#{} Mult if hand",
			"contains only {C:attention}2s, 3s, 5s, 6s, 8s,{}",
			"{C:attention}9s, 10s, Jacks or Queens.{}",
			"{s:0.8}Why are all those numbers rou- Oh now I get it.{}",
		}
	},
	config = { extra = { mult = 8 } },
	rarity = 1,
	atlas = 'MisersMenagerieJokers',
	pos = { x = 6, y = 0 },
	soul_pos = { x = 7, y = 0 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
    		return { vars = { card.ability.extra.mult } }
  	end,
	calculate = function(self, card, context)
		local check = true
		if context.joker_main and not context.blueprint then
			for k, v in ipairs(context.full_hand) do
				if
					v:get_id() == 4
					or v:get_id() == 7
					or v:get_id() == 13
					or v:get_id() == 14
				then
					check = false
					break
				end
			end
			if check then
				return {
					mult_mod = card.ability.extra.mult,
					message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
					colour = G.C.RED,
					card = card,
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'painty',
	loc_txt = {
		name = 'Painty',
		text = {
			"+{C:money}$#1#{} every time",
			"you open a {C:attention}Booster pack{}.",
			"{s:0.7} The ol' coin on a string trick...",
		}
	},
	config = { extra = { money = 3 } },
	rarity = 2,
	atlas = 'MisersMenagerieJokers',
	pos = { x = 8, y = 0 },
	soul_pos = { x = 9, y = 0 },
	cost = 7,
	loc_vars = function(self, info_queue, card)
    		return { vars = { card.ability.extra.money } }
  	end,
	calculate = function(self, card, context)
		local check = true
		if context.open_booster then
			ease_dollars(card.ability.extra.money)
			return{
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = "$" .. card.ability.extra.money,
					colour = G.C.MONEY,
				}),
			}
		end
	end
}

SMODS.Joker {
	key = 'useless',
	loc_txt = {
		name = 'Extremely Specific and Pretty Much Completely Worthless Capsule Spell Machine',
		text = {
			"Does {C:attention}something extremely specific{}",
			"{C:attention}and pretty much completely worthless{}",
			" ",
			"{C:inactive}I can't think of a single situation where I'd need{}",
			"{C:inactive}to use something so pointless. That's amazing, father!{}",
		}
	},
	config = { extra = { } },
	rarity = 1,
	atlas = 'MisersMenagerieJokers',
	pos = { x = 0, y = 1},
	cost = 10,
}

SMODS.Back {
	key = "buildadeck",
	loc_txt = {
		name = "Build-A-Deck",
		text = {
			"Start with an empty Deck",
			"and {C:attention}13 Standard Tags{}",
		}
	},
	atlas = 'MisersMenagerieDecks',
	pos = {x = 0, y = 0},
	config = { standardspam = true },
	cards = { },
	apply = function() 
		G.E_MANAGER:add_event(Event({
			func = function()
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
				add_tag(Tag('tag_standard'))
			return true; end
		}))
		G.E_MANAGER:add_event(Event({
            		func = function()
                	local i = 1
                	while i <= #G.playing_cards do
                    		local v = G.playing_cards[i]
                    		if i >= 0 then
                        		v:remove()
                    		else
                        		i = i + 1
                    		end
                	end
                return true
            end
        }))
    end
}

SMODS.Consumable {
	key = 'wheelBUT',
	set = 'Tarot',
	loc_txt = {
		name = "Wheel of Fortune*",
		text = {
			"{C:green}#1# in #2#{} chance to add",
        		"{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
        	        "{C:dark_edition}Polychrome{} edition",
        	        "to a random {C:attention}Joker",
			"...",
			"{s:0.5}And a {C:green}#1# in #2#{} chance to{}",
			"{s:0.5}destroy a random joker.{}",
			"{s:0.5}This is why you read the fine print!{}",
		}
	},
	config = { extra = { odds = 4 } },
	atlas = 'Tarot',
	pos = { x = 6, y = 5 },
	permaeternal = true,
	cost = 3,
	hidden = true,
}

SMODS.Consumable {
	key = 'nothingness',
	loc_txt = {
		name = "...",
		text = {
			"Does nothing. Like... literally nothing.",
			"Yep. Nothing to be found here.",
			"You've found the most useless card in this mod.",
		}
	},
	config = { extra = { } },
	atlas = 'Tarot',
	pos = { x = 7, y = 5 },
	permaeternal = true,
	cost = 3,
	hidden = true,
}
	
----------------------------------------------
------------MOD CODE END----------------------
