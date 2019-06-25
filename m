Date: Tue, 25 Jun 2019 21:49:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190625194905.GM1097@...1296...>
References: <1561491241-16380-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Lqu5hkAdORZH7CMT"
Content-Disposition: inline
In-Reply-To: <1561491241-16380-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: enable interactive service
 to open tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--Lqu5hkAdORZH7CMT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 25, 2019 at 10:34:01PM +0300, Lev Stipakov wrote:
>      ack_message_t ack;
>      struct gc_arena gc =3D gc_new();
>=20=20
> -    if (!send_msg_iservice(pipe, rt, size, &ack, "ROUTE"))
> +    if (!send_msg_iservice(pipe, rt, size, &ack, sizeof(ack), "ROUTE"))

I do not like this.  Please find another way to send the request message
"with length" than to add an extra parameter to every single caller of=20
send_msg_iservice().

Possibly introduce a wrapper for the "standard" case which calls a new
function send_msg_iservice_ex() that takes a length field for the return=20
data type.  And the open wintun / return handle would then use _ex().

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Lqu5hkAdORZH7CMT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdEnqxAAoJEB2Cnv7KVigSil8MAIHzFR9ryLd/YhfXtOOpqF08
DKSz40MZ5lg5mif/GsIxLu0wxSMNhOyxMV/KYPbXskRZVSLvJTPm9zm9FCE8H1uk
8O/9XRmH5Uxvq6wCfj21nZFqAIXTzVR/rzUIUOp/pvSqy9FD2AdhCmkY2fc2B7Wy
c1EiFmopKqSRzc7YAfz9yjejru+31GU0zmfGd+OgHTnd/x1q09wGGyCcJJYhRnjg
nfZWL2ojqJamhMDToiNgl7ReFoCJBnWNgAJZ8GMTqRsT/YZDIeivn0ZhjXh1GWBN
z8FuCjsRpx2xRIGG6Tp89FqPRtrk1pvjIhc0YneoodymsJnSY/3rLDEXg6kqorsu
+fCLpbfhEpWrXFCDi9JCSis6rdOg9R27S1VbfzioDuh6O9OLdn+tckuNmKcyps9a
+jEzNW3S/xD5f1rfcfP0hIt9PAz0+1eBlNhDzU9ncgMaaGUgSsDO/VmdAZedtCgQ
7/Lps/nWIf7kQpo4wX2jn3tBlTpiLpDiDTjyh16AKg==
=VwLn
-----END PGP SIGNATURE-----

--Lqu5hkAdORZH7CMT--

