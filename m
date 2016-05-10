Date: Tue, 10 May 2016 09:12:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160510071207.GO53051@...1296...>
References: <280154CA-9468-429B-BCAC-DB632C0AFB32@...2127...>
	<20160509180427.GL53051@...1296...>
	<58D68395-BFC5-4D6F-91A3-4A973008EB37@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HrSaiTVTrTHIlYwZ"
Content-Disposition: inline
In-Reply-To: <58D68395-BFC5-4D6F-91A3-4A973008EB37@...2127...>
Subject: Re: [Openvpn-devel] [PATCH] Prevent integration test timeout bc. of
 sudo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--HrSaiTVTrTHIlYwZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 09, 2016 at 10:39:24PM +0200, Jens Neuhalfen wrote:
> > - not sure what it is, but it's usually fixed by "git send-email"... th=
anks.
>=20
> strange, I use "git format-patch". I guess that "git am??? gets confused =
about the ???duplicate" Subject/From/.. lines (mail header and patch header=
).
>=20
> I???ll switch to send-email

It wasn't the duplicate Subject/From lines, but the whitespace mangling -=20
which is something mail clients *love* to do, and git send-email knows
how to avoid.

It was not only "git am" - I tried with plain old "patch -p1 <$file",=20
and that first barfed about "invalid patch", and after I fixed the
lines that had no space in the first column, complained about "does not
apply" because the context was not matching - "patch -l" (ignore=20
whitespace) worked, and that's a fairly good hint that a mail client
messed up whitespace...

Note: if you use exchange as your outbound mail server, even git send-email
will fail, because exchange *loves* to "fix" leading tabs in mails - Heiko
ran into this a while ago.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HrSaiTVTrTHIlYwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVzGJx6kuBuNlUUl1AQLnZwP9HhOyhefL2w2t1XOHboLyYBmFD67VbR6I
C7BzWPprZO47GK6AjU6B/yA1LVHpLcI8qq3jfIdCa48niWD4HDeyPlUEtTkuMx7h
u0MNDxjW4oNkxkZknthDuvbohXoGeRfzynX3mGsnfQJoA7s3s5g3jV3JJ7467Olx
TXceXFHFolo=
=GDzm
-----END PGP SIGNATURE-----

--HrSaiTVTrTHIlYwZ--

