Message-Id: <494BA9FE020000BC00074B9E@...1170...>
Date: Fri, 19 Dec 2008 14:04:46 +0100
From: "Svein Hansen" <Svein.Hansen@...1133...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Building a Windows installer.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi

When doing a ./domake-win I get some errors:

*
install-win32/buildinstaller: /c/Program Files/NSIS/makensis: No such
file or directory
I'm using a Norwegian version of XP. 
So the correct path for me is: /c/Programfiler/NSIS/makensis
Maybe this should be fixed to also work for localized versions of
Windows?

*
FunctionEnd
!define: "SF_SELECTED" already defined!
Error in script "openvpn.nsi" on line 265 -- aborting creation process
Is IT safe to just comment out the line?: #!define SF_SELECTED 1


So a request...:
On Vista, users need to run OpenVPN as administrator(to set routes)
Can this feature be added to the source?
( or is there a reason that it's not included? )

It would have been nice if the users didn't have to fix this
themselves.
(right-click on icon, set to "run as admin..")

I've added some code in openvpn.nsi:

--- openvpn.nsi.orig    2008-12-19 13:49:05.000000000 +0100
+++ openvpn.nsi 2008-12-19 08:33:28.000000000 +0100
@@ -426,6 +426,10 @@
 ; tap-64bit:

   DetailPrint "We are running on a 64-bit system."
+
+  SetRegView 64
+  WriteRegStr HKLM "Software\Microsoft\Windows
NT\CurrentVersion\AppCompatFlags\Layers"
"$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADMIN"
+  SetRegView 32

   SetOutPath "$INSTDIR\bin"

@@ -442,6 +446,8 @@
 tap-32bit:

   DetailPrint "We are running on a 32-bit system."
+  WriteRegStr HKLM "Software\Microsoft\Windows
NT\CurrentVersion\AppCompatFlags\Layers"
"$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADMIN"
+

   SetOutPath "$INSTDIR\bin"
   File "${GEN}\tapinstall\i386\tapinstall.exe"

This is maybe not the best way to do it...but it works..

Svein Hansen

