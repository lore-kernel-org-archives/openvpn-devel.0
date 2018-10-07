References: <20181007073413.9778-1-steffan@...1856...>
 <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
 <7b2c0430-4d5a-1e7e-334c-9292193b2a2d@...2181...>
 <ce2afd5b-cd48-8623-eaf0-0a03ee146436@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <817685bc-8454-bd24-3822-ee9223b1e901@...2181...>
Date: Mon, 8 Oct 2018 04:18:47 +0800
MIME-Version: 1.0
In-Reply-To: <ce2afd5b-cd48-8623-eaf0-0a03ee146436@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="syox7cnnO7tInVkQZ8p4tREhDJ2Rb92N0"
Subject: Re: [Openvpn-devel] [PATCH] Add support for CHACHA20-POLY1305 in
 the data channel
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
--syox7cnnO7tInVkQZ8p4tREhDJ2Rb92N0
Content-Type: multipart/mixed; boundary="yEQVkAINUwABsf55omYhjZcKmvs4KTxa6";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <817685bc-8454-bd24-3822-ee9223b1e901@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for CHACHA20-POLY1305 in the
 data channel
References: <20181007073413.9778-1-steffan@...1856...>
 <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
 <7b2c0430-4d5a-1e7e-334c-9292193b2a2d@...2181...>
 <ce2afd5b-cd48-8623-eaf0-0a03ee146436@...1856...>
In-Reply-To: <ce2afd5b-cd48-8623-eaf0-0a03ee146436@...1856...>

--yEQVkAINUwABsf55omYhjZcKmvs4KTxa6
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/10/18 02:13, Steffan Karger wrote:
> On 07-10-18 15:36, Antonio Quartulli wrote:
>> On 07/10/18 21:28, Antonio Quartulli wrote:
>>>> +#if defined(MBEDTLS_CHACHAPOLY_C) && (MBEDTLS_VERSION_NUMBER >=3D 0x0=
20C0000)
>>>
>>> Why do we need the dual condition? Isn't MBEDTLS_CHACHAPOLY_C enough to
>>> know mbedTLS has what we need? Or you feel like we have to demand a
>>> specific mbedTLS version when using ChaCha20?
>>
>> Just to reinforce my argument: ChaCha20-Poly1305 was introduced with
>> ce66d5e8e (in mbedTLS upstream) and a quick search shows:
>>
>> mbedtls $ git tag --contains ce66d5e8e
>> mbedtls-2.12.0
>> mbedtls-2.13.0
>> mbedtls-2.13.1
>>
>> Given that 2.12 is 0x020C0000, I am fairly sure there is no reason to
>> have both conditions in the if guard.
>> But I might still be missing something.
>>
>> (p.s. I am arguing simply because I want to avoid more version-based
>> ifdef that may become new nightmares)
>=20
> Which is a good cause, but that unfortunately won't work here. That is
> because the actual implementation was introduced in dca3a5d8,=20
[CUT]

mbedtls $ git tag --contains dca3a5d8
mbedtls-2.12.0
mbedtls-2.13.0
mbedtls-2.13.1

To be safe I checked out 2.9.0 and grepped the define:

mbedtls $ git checkout mbedtls-2.9.0
Note: checking out 'mbedtls-2.9.0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at 070e35647 Merge remote-tracking branch
'upstream-restricted/pr/481' into development-restricted
mbedtls $ grep -rn CHACHAPOLY_C
mbedtls $

am I missing something?
2.12.0 is the first release where my grep command prints something.

Cheers,


--=20
Antonio Quartulli


--yEQVkAINUwABsf55omYhjZcKmvs4KTxa6--

--syox7cnnO7tInVkQZ8p4tREhDJ2Rb92N0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu6aicACgkQ9FVsWUWD
Dm38qw/+JA1Y716VfTlkzkDbYDzo2DCJPCG7SM3CEeza82jx435kS0VAVp5qj01j
QGa5VtivzBjqzn+IGV8QCzkXceY2CKtxophCDpc7eOP+53UaNTMb9XeskzYmeBBP
qLaLk92aakwpkGlu0KJIMyxOhTOIdZs7G5r++4UKkezPqj8OBVUC0kaST8EWPepM
r/4EbQ+ZDNmX2jWmXIhF6+b2qbY/zomhH9Iz6IgAlmQZgWFa4jZ40QnzYKzZMElu
XYA+hm1aKNOzyH/L6dO/Guke1+KWhNfVUcNMUZ41JhKcYX7Dv0Ctdp9v4wEKfpZa
oiMYi053SO8akkikqjF7BKM9IbLGdwv4MqlUfTCk0XDeThTxSUZKzJcYKvDA0duZ
SNME6wz34vFGV27hfZFjPwt1kQnaB9NPBPkvs7VqwdF1lfzYbAWcrpliIX3HafcE
ZPVOMERtVc8BkpqtM4DacHsDKBvH6YKr72by0gu/5A/gFmWaCPgxrqAJMH7y1xbL
Ky6WangIQqT+kqEUvVHUQuQvYhGtzmHiWPGJMFV1RMZfrKkuDFktGfkGlknk8ulK
RiaR+PK2IIaFnzdHdQGH98AEvZQRb3vWvlx7iSTVdTROXYzvIV7GTAe0oYsAim2C
pNcYKbRDfayL0W8dvFP0sBA9mcQLx7XFSmgCvYwV1Mi1zatZAdw=
=i09/
-----END PGP SIGNATURE-----

--syox7cnnO7tInVkQZ8p4tREhDJ2Rb92N0--

