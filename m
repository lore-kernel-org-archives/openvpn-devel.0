Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C133DC55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3L7jy5LIZpFoW3n/EzbyCBHY7xEf+/FG7pigEM1UcT8=; b=XxloSouUMXwxRMIG2LU3TxIGfQ
	aA2sZt6iReY4g4P/wDmWf+FDYxUsgObC33QJhuLl53L24GHx9XtTgoU3yvixFg1KUZ0KF8U4evuml
	7GYGltOruQDsEFVDLLMDda8+vN4G23e7cC93lM73H3GxO5LPoiuq8UjLTktw8Znou1a4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrwDV-0002MD-Kb;
	Thu, 06 Aug 2026 11:24:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrwDU-0002M6-RS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:24:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Tgbx7tSeSjv5A+aHg08oB8KdgYCh/mhPPDJ246tn1KM=; b=A1yeQZFBW67+Thfi0th8NuhjhY
 z/sZY6ZMVRTqHdz3cCQ2NZu4ttuIT8gzSxQlul5bhJ0A4NuzS7EfwkIN74ifXvrj/pBnTOhTO/JfG
 QnOmlWNR142iotyh/zxvpAY5Ejk3PBNAxE/dS6iTrLLBPnoyB56maOptVxODSn1LgoJw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Tgbx7tSeSjv5A+aHg08oB8KdgYCh/mhPPDJ246tn1KM=; b=i
 GBg/5N6xSoaFpa7hqWilBEN2CqKw36WOTT3OlwVNkADDWx5LLs1D4kpTztJdpFoOSUnSmu8tKeZNP
 YFm4s74QvxOZLgs2Y7yZqCxRCsM6XZkFit8OOro1WhscV61VX6Lit2N/GAA8EvJ3Km3Lp5U3ZKKoB
 JY3II+zccuYKJ15Y=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrwDY-00024h-6z for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:24:53 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so20231565e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 04:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786015486; x=1786620286; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tgbx7tSeSjv5A+aHg08oB8KdgYCh/mhPPDJ246tn1KM=;
 b=ggUYRwS9sICKcNbhFLFfRC560DByQOdzrYCuLQ/hvlNKo/cwWehKqm6qkqpCAKtn+t
 615hBwda7IxyOcWmpRc109W4wAwOa1L3OYX6x5aCJerEqltXpMwfLyoJ/CaOFhTrnGCd
 TttSQZAjhyrszGykeMzuS/Ig3jxk1ofj954a89cOT3ZgKwp5QfBXxerl5Oaio6n+id6C
 z6IOB5lIrZLAZ/aApybHgXSk+80KCYGjLvkwjMxdBGRDnhnrvwz50xzRyvH/FIFLZd+h
 vGL4xEvb2iSE9LnZ/Ml/oHx3rXDOo6eP+tigFtBdU2O53bGzOEDIw+znpn2Iwi1kz0yK
 MkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786015486; x=1786620286;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Tgbx7tSeSjv5A+aHg08oB8KdgYCh/mhPPDJ246tn1KM=;
 b=ogL7xF75ZRh+8yJmWZlmLTPiA48HvUgBNe2h1O/lT4VtjkA4SZ9mE7gbc9+kYY4qd5
 OwvLJR4jwuNnSljxdzZ7VgM9UGaQiyYMrgBWSL2RsX+SruKzWOkfhwa5dN7UAAaNtAmJ
 f57EpjUo4FWQP6uXxGsFWv5j1/wP1KPUzw5HNi96M1f/e9Dmh1uJzVKAI8nSq2m5LzXE
 6RcT7NySMccYoONjSbuZbG4a9hje0O+os4OxAZQ6qVzEZ6RCWMEkSJcpxnbIBnxOtRty
 2CmDPMkzOIGHFYRGnj88HDFSy8wTxTqWwcWZtIKFp1wzW9xnhpJchI2hqpZgu7ik8OWj
 Jj8w==
X-Gm-Message-State: AOJu0YzWVZ0vF/NYCkuxSKgrwMSJnElS0FnwqQnJnhFy7ZaxuimgOqm5
 fj+yiE3hkh0H4Q3g72FRYEJVSqlauF/s8A22z0AmfpBhKY3qcpZxgiLBbyMlJAWPY3MDs1UooCZ
 1CmThXwEZ20h72uUOJth+QWxwSPLwbNbezqyIuyGqfLDkEG0SU5KO78y8a/5efT7A2p8RhtTKbR
 o6gQ01LA==
