Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530E5CD4F3C
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZta/ssNa2BW4gMClBOVQS17q0tleJE8yu1udivCw4U=; b=YDWvp4q6FoHi6YoQqEe9dCWSVZ
	9RaoTDp09igq0HVbWmEtII9xRHvEuTevWYPZJko6xhJXPD7Ibm0odFEgw0YF0xle+CpyuHnkbyUtB
	miZmjaeMRxJtlTNvwOyyPYbY4jTcN0mc6ETH7QE6Q+4yuyeN87OpugIMi+F0Ua+BmqHQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPchP-0000eR-JQ;
	Wed, 20 May 2026 08:54:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPchN-0000eI-P1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 08:54:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+YV3+jbSjLA4+uBs9zo65l7wAWISOFRsxKsSuvCsod8=; b=Y8hbHA90002/sKxYFYwNQrqzB/
 zbw6Nk1qHiWtIs5U4WWPUirPjhdJs1lnxUxbMVUfcDNGjHJrGTxodvpGl0hJ8WAjRTX0c5T+V46ql
 heNKdt7GBQrsZwWvX1TtYRgsdZyn+PDmSCtNTbhsJTPl+l/IFJplq5HkK7MMMCclG8fM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+YV3+jbSjLA4+uBs9zo65l7wAWISOFRsxKsSuvCsod8=; b=X
 3xSQ+lX4LO7aKFVm4usll4dbpQF0S7xP1Bw8aWJHBg/eEoKpVYc/GwZg09DWibaj2Llt9Sj+N5RQZ
 xuHKaEtB1YyAgtq0OjH5NUQuINxaHZuj14o0NG/3aNIE8pVaGk5zcFMzR6FHd9dNFIuTIXvllWTtf
 OGY2cg2DTPEciiy0=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPchJ-0000Ue-VN for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 08:54:42 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso4048293f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779267272; x=1779872072; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+YV3+jbSjLA4+uBs9zo65l7wAWISOFRsxKsSuvCsod8=;
 b=dOm5iRiNyP1BaV0b4lNwtyhRzTzlVFmExRqwDWAm4Ibcx5fUsyoLGiY1XK2OaVQC6/
 BfeJPEq2PKgEmLBRqGSSrWIkSB9czFslQ67+oVnjTomzxfd1X1sfytuKFM++tysvPW/7
 Qb9WErVFKiZqDicYbzjapbdausGvjYC9ay2+FjKxoKTXy8uO8UA6oI3A87XetBQwVaxO
 zGLbhFugtswliy0D148hdQ9WovuOR2whKNCDctO3D7G0OHER450312WmPUSqIrGvyaha
 IJy15jH2/5jOxhv+yhPz1MN7K8FPwP9nOwJM15QpCpUjEdD7KU1gh9Trdjf1MKQhBBe5
 rJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779267272; x=1779872072;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+YV3+jbSjLA4+uBs9zo65l7wAWISOFRsxKsSuvCsod8=;
 b=aIJQqadtHkMmaNRdC/RzaMpeCvplbr48XH4ss/KLzLCgMaklnExoU9wgP/+ZHTqGYY
 2DAt5+bAju/BpLFp87eUpNwXwyh4fO406C95bcNVuCAss3YG2pX2tEGEoO4hNdPz8Y8H
 chZnus3wpZUE4iucERnBoHrET2Y1a8EcLNaR7g9PdQhWBkyrdwDc4D/AXZn3VvEQt59y
 OVeXiBU98B4zMnDeQiTd3DVN0ir+GRP5BqqZx/LmYx59ACfQFvm5oCngguOlqq1BSYMr
 6SxVN/Fa7RAEmxfOYwrhIs3G+jtbvn1YdXPLLjI2Z75Q0H7PvTjFyf0yXHWxrnoaZNUv
 /saw==
