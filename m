Date: Fri, 5 May 2017 20:28:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170505182851.GJ97029@...1296...>
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <1494008642-7239-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] In auth-pam plugin clear the
 password after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 05, 2017 at 02:24:01PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> This adds a minimal secure_memzero()
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>

Feature-ACK, Code-NAK, but just because David is planning to export
secure_memzero() to plugins from OpenVPN proper - mentioned just today
on IRC

17:09 <@dazo> syzzer: just thinking aloud (remembered our discussion on wip=
ing=20
              passwords securely in plug-ins) ... what do you think about=20
              exposing secure_memzero() to plug-ins, similar to what we do =
with=20
              plugin_{log,vlog}()?
17:09 <@dazo> to avoid each plug-in needing to re-implement this
17:09 <@syzzer> yeah, sounds useful
17:10 <@dazo> I'll send a patch doing that too (should be quick to solve)


So I'd postpone this until David's patch plus instructions for plugin
authors show up.

Good timing :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZDMRjAAoJEB2Cnv7KVigSkRoL/2fbbeRn6UtlLMrNthIvwdXL
cDL0XWJONa/z39PHFCFrHXqvD46GmahEpqIvJx8MLH/Ijd7WAPWrla6FhLPhkH4s
l/tHBTYk4wqN4woIVg8GAvSSxFaZgOWd0uBXzv+QaMK2fKtcX3beK1zRRhUCbE5z
qcVhAh6/vl0hLUiLxAgunF+0Ii4O8u1wXafEhJ8mrDjIXMEn3Aj+5pFSnbch3vx6
PM+a9pShapmpnc6o1I0Q04QFrBSIVQqtQDSSp7u5TsDhnKG/yDFX3JEEGGVc9h0n
VWO88JxcIZdLCfHwvCr3L4JELIiOGxxbTXUSL5koQ4X50/yQHOy07c+of2Xm+BK2
qjFMTtohFm9/TN7T0voz7v8k9jNotpxZleq3oGldAtggU/xTe+dvqkX2lEeED2+H
fgqg4IB8XJQekO5HnNqjBaLk8EDbYOG8y7IgivreE4mGZQIS1XBSjkRJF9R3jUej
aUu23Wo1zU3an4XpNV/I0LhkGiHsjg3qi5LOnn/17w==
=8EVz
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

