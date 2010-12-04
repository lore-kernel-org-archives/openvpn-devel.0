Message-ID: <4CFA299B.8010902@...1114...>
Date: Sat, 04 Dec 2010 12:44:27 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CF90B25.3010104@...515...>	<20101204025529.GA3200@...33...>	<4CFA1A01.2000602@...515...>
	<4CFA2341.3080905@...68...>
In-Reply-To: <4CFA2341.3080905@...68...>
Subject: Re: [Openvpn-devel] Error C2010 in openvpnserv.c during VS2008 build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Matthias Andree <matthias.andree@...68...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/12/10 12:17, Matthias Andree wrote:
| Am 04.12.2010 11:37, schrieb Samuli Sepp=E4nen:
|> Hi Matthias,
|>
|> Your patch fixes the issue.
|
| Hi Samuli,
|
| then please use the attached /updated/ patch (same code, different log en=
try).
| It fixes VS2008, and breaks compatibility with GCC before 3.0.
|
| For the records, it was discussed on IRC with David Sommerseth and yourse=
lf on
| 2010-12-04 around 11:08 UTC that we deem it unnecessary to keep GCC<  3.0
| compatibility for this new Windows-only code.
|

| From: Matthias Andree <matthias.andree@...68...>
| Date: Sat, 4 Dec 2010 03:51:11 +0100
| Subject: [PATCH] Change variadic macros to C99 style.
| MIME-Version: 1.0
| Content-Type: text/plain; charset=3DUTF-8
| Content-Transfer-Encoding: 8bit
|
| The macros used GCC's pre-C99 syntax, which could not be compiled with
| Microsoft Visual Studio 2008.
|
| Note this breaks compatibility with GCC versions before 3.0, which is
| deemed safe in a discussion on IRC with David Sommerseth and Samuli
| Sepp=E4nen on #openvpn-devel (RHEL 3 uses GCC 3.2 already).
|
| Compiled tested on VS2008 by Samuli, on Cygwin GCC 3.4 and GCC 4.3 by mys=
elf.
|
| Signed-off-by: Matthias Andree <matthias.andree@...68...>
Acked-by: David Sommerseth <dazo@...384...>

Applied to bugfix2.1 (commit 9469168e3abb09bd78297208a917ee4d9c025041) and
merged into allmerged and beta2.2.

In addition, gcc-2.95.3 is the last 2.xx release which was released in March
2001 [1].  To be very honest, I have no issues that we force users to upgra=
de
such ancient compilers.

As this will also only impact environments who compiles the openvpnserv
command as a Windows binary - either natively on a Windows box or
cross-compiling with such old compilers.  This program is also not used by
non-Windows plattforms at all.  Thus the impact on old compilers is minimal.

And if there are users still using the old 2.95 gcc compiler.  Consider to
upgrade soon.  OpenVPN will not support such old environments forever.  So =
far
we have occasionally checked if OpenVPN is compilable and works on RHEL4.
RHEL4 has EOL for the regular cycle in February 2012 [2], with an extended
support cycle until February 2015.  At that point we might move on to
something newer as the oldest supported environment.


Kind regards,

David Sommerseth



[1] <http://gcc.gnu.org/releases.html>
[2] <https://access.redhat.com/support/policy/updates/errata/>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkz6KZsACgkQDC186MBRfrqywwCghbs5sAeMuTljcd4ZvBSWVRNM
f+sAn28BSl3CRUAFJhSYTYYT4829etdX
=3DuIIS
-----END PGP SIGNATURE-----