X-Gm-Message-State: AOJu0YyzFh7N2U86/gwvkGrbFSlC9jiNU6jzGMBTCC6k4m5UnCU30eZx
 qQyJ+mEHjMlJ/nLpSwzSkvE6XG1z4BVQ2kc1gV+dQopUKETcGveFCUrw0PlG1yq4gvAXitrE2kb
 GfGSizR4fgbULm4yuo8OkJ8GiaXdSgSTc+j9KWmJq3S97be/gIakOIiverawuXr1IpycL
X-Gm-Gg: Acq92OFYBKxBxyU6Vyo2ZFRn1589gi058uu0N7qwxTw6B4fJLnVSw/JH1XYf+LLwhsg
 426JIIZO90NG8ZvwM7EjNvQa4wfsTx/oc5arrwf7in/DSyXYApgF1hw3zeA8pHcPgJcT8gyehXb
 Q6ZdD8Iq61I61GbU//zZ1yPbtVqckw9rHYdQH+ith5yuWqRmhUPpYRCeW1kLsIVU/8x78/dAzld
 H4cgrA3aTl4SOOijAeR6/fAYkt9TlhqrbVMIeDAfAnYtgOXl6avL2Iff81DxAPu3rJQ75//h3HL
 Fp9exXJ3dYvLLYMu3Vh+07SXk5jxoblYj1VtfrtC1BCcCbEyKB/JpHugb7YWr/3awIbWqfTVROB
 lx+tanBYmu1MTpm5M7ODudaaL9n/8FCsQxsM3d3gABLYVJv4nr/ry4+jW2kOQrsYWYfbjGMIUY6
 q9brejK0e4wHW5X0Ncy3cabBDWwXYkyEs4av+Tglq5QLMBbTFImGsH6pn+YZ49ZpbYpIuUErPaD
 n+zZFO9TUE5XHaXJKV9pdGc3Cp8ixy4UbOmiZLm4STYPm02Rhtq8DJrNe66kEam4Z1YQxn9lbsG
 hUaDJyxcvbMJG2xkEWn14LK2
X-Received: by 2002:a5d:64a2:0:b0:45e:655e:4e02 with SMTP id
 ffacd0b85a97d-45e655e4e6cmr23117811f8f.32.1779267271660; 
 Wed, 20 May 2026 01:54:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed30110sm56604897f8f.13.2026.05.20.01.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 01:54:31 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 08:54:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: c5f02a68b6036a8c30e5e81704b1ffa417b26d83
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45198610a3bcfe051cc1f5f03b5e9b354515d5e1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPchJ-0000Ue-VN
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
Content-Type: multipart/mixed; boundary="===============2577411600270195033=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2577411600270195033==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d8Qua8zjo/Q="; charset=UTF-8

--d8Qua8zjo/Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1682?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: multi/dco: simplify dco_delete_iroutes call chain
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi/dco: simplify=
 dco_delete_iroutes call chain

In order to be able to delete DCO iroutes f=
rom areas of the code
where the multi_context and the multi_instance object=
s may not be
available, let's simplify the call chain by passing the smalle=
st
scoped context required=2E

This is a refactoring only and does not incl=
ude any functional change=2E

This patch is required in preparation of fixi=
ng DCO iroutes removal
upon client exit, without waiting for the delayed ex=
it routine
to kick in=2E

Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c15=
13a
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/op=
envpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/m=
ulti=2Eh
4 files changed, 31 insertions(+), 33 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1682/2

diff --git=
 a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f5b7081=2E=2Efae0548 100=
644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -724,26 +724,25 =
@@
 }
 
 void
-dco_delete_iroutes(struct multi_context *m, struct multi_ins=
tance *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, struct context *=
c)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN=
32)
-    if (!dco_enabled(&m->top=2Eoptions))
+    if (!dco_enabled(&c->opt=
ions))
     {
         return;
     }
