Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEEACC6B08
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MLF5z7plWr9ZqhOOZzpSm+AAZgXNKMFWO8mCw+S1Ei4=; b=HYbw/zhnhl8vHV3VwY+vDqHDGd
	6m0LNYBwBBdBZO8xMy1CUIXK4eh6NMRTUb5T02qxFowZLbGEj8J2fHaQwafYPaKwtunW0KZxztgPu
	Rd4SAt64/dWZk2JgKBkOw2daHDAK6iB1w4BjPD3J90Pie8EouOdS4kNhDEbuUddncSrI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGZNo-00087W-MY;
	Tue, 13 Oct 2026 10:05:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGZNg-00087L-F7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iBIgfI8KWfteaG0pw12iuEH8MQ/E5LPlIgv0Uxlic4w=; b=GDC6U8Bh9E1SzSTvDrdQw3C7Lm
 uR8+USjc4n898UNGxX+qZQjah0ZkJ31GYvzTpfmtkkwgdc8aayX49hasiAC2ybsqjtDolGC0gMeNJ
 6vWNDGlmzfrtZnHbUa1OVILn/AYqmGU5yHDm1+LfTkD8+fOtdy375KEP9oY73WsLUpA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iBIgfI8KWfteaG0pw12iuEH8MQ/E5LPlIgv0Uxlic4w=; b=V
 rnto3qJCXY/T5ve+QzXal2PVEzTcw37fULcVCYshg0hZmgKmCUpZmSxjq/h5uYwQQYFUTwZP3mC8e
 TTQDU/o7UUnyGGPIc0rN48AX+gHpNg4gHfG5i14wsXomBs3tamGsp0zhmDqgVl4MuhHbGTMe74Jkb
 XfDxBZmiy3vG9xls=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGZNb-00073A-QL for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:05:12 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so22877465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791885901; x=1792490701; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iBIgfI8KWfteaG0pw12iuEH8MQ/E5LPlIgv0Uxlic4w=;
 b=gAdwvUmBQorsyM3KRNY2P4orERGUx4tmH1WscWB4k4Y0iiHRJgnYFEachrI3KNLiCF
 DzWTg5i/6G2a4ViFgENwD2j5oLcFJDKEfhLMBxPKoyg4zspJ845rw4B/VMCNEZ8YhjHX
 koUAPQsqW5cHKYzPEzp75+1VqKdEpH+JFkvsJghVAmM8zA7/4A6d8kXREzIR9ZJoGAMU
 LzMQM/7Cx2RWi7xnwij+DI6IGVPTUeBLSx7RoQMgeveP2g8Ejqpr/f3PK5t5fcRqz3sh
 OpVzB0CPkyiqGNbgqLhneZK/0OxYUOIWVIiBURHLEyydxLqQrDpivNzjXEVOFETwxn0p
 QQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791885901; x=1792490701;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iBIgfI8KWfteaG0pw12iuEH8MQ/E5LPlIgv0Uxlic4w=;
 b=XrWHwi+7FrlUk1h1sySxig7qwaXBDU6Evg5+8Kh7TcxEl+wvnNzJkbQeu0dy0tkKcI
 /KUnZIt+2M9Jlqorad41wojaENS416Vs3UuOuJ/vWhGwNzwnrd7S+ZUoEgFyNyb1vCI/
 9JL66GDMkDyRO5Y28UuKaD6yY6jGi5JyoXUzP6ZeYQVVQ0KJhEiL6RGcTZXR1jETkeXO
 HIhgKac8t6ela/v5nuKxhaouia4htc4OfPAi1zkFogH1XEXYjufBvWSnk38b12R5rwSV
 WT5zkphGInGT/Bv0sWfANuzvbhlXxHkXg1xJQ3a75f83hIhMtmBWiVbiHJJZEmfxcZtR
 cLew==
