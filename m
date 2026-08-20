Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAC9C5DF82
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BIjUCycPU8lVc1abXkwh2ZfEX5jM2gcVeTmjM4zcvi4=; b=mEX4kK+lJ5nn1ZrBj2YXl4sC6s
	EeZixE4Z4GhieXVw3Zz+CWLP/IEjj0//bf0S7x9U7IcCmGti13ApYglgjbgTL60u475RxbiF1g/5b
	r0CzJ6nnbN7HQWkd+4gM4521fhvSs/XS20RJqKe2tTV2aM2LQy+FrsD4tUu0Oa6mca9I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx0XU-0003a8-7I;
	Thu, 20 Aug 2026 11:02:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx0XQ-0003ZS-1o
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Mjztc4sHCpBVoFHeQolAxrkFt3Z6mfpkCCW/27lfjLo=; b=WPNOLXtP5UPbDXy99RWPIghdF0
 yLhYAN45HWA8w1kCk4rfaMYOa5J+LumYBW6ZNfd4E7Ff/oBaZcAwGrOAgMvQV/ID51GGW7S00tQgX
 hso8E+1WRbVTvi576eQMBYiDIqazBqdERAD9NLUUrzc/7KnYrQF5p8KL7FCMT7YNIzIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mjztc4sHCpBVoFHeQolAxrkFt3Z6mfpkCCW/27lfjLo=; b=m
 6OMjq9OWIqnnLh25pNwUssL6jID7JUesYLAhYwOVIYoLdIfB/redpcSke/MZI8URP7NFh9R5QXxUG
 Wc7GxnAw2KfKoYQLuhW0tlMrcnvg9ZzUl9vTV2YA66vSenA8FC4wCM6sff/zQN3VEs/i+mruXm5mw
 DeE8Wz7JjOs1b7rk=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx0Ww-00054k-1A for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:01:54 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4956242332dso21732005e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 04:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787223707; x=1787828507; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mjztc4sHCpBVoFHeQolAxrkFt3Z6mfpkCCW/27lfjLo=;
 b=T9/q3YosvwLkyX+F99I8iLsdByRNQ+oANVAWWJIbQyhEz8ANKGgka8Yj9f7ySyPcy4
 YF9jTGOXZ3ns+2a7SoXXSiblYmZgeGZQc77h4Jka93eIcOEeh+WNBBJWemrIwS2+J2tr
 M3jlH7Z4RU1cuKToS+dr4pPPVAy/KjT4qu9+LHSOIHmj3+zv6MghLM78Ag0ChnZd5rwW
 7QZM2UV9F8iB5e8ISQZw+/k4iFiMVtRGSg4ZreXcXtU4GYjCwJnq3IlHQYWyaZQhSOpQ
 Dvem6EAQtTNT482CiI9hvmeYACMc5G3xD76woK9098xoGnD65Up8XIdfcGWK1c4wQNNN
 Yy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787223707; x=1787828507;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mjztc4sHCpBVoFHeQolAxrkFt3Z6mfpkCCW/27lfjLo=;
 b=IJltzDsz2QThMb3PHDDLrgNoRlfyjH7iE0/jVNXo4tIbSeHSu4y7aaR9EBpQ42Vp5R
 S/rH0p3p4kYhM5ay7K2hkNG4y+OZC6Jw1Fo8/fsRDCJB7nA34CeMLUMe0hwDecEJ+GRV
 EYFDmzi5gYgSZFMwklymGAQM4LiXHlzUWcLmQ+mNSLwKZ1H557vX5rrghwZi2G6b3Oww
 ZNHBoADBSOLJoIRPyueI0ZoNuJjpi/xPGBh++gmGsmqQgd2xfziDF+4sRQucgNCY5w9g
 giBy3gBH0vpMX0FgIM+YdLnJ6qBIXyuwHxwPvbdMKrEqywEVOOGNUQE8WHCdm47sS6TA
 cp0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyZ9jMIMRKZxSM5Sp71YvkQOjCfv7RCDNWCCvmlfR9jLmoxsIi6+D5SeXZf2ufaSCNTA7A8V2bBM8SdCfV@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzY8BQleK7KNVQmh2QGhnsfkRC+Vr3pPpyecr5gnMqi5ECYKmIR
 esAHC54hnWD0QCKi+RY5Xbsg+v4ffjZ1AKDA74DIZzoDWGl+EiApGzo4+G75Hw30A2lmub9XUu1
 X+m7SVA6V4k+m8HsIrKoDeiEDimVCL3l8arVUUmCUUdB65DUPIsS6gApKadGeU2h9kJGk
