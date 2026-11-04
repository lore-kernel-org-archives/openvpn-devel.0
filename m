Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60195606A32C
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RGtP3t3y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b8ngcFbU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G7HYwyhX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LLUB4KoV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=vKOqOJnHIE3Sc5xNtdnMwuDjdGHeTKo/03bAA3+QeLE=; b=RGtP3t3yWUCavRz1SbzqZKVDY7
	si6yQb1c8hWZFYghJ1HFTl4TS3mXJyc+DQCAw70La44nsKbAqDveLlZY2lv35UjDlU/Xb1VNaQDnU
	93VoeOw1DAiNBWT7A+OisBoJ9PbXOPX1Kd9P7/QlXsDznC0/wEyskM6p7nwhBEuZYfQE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOW2d-000000008Q3-3TZX;
	Wed, 04 Nov 2026 08:08:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOW2c-000000008Pp-1sW5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:08:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dMMpFZTyAfx2ZZ4h2pUIWhCK4KP/yeencWDxKQLkaHo=; b=b8ngcFbUB2b2b2E9Waola864Tu
 Ce5zml80uTUwTyda1dGBylsFa+N26RM5PmJ+P74AtrihfXmecA8xkFrMHFPJ7X+yDHJnUGME5Ev1x
 Ueg0Gb3gG2WW6Z6K0GaaolZ79jYxDCw/yVif8M+8LX4CMcQhJFVBakgw6Vd+y5wZn17w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dMMpFZTyAfx2ZZ4h2pUIWhCK4KP/yeencWDxKQLkaHo=; b=G7HYwyhX+S/u3FD2PWhN8+l56O
 3IriLnOOkEz5aWDK5UlX6I6lw4nJGggRCc6QaCXnlutXmCzvf4OQzsCLj8yF/8iDoZCWzU/Z2v4xH
 AbFyPk4Z2JJIho8xeR4P30JHxtLO+Cvwbnzw4l9qCzh/hrkO6TitdtYvyrQt34JlJwxw=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOW2b-000000007R9-36h6 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:08:18 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so3106205e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793779691; x=1794384491; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dMMpFZTyAfx2ZZ4h2pUIWhCK4KP/yeencWDxKQLkaHo=;
 b=LLUB4KoVEfszp33ZyFfKbI04/nCsEMcNr9QtsONH3nyaz9xQOW2a8vAMiKkRpwdywS
 ZgPp4u2inEwnvBP0bszxOkK+u+PjZ8344JW2Ugj/DxdZRvujkMCNW+ToGr6BNs9tNNJH
 cWRQWhjCaOxcxnzq19cAEbkBa7XM6oua5MmEBwByk93PS15gUEV1qcMfJWI8c1487qyG
 v6WD6yUjwhyP3N3J9jgWjnQezEoaDmORB9R4DN8ZvPiQyccXkTrbwFPBwxlp9XZGO0xf
 HE6g37tBYmeXpUM+LhLtYPCmjCXoIgbfnyEnl4Z6C6Z07mBMc/tLM0sGksd6T3PEeArq
 uQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793779691; x=1794384491;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dMMpFZTyAfx2ZZ4h2pUIWhCK4KP/yeencWDxKQLkaHo=;
 b=TRVj5wVSylyYrpR4ToYApHrB4CR6y5Wi/mtp5qELvuPiZAcsuXsIO1NbrWtHt6DNc/
 c73mM140ADQ3YPjML0VyyMoa2ccXuu/sLWaMk54DGAqDwqp/Vv20rQgdAOs5Jf3irxNZ
 hLpr2nx0DMKJK6hfXuPx1ILBO09nfEgiqL4b4K3T7P/3MxSWw7rfXgROvy4nFZKnE4mQ
 VgCPWa95nIvuB2T6D8mkF2FGSGKQIpEcG0jy1rz0MMgAKq3m4no3G9+bhHwP1QXfD/uP
 96hj8ZIC1L/9c9THcCQKvb1HuGqWxwUUZb/rDdBPMRQPyawbdOOzHcPzeqYXB6vkxmr7
 0piA==
