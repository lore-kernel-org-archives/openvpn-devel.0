Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF503606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X/nwe+ha;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Eky+smj4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gCRPoLWc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XjHf/tAX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DWxz4+K++WBnt97Cf8aSOoTU97efzzXkl3xRmwZgvDQ=; b=X/nwe+hahyCKcRtMr4bhqRwB52
	bO+9rriSFv3rgqc6xzSPkDidRJEEVka6cgrV5N2LQarYNUAVQtOflha/xtUCiq8q8a25m3SkZYxRg
	rlbmpAs3gLlkiqwEG+d9IEikn62U9eiDY3XhVJHWnmRqTVSri9NlyrRcoaqbTv6Y4CY0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOZDz-000000006xH-0Czk;
	Wed, 04 Nov 2026 11:32:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOZDy-000000006xA-0mti
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:32:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZYfq0JOuputjxKmKEAvg229C+5Pi7jb/2T10WGqKmA0=; b=Eky+smj4JfCR6jh0a7RbHrkGVX
 JnqKq1+NoVsjwIGH3eQIe8jIuCrP6klZTPp2PRSmOYLDnwCmMN76Wkkl7SkkZjUL2jm79cuCpxOBP
 Z41SJrCzH3oB+YDDvHQVuJDOvQA1lCnIc/oB/82Z4Ez++IK3AgEqI981h9HaBOWduVLE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZYfq0JOuputjxKmKEAvg229C+5Pi7jb/2T10WGqKmA0=; b=gCRPoLWcgUKseXJT7+brX9WUfz
 jefe8to2vKuySkfvzrEU5rcld5+Me6z6T+Q/xT0xHnd1v5cGhvt2Ea2zYAkQHp3a5sTS4yu6TbDQq
 bP3RyPSwTWLgRms8m/5N07/zDwSAYZt/1+zZZCbG79lN1zQZaV1URiNvU2wqN6zY5dYo=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOZDv-000000000uD-3qje for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:32:14 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso4444375e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 03:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793791925; x=1794396725; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZYfq0JOuputjxKmKEAvg229C+5Pi7jb/2T10WGqKmA0=;
 b=XjHf/tAXkBYWEya0wmoTQc0V7nXSAyr2QjHJQjdQ0+daYjeX4C+pkCHe1rqbreNBcL
 ctnbRTHSFn7F8MCWheP4cVvk/kNao/lUszQSPBZvFJ2PsYvN8GUy6wbwqVkfdJEnxTpx
 +kfcMzPrQJbr81zHQFj0EPHNdOvCYZpqMLlGlCD+CWbNQPkJeHmDiZgD8VisiLfGFkpo
 ySNAu9jqLB7pMEo4wxvfgAEOWCjD8jKwb8t/DCmxSVUr6FqZkquRYy/WSN6RopfpvhLC
 Ve4cJua+Zkbl5W2q2EHLPR3/Oc1PKKy6T05bUnb13cy204UsiEeZyQvuL01tKqnwm7F0
 g+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793791925; x=1794396725;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZYfq0JOuputjxKmKEAvg229C+5Pi7jb/2T10WGqKmA0=;
 b=bFwZGoz1nUn0z7M7DYSM9ILd5poIx4x9b7RRPITzUIxfNAOjC0NJ1JFWHIiOP7hH2h
 9znIU4Dy1dNTlKrvpqDBQmQzKcLCGMyVghjwzS5f7AklEkcn1ypyG3Iwz3HxHJh7L1UG
 zEyU8iwTeqRoq3KFVSLxsF6qNGrr0ozBUq4j2pXfVpdIaDrOF5+gn2MQnREZVObSTFTj
 lkQCQrNmRuFrpRcV01tcmNNZCjGs0UQQ7ipHy/VbS+6KBPXaYMWdQi8Je8/CtRC3YhTy
 TW1FIeCdfbdWDmvojNCFNS4YYz3GJtx+BvIH4gd44nH+hmht8oNd4kv/SO/dCl15YuBx
 jq3A==
