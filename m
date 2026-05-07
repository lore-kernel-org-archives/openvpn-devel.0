From: Gert Doering <gert@...1296...>
Date: Thu,  7 May 2026 09:53:15 +0200
Message-ID: <20260507075321.25123-1-gert@...1296...>
In-Reply-To: <gerrit.1778102459000.Icd8ea093dfe9f1888570f3d7b786b951b5262e47@...2715...>
References: <gerrit.1778102459000.Icd8ea093dfe9f1888570f3d7b786b951b5262e47@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco_freebsd: Add check_malloc_return
 after realloc
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

From: Frank Lichtenheld <frank@...2641...>

cppcheck complained about a potential memleak
due to realloc failure. But trying to handle that
is probably not useful. Just abort like we do
for other malloc failures.

Change-Id: Icd8ea093dfe9f1888570f3d7b786b951b5262e47
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1669
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1669
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 1fefb51..c9d4714 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -49,6 +49,8 @@
 knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164
 # FP: cppcheck seems to be confused since we cast the pointer to integer
 memleak:src/plugins/down-root/down-root.c:337
+# IGN: we just abort instead
+memleakOnRealloc:src/openvpn/dco_freebsd.c:845
 # FP: eventmsg.h is not built on Unix
 missingInclude:src/openvpnserv/common.c:25
 # IGN: strlen(NULL) is not nice code, but seems to work
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 718cd8b..eaca86b 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -842,6 +842,7 @@
 
 retry:
     buf = realloc(buf, buf_size);
+    check_malloc_return(buf);
     drv.ifd_len = buf_size;
     drv.ifd_data = buf;
 

