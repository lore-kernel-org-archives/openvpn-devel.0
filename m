Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C26606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=APvu+4Ft;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a4u8rqUA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ByH4DGaS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V8BlI+mX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WKAdpyfoMvEB2KcUCgXcQ/CGLNSxArX4G3Ooq6cxK1k=; b=APvu+4FtMwgXTS/s+HI4lqTF9X
	rB/q8gZ8h4NZFqI7dSDDBUFbvM5C8FDlU9hC54/3fxz6y+14EEDeJl7VWUWJcsgEVMhdSYYRlTVdl
	vqd0qtASKICpHDdHK3IHk0f+LqgMbsLc+aYs9SSz7hhzjO/M4C/PY538IIBa8xL+TxtE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVYxK-000000001yB-3XcC;
	Mon, 23 Nov 2026 18:39:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVYxI-000000001y0-1JCf
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:39:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7ksimITn0GHUFj2UOTXCWGKgoRqwSXleehIGDpk99kQ=; b=a4u8rqUAI4BMC2ZYo2iyQztMIB
 NH/tb4iNKJ/45QMUflDfwlpHPA2fLducqAl6Z1yTUo914Bt8t+3NDgp/pxbkp1ENSaLppCDNbdKBq
 dVA2oGkFDeMzmPx1LkyoI/TbG0gkJ7QBX2ZAbxsREUXIi3ee/K90F1CfZ2b6TuAmHzEI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7ksimITn0GHUFj2UOTXCWGKgoRqwSXleehIGDpk99kQ=; b=ByH4DGaSiOg8ye6Ue/McqWJPnq
 qMGXmI17NAX7jmCHkuUYxU2kqyBjOuTH9tkgEFZODLqv14HkcrFnroZ8KGUYoWbns5KSJZlbJ6Klm
 DPw5sPu7/orf6voUooa+skwXkq5LKgXPdyLrlRyzQ4USS+GQsObAp3RNKIAOtvBVnm3M=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVYxF-000000003Va-1vFR for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:39:56 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so29315685e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 10:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795459187; x=1796063987; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7ksimITn0GHUFj2UOTXCWGKgoRqwSXleehIGDpk99kQ=;
 b=V8BlI+mXuLQXI/Zrz0c/QtZuKB8Us+kafqu9AYyWGHItERqXkcd+26w2D4oHpTW05Y
 B8EPPAud8sDF6PjkEWSyQvhrVRjLjp2lnSsUMgYGcTGp6iW/VXUmB8US7rpP5Avr/fzQ
 uDxBW8DtDQuvsiKTSXyu/KyyaxaquhKraHrQboEYUf1mVjFS0h1sw/yoCwXu3iFGe+sz
 Y6OStOhSkK61LgX0m8gHGLha0v1p8+zByJ9Dwa25rwg+Seeyu23QeB24CZtE8ijup0fJ
 6kzd1Nxjue3wH+Y38K01d7I100HNXfBZR/tQ3gktrATNO3BIfMcTLZj3I6BZoMIHSweK
 DJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459187; x=1796063987;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7ksimITn0GHUFj2UOTXCWGKgoRqwSXleehIGDpk99kQ=;
 b=snF0v2/WXZGVAsmg9Yp+AqFmMWJZpcuVK+uQsCZzFo9bnI9Na8mn//6UNMS51gvCB/
 YiZOP2O5MV4bSSCDx0SJ/tGcNK80S8cXedb0dq0Ktt1w4Z0Rnu7pPAUSBIU1usBBo4X6
 cyWx4LjqSDxL4zIKI0JIIsQWvWGTwLdTLMeJXJNvIIkRieTzvLY9a6ViYA+A07hMKMAT
 IhByRxjQk0NVSc67XXw2xeiVOrKiIHlNvR5JiqztJs+uIX8gOJ5m/jVzs+AEb4sW7WeN
 4ecNUGc8xojqBeLopAprQIxb31GJO9ihBXf3QiB8aVFrlwJQ3DDyednqyk11s9zMPigS
 b5hw==
