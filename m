Date: Mon, 17 Oct 2022 11:20:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y00eYY2U2Zirhi4X@...1296...>
References: <20221007153823.1334940-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LddJO9b3Fb4Dj9h4"
Content-Disposition: inline
In-Reply-To: <20221007153823.1334940-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Allow Authtoken lifetime to be short
 than renegotiation time
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

--LddJO9b3Fb4Dj9h4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm working through this, and have some questions...

On Fri, Oct 07, 2022 at 05:38:23PM +0200, Arne Schwabe wrote:
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 6a45b9e91..eca4a4335 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -195,9 +196,15 @@ check_tls(struct context *c)
>=20=20
>      interval_schedule_wakeup(&c->c2.tmp_int, &wakeup);
>=20=20
> -    /* Our current code has no good hooks in the TLS machinery to update
> +    /*
> +     * Our current code has no good hooks in the TLS machinery to update
>       * DCO keys. So we check the key status after the whole TLS machinery
>       * has been completed and potentially update them
> +     *
> +     * We have a hidden state transition from secondary to primary key b=
ased
> +     * on ks->auth_deferred_expire that DCO needs to check that the norm=
al
> +     * TLS state engine does not check. So we call the doc check even if
> +     * tmp_status does not indicate that something has changed.
>       */
>      check_dco_key_status(c);
>=20=20

This seems unrelated to auth-token, but "escaped from the P2P DCO rework".

I suggest to ignore that hunk.

> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index f1cade2ef..db0a96cc9 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -624,6 +625,10 @@ struct tls_multi
>                            *   user/pass authentications in this session.
>                            */
>      char *auth_token_initial;
> +    /**< Last time an auth-token was generated, this is strictly speakin=
g redundant
> +     *  as the auth_token attribute already contains the information but=
 in a
> +     *  highly encoded way */
> +    time_t auth_token_lastgenerated;
>      /**< The first auth-token we sent to a client. We use this to rememb=
er
>       * the session ID and initial timestamp when generating new auth-tok=
en.
>       */

This is not used at all.  I suspect this was coming from an initial
approach and later all was done based on event handling.

I suggest to ignore that hunk as well.


The rest looks reasonable (and I'm halfway through applying it, so
no need for a v2, just an "yes, please ignore those hunks").

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LddJO9b3Fb4Dj9h4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjTR5hAAoJEB2Cnv7KVigSTPoL/3q2PqKmJONGicGwQxoEpAPu
V9P/qSa5XLfXJ9w9VJ6QmARlnY9PrqPLDZGcohhblA34sOjR6vUulP7dt+7KW6PC
ZKbYQJG2OBpoyPKLv07C/4/U4n3xErqpVu97bRTTQoydmjax3qZe5oTZAl74xIcB
sd+MNDcgKG2gnTclC1bAKfnMjob600DUqW/O/+ZhmNJSIIyHNQQlXtMBTXn+ljc3
w76dsHeTaa+Z4A0fbpljMdx0wkCItk9OBN2Zzps0AfGv0MAgOR48jJ8SM7kHPBP2
nAMUDTCgXB1xMS2MJJAt5/cL22lDlsBAxA7pDjG1668/NtrtITShn20dSMobIPKj
rTfLCdReRRfT4dqownpiO0GK4Sph60XLii4r3gBFuFZHkGAm7aLho+0QElg37Jal
D4bE8/7TIsldJs3zOx0f2hf1NBfpkQPAHHwQOR/oM+dmlGGEDV1jCg0zwOqzT3qA
35yBzdZYxzCTNHu8SkvShs4ohtAVOl1bmosoav9oIA==
=vbiX
-----END PGP SIGNATURE-----

--LddJO9b3Fb4Dj9h4--

