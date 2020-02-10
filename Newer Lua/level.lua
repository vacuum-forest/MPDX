Level.fog.active = true
Level.fog.color.r = 0
Level.fog.color.g = 0
Level.fog.color.b = 0
Level.fog.affects_landscapes = false
Level.fog.depth = 30

Level._conveyors = {}
Level._doorways = {}
Level._switches = {}

Level._doorways[0] = {
	["Reception"] = {
		["type"] = "solid single a",
		["facing"] = 180,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["placard"] = {
			["placement"] = "inside",
			["orientation"] = "left",
			["text"] = "G010 - Reception Office"
		}
	},
	["Building Management"] = {
		["type"] = "glass double b",
		["facing"] = 0,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["placard"] = {
			["placement"] = "outside",
			["orientation"] = "left",
			["text"] = "G011 - Building Management"
		}
	},
	["2F Landing"] = {
		["type"] = "glass double b",
		["facing"] = 180,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil
	},
	["2F Access"] = {
		["type"] = "solid single a",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Second Floor", ["start"] = "2F Access"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		}
	},
	["Main Entry"] = {
		["type"] = "glass double b",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil
	},
	["Peski N"] = {
		["type"] = "solid double b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor Interior", ["start"] = "Peski N"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		},
		["placard"] = {
			["placement"] = "outside",
			["orientation"] = "left",
			["text"] = "G022 - Peski Telemarketing Inc."
		}
	},
	["Peski S"] = {
		["type"] = "solid double b",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor Interior", ["start"] = "Peski S"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		},
		["placard"] = {
			["placement"] = "outside",
			["orientation"] = "left",
			["text"] = "G022 - Peski Telemarketing Inc."
		}
	},
	["Goo'd"] = {
		["type"] = "solid double b",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor Interior", ["start"] = "Goo'd"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		},
		["placard"] = {
			["placement"] = "outside",
			["orientation"] = "left",
			["text"] = "G023 - Goo'd Biochemical LLC"
		}
	},
	["Drowssap"] = {
		["type"] = "solid double b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor Interior", ["start"] = "Drowssap"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		},
		["placard"] = {
			["placement"] = "outside",
			["orientation"] = "left",
			["text"] = "G021 - Drowssap Security Consultants"
		}
	},
	["Mephisto N"] = {
		["type"] = "glass double b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["placard"] = {
			["placement"] = "outside",
			["orientation"] = "left",
			["text"] = "G012 - Mephisto Financial Solutions"
		}
	},
	["Mephisto S"] = {
		["type"] = "glass double b",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["placard"] = {
			["placement"] = "outside",
			["orientation"] = "left",
			["text"] = "G012 - Mephisto Financial Solutions"
		}
	},
	["Driveway"] = {
		["type"] = "solid single b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Basement Level 1", ["start"] = "Driveway"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		}
	},
	["Maintenance B1"] = {
		["type"] = "solid single b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Basement Level 1", ["start"] = "Maintenance B1"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		}
	},
	["Stairwell 1F"] = {
		["type"] = "solid single b",
		["facing"] = 180,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Stairwell", ["start"] = "Stairwell 1F"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		}
	},
	["Pawn"] = {
		["type"] = "glass double b",
		["facing"] = 180,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["placard"] = {
			["placement"] = "outside",
			["orientation"] = "left",
			["text"] = "G014 - Thrifty's Pawn & Surplus"
		}
	},
	["Pawn Office"] = {
		["type"] = "solid single a",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil
	},
	["Recycling"] = {
		["type"] = "glass double d",
		["facing"] = 180,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["placard"] = {
			["placement"] = "outside",
			["orientation"] = "left",
			["text"] = "G013 - Recycling Center"
		}
	},
	["Garage"] = {
		["type"] = "solid double a",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["placard"] = {
			["placement"] = "inside",
			["orientation"] = "left",
			["text"] = "G015 - Maintenance Garage"
		}
	},
	["Utility"] = {
		["type"] = "solid single a",
		["facing"] = 0,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["placard"] = {
			["placement"] = "inside",
			["orientation"] = "left",
			["text"] = "G015A - Maintenance Utility Closet 4F"
		}
	},
	["Janitor"] = {
		["type"] = "solid single a",
		["facing"] = 180,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["placard"] = {
			["placement"] = "inside",
			["orientation"] = "left",
			["text"] = "G016 - Auxiliary Broom Storage 17J"
		}
	}
}

