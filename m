Date: Sat, 11 Jun 2016 14:10:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160611121010.GR62247@...1296...>
References: <1442309019-7586-9-git-send-email-arne@...1227...>
	<1444919912-4432-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline
In-Reply-To: <1444919912-4432-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH V2] Remove http-proxy-timeout,
 socks timeout and set default of server-poll-timeout to 120s
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

--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 15, 2015 at 04:38:32PM +0200, Arne Schwabe wrote:
> With this change all timeouts before the first packet from the OpenVPN se=
rver are unified into the server-poll-timeout option.
=20
Time to get this done...

> The default of 120s has been chosen to be a safe value is larger as it is=
 larger the sums of the old small timeouts.
>=20
> Patch V2: Fix a regression with --static

I think I want a v3, due to a few "it has been too long" artifacts in
the v2 patch...

> diff --git a/android-config/config.h b/android-config/config.h
> index 7ba9be6..e0f857d 100644
> --- a/android-config/config.h
> +++ b/android-config/config.h
> @@ -348,7 +348,7 @@
>  #define HAVE_STROPTS_H 1
>=20=20
>  /* Define to 1 if you have the `syslog' function. */
> - #define HAVE_SYSLOG 1
> +#define HAVE_SYSLOG 1
>=20=20
>  /* Define to 1 if you have the <syslog.h> header file. */
>  #define HAVE_SYSLOG_H 1

This shouldn't be here...

> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 3a86409..b8fb2e5 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -354,11 +354,10 @@ block:
>  .B explicit\-exit\-notify,
>  .B float,
>  .B fragment,
> -.B http\-proxy,
> -.B http\-proxy\-option,
> -.B http\-proxy\-retry,
> -.B http\-proxy\-timeout,
> -.B link\-mtu,
> +.B http-proxy,
> +.B http-proxy-option,
> +.B http-proxy-retry,
> +.B link-mtu,
>  .B local,
>  .B lport,
>  .B mssfix,

And of these, only the removal of "-.B http\-proxy\-timeout," makes sense,
the rest is likely caused by merge/rebase conflicts with Samuli's addition
of gratituous "\-" all over openvpn.8 :-)


> @@ -533,13 +540,16 @@ process_coarse_timers (struct context *c)
>      return;
>=20=20
>  #if P2MP
> -  check_server_poll_timeout (c);
> -  if (c->sig->signal_received)
> -    return;
> +  if (c->c2.tls_multi)
> +    {

This check "c2.tls_multi" - is this a short form for "we're not a=20
peer-to-peer session"?=20=20

Other parts of the code seem to check "we have --pull or we have=20
--mode server", so I wonder if we should make this somewhat more
uninform.  Eventually... :-)

[..]
> +++ b/src/openvpn/init.c
> @@ -1052,6 +1052,19 @@ reset_coarse_timers (struct context *c)
>  }
>=20=20
>  /*
> + * Initialize the server poll timeout timer
> + * Thie timer is used in the http/socks proxy setup so it needs to be se=
tup

Typo...

> + * before
> + */
> +static void
> +do_init_server_poll_timer (struct context *c)
> +{
> +    update_time ();
> +    if (c->options.ce.connect_timeout)
> +	event_timeout_init (&c->c2.server_poll_interval, c->options.ce.connect_=
timeout, now);
> +}

Shouldn't this function be named "do_init_server_poll_time*out*()"?

(But I can see that part of the code speaks about "timer" while all the
rest is calling the things "timeout", like "event_timeout_init()"...)

> @@ -3545,6 +3543,9 @@ init_instance (struct context *c, const struct env_=
set *env, const unsigned int
>     */
>    do_uid_gid_chroot (c, c->c2.did_open_tun);
>=20=20
> +  /* initialse connect timeout timer */

Typo :)

> +  do_init_server_poll_timer(c);
> +
>    /* finalize the TCP/UDP socket */
>    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D C=
M_CHILD_TCP)
>      do_init_socket_2 (c);


[..]
> -#if P2MP
>        else if (streq (p[1], "SERVER_POLL_TIMEOUT") && p[2])

One just has to love these magic options :)

> @@ -633,8 +638,9 @@ establish_http_proxy_passthru (struct http_proxy_info=
 *p,
>        if (!send_crlf (sd))
>  	goto error;
>=20=20
> +

spurious extra empty line...  (which leads to "two empty lines" which looks
funny, otherwise I wouldn't have complained)


Besides these, the patch looks reasonable - and I assume it has been very
very thoroughly tested in those last 8 months, no? ;-)

So - ready to go!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1v/oakuBuNlUUl1AQLqpQP+NZ0k+qtxmSQlQfuNSUCQI3+g9TyENmMy
Swva/SV0m26LeAH8fRk4dlvZ7ndt5/wsxkuA7JXvYz60ijNMOAUeQS2eEmI+IxSF
jE0LmgdmTh4SsWuYSpDMIfQwr1dbFw3dPBNwo+0kYU+mSFxhc+QK2RaxwDNMGCjL
ybs9AdYFjF4=
=v4y2
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--

