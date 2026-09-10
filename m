Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77952C79FB9
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CJxkEhHToHs/8bYetJuytWA+EGc+BbHxObeho27brjI=; b=gkHzazOPRFyFT28kffTUdX7poo
	pov8PA8yrGNbEbcubzDlMu124laZccQpTYGUy/jGZRC4PHWsJ1g1rzDvkYz8br++O0Zv3n2gjUt6O
	YFFt1u8suGRbIK5IwSLMEeBOqsfHkhi9Er9e/VjaIOtP2gSOO6iRIjx6E0+QdxAasj/0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4a3i-0006K4-1l;
	Thu, 10 Sep 2026 08:22:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4a3f-0006Jc-Nt
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qdQFlwyxMXiiYJKqwv21Cfy1jpJxwOiZYsiNbv/qmtw=; b=mQCeMAp/4aL1whSGpj2ZipT/R3
 s8LjTdt2g3Y2637JPdq9ZXH0zM/lpoXSLFT4QoP5yi8+tFgzViOQvK+OdHgUuqLeeXJ6Kh7Rdm1fu
 RfA7qdnvc3ikgHnyJf3yP/8Za09QFqfiqcAl3S8SmnOY58LeHM8vOcfgrsad0d30ZBfQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qdQFlwyxMXiiYJKqwv21Cfy1jpJxwOiZYsiNbv/qmtw=; b=O
 6OyVTOUd6/t3EYlJWKEbSFYV9R+YN6+jR9Nu79HAoYxTTFcwd+KX6LEJXBL3+Q7oAzDYtj+hv23XX
 3mc+W8rmSt7FKq6V/tvNw1xArPcewfb43rIWqQwyzNro+ukoU5jrNqAyrOKILSCU3ivNZ1xS96YK+
 0bJJBTiyWzb/QRb4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4a3Z-0008RC-Kh for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:22:57 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so85726515e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789028567; x=1789633367; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qdQFlwyxMXiiYJKqwv21Cfy1jpJxwOiZYsiNbv/qmtw=;
 b=Ldtzb7BXN6BIt9fZJ+VHEo8+pDiX5CRChy2Ueuqmi6zOVRzWRdsUGaD3AM+00Osr7l
 iO6ytulDFI66XrsRSr726kfexjD3+cCEZqFjqSmmWG6GKBGxmgJHMOkIMaN/dtele/NI
 0dn3omc59ENsIp5xaZfCh6woombEedLiZY+v2f/foqtfmlrAY64ERZ/itDKWFVm9W6jt
 ErJQEhCDJpI/bYH/PsrlzwXhgzElPSszhDyDAq9XDlB/MTH9VM5qfrxmWBCTfz5IZTnh
 iZoNlwFXfMETohqdgGvEFoUYTC/cE/Z+QgERlQnQS2g0XcuxFtJF770kg5Abr74hwyha
 T80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789028567; x=1789633367;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qdQFlwyxMXiiYJKqwv21Cfy1jpJxwOiZYsiNbv/qmtw=;
 b=drgXSLBo3MyIb5x/AATfmzYNqT9a8y6SNZZc2kJ3vUZNK9ZSTfmNnCyIDLLwQMeVF2
 4hkdVY3FRqKF4X8smKJFyfhE3d9AAFb+MbruQzepunPgQA9t8PP3FhwIadT3mwV1zNWK
 dMN99fSXOIEYSrt+n5DIFOHseDy6EwRlbz6x0dl/SQ85ZuyIdVjJkGgpA6ppa1Kbl95o
 cXHEtMndFaOmLKcjqCUZ4wr74eqGwM0GRVFzmyKB4OVbxgXqhg6fX3FIk/7cA4Z4KPXm
 3qdJADar+5FKYuuzLl5s5tmfAh6by+knaXSeKoiJiq91gre7ccdiRrgNqxBNKhE4M7hs
 rMaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrsUppoBj7hFDkvgMXWZJFx7/1tSupIqXLds/dkJB7eOtCSWOmUIGcX8J+BA9FTL1VfTQjU28QfKWo399F@lists.sourceforge.net
