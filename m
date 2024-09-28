From: Gert Doering <gert@...1296...>
Date: Sat, 28 Sep 2024 22:05:08 +0200
Message-ID: <20240928200508.23747-1-gert@...1296...>
In-Reply-To: <gerrit.1727186481000.Iec1953415afb53755488dd44407568e72d28e854@...2715...>
References: <gerrit.1727186481000.Iec1953415afb53755488dd44407568e72d28e854@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] t_client.sh: conditionally skip
 ifconfig+route check
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

For --dev null or --dev-type af_unix:lwipopenvn tests, there will be
no visible change to ifconfig or route output, so tests will fail
("how can this be?").  Set EXPECT_IFCONFIG4_<n>=- to skip this
check.

(Simply leaving both EXPECT_IFCONFIG* vars empty and using that as
trigger would interfere with the magic from commit df0b00c25)

v2: fix string-equal comparison

Change-Id: Iec1953415afb53755488dd44407568e72d28e854
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/768
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index f6654dd..1ccadeb 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -225,6 +225,7 @@
     expect_list="$@"
 
     if [ -z "$expect_list" ] ; then return ; fi
+    if [ "$expect_list" = "-" ] ; then return ; fi
 
     for expect in $expect_list
     do
@@ -404,13 +405,17 @@
     output "save ifconfig+route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route.txt
 
-    output -n "compare pre-openvpn ifconfig+route with current values..."
-    if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
-	    $LOGDIR/$SUF:ifconfig_route.txt >/dev/null
-    then
-	fail "no differences between ifconfig/route before OpenVPN start and now."
+    if [ "$expect_ifconfig4" = "-" ] ; then
+        output "skip ifconfig+route check"
     else
-	output " OK!\n"
+	output -n "compare pre-openvpn ifconfig+route with current values..."
+	if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
+		$LOGDIR/$SUF:ifconfig_route.txt >/dev/null
+	then
+	    fail "no differences between ifconfig/route before OpenVPN start and now."
+	else
+	    output " OK!\n"
+	fi
     fi
 
     # post init script needed?

