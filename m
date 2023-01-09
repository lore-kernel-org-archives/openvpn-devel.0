Date: Mon, 9 Jan 2023 09:26:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7vPuxKfZ5AbAJKb@...1296...>
References: <20230105175614.405385-1-arne@...1227...>
 <20230106143841.506504-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YwrCjc6UAx7Q4o7w"
Content-Disposition: inline
In-Reply-To: <20230106143841.506504-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add connect-freq-initial option to
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

--YwrCjc6UAx7Q4o7w
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 06, 2023 at 03:38:41PM +0100, Arne Schwabe wrote:
> Patch v2: use strtol instead of atoi to be able to differentiate between
>           an error parsing and parsing 0. Use int64_t instead int to
>           avoid overflow errors.

I find this easier to read, so thanks.

This said...

> +        /* Check if we are still below our limit for sending out
> +         * responses */
> +        if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
> +        {
> +            return false;
> +        }

This does "we kill the packet if reflect_filter returns false(!)".

[..]
> +bool
> +reflect_filter_rate_limit_check(struct initial_packet_rate_limit *irl)
> +{
[..]
> +    return irl->curr_period_counter > irl->max_per_period;
> +}

This does "return false *while under the limit*".

So it kills all UDP for me.

2023-01-09 09:03:01 us=3D694540 rrl: curr_period_counter=3D1, max_pp=3D100
2023-01-09 09:03:01 us=3D694598 connection killed by reflect_filter
2023-01-09 09:03:17 us=3D494917 rrl: curr_period_counter=3D1, max_pp=3D100
2023-01-09 09:03:17 us=3D495003 connection killed by reflect_filter
2023-01-09 09:03:22 us=3D773712 rrl: curr_period_counter=3D2, max_pp=3D100
2023-01-09 09:03:22 us=3D773773 connection killed by reflect_filter
2023-01-09 09:03:25 us=3D243757 rrl: curr_period_counter=3D3, max_pp=3D100
2023-01-09 09:03:25 us=3D243827 connection killed by reflect_filter


Turning around the condition in reflect_filter.c

 +    return irl->curr_period_counter < irl->max_per_period;

makes things well-behaved - as in, normal connections succeed, excess
RESET_V3 fail - tested with your sendOvpn.py

$ python3.9 sendOvpn.py 1000
generating packets
creating sockets
Round 0
sending packets
sleeping
99 packets received

2023-01-09 09:22:47 us=3D429929 Connection Attempt Dropped 900 initial hand=
shake packets due to --connect-freq-initial 100 10


While at it, I wonder if it would be a useful addition to do a single
message if the rate limiter kicks in, like this

    if ( irl->curr_period_counter =3D=3D irl->max_per_period )
    {
	msg( M_WARN, "connect-freq-initial rate limiter activated, dropping incomi=
ng UDP for the next %d seconds",=20
            (irl->last_period_reset + irl->period_length)-now );
    }

we do have a log entry after the end of the period, but that might be an
arbitrary time ("when the next packet comes in") further down the log,
with no indication why OpenVPN decided to play dead at this point.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YwrCjc6UAx7Q4o7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJju8+7AAoJEB2Cnv7KVigSfzUL/00yxkdQYwX++PCxwwunAbHe
WJ9IWN+Y8JTPHPK+mV6tpVd0sHaS5u1nUQlJQl7eGQz6VgOmvxDjMAyh1Y6BBGqz
6VEheIaG5xKgwSFcBLwk3JDRwtwkouek6GtHyRffiZrhxWuer5ZDzyUGokvdVszF
JeX4vrCrKgM2feuyb3myCK5z39ndfnCWuYn4nTfOJ3QZ3j5jbxn/DpWgkn4aWHsQ
fYTkZuRWUiAmqPoVhfYPc1UQCBud6U3nCcM4Gsj3CDGLcgq/Z0jS43cSVF9R6fvx
E0AfdE6sHnkKNOVKHc3FFhE6PPsEV+3GM5Hz+Q/Unq6XEBNKMGohzT6ukqlNQSJo
pn83G365DWWs4CA4dGHIRqu/GKrVN2ISJCq1C2bkz0nEVqzQopVYPHUlsmbzEJih
aJyqngP5v6MGUWWKYVb8/CIctotQbcXe1TBh5LG2PcoxcLAtAAFJ/oeVHLdHGsQs
XSdR8Wa/c1TREzPuI3P1TSkRjY0551NY6dJkY7g74w==
=Jd6M
-----END PGP SIGNATURE-----

--YwrCjc6UAx7Q4o7w--

