Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97F6071E69
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jBPmawYi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kGqqRxac;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QVyiWrs4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XSU7QcRh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HqyrJp1B5AHn1PsmqsrchsrmzHD+tmZ1kySSvKKl9oU=; b=jBPmawYijqFOKI3/hCdFCvuSwv
	qTY3iP7knmDuWaFQQ5P0LqFRfeiUaxqu2fmdOKocz2xNl97PmkObZILpIA/mY2JVHu8SOmvffE0xc
	ni7m3TLxiloyGgi+xJ0hcYmQnIyQB0Iuf49Of0AQE4pg3eHc9sFUszW9FcrrPhGrmnTA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQiKo-000000004rU-0OyP;
	Tue, 10 Nov 2026 09:40:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQiKm-000000004rO-2fXo
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mZXURC2Z90Yy3LfvbOhL2OjIX8UngDha7avoVtx8Mq4=; b=kGqqRxacJiBZf1TSEbeBSB/ZRo
 ZleIWzXpi4074bEjTsAcr0R2MkMLqfAnhR167Sf1i/o+pvhBaIJoSUiKAizIEgMkDh8e8bT99vVtR
 AorZgkTfmUsOwl5X9CtnD55hGNriCmHmeomytcwht7/d6EVtgAGO+lk3YAEDfGj5XwR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mZXURC2Z90Yy3LfvbOhL2OjIX8UngDha7avoVtx8Mq4=; b=QVyiWrs4OMFVeVYtoayhStgbEt
 Ej+AQdKPvPAodvKOGP+eXrHfrpbWHKdtzcDSXi0UzUIZq/FOzubsS/reUx+vLJgdSeTpW7eJ2V8gu
 UHJQ+BKbirsf/wUElhi5+i9Ug6JXJD5YabJx2zZjsWLz32Elh7zJy3g5A4tHk8qAYigs=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQiKi-000000002IB-1af3 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:40:08 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso1179257f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 01:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794303598; x=1794908398; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mZXURC2Z90Yy3LfvbOhL2OjIX8UngDha7avoVtx8Mq4=;
 b=XSU7QcRhRolWUHag5GTQIZvJm9SCZRhAtUCLaDLCLVwWARmQFtJPEciwMl3ESR8LTA
 hU9JaJZLQQPUj8i7Yb1Lj/t2BqTs7RudsyzwoketgrssZLC2kemq3LUnIUqIZ/yift9D
 3WsU/zRKDUqWsPnqYvagE///56sXVuqMP0t5J3gxPU4XhWkEGK4yA7D/NtIxtd8pHh/3
 m/RG61FQpYF975KQ/5nw9bncSq5dJn4jW/UojCjwq24CfZJx3epVhlDpqLNqn3/geW6/
 dkHUfQLAxSZvCYc+Sx/2V23v0R6B8quyZ8Inw1di7pCrfmv5ImxSiYDqgNm8SOl4IHfD
 Bg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794303598; x=1794908398;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mZXURC2Z90Yy3LfvbOhL2OjIX8UngDha7avoVtx8Mq4=;
 b=qvh3cTPTOl8JfVDG5sIg2e8REwALu9orNc7pPiIxAtHZt2eBV8KTW4K2rSDUtccfnf
 uNAqP4dzHxyIeCAHXRT2r35Hey89ChX6gluEHCiX3FO7t2nkFOdW3EXJLociD7Ic//Tx
 Q/IM4XCiWrNvX6WQD3CgSepvalzTMjxF87vx4r3Xgfj4/koVp6gMg0WyDcCNxcP/gk7a
 08TVOB3NoS6WdA9S3NbNJIZ5hHooobvTwwofKloX+MI+QBa6kVtvErwwyR721iGgOJ9S
 81RAzeLb7rrvRZhc38bKrtCpkPvkSzFCeTKLhpY8G2RdexAi6NGZgii9dwRgLlZvCVfp
 ObjQ==
