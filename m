Date: Thu, 14 Jul 2022 16:27:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YtAn53rzl8hUkECA@...1296...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-7-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1TsBPj1t1QgE4rsz"
Content-Disposition: inline
In-Reply-To: <20220624083809.23487-7-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 06/25] dco: initialize context and save
 pointer in TLS object
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

--1TsBPj1t1QgE4rsz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2022 at 10:37:50AM +0200, Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/init.c       | 49 ++++++++++++++++++++++++++++++++--------
>  src/openvpn/ssl_common.h | 23 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 9 deletions(-)

Without trying to understand the code flow in init.c, is there a
deeper reason why this happens twice?

> @@ -1708,6 +1717,12 @@ do_open_tun(struct context *c)
>      /* initialize (but do not open) tun/tap object */
>      do_init_tun(c);
>=20=20
> +    /* inherit the dco context from the tuntap object */
> +    if (c->c2.tls_multi)
> +    {
> +        c->c2.tls_multi->dco =3D &c->c1.tuntap->dco;
> +    }
> +
[..]

> @@ -2979,12 +2999,20 @@ do_init_crypto_tls(struct context *c, const unsig=
ned int flags)
[..]
>      /*
>       * Initialize OpenVPN's master TLS-mode object.
>       */
>      if (flags & CF_INIT_TLS_MULTI)
>      {
>          c->c2.tls_multi =3D tls_multi_init(&to);
> +        /* inherit the dco context from the tuntap object */
> +        if (c->c1.tuntap)
> +        {
> +            c->c2.tls_multi->dco =3D &c->c1.tuntap->dco;
> +        }
>      }

... and here again, but only sometimes?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1TsBPj1t1QgE4rsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi0CfnAAoJEB2Cnv7KVigS7TEL/R0sV+Nsll0bPn8HhUd6jRoD
R0kRXGm+l6anyaDDnCSI4FrTHcE8lXWMYsSTUpj/WEjXjr0PtsUXm5ER6KEOpfng
eUTE08o7aaABzTUn2K9OPqRVkXo/e416x6IzlsmpA+L3FqwKl7g6cZyZuNPMzDKG
vrzTxBpG/ZsdmRNoLJXrddl31HM5kgVUgnOV8a5YT82iYgk2PJ0QAPD476lPQ5sF
1Uf4NYigqpLuoX704hIM89jHJKDvy4IBBSFtYpkxnnDGQkBdT5D79Q2cAASbOnMu
Jntob1EAY0B+iYV9VHV5VOQGPN2sX984SVI5FA1LzyBnguOMLHnNCm042ZClzz5h
kGMrKi4RM5Em5HKH2wo5Za05UgdBVCIbZV+06gpVgc7ZqeIKHJN6BU1nyoVpXKQd
ee/uMe+MJRURjRewzOx8YB+LflQWu1j9wMZ0y6hc5xrBztXVPRa/zEXZKl2PU09W
pgBKUNfXJ9H9f/AxRrUwiFihgwWfRPYz9Y1Uyq8iAw==
=M3LK
-----END PGP SIGNATURE-----

--1TsBPj1t1QgE4rsz--

