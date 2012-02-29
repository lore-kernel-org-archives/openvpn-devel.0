From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:28:01 +0200
Message-Id: <1330547285-18481-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [easy-rsa 0/4] standalone package
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>

1. Make easy-rsa standalone package.
2. Package.
3. Add spec file.

Alon Bar-Lev (4):
  cleanup: fix execute permission
  build: simple autotools build
  build: doc
  packaging: rpm: initial add

 .gitignore                       |    9 +
 COPYING                          |   42 +++++
 COPYRIGHT.GPL                    |  339 ++++++++++++++++++++++++++++++++++++++
 Makefile.am                      |   50 ++++++
 configure.ac                     |   55 ++++++
 distro/Makefile.am               |   15 ++
 distro/rpm/Makefile.am           |   15 ++
 distro/rpm/easy-rsa.spec.in      |   68 ++++++++
 doc/Makefile.am                  |   16 ++
 doc/README-1.0                   |  161 ++++++++++++++++++
 doc/README-2.0                   |  229 +++++++++++++++++++++++++
 easy-rsa/1.0/README              |  161 ------------------
 easy-rsa/2.0/Makefile            |   13 --
 easy-rsa/2.0/README              |  229 -------------------------
 14 files changed, 999 insertions(+), 403 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 COPYING
 create mode 100644 COPYRIGHT.GPL
 create mode 100644 Makefile.am
 create mode 100644 configure.ac
 create mode 100644 distro/Makefile.am
 create mode 100644 distro/rpm/Makefile.am
 create mode 100644 distro/rpm/easy-rsa.spec.in
 create mode 100644 doc/Makefile.am
 create mode 100644 doc/README-1.0
 create mode 100644 doc/README-2.0
 delete mode 100644 easy-rsa/1.0/README
 mode change 100644 => 100755 easy-rsa/1.0/list-crl
 mode change 100644 => 100755 easy-rsa/1.0/make-crl
 mode change 100644 => 100755 easy-rsa/1.0/revoke-crt
 delete mode 100644 easy-rsa/2.0/Makefile
 delete mode 100644 easy-rsa/2.0/README
 mode change 100755 => 100644 easy-rsa/2.0/openssl-0.9.6.cnf
 mode change 100755 => 100644 easy-rsa/2.0/openssl-0.9.8.cnf
 mode change 100755 => 100644 easy-rsa/2.0/openssl-1.0.0.cnf
 mode change 100755 => 100644 easy-rsa/2.0/vars
 mode change 100755 => 100644 easy-rsa/Windows/init-config.bat

-- 
1.7.3.4


