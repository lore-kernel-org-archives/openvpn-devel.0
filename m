Date: Fri, 25 Nov 2011 09:38:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111125083853.GU8496@...1296...>
References: <1322171683-17358-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K5nRL+nTNCPL13nI"
Content-Disposition: inline
In-Reply-To: <1322171683-17358-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix bug after removing Linux 2.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

--K5nRL+nTNCPL13nI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 24, 2011 at 10:54:43PM +0100, David Sommerseth wrote:
> -	  msg (M_WARN | M_ERRNO, "Note: Cannot open TUN/TAP dev %s", node);
> -	  return;
> +	  msg (M_ERR, "Note: Cannot open TUN/TAP dev %s", node);

Agree in principle, but if you do so, please change s/Note:/ERROR:/ :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--K5nRL+nTNCPL13nI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTs9UHakuBuNlUUl1AQLUXgP/dlx4h+0sCeoBr6dClOVglFfnHBpmfxZn
meZM55ryDi+XLMqIjignrP58upxWIEVJxKK3+Ryloc2A45+vAcswVlzNrEnVJNyz
3Ig23VrL7YpWo9Awuw+lSml5iYovXH4D88Gm66FY8VfKYjTC5phKX19ABNBR0y8W
LCoyl60Phf4=
=65RT
-----END PGP SIGNATURE-----

--K5nRL+nTNCPL13nI--

