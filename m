From: Gert Doering <gert@...1296...>
Date: Fri, 13 Mar 2026 16:30:01 +0100
Message-ID: <20260313153007.31810-1-gert@...1296...>
In-Reply-To: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
References: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] GHA: Install aws-lc under /opt/aws-lc
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

The previous installation inside the OpenVPN workspace directory
caused the AWS-LC installation to be deleted. And that caused to OpenSSL
to be used instead of AWS-LC during the build

This also removes the --enable-werror flag from AWS-LC because it
currently not even close to build without warnings.

Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1565
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1565
This mail reflects revision 4 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b213192..2a2616b 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -454,7 +454,7 @@
       CC: ${{matrix.cc}}
       CXX: ${{matrix.cxx}}
       UBSAN_OPTIONS: print_stacktrace=1
-      AWS_LC_INSTALL: ${{ github.workspace }}/aws-lc/aws-lc-install
+      AWS_LC_INSTALL: /opt/aws-lc
 
     steps:
       - name: Install dependencies
@@ -465,7 +465,7 @@
           path: aws-lc
           # versioning=semver-coerced
           repository: aws/aws-lc
-          ref: v1.67.0
+          ref: v1.70.0
       - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "AWS-LC: build"
         run: |
@@ -480,10 +480,10 @@
         run: autoreconf -fvi
       - name: configure with AWS-LC
         run: |
-          OPENSSL_CFLAGS="-I/${{ env.AWS_LC_INSTALL }}/include" \
-          OPENSSL_LIBS="-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto" \
-          LDFLAGS="-Wl,-rpath=/${{ env.AWS_LC_INSTALL }}/lib" \
-          ./configure --with-crypto-library=openssl --enable-werror
+          OPENSSL_CFLAGS="-I${{ env.AWS_LC_INSTALL }}/include" \
+          OPENSSL_LIBS="-L${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto" \
+          LDFLAGS="-Wl,-rpath=${{ env.AWS_LC_INSTALL }}/lib" \
+          ./configure --with-crypto-library=openssl
       - name: make all
         run: make -j3
       - name: configure checks

