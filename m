Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBD6C54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDUhJPOHCaDDwl09SoAcl1GBt1/PJ5hlyRqAfkLeH1Q=; b=f859yldvUhTtV6KCsBcan/s3tk
	I0+jYaKF6n1Q7JXyKe1P2Fps+5qLvdFfo4TWt0jPreLWL19sxl+oQPbVm0rxMaTcSph7LWn+NX6N+
	gAir1hkp8/aoJlKyH1bMvBsGJ3O9E3EaDPxjx7NjQMl43m//4FTd2ZFL8c02C9RL64dc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wocXB-0004S7-2e;
	Tue, 28 Jul 2026 07:47:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wocX9-0004S0-LJ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 07:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=X9dP/3iC1su00z6U9bOWG/PRYgEgf6EPmo2gAK4a5nA=; b=Og7BO38glHvVVKSixW7M5su194
 GHsh1NixmNCzqgsL9yLRVnx/SAu67ue9+LlM/SfW48G4W9YEv5WpH4CEVgwYI7UjhMTnq2Lz4Rnar
 dhGkfS901ThVqkhEJJqM579GDxKHVmdJ5mVbKzecxOPWXMP3595t1WhIufDIgRlVGh4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X9dP/3iC1su00z6U9bOWG/PRYgEgf6EPmo2gAK4a5nA=; b=N
 Qo/RTIEd16xmHNAvrkrwHaNrnJDoRPLXqVLOFPYtlMpaSsxtug/R4RfIGPqk246Q2J02u5Mum+8Fc
 WDELcHVVCkVwSpJAFjHoCPZEs+meH0fbB426LNpSLFKwsXq0lJhDZuckQFfAaIM6aQutAhmqMTKDr
 rZMBTPsT8qRo6Yrg=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wocX6-0002wG-Rk for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 07:47:25 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so24818125e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785224835; x=1785829635; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X9dP/3iC1su00z6U9bOWG/PRYgEgf6EPmo2gAK4a5nA=;
 b=FWyahQzs+SmQoN7GlkN60TL+EdBipxU0yQ9Y5Tos1VqgAFpjT6e+PCmdfdq+lFLJPb
 g1QMB2GNnTqhFe2EcnMt1TWN7AWt85eics0PC9BSCui/anf5m+08IfYnjJy9bG3+dnHM
 TnCmDaarBCzGOn+8vRscLEPFTQkpoUyD5VxJXIGyh7ONHBuKnqKqtJnRCCu8H2dQcMX0
 1K0IoxmnVaWXfAD4PyQdbdUhI3xDRQ0AkaAG/tNA+H3Ss5qHp5LQ/mo3ZMJtLo0P+fKz
 TP0X/vFhV0sIqdWoVLiKsYQGv4m2XaC5djabNL6xFDjuSr+GPMtrQHthQtlxP4eyoDcN
 E56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224835; x=1785829635;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X9dP/3iC1su00z6U9bOWG/PRYgEgf6EPmo2gAK4a5nA=;
 b=ZFr+Yy9sDvl5ngAtfgmuvBwcNqgh+aHcu1i7s5u03HSaLRMt8tU/MmTXW8jlO2U3QE
 VN5FwRU0yj4pt+tbgi9PWNAUDB648tR7SB4QYtRXIt1ubfBlD4MWAHQNnosbHD/m8aSP
 W0ea/l53DF/gu3Qcg89hP2ncuPCcNOvICNZifnD0KmZePosXu5iyXyKYexGQoLwcAQaE
 nf5+DCOeYmelWS/JYkxkATW0ycoxxJKy47Ydc04Jnx5uE/+cQFqvKsTy0UQDw2YlmioY
 Pkyx+/V644KosMYkkrAef623z6hu6GooGCQL4TO6Ducky+QRz8XN5zXwKDWnlBdVxcaH
 h3vg==
X-Gm-Message-State: AOJu0YwTwBZQ9tr3lEzJ5wYs4hxNMkIqM08CBu6Rbyr4VLLTgDeEvf6X
 pS5uQywWm/c6gEVqCZbuzagC59dYEkn3/aAT4xTbU3o/wraoGkOAkVbN8yg89AoH1BsYz43QQWN
 Lb0imSVFz6OaPak8JPXD8MFpxzPNwh2AV/PPspcfhlLmLiFNa9tARyOQebB5y+1dNYBXF
X-Gm-Gg: AR+sD10KfQPSLaDTDymWxuRf2+ZVbwF8Y+d8K4/O3sbC6pzUTD8XJ79XNmMS2eGGIFC
 YBcfJjp6eYjp/T/ts/levojOUR/9AvXnKufyG+KJaMK/d/fcvKXtmfDfxZ6AIrN3xA9KK1YiYpO
 ZF/wg0edBpOX6WFuW+nXqZSTEPyahYphzwwwIW9A7Hf4aFyV4nijSHXJp8TTk2RHFDsbVTIrqZ/
 jLbSoaEY7PhAj9VNcSvC4QEvsRHnclJLSPzGfqa72unenKROJuUwEi0I4GQXQU95334yTYUDGol
 5c9MzNwh4+enbuW1DZnTJWmWKavBd93hMvdi8QPms0znTJWw/8KopZ9FgAcDdn0YDF4i6Q3oSop
 pZNyapdVIuld+h094lwpZX/MC+dDy4TbM7yTud/u/jdYHeV3ouyPzaNB10KBewDavn0RBhpBNGa
 XqAeBQlDE2x7wg70H7hTQaPe/t2rRhvFOKC4t613rVgVxybA9dh/rNSyor/bQR1WGh1Go046VyY
 LSo82mhp0hrkHCdh0BWlg20jo1ol0VN1WwrXrIdPp4tOZJUdctHmuPNNgUIJXqh57lV
X-Received: by 2002:a05:600c:3b25:b0:495:39aa:1359 with SMTP id
 5b1f17b1804b1-496c641309bmr13651695e9.3.1785224834325; 
 Tue, 28 Jul 2026 00:47:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45e6d38sm64218445e9.14.2026.07.28.00.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:47:13 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 07:47:09 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 166bad41b6b290bffc81db9e747967d58833ea1e
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3545647f95895a42e209e0606a6fbbf492a0ef82-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wocX6-0002wG-Rk
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7996996331244609949=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7996996331244609949==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e8L2Spv9kYs="; charset=UTF-8

--e8L2Spv9kYs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, ordex=
, plaisthos=2E

Hello cron2, flichtenheld, plaisthos, 

I'd like you to ree=
xamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1089?usp=3Demail

