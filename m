Date: Tue, 7 Feb 2012 11:24:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120207102413.GQ13929@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hCenlVgnDQUGHXTR"
Content-Disposition: inline
Subject: [Openvpn-devel] configure patch for MacOS 10.7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--hCenlVgnDQUGHXTR
Content-Type: multipart/mixed; boundary="CVXKxAdNG2kQIXaJ"
Content-Disposition: inline

--CVXKxAdNG2kQIXaJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm forwarding this "as-is", as I do not have enough understanding of
autoconf to say whether this is necessary, or "the right fix" - but
anyway, I've been told that this is needed to make our configure=20
behave on MacOS 10.7.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CVXKxAdNG2kQIXaJ
Content-Type: message/rfc822
Content-Disposition: inline

X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on kirk.greenie.muc.de
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=7.0 tests=BAYES_50 autolearn=no
	version=3.3.2
Received: from delta2.greenie.net (mgetty.greenie.Net
	[IPv6:2001:608:0:1007::212])
	by kirk.greenie.muc.de (8.14.5/8.12.11) with ESMTP id q173dSl1020372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <gert@...1295...>; Tue, 7 Feb 2012 04:39:30 +0100 (CET)
Received: from asmtp.apnic.net (asmtp.apnic.net [IPv6:2001:dc0:2001:11::199])
	by delta2.greenie.net (8.14.4/8.12.11) with ESMTP id q173dQrF001733
	for <gert@...1296...>; Tue, 7 Feb 2012 04:39:27 +0100 (CET)
Received: from [IPv6:2001:dc0:a000:4:8598:422d:e21d:ae7b] (unknown
	[IPv6:2001:dc0:a000:4:8598:422d:e21d:ae7b])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by asmtp.apnic.net (Postfix) with ESMTP id 68430B66B3;
	Tue,  7 Feb 2012 13:39:18 +1000 (EST)
Subject: Re: OpenVPN IPv6 with > /64...
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_D40D33E1-88C2-4B78-849C-EAAF47C99B37"
From: Byron Ellacott <bje@...1544...>
In-Reply-To: <20120206095744.GE13929@...1296...>
Date: Tue, 7 Feb 2012 13:39:17 +1000
Cc: ggm@...1544...
Message-Id: <A5E4F973-CFD8-40A4-A920-FE82EA5CB8CB@...1544...>
References: <6646AAA7-BA74-454B-AF26-94781B1759B9@...1544...>
	<20120203084529.GH13929@...1296...>
	<CAA=nHSJL9b=kBCz-vhOdQBU73mzorOEX1hfu14W0ZOVyKaHm+w@...278...>
	<980057F6-2225-4CD1-B4A6-B262ECCE03F5@...1544...>
	<20120206095744.GE13929@...1296...>
To: Gert Doering <gert@...1296...>
X-Mailer: Apple Mail (2.1251.1)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
	milter-greylist-4.2.7 (delta2.greenie.net
	[IPv6:2001:608:0:1007:a00:20ff:fefe:4bd2]);
	Tue, 07 Feb 2012 04:39:28 +0100 (CET)
X-Virus-Scanned: clamav-milter 0.97.3 at delta7z.greenie.net
X-Virus-Status: Clean

--Apple-Mail=_D40D33E1-88C2-4B78-849C-EAAF47C99B37
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 06/02/2012, at 7:57 PM, Gert Doering wrote:

> Can you send me the changes you had to do?  OpenVPN "should" build out of
> the box on all supported platforms, and that includes OS X.

Here's the diff, it's just three places that AC_LANG_SOURCE needed to be ad=
ded to AC_COMPILE_IFELSEs as per the change described in http://lists.gnu.o=
rg/archive/html/autoconf/2010-09/msg00069.html (changelog for 2.68).


--Apple-Mail=_D40D33E1-88C2-4B78-849C-EAAF47C99B37
Content-Disposition: attachment; filename=openvpn-testing-autoconf-2.6.8.diff
Content-Type: application/octet-stream; x-unix-mode=0664;
	name="openvpn-testing-autoconf-2.6.8.diff"
Content-Transfer-Encoding: 7bit

