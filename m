Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2389DCD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+2W2V+bN9Ml6CM561+YPQhu3DUJ4dn+uF/BBMyaId0=; b=GVeBT9T7VmzmSI/Uu7+zcW1EpI
	jFXHsNF/yOUhKjC96wuHEARRwgMQwk7fKCC3VWt4U3/33JWPPgkxUAhyLwXsBqrjr4lfQNWuXa3MK
	PWEfVy3UylCOuWq4OIsXXSomAYEKeHzwFQ5J64euIaqXb5ATe8HIcC9vCv5P/KjRc0mA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXy3p-000253-6J;
	Fri, 12 Jun 2026 09:20:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXy3n-00023z-7H
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pNwgDyz1LEMltbZ5d9aforUqOmVlIxGwwsEI0np+eu8=; b=m4/IURRk4G02y3QJCGP/jFwT0p
 43uzsNzNXZfVgY/31gtLbHGvaVLYDRGQl+1TS220EofyBeR/OdyOZbEBUgbOBMgZk+8AdtOiw3lFW
 +v5Tm5G/YLw5cxV+3hKdJ1aRHgpM1n28wJSjCAcs8tvzJHmTKn2SjLTsPwlF1Kew677I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pNwgDyz1LEMltbZ5d9aforUqOmVlIxGwwsEI0np+eu8=; b=g
 4znv+oGWFPcBs+Pgsv8xCrFZKAQnj11Rz/5mtxXCNRZHLQUZuGOG0VVJdhcGi36R4gwbySSpY38m0
 CP/4I507mqBSLQsyTgS+CLeUpQelu0Y0xMOhZBujxnQ3M8O77AtVPAlf/G25HNC3ZWDIaWPc3MwzL
 RLzjcyA4zVcYurhY=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXy3N-0003wZ-OV for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:19:55 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso5269535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781255983; x=1781860783; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNwgDyz1LEMltbZ5d9aforUqOmVlIxGwwsEI0np+eu8=;
 b=Nhics7YvSWXsUJIrfwoojSv8/KceDEQ38tZG1fgzt8HxUbMC9e80xXwZ3TCILx5OL7
 jvMD8hE3v1vmczXDT29aKZXR5ldOrQKnemVGSerkZ6wnywTeK0Ipy9vUsh5of9dEmhm2
 fmVR0ab5yMB7AxOCOsO8xhx+XIWJmdDQyoWsCt7smx9HY18rD4kZaGY+EIQaXb2tQ7Ks
 1v3L9j7+sbLRyDwUFku05H6BGEd/Be+PaKNNLxTWcnq7Bxuf0OWdTrZEQ3ggh+XdWPFm
 vigYQVtqMdEGRj798QkZxk/O3xB2jS1mSJmuN44dpFDCNRIWxMzOHIDi9iVCLA5/C1LI
 NeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781255983; x=1781860783;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pNwgDyz1LEMltbZ5d9aforUqOmVlIxGwwsEI0np+eu8=;
 b=IQX62KhCdLYwEqc+jgnpiTdbvtfAIhYG4aJVa3CxO12uaZZJFPCDMv+iFE5Vy9GMXL
 izf1wlgmnZvtjU4l8HFVzE0l8VdzHOV1U0llXsAz2vrpr9n8wtHix5TfqYNEhrhyA5rS
 1mpK6D13pGSs8cFkBdzaocdL6iPkfOh3DV7cIiW/oIlkxrhQ8LtnAofgsCGxsR43Un35
 eSzAhBATGt+xDoj+d1ZfIBTAc+8CucoP89N8JchcQgEdakCR0CpXQeMJxFD0wRphlDG4
 NUSYD117fag9LB7S5oqJT3sVnQfKu6fEAltdSyYX3fuvLPlcLjTRDB9gD+SAfxb2VCEm
 ghdQ==
