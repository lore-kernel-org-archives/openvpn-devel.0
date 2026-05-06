From: Gert Doering <gert@...1296...>
Date: Wed,  6 May 2026 16:59:28 +0200
Message-ID: <20260506145933.22301-1-gert@...1296...>
In-Reply-To: <gerrit.1778070626000.I7cf7146c3c4f1a01b0bcb57e03d09b32f8b59780@...2715...>
References: <gerrit.1778070626000.I7cf7146c3c4f1a01b0bcb57e03d09b32f8b59780@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] t_client.sh: Do not use CA_CERT variable
 as indicator for good .rc file
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

t_client.sh doesn't actually care about this variable, and our
.rc files do not use it anymore. If you really want to dynamically
skip running t_client.sh just set TEST_RUN_LIST to empty in the .rc
file.

Change-Id: I7cf7146c3c4f1a01b0bcb57e03d09b32f8b59780
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1664
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1664
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index a49de40..48e2446 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -62,11 +62,6 @@
     exit 1
 fi
 
-if [ -z "$CA_CERT" ] ; then
-    echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
-    exit "${TCLIENT_SKIP_RC}"
-fi
-
 if [ -z "$TEST_RUN_LIST" ] ; then
     echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
     exit "${TCLIENT_SKIP_RC}"

