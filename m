Date: Sat, 28 Apr 2012 11:40:02 -0700
From: Alon Bar-Lev <alon.barlev@...277...>
Message-ID: <4f9c3982826e1_1206198fae8102818@...1710...>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--==_mimepart_4f9c39827ff12_1206198fae8102642";
	charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Openvpn-devel] [OpenVPN/openvpn-build] d0f061: build.bat: chdir
 with change drive to script locat...
Reply-To: Alon Bar-Lev <alon.barlev@...277...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net



----==_mimepart_4f9c39827ff12_1206198fae8102642
Date: Sat, 28 Apr 2012 11:40:02 -0700
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-ID: <4f9c3982816a2_1206198fae81027eb@...1710...>

  Branch: refs/heads/master
  Home:   https://github.com/OpenVPN/openvpn-build
  Commit: d0f06178a3dcd3d9ffad713233b6ec2f39c66b78
      https://github.com/OpenVPN/openvpn-build/commit/d0f06178a3dcd3d9ffad713233b6ec2f39c66b78
  Author: Alon Bar-Lev <alon.barlev@...277...>
  Date:   2012-04-28 (Sat, 28 Apr 2012)

  Changed paths:
    M msvc/build.bat

  Log Message:
  -----------
  build.bat: chdir with change drive to script location

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>


diff --git a/msvc/build.bat b/msvc/build.bat
index 716f560..a4d987a 100644
--- a/msvc/build.bat
+++ b/msvc/build.bat
@@ -27,7 +27,7 @@ rem
 
 setlocal ENABLEDELAYEDEXPANSION
 
-cd %0\..
+cd /d %0\..
 SET ROOT=%CD%
 
 call build-env.bat


================================================================
  Commit: af4852a58a759dda3b20ce9d515cda6dbff168b3
      https://github.com/OpenVPN/openvpn-build/commit/af4852a58a759dda3b20ce9d515cda6dbff168b3
  Author: Alon Bar-Lev <alon.barlev@...277...>
  Date:   2012-04-28 (Sat, 28 Apr 2012)

  Changed paths:
    M msvc/build.bat

  Log Message:
  -----------
  Merge pull request #1 from alonbl/master

build.bat: chdir with change drive to script location


diff --git a/msvc/build.bat b/msvc/build.bat
index 716f560..a4d987a 100644
--- a/msvc/build.bat
+++ b/msvc/build.bat
@@ -27,7 +27,7 @@ rem
 
 setlocal ENABLEDELAYEDEXPANSION
 
-cd %0\..
+cd /d %0\..
 SET ROOT=%CD%
 
 call build-env.bat


================================================================
Compare: https://github.com/OpenVPN/openvpn-build/compare/cf91c13...af4852a

----==_mimepart_4f9c39827ff12_1206198fae8102642--

