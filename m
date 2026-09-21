Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33932C982E1
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qrncK0wuBT9Ty+XYl95jZZOYhtQIvAP37oaE4uFNy5E=; b=ShszveebLW8YUeQsvYfY2dJ0u4
	gsBH3oW85msJAIaUXzKbogr7DnsmpuXL30y5WR9oNJRZtlKZhlIcUzSVzONPzwjt+VnsRZD1+ril/
	GG+5M7Hf/WdOmnyJqv+9sr6Rd6Ju90zE758zYO3eaaGzUaFuJfJIgqSO77q0hQc0BqjI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8ZQW-0000Iw-UV;
	Mon, 21 Sep 2026 08:31:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8ZQP-0000If-PE
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 08:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GQa6KL0Obs32LYZZW4tn/n3p6ILfG2hE8W/jAq5uVhk=; b=MeM+t/blgq2o7iucP0rrjWxsos
 DjuSvU4LYGhq9+QwXW3edwfxIpk/KqTiAx+8F7HWVjqxHxpn+3lWYk1NEBKXfJIwgzrMobArE0HpS
 IcWSncggbMEiB45gazmST2MJB7t+Z5K6vtXLwJgu/FeQrSKIL9ACzvDPK/sQTmG8Mbjk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GQa6KL0Obs32LYZZW4tn/n3p6ILfG2hE8W/jAq5uVhk=; b=O
 DODwyT/9gAlB+dbviuOsTFl9a6YTS8HIgFquB5ZoboaKCcEsUqWI4P6DxScKb06GojzOkZS+NOwrP
 VadFwVunbsUbumdpkgdYU0110Aoy6i43OO9Ph84j/h/dUgdOSNwSpHZF4KmPCe4BQPIroiQc+bJzo
 8DpoAypsGVClLh90=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8ZQN-0000Of-Sc for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 08:30:58 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c3ee4cfso1444093f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789979449; x=1790584249; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GQa6KL0Obs32LYZZW4tn/n3p6ILfG2hE8W/jAq5uVhk=;
 b=PDVKHBGSt/ZZXz1FPAD9aIuBdd0eg5Hu89TVVq1MssW/f46AI6njna7YROJjjtDgau
 0cZsX2j1N7rETUNGAmWEv2Zo/1Iv07r51L9InDnEG5Zw7WXWuSFh5OvQoQd1disDKQy3
 d5kfSyqSlq/bejR44gYGc3J///Nj0Erp1AG0eKDSaLM1ugZcN7iS/fGZdn0G7ogzhqIQ
 wHD8/AHbZqozdR76fzhRxrW/+xYrVcu54CRcumo5QWzFE5LLEaVGcxrbzM/XN69ov0Ps
 SXruao45Jk9cYG9DwEtXF6KwftmJjCgq5RU3H3RguLRYl5H+PtruJ7Eo15AdNNWoMoOe
 XCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789979449; x=1790584249;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GQa6KL0Obs32LYZZW4tn/n3p6ILfG2hE8W/jAq5uVhk=;
 b=ZaHkO4hjhobhz19mr7j0P6XluzgJ7WZimtWO0jRB3d+UxZyO8/nlX/N1guTD2Rg0FR
 0yoGvs8byDyoVlpKqpvwbA/UU7Euesz306bmNWkhwZYSjDRvgj5ORSvd2FHjB281oz3+
 lvtP+6KUe82aaWPq9bW5J6MB271HakksqXXsFwniPb5eNI5oPMy5cA0YhiBvp9j5u70k
 h5SLikALnnH42WwZlOamHaaBkaI93+xy4IETe6EyqGEpRl7La1MqipTOxFA0yq72Cgc/
 3HZ8ho3Qhkyd8qY2/nA3Uw91CypAbfI7uUZc2TWhaou4PwH9oV7btrZUGD7YHuwmUL+m
 gP+A==
X-Gm-Message-State: AFuF++nzN9cRhM0JvCn1jeoD2ZsYUXlg4sgg8SHfwVWSVfQXc3pqxS7/
 GTH5RecjWuPVlncNV0ml6mGwBgtSgi3iaxWrv+ssOWtTECXFlmrkaf1d2D7rqrwFqLVdYQrM00b
 nC542cuxYupnETl6R4AmtUr7LtI5zemuQI5ZEQRrmQPa6kTkrilLSM7NN/zw124BpKo/qTBEAjp
 oiq8AYMw==