X-Gm-Message-State: APuU4Z/jnXk1zhcHFnkLm3+FPXublNBUmR8xdIOMLMWyNuDPqQ242G4J
 3r53Vpj+gheK88Mv+u5/MMcQ3U93k8fduGOyGgxTTSm9XTx93t/riozNG5gpTTb/LDI25fBkdSS
 UZYhDc21HYwfzFDTK3eYO/pxkXi2TeGgTJNBtEndWYS8kaQjjC/do09o0B1IeGS6Cup3C
X-Gm-Gg: AYBFou0AEGR4JDpcBOoEAA1m0/QyMTfvSdlBxvYZa0D7HgP21x47FcCdmEv/LA7DqDA
 rwSferNbrq12SrzUlD/88z47Fmhui0RrMNIKASAC+yM4dKHRUMk6p+vFc6oqwvBdNtictAkXn8+
 EdUfyeSaQxbLegiSaBHS64tWVvvnRx6RSdpUkgadLtjL1+tkn03Be/Fst+xv/bL/iHZiH2aXJIt
 wjjbLfpU7TBH84nI/427fX0Lv4/F8UE++rJ9cAGzvENf6kMaTchR7Ty7GWpuBQY3uLbLF2ZdvvE
 +vk9PPf3TBEPSGL0GsXv5vxEZHv3ZGYN34GbTS8XbYFyt1yKjkRln/+T64tuK452Sd0BlB7f5Sf
 EOuKkpVm4QNfWlno03NddC8UE+jdWDW9/toGS7hl68K+/Mm9w21Ngrk30wx7fwNckjIsn1WqFOD
 YsY7E8n9lyen/J2EPAOhz514uYyUGguIPA5s2ZDgxY+YAow14ViXDLeFKVAT9oWsgN/alOC/aqw
 CFNyTbJ6KQxDz+MVisgsRCl7J/v6EZxKuEmR4bQE+X6VC/7c6I3q94SLr+6IRJQhpKhFhRxlR5V
 4uDF2TcPaFC+YizdCfzB+HQciAom3nsDwFh8CSZlnfltjIQ/JldI7lB6NdHrd0zOmSqCP2pdP89
 Tpi4Z5WisfNkn6OCZ4z15C4tq6UCClXqyC1n2DLdSau1BF2504WRnSvxXgsjfznZk1xoRF3/8gd
 vYUf7uAohuGS52VvgSix4LJO+e/swXY6uh47Q=
X-Received: by 2002:a05:600c:3ba5:b0:4a2:a6e:80f5 with SMTP id
 5b1f17b1804b1-4ac16fa356cmr433069945e9.11.1793791925153; 
 Wed, 04 Nov 2026 03:32:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4533873f0sm43655885e9.4.2026.11.04.03.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 03:32:04 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 11:32:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 3a483bb3abcdc7f7b80d59956cef6b90faf8fbd4
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <72ff667e23907d77de32e5d21e8a57ed4c6bff10-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOZDv-000000000uD-3qje
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support pre-existing
 Linux DCO interfaces
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
Content-Type: multipart/mixed; boundary="===============7479146354965820328=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7479146354965820328==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SYmJCCdUA7Q="; charset=UTF-8

--SYmJCCdUA7Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Hello Ant=
onio Quartulli, Arne Schwabe, 

I'd like you to reexamine a change=2E Pleas=
e visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail

t=
o look at the new patch set (#5)=2E

The change is no longer submittable: c=
hecks~ChecksSubmitRule is unsatisfied now=2E


Change subject: Support pre-=
existing Linux DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Support pre-existing Linux DCO interfaces

When creating a=
n ovpn interface returns -EEXIST, still retrieve the
ifindex and return the=
 error to the generic DCO open path=2E This lets the
caller mark the interf=
ace as pre-existing and avoid deleting it on
close=2E

Before accepting the=
 existing interface, query its rtnetlink link info
and verify that it is an=
 ovpn device with the expected mode=2E The ovpn
mode is fixed at interface =
creation time, so attaching to an interface
created for the other mode cann=
ot work=2E

Honor the pre-existing state on close by skipping net_iface_del=
() for
persistent interfaces=2E

Github: closes OpenVPN/openvpn#1064
Change=
-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
Signed-off-by: Ralf Lici <ra=
lf@mandelbit=2Ecom>
---
M src/openvpn/dco=2Eh
M src/openvpn/dco_linux=2Ec
M=
 src/openvpn/dco_linux=2Eh
M src/openvpn/networking=2Eh
M src/openvpn/netwo=
rking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/network=
ing_sitnl=2Eh
7 files changed, 185 insertions(+), 29 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/34/1734/5

diff=
 --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index c435f8c=2E=2E02ff9=
b3 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -109,7 +10=
9,8 @@
 bool ovpn_dco_init(struct context *c);
 
 /**
- * Open/create a DCO=
 interface
+ * Open/create a DCO interface and store its ifindex=2E
+ * If =
the interface already exists, save the ifindex anyway and return -EEXIST=2E=

  *
  * @param tt        the tuntap context
  * @param ctx       the netwo=
rking API context
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_=
linux=2Ec
index 4412ad0=2E=2Ee9cf0b7 100644
--- a/src/openvpn/dco_linux=2Ec=

+++ b/src/openvpn/dco_linux=2Ec
@@ -540,6 +540,19 @@
     CLEAR(dco);
 }
 =

+static const char *
+ovpn_mode_to_str(enum ovpn_mode mode)
+{
+    switch=
 (mode)
+    {
+        case OVPN_MODE_P2P:
+            return "p2p";
+   =
     case OVPN_MODE_MP:
+            return "server";
+    }
+    return "u=
nknown";
+}
+
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx,=
 const char *dev)
 {
@@ -547,11 +560,30 @@
     ASSERT(tt->type =3D=3D DEV_=
TYPE_TUN);
 
     int ret =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &tt=
->dco);
-    if (ret < 0)
+    if (ret < 0 && ret !=3D -EEXIST)
     {
    =
     msg(D_DCO_DEBUG, "Cannot create DCO interface %s: %d", dev, ret);
    =
     return ret;
     }
+    if (ret =3D=3D -EEXIST)
+    {
+        enum o=
vpn_mode mode;
+        int mode_ret =3D net_iface_ovpn_mode(ctx, dev, &mod=
e);
+
+        if (mode_ret < 0)
+        {
+            msg(M_WARN, "DCO: =
cannot retrieve mode of existing interface %s: %s (%d)", dev,
+            =
    strerror(-mode_ret), mode_ret);
+            return mode_ret;
+        =
}
+
+        if (mode !=3D tt->dco=2Eifmode)
+        {
+            msg(M_=
WARN, "DCO: existing interface %s is in %s mode, expected %s mode",
+      =
          dev, ovpn_mode_to_str(mode), ovpn_mode_to_str(tt->dco=2Eifmode));=

+            return -EINVAL;
+        }
+    }
 
     tt->dco=2Eifindex =
=3D if_nametoindex(dev);
     if (!tt->dco=2Eifindex)
@@ -559,7 +591,7 @@
 =
        msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);=

     }
 
-    return 0;
+    return ret;
 }
 
 void
@@ -567,7 +599,10 @@
 =
{
     msg(D_DCO_DEBUG, __func__);
 
-    net_iface_del(ctx, tt->actual_nam=
e);
+    if (!tt->persistent_if)
+    {
+        net_iface_del(ctx, tt->act=
ual_name);
+    }
     ovpn_dco_uninit_netlink(&tt->dco);
 }
 
diff --git a=
/src/openvpn/dco_linux=2Eh b/src/openvpn/dco_linux=2Eh
index c487581=2E=2Ea=
999d77 100644
--- a/src/openvpn/dco_linux=2Eh
+++ b/src/openvpn/dco_linux=
=2Eh
@@ -24,6 +24,7 @@
 #if defined(ENABLE_DCO) && defined(TARGET_LINUX)
 
=
 #include "event=2Eh"
+#include "networking_sitnl=2Eh"
 
 #include "ovpn_dc=
o_linux=2Eh"
 
@@ -38,28 +39,6 @@
 typedef enum ovpn_key_slot dco_key_slot_=
t;
 typedef enum ovpn_cipher_alg dco_cipher_t;
 
-/* OVPN section */
-
-#if=
ndef IFLA_OVPN_MAX
-
-enum ovpn_mode
-{
-    OVPN_MODE_P2P,
-    OVPN_MODE_=
MP,
-};
-
-enum ovpn_ifla_attrs
-{
-    IFLA_OVPN_UNSPEC =3D 0,
-    IFLA_O=
VPN_MODE,
-
-    __IFLA_OVPN_MAX,
-};
-
-#define IFLA_OVPN_MAX (__IFLA_OVPN=
_MAX - 1)
-
-#endif /* ifndef IFLA_OVPN_MAX */
-
 typedef struct
 {
     /*=
 socket used for synchronous request/reply transactions (commands and
diff =
--git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index 25233=
c8=2E=2E2423637 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/n=
etworking=2Eh
@@ -115,6 +115,19 @@
  */
 int net_iface_type(openvpn_net_ctx=
_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX]);
 
