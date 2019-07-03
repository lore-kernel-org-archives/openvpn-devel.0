From: Gisle Vanem <gisle.vanem@...277...>
Message-ID: <aa4f4026-a684-f96d-c8cb-d4f8a3468c4c@...277...>
Date: Wed, 3 Jul 2019 15:45:34 +0200
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel] Wrong FILETYPE in .rc files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

I noticed the .rc-files for programs uses
'FILETYPE 0x2L'. The 0x2L' is for a .DLL (VFT_DLL).

Ref: Win-Kit's 'um/verrsrc.h':
   #define VFT_DLL 0x00000002L

Hence these '0x2L' should be replaced with 'VFT_APP':

--- a/src/openvpn/openvpn_win32_resources.rc 2016-11-06 10:54:00
+++ b/src/openvpn/openvpn_win32_resources.rc 2019-07-03 11:54:06
@@ -19,7 +19,7 @@
   FILEFLAGS 0x0L
  #endif
   FILEOS 0x40004L
- FILETYPE 0x2L
+ FILETYPE VFT_APP
   FILESUBTYPE 0x0L
  BEGIN
      BLOCK "StringFileInfo"

--- a/src/openvpnserv/openvpnserv_resources.rc 2016-11-06 10:54:01
+++ b/src/openvpnserv/openvpnserv_resources.rc 2019-07-03 11:54:25
@@ -19,7 +19,7 @@
   FILEFLAGS 0x0L
  #endif
   FILEOS 0x40004L
- FILETYPE 0x2L
+ FILETYPE VFT_APP
   FILESUBTYPE 0x0L
  BEGIN
      BLOCK "StringFileInfo"


-- 
--gv

