Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AB0C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kWbPYg9E40WkZwScoZ8yl2SWibvYwhl1Bxo+JECixRo=; b=An6zgHvLSrzVGLO7IOotaChO3K
	GZlRiLtHrrNIRlbMTWrAYdYGzmUPEo7ZF+NYDxcD3ryQI4wqR2MJsvWlHEf/iP6jMI0gVyzk3q3bn
	nzXWE9u57TwQvI3Nha+qiViDPc5nts6uR10S6E8b6yiFl5kSBuCgeKr+TTMYHnTLln+4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwu2-0003ZY-H6;
	Mon, 17 Aug 2026 12:57:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwu1-0003ZS-KP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:57:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wezbBld/b5iql9AdkCnRe/0/Tdli8R10SghwnZiVvZk=; b=WZlgFea5yXHQlj7AA1XrosQH64
 1CMZRl8IpcLcX+p0x9gsuCwLyiWtZnJUdemmuQwU3VoLS6KQGC3xzmjOI6CYjMP4kehr1I05oCbIo
 f8LyM7QbKLvirRGHaWY/LlD5adzNgol2HVL8zGkWKPyfFxYCSXI0pVphIShzTw0NTAfY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wezbBld/b5iql9AdkCnRe/0/Tdli8R10SghwnZiVvZk=; b=M
 S+uvV/NFsBo4SapdddJxmehusaXcWGMh8uuCGT+1esDDzFVVOyqoC/NYoZlh03SIlTisDLEq8mHnp
 Rd6rjAXiJo4qYkF4pIyiUc0IVAwYsONuvDF9l57A24IIBbq3PW1fEPgQQbYSAs4EvP8GuPoIXJOat
 SmDGDXJyEXhf4Qb4=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwu1-0004CE-8N for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:57:19 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47fde295992so2393724f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786971431; x=1787576231; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wezbBld/b5iql9AdkCnRe/0/Tdli8R10SghwnZiVvZk=;
 b=M/Y/DgZc5iTWjMjLEn+S6PT2seSvtwi3B9NLpJomOrfO8TQvNhS2fDI6xXIdOPv81B
 s1rafSqebOWS9VGcrcuXzyXL5ilJKOCXvdJpr7YuJ10cRAL3hleOyPC2RZvRP5KbgBL2
 XJsDbw193kbCaNBTunE2MyDZ93yg6/aELBxDyW038RAoxwpaFI/73Vra8aMNQ+4Iht15
 6t+YV2/Ltd2mJibasahC4vQk+Q0ii8jpfKZbUaGhdzPW1yJqpyxVdrY2FdprNluhP+qz
 cdpm1WN49AWK+mwOvxtdK/xE/8iNROFgBw6hUyMLPEwXV21NaxMuWchv1xuPZBFUZL4H
 +R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786971431; x=1787576231;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wezbBld/b5iql9AdkCnRe/0/Tdli8R10SghwnZiVvZk=;
 b=nvJHKhIAhHM+i5Rq0XPq8TpOD1WqvAW2ikGi+hLg/69z/dGcZWaFsyO53hxs7gSXkZ
 sGWpFiMGMy9U8k65kuQwkinyow+0QXjxcQvvKw7KttgH5uEQUX3CckAJCCPc/CE1vE9R
 4kiuhF+VPQCwSXzxev9i8HkeK0yBNBk0pn/kC28ryGLUdGMwY4/IHjuZkNV94rmAAVX2
 x6tbGbTyqZaFhB1w29gZoBdv+S1wzzP2ixXdJwOQ08ZiFVj4N0iVcWmw8b7m3Qp9TEzn
 I2WN84sXw2zVrW4mipDM56IPyxR6RTRSGvegOffmR94AslsKpB8HfwNk2jsSWuU+yAf4
 K0NQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roi2FpjoVxun50LmBJmkFA3yhnopox4qTkpcqzFVoqEVTwOQTapsK70+QmE1toxLcLaE/EnopTDi6ZxyUWs@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwZuAaF7IZliYC/8PnbZknR6fljdN1TTJ2isAmrs4I+nx63HT39
 In4ZLatm7IC1y7ZylBw3Usqct7L1+Krxlrhym2KhdoKUKLbukTuFHA+hkkUa//eW4jlBy3rJ7Rn
 6Ec5ITdKB3+yzWh+mbp+tLPqkcLFAJIcqVNPj/KJ5RFK6SJKnQP39iLk4Xklu0IdIfrYC