to look at the new patch set (#29)=2E

The following =
approvals got outdated and were removed:
Code-Review-1 by cron2, Code-Revie=
w-1 by plaisthos


Change subject: multipeer: introduce asymmetric peer-id
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multipeer: in=
troduce asymmetric peer-id

In order to achieve a multipeer functionality, =
peers now
use separate IDs for sending (tx_peer_id) and receiving
(rx_peer_=
id)=2E

Each peer announces its own ID through pushing peer-info
using 'ID=
=3D7f1' hex format so identification can still
happen even if IP/port chang=
es=2E

In P2P mode, peer switch to using the announced IDs after
mutual exc=
hange=2E
In P2MP mode, clients always announce their ID, and servers
can op=
tionally respond with their own to enable the same
behavior=2E

Change-Id: =
I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Signed-off-by: Gianmarco De Grego=
ri <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M src/openvpn/init=
=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/options=
=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push_util=2Ec
M src/openvpn/ssl=
=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/s=
sl_util=2Ec
M src/openvpn/ssl_util=2Eh
12 files changed, 168 insertions(+),=
 54 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/89/1089/29

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=
=2Ec
index 2584368=2E=2Ece73701 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/=
openvpn/dco=2Ec
@@ -544,14 +544,15 @@
         c->c2=2Etls_multi->dco_peer_=
id =3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1=2Etuntap->dc=
o, multi->peer_id, sock->sd, NULL,
-                           proto_is_dgr=
am(sock->info=2Eproto) ? remoteaddr : NULL, NULL, NULL);
+    int ret =3D d=
co_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_id, sock->sd, NULL,
+     =
                      proto_is_dgram(sock->info=2Eproto) ? remoteaddr : NUL=
L,
+                           NULL, NULL);
     if (ret < 0)
     {
      =
   return ret;
     }
 
-    c->c2=2Etls_multi->dco_peer_id =3D multi->peer=
_id;
+    c->c2=2Etls_multi->dco_peer_id =3D multi->rx_peer_id;
 
     retu=
rn 0;
 }
@@ -626,7 +627,7 @@
 {
     struct context *c =3D &mi->context;
 
=
-    int peer_id =3D c->c2=2Etls_multi->peer_id;
+    int peer_id =3D c->c2=
=2Etls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D =
NULL;
     struct sockaddr_storage local =3D { 0 };
     const socket_descr=
iptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
@@ -706,7 +707,7 @@
     {
 #if=
 defined(_WIN32)
         dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, add=
r->v6=2Eaddr, addr->netbits,
-                                c->c2=2Etls_m=
ulti->peer_id);
+                                c->c2=2Etls_multi->rx_peer=
_id);
 #else
         const struct in6_addr *gateway =3D &mi->context=2Ec2=
=2Epush_ifconfig_ipv6_local;
         if (addr->type & MR_ONLINK_DCO_ADDR)
=
@@ -723,7 +724,7 @@
     {
 #if defined(_WIN32)
         dco_win_add_iroute=
_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits,
-              =
                  c->c2=2Etls_multi->peer_id);
+                           =
     c->c2=2Etls_multi->rx_peer_id);
 #else
         in_addr_t dest =3D hto=
nl(addr->v4=2Eaddr);
         const in_addr_t *gateway =3D &mi->context=2Ec=
2=2Epush_ifconfig_local;
diff --git a/src/openvpn/init=2Ec b/src/openvpn/in=
it=2Ec
index 914d191=2E=2Edb753dc 100644
--- a/src/openvpn/init=2Ec
+++ b/s=
rc/openvpn/init=2Ec
@@ -2207,9 +2207,10 @@
                    md_kt_name(o=
->authname));
     }
 
-    if (o->use_peer_id)
+    if (c->c2=2Etls_multi =
&& c->c2=2Etls_multi->use_peer_id)
     {
-        buf_printf(&out, ", peer=
-id: %d", o->peer_id);
+        buf_printf(&out, ", rx-peer-id: %u, tx-peer=
-id: %u", c->c2=2Etls_multi->rx_peer_id,
+                   c->c2=2Etls_mu=
lti->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2326,6 +2327,11 @@
     }
 =
#endif
 
+    /* The peer-id can also be negotiated without being pushed, s=
o sync the
+     * option before the frame is recalculated: it decides whet=
her the
+     * DATA_V2 header is accounted for */
+    c->options=2Euse_pe=
er_id =3D c->c2=2Etls_multi->use_peer_id;
+
     struct tls_session *sessio=
n =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
     if (!tls_session_update_=
crypto_params(c->c2=2Etls_multi, session, &c->options, &c->c2=2Eframe,
    =
                                       frame_fragment, get_link_socket_info=
(c),
@@ -2679,7 +2685,8 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPOR=
T: peer-id set");
         c->c2=2Etls_multi->use_peer_id =3D true;
-      =
  c->c2=2Etls_multi->peer_id =3D c->options=2Epeer_id;
+        c->c2=2Etls=
_multi->tx_peer_id =3D c->options=2Epeer_id;
+        c->c2=2Etls_multi->rx=
_peer_id =3D c->options=2Epeer_id;
     }
 
     /* process (potentially) p=
ushed options */
@@ -2706,7 +2713,7 @@
     /* Ensure that for epoch data f=
ormat is only enabled if also data v2
      * is enabled */
     bool epoch=
_data =3D c->options=2Eimported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT;
=
-    bool datav2_enabled =3D c->options=2Euse_peer_id && c->options=2Epeer_=
id < MAX_PEER_ID;
+    bool datav2_enabled =3D c->c2=2Etls_multi->use_peer_=
id && c->c2=2Etls_multi->tx_peer_id < MAX_PEER_ID;
 
     if (epoch_data &&=
 !datav2_enabled)
     {
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/mi=
sc=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/openvpn/misc=2Ec
+++ b/s=
rc/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
         chomp(line);
    =
     if (validate_peer_info_line(line)
-            && (strncmp(line, "IV_"=
, 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
+            && (strncm=
p(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0
+           =
     || strncmp(line, "ID", 2) =3D=3D 0))
         {
             msg(M_INF=
O, "peer info: %s", line);
             env_set_add(es, line);
         }
 =
        else
         {
-            msg(M_WARN, "validation failed on peer=
_info line received from client");
+            msg(M_WARN, "validation fai=
led on peer_info line received");
         }
     }
 }
diff --git a/src/ope=
nvpn/multi=2Ec b/src/openvpn/multi=2Ec
index fe2badb=2E=2Ef823f5b 100644
--=
- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -430,7 +430,7 @@
 =
        if (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)
=
             && dco_enabled(&mi->context=2Eoptions))
         {
-          =
  buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=2Etls_multi->peer_id);=

+            buf_printf(&out, " rx-peer-id=3D%d", mi->context=2Ec2=2Etls_m=
ulti->rx_peer_id);
         }
         return BSTR(&out);
     }
@@ -598,9 =
+598,9 @@
         }
 #endif
 
-        if (mi->context=2Ec2=2Etls_multi->p=
eer_id !=3D MAX_PEER_ID)
+        if (mi->context=2Ec2=2Etls_multi->rx_peer=
_id !=3D MAX_PEER_ID)
         {
-            m->instances[mi->context=2Ec2=
=2Etls_multi->peer_id] =3D NULL;
+            m->instances[mi->context=2Ec2=
=2Etls_multi->rx_peer_id] =3D NULL;
 
             /* Adjust the max_peerid=
 as this might have been the highest
              * peer id instance */
@@=
 -908,8 +908,7 @@
 #else
                         sep,
 #endif
-           =
             sep,
-                        mi->context=2Ec2=2Etls_multi ? m=
i->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+                       =
 sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->rx_peer_=
id : MAX_PEER_ID,
                         sep, translate_cipher_name_to_op=
envpn(mi->context=2Eoptions=2Eciphername));
                 }
            =
     gc_free(&gc);
@@ -3121,12 +3120,12 @@
          * has, so we disallow =
it=2E This can happen if a DCO netlink notification
          * gets lost a=
nd we miss a floating step=2E
          */
-        if (m1->peer_id =3D=3D =
m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
         {
=
             msg(M_WARN,
                 "disallowing peer %" PRIu32 " (%s=
) from floating to "
                 "its own address (%s)",
-            =
    m1->peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
+   =
             m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, =
false),
                 mroute_addr_print(&mi->real, &gc));
             g=
oto done;
         }
@@ -3139,7 +3138,8 @@
     }
 
     msg(D_MULTI_MEDIUM=
, "peer %" PRIu32 " (%s) floated from %s to %s",
-        mi->context=2Ec2=
=2Etls_multi->peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false)=
,
+        mi->context=2Ec2=2Etls_multi->rx_peer_id,
+        tls_common_na=
me(mi->context=2Ec2=2Etls_multi, false),
         mroute_addr_print_ex(&mi-=
>real, MAPF_SHOW_FAMILY, &gc),
         mroute_addr_print_ex(&real, MAPF_SH=
OW_FAMILY, &gc));
 
