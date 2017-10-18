From: Jeremie Courreges-Anglas <jca@...2272...>
References: <87fuaymq62.fsf@...2274...>
 <44a0a6e8-0662-6fcc-7f97-d35477bd81b0@...68...>
 <87efq4havl.fsf@...2274...>
Date: Wed, 18 Oct 2017 20:36:24 +0200
Message-ID: <87bml4mhg7.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [patch] Fix time_t printing - NAK
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 15 2017, Jeremie Courreges-Anglas <jca@...2272...> wrote:
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
>
> oops, sorry about that.
>
>> The long commit log states time_t could be a float, which it cannot be
>> according to IEEE Std 1003.1, 2013 edition, which, in the sys/types.h
>> section, requires that time_t shall be an integer type (no mention if
>> it's signed or unsigned). (clock_t could be a floating-point type
>> however).=C2=A0 This is a POSIX restriction over ISO 9899.
>
> ISO C only says that time_t is a numeric type (hence a floating point
> type would be possible), but POSIX is more precise indeed.
>
> Thanks for your feedback.  New proposal attached, hopefully fixing the
> commit message.
>
>> I propose to either:
>> * cast it to uintmax_t and use the PRIuMAX macro in the *printf function,
>> * cast it to unsigned long long and use %llu to print.
>
> I see no good reason to interpret time_t as an unsigned value.  Most
> unix-like systems (original unix, BSD, Linux, solaris...) use a signed
> integer. A negative time_t value ought to be meaningful, representing
> dates before epoch.  Also I've seen people using time_t to store the
> difference between two timestamps, relying on a signed implementation.
> (I'm not saying this is the case in openvpn.)
>
> Printing negative values as unsigned would make them meaningless/hard to
> diagnose.  The "long long" idiom is careful about this.
>
> I don't have much to say about the intmax_t approach, all I know is that
> "long long" works well as a generic solution since it doesn't need
> stdint.h - and format specifiers that some people find ugly.

Some things that I should probably have stated more clearly:

- the proposed patch is fixing an actual problem.
  openvpn --machine-readable-output currently crashes on OpenBSD/arm (32
  bits platform, 64 bits time_t)

- there are other places when a time_t is printed in openvpn.  Usually
  it is cast to (int), which is not a nice thing to do if you plan to
  support dates after 2038.

  I also stumbled upon this in src/openvpn/common.h

  /*
   * Printf formats for special types
   */
  #ifdef _WIN64
  #define ptr_format              "0x%I64x"
  #else
  #define ptr_format              "0x%08lx"
  #endif
  #define time_format             "%lu"
  #define fragment_header_format  "0x%08x"
=20=20
  /* these are used to cast the arguments
   * and MUST match the formats above */
  typedef unsigned long time_type;
  #ifdef _WIN64
  typedef unsigned long long ptr_type;
  #else
  typedef unsigned long ptr_type;
  #endif

  time_format and time_type are indeed used in a few places where
  a time_t is printed.  Technically, "unsigned long" suffers from the
  same problem as "long" on platforms with a 32 bits "long", pushing the
  limit to 2106 instead of 2038.

  I would suggest using "long long" here too, but do you folks think
  that the whole "time_format/time_type" indirection makes sense?
  After all, those are currently the same on all platforms.

  I have a diff to fix places in src/openvpn where time_t variables are
  cast to (int), but it kinda depends on the approach you folks prefer
  to use.

>> While we are at it, note that tv.tv_usec, per POSIX, is a SIGNED integer
>> type capable of representing numbers in the range [-1; 1,000,000] so
>> casting tv_usec to unsigned long without checking if it's -1 is
>> technically wrong, although I'd be surprised to see gettimeofday()
>> return a negative tv_usec - but UINT_MAX or ULONG_MAX likewise.
>
> It makes sense to respect the fact that suseconds_t can store a negative
> value.  But then the same can be said about time_t (since its signedness
> is not defined by posix).

I guess it makes sense to also choose a generic way to print
suseconds_t, whose size isn't defined by posix either, and deal with
both types at once.  I would suggest using %ld and a cast to (long), as
this is the underlying type on at least OpenBSD and Linux.

--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlnnnykACgkQDfp0rhUk
5+6l/hAAs5b1NSug2ug/zj51vnDJHmIqVYXMwOjs54eDBSXijR88OEkfl4gm7Wv7
N2aEEcUwY3DkxWSgFhilHTuriRojmmrmUxWEnDKlMewrPpqHNYhwzshqmkX8ER8x
wacTKdF+OrYWPQWs49S30GcFCTT4pam8fxYR6pXT4F2zbD3Zv34gGHQSO/HuwtSB
V9WIH0xkC+fUV6ZPmDYMaux8GaXQUIeeFbHlzEf0zU9Wpp2FZqcQCk/gDfO6o1Qh
bmgqZndKyVzutUABk4fO2hYqpoi225nd8c4GpjxNHvdPlERZ/mMiaELqtJC7+270
IznwaLkiL1LXS7Xav0I4Pcqttw1Whqdv0zDsagNvRYFMpyicirV84JaUL/Z6fqNi
gCuA1TSMdjGcLrjzf+zyvh0t0Lk/qh5CaNfpt/YDPlaU/gLtL+OmBK1XqZWxkHB4
+xNd+BJjFo3xWe1MwRAeTrX1cdVZI03SLTvhY0xiLPUYBXZZyKKpSTkWgTpfQU4D
K6YwZoxrjY8HNDsa81HM2Rxb/KHVvORDbYWJYA+qkp4K56lhOcDW6/oF3yUwPgRw
ePvryanrjaDvSLosvLR+X8umWeilYBiH63zs6YQcOBvXdaQ8D4F2RdGEMTXvzeDb
z0g0LKELxRgd/UoxD5qSltKhbTP3mQVRA+sKg+8adM5E/UqcaS4=
=Okib
-----END PGP SIGNATURE-----
--=-=-=--