X-Gm-Gg: AR+sD13aOO5Ks1OTsQEXBsWekk7VWUDjjMsvK7hFZSTqI5bIMkD1lAlsmOwMd4F7j0s
 keF14pYKrn9dBa9RrgUCWXNp4sIy/eDcwX1d2OucZXAswVODH8JtynbdG8zSnFgKNLv58YMI1+h
 kldAYmBFusEaB0aKUFzYd0T/TiSDetqn0w4BDgrLCO4vTLBQKQt6bhURHOQhAchBVJ7CwnwD/ct
 NTBl4hN1AbZFRPpNnJ/QmfnT0sU5GwA6djCntxza5N0/Ii5awxHaKwa+azWSkZC6rJMn5QmUmyF
 uBD5kWSLDR1mTqDyM9YVHZX3LPPicm1PzVF7gBUWB3DRt9aX+5vxohF+IcaXSiXOA0QoL1Mz0D4
 ymKVjjh5nsOfLsG4OPT72SkHUxyHZEY8nRYN4CBNDTdJNpbKcSnHyRnuQm7DY4ddGXTDCiq1ees
 K7XqJt3TLZS5RfxuBrYxASxzOPSysCOIQEvuBCL4fafULQv+zbteaeYmpDkPstcqk/c7qxUSSdN
 gn5Eb32MowwQzsWzlLfBEm3h4Z156Dlunj/F6qs8fFJagifXaY7BHFCxZS5LGvtw+U+IsI5qTeq
 xdvLyzL0HDi2QzweITGGTAWOVlk52i2ZBraYUmCVTE6d8hjc/uY=
X-Received: by 2002:a05:600d:8483:b0:498:1371:6612 with SMTP id
 5b1f17b1804b1-4994e7a70aemr145465865e9.6.1786015485960; 
 Thu, 06 Aug 2026 04:24:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49952dda992sm31218495e9.2.2026.08.06.04.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:24:45 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 11:24:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
X-Gerrit-Change-Number: 1836
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1836?usp=email>
X-Gerrit-Commit: 84e155246221f2d6e4cdb939634c5a80c6398d3a
In-Reply-To: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
References: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkljYzA3MjFmZDRhOTEwMTEwNTA3ZDA2YjRlOTQxZTllNmRiYjExZTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ddadee8191ce1fa4e03d91d4b108816dbfe2e752-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrwDY-00024h-6z
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: reject a pushed
 epoch data format tag with a non-AEAD cipher
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6320705849110693900=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6320705849110693900==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WyQaDrxs9fg="; charset=UTF-8

--WyQaDrxs9fg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex=2E

Hello plaisthos, 

I'd like=
 you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1836?usp=3Demail