@@ -4099,7 +4099,7 @@
     {
         if (!m->instances=
[i])
         {
-            mi->context=2Ec2=2Etls_multi->peer_id =3D i;
+=
            mi->context=2Ec2=2Etls_multi->rx_peer_id =3D i;
             m-=
>instances[i] =3D mi;
             break;
         }
@@ -4108,11 +4108,11 @=
@
     /* should not really end up here, since multi_create_instance return=
s null
      * if amount of clients exceeds max_clients and this method wou=
ld then
      * also not have been called */
-    ASSERT(mi->context=2Ec2=
=2Etls_multi->peer_id < m->max_clients);
+    ASSERT(mi->context=2Ec2=2Etls=
_multi->rx_peer_id < m->max_clients);
 
-    if (mi->context=2Ec2=2Etls_mul=
ti->peer_id > m->max_peerid)
+    if (mi->context=2Ec2=2Etls_multi->rx_peer=
_id > m->max_peerid)
     {
-        m->max_peerid =3D mi->context=2Ec2=2Et=
ls_multi->peer_id;
+        m->max_peerid =3D mi->context=2Ec2=2Etls_multi-=
>rx_peer_id;
     }
 }
 
diff --git a/src/openvpn/options=2Eh b/src/openvpn=
/options=2Eh
index 2f7fe30=2E=2E30a146f 100644
--- a/src/openvpn/options=2E=
h
+++ b/src/openvpn/options=2Eh
@@ -697,6 +697,9 @@
     enum tun_driver_ty=
pe windows_driver;
 #endif
 
+    /** Whether the data channel uses the DAT=
A_V2 header (peer-id)=2E
+     *  Mirror of tls_multi->use_peer_id, needed =
by the MTU/frame calculation
+     *  which only has access to struct optio=
ns=2E */
     bool use_peer_id;
     uint32_t peer_id;
 
diff --git a/src/o=
penvpn/push=2Ec b/src/openvpn/push=2Ec
index e391147=2E=2E633c007d 100644
-=
-- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -661,9 +661,9 @@
  =
                       print_in_addr_t(c->c2=2Epush_ifconfig_remote_netmask=
, 0, gc));
     }
 
-    if (tls_multi->use_peer_id)
+    if (tls_multi->us=
e_peer_id && !tls_multi->use_asymmetric_peer_id)
     {
-        push_optio=
n_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->peer_id);
+        p=
ush_option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->rx_peer_id)=
;
     }
     /*
      * If server uses --auth-gen-token and we have an aut=
h token
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
=
index f57f54d=2E=2Ec927f26 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src=
/openvpn/push_util=2Ec
@@ -188,7 +188,7 @@
         unsigned int permission=
_mask =3D pull_permission_mask(c);
         if (process_push_update(c, &o, =
permission_mask, &option_types_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR=
)
         {
-            msg(M_WARN, "Failed to process push update messag=
e sent to client ID: %u", c->c2=2Etls_multi->peer_id);
+            msg(M_W=
ARN, "Failed to process push update message sent to client ID: %u", c->c2=
=2Etls_multi->rx_peer_id);
         }
         e =3D e->next;
     }
@@ -29=
4,7 +294,7 @@
 
         if (!support_push_update(mi))
         {
-        =
    msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported peer wit=
h ID: %u", mi->context=2Ec2=2Etls_multi->peer_id);
+            msg(M_CLIEN=
T, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi->=
context=2Ec2=2Etls_multi->rx_peer_id);
             buffer_list_free(msgs);=

             gc_free(&gc);
             return 0;
@@ -329,7 +329,7 @@
    =
     /* Type is UPT_BROADCAST so we update every client */
         if (!se=
nd_single_push_update(m, curr_mi, msgs))
         {
-            msg(M_CLIE=
NT, "ERROR: Peer ID: %u has not been updated", curr_mi->context=2Ec2=2Etls_=
multi->peer_id);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not bee=
n updated", curr_mi->context=2Ec2=2Etls_multi->rx_peer_id);
             co=
ntinue;
         }
         count++;
diff --git a/src/openvpn/ssl=2Ec b/src=
/openvpn/ssl=2Ec
index 60df7ce=2E=2E0db22b0 100644
--- a/src/openvpn/ssl=2E=
c
+++ b/src/openvpn/ssl=2Ec
@@ -1168,7 +1168,10 @@
     /* get command line=
 derived options */
     ret->opt =3D *tls_options;
     ret->dco_peer_id =
=3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+    ret->use_asymmetric_peer_id=
 =3D false;
+    /* The rx_peer_id is also used to identify DCO clients */
=
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    ret->tx_peer_id =3D MAX_PEER_ID;=

 
     return ret;
 }
@@ -1181,6 +1184,15 @@
 
     tls_session_init(multi=
, &multi->session[TM_ACTIVE]);
     tls_session_init(multi, &multi->session=
[TM_INITIAL]);
+
+    if (!multi->opt=2Edco_enabled)
+    {
+        /* Cal=
culate the asymmetric peer-id */
+        if (multi->rx_peer_id =3D=3D MAX_=
PEER_ID && multi->session[TM_INITIAL]=2Eopt->mode !=3D MODE_SERVER)
+      =
  {
+            multi->rx_peer_id =3D (uint32_t)(get_random() % (MAX_PEER_=
ID - 1));
+        }
+    }
 }
 
 /*
@@ -1858,6 +1870,25 @@
     return str=
;
 }
 
+static bool
+push_peer_info_peerid(struct buffer *out, struct tls_m=
ulti *multi, struct tls_session *session)
+{
+    if (multi->rx_peer_id =3D=
=3D MAX_PEER_ID || session->opt->dco_enabled)
+    {
+        /* No valid p=
eer id or DCO is enabled=2E Cannot use this feature */
+        return true=
;
+    }
+
+    /* In server mode we only add this when the client has anno=
unced its
+     * support for the feature */
+    if (session->opt->mode !=
=3D MODE_SERVER || multi->use_asymmetric_peer_id)
+    {
+        return bu=
f_printf(out, "ID=3D%x\n", multi->rx_peer_id);
+    }
+
+    return true;
+=
}
+
 /**
  * Prepares the IV_ and UV_ variables that are part of the
  * ex=
change to signal the peer's capabilities=2E The amount
@@ -1871,15 +1902,22=
 @@
  *
  * @param buf       the buffer to write these variables to
  * @pa=
ram session   the TLS session object
+ * @param multi     the TLS multi obj=
ect
  * @return          true if no error was encountered
  */
 static bool=

