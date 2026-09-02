Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD31C624D0
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mL3+YnjxsKUwxdMP4UbOdNgLCrLOFQZNQN9rbQbjUUc=; b=EKpM926zM0SlkJAQVl7eCTCKts
	P2pzCXlmzVk6/z6USp2fC/ss5NevgwSRhh4jKFBPpjHvgFwP+RIOfaZP0h2XZU80ebWjKjr/OosUV
	V2Olyo/1QUcVIP0l3jQ5qqCMfcRD8EzgcGThvzay2KZhdNPZ5Bxapzq5HRFwdGHCwRrk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1imm-0004wH-Vt;
	Wed, 02 Sep 2026 11:05:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1iml-0004w6-Ua
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:05:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tvm+u1lW4rHziaAqYKoDgQYs5fHnEcmRxNUw2ImxbNY=; b=icAthaTMQiMZCllwc4qbY3Z0r5
 WOfyR2RNOKE/RpUNOOH1gh/n82UrnHhr8a5OYDUDXotIGy47JvF+q2RGUuYfNUqGnA2AOjHrRFUyr
 4bq9i50oUEkstkydznCbWaQczLsGWxtvMciumWWzbyTPpykZ62h9JQ0i+mCiJrjoZcHM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tvm+u1lW4rHziaAqYKoDgQYs5fHnEcmRxNUw2ImxbNY=; b=F
 wAwc0bMzeTLJd0g7S8EkGtELTpeeZ93yop1VGy7eN7SDyxwjhyxg+MoHX+/yjs1BDLrKcy433F4JY
 wv9vYRB71e/CwhKoLw2GFS7N7rXFYKCoK7//fMmneVyel27EaXJsXdlLcEMfJBrBpNqVC0NLy4Krr
 LKEdafO+49Dl2csM=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1iml-00078i-GK for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:05:44 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so586329f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788347137; x=1788951937; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tvm+u1lW4rHziaAqYKoDgQYs5fHnEcmRxNUw2ImxbNY=;
 b=NZxSB4nOJvK3QCjfGsH+MVF2/67esZd28Y5HvJegq8JGcGpKzpb9y+maL/VbrySo9k
 4c92/I6B//GNhCE7i/LNYb9HU03jx72kQyColJnKPZ2MYo9SlfOq3cCXyFExtjCeGjkL
 UQ19lknbCltB3mv0iu2F1Y9Y96j1mDty5bhpXLXlADB33pTayQtTB5UEqJMUYBuG5kJh
 YyO57sMyxzqkttdHulF3JRIwcdK2dxXAeY/TJ/4IQiief3qZwnaS+CjUtcagyeBnNeg4
 GViU2pHOHqYSiv0/1N64PtT8po747k7wdmMcRRaNgnf4UomAKUMl72mEBb3XOymy8KiK
 8UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788347137; x=1788951937;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tvm+u1lW4rHziaAqYKoDgQYs5fHnEcmRxNUw2ImxbNY=;
 b=AvfLMSJuEGSYsM0ztNAs2wmOEH0+QyhnclHWfBIh+IyczQrN6zq0H6JfaatFyy0RD9
 bCHA3b0Z/g7F6thpPDSLLPunJ0ydrb7ucI7HhB6qT9RxyoOkPoIeDQ27Q6o/X31CA3En
 wKDAjp3u9FTWy/JX2tieqKkmtWGq+4vlQmR5MAQkxTR2R+Kb4plaV7LkEaGn+n/HFttM
 4aZ+oD+BXf8vaX9Xmbk7mB1EICXzMFBTcXeHJ36WUf+mBkZ90r1AK+AeuPEZQvXOxXNj
 atxT76bQpZg5dIO4dcVnmkakWCC97CGmFIv3YExQyTCis0elos0V7uPLTZBgSty8Xi57
 hlTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy33pKKHkueO/SPF0CkvDbK1sYxuFCCDWQrCFGnZYTwjmbLpZnoGUej9uLZeUS3aw77wvRwDD0aaecWu6yI@lists.sourceforge.net
