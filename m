From: Gert Doering <gert@...1296...>
Date: Mon,  6 May 2024 17:58:31 +0200
Message-ID: <20240506155831.3524-1-gert@...1296...>
In-Reply-To: <gerrit.1714664981000.Id95e0124d943912439c6ec6f562c0eb40d434163@...2715...>
References: <gerrit.1714664981000.Id95e0124d943912439c6ec6f562c0eb40d434163@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Only run coverity scan in
 OpenVPN/OpenVPN repository
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

From: Arne Schwabe <arne@...1227...>

This avoids the error message triggering every night that the run
failed in forked repositories

Change-Id: Id95e0124d943912439c6ec6f562c0eb40d434163
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/583
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index e289746..37b8102 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -6,6 +6,9 @@
 
 jobs:
   latest:
+    # Running coverity requires the secrets.COVERITY_SCAN_TOKEN token
+    # which is only available on the main repository
+    if: github.repository_owner == 'OpenVPN'
     runs-on: ubuntu-latest
     steps:
       - name: Check submission cache