-push_peer_info(struct buffer *buf, struct tls_session *session)
+push_pee=
r_info(struct buffer *buf, struct tls_multi *multi, struct tls_session *ses=
sion)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D false;
   =
  struct buffer out =3D alloc_buf_gc(512 * 3, &gc);
 
+    /* The asymmetri=
c peer-id is always written when enabled */
+    if (!push_peer_info_peerid=
(&out, multi, session))
+    {
+        goto error;
+    }
+
     if (sessi=
on->opt->push_peer_info_detail > 1)
     {
         /* push version */
@@ -=
2019,7 +2057,11 @@
                 }
             }
         }
+    }
 
+ =
   /* write peer info string if there is anything in it, empty string other=
wise */
+    if (BLEN(&out) > 0)
+    {
         if (!write_string(buf, BST=
R(&out), -1))
         {
             goto error;
@@ -2027,7 +2069,7 @@
   =
  }
     else
     {
-        if (!write_empty_string(buf)) /* no peer info=
 */
+        if (!write_empty_string(buf))
         {
             goto err=
or;
         }
@@ -2156,7 +2198,7 @@
         }
     }
 
-    if (!push_pee=
r_info(buf, session))
+    if (!push_peer_info(buf, multi, session))
     {=

         goto error;
     }
@@ -2269,6 +2311,19 @@
     if (multi->peer_in=
fo)
     {
         output_peer_info_env(session->opt->es, multi->peer_info=
);
+        uint32_t peer_id =3D extract_asymmetric_peer_id(multi->peer_inf=
o);
+        if (peer_id !=3D MAX_PEER_ID && !session->opt->dco_enabled)
+ =
       {
+            multi->tx_peer_id =3D peer_id;
+            multi->us=
e_asymmetric_peer_id =3D true;
+            multi->use_peer_id =3D true;
+ =
       }
+        else
+        {
+            /* Peer has no support for a=
symmetric peer-id, and DCO currently
+             * can only handle symmet=
ric peer IDs */
+            multi->tx_peer_id =3D multi->rx_peer_id;
+    =
    }
     }
 
     free(multi->remote_ciphername);
@@ -4016,8 +4071,8 @@
 =
    msg(D_TLS_DEBUG, __func__);
 
     ASSERT(ks);
-
-    peer =3D htonl(((=
P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24 | (multi->peer_id & 0xFFFF=
FF));
+    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 2=
4
+                 | (multi->tx_peer_id & 0xFFFFFF));
     ASSERT(buf_writ=
e_prepend(buf, &peer, 4));
 }
 
diff --git a/src/openvpn/ssl_common=2Eh b/s=
rc/openvpn/ssl_common=2Eh
index 9c90242=2E=2Ef6392f9 100644
--- a/src/openv=
pn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -696,8 +696,10 @@
 #d=
efine AUTH_TOKEN_VALID_EMPTYUSER (1 << 2)
 
     /* For P_DATA_V2 */
-    u=
int32_t peer_id;
+    uint32_t rx_peer_id;
+    uint32_t tx_peer_id;
     b=
ool use_peer_id;
+    bool use_asymmetric_peer_id;
 
     char *remote_ciph=
ername; /**< cipher specified in peer's config file */
     bool remote_use=
