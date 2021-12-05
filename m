Date: Sun, 5 Dec 2021 11:19:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YaySTbKDclfC6PWL@...1296...>
References: <20211202125455.2593763-1-arne@...1227...>
 <2116536034.296245.1638548339523@...2642...>
 <eeacddfd-0819-0afb-4767-0dcc011f8c11@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="thboelxeZquYgfCA"
Content-Disposition: inline
In-Reply-To: <eeacddfd-0819-0afb-4767-0dcc011f8c11@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Make --nobind default for --pull
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

--thboelxeZquYgfCA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 05, 2021 at 03:57:55AM +0100, Arne Schwabe wrote:
> > The refactoring makes it very hard to see what the actual change is. Ma=
ybe it would be better to split this in two commits?
> >=20
> > The only actual change in behavior is the "|| o->pull", right?
>=20
> Yes. But should I really split up this 5 line patch into two patches?=20
> That feels a bit excessive.

I'm fine with a single patch here.

I need to think a bit more into "what conditions is this checking, exactly,
and why?" - but with refactoring, I'd have to do that thinking twice :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--thboelxeZquYgfCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhrJJNAAoJEB2Cnv7KVigSSPwL/iqO6ZW6110S8WFBUXWs/rcT
/TQcYFVoh4FmeYKmjO9/F/yyQ5ParOgneJo2GSw+KqaQ+Fx1xoVlZPC1+zAdrFlb
kQHLeSAziiVepd1Xa7YU7O65gUrJmy3YepB09o2CrxUD7YgnvFNVPZv77u1CRTuV
TJ4fCtwbgPfC0eoLBLPN5/AtVX/idmQoPUdW/p/in0qiPQbFmxhDZBGZ8o3w9HRN
HSByRey5rDZTk6QB4BwSho/znTVOKbTHVLIX3RGWJG2ZMtq217k+tegzG8eG5eQd
wLY0zUlGDWeDknzO7Rd7wxeMNB8MBzTOgyYDZdHNKq1M3hWTHPrSaDSoF7qgbcpZ
D2KeybvB5yGKe4QPDE+8VxIUUWBTO3F4ueRj9MmQq7L73Svfo87LjWe2SJxYrGvh
Z4hoHCSAI6oAY/Hx7swXDnPjbxeUttLVmIiMKGXwY5x6IwMkYEkejR6h1Pn+X1YN
RABZ5jtv5rlP6o49duO+EuRIWlnmukRliABIbDYWAw==
=5/lm
-----END PGP SIGNATURE-----

--thboelxeZquYgfCA--

