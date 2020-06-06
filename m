Date: Sat, 6 Jun 2020 21:46:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200606194636.GC1431@...1296...>
References: <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
 <1591374528.4728.53.camel@...2316...>
 <1591377595.4728.67.camel@...2316...>
 <47ddb948-d12f-6372-1ca9-34b70dee3f25@...1227...>
 <20200606084110.GY1431@...1296...>
 <fe88bc2f-948d-d0c1-8969-b81ccfe1dba2@...1227...>
 <20200606112817.GZ1431@...1296...>
 <1591456971.3589.12.camel@...2316...>
 <20200606181657.GB1431@...1296...>
 <1591470647.3314.6.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZNES78oPoAmfTYTh"
Content-Disposition: inline
In-Reply-To: <1591470647.3314.6.camel@...2316...>
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--ZNES78oPoAmfTYTh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 06, 2020 at 12:10:47PM -0700, James Bottomley wrote:
> > > +eval shrext=3D$shrext_cmds
> > > +AC_SUBST([shrext])
> >=20
> > ... I hoped we can get rid of this again...
>=20
> In theory I can get around this using the libtool -shrext .so on the
> command line.  Someone would have to check on windows that this is
> acceptable because they really like .dll as the extension.  If it works
> on windows then the below patch should do it.

Oh, Windows.

Production builds for windows are done with MinGW on Ubuntu (cross-builds)=
=20
and we do not run any unit tests there.

Lev does run MSVC builds, but he's not using "make", so I'm not sure he
ever runs "make check"...

What would be needed to actually run this test on windows?  Or any of our
tests?  "MinGW/Cygwin on windows"?  Has anyone built with that since XP?
(My first openvpn.exe was built with MinGW/Cygwin, but that was painful)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ZNES78oPoAmfTYTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe2/KcAAoJEB2Cnv7KVigSJdEL/RfIniCSkgo0yBR21vnali7K
IaRPnhPIPe63FulfIcoWHvIMUqBOq5aSdqxQS8ws6711V9GTHHvsSxNKZnUa7Ij8
8HiS8m3QWKzjnisK4kl0U3el3JCs17X1ZplX2nRjfpl4flePB38/eli8susNCCT0
aWKLs38drHAB4u8Lz6Y1OAlrm7ZKCCvONl1oU1qPS61yIgINI5Wqhlv/m0O6w6I+
uevGJlZE+BK77KLLNYzKH1T8+u1fyxKAW+apg/5D+eQQtfV/r8ImHIETOGsoymmi
nlmV1whD/DFLIqINjhnTPOxWrzfnHKRW/8JICU/hhuAQxxuIAadUQBEasmthqezV
pgcusRnJim+PKUCzWBP2kuUgmJ+qHf2SFH8KJ5C+LeORz3zn9Zbw7apJUKEL38wU
s5h7ecjPRP7XkT7Uiq7f5v1luiRZgTjZSuBYr7fMD1QFBJ77+BXOrP5e9H0CwE+C
2cQbmrUceRg2vf/jpOMnr9E79vD+TKGYuiANIBpNSw==
=rFj2
-----END PGP SIGNATURE-----

--ZNES78oPoAmfTYTh--

