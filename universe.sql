-- ============================================================
-- Universe Database Schema & Seed Data
-- ============================================================

DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;

\connect universe

-- ============================================================
-- 1. TABLE DEFINITIONS
-- ============================================================

CREATE TABLE galaxy (
    galaxy_id           SERIAL PRIMARY KEY,
    name                VARCHAR(30) NOT NULL UNIQUE,
    description         TEXT,
    mass                INT,
    distance_from_earth INT,
    galaxy_type         VARCHAR(20),
    diameter            NUMERIC,
    has_supernovae      BOOLEAN,
    has_nebulae         BOOLEAN,
    age                 INT,
    black_holes_present BOOLEAN
);

CREATE TABLE star (
    star_id             SERIAL PRIMARY KEY,
    name                VARCHAR(30) NOT NULL UNIQUE,
    description         TEXT,
    type                VARCHAR(20),
    radius              INT,
    luminosity          NUMERIC,
    temperature         INT,
    age                 NUMERIC,
    has_planets         BOOLEAN,
    galaxy_id           INT NOT NULL REFERENCES galaxy(galaxy_id)
);

CREATE TABLE planet (
    planet_id           SERIAL PRIMARY KEY,
    name                VARCHAR(30) NOT NULL UNIQUE,
    description         TEXT,
    type                VARCHAR(20),
    radius              INT,
    orbital_period      NUMERIC,
    distance_from_star  INT,
    age                 NUMERIC,
    has_rings           BOOLEAN,
    star_id             INT NOT NULL REFERENCES star(star_id)
);

CREATE TABLE moon (
    moon_id             SERIAL PRIMARY KEY,
    name                VARCHAR(30) NOT NULL UNIQUE,
    description         TEXT,
    mass                INT,
    radius              INT,
    has_atmosphere      BOOLEAN,
    has_water           BOOLEAN,
    has_life            BOOLEAN,
    rotation_period     NUMERIC,
    planet_id           INT NOT NULL REFERENCES planet(planet_id)
);

CREATE TABLE satellite (
    satellite_id        SERIAL PRIMARY KEY,
    name                VARCHAR(30) NOT NULL UNIQUE,
    description         TEXT,
    type                VARCHAR(20),
    diameter            NUMERIC,
    orbit_distance      NUMERIC,
    orbital_period      NUMERIC,
    mass                NUMERIC,
    has_ring            BOOLEAN,
    planet_id           INT NOT NULL REFERENCES planet(planet_id)
);

-- ============================================================
-- 2. SEED DATA
-- ============================================================

INSERT INTO galaxy (
    name, description, mass, distance_from_earth, galaxy_type,
    diameter, has_supernovae, has_nebulae, age, black_holes_present
) VALUES
    ('Milky Way',   'The galaxy that contains our Solar System.',                        150, 0,    'Spiral',        10,    true,  true, 13700, true),
    ('Andromeda',   'The nearest spiral galaxy to the Milky Way.',                       300, 250,  'Spiral',        22,    true,  true, 1,     true),
    ('Triangulum',  'A member of the Local Group of galaxies.',                          50,  300,  'Spiral',        6,     false, true, 1,     true),
    ('Whirlpool',   'A classic spiral galaxy with a distinctive spiral structure.',      160, 2300, 'Spiral',        6,     true,  true, 500,   true),
    ('Sombrero',    'A spiral galaxy with a large central bulge in Virgo.',              80,  2900, 'Spiral',        5,     true,  true, 1000,  true),
    ('Cartwheel',   'A ring galaxy with a distinctive cartwheel shape.',                 100, 5,    'Ring',          15,    true,  true, 500,   true),
    ('Messier 87',  'A supergiant elliptical galaxy with a prominent jet.',              600, 5300, 'Elliptical',    24,    true,  true, 11000, true),
    ('Centaurus A', 'A lenticular galaxy with a massive black hole.',                    100, 1300, 'Lenticular',    6,     true,  true, 11000, true),
    ('NGC 1300',    'A barred spiral galaxy with a well-defined bar.',                   180, 6100, 'Barred Spiral', 11,    true,  true, 1,     true),
    ('NGC 4565',    'A spiral galaxy seen edge-on.',                                     200, 3150, 'Spiral',        10,    true,  true, 1,     true),
    ('NGC 4038',    'A peculiar galaxy undergoing a collision.',                         150, 6500, 'Peculiar',      75000, true,  true, 1,     true),
    ('NGC 5128',    'A galaxy with a prominent dust lane.',                              120, 1000, 'Lenticular',    6,     true,  true, 11000, true),
    ('NGC 4258',    'A spiral galaxy with unusual emission lines.',                      150, 2500, 'Spiral',        10,    true,  true, 1,     true),
    ('NGC 4631',    'A barred spiral galaxy with a distinctive whale-like shape.',       160, 2500, 'Barred Spiral', 10,    true,  true, 1,     true),
    ('NGC 4826',    'A spiral galaxy known as the Black Eye Galaxy.',                    150, 1700, 'Spiral',        10,    true,  true, 1,     true),
    ('NGC 5194',    'A spiral galaxy interacting with NGC 5195.',                        150, 2300, 'Spiral',        10,    true,  true, 1,     true),
    ('NGC 6946',    'A barred spiral galaxy with a high rate of star formation.',        160, 1800, 'Barred Spiral', 10,    true,  true, 1,     true),
    ('NGC 253',     'A spiral galaxy known as the Sculptor Galaxy.',                     150, 1100, 'Spiral',        10,    true,  true, 1,     true),
    ('NGC 300',     'A spiral galaxy in the constellation Sculptor.',                    150, 600,  'Spiral',        10,    true,  true, 1,     true),
    ('NGC 3628',    'A spiral galaxy in the constellation Leo.',                         150, 3500, 'Spiral',        10,    true,  true, 1,     true);

