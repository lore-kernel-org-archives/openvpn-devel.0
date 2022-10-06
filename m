Date: Thu, 6 Oct 2022 12:02:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yz6nzSfEe4yrSI8F@...1296...>
References: <20220917231030.22565-1-a@...2181...>
 <20220919134108.31316-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="phrZTQxJ2FfPusyP"
Content-Disposition: inline
In-Reply-To: <20220919134108.31316-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] implement --session-timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--phrZTQxJ2FfPusyP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have a few documentation / comment language issues, and a bit of
grumbling about the code (which can be ignored).

On Mon, Sep 19, 2022 at 03:41:08PM +0200, Antonio Quartulli wrote:
> +--session-timeout n
> +  Raises :code:`SIGTERM` for the client instance after ``n`` seconds sin=
ce
> +  the beginning of the session, forcing OpenVPN to disconnect.
> +  In client mode, OpenVPN will disconnect and exit, while in server mode
> +  all client sessions are terminated.
> +
> +  This option can also be specified in a client instance config file
> +  using ``--client-config-dir`` or dynamically generated using a
> +  ``--client-connect`` script. In these cases, only the related client
> +  session is terminated.
> +
> +  When using option on the server side, it may be useful to push
> +  ``--explicit-exit-notify`` in order to terminate a client session
> +  and be informed about it.

This paragraph is a bit unclear.  Why would you want to *push*
--explicit-exit-notify?  *Use* it, on the server, so the client gets
an EEN, this I would understand.

Maybe reword this as

"If this is used on the server (main config or per-client), this works
better if ``--explicit-exit-notify`` is also used in the server config,
so clients are not just silently disconnected but get told about it."


> +
>  --socket-flags flags
>    Apply the given flags to the OpenVPN transport socket. Currently, only
>    :code:`TCP_NODELAY` is supported.
> diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/serve=
r-options.rst
> index 54ea8b66..9d0c73b6 100644
> --- a/doc/man-sections/server-options.rst
> +++ b/doc/man-sections/server-options.rst
> @@ -426,7 +426,7 @@ fast hardware. SSL/TLS authentication must be used in=
 this mode.
>    ``--inactive``, ``--ping``, ``--ping-exit``, ``--ping-restart``,
>    ``--setenv``, ``--auth-token``, ``--persist-key``, ``--persist-tun``,
>    ``--echo``, ``--comp-lzo``, ``--socket-flags``, ``--sndbuf``,
> -  ``--rcvbuf``
> +  ``--rcvbuf``, ``--session-timeout``
>=20=20
>  --push-remove opt
>    Selectively remove all ``--push`` options matching "opt" from the opti=
on
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index e5cee665..810cb8a7 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -630,6 +630,21 @@ encrypt_sign(struct context *c, bool comp_frag)
>      buffer_turnover(orig_buf, &c->c2.to_link, &c->c2.buf, &b->read_tun_b=
uf);
>  }
>=20=20
> +/*
> + * Should we exit due to session timeout?
> + */
> +static void
> +check_session_timeout(struct context *c)
> +{
> +    if (c->options.session_timeout
> +        && event_timeout_trigger(&c->c2.session_interval, &c->c2.timeval,
> +                                 ETT_DEFAULT))
> +    {
> +        msg(M_INFO, "Session timeout, exiting");
> +        register_signal(c, SIGTERM, "session-timeout");
> +    }
> +}
> +
>  /*
>   * Coarse timers work to 1 second resolution.
>   */
> @@ -681,6 +696,13 @@ process_coarse_timers(struct context *c)
>          return;
>      }
>=20=20
> +    /* kill session if time is over */
> +    check_session_timeout(c);
> +    if (c->sig->signal_received)
> +    {
> +        return;
> +    }

This now-triple "if (c->sig->signal_received)" still rubs my sensitivies,
but I'm not sure if it's worth rewriting check_session_timeout() and
check_ping_restart() to return a bool instead, and make this

    if (check_session_timeout(c))		/* game over? */
    {
        return;
    }

    if (check_ping_restart(c))			/* peer went to sleep? */
    {
        return;
    }

instead...


But anyway, this is more "material for a general cleanup patch", this
patch is OK as it is, code-wise.

> +    int session_timeout;        /* Kill session after n seconds, regardl=
ess activity */

"regardless activity" is no good, "regardless of activity" is getting a bit
long.

What about "/* force-kill session after n seconds */"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--phrZTQxJ2FfPusyP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjPqfNAAoJEB2Cnv7KVigST00MALQJXht6QCaix4P/iHk6rmVo
ILJqYKo2u+jSJ0K/r2LqXkciyrn/VAiuP7M2wpcfNMyXvHkJtdatLs44UXkz0b/F
fpHSUF/aVwSNCd3Dyo51ok33RBU48IEUfUh+FbQYdQpajr75PHlqTwEWURjQyb7g
Q8412FrnAGHJLsZQcb01zxECSJ1NcmTVUz+tBI1UuXnGuBi56mwTYOgXpTYHjsUD
Lp+Aof9a8BjsKXEK6I0hn1aNtqDC0oHyKhacqd8vsyLLZhy8+IsFRzBVQojbNW1l
yds8laHejmthZefLdf6hd9b8OtTogAe5pwA6e6BHEaTZTpmZWZY2gKv3hplfmJ2k
TXM11hZG7xqSYPa6jNElHafvakZXpO3zRnS8SSyfKLT4O5MBjkbyFHbzAn0udt1Y
TCn+7wlBboObce5cljRmEmdJU8SJ/I5kwXfHU5ki9/crIcv8l5mv925QOMePK1ac
rDJ8xctRE76cSwVJI3UEST2zF6HmH3/LTDEhEu33Jg==
=cxjs
-----END PGP SIGNATURE-----

--phrZTQxJ2FfPusyP--

