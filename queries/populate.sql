------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Populate--------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--INSERT INTO country VALUES('name_country','flag','iso_code');
INSERT INTO country VALUES('Portugal', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Portugal.svg/390px-Flag_of_Portugal.svg.png','PRT');
INSERT INTO country VALUES('Espanha', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Spain.svg/255px-Flag_of_Spain.svg.png','ESP');
INSERT INTO country VALUES('Monaco', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Flag_of_Monaco.svg/213px-Flag_of_Monaco.svg.png','MCO');
INSERT INTO country VALUES('Dubai', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Flag_of_Dubai.svg/383px-Flag_of_Dubai.svg.png','AE');

--INSERT INTO boat_class VALUES('name_boatclass',max_length)
INSERT INTO boat_class VALUES('class 0',4.86);
INSERT INTO boat_class VALUES('class 1',7.90);
INSERT INTO boat_class VALUES('class 2',12.16);
INSERT INTO boat_class VALUES('class 3',19.76);
INSERT INTO boat_class VALUES('class 4',458.45); --biggest boat ever made, Seawise Giant

--INSERT INTO sailor VALUES('first_name','surname','email')
INSERT INTO sailor VALUES('Pedro', 'Rodrigues','pedrorodrigues@gmail.com');
INSERT INTO sailor VALUES('Rodrigo', 'Contreiras Santos','rodrigosantos@gmail.com');
INSERT INTO sailor VALUES('Sebastiao Santos', 'Caldas','sebastiaocaldas@gmail.com');
INSERT INTO sailor VALUES('Francisco', 'Regateiro Santos', 'franciscosantos@gmail.com');
INSERT INTO sailor VALUES('Paulo', 'Santos Carreira', 'paulocarreira@gmail.com');
INSERT INTO sailor VALUES('Fernando', 'Santos', 'fernandosantos@gmail.com');
INSERT INTO sailor VALUES('Quim', 'Barreiros', 'quimbarreiros@gmail.com');

--INSERT INTO senior VALUES('email')
INSERT INTO senior VALUES('pedrorodrigues@gmail.com');
INSERT INTO senior VALUES('rodrigosantos@gmail.com');
INSERT INTO senior VALUES('sebastiaocaldas@gmail.com');
INSERT INTO senior VALUES('franciscosantos@gmail.com');
INSERT INTO senior VALUES('paulocarreira@gmail.com');

--INSERT INTO junior VALUES('email')
INSERT INTO junior VALUES('fernandosantos@gmail.com');
INSERT INTO junior VALUES('quimbarreiros@gmail.com');

--INSERT INTO location VALUES('name_loc','country','latitude', 'longitude')
INSERT INTO location VALUES('Docas de Belem','Portugal', 38.691583,-9.21597729);
INSERT INTO location VALUES('Porto desportivo de Marbella', 'Espanha', 36.505776, -4.889836);
INSERT INTO location VALUES('Porto de Monaco', 'Monaco',43.735706, 7.427364);
INSERT INTO location VALUES('Porto do Dubai', 'Dubai',25.093679, 55.129368);

--INSERT INTO date_interval VALUES('start_date', 'end_date')
INSERT INTO date_interval VALUES('2001-01-01','2001-02-01');
INSERT INTO date_interval VALUES('2001-02-01','2001-03-01');
INSERT INTO date_interval VALUES('2001-05-01','2001-06-01');
INSERT INTO date_interval VALUES('2001-08-01','2001-09-01');

--INSERT INTO boat VALUES('cni', 'name_boat','length','year','name_country','has_name_boatclass')
INSERT INTO boat VALUES('PT-ABC00125-A1-97', 'otuga', 450, 1997,'Portugal', 'class 4');
INSERT INTO boat VALUES('PT-AJC00127-C3-97', 'tejo', 300, 1997,'Portugal', 'class 4');
INSERT INTO boat VALUES('ESP-AUH00025-F2-95', 'CR', 18, 1995,'Espanha', 'class 3');
INSERT INTO boat VALUES('MCO-KIF00142-D5-96', 'f1', 10, 1996,'Monaco', 'class 2');
INSERT INTO boat VALUES('AE-PTH000250-B2-96', 'copamundo', 3, 1996,'Dubai', 'class 0');
INSERT INTO boat VALUES('AE-PTH000287-B2-96', 'catar', 3, 1996,'Dubai', 'class 1');

--INSERT INTO reservation VALUES('cni', 'name_country', 'start_date', 'end_date', 'responsible_senior')
INSERT INTO reservation VALUES('PT-ABC00125-A1-97', 'Portugal', '2001-01-01', '2001-02-01', 'paulocarreira@gmail.com');
INSERT INTO reservation VALUES('PT-AJC00127-C3-97', 'Portugal', '2001-02-01', '2001-03-01', 'franciscosantos@gmail.com');
INSERT INTO reservation VALUES('ESP-AUH00025-F2-95', 'Espanha', '2001-05-01', '2001-06-01', 'sebastiaocaldas@gmail.com');
INSERT INTO reservation VALUES('MCO-KIF00142-D5-96', 'Monaco', '2001-08-01', '2001-09-01', 'rodrigosantos@gmail.com');

--INSERT INTO authorised VALUES('name_country', 'cni', 'start_date', 'end_date', 'email')
INSERT INTO authorised VALUES('Portugal', 'PT-ABC00125-A1-97', '2001-01-01', '2001-02-01', 'paulocarreira@gmail.com');
INSERT INTO authorised VALUES('Portugal', 'PT-AJC00127-C3-97', '2001-02-01', '2001-03-01', 'franciscosantos@gmail.com');
INSERT INTO authorised VALUES('Espanha', 'ESP-AUH00025-F2-95', '2001-05-01', '2001-06-01', 'sebastiaocaldas@gmail.com');
INSERT INTO authorised VALUES('Monaco', 'MCO-KIF00142-D5-96', '2001-08-01', '2001-09-01', 'rodrigosantos@gmail.com');

--INSERT INTO trip VALUES('start_date', 'end_date', 'cni', 'name_country', 'take_off','arrival','insurance', 'from_latitude', 'from_longitude','to_latitude', 'to_longitude', 'skipper_email')
INSERT INTO trip VALUES('2001-01-01', '2001-02-01', 'PT-ABC00125-A1-97', 'Portugal', '2001-01-01', '2001-02-01', '2D-AE-CPN1524368', 38.691583,-9.21597729, 25.093679, 55.129368,'paulocarreira@gmail.com'); --Portugal-> Dubai
INSERT INTO trip VALUES('2001-02-01', '2001-03-01', 'PT-AJC00127-C3-97', 'Portugal', '2001-02-02', '2001-03-01', '8F-EF-CFG2546385',38.691583,-9.21597729, 43.735706, 7.427364,'franciscosantos@gmail.com' ); --Portugal->Monaco
INSERT INTO trip VALUES('2001-05-01', '2001-06-01', 'ESP-AUH00025-F2-95', 'Espanha', '2001-05-01', '2001-06-01', '9D-VG-POI0289657',36.505776, -4.889836, 38.691583,-9.21597729,'sebastiaocaldas@gmail.com' ); --Espanha->Portugal
INSERT INTO trip VALUES('2001-08-01', '2001-09-01', 'MCO-KIF00142-D5-96', 'Monaco', '2001-08-01', '2001-09-01', 'E7-CR-VTR4589632', 43.735706, 7.427364, 25.093679, 55.129368,'rodrigosantos@gmail.com' ); --Monaco->Dubai

--INSERT INTO sailing_certificate VALUES('issue_date', 'expiry_date', 'email', 'for_class')
INSERT INTO sailing_certificate VALUES('1999-02-24','2004-02-24', 'pedrorodrigues@gmail.com', 'class 3');
INSERT INTO sailing_certificate VALUES('1998-04-02','2003-04-02', 'rodrigosantos@gmail.com', 'class 2');
INSERT INTO sailing_certificate VALUES('1998-04-03','2003-04-03', 'rodrigosantos@gmail.com', 'class 3');
INSERT INTO sailing_certificate VALUES('2000-06-15','2005-06-15', 'sebastiaocaldas@gmail.com', 'class 4');
INSERT INTO sailing_certificate VALUES('1997-09-12','2002-09-12', 'franciscosantos@gmail.com', 'class 4');
INSERT INTO sailing_certificate VALUES('1999-01-03','2004-01-03', 'paulocarreira@gmail.com', 'class 4');
INSERT INTO sailing_certificate VALUES('1998-10-26','2003-10-26', 'fernandosantos@gmail.com', 'class 1');
INSERT INTO sailing_certificate VALUES('1997-03-13','2002-03-13', 'quimbarreiros@gmail.com', 'class 0');

--INSERT INTO valid_for VALUES('issue_date', 'name_country', 'email')
INSERT INTO valid_for VALUES('1999-02-24', 'Portugal', 'pedrorodrigues@gmail.com');
INSERT INTO valid_for VALUES('1998-04-02', 'Monaco', 'rodrigosantos@gmail.com');
INSERT INTO valid_for VALUES('2000-06-15', 'Espanha', 'sebastiaocaldas@gmail.com');
INSERT INTO valid_for VALUES('1997-09-12', 'Portugal', 'franciscosantos@gmail.com');
INSERT INTO valid_for VALUES('1999-01-03', 'Portugal', 'paulocarreira@gmail.com');
INSERT INTO valid_for VALUES('1998-10-26', 'Dubai', 'fernandosantos@gmail.com');
INSERT INTO valid_for VALUES('1997-03-13', 'Espanha', 'quimbarreiros@gmail.com');