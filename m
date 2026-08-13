Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19207C5CFEB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jZSiZ2HeA2xM1Ab13SFOkFrmP52E7ZVsG3fOxOQKN/w=; b=XnZz3XySebYuZ7a4zr1fZWCUgB
	ILP3Znl1cYcGB4AvsnFMiBlSjpIFQX5jhHHFIFSJIJY0kgABxqn9FdmFoZDxcs5R7jx9YmSRl2OOE
	q16O0BGx96ZbgyQ04AzaVvGMVQpxT33jazjnKzgAAWlLD5OCUKYLnpuej6mpXHXrdfDQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuPAy-0007uY-Ns;
	Thu, 13 Aug 2026 06:44:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuPAx-0007uS-Rp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 06:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BAm7b878mHKK/5iws+JzsvnnLC/DeD5+aiFjXdxJNAU=; b=WRCZGSgRH3ijVTwzrrqxCgbfKN
 V8Ci/DMJ4wUbQA/mL9MHDkTYsRxQN5jKX2tK4ZWFrSb4AnQizWI7Rq1DYJZV57Yfk4yw+np4BZ4tO
 cFygjmoesfu90UH40uCmBJocUWf5xDJKpNcIZ+a19qj3glXYWeWFaG5KTn7yylvEJUnI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BAm7b878mHKK/5iws+JzsvnnLC/DeD5+aiFjXdxJNAU=; b=D
 Ro0WmUL/IjnClvevc9JN1sAazn1kW6X6m8HQCvP069pg/kQRKGJYssgoEuyEqf7byMtmXsjFRKeF7
 opjk1yhUQfbOlDL/1Xkyg+A6hd0S9KHGvXwHxWUg2IhjHkWfIXvfqvMVWPK7aeu7eddXS1EpvhoWm
 Fp+Sl7L8YQeiRy1c=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuPAv-0004qy-V1 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 06:44:27 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so83256f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786603459; x=1787208259; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BAm7b878mHKK/5iws+JzsvnnLC/DeD5+aiFjXdxJNAU=;
 b=JPjHR8EbmGIcu/d0rrdrDcYI+9CBrg6ushR9bPWjrmT/k0i/mN74OAIwfj89stF6i3
 aU487P++gbIffaqq07J/8QKp2bLMIKQiCdWzr+q6Ge3w1kCWx8Snaf8vjNZDC8un3c5u
 X8QkQft3Qp+txnaTiYUJyoqJ+zUlDEzKjyu0vSiqrdMbOtW3qG7EEyIISs2waRxZj01A
 57c3vRzsZrm4SXMyoWaxqB81/8bkB7iMnFeP2a2Vh/g0F7rkj8J2pOLY5hvhN+v6VmbX
 8zHjutDossz/guR3bBTil2XRKm4r0qduEYkVhSScUhflCTLa4DEkycIi8bQ/yRZLLV+z
 us4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786603459; x=1787208259;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BAm7b878mHKK/5iws+JzsvnnLC/DeD5+aiFjXdxJNAU=;
 b=Yh2ICZ7OHX7hnsCkOl/07NueEE7kguyswYdrwDSrsLpI6ZR7QcMu3U9uhB9ppumSin
 VINyEY/ZLPukK2l2aiOZGsqRLiqi1jYAFrxnVCthc5/G8BvGPZmixP8hY7qF18DPzPQI
 u/mBDJilcwBxVX6gYzb8shz5tnJhTnoWJ12a8by9ZPO1UmxOc547GHmxD7gtDAQb9ztp
 oAkYhObC4mV6HQXvUkmk4bQt15g7J8qqpgymk8wDZX7Z5w5JRdDv8bqVgHxQ9ZyxiHPV
 ykI0owafSPbV2MT33HdJENc2dExp8MXix2NGzVMq4SS/ttbZ8j3iE/gNi+lvWBERxlIy
 eYRw==
