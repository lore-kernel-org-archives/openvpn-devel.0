Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13DBCA5FA3
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 21:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FrLxi5oFBi31Fe1nCgiGs/RmoijSmXiUZT4h+QmeRsA=; b=LWpyQaV81usfum1HjffshlXFf6
	9fvshasXkSMVcu4YM3r1O8oJBtX9WprvAXClJrOtyDHZNvG5Q21wCCx5IdREHJ/v00DhjcImSgCu0
	bKPin9W2qqgH0zkGX1cTLGuuyk5MTy4SSGNdGGJ5piSlqh95csgTAZy3TXIk/0Rem5e8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBITl-0002aQ-Rn;
	Mon, 28 Sep 2026 21:01:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xBITl-0002aJ-12
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hxfBRagk8/+lY/7uaFIqJi/ZPI55/vCpXS0WUP/PgL4=; b=hyKrksmm0X29hxK+IYkT4lTlz8
 ydPuCSzK/SF+KPLvTkN9z2Id8ZGSJAmPSpVjFP98Y59J8KuSSG7cTTg08WNMVucgINMJW1sBSLO0D
 6W546DJDUMSrh7C93P370Qh4YcnMbs7XA2KZtYWhw1uoXBTFM/ouzNjyJvJZ7Rqh+T1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hxfBRagk8/+lY/7uaFIqJi/ZPI55/vCpXS0WUP/PgL4=; b=VnOVN9cIasqxxFKx4fwvzer4PN
 xCOa4PLeZiymGBCWYgSy1tmErkFY5+EsJEUG5u60qi22XzcjAZML/Yc5luZPIEnARQ49I9zOCscyn
 +CYZ/6dS40FbHb9EEyt5tz/uTXOqi0E7o3zxuP+RTB9d7VP+c4s64kLuyPcSjxoxlNXs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBITg-00076c-HM for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:01:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68SL1TWt012401
 for <openvpn-devel@lists.sourceforge.net>; Mon, 28 Sep 2026 23:01:29 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68SL1TLv012400
 for openvpn-devel@lists.sourceforge.net; Mon, 28 Sep 2026 23:01:29 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 28 Sep 2026 23:01:23 +0200
Message-ID: <20260928210129.12370-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790610390000.I39b3b31983a2d6348fd66266448f8d13e53a422c@gerrit.openvpn.net>
References: <gerrit.1790610390000.I39b3b31983a2d6348fd66266448f8d13e53a422c@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xBITg-00076c-HM
Subject: [Openvpn-devel] [PATCH v1] openvpnmscia: Fix some ugly code
 formatting
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Trailing comments lead to some ugliness due
to clang-format formatting. Make nicer.

Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1959
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1959
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 25fa1e4..e510e4d 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -185,9 +185,9 @@
         free(pAdapterAdresses);
         if (ulResult != ERROR_BUFFER_OVERFLOW)
         {
-            SetLastError(
-                ulResult); /* MSDN does not mention GetAdaptersAddresses() to set GetLastError().
-                              But we do have an error code. Set last error manually. */
+            /* MSDN does not mention GetAdaptersAddresses() to set GetLastError().
+             * But we do have an error code. Set last error manually. */
+            SetLastError(ulResult);
             msg(M_NONFATAL | M_ERRNO, "%s: GetAdaptersAddresses() failed", __FUNCTION__);
             uiResult = ulResult;
             goto cleanup_pAdapterList;
@@ -290,8 +290,9 @@
     uiResult = MsiSetProperty(hInstall, szActiveAdaptersPropertyName, szAdaptersActive);
     if (uiResult != ERROR_SUCCESS)
     {
-        SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But
-                                   we do have an error code. Set last error manually. */
+        /* MSDN does not mention MsiSetProperty() to set GetLastError(). But
+         * we do have an error code. Set last error manually. */
+        SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%s\") failed", __FUNCTION__,
             szActiveAdaptersPropertyName);
         goto cleanup_szAdaptersActive;
@@ -386,8 +387,9 @@
     uiResult = MsiRecordSetString(hRecord, 0, L"\"[#bin.openvpn_gui.exe]\"");
     if (uiResult != ERROR_SUCCESS)
     {
-        SetLastError(uiResult); /* MSDN does not mention MsiRecordSetString() to set GetLastError().
-                                   But we do have an error code. Set last error manually. */
+        /* MSDN does not mention MsiRecordSetString() to set GetLastError().
+         * But we do have an error code. Set last error manually. */
+        SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiRecordSetString failed", __FUNCTION__);
         goto cleanup_MsiCreateRecord;
     }
@@ -412,16 +414,17 @@
     }
     if (uiResult != ERROR_SUCCESS)
     {
-        SetLastError(uiResult); /* MSDN does not mention MsiFormatRecord() to set GetLastError().
-                                   But we do have an error code. Set last error manually. */
+        /* MSDN does not mention MsiFormatRecord() to set GetLastError().
+         * But we do have an error code. Set last error manually. */
+        SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiFormatRecord failed", __FUNCTION__);
         goto cleanup_malloc_szPath;
     }
 
     /* Launch the OpenVPN GUI. */
     SHELLEXECUTEINFO sei = { .cbSize = sizeof(SHELLEXECUTEINFO),
-                             .fMask =
-                                 SEE_MASK_FLAG_NO_UI, /* Don't show error UI, we'll display it. */
+                             /* Don't show error UI, we'll display it. */
+                             .fMask = SEE_MASK_FLAG_NO_UI,
                              .lpFile = szPath,
                              .nShow = SW_SHOWNORMAL };
     if (!ShellExecuteEx(&sei))
