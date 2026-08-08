Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1D5C55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aoWtOJa1kisXIF8qRblyK15A3jegBxtqnJpIdGRl56o=; b=P/EkjVHec04dRKl2u+TaiAlUq+
	HYZBK7ZufZEbdCP7kpX379mgsfyCQgm6+wEJNBhw2fsp2N5fwYWokjgSB12v0BeLBDQtxkoEG9RP+
	Z6e9QkY9VEJ+bLAe/hHVbFAGu5v5EP/y6nHJgG4TzwZ4fMSR2rh5OScir5g+mY6QGxxs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsjDX-0006yR-H1;
	Sat, 08 Aug 2026 15:44:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsjDV-0006yK-Md
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U1l40CS6fsOIWL6AgLRqC2p535cI8cZgUCaqAZ0Y/g4=; b=mAG8A8BSPmPEzgA1uisoP7jKib
 2nDYNlRhaniN1Zf+w/GkslwLS/5+tZyfD17Y3CKE+eaA+Y5symZxztQ37hLA9ChHg0pi1kjDApwET
 iSOkilVGwQdEVsyTNTQUxMp7PNsCI8qjV9qI8JcwmZel2VU1BxXOyMU6uQHPlyK09lnk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U1l40CS6fsOIWL6AgLRqC2p535cI8cZgUCaqAZ0Y/g4=; b=D
 fp1E88ofFp604RNfrUPFKY2yhg8F6aPKNPIycMwic8Q6cXq/NAw4gaD6Eq3D/Kpjbf8oaL+KUJO+d
 mGoOGRW3KtHWvp0TUHzkCV8RB/aAYSO9ny2pGEX7wmYxeup3tqidXTw1eiYZvRMfegedWfie5y8px
 XMimstwFzav+QeWU=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsjDV-0004Yp-Ve for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:44:09 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so389994f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786203840; x=1786808640; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U1l40CS6fsOIWL6AgLRqC2p535cI8cZgUCaqAZ0Y/g4=;
 b=Q/DkHZN5HiNp3oXmVPHA5qix6b1+P05kHVChA5g9AGUnh5ZW5XLQQIuIOCnPmANZhu
 k9E76S7Kw0dYFt1/z3O3nG9a7/vfljIbEvccVXBlmw/w7vn3GNXFgDLN95eg7fcxchCh
 tt1kTzKaWgl8+IC3hfRA4cNrxdF3EsTxUiQv7dtTw2jEpuR/XGoOIgIOvkU1iSpTo9kU
 6zUofIiMxIa2AaTSBbOaZa+4YfKoudpKo95owN3v+F/f7k5AG6+fNSfz0orA9L63ugmv
 JZBV9ry1kCXjLzilicS8CUa2Yrb/auNDcC/ddA2RsvRHR5ATmnCDaL0BwN4kxbfRGAYp
 7OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786203840; x=1786808640;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U1l40CS6fsOIWL6AgLRqC2p535cI8cZgUCaqAZ0Y/g4=;
 b=AA9axuXY33gtGws5UaKystKUH79oGHpE0q7poBLZJ2TO6pN+NyGYrORjJGqEoMpVVk
 49y9Jqd39Z6xl+v6IJB42zL2I/feA0VMbkR4zoaPoSXaucqTMlq5CFq+pHLB7cvL4CAE
 +bM9FLPgu6wsejFPkEkuJosM13SEub3y0N6VRL1Ab5d0M78J6S2qIskl8Ow5jPewy0Sk
 J6fjzDmvRSHKhf5icYMthm+J67hFgGY7+hSmPuS+sBWgazddOtJz7GkoYAmwC3gKpx5Z
 okfZByHgYNJlmahND/yhw8at1sp6hbO8llUo2JCOx4np/TFV9d0R8jeYkpXK5klYa4Lf
 j8jg==
X-Gm-Message-State: AOJu0YzpN45xYLrSAcAng67dBFtLjZDWa3/So/6cTRZfBbohanq3v35+
 OQrOdCvZQOJ/NuZIOMh3WlQUBQ0IwE/iXabbo//kYv02GO7NemLKPZ6sBrRNY70Fm5BYZcDWmK+
 QDbTwIagN2ozSHmInzvN+46Acfjo+Bx81iqr9ryLUcL8OU68lHNeCd0sQOJ8aZLV6/WzypIz4Uv
 ktwmpQMQ==
X-Gm-Gg: AR+sD12GjhrWi8KkG8/agOJSgVVluX3BpRfYl2MS9GFXccDk/nShVyU8rfoFeHaaTcX
 aW1De0lmu3Mv74QjoVFln2sxZyihJtNSUQPOt0Abg6bfk3YBzFNOLhhCWdDcmEfLzZx5sA5oV9i
 9hzqz4F1ix2YyDSetDBeABu+arKi0Mj72X9Xbxpo9ahLbwqKTEpWal3Q7lxKoZz+8B158Zh+yGT
 LN4roxTwZK6kZVBl3dztxlQXvYgCAh1aeEKsmMg5QueN7otPRiTVVGo/gzAM1Cu0zgL0eBOXPJL
 yJHEK4tAnV/knLgcm3cxrYxJYyMPBiOGT3JlWZx7PGz9eTcCHzRZiiCF17UnVhpGcC0+9cGNOhO
 m8TeQN6xd/lqnh8BB+Z4CDoyddbWP5L5WywML6srOGmoqLxXxHSaf9f0JAzNVGRuMgJDqNG+sya
 QTOx4AJUjKBb/2Ebeo+5NC1cSW92SPz3MDOi1wuq0GgXXycUud/Gi28qOiXCGLe5us2DILYMhFx
 7Qy5k4mjbGhCPI1qAvrMJaRHyOtgsQheCJ3ODvWp/+scCpx68ZxTBNRZfdorPtfVXA3BjP8jD7d
 ogpOodzV6Lbm5tReAG83DuuPcDWYr7ehuMhnFj1+y3exhOR/gK4=
X-Received: by 2002:a5d:5cc7:0:b0:47f:c648:e265 with SMTP id
 ffacd0b85a97d-48130edb15amr8623700f8f.17.1786203839420; 
 Sat, 08 Aug 2026 08:43:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f9182sm16211913f8f.28.2026.08.08.08.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 08:43:58 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 15:43:55 +0000
To: its_Giaan <gianmarco@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 30
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: fc2d2f2458df63b59e93052d26a112e4fb158049
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ecfc0f3f8b115bc706ac8d09538fd2fceaf5bcd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsjDV-0004Yp-Ve
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3863943053012279776=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3863943053012279776==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KpBUfjOiapg="; charset=UTF-8

--KpBUfjOiapg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#30) to the change originally created b=
y its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 plaisthos


Change subject: multipeer: introduce asymmetric peer-id
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multipeer: introduc=
e asymmetric peer-id

In order to achieve a multipeer functionality, peers =
now
use separate IDs for sending (tx_peer_id) and receiving
(rx_peer_id)=2E=


Each peer announces its own ID through pushing peer-info
using 'ID=3D7f1'=
 hex format so identification can still
happen even if IP/port changes=2E

=
In P2P mode, peer switch to using the announced IDs after
mutual exchange=
=2E
In P2MP mode, clients always announce their ID, and servers
can optiona=
lly respond with their own to enable the same
behavior=2E

