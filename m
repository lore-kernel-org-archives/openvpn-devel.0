Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D316BC982DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n9vCW39MLTas30lNwlpNIoK4wSIaG+Jf/uwHYlqRf34=; b=DX+3k8qxDGJBiSc2J67oKQeY3C
	3IdVXzJINpRbyvdQweX215Y6bBr0aBA8hja4idea69HtARE8t1krwhZ0KLeARWJ3wtXev+1yfpS8i
	9FY80JSe1qDFWmkSsre4KaGbeOORXHeQfyHNP/QxDP+ed6JRo+rD6NpJpAnJVYiE5qHM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8ZQZ-0007yV-SH;
	Mon, 21 Sep 2026 08:31:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8ZQT-0007xs-EC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 08:31:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zDV/TTa3zFt5phB58ee978O5YprIyOZ8lKrZB/OrnKo=; b=ZeAOODupKX+AvpDchnXaNaPwOn
 1IXOjV3ctwErmX9Ay8JGKdIAoXIVD14L9FXSnBBnDZnqPuiLPfUV/yNRGguAmYo66ePJyI74eU9CU
 7RYDKAP+2Cr8YRMusgjGN8+vKz2b2LtpN0ms+clKupc3zGMipRcwYTJy///F1SokuHM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zDV/TTa3zFt5phB58ee978O5YprIyOZ8lKrZB/OrnKo=; b=T
 EG0s/srZ4lX0R7R/rUp9Eho5x+SHgWR8blPXWKl+Ef0u2aKUQ2on4l5lLteJLyNMbsalt3EaSZjqt
 sTsYeOROwK72JW4bD0rq24LfzbCHZGN1k/LWTdaEp+b82aUGdzJ11LcxiWBHNAg5Mc5qyzku8kOoW
 9Ethvbb3ZkxtWcW4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8ZQP-0000Oo-NA for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 08:30:59 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso6852255e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 01:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789979451; x=1790584251; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zDV/TTa3zFt5phB58ee978O5YprIyOZ8lKrZB/OrnKo=;
 b=SD3JCkB5MQNXOthd8bcM5Bg8x4Jwe7v7Kc906igEfdf8CezjXTuThOFpexCmnzZGCv
 LlNo2M6MiTTGhOj0IOfx9L9jKpcmqWmGJDNVQNp/5nwduijgffe4c5BgNaD5vWWAjjPp
 MNTngNwXmSL3rpjYRkPCjH46jyEqH+cAmUkfP3S079aZaIJBnlMx8i3Bof+ZMaUrq27V
 JyAXOAh4no7exvhjsW0GEphIR55IqMJfRwhI1CIFsRDtCcpVG4VYcqz1mBygLKIvR94F
 iQ2RmtAfRY+rP5Yf8MGPyUGlqzHyWGe2MDNNu8q9Z3Yq/eEMhxm3y7w8HYxSboy71VSP
 7CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789979451; x=1790584251;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zDV/TTa3zFt5phB58ee978O5YprIyOZ8lKrZB/OrnKo=;
 b=1altBGZJeWvTGVKyBPXhMtqO7pMUNCAOqvnRbpAxMQA0vdX472xr+OT1sx4k92uV9E
 xQkDKHlP5oOkpU5yjV0ok4y0ZZqk4bmcjoLQpQ335Oah0ythp41nBrQEa2UkG7rRs1gE
 jwzoGX6Sdk7+Qv6+gg599Q/lNsMJEHErS10yp92hcBul56h2DENwvZVTi/THaKSrybHQ
 fkP5BvGg2VVj/GvudxrPWJi0FV7jlaZVLxeQeB7NwNsU7ySb9b/AWCT9GkkpcZnRL/gW
 +kO5+iEanvZYmNl6vytbjLdjqqbmMlTiAVzCPcxJfnLKIPPVlOO9kAu81DzBrM3Cyx/w
 S/Ag==
X-Forwarded-Encrypted: i=1;
 AKwUvBybxwgyrknK/M3D1qkZnqwZxM5SR9uXlgoec7Z/CniYKMoCIu/mpWaJhboCtZYHl+tsHs+yubT/G1a7wjcI@lists.sourceforge.net
X-Gm-Message-State: AFuF++mkjnbzgVfb8Sos1BN268VaNzhlv1Nl90aEJ2SPN7XqcGymPlno
 09cQsjZKNGSkWxQbtaIxeVvV1o/TJ7lRVyfnBEvAHPQEIZ3FK+Z1vfBs887ED+qdpqs0eTmzW6E
 YsCaAmzfvB2CL7OWUlUxdV+CIiuIoe80pNBSVQTxIPNCcCB5AtuJ3A9103QpmYz7fnqjmC7TDjI
 rcEPnYfg==
