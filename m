From: Simon Rozman <simon@...2293...>
Date: Mon, 22 Mar 2021 08:43:59 +0100
Message-Id: <20210322074359.527-1-simon@...2293...>
In-Reply-To: <a002b6f5-3201-cb8c-c05c-26d919dd8696@...1227...>
References: <a002b6f5-3201-cb8c-c05c-26d919dd8696@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 4/5] tapctl: Resolve MSVC C4996 warnings
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

wcsncat() was declared unsafe in favour of wcsncat_s(). However, the
string concatenation follows the string length check, making wcsncat()
safe too. Code analysis is just not smart enough (yet) to detect this.

The code was refactored to use wcscat_s() MSVC is considering as "safe".

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/tapctl/tap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index dd4a10a3..563c07f6 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -73,14 +73,15 @@ find_function(const WCHAR *libname, const char *funcname, HMODULE *m)
        return NULL;
     }
 
-    size_t len = _countof(libpath) - wcslen(libpath) - 1;
-    if (len < wcslen(libname) + 1)
+    /* +1 for the path seperator '\' */
+    const size_t path_length = wcslen(libpath) + 1 + wcslen(libname);
+    if (path_length >= _countof(libpath))
     {
        SetLastError(ERROR_INSUFFICIENT_BUFFER);
        return NULL;
     }
-    wcsncat(libpath, L"\\", len);
-    wcsncat(libpath, libname, len-1);
+    wcscat_s(libpath, _countof(libpath), L"\\");
+    wcscat_s(libpath, _countof(libpath), libname);
 
     *m = LoadLibraryW(libpath);
     if (*m == NULL)
-- 
2.30.0.windows.2


