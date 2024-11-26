From: Gert Doering <gert@...1296...>
Date: Tue, 26 Nov 2024 11:26:51 +0100
Message-ID: <20241126102651.18905-1-gert@...1296...>
In-Reply-To: <gerrit.1732583163000.Ib88ce925b20c5912de489ef1b62615c4b87d365c@...2715...>
References: <gerrit.1732583163000.Ib88ce925b20c5912de489ef1b62615c4b87d365c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix wrong doxygen comments
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

Add some missing "<" to trailing comments
to make sure they apply to the correct line.

Change-Id: Ib88ce925b20c5912de489ef1b62615c4b87d365c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/820
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 10ee9f6..043b240 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -929,10 +929,10 @@
 
 struct pull_filter
 {
-#define PUF_TYPE_UNDEF  0    /** undefined filter type */
-#define PUF_TYPE_ACCEPT 1    /** filter type to accept a matching option */
-#define PUF_TYPE_IGNORE 2    /** filter type to ignore a matching option */
-#define PUF_TYPE_REJECT 3    /** filter type to reject and trigger SIGUSR1 */
+#define PUF_TYPE_UNDEF  0    /**< undefined filter type */
+#define PUF_TYPE_ACCEPT 1    /**< filter type to accept a matching option */
+#define PUF_TYPE_IGNORE 2    /**< filter type to ignore a matching option */
+#define PUF_TYPE_REJECT 3    /**< filter type to reject and trigger SIGUSR1 */
     int type;
     int size;
     char *pattern;
@@ -3846,14 +3846,14 @@
  *  Check file/directory sanity
  *
  */
-#ifndef ENABLE_SMALL  /** Expect people using the stripped down version to know what they do */
+#ifndef ENABLE_SMALL  /* Expect people using the stripped down version to know what they do */
 
-#define CHKACC_FILE (1<<0)       /** Check for a file/directory presence */
-#define CHKACC_DIRPATH (1<<1)    /** Check for directory presence where a file should reside */
-#define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
-#define CHKACC_ACPTSTDIN (1<<3)  /** If filename is stdin, it's allowed and "exists" */
-#define CHKACC_PRIVATE (1<<4)    /** Warn if this (private) file is group/others accessible */
-#define CHKACC_ACCEPT_URI (1<<5) /** If filename is a URI, no check is done unless it starts with file: */
+#define CHKACC_FILE (1<<0)       /**< Check for a file/directory presence */
+#define CHKACC_DIRPATH (1<<1)    /**< Check for directory presence where a file should reside */
+#define CHKACC_FILEXSTWR (1<<2)  /**< If file exists, is it writable? */
+#define CHKACC_ACPTSTDIN (1<<3)  /**< If filename is stdin, it's allowed and "exists" */
+#define CHKACC_PRIVATE (1<<4)    /**< Warn if this (private) file is group/others accessible */
+#define CHKACC_ACCEPT_URI (1<<5) /**< Do not check URIs, unless they start with file: */
 
 static bool
 check_file_access(const int type, const char *file, const int mode, const char *opt)
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index 6cd272c..cec046f 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -37,8 +37,8 @@
  */
 struct msica_arg
 {
-    struct msica_arg *next; /** Pointer to the next argument in the sequence */
-    TCHAR val[];            /** Zero terminated argument string */
+    struct msica_arg *next; /**< Pointer to the next argument in the sequence */
+    TCHAR val[];            /**< Zero terminated argument string */
 };
 
 
@@ -47,8 +47,8 @@
  */
 struct msica_arg_seq
 {
-    struct msica_arg *head; /** Pointer to the first argument in the sequence */
-    struct msica_arg *tail; /** Pointer to the last argument in the sequence */
+    struct msica_arg *head; /**< Pointer to the first argument in the sequence */
+    struct msica_arg *tail; /**< Pointer to the last argument in the sequence */
 };
 
 
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 5ffb5b3..154fff4 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -59,9 +59,10 @@
  * Local constants
  */
 
-#define MSICA_ADAPTER_TICK_SIZE (16*1024) /** Amount of tick space to reserve for one TAP/TUN adapter creation/deletition. */
+/** Amount of tick space to reserve for one TAP/TUN adapter creation/deletition. */
+#define MSICA_ADAPTER_TICK_SIZE        (16 * 1024)
 
-#define FILE_NEED_REBOOT        L".ovpn_need_reboot"
+#define FILE_NEED_REBOOT               L".ovpn_need_reboot"
 
 #define OPENVPN_CONNECT_ADAPTER_SUBSTR L"OpenVPN Connect"
 
@@ -88,7 +89,9 @@
     free(szSequence);
     if (uiResult != ERROR_SUCCESS)
     {
-        SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+        /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error
+         * code. Set last error manually. */
+        SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szProperty);
         return uiResult;
     }
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 6640d7e..7aacdf3 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -38,7 +38,7 @@
  */
 struct openvpnmsica_thread_data
 {
-    MSIHANDLE hInstall; /** Handle to the installation session. */
+    MSIHANDLE hInstall; /**< Handle to the installation session. */
 };
 
 
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 9c403cc..680c13a 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -135,11 +135,11 @@
  */
 struct tap_adapter_node
 {
-    GUID guid;             /** Adapter GUID */
-    LPTSTR szzHardwareIDs; /** Device hardware ID(s) */
-    LPTSTR szName;         /** Adapter name */
+    GUID guid;             /**< Adapter GUID */
+    LPTSTR szzHardwareIDs; /**< Device hardware ID(s) */
+    LPTSTR szName;         /**< Adapter name */
 
-    struct tap_adapter_node *pNext; /** Pointer to next adapter */
+    struct tap_adapter_node *pNext; /**< Pointer to next adapter */
 };
 
 

