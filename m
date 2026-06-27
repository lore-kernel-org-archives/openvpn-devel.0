Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD3BC43327
	for <openvpn-devel@archiver.kernel.org>; Sat, 27 Jun 2026 07:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=GspZIALgn8YoJ3uHEnFsUQDFO4hG698JEDNPWXeznWE=; b=lujU42viNNlWkU
	uxJewpqQWMsHNZ63J6gViNVzYh6+7AdXfSYnMii7aOM/ancMugzxcIlimYyQpthTS2g94HlG4NuCf
	0y39JG94c87gQkCmUCC2tCylpWQqu0+C3hQy2sYS2ddvysraF0wpmKy05IREvwMaRM//0//QDdmc9
	GQo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdNTE-0000tN-0I;
	Sat, 27 Jun 2026 07:28:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdNTB-0000tG-VF
 for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 07:28:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EVX7ZfyKr0iSB9k/QCwsWxdy1qfc5Uhoz1JC6aGudtk=; b=Sf0J4+8mgph+vdQ86/7qnpsWaf
 MFP1SzBADzzQnN6JS3yoy3/4pgdj5lpaEJyU5amkFhKw1GSFeVvnDQaoV7UU9fsMuzva865E+i9Tu
 4OBDwUBGYzLzdCac0KJbmVdvtWP9aa9R2tGK3qDtPwc1QNHZ+7z5/hcXuXZpl2xlYduE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EVX7ZfyKr0iSB9k/QCwsWxdy1qfc5Uhoz1JC6aGudtk=; b=k
 ZpJXyQpm41QE3EicnwZgmC2ILHe+VOVy7k2WsrKHQTM0Xtvqk9OKd9cwmtPyso1BIsLRelYJsmS8j
 0wrk51D1RtTCNqYU5fjwzqfRkHLVwJ9Gt4ruZmiEWRlehI0EzKwvqd9pAg1wIOfrkgVDrwfoFYlyS
 vPvUitCaTziXjIT4=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdNTA-000559-Mj for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 07:28:54 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso18449425e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 27 Jun 2026 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782545322; x=1783150122; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVX7ZfyKr0iSB9k/QCwsWxdy1qfc5Uhoz1JC6aGudtk=;
 b=WAJYK1n6s/EJWYylK64DCq7M8juFh8LplPlnjA/OkdYhgwXwLvyQpDHsYfIeRVnta6
 cKaVys8SR9BKaMn5oUKkdglnXhaCzkbzBTiLH1W0DuIwX/lPvP5txrsSF3uhyqff69XC
 as3WDDaPaUeh9DXijIE3Eg17AXKD0WoypIEQ1R7+qjknyNB4T4yj73/K7Aqb0b7YFV16
 xCOGoZUwzGK8Q2tx7jKopW4EUi8AJFd8Vi9x6Dd9L3Of6EJTjuK63XAaLZ9a28Jd9dhf
 Y+9jrSRY0K19sheic/8o9fTRJWg/x6IG1356py3oVVAfYwoLJpPiMSwo6cP7NipufeUD
 0ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782545322; x=1783150122;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVX7ZfyKr0iSB9k/QCwsWxdy1qfc5Uhoz1JC6aGudtk=;
 b=n1jeMYE0Zge1WZVKe6K3ukVD6yB5G143Y7obiw/1drrl2YiQwJmLklFW01w5acBbYc
 2iWwgklJc6zNXAQVrJA777nn+xDPz382bDg4H8D1S0II3QRrj1OTBqgWYMRrIJfC3fFL
 j/60EFut7WpcnehhSzHYLTGBRXvhLbqVpkobhik6O2j9HQDIpHKa0Quwc6vO3j5h1gIQ
 DwC+A4d+BViI7AYo685nKaWgr/xHqDr/jN/WqAW73Ut4JbCV10R376D0/FI7Z253DVNR
 LJN7khGAJJcnNEoRCa41Lu8Tx8oHiXIemathWuRVmxmptBVCuUV9vsyKFM3cllSFliTB
 pstA==
X-Gm-Message-State: AOJu0Yx0n+b/R6Y6md23kuzuMnYGSLdxo3t0BKtvYJPRowYiOJZzJpVW
 a389vbv6mAMlryxR1SKeL2U6+1iHdpuKMQD+WeYKXKyPB4I/8rHq/YvLcRxuwfgvZhGh/3b939a
 1NJ4Jqwhddq5To4CifKZB1KDkRaQONiR0IIk5Hddky7bMVFECQQxOIcOKfu+JqttufHO1Ww/UDK
 mhxMPtcg==
