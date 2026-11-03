Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F7606A329
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BT3GiC1M;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mWftWMqj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BepqkAyg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SlHYySdB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dl6KWi3pvT0o+2061RPn9JQ+9AheVZ4WaFPHZUjA0MY=; b=BT3GiC1M+IurxD8sDXxFSEYXr9
	RLrQ2dV3AWjVfEVql7Z5ZSCqvoMJMfM+RZBwZBcM/2cmwWIIo9zkZ4gNEMsUytOfi09ysr3qYlBaE
	zgpSdn6CA7o9/hMcm+zoa02z6dvz8mMkN9C9llY0ADiogykbe4YlnpevFlDIfEKYUoyE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOEWX-00000000361-3XwG;
	Tue, 03 Nov 2026 13:26:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOEWX-0000000035v-0R17
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JZnm/BNp6bT/SZgnIQ3+jlBl6XZv3WlnAClek6E7eTU=; b=mWftWMqjykc+WPe76N/M+LFhAI
 xu+4WNQfU4hGhrBwh2OPjoSu7E3lpY+gKbCKgYWtSWbsKj5ZZq+N9r+gojA9hN4pxjG5LpD/kVs35
 otHYF8voKIqYhV/Qk5nLkOKCY7qJJIkBWQIFKoEZQWWISl3vB2ttMXbl7SGhc50qjbuM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JZnm/BNp6bT/SZgnIQ3+jlBl6XZv3WlnAClek6E7eTU=; b=BepqkAygn8qnX0HfbNXu9czuhD
 Eo0ooRDlflpXraQ5jb5n/RrBR/2Q4sf4MVqEDs/0tEPYZMrPPzEPg42z/doZ2JtoHADLCen8PC0rF
 xOUoF9VI9RP2+sF+QdV/Pdvf2tClsOrKje39jIAYcJ6i5pwkIfxhe2k+6g2pBNH+SuH4=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOEWV-000000004vU-0AiN for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:26:01 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so33402865e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793712352; x=1794317152; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JZnm/BNp6bT/SZgnIQ3+jlBl6XZv3WlnAClek6E7eTU=;
 b=SlHYySdBC7zswI53q+Ps0IWyIHwqd3btZz+1ePkcQu7Z0a3Kmcy5y3InbPpFf3sfCg
 juyoWQSQptjc5mefHwiX1RRgFDBtJToCfFxOjFZhZhgW0GG4lejIsKiOGYF5ATIxtYKs
 c9wMUY7vNs/NMBcSGhj/nR3CeIiyjUhZFQ7ve9pBTlFydworiQUZ9Yc9Dsua6XkrOR19
 EtPy9bABDQV9mUwDG1EMvF9R3VFbpisXtAp7imzSn3eJYZEyxq0MWGW0L+iVDHuTYP/N
 ZY0HumaAZ+Fu2aJcCBOJp/0dt3B1wE/soexsojAXv6KH2Y+YXUY+gh1h/aXnU0G2TRmG
 3JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712352; x=1794317152;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JZnm/BNp6bT/SZgnIQ3+jlBl6XZv3WlnAClek6E7eTU=;
 b=s57EujfsexfVHzIHJcFuu6sQRWYPlXTrJAqM54KZV7ex6PoganraFJmLJhGkckV03J
 gChVgJ9oPqwRQ1DAW9s2oRMszhPu0G+kH/45Lm3lZCQfDgpkCJ7QxfZeWaJxBVdAz/7f
 Mge7HpJganzZw5IzJ2Iqu/2dvCIapJQ6fIEgRJsH1IryBitvR5dP2QS4Jec0nEvLDIqb
 ERZ+Z5j8Ut/13wSeqDN17h3BleDzjwHqMM4cXXxlctJKnmBLBqKI/2dRv54ylz3AWFOR
 omjvU7Z9zjDKX0ZnDFt+8eJiXENbOObnoQ8lTM1wPuZ8pwaH7qpKGQog92XyQimQu48c
 kKcg==
