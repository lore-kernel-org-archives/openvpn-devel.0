Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B93CD4F2C
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XzM5gJ6RSIxCZo7bzUfVbLKlgrqjWIwB3lHumJTFBzo=; b=NXJh9JqtsZ87/Ezu9npmmZhhAE
	5llPLo/yiPmupGkGl0dbovdwp7MUzU+sF1VeIePrHaCsUDGE0ImrLiRoxh3Zeegb5FMScCqLqO2U0
	YCETZlNwiEWKD8gN0Wl4Lcbx1Lp7yvIi5LpdjdSh7ncyM6ChAZJFMndtXb4envsD9AKs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXy3n-0001fg-Or;
	Fri, 12 Jun 2026 09:20:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXy3m-0001d8-GW
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=P/eTzdpldSY0HJR3JgAescnyTaK2EgKMS4sQGOTM2J4=; b=bTCnk8nOHUyTxZCKDOI+I4Ec0K
 DDZwgPGHy4x68UjOTzdra5y3RWmIgyp4aWlZyyUTpQCCv5/cHij3Stp9fTnzVGF3tjemlpB3Bah7Q
 ozAIvKmnl6EMOyrDtal+uzn6qWsu57AkaLtjmG5mXxavMkuD7JMZztQLKt588FJUE4Rs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=P/eTzdpldSY0HJR3JgAescnyTaK2EgKMS4sQGOTM2J4=; b=A
 CDkEYqqxm736HMXmw2l5wBssw9TzJhqrzNOBMF2etJvZjLg/GwoCPaHRGlgqKaXHKyEjF31dzS0Fq
 uGbzAEuteg19/CW4E//Fv7v6MqFdEuOqZRpx04d3o/R/N5MRCmtUUSDlopr47DoJimroW5fD+BCO1
 CvC1X1SF+WhzN8Xs=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXy3M-0003wX-S4 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:19:54 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so1184186f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781255982; x=1781860782; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P/eTzdpldSY0HJR3JgAescnyTaK2EgKMS4sQGOTM2J4=;
 b=ZtNWPMObpLfh0j5tdKYzt6xdgsXG1rvx83TZY0zeIWxeKDN3KtfRV2ItcWgVQVsNQH
 onw8zmwDvrMcmAJ2U2p9vepB8nmp7iGKujQMQU4Fv1D4f0xZ/9+Q3D+zi+iXQ9Yr5Vo+
 /8b9lMyczj+dkhOwmtDhwEKKCE23VPOmWkgm16lZG8xFk7IaeFJhKnkr/2zAwaMOqExc
 mM/p+9ft24JmTv+E1CAywJmPE1fOjKNP6RwIWiEzl7zNZxKbniPuqiA+Uuu5fTro7FPQ
 i6zMrBj89qO9mfbpn26PL/u1w5xRb/Y7HiCOTa2kbIMAQ42BAryrX8OdQQ/R1k+kyIsZ
 la/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781255982; x=1781860782;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P/eTzdpldSY0HJR3JgAescnyTaK2EgKMS4sQGOTM2J4=;
 b=oMl93XKJp/J2HKdLTsg0AIDlqjAClK5t9el7k2WNL4Bc9DmPkOQc/M/36Xh0kGmw6W
 A8jQ5Z/F2M79fRTQvW0jsf/h9KXwv5tZNfrvyNPjKg0WSlgpTJaLFeTNGZMD2jE52V/2
 sKWcUmO+QShancVR32vE1GEj3lyqS1ZA0a0FOnqibRHvfNxIJFoGFascLuYh6XH/Vhnc
 h46K8z8wGaBsiknmdAs/Cx7H7NwwXoTDLXRi5NzMGJ4FBH01kHEg6IPCcaU/VjgDJWsK
 NgmiSjEyHyBNkJg0A9tstVBlb6iZ0PF2x/522+msSrTiZRHbeBzwfAryBnHFNuk2iY2U
 Kmig==
X-Gm-Message-State: AOJu0YyjH18tRal084Xh9eY304zRp6e7xA0dTQr8b2XMxC9DkiGROoFG
 ODAFRf6jZyE7ypWNkcOOX5cnoRbLcjLxaP3Zw6GSTndax7sy/FofauTsqlcjZt28k7OjfgGp2Qr
 q94D7tkHp8GFxOIHTjuQk1r/J32UH7/iPQZlllDdK9jEz5bQYywnk6ye3uNrAO9nh6pH8
