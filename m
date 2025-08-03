From: Gert Doering <gert@...1296...>
Date: Sun,  3 Aug 2025 17:01:37 +0200
Message-ID: <20250803150143.3878-1-gert@...1296...>
In-Reply-To: <gerrit.1730386897000.I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff@...2715...>
References: <gerrit.1730386897000.I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v18] Define a .clang-format file for the
 project
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

Each of these statements has been reviewed but
not all of them are obvious.

Also add a pre-commit config to easily check the
formatting.

Change-Id: I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/790
This mail reflects revision 18 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.clang-format b/.clang-format
new file mode 100644
index 0000000..c314fca
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,51 @@
+---
+BasedOnStyle: Mozilla
+AccessModifierOffset: '-4'
+AlignAfterOpenBracket: Align
+AlignConsecutiveMacros:
+  Enabled: true
+  AcrossEmptyLines: false
+  AcrossComments: true
+AlignEscapedNewlines: Left
+AlignOperands: true
+AlignTrailingComments:
+  Kind: Always
+  OverEmptyLines: 1
+AllowAllParametersOfDeclarationOnNextLine: true
+AllowShortBlocksOnASingleLine: Never
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: None
+AllowShortIfStatementsOnASingleLine: Never
+AllowShortLoopsOnASingleLine: false
+BinPackArguments: true
+BinPackParameters: true
+BreakAfterReturnType: AllDefinitions
+BreakBeforeBinaryOperators: NonAssignment
+BreakBeforeBraces: Allman
+BreakBeforeTernaryOperators: true
+BreakStringLiterals: false
+ColumnLimit: '100'
+ContinuationIndentWidth: '4'
+DerivePointerAlignment: false
+IndentCaseLabels: true
+IndentGotoLabels: false
+IndentWidth: '4'
+IndentWrappedFunctionNames: false
+KeepEmptyLinesAtTheStartOfBlocks: false
+MaxEmptyLinesToKeep: '2'
+PointerAlignment: Right
+ReflowComments: true
+SortIncludes: false
+SpaceAfterCStyleCast: false
+SpaceBeforeAssignmentOperators: true
+SpaceBeforeParens: ControlStatements
+SpacesBeforeTrailingComments: '2'
+SpacesInParens: Never
+TabWidth: '4'
+TypeNames: [DWORD]
+UseTab: Never
+WhitespaceSensitiveMacros: [_STRINGIFY]
+---
+Language: C
+---
+Language: Cpp
diff --git a/.pre-commit-config.yaml b/.pre-commit-config.yaml
new file mode 100644
index 0000000..c1bca47
--- /dev/null
+++ b/.pre-commit-config.yaml
@@ -0,0 +1,8 @@
+repos:
+  - repo: https://github.com/pre-commit/mirrors-clang-format
+    rev: 'v20.1.0'
+    hooks:
+      - id: clang-format
+        files: \.[ch]$
+        # preserve upstream formatting
+        exclude: ^(src/compat/compat-lz4\.[ch]|src/openvpn/ovpn_dco_(linux|win)\.h)$

