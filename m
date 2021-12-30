Date: Thu, 30 Dec 2021 18:03:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yc3mWkIMThR8Vqg+@greenie.muc.de>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-10-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SVqZMHZV2ko4Iuod"
Content-Disposition: inline
In-Reply-To: <20211207170211.3275837-10-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 09/21] Rework occ link-mtu calculation
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

--SVqZMHZV2ko4Iuod
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 07, 2021 at 06:01:59PM +0100, Arne Schwabe wrote:
> Use the functions that directly compute the link mtu instead relying on t=
he
> frame logic.
[..]
> --- a/src/openvpn/mtu.c
> +++ b/src/openvpn/mtu.c
> @@ -61,6 +61,8 @@ frame_calculate_protocol_header_size(const struct key_t=
ype *kt,
>      /* Sum of all the overhead that reduces the usable packet size */
>      size_t header_size =3D 0;
>=20=20
> +    bool tlsmode =3D options->tls_server || options->tls_client;
> +
>      /* A socks proxy adds 10 byte of extra header to each packet */
>      if (options->ce.socks_proxy_server && proto_is_udp(options->ce.proto=
))
>      {
> @@ -74,7 +76,10 @@ frame_calculate_protocol_header_size(const struct key_=
type *kt,
>      }
>=20=20
>      /* Add the opcode and peerid */
> -    header_size +=3D options->use_peer_id ? 4 : 1;
> +    if (tlsmode)
> +    {
> +        header_size +=3D options->use_peer_id ? 4 : 1;
> +    }

We need a v2 of this - these two hunks are already in master.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--SVqZMHZV2ko4Iuod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhzeZaAAoJEB2Cnv7KVigSPxkL/jP3JZiFd7UDdOPwfv9z+b4R
9mJruhTXZEj56EMk92d1E4xg9GZzo+p00UdtewvazpSAuJpox4JkES5B5iS1Qv8z
+k4VB/RMGIc5F3oA/RBVI/eyKPZlocHo68dZHi2ZbbZd6xgFaxWKRwu4RrAb2Usu
6BRjq+hHDhndndobd6/RlcvPqrDVDOFvvdc/84PcH4Mv4edJA+rULS2ymcX+GNdE
zL0d59YIAXLB8hnYxmtlf6cDl49bbyAVte16ec7/lfEJPiudTbowublO5u9a2Evm
Bnko3BRxGGTfvz58CnnifuuX6wHmTnOG+GTo+vVEYJ1GPrd0tu9vPuwU5g2Z74h0
wVA3w4wuU077MHEDE54xtFeeqjYQfKV1L4j7f4QBasa6WHXCQh9U6erAAM6hQ6Ib
Oe7VdiOmjXpjIAvhpl6rNQuC/LKGUvY7YGNrmmin6FM1r0TghmQTHqoDJm2sDeWY
jUaP14ykCCKk+atBO24t81PlX9VlTIEQHWKoTRlm4w==
=doX5
-----END PGP SIGNATURE-----

--SVqZMHZV2ko4Iuod--

