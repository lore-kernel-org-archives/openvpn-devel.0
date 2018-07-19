Date: Thu, 19 Jul 2018 08:29:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180719062932.GS55859@...1296...>
References: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="31zvzas5NXT9fief"
Content-Disposition: inline
In-Reply-To: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
Subject: Re: [Openvpn-devel] Fix for NetBSD with subnet topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adam <adam@...1031...>
Cc: openvpn-devel@lists.sourceforge.net

--31zvzas5NXT9fief
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 18, 2018 at 04:33:13PM +0200, Adam wrote:
> It turns out, NetBSD needs similar handling of subnet topology for tun in=
terfaces as OpenBSD does.
>=20
> Here is a patch to fix the issue (against OpenVPN 2.4.6):

This comes as a bit of surprise - has something changed here on the
NetBSD side?  Which NetBSD version did you test this against, how=20
does the problem manifest itself?

I do run CI tests on various NetBSD versions, and never had an issue
with --topology subnet there...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--31zvzas5NXT9fief
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbUC/MAAoJEB2Cnv7KVigSOewL/0UIV115SBaLReyYZoKj6lYq
rFbNhCIxn0YkkK4IRPi9EqVQcZlHGO2JuiWncJ778So8X/M1ifyFtqIVr3WiUbfR
uBcDgMA+YWdd2Q3M77LRvjH+kq7BC6HHzU7dWSnco/4/Ct/LC0g8jogrf6C954L0
z1efKQSC7aB31MDLkwnflOZiSp7klkRGpPG+UGWTRmrQJe5FVD5WNXjp/Yfa71vJ
bvgP0XL84LGecx/uV8hDWJx+XbDMn+olXSC7eIEEGrVrsN+J/u5dO4AN3yuLHh2v
4bFVuNNJ34cOy5cbw1arOCN1/pNoiVa6K7HWnLl9TbOHJ0egQVi+9bvHIF9pnvlF
tn0i/rIAH7LqXd9EUZW7eerbpsRClhCi6uGZu4QGqzp8dNOgMTy3gUlZinAfTbC+
3xQ8D0niQzOwqU+VtegIJ9MgS7Baae4JWpWpsA6Dt3KuAMv9zj6jijctzGO7jE/8
fqqTwC2w1fDLJSjfg7dIiq/KnPsdPUxCKYcbUN/jiw==
=TQwa
-----END PGP SIGNATURE-----

--31zvzas5NXT9fief--