X-Gm-Gg: AfdE7clR84sp2DbJHDCSIqsThIRQNI/wN6OEuNfQyHTU7dVhREYoIpkO1Gt5ERhNRsd
 JqmXJyo1ULdSxZKrThUV+IfT5Ltm17M+qwKuDoLTrvqdwjfbKwnXVGx1ukO7Ju2qmzHos+ib1QP
 a36b6cbCZJiiwze1zW9DboJ0k1frfBUcwNFnEDGVa4HhUHTb3qWGqagQQUWNBdfhDiVSkva0+Eg
 hv/qI27N4P5U4KsTYi2kIl8I7YsbyKW+9q16BQLUNZw4PjhhQS6TmcwQNB4uvtZlu1D2MK87xoo
 9MtXqXOqwu/9TysXIaAX+urf/x5Leme6x8GS7Fee3Y9nF1dde7OcGnVTjQtLAr06V+m8i+NnhsQ
 Erd/HNzsmrNNiJ0CYye4HJg4bOwOfKvttQuRDv6OvzpxAZfeLZcAu+kSA1Eiwasr9+CHzJu7l+4
 nF3liuyb13AtEkUDlat1BP69KPdAsbl8pLS15SfQ9ku0hEgAr+WdoixivFKOd6VbVcxv0LTx++m
 dF9sxvexI4nKR7SyqDltU6k/5AV/m57DTFb9kWPv+DFHM7l7+U7gt6QqpnH08uuVGyn+z8OA/5S
 Q5s=
X-Received: by 2002:a05:600c:3f06:b0:492:33a8:5499 with SMTP id
 5b1f17b1804b1-492668858a8mr149464825e9.17.1782545321411; 
 Sat, 27 Jun 2026 00:28:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fef710sm250365585e9.7.2026.06.27.00.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 00:28:40 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 27 Jun 2026 07:28:40 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 2902b94906e9b21e9288d9e43b24a3c6b5775e17
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98e776d24f867b99a8669cb831998119ee1d265f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdNTA-000559-Mj
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
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9127770799864044289=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9127770799864044289==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d+OdU9O63+0="; charset=UTF-8

--d+OdU9O63+0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1734?usp=3Demail

to review the following change=2E


Chang=
e subject: Support pre-existing Linux DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Support pre-existing Linux DCO int=
erfaces

When creating an ovpn interface returns -EEXIST, still retrieve th=
e
ifindex and return the error to the generic DCO open path=2E This lets th=
e
caller mark the interface as pre-existing and avoid deleting it on
close=
=2E

Before accepting the existing interface, query its rtnetlink link info=

and verify that it is an ovpn device with the expected mode=2E The ovpn
mo=
de is fixed at interface creation time, so attaching to an interface
create=
d for the other mode cannot work=2E

Honor the pre-existing state on close =
by skipping net_iface_del() for
persistent interfaces=2E

Github: closes Op=
enVPN/openvpn#1064
Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
Sig=
ned-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
---
M src/openvpn/dco=2Eh
M sr=
c/openvpn/dco_linux=2Ec
M src/openvpn/networking=2Eh
M src/openvpn/networki=
ng_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
5 files changed, 144 ins=
ertions(+), 7 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/34/1734/1

