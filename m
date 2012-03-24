From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 24 Mar 2012 09:58:35 +0200
Message-Id: <1332575918-3384-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <4F6D06C5.3030408@...1114...>
References: <4F6D06C5.3030408@...1114...>
Subject: [Openvpn-devel] [PATCH 3/6] tree: ChangeLog: add ident attribute
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

---
 .gitattributes |    1 +
 ChangeLog      |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 .gitattributes

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 0000000..9cf9e1f
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1 @@
+ChangeLog ident
diff --git a/ChangeLog b/ChangeLog
index d498344..d7cc77c 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,8 @@
 OpenVPN Change Log
 Copyright (C) 2002-2011 OpenVPN Technologies, Inc. <sales@...515...>
 
+$Id$
+
 2012.02.21 -- Version 2.3-alpha1
 Adriaan de Jong (127):
       Added Doxygen doxyfile
-- 
1.7.3.4