X-Gm-Message-State: AFuF++m4mAhkzYbDNCv3AhxdroGje3vHDyR7w/7zhcYxMaDyWMavhhk8
 pyTKRY/Okz/ykWAHQpI+D3SRopD0Wl0xLdzz7OjsvC/tLSbVst5L8U6vuPoQLhWGTV5OaBPFz4l
 fZhcXgXnJYON9zbHGir94ci3Py9XVv0WJRDFYVVu9mJ3F/o05Pgz7+YEiWVhQJjtA5CAe
X-Gm-Gg: AYBFou0kep2mJ54t/kWkGORQxDauxyIyjlKyjc/McKwbw9JN+l80xK8ECplRDmq5FsE
 LXqs965koC1dm+1xDFO5SJOyAMKG1th0P1NUDvDrVkNooFpdadneP2MqPwnCJfvfSTk0s2a8Y+q
 1roMr6hopqsgktXY/8xAJUh2wW41T4O7JDfPycZAvLujwaC9DtuXE41S6Fc3L1/qlYO7kpdOwHi
 Kk3vOfIJt1ya3tIEL988B1ORLNVATPmIvQOO6wJHYAhO/dcLIQoJ4bkoUypv+kdTtYeHXWzASI2
 PVHMNefV9j2Bo9ypZGQUowe+O1lpOX9lqSv6e+7Toflhd9SUjc12dDvu3nxLvCYbfP4GrgXEdMA
 5ofPS20qrQEvqraPf/TJHGl8zCnC/gk/Jj/OwEJY7vK8HBN5mY9NcYlRIL8rcZNl2CKiDfexMN7
 V/0Gc7NkSmMPteTnBiRbpFw3DxSZMu2512TLV+PuJzD3yOcR5iO7UlUqMUaHREIDpksCY4yrPB9
 UXUl0GqoLULZrnOS6JVwCk+fLvFmc5WFURE4ZFKE+kiAgtPYac3ZRUP2uAJrN0awhC6/pbniZMl
 3clGtdjxaz05vNX6ZQ1LUeMGFB7P/YPqSWFCK8qALz9P/za4+OPjEKvu1MgsUw==
X-Received: by 2002:a05:600c:a04:b0:499:db27:7b1 with SMTP id
 5b1f17b1804b1-49cf82621acmr418568055e9.15.1789028566818; 
 Thu, 10 Sep 2026 01:22:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e60bsm106931955e9.0.2026.09.10.01.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 01:22:46 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 08:22:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: 8559184d4d69311300b093095358ddbf4346b90a
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a063073ed66e223262c462fb0fb7fbaa0c3eb65d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4a3Z-0008RC-Kh
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi/dco: simplify
 dco_delete_iroutes call chain
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6929719667280152162=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6929719667280152162==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ACdJIG1NF50="; charset=UTF-8

--ACdJIG1NF50=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

He=
llo plaisthos, 

I'd like you to reexamine a change=2E Please visit

    ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail

to look at the ne=
w patch set (#4)=2E

The following approvals got outdated and were removed:=

Code-Review+2 by plaisthos

The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now=2E


Change subject: mul=
ti/dco: simplify dco_delete_iroutes call chain
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi/dco: simplify dco_delete_iroutes c=
all chain

In order to be able to delete DCO iroutes from areas of the code=

where the multi_context and the multi_instance objects may not be
availabl=
e, let's simplify the call chain by passing the smallest
scoped context req=
uired=2E

This is a refactoring only and does not include any functional ch=
ange=2E

This patch is required in preparation of fixing DCO iroutes remova=
l
upon client exit, without waiting for the delayed exit routine
to kick in=
=2E

Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
Signed-off-by: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M src/o=
penvpn/dco=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
4 files chan=
ged, 29 insertions(+), 37 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/82/1682/4

diff --git a/src/openvpn/dco=
=2Ec b/src/openvpn/dco=2Ec
index 8eae4bf=2E=2Eba1c85f 100644
--- a/src/open=
vpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -741,26 +741,24 @@
 }
 
 void
-dco=
_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+dco_de=
lete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)
 {
 #if d=
efined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
-    if =
(!dco_enabled(&m->top=2Eoptions))
+    if (!dco_enabled(&c->options))
     =
{
         return;
     }
-    ASSERT(TUNNEL_TYPE(mi->context=2Ec1=2Etuntap=
) =3D=3D DEV_TYPE_TUN);
+    ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_=
TYPE_TUN);
 
