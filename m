Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F63CD4F54
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=FoEtNQUpMy3B6yesf2Er80zr/nWhYiPYs0Y2KggKKnw=; b=XswtmrAUpzsL0w
	bp/l5cn2dPqhJKoCJohG0MVqmarVJblJqzKSG5T6JRwq6dOejIKyPAOGoY95MDlcXoYDKyH/VMiTJ
	rIeP0xVW6m2XKgG6GovkirTy8jM68aDCVETg0hUlRCEyBJwZap7YLCd2YN9ZCVU6kD842YTt9haDE
	K0I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPcDi-0006v8-Lc;
	Wed, 20 May 2026 08:24:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPcDe-0006ul-7H
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 08:23:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wLgd6+QMuLdGIhFQJdiGZtNCkWaADCqNBrZd/A7qIBE=; b=iBAIAeVlkzj+QydZfJmPMm2J9g
 WkHsq/hZReyy2F7iLbl1QvYnjU14oDo2AA9RYFmAJKFzhNdbLch/nDSmCDj33DwxDGFogfzLqaAhL
 +E32NiMYmJHTrx/uiMcIHrtOiL75+7N9/bn84VO2fuHg5FyEEivhlnSDkF6N3KJUzNG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wLgd6+QMuLdGIhFQJdiGZtNCkWaADCqNBrZd/A7qIBE=; b=c
 3DA3JCnLzb3kgSrSfntMcXJYifWae5bA5XTeFSfcws6mdspQiSyI297WAN7bgDkMDrSJ3hrPc5dkX
 Lv2QAnyR/5CLDl0Y7wZki4hNyTM/xqz4WLwPlnoJecA5F1Lf0R8o1ISu9YHdZqJwhj/Nd+7PHgv1A
 RoH6T9TJIXMk7Hw8=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPcDZ-0004cf-On for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 08:23:58 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45562c41ec7so2777321f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779265423; x=1779870223; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLgd6+QMuLdGIhFQJdiGZtNCkWaADCqNBrZd/A7qIBE=;
 b=VixJdviM1q6W6lh/9CfH6VgjWU828Qm1I/JQtCBTFtEwapDm+fEo+f7u94/UwGoTm7
 YvOhqaIhwHCusQ1hjRkbaoCa0kQby+3QiFt76QwuKi07jmmOxIG7mVTNJJTbxyyBmvei
 RSKyRDhEaWGVVLQRlqCvEwtMxIR8bwkB36+7U+tj5g0VeclCVdoSbCb2Kz5hpaolOB3N
 fy49nX8J7mqNIASFtnINndUVunLJaR9f3tbQ8nUpNnb2SpON9arqeYPhgnHtFNKc4XHc
 7JFppv8TXii8PSm8xA9yukQHr8xk7uKQRufIHMYX6GA2sWl59pDPQ9pYHI4aXGkzACmO
 Jp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779265423; x=1779870223;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wLgd6+QMuLdGIhFQJdiGZtNCkWaADCqNBrZd/A7qIBE=;
 b=eHMxX96hj+t2Hcaf0sKNI6wAYPDN8zlRYFGW12D1UJwcgM2oRRjKElHoTvXyBRNzgX
 YvWaSTZJELV4kc2Ym0BPoVI62m+rWuzXRY5kdL0zwWwZVPKE7OZh1VdesOuT8AiIwb7p
 KQQF6bo0D3gt5oyJjsYG7nHZVN6iGO1C9T6xpvfMyQlL+nCt561GGTATb67mACutRvSI
 SFFfJcTyKKGvohxAeCJ6Xs0Ig3PIGYyALj4GfBS+mfOsX99q/DONm2E+QwhNnU3s9exl
 t03cNC0KoxWR+XQScWvKqLNcFlq8U1HMn9hd/BC2zgBftIGb//7yFa+xy6lJMSGDeeR0
 VsJA==