scomp;    /**< remote announced comp-lzo in OCC string */
diff --git a/src/=
openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index baf5a95=2E=2Eb450de8 10=
0644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -408,6 =
+408,7 @@
 {
     /* will return 0 if peer_info is null */
     const unsig=
ned int iv_proto_peer =3D extract_iv_proto(multi->peer_info);
+    const un=
signed int tx_peer_id =3D extract_asymmetric_peer_id(multi->peer_info);
 
 =
    /* The other peer does not support P2P NCP */
     if (!(iv_proto_peer =
& IV_PROTO_NCP_P2P))
@@ -418,7 +419,6 @@
     if (iv_proto_peer & IV_PROTO_=
DATA_V2)
     {
         multi->use_peer_id =3D true;
-        multi->peer_=
id =3D 0x76706e; /* 'v' 'p' 'n' */
     }
 
     if (iv_proto_peer & IV_PRO=
TO_CC_EXIT_NOTIFY)
@@ -441,27 +441,42 @@
     if (iv_proto_peer & IV_PROTO_=
TLS_KEY_EXPORT)
     {
         session->opt->crypto_flags |=3D CO_USE_TLS_=
KEY_MATERIAL_EXPORT;
+    }
 
-        if (multi->use_peer_id)
+    if (mul=
ti->use_peer_id)
+    {
+        /* The asymmetric peer-id trumps on the EK=
M generated ones */
+        if ((iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
=
+            && (tx_peer_id !=3D MAX_PEER_ID) && !multi->opt=2Edco_enabled)=

         {
+            multi->tx_peer_id =3D tx_peer_id;
+            mul=
ti->use_asymmetric_peer_id =3D true;
+        }
+        else
+        {
+ =
           uint8_t peerid[3];
             /* Using a non hardcoded peer-id=
 makes a tiny bit harder to
              * fingerprint packets and also gi=
ves each connection a unique
              * peer-id that can be useful for=
 NAT tracking etc=2E */
-
-            uint8_t peerid[3];
-            if (=
!key_state_export_keying_material(session, EXPORT_P2P_PEERID_LABEL,
-      =
                                            strlen(EXPORT_P2P_PEERID_LABEL)=
, &peerid, 3))
+            if ((iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
+=
                && key_state_export_keying_material(session, EXPORT_P2P_PEE=
RID_LABEL,
+                                                    strlen(EXPO=
RT_P2P_PEERID_LABEL), &peerid, 3))
             {
-                /* Non D=
CO setup might still work but also this should never
-                 * ha=
ppen or very likely the TLS encryption key exporter will
-                 =
* also fail */
-                msg(M_NONFATAL, "TLS key export for P2P pee=
r id failed=2E "
-                                "Continuing anyway, expec=
t problems");
+                multi->rx_peer_id =3D (peerid[0] << 16) + (p=
eerid[1] << 8) + peerid[2];
             }
             else
             {=

-                multi->peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) +=
 peerid[2];
+                if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
+=
                {
+                    /* Non DCO setup might still work bu=
t also this should never
+                     * happen or very likely the =
TLS encryption key exporter will
+                     * also fail */
+    =
                msg(M_NONFATAL, "TLS key export for P2P peer id failed=2E "=

+                                    "Continuing anyway, expect problems")=
;
+                }
+                multi->rx_peer_id =3D 0x76706e; /* 'v=
' 'p' 'n' */
             }
+            multi->tx_peer_id =3D multi->rx_pe=
er_id;
         }
     }
     if (iv_proto_peer & IV_PROTO_DYN_TLS_CRYPT)
@=
@ -502,11 +517,13 @@
         common_cipher =3D BSTR(&out);
     }
 
-    m=
sg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP negotiation result: "
-        "=
TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%s",
-     =
   (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT), mul=
ti->use_peer_id,
-        multi->peer_id, (bool)(session->opt->crypto_flags=
 & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D_TLS_DEBUG_LOW, "P2P mode NCP negot=
iation result: "
+                         "TLS_export=3D%d, DATA_v2=3D%d, =
rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s",
+        (bool)(ses=
sion->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
+        multi->=
use_peer_id,
+        multi->rx_peer_id,
+        multi->tx_peer_id,
+     =
   (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
         =
common_cipher);
 
     gc_free(&gc);
diff --git a/src/openvpn/ssl_util=2Ec =
b/src/openvpn/ssl_util=2Ec
index 71fbc9e=2E=2E2f01f8a 100644
--- a/src/open=
vpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -24,7 +24,7 @@
 #endif
 =

 #include "syshead=2Eh"
-
+#include "openvpn=2Eh"
 #include "ssl_util=2Eh"=

 
 char *
@@ -72,6 +72,25 @@
     return 0;
 }
 
+uint32_t
+extract_asymme=
tric_peer_id(const char *peer_info)
+{
+    for (const char *p =3D peer_inf=
o; p && (p =3D strstr(p, "ID=3D")); p +=3D 3)
+    {
+        /* only accep=
t "ID=3D" at the start of a line, so it does not match
+         * substrin=
gs like "UV_ID=3D" or "GUID=3D" */
+        if (p =3D=3D peer_info || p[-1]=
 =3D=3D '\n')
+        {
+            uint32_t peer_id =3D 0;
+            =
if (sscanf(p, "ID=3D%x", &peer_id) =3D=3D 1 && peer_id < MAX_PEER_ID)
+    =
        {
+                return peer_id;
+            }
+        }
+    }=

+    return MAX_PEER_ID;
+}
+
 const char *
 options_string_compat_lzo(con=
st char *options, struct gc_arena *gc)
 {
diff --git a/src/openvpn/ssl_util=
=2Eh b/src/openvpn/ssl_util=2Eh
index 2177d94=2E=2E1a69e6f 100644
--- a/src=
/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
@@ -53,6 +53,15 @@
  *=
/
 unsigned int extract_iv_proto(const char *peer_info);
 
+
+/**
+ * Extra=
cts the ID variable and returns its value or
+ * MAX_PEER_ID if it cannot b=
e extracted=2E
+ *
+ * @param peer_info     peer info string to search for =
ID
+ */
+uint32_t extract_asymmetric_peer_id(const char *peer_info);
+
 /**=

  * Takes a locally produced OCC string for TLS server mode and modifies a=
s
  * if the option comp-lzo was enabled=2E This is to send a client in

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20e=
abcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 29
Gerrit=
-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@=
greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@=
mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: its_Giaa=
n <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>

--e8L2Spv9kYs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, ordex, plaisthos=2E <=
/p>
<p>its_Giaan <strong>uploaded patch set #29</strong> to this change=2E<=
/p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail=
">View Change</a></p><p>The following approvals got outdated and were remov=
ed:
Code-Review-1 by cron2, Code-Review-1 by plaisthos</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mul=
tipeer: introduce asymmetric peer-id<br><br>In order to achieve a multipeer=
 functionality, peers now<br>use separate IDs for sending (tx_peer_id) and =
receiving<br>(rx_peer_id)=2E<br><br>Each peer announces its own ID through =
pushing peer-info<br>using &#39;ID=3D7f1&#39; hex format so identification =
can still<br>happen even if IP/port changes=2E<br><br>In P2P mode, peer swi=
tch to using the announced IDs after<br>mutual exchange=2E<br>In P2MP mode,=
 clients always announce their ID, and servers<br>can optionally respond wi=
th their own to enable the same<br>behavior=2E<br><br>Change-Id: I0a13ee90b=
6706acf20eabcee3bab3f2dff639bf9<br>Signed-off-by: Gianmarco De Gregori &lt;=
gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/open=
vpn/init=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/multi=2Ec<br>M src/=
openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push_util=2E=
c<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M src/openvpn=
/ssl_ncp=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh<br=
>12 files changed, 168 insertions(+), 54 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1=
089/29</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span=
><br><span>index 2584368=2E=2Ece73701 100644</span><br><span>--- a/src/open=
vpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -5=
44,14 +544,15 @@</span><br><span>         c-&gt;c2=2Etls_multi-&gt;dco_peer=
_id =3D -1;</span><br><span>     }</span><br><span> #endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_peer(&amp;c-&g=
t;c1=2Etuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                           proto_is_=
dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL, NULL, NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_new_peer(&am=
p;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NULL,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           NULL, N=
ULL);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</span><br=
><span>         return ret;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Etls_multi-&gt=
;dco_peer_id =3D multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi-&gt;rx_p=
eer_id;</span><br><span> </span><br><span>     return 0;</span><br><span> }=
</span><br><span>@@ -626,7 +627,7 @@</span><br><span> {</span><br><span>   =
  struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =3D c-&gt;c2=2Etls=
_multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><br><span>  =
   struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span>     s=
truct sockaddr_storage local =3D { 0 };</span><br><span>     const socket_d=
escriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><br><span>@@ -7=
06,7 +707,7 @@</span><br><span>     {</span><br><span> #if defined(_WIN32)<=
/span><br><span>         dco_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt=
;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                c-&gt;c2=2Etls_multi-=
&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                          c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><=
span> #else</span><br><span>         const struct in6_addr *gateway =3D &am=
p;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span>         =
if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><span>@@ -723,7 +724,=
7 @@</span><br><span>     {</span><br><span> #if defined(_WIN32)</span><br>=
<span>         dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr=
-&gt;v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                c-&gt;c2=2Etls_multi-&gt;peer_i=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #els=
e</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4=2Eaddr);</s=
pan><br><span>         const in_addr_t *gateway =3D &amp;mi-&gt;context=2Ec=
2=2Epush_ifconfig_local;</span><br><span>diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec</span><br><span>index 914d191=2E=2Edb753dc 100644</s=
pan><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/=
init=2Ec</span><br><span>@@ -2207,9 +2207,10 @@</span><br><span>           =
         md_kt_name(o-&gt;authname));</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;use_=
peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&=
gt;c2=2Etls_multi &amp;&amp; c-&gt;c2=2Etls_multi-&gt;use_peer_id)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 buf_printf(&amp;out, &quot;, peer-id: %d&quot;, o-&gt;peer_id);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &=
quot;, rx-peer-id: %u, tx-peer-id: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_pe=
er_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
      c-&gt;c2=2Etls_multi-&gt;tx_peer_id);</span><br><span>     }</span><b=
r><span> </span><br><span> #ifdef USE_COMP</span><br><span>@@ -2326,6 +2327=
,11 @@</span><br><span>     }</span><br><span> #endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The peer-id can =
also be negotiated without being pushed, so sync the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * option before the frame is recalcu=
lated: it decides whether the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * DATA_V2 header is accounted for */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Euse_peer_id =3D c-&gt=
;c2=2Etls_multi-&gt;use_peer_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     struct tls_session *session =3D &amp;c-&=
gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span>     if (!tls_ses=
sion_update_crypto_params(c-&gt;c2=2Etls_multi, session, &amp;c-&gt;options=
, &amp;c-&gt;c2=2Eframe,</span><br><span>                                  =
         frame_fragment, get_link_socket_info(c),</span><br><span>@@ -2679,=
7 +2685,8 @@</span><br><span>     {</span><br><span>         msg(D_PUSH_DEB=
UG, &quot;OPTIONS IMPORT: peer-id set&quot;);</span><br><span>         c-&g=
t;c2=2Etls_multi-&gt;use_peer_id =3D true;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        c-&gt;c2=2Etls_multi-&gt;peer_id =3D c-&gt;opt=
ions=2Epeer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    c-&gt;c2=2Etls_multi-&gt;tx_peer_id =3D c-&gt;options=2Epeer_id;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Etls_mul=
ti-&gt;rx_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span>     }</span=
><br><span> </span><br><span>     /* process (potentially) pushed options *=
/</span><br><span>@@ -2706,7 +2713,7 @@</span><br><span>     /* Ensure that=
 for epoch data format is only enabled if also data v2</span><br><span>    =
  * is enabled */</span><br><span>     bool epoch_data =3D c-&gt;options=2E=
imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    bool datav2_enabled =3D c-&gt;options=
=2Euse_peer_id &amp;&amp; c-&gt;options=2Epeer_id &lt; MAX_PEER_ID;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    bool datav2_enabled =3D=
 c-&gt;c2=2Etls_multi-&gt;use_peer_id &amp;&amp; c-&gt;c2=2Etls_multi-&gt;t=
x_peer_id &lt; MAX_PEER_ID;</span><br><span> </span><br><span>     if (epoc=
h_data &amp;&amp; !datav2_enabled)</span><br><span>     {</span><br><span>d=
iff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>ind=
ex 10bfc35=2E=2Ea8c88c9 100644</span><br><span>--- a/src/openvpn/misc=2Ec</=
span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -765,14 +765,1=
5 @@</span><br><span>     {</span><br><span>         chomp(line);</span><br=
><span>         if (validate_peer_info_line(line)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            &amp;&amp; (strncmp(line, &quot;IV_=
&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (str=
ncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3=
) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       || strncmp(line, &quot;ID&quot;, 2) =3D=3D 0))</span><br><span>     =
    {</span><br><span>             msg(M_INFO, &quot;peer info: %s&quot;, l=
ine);</span><br><span>             env_set_add(es, line);</span><br><span> =
        }</span><br><span>         else</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;=
validation failed on peer_info line received from client&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;=
validation failed on peer_info line received&quot;);</span><br><span>      =
   }</span><br><span>     }</span><br><span> }</span><br><span>diff --git a=
/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index fe2bad=
b=2E=2Ef823f5b 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br=
><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -430,7 +430,7 @@</spa=
n><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; check_d=
ebug_level(D_DCO_DEBUG)</span><br><span>             &amp;&amp; dco_enabled=
(&amp;mi-&gt;context=2Eoptions))</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quo=
t; peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&am=
p;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx=
_peer_id);</span><br><span>         }</span><br><span>         return BSTR(=
&amp;out);</span><br><span>     }</span><br><span>@@ -598,9 +598,9 @@</span=
><br><span>         }</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=
=2Etls_multi-&gt;peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_p=
eer_id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            m-&gt;instances[mi-&gt;context=
=2Ec2=2Etls_multi-&gt;peer_id] =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            m-&gt;instances[mi-&gt;context=2Ec2=2Etls_=
multi-&gt;rx_peer_id] =3D NULL;</span><br><span> </span><br><span>         =
    /* Adjust the max_peerid as this might have been the highest</span><br>=
<span>              * peer id instance */</span><br><span>@@ -908,8 +908,7 =
@@</span><br><span> #else</span><br><span>                         sep,</sp=
an><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       sep,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;cont=
ext=2Ec2=2Etls_multi-&gt;peer_id : UINT32_MAX,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        sep, mi-&gt;context=2Ec2=
=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id : MAX_PEER_ID=
,</span><br><span>                         sep, translate_cipher_name_to_op=
envpn(mi-&gt;context=2Eoptions=2Eciphername));</span><br><span>            =
     }</span><br><span>                 gc_free(&amp;gc);</span><br><span>@=