+#if defined(=
ENABLE_DCO) && defined(TARGET_LINUX)
+/**
+ * Retrieve the ovpn interface m=
ode
+ *
+ * @param ctx       the implementation specific context
+ * @param=
 iface     interface to query
+ * @param mode      variable where the ovpn =
mode attribute will be stored
+ *
+ * @return          0 on success, a nega=
tive error code otherwise
+ */
+int net_iface_ovpn_mode(openvpn_net_ctx_t *=
ctx, const char *iface, enum ovpn_mode *mode);
+#endif
+
 /**
  * Remove an=
 interface
  *
diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openv=
pn/networking_iproute2=2Ec
index f091fb3=2E=2E3fc7bc1 100644
--- a/src/open=
vpn/networking_iproute2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -8=
2,6 +82,16 @@
     return -1;
 }
 
+#if defined(ENABLE_DCO)
+int
+net_iface=
_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode)=

+{
+    /* not supported by iproute2 */
+    msg(M_WARN, "%s: operation no=
t supported by iproute2 backend", __func__);
+    return -EOPNOTSUPP;
+}
+#=
endif
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
d=
iff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=
=2Ec
index 0c99d38=2E=2E756eefa 100644
--- a/src/openvpn/networking_sitnl=
=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -1430,8 +1430,18 @@
     ret=
urn 0;
 }
 
-int
-net_iface_type(openvpn_net_ctx_t *ctx, const char *iface,=
 char type[IFACE_TYPE_LEN_MAX])