INSERT INTO star (
    name, description, type, radius, luminosity, temperature, age, has_planets, galaxy_id
) VALUES
    ('Sun',              'The star at the center of the Solar System.',                      'G-type', 6964,   1.0,   5778,  4.6,  true,  1),
    ('Proxima Centauri', 'The closest known star to the Sun.',                               'M-type', 69634,  0.17,  3042,  4.85, true,  1),
    ('Sirius A',         'The brightest star in the night sky.',                             'A-type', 11896,  25.4,  9940,  0.24, false, 1),
    ('Alpha Centauri A', 'Primary star in the closest star system to the Solar System.',     'G-type', 864340, 1.52,  5790,  4.85, true,  1),
    ('Alpha Centauri B', 'Secondary star in the closest star system to the Solar System.',   'K-type', 695510, 0.5,   5232,  4.85, true,  1),
    ('Barnards Star',    'A red dwarf star in the constellation Ophiuchus.',                 'M-type', 7,      0.35,  3134,  10.0, true,  2),
    ('Wolf 359',         'A red dwarf star in the constellation Leo.',                       'M-type', 620,    0.18,  28,    7.9,  true,  2),
    ('Luytens Star',     'A red dwarf star in the constellation Canis Minor.',               'M-type', 7,      0.35,  3134,  8.5,  true,  2),
    ('Tau Ceti',         'A star in the constellation Cetus.',                               'G-type', 793840, 0.52,  5344,  5.8,  true,  2),
    ('Epsilon Eridani',  'A star in the constellation Eridanus.',                            'K-type', 731520, 0.34,  5144,  0.85, true,  2),
    ('Vega',             'A star in the constellation Lyra.',                                'A-type', 12137,  40.12, 9602,  0.45, false, 6),
    ('Altair',           'A star in the constellation Aquila.',                              'A-type', 14960,  10.6,  7550,  1.2,  false, 6),
    ('Fomalhaut',        'A star in the constellation Piscis Austrinus.',                    'A-type', 14220,  16.6,  8590,  0.44, true,  6),
    ('Betelgeuse',       'A red supergiant star in the constellation Orion.',                'M-type', 12345,  1260,  35,    8.5,  false, 6),
    ('Rigel',            'A blue supergiant star in the constellation Orion.',               'B-type', 78730,  12,    12130, 8.5,  false, 6),
    ('Aldebaran',        'A red giant star in the constellation Taurus.',                    'K-type', 43870,  518,   3910,  6.5,  true,  7),
    ('Antares',          'A red supergiant star in the constellation Scorpius.',             'M-type', 883,    6,     35,    12.0, false, 7),
    ('Spica',            'A binary star system in the constellation Virgo.',                 'B-type', 740,    128,   226,   12.5, false, 7),
    ('Pollux',           'An orange giant star in the constellation Gemini.',                'K-type', 88780,  32.7,  4865,  1.12, true,  7),
    ('Arcturus',         'A red giant star in the constellation Boötes.',                    'K-type', 18347,  170,   4286,  7.1,  true,  7);