Change-Id: I0a13=
ee90b6706acf20eabcee3bab3f2dff639bf9
Signed-off-by: Gianmarco De Gregori <g=
ianmarco@mandelbit=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089
Message-Id: =
<20260728122355=2E2566-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37944=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dco=2Ec
M=
 src/openvpn/init=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/multi=2Ec
M src/=
openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push_util=2Ec
M sr=
c/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_ncp=2Ec
M =
src/openvpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
12 files changed, 168 i=
nsertions(+), 54 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/89/1089/30

diff --git a/src/openvpn/dco=2Ec b/src/=
openvpn/dco=2Ec
index 2584368=2E=2Ece73701 100644
--- a/src/openvpn/dco=2Ec=

+++ b/src/openvpn/dco=2Ec
@@ -544,14 +544,15 @@
         c->c2=2Etls_multi=
->dco_peer_id =3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1=
=2Etuntap->dco, multi->peer_id, sock->sd, NULL,
-                          =
 proto_is_dgram(sock->info=2Eproto) ? remoteaddr : NULL, NULL, NULL);
+    =
int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_id, sock->sd,=
 NULL,
+                           proto_is_dgram(sock->info=2Eproto) ? rem=
oteaddr : NULL,
+                           NULL, NULL);
     if (ret < 0)
=
     {
         return ret;
     }
 
-    c->c2=2Etls_multi->dco_peer_id =
=3D multi->peer_id;
+    c->c2=2Etls_multi->dco_peer_id =3D multi->rx_peer_=
id;
 
     return 0;
 }
@@ -626,7 +627,7 @@
 {
     struct context *c =3D &=
mi->context;
 
-    int peer_id =3D c->c2=2Etls_multi->peer_id;
+    int pe=
er_id =3D c->c2=2Etls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, =
*localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
     con=
st socket_descriptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
@@ -706,7 +707,7=
 @@
     {
 #if defined(_WIN32)
         dco_win_add_iroute_ipv6(&c->c1=2Et=
untap->dco, addr->v6=2Eaddr, addr->netbits,
-                              =
  c->c2=2Etls_multi->peer_id);
+                                c->c2=2Etls=
_multi->rx_peer_id);
 #else
         const struct in6_addr *gateway =3D &mi=
->context=2Ec2=2Epush_ifconfig_ipv6_local;
         if (addr->type & MR_ONL=
INK_DCO_ADDR)
@@ -723,7 +724,7 @@
     {
 #if defined(_WIN32)
         dco_=
win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits,
-=
                                c->c2=2Etls_multi->peer_id);
+             =
                   c->c2=2Etls_multi->rx_peer_id);
 #else
         in_addr_=
t dest =3D htonl(addr->v4=2Eaddr);
         const in_addr_t *gateway =3D &m=
i->context=2Ec2=2Epush_ifconfig_local;
diff --git a/src/openvpn/init=2Ec b/=
src/openvpn/init=2Ec
index 0236886=2E=2E906a83c 100644
--- a/src/openvpn/in=
it=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2203,9 +2203,10 @@
                  =
  md_kt_name(o->authname));
     }
 
-    if (o->use_peer_id)
+    if (c->c=
2=2Etls_multi && c->c2=2Etls_multi->use_peer_id)
     {
-        buf_printf=
(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out, ", rx-peer-i=
d: %u, tx-peer-id: %u", c->c2=2Etls_multi->rx_peer_id,
+                   =
c->c2=2Etls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2322,6 +2323,=
11 @@
     }
 #endif
 
+    /* The peer-id can also be negotiated without b=
eing pushed, so sync the
+     * option before the frame is recalculated: i=
t decides whether the
+     * DATA_V2 header is accounted for */
+    c->op=
tions=2Euse_peer_id =3D c->c2=2Etls_multi->use_peer_id;
+
     struct tls_s=
ession *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
     if (!tls_s=
ession_update_crypto_params(c->c2=2Etls_multi, session, &c->options, &c->c2=
=2Eframe,
                                           frame_fragment, get_li=
nk_socket_info(c),
@@ -2675,7 +2681,8 @@
     {
         msg(D_PUSH_DEBUG, =
"OPTIONS IMPORT: peer-id set");
         c->c2=2Etls_multi->use_peer_id =3D=
 true;
-        c->c2=2Etls_multi->peer_id =3D c->options=2Epeer_id;
+     =
   c->c2=2Etls_multi->tx_peer_id =3D c->options=2Epeer_id;
+        c->c2=
=2Etls_multi->rx_peer_id =3D c->options=2Epeer_id;
     }
 
     /* process=
 (potentially) pushed options */
@@ -2702,7 +2709,7 @@
     /* Ensure that =
for epoch data format is only enabled if also data v2
      * is enabled */=

     bool epoch_data =3D c->options=2Eimported_protocol_flags & CO_EPOCH_D=
ATA_KEY_FORMAT;
-    bool datav2_enabled =3D c->options=2Euse_peer_id && c-=
>options=2Epeer_id < MAX_PEER_ID;
+    bool datav2_enabled =3D c->c2=2Etls_=
multi->use_peer_id && c->c2=2Etls_multi->tx_peer_id < MAX_PEER_ID;
 
     i=
f (epoch_data && !datav2_enabled)
     {
diff --git a/src/openvpn/misc=2Ec =
b/src/openvpn/misc=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/openvpn/=
misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
         c=
homp(line);
         if (validate_peer_info_line(line)
-            && (str=
ncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
+      =
      && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=
=3D 0
+                || strncmp(line, "ID", 2) =3D=3D 0))
         {
    =
         msg(M_INFO, "peer info: %s", line);
             env_set_add(es, l=
ine);
         }
         else
         {
-            msg(M_WARN, "validat=
ion failed on peer_info line received from client");
+            msg(M_WAR=
N, "validation failed on peer_info line received");
         }
     }
 }
di=
ff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a4e9c1c=2E=
=2Ecfa2ad8 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@=
@ -430,7 +430,7 @@
         if (mi->context=2Ec2=2Etls_multi && check_debug=
_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context=2Eoptions))
  =
       {
-            buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=2E=
tls_multi->peer_id);
+            buf_printf(&out, " rx-peer-id=3D%d", mi->=
context=2Ec2=2Etls_multi->rx_peer_id);
         }
         return BSTR(&out=
);
     }
@@ -598,9 +598,9 @@
         }
 #endif
 
-        if (mi->context=
=2Ec2=2Etls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context=2Ec2=
=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->insta=
nces[mi->context=2Ec2=2Etls_multi->peer_id] =3D NULL;
+            m->insta=
nces[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
 
             /* =
Adjust the max_peerid as this might have been the highest
              * p=
eer id instance */
@@ -908,8 +908,7 @@
 #else
                         sep,=

 #endif
-                        sep,
-                        mi->context=
=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+  =
                      sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=
=2Etls_multi->rx_peer_id : MAX_PEER_ID,
                         sep, trans=
late_cipher_name_to_openvpn(mi->context=2Eoptions=2Eciphername));
         =
        }
                 gc_free(&gc);
@@ -3121,12 +3120,12 @@
          =
* has, so we disallow it=2E This can happen if a DCO netlink notification
 =
         * gets lost and we miss a floating step=2E
          */
