Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3222AC531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7W6RYPdMiWEyNPc7Qpo1nGNV9hyLosAuIcZd+i3jF4k=; b=AtiVS27vsX2pHnuwJVeKizJceF
	2J0LevFEw0OHEBFMDh08q3/wy2oIprU//awi5p6JValU3wsqcUrQ/85UI220zAbvYK/auIPbIuWqj
	36biCACkUweHBx9LHCneoHkQa82wNqedtqoSxIkTZAOW0MRlgpb7+OuW1n2iIxdTprpY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIKq-0002lq-Qx;
	Fri, 24 Jul 2026 16:01:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIKf-0002lX-GB
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4e5ipVGtsnCDSu6kT2eZgewCKSNCCOvgwDlgqbyZ9HM=; b=bBx2EB1KZ7bEYQsT/P5yVTl7ja
 nI4R+0P3rFcJFckFFLih/OECSQqK6Fn2NiBx6lwud6xorLGdWv8mLijQZIRzPNnN/PZ/Bl2Izi6hx
 u4MzMQAtZBT3nXc7M46vntwu6jlOJ4dNB/5jhdO0NZBT6xIAPdwO4IorbwmL+BiAOcys=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4e5ipVGtsnCDSu6kT2eZgewCKSNCCOvgwDlgqbyZ9HM=; b=l
 PXmTT3dTwSFKjkpBIk44NruM7ySp6oabbFXZObaQET1zDNjuoLMsJlQ06dABpkkn2NmAju/+0gr//
 vRfF3Q63qy6GD60DSZwn5bBarzYgh1dqqofyXItaWJ3/8XF5T7FF/XlSsaCLPx8NVFj4sC7AoATBW
 u30Opppn4KKUouKQ=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIKb-0000dr-SW for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:05 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so321228f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784908855; x=1785513655; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4e5ipVGtsnCDSu6kT2eZgewCKSNCCOvgwDlgqbyZ9HM=;
 b=c1nlb1C+JWJo2BNC0ZSCMny0MeTLDBqQ2wf5yQt3AY9ztbv9E+HqoF3GCrw0Md3pD+
 yJ/x3Fe1+su2eo6vPnbgRdJRUq7Qqh9aCdD870Sb9kV+pRvMx+hDjOrpYsdiH72YJh8T
 fU+jhSW7bDPq42/WHXBF+YTt71bAubmyw/18yIPORVWiKzJrKLJgJOmpbvJdR2KBrr8T
 3ilJkuUQqS9X9CQrypsd/Bx54jmJDJd0eq2Joqw2AgvTCO1kLBaKZuMERFhTrlKLZbdR
 pQhN2nlU4nAnlhY33a1BfJ1WarOW5BDaTXpHTC3N3nKNzBRzm0wCxu++KBB7KdsJ297t
 ZFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784908855; x=1785513655;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4e5ipVGtsnCDSu6kT2eZgewCKSNCCOvgwDlgqbyZ9HM=;
 b=rcLzKMVaMXmxWj9pGmM5zMC2LQn6Hj/QZbzhDjlZwyrrU06HseQD45ztPe34esrR4e
 r9aibDULaefzoP3CF+BlOLW1rAY2YjED9U4BCycVGxLkuccmhb7taF/Oc8UYTlHleqd9
 iZF0WXdkG3Ly89ipvPFc4gh9vUbxZ62t3H6bghYA7Yto2qUlfiBN5u4Xph60+3yaTQOF
 dGsif5HKukTRLYbjttO3hFdlcB8uG62QFaIvlMaJYL9FDD/5MvEK3+iCUb+X/CWID6AR
 l+QLxIIcHlUyjflZxUD1bvMGjhaQyZC1XSeKrhNvmCmWq8xectAcCWVVRK3ARC3gMBVw
 VKVw==
X-Gm-Message-State: AOJu0YyrusccNB90baT71w3dvo9oo+Sf9L+r310jgdYrmVtNUHmvDDtB
 oCgeHD+W0dfptrBk5BQrL6IFR5g0CProItxCbxoYNJhFgUZigs+38HNo9HgLsHDr39axEELW4Rn
 ooy0rEX4BfTQ/Yi0s3E176SYnBqmH8AobpykFiOTgqFj9x0x/7lS/kerPZr2NeXovLrHd
X-Gm-Gg: AR+sD10jMO6W0CH6DTRLGDNgQ2jMEOFy32KTMVL0Yhk2Qtk3xgjNX5+0VgPqUmsJy7L
 IkeAyG2qbNGoG1PJ3Xng36oKWwQ43JsPt96oWEzQOTmu+esjfZPvSUvNewW24jHQDb+8AmAPQSG
 ahNe1VNtvGxrodF3GWPRBz32yPc9JNHzPquKcM9xqxhJMwV1/W8NwiQDf6kT6Y5PhhVI9Jdp/9g
 U1OxpxVHaIfY3C6gmtyvT+xbLS7R73AJ95WfWSVdAs+upi9oGEIzyi4s81ezwgLYjxdDbP7JqvZ
 FuiufuXvhxeErY/pfgWkXMFKstL/LuzxFWf4zzOI4b4q/EsMtNeji4UGdpPju0m9FQHV2M9njO1
 Twd2xA5fzvTKMUF4y6e4pLdFD/XX9vhBKxfR9XWg28BXB4TzEdLQqLcKUTe6Eaa2wrYVgb0jl/e
 uZJHFEP7fXd592VXFLocTD6Al1wBwq41j4bMCQr4IVLQ/SiaO9yOGlerq12fPhUzSGDhnyoybcH
 +XMlYP2++7nQuw1YFktAlokuyEAuHigmFrlORad0V2xl1zuPpVKehAc/DoHbCJU0l8Q
X-Received: by 2002:a05:6000:4a03:b0:47f:8110:3073 with SMTP id
 ffacd0b85a97d-47f8da8a56dmr9490258f8f.24.1784908854488; 
 Fri, 24 Jul 2026 09:00:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96b9abc0sm6737960f8f.32.2026.07.24.09.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:00:53 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:00:47 +0000
To: its_Giaan <gianmarco@mandelbit.com>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: dd514838ac7c65141c7c0296e5c8d86382e27c93
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0657441f96cb6a12f6f22f25bec7e75c404c3bef-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIKb-0000dr-SW
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multipeer: introduce
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0053189252300482612=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0053189252300482612==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OtzomPwf4Sg="; charset=UTF-8

--OtzomPwf4Sg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, ordex=
=2E

plaisthos has uploaded a new patch set (#22) to the change originally =
created by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?us=
p=3Demail )


Change subject: multipeer: introduce asymmetric peer-id
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multipeer: intro=
duce asymmetric peer-id

In order to achieve a multipeer functionality, pee=
rs now
use separate IDs for sending (tx_peer_id) and receiving
(rx_peer_id)=
=2E

