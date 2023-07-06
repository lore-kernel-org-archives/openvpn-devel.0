From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  6 Jul 2023 12:04:07 +0200
Message-Id: <20230706100407.231175-1-frank@...2641...>
In-Reply-To: <20230704130902.105585-1-frank@...2641...>
References: <20230704130902.105585-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] GHA: Add work-around for rst2*.py not being
 directly executable on Windows
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

We write a small .bat file wrapper and then force CMake
to use that.

Note that we need to specify the path with / instead of \
as path separator because otherwise run-cmake action will
mangle it.

Change-Id: I05d3f7f3f7f7418d1977e523c6dcfb6fa5feb604
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/workflows/build.yaml | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

This is an alternate patch to "CMake: Support doc builds on
Windows machines that do not have .py file association" since
there was some doubt on IRC whether we want to have the complexity
inside of CMake or should delegate that to the caller.

Let me know your opinions.

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index da2a427c..72edb089 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -286,8 +286,25 @@ jobs:
       - uses: actions/checkout@...2689...
       - uses: lukka/get-cmake@...2729...
 
+      # since we can't execute .py files directly, do a workaround for rst2html,rst2man
+      - name: Determine Python script path
+        run: |
+          import os
+          import sysconfig
+          scripts_path = sysconfig.get_path("scripts",f"{os.name}")
+          with open(os.environ["GITHUB_ENV"], "a") as env:
+            print(f"PYTHON_SCRIPTS_DIR={scripts_path}", file=env)
+        shell: python
       - name: Install rst2html
-        run: python -m pip install --upgrade pip docutils
+        run: |
+          python -m pip install --upgrade pip docutils
+          $install_dir = "${{ runner.workspace }}\docutils"
+          mkdir $install_dir
+          echo "python $Env:PYTHON_SCRIPTS_DIR\rst2html.py %*" > $install_dir\rst2html.bat
+          cat $install_dir\rst2html.bat
+          echo "python $Env:PYTHON_SCRIPTS_DIR\rst2man.py %*" > $install_dir\rst2man.bat
+          $safe_path = $install_dir.replace("\", "/")
+          echo "DOCUTILS=$safe_path" >> "$Env:GITHUB_ENV"
 
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2735...
@@ -300,6 +317,7 @@ jobs:
         if: ${{ matrix.arch == 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
+          configurePresetAdditionalArgs: "[`-DRST2HTML=${{ env.DOCUTILS }}/rst2html.bat`, `-DRST2MAN=${{ env.DOCUTILS }}/rst2man.bat`]"
           buildPreset: win-${{ matrix.arch }}-release
 
       - name: Run CMake with vcpkg.json manifest
@@ -307,6 +325,7 @@ jobs:
         if: ${{ matrix.arch != 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
+          configurePresetAdditionalArgs: "[`-DRST2HTML=${{ env.DOCUTILS }}/rst2html.bat`, `-DRST2MAN=${{ env.DOCUTILS }}/rst2man.bat`]"
           buildPreset: win-${{ matrix.arch }}-release
           testPreset: win-${{ matrix.arch }}-release
 
-- 
2.34.1


