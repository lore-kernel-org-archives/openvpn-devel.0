Date: Wed, 22 Apr 2020 10:31:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200422083138.GD1431@...1296...>
References: <2b5fbffa-6b18-2226-5b29-7c6be670413b@...1800...>
 <20200421183735.GB1431@...1296...>
 <20200421185953.GC1431@...1296...>
 <20200422102152.273bd40d@...1799...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8wRZ/4jaTLrvx324"
Content-Disposition: inline
In-Reply-To: <20200422102152.273bd40d@...1799...>
Subject: Re: [Openvpn-devel] [Openvpn-users] new openssl = new OpenVPN
 release ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--8wRZ/4jaTLrvx324
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 22, 2020 at 10:21:52AM +0200, Christian Hesse wrote:
> > So, speaking to myself again :-) - I've looked at the advisory, and
> > it talks about "Server or client applications that call the=20
> > SSL_check_chain() function".
>=20
> Are you sure that openvpn code does not call any openssl function that ca=
lls
> SSL_check_chain() then? Did not check, but I guess that's possible.

This is one of the OpenSSL intricacies I wouldn't know.

OTOH, I would expect the advisory then to be worded as "a TLS 1.3=20
handshake might crash" not "... applications that call ...=20
SSL_check_chain()", which sounds very specific to me.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8wRZ/4jaTLrvx324
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeoADpAAoJEB2Cnv7KVigSBDoL/R0Xjlp61TjpDj4HctDA9Vot
Zji6JHAgH8YQ2B0dwBawC1ssubPNJe75oQOeYa9L4nqS6tIrppfl82OLEwo7H3dJ
HC5kxLPZ0wPbm+IqJ04uPH4MvOV4JXOax1eSpbkLLVjEV9RZXnXjTgepveJ0xWri
8O93LjoKFnUcfHqPa3NLmkx5VVYuqJVmtyDBL6knKIgOuj420jKnpsU4aQLOn9sA
oJGxje9Nt9FwNW2Tp/2lYhRVhmEq14PyrjT1wu8Ef8zFil+iUcLENYNT3HE/a1QM
78kF8PP0Ybo/zJ4AO1E5lYFHf3lC+/V7GzWrfHNc4I12STK7EZNo0ekv0FB1IhXk
zZ/ui5NT9AvVxMx831XzU6wfVQCAH/vbEmkOeRLRVyIb8Kep76ySX/qdfSRYYxdn
scG/pGpd1jEcKPgQfUJePbUILd7Qvsf728YOIR/FTcvX8FOsNIJecXISsDGA8dJ/
COk37z2bmvle7MBFDuf5orx9rrM3lWMGk2qqtPRDeg==
=bn0b
-----END PGP SIGNATURE-----

--8wRZ/4jaTLrvx324--