-    ASSERT(TUNNEL_TYPE(mi->context=
=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN);
+    ASSERT(TUNNEL_TYPE(c->c1=2Etunta=
p) =3D=3D DEV_TYPE_TUN);
 
-    struct context *c =3D &mi->context;
 
-    =
if (mi->context=2Ec2=2Epush_ifconfig_defined)
+    if (c->c2=2Epush_ifconfi=
g_defined)
     {
         for (const struct iroute *ir =3D c->options=2Eir=
outes; ir; ir =3D ir->next)
         {
 #if defined(_WIN32)
             dc=
o_win_del_iroute_ipv4(&c->c1=2Etuntap->dco, htonl(ir->network), ir->netbits=
);
 #else
-            net_route_v4_del(&m->top=2Enet_ctx, &ir->network, ir=
->netbits,
-                             &mi->context=2Ec2=2Epush_ifconfig_=
local, c->c1=2Etuntap->actual_name, 0,
+            net_route_v4_del(net_ct=
x, &ir->network, ir->netbits,
+                             &c->c2=2Epush_i=
fconfig_local, c->c1=2Etuntap->actual_name, 0,
                            =
  DCO_IROUTE_METRIC);
 #endif
         }
@@ -751,27 +750,26 @@
 #if !define=
d(_WIN32)
         /* Check if we added a host route as the assigned client=
 IP address was
          * not in the on link scope defined by --ifconfig =
*/
-        in_addr_t ifconfig_local =3D mi->context=2Ec2=2Epush_ifconfig_l=
ocal;
+        in_addr_t ifconfig_local =3D c->c2=2Epush_ifconfig_local;
 
=
-        if (multi_check_push_ifconfig_extra_route(mi, htonl(ifconfig_local=
)))
+        if (multi_check_push_ifconfig_extra_route(c, htonl(ifconfig_lo=
cal)))
         {
             /* On windows we do not install these routes=
, so we also do not need to delete them */
-            net_route_v4_del(&m=
->top=2Enet_ctx, &ifconfig_local,
-                             32, NULL, c=
->c1=2Etuntap->actual_name, 0,
-                             DCO_IROUTE_MET=
RIC);
+            net_route_v4_del(net_ctx, &ifconfig_local, 32, NULL,
+  =
                           c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRI=
C);
         }
 #endif
     }
 
-    if (mi->context=2Ec2=2Epush_ifconfig_i=
pv6_defined)
+    if (c->c2=2Epush_ifconfig_ipv6_defined)
     {
         f=
or (const struct iroute_ipv6 *ir6 =3D c->options=2Eiroutes_ipv6; ir6; ir6 =
=3D ir6->next)
         {
 #if defined(_WIN32)
             dco_win_del_iro=
ute_ipv6(&c->c1=2Etuntap->dco, ir6->network, ir6->netbits);
 #else
-       =
     net_route_v6_del(&m->top=2Enet_ctx, &ir6->network, ir6->netbits,
-    =
                         &mi->context=2Ec2=2Epush_ifconfig_ipv6_local, c->c=
1=2Etuntap->actual_name, 0,
+            net_route_v6_del(net_ctx, &ir6->ne=
twork, ir6->netbits,
+                             &c->c2=2Epush_ifconfig_i=
pv6_local, c->c1=2Etuntap->actual_name, 0,
                              DC=
O_IROUTE_METRIC);
 #endif
         }
@@ -779,11 +777,11 @@
         /* Chec=
ked if we added a host route as the assigned client IP address was
        =
  * outside the --ifconfig-ipv6 tun interface config */
 #if !defined(_WIN3=
2)
-        struct in6_addr *dest =3D &mi->context=2Ec2=2Epush_ifconfig_ipv=
6_local;
-        if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))=

+        struct in6_addr *dest =3D &c->c2=2Epush_ifconfig_ipv6_local;
+   =
     if (multi_check_push_ifconfig_ipv6_extra_route(c, dest))
         {
  =
           /* On windows we do not install these routes, so we also do not =
need to delete them */
-            net_route_v6_del(&m->top=2Enet_ctx, des=
t, 128, NULL,
+            net_route_v6_del(net_ctx, dest, 128, NULL,
     =
                         c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC)=
;
         }
 #endif
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh=

index 4e5aad5=2E=2E733f59a1 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/ope=
nvpn/dco=2Eh
@@ -220,10 +220,10 @@
 /**
  * Remove all routes added through=
 the specified client
  *
- * @param m         the server context
- * @para=
m mi        the client instance for which routes have to be removed
+ * @pa=
ram net_ctx   the iface networking context
+ * @param c         the client =
context for which routes have to be removed
  */
-void dco_delete_iroutes(s=
truct multi_context *m, struct multi_instance *mi);
+void dco_delete_iroute=
s(openvpn_net_ctx_t *net_ctx, struct context *c);
 
 /**
  * Update traffic=
 statistics for all peers
@@ -361,7 +361,7 @@
 }
 
 static inline void
-dco=
_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+dco_de=
lete_iroutes(openvpn_net_ctx_t *net_ctx, struct context *c)
 {
 }
 
diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a957fdf=2E=2Ee94a=
7d5 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -479,=
7 +479,7 @@
     const struct iroute *ir;
     const struct iroute_ipv6 *ir=
6;
 
-    dco_delete_iroutes(m, mi);
+    dco_delete_iroutes(&m->top=2Enet_=
ctx, &mi->context);
 
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TUN)
     {
@@ -1198,7 +1198,7 @@
         management_learn_ad=
dr(management, &mi->context=2Ec2=2Emda_context, &addr, primary);
     }
 #e=
ndif
-    if (primary && multi_check_push_ifconfig_extra_route(mi, addr=2Ev=
4=2Eaddr))
+    if (primary && multi_check_push_ifconfig_extra_route(&mi->c=
ontext, addr=2Ev4=2Eaddr))
     {
         /* "primary" is the VPN ifconfig=
 address of the peer */
         /* if it does not fall into the network de=
fined by ifconfig_local
@@ -1243,7 +1243,7 @@
         management_learn_add=
r(management, &mi->context=2Ec2=2Emda_context, &addr, primary);
     }
 #en=
dif
-    if (primary && multi_check_push_ifconfig_ipv6_extra_route(mi, &add=
r=2Ev6=2Eaddr))
+    if (primary && multi_check_push_ifconfig_ipv6_extra_ro=
ute(&mi->context, &addr=2Ev6=2Eaddr))
     {
         /* "primary" is the V=
PN ifconfig address of the peer */
         /* if it does not fall into the=
 network defined by ifconfig_local
@@ -4373,9 +4373,9 @@
 }
 
 bool
-multi_=
check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest)
=
+multi_check_push_ifconfig_extra_route(struct context *c, in_addr_t dest)
 =
{
-    struct options *o =3D &mi->context=2Eoptions;
+    struct options *o=
 =3D &c->options;
     in_addr_t local_addr, local_netmask;
 
     if (!o->=
ifconfig_local || !o->ifconfig_remote_netmask)
@@ -4394,10 +4394,10 @@
 }
 =

 bool
-multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *m=
i,
+multi_check_push_ifconfig_ipv6_extra_route(struct context *c,
         =
                                   struct in6_addr *dest)
 {
-    struct op=
tions *o =3D &mi->context=2Eoptions;
+    struct options *o =3D &c->options=
;
 
     if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbits)
     {
d=
iff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3ed08d4=2E=
=2E35ad13f 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@=
@ -673,27 +673,27 @@
  * Determines if the ifconfig_push_local address fall=
s into the range of the local
  * IP addresses of the VPN interface (ifconf=
ig_local with ifconfig_remote_netmask)
  *
- * @param mi           The mult=
i-instance to check this condition for
+ * @param c            The multi-in=
stance context to check this condition for
  * @param dest         The dest=
ination IP address to check
  *
  * @return Returns true if ifconfig_push i=
s outside that range and requires an extra
  * route to be installed=2E
  *=
/
 bool
-multi_check_push_ifconfig_extra_route(struct multi_instance *mi, i=
n_addr_t dest);
+multi_check_push_ifconfig_extra_route(struct context *c, i=
n_addr_t dest);
 
 /**
  * Determines if the ifconfig_ipv6_local address fa=
lls into the range of the local
  * IP addresses of the VPN interface (ifco=
nfig_local with ifconfig_remote_netmask)
  *
- * @param mi           The mu=
lti-instance to check this condition for
+ * @param c            The multi-=
instance context to check this condition for
  * @param dest         The de=
stination IPv6 address to check
  *
  * @return Returns true if ifconfig_pu=
sh is outside that range and requires an extra
  * route to be installed=2E=

  */
 bool
-multi_check_push_ifconfig_ipv6_extra_route(struct multi_instan=
ce *mi,
+multi_check_push_ifconfig_ipv6_extra_route(struct context *c,
    =
                                        struct in6_addr *dest);
 
 /*

-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5832dc56eaeca1b17016=
396769b84bdf2c1513a
Gerrit-Change-Number: 1682
Gerrit-PatchSet: 2
Gerrit-Ow=
ner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--d8Qua8zjo/Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1682?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">multi/dco=
: simplify dco_delete_iroutes call chain<br><br>In order to be able to dele=
te DCO iroutes from areas of the code<br>where the multi_context and the mu=
lti_instance objects may not be<br>available, let&#39;s simplify the call c=
hain by passing the smallest<br>scoped context required=2E<br><br>This is a=
 refactoring only and does not include any functional change=2E<br><br>This=
 patch is required in preparation of fixing DCO iroutes removal<br>upon cli=
ent exit, without waiting for the delayed exit routine<br>to kick in=2E<br>=
<br>Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a<br>Signed-off-by: =
Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/d=
co=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn=
/multi=2Eh<br>4 files changed, 31 insertions(+), 33 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/82/1682/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=
=2Ec</span><br><span>index f5b7081=2E=2Efae0548 100644</span><br><span>--- =
a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><=
span>@@ -724,26 +724,25 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_delete_=
iroutes(struct multi_context *m, struct multi_instance *mi)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes(openvpn_net_ctx_=
t *net_ctx, struct context *c)</span><br><span> {</span><br><span> #if defi=
ned(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!dco_enabled(&amp;m-&gt;t=
op=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!dco_enabled(&amp;c-&gt;options))</span><br><span>     {</span><br><span=
>         return;</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ASSERT(TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct conte=
xt *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (mi-&gt;context=2Ec2=2Epush_ifconfig_defi=
ned)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c=
2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span>         =
for (const struct iroute *ir =3D c-&gt;options=2Eiroutes; ir; ir =3D ir-&gt=
;next)</span><br><span>         {</span><br><span> #if defined(_WIN32)</spa=
n><br><span>             dco_win_del_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt=
;dco, htonl(ir-&gt;network), ir-&gt;netbits);</span><br><span> #else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            net_route_v4_del=
(&amp;m-&gt;top=2Enet_ctx, &amp;ir-&gt;network, ir-&gt;netbits,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                             &amp=
;mi-&gt;context=2Ec2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;actual_na=
me, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            n=
et_route_v4_del(net_ctx, &amp;ir-&gt;network, ir-&gt;netbits,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                             &amp=
;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</spa=
n><br><span>                              DCO_IROUTE_METRIC);</span><br><sp=
an> #endif</span><br><span>         }</span><br><span>@@ -751,27 +750,26 @@=
</span><br><span> #if !defined(_WIN32)</span><br><span>         /* Check if=
 we added a host route as the assigned client IP address was</span><br><spa=
n>          * not in the on link scope defined by --ifconfig */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        in_addr_t ifconfig_local =
=3D mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        in_addr_t ifconfig_local =3D c-&gt;c2=2E=
push_ifconfig_local;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (multi_check_push_ifconfig_extra_route(mi, hton=
l(ifconfig_local)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (multi_check_push_ifconfig_extra_route(c, htonl(ifconfig_local))=
)</span><br><span>         {</span><br><span>             /* On windows we =
do not install these routes, so we also do not need to delete them */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            net_route_v4_de=
l(&amp;m-&gt;top=2Enet_ctx, &amp;ifconfig_local,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                             32, NULL, c-&gt;c1=
=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                             DCO_IROUTE_METRIC);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            net_route_v4_del(net_ctx, =
&amp;ifconfig_local, 32, NULL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                             c-&gt;c1=2Etuntap-&gt;actual_name, =
0, DCO_IROUTE_METRIC);</span><br><span>         }</span><br><span> #endif</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2E=
push_ifconfig_ipv6_defined)</span><br><span>     {</span><br><span>        =
 for (const struct iroute_ipv6 *ir6 =3D c-&gt;options=2Eiroutes_ipv6; ir6; =
ir6 =3D ir6-&gt;next)</span><br><span>         {</span><br><span> #if defin=
ed(_WIN32)</span><br><span>             dco_win_del_iroute_ipv6(&amp;c-&gt;=
c1=2Etuntap-&gt;dco, ir6-&gt;network, ir6-&gt;netbits);</span><br><span> #e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            net_ro=
ute_v6_del(&amp;m-&gt;top=2Enet_ctx, &amp;ir6-&gt;network, ir6-&gt;netbits,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
        &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etun=
tap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            net_route_v6_del(net_ctx, &amp;ir6-&gt;network, ir6-&gt;net=
bits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
               &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-=
&gt;actual_name, 0,</span><br><span>                              DCO_IROUT=
E_METRIC);</span><br><span> #endif</span><br><span>         }</span><br><sp=
an>@@ -779,11 +777,11 @@</span><br><span>         /* Checked if we added a =
host route as the assigned client IP address was</span><br><span>          =
* outside the --ifconfig-ipv6 tun interface config */</span><br><span> #if =
!defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct in6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_=
local;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mul=
ti_check_push_ifconfig_ipv6_extra_route(mi, dest))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct in6_addr *dest =3D &amp;c-&gt=
;c2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (multi_check_push_ifconfig_ipv6_extra_route(c, dest)=
)</span><br><span>         {</span><br><span>             /* On windows we =
do not install these routes, so we also do not need to delete them */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            net_route_v6_de=
l(&amp;m-&gt;top=2Enet_ctx, dest, 128, NULL,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            net_route_v6_del(net_ctx, dest, 128, N=
ULL,</span><br><span>                              c-&gt;c1=2Etuntap-&gt;ac=
tual_name, 0, DCO_IROUTE_METRIC);</span><br><span>         }</span><br><spa=
n> #endif</span><br><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dc=
o=2Eh</span><br><span>index 4e5aad5=2E=2E733f59a1 100644</span><br><span>--=
- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br=
><span>@@ -220,10 +220,10 @@</span><br><span> /**</span><br><span>  * Remov=
e all routes added through the specified client</span><br><span>  *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param m         the serve=
r context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param mi=
        the client instance for which routes have to be removed</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param net_ctx   the iface n=
etworking context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param c         the client context for which routes have to be removed</s=
pan><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-voi=
d dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void dco_delete_irout=
es(openvpn_net_ctx_t *net_ctx, struct context *c);</span><br><span> </span>=
<br><span> /**</span><br><span>  * Update traffic statistics for all peers<=
/span><br><span>@@ -361,7 +361,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static inline void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-dco_delete_iroutes(struct multi_context *m, struct multi_instan=
ce *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_i=
routes(openvpn_net_ctx_t *net_ctx, struct context *c)</span><br><span> {</s=
pan><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn=
/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index a957fdf=2E=2Ee94a7=
d5 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b=
/src/openvpn/multi=2Ec</span><br><span>@@ -479,7 +479,7 @@</span><br><span>=
     const struct iroute *ir;</span><br><span>     const struct iroute_ipv6=
 *ir6;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    dco_delete_iroutes(m, mi);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    dco_delete_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;=
context);</span><br><span> </span><br><span>     if (TUNNEL_TYPE(mi-&gt;con=
text=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><=
span>@@ -1198,7 +1198,7 @@</span><br><span>         management_learn_addr(m=
anagement, &amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary);</sp=
an><br><span>     }</span><br><span> #endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (primary &amp;&amp; multi_check_push_ifconfig_=
extra_route(mi, addr=2Ev4=2Eaddr))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (primary &amp;&amp; multi_check_push_ifconfig_extra_r=
oute(&amp;mi-&gt;context, addr=2Ev4=2Eaddr))</span><br><span>     {</span><=
br><span>         /* &quot;primary&quot; is the VPN ifconfig address of the=
 peer */</span><br><span>         /* if it does not fall into the network d=
efined by ifconfig_local</span><br><span>@@ -1243,7 +1243,7 @@</span><br><s=
pan>         management_learn_addr(management, &amp;mi-&gt;context=2Ec2=2Em=
da_context, &amp;addr, primary);</span><br><span>     }</span><br><span> #e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (primary &=
amp;&amp; multi_check_push_ifconfig_ipv6_extra_route(mi, &amp;addr=2Ev6=2Ea=
ddr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (primar=
y &amp;&amp; multi_check_push_ifconfig_ipv6_extra_route(&amp;mi-&gt;context=
, &amp;addr=2Ev6=2Eaddr))</span><br><span>     {</span><br><span>         /=
* &quot;primary&quot; is the VPN ifconfig address of the peer */</span><br>=
<span>         /* if it does not fall into the network defined by ifconfig_=
local</span><br><span>@@ -4373,9 +4373,9 @@</span><br><span> }</span><br><s=
pan> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_a=
ddr_t dest)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_ch=
eck_push_ifconfig_extra_route(struct context *c, in_addr_t dest)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct op=
tions *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct options *o =3D &amp;c-&gt;options;</span=
><br><span>     in_addr_t local_addr, local_netmask;</span><br><span> </spa=
n><br><span>     if (!o-&gt;ifconfig_local || !o-&gt;ifconfig_remote_netmas=
k)</span><br><span>@@ -4394,10 +4394,10 @@</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifc=
onfig_ipv6_extra_route(struct context *c,</span><br><span>                 =
                           struct in6_addr *dest)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct options *o =3D &a=
mp;mi-&gt;context=2Eoptions;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct options *o =3D &amp;c-&gt;options;</span><br><span> </s=
pan><br><span>     if (!o-&gt;ifconfig_ipv6_local || !o-&gt;ifconfig_ipv6_n=
etbits)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/mul=
ti=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 3ed08d4=2E=2E35ad13f 1=
00644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src=
/openvpn/multi=2Eh</span><br><span>@@ -673,27 +673,27 @@</span><br><span>  =
* Determines if the ifconfig_push_local address falls into the range of the=
 local</span><br><span>  * IP addresses of the VPN interface (ifconfig_loca=
l with ifconfig_remote_netmask)</span><br><span>  *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param mi           The multi-instance t=
o check this condition for</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param c            The multi-instance context to check this cond=
ition for</span><br><span>  * @param dest         The destination IP addres=
s to check</span><br><span>  *</span><br><span>  * @return Returns true if =
ifconfig_push is outside that range and requires an extra</span><br><span> =
 * route to be installed=2E</span><br><span>  */</span><br><span> bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfig_=
extra_route(struct multi_instance *mi, in_addr_t dest);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_extra_route(s=
truct context *c, in_addr_t dest);</span><br><span> </span><br><span> /**</=
span><br><span>  * Determines if the ifconfig_ipv6_local address falls into=
 the range of the local</span><br><span>  * IP addresses of the VPN interfa=
ce (ifconfig_local with ifconfig_remote_netmask)</span><br><span>  *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param mi           The m=
ulti-instance to check this condition for</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param c            The multi-instance context to =
check this condition for</span><br><span>  * @param dest         The destin=
ation IPv6 address to check</span><br><span>  *</span><br><span>  * @return=
 Returns true if ifconfig_push is outside that range and requires an extra<=
/span><br><span>  * route to be installed=2E</span><br><span>  */</span><br=
><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_che=
ck_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_ipv6_ext=
ra_route(struct context *c,</span><br><span>                               =
             struct in6_addr *dest);</span><br><span> </span><br><span> /*<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">change 1682</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5832dc56eaeca1b1=
7016396769b84bdf2c1513a </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1682 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--d8Qua8zjo/Q=--


--===============2577411600270195033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2577411600270195033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2577411600270195033==--