Each peer announces its own ID through pushing peer-info
using 'ID=3D7=
f1' hex format so identification can still
happen even if IP/port changes=
=2E

In P2P mode, peer switch to using the announced IDs after
mutual excha=
nge=2E
In P2MP mode, clients always announce their ID, and servers
can opti=
onally respond with their own to enable the same
behavior=2E

Change-Id: I0=
a13ee90b6706acf20eabcee3bab3f2dff639bf9
Signed-off-by: Gianmarco De Gregori=
 <gianmarco@mandelbit=2Ecom>
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
---
M src/openvpn/dco=2Ec
M src/openvpn/init=2Ec
M src/openvpn/misc=2Ec
=
M src/openvpn/multi=2Ec
M src/openvpn/push=2Ec
M src/openvpn/push_util=2Ec
=
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_ncp=2E=
c
M src/openvpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
11 files changed, 2=
03 insertions(+), 53 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/89/1089/22

diff --git a/src/openvpn/dco=2Ec b/=
src/openvpn/dco=2Ec
index 2584368=2E=2Ece73701 100644
--- a/src/openvpn/dco=
=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -544,14 +544,15 @@
         c->c2=2Etls_m=
ulti->dco_peer_id =3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->=
c1=2Etuntap->dco, multi->peer_id, sock->sd, NULL,
-                        =
   proto_is_dgram(sock->info=2Eproto) ? remoteaddr : NULL, NULL, NULL);
+  =
  int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_id, sock->s=
d, NULL,
+                           proto_is_dgram(sock->info=2Eproto) ? r=
emoteaddr : NULL,
+                           NULL, NULL);
     if (ret < 0=
)
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
index 914d191=2E=2Ee300af1 100644
--- a/src/openvpn/in=
it=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2209,7 +2209,7 @@
 
     if (o->use_p=
eer_id)
     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+   =
     buf_printf(&out, ", rx-peer-id: %u, tx-peer-id: %u", c->c2=2Etls_multi=
->rx_peer_id, c->c2=2Etls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ =
-2679,7 +2679,11 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer=
-id set");
         c->c2=2Etls_multi->use_peer_id =3D true;
-        c->c2=
=2Etls_multi->peer_id =3D c->options=2Epeer_id;
+        c->c2=2Etls_multi-=
>tx_peer_id =3D c->options=2Epeer_id;
+        if (!c->c2=2Etls_multi->use_=
asymmetric_peer_id)
+        {
+            c->c2=2Etls_multi->rx_peer_id =
=3D c->options=2Epeer_id;
+        }
     }
 
     /* process (potentially)=
 pushed options */
@@ -3476,6 +3480,10 @@
     if (c->c2=2Etls_multi)
     =
{
         tls_multi_init_finalize(c->c2=2Etls_multi, c->options=2Ece=2Etls=
_mtu);
+        if (c->c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
+      =
  {
+            c->options=2Euse_peer_id =3D true;
+        }
         ASS=
ERT(c->c2=2Etls_multi->opt=2Eframe=2Ebuf=2Epayload_size <=3D c->c2=2Eframe=
=2Ebuf=2Epayload_size);
         frame_print(&c->c2=2Etls_multi->opt=2Efram=
e, D_MTU_INFO, "Control Channel MTU parms");
 
diff --git a/src/openvpn/mis=
c=2Ec b/src/openvpn/misc=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/op=
envpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
    =
     chomp(line);
         if (validate_peer_info_line(line)
-            &=
& (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
+=
            && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3)=
 =3D=3D 0
+                || strncmp(line, "ID", 2) =3D=3D 0))
         {
=
             msg(M_INFO, "peer info: %s", line);
             env_set_add(e=
s, line);
         }
         else
         {
-            msg(M_WARN, "val=
idation failed on peer_info line received from client");
+            msg(M=
_WARN, "validation failed on peer_info line received");
         }
     }
 =
}
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index fe2badb=
=2E=2Ef823f5b 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -430,7 +430,7 @@
         if (mi->context=2Ec2=2Etls_multi && check_de=
bug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context=2Eoptions))=

         {
-            buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=
=2Etls_multi->peer_id);
+            buf_printf(&out, " rx-peer-id=3D%d", m=
i->context=2Ec2=2Etls_multi->rx_peer_id);
         }
         return BSTR(&=
out);
     }
@@ -598,9 +598,9 @@
         }
 #endif
 
-        if (mi->cont=
ext=2Ec2=2Etls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context=2E=
c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->ins=
tances[mi->context=2Ec2=2Etls_multi->peer_id] =3D NULL;
+            m->ins=
tances[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
 
             /=
* Adjust the max_peerid as this might have been the highest
              *=
 peer id instance */
@@ -908,8 +908,7 @@
 #else
                         se=
p,
 #endif
-                        sep,
-                        mi->conte=
xt=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+=
                        sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec=
2=2Etls_multi->rx_peer_id : MAX_PEER_ID,
                         sep, tran=
slate_cipher_name_to_openvpn(mi->context=2Eoptions=2Eciphername));
        =
         }
                 gc_free(&gc);
@@ -3121,12 +3120,12 @@
         =
 * has, so we disallow it=2E This can happen if a DCO netlink notification
=
          * gets lost and we miss a floating step=2E
          */
-        =
if (m1->peer_id =3D=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->=
rx_peer_id)
         {
             msg(M_WARN,
                 "disallowi=
ng peer %" PRIu32 " (%s) from floating to "
                 "its own addre=
ss (%s)",
-                m1->peer_id, tls_common_name(mi->context=2Ec2=2E=
tls_multi, false),
+                m1->rx_peer_id, tls_common_name(mi->con=
text=2Ec2=2Etls_multi, false),
                 mroute_addr_print(&mi->real=
, &gc));
             goto done;
         }
@@ -3139,7 +3138,8 @@
     }
 
=
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-  =
      mi->context=2Ec2=2Etls_multi->peer_id, tls_common_name(mi->context=2E=
c2=2Etls_multi, false),
+        mi->context=2Ec2=2Etls_multi->rx_peer_id,
=
+        tls_common_name(mi->context=2Ec2=2Etls_multi, false),
         mro=
ute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
         mroute_addr_p=
rint_ex(&real, MAPF_SHOW_FAMILY, &gc));
 
@@ -4099,7 +4099,7 @@
     {
    =
     if (!m->instances[i])
         {
-            mi->context=2Ec2=2Etls_m=
ulti->peer_id =3D i;
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
 
diff --git a/src/openvpn/push=
=2Ec b/src/openvpn/push=2Ec
index e391147=2E=2E633c007d 100644
--- a/src/op=
envpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -661,9 +661,9 @@
             =
            print_in_addr_t(c->c2=2Epush_ifconfig_remote_netmask, 0, gc));
=
     }
 
