From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 20 Jun 2023 15:53:10 +0200
Message-Id: <20230620135310.94455-6-frank@...2641...>
In-Reply-To: <20230620135310.94455-1-frank@...2641...>
References: <20230509111205.138997-1-frank@...2641...>
 <20230620135310.94455-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5] GHA: update to run-vcpkg@...2735...
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

Change-Id: I4183edacc0295e9671c586cfcd77cf687015a22c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/workflows/build.yaml | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5f0a0761..da2a427c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -52,11 +52,10 @@ jobs:
         uses: actions/checkout@...2689...
 
       - name: Restore from cache and install vcpkg
-        uses: lukka/run-vcpkg@...2637...
+        uses: lukka/run-vcpkg@...2735...
         with:
-          vcpkgGitCommitId: 'd10d511f25620ca0f315cd83dcef6485efc63010'
+          vcpkgGitCommitId: '1ba9a2591f15af5900f2ce2b3e2bf31771e3ac48'
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
-          appendedCacheKey: mingw_${{ matrix.arch }}
 
       - name: Run CMake with vcpkg.json manifest
         uses: lukka/run-cmake@...2637...
@@ -291,11 +290,10 @@ jobs:
         run: python -m pip install --upgrade pip docutils
 
       - name: Restore artifacts, or setup vcpkg (do not install any package)
-        uses: lukka/run-vcpkg@...2637...
+        uses: lukka/run-vcpkg@...2735...
         with:
-          vcpkgGitCommitId: 'd10d511f25620ca0f315cd83dcef6485efc63010'
+          vcpkgGitCommitId: '1ba9a2591f15af5900f2ce2b3e2bf31771e3ac48'
           vcpkgJsonGlob: '**/windows/vcpkg.json'
-          appendedCacheKey: msvc_${{ matrix.arch }}
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
         uses: lukka/run-cmake@...2637...
-- 
2.34.1


