Date: Mon, 20 Feb 2017 14:19:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170220131933.GF93896@...1296...>
References: <20170125205302.23069-1-davids@...515...>
	<20170220130341.GB93896@...1296...>
	<d2dc71de-47f6-45f6-96b7-103d39725ea9@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HwdYac1wHLTJyVrJ"
Content-Disposition: inline
In-Reply-To: <d2dc71de-47f6-45f6-96b7-103d39725ea9@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] dev-tools: Simple tool wihch automates
 rebasing LZ4 compat library
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

--HwdYac1wHLTJyVrJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 20, 2017 at 02:13:20PM +0100, David Sommerseth wrote:
> > and ran it against a local copy of lz4 v131, and that produced the
> > expected result - no significant changes to compat-lz4.c/compat-lz4.h
> > (the "#ifdef HAVE_CONFIG_H" block moves to the top of the file, but=20
> > that is purely cosmetic - the block itself is fine)
>=20
> I /did/ consider to do some clever sed hacks here too ... but I wasn't
> in mood for that complexity, and I actually feared how *BSD would
> explode in my face :)=20=20

We'll always get you ;-)

> But as it turned out, the BSD explosion trigger
> was even lower than that ....... ;-)

GNU sed enables "more complex" matching by default, but I can never
remember which sed version does what, and when I need to turn on -E=20
("extended regex") to make sed do what I want :-)

> > So, any objections against the much simpler sed command there?  "lz4.h"
> > with double quotes never shows up elsewhere in the file today - and=20
> > when importing, we need to run a compile test anyway, so if it should
> > ever garble the .c file, we fix the script...
>=20
> This is purely my "match a precise as possible" approach I default to.
> I have no issues making this simpler if that is what is required.

Understood, but in this particular case, I think "simple is good enough"

> New patch or fix at commit time?

Whatever you prefer.  It's your code :)

(And since this is not "main openvpn code", the rules are not as strict
anyway - the actual lz4 commit change would need to be reviewed anyway)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HwdYac1wHLTJyVrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYquzlAAoJEB2Cnv7KVigSlqkMAJfRH1tDixF7n+B6GUajnq3k
xE+McAcgSUYv/68Of7jAujEvHKfLWi87J4TMgBVRapIJSJcvnWO34emJFdGDuPb2
xZcuC0TYRndap1vAwPVo+0o2iyt7WSnh/QAZwQ04oeHBUs/kqT91XCdeLNdeJ4z/
2SPQPsLE/K6zV2tC83uhinzOIEGrW5ruoXGVYn03Kf+whbp9H4SBXoPDQoWb309T
qBBZ4ax/7q8uiUt0gkVFeIXIim5Sm2esBTeiuDhC3vMv+9zuEATtYgqljndfWLS+
f/OZUmetsOT51cJndZQtsAxue2GBvh17KfZfPcUlYQLoT4UC5hNRd5nqQDt8ea2L
xNRaxdZxM/KLRMcyNRXssQEcCcoa7RDsItdEIrKoopI/zGvnKC5xlTd73g6ZkNyH
kehBc6o7Y4bnnX3CMipQeHH83JyNQT2QKgbV25MMRlVgTZpMLXWE33kDb+EmV/8O
Nn6qeAk+OKUQunROjksyAnKhNDxBlzpO/HH6SHWJUg==
=hO54
-----END PGP SIGNATURE-----

--HwdYac1wHLTJyVrJ--

