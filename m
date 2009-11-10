MIME-version: 1.0
Date: Tue, 10 Nov 2009 17:16:32 +0100
From: Till Maas <opensource@...519...>
Message-id: <20091110161632.GA31301@...1276...>
Content-type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary=6c2NcOVqGQ03X4Wi
Content-disposition: inline
Subject: [Openvpn-devel] Script interface to trigger events depending on the
	validity of a	certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I would like to get a notification in case a client certificate is used
for a connection to an OpenVPN server, that is about to expire soon. Is
there currently a way to do this? I looked into the tls-verify hook, but
according to the documentation, only the Subject line of a certificate
is available and not the validity. Is there maybe a way to log the
expiration dates?

Regards
Till

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBCgAGBQJK+ZHcAAoJEGo6ELMcEJUX0BsQAJhqx8d8YCgIDe72cynK+FxA
YduRg1GVty7OdG5yAe4tcJjsgQfXj1c3l2ra+QSRc0QQckLIV+mbM5wFKTzTDKma
gMOzi++UhL7vXwas6789ZVpsBZ57SN+QifrqdB+9+GQI4WP12w8YA/2ynE4n9BhX
Fnuc1ut1Dyjz74NEpr1RRVFrxBwMGkPlk6zbIFO325kOa6zhG/obKi/NAh6TN2kz
PNjGGJ08t7q5xKB9eAOOq560j0cpsYJwS+3rrm3KF3rDQ4I2Mn2BTZlWAr14rw2q
NZpqRi/JRhvvkIMNrmM4/HWzQlI1PLQ5njYxdiQGe7nc1jXQOz8qKCMeZsiAEAzn
tHUeV2OmS/qEaUKAzjumzYHrYNeSSvVtf3wd+nTsZ2oIsAnHmreF4cftbUAs9L6c
GAvppQCgT7bumXq+oSDu6LZUqJYKo3NsixMZP5ffEduq+8CIjuSQLFtjSTeSMBGf
62l48iMugAGUY91aWyoO/AORd/HKDuYYsgDeDBMuMWaK97B7Ovc7DWz7UBkDFO1L
3lA40uBWZfSBxsHTRxp9OX+XUi8RlSvCGXwyRP4JsuBSI96GOmnWlDNaWx+pe3eZ
WQ0EZbk6+O/6e3i3LT+asTC57Q3wpXUOZQLpS6OVHqz9Zr5EoU/Yhxh8BUrPoJvm
qg7vzjDi3bAjKeVG8peZ
=WD6t
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--