+/**
+ * Issue an RTM_GETLINK query for an =
interface and feed the reply to the given
+ * parsing callback=2E
+ *
+ * @=
param iface     name of the interface to query
+ * @param cb        callbac=
k invoked with the netlink reply
+ * @param arg       opaque argument passe=
d through to the callback
+ *
+ * @return          0 on success, a negative=
 error code otherwise
+ */
+static int
+sitnl_link_get(const char *iface, s=
itnl_parse_reply_cb cb, void *arg)
 {
     struct sitnl_link_req req =3D {}=
;
     int ifindex =3D if_nametoindex(iface);
@@ -1448,9 +1458,15 @@
     r=
eq=2Ei=2Eifi_family =3D AF_PACKET;
     req=2Ei=2Eifi_index =3D ifindex;
 
=
+    return sitnl_send(&req=2En, 0, 0, cb, arg);
+}
+
+int
+net_iface_type(=
openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
+=
{
     memset(type, 0, IFACE_TYPE_LEN_MAX);
 
-    int ret =3D sitnl_send(&=
req=2En, 0, 0, sitnl_type_save, type);
+    int ret =3D sitnl_link_get(ifac=
e, sitnl_type_save, type);
     if (ret < 0)
     {
         msg(D_ROUTE, "=
%s: cannot retrieve iface %s: %s (%d)", __func__, iface, strerror(-ret), re=
t);
@@ -1462,6 +1478,82 @@
     return 0;
 }
 
+#if defined(ENABLE_DCO)
+st=
atic int
+sitnl_ovpn_mode_save(struct nlmsghdr *n, void *arg)
+{
+    struc=
t ifinfomsg *ifi =3D NLMSG_DATA(n);
+    struct rtattr *tb[IFLA_MAX + 1];
+=
    struct rtattr *tb_link[IFLA_INFO_MAX + 1];
+    struct rtattr *tb_data[=
IFLA_OVPN_MAX + 1];
+    enum ovpn_mode *mode =3D arg;
+    uint8_t raw_mod=
e;
+
+    if (n->nlmsg_type !=3D RTM_NEWLINK)
+    {
+        return -EINVA=
L;
+    }
+
+    if (n->nlmsg_len < NLMSG_LENGTH(sizeof(*ifi)))
+    {
+   =
     return -EINVAL;
+    }
+
+    sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RT=
A(ifi), IFLA_PAYLOAD(n));
+
+    if (!tb[IFLA_LINKINFO])
+    {
+        re=
turn -ENOENT;
+    }
+
+    sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MA=
X, tb[IFLA_LINKINFO]);
+
+    if (!tb_link[IFLA_INFO_KIND]
+        || strc=
mp(RTA_DATA(tb_link[IFLA_INFO_KIND]), OVPN_FAMILY_NAME) !=3D 0)
+    {
+   =
     return -EINVAL;
+    }
+
+    if (!tb_link[IFLA_INFO_DATA])
+    {
+  =
      return -ENOENT;
+    }
+
+    sitnl_parse_rtattr_nested(tb_data, IFLA=
_OVPN_MAX, tb_link[IFLA_INFO_DATA]);
+
+    if (!tb_data[IFLA_OVPN_MODE])
+=
    {
+        return -ENOENT;
+    }
+
+    if (RTA_PAYLOAD(tb_data[IFLA_O=
VPN_MODE]) < sizeof(raw_mode))
+    {
+        return -EINVAL;
+    }
+
+  =
  raw_mode =3D *(uint8_t *)RTA_DATA(tb_data[IFLA_OVPN_MODE]);
+    *mode =
=3D (enum ovpn_mode)raw_mode;
+
+    return 0;
+}
+
+int
+net_iface_ovpn_mo=
de(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode)
+{
+   =
 int ret =3D sitnl_link_get(iface, sitnl_ovpn_mode_save, mode);
+    if (re=
t < 0)
+    {
+        msg(D_ROUTE, "%s: cannot retrieve ovpn mode for ifac=
e %s: %s (%d)", __func__, iface,
+            strerror(-ret), ret);
+      =
  return ret;
+    }
+
+    msg(D_ROUTE, "%s: mode of %s: %d", __func__, if=
ace, *mode);
+
+    return 0;
+}
+#endif /* defined(ENABLE_DCO) */
+
 int
 =
net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
diff --git a/sr=
c/openvpn/networking_sitnl=2Eh b/src/openvpn/networking_sitnl=2Eh
index 481=
cc36=2E=2E7a2d964 100644
--- a/src/openvpn/networking_sitnl=2Eh
+++ b/src/o=
penvpn/networking_sitnl=2Eh
@@ -24,4 +24,30 @@
 typedef char openvpn_net_if=
ace_t;
 typedef void *openvpn_net_ctx_t;
 
+#if defined(TARGET_LINUX)
+
+#i=
nclude <linux/if_link=2Eh>
+
+#ifndef IFLA_OVPN_MAX
+
+enum ovpn_mode
+{
+ =
   OVPN_MODE_P2P,
+    OVPN_MODE_MP,
+};
+
+enum ovpn_ifla_attrs
+{
+    IF=
LA_OVPN_UNSPEC =3D 0,
+    IFLA_OVPN_MODE,
+
+    __IFLA_OVPN_MAX,
+};
+
+#=
define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
+
+#endif /* ifndef IFLA_OVPN_MA=
X */
+
+#endif /* if defined(TARGET_LINUX) */
+
 #endif /* NETWORKING_SITNL=
