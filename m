From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  1 Dec 2023 13:36:49 +0100
Message-Id: <20231201123649.18127-1-frank@...2641...>
In-Reply-To: <gerrit.1701190231000.I9b8e69f2b9838cea4cb9001f4e8960b8a39724ef@...2715...>
References: <gerrit.1701190231000.I9b8e69f2b9838cea4cb9001f4e8960b8a39724ef@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: clean up libressl builds with newer
 libressl
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

- Update to latest stable release
- Work-around patches not required anymore
- Official URL of repo has changed

Change-Id: I9b8e69f2b9838cea4cb9001f4e8960b8a39724ef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master and release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/461
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index cd72f3d..4393f5c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -323,22 +323,11 @@
         uses: actions/checkout@...2689...
         with:
           path: libressl
-          repository: libressl-portable/portable
-          ref: v3.7.0
-      # LibreSSL has master in the OPENBSD_BRANCH by default even in the tagged releases
-      # Manually use the OpenBSD branch that is more appropiate and remove git pull that
-      # breaks when checking out a tag instead of branch
-      - name: "libressl: fix build"
-        run: |
-           echo libressl-v3.7.0 > OPENBSD_BRANCH
-           sed -i -e 's/ git pull --rebase//' update.sh
-        working-directory: libressl
+          repository: libressl/portable
+          ref: v3.8.2
       - name: "libressl: autogen.sh"
         run: ./autogen.sh
         working-directory: libressl
-      - name: "libressl: autoconf"
-        run: autoreconf -fvi
-        working-directory: libressl
       - name: "libressl: configure"
         run: ./configure
         working-directory: libressl