X-Gm-Message-State: APuU4Z+LbvG0MvhnwvxZMVN8eSbBqayiWpbNUveGa2b+6ATS7gq0xlpP
 mvX0yqZR20S6BQdnCqKKQgJeH0q1ynwAr/cJCTIyiiC9qrO0W+P3Z2+HQup8kzwByioPre21wAu
 0xiPVra+hlokGznBAgHwS9OCNazFPvND/KOfssgNOTeNt4xF/1kuY4s9iPpyg1bs/EHHTxr4Zig
 9BCPIBhg==
X-Gm-Gg: AZFdTZfYOR/oSGMbtZODX0Gql3eDAnpnq0k0WASESmJZtEN5u3WPfuQds1m518j+M7P
 9310zxXBJasXkqPqWBCCd+WT5u6+bpUtdPPJ2/9W58YR4f6xe9tvUv2z8HJZUv5t7y+RMUfhNwi
 AxAlB93QYhbv+OX4bNGS2ae8oOKgfzLk0uwUqFTwnu/F/6AW+OFR4/boCaoOfFYdJpZx1T1Snnp
 T+Gyqkwqq3M8tVeLz039mYSao2Dg3XFAW0yZSbYWfnszlyYkgvJai310i6pWLZTiF9GNvls3I0b
 3mVXsipJxHpJqDuDj6NGpfhfLrVbQ/Vq7O6u/nSIjLEjf2oEaC+yO7cLa8uDv+KzueHuwi4KyLP
 JxdG3ZITsln2x7s/QRB+Y2UvR/WlFwCjSInU3LcQXxK1Kgn/7tD2uvAaclVzVkABk11NMpY9fUY
 iL6JwVbtbEJDWGKefseelGjbE+C8qkRXPqazVKi4GzXi/Nfdbno49cmpioJP81cwGMSxIvNFkYw
 xeGvR+sz9h/V3gZI4KsPVljTyfb+SrySbDz8gQktY7TE6FjHbYtP2dsJ0DymB0+xi5E1J/M49pL
 rP680k4gJV+9oWXQ8PU0GiLCciBIIanyVAPpblmiAsogmPNN0sGwncGkkohkwHiQ6muzKKYn+Or
 6YcXIKHAwHyOOhdMdh4u0vjcahRfWeAi6ZSrNkY15f/7Sq4l9qSRbiprxrFEH6kghUGmjGMTqg0
 qL0GDTrzMWC1LWDmc=
X-Received: by 2002:a05:600c:a088:b0:4bb:6473:cde9 with SMTP id
 5b1f17b1804b1-4bb8880f2d8mr213639885e9.6.1795459186771; 
 Mon, 23 Nov 2026 10:39:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dd55sm23158910f8f.30.2026.11.23.10.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:39:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 18:39:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80
X-Gerrit-Change-Number: 2238
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2238?usp=email>
X-Gerrit-Commit: f7d89f63de3c40c24bb00e7894a882261c11c130
In-Reply-To: <gerrit.1795353062000.I58b88ca3934e52cfc5140a564c9ed7260857ce80@gerrit.openvpn.net>
References: <gerrit.1795353062000.I58b88ca3934e52cfc5140a564c9ed7260857ce80@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MzUzMDYyMDAwLkk1OGI4OGNhMzkzNGU1MmNmYzUxNDBhNTY0YzllZDcyNjA4NTdjZTgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a3e69ab5f40586dc67b465574e82be35bbe74ed3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVYxF-000000003Va-1vFR
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: drop
 redundant NULL checks
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8165769487781565672=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8165769487781565672==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4lYuRyVDlZA="; charset=UTF-8

--4lYuRyVDlZA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2238?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: manage: drop redunda=
nt NULL checks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


manage: drop redundant NULL checks

