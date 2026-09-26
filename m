Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ACFC98332
	for <openvpn-devel@archiver.kernel.org>; Sat, 26 Sep 2026 20:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MGlfwbnJdfR5on6Ska3dCVbRKTIbPz8EoBK5Sd0bGHA=; b=d07YMzMBDN+IW2mKJch46DahEo
	qi5kknuJh6M2e5fpQS5VNeS7oti4J/J3OOlUgoDh4/EIE5selILqb+tzItHodT2qWxGSZdXLsgUZO
	m9wWxmdMV5g/ow5VzrfACkN6v+Vw2PEA8/y4Y+bsWPpb5mQRVM9GJ32jeX+/IOP6gByU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xAYir-0006bb-2q;
	Sat, 26 Sep 2026 20:10:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xAYip-0006bT-Qi
 for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 20:10:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0DHFm5NEw/USPIgZ+b89EffGjFy7V+fQ/9e2/ZNTSvM=; b=gkf9BzhL2WTRI99iSgmZkbfOyD
 DTcnFGcyEjAusBzn4U+DcbCiBRn1rQqFKmFFnskXOBlj7qQbukwWBYAYYxDmBbnCnS+3nVBek2VxG
 8wAkLF0qHb167hzWL3JGUXxvh2WoPaHTVeU/KGmSPGvqKtsSJxcI9Fg4RRCSPAuk6nmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0DHFm5NEw/USPIgZ+b89EffGjFy7V+fQ/9e2/ZNTSvM=; b=R
 A3dzuJM5aG5of0JTwPqbEa24kqdP8gJVajFO+Fx+xf6kzsK7auxukBxRSPEPopvRNwBgfoICDYyCD
 YnY7+fpCHl08Ycntab0+od6v19aC+mt1kmMSMu29siy95XQUhmsd93Tl8JXOCzla7rJgjsDyxGFXi
 FAE0tyj2Jpb7qxgI=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xAYil-0006Am-I7 for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 20:10:09 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so1120321f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 26 Sep 2026 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790453401; x=1791058201; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0DHFm5NEw/USPIgZ+b89EffGjFy7V+fQ/9e2/ZNTSvM=;
 b=Lsh+AwfpYrmDT04elTj8l35BprqSTkSV9JZmCaPsxX28BFg4T5VKC8JYUqoiYLpWQ4
 d8ntfs7QG/X0eO3Z9MZeJJitnb3W+GTxjmQRW/XJU2ld8s3fCtfqAj0Q4Gb3fcLh+goF
 xtoslKD1L/iWJOMn8+LGUqoohNohhZBDHeNxa91SpWWNopB2DmwM1W3fMwG/3iNrcGZ5
 9BYCM+Jpi7ovP+ayU8duxpeJzscGPwRa/pVbJcUK5yZpbWLOzSWlYRdbe5s1QSMtGQQ4
 ce2Prmud+0y6i79l0B0v8UGC/5T9AMywj6D4EBnsnWzyTyQtZOqNTILa2ehtLljnV+WO
 Foew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790453401; x=1791058201;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0DHFm5NEw/USPIgZ+b89EffGjFy7V+fQ/9e2/ZNTSvM=;
 b=npHl2/6pF6JpD/6rO0l5L9RMwxay4oLooHe5oDHaXXa8UoBpWMIiBsGkD7fqGjKT52
 Aj+AJAXxq5IZRPQTqiOJeOQMg3nXj58JmEAHyMI+lc0XteTtdlxbRK+PjBGMfFJOvNlp
 sxxGabJcR4YioyXlbvK7lZ/VLLKIw2vMsR/nBjnhhRgwlBYtQHdP09ogGB2h6w3zW8Ti
 nwDjKTXFKyiPJwwo5wLvhzhOVnJdYGme9z9med72oFJBBZzuxZzmsnW20TG9qV1dygkS
 qHGqaQBpASc82bCx+6lzXQLIcpChX0N7XOOTOhFH3VqASNSNqwE/OVaNQDjdBHMerX3J
 Vp9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoDlbSPT7DMA9x6iTxV5SNa+Q8r88p+XGuXjeWI7rFqZSlhVD/BVXpDH/I38n9Q/uNHmSNdZL5e2eaH2Ll@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLX1HicnkDBeXJOCRzI29yT2YmILEKV1HryDxuNQF7cDQwBtrBU
 DO6wdWdMXxn4GcSW1XOAf45vSULFvz1t/AsJ9hjR/ESG/dJR9XKfN3Bh9UMLgnYpJ8ghKBgaK7f
 pst2vYAJRzhwZbJ42fIGnTFpxy9bOOaMXQbek4G4dVdtL/hNmLYbRuf3SPtd3G0aRLAOxuyzKv2
 9GtGaMpQ==