X-Gm-Message-State: AOJu0YwNKBc7y8LXQHlvtz0fMMB99ARc74FSxFfQDCFt0hcz2TOJMx8b
 AJphny6Xdfw6Gvsq0QBQgz5hzfZe8EvTRrLYQjA/WT63wQgsCRrk45/r1L2c4SQ6dyLazgRmoR2
 f7m7GZV9aNDlGpzGK4ZkFGHyPY7FVAdWCFPTg8uEFi3nH3MMWgJBW8b3hh9xUA0AvivXf7shTBW
 uDCYzZhA==
X-Gm-Gg: AR+sD10YYs+p6URUun3188eZSmkWOItojwcmz7JpkY/mTrXRYER+5tSCznLjmwxAkUH
 91b9AovAJtWVPO01l3D5/B0wv9JfV/dhLMaQSH1iQBVaMM0dcF1REEluL878CmH48KLA02bDyBR
 QKf/1Lbzcl5Bi6smuYdf1OKh4qyRzFq4+Kl0/VdPI8tg39+4H9dLwIOkqKsuv0Dq3w0SsLsx9gJ
 KImPnUSj2224Yq4vMv0GbI7MVYt0drSOXvujEPfToQiuWUm5jHmfj4um6JcpxvHtjIoqexYFNrR
 nKXWJLmZg0G0nxZgrI7E6Rjgh7iTLtcXXJk3XKK0ppZA/WlS6uZaAP+7TENBSt28Jk/4q7ehMnp
 hgkdPW0UBBAT4TQyyKCHYCiG1wbvdnrvfnLtTxvWsQhO3hN+JEuXl5icLLBTYdV3Of9mGul+mNI
 Uw0u/XE3B0VRLcwQsTKu5VaBrgTr0avoELoWg6ZiFRlIDGGnu6Doddfhqr74C0sfJBUUCMe5pF3
 EsvhF3S2i+8EAu4YSzSNGM+Agok3vSuuFP7ZF4emH1N7c4iFxYk5/56qEflDfP0XtaQM719psJF
 32+wyr1QddJN402iCb5xJ7CUtpeTGgHc5Ca7c/bJ4O3WQOnJftU=
X-Received: by 2002:adf:f046:0:b0:47f:c3a1:244 with SMTP id
 ffacd0b85a97d-4815a053067mr3316192f8f.30.1786603459277; 
 Wed, 12 Aug 2026 23:44:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5c2842sm3621661f8f.35.2026.08.12.23.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:44:18 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 06:44:16 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7
X-Gerrit-Change-Number: 1841
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1841?usp=email>
X-Gerrit-Commit: dbd0b53611e96bbc18f9dfade4c0fd3e65b25222
In-Reply-To: <gerrit.1786465628000.I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7@gerrit.openvpn.net>
References: <gerrit.1786465628000.I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDY1NjI4MDAwLkkyYmQ1MjU5ZGU3MDJmY2U1ZDRlZjY5MjZjMWRlZTdjNmU2ZTU5N2Q3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71f115c6cd825300354c3d7d4c9abddca47f6a2e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuPAv-0004qy-V1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: otime: Remove
 openvpn_time()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3901963972452883014=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3901963972452883014==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TovCOT/k5kk="; charset=UTF-8

--TovCOT/k5kk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: otime: Remove openvpn_time()
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

otime: Remove openvpn_time()=


Using this function seems to be more complicated
than just using now dire=
ctly=2E

Suggested by Arne in review of cppcheck fixes=2E

Change-Id: I2bd5=
259de702fce5d4ef6926c1dee7c6e6e597d7
Signed-off-by: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841
Message-Id: <2026=
0811184408=2E3535-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38286=2Ehtml
Signed-off-=
by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/otime=2Eh
M sr=
c/openvpn/pkcs11=2Ec
M src/openvpn/push=2Ec
3 files changed, 3 insertions(+=
), 15 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/41/1841/2

diff --git a/src/openvpn/otime=2Eh b/src/openvpn/ot=
ime=2Eh
index f02cc31=2E=2Ed14f01e 100644
--- a/src/openvpn/otime=2Eh
+++ b=
/src/openvpn/otime=2Eh
@@ -93,17 +93,6 @@
 #endif
 }
 
