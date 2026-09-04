Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE07C79F80
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TtZ0MvwE097/SYNOABRz81gAROlN5I7u/JORLAHVnd0=; b=NRum0ISQEb6ekKTnicpBVn+Gpb
	KfIynYMNhv/Cnmu7XNWxgWWVMh5CvWmVs+P6gG9PX4gW17wlU3p4T6CULzQDUJloxiTAwF4qztz+c
	ijkNn9p5+++VVO1Vmi+Ue2STcXrH0w12Jk1YLcS7au8vKtfE8dJwu6dUAiuSXS6PHXpQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2QMe-0007Yt-2M;
	Fri, 04 Sep 2026 09:37:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2QMb-0007Yg-21
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 09:37:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GtfR7m3zHDBRjuijspINLjpPq6M0kQJhUUfvXxd/VEk=; b=j6Mf96ccTzuehkIoS8LX2xkME3
 WzE4H/dz4aWjBYMeX1sFSmbrvxM0IKQeEKJ+0FcRKABJZo1z3p/sJbTmkD9jMBLzOdYFUzFu6YPie
 +sF+WRj74DuU5SBWBhcG4U8CIbgnyVHbicpDyJmosAfsTtd3qSrVJM9zFOt3PhsGHAJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GtfR7m3zHDBRjuijspINLjpPq6M0kQJhUUfvXxd/VEk=; b=l
 oexKXlmSg73HWAi3OusSD04eamuzRvUOkcXsN/eqAgSpmYbwYpwQdVrCq3Ogv9T4Q93+q7EmR1Ple
 jx/vLkxF9Bb9ouM90OmEgpqF8OSqMG/Sh9FdNRpxPGgUyKjBpPEsoZja2+PI+vJTnYpMTqouEblmI
 X6bwsQPcRd2sxhUY=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2QMY-0008Aq-IO for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 09:37:36 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso7397285e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788514648; x=1789119448; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GtfR7m3zHDBRjuijspINLjpPq6M0kQJhUUfvXxd/VEk=;
 b=LbF4wZItqpCe+aOdwfC3j4mTKO3FI3sgPFMxZNjutvXB3/D/w6kDcFYVlgEaF6B5O3
 PvIvh3V4t/JHd3nudTfsNjqqDw8BrMjHnt1m/Z4E5nHkXMA5ZNFE24JmkkwBC4KIj8qZ
 o5OqrgxiZ2sonWb/CLXhtNoOqyTqvTFClIZ6n57TCNo2AEjOGlk6In/loGzYH9YDETsy
 YZv8fO38k8lwolKmZh5SMIjtfYNT5CaIA37doq0NzJdvXKJg72ykEvFLwI3koBTnxKYB
 WIpamOrtoHVUR+fw2qPBYgF4Oi/sx8lHccy6mkjs0BuAy+kWXyf7V39v0cuVF1jfORj0
 UzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788514648; x=1789119448;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GtfR7m3zHDBRjuijspINLjpPq6M0kQJhUUfvXxd/VEk=;
 b=g0fLsRhdKMwe0TE/gWCJHwqcsWrNPYsL7Xyf8CT1jQebRNQRDvOLVCg5T3WUxMPF2Z
 ZHo9tOd9QAj1s/fXx8g0y3r+jlKZla7DfwxYLc8Zdug3yKP6lDroRFeTuJwgZF6FSOgZ
 r/s8mQU229paeEQ4MZbaRnhU5QB5hvL2cLALOuuMOScm46OtGu23rWA3oZC6zXd7y+cr
 s8+XOcHG0HCBaM5S4IrAHQ52tQ7Fh6Kk/xk+M+v/IcSAwoDJVqMAheDkXIwSMFYipijO
 dxVd3steAHDqrDMSO6ZiSCUgougsdaU9PKUytxk+6eH12Ms/W/ADTjiXc5AlsYRJ9NZ2
 LtMw==
