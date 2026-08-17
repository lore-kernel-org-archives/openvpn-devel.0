Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5786C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P9FT2x8/fqHmIcHso1PwA1ygijVvEUk1D0nbPTRB4Es=; b=iPpaNLOczwmzFDKt15EZVSIx0Q
	c1tZHzhzMI37hrbbuOTIbKCKl3dmZOHEYGnnSJcHPeXcYiuSWIn2bCfLyPe4PMr5JL6aCAUPD8JIR
	qzAfNFiIRQ3COl+q6/woFQOIz7/6nQgjIcVPV32YTnyt2/PYMRnic1nZ19Ii3uUUzRwg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvxzj-0007Vm-Na;
	Mon, 17 Aug 2026 14:07:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvxzi-0007Vc-8p
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eHVhyUJ4D4ocyglrOtyUZn6m2oQqwEXxe4bPWoET5uM=; b=nMBvid32wQphlTH5WZqIybD+hX
 sSGFKIomEV/hOx+osvpmFCpw9RCUndUSUrBGRAMmwCaQkGWML7JR6NHDThYga9ZX/nRNSm3z0Q759
 UnYvMp3GSW7SY5eJHlGIjoS5OU2OQMTruEv909tNUR1oSbhT9mBt9sqajBuNH3F1PxLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eHVhyUJ4D4ocyglrOtyUZn6m2oQqwEXxe4bPWoET5uM=; b=h
 xHr3ZRgvyHMl4IXiUFRriDL4OeO9wegooC6CYpAo21UDO7U1fWYk0uyYHmdWQjEl578pqcs9EM4Q2
 2tTgCCV0beBtwIASx6kELtFEc2BesyJcJRhGzdK327AQYDVmC6su0h2qm0kOXh5SVESL73LDGhLsu
 kRvn49yLwm2vG5fQ=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvxzh-0007ej-Ed for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:07:15 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso1581516f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786975627; x=1787580427; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eHVhyUJ4D4ocyglrOtyUZn6m2oQqwEXxe4bPWoET5uM=;
 b=WpvkFWQIAZIiRmHVpxD6zQ52OxMbCI//ivcf5UkSXWS2jSeG6VuG2QvHg+1Ena8b+5
 3/MYqSobuY188NPK3yE+5H/VBQ0GEgUusa+IPxn5n9kvbu2Z5eHgjg6t3PEGKU239Ppq
 EyGmuwHVFmxKQC9q6uxgzVtOJdlK5WqVJB/UmE5ybypsMnnFg2Zqir6y/CpnfN1kKKb6
 QJImJWKiqpivhqlOAKk9QdBtbmjoxWmSgVdlqngWp9SiHkT6Nw0/VmoARycoo80DXMF2
 eZxGlvUPqqe6N4hrC+H0WvD7N5cgAlNpYqEstBqQpqe9VuWN++eBZuuQZFRDEnuyDoGa
 gKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786975627; x=1787580427;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eHVhyUJ4D4ocyglrOtyUZn6m2oQqwEXxe4bPWoET5uM=;
 b=XMchrIei1UR8BXgA0/LwwtuZCLdeUS1J+MdjJUJ0WuYfSZh+kpL4wFRizwgFb2hAvg
 n9BtBv5n4GZItFPHzeVRUdygNu/GNYn3hFzIopf1hX52vWBrQrH8gNkVYZVfV1wjmz+k
 b2JB9xdB3+8fGPzt8jjQN0N7rfqJtXI3Xi7P1cN3ol/GPL59X1hp4UbOsUaChVzwj/rb
 xX9BC+UuXHxoO1lw/QO9spJrB5c065Tj6tEpT0gvyiuXY4VjXnk5yaQA/3AGTmtWhMXi
 zOXHqcn24+4eKwyygwrgrbN9IfHzJPyvnXry9u/eBI9hdivs4uQLmhwwn76hlGKV5EF1
 BeWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVBEkFMR/ZiiXkmaLWAwFvv8PEtNt9ylAXG87sJckQjk4+2yB3Ck77lBn0ov7Pj5//DXilyI7w79TAzcZY@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy8ulxjzl2hEeb/NCAaUJZgxXi3dolL/Ce0KB19jnItgD2fILUn
 gTGo3+2K7WYjLJHoqyysLfI1pUY0S+CAnLwxUMmVLYlJ2FzLwtsHLFD9quR+zkmb+MlTOWNZk8N
 pVC9vLGfH9nMxBHjHc1AMBpGmUQVQonntYOJeTrvkvwSstgTZmEKP7hpslyawE6iUOv+PojWU/L
 0zXTS+0Q==