-    const struct context *c =3D &mi->context;
-
-    if (mi->=
context=2Ec2=2Epush_ifconfig_defined)
+    if (c->c2=2Epush_ifconfig_define=
d)
     {
         for (const struct iroute *ir =3D c->options=2Eiroutes; i=
r; ir =3D ir->next)
         {
 #if defined(_WIN32)
             dco_win_de=
l_iroute_ipv4(&c->c1=2Etuntap->dco, htonl(ir->network), ir->netbits);
 #els=
e
-            net_route_v4_del(&m->top=2Enet_ctx, &ir->network, ir->netbit=
s,
-                             &mi->context=2Ec2=2Epush_ifconfig_local, c=
->c1=2Etuntap->actual_name, 0,
+            net_route_v4_del(net_ctx, &ir->=
network, ir->netbits,
+                             &c->c2=2Epush_ifconfig_=
local, c->c1=2Etuntap->actual_name, 0,
                              DCO_IR=
OUTE_METRIC);
 #endif
         }
@@ -768,27 +766,26 @@
 #if !defined(_WIN32=
)
         /* Check if we added a host route as the assigned client IP addr=
ess was
          * not in the on link scope defined by --ifconfig */
-    =
    in_addr_t ifconfig_local =3D mi->context=2Ec2=2Epush_ifconfig_local;
+ =
       in_addr_t ifconfig_local =3D c->c2=2Epush_ifconfig_local;
 
-       =
 if (multi_check_push_ifconfig_extra_route(mi, htonl(ifconfig_local)))
+   =
     if (multi_check_push_ifconfig_extra_route(&c->options, htonl(ifconfig_=
local)))
         {
             /* On windows we do not install these rout=
es, so we also do not need to delete them */
-            net_route_v4_del(=
&m->top=2Enet_ctx, &ifconfig_local,
-                             32, NULL,=
 c->c1=2Etuntap->actual_name, 0,
-                             DCO_IROUTE_M=
ETRIC);
+            net_route_v4_del(net_ctx, &ifconfig_local, 32, NULL,
+=
                             c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_MET=
RIC);
         }
 #endif
     }
 