X-Gm-Message-State: AFuF++mYnNED646jsq3FUbGVF0AX7cHLSgOgQzSnknKW4FRV53e8YuFT
 V8yyibrjG3YW8EQwYTg+Aj+H9W9ADlRKj71/Y4iqgTiXebzFHAu24v0q0nkhj+/hBK0bbO/zJX/
 ZCB97GwLWhcegkZG0UQXQMCS9Xez7Xj8iM03S/cdaXMXuVESuOCPbPz+3m2xHFv9kB/1P
X-Gm-Gg: AYBFou0B0jW72rawb4RYBS16G47G4YUAcG3QrnyfTY6wex1x6k2N3y0HMSLXWUhVRLi
 vWl8Dt9zHqf2FxAc429lHQ/8RhgpuAiOfs0kw1DmtGV0uuPhOaae1U0DC4v+5hc3T00zuhEYTJE
 POqi+1RqDBGP1+RcXSeXhUErg+iMo+9REjrv/WYemZ/eNPwgRMRMNwtm6T4jW0iCGP9xwnAYGEr
 7fz2iBBpG8fGcsOwn1YB7x8NNXNxZK0tR7NW/2Dmq5nQdcNBRne+smwxlmnp4k9LZ3Xu/hMSa9T
 ytHjZCE5JRPCCdBTsG9pBmn4tQ9GhWmW06xDYxxKRd/0fCDpS0bLtlO2FGsNSpkyJ1kC1pVWa++
 3Bbtt5UE1mke82GUdRtcP5qunwM3QY2RmViQZpyRPpxQQ6Yndn/L596SgWbony8xkYwk+/5C4BQ
 eBCiFkSHhfcY+HznV4VH/loi81Ku4QpKFKvi8DgI1cBMDDkzjHYuivdP3AfbTRLkSu9scKRqWCX
 PxmRGPmbOtVDeH7eUFFpg+Q219+XlSVeDedqT65wIfVma78V92L2Rev+IF8cQhzy0YXhJ7hL9MB
 TMU/Uvq/3TKwlobsKc3fipBKJlCOkSvT89GktZ+QCBvP1cLLHo4=
X-Received: by 2002:a05:600c:4e90:b0:49c:f3dd:e166 with SMTP id
 5b1f17b1804b1-49cf826ca60mr40788045e9.13.1788514647744; 
 Fri, 04 Sep 2026 02:37:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7736132sm54703195e9.12.2026.09.04.02.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 02:37:26 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 4 Sep 2026 09:37:25 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 5c8c4bf4b9c7a4ab34c99e6b899c0d939dc6e479
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b9e083efb2ca0302f5b8806cfa6521fcc25a12cf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2QMY-0008Aq-IO
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support pre-existing
 Linux DCO interfaces
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8160605906283346253=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8160605906283346253==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v/fhYDbaJj4="; charset=UTF-8

--v/fhYDbaJj4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos, ralf_lici=2E

Hello=
 ordex, plaisthos, 

I'd like you to reexamine a change=2E Please visit

  =
  http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail

to look at th=
e new patch set (#2)=2E

The following approvals got outdated and were remo=
ved:
Code-Review-1 by ordex


Change subject: Support pre-existing Linux DC=
O interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Support pre-existing Linux DCO interfaces

When creating an ovpn interfac=
e returns -EEXIST, still retrieve the
ifindex and return the error to the g=
eneric DCO open path=2E This lets the
caller mark the interface as pre-exis=
ting and avoid deleting it on
close=2E

Before accepting the existing inter=
face, query its rtnetlink link info
and verify that it is an ovpn device wi=
th the expected mode=2E The ovpn
mode is fixed at interface creation time, =
so attaching to an interface
created for the other mode cannot work=2E

Hon=
or the pre-existing state on close by skipping net_iface_del() for
persiste=
nt interfaces=2E

Github: closes OpenVPN/openvpn#1064
Change-Id: I72302403b=
ddee4b0b0ee2441ae9e246f48d0bc81
Signed-off-by: Ralf Lici <ralf@mandelbit=2E=
com>
---
M src/openvpn/dco=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dc=
o_linux=2Eh
M src/openvpn/networking=2Eh
M src/openvpn/networking_iproute2=
=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/networking_sitnl=2Eh
=
7 files changed, 185 insertions(+), 29 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/34/1734/2

diff --git a/src/o=
penvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 4e5aad5=2E=2E4584004 100644
--- =
a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -109,7 +109,8 @@
 bool o=
vpn_dco_init(struct context *c);
 
 /**
- * Open/create a DCO interface
+ *=
 Open/create a DCO interface and store its ifindex=2E
+ * If the interface =
already exists, save the ifindex anyway and return -EEXIST=2E
  *
  * @para=
m tt        the tuntap context
  * @param ctx       the networking API cont=
ext
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
inde=
x 56f6259=2E=2E777b43c 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/ope=
nvpn/dco_linux=2Ec
@@ -502,6 +502,19 @@
     CLEAR(dco);
 }
 
+static const=
 char *
+ovpn_mode_to_str(enum ovpn_mode mode)
+{
+    switch (mode)
+    {=

+        case OVPN_MODE_P2P:
+            return "p2p";
+        case OVPN=
_MODE_MP:
+            return "server";
+    }
+    return "unknown";
+}
+
=
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *d=
ev)
 {
@@ -509,11 +522,30 @@
     ASSERT(tt->type =3D=3D DEV_TYPE_TUN);
 
 =
    int ret =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &tt->dco);
-    i=
f (ret < 0)
+    if (ret < 0 && ret !=3D -EEXIST)
     {
         msg(D_DCO=
_DEBUG, "Cannot create DCO interface %s: %d", dev, ret);
         return re=
t;
     }
+    if (ret =3D=3D -EEXIST)
+    {
+        enum ovpn_mode mode;=

+        int mode_ret =3D net_iface_ovpn_mode(ctx, dev, &mode);
+
+       =
 if (mode_ret < 0)
+        {
+            msg(M_WARN, "DCO: cannot retriev=
e mode of existing interface %s: %s (%d)", dev,
+                strerror(-=
mode_ret), mode_ret);
+            return mode_ret;
+        }
+
+        i=
f (mode !=3D tt->dco=2Eifmode)
+        {
+            msg(M_WARN, "DCO: ex=
isting interface %s is in %s mode, expected %s mode",
+                dev,=
 ovpn_mode_to_str(mode), ovpn_mode_to_str(tt->dco=2Eifmode));
+            =
return -EINVAL;
+        }
+    }
 
     tt->dco=2Eifindex =3D if_nametoind=
ex(dev);
     if (!tt->dco=2Eifindex)
@@ -521,7 +553,7 @@
         msg(M_FA=
TAL, "DCO: cannot retrieve ifindex for interface %s", dev);
     }
 
-    r=
eturn 0;
+    return ret;
 }
 
 void
@@ -529,7 +561,10 @@
 {
     msg(D_DCO=
_DEBUG, __func__);
 
-    net_iface_del(ctx, tt->actual_name);
+    if (!tt=
->persistent_if)
+    {
+        net_iface_del(ctx, tt->actual_name);
+    =
}
     ovpn_dco_uninit_netlink(&tt->dco);
 }
 
diff --git a/src/openvpn/dco=
_linux=2Eh b/src/openvpn/dco_linux=2Eh
index e3e4824=2E=2E42df09e 100644
--=
- a/src/openvpn/dco_linux=2Eh
+++ b/src/openvpn/dco_linux=2Eh
@@ -24,6 +24,=
7 @@
 #if defined(ENABLE_DCO) && defined(TARGET_LINUX)
 
 #include "event=
=2Eh"
+#include "networking_sitnl=2Eh"
 
 #include "ovpn_dco_linux=2Eh"
 
@=
@ -38,28 +39,6 @@
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum=
 ovpn_cipher_alg dco_cipher_t;
 
-/* OVPN section */
-
-#ifndef IFLA_OVPN_M=
AX
-
-enum ovpn_mode
-{
-    OVPN_MODE_P2P,
-    OVPN_MODE_MP,
-};
-
-enum =
ovpn_ifla_attrs
-{
-    IFLA_OVPN_UNSPEC =3D 0,
-    IFLA_OVPN_MODE,
-
-   =
 __IFLA_OVPN_MAX,
-};
-
-#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
-
-#en=
dif /* ifndef IFLA_OVPN_MAX */
-
 typedef struct
 {
     struct nl_sock *nl=
_sock;
diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh=

index bce0c19=2E=2Ecab560c 100644
--- a/src/openvpn/networking=2Eh
+++ b/s=
rc/openvpn/networking=2Eh
@@ -115,6 +115,19 @@
  */
 int net_iface_type(ope=
nvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX]);
 
+=
#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+/**
+ * Retrieve the ovpn=
 interface mode
+ *
+ * @param ctx       the implementation specific contex=
t
+ * @param iface     interface to query
+ * @param mode      variable whe=
re the ovpn mode attribute will be stored
+ *
+ * @return          0 on suc=
cess, a negative error code otherwise
+ */
+int net_iface_ovpn_mode(openvpn=
_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode);
+#endif
+
 /**
 =
 * Remove an interface
  *
diff --git a/src/openvpn/networking_iproute2=2Ec=
 b/src/openvpn/networking_iproute2=2Ec
index a1f3525=2E=2E85ab158 100644
--=
- a/src/openvpn/networking_iproute2=2Ec
+++ b/src/openvpn/networking_iprout=
e2=2Ec
@@ -82,6 +82,16 @@
     return -1;
 }
 
+#if defined(ENABLE_DCO)
+in=
t
+net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn=
_mode *mode)
+{
+    /* not supported by iproute2 */
+    msg(M_WARN, "%s: =
operation not supported by iproute2 backend", __func__);
+    return -EOPNO=
TSUPP;
+}
+#endif
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char =
*iface)
 {
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/netw=
orking_sitnl=2Ec
index a396255=2E=2E9d07638 100644
--- a/src/openvpn/networ=
king_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -1432,8 +1432,18 @=
@
     return 0;
 }
 