to look at the new patch set (#3)=2E

The =
change is no longer submittable: checks~ChecksSubmitRule is unsatisfied now=
=2E


Change subject: ssl: reject a pushed epoch data format tag with a non=
-AEAD cipher
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


ssl: reject a pushed epoch data format tag with a non-AEAD cipher

The ep=
och data key format is defined for AEAD ciphers only=2E Both places
that en=
able it locally verify this - multi=2Ec when picking the cipher to
push and=
 ssl_ncp=2Ec for p2p NCP - but the pulling side imports the
"aead-epoch" pr=
otocol flag without validating it against the cipher that
was actually nego=
tiated=2E

A peer pushing "protocol-flags aead-epoch" together with a non-A=
EAD
cipher therefore makes us reach the M_FATAL in init_key_contexts() and
=
terminate the process=2E This can be triggered whenever a non-AEAD cipher
i=
s part of our own --data-ciphers, which is not unusual in
configurations ke=
pt compatible with old peers, e=2Eg=2E

  data-ciphers AES-256-GCM:AES-256-=
CBC

Validate the combination in do_deferred_options(), next to the existin=
g
data v2 check, so that the mismatch is reported as an OPTIONS ERROR and
t=
he connection is restarted=2E Turn the now unreachable M_FATAL in
init_key_=
contexts() into a session error as well, so that no future code
path can pr=
omote this to a process exit=2E

Change-Id: Icc0721fd4a910110507d06b4e941e9=
e6dbb11e9f
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M=
 src/openvpn/init=2Ec
M src/openvpn/ssl=2Ec
2 files changed, 18 insertions(=
+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/36/1836/3

diff --git a/src/openvpn/init=2Ec b/src/openvpn/ini=
t=2Ec
index 0236886=2E=2E84de986 100644
--- a/src/openvpn/init=2Ec
+++ b/sr=
c/openvpn/init=2Ec
@@ -2711,6 +2711,18 @@
         return false;
     }
 
+=
    /* The epoch data format is defined for AEAD ciphers only=2E A peer may=
 push
+     * the tag along with a non-AEAD cipher, so this has to be check=
ed here
+     * rather than trusted */
+    if (epoch_data && !cipher_kt_mo=
de_aead(c->options=2Eciphername))
+    {
+        msg(D_PUSH_ERRORS,
+     =
       "OPTIONS ERROR: Epoch key data format tag requires an AEAD "
+      =
      "cipher, but '%s' was negotiated=2E",
+            c->options=2Eciphe=
rname);
+        return false;
+    }
+
 
     if (found & OPT_P_PUSH_MTU)
=
     {
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 4a4feaf=
=2E=2E23c8ec8 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@=
 -1428,10 +1428,14 @@
     {
         if (!cipher_kt_mode_aead(key_type->ci=
pher))
         {
-            msg(M_FATAL,
-                "AEAD cipher (=
currently %s) "
+            /* The pulled options are validated in do_defe=
rred_options(), so
+             * reaching this point means a code path es=
caped that check=2E Fail
+             * the session instead of the whole p=
rocess */
+            msg(D_TLS_ERRORS,
+                "TLS Error: AEAD =
cipher (currently %s) "
                 "required for epoch data format=2E=
",
                 cipher_kt_name(key_type->cipher));
+            return =
KEY_GEN_FAILED;
         }
         init_epoch_keys(ks, multi, key_type, se=
rver, key2);
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1836?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
Gerrit-Change-Number: 1836
Ger=
rit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex <antonio@mandelb=
it=2Ecom>

--WyQaDrxs9fg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex=2E </p>
<p>ordex <strong>uploaded patch set #3<=
/strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1836?usp=3Demail">View Change</a></p><p>The change is no longer =
submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>ssl: reject a pushed epoch data format tag with a non-AEAD cipher<br><br>T=
he epoch data key format is defined for AEAD ciphers only=2E Both places<br=
>that enable it locally verify this - multi=2Ec when picking the cipher to<=
br>push and ssl_ncp=2Ec for p2p NCP - but the pulling side imports the<br>&=
quot;aead-epoch&quot; protocol flag without validating it against the ciphe=
r that<br>was actually negotiated=2E<br><br>A peer pushing &quot;protocol-f=
lags aead-epoch&quot; together with a non-AEAD<br>cipher therefore makes us=
 reach the M_FATAL in init_key_contexts() and<br>terminate the process=2E T=
his can be triggered whenever a non-AEAD cipher<br>is part of our own --dat=
a-ciphers, which is not unusual in<br>configurations kept compatible with o=
ld peers, e=2Eg=2E<br><br>  data-ciphers AES-256-GCM:AES-256-CBC<br><br>Val=
idate the combination in do_deferred_options(), next to the existing<br>dat=
a v2 check, so that the mismatch is reported as an OPTIONS ERROR and<br>the=
 connection is restarted=2E Turn the now unreachable M_FATAL in<br>init_key=
_contexts() into a session error as well, so that no future code<br>path ca=
n promote this to a process exit=2E<br><br>Change-Id: Icc0721fd4a910110507d=
06b4e941e9e6dbb11e9f<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandel=
bit=2Ecom&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/ssl=2Ec<br>=
2 files changed, 18 insertions(+), 2 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/36/183=
6/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span>=
<br><span>index 0236886=2E=2E84de986 100644</span><br><span>--- a/src/openv=
pn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -=
2711,6 +2711,18 @@</span><br><span>         return false;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* The epoch data format is defined for AEAD ciphers only=2E A peer=
 may push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the=
 tag along with a non-AEAD cipher, so this has to be checked here</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * rather than trusted */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (epoch_data =
&amp;&amp; !cipher_kt_mode_aead(c-&gt;options=2Eciphername))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;OPTIONS ERROR: Epoch ke=
y data format tag requires an AEAD &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;cipher, but &#39;%s&#39; was negoti=
ated=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       c-&gt;options=2Eciphername);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> </span><br><span>     if (found &amp; OPT_P_PUSH_MTU)=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/=
src/openvpn/ssl=2Ec</span><br><span>index 4a4feaf=2E=2E23c8ec8 100644</span=
><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=
=2Ec</span><br><span>@@ -1428,10 +1428,14 @@</span><br><span>     {</span><=
br><span>         if (!cipher_kt_mode_aead(key_type-&gt;cipher))</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              &quot;AEAD cipher (currently %s) &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* The pulled options are val=
idated in do_deferred_options(), so</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             * reaching this point means a code path escape=
d that check=2E Fail</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+             * the session instead of the whole process */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;TLS=
 Error: AEAD cipher (currently %s) &quot;</span><br><span>                 =
&quot;required for epoch data format=2E&quot;,</span><br><span>            =
     cipher_kt_name(key_type-&gt;cipher));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            return KEY_GEN_FAILED;</span><br><span> =
        }</span><br><span>         init_epoch_keys(ks, multi, key_type, ser=
ver, key2);</span><br><span>     }</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3D=
email">change 1836</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1836?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1836 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner=
: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--WyQaDrxs9fg=--


--===============6320705849110693900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6320705849110693900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6320705849110693900==--

