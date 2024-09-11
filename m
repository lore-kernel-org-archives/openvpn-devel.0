From: Gert Doering <gert@...1296...>
Date: Wed, 11 Sep 2024 16:42:31 +0200
Message-ID: <20240911144231.32553-1-gert@...1296...>
In-Reply-To: <gerrit.1725974500000.I86ceceb4e1c716b33c6c6ec8853eca0fb4b394f1@...2715...>
References: <gerrit.1725974500000.I86ceceb4e1c716b33c6c6ec8853eca0fb4b394f1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Update dependency Mbed-TLS/mbedtls
 to v3.6.1
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

Requires submodule checkout.

Change-Id: I86ceceb4e1c716b33c6c6ec8853eca0fb4b394f1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/741
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 6207c95..8f0a7b5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -404,9 +404,10 @@
         uses: actions/checkout@...2691...
         with:
           path: mbedtls
+          submodules: true
           # versioning=semver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.5.2
+          ref: v3.6.1
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=1
         working-directory: mbedtls