X-Gm-Message-State: AOJu0YzGUCj0AErMwx0aInU5+BEd2rH8itx/1VPDUwUMaWfbY7WGrCJt
 EFrWgqPhbTcCInICkrwhQts3lajZ0fN/RcAMM1sxq44/DAsI/k0Xn7iSBj25pT19X6nEYHYAmPQ
 rtE7mfimgjth8mrkyg7m8kqlIemiY/sb+PuITl6L7nk4GQXWx898+zND16LkTP0qZJxZnPbLsYM
 dZM1su2g==
X-Gm-Gg: Acq92OE/dN304SMHiGbaVrGRvjPDY6OzYS+mjztL26BgU/q3fxxHS22f0Tx8U5+zglL
 Bqc4kkURyldfCETqIuqBDduT80MseZENXKITRBQ8kGe4QQ5bmhEh6fCdERjkCcXkQTmNxPPDer8
 jBEAuYxTH1vcHNvqmhs5JMLSQnu2m5K1jM1E4yBWmdHU580FugHVBkW91lDWlgf1bFf1e5Wb6qS
 /hsMAJJ/V5NlMgt8a9yZhU6j7MA38QozIEy4x2YZ/fk3fwcUD8hB+VMAnHWvebr9ehv3nGCT7NE
 PAFiLxcd142WgsT9Y9ZUtQpMRtG01oTVDo6IYCIz0xrgKTjgcmNc330nhVbveihGyyE1fTNlKyD
 BV/AGM86AiPn1hoBgS/X/PhEPRpFgxuv16LNIH2U06I8VITIPnNb3f+px1lGWTmhEiHZE4ch6bd
 aNpziesdSqIsS51j73dfaXLRrBdSoNk31DAJfwhbV6H1NRIVT50zCPthUwZHCPfuk+JcnCpsA82
 s+Mv0eaHUpdST7Yq82kikS0gu5BQ6hdlb3l3/GGWqCNRUSc/9XBuZxKdp2uB+TfCJLD14LsEZA3
 yDh7Gk9TyuO/DeHcMq2TtzvC
X-Received: by 2002:a5d:584c:0:b0:43f:dc54:9493 with SMTP id
 ffacd0b85a97d-45e5c5e3276mr35037373f8f.21.1779265422566; 
 Wed, 20 May 2026 01:23:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39806sm51060778f8f.9.2026.05.20.01.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 01:23:41 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 08:23:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: f5af8cfaeaee954ba4a81d3dd3e571e030bf2d00
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d76b24d207acc9451de8ae94c117e426046751d5-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPcDZ-0004cf-On
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
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1768665038511324891=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1768665038511324891==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EUs/xIFBjv0="; charset=UTF-8

--EUs/xIFBjv0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1682?usp=3Demail

to review the following change=2E


Chang=
e subject: multi/dco: simplify dco_delete_iroutes call chain
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi/dco: simplify dco_d=
elete_iroutes call chain

In order to be able to delete DCO iroutes from ar=
eas of the code
where the multi_context and the multi_instance objects may =
not be
available, let's simplify the call chain by passing the smallest
sco=
ped context required=2E

This is a refactoring only and does not include an=
y functional change=2E

This patch is required in preparation of fixing DCO=
 iroutes removal
upon client exit, without waiting for the delayed exit rou=
tine
to kick in=2E

Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
Si=
gned-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/=
dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/multi=
=2Eh
4 files changed, 30 insertions(+), 32 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1682/1

diff --git a/=
src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f5b7081=2E=2Efae0548 100644=

--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -724,26 +724,25 @@
=
 }
 
 void
-dco_delete_iroutes(struct multi_context *m, struct multi_instan=
ce *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, struct context *c)
=
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)=

-    if (!dco_enabled(&m->top=2Eoptions))
+    if (!dco_enabled(&c->option=
s))
     {
         return;
     }
-    ASSERT(TUNNEL_TYPE(mi->context=2Ec1=
=2Etuntap) =3D=3D DEV_TYPE_TUN);
+    ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =
=3D=3D DEV_TYPE_TUN);
 
-    struct context *c =3D &mi->context;
 