diff --git a/acinclude.m4 b/acinclude.m4
index acfc01d..4e674c9 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -17,16 +17,16 @@ dnl @author James Yonan <jim@...41...>
 
 AC_DEFUN([AX_EMPTY_ARRAY], [
   AC_MSG_RESULT([checking for C compiler empty array support])
-  AC_COMPILE_IFELSE(
+  AC_COMPILE_IFELSE([AC_LANG_SOURCE(
     [
         struct { int foo; int bar[[0]]; } mystruct;
-    ], [
+    ])], [
         AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE, 0, [Dimension to use for empty array declaration])
     ], [
-        AC_COMPILE_IFELSE(
+        AC_COMPILE_IFELSE([AC_LANG_SOURCE(
 	    [
 	        struct { int foo; int bar[[]]; } mystruct;
-	    ], [
+	    ])], [
                 AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE,, [Dimension to use for empty array declaration])
 	    ], [
 	        AC_MSG_ERROR([C compiler is unable to creaty empty arrays])
@@ -45,11 +45,11 @@ dnl @author James Yonan <jim@...41...>, Matthias Andree <matthias.andree@...83...
 AC_DEFUN([AX_CPP_VARARG_MACRO_GCC], [dnl
     AS_VAR_PUSHDEF([VAR],[ax_cv_cpp_vararg_macro_gcc])dnl
     AC_CACHE_CHECK([for GNU GCC vararg macro support], VAR, [dnl
-      AC_COMPILE_IFELSE([
+      AC_COMPILE_IFELSE([AC_LANG_SOURCE([
 	#define macro(a, b...) func(a, b)
 	int func(int a, int b, int c);
 	int test() { return macro(1, 2, 3); }
-	], [ VAR=yes ], [VAR=no])])
+	])], [ VAR=yes ], [VAR=no])])
     if test $VAR = yes ; then
     AC_DEFINE([HAVE_CPP_VARARG_MACRO_GCC], 1, 
       [Define to 1 if your compiler supports GNU GCC-style variadic macros])
@@ -67,11 +67,11 @@ dnl @author James Yonan <jim@...41...>, Matthias Andree <matthias.andree@...83...
 AC_DEFUN([AX_CPP_VARARG_MACRO_ISO], [dnl
     AS_VAR_PUSHDEF([VAR],[ax_cv_cpp_vararg_macro_iso])dnl
     AC_CACHE_CHECK([for ISO C 1999 vararg macro support], VAR, [dnl
-      AC_COMPILE_IFELSE([
+      AC_COMPILE_IFELSE([AC_LANG_SOURCE([
 #define macro(a, ...) func(a, __VA_ARGS__)
 	int func(int a, int b, int c);
 	int test() { return macro(1, 2, 3); }
-	], [ VAR=yes ], [VAR=no])])
+	])], [ VAR=yes ], [VAR=no])])
     if test $VAR = yes ; then
     AC_DEFINE([HAVE_CPP_VARARG_MACRO_ISO], 1, 
       [Define to 1 if your compiler supports ISO C99 variadic macros])

--Apple-Mail=_D40D33E1-88C2-4B78-849C-EAAF47C99B37
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> On Mon, Feb 06, 2012 at 01:39:04PM +1000, Byron Ellacott wrote:
>> Yep, debian stable, and a client system of OS X 10.7.  I had to change a=
 few things in acinclude.m4 to get openvpn-testing to build for OS X, due t=
o the version of autoconf on the system, and I had to extend the permitted =
netbits further to accommodate the /116 I have, but after that, the VPN con=
nected and started passing IPv6 traffic.
>>=20
>> (Next problem: my /116 is not routed, the remote end gets NDs that the l=
inux kernel cannot or will not pass through to an internal interface, but t=
hat's nothing to do with OpenVPN).
>=20
> If you only have a single IPv6 network, and a incomplete to that, it
> might be more straightforward to run OpenVPN in tap mode and bridge=20
> between "eth0" and "tap0" on the server.

I'd looked very briefly at whether tap mode would work better in this case,=
 and it almost certainly will.  My aim is to demonstrate a VPN that support=
s both IPv6 and two-factor authentication, so I'll probably give bridge mod=
e a go to demonstrate packets can pass, then call it a success.

> "tun" and "server-ipv6" really is meant for routed subnets, not for
> addressess stolen from a subnet used on a different interface (you can
> do that with proxy-ND, but I'm not sure how to do that on Linux)

The subnet is only a /116, but it's not in use on eth0.  It's not routed, b=
ecause it's supposed to be used if you have more than one virtual host in t=
he pool and want to assign addresses according to your own scheme, so anoth=
er approach I could take to get packets flowing is to use an ND proxy daemo=
n.

> Much better: complain to your provider to give you a reasonable network,
> like a /56, and use one /64 on the LAN and another /64 for openvp-tun .-)

Yes, this would be better.  When we (eventually) deploy a v6 VPN for produc=
tion, it will be using APNIC's own address space, and we'll provide ourselv=
es with a proper /64.  In the case of linode, their initial proposal was to=
 offer a /128 and nothing more.  Given it's native v6, it's still a step up=
 from a thousand other virtual hosting companies :-)

  Byron=

--Apple-Mail=_D40D33E1-88C2-4B78-849C-EAAF47C99B37--


--CVXKxAdNG2kQIXaJ--

--hCenlVgnDQUGHXTR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTzD7zKkuBuNlUUl1AQJs2gQAk2YeI17gYH0R9Q7RuIprxCm9N8xxoWW/
pqblcM72EEX49yIHaNmfRmp87q3A+rtuPmRQnMYTtN48kEHi2Y/26WZcri/7WkQD
ZWEz34Z6FGrq05DNshx3jcvLoXklGLc79xB2J/iMFKK1y6B01OGNLfB6GiBCehxG
yCKZHvWQeZg=
=POz1
-----END PGP SIGNATURE-----

--hCenlVgnDQUGHXTR--