-    if (tls_multi->use_peer_id)
+    if (tls_multi->use_peer_id &=
& !tls_multi->use_asymmetric_peer_id)
     {
-        push_option_fmt(gc, p=
ush_list, M_USAGE, "peer-id %d", tls_multi->peer_id);
+        push_option_=
fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->rx_peer_id);
     }
  =
   /*
      * If server uses --auth-gen-token and we have an auth token
dif=
f --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index f57f5=
4d=2E=2Ec927f26 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/pu=
sh_util=2Ec
@@ -188,7 +188,7 @@
         unsigned int permission_mask =3D p=
ull_permission_mask(c);
         if (process_push_update(c, &o, permission_=
mask, &option_types_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         =
{
-            msg(M_WARN, "Failed to process push update message sent to c=
lient ID: %u", c->c2=2Etls_multi->peer_id);
+            msg(M_WARN, "Faile=
d to process push update message sent to client ID: %u", c->c2=2Etls_multi-=
>rx_peer_id);
         }
         e =3D e->next;
     }
@@ -294,7 +294,7 @@=

 
         if (!support_push_update(mi))
         {
-            msg(M_CLI=
ENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi=
->context=2Ec2=2Etls_multi->peer_id);
+            msg(M_CLIENT, "PUSH_UPDA=
TE: not sending message to unsupported peer with ID: %u", mi->context=2Ec2=
=2Etls_multi->rx_peer_id);
             buffer_list_free(msgs);
           =
  gc_free(&gc);
             return 0;
@@ -329,7 +329,7 @@
         /* Type=
 is UPT_BROADCAST so we update every client */
         if (!send_single_pu=
sh_update(m, curr_mi, msgs))
         {
-            msg(M_CLIENT, "ERROR: =
Peer ID: %u has not been updated", curr_mi->context=2Ec2=2Etls_multi->peer_=
id);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", =
curr_mi->context=2Ec2=2Etls_multi->rx_peer_id);
             continue;
    =
     }
         count++;
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec
index 60df7ce=2E=2Eb1bfe85 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/=
openvpn/ssl=2Ec
@@ -1168,7 +1168,10 @@
     /* get command line derived opt=
ions */
     ret->opt =3D *tls_options;
     ret->dco_peer_id =3D -1;
-    =
ret->peer_id =3D MAX_PEER_ID;
+    ret->use_asymmetric_peer_id =3D false;
+=
    /* The rx_peer_id is also used to identify DCO clients */
+    ret->rx_=
peer_id =3D MAX_PEER_ID;
+    ret->tx_peer_id =3D MAX_PEER_ID;
 
     retur=
n ret;
 }
@@ -1181,6 +1184,27 @@
 
     tls_session_init(multi, &multi->ses=
sion[TM_ACTIVE]);
     tls_session_init(multi, &multi->session[TM_INITIAL])=
;
+
+    if (!multi->opt=2Edco_enabled)
+    {
+        /* Calculate the as=
ymmetric peer-id */
+        if (multi->rx_peer_id =3D=3D MAX_PEER_ID && mu=
lti->session[TM_INITIAL]=2Eopt->mode !=3D MODE_SERVER)
+        {
+        =
    uint8_t peerid[3];
+
+            do
+            {
+                if=
 (rand_bytes(peerid, sizeof(peerid)) !=3D 1)
+                {
+          =
          msg(M_FATAL, "rand_bytes() failed");
+                }
+
+      =
          multi->rx_peer_id =3D ((uint32_t)peerid[0] << 16)
+              =
                      | ((uint32_t)peerid[1] << 8)
+                       =
             | (uint32_t)peerid[2];
+            } while (multi->rx_peer_id=
 =3D=3D MAX_PEER_ID);
+        }
+    }
 }
 
 /*
@@ -1858,6 +1882,25 @@
   =
  return str;
 }
 
+static bool
+push_peer_info_peerid(struct buffer *out, =
struct tls_multi *multi, struct tls_session *session)
+{
+    if (multi->rx=
_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
+    {
+        /=
* No valid peer id or DCO is enabled=2E Cannot use this feature */
+       =
 return true;
+    }
+
+    /* In server mode we only add this when the cli=
ent has announced its
+     * support for the feature */
+    if (session->=
opt->mode !=3D MODE_SERVER || multi->use_asymmetric_peer_id)
+    {
+      =
  return buf_printf(out, "ID=3D%x\n", multi->rx_peer_id);
+    }
+
+    ret=
urn true;
+}
+
 /**
  * Prepares the IV_ and UV_ variables that are part of=
 the
  * exchange to signal the peer's capabilities=2E The amount
@@ -1871,=
15 +1914,22 @@
  *
  * @param buf       the buffer to write these variables=
 to
  * @param session   the TLS session object
+ * @param multi     the TL=
S multi object
  * @return          true if no error was encountered
  */
 =
static bool
-push_peer_info(struct buffer *buf, struct tls_session *session=
)
+push_peer_info(struct buffer *buf, struct tls_multi *multi, struct tls_s=
ession *session)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D=
 false;
     struct buffer out =3D alloc_buf_gc(512 * 3, &gc);
 
+    /* Th=
e asymmetric peer-id is always written when enabled */
+    if (!push_peer_=
info_peerid(&out, multi, session))
+    {
+        goto error;
+    }
+
   =
  if (session->opt->push_peer_info_detail > 1)
     {
         /* push vers=
ion */
@@ -2027,9 +2077,19 @@
     }
     else
     {
-        if (!write_e=
mpty_string(buf)) /* no peer info */
+        if (session->opt->mode =3D=3D=
 MODE_SERVER && multi->use_asymmetric_peer_id)
         {
-            goto=
 error;
+            if (!write_string(buf, BSTR(&out), -1))
+            {=

+                goto error;
+            }
+        }
+        else
+    =
    {
+            if (!write_empty_string(buf))
+            {
+          =
      goto error;
+            }
         }
     }
     ret =3D true;
@@ -2=
156,7 +2216,7 @@
         }
     }
 
-    if (!push_peer_info(buf, session)=
)
+    if (!push_peer_info(buf, multi, session))
     {
         goto error=
;
     }
@@ -2269,6 +2329,39 @@
     if (multi->peer_info)
     {
         =
output_peer_info_env(session->opt->es, multi->peer_info);
+        if (sess=
ion->opt->mode =3D=3D MODE_SERVER)
+        {
+            if (!session->op=
t->dco_enabled)
+            {
+                uint32_t peer_id =3D extrac=
t_asymmetric_peer_id(multi->peer_info);
+                if (peer_id !=3D M=
AX_PEER_ID)
+                {
+                    multi->tx_peer_id =3D p=
eer_id;
+                    multi->use_asymmetric_peer_id =3D true;
+     =
               multi->use_peer_id =3D true;
+                }
+           =
     else
+                {
+                    /* Client has no asymmetr=
ic peer-id capability */
+                    multi->tx_peer_id =3D multi->=
rx_peer_id;
+                }
+            }
+            else
+          =
  {
+                /* With DCO we don't need the tx_peer_id atm */
+     =
           multi->tx_peer_id =3D multi->rx_peer_id;
+            }
+       =
 }
+        if (session->opt->mode =3D=3D MODE_POINT_TO_POINT && !session->=
opt->dco_enabled)
+        {
+            uint32_t peer_id =3D extract_asym=
metric_peer_id(multi->peer_info);
+            if (peer_id !=3D MAX_PEER_ID=
)
+            {
+                multi->tx_peer_id =3D peer_id;
+         =
       multi->use_asymmetric_peer_id =3D true;
+                multi->use_=
peer_id =3D true;
+            }
+        }
     }
 
     free(multi->remot=
e_ciphername);
@@ -4016,8 +4109,8 @@
     msg(D_TLS_DEBUG, __func__);
 
   =
  ASSERT(ks);
