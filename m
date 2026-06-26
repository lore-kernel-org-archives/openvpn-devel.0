Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E36FC43327
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TsiIwU4XxNSNlfQLcdJ+/MRxXOCznpGED1mco+QpUcg=; b=ZOSaTaDVAlRli/Cb5pVOmDuWlN
	GnzDoe3wduh22S8mdUle4Yp7zcVXShTOO+KCRY0RM9nn0A9MLezENWE4cZf3FGqoLQe9+jzrgtH1O
	Qk/EMJ0sxmRvYespZVwlm+cafw2/EpEksBG3ZRnNG12P6rXzRZ3nVXy8eE85yZijZnos=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wd9D3-0002Fg-Rr;
	Fri, 26 Jun 2026 16:15:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wd9D2-0002FZ-SS
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 16:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sN2bUUx14dCgC8MI9JD104BvUPGlTgpV6k+j4P8Sbxs=; b=IL3bzc35eP7pIKJbsjljXQtN9z
 2wX/0Ih63VgP1JXsiMV6N0I6jlXKHic0yhaKieH4hIk6BfeVadJNFT35xlteeisbY4LI7PKIpb5zm
 BX63yzparImxMg+s5ffIixV40pn9Pn2q+W9vieIk2ZePc4PnZpodfeNG3UqaQLtaLWX4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sN2bUUx14dCgC8MI9JD104BvUPGlTgpV6k+j4P8Sbxs=; b=L
 ZvQfr85OTh2TenrQJ1FAh6aH6Zjd2Fb89Dz3aEI/8djUy/VmSGolYqNg/yV/ltWMvETTD5m7/g0Vh
 jgcoXTS2zywjVRkNPU+VW9e3AQxhGdILm3q2ivixCResV6rct8qwgBlkT5G5zWHsqSKDXnD0ttL6u
 QVdgukBrTcACKZpA=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wd9Cu-0003j1-Lj for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 16:15:14 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-46e335379cbso728146f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 26 Jun 2026 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782490497; x=1783095297; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sN2bUUx14dCgC8MI9JD104BvUPGlTgpV6k+j4P8Sbxs=;
 b=BKmdvcYb9LwKjMktdyQGloNmG/15+rr3R+j5feDwdQ+FkhrHgRgIzfyZV4s8mM4Eev
 sO9zazUXNXijzEcCyzNt6NLts3XDbzmvlZHOSw8GbLfiD7TEyVvVYd+VQthkRQKdSBRZ
 MPRbzrQlwy+y1nAFr59yva9ZCuH5X5U0is7M+Earpsm5I1trxrMdYMywpnilVf+axZTf
 yqkI3tOauzHFeEJRflxOCT4WEo439725K8cUryjOz07AvdKbiMyZa9Qd41GZ5iAZ6oy1
 GlDcEkRTPy3c1uUMJuo6/wNJhOQMwvXWJFXnQLmXHlBKZSZBfO1nuq4qF2QuAhQL6SeZ
 y5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782490497; x=1783095297;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sN2bUUx14dCgC8MI9JD104BvUPGlTgpV6k+j4P8Sbxs=;
 b=F+LbFHORSQ0DsP+7Ib01ykVdtCZxWpAr59iLSijbO1nERKv7xsBSlUG8YudMtOghur
 MeJq3YU60WjsGeiBUooT58FK+bolSK2fVmigdBnyj8jBhn8KneleS3xTp3FdoP2ypPeA
 i9PQ3scF0OySoKSV85MlyM6UkcOg4H+8ZzNfQyS6btq4bkAHLDUhyjQMbUSJcyD9MeOG
 pmgd++D1PASF0OnT8hFRm66MOheCzyzAjbMm1Sm4c4xnOqLX/3C5t7mkfPyTbH5btLZ1
 TPBulqVEoE3EriApvwWDDtsUW02qwQL/qabUuu2vMpPZ7bephTOocgqqdUoPLPXy0mQM
 M/6A==
X-Gm-Message-State: AOJu0YyIalEoplXLrLuN0QFl8gVIY72zQ2jSAHMppQJU034O4KQF4wQD
 W/2lLTfrVeksWxJ5EHSZS4sFd4yxJ+AH8+z7zSq6VHkMwjqSgfnxs4+3NyuSZWQAvh9Yolo42RH
 +wQCWZ82cSpOTpDj8RQI0/lqOzTbEYCigQUTtca0a31rl7i/1b360hH8JgjZ6pnPTsezR
