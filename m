From: Gert Doering <gert@...1296...>
Date: Mon,  4 Aug 2025 15:34:07 +0200
Message-ID: <20250804133413.24729-1-gert@...1296...>
In-Reply-To: <gerrit.1754309687000.I9159e2e354170ad6dbed5a6ce620f57fa8ab128e@...2715...>
References: <gerrit.1754309687000.I9159e2e354170ad6dbed5a6ce620f57fa8ab128e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: enable -Werror for mbedTLS v3 and
 AWS LC builds
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

Because we can and so we should.

Change-Id: I9159e2e354170ad6dbed5a6ce620f57fa8ab128e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1128
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index cc17fba..0f88d0c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -425,7 +425,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=mbedtls
+        run: ./configure --with-crypto-library=mbedtls --enable-werror
       - name: make all
         run: make -j3
       - name: configure checks
@@ -489,7 +489,7 @@
           OPENSSL_CFLAGS="-I/${{ env.AWS_LC_INSTALL }}/include" \
           OPENSSL_LIBS="-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto" \
           LDFLAGS="-Wl,-rpath=/${{ env.AWS_LC_INSTALL }}/lib" \
-          ./configure --with-crypto-library=openssl
+          ./configure --with-crypto-library=openssl --enable-werror
       - name: make all
         run: make -j3
       - name: configure checks

