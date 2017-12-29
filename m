References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <7adfcf57-b3dd-0e6a-ced0-2767a5462699@...1435...>
 <c6a491fe-17d2-445c-e99d-511992c33f38@...2181...>
 <a6d2b0f3-7c8f-ed68-0398-a36392d846b0@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <1524c6d8-b74d-4e03-483d-e2ff8b7729bf@...2181...>
Date: Fri, 29 Dec 2017 19:00:08 +0800
MIME-Version: 1.0
In-Reply-To: <a6d2b0f3-7c8f-ed68-0398-a36392d846b0@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FdFkJne9goH8C5xwQBtfedhI9So9W3z9n"
Subject: Re: [Openvpn-devel] [PATCH] travis: use clang's -fsanitize=address
 to catch more bugs
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
--FdFkJne9goH8C5xwQBtfedhI9So9W3z9n
Content-Type: multipart/mixed; boundary="LGYvEmWcAMrbymuHQJ8zvgne4BTVdU6nv";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1524c6d8-b74d-4e03-483d-e2ff8b7729bf@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] travis: use clang's -fsanitize=address to
 catch more bugs
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <7adfcf57-b3dd-0e6a-ced0-2767a5462699@...1435...>
 <c6a491fe-17d2-445c-e99d-511992c33f38@...2181...>
 <a6d2b0f3-7c8f-ed68-0398-a36392d846b0@...1435...>
In-Reply-To: <a6d2b0f3-7c8f-ed68-0398-a36392d846b0@...1435...>

--LGYvEmWcAMrbymuHQJ8zvgne4BTVdU6nv
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/12/17 18:58, Steffan Karger wrote:
> On 29-12-17 11:32, Antonio Quartulli wrote:
>> On 29/12/17 18:00, Steffan Karger wrote:
>>> On 29-12-17 10:47, Steffan Karger wrote:
>>>> The clang address sanitizer is able to catch quite a number of=20
>>>> memory-related bugs, such add memory leaks and buffer
>>>> under/overruns. So, enable the address sanitizer for one
>>>> openssl and one mbedtls build.
>>>>
>>>> This would have caught the buffer list unittest memory leak
>>>> that <1512724338-22197-1-git-send-email-steffan@...1856...>
>>>> wants to fix.
>>>
>>> For reference, I've pushed this commit to my own gh fork.  This
>>> would be the result based on current master:=20
>>> https://travis-ci.org/syzzer/openvpn/builds/322839893\
>=20
>> your travis build is failing and throwing out quite some "errors".
>=20
>> I personally think we should fix them all before adding the new
>> sanitize flag, otherwise travis will just always fail until we fix
>> them all.
>=20
> You already ACK'ed the fix in
> <1512724338-22197-1-git-send-email-steffan@...1856...> ;-)
>=20
> But yeah, it would be nice to apply that fix before this patch.

woops, I didn't realize it was only that one :)
Even better!

Cheers,

--=20
Antonio Quartulli


--LGYvEmWcAMrbymuHQJ8zvgne4BTVdU6nv--

--FdFkJne9goH8C5xwQBtfedhI9So9W3z9n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpGIDgACgkQB6U8WA7y
zXRWghAAvh0CGKbp9MLKZFGQWd41kFODafH73sRBk7sdXQEAD+IQ+WeQDu2tE+Lj
aenSZNXvQgROgB4taONf1zyH8YXqVBhjWy2vnqu9nqFEaeSKddhBLwVyr1sIAP2Z
7E8IpHaXUdnAA/wvclrZBQPV68Md3njY+U++MzWJikVTowJsUUuRj52pW0tqcgs1
73GRFTGtmlpXher185Xwyolktc6CtWvBiusEYBW3v4sL9ySDowT7TRvuucU34Ooa
p51MFw6gspH6xZjRQ37GyqFEvNFlusC+1ZqNJPAFYdKYYnPuaYe+S7N1b8FVYvI5
v+tbQAu95J9S32HvjErlycq8N3RJ6d0zDUVVllHysoJEMW3xjakuVISyxydUEj10
L6JRa7KRBjJrgIy6TkxDTiJpko+IMAHzLhPojt6wquzlasIJX5RD7hUL+YXCN/ZV
bbB3ZIGhbrct0zJxi+p6j1Ic+3q0hjOoOAcyjNbLGaDOktsdsMCUUk1g1W8T5l/S
amSc/O4YlzysMw2cr6RSGB+R0wlWKGV9PXRxMTWk5zncXyvOSQfsF4ehgLnvtJ4B
L3n8vzX/GXBfaUfnTsYju0YZfFrOEla5m+VZVqW4I33Q+5GE1flvxATFqH0FnWN7
p020iRFBjIOmc3c0lTShuJHQHtnxzbuVsZ8Oxih1BzvXCrMH5X0=
=CSPA
-----END PGP SIGNATURE-----

--FdFkJne9goH8C5xwQBtfedhI9So9W3z9n--