-        i=
f (m1->peer_id =3D=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->r=
x_peer_id)
         {
             msg(M_WARN,
                 "disallowin=
g peer %" PRIu32 " (%s) from floating to "
                 "its own addres=
s (%s)",
-                m1->peer_id, tls_common_name(mi->context=2Ec2=2Et=
ls_multi, false),
+                m1->rx_peer_id, tls_common_name(mi->cont=
ext=2Ec2=2Etls_multi, false),
                 mroute_addr_print(&mi->real,=
 &gc));
             goto done;
         }
@@ -3139,7 +3138,8 @@
     }
 
 =
    msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-   =
     mi->context=2Ec2=2Etls_multi->peer_id, tls_common_name(mi->context=2Ec=
2=2Etls_multi, false),
+        mi->context=2Ec2=2Etls_multi->rx_peer_id,
+=
        tls_common_name(mi->context=2Ec2=2Etls_multi, false),
         mrou=
te_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
         mroute_addr_pr=
int_ex(&real, MAPF_SHOW_FAMILY, &gc));
 
@@ -4099,7 +4099,7 @@
     {
     =
    if (!m->instances[i])
         {
-            mi->context=2Ec2=2Etls_mu=
lti->peer_id =3D i;
+            mi->context=2Ec2=2Etls_multi->rx_peer_id =
=3D i;
             m->instances[i] =3D mi;
             break;
         }
=
@@ -4108,11 +4108,11 @@
     /* should not really end up here, since multi_=
create_instance returns null
      * if amount of clients exceeds max_clien=
ts and this method would then
      * also not have been called */
-    ASS=
ERT(mi->context=2Ec2=2Etls_multi->peer_id < m->max_clients);
+    ASSERT(mi=
->context=2Ec2=2Etls_multi->rx_peer_id < m->max_clients);
 
-    if (mi->co=
ntext=2Ec2=2Etls_multi->peer_id > m->max_peerid)
+    if (mi->context=2Ec2=
=2Etls_multi->rx_peer_id > m->max_peerid)
     {
-        m->max_peerid =3D=
 mi->context=2Ec2=2Etls_multi->peer_id;
+        m->max_peerid =3D mi->cont=
ext=2Ec2=2Etls_multi->rx_peer_id;
     }
 }
 
diff --git a/src/openvpn/opti=
ons=2Eh b/src/openvpn/options=2Eh
index 2f7fe30=2E=2E30a146f 100644
--- a/s=
rc/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -697,6 +697,9 @@
  =
   enum tun_driver_type windows_driver;
 #endif
 
+    /** Whether the data=
 channel uses the DATA_V2 header (peer-id)=2E
+     *  Mirror of tls_multi-=
>use_peer_id, needed by the MTU/frame calculation
+     *  which only has a=
ccess to struct options=2E */
     bool use_peer_id;
     uint32_t peer_id;=

 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index e391147=
=2E=2E633c007d 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec=

@@ -661,9 +661,9 @@
                         print_in_addr_t(c->c2=2Epush_=
ifconfig_remote_netmask, 0, gc));
     }
 
-    if (tls_multi->use_peer_id)=

+    if (tls_multi->use_peer_id && !tls_multi->use_asymmetric_peer_id)
   =
  {
-        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_mult=
i->peer_id);
+        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",=
 tls_multi->rx_peer_id);
     }
     /*
      * If server uses --auth-gen-t=
oken and we have an auth token
diff --git a/src/openvpn/push_util=2Ec b/src=
/openvpn/push_util=2Ec
index f57f54d=2E=2Ec927f26 100644
--- a/src/openvpn/=
push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -188,7 +188,7 @@
         =
unsigned int permission_mask =3D pull_permission_mask(c);
         if (proc=
ess_push_update(c, &o, permission_mask, &option_types_found, &tmp_msg, true=
) =3D=3D PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Failed to pro=
cess push update message sent to client ID: %u", c->c2=2Etls_multi->peer_id=
);
+            msg(M_WARN, "Failed to process push update message sent to =
client ID: %u", c->c2=2Etls_multi->rx_peer_id);
         }
         e =3D e=
->next;
     }
@@ -294,7 +294,7 @@
 
         if (!support_push_update(mi))=

         {
-            msg(M_CLIENT, "PUSH_UPDATE: not sending message to=
 unsupported peer with ID: %u", mi->context=2Ec2=2Etls_multi->peer_id);
+  =
          msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported pe=
er with ID: %u", mi->context=2Ec2=2Etls_multi->rx_peer_id);
             bu=
ffer_list_free(msgs);
             gc_free(&gc);
             return 0;
@@ =
-329,7 +329,7 @@
         /* Type is UPT_BROADCAST so we update every clien=
t */
         if (!send_single_push_update(m, curr_mi, msgs))
         {
- =
           msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi=
->context=2Ec2=2Etls_multi->peer_id);
+            msg(M_CLIENT, "ERROR: Pe=
er ID: %u has not been updated", curr_mi->context=2Ec2=2Etls_multi->rx_peer=
_id);
             continue;
         }
         count++;
diff --git a/src/=
openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ccd8264=2E=2Ed5100af 100644
---=
 a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1168,7 +1168,10 @@
   =
  /* get command line derived options */
     ret->opt =3D *tls_options;
  =
   ret->dco_peer_id =3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+    ret->us=
e_asymmetric_peer_id =3D false;
+    /* The rx_peer_id is also used to iden=
tify DCO clients */
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    ret->tx_peer=
_id =3D MAX_PEER_ID;
 
     return ret;
 }
@@ -1181,6 +1184,15 @@
 
     tl=
s_session_init(multi, &multi->session[TM_ACTIVE]);
     tls_session_init(mu=
lti, &multi->session[TM_INITIAL]);
+
+    if (!multi->opt=2Edco_enabled)
+ =
   {
+        /* Calculate the asymmetric peer-id */
+        if (multi->rx=
_peer_id =3D=3D MAX_PEER_ID && multi->session[TM_INITIAL]=2Eopt->mode !=3D =
MODE_SERVER)
+        {
+            multi->rx_peer_id =3D (uint32_t)(get_r=
andom() % (MAX_PEER_ID - 1));
+        }
+    }
 }
 
 /*
@@ -1858,6 +1870,2=
5 @@
     return str;
 }
 
+static bool
+push_peer_info_peerid(struct buffe=
r *out, struct tls_multi *multi, struct tls_session *session)
+{
+    if (m=
ulti->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
+    {
+ =
       /* No valid peer id or DCO is enabled=2E Cannot use this feature */
=
+        return true;
+    }
+
+    /* In server mode we only add this when=
 the client has announced its
+     * support for the feature */
+    if (s=
ession->opt->mode !=3D MODE_SERVER || multi->use_asymmetric_peer_id)
+    {=

+        return buf_printf(out, "ID=3D%x\n", multi->rx_peer_id);
+    }
+
=
+    return true;
+}
+
 /**
  * Prepares the IV_ and UV_ variables that are=
 part of the
  * exchange to signal the peer's capabilities=2E The amount
@=
@ -1871,15 +1902,22 @@
  *
  * @param buf       the buffer to write these v=
ariables to
  * @param session   the TLS session object
+ * @param multi   =
  the TLS multi object
  * @return          true if no error was encountere=
d
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_session =
*session)
+push_peer_info(struct buffer *buf, struct tls_multi *multi, stru=
ct tls_session *session)
 {
     struct gc_arena gc =3D gc_new();
     bool=
 ret =3D false;
     struct buffer out =3D alloc_buf_gc(512 * 3, &gc);
 
+ =
   /* The asymmetric peer-id is always written when enabled */
