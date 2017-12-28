From: Antonio Quartulli <a@...2181...>
References: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
 <1498913642-32459-4-git-send-email-steffan.karger@...1435...>
Message-ID: <e063898a-6b6c-d716-824f-8e10b859d692@...2181...>
Date: Fri, 29 Dec 2017 06:51:23 +0800
MIME-Version: 1.0
In-Reply-To: <1498913642-32459-4-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j37zgVDO9mEv5NbQWCWqNWN8NbzoJEoTg"
Subject: Re: [Openvpn-devel] [PATCH 4/5] buffer_list_aggregate_separator():
 prevent 0-byte malloc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j37zgVDO9mEv5NbQWCWqNWN8NbzoJEoTg
Content-Type: multipart/mixed; boundary="S3T2OBOEEudvz18WdsLc8aWMRaEt0EutK";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e063898a-6b6c-d716-824f-8e10b859d692@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] buffer_list_aggregate_separator():
 prevent 0-byte malloc
References: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
 <1498913642-32459-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1498913642-32459-4-git-send-email-steffan.karger@...1435...>

--S3T2OBOEEudvz18WdsLc8aWMRaEt0EutK
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 01/07/17 20:54, Steffan Karger wrote:
> As pointed out in finding OVPN-05 of the cryptograpy engineering audit
> (funded by Private Internet Access), buffer_list_aggregate_separator()
> could perform a 0-byte malloc when called with a list of 0-length buffers
> and a "" separator.  If other could would later try to access that buffer
> memory, this would result in undefined behaviour.  To prevent this, always
> malloc() 1 byte.
>=20
> To simplify as we go, use alloc_buf() to allocate the buffer.  This has
> the additional benefit that the actual buffer data (not the contents) is
> zero-terminated, because alloc_buf() calls calloc() and we have 1 extra
> byte of data.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>


Does it really make sense to continue the execution if we receive a list
of empty buffers? Shouldn't we report this as an error?


> ---
>  src/openvpn/buffer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index 2700ad1..ecbdc1b 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -1261,8 +1261,7 @@ buffer_list_aggregate_separator(struct buffer_list =
*bl, const size_t max_len,
>              struct buffer_entry *e =3D bl->head, *f;
>=20=20
>              ALLOC_OBJ_CLEAR(f, struct buffer_entry);
> -            f->buf.data =3D malloc(size);
> -            check_malloc_return(f->buf.data);
> +            f->buf =3D alloc_buf(size+1); /* prevent 0-byte malloc */

the '+' sign should be surrounded by spaces.


Cheers,

>              f->buf.capacity =3D size;
>              for (i =3D 0; e && i < count; ++i)
>              {
>=20

--=20
Antonio Quartulli



--S3T2OBOEEudvz18WdsLc8aWMRaEt0EutK--

--j37zgVDO9mEv5NbQWCWqNWN8NbzoJEoTg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpFdWsACgkQB6U8WA7y
zXSo+BAAh8r19pZSUX0XPHwu2Bp6FDYYoJESNJLU4IFO97wGNgwzgFG4XzN/+4pl
dtg4+1mP1WY9URLqY+uT1BdwtJI5TskaxKHpVUH/FOhjNaJNzcKUH6HyeIOb/9+y
B4dxbEN3I0MmRZ4282fYQornpvf0uSzQz/nAI6Ncv4eH+IIbk79BaIWaTyl8+tAm
rLgACdqw+tc61OFmog4sq8vMdmYY901ap826EziYw+zZQ2bVSvV1gT5Uc/NZPtwb
CbFLvLmM2xcYDKis+VL7F+aG3JlshDFT3AzCVYKMnFblVehOkP459KgLP9R9h6FT
kYtZhxLmrdEfag5I08bZb8RMvGYgY6mSX0y3i05568eN8vveSNnH3RcqBskX8JNs
Z8rUp6gsRhuhOdbO/+8EO5qGrS/HNIgBQg6tyG/wbvy4leQnT0iE2jyfXQGVt5gu
5OGJAHCD0mVMdb3u2+nQxEvR1XCFdM5Q0itMCNuttl2mUcnGkYQMTjIzDzFfFhKe
2V96sAGlFaQq72oCZpbEtib6k5YwyaYlew9RvFafvOO1rSonbY4ZOHpn2p9a4znL
tTFmO2O/zSnhYO3Xz2iJxz+Sjp4UUWxhIrsreuBPuvP+ZD0I8xPkVbO2ZkUwG+dA
+TLHr3ydaQNvR9PHNFmcD31GNUNEJqrMFqHtXjF1P2ZkEKuzB8c=
=pj6T
-----END PGP SIGNATURE-----

--j37zgVDO9mEv5NbQWCWqNWN8NbzoJEoTg--

