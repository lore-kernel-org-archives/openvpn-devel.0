References: <20180605081407.6944-1-a@...2181...>
 <7b4f4995-3474-8f77-14ba-bf9d0c236446@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d0292cbf-aed5-7be5-0dc5-45f622775fb8@...2181...>
Date: Fri, 6 Jul 2018 10:15:23 +0800
MIME-Version: 1.0
In-Reply-To: <7b4f4995-3474-8f77-14ba-bf9d0c236446@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0GC1mEwkZvwhzikwJvwznPzOnRgSkn4sA"
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] crypto: always reload
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
--0GC1mEwkZvwhzikwJvwznPzOnRgSkn4sA
Content-Type: multipart/mixed; boundary="6EXeHfKP3IVo5FvvCsZbw17OKspNLuLWA";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <d0292cbf-aed5-7be5-0dc5-45f622775fb8@...2181...>
Subject: Re: [PATCH v3 1/2] crypto: always reload tls-auth/crypt key contexts
References: <20180605081407.6944-1-a@...2181...>
 <7b4f4995-3474-8f77-14ba-bf9d0c236446@...1856...>
In-Reply-To: <7b4f4995-3474-8f77-14ba-bf9d0c236446@...1856...>

--6EXeHfKP3IVo5FvvCsZbw17OKspNLuLWA
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffan and thanks for the review,

On 06/07/18 04:22, Steffan Karger wrote:
>> +struct buffer
>> +keyfile_to_buffer(const char *file, int max_size, struct gc_arena *gc)
>> +{
>> +    size_t size;
>> +    struct buffer in =3D alloc_buf_gc(max_size, gc);
>> +    int fd =3D platform_open(file, O_RDONLY, 0);
>> +    if (fd =3D=3D -1)
>> +    {
>> +        msg(M_ERR, "Cannot open key file '%s'", file);
>> +    }
>> +
>> +    size =3D read(fd, in.data, in.capacity);
>> +    if (size < 0)
>> +    {
>> +        msg(M_FATAL, "Read error on key file ('%s')", file);
>> +    }
>> +
>> +    if (size =3D=3D in.capacity)
>> +    {
>> +        msg(M_FATAL, "Key file ('%s') can be a maximum of %d bytes", fi=
le,
>> +            (int)in.capacity);
>> +    }
>> +    close(fd);
>> +
>> +    in.len =3D size;
>> +
>> +    return in;
>> +}
>=20
> Hm, I don't really like the FATAL errors in a function that looks
> generic enough for someone to use in non-startup situations.  In that
> case the FATALs might create a DoS vector.  Or, think ahead to the
> connection blocks, a connection starting, then timeing out, then exiting
> because the tls-auth/crypt key of the next connection block doesn't
> exist (instead of just trying the next block).
>=20

You're right. I made an assumption about the context where it'll be
used, but you're right, I shouldn't do it. I'll remove the FATAL.

> While reading this, I realize I wrote a very similar function in the
> "tls-crypt-v2: generate client keys" patch.  That one uses
> platform_stat() to figure out the size and get rid of the maxlen
> argument, and doesn't throw fatal errors.  Feel free to use that
> implementation if you like it, or not if you don't (and I'll use yours
> in the latter case).

Oh Right, thanks for pointing this out.
I'll use your implementation as it is relying more on buffer APIs, while
I am dealing directly with the internals (and I prefer your approach).

I'll send v4 of this patch soon.

Thanks!


--=20
Antonio Quartulli


--6EXeHfKP3IVo5FvvCsZbw17OKspNLuLWA--

--0GC1mEwkZvwhzikwJvwznPzOnRgSkn4sA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAls+0MUACgkQB6U8WA7y
zXQf/Q//bJOKDCpLG71OFpyubI8JY2CtN8WIlcdQT/xKsfQkH/wuDJAYnZTm78gC
MymJkJAg+w7ktEozhfXlC0jPXn3SqbBt82ne8OrIBWf01QFc5yPkHVWcbc0ReAb/
DmN1C8VX9l+h1MIV7tg6dQp0G7cbwnBmI0PDUAzExGQh76nXj+r2JQr6paLXlsnE
THWebvZkuhwDIzO3RZ2Xk514gmvV8QDjr8OyVjdfwq+WtKkBXPUV0JVnQF1NqRJh
7zCtVUz4v/AV+T5/5racIb5tzkhOuYO/HGIWQFL4WlVLAcaus5z0lOxun8hxIj7b
BtrUGLTc8JVpE86DddDfgWS6/U4+8X9Q7MIVpqtoiqEcbg5Zq0QZhU2yo7VAo/QJ
mcmhYCrPm9SJ6Goq4aQ1A5vNt2goV1z9RC8wvQmPmkn+4qo6HimA05QwZKkTybTP
wvgDHPoHe9uF0HY6yTxrQqtbbCXZvCrWBcV6tvCfQT6Os+xwCD4J0EPKQrjd98/a
+aah5MVeWdLOxqGZmbc+CMppZMqHiraOTlFawVK0oIdXY3xyiJUrcyQkJMWxWsI7
QnjWCZwBXJxlqjbdYUTe9KnpskX1eCnmzYibWA1Awm9zhMBYNAUyahvoqEMvGR44
8+1517xFRtGHgPRje5Dk6DGTaPMiRCyPuAi0M98afsZuuz/mfVY=
=4dZY
-----END PGP SIGNATURE-----

--0GC1mEwkZvwhzikwJvwznPzOnRgSkn4sA--