diff --git a/src/openvpn/dco=2Eh b/src/ope=
nvpn/dco=2Eh
index 4e5aad5=2E=2E4584004 100644
--- a/src/openvpn/dco=2Eh
++=
+ b/src/openvpn/dco=2Eh
@@ -109,7 +109,8 @@
 bool ovpn_dco_init(struct cont=
ext *c);
 
 /**
- * Open/create a DCO interface
+ * Open/create a DCO inter=
face and store its ifindex=2E
+ * If the interface already exists, save the=
 ifindex anyway and return -EEXIST=2E
  *
  * @param tt        the tuntap c=
ontext
  * @param ctx       the networking API context
diff --git a/src/ope=
nvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 40746bd=2E=2E2eedbf8 1=
00644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -5=
08,11 +508,31 @@
     ASSERT(tt->type =3D=3D DEV_TYPE_TUN);
 
     int ret =
=3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &tt->dco);
-    if (ret < 0)
=
+    if (ret < 0 && ret !=3D -EEXIST)
     {
         msg(D_DCO_DEBUG, "Can=
not create DCO interface %s: %d", dev, ret);
         return ret;
     }
+ =
   else if (ret =3D=3D -EEXIST)
+    {
+        const char *expected =3D tt=
->dco=2Eifmode =3D=3D OVPN_MODE_MP ? "server" : "p2p";
+        uint8_t mod=
e;
+        int mode_ret =3D net_iface_ovpn_mode(ctx, dev, &mode);
+
+     =
   if (mode_ret < 0)
+        {
+            msg(M_WARN, "DCO: cannot retri=
eve mode of existing interface %s: %s (%d)", dev,
+                strerror=
(-mode_ret), mode_ret);
+            return mode_ret;
+        }
+
+       =
 if (mode !=3D (uint8_t)tt->dco=2Eifmode)
+        {
+            msg(M_WAR=
N, "DCO: existing interface %s is in %s mode, expected %s mode", dev,
+    =
            mode =3D=3D OVPN_MODE_MP ? "server" : "p2p", expected);
+      =
      return -EINVAL;
+        }
+    }
 
     tt->dco=2Eifindex =3D if_nam=
etoindex(dev);
     if (!tt->dco=2Eifindex)
@@ -520,7 +540,7 @@
         ms=
g(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);
     }
 
=
-    return 0;
+    return ret;
 }
 
 void
@@ -528,7 +548,10 @@
 {
     msg=
(D_DCO_DEBUG, __func__);
 
-    net_iface_del(ctx, tt->actual_name);
+    i=
f (!tt->persistent_if)
+    {
+        net_iface_del(ctx, tt->actual_name);=

+    }
     ovpn_dco_uninit_netlink(&tt->dco);
 }
 
diff --git a/src/openv=
pn/networking=2Eh b/src/openvpn/networking=2Eh
index bce0c19=2E=2Eb74d448 1=
00644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ =
-115,6 +115,19 @@
  */
 int net_iface_type(openvpn_net_ctx_t *ctx, const ch=
ar *iface, char type[IFACE_TYPE_LEN_MAX]);
 
+#if defined(ENABLE_DCO) && de=
fined(TARGET_LINUX)
+/**
+ * Retrieve the ovpn interface mode
+ *
+ * @para=
m ctx       the implementation specific context
+ * @param iface     interf=
ace to query
+ * @param mode      variable where the ovpn mode attribute wi=
ll be stored
+ *
+ * @return          0 on success, a negative error code o=
therwise
+ */
+int net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *=
iface, uint8_t *mode);
+#endif
+
 /**
  * Remove an interface
  *
diff --gi=
t a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=
=2Ec
index a1f3525=2E=2E8105dcb 100644
--- a/src/openvpn/networking_iproute=
2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -82,6 +82,16 @@
     ret=
urn -1;
 }
 
+#if defined(ENABLE_DCO)
+int
+net_iface_ovpn_mode(openvpn_net=
_ctx_t *ctx, const char *iface, uint8_t *mode)
+{
+    /* not supported by =
iproute2 */
+    msg(M_WARN, "%s: operation not supported by iproute2 backe=
nd", __func__);
+    return -EOPNOTSUPP;
+}
+#endif
+
 int
 net_iface_del(o=
penvpn_net_ctx_t *ctx, const char *iface)
 {
diff --git a/src/openvpn/netwo=
rking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index b3f8e2b=2E=2E3c462=
c9 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networki=
ng_sitnl=2Ec
@@ -1412,8 +1412,18 @@
     return 0;
 }
 
-int
-net_iface_typ=
e(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])=

