Date: Tue, 6 Dec 2016 22:02:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161206210232.GN78624@...1296...>
References: <20161108124506.32559-1-gert@...1296...>
	<201611092014.uA9KErZf048132@...2054...>
	<8feec195-c9ed-a0bb-31c5-459bf9757ce6@...68...>
	<20161111221004.GC28918@...1296...>
	<b998265c-5220-d5ce-596c-fe400a422de2@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nT6ukc3bqTvTgwkF"
Content-Disposition: inline
In-Reply-To: <b998265c-5220-d5ce-596c-fe400a422de2@...68...>
Subject: Re: [Openvpn-devel] FreeBSD port versions (was: [PATCH applied] Re:
 Repair topology subnet on FreeBSD 11)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--nT6ukc3bqTvTgwkF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Nov 12, 2016 at 05:43:56AM +0100, Matthias Andree wrote:
> Am 11.11.2016 um 23:10 schrieb Gert Doering:
> > I might be tempted to do a quick 2.3.14 release in between - there's two
> > important platform fixes in that branch now (FreeBSD and OpenBSD topolo=
gy
> > subnet :-) ) and Lev's recursive routing patch.  Add to that the windows
> > block-outside-dns patch that I hope to be testing this weekend, and it's
> > worth a minor bugfix release...  at least "before January".
>=20
> Well, for me to update the FreeBSD port, mid December 2016 would be cool
> for anything (2.3.14, or 2.4.0, or both) due to the before-xmas-madness
> and to have like two weeks for smoke testing.

Here we go :-) - Nikolaus present, 2.3.14.

2.4_beta2 is waiting for someone to bump the openvpn-devel port, but
everyone is busy, it seems (PR#214930).

I wonder what the best approach towards 2.4 in ports would be, though -
introduce an openvpn23 port, and bump "openvpn" to 2.4.0 when that
happens?  Or introduce it as "openvpn24"?

"operating system wise", 2.4.0 should be as good on FreeBSD as 2.3.14
(because all the platform fixes went into both branches), but there
might be hidden bugs lurking in the "non-client, non-platform" bits
that are new in 2.4

> Bottom line, give Debian the priority, and while it would be nice to
> have for FreeBSD, no need to rush.

So far we've managed to keep to our timeline, which currently says
"2.4_rc2 next week, and 2.4.0 end of the year" (two weeks of testing
phase for rc2)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nT6ukc3bqTvTgwkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYRydoAAoJEB2Cnv7KVigSVaAL/RppakQ6ItH93yUnoPt7An5o
BJoAnYwmtsceoltw7I1N1Wg045z1ZrutDbhUkgD0qZ2ZN9aM8FVdIy4bIVYfFJlh
5sCiCDvDVM/pZPnsqFTVKkphhyT6Z1ikA8xo0pIXVmA1qnHay/i5V/EmpP0HEhIX
P5ETLuH4BlEL7VhycXMgNUrh4YL5Z9JzD+rj9tT+pp24WVwmHv5JcIueVxRvHQaA
+lpF0qEL5VDD8o0SPPkuvUemP9nuobFH0jKDflAHDlAYUkkSJLWQOfrm7jqhoA9k
OauwEU3ZNyuMBr2/SIZoX4yJZTZ/lWO6q8DfJFCj28YAX00fZMfs0t8EtRo1NaX7
40wW8N22OBChHvdWDkFa7mziCqBbI0+3Gorln5VcRPxYbNusp++m51XdC0TVW+z9
FfY9hpci6surLrO8y3OzpDjyNBfpQqZ5fjGvSR3E5qttVbKIAoMFna7+8t7jC0lY
yvYWsoH9RYV5jfiacBHNjtFwoZL+3tt1PANi4iCHUQ==
=Sshv
-----END PGP SIGNATURE-----

--nT6ukc3bqTvTgwkF--