X-Gm-Message-State: APuU4Z906AJw+GZRW56F5Pa2TKwCMfxokcDSOJHibrA5zGucD0GjXeTF
 DH2OWQhX7giXLSiVKXVzkj3hJ29m1F1kJUABleW5RQmIzNxqPdNNtIm63H0KNtcxYnZ3utXMtqc
 qOJ0gLKcKbCv5cZvBfHxI6YGSQLLQ7XgmXfJ7r7uKrff/wPNh7U9LOJLcfk8aEFN6TDL94SkAsl
 mcMK2cHw==
X-Gm-Gg: AYBFou11IOmAPPaFsEer7xQai1rsyOautEB5zkcO4irgrkcMhVZm7ut9BOGiWtzt4I9
 8w9L2CWM+NRNTtEHRoaHtwDvWcRQHdk5OoPIGEVKLX8PHjpoW6GdLJDLN5YtyEYoyfuN06/zgge
 L4pRIHLREko8kJWcP0zSIa/wlNiQRuiszSKkuDM0jvgsQodcNy78ztbeGxdekpzE+4MxbBizqxc
 1wkMkP9r+MwYQDKcood3hHtDnolIdS3iG20O83zqh0xrS+PLU0h1r1zlFExFfnEZqJWF72QuoYN
 11U3CKIflntXYcvQjWFn03E6WWYyI/sl+MkkiyrRcV0cS/H2aXSrzoEncBekAsoPGtXR4uuFUWT
 xIZ3hEq4YQ22aFwchy9ovwxNOgu5gQDDFOeqkJE57ZmHNeMjivRPzIjN5vDMtNu7maKy0UxQ70g
 EE7WRHR01UiKDlXMcLoExh2ODSfrtyAjBrWwf/rz7KKdglVgmCiTnSSDchqklWY0d+xYCpUqQVi
 XgZXmmVBoXGgKbCyx58DEjJmDF708615TPf5zlG+Me34GNEtU7zxqi7/82VIBoforkHmahpQJ5w
 s+3TpcvA99MHlOPPuJR9h+7A25NLHFjuPcOgLzE/J7BcRyIQxl/qGaUTFr7f1mCZe1ZRTOqwWkX
 sKEGqbgoL7KTlrc85GjBh0xIEZ49+m+Sykiqc/62l8b6jPYNCQDSyZzEYMfIaNW/JJmm5XCVTpY
 NSt1TFPiNfU2UhmNY=
X-Received: by 2002:a05:6000:5c5:b0:492:3f98:5070 with SMTP id
 ffacd0b85a97d-498364d741cmr3616147f8f.12.1794303597395; 
 Tue, 10 Nov 2026 01:39:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c500asm4115610f8f.48.2026.11.10.01.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 01:39:56 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 09:39:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 5bc6b50d0e310ad1642fb2699b023dc7ce7fbe93
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dcc9daa393f6f3dad3d130ee036ea1c8ca29e271-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQiKi-000000002IB-1af3
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
Content-Type: multipart/mixed; boundary="===============0666992296734533786=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0666992296734533786==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/ePFfiVxKEc="; charset=UTF-8

--/ePFfiVxKEc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Ralf=
 Lici=2E

Hello Antonio Quartulli, Arne Schwabe, 

I'd like you to reexamin=
e a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1734?usp=3Demail

