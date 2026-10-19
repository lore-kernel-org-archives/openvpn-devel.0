Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73207CCF2E5
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GpgqpI0TC/oQ90cYHl58grj6EnT6EDcIt6t9oK6wFX0=; b=coqFhpgxt6s+o3g3a4BBe78hta
	ctkPr+PVTzCMEYOYAYNM4OQvMHJtubR4r364zoBGZn1h6P2TSXKEeVdM6uXMou2I16i71ngU/P9h9
	GzsLnFEj5pmgCmIftUff0zVprTG2/5fkPsZQO6qHGZQ9wrIrsNI7Hgj9nUPRo3HcDwKg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIn7I-0004Nt-GD;
	Mon, 19 Oct 2026 13:09:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIn7E-0004Lf-4y
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:09:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XVr8NI9vv98XE6yAqs7++2ZubFl/iioyMOUk/hK1dO8=; b=Y88nkb88DdohdQtd7uPeiYC+nf
 P1BDLv4ieBhj1i6IyggKFLa1M6XidAE+dBF3bGyi+5f2Z3uUfrFZhwcjCG8vBRK9A//TdB9GPz5CK
 4lfrV9Mncj45Bye3RyMQW3tmtnSdr4kYbsEXXcD6gH7zBWBsUiae8CAWrIivh6bkPhqI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XVr8NI9vv98XE6yAqs7++2ZubFl/iioyMOUk/hK1dO8=; b=K
 oGGG2RQ/bha1iIdCn6S3hCMu2xNb13EKaEJypI/p/lgsHVKU5qHju35vsn648jBuZe2t7OuCSII2J
 DoluXqKK5oKufvxZyPyHqqfuU9zkWC3FfqHgSb8+fDGMcximfcGvpvU8p/PeLKWOpOHdl/nPTxZur
 xIwjpkuffHQ92a2I=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIn6w-0002Md-RI for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:09:07 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso18253065e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792415340; x=1793020140; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XVr8NI9vv98XE6yAqs7++2ZubFl/iioyMOUk/hK1dO8=;
 b=dQEq7Q29RKdJpFVdLwNlQ5rQgATPnSA4pY5wvSVWoHLrCDjnyZBmUtQ+9em5lUUGgr
 wiFWvpOEMJy+buTq/LJo0fNUnvOQd2cDCnLh9b5AiSJMd3NZWQlIgN96ow9y5p6xoohR
 Nkz88l49ht0n8PBHuSX+//Q0oqn/jzrJO8yy/DZHnnNg2PiGF2Y0sKPPz1aCaTBNVwpN
 YEfnAXJz+8rj6wJ4HcB6QZL23PFp1AiP3+4AzneDkXy0lKwJmmIVYIUwFCAKhuMeSPqF
 zOu0VFbEJlGyqYyKyq97fTw8BqRgoNUztLr7roQKoPRfUGpaA2LPCQ8vlh9PAEq4uQ5R
 dULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415340; x=1793020140;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XVr8NI9vv98XE6yAqs7++2ZubFl/iioyMOUk/hK1dO8=;
 b=gBNjmId5AE6cyFiUC3G1gcIexmgeGkw1penKLuRk+klE5DS2fr5Cr7VdRz8uUzT6Bz
 TtNzOLUHn7XBRfEEr1p9UMDcAO1aT/xrqswz6Nwa24iPRL/UYUcxVtLerS3hTdmb53CX
 i0ouC9rkQMHco+hkJXnJXepLTz7h3F0gBONsU9U2sp8DlssrAy9ZW9voDMHG9jzrOaUI
 Qhjfw8JRm2SUZVeDUNi6yjRcS6wa9bVicR8l4HAX5m5xod/yaLB/RDkuxHmDm/DUqM+i
 sHkt22nmqVKTLfhjynMxOqtyR6VI5vW7UK/nEEPpDljVrDomOGOHWZKw2UsniQd2FpLR
 7qVQ==
X-Gm-Message-State: AFq9FYJNNoKiErR9C2nAACGnHGQEXWnE/NuvsSW/2JwyYbQJ/TKlQ9YJ
 fvODRWjX04aE/3uUFhOsCKKVI4wbgJYohTrR4CdF7EGNIKvbD6hn/MtDdlCpMG6Q8+os5QlTIJ7
 rmDdLFIPTG0r2z5NbtSx4sXeTdi1oUsIT7g3gnyFf60gUFH5X8QDIaXqEZ0d6mnx7N//4
