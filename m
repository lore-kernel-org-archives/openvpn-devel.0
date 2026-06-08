Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6C1CD8C9D
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=UmjI3f7Brg8nyQTalKutG2kjpSF1/2yNrGfFP02gAU8=; b=Qzt2f84gzbPgnr
	eWaLJeSIKxJ1eol3bv2I3OF0t/yiTn5VuwzU0Wq36n1zVzRvMuYan2Qd1hDuXZy+mfeoQMQRT/G3B
	dTZTjGRssyYag7hgXVy3EkSQ2Vtl2P7BfFIpYtfeujRGaooYq+/pXTapF1K9Dlq9cNEzS7m5mFitZ
	mJY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWYXI-0004pH-1g;
	Mon, 08 Jun 2026 11:52:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWYXH-0004pA-1W
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 11:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cDXrEuzZlXxVDTJ6al/eUoVIPEEMkR78+06gro5Ugaw=; b=hPKdcHXvlbIvDF/BnV+Q3yz73Z
 absAPnRH7rTGLxsZptuooIkS8cU3vMWQFrWwWm5VvWMFM+rAlc3lzKaiybQjahqBpwn2PTHkj2Mdm
 a/bba8zDsjrObTD0weuVk2xAIQ46MSgEtVLJGO6yv3uVXJCOVA/MfHkuUwUnh+CjvE0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cDXrEuzZlXxVDTJ6al/eUoVIPEEMkR78+06gro5Ugaw=; b=l
 AdIZR3RZR5tHZW6foZYqcooFC7cujMLYx59bIvwMDw9XUZxzIW2UHo5fioBYImHsGcMqn8RSP6yKw
 VgOOQM/9p74afg8h34Mn8Sgeagd83omKJTvFKRNFTG8HoXMEzjTmJiFUUAlYkV6zyjhyZV/xUORSy
 uXiA1rKZJIgAidJU=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWYXC-0002lt-TC for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 11:52:52 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso2117408f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 04:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780919560; x=1781524360; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDXrEuzZlXxVDTJ6al/eUoVIPEEMkR78+06gro5Ugaw=;
 b=NPC/RGHfui6566AkV2WjoBdvwMGudrNdFqv7F+3XIl47WzWnlVZKr9cSnXL1CdF5Er
 I6kglbsRPpEoY+/BxZnUYEWn3tH1CbKiMwn99sg7S67IFVcjGnqFykw+U0unchEc65Mq
 wY0NOo+PQoonF/Chvnpwy1gwwg+MOtX+uP/lQGzFiibRwH3VMnBdODjt1Phq0ly7drle
 TbkGZmnBc6PHg1lVOOZ4CKrLKPV/F6N6psYM4nm/5B0l3uBITNCEi2ocyeTUNy5DHuLH
 DDhVy9ywKZ3y3uagDF1QytG7TypBG9sPkb3mbGoYVndCQSymbfgrKFV4HxdmIcl/oKyC
 4jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780919560; x=1781524360;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cDXrEuzZlXxVDTJ6al/eUoVIPEEMkR78+06gro5Ugaw=;
 b=L1IfNZRNJ/1T/lEvkc+qYveJkSCg8sFXEMnLNZfYBsG1nrnZDRYcMZGYQCaeBFSwCn
 LYx/LB1L7kDWPRIMEPH/qBPWGS5QIf8oFVf2mYoPTreFOojpZq+9xIuFsLw/ZEEUc9yR
 8dd7bGLISoMRKitc/zsiuOnjudorFk/ss3u+Pt0a+Quo6cxtpMgP63+GLMok5L/rf3Gj
 CUopq1szaRCtZ7Jdk7L9svxok3JvRwdQvTUIbRplLZS2Pa2Q88SpqjWMxP5v5PcdaDdl
 p2K2TQxD3GI+hUyrNYiLINSfPCJNuAI9/csBFb18zKhcr4MSWmzAPM8j3xN0otabjDH7
 Ss2A==
X-Gm-Message-State: AOJu0Yz9g62Eh6SixnYOry6xRiFKn0SOToE1njazd+cZMRzIYCtTXLVc
 jrG+KtlL/5/NkcCH6rqVGAzKXERYqCGbGYnJ53l8Sbu8xwTuZosZmLTa3r0RxWAjG1vETn1E+A7
 BYzhPkiCmeCvAzkyrqoLFQ0Ot52rvN1GbMS7+lQr3V7/5FMFB14BriWBJGO6uQDNRx8JEiAbCKr
 dWphPP+A==
