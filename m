Message-ID: <4F881610.5010304@...515...>
Date: Fri, 13 Apr 2012 15:03:28 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] MSVC build tests on Git "master"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

I did a number of MSVC build tests using Visual Studio 2010 Express. I
tried both Git "master"[1] and Alon's openvpn-build repo[2].

I encountered a number of issues with [1]. First, unlike in [2],
dependency fetching is not automatic - not sure if that's intentional,
but it is/was a really nice feature. Due to this, "master"[1] did not
build at all[3] without copying the build dependencies to a directory
manually, and adding a "msvc-build-env-local.bat" to point the build to
those:

set OPENVPN_DEPROOT=c:\Users\Samuli\openvpn-build\build-deps-alon
set OPENSSL_HOME=%OPENVPN_DEPROOT%\openssl-1.0.0g
set LZO_HOME=%OPENVPN_DEPROOT%\lzo-2.06
set PKCS11H_HOME=%OPENVPN_DEPROOT%\pkcs11-helper-1.10
set TAP_WINDOWS_HOME=%OPENVPN_DEPROOT%\tap-windows-9.9

This allowed the build to proceed, but then I got tons of errors. Those
seem to be caused by Visual Studio 2010 peculiarities; see [4] for a
partial log. The full error log is 1396k in size - If you need it just
let me know.

Samuli

[1]  <git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn.git>
[2] <https://github.com/alonbl/openvpn-build.git>
[3] <http://pastie.org/3780063>
[4] <http://pastie.org/3780024>