X-Gm-Gg: Acq92OHgV0/yjm2Ne1Bf+O3EqajGkhluFfvrikDVjcLiNc8YLuYsUJmwOH0QFI+ZAxZ
 l8bIZSjS9mJNN7/rntG1IDl84SBIqNR6IMjAySTOG8Wm+7GQfRhhFB6P5WuU0TzYrZTY22IRSLf
 AI5Hp07ZlXMr2qTFYNznK9Hdd5Y4jHQTv6qVoyi95IqsPdL6rcfirbdvXnC9iPMw1fF96XvgRVN
 qv6COaF5FtvExPrJ42RE6U2QGlA8Z/8UpygZC+gduPDf0NeHwKBbuoRK4ZXdz8ZboPI0xz0OBvM
 wG2CmzZ8T9h9CSsMtwTqEVKbuVPu+ImhabLtyOgj6zO6b9MtQVntQVGxaPqb9PglczLsiMUyt+6
 ZOkWPetJ7o/dX7jtPUgl5GQvbqA9D2OpWpgJPQcOtt4Ubv5kynLEuFprM4Rx0LNoEAZ9HitANxO
 T5T625I5QamBiSpTOU3MhV9rEb8GONPldyzCDOl89D9m8tkjJHJ4qyEEuOCcgKQWaUMedWzEQzb
 RgjF7yBjjtmTiN4dQogLv29WqBvEAcKHtds1Jj1lkhLy6egmhfCEW3WtM53QARk/px9nazHXsYK
 cFBohftIa+rz8w==
X-Received: by 2002:a05:6000:2488:b0:460:21e7:330e with SMTP id
 ffacd0b85a97d-4606cb2a8f0mr2893125f8f.10.1781255981651; 
 Fri, 12 Jun 2026 02:19:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f726sm3658568f8f.15.2026.06.12.02.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:19:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 09:19:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
X-Gerrit-Change-Number: 1708
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1708?usp=email>
X-Gerrit-Commit: dc023ffebdad65a787f63a6d745537c561db7d76
In-Reply-To: <gerrit.1780919555000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
References: <gerrit.1780919555000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwOTE5NTU1MDAwLklmZjhiMzM2MTI2YTVkZmY5ODcxMjEzNjY0YjFlODU4NWZiNzBkMjFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cbf39223d0df7de30f7451218c373e8bdb4fdba7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXy3M-0003wX-S4
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
Content-Type: multipart/mixed; boundary="===============1664144681517622213=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1664144681517622213==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fby+xrBkzF0="; charset=UTF-8

--fby+xrBkzF0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
cron2


Change subject: Ensure pushed tun-mtu is no lower than TUN_MTU_MIN
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Ensure pushed=
 tun-mtu is no lower than TUN_MTU_MIN

The normal path ensure that the mini=
mum tun mtu is set to at least
TUN_MTU_MIN=2E However, the pushed options p=
ath does not have this
restriction=2E

Check that the tun-mtu is within the=
 limits of min/max mtu
in options=2Ec=2E This ensure that the check is also=
 correctly done
on the pushed variant=2E

Also add an extra check to keep t=
he allowed payload for icmp6 packets
to be at least 64 bytes in the the blo=
ck-ipv6 code path
(ipv6_send_icmp_unreachable) as extra layer of defence=2E=


Pushing a low mtu like 1 and also block-ipv6 could trigger an
assertion i=
n the ipv6_send_icmp_unreachable code path=2E