X-Gm-Gg: AYBFou32W3njo6a9MJ81pBqZ5lVYPi23vXJrU0XPv/8mWMPswcWehp+QRchGKYxR0/9
 EZQVtb72jaS3h/S7pb/zoRLZCYftw5yCvcp6y61DPUjBAqTBYMKtJk+ee164Oo8hNLys/GY8rKE
 Xeg5YGT/UiYWsVC2PpbYVtwFIAFdHv5jB++plOIJi2dXXvVWVXF1SY+utNfQZGGVnd1gaTGz+Gt
 vrO4b16X8tq3Ke0EOhdxX1PfjEC4naquyPWI2cPjXoe9N/BoRNJmzkO1JTUxSsEukbwRFosQ3Td
 IHJqQvPR0yutBkVVJxoxVstYSG/Ktx9IhLFL/eC6rA1+XmkPAK8NsPYTaLYFU+l0Re47N4Nu2uq
 sNWwGF71EhXjSzsusPUWjlt7ggyheb1dM9zhv9K+6q3NcNOVLD9DctPuiDRxkLhK8PQTz8T3Pj6
 VvtcGhs2ZS08RX+mXsX5zP33HiaWwNHmLzCpPR+t9eKicy4oBZvTStIGt44471DaXI3bOv2fN9o
 ROZeZSOUjlppGZ9nXpN0ZXFxj2SpqezyjMJzscctTFR/rfaGwQdvsh8yHvjLpc2QXCselzENlbg
 bwqU0HGn9dEXyoBKu643/ejqFo190CENveHJXvfnGZy6k3q4ZaWgA/NyE80l
X-Received: by 2002:a05:600c:4714:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-49fc4f72886mr150884765e9.2.1789979450794; 
 Mon, 21 Sep 2026 01:30:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcc1160a1sm170507065e9.4.2026.09.21.01.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 01:30:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 08:30:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
X-Gerrit-Change-Number: 1836
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1836?usp=email>
X-Gerrit-Commit: 5e1d17e611de02f194bf959df9f5795580f570be
In-Reply-To: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
References: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkljYzA3MjFmZDRhOTEwMTEwNTA3ZDA2YjRlOTQxZTllNmRiYjExZTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1c5892e85be98c9d582b8b4868ee57c0a39fd710-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8ZQP-0000Oo-NA
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1131101051444996881=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1131101051444996881==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e+siqzK0lA8="; charset=UTF-8

--e+siqzK0lA8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1836?usp=3Demail )

Change subject: ssl: reject a pushed epoch data for=
mat tag with a non-AEAD cipher
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

ssl: reject a pushed epoch data format tag with a non-A=
EAD cipher

The epoch data key format is defined for AEAD ciphers only=2E B=
oth places
that enable it locally verify this - multi=2Ec when picking the =
cipher to
push and ssl_ncp=2Ec for p2p NCP - but the pulling side imports t=
he
"aead-epoch" protocol flag without validating it against the cipher that=

was actually negotiated=2E

A peer pushing "protocol-flags aead-epoch" tog=
ether with a non-AEAD
cipher therefore makes us reach the M_FATAL in init_k=
ey_contexts() and
terminate the process=2E This can be triggered whenever a=
 non-AEAD cipher
is part of our own --data-ciphers, which is not unusual in=

configurations kept compatible with old peers, e=2Eg=2E

  data-ciphers AE=
S-256-GCM:AES-256-CBC

Validate the combination in do_deferred_options(), n=
ext to the existing
data v2 check, so that the mismatch is reported as an O=
PTIONS ERROR and
the connection is restarted=2E Turn the now unreachable M_=
FATAL in
init_key_contexts() into a session error as well, so that no futur=
e code
path can promote this to a process exit=2E

Change-Id: Icc0721fd4a91=
0110507d06b4e941e9e6dbb11e9f
Signed-off-by: Antonio Quartulli <antonio@mand=
elbit=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836
Message-Id: <202609191918=
10=2E14656-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg39356=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M src/openvp=
n/ssl=2Ec
2 files changed, 18 insertions(+), 2 deletions(-)




diff --git =
a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 453ee7e=2E=2E8a449e8 10=
0644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2698,6 +2698=
,18 @@
         return false;
     }
 
+    /* The epoch data format is def=
ined for AEAD ciphers only=2E A peer may push
+     * the tag along with a =
non-AEAD cipher, so this has to be checked here
+     * rather than trusted=
 */
+    if (epoch_data && !cipher_kt_mode_aead(c->options=2Eciphername))
+=
    {
+        msg(D_PUSH_ERRORS,
+            "OPTIONS ERROR: Epoch key da=
ta format tag requires an AEAD "
+            "cipher, but '%s' was negotia=
ted=2E",
+            c->options=2Eciphername);
+        return false;
+   =
 }
