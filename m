Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5B606A332
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aI/uHzWG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JsFD65uP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XgbYUPQx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cUGmFGTk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zO76GuyzH00IatmeM2UPPyFAJUQcjJtFmPG0jh7ZDXg=; b=aI/uHzWGqsRkq0LV3GVrJLJfvT
	RbWzdaO4d7p3LxI9mmvX+uOfFLPTgR48ELbmUGwRRPFIIydrDBfWy5SjQcZStfKeE4bX3PS6XWK3/
	gMVSIvsAH8m8mjHELCAbiFQjI69IJRlUtstCso4B4AvOpwXoQTb8a5evaVX2/HnCWknk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGTw-000000006jH-03nQ;
	Sat, 14 Nov 2026 16:20:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGTu-000000006jA-3p4T
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qDsOACqitKjqqQl//J8dt4eWEY3JiVJMLDV2Fj7oHUU=; b=JsFD65uPOwMZz9msE6eLl0B1Ny
 p4xAkaolZ/7HclfzxTBz3nyQ/awRW1Qv+E46VC9t+amMh72rdotlCCg7y0TwtZLHpeUbL8Gmpui2N
 Qhie/NVhja0opa92nnnVR9GtYVJz22F5WMv1ITwl/Cj2HIk8J6dS2bkKgpyReP4703XY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qDsOACqitKjqqQl//J8dt4eWEY3JiVJMLDV2Fj7oHUU=; b=XgbYUPQxz4YWM58yCO+QlGWBL8
 du07byxVybq4rQGrT2D3zAXyAB2RjqZrcD7bwSqr57gkuRlgN4R2zngKqZJKOfAlt7UOFynRXmNQ3
 7mQVBvCA9CK9dmfy/EmQuvb5gScEnf8VV9J8yrgLNOIvla2cvfLyrszUSvPVZoOPB0NQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGTt-000000000ww-2gUL for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:19:58 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso11898315e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794673191; x=1795277991; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qDsOACqitKjqqQl//J8dt4eWEY3JiVJMLDV2Fj7oHUU=;
 b=cUGmFGTkWXrsjaU0jKMAqS1Bl17aVS/HTymkzqCsJYLy84A97Dm5B7B8XT2N3PoKQV
 i+Rl+vaugs6AmUhT5V+COunJiNi38/Kp3oW3QTBqFO6OAKgA5sTjQZAO9PmvfUKINpA8
 138t8bJ08xTNk/Fzbc7s10DDfmGc5HShcR7qua2CPSfgrPQ/TAaYjAEBkWmqvnJLOuk9
 mkjM6M2/eRkg/fsaom/zccs2Wr5FAIDxHXCO2DG8LS2cxu7iOIrshdk1wDwtlStSeJ6v
 2ckWz8bwKVSdVdhQQp8oLoUAaX4i7OURYixX5ozMekW2geDffv4TuVVpvMq7viAOwrgx
 t1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794673191; x=1795277991;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qDsOACqitKjqqQl//J8dt4eWEY3JiVJMLDV2Fj7oHUU=;
 b=eGy1M6qghkYASuSm9VNkV9MQ8TmwAtX0sfI60ozxUAdv0BKD1GvmcEZQ1PrdQQ4QhK
 dSAuQcBfdcjKQBMgN+jqdpepWK9t5lMY7QSWsTYcn5Q7Bv5k2kM1aFYbbExNoOK4gmj9
 tm5CotojaigCEFX2Y3esWCc11b2MHZHxyag2DgiiUGYJ3lBU2cjhyLuk5SmyV8reUq9K
 NLNKKCZmrnCa+Qjvdl/Jd8vSFQEpbOKSxdaDoRsAwuB4XOa5eKpevzqp4Hw3BLHS0ysn
 9Np/UzYARy68Zkp8g69ixgT9cPRKYDazRCcs3lCT3q+z9F+/qJuxnpPcnThc5qUVTdwa
 YYHA==
X-Gm-Message-State: APuU4Z8kktVea06NgLr7MjjjmZhpRTR3hE9G3A0TqP6tbyJUkJiJFuCi
 nmzvWbQDOGIifcLwtZJmf4oRCH2uX1S74EEMkgtgbLoKL38Xyn/IC//r90pQLrx6EzF6Omcqk3C
 //NzIU5vz6YG6UWytBs+t77zNmYX2L2jVsjx3PX1D5oNCBOT3sjYR70U9SWT8DyxrbfLr
X-Gm-Gg: AYBFou0wzFGuHdngJ+jPZGDg0yKG/q/69g6YFc0T6aZLxyRNmmdsON1Y3IY3WZMf4fa
 DSf+VAS4SFnJTxMxof6B9ioX3PE+pMbKc54KafUU3gB9Rz9UnTlaxvq1OjWhfPwdwRetqXlgNXJ
 /rgPEiF/zE5UE8w6PYwu2E/aodFh0G0b/7tO5s/EKBXPSGTF1PN4J+euk9w0Yt5OuVyfx9Dy600
 MH6GhAgjad+MRX4RWPwtDVCX9U5XruSJSW1/HIQJRwkXjK20z7u1EXcErVNlbMzuiDL5J2z5jbV
 NKRBEfZT/syYlGkNYnuSyq+HTNO1ufnDszpdUWeO/jUUEmvuzgGrZJ/CqJNX/X268ZhnJVCjHcW
 W1/urGH3q8VeefSxAYEj2hmcpjpMup7DWhAPOqB2crZf7vs9v5db0Mi29jH324U6f2ntQBOV2oD
 HJX4sdcO7ZWa26SL9EBfZxuzsuclkum8EsUK3H9R+61V31KJO5omogj6HszpvoVItJ4i0tdewLH
 xLrT/kFo+aok2T4HTy2mAf2Jey8EZgIREuOeAZ+v0OqCvH3En1HpbYp7uId0AWEl5Qlu7NR4BZK
 AiTHv83jxh+cm/at65Qr7BQcWus9b0r3SGxxqDRHOjFIJXIpwOlXGfF2aU5vVziecEfc8Tlclid
 8Rq4hRDThPcUD86u7LwzRtAYGQkoGdny6Mb8h3EWr0hqXGAb7gsGB3iSOLSzoeh0k6JYLL1F7HI
 K6cv/DrKW+RhRWAICH
