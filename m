Date: Tue, 14 Apr 2015 22:48:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150414204824.GE382@...1296...>
References: <1429036445-17223-1-git-send-email-yegorslists@...1030...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <1429036445-17223-1-git-send-email-yegorslists@...1030...>
Subject: Re: [Openvpn-devel] [PATCH] m4: enable silent build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Yegor Yefremov <yegorslists@...1030...>
Cc: openvpn-devel@lists.sourceforge.net

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 14, 2015 at 08:34:05PM +0200, Yegor Yefremov wrote:
> +# enable silent build
> +m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
> +

I don't understand autoconf magic well enough to understand what that
does - do you have a pointer for me which would explain it?

thanks

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVS19GKkuBuNlUUl1AQKDVgP/fmuevKfwmDQbgzjkfAwZeLScNXIBRltq
AJhWQDFRFwyGgWYxj96UPDEDQgmNatsyKWyeoQSq5R0WAZyb8RkSvraOG+THSqjt
rzwr94bvCzCLKGCdfxas77MQoDgkSBwk7sejOm5+QPmJ6997BpyrBVNm2F82TNmS
WT56z/UYuW0=
=evxg
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

