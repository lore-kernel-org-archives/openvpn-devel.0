From: Gert Doering <gert@...1296...>
Date: Mon,  1 Dec 2025 10:01:03 +0100
Message-ID: <20251201090110.5487-1-gert@...1296...>
In-Reply-To: <gerrit.1764370297000.Ic4e233c788b16a862c1fddcf314a3da661072fb5@...2715...>
References: <gerrit.1764370297000.Ic4e233c788b16a862c1fddcf314a3da661072fb5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Set UTF-8 as the codepage using manifest
 declaration
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

From: Selva Nair <selva.nair@...277...>

Works on Windows 10+. This ensures any UTF-8 string we pass to
ANSI API will not get interpreted in some local code page
in effect at runtime.

Although we do not use any such API, OpenSSL dll we link to
does (e.g., the store API used for reading certificate and
key from files). OpenSSL may fix this in future versions,
but this is an easy workaround that looks harmless and appropriate.

Fixes failure to read certificates when filenames contain non-ascii
characters reported by: Carsten Mietzsch <Carsten.Mietzsch@...2971...>

Ref: https://learn.microsoft.com/en-us/windows/apps/design/globalizing/use-utf8-code-page

Change-Id: Ic4e233c788b16a862c1fddcf314a3da661072fb5
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1413
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1413
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/openvpn.manifest b/src/openvpn/openvpn.manifest
index fa5b3d7..f964152 100644
--- a/src/openvpn/openvpn.manifest
+++ b/src/openvpn/openvpn.manifest
@@ -14,6 +14,11 @@
             <supportedOS Id="{e2011457-1546-43c5-a5fe-008deee3d3f0}"/>
         </application>
     </compatibility>
+    <application>
+        <windowsSettings>
+            <activeCodePage xmlns="http://schemas.microsoft.com/SMI/2019/WindowsSettings">UTF-8</activeCodePage>
+        </windowsSettings>
+    </application>
     <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
         <security>
             <requestedPrivileges>

