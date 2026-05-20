Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947ECCD4F5E
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 20:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h0xXvGasQy9EfJUgfQWJph51CRLIwZrwU/fcXbGICBg=; b=Mas1XXfz69QQ0dFmMxw8LTTETN
	2UtmZ5fY0tz1S5mYVJf4dXjlSNSoLuJdqKvyYmkDnFKkeJS3q/hajIchTW/O0JZDrYsMhLePMO32n
	vNgK3fI+yoaYDBMnP7BUDi8kWjGVQ9wVOLILPfsHDbfmuOm+FRc0oZkHulKhDUvt1dyI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPnR6-0003nZ-G1;
	Wed, 20 May 2026 20:22:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPnQo-0003nA-NM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 20:22:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qNPg1ZrWOeXdpwCAQ5ZW26aA0WCC7rPSKI/crdHm6sk=; b=gmTKVQZm/lT7JfWicqNxw3QPxj
 JIAqhxLYbO3ZVepFhDETtVV1qnttIEp5G/T/wJ/q6cuLLgFI1UcjHD3U4389CbUowNOYYyzEvChSe
 ZtsC0hpNg2caeQX+xvLXLFEWaJ16ymyU/qASqy8+FmM2D+HePg8MQKLmq1NANtVnwM5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qNPg1ZrWOeXdpwCAQ5ZW26aA0WCC7rPSKI/crdHm6sk=; b=k
 XWHirb/iO1WYKicWI/bgLjVk+1FVauHUOcO93FLV8wvnnKsfsVAOtxoOsJWKaQPXL5eatpeAFjMX6
 2sxBO3/4cEXfNxf4t3zfl1pST3BBzIG3uUs1cytAMdELVq2nAkhUw38YbwPupBvG8aqGACbhpay2w
 mH3M4vu8WfWKc/ZM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPnQe-0005jj-Jb for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 20:22:11 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso39994335e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779308517; x=1779913317; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qNPg1ZrWOeXdpwCAQ5ZW26aA0WCC7rPSKI/crdHm6sk=;
 b=TPH9eJ9g9tQODqAtwMHkcovSemnWIvLJc0Wl8Atj5H6mkoAFpauuT3XPLbfGLXZ/1n
 Fu4iSz5W6dP78aSm6usaWalcCvksPD1C8XjLMHscsRgK+LJluaE0zN3FC1stqrOj94tD
 dwWoDextsjzd/Fo1oxqw5euGHiqOLYhKt4gppsM8plo3yB/smHv4DydiFggwxqOknRDK
 aMhst3vvCyW9eWk5jD6UicDNvYOJRLb+zIvJ6MW3n83zZGJhBoLRy97ismZ4EU5+WFW4
 M9UkRCvBMXtFkxgxCRh0g+X38JiIfkM3u3EciMvgHo0HfIeW734QB1GFWkoHZHIhULuH
 tfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779308517; x=1779913317;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qNPg1ZrWOeXdpwCAQ5ZW26aA0WCC7rPSKI/crdHm6sk=;
 b=LS9X4NKwBpXaWNKGGY3STA1f8soz2Dq7+OiEc4IQ1vj4HoVFdr7DoXNFhBEtg1n0Rw
 jdq/lReU/NtN9pdfwSXSjWAmFQlJYLxakev+pXqmDjygj5Yz2oewS/WZc9m/LNEaG3Pd
 FR2xg6FGpAMQEEMluAp8fTn05V2A/2lwAjNJKIwG2VK2zKADPaNqP3aJzo1Qx7MgOW0x
 3IZj/j+pFFsMDXnWKS6z2Vbpa7GkwchyTZASy/leX/M1QOpSe1k12Z2dDGlywpTx+GKY
 XeymowvI1z6BuGhyRMvJYEDNfacqkf3Ww39TMAy/KK08w/Yp0FfA+FTroBM90/SzDQy+
 pKwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nk6rSeGw4Aupf9TqJn7q3yYGMYEVk5OmehvLLk7ytChdZYbJEkd25dIfCL4rDW2XceU61rE65sAj01oJu@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxhfYZv9xKyFYjGewOe+QKCM5vTp2USnlIz+9Cxw+UiNzvB9urM
 380t87upX6O6JGwz+5BnBdtrjnxTIF/HRyfeIylP24cd/GfpqoPQ8j+vaUWUCNp8+tMHyjZY2vQ
 xuxQgroR9QKB7y53el+qCF8Fh+1JOHMwRD32Q0ZX1FuhOpUQKqW16eu23pe1VG90dZwEb