INSERT INTO planet (
    name, description, type, radius, orbital_period, distance_from_star, age, has_rings, star_id
) VALUES
    ('Earth',              'The third planet from the Sun.',                            'Terrestrial', 6371,  365.25,  14960, 4.5,  false, 1),
    ('Mars',               'The fourth planet from the Sun.',                           'Terrestrial', 3389,  687,     22790, 4.6,  false, 1),
    ('Jupiter',            'The largest planet in the Solar System.',                   'Gas Giant',   69911, 4332.59, 77850, 4.5,  true,  1),
    ('Saturn',             'The sixth planet from the Sun.',                            'Gas Giant',   58232, 10759,   1434,  4.5,  true,  1),
    ('Uranus',             'The seventh planet from the Sun.',                          'Ice Giant',   25362, 30687,   2871,  4.5,  true,  1),
    ('Neptune',            'The eighth planet from the Sun.',                           'Ice Giant',   24622, 60190,   4495,  4.5,  true,  1),
    ('Pluto',              'A dwarf planet in the Kuiper belt.',                        'Dwarf',       1188,  90560,   5906,  4.5,  false, 1),
    ('Proxima Centauri b', 'An exoplanet orbiting Proxima Centauri.',                   'Terrestrial', 7150,  11.186,  748,   4.85, false, 2),
    ('Alpha Centauri Bb',  'A hot exoplanet orbiting Alpha Centauri B.',                'Terrestrial', 48,    3.2,     610,   4.85, false, 2),
    ('Kepler-452b',        'An exoplanet orbiting Kepler-452.',                         'Super-Earth', 1,     385.84,  14960, 6.0,  false, 3),
    ('TRAPPIST-1d',        'An exoplanet orbiting TRAPPIST-1.',                         'Terrestrial', 6150,  4.05,    383,   7.6,  false, 3),
    ('Gliese 581g',        'A potentially habitable exoplanet.',                        'Super-Earth', 83,    36.6,    20,    7.5,  false, 4),
    ('HD 189733 b',        'A gas giant exoplanet known for its blue color.',           'Gas Giant',   618,   2.2,     48,    4.4,  true,  4),
    ('55 Cancri e',        'A super-Earth exoplanet with extreme temperatures.',        'Super-Earth', 76,    0.74,    41,    8.0,  false, 5),
    ('Tau Ceti e',         'A potentially habitable exoplanet orbiting Tau Ceti.',      'Super-Earth', 89,    168.1,   12,    5.8,  false, 5),
    ('Kepler-22b',         'An exoplanet in the habitable zone of Kepler-22.',          'Super-Earth', 89,    289.9,   60,    6.0,  false, 6),
    ('Wolf 1061c',         'An exoplanet orbiting Wolf 1061.',                          'Super-Earth', 93,    17.87,   1380,  4.5,  false, 6),
    ('Kapteyn b',          'An exoplanet orbiting Kapteyns Star.',                      'Super-Earth', 80,    48.62,   46,    11.5, false, 7),
    ('Ross 128 b',         'An exoplanet orbiting Ross 128.',                           'Terrestrial', 55,    9.87,    1120,  9.8,  false, 7),
    ('Luyten b',           'An exoplanet orbiting Luytens Star.',                       'Terrestrial', 54,    18.6,    12,    6.0,  false, 8),
    ('Teegarden b',        'An exoplanet orbiting Teegardens Star.',                    'Terrestrial', 51,    4.91,    12,    8.0,  false, 8);