-
-    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->ke=
y_id) << 24 | (multi->peer_id & 0xFFFFFF));
+    peer =3D htonl(((P_DATA_V2=
 << P_OPCODE_SHIFT) | ks->key_id) << 24
+                 | (multi->tx_peer=
_id & 0xFFFFFF));
     ASSERT(buf_write_prepend(buf, &peer, 4));
 }
 
diff =
--git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9c902=
42=2E=2Ef6392f9 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/s=
sl_common=2Eh
@@ -696,8 +696,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUSER (1 <=
< 2)
 
     /* For P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t rx_pee=
r_id;
+    uint32_t tx_peer_id;
     bool use_peer_id;
+    bool use_asymme=
tric_peer_id;
 
     char *remote_ciphername; /**< cipher specified in peer=
's config file */
     bool remote_usescomp;    /**< remote announced comp-=
lzo in OCC string */
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl=
_ncp=2Ec
index baf5a95=2E=2Eb450de8 100644
--- a/src/openvpn/ssl_ncp=2Ec
++=
+ b/src/openvpn/ssl_ncp=2Ec
@@ -408,6 +408,7 @@
 {
     /* will return 0 if=
 peer_info is null */
     const unsigned int iv_proto_peer =3D extract_iv_=
proto(multi->peer_info);
+    const unsigned int tx_peer_id =3D extract_asy=
mmetric_peer_id(multi->peer_info);
 
     /* The other peer does not suppor=
t P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -418,7 +419,6=
 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_p=
eer_id =3D true;
-        multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
  =
   }
 
     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -441,27 +441,42=
 @@
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
         sessi=
on->opt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
+    }
 
-      =
  if (multi->use_peer_id)
+    if (multi->use_peer_id)
+    {
+        /* T=
he asymmetric peer-id trumps on the EKM generated ones */
+        if ((iv_=
proto_peer & IV_PROTO_TLS_KEY_EXPORT)
+            && (tx_peer_id !=3D MAX_=
PEER_ID) && !multi->opt=2Edco_enabled)
         {
+            multi->tx_pe=
er_id =3D tx_peer_id;
+            multi->use_asymmetric_peer_id =3D true;
=
+        }
+        else
+        {
+            uint8_t peerid[3];
       =
      /* Using a non hardcoded peer-id makes a tiny bit harder to
         =
     * fingerprint packets and also gives each connection a unique
        =
      * peer-id that can be useful for NAT tracking etc=2E */
-
-          =
  uint8_t peerid[3];
-            if (!key_state_export_keying_material(ses=
sion, EXPORT_P2P_PEERID_LABEL,
-                                           =
       strlen(EXPORT_P2P_PEERID_LABEL), &peerid, 3))
+            if ((iv_p=
roto_peer & IV_PROTO_TLS_KEY_EXPORT)
+                && key_state_export_k=
eying_material(session, EXPORT_P2P_PEERID_LABEL,
+                         =
                           strlen(EXPORT_P2P_PEERID_LABEL), &peerid, 3))
  =
           {
-                /* Non DCO setup might still work but also th=
is should never
-                 * happen or very likely the TLS encryptio=
n key exporter will
-                 * also fail */
-                msg(M=
_NONFATAL, "TLS key export for P2P peer id failed=2E "
-                   =
             "Continuing anyway, expect problems");
+                multi-=
>rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
         =
    }
             else
             {
-                multi->peer_id =3D =
(peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+                if (iv_p=
roto_peer & IV_PROTO_TLS_KEY_EXPORT)
+                {
+                  =
  /* Non DCO setup might still work but also this should never
+           =
          * happen or very likely the TLS encryption key exporter will
+   =
                  * also fail */
+                    msg(M_NONFATAL, "TLS =
key export for P2P peer id failed=2E "
+                                   =
 "Continuing anyway, expect problems");
+                }
+               =
 multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
             }
+        =
    multi->tx_peer_id =3D multi->rx_peer_id;
         }
     }
     if (iv_=
proto_peer & IV_PROTO_DYN_TLS_CRYPT)
@@ -502,11 +517,13 @@
         common_=
cipher =3D BSTR(&out);
     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mod=
e NCP negotiation result: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-i=
d %d, epoch=3D%d, cipher=3D%s",
-        (bool)(session->opt->crypto_flags =
& CO_USE_TLS_KEY_MATERIAL_EXPORT), multi->use_peer_id,
-        multi->peer=
_id, (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    ms=
g(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
+                   =
      "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=
=3D%d, cipher=3D%s",
+        (bool)(session->opt->crypto_flags & CO_USE_TL=
S_KEY_MATERIAL_EXPORT),
+        multi->use_peer_id,
+        multi->rx_pee=
r_id,
+        multi->tx_peer_id,
+        (bool)(session->opt->crypto_flag=
s & CO_EPOCH_DATA_KEY_FORMAT),
         common_cipher);
 
     gc_free(&gc)=
;
diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 71=
fbc9e=2E=2E2f01f8a 100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/=
ssl_util=2Ec
@@ -24,7 +24,7 @@
 #endif
 
 #include "syshead=2Eh"
-
+#includ=
e "openvpn=2Eh"
 #include "ssl_util=2Eh"
 
 char *
@@ -72,6 +72,25 @@
     =
return 0;
 }
 
+uint32_t
+extract_asymmetric_peer_id(const char *peer_info)=

+{
+    for (const char *p =3D peer_info; p && (p =3D strstr(p, "ID=3D"));=
 p +=3D 3)
+    {
+        /* only accept "ID=3D" at the start of a line, s=
o it does not match
+         * substrings like "UV_ID=3D" or "GUID=3D" */
=
+        if (p =3D=3D peer_info || p[-1] =3D=3D '\n')
+        {
+         =
   uint32_t peer_id =3D 0;
+            if (sscanf(p, "ID=3D%x", &peer_id) =
=3D=3D 1 && peer_id < MAX_PEER_ID)
+            {
+                return p=
eer_id;
+            }
+        }
+    }
+    return MAX_PEER_ID;
+}
+
 con=
st char *
 options_string_compat_lzo(const char *options, struct gc_arena *=
gc)
 {
diff --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
ind=
ex 2177d94=2E=2E1a69e6f 100644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/ope=
nvpn/ssl_util=2Eh
@@ -53,6 +53,15 @@
  */
 unsigned int extract_iv_proto(co=
nst char *peer_info);
 
+
+/**
+ * Extracts the ID variable and returns its=
 value or
+ * MAX_PEER_ID if it cannot be extracted=2E
+ *
+ * @param peer_=
info     peer info string to search for ID
+ */
+uint32_t extract_asymmetri=
c_peer_id(const char *peer_info);
+
 /**
  * Takes a locally produced OCC s=
tring for TLS server mode and modifies as
  * if the option comp-lzo was en=
abled=2E This is to send a client in

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change=
-Number: 1089
Gerrit-PatchSet: 22
Gerrit-Owner: its_Giaan <gianmarco@mandel=
bit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: =
its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Attention: ordex <antonio@mandelbit=2Ecom>

--OtzomPwf4Sg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, ordex=2E </p>
<p>plai=
sthos <strong>uploaded patch set #22</strong> to the change originally crea=
ted by its_Giaan=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1089?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">multipeer: introduce=
 asymmetric peer-id<br><br>In order to achieve a multipeer functionality, p=
eers now<br>use separate IDs for sending (tx_peer_id) and receiving<br>(rx_=
peer_id)=2E<br><br>Each peer announces its own ID through pushing peer-info=
<br>using &#39;ID=3D7f1&#39; hex format so identification can still<br>happ=
en even if IP/port changes=2E<br><br>In P2P mode, peer switch to using the =
announced IDs after<br>mutual exchange=2E<br>In P2MP mode, clients always a=
nnounce their ID, and servers<br>can optionally respond with their own to e=
nable the same<br>behavior=2E<br><br>Change-Id: I0a13ee90b6706acf20eabcee3b=
ab3f2dff639bf9<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelb=
it=2Ecom&gt;<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>-=
--<br>M src/openvpn/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/misc=
=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/=
push_util=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M=
 src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/ssl=
_util=2Eh<br>11 files changed, 203 insertions(+), 53 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/89/1089/22</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/d=
co=2Ec</span><br><span>index 2584368=2E=2Ece73701 100644</span><br><span>--=
- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br=
><span>@@ -544,14 +544,15 @@</span><br><span>         c-&gt;c2=2Etls_multi-=
&gt;dco_peer_id =3D -1;</span><br><span>     }</span><br><span> #endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_pe=
er(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
   proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL, NULL, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_=
new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd,=
 NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
              proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
     NULL, NULL);</span><br><span>     if (ret &lt; 0)</span><br><span>    =
 {</span><br><span>         return ret;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Et=
ls_multi-&gt;dco_peer_id =3D multi-&gt;peer_id;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D mu=
lti-&gt;rx_peer_id;</span><br><span> </span><br><span>     return 0;</span>=
<br><span> }</span><br><span>@@ -626,7 +627,7 @@</span><br><span> {</span><=
br><span>     struct context *c =3D &amp;mi-&gt;context;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =3D c-=
&gt;c2=2Etls_multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span>=
<br><span>     struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br>=
<span>     struct sockaddr_storage local =3D { 0 };</span><br><span>     co=
nst socket_descriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><br=
><span>@@ -706,7 +707,7 @@</span><br><span>     {</span><br><span> #if defi=
ned(_WIN32)</span><br><span>         dco_win_add_iroute_ipv6(&amp;c-&gt;c1=
=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                c-&gt;c2=
=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                c-&gt;c2=2Etls_multi-&gt;rx_peer_id)=
;</span><br><span> #else</span><br><span>         const struct in6_addr *ga=
teway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><s=
pan>         if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><span>@@=
 -723,7 +724,7 @@</span><br><span>     {</span><br><span> #if defined(_WIN3=
2)</span><br><span>         dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-=
&gt;dco, addr-&gt;v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                c-&gt;c2=2Etls_mul=
ti-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                             c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><b=
r><span> #else</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v=
4=2Eaddr);</span><br><span>         const in_addr_t *gateway =3D &amp;mi-&g=
t;context=2Ec2=2Epush_ifconfig_local;</span><br><span>diff --git a/src/open=
vpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 914d191=2E=2Ee300=
af1 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b=
/src/openvpn/init=2Ec</span><br><span>@@ -2209,7 +2209,7 @@</span><br><span=
> </span><br><span>     if (o-&gt;use_peer_id)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out=
, &quot;, peer-id: %d&quot;, o-&gt;peer_id);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;, rx-peer-id: %=
u, tx-peer-id: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id, c-&gt;c2=2Etl=
s_multi-&gt;tx_peer_id);</span><br><span>     }</span><br><span> </span><br=
><span> #ifdef USE_COMP</span><br><span>@@ -2679,7 +2679,11 @@</span><br><s=
pan>     {</span><br><span>         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT:=
 peer-id set&quot;);</span><br><span>         c-&gt;c2=2Etls_multi-&gt;use_=
peer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    c-&gt;c2=2Etls_multi-&gt;peer_id =3D c-&gt;options=2Epeer_id;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Etls_multi-=
&gt;tx_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!c-&gt;c2=2Etls_multi-&gt;use_asymmetri=
c_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c=
2=2Etls_multi-&gt;rx_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</spa=
n><br><span> </span><br><span>     /* process (potentially) pushed options =
*/</span><br><span>@@ -3476,6 +3480,10 @@</span><br><span>     if (c-&gt;c2=
=2Etls_multi)</span><br><span>     {</span><br><span>         tls_multi_ini=
t_finalize(c-&gt;c2=2Etls_multi, c-&gt;options=2Ece=2Etls_mtu);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=2Etls_mult=
i-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            c-&gt;options=2Euse_peer_id =3D true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         ASSER=
T(c-&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Ebuf=2Epayload_size &lt;=3D c-&gt;c=
2=2Eframe=2Ebuf=2Epayload_size);</span><br><span>         frame_print(&amp;=
c-&gt;c2=2Etls_multi-&gt;opt=2Eframe, D_MTU_INFO, &quot;Control Channel MTU=
 parms&quot;);</span><br><span> </span><br><span>diff --git a/src/openvpn/m=
isc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index 10bfc35=2E=2Ea8c88c9 1=
00644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/=
openvpn/misc=2Ec</span><br><span>@@ -765,14 +765,15 @@</span><br><span>    =
 {</span><br><span>         chomp(line);</span><br><span>         if (valid=
ate_peer_info_line(line)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || st=
rncmp(line, &quot;UV_&quot;, 3) =3D=3D 0))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &amp;&amp; (strncmp(line, &quot;IV_&quot=
;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                || strncmp(line, &=
quot;ID&quot;, 2) =3D=3D 0))</span><br><span>         {</span><br><span>   =
          msg(M_INFO, &quot;peer info: %s&quot;, line);</span><br><span>   =
          env_set_add(es, line);</span><br><span>         }</span><br><span=
>         else</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_WARN, &quot;validation failed on peer=
_info line received from client&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_WARN, &quot;validation failed on peer=
_info line received&quot;);</span><br><span>         }</span><br><span>    =
 }</span><br><span> }</span><br><span>diff --git a/src/openvpn/multi=2Ec b/=
