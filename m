Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5475606A32E
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DueGrEpW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PHTVcGdp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iHycpQqa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=efO3Ci60
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UqrJrUHnSRKbvzv1AJ7K2OS/JmZTs8jkcRp63Gh5nOQ=; b=DueGrEpWmq0cdIrs9eq8lh48Qm
	AvsQaxeP+nJc5BRL40juau61XtcwRy1xXX9mR7kgJAEl3tTquxJn+qLn7+84UFqPfGgVGgVYTAHON
	vcqpDdr1JPd6Rb3mjtZ92fKhbaSL2mLWpeOG+xbNidJgUpTz8asBr0wzxMS160Npzn4c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOZ0v-000000006h9-0r47;
	Wed, 04 Nov 2026 11:18:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOZ0g-000000006gs-1nxB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:18:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nmaIO1fyuwu5C6bgi4alCNNsT13DeTgaOV1ZqBw/8ks=; b=PHTVcGdpGAKuuQNL8dFP8LE4OH
 pxiWEhsL6kwly8XEFxKXFj7dgSdQmHepYSagqy0U5OjAY8EUKjg4k0wTDPCcS0lVh/gF6h0xhkVJr
 h3sGxaK5AYYPQEmHiplSSS9Rze9jAIODP9PZ37HEI614tfC0+XL1ICuuUU1GnVHXnRJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nmaIO1fyuwu5C6bgi4alCNNsT13DeTgaOV1ZqBw/8ks=; b=iHycpQqa88QuDzmZ650b5McpvU
 ZgUPe+EI845GiEvAdc12gjdTiD2ooGkE5dbKYvAYQ68aN8SoE9ck7xFRzhCLzZ2ZiLSxB9AMW0UFg
 amwxqX9A/ajtFocOwMGaZlWNk6kwEt+KX9RXHgadU644f49PjErFAi/0y0zo7YLNRaW4=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOZ0d-000000000YE-3G7d for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:18:30 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so460197f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 03:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793791101; x=1794395901; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nmaIO1fyuwu5C6bgi4alCNNsT13DeTgaOV1ZqBw/8ks=;
 b=efO3Ci600jesN6EdJuHrs/kp4Nj2zOvmD0Oby+JT2OW5V2JYBijuqgwdw+wi4zHiG8
 TxweekiJncth/hUEltLGHnkA8Ig5250lcUviKXUTntJ5CYzBJILyfDZ1bW0TO4Dc/MqG
 isMguWzvnCCNyRM5jB+4KMWLLlD0F9ZJBIbqY4t4G7jLY1u94l9oLvbAaVIcLnNDx9Zy
 b4cV0s+XUFjmvfWrChjZ4QS0JaN7ejakinm6d3dydJO6qO+hfB3oqudp6Jx8Zt6WjNJD
 tKx4Uox1J+dMvQP1KqgBKzGMjqllmS2MeiQ2uXNoB0EHxD96BZBT7OWIwfENNdVU1iXs
 zWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793791101; x=1794395901;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nmaIO1fyuwu5C6bgi4alCNNsT13DeTgaOV1ZqBw/8ks=;
 b=UzGT3ZwuMMyON2GXbIuGrcyuJUEj+U4mB67JTc4IUML83lGU+B2z+HF2dwUnClEn/U
 ayllswhtxJe5NDSUyMQ3HQCFTMUevo8stc0+lp0A7+CoWSxSAfXUMvw9T3vt5Bhhcz+h
 /a5tDN2jeHCO68OWIIsSANChhHY6ZX+e1BqMunMpLbaRAFpyKQAQjhKjfM9HZbnhAf2e
 RdtA4nfntvS32TieDKpiQrBfQM/Els5HX6+OtrjOF7kAgNNHutYN1+1/zxsTqY/kr05l
 M39i4CMcsu7Bnpdxqn6Xmc1WmPHpjrR52vTMMBx3LZSkaTrVv3qWR9SHcd4mVQf9ehjK
 rg3w==
X-Gm-Message-State: APuU4Z/KftCF+JoTxl1OBepf1bo0o1YgT5wpp4zQ0WI517BT+kpIVFDP
 Kom6ch8NdWLXBSiEQVA9cPENHfQq9xl2bxEauQSkKqhSBVf5d8i65JKfRok/tX2dcJQKZxuccDI
 dhGHBLY/+t5RSIWGE0OmwEIVNSOz68y0uCSZepW/Vtxz/i0CAIRXYhUjuBBhENLr1QL7MGW8h8j
 j2ZnN6+Q==
