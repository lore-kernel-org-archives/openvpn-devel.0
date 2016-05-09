Date: Mon, 9 May 2016 20:04:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160509180427.GL53051@...1296...>
References: <280154CA-9468-429B-BCAC-DB632C0AFB32@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4aPahFyGg++yPLwE"
Content-Disposition: inline
In-Reply-To: <280154CA-9468-429B-BCAC-DB632C0AFB32@...2127...>
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

--4aPahFyGg++yPLwE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 09, 2016 at 06:22:49PM +0200, Jens Neuhalfen wrote:
> >From 885471cf0c9918a8a7edbae2b8985e2321aff739 Mon Sep 17 00:00:00 2001
> From: Jens Neuhalfen <jens@...2127...>
> Date: Sun, 8 May 2016 18:17:48 +0200
> Subject: [PATCH] Prevent integration test timeout bc. of sudo

Git isn't liking the way you send your patches - I'll apply it manually
(because it makes sense), but please take a look at "git send-email",
which will ensure that patches and mail headers, blank encoding, and
everything is perfect?

If I try to feed your mail into "git am", it complains about

Applying: Prevent integration test timeout bc. of sudo
fatal: corrupt patch at line 19
Patch failed at 0001 Prevent integration test timeout bc. of sudo

- not sure what it is, but it's usually fixed by "git send-email"... thanks.

ACK mail next :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4aPahFyGg++yPLwE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVzDRKakuBuNlUUl1AQKJRgQAtkfJtGl2Kse7wGVqOyhE9bAUJUNq3tFL
TH5RGzoblXlT/MWd1pBk5fyHGkcyEbkpwBh/UP8wdwwnNvwk9t+FkmDFyI4jeZl4
WkqKeiGxZNftP8doPhPUOhAF62gZniH8AZZ6+K1nXjI+kk620OK2Yp7hGd99Dndc
FIHLqqyonyo=
=lff2
-----END PGP SIGNATURE-----

--4aPahFyGg++yPLwE--

