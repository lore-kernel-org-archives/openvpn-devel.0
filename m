Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5EFC5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HIh2zFgw6HF4z1lQdj5M+Kd+G8vDsCRkFiEUylchrFE=; b=CUEoCGdogF4qDfcO+JI91mx5VM
	GBlfM6omxgbSF1nXRguwQTvRyZmEta9qfUcOGI1gyCVgNrN7XOM+pqtxtcbgjGgSgriIdlKUtF/1a
	GVI/FL7EHM5vc4D/4SJPIy1h+UDdL6leCDeOr36R8jTSExiKqyFs6Lsr64lyWHlL59Q0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvxWR-0000B3-VF;
	Mon, 17 Aug 2026 13:37:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvxWQ-0000Af-Mq
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tH2DdAWxafSQCHWKlBUe+I/ZpuHkGPEn2VHXm7q6iRY=; b=gy48oJlF1zvDszkQ08xNP9m2eV
 moUW82s0eymHKYbri+TMPhoelIroc0KgAu7SrOE0pYyK9XKBHQ7XA/AAga8ECIxSwdmsS3EUbboMd
 jimZYHYb+xRXQCJhGV92kxybK2fUJSHI+ZqBnMVkH7a7GK+KPczJqGZOM3wrOrrBVftw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tH2DdAWxafSQCHWKlBUe+I/ZpuHkGPEn2VHXm7q6iRY=; b=i
 hD9Jy9GLWJpPm8JCnvHYKSj2J+ivSbCbrCT3uc5kVzDq0Md3y+3go5j8ApwG0ClTlwk7yGQjOdtqK
 ZvMLRHwIhwm6kJ/uvE9xo+bwTDAyAhVLMGsJXGJfXeFrwX8vsM4wKOo6VdPtqXaKJU4r1817u0ZGx
 n+uZB8i21d1Ub+rk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvxWP-00015Y-E3 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:37:03 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso23525045e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786973815; x=1787578615; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tH2DdAWxafSQCHWKlBUe+I/ZpuHkGPEn2VHXm7q6iRY=;
 b=BzDMAVQHhlnPaut+rHFTMMZhY+7oTGtc6EbeS4whloiacVSFWOqjDk+4uvdpE3g0ms
 26ION8XnFJ6SyfzBoRdALgcZeiZGJqaNNZg20nMdocBuq324pCkrKpxUYRygK+4WfIQL
 NqG/ssRdsuLPfxw27zXKzyuy8l0bTfN7XVmQj8ItKAGQCatYAcr1HnxMdSr84xQG6/e8
 3pO9CYOLB/9r2Ix2BSeLS0qamkKgV/2agUCR7cB87EX281j1DGEyH+2tlpG2feoi2oyI
 i9UbzvY8w0rRvtmsqujkg9DzwuwuEv+Fw0DFztZyeuRP2j1A9fB9D+YzOATIy0qTKyJM
 yjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786973815; x=1787578615;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tH2DdAWxafSQCHWKlBUe+I/ZpuHkGPEn2VHXm7q6iRY=;
 b=kJY6fqNIYWakjvGMHmjtrxrHVgn1UQkn7xCTITCjCca5HFD655zAEqYEEI1zrtDG4o
 RjQPC0RLL/aWKjoSratOLxqfuWa4xXqAqYsmmpOJWXpEnsjbmkJSkqu833bW14i5j21I
 vooGwRdesi0tig1ZyrSwtc5BEhtZnmGvtHw5y/wqDxd2zoxF4wxIpsDv2CpHDdYo1gdz
 slsmlXtuOnc70CNrqbtAENHNn/v3SxICenZSvhx1ByxRi1YBiJLCbcurQjie0EF7YVLN
 vnfllo6nWpzrbh2ixgT5Egxm4gn5/zw5tdtjmsSOo4tZzcWYyYxlcfMLX+6ZLDywPb6q
 NEdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcJqSprZ3ZNo4HRHQsYeYeBhAoPiaK5IfL7glegsYEkAVHbABL9UlECwbHOrx/ypxmb13JmhpJriQ2A3aN@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzFgQ9w7Nx77G9dg8nvg4+urYEcsZSTsrK/A+sPOY/e5HUTf0EN
 T14ir8IUmnYUhAbUPfaARcPqzcE6Z5EfuJlaTvnn9620mtByZllXlKk7kZt0g+0FBSfYMXqc/JS
 OZknfm/Q9NAMbgM2StKgbAPY8+NDW4eL5xqmCwv+00bbYFzebvHVh9MD6JGz4e0nOUaJshLka+2
 moWD0ngw==