-    if (mi->context=2Ec2=2Epush_ifconfig=
_ipv6_defined)
+    if (c->c2=2Epush_ifconfig_ipv6_defined)
     {
        =
 for (const struct iroute_ipv6 *ir6 =3D c->options=2Eiroutes_ipv6; ir6; ir6=
 =3D ir6->next)
         {
 #if defined(_WIN32)
             dco_win_del_ir=
oute_ipv6(&c->c1=2Etuntap->dco, ir6->network, ir6->netbits);
 #else
-      =
      net_route_v6_del(&m->top=2Enet_ctx, &ir6->network, ir6->netbits,
-   =
                          &mi->context=2Ec2=2Epush_ifconfig_ipv6_local, c->=
c1=2Etuntap->actual_name, 0,
+            net_route_v6_del(net_ctx, &ir6->n=
etwork, ir6->netbits,
+                             &c->c2=2Epush_ifconfig_=
ipv6_local, c->c1=2Etuntap->actual_name, 0,
                              D=
CO_IROUTE_METRIC);
 #endif
         }
@@ -796,11 +793,11 @@
         /* Che=
cked if we added a host route as the assigned client IP address was
       =
   * outside the --ifconfig-ipv6 tun interface config */
 #if !defined(_WIN=
32)
-        struct in6_addr *dest =3D &mi->context=2Ec2=2Epush_ifconfig_ip=
v6_local;
-        if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest)=
)
+        const struct in6_addr *dest =3D &c->c2=2Epush_ifconfig_ipv6_loca=
l;
+        if (multi_check_push_ifconfig_ipv6_extra_route(&c->options, des=
t))
         {
             /* On windows we do not install these routes, s=
o we also do not need to delete them */
-            net_route_v6_del(&m->t=
op=2Enet_ctx, dest, 128, NULL,
+            net_route_v6_del(net_ctx, dest,=
 128, NULL,
                              c->c1=2Etuntap->actual_name, 0, D=
CO_IROUTE_METRIC);
         }
 #endif
diff --git a/src/openvpn/dco=2Eh b/sr=
c/openvpn/dco=2Eh
index 4e5aad5=2E=2E7ef75fee 100644
--- a/src/openvpn/dco=
=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -220,10 +220,10 @@
 /**
  * Remove all ro=
utes added through the specified client
  *
- * @param m         the server=
 context
- * @param mi        the client instance for which routes have to =
be removed
+ * @param net_ctx   the iface networking context
+ * @param c  =
       the client context for which routes have to be removed
  */
-void dc=
o_delete_iroutes(struct multi_context *m, struct multi_instance *mi);
+void=
 dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c);
 =

 /**
  * Update traffic statistics for all peers
@@ -361,7 +361,7 @@
 }
 
=
 static inline void
-dco_delete_iroutes(struct multi_context *m, struct mul=
ti_instance *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const stru=
ct context *c)
 {
 }
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mul=
ti=2Ec
index 46ff1ba=2E=2Ea167071 100644
--- a/src/openvpn/multi=2Ec
+++ b/=
src/openvpn/multi=2Ec
@@ -479,7 +479,7 @@
     const struct iroute *ir;
   =
  const struct iroute_ipv6 *ir6;
 
-    dco_delete_iroutes(m, mi);
+    dco=
_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
 
     if (TUNNEL_TYPE(mi=
->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
@@ -1197,7 +1197,7 @@
=
         management_learn_addr(management, &mi->context=2Ec2=2Emda_context,=
 &addr, primary);
     }
 #endif
-    if (primary && multi_check_push_ifcon=
fig_extra_route(mi, addr=2Ev4=2Eaddr))
+    if (primary && multi_check_push=
_ifconfig_extra_route(&mi->context=2Eoptions, addr=2Ev4=2Eaddr))
     {
   =
      /* "primary" is the VPN ifconfig address of the peer */
         /* i=
f it does not fall into the network defined by ifconfig_local
@@ -1242,7 +1=
242,7 @@
         management_learn_addr(management, &mi->context=2Ec2=2Emda=
_context, &addr, primary);
     }
 #endif
-    if (primary && multi_check_p=
ush_ifconfig_ipv6_extra_route(mi, &addr=2Ev6=2Eaddr))
+    if (primary && m=
ulti_check_push_ifconfig_ipv6_extra_route(&mi->context=2Eoptions, &addr=2Ev=
6=2Eaddr))
     {
         /* "primary" is the VPN ifconfig address of the =
peer */
         /* if it does not fall into the network defined by ifconfi=
g_local
@@ -4438,9 +4438,8 @@
 }
 
 bool
-multi_check_push_ifconfig_extra_r=
oute(struct multi_instance *mi, in_addr_t dest)
+multi_check_push_ifconfig_=
extra_route(const struct options *o, in_addr_t dest)
 {
-    const struct o=
ptions *o =3D &mi->context=2Eoptions;
     in_addr_t local_addr, local_netm=
ask;
 
     if (!o->ifconfig_local || !o->ifconfig_remote_netmask)
@@ -4459=
,11 +4458,8 @@
 }
 
 bool
-multi_check_push_ifconfig_ipv6_extra_route(struc=
t multi_instance *mi,
-                                           struct in=
6_addr *dest)
+multi_check_push_ifconfig_ipv6_extra_route(const struct opti=
ons *o, const struct in6_addr *dest)
 {
-    const struct options *o =3D &m=
i->context=2Eoptions;
-
     if (!o->ifconfig_ipv6_local || !o->ifconfig_ip=
v6_netbits)
     {
         /* If we do not have a local address, we just r=
eturn false as
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
i=
ndex 6cb86c7=2E=2E18e57b8 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/open=
vpn/multi=2Eh
@@ -670,28 +670,27 @@
  * Determines if the ifconfig_push_loc=
al address falls into the range of the local
  * IP addresses of the VPN in=
terface (ifconfig_local with ifconfig_remote_netmask)
  *
- * @param mi    =
       The multi-instance to check this condition for
+ * @param o         =
   The instance wide options
  * @param dest         The destination IP add=
ress to check
  *
  * @return Returns true if ifconfig_push is outside that=
 range and requires an extra
  * route to be installed=2E
  */
 bool
