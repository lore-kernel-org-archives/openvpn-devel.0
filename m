Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FABC624D6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XIKeHz6PpMAD7u6x4pOtw8LZcV4IaBzLiz+GhjdPT74=; b=io/gHYQSloZXAtUnG+Q0m29aL+
	RsBoOhwgbh81sStHBWe3jFRLqHJs9YNTsQTNor2xKyAMV1eg6gHpq7GnsS1QMRVzFJSjgQgv0eVAi
	+QQ2krEIo36Tx7xok9IZO6Y0tbq9nO5m0Xc9BgYcr476xIF0YYyo/vljZtZ1RPrvVDlk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1imp-0000I0-76;
	Wed, 02 Sep 2026 11:05:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1imn-0000Hn-59
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:05:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dqpQVmMtIyv/MnpsJj+kiTwvBKLZ/G2BirQJlzWBHOw=; b=XKTP7C8M7K+NThiTwx/r7wN8md
 20PIv6Zx4ZnK7546CeAE/EzvnxegDBpx4QdSD0J9Q0edC0BtYMEmbZ16lR9I/h+Ys8HAPVfvFLRG4
 VXdXb195pa3K6eqiyFdv+sWn5UxbyWf3f+FtaX0Mel8lNlImr1rZfGSWpnHJR4IIOJAI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dqpQVmMtIyv/MnpsJj+kiTwvBKLZ/G2BirQJlzWBHOw=; b=c
 qomZOHe7k4vh0ycDUk/FDZg+L9DAFSfiCAXbLfOALOPunBV15rNWcf3hv3nsTAbPmWC09IIqe3y8w
 pC2ewUZrgSve7+l6croLti/zyTgJZoKpZNG43eWaMMnLYFcmTgRag3jnkxlM+JIyV41iHP0cj0a7I
 4sTRyjwVUamo/xNs=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1imk-00078e-Pz for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:05:45 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso705179f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 04:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788347136; x=1788951936; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dqpQVmMtIyv/MnpsJj+kiTwvBKLZ/G2BirQJlzWBHOw=;
 b=hFS1vtSYiCQ5Kw/TYQCyBuXYqsW6Rmr+f9MGQowVlgwazPo5uEIXivsPMN/Y+MS6vE
 4edY7T3stSb1M7slLws6lsGR54dHY+s9xrthUVoDfmS3kDPecpkmSBGvcq59dxSR9dwQ
 Ap4t7gN72ag57NCr8KxP1IYiRlryJeFM9+Bmk9wNnHEo9VqdxdwqRKQH1N89YDQ4G7d1
 KvRia0AeBRIrjcJerwrP33VMawasOHmfV6k1ZRYMblV8vBSqw3/EswznN3lSNOCxOp+W
 0bwZXtQDT5ysmaTAOhqa3K/9hg61dDqiUJbnf0nSbp3HKBg7T7d0GMne2Vt0RX4fN8D+
 JJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788347136; x=1788951936;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dqpQVmMtIyv/MnpsJj+kiTwvBKLZ/G2BirQJlzWBHOw=;
 b=hDNlA7s/cNaorzMvCLrNwgjpTS59Te6lb1f51SqmkdyVInbXqaCqvLzPtv1kE/27qJ
 NEsOKSMsLmMyh9mbwXsDhlQjwaxIQ/023EznQLetCYtzzZcMr/3N/d2Desxo/qFcnybV
 82qToR59EbceK/+IYv32HsspS0f776jBzZz7fWt8+GgGBymlr03FyDFWOK/SEwG0gAVj
 kukK645cZgCU7evu+yze+mWvkQg+ZWtAP+EFz9HNJI6SZOUcqW0qQWrVV22yuPqNW3NH
 ysTPmTLzbofg98fhG7nfFKOJUoDfBTu/Z7Yx1sc4AbyPHiuTOuCuQeYIE9S7Mv+QM4iu
 YbyQ==
