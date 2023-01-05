Date: Thu, 5 Jan 2023 22:11:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7c88NI9HQj64Bto@...1296...>
References: <20230105175614.405385-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uustsK6hgIcDQxF1"
Content-Disposition: inline
In-Reply-To: <20230105175614.405385-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add connect-freq-initial option to
 limit initial connection responses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--uustsK6hgIcDQxF1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

first of all, feature-ACK, and "structure-ACK" - this is a lightweight
implementation that can go into 2.6 with not much testing, which should
"get the thing done" for most cases.  A more sophisticated implementation
with per-IP hashing (to avoid (ab-)using the rate-limiter to drown-out
legitimate clients) can follwo for 2.7.

This said, most of the code looks good, except for this part:


On Thu, Jan 05, 2023 at 06:56:14PM +0100, Arne Schwabe wrote:
> index ee3783046..cf8622f46 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -864,6 +865,8 @@ init_options(struct options *o, const bool init_gc)
>      o->n_bcast_buf =3D 256;
>      o->tcp_queue_limit =3D 64;
>      o->max_clients =3D 1024;
> +    o->cf_initial_per =3D 10;
> +    o->cf_initial_max =3D 100;

... so this is on-by-default...

> @@ -2613,6 +2618,10 @@ options_postprocess_verify_ce(const struct options=
 *options,
>          {
>              msg(M_USAGE, "--connect-freq only works with --mode server -=
-proto udp.  Try --max-clients instead.");
>          }
> +        if (!proto_is_udp(ce->proto) && (options->cf_initial_max || opti=
ons->cf_initial_per))
> +        {
> +            msg(M_USAGE, "--connect-freq only works with --mode server -=
-proto udp.  Try --max-clients instead.");
> +        }

... and if it is enabled for !UDP modes, we'll refuse cooperation.

But wouldn't that trigger for *all* TCP servers now, since it defaults
to "active"?

Besides that, the "--connect-freq" there is wrong and needs to be=20
"--connect-freq-initial" ;-)

[..]
> +    else if (streq(p[0], "connect-freq-initial") && p[1] && p[2] && !p[3=
])
> +    {
> +        int cf_max, cf_per;
> +
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        cf_max =3D atoi(p[1]);
> +        cf_per =3D atoi(p[2]);
> +        if (cf_max < 0 || cf_per < 0)

" < 0 " or " <=3D 0"?

> +        {
> +            msg(msglevel, "--connect-freq-initial parms must be > 0");
> +            goto err;
> +        }

... because the inverse of ">0" is not "<0"...

> +        options->cf_initial_max =3D cf_max;
> +        options->cf_initial_per =3D cf_per;
> +    }

... now we could of course document "0 turns it off", but then the
message needs to be ">=3D 0".

> +bool
> +reflect_filter_rate_limit_check(struct initial_packet_rate_limit *irl)
> +{
> +    if (now > irl->last_period_reset + irl->period_length)
> +    {
> +        int dropped =3D max_int(irl->curr_period_counter - irl->max_per_=
period, 0);
> +        if (dropped > 0)
> +        {
> +            msg(D_TLS_DEBUG_LOW, "Dropped %d initial handshake packets d=
ue to "
> +                "--connect-freq-initial %d %d",
> +                dropped, irl->max_per_period, irl->period_length);
> +        }
> +        irl->last_period_reset =3D now;
> +        irl->curr_period_counter =3D 0;
> +    }
> +    /* avoid overflow by capping the counter to INT_MAX -1. Still counti=
ng
> +     * the number of packets during a period is still useful */
> +    irl->curr_period_counter =3D min_int(irl->curr_period_counter + 1, I=
NT_MAX - 1);

This looks uglysh.

With a 10-seconds bucket, an (32bit) "int" would overflow at about
430 million packets per seconds - which is, I think, way beyond what
any reasonable system can handle (10G ethernet saturates at 15 Mpps).

But if you are really worried about overflows - why not use a (64bit)
long here?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uustsK6hgIcDQxF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjtzzwAAoJEB2Cnv7KVigSbw0L/RtfO5yrccYFZkbJyoyy5Uk9
vDoLoN9kUEAWSCwjcM8MGyghkg/jhq11tlNBkEzuYyEjUGuLeGRMP8JL7DNir0Ge
ZFNeSofd5KATPfdFSMYYjhCMSWonqspAGK5uGd8iuuKW+g7DAWxAJRLiIHLQDKBN
D2yXqd+yZL4DdCvBNxzb58hDGVIX9UTxT9V5W+mYFOCNQE6kmAxCmimyHUEneEJe
/cncGkMTLhLPFwz+F2GWhWHfTWLmJPIrEw/bGED1f/dTCtYJbUEZv9DODJBz04Xt
VxxQNTNZVP6apNmiocnVGNaUgPT3krE6Ja0QhzXa76U0hL96Er9g/LBJ0Lzb1qa+
lMe4tJp9dXcwu7ictBLuGzlgrYgOAngAgeLjq5/ypkC7x0A0MX8tO7RguQvHbj3u
lpaookC16EiniHl9X7M585m3IRgkdClK//p5uvj/isKjLuThbkLPrOSHDQgXKdVu
sowXb7XYdfPmG7EgrICGzRXlOvHDo+KjbOg2wjeB5w==
=YRQL
-----END PGP SIGNATURE-----

--uustsK6hgIcDQxF1--

