From: Arne Schwabe <arne@...1227...>
Date: Thu,  9 Feb 2023 17:31:15 +0100
Message-Id: <20230209163115.465548-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix LibreSSL not building in Github Actions
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

During the build of LibreSSL portable it pulls in a branch from OpenBSD
upstream. Unfortunately they use master there instead of a fixed branch.
So we work around this issue.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 132624547..5888e91e5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -415,6 +415,14 @@ jobs:
           path: libressl
           repository: libressl-portable/portable
           ref: v3.7.0
+      # LibreSSL has master in the OPENBSD_BRANCH by default even in the tagged releases
+      # Manually use the OpenBSD branch that is more appropiate and remove git pull that
+      # breaks when checking out a tag instead of branch
+      - name: "libressl: fix build"
+        run: |
+           echo libressl-v3.7.0 > OPENBSD_BRANCH
+           sed -i -e 's/ git pull --rebase//' update.sh
+        working-directory: libressl
       - name: "libressl: autogen.sh"
         run: ./autogen.sh
         working-directory: libressl
-- 
2.37.1 (Apple Git-137.1)