X-Gm-Message-State: APuU4Z9Zj5ktLmVCDzBeT5jVaQCdDMwP99Yrtepz77WyVIoFE4rrxYmW
 ub+QIRPiyy6cB/mFFv+ukARDcnlbG9dg7pqMeQOYU8lqRaK+aBvVgt6F9kFtovsTOpVXLiVPPCW
 IYL3WBDRirVtlYadfNkv16i/yXDpVINaO+jU4OMV+OKBco8157RSthfwViC4x51z83syR
X-Gm-Gg: AYBFou3gPOKH4VMVx2ZGEILlOECIWfX/7vR81WrwEX71wlcRYBG4QMQwlcIvDqmj2lw
 xM6wKZzhIYLx6uBUhVaZJUVSNYGML7efl4W65BGXuja+yCjVI92HsxKZ9ckRA/rmTJnBvIR8XWC
 CaBNFQxOl9sDDUuPcbVvAjMgqi2QJd46Nd1ATkQCyDbTlLNDN1qJWR70j0ivcgxjxuhLUqnn14d
 hwT70Y4/wASOtnmch+FbU5oNXEpsbX2wNAHnL12GFQKK2RogkTTcdaloa6y/7uYyRMGEZHkYp6U
 z7vaqsGQcvQsDuiKPqGGfknjK/zIG7wVwCCACJxfbBw1sAomS0a1KoK5Q/RgjjYF9AwAi1YP1gz
 ycFfXL5GL71DGogodlQkoixB4Y1+G43eUEqmL0fo0oBe/sdwhLb/4FU0yRhIOYTccb6+IwQdPz7
 UbilbcVP84wlj2wMwaYrqAifWJdvI4IuFBOLI5Z+Hh4Yir3zNqr0NEMDC+0etuSqXMJ1wEQVcxx
 yTeab1emHKrAwBHCVg6XJWzYAuJEHfGOuQtCozDLu28hzkrg5KTklOC+puNVCiBMm6UcfxzOWbm
 heeLuTdMHv9BGghAS6PlXX7jhx+b652K7lYC91YU4XhWcXgu+sRRsQJEqviSg2iWstnEpHautfI
 G7H+bdmvd1o9Xj9DV1lfddeLChwDmeEKer5h0fJC4gu4f99toP6ZaC3lb7TLuVVvj6jlWSXL+Zc
 hlaYAyc/HXv0x9GA==
X-Received: by 2002:a05:600c:628d:b0:4a2:397:73e9 with SMTP id
 5b1f17b1804b1-4ac17d1995amr301941665e9.18.1793712352077; 
 Tue, 03 Nov 2026 05:25:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9bd5d2fsm51696555e9.14.2026.11.03.05.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:25:51 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 13:25:47 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: d6770048b77488747e40f67058e821c6ea13337f
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dd1ddd99456aca7d4ef5c821f11343e68e9fb64a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOEWV-000000004vU-0AiN
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
Content-Type: multipart/mixed; boundary="===============3242926364190913214=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3242926364190913214==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XnI6lvWzgXc="; charset=UTF-8

--XnI6lvWzgXc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

H=
ello Antonio Quartulli, Arne Schwabe, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=
=3Demail