@@ -528,7 +531,8 @@
                     break;
                 }
             }
-            break; /* Adapter names are unique. There should be no other adapter with this name. */
+            /* Adapter names are unique. There should be no other adapter with this name. */
+            break;
         }
     }
 
@@ -614,7 +618,8 @@
             }
 
             *iTicks += MSICA_ADAPTER_TICK_SIZE;
-            break; /* Adapter names are unique. There should be no other adapter with this name. */
+            /* Adapter names are unique. There should be no other adapter with this name. */
+            break;
         }
     }
 
@@ -678,9 +683,9 @@
     uiResult = MsiDatabaseOpenView(hDatabase, szQuery, &hViewST);
     if (uiResult != ERROR_SUCCESS)
     {
-        SetLastError(
-            uiResult); /* MSDN does not mention MsiDatabaseOpenView() to set GetLastError(). But we
-                          do have an error code. Set last error manually. */
+        /* MSDN does not mention MsiDatabaseOpenView() to set GetLastError(). But we
+         * do have an error code. Set last error manually. */
+        SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiDatabaseOpenView(\"%ls\") failed", __FUNCTION__, szQuery);
         goto cleanup_hDatabase;
     }
@@ -689,8 +694,9 @@
     uiResult = MsiViewExecute(hViewST, 0);
     if (uiResult != ERROR_SUCCESS)
     {
-        SetLastError(uiResult); /* MSDN does not mention MsiViewExecute() to set GetLastError(). But
-                                   we do have an error code. Set last error manually. */
+        /* MSDN does not mention MsiViewExecute() to set GetLastError(). But
+         * we do have an error code. Set last error manually. */
+        SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiViewExecute(\"%ls\") failed", __FUNCTION__, szQuery);
         goto cleanup_hViewST;
     }
@@ -715,8 +721,9 @@
         }
         else if (uiResult != ERROR_SUCCESS)
         {
-            SetLastError(uiResult); /* MSDN does not mention MsiViewFetch() to set GetLastError().
-                                       But we do have an error code. Set last error manually. */
+            /* MSDN does not mention MsiViewFetch() to set GetLastError().
+             * But we do have an error code. Set last error manually. */
+            SetLastError(uiResult);
             msg(M_NONFATAL | M_ERRNO, "%s: MsiViewFetch failed", __FUNCTION__);
             goto cleanup_hRecordProg;
         }
@@ -735,9 +742,10 @@
             uiResult = MsiGetComponentState(hInstall, szValue, &iInstalled, &iAction);
             if (uiResult != ERROR_SUCCESS)
             {
-                SetLastError(uiResult); /* MSDN does not mention MsiGetComponentState() to set
-                                           GetLastError(). But we do have an error code. Set last
-                                           error manually. */
+                /* MSDN does not mention MsiGetComponentState() to set
+                 * GetLastError(). But we do have an error code. Set last
+                 * error manually. */
+                SetLastError(uiResult);
                 msg(M_NONFATAL | M_ERRNO, "%s: MsiGetComponentState(\"%ls\") failed", __FUNCTION__,
                     szValue);
                 free(szValue);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
