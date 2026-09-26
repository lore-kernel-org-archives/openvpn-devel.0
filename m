Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE68C9832A
	for <openvpn-devel@archiver.kernel.org>; Sat, 26 Sep 2026 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zM3KSvEnL3CHLlJaAwiy1CLHzFgQIBu3kSQif5KNgak=; b=LyXw8NA0pfK8o8mk7P9/zaRTBK
	gJJlYKk8fn9Hl88G9S9R6YA59UVtW0Rc/+UGD3xUcFywcPt/POiSIIXoXc5nqqgWu1Mp4+4HjOYwL
	JrRSxIYL4m+4E67DtrHNgUNqxfIh2BA5iWZaeNgXR00BJwjTDjxbHYHJopwNIJhWJv8Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xAYim-0002Nc-Vs;
	Sat, 26 Sep 2026 20:10:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xAYik-0002NU-Uk
 for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 20:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Hx9DI6PRKW8d9RFMT/tXl4LSARZRqHz6H8MCuFrSOaQ=; b=lhEAByFHHLNl/sCn8fC2/+UUYL
 HY8ughI5KVp0I1A+UhiqF3hfhnpfqfI4Hoz60PyIY6JKx939HmNzNF71+I3o7GQIITRYR6RieKU+h
 S5VFgbQsoJiX9jViuSzBwZHZd9K5zzNYJaUjjc1ANnU+4KFZFxSEG/xn45heTiEhYs+w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hx9DI6PRKW8d9RFMT/tXl4LSARZRqHz6H8MCuFrSOaQ=; b=Q
 uR+ZDDgq48loz01KNlitnSgmixuAWqHuvBJRHp78G17JrBR9CT+BoyZKM/rd0v10obfZ+kJVOyDfl
 jgHTCSMzIlZgl6X3sHS5jy4JgG/NhGbjJYYg8YETi6RJt4iCcpys1iCiuVHpKTFsCPNv4ZSdlbIQm
 hSuWn+u07TYLRcvE=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xAYij-0006AU-8r for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 20:10:07 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ff9621c5dso4843325e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 26 Sep 2026 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790453399; x=1791058199; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hx9DI6PRKW8d9RFMT/tXl4LSARZRqHz6H8MCuFrSOaQ=;
 b=RAozjgvc0ViRlUN/z4SUphwiXznDwpE7zF6iZsib6o0vEEEUmzMhi8u6ootw9PzACU
 pfxGVrYELvCkuCwgKMCyijLjk6on/Wq6P2SeB3lsU1GIDeeFrB4euNv4xS32+wfOnsPQ
 B5yaF3cZXE/E2bGg/klbey+jWKJSLpVpaV8BZicRCLPbSyBDR6kIo4KVFB8LfFIgSFQS
 yZREFelIn+5zKVwbdISdbvzNSkHCW3NnLnUfWim5E6Y1u0kLjwBaGZ9Q8i1PyPXKAVgk
 veqxWub6foWtrXbD8NnhDn+QSZhEJ0hMarTkhgBmbJ0F8ZzY8RSZG4UDX50gUf/1/Zau
 wdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790453399; x=1791058199;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Hx9DI6PRKW8d9RFMT/tXl4LSARZRqHz6H8MCuFrSOaQ=;
 b=hgOMmIcYFEeSI3GOjX1NMZ6vWUSDyJtdQYDKPhkHZuZRkqXKiLzSDN7ZUwzyGhMVRg
 O0Da+6muciA09ovJQv54SPCqumgu0gAMLhZGYDAP5gsudsW7Dg0ngLXapVWMSYxaGisi
 HyD3lwSVWF4ffeomileyPWhnWwu4ys+eJqD9+lz+/5FOC+RXzysmbtRXv6/hsnP8Bc8n
 f+BxEV5g33pOvJd/OcbIKO+mTls6tjSNdmDIsHJKMUhBgndKjcfa4nd0iJBSTkqYTNwk
 u/NCFq6MNQ3ERQPV0/+UcQcSxKY+FD/Q4VOgXxi7UELjNGrcSOq2lncWipWHRPMvWkIi
 20Aw==
