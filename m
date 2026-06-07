Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6021ECD8C8C
	for <openvpn-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbpGZXe4ACETE6JL4WRdjn7dAxK9PZBq1nCr0+xVPrM=; b=Jqwj74IrvvcnvvM8KCZvuCVL7U
	AMY4oDlIy3tWTrdvDHbIX0YXR5VLzTJ/99+SP/gitn5gfCiICXATiqkvVdFskZ51GirkNp7OS7Ybf
	sRUny5oRf+CqQdIpFL/PUEr+KYedamUumHrY87TNmOpkpewrU0RCKFAT8U19xf6RdRys=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWGsK-0003Zo-MB;
	Sun, 07 Jun 2026 17:01:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWGsJ-0003Zh-B0
 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:01:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lOLuwlUGTksbjKgcVnTY+8hP87yBIr7m3l66eUxAcXA=; b=lgmfzud1/6cs/Te5rNmz33Vkig
 48VbuAOVqsvibHlKFSL0H7Nb0uKQKLq3MK8HI2i13abRUUsUG2MQJg6mHkf3T9oKmV3QKNXlGO0Lh
 erk9gmXuvCPGDVshF5UIrhXX3bgZdgUhoZIJDthe7SdOhH3kZBKQArNrPVjbPpiaL/jU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lOLuwlUGTksbjKgcVnTY+8hP87yBIr7m3l66eUxAcXA=; b=V
 3wNO2cd2zGvqF4vZ7l8kNOjgbLwFmw+FuV6iKOwA0JK0rPzyi4lpS7aY3w4du6JhrC6cbFxv8VvU2
 jS+vJ7+V7eBHuAFnVlZBPRyJhxoxYoF+BiTehGp8D6KMziza2slO8coNoaoIIu9VSSejD32tz6sLv
 fEu08eeIn4/Hc1EI=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWGsF-0000fj-CL for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:01:24 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490af320e2aso39533705e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 07 Jun 2026 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780851672; x=1781456472; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lOLuwlUGTksbjKgcVnTY+8hP87yBIr7m3l66eUxAcXA=;
 b=CdfUQ44ZDdiOFXQGLr2W7DTxq/sWMmgo9NrHPhEahrtcyJqJUjloSkOY4Zs9+Djogw
 1k6jGczJxuYKKZbMJNAK0XZbKhQNyWSo8+vbLwPMWmo/kpB4e2w+vMXDp2r+TVbK/ff7
 KqsRmRaT4/RcgtVvKJ9CUtI+yOL89YUsWmJ69lzauU8Dv/4bcdBTvvN3lIRWmIYGri2l
 nB/+nWDeYH1Uo/jEHwpeLwqweOJhiSa747kWv+cudnXWHUzmsDtP8ygyzwOGbsS80ZpJ
 ppq8b2jJ4cduhhPa8Ku/4cDfQAnb2Scu5lNgj1xPpQZ2FLNcz/EbYKTTBY8hg2oZq8Mu
 wmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780851672; x=1781456472;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lOLuwlUGTksbjKgcVnTY+8hP87yBIr7m3l66eUxAcXA=;
 b=AibP2jOuU9UGa0igeNuvVGPIIn7Fd8dEeNIOo3o/kl/1Cz506KUkd87/HBttOAlmia
 tOR/jpfQbcrKzmLep4/Uyht1u87KVIzozrvX3IeI7UDGQqrVkgTEkhv3/7mFnyaAYdIO
 /VVynUn51EwGba64YBPs1CPJ68PYYrHGXXnCR+lf+ZhXRYTPDrMplSr47KatH65DUfZh
 qW5oiqo0NKaSYZC78QaAGRg3ekmfzn9Qn3FWVgRh+hpX5HlXfLTOMk0RbcZWbOCOC5T4
 pRFVYnwAxggP/LKZe7CxDRPb4qRbKrh6Xl5cc+yjTO3F6ZkFiZzWNx6o55NsskcTLuwL
 V0RA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZzuxAv3r8i72SAXMLT42oY5fcnW5WL4ecZ5wV+Uftd/xX9nMvhH6DDzxgCUVI8Wm+ariMls/WP3tKbIeM@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzC3858Zd+CyuPb0ozQkxd+pQttPHHd24S+pkhUeBmRCnH49iml
 8LycfI3dXPM4/W4kku/uv2PIehtkKEnI9vnAqzHvCT1aVkhzb96yWmUGYClhkjD6thrq4TlyIG3
 Dv3okbqEKKDSWygidRb1r/MvgCfU6Qj7fIs9Xmcqask3mikcgD4SePKgNFLobkzW97rKM
