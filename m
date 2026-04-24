From: Gert Doering <gert@...1296...>
Date: Fri, 24 Apr 2026 18:18:33 +0200
Message-ID: <20260424161840.5767-1-gert@...1296...>
In-Reply-To: <gerrit.1776903146000.I4d46c3672691b159cbd98a17020c4f30782bc202@...2715...>
References: <gerrit.1776903146000.I4d46c3672691b159cbd98a17020c4f30782bc202@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fixup: prompting password from management
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

From: Selva Nair <selva.nair@...277...>

Commit b450414 added logic for reading password from management
when not in file or inline, but it was made conditional on
`response_from_stdin` which is always true! Fix by explicitly
checking for `password_from_stdin`.

Change-Id: I4d46c3672691b159cbd98a17020c4f30782bc202
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1638
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1638
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 979293f..10bfc35 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -336,6 +336,7 @@
              */
             if (management && (flags & GET_USER_PASS_MANAGEMENT)
                 && management_query_user_pass_enabled(management)
+                && password_from_stdin
                 && !(flags & GET_USER_PASS_USERNAME_ONLY))
             {
                 msg(D_LOW,