X-Gm-Gg: Acq92OGiJjXxlV1s1hVkmd/CFvGPO44qIuo34/qsfxi2itWGMZYhwRVG5x9P4TjwcXe
 H5/PdyvAwQNu7YO7ej7UO4ZHJiE3eWQ6YDswgpO+vzx+o5DtiD395Sx2YOwVB8oIupmtSPyk/Ks
 OtODzGCmx6vFBnmlXBbvw0v9WcKYZpNPVGo/zvKm6vccgLZ33lXgY76Jj7DOTLhVJTtKAQJKwGe
 Kgtd3pckt+VcYKOgYRs7zTYlAk27kixahHzxvG2ZN87nN1gYcbU5n8HX4188hEWjFObZtdV7LME
 mQ+yjxfroCIaMJY55hnqG1R62gN2dMMeLsUAqywsHRAIvZj5h5blChQ69OpS4Bb5R5kfB1y9wP4
 2trYtmbLnl05W5q2WAken0p4K2jC8SYR5hlOsDB5rEkW82nTOs6ePxF7y4NMEK9qHWusMWAP23J
 0QPYE4cKxhXWfYzcoHGVIsUMiyO96mx8bAZDsYNfNrpGk7v3BYPKwEtqdgu/+hA0w99nywXu6kG
 bCvD/mhpjFfu5O5EudjWDlIsYfNdogDoUkw8rrJUqzJG9fYfpsK8Nk4bCE29zAhF/Gj68enMqOE
 aXxl3gK/7Z3+UWxDBddtcimZRtIbz4H6+q0=
X-Received: by 2002:a05:6000:12c9:b0:45e:73eb:1ff7 with SMTP id
 ffacd0b85a97d-460302dccd4mr16885572f8f.3.1780919559467; 
 Mon, 08 Jun 2026 04:52:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4602cda3651sm40249015f8f.32.2026.06.08.04.52.39
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 04:52:39 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 11:52:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
X-Gerrit-Change-Number: 1708
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1708?usp=email>
X-Gerrit-Commit: 8a9c342fce957230cde794d24e61d3fb791a4f70
References: <gerrit.1780919555000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwOTE5NTU1MDAwLklmZjhiMzM2MTI2YTVkZmY5ODcxMjEzNjY0YjFlODU4NWZiNzBkMjFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <765d726197370910b0ae775c38dd94cac5350976-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWYXC-0002lt-TC
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3516374912805775857=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3516374912805775857==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nPbjURDEUvY="; charset=UTF-8

--nPbjURDEUvY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1708?usp=3Demail )


Change subject: Ensure pushed tun-m=
tu is no lower than TUN_MTU_MIN
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Ensure pushed tun-mtu is no lower than TUN_MTU_MIN

The=
 normal path ensure that the minimum tun mtu is set to at least
TUN_MTU_MIN=
=2E However, the pushed options path does not have this
restriction=2E

Che=
ck that the tun-mtu is within the limits of min/max mtu
in options=2Ec=2E T=
his ensure that the check is also correctly done
on the pushed variant=2E

=
Also add an extra check to keep the allowed payload for icmp6 packets
to be=
 at least 64 bytes in the the block-ipv6 code path
(ipv6_send_icmp_unreacha=
ble) as extra layer of defence=2E

Pushing a low mtu like 1 and also block-=
ipv6 could trigger an
assertion in the ipv6_send_icmp_unreachable code path=
=2E

Reported-By: Haiyang Huang <huanghaiyang83@gmail=2Ecom>
Change-Id: Iff=
8b336126a5dff9871213664b1e8585fb70d21e
---
M src/openvpn/forward=2Ec
M src/=
openvpn/mtu=2Eh
M src/openvpn/options=2Ec
3 files changed, 16 insertions(+)=
, 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/08/1708/1

diff --git a/src/openvpn/forward=2Ec b/src/openvpn/fo=
rward=2Ec
index e43ce28=2E=2E2255951 100644
--- a/src/openvpn/forward=2Ec
+=
++ b/src/openvpn/forward=2Ec
@@ -1610,6 +1610,8 @@
      */
     int max_pa=
yload_size =3D min_int(MAX_ICMPV6LEN,
                                    c=
->c2=2Eframe=2Etun_mtu - icmpheader_len);
+    /* Ensure that minimum paylo=
ad size is at least 64 bytes as extra safety layer */
+    max_payload_size=
 =3D max_int(max_payload_size, 64);
     int payload_len =3D min_int(max_pa=
yload_size, BLEN(&inputipbuf));
 
     pip6out=2Epayload_len =3D htons(size=
of(struct openvpn_icmp6hdr) + payload_len);
diff --git a/src/openvpn/mtu=2E=
h b/src/openvpn/mtu=2Eh
index d3df5b2=2E=2E70ec43d 100644
--- a/src/openvpn=
/mtu=2Eh
+++ b/src/openvpn/mtu=2Eh
@@ -69,6 +69,11 @@
  */
 #define TUN_MTU=
_DEFAULT    1500
 
+/**
+ * Maximum MTU we accept for MTU related options
+=
 */
+#define TUN_MTU_MAX 65536
+
 /*
  * MTU Defaults for TAP devices
  */