X-Gm-Message-State: AFuF++mbsIeG1RQSbyqr1g3fRFzpRDflZEZ4fOCO3QtEmWlIXYintIix
 a0eqr/9i3H/FwBNfYfw9qvYI66v9Rsp7WtCPjTXc/E0ERuAvdOgK3xXBkr4fWFGpjsGBGXhnYfr
 c0MJAq/YM2u/XH/FLEvU/uhANaXYilcdGzqoYZlyX0oC64P3xKKKCybTHi2ajHjFqScHX
X-Gm-Gg: AYBFou3rVJrE7gn/QP9JaMxwDo4mSu7fwkYMaSFsvV43A49K8LURgXc81LJufcSeqMP
 lCqTGU7yPIimSjfCJq1ppWK7nlQdaFLgJwl9QJoTm6hSv+J0ULWCE/DcUaRDQw93he6nvpK/Xog
 PEReiNp0pTtVujhvotAD6ovAlHUaT30u913JIr8cFfKmSdkNoXGpWiSE5Oee1Z5S0zR+wFSLtst
 23MLCtyFEzW0INIkNVe4sb+xOeHdHCmcwHf63GxzttxMncj4lKA7TDwDLoI8glW1CMYwmhmcXiQ
 PW9e8Dae6WSri6bAv8sbSWntqEcicDbZ2CFBqgPH+zI/y6vCaKb2jWmLKRUAAViOXjvQSXI7BOf
 NS6AY7QwFBwu4bkUCwhiivQ4mgLBsRO8C3ErPf263Yd4tdC7+thIzPgIb3EXrlL6curg8mYijtL
 9gSjRgE0LXQ5PDKXkA01NBfGzist9Sz7rEno0kYsXpZ18224xnxaOAHxX4OTOmqj03zscwFLBed
 okwrZgzQY/KA+b72JOkUcAnWMT0PiWGHVjRy/EuuOjJ98erxWnwGfkzKASxoWDvYZEne2qfd2w3
 QfvQJH8HK4L27eDaZn+6D7/UDkG0aSg0nUtwdt9e7dQZ1RlyytT84B1vzUbm/xE+KtKvD70=
X-Received: by 2002:a05:600c:638f:b0:49c:ffab:551f with SMTP id
 5b1f17b1804b1-49fe66d8112mr157980855e9.22.1790453398533; 
 Sat, 26 Sep 2026 13:09:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017612e5sm333525e9.2.2026.09.26.13.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 13:09:58 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 26 Sep 2026 20:09:56 +0000
To: razvanc <razvanc@mailbox.org>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: 48939c9cd29b3bd857da10452aae854bc670c04f
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d63d922accfaf73b6c0ebe8c823277c9bc22cbf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xAYij-0006AU-8r
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8202280164796772669=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8202280164796772669==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rsk6YP7fp5c="; charset=UTF-8

--rsk6YP7fp5c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by razv=
anc


Change subject: multi/dco: simplify dco_delete_iroutes call chain
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi/dco: simpl=
ify dco_delete_iroutes call chain

In order to be able to delete DCO iroute=
s from areas of the code
where the multi_context and the multi_instance obj=
ects may not be
available, let's simplify the call chain by passing the sma=
llest
scoped context required=2E

This is a refactoring only and does not i=
nclude any functional change=2E

This patch is required in preparation of f=
ixing DCO iroutes removal
upon client exit, without waiting for the delayed=
 exit routine
to kick in=2E

Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2=
c1513a
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked-by:=
 Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1682
Message-Id: <20260921082222=2E17813-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg39358=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/=
multi=2Ec
M src/openvpn/multi=2Eh
4 files changed, 29 insertions(+), 37 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/82/1682/5

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index=
 8eae4bf=2E=2Eba1c85f 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dc=
o=2Ec
@@ -741,26 +741,24 @@
 }
 
 void
-dco_delete_iroutes(struct multi_con=
text *m, struct multi_instance *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *=
net_ctx, const struct context *c)
 {
 #if defined(TARGET_LINUX) || defined(=
TARGET_FREEBSD) || defined(_WIN32)
-    if (!dco_enabled(&m->top=2Eoptions)=
)
+    if (!dco_enabled(&c->options))
     {
         return;
     }
