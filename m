Date: Fri, 16 Aug 2019 22:29:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190816202908.GR1349@...1296...>
References: <20190724152934.9884-1-arne@...1227...>
 <201908161931.x7GJVqP9044592@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Content-Disposition: inline
In-Reply-To: <201908161931.x7GJVqP9044592@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: openssl: Fix compilation
 without deprecated OpenSSL 1.1 APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rosen Penev <rosenp@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 16, 2019 at 09:31:52PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> Is this also suitable for release/2.4?  "You folks tell me, I do the
> cherry-picking" (if it applies) :-)
>=20
> I have removed the extra spaces in "# if" constructs, as this is not
> something we use elsewhere on nested CPP expressions (it came up in the
> discussion, but was still part of this patch).
>=20
> Tested lightly with openssl 1.0.2o and 1.1.1.

I should have tested with mbedtls :-/ - buildbot tells me that a good
number of platforms have started core dumping on the mbedtls client tests=20
with this commit.

*** Error in `../src/openvpn/openvpn': free(): invalid next size (fast):
+0x0000000000c74850 ***
./t_client.sh: line 262:  8896 Aborted                 (core dumped) $RUN_S=
UDO
+"${top_builddir}/src/openvpn/openvpn" $openvpn_conf >> $LOGDIR/$SUF:openvp=
n.log
  OpenVPN running with PID 8896

(I have seen this on fedora29 and one of the FreeBSDs, but there is
"more red" - more details on mbedTLS versions in use can be provided)

Steffan, if you could have a look, this would be most appreciated...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdVxITAAoJEB2Cnv7KVigS/NcMAJeinZOlMpig1zbUo/9dLzkh
RDIn6/mXadnaeZvLpr5zRPvQHnDZR7AVXJCMFUW0bP7fpDg1Qd6OafyWlXNv+hgG
DRBcSIhsCCphB1RggYnMjhKAtAY3MhZsCdenX++hg2SBHUWa+isL/wy+9PsljsbL
lbAUPVTRgqsGmaBrnxSmVkPFy9rTEVYqk31lEH5KDDNjAsNNpBfb1M0pTOGLt7wx
t6v4i/2FIxbLGiWRjmmW8ZX1XLKolm3Ax2mD/KPFUSrpXnByAQyacd946XD+k3Kp
lhZMOGCxKnwDlR2Mts/C7axR2dq6DuK7pUAEDIVo2jsXOqD8QeEfvJ0kCfce6xd7
Q3GzDj1np5ltbx2HBmOei1cQna96IwO57JmfcZICSY8xighN64NZpa4VZ4uvy+yc
MF2a3l4uBR3nO+smcN3GqwffbZ59oL90rG8a3pW3iBzYMOV3kPXbesZkCRtOG0k2
a/f9t1CGA5c3n/Hdjx2TA9DaWBx3xeAW3Hl+rnFFFA==
=oRd+
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--