X-Gm-Gg: Acq92OFsyYfPCa6MYgFh4wUPz0/INeeBzM7+gSGmj6v/4mGRqUxGPTIqUpxWa2F8wrT
 HDoykYwhpIIFcefepqI5icLY2BjbZM4h1O6NZn5rpMGvQ59Wbx1C2a2RW+SCJw+spK2YwHsHsXx
 pidF392JnrGIcuAlL8I1kdwQGgnOV5qWt+SZ07opx3xonx7jwGAjBBEkUkksgYJNaVAc4TJ+Be4
 J2IxLlgRYl5EpMNrTWnhRaYcz0FDFmrPMTN8nBaP5G92JvDB5mVHX3us8sb5wkaVjxGd6KnRlXb
 H9vsPIm/g1I2SxLukfhU8SKT6u1/K5LqLJBu+N1x+9Tewjj74k0PwoneE39dRtmGFcMvEqUE0aQ
 sXhxjvMkhx0NCwLDadpcg/VANG0GnhJMz1W17wv6hoax1E8xpubFjyVLQwtSEumezdnzB+CvhCH
 /AD5EChCZb3SLa+A/4UTDvLF8ZDppZufKuoWxAXm6Jtxb89lJ4DRFEUmIyhoKe+X7Lv5M3UUZSz
 1ofskn//bWRqVdGgPmLjXoZFHp/q8O58gLEAzrpGP98nZXj3p/k/yWeVyjo3sIxS7BYa6ET6p8x
 6xYWvNPD/LscIPXX1JdRycPL
X-Received: by 2002:a05:600c:5246:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-490c25ff39amr203845695e9.27.1780851672109; 
 Sun, 07 Jun 2026 10:01:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fcf5bsm386119125e9.9.2026.06.07.10.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 10:01:11 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 7 Jun 2026 17:01:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
X-Gerrit-Change-Number: 1707
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1707?usp=email>
X-Gerrit-Commit: aca8546df6b04afee275b78f92f5564f5590f76a
In-Reply-To: <gerrit.1780494160000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
References: <gerrit.1780494160000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwNDk0MTYwMDAwLklmZjhiMzM2MTI2YTVkZmY5ODcxMjEzNjY0YjFlODU4NWZiNzBkMjFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <de09642160b68f53de39d88962ae1400d25ce147-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWGsF-0000fj-CL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Ensure pushed
 tun-mtu is no lower than TUN_MTU_MIN
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============7471750547703777789=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7471750547703777789==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DwuebHmw3sA="; charset=UTF-8

--DwuebHmw3sA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1707?usp=3Demail )

Change subject: Ensure pushed tun-mtu is no lower t=
han TUN_MTU_MIN
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Ensure pushed tun-mtu is no lower than TUN_MTU_MIN

The normal path en=
sure that the minimum tun mtu is set to at least
TUN_MTU_MIN=2E However, th=
e pushed options path does not have this
restriction=2E

Check that the tun=
-mtu is within the limits of min/max mtu
in options=2Ec=2E This ensure that=
 the check is also correctly done
on the pushed variant=2E

Also add an ext=
ra check to keep the allowed payload for icmp6 packets
to be at least 64 by=
tes in the the block-ipv6 code path
(ipv6_send_icmp_unreachable) as extra l=
ayer of defence=2E

Pushing a low mtu like 1 and also block-ipv6 could trig=
ger an
assertion in the ipv6_send_icmp_unreachable code path=2E

Reported-B=
y: Haiyang Huang <huanghaiyang83@gmail=2Ecom>
Change-Id: Iff8b336126a5dff98=
71213664b1e8585fb70d21e
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Acked-by: MaxF <max@max-fillinger=2Enet>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1707
Message-Id: <20260605180931=2E3547-1-gert=
@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg37069=2Ehtml
Signed-off-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
---
M src/openvpn/forward=2Ec
M src/openvpn/mtu=2Eh
M sr=
c/openvpn/options=2Ec
3 files changed, 20 insertions(+), 11 deletions(-)


=


diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 27cf=
d36=2E=2Ed24f534 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/for=
ward=2Ec
@@ -1598,7 +1598,9 @@
      * frame should be <=3D 1280 and have a=
s much as possible of the original
      * packet
      */