man_need() already guarantees p[1] fo=
r log and echo, and
up_query_type is non-NULL once "needed" holds in
man_qu=
ery_password_base64()=2E

Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857c=
e80
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2238
Message-Id: <20261123134906=2E31644-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41822=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 3 insertions(+), =
9 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/38/2238/2

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manag=
e=2Ec
index 112db4a=2E=2Ed63d53b 100644
--- a/src/openvpn/manage=2Ec
+++ b/=
src/openvpn/manage=2Ec
@@ -1051,7 +1051,7 @@
         msg(M_CLIENT, "ERROR:=
 no password is currently needed at this time");
         return;
     }
- =
   if (!man->connection=2Eup_query_type || !streq(man->connection=2Eup_quer=
y_type, type))
+    if (!streq(man->connection=2Eup_query_type, type))
    =
 {
         msg(M_CLIENT, "ERROR: password of type '%s' entered, but we nee=
d one of type '%s'",
             type, man->connection=2Eup_query_type);
@=
@ -1665,10 +1665,7 @@
     {
         if (man_need(p, 1, MN_AT_LEAST))
    =
     {
-            if (p[1])
-            {
-                man_log(man, =
p[1]);
-            }
+            man_log(man, p[1]);
             if (p[2=
])
             {
                 man_log(man, p[2]);
@@ -1679,10 +1676,7 =
@@
     {
         if (man_need(p, 1, MN_AT_LEAST))
         {
-           =
 if (p[1])
-            {
-                man_echo(man, p[1]);
-          =
  }
+            man_echo(man, p[1]);
             if (p[2])
             {=

                 man_echo(man, p[2]);

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80
Gerrit-=
Change-Number: 2238
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--4lYuRyVDlZA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2238?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">manage: drop redundant NULL checks<br><br>man_need() already guarantees=
 p[1] for log and echo, and<br>up_query_type is non-NULL once &quot;needed&=
quot; holds in<br>man_query_password_base64()=2E<br><br>Change-Id: I58b88ca=
3934e52cfc5140a564c9ed7260857ce80<br>Signed-off-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238<b=
r>Message-Id: &lt;20261123134906=2E31644-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg41822=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file changed, 3 insertions(+)=
, 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/38/2238/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 112db4a=2E=2Ed6=
3d53b 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+=
++ b/src/openvpn/manage=2Ec</span><br><span>@@ -1051,7 +1051,7 @@</span><br=
><span>         msg(M_CLIENT, &quot;ERROR: no password is currently needed =
at this time&quot;);</span><br><span>         return;</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!man-&gt;con=
nection=2Eup_query_type || !streq(man-&gt;connection=2Eup_query_type, type)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!streq(man=
-&gt;connection=2Eup_query_type, type))</span><br><span>     {</span><br><s=
pan>         msg(M_CLIENT, &quot;ERROR: password of type &#39;%s&#39; enter=
ed, but we need one of type &#39;%s&#39;&quot;,</span><br><span>           =
  type, man-&gt;connection=2Eup_query_type);</span><br><span>@@ -1665,10 +1=
665,7 @@</span><br><span>     {</span><br><span>         if (man_need(p, 1,=
 MN_AT_LEAST))</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (p[1])</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                man_log(man, p[1]);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            man_log(man, p[1]);</span><br><span>       =
      if (p[2])</span><br><span>             {</span><br><span>            =
     man_log(man, p[2]);</span><br><span>@@ -1679,10 +1676,7 @@</span><br><=
span>     {</span><br><span>         if (man_need(p, 1, MN_AT_LEAST))</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (p[1])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        man_echo(man, p[1]);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            man_echo(man, p[1]);</span><br><span>             if (p[2])</s=
pan><br><span>             {</span><br><span>                 man_echo(man,=
 p[2]);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2238?usp=3Demail">change 2238</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I58b88ca3934e52cfc5140a=
564c9ed7260857ce80 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2238 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--4lYuRyVDlZA=--


--===============8165769487781565672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8165769487781565672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8165769487781565672==--