X-Gm-Message-State: AFq9FYL8O4ur6wqGEsgxC11CCOSy7/afjB3QTtI03WPABYZXJlD01DPM
 Ke1Jadd1+vV6Nmm9zYvHBgkDK0eO1j8PRsPsdgfEiDrDp/o6j3ms4AgLIyDbFtwQcuImIOh6UAi
 r9WonIKeubD6+S/yvHaGswPoU2XkHE8geyPA0j9IyBLBmblg+AZE7/N6nrfTROb5ZwzuhQ4IzbG
 vpvY+b8g==
X-Gm-Gg: AYBFou1bS55DNH5iZgl5WnptTAyGQr7Fm8lAc/QL85j+sSmPvK2YiFPnXsN8IDsQXw/
 g8+sXXMK96h+pY+2KmDwZStFdjsQrj2zvXg4wo3Q/Cu0Zg3lE/GjPyqmk4y3g1w8rQoTsyyVlcS
 pkrHBH5LE8iOiO2QOTvHZX/sZNh7XANQfMJ9bhliGdoI4Lc3oWE3QBTHROq5hcZprlFNn5XSXen
 er6kfLNw8G7RKVQwTFAuyerneBOJ+/RLKB1rWT7ymuyMomQqcGbDVHXkDJmzJGIovohKYVSVyeM
 584TWeThI/Pvtw2TAdv1k2eyRBiEEHsslEDGxGzzKsf9WcwCAtZw59NuJpCh7gXydRYEa6X6aA4
 Uba0PzEjdbWriuVd10X6xZrLew6/1Qxs83YKzh0GjOB41Z5IJzhSAkgbLfndGXWV5bJSLRP5HpO
 Z2OFOQuHngfzpEBwcMPJNnZvBpuRUXDHNuqUI1dlLxyhLrOg3kfuu3bZTa1NVCil0zDxDgelISR
 hXOdTi3FJZlCcOfqVB7XTXtMfRu/hJFqcQCmnda7kevZ0PVVbJPxE2ccfMv9QLX7GVbYnZ5IoDK
 feFg0kMA/h6zCMvYWxFWTl4Cxla1bMphs4dSSPy4QxxlfiZqQCSYhGEhU2s7
X-Received: by 2002:a05:600c:e547:20b0:4a1:946c:953d with SMTP id
 5b1f17b1804b1-4a1946c968cmr119974735e9.27.1791885899804; 
 Tue, 13 Oct 2026 03:04:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm386100615e9.10.2026.10.13.03.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:04:59 -0700 (PDT)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 10:04:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: f1edccb06fdbcdcd234a09283f196af9ed8965a2
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ac00eda8a4b0ef6315c1fe507d09205cc0e63f5d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGZNb-00073A-QL
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
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5232100455333339889=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5232100455333339889==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VnRWw05wQ+I="; charset=UTF-8

--VnRWw05wQ+I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Hello Ant=
onio Quartulli, Arne Schwabe, 

I'd like you to reexamine a change=2E Pleas=
e visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail

