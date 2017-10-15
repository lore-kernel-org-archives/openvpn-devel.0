References: <87fuaymq62.fsf@...2274...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <44a0a6e8-0662-6fcc-7f97-d35477bd81b0@...68...>
Date: Sun, 15 Oct 2017 13:00:04 +0200
MIME-Version: 1.0
In-Reply-To: <87fuaymq62.fsf@...2274...>
Content-Type: multipart/alternative;
 boundary="------------61C30BD2EAA359BE34674528"
Content-Language: de-DE
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

This is a multi-part message in MIME format.
--------------61C30BD2EAA359BE34674528
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 05.10.2017 um 01:47 schrieb Jeremie Courreges-Anglas:
> When building openvpn-2.4.4 on OpenBSD, I noticed the following warning:
>
> --8<--
> cc -DHAVE_CONFIG_H -I. -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/=
openvpn -I../.. -I../../include  -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.=
4.4/include  -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/compat  -I/u=
sr/local/include     -I/usr/local/include    -DPLUGIN_LIBDIR=3D\"/usr/local=
/lib/openvpn/plugins\"  -O2 -pipe -std=3Dc99 -MT error.o -MD -MP -MF .deps/=
error.Tpo -c -o error.o /usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/ope=
nvpn/error.c
> /usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/openvpn/error.c:346:25: w=
arning: format specifies type 'unsigned long' but the argument has type 'ti=
me_t' (aka 'long long') [-Wformat]
>                         tv.tv_sec,
>                         ^~~~~~~~~
> 1 warning generated.
> mv -f .deps/error.Tpo .deps/error.Po
> -->8--
>
> OpenBSD uses long long for time_t on all architectures, 32 or 64 bits,
> in order to cope with dates beyond 2038.  This is also the case on
> NetBSD and Linux x32.
>
> The warning is not innocuous, as a mismatch between the format and the
> type of parameters passed to variadic functions can result in nasty
> problems (crashes, etc).  For example, the code below crashes on
> OpenBSD/arm (32 bits long).
>
> --8<--
> #include <stdio.h>
> #include <time.h>
>
> int
> main(void)
> {
>         time_t t;
>
>         time(&t);
>         printf("%ld %s\n", t, "foobar");
>         return 0;
> }
> -->8--
>
> The diff below fixes the potential issue and the warning.  The method
> used is a cast to (long long), a method successfully used since OpenBSD
> switched to a 64 bits time_t.  More data at
>
>   https://www.openbsd.org/papers/eurobsdcon_2013_time_t/mgp00029.html
>
> openvpn already uses long long in a few places.  Note that I did not
> audit the whole openvpn tree for other possible time_t problems, but
> I can't spot similar warnings in the build logs.
> From d620431f661375d3564b60f110d1f69575ac78d7 Mon Sep 17 00:00:00 2001
> From: Jeremie Courreges-Anglas <jca@...2272...>
> Date: Thu, 5 Oct 2017 01:43:33 +0200
> Subject: [PATCH] Cast time_t to long double in order to print it.
>
> The underlying type of time_t can be anything from unsigned 32 bits to
> signed 64 bits to float.  To reliably print it, better cast it to "long
> long", which is at least 64 bits wide and can represent values beyond
> 2038.

NAK.

This is due to the inconsistent and misleading commit log.
The subject says "cast to long double", the code does "cast to long long".

The long commit log states time_t could be a float, which it cannot be
according to IEEE Std 1003.1, 2013 edition, which, in the sys/types.h
section, requires that time_t shall be an integer type (no mention if
it's signed or unsigned). (clock_t could be a floating-point type
however).=C2=A0 This is a POSIX restriction over ISO 9899.

I propose to either:
* cast it to uintmax_t and use the PRIuMAX macro in the *printf function,
* cast it to unsigned long long and use %llu to print.

While we are at it, note that tv.tv_usec, per POSIX, is a SIGNED integer
type capable of representing numbers in the range [-1; 1,000,000] so
casting tv_usec to unsigned long without checking if it's -1 is
technically wrong, although I'd be surprised to see gettimeofday()
return a negative tv_usec - but UINT_MAX or ULONG_MAX likewise.


