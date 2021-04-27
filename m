Date: Tue, 27 Apr 2021 19:27:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210427172728.GS976@...1296...>
References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-5-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TGe9LcRTAdFssE+j"
Content-Disposition: inline
In-Reply-To: <20210408140229.31824-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] Implement deferred auth for scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--TGe9LcRTAdFssE+j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 08, 2021 at 04:02:29PM +0200, Arne Schwabe wrote:
> This patch also refactors the if condition that checks the result of
> the authentication since that has become quite unreadable. It renames
> s1/s2 and extracts some parts of the condition into individual variables
> to make the condition better understandle
>=20
> Patch v2: add refactoring of the if condition
> Patch v4: fix documentation not mentioning method as 2nd line
> Patch v5: fix deferred auth used by both plugin and script not working
> Patch v6: Add missing async inotify for script deferred auth

Just for the sake of the archives - this patch is a rebased re-send
of the patch in

  https://patchwork.openvpn.net/patch/1720/

(different from/to commit IDs, but otherwise 100% identical)

Someone already closed *this* one in patchwork, but I came across it=20
today when working on the "patchset" this was sent with, and it confused
me.  So, document, close.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TGe9LcRTAdFssE+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgiEl/AAoJEB2Cnv7KVigS9fQL/174ZXZ9efcCoTpYYGTEsGxm
zvsqqSSZDdNzuw2N1PiXEy4WlHRtBFy/J+biPJHeX67BpFdovuZVlSYWbeJxfEhG
MHWEvsmTImXYNs9MyjL2O4evFLfEfxzDbaUBdy+ImEaSCfR9n2JQ0pz2aNVYvpN9
0J0HnuF3onu6JfRfBYh12gwUIPcCGcWKvr+2s94IY7hA0lemJEIRlLVGDBuq0wT8
kUmeor0ij0HUDzmO/TnefYBTOPkJlMHkTnm7B9e9fjJ7E4ue0SzQ1nBZJ2md4G/f
E/CnreQf6xkU0qAU+WYxT7rdeSGrBzybVyXHbEd/tCakbnvZqGST6nP0P9Y3wWTJ
+QKIdsiEGgxSg77mkeenhQZ5w5prA9E8cEM5OUZoZvdrpJedwTi9D/21z2JRXWeS
ICS/01X+rFqE3yHEDps6AIJ8CITcSfcz7yMde06MrHqpPpU/GYhofQM6vCuXqJXP
oCO+mphVSL0Ojw3f4pJPRPV8EmSQQL2nT3JJslKNzA==
=g6ol
-----END PGP SIGNATURE-----

--TGe9LcRTAdFssE+j--