Level._switches[0] = {
	["Main Entry"] = {
		["type"] = "lock",
		["target"] = "Main Entry",
		["enable"] = true,
		["keys"] = "Visitor Pass"
	},
	["2F Landing"] = {
		["type"] = "lock",
		["target"] = "2F Landing",
		["enable"] = true,
		["keys"] = "2F Landing"
	},
	["Reception"] = {
		["type"] = "lock",
		["target"] = "Reception",
		["enable"] = true,
		["keys"] = "Reception"
	},
	["Mephisto N"] = {
		["type"] = "lock",
		["target"] = "Mephisto N",
		["enable"] = true,
		["keys"] = "Mephisto"
	},
	["Mephisto S"] = {
		["type"] = "lock",
		["target"] = "Mephisto S",
		["enable"] = true,
		["keys"] = "Mephisto"
	},
	["Goo'd"] = {
		["type"] = "lock",
		["target"] = "Goo'd",
		["enable"] = true,
		["keys"] = "Goo'd"
	},
	["Peski N"] = {
		["type"] = "lock",
		["target"] = "Peski N",
		["enable"] = true,
		["keys"] = "Peski"
	},
	["Peski S"] = {
		["type"] = "lock",
		["target"] = "Peski S",
		["enable"] = true,
		["keys"] = "Peski"
	},
	["Drowssap"] = {
		["type"] = "lock",
		["target"] = "Drowssap",
		["enable"] = true,
		["keys"] = "Drowssap"
	}
}

Level._conveyors[1] = {
	["Goo'd"] = {
		["direction"] = 0,
		["speed"] = 8,
		["active"] = true
	}
}

Level._doorways[1] = {
	["Peski N"] = {
		["type"] = "solid double b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor", ["start"] = "Peski N"},
			["from"] = {["direction"] = "inside", ["offset"] = 0.5}
		}
	},
	["Peski S"] = {
		["type"] = "solid double b",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor", ["start"] = "Peski S"},
			["from"] = {["direction"] = "inside", ["offset"] = 0.5}
		}
	},
	["Goo'd"] = {
		["type"] = "solid double b",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor", ["start"] = "Goo'd"},
			["from"] = {["direction"] = "inside", ["offset"] = 0.5}
		}
	},
	["Goo'd B1"] = {
		["type"] = "solid double b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Basement Level 1", ["start"] = "Goo'd B1"},
			["from"] = {["direction"] = "inside", ["offset"] = 0.5}
		}
	},
	["Drowssap"] = {
		["type"] = "solid double b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor", ["start"] = "Drowssap"},
			["from"] = {["direction"] = "inside", ["offset"] = 0.5}
		}
	},
	["Drowssap B1"] = {
		["type"] = "solid single b",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Basement Level 1", ["start"] = "Drowssap B1"},
			["from"] = {["direction"] = "inside", ["offset"] = 0.5}
		}
	}
}

Level._doorways[2] = {
	["Goo'd B1"] = {
		["type"] = "solid double b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor Interior", ["start"] = "Goo'd B1"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		}
	},
	["Drowssap B1"] = {
		["type"] = "solid single b",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "outside",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor Interior", ["start"] = "Drowssap B1"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		}
	},
	["Stairwell B1"] = {
		["type"] = "solid single b",
		["facing"] = 0,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Stairwell", ["start"] = "Stairwell B1"},
			["from"] = {["direction"] = "outside", ["offset"] = 0.5}
		}
	},
	["Driveway"] = {
		["type"] = "solid single b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor", ["start"] = "Driveway"},
			["from"] = {["direction"] = "inside", ["offset"] = 0.5}
		}
	},
	["Maintenance B1"] = {
		["type"] = "solid single b",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil,
		["transit"] = {
			["to"] = {["level"] = "Ground Floor", ["start"] = "Maintenance B1"},
			["from"] = {["direction"] = "inside", ["offset"] = 0.5}
		}
	},
	["Maintenance Boss"] = {
		["type"] = "glass single a",
		["facing"] = 270,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil
	},
	["Maintenance Locker"] = {
		["type"] = "solid single a",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "inside",
		["keys"] = nil
	},
	["Maintenance Entrance"] = {
		["type"] = "solid double b",
		["facing"] = 90,
		["enable"] = true,
		["lock"] = "none",
		["keys"] = nil
	}
}

Level._switches[2] = {
	["Cargo Gate"] = {
		["type"] = "platform",
		["target"] = 176,
		["enable"] = true,
		["keys"] = nil,
		["platformExtendsFromFloor"] = true
	},
	["Maintenance Locker"] = {
		["type"] = "lock",
		["target"] = "Maintenance Locker",
		["enable"] = true,
		["keys"] = nil
	},
	["Goo'd B1"] = {
		["type"] = "lock",
		["target"] = "Goo'd B1",
		["enable"] = true,
		["keys"] = "Goo'd"
	},
	["Drowssap B1"] = {
		["type"] = "lock",
		["target"] = "Drowssap B1",
		["enable"] = true,
		["keys"] = "Drowssap"
	}
}


function initLevel()

	RoomTemplates["restroom"] = function(room)

		for k, polygon in ipairs(room) do

			if polygon.area == 0.03125 then
	
				doorway = {}
	
				doorway.id = nil
				doorway.type = "toilet"

				doorway.x = polygon.x
				doorway.y = polygon.y
				doorway.facing = 0
				doorway.polygon = polygon

				doorway.enable = true
				doorway.lock = "none"
				doorway.keys = nil
	
				installDoorway(doorway)
	
			end

		end

	end
	
end