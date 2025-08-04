From: Gert Doering <gert@...1296...>
Date: Mon,  4 Aug 2025 21:50:48 +0200
Message-ID: <20250804195054.21729-1-gert@...1296...>
In-Reply-To: <gerrit.1754309056000.I3046f4b09a4700001a1d9dcce802990dfa701b52@...2715...>
References: <gerrit.1754309056000.I3046f4b09a4700001a1d9dcce802990dfa701b52@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix build error with clang-cl on latest
 Windows SDK
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

Found when testing windows-2025 runner in GHA.
So switch to that to make sure the error is fixed.

Change-Id: I3046f4b09a4700001a1d9dcce802990dfa701b52
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1127
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index bd5895b..cc17fba 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -125,7 +125,7 @@
         arch: [x86, x64]
         test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
 
-    runs-on: windows-latest
+    runs-on: windows-2025
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
@@ -273,7 +273,7 @@
       env:
         BUILD_CONFIGURATION: Release
 
-      runs-on: windows-latest
+      runs-on: windows-2025
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
       - uses: lukka/get-cmake@...2897... # v4.0.3
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index e77f313..da53635 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -44,7 +44,7 @@
 #define srandom srand
 #endif
 
-#ifdef _MSC_VER /* Visual Studio */
+#if defined(_MSC_VER) && !defined(__clang__) /* Microsoft compiler */
 #define __func__ __FUNCTION__
 #define __attribute__(x)
 #endif

