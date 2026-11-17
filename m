Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C7606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ilt6AfvU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aamxhmHt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=I4PvM10i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xqsI528vgip5+ahn+oLLfNRD2CfVFfAfNLHpHoUFzY4=; b=ilt6AfvUJO0BPw
	SkjqNKFWHqSVvWXj+fUNGM6yJ9sy0vrqhGXjW5MJWoc36QJ31ZmW0uf39mmHG01bPS2/6/aWmImHL
	0rIltLkDt4GGeBPqleeSWwnQ8JRUi0dMszOKUzleTTfcc1Qa7EbRw9/h21GQATCa4vRzQOj80PYBn
	oyc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNoI-0000000041F-0tiU;
	Tue, 17 Nov 2026 18:21:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTNo7-00000000413-3kx9 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OmygsGhPkzs8sIFN1wPwKeftPxCcvMJE+0e9D6yjxhA=; b=aamxhmHt2jAmDQCJBd6dk9nu1Y
 HRrbE7I/FxCENB3+ZvQ/A/cPP9xyPyMYrtAMWHVClFUvvQ3XtcttsXx1r8Wc/ttp8JvszvhriO3M7
 k10c8mtM1fHLdtshBhBIKDvSiAGt5l7LsRXGhgxNFC7XWsXs0NIWbIo20TcIkLe7aKMY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OmygsGhPkzs8sIFN1wPwKeftPxCcvMJE+0e9D6yjxhA=; b=I4PvM10ied2DT6EhIJJ0g3HoIK
 bVMn6GtytbF/EPCMCiRtrCfSAEIb5yA01eUaI6N4lEAKa4l6cUNuxQLcyGvg5w6Xoxe1g0IWlRRuG
 XKm4tJEW0clNNxgREtr4TDH3QVuwBsRvaAE8uqYelrViYAH702vzMIPObTbtwww0Fa1g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTNo6-000000001C2-0i5x for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:21:27 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AHILJK7017660
 for <openvpn-devel@lists.sourceforge.net>; Tue, 17 Nov 2026 19:21:19 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHILJ9T017659
 for openvpn-devel@lists.sourceforge.net; Tue, 17 Nov 2026 19:21:19 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 19:21:14 +0100
Message-ID: <20261117182119.17648-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793747232000.Id3a58112fffc8679978ddf5adb44e7be9083e17a@gerrit.openvpn.net>
References: <gerrit.1793747232000.Id3a58112fffc8679978ddf5adb44e7be9083e17a@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTNo6-000000001C2-0i5x
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: hold the service pipe name
 with a private instance
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

Only the first pipe instance was created with the flag
FILE_FLAG_FIRST_PIPE_INSTANCE, which relied on the service never
closing all of its instances.

Create a disconnected instance on first use instead, which holds the
name for the lifetime of the service, no matter how many instances
clients use.

Change-Id: Id3a58112fffc8679978ddf5adb44e7be9083e17a
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2112
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2112
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 4a8d0b5..5e4b555 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3806,6 +3806,16 @@
 }
 
 
+/**
+ * Create an instance of the service pipe clients connect to
+ *
+ * The first call also creates a private instance with FILE_FLAG_FIRST_PIPE_INSTANCE,
+ * which fails if the pipe name already exists. It is kept disconnected, so clients
+ * cannot connect to it, and holds the pipe name for the lifetime of the service.
+ * This way the pipe name is blocked from other processes using it.
+ *
+ * @return HANDLE of the pipe instance, or INVALID_HANDLE_VALUE on error
+ */
 static HANDLE
 CreateClientPipeInstance(VOID)
 {
@@ -3833,21 +3843,33 @@
     sa.bInheritHandle = FALSE;
 
     DWORD flags = PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_OVERLAPPED;
-
-    static BOOL first = TRUE;
-    if (first)
-    {
-        flags |= FILE_FLAG_FIRST_PIPE_INSTANCE;
-        first = FALSE;
-    }
+    DWORD mode = PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS;
 
     WCHAR pipe_name[256]; /* The entire pipe name string can be up to 256 characters long according
                              to MSDN. */
     swprintf(pipe_name, _countof(pipe_name), L"\\\\.\\pipe\\" _L(PACKAGE) L"%ls\\service",
              service_instance);
-    HANDLE pipe = CreateNamedPipe(
-        pipe_name, flags, PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
-        PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &sa);
+
+    static HANDLE blocker = INVALID_HANDLE_VALUE;
+    if (blocker == INVALID_HANDLE_VALUE)
+    {
+        blocker = CreateNamedPipe(pipe_name, flags | FILE_FLAG_FIRST_PIPE_INSTANCE, mode,
+                                  PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &sa);
+        if (blocker != INVALID_HANDLE_VALUE && !DisconnectNamedPipe(blocker))
+        {
+            DWORD error = GetLastError();
+            CloseHandleEx(&blocker);
+            SetLastError(error);
+        }
+    }
+
+    /* Without the first instance, fail and try again with the next call */
+    HANDLE pipe = INVALID_HANDLE_VALUE;
+    if (blocker != INVALID_HANDLE_VALUE)
+    {
+        pipe = CreateNamedPipe(pipe_name, flags, mode, PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,
+                               &sa);
+    }
 
     LocalFree(sd);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