to look at the new patch set (#6)=2E

The following appro=
vals got outdated and were removed:
Code-Review+2 by Antonio Quartulli

The=
 change is no longer submittable: Code-Review and checks~ChecksSubmitRule a=
re unsatisfied now=2E


Change subject: Support pre-existing Linux DCO inte=
rfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Supp=
ort pre-existing Linux DCO interfaces

When creating an ovpn interface retu=
rns -EEXIST, still retrieve the
ifindex and return the error to the generic=
 DCO open path=2E This lets the
caller mark the interface as pre-existing a=
nd avoid deleting it on
close=2E

Before accepting the existing interface, =
query its rtnetlink link info
and verify that it is an ovpn device with the=
 expected mode=2E The ovpn
mode is fixed at interface creation time, so att=
aching to an interface
created for the other mode cannot work=2E

Honor the=
 pre-existing state on close by skipping net_iface_del() for
persistent int=
erfaces=2E

Github: closes OpenVPN/openvpn#1064
Change-Id: I72302403bddee4b=
0b0ee2441ae9e246f48d0bc81
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
-=
--
M src/openvpn/dco=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_linu=
x=2Eh
M src/openvpn/networking=2Eh
M src/openvpn/networking_iproute2=2Ec
M =
src/openvpn/networking_sitnl=2Ec
M src/openvpn/networking_sitnl=2Eh
7 files=
 changed, 185 insertions(+), 29 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/34/1734/6

diff --git a/src/openvpn/=
dco=2Eh b/src/openvpn/dco=2Eh
index c435f8c=2E=2E02ff9b3 100644
--- a/src/o=
penvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -109,7 +109,8 @@
 bool ovpn_dco=
_init(struct context *c);
 
 /**
- * Open/create a DCO interface
+ * Open/c=
reate a DCO interface and store its ifindex=2E
+ * If the interface already=
 exists, save the ifindex anyway and return -EEXIST=2E
  *
  * @param tt   =
     the tuntap context
  * @param ctx       the networking API context
dif=
f --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index a84e3=
10=2E=2E4d24122 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dc=
o_linux=2Ec
@@ -540,6 +540,19 @@
     CLEAR(*dco);
 }
 
+static const char =
*
+ovpn_mode_to_str(enum ovpn_mode mode)
+{
+    switch (mode)
+    {
+    =
    case OVPN_MODE_P2P:
+            return "p2p";
+        case OVPN_MODE_=
MP:
+            return "server";
+    }
+    return "unknown";
+}
+
 int
 =
open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
 {=

@@ -547,11 +560,30 @@
     ASSERT(tt->type =3D=3D DEV_TYPE_TUN);
 
     in=
t ret =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &tt->dco);
-    if (ret=
 < 0)
+    if (ret < 0 && ret !=3D -EEXIST)
     {
         msg(D_DCO_DEBUG=
, "Cannot create DCO interface %s: %d", dev, ret);
         return ret;
   =
  }
+    if (ret =3D=3D -EEXIST)
+    {
+        enum ovpn_mode mode;
+    =
    int mode_ret =3D net_iface_ovpn_mode(ctx, dev, &mode);
+
+        if (m=
ode_ret < 0)
+        {
+            msg(M_WARN, "DCO: cannot retrieve mode=
 of existing interface %s: %s (%d)", dev,
+                strerror(-mode_r=
et), mode_ret);
+            return mode_ret;
+        }
+
+        if (mod=
e !=3D tt->dco=2Eifmode)
+        {
+            msg(M_WARN, "DCO: existing=
 interface %s is in %s mode, expected %s mode",
+                dev, ovpn_=
mode_to_str(mode), ovpn_mode_to_str(tt->dco=2Eifmode));
+            return=
 -EINVAL;
+        }
+    }
 
     tt->dco=2Eifindex =3D if_nametoindex(dev=
);
     if (!tt->dco=2Eifindex)
@@ -559,7 +591,7 @@
         msg(M_FATAL, "=
DCO: cannot retrieve ifindex for interface %s", dev);
     }
 
-    return =
0;
+    return ret;
 }
 
 void
@@ -567,7 +599,10 @@
 {
     msg(D_DCO_DEBUG=
, __func__);
 
-    net_iface_del(ctx, tt->actual_name);
+    if (!tt->pers=
istent_if)
+    {
+        net_iface_del(ctx, tt->actual_name);
+    }
    =
 ovpn_dco_uninit_netlink(&tt->dco);
 }
 
diff --git a/src/openvpn/dco_linux=
=2Eh b/src/openvpn/dco_linux=2Eh
index c487581=2E=2Ea999d77 100644
--- a/sr=
c/openvpn/dco_linux=2Eh
+++ b/src/openvpn/dco_linux=2Eh
@@ -24,6 +24,7 @@
 =
#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
 
 #include "event=2Eh"
+#=
include "networking_sitnl=2Eh"
 
 #include "ovpn_dco_linux=2Eh"
 
@@ -38,28=
 +39,6 @@
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_ci=
pher_alg dco_cipher_t;
 
-/* OVPN section */
-
-#ifndef IFLA_OVPN_MAX
-
-en=
um ovpn_mode
-{
-    OVPN_MODE_P2P,
-    OVPN_MODE_MP,
-};
-
-enum ovpn_ifl=
a_attrs
-{
-    IFLA_OVPN_UNSPEC =3D 0,
-    IFLA_OVPN_MODE,
-
-    __IFLA_=
OVPN_MAX,
-};
-
-#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
-
-#endif /* i=
fndef IFLA_OVPN_MAX */
-
 typedef struct
 {
     /* socket used for synchro=
nous request/reply transactions (commands and
diff --git a/src/openvpn/netw=
orking=2Eh b/src/openvpn/networking=2Eh
index 7ad6e2e=2E=2E83bce57 100644
-=
-- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -115,6 =
+115,19 @@
  */
 int net_iface_type(const openvpn_net_ctx_t *ctx, const cha=
r *iface, char type[IFACE_TYPE_LEN_MAX]);
 
+#if defined(ENABLE_DCO) && def=
ined(TARGET_LINUX)
+/**
+ * Retrieve the ovpn interface mode
+ *
+ * @param=
 ctx       the implementation specific context
+ * @param iface     interfa=
ce to query
+ * @param mode      variable where the ovpn mode attribute wil=
l be stored
+ *
+ * @return          0 on success, a negative error code ot=
herwise
+ */
+int net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *i=
face, enum ovpn_mode *mode);
+#endif
+
 /**
  * Remove an interface
  *
dif=
f --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_ipro=
ute2=2Ec
index d987478=2E=2Edd240d1 100644
--- a/src/openvpn/networking_ipr=
oute2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -80,6 +80,16 @@
    =
 return -1;
 }
 
+#if defined(ENABLE_DCO)
+int
+net_iface_ovpn_mode(openvpn=
_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode)
+{
+    /* not su=
pported by iproute2 */
+    msg(M_WARN, "%s: operation not supported by ipr=
oute2 backend", __func__);
+    return -EOPNOTSUPP;
+}
+#endif
+
 int
 net_=
iface_del(const openvpn_net_ctx_t *ctx, const char *iface)
 {
diff --git a/=
src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 9=
7ff7bd=2E=2E6d47b62 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src=
/openvpn/networking_sitnl=2Ec
@@ -1430,8 +1430,18 @@
     return 0;
 }
 
-i=
nt
-net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, char ty=
pe[IFACE_TYPE_LEN_MAX])
+/**
+ * Issue an RTM_GETLINK query for an interfac=
e and feed the reply to the given
+ * parsing callback=2E
+ *
+ * @param if=
ace     name of the interface to query
+ * @param cb        callback invoke=
d with the netlink reply
+ * @param arg       opaque argument passed throug=
h to the callback
+ *
+ * @return          0 on success, a negative error c=
ode otherwise
+ */
+static int
+sitnl_link_get(const char *iface, sitnl_par=
se_reply_cb cb, void *arg)
 {
     struct sitnl_link_req req =3D {};
     i=
nt ifindex =3D if_nametoindex(iface);
@@ -1448,9 +1458,15 @@
     req=2Ei=
=2Eifi_family =3D AF_PACKET;
     req=2Ei=2Eifi_index =3D ifindex;
 
+    r=
eturn sitnl_send(&req=2En, 0, 0, cb, arg);
+}
+
+int
+net_iface_type(const =
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
net_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)
 {
diff --gi=
t a/src/openvpn/networking_sitnl=2Eh b/src/openvpn/networking_sitnl=2Eh
ind=
ex 481cc36=2E=2E7a2d964 100644
--- a/src/openvpn/networking_sitnl=2Eh
+++ b=
/src/openvpn/networking_sitnl=2Eh
@@ -24,4 +24,30 @@
 typedef char openvpn_=
net_iface_t;
 typedef void *openvpn_net_ctx_t;
 
+#if defined(TARGET_LINUX)=

+
+#include <linux/if_link=2Eh>
+
+#ifndef IFLA_OVPN_MAX
+
+enum ovpn_mode=

+{
+    OVPN_MODE_P2P,
+    OVPN_MODE_MP,
+};
+
+enum ovpn_ifla_attrs
+{
+=
    IFLA_OVPN_UNSPEC =3D 0,
+    IFLA_OVPN_MODE,
+
+    __IFLA_OVPN_MAX,
+}=
;
+
+#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
+
+#endif /* ifndef IFLA_O=
VPN_MAX */
+
+#endif /* if defined(TARGET_LINUX) */
+
 #endif /* NETWORKING=
_SITNL_H_ */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1734?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7=
2302403bddee4b0b0ee2441ae9e246f48d0bc81
Gerrit-Change-Number: 1734
Gerrit-P=
atchSet: 6
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: =
Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--/ePFfiVxKEc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Ralf Lici=2E </p>
<p=
>Ralf Lici <strong>uploaded patch set #6</strong> to this change=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View=
 Change</a></p><p>The following approvals got outdated and were removed:
Co=
de-Review+2 by Antonio Quartulli</p><p>The change is no longer submittable:=
 Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E</p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Support pre-existing Linux DCO interfaces<br><br>When creating an ovp=
n interface returns -EEXIST, still retrieve the<br>ifindex and return the e=
rror to the generic DCO open path=2E This lets the<br>caller mark the inter=
face as pre-existing and avoid deleting it on<br>close=2E<br><br>Before acc=
epting the existing interface, query its rtnetlink link info<br>and verify =
that it is an ovpn device with the expected mode=2E The ovpn<br>mode is fix=
ed at interface creation time, so attaching to an interface<br>created for =
the other mode cannot work=2E<br><br>Honor the pre-existing state on close =
by skipping net_iface_del() for<br>persistent interfaces=2E<br><br>Github: =
closes OpenVPN/openvpn#1064<br>Change-Id: I72302403bddee4b0b0ee2441ae9e246f=
48d0bc81<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>---<br=
>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_=
linux=2Eh<br>M src/openvpn/networking=2Eh<br>M src/openvpn/networking_iprou=
te2=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/networking_s=
itnl=2Eh<br>7 files changed, 185 insertions(+), 29 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/34/1734/6</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=
=2Eh</span><br><span>index c435f8c=2E=2E02ff9b3 100644</span><br><span>--- =
a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br><=
span>@@ -109,7 +109,8 @@</span><br><span> bool ovpn_dco_init(struct context=
 *c);</span><br><span> </span><br><span> /**</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * Open/create a DCO interface</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Open/create a DCO interface and store =
its ifindex=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If=
 the interface already exists, save the ifindex anyway and return -EEXIST=
=2E</span><br><span>  *</span><br><span>  * @param tt        the tuntap con=
text</span><br><span>  * @param ctx       the networking API context</span>=
<br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2E=
c</span><br><span>index a84e310=2E=2E4d24122 100644</span><br><span>--- a/s=
rc/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</s=
pan><br><span>@@ -540,6 +540,19 @@</span><br><span>     CLEAR(*dco);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ovpn_mode_to_str(enum ovpn_mode mode)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    switch (mode)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case OVPN_MODE_P2P:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return &quot;p2p&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        case OVPN_MODE_MP:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return &quot;server&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return &quot;unknown&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> open_tun_dc=
o(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)</span><br><sp=
an> {</span><br><span>@@ -547,11 +560,30 @@</span><br><span>     ASSERT(tt-=
&gt;type =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span>     int r=
et =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &amp;tt-&gt;dco);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0 &amp;&amp; =
ret !=3D -EEXIST)</span><br><span>     {</span><br><span>         msg(D_DCO=
_DEBUG, &quot;Cannot create DCO interface %s: %d&quot;, dev, ret);</span><b=
r><span>         return ret;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D -EEXIST)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        enum ovpn_mode mode;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        int mode_ret =3D net_iface_ovp=
n_mode(ctx, dev, &amp;mode);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (mode_ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 msg(M_WARN, &quot;DCO: cannot retrieve mode of existing interface %s: %s (=
%d)&quot;, dev,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            strerror(-mode_ret), mode_ret);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return mode_ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (mode !=3D tt-&gt;dco=2Eifmode)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(M_WARN, &quot;DCO: existing interface %s =
is in %s mode, expected %s mode&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                dev, ovpn_mode_to_str(mode), ovpn_mode_t=
o_str(tt-&gt;dco=2Eifmode));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return -EINVAL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span> </span><br><span>     tt-&gt;dco=2Eifindex =
=3D if_nametoindex(dev);</span><br><span>     if (!tt-&gt;dco=2Eifindex)</s=
pan><br><span>@@ -559,7 +591,7 @@</span><br><span>         msg(M_FATAL, &qu=
ot;DCO: cannot retrieve ifindex for interface %s&quot;, dev);</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return ret;</span><br><span> }</span><br><span> </span><br><span> void<=
/span><br><span>@@ -567,7 +599,10 @@</span><br><span> {</span><br><span>   =
  msg(D_DCO_DEBUG, __func__);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    net_iface_del(ctx, tt-&gt;actual_name);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tt-&gt;persisten=
t_if)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        net_iface_del(ctx, t=
t-&gt;actual_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span>     ovpn_dco_uninit_netlink(&amp;tt-&gt;dco);</span>=
<br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/dco=
_linux=2Eh b/src/openvpn/dco_linux=2Eh</span><br><span>index c487581=2E=2Ea=
999d77 100644</span><br><span>--- a/src/openvpn/dco_linux=2Eh</span><br><sp=
an>+++ b/src/openvpn/dco_linux=2Eh</span><br><span>@@ -24,6 +24,7 @@</span>=
<br><span> #if defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX)</span><=
br><span> </span><br><span> #include &quot;event=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;networking_sitnl=2Eh&=
quot;</span><br><span> </span><br><span> #include &quot;ovpn_dco_linux=2Eh&=
quot;</span><br><span> </span><br><span>@@ -38,28 +39,6 @@</span><br><span>=
 typedef enum ovpn_key_slot dco_key_slot_t;</span><br><span> typedef enum o=
vpn_cipher_alg dco_cipher_t;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/* OVPN section */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifndef IFLA_OVPN_MAX</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_mode</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    OVPN_MODE_P2P,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    OVPN_MODE_MP,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_ifla_attr=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    IFLA_OVPN_UNSPEC =3D 0,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    IFLA_OVPN_MODE,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    __IFLA_OVPN_MAX,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IFLA_OVPN_MAX (=
__IFLA_OVPN_MAX - 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef IFLA_=
OVPN_MAX */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> typedef struct</span><br><span> {</span><br><span>     /* socket us=
ed for synchronous request/reply transactions (commands and</span><br><span=
>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh</span=
><br><span>index 7ad6e2e=2E=2E83bce57 100644</span><br><span>--- a/src/open=
vpn/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh</span><=
br><span>@@ -115,6 +115,19 @@</span><br><span>  */</span><br><span> int net=
_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFAC=
E_TYPE_LEN_MAX]);</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Retrieve the ovpn interface mode</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param ctx       the implementation =
specific context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param iface     interface to query</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param mode      variable where the ovpn mode attribute =
will be stored</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return          0 =
on success, a negative error code otherwise</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, =
enum ovpn_mode *mode);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /**</span><br><span>  * Remove an interface</span><br><span>  *</sp=
an><br><span>diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn=
/networking_iproute2=2Ec</span><br><span>index d987478=2E=2Edd240d1 100644<=
/span><br><span>--- a/src/openvpn/networking_iproute2=2Ec</span><br><span>+=
++ b/src/openvpn/networking_iproute2=2Ec</span><br><span>@@ -80,6 +80,16 @@=
</span><br><span>     return -1;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+net_iface_ovpn_mode(openvpn_net_ctx_t=
 *ctx, const char *iface, enum ovpn_mode *mode)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* not supported by iproute2 */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    msg(M_WARN, &quot;%s: operation not supported=
 by iproute2 backend&quot;, __func__);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return -EOPNOTSUPP;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> int</span><br><span> net_iface_del(const openvpn_net_ctx_t *ctx, =
const char *iface)</span><br><span> {</span><br><span>diff --git a/src/open=
vpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span=
>index 97ff7bd=2E=2E6d47b62 100644</span><br><span>--- a/src/openvpn/networ=
king_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span=
><br><span>@@ -1430,8 +1430,18 @@</span><br><span>     return 0;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_typ=
e(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN=
_MAX])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Issue an RTM_GETLINK query=
 for an interface and feed the reply to the given</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * parsing callback=2E</span><br><span style=
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
(120, 100%, 40%);">+net_iface_type(const openvpn_net_ctx_t *ctx, const char=
 *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span>     memset(type, 0, IFACE_TYPE_LEN_M=
AX);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int ret =3D sitnl_send(&amp;req=2En, 0, 0, sitnl_type_save, type);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D sitnl_l=
ink_get(iface, sitnl_type_save, type);</span><br><span>     if (ret &lt; 0)=
</span><br><span>     {</span><br><span>         msg(D_ROUTE, &quot;%s: can=
not retrieve iface %s: %s (%d)&quot;, __func__, iface, strerror(-ret), ret)=
;</span><br><span>@@ -1462,6 +1478,82 @@</span><br><span>     return 0;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+sitnl_ovpn_mode_save(struct nlmsghdr *n, void *arg)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct ifinfomsg *ifi =3D NLMSG_DATA(n);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct rtattr *tb[IFLA_=
MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 rtattr *tb_link[IFLA_INFO_MAX + 1];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct rtattr *tb_data[IFLA_OVPN_MAX + 1];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    enum ovpn_mode *mode =3D ar=
g;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t raw_m=
ode;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (n-&gt;nlmsg_type !=3D RTM_=
NEWLINK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (n-&gt;nlmsg_len &lt; NLMSG_LENGTH(sizeof(*ifi)=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAY=
LOAD(n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tb[IFLA_LINKINFO])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LI=
NKINFO]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tb_link[IFLA_INFO_KI=
ND]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || strcm=
p(RTA_DATA(tb_link[IFLA_INFO_KIND]), OVPN_FAMILY_NAME) !=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!tb_link[IFLA_INFO_DATA])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return -ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sitnl_parse_rtattr_neste=
d(tb_data, IFLA_OVPN_MAX, tb_link[IFLA_INFO_DATA]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!tb_data[IFLA_OVPN_MODE])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return -ENOENT;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (RTA_PA=
YLOAD(tb_data[IFLA_OVPN_MODE]) &lt; sizeof(raw_mode))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return -EINVAL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    raw_m=
ode =3D *(uint8_t *)RTA_DATA(tb_data[IFLA_OVPN_MODE]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    *mode =3D (enum ovpn_mode)raw_mode;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_ovpn_mode(ope=
nvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int ret =3D sitnl_link_get(iface, sitnl_ovpn_mo=
de_save, mode);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUT=
E, &quot;%s: cannot retrieve ovpn mode for iface %s: %s (%d)&quot;, __func_=
_, iface,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  strerror(-ret), ret);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: mo=
de of %s: %d&quot;, __func__, iface, *mode);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(=
ENABLE_DCO) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> int</span><br><span> net_iface_del(const openvpn_net_ctx_t *ct=
x, const char *iface)</span><br><span> {</span><br><span>diff --git a/src/o=
penvpn/networking_sitnl=2Eh b/src/openvpn/networking_sitnl=2Eh</span><br><s=
pan>index 481cc36=2E=2E7a2d964 100644</span><br><span>--- a/src/openvpn/net=
working_sitnl=2Eh</span><br><span>+++ b/src/openvpn/networking_sitnl=2Eh</s=
pan><br><span>@@ -24,4 +24,30 @@</span><br><span> typedef char openvpn_net_=
iface_t;</span><br><span> typedef void *openvpn_net_ctx_t;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET=
_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;linux/if_link=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef IFLA_OVPN_MAX</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+enum ovpn_mode</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    OVPN_MODE_P2P,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   OVPN_MODE_MP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+enum ovpn_ifla_attrs</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    IFLA_OVPN_UNSPEC =3D 0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    IFLA_OVPN_MODE,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    __IFLA_OVPN_MAX,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define IFLA_OVPN_MAX (__IF=
LA_OVPN_MAX - 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef IFLA_=
OVPN_MAX */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET=
_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #endif /* NETWORKING_SITNL_H_ */</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">ch=
ange 1734</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1734 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Ralf=
 Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--/ePFfiVxKEc=--


--===============0666992296734533786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0666992296734533786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0666992296734533786==--

