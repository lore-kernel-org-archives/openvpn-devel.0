Date: Fri, 11 Aug 2017 20:26:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170811182603.GA70062@...1296...>
References: <20170811090744.31750-1-a@...2181...>
 <20170811090744.31750-6-a@...2181...>
 <CAKuzo_gpjo3d6O+Z8XrCGt0DVaySR8AZrQ4MyVxqpx0spD8gwQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xd7ZVmXU2EjaW0+X"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gpjo3d6O+Z8XrCGt0DVaySR8AZrQ4MyVxqpx0spD8gwQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 5/5] use NULL instead of 0 when
 assigning pointers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--xd7ZVmXU2EjaW0+X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 11, 2017 at 11:11:21AM -0400, Selva Nair wrote:
> Constant 0 or (void *) 0 assigned to a pointer are the same as NULL
> pointer, so why bother?

Technically, it is (and NULL is quite often defined to be "(void *)0L"
or the like).

Personally, I like using NULL - and seeing NULL being used - when in
pointer context and "0" when in numeric context - it's more a visual
thing.

Since we use NULL about everywhere else in OpenVPN, I think this change
to get the few remaining places in line is a good thing.  Thus, ACK :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xd7ZVmXU2EjaW0+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZjfa7AAoJEB2Cnv7KVigSpDUL/A7AbkeuKeQaQ6hji2p9tNUT
hkYqghvT4MYLe66LPvMz2p6VpZFPe18UsrxWNY+RoL9bvsrIvc1Ne1Pp4YXbDMSV
B63ruHcpevIWLd/23tSFp1Pzpu/O9vWXuSQ+gOyFLkoc60VBbrqAg9jrqI1uDUuk
C5CK+Gfx87jFciE7NBgIHAYgGsL1ZEeS/Gh2RhLTht3SejUoastlaqwpuFnx1Iyg
aHAZI8r4fTTUTA+jZglqGaq/ETX6aWUrbub+wCGSflSx3t+YxI7mmPrRs3kBg0W+
Us1edBnwiaMGZVi4hFcCk/c97l3qltFPaB7EZ+ht0KBgJOGlNQ3Atw2Z470pzdkJ
uoH1TQqiDmSP8M90weEv/sjSA/9clMWGT9izmDlwynyMD634xvJDgtANcbaATffN
OMbmOeNMXWMoUgI3EenORAl+XfkSjKD9WBWTmEyztKW1KhEYFgIYrIGoZRnE9r76
K6mihHJqun37RcB52y4TA+/jp5DOQ0YkCXMzGJJrug==
=DtQu
-----END PGP SIGNATURE-----

--xd7ZVmXU2EjaW0+X--