X-Gm-Gg: AfdE7cncD1FmZU/hNIpwPY14zLiQy9Wu4gTxYyslqkVNPKiT5mIiakrjOAu/RpQadbI
 eqBlhkt7xioC9qO2BrDzHPriylHBiRkMQ+nsk1fRVRBhqZfMX9EMwtK12SAcX3hUZEumMRQbeBQ
 dI8bg0obAdqlOmzp/wcwqawGTGeGZ+PWXPQdYgqKcevvdSnP6xGwzc1JlrBjDimh4Byvg+zogZd
 r39JcWzJ9r91c9mAhJS9SEAxZqO7t0MPsAhhjQC23dgxyT/rV9Ym8I0HwVa+9LADwUYjAjlRN+W
 dzRQQVcwg6VcfnjYdMj2P7kFLW2n6BIE1dovRE2DO/Vp56gN48VR9vNKKDzhpftarcZy0W3H7dn
 qPvsPYg5lcmQ+uX5K/vpxnVYyCBGZU1Uv39MYY84hzbKHFXRRV/2M8ic1SPgIs+Oa1+VmczZ7h+
 iJPZ+EIg32/ps/9LVsSSZfSpIQjNgUarXVQikQAUMerSIpxykiyngwbvI8aw4u9i37+BKW+YNu1
 SWm2ZcQTALC5noPHNI+lG0aPlRG7VJ/A96wl73Upii5VoCdDyH3wxphyJYZXfpj4XCfc+w0WfEi
 P9A=
X-Received: by 2002:a05:6000:2485:b0:460:e0f:8d19 with SMTP id
 ffacd0b85a97d-46dbfe8cd80mr12565343f8f.9.1782490497398; 
 Fri, 26 Jun 2026 09:14:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46e6167c05fsm11889069f8f.25.2026.06.26.09.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 09:14:57 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 26 Jun 2026 16:14:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
X-Gerrit-Change-Number: 1732
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1732?usp=email>
X-Gerrit-Commit: 712f3d61488a47e80577112489e9e9f98a32aac6
In-Reply-To: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
References: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNDg2Mjk1MDAwLklmZWZiM2FkMjA0YzBjMTZjYjQ5NTJkZDZlODY2MWZkYzkxMzZiMTI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0833ce2f7faa3092455947fb2334220599c66aed-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wd9Cu-0003j1-Lj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make get_random
 return int64 instead of long
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4027798440940347705=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4027798440940347705==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZRX7qZnps+w="; charset=UTF-8

--ZRX7qZnps+w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
cron2


Change subject: Make get_random return int64 instead of long
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make get_random ret=
urn int64 instead of long

This avoids having get_ranomd being different on=
 32bit/Windows vs
64 bit Unix platform=2E Also adjust platform_create_temp_=
file to
create the same files on all platforms=2E

Change-Id: Ifefb3ad204c0=
c16cb4952dd6e8661fdc9136b125
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1732
Message-Id: <20260626152951=2E29207-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg37322=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2E=
h
M src/openvpn/platform=2Ec
3 files changed, 13 insertions(+), 7 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32=
/1732/3

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index=
 7954e8a=2E=2E3d79fe5 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn=
/crypto=2Ec
@@ -1731,11 +1731,12 @@
     ASSERT(rand_bytes(output, len));
 =
}
 