X-Gm-Message-State: APuU4Z9n8vziirtnb21AlncydGTNtnkqk0K3TZ2RCM2Y0NKs5pV9nzoV
 X1UN+NNErsXRwaFgiRClPRjhz5CDA2+Ofj3lMK9g2+hyHkFWRZcsLy4ZbnEhFQxTRXG8Cz5p+bC
 zAT41kR5wYmiQAWsrU2hYZIycVbEBADsp6fCV6AycezvzMAAoWt7rkaO8eMS99VHeQ3DYJMt2Js
 dthKQ64w==
X-Gm-Gg: AYBFou2OrxPtmy+DKmnFOmhUNHX28HIMNCR4neLn5D5KegRLr7UkFwB8TSUwdOVTcAV
 xs/JJH4AwFrEJo8Igh6kjihrl9H4Mr9B8nDIRuObpd80bhKtA1mD7GmJ7XuGgH/Ah3LEzFW4AZV
 H5Nty6lAj86Ynmor3oCcy7MIAi9MZXAX59e6bL9tAcq1fVYcVp+aglgFBsQktbEN6pdwNWZ4Bml
 HVwbrPgG6xISHImYPWcXWC+tjoT4wEQmqIIohOn0qPy6JrCaR36H6yduCZZukjolvyN1Yt4Wl2j
 RksbR5RgfBAYeg5hpcgnBOCWUCkKklw2DSm6JR2K8IiGX4OKfFDEvX1OrRJlM1CAe3ZLz0e8cXc
 plr3lMMZlA4NwDppMObLWx7mTc3PIsyocmBjJsSOVDHbXgCb2IE4TOy/BNqNSDvGcoPaRIveSKN
 1Avdc0MbyGJ7RPPyOwbJZ0XrRWV9kwIFrx8qARMTAnA+mBx1TmEoVqUsxxPv9NOiftA+9dNF7Sq
 6iHJcj7VZAEBzD9mV6RWQCE+wsb/huzgCM0gTMxXrwGCR/lIwZAdqEUNrJ/o9JbCBRahsxHkilT
 9MTIJOF4H4FXufuS2BG3kFc/eb8wxRKBJ7xYFIL2d2dQDwPzmP+fvg/p9QjROyWaHWOYdGxe37o
 ID3m6KWjy/XPyd6jxdnAtjaqVJuMGqkG4JjUqYThYvKVNIXyFQcdKomIMyZ4ZMZV0z7ZupEwMYV
 TPmB69IfTiNIwAfQ==
X-Received: by 2002:a05:600c:6555:b0:4a1:d45a:3ae9 with SMTP id
 5b1f17b1804b1-4aa8b05fa4bmr357038425e9.15.1793779691031; 
 Wed, 04 Nov 2026 00:08:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180ee1sm2846614f8f.4.2026.11.04.00.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:08:10 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 08:08:10 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I766eff47993375c80895755355919ede11b488db
X-Gerrit-Change-Number: 2124
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2124?usp=email>
X-Gerrit-Commit: 9d0d246a2b71adc4b8992cc70775667e53068d16
References: <gerrit.1793779688000.I766eff47993375c80895755355919ede11b488db@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5Njg4MDAwLkk3NjZlZmY0Nzk5MzM3NWM4MDg5NTc1NTM1NTkxOWVkZTExYjQ4OGRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <535ee4dc7680c97aad58b64c5723d0437890072f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOW2b-000000007R9-36h6
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: make
 delete_route_connected_v6_net() and create_arbitrary_remote...
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6077213595506000224=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6077213595506000224==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BMnuDZyoBKg="; charset=UTF-8

--BMnuDZyoBKg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2124?usp=3Demail

to review the following change=2E
=


Change subject: tun: make delete_route_connected_v6_net() and create_arbi=
trary_remote() static
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

tun: make delete_route_connected_v6_net() and create_arbitrary_r=
emote() static

Neither is used outside tun=2Ec or declared in a header=2E
=