t=
o look at the new patch set (#3)=2E

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
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/34/1734/3

diff=
 --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 7ef75fee=2E=2E4b82=
b29 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -109,7 +1=
09,8 @@
 bool ovpn_dco_init(struct context *c);
 
 /**
- * Open/create a DC=
O interface
+ * Open/create a DCO interface and store its ifindex=2E
+ * If=
 the interface already exists, save the ifindex anyway and return -EEXIST=
=2E
  *
  * @param tt        the tuntap context
  * @param ctx       the ne=
tworking API context
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/d=
co_linux=2Ec
index a397fb8=2E=2Ee6e12b4 100644
--- a/src/openvpn/dco_linux=
=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -540,6 +540,19 @@
     CLEAR(dco);
=
 }
 
+static const char *
+ovpn_mode_to_str(enum ovpn_mode mode)
+{
+    sw=
itch (mode)
+    {
+        case OVPN_MODE_P2P:
+            return "p2p";
=
+        case OVPN_MODE_MP:
+            return "server";
+    }
+    retur=
n "unknown";
+}
+
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *=
ctx, const char *dev)
 {
@@ -547,11 +560,30 @@
     ASSERT(tt->type =3D=3D =
DEV_TYPE_TUN);
 
     int ret =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME,=
 &tt->dco);
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
+        en=
um ovpn_mode mode;
+        int mode_ret =3D net_iface_ovpn_mode(ctx, dev, =
&mode);
+
+        if (mode_ret < 0)
+        {
+            msg(M_WARN, "D=
CO: cannot retrieve mode of existing interface %s: %s (%d)", dev,
+        =
        strerror(-mode_ret), mode_ret);
+            return mode_ret;
+    =
    }
+
+        if (mode !=3D tt->dco=2Eifmode)
+        {
+            ms=
g(M_WARN, "DCO: existing interface %s is in %s mode, expected %s mode",
+  =
              dev, ovpn_mode_to_str(mode), ovpn_mode_to_str(tt->dco=2Eifmod=
e));
+            return -EINVAL;
+        }
+    }
 
     tt->dco=2Eifinde=
x =3D if_nametoindex(dev);
     if (!tt->dco=2Eifindex)
@@ -559,7 +591,7 @@=

         msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev=
);
     }
 
-    return 0;
+    return ret;
 }
 
 void
@@ -567,7 +599,10 @@=

 {
     msg(D_DCO_DEBUG, __func__);
 
-    net_iface_del(ctx, tt->actual_n=
ame);
+    if (!tt->persistent_if)
+    {
+        net_iface_del(ctx, tt->a=
ctual_name);
+    }
     ovpn_dco_uninit_netlink(&tt->dco);
 }
 
diff --git=
 a/src/openvpn/dco_linux=2Eh b/src/openvpn/dco_linux=2Eh
index c487581=2E=
=2Ea999d77 100644
--- a/src/openvpn/dco_linux=2Eh
+++ b/src/openvpn/dco_lin=
ux=2Eh
@@ -24,6 +24,7 @@
 #if defined(ENABLE_DCO) && defined(TARGET_LINUX)
=
 
 #include "event=2Eh"
+#include "networking_sitnl=2Eh"
 
 #include "ovpn_=
dco_linux=2Eh"
 
@@ -38,28 +39,6 @@
 typedef enum ovpn_key_slot dco_key_slo=
t_t;
 typedef enum ovpn_cipher_alg dco_cipher_t;
 
-/* OVPN section */
-
-#=
ifndef IFLA_OVPN_MAX
-
-enum ovpn_mode
-{
-    OVPN_MODE_P2P,
-    OVPN_MOD=
E_MP,
-};
-
-enum ovpn_ifla_attrs
-{
-    IFLA_OVPN_UNSPEC =3D 0,
-    IFLA=
_OVPN_MODE,
-
-    __IFLA_OVPN_MAX,
-};
-
-#define IFLA_OVPN_MAX (__IFLA_OV=
PN_MAX - 1)
-
-#endif /* ifndef IFLA_OVPN_MAX */
-
 typedef struct
 {
     =
/* socket used for synchronous request/reply transactions (commands and
dif=
f --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index bce=
0c19=2E=2Ecab560c 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn=
/networking=2Eh
@@ -115,6 +115,19 @@
  */
 int net_iface_type(openvpn_net_c=
tx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX]);
 
+#if define=
d(ENABLE_DCO) && defined(TARGET_LINUX)
+/**
+ * Retrieve the ovpn interface=
 mode
+ *
+ * @param ctx       the implementation specific context
+ * @par=
am iface     interface to query
+ * @param mode      variable where the ovp=
n mode attribute will be stored
+ *
+ * @return          0 on success, a ne=
gative error code otherwise
+ */
+int net_iface_ovpn_mode(openvpn_net_ctx_t=
 *ctx, const char *iface, enum ovpn_mode *mode);
