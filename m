References: <87fuaymq62.fsf@...2274...>
 <44a0a6e8-0662-6fcc-7f97-d35477bd81b0@...68...>
 <87efq4havl.fsf@...2274...> <87bml4mhg7.fsf@...2274...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <3cb0497a-72d4-f84e-9026-f6b1e1aeb69c@...1435...>
Date: Thu, 26 Oct 2017 10:22:54 +0200
MIME-Version: 1.0
In-Reply-To: <87bml4mhg7.fsf@...2274...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HnmtNDiCfxKS7a0GqNhOWXpPqU272GUHp"
Subject: Re: [Openvpn-devel] [patch] Fix time_t printing - NAK
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--HnmtNDiCfxKS7a0GqNhOWXpPqU272GUHp
Content-Type: multipart/mixed; boundary="fCxHse0DnOgxEGeXPCljLPTxEfwPSGfct";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <3cb0497a-72d4-f84e-9026-f6b1e1aeb69c@...1435...>
Subject: Re: [Openvpn-devel] [patch] Fix time_t printing - NAK
References: <87fuaymq62.fsf@...2274...>
 <44a0a6e8-0662-6fcc-7f97-d35477bd81b0@...68...>
 <87efq4havl.fsf@...2274...> <87bml4mhg7.fsf@...2274...>
In-Reply-To: <87bml4mhg7.fsf@...2274...>

--fCxHse0DnOgxEGeXPCljLPTxEfwPSGfct
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for being late to respond.

On 18-10-17 20:36, Jeremie Courreges-Anglas wrote:
> - there are other places when a time_t is printed in openvpn.  Usually
>   it is cast to (int), which is not a nice thing to do if you plan to
>   support dates after 2038.
>=20
>   I also stumbled upon this in src/openvpn/common.h
>=20
>   /*
>    * Printf formats for special types
>    */
>   #ifdef _WIN64
>   #define ptr_format              "0x%I64x"
>   #else
>   #define ptr_format              "0x%08lx"
>   #endif
>   #define time_format             "%lu"
>   #define fragment_header_format  "0x%08x"
>=20=20=20
>   /* these are used to cast the arguments
>    * and MUST match the formats above */
>   typedef unsigned long time_type;
>   #ifdef _WIN64
>   typedef unsigned long long ptr_type;
>   #else
>   typedef unsigned long ptr_type;
>   #endif
>=20
>   time_format and time_type are indeed used in a few places where
>   a time_t is printed.  Technically, "unsigned long" suffers from the
>   same problem as "long" on platforms with a 32 bits "long", pushing the
>   limit to 2106 instead of 2038.
>=20
>   I would suggest using "long long" here too, but do you folks think
>   that the whole "time_format/time_type" indirection makes sense?
>   After all, those are currently the same on all platforms.
>=20
>   I have a diff to fix places in src/openvpn where time_t variables are
>   cast to (int), but it kinda depends on the approach you folks prefer
>   to use.

Not sure about the other devs, but I think we should get rid of this
indirection.  Someone who forgets to cast to long long will likely also
not use the time_format define.  Better be consistent in casting to long
long and printing using %lld (which is obviously correct for a long
long).  Patch is definitely welcome.

>>> While we are at it, note that tv.tv_usec, per POSIX, is a SIGNED integer
>>> type capable of representing numbers in the range [-1; 1,000,000] so
>>> casting tv_usec to unsigned long without checking if it's -1 is
>>> technically wrong, although I'd be surprised to see gettimeofday()
>>> return a negative tv_usec - but UINT_MAX or ULONG_MAX likewise.
>>
>> It makes sense to respect the fact that suseconds_t can store a negative
>> value.  But then the same can be said about time_t (since its signedness
>> is not defined by posix).
>=20
> I guess it makes sense to also choose a generic way to print
> suseconds_t, whose size isn't defined by posix either, and deal with
> both types at once.  I would suggest using %ld and a cast to (long), as
> this is the underlying type on at least OpenBSD and Linux.

Sounds good to me.

-Steffan


--fCxHse0DnOgxEGeXPCljLPTxEfwPSGfct--

--HnmtNDiCfxKS7a0GqNhOWXpPqU272GUHp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZ8ZteAAoJEEEwndWOY1w5BBgIAIYvxu6bkMI2wRWx4GXmE67G
ZLeTXbnVeT2e595ZVRtm8fye/YWeh6F6LRcINuE+QX//nwTiFVPwbernUVF7BhB+
WF50L57mVAdm2EpdCvkxcE/UN9SCvPyKTlOm2qKoINTONAd296dYvcBbFY8/+G+t
6dglsEdYxNNn0jE2dq/8bDfDcruj/TOTrqA0TC0KjrXAdoCkQ7l9um77tKI/D2aD
R4sqZ0pjR3sE+wzUbor8bYtmr3KbLNl7qSxA2QKHqXBiI2aNVaxjNKnjyZK8MKZ1
YC1dqK4t2ZcdBwsp0CIIzcJp2YGxdsd/n3Ee/POswt2CsrhGBPNAd1SubqjsMhQ=
=ADHS
-----END PGP SIGNATURE-----

--HnmtNDiCfxKS7a0GqNhOWXpPqU272GUHp--

