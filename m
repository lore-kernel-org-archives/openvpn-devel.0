From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 25 Jan 2024 12:01:22 +0100
Message-Id: <20240125110122.16257-1-frank@...2641...>
In-Reply-To: <gerrit.1702310034000.I11e0091482d9acee89ca018374cb8d96d22f8514@...2715...>
References: <gerrit.1702310034000.I11e0091482d9acee89ca018374cb8d96d22f8514@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] forked-test-driver: Show test output
 always
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

We want to see the progress, at least for slow tests
like t_client.sh.

Change-Id: I11e0091482d9acee89ca018374cb8d96d22f8514
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/479
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/forked-test-driver b/forked-test-driver
index be73b80..6971dfb 100755
--- a/forked-test-driver
+++ b/forked-test-driver
@@ -108,9 +108,14 @@
 # Test script is run here. We create the file first, then append to it,
 # to ameliorate tests themselves also writing to the log file. Our tests
 # don't, but others can (automake bug#35762).
+# OVPN changes:
+#  - add tee to see output of tests
+#  - needs portable pipefail mechanism
+estatusfile="${trs_file}.exit"
 : >"$log_file"
-"$@" >>"$log_file" 2>&1
-estatus=$?
+("$@" 2>&1; estatus=$?; echo $estatus >"$estatusfile") | tee -a "$log_file"
+estatus=$(cat "$estatusfile")
+rm -f "$estatusfile"
 
 if test $enable_hard_errors = no && test $estatus -eq 99; then
   tweaked_estatus=1