X-Gm-Gg: AYBFou0RHgrtJJ82RqbglTE81iX4BYXcHz5l7vtX7bD7/BkCjGGAE9L7oSkTpmlqFM5
 PhV2omN7aVPiRlH21vN9khDcm+ikWWhm0wOc5to8n8nm0OfajL/OPoTD9CPqdWMxYYQsexs/TGl
 R2XnhvH420Ki7dXvn1OtNu2gDr3rH/fZbUd/25kboP+U3niLCwNRdEM/9iBvUvqnjtm02Y5l8Dj
 LKnG5oioT14bzN7bD+pEFDQNtp743HdrLiCgBeT/N8xjsU+lCbmC02Get8l/MkIqWUHwPkiovIM
 MsaH9uCahJ0smYfISNvBOX40McA6GZaYqjV+q6O35pZBO+NX0EBF+MmbSaolsszE8ZPM8NiXeqh
 7ihQmR8g9afYMnE2Jp+Kl0oReFCs+U8C5ajNVmMmlqlv+b0b6eV/pe4KVd1t3VTQ5zYHaMmxIsl
 8N2ghH4w2REX7eEAZaTZfF2LVahx2I8Xd6thsXV1qYtd8pDULtrerZVWWeDLlZrivdpzaH0OtuB
 facB/nSGnCcxs57INPp96YtbtcfiAY6CrHjIy68poxm4EVNvNRPzA8jZmqFnkHz+M74t7AeH0wD
 ysj59wR1ZLUj/4utjYGH5QlwpqLw6rZ9d4x5d2bmiKKQn4+oEBrS5eA1X5NcWxc8S7RukyE=
X-Received: by 2002:a05:6000:22c7:b0:486:f42f:6860 with SMTP id
 ffacd0b85a97d-48871724305mr16958600f8f.56.1790453400589; 
 Sat, 26 Sep 2026 13:10:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a3625ccsm16934041f8f.22.2026.09.26.13.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 13:10:00 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 26 Sep 2026 20:09:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: 48939c9cd29b3bd857da10452aae854bc670c04f
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d63d922accfaf73b6c0ebe8c823277c9bc22cbf-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xAYil-0006Am-I7
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6019557905725046227=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6019557905725046227==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NtcLnstu5Ro="; charset=UTF-8

--NtcLnstu5Ro=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1682?usp=3Demail )

Change subject: multi/dco: simplify dco_delete_irou=
tes call chain
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


multi/dco: simplify dco_delete_iroutes call chain

In order to be able to=
 delete DCO iroutes from areas of the code
where the multi_context and the =
multi_instance objects may not be
available, let's simplify the call chain =
by passing the smallest
scoped context required=2E

This is a refactoring o=
nly and does not include any functional change=2E

This patch is required i=
n preparation of fixing DCO iroutes removal
upon client exit, without waiti=
ng for the delayed exit routine
to kick in=2E

Change-Id: Ib5832dc56eaeca1b=
17016396769b84bdf2c1513a
Signed-off-by: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682
Message-Id: <20260921082222=2E1=
7813-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg39358=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dco=2Ec
M src/openvpn/dco=
=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
4 files changed, 29 in=
sertions(+), 37 deletions(-)




diff --git a/src/openvpn/dco=2Ec b/src/ope=
nvpn/dco=2Ec
index 8eae4bf=2E=2Eba1c85f 100644
--- a/src/openvpn/dco=2Ec
++=
+ b/src/openvpn/dco=2Ec
@@ -741,26 +741,24 @@
 }
 
 void
