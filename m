From: Gert Doering <gert@...1296...>
Date: Tue,  7 Apr 2026 22:53:36 +0200
Message-ID: <20260407205344.31263-1-gert@...1296...>
In-Reply-To: <gerrit.1775592384000.I7f983168c263e49da7665fc20bd1ecdd426c21d0@...2715...>
References: <gerrit.1775592384000.I7f983168c263e49da7665fc20bd1ecdd426c21d0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: Remove redundant bit-wise
 operation
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

Found by cppcheck.

Change-Id: I7f983168c263e49da7665fc20bd1ecdd426c21d0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1623
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1623
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a2f9f09..ace25b9 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3410,7 +3410,7 @@
     ea[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
     ea[0].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
     ea[0].Trustee.ptstrName = (LPWSTR)svc_user->User.Sid;
-    ea[1].grfAccessPermissions = READ_CONTROL | SYNCHRONIZE | PROCESS_VM_READ | SYNCHRONIZE
+    ea[1].grfAccessPermissions = READ_CONTROL | PROCESS_VM_READ | SYNCHRONIZE
                                  | PROCESS_TERMINATE | PROCESS_QUERY_INFORMATION;
     ea[1].grfAccessMode = SET_ACCESS;
     ea[1].grfInheritance = NO_INHERITANCE;

