From: Henry Nestler <Henry.ne@...755...>
Date: Thu, 31 Aug 2006 10:05:51 +0200
Message-ID: <44F6985F.6060800@...755...>
References: <fe9771a80608281338h269bd873va16ace0effde172f@...278...>	<fe9771a80608281342j3aabdf58wa31266c8bd7da09f@...278...>
	<879fd0db0608290106mce513d3qd111d0ba10799fc4@...278...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020901070703040104000701"
In-Reply-To: <879fd0db0608290106mce513d3qd111d0ba10799fc4@...278...>
Sender: news <news@...165...>
Subject: [Openvpn-devel] [patch] Re: BSOD: Tap-Win32 crashes Vista
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020901070703040104000701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes for running TAP-Win32 on Vista (Beta):
- Gets MiniPortName with function NdisReadConfiguration, instand the
   direct pointer access into strcture NDIS_MINIPORT_BLOCK.
   On Windows2000 this function isn't supported, it falls back into
   older accessing with ugly pointer into the struct.  Checks ndis
   version before, to avoid BSOD.
- incrase driver version to 8.4, updated build date.
- build with DDK 3790.1830
- Files on http://home.arcor.de/henryn/OpenVPN-2.1beta14-tap32/

openvpn-2.1-tap32-vista.patch	: Source patch for openvpn-2.1_beta14
tap-win32-OpenVPN.src.zip	: Complete sources for tap driver
tap-win32-OpenVPN.i386.zip	: Driver, binary and symbols for OpenVPN

This is a backport from running tap driver under colinux.
Binaries for OpenVPN have not tested, I have no vpn installed.  Please 
give a feedback.

Thanks to Emre Erenoglu and Anoop G. for finding, testing and tips.

-- 
Henry N.

--------------020901070703040104000701
Content-Type: text/x-diff;
 name="openvpn-2.1-tap32-vista.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.1-tap32-vista.patch"

# Patchfile: openvpn-2.1-tap32-vista.patch
#
# Changes for running TAP-Win32 on Vista (Beta):
# - Gets MiniPortName with function NdisReadConfiguration, instand
#   the direct pointer access into strcture NDIS_MINIPORT_BLOCK.
#   On Windows2000 this function isn't supported, it falls back into
#   older accessing with ugly pointer into the struct.  Checks ndis
#   version before, to avoid BSOD.
# - incrase driver version to 8.4, update build date.
#
# Thanks to Emre Erenoglu and Anoop G. for finding, testing and tips.
#
# Henry N. <Henry at BigFoot.de>

---

 openvpn-2.1_beta14/tap-win32/SOURCES           |    2 
 openvpn-2.1_beta14/tap-win32/i386/OemWin2k.inf |    2 
 openvpn-2.1_beta14/tap-win32/resource.rc       |    2 
 openvpn-2.1_beta14/tap-win32/tapdrvr.c         |   74 +++++++++++++++++++------
 4 files changed, 62 insertions(+), 18 deletions(-)

======================================================================
diff -aur openvpn-2.1_beta14.old/tap-win32/i386/OemWin2k.inf openvpn-2.1_beta14/tap-win32/i386/OemWin2k.inf
--- openvpn-2.1_beta14.old/tap-win32/i386/OemWin2k.inf
+++ openvpn-2.1_beta14/tap-win32/i386/OemWin2k.inf
@@ -51,7 +51,7 @@
 
 ; This version number should match the version
 ; number given in SOURCES.
-   DriverVer=05/15/2004,8.00.00.0001
+   DriverVer=08/31/2006,8.00.00.0004
 
 [Strings]
    DeviceDescription = "TAP-Win32 Adapter V8"
diff -aur openvpn-2.1_beta14.old/tap-win32/resource.rc openvpn-2.1_beta14/tap-win32/resource.rc
--- openvpn-2.1_beta14.old/tap-win32/resource.rc
+++ openvpn-2.1_beta14/tap-win32/resource.rc
@@ -36,7 +36,7 @@
 #define VER_COMPANYNAME_STR         "The OpenVPN Project"
 #define VER_FILEDESCRIPTION_STR     "TAP-Win32 Virtual Network Driver"
 #define VER_ORIGINALFILENAME_STR    TAP_COMPONENT_ID ".sys"
-#define VER_LEGALCOPYRIGHT_YEARS    "2003-2004"
+#define VER_LEGALCOPYRIGHT_YEARS    "2003-2006"
 #define VER_LEGALCOPYRIGHT_STR      "OpenVPN Solutions LLC and Damion K. Wilson"
 
 
diff -aur openvpn-2.1_beta14.old/tap-win32/SOURCES openvpn-2.1_beta14/tap-win32/SOURCES
--- openvpn-2.1_beta14.old/tap-win32/SOURCES	2005-11-02 19:02:52.000000000 +0100
+++ openvpn-2.1_beta14/tap-win32/SOURCES	2006-08-31 01:21:00.000000000 +0200
@@ -15,7 +15,7 @@
 # config-win32.h
 C_DEFINES=
 C_DEFINES=$(C_DEFINES) -DTAP_DRIVER_MAJOR_VERSION=8