_H_ */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7230240=
3bddee4b0b0ee2441ae9e246f48d0bc81
Gerrit-Change-Number: 1734
Gerrit-PatchSe=
t: 5
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--SYmJCCdUA7Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Ralf Lici <strong>=
uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><p>T=
he change is no longer submittable: checks~ChecksSubmitRule is unsatisfied =
now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Support pre-existing Linux DCO interfaces<br><br>Wh=
en creating an ovpn interface returns -EEXIST, still retrieve the<br>ifinde=
x and return the error to the generic DCO open path=2E This lets the<br>cal=
ler mark the interface as pre-existing and avoid deleting it on<br>close=2E=
<br><br>Before accepting the existing interface, query its rtnetlink link i=
nfo<br>and verify that it is an ovpn device with the expected mode=2E The o=
vpn<br>mode is fixed at interface creation time, so attaching to an interfa=
ce<br>created for the other mode cannot work=2E<br><br>Honor the pre-existi=
ng state on close by skipping net_iface_del() for<br>persistent interfaces=
=2E<br><br>Github: closes OpenVPN/openvpn#1064<br>Change-Id: I72302403bddee=
4b0b0ee2441ae9e246f48d0bc81<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=
=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_linux=2Ec<b=
r>M src/openvpn/dco_linux=2Eh<br>M src/openvpn/networking=2Eh<br>M src/open=
vpn/networking_iproute2=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/=
openvpn/networking_sitnl=2Eh<br>7 files changed, 185 insertions(+), 29 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/34/1734/5</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2E=
h b/src/openvpn/dco=2Eh</span><br><span>index c435f8c=2E=2E02ff9b3 100644</=
span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/=
dco=2Eh</span><br><span>@@ -109,7 +109,8 @@</span><br><span> bool ovpn_dco_=
init(struct context *c);</span><br><span> </span><br><span> /**</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Open/create a DCO interface</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Open/create a DCO i=
nterface and store its ifindex=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * If the interface already exists, save the ifindex anyway a=
nd return -EEXIST=2E</span><br><span>  *</span><br><span>  * @param tt     =
   the tuntap context</span><br><span>  * @param ctx       the networking A=
PI context</span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/ope=
nvpn/dco_linux=2Ec</span><br><span>index 4412ad0=2E=2Ee9cf0b7 100644</span>=
<br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn=
/dco_linux=2Ec</span><br><span>@@ -540,6 +540,19 @@</span><br><span>     CL=
EAR(dco);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ovpn_mode_to_str(enum ovpn_mode mode)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    switch (mode)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case OVPN_MODE_P2P:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return &quot;p2p&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        case OVPN_MODE_MP:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return &quot;server&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;unknown&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><s=
pan> open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *de=
v)</span><br><span> {</span><br><span>@@ -547,11 +560,30 @@</span><br><span=
>     ASSERT(tt-&gt;type =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br>=
<span>     int ret =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &amp;tt-&g=
t;dco);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &l=
t; 0 &amp;&amp; ret !=3D -EEXIST)</span><br><span>     {</span><br><span>  =
       msg(D_DCO_DEBUG, &quot;Cannot create DCO interface %s: %d&quot;, dev=
, ret);</span><br><span>         return ret;</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D -EEXIST)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        enum ovpn_mode mode;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int mode_ret =3D=
 net_iface_ovpn_mode(ctx, dev, &amp;mode);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (mode_ret &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_WARN, &quot;DCO: cannot retrieve mode of existing inte=
rface %s: %s (%d)&quot;, dev,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                strerror(-mode_ret), mode_ret);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return mode_ret;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (mode !=3D tt-&gt;dco=2Eifmode)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;DCO: existing =
interface %s is in %s mode, expected %s mode&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                dev, ovpn_mode_to_str(mod=
e), ovpn_mode_to_str(tt-&gt;dco=2Eifmode));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return -EINVAL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     tt-&gt=
;dco=2Eifindex =3D if_nametoindex(dev);</span><br><span>     if (!tt-&gt;dc=
o=2Eifindex)</span><br><span>@@ -559,7 +591,7 @@</span><br><span>         m=
sg(M_FATAL, &quot;DCO: cannot retrieve ifindex for interface %s&quot;, dev)=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return ret;</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span>@@ -567,7 +599,10 @@</span><br><span> {</spa=
n><br><span>     msg(D_DCO_DEBUG, __func__);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    net_iface_del(ctx, tt-&gt;actu=
al_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!t=
t-&gt;persistent_if)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        net_i=
face_del(ctx, tt-&gt;actual_name);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span>     ovpn_dco_uninit_netlink(&amp;tt-&=
gt;dco);</span><br><span> }</span><br><span> </span><br><span>diff --git a/=
src/openvpn/dco_linux=2Eh b/src/openvpn/dco_linux=2Eh</span><br><span>index=
 c487581=2E=2Ea999d77 100644</span><br><span>--- a/src/openvpn/dco_linux=2E=
h</span><br><span>+++ b/src/openvpn/dco_linux=2Eh</span><br><span>@@ -24,6 =
+24,7 @@</span><br><span> #if defined(ENABLE_DCO) &amp;&amp; defined(TARGET=
_LINUX)</span><br><span> </span><br><span> #include &quot;event=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;networ=
king_sitnl=2Eh&quot;</span><br><span> </span><br><span> #include &quot;ovpn=
_dco_linux=2Eh&quot;</span><br><span> </span><br><span>@@ -38,28 +39,6 @@</=
span><br><span> typedef enum ovpn_key_slot dco_key_slot_t;</span><br><span>=
 typedef enum ovpn_cipher_alg dco_cipher_t;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/* OVPN section */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifndef IFLA_OVPN_MAX</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum =
ovpn_mode</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_MODE_P2P,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    OVPN_MODE_MP,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum=
 ovpn_ifla_attrs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    IFLA_OVPN_UNSPEC =3D =
0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    IFLA_OVPN_MODE,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    __IFLA_OVPN_MAX,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif =
/* ifndef IFLA_OVPN_MAX */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> typedef struct</span><br><span> {</span><br><span>  =
   /* socket used for synchronous request/reply transactions (commands and<=
/span><br><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/netwo=
rking=2Eh</span><br><span>index 25233c8=2E=2E2423637 100644</span><br><span=
>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/network=
ing=2Eh</span><br><span>@@ -115,6 +115,19 @@</span><br><span>  */</span><br=
><span> int net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char =
type[IFACE_TYPE_LEN_MAX]);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO) &amp;&amp; defined(TARGET_=
LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Retrieve the ovpn interfac=
e mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx       the implem=
entation specific context</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param iface     interface to query</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param mode      variable where the ovpn mode a=
ttribute will be stored</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return   =
       0 on success, a negative error code otherwise</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+int net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const cha=
r *iface, enum ovpn_mode *mode);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /**</span><br><span>  * Remove an interface</span><br><sp=
an>  *</span><br><span>diff --git a/src/openvpn/networking_iproute2=2Ec b/s=
rc/openvpn/networking_iproute2=2Ec</span><br><span>index f091fb3=2E=2E3fc7b=
c1 100644</span><br><span>--- a/src/openvpn/networking_iproute2=2Ec</span><=
br><span>+++ b/src/openvpn/networking_iproute2=2Ec</span><br><span>@@ -82,6=
 +82,16 @@</span><br><span>     return -1;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENA=
BLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_ovpn_mode(openvpn=
_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* not supported by iproute2 */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN, &quot;%s: operation not=
 supported by iproute2 backend&quot;, __func__);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return -EOPNOTSUPP;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> int</span><br><span> net_iface_del(openvpn_net_ctx_t *=
ctx, const char *iface)</span><br><span> {</span><br><span>diff --git a/src=
/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br>=
<span>index 0c99d38=2E=2E756eefa 100644</span><br><span>--- a/src/openvpn/n=
etworking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec<=
/span><br><span>@@ -1430,8 +1430,18 @@</span><br><span>     return 0;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_ifac=
e_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_=
MAX])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Issue an RTM_GETLINK query =
for an interface and feed the reply to the given</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * parsing callback=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param iface     name of the interface to query</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param cb        callbac=
k invoked with the netlink reply</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param arg       opaque argument passed through to the call=
back</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return          0 on success=
, a negative error code otherwise</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_link_=
get(const char *iface, sitnl_parse_reply_cb cb, void *arg)</span><br><span>=
 {</span><br><span>     struct sitnl_link_req req =3D {};</span><br><span> =
    int ifindex =3D if_nametoindex(iface);</span><br><span>@@ -1448,9 +1458=
,15 @@</span><br><span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span><br><=
span>     req=2Ei=2Eifi_index =3D ifindex;</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_send(&amp;req=2En=
, 0, 0, cb, arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+net_iface_type(openvpn_net_ctx_t *ctx, const char *ifac=
e, char type[IFACE_TYPE_LEN_MAX])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span>     memset(type, 0, IFACE_TYPE_LEN_MAX);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt ret =3D sitnl_send(&amp;req=2En, 0, 0, sitnl_type_save, type);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D sitnl_link_ge=
t(iface, sitnl_type_save, type);</span><br><span>     if (ret &lt; 0)</span=
><br><span>     {</span><br><span>         msg(D_ROUTE, &quot;%s: cannot re=
trieve iface %s: %s (%d)&quot;, __func__, iface, strerror(-ret), ret);</spa=
n><br><span>@@ -1462,6 +1478,82 @@</span><br><span>     return 0;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+sitnl_ovpn_mode_save(struct nlmsghdr *n, void *arg)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct ifinfomsg *ifi =3D NLMSG_DATA(n);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct rtattr *tb[IFLA_MAX + =
1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct rtatt=
r *tb_link[IFLA_INFO_MAX + 1];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct rtattr *tb_data[IFLA_OVPN_MAX + 1];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    enum ovpn_mode *mode =3D arg;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t raw_mode;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (n-&gt;nlmsg_type !=3D RTM_NEWLIN=
K)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (n-&gt;nlmsg_len &lt; NLMSG_LENGTH(sizeof(*ifi)))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!tb[IFLA_LINKINFO])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO=
]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!tb_link[IFLA_INFO_KIND]</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        || strcmp(RTA_=
DATA(tb_link[IFLA_INFO_KIND]), OVPN_FAMILY_NAME) !=3D 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!tb_link[IFLA_INFO_DATA])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return -ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    sitnl_parse_rtattr_nested(tb_da=
ta, IFLA_OVPN_MAX, tb_link[IFLA_INFO_DATA]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!tb_data[IFLA_OVPN_MODE])</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return -ENOENT;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (RTA_PAYLOAD(tb_=
data[IFLA_OVPN_MODE]) &lt; sizeof(raw_mode))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return -EINVAL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    raw_mode =3D *=
(uint8_t *)RTA_DATA(tb_data[IFLA_OVPN_MODE]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    *mode =3D (enum ovpn_mode)raw_mode;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+net_iface_ovpn_mode(openvpn_net_=
ctx_t *ctx, const char *iface, enum ovpn_mode *mode)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int ret =3D sitnl_link_get(iface, sitnl_ovpn_mode_save,=
 mode);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =
&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot=
;%s: cannot retrieve ovpn mode for iface %s: %s (%d)&quot;, __func__, iface=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            strerr=
or(-ret), ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: mode of %s=
: %d&quot;, __func__, iface, *mode);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(ENABLE_D=
CO) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> int</span><br><span> net_iface_del(openvpn_net_ctx_t *ctx, const char =
*iface)</span><br><span> {</span><br><span>diff --git a/src/openvpn/network=
ing_sitnl=2Eh b/src/openvpn/networking_sitnl=2Eh</span><br><span>index 481c=
c36=2E=2E7a2d964 100644</span><br><span>--- a/src/openvpn/networking_sitnl=
=2Eh</span><br><span>+++ b/src/openvpn/networking_sitnl=2Eh</span><br><span=
>@@ -24,4 +24,30 @@</span><br><span> typedef char openvpn_net_iface_t;</spa=
n><br><span> typedef void *openvpn_net_ctx_t;</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;linux/if_link=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef IFLA_OVPN_MAX</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+enum ovpn_mode</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE=
_P2P,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE_=
MP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+enum ovpn_ifla_attrs</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    IFLA_OVPN_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    IFLA_OVPN_MODE,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _=
_IFLA_OVPN_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX -=
 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef IFLA_OVPN_MAX */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_LINUX) */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #end=
if /* NETWORKING_SITNL_H_ */</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">change 1734</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7=
2302403bddee4b0b0ee2441ae9e246f48d0bc81 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1734 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Ralf Lici &lt;ral=
f@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>

</body></html>
--SYmJCCdUA7Q=--


--===============7479146354965820328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7479146354965820328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7479146354965820328==--