-int
-net_iface_type(openvpn_net_ctx_t *ctx, const ch=
ar *iface, char type[IFACE_TYPE_LEN_MAX])
+/**
+ * Issue an RTM_GETLINK que=
ry for an interface and feed the reply to the given
+ * parsing callback=2E=

+ *
+ * @param iface     name of the interface to query
+ * @param cb     =
   callback invoked with the netlink reply
+ * @param arg       opaque argu=
ment passed through to the callback
+ *
+ * @return          0 on success, =
a negative error code otherwise
+ */
+static int
+sitnl_link_get(const char=
 *iface, sitnl_parse_reply_cb cb, void *arg)
 {
     struct sitnl_link_req =
req =3D {};
     int ifindex =3D if_nametoindex(iface);
@@ -1450,9 +1460,15=
 @@
     req=2Ei=2Eifi_family =3D AF_PACKET;
     req=2Ei=2Eifi_index =3D i=
findex;
 
+    return sitnl_send(&req=2En, 0, 0, cb, arg);
+}
+
+int
+net_i=
face_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_L=
EN_MAX])
+{
     memset(type, 0, IFACE_TYPE_LEN_MAX);
 
-    int ret =3D si=
tnl_send(&req=2En, 0, 0, sitnl_type_save, type);
+    int ret =3D sitnl_lin=
k_get(iface, sitnl_type_save, type);
     if (ret < 0)
     {
         msg(=
D_ROUTE, "%s: cannot retrieve iface %s: %s (%d)", __func__, iface, strerror=
(-ret), ret);
@@ -1464,6 +1480,82 @@
     return 0;
 }
 
+#if defined(ENABL=
E_DCO)
+static int
+sitnl_ovpn_mode_save(struct nlmsghdr *n, void *arg)
+{
=
+    struct ifinfomsg *ifi =3D NLMSG_DATA(n);
+    struct rtattr *tb[IFLA_M=
AX + 1];
+    struct rtattr *tb_link[IFLA_INFO_MAX + 1];
+    struct rtattr=
 *tb_data[IFLA_OVPN_MAX + 1];
+    enum ovpn_mode *mode =3D arg;
+    uint8=
_t raw_mode;
+
+    if (n->nlmsg_type !=3D RTM_NEWLINK)
+    {
+        ret=
urn -EINVAL;
+    }
+
+    if (n->nlmsg_len < NLMSG_LENGTH(sizeof(*ifi)))
+=
    {
+        return -EINVAL;
+    }
+
+    sitnl_parse_rtattr(tb, IFLA_MA=
X, IFLA_RTA(ifi), IFLA_PAYLOAD(n));
+
+    if (!tb[IFLA_LINKINFO])
+    {
+=
        return -ENOENT;
+    }
+
+    sitnl_parse_rtattr_nested(tb_link, IF=
LA_INFO_MAX, tb[IFLA_LINKINFO]);
+
+    if (!tb_link[IFLA_INFO_KIND]
+     =
   || strcmp(RTA_DATA(tb_link[IFLA_INFO_KIND]), OVPN_FAMILY_NAME) !=3D 0)
+=
    {
+        return -EINVAL;
+    }
+
+    if (!tb_link[IFLA_INFO_DATA])
=
+    {
+        return -ENOENT;
+    }
+
+    sitnl_parse_rtattr_nested(tb_=
data, IFLA_OVPN_MAX, tb_link[IFLA_INFO_DATA]);
+
+    if (!tb_data[IFLA_OVP=
N_MODE])
+    {
+        return -ENOENT;
+    }
+
+    if (RTA_PAYLOAD(tb_d=
ata[IFLA_OVPN_MODE]) < sizeof(raw_mode))
+    {
+        return -EINVAL;
+ =
   }
+
+    raw_mode =3D *(uint8_t *)RTA_DATA(tb_data[IFLA_OVPN_MODE]);
+  =
  *mode =3D (enum ovpn_mode)raw_mode;
+
+    return 0;
+}
+
+int
+net_iface=
_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode)=

