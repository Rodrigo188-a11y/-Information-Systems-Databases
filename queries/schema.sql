------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Project schema-----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS authorised;
DROP TABLE IF EXISTS has;
DROP TABLE IF EXISTS valid_for;
DROP TABLE IF EXISTS sailing_certificate;
DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS boat;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS date_interval;
DROP TABLE IF EXISTS junior;
DROP TABLE IF EXISTS senior;
DROP TABLE IF EXISTS sailor;
DROP TABLE IF EXISTS boat_class;
DROP TABLE IF EXISTS country;


CREATE TABLE country(
    name_country VARCHAR (80),
    flag VARCHAR(2083), --URL
    iso_code VARCHAR(3) NOT NULL,
    CONSTRAINT pk_country
        PRIMARY KEY (name_country),
    CHECK ( length(flag)>11 ), --comprimento minimo URL
    --IC-5
    UNIQUE(iso_code)
);

CREATE TABLE boat_class(
    name_boatclass VARCHAR (20),
    max_length NUMERIC (5,2) NOT NULL, --Seawise Giant -largest boat ever built	458.45 m
    CONSTRAINT pk_boat_class
        PRIMARY KEY (name_boatclass)
);

CREATE TABLE sailor(
    first_name VARCHAR (80) NOT NULL,
    surname VARCHAR (80) NOT NULL,
    email VARCHAR (254),
    CONSTRAINT pk_sailor
        PRIMARY KEY (email),
    CHECK (length(email)>6)
    --No sailor can exist at the same time in the both table 'senior' and 'junior'
    --Every sailor must be a junior or a senior
);

CREATE TABLE senior(
    email VARCHAR(254),
    CONSTRAINT pk_senior
        PRIMARY KEY (email),
    CONSTRAINT fk_senior_sailor
        FOREIGN KEY (email)
            REFERENCES sailor(email)
    --Qualquer row nesta tabela não pode existir nenhuma igual na tabela na tabela junior
    --Qualquer row nesta tabela tem de exisir também na tabela sailor
);

CREATE TABLE junior(
     email VARCHAR(254),
    CONSTRAINT pk_junior
        PRIMARY KEY (email),
    CONSTRAINT fk_junior_sailor
        FOREIGN KEY (email)
            REFERENCES sailor(email)
    --Qualquer row nesta tabela não pode existir nenhuma igual na tabela na tabela senior
    --Qualquer row nesta tabela tem de exisir também na tabela sailor
);

CREATE TABLE location(
    name_loc VARCHAR (85) NOT NULL, --Biggest location name (85):Taumatawhakatangihangakoauauotamateaturipukakapikimaungahoronukupokaiwhenuakitanatahu in New Zeland :)
    country VARCHAR(80) NOT NULL,
    latitude NUMERIC (8,6),
    longitude NUMERIC (9,6),
    CONSTRAINT pk_location
        PRIMARY KEY (latitude, longitude),   --https://www.rd.com/article/longest-place-name/
    CONSTRAINT fk_location_country
        FOREIGN KEY (country)
            REFERENCES country(name_country)
    --IC-1 Every country where boats are registered must have at least one location.
    --IC-2 Any two locations must be at least one nautical mile apart.
);

CREATE TABLE date_interval(
    start_date DATE,
    end_date DATE,
    CONSTRAINT pk_date_interval
        PRIMARY KEY (start_date, end_date)
    --IC-4 A boat can not take off on a trip before the reservation start date.
);

CREATE TABLE boat(
    cni VARCHAR(20),
    name_boat VARCHAR (10) NOT NULL,
    length NUMERIC (5,2) NOT NULL,
    year SMALLINT NOT NULL,
    name_country VARCHAR(80),
    has_name_boatclass VARCHAR(20),
    CONSTRAINT pk_boat
        PRIMARY KEY (name_country, cni),
    CONSTRAINT fk_boat_country
        FOREIGN KEY (name_country)
            REFERENCES country(name_country),
    CONSTRAINT fk_has_boatclass
        FOREIGN KEY (has_name_boatclass)
            REFERENCES boat_class(name_boatclass)
    --IC-1 Every country where boats are registered must have at least one location.
    --IC-3  The skipper must be an authorized sailor of the corresponding reservation.
);

