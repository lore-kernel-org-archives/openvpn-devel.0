Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F057C5DF86
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4FLxNRnZ7qfw6iNfE0fa2QHk1UJUUMki6imvMvBDtLs=; b=RWGegOA3sEUvaBnu+uMgEMOmfT
	rSMmwiZWX+oRise/ntvYf1pp56CaCMLw4XG0ve7tifrZrEZn8y6TPnlbVEcEY+iLxDinlVI7n6jx5
	2HahHFYIpcnvDTczVK0NwuvZU5JSmKF9rRNQfx40sIUJlt4w0YhGHxYivV7mcVSwTPfM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx9bt-0006O4-TR;
	Thu, 20 Aug 2026 20:43:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx9br-0006Nv-Lj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 20:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VI9H8h/W1NLkV4J9L+f2uQnYTQhqjl3z0UQrCMsBsVE=; b=AfV0WkgewzNBC4wZTBm/bIIOWv
 exa54w0/YOzIn0NW5wlcBj1QeyW/E1dgzQdG0egCQT2lSiKWbIItZS/ZBOc5pqU3Pz6wyWRPcjWVX
 woGHhAE+KKJZlOmvxyp6vMRTz+d5lXlujRjhlBgmKHQUDhJ2nDn77rw4MaebZFle6vlo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VI9H8h/W1NLkV4J9L+f2uQnYTQhqjl3z0UQrCMsBsVE=; b=L
 O4Rh9D5/upOel1+mm7M/TnwhfuUQL4KpQqSt00CfeieRd1LGsqgQiBhXyWlJG8eKkqyofuc+CwByh
 sUxooQxAsLX7wwyK4OyTZK2hf4NGnjKtjDvqAImG2g9KmxLxa4JoxGnKgSpmMYnEgHjpQ5Df04oSv
 sNctZGP3olA0ZW/U=;
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx9bk-000586-5D for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 20:43:35 +0000
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so46874066b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787258601; x=1787863401; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VI9H8h/W1NLkV4J9L+f2uQnYTQhqjl3z0UQrCMsBsVE=;
 b=Rta80T9hF9IxxuSXi4tXw4keEUaoIEZLKI8J1tb1EzqP5RboOMNhwZeqwSwLEnboJF
 kj0ik4ycswIAb0aHlK+wZiz8ADD12ze3iw6a0c976IcH2NPFuYYARmRFMgyVFzNpf+wO
 8WLcH+IzSuR0AR0aRVzBefixGWfxl3ZB2fP8z7TDHPNVjEx63SZ1Q9MR7QsfdMPUDeyX
 HMHSTmknq23oYUePVpUgnHvv86Hp1UhSomdEHAgxB9gflfZU9yXOSTyjExWAV7HVdqtB
 he58PmvbQeZ+KcbrQSaVyIBqfmVpQhSBV2oAPvN97YwPc13CLyAtQlYsI8G8FDTQwbYu
 WRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787258601; x=1787863401;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VI9H8h/W1NLkV4J9L+f2uQnYTQhqjl3z0UQrCMsBsVE=;
 b=PGSx6z27Lw8/VQxh+1yHkfWPhKfyAxJGUAvuQAoHyWmI27Jfccf7NL0x/jw7LSVZQ7
 tn0G/O7Ro618yqohfayWBOYm/NWy5+FuTIX6tdz6ERhH0r68KJl2P3YYlDr+YFJi0zUa
 aWSOic2+OiuLx+5EerrBWDBlMkqAmEZxLPOjuoc0vx8RyO/YkHud0j3dG9nsttkQ3MI3
 fEF1TfdxIemGHLY4OhCdjdbxrNvdG1NutwtXL9YBve+4/FEPOFJ6M2Bkp8DYtbeqBagZ
 seJ55bNA+ZfCndcV+p7C2gsuBUk8NCwG/BnuMxPw5VmKoCILdvNXfXoeZaE/OPR7BEo8
 LL6w==
X-Gm-Message-State: AOJu0Yyu3XHmmcnY90B9hTyioAQGZUWU1ZvvUYXxhnzMirrYqkuw1HxV
 MKFOd5H8IVU8qre5o3WIYtSJzmPLMHqGc+LiIEz9+PVfIDLmSx3EK9slp1PkzUTrNM3jIyKdWsj
 YNxOKKriVpZgR9MwvOs6xsWdxa20p0AyIVxltRcnREM755u46DLeTXYsluMzY0eMiHMgW
X-Gm-Gg: AR+sD12V3Es2+VCOKIrfn2FUcVWVr2J0EfGhhdv7fBcKneN4e5oEy2K35LOQIGSGByU
 f7PZwG/x5o0j3/2XQXKdRL0jFDWkS2Rv3GlLm8ofxFIq9mcVzDKVT+pZi7vGlYxYqf4vT6NvYKu
 MqJd956hKJ8MwkPAjv1Xzm3Skle7imfoO/2+uuUW5A9229x5kK663MECKqGVqjz0huKusCXI3QR
 lAp9kd3dcNfBSaQU+feckwZIiforTh74OKesLdvIdi6KduX8FjflMBcmUfeq6sxqHfSoqI60jQ4
 cqoqMgEZlpCrTXTwOaDEm+OnaSukkJMw2Qo+4lTzW5pGvr/mTq6wTdiZ6boYF5uSkvVrryuJVne
 dgrnntsDj1rgw2o7ZONCPTub5v2HdNYYmwptHGfYyM2VGLhWlOUlZofL+J7RXGxU49e1np2bTPq
 DVv3w4n74ijX3kB8OQM1/WmT7BGldlPWC9d+PFmbq2bUXODnSGjCL01KJ4Hp34DHgmKZxOBrGxp
 VY1JEHzKLE12Vjt2IyLpB7FgJj0TFdcV2K9WOo4litVcPfbUvuh0oTrTPIlMIw1uQ0WGmtWX/sQ
 cVvmjSHu1CNAJK5B89MYpurY7A/BA5e2XRo1B0jP/8s0JyBJUgU=
X-Received: by 2002:a17:907:3d4b:b0:c15:f005:63fb with SMTP id
 a640c23a62f3a-c246a4a9facmr92134266b.3.1787258601008; 
 Thu, 20 Aug 2026 13:43:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589d98b0sm129706466b.6.2026.08.20.13.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:43:19 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 20:43:16 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: 3e8dfe34b01f4ea727ba4a0ce1cf3093087cf960
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <707e123d9b169ce8baa37db965f0aac84adf40ab-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx9bk-000586-5D
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 options_string code from options.c
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6521004719681835274=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6521004719681835274==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rHCAUQmc0ZQ="; charset=UTF-8

--rHCAUQmc0ZQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: options: Factor out options_string code from o=
ptions=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
ptions: Factor out options_string code from options=2Ec

options=2Ec is a h=
uge, unwieldly file=2E So remove some
closely related code that has no dire=
ct dependencies
with the other functions in the file=2E

This time it is th=
e functions related to the creation
and testing of the options string=2E

C=
hange-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
Signed-off-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773
Mess=
age-Id: <20260820124355=2E23332-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38563=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=
=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/init=2Ec
M src/openvpn/occ=
=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/openvpn/opti=
ons_string=2Ec
A src/openvpn/options_string=2Eh
M src/openvpn/ssl=2Ec
9 fil=
es changed, 532 insertions(+), 458 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/1773/6

diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt
index 8866520=2E=2E2c3324d 100644
--- a/CMakeL=
ists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -533,6 +533,8 @@
     src/openvpn/opti=
ons_parse=2Ec
     src/openvpn/options_show=2Ec
     src/openvpn/options_sh=
ow=2Eh
+    src/openvpn/options_string=2Ec
+    src/openvpn/options_string=
=2Eh
     src/openvpn/otime=2Ec
     src/openvpn/otime=2Eh
     src/openvpn=
/ovpn_dco_win=2Eh
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Make=
file=2Eam
index 42b4404=2E=2E7fd12b4 100644
--- a/src/openvpn/Makefile=2Eam=

+++ b/src/openvpn/Makefile=2Eam
@@ -110,6 +110,7 @@
 	openvpn=2Ec openvpn=
=2Eh \
 	options=2Ec options=2Eh \
 	options_show=2Ec options_show=2Eh \
+	=
options_string=2Ec options_string=2Eh \
 	options_util=2Ec options_util=2Eh=
 \
 	options_parse=2Ec \
 	otime=2Ec otime=2Eh \
diff --git a/src/openvpn/i=
nit=2Ec b/src/openvpn/init=2Ec
index a90fe69=2E=2Efa62cdd 100644
--- a/src/=
openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -54,6 +54,7 @@
 #include "dc=
o=2Eh"
 #include "tun_afunix=2Eh"
 #include "schedule=2Eh"
+#include "optio=
ns_string=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/occ=2Ec =
b/src/openvpn/occ=2Ec
index aa262a8=2E=2Ef25ae19 100644
--- a/src/openvpn/o=
cc=2Ec
+++ b/src/openvpn/occ=2Ec
@@ -29,7 +29,7 @@
 #include "occ=2Eh"
 #in=
clude "forward=2Eh"
 #include "memdbg=2Eh"
