-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 08, 2023 at 05:19 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gaming-site`
--

-- --------------------------------------------------------

--
-- Table structure for table `korisnik`
--

CREATE TABLE `korisnik` (
  `id` int(11) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `prezime` varchar(20) NOT NULL,
  `rola` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password_hash` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `korisnik`
--

INSERT INTO `korisnik` (`id`, `ime`, `prezime`, `rola`, `email`, `password_hash`) VALUES
(8, 'Aleksandar', 'Cvetkovic', 'user', 'slovnipo31@gmail.com', 'pbkdf2:sha256:260000$2wmwiwnOAXBuMrB0$477b1eb4c1a2a259f570eb8a2cb3fa1e693ee0d9a7bd7a9f1bc5e70326dcdfdd'),
(9, 'Nikola', 'Zivkovic', 'user', 'zile01@gmail.com', 'pbkdf2:sha256:260000$yzxJfbyNLf5pQJom$3c4d75c3589518aaf356c06d3618b74fa716cb752a9c22dbeea36ae8da8118ae');

-- --------------------------------------------------------

--
-- Table structure for table `produkti`
--

CREATE TABLE `produkti` (
  `id` int(11) NOT NULL,
  `ime` varchar(40) NOT NULL,
  `deskripcija` text NOT NULL,
  `cena` decimal(10,2) NOT NULL,
  `dostupnost` int(11) NOT NULL,
  `popularnost` int(11) NOT NULL,
  `popust` int(11) NOT NULL,
  `image_url` varchar(600) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produkti`
--

INSERT INTO `produkti` (`id`, `ime`, `deskripcija`, `cena`, `dostupnost`, `popularnost`, `popust`, `image_url`) VALUES
(1, 'Hogwarts Legacy', 'Hogwarts Legacy is an open-world action RPG set in the world first introduced in the Harry Potter books. Embark on a journey through familiar and new locations as you explore and discover magical beasts, customize your character and craft potions, master spell casting, upgrade talents and become the wizard you want to be.\r\n\r\nExperience Hogwarts in the 1800s. Your character is a student who holds the key to an ancient secret that threatens to tear the wizarding world apart. Make allies, battle Dark wizards, and ultimately decide the fate of the wizarding world. Your legacy is what you make of it. Live the Unwritten.', '53.49', 0, 1000, 0, 'static\\images\\harry potter.jpg'),
(2, 'Elden Ring', 'The Elden Ring has been destroyed and its shards have scattered throughout the lands, forming the Great Runes. Some of these shards have fallen into the hands of the children of Queen Marika the Eternal, and the promise of even more power has corrupted each of the six demi-gods.\r\n\r\nThe people who live on the land, used to enjoy the Grace of the Ring, given by the Erdtree, which showed with a kind of golden glow in the eyes – this glow has faded, indicating the loss of Grace, and those who remain are now called ‘the Tarnished.’ You are one of them, an exile from the Lands Between, because of the loss of Grace – and now it is your job to find the shards, restore the Ring and become Elden Lord, returning good to the land.\r\n\r\nThe Lands Between is a vast open world system so you can wander through the six regions (one per boss/ demi-god) in the Lands Between:\r\nexploring castles, fortresses, catacombs, caves, grassy plains, suffocating swamps, spiralling mountains and so much more.\r\n\r\nEach demi-god (being one of the Queen’s children) rules their section of the land, and eventually defeating them is the equivalent of a boss battle. All defeated enemies are transformed into spirits who can then be summoned to help you out when you need it. This summoning is also available in multiplayer mode – although in this case you call up other players to give you a hand!\r\n\r\nFor unexplained reasons, you have a spectral horse to ride as you wrest the shards from the demi-gods and hope to impress the Erdtree into restoring your Grace.', '60.00', 50, 60, 43, 'static\\images\\eldenring.jpg'),
(5, 'Farming Simulator 22', 'With Farming Simulator 22, various new gameplay mechanics are introduced: Seasonal cycles challenge you to plan ahead and adapt to changing weather conditions. New crops like grapes and olives require you to carefully work in narrow spaces with specialized machines, and various production chains allow you to build an agricultural empire.\r\n\r\nPlatinum Expansion included - get even more content!\r\n\r\nIncluded in the Platinum Edition, apart from the already massive base game, is the brand-new Platinum Expansion: Adding Silverrun Forest, a new map, inspired by the Pacific Northwest with its woody landscapes and new possibilities. Grab your tree markers to take on new forestry missions and even build a boat at the shipyard - as Silverrun Forest is rife with points of interest and production chains that develop based on your delivery of logs.\r\n\r\nEnjoy a large selection of new machines by the renowned Swedish manufacturer Volvo that celebrates its debut to the Farming Simulator series and extend your fleet by even more from John Deere, Komatsu, Pfanzelt, Koller, Schwarzmüller, IMPEX and many other brands. Over 40 authentic vehicles and tools are included in the expansion to enrich and grow your farming and forestry experience - whether you rise to the challenge of virtual farming alone or with friends in multiplayer.\r\n\r\nOver 100 real brands - new: Volvo and others!\r\nOver 500 authentic vehicles and tools\r\nIncludes base game and Platinum Expansion\r\n4 distinctive European and American environments\r\nLarge variety of crops, animals and trees\r\nSeasonal challenges, production chains, tree marking & more!\r\nCrossplay-Multiplayer allows for cooperative farming\r\nModHub offers free community-created content', '25.33', 35, 40, 0, 'static/images/farmingsimulator22.jpg'),
(7, 'Fire Emblem Engage', 'The Fell Dragon rises!\r\nSummon the Emblems and save the continent of Elyos in Fire Emblem Engage for Nintendo Switch.\r\n\r\nThis new instalment in the Fire Emblem series takes place in Elyos, a continent consisting of four realms surrounding a holy land at its centre. A thousand years ago, a vicious war broke out between people of Elyos and the Fell Dragon.\r\n\r\nDuring this war, the people of Elyos called upon Emblems – heroes from other worlds – to aid them. With the Emblems by their side, the warriors of each nation fought as one and, in the end, successfully imprisoned the Fell Dragon. However, signs are now appearing that the Fell Dragon may soon be resurrected…\r\n\r\nTake on the role of Alear, the Divine Dragon, who awakens a thousand years after the war with no memory of their past. Answer the call to arms and fight alongside your allies in tactical RPG battles to prevent the resurrection of the Fell Dragon.\r\n\r\nBolster your strength on the battlefield by summoning the Emblems – including Marth, Celica and other heroes from past Fire Emblem titles – who dwell within special Emblem Rings. By wearing these rings, Alear and their allies can borrow the power of these Emblems, boosting their stats or granting access to even stronger abilities. Heroes can also ‘engage’ with the Emblems, combining their strength and unlocking unique attacks to challenge the enemy with.\r\n\r\nA grand adventure begins! Meet various allies and enemies in each nation, discover the Emblems that dwell within the rings and deepen their bonds as you fight to protect the world.', '22.99', 50, 20, 0, 'static\\images\\fireemblemengage.jpg'),
(8, 'Football Manager 2023', 'Getting your European club to the biggest tournaments possible should be something memorable that makes you, as manager, feel special. And the developers have worked hard for this to be a feature of the game.\r\nWhen approaching all of the upgrades, enhancements and functionality relating to UEFA Club Competition licensed assets, the development team aimed to recreate the UEFA Club Competition look and feel. And they have captured the excitement generated by those big competitions and celebration of successful underdogs, sleeping giants and, of course, the best of the best.\r\nThe team has worked closely with UEFA – replicating the accuracy of FM22’s Bundesliga experience – so that pre-match line-ups and scoreboards look just like they do on TV, no matter whether you’re playing in the UEFA Champions League, UEFA Europa League, UEFA Europa Conference League or UEFA Super Cup.\r\nLikewise, graphics for goals, cards and substitutions have all been updated to incorporate the relevant UEFA Club Competition branding. And in matches themselves, you’ll notice a few other immersive touches that take you to the heart of the action.\r\nThese include distinct walkout cutscenes (and music) to kick off UEFA Club Competitions before the opening whistle as well as a bespoke camera angle. The attention to detail to try and make the games as special as possible even goes as far as having the branded official match balls for the competitions – a small but significant detail for purists to enjoy.\r\nAt the end of the season with all those big finals, each tournament will have unique podiums for the trophy presentations, while the authentic trophies have been beautifully rendered. Additionally, media interview and conference backgrounds have been updated to reflect UEFA’s array of partners.', '60.00', 50, 50, 39, 'static\\images\\footballmanager.jpg'),
(9, 'Frozen Flame', 'Frozen Flame is a Survival RPG set in the vast world of Arсana, an ancient land once governed by the Dragons. Addled by the curse, it now beckons for souls capable of harnessing the powers of the primeval magic. Those who seek to govern over these lands will have to amass power and allies to bring the fight to the Ice Citadel, home of the Faceless that spreads rot over the realm.\r\n\r\nTailored for those who love to explore, Frozen Flame offers so much more than just an open world full of beautiful vistas and ancient ruins riddled with monsters. With a fully-developed progression system, it’s up to you to choose your own path and endure the harsh world full of mystery, threatening enemies, and gigantic creatures guarding the secrets of this world.\r\n\r\nRecruit allies, build your keep, gear up with dozens of craftable options and get exploring in search of ancient artifacts left by the ancients. No journey is like any other in this realm: bound by magic, the shape of the world is unique for every playthrough, with islands, floating in the air, changing the layout in an unpredictable way. Spread the wings given to you by the power of Frozen Flame and explore the ever-changing landscape in search of ancient treasure.', '30.00', 50, 30, 57, 'static\\images\\frozenflame.jpg'),
(10, 'Mount & Blade II: Bannerlord', '\r\nThe game is a cheerful and immersive melding of sandbox action, role-playing, and strategy games, the whole adding up to an immersive and exciting experience as you build up your mighty dynasty from humble and lowly beginnings. You can play campaign mode as a single player, or you can take your army online and play against other online players.\r\n\r\nDialogue engines have been dramatically improved, and along with this comes more realistic and engaging interactions between players and NPCs (non playing characters), many of whom need to be persuaded into courses of action that they are initially unwilling to follow. There is a progress bar to indicate to the player how well their offers are going down: if this bar is not filled with charm alone, they can switch to bartering to get the NPC to go along with them.\r\n\r\nThe strategic part of the game comes into play early on, with the player needing to examine the terrain, look for weaknesses in the opposition’s defences.\r\n\r\nTo speed up gameplay and move the action along, only certain parts of the fortresses (merlons, gatehouses and siege engines) are destroyable, so weapons should be placed with care, aiming to destroy those parts belonging to the enemy, while protecting your own siege engines to keep the damage flowing.', '50.00', 50, 60, 50, 'static\\images\\mountandblade.jpg'),
(11, 'Persona 3 Portable', 'Shortly after transferring to Gekkoukan High School, the protagonist encounters the \"Dark Hour.\" Unfamiliar stillness swallows the city, people turn into eerie coffins, and otherworldly monsters called Shadows swarm. When they are attacked by one of these Shadows, and all hope seems lost, the power of the heart, their Persona is awakened.', '20.00', 35, 10, 15, 'static\\images\\persona3.jpg'),
(12, 'Rain World: Downpour', 'Rain World: Downpour is a DLC expansion of Rain World. Take control of five new characters with new abilities in this vast, redefined world. Slugcats have adapted to the harsh conditions alongside evolved predators! Survive new environmental conditions, dangers and explore uncharted territory.\r\n\r\nReturn to the unwavering wild in Downpour, where you explore new, harsh lands and survive new predators. As time passed, the slugcat has evolved. With five variants of the species - take advantage of various skills that they possess and explore their own personal tales.\r\n', '15.00', 50, 10, 50, 'static\\images\\rainworld.jpg'),
(13, 'Marvel’s Spider-Man: Miles Morales', 'The game picks up after the events of the movie, continuing Miles Morales adventures as he learns to juggle civilian life verse superheroing. It is not long before he discovers that his new home in Harlem is threatened by a battle between the tech giant, Roxxon Energy Co, and the latest villainous crew, the Underground, led by mysterious villain, The Tinkerer.\r\nAs Miles does his best, he keeps an eye on the city’s doings by using an app which tells him what crimes are ongoing as well as alerting him to news and side missions. Like Peter, Miles possesses a \"spider-sense\", which warns the player of incoming attacks and allows them to dodge and retaliate.\r\nHe also has, of course, web-shooters, which stream webs that can be used during both traversal and combat, in several different ways. Miles can also jump, stick to surfaces, and fast travel using the New York City subway system.\r\nIt’s not all web slinging and flying high over the city though. During certain sections of the game, players control Miles in his civilian persona and cannot use any of his abilities or gadgets. Miles does his best to help Spiderman, but his confidence is quite low after a couple of fairly high-level mistakes, so when Spidey lets him know that he, Spidey will be out of town for a bit, with MJ, Miles is convinced it’s all going to go wrong.', '50.00', 6, 90, 49, 'static\\images\\spiderman.jpg'),
(14, 'WRC Generations', '2022 will see the WRC transition to the hybrid era. This is a revolution for the rally world, significantly affecting performance, changing strategies and making drivers and teams adapt.\r\n\r\nIn terms of gameplay, new mechanics have been integrated to represent the demands of the hybrid engines. In order to win, you have to carefully manage your battery by adapting your engine mapping throughout the special stages you take part in.\r\n\r\nAs community satisfaction is always a priority , you can now share customised livery and stickers with other players. The best creations will be rewarded and highlighted.\r\n\r\nFor fans of competition, the new Leagues mode lets players challenge opponents with a similar level online. Finish ahead of your competitors to move up the ladder in the Legends category.\r\n\r\nWRC Generations includes more content than ever before in a rally game.\r\n750 km of unique special stages in 22 countries\r\n49 teams from the 2022 season (Rally1 / Rally2 / Junior WRC)\r\n37 legendary cars plus additional bonuses\r\n165 timed special stages\r\n\r\nIn order to make the representation of the championship even more realistic, a completely redesigned Rally Sweden environment has been added, with 6 brand-new special stages in the Umea region.', '50.00', 50, 40, 61, 'images\\static\\WRC.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `korisnik`
--
ALTER TABLE `korisnik`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produkti`
--
ALTER TABLE `produkti`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `korisnik`
--
ALTER TABLE `korisnik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `produkti`
--
ALTER TABLE `produkti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