X-Gm-Gg: AYBFou3BlilPsr2E4W+5efWqJFF3vUapJcmW81rCrSvE6Tp6cErPwlL2855KNJIAbN+
 dFKRGG9qr0/xqp9iY2Q8nr2+4HtO+70++gVEvXa01KiTzYQlrw6A4bDF9JWJhvPTuxqsXRcml6k
 3bqJvYgQ3BDJ4Ze9zmXzShqGqUyxYYVQ4/+w28IhqpREVrCwnpDlc3+72dbxUWawOy2KPh7Oubw
 ICmJJn6dH2mbuiciXPLvTa2vLTSuiifxjThnjJxA8q6UKnfqDh+hGyDjgVhBkiBIIpdxDNPL5Qw
 SLwtxsjQ2JxeEoZ87nSWjPhnJX50lEgfj8+N/ycp8Y3zXbS6DK9a4h+Z3K8YiwY3tzWDADy2NMV
 3yM8PH/j3hNCejGttFcOgBlQlylsG6ho+Kt5hFiQwH/h5yUZsOkBOfclzoAUsldsZkkQGlMKSpI
 7Le5zZ3aIz8o8HROlzDq5YOKiW48Oimkl5gwh7g3pa0Vwl8C6V5JBD1OGaPWXAK+ZPbJjoa0nw8
 j3ZqJDcMeZRCch+6Zc16aG4mCG2C+1zrk2mUtK3oehroI1+iCEYWsOPb1hLuE93WxlzbakhVpWo
 rx96VKCVc3OOmufd0Z/20RBrpvyI46gLlau89lHTlRIbjbSMepIqQdYGpaDJW3DOXuLK0BF3Xjw
 BnV+HSFs9oTKfBwiM+xKw6B51+6GfDBXJr2w1waO8pBo+m9gJt3fa3nSoeAKQlQtuJTrFxlgByE
 Zgt3y84psltwM1aA==
X-Received: by 2002:a5d:64a7:0:b0:48e:5e1f:9a36 with SMTP id
 ffacd0b85a97d-48e6e50191cmr26802862f8f.42.1793791100782; 
 Wed, 04 Nov 2026 03:18:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fece99d67sm3333000f8f.24.2026.11.04.03.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 03:18:20 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 11:18:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: f2a3322f598f643c1703ef68907877800d776594
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e0cbd9e5bb3655193693ec821626665cbcfc843e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOZ0d-000000000YE-3G7d
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2073737894522920099=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2073737894522920099==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x0FpCBbHcV8="; charset=UTF-8

--x0FpCBbHcV8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

H=
ello Antonio Quartulli, Arne Schwabe, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=
=3Demail