src/openvpn/multi=2Ec</span><br><span>index fe2badb=2E=2Ef823f5b 100644</sp=
an><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/=
multi=2Ec</span><br><span>@@ -430,7 +430,7 @@</span><br><span>         if (=
mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</=
span><br><span>             &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eop=
tions))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            buf_printf(&amp;out, &quot; peer-id=3D%d&quot;, mi=
-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot; rx-peer-id=
=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><sp=
an>         }</span><br><span>         return BSTR(&amp;out);</span><br><sp=
an>     }</span><br><span>@@ -598,9 +598,9 @@</span><br><span>         }</s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id !=
=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id=
] =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NUL=
L;</span><br><span> </span><br><span>             /* Adjust the max_peerid =
as this might have been the highest</span><br><span>              * peer id=
 instance */</span><br><span>@@ -908,8 +908,7 @@</span><br><span> #else</sp=
an><br><span>                         sep,</span><br><span> #endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        sep,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;peer=
_id : UINT32_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      sep, mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=
=2Ec2=2Etls_multi-&gt;rx_peer_id : MAX_PEER_ID,</span><br><span>           =
              sep, translate_cipher_name_to_openvpn(mi-&gt;context=2Eoption=
s=2Eciphername));</span><br><span>                 }</span><br><span>      =
           gc_free(&amp;gc);</span><br><span>@@ -3121,12 +3120,12 @@</span>=