+{
+    int ret =3D sitnl_link_get(iface, sitnl_ovpn_mode_save, mode);
+  =
  if (ret < 0)
+    {
+        msg(D_ROUTE, "%s: cannot retrieve ovpn mode =
for iface %s: %s (%d)", __func__, iface,
+            strerror(-ret), ret);=

+        return ret;
+    }
+
+    msg(D_ROUTE, "%s: mode of %s: %d", __fu=
nc__, iface, *mode);
+
+    return 0;
+}
+#endif /* defined(ENABLE_DCO) */
=
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
diff --=
git a/src/openvpn/networking_sitnl=2Eh b/src/openvpn/networking_sitnl=2Eh
i=
ndex 481cc36=2E=2E7a2d964 100644
--- a/src/openvpn/networking_sitnl=2Eh
+++=
 b/src/openvpn/networking_sitnl=2Eh
@@ -24,4 +24,30 @@
 typedef char openvp=
n_net_iface_t;
 typedef void *openvpn_net_ctx_t;
 
+#if defined(TARGET_LINU=
X)
+
+#include <linux/if_link=2Eh>
+
+#ifndef IFLA_OVPN_MAX
+
+enum ovpn_mo=
de
+{
+    OVPN_MODE_P2P,
+    OVPN_MODE_MP,
+};
+
+enum ovpn_ifla_attrs
+{=

+    IFLA_OVPN_UNSPEC =3D 0,
+    IFLA_OVPN_MODE,
+
+    __IFLA_OVPN_MAX,
=
+};
+
+#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
+
+#endif /* ifndef IFLA=
_OVPN_MAX */
+
+#endif /* if defined(TARGET_LINUX) */
+
 #endif /* NETWORKI=
NG_SITNL_H_ */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1734?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7=
2302403bddee4b0b0ee2441ae9e246f48d0bc81
Gerrit-Change-Number: 1734
Gerrit-P=
atchSet: 2
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: =
ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mand=
elbit=2Ecom>

--v/fhYDbaJj4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos, ralf_lici=2E </p>
<p>ralf_lici <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><=
p>The following approvals got outdated and were removed:
Code-Review-1 by o=
rdex</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Support pre-existing Linux DCO interfaces<br><br>When=
 creating an ovpn interface returns -EEXIST, still retrieve the<br>ifindex =