+    if (!pu=
sh_peer_info_peerid(&out, multi, session))
+    {
+        goto error;
+   =
 }
+
     if (session->opt->push_peer_info_detail > 1)
     {
         /* p=
ush version */
@@ -2019,7 +2057,11 @@
                 }
             }
   =
      }
+    }
 
+    /* write peer info string if there is anything in it,=
 empty string otherwise */
+    if (BLEN(&out) > 0)
+    {
         if (!wr=
ite_string(buf, BSTR(&out), -1))
         {
             goto error;
@@ -20=
27,7 +2069,7 @@
     }
     else
     {
-        if (!write_empty_string(bu=
f)) /* no peer info */
+        if (!write_empty_string(buf))
         {
  =
           goto error;
         }
@@ -2156,7 +2198,7 @@
         }
     }
 =

-    if (!push_peer_info(buf, session))
+    if (!push_peer_info(buf, mult=
i, session))
     {
         goto error;
     }
@@ -2269,6 +2311,19 @@
    =
 if (multi->peer_info)
     {
         output_peer_info_env(session->opt->e=
s, multi->peer_info);
+        uint32_t peer_id =3D extract_asymmetric_peer=
_id(multi->peer_info);
+        if (peer_id !=3D MAX_PEER_ID && !session->o=
pt->dco_enabled)
+        {
+            multi->tx_peer_id =3D peer_id;
+  =
          multi->use_asymmetric_peer_id =3D true;
+            multi->use_p=
eer_id =3D true;
+        }
+        else
+        {
+            /* Peer h=
as no support for asymmetric peer-id, and DCO currently
+             * can=
 only handle symmetric peer IDs */
+            multi->tx_peer_id =3D multi=
->rx_peer_id;
+        }
     }
 
     free(multi->remote_ciphername);
@@ -=
4030,8 +4085,8 @@
     msg(D_TLS_DEBUG, __func__);
 
     ASSERT(ks);
-
-  =
  peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24 | (mult=
i->peer_id & 0xFFFFFF));
+    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT)=
 | ks->key_id) << 24
+                 | (multi->tx_peer_id & 0xFFFFFF));
 =
    ASSERT(buf_write_prepend(buf, &peer, 4));
 }
 
diff --git a/src/openvpn=
/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9c90242=2E=2Ef6392f9 100=
644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -6=
96,8 +696,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUSER (1 << 2)
 
     /* For =
P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t rx_peer_id;
+    uint32_t=
 tx_peer_id;
     bool use_peer_id;
+    bool use_asymmetric_peer_id;
 
   =
  char *remote_ciphername; /**< cipher specified in peer's config file */
 =
    bool remote_usescomp;    /**< remote announced comp-lzo in OCC string *=
/
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index baf5=
a95=2E=2Eb450de8 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl=
_ncp=2Ec
@@ -408,6 +408,7 @@
 {
     /* will return 0 if peer_info is null =
*/
     const unsigned int iv_proto_peer =3D extract_iv_proto(multi->peer_i=
nfo);
+    const unsigned int tx_peer_id =3D extract_asymmetric_peer_id(mul=
ti->peer_info);
 
     /* The other peer does not support P2P NCP */
     i=