X-Gm-Gg: AR+sD13OqctPx9Tvo7m7EYROU9B7OVewhtg4JrHo+1thxCu8gc6sBBWVzqd9H95C+Kk
 oLiO+ZTMR+ZTZnWW4bftlu91PVerCqxAhJlaK5OTYQa1oa2P3R+E7MObB62BqI2tG2B/B7UTF+H
 r+CmKekwZQcRsEo+ZoQoz0ROZuFrYhd1yZBWtv50iwfZpu9p+TdG1ZSQp3v4lyL04OW5YEbJsND
 WQ9/a99aWFjWahKLm+9RFCyhVp2WuBLRYmOSamjae+OOk+G5TJACTZ5I0lpIHUGG2t/hwSM2mW4
 L/t2niD/UNWXXW6M2nGnq4gL5d9kdLVo5oO4GUFMnPknhZF/Gre3HjMv6UFPxdVyH+7jT2JSPtn
 /nVy8ptwiMGd7HkzN4xJUMCKPhsmZ6MyXLD53v1DBQO/XZjQP2qqJojJ2J5whD12K3AL6keg0uB
 fPaDGoYj2LGT3m9sdxHD/6JUqZApchcl2VXBj0G0souJJALECWRs1UZVRVP8jO3GqFRm5ez04fS
 cVHYnq/RSokd4zF31l/XVfB0bDXhIpEPBTR6IwLNyh7FmIMFpWAPc5j51z9XHGnHotiVup6wuEJ
 9p7FeNDP1qAIj44mC6FfTFUucqx+2HbfUaNWPcyEBNtmk2qxbUc=
X-Received: by 2002:a05:600c:4709:b0:499:7a4f:d13d with SMTP id
 5b1f17b1804b1-4999fae4eafmr4142185e9.4.1786973814799; 
 Mon, 17 Aug 2026 06:36:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a315bfsm4334920f8f.1.2026.08.17.06.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:36:54 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 13:36:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: d1aa12f7c12ec03bdcaf0659d5ccbbcb198d7081
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8497dd71b32727a0d23f5ecfd5ab06d76a5e6993-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvxWP-00015Y-E3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Reduce number of
 future epoch keys from 16 to 4
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0778180868808295788=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0778180868808295788==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H09gAl8Su8g="; charset=UTF-8

--H09gAl8Su8g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has uploaded a =
new patch set (#3)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=
=3Demail )


Change subject: Reduce number of future epoch keys from 16 to =
4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Reduce num=
ber of future epoch keys from 16 to 4

The calculation in the RFC was wrong=
 and probably influenced
by an older worst case assumption=2E With the fixe=
d calculation
four future epoch keys should be more than enough even for
10=
0 Gbit/s=2E So change the number to 4 in OpenVPN as well=2E

This also redu=
ces the spam about the epoch keys a bit=2E

Thanks to Ralf Lici for noticin=
g the wrong calculation=2E

Change-Id: Id3c6681b29026c2920a62a0ea570fd09864=
9e197
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/cr=
ypto_epoch=2Ec
M src/openvpn/ssl=2Ec
2 files changed, 11 insertions(+), 6 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/44/1844/3

diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/cr=
ypto_epoch=2Ec
index 54225bf=2E=2E37933a1 100644
--- a/src/openvpn/crypto_e=
poch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -308,9 +308,10 @@
         f=
