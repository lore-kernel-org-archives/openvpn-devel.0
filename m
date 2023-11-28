From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Nov 2023 11:37:40 +0100
Message-Id: <20231128103740.61160-1-frank@...2641...>
In-Reply-To: <gerrit.1700571255000.I7da7c2d7d34c7e5efd52d448646b4398a1005e77@...2715...>
References: <gerrit.1700571255000.I7da7c2d7d34c7e5efd52d448646b4398a1005e77@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] configure.ac: Remove unused
 AC_TYPE_SIGNAL macro
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne-openvpn@...1227...>

Recent autoconf warns:
configure.ac:448: warning: The macro `AC_TYPE_SIGNAL' is obsolete.

And it turns out that we do not actually use RETSIGTYPE.
Additionally, there is no reason to do so since as the
autoconf documentation says:
"These days, it is portable to assume C89, and that signal
handlers return void, without needing to use this macro or
RETSIGTYPE."

Change-Id: I7da7c2d7d34c7e5efd52d448646b4398a1005e77
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/453
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/configure.ac b/configure.ac
index 84eaad6..5cc55c3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -445,7 +445,6 @@
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
 AC_TYPE_UID_T
-AC_TYPE_SIGNAL
 AX_TYPE_SOCKLEN_T
 AC_CHECK_SIZEOF([unsigned int])
 AC_CHECK_SIZEOF([unsigned long])