-    const int m=
ax_payload_size =3D min_int(MAX_ICMPV6LEN, c->c2=2Eframe=2Etun_mtu - icmphe=
ader_len);
+    int max_payload_size =3D min_int(MAX_ICMPV6LEN, c->c2=2Efra=
me=2Etun_mtu - icmpheader_len);
+    /* Ensure that minimum payload size is=
 at least 64 bytes as extra safety layer */
+    max_payload_size =3D max_i=
nt(max_payload_size, 64);
     const int payload_len =3D min_int(max_payloa=
d_size, BLEN(&inputipbuf));
     const uint16_t icmp_len =3D (uint16_t)(siz=
eof(struct openvpn_icmp6hdr) + payload_len);
 
diff --git a/src/openvpn/mtu=
=2Eh b/src/openvpn/mtu=2Eh
index ca8109c=2E=2E8f07e75 100644
--- a/src/open=
vpn/mtu=2Eh
+++ b/src/openvpn/mtu=2Eh
@@ -68,6 +68,11 @@
  */
 #define TUN_=
MTU_DEFAULT 1500
 
+/**
+ * Maximum MTU we accept for MTU related options
+=
 */
+#define TUN_MTU_MAX 65536
+
 /*
  * Minimum maximum MTU
  */
diff --gi=
t a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 0c2866c=2E=2E12=
8d1e5 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@=
 -6409,26 +6409,28 @@
     else if (streq(p[0], "tun-mtu") && p[1] && !p[3]=
)
     {
         VERIFY_PERMISSION(OPT_P_PUSH_MTU | OPT_P_CONNECTION);
-  =
      options->ce=2Etun_mtu =3D positive_atoi(p[1], msglevel);
-        opt=
ions->ce=2Etun_mtu_defined =3D true;
-        if (p[2])
+        if (atoi_c=
onstrained(p[1], &options->ce=2Etun_mtu, "tun-mtu", TUN_MTU_MIN, TUN_MTU_MA=
X, msglevel))
         {
-            options->ce=2Eocc_mtu =3D positive_at=
oi(p[2], msglevel);
-        }
-        else
-        {
-            option=
s->ce=2Eocc_mtu =3D 0;
+            options->ce=2Etun_mtu_defined =3D true;=

+            if (p[2])
+            {
+                atoi_constrained(p[=
2], &options->ce=2Eocc_mtu, "tun-mtu occ-mtu", TUN_MTU_MIN, TUN_MTU_MAX, ms=
glevel);
+            }
+            else
+            {
+                o=
ptions->ce=2Eocc_mtu =3D 0;
+            }
         }
     }
     else if (=
streq(p[0], "tun-mtu-max") && p[1] && !p[2])
     {
         VERIFY_PERMISS=
ION(OPT_P_MTU | OPT_P_CONNECTION);
-        atoi_constrained(p[1], &options=
->ce=2Etun_mtu_max, p[0], TUN_MTU_MAX_MIN, 65536, msglevel);
+        atoi_=
constrained(p[1], &options->ce=2Etun_mtu_max, p[0], TUN_MTU_MAX_MIN, TUN_MT=
U_MAX, msglevel);
     }
     else if (streq(p[0], "tun-mtu-extra") && p[1]=
 && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);=

-        if (atoi_constrained(p[1], &options->ce=2Etun_mtu_extra, p[0], 0,=
 65536, msglevel))
+        if (atoi_constrained(p[1], &options->ce=2Etun_m=
tu_extra, p[0], 0, TUN_MTU_MAX, msglevel))
         {
             options-=
>ce=2Etun_mtu_extra_defined =3D true;
         }

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
Gerrit=
-Change-Number: 1707
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--DwuebHmw3sA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1707?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Ensure pushed tun-mtu is no lower than TUN=
_MTU_MIN<br><br>The normal path ensure that the minimum tun mtu is set to a=
t least<br>TUN_MTU_MIN=2E However, the pushed options path does not have th=
is<br>restriction=2E<br><br>Check that the tun-mtu is within the limits of =
min/max mtu<br>in options=2Ec=2E This ensure that the check is also correct=
ly done<br>on the pushed variant=2E<br><br>Also add an extra check to keep =
the allowed payload for icmp6 packets<br>to be at least 64 bytes in the the=
 block-ipv6 code path<br>(ipv6_send_icmp_unreachable) as extra layer of def=