=
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 044aab=
3=2E=2Eea640da 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/optio=
ns=2Ec
@@ -6552,7 +6552,15 @@
     else if (streq(p[0], "tun-mtu") && p[1] =
&& !p[3])
     {
         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION=
);
-        options->ce=2Etun_mtu =3D positive_atoi(p[1]);
+        int mtu=
 =3D positive_atoi(p[1]);
+        if (mtu < TUN_MTU_MIN || mtu > TUN_MTU_M=
AX)
+        {
+            msg(msglevel, "--mtu parm must be between %d an=
d %d=2E", TUN_MTU_MIN,
+                TUN_MTU_MAX);
+            goto err=
;
+        }
+
+        options->ce=2Etun_mtu =3D mtu;
         options->ce=
=2Etun_mtu_defined =3D true;
         if (p[2])
         {

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
=
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Iff8b336126a5dff9871213664b1=
e8585fb70d21e
Gerrit-Change-Number: 1708
Gerrit-PatchSet: 1
Gerrit-Owner: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--nPbjURDEUvY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Ensure pushed tun-mtu is no lower than TUN_MTU_MIN<br><br>The norm=
al path ensure that the minimum tun mtu is set to at least<br>TUN_MTU_MIN=
=2E However, the pushed options path does not have this<br>restriction=2E<b=
r><br>Check that the tun-mtu is within the limits of min/max mtu<br>in opti=
ons=2Ec=2E This ensure that the check is also correctly done<br>on the push=
ed variant=2E<br><br>Also add an extra check to keep the allowed payload fo=
r icmp6 packets<br>to be at least 64 bytes in the the block-ipv6 code path<=
br>(ipv6_send_icmp_unreachable) as extra layer of defence=2E<br><br>Pushing=
 a low mtu like 1 and also block-ipv6 could trigger an<br>assertion in the =
ipv6_send_icmp_unreachable code path=2E<br><br>Reported-By: Haiyang Huang &=
lt;huanghaiyang83@gmail=2Ecom&gt;<br>Change-Id: Iff8b336126a5dff9871213664b=
1e8585fb70d21e<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/mtu=2Eh=
<br>M src/openvpn/options=2Ec<br>3 files changed, 16 insertions(+), 1 delet=
ion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/08/1708/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward=
=2Ec b/src/openvpn/forward=2Ec</span><br><span>index e43ce28=2E=2E2255951 1=
00644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/s=
rc/openvpn/forward=2Ec</span><br><span>@@ -1610,6 +1610,8 @@</span><br><spa=
n>      */</span><br><span>     int max_payload_size =3D min_int(MAX_ICMPV6=
LEN,</span><br><span>                                    c-&gt;c2=2Eframe=
=2Etun_mtu - icmpheader_len);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Ensure that minimum payload size is at least 64 bytes as e=
xtra safety layer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    max_payload_size =3D max_int(max_payload_size, 64);</span><br><span>  =
   int payload_len =3D min_int(max_payload_size, BLEN(&amp;inputipbuf));</s=
pan><br><span> </span><br><span>     pip6out=2Epayload_len =3D htons(sizeof=
(struct openvpn_icmp6hdr) + payload_len);</span><br><span>diff --git a/src/=
openvpn/mtu=2Eh b/src/openvpn/mtu=2Eh</span><br><span>index d3df5b2=2E=2E70=
ec43d 100644</span><br><span>--- a/src/openvpn/mtu=2Eh</span><br><span>+++ =
b/src/openvpn/mtu=2Eh</span><br><span>@@ -69,6 +69,11 @@</span><br><span>  =
*/</span><br><span> #define TUN_MTU_DEFAULT    1500</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Maximum MTU we accept for MTU related =
options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define TUN_MTU_MAX 65536</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</=
span><br><span>  * MTU Defaults for TAP devices</span><br><span>  */</span>=
<br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</s=
pan><br><span>index 044aab3=2E=2Eea640da 100644</span><br><span>--- a/src/o=
penvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br>=
<span>@@ -6552,7 +6552,15 @@</span><br><span>     else if (streq(p[0], &quo=
t;tun-mtu&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</=
span><br><span>         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;c=
e=2Etun_mtu =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        int mtu =3D positive_atoi(p[1]);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (mtu &lt; TUN_MTU_MIN || m=
tu &gt; TUN_MTU_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(msglevel, &quot;--mtu parm must be between %d and %d=2E&quot;, TUN_M=
TU_MIN,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    TUN_MTU_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ce=2Etun_=
mtu =3D mtu;</span><br><span>         options-&gt;ce=2Etun_mtu_defined =3D =
true;</span><br><span>         if (p[2])</span><br><span>         {</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1708?usp=3Demail">change 1708</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E=
6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff8b336126a5dff987=
1213664b1e8585fb70d21e </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1708 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--nPbjURDEUvY=--


--===============3516374912805775857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3516374912805775857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3516374912805775857==--

