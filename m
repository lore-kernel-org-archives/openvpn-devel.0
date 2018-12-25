Date: Tue, 25 Dec 2018 09:03:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181225080337.GX962@...1296...>
References: <c042fd01f62d707477c37e0298e303f1@...2482...>
 <b49e6ca0-5ff5-5519-2078-87bd19225362@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vOCXB21EVDvwfuLa"
Content-Disposition: inline
In-Reply-To: <b49e6ca0-5ff5-5519-2078-87bd19225362@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix error message when using RHEL init
 script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Richard van den Berg <richard@...2482...>, openvpn-devel@lists.sourceforge.net

--vOCXB21EVDvwfuLa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 25, 2018 at 12:59:34AM +0100, David Sommerseth wrote:
> On 21/12/2018 07:43, Richard van den Berg via Openvpn-devel wrote:
> > In RHEL 7 /etc/sysconfig/network is no longer used (still there but emp=
ty).
> > This results in the following error when openvpn starts:
> >=20
> > Dec 20 09:01:25 localhost openvpn: /etc/rc.d/init.d/openvpn: line 94: [=
: =3D:
> > unary operator expected
>=20
> Not related to this fix, but we really need to get rid of the distro/rpm
> folder.  These init script should NOT be used on any systemd based system=
s at all.

I've expected a comment along that lines :-)  - and I'm not objecting
to a massive cleanup here.=20=20

But as long as we keep the script, it should better be well-behaved,
thus, my ACK :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vOCXB21EVDvwfuLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcIeRYAAoJEB2Cnv7KVigS5hcL/As8cb8Zwd9sjZknh4pP3b4a
pqDQ6Y42IksPvUgiFvbfENM3O/1e+/M996CVnZFKLx+BzvBYopGHeex0uZlS639w
KqHX+rJFk3uEdOMJeaUpXg0h1kCGe2AWW4An+v2wRgIspJ7m9F3uFoX4h8aQM5/5
une93Gmdc1jq6RLv/gnqyczaD+a3OVFmpCMlUksr54eLmkqAIB1O25yTrZO6HW5e
LP0AVEsilxKiAcMBkRrWMOGjRD07RfaK8jHnnZ6yTTGdQnNgb9r64/TKzQ+EiOew
5cospc4W8fJxrbpXjoe3MBHzf8tqJpkWGWcR0INswUQ6R018Neg5/JPWMyeW0gCK
grdUYwWUpJlXG59KjHPQcnnsgdz/YAU2PCr7b0M971VqBXW9s3vy+gMY1TfXvMY7
qk/kQRASuIOtdFz/J5/lv03yODuQB5rT/n0cJOCgZqOUBpjUzw7hs/7Fw9AHhywb
U/dOzppZ3HyvFKOnRhvhTTCnuydEbJph4ZRnm39oOQ==
=8NPr
-----END PGP SIGNATURE-----

--vOCXB21EVDvwfuLa--