f (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -418,7 +419,6 @@
     if (iv_pro=
to_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id =3D true;
- =
       multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
     }
 
     if (iv_=
proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -441,27 +441,42 @@
     if (iv_pro=
to_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
         session->opt->crypto_fla=
gs |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
+    }
 
-        if (multi->use_pe=
er_id)
+    if (multi->use_peer_id)
+    {
+        /* The asymmetric peer-=
id trumps on the EKM generated ones */
+        if ((iv_proto_peer & IV_PRO=
TO_TLS_KEY_EXPORT)
+            && (tx_peer_id !=3D MAX_PEER_ID) && !multi-=
>opt=2Edco_enabled)
         {
+            multi->tx_peer_id =3D tx_peer_i=
d;
+            multi->use_asymmetric_peer_id =3D true;
+        }
+       =
 else
+        {
+            uint8_t peerid[3];
             /* Using a no=
n hardcoded peer-id makes a tiny bit harder to
              * fingerprint =
packets and also gives each connection a unique
              * peer-id tha=
t can be useful for NAT tracking etc=2E */
-
-            uint8_t peerid[3]=
;
-            if (!key_state_export_keying_material(session, EXPORT_P2P_PE=
ERID_LABEL,
-                                                  strlen(EXPOR=
T_P2P_PEERID_LABEL), &peerid, 3))
+            if ((iv_proto_peer & IV_PROT=
O_TLS_KEY_EXPORT)
+                && key_state_export_keying_material(sess=
ion, EXPORT_P2P_PEERID_LABEL,
+                                            =
        strlen(EXPORT_P2P_PEERID_LABEL), &peerid, 3))
             {
-     =
           /* Non DCO setup might still work but also this should never
-  =
               * happen or very likely the TLS encryption key exporter will=

-                 * also fail */
-                msg(M_NONFATAL, "TLS key=
 export for P2P peer id failed=2E "
-                                "Conti=
nuing anyway, expect problems");
+                multi->rx_peer_id =3D (pe=
erid[0] << 16) + (peerid[1] << 8) + peerid[2];
             }
             =
else
             {
-                multi->peer_id =3D (peerid[0] << 16) +=
 (peerid[1] << 8) + peerid[2];
+                if (iv_proto_peer & IV_PROT=
O_TLS_KEY_EXPORT)
+                {
+                    /* Non DCO setup =
might still work but also this should never
+                     * happen =
or very likely the TLS encryption key exporter will
+                     *=
 also fail */
+                    msg(M_NONFATAL, "TLS key export for P2P =
peer id failed=2E "
+                                    "Continuing anyway=
, expect problems");
+                }
+                multi->rx_peer_id =
=3D 0x76706e; /* 'v' 'p' 'n' */
             }
+            multi->tx_peer_=
id =3D multi->rx_peer_id;
         }
     }
     if (iv_proto_peer & IV_PRO=
TO_DYN_TLS_CRYPT)
@@ -502,11 +517,13 @@
         common_cipher =3D BSTR(&ou=
t);
     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP negotiation r=
esult: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, c=
ipher=3D%s",
-        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MA=
TERIAL_EXPORT), multi->use_peer_id,
-        multi->peer_id, (bool)(session=
->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D_TLS_DEBUG_LOW, =
"P2P mode NCP negotiation result: "
+                         "TLS_export=
=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s"=
,
+        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPO=
RT),
+        multi->use_peer_id,
+        multi->rx_peer_id,
+        mult=
i->tx_peer_id,
+        (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_K=
EY_FORMAT),
         common_cipher);
 
     gc_free(&gc);
diff --git a/src/=
openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 71fbc9e=2E=2E2f01f8a =
100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -24=
,7 +24,7 @@
 #endif
 
 #include "syshead=2Eh"
-
+#include "openvpn=2Eh"
 #i=
nclude "ssl_util=2Eh"
 
 char *
@@ -72,6 +72,25 @@
     return 0;
 }
 
+uin=
t32_t
+extract_asymmetric_peer_id(const char *peer_info)
+{
+    for (const=
 char *p =3D peer_info; p && (p =3D strstr(p, "ID=3D")); p +=3D 3)
+    {
+=
        /* only accept "ID=3D" at the start of a line, so it does not match=

+         * substrings like "UV_ID=3D" or "GUID=3D" */
+        if (p =3D=
=3D peer_info || p[-1] =3D=3D '\n')
+        {
+            uint32_t peer_i=
d =3D 0;
+            if (sscanf(p, "ID=3D%x", &peer_id) =3D=3D 1 && peer_i=
d < MAX_PEER_ID)
+            {
+                return peer_id;
+         =
   }
+        }
+    }
+    return MAX_PEER_ID;
+}
+
 const char *
 options=
_string_compat_lzo(const char *options, struct gc_arena *gc)
 {
diff --git =
a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 2177d94=2E=2E1a=
69e6f 100644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
=
@@ -53,6 +53,15 @@
  */
 unsigned int extract_iv_proto(const char *peer_inf=
o);
 
+
+/**
+ * Extracts the ID variable and returns its value or
+ * MAX_=
PEER_ID if it cannot be extracted=2E
+ *
+ * @param peer_info     peer info=
 string to search for ID
+ */
+uint32_t extract_asymmetric_peer_id(const ch=
ar *peer_info);
+
 /**
  * Takes a locally produced OCC string for TLS serv=
er mode and modifies as
  * if the option comp-lzo was enabled=2E This is t=
o send a client in

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerr=
it-PatchSet: 30
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-=
Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-CC: ordex <antonio@mandelbit=2Ecom>

--KpBUfjOiapg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #30</strong> to the change originally created by its_Giaan=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">multipeer: introduce as=
ymmetric peer-id<br><br>In order to achieve a multipeer functionality, peer=
s now<br>use separate IDs for sending (tx_peer_id) and receiving<br>(rx_pee=
r_id)=2E<br><br>Each peer announces its own ID through pushing peer-info<br=
>using &#39;ID=3D7f1&#39; hex format so identification can still<br>happen =
even if IP/port changes=2E<br><br>In P2P mode, peer switch to using the ann=
ounced IDs after<br>mutual exchange=2E<br>In P2MP mode, clients always anno=
unce their ID, and servers<br>can optionally respond with their own to enab=
le the same<br>behavior=2E<br><br>Change-Id: I0a13ee90b6706acf20eabcee3bab3=
f2dff639bf9<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=
=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089<br>Message-Id: =
&lt;20260728122355=2E2566-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37944=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/misc=2Ec<=
br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/pu=
sh=2Ec<br>M src/openvpn/push_util=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/ope=
nvpn/ssl_common=2Eh<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_util=
=2Ec<br>M src/openvpn/ssl_util=2Eh<br>12 files changed, 168 insertions(+), =
54 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/89/1089/30</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 2584368=2E=2Ece73701=
 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src=
/openvpn/dco=2Ec</span><br><span>@@ -544,14 +544,15 @@</span><br><span>    =
     c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D -1;</span><br><span>     }</s=
pan><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int ret =3D dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;peer=
_id, sock-&gt;sd, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                           proto_is_dgram(sock-&gt;info=2Eproto) ? remote=
addr : NULL, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int ret =3D dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&g=
t;rx_peer_id, sock-&gt;sd, NULL,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                           proto_is_dgram(sock-&gt;info=2Eprot=
o) ? remoteaddr : NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                           NULL, NULL);</span><br><span>     if (ret &l=
t; 0)</span><br><span>     {</span><br><span>         return ret;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi-&gt;peer_id;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_mu=
lti-&gt;dco_peer_id =3D multi-&gt;rx_peer_id;</span><br><span> </span><br><=
span>     return 0;</span><br><span> }</span><br><span>@@ -626,7 +627,7 @@<=
/span><br><span> {</span><br><span>     struct context *c =3D &amp;mi-&gt;c=
ontext;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;peer_id;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int peer_id =3D c-&gt;c2=2Etls_mu=
lti-&gt;rx_peer_id;</span><br><span>     struct sockaddr *remoteaddr, *loca=
laddr =3D NULL;</span><br><span>     struct sockaddr_storage local =3D { 0 =
};</span><br><span>     const socket_descriptor_t sd =3D c-&gt;c2=2Elink_so=
ckets[0]-&gt;sd;</span><br><span>@@ -706,7 +707,7 @@</span><br><span>     {=
</span><br><span> #if defined(_WIN32)</span><br><span>         dco_win_add_=
iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;ne=
tbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                 c-&gt;c2=2Etls_multi-&gt;peer_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                c-&gt;c2=
=2Etls_multi-&gt;rx_peer_id);</span><br><span> #else</span><br><span>      =
   const struct in6_addr *gateway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifcon=
fig_ipv6_local;</span><br><span>         if (addr-&gt;type &amp; MR_ONLINK_=
DCO_ADDR)</span><br><span>@@ -723,7 +724,7 @@</span><br><span>     {</span>=
<br><span> #if defined(_WIN32)</span><br><span>         dco_win_add_iroute_=
ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, addr-&gt;netbits,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
          c-&gt;c2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                c-&gt;c2=2Etls_mul=
ti-&gt;rx_peer_id);</span><br><span> #else</span><br><span>         in_addr=
_t dest =3D htonl(addr-&gt;v4=2Eaddr);</span><br><span>         const in_ad=
dr_t *gateway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br=
><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><=
span>index 0236886=2E=2E906a83c 100644</span><br><span>--- a/src/openvpn/in=
it=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2203,=
9 +2203,10 @@</span><br><span>                    md_kt_name(o-&gt;authname=
));</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (o-&gt;use_peer_id)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Etls_multi &amp;&amp; c-&gt=
;c2=2Etls_multi-&gt;use_peer_id)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;, peer=
-id: %d&quot;, o-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_printf(&amp;out, &quot;, rx-peer-id: %u, tx-peer-id:=
 %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                   c-&gt;c2=2Etls_multi-&gt;tx_=
peer_id);</span><br><span>     }</span><br><span> </span><br><span> #ifdef =
USE_COMP</span><br><span>@@ -2322,6 +2323,11 @@</span><br><span>     }</spa=
n><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* The peer-id can also be negotiated without being p=
ushed, so sync the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * option before the frame is recalculated: it decides whether the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * DATA_V2 header is =
accounted for */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 c-&gt;options=2Euse_peer_id =3D c-&gt;c2=2Etls_multi-&gt;use_peer_id;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     st=
ruct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTI=
VE];</span><br><span>     if (!tls_session_update_crypto_params(c-&gt;c2=2E=
tls_multi, session, &amp;c-&gt;options, &amp;c-&gt;c2=2Eframe,</span><br><s=
pan>                                           frame_fragment, get_link_soc=
ket_info(c),</span><br><span>@@ -2675,7 +2681,8 @@</span><br><span>     {</=
span><br><span>         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-id set=
&quot;);</span><br><span>         c-&gt;c2=2Etls_multi-&gt;use_peer_id =3D =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=
=2Etls_multi-&gt;peer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Etls_multi-&gt;tx_peer_=
id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        c-&gt;c2=2Etls_multi-&gt;rx_peer_id =3D c-&gt;options=
=2Epeer_id;</span><br><span>     }</span><br><span> </span><br><span>     /=
* process (potentially) pushed options */</span><br><span>@@ -2702,7 +2709,=
7 @@</span><br><span>     /* Ensure that for epoch data format is only enab=
led if also data v2</span><br><span>      * is enabled */</span><br><span> =
    bool epoch_data =3D c-&gt;options=2Eimported_protocol_flags &amp; CO_EP=
OCH_DATA_KEY_FORMAT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   bool datav2_enabled =3D c-&gt;options=2Euse_peer_id &amp;&amp; c-&gt;opt=
ions=2Epeer_id &lt; MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool datav2_enabled =3D c-&gt;c2=2Etls_multi-&gt;use_peer_=
id &amp;&amp; c-&gt;c2=2Etls_multi-&gt;tx_peer_id &lt; MAX_PEER_ID;</span><=
br><span> </span><br><span>     if (epoch_data &amp;&amp; !datav2_enabled)<=
/span><br><span>     {</span><br><span>diff --git a/src/openvpn/misc=2Ec b/=
src/openvpn/misc=2Ec</span><br><span>index 10bfc35=2E=2Ea8c88c9 100644</spa=
n><br><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/mi=
sc=2Ec</span><br><span>@@ -765,14 +765,15 @@</span><br><span>     {</span><=
br><span>         chomp(line);</span><br><span>         if (validate_peer_i=
nfo_line(line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line=
, &quot;UV_&quot;, 3) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=
=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                || strncmp(line, &quot;ID=
&quot;, 2) =3D=3D 0))</span><br><span>         {</span><br><span>          =
   msg(M_INFO, &quot;peer info: %s&quot;, line);</span><br><span>          =
   env_set_add(es, line);</span><br><span>         }</span><br><span>      =
   else</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(M_WARN, &quot;validation failed on peer_info l=
ine received from client&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_WARN, &quot;validation failed on peer_info l=
ine received&quot;);</span><br><span>         }</span><br><span>     }</spa=
n><br><span> }</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec</span><br><span>index a4e9c1c=2E=2Ecfa2ad8 100644</span><br>=
<span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -430,7 +430,7 @@</span><br><span>         if (mi-&g=
t;context=2Ec2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span>=
<br><span>             &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions=
))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            buf_printf(&amp;out, &quot; peer-id=3D%d&quot;, mi-&gt;=
context=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            buf_printf(&amp;out, &quot; rx-peer-id=3D%d&=
quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>   =
      }</span><br><span>         return BSTR(&amp;out);</span><br><span>   =
  }</span><br><span>@@ -598,9 +598,9 @@</span><br><span>         }</span><b=