-multi=
_check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest)=
;
+multi_check_push_ifconfig_extra_route(const struct options *o, in_addr_t=
 dest);
 
 /**
  * Determines if the ifconfig_ipv6_local address falls into=
 the range of the local
  * IP addresses of the VPN interface (ifconfig_loc=
al with ifconfig_remote_netmask)
  *
- * @param mi           The multi-inst=
ance to check this condition for
+ * @param o            The instance wide =
options
  * @param dest         The destination IPv6 address to check
  *
 =
 * @return Returns true if ifconfig_push is outside that range and requires=
 an extra
  * route to be installed=2E
  */
 bool
-multi_check_push_ifconfi=
g_ipv6_extra_route(struct multi_instance *mi,
-                            =
               struct in6_addr *dest);
+multi_check_push_ifconfig_ipv6_extr=
a_route(const struct options *o, const struct in6_addr *dest);
 
 /*
  * Ch=
eck for signals=2E

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1682?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
Gerrit-Change-Number: 1682
Gerr=
it-PatchSet: 4
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-At=
tention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <an=
tonio@mandelbit=2Ecom>

--ACdJIG1NF50=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>ordex <stro=
ng>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review+2 by pl=
aisthos</p><p>The change is no longer submittable: Code-Review and checks~C=
hecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">multi/dco: simplify=
 dco_delete_iroutes call chain<br><br>In order to be able to delete DCO iro=
utes from areas of the code<br>where the multi_context and the multi_instan=
ce objects may not be<br>available, let&#39;s simplify the call chain by pa=
ssing the smallest<br>scoped context required=2E<br><br>This is a refactori=
ng only and does not include any functional change=2E<br><br>This patch is =
required in preparation of fixing DCO iroutes removal<br>upon client exit, =
without waiting for the delayed exit routine<br>to kick in=2E<br><br>Change=
-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a<br>Signed-off-by: Antonio Qu=
artulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>=
M src/openvpn/dco=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh=
<br>4 files changed, 29 insertions(+), 37 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/=
1682/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span=
><br><span>index 8eae4bf=2E=2Eba1c85f 100644</span><br><span>--- a/src/open=
vpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -7=
41,26 +741,24 @@</span><br><span> }</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_delete_iroutes(st=
ruct multi_context *m, struct multi_instance *mi)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx=
, const struct context *c)</span><br><span> {</span><br><span> #if defined(=
TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!dco_enabled(&amp;m-&gt;top=
=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!dco_enabled(&amp;c-&gt;options))</span><br><span>     {</span><br><span> =
        return;</span><br><span>     }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ASSERT(TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct=
 context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Epush_ifconfig_defined)</span>=
<br><span>     {</span><br><span>         for (const struct iroute *ir =3D =
c-&gt;options=2Eiroutes; ir; ir =3D ir-&gt;next)</span><br><span>         {=
</span><br><span> #if defined(_WIN32)</span><br><span>             dco_win_=
del_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, htonl(ir-&gt;network), ir-&=
gt;netbits);</span><br><span> #else</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            net_route_v4_del(&amp;m-&gt;top=2Enet_ctx, &amp;i=
r-&gt;network, ir-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                             &amp;mi-&gt;context=2Ec2=2Epush_ifcon=
fig_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            net_route_v4_del(net_ctx, &amp;ir-=
&gt;network, ir-&gt;netbits,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                             &amp;c-&gt;c2=2Epush_ifconfig_local, =
c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span>                     =
         DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>      =
   }</span><br><span>@@ -768,27 +766,26 @@</span><br><span> #if !defined(_W=
IN32)</span><br><span>         /* Check if we added a host route as the ass=
igned client IP address was</span><br><span>          * not in the on link =
scope defined by --ifconfig */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        in_addr_t ifconfig_local =3D mi-&gt;context=2Ec2=2Epush_if=
config_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  in_addr_t ifconfig_local =3D c-&gt;c2=2Epush_ifconfig_local;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mult=
i_check_push_ifconfig_extra_route(mi, htonl(ifconfig_local)))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (multi_check_push_ifco=
nfig_extra_route(&amp;c-&gt;options, htonl(ifconfig_local)))</span><br><spa=
n>         {</span><br><span>             /* On windows we do not install t=
hese routes, so we also do not need to delete them */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            net_route_v4_del(&amp;m-&gt;top=
=2Enet_ctx, &amp;ifconfig_local,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                             32, NULL, c-&gt;c1=2Etuntap-&gt;act=
ual_name, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                    DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            net_route_v4_del(net_ctx, &amp;ifconfig_loc=
al, 32, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                       c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_MET=
RIC);</span><br><span>         }</span><br><span> #endif</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Epush_ifconfig_ipv=
6_defined)</span><br><span>     {</span><br><span>         for (const struc=
t iroute_ipv6 *ir6 =3D c-&gt;options=2Eiroutes_ipv6; ir6; ir6 =3D ir6-&gt;n=
ext)</span><br><span>         {</span><br><span> #if defined(_WIN32)</span>=
<br><span>             dco_win_del_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;d=
co, ir6-&gt;network, ir6-&gt;netbits);</span><br><span> #else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            net_route_v6_del(&amp;m=
-&gt;top=2Enet_ctx, &amp;ir6-&gt;network, ir6-&gt;netbits,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                             &amp;mi-&=
gt;context=2Ec2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_na=
me, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            n=
et_route_v6_del(net_ctx, &amp;ir6-&gt;network, ir6-&gt;netbits,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                             &a=
mp;c-&gt;c2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_name, =
0,</span><br><span>                              DCO_IROUTE_METRIC);</span>=
<br><span> #endif</span><br><span>         }</span><br><span>@@ -796,11 +79=
3,11 @@</span><br><span>         /* Checked if we added a host route as the=
 assigned client IP address was</span><br><span>          * outside the --i=
fconfig-ipv6 tun interface config */</span><br><span> #if !defined(_WIN32)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct in6_add=
r *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (multi_check_push_ifc=
onfig_ipv6_extra_route(mi, dest))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const struct in6_addr *dest =3D &amp;c-&gt;c2=2Epush_=
ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (multi_check_push_ifconfig_ipv6_extra_route(&amp;c-&gt;options,=
 dest))</span><br><span>         {</span><br><span>             /* On windo=
ws we do not install these routes, so we also do not need to delete them */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            net_route=
_v6_del(&amp;m-&gt;top=2Enet_ctx, dest, 128, NULL,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            net_route_v6_del(net_ctx, dest, =
128, NULL,</span><br><span>                              c-&gt;c1=2Etuntap-=
&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span>         }</span><b=
r><span> #endif</span><br><span>diff --git a/src/openvpn/dco=2Eh b/src/open=
vpn/dco=2Eh</span><br><span>index 4e5aad5=2E=2E7ef75fee 100644</span><br><s=
pan>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</sp=
an><br><span>@@ -220,10 +220,10 @@</span><br><span> /**</span><br><span>  *=
 Remove all routes added through the specified client</span><br><span>  *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param m         the=
 server context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @pa=
ram mi        the client instance for which routes have to be removed</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param net_ctx   the i=
face networking context</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param c         the client context for which routes have to be remo=
ved</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void dco_delete_iroutes(struct multi_context *m, struct multi_instance *=
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void dco_delete=
_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c);</span><br><s=
pan> </span><br><span> /**</span><br><span>  * Update traffic statistics fo=
r all peers</span><br><span>@@ -361,7 +361,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static inline void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-dco_delete_iroutes(struct multi_context *m, struct =
multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)</sp=
an><br><span> {</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index =
46ff1ba=2E=2Ea167071 100644</span><br><span>--- a/src/openvpn/multi=2Ec</sp=
an><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -479,7 +479,7 @=
@</span><br><span>     const struct iroute *ir;</span><br><span>     const =
struct iroute_ipv6 *ir6;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    dco_delete_iroutes(m, mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dco_delete_iroutes(&amp;m-&gt;top=2En=
et_ctx, &amp;mi-&gt;context);</span><br><span> </span><br><span>     if (TU=
NNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><spa=
n>     {</span><br><span>@@ -1197,7 +1197,7 @@</span><br><span>         man=
agement_learn_addr(management, &amp;mi-&gt;context=2Ec2=2Emda_context, &amp=
;addr, primary);</span><br><span>     }</span><br><span> #endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (primary &amp;&amp; multi_=
check_push_ifconfig_extra_route(mi, addr=2Ev4=2Eaddr))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (primary &amp;&amp; multi_check_p=
ush_ifconfig_extra_route(&amp;mi-&gt;context=2Eoptions, addr=2Ev4=2Eaddr))<=
/span><br><span>     {</span><br><span>         /* &quot;primary&quot; is t=
he VPN ifconfig address of the peer */</span><br><span>         /* if it do=
es not fall into the network defined by ifconfig_local</span><br><span>@@ -=
1242,7 +1242,7 @@</span><br><span>         management_learn_addr(management=
, &amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary);</span><br><s=
pan>     }</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (primary &amp;&amp; multi_check_push_ifconfig_ipv6_extr=
a_route(mi, &amp;addr=2Ev6=2Eaddr))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (primary &amp;&amp; multi_check_push_ifconfig_ipv6_e=
xtra_route(&amp;mi-&gt;context=2Eoptions, &amp;addr=2Ev6=2Eaddr))</span><br=
><span>     {</span><br><span>         /* &quot;primary&quot; is the VPN if=
config address of the peer */</span><br><span>         /* if it does not fa=
ll into the network defined by ifconfig_local</span><br><span>@@ -4438,9 +4=
438,8 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfig_ext=
ra_route(struct multi_instance *mi, in_addr_t dest)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_extra_route(con=
st struct options *o, in_addr_t dest)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const struct options *o =3D &amp;mi-=
&gt;context=2Eoptions;</span><br><span>     in_addr_t local_addr, local_net=
mask;</span><br><span> </span><br><span>     if (!o-&gt;ifconfig_local || !=
o-&gt;ifconfig_remote_netmask)</span><br><span>@@ -4459,11 +4458,8 @@</span=
><br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfig_ipv6_extra_route(=
struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                           struct in6_addr *dest)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfi=
g_ipv6_extra_route(const struct options *o, const struct in6_addr *dest)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onst struct options *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (!o-&gt;ifconf=
ig_ipv6_local || !o-&gt;ifconfig_ipv6_netbits)</span><br><span>     {</span=
><br><span>         /* If we do not have a local address, we just return fa=
lse as</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/mul=
ti=2Eh</span><br><span>index 6cb86c7=2E=2E18e57b8 100644</span><br><span>--=
- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span=
><br><span>@@ -670,28 +670,27 @@</span><br><span>  * Determines if the ifco=
nfig_push_local address falls into the range of the local</span><br><span> =
 * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_n=
etmask)</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param mi           The multi-instance to check this condition for=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param o        =
    The instance wide options</span><br><span>  * @param dest         The d=
estination IP address to check</span><br><span>  *</span><br><span>  * @ret=
urn Returns true if ifconfig_push is outside that range and requires an ext=
ra</span><br><span>  * route to be installed=2E</span><br><span>  */</span>=
<br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_=
check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_if=
config_extra_route(const struct options *o, in_addr_t dest);</span><br><spa=
n> </span><br><span> /**</span><br><span>  * Determines if the ifconfig_ipv=
6_local address falls into the range of the local</span><br><span>  * IP ad=
dresses of the VPN interface (ifconfig_local with ifconfig_remote_netmask)<=
/span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 @param mi           The multi-instance to check this condition for</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param o            The =
instance wide options</span><br><span>  * @param dest         The destinati=
on IPv6 address to check</span><br><span>  *</span><br><span>  * @return Re=
turns true if ifconfig_push is outside that range and requires an extra</sp=
an><br><span>  * route to be installed=2E</span><br><span>  */</span><br><s=
pan> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_=
push_ifconfig_ipv6_extra_route(struct multi_instance *mi,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                       =
    struct in6_addr *dest);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_check_push_ifconfig_ipv6_extra_route(const struct options *o,=
 const struct in6_addr *dest);</span><br><span> </span><br><span> /*</span>=
<br><span>  * Check for signals=2E</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3D=
email">change 1682</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1682?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1682 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner=
: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt=
;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--ACdJIG1NF50=--


--===============6929719667280152162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6929719667280152162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6929719667280152162==--