--------------61C30BD2EAA359BE34674528
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Am 05.10.2017 um 01:47 schrieb Jeremie
      Courreges-Anglas:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:87fuaymq62.fsf@...2274...">
      <pre wrap=3D"">
When building openvpn-2.4.4 on OpenBSD, I noticed the following warning:

--8&lt;--
cc -DHAVE_CONFIG_H -I. -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/op=
envpn -I../.. -I../../include  -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.=
4/include  -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/compat  -I/usr=
/local/include     -I/usr/local/include    -DPLUGIN_LIBDIR=3D\"/usr/local/l=
ib/openvpn/plugins\"  -O2 -pipe -std=3Dc99 -MT error.o -MD -MP -MF .deps/er=
ror.Tpo -c -o error.o /usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/openv=
pn/error.c
/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/openvpn/error.c:346:25: war=
ning: format specifies type 'unsigned long' but the argument has type 'time=
_t' (aka 'long long') [-Wformat]
                        tv.tv_sec,
                        ^~~~~~~~~
1 warning generated.
mv -f .deps/error.Tpo .deps/error.Po
--&gt;8--

OpenBSD uses long long for time_t on all architectures, 32 or 64 bits,
in order to cope with dates beyond 2038.  This is also the case on
NetBSD and Linux x32.

The warning is not innocuous, as a mismatch between the format and the
type of parameters passed to variadic functions can result in nasty
problems (crashes, etc).  For example, the code below crashes on
OpenBSD/arm (32 bits long).

--8&lt;--
#include &lt;stdio.h&gt;
#include &lt;time.h&gt;

int
main(void)
{
        time_t t;

        time(&amp;t);
        printf("%ld %s\n", t, "foobar");
        return 0;
}
--&gt;8--

The diff below fixes the potential issue and the warning.  The method
used is a cast to (long long), a method successfully used since OpenBSD
switched to a 64 bits time_t.  More data at

  <a class=3D"moz-txt-link-freetext" href=3D"https://www.openbsd.org/papers=
/eurobsdcon_2013_time_t/mgp00029.html">https://www.openbsd.org/papers/eurob=
sdcon_2013_time_t/mgp00029.html</a>

openvpn already uses long long in a few places.  Note that I did not
audit the whole openvpn tree for other possible time_t problems, but
I can't spot similar warnings in the build logs.
</pre>
    </blockquote>
    <blockquote type=3D"cite">
      <div class=3D"moz-text-plain" wrap=3D"true" style=3D"font-family:
        -moz-fixed; font-size: 12px;" lang=3D"x-western">
        <pre wrap=3D"">From d620431f661375d3564b60f110d1f69575ac78d7 Mon Se=
p 17 00:00:00 2001
From: Jeremie Courreges-Anglas <a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:jca@...2272...">&lt;jca@...2272...&gt;</a>
Date: Thu, 5 Oct 2017 01:43:33 +0200
Subject: [PATCH] Cast time_t to long double in order to print it.

The underlying type of time_t can be anything from unsigned 32 bits to
signed 64 bits to float.  To reliably print it, better cast it to "long
long", which is at least 64 bits wide and can represent values beyond
2038.</pre>
      </div>
    </blockquote>
    <br>
    NAK.<br>
    <br>
    This is due to the inconsistent and misleading commit log. <br>
    The subject says "cast to long double", the code does "cast to long
    long". <br>
    <br>
    The long commit log states time_t could be a float, which it cannot
    be according to IEEE Std 1003.1, 2013 edition, which, in the
    sys/types.h section, requires that time_t shall be an integer type
    (no mention if it's signed or unsigned). (clock_t could be a
    floating-point type however).=C2=A0 This is a POSIX restriction over ISO
    9899.<br>
    <br>
    I propose to either:<br>
    * cast it to uintmax_t and use the PRIuMAX macro in the *printf
    function,<br>
    * cast it to unsigned long long and use %llu to print.<br>
    <br>
    While we are at it, note that tv.tv_usec, per POSIX, is a SIGNED
    integer type capable of representing numbers in the range [-1;
    1,000,000] so casting tv_usec to unsigned long without checking if
    it's -1 is technically wrong, although I'd be surprised to see
    gettimeofday() return a negative tv_usec - but UINT_MAX or ULONG_MAX
    likewise.<br>
    <br>
  </body>
</html>

--------------61C30BD2EAA359BE34674528--