r><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id !=3D MA=
X_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id] =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m-=
&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</sp=
an><br><span> </span><br><span>             /* Adjust the max_peerid as thi=
s might have been the highest</span><br><span>              * peer id insta=
nce */</span><br><span>@@ -908,8 +908,7 @@</span><br><span> #else</span><br=
><span>                         sep,</span><br><span> #endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                        sep,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        mi-&g=
t;context=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id : =
UINT32_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                sep, mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=
=2Etls_multi-&gt;rx_peer_id : MAX_PEER_ID,</span><br><span>                =
         sep, translate_cipher_name_to_openvpn(mi-&gt;context=2Eoptions=2Ec=
iphername));</span><br><span>                 }</span><br><span>           =
      gc_free(&amp;gc);</span><br><span>@@ -3121,12 +3120,12 @@</span><br><=
span>          * has, so we disallow it=2E This can happen if a DCO netlink=
 notification</span><br><span>          * gets lost and we miss a floating =
step=2E</span><br><span>          */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (m1-&gt;peer_id =3D=3D m2-&gt;peer_id)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (m1-&gt;rx_peer_id =
=3D=3D m2-&gt;rx_peer_id)</span><br><span>         {</span><br><span>      =
       msg(M_WARN,</span><br><span>                 &quot;disallowing peer =
%&quot; PRIu32 &quot; (%s) from floating to &quot;</span><br><span>        =
         &quot;its own address (%s)&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                m1-&gt;peer_id, tls_common_name(mi-&gt=
;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                m1-&gt;rx_peer_id, tls_common_name(mi-&gt;co=
ntext=2Ec2=2Etls_multi, false),</span><br><span>                 mroute_add=
r_print(&amp;mi-&gt;real, &amp;gc));</span><br><span>             goto done=
;</span><br><span>         }</span><br><span>@@ -3139,7 +3138,8 @@</span><b=
r><span>     }</span><br><span> </span><br><span>     msg(D_MULTI_MEDIUM, &=
quot;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Ec2=2Et=
ls_multi-&gt;peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, fals=
e),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;c=
ontext=2Ec2=2Etls_multi-&gt;rx_peer_id,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        tls_common_name(mi-&gt;context=2Ec2=2Etls_multi=
, false),</span><br><span>         mroute_addr_print_ex(&amp;mi-&gt;real, M=
APF_SHOW_FAMILY, &amp;gc),</span><br><span>         mroute_addr_print_ex(&a=
mp;real, MAPF_SHOW_FAMILY, &amp;gc));</span><br><span> </span><br><span>@@ =
-4099,7 +4099,7 @@</span><br><span>     {</span><br><span>         if (!m-&=
gt;instances[i])</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_=
id =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id =3D i;</span><br><span>   =
          m-&gt;instances[i] =3D mi;</span><br><span>             break;</s=
pan><br><span>         }</span><br><span>@@ -4108,11 +4108,11 @@</span><br>=
<span>     /* should not really end up here, since multi_create_instance re=
turns null</span><br><span>      * if amount of clients exceeds max_clients=
 and this method would then</span><br><span>      * also not have been call=
ed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi-&g=
t;context=2Ec2=2Etls_multi-&gt;peer_id &lt; m-&gt;max_clients);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context=2Ec2=
=2Etls_multi-&gt;rx_peer_id &lt; m-&gt;max_clients);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context=2Ec=
2=2Etls_multi-&gt;peer_id &gt; m-&gt;max_peerid)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx=
_peer_id &gt; m-&gt;max_peerid)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        m-&gt;max_peerid =3D mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        m-&gt;max_peerid =3D mi-&gt;context=2Ec2=2Etls_multi-&g=
t;rx_peer_id;</span><br><span>     }</span><br><span> }</span><br><span> </=
span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh</span><br><span>index 2f7fe30=2E=2E30a146f 100644</span><br><span>--- =
a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</sp=
an><br><span>@@ -697,6 +697,9 @@</span><br><span>     enum tun_driver_type =
windows_driver;</span><br><span> #endif</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /** Whether the data channel uses=
 the DATA_V2 header (peer-id)=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     *  Mirror of tls_multi-&gt;use_peer_id, needed by the MTU=
/frame calculation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    *  which only has access to struct options=2E */</span><br><span>     b=
ool use_peer_id;</span><br><span>     uint32_t peer_id;</span><br><span> </=
span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</sp=
an><br><span>index e391147=2E=2E633c007d 100644</span><br><span>--- a/src/o=
penvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>=
@@ -661,9 +661,9 @@</span><br><span>                         print_in_addr_=
t(c-&gt;c2=2Epush_ifconfig_remote_netmask, 0, gc));</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (tls_multi-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (tls_multi-&gt;use_peer_id &amp;&amp; !tls_multi-&gt;use_=
asymmetric_peer_id)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        push_option_fmt(gc, push_list, M_USAGE, &quot;=
peer-id %d&quot;, tls_multi-&gt;peer_id);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot=
;peer-id %d&quot;, tls_multi-&gt;rx_peer_id);</span><br><span>     }</span>=
<br><span>     /*</span><br><span>      * If server uses --auth-gen-token a=
nd we have an auth token</span><br><span>diff --git a/src/openvpn/push_util=
=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index f57f54d=2E=2Ec927f26=
 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++=
 b/src/openvpn/push_util=2Ec</span><br><span>@@ -188,7 +188,7 @@</span><br>=
<span>         unsigned int permission_mask =3D pull_permission_mask(c);</s=
pan><br><span>         if (process_push_update(c, &amp;o, permission_mask, =
&amp;option_types_found, &amp;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(M_WARN, &quot;Failed to process push update message sent to c=
lient ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;peer_id);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Failed to =
process push update message sent to client ID: %u&quot;, c-&gt;c2=2Etls_mul=
ti-&gt;rx_peer_id);</span><br><span>         }</span><br><span>         e =
=3D e-&gt;next;</span><br><span>     }</span><br><span>@@ -294,7 +294,7 @@<=
/span><br><span> </span><br><span>         if (!support_push_update(mi))</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(M_CLIENT, &quot;PUSH_UPDATE: not sending message to unsu=
pported peer with ID: %u&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M=
_CLIENT, &quot;PUSH_UPDATE: not sending message to unsupported peer with ID=
: %u&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><spa=
n>             buffer_list_free(msgs);</span><br><span>             gc_free=
(&amp;gc);</span><br><span>             return 0;</span><br><span>@@ -329,7=
 +329,7 @@</span><br><span>         /* Type is UPT_BROADCAST so we update e=
very client */</span><br><span>         if (!send_single_push_update(m, cur=
r_mi, msgs))</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            msg(M_CLIENT, &quot;ERROR: Peer ID: %u has no=
t been updated&quot;, curr_mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIE=
NT, &quot;ERROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>             continue;<=
/span><br><span>         }</span><br><span>         count++;</span><br><spa=
n>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>in=
dex ccd8264=2E=2Ed5100af 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</=
span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1168,7 +1168,1=
0 @@</span><br><span>     /* get command line derived options */</span><br>=
<span>     ret-&gt;opt =3D *tls_options;</span><br><span>     ret-&gt;dco_p=
eer_id =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
-&gt;peer_id =3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ret-&gt;use_asymmetric_peer_id =3D false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* The rx_peer_id is also used to i=
dentify DCO clients */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ret-&gt;rx_peer_id =3D MAX_PEER_ID;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ret-&gt;tx_peer_id =3D MAX_PEER_ID;</span><br><s=
pan> </span><br><span>     return ret;</span><br><span> }</span><br><span>@=
@ -1181,6 +1184,15 @@</span><br><span> </span><br><span>     tls_session_in=
it(multi, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span>     tls_sess=
ion_init(multi, &amp;multi-&gt;session[TM_INITIAL]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!multi-&gt;opt=2Edco_enabled)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* Calculate the asymmetric peer-id */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (multi-&gt;rx_pee=
r_id =3D=3D MAX_PEER_ID &amp;&amp; multi-&gt;session[TM_INITIAL]=2Eopt-&gt;=
mode !=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     multi-&gt;rx_peer_id =3D (uint32_t)(get_random() % (MAX_PEER_ID - 1));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</spa=
n><br><span> </span><br><span> /*</span><br><span>@@ -1858,6 +1870,25 @@</s=
pan><br><span>     return str;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+push_peer_info_peerid(struct buffer=
 *out, struct tls_multi *multi, struct tls_session *session)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || s=
ession-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* No valid peer id or DCO is enabled=2E Cannot use this feature */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* In server mode we only add this when the clien=
t has announced its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * support for the feature */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (session-&gt;opt-&gt;mode !=3D MODE_SERVER || multi-&g=
t;use_asymmetric_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return buf_printf(out, &quot;ID=3D%x\n&quot;, multi-&gt;rx_peer_id);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /**</span><br><span>  * Prepares the IV_ and UV_ variables tha=
t are part of the</span><br><span>  * exchange to signal the peer&#39;s cap=
abilities=2E The amount</span><br><span>@@ -1871,15 +1902,22 @@</span><br><=
span>  *</span><br><span>  * @param buf       the buffer to write these var=
iables to</span><br><span>  * @param session   the TLS session object</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param multi     the T=
LS multi object</span><br><span>  * @return          true if no error was e=
ncountered</span><br><span>  */</span><br><span> static bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *buf, s=
truct tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+push_peer_info(struct buffer *buf, struct tls_multi *multi, struct =
tls_session *session)</span><br><span> {</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span>     bool ret =3D false;</span><br><spa=
n>     struct buffer out =3D alloc_buf_gc(512 * 3, &amp;gc);</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The asymm=
etric peer-id is always written when enabled */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!push_peer_info_peerid(&amp;out, multi,=
 session))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (session-&gt=
;opt-&gt;push_peer_info_detail &gt; 1)</span><br><span>     {</span><br><sp=
an>         /* push version */</span><br><span>@@ -2019,7 +2057,11 @@</span=
><br><span>                 }</span><br><span>             }</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* write peer info string if there is anything in it, empty string otherwi=
se */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(&=
amp;out) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span>         if (!write_string(buf, BSTR(&amp;out), -1))</sp=
an><br><span>         {</span><br><span>             goto error;</span><br>=
<span>@@ -2027,7 +2069,7 @@</span><br><span>     }</span><br><span>     els=
e</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (!write_empty_string(buf)) /* no peer info */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!write_empty_string(buf=
))</span><br><span>         {</span><br><span>             goto error;</spa=
n><br><span>         }</span><br><span>@@ -2156,7 +2198,7 @@</span><br><spa=
n>         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!push_peer_info(buf, session))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_info(=
buf, multi, session))</span><br><span>     {</span><br><span>         goto =
error;</span><br><span>     }</span><br><span>@@ -2269,6 +2311,19 @@</span>=
<br><span>     if (multi-&gt;peer_info)</span><br><span>     {</span><br><s=
pan>         output_peer_info_env(session-&gt;opt-&gt;es, multi-&gt;peer_in=
fo);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint32_=
t peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (peer_id !=3D MAX_PEE=
R_ID &amp;&amp; !session-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D peer_id;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;use_asy=
mmetric_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            multi-&gt;use_peer_id =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            /* Peer has no support for asymmetric peer-id, and DCO curre=
ntly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * =
can only handle symmetric peer IDs */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span>     }</span><br><span> </span><br><span>     free(multi-&gt;remote=
_ciphername);</span><br><span>@@ -4030,8 +4085,8 @@</span><br><span>     ms=
g(D_TLS_DEBUG, __func__);</span><br><span> </span><br><span>     ASSERT(ks)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    peer =3D htonl(((P_DATA_V2 &lt;&lt; P=
_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24 | (multi-&gt;peer_id &amp; 0xFF=
FFFF));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    peer =3D=
 htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 | (mu=
lti-&gt;tx_peer_id &amp; 0xFFFFFF));</span><br><span>     ASSERT(buf_write_=
prepend(buf, &amp;peer, 4));</span><br><span> }</span><br><span> </span><br=
><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh=
</span><br><span>index 9c90242=2E=2Ef6392f9 100644</span><br><span>--- a/sr=
c/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</=
span><br><span>@@ -696,8 +696,10 @@</span><br><span> #define AUTH_TOKEN_VAL=
ID_EMPTYUSER (1 &lt;&lt; 2)</span><br><span> </span><br><span>     /* For P=
_DATA_V2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32=
_t peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
32_t rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint32_t tx_peer_id;</span><br><span>     bool use_peer_id;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool use_asymmetric_peer_id;</=
span><br><span> </span><br><span>     char *remote_ciphername; /**&lt; ciph=
er specified in peer&#39;s config file */</span><br><span>     bool remote_=
usescomp;    /**&lt; remote announced comp-lzo in OCC string */</span><br><=
span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><=
br><span>index baf5a95=2E=2Eb450de8 100644</span><br><span>--- a/src/openvp=
n/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span=
>@@ -408,6 +408,7 @@</span><br><span> {</span><br><span>     /* will return=
 0 if peer_info is null */</span><br><span>     const unsigned int iv_proto=
_peer =3D extract_iv_proto(multi-&gt;peer_info);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const unsigned int tx_peer_id =3D extract_=
asymmetric_peer_id(multi-&gt;peer_info);</span><br><span> </span><br><span>=
     /* The other peer does not support P2P NCP */</span><br><span>     if =
(!(iv_proto_peer &amp; IV_PROTO_NCP_P2P))</span><br><span>@@ -418,7 +419,6 =
@@</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_DATA_V2)</span><br=
><span>     {</span><br><span>         multi-&gt;use_peer_id =3D true;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;peer_id =
=3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span>   =
  }</span><br><span> </span><br><span>     if (iv_proto_peer &amp; IV_PROTO=
_CC_EXIT_NOTIFY)</span><br><span>@@ -441,27 +441,42 @@</span><br><span>    =
 if (iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span>     {</s=
pan><br><span>         session-&gt;opt-&gt;crypto_flags |=3D CO_USE_TLS_KEY=
_MATERIAL_EXPORT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (multi-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (multi-&gt;use_peer_id)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* The asymmetric peer-id trumps on the EKM generated o=
nes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((=
iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &amp;&amp; (tx_peer_id !=3D MAX_PEER_I=
D) &amp;&amp; !multi-&gt;opt=2Edco_enabled)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;tx=
_peer_id =3D tx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            multi-&gt;use_asymmetric_peer_id =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            uint8_t peerid[3];</span><br><span>             /*=
 Using a non hardcoded peer-id makes a tiny bit harder to</span><br><span> =
             * fingerprint packets and also gives each connection a unique<=
/span><br><span>              * peer-id that can be useful for NAT tracking=
 etc=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            uint8_t peerid[3];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!key_st=
ate_export_keying_material(session, EXPORT_P2P_PEERID_LABEL,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
              strlen(EXPORT_P2P_PEERID_LABEL), &amp;peerid, 3))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if ((iv_proto_peer =
&amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                &amp;&amp; key_state_export_keying_material(sess=
ion, EXPORT_P2P_PEERID_LABEL,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                                    strlen(EXPORT=
_P2P_PEERID_LABEL), &amp;peerid, 3))</span><br><span>             {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                /* Non DCO se=
tup might still work but also this should never</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                 * happen or very likely the TLS =
encryption key exporter will</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                 * also fail */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                msg(M_NONFATAL, &quot;TLS key export for P=
2P peer id failed=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                &quot;Continuing anyway, expect probl=
ems&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&=
lt; 8) + peerid[2];</span><br><span>             }</span><br><span>        =
     else</span><br><span>             {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                multi-&gt;peer_id =3D (peerid[0] &lt;&lt=
; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                if (iv_proto_peer &amp; IV_PROTO_TL=
S_KEY_EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            /* Non DCO setup might still work but also this should never</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     *=
 happen or very likely the TLS encryption key exporter will</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     * also fail */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 msg(M_NONFATAL, &quot;TLS key export for P2P peer id failed=2E &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
            &quot;Continuing anyway, expect problems&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;rx_peer_id=
 =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span>  =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span>       =
  }</span><br><span>     }</span><br><span>     if (iv_proto_peer &amp; IV_=
PROTO_DYN_TLS_CRYPT)</span><br><span>@@ -502,11 +517,13 @@</span><br><span>=
         common_cipher =3D BSTR(&amp;out);</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_TLS=
_DEBUG_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &q=
uot;P2P mode NCP negotiation result: &quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        &quot;TLS_export=3D%d, DATA_v2=3D%d, peer-id =
%d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_T=
LS_KEY_MATERIAL_EXPORT), multi-&gt;use_peer_id,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        multi-&gt;peer_id, (bool)(session-&gt;opt=
-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP =
negotiation result: &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                         &quot;TLS_export=3D%d, DATA_v2=3D%d, rx-pee=
r-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypt=
o_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        multi-&gt;use_peer_id,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;rx_peer_id,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;tx_peer_i=
d,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (bool)(se=
ssion-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><=
span>         common_cipher);</span><br><span> </span><br><span>     gc_fre=
e(&amp;gc);</span><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/ope=
nvpn/ssl_util=2Ec</span><br><span>index 71fbc9e=2E=2E2f01f8a 100644</span><=
br><span>--- a/src/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/s=
sl_util=2Ec</span><br><span>@@ -24,7 +24,7 @@</span><br><span> #endif</span=
><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span> #in=
clude &quot;ssl_util=2Eh&quot;</span><br><span> </span><br><span> char *</s=
pan><br><span>@@ -72,6 +72,25 @@</span><br><span>     return 0;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+uint32_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extra=
ct_asymmetric_peer_id(const char *peer_info)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (const char *p =3D peer_info; p &amp;&amp; (p =3D strstr(p, =
&quot;ID=3D&quot;)); p +=3D 3)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* only accept &quot;ID=3D&quot; at the start of a line, so it does no=
t match</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * s=
ubstrings like &quot;UV_ID=3D&quot; or &quot;GUID=3D&quot; */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D peer_info ||=
 p[-1] =3D=3D &#39;\n&#39;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          uint32_t peer_id =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (sscanf(p, &quot;ID=3D%x&quot;, &amp;peer_id) =
=3D=3D 1 &amp;&amp; peer_id &lt; MAX_PEER_ID)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                return peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> const char *</span><br><span> options_string_compat_lzo(const char =
*options, struct gc_arena *gc)</span><br><span> {</span><br><span>diff --gi=
t a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh</span><br><span>ind=
ex 2177d94=2E=2E1a69e6f 100644</span><br><span>--- a/src/openvpn/ssl_util=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_util=2Eh</span><br><span>@@ -53,=
6 +53,15 @@</span><br><span>  */</span><br><span> unsigned int extract_iv_p=
roto(const char *peer_info);</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extra=
cts the ID variable and returns its value or</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * MAX_PEER_ID if it cannot be extracted=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param peer_info     peer info string =
to search for ID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_t extract_as=
ymmetric_peer_id(const char *peer_info);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Takes a loca=
lly produced OCC string for TLS server mode and modifies as</span><br><span=
>  * if the option comp-lzo was enabled=2E This is to send a client in</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf2=
0eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 30 </div>
=
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--KpBUfjOiapg=--


--===============3863943053012279776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3863943053012279776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3863943053012279776==--