Reported-By: Haiyang Huang <=
huanghaiyang83@gmail=2Ecom>
Change-Id: Iff8b336126a5dff9871213664b1e8585fb7=
0d21e
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1708
Message-Id: <20260608121759=2E10121-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37084=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/forward=2Ec
M src/openvpn/mtu=2Eh
M src/open=
vpn/options=2Ec
3 files changed, 16 insertions(+), 1 deletion(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/08/1708/2

diff =
--git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index e43ce28=2E=
=2E2255951 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=
=2Ec
@@ -1610,6 +1610,8 @@
      */
     int max_payload_size =3D min_int(M=
AX_ICMPV6LEN,
                                    c->c2=2Eframe=2Etun_mtu -=
 icmpheader_len);
+    /* Ensure that minimum payload size is at least 64 b=
ytes as extra safety layer */
+    max_payload_size =3D max_int(max_payload=
_size, 64);
     int payload_len =3D min_int(max_payload_size, BLEN(&inputi=
pbuf));
 
     pip6out=2Epayload_len =3D htons(sizeof(struct openvpn_icmp6h=
dr) + payload_len);
diff --git a/src/openvpn/mtu=2Eh b/src/openvpn/mtu=2Eh
=
index d3df5b2=2E=2E70ec43d 100644
--- a/src/openvpn/mtu=2Eh
+++ b/src/openv=
pn/mtu=2Eh
@@ -69,6 +69,11 @@
  */
 #define TUN_MTU_DEFAULT    1500
 
+/**
=
+ * Maximum MTU we accept for MTU related options
+ */
+#define TUN_MTU_MAX=
 65536
+
 /*
  * MTU Defaults for TAP devices
  */
diff --git a/src/openvpn=
/options=2Ec b/src/openvpn/options=2Ec
index 044aab3=2E=2Eea640da 100644
--=
- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6552,7 +6552,=
15 @@
     else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
     {
       =
  VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);
-        options->ce=
=2Etun_mtu =3D positive_atoi(p[1]);
+        int mtu =3D positive_atoi(p[1]=
);
+        if (mtu < TUN_MTU_MIN || mtu > TUN_MTU_MAX)
+        {
+       =
     msg(msglevel, "--mtu parm must be between %d and %d=2E", TUN_MTU_MIN,
=
+                TUN_MTU_MAX);
+            goto err;
+        }
+
+       =
 options->ce=2Etun_mtu =3D mtu;
         options->ce=2Etun_mtu_defined =3D =
true;
         if (p[2])
         {

-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1708?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: releas=
e/2=2E6
Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
Gerrit-=
Change-Number: 1708
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--fby+xrBkzF0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Ensure pushed tun-mtu is no=
 lower than TUN_MTU_MIN<br><br>The normal path ensure that the minimum tun =
mtu is set to at least<br>TUN_MTU_MIN=2E However, the pushed options path d=
oes not have this<br>restriction=2E<br><br>Check that the tun-mtu is within=
 the limits of min/max mtu<br>in options=2Ec=2E This ensure that the check =
is also correctly done<br>on the pushed variant=2E<br><br>Also add an extra=
 check to keep the allowed payload for icmp6 packets<br>to be at least 64 b=
ytes in the the block-ipv6 code path<br>(ipv6_send_icmp_unreachable) as ext=
ra layer of defence=2E<br><br>Pushing a low mtu like 1 and also block-ipv6 =
could trigger an<br>assertion in the ipv6_send_icmp_unreachable code path=
=2E<br><br>Reported-By: Haiyang Huang &lt;huanghaiyang83@gmail=2Ecom&gt;<br=
>Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e<br>Signed-off-by: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1708<br>Message-Id: &lt;20260608121759=2E10121-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg37084=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/openv=
pn/mtu=2Eh<br>M src/openvpn/options=2Ec<br>3 files changed, 16 insertions(+=
), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/08/1708/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index e43ce28=2E=2E=
2255951 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><spa=
n>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -1610,6 +1610,8 @@</span=
><br><span>      */</span><br><span>     int max_payload_size =3D min_int(M=
AX_ICMPV6LEN,</span><br><span>                                    c-&gt;c2=
=2Eframe=2Etun_mtu - icmpheader_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Ensure that minimum payload size is at least 64 by=
tes as extra safety layer */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    max_payload_size =3D max_int(max_payload_size, 64);</span><br>=
<span>     int payload_len =3D min_int(max_payload_size, BLEN(&amp;inputipb=
uf));</span><br><span> </span><br><span>     pip6out=2Epayload_len =3D hton=
s(sizeof(struct openvpn_icmp6hdr) + payload_len);</span><br><span>diff --gi=
t a/src/openvpn/mtu=2Eh b/src/openvpn/mtu=2Eh</span><br><span>index d3df5b2=
=2E=2E70ec43d 100644</span><br><span>--- a/src/openvpn/mtu=2Eh</span><br><s=
pan>+++ b/src/openvpn/mtu=2Eh</span><br><span>@@ -69,6 +69,11 @@</span><br>=
<span>  */</span><br><span> #define TUN_MTU_DEFAULT    1500</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Maximum MTU we accept for MTU =
related options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TUN_MTU_MAX =
65536</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /*</span><br><span>  * MTU Defaults for TAP devices</span><br><span>  *=
/</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/option=
s=2Ec</span><br><span>index 044aab3=2E=2Eea640da 100644</span><br><span>---=
 a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</s=
pan><br><span>@@ -6552,7 +6552,15 @@</span><br><span>     else if (streq(p[=
0], &quot;tun-mtu&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>=
     {</span><br><span>         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONN=
ECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        optio=
ns-&gt;ce=2Etun_mtu =3D positive_atoi(p[1]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        int mtu =3D positive_atoi(p[1]);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (mtu &lt; TUN_MTU_=
MIN || mtu &gt; TUN_MTU_MAX)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(msglevel, &quot;--mtu parm must be between %d and %d=2E&quot=
;, TUN_MTU_MIN,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            TUN_MTU_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            goto err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;c=
e=2Etun_mtu =3D mtu;</span><br><span>         options-&gt;ce=2Etun_mtu_defi=
ned =3D true;</span><br><span>         if (p[2])</span><br><span>         {=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3Demail">change 1708</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1708?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: rel=
ease/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff8b33612=
6a5dff9871213664b1e8585fb70d21e </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1708 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cr=
on2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>

</body></html>
--fby+xrBkzF0=--


--===============1664144681517622213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1664144681517622213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1664144681517622213==--

