Date: Tue, 22 Oct 2013 13:40:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20131022114017.GD161@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC866@...1846...>
	<20131017141929.GC161@...1296...>
	<OF103608A1.B8847B78-ONC1257C0B.002E1D46-C1257C0B.002F1965@...1846...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j1TzbQBGf+ftliiX"
Content-Disposition: inline
In-Reply-To: <OF103608A1.B8847B78-ONC1257C0B.002E1D46-C1257C0B.002F1965@...1846...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after
	24hours (addendum3)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845...
Cc: openvpn-devel@lists.sourceforge.net

--j1TzbQBGf+ftliiX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 21, 2013 at 10:34:27AM +0200, arno.odermatt@...1845... wrote:
> thank you for replying.
> Do you see any time window, you potentially could have time for this?

I just gave it an initial try (using the "master" branch but that code
should have the same issues, if any, as no (known) fixes have been commited=
).

Valgrind isn't telling me about any clear mem-leaks yet...

=3D=3D1953=3D=3D HEAP SUMMARY:
=3D=3D1953=3D=3D     in use at exit: 2,560 bytes in 52 blocks
=3D=3D1953=3D=3D   total heap usage: 52,139 allocs, 52,087 frees, 15,723,72=
3 bytes allocated

... but I could see memory go up in "while sleep 1; do ps wwup 1953 ; done"=
=20
listings at exactly the point in time where renegotiation was taking place,
with two clients connected to it.

I could use some ideas on how to debug this further - if valgrind isn't
complaining, normally our memory management should be OK, but why is
VSZ/RSZ still growing, then...?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--j1TzbQBGf+ftliiX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUmZkIakuBuNlUUl1AQL3nQP9FP4WIftxpENJgXmppNVv0R/NQ5nuXDQF
0FAuZj0ijJHWfWYZADVH0W8zYnwUECoPJ9W6iGPKr1bxurK3yysqUx4aoBXX3FCD
nl8Xknw3W2wmy/Q+zjDDACGgqcPfrmITDf+twxFfqU4+W4t/CQyujK83ZL2b/a8p
FkbM+AEWXLk=
=Rzw8
-----END PGP SIGNATURE-----

--j1TzbQBGf+ftliiX--