-    if =
(mi->context=2Ec2=2Epush_ifconfig_defined)
+    if (c->c2=2Epush_ifconfig_d=
efined)
     {
         for (const struct iroute *ir =3D c->options=2Eirout=
es; ir; ir =3D ir->next)
         {
 #if defined(_WIN32)
             dco_w=
in_del_iroute_ipv4(&c->c1=2Etuntap->dco, htonl(ir->network), ir->netbits);
=
 #else
-            net_route_v4_del(&m->top=2Enet_ctx, &ir->network, ir->n=
etbits,
-                             &mi->context=2Ec2=2Epush_ifconfig_loc=
al, c->c1=2Etuntap->actual_name, 0,
+            net_route_v4_del(net_ctx, =
&ir->network, ir->netbits,
+                             &c->c2=2Epush_ifco=
nfig_local, c->c1=2Etuntap->actual_name, 0,
                              D=
CO_IROUTE_METRIC);
 #endif
         }
@@ -751,27 +750,26 @@
 #if !defined(_=
WIN32)
         /* Check if we added a host route as the assigned client IP=
 address was
          * not in the on link scope defined by --ifconfig */
=
-        in_addr_t ifconfig_local =3D mi->context=2Ec2=2Epush_ifconfig_loca=
l;
+        in_addr_t ifconfig_local =3D c->c2=2Epush_ifconfig_local;
 
-  =
      if (multi_check_push_ifconfig_extra_route(mi, htonl(ifconfig_local)))=

+        if (multi_check_push_ifconfig_extra_route(c, htonl(ifconfig_local=
)))
         {
             /* On windows we do not install these routes, s=
o we also do not need to delete them */
-            net_route_v4_del(&m->t=
op=2Enet_ctx, &ifconfig_local,
-                             32, NULL, c->c=
1=2Etuntap->actual_name, 0,
-                             DCO_IROUTE_METRIC=
);
+            net_route_v4_del(net_ctx, &ifconfig_local, 32, NULL,
+     =
                        c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);=

         }
 #endif
     }
 
-    if (mi->context=2Ec2=2Epush_ifconfig_ipv6=
_defined)
+    if (c->c2=2Epush_ifconfig_ipv6_defined)
     {
         for =
(const struct iroute_ipv6 *ir6 =3D c->options=2Eiroutes_ipv6; ir6; ir6 =3D =
ir6->next)
         {
 #if defined(_WIN32)
             dco_win_del_iroute_=
ipv6(&c->c1=2Etuntap->dco, ir6->network, ir6->netbits);
 #else
-           =
 net_route_v6_del(&m->top=2Enet_ctx, &ir6->network, ir6->netbits,
-        =
                     &mi->context=2Ec2=2Epush_ifconfig_ipv6_local, c->c1=2E=
tuntap->actual_name, 0,
+            net_route_v6_del(net_ctx, &ir6->networ=
k, ir6->netbits,
+                             &c->c2=2Epush_ifconfig_ipv6_=
local, c->c1=2Etuntap->actual_name, 0,
                              DCO_IR=
OUTE_METRIC);
 #endif
         }
@@ -779,11 +777,11 @@
         /* Checked =
if we added a host route as the assigned client IP address was
          * =
outside the --ifconfig-ipv6 tun interface config */
 #if !defined(_WIN32)
-=
        struct in6_addr *dest =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_lo=
cal;
-        if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))
+  =
      struct in6_addr *dest =3D &c->c2=2Epush_ifconfig_ipv6_local;
