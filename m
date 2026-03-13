From: Gert Doering <gert@...1296...>
Date: Fri, 13 Mar 2026 18:53:16 +0100
Message-ID: <20260313175324.12121-1-gert@...1296...>
In-Reply-To: <gerrit.1773243451000.Ia929c949cceaabe21a2937ad3217052aec4b2b4c@...2715...>
References: <gerrit.1773243451000.Ia929c949cceaabe21a2937ad3217052aec4b2b4c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Show version and double check we use the
 right TLS library in Github Actions
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

We recently discovered that the AWS-LC builds in Github Actions were
actually using OpenSSL. This will now cause an error if something like
this happens in the future again.

Change-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1566
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1566
This mail reflects revision 3 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 2a2616b..dd8e472 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -363,6 +363,10 @@
         run: ./configure --with-crypto-library=openssl ${{matrix.configureflags}} --enable-werror
       - name: make all
         run: make -j3
+      - name: Ensure the build uses LibreSSL
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: LibreSSL"
       - name: configure checks
         run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
       - name: make check
@@ -422,6 +426,10 @@
         run: ./configure --with-crypto-library=mbedtls --enable-werror
       - name: make all
         run: make -j3
+      - name: Ensure the build uses mbed TLS 4.x
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: mbed TLS 4."
       - name: configure checks
         run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
       - name: make check
@@ -486,6 +494,10 @@
           ./configure --with-crypto-library=openssl
       - name: make all
         run: make -j3
+      - name: Ensure the build uses AWS-LC
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: AWS-LC"
       - name: configure checks
         run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
       - name: make check

