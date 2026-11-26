Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A75606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OxYduf+i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ivb8ZQCd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mMVlArgH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=az8Mlj/zwMwqPF6p/2hkQF6NO053moa7xFT97Eb6JbE=; b=OxYduf+i6SoAge
	9A54dbiOUFbAI6bJxN5sKl8f5guN/9sBAYIIO4rStl7WAxI557uWSQURBGgbkrNGEcYfGM47NyaXc
	8TUGIwtbNCrDHlk0tjauUmqg8PAwUiZaKZ1+PEPScSFQJd0cC77yh1NbIu2j+thFsaAOB8wg8I1li
	KSc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWeSj-0000000083T-1cU1;
	Thu, 26 Nov 2026 18:44:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWeSh-0000000083M-3HTh for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 18:44:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9UgKH/I5zIDDAooeRhk4LQp7IzTOCCK04uZwNGY0ITA=; b=ivb8ZQCd+hS1lVnRy7Ct4qi9OZ
 3NeuLK3B7eqXiAuAIWMOzzwlDj7TBcaUIdOQaJu9lOyd0VV9fOagCZitFcsaitmt8RNiUbDKvZMal
 pMxDvS1TCuYqfyMWhBGdmqRMPzhkzQLN/3TWfJxoR4hiygFusdaQPiafTO2MuyV+Ysec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9UgKH/I5zIDDAooeRhk4LQp7IzTOCCK04uZwNGY0ITA=; b=mMVlArgHTfktnZPxEuwmp5u7bU
 XzZZ3KfRptXPPFaOK8ArUARuMyJ/QT05y0u+LJb/ggplhwRGVQJ4sfo7zGRougjMsERIWOvAcD7Uv
 9PEwQDpx1Cpzs8HdaGk44CchDkILosz4Gy5Ctf5Dx6s3KshoJo8lEGpdmiHbeeE79jz8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWeSg-000000007JS-1wn0 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 18:44:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AQIihnN015567
 for <openvpn-devel@lists.sourceforge.net>; Thu, 26 Nov 2026 19:44:43 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQIihaJ015566
 for openvpn-devel@lists.sourceforge.net; Thu, 26 Nov 2026 19:44:43 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 19:44:37 +0100
Message-ID: <20261126184443.15556-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795714582000.Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7@gerrit.openvpn.net>
References: <gerrit.1795714582000.Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWeSg-000000007JS-1wn0
Subject: [Openvpn-devel] [PATCH v1] openvpnmsica: Clean up sign conversion
 warnings
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Improve code in x_msg_va to handle vsnprintf result.

Removes explict null termination that is not required
in supported versions of Windows.

Includes one unrelated cast that is too small to
warrant its own commit.

Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2358
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2358
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 777c823..e191207 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -98,11 +98,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 {
@@ -124,26 +119,29 @@
         /* Field 2: The message string. */
         char szBufStack[128];
         int iResultLen = vsnprintf(szBufStack, _countof(szBufStack), format, arglist);
-        if (iResultLen > 0 && (unsigned int)iResultLen < _countof(szBufStack))
+        if (iResultLen > 0)
         {
-            /* Use from stack. */
-            MsiRecordSetStringA(hRecordProg, 2, szBufStack);
-        }
-        else
-        {
-            /* Allocate on heap and retry. */
-            char *szMessage = (char *)malloc(++iResultLen * sizeof(char));
-            if (szMessage != NULL)
+            const size_t alloc_size = (size_t)iResultLen + 1;
+            if (alloc_size <= _countof(szBufStack))
             {
-                vsnprintf(szMessage, iResultLen, format, arglist);
-                MsiRecordSetStringA(hRecordProg, 2, szMessage);
-                free(szMessage);
+                /* Use from stack. */
+                MsiRecordSetStringA(hRecordProg, 2, szBufStack);
             }
             else
             {
-                /* Use stack variant anyway, but make sure it's zero-terminated. */
-                szBufStack[_countof(szBufStack) - 1] = 0;
-                MsiRecordSetStringA(hRecordProg, 2, szBufStack);
+                /* Allocate on heap and retry. */
+                char *szMessage = malloc(alloc_size);
+                if (szMessage != NULL)
+                {
+                    vsnprintf(szMessage, alloc_size, format, arglist);
+                    MsiRecordSetStringA(hRecordProg, 2, szMessage);
+                    free(szMessage);
+                }
+                else
+                {
+                    /* Use truncated stack variant anyway */
+                    MsiRecordSetStringA(hRecordProg, 2, szBufStack);
+                }
             }
         }
     }
@@ -159,7 +157,7 @@
         MsiRecordSetInteger(hRecordProg, 1, ERROR_MSICA_ERRNO);
 
         /* Field 3: The Windows error number. */
-        MsiRecordSetInteger(hRecordProg, 3, dwResult);
+        MsiRecordSetInteger(hRecordProg, 3, (int)dwResult);
 
         /* Field 4: The Windows error description. */
         LPWSTR szErrMessage = NULL;
@@ -194,7 +192,3 @@
                       hRecordProg);
     MsiCloseHandle(hRecordProg);
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