+
 
     if (found & OPT_P_PUSH_MTU)
     {
diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index 2a115d4=2E=2Eb6595ab 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1456,10 +1456,14 @@
     {
      =
   if (!cipher_kt_mode_aead(key_type->cipher))
         {
-            msg(=
M_FATAL,
-                "AEAD cipher (currently %s) "
+            /* The=
 pulled options are validated in do_deferred_options(), so
+             * =
reaching this point means a code path escaped that check=2E Fail
+         =
    * the session instead of the whole process */
+            msg(D_TLS_ER=
RORS,
+                "TLS Error: AEAD cipher (currently %s) "
           =
      "required for epoch data format=2E",
                 cipher_kt_name(=
key_type->cipher));
+            return KEY_GEN_FAILED;
         }
        =
 init_epoch_keys(ks, multi, key_type, server, key2);
     }

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb1=
1e9f
Gerrit-Change-Number: 1836
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <ant=
onio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--e+siqzK0lA8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1836?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">ssl: reject a pushed epoch data format tag=
 with a non-AEAD cipher<br><br>The epoch data key format is defined for AEA=
D ciphers only=2E Both places<br>that enable it locally verify this - multi=
=2Ec when picking the cipher to<br>push and ssl_ncp=2Ec for p2p NCP - but t=
he pulling side imports the<br>&quot;aead-epoch&quot; protocol flag without=
 validating it against the cipher that<br>was actually negotiated=2E<br><br=
>A peer pushing &quot;protocol-flags aead-epoch&quot; together with a non-A=
EAD<br>cipher therefore makes us reach the M_FATAL in init_key_contexts() a=
nd<br>terminate the process=2E This can be triggered whenever a non-AEAD ci=
pher<br>is part of our own --data-ciphers, which is not unusual in<br>confi=
gurations kept compatible with old peers, e=2Eg=2E<br><br>  data-ciphers AE=
S-256-GCM:AES-256-CBC<br><br>Validate the combination in do_deferred_option=
s(), next to the existing<br>data v2 check, so that the mismatch is reporte=
d as an OPTIONS ERROR and<br>the connection is restarted=2E Turn the now un=
reachable M_FATAL in<br>init_key_contexts() into a session error as well, s=
o that no future code<br>path can promote this to a process exit=2E<br><br>=
Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f<br>Signed-off-by: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1836<br>Message-Id: &lt;20260919191810=2E14656-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg39356=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvp=
n/ssl=2Ec<br>2 files changed, 18 insertions(+), 2 deletions(-)<br><br></pre=
>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><sp=
an>index 453ee7e=2E=2E8a449e8 100644</span><br><span>--- a/src/openvpn/init=
=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2698,6 =
+2698,18 @@</span><br><span>         return false;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* The epoch data format is defined for AEAD ciphers only=2E A peer may pu=
sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the tag al=
ong with a non-AEAD cipher, so this has to be checked here</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * rather than trusted */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (epoch_data &amp;&a=
mp; !cipher_kt_mode_aead(c-&gt;options=2Eciphername))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_PUSH_ERRORS,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot;OPTIONS ERROR: Epoch key data =
format tag requires an AEAD &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;cipher, but &#39;%s&#39; was negotiated=2E=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
c-&gt;options=2Eciphername);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> </span><br><span>     if (found &amp; OPT_P_PUSH_MTU)</span>=
<br><span>     {</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/ope=
nvpn/ssl=2Ec</span><br><span>index 2a115d4=2E=2Eb6595ab 100644</span><br><s=
pan>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</sp=
an><br><span>@@ -1456,10 +1456,14 @@</span><br><span>     {</span><br><span=
>         if (!cipher_kt_mode_aead(key_type-&gt;cipher))</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      &quot;AEAD cipher (currently %s) &quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* The pulled options are validated i=
n do_deferred_options(), so</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+             * reaching this point means a code path escaped that c=
heck=2E Fail</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      * the session instead of the whole process */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                &quot;TLS Error=
: AEAD cipher (currently %s) &quot;</span><br><span>                 &quot;=
required for epoch data format=2E&quot;,</span><br><span>                 c=
ipher_kt_name(key_type-&gt;cipher));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return KEY_GEN_FAILED;</span><br><span>       =
  }</span><br><span>         init_epoch_keys(ks, multi, key_type, server, k=
ey2);</span><br><span>     }</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail"=
>change 1836</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1836 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--e+siqzK0lA8=--


--===============1131101051444996881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1131101051444996881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1131101051444996881==--