and return the error to the generic DCO open path=2E This lets the<br>calle=
r mark the interface as pre-existing and avoid deleting it on<br>close=2E<b=
r><br>Before accepting the existing interface, query its rtnetlink link inf=
o<br>and verify that it is an ovpn device with the expected mode=2E The ovp=
n<br>mode is fixed at interface creation time, so attaching to an interface=
<br>created for the other mode cannot work=2E<br><br>Honor the pre-existing=
 state on close by skipping net_iface_del() for<br>persistent interfaces=2E=
<br><br>Github: closes OpenVPN/openvpn#1064<br>Change-Id: I72302403bddee4b0=
b0ee2441ae9e246f48d0bc81<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ec=
om&gt;<br>---<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M =
src/openvpn/dco_linux=2Eh<br>M src/openvpn/networking=2Eh<br>M src/openvpn/=
networking_iproute2=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/open=
vpn/networking_sitnl=2Eh<br>7 files changed, 185 insertions(+), 29 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/34/1734/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Eh b/=
src/openvpn/dco=2Eh</span><br><span>index 4e5aad5=2E=2E4584004 100644</span=
><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=
=2Eh</span><br><span>@@ -109,7 +109,8 @@</span><br><span> bool ovpn_dco_ini=
t(struct context *c);</span><br><span> </span><br><span> /**</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Open/create a DCO interface</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Open/create a DCO inte=
rface and store its ifindex=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * If the interface already exists, save the ifindex anyway and =
return -EEXIST=2E</span><br><span>  *</span><br><span>  * @param tt        =
the tuntap context</span><br><span>  * @param ctx       the networking API =
context</span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvp=
n/dco_linux=2Ec</span><br><span>index 56f6259=2E=2E777b43c 100644</span><br=
><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dc=
o_linux=2Ec</span><br><span>@@ -502,6 +502,19 @@</span><br><span>     CLEAR=
(dco);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ovpn_mode_to_str(enum ovpn_mode mode)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    switch (mode)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        case OVPN_MODE_P2P:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return &quot;p2p&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case OVPN_MODE_MP:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return &quot;server&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;unknown&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><sp=
an> open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev=
)</span><br><span> {</span><br><span>@@ -509,11 +522,30 @@</span><br><span>=
     ASSERT(tt-&gt;type =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><=
span>     int ret =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &amp;tt-&gt=
;dco);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &lt=
; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt=
; 0 &amp;&amp; ret !=3D -EEXIST)</span><br><span>     {</span><br><span>   =
      msg(D_DCO_DEBUG, &quot;Cannot create DCO interface %s: %d&quot;, dev,=
 ret);</span><br><span>         return ret;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D -EEXIST)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        enum ovpn_mode mode;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        int mode_ret =3D =
net_iface_ovpn_mode(ctx, dev, &amp;mode);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (mode_ret &lt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_WARN, &quot;DCO: cannot retrieve mode of existing inter=
face %s: %s (%d)&quot;, dev,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                strerror(-mode_ret), mode_ret);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return mode_ret;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (mode !=3D tt-&gt;dco=2Eifmode)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;DCO: existing i=
nterface %s is in %s mode, expected %s mode&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                dev, ovpn_mode_to_str(mode),=
 ovpn_mode_to_str(tt-&gt;dco=2Eifmode));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return -EINVAL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span> </span><br><span>     tt-&gt;dco=
=2Eifindex =3D if_nametoindex(dev);</span><br><span>     if (!tt-&gt;dco=2E=
ifindex)</span><br><span>@@ -521,7 +553,7 @@</span><br><span>         msg(M=
_FATAL, &quot;DCO: cannot retrieve ifindex for interface %s&quot;, dev);</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return ret;</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span>@@ -529,7 +561,10 @@</span><br><span> {</span><b=
r><span>     msg(D_DCO_DEBUG, __func__);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    net_iface_del(ctx, tt-&gt;actual_n=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tt-&g=
t;persistent_if)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        net_iface=
_del(ctx, tt-&gt;actual_name);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span>     ovpn_dco_uninit_netlink(&amp;tt-&gt;d=
co);</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/=
openvpn/dco_linux=2Eh b/src/openvpn/dco_linux=2Eh</span><br><span>index e3e=
4824=2E=2E42df09e 100644</span><br><span>--- a/src/openvpn/dco_linux=2Eh</s=
pan><br><span>+++ b/src/openvpn/dco_linux=2Eh</span><br><span>@@ -24,6 +24,=
7 @@</span><br><span> #if defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LIN=
UX)</span><br><span> </span><br><span> #include &quot;event=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;networking=
_sitnl=2Eh&quot;</span><br><span> </span><br><span> #include &quot;ovpn_dco=
_linux=2Eh&quot;</span><br><span> </span><br><span>@@ -38,28 +39,6 @@</span=
><br><span> typedef enum ovpn_key_slot dco_key_slot_t;</span><br><span> typ=
edef enum ovpn_cipher_alg dco_cipher_t;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/* OVPN section */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifndef IFLA_OVPN_MAX</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn=
_mode</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    OVPN_MODE_P2P,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    OVPN_MODE_MP,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovp=
n_ifla_attrs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    IFLA_OVPN_UNSPEC =3D 0,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    IFLA_OVPN_MODE,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    __IFLA_OVPN_MAX,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IFLA=
_OVPN_MAX (__IFLA_OVPN_MAX - 1)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* i=
fndef IFLA_OVPN_MAX */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> typedef struct</span><br><span> {</span><br><span>     s=
truct nl_sock *nl_sock;</span><br><span>diff --git a/src/openvpn/networking=
=2Eh b/src/openvpn/networking=2Eh</span><br><span>index bce0c19=2E=2Ecab560=
c 100644</span><br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+=
++ b/src/openvpn/networking=2Eh</span><br><span>@@ -115,6 +115,19 @@</span>=
<br><span>  */</span><br><span> int net_iface_type(openvpn_net_ctx_t *ctx, =
const char *iface, char type[IFACE_TYPE_LEN_MAX]);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO) &a=
mp;&amp; defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Re=
trieve the ovpn interface mode</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram ctx       the implementation specific context</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param iface     interface to query</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param mode      variab=
le where the ovpn mode attribute will be stored</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return          0 on success, a negative error code otherwis=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+int net_iface_ovpn_mode(openvpn_ne=
t_ctx_t *ctx, const char *iface, enum ovpn_mode *mode);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Remove an =
interface</span><br><span>  *</span><br><span>diff --git a/src/openvpn/netw=
orking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>i=
ndex a1f3525=2E=2E85ab158 100644</span><br><span>--- a/src/openvpn/networki=
ng_iproute2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec</=
span><br><span>@@ -82,6 +82,16 @@</span><br><span>     return -1;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_=
iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *=
mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* not supported by iproute2=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN, =
&quot;%s: operation not supported by iproute2 backend&quot;, __func__);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -EOPNOTSUPP;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> net_iface_d=
el(openvpn_net_ctx_t *ctx, const char *iface)</span><br><span> {</span><br>=
<span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networkin=
g_sitnl=2Ec</span><br><span>index a396255=2E=2E9d07638 100644</span><br><sp=
an>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn=
/networking_sitnl=2Ec</span><br><span>@@ -1432,8 +1432,18 @@</span><br><spa=
n>     return 0;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, cha=
r type[IFACE_TYPE_LEN_MAX])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Issue=
 an RTM_GETLINK query for an interface and feed the reply to the given</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * parsing callback=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param iface     name of the interf=
