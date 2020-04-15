Date: Wed, 15 Apr 2020 21:22:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200415192203.GO1431@...1296...>
References: <20200313130133.19045-1-samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="USf1PyUzamLyyBMw"
Content-Disposition: inline
In-Reply-To: <20200313130133.19045-1-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Document some limitations of
 --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

--USf1PyUzamLyyBMw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 13, 2020 at 03:01:33PM +0200, samuli@...515... wrote:
> From: Samuli Sepp=E4nen <samuli@...515...>
>=20
> URL: https://community.openvpn.net/openvpn/ticket/757
> Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
> ---

I'm going to mark that patch in patchwork as "changes requested",
given that Selva changed the issue towards "if this happens,=20
we'll just ignore the stored username and ask management for both=20
user+password".

Not sure if we still need a documentation patch, but if we want one,
it will have to be different text :)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--USf1PyUzamLyyBMw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJel17aAAoJEB2Cnv7KVigSoPQMAIkSW1IE84V5pzlL2RCZ704m
PcsK8DCgtFw8zl+oLR6fZbKAmjHHc9qTdXgVmTbb6VEsty1r/HHdFeTnA7htCZ4p
l+ZWNboYXNEdce070YTwifj8HwXIEdX4X3D2o6SrozSPtaM2nxcVvvkfZp4k52Bd
lcrg/MdmIJsQhOih1RpmTzbNg8DZgl32xK2nPg/Qkv0pVGYRh3aFy3CsvNyjYZ0S
QlofIqyXk13vLRTOE2pyaWQMmTCVkPCK0ubIoIVJ10BUz7v/SEV2qJ9M9n7O/wdO
Ir+uiTuOnCyghYIdWlXd9lA86DccW1aEoYdjkuh5oSDBWkfOZ85jsuXbuI8p6VTk
02tzyJApDsEsjfnNnHqjT1E371GmYaGPPzvpPO8WYs1XOYozB3yNqfB1cuV2piPw
lZWE57hmtBvFor9+364MUZlE6PopPU26c7aHQa9SSNfpBK+iLTAIIjyMXuLtNKBk
3HkLkvdR9al38YuP5BxjVm+5v/ZR9+2eeAiy0DpiCQ==
=AlVb
-----END PGP SIGNATURE-----

--USf1PyUzamLyyBMw--

