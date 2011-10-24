Date: Mon, 24 Oct 2011 12:08:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20111024100850.GB8496@...1296...>
References: <1319449145-27671-1-git-send-email-dejong@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PJQ/mdcU8Q0HUpEr"
Content-Disposition: inline
In-Reply-To: <1319449145-27671-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Added missing #ifdef to allow
	--disable-managent to work again
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--PJQ/mdcU8Q0HUpEr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 24, 2011 at 11:39:05AM +0200, Adriaan de Jong wrote:
> @@ -172,7 +172,10 @@ static inline bool verify_user_pass_enabled(struct t=
ls_session *session)
>  {
>    return (session->opt->auth_user_pass_verify_script
>          || plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_AUTH_US=
ER_PASS_VERIFY)
> -        || management_enable_def_auth (management));
> +#ifdef MANAGEMENT_DEF_AUTH
> +        || management_enable_def_auth (management)
> +#endif
> +        );
>  }

ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PJQ/mdcU8Q0HUpEr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTqU5MqkuBuNlUUl1AQIEkgP+OM114uzTxztMAd1u7suv+XbISV0iW2ma
oMV6xSM2icSSh1fJIIagAud0wKi//6vFt6bbTSEd4/y7mHDhsHn8mZ+SouIbcDy3
DqNE3zvkNctiJ5dRZm0YR/N9e3acld2fKXDE/yLy0vklOJOo2lRRMmA93UL7CfdE
XHyHIEJjefo=
=XuPP
-----END PGP SIGNATURE-----

--PJQ/mdcU8Q0HUpEr--

