Date: Fri, 8 Aug 2008 09:52:03 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20080808075203.GB8673@...33...>
References: <4892B01F.10208@...41...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <4892B01F.10208@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc9 released -- note security fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net

--n/aVsWSeQ4JHkrmm
Content-Type: multipart/mixed; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline

--H8ygTp4AXg6deix2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[Sorry James for the dupe - used the wrong sender for the list]

On Fri, 01 Aug 2008, James Yonan wrote:

> Download:
>=20
> http://openvpn.net/download.html
>=20
> 2008.07.31 -- Version 2.1_rc9
>=20
> * Security Fix -- affects non-Windows OpenVPN clients running
>    OpenVPN 2.1-beta14 through 2.1-rc8 (OpenVPN 2.0.x clients are NOT
>    vulnerable nor are any versions of the OpenVPN server vulnerable).
>    An OpenVPN client connecting to a malicious or compromised
>    server could potentially receive an "lladdr" or "iproute"
>    configuration directive from the server which could cause arbitrary
>    code execution on the client. A successful attack requires that (a)
>    the client has agreed to allow the server to push configuration
>    directives to it by including "pull" or the macro "client" in its
>    configuration file, (b) the client successfully authenticates the
>    server, (c) the server is malicious or has been compromised and is
>    under the control of the attacker, and (d) the client is running a
>    non-Windows OS.  Credit: David Wagner.
>=20
> * Miscellaneous defensive programming changes to multiple
>    areas of the code.  In particular, use of the system() call
>    for calling executables such as ifconfig, route, and
>    user-defined scripts has been completely revamped in favor
>    of execve() on unix and CreateProcess() on Windows.

Hi James,

while packaging the new release for FreeBSD ports, I made some
observations:

1 - --script-security is documented in openvpn --help,
    but not in the manual page.

2 - apparently the security issue has been assigned CVE-2008-3459 (at
    least that one references your changelog and adumbrates the
    described security issue you fixed).

3 - one part of the self-test suite ("make check") needs to be adjusted
    to cater for the tightened script security. Patch attached (against
    SVN) - it also adds retrying if the addresses are in use. Note there
    are two "svn propedit" or "svn propset" required for an additional
    --down script - see attached patch

Best regards
Matthias Andree

--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-selftests.patch"
Content-Transfer-Encoding: quoted-printable

Index: t_cltsrv.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- t_cltsrv.sh	(revision 3198)
+++ t_cltsrv.sh	(working copy)
@@ -1,7 +1,7 @@
 #! /bin/sh
 #
 # t_cltsrv.sh - script to test OpenVPN's crypto loopback
-# Copyright (C) 2005,2006  Matthias Andree
+# Copyright (C) 2005, 2006, 2008  Matthias Andree
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
@@ -38,22 +38,50 @@
     fi
     ;;
 esac
-echo "the following test will take about two minutes..." >&2
-set +e
-(
-./openvpn --cd "${srcdir}" ${addopts} --down 'echo "srv:${signal}" >&3 ; :=
 #' --tls-exit --ping-exit 180 --config sample-config-files/loopback-server=
 &
-./openvpn --cd "${srcdir}" ${addopts} --down 'echo "clt:${signal}" >&3 ; :=
 #' --tls-exit --ping-exit 180 --config sample-config-files/loopback-client
-) 3>log.$$.signal >log.$$ 2>&1
-e1=3D$?
-wait $!
-e2=3D$?
-grep -v ":inactive$" log.$$.signal >/dev/null && { cat log.$$.signal ; ech=
o ; cat log.$$ ; exit 1 ; }
=20
+# make sure that the --down script is executable -- fail (rather than
+# skip) test if it isn't.
+downscript=3D"t_cltsrv-down.sh"
+test -x "${srcdir}"/$downscript || chmod +x "${srcdir}"/$downscript || { e=
cho >&2 "$downscript is not executable, failing." ; exit 1 ; }
+echo "The following test will take about two minutes." >&2
+echo "If the addresses are in use, this test will retry up to two times." =
>&2
+
+# go
+success=3D0
+for i in 1 2 3 ; do
+  set +e
+  (
+  ./openvpn --script-security 2 --cd "${srcdir}" ${addopts} --setenv role =
srv --down "$downscript" --tls-exit --ping-exit 180 --config sample-config-=
files/loopback-server &
+  ./openvpn --script-security 2 --cd "${srcdir}" ${addopts} --setenv role =
clt --down "$downscript" --tls-exit --ping-exit 180 --config sample-config-=
files/loopback-client
+  ) 3>log.$$.signal >log.$$ 2>&1
+  e1=3D$?
+  wait $!
+  e2=3D$?
+  grep 'TCP/UDP: Socket bind failed on local address.*in use' log.$$ >/dev=
/null && {
+    echo 'address in use, retrying in 150 s'
+    sleep 150
+    continue
+  }
+  grep -v ':inactive$' log.$$.signal >/dev/null && { cat log.$$.signal ; e=
cho ; cat log.$$ ; exit 1 ; }
+  success=3D1
+  break
+done
+
 set -e
=20
-if [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ] ; then
-    cat log.$$
-    exit 1
+# exit code - defaults to 0, PASS
+ec=3D0
+
+if [ $success !=3D 1 ] ; then
+  # couldn't run test -- addresses in use, skip test
+  cat log.$$
+  ec=3D77
+elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ] ; then
+  # failure -- fail test
+  cat log.$$
+  ec=3D1
 fi
+
 rm log.$$ log.$$.signal
 trap 0
+exit $ec
Index: t_cltsrv-down.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- t_cltsrv-down.sh	(revision 0)
+++ t_cltsrv-down.sh	(revision 0)
@@ -0,0 +1,2 @@
+#! /bin/sh
+echo "${role}:${signal}" >&3

Property changes on: t_cltsrv-down.sh
___________________________________________________________________
Added: svn:executable
   + *
Added: svn:eol-style
   + native


--H8ygTp4AXg6deix2--

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkib+yMACgkQvmGDOQUufZW+DACfWVPYHXpBXGYW4iI+jiT5F+1m
k+8AoKCJqigWCFod45T7SBfHX8b+vsKN
=h4Ea
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--