@ -3121,12 +3120,12 @@</span><br><span>          * has, so we disallow it=
=2E This can happen if a DCO netlink notification</span><br><span>         =
 * gets lost and we miss a floating step=2E</span><br><span>          */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m1-&gt;peer_=
id =3D=3D m2-&gt;peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><sp=
an>         {</span><br><span>             msg(M_WARN,</span><br><span>    =
             &quot;disallowing peer %&quot; PRIu32 &quot; (%s) from floatin=
g to &quot;</span><br><span>                 &quot;its own address (%s)&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m1=
-&gt;peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                m1-&gt;r=
x_peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><=
br><span>                 mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</s=
pan><br><span>             goto done;</span><br><span>         }</span><br>=
<span>@@ -3139,7 +3138,8 @@</span><br><span>     }</span><br><span> </span>=
<br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%s) fl=
oated from %s to %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id, tls_common_name(m=
i-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_common_=
name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span>         mrou=
te_addr_print_ex(&amp;mi-&gt;real, MAPF_SHOW_FAMILY, &amp;gc),</span><br><s=
pan>         mroute_addr_print_ex(&amp;real, MAPF_SHOW_FAMILY, &amp;gc));</=
span><br><span> </span><br><span>@@ -4099,7 +4099,7 @@</span><br><span>    =
 {</span><br><span>         if (!m-&gt;instances[i])</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&g=
t;context=2Ec2=2Etls_multi-&gt;peer_id =3D i;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Etls_multi-&gt;r=
x_peer_id =3D i;</span><br><span>             m-&gt;instances[i] =3D mi;</s=
pan><br><span>             break;</span><br><span>         }</span><br><spa=
n>@@ -4108,11 +4108,11 @@</span><br><span>     /* should not really end up =
here, since multi_create_instance returns null</span><br><span>      * if a=
mount of clients exceeds max_clients and this method would then</span><br><=
span>      * also not have been called */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ASSERT(mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id =
&lt; m-&gt;max_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ASSERT(mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id &lt; m-&gt;m=
ax_clients);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id &gt; m-&gt;max=
_peerid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-=
&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id &gt; m-&gt;max_peerid)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 m-&gt;max_peerid =3D mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;max_peerid =3D=
 mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id;</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/=
options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 2f7fe30=2E=2E30=
a146f 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>=
+++ b/src/openvpn/options=2Eh</span><br><span>@@ -697,6 +697,9 @@</span><br=
><span>     enum tun_driver_type windows_driver;</span><br><span> #endif</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/** Whether the data channel uses the DATA_V2 header (peer-id)=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     *  Mirror of tls_multi-&=
gt;use_peer_id, needed by the MTU/frame calculation</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     *  which only has access to struct o=
ptions=2E */</span><br><span>     bool use_peer_id;</span><br><span>     ui=
nt32_t peer_id;</span><br><span> </span><br><span>diff --git a/src/openvpn/=
push=2Ec b/src/openvpn/push=2Ec</span><br><span>index e391147=2E=2E633c007d=
 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/sr=