create_arbitrary_remote() has had no FreeBSD/DragonFly caller since
94db32=
61 ("FreeBSD: for topology subnet, put tun interface into
IFF_BROADCAST mod=
e"), so limit it to NetBSD and OpenBSD to avoid an
unused static function t=
here=2E

Change-Id: I766eff47993375c80895755355919ede11b488db
Signed-off-by=
: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/tun=2Ec
1 file =
changed, 3 insertions(+), 4 deletions(-)



  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/24/2124/1

diff --git a/src/openvpn/tun=
=2Ec b/src/openvpn/tun=2Ec
index 225d8b1=2E=2Eb6728fa 100644
--- a/src/open=
vpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -988,7 +988,7 @@
     add_route_ip=
v6(&r6, tt, 0, es, NULL);
 }
 
-void
+static void
 delete_route_connected_v=
6_net(const struct tuntap *tt)
 {
     struct route_ipv6 r6;
@@ -1005,8 +10=
05,7 @@
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(=
TARGET_NETBSD) || \
           defined(TARGET_OPENBSD) */
 
-#if defined(TA=
RGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) \
-   =
 || defined(TARGET_OPENBSD)
+#if defined(TARGET_NETBSD) || defined(TARGET_O=
PENBSD)
 /* we can't use true subnet mode on tun on all platforms, as that
=
  * conflicts with IPv6 (wants to use ND then, which we don't do),
  * but =
the OSes want "a remote address that is different from ours"
@@ -1016,7 +10=
15,7 @@
  * is still point to point and no layer 2 resolution is done=2E=2E=
=2E
  */
 
-in_addr_t
+static in_addr_t
 create_arbitrary_remote(const stru=
ct tuntap *tt)
 {
     in_addr_t remote;

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2124?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I766eff47993375c80895755355919ede11b488db
Gerrit-Ch=
ange-Number: 2124
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--BMnuDZyoBKg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2124?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tun: make delete_route_connected_v6_net() and create_ar=
bitrary_remote() static<br><br>Neither is used outside tun=2Ec or declared =
in a header=2E<br><br>create_arbitrary_remote() has had no FreeBSD/DragonFl=
y caller since<br>94db3261 (&quot;FreeBSD: for topology subnet, put tun int=
erface into<br>IFF_BROADCAST mode&quot;), so limit it to NetBSD and OpenBSD=
 to avoid an<br>unused static function there=2E<br><br>Change-Id: I766eff47=
993375c80895755355919ede11b488db<br>Signed-off-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/tun=2Ec<br>1 file changed, 3 =
insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/24/2124/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 225d8b1=
=2E=2Eb6728fa 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><s=
pan>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -988,7 +988,7 @@</span><br=
><span>     add_route_ipv6(&amp;r6, tt, 0, es, NULL);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span> delete_route_connected_v6_net(const struct tuntap *tt)</span><br><s=
pan> {</span><br><span>     struct route_ipv6 r6;</span><br><span>@@ -1005,=
8 +1005,7 @@</span><br><span> #endif /* if defined(_WIN32) || defined(TARGE=
T_DARWIN) || defined(TARGET_NETBSD) || \</span><br><span>           defined=
(TARGET_OPENBSD) */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) ||=
 defined(TARGET_NETBSD) \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    || defined(TARGET_OPENBSD)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)</span>=
<br><span> /* we can&#39;t use true subnet mode on tun on all platforms, as=
 that</span><br><span>  * conflicts with IPv6 (wants to use ND then, which =
we don&#39;t do),</span><br><span>  * but the OSes want &quot;a remote addr=
ess that is different from ours&quot;</span><br><span>@@ -1016,7 +1015,7 @@=
</span><br><span>  * is still point to point and no layer 2 resolution is d=
one=2E=2E=2E</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-in_addr_t</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static in_addr_t</span><br><span> create_arbitrary_re=
mote(const struct tuntap *tt)</span><br><span> {</span><br><span>     in_ad=
dr_t remote;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2124?usp=3Demail">change 2124</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2124?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I766eff47993375c8089=
5755355919ede11b488db </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2124 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--BMnuDZyoBKg=--


--===============6077213595506000224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6077213595506000224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6077213595506000224==--

