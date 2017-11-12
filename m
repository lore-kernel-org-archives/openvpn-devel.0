References: <20171111160359.28078-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ed338010-2918-fb1d-27e0-116712651b87@...2181...>
Date: Sun, 12 Nov 2017 23:33:49 +0800
MIME-Version: 1.0
In-Reply-To: <20171111160359.28078-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="II3V4sjEK9de0D08U2v0ikajtURsgw07H"
Subject: Re: [Openvpn-devel] [PATCH] Use P_DATA_V2 for server->client
 packets too
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--II3V4sjEK9de0D08U2v0ikajtURsgw07H
Content-Type: multipart/mixed; boundary="EmGmuXue3ETdptcALnuRHuf6gRoLbDpHB";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ed338010-2918-fb1d-27e0-116712651b87@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Use P_DATA_V2 for server->client packets
 too
References: <20171111160359.28078-1-steffan@...1856...>
In-Reply-To: <20171111160359.28078-1-steffan@...1856...>

--EmGmuXue3ETdptcALnuRHuf6gRoLbDpHB
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/11/17 00:03, Steffan Karger wrote:
> P_DATA_V2 introduced the peer-id.  This allows clients to float, but as a
> side-effect 32-bit aligns the encrypted data.  That alignment improves
> performance particularly on cheaper/older CPUs.  So although servers don't
> actually have a peer-id, still use the V2 packet format (with a zero-id)
> for server->client traffic too.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/forward.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 1b7455bb..20e89d34 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -496,7 +496,7 @@ encrypt_sign(struct context *c, bool comp_frag)
>          /* If using P_DATA_V2, prepend the 1-byte opcode and 3-byte peer=
-id to the
>           * packet before openvpn_encrypt(), so we can authenticate the o=
pcode too.
>           */
> -        if (c->c2.buf.len > 0 && !c->c2.tls_multi->opt.server && c->c2.t=
ls_multi->use_peer_id)
> +        if (c->c2.buf.len > 0 && c->c2.tls_multi->use_peer_id)
>          {
>              tls_prepend_opcode_v2(c->c2.tls_multi, &b->encrypt_buf);
>          }

NAK.
Although the patch looks good and easy, it is actually missing an
important part: c->c2.tls_multi->use_peer_id is never set to true on the
server.

This should probably happen after parsing "IV_PROTO=3D" in
prepare_push_reply().


Cheers,

--=20
Antonio Quartulli


--EmGmuXue3ETdptcALnuRHuf6gRoLbDpHB--

--II3V4sjEK9de0D08U2v0ikajtURsgw07H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloIad0ACgkQB6U8WA7y
zXTLmA/+PPqFecXdimpVPyUbR9lA49ekpsPfyIRMI5uRmVOwQMu9QKncdx/eP9XQ
7OjkIwoENYOEHc5V9ZSa1WdqHDjnzk0OL+8jh+1BRHGeMHpLjQhGjnetGTqziwX4
bTO1FHiV5X35u0N/KwtR7mXhiKRcefUR/sZY3+8dqijsc8XwUdrfLNbPR5ApBNll
mycH/XrOBY1JcKTHpBcTQ/PFAVCcQEcaK0Y4HQdglru4QkMVDH/IQbbiTaSQwibL
zf0veqp4C/u0DcA2GGmPWHiDwNYqdAsqc8WjNnFJl9n2+sv4ZyaZB6wDXoQeov/w
GQ42V7HOvIKkpMM6MVKxuLo88jf8fyYQkQrtV/R9FyClMY5w5x26P6Q0kaAu3xFU
f2iEbPkyMkYwTzhoqely/DBKPfbBtj0F7hTvl5+E1SGweNH9MYcDjMMpqFCqGrgu
ZH0f3UH24DKXqspmFQO31S+h1zH9eTWFYr1yPXer96OJb24Yn4ZFXV9Ivf843NMO
il6+4TLDv1KmUXUWkoelLg379G48mOmExfMvtvXWM0wH2dlOBdx0bN+eVTqiis9i
NxwqrpYMFUEtnWifYb9J1Z5K4MdFg1IyX8DMBJQr0eOMrLtg73nPmhdwUgLfhIp8
g3Fe5/f0v3whvQLi4lDFM4uj3RaAAJV+6dy95uMJ6k5+j3bxMFI=
=Pgh8
-----END PGP SIGNATURE-----

--II3V4sjEK9de0D08U2v0ikajtURsgw07H--