X-Gm-Gg: AYBFou3NkhQT32UY/oV1ptIcLNQ6mDq/23DJ58pEkSJQV3nI/nKmkkIR4qXBBjNNW2c
 9UwincWXoWaXGAQGKBSkK4t9GhZpDJIvKHiQD6UHNp5MR0iwi8/BAqR07e3RuNEOT9JE6jqNWTI
 XQxvBdzMsUDhcuqWrvvKe5gFgIwIqQHzZvq+IBeqRvO76eqLXpJA6rNqbT1dVKcZd2ODwXEKKlF
 TKPRizwVjfM5RhWTyXaHOgtPtDd62FOFDcP0C7kV4rCltE8PzZFQnErzMzs8vY1dk5SYWBv9B0i
 iycrn9o8NZNYbp/CCqwq2Ks0uHPk8+PLpkq/vJ4MrolE8oadj57US7Zpd7/SpC+ADLj9DprFVq+
 9+/Ri9ikKE8xYdu5QeRbjjOJZumW+f7lwsNjDU7HiCH295vwR5SD7FqdZwhKO9A4zIeF/Y9haAt
 kxE7t4tUz9qP939PXSOsxdoGg1T3CsR2dIhpyWncNBh903NeD9aRQxZ3mDLI/mSN/X6v1NC0gM/
 7+tzoZGm/fUzXJsmBsGyinufDYri8+3I9b+LioGwhCtn1WA8TfeB4Dui/FxI1U5rxYTJf8XeOK8
 BJcpx3mHFhwmOEspX2f+r/awqMJp7B4d71TwlSVCWy0A9nYFNR2y28qFuj3YF06WX8+JhSya
X-Received: by 2002:a05:600c:1382:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-49fc574f42bmr131393995e9.19.1789979448948; 
 Mon, 21 Sep 2026 01:30:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd0f7e05sm224627765e9.4.2026.09.21.01.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 01:30:48 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 08:30:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
X-Gerrit-Change-Number: 1836
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1836?usp=email>
X-Gerrit-Commit: 5e1d17e611de02f194bf959df9f5795580f570be
In-Reply-To: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
References: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkljYzA3MjFmZDRhOTEwMTEwNTA3ZDA2YjRlOTQxZTllNmRiYjExZTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1c5892e85be98c9d582b8b4868ee57c0a39fd710-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8ZQN-0000Of-Sc
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5437305623092864385=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5437305623092864385==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zspu/xX2IpU="; charset=UTF-8

--Zspu/xX2IpU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by plai=
sthos


Change subject: ssl: reject a pushed epoch data format tag with a n=
on-AEAD cipher
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
Acked=
-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1836
Message-Id: <20260919191810=2E14656-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg39356=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M src/openvpn/ssl=2Ec
2 file=
s changed, 18 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/36/1836/4

diff --git a/src/openvpn/i=
nit=2Ec b/src/openvpn/init=2Ec
index 453ee7e=2E=2E8a449e8 100644
--- a/src/=
openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2698,6 +2698,18 @@
        =
 return false;
     }
 
+    /* The epoch data format is defined for AEAD c=
iphers only=2E A peer may push
+     * the tag along with a non-AEAD cipher=
, so this has to be checked here
+     * rather than trusted */
+    if (ep=
och_data && !cipher_kt_mode_aead(c->options=2Eciphername))
+    {
+        =
msg(D_PUSH_ERRORS,
+            "OPTIONS ERROR: Epoch key data format tag r=
equires an AEAD "
+            "cipher, but '%s' was negotiated=2E",
+     =
       c->options=2Eciphername);
+        return false;
+    }
+
 
     if =
