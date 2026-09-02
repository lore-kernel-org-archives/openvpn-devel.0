Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C496BC61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+7UDN2ufgqRxa4WOH0waCoZ1f8SeYXikwfFxk7sBOm4=; b=e2oZAqxKb9fXUWq7sSXh3JvCfh
	MChJK1AtEd/j5TfoeY/6mNe+/ke87bKjnPlnAgCMRAlpgQB16JhgSqxtB68hOW8cxt2pSn3Tbp74h
	KxO6ja/+FRAsCf8TBBAROEZ3U42aW7RYcsFfUMx7AddykZHBVF3aPPDvpvBopaQwxdW8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1hj1-0003em-QR;
	Wed, 02 Sep 2026 09:57:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x1hiz-0003ed-V0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 09:57:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a/aOQ5s91BcHBgpbr8W2Wh1agFFKnEu5S9qA6441gQA=; b=nO55PCOlKhE/in+nUAb+/vA/u1
 Jxo2gegzOVK6fR3XIXVxdqrqaMaIWMK7snYStliRjs10u2P6hxiH8x5H6rqSoY5KKhilK08t3xccJ
 Nf75qzXffbEZBrVlct51/t0o7OODKEJlWha+UGcU5dykydex0rn3zSmkTTnMTm8idRqA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a/aOQ5s91BcHBgpbr8W2Wh1agFFKnEu5S9qA6441gQA=; b=ZfSn+vbbSPKB97lm8d31NhAQek
 oo48K2SsVYRWqwCCxwg/fTs3gthLuE65YKQE07qpKYZ5LEW9mRckkmF3n2SBW7a6Pu0bUWwLquLuI
 fuC/nJpbIrujmFfGhEhVmvp7b1qDrEaV0dhv8/NXNmSmVzZGqKOGFm/yNGYMuPp2ZT2Q=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1hiv-00082a-W0 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 09:57:43 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6829vZIQ026870
 for <openvpn-devel@lists.sourceforge.net>; Wed, 2 Sep 2026 11:57:35 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6829vZ0r026869
 for openvpn-devel@lists.sourceforge.net; Wed, 2 Sep 2026 11:57:35 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  2 Sep 2026 11:57:29 +0200
Message-ID: <20260902095734.26857-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788282930000.I70282985a7e8e46add92b2277674cbca6bce39c1@gerrit.openvpn.net>
References: <gerrit.1788282930000.I70282985a7e8e46add92b2277674cbca6bce39c1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x1hiv-00082a-W0
Subject: [Openvpn-devel] [PATCH v1] tapctl: prevent binary planting with
 netsh
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

Provide a application name to CreateProcess(), so that it doesn't try to
locate an executable - somewhere. Instead construct the full path to
netsh.exe in the system dir and pass that to the function instead of NULL.

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2.
Contributing Researcher: Vivek Parikh.

Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
Tested-by: Vivek Parikh <vivek.parikh@breachx.ai>
Github: OpenVPN/openvpn-private-issues#164
CVE: 2026-84226
Change-Id: I70282985a7e8e46add92b2277674cbca6bce39c1
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1890
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1890
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 1d94988..769df6c 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -921,32 +921,38 @@
                                     bEnable ? enable_device : disable_device, pbRebootRequired);
 }
 
-/* stripped version of ExecCommand in interactive.c */
 static DWORD
-ExecCommand(const WCHAR *cmdline)
+ExecNetsh(PWSTR cmdline)
 {
     DWORD exit_code;
     STARTUPINFOW si;
     PROCESS_INFORMATION pi;
     DWORD proc_flags = CREATE_NO_WINDOW | CREATE_UNICODE_ENVIRONMENT;
-    WCHAR *cmdline_dup = NULL;
 
     ZeroMemory(&si, sizeof(si));
     ZeroMemory(&pi, sizeof(pi));
-
     si.cb = sizeof(si);
 
-    /* CreateProcess needs a modifiable cmdline: make a copy */
-    cmdline_dup = _wcsdup(cmdline);
-    if (cmdline_dup
-        && CreateProcessW(NULL, cmdline_dup, NULL, NULL, FALSE, proc_flags, NULL, NULL, &si, &pi))
+    WCHAR appName[MAX_PATH];
+    WCHAR netsh_exe[] = L"\\netsh.exe";
+    UINT sysdir_len = GetSystemDirectoryW(appName, _countof(appName));
+    if (sysdir_len == 0)
+    {
+        wcscpy_s(appName, _countof(appName), L"C:\\Windows\\system32");
+    }
+    else if (sysdir_len + _countof(netsh_exe) > _countof(appName))
+    {
+        return ERROR_INSUFFICIENT_BUFFER;
+    }
+    wcscat_s(appName, _countof(appName), netsh_exe);
+
+    if (CreateProcessW(appName, cmdline, NULL, NULL, FALSE, proc_flags, NULL, NULL, &si, &pi))
     {
         WaitForSingleObject(pi.hProcess, INFINITE);
         if (!GetExitCodeProcess(pi.hProcess, &exit_code))
         {
             exit_code = GetLastError();
         }
-
         CloseHandle(pi.hProcess);
         CloseHandle(pi.hThread);
     }
@@ -955,7 +961,6 @@
         exit_code = GetLastError();
     }
 
-    free(cmdline_dup);
     return exit_code;
 }
 
@@ -1013,7 +1018,7 @@
 
     free(szOldName);
 
-    dwResult = ExecCommand(szCmdLine);
+    dwResult = ExecNetsh(szCmdLine);
     free(szCmdLine);
 
     if (dwResult != ERROR_SUCCESS)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
