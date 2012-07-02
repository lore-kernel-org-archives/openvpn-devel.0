Message-ID: <4FF1546D.4090907@...1114...>
Date: Mon, 02 Jul 2012 09:57:33 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Build issues on ScientificLinux 6.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi Alon & al,

Just tried to do a scratch build on SL6.2 from the git tree.

- -------------------------------------------------------------
$ autoreconf -vi
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal -I m4
autoreconf: configure.ac: tracing
autoreconf: configure.ac: not using Libtool
autoreconf: running: /usr/bin/autoconf
configure.ac:380: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL
      If this token and others are legitimate, please use
m4_pattern_allow.
      See the Autoconf documentation.
configure.ac:381: error: possibly undefined macro: AC_LIBTOOL_RC
configure.ac:382: error: possibly undefined macro: AC_PROG_LIBTOOL
autoreconf: /usr/bin/autoconf failed with exit status: 1
$
- -------------------------------------------------------------

autoconf-2.63-5.1.el6.noarch
automake-1.11.1-1.2.el6.noarch

Can we please fix this?  The workaround currently is to do 'make dist'
on box where autoreconf can complete.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/xVGsACgkQDC186MBRfrrrcACfbfCVnRovD2fJ0QPt6VQl3/fI
di0An0htzDrWY3VXaQcSHI2a6Iz67hmn
=W8/1
-----END PGP SIGNATURE-----