-/* an analogue to the random() function, but use prng_bytes */
-long i=
nt
+/* an analogue to the random() function, but use prng_bytes and
+ * als=
o int64_t instead of long to avoid LLP64 vs LP64 */
+int64_t
 get_random(vo=
id)
 {
-    long int l;
+    int64_t l;
     prng_bytes((unsigned char *)&l=
, sizeof(l));
     if (l < 0)
     {
diff --git a/src/openvpn/crypto=2Eh b/=
src/openvpn/crypto=2Eh
index fbca2a0=2E=2Eee5b50f 100644
--- a/src/openvpn/=
crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -603,8 +603,13 @@
  */
 void prn=
g_bytes(uint8_t *output, int len);
 
-/* an analogue to the random() functi=
on, but use prng_bytes */
-long int get_random(void);
+/**
+ * an analogue =
to the random() function, but use prng_bytes and
+ * also int64_t instead o=
f long to avoid LLP64 vs LP64
+ *
+ * @return Returns a random positive 63 =
bit integer
+ */
+int64_t get_random(void);
 
 /** Print a cipher list entr=
y */
 void print_cipher(const char *cipher);
diff --git a/src/openvpn/platf=
orm=2Ec b/src/openvpn/platform=2Ec
index 9fa9363=2E=2E85b6408 100644
--- a/=
src/openvpn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
@@ -543,7 +543,7 @@=

     const char *retfname =3D NULL;
     unsigned int attempts =3D 0;
    =
 char fname[256] =3D { 0 };
-    const char *fname_fmt =3D PACKAGE "_%=2E*s=
_%08lx%08lx=2Etmp";
+    const char *fname_fmt =3D PACKAGE "_%=2E*s_%08" PR=
Ix64 "%08" PRIx64 "=2Etmp";
     const int max_prefix_len =3D sizeof(fname)=
 - (sizeof(PACKAGE) + 7 + (2 * 8));
 
     while (attempts < 6)
@@ -551,7 +=
551,7 @@
         ++attempts;
 
         if (!checked_snprintf(fname, sizeo=
f(fname), fname_fmt, max_prefix_len, prefix,
-                             =
 (unsigned long)get_random(), (unsigned long)get_random()))
+              =
                get_random(), get_random()))
         {
             msg(M_=
WARN, "ERROR: temporary filename too long");
             return NULL;

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifefb3ad204c0c16cb495=
2dd6e8661fdc9136b125
Gerrit-Change-Number: 1732
Gerrit-PatchSet: 3
Gerrit-O=
wner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@g=
reenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>

--ZRX7qZnps+w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Make get_random return int6=
4 instead of long<br><br>This avoids having get_ranomd being different on 3=
2bit/Windows vs<br>64 bit Unix platform=2E Also adjust platform_create_temp=
_file to<br>create the same files on all platforms=2E<br><br>Change-Id: Ife=
fb3ad204c0c16cb4952dd6e8661fdc9136b125<br>Signed-off-by: Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732<br>Mess=
age-Id: &lt;20260626152951=2E29207-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
7322=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/ope=
nvpn/platform=2Ec<br>3 files changed, 13 insertions(+), 7 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/32/1732/3</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/op=
envpn/crypto=2Ec</span><br><span>index 7954e8a=2E=2E3d79fe5 100644</span><b=
r><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/cryp=
to=2Ec</span><br><span>@@ -1731,11 +1731,12 @@</span><br><span>     ASSERT(=
rand_bytes(output, len));</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/* an analogue to the random() fun=
ction, but use prng_bytes */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-long int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a=
n analogue to the random() function, but use prng_bytes and</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * also int64_t instead of long to =
avoid LLP64 vs LP64 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int64_t</span><br><span> get_random(void)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    long int l;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int64_t l;</span><br><span>     p=
rng_bytes((unsigned char *)&amp;l, sizeof(l));</span><br><span>     if (l &=
lt; 0)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/cryp=
to=2Eh b/src/openvpn/crypto=2Eh</span><br><span>index fbca2a0=2E=2Eee5b50f =
100644</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/s=
rc/openvpn/crypto=2Eh</span><br><span>@@ -603,8 +603,13 @@</span><br><span>=
  */</span><br><span> void prng_bytes(uint8_t *output, int len);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* an analogue=
 to the random() function, but use prng_bytes */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-long int get_random(void);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * an analogue to the random() function, but use prng_byt=
es and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * also int64=
_t instead of long to avoid LLP64 vs LP64</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return Returns a random positive 63 bit integer</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int64_t get_random(void);</span><br><span> </span><br>=
<span> /** Print a cipher list entry */</span><br><span> void print_cipher(=
const char *cipher);</span><br><span>diff --git a/src/openvpn/platform=2Ec =
b/src/openvpn/platform=2Ec</span><br><span>index 9fa9363=2E=2E85b6408 10064=
4</span><br><span>--- a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/=
openvpn/platform=2Ec</span><br><span>@@ -543,7 +543,7 @@</span><br><span>  =
   const char *retfname =3D NULL;</span><br><span>     unsigned int attempt=
s =3D 0;</span><br><span>     char fname[256] =3D { 0 };</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const char *fname_fmt =3D PACKAGE &q=
uot;_%=2E*s_%08lx%08lx=2Etmp&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *fname_fmt =3D PACKAGE &quot;_%=2E*s_%08&quo=
t; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Etmp&quot;;</span><br><span>     c=
onst int max_prefix_len =3D sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 * 8))=
;</span><br><span> </span><br><span>     while (attempts &lt; 6)</span><br>=
<span>@@ -551,7 +551,7 @@</span><br><span>         ++attempts;</span><br><s=
pan> </span><br><span>         if (!checked_snprintf(fname, sizeof(fname), =
fname_fmt, max_prefix_len, prefix,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                              (unsigned long)get_random(), (un=
signed long)get_random()))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                              get_random(), get_random()))</span><br=
><span>         {</span><br><span>             msg(M_WARN, &quot;ERROR: tem=
porary filename too long&quot;);</span><br><span>             return NULL;<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail">change 1732</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifefb3ad204c0c16cb=
4952dd6e8661fdc9136b125 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1732 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bod=
y></html>
--ZRX7qZnps+w=--


--===============4027798440940347705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4027798440940347705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4027798440940347705==--