ace to query</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am cb        callback invoked with the netlink reply</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param arg       opaque argument passe=
d through to the callback</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
         0 on success, a negative error code otherwise</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+sitnl_link_get(const char *iface, sitnl_parse_reply_cb cb, void *=
arg)</span><br><span> {</span><br><span>     struct sitnl_link_req req =3D =
{};</span><br><span>     int ifindex =3D if_nametoindex(iface);</span><br><=
span>@@ -1450,9 +1460,15 @@</span><br><span>     req=2Ei=2Eifi_family =3D A=
F_PACKET;</span><br><span>     req=2Ei=2Eifi_index =3D ifindex;</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return si=
tnl_send(&amp;req=2En, 0, 0, cb, arg);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+net_iface_type(openvpn_net_ctx_t *=
ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span>     memset(type, 0, I=
FACE_TYPE_LEN_MAX);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int ret =3D sitnl_send(&amp;req=2En, 0, 0, sitnl_type_s=
ave, type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
ret =3D sitnl_link_get(iface, sitnl_type_save, type);</span><br><span>     =
if (ret &lt; 0)</span><br><span>     {</span><br><span>         msg(D_ROUTE=
, &quot;%s: cannot retrieve iface %s: %s (%d)&quot;, __func__, iface, strer=
ror(-ret), ret);</span><br><span>@@ -1464,6 +1480,82 @@</span><br><span>   =
  return 0;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+sitnl_ovpn_mode_save(struct nlmsghdr *n, void *arg=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct ifinfomsg *ifi =3D NLMSG_=
DATA(n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
rtattr *tb[IFLA_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct rtattr *tb_link[IFLA_INFO_MAX + 1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct rtattr *tb_data[IFLA_OVPN_MAX =
+ 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum ovpn_=
mode *mode =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint8_t raw_mode;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (n-&gt;nlm=
sg_type !=3D RTM_NEWLINK)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return -EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (n-&gt;nlmsg_len &lt; NLMSG_LE=
NGTH(sizeof(*ifi)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 -EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sitnl_parse_rtattr(tb, IFLA_MAX, IFLA=
_RTA(ifi), IFLA_PAYLOAD(n));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!t=
b[IFLA_LINKINFO])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -=
ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    sitnl_parse_rtattr_nested(tb_link, IFLA_I=
NFO_MAX, tb[IFLA_LINKINFO]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!t=
b_link[IFLA_INFO_KIND]</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        || strcmp(RTA_DATA(tb_link[IFLA_INFO_KIND]), OVPN_FAMILY_NAME) !=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!tb_link[IFLA_INFO_DATA])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return -ENOENT;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sitnl=
_parse_rtattr_nested(tb_data, IFLA_OVPN_MAX, tb_link[IFLA_INFO_DATA]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!tb_data[IFLA_OVPN_MODE])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (RTA_PAYLOAD(tb_data[IFLA_OVPN_MODE]) &lt; sizeof(raw_mode))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    raw_mode =3D *(uint8_t *)RTA_DATA(tb_data[IFLA_OVPN_MODE]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *mode =3D (enum o=
vpn_mode)raw_mode;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_=
iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *=
mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D sitnl_link_get(i=
face, sitnl_ovpn_mode_save, mode);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(D_ROUTE, &quot;%s: cannot retrieve ovpn mode for iface %s: %s =
(%d)&quot;, __func__, iface,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            strerror(-ret), ret);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return ret;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_=
ROUTE, &quot;%s: mode of %s: %d&quot;, __func__, iface, *mode);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* defined(ENABLE_DCO) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> int</span><br><span> net_iface_del(openvpn_=
net_ctx_t *ctx, const char *iface)</span><br><span> {</span><br><span>diff =
--git a/src/openvpn/networking_sitnl=2Eh b/src/openvpn/networking_sitnl=2Eh=
</span><br><span>index 481cc36=2E=2E7a2d964 100644</span><br><span>--- a/sr=
c/openvpn/networking_sitnl=2Eh</span><br><span>+++ b/src/openvpn/networking=
_sitnl=2Eh</span><br><span>@@ -24,4 +24,30 @@</span><br><span> typedef char=
 openvpn_net_iface_t;</span><br><span> typedef void *openvpn_net_ctx_t;</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;linux=
/if_link=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef IFLA_OVPN_MAX<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+enum ovpn_mode</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_MODE_P2P,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    OVPN_MODE_MP,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+enum ovpn_ifla_attrs</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    IFLA_OVPN_UNSPEC =3D 0,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    IFLA_OVPN_MODE,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    __IFLA_OVPN_MAX,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IFLA=
_OVPN_MAX (__IFLA_OVPN_MAX - 1)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif =
/* ifndef IFLA_OVPN_MAX */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if=
 defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> #endif /* NETWORKING_SITNL_H_ */</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1734?usp=3Demail">change 1734</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1734?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48=
d0bc81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1734 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--v/fhYDbaJj4=--


--===============8160605906283346253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8160605906283346253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8160605906283346253==--