<br><span>          * has, so we disallow it=2E This can happen if a DCO ne=
tlink notification</span><br><span>          * gets lost and we miss a floa=
ting step=2E</span><br><span>          */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (m1-&gt;peer_id =3D=3D m2-&gt;peer_id)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m1-&gt;rx_pee=
r_id =3D=3D m2-&gt;rx_peer_id)</span><br><span>         {</span><br><span> =
            msg(M_WARN,</span><br><span>                 &quot;disallowing =
peer %&quot; PRIu32 &quot; (%s) from floating to &quot;</span><br><span>   =
              &quot;its own address (%s)&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                m1-&gt;peer_id, tls_common_name(m=
i-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                m1-&gt;rx_peer_id, tls_common_name(mi-&=
gt;context=2Ec2=2Etls_multi, false),</span><br><span>                 mrout=
e_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span>             goto=
 done;</span><br><span>         }</span><br><span>@@ -3139,7 +3138,8 @@</sp=
an><br><span>     }</span><br><span> </span><br><span>     msg(D_MULTI_MEDI=
UM, &quot;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Ec=
2=2Etls_multi-&gt;peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi,=
 false),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-=
&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        tls_common_name(mi-&gt;context=2Ec2=2Etls_=
multi, false),</span><br><span>         mroute_addr_print_ex(&amp;mi-&gt;re=
al, MAPF_SHOW_FAMILY, &amp;gc),</span><br><span>         mroute_addr_print_=
ex(&amp;real, MAPF_SHOW_FAMILY, &amp;gc));</span><br><span> </span><br><spa=
n>@@ -4099,7 +4099,7 @@</span><br><span>     {</span><br><span>         if =
(!m-&gt;instances[i])</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec2=2Etls_multi-&gt;=
peer_id =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id =3D i;</span><br><spa=
n>             m-&gt;instances[i] =3D mi;</span><br><span>             brea=
k;</span><br><span>         }</span><br><span>@@ -4108,11 +4108,11 @@</span=
><br><span>     /* should not really end up here, since multi_create_instan=
ce returns null</span><br><span>      * if amount of clients exceeds max_cl=
ients and this method would then</span><br><span>      * also not have been=
 called */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id &lt; m-&gt;max_clients);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context=
=2Ec2=2Etls_multi-&gt;rx_peer_id &lt; m-&gt;max_clients);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;peer_id &gt; m-&gt;max_peerid)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Ec2=2Etls_multi-&=
gt;rx_peer_id &gt; m-&gt;max_peerid)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;max_peerid =3D mi-&gt;c=
ontext=2Ec2=2Etls_multi-&gt;peer_id;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        m-&gt;max_peerid =3D mi-&gt;context=2Ec2=2Etls_mul=
ti-&gt;rx_peer_id;</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2E=
c</span><br><span>index e391147=2E=2E633c007d 100644</span><br><span>--- a/=
src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><=
span>@@ -661,9 +661,9 @@</span><br><span>                         print_in_=
addr_t(c-&gt;c2=2Epush_ifconfig_remote_netmask, 0, gc));</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (tls_multi-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (tls_multi-&gt;use_peer_id &amp;&amp; !tls_multi-&gt=
;use_asymmetric_peer_id)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        push_option_fmt(gc, push_list, M_USAGE, &=
quot;peer-id %d&quot;, tls_multi-&gt;peer_id);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        push_option_fmt(gc, push_list, M_USAGE, =
&quot;peer-id %d&quot;, tls_multi-&gt;rx_peer_id);</span><br><span>     }</=
span><br><span>     /*</span><br><span>      * If server uses --auth-gen-to=
ken and we have an auth token</span><br><span>diff --git a/src/openvpn/push=
_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index f57f54d=2E=2Ec9=
27f26 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><spa=
n>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -188,7 +188,7 @@</span=
><br><span>         unsigned int permission_mask =3D pull_permission_mask(c=
);</span><br><span>         if (process_push_update(c, &amp;o, permission_m=
ask, &amp;option_types_found, &amp;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(M_WARN, &quot;Failed to process push update message sent=
 to client ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;peer_id);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Faile=
d to process push update message sent to client ID: %u&quot;, c-&gt;c2=2Etl=
s_multi-&gt;rx_peer_id);</span><br><span>         }</span><br><span>       =
  e =3D e-&gt;next;</span><br><span>     }</span><br><span>@@ -294,7 +294,7=
 @@</span><br><span> </span><br><span>         if (!support_push_update(mi)=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_CLIENT, &quot;PUSH_UPDATE: not sending message to =
unsupported peer with ID: %u&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;pee=
r_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(M_CLIENT, &quot;PUSH_UPDATE: not sending message to unsupported peer wit=
h ID: %u&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br>=
<span>             buffer_list_free(msgs);</span><br><span>             gc_=
free(&amp;gc);</span><br><span>             return 0;</span><br><span>@@ -3=
29,7 +329,7 @@</span><br><span>         /* Type is UPT_BROADCAST so we upda=
te every client */</span><br><span>         if (!send_single_push_update(m,=
 curr_mi, msgs))</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;ERROR: Peer ID: %u ha=
