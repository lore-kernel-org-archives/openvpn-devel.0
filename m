References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <20181010143051.27163-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ae73b99c-69b5-d472-640c-64aed0fda0d6@...2181...>
Date: Fri, 7 Dec 2018 17:13:32 +1000
MIME-Version: 1.0
In-Reply-To: <20181010143051.27163-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="b3ncjFnnsfClqLRcUb1puYCOxuL7B8iRt"
Subject: Re: [Openvpn-devel] [PATCH v5] Revert to original password
 authentication after failed auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b3ncjFnnsfClqLRcUb1puYCOxuL7B8iRt
Content-Type: multipart/mixed; boundary="Ta9qDqEecCrdtrIBoglt2VmdawrlWopUl";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ae73b99c-69b5-d472-640c-64aed0fda0d6@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v5] Revert to original password
 authentication after failed auth-token
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <20181010143051.27163-1-arne@...1227...>
In-Reply-To: <20181010143051.27163-1-arne@...1227...>

--Ta9qDqEecCrdtrIBoglt2VmdawrlWopUl
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On 11/10/2018 00:30, Arne Schwabe wrote:
> Auth-tokens can expire. For by reconnecting when the server uses
> auth-gen-toke.
>=20

The sentence above should be adjusted a bit before the patch is merged.

> Behaviour of OpenVPN client is to never fallback to the previous
> authentication method and continue using the auth-token. Depending on
> auth-retry it either quit or tried endlessly with an expired
> token. Since auth-gen-token tokens expire on reconnect, a client will
> not survive a reconnect.
>=20
> This patches changes the behaviour on failed auth when using an
> auth-token as a soft error (USR1) and clean the auth-token falling
> back to the original auth method.
>=20
> Patch V2: properly formatted commit message, fix openvpn3 detection
>=20
> Patch V3: remove all server changes, include only minimal non
> intrusive client changes that only improve error recovery but don't
> change overall behaviour.
>=20
> Patch V4: forget add push.c to git index, now also included
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

The patch does what it says and it nicely separates where the "password"
and the "token" are stored.
This has the advantage of making the code slightly easier to follow.

I performed a simple test with a server and a client configured for
using auth-gen-token:
- client connected to the server
- authentication with user/pass is successful and I see the token being
pushed
- server is restarted
- client waits its ping timeout and then softly restarts
- client fails with AUTH_FAILED:

Fri Dec  7 17:03:08 2018 us=3D203818 AUTH: Received control message:
AUTH_FAILED
Fri Dec  7 17:03:08 2018 us=3D204210 TCP/UDP: Closing socket
Fri Dec  7 17:03:08 2018 us=3D204322 SIGUSR1[soft,auth-failure
(auth-token)] received, process restarting
Fri Dec  7 17:03:08 2018 us=3D204391 Restart pause, 5 second(s)

- client softly reconnects
- authentication is successful with user/pass again and a new token is
pushed.

Acked-by: Antonio Quartulli <antonio@...515...>


--=20
Antonio Quartulli


--Ta9qDqEecCrdtrIBoglt2VmdawrlWopUl--

--b3ncjFnnsfClqLRcUb1puYCOxuL7B8iRt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlwKHZwACgkQ9FVsWUWD
Dm2itA//SAx5FH5Gi8KH1KMhr3usAs/QVq0LvnwV+Le2JptqM6P/R4DV5/FFBPrj
+8CulrfzhYsmfcS6EM7rWYZWHNG3Mkr+BzQeTHhEKHIGC0h3MQFYse3CYSJyPBxz
ri1UWkxKgwegJCfGsanRECEQaUSXzkulgbii8lJKwXmT9bpzcXSoM5lLiiemIewy
7bANyLcyp5eCQK5X9kqWCuLtYgEgF6lHHzLdM7zmRp4nbXH0ZfkAoQzW32pE/IE5
nhetd3q0c0kaoF7T+MOvLXHc+Mbc6N7xKZgM1oHydKlfoKLnxqG32pI0zlx2ppDH
fTXkWtzRLWievihqRO8UV115u7xvk6IeiKIhabyuFJ3/7k1RDTkZMR0nSwBZDoQB
PV90VaXH2uFvqomjmRcqWt0LjBVkjXWnH4saHb7gRnMIkb0hDjl0gGkOMcoA81Ks
rCFYOReQhmfZ2WnoQsHebKrzHw80Ge6jVq5dK4JLGwFlp7znWX3fYMPSU6WJhsW8
35s76MZ7qvoGQAfdS6UeB+VbPadze+r9yRBOHaweyj+dVa6zDxUkC5d/pxpl+iWq
SFc4OTBQHZUS+F6XGopnCQ/FGNwa5JIrseTjMbiiBsB1NspQjgA7ptU6SZNEw5KZ
DQ3dH9W/ckaISnrQWv2taQQVNM7tQCL6v9jtwggBFBd/qPcOMes=
=7T+5
-----END PGP SIGNATURE-----

--b3ncjFnnsfClqLRcUb1puYCOxuL7B8iRt--