CREATE TABLE reservation(
    cni VARCHAR(20),
    name_country VARCHAR(80),
    start_date DATE,
    end_date DATE,
    responsible_senior VARCHAR(254) NOT NULL,
    CONSTRAINT pk_reservation
        PRIMARY KEY (name_country, cni, start_date, end_date),
    CONSTRAINT fk_reservation_boat
        FOREIGN KEY (name_country, cni)
            REFERENCES boat(name_country, cni),
    CONSTRAINT fk_reservation_date_interval
        FOREIGN KEY (start_date, end_date)
            REFERENCES date_interval(start_date, end_date),
    CONSTRAINT fk_reservation_senior
        FOREIGN KEY (responsible_senior)
            REFERENCES senior(email)
    --IC-2, IC-6?  Any two locations must be at least one nautical mile apart.
    --IC-3 The skipper must be an authorized sailor of the corresponding reservation.
    --Every reservation must be in the authorised table
);

CREATE TABLE trip(
    start_date DATE,
    end_date DATE,
    cni VARCHAR(20),
    name_country VARCHAR(80),
    take_off DATE,
    arrival DATE NOT NULL,
    insurance VARCHAR (16) NOT NULL,  --data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAO4AAADTCAMAAACx1N9jAAACfFBMVEX5+fkAhT/////8QkIAfzL//f6lxq/39/fc599AlV8Agjmsyrb+OTn/MzPo6enOxMTLysrbmprZoaHf5OQAAAD///ru//8AfzX6//////f//PtThy8AgTLGw4cAhUUAj0cAhU9iur7//uvn+f/K7fz/9+rt8u9MjEsAi0cAezi1tbWIrMmsimClw9wck3Vxmkfy4LSFmjxcklax4Obv3r5xlDiJzdXUz5g/ra7Jq4f5SEihf1YAfCn06MRxwMk/jD+T1eT/99YAj3vA1sc6VX8GAB6RZ0fW7/YuQHXlf3/cv54FBRVyX0zE3PCcqVwAeSKl2NmT1p1xs4j67dU3dSgFFE54UiLgiYkVID3Ho3qbvtmstXXT4MJ8tJVRm3bV8ucAgWE7nodPmmYAiHNhhj8ei2CkrWHUsbHpZ2fl2czYuZRdRy9rkLWokoerh3eAcnpUYX11iaZtc5SMw7WOq21qs6C3yqD/8c2v4/SLqGcakIe7yafB4ePV38uavJqZs392u6w2mW623dR9rHtorpF8vbdfpp/P1KmnxJqttoZil4WHqn65uXNDhWrLw4NFnIBqlXI7qE+dy6MPqjNHp1x7uYlesXY8gEF1nFkRdUQmbQ9UIwAaAByWazNEeKFXKiM0GCoeHx2Mp7q9r5lRQj9FTlwcS2WGalUpBgAjOl9JP0VQX2lfNx5KT207JRAXADAOSH46M0oSJVk3AACIWiaQiItHAAAoM0UAADvuW1sZEQALJ0JkZF8AAC1PPSpuSC4CDQxqeZxIRn0yLy2DipOpoIyXe3lxUWNOU3R/jJROP0pKKkiQjqJlLTyll3qTbmhlR0iqo7ZxQThmbmgGg4znAAAfoElEQVR4nO2djUMTV7rwJ8eMCYMNaUPIJIbckGHCJRBqIeWjBqIGyW1kgHW62/ItdCkdDAi1dhUIVpRSV7d2e7tb9n13aQEpFVvvdvfyunWtH6/grq3X1td/6H3OmXwAghEMxKU8AnPmfP/mPOfjOWcSKcVPSqhEV2B9ZRN3I8sm7kaWTdyNLFFcRhm9ht1YzEzUzcxzLxSlUvlwmNkQTfkEdYyjRHCZvOTt5Nqy1cO0eEfC/tbDb0eqyrT1pxsUSwiTfcSbfGYxkuXwO+HYlprhJROut0RwzRnoRXw1FNq2KzNQfajuTF5alJDJ44qWqjVjzUQgv1Iu9LZk7gYfixxhh3KJhOsuS+IqzNXhlnosXHMZqq82nHp7cfNWKxWMJRPSP+W4pEmIyLgMY7EoDDKuxUKoGOwI8bmP/soN3ZeJeEN0TAeJFG1cOlwA1x1KmFBZgAvjjdmNlbkYPR/yJrhMXj9CxtNKwB0uQGjYw1j704dYxB+TAdxHbR7c6swBX30hQqWfQCSXR6E4usPdi7UcpVszS2sgwJMAwgUyHzfoxeKzbTcX6+fjKtsyjX2N/ahemcfx2JFuUO4yBgcOp9nk+puLEX8cWh+4+eBADeIbIFKRUgEa3HaYHW4c8FgzSUDCNXo+ronCgh7CNbew6W5zm2+HG5TZbf5DZqnSXGbzKKszUJUcS3mEQ8Z3lAr3rt3VSlDtarPh6G43tK7BfCDtrNKA+261Obtgd6Kbd4EyV7vd1dWFD7duL1vFKIDSTYYqw1EZV2FuQVWh7mjOboL2NACuW2HGf5S7ZFxID4O8PFQpC8XtCUCcL0sOVQ/j1i+Fy0RxoYHdu/Tbo7iGJXAN/zK4VQzzKFw8RLshgyVxIxPRU49rYQCiXtnCFrkBdcdyuExTltltPWpbqnXbuB3VCkUU12xO5HT0SFxlBu9lRZh2CmDU5ozHDAQ3ezEuc4DTQzgM2ItwM3fAaF2Igv2lFhkX5rgj6uMJ5I3gKjOMBJch8y5PcJkjPio4grveYbsqOAJN5QPNzK4B3AwRcPfY5ZGZOTEI4W8rFebCX+E/uzFaqVJRsAPrcY2dP27BTkOZ6MnepR9ZsiLrI1GLyOwOXZVRt9LtJjMlYwYHNArjxqsJ7IdjwW0oLQ53M6HEJJy4SGwcxshOszLRq8l1tndh5Epk4667eW9tTejCed13MxJrJvxkN29+ErKJu5FlE3cjyybuRpZN3I0sm7gbWTZxN7Js4m5kie5Ewu+iXaTlz+oVjFkZjWyAhGbDvJP66F47PtNn8C6X+fGqwyjdkGRBPZZOaV548Prwbu7SdQ/jMoVVjNXrYaCq8i8+qx8wkJpjt+wrO8hRf3JDluw0WweyP8oefOejcGKm5RgTIn7X6z1ubhs8zlgOy36MnAWJFipKEQnArw4k9weTP2wwh6MyjBkqxijmFS1HHerzhNPDX+VQvXJeRuCwDjDRzB/GNeyqUlqbX7E2nlSeOHXScuqkGe8rGc41AtSJLOaEh4RkWfZbmxqzGOvgiLtl2H2iMSu7qXHIlt/6ni2/SYmjtDWezK4ZdudBOoWyeNhsKazPELMU2TVVJ5oaPcy5xnzI9UTWicYRiG0AvyychIEbmbc6I736dRsEQdQs68lTJ6t3VbVBWJNHccKDc23ywC3TYj8GScxQVWA+1+gpGw5lpDh3xgO1zre0WlshEEBOMkviDjc2Bj8ZPDNUX+hqrTk+dJph9jS8N3zufYO5uCh7MH/wTE194dkD6ib7mSwIwfq2p6HJm+U7fSSY1PxrW1LzK/1nBvOD+TVvFKbnBZsGtwPjCwrznobiUg84jxUOH2k419A0cK6huiy9YLjJexIyBD/r4JnkfChQfj3CXJaufD3teM0bGekt4uvGkwVVu44PjiiUZWetXkg9mN//Ym+pkslTjwweH0rPKG1llC0Np94vLIVa4CpmvHOkoaWh6f0DwRYeEmecHhKVS+LWtzYFe22NQzvKzh5oPnN4txKgzqn7shimzdvU1zJcvacBcINNQTfoHOAy1fBIC+qbf/l6Q3bzb3ZnN/eWus2Wd/v6P8g4m+FqLEhnLAUvKiATqB7BrW9TNw325bdg3Jqq7HeT+9Px8zvV4HbvUQ8MlZojuGJ1RhF0F9tvdldnfFBIncXvDTT0FpW94c44jXENjLX5w4bqvIahdIPCUFivdJed/UPzu8PVLcHB5w01Z6AUwC2tLjvd7DkQXBq3ymBt/k1D0rmThfUHgvlNZwxQ02rLkeB2hWHIWw+VbBnGtTsX9ECvDnqU1oGyoqRT+VFcqJy7t9Rc9kHGGxkQMqIwlJ1VuouL5uFuV5xrbpRx9zR4MjBu8FSw2r0HF0hedgjjQow/NBPcXVBn0PIab1XZ2WrA3Y5x26K4ysJ0d3XZ2bbmI4DbMPh89uDzlnPNHwbxY60f3H4gaF4K9ygMVc2v1PQNHis8mz3UN0iU+dcNhxvI4cjz1kEIKW44zGNchfK9YOPg23nercGs5l8eUJ8kuK/UvDP4YbCx/4Pi0jbvgHc7PJXBvsNBD8a11FRh3A/Bv7V/wAcwed6B/iL8/LJq+rwjh/sG63EXBdwi5es2aN2yvsO4dcs+2FVVXGRQmIt3V+cFtwY9hX01+KCteTtOkoFPF1uCW/sK09vU+aEqDud5G72/CbaI1YVni/tqxKVwFVb4TWIsrTAOweiXlARFW5IUSa34iUNXJSHgnQSeeEhJglvG2upRJIE7C/uSxMq2VovHkmTGIRDL0trKKEgKKy4gCZJ5IFUS3MDFYrGGy7RAgVaSs9UCCRirB3ytxGElGZh7iwy4PIidZJGrmgRVld9ialVEMoISoJq4Xjix4lQ+fthL4EZmHPlu3pVpSx4JR4gM66GJIzxDRN1MNLvoJVJGOFk0JhPOWbFIGEUkAp75+jyhSPNLfrgukcxkvyPJyVnzM32cVRWT6BdIVl8HRrkw3U91ERlSg6egIddSon2X2c/AImRg5Kl4VXOtJDoyD+12W2qOtxXUG5RmAwNDPzEDzEu8t/svLBET4QhM/73DSqZtJM/rPd2brhw6NuRt8BQG399IvFED8HVYwsB8zsBqPrvmpNcy+OuG6uKiwvoNpdzRvgu4sHyBebrgRbzkGxjutSUnH6+p30iNOx/X5ga7zlJTX5YOS7Ree1VeEJaogLuReKO4be/DUvRw8nGl5XDyCGPdCsZp8vuGIyPMkYS+PBJfmffRCwNZhDB4yyX8AQwGv7W7IVv3pyGbuBtZNnE3smzibmTZxN3IEjEAlRtaFuEy+7duZElmFuIqkxG9gQU9hEtTG1g2cRNdpbWUTdxEV2ktZRM30VVaS9nEXRRDpYIf+PN4AlP5SopfYfQnlpi4qo9+RkQd9V+mjtiXbmg8zJlilgo5kEgmiI4f5Loxx8CladVvf/cRyG//MxxA8wONh30LK4jv6OEhik4/kDz4ztCi2j8Ew/c1NvbDVV+fl4yvxj5fPJkeITFwvT9L/liNEKJ//7MQLz2seNd73FIzPxY9XACNFeyn0Au7EB3sX1gE7apZCCx6WpL7PO+xFJ9fQL7Fgc8qiK0RcZFH46o+/h3gQuOqP/7dx/+pxl68pxDRaHiIpUwqOyiiijLZqapCux079S8Ugh/40na7CghUdjtkV5+hglCT7AVtWlUMZojoqTHx+TU4C4ILV+Km5VzlX5I5FcrLhMsg+dAkmn0VXSAWrkb1sXqgsdG+tbHxt15cTGkbVjzop/rTHsWJfnr4yPGWevz+D0ov1j/PKMxlHxTT+tMKBsLELIVliC1SKphe1nhcoThHdFZuS/0bGTxEZwpNxAelDx03Wwto07CHyfMZf3nUhF4oROlH3i5GpxmmrZ8ubXnHYxhClDjCWI5wtCtLYYW7eOOqVf+m3oo770f234dwORJE78jzofpitjSPo4kO0+nFxIHOZqAdB3xouMak1yH+laOovgxCi3pZ9EYxHcWtL0bGqDLTRZBd0R5OtBYgO2UjuLvoHXsg3M6i9F4kVh9Fpe6jJlANfsDHP78LlVoy4437e7Xq39WN+7GoB7yYsvRACDe9124/RnAp4wu7TFQI10QDbnoxomDsxRq3HePSlKm+2M4/n7EAl4a+awq1Nz3cwlFim0+0FMDQFsWliPYW9SLbK5nYS//iUciXFj8psA9bVz7AxcZNavy3sOxfgHvupOKIj14WF49RWZYTnqPoDYJ7bsTyHkfFwkXDn5wYUs3HNR63WFplXNMLu4wYl6J2f9KoaCtYeeeNiWtvTIrg/h68oO/i8lRAByO2ieDqH8bFeq9/sRChF6F1MzBuBo5O4LbXYNyqjKVwQSmC2wuNUVx6xwEO7ViISwOuD6aLFdPGwk1SU8kRWjMOA42kkAkqV5THIamfKDN6IwOp5uMWvc4ivt+4fRfiQZmh56nYdOi7Yj+mM9X3cjTtshSYlsA12Wmc2wtlCEZ5GRfyKorg6iHEFOT47QXI6OXij0s3Kf49JBY8EcBwe2J/a1sNzY+c2J81xLpAuelSy/4m3wdh3GIS5ilD6db9p46VQYqm1qOQ7KS1UKY7lrQf3BQVwfUA7h6Cy+c3nYRxeFjRdAoG5R2vQ+AvT5zc+gef7X8B7ou7oCgcwQRZ57esAa49QqtolNcZ+qDXixeKcIXFFe/F0yzv9VFqssww4eUGZYIwROGvUOFhPOG9ahUtRydiUkMOdBQXmovi1RTJiyeZ02qvj++neLLm8vajIEfaMujDRZEIkrd/McuT457QNCosYQkvm8NrZvkScsu5Ydx5YeH1Iz3Pa15wGDeyzKQXpzSFnPS8pWg4wmoWYjEWkSeaLNlhaYqdm+lY5koqwZ9cr7VyWGLgquftSNsfI7vHtRNDYl9h/CeWmBbRPHmM7FY4N6z7VkKMvqt+uuVxFG4FuHZr0lMt3pWqRwxlRk+3rLgzbG7NJbpKaymbuImu0lrKJm6iq7SWsom7MEKMxSNNJWApuHqJgavSgqhCVo5GR0m6hck1WhXEWbzQXxzr6ZEYuOL/Tk1N7eZIC6KSP6d1Ok0R4xN71abWIdcfBVPYJCV/0J9GUcQUpp+qxo+F+2mdZuIzJ7JrdYBbnqbT0XpJq+GhQfEvKhkr51yfCeDWa3W8VqPleK0O/SkgafEWBziNWs1DjZ9AiYk7rp34THCdf3C+hy0pN17PMXZNVn6u/dSJass5wP18Ksf1Wab/55z4RZ1/34PKyUOVF7idkw+udbOu6QfTzt1fXDy03jb8IyQGLv/lldS9PfqKUQRt2FFurMjBbemw544COQLcC9JXEuD+hRMv1fn/K9O1TxBThZ3lyJUq/GlUt/PPu/9at/KjjbWTx1BmDcsDmvipk+D6L/hohFxfSV/7TBg3LffO12Hcn3PQj8UvABTt/qvzvydnZnrguk6He48lMXGd0DjGilHW/1/R1p0RbJXnb7J49LrAide+zfT/LdM1D3fnhTRo3Z2jSBJ2fyH8K+H+H9I4UuX05DiMzKDB+onpW90CKtmLA1DtBQ7l7hXEg5cfpNb5/+YDSlDmP01eHethxYPTl+t2p/4rtS6lUcmi0VDwi39UGp1KxYJOE29w23V2uNo1GjvckB+NBvtDAE6kWrWsOy6uM1T9IVFPjY0/7BtXgUemiT/xo3Bxm+q0Ke3PPSzPLuEXZ2lPwcxxBn4ELmiorv3lb7Zs2ZYQ2bLlm5fb4w28LC7ul+1v4lITJ9u2vQnA8VTp5XCBVvsqgd227ZmESKjwV3XxbN9lcTXaN7eR5/tqe3tKAqS9/dVvMPG2N7Vx5F0GN0z7ZopWHiTXX3Q6bbtchzi279K40G9fxrr0nE73BPPmkwpMC89i3jjq8zK4uvZngDbO48RKhYyWwPtMu25NcUGV8fzzXFxHidUI8D6HZ6S4VWRpXN1zz2zZ9nLCaQkv9N/4Ne+SuFDGli0vpSSeFvOmbMOjVZwOvpfCBV3eMq9xw+Y5WmCnh+7Q4pCwPxa40mhxZCr0ehUdOb8j96H44B2+Iw65ebfEazJaGhcGKui5cgm8Q8C10EsOBxfBQpJDi6+Sw0dR+hQHF/V36BD2B9GyJhzBRJlSHCzJSYd3sFIcAsSA/LRsqACfSU4gkLwERJM7Ui7uWFib1xJXh8f/kC6jktQcqJ1YOZZ643JkI4a/fuM1spuBzVljxd9C21F85diNG/tyEMrdB44xMIZ3po4iyviLv6QBSe4+iOy6lpq6L8DyU6mpN/AWJ6TeV2dCtTdSU6Eg7A3pd8LN2JVR/DhkbX4uTp13adxXI/rD3xsbA1z++r6Ljs6x10JbE7Tr0uQlsle1l+D+XMY1Vox1O+bG9jlR7tgdh+PaWADtvHVZMBl/8R9pND81dtlpMla85uSn/i64Pg2gXJwY+cfGsDc8Gsivdm+d7cs/czRN6yvkwqBnAe6za4oLa4yXCK5x596rgIv8qTdZhEomQ1sTqPZb7UGyEzkfl3ZdKYdYHZOAu09AyAUtu3NsbJTFuMZfvHb1NYgs3edQybdO6Jr63G/hXrw2PeZE/MFu6Cu07frnaXIfRv4rOUSVZNxX1xxXp4FgfafTD8ol1yw8yECbHyxP2/mtYFqIizfZQ+NM7ti4w3EQHtTOy537nBjXdFsgkWHs4iv+Dg3Hf7kXgPQ7yyf+6ESuS2OpqRd84rWLU6nd+B1T2/UL8niwrrhQdYxr7PqWaBYdGjNdXwSQ/4sAG8WlsXcYlwLcKzduXMF99zXdl+Us4EJCeX8LNCY1AL2Sn6v8u4D8f3T690LrwgDlvxQQr411z13CahNu3HXD1WrkCHLrkpryWhVfcQM0NnffHcfctQu+MO5ffLZPx64ESgguxJL7roM1AW6mf1/dfwNuSPMxLR6iEI3EL0dt1+G5AS7cYpWRcJ65ewWTHp6gaZ1xVRFc1JF6k7Reju16amo5f3AMD50wJPm/gECseLZPb6QG/KTvlqQG5L4LzYNxjRWXD0Zx9blAa6I0Dh8tflke/OtY6r5b0MchMuDy1z+Hnr3PCUGjoQquB+6ri3BhZIYxt3Psgo8oM+gx1uhLo6zr0uU7jqmxcpb423Cse2PfZmJc0jgYF1T/VgQXssNp4fmN4mx40IGusTtCRyrpHdCydaRruC4F2Pm4azsyz593/XjeReLBGzduvOYk/clYIav29Z/79PeuYP/w1jmJtbcOhqrUMO63mSaUe4Pg1oI68L8YuwKa4TTuJEeLNCEH7wq4Ledo/jqZd+VCQ7hrPu9qsIUQXpZLDlJzWO44Qh93gybBQbCCEsgyyhH9GFxo7UWT1RaIScILLt5xnw3lxJP1EmiySSKrrnABOCG+1ctrrlCh1Lqsqoj+vCwPzaElLRmSw4no8OJX/jt/Z5oOr3zD+S9YM5vC7+FFY4YLCGdPR6MSWrJm3raWa+an0iKKT3bL2LvPPj32LswSz8Sr6y67m/HSFtx7E827PrsZ8nYGDM4/jb2qyE4kObRI4E4kadt49qrl95m/ISWl6BK3z6xLWad95vmnCM+2p2gTICntz765bqcI5IyI6POWBB0RPfOMXPrLcR0/lj/wxOPEN4k+AfxmnU4AqfD57ksJOt6FB/3Sy+26OM+FMU7v8blU+3PPJkCea2/X6uL+vkLMdzM0S72bEd+3MMjgP++ljOi7GaQSpsVb3GuGi9+2eWjiXW4qXt0MbZ+YFShpZlylknRUik8FTrtK8kkzTorvvAP2tSTQ/Nz9lX92dTW4YJnf6sG2O83PCCayNYdKAmSHn1g0CJsuxIH85SwyLVfM8uX7nbZD6rusvw45uJQfBOMM589BDqkHlThLBPEmK92rQ12Ztrvxad9YuP+X5SudxrlZwX+rRwUNAUCSk++cFfQTM+OsNK7vFPi5WR+SZue6wb1iXtQp6Dt98LBybPd5XZcg9rBij/E+3gNy3uaMh1htR53+H2nwsz64aag2x99zr1w67/R3z02CdtUGakfnbkrTjh+Fjpv6Cmdt91w5/934VDmbsvJ3W/VdgCsgfsYnOREK4YpORPF3034A3DTUUYcmBOk/1g03N0eaufqV5qov9/L0JGh0bcB19cG4vuvirK/jJqoQKian/xnsZl3dq1Jm0ro8EMOzwrh3WVeO5IO+40OkdTGuPUX91jopMyedFyoC/q/slULJqHqWw6074Zz4WntfB97d0qdCbkAaF78WasvZ1cyRrnHprr3SqbHDaIRIU084HZx4XtCo/E5XDyh1DupyuuL0ZmWsV0DPT086kXT+ziHfvW571+Q4DFslOWLl5Lh+4ny3j5+6WCnwUxClZHoGK/bKK4V3s/gUrUOLP78gcRS49TpK0jocgj4Fv+gOAzY42LjQxnwFNDwII4r8hI5s5XsyKJM/Jvl4dhXKTJFT33n7YKFM5HIjn8mP11uzm58jSnSV1lI2cRNdpbWUTdxEV2ktJQYuMcYeSqSxg1W00HvVdiksTeBHpYneRm7mu+Mkj8bVl1wdm3yLgzmQTKvEAkK0vqKuNiDOcigy4VK2f/jkyXOlaz1jp2CcygF7QE6NfvDRyBVA2MpFgItco4he3XS+ClwKGSsF5Jqd8U1cHbfP+MRZ+8QhJzYLAuJdfqbzEBhGh+bGWeT/bJSCKKzYvcKlPBiA4uxdthMM3PucNOu4DY7OcQcHduH9iUxpZi6AJmbi99mcWH2XB1z/Ba10yPGd0FXXEXB95fiuf6ezNsfVDTZSbsD1tXZqlKXE7wX/V9rrdbx2pRWANbPQqb5rPMS5evwBdFt9N60j0JkJdkhdVz8YvwEwf7tW/h16T4JbzvK3H3wt+G9OOTsuPzgkhHAnuY6b/pvIf5OlbN9ztTmoI8Cu2HDh7zp8kmMcDD/+7kQOuh3sAZPI5XTMdmZ2eW+yYqDkjmMmbp80e0zcjgva7wT+ejkHbTjD4b4bwhWhdTHu/zj9/1RPraJ19ffAwj0k8KR1c/Ry69p+cJZ0s5HWnYjbZ0Rj4nYKtAuefOedTieCp6+HHgpGmr8O+u4s588xdvXcA1z9xE3VqvouRfudYNxyCPquz+XU407cWYc6fS6gxH0XTK8ZZ9w+JBpz3iXbUyELJXT6Dld8A/9oJFZePF9Hwlc3MlPyTiMl7zaa5KJMVHQbDEVfXouDPPEyw77EvPz0yuaqKtFVWkvZxE10ldZSNnEXBCO0xHFU+L2v0ATxZLOiXIBpXsYRX1ICvehILBIQmvZIOBU5xsF+9LJHaDEsoq7pq+e7OTryPZzkR9+F3zqvnJ504tIoY7sv+t03K9YNvnPGSSFpHFEpPnzqQov3WUryTczc5cQZfC7ld8ISxBFZV2FTgp+Zwa9AI/EuXuAIlNEhQVR8jMNRsGQBh2NVuJRGwjveWvJlJ3qtSqVVabQaMABNlKtbJ30nmCQtJ37vZCWtCkEUml/phjCacNpmOGmuB+kddscPAgInixySE2zCzkzbWyjlXh1YhZEjMeN9tqTO7wSLQnRKc2+xRsdt/KJlio8/pL4LaXgHXo2iiWVW2Y+1Zn7tjvbHB5O6SsFVLl2d6eZkXA7l5vgnr476P+uRLs502368c14Qb65wEaknhyYaqKE4brJ3CSZwsrb7rAmVCOTQREOOxIyRIzEkHfKVCPquTL+gEd9iVfZOeEQCovlZqQf5c1Sw+IZVtj/nCXDBIpro/EwoCeTWdVy++kfnzggu76j8nP/eV3v56t7+yjuzPnql/Zjggkndg89xEeDiFbroNCGxB0WOxPyOlK/SQj2Y1kzUYVyfI40GXHKm1s7hfCAPWGgDLj+jvfckuKOs/4L6R0H8cdLXUW532OXWZW1TYPD6y23/46sN8A6NVlsRWPExO6idfsZHY/0jR2KQcQ+b4kPSXQ7d5mxvkSMxrQ60GnrlLEcZtWj3zQ5Bf1t3n6ZCuPx91ggGDDwgfx2NcXWaiWV2BGLiHiSt6zp/8Tsn/nIUfupWdxrB/WL6Vg9bcvnBhbSKcqnyVo9xanra6bqwUotImp0YZylXADplBNfBub52OAT/nbkcRJeAao6Tvoifpb7TMSeIkAYfkoVwJac+t1vrsHc6ZnwUaV2HY5nT/pjzbmjfzG4n/5UL3itTmch/1KDRaEgw/ioQEsWk0axmJ82uCf+XD/P+9wecu8ZESoB7cES0hrhxSTi+HA5O8iaHShPyUy17FLm5zEh0ldZSNnETXaW1lE3cRFdpLeUxXlZY7UsIjyn0UjZXuPSHfJ6wJjHfmhu7nAMrK9nsole31fhIMYExMy5/fIiWtyBpFLLyKDAEwiZdyFMSyH7liteqYYn9XpU4DbaBMcUBRpHkUPHLrVdWK7CIwgtJkr9DkBxgXBEnJzl8+h8cDhZhBxTN4jiSTotMWiR/ln8VEgv3a8ccfqWq9uLUqPjpnYM5/Ex8v/URkdWtvtPp6nF1238QSupqc8Qe8Sud2KOf4SoEf8DVA4bC/xP8OSV1orOjrsvnyvE7xZ7V8cbC/R7MHFBmqfNauTjJlazcBohVPl4m07ZDnHEGDLhOMN46M8lBUUmPY8r5A+cKYIfwjzRXQDw0znXUuXJKhKlxx3ere+qxXwEFU7JSN1XXMRrCjfOwBTYbkrQzMu5tnz+nS0C3pR78CqzE/QNwO5zYAbgIid3+HNuhWfa2z5SyNq2LvwECWvfe3gf/DH7HgaE3HefvfdRPzM7d5aRZrM4Et7an0yneZMGsucsC7ig4esDAd42CgTTekQNGNoLY46vTssecd9Gqx8KYQlMq+UOhoZK6yPcBw/gbtmpMqnDZEQelWuXq4KlbZtApvjWc5Z863LWVTdxEV2kt5aeK+/8BFdPeU7+t9aQAAAAASUVORK5CYII=
    from_latitude NUMERIC (8,6) NOT NULL,
    from_longitude NUMERIC (9,6) NOT NULL,
    to_latitude NUMERIC (8,6) NOT NULL,
    to_longitude NUMERIC (9,6) NOT NULL,
    skipper_email VARCHAR(254) NOT NULL,
    CONSTRAINT pk_trip
        PRIMARY KEY (name_country, cni, start_date, end_date, take_off),
    CONSTRAINT fk_reservation
        FOREIGN KEY (name_country, cni, start_date, end_date)
            REFERENCES reservation(name_country, cni, start_date, end_date),
    CONSTRAINT fk_from_location
        FOREIGN KEY (from_latitude, from_longitude)
            REFERENCES location(latitude, longitude),
    CONSTRAINT fk_to_location
        FOREIGN KEY (to_latitude, to_longitude)
            REFERENCES location(latitude, longitude),
    CONSTRAINT fk_skipper
        FOREIGN KEY (skipper_email)
            REFERENCES sailor(email),
    CHECK (length(skipper_email)>6),
    --IC-4 A boat can not take off on a trip before the reservation start date.
    CHECK (take_off>=start_date)
    --IC-3 The skipper must be an authorized sailor of the corresponding reservation.
);