(found & OPT_P_PUSH_MTU)
     {
diff --git a/src/openvpn/ssl=2Ec b/src/open=
vpn/ssl=2Ec
index 2a115d4=2E=2Eb6595ab 100644
--- a/src/openvpn/ssl=2Ec
+++=
 b/src/openvpn/ssl=2Ec
@@ -1456,10 +1456,14 @@
     {
         if (!cipher_=
kt_mode_aead(key_type->cipher))
         {
-            msg(M_FATAL,
-     =
           "AEAD cipher (currently %s) "
+            /* The pulled options=
 are validated in do_deferred_options(), so
+             * reaching this p=
oint means a code path escaped that check=2E Fail
+             * the sessi=
on instead of the whole process */
+            msg(D_TLS_ERRORS,
+        =
        "TLS Error: AEAD cipher (currently %s) "
                 "required=
 for epoch data format=2E",
                 cipher_kt_name(key_type->ciphe=
r));
+            return KEY_GEN_FAILED;
         }
         init_epoch_key=
s(ks, multi, key_type, server, key2);
     }

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
Gerri=
t-Change-Number: 1836
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@mande=
lbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Zspu/xX2IpU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">ssl: reject a pushed epoch da=
ta format tag with a non-AEAD cipher<br><br>The epoch data key format is de=
fined for AEAD ciphers only=2E Both places<br>that enable it locally verify=
 this - multi=2Ec when picking the cipher to<br>push and ssl_ncp=2Ec for p2=
p NCP - but the pulling side imports the<br>&quot;aead-epoch&quot; protocol=
 flag without validating it against the cipher that<br>was actually negotia=
ted=2E<br><br>A peer pushing &quot;protocol-flags aead-epoch&quot; together=
 with a non-AEAD<br>cipher therefore makes us reach the M_FATAL in init_key=
_contexts() and<br>terminate the process=2E This can be triggered whenever =
a non-AEAD cipher<br>is part of our own --data-ciphers, which is not unusua=
l in<br>configurations kept compatible with old peers, e=2Eg=2E<br><br>  da=
ta-ciphers AES-256-GCM:AES-256-CBC<br><br>Validate the combination in do_de=
ferred_options(), next to the existing<br>data v2 check, so that the mismat=
ch is reported as an OPTIONS ERROR and<br>the connection is restarted=2E Tu=
rn the now unreachable M_FATAL in<br>init_key_contexts() into a session err=
or as well, so that no future code<br>path can promote this to a process ex=
it=2E<br><br>Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f<br>Signed=
-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1836<br>Message-Id: &lt;20260919191810=2E14656=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg39356=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<b=
r>M src/openvpn/ssl=2Ec<br>2 files changed, 18 insertions(+), 2 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/36/1836/4</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/sr=
c/openvpn/init=2Ec</span><br><span>index 453ee7e=2E=2E8a449e8 100644</span>=
<br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -2698,6 +2698,18 @@</span><br><span>         return=
 false;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* The epoch data format is defined for AE=
AD ciphers only=2E A peer may push</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * the tag along with a non-AEAD cipher, so this has to =
be checked here</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * rather than trusted */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (epoch_data &amp;&amp; !cipher_kt_mode_aead(c-&gt;options=2Eci=
phername))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRO=
RS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;OPTIONS ERROR: Epoch key data format tag requires an AEAD &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;cipher, bu=
t &#39;%s&#39; was negotiated=2E&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            c-&gt;options=2Eciphername);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span>     if (fo=
und &amp; OPT_P_PUSH_MTU)</span><br><span>     {</span><br><span>diff --git=
 a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 2a115d4=
=2E=2Eb6595ab 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1456,10 +1456,14 @@</span=
><br><span>     {</span><br><span>         if (!cipher_kt_mode_aead(key_typ=
e-&gt;cipher))</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_FATAL,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                &quot;AEAD cipher (currently %s) &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* T=
he pulled options are validated in do_deferred_options(), so</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             * reaching this point=
 means a code path escaped that check=2E Fail</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             * the session instead of the whole p=
rocess */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot;TLS Error: AEAD cipher (currently %s) &quot;</span><b=
r><span>                 &quot;required for epoch data format=2E&quot;,</sp=
an><br><span>                 cipher_kt_name(key_type-&gt;cipher));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return KEY_GEN_=
FAILED;</span><br><span>         }</span><br><span>         init_epoch_keys=
(ks, multi, key_type, server, key2);</span><br><span>     }</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1836?usp=3Demail">change 1836</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9=
e6dbb11e9f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1836 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"=
display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Zspu/xX2IpU=--


--===============5437305623092864385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5437305623092864385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5437305623092864385==--