c/openvpn/push=2Ec</span><br><span>@@ -661,9 +661,9 @@</span><br><span>    =
                     print_in_addr_t(c-&gt;c2=2Epush_ifconfig_remote_netmas=
k, 0, gc));</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (tls_multi-&gt;use_peer_id)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_multi-&gt;use_pe=
er_id &amp;&amp; !tls_multi-&gt;use_asymmetric_peer_id)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        push_optio=
n_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;peer_id=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_opti=
on_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;rx_pee=
r_id);</span><br><span>     }</span><br><span>     /*</span><br><span>     =
 * If server uses --auth-gen-token and we have an auth token</span><br><spa=
n>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span>=
<br><span>index f57f54d=2E=2Ec927f26 100644</span><br><span>--- a/src/openv=
pn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br>=
<span>@@ -188,7 +188,7 @@</span><br><span>         unsigned int permission_=
mask =3D pull_permission_mask(c);</span><br><span>         if (process_push=
_update(c, &amp;o, permission_mask, &amp;option_types_found, &amp;tmp_msg, =
true) =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Failed to p=
rocess push update message sent to client ID: %u&quot;, c-&gt;c2=2Etls_mult=
i-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_WARN, &quot;Failed to process push update message sent to cli=
ent ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span>   =
      }</span><br><span>         e =3D e-&gt;next;</span><br><span>     }</=
span><br><span>@@ -294,7 +294,7 @@</span><br><span> </span><br><span>      =
   if (!support_push_update(mi))</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;PUSH_=
UPDATE: not sending message to unsupported peer with ID: %u&quot;, mi-&gt;c=
ontext=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(M_CLIENT, &quot;PUSH_UPDATE: not sending =
message to unsupported peer with ID: %u&quot;, mi-&gt;context=2Ec2=2Etls_mu=
lti-&gt;rx_peer_id);</span><br><span>             buffer_list_free(msgs);</=
span><br><span>             gc_free(&amp;gc);</span><br><span>             =
return 0;</span><br><span>@@ -329,7 +329,7 @@</span><br><span>         /* T=
ype is UPT_BROADCAST so we update every client */</span><br><span>         =
if (!send_single_push_update(m, curr_mi, msgs))</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIE=
NT, &quot;ERROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_CLIENT, &quot;ERROR: Peer ID: %u has not bee=
n updated&quot;, curr_mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</spa=
n><br><span>             continue;</span><br><span>         }</span><br><sp=
an>         count++;</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src=
/openvpn/ssl=2Ec</span><br><span>index 60df7ce=2E=2E0db22b0 100644</span><b=
r><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec=
</span><br><span>@@ -1168,7 +1168,10 @@</span><br><span>     /* get command=
 line derived options */</span><br><span>     ret-&gt;opt =3D *tls_options;=
</span><br><span>     ret-&gt;dco_peer_id =3D -1;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    ret-&gt;peer_id =3D MAX_PEER_ID;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;use_asymmetric_pee=
r_id =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* The rx_peer_id is also used to identify DCO clients */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;rx_peer_id =3D MAX_PEER_I=
D;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;tx_pe=
er_id =3D MAX_PEER_ID;</span><br><span> </span><br><span>     return ret;</=
span><br><span> }</span><br><span>@@ -1181,6 +1184,15 @@</span><br><span> <=
/span><br><span>     tls_session_init(multi, &amp;multi-&gt;session[TM_ACTI=
VE]);</span><br><span>     tls_session_init(multi, &amp;multi-&gt;session[T=
M_INITIAL]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=2Ed=
co_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Calculate t=
he asymmetric peer-id */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp;&amp; multi-&=
gt;session[TM_INITIAL]=2Eopt-&gt;mode !=3D MODE_SERVER)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            multi-&gt;rx_peer_id =3D (uint32_t)(g=
et_random() % (MAX_PEER_ID - 1));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span> }</span><br><span> </span><br><span> /*</span><b=
r><span>@@ -1858,6 +1870,25 @@</span><br><span>     return str;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pu=
sh_peer_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls=
_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;r=
x_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_enabled)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* No valid peer id or DCO is enable=
d=2E Cannot use this feature */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mod=
e we only add this when the client has announced its</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * support for the feature */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt=
;mode !=3D MODE_SERVER || multi-&gt;use_asymmetric_peer_id)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return buf_printf(out, &quot;ID=3D%x\n&qu=
ot;, multi-&gt;rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Prep=
ares the IV_ and UV_ variables that are part of the</span><br><span>  * exc=
hange to signal the peer&#39;s capabilities=2E The amount</span><br><span>@=
@ -1871,15 +1902,22 @@</span><br><span>  *</span><br><span>  * @param buf  =
     the buffer to write these variables to</span><br><span>  * @param sess=
ion   the TLS session object</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param multi     the TLS multi object</span><br><span>  * @retu=
rn          true if no error was encountered</span><br><span>  */</span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pu=
sh_peer_info(struct buffer *buf, struct tls_session *session)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+push_peer_info(struct buffer *buf=
, struct tls_multi *multi, struct tls_session *session)</span><br><span> {<=
/span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     =
bool ret =3D false;</span><br><span>     struct buffer out =3D alloc_buf_gc=
(512 * 3, &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* The asymmetric peer-id is always written when enab=
led */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!push=
_peer_info_peerid(&amp;out, multi, session))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto error;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     if (session-&gt;opt-&gt;push_peer_info_detail &gt; 1)</s=
pan><br><span>     {</span><br><span>         /* push version */</span><br>=
<span>@@ -2019,7 +2057,11 @@</span><br><span>                 }</span><br><=
span>             }</span><br><span>         }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* write peer info string if there is an=
ything in it, empty string otherwise */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (BLEN(&amp;out) &gt; 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span>         if (!write_st=
ring(buf, BSTR(&amp;out), -1))</span><br><span>         {</span><br><span> =
            goto error;</span><br><span>@@ -2027,7 +2069,7 @@</span><br><sp=
an>     }</span><br><span>     else</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (!write_empty_string(buf)) =
/* no peer info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (!write_empty_string(buf))</span><br><span>         {</span><br><=
span>             goto error;</span><br><span>         }</span><br><span>@@=
 -2156,7 +2198,7 @@</span><br><span>         }</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
push_peer_info(buf, session))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!push_peer_info(buf, multi, session))</span><br><span>   =
  {</span><br><span>         goto error;</span><br><span>     }</span><br><=
span>@@ -2269,6 +2311,19 @@</span><br><span>     if (multi-&gt;peer_info)</=
span><br><span>     {</span><br><span>         output_peer_info_env(session=
-&gt;opt-&gt;es, multi-&gt;peer_info);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        uint32_t peer_id =3D extract_asymmetric_peer_id(=
multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (peer_id !=3D MAX_PEER_ID &amp;&amp; !session-&gt;opt-&gt;dco_=
enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt=
;tx_peer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            multi-&gt;use_asymmetric_peer_id =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;use_peer_id =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* Peer has no support fo=
r asymmetric peer-id, and DCO currently</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+             * can only handle symmetric peer IDs */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;=
tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </span><=
br><span>     free(multi-&gt;remote_ciphername);</span><br><span>@@ -4016,8=
 +4071,8 @@</span><br><span>     msg(D_TLS_DEBUG, __func__);</span><br><spa=
n> </span><br><span>     ASSERT(ks);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pe=
er =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt;=
 24 | (multi-&gt;peer_id &amp; 0xFFFFFF));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHI=
FT) | ks-&gt;key_id) &lt;&lt; 24</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                 | (multi-&gt;tx_peer_id &amp; 0xFFFFFF));</sp=
an><br><span>     ASSERT(buf_write_prepend(buf, &amp;peer, 4));</span><br><=
span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_comm=
on=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 9c90242=2E=2Ef639=
2f9 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span=
>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -696,8 +696,10 @@</spa=
n><br><span> #define AUTH_TOKEN_VALID_EMPTYUSER (1 &lt;&lt; 2)</span><br><s=
pan> </span><br><span>     /* For P_DATA_V2 */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    uint32_t peer_id;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint32_t rx_peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t tx_peer_id;</span><br><span>=
     bool use_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool use_asymmetric_peer_id;</span><br><span> </span><br><span>     =
