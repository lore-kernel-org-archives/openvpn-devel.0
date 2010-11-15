Date: Mon, 15 Nov 2010 22:45:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20101115214531.GR258@...1296...>
References: <4CE1949C.6010707@...1114...>
	<1289854246-16196-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gLcqQrOcczDba7nC"
Content-Disposition: inline
In-Reply-To: <1289854246-16196-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Use stricter snprintf() formatting in
	socks_username_password_auth() (v2)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--gLcqQrOcczDba7nC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 15, 2010 at 09:50:46PM +0100, David Sommerseth wrote:
> +      || !creds.password || (strlen(creds.password) > 255) ) {
> +          msg (M_NONFATAL,
> +               "socks username and/or password exceeds 255 characters.  "
> +               "Authentiaction not possible.");

I'd ack this but for the spelling typo :-)

(Sorry, but, well, these things tend to stick...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gLcqQrOcczDba7nC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTOGp+6kuBuNlUUl1AQJF8wQAlD1ldygeS0CshBnK1ii5OKv59Y6kz42o
8jlr3NMqGhMeyOTCE+v3hOBdCiXbQ0bx+3j2JI2F06RHwmNOt0ejaMq19YbFa9X+
IYELgaHRm46ZhGqRa8tn+4JlR4dpF3VGO0hlM07r5DQu1UzwB2+ULcnx2smSx8gU
SXBK40EipaQ=
=ScXC
-----END PGP SIGNATURE-----

--gLcqQrOcczDba7nC--

