Date: Tue, 21 Apr 2020 20:37:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200421183735.GB1431@...1296...>
References: <2b5fbffa-6b18-2226-5b29-7c6be670413b@...1800...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RcG5pgtWOxaVNzmE"
Content-Disposition: inline
In-Reply-To: <2b5fbffa-6b18-2226-5b29-7c6be670413b@...1800...>
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
To: mike tancsa <mike@...1800...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--RcG5pgtWOxaVNzmE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 21, 2020 at 02:15:43PM -0400, mike tancsa wrote:
> =A0=A0=A0 Will the sec issue with OpenSSL force a new release of OpenVPN ?
>=20
> https://www.openssl.org/news/secadv/20200421.txt

This is a question better asked on the openvpn-devel list.

But anyway: normally we do not statically link OpenSSL, so whenever your
Linux / BSD distribution updates OpenSSL, it will make sure OpenVPN
has the latest patch -> all good.

Now, on *Windows* we ship OpenSSL as part of our package, so if this
is an issue that is relevant for OpenVPN (haven't checked yet - some of
the security issues in OpenSSL in the past have not affected us because
we didn't use that functionality) we'll re-roll the windows installers,
bumping from "2.4.9-I601" to "2.4.9-I602".  So, no new OpenVPN release,
but new Windows installers.

On MacOS, I think Tunnelblick has to bundle OpenSSL, so you'll see
an update there as well...


Long story short: we'll look into the advisory, and then see what to do.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--RcG5pgtWOxaVNzmE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJenz1vAAoJEB2Cnv7KVigSNcwL/jEGXYL0WHa1JlkdzqiBsCAg
5X028kC8AB6WmNVv3xtW740Olp/KTaplfbJoXVgyZ3QEbf8jbiGCfYmuvPPeJ79B
xabR/w49jWY+hEIIk7w/LG719EDDa5DeQ72bcLySaPbgw92LD+OzluVcD21HbxbE
6IE+skrH8JJnQuycsnxj6yLiLqw5jkMSpOPle12VwxlrRwynRj+ZZ3na+poRmB2x
yoaK/WvbaJPwpnyIXqPX+SYciqgd0YATnDzpunh+OYu9c5ANb6C6GePOWpDJ2i3n
yuFmYATxx62XLS8SZ1rAuoXw2fgAQB6OOAKXUFpq8Xl6+c9p5Uec9wJ9zmeuIV0d
Vg0vVfmX0htjs+DCTGSOD9Yb36iIjIDafjQX/6j99V1PLe+rAeLYmx1sq7Ca2NSy
DLEjZgzKGJ9lvKAfsFc7C0HN1HlmQrULPpfB/t0ijkQTjpT9kgyu0j0hBRKGeb+g
hLisl512eKcO2OV45ZtOfgeYObuz+WAoOrc/LEwnRQ==
=JLEl
-----END PGP SIGNATURE-----

--RcG5pgtWOxaVNzmE--