X-Gm-Message-State: AFuF++miofI/32YBtEOvRux1dv4kkR5VWHjyPCa9FwXI+GXkG/V2MAmT
 vKjO6NBcUfRq4Su9LdDL5KzS7lfSchmoNzuvW6HNx/aw/XSCh6OIDO8OPDjKzAHRYe+0m5MGihk
 lD+l97ZsgBQdA1e9XUKTlRi+FXaX9rXVcRvmStVsNxFt1snK2tl6aDXaZMZYZuRSbwiBE
X-Gm-Gg: AYBFou2QSzUo2odiDQjgqyN/mshTSKr7IprS26PFp2Uv/uXHHxUwoKxmsJjwR4XVpBc
 qHQalfHSi9+szsvWpq+alTMP3r6oeU7ABtWLE8C9HbVLplfnOi04i/f5LFDLJ2H2YjBdb0rqRlc
 hRxOUtvLxiuBYY8BmOjvyKhWHzJKNW5/ru5c/RH2hnVZmnwLaDhS/v1l2jv0LYGn6UbOwFTXuMF
 iKNRWOENsEhC1hwZwnCxPaCeM9WKxcCBOQHm1rP6Xs2YlUK68NS37mwfU2+O/jOM1h9hmDg8Ylu
 wyMwz1duSkOg76z0cAc6nHa9xPLpnEg6sYKaLPUTin0o5oNzRv5JVobMDpGxJlBQEFAfjkokNSb
 XUfntOmDcb6ZN7qDsqCU+Xu5tWrzr+GzA7Z8nmmGGklwDVuXw8TTN4GELtE8q97tNG7knhAPNu7
 4/I1h3+aFmYq4vc3K5hr9xFmidmnGpQuksYqKPzDf+lSM6zotFZH/FlRkkxGAU0mE68hHVOhje2
 V1YT/5zmcNg7k34agnub/ecwrx5RQYgnwnVznZjzA7MN29M0raifgG2NhDsVAsh202WzDn54743
 IoIxpfIEW5maUtOF7IoL7sAi2luIK37N8MfSk+7rJSZ3aNHGx6s=
X-Received: by 2002:a05:6000:220c:b0:484:3317:a1a with SMTP id
 ffacd0b85a97d-484914ccd59mr7647456f8f.27.1788347136671; 
 Wed, 02 Sep 2026 04:05:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72d2asm5378215f8f.8.2026.09.02.04.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 04:05:36 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 11:05:35 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I70282985a7e8e46add92b2277674cbca6bce39c1
X-Gerrit-Change-Number: 1890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1890?usp=email>
X-Gerrit-Commit: 03f8b88898b06d0d0acb3bded18eba82fa2e6277
In-Reply-To: <gerrit.1788282930000.I70282985a7e8e46add92b2277674cbca6bce39c1@gerrit.openvpn.net>
References: <gerrit.1788282930000.I70282985a7e8e46add92b2277674cbca6bce39c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MjgyOTMwMDAwLkk3MDI4Mjk4NWE3ZThlNDZhZGQ5MmIyMjc3Njc0Y2JjYTZiY2UzOWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b1025fac6deb516b971bcc7728146af11b4df8a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1iml-00078i-GK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tapctl: prevent
 binary planting with netsh
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1423305462024581360=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1423305462024581360==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BoAsQ+LiK80="; charset=UTF-8

--BoAsQ+LiK80=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1890?usp=3Demail )

Change subject: tapctl: prevent binary planting wit=
h netsh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tapc=
tl: prevent binary planting with netsh

Provide a application name to Creat=
eProcess(), so that it doesn't try to
locate an executable - somewhere=2E I=
nstead construct the full path to
netsh=2Eexe in the system dir and pass th=
at to the function instead of NULL=2E

Discovered and reported by BreachX Z=
ero Day Labs, using Typhon AI Mil v2=2E
Contributing Researcher: Vivek Pari=
kh=2E