-
+#include "options_string=2Eh"=

 
 /*
  * This random string identifies an OpenVPN
diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec
index 391739c=2E=2E9bd6f01 100644
-=
-- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3363,436 +33=
63,6 @@
 }
 
 /*
- * Build an options string to represent data channel encr=
yption options=2E
- * This string must match exactly between peers=2E  The =
keysize is checked
- * separately by read_key()=2E
- *
- * The following op=
tions must match on both peers:
- *
- * Tunnel options:
- *
- * --dev tun|t=
ap [unit number need not match]
- * --dev-type tun|tap
- * --link-mtu
- * -=
-udp-mtu
- * --tun-mtu
- * --proto udp
- * --proto tcp-client [matched with=
 --proto tcp-server
- *                     on the other end of the connect=
ion]
- * --proto tcp-server [matched with --proto tcp-client on
- *        =
             the other end of the connection]
- * --tun-ipv6
- * --ifconfig=
 x y [matched with --ifconfig y x on
- *                 the other end of t=
he connection]
- *
- * --comp-lzo
- * --compress alg
- * --fragment
- *
- *=
 Crypto Options:
- *
- * --cipher
- * --auth
- * --secret
- *
- * SSL Optio=
ns:
- *
- * --tls-auth
- * --tls-client [matched with --tls-server on
- *  =
             the other end of the connection]
- * --tls-server [matched wit=
h --tls-client on
- *               the other end of the connection]
- */
-=
char *
-options_string(const struct options *o, const struct frame *frame, =
struct tuntap *tt,
-               openvpn_net_ctx_t *ctx, bool remote, str=
uct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf(OPTION_LINE_SIZE)=
;
-    bool tt_local =3D false;
-
-    buf_printf(&out, "V4");
-
-    /*
- =
    * Tunnel Options
-     */
-
-    buf_printf(&out, ",dev-type %s", dev_t=
ype_string(o->dev, o->dev_type));
-    /* the link-mtu that we send has onl=
y a meaning if have a fixed
-     * cipher (p2p) or have a fallback cipher =
configured for older non
-     * ncp clients=2E But not sending it will mak=
e even 2=2E4 complain
-     * about it being missing=2E So still send it=2E=
 */
-    buf_printf(&out, ",link-mtu %u", (unsigned int)calc_options_string=
_link_mtu(o, frame));
-
-    if (o->ce=2Eocc_mtu !=3D 0)
-    {
-        bu=
f_printf(&out, ",tun-mtu %d", o->ce=2Eocc_mtu);
-    }
-    else
-    {
-  =
      buf_printf(&out, ",tun-mtu %d", frame->tun_mtu);
-    }
-
-    buf_pr=
intf(&out, ",proto %s", proto_remote(o->ce=2Eproto, remote));
-
-    bool p=
2p_nopull =3D o->mode =3D=3D MODE_POINT_TO_POINT && !PULL_DEFINED(o);
-    =
/* send tun_ipv6 only in peer2peer mode - in client/server mode, it
-     *=
 is usually pushed by the server, triggering a non-helpful warning
-     */=

-    if (o->ifconfig_ipv6_local && p2p_nopull)
-    {
-        buf_printf(=
&out, ",tun-ipv6");
-    }
-
-    /*
-     * Try to get ifconfig parameters=
 into the options string=2E
-     * If tt is undefined, make a temporary in=
stantiation=2E
-     */
-    if (!tt)
-    {
-        tt =3D init_tun(o->de=
v, o->dev_type, o->topology, o->ifconfig_local,
-                      o->i=
fconfig_remote_netmask, o->ifconfig_ipv6_local, o->ifconfig_ipv6_netbits,
-=
                      o->ifconfig_ipv6_remote, NULL, NULL, false, NULL, ctx=
, NULL);
-        if (tt)
-        {
-            tt_local =3D true;
-     =
   }
-    }
-
-    if (tt && p2p_nopull)
-    {
-        const char *ios =
=3D ifconfig_options_string(tt, remote, o->ifconfig_nowarn, gc);
-        i=
f (ios && strlen(ios))
-        {
-            buf_printf(&out, ",ifconfig =
%s", ios);
-        }
-    }
-    if (tt_local)
-    {
-        free(tt);
-=
        tt =3D NULL;
-    }
-
-#ifdef USE_COMP
-    if (o->comp=2Ealg !=3D =
COMP_ALG_UNDEF)
-    {
-        buf_printf(&out, ",comp-lzo"); /* for compa=
tibility, this simply indicates that compression
-                         =
                 context is active, not necessarily LZO per-se */
-    }
-#=
endif
-
-#ifdef ENABLE_FRAGMENT
-    if (o->ce=2Efragment)
-    {
-        =
buf_printf(&out, ",mtu-dynamic");
-    }
-#endif
-
-#define TLS_CLIENT (o->=
tls_client)
-#define TLS_SERVER (o->tls_server)
-
-    /*
-     * Key direc=
tion
-     */
-    {
-        const char *kd =3D keydirection2ascii(o->key_=
direction, remote, false);
-        if (kd)
-        {
-            buf_pri=
ntf(&out, ",keydir %s", kd);
-        }
-    }
-
-    /*
-     * Crypto Opt=
ions
-     */
-    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVER)
-=
    {
-        struct key_type kt;
-
-        ASSERT((o->shared_secret_file=
 !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) <=3D 1);
=
-
-        /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
-=
         * to work here in the default configuration */
-        const char=
 *ciphername =3D o->ciphername;
-        size_t keysize =3D 0;
-
-        i=
f (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
-        {
-            init_k=
ey_type(&kt, "none", o->authname, true, false);
-            keysize =3D 12=
8;
-        }
-        else
-        {
-            init_key_type(&kt, o->c=
iphername, o->authname, true, false);
-            ciphername =3D cipher_kt=
_name(kt=2Ecipher);
-            if (cipher_defined(o->ciphername))
-      =
      {
-                keysize =3D cipher_kt_key_size(kt=2Ecipher) * 8;
-=
            }
-        }
-        /* Only announce the cipher to our peer i=
f we are willing to
-         * support it */
-        if (p2p_nopull || tl=
s_item_in_cipher_list(ciphername, o->ncp_ciphers))
-        {
-            =
buf_printf(&out, ",cipher %s", ciphername);
-        }
-        buf_printf(=
&out, ",auth %s", md_kt_name(kt=2Edigest));
-        buf_printf(&out, ",key=
size %zu", keysize);
-        if (o->shared_secret_file)
-        {
-      =
      buf_printf(&out, ",secret");
-        }
-    }
-
-    /*
-     * SSL =
Options
-     */
-    {
-        if (TLS_CLIENT || TLS_SERVER)
-        {
-=
            if (o->ce=2Etls_auth_file)
-            {
-                buf_=
printf(&out, ",tls-auth");
-            }
-            /* Not adding tls-cr=
ypt here, because we won't reach this code if
-             * tls-auth/tls-=
crypt does not match=2E  Removing tls-auth here would
-             * break=
 stuff, so leaving that in place=2E */
-
-            buf_printf(&out, ",ke=
y-method %d", KEY_METHOD_2);
-        }
-
-        if (remote)
-        {
-=
            if (TLS_CLIENT)
-            {
-                buf_printf(&out=
, ",tls-server");
-            }
-            else if (TLS_SERVER)
-       =
     {
-                buf_printf(&out, ",tls-client");
-            }
-  =
      }
-        else
-        {
-            if (TLS_CLIENT)
-            =
{
-                buf_printf(&out, ",tls-client");
-            }
-       =
     else if (TLS_SERVER)
-            {
-                buf_printf(&out, =
",tls-server");
-            }
-        }
-    }
-
-#undef TLS_CLIENT
-#und=
ef TLS_SERVER
-
-    return BSTR(&out);
-}
-
-/*
- * Compare option strings=
 for equality=2E
- * If the first two chars of the strings differ, it means=
 that
- * we are looking at different versions of the options string,
- * t=
herefore don't compare them and return true=2E
- */
-
-bool
-options_cmp_eq=
ual(char *actual, const char *expected)
-{
-    return options_cmp_equal_sa=
fe(actual, expected, strlen(actual) + 1);
-}
-
-void
-options_warning(char =
*actual, const char *expected)
-{
-    options_warning_safe(actual, expecte=
d, strlen(actual) + 1);
-}
-
-static const char *
-options_warning_extract_=
parm1(const char *option_string, struct gc_arena *gc_ret)
-{
-    struct gc=
_arena gc =3D gc_new();
-    struct buffer b =3D string_alloc_buf(option_st=
ring, &gc);
-    char *p =3D gc_malloc(OPTION_PARM_SIZE, false, &gc);
-    =
const char *ret;
-
-    buf_parse(&b, ' ', p, OPTION_PARM_SIZE);
-    ret =
=3D string_alloc(p, gc_ret);
-    gc_free(&gc);
-    return ret;
-}
-
-stat=
ic void
-options_warning_safe_scan2(const msglvl_t msglevel, const int deli=
m,
-                           const bool report_inconsistent, const char *=
p1,
-                           const struct buffer *b2_src, const char *b1=
_name,
-                           const char *b2_name)
-{
-    /* We will =
stop sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
-     * OCC =
in a future version (because it's not useful)=2E To reduce questions
-     =
* when interoperating, we no longer printing a warning about it=2E
-     */=

-    if (strprefix(p1, "key-method ") || strprefix(p1, "keydir ") || strpr=
efix(p1, "proto ")
-        || streq(p1, "tls-auth") || strprefix(p1, "tun-=
ipv6") || strprefix(p1, "cipher "))
-    {
-        return;
-    }
-
-    i=
f (strlen(p1) > 0)
-    {
-        struct gc_arena gc =3D gc_new();
-      =
  struct buffer b2 =3D *b2_src;
-        const char *p1_prefix =3D options_=
warning_extract_parm1(p1, &gc);
-        char *p2 =3D gc_malloc(OPTION_PARM=
_SIZE, false, &gc);
-
-        while (buf_parse(&b2, delim, p2, OPTION_PARM=
_SIZE))
-        {
-            if (strlen(p2))
-            {
-           =
     const char *p2_prefix =3D options_warning_extract_parm1(p2, &gc);
-
- =
               if (!strcmp(p1, p2))
-                {
-                   =
 goto done;
-                }
-                if (!strcmp(p1_prefix, p2_p=
refix))
-                {
-                    if (report_inconsistent)
- =
                   {
-                        msg(msglevel, "WARNING: '%s' =
is used inconsistently, %s=3D'%s', %s=3D'%s'",
-                           =
 safe_print(p1_prefix, &gc), b1_name, safe_print(p1, &gc), b2_name,
-      =
                      safe_print(p2, &gc));
-                    }
-       =
             goto done;
-                }
-            }
-        }
-
-   =
     msg(msglevel, "WARNING: '%s' is present in %s config but missing in %s=
 config, %s=3D'%s'",
-            safe_print(p1_prefix, &gc), b1_name, b2_n=
ame, b1_name, safe_print(p1, &gc));
-
-done:
-        gc_free(&gc);
-    }
=
-}
-
-static void
-options_warning_safe_scan1(const msglvl_t msglevel, cons=
t int delim,
-                           const bool report_inconsistent, co=
nst struct buffer *b1_src,
-                           const struct buffer =
*b2_src, const char *b1_name, const char *b2_name)
-{
-    struct gc_arena =
gc =3D gc_new();
-    struct buffer b =3D *b1_src;
-    char *p =3D gc_mall=
oc(OPTION_PARM_SIZE, true, &gc);
-
-    while (buf_parse(&b, delim, p, OPTI=
ON_PARM_SIZE))
-    {
-        options_warning_safe_scan2(msglevel, delim, =
report_inconsistent, p, b2_src, b1_name,
-                                 =
  b2_name);
-    }
-
-    gc_free(&gc);
-}
-
-static void
-options_warning_=
safe_ml(const msglvl_t msglevel, char *actual, const char *expected, size_t=
 actual_n)
-{
-    struct gc_arena gc =3D gc_new();
-
-    if (actual_n > 0=
)
-    {
-        struct buffer local =3D alloc_buf_gc(OPTION_PARM_SIZE + 1=
6, &gc);
-        struct buffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE + =
16, &gc);
-        actual[actual_n - 1] =3D 0;
-
-        buf_printf(&local=
, "version %s", expected);
-        buf_printf(&remote, "version %s", actua=
l);
-
-        options_warning_safe_scan1(msglevel, ',', true, &local, &rem=
ote, "local", "remote");
-
-        options_warning_safe_scan1(msglevel, ',=
', false, &remote, &local, "remote", "local");
-    }
-
-    gc_free(&gc);
=
-}
-
-bool
-options_cmp_equal_safe(char *actual, const char *expected, size=
_t actual_n)
-{
-    struct gc_arena gc =3D gc_new();
-    bool ret =3D tru=
e;
-
-    if (actual_n > 0)
-    {
-        actual[actual_n - 1] =3D 0;
-  =
      if (strncmp(actual, expected, 2))
-        {
-            msg(D_SHOW_=
OCC, "NOTE: Options consistency check may be skewed by version differences"=
);
-            options_warning_safe_ml(D_SHOW_OCC, actual, expected, actua=
l_n);
-        }
-        else
-        {
-            ret =3D !strcmp(actu=
al, expected);
-        }
-    }
-    gc_free(&gc);
-    return ret;
-}
-
-=
void
-options_warning_safe(char *actual, const char *expected, size_t actua=
l_n)
-{
-    options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n=
);
-}
-
-const char *
-options_string_version(const char *s, struct gc_aren=
a *gc)
-{
-    struct buffer out =3D alloc_buf_gc(4, gc);
-    strncpynt((c=
har *)BPTR(&out), s, 3);
-    return BSTR(&out);
-}
-
-#if defined(__GNUC__=
) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnosti=
c ignored "-Wsign-compare"
-#endif
-
-char *
-options_string_extract_option=
(const char *options_string, const char *opt_name, struct gc_arena *gc)
-{
=
-    char *ret =3D NULL;
-    const size_t opt_name_len =3D strlen(opt_name=
);
-
-    const char *p =3D options_string;
-    while (p)
-    {
-        =
if (0 =3D=3D strncmp(p, opt_name, opt_name_len) && strlen(p) > (opt_name_le=
n + 1)
-            && p[opt_name_len] =3D=3D ' ')
-        {
-            =
/* option found, extract value */
-            const char *start =3D &p[opt=
_name_len + 1];
-            const char *end =3D strchr(p, ',');
-         =
   size_t val_len =3D end ? end - start : strlen(start);
-            ret =
=3D gc_malloc(val_len + 1, true, gc);
-            memcpy(ret, start, val_l=
en);
-            break;
-        }
-        p =3D strchr(p, ',');
-       =
 if (p)
-        {
-            p++; /* skip delimiter */
-        }
-    }=

-    return ret;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragm=
a GCC diagnostic pop
-#endif
-
-/*
  * parse/print topology coding
  */
 
d=
iff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index d42773f=
=2E=2E0fd505a 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/option=
s=2Eh
@@ -903,33 +903,6 @@
 
 bool string_defined_equal(const char *s1, con=
st char *s2);
 
-const char *options_string_version(const char *s, struct g=
c_arena *gc);
-
-char *options_string(const struct options *o, const struct=
 frame *frame, struct tuntap *tt,
-                     openvpn_net_ctx_t *=
ctx, bool remote, struct gc_arena *gc);
-
-bool options_cmp_equal_safe(char=
 *actual, const char *expected, size_t actual_n);
-
-void options_warning_s=
afe(char *actual, const char *expected, size_t actual_n);
-
-bool options_c=
mp_equal(char *actual, const char *expected);
-
-void options_warning(char =
*actual, const char *expected);
-
-/**
- * Given an OpenVPN options string,=
 extract the value of an option=2E
- *
- * @param options_string        Zer=
o-terminated, comma-separated options string
- * @param opt_name           =
   The name of the option to extract
- * @param gc                    The g=
c to allocate the return value
- *
- * @return gc-allocated value of option=
 with name opt_name if option was found,
- *         or NULL otherwise=2E
-=
 */
-char *options_string_extract_option(const char *options_string, const =
char *opt_name,
-                                    struct gc_arena *gc);
=
-
-
 void options_postprocess(struct options *options, struct env_set *es);=

 
 bool options_postprocess_pull(struct options *o, struct env_set *es);
d=
iff --git a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec=

new file mode 100644
index 0000000=2E=2Ed3b29b8
--- /dev/null
+++ b/src/op=
envpn/options_string=2Ec
@@ -0,0 +1,429 @@
+/*
+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks
+ *             over a single UDP port, w=
ith support for SSL/TLS-based
+ *             session authentication and ke=
y exchange,
+ *             packet encryption, packet authentication, and
+=
 *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenV=
PN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you ca=
n redistribute it and/or modify
+ *  it under the terms of the GNU General =
Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H=

+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "buff=
er=2Eh"
+#include "crypto=2Eh"
+#include "error=2Eh"
+#include "mtu=2Eh"
+#=
include "options=2Eh"
+#include "socket_util=2Eh"
+#include "ssl=2Eh"
+#inc=
lude "ssl_ncp=2Eh"
+#include "tun=2Eh"
+
+#include <string=2Eh>
+
+char *
+=
options_string(const struct options *o, const struct frame *frame, struct t=
untap *tt,
+               openvpn_net_ctx_t *ctx, bool remote, struct gc_a=
rena *gc)
+{
+    struct buffer out =3D alloc_buf(OPTION_LINE_SIZE);
+    b=
ool tt_local =3D false;
+
+    buf_printf(&out, "V4");
+
+    /*
+     * Tu=
nnel Options
+     */
+
+    buf_printf(&out, ",dev-type %s", dev_type_stri=
ng(o->dev, o->dev_type));
+    /* the link-mtu that we send has only a mean=
ing if have a fixed
+     * cipher (p2p) or have a fallback cipher configur=
ed for older non
+     * ncp clients=2E But not sending it will make even 2=
=2E4 complain
+     * about it being missing=2E So still send it=2E */
+   =
 buf_printf(&out, ",link-mtu %u", (unsigned int)calc_options_string_link_mt=
u(o, frame));
+
+    if (o->ce=2Eocc_mtu !=3D 0)
+    {
+        buf_printf=
(&out, ",tun-mtu %d", o->ce=2Eocc_mtu);
+    }
+    else
+    {
+        bu=
f_printf(&out, ",tun-mtu %d", frame->tun_mtu);
+    }
+
+    buf_printf(&ou=
t, ",proto %s", proto_remote(o->ce=2Eproto, remote));
+
+    bool p2p_nopul=
l =3D o->mode =3D=3D MODE_POINT_TO_POINT && !PULL_DEFINED(o);
+    /* send =
tun_ipv6 only in peer2peer mode - in client/server mode, it
+     * is usua=
lly pushed by the server, triggering a non-helpful warning
+     */
+    if=
 (o->ifconfig_ipv6_local && p2p_nopull)
+    {
+        buf_printf(&out, ",=
tun-ipv6");
+    }
+
+    /*
+     * Try to get ifconfig parameters into th=
e options string=2E
+     * If tt is undefined, make a temporary instantiat=
ion=2E
+     */
+    if (!tt)
+    {
+        tt =3D init_tun(o->dev, o->de=
v_type, o->topology, o->ifconfig_local,
+                      o->ifconfig_=
remote_netmask, o->ifconfig_ipv6_local, o->ifconfig_ipv6_netbits,
+        =
              o->ifconfig_ipv6_remote, NULL, NULL, false, NULL, ctx, NULL);=

+        if (tt)
+        {
+            tt_local =3D true;
+        }
+  =
  }
+
+    if (tt && p2p_nopull)
+    {
+        const char *ios =3D ifconf=
ig_options_string(tt, remote, o->ifconfig_nowarn, gc);
+        if (ios && =
strlen(ios))
+        {
+            buf_printf(&out, ",ifconfig %s", ios);=

+        }
+    }
+    if (tt_local)
+    {
+        free(tt);
+        tt=
 =3D NULL;
+    }
+
+#ifdef USE_COMP
+    if (o->comp=2Ealg !=3D COMP_ALG_U=
NDEF)
+    {
+        /* for compatibility, this simply indicates that comp=
ression
+         * context is active, not necessarily LZO per-se */
+     =
   buf_printf(&out, ",comp-lzo");
+    }
+#endif
+
+#ifdef ENABLE_FRAGMENT
=
+    if (o->ce=2Efragment)
+    {
+        buf_printf(&out, ",mtu-dynamic")=
;
+    }
+#endif
+
+#define TLS_CLIENT (o->tls_client)
+#define TLS_SERVER =
(o->tls_server)
+
+    /*
+     * Key direction
+     */
+    {
+        co=
nst char *kd =3D keydirection2ascii(o->key_direction, remote, false);
+    =
    if (kd)
+        {
+            buf_printf(&out, ",keydir %s", kd);
+  =
      }
+    }
+
+    /*
+     * Crypto Options
+     */
+    if (o->shared=
_secret_file || TLS_CLIENT || TLS_SERVER)
+    {
+        struct key_type k=
t;
+
+        ASSERT((o->shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D=
 true) + (TLS_SERVER =3D=3D true) <=3D 1);
+
+        /* Skip resolving BF-=
CBC to allow SSL libraries without BF-CBC
+         * to work here in the d=
efault configuration */
+        const char *ciphername =3D o->ciphername;
=
+        size_t keysize =3D 0;
+
+        if (strcmp(o->ciphername, "BF-CBC=
") =3D=3D 0)
+        {
+            init_key_type(&kt, "none", o->authname=
, true, false);
+            keysize =3D 128;
+        }
+        else
+   =
     {
+            init_key_type(&kt, o->ciphername, o->authname, true, fa=
lse);
+            ciphername =3D cipher_kt_name(kt=2Ecipher);
+           =
 if (cipher_defined(o->ciphername))
+            {
+                keysize=
 =3D cipher_kt_key_size(kt=2Ecipher) * 8;
+            }
+        }
+      =
  /* Only announce the cipher to our peer if we are willing to
+         * =
support it */
+        if (p2p_nopull || tls_item_in_cipher_list(ciphername=
, o->ncp_ciphers))
+        {
+            buf_printf(&out, ",cipher %s", c=
iphername);
+        }
+        buf_printf(&out, ",auth %s", md_kt_name(kt=
=2Edigest));
+        buf_printf(&out, ",keysize %zu", keysize);
+        i=
f (o->shared_secret_file)
+        {
+            buf_printf(&out, ",secret=
");
+        }
+    }
+
+    /*
+     * SSL Options
+     */
+    {
+      =
  if (TLS_CLIENT || TLS_SERVER)
+        {
+            if (o->ce=2Etls_aut=
h_file)
+            {
+                buf_printf(&out, ",tls-auth");
+   =
         }
+            /* Not adding tls-crypt here, because we won't reac=
h this code if
+             * tls-auth/tls-crypt does not match=2E  Removi=
ng tls-auth here would
+             * break stuff, so leaving that in plac=
e=2E */
+
+            buf_printf(&out, ",key-method %d", KEY_METHOD_2);
+ =
       }
+
+        if (remote)
+        {
+            if (TLS_CLIENT)
+  =
          {
+                buf_printf(&out, ",tls-server");
+            =
}
+            else if (TLS_SERVER)
+            {
+                buf_pri=
ntf(&out, ",tls-client");
+            }
+        }
+        else
+        =
{
+            if (TLS_CLIENT)
+            {
+                buf_printf(&=
out, ",tls-client");
+            }
+            else if (TLS_SERVER)
+    =
        {
+                buf_printf(&out, ",tls-server");
+            }
=
+        }
+    }
+
+#undef TLS_CLIENT
+#undef TLS_SERVER
+
+    return BST=
R(&out);
+}
+
+/**
+ * Compare option strings for equality=2E
+ *
+ * If th=
e first two chars of the strings differ, it means that
+ * we are looking a=
t different versions of the options string,
+ * therefore don't compare the=
m and return true=2E
+ */
+static const char *
+options_warning_extract_par=
m1(const char *option_string, struct gc_arena *gc_ret)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    struct buffer b =3D string_alloc_buf(option_strin=
g, &gc);
+    char *p =3D gc_malloc(OPTION_PARM_SIZE, false, &gc);
+    con=
st char *ret;
+
+    buf_parse(&b, ' ', p, OPTION_PARM_SIZE);
+    ret =3D =
string_alloc(p, gc_ret);
+    gc_free(&gc);
+    return ret;
+}
+
+static v=
oid
+options_warning_safe_scan2(const msglvl_t msglevel, const int delim,
+=
                           const bool report_inconsistent, const char *p1,
=
+                           const struct buffer *b2_src, const char *b1_nam=
e,
+                           const char *b2_name)
+{
+    /* We will stop=
 sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
+     * OCC in a=
 future version (because it's not useful)=2E To reduce questions
+     * wh=
en interoperating, we no longer printing a warning about it=2E
+     */
+  =
  if (strprefix(p1, "key-method ") || strprefix(p1, "keydir ") || strprefix=
(p1, "proto ")
+        || streq(p1, "tls-auth") || strprefix(p1, "tun-ipv6=
") || strprefix(p1, "cipher "))
+    {
+        return;
+    }
+
+    if (s=
trlen(p1) > 0)
+    {
+        struct gc_arena gc =3D gc_new();
+        st=
ruct buffer b2 =3D *b2_src;
+        const char *p1_prefix =3D options_warn=
ing_extract_parm1(p1, &gc);
+        char *p2 =3D gc_malloc(OPTION_PARM_SIZ=
E, false, &gc);
+
+        while (buf_parse(&b2, delim, p2, OPTION_PARM_SIZ=
E))
+        {
+            if (strlen(p2))
+            {
+               =
 const char *p2_prefix =3D options_warning_extract_parm1(p2, &gc);
+
+     =
           if (!strcmp(p1, p2))
+                {
+                    got=
o done;
+                }
+                if (!strcmp(p1_prefix, p2_prefi=
x))
+                {
+                    if (report_inconsistent)
+     =
               {
+                        msg(msglevel, "WARNING: '%s' is u=
sed inconsistently, %s=3D'%s', %s=3D'%s'",
+                            saf=
e_print(p1_prefix, &gc), b1_name, safe_print(p1, &gc), b2_name,
+          =
                  safe_print(p2, &gc));
+                    }
+           =
         goto done;
+                }
+            }
+        }
+
+       =
 msg(msglevel, "WARNING: '%s' is present in %s config but missing in %s con=
fig, %s=3D'%s'",
+            safe_print(p1_prefix, &gc), b1_name, b2_name,=
 b1_name, safe_print(p1, &gc));
+
+done:
+        gc_free(&gc);
+    }
+}
+=

+static void
+options_warning_safe_scan1(const msglvl_t msglevel, const in=
t delim,
+                           const bool report_inconsistent, const =
struct buffer *b1_src,
+                           const struct buffer *b2_=
src, const char *b1_name, const char *b2_name)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer b =3D *b1_src;
+    char *p =3D gc_malloc(=
OPTION_PARM_SIZE, true, &gc);
+
+    while (buf_parse(&b, delim, p, OPTION_=
PARM_SIZE))
+    {
+        options_warning_safe_scan2(msglevel, delim, rep=
ort_inconsistent, p, b2_src, b1_name,
+                                   b=
2_name);
+    }
+
+    gc_free(&gc);
+}
+
+static void
+options_warning_saf=
e_ml(const msglvl_t msglevel, char *actual, const char *expected, size_t ac=
tual_n)
+{
+    struct gc_arena gc =3D gc_new();
+
+    if (actual_n > 0)
+=
    {
+        struct buffer local =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, =
&gc);
+        struct buffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE + 16,=
 &gc);
+        actual[actual_n - 1] =3D 0;
+
+        buf_printf(&local, "=
version %s", expected);
+        buf_printf(&remote, "version %s", actual);=

+
+        options_warning_safe_scan1(msglevel, ',', true, &local, &remote=
, "local", "remote");
+
+        options_warning_safe_scan1(msglevel, ',', =
false, &remote, &local, "remote", "local");
+    }
+
+    gc_free(&gc);
+}
=
+
+bool
+options_cmp_equal_safe(char *actual, const char *expected, size_t =
actual_n)
+{
+    struct gc_arena gc =3D gc_new();
+    bool ret =3D true;
=
+
+    if (actual_n > 0)
+    {
+        actual[actual_n - 1] =3D 0;
+     =
   if (strncmp(actual, expected, 2))
+        {
+            msg(D_SHOW_OCC=
, "NOTE: Options consistency check may be skewed by version differences");
=
+            options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n=
);
+        }
+        else
+        {
+            ret =3D !strcmp(actual,=
 expected);
+        }
+    }
+    gc_free(&gc);
+    return ret;
+}
+
+boo=
l
+options_cmp_equal(char *actual, const char *expected)
+{
+    return opt=
ions_cmp_equal_safe(actual, expected, strlen(actual) + 1);
+}
+
+void
+opti=
ons_warning_safe(char *actual, const char *expected, size_t actual_n)
+{
+ =
   options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
+}
+
+v=
oid
+options_warning(char *actual, const char *expected)
+{
+    options_wa=
rning_safe(actual, expected, strlen(actual) + 1);
+}
+
+const char *
+optio=
ns_string_version(const char *s, struct gc_arena *gc)
+{
+    struct buffer=
 out =3D alloc_buf_gc(4, gc);
+    strncpynt((char *)BPTR(&out), s, 3);
+  =
  return BSTR(&out);
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+=
#endif
+
+char *
+options_string_extract_option(const char *options_string,=
 const char *opt_name, struct gc_arena *gc)
+{
+    char *ret =3D NULL;
+  =
  const size_t opt_name_len =3D strlen(opt_name);
+
+    const char *p =3D =
options_string;
+    while (p)
+    {
+        if (0 =3D=3D strncmp(p, opt_=
name, opt_name_len) && strlen(p) > (opt_name_len + 1)
+            && p[opt=
_name_len] =3D=3D ' ')
+        {
+            /* option found, extract val=
ue */
+            const char *start =3D &p[opt_name_len + 1];
+           =
 const char *end =3D strchr(p, ',');
+            size_t val_len =3D end ? =
end - start : strlen(start);
+            ret =3D gc_malloc(val_len + 1, tr=
ue, gc);
+            memcpy(ret, start, val_len);
+            break;
+   =
     }
+        p =3D strchr(p, ',');
+        if (p)
+        {
+         =
   p++; /* skip delimiter */
+        }
+    }
+    return ret;
+}
+
+#if d=
efined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
=
diff --git a/src/openvpn/options_string=2Eh b/src/openvpn/options_string=2E=
h
new file mode 100644
index 0000000=2E=2E02efed3
--- /dev/null
+++ b/src/o=
penvpn/options_string=2Eh
@@ -0,0 +1,97 @@
+/*
+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks
+ *             over a single UDP port, w=
ith support for SSL/TLS-based
+ *             session authentication and ke=
y exchange,
+ *             packet encryption, packet authentication, and
+=
 *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenV=
PN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you ca=
n redistribute it and/or modify
+ *  it under the terms of the GNU General =
Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef OPTIONS_STRI=
NG_H
+#define OPTIONS_STRING_H
+
+#include "buffer=2Eh"
+#include "options=
=2Eh"
+
+const char *options_string_version(const char *s, struct gc_arena =
*gc);
+
+/**
+ * Build an options string to represent data channel encrypti=
on options=2E
+ * This string must match exactly between peers=2E  The keys=
ize is checked
+ * separately by read_key()=2E
+ *
+ * The following option=
s must match on both peers:
+ *
+ * Tunnel options:
+ *
+ * --dev tun|tap [=
unit number need not match]
+ * --dev-type tun|tap
+ * --link-mtu
+ * --udp=
-mtu
+ * --tun-mtu
+ * --proto udp
+ * --proto tcp-client [matched with --p=
roto tcp-server
+ *                     on the other end of the connection]=

+ * --proto tcp-server [matched with --proto tcp-client on
+ *            =
         the other end of the connection]
+ * --tun-ipv6
+ * --ifconfig x y=
 [matched with --ifconfig y x on
+ *                 the other end of the c=
onnection]
+ *
+ * --comp-lzo
+ * --compress alg
+ * --fragment
+ *
+ * Cry=
pto Options:
+ *
+ * --cipher
+ * --auth
+ * --secret
+ *
+ * SSL Options:
=
+ *
+ * --tls-auth
+ * --tls-client [matched with --tls-server on
+ *      =
         the other end of the connection]
+ * --tls-server [matched with --=
tls-client on
+ *               the other end of the connection]
+ */
+char=
 *options_string(const struct options *o, const struct frame *frame, struct=
 tuntap *tt,
+                     openvpn_net_ctx_t *ctx, bool remote, str=
uct gc_arena *gc);
+
+bool options_cmp_equal_safe(char *actual, const char =
*expected, size_t actual_n);
+
+void options_warning_safe(char *actual, con=
st char *expected, size_t actual_n);
+
+bool options_cmp_equal(char *actual=
, const char *expected);
+
+void options_warning(char *actual, const char *=
expected);
+
+/**
+ * Given an OpenVPN options string, extract the value of=
 an option=2E
+ *
+ * @param options_string        Zero-terminated, comma-s=
eparated options string
+ * @param opt_name              The name of the op=
tion to extract
+ * @param gc                    The gc to allocate the ret=
urn value
+ *
+ * @return gc-allocated value of option with name opt_name i=
f option was found,
+ *         or NULL otherwise=2E
+ */
+char *options_st=
ring_extract_option(const char *options_string, const char *opt_name,
+    =
                                struct gc_arena *gc);
+
+
+#endif
diff --gi=
t a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 01e45fd=2E=2Ed5bd602 10=
0644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -62,6 +62,7 @@
=
 #include "auth_token=2Eh"
 #include "mss=2Eh"
 #include "dco=2Eh"
+#includ=
e "options_string=2Eh"
 
 #include "memdbg=2Eh"
 #include "openvpn=2Eh"

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6824058fc9c4efd48ce=
eb32d4164f97b2a243d85
Gerrit-Change-Number: 1773
Gerrit-PatchSet: 6
Gerrit-=
Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--rHCAUQmc0ZQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">options: Factor out opti=
ons_string code from options=2Ec<br><br>options=2Ec is a huge, unwieldly fi=
le=2E So remove some<br>closely related code that has no direct dependencie=
s<br>with the other functions in the file=2E<br><br>This time it is the fun=
ctions related to the creation<br>and testing of the options string=2E<br><=
br>Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1773<br>Message-Id: &lt;20260820124355=2E23332-1-gert@green=
ie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg38563=2Ehtml<br>Signed-off-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/M=
akefile=2Eam<br>M src/openvpn/init=2Ec<br>M src/openvpn/occ=2Ec<br>M src/op=
envpn/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/openvpn/options_str=
ing=2Ec<br>A src/openvpn/options_string=2Eh<br>M src/openvpn/ssl=2Ec<br>9 f=
iles changed, 532 insertions(+), 458 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/177=
3/6</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><spa=
n>index 8866520=2E=2E2c3324d 100644</span><br><span>--- a/CMakeLists=2Etxt<=
/span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -533,6 +533,8 @@<=
/span><br><span>     src/openvpn/options_parse=2Ec</span><br><span>     src=
/openvpn/options_show=2Ec</span><br><span>     src/openvpn/options_show=2Eh=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/opt=
ions_string=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
src/openvpn/options_string=2Eh</span><br><span>     src/openvpn/otime=2Ec</=
span><br><span>     src/openvpn/otime=2Eh</span><br><span>     src/openvpn/=
ovpn_dco_win=2Eh</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/s=
rc/openvpn/Makefile=2Eam</span><br><span>index 42b4404=2E=2E7fd12b4 100644<=
/span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/o=
penvpn/Makefile=2Eam</span><br><span>@@ -110,6 +110,7 @@</span><br><span> 	=
openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span=
><br><span> 	options_show=2Ec options_show=2Eh \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	options_string=2Ec options_string=2Eh \</span=
><br><span> 	options_util=2Ec options_util=2Eh \</span><br><span> 	options_=
parse=2Ec \</span><br><span> 	otime=2Ec otime=2Eh \</span><br><span>diff --=
git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index a90=
fe69=2E=2Efa62cdd 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><=
br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -54,6 +54,7 @@</span=
><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;tu=
n_afunix=2Eh&quot;</span><br><span> #include &quot;schedule=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_st=
ring=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh=
&quot;</span><br><span> </span><br><span>diff --git a/src/openvpn/occ=2Ec b=
/src/openvpn/occ=2Ec</span><br><span>index aa262a8=2E=2Ef25ae19 100644</spa=
n><br><span>--- a/src/openvpn/occ=2Ec</span><br><span>+++ b/src/openvpn/occ=
=2Ec</span><br><span>@@ -29,7 +29,7 @@</span><br><span> #include &quot;occ=
=2Eh&quot;</span><br><span> #include &quot;forward=2Eh&quot;</span><br><spa=
n> #include &quot;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;options_string=2Eh&quot;</span><br><span> </span><br><span> /*</sp=
an><br><span>  * This random string identifies an OpenVPN</span><br><span>d=
iff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><sp=
an>index 391739c=2E=2E9bd6f01 100644</span><br><span>--- a/src/openvpn/opti=
ons=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3=
363,436 +3363,6 @@</span><br><span> }</span><br><span> </span><br><span> /*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Build an options s=
tring to represent data channel encryption options=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * This string must match exactly between p=
eers=2E  The keysize is checked</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * separately by read_key()=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * The following options must match on both peers:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Tunnel options:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --dev tun=
|tap [unit number need not match]</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * --dev-type tun|tap</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * --link-mtu</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * --udp-mtu</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --=
tun-mtu</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --proto udp=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --proto tcp-client=
 [matched with --proto tcp-server</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *                     on the other end of the connection]</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * --proto tcp-server [mat=
ched with --proto tcp-client on</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *                     the other end of the connection]</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * --tun-ipv6</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * --ifconfig x y [matched with --ifcon=
fig y x on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *         =
        the other end of the connection]</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * --comp-lzo</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --com=
press alg</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --fragmen=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Crypto Options:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * --cipher</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * --auth</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --sec=
ret</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * SSL Options:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * --tls-auth</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * --tls-client [matched with --tls-server on</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *               the other end of the connecti=
on]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tls-server [m=
atched with --tls-client on</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *               the other end of the connection]</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-options_string(const struct options *o, const struct frame *frame, struct =
tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
     openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf(OPTION_LINE_SIZE);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool tt_local =3D=
 false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;V4&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * Tunnel Options</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_pri=
ntf(&amp;out, &quot;,dev-type %s&quot;, dev_type_string(o-&gt;dev, o-&gt;de=
v_type));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* the l=
ink-mtu that we send has only a meaning if have a fixed</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * cipher (p2p) or have a fallback ci=
pher configured for older non</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     * ncp clients=2E But not sending it will make even 2=2E4 compl=
ain</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * about it be=
ing missing=2E So still send it=2E */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    buf_printf(&amp;out, &quot;,link-mtu %u&quot;, (unsigne=
d int)calc_options_string_link_mtu(o, frame));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (o-&gt;ce=2Eocc_mtu !=3D 0)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        buf_printf(&amp;out, &quot;,tun-mtu %d&quot;, o-&gt;ce=2Eocc_mtu);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        buf_printf(&amp;out, &quot;,tun-mtu %d&quot;, frame-&gt;tu=
n_mtu);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;,proto %s&quot;, pro=
to_remote(o-&gt;ce=2Eproto, remote));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
ool p2p_nopull =3D o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !PULL_D=
EFINED(o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* send=
 tun_ipv6 only in peer2peer mode - in client/server mode, it</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     * is usually pushed by the serv=
er, triggering a non-helpful warning</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (o-&gt;ifconfig_ipv6_local &amp;&amp; p2p_nopull)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;,tun-ipv6&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * Try to get ifconfig parameters into the options string=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * If tt is undefined, make a=
 temporary instantiation=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
!tt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        tt =3D init_tun(o-&gt;dev=
, o-&gt;dev_type, o-&gt;topology, o-&gt;ifconfig_local,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                      o-&gt;ifconfig_remo=
te_netmask, o-&gt;ifconfig_ipv6_local, o-&gt;ifconfig_ipv6_netbits,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                      o-&gt;i=
fconfig_ipv6_remote, NULL, NULL, false, NULL, ctx, NULL);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (tt)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            tt_local =3D true;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt &amp;&amp=
; p2p_nopull)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *ios =
=3D ifconfig_options_string(tt, remote, o-&gt;ifconfig_nowarn, gc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ios &amp;&amp; st=
rlen(ios))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(=
&amp;out, &quot;,ifconfig %s&quot;, ios);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
tt_local)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        free(tt);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        tt =3D NULL;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef USE_COMP</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (o-&gt;comp=2Ealg !=3D COMP_ALG_UNDEF)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        buf_printf(&amp;out, &quot;,comp-lzo&quot;); /* for compatib=
ility, this simply indicates that compression</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                          context i=
s active, not necessarily LZO per-se */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_FRAGMENT</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;ce=2Efragment)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;,mtu-dy=
namic&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define TLS_CLIENT (o-&gt;tls_client)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define TLS_SERVER (o-&gt;tls_server)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * Key direction</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char =
*kd =3D keydirection2ascii(o-&gt;key_direction, remote, false);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (kd)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,keydir %s&q=
uot;, kd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * Crypto Options</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;=
shared_secret_file || TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        struct key_type kt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   ASSERT((o-&gt;shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D true) +=
 (TLS_SERVER =3D=3D true) &lt;=3D 1);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-         * to work here in the =
default configuration */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        const char *ciphername =3D o-&gt;ciphername;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        size_t keysize =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot=
;) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            init_key_=
type(&amp;kt, &quot;none&quot;, o-&gt;authname, true, false);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            keysize =3D 128;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;au=
thname, true, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            ciphername =3D cipher_kt_name(kt=2Ecipher);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            if (cipher_defined(o-&gt;ciph=
ername))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                keysi=
ze =3D cipher_kt_key_size(kt=2Ecipher) * 8;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        /* Only announce the cipher to our peer if we are willing to</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-         * support it */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p2p_nopull =
|| tls_item_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,cipher %s&=
quot;, ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_pr=
intf(&amp;out, &quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot=
;,keysize %zu&quot;, keysize);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (o-&gt;shared_secret_file)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            buf_printf(&amp;out, &quot;,secret&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * SSL Options=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (TLS_CLIENT || TLS_SERVER)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            if (o-&gt;ce=2Etls_auth_file)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&amp;out=
, &quot;,tls-auth&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* Not adding tls-crypt here, because we won&#39;t reach this code =
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * tls-=
auth/tls-crypt does not match=2E  Removing tls-auth here would</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-             * break stuff, so lea=
ving that in place=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_pr=
intf(&amp;out, &quot;,key-method %d&quot;, KEY_METHOD_2);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (remote)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (TLS_CLIENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   buf_printf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            else if (TLS_SERVER)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-cli=
ent&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (TLS_CLIENT)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-cli=
ent&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else i=
f (TLS_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 buf_printf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#undef TLS_CLIENT</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#undef TLS_SERVER</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return BSTR(&amp;out);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Compare option strings for equality=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If the first tw=
o chars of the strings differ, it means that</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * we are looking at different versions of the optio=
ns string,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * therefor=
e don&#39;t compare them and return true=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-options_cmp_equal(char *actual, co=
nst char *expected)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return options_cmp=
_equal_safe(actual, expected, strlen(actual) + 1);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-options_warning(char *actual,=
 const char *expected)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    options_warning=
_safe(actual, expected, strlen(actual) + 1);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_warning_extr=
act_parm1(const char *option_string, struct gc_arena *gc_ret)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct buffer b =3D string_alloc_buf=
(option_string, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    char *p =3D gc_malloc(OPTION_PARM_SIZE, false, &amp;gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const char *ret;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    buf_parse(&amp;b, &#39; &#39;, p, OPTION_PARM_SIZE=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D string_=
alloc(p, gc_ret);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-options_warning_safe_scan2(const msglvl_t msglevel, const int=
 delim,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
             const bool report_inconsistent, const char *p1,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                           const str=
uct buffer *b2_src, const char *b1_name,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                           const char *b2_name)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* We will stop sending &#39;key-method&#39;, =
&#39;keydir&#39;, &#39;proto&#39; and &#39;tls-auth&#39; in</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * OCC in a future version (becau=
se it&#39;s not useful)=2E To reduce questions</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     * when interoperating, we no longer printing =
a warning about it=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (strpre=
fix(p1, &quot;key-method &quot;) || strprefix(p1, &quot;keydir &quot;) || s=
trprefix(p1, &quot;proto &quot;)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        || streq(p1, &quot;tls-auth&quot;) || strprefix(p1, &quo=
t;tun-ipv6&quot;) || strprefix(p1, &quot;cipher &quot;))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (strlen(p1) &gt; =
0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct b=
uffer b2 =3D *b2_src;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        const char *p1_prefix =3D options_warning_extract_parm1(p1, &amp;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *p2 =
=3D gc_malloc(OPTION_PARM_SIZE, false, &amp;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        while (buf_parse(&amp;b2, delim, p2, OPTION_PARM_SIZE))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (strlen(p2))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                const char *p2_prefix =3D=
 options_warning_extract_parm1(p2, &amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                if (!strcmp(p1, p2))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    goto done;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                if (!strcmp(p1_prefix, p2_prefix))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    if (report_i=
nconsistent)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               msg(msglevel, &quot;WARNING: &#39;%s&#39; is used inconsiste=
ntly, %s=3D&#39;%s&#39;, %s=3D&#39;%s&#39;&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                            safe_print(p1_prefi=
x, &amp;gc), b1_name, safe_print(p1, &amp;gc), b2_name,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                            safe_print(p2=
, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;WARNING: &#39;%=
s&#39; is present in %s config but missing in %s config, %s=3D&#39;%s&#39;&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            saf=
e_print(p1_prefix, &amp;gc), b1_name, b2_name, b1_name, safe_print(p1, &amp=
;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-done:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-options_warning_safe_scan1(const msglvl_=
t msglevel, const int delim,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                           const bool report_inconsistent, const str=
uct buffer *b1_src,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                         const struct buffer *b2_src, const char *b1_name, =
const char *b2_name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct buffer b =3D *b1_src;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    char *p =3D gc_malloc(OPTION_PARM_SIZE, true, &amp;gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    while (buf_parse(&amp;b, delim, p, OPTION_PARM_SI=
ZE))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        options_warning_safe_scan=
2(msglevel, delim, report_inconsistent, p, b2_src, b1_name,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                   b2=
_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-options_warning_safe_ml(con=
st msglvl_t msglevel, char *actual, const char *expected, size_t actual_n)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (actual_n &gt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct buffer local =3D alloc_buf_gc(OPTION_PARM_SI=
ZE + 16, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     struct buffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        actual[actual=
_n - 1] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;loca=
l, &quot;version %s&quot;, expected);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        buf_printf(&amp;remote, &quot;version %s&quot;, act=
ual);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        options_warning_safe_scan1(ms=
glevel, &#39;,&#39;, true, &amp;local, &amp;remote, &quot;local&quot;, &quo=
t;remote&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        options_warning_sa=
fe_scan1(msglevel, &#39;,&#39;, false, &amp;remote, &amp;local, &quot;remot=
e&quot;, &quot;local&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_cmp_e=
qual_safe(char *actual, const char *expected, size_t actual_n)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D true;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (actual_n &gt; 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        actual[actual_n - 1] =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (strncmp(actual, expected, 2))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(D_SHOW_OCC, &quot;NOTE: Options co=
nsistency check may be skewed by version differences&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            options_warning_safe_ml(=
D_SHOW_OCC, actual, expected, actual_n);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            re=
t =3D !strcmp(actual, expected);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-option=
s_warning_safe(char *actual, const char *expected, size_t actual_n)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    options_warning_safe_ml(D_SHOW_OCC, actual, e=
xpected, actual_n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-options_string_version(const char *s, struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf=
_gc(4, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncp=
ynt((char *)BPTR(&amp;out), s, 3);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return BSTR(&amp;out);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_st=
ring_extract_option(const char *options_string, const char *opt_name, struc=
t gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D NULL;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const size_t opt_nam=
e_len =3D strlen(opt_name);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char =
*p =3D options_string;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    while (p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (0 =3D=3D st=
rncmp(p, opt_name, opt_name_len) &amp;&amp; strlen(p) &gt; (opt_name_len + =
1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&a=
mp; p[opt_name_len] =3D=3D &#39; &#39;)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            /* option found, extract value */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            const char *start =3D &amp;p[op=
t_name_len + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       const char *end =3D strchr(p, &#39;,&#39;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            size_t val_len =3D end ? end - sta=
rt : strlen(start);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          ret =3D gc_malloc(val_len + 1, true, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            memcpy(ret, start, val_len);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        p =3D strchr(p, &#39;,&#39;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            p++; /* skip delimiter */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * parse/print =
topology coding</span><br><span>  */</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>=
index d42773f=2E=2E0fd505a 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -903,=
33 +903,6 @@</span><br><span> </span><br><span> bool string_defined_equal(c=
onst char *s1, const char *s2);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-const char *options_string_version(const char *=
s, struct gc_arena *gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *options_stri=
ng(const struct options *o, const struct frame *frame, struct tuntap *tt,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     op=
envpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-bool options_cmp_equal_safe(char *actual, const char *expecte=
d, size_t actual_n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void options_warning_s=
afe(char *actual, const char *expected, size_t actual_n);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-bool options_cmp_equal(char *actual, const char *expected);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void options_warning(char *actual, const ch=
ar *expected);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * Given an OpenVPN options string, extract th=
e value of an option=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param options=
_string        Zero-terminated, comma-separated options string</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param opt_name              Th=
e name of the option to extract</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param gc                    The gc to allocate the return val=
ue</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @return gc-allocated value of optio=
n with name opt_name if option was found,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *         or NULL otherwise=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-char *options_string_extract_option(const char *options_strin=
g, const char *opt_name,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                    struct gc_arena *gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> void options_postprocess(struct options=
 *options, struct env_set *es);</span><br><span> </span><br><span> bool opt=
ions_postprocess_pull(struct options *o, struct env_set *es);</span><br><sp=
an>diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=
=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2Ed3b29b8</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
options_string=2Ec</span><br><span>@@ -0,0 +1,429 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the =
GNU General Public License version 2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
mtu=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;socket_util=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;ssl=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tun=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+options_string(const struct options *o, const struct frame *fr=
ame, struct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+               openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer out =3D alloc_buf(=
OPTION_LINE_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool tt_local =3D false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_pri=
ntf(&amp;out, &quot;V4&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Tunnel Options=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,dev-type %s&quot;,=
 dev_type_string(o-&gt;dev, o-&gt;dev_type));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* the link-mtu that we send has only a meani=
ng if have a fixed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * cipher (p2p) or have a fallback cipher configured for older non</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ncp clients=2E But=
 not sending it will make even 2=2E4 complain</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * about it being missing=2E So still send it=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_print=
f(&amp;out, &quot;,link-mtu %u&quot;, (unsigned int)calc_options_string_lin=
k_mtu(o, frame));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;ce=2Eoc=
c_mtu !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&=
amp;out, &quot;,tun-mtu %d&quot;, o-&gt;ce=2Eocc_mtu);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    buf_printf(&amp;out, &quot;,tun-mtu %d&quot;, frame-&gt;tun_mtu);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buf_printf(&amp;out, &quot;,proto %s&quot;, proto_remo=
te(o-&gt;ce=2Eproto, remote));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 p2p_nopull =3D o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !PULL_DEFI=
NED(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* send =
tun_ipv6 only in peer2peer mode - in client/server mode, it</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * is usually pushed by the ser=
ver, triggering a non-helpful warning</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (o-&gt;ifconfig_ipv6_local &amp;&amp; p2p_nopull)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,tun-ipv6&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * Try to get ifconfig parameters into the options stri=
ng=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * If tt i=
s undefined, make a temporary instantiation=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!tt)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  tt =3D init_tun(o-&gt;dev, o-&gt;dev_type, o-&gt;topology, o-&gt;ifconfig=
_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
          o-&gt;ifconfig_remote_netmask, o-&gt;ifconfig_ipv6_local, o-&gt;i=
fconfig_ipv6_netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                      o-&gt;ifconfig_ipv6_remote, NULL, NULL, false, NULL=
, ctx, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tt_local=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (tt &amp;&amp; p2p_nopull)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const char *ios =3D ifconfig_options_string(=
tt, remote, o-&gt;ifconfig_nowarn, gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (ios &amp;&amp; strlen(ios))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,ifcon=
fig %s&quot;, ios);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt_local)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        free(tt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tt =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef USE_COMP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (o-&gt;comp=2Ealg !=3D COMP_ALG_UNDEF)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* for compatibility, this simply indicates that compress=
ion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * conte=
xt is active, not necessarily LZO per-se */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,comp-lzo&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef ENABLE_FRAGMENT</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (o-&gt;ce=2Efragment)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf_printf(&amp;out, &quot;,mtu-dynamic&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define TLS_CLIENT (o-&gt;tls_client)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define TLS_SERVER (o-&gt;tls_server)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * Key direction</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *kd=
 =3D keydirection2ascii(o-&gt;key_direction, remote, false);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (kd)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,keydir %=
s&quot;, kd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * Crypto Options</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (o-&gt;shared_secret_file || TLS_CLIENT || TLS_SERVER)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct key_type kt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ASSERT((o-&gt;shared_secret_file !=3D NULL) + (=
TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) &lt;=3D 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* Skip resolving BF-CBC to allow SSL libra=
ries without BF-CBC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * to work here in the default configuration */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const char *ciphername =3D o-&g=
t;ciphername;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  size_t keysize =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (str=
cmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            init_key_type(&amp;kt, &quot;none&quot;=
, o-&gt;authname, true, false);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            keysize =3D 128;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname, true, false)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cipher=
name =3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (cipher_defined(o-&gt;ciphername))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                keysize =3D ciphe=
r_kt_key_size(kt=2Ecipher) * 8;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* Only announce the cipher to our peer if we are willing to</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * support it */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p2p_nopull ||=
 tls_item_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,cipher %=
s&quot;, ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
buf_printf(&amp;out, &quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;ou=
t, &quot;,keysize %zu&quot;, keysize);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (o-&gt;shared_secret_file)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,secret&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * SSL Options</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TLS_CLIEN=
T || TLS_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (o-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                buf_printf(&amp;out, &quot;,tls-auth&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* Not adding tls-crypt h=
ere, because we won&#39;t reach this code if</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             * tls-auth/tls-crypt does not match=
=2E  Removing tls-auth here would</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+             * break stuff, so leaving that in place=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,k=
ey-method %d&quot;, KEY_METHOD_2);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (re=
mote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (TLS_CLIE=
NT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_pr=
intf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            else if (TLS_SERVER)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                buf_printf(&amp;out, &quot;,tls-clien=
t&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (TLS_CLIENT)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &q=
uot;,tls-client&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          else if (TLS_SERVER)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                buf_printf(&amp;out, &quot;,tls-server&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#undef TLS_CLIENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
undef TLS_SERVER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;o=
ut);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Compare option strings for equality=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * If the first two chars of the strings differ, it means that<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * we are looking at=
 different versions of the options string,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * therefore don&#39;t compare them and return true=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+options_warning_extract_parm1(co=
nst char *option_string, struct gc_arena *gc_ret)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer b =3D string_alloc_buf(optio=
n_string, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    char *p =3D gc_malloc(OPTION_PARM_SIZE, false, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_parse(&amp;b, &#39; &#39;, p, OPTION_PARM_SI=
ZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D str=
ing_alloc(p, gc_ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+options_warning_safe_scan2(const msglvl_t msg=
level, const int delim,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                           const bool report_inconsistent, const char *=
p1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
           const struct buffer *b2_src, const char *b1_name,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           const c=
har *b2_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We will stop send=
ing &#39;key-method&#39;, &#39;keydir&#39;, &#39;proto&#39; and &#39;tls-au=
th&#39; in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * OC=
C in a future version (because it&#39;s not useful)=2E To reduce questions<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * when interope=
rating, we no longer printing a warning about it=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (strprefix(p1, &quot;key-method &quot;) || str=
prefix(p1, &quot;keydir &quot;) || strprefix(p1, &quot;proto &quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        || streq(p1, &quot=
;tls-auth&quot;) || strprefix(p1, &quot;tun-ipv6&quot;) || strprefix(p1, &q=
uot;cipher &quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (strlen(p1) &gt; 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct buffer b2 =3D *b2_src;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char =
*p1_prefix =3D options_warning_extract_parm1(p1, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        char *p2 =3D gc_malloc(OPTIO=
N_PARM_SIZE, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        w=
hile (buf_parse(&amp;b2, delim, p2, OPTION_PARM_SIZE))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (strlen(p2))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                const char *p2_prefix =3D optio=
ns_warning_extract_parm1(p2, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if (!strcmp(p1, p2))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    goto done;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                if (!strcmp(p1_prefix, p2_prefix))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if=
 (report_inconsistent)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        msg(msglevel, &quot;WARNING: &#39;%s&#39; is u=
sed inconsistently, %s=3D&#39;%s&#39;, %s=3D&#39;%s&#39;&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                            saf=
e_print(p1_prefix, &amp;gc), b1_name, safe_print(p1, &amp;gc), b2_name,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
     safe_print(p2, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    goto done;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(m=
sglevel, &quot;WARNING: &#39;%s&#39; is present in %s config but missing in=
 %s config, %s=3D&#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            safe_print(p1_prefix, &amp;gc), b1_name, b2_na=
me, b1_name, safe_print(p1, &amp;gc));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+options_warning_safe_scan1(const msglvl_t msglevel, const int delim=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
         const bool report_inconsistent, const struct buffer *b1_src,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  const struct buffer *b2_src, const char *b1_name, const char *b2_name)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b =3D=
 *b1_src;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
p =3D gc_malloc(OPTION_PARM_SIZE, true, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    while (buf_parse(&amp;b, delim, p, OPTION_PARM_SIZE))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        options_warning_safe_scan2(msgle=
vel, delim, report_inconsistent, p, b2_src, b1_name,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                   b2_nam=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_warning_s=
afe_ml(const msglvl_t msglevel, char *actual, const char *expected, size_t =
actual_n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (actual_n &gt; 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct buffer local =3D alloc_b=
uf_gc(OPTION_PARM_SIZE + 16, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        struct buffer remote =3D alloc_buf_gc(OPTION_PAR=
M_SIZE + 16, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        actual[actual_n - 1] =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        buf_printf(&amp;local, &quot;version %s&quot;, expected);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;remot=
e, &quot;version %s&quot;, actual);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     options_warning_safe_scan1(msglevel, &#39;,&#39;, true, &amp;local, &a=
mp;remote, &quot;local&quot;, &quot;remote&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        options_warning_safe_scan1(msglevel, &#39;,&#39;, false=
, &amp;remote, &amp;local, &quot;remote&quot;, &quot;local&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+options_cmp_equal_safe(char *actual=
, const char *expected, size_t actual_n)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool ret =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (actual_n &gt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   actual[actual_n - 1] =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (strncmp(actual, expected, 2))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_SHOW_OCC, &quot;NOTE: Options con=
sistency check may be skewed by version differences&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            options_warning_safe_ml=
(D_SHOW_OCC, actual, expected, actual_n);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ret =3D !strcmp(actual, expected);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+options_cmp_equal(char *actual, const char *expected)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return options_cmp_equal_safe(actual=
, expected, strlen(actual) + 1);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+options_warning_safe(char *actual, cons=
t char *expected, size_t actual_n)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+option=
s_warning(char *actual, const char *expected)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    options_warning_safe(actual, expected, strlen(actual) + 1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+options_string_version(const char *s, struct gc_arena *gc)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer out =3D alloc_buf_gc(4, gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strncpynt((char=
 *)BPTR(&amp;out), s, 3);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return BSTR(&amp;out);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+options_string_extract_option(const char *options_string, const char *opt=
_name, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst size_t opt_name_len =3D strlen(opt_name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *p =3D options_string;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    while (p)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (0 =3D=3D strncmp(p, opt_name, opt_name_len) &amp;&amp; str=
len(p) &gt; (opt_name_len + 1)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &amp;&amp; p[opt_name_len] =3D=3D &#39; &#39;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /* option found, extrac=
t value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   const char *start =3D &amp;p[opt_name_len + 1];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            const char *end =3D strchr(p, &#=
39;,&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    size_t val_len =3D end ? end - start : strlen(start);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            ret =3D gc_malloc(val_len=
 + 1, true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         memcpy(ret, start, val_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        p =3D strchr(p, &#39;,&#39;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (p)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            p++; /* skip delimiter */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span>diff --git a/src/openvpn/options_string=2Eh b/src/openvpn/=
options_string=2Eh</span><br><span>new file mode 100644</span><br><span>ind=
ex 0000000=2E=2E02efed3</span><br><span>--- /dev/null</span><br><span>+++ b=
/src/openvpn/options_string=2Eh</span><br><span>@@ -0,0 +1,97 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunne=
l IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         over a single UDP port, with support for SSL/TLS-based</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             session authenti=
cation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet encryption, packet authentication, and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compres=
sion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 O=
penVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is free software; you can redistribute it and/or modify<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the ter=
ms of the GNU General Public License version 2</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPTIONS_STRI=
NG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPTIONS=
_STRING_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;op=
tions=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *options_str=
ing_version(const char *s, struct gc_arena *gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Bui=
ld an options string to represent data channel encryption options=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * This string must match =
exactly between peers=2E  The keysize is checked</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * separately by read_key()=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * The following options must match on both peers:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Tunnel options:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * --dev tun|tap [unit number need not match]</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * --dev-type tun|tap</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * --link-mtu</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * --udp-mtu</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * --tun-mtu</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * --proto udp</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * --proto tcp-client [matched with --proto tcp-serve=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                =
     on the other end of the connection]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * --proto tcp-server [matched with --proto tcp-client=
 on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              =
       the other end of the connection]</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * --tun-ipv6</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * --ifconfig x y [matched with --ifconfig y x on</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *                 the other en=
d of the connection]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --comp-lzo</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --compress alg</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --fragment</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Crypto Options:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * --cipher</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * --auth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --sec=
ret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * SSL Options:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * --tls-auth</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * --tls-client [matched with --tls-server on</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *               the other end of =
the connection]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * -=
-tls-server [matched with --tls-client on</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *               the other end of the connection]</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+char *options_string(const struct optio=
ns *o, const struct frame *frame, struct tuntap *tt,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     openvpn_net_ctx_t *c=
tx, bool remote, struct gc_arena *gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool options_cmp_equal_safe(char *actual, const char *expected, size_t actu=
al_n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void options_warning_safe(char *=
actual, const char *expected, size_t actual_n);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool options_cmp_equal(char *actual, const char *expected);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void options_warning(char *actual, const char=
 *expected);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Given an OpenVPN options string, extra=
ct the value of an option=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m options_string        Zero-terminated, comma-separated options string</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opt_name     =
         The name of the option to extract</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param gc                    The gc to allocate t=
he return value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return gc-allocat=
ed value of option with name opt_name if option was found,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *         or NULL otherwise=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+char *options_string_extract_option(cons=
t char *options_string, const char *opt_name,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                    struct gc_are=
na *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/s=
sl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 01e45fd=2E=2Ed5bd602 100=
644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl=2Ec</span><br><span>@@ -62,6 +62,7 @@</span><br><span> #include &q=
uot;auth_token=2Eh&quot;</span><br><span> #include &quot;mss=2Eh&quot;</spa=
n><br><span> #include &quot;dco=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;options_string=2Eh&quot;</span><br><sp=
an> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #inc=
lude &quot;openvpn=2Eh&quot;</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail"=
>change 1773</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1773 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--rHCAUQmc0ZQ=--


--===============6521004719681835274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6521004719681835274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6521004719681835274==--