-static inline time_=
t
-openvpn_time(time_t *t)
-{
-    update_time();
-    if (t)
-    {
-     =
   *t =3D now;
-    }
-    return now;
-}
-
 static inline void
 tv_clear(s=
truct timeval *tv)
 {
diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkc=
s11=2Ec
index cfcd372=2E=2E8b06fd0 100644
--- a/src/openvpn/pkcs11=2Ec
+++ =
b/src/openvpn/pkcs11=2Ec
@@ -42,7 +42,8 @@
 static time_t
 __mytime(void)
 =
{
-    return openvpn_time(NULL);
+    update_time();
+    return now;
 }
 =

 #if !defined(_WIN32)
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=
=2Ec
index ce2baf2=2E=2E97f352e 100644
--- a/src/openvpn/push=2Ec
+++ b/src=
/openvpn/push=2Ec
@@ -999,9 +999,7 @@
     else if (tls_authentication_stat=
us(c->c2=2Etls_multi) =3D=3D TLS_AUTHENTICATION_SUCCEEDED
              && =
c->c2=2Etls_multi->multi_state >=3D CAS_CONNECT_DONE)
     {
-        time_=
t now;
-
-        openvpn_time(&now);
+        update_time();
         if (=
c->c2=2Esent_push_reply_expiry > now)
         {
             ret =3D PUSH_=
MSG_ALREADY_REPLIED;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1841?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7
Gerrit-Change-Number: 1841
Ge=
rrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>

--TovCOT/k5kk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">otime: Remove openvpn_=
time()<br><br>Using this function seems to be more complicated<br>than just=
 using now directly=2E<br><br>Suggested by Arne in review of cppcheck fixes=
=2E<br><br>Change-Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1841<br>Message-Id: &lt;20260811184408=2E3535-1-g=
ert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg38286=2Ehtml<br>Signed-off-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/otime=2Eh<br>M=
 src/openvpn/pkcs11=2Ec<br>M src/openvpn/push=2Ec<br>3 files changed, 3 ins=
ertions(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1841/2</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh</span><br><span>index f02cc3=
1=2E=2Ed14f01e 100644</span><br><span>--- a/src/openvpn/otime=2Eh</span><br=
><span>+++ b/src/openvpn/otime=2Eh</span><br><span>@@ -93,17 +93,6 @@</span=
><br><span> #endif</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static inline time_t</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-openvpn_time(time_t *t)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    update_time();</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (t)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *t =3D =
now;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return now;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> static inline void</span><br><span> tv_cl=
ear(struct timeval *tv)</span><br><span> {</span><br><span>diff --git a/src=
/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span>index cfcd372=
=2E=2E8b06fd0 100644</span><br><span>--- a/src/openvpn/pkcs11=2Ec</span><br=
><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -42,7 +42,8 @@</span=
><br><span> static time_t</span><br><span> __mytime(void)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return openvpn_t=
ime(NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    updat=
e_time();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 now;</span><br><span> }</span><br><span> </span><br><span> #if !defined(_W=
IN32)</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=
=2Ec</span><br><span>index ce2baf2=2E=2E97f352e 100644</span><br><span>--- =
a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br=
><span>@@ -999,9 +999,7 @@</span><br><span>     else if (tls_authentication=
_status(c-&gt;c2=2Etls_multi) =3D=3D TLS_AUTHENTICATION_SUCCEEDED</span><br=
><span>              &amp;&amp; c-&gt;c2=2Etls_multi-&gt;multi_state &gt;=
=3D CAS_CONNECT_DONE)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        time_t now;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        openvpn_time(&amp;now);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        update_time();</span><br><span>         if (c-&gt;c2=2E=
sent_push_reply_expiry &gt; now)</span><br><span>         {</span><br><span=
>             ret =3D PUSH_MSG_ALREADY_REPLIED;</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1841?usp=3Demail">change 1841</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1841?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1841 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--TovCOT/k5kk=--


--===============3901963972452883014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3901963972452883014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3901963972452883014==--