to look at the new patch set (#2)=2E

The following approvals got=
 outdated and were removed:
Code-Review-1 by Antonio Quartulli


Change sub=
ject: dco_linux: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux: enable RPS on new=
ly created DCO interfaces

When multiple TCP streams share an OpenVPN tunne=
l, their ACKs arrive
through the same outer flow and can be processed on a =
single NIC RX CPU=2E
Delivering the decrypted ACKs can also drain TCP trans=
mit queues inline,
concentrating receive processing, transmission and crypt=
o work on that
CPU despite the parallelism available between inner flows=2E=


Enable Receive Packet Steering (RPS) on newly created DCO interfaces to
d=
istribute inner flow processing across CPUs, after decryption=2E Build a
ma=
sk covering all possible CPU IDs and let the kernel filter out offline
CPUs=
=2E

Add --rps-off to skip automatic RPS configuration=2E Document the opti=
on
and the limitation that RPS may not be re-enabled if the interface is
re=
created after privileges have been dropped=2E

Leave pre-existing interface=
s and nonzero RPS masks unchanged, including
masks inherited from net=2Ecor=
e=2Erps_default_mask=2E Failure to configure RPS
is nonfatal=2E

Tested on =
a Ryzen 9 9950X with Fedora's stock ovpn module from kernel
7=2E2=2E5-200=
=2Efc44=2Ex86_64 and two ConnectX-4 Lx ports were cabled at 25
Gb/s, The tu=
nnel used IPv4/UDP, AES-256-GCM and MTU 1448=2E Values are
medians across t=
hree 20 seconds iperf3 runs, after a 3-second warmup:

flows    RPS off    =
 RPS on      change
  1         9=2E01      12=2E06      +33=2E9%
  4      =
   9=2E41      16=2E90      +79=2E6%

At four streams, the sender NIC IRQ C=
PU's average softirq utilization
was 98=2E7-99=2E5% off and 4=2E7-47=2E2% o=
n=2E

Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
Reported-By: Lev=
 Stipakov <lev@openvpn=2Enet>
Signed-off-by: Ralf Lici <ralf@mandelbit=2Eco=
m>
---
M README=2Edco=2Emd
M doc/man-sections/advanced-options=2Erst
M src/=
openvpn/dco_linux=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M=
 src/openvpn/options_show=2Ec
6 files changed, 182 insertions(+), 0 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
91/1991/2

diff --git a/README=2Edco=2Emd b/README=2Edco=2Emd
index a93dc94=
=2E=2Eb530cbc 100644
--- a/README=2Edco=2Emd
+++ b/README=2Edco=2Emd
@@ -52=
,6 +52,20 @@
 
 in your log=2E
 
+On Linux, OpenVPN enables Receive Packet =
Steering (RPS) on DCO interfaces it
+creates, distributing inner-flow proce=
ssing across online CPUs=2E Use `--rps-off`
+to opt out of this automatic c=
onfiguration if its overhead outweighs the
+performance benefit on your sys=
tem=2E Pre-existing interfaces and nonzero RPS
+masks (including masks inhe=
rited from `net=2Ecore=2Erps_default_mask`) are
+preserved and `--rps-off` =
does not clear administrator-configured masks=2E
+
+RPS is configured befor=
e OpenVPN drops privileges during initial setup=2E If the
+interface is rec=
reated after dropping privileges, for example when pulled
+options change o=
n reconnect, OpenVPN may be unable to re-enable RPS because the
+sysfs file=
 is not writable by the new user=2E This failure is logged and is
+nonfatal=
=2E `--persist-tun` normally preserves the interface and its RPS mask,
+but=
 changes to certain pulled options can still force recreation=2E
+
 
 Getti=
ng started (Windows)
 -------------------------
diff --git a/doc/man-sectio=
ns/advanced-options=2Erst b/doc/man-sections/advanced-options=2Erst
index 3=
2008d5=2E=2Efa210e6 100644
--- a/doc/man-sections/advanced-options=2Erst
++=
+ b/doc/man-sections/advanced-options=2Erst
@@ -115,3 +115,17 @@
   is enab=
led=2E
 
   On platforms that do not support DCO ``disable-dco`` has no eff=
ect=2E
+
+--rps-off
+  Do not automatically enable Receive Packet Steering =
(RPS) on newly created
+  Linux DCO interfaces=2E This option is local and =
cannot be pushed by a server=2E
+  It is accepted on all platforms, but has=
 no effect outside Linux DCO=2E
+
+  By default, OpenVPN enables RPS to dis=
tribute inner-flow processing across
+  online CPUs=2E This can improve thr=
oughput, but the additional processing
+  overhead may outweigh the benefit=
 on some systems or workloads=2E
+  ``--rps-off`` skips this automatic conf=
iguration=2E
+
+  Pre-existing interfaces and nonzero RPS masks, including =
masks inherited
+  from ``net=2Ecore=2Erps_default_mask``, are left unchang=
ed even without
+  ``--rps-off``=2E
diff --git a/src/openvpn/dco_linux=2Ec =
b/src/openvpn/dco_linux=2Ec
index e9cf0b7=2E=2Ecd482ba 100644
--- a/src/ope=
nvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -33,6 +33,7 @@
 #incl=
ude "buffer=2Eh"
 #include "networking=2Eh"
 #include "openvpn=2Eh"
+#inclu=
de "options_util=2Eh"
 
 #include "socket=2Eh"
 #include "tun=2Eh"
@@ -553,=
6 +554,145 @@
     return "unknown";
 }
 