X-Gm-Gg: AR+sD12V5yZKAOoXSlX9mN3P4yPeB4toAYFd4/MX6WM0HWjvv0hmhs8N7SiOAvKIRcw
 xD2KR1mUS/Cigj0NMsCS9FbZ+hJgLCmyWvwAUSKaDdn4kH8dlkxvafUolgXfTQTkAQpD+utFNKk
 JTD8tcJ2mEEMCZK33GzpaKdeX94KbiXS6VuQaHG+waCsJBbY/AVEm8+P5zeYJ6Vv/3e0uz9mryM
 onZQu2r4toIWbUz/zD1D2ReRoLOyDl31/w/GaGzp54Z9F/KPOhjX9n6vhNFHoDwvp16cNkAy/fy
 9VLojjA+hKTC+y9VmtPuj/03GjF26cqOAOzHAVe5350PxEw8gZU5EmyTa4FjjteFj/aKB2Tf9Lq
 6GMH5c0wCJfLi2O2r6441w6CJqG0rTyJbZvelv6DREqqW81ekBwUKmtp1qAh3H3wc7WAeDWDjzc
 OdUU6dWnfa/p49AjBmXkWk/WZZwk9GV0wZN0YkgGPd6e8tjpugXzyCTdWzHyOArwvXvvNL7Kqel
 dBpaowIxcPLi2WR6TupDJJF66ZRKzu18M8b6zOfwsrrpFD+WSa7S+UfXq54Re5iOefcmZIKtrYd
 cVFuPuov7P+9/oxsegDM7Mdcj4Cl1K7ZQlAzyaowtK1qSZ1B7+8=
X-Received: by 2002:a05:6000:40da:b0:47f:8fc9:6eaa with SMTP id
 ffacd0b85a97d-482a8ff66a5mr838251f8f.8.1786975627197; 
 Mon, 17 Aug 2026 07:07:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7c55bsm4088740f8f.20.2026.08.17.07.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:07:06 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 14:07:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: 4951d0100d7a0e149a07ac37daf5cccef2fa8241
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c98bcb65f49abbdbb67308ec2a1e6cf7b1038c7a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvxzh-0007ej-Ed
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
Content-Type: multipart/mixed; boundary="===============4931882558401427641=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4931882558401427641==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J8IJIePwo+8="; charset=UTF-8

--J8IJIePwo+8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has uploaded a =
new patch set (#4)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=
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
anges/44/1844/4

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
index fd96b85=2E=2E01e45fd 100644
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
+     * One epoch lasts 910 Gi=
B with 128 byte packets or 78s at 100 GBit/s=2E
+     * (respectively 1011 =
GiB and 86s with 1280 byte packets)=2E
+     */
+    const uint8_t future_k=
ey_count =3D 4;
 
     int key_direction =3D server ? KEY_DIRECTION_INVERSE=
 : KEY_DIRECTION_NORMAL;
     struct key_direction_state kds;

-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570f=
d098649e197
Gerrit-Change-Number: 1844
Gerrit-PatchSet: 4
Gerrit-Owner: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: razvanc <razvanc@mailbox=2Eorg>

--J8IJIePwo+8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p>plaisthos <strong>uploaded patch s=
et #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
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
refs/changes/44/1844/4</pre><pre style=3D"font-family: monospace,monospace;=
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
><br><span>index fd96b85=2E=2E01e45fd 100644</span><br><span>--- a/src/open=
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
 * One epoch lasts 910 GiB with 128 byte packets or 78s at 100 GBit/s=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (respectively 1=
011 GiB and 86s with 1280 byte packets)=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const uint8_t future_key_count =3D 4;</span><br><span> </spa=
n><br><span>     int key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY=
_DIRECTION_NORMAL;</span><br><span>     struct key_direction_state kds;</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1844?usp=3Demail">change 1844</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id3c6681b29026c292=
0a62a0ea570fd098649e197 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1844 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>

</body></html>
--J8IJIePwo+8=--


--===============4931882558401427641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4931882558401427641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4931882558401427641==--

