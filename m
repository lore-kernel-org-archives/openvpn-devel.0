Date: Sun, 18 Sep 2022 12:37:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yyb07u4pG0Ii9vQf@...1296...>
References: <20220917231030.22565-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EKVAqSiJrohY0G8j"
Content-Disposition: inline
In-Reply-To: <20220917231030.22565-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] implement --session-timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Dmitry Zelenkovsky <Dmitry.Zelenkovskiy@...1719...>

--EKVAqSiJrohY0G8j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Sun, Sep 18, 2022 at 01:10:30AM +0200, Antonio Quartulli wrote:
> From: Dmitry Zelenkovsky <Dmitry.Zelenkovskiy@...1719...>
>=20
> Disconnect clients after session-timeout expires.
> session-timeout can be defined in ccd files in order to limit
> per-user connection time.

I find this implementation needlessly complicated.

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

Why are we working with event triggers here, if all we *want* to do is
a single-shot

 if ( now > $somectx->session_must_end_at_this_time )
 {
      /* kick out this user now */
      ...
 }

> +    else if (streq(p[0], "session-timeout") && p[1] && !p[2])
> +    {
> +        VERIFY_PERMISSION(OPT_P_TIMER);

OPT_P_INSTANCE?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EKVAqSiJrohY0G8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJvTuAAoJEB2Cnv7KVigSiaQL/R12suoaYRYT9rOk7jy9IPZw
fhpBgn8NuODLKQauauRtaiJi58jIyyJPyWEN8XWXrLPjpj/fPvi3BfBYG56c12V2
TcyLUx/EmlNyQxaybQ27ShLd5m2paGEjIu1FF6fr3+kn0LGnGyVjJjyLZQChHHBf
p1hIYZhbKhlJAfWXANwdPOH8GAU+vzL3Cd6zqTzxcYHVB7jKdvVBNcfIHjbxjIoI
Oa3rOPSBGSPFmuMknoC2+tUVnoC1/RMZSIPy/j7/J2TPMHQv3YFaR29STMyykyYv
nvLht0405XwtEAezwImyrDWpBHqb8F654U9bBnLj7RFcqm/1YEV4mC9cEDDhDAZ8
98HhQLkJ0bIc/sNtgHllN9E9+3GFL7nzc2rm5kCMWVn7KF6fR+w1pcLHbNBIxoDp
rvH5qaeyMEvYFm86PiVB1tchTlyQCw6cG5YxpdaKtdzNtARsjCC+XpfC6SxCqDP5
6V7jHoN4DC/7ov/6vqd1Gu46g3tNW26JoIuMnNG3xg==
=5Zb5
-----END PGP SIGNATURE-----

--EKVAqSiJrohY0G8j--