char *remote_ciphername; /**&lt; cipher specified in peer&#39;s config file=
 */</span><br><span>     bool remote_usescomp;    /**&lt; remote announced =
comp-lzo in OCC string */</span><br><span>diff --git a/src/openvpn/ssl_ncp=
=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index baf5a95=2E=2Eb450de8 1=
00644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl_ncp=2Ec</span><br><span>@@ -408,6 +408,7 @@</span><br><span>=
 {</span><br><span>     /* will return 0 if peer_info is null */</span><br>=
<span>     const unsigned int iv_proto_peer =3D extract_iv_proto(multi-&gt;=
peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t unsigned int tx_peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_inf=
o);</span><br><span> </span><br><span>     /* The other peer does not suppo=
rt P2P NCP */</span><br><span>     if (!(iv_proto_peer &amp; IV_PROTO_NCP_P=
2P))</span><br><span>@@ -418,7 +419,6 @@</span><br><span>     if (iv_proto_=
peer &amp; IV_PROTO_DATA_V2)</span><br><span>     {</span><br><span>       =
  multi-&gt;use_peer_id =3D true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        multi-&gt;peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#=
39; &#39;n&#39; */</span><br><span>     }</span><br><span> </span><br><span=
>     if (iv_proto_peer &amp; IV_PROTO_CC_EXIT_NOTIFY)</span><br><span>@@ -=
441,27 +441,42 @@</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_TLS=
_KEY_EXPORT)</span><br><span>     {</span><br><span>         session-&gt;op=
t-&gt;crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt;use_peer_id)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;use_=
peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The asymmetric=
 peer-id trumps on the EKM generated ones */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if ((iv_proto_peer &amp; IV_PROTO_TLS_KEY_=
EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&amp;&amp; (tx_peer_id !=3D MAX_PEER_ID) &amp;&amp; !multi-&gt;opt=2Edco_en=
abled)</span><br><span>         {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            multi-&gt;tx_peer_id =3D tx_peer_id;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;use_asymme=
tric_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint8_t peer=
id[3];</span><br><span>             /* Using a non hardcoded peer-id makes =
a tiny bit harder to</span><br><span>              * fingerprint packets an=
d also gives each connection a unique</span><br><span>              * peer-=
id that can be useful for NAT tracking etc=2E */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            uint8_t peerid[3];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (!key_state_export_keying_material(session, E=
XPORT_P2P_PEERID_LABEL,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                                  strlen(EXPORT_P2P_PEERI=
D_LABEL), &amp;peerid, 3))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if ((iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp;=
 key_state_export_keying_material(session, EXPORT_P2P_PEERID_LABEL,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                         strlen(EXPORT_P2P_PEERID_LABEL), &amp;peerid, 3))<=
/span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                /* Non DCO setup might still work but also this sh=
ould never</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
      * happen or very likely the TLS encryption key exporter will</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                 * also fail *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(=
M_NONFATAL, &quot;TLS key export for P2P peer id failed=2E &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
 &quot;Continuing anyway, expect problems&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                multi-&gt;rx_peer_id =3D (pee=
rid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span> =
            }</span><br><span>             else</span><br><span>           =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mu=
lti-&gt;peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peer=
id[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    /* Non DCO setup migh=
t still work but also this should never</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                     * happen or very likely the TLS en=
cryption key exporter will</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     * also fail */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    msg(M_NONFATAL, &quot;TLS key ex=
port for P2P peer id failed=2E &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                    &quot;Continuing anyw=
ay, expect problems&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#3=
9;p&#39; &#39;n&#39; */</span><br><span>             }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D mul=
ti-&gt;rx_peer_id;</span><br><span>         }</span><br><span>     }</span>=
<br><span>     if (iv_proto_peer &amp; IV_PROTO_DYN_TLS_CRYPT)</span><br><s=
pan>@@ -502,11 +517,13 @@</span><br><span>         common_cipher =3D BSTR(&=
amp;out);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_TLS_DEBUG_LOW,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        &quot;P2P mode NCP negotiation resu=
lt: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &qu=
ot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%s&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (bool)(sessi=
on-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT), multi-&g=
t;use_peer_id,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 multi-&gt;peer_id, (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_=
DATA_KEY_FORMAT),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiation result: &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                         &=
quot;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%=
d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATE=
RIAL_EXPORT),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  multi-&gt;use_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi-&gt;rx_peer_id,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        multi-&gt;tx_peer_id,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto_flags &a=
mp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span>         common_cipher);</sp=
an><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span>diff =
--git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec</span><br><span=
>index 71fbc9e=2E=2E2f01f8a 100644</span><br><span>--- a/src/openvpn/ssl_ut=
il=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=2Ec</span><br><span>@@ -2=
4,7 +24,7 @@</span><br><span> #endif</span><br><span> </span><br><span> #in=
clude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;openvpn=2Eh&quot;</span><br><span> #include &quot;ssl_util=2Eh&quot;</s=
pan><br><span> </span><br><span> char *</span><br><span>@@ -72,6 +72,25 @@<=
/span><br><span>     return 0;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_t</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+extract_asymmetric_peer_id(const char =
*peer_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const char *p =3D=
 peer_info; p &amp;&amp; (p =3D strstr(p, &quot;ID=3D&quot;)); p +=3D 3)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* only accept &quot;ID=3D&q=
uot; at the start of a line, so it does not match</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * substrings like &quot;UV_ID=3D&quo=
t; or &quot;GUID=3D&quot; */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (p =3D=3D peer_info || p[-1] =3D=3D &#39;\n&#39;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            uint32_t peer_id =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (ssc=
anf(p, &quot;ID=3D%x&quot;, &amp;peer_id) =3D=3D 1 &amp;&amp; peer_id &lt; =
MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   return peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return MAX_PEER_ID;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br><spa=
n> options_string_compat_lzo(const char *options, struct gc_arena *gc)</spa=
n><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_util=2Eh b/src/=
openvpn/ssl_util=2Eh</span><br><span>index 2177d94=2E=2E1a69e6f 100644</spa=
n><br><span>--- a/src/openvpn/ssl_util=2Eh</span><br><span>+++ b/src/openvp=
n/ssl_util=2Eh</span><br><span>@@ -53,6 +53,15 @@</span><br><span>  */</spa=
n><br><span> unsigned int extract_iv_proto(const char *peer_info);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Extracts the ID variable and returns its v=
alue or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * MAX_PEER_=
ID if it cannot be extracted=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram peer_info     peer info string to search for ID</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+uint32_t extract_asymmetric_peer_id(const char *peer_info=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /**</span><br><span>  * Takes a locally produced OCC string for TLS server=
 mode and modifies as</span><br><span>  * if the option comp-lzo was enable=
d=2E This is to send a client in</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Dem=
ail">change 1089</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 29 </div>
<div style=3D"display:none"> Gerrit-Owner=
: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex=
 &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--e8L2Spv9kYs=--


--===============7996996331244609949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7996996331244609949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7996996331244609949==--