X-Gm-Gg: Acq92OEVyquRQIX0ulhjlRiG/hGE5/IIu3wbvOrA8BGh0IokqeQsz1jvSbS0MK+UM7L
 xchs6R8SJPKjugEDVhi79wSDIwj9voiaHhHrZBIjRS/fiF/ezvKNcSNNgea75od+N1qLkLY8fKK
 wtg/DVpG5FJZl6b6CLIwmBLPkii0XIV0S1XIj8oCGSvMnoa2J0PcrPXj18s2QbPrp2NZcosLhB1
 ifCjTytJ1UqHDa65pGKdAUzxkZtGovRi93rj7quZ9s+B/PwjaXMF59QrtorgQVamdLPiYo3mz/h
 FhEy+R683OACbLBw46gUiKqVSgpMB1rxqfPX47LfSwCpVYsjNW08kN+jGF8Byit0NxXnK64gDvy
 4RQ9+XfjzmfLI2IZTDPJKBzDkYchSR/aIK8dN8SgHOyPZZdT1hEAyQsmHWp8mgc18b3OHVvIPBa
 avm4jC08UxSFLXwwcSNLXE51N+KWF+OJvLVIBTM63KikmAqhM7St66FYF+YeIlrfVLRAqjTnElQ
 a2gaabFMqyyJ8qp8EG7hUgD7yK1GzE1l0EDIzJQz7mgYNFcxuxmw1noMDOxTRPq4AIjmP4T0zer
 tqLWUffrh1alhw==
X-Received: by 2002:a05:600c:8189:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48fe6323addmr365631265e9.21.1779308516907; 
 Wed, 20 May 2026 13:21:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035eec6casm59185e9.33.2026.05.20.13.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 13:21:56 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 20:21:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: 913767cf436841f1e605089e1b7c2ba5021a335c
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0ba6cd532cd6df92e5eac44d77613caab9ee8b0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPnQe-0005jj-Jb
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2403120709506199304=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2403120709506199304==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wQGUa+ahf2o="; charset=UTF-8

--wQGUa+ahf2o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail

to look at the new patch=
 set (#3)=2E


Change subject: multi/dco: simplify dco_delete_iroutes call =
chain
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi/d=
co: simplify dco_delete_iroutes call chain

In order to be able to delete D=
CO iroutes from areas of the code
where the multi_context and the multi_ins=
tance objects may not be
available, let's simplify the call chain by passin=
g the smallest
scoped context required=2E

This is a refactoring only and d=
oes not include any functional change=2E

This patch is required in prepara=
tion of fixing DCO iroutes removal
upon client exit, without waiting for th=
e delayed exit routine
to kick in=2E

Change-Id: Ib5832dc56eaeca1b170163967=
69b84bdf2c1513a
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
=
---
M src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/multi=2Ec
M s=
rc/openvpn/multi=2Eh
4 files changed, 29 insertions(+), 36 deletions(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1682/3=


diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f5b7081=2E=
=2E1e6638b 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -7=
24,26 +724,25 @@
 }
 
 void
-dco_delete_iroutes(struct multi_context *m, st=
ruct multi_instance *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, st=
ruct context *c)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) |=
| defined(_WIN32)
-    if (!dco_enabled(&m->top=2Eoptions))
+    if (!dco_e=
nabled(&c->options))
     {
         return;
     }