X-Gm-Message-State: AFuF++mvw6qVZgfgIXfDMdSXNcAIv1NL+BIv0BxQER75BpSddefdueEl
 hT4MByFrW+3nHjjZTTR4bsZ1tJGxgvJEQv5rVQj2U5IcZJiTRFJP7x1HGI0N9HzpLEwHiRW8NNr
 f9Tspdofb5vxtfDyHm18dXayKZHMhFPW135AMriQz8IKozbIqXKQmSla+2Tz0uoJNhPmx
X-Gm-Gg: AR+sD11xcMzlRKzKXZSCUJRuDEtAfeFEXJVKrfTdCZraGgBNq0v0GMe1P+j4lAM2JYs
 YfStz+QGXCUePbcuxWDAR8eGGQz7jWnj1MOsFmeG6WpPrsnODcUBHNXWD6pMDz/ZDCrDRLHkuts
 J8Lee4hMs8SSgluec7+zP8dG+553JW85mI5Jl1zdh9w9ZQ21Hlo7X6zID2pA0IvroJ8b1TIns5D
 TaLZl8jK5aHXDzSd4iQTFnPg4ecSc2GKcUTSKdSLrVT5jNcqL2/qwfhM42rP8RYYIrGJrysLGLs
 0dF492gKFn9ZnSZy6D7UVewbzyWSSxss4povk6VF9LVpmAwG6avg/qDgWvhFbwWDXjxFIHlD/82
 XV0DwmSsz6GBaF9b8slsb1OPsXs1/f2+kq6Rwo5ZOxNLSCcqYEPz7Rkg4wKKCJF00mC+Y03h7xb
 wyPvrAXGVvrajOpGmpot4W9aULqje+QSychcl+hEh/RTR/d+9nkmUkfpPYL7bEDJ+qvZEiJmUzI
 6S5alPlae25df6ZvPsgYKHgp8ptOVZU4LByvSewM2hd/+GARXPBRDfgWL7oXRHQ9p+n0Mi/TGwO
 i3mMlXqsO9grNodobrCq/9Ss4FO9t9dzayV06Ka1ofne7HOBW8M=
X-Received: by 2002:a05:600c:4693:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-49ce5817d63mr56362665e9.9.1788347135753; 
 Wed, 02 Sep 2026 04:05:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5941cb4sm20506605e9.4.2026.09.02.04.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 04:05:34 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 11:05:33 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I70282985a7e8e46add92b2277674cbca6bce39c1
X-Gerrit-Change-Number: 1890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1890?usp=email>
X-Gerrit-Commit: 03f8b88898b06d0d0acb3bded18eba82fa2e6277
In-Reply-To: <gerrit.1788282930000.I70282985a7e8e46add92b2277674cbca6bce39c1@gerrit.openvpn.net>
References: <gerrit.1788282930000.I70282985a7e8e46add92b2277674cbca6bce39c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MjgyOTMwMDAwLkk3MDI4Mjk4NWE3ZThlNDZhZGQ5MmIyMjc3Njc0Y2JjYTZiY2UzOWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b1025fac6deb516b971bcc7728146af11b4df8a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1imk-00078e-Pz
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8697857931158048212=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8697857931158048212==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IRTzb1dQdwU="; charset=UTF-8

--IRTzb1dQdwU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, razvanc, 

I'd like you to reexamine a change=2E Pl=
ease visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail
=

