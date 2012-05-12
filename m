From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:03:53 +0300
Message-Id: <1336849433-23066-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: insall README* document using build
	system
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
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Purpose: make distro packager task simpler, more flexible to provide
more documentation without changing the packaging script.

Remove installation related documents from rpm as package already
installed when viewed.

+Workaround rpm bug[1].

[1] http://rpm.org/ticket/836

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 Makefile.am                |    3 +++
 distro/rpm/openvpn.spec.in |   11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 33dfcd6..c580579 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -57,6 +57,9 @@ endif
 SUBDIRS = build distro include src sample doc tests
 
 dist_doc_DATA = \
+	README \
+	README.IPv6 \
+	README.polarssl \
 	COPYRIGHT.GPL \
 	COPYING
 
diff --git a/distro/rpm/openvpn.spec.in b/distro/rpm/openvpn.spec.in
index d9158c1..a6f31bd 100644
--- a/distro/rpm/openvpn.spec.in
+++ b/distro/rpm/openvpn.spec.in
@@ -164,6 +164,10 @@ done
 
 %__mv -f src/plugins/README src/plugins/README.plugins
 
+# Install extra %doc stuff
+cp -r AUTHORS ChangeLog NEWS contrib/ sample/ src/plugins/README.* \
+	"%{buildroot}/%{_docdir}/%{name}-%{version}"
+
 #
 # Clean section
 #
@@ -207,13 +211,15 @@ fi
 #
 # Files section
 #
+# don't use %doc as old rpmbuild removes it[1].
+# [1] http://rpm.org/ticket/836
 
 %files
 %defattr(-,root,root)
-%doc AUTHORS ChangeLog COPYING COPYRIGHT.GPL INSTALL NEWS PORTS README 
 %{_mandir}
 %{_sbindir}/%{name}
 %{_datadir}/%{name}
+%{_docdir}/%{name}-%{version}
 %dir /etc/%{name}
 %if "%{VENDOR}" == "SuSE"
 /etc/init.d/%{name}
@@ -221,9 +227,6 @@ fi
 /etc/rc.d/init.d/%{name}
 %endif
 
-# Install extra %doc stuff
-%doc contrib/ sample/ src/plugins/README.*
-
 %files devel
 %defattr(-,root,root)
 %{_includedir}/*
-- 
1.7.3.4