s not been updated&quot;, curr_mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
CLIENT, &quot;ERROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;co=
ntext=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>             contin=
ue;</span><br><span>         }</span><br><span>         count++;</span><br>=
<span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><spa=
n>index 60df7ce=2E=2Eb1bfe85 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1168,7 +=
1168,10 @@</span><br><span>     /* get command line derived options */</spa=
n><br><span>     ret-&gt;opt =3D *tls_options;</span><br><span>     ret-&gt=
;dco_peer_id =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ret-&gt;peer_id =3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ret-&gt;use_asymmetric_peer_id =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* The rx_peer_id is also use=
d to identify DCO clients */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ret-&gt;rx_peer_id =3D MAX_PEER_ID;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ret-&gt;tx_peer_id =3D MAX_PEER_ID;</span>=
<br><span> </span><br><span>     return ret;</span><br><span> }</span><br><=
span>@@ -1181,6 +1184,27 @@</span><br><span> </span><br><span>     tls_sess=
ion_init(multi, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span>     tl=
s_session_init(multi, &amp;multi-&gt;session[TM_INITIAL]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!multi-&gt;opt=2Edco_enabled)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* Calculate the asymmetric peer-id */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (multi-&gt;rx=
_peer_id =3D=3D MAX_PEER_ID &amp;&amp; multi-&gt;session[TM_INITIAL]=2Eopt-=
&gt;mode !=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         uint8_t peerid[3];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (ra=
nd_bytes(peerid, sizeof(peerid)) !=3D 1)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    msg(M_FATAL, &quot;rand_bytes() fail=
ed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;rx_p=
eer_id =3D ((uint32_t)peerid[0] &lt;&lt; 16)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                    | ((uint32_t)p=
eerid[1] &lt;&lt; 8)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                    | (uint32_t)peerid[2];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            } while (multi-&gt;rx_p=
eer_id =3D=3D MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span> }</span><br><span> </span><br><span> /*</span><br><spa=
n>@@ -1858,6 +1882,25 @@</span><br><span>     return str;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_pee=
r_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls_sessi=
on *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;rx_peer=
_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_enabled)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* No valid peer id or DCO is enabled=2E C=
annot use this feature */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we o=
nly add this when the client has announced its</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * support for the feature */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;mode !=
=3D MODE_SERVER || multi-&gt;use_asymmetric_peer_id)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return buf_printf(out, &quot;ID=3D%x\n&quot;, m=
ulti-&gt;rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Prepares t=
he IV_ and UV_ variables that are part of the</span><br><span>  * exchange =
to signal the peer&#39;s capabilities=2E The amount</span><br><span>@@ -187=
1,15 +1914,22 @@</span><br><span>  *</span><br><span>  * @param buf       t=
he buffer to write these variables to</span><br><span>  * @param session   =
the TLS session object</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param multi     the TLS multi object</span><br><span>  * @return    =
      true if no error was encountered</span><br><span>  */</span><br><span=
> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_pee=
r_info(struct buffer *buf, struct tls_session *session)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+push_peer_info(struct buffer *buf, stru=
ct tls_multi *multi, struct tls_session *session)</span><br><span> {</span>=
<br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     bool r=
et =3D false;</span><br><span>     struct buffer out =3D alloc_buf_gc(512 *=
 3, &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* The asymmetric peer-id is always written when enabled */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_=
info_peerid(&amp;out, multi, session))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     if (session-&gt;opt-&gt;push_peer_info_detail &gt; 1)</span><b=
r><span>     {</span><br><span>         /* push version */</span><br><span>=
@@ -2027,9 +2077,19 @@</span><br><span>     }</span><br><span>     else</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (!write_empty_string(buf)) /* no peer info */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt;opt-&gt;mode =3D=
=3D MODE_SERVER &amp;&amp; multi-&gt;use_asymmetric_peer_id)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (!write_string(buf, BSTR(&amp;out), -1))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                goto error;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (!write_empty_string(buf))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                goto error;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><br=
><span>     }</span><br><span>     ret =3D true;</span><br><span>@@ -2156,7=
 +2216,7 @@</span><br><span>         }</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!push_pee=