to look at the new patch set (#3)=2E


Change subject: dco_linux:=
 enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux: enable RPS on newly created DCO =
interfaces

When multiple TCP streams share an OpenVPN tunnel, their ACKs a=
rrive
through the same outer flow and can be processed on a single NIC RX C=
PU=2E
Delivering the decrypted ACKs can also drain TCP transmit queues inli=
ne,
concentrating receive processing, transmission and crypto work on that
=
CPU despite the parallelism available between inner flows=2E

Enable Receiv=
e Packet Steering (RPS) on newly created DCO interfaces to
distribute inner=
 flow processing across CPUs, after decryption=2E Build a
mask covering all=
 possible CPU IDs and let the kernel filter out offline
CPUs=2E

Add --disa=
ble-rps to skip automatic RPS configuration=2E Document the
option and the =
limitation that RPS may not be re-enabled if the
interface is recreated aft=
er privileges have been dropped=2E

Leave pre-existing interfaces and nonze=
ro RPS masks unchanged, including
masks inherited from net=2Ecore=2Erps_def=
ault_mask=2E Failure to configure RPS
is nonfatal=2E

Tested on a Ryzen 9 9=
950X with Fedora's stock ovpn module from kernel
7=2E2=2E5-200=2Efc44=2Ex86=
_64 and two ConnectX-4 Lx ports were cabled at 25
Gb/s, The tunnel used IPv=
4/UDP, AES-256-GCM and MTU 1448=2E Values are
medians across three 20 secon=
ds iperf3 runs, after a 3-second warmup:

flows    RPS off     RPS on      =
change
  1         9=2E01      12=2E06      +33=2E9%
  4         9=2E41    =
  16=2E90      +79=2E6%

At four streams, the sender NIC IRQ CPU's average =
softirq utilization
was 98=2E7-99=2E5% off and 4=2E7-47=2E2% on=2E

Change-=
Id: I97c55e211f9113d090808724ab43cb3c94099fb0
Reported-By: Lev Stipakov <le=
v@openvpn=2Enet>
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
---
M READ=
ME=2Edco=2Emd
M doc/man-sections/advanced-options=2Erst
M src/openvpn/dco_l=
inux=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/=
options_show=2Ec
6 files changed, 184 insertions(+), 0 deletions(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/1991/3

di=
ff --git a/README=2Edco=2Emd b/README=2Edco=2Emd
index a93dc94=2E=2E6ece2b7=
 100644
--- a/README=2Edco=2Emd
+++ b/README=2Edco=2Emd
@@ -52,6 +52,20 @@
=
 
 in your log=2E
 
+On Linux, OpenVPN enables Receive Packet Steering (RPS=
) on DCO interfaces it
+creates, distributing inner-flow processing across =
online CPUs=2E Use
+`--disable-rps` to opt out of this automatic configurat=
ion if its overhead
+outweighs the performance benefit on your system=2E Pr=
e-existing interfaces and
+nonzero RPS masks (including masks inherited fro=
m `net=2Ecore=2Erps_default_mask`)
+are preserved and `--disable-rps` does =
not clear administrator-configured masks=2E
+
+RPS is configured before Ope=
nVPN drops privileges during initial setup=2E If the
+interface is recreate=
d after dropping privileges, for example when pulled
+options change on rec=
onnect, OpenVPN may be unable to re-enable RPS because the
+sysfs file is n=
ot writable by the new user=2E This failure is logged and is
+nonfatal=2E `=
--persist-tun` normally preserves the interface and its RPS mask,
+but chan=
ges to certain pulled options can still force recreation=2E
+
 
 Getting st=
arted (Windows)
 -------------------------
diff --git a/doc/man-sections/ad=
vanced-options=2Erst b/doc/man-sections/advanced-options=2Erst
index 32008d=
5=2E=2E6581657 100644
--- a/doc/man-sections/advanced-options=2Erst
+++ b/d=
oc/man-sections/advanced-options=2Erst
@@ -115,3 +115,17 @@
   is enabled=
=2E
 
   On platforms that do not support DCO ``disable-dco`` has no effect=
=2E
+
+--disable-rps
+  Do not automatically enable Receive Packet Steering=
 (RPS) on newly created
+  Linux DCO interfaces=2E This option is local and=
 cannot be pushed by a server=2E
+  It is accepted on all platforms, but ha=
s no effect outside Linux DCO=2E
+
+  By default, OpenVPN enables RPS to di=
stribute inner-flow processing across
+  online CPUs=2E This can improve th=
roughput, but the additional processing
+  overhead may outweigh the benefi=
t on some systems or workloads=2E
+  ``--disable-rps`` skips this automatic=
 configuration=2E
+
+  Pre-existing interfaces and nonzero RPS masks, inclu=
ding masks inherited
+  from ``net=2Ecore=2Erps_default_mask``, are left un=
changed even without
+  ``--disable-rps``=2E
diff --git a/src/openvpn/dco_l=
inux=2Ec b/src/openvpn/dco_linux=2Ec
index e9cf0b7=2E=2E8c2f666 100644
--- =
a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -33,6 +33,7 =
@@
 #include "buffer=2Eh"
 #include "networking=2Eh"
 #include "openvpn=2Eh=
"
+#include "options_util=2Eh"
 
 #include "socket=2Eh"
 #include "tun=2Eh"=

@@ -553,6 +554,145 @@
     return "unknown";
 }
 
+/**
+ * Build an RPS ma=
sk covering all possible CPU IDs=2E The kernel filters out
+ * offline CPUs=
 when installing the mask, so only the last ID in the sorted
+ * sysfs CPU =
list is needed, even when the list has gaps=2E
+ * Removes the trailing new=
line from cpus before parsing the last ID=2E
+ */
+static bool
+ovpn_rps_ma=
sk_full(char *cpus, struct buffer *mask)
+{
+    /* the cpus string contain=
s range formats like "0-31" or "0-15,32-47" */
+    size_t len =3D strspn(c=
pus, "0123456789,-");
+    if (!len || cpus[len] !=3D '\n' || cpus[len + 1]=
 !=3D '\0')
+    {
+        return false;
+    }
+
+    /* walk backwards o=
ver the trailing digits to find the beginning of the
+     * last number, s=
topping at a separator or the beginning of the string
+     */
+    const c=
har *last =3D cpus + len;
+    while (last > cpus && last[-1] >=3D '0' && l=
ast[-1] <=3D '9')
+    {
+        --last;
+    }
+    if (last =3D=3D cpus =
+ len)
+    {
+        return false;
+    }
+
+    cpus[len] =3D '\0';
+   =
 int last_cpu;
+    if (!atoi_constrained(last, &last_cpu, "last possible C=
PU", 0, INT_MAX, M_WARN))
+    {
+        return false;
+    }
+
+    /* th=
e most significant group may contain fewer than 32 bits */
+    unsigned in=
t word =3D UINT32_MAX >> (31 - last_cpu % 32);
+    /* first handle the mos=
t significant, potentially partial group */
+    if (!buf_printf(mask, "%x"=
, word))
+    {
+        return false;
+    }
+    /* then write the other =
chunks, comma-separated as required by bitmap_parse
+     * in linux/lib/bi=
tmap-str=2Ec
+     */
+    for (int i =3D last_cpu / 32; i > 0; --i)
+    {=

+        if (!buf_printf(mask, ",ffffffff"))
+        {
+            retur=
n false;
+        }
+    }
+    return buf_printf(mask, "\n");
+}
+
+static=
 void
+ovpn_enable_rps(const char *dev)
+{
+    char rps_path[PATH_MAX];
+ =
   /* ovpn interfaces have a single RX queue */
+    if (!checked_snprintf(=
rps_path, sizeof(rps_path),
+                          "/sys/class/net/%s/q=
ueues/rx-0/rps_cpus", dev))
+    {
+        msg(M_WARN, "DCO: cannot build =
RPS path for %s", dev);
+        return;
+    }
+
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer current =3D buffer_read_from_file(rps_path=
, &gc);
+    /* buffer_read_from_file counts the terminating NUL as content=
 */
+    buf_rmtail(&current, '\0');
+    if (!buf_defined(&current) || BLE=
N(&current) < 2 || *BLAST(&current) !=3D '\n')
+    {
+        /* RPS may b=
e unavailable, for example with CONFIG_RPS disabled */
+        msg(D_DCO_D=
EBUG, "DCO: cannot read RPS mask from %s", rps_path);
+        goto out;
+ =
   }
+    if (strspn(BSTR(&current), "0,") !=3D (size_t)BLEN(&current) - 1)=

+    {
+        /* new devices can still inherit an administrator's rps_de=
fault_mask */
+        msg(D_DCO_DEBUG, "DCO: preserving existing RPS mask =
in %s: %=2E*s", rps_path,
+            BLEN(&current) - 1, BSTR(&current));=

+        goto out;
+    }
+
+    const char *cpus_path =3D "/sys/devices/s=
ystem/cpu/possible";
+    struct buffer cpus =3D buffer_read_from_file(cpus=
_path, &gc);
+    if (!buf_defined(&cpus))
+    {
+        msg(M_WARN, "DCO=
: cannot read possible CPUs from %s", cpus_path);
+        goto out;
+    }=

+
+    struct buffer mask =3D alloc_buf_gc(4096, &gc);
+    if (!ovpn_rps_=
mask_full(BSTR(&cpus), &mask))
+    {
+        msg(M_WARN, "DCO: cannot bui=
ld RPS mask from %s", cpus_path);
+        goto out;
+    }
+
+    /* recre=
ating the interface after dropping privileges may leave us unable
+     * t=
o open this root-owned file, even with CAP_NET_ADMIN retained
+     */
+   =
 int fd =3D open(rps_path, O_WRONLY);
+    if (fd < 0)
+    {
+        msg(=
M_WARN | M_ERRNO, "DCO: cannot open %s for enabling RPS", rps_path);
+     =
   goto out;
+    }
+    /* submit the complete mask in one write and retry=
 only on interruption */
+    ssize_t written;
+    do
+    {
+        writ=
ten =3D write(fd, BPTR(&mask), (size_t)BLEN(&mask));
+    } while (written =
< 0 && errno =3D=3D EINTR);
+
+    if (written < 0)
+    {
+        msg(M_W=
ARN | M_ERRNO, "DCO: cannot enable RPS on %s", dev);
+    }
+    else if (w=
ritten !=3D BLEN(&mask))
+    {
+        msg(M_WARN, "DCO: incomplete RPS m=
ask write to %s", rps_path);
+    }
+    else
+    {
+        msg(D_DCO, "D=
CO: RPS enabled on %s with CPU mask %=2E*s", dev, BLEN(&mask) - 1,
+       =
     BSTR(&mask));
+    }
+    if (close(fd) < 0)
+    {
+        msg(M_WAR=
N | M_ERRNO, "DCO: cannot close %s", rps_path);
+    }
+
+out:
+    gc_free=
(&gc);
+}
+
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, c=
onst char *dev)
 {
@@ -584,6 +724,11 @@
             return -EINVAL;
      =
   }
     }
+    /* configure RPS only on newly created devices unless expl=
icitly disabled */
+    if (ret =3D=3D 0 && !tt->dco=2Ec->options=2Edisable=
_rps)
+    {
+        ovpn_enable_rps(dev);
+    }
 
     tt->dco=2Eifindex=
 =3D if_nametoindex(dev);
     if (!tt->dco=2Eifindex)
diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec
index 8e0c602=2E=2E62e21d5 10064=
4
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -207,6 +20=
7,9 @@
     "                  /dev/net/tun, /dev/tun, /dev/tap, etc=2E\n"
=
 #if defined(ENABLE_DCO)
     "--disable-dco   : Do not attempt using Data =
Channel Offload=2E\n"
+#ifdef TARGET_LINUX
+    "--disable-rps   : Do not a=
utomatically enable Receive Packet Steering on DCO interfaces=2E\n"
+#endif=

 #endif
     "--lladdr hw     : Set the link layer address of the tap devi=
ce=2E\n"
     "--topology t    : Set --dev tun topology: 'net30', 'p2p', or=
 'subnet'=2E\n"
@@ -4464,6 +4467,11 @@
     {
         options->disable_dco=
 =3D true;
     }
+    else if (streq(p[0], "disable-rps") && !p[1])
+    {=

+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->disable_rps =
=3D true;
+    }
     else if (streq(p[0], "dev-node") && p[1] && !p[2])
  =
   {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh
index c58530a=2E=2Eb88ccd6 100644
--- a=
/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -372,6 +372,8 @@
=
     /* DCO is disabled and should not be used as backend driver for the
  =
    * tun/tap device */
     bool disable_dco;
+    /* Do not automatically=
 enable RPS on Linux DCO interfaces */
+    bool disable_rps;
 
     /* Mis=
c parms */
     const char *username;
diff --git a/src/openvpn/options_show=
=2Ec b/src/openvpn/options_show=2Ec
index 80d36f0=2E=2E4d01f28 100644
--- a=
/src/openvpn/options_show=2Ec
+++ b/src/openvpn/options_show=2Ec
@@ -375,6 =
+375,7 @@
 #if defined(ENABLE_DCO)
     SHOW_BOOL(disable_dco);
 #endif
+  =
  SHOW_BOOL(disable_rps);
     SHOW_STR(lladdr);
     SHOW_INT(topology);
 =
    SHOW_STR(ifconfig_local);

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1991?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
Gerrit-Change-Num=
ber: 1991
Gerrit-PatchSet: 3
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>=

Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <=
antonio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>

--x0FpCBbHcV8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Ralf Lici =
<strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a>=
</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">dco_linux: enable RPS on newly created DCO interfaces<br>=
<br>When multiple TCP streams share an OpenVPN tunnel, their ACKs arrive<br=
>through the same outer flow and can be processed on a single NIC RX CPU=2E=
<br>Delivering the decrypted ACKs can also drain TCP transmit queues inline=
,<br>concentrating receive processing, transmission and crypto work on that=
<br>CPU despite the parallelism available between inner flows=2E<br><br>Ena=
ble Receive Packet Steering (RPS) on newly created DCO interfaces to<br>dis=
tribute inner flow processing across CPUs, after decryption=2E Build a<br>m=
ask covering all possible CPU IDs and let the kernel filter out offline<br>=
CPUs=2E<br><br>Add --disable-rps to skip automatic RPS configuration=2E Doc=
ument the<br>option and the limitation that RPS may not be re-enabled if th=
e<br>interface is recreated after privileges have been dropped=2E<br><br>Le=
ave pre-existing interfaces and nonzero RPS masks unchanged, including<br>m=
asks inherited from net=2Ecore=2Erps_default_mask=2E Failure to configure R=
PS<br>is nonfatal=2E<br><br>Tested on a Ryzen 9 9950X with Fedora&#39;s sto=
ck ovpn module from kernel<br>7=2E2=2E5-200=2Efc44=2Ex86_64 and two Connect=
X-4 Lx ports were cabled at 25<br>Gb/s, The tunnel used IPv4/UDP, AES-256-G=
CM and MTU 1448=2E Values are<br>medians across three 20 seconds iperf3 run=
s, after a 3-second warmup:<br><br>flows    RPS off     RPS on      change<=
br>  1         9=2E01      12=2E06      +33=2E9%<br>  4         9=2E41     =
 16=2E90      +79=2E6%<br><br>At four streams, the sender NIC IRQ CPU&#39;s=
 average softirq utilization<br>was 98=2E7-99=2E5% off and 4=2E7-47=2E2% on=
=2E<br><br>Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0<br>Reported=
-By: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Signed-off-by: Ralf Lici &lt=
;ralf@mandelbit=2Ecom&gt;<br>---<br>M README=2Edco=2Emd<br>M doc/man-sectio=
ns/advanced-options=2Erst<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/o=
ptions=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/options_show=2Ec<b=
r>6 files changed, 184 insertions(+), 0 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/19=
91/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/README=2Edco=2Emd b/README=2Edco=2Emd</span><br><=
span>index a93dc94=2E=2E6ece2b7 100644</span><br><span>--- a/README=2Edco=
=2Emd</span><br><span>+++ b/README=2Edco=2Emd</span><br><span>@@ -52,6 +52,=
20 @@</span><br><span> </span><br><span> in your log=2E</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+On Linux, OpenVPN ena=
bles Receive Packet Steering (RPS) on DCO interfaces it</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+creates, distributing inner-flow proces=
sing across online CPUs=2E Use</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+`--disable-rps` to opt out of this automatic configuration if it=
s overhead</span><br><span style=3D"color: hsl(120, 100%, 40%);">+outweighs=
 the performance benefit on your system=2E Pre-existing interfaces and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+nonzero RPS masks (inclu=
ding masks inherited from `net=2Ecore=2Erps_default_mask`)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+are preserved and `--disable-rps` do=
es not clear administrator-configured masks=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+RPS is configured before OpenVPN drops privileges during initial se=
tup=2E If the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+interf=
ace is recreated after dropping privileges, for example when pulled</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+options change on reconnect=
, OpenVPN may be unable to re-enable RPS because the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sysfs file is not writable by the new use=
r=2E This failure is logged and is</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+nonfatal=2E `--persist-tun` normally preserves the interface=
 and its RPS mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ut changes to certain pulled options can still force recreation=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br=
><span> Getting started (Windows)</span><br><span> ------------------------=
-</span><br><span>diff --git a/doc/man-sections/advanced-options=2Erst b/do=
c/man-sections/advanced-options=2Erst</span><br><span>index 32008d5=2E=2E65=
81657 100644</span><br><span>--- a/doc/man-sections/advanced-options=2Erst<=
/span><br><span>+++ b/doc/man-sections/advanced-options=2Erst</span><br><sp=
an>@@ -115,3 +115,17 @@</span><br><span>   is enabled=2E</span><br><span> <=
/span><br><span>   On platforms that do not support DCO ``disable-dco`` has=
 no effect=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+--disable-rps</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  Do not automatically enable R=
eceive Packet Steering (RPS) on newly created</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  Linux DCO interfaces=2E This option is local an=
d cannot be pushed by a server=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  It is accepted on all platforms, but has no effect outside =
Linux DCO=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  By default, OpenVPN enab=
les RPS to distribute inner-flow processing across</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  online CPUs=2E This can improve throughput=
, but the additional processing</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  overhead may outweigh the benefit on some systems or workload=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--disable-r=
ps`` skips this automatic configuration=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  Pre-existing interfaces and nonzero RPS masks, including masks inheri=
ted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  from ``net=2Ec=
ore=2Erps_default_mask``, are left unchanged even without</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  ``--disable-rps``=2E</span><br><spa=
n>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span>=
<br><span>index e9cf0b7=2E=2E8c2f666 100644</span><br><span>--- a/src/openv=
pn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br>=
<span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;buffer=2Eh&quot;</s=
pan><br><span> #include &quot;networking=2Eh&quot;</span><br><span> #includ=
e &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;options_util=2Eh&quot;</span><br><span> </span><br><sp=
an> #include &quot;socket=2Eh&quot;</span><br><span> #include &quot;tun=2Eh=
&quot;</span><br><span>@@ -553,6 +554,145 @@</span><br><span>     return &q=
uot;unknown&quot;;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Build an RPS mask covering all possible CPU IDs=2E T=
he kernel filters out</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * offline CPUs when installing the mask, so only the last ID in the sort=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sysfs CPU list=
 is needed, even when the list has gaps=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Removes the trailing newline from cpus before par=
sing the last ID=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_rps_mask_full(char =
*cpus, struct buffer *mask)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the=
 cpus string contains range formats like &quot;0-31&quot; or &quot;0-15,32-=
47&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size=
_t len =3D strspn(cpus, &quot;0123456789,-&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!len || cpus[len] !=3D &#39;\n&#39; =
|| cpus[len + 1] !=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* walk backwards over th=
e trailing digits to find the beginning of the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * last number, stopping at a separator or t=
he beginning of the string</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *last =3D cpus + len;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    while (last &gt; cpus &amp;&amp; last[-1] &gt;=3D &#39;0&#3=
9; &amp;&amp; last[-1] &lt;=3D &#39;9&#39;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        --last;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
last =3D=3D cpus + len)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cpus[len] =3D &#39;\0&#39;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int last_cpu;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!atoi_constrained(last,=
 &amp;last_cpu, &quot;last possible CPU&quot;, 0, INT_MAX, M_WARN))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* the most significant group may contain fewer than 32 bits */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int word =
=3D UINT32_MAX &gt;&gt; (31 - last_cpu % 32);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* first handle the most significant, potenti=
ally partial group */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!buf_printf(mask, &quot;%x&quot;, word))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* then write the other chunks, comma-separated as required by bit=
map_parse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in =
linux/lib/bitmap-str=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (int i =3D last_cpu / 32; i &gt; 0; --i)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!buf_printf(mask, &quot;,ffffffff&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return buf_printf(mask, &quot;\n&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn=
_enable_rps(const char *dev)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char =
rps_path[PATH_MAX];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* ovpn interfaces have a single RX queue */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!checked_snprintf(rps_path, sizeof(rps=
_path),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
              &quot;/sys/class/net/%s/queues/rx-0/rps_cpus&quot;, dev))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DCO: cannot=
 build RPS path for %s&quot;, dev);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer current =3D buffer_read_from_file(rps_path, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* buffer_read_from_fil=
e counts the terminating NUL as content */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_rmtail(&amp;current, &#39;\0&#39;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_defined(&amp;cu=
rrent) || BLEN(&amp;current) &lt; 2 || *BLAST(&amp;current) !=3D &#39;\n&#3=
9;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* RPS may be unavaila=
ble, for example with CONFIG_RPS disabled */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;DCO: cannot read RP=
S mask from %s&quot;, rps_path);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (strspn(BSTR(&amp;current), &quot;0,&quot;) !=3D (size_t)BLEN(&amp;curr=
ent) - 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* new devices c=
an still inherit an administrator&#39;s rps_default_mask */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;DCO:=
 preserving existing RPS mask in %s: %=2E*s&quot;, rps_path,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            BLEN(&amp;current) - 1=
, BSTR(&amp;current));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *cpus_path =3D &q=
uot;/sys/devices/system/cpu/possible&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer cpus =3D buffer_read_from_file(cp=
us_path, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!buf_defined(&amp;cpus))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(M_WARN, &quot;DCO: cannot read possible CPUs from %s&quot;, cpus_=
path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer mask =3D alloc_buf_gc(4096, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ovp=
n_rps_mask_full(BSTR(&amp;cpus), &amp;mask))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msg(M_WARN, &quot;DCO: cannot build RPS mask from %s&quo=
t;, cpus_path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* recreating the interface after d=
ropping privileges may leave us unable</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * to open this root-owned file, even with CAP_NET_A=
DMIN retained</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int fd =3D ope=
n(rps_path, O_WRONLY);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (fd &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_WARN | M_ERRNO, &quot;DCO: cannot open %s for enabling RPS&quot;, rps_pat=
h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* submit the complete mask =
in one write and retry only on interruption */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ssize_t written;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    do</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        written =3D write(fd, BPTR(&amp;mask), (size_t)BLEN(&amp;mask));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } while (written =
&lt; 0 &amp;&amp; errno =3D=3D EINTR);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (written &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_WARN | M_ERRNO, &quot;DCO: cannot enable RPS on %s&quot;, dev);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (written !=3D BLEN(&amp;mask)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DCO: i=
ncomplete RPS mask write to %s&quot;, rps_path);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_DCO, &quot;DCO: RPS enabled on %s with CPU mask %=2E*s&quot;, dev, BLEN=
(&amp;mask) - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         BSTR(&amp;mask));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(close(fd) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_W=
ARN | M_ERRNO, &quot;DCO: cannot close %s&quot;, rps_path);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</s=
pan><br><span> open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, cons=
t char *dev)</span><br><span> {</span><br><span>@@ -584,6 +724,11 @@</span>=
<br><span>             return -EINVAL;</span><br><span>         }</span><br=
><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 configure RPS only on newly created devices unless explicitly disabled */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D 0=
 &amp;&amp; !tt-&gt;dco=2Ec-&gt;options=2Edisable_rps)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ovpn_enable_rps(dev);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>    =
 tt-&gt;dco=2Eifindex =3D if_nametoindex(dev);</span><br><span>     if (!tt=
-&gt;dco=2Eifindex)</span><br><span>diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec</span><br><span>index 8e0c602=2E=2E62e21d5 100644</=
span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/open=
vpn/options=2Ec</span><br><span>@@ -207,6 +207,9 @@</span><br><span>     &q=
uot;                  /dev/net/tun, /dev/tun, /dev/tap, etc=2E\n&quot;</spa=
n><br><span> #if defined(ENABLE_DCO)</span><br><span>     &quot;--disable-d=
co   : Do not attempt using Data Channel Offload=2E\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_LINUX</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;--disable-rps   : Do not =
automatically enable Receive Packet Steering on DCO interfaces=2E\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n> #endif</span><br><span>     &quot;--lladdr hw     : Set the link layer a=
ddress of the tap device=2E\n&quot;</span><br><span>     &quot;--topology t=
    : Set --dev tun topology: &#39;net30&#39;, &#39;p2p&#39;, or &#39;subne=
t&#39;=2E\n&quot;</span><br><span>@@ -4464,6 +4467,11 @@</span><br><span>  =
   {</span><br><span>         options-&gt;disable_dco =3D true;</span><br><=
span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (streq(p[0], &quot;disable-rps&quot;) &amp;&amp; !p[1])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;disable=
_rps =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span>     else if (streq(p[0], &quot;dev-node&quot;) &amp;&amp;=
 p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VER=
IFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn/opt=
ions=2Eh b/src/openvpn/options=2Eh</span><br><span>index c58530a=2E=2Eb88cc=
d6 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++=
 b/src/openvpn/options=2Eh</span><br><span>@@ -372,6 +372,8 @@</span><br><s=
pan>     /* DCO is disabled and should not be used as backend driver for th=
e</span><br><span>      * tun/tap device */</span><br><span>     bool disab=
le_dco;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Do no=
t automatically enable RPS on Linux DCO interfaces */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool disable_rps;</span><br><span> </=
span><br><span>     /* Misc parms */</span><br><span>     const char *usern=
ame;</span><br><span>diff --git a/src/openvpn/options_show=2Ec b/src/openvp=
n/options_show=2Ec</span><br><span>index 80d36f0=2E=2E4d01f28 100644</span>=
<br><span>--- a/src/openvpn/options_show=2Ec</span><br><span>+++ b/src/open=
vpn/options_show=2Ec</span><br><span>@@ -375,6 +375,7 @@</span><br><span> #=
if defined(ENABLE_DCO)</span><br><span>     SHOW_BOOL(disable_dco);</span><=
br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_BOOL(disable_rps);</span><br><span>     SHOW_STR(lladdr);</span><br><=
span>     SHOW_INT(topology);</span><br><span>     SHOW_STR(ifconfig_local)=
;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1991?usp=3Demail">change 1991</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I97c55e211f9113d090808724ab43c=
b3c94099fb0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1991 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartu=
lli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bo=
dy></html>
--x0FpCBbHcV8=--


--===============2073737894522920099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2073737894522920099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2073737894522920099==--