X-Gm-Gg: AYBFou2yD6TF8+uO5fLQc0aN1OuGbx/6KzQCSpEpqs7jOQH8T/dXzB98qDv/RQNcyAL
 ornJmyfajQI282i4YfCPYPjcNzhOUk834kqE6YL1qVTAsLHZMIMfjnkoliKiFueFCQTTDCPbnte
 h/D4iL/d6EGTQZ942ONN7bH+CzI/0g3iW62Do1pEPC+P1P+Z5sLs/0sSw55XAYdGB//CNAwaBh8
 U5NoKqhMQ+7QZLMKkachrffKWhDlE9pLuPlP7HMdD5s1UMPS9pve66EPk4bb3ncRtMzgXuf2Cti
 kW4fta8wielUzb+tH/p2Vo9zVJugfVmeI7BHmU6TWzcM+cbZoTZs/c/ZPti+hPPYfgEELkHPh+p
 mRpMB4Ag9E8D5saSV0obpKpT5k+VDE97uf9yL936ALge+dHzBMLXC1n9eZufc/cj5K6LIHYFaZC
 zgN7/UafmUn0qMSjFd7Op8ffMMvFTIC8yrNdBlm8sPA+IhqgFxRkGhvRvHdgvv7liEA1r1lfheq
 bAj0uXgdsw2oNMFqCszdExW1Fi/hkDEA1bQSuwoIJeEsN6l5+yDXZJZQrAUMS9OgKMZDHqlwGOf
 N+5meARoyEOiHIQHYvm5fLwxu3QHtiKcyWBSnf2imbghPKyiFWYWlsyr6V9K
X-Received: by 2002:a05:600c:c87:b0:4a1:bc6e:2f4 with SMTP id
 5b1f17b1804b1-4a1d74659c7mr158867085e9.0.1792415339480; 
 Mon, 19 Oct 2026 06:08:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1dc952d63sm246053935e9.2.2026.10.19.06.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:08:59 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 13:08:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
X-Gerrit-Change-Number: 2014
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2014?usp=email>
X-Gerrit-Commit: 340b9021f401b6638392193db933c2af6c9e0db5
In-Reply-To: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
References: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI1NzcwMDAwLkkxMGViYjU4MjE4MjliZjczOGU1OGZlYzIzZjlmOWRkNjVkNDYyNmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <502d15b9f7c2dcd8789e9e9542c4ac74aef73778-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIn6w-0002Md-RI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix cppcheck
 warnings on macOS
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1099108215161206042=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1099108215161206042==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S4QqCpdmCgI="; charset=UTF-8

--S4QqCpdmCgI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Gert Doering


Change subject: Fix cppcheck warnings on macOS
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix cppcheck =
warnings on macOS

- Replace bzero with CLEAR/memset

   memset is nowadays=
 preferred to bzero

- add_route_ipv6: Fix %d used with unsigned int
- add =
const to two variables that can be const

Found-By: cppcheck on macOS
Chang=
e-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
Signed-off-by: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2E=
de>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014
Message-Id:=
 <20261018145411=2E19775-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40015=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/route=
=2Ec
M src/openvpn/tun=2Ec
2 files changed, 11 insertions(+), 11 deletions(=
-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/14/=
2014/3

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 8e=
93404=2E=2E0b1634c 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rou=
te=2Ec
@@ -1862,7 +1862,7 @@
 #elif defined(TARGET_ANDROID)
     char out[6=
4];
 
-    snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbits, dev=
ice);
+    snprintf(out, sizeof(out), "%s/%u %s", network, r6->netbits, dev=
ice);
 
     status =3D management_android_control(management, "ROUTE6", ou=
t);
 
@@ -3348,10 +3348,10 @@
     rtm_addrs =3D RTA_DST | RTA_NETMASK | RT=
A_IFP;
 #endif
 
-    bzero(&m_rtmsg, sizeof(m_rtmsg));
-    bzero(&so_dst,=
 sizeof(so_dst));
-    bzero(&so_mask, sizeof(so_mask));
-    bzero(&rtm, s=
izeof(struct rt_msghdr));
+    CLEAR(m_rtmsg);
+    CLEAR(so_dst);
+    CLE=
AR(so_mask);
+    CLEAR(rtm);
 
     rtm=2Ertm_type =3D RTM_GET;
     rtm=
=2Ertm_flags =3D RTF_UP | RTF_GATEWAY;
@@ -3566,10 +3566,10 @@
     rtm_add=
rs =3D RTA_DST | RTA_NETMASK | RTA_IFP;
 #endif
 
-    bzero(&m_rtmsg, size=
of(m_rtmsg));
-    bzero(&so_dst, sizeof(so_dst));
-    bzero(&so_mask, siz=
eof(so_mask));
-    bzero(&rtm, sizeof(struct rt_msghdr));
+    CLEAR(m_rtm=
sg);
+    CLEAR(so_dst);
+    CLEAR(so_mask);
+    CLEAR(rtm);
 
     rtm=
=2Ertm_type =3D RTM_GET;
     rtm=2Ertm_flags =3D RTF_UP;