-C_DEFINES=$(C_DEFINES) -DTAP_DRIVER_MINOR_VERSION=3
+C_DEFINES=$(C_DEFINES) -DTAP_DRIVER_MINOR_VERSION=4
 
 # Use 00:FF:XX:XX:XX:XX format MAC addresses where
 # the Xs are random (like Linux tap driver).
diff -aur openvpn-2.1_beta14.old/tap-win32/tapdrvr.c openvpn-2.1_beta14/tap-win32/tapdrvr.c
--- openvpn-2.1_beta14.old/tap-win32/tapdrvr.c
+++ openvpn-2.1_beta14/tap-win32/tapdrvr.c
@@ -364,19 +364,6 @@
 				       AdapterHalt);
   l_Adapter->m_RegisteredAdapterShutdownHandler = TRUE;
 
-  //====================================
-  // Allocate and construct adapter name
-  //====================================
-
-  if (RtlUnicodeStringToAnsiString (
-       &l_Adapter->m_NameAnsi,
-       &((PNDIS_MINIPORT_BLOCK) p_AdapterHandle)->MiniportName,
-       TRUE) != STATUS_SUCCESS)
-    {
-      AdapterFreeResources (l_Adapter);
-      return NDIS_STATUS_RESOURCES;
-    }
-
   //============================================
   // Get parameters from registry which were set
   // in the adapter advanced properties dialog.
@@ -392,8 +379,66 @@
     l_Adapter->m_MediaState = FALSE;
 
     NdisOpenConfiguration (&status, &configHandle, p_ConfigurationHandle);
-    if (status == NDIS_STATUS_SUCCESS)
+    if (status != NDIS_STATUS_SUCCESS)
+      {
+	  DEBUGP (("[TAP] Couldn't open adapter registry\n"));
+	  AdapterFreeResources (l_Adapter);
+	  return status;
+      }
+
+    //====================================
+    // Allocate and construct adapter name
+    //====================================
+    {
+      NDIS_STRING key = NDIS_STRING_CONST("MiniportName");
+      NdisReadConfiguration (&status, &parm, configHandle, &key, NdisParameterString);
+      if (status == NDIS_STATUS_SUCCESS)
+	{
+	  if (parm->ParameterType == NdisParameterString)
+	    {
+	      DEBUGP (("[TAP] NdisReadConfiguration (MiniportName=%s)\n", parm->ParameterData.StringData.Buffer));
+
+	      if (RtlUnicodeStringToAnsiString (
+			&l_Adapter->m_NameAnsi,
+			&parm->ParameterData.StringData,
+			TRUE) != STATUS_SUCCESS)
+		{
+		  DEBUGP (("[TAP] RtlUnicodeStringToAnsiString MiniportName failed\n"));
+		  status = NDIS_STATUS_RESOURCES;
+		}
+	    }
+	} else {
+	  /* "MiniportName" is available only XP and above.  Not on Windows 2000. */
+	  NDIS_STRING key = NDIS_STRING_CONST("NdisVersion");
+	  NdisReadConfiguration (&status, &parm, configHandle, &key, NdisParameterInteger);
+	  if (status == NDIS_STATUS_SUCCESS)
+	    {
+	      if (parm->ParameterData.IntegerData == 0x50000)
+		{
+		  /* Fallback for Windows 2000 with NDIS version 5.00.00
+		     Don't use this on Vista, 'NDIS_MINIPORT_BLOCK' was changed! */
+		  DEBUGP (("[TAP] NdisReadConfiguration NdisVersion (Int=%X)\n", parm->ParameterData.IntegerData));
+		  if (RtlUnicodeStringToAnsiString (
+			&l_Adapter->m_NameAnsi,
+			&((PNDIS_MINIPORT_BLOCK) p_AdapterHandle)->MiniportName,
+			TRUE) != STATUS_SUCCESS)
+		    {
+		      DEBUGP (("[TAP] RtlUnicodeStringToAnsiString MiniportName (W2K) failed\n"));
+		      status = NDIS_STATUS_RESOURCES;
+		    }
+		}
+	    }
+	}
+    }
+
+    /* Can't continue without name (see macro 'NAME') */
+    if (status != NDIS_STATUS_SUCCESS || !l_Adapter->m_NameAnsi.Buffer)
       {
+	NdisCloseConfiguration (configHandle);
+	AdapterFreeResources (l_Adapter);
+	return NDIS_STATUS_RESOURCES;
+      }
+
 	/* Read MTU setting from registry */
 	{
 	  NDIS_STRING key = NDIS_STRING_CONST("MTU");
@@ -470,7 +515,6 @@
 	}
 
 	NdisCloseConfiguration (configHandle);
-      }
 
     DEBUGP (("[%s] MTU=%d\n", NAME (l_Adapter), l_Adapter->m_MTU));
   }

--------------020901070703040104000701--