+#endif
+
 /**
  * Remove =
an interface
  *
diff --git a/src/openvpn/networking_iproute2=2Ec b/src/ope=
nvpn/networking_iproute2=2Ec
index a1f3525=2E=2E85ab158 100644
--- a/src/op=
envpn/networking_iproute2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ =
-82,6 +82,16 @@
     return -1;
 }
 
+#if defined(ENABLE_DCO)
+int
+net_ifa=
ce_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mod=
e)
+{
+    /* not supported by iproute2 */
+    msg(M_WARN, "%s: operation =
not supported by iproute2 backend", __func__);
+    return -EOPNOTSUPP;
+}
=
+#endif
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {=

diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sit=
nl=2Ec
index 83915db=2E=2Eb457abd 100644
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
t: 3
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

--VnRWw05wQ+I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Ralf Lici <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"https://g=
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
9418/openvpn refs/changes/34/1734/3</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2E=
h b/src/openvpn/dco=2Eh</span><br><span>index 7ef75fee=2E=2E4b82b29 100644<=
/span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn=
/dco=2Eh</span><br><span>@@ -109,7 +109,8 @@</span><br><span> bool ovpn_dco=
_init(struct context *c);</span><br><span> </span><br><span> /**</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * Open/create a DCO interface</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Open/create a DCO =
interface and store its ifindex=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * If the interface already exists, save the ifindex anyway =
and return -EEXIST=2E</span><br><span>  *</span><br><span>  * @param tt    =
    the tuntap context</span><br><span>  * @param ctx       the networking =
API context</span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/op=
envpn/dco_linux=2Ec</span><br><span>index a397fb8=2E=2Ee6e12b4 100644</span=
><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvp=
n/dco_linux=2Ec</span><br><span>@@ -540,6 +540,19 @@</span><br><span>     C=
LEAR(dco);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ovpn_mode_to_str(enum ovpn_mode mode)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    switch (mode)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        case OVPN_MODE_P2P:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return &quot;p2p&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        case OVPN_MODE_MP:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return &quot;server&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;unknown&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><=
span> open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *d=
ev)</span><br><span> {</span><br><span>@@ -547,11 +560,30 @@</span><br><spa=
n>     ASSERT(tt-&gt;type =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br=
><span>     int ret =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &amp;tt-&=
gt;dco);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &=
lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &=
lt; 0 &amp;&amp; ret !=3D -EEXIST)</span><br><span>     {</span><br><span> =
        msg(D_DCO_DEBUG, &quot;Cannot create DCO interface %s: %d&quot;, de=
v, ret);</span><br><span>         return ret;</span><br><span>     }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D -EEXIST=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        enum ovpn_mode mode;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int mode_ret =
=3D net_iface_ovpn_mode(ctx, dev, &amp;mode);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (mode_ret &lt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(M_WARN, &quot;DCO: cannot retrieve mode of existing i=
nterface %s: %s (%d)&quot;, dev,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                strerror(-mode_ret), mode_ret);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return mode_ret;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (mode !=3D tt-&gt;dco=2Eifmode)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;DCO: existi=
ng interface %s is in %s mode, expected %s mode&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                dev, ovpn_mode_to_str(mo=
de), ovpn_mode_to_str(tt-&gt;dco=2Eifmode));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            return -EINVAL;</span><br><span style=
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
rking=2Eh</span><br><span>index bce0c19=2E=2Ecab560c 100644</span><br><span=
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
rc/openvpn/networking_iproute2=2Ec</span><br><span>index a1f3525=2E=2E85ab1=
58 100644</span><br><span>--- a/src/openvpn/networking_iproute2=2Ec</span><=
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
<span>index 83915db=2E=2Eb457abd 100644</span><br><span>--- a/src/openvpn/n=
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
hSet: 3 </div>
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
--VnRWw05wQ+I=--


--===============5232100455333339889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5232100455333339889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5232100455333339889==--

