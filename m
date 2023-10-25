From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 25 Oct 2023 14:17:10 +0200
Message-Id: <20231025121710.1030736-1-frank@...2641...>
In-Reply-To: <gerrit.1697649699000.I8f06a1213fdca233671f8d5746216ae46e84233b@...2715...>
References: <gerrit.1697649699000.I8f06a1213fdca233671f8d5746216ae46e84233b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add --enable-werror to all platforms in
 Github Actions
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

Change-Id: I8f06a1213fdca233671f8d5746216ae46e84233b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/376
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 06567e0..60d3da5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -186,7 +186,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: CFLAGS="-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-omit-frame-pointer -O2" CC=clang ./configure --with-crypto-library=${{matrix.ssllib}}
+        run: CFLAGS="-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-omit-frame-pointer -O2" CC=clang ./configure --with-crypto-library=${{matrix.ssllib}} --enable-werror
       - name: make all
         run: make -j3
       - name: make check
@@ -355,7 +355,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=openssl ${{matrix.configureflags}}
+        run: ./configure --with-crypto-library=openssl ${{matrix.configureflags}} --enable-werror
       - name: make all
         run: make -j3
       - name: make check