to look at the new patch set (#2)=2E

The following approvals got outdated=
 and were removed:
Code-Review+2 by razvanc


Change subject: tapctl: preve=
nt binary planting with netsh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

tapctl: prevent binary planting with netsh

Provide a appl=
ication name to CreateProcess(), so that it doesn't try to
locate an execut=
able - somewhere=2E Instead construct the full path to
netsh=2Eexe in the s=
ystem dir and pass that to the function instead of NULL=2E

Discovered and =
reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E
Contributing R=
esearcher: Vivek Parikh=2E

Reported-by: Vivek Parikh <vivek=2Eparikh@breac=
hx=2Eai>
Tested-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Github: Open=
VPN/openvpn-private-issues#164
CVE: 2026-84226
Change-Id: I70282985a7e8e46a=
dd92b2277674cbca6bce39c1
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=
=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890
Message-Id: <20260902095734=2E26=
857-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg38894=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M src/tapctl/tap=2Ec
1 file changed, 16 in=
sertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/90/1890/2

diff --git a/src/tapctl/tap=2Ec b/src/tap=
ctl/tap=2Ec
index 1d94988=2E=2E769df6c 100644
--- a/src/tapctl/tap=2Ec
+++ =
b/src/tapctl/tap=2Ec
@@ -921,32 +921,38 @@
                                =
     bEnable ? enable_device : disable_device, pbRebootRequired);
 }
 
-/* =
stripped version of ExecCommand in interactive=2Ec */
 static DWORD
-ExecCo=
mmand(const WCHAR *cmdline)
+ExecNetsh(PWSTR cmdline)
 {
     DWORD exit_co=
de;
     STARTUPINFOW si;
     PROCESS_INFORMATION pi;
     DWORD proc_flag=
s =3D CREATE_NO_WINDOW | CREATE_UNICODE_ENVIRONMENT;
-    WCHAR *cmdline_du=
p =3D NULL;
 
     ZeroMemory(&si, sizeof(si));
     ZeroMemory(&pi, sizeof=
(pi));
-
     si=2Ecb =3D sizeof(si);
 
-    /* CreateProcess needs a modif=
iable cmdline: make a copy */
-    cmdline_dup =3D _wcsdup(cmdline);
-    i=
f (cmdline_dup
-        && CreateProcessW(NULL, cmdline_dup, NULL, NULL, FA=
LSE, proc_flags, NULL, NULL, &si, &pi))
+    WCHAR appName[MAX_PATH];
+    =
WCHAR netsh_exe[] =3D L"\\netsh=2Eexe";
+    UINT sysdir_len =3D GetSystemD=
irectoryW(appName, _countof(appName));
+    if (sysdir_len =3D=3D 0)
+    {=

+        wcscpy_s(appName, _countof(appName), L"C:\\Windows\\system32");
+=
    }
+    else if (sysdir_len + _countof(netsh_exe) > _countof(appName))
+=
    {
+        return ERROR_INSUFFICIENT_BUFFER;
+    }
+    wcscat_s(appNa=
me, _countof(appName), netsh_exe);
+
+    if (CreateProcessW(appName, cmdli=
ne, NULL, NULL, FALSE, proc_flags, NULL, NULL, &si, &pi))
     {
         W=
aitForSingleObject(pi=2EhProcess, INFINITE);
         if (!GetExitCodeProce=
ss(pi=2EhProcess, &exit_code))
         {
             exit_code =3D GetLas=
tError();
         }
-
         CloseHandle(pi=2EhProcess);
         CloseH=
andle(pi=2EhThread);
     }
@@ -955,7 +961,6 @@
         exit_code =3D GetL=
astError();
     }
 
-    free(cmdline_dup);
     return exit_code;
 }
 
@@=
 -1013,7 +1018,7 @@
 
     free(szOldName);
 
-    dwResult =3D ExecCommand=
(szCmdLine);
+    dwResult =3D ExecNetsh(szCmdLine);
     free(szCmdLine);
