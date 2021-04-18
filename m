Date: Sun, 18 Apr 2021 15:33:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210418133320.GZ976@...1296...>
References: <20201215164221.5995-1-arne@...1227...>
 <20210328120241.27605-1-arne@...1227...>
 <20210328120241.27605-2-arne@...1227...>
 <20210418101127.GX976@...1296...>
 <37911499-1ff6-e396-8cf2-3f90e763299d@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2qHqlFNhrCDN4TKQ"
Content-Disposition: inline
In-Reply-To: <37911499-1ff6-e396-8cf2-3f90e763299d@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Fix condition to generate
 session keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--2qHqlFNhrCDN4TKQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 18, 2021 at 01:48:53PM +0200, Arne Schwabe wrote:
> > For master, this conflicts with commit 8fa8a17528c (compress migrate),
> > which already introduces the "multi" parameter.  Master only needs the
> > second hunk (documentation plus CAS_SUCCEEDED check).
>=20
> I can resend it if you want but this should be a trivial conflict. Maybe=
=20
> even 3way merge might fix it. If you don't count this as trivial=20
> conflict (i.e. does the same as the other patch) then I can also resend i=
t.

It's a trivial conflict (basically, 2 of 3 hunks are "already in", though
the first looks different due to line wrapping, so 3way can't autofix it).

I basically just wanted to know how to proceed here :-) - so I'll proceed
to merge this to 2.5 "as it is" and to master "only hunk 2".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2qHqlFNhrCDN4TKQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgfDUfAAoJEB2Cnv7KVigSENUL/jhBBIujzOzYilK8Kg3pp5xn
+O/PJOrr3ooPnTHGbu/pblwWxXctxaglgw04YHlJ4UkY1e/9f6MvewPVTWSGJSbP
t66sSi87Iks4qWvvnqvA4eNfRMci4j85ZoWp8s7ek90gHKoU2Rc9c+CWhgDD5/oM
fdq2nJ5FkkgFTCFMg2/zm+j5SB/I3ykqgTUV19FB7XWVs46qDYzY2H60H0cHgCbk
wCuLnDsgW/fbiJeBO8khbmm0K6cqLBPBQZPo0mrkMuy+WaZc9IY9sAjISy2RuVN7
gEVk9B6orOkw101xkNWf0E/DKruaE42dFjUYO/q7VFd5yDegXOaNbnnuNKotHScw
AT8atEWxTve+DwZ4hbggGnjrqFdTihdeHqiwB/RYxc6JBClbx0mJ+odHBcmMt31l
lgonmSG9nm7mrNxNn3YpGEoOlCNxhlbevBtQu2xSxCI6Tr0bY7qXg/zEg7Zd3tyh
vnE+z4Fz4y/dpBxCKXb1Xolex9+qVY8w2LICIY2HCw==
=oR48
-----END PGP SIGNATURE-----

--2qHqlFNhrCDN4TKQ--