ree_key_ctx(&co->key_ctx_bi=2Eencrypt);
 
         /* Update the epoch_key =
for send to match the current key being used=2E
-         * This is a bit o=
f extra work but since we are a maximum of 16
-         * keys behind, a ma=
ximum 16 HMAC invocations are a small price to
-         * pay for not keep=
ing all the old epoch keys around in future_keys
+         * This is a bit =
of extra work but since we are a maximum of
+         * epoch_data_keys_fut=
ure_count keys behind (4 by default),
+         * a maximum 4 HMAC invocati=
ons are a small price to pay for not
+         * keeping all the old epoch =
keys around in future_keys
          * array */
         while (co->epoch_k=
ey_send=2Eepoch < new_epoch)
         {
diff --git a/src/openvpn/ssl=2Ec b/=
src/openvpn/ssl=2Ec
index fd96b85=2E=2E81346d1 100644
--- a/src/openvpn/ssl=
=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1343,10 +1343,14 @@
 init_epoch_keys(str=
uct key_state *ks, struct tls_multi *multi, const struct key_type *key_type=
,
                 bool server, struct key2 *key2)
 {
-    /* For now we ha=
rdcode this to be 16 for the software based data channel
+    /* For now we=
 hardcode this to be 4 for the software based data channel
      * DCO base=
d implementations/HW implementation might adjust this number
-     * based =
on their expected speed */
-    const uint8_t future_key_count =3D 16;
+   =
  * based on their expected speed=2E
+     *
+     * One epoch lasts 910 GB=
 with 128 byte packets or 78s at 100 GBit/s=2E
+     * (respectively 1011 G=
B and 86s with 1280 byte packets)=2E
+     */
+    const uint8_t future_key=
_count =3D 4;
 
     int key_direction =3D server ? KEY_DIRECTION_INVERSE :=
 KEY_DIRECTION_NORMAL;
     struct key_direction_state kds;

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd0=
98649e197
Gerrit-Change-Number: 1844
Gerrit-PatchSet: 3
Gerrit-Owner: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit=
-Attention: razvanc <razvanc@mailbox=2Eorg>

--H09gAl8Su8g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p>plaisthos <strong>uploaded patch s=
et #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Reduc=
e number of future epoch keys from 16 to 4<br><br>The calculation in the RF=
C was wrong and probably influenced<br>by an older worst case assumption=2E=
 With the fixed calculation<br>four future epoch keys should be more than e=
nough even for<br>100 Gbit/s=2E So change the number to 4 in OpenVPN as wel=
l=2E<br><br>This also reduces the spam about the epoch keys a bit=2E<br><br=
>Thanks to Ralf Lici for noticing the wrong calculation=2E<br><br>Change-Id=
: Id3c6681b29026c2920a62a0ea570fd098649e197<br>Signed-off-by: Arne Schwabe =
&lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/crypto_epoch=2Ec<br>M sr=
c/openvpn/ssl=2Ec<br>2 files changed, 11 insertions(+), 6 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/44/1844/3</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/=
src/openvpn/crypto_epoch=2Ec</span><br><span>index 54225bf=2E=2E37933a1 100=
644</span><br><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ =
b/src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -308,9 +308,10 @@</span><=
br><span>         free_key_ctx(&amp;co-&gt;key_ctx_bi=2Eencrypt);</span><br=
><span> </span><br><span>         /* Update the epoch_key for send to match=
 the current key being used=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         * This is a bit of extra work but since we are a maximum =
of 16</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * keys =
behind, a maximum 16 HMAC invocations are a small price to</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-         * pay for not keeping all the=
 old epoch keys around in future_keys</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * This is a bit of extra work but since we are a=
 maximum of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * epoch_data_keys_future_count keys behind (4 by default),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * a maximum 4 HMAC invocat=
ions are a small price to pay for not</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * keeping all the old epoch keys around in futur=
e_keys</span><br><span>          * array */</span><br><span>         while =
(co-&gt;epoch_key_send=2Eepoch &lt; new_epoch)</span><br><span>         {</=
span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span=
><br><span>index fd96b85=2E=2E81346d1 100644</span><br><span>--- a/src/open=
vpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1=
343,10 +1343,14 @@</span><br><span> init_epoch_keys(struct key_state *ks, s=
truct tls_multi *multi, const struct key_type *key_type,</span><br><span>  =
               bool server, struct key2 *key2)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* For now we hardcode this=
 to be 16 for the software based data channel</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* For now we hardcode this to be 4 for the s=
oftware based data channel</span><br><span>      * DCO based implementation=
s/HW implementation might adjust this number</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * based on their expected speed */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t future_key_count=
 =3D 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * base=
d on their expected speed=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * One epoch lasts 910 GB with 128 byte packets or 78s at 100 GBit/s=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (respectively 10=
11 GB and 86s with 1280 byte packets)=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const uint8_t future_key_count =3D 4;</span><br><span> </span>=
<br><span>     int key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_D=
IRECTION_NORMAL;</span><br><span>     struct key_direction_state kds;</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1844?usp=3Demail">change 1844</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Id3c6681b29026c2920a62a=
0ea570fd098649e197 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1844 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=

</body></html>
--H09gAl8Su8g=--


--===============0778180868808295788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0778180868808295788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0778180868808295788==--