@@ -3654,7 +3654,=
7 @@
     /* get gateway addr and interface name */
     if (gate !=3D NULL=
)
     {
-        struct sockaddr_in6 *s6 =3D (struct sockaddr_in6 *)gate;
=
+        const struct sockaddr_in6 *s6 =3D (struct sockaddr_in6 *)gate;
   =
      struct in6_addr gw =3D s6->sin6_addr;
 
 #ifndef TARGET_SOLARIS
diff =
--git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index a226fc4=2E=2E18c1cf=
f 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1833,7 +18=
33,7 @@
             for (int i =3D 0; i < 256; ++i)
             {
       =
          /* some platforms have a dedicated directory per driver */
-     =
           char *sep =3D "";
+                const char *sep =3D "";
 #if =
defined(TARGET_HAIKU)
                 sep =3D "/";
 #endif

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9=
dd65d4626d3
Gerrit-Change-Number: 2014
Gerrit-PatchSet: 3
Gerrit-Owner: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@=
greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--S4QqCpdmCgI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/201=
4?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">Fix cppchec=
k warnings on macOS<br><br>- Replace bzero with CLEAR/memset<br><br>   mems=
et is nowadays preferred to bzero<br><br>- add_route_ipv6: Fix %d used with=
 unsigned int<br>- add const to two variables that can be const<br><br>Foun=
d-By: cppcheck on macOS<br>Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d46=
26d3<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>A=
cked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014<br>Message-Id: &lt;20261018145411=
=2E19775-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40015=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
route=2Ec<br>M src/openvpn/tun=2Ec<br>2 files changed, 11 insertions(+), 11=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/14/2014/3</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/r=
oute=2Ec b/src/openvpn/route=2Ec</span><br><span>index 8e93404=2E=2E0b1634c=
 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/s=
rc/openvpn/route=2Ec</span><br><span>@@ -1862,7 +1862,7 @@</span><br><span>=
 #elif defined(TARGET_ANDROID)</span><br><span>     char out[64];</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    snprintf(=
out, sizeof(out), &quot;%s/%d %s&quot;, network, r6-&gt;netbits, device);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(out, siz=
eof(out), &quot;%s/%u %s&quot;, network, r6-&gt;netbits, device);</span><br=
><span> </span><br><span>     status =3D management_android_control(managem=
ent, &quot;ROUTE6&quot;, out);</span><br><span> </span><br><span>@@ -3348,1=
0 +3348,10 @@</span><br><span>     rtm_addrs =3D RTA_DST | RTA_NETMASK | RT=
A_IFP;</span><br><span> #endif</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bzero(&amp;m_rtmsg, sizeof(m_rtmsg));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;so_dst, sizeo=
f(so_dst));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bzero(=
&amp;so_mask, sizeof(so_mask));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    bzero(&amp;rtm, sizeof(struct rt_msghdr));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    CLEAR(m_rtmsg);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    CLEAR(so_dst);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    CLEAR(so_mask);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    CLEAR(rtm);</span><br><span> </span=
><br><span>     rtm=2Ertm_type =3D RTM_GET;</span><br><span>     rtm=2Ertm_=
flags =3D RTF_UP | RTF_GATEWAY;</span><br><span>@@ -3566,10 +3566,10 @@</sp=
an><br><span>     rtm_addrs =3D RTA_DST | RTA_NETMASK | RTA_IFP;</span><br>=
<span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    bzero(&amp;m_rtmsg, sizeof(m_rtmsg));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;so_dst, sizeof(so_dst));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;so_mask, s=
izeof(so_mask));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
zero(&amp;rtm, sizeof(struct rt_msghdr));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(m_rtmsg);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(so_dst);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    CLEAR(so_mask);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    CLEAR(rtm);</span><br><span> </span><br><span>    =
 rtm=2Ertm_type =3D RTM_GET;</span><br><span>     rtm=2Ertm_flags =3D RTF_U=
P;</span><br><span>@@ -3654,7 +3654,7 @@</span><br><span>     /* get gatewa=
y addr and interface name */</span><br><span>     if (gate !=3D NULL)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    struct sockaddr_in6 *s6 =3D (struct sockaddr_in6 *)gate;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const struct sockaddr_in6 =
*s6 =3D (struct sockaddr_in6 *)gate;</span><br><span>         struct in6_ad=
dr gw =3D s6-&gt;sin6_addr;</span><br><span> </span><br><span> #ifndef TARG=
ET_SOLARIS</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/t=
un=2Ec</span><br><span>index a226fc4=2E=2E18c1cff 100644</span><br><span>--=
- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br=
><span>@@ -1833,7 +1833,7 @@</span><br><span>             for (int i =3D 0;=
 i &lt; 256; ++i)</span><br><span>             {</span><br><span>          =
       /* some platforms have a dedicated directory per driver */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                char *sep =3D &=
quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         const char *sep =3D &quot;&quot;;</span><br><span> #if defined(TAR=
GET_HAIKU)</span><br><span>                 sep =3D &quot;/&quot;;</span><b=
r><span> #endif</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail">change 2014</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I10ebb5821829bf7=
38e58fec23f9f9dd65d4626d3 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2014 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>=

<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--S4QqCpdmCgI=--


--===============1099108215161206042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1099108215161206042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1099108215161206042==--

