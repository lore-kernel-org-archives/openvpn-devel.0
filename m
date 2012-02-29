From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:37:31 +0200
Message-Id: <1330547854-18889-6-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
References: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [tap-windows 08/11] cleanup: add TAP_WIN prefix to
	exports
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/dhcp.c        |    2 +-
 src/resource.rc   |    2 +-
 src/tap-windows.h |   46 ++++++++++++++++------------------------------
 src/tapdrvr.c     |   28 ++++++++++++++--------------
 4 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/src/dhcp.c b/src/dhcp.c
index 62602c9..89e601d 100755
--- a/src/dhcp.c
+++ b/src/dhcp.c
@@ -391,7 +391,7 @@ SendDHCPMsg (const TapAdapterPointer a,
 //===================================================================
 // Handle a BOOTPS packet produced by the local system to
 // resolve the address/netmask of this adapter.
-// If we are in TAP_IOCTL_CONFIG_DHCP_MASQ mode, reply
+// If we are in TAP_WIN_IOCTL_CONFIG_DHCP_MASQ mode, reply
 // to the message.  Return TRUE if we processed the passed
 // message, so that downstream stages can ignore it.
 //===================================================================
diff --git a/src/resource.rc b/src/resource.rc
index d5a7c35..ed7cf20 100755
--- a/src/resource.rc
+++ b/src/resource.rc
@@ -36,7 +36,7 @@
 
 #define VER_COMPANYNAME_STR         "The OpenVPN Project"
 #define VER_FILEDESCRIPTION_STR     "TAP-Windows Virtual Network Driver"
-#define VER_ORIGINALFILENAME_STR    TAP_COMPONENT_ID ".sys"
+#define VER_ORIGINALFILENAME_STR    PRODUCT_TAP_ID ".sys"
 #define VER_LEGALCOPYRIGHT_YEARS    "2003-2010"
 #define VER_LEGALCOPYRIGHT_STR      "OpenVPN Technologies, Inc."
 
diff --git a/src/tap-windows.h b/src/tap-windows.h
index 8dceda5..243a4a2 100755
--- a/src/tap-windows.h
+++ b/src/tap-windows.h
@@ -21,40 +21,32 @@
  *  distribution); if not, write to the Free Software Foundation, Inc.,
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-
-//===============================================
-// This file is included both by OpenVPN and
-// the TAP-Windows driver and contains definitions
-// common to both.
-//===============================================
-
-#ifndef HAVE_CONFIG_H
-#include "autodefs.h"
-#endif
+#ifndef __TAP_WIN_H
+#define __TAP_WIN_H
 
 //=============
 // TAP IOCTLs
 //=============
 
-#define TAP_CONTROL_CODE(request,method) \
+#define TAP_WIN_CONTROL_CODE(request,method) \
   CTL_CODE (FILE_DEVICE_UNKNOWN, request, method, FILE_ANY_ACCESS)
 
 // Present in 8.1
 
-#define TAP_IOCTL_GET_MAC               TAP_CONTROL_CODE (1, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_VERSION           TAP_CONTROL_CODE (2, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_MTU               TAP_CONTROL_CODE (3, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_INFO              TAP_CONTROL_CODE (4, METHOD_BUFFERED)
-#define TAP_IOCTL_CONFIG_POINT_TO_POINT TAP_CONTROL_CODE (5, METHOD_BUFFERED)
-#define TAP_IOCTL_SET_MEDIA_STATUS      TAP_CONTROL_CODE (6, METHOD_BUFFERED)
-#define TAP_IOCTL_CONFIG_DHCP_MASQ      TAP_CONTROL_CODE (7, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_LOG_LINE          TAP_CONTROL_CODE (8, METHOD_BUFFERED)
-#define TAP_IOCTL_CONFIG_DHCP_SET_OPT   TAP_CONTROL_CODE (9, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_MAC               TAP_WIN_CONTROL_CODE (1, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_VERSION           TAP_WIN_CONTROL_CODE (2, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_MTU               TAP_WIN_CONTROL_CODE (3, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_INFO              TAP_WIN_CONTROL_CODE (4, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT TAP_WIN_CONTROL_CODE (5, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_SET_MEDIA_STATUS      TAP_WIN_CONTROL_CODE (6, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_CONFIG_DHCP_MASQ      TAP_WIN_CONTROL_CODE (7, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_LOG_LINE          TAP_WIN_CONTROL_CODE (8, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT   TAP_WIN_CONTROL_CODE (9, METHOD_BUFFERED)
 
 // Added in 8.2
 
-/* obsoletes TAP_IOCTL_CONFIG_POINT_TO_POINT */
-#define TAP_IOCTL_CONFIG_TUN            TAP_CONTROL_CODE (10, METHOD_BUFFERED)
+/* obsoletes TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT */
+#define TAP_WIN_IOCTL_CONFIG_TUN            TAP_WIN_CONTROL_CODE (10, METHOD_BUFFERED)
 
 //=================
 // Registry keys
@@ -71,12 +63,6 @@
 #define USERMODEDEVICEDIR "\\\\.\\Global\\"
 #define SYSDEVICEDIR      "\\Device\\"
 #define USERDEVICEDIR     "\\DosDevices\\Global\\"