+/**
+ * Issue an RTM_GETLINK query for an interface and feed the reply to=
 the given
+ * parsing callback=2E
+ *
+ * @param iface     name of the int=
erface to query
+ * @param cb        callback invoked with the netlink repl=
y
+ * @param arg       opaque argument passed through to the callback
+ *
+=
 * @return          0 on success, a negative error code otherwise
+ */
+sta=
tic int
+sitnl_link_get(const char *iface, sitnl_parse_reply_cb cb, void *a=
rg)
 {
     struct sitnl_link_req req =3D {};
     int ifindex =3D if_namet=
oindex(iface);
@@ -1430,9 +1440,15 @@
     req=2Ei=2Eifi_family =3D AF_PACK=
ET;
     req=2Ei=2Eifi_index =3D ifindex;
 
+    return sitnl_send(&req=2En=
, 0, 0, cb, arg);
+}
+
+int
+net_iface_type(openvpn_net_ctx_t *ctx, const c=
har *iface, char type[IFACE_TYPE_LEN_MAX])
+{
     memset(type, 0, IFACE_TY=
PE_LEN_MAX);
 
-    int ret =3D sitnl_send(&req=2En, 0, 0, sitnl_type_save,=
 type);
+    int ret =3D sitnl_link_get(iface, sitnl_type_save, type);
    =
 if (ret < 0)
     {
         msg(D_ROUTE, "%s: cannot retrieve iface %s: %=
s (%d)", __func__, iface, strerror(-ret), ret);
@@ -1444,6 +1460,80 @@
    =
 return 0;
 }
 
+#if defined(ENABLE_DCO)
+static int
+sitnl_ovpn_mode_save(=
struct nlmsghdr *n, void *arg)
+{
+    uint8_t *mode =3D arg;
+    struct i=
finfomsg *ifi =3D NLMSG_DATA(n);
+    struct rtattr *tb[IFLA_MAX + 1];
+   =
 struct rtattr *tb_link[IFLA_INFO_MAX + 1];
+    struct rtattr *tb_data[IFL=
A_OVPN_MAX + 1];
+
+    if (n->nlmsg_type !=3D RTM_NEWLINK)
+    {
+       =
 return -EINVAL;
+    }
+
+    if (n->nlmsg_len < NLMSG_LENGTH(sizeof(*ifi)=
))
+    {
+        return -EINVAL;
+    }
+
+    sitnl_parse_rtattr(tb, IFL=
A_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n));
+
+    if (!tb[IFLA_LINKINFO])
+   =
 {
+        return -ENOENT;
+    }
+
+    sitnl_parse_rtattr_nested(tb_link=
, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
+
+    if (!tb_link[IFLA_INFO_KIND]
+ =
       || strcmp(RTA_DATA(tb_link[IFLA_INFO_KIND]), OVPN_FAMILY_NAME) !=3D =
0)
+    {
+        return -EINVAL;
+    }
+
+    if (!tb_link[IFLA_INFO_DAT=
A])
+    {
+        return -ENOENT;
+    }
+
+    sitnl_parse_rtattr_nested=
(tb_data, IFLA_OVPN_MAX, tb_link[IFLA_INFO_DATA]);
+
+    if (!tb_data[IFLA=
_OVPN_MODE])
+    {
+        return -ENOENT;
+    }
+
+    if (RTA_PAYLOAD(=
tb_data[IFLA_OVPN_MODE]) < sizeof(*mode))
+    {
+        return -EINVAL;
+=
    }
+
+    *mode =3D *(uint8_t *)RTA_DATA(tb_data[IFLA_OVPN_MODE]);
+
+  =
  return 0;
+}
+
+int
+net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const ch=
ar *iface, uint8_t *mode)
+{
+    int ret =3D sitnl_link_get(iface, sitnl_o=
vpn_mode_save, mode);
+    if (ret < 0)
+    {
+        msg(D_ROUTE, "%s: c=
annot retrieve ovpn mode for iface %s: %s (%d)", __func__, iface,
+        =
    strerror(-ret), ret);
+        return ret;
+    }
+
+    msg(D_ROUTE, "=
%s: mode of %s: %u", __func__, iface, *mode);
+
+    return 0;
+}
+#endif /=
* defined(ENABLE_DCO) */
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, cons=
t char *iface)
 {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1734?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
72302403bddee4b0b0ee2441ae9e246f48d0bc81
Gerrit-Change-Number: 1734
Gerrit-=
PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>

--d+OdU9O63+0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ralf_lici would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Support pre-existing Linux DCO interfaces<br><br>When creating an ovpn =
interface returns -EEXIST, still retrieve the<br>ifindex and return the err=
or to the generic DCO open path=2E This lets the<br>caller mark the interfa=
ce as pre-existing and avoid deleting it on<br>close=2E<br><br>Before accep=
ting the existing interface, query its rtnetlink link info<br>and verify th=
at it is an ovpn device with the expected mode=2E The ovpn<br>mode is fixed=
 at interface creation time, so attaching to an interface<br>created for th=
e other mode cannot work=2E<br><br>Honor the pre-existing state on close by=
 skipping net_iface_del() for<br>persistent interfaces=2E<br><br>Github: cl=
oses OpenVPN/openvpn#1064<br>Change-Id: I72302403bddee4b0b0ee2441ae9e246f48=
d0bc81<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>---<br>M=
 src/openvpn/dco=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/networ=
king=2Eh<br>M src/openvpn/networking_iproute2=2Ec<br>M src/openvpn/networki=
ng_sitnl=2Ec<br>5 files changed, 144 insertions(+), 7 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/34/1734/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/d=
co=2Eh</span><br><span>index 4e5aad5=2E=2E4584004 100644</span><br><span>--=
- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br=
><span>@@ -109,7 +109,8 @@</span><br><span> bool ovpn_dco_init(struct conte=
xt *c);</span><br><span> </span><br><span> /**</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Open/create a DCO interface</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Open/create a DCO interface and stor=
e its ifindex=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
If the interface already exists, save the ifindex anyway and return -EEXIST=
=2E</span><br><span>  *</span><br><span>  * @param tt        the tuntap con=
text</span><br><span>  * @param ctx       the networking API context</span>=
<br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2E=
c</span><br><span>index 40746bd=2E=2E2eedbf8 100644</span><br><span>--- a/s=
rc/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</s=
pan><br><span>@@ -508,11 +508,31 @@</span><br><span>     ASSERT(tt-&gt;type=
 =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span>     int ret =3D n=
et_iface_new(ctx, dev, OVPN_FAMILY_NAME, &amp;tt-&gt;dco);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0 &amp;&amp; ret !=3D=
 -EEXIST)</span><br><span>     {</span><br><span>         msg(D_DCO_DEBUG, =
&quot;Cannot create DCO interface %s: %d&quot;, dev, ret);</span><br><span>=
         return ret;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (ret =3D=3D -EEXIST)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const char *expected =3D tt-&gt;dco=2Eifmode=
 =3D=3D OVPN_MODE_MP ? &quot;server&quot; : &quot;p2p&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        uint8_t mode;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        int mode_ret =3D net_ifa=
ce_ovpn_mode(ctx, dev, &amp;mode);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (mode_ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(M_WARN, &quot;DCO: cannot retrieve mode of existing interface %s=
: %s (%d)&quot;, dev,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                strerror(-mode_ret), mode_ret);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return mode_ret;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (mode !=3D (uint8_t)tt-&gt;dco=2Eifmode)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;DCO: existi=
ng interface %s is in %s mode, expected %s mode&quot;, dev,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                mode =3D=3D OVPN_MO=
DE_MP ? &quot;server&quot; : &quot;p2p&quot;, expected);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return -EINVAL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>=
     tt-&gt;dco=2Eifindex =3D if_nametoindex(dev);</span><br><span>     if =
(!tt-&gt;dco=2Eifindex)</span><br><span>@@ -520,7 +540,7 @@</span><br><span=
>         msg(M_FATAL, &quot;DCO: cannot retrieve ifindex for interface %s&=
quot;, dev);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span>@@ -528,7 +548,10 @@</span><br><s=
pan> {</span><br><span>     msg(D_DCO_DEBUG, __func__);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    net_iface_del(ctx, =
tt-&gt;actual_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!tt-&gt;persistent_if)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      net_iface_del(ctx, tt-&gt;actual_name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span>     ovpn_dco_uninit_netlin=
k(&amp;tt-&gt;dco);</span><br><span> }</span><br><span> </span><br><span>di=
ff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh</span><b=
r><span>index bce0c19=2E=2Eb74d448 100644</span><br><span>--- a/src/openvpn=
/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh</span><br>=
<span>@@ -115,6 +115,19 @@</span><br><span>  */</span><br><span> int net_if=
ace_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LE=
N_MAX]);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Retrieve the ovpn interface mode</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param ctx       the implementation specific =
context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param if=
ace     interface to query</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param mode      variable where the ovpn mode attribute will be s=
tored</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return          0 on succes=
s, a negative error code otherwise</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, uint8_t *=
mode);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</spa=
n><br><span>  * Remove an interface</span><br><span>  *</span><br><span>dif=
f --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_ipro=
ute2=2Ec</span><br><span>index a1f3525=2E=2E8105dcb 100644</span><br><span>=
--- a/src/openvpn/networking_iproute2=2Ec</span><br><span>+++ b/src/openvpn=
/networking_iproute2=2Ec</span><br><span>@@ -82,6 +82,16 @@</span><br><span=
>     return -1;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const cha=
r *iface, uint8_t *mode)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* not su=
pported by iproute2 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    msg(M_WARN, &quot;%s: operation not supported by iproute2 backend&qu=
ot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return -EOPNOTSUPP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br=
><span> net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)</span><br>=
<span> {</span><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/sr=
c/openvpn/networking_sitnl=2Ec</span><br><span>index b3f8e2b=2E=2E3c462c9 1=
00644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><spa=
n>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -1412,8 +1412,1=
8 @@</span><br><span>     return 0;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-net_iface_type(openvpn_net_ctx_t *ctx, con=
st char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Issue an RTM_GETLINK query for an interface and feed the repl=
y to the given</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pa=
rsing callback=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param iface    =
 name of the interface to query</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param cb        callback invoked with the netlink reply</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param arg       opa=
que argument passed through to the callback</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return          0 on success, a negative error code otherwise</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+sitnl_link_get(const char *iface, sitnl_parse_r=
eply_cb cb, void *arg)</span><br><span> {</span><br><span>     struct sitnl=
_link_req req =3D {};</span><br><span>     int ifindex =3D if_nametoindex(i=
face);</span><br><span>@@ -1430,9 +1440,15 @@</span><br><span>     req=2Ei=
=2Eifi_family =3D AF_PACKET;</span><br><span>     req=2Ei=2Eifi_index =3D i=
findex;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return sitnl_send(&amp;req=2En, 0, 0, cb, arg);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_type(=
openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span>   =
  memset(type, 0, IFACE_TYPE_LEN_MAX);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int ret =3D sitnl_send(&amp;req=2En,=
 0, 0, sitnl_type_save, type);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int ret =3D sitnl_link_get(iface, sitnl_type_save, type);</s=
pan><br><span>     if (ret &lt; 0)</span><br><span>     {</span><br><span> =
        msg(D_ROUTE, &quot;%s: cannot retrieve iface %s: %s (%d)&quot;, __f=
unc__, iface, strerror(-ret), ret);</span><br><span>@@ -1444,6 +1460,80 @@<=
/span><br><span>     return 0;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+sitnl_ovpn_mode_save(struct nlms=
ghdr *n, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *mode =
=3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
ifinfomsg *ifi =3D NLMSG_DATA(n);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct rtattr *tb[IFLA_MAX + 1];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct rtattr *tb_link[IFLA_INFO_MAX + 1=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct rtattr=
 *tb_data[IFLA_OVPN_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (n=
-&gt;nlmsg_type !=3D RTM_NEWLINK)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return -EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (n-&gt;nlmsg_len &lt; =
NLMSG_LENGTH(sizeof(*ifi)))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return -EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    sitnl_parse_rtattr(tb, IFLA_MAX=
, IFLA_RTA(ifi), IFLA_PAYLOAD(n));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!tb[IFLA_LINKINFO])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn -ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    sitnl_parse_rtattr_nested(tb_link, =
IFLA_INFO_MAX, tb[IFLA_LINKINFO]);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!tb_link[IFLA_INFO_KIND]</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        || strcmp(RTA_DATA(tb_link[IFLA_INFO_KIND]), OVPN_FAMILY_N=
AME) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -EINVA=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!tb_link[IFLA_INFO_DATA])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
sitnl_parse_rtattr_nested(tb_data, IFLA_OVPN_MAX, tb_link[IFLA_INFO_DATA]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!tb_data[IFLA_OVPN_MODE])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (RTA_PAYLOAD(tb_data[IFLA_OVPN_MODE]) &lt; sizeof(*mode))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    *mode =3D *(uint8_t *)RTA_DATA(tb_data[IFLA_OVPN_MODE]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_ovpn_mode(openv=
pn_net_ctx_t *ctx, const char *iface, uint8_t *mode)</span><br><span style=
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
: %u&quot;, __func__, iface, *mode);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(ENABLE_D=
CO) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> int</span><br><span> net_iface_del(openvpn_net_ctx_t *ctx, const char =
*iface)</span><br><span> {</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">c=
hange 1734</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1734 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_li=
ci &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--d+OdU9O63+0=--


--===============9127770799864044289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9127770799864044289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9127770799864044289==--