X-Gm-Gg: AR+sD13dkAJMvnAsYXiApgNZvKyTCBDihNY+lqRag0rEv3VMev4sFoWXJYgfIJ2Ltud
 YOBSPETWn2ZNPjtClBod5s+nB6JF8/wZbWy1CnxsVPHn4JAkc4U28U0z9DsfE30L2WVG3B1Mzd2
 NiYfy7OvIwH4EaTZ3hnV8XPzF0/vf2nMlhDg1cgHta0rZVy0DPehNslQEsJvGkggqe1u8odW54u
 OGOEWY/JOXsHX4Pudo/iU0SoPXJUPhE7FJ3IwOsbhJ10CH/WP4WQnOiM5Jbp12AvEZJV0Ud4dCL
 V0iT7Rbo3RIfB4a42KH9OuV7JA5wi2CLKgDnBVNrdFBxbQB1HfVeJMZXCQcFTf4uX4HDagGcjII
 5DYYam9GvGWGpycU60LC78eodQBtYE7HB0mX69zVQdhmgzPj1ImCTCLgEda+5DI/UBGXQj24lSx
 fjctUQ2BgQ6fEJshR79HRyVsBN7eEm36CEElgIX/AfsgNIFA9EQ1UqAEbZxju6jwrO7Z9QZPboj
 MAKXkYQ+qSuJKbXq9etg83FLpDeROFH2UzDyN80vUaljYlFAa9n0ow54pY6GjMabvLJpicaTuar
 w82kzwzb9JARVttvCvjARfNHrc9lgDJegHcoovxb9b8hzrM8JPY=
X-Received: by 2002:a05:6000:1a8c:b0:481:562d:6fb1 with SMTP id
 ffacd0b85a97d-4816075be23mr37342838f8f.6.1786971430960; 
 Mon, 17 Aug 2026 05:57:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a31396sm3846308f8f.2.2026.08.17.05.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:57:10 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:57:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: 79f87e8fa83b20485262f5a50497d621febc5e40
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21aaf6b0eafe7c668f0ba8d1561b14bada7b4253-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwu1-0004CE-8N
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
Content-Type: multipart/mixed; boundary="===============4039507145835585566=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4039507145835585566==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1JJwPzm1s94="; charset=UTF-8

--1JJwPzm1s94=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

plaisthos has uploaded =
a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?us=
p=3Demail )


Change subject: Reduce number of future epoch keys from 16 to=
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
M src/openvpn/ss=
l=2Ec
1 file changed, 7 insertions(+), 3 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/1844/2

diff --git a/src=
/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index fd96b85=2E=2E81346d1 100644
--=
- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1343,10 +1343,14 @@
 =
init_epoch_keys(struct key_state *ks, struct tls_multi *multi, const struct=
 key_type *key_type,
                 bool server, struct key2 *key2)
 {
- =
   /* For now we hardcode this to be 16 for the software based data channel=

+    /* For now we hardcode this to be 4 for the software based data chann=
el
      * DCO based implementations/HW implementation might adjust this nu=
mber
-     * based on their expected speed */
-    const uint8_t future_key=
_count =3D 16;
+     * based on their expected speed=2E
+     *
+     * One=
 epoch lasts 910 GB with 128 byte packets or 78s at 100 GBit/s=2E
+     * (=
respectively 1011 GB and 86s with 1280 byte packets)=2E
+     */
+    const=
 uint8_t future_key_count =3D 4;
 
     int key_direction =3D server ? KEY_=
DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
     struct key_direction_state k=
ds;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id3c6681b290=
26c2920a62a0ea570fd098649e197
Gerrit-Change-Number: 1844
Gerrit-PatchSet: 2=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--1JJwPzm1s94=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Reduc=
e number of future epoch keys from 16 to 4<br><br>The calculation in the RF=
C was wrong and probably influenced<br>by an older worst case assumption=2E=
 With the fixed calculation<br>four future epoch keys should be more than e=
nough even for<br>100 Gbit/s=2E So change the number to 4 in OpenVPN as wel=
l=2E<br><br>This also reduces the spam about the epoch keys a bit=2E<br><br=
>Thanks to Ralf Lici for noticing the wrong calculation=2E<br><br>Change-Id=
: Id3c6681b29026c2920a62a0ea570fd098649e197<br>Signed-off-by: Arne Schwabe =
&lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file change=
d, 7 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/1844/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index fd9=
6b85=2E=2E81346d1 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><b=
r><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1343,10 +1343,14 @@</=
span><br><span> init_epoch_keys(struct key_state *ks, struct tls_multi *mul=
ti, const struct key_type *key_type,</span><br><span>                 bool =
server, struct key2 *key2)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* For now we hardcode this to be 16 for the so=
ftware based data channel</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* For now we hardcode this to be 4 for the software based data c=
hannel</span><br><span>      * DCO based implementations/HW implementation =
might adjust this number</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * based on their expected speed */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const uint8_t future_key_count =3D 16;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * based on their expected =
speed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * One epoch lasts 9=
10 GB with 128 byte packets or 78s at 100 GBit/s=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * (respectively 1011 GB and 86s with=
 1280 byte packets)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 uint8_t future_key_count =3D 4;</span><br><span> </span><br><span>     int=
 key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;</=
span><br><span>     struct key_direction_state kds;</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1844?usp=3Demail">change 1844</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1844?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1844 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--1JJwPzm1s94=--


--===============4039507145835585566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4039507145835585566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4039507145835585566==--