r_info(buf, session))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!push_peer_info(buf, multi, session))</span><br><span>     {</spa=
n><br><span>         goto error;</span><br><span>     }</span><br><span>@@ =
-2269,6 +2329,39 @@</span><br><span>     if (multi-&gt;peer_info)</span><br=
><span>     {</span><br><span>         output_peer_info_env(session-&gt;opt=
-&gt;es, multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (session-&gt;opt-&gt;mode =3D=3D MODE_SERVER)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (!session-&gt;opt-&gt;=
dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   uint32_t peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (pe=
er_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    multi-&gt;tx_peer_id =3D peer_id;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    multi-&gt;use_asymm=
etric_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    multi-&gt;use_peer_id =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    /* Client has no asym=
metric peer-id capability */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                /* With DCO we don&#=
39;t need the tx_peer_id atm */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt;opt-&gt;mode=
 =3D=3D MODE_POINT_TO_POINT &amp;&amp; !session-&gt;opt-&gt;dco_enabled)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            uint32_t peer_id =3D=
 extract_asymmetric_peer_id(multi-&gt;peer_info);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (peer_id !=3D MAX_PEER_ID)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;tx_=
peer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                multi-&gt;use_asymmetric_peer_id =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;use_peer_=
id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span>     }</span><br><span> </span><br><span>     free(multi-&gt;r=
emote_ciphername);</span><br><span>@@ -4016,8 +4109,8 @@</span><br><span>  =
   msg(D_TLS_DEBUG, __func__);</span><br><span> </span><br><span>     ASSER=
T(ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    peer =3D htonl(((P_DATA_V2 &lt;&=
lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24 | (multi-&gt;peer_id &amp;=
 0xFFFFFF));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pee=
r =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; =
24</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
| (multi-&gt;tx_peer_id &amp; 0xFFFFFF));</span><br><span>     ASSERT(buf_w=
rite_prepend(buf, &amp;peer, 4));</span><br><span> }</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_commo=
n=2Eh</span><br><span>index 9c90242=2E=2Ef6392f9 100644</span><br><span>---=
 a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=
=2Eh</span><br><span>@@ -696,8 +696,10 @@</span><br><span> #define AUTH_TOK=
EN_VALID_EMPTYUSER (1 &lt;&lt; 2)</span><br><span> </span><br><span>     /*=
 For P_DATA_V2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
uint32_t peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint32_t rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint32_t tx_peer_id;</span><br><span>     bool use_peer_id;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool use_asymmetric_peer=
_id;</span><br><span> </span><br><span>     char *remote_ciphername; /**&lt=
; cipher specified in peer&#39;s config file */</span><br><span>     bool r=
emote_usescomp;    /**&lt; remote announced comp-lzo in OCC string */</span=
><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</=
span><br><span>index baf5a95=2E=2Eb450de8 100644</span><br><span>--- a/src/=
openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br=
><span>@@ -408,6 +408,7 @@</span><br><span> {</span><br><span>     /* will =
return 0 if peer_info is null */</span><br><span>     const unsigned int iv=
_proto_peer =3D extract_iv_proto(multi-&gt;peer_info);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const unsigned int tx_peer_id =3D ex=
tract_asymmetric_peer_id(multi-&gt;peer_info);</span><br><span> </span><br>=
<span>     /* The other peer does not support P2P NCP */</span><br><span>  =
   if (!(iv_proto_peer &amp; IV_PROTO_NCP_P2P))</span><br><span>@@ -418,7 +=
419,6 @@</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_DATA_V2)</sp=
an><br><span>     {</span><br><span>         multi-&gt;use_peer_id =3D true=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;pe=
er_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><sp=
an>     }</span><br><span> </span><br><span>     if (iv_proto_peer &amp; IV=
_PROTO_CC_EXIT_NOTIFY)</span><br><span>@@ -441,27 +441,42 @@</span><br><spa=
n>     if (iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span>   =
  {</span><br><span>         session-&gt;opt-&gt;crypto_flags |=3D CO_USE_T=
LS_KEY_MATERIAL_EXPORT;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (multi-&gt;use_peer_id)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (multi-&gt;use_peer_id)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* The asymmetric peer-id trumps on the EKM gen=
erated ones */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if ((iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (tx_peer_id !=3D M=
AX_PEER_ID) &amp;&amp; !multi-&gt;opt=2Edco_enabled)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mul=
ti-&gt;tx_peer_id =3D tx_peer_id;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            multi-&gt;use_asymmetric_peer_id =3D true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            uint8_t peerid[3];</span><br><span>    =
         /* Using a non hardcoded peer-id makes a tiny bit harder to</span>=
<br><span>              * fingerprint packets and also gives each connectio=
n a unique</span><br><span>              * peer-id that can be useful for N=
AT tracking etc=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            uint8_t p=
eerid[3];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (!key_state_export_keying_material(session, EXPORT_P2P_PEERID_LABEL,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                         strlen(EXPORT_P2P_PEERID_LABEL), &amp;peerid, 3))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if ((iv_=
proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                &amp;&amp; key_state_export_keying_ma=
terial(session, EXPORT_P2P_PEERID_LABEL,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                                    st=
rlen(EXPORT_P2P_PEERID_LABEL), &amp;peerid, 3))</span><br><span>           =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /*=
 Non DCO setup might still work but also this should never</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                 * happen or very like=
ly the TLS encryption key exporter will</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                 * also fail */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                msg(M_NONFATAL, &quot;TLS key e=
xport for P2P peer id failed=2E &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                &quot;Continuing anyway, e=
xpect problems&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 16) + (peer=
id[1] &lt;&lt; 8) + peerid[2];</span><br><span>             }</span><br><sp=
an>             else</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                multi-&gt;peer_id =3D (peer=
id[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                if (iv_proto_peer &amp=
; IV_PROTO_TLS_KEY_EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    /* Non DCO setup might still work but also this sh=
ould never</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            * happen or very likely the TLS encryption key exporter will</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     *=
 also fail */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              msg(M_NONFATAL, &quot;TLS key export for P2P peer id failed=
=2E &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                           &quot;Continuing anyway, expect problems&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                multi=
-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</sp=
an><br><span>             }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><b=
r><span>         }</span><br><span>     }</span><br><span>     if (iv_proto=
_peer &amp; IV_PROTO_DYN_TLS_CRYPT)</span><br><span>@@ -502,11 +517,13 @@</=
span><br><span>         common_cipher =3D BSTR(&amp;out);</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    msg(D_TLS_DEBUG_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        &quot;P2P mode NCP negotiation result: &quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        &quot;TLS_export=3D%d, DATA_v2=
=3D%d, peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        (bool)(session-&gt;opt-&gt;crypto_flags=
 &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT), multi-&gt;use_peer_id,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;peer_id, (bool)(=
session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quo=
t;P2P mode NCP negotiation result: &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                         &quot;TLS_export=3D%d, DATA_=
v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        (bool)(session-&g=
t;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;use_peer_id,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;rx_p=
eer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mult=
i-&gt;tx_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMA=
T),</span><br><span>         common_cipher);</span><br><span> </span><br><s=
pan>     gc_free(&amp;gc);</span><br><span>diff --git a/src/openvpn/ssl_uti=
l=2Ec b/src/openvpn/ssl_util=2Ec</span><br><span>index 71fbc9e=2E=2E2f01f8a=
 100644</span><br><span>--- a/src/openvpn/ssl_util=2Ec</span><br><span>+++ =
b/src/openvpn/ssl_util=2Ec</span><br><span>@@ -24,7 +24,7 @@</span><br><spa=
n> #endif</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span=
><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> </span><br><=
span> char *</span><br><span>@@ -72,6 +72,25 @@</span><br><span>     return=
 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+uint32_t</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+extract_asymmetric_peer_id(const char *peer_info)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (const char *p =3D peer_info; p &amp;&amp; (p=
 =3D strstr(p, &quot;ID=3D&quot;)); p +=3D 3)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* only accept &quot;ID=3D&quot; at the start of a line=
, so it does not match</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         * substrings like &quot;UV_ID=3D&quot; or &quot;GUID=3D&quot; *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=
=3D peer_info || p[-1] =3D=3D &#39;\n&#39;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            uint32_t peer_id =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (sscanf(p, &quot;ID=3D%x&quot;=
, &amp;peer_id) =3D=3D 1 &amp;&amp; peer_id &lt; MAX_PEER_ID)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                return peer_id;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return MAX_PEER_ID;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> const char *</span><br><span> options_string_compat=
_lzo(const char *options, struct gc_arena *gc)</span><br><span> {</span><br=
><span>diff --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh</sp=
an><br><span>index 2177d94=2E=2E1a69e6f 100644</span><br><span>--- a/src/op=
envpn/ssl_util=2Eh</span><br><span>+++ b/src/openvpn/ssl_util=2Eh</span><br=
><span>@@ -53,6 +53,15 @@</span><br><span>  */</span><br><span> unsigned in=
t extract_iv_proto(const char *peer_info);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Extracts the ID variable and returns its value or</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * MAX_PEER_ID if it cannot be extra=
cted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param peer_info     peer =
info string to search for ID</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_=
t extract_asymmetric_peer_id(const char *peer_info);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Takes a locally produced OCC string for TLS server mode and modifies as</s=
pan><br><span>  * if the option comp-lzo was enabled=2E This is to send a c=
lient in</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90=
b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></=
html>
--OtzomPwf4Sg=--


--===============0053189252300482612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0053189252300482612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0053189252300482612==--