-    A=
SSERT(TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN);
+    ASS=
ERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
-    const struct c=
ontext *c =3D &mi->context;
-
-    if (mi->context=2Ec2=2Epush_ifconfig_def=
ined)
+    if (c->c2=2Epush_ifconfig_defined)
     {
         for (const st=
ruct iroute *ir =3D c->options=2Eiroutes; ir; ir =3D ir->next)
         {
 =
#if defined(_WIN32)
             dco_win_del_iroute_ipv4(&c->c1=2Etuntap->d=
co, htonl(ir->network), ir->netbits);
 #else
-            net_route_v4_del(=
&m->top=2Enet_ctx, &ir->network, ir->netbits,
-                            =
 &mi->context=2Ec2=2Epush_ifconfig_local, c->c1=2Etuntap->actual_name, 0,
+=
            net_route_v4_del(net_ctx, &ir->network, ir->netbits,
+         =
                    &c->c2=2Epush_ifconfig_local, c->c1=2Etuntap->actual_na=
me, 0,
                              DCO_IROUTE_METRIC);
 #endif
         }=

@@ -768,27 +766,26 @@
 #if !defined(_WIN32)
         /* Check if we added =
a host route as the assigned client IP address was
          * not in the o=
n link scope defined by --ifconfig */
-        in_addr_t ifconfig_local =3D=
 mi->context=2Ec2=2Epush_ifconfig_local;
+        in_addr_t ifconfig_local =
=3D c->c2=2Epush_ifconfig_local;
 
-        if (multi_check_push_ifconfig_e=
xtra_route(mi, htonl(ifconfig_local)))
+        if (multi_check_push_ifconf=
ig_extra_route(&c->options, htonl(ifconfig_local)))
         {
            =
 /* On windows we do not install these routes, so we also do not need to de=
lete them */
-            net_route_v4_del(&m->top=2Enet_ctx, &ifconfig_loc=
al,
-                             32, NULL, c->c1=2Etuntap->actual_name, 0,=

-                             DCO_IROUTE_METRIC);
+            net_route_v=
4_del(net_ctx, &ifconfig_local, 32, NULL,
+                             c->=
c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
         }
 #endif
     }
=
 
-    if (mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
+    if (c->c2=2E=
push_ifconfig_ipv6_defined)
     {
         for (const struct iroute_ipv6 *=
ir6 =3D c->options=2Eiroutes_ipv6; ir6; ir6 =3D ir6->next)
         {
 #if =
defined(_WIN32)
             dco_win_del_iroute_ipv6(&c->c1=2Etuntap->dco, =
ir6->network, ir6->netbits);
 #else
-            net_route_v6_del(&m->top=
=2Enet_ctx, &ir6->network, ir6->netbits,
-                             &mi-=
>context=2Ec2=2Epush_ifconfig_ipv6_local, c->c1=2Etuntap->actual_name, 0,
+=
            net_route_v6_del(net_ctx, &ir6->network, ir6->netbits,
+       =
                      &c->c2=2Epush_ifconfig_ipv6_local, c->c1=2Etuntap->ac=
tual_name, 0,
                              DCO_IROUTE_METRIC);
 #endif
   =
      }
@@ -796,11 +793,11 @@
         /* Checked if we added a host route =
as the assigned client IP address was
          * outside the --ifconfig-ip=
v6 tun interface config */
 #if !defined(_WIN32)
-        struct in6_addr *=
dest =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
-        if (multi_c=
heck_push_ifconfig_ipv6_extra_route(mi, dest))
+        const struct in6_ad=
dr *dest =3D &c->c2=2Epush_ifconfig_ipv6_local;
+        if (multi_check_pu=
sh_ifconfig_ipv6_extra_route(&c->options, dest))
         {
             /*=
 On windows we do not install these routes, so we also do not need to delet=
e them */
-            net_route_v6_del(&m->top=2Enet_ctx, dest, 128, NULL,=

+            net_route_v6_del(net_ctx, dest, 128, NULL,
                  =
            c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
         }
=
 #endif
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 4e5aad=
5=2E=2E7ef75fee 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
=
@@ -220,10 +220,10 @@
 /**
  * Remove all routes added through the specifie=
d client
  *
- * @param m         the server context
- * @param mi        t=
he client instance for which routes have to be removed
+ * @param net_ctx  =
 the iface networking context
+ * @param c         the client context for w=
hich routes have to be removed
  */
-void dco_delete_iroutes(struct multi_c=
ontext *m, struct multi_instance *mi);
+void dco_delete_iroutes(openvpn_net=
_ctx_t *net_ctx, const struct context *c);
 
 /**
  * Update traffic statis=
tics for all peers
@@ -361,7 +361,7 @@
 }
 
 static inline void
-dco_delete=
_iroutes(struct multi_context *m, struct multi_instance *mi)
+dco_delete_ir=
outes(openvpn_net_ctx_t *net_ctx, const struct context *c)
 {
 }
 
diff --g=
it a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a6fadf6=2E=2E52364=
f9 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -479,7=
 +479,7 @@
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6=
;
 
-    dco_delete_iroutes(m, mi);
+    dco_delete_iroutes(&m->top=2Enet_c=
tx, &mi->context);
 
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D=
 DEV_TYPE_TUN)
     {
@@ -1197,7 +1197,7 @@
         management_learn_addr(=
&mi->context=2Ec2=2Emda_context, &addr, primary);
     }
 #endif
-    if (p=
rimary && multi_check_push_ifconfig_extra_route(mi, addr=2Ev4=2Eaddr))
+   =
 if (primary && multi_check_push_ifconfig_extra_route(&mi->context=2Eoption=
s, addr=2Ev4=2Eaddr))
     {
         /* "primary" is the VPN ifconfig addr=
ess of the peer */
         /* if it does not fall into the network defined=
 by ifconfig_local
@@ -1242,7 +1242,7 @@
         management_learn_addr(&mi=
->context=2Ec2=2Emda_context, &addr, primary);
     }
 #endif
-    if (prim=
ary && multi_check_push_ifconfig_ipv6_extra_route(mi, &addr=2Ev6=2Eaddr))
+=
    if (primary && multi_check_push_ifconfig_ipv6_extra_route(&mi->context=
=2Eoptions, &addr=2Ev6=2Eaddr))
     {
         /* "primary" is the VPN ifc=
onfig address of the peer */
         /* if it does not fall into the netwo=
rk defined by ifconfig_local
@@ -4439,9 +4439,8 @@
 }
 
 bool
-multi_check_=
push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest)
+multi=
_check_push_ifconfig_extra_route(const struct options *o, in_addr_t dest)
 =
{
-    const struct options *o =3D &mi->context=2Eoptions;
     in_addr_t l=
ocal_addr, local_netmask;
 
     if (!o->ifconfig_local || !o->ifconfig_rem=
ote_netmask)
@@ -4460,11 +4459,8 @@
 }
 
 bool
-multi_check_push_ifconfig_i=
pv6_extra_route(struct multi_instance *mi,
-                               =
            struct in6_addr *dest)
+multi_check_push_ifconfig_ipv6_extra_ro=
ute(const struct options *o, const struct in6_addr *dest)
 {
-    const str=
uct options *o =3D &mi->context=2Eoptions;
-
     if (!o->ifconfig_ipv6_loc=
al || !o->ifconfig_ipv6_netbits)
     {
         /* If we do not have a loc=
al address, we just return false as
diff --git a/src/openvpn/multi=2Eh b/sr=
c/openvpn/multi=2Eh
index ac6cb78f=2E=2E7115b34 100644
--- a/src/openvpn/mu=
lti=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -668,28 +668,27 @@
  * Determines if=
 the ifconfig_push_local address falls into the range of the local
  * IP a=
ddresses of the VPN interface (ifconfig_local with ifconfig_remote_netmask)=

  *
- * @param mi           The multi-instance to check this condition for=

+ * @param o            The instance wide options
  * @param dest         =
The destination IP address to check
  *
  * @return Returns true if ifconfi=
g_push is outside that range and requires an extra
  * route to be installe=
d=2E
  */
 bool
-multi_check_push_ifconfig_extra_route(struct multi_instanc=
e *mi, in_addr_t dest);
+multi_check_push_ifconfig_extra_route(const struct=
 options *o, in_addr_t dest);
 
 /**
  * Determines if the ifconfig_ipv6_lo=
cal address falls into the range of the local
  * IP addresses of the VPN i=
nterface (ifconfig_local with ifconfig_remote_netmask)
  *
- * @param mi   =
        The multi-instance to check this condition for
+ * @param o        =
    The instance wide options
  * @param dest         The destination IPv6 =
address to check
  *
  * @return Returns true if ifconfig_push is outside t=
hat range and requires an extra
  * route to be installed=2E
  */
 bool
-mu=
lti_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-      =
                                     struct in6_addr *dest);
+multi_check_p=
ush_ifconfig_ipv6_extra_route(const struct options *o, const struct in6_add=
r *dest);
 
 /*
  * Check for signals=2E

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
Gerrit-C=
hange-Number: 1682
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <antonio@mandelbi=
t=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--rsk6YP7fp5c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">multi/dco: simplify dco_delete_=
iroutes call chain<br><br>In order to be able to delete DCO iroutes from ar=
eas of the code<br>where the multi_context and the multi_instance objects m=
ay not be<br>available, let&#39;s simplify the call chain by passing the sm=
allest<br>scoped context required=2E<br><br>This is a refactoring only and =
does not include any functional change=2E<br><br>This patch is required in =
preparation of fixing DCO iroutes removal<br>upon client exit, without wait=
ing for the delayed exit routine<br>to kick in=2E<br><br>Change-Id: Ib5832d=
c56eaeca1b17016396769b84bdf2c1513a<br>Signed-off-by: Antonio Quartulli &lt;=
antonio@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682<=
br>Message-Id: &lt;20260921082222=2E17813-1-gert@greenie=2Emuc=2Ede&gt;<br>=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg39358=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/op=
envpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>4 files changed, 29 insertion=
s(+), 37 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/82/1682/5</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 8eae4bf=2E=2Eba1=
c85f 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b=
/src/openvpn/dco=2Ec</span><br><span>@@ -741,26 +741,24 @@</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-dco_delete_iroutes(struct multi_context *m, struct mul=
ti_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco=
_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)</span>=
<br><span> {</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_F=
REEBSD) || defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!dco_enabled(&amp;c-&gt;options))=
</span><br><span>     {</span><br><span>         return;</span><br><span>  =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(TUNNEL=
_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etun=
tap) =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const struct context *c =3D &amp;mi-&gt;context;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context=2Ec2=2Epush_ifconfi=
g_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span>   =
      for (const struct iroute *ir =3D c-&gt;options=2Eiroutes; ir; ir =3D =
ir-&gt;next)</span><br><span>         {</span><br><span> #if defined(_WIN32=
)</span><br><span>             dco_win_del_iroute_ipv4(&amp;c-&gt;c1=2Etunt=
ap-&gt;dco, htonl(ir-&gt;network), ir-&gt;netbits);</span><br><span> #else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            net_route_=
v4_del(&amp;m-&gt;top=2Enet_ctx, &amp;ir-&gt;network, ir-&gt;netbits,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
  &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;act=
ual_name, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     net_route_v4_del(net_ctx, &amp;ir-&gt;network, ir-&gt;netbits,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
  &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0=
,</span><br><span>                              DCO_IROUTE_METRIC);</span><=
br><span> #endif</span><br><span>         }</span><br><span>@@ -768,27 +766=
,26 @@</span><br><span> #if !defined(_WIN32)</span><br><span>         /* Ch=
eck if we added a host route as the assigned client IP address was</span><b=
r><span>          * not in the on link scope defined by --ifconfig */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        in_addr_t ifconfig_=
local =3D mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        in_addr_t ifconfig_local =3D c-&g=
t;c2=2Epush_ifconfig_local;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (multi_check_push_ifconfig_extra_route(m=
i, htonl(ifconfig_local)))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (multi_check_push_ifconfig_extra_route(&amp;c-&gt;options=
, htonl(ifconfig_local)))</span><br><span>         {</span><br><span>      =
       /* On windows we do not install these routes, so we also do not need=
 to delete them */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         net_route_v4_del(&amp;m-&gt;top=2Enet_ctx, &amp;ifconfig_local,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
     32, NULL, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                             DCO_IROUTE_MET=
RIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ne=
t_route_v4_del(net_ctx, &amp;ifconfig_local, 32, NULL,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                             c-&gt;c1=2E=
tuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span>         }</=
span><br><span> #endif</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context=2Ec2=2Epus=
h_ifconfig_ipv6_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (c-&gt;c2=2Epush_ifconfig_ipv6_defined)</span><br><span>     {<=
/span><br><span>         for (const struct iroute_ipv6 *ir6 =3D c-&gt;optio=
ns=2Eiroutes_ipv6; ir6; ir6 =3D ir6-&gt;next)</span><br><span>         {</s=
pan><br><span> #if defined(_WIN32)</span><br><span>             dco_win_del=
_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, ir6-&gt;network, ir6-&gt;netbi=
ts);</span><br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            net_route_v6_del(&amp;m-&gt;top=2Enet_ctx, &amp;ir6-&gt;n=
etwork, ir6-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                             &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ip=
v6_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            net_route_v6_del(net_ctx, &amp;ir6-=
&gt;network, ir6-&gt;netbits,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                             &amp;c-&gt;c2=2Epush_ifconfig_ipv6_l=
ocal, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span>               =
               DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>=
         }</span><br><span>@@ -796,11 +793,11 @@</span><br><span>         /=
* Checked if we added a host route as the assigned client IP address was</s=
pan><br><span>          * outside the --ifconfig-ipv6 tun interface config =
*/</span><br><span> #if !defined(_WIN32)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        struct in6_addr *dest =3D &amp;mi-&gt;context=2E=
c2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct=
 in6_addr *dest =3D &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (multi_check_push_ifco=
nfig_ipv6_extra_route(&amp;c-&gt;options, dest))</span><br><span>         {=
</span><br><span>             /* On windows we do not install these routes,=
 so we also do not need to delete them */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            net_route_v6_del(&amp;m-&gt;top=2Enet_ctx, =
dest, 128, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         net_route_v6_del(net_ctx, dest, 128, NULL,</span><br><span>       =
                       c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_MET=
RIC);</span><br><span>         }</span><br><span> #endif</span><br><span>di=
ff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index =
4e5aad5=2E=2E7ef75fee 100644</span><br><span>--- a/src/openvpn/dco=2Eh</spa=
n><br><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -220,10 +220,10 @@=
</span><br><span> /**</span><br><span>  * Remove all routes added through t=
he specified client</span><br><span>  *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * @param m         the server context</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param mi        the client instance =
for which routes have to be removed</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param net_ctx   the iface networking context</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param c         the client=
 context for which routes have to be removed</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void dco_delete_iroutes(struct =
multi_context *m, struct multi_instance *mi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void dco_delete_iroutes(openvpn_net_ctx_t *net_ct=
x, const struct context *c);</span><br><span> </span><br><span> /**</span><=
br><span>  * Update traffic statistics for all peers</span><br><span>@@ -36=
1,7 +361,7 @@</span><br><span> }</span><br><span> </span><br><span> static =
inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_delete=
_iroutes(struct multi_context *m, struct multi_instance *mi)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes(openvpn_net_ctx=
_t *net_ctx, const struct context *c)</span><br><span> {</span><br><span> }=
</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src=
/openvpn/multi=2Ec</span><br><span>index a6fadf6=2E=2E52364f9 100644</span>=
<br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mul=
ti=2Ec</span><br><span>@@ -479,7 +479,7 @@</span><br><span>     const struc=
t iroute *ir;</span><br><span>     const struct iroute_ipv6 *ir6;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_delet=
e_iroutes(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  dco_delete_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span>=
<br><span> </span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etunt=
ap) =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1197,7 =
+1197,7 @@</span><br><span>         management_learn_addr(&amp;mi-&gt;conte=
xt=2Ec2=2Emda_context, &amp;addr, primary);</span><br><span>     }</span><b=
r><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (primary &amp;&amp; multi_check_push_ifconfig_extra_route(mi, addr=2Ev4=2E=
addr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (prima=
ry &amp;&amp; multi_check_push_ifconfig_extra_route(&amp;mi-&gt;context=2Eo=
ptions, addr=2Ev4=2Eaddr))</span><br><span>     {</span><br><span>         =
/* &quot;primary&quot; is the VPN ifconfig address of the peer */</span><br=
><span>         /* if it does not fall into the network defined by ifconfig=
_local</span><br><span>@@ -1242,7 +1242,7 @@</span><br><span>         manag=
ement_learn_addr(&amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary=
);</span><br><span>     }</span><br><span> #endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (primary &amp;&amp; multi_check_push_ifc=
onfig_ipv6_extra_route(mi, &amp;addr=2Ev6=2Eaddr))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (primary &amp;&amp; multi_check_push_=
ifconfig_ipv6_extra_route(&amp;mi-&gt;context=2Eoptions, &amp;addr=2Ev6=2Ea=
ddr))</span><br><span>     {</span><br><span>         /* &quot;primary&quot=
; is the VPN ifconfig address of the peer */</span><br><span>         /* if=
 it does not fall into the network defined by ifconfig_local</span><br><spa=
n>@@ -4439,9 +4439,8 @@</span><br><span> }</span><br><span> </span><br><spa=
n> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_pu=
sh_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_ex=
tra_route(const struct options *o, in_addr_t dest)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct options *o=
 =3D &amp;mi-&gt;context=2Eoptions;</span><br><span>     in_addr_t local_ad=
dr, local_netmask;</span><br><span> </span><br><span>     if (!o-&gt;ifconf=
ig_local || !o-&gt;ifconfig_remote_netmask)</span><br><span>@@ -4460,11 +44=
59,8 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_push_ifconfig_ipv6=
_extra_route(struct multi_instance *mi,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                           struct in6_add=
r *dest)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check=
_push_ifconfig_ipv6_extra_route(const struct options *o, const struct in6_a=
ddr *dest)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const struct options *o =3D &amp;mi-&gt;context=2Eoptions;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (=
!o-&gt;ifconfig_ipv6_local || !o-&gt;ifconfig_ipv6_netbits)</span><br><span=
>     {</span><br><span>         /* If we do not have a local address, we j=
ust return false as</span><br><span>diff --git a/src/openvpn/multi=2Eh b/sr=
c/openvpn/multi=2Eh</span><br><span>index ac6cb78f=2E=2E7115b34 100644</spa=
n><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/m=
ulti=2Eh</span><br><span>@@ -668,28 +668,27 @@</span><br><span>  * Determin=
es if the ifconfig_push_local address falls into the range of the local</sp=
an><br><span>  * IP addresses of the VPN interface (ifconfig_local with ifc=
onfig_remote_netmask)</span><br><span>  *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * @param mi           The multi-instance to check this=
 condition for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram o            The instance wide options</span><br><span>  * @param dest=
         The destination IP address to check</span><br><span>  *</span><br>=
<span>  * @return Returns true if ifconfig_push is outside that range and r=
equires an extra</span><br><span>  * route to be installed=2E</span><br><sp=
an>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in=
_addr_t dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi=
_check_push_ifconfig_extra_route(const struct options *o, in_addr_t dest);<=
/span><br><span> </span><br><span> /**</span><br><span>  * Determines if th=
e ifconfig_ipv6_local address falls into the range of the local</span><br><=
span>  * IP addresses of the VPN interface (ifconfig_local with ifconfig_re=
mote_netmask)</span><br><span>  *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * @param mi           The multi-instance to check this conditi=
on for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param o  =
          The instance wide options</span><br><span>  * @param dest        =
 The destination IPv6 address to check</span><br><span>  *</span><br><span>=
  * @return Returns true if ifconfig_push is outside that range and require=
s an extra</span><br><span>  * route to be installed=2E</span><br><span>  *=
/</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                  struct in6_addr *dest);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+multi_check_push_ifconfig_ipv6_extra_route(const stru=
ct options *o, const struct in6_addr *dest);</span><br><span> </span><br><s=
pan> /*</span><br><span>  * Check for signals=2E</span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Dema=
il">change 1682</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
682?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1682 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html=
>
--rsk6YP7fp5c=--


--===============8202280164796772669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8202280164796772669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8202280164796772669==--

