class Passcode
  def self.passcodes
    # `new` is needed to call instance methods inside a class method
    [new.foods, new.super_heroes].flatten
  end

  def foods
    [
      "americano",
      "applepie",
      "appleringo",
      "apricot",
      "banana",
      "brownie",
      "budougrape",
      "cafecreme",
      "cafelatte",
      "camachile",
      "capuccino",
      "carrotcake",
      "chardonnay",
      "cherimoya",
      "chiliconcarne",
      "chocolate",
      "cremebrulee",
      "dakumokachippu",
      "dragonfruit",
      "durian",
      "espresso",
      "frapuccino",
      "grape",
      "gratin",
      "hotcocoa",
      "mango",
      "mcflurry",
      "niku",
      "nikujaga",
      "potaufeu",
      "ramen",
      "ratatouille",
      "redvelvet",
      "redwine",
      "starfruit",
      "strawberry",
      "watermelon"
    ]
  end

  def super_heroes
    [
      "antman",
      "aquaman",
      "batman",
      "blackknight",
      "blackpanther",
      "blackwidow",
      "captainamerica",
      "daredevil",
      "deadpool",
      "doctorstrange",
      "eternals",
      "harleyquinn",
      "hawkeye",
      "ironfist",
      "ironman",
      "jessicajones",
      "luffy",
      "mightythor",
      "moonknight",
      "mrfreeze",
      "naruto",
      "penguin",
      "robin",
      "scarletwitch",
      "shangchi",
      "shazam",
      "spiderman",
      "superman",
      "techies",
      "thanos",
      "theflash",
      "thejoker",
      "theriddler",
      "ussop",
      "venom",
      "vision",
      "wolverine",
      "wonderwoman"
    ]
  end
end