-#define TAPSUFFIX         ".tap"
+#define TAP_WIN_SUFFIX    ".tap"
 
-//=========================================================
-// TAP_COMPONENT_ID -- This string defines the TAP driver
-// type -- different component IDs can reside in the system
-// simultaneously.
-//=========================================================
-
-#define TAP_COMPONENT_ID TAP_ID
+#endif
diff --git a/src/tapdrvr.c b/src/tapdrvr.c
index ffc5813..d183902 100755
--- a/src/tapdrvr.c
+++ b/src/tapdrvr.c
@@ -31,8 +31,8 @@
 // By default we operate as a "tap" virtual ethernet
 // 802.3 interface, but we can emulate a "tun"
 // interface (point-to-point IPv4) through the
-// TAP_IOCTL_CONFIG_POINT_TO_POINT or
-// TAP_IOCTL_CONFIG_TUN ioctl.
+// TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT or
+// TAP_WIN_IOCTL_CONFIG_TUN ioctl.
 //======================================================
 
 #include "tap-windows.h"
@@ -824,7 +824,7 @@ CreateTapDevice (TapExtensionPointer p_Extension, const char *p_Name)
      "%s%s%s",
      SYSDEVICEDIR,
      l_UsableName,
-     TAPSUFFIX);
+     TAP_WIN_SUFFIX);
 
   if (l_Status != STATUS_SUCCESS)
     {
@@ -850,7 +850,7 @@ CreateTapDevice (TapExtensionPointer p_Extension, const char *p_Name)
      "%s%s%s",
      USERDEVICEDIR,
      l_UsableName,
-     TAPSUFFIX);
+     TAP_WIN_SUFFIX);
 
   if (l_Status != STATUS_SUCCESS)
     {
@@ -1914,7 +1914,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
       {
 	switch (l_IrpSp->Parameters.DeviceIoControl.IoControlCode)
 	  {
-	  case TAP_IOCTL_GET_MAC:
+	  case TAP_WIN_IOCTL_GET_MAC:
 	    {
 	      if (l_IrpSp->Parameters.DeviceIoControl.OutputBufferLength
 		  >= sizeof (MACADDR))
@@ -1930,7 +1930,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 		}
 	      break;
 	    }
-	  case TAP_IOCTL_GET_VERSION:
+	  case TAP_WIN_IOCTL_GET_VERSION:
 	    {
 	      const ULONG size = sizeof (ULONG) * 3;
 	      if (l_IrpSp->Parameters.DeviceIoControl.OutputBufferLength
@@ -1956,7 +1956,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 
 	      break;
 	    }
-	  case TAP_IOCTL_GET_MTU:
+	  case TAP_WIN_IOCTL_GET_MTU:
 	    {
 	      const ULONG size = sizeof (ULONG) * 1;
 	      if (l_IrpSp->Parameters.DeviceIoControl.OutputBufferLength
@@ -1974,7 +1974,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 
 	      break;
 	    }
-	  case TAP_IOCTL_GET_INFO:
+	  case TAP_WIN_IOCTL_GET_INFO:
 	    {
 	      char state[16];
 	      if (l_Adapter->m_InterfaceIsRunning)
@@ -2035,7 +2035,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 	    }
 
 #if DBG
-	  case TAP_IOCTL_GET_LOG_LINE:
+	  case TAP_WIN_IOCTL_GET_LOG_LINE:
 	    {
 	      if (GetDebugLine ((LPTSTR)p_IRP->AssociatedIrp.SystemBuffer,
 				l_IrpSp->Parameters.DeviceIoControl.OutputBufferLength))
@@ -2050,7 +2050,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 	    }
 #endif
 
-	  case TAP_IOCTL_CONFIG_TUN:
+	  case TAP_WIN_IOCTL_CONFIG_TUN:
 	    {
 	      if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength >=
 		  (sizeof (IPADDR) * 3))
@@ -2097,7 +2097,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 	      break;
 	    }
 
-	  case TAP_IOCTL_CONFIG_POINT_TO_POINT: // Obsoleted by TAP_IOCTL_CONFIG_TUN
+	  case TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT: // Obsoleted by TAP_WIN_IOCTL_CONFIG_TUN
 	    {
 	      if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength >=
 		  (sizeof (IPADDR) * 2))
@@ -2136,7 +2136,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 	      break;
 	    }
 
-	  case TAP_IOCTL_SET_MEDIA_STATUS:
+	  case TAP_WIN_IOCTL_SET_MEDIA_STATUS:
 	    {
 	      if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength >=
 		  (sizeof (ULONG) * 1))
@@ -2153,7 +2153,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 	      break;
 	    }
 
-	  case TAP_IOCTL_CONFIG_DHCP_MASQ:
+	  case TAP_WIN_IOCTL_CONFIG_DHCP_MASQ:
 	    {
 	      if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength >=
 		  (sizeof (IPADDR) * 4))
@@ -2194,7 +2194,7 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 	      break;
 	    }
 
-	  case TAP_IOCTL_CONFIG_DHCP_SET_OPT:
+	  case TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT:
 	    {
 	      if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength <=
 		  DHCP_USER_SUPPLIED_OPTIONS_BUFFER_SIZE
-- 
1.7.3.4