-dco_delete_iroute=
s(struct multi_context *m, struct multi_instance *mi)
+dco_delete_iroutes(o=
penvpn_net_ctx_t *net_ctx, const struct context *c)
 {
 #if defined(TARGET_=
LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
-    if (!dco_enabled(=
&m->top=2Eoptions))
+    if (!dco_enabled(&c->options))
     {
         ret=
urn;
     }
-    ASSERT(TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_T=
YPE_TUN);
+    ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
-=
    const struct context *c =3D &mi->context;
-
-    if (mi->context=2Ec2=
=2Epush_ifconfig_defined)
+    if (c->c2=2Epush_ifconfig_defined)
     {
  =
       for (const struct iroute *ir =3D c->options=2Eiroutes; ir; ir =3D ir=
->next)
         {
 #if defined(_WIN32)
             dco_win_del_iroute_ipv=
4(&c->c1=2Etuntap->dco, htonl(ir->network), ir->netbits);
 #else
-         =
   net_route_v4_del(&m->top=2Enet_ctx, &ir->network, ir->netbits,
-        =
                     &mi->context=2Ec2=2Epush_ifconfig_local, c->c1=2Etunta=
p->actual_name, 0,
+            net_route_v4_del(net_ctx, &ir->network, ir-=
>netbits,
+                             &c->c2=2Epush_ifconfig_local, c->c1=
=2Etuntap->actual_name, 0,
                              DCO_IROUTE_METRIC)=
;
 #endif
         }
@@ -768,27 +766,26 @@
 #if !defined(_WIN32)
         /=
* Check if we added a host route as the assigned client IP address was
    =
      * not in the on link scope defined by --ifconfig */
-        in_addr_=
t ifconfig_local =3D mi->context=2Ec2=2Epush_ifconfig_local;
+        in_ad=
dr_t ifconfig_local =3D c->c2=2Epush_ifconfig_local;
 
-        if (multi_c=
heck_push_ifconfig_extra_route(mi, htonl(ifconfig_local)))
+        if (mul=
ti_check_push_ifconfig_extra_route(&c->options, htonl(ifconfig_local)))
   =
      {
             /* On windows we do not install these routes, so we al=
so do not need to delete them */
-            net_route_v4_del(&m->top=2Ene=
t_ctx, &ifconfig_local,
-                             32, NULL, c->c1=2Etun=
tap->actual_name, 0,
-                             DCO_IROUTE_METRIC);
+   =
         net_route_v4_del(net_ctx, &ifconfig_local, 32, NULL,
+            =
                 c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
      =
   }
 #endif
     }
 
-    if (mi->context=2Ec2=2Epush_ifconfig_ipv6_define=
d)
+    if (c->c2=2Epush_ifconfig_ipv6_defined)
     {
         for (const =
struct iroute_ipv6 *ir6 =3D c->options=2Eiroutes_ipv6; ir6; ir6 =3D ir6->ne=
xt)
         {
 #if defined(_WIN32)
             dco_win_del_iroute_ipv6(&c=
->c1=2Etuntap->dco, ir6->network, ir6->netbits);
 #else
-            net_ro=
ute_v6_del(&m->top=2Enet_ctx, &ir6->network, ir6->netbits,
-               =
              &mi->context=2Ec2=2Epush_ifconfig_ipv6_local, c->c1=2Etuntap-=
>actual_name, 0,
+            net_route_v6_del(net_ctx, &ir6->network, ir6-=
>netbits,
+                             &c->c2=2Epush_ifconfig_ipv6_local, =
c->c1=2Etuntap->actual_name, 0,
                              DCO_IROUTE_ME=
TRIC);
 #endif
         }
@@ -796,11 +793,11 @@
         /* Checked if we a=
dded a host route as the assigned client IP address was
          * outside=
 the --ifconfig-ipv6 tun interface config */
 #if !defined(_WIN32)
-       =
 struct in6_addr *dest =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
- =
       if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))
+        c=
onst struct in6_addr *dest =3D &c->c2=2Epush_ifconfig_ipv6_local;
+        =
if (multi_check_push_ifconfig_ipv6_extra_route(&c->options, dest))
        =
 {
             /* On windows we do not install these routes, so we also do=
 not need to delete them */
-            net_route_v6_del(&m->top=2Enet_ctx=
, dest, 128, NULL,
+            net_route_v6_del(net_ctx, dest, 128, NULL,
=
                              c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_ME=
TRIC);
         }
 #endif
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dc=
o=2Eh
index 4e5aad5=2E=2E7ef75fee 100644
--- a/src/openvpn/dco=2Eh
+++ b/sr=
c/openvpn/dco=2Eh
@@ -220,10 +220,10 @@
 /**
  * Remove all routes added th=
rough the specified client
  *
- * @param m         the server context
- * =
@param mi        the client instance for which routes have to be removed
+ =
* @param net_ctx   the iface networking context
+ * @param c         the cl=
ient context for which routes have to be removed
  */
-void dco_delete_irou=
tes(struct multi_context *m, struct multi_instance *mi);
+void dco_delete_i=
routes(openvpn_net_ctx_t *net_ctx, const struct context *c);
 
 /**
  * Upd=
ate traffic statistics for all peers
@@ -361,7 +361,7 @@
 }
 
 static inlin=
e void
-dco_delete_iroutes(struct multi_context *m, struct multi_instance *=
mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c=
)
 {
 }
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index =
a6fadf6=2E=2E52364f9 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/m=
ulti=2Ec
@@ -479,7 +479,7 @@
     const struct iroute *ir;
     const struc=
t iroute_ipv6 *ir6;
 
-    dco_delete_iroutes(m, mi);
+    dco_delete_irout=
es(&m->top=2Enet_ctx, &mi->context);
 
     if (TUNNEL_TYPE(mi->context=2Ec=
1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
@@ -1197,7 +1197,7 @@
         mana=
gement_learn_addr(&mi->context=2Ec2=2Emda_context, &addr, primary);
     }
=
 #endif
-    if (primary && multi_check_push_ifconfig_extra_route(mi, addr=
=2Ev4=2Eaddr))
+    if (primary && multi_check_push_ifconfig_extra_route(&m=
i->context=2Eoptions, addr=2Ev4=2Eaddr))
     {
         /* "primary" is th=
e VPN ifconfig address of the peer */
         /* if it does not fall into =
the network defined by ifconfig_local
@@ -1242,7 +1242,7 @@
         manage=
ment_learn_addr(&mi->context=2Ec2=2Emda_context, &addr, primary);
     }
 #=
endif
-    if (primary && multi_check_push_ifconfig_ipv6_extra_route(mi, &a=
ddr=2Ev6=2Eaddr))
+    if (primary && multi_check_push_ifconfig_ipv6_extra_=
route(&mi->context=2Eoptions, &addr=2Ev6=2Eaddr))
     {
         /* "prima=
ry" is the VPN ifconfig address of the peer */
         /* if it does not f=
all into the network defined by ifconfig_local
@@ -4439,9 +4439,8 @@
 }
 
 =
bool
-multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_a=
ddr_t dest)
+multi_check_push_ifconfig_extra_route(const struct options *o,=
 in_addr_t dest)
 {
-    const struct options *o =3D &mi->context=2Eoptions=
;
     in_addr_t local_addr, local_netmask;
 
     if (!o->ifconfig_local |=
| !o->ifconfig_remote_netmask)
@@ -4460,11 +4459,8 @@
 }
 
 bool
-multi_che=
ck_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-             =
                              struct in6_addr *dest)
+multi_check_push_ifco=
nfig_ipv6_extra_route(const struct options *o, const struct in6_addr *dest)=

 {
-    const struct options *o =3D &mi->context=2Eoptions;
-
     if (!o-=
>ifconfig_ipv6_local || !o->ifconfig_ipv6_netbits)
     {
         /* If we=
 do not have a local address, we just return false as
diff --git a/src/open=
vpn/multi=2Eh b/src/openvpn/multi=2Eh
index ac6cb78f=2E=2E7115b34 100644
--=
- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -668,28 +668,27 @@=

  * Determines if the ifconfig_push_local address falls into the range of =
the local
  * IP addresses of the VPN interface (ifconfig_local with ifconf=
ig_remote_netmask)
  *
- * @param mi           The multi-instance to check =
this condition for
+ * @param o            The instance wide options
  * @p=
aram dest         The destination IP address to check
  *
  * @return Retur=
ns true if ifconfig_push is outside that range and requires an extra
  * ro=
ute to be installed=2E
  */
 bool
-multi_check_push_ifconfig_extra_route(st=
ruct multi_instance *mi, in_addr_t dest);
+multi_check_push_ifconfig_extra_=
route(const struct options *o, in_addr_t dest);
 
 /**
  * Determines if th=
e ifconfig_ipv6_local address falls into the range of the local
  * IP addr=
esses of the VPN interface (ifconfig_local with ifconfig_remote_netmask)
  =
*
- * @param mi           The multi-instance to check this condition for
+ =
* @param o            The instance wide options
  * @param dest         The=
 destination IPv6 address to check
  *
  * @return Returns true if ifconfig=
_push is outside that range and requires an extra
  * route to be installed=
=2E
  */
 bool
-multi_check_push_ifconfig_ipv6_extra_route(struct multi_ins=
tance *mi,
-                                           struct in6_addr *des=
t);
+multi_check_push_ifconfig_ipv6_extra_route(const struct options *o, co=
nst struct in6_addr *dest);
 
 /*
  * Check for signals=2E

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c15=
13a
Gerrit-Change-Number: 1682
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--NtcLnstu5Ro=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1682?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">multi/dco: simplify dco_delete_iroutes cal=
l chain<br><br>In order to be able to delete DCO iroutes from areas of the =
code<br>where the multi_context and the multi_instance objects may not be<b=
r>available, let&#39;s simplify the call chain by passing the smallest<br>s=
coped context required=2E<br><br>This is a refactoring only and does not in=
clude any functional change=2E<br><br>This patch is required in preparation=
 of fixing DCO iroutes removal<br>upon client exit, without waiting for the=
 delayed exit routine<br>to kick in=2E<br><br>Change-Id: Ib5832dc56eaeca1b1=
7016396769b84bdf2c1513a<br>Signed-off-by: Antonio Quartulli &lt;antonio@man=
delbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682<br>Message-=
Id: &lt;20260921082222=2E17813-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39358=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/multi=
=2Ec<br>M src/openvpn/multi=2Eh<br>4 files changed, 29 insertions(+), 37 de=
letions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/=
dco=2Ec</span><br><span>index 8eae4bf=2E=2Eba1c85f 100644</span><br><span>-=
-- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><b=
r><span>@@ -741,26 +741,24 @@</span><br><span> }</span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_dele=
te_iroutes(struct multi_context *m, struct multi_instance *mi)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes(openvpn_net_c=
tx_t *net_ctx, const struct context *c)</span><br><span> {</span><br><span>=
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!dco_enabled(&am=
p;m-&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!dco_enabled(&amp;c-&gt;options))</span><br><span>     {</span>=
<br><span>         return;</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    ASSERT(TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etu=
ntap) =3D=3D DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st struct context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Epush_ifconfig_define=
d)</span><br><span>     {</span><br><span>         for (const struct iroute=
 *ir =3D c-&gt;options=2Eiroutes; ir; ir =3D ir-&gt;next)</span><br><span> =
        {</span><br><span> #if defined(_WIN32)</span><br><span>            =
 dco_win_del_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, htonl(ir-&gt;netwo=
rk), ir-&gt;netbits);</span><br><span> #else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            net_route_v4_del(&amp;m-&gt;top=2Enet_ct=
x, &amp;ir-&gt;network, ir-&gt;netbits,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                             &amp;mi-&gt;context=2Ec2=2Ep=
ush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            net_route_v4_del(net_ctx,=
 &amp;ir-&gt;network, ir-&gt;netbits,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                             &amp;c-&gt;c2=2Epush_ifconfi=
g_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span>            =
                  DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><sp=
an>         }</span><br><span>@@ -768,27 +766,26 @@</span><br><span> #if !d=
efined(_WIN32)</span><br><span>         /* Check if we added a host route a=
s the assigned client IP address was</span><br><span>          * not in the=
 on link scope defined by --ifconfig */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        in_addr_t ifconfig_local =3D mi-&gt;context=2Ec2=
=2Epush_ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        in_addr_t ifconfig_local =3D c-&gt;c2=2Epush_ifconfig_local;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (multi_check_push_ifconfig_extra_route(mi, htonl(ifconfig_local)))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (multi_check=
_push_ifconfig_extra_route(&amp;c-&gt;options, htonl(ifconfig_local)))</spa=
n><br><span>         {</span><br><span>             /* On windows we do not=
 install these routes, so we also do not need to delete them */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            net_route_v4_del(&amp=
;m-&gt;top=2Enet_ctx, &amp;ifconfig_local,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                             32, NULL, c-&gt;c1=2Etunt=
ap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                             DCO_IROUTE_METRIC);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            net_route_v4_del(net_ctx, &amp;if=
config_local, 32, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                             c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_=
IROUTE_METRIC);</span><br><span>         }</span><br><span> #endif</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Epush_if=
config_ipv6_defined)</span><br><span>     {</span><br><span>         for (c=
onst struct iroute_ipv6 *ir6 =3D c-&gt;options=2Eiroutes_ipv6; ir6; ir6 =3D=
 ir6-&gt;next)</span><br><span>         {</span><br><span> #if defined(_WIN=
32)</span><br><span>             dco_win_del_iroute_ipv6(&amp;c-&gt;c1=2Etu=
ntap-&gt;dco, ir6-&gt;network, ir6-&gt;netbits);</span><br><span> #else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            net_route_v6_=
del(&amp;m-&gt;top=2Enet_ctx, &amp;ir6-&gt;network, ir6-&gt;netbits,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
 &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&gt=
;actual_name, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         net_route_v6_del(net_ctx, &amp;ir6-&gt;network, ir6-&gt;netbits,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
        &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&gt;act=
ual_name, 0,</span><br><span>                              DCO_IROUTE_METRI=
C);</span><br><span> #endif</span><br><span>         }</span><br><span>@@ -=
796,11 +793,11 @@</span><br><span>         /* Checked if we added a host ro=
ute as the assigned client IP address was</span><br><span>          * outsi=
de the --ifconfig-ipv6 tun interface config */</span><br><span> #if !define=
d(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stru=
ct in6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (multi_chec=
k_push_ifconfig_ipv6_extra_route(mi, dest))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const struct in6_addr *dest =3D &amp;c-&gt;=
c2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (multi_check_push_ifconfig_ipv6_extra_route(&amp;c-&g=
t;options, dest))</span><br><span>         {</span><br><span>             /=
* On windows we do not install these routes, so we also do not need to dele=
te them */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 net_route_v6_del(&amp;m-&gt;top=2Enet_ctx, dest, 128, NULL,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            net_route_v6_del(net_c=
tx, dest, 128, NULL,</span><br><span>                              c-&gt;c1=
=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span>         =
}</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/dco=2Eh =
b/src/openvpn/dco=2Eh</span><br><span>index 4e5aad5=2E=2E7ef75fee 100644</s=
pan><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/d=
co=2Eh</span><br><span>@@ -220,10 +220,10 @@</span><br><span> /**</span><br=
><span>  * Remove all routes added through the specified client</span><br><=
span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param m  =
       the server context</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param mi        the client instance for which routes have to be rem=
oved</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param net_c=
tx   the iface networking context</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param c         the client context for which routes have =
to be removed</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void dco_delete_iroutes(struct multi_context *m, struct multi_=
instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c);</s=
pan><br><span> </span><br><span> /**</span><br><span>  * Update traffic sta=
tistics for all peers</span><br><span>@@ -361,7 +361,7 @@</span><br><span> =
}</span><br><span> </span><br><span> static inline void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-dco_delete_iroutes(struct multi_context *=
m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct conte=
xt *c)</span><br><span> {</span><br><span> }</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><s=
pan>index a6fadf6=2E=2E52364f9 100644</span><br><span>--- a/src/openvpn/mul=
ti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -479,=
7 +479,7 @@</span><br><span>     const struct iroute *ir;</span><br><span> =
    const struct iroute_ipv6 *ir6;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    dco_delete_iroutes(m, mi);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    dco_delete_iroutes(&amp;m-&g=
t;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span> </span><br><span>  =
   if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span=
><br><span>     {</span><br><span>@@ -1197,7 +1197,7 @@</span><br><span>   =
      management_learn_addr(&amp;mi-&gt;context=2Ec2=2Emda_context, &amp;ad=
dr, primary);</span><br><span>     }</span><br><span> #endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (primary &amp;&amp; multi_che=
ck_push_ifconfig_extra_route(mi, addr=2Ev4=2Eaddr))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (primary &amp;&amp; multi_check_pu=
sh_ifconfig_extra_route(&amp;mi-&gt;context=2Eoptions, addr=2Ev4=2Eaddr))</=
span><br><span>     {</span><br><span>         /* &quot;primary&quot; is th=
e VPN ifconfig address of the peer */</span><br><span>         /* if it doe=
s not fall into the network defined by ifconfig_local</span><br><span>@@ -1=
242,7 +1242,7 @@</span><br><span>         management_learn_addr(&amp;mi-&gt=
;context=2Ec2=2Emda_context, &amp;addr, primary);</span><br><span>     }</s=
pan><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (primary &amp;&amp; multi_check_push_ifconfig_ipv6_extra_route(mi, &=
amp;addr=2Ev6=2Eaddr))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (primary &amp;&amp; multi_check_push_ifconfig_ipv6_extra_route(&a=
mp;mi-&gt;context=2Eoptions, &amp;addr=2Ev6=2Eaddr))</span><br><span>     {=
</span><br><span>         /* &quot;primary&quot; is the VPN ifconfig addres=
s of the peer */</span><br><span>         /* if it does not fall into the n=
etwork defined by ifconfig_local</span><br><span>@@ -4439,9 +4439,8 @@</spa=
n><br><span> }</span><br><span> </span><br><span> bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfig_extra_route(stru=
ct multi_instance *mi, in_addr_t dest)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+multi_check_push_ifconfig_extra_route(const struct optio=
ns *o, in_addr_t dest)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const struct options *o =3D &amp;mi-&gt;context=2Eo=
ptions;</span><br><span>     in_addr_t local_addr, local_netmask;</span><br=
><span> </span><br><span>     if (!o-&gt;ifconfig_local || !o-&gt;ifconfig_=
remote_netmask)</span><br><span>@@ -4460,11 +4459,8 @@</span><br><span> }</=
span><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-multi_check_push_ifconfig_ipv6_extra_route(struct multi_in=
stance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                                 struct in6_addr *dest)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_ipv6_extra_ro=
ute(const struct options *o, const struct in6_addr *dest)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct opt=
ions *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>     if (!o-&gt;ifconfig_ipv6_local |=
| !o-&gt;ifconfig_ipv6_netbits)</span><br><span>     {</span><br><span>    =
     /* If we do not have a local address, we just return false as</span><b=
r><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><b=
r><span>index ac6cb78f=2E=2E7115b34 100644</span><br><span>--- a/src/openvp=
n/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ =
-668,28 +668,27 @@</span><br><span>  * Determines if the ifconfig_push_loca=
l address falls into the range of the local</span><br><span>  * IP addresse=
s of the VPN interface (ifconfig_local with ifconfig_remote_netmask)</span>=
<br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @para=
m mi           The multi-instance to check this condition for</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param o            The instan=
ce wide options</span><br><span>  * @param dest         The destination IP =
address to check</span><br><span>  *</span><br><span>  * @return Returns tr=
ue if ifconfig_push is outside that range and requires an extra</span><br><=
span>  * route to be installed=2E</span><br><span>  */</span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifc=
onfig_extra_route(struct multi_instance *mi, in_addr_t dest);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_extra_r=
oute(const struct options *o, in_addr_t dest);</span><br><span> </span><br>=
<span> /**</span><br><span>  * Determines if the ifconfig_ipv6_local addres=
s falls into the range of the local</span><br><span>  * IP addresses of the=
 VPN interface (ifconfig_local with ifconfig_remote_netmask)</span><br><spa=
n>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param mi    =
       The multi-instance to check this condition for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param o            The instance wide =
options</span><br><span>  * @param dest         The destination IPv6 addres=
s to check</span><br><span>  *</span><br><span>  * @return Returns true if =
ifconfig_push is outside that range and requires an extra</span><br><span> =
 * route to be installed=2E</span><br><span>  */</span><br><span> bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfig_=
ipv6_extra_route(struct multi_instance *mi,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                           struct in6=
_addr *dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_=
check_push_ifconfig_ipv6_extra_route(const struct options *o, const struct =
in6_addr *dest);</span><br><span> </span><br><span> /*</span><br><span>  * =
Check for signals=2E</span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">change 1682</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerri=
t-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: maste=
r </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5832dc56eaeca1b17=
016396769b84bdf2c1513a </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1682 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--NtcLnstu5Ro=--


--===============6019557905725046227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6019557905725046227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6019557905725046227==--

