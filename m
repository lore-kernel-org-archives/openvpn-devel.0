Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A2AC61DD6
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=piOEVCrrCEywiibqsWknw1y0KLm47a2LUTasSfTdPi0=; b=gisAMTwkVo1XJmsWLGmFiRZ2Rr
	fJLYx6FAQzOFmIU9t8XpCAgApA/rC2Joiw+gylMElhseNDfgzB/gaEARHHqSTcApbiEEdGBdyeMWB
	9rTIRrQORCA86AuFGDciVohRj8UgwCWFbqgm3M2uaQSQpKZK5mYSv5x6R818x3wbGSpk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1V6w-00088A-AD;
	Tue, 01 Sep 2026 20:29:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x1V6Q-00087m-EG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:29:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MHoojlFX3c1KndCIUWxJzrIEXwD/TxiLF9RCEsj3tPs=; b=UHhOiBMP7TZE4UefEI2AGucw1A
 cGiFPoJChjcbBBX2pilubZ0CDoF2OVNhWstW+w6qbWzLt+GAWrfcij5e9vzhxFsM7R/hjma+gjoCs
 orSb6g+7IQdY194enjvjC80C2xe8kDx/IcPMlhcKurk4ku1Nshaxn+8Kdpw/LxtWN66g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MHoojlFX3c1KndCIUWxJzrIEXwD/TxiLF9RCEsj3tPs=; b=YF0z979phF9bYrZAmL6aQ9D0Fm
 jN0goouvziellLyZwY7RajJRj8SFQGz+jrZCoKNbFfoKBrZKB8Pxb30ja/PySQ0kImPfz+cw8t12L
 gAbFYAZQXOn1o5uEZErKccLnf1p01dJ1LH5Pk2peGEGRXjYtRCiwTGX5dD2PpmUHk3Vg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1V6M-0005Zm-Sa for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:29:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 681KStNl013759
 for <openvpn-devel@lists.sourceforge.net>; Tue, 1 Sep 2026 22:28:55 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 681KStmw013758
 for openvpn-devel@lists.sourceforge.net; Tue, 1 Sep 2026 22:28:55 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  1 Sep 2026 22:28:49 +0200
Message-ID: <20260901202854.13746-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788282372000.I787a7067f6ff040c6a1f43f384321bddf5efc97b@gerrit.openvpn.net>
References: <gerrit.1788282372000.I787a7067f6ff040c6a1f43f384321bddf5efc97b@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x1V6M-0005Zm-Sa
Subject: [Openvpn-devel] [PATCH v1] win: don't use NULL DACL with system
 objects
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Heiko Hund <heiko@ist.eigentlich.net>

The netsh semaphore used a NULL DACL, which allowed any user on a shared
system to block openvpn from running. Instances would time out and shut
down.

Similar with the --service exit event. Any user could signal it and shut
down the instance if the event name is known or can be retrieved from
the running process.

To prevent both, the objects are created with a DACL which allows access
to the creating user only. In case of the netsh semaphore this means that
only the first user running openvpn can run more instances. Other
accounts doing so will error out. The interactive service can be used to
prevent this from happening, since the netsh semaphore is only used when
the openvpn process runs privileged operations directly.

Github: OpenVPN/openvpn-private-issues#167
CVE: 2026-82312
Reported-By: DEBRAJ BASAK <https://in.linkedin.com/in/debrajbasak>
Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1889
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1889
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 44b010d..dd88a22 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -35,6 +35,8 @@
 
 #include <minwindef.h>
 #include <winsock2.h>
+#include <accctrl.h>
+#include <aclapi.h>
 
 #include "buffer.h"
 #include "error.h"
@@ -146,6 +148,13 @@
     pause_exit_enabled = true;
 }
 
+/**
+ * @brief Initializes security attributes with a NULL DACL, allowing
+ *        unrestricted access to the resulting object.
+ *
+ * @param obj Security attributes structure to initialize.
+ * @return true on success, false otherwise.
+ */
 bool
 init_security_attributes_allow_all(struct security_attributes *obj)
 {
@@ -165,6 +174,93 @@
     return true;
 }
 