X-Gm-Message-State: AOJu0YwMDfeYpG/O2tnmV3sJPCZMKzulBHWadPdLBCvx4hEq9hDdERpw
 cbirI5zF4Qy2Kpx1PdkSW7ef1pKsvj+73jw4yQdU96123s8s9dWRA+3c0rS3NS3k5dhY0ifiUnC
 zUWDSGSAKL8qYxyY5raO/WSA39PjSmvLBuyBWAdEk2ckRX67i7VLIB1LKVUsedLy1AGK8
X-Gm-Gg: Acq92OHivb8K9IcCBthsqyRlklsxDjouDYv4h0rk05CGMWUn5zf6EZFx3t6CeiIb6/S
 KjVTlL9wbJXvBfyyheHfG6MUNCwK/Q6b0MJTTLtnO3mUD3hVy1svpE3C4IIP84tIereNg3rEUAk
 7oBhdz/XBlbwwQYuZWosCptLw+WAfcFiEIj281jviW+eZOo0DqgrxrDdUkSU43+fQ/zm9iKc7WG
 YEaewRXSSXiu4quS5s0LhecNtHB0FhK7pe2/yHBYLN7Z/5CA5spbgB+PpN0VDFieACUcL2hWgcw
 RO/I8T2860KdSpiulz7kBABPaMb5fWWeWEiPNUnZ/KK4q63M65fWeBKnqQ01x1A6ZLi9Q5CjZ1H
 iLk6oKhloiOC9K14GOZe4Xa5/TvlbsZiZt1F1tt6ZTy3pZVw2gAMT9yrRJ4ScnLnvp6EDh+S+D7
 nAFdyccOkUlvzlgJE4gBi0wojwTaioQ+/cPdjVZlfI7LclC2DMQSZCf0jGvvImERmvPq6WPYx7A
 PKIcMbauFSIqRWKcN1U8r1HFg/UFlEZioIp6/v8NIkMUsKYoQJsa6M5GHdA/G5Atwl9UZ4VbZAU
 WE/O3KAizBLxTcJuC+LMLIoC
X-Received: by 2002:a05:600d:6452:20b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-490ec4fb540mr16368465e9.16.1781255982458; 
 Fri, 12 Jun 2026 02:19:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea7db9c6sm52005225e9.8.2026.06.12.02.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:19:42 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 09:19:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
X-Gerrit-Change-Number: 1708
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1708?usp=email>
X-Gerrit-Commit: dc023ffebdad65a787f63a6d745537c561db7d76
In-Reply-To: <gerrit.1780919555000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
References: <gerrit.1780919555000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwOTE5NTU1MDAwLklmZjhiMzM2MTI2YTVkZmY5ODcxMjEzNjY0YjFlODU4NWZiNzBkMjFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cbf39223d0df7de30f7451218c373e8bdb4fdba7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXy3N-0003wZ-OV
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Ensure pushed
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1651702319971366777=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1651702319971366777==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OMtxA0//UA0="; charset=UTF-8

--OMtxA0//UA0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1708?usp=3Demail )

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
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708
Message-Id: <20260608121759=2E101=
21-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg37084=2Ehtml
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/forward=2Ec
M src/openvpn/mtu=
=2Eh
M src/openvpn/options=2Ec
3 files changed, 16 insertions(+), 1 deletio=
n(-)




diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
ind=
ex e43ce28=2E=2E2255951 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/open=
vpn/forward=2Ec
@@ -1610,6 +1610,8 @@
      */
     int max_payload_size =
=3D min_int(MAX_ICMPV6LEN,
                                    c->c2=2Efram=
e=2Etun_mtu - icmpheader_len);
+    /* Ensure that minimum payload size is =
at least 64 bytes as extra safety layer */
+    max_payload_size =3D max_in=
t(max_payload_size, 64);
     int payload_len =3D min_int(max_payload_size,=
 BLEN(&inputipbuf));
 
     pip6out=2Epayload_len =3D htons(sizeof(struct o=
penvpn_icmp6hdr) + payload_len);
diff --git a/src/openvpn/mtu=2Eh b/src/ope=
nvpn/mtu=2Eh
index d3df5b2=2E=2E70ec43d 100644
--- a/src/openvpn/mtu=2Eh
++=
+ b/src/openvpn/mtu=2Eh
@@ -69,6 +69,11 @@
  */
 #define TUN_MTU_DEFAULT   =
 1500
 
