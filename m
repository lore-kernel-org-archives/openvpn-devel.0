Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180201072731.GU69387@...1296...>
 <20180201154521.7642-1-steffan@...1856...>
 <CAKuzo_jyu-zuJDTXJkB2iV=MQ=Yx74uo_Eo8XN3Sgr5YLR460g@...278...>
 <b1f23a13-e547-be90-9c7d-690245c86fdd@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9665a3a4-c7a0-142e-147a-aae3da356767@...2080...>
Date: Fri, 2 Feb 2018 12:24:48 +0100
MIME-Version: 1.0
In-Reply-To: <b1f23a13-e547-be90-9c7d-690245c86fdd@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cO70bgiCpriIB189QMEjujzt7E120M00u"
Subject: Re: [Openvpn-devel] [PATCH v3] Enable stricter compiler warnings by
 default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cO70bgiCpriIB189QMEjujzt7E120M00u
Content-Type: multipart/mixed; boundary="6t6Gkq7Oz7DoOmn9tUcwEUOddYzpkmB92";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <9665a3a4-c7a0-142e-147a-aae3da356767@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3] Enable stricter compiler warnings by
 default
References: <20180201072731.GU69387@...1296...>
 <20180201154521.7642-1-steffan@...1856...>
 <CAKuzo_jyu-zuJDTXJkB2iV=MQ=Yx74uo_Eo8XN3Sgr5YLR460g@...278...>
 <b1f23a13-e547-be90-9c7d-690245c86fdd@...1856...>
In-Reply-To: <b1f23a13-e547-be90-9c7d-690245c86fdd@...1856...>

--6t6Gkq7Oz7DoOmn9tUcwEUOddYzpkmB92
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 02/02/18 07:32, Steffan Karger wrote:
> Hi,
>=20
> On 02-02-18 05:43, Selva Nair wrote:
>> On Thu, Feb 1, 2018 at 10:45 AM, Steffan Karger <steffan@...1856...> wro=
te:
>>> [...]
>>>
>>> +AX_CHECK_COMPILE_FLAG([-Wall], [CFLAGS=3D"-Wall ${CFLAGS}"])
>>
>> The three options could have checked together, but this is fine too.
>>
>> All said and done, the check is not as useful as I had imagined..
>> AX_CHECK_COMPLIE_FLAG only catches errors, not warnings.
>> For instance, IBM's xlc, at least on Linux, only warns about unknown opt=
ions.
>> So nothing gained -- in fact 4 warning lines per source file caused by
>> these options.
>> Hopefully, its still useful on some other never used build envs..
>>
>> Anyway, the check protects against probable build failures on some unkno=
wn
>> systems, and I won't waste any more time dwelling on this.
>>
>>> diff --git a/m4/ax_check_compile_flag.m4 b/m4/ax_check_compile_flag.m4
>>> new file mode 100644
>>> [...]
>>
>> This macro is a part of autoconf archive which, I thought, is
>> prerequisite for building from the repo. One anyway needs autotools
>> installed. Can't we not insist on having these common macros be present
>> as well? After all this is for building from git sources, not from a
>> dist tarball
>> which needs no autotools.
>>
>> Also the notes in the macro file says "Please keep this macro in sync wi=
th
>> AX_CHECK_{PREPROC,LINK}_FLAG." which is easier to do if we use the
>> system's installed copy.
>>
>> Anyway, if including such m4 macros in the repo is the policy,  this
>> is fine.
>=20
> We previously did not depend on it (I didn't have the archive installed)
> and thought we didn't want to pull in another dependency.  Also, the
> error when the archive is missing is quite terrible and will cost a lot
> of people time to understand.  Autoconf happily continues, then
> configure fails with:
>=20
> ./configure: line 17861: syntax error near unexpected token `newline'
> ./configure: line 17861: `AX_CHECK_COMPILE_FLAG('
>=20
> That said, if we prefer to not include the macro, it can simply be
> removed from the commit.  I could even rewrite then to directly use
> AC_COMPILE_IFELSE, which is bulkier and less clear but doesn't need the
> include.

I've just done a quick check where/how ax_check_compile_flag.m4 can be found
on Fedora 27, RHEL-7 and RHEL-6.

For Fedora 27 and RHEL-7, it is found in a package named "autoconf-archive".
For RHEL-6, no such package exists and I could also not find any other
packages which provides that .m4 file.

We could check this on other platforms as well (*BSD, Solaris, AIX) to see =
how
they handle this.  But if there's a similar situation there, I think it mak=
es
perfect sense to ship this macro file.  What I don't like about that, is th=
at
we should have some process to ensure we keep these m4 files up-to-date.
Which we have not really done so far :/


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--6t6Gkq7Oz7DoOmn9tUcwEUOddYzpkmB92--

--cO70bgiCpriIB189QMEjujzt7E120M00u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJadEqAAAoJEIbPlEyWcf3yeJAP/1bg2qotJNDpNvhZOsU55U52
CwTKqTmAooAUBJXcoIzzUn+wGhJ8MYMHLze30OuZCe7dYN1CPY58xJ6gY36lFWRi
v5AExY69BNGJvxiYFHKinmJi9808/FS5u0llxEpjqxmYJZCNMQxqDiYPle3uqj7i
xadHrDIM8TJymL4xtIP7L3SdkaQaUKYt+B2FrG++MREXM/6Cpn+6HJ+NqfoR1szY
eYp+S24aiEHk9mPQQduHliR9eooCd/FNT6RkyjIOApqw1++NVLEHmbQXhrm607fh
deT2SoviTZJIqO35d0Wfa5U8NeAMfnyq14PmafRU0SvmqC1x/T4Ieh6UkYdAoIdA
vVicOC9qUbgGPFuQU9vS4gm9P8gOmcrzUyuXTT83CqjPItwuLP1wHSZRbfYNz4iS
17Cop0YihOn3l0rMxQk9ZBKuTuYkaIFyjEBoXHaCe1z71i8qMYCtHJRffw7IWm3k
VhC3p03GeSicwDHci/s4hW4lQXCiZGES10u0mbxg2w3YsgqWiyGcbE4C+YShwnJH
sW4u+XKOBuj8RdwYLSSWQyYC4I4IQyKvSZTWBNEA3nu/TXRdOSUcU5I8KELiVWBb
pswj15aytzXGyXkVG8LUPTwE5yCCtGNw0F97XZ9WwaOFuX1NlbfJppEAXsqYp9I+
zflG0pRKSBlluQZlq5vj
=2yh6
-----END PGP SIGNATURE-----

--cO70bgiCpriIB189QMEjujzt7E120M00u--