ence=2E<br><br>Pushing a low mtu like 1 and also block-ipv6 could trigger a=
n<br>assertion in the ipv6_send_icmp_unreachable code path=2E<br><br>Report=
ed-By: Haiyang Huang &lt;huanghaiyang83@gmail=2Ecom&gt;<br>Change-Id: Iff8b=
336126a5dff9871213664b1e8585fb70d21e<br>Signed-off-by: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fillinger=2Enet&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707<br>Messag=
e-Id: &lt;20260605180931=2E3547-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3706=
9=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/mtu=2Eh<br>M src/openvpn/=
options=2Ec<br>3 files changed, 20 insertions(+), 11 deletions(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</spa=
n><br><span>index 27cfd36=2E=2Ed24f534 100644</span><br><span>--- a/src/ope=
nvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><s=
pan>@@ -1598,7 +1598,9 @@</span><br><span>      * frame should be &lt;=3D 1=
280 and have as much as possible of the original</span><br><span>      * pa=
cket</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const int max_payload_size =3D min_int(MAX_ICMPV6LEN, c-&gt;c2=
=2Eframe=2Etun_mtu - icmpheader_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int max_payload_size =3D min_int(MAX_ICMPV6LEN, c-&gt=
;c2=2Eframe=2Etun_mtu - icmpheader_len);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Ensure that minimum payload size is at least 64=
 bytes as extra safety layer */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    max_payload_size =3D max_int(max_payload_size, 64);</span><=
br><span>     const int payload_len =3D min_int(max_payload_size, BLEN(&amp=
;inputipbuf));</span><br><span>     const uint16_t icmp_len =3D (uint16_t)(=
sizeof(struct openvpn_icmp6hdr) + payload_len);</span><br><span> </span><br=
><span>diff --git a/src/openvpn/mtu=2Eh b/src/openvpn/mtu=2Eh</span><br><sp=
an>index ca8109c=2E=2E8f07e75 100644</span><br><span>--- a/src/openvpn/mtu=
=2Eh</span><br><span>+++ b/src/openvpn/mtu=2Eh</span><br><span>@@ -68,6 +68=
,11 @@</span><br><span>  */</span><br><span> #define TUN_MTU_DEFAULT 1500</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Maximum MTU we a=
ccept for MTU related options</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e TUN_MTU_MAX 65536</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /*</span><br><span>  * Minimum maximum MTU</span><br><spa=
n>  */</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/o=
ptions=2Ec</span><br><span>index 0c2866c=2E=2E128d1e5 100644</span><br><spa=
n>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -6409,26 +6409,28 @@</span><br><span>     else if (=
streq(p[0], &quot;tun-mtu&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><b=
r><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_PUSH_MTU | =
OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     options-&gt;ce=2Etun_mtu =3D positive_atoi(p[1], msglevel);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce=2Etun_mtu=
_defined =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (atoi_constrained(p[1], &amp;options-&gt;ce=2Etun_mtu, &quot;tun-mtu&=
quot;, TUN_MTU_MIN, TUN_MTU_MAX, msglevel))</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;ce=
=2Eocc_mtu =3D positive_atoi(p[2], msglevel);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   options-&gt;ce=2Eocc_mtu =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            options-&gt;ce=2Etun_mtu_defined =3D true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (p[2])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                atoi_constrai=
ned(p[2], &amp;options-&gt;ce=2Eocc_mtu, &quot;tun-mtu occ-mtu&quot;, TUN_M=
TU_MIN, TUN_MTU_MAX, msglevel);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             options-&gt;ce=2Eocc_mtu =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><br=
><span>     }</span><br><span>     else if (streq(p[0], &quot;tun-mtu-max&q=
uot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><s=
pan>         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        atoi_constrained(p[1], &amp=
;options-&gt;ce=2Etun_mtu_max, p[0], TUN_MTU_MAX_MIN, 65536, msglevel);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        atoi_constraine=
d(p[1], &amp;options-&gt;ce=2Etun_mtu_max, p[0], TUN_MTU_MAX_MIN, TUN_MTU_M=
AX, msglevel);</span><br><span>     }</span><br><span>     else if (streq(p=
[0], &quot;tun-mtu-extra&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br=
><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_=
CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (atoi_constrained(p[1], &amp;options-&gt;ce=2Etun_mtu_extra, p[0], 0, 655=
36, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (atoi_constrained(p[1], &amp;options-&gt;ce=2Etun_mtu_extra, p[0], 0,=
 TUN_MTU_MAX, msglevel))</span><br><span>         {</span><br><span>       =
      options-&gt;ce=2Etun_mtu_extra_defined =3D true;</span><br><span>    =
     }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707?usp=3Demail">change 1707</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff8b336126a5dff=
9871213664b1e8585fb70d21e </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1707 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt=
;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--DwuebHmw3sA=--


--===============7471750547703777789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7471750547703777789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7471750547703777789==--