+/**
+ * Build an RPS mask coveri=
ng all possible CPU IDs=2E The kernel filters out
+ * offline CPUs when ins=
talling the mask, so only the last ID in the sorted
+ * sysfs CPU list is n=
eeded, even when the list has gaps=2E
+ * Removes the trailing newline from=
 cpus before parsing the last ID=2E
+ */
+static bool
+ovpn_rps_mask_full(c=
har *cpus, struct buffer *mask)
+{
+    /* the cpus string contains range f=
ormats like "0-31" or "0-15,32-47" */
+    size_t len =3D strspn(cpus, "012=
3456789,-");
+    if (!len || cpus[len] !=3D '\n' || cpus[len + 1] !=3D '\0=
')
+    {
+        return false;
+    }
+
+    /* walk backwards over the t=
railing digits to find the beginning of the
+     * last number, stopping a=
t a separator or the beginning of the string
+     */
+    const char *last=
 =3D cpus + len;
+    while (last > cpus && last[-1] >=3D '0' && last[-1] <=
=3D '9')
+    {
+        --last;
+    }
+    if (last =3D=3D cpus + len)
+ =
   {
+        return false;
+    }
+
+    cpus[len] =3D '\0';
+    int last=
_cpu;
+    if (!atoi_constrained(last, &last_cpu, "last possible CPU", 0, I=
NT_MAX, M_WARN))
+    {
+        return false;
+    }
+
+    /* the most si=
gnificant group may contain fewer than 32 bits */
+    unsigned int word =
=3D UINT32_MAX >> (31 - last_cpu % 32);
+    /* first handle the most signi=
ficant, potentially partial group */
+    if (!buf_printf(mask, "%x", word)=
)
+    {
+        return false;
+    }
+    /* then write the other chunks,=
 comma-separated as required by bitmap_parse
+     * in linux/lib/bitmap-st=
r=2Ec
+     */
+    for (int i =3D last_cpu / 32; i > 0; --i)
+    {
+     =
   if (!buf_printf(mask, ",ffffffff"))
+        {
+            return false=
;
+        }
+    }
+    return buf_printf(mask, "\n");
+}
+
+static void
+=
ovpn_enable_rps(const char *dev)
+{
+    char rps_path[PATH_MAX];
+    /* o=
vpn interfaces have a single RX queue */
+    if (!checked_snprintf(rps_pat=
h, sizeof(rps_path),
+                          "/sys/class/net/%s/queues/r=
x-0/rps_cpus", dev))
+    {
+        msg(M_WARN, "DCO: cannot build RPS pat=
h for %s", dev);
+        return;
+    }
+
+    struct gc_arena gc =3D gc_n=
ew();
+    struct buffer current =3D buffer_read_from_file(rps_path, &gc);
=
+    /* buffer_read_from_file counts the terminating NUL as content */
+   =
 buf_rmtail(&current, '\0');
+    if (!buf_defined(&current) || BLEN(&curre=
nt) < 2 || *BLAST(&current) !=3D '\n')
+    {
+        /* RPS may be unavai=
lable, for example with CONFIG_RPS disabled */
+        msg(D_DCO_DEBUG, "D=
CO: cannot read RPS mask from %s", rps_path);
+        goto out;
+    }
+  =
  if (strspn(BSTR(&current), "0,") !=3D (size_t)BLEN(&current) - 1)
+    {
=
+        /* new devices can still inherit an administrator's rps_default_ma=
sk */
+        msg(D_DCO_DEBUG, "DCO: preserving existing RPS mask in %s: %=
=2E*s", rps_path,
+            BLEN(&current) - 1, BSTR(&current));
+      =
  goto out;
+    }
+
+    const char *cpus_path =3D "/sys/devices/system/cp=
u/possible";
+    struct buffer cpus =3D buffer_read_from_file(cpus_path, &=
gc);
+    if (!buf_defined(&cpus))
+    {
+        msg(M_WARN, "DCO: cannot=
 read possible CPUs from %s", cpus_path);
+        goto out;
+    }
+
+    =
struct buffer mask =3D alloc_buf_gc(4096, &gc);
+    if (!ovpn_rps_mask_ful=
l(BSTR(&cpus), &mask))
+    {
+        msg(M_WARN, "DCO: cannot build RPS m=
ask from %s", cpus_path);
+        goto out;
+    }
+
+    /* recreating th=
e interface after dropping privileges may leave us unable
+     * to open t=
his root-owned file, even with CAP_NET_ADMIN retained
+     */
+    int fd =
=3D open(rps_path, O_WRONLY);
+    if (fd < 0)
+    {
+        msg(M_WARN |=
 M_ERRNO, "DCO: cannot open %s for enabling RPS", rps_path);
+        goto =
out;
+    }
+    /* submit the complete mask in one write and retry only on=
 interruption */
+    ssize_t written;
+    do
+    {
+        written =3D =
write(fd, BPTR(&mask), (size_t)BLEN(&mask));
+    } while (written < 0 && e=
rrno =3D=3D EINTR);
+
+    if (written < 0)
+    {
+        msg(M_WARN | M_=
ERRNO, "DCO: cannot enable RPS on %s", dev);
+    }
+    else if (written !=
=3D BLEN(&mask))
+    {
+        msg(M_WARN, "DCO: incomplete RPS mask writ=
e to %s", rps_path);
+    }
+    else
+    {
+        msg(D_DCO, "DCO: RPS =
enabled on %s with CPU mask %=2E*s", dev, BLEN(&mask) - 1,
+            BST=
R(&mask));
+    }
+    if (close(fd) < 0)
+    {
+        msg(M_WARN | M_ER=
RNO, "DCO: cannot close %s", rps_path);
+    }
+
+out:
+    gc_free(&gc);
+=
}
+
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const cha=
r *dev)
 {
@@ -584,6 +724,11 @@
             return -EINVAL;
         }
   =
  }
+    /* configure RPS only on newly created devices unless explicitly d=
isabled */
+    if (ret =3D=3D 0 && !tt->dco=2Ec->options=2Erps_off)
+    {=

+        ovpn_enable_rps(dev);
+    }
 
     tt->dco=2Eifindex =3D if_name=
toindex(dev);
     if (!tt->dco=2Eifindex)
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 8e0c602=2E=2E0352b42 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -208,6 +208,7 @@
 #if =
defined(ENABLE_DCO)
     "--disable-dco   : Do not attempt using Data Chann=
el Offload=2E\n"
 #endif
+    "--rps-off       : Do not automatically enabl=
e Receive Packet Steering on DCO interfaces=2E\n"
     "--lladdr hw     : S=
et the link layer address of the tap device=2E\n"
     "--topology t    : S=
et --dev tun topology: 'net30', 'p2p', or 'subnet'=2E\n"
 #ifdef ENABLE_IPR=
OUTE
@@ -4464,6 +4465,11 @@
     {
         options->disable_dco =3D true;
=
     }
+    else if (streq(p[0], "rps-off") && !p[1])
+    {
+        VERIF=
Y_PERMISSION(OPT_P_GENERAL);
+        options->rps_off =3D true;
+    }
   =
  else if (streq(p[0], "dev-node") && p[1] && !p[2])
     {
         VERIFY=
_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options=2Eh b/src/open=
vpn/options=2Eh
index c58530a=2E=2E58b80cd 100644
--- a/src/openvpn/options=
=2Eh
+++ b/src/openvpn/options=2Eh
@@ -372,6 +372,8 @@
     /* DCO is disab=
led and should not be used as backend driver for the
      * tun/tap device=
 */
     bool disable_dco;
+    /* Do not automatically enable RPS on Linux=
 DCO interfaces */
+    bool rps_off;
 
     /* Misc parms */
     const ch=
ar *username;
diff --git a/src/openvpn/options_show=2Ec b/src/openvpn/optio=
ns_show=2Ec
index 80d36f0=2E=2Ec1120df 100644
--- a/src/openvpn/options_sho=
w=2Ec
+++ b/src/openvpn/options_show=2Ec
@@ -375,6 +375,7 @@
 #if defined(E=
NABLE_DCO)
     SHOW_BOOL(disable_dco);
 #endif
+    SHOW_BOOL(rps_off);
  =
   SHOW_STR(lladdr);
     SHOW_INT(topology);
     SHOW_STR(ifconfig_local)=
;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I97c55e211f=
9113d090808724ab43cb3c94099fb0
Gerrit-Change-Number: 1991
Gerrit-PatchSet: =
2
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Antonio Q=
uartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--XnI6lvWzgXc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Ralf Lici =
<strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a>=
</p><p>The following approvals got outdated and were removed:
Code-Review-1=
 by Antonio Quartulli</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">dco_linux: enable RPS on newly creat=
ed DCO interfaces<br><br>When multiple TCP streams share an OpenVPN tunnel,=
 their ACKs arrive<br>through the same outer flow and can be processed on a=
 single NIC RX CPU=2E<br>Delivering the decrypted ACKs can also drain TCP t=
ransmit queues inline,<br>concentrating receive processing, transmission an=
d crypto work on that<br>CPU despite the parallelism available between inne=
r flows=2E<br><br>Enable Receive Packet Steering (RPS) on newly created DCO=
 interfaces to<br>distribute inner flow processing across CPUs, after decry=
ption=2E Build a<br>mask covering all possible CPU IDs and let the kernel f=
ilter out offline<br>CPUs=2E<br><br>Add --rps-off to skip automatic RPS con=
figuration=2E Document the option<br>and the limitation that RPS may not be=
 re-enabled if the interface is<br>recreated after privileges have been dro=
pped=2E<br><br>Leave pre-existing interfaces and nonzero RPS masks unchange=
d, including<br>masks inherited from net=2Ecore=2Erps_default_mask=2E Failu=
re to configure RPS<br>is nonfatal=2E<br><br>Tested on a Ryzen 9 9950X with=
 Fedora&#39;s stock ovpn module from kernel<br>7=2E2=2E5-200=2Efc44=2Ex86_6=
4 and two ConnectX-4 Lx ports were cabled at 25<br>Gb/s, The tunnel used IP=
v4/UDP, AES-256-GCM and MTU 1448=2E Values are<br>medians across three 20 s=
econds iperf3 runs, after a 3-second warmup:<br><br>flows    RPS off     RP=
S on      change<br>  1         9=2E01      12=2E06      +33=2E9%<br>  4   =
      9=2E41      16=2E90      +79=2E6%<br><br>At four streams, the sender =
NIC IRQ CPU&#39;s average softirq utilization<br>was 98=2E7-99=2E5% off and=
 4=2E7-47=2E2% on=2E<br><br>Change-Id: I97c55e211f9113d090808724ab43cb3c940=
99fb0<br>Reported-By: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Signed-off-=
by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>---<br>M README=2Edco=2Emd<br=
>M doc/man-sections/advanced-options=2Erst<br>M src/openvpn/dco_linux=2Ec<b=
r>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/o=
ptions_show=2Ec<br>6 files changed, 182 insertions(+), 0 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/91/1991/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/README=2Edco=2Emd b/README=2Edco=
=2Emd</span><br><span>index a93dc94=2E=2Eb530cbc 100644</span><br><span>---=
 a/README=2Edco=2Emd</span><br><span>+++ b/README=2Edco=2Emd</span><br><spa=
n>@@ -52,6 +52,20 @@</span><br><span> </span><br><span> in your log=2E</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+On Lin=
ux, OpenVPN enables Receive Packet Steering (RPS) on DCO interfaces it</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+creates, distributing in=
ner-flow processing across online CPUs=2E Use `--rps-off`</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+to opt out of this automatic configur=
ation if its overhead outweighs the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+performance benefit on your system=2E Pre-existing interfac=
es and nonzero RPS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
asks (including masks inherited from `net=2Ecore=2Erps_default_mask`) are</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+preserved and `--rps-=
off` does not clear administrator-configured masks=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+RPS is configured before OpenVPN drops privileges during ini=
tial setup=2E If the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+interface is recreated after dropping privileges, for example when pulled<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+options change on re=
connect, OpenVPN may be unable to re-enable RPS because the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+sysfs file is not writable by the n=
ew user=2E This failure is logged and is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+nonfatal=2E `--persist-tun` normally preserves the int=
erface and its RPS mask,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+but changes to certain pulled options can still force recreation=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </sp=
an><br><span> Getting started (Windows)</span><br><span> ------------------=
-------</span><br><span>diff --git a/doc/man-sections/advanced-options=2Ers=
t b/doc/man-sections/advanced-options=2Erst</span><br><span>index 32008d5=
=2E=2Efa210e6 100644</span><br><span>--- a/doc/man-sections/advanced-option=
s=2Erst</span><br><span>+++ b/doc/man-sections/advanced-options=2Erst</span=
><br><span>@@ -115,3 +115,17 @@</span><br><span>   is enabled=2E</span><br>=
<span> </span><br><span>   On platforms that do not support DCO ``disable-d=
co`` has no effect=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--rps-off</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  Do not automatically enab=
le Receive Packet Steering (RPS) on newly created</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  Linux DCO interfaces=2E This option is loca=
l and cannot be pushed by a server=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  It is accepted on all platforms, but has no effect outs=
ide Linux DCO=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  By default, OpenVPN =
enables RPS to distribute inner-flow processing across</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  online CPUs=2E This can improve throug=
hput, but the additional processing</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  overhead may outweigh the benefit on some systems or work=
loads=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--rps-o=
ff`` skips this automatic configuration=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  Pre-existing interfaces and nonzero RPS masks, including masks inheri=
ted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  from ``net=2Ec=
ore=2Erps_default_mask``, are left unchanged even without</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  ``--rps-off``=2E</span><br><span>di=
ff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br>=
<span>index e9cf0b7=2E=2Ecd482ba 100644</span><br><span>--- a/src/openvpn/d=
co_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><spa=
n>@@ -33,6 +33,7 @@</span><br><span> #include &quot;buffer=2Eh&quot;</span>=
<br><span> #include &quot;networking=2Eh&quot;</span><br><span> #include &q=
uot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;options_util=2Eh&quot;</span><br><span> </span><br><span> =
#include &quot;socket=2Eh&quot;</span><br><span> #include &quot;tun=2Eh&quo=
t;</span><br><span>@@ -553,6 +554,145 @@</span><br><span>     return &quot;=
unknown&quot;;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Build an RPS mask covering all possible CPU IDs=2E The=
 kernel filters out</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * offline CPUs when installing the mask, so only the last ID in the sorted=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sysfs CPU list i=
s needed, even when the list has gaps=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Removes the trailing newline from cpus before parsi=
ng the last ID=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_rps_mask_full(char *c=
pus, struct buffer *mask)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the c=
pus string contains range formats like &quot;0-31&quot; or &quot;0-15,32-47=
&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t=
 len =3D strspn(cpus, &quot;0123456789,-&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!len || cpus[len] !=3D &#39;\n&#39; ||=
 cpus[len + 1] !=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* walk backwards over the =
trailing digits to find the beginning of the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * last number, stopping at a separator or the=
 beginning of the string</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *last =3D cpus + len;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    while (last &gt; cpus &amp;&amp; last[-1] &gt;=3D &#39;0&#39;=
 &amp;&amp; last[-1] &lt;=3D &#39;9&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        --last;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (la=
st =3D=3D cpus + len)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
 &amp;&amp; !tt-&gt;dco=2Ec-&gt;options=2Erps_off)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ovpn_enable_rps(dev);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     tt-=
&gt;dco=2Eifindex =3D if_nametoindex(dev);</span><br><span>     if (!tt-&gt=
;dco=2Eifindex)</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec</span><br><span>index 8e0c602=2E=2E0352b42 100644</span=
><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/=
options=2Ec</span><br><span>@@ -208,6 +208,7 @@</span><br><span> #if define=
d(ENABLE_DCO)</span><br><span>     &quot;--disable-dco   : Do not attempt u=
sing Data Channel Offload=2E\n&quot;</span><br><span> #endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;--rps-off       : Do not=
 automatically enable Receive Packet Steering on DCO interfaces=2E\n&quot;<=
/span><br><span>     &quot;--lladdr hw     : Set the link layer address of =
the tap device=2E\n&quot;</span><br><span>     &quot;--topology t    : Set =
--dev tun topology: &#39;net30&#39;, &#39;p2p&#39;, or &#39;subnet&#39;=2E\=
n&quot;</span><br><span> #ifdef ENABLE_IPROUTE</span><br><span>@@ -4464,6 +=
4465,11 @@</span><br><span>     {</span><br><span>         options-&gt;disa=
ble_dco =3D true;</span><br><span>     }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (streq(p[0], &quot;rps-off&quot;) &amp;&am=
p; !p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSIO=
N(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      options-&gt;rps_off =3D true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;dev-n=
ode&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><=
br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --=
git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>ind=
ex c58530a=2E=2E58b80cd 100644</span><br><span>--- a/src/openvpn/options=2E=
h</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -372,6 +=
372,8 @@</span><br><span>     /* DCO is disabled and should not be used as =
backend driver for the</span><br><span>      * tun/tap device */</span><br>=
<span>     bool disable_dco;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Do not automatically enable RPS on Linux DCO interfaces */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool rps_off;</s=
pan><br><span> </span><br><span>     /* Misc parms */</span><br><span>     =
const char *username;</span><br><span>diff --git a/src/openvpn/options_show=
=2Ec b/src/openvpn/options_show=2Ec</span><br><span>index 80d36f0=2E=2Ec112=
0df 100644</span><br><span>--- a/src/openvpn/options_show=2Ec</span><br><sp=
an>+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ -375,6 +375,7 @@</=
span><br><span> #if defined(ENABLE_DCO)</span><br><span>     SHOW_BOOL(disa=
ble_dco);</span><br><span> #endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_BOOL(rps_off);</span><br><span>     SHOW_STR(lladdr)=
;</span><br><span>     SHOW_INT(topology);</span><br><span>     SHOW_STR(if=
config_local);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">change 1991</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I97c55e211f9113d=
090808724ab43cb3c94099fb0 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1991 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartu=
lli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--XnI6lvWzgXc=--


--===============3242926364190913214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3242926364190913214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3242926364190913214==--