Reported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by: V=
ivek Parikh <vivek=2Eparikh@breachx=2Eai>
Github: OpenVPN/openvpn-private-i=
ssues#164
CVE: 2026-84226
Change-Id: I70282985a7e8e46add92b2277674cbca6bce3=
9c1
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1890
Message-Id: <20260902095734=2E26857-1-gert@greenie=2Em=
uc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg38894=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/tapctl/tap=2Ec
1 file changed, 16 insertions(+), 11 deleti=
ons(-)




diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec
index 1d949=
88=2E=2E769df6c 100644
--- a/src/tapctl/tap=2Ec
+++ b/src/tapctl/tap=2Ec
@@=
 -921,32 +921,38 @@
                                     bEnable ? enable_d=
evice : disable_device, pbRebootRequired);
 }
 
-/* stripped version of Exe=
cCommand in interactive=2Ec */
 static DWORD
-ExecCommand(const WCHAR *cmdl=
ine)
+ExecNetsh(PWSTR cmdline)
 {
     DWORD exit_code;
     STARTUPINFOW s=
i;
     PROCESS_INFORMATION pi;
     DWORD proc_flags =3D CREATE_NO_WINDOW =
| CREATE_UNICODE_ENVIRONMENT;
-    WCHAR *cmdline_dup =3D NULL;
 
     Zero=
Memory(&si, sizeof(si));
     ZeroMemory(&pi, sizeof(pi));
-
     si=2Ecb =
=3D sizeof(si);
 
-    /* CreateProcess needs a modifiable cmdline: make a =
copy */
-    cmdline_dup =3D _wcsdup(cmdline);
-    if (cmdline_dup
-      =
  && CreateProcessW(NULL, cmdline_dup, NULL, NULL, FALSE, proc_flags, NULL,=
 NULL, &si, &pi))
+    WCHAR appName[MAX_PATH];
+    WCHAR netsh_exe[] =3D =
L"\\netsh=2Eexe";
+    UINT sysdir_len =3D GetSystemDirectoryW(appName, _co=
untof(appName));
+    if (sysdir_len =3D=3D 0)
+    {
+        wcscpy_s(app=
Name, _countof(appName), L"C:\\Windows\\system32");
+    }
+    else if (sy=
sdir_len + _countof(netsh_exe) > _countof(appName))
+    {
+        return =
ERROR_INSUFFICIENT_BUFFER;
+    }
+    wcscat_s(appName, _countof(appName),=
 netsh_exe);
+
+    if (CreateProcessW(appName, cmdline, NULL, NULL, FALSE,=
 proc_flags, NULL, NULL, &si, &pi))
     {
         WaitForSingleObject(pi=
=2EhProcess, INFINITE);
         if (!GetExitCodeProcess(pi=2EhProcess, &ex=
it_code))
         {
             exit_code =3D GetLastError();
         }
=
-
         CloseHandle(pi=2EhProcess);
         CloseHandle(pi=2EhThread);
=
     }
@@ -955,7 +961,6 @@
         exit_code =3D GetLastError();
     }
 
=
-    free(cmdline_dup);
     return exit_code;
 }
 
@@ -1013,7 +1018,7 @@
 =

     free(szOldName);
 
-    dwResult =3D ExecCommand(szCmdLine);
+    dwR=
esult =3D ExecNetsh(szCmdLine);
     free(szCmdLine);
 
     if (dwResult !=
=3D ERROR_SUCCESS)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1890?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70=
282985a7e8e46add92b2277674cbca6bce39c1
Gerrit-Change-Number: 1890
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mail=
box=2Eorg>
Gerrit-CC: d12fk <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--BoAsQ+LiK80=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1890?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">tapctl: prevent binary planting with netsh=
<br><br>Provide a application name to CreateProcess(), so that it doesn&#39=
;t try to<br>locate an executable - somewhere=2E Instead construct the full=
 path to<br>netsh=2Eexe in the system dir and pass that to the function ins=
