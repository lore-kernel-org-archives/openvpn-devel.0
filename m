References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
	<95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
	<a0821983-407a-dd9f-dbac-47f94a18c4dd@...515...>
	<ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080...>
Date: Mon, 3 Apr 2017 22:43:50 +0200
MIME-Version: 1.0
In-Reply-To: <ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WJT1llUf96KTVSADsHpDGdURL6tW3arbr"
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WJT1llUf96KTVSADsHpDGdURL6tW3arbr
Content-Type: multipart/mixed; boundary="ewTr9w6VMsFMxxdRDmAqfHHJrmJ62Rmw3";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Jan Just Keijser <janjust@...1147...>, Steffan Karger <steffan@...1856...>, 
	openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080...>
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
	<95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
	<a0821983-407a-dd9f-dbac-47f94a18c4dd@...515...>
	<ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
In-Reply-To: <ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>

--ewTr9w6VMsFMxxdRDmAqfHHJrmJ62Rmw3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/04/17 16:12, Jan Just Keijser wrote:
> Hi Samuli,
>=20
> On 03/04/17 15:53, Samuli Sepp=C3=A4nen wrote:
>> On 02/04/2017 10:57, Steffan Karger wrote:
>>> Hi,
>>>
>>> On 31-03-17 22:34, David Sommerseth wrote:
>>>> On 31/03/17 10:56, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>>>>> 2017-03-31 13:26 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>>>>> <mailto:samuli@...515...>>:
>>>>>
>>>>>      Hi,
>>>>>
>>>>>      We still bundle EasyRSA 2 with our Windows installers and it is
>>>>>      prominently advertised on our widely linked to HOWTO:
>>>>>
>>>>>      <https://openvpn.net/index.php/open-source/documentation/howto.h=
tml
>>>>>      <https://openvpn.net/index.php/open-source/documentation/howto.h=
tml>>
>>>>>
>>>>>      As such, EasyRSA 2 is used by many/most OpenVPN server admins.
>>>>>
>>>>>      However, the default values for EasyRSA 2 such as MD5 hashing al=
gorithm
>>>>>      and 1024-bit keysize seem totally inadequate for today's standar=
ds:
>>>>>
>>>>>      <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.=
0/vars#L53
>>>>>      <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.=
0/vars#L53>>
>>>>>      <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.=
0/openssl-1.0.0.cnf#L57
>>>>>      <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.=
0/openssl-1.0.0.cnf#L57>>
>>>>>
>>>>>      I think we should upgrade these to something more recent. What w=
ould
>>>>>      more modern reasonable defaults be?
>>>>>
>>>>>
>>>>>
>>>>> someday we decided to use DSA (instead of default RSA)
>>>>> it worked ... until we started to use OpenVPN Connect for iOS.
>>>>> next, we had to change back to RSA
>>>>>
>>>>>
>>>>> the conclusion would be "test all available platforms and take a
>>>>> decision", probably even set up special test server and ask people on
>>>>> openvpn-users mailing list
>>>> Always a good idea to test as many platforms as possible.  But we can
>>>> also leverage all the testing which have been done indirectly by others
>>>> as well.
>>>>
>>>> The suggestion from Samuli is to update the default key size and hashi=
ng
>>>> algorithm.  MD5 is broken.  MD5 have been broken for years.  SHA1 have
>>>> the recent SHAttering panic, which have its own set of challenges - and
>>>> should not be used for certificates any longer (if I have understood t=
he
>>>> crypto-gurus correctly).
>>>>
>>>> Also considering that the "world in general" have been moving towards
>>>> stronger keys *and* have moved towards SHA256 hashing in certificates,
>>>> updating EasyRSA is more than reasonable.
>>>>
>>>> So, I would highly recommend using SHA256.  I have used that for my
>>>> OpenVPN setups for several years already.  That works fine for me, and=
 I
>>>> know others have done the same.  This is actually the most challenging
>>>> move, from a technical point of view - using a new algorithm.  But this
>>>> algorithm is well supported by all OpenSSL and mbed TLS implementations
>>>> OpenVPN can be built against.
>>>>
>>>> Secondly, updating the key length from 1024 bits to at least 2048 shou=
ld
>>>> not cause any issues at all.  Many users (myself included) often use
>>>> 4096 bits keys without any issues.
>>>>
>>>> Swapping RSA for DSA is an issue of a completely different league. And
>>>> DSA is by OpenSSH considered too weak; IIRC it was even removed in
>>>> OpenSSH v7.0.
>>> Yes, upgrading would be good if we still ship it.  I can echo David's
>>> SHA256 / RSA2048+ recommendation.  Enough security margin, and very good
>>> interop (not only crypto libs, but also smart cards, OS key stores,
>>> ...).  To not dramatically slow down connection setup on low-cpu-power
>>> devices (e.g. home routers), don't go beyond RSA4096 though.
>>>
>>> DSA is _not_ a preferred choice.  The original 1024-bit DSA is too weak
>>> nowadays, and the 'larger' DSA variants are not even close to the wide
>>> support that RSA has.
>>>
>>> -Steffan
>>>
>> Hi,
>>
>> I've issue a pull request here and review would be appreciated:
>>
>> <https://github.com/OpenVPN/easy-rsa-old/pull/1>
>>
>> I tested these changes on Debian 8 which has OpenSSL-1.0.1. Key size was
>> set to 4096-bits and signature algorithm to SHA256WithRSAEncryption.
>>
>> The only real issue was DH parameter generation: it took ~25 minutes on
>> my Intel i5 laptop. Is that acceptable default behavior?
>>
> what kind of i5 is this? on my i7-4810 it took 5 minutes. Can you give th=
e full CPUID string (from /proc/cpuinfo) ?  then I can=20
> guestimate whether the 25 minutes is realistic for slower hardware.

