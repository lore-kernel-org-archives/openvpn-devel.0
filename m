Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1756606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nl8YysAw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kiqWjeB+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=X2LSUOtO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Qa/kKeir02OnpqDzPcPeC5JWsyFdgw2DxoSG9L7OZ30=; b=Nl8YysAwIl9sn2
	Spr5vecLzWQ3Ay+9p0VZYsIisO+Quo5+lnS09BsVlT9uBUsJFcAhXfBl7TIBN5iH9zh69N+VSPxDs
	mJePn4AdQE12mThAFiOWjf0YdiPyA7NNMyZYXM90nVsnsEaKvPok1PPp62m1F9djMZprNlHUrXMzH
	784=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVXmE-0000000076P-3sqF;
	Mon, 23 Nov 2026 17:24:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVXmC-0000000076H-2Wvx for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:24:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+0Lu36IaYk422TM71RD8aiWSn9e2XqLbmPUkj6aYeRM=; b=kiqWjeB+ujy1okMlu7uEH4+rQm
 COkqPqyzTRknk5mrwHhgxy3Iyqc7toAPSo1Z/HRY+5mVXpPw9kfTP0ZEZ8U8qWawK4TCD5yvgCfqp
 Z6OwG2td92ojZuXrTw0DsTua01fFiWlMpQO/WeZTyXJe0EVHHprlwxwu+eaVBGrgR8Dc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+0Lu36IaYk422TM71RD8aiWSn9e2XqLbmPUkj6aYeRM=; b=X2LSUOtONPfu4QP5gQFaDCdoHt
 xuRUKk1+mLixJHMo/KPkG5rhuvota2Yb+3WnOdUY/OrjlzZlfRUjDL0bBbCf6l+530AADhGiOpGCv
 RR36aphIi7BKui6u2WM3i658UULf21VMwr7x7NEP1jEaZks+UT+0K6yAmIwrKNjZjbRQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVXmA-000000001b2-2TUh for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:24:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANHOF4x022031
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 18:24:15 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANHOFLP022030
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 18:24:15 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 18:24:09 +0100
Message-ID: <20261123172414.22019-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794000221000.I9093aaaf8f198cd389e9f72186397a87a7ded297@gerrit.openvpn.net>
References: <gerrit.1794000221000.I9093aaaf8f198cd389e9f72186397a87a7ded297@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVXmA-000000001b2-2TUh
Subject: [Openvpn-devel] [PATCH v1] win32: restrict the DLL search path of
 openvpn
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Heiko Hund <heiko@ist.eigentlich.net>

DLLs that openvpn loads by name, like dependencies of plugins or
modules loaded by libraries like OpenSSL, are searched in the current
directory and the directories in PATH, among others. These can contain
places where users have write access. Placing a dll there makes it
possible to inject code into the openvpn process and gives access to
privileged operations.

Call SetDefaultDllDirectories() at the start of wmain() to restrict the
search to the application directory, the system directory and the
directories added with AddDllDirectory(). openvpn exits if this fails.

The trusted plugin directory is added with AddDllDirectory(). To get
it, move the code that determined it inline in plugin_in_trusted_dir()
into get_plugin_dir(), which returns the normalized directory or fails
if it cannot be determined.

plugin_in_trusted_dir() now only checks against the system directory
if the plugin is not in the plugin directory. It now fails if the
system directory cannot be retrieved, instead of checking against an
empty path.

Change-Id: I9093aaaf8f198cd389e9f72186397a87a7ded297
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn-private/+/2147
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn-private/+/2147
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/Changes.md b/Changes.md
index b5ae881..62640b2 100644
--- a/Changes.md
+++ b/Changes.md
@@ -23,6 +23,18 @@
   the characters mentioned above were already escaped. However, the behavior of
   Mbed TLS is slightly different from OpenSSL in that it also escapes "=".
 
+* **Windows: DLLs are no longer loaded from the current directory or PATH**
+
+  OpenVPN now only loads DLLs from its installation directory, the Windows
+  system directory and the trusted plugin directory. DLLs a plugin depends on
+  are also looked up in the directory of the plugin itself. The current
+  directory and the directories in `PATH` are not searched anymore.
+
+  If a plugin depends on DLLs that were only found via `PATH`, install them
+  next to the plugin. PKCS#11 providers given by name only, e.g.
+  `--pkcs11-providers provider.dll`, need to be given with their full path,
+  unless they are located in one of the directories listed above.
+
 ## Maintainer-visible changes
 
 - The configure-time option `--enable-debug` is no longer  available
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index b32f009..da1def8 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -358,6 +358,23 @@
     int ret;
     int i;
 