=
 
     if (dwResult !=3D ERROR_SUCCESS)

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I70282985a7e8e46add92b2277674cbca6bce39c1
Gerrit-C=
hange-Number: 1890
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Em=
uc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: d12fk <heiko@openvpn=2Ene=
t>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--IRTzb1dQdwU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by razvanc<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">tapctl: prevent binary planting with netsh<br><br>Provide =
a application name to CreateProcess(), so that it doesn&#39;t try to<br>loc=
ate an executable - somewhere=2E Instead construct the full path to<br>nets=
h=2Eexe in the system dir and pass that to the function instead of NULL=2E<=
br><br>Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mi=
l v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>Reported-by: Viv=
ek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek Parikh &l=
t;vivek=2Eparikh@breachx=2Eai&gt;<br>Github: OpenVPN/openvpn-private-issues=
#164<br>CVE: 2026-84226<br>Change-Id: I70282985a7e8e46add92b2277674cbca6bce=
39c1<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>A=
cked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890<br>Message-Id: &lt;2026090209573=
4=2E26857-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38894=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/tapctl/t=
ap=2Ec<br>1 file changed, 16 insertions(+), 11 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/90/1890/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec</s=
pan><br><span>index 1d94988=2E=2E769df6c 100644</span><br><span>--- a/src/t=
apctl/tap=2Ec</span><br><span>+++ b/src/tapctl/tap=2Ec</span><br><span>@@ -=
921,32 +921,38 @@</span><br><span>                                     bEna=
ble ? enable_device : disable_device, pbRebootRequired);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* =
stripped version of ExecCommand in interactive=2Ec */</span><br><span> stat=
ic DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ExecCommand(c=
onst WCHAR *cmdline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ExecNetsh(PWSTR cmdline)</span><br><span> {</span><br><span>     DWORD exi=
t_code;</span><br><span>     STARTUPINFOW si;</span><br><span>     PROCESS_=
INFORMATION pi;</span><br><span>     DWORD proc_flags =3D CREATE_NO_WINDOW =
| CREATE_UNICODE_ENVIRONMENT;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    WCHAR *cmdline_dup =3D NULL;</span><br><span> </span><br><span>=
     ZeroMemory(&amp;si, sizeof(si));</span><br><span>     ZeroMemory(&amp;=
pi, sizeof(pi));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     si=2Ecb =3D sizeof(si);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* CreateProcess needs a modifiabl=
e cmdline: make a copy */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    cmdline_dup =3D _wcsdup(cmdline);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (cmdline_dup</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        &amp;&amp; CreateProcessW(NULL, cmdline_dup, NULL=
, NULL, FALSE, proc_flags, NULL, NULL, &amp;si, &amp;pi))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    WCHAR appName[MAX_PATH];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR netsh_exe[] =3D L&=
quot;\\netsh=2Eexe&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    UINT sysdir_len =3D GetSystemDirectoryW(appName, _countof(appName=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sysdir_l=
en =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wcscpy_s(appN=
ame, _countof(appName), L&quot;C:\\Windows\\system32&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else if (sysdir_len + _countof(netsh_exe) &g=
t; _countof(appName))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn ERROR_INSUFFICIENT_BUFFER;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
wcscat_s(appName, _countof(appName), netsh_exe);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (CreateProcessW(appName, cmdline, NULL, NULL, FALSE, proc_=
flags, NULL, NULL, &amp;si, &amp;pi))</span><br><span>     {</span><br><spa=
n>         WaitForSingleObject(pi=2EhProcess, INFINITE);</span><br><span>  =
       if (!GetExitCodeProcess(pi=2EhProcess, &amp;exit_code))</span><br><s=
pan>         {</span><br><span>             exit_code =3D GetLastError();</=
span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span>         CloseHandle(pi=2EhProcess);</span><br><span> =
        CloseHandle(pi=2EhThread);</span><br><span>     }</span><br><span>@=
@ -955,7 +961,6 @@</span><br><span>         exit_code =3D GetLastError();</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    free(cmdline_dup);</span><br><span>     return exit_c=
ode;</span><br><span> }</span><br><span> </span><br><span>@@ -1013,7 +1018,=
7 @@</span><br><span> </span><br><span>     free(szOldName);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dwResult =3D E=
xecCommand(szCmdLine);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    dwResult =3D ExecNetsh(szCmdLine);</span><br><span>     free(szCmdLi=
ne);</span><br><span> </span><br><span>     if (dwResult !=3D ERROR_SUCCESS=
)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail">change 1890</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70282985a7e8e=
46add92b2277674cbca6bce39c1 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1890 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--IRTzb1dQdwU=--


--===============8697857931158048212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8697857931158048212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8697857931158048212==--