+       =
 if (multi_check_push_ifconfig_ipv6_extra_route(c, dest))
         {
      =
       /* On windows we do not install these routes, so we also do not need=
 to delete them */
-            net_route_v6_del(&m->top=2Enet_ctx, dest, 1=
28, NULL,
+            net_route_v6_del(net_ctx, dest, 128, NULL,
         =
                     c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
  =
       }
 #endif
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
ind=
ex 4e5aad5=2E=2Ef331130 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/=
dco=2Eh
@@ -220,10 +220,10 @@
 /**
  * Remove all routes added through the =
specified client
  *
- * @param m         the server context
- * @param mi =
       the client instance for which routes have to be removed
+ * @param n=
et_ctx   the iface networking context
+ * @param c         the client conte=
xt for which routes have to be removed
  */
-void dco_delete_iroutes(struct=
 multi_context *m, struct multi_instance *mi);
+void dco_delete_iroutes(ope=
nvpn_net_ctx_t *net_ctx, struct context *c);
 
 /**
  * Update traffic stat=
istics for all peers
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index a957fdf=2E=2Ee94a7d5 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -479,7 +479,7 @@
     const struct iroute *ir;
     =
const struct iroute_ipv6 *ir6;
 
-    dco_delete_iroutes(m, mi);
+    dco_d=
elete_iroutes(&m->top=2Enet_ctx, &mi->context);
 
     if (TUNNEL_TYPE(mi->=
context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
@@ -1198,7 +1198,7 @@
  =
       management_learn_addr(management, &mi->context=2Ec2=2Emda_context, &=
addr, primary);
     }
 #endif
-    if (primary && multi_check_push_ifconfi=
g_extra_route(mi, addr=2Ev4=2Eaddr))
+    if (primary && multi_check_push_i=
fconfig_extra_route(&mi->context, addr=2Ev4=2Eaddr))
     {
         /* "pr=
imary" is the VPN ifconfig address of the peer */
         /* if it does no=
t fall into the network defined by ifconfig_local
@@ -1243,7 +1243,7 @@
   =
      management_learn_addr(management, &mi->context=2Ec2=2Emda_context, &a=
ddr, primary);
     }
 #endif
-    if (primary && multi_check_push_ifconfig=
_ipv6_extra_route(mi, &addr=2Ev6=2Eaddr))
+    if (primary && multi_check_p=
ush_ifconfig_ipv6_extra_route(&mi->context, &addr=2Ev6=2Eaddr))
     {
    =
     /* "primary" is the VPN ifconfig address of the peer */
         /* if=
 it does not fall into the network defined by ifconfig_local
@@ -4373,9 +43=
73,9 @@
 }
 
 bool
-multi_check_push_ifconfig_extra_route(struct multi_inst=
ance *mi, in_addr_t dest)
+multi_check_push_ifconfig_extra_route(struct con=
text *c, in_addr_t dest)
 {
-    struct options *o =3D &mi->context=2Eoptio=
ns;
+    struct options *o =3D &c->options;
     in_addr_t local_addr, loca=
l_netmask;
 
     if (!o->ifconfig_local || !o->ifconfig_remote_netmask)
@@=
 -4394,10 +4394,10 @@
 }
 
 bool
-multi_check_push_ifconfig_ipv6_extra_rout=
e(struct multi_instance *mi,
+multi_check_push_ifconfig_ipv6_extra_route(st=
ruct context *c,
                                            struct in6_add=
r *dest)
 {
-    struct options *o =3D &mi->context=2Eoptions;
+    struct =
options *o =3D &c->options;
 
     if (!o->ifconfig_ipv6_local || !o->ifcon=
fig_ipv6_netbits)
     {
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/m=
ulti=2Eh
index 3ed08d4=2E=2E35ad13f 100644
--- a/src/openvpn/multi=2Eh
+++ =
b/src/openvpn/multi=2Eh
@@ -673,27 +673,27 @@
  * Determines if the ifconfi=
g_push_local address falls into the range of the local
  * IP addresses of =
the VPN interface (ifconfig_local with ifconfig_remote_netmask)
  *
- * @pa=
ram mi           The multi-instance to check this condition for
+ * @param =
c            The multi-instance context to check this condition for
  * @pa=
ram dest         The destination IP address to check
  *
  * @return Return=
s true if ifconfig_push is outside that range and requires an extra
  * rou=
te to be installed=2E
  */
 bool
-multi_check_push_ifconfig_extra_route(str=
uct multi_instance *mi, in_addr_t dest);
+multi_check_push_ifconfig_extra_r=
oute(struct context *c, in_addr_t dest);
 
 /**
  * Determines if the ifcon=
fig_ipv6_local address falls into the range of the local
  * IP addresses o=
f the VPN interface (ifconfig_local with ifconfig_remote_netmask)
  *
- * @=
param mi           The multi-instance to check this condition for
+ * @para=
m c            The multi-instance context to check this condition for
  * @=
param dest         The destination IPv6 address to check
  *
  * @return Re=
turns true if ifconfig_push is outside that range and requires an extra
  *=
 route to be installed=2E
  */
 bool
-multi_check_push_ifconfig_ipv6_extra_=
route(struct multi_instance *mi,
+multi_check_push_ifconfig_ipv6_extra_rout=
e(struct context *c,
                                            struct in6=
_addr *dest);
 
 /*

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1682?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Ib5832dc56eaeca1b17016396769b84bdf2c1513a
Gerrit-Change-Number: 1682
Gerri=
t-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>

--EUs/xIFBjv0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1682?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mu=
lti/dco: simplify dco_delete_iroutes call chain<br><br>In order to be able =
to delete DCO iroutes from areas of the code<br>where the multi_context and=
 the multi_instance objects may not be<br>available, let&#39;s simplify the=
 call chain by passing the smallest<br>scoped context required=2E<br><br>Th=
is is a refactoring only and does not include any functional change=2E<br><=
br>This patch is required in preparation of fixing DCO iroutes removal<br>u=
pon client exit, without waiting for the delayed exit routine<br>to kick in=
=2E<br><br>Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a<br>Signed-o=
ff-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/op=
envpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/multi=2Ec<br>M src/=
openvpn/multi=2Eh<br>4 files changed, 30 insertions(+), 32 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/82/1682/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/open=
vpn/dco=2Ec</span><br><span>index f5b7081=2E=2Efae0548 100644</span><br><sp=
an>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</spa=
n><br><span>@@ -724,26 +724,25 @@</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_=
delete_iroutes(struct multi_context *m, struct multi_instance *mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes(openvpn_n=
et_ctx_t *net_ctx, struct context *c)</span><br><span> {</span><br><span> #=
if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!dco_enabled(&amp;=
m-&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!dco_enabled(&amp;c-&gt;options))</span><br><span>     {</span><b=
r><span>         return;</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etunt=
ap) =3D=3D DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context=2Ec2=2Epush_ifconf=
ig_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span>  =
       for (const struct iroute *ir =3D c-&gt;options=2Eiroutes; ir; ir =3D=
 ir-&gt;next)</span><br><span>         {</span><br><span> #if defined(_WIN3=
2)</span><br><span>             dco_win_del_iroute_ipv4(&amp;c-&gt;c1=2Etun=
tap-&gt;dco, htonl(ir-&gt;network), ir-&gt;netbits);</span><br><span> #else=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            net_route=
_v4_del(&amp;m-&gt;top=2Enet_ctx, &amp;ir-&gt;network, ir-&gt;netbits,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
   &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;ac=
tual_name, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      net_route_v4_del(net_ctx, &amp;ir-&gt;network, ir-&gt;netbits,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
   &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;actual_name, =
0,</span><br><span>                              DCO_IROUTE_METRIC);</span>=
<br><span> #endif</span><br><span>         }</span><br><span>@@ -751,27 +75=
0,26 @@</span><br><span> #if !defined(_WIN32)</span><br><span>         /* C=
heck if we added a host route as the assigned client IP address was</span><=
br><span>          * not in the on link scope defined by --ifconfig */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        in_addr_t ifconfig=
_local =3D mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        in_addr_t ifconfig_local =3D c-&g=
t;c2=2Epush_ifconfig_local;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (multi_check_push_ifconfig_extra_route(m=
i, htonl(ifconfig_local)))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (multi_check_push_ifconfig_extra_route(c, htonl(ifconfig_=
local)))</span><br><span>         {</span><br><span>             /* On wind=
ows we do not install these routes, so we also do not need to delete them *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            net_rout=
e_v4_del(&amp;m-&gt;top=2Enet_ctx, &amp;ifconfig_local,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                             32, NULL, c-=
&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                             DCO_IROUTE_METRIC);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            net_route_v4_del(net=
_ctx, &amp;ifconfig_local, 32, NULL,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                             c-&gt;c1=2Etuntap-&gt;actual_=
name, 0, DCO_IROUTE_METRIC);</span><br><span>         }</span><br><span> #e=
ndif</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_de=
fined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt=
;c2=2Epush_ifconfig_ipv6_defined)</span><br><span>     {</span><br><span>  =
       for (const struct iroute_ipv6 *ir6 =3D c-&gt;options=2Eiroutes_ipv6;=
 ir6; ir6 =3D ir6-&gt;next)</span><br><span>         {</span><br><span> #if=
 defined(_WIN32)</span><br><span>             dco_win_del_iroute_ipv6(&amp;=
c-&gt;c1=2Etuntap-&gt;dco, ir6-&gt;network, ir6-&gt;netbits);</span><br><sp=
an> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
net_route_v6_del(&amp;m-&gt;top=2Enet_ctx, &amp;ir6-&gt;network, ir6-&gt;ne=
tbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
              &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local, c-&gt;c1=
=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            net_route_v6_del(net_ctx, &amp;ir6-&gt;network, ir6-&=
gt;netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                     &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Et=
untap-&gt;actual_name, 0,</span><br><span>                              DCO=
_IROUTE_METRIC);</span><br><span> #endif</span><br><span>         }</span><=
br><span>@@ -779,11 +777,11 @@</span><br><span>         /* Checked if we ad=
ded a host route as the assigned client IP address was</span><br><span>    =
      * outside the --ifconfig-ipv6 tun interface config */</span><br><span=
> #if !defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        struct in6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig=
_ipv6_local;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct in6_addr *dest =3D &amp=
;c-&gt;c2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (multi_check_push_ifconfig_ipv6_extra_route(c,=
 dest))</span><br><span>         {</span><br><span>             /* On windo=
ws we do not install these routes, so we also do not need to delete them */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            net_route=
_v6_del(&amp;m-&gt;top=2Enet_ctx, dest, 128, NULL,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            net_route_v6_del(net_ctx, dest, =
128, NULL,</span><br><span>                              c-&gt;c1=2Etuntap-=
&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span>         }</span><b=
r><span> #endif</span><br><span>diff --git a/src/openvpn/dco=2Eh b/src/open=
vpn/dco=2Eh</span><br><span>index 4e5aad5=2E=2Ef331130 100644</span><br><sp=
an>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</spa=
n><br><span>@@ -220,10 +220,10 @@</span><br><span> /**</span><br><span>  * =
Remove all routes added through the specified client</span><br><span>  *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param m         the =
server context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @par=
am mi        the client instance for which routes have to be removed</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param net_ctx   the if=
ace networking context</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param c         the client context for which routes have to be remov=
ed</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void dco_delete_iroutes(struct multi_context *m, struct multi_instance *m=
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void dco_delete_=
iroutes(openvpn_net_ctx_t *net_ctx, struct context *c);</span><br><span> </=
span><br><span> /**</span><br><span>  * Update traffic statistics for all p=
eers</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index a957fdf=2E=2Ee94a7d5 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -479,7 +479,7 @@</span><br><span>     const struct iroute *ir;<=
/span><br><span>     const struct iroute_ipv6 *ir6;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_delete_iroutes(m, m=
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_delete_i=
routes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span> </s=
pan><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV=
_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1198,7 +1198,7 @@</sp=
an><br><span>         management_learn_addr(management, &amp;mi-&gt;context=
=2Ec2=2Emda_context, &amp;addr, primary);</span><br><span>     }</span><br>=
<span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
primary &amp;&amp; multi_check_push_ifconfig_extra_route(mi, addr=2Ev4=2Ead=
dr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (primary=
 &amp;&amp; multi_check_push_ifconfig_extra_route(&amp;mi-&gt;context, addr=
=2Ev4=2Eaddr))</span><br><span>     {</span><br><span>         /* &quot;pri=
mary&quot; is the VPN ifconfig address of the peer */</span><br><span>     =
    /* if it does not fall into the network defined by ifconfig_local</span=
><br><span>@@ -1243,7 +1243,7 @@</span><br><span>         management_learn_=
addr(management, &amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary=
);</span><br><span>     }</span><br><span> #endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (primary &amp;&amp; multi_check_push_ifc=
onfig_ipv6_extra_route(mi, &amp;addr=2Ev6=2Eaddr))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (primary &amp;&amp; multi_check_push_=
ifconfig_ipv6_extra_route(&amp;mi-&gt;context, &amp;addr=2Ev6=2Eaddr))</spa=
n><br><span>     {</span><br><span>         /* &quot;primary&quot; is the V=
PN ifconfig address of the peer */</span><br><span>         /* if it does n=
ot fall into the network defined by ifconfig_local</span><br><span>@@ -4373=
,9 +4373,9 @@</span><br><span> }</span><br><span> </span><br><span> bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfi=
g_extra_route(struct multi_instance *mi, in_addr_t dest)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_extra_route(=
struct context *c, in_addr_t dest)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct options *o =3D &amp;mi-&gt;conte=
xt=2Eoptions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct options *o =3D &amp;c-&gt;options;</span><br><span>     in_addr_t loca=
l_addr, local_netmask;</span><br><span> </span><br><span>     if (!o-&gt;if=
config_local || !o-&gt;ifconfig_remote_netmask)</span><br><span>@@ -4394,10=
 +4394,10 @@</span><br><span> }</span><br><span> </span><br><span> bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfig=
_ipv6_extra_route(struct multi_instance *mi,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_ipv6_extra_route(struct =
context *c,</span><br><span>                                            str=
uct in6_addr *dest)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct options *o =3D &amp;mi-&gt;context=2Eoptions;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct options *o=
 =3D &amp;c-&gt;options;</span><br><span> </span><br><span>     if (!o-&gt;=
ifconfig_ipv6_local || !o-&gt;ifconfig_ipv6_netbits)</span><br><span>     {=
</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh=
</span><br><span>index 3ed08d4=2E=2E35ad13f 100644</span><br><span>--- a/sr=
c/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><=
span>@@ -673,27 +673,27 @@</span><br><span>  * Determines if the ifconfig_p=
ush_local address falls into the range of the local</span><br><span>  * IP =
addresses of the VPN interface (ifconfig_local with ifconfig_remote_netmask=
)</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param mi           The multi-instance to check this condition for</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c            Th=
e multi-instance context to check this condition for</span><br><span>  * @p=
aram dest         The destination IP address to check</span><br><span>  *</=
span><br><span>  * @return Returns true if ifconfig_push is outside that ra=
nge and requires an extra</span><br><span>  * route to be installed=2E</spa=
n><br><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-multi_check_push_ifconfig_extra_route(struct multi_instanc=
e *mi, in_addr_t dest);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+multi_check_push_ifconfig_extra_route(struct context *c, in_addr_t dest=
);</span><br><span> </span><br><span> /**</span><br><span>  * Determines if=
 the ifconfig_ipv6_local address falls into the range of the local</span><b=
r><span>  * IP addresses of the VPN interface (ifconfig_local with ifconfig=
_remote_netmask)</span><br><span>  *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @param mi           The multi-instance to check this cond=
ition for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
c            The multi-instance context to check this condition for</span><=
br><span>  * @param dest         The destination IPv6 address to check</spa=
n><br><span>  *</span><br><span>  * @return Returns true if ifconfig_push i=
s outside that range and requires an extra</span><br><span>  * route to be =
installed=2E</span><br><span>  */</span><br><span> bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfig_ipv6_extra_rout=
e(struct multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+multi_check_push_ifconfig_ipv6_extra_route(struct context *c,</spa=
n><br><span>                                            struct in6_addr *de=
st);</span><br><span> </span><br><span> /*</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/168=
2?usp=3Demail">change 1682</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1682?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1682 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--EUs/xIFBjv0=--


--===============1768665038511324891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1768665038511324891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1768665038511324891==--