+    /* Initialize the message output, so that msg() can be used below */
+    error_reset();
+
+    /* Load DLLs only from the application and system directories */
+    if (!SetDefaultDllDirectories(LOAD_LIBRARY_SEARCH_DEFAULT_DIRS))
+    {
+        msg(M_FATAL | M_ERRNO, "Failed to restrict the DLL search path.");
+    }
+
+    /* Also allow loading DLLs from the trusted plugin directory */
+    WCHAR plugin_dir[MAX_PATH];
+    BOOL have_plugin_dir = get_plugin_dir(plugin_dir, _countof(plugin_dir));
+    if (have_plugin_dir && !AddDllDirectory(plugin_dir))
+    {
+        msg(M_WARN | M_ERRNO, "Failed to add the plugin directory to the DLL search path.");
+    }
+
     /*
      * Do not use the argv provided by the CRT. Split the command line with
      * CommandLineToArgvW() instead, which is what the interactive service uses
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 3af58ed..a2a1b22 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1571,6 +1571,30 @@
     }
 }
 
+BOOL
+get_plugin_dir(PWSTR dir, DWORD size)
+{
+    WCHAR plugin_dir[MAX_PATH] = { 0 };
+
+    /* Attempt to retrieve the trusted plugin directory path from the registry,
+     * using installation path as a fallback */
+    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, sizeof(plugin_dir))
+        && !get_openvpn_reg_value(NULL, plugin_dir, sizeof(plugin_dir)))
+    {
+        msg(M_WARN, "Installation path could not be determined.");
+        return FALSE;
+    }
+
+    DWORD len = GetFullPathNameW(plugin_dir, size, dir, NULL);
+    if (len == 0 || len >= size)
+    {
+        msg(M_NONFATAL | M_ERRNO, "Failed to normalize plugin dir.");
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
 bool
 plugin_in_trusted_dir(const WCHAR *plugin_path)
 {
@@ -1581,47 +1605,22 @@
         return false;
     }
 
-    WCHAR plugin_dir[MAX_PATH] = { 0 };
-
-    /* Attempt to retrieve the trusted plugin directory path from the registry,
-     * using installation path as a fallback */
-    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, sizeof(plugin_dir))
-        && !get_openvpn_reg_value(NULL, plugin_dir, sizeof(plugin_dir)))
-    {
-        msg(M_WARN, "Installation path could not be determined.");
-    }
-
-    /* Get the system directory */
-    WCHAR system_dir[MAX_PATH] = { 0 };
-    if (GetSystemDirectoryW(system_dir, _countof(system_dir)) == 0)
-    {
-        msg(M_NONFATAL | M_ERRNO, "Failed to get system directory.");
-    }
-
-    if ((wcslen(plugin_dir) == 0) && (wcslen(system_dir) == 0))
-    {
-        return false;
-    }
-
-    WCHAR normalized_plugin_dir[MAX_PATH] = { 0 };
-
-    /* Normalize the plugin dir */
-    if (wcslen(plugin_dir) > 0)
-    {
-        if (!GetFullPathNameW(plugin_dir, MAX_PATH, normalized_plugin_dir, NULL))
-        {
-            msg(M_NONFATAL | M_ERRNO, "Failed to normalize plugin dir.");
-            return false;
-        }
-    }
-
     /* Check if the plugin path resides within the plugin/install directory */
-    if (win_path_in_dir(plugin_path, normalized_plugin_dir))
+    WCHAR plugin_dir[MAX_PATH] = { 0 };
+    if (get_plugin_dir(plugin_dir, _countof(plugin_dir))
+        && win_path_in_dir(plugin_path, plugin_dir))
     {
         return true;
     }
 
     /* Fallback to the system directory */
+    WCHAR system_dir[MAX_PATH] = { 0 };
+    if (GetSystemDirectoryW(system_dir, _countof(system_dir)) == 0)
+    {
+        msg(M_NONFATAL | M_ERRNO, "Failed to get system directory.");
+        return false;
+    }
+
     return win_path_in_dir(plugin_path, system_dir);
 }
 
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 39ff7d8..646e3eb 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -336,6 +336,19 @@
 bool get_openvpn_reg_value(const WCHAR *key, WCHAR *value, DWORD size);
 
 /**
+ * Get the trusted plugin directory
+ *
+ * The directory is taken from the "plugin_dir" registry value, or the
+ * installation path, if that value is missing. The path is normalized.
+ *
+ * @param  dir      buffer to store the directory in
+ * @param  size     size of the @p dir buffer in characters
+ *
+ * @return BOOL to indicate success or failure
+ */
+BOOL get_plugin_dir(PWSTR dir, DWORD size);
+
+/**
  * @brief Checks if a plugin is located in a trusted directory.
  *
  * Verifies the plugin's path against a trusted directory, which is:


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
