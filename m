Date: Tue, 13 Jun 2017 21:37:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170613193756.GY97029@...1296...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
	<CAKuzo_hUiYVxZSEnB=8=ijO86_VbiZep2mR=1_FCi2pFJYLYmg@...278...>
	<20170613192559.GX97029@...1296...>
	<CAKuzo_gGy8xWAwBCzrxshHBPyzV=iMA=17vxnfSngfZ_b5MUrQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6az8+5dhbrqkbqJe"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gGy8xWAwBCzrxshHBPyzV=iMA=17vxnfSngfZ_b5MUrQ@...278...>
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--6az8+5dhbrqkbqJe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 13, 2017 at 03:33:35PM -0400, Selva Nair wrote:
> Right :)  But we could probably do better using Set instead of Add while
> the address is set using the service. I'm not that familiar with ipapi, b=
ut
> looks like SetUnicastIpAddressEnrty instead of AddUnicastIpAddressEntry
> may be the right thing.
>=20
> The netsh command used when service is not in use does correctly do a set
> not add.

Good point.  Wouldn't solve the first problem, but at least a subsequent
run would "magically fix it", provided the same tap interface is used
(which, I think, is the case in the great majority of windows installations)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6az8+5dhbrqkbqJe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZQD8UAAoJEB2Cnv7KVigSq3wL/A+6QPJUmbCyE8PftcdFSCi8
L4DDcTemlpPdjklkFuk0TcUSzczscgc2wKcWDJw21eeszyE6G8s4qbsw1/ekxH56
UTDhHcwmV5+Kj7rjbYG+pyfnroxqVTsqCs5x7U+9BPNl0YWSZGLK6Pu+t7rVfLqR
qbxBiJbEr5HTb1CJi61Qf4QKLPeM5vlnr4blpzi+9spqSGBgr3Ok45VC3oDmFpnA
OX1MsJ6rla+RiK4je+xfmsxKoNBOun/5A4TBGcigKEPObs/Jiv1/lXCguxJB+PyX
SFQKqhev55XxmQHj2PMDKoKCVEkJMzR5zI3e03o3grWvZvSXWmAW2cCZb1FoBwuW
i4IjZ5CJQ9gLOzo/+XUL2oB+TfCQwsiUxKkXekuXmiDsexYC5HhPfD7R4NAr0m7r
j0qkfNQ++p+sr7R7KwC6fL2M3sGtC/t31Zty/f0Ko1feZrBFNEC/FLEK1lv1dMeQ
eTxR7FWzaSRNFzz8bdCsq+juBT8NQt+uW9WI7362KA==
=1f1M
-----END PGP SIGNATURE-----

--6az8+5dhbrqkbqJe--