-    ASSERT(TUNNEL_TYPE=
(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN);
+    ASSERT(TUNNEL_TYPE(c=
->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
-    struct context *c =3D &mi->cont=
ext;
 
-    if (mi->context=2Ec2=2Epush_ifconfig_defined)
+    if (c->c2=2E=
push_ifconfig_defined)
     {
         for (const struct iroute *ir =3D c->=
options=2Eiroutes; ir; ir =3D ir->next)
         {
 #if defined(_WIN32)
   =
          dco_win_del_iroute_ipv4(&c->c1=2Etuntap->dco, htonl(ir->network),=
 ir->netbits);
 #else
-            net_route_v4_del(&m->top=2Enet_ctx, &ir-=
>network, ir->netbits,
-                             &mi->context=2Ec2=2Epu=
sh_ifconfig_local, c->c1=2Etuntap->actual_name, 0,
+            net_route_v=
4_del(net_ctx, &ir->network, ir->netbits,
+                             &c-=
>c2=2Epush_ifconfig_local, c->c1=2Etuntap->actual_name, 0,
                =
              DCO_IROUTE_METRIC);
 #endif
         }
@@ -751,27 +750,26 @@
=
 #if !defined(_WIN32)
         /* Check if we added a host route as the ass=
igned client IP address was
          * not in the on link scope defined by=
 --ifconfig */
-        in_addr_t ifconfig_local =3D mi->context=2Ec2=2Epus=
h_ifconfig_local;
+        in_addr_t ifconfig_local =3D c->c2=2Epush_ifconf=
ig_local;
 
-        if (multi_check_push_ifconfig_extra_route(mi, htonl(if=
config_local)))
+        if (multi_check_push_ifconfig_extra_route(&c->opti=
ons, htonl(ifconfig_local)))
         {
             /* On windows we do no=
t install these routes, so we also do not need to delete them */
-         =
   net_route_v4_del(&m->top=2Enet_ctx, &ifconfig_local,
-                  =
           32, NULL, c->c1=2Etuntap->actual_name, 0,
-                     =
        DCO_IROUTE_METRIC);
+            net_route_v4_del(net_ctx, &ifconfi=
g_local, 32, NULL,
+                             c->c1=2Etuntap->actual_nam=
e, 0, DCO_IROUTE_METRIC);
         }
 #endif
     }
 
-    if (mi->context=
=2Ec2=2Epush_ifconfig_ipv6_defined)
+    if (c->c2=2Epush_ifconfig_ipv6_def=
ined)
     {
         for (const struct iroute_ipv6 *ir6 =3D c->options=2Ei=
routes_ipv6; ir6; ir6 =3D ir6->next)
         {
 #if defined(_WIN32)
      =
       dco_win_del_iroute_ipv6(&c->c1=2Etuntap->dco, ir6->network, ir6->net=
bits);
 #else
-            net_route_v6_del(&m->top=2Enet_ctx, &ir6->networ=
k, ir6->netbits,
-                             &mi->context=2Ec2=2Epush_ifc=
onfig_ipv6_local, c->c1=2Etuntap->actual_name, 0,
+            net_route_v6=
_del(net_ctx, &ir6->network, ir6->netbits,
+                             &c=
->c2=2Epush_ifconfig_ipv6_local, c->c1=2Etuntap->actual_name, 0,
          =
                    DCO_IROUTE_METRIC);
 #endif
         }
@@ -779,11 +777,=
11 @@
         /* Checked if we added a host route as the assigned client I=
P address was
          * outside the --ifconfig-ipv6 tun interface config =
*/
 #if !defined(_WIN32)
-        struct in6_addr *dest =3D &mi->context=2E=
c2=2Epush_ifconfig_ipv6_local;
-        if (multi_check_push_ifconfig_ipv6_=
extra_route(mi, dest))
+        struct in6_addr *dest =3D &c->c2=2Epush_ifc=
onfig_ipv6_local;
+        if (multi_check_push_ifconfig_ipv6_extra_route(&=
c->options, dest))
         {
             /* On windows we do not install =
these routes, so we also do not need to delete them */
-            net_rou=
te_v6_del(&m->top=2Enet_ctx, dest, 128, NULL,
+            net_route_v6_del=
(net_ctx, dest, 128, NULL,
                              c->c1=2Etuntap->ac=
tual_name, 0, DCO_IROUTE_METRIC);
         }
 #endif
diff --git a/src/openv=
pn/dco=2Eh b/src/openvpn/dco=2Eh
index 4e5aad5=2E=2E733f59a1 100644
--- a/s=
rc/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -220,10 +220,10 @@
 /**
  *=
 Remove all routes added through the specified client
  *
- * @param m     =
    the server context
- * @param mi        the client instance for which r=
outes have to be removed
+ * @param net_ctx   the iface networking context
=
+ * @param c         the client context for which routes have to be removed=

  */
-void dco_delete_iroutes(struct multi_context *m, struct multi_instan=
ce *mi);
+void dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, struct contex=
t *c);
 
 /**
  * Update traffic statistics for all peers
@@ -361,7 +361,7 =
@@
 }
 
 static inline void
-dco_delete_iroutes(struct multi_context *m, st=
ruct multi_instance *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, st=
ruct context *c)
 {
 }
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec
index a957fdf=2E=2Ea72dcd1 100644
--- a/src/openvpn/multi=2Ec
+++ =
b/src/openvpn/multi=2Ec
@@ -479,7 +479,7 @@
     const struct iroute *ir;
 =
    const struct iroute_ipv6 *ir6;
 
-    dco_delete_iroutes(m, mi);
+    d=
co_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
 
     if (TUNNEL_TYPE(=
mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
@@ -1198,7 +1198,7 @=
@
         management_learn_addr(management, &mi->context=2Ec2=2Emda_contex=
t, &addr, primary);
     }
 #endif
-    if (primary && multi_check_push_ifc=
onfig_extra_route(mi, addr=2Ev4=2Eaddr))
+    if (primary && multi_check_pu=
sh_ifconfig_extra_route(&mi->context=2Eoptions, addr=2Ev4=2Eaddr))
     {
 =
        /* "primary" is the VPN ifconfig address of the peer */
         /*=
 if it does not fall into the network defined by ifconfig_local
@@ -1243,7 =
+1243,7 @@
         management_learn_addr(management, &mi->context=2Ec2=2Em=
da_context, &addr, primary);
     }
 #endif
-    if (primary && multi_check=
_push_ifconfig_ipv6_extra_route(mi, &addr=2Ev6=2Eaddr))
+    if (primary &&=
 multi_check_push_ifconfig_ipv6_extra_route(&mi->context=2Eoptions, &addr=
=2Ev6=2Eaddr))
     {
         /* "primary" is the VPN ifconfig address of =
the peer */
         /* if it does not fall into the network defined by ifc=
onfig_local
@@ -4373,9 +4373,8 @@
 }
 
 bool
-multi_check_push_ifconfig_ext=
ra_route(struct multi_instance *mi, in_addr_t dest)
+multi_check_push_ifcon=
fig_extra_route(struct options *o, in_addr_t dest)
 {
-    struct options *=
o =3D &mi->context=2Eoptions;
     in_addr_t local_addr, local_netmask;
 
 =
    if (!o->ifconfig_local || !o->ifconfig_remote_netmask)
@@ -4394,11 +439=
3,8 @@
 }
 
 bool
-multi_check_push_ifconfig_ipv6_extra_route(struct multi_=
instance *mi,
-                                           struct in6_addr *=
dest)
+multi_check_push_ifconfig_ipv6_extra_route(struct options *o, struct=
 in6_addr *dest)
 {
-    struct options *o =3D &mi->context=2Eoptions;
-
  =
   if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbits)
     {
       =
  /* If we do not have a local address, we just return false as
diff --git =
a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3ed08d4=2E=2Ef4459d2 =
100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -673,28 +=
673,27 @@
  * Determines if the ifconfig_push_local address falls into the =
range of the local
  * IP addresses of the VPN interface (ifconfig_local wi=
th ifconfig_remote_netmask)
  *
- * @param mi           The multi-instance =
to check this condition for
+ * @param o            The instance wide optio=
ns
  * @param dest         The destination IP address to check
  *
  * @ret=
urn Returns true if ifconfig_push is outside that range and requires an ext=
ra
  * route to be installed=2E
  */
 bool
-multi_check_push_ifconfig_extra=
_route(struct multi_instance *mi, in_addr_t dest);
+multi_check_push_ifconf=
ig_extra_route(struct options *o, in_addr_t dest);
 
 /**
  * Determines if=
 the ifconfig_ipv6_local address falls into the range of the local
  * IP a=
ddresses of the VPN interface (ifconfig_local with ifconfig_remote_netmask)=

  *
- * @param mi           The multi-instance to check this condition for=

+ * @param o            The instance wide options
  * @param dest         =
The destination IPv6 address to check
  *
  * @return Returns true if ifcon=
fig_push is outside that range and requires an extra
  * route to be instal=
led=2E
  */
 bool
-multi_check_push_ifconfig_ipv6_extra_route(struct multi_=
instance *mi,
-                                           struct in6_addr *=
dest);
+multi_check_push_ifconfig_ipv6_extra_route(struct options *o, struc=
t in6_addr *dest);
 
 /*
  * Check for signals=2E

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
=
Gerrit-Change-Number: 1682
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@=
mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>

--wQGUa+ahf2o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>ordex <strong>uplo=
aded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">multi/dco: simplify dco_delete_iroutes call chain<br><br>In order to b=
e able to delete DCO iroutes from areas of the code<br>where the multi_cont=
ext and the multi_instance objects may not be<br>available, let&#39;s simpl=
ify the call chain by passing the smallest<br>scoped context required=2E<br=
><br>This is a refactoring only and does not include any functional change=
=2E<br><br>This patch is required in preparation of fixing DCO iroutes remo=
val<br>upon client exit, without waiting for the delayed exit routine<br>to=
 kick in=2E<br><br>Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a<br>=
Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>=
M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/multi=2Ec<b=
r>M src/openvpn/multi=2Eh<br>4 files changed, 29 insertions(+), 36 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/82/1682/3</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/=
src/openvpn/dco=2Ec</span><br><span>index f5b7081=2E=2E1e6638b 100644</span=
><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=
=2Ec</span><br><span>@@ -724,26 +724,25 @@</span><br><span> }</span><br><sp=
an> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes(=
openvpn_net_ctx_t *net_ctx, struct context *c)</span><br><span> {</span><br=
><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WI=
N32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!dco_enab=
led(&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!dco_enabled(&amp;c-&gt;options))</span><br><span>     {=
</span><br><span>         return;</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(TUNNEL_TYPE(mi-&gt;context=2E=
c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TU=
N);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context=2Ec2=2Epu=
sh_ifconfig_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br=
><span>         for (const struct iroute *ir =3D c-&gt;options=2Eiroutes; i=
r; ir =3D ir-&gt;next)</span><br><span>         {</span><br><span> #if defi=
ned(_WIN32)</span><br><span>             dco_win_del_iroute_ipv4(&amp;c-&gt=
;c1=2Etuntap-&gt;dco, htonl(ir-&gt;network), ir-&gt;netbits);</span><br><sp=
an> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
net_route_v4_del(&amp;m-&gt;top=2Enet_ctx, &amp;ir-&gt;network, ir-&gt;netb=
its,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
            &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_local, c-&gt;c1=2Etunt=
ap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            net_route_v4_del(net_ctx, &amp;ir-&gt;network, ir-&gt;netbit=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
            &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;actu=
al_name, 0,</span><br><span>                              DCO_IROUTE_METRIC=
);</span><br><span> #endif</span><br><span>         }</span><br><span>@@ -7=
51,27 +750,26 @@</span><br><span> #if !defined(_WIN32)</span><br><span>    =
     /* Check if we added a host route as the assigned client IP address wa=
s</span><br><span>          * not in the on link scope defined by --ifconfi=
g */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in_addr_t=
 ifconfig_local =3D mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        in_addr_t ifconfig_local=
 =3D c-&gt;c2=2Epush_ifconfig_local;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (multi_check_push_ifconfig_extr=
a_route(mi, htonl(ifconfig_local)))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (multi_check_push_ifconfig_extra_route(&amp;c-&g=
t;options, htonl(ifconfig_local)))</span><br><span>         {</span><br><sp=
an>             /* On windows we do not install these routes, so we also do=
 not need to delete them */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            net_route_v4_del(&amp;m-&gt;top=2Enet_ctx, &amp;ifconfig_=
local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
              32, NULL, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                             DCO_IR=
OUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      net_route_v4_del(net_ctx, &amp;ifconfig_local, 32, NULL,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                             c-&=
gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span>    =
     }</span><br><span> #endif</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context=2E=
c2=2Epush_ifconfig_ipv6_defined)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (c-&gt;c2=2Epush_ifconfig_ipv6_defined)</span><br><span=
>     {</span><br><span>         for (const struct iroute_ipv6 *ir6 =3D c-&=
gt;options=2Eiroutes_ipv6; ir6; ir6 =3D ir6-&gt;next)</span><br><span>     =
    {</span><br><span> #if defined(_WIN32)</span><br><span>             dco=
_win_del_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, ir6-&gt;network, ir6-&=
gt;netbits);</span><br><span> #else</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            net_route_v6_del(&amp;m-&gt;top=2Enet_ctx, &amp;i=
r6-&gt;network, ir6-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                             &amp;mi-&gt;context=2Ec2=2Epush_ifc=
onfig_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            net_route_v6_del(net_ctx, &=
amp;ir6-&gt;network, ir6-&gt;netbits,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                             &amp;c-&gt;c2=2Epush_ifconfi=
g_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span>       =
                       DCO_IROUTE_METRIC);</span><br><span> #endif</span><b=
r><span>         }</span><br><span>@@ -779,11 +777,11 @@</span><br><span>  =
       /* Checked if we added a host route as the assigned client IP addres=
s was</span><br><span>          * outside the --ifconfig-ipv6 tun interface=
 config */</span><br><span> #if !defined(_WIN32)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        struct in6_addr *dest =3D &amp;mi-&gt;co=
ntext=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (multi_check_push_ifconfig_ipv6_extra_route(mi,=
 dest))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        stru=
ct in6_addr *dest =3D &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (multi_check_push_if=
config_ipv6_extra_route(&amp;c-&gt;options, dest))</span><br><span>        =
 {</span><br><span>             /* On windows we do not install these route=
s, so we also do not need to delete them */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            net_route_v6_del(&amp;m-&gt;top=2Enet_ctx=
, dest, 128, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           net_route_v6_del(net_ctx, dest, 128, NULL,</span><br><span>     =
                         c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_M=
ETRIC);</span><br><span>         }</span><br><span> #endif</span><br><span>=
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>inde=
x 4e5aad5=2E=2E733f59a1 100644</span><br><span>--- a/src/openvpn/dco=2Eh</s=
pan><br><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -220,10 +220,10 =
@@</span><br><span> /**</span><br><span>  * Remove all routes added through=
 the specified client</span><br><span>  *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * @param m         the server context</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @param mi        the client instanc=
e for which routes have to be removed</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param net_ctx   the iface networking context</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c         the clie=
nt context for which routes have to be removed</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void dco_delete_iroutes(struc=
t multi_context *m, struct multi_instance *mi);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void dco_delete_iroutes(openvpn_net_ctx_t *net_=
ctx, struct context *c);</span><br><span> </span><br><span> /**</span><br><=
span>  * Update traffic statistics for all peers</span><br><span>@@ -361,7 =
+361,7 @@</span><br><span> }</span><br><span> </span><br><span> static inli=
ne void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_delete_iro=
utes(struct multi_context *m, struct multi_instance *mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes(openvpn_net_ctx_t *=
net_ctx, struct context *c)</span><br><span> {</span><br><span> }</span><br=
><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec</span><br><span>index a957fdf=2E=2Ea72dcd1 100644</span><br><span>=
--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</sp=
an><br><span>@@ -479,7 +479,7 @@</span><br><span>     const struct iroute *=
ir;</span><br><span>     const struct iroute_ipv6 *ir6;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_delete_iroutes(=
m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_dele=
te_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span>=
 </span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D=
 DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1198,7 +1198,7 @@=
</span><br><span>         management_learn_addr(management, &amp;mi-&gt;con=
text=2Ec2=2Emda_context, &amp;addr, primary);</span><br><span>     }</span>=
<br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (primary &amp;&amp; multi_check_push_ifconfig_extra_route(mi, addr=2Ev4=
=2Eaddr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pr=
imary &amp;&amp; multi_check_push_ifconfig_extra_route(&amp;mi-&gt;context=
=2Eoptions, addr=2Ev4=2Eaddr))</span><br><span>     {</span><br><span>     =
    /* &quot;primary&quot; is the VPN ifconfig address of the peer */</span=
><br><span>         /* if it does not fall into the network defined by ifco=
nfig_local</span><br><span>@@ -1243,7 +1243,7 @@</span><br><span>         m=
anagement_learn_addr(management, &amp;mi-&gt;context=2Ec2=2Emda_context, &a=
mp;addr, primary);</span><br><span>     }</span><br><span> #endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (primary &amp;&amp; mult=
i_check_push_ifconfig_ipv6_extra_route(mi, &amp;addr=2Ev6=2Eaddr))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (primary &amp;&amp; m=
ulti_check_push_ifconfig_ipv6_extra_route(&amp;mi-&gt;context=2Eoptions, &a=
mp;addr=2Ev6=2Eaddr))</span><br><span>     {</span><br><span>         /* &q=
uot;primary&quot; is the VPN ifconfig address of the peer */</span><br><spa=
n>         /* if it does not fall into the network defined by ifconfig_loca=
l</span><br><span>@@ -4373,9 +4373,8 @@</span><br><span> }</span><br><span>=
 </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_=
t dest)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_=
push_ifconfig_extra_route(struct options *o, in_addr_t dest)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct option=
s *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span>     in_addr_t loca=
l_addr, local_netmask;</span><br><span> </span><br><span>     if (!o-&gt;if=
config_local || !o-&gt;ifconfig_remote_netmask)</span><br><span>@@ -4394,11=
 +4393,8 @@</span><br><span> }</span><br><span> </span><br><span> bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfig_=
ipv6_extra_route(struct multi_instance *mi,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                           struct in6=
_addr *dest)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_c=
heck_push_ifconfig_ipv6_extra_route(struct options *o, struct in6_addr *des=
t)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct options *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (!o-&gt;ifconfi=
g_ipv6_local || !o-&gt;ifconfig_ipv6_netbits)</span><br><span>     {</span>=
<br><span>         /* If we do not have a local address, we just return fal=
se as</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/mult=
i=2Eh</span><br><span>index 3ed08d4=2E=2Ef4459d2 100644</span><br><span>---=
 a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span>=
<br><span>@@ -673,28 +673,27 @@</span><br><span>  * Determines if the ifcon=
fig_push_local address falls into the range of the local</span><br><span>  =
* IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_ne=
tmask)</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @param mi           The multi-instance to check this condition for<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param o         =
   The instance wide options</span><br><span>  * @param dest         The de=
stination IP address to check</span><br><span>  *</span><br><span>  * @retu=
rn Returns true if ifconfig_push is outside that range and requires an extr=
a</span><br><span>  * route to be installed=2E</span><br><span>  */</span><=
br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_c=
heck_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifc=
onfig_extra_route(struct options *o, in_addr_t dest);</span><br><span> </sp=
an><br><span> /**</span><br><span>  * Determines if the ifconfig_ipv6_local=
 address falls into the range of the local</span><br><span>  * IP addresses=
 of the VPN interface (ifconfig_local with ifconfig_remote_netmask)</span><=
br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param=
 mi           The multi-instance to check this condition for</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param o            The instanc=
e wide options</span><br><span>  * @param dest         The destination IPv6=
 address to check</span><br><span>  *</span><br><span>  * @return Returns t=
rue if ifconfig_push is outside that range and requires an extra</span><br>=
<span>  * route to be installed=2E</span><br><span>  */</span><br><span> bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_push_if=
config_ipv6_extra_route(struct multi_instance *mi,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                           str=
uct in6_addr *dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+multi_check_push_ifconfig_ipv6_extra_route(struct options *o, struct in6_a=
ddr *dest);</span><br><span> </span><br><span> /*</span><br><span>  * Check=
 for signals=2E</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">change 1682=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
b5832dc56eaeca1b17016396769b84bdf2c1513a </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1682 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=


</body></html>
--wQGUa+ahf2o=--


--===============2403120709506199304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2403120709506199304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2403120709506199304==--

