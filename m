From: Gert Doering <gert@...1296...>
Date: Fri,  5 Jan 2024 15:23:39 +0100
Message-ID: <20240105142340.25735-1-gert@...1296...>
In-Reply-To: <gerrit.1703674237000.Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71@...2715...>
References: <gerrit.1703674237000.Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: increase verbosity for make check
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

Make sure we get to see the test-suite.log on
failure.

Change-Id: Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/485
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 4393f5c..51100c3 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -163,7 +163,7 @@
       - name: make all
         run: make -j3
       - name: make check
-        run: make check
+        run: make check VERBOSE=1
 
   ubuntu-clang-asan:
     strategy:
@@ -190,7 +190,7 @@
       - name: make all
         run: make -j3
       - name: make check
-        run: make check
+        run: make check VERBOSE=1
 
   macos:
     strategy:
@@ -239,7 +239,7 @@
       - name: make all
         run: make -j4
       - name: make check
-        run: make check
+        run: make check VERBOSE=1
 
   msvc:
       strategy:
@@ -348,7 +348,7 @@
       - name: make all
         run: make -j3
       - name: make check
-        run: make check
+        run: make check VERBOSE=1
 
   mbedtls3:
     strategy:
@@ -399,4 +399,4 @@
       - name: make all
         run: make -j3
       - name: make check
-        run: make check
+        run: make check VERBOSE=1

