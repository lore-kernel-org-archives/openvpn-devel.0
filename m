Date: Sun, 18 Oct 2015 13:46:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151018114633.GB22054@...1296...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
	<20150830162534.4ee0c9f2.movrax-dev@...2061...>
	<20150830203749.GW34798@...1296...>
	<20150903221836.04306e51.movrax-dev@...2061...>
	<5612D2DB.8090007@...1856...>
	<20151017215022.6ce3cdab.movrax-dev@...2061...>
	<20151018103446.5fed9f97.movrax-dev@...2061...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PvO6gVpe2R1m8PYV"
Content-Disposition: inline
In-Reply-To: <20151018103446.5fed9f97.movrax-dev@...2061...>
Subject: Re: [Openvpn-devel] [PATCH] Privileges not being dropped if the
 first connection is not successful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Lukasz K." <movrax-dev@...2061...>
Cc: openvpn-devel@lists.sourceforge.net

--PvO6gVpe2R1m8PYV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 18, 2015 at 10:34:46AM +0200, Lukasz K. wrote:
> I'm resending my previous message (as a quote) with attachment, using
> different headers and no signing, as it appears it has been incorrectly
> handled by mailman.

The way that really works best is "git send-email ..." - it can handle
remote servers (smtp+auth) if needed, or just feed to local MTA, and
it will always get the formatting and whitespaceing and mail headers=20
and everything right :-)

Your e-mail, for example, was again a bit weird, as the original mail
was just "included" and not "attached" (message/rfc822 attachment), plus,
it had CR+NL line endings in the "attachment" part - so "git am" had
a hard time extracting the actual patch as it stopped searching when
it hit the second "From " line...

Anyway, since it wasn't whitespace-garbled, it applied, but really and
truly, git send-email is what everyone wants :-)

Merging right now...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PvO6gVpe2R1m8PYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBViOFOakuBuNlUUl1AQJ+TQQApLdcL7d9QBObH2LuYv93zvbCgBgDtE1N
sTJCn1mZQ1KaYYSCtkZzpCdhGhDInLM82doq2+nBm++hjEhzNIr9ILyBysfda2Eu
u1kLWoA24okJ+kHwa66u5JnFKMTUd8esn/kByd+oVBRodLxijoLvauzUyySXYU0c
waKEny5+Fpc=
=2v/0
-----END PGP SIGNATURE-----

--PvO6gVpe2R1m8PYV--