INSERT INTO moon (
    name, description, mass, radius, has_atmosphere, has_water, has_life, rotation_period, planet_id
) VALUES
    ('Moon',      'The only natural satellite of Earth.',                                    7342,   1737, false, false, false, 27.3,   1),
    ('Phobos',    'The larger of Mars two moons.',                                           10660,  11,   false, false, false, 0.319,  2),
    ('Deimos',    'The smaller of Mars two moons.',                                          148,    6,    false, false, false, 1.26,   2),
    ('Europa',    'A moon of Jupiter with a possible subsurface ocean.',                     48,     1561, true,  true,  false, 3.55,   3),
    ('Io',        'The most volcanically active body in the Solar System.',                  893190, 1821, false, false, false, 1.77,   3),
    ('Ganymede',  'The largest moon of Jupiter and the Solar System.',                       14819,  2634, false, true,  false, 7.15,   3),
    ('Callisto',  'A heavily cratered moon of Jupiter.',                                     10759,  2410, false, false, false, 16.69,  3),
    ('Titan',     'The largest moon of Saturn, with a dense atmosphere.',                    13452,  2575, true,  true,  false, 15.94,  4),
    ('Enceladus', 'A moon of Saturn known for its geysers.',                                 1080,   252,  true,  true,  false, 1.37,   4),
    ('Mimas',     'The smallest and innermost of Saturns major moons.',                      37493,  198,  false, false, false, 0.94,   4),
    ('Dione',     'A moon of Saturn known for its icy surface.',                             11,     561,  false, false, false, 2.74,   4),
    ('Iapetus',   'A moon of Saturn with a distinctive two-tone coloration.',                1810,   735,  false, false, false, 79.33,  4),
    ('Rhea',      'The second largest moon of Saturn.',                                      23,     764,  false, false, false, 4.52,   4),
    ('Tethys',    'A mid-sized moon of Saturn with a large impact crater.',                  61730,  531,  false, false, false, 1.89,   4),
    ('Hyperion',  'A moon of Saturn known for its chaotic rotation.',                        56,     135,  false, false, false, 21.28,  4),
    ('Oberon',    'The second largest moon of Uranus.',                                      301,    761,  false, false, false, 13.46,  5),
    ('Titania',   'The largest moon of Uranus.',                                             340,    789,  false, false, false, 8.71,   5),
    ('Miranda',   'A moon of Uranus with extreme surface features.',                         66,     235,  false, false, false, 1.41,   5),
    ('Ariel',     'A moon of Uranus with a surface covered by valleys and canyons.',         13530,  578,  false, false, false, 2.52,   5),
    ('Umbriel',   'A dark moon of Uranus.',                                                  11720,  584,  false, false, false, 4.14,   5),
    ('Triton',    'The largest moon of Neptune.',                                            214080, 1353, true,  false, false, 5.88,   6),
    ('Nereid',    'The third-largest moon of Neptune.',                                      320,    340,  false, false, false, 360.13, 6),
    ('Proteus',   'A dark moon of Neptune.',                                                 44,     210,  false, false, false, 1.12,   6),
    ('Charon',    'The largest moon of Pluto, half the size of Pluto itself.',               15980,  606,  false, false, false, 6.39,   7);

INSERT INTO satellite (
    name, description, type, diameter, orbit_distance, orbital_period, mass, has_ring, planet_id
) VALUES
    ('Ceres',         'The largest object in the asteroid belt between Mars and Jupiter.', 'Asteroid',     940,    414000,     1680,  939000000000000000000,   false, 2),
    ('Halleys Comet', 'A short-period comet visible from Earth every 76 years.',           'Comet',        11,     1700000000, 75.3,  220000000000000,         true,  1),
    ('Phobos',        'The larger of Mars two moons.',                                     'Minor Moon',   22.4,   9376,       0.319, 10659000000000000,       false, 2),
    ('Deimos',        'The smaller of Mars two moons.',                                    'Minor Moon',   12.4,   23460,      1.26,  1471000000000000,        false, 2),
    ('Eris',          'A dwarf planet in the scattered disc.',                             'Dwarf Planet', 2390,   1670000000, 557,   16600000000000000000000, false, 6),
    ('Pluto',         'A dwarf planet in the Kuiper belt.',                                'Dwarf Planet', 1188,   590000000,  90,    13100000000000000000000, false, 6),
    ('Io',            'A moon of Jupiter, known for its volcanic activity.',               'Minor Moon',   1821.6, 421700,     1.77,  89300000000000000000000, false, 3),
    ('Titan',         'The largest moon of Saturn, with a dense atmosphere.',              'Minor Moon',   5150,   1222000,    15.94, 135000000000000000000000, true, 4);