X-Received: by 2002:a05:600c:34d5:b0:4b7:6942:39bd with SMTP id
 5b1f17b1804b1-4bb55ab1610mr116441815e9.26.1794673190926; 
 Sat, 14 Nov 2026 08:19:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb65ce005bsm58080885e9.14.2026.11.14.08.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:19:50 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:19:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icab02b28773a409821fa9b80ccb1560d2796d1df
X-Gerrit-Change-Number: 2117
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2117?usp=email>
X-Gerrit-Commit: 3c687de340436e0c6d516df73379ee993782d13e
In-Reply-To: <gerrit.1793776420000.Icab02b28773a409821fa9b80ccb1560d2796d1df@gerrit.openvpn.net>
References: <gerrit.1793776420000.Icab02b28773a409821fa9b80ccb1560d2796d1df@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NDIwMDAwLkljYWIwMmIyODc3M2E0MDk4MjFmYTliODBjY2IxNTYwZDI3OTZkMWRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5a54d8843247b81c8cc5cd40687f1716549f65f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGTt-000000000ww-2gUL
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: print
 tls-crypt-v2 client key hint before CRYPT_ERROR
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
Content-Type: multipart/mixed; boundary="===============4171974413635446639=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4171974413635446639==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1uswe56H1E0="; charset=UTF-8

--1uswe56H1E0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2117?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: tls_crypt: print tls=
-crypt-v2 client key hint before CRYPT_ERROR
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tls_crypt: print tls-crypt-v2 client key hi=
nt before CRYPT_ERROR

CRYPT_ERROR() jumps to error_exit, so the hint about=
 a client key
generated for a different server key was never printed=2E Log=
 it first,
and drop a stray ')' from it=2E

Broken since 7a477c16 ("Print a=
 more user-friendly error when
tls-crypt-v2 client auth fails")=2E

Change-=
Id: Icab02b28773a409821fa9b80ccb1560d2796d1df
Signed-off-by: Razvan Cojocar=
u <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117
Message-Id=
: <20261104122103=2E15637-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40810=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/tls_cr=
ypt=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/2117/2

diff --git a/s=
rc/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 08d9fcd=2E=2E64d=
b29f 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec=

@@ -493,9 +493,9 @@
     {
         dmsg(D_CRYPTO_DEBUG, "tag      : %s", =
format_hex(tag, sizeof(tag_check), 0, &gc));
         dmsg(D_CRYPTO_DEBUG, =
"tag_check: %s", format_hex(tag_check, sizeof(tag_check), 0, &gc));
-      =
  CRYPT_ERROR("client key authentication error");
         msg(D_TLS_DEBUG_=
LOW, "This might be a client-key that was generated for "
-                =
             "a different tls-crypt-v2 server key)");
+                    =
         "a different tls-crypt-v2 server key");
+        CRYPT_ERROR("clie=
nt key authentication error");
     }
 
     if (BLENZ(&plaintext) < sizeof=
(client_key->keys))

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2117?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Icab02b28773a409821fa9b80ccb1560d2796d1df
Gerrit-Change-Number: 2117
G=
errit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>

--1uswe56H1E0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2117?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">tls_crypt: print tls-crypt-v2 client key hint before CRYPT_ERROR<br><br=
>CRYPT_ERROR() jumps to error_exit, so the hint about a client key<br>gener=
ated for a different server key was never printed=2E Log it first,<br>and d=
rop a stray &#39;)&#39; from it=2E<br><br>Broken since 7a477c16 (&quot;Prin=
t a more user-friendly error when<br>tls-crypt-v2 client auth fails&quot;)=
=2E<br><br>Change-Id: Icab02b28773a409821fa9b80ccb1560d2796d1df<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2117<br>Message-Id: &lt;20261104122103=2E15637-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg40810=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tls_crypt=2Ec<b=
r>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/211=
7/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=
=2Ec</span><br><span>index 08d9fcd=2E=2E64db29f 100644</span><br><span>--- =
a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec=
</span><br><span>@@ -493,9 +493,9 @@</span><br><span>     {</span><br><span=
>         dmsg(D_CRYPTO_DEBUG, &quot;tag      : %s&quot;, format_hex(tag, s=
izeof(tag_check), 0, &amp;gc));</span><br><span>         dmsg(D_CRYPTO_DEBU=
G, &quot;tag_check: %s&quot;, format_hex(tag_check, sizeof(tag_check), 0, &=
amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CRYP=
T_ERROR(&quot;client key authentication error&quot;);</span><br><span>     =
    msg(D_TLS_DEBUG_LOW, &quot;This might be a client-key that was generate=
d for &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                    &quot;a different tls-crypt-v2 server key)&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
     &quot;a different tls-crypt-v2 server key&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        CRYPT_ERROR(&quot;client key aut=
hentication error&quot;);</span><br><span>     }</span><br><span> </span><b=
r><span>     if (BLENZ(&amp;plaintext) &lt; sizeof(client_key-&gt;keys))</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2117?usp=3Demail">change 2117</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2117?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Icab02b28773a409821fa9b80ccb1560d2=
796d1df </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2117 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--1uswe56H1E0=--


--===============4171974413635446639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4171974413635446639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4171974413635446639==--