X-Gm-Gg: AR+sD104hNeOrnenS6M+j9n0zo7XeD/kLLjqCZ56ylAzHE+tpkQnKMCcfg79zGqEeOs
 q6Jho3a+MtImFtQ0yCCwzFeAn4yk7n5FvQm05zi0f4s6L4b1O/YWyFIDzVnlxFRWgZkCperv/H7
 lm6P+3pIHkccU2mJPk3tMz1mWDu8H6d0+fOWoia+hNON5BccIZeqys3aGnH4APb6i+CrfEmVmLP
 Xgbnm21FT9/foVs3Ue3P4u1Jrl0d1GL05jnxPV0CjEI2U9zExAqCt4fZbq4mzHjPPQmgq8qHML2
 VUx2QXSi4tUZQOaeuAr1k8kNF+409uKth7XuoJ94Gk8XfGrNsSCRigi0PzJcQy8Vsqjr5g9ma/N
 oXtgs/pISMEHbaVcm/e7Lfv8OKtzdjcmWbnBvlkF6qm/7KLKBkI0Fl1PDQM+3X080s++KeeQh8S
 yWZLHDwo0NOw5Un78lwQwqA72NxhetGXlFo74YEV+vmKT0yBXPZ3a3T6Mbg+a4q3zy259Vaqgx5
 njn8peKD3Ktj/7AbCkSxG89hSg3xURLHn94A9A+by/k/SJMu46NQiUy2u7ROtTkgl2/al0oCz5K
 18n2rC2VG58L6DIUFKAEY59BXhPak2a+DBFSC5Ps6BNrS+LnHwkY
X-Received: by 2002:a05:600c:c170:b0:499:86ce:465e with SMTP id
 5b1f17b1804b1-499aa15d8dcmr220120805e9.4.1787223706474; 
 Thu, 20 Aug 2026 04:01:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b20a19eesm21363325e9.0.2026.08.20.04.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 04:01:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 11:01:42 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439
X-Gerrit-Change-Number: 1848
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1848?usp=email>
X-Gerrit-Commit: 34661b1e1e06df3d6bbfdb85a33db87b33a79034
In-Reply-To: <gerrit.1787144531000.Ibb80db0547dcc0935964c9bd40222c27aac80439@gerrit.openvpn.net>
References: <gerrit.1787144531000.Ibb80db0547dcc0935964c9bd40222c27aac80439@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTQ0NTMxMDAwLkliYjgwZGIwNTQ3ZGNjMDkzNTk2NGM5YmQ0MDIyMmMyN2FhYzgwNDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4976a9a29997dc685fd6e1288232dd9fe19346c8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx0Ww-00054k-1A
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: .clang-format:
 Convert deprecated setting KeepEmptyLinesAtTheStartOfB...
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1778489513539099018=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1778489513539099018==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ouqvLDrOaUA="; charset=UTF-8

--ouqvLDrOaUA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1848?usp=3Demail )

Change subject: =2Eclang-format: Convert deprecated=
 setting KeepEmptyLinesAtTheStartOfBlocks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

=2Eclang-format: Convert deprecated setting Ke=
epEmptyLinesAtTheStartOfBlocks

Convert to new KeepEmptyLines settings=2E T=
his adds
AtStartOfFile setting and applies it=2E

Change-Id: Ibb80db0547dcc=
0935964c9bd40222c27aac80439
Signed-off-by: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848
Message-Id: <20260820101226=
=2E9581-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg38551=2Ehtml
Signed-off-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
---
M =2Eclang-format
M src/openvpn/crypto=
_mbedtls=2Eh
M src/openvpnserv/validate=2Eh
3 files changed, 4 insertions(+=
), 3 deletions(-)




diff --git a/=2Eclang-format b/=2Eclang-format
index =
4774d1e=2E=2E0823739 100644
--- a/=2Eclang-format
+++ b/=2Eclang-format
@@ =
-32,7 +32,10 @@
 IndentWidth: '4'
 IndentWrappedFunctionNames: false
 Inser=
