References: <87fuaymq62.fsf@...2274...>
 <44a0a6e8-0662-6fcc-7f97-d35477bd81b0@...68...>
 <87efq4havl.fsf@...2274...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <519e633f-ccb4-da6a-32f2-425a1e23b343@...1435...>
Date: Thu, 26 Oct 2017 10:17:30 +0200
MIME-Version: 1.0
In-Reply-To: <87efq4havl.fsf@...2274...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uOi9h2FngPjO0rW1w60pckovB5jfsCJ94"
Subject: Re: [Openvpn-devel] [patch] Fix time_t printing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--uOi9h2FngPjO0rW1w60pckovB5jfsCJ94
Content-Type: multipart/mixed; boundary="4OtsCUiFHVriFWJG7B1Nj26GI7IXq6vvb";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <519e633f-ccb4-da6a-32f2-425a1e23b343@...1435...>
Subject: Re: [Openvpn-devel] [patch] Fix time_t printing
References: <87fuaymq62.fsf@...2274...>
 <44a0a6e8-0662-6fcc-7f97-d35477bd81b0@...68...>
 <87efq4havl.fsf@...2274...>
In-Reply-To: <87efq4havl.fsf@...2274...>

--4OtsCUiFHVriFWJG7B1Nj26GI7IXq6vvb
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 15-10-17 14:08, Jeremie Courreges-Anglas wrote:
> On Sun, Oct 15 2017, Matthias Andree <matthias.andree@...68...> wrote:
>> Am 05.10.2017 um 01:47 schrieb Jeremie Courreges-Anglas:
>>> When building openvpn-2.4.4 on OpenBSD, I noticed the following warning:
>>>
>>> --8<--
>>> cc -DHAVE_CONFIG_H -I. -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/sr=
c/openvpn -I../.. -I../../include  -I/usr/ports/pobj/openvpn-2.4.4/openvpn-=
2.4.4/include  -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/compat  -I=
/usr/local/include     -I/usr/local/include    -DPLUGIN_LIBDIR=3D\"/usr/loc=
al/lib/openvpn/plugins\"  -O2 -pipe -std=3Dc99 -MT error.o -MD -MP -MF .dep=
s/error.Tpo -c -o error.o /usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/o=
penvpn/error.c
>>> /usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/openvpn/error.c:346:25:=
 warning: format specifies type 'unsigned long' but the argument has type '=
time_t' (aka 'long long') [-Wformat]
>>>                         tv.tv_sec,
>>>                         ^~~~~~~~~
>>> 1 warning generated.
>>> mv -f .deps/error.Tpo .deps/error.Po
>>> -->8--
>>>
>>> OpenBSD uses long long for time_t on all architectures, 32 or 64 bits,
>>> in order to cope with dates beyond 2038.  This is also the case on
>>> NetBSD and Linux x32.
>>>
>>> The warning is not innocuous, as a mismatch between the format and the
>>> type of parameters passed to variadic functions can result in nasty
>>> problems (crashes, etc).  For example, the code below crashes on
>>> OpenBSD/arm (32 bits long).
>>>
>>> --8<--
>>> #include <stdio.h>
>>> #include <time.h>
>>>
>>> int
>>> main(void)
>>> {
>>>         time_t t;
>>>
>>>         time(&t);
>>>         printf("%ld %s\n", t, "foobar");
>>>         return 0;
>>> }
>>> -->8--
>>>
>>> The diff below fixes the potential issue and the warning.  The method
>>> used is a cast to (long long), a method successfully used since OpenBSD
>>> switched to a 64 bits time_t.  More data at
>>>
>>>   https://www.openbsd.org/papers/eurobsdcon_2013_time_t/mgp00029.html
>>>
>>> openvpn already uses long long in a few places.  Note that I did not
>>> audit the whole openvpn tree for other possible time_t problems, but
>>> I can't spot similar warnings in the build logs.
>>> From d620431f661375d3564b60f110d1f69575ac78d7 Mon Sep 17 00:00:00 2001
>>> From: Jeremie Courreges-Anglas <jca@...2272...>
>>> Date: Thu, 5 Oct 2017 01:43:33 +0200
>>> Subject: [PATCH] Cast time_t to long double in order to print it.
>>>
>>> The underlying type of time_t can be anything from unsigned 32 bits to
>>> signed 64 bits to float.  To reliably print it, better cast it to "long
>>> long", which is at least 64 bits wide and can represent values beyond
>>> 2038.
>>
>> NAK.
>>
>> This is due to the inconsistent and misleading commit log.
>> The subject says "cast to long double", the code does "cast to long long=
".
>=20
> oops, sorry about that.
>=20
>> The long commit log states time_t could be a float, which it cannot be
>> according to IEEE Std 1003.1, 2013 edition, which, in the sys/types.h
>> section, requires that time_t shall be an integer type (no mention if
>> it's signed or unsigned). (clock_t could be a floating-point type
>> however).=C2=A0 This is a POSIX restriction over ISO 9899.
>=20
> ISO C only says that time_t is a numeric type (hence a floating point
> type would be possible), but POSIX is more precise indeed.
>=20
> Thanks for your feedback.  New proposal attached, hopefully fixing the
> commit message.

ACK to that attached patch.

>> I propose to either:
>> * cast it to uintmax_t and use the PRIuMAX macro in the *printf function,
>> * cast it to unsigned long long and use %llu to print.
>=20
> I see no good reason to interpret time_t as an unsigned value.  Most
> unix-like systems (original unix, BSD, Linux, solaris...) use a signed
> integer. A negative time_t value ought to be meaningful, representing
> dates before epoch.  Also I've seen people using time_t to store the
> difference between two timestamps, relying on a signed implementation.
> (I'm not saying this is the case in openvpn.)
>=20
> Printing negative values as unsigned would make them meaningless/hard to
> diagnose.  The "long long" idiom is careful about this.
>=20
> I don't have much to say about the intmax_t approach, all I know is that
> "long long" works well as a generic solution since it doesn't need
> stdint.h - and format specifiers that some people find ugly.

Agreed that we should use a signed type to print time_t, and "long long"
seems like good choice.  (Too bad there is no canonical solution such as
a PRItime or so.)

-Steffan


--4OtsCUiFHVriFWJG7B1Nj26GI7IXq6vvb--

--uOi9h2FngPjO0rW1w60pckovB5jfsCJ94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZ8ZoiAAoJEEEwndWOY1w52tQH/0anTSpO149bdS0qCOXBLkTC
iIZMcZnaDiCEwz7Ojq54cgxnCwLkfjYyEvabbqXES+iI8q9++oJEm+Imfi4yAyMp
pshV4mPoNfgCCMoI/ph9EWZpsyYTmwFu9Jr4eYFv4ZaHXmOpAvIylwJD26ZqcKoO
xbdj2QLEoE+0/r8Ud7F6kj8ltB70s3k275BjCyIzZPHeMfJLdw1PFBCmPKWAZr3l
FrL3nbHKcrsM7BHaq7nhNmq/th3m+KzukDQaxpvfym4jpn8RBPtEFOBRh9wiWZtb
h5R+kkN2R07nAWFzjCyV8J8kKM68CksEymSAZ3vew1PZGfNTeDDOt7HOFs5oOsk=
=WP6F
-----END PGP SIGNATURE-----

--uOi9h2FngPjO0rW1w60pckovB5jfsCJ94--