+/**
+ * Maximum MTU we accept for MTU related options
+ */
+#defin=
e TUN_MTU_MAX 65536
+
 /*
  * MTU Defaults for TAP devices
  */
diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 044aab3=2E=2Eea64=
0da 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -=
6552,7 +6552,15 @@
     else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
 =
    {
         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);
-       =
 options->ce=2Etun_mtu =3D positive_atoi(p[1]);
+        int mtu =3D positi=
ve_atoi(p[1]);
+        if (mtu < TUN_MTU_MIN || mtu > TUN_MTU_MAX)
+      =
  {
+            msg(msglevel, "--mtu parm must be between %d and %d=2E", T=
UN_MTU_MIN,
+                TUN_MTU_MAX);
+            goto err;
+        =
}
+
+        options->ce=2Etun_mtu =3D mtu;
         options->ce=2Etun_mtu_=
defined =3D true;
         if (p[2])
         {

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 release/2=2E6
Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
=
Gerrit-Change-Number: 1708
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--OMtxA0//UA0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1708?usp=3Demail">View Change</a></p><div style=3D"white-spa=
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
e-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708<b=
r>Message-Id: &lt;20260608121759=2E10121-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg37084=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/mtu=2Eh<br>M src=
/openvpn/options=2Ec<br>3 files changed, 16 insertions(+), 1 deletion(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=
=2Ec</span><br><span>index e43ce28=2E=2E2255951 100644</span><br><span>--- =
a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</sp=
an><br><span>@@ -1610,6 +1610,8 @@</span><br><span>      */</span><br><span=
>     int max_payload_size =3D min_int(MAX_ICMPV6LEN,</span><br><span>     =
                               c-&gt;c2=2Eframe=2Etun_mtu - icmpheader_len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ensure that=
 minimum payload size is at least 64 bytes as extra safety layer */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    max_payload_size =3D ma=
x_int(max_payload_size, 64);</span><br><span>     int payload_len =3D min_i=
nt(max_payload_size, BLEN(&amp;inputipbuf));</span><br><span> </span><br><s=
pan>     pip6out=2Epayload_len =3D htons(sizeof(struct openvpn_icmp6hdr) + =
payload_len);</span><br><span>diff --git a/src/openvpn/mtu=2Eh b/src/openvp=
n/mtu=2Eh</span><br><span>index d3df5b2=2E=2E70ec43d 100644</span><br><span=
>--- a/src/openvpn/mtu=2Eh</span><br><span>+++ b/src/openvpn/mtu=2Eh</span>=
<br><span>@@ -69,6 +69,11 @@</span><br><span>  */</span><br><span> #define =
TUN_MTU_DEFAULT    1500</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Maximum MTU we accept for MTU related options</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define TUN_MTU_MAX 65536</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * MTU Defau=
lts for TAP devices</span><br><span>  */</span><br><span>diff --git a/src/o=
penvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 044aab3=
=2E=2Eea640da 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><b=
r><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6552,7 +6552,15 @=
@</span><br><span>     else if (streq(p[0], &quot;tun-mtu&quot;) &amp;&amp;=
 p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>         VER=
IFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        options-&gt;ce=2Etun_mtu =3D positive_at=
oi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        in=
t mtu =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (mtu &lt; TUN_MTU_MIN || mtu &gt; TUN_MTU_MAX)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--mt=
u parm must be between %d and %d=2E&quot;, TUN_MTU_MIN,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                TUN_MTU_MAX);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        options-&gt;ce=2Etun_mtu =3D mtu;</span><br><spa=
n>         options-&gt;ce=2Etun_mtu_defined =3D true;</span><br><span>     =
    if (p[2])</span><br><span>         {</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708?=
usp=3Demail">change 1708</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1708?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1708 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--OMtxA0//UA0=--


--===============1651702319971366777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1651702319971366777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1651702319971366777==--