tBraces: true
-KeepEmptyLinesAtTheStartOfBlocks: false
+KeepEmptyLines:
+  =
AtEndOfFile: false
+  AtStartOfBlock: false
+  AtStartOfFile: false
 MaxEmp=
tyLinesToKeep: '2'
 PointerAlignment: Right
 ReflowComments: true
diff --gi=
t a/src/openvpn/crypto_mbedtls=2Eh b/src/openvpn/crypto_mbedtls=2Eh
index 0=
4346a9=2E=2E5c3b670 100644
--- a/src/openvpn/crypto_mbedtls=2Eh
+++ b/src/o=
penvpn/crypto_mbedtls=2Eh
@@ -1,4 +1,3 @@
-
 /*
  *  OpenVPN -- An applicat=
ion to securely tunnel IP networks
  *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based
diff --git a/src/openvpnserv/validate=2E=
h b/src/openvpnserv/validate=2Eh
index 12150f1=2E=2E2da41dc 100644
--- a/sr=
c/openvpnserv/validate=2Eh
+++ b/src/openvpnserv/validate=2Eh
@@ -1,4 +1,3 =
@@
-
 /*
  *  OpenVPN -- An application to securely tunnel IP networks
  * =
            over a single TCP/UDP port, with support for SSL/TLS-based

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibb80db0547dcc0935964c9bd4=
0222c27aac80439
Gerrit-Change-Number: 1848
Gerrit-PatchSet: 3
Gerrit-Owner:=
 flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ouqvLDrOaUA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1848?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">=2Eclang-format: Convert deprecated settin=
g KeepEmptyLinesAtTheStartOfBlocks<br><br>Convert to new KeepEmptyLines set=
tings=2E This adds<br>AtStartOfFile setting and applies it=2E<br><br>Change=
-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1848<br>Message-Id: &lt;20260820101226=2E9581-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38551=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M =2Eclang-format<br>M src/openvpn/crypto_mbe=
dtls=2Eh<br>M src/openvpnserv/validate=2Eh<br>3 files changed, 4 insertions=
(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/=2Eclang-format b/=2Eclan=
g-format</span><br><span>index 4774d1e=2E=2E0823739 100644</span><br><span>=
--- a/=2Eclang-format</span><br><span>+++ b/=2Eclang-format</span><br><span=
>@@ -32,7 +32,10 @@</span><br><span> IndentWidth: &#39;4&#39;</span><br><sp=
an> IndentWrappedFunctionNames: false</span><br><span> InsertBraces: true</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-KeepEmptyLinesAtTheStar=
tOfBlocks: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Kee=
pEmptyLines:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  AtEnd=
OfFile: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  AtSt=
artOfBlock: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
AtStartOfFile: false</span><br><span> MaxEmptyLinesToKeep: &#39;2&#39;</spa=
n><br><span> PointerAlignment: Right</span><br><span> ReflowComments: true<=
/span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Eh b/src/openvpn/c=
rypto_mbedtls=2Eh</span><br><span>index 04346a9=2E=2E5c3b670 100644</span><=
br><span>--- a/src/openvpn/crypto_mbedtls=2Eh</span><br><span>+++ b/src/ope=
nvpn/crypto_mbedtls=2Eh</span><br><span>@@ -1,4 +1,3 @@</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * =
 OpenVPN -- An application to securely tunnel IP networks</span><br><span> =
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span>diff --git a/src/openvpnserv/validate=2Eh b/src/openvpnserv/=
validate=2Eh</span><br><span>index 12150f1=2E=2E2da41dc 100644</span><br><s=
pan>--- a/src/openvpnserv/validate=2Eh</span><br><span>+++ b/src/openvpnser=
v/validate=2Eh</span><br><span>@@ -1,4 +1,3 @@</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  *  OpenVPN =
-- An application to securely tunnel IP networks</span><br><span>  *       =
      over a single TCP/UDP port, with support for SSL/TLS-based</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1848?usp=3Demail">change 1848</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ibb80db0547dcc0935964c9bd40222c=
27aac80439 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1848 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"=
display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--ouqvLDrOaUA=--


--===============1778489513539099018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1778489513539099018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1778489513539099018==--

