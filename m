Date: Fri, 17 Jun 2016 20:22:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160617182237.GL79504@...1296...>
References: <1466167642-13603-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <1466167642-13603-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Remove http-proxy-retry and
 socks-proxy-retry
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

--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 17, 2016 at 02:47:22PM +0200, Arne Schwabe wrote:
> @@ -5292,8 +5287,8 @@ add_option (struct options *options,
>    else if (streq (p[0], "socks-proxy-retry") && !p[1])
>      {
>        VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
> -      options->ce.socks_proxy_retry =3D true;
> -    }
> +      msg (M_WARN, "DEPRECATED OPTION: http-proxy-retry: In OpenVPN 2.4 =
proxy connection retries are handled"
> +        "like regular tcp connects");    }
>    else if (streq (p[0], "keepalive") && p[1] && p[2] && !p[3])

There's a copy-paste error in the message, and the closing "}" jumped...

If you're ok with that, I'll fix that on the go while applying.

Shall I remove the man page references as well, or do you want to send
a v2?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2Q/7KkuBuNlUUl1AQJ9cAP/Z7gSHSMEbwLR191sv2sTFuT4FEtt8Rsq
3W7jlGjQQlFt1Rfw8KSxd8iR5KjycVJmZ0S1PEdUci6ZInEUiJITHHLjEEUg3Y+N
1Cckc4KhbsjcfhHqfCZ/H6ltimhn1OeDjaMfx1dYhEcyTqvwP4lqU4RdRpI2tJRU
Z96cfeJeU0A=
=vD4Q
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

