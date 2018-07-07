References: <20180707090421.25953-1-a@...2181...>
 <63f62036-3e45-0dce-da47-bc32cbd6db0f@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <260cdffe-2146-3760-1730-d0cc49086ba6@...2181...>
Date: Sun, 8 Jul 2018 00:25:28 +0800
MIME-Version: 1.0
In-Reply-To: <63f62036-3e45-0dce-da47-bc32cbd6db0f@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yNvbDYHtwJNUJowHRSsxiiRjLmjyW6TlW"
Subject: Re: [Openvpn-devel] [PATCH v4 1/2] crypto: always reload
 tls-auth/crypt key contexts
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
--yNvbDYHtwJNUJowHRSsxiiRjLmjyW6TlW
Content-Type: multipart/mixed; boundary="53XVR3s1fK7dh24rjDNPXD7w2ajxgTIMW";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <260cdffe-2146-3760-1730-d0cc49086ba6@...2181...>
Subject: Re: [PATCH v4 1/2] crypto: always reload tls-auth/crypt key contexts
References: <20180707090421.25953-1-a@...2181...>
 <63f62036-3e45-0dce-da47-bc32cbd6db0f@...1856...>
In-Reply-To: <63f62036-3e45-0dce-da47-bc32cbd6db0f@...1856...>

--53XVR3s1fK7dh24rjDNPXD7w2ajxgTIMW
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/07/18 20:45, Steffan Karger wrote:
> Hi,

[cut]

>> +static void
>> +free_buf_gc(struct buffer *buf, struct gc_arena *gc)
>> +{
>> +    if (gc)
>> +    {
>> +        struct gc_entry **e =3D &gc->list;
>> +
>> +        while (*e)
>> +        {
>> +            /* check if this object is the one we want to delete */
>> +            if ((uint8_t *)((*e) + sizeof(*e)) =3D=3D buf->data)
>=20
> I think this should be sizeof(**e).
>=20

Right! Thanks for catching this!

[cut]

>> +/**
>> + * buffer_read_from_file - copy the content of a file into a buffer
>> + *
>> + * @param file      path to the file to read
>> + * @param gc        the garbage collector to use when allocating the bu=
ffer. It
>> + *                  passed to alloc_buf_gc() and therefore can be NULL.
>=20
> It *is* passed ?
>=20

of course :-) thanks!

[cut]

>=20
> Otherwise, this looks good.
>=20

Cool, thanks!

I will send v4 with these small fixes and a unit test for the
buf_free_gc() function.


Cheers,


--=20
Antonio Quartulli


--53XVR3s1fK7dh24rjDNPXD7w2ajxgTIMW--

--yNvbDYHtwJNUJowHRSsxiiRjLmjyW6TlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltA6XgACgkQB6U8WA7y
zXRMkw//X3032lVXUBqxZ4dVJuB0v6Lq3eHujDLlGOus+ZFfO4MCEyMkzd8Lfb8K
fraf62bcpb13I8qCSI1w6wZPrFMgkAbeL69OKnL8dUfzWCOGL9Y1ccg6U0Lqn3L5
NdolnUQwt0nR9UuvrrZ9AlejHu+v+Y+O+qed1B4rivJAfwdNaUAYv1/l54E5SHVP
ie1QcEXXwqz2nQ8d8MfG4KHL7PUiIogtPn8qXQYjtY44k7iah4o6nMGH/blq2zPi
foxmxy8T7FdF3rdRtIi/783UatZOHnE6TPPHOfghxbUefhLjbEu8fy1Omd65FMTc
rW5zDmhuSOydvElfojxDK/qd92JWNQCMqff31WKw2be0F9VvPjMHxfm+ofJgqmT7
uT+P462O65+ubbVKFH/ovuBRFwm4K4A3FSQMLvnItpM3BjaOuS42nqHWf9Qe9voB
1Px/BannUNAGfxAjbzCr3LFA2F66DlvRv/Gp+ke4fuOvnj+kEK6Jz+zipAFGg70c
mR1RH5d3U4q1bNtXSIWqSiwbF7UGXGbRI70u+hZr+fiY35/PaLI424pN2jbMffSk
b0v2lIXP7LbSYHZj4JLjfEN286Q2zAdHTxGE+EkKabjjzk/cXwaqxJeCu8SbHB7Y
XJTd8eE9cb+nMsFjbR2spCfpjdb28KnnlW2GelWe2LVbD8Hj6Xc=
=795h
-----END PGP SIGNATURE-----

--yNvbDYHtwJNUJowHRSsxiiRjLmjyW6TlW--