tead of NULL=2E<br><br>Discovered and reported by BreachX Zero Day Labs, us=
ing Typhon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>=
Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by:=
 Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Github: OpenVPN/openvp=
n-private-issues#164<br>CVE: 2026-84226<br>Change-Id: I70282985a7e8e46add92=
b2277674cbca6bce39c1<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlic=
h=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890<br>Message-Id: &=
lt;20260902095734=2E26857-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38894=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/tapctl/tap=2Ec<br>1 file changed, 16 insertions(+), 11 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec</span=
><br><span>index 1d94988=2E=2E769df6c 100644</span><br><span>--- a/src/tapc=
tl/tap=2Ec</span><br><span>+++ b/src/tapctl/tap=2Ec</span><br><span>@@ -921=
,32 +921,38 @@</span><br><span>                                     bEnable=
 ? enable_device : disable_device, pbRebootRequired);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* str=
ipped version of ExecCommand in interactive=2Ec */</span><br><span> static =
DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ExecCommand(cons=
t WCHAR *cmdline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Ex=
ecNetsh(PWSTR cmdline)</span><br><span> {</span><br><span>     DWORD exit_c=
ode;</span><br><span>     STARTUPINFOW si;</span><br><span>     PROCESS_INF=
ORMATION pi;</span><br><span>     DWORD proc_flags =3D CREATE_NO_WINDOW | C=
REATE_UNICODE_ENVIRONMENT;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    WCHAR *cmdline_dup =3D NULL;</span><br><span> </span><br><span>   =
  ZeroMemory(&amp;si, sizeof(si));</span><br><span>     ZeroMemory(&amp;pi,=
 sizeof(pi));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     si=2Ecb =3D sizeof(si);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* CreateProcess needs a modifiable c=
mdline: make a copy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    cmdline_dup =3D _wcsdup(cmdline);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (cmdline_dup</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        &amp;&amp; CreateProcessW(NULL, cmdline_dup, NULL, N=
ULL, FALSE, proc_flags, NULL, NULL, &amp;si, &amp;pi))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    WCHAR appName[MAX_PATH];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR netsh_exe[] =3D L&quo=
t;\\netsh=2Eexe&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    UINT sysdir_len =3D GetSystemDirectoryW(appName, _countof(appName));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sysdir_len =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        wcscpy_s(appName=
, _countof(appName), L&quot;C:\\Windows\\system32&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (sysdir_len + _countof(netsh_exe) &gt; =
_countof(appName))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
ERROR_INSUFFICIENT_BUFFER;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wcs=
cat_s(appName, _countof(appName), netsh_exe);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (CreateProcessW(appName, cmdline, NULL, NULL, FALSE, proc_fla=
gs, NULL, NULL, &amp;si, &amp;pi))</span><br><span>     {</span><br><span> =
        WaitForSingleObject(pi=2EhProcess, INFINITE);</span><br><span>     =
    if (!GetExitCodeProcess(pi=2EhProcess, &amp;exit_code))</span><br><span=
>         {</span><br><span>             exit_code =3D GetLastError();</spa=
n><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>         CloseHandle(pi=2EhProcess);</span><br><span>    =
     CloseHandle(pi=2EhThread);</span><br><span>     }</span><br><span>@@ -=
955,7 +961,6 @@</span><br><span>         exit_code =3D GetLastError();</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    free(cmdline_dup);</span><br><span>     return exit_code=
;</span><br><span> }</span><br><span> </span><br><span>@@ -1013,7 +1018,7 @=
@</span><br><span> </span><br><span>     free(szOldName);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dwResult =3D Exec=
Command(szCmdLine);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    dwResult =3D ExecNetsh(szCmdLine);</span><br><span>     free(szCmdLine)=
;</span><br><span> </span><br><span>     if (dwResult !=3D ERROR_SUCCESS)</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail">change 1890</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I70282985a7e8e46add92b2=
277674cbca6bce39c1 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1890 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>

</body></html>
--BoAsQ+LiK80=--


--===============1423305462024581360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1423305462024581360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1423305462024581360==--