CREATE TABLE sailing_certificate(
    issue_date TIMESTAMP,
    expiry_date TIMESTAMP NOT NULL,
    email VARCHAR (254),
    for_class VARCHAR(80) NOT NULL,
    CONSTRAINT pk_sailing_certificate
        PRIMARY KEY (email, issue_date),
    CONSTRAINT fk_sailing_certificate_sailor
        FOREIGN KEY(email)
            REFERENCES sailor(email),
    CONSTRAINT fk_sailing_certificate_for_class
        FOREIGN KEY (for_class)
            REFERENCES boat_class(name_boatclass)
    --Sailing certificate must always exist in the table valid-for
);

CREATE TABLE valid_for(
    issue_date DATE,
    name_country VARCHAR(80),
    email VARCHAR(254),
    CONSTRAINT pk_valid_for
        PRIMARY KEY (name_country, issue_date, email),
    CONSTRAINT fk_valid_for_country
        FOREIGN KEY (name_country)
            REFERENCES country(name_country),
    CONSTRAINT fk_valid_for_sailing_certificate
        FOREIGN KEY (issue_date, email)
            REFERENCES sailing_certificate(issue_date, email)
);


CREATE TABLE authorised(
    name_country VARCHAR(80),
    cni VARCHAR(20),
    start_date DATE,
    end_date DATE,
    email VARCHAR(254),
    CONSTRAINT pk_authorised
        PRIMARY KEY (name_country, cni, start_date, end_date, email),
    CONSTRAINT fk_authorised_reservation
        FOREIGN KEY (name_country, cni, start_date, end_date)
            REFERENCES reservation(name_country, cni, start_date, end_date),
    CONSTRAINT fk_sailor
        FOREIGN KEY (email)
            REFERENCES sailor(email)
    --IC-6  One of the senior authorized sailors must be the responsible for the reservation.
);