+/**
+ * @brief Initializes security attributes with a DACL restricted to the
+ *        current process user.
+ *
+ * The resulting DACL grants GENERIC_ALL access to the calling user only,
+ * so the created object cannot be opened, signaled or otherwise accessed
+ * by other users on the system. The allocated DACL must be released with
+ * free_security_attributes() once the security attributes are no longer
+ * needed.
+ *
+ * @param obj Security attributes structure to initialize.
+ * @return true on success, false otherwise.
+ */
+static bool
+init_security_attributes_allow_user(struct security_attributes *obj)
+{
+    bool ret = false;
+
+    CLEAR(*obj);
+    obj->sa.nLength = sizeof(SECURITY_ATTRIBUTES);
+    obj->sa.lpSecurityDescriptor = &obj->sd;
+    obj->sa.bInheritHandle = FALSE;
+
+    if (!InitializeSecurityDescriptor(&obj->sd, SECURITY_DESCRIPTOR_REVISION))
+    {
+        return ret;
+    }
+
+    HANDLE token = NULL;
+    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &token))
+    {
+        return ret;
+    }
+
+    PTOKEN_USER info = NULL;
+    DWORD info_len = 0;
+    if (!GetTokenInformation(token, TokenUser, info, info_len, &info_len)
+        && GetLastError() != ERROR_INSUFFICIENT_BUFFER)
+    {
+        goto out;
+    }
+
+    info = malloc(info_len);
+    if (!info || !GetTokenInformation(token, TokenUser, info, info_len, &info_len))
+    {
+        goto out;
+    }
+
+    EXPLICIT_ACCESS ea = { 0 };
+    ea.grfAccessPermissions = GENERIC_ALL;
+    ea.grfAccessMode = SET_ACCESS;
+    ea.grfInheritance = NO_INHERITANCE;
+    ea.Trustee.TrusteeForm = TRUSTEE_IS_SID;
+    ea.Trustee.TrusteeType = TRUSTEE_IS_USER;
+    ea.Trustee.ptstrName = (LPTSTR)info->User.Sid;
+
+    if (SetEntriesInAcl(1, &ea, NULL, &obj->dacl) != ERROR_SUCCESS)
+    {
+        goto out;
+    }
+
+    if (SetSecurityDescriptorDacl(&obj->sd, TRUE, obj->dacl, FALSE))
+    {
+        ret = true;
+    }
+
+out:
+    free(info);
+    CloseHandle(token);
+    return ret;
+}
+
+/**
+ * @brief Releases resources allocated by init_security_attributes_allow_user().
+ *
+ * @param obj Security attributes structure to release.
+ */
+static void
+free_security_attributes(struct security_attributes *obj)
+{
+    if (obj->dacl)
+    {
+        LocalFree(obj->dacl);
+        obj->dacl = NULL;
+    }
+}
+
 void
 overlapped_io_init(struct overlapped_io *o, const struct frame *frame, BOOL event_state)
 {
@@ -504,7 +600,7 @@
         struct gc_arena gc = gc_new();
         const wchar_t *exit_event_nameW = wide_string(exit_event_name, &gc);
 
-        if (!init_security_attributes_allow_all(&sa))
+        if (!init_security_attributes_allow_user(&sa))
         {
             msg(M_ERR, "Error: win32_signal_open: init SA failed");
         }
@@ -526,6 +622,7 @@
                 ws->mode = WSO_MODE_SERVICE;
             }
         }
+        free_security_attributes(&sa);
         gc_free(&gc);
     }
     /* set the ctrl handler in both console and service modes */
@@ -751,14 +848,15 @@
     s->name = name;
     s->hand = NULL;
 
-    if (init_security_attributes_allow_all(&sa))
+    if (init_security_attributes_allow_user(&sa))
     {
         s->hand = CreateSemaphore(&sa.sa, 1, 1, name);
     }
+    free_security_attributes(&sa);
 
     if (s->hand == NULL)
     {
-        msg(M_WARN | M_ERRNO, "WARNING: Cannot create Win32 semaphore '%s'", name);
+        msg(M_ERR, "Cannot create Win32 semaphore '%s'", name);
     }
     else
     {
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index ef32062..8be3d96 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -63,6 +63,7 @@
 {
     SECURITY_ATTRIBUTES sa;
     SECURITY_DESCRIPTOR sd;
+    PACL dacl;
 };
 
 #define HANDLE_DEFINED(h) ((h) != NULL && (h) != INVALID_HANDLE_VALUE)
@@ -262,6 +263,11 @@
  *
  * It seems you can't run more than one instance
  * of netsh on the same machine at the same time.
+ *
+ * Its DACL is restricted to the creating user to prevent an unprivileged
+ * local user from starving it and DoS'ing running instances. This means
+ * different user accounts running OpenVPN directly, not via the interactive
+ * service, will make all but the first user's instances exit.
  */
 
 extern struct semaphore netcmd_semaphore;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
