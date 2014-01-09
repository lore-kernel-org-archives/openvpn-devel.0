Date: Thu, 9 Jan 2014 21:06:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140109200640.GY226@...1296...>
References: <1389296891-1487-1-git-send-email-gert@...1296...>
	<52CEFDA9.1090306@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hbEGQ9F0b6kf96/Q"
Content-Disposition: inline
In-Reply-To: <52CEFDA9.1090306@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Reduce IV_OPENVPN_GUI_VERSION= to
	IV_GUI_VER=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--hbEGQ9F0b6kf96/Q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 09, 2014 at 08:51:05PM +0100, Arne Schwabe wrote:
> Am 09.01.14 20:48, schrieb Gert Doering:
> > Use shorter variable name to signal the same thing (see f3a2cd255a3bc73)
> > to save space in the buffer used the collective IV_ info sent to server.
> ACK.

committed and pushed, with updated message-id, acked-by, etc.

commit 7efaca734b8d633441ec3d7def2a2768864dedcf (master)
commit c1b35689964f6910c1ea239618d42ee5e552c405 (release/2.3)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hbEGQ9F0b6kf96/Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUs8BUKkuBuNlUUl1AQIEswQAkIzsDHkMQYwaAjo35SpJ6r/h2V4U5F2F
jt4dzq2ZeDE1iNq2bj84HSHMK6ArbDP3y6Q8FuzqUtSVcUcdnZfJYhgBu8Oe/aVX
MrqbflpEdLmoY5bIj6xn9s2K5V4zochRJZC2rfzKFoXjWCdvo0SS8pPo8SznNLzC
4MFP81hPc2E=
=bc5m
-----END PGP SIGNATURE-----

--hbEGQ9F0b6kf96/Q--

