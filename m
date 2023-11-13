Date: Mon, 13 Nov 2023 08:12:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZVHMZLnGMe9KqJ05@...1296...>
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
 <ZU3aVt0EgPyOQWEe@...1296...>
 <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
 <fe0a4e43-4015-4834-a9bd-8764baf0134a@...1823...>
 <ZU39JoRBq8R_NgD6@...1296...> <ZU6I1MMD980Ervm-@...1296...>
 <CACDCbPq3O71Pjvaj0aBE8Dd-JQA3idZOxP+eyb=9if_MiLREQw@...278...>
 <ZVEX9TEflRrLHUmb@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xLftWnp/QEpb8JTM"
Content-Disposition: inline
In-Reply-To: <ZVEX9TEflRrLHUmb@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: Gert Doering <gert@...1296...>, Dmitry Melekhov <dm@...1823...>, openvpn-devel@lists.sourceforge.net

--xLftWnp/QEpb8JTM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 12, 2023 at 07:22:45PM +0100, Gert Doering wrote:
> (If you feel like debugging a bit more - could you compile an instance
> without optimization, run from gdb, and when it segfaults print all=20
> local variables of interest?  i, j, ks, *ks, ks->send_reliable?  We
> got one variable print from Dmitry - thanks! - but the optimizer broke
> printing "ks" things)

Dmitry was able to do this, and has confirmed that ks->send_reliable
is NULL here, because of "half-initialized state" - which can be determined
by checking ks->state first (S_UNDEF =3D 0 --> send_reliable not yet
initialized).

Thanks for your help, Dmitry and Greg.  Fixed version coming soon...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xLftWnp/QEpb8JTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlUcxkAAoJEB2Cnv7KVigSt2QL/jEVdRsXkDCCEQhAR3YjGn9J
y+rN61JcYwwzJJ0+X49HSRxCK8bVpJkmn4ZB8OymOJ4SVEURjELo7AyWD4rKxQm/
nMttzrJGDnHy1VP5YrAdWtE0gB03JjOL3MLcBD0VH33fRLhewU3/GiE/SaXpt7wT
HHyv30qwuXR9zmHUsDm6q5BRCInJ2T9fOv5fLmkNxBtUpn864DalzmBDbAYjmBL9
OIMtq/yH39HjSaXuRj0MQZt1cXRZoseuhSo3fIxw0EGtm1+VkgNJ+OoL5Mb0fbuU
u0lgaIlKirEayG1RXU8e8bh4Ldrlk1MuSNXHR33kMFS787CNnpMx2fnKbaIz3+87
xNTKPlcxuXMBNlPe29+jGSsHgklnIuHnuaO3WF3LihsBOQkl1fyLWxP3igkhzwlj
G9QLYsikvCTMl0UFWFAWSh7CbOad756pmRI1YxhLY0cHtUPpYm+4tdemicgXpdHK
pP7KFhR/H5u6GuIF7cpwWRrRJ0Kszdi4MfPxjltmkg==
=LwWd
-----END PGP SIGNATURE-----

--xLftWnp/QEpb8JTM--