I've run a a couple of "quick" tests ... on a two different laptops

--- test 1 ----------------------------------------------------------
$ time openssl gendh -out test 4096
[...snip...]

real    35m40.098s
user    35m38.922s
sys     0m0.367s
$ cat /proc/cpuinfo  | grep model\ name | uniq -c
      4 model name      : Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz

<http://ark.intel.com/products/88193/Intel-Core-i5-6200U-Processor-3M-Cache=
-up-to-2_80-GHz>

--- test 2 ----------------------------------------------------------
$ time openssl gendh -out test 4096
[...snip...]

real	13m59.742s
user	13m59.448s
sys	0m0.140s
$ cat /proc/cpuinfo  | grep model\ name | uniq -c
      4 model name	: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz

<http://ark.intel.com/products/85215/Intel-Core-i7-5600U-Processor-4M-Cache=
-up-to-3_20-GHz>


--- test 3 ----------------------------------------------------------
$ time openssl gendh -out test 4096
[...snip...]

real	14m54.432s
user	14m53.475s
sys	0m0.339s
$ cat /proc/cpuinfo | grep model\ name | uniq -c
      4 model name	: Intel(R) Xeon(R) CPU E3-1220L V2 @ 2.30GHz

<http://ark.intel.com/products/53401/Intel-Xeon-Processor-E3-1220L-3M-Cache=
-2_20-GHz>


The main difference, if I looked at the correct "Intel Ark" page for
your i7-4800 [1], is the CPU cache (yours is 6MB, while the others are
3-4MB.  The i5 have max turbo freq at 2.8GHz, while the others are quite
closer (3.2-3.4 GHz, yours is at 3.8GHz).

[1]
<http://ark.intel.com/products/78937/Intel-Core-i7-4810MQ-Processor-6M-Cach=
e-up-to-3_80-GHz>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--ewTr9w6VMsFMxxdRDmAqfHHJrmJ62Rmw3--

--WJT1llUf96KTVSADsHpDGdURL6tW3arbr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY4rQGAAoJEIbPlEyWcf3ypD8QAIL3MVnQbgNP1zVLPd3uhyKv
4n2ox1uOsh6oKRshgN7UJ1Z6SuoWqg3XRUlS9XWsZAm1Fb4jV6YkC9601Lm3gnNe
wfQBNGHJcik6qW9uLX9alxXBiJmF55HvH/SUQB2EarRXjBk7yDPPZuAYrp16QUa/
Vge+mteJOCSEb24t2iQA/mNALpJtVmjfFsGrvWBGnLXzdg1EScXiRR694MgPicj1
5IN80YKfJyDV0ULUff2BL5+zsPD2RXEU+xci2FbMPMa2y4EOR4kSCGmAmxqVL5D4
Cn0peDuDRZPO/TSW4uDZ4QaVANEq1KNdgGWCZeo1TmmJTZ/7EPU+FZpgISCp+Ncz
r1PGA1JE4ki12vIN9664YBix7l07dnCKBzmXD34KcYuzd5t2jdQ5vtJasfAp9WT0
KxP0BwkLkFcuRWCal+vA/dzKK88kN/xUVhKPkl8JgLL7sUzQhJKg9KAU2GP78nfs
5fbSnUOihl0r7ZwVkVPSU2yC7c+lSNA1z8/6Cw4669CqwRhkFzUN/XDya2vnV32P
23aTDwEHXo3wiWHMk6n5B8OsH8C85EhbCjn9EgLaWd9nbgtSesixWjvQhhfS4ks5
mRypUazIhCVyaj6w1Fk3FyNhemqWO5dW6wCrDpM9UCrWzbJxIOohmdSbhB/Zc6el
Lvc6nlogLeTfm2ceTUM/
=uDwZ
-----END PGP SIGNATURE-----

--WJT1llUf96KTVSADsHpDGdURL6tW3arbr--

