Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E70C44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5t+zqImFOK2PMKUIwUj2TGKPP2/C/+ew6VOIn73hmnY=; b=f11E64xTv41jiafQ1ACyfkddFS
	yusTDI7G9OIUSwyfkOE26cjPheMpVC46++80BG6aWHogpE7m9qz/CfUU8JmiV6wydL4dYctCuPHAl
	0EaRq3HvUCfOkGqU+SISIZne2BGSjObUjmcm+vIuY6ihhs4azHzkW+KVUzatSmj/SFdM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmVDM-0004Cr-QZ;
	Wed, 22 Jul 2026 11:34:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmVDK-0004Cb-Om
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 11:34:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LQS3oq1GfKnmFpMaC7+UhrITCU2tCsRgBKqjWBi/A14=; b=f3NTKDB/GuVVfResqZlTyWIOc6
 OO2VM/Rh0xS5BbxY2WkZh1roFNoTdfxWeFF6CRfYuN3tBfmbQ/VX76sxGi4xSjH6iBgpDUQKeb8qb
 j/+FKhYuZi2TGt1JqLSAKdMcCPVEje8JNSdR1Qs63cf0xwddLB5nWPjGrp2Umw6hjZH0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LQS3oq1GfKnmFpMaC7+UhrITCU2tCsRgBKqjWBi/A14=; b=c
 9v+9TSdbibkEKyFqCq+RuRNUAh8sleBuAgHrLBNHgIDx/LUy3LHiwW7bv0dO2sMrYTk0GEdg5tg5a
 Lz4//mZTEycyrABl5Df2CMDA2D60Q8fz/aMBOzMTeqrTFwgwehmmJ6pyYmz6FTTIhRuMQ/StG77jA
 GhpG/b4PNXXQumLM=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmVDI-00026q-69 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 11:34:15 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f84023916so991283f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 04:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784720046; x=1785324846; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LQS3oq1GfKnmFpMaC7+UhrITCU2tCsRgBKqjWBi/A14=;
 b=bKEPJWeUobMKS3DRrgPhddTZHJ+sNj0ZLmwPVrHPqgeQwl28lWUnURnRz5F5zP4iXg
 f7ELjXCsiOMkVl/e7x5jrh5i1qCsRBrDO25VZR/3S5AWb8ZKohcn0xPPlsWkKzhXixft
 Loh2CovLyOCzbW4L3ch7CHT7ma4m7u7wCRhfI+aV9Qa/h24tkgaIbT+R9fudnOOMPvX3
 EwioUc8UDbOzLMIaHEctH0/ns7kI1Ei1nbwTn9TLWKhHNHeGIjO4u5byOUXAyk8qXZm6
 WRI8AUpCUZVlOcAFVdkoRiBsgl7kXXD9NzhHJsYc2fZsghh0WWcECDO8WvgsYm8UAvAN
 B77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784720046; x=1785324846;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LQS3oq1GfKnmFpMaC7+UhrITCU2tCsRgBKqjWBi/A14=;
 b=OGt59QJAv3FoR+9/WApUUrFFOBDeVV5aSfu1GLHzBtrfGJw7Ek/ITmeRCeQ8yjI97V
 yO7MrwyDHIihDALnMhyBbGy/7K6fc+pO5OrFcG1XOXeMrqdBK8f6ttz5bBelOPX6Wro7
 ixdRi8+Wkw2GgqXyEmBaHCenm5p3qhe/RBvcjWChJeQmLEL+UdAXeeOwxNdHgQEaKhCg
 +d3QBDA00enZSfIF3sT7Fo5y+oeVy19SKJvBP+INNjKoREkqxD2ZqOpfHIGhK2UHt6Im
 2wMuHJfOHY5sGcXTNBt8y4NWyWSnHALv/uo/KAOcg4AMVip0xP+OP5SmWyDUz7lUYLcb
 7Vcw==
X-Gm-Message-State: AOJu0YzBS4eqLSDLQPsa7/XiRUwbORW9Ps8S1NJz8qzsty295fLdApk2
 4myK+X0/tw6E933uagjSBn/FZI0GD1qyr7WScUMstvI2OgjB6n+t1Tg+hV05IJx19xtgIbVCBJo
 VHZqMtfs4+TPjcwXopNAUuPL4BltBdcAnfWu/3t/b5pW9ZA98sW1hwvZT3FOWLxi64ga0Fd90eA
 a/lm9ISw==
X-Gm-Gg: AR+sD11LiLv2UVaAbLQyCFUiyT113k2+x8+Lo+Ib/XT8CFdrd6i8QPMTm7aDH8M6gzP
 nj+BTT5R/ueIa/+UBE6OsNqOPkcd1UxQoayfz3wqRUX5mipoI2sDbZkba9CnJYz2aTHmaBmzQDp
 KRlL8ICdR8APkQgPD1MVZ47cZt+BNrTboL9XePklwP7ZG1xLEj7cYvx539+bb9ZvPLlBeG2cc57
 s6rZliQUTTCffHaf+dQtt19a547IGgDOWd4NPfpnCLS7197ieMQGUug1TWr6PuRYV+GqviBYj2g
 BWL97IDHUfsg/o/pkNubbVk1qSD7cMUJ4ErR6ltSYen1ZdbhVdJWwXWk9IO4o/LB9jMIfGYL6pl
 M1GgnMV80zLnsoSWRvS3PlVX8xQgum9H5bvCUPgT1m6NlbWqvcDRy2N7e3onhjEZs4b2rHPRlQ9
 9najIWOZKpOwSixgzgw4iIhI3lv47Ga3KsBtiDaizlpXzl01iq/JPA7fj9XDg83pOM384u9BZlt
 f0GMkAFm0evHx4SceVbc5HV6cJVAVh07EDerIl89MhUNYICfBMW7+8MB+kps/UpHp3hVBEvNLiH
 ujo=
X-Received: by 2002:a5d:5e01:0:b0:47f:6fd1:d399 with SMTP id
 ffacd0b85a97d-47f6fd1d54bmr21384427f8f.51.1784720045080; 
 Wed, 22 Jul 2026 04:34:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm5202869f8f.16.2026.07.22.04.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 04:34:04 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 11:34:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 54a201ed40362a8b76d2b2c5f323057b556c9080
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0441d9af54c5000a71e3da0b0c28eff85176c3f5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmVDI-00026q-69
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8131252801034579785=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8131252801034579785==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E0JLy6cSWZE="; charset=UTF-8

--E0JLy6cSWZE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, plais=
thos=2E

Hello cron2, flichtenheld, plaisthos, 

I'd like you to reexamine =
a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/108=
9?usp=3Demail

to look at the new patch set (#20)=2E


Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

multipeer: introduce asymmetric peer-id

In order to=
 achieve a multipeer functionality, peers now
use separate IDs for sending =
(tx_peer_id) and receiving
(rx_peer_id)=2E

Each peer announces its own ID =
through pushing peer-info
using 'ID=3D7f1' hex format so identification can=
 still
happen even if IP/port changes=2E

In P2P mode, peer switch to using=
 the announced IDs after
mutual exchange=2E
In P2MP mode, clients always an=
nounce their ID, and servers
can optionally respond with their own to enabl=
e the same
behavior=2E

Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf=
9
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src=
/openvpn/dco=2Ec
M src/openvpn/init=2Ec
M src/openvpn/misc=2Ec
M src/openvp=
n/multi=2Ec
M src/openvpn/push=2Ec
M src/openvpn/push_util=2Ec
M src/openvp=
n/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_ncp=2Ec
M src/open=
vpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
11 files changed, 203 insertion=
s(+), 53 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/89/1089/20

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/=
dco=2Ec
index e944547=2E=2Ec722311 100644
--- a/src/openvpn/dco=2Ec
+++ b/s=
rc/openvpn/dco=2Ec
@@ -528,14 +528,15 @@
         c->c2=2Etls_multi->dco_pe=
er_id =3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1=2Etuntap-=
>dco, multi->peer_id, sock->sd, NULL,
-                           proto_is_=
dgram(sock->info=2Eproto) ? remoteaddr : NULL, NULL, NULL);
+    int ret =
=3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_id, sock->sd, NULL,
+=
                           proto_is_dgram(sock->info=2Eproto) ? remoteaddr =
: NULL,
+                           NULL, NULL);
     if (ret < 0)
     {
 =
        return ret;
     }
 
-    c->c2=2Etls_multi->dco_peer_id =3D multi-=
>peer_id;
+    c->c2=2Etls_multi->dco_peer_id =3D multi->rx_peer_id;
 
    =
 return 0;
 }
@@ -610,7 +611,7 @@
 {
     struct context *c =3D &mi->contex=
t;
 
-    int peer_id =3D c->c2=2Etls_multi->peer_id;
+    int peer_id =3D =
c->c2=2Etls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, *localaddr=
 =3D NULL;
     struct sockaddr_storage local =3D { 0 };
     const socket_=
descriptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
@@ -690,7 +691,7 @@
     {=

 #if defined(_WIN32)
         dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco=
, addr->v6=2Eaddr, addr->netbits,
-                                c->c2=2E=
tls_multi->peer_id);
+                                c->c2=2Etls_multi->rx=
_peer_id);
 #else
         const struct in6_addr *gateway =3D &mi->context=
=2Ec2=2Epush_ifconfig_ipv6_local;
         if (addr->type & MR_ONLINK_DCO_A=
DDR)
@@ -707,7 +708,7 @@
     {
 #if defined(_WIN32)
         dco_win_add_i=
route_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits,
-         =
                       c->c2=2Etls_multi->peer_id);
+                      =
          c->c2=2Etls_multi->rx_peer_id);
 #else
         in_addr_t dest =
=3D htonl(addr->v4=2Eaddr);
         const in_addr_t *gateway =3D &mi->cont=
ext=2Ec2=2Epush_ifconfig_local;
diff --git a/src/openvpn/init=2Ec b/src/ope=
nvpn/init=2Ec
index caaa769=2E=2Ea941f69 100644
--- a/src/openvpn/init=2Ec
=
+++ b/src/openvpn/init=2Ec
@@ -2209,7 +2209,7 @@
 
     if (o->use_peer_id)=

     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        bu=
f_printf(&out, ", rx-peer-id: %u, tx-peer-id: %u", c->c2=2Etls_multi->rx_pe=
er_id, c->c2=2Etls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2688,7=
 +2688,11 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set=
");
         c->c2=2Etls_multi->use_peer_id =3D true;
-        c->c2=2Etls_=
multi->peer_id =3D c->options=2Epeer_id;
+        c->c2=2Etls_multi->tx_pee=
r_id =3D c->options=2Epeer_id;
+        if (!c->c2=2Etls_multi->use_asymmet=
ric_peer_id)
+        {
+            c->c2=2Etls_multi->rx_peer_id =3D c->o=
ptions=2Epeer_id;
+        }
     }
 
     /* process (potentially) pushed =
options */
@@ -3485,6 +3489,10 @@
     if (c->c2=2Etls_multi)
     {
      =
   tls_multi_init_finalize(c->c2=2Etls_multi, c->options=2Ece=2Etls_mtu);
+=
        if (c->c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
+        {
+   =
         c->options=2Euse_peer_id =3D true;
+        }
         ASSERT(c->c=
2=2Etls_multi->opt=2Eframe=2Ebuf=2Epayload_size <=3D c->c2=2Eframe=2Ebuf=2E=
payload_size);
         frame_print(&c->c2=2Etls_multi->opt=2Eframe, D_MTU_=
INFO, "Control Channel MTU parms");
 
diff --git a/src/openvpn/misc=2Ec b/s=
rc/openvpn/misc=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/openvpn/mis=
c=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
         chom=
p(line);
         if (validate_peer_info_line(line)
-            && (strncm=
p(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
+         =
   && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0=

+                || strncmp(line, "ID", 2) =3D=3D 0))
         {
         =
    msg(M_INFO, "peer info: %s", line);
             env_set_add(es, line);=

         }
         else
         {
-            msg(M_WARN, "validation f=
ailed on peer_info line received from client");
+            msg(M_WARN, "v=
alidation failed on peer_info line received");
         }
     }
 }
diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index fe2badb=2E=2Ef823=
f5b 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -430,=
7 +430,7 @@
         if (mi->context=2Ec2=2Etls_multi && check_debug_level(=
D_DCO_DEBUG)
             && dco_enabled(&mi->context=2Eoptions))
         =
{
-            buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=2Etls_mul=
ti->peer_id);
+            buf_printf(&out, " rx-peer-id=3D%d", mi->context=
=2Ec2=2Etls_multi->rx_peer_id);
         }
         return BSTR(&out);
    =
 }
@@ -598,9 +598,9 @@
         }
 #endif
 
-        if (mi->context=2Ec2=
=2Etls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context=2Ec2=2Etls=
_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->instances[m=
i->context=2Ec2=2Etls_multi->peer_id] =3D NULL;
+            m->instances[m=
i->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
 
             /* Adjust=
 the max_peerid as this might have been the highest
              * peer id=
 instance */
@@ -908,8 +908,7 @@
 #else
                         sep,
 #end=
if
-                        sep,
-                        mi->context=2Ec2=
=2Etls_multi ? mi->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+       =
                 sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls=
_multi->rx_peer_id : MAX_PEER_ID,
                         sep, translate_c=
ipher_name_to_openvpn(mi->context=2Eoptions=2Eciphername));
               =
  }
                 gc_free(&gc);
@@ -3121,12 +3120,12 @@
          * has,=
 so we disallow it=2E This can happen if a DCO netlink notification
       =
   * gets lost and we miss a floating step=2E
          */
-        if (m1-=
>peer_id =3D=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->rx_peer=
_id)
         {
             msg(M_WARN,
                 "disallowing peer=
 %" PRIu32 " (%s) from floating to "
                 "its own address (%s)=
",
-                m1->peer_id, tls_common_name(mi->context=2Ec2=2Etls_mul=
ti, false),
+                m1->rx_peer_id, tls_common_name(mi->context=2E=
c2=2Etls_multi, false),
                 mroute_addr_print(&mi->real, &gc))=
;
             goto done;
         }
@@ -3139,7 +3138,8 @@
     }
 
     ms=
g(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-        m=
i->context=2Ec2=2Etls_multi->peer_id, tls_common_name(mi->context=2Ec2=2Etl=
s_multi, false),
+        mi->context=2Ec2=2Etls_multi->rx_peer_id,
+      =
  tls_common_name(mi->context=2Ec2=2Etls_multi, false),
         mroute_add=
r_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
         mroute_addr_print_ex=
(&real, MAPF_SHOW_FAMILY, &gc));
 
@@ -4099,7 +4099,7 @@
     {
         if=
 (!m->instances[i])
         {
-            mi->context=2Ec2=2Etls_multi->p=
eer_id =3D i;
+            mi->context=2Ec2=2Etls_multi->rx_peer_id =3D i;
=
             m->instances[i] =3D mi;
             break;
         }
@@ -410=
8,11 +4108,11 @@
     /* should not really end up here, since multi_create_=
instance returns null
      * if amount of clients exceeds max_clients and =
this method would then
      * also not have been called */
-    ASSERT(mi-=
>context=2Ec2=2Etls_multi->peer_id < m->max_clients);
+    ASSERT(mi->conte=
xt=2Ec2=2Etls_multi->rx_peer_id < m->max_clients);
 
-    if (mi->context=
=2Ec2=2Etls_multi->peer_id > m->max_peerid)
+    if (mi->context=2Ec2=2Etls=
_multi->rx_peer_id > m->max_peerid)
     {
-        m->max_peerid =3D mi->c=
ontext=2Ec2=2Etls_multi->peer_id;
+        m->max_peerid =3D mi->context=2E=
c2=2Etls_multi->rx_peer_id;
     }
 }
 
diff --git a/src/openvpn/push=2Ec b=
/src/openvpn/push=2Ec
index e391147=2E=2E633c007d 100644
--- a/src/openvpn/=
push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -661,9 +661,9 @@
                   =
      print_in_addr_t(c->c2=2Epush_ifconfig_remote_netmask, 0, gc));
     }=

 
-    if (tls_multi->use_peer_id)
+    if (tls_multi->use_peer_id && !tls=
_multi->use_asymmetric_peer_id)
     {
-        push_option_fmt(gc, push_li=
st, M_USAGE, "peer-id %d", tls_multi->peer_id);
+        push_option_fmt(gc=
, push_list, M_USAGE, "peer-id %d", tls_multi->rx_peer_id);
     }
     /*
=
      * If server uses --auth-gen-token and we have an auth token
diff --gi=
t a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index f57f54d=2E=
=2Ec927f26 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_ut=
il=2Ec
@@ -188,7 +188,7 @@
         unsigned int permission_mask =3D pull_p=
ermission_mask(c);
         if (process_push_update(c, &o, permission_mask,=
 &option_types_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
-  =
          msg(M_WARN, "Failed to process push update message sent to client=
 ID: %u", c->c2=2Etls_multi->peer_id);
+            msg(M_WARN, "Failed to =
process push update message sent to client ID: %u", c->c2=2Etls_multi->rx_p=
eer_id);
         }
         e =3D e->next;
     }
@@ -294,7 +294,7 @@
 
  =
       if (!support_push_update(mi))
         {
-            msg(M_CLIENT, =
"PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi->con=
text=2Ec2=2Etls_multi->peer_id);
+            msg(M_CLIENT, "PUSH_UPDATE: n=
ot sending message to unsupported peer with ID: %u", mi->context=2Ec2=2Etls=
_multi->rx_peer_id);
             buffer_list_free(msgs);
             gc_f=
ree(&gc);
             return 0;
@@ -329,7 +329,7 @@
         /* Type is UP=
T_BROADCAST so we update every client */
         if (!send_single_push_upd=
ate(m, curr_mi, msgs))
         {
-            msg(M_CLIENT, "ERROR: Peer I=
D: %u has not been updated", curr_mi->context=2Ec2=2Etls_multi->peer_id);
+=
            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_m=
i->context=2Ec2=2Etls_multi->rx_peer_id);
             continue;
         }=

         count++;
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
i=
ndex 60df7ce=2E=2Eb1bfe85 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvp=
n/ssl=2Ec
@@ -1168,7 +1168,10 @@
     /* get command line derived options *=
/
     ret->opt =3D *tls_options;
     ret->dco_peer_id =3D -1;
-    ret->p=
eer_id =3D MAX_PEER_ID;
+    ret->use_asymmetric_peer_id =3D false;
+    /*=
 The rx_peer_id is also used to identify DCO clients */
+    ret->rx_peer_i=
d =3D MAX_PEER_ID;
+    ret->tx_peer_id =3D MAX_PEER_ID;
 
     return ret;=

 }
@@ -1181,6 +1184,27 @@
 
     tls_session_init(multi, &multi->session[T=
M_ACTIVE]);
     tls_session_init(multi, &multi->session[TM_INITIAL]);
+
+ =
   if (!multi->opt=2Edco_enabled)
+    {
+        /* Calculate the asymmetr=
ic peer-id */
+        if (multi->rx_peer_id =3D=3D MAX_PEER_ID && multi->s=
ession[TM_INITIAL]=2Eopt->mode !=3D MODE_SERVER)
+        {
+            ui=
nt8_t peerid[3];
+
+            do
+            {
+                if (rand=
_bytes(peerid, sizeof(peerid)) !=3D 1)
+                {
+                =
    msg(M_FATAL, "rand_bytes() failed");
+                }
+
+            =
    multi->rx_peer_id =3D ((uint32_t)peerid[0] << 16)
+                    =
                | ((uint32_t)peerid[1] << 8)
+                             =
       | (uint32_t)peerid[2];
+            } while (multi->rx_peer_id =3D=
=3D MAX_PEER_ID);
+        }
+    }
 }
 
 /*
@@ -1858,6 +1882,25 @@
     re=
turn str;
 }
 
+static bool
+push_peer_info_peerid(struct buffer *out, stru=
ct tls_multi *multi, struct tls_session *session)
+{
+    if (multi->rx_pee=
r_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
+    {
+        /* No=
 valid peer id or DCO is enabled=2E Cannot use this feature */
+        ret=
urn true;
+    }
+
+    /* In server mode we only add this when the client =
has announced its
+     * support for the feature */
+    if (session->opt-=
>mode !=3D MODE_SERVER || multi->use_asymmetric_peer_id)
+    {
+        re=
turn buf_printf(out, "ID=3D%x\n", multi->rx_peer_id);
+    }
+
+    return =
true;
+}
+
 /**
  * Prepares the IV_ and UV_ variables that are part of the=

  * exchange to signal the peer's capabilities=2E The amount
@@ -1871,15 +=
1914,22 @@
  *
  * @param buf       the buffer to write these variables to
=
  * @param session   the TLS session object
+ * @param multi     the TLS mu=
lti object
  * @return          true if no error was encountered
  */
 stat=
ic bool
-push_peer_info(struct buffer *buf, struct tls_session *session)
+p=
ush_peer_info(struct buffer *buf, struct tls_multi *multi, struct tls_sessi=
on *session)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D fal=
se;
     struct buffer out =3D alloc_buf_gc(512 * 3, &gc);
 
+    /* The as=
ymmetric peer-id is always written when enabled */
+    if (!push_peer_info=
_peerid(&out, multi, session))
+    {
+        goto error;
+    }
+
     if=
 (session->opt->push_peer_info_detail > 1)
     {
         /* push version =
*/
@@ -2027,9 +2077,19 @@
     }
     else
     {
-        if (!write_empty=
_string(buf)) /* no peer info */
+        if (session->opt->mode =3D=3D MOD=
E_SERVER && multi->use_asymmetric_peer_id)
         {
-            goto err=
or;
+            if (!write_string(buf, BSTR(&out), -1))
+            {
+  =
              goto error;
+            }
+        }
+        else
+        =
{
+            if (!write_empty_string(buf))
+            {
+              =
  goto error;
+            }
         }
     }
     ret =3D true;
@@ -2156,=
7 +2216,7 @@
         }
     }
 
-    if (!push_peer_info(buf, session))
+ =
   if (!push_peer_info(buf, multi, session))
     {
         goto error;
  =
   }
@@ -2269,6 +2329,39 @@
     if (multi->peer_info)
     {
         outp=
ut_peer_info_env(session->opt->es, multi->peer_info);
+        if (session-=
>opt->mode =3D=3D MODE_SERVER)
+        {
+            if (!session->opt->d=
co_enabled)
+            {
+                uint32_t peer_id =3D extract_as=
ymmetric_peer_id(multi->peer_info);
+                if (peer_id !=3D MAX_P=
EER_ID)
+                {
+                    multi->tx_peer_id =3D peer_=
id;
+                    multi->use_asymmetric_peer_id =3D true;
+         =
           multi->use_peer_id =3D true;
+                }
+               =
 else
+                {
+                    /* Client has no asymmetric p=
eer-id capability */
+                    multi->tx_peer_id =3D multi->rx_p=
eer_id;
+                }
+            }
+            else
+            {
=
+                /* With DCO we don't need the tx_peer_id atm */
+         =
       multi->tx_peer_id =3D multi->rx_peer_id;
+            }
+        }
+=
        if (session->opt->mode =3D=3D MODE_POINT_TO_POINT && !session->opt-=
>dco_enabled)
+        {
+            uint32_t peer_id =3D extract_asymmetr=
ic_peer_id(multi->peer_info);
+            if (peer_id !=3D MAX_PEER_ID)
+ =
           {
+                multi->tx_peer_id =3D peer_id;
+             =
   multi->use_asymmetric_peer_id =3D true;
+                multi->use_peer=
_id =3D true;
+            }
+        }
     }
 
     free(multi->remote_ci=
phername);
@@ -4016,8 +4109,8 @@
     msg(D_TLS_DEBUG, __func__);
 
     AS=
SERT(ks);
-
-    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id=
) << 24 | (multi->peer_id & 0xFFFFFF));
+    peer =3D htonl(((P_DATA_V2 << =
P_OPCODE_SHIFT) | ks->key_id) << 24
+                 | (multi->tx_peer_id =
& 0xFFFFFF));
     ASSERT(buf_write_prepend(buf, &peer, 4));
 }
 
diff --gi=
t a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9c90242=
=2E=2Ef6392f9 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl=
_common=2Eh
@@ -696,8 +696,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUSER (1 << =
2)
 
     /* For P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t rx_peer_=
id;
+    uint32_t tx_peer_id;
     bool use_peer_id;
+    bool use_asymmetr=
ic_peer_id;
 
     char *remote_ciphername; /**< cipher specified in peer's=
 config file */
     bool remote_usescomp;    /**< remote announced comp-lz=
o in OCC string */
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_n=
cp=2Ec
index baf5a95=2E=2Eb450de8 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ =
b/src/openvpn/ssl_ncp=2Ec
@@ -408,6 +408,7 @@
 {
     /* will return 0 if p=
eer_info is null */
     const unsigned int iv_proto_peer =3D extract_iv_pr=
oto(multi->peer_info);
+    const unsigned int tx_peer_id =3D extract_asymm=
etric_peer_id(multi->peer_info);
 
     /* The other peer does not support =
P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -418,7 +419,6 @=
@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_pee=
r_id =3D true;
-        multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
    =
 }
 
     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -441,27 +441,42 @=
@
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
         session=
->opt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
+    }
 
-        =
if (multi->use_peer_id)
+    if (multi->use_peer_id)
+    {
+        /* The=
 asymmetric peer-id trumps on the EKM generated ones */
+        if ((iv_pr=
oto_peer & IV_PROTO_TLS_KEY_EXPORT)
+            && (tx_peer_id !=3D MAX_PE=
ER_ID) && !multi->opt=2Edco_enabled)
         {
+            multi->tx_peer=
_id =3D tx_peer_id;
+            multi->use_asymmetric_peer_id =3D true;
+ =
       }
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
-            =
uint8_t peerid[3];
-            if (!key_state_export_keying_material(sessi=
on, EXPORT_P2P_PEERID_LABEL,
-                                             =
     strlen(EXPORT_P2P_PEERID_LABEL), &peerid, 3))
+            if ((iv_pro=
to_peer & IV_PROTO_TLS_KEY_EXPORT)
+                && key_state_export_key=
ing_material(session, EXPORT_P2P_PEERID_LABEL,
+                           =
                         strlen(EXPORT_P2P_PEERID_LABEL), &peerid, 3))
    =
         {
-                /* Non DCO setup might still work but also this=
 should never
-                 * happen or very likely the TLS encryption =
key exporter will
-                 * also fail */
-                msg(M_N=
ONFATAL, "TLS key export for P2P peer id failed=2E "
-                     =
           "Continuing anyway, expect problems");
+                multi->r=
x_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
           =
  }
             else
             {
-                multi->peer_id =3D (p=
eerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+                if (iv_pro=
to_peer & IV_PROTO_TLS_KEY_EXPORT)
+                {
+                    =
/* Non DCO setup might still work but also this should never
+             =
        * happen or very likely the TLS encryption key exporter will
+     =
                * also fail */
+                    msg(M_NONFATAL, "TLS ke=
y export for P2P peer id failed=2E "
+                                    "=
Continuing anyway, expect problems");
+                }
+                m=
ulti->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
             }
+          =
  multi->tx_peer_id =3D multi->rx_peer_id;
         }
     }
     if (iv_pr=
oto_peer & IV_PROTO_DYN_TLS_CRYPT)
@@ -502,11 +517,13 @@
         common_ci=
pher =3D BSTR(&out);
     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode =
NCP negotiation result: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id =
%d, epoch=3D%d, cipher=3D%s",
-        (bool)(session->opt->crypto_flags & =
CO_USE_TLS_KEY_MATERIAL_EXPORT), multi->use_peer_id,
-        multi->peer_i=
d, (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(=
D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
+                     =
    "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%=
d, cipher=3D%s",
+        (bool)(session->opt->crypto_flags & CO_USE_TLS_KE=
Y_MATERIAL_EXPORT),
+        multi->use_peer_id,
+        multi->rx_peer_id=
,
+        multi->tx_peer_id,
+        (bool)(session->opt->crypto_flags & =
CO_EPOCH_DATA_KEY_FORMAT),
         common_cipher);
 
     gc_free(&gc);
di=
ff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 71fbc9=
e=2E=2E2f01f8a 100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_=
util=2Ec
@@ -24,7 +24,7 @@
 #endif
 
 #include "syshead=2Eh"
-
+#include "o=
penvpn=2Eh"
 #include "ssl_util=2Eh"
 
 char *
@@ -72,6 +72,25 @@
     retu=
rn 0;
 }
 
+uint32_t
+extract_asymmetric_peer_id(const char *peer_info)
+{
=
+    for (const char *p =3D peer_info; p && (p =3D strstr(p, "ID=3D")); p +=
=3D 3)
+    {
+        /* only accept "ID=3D" at the start of a line, so it=
 does not match
+         * substrings like "UV_ID=3D" or "GUID=3D" */
+   =
     if (p =3D=3D peer_info || p[-1] =3D=3D '\n')
+        {
+            u=
int32_t peer_id =3D 0;
+            if (sscanf(p, "ID=3D%x", &peer_id) =3D=
=3D 1 && peer_id < MAX_PEER_ID)
+            {
+                return peer=
_id;
+            }
+        }
+    }
+    return MAX_PEER_ID;
+}
+
 const =
char *
 options_string_compat_lzo(const char *options, struct gc_arena *gc)=

 {
diff --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index =
2177d94=2E=2E1a69e6f 100644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvp=
n/ssl_util=2Eh
@@ -53,6 +53,15 @@
  */
 unsigned int extract_iv_proto(const=
 char *peer_info);
 
+
+/**
+ * Extracts the ID variable and returns its va=
lue or
+ * MAX_PEER_ID if it cannot be extracted=2E
+ *
+ * @param peer_inf=
o     peer info string to search for ID
+ */
+uint32_t extract_asymmetric_p=
eer_id(const char *peer_info);
+
 /**
  * Takes a locally produced OCC stri=
ng for TLS server mode and modifies as
  * if the option comp-lzo was enabl=
ed=2E This is to send a client in

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Nu=
mber: 1089
Gerrit-PatchSet: 20
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=
=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianmarco@=
mandelbit=2Ecom>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-A=
ttention: flichtenheld <frank@lichtenheld=2Ecom>

--E0JLy6cSWZE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, plaisthos=2E </p>
<p>=
its_Giaan <strong>uploaded patch set #20</strong> to this change=2E</p><p><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View =
Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">multipeer: introduce asymmetric peer-id<br><br>=
In order to achieve a multipeer functionality, peers now<br>use separate ID=
s for sending (tx_peer_id) and receiving<br>(rx_peer_id)=2E<br><br>Each pee=
r announces its own ID through pushing peer-info<br>using &#39;ID=3D7f1&#39=
; hex format so identification can still<br>happen even if IP/port changes=
=2E<br><br>In P2P mode, peer switch to using the announced IDs after<br>mut=
ual exchange=2E<br>In P2MP mode, clients always announce their ID, and serv=
ers<br>can optionally respond with their own to enable the same<br>behavior=
=2E<br><br>Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9<br>Signed-o=
ff-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M s=
rc/openvpn/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/misc=2Ec<br>M=
 src/openvpn/multi=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/push_util=
=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M src/open=
vpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh=
<br>11 files changed, 203 insertions(+), 53 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/8=
9/1089/20</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</s=
pan><br><span>index e944547=2E=2Ec722311 100644</span><br><span>--- a/src/o=
penvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@=
 -528,14 +528,15 @@</span><br><span>         c-&gt;c2=2Etls_multi-&gt;dco_p=
eer_id =3D -1;</span><br><span>     }</span><br><span> #endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_peer(&amp;c=
-&gt;c1=2Etuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                           proto_=
is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL, NULL, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_new_peer(=
&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NULL,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
     proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                           NULL=
, NULL);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</span>=
<br><span>         return ret;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Etls_multi-=
&gt;dco_peer_id =3D multi-&gt;peer_id;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi-&gt;r=
x_peer_id;</span><br><span> </span><br><span>     return 0;</span><br><span=
> }</span><br><span>@@ -610,7 +611,7 @@</span><br><span> {</span><br><span>=
     struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =3D c-&gt;c2=2E=
tls_multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><br><span=
>     struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span>   =
  struct sockaddr_storage local =3D { 0 };</span><br><span>     const socke=
t_descriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><br><span>@@=
 -690,7 +691,7 @@</span><br><span>     {</span><br><span> #if defined(_WIN3=
2)</span><br><span>         dco_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-=
&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                c-&gt;c2=2Etls_mul=
ti-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                             c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><b=
r><span> #else</span><br><span>         const struct in6_addr *gateway =3D =
&amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span>      =
   if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><span>@@ -707,7 +7=
08,7 @@</span><br><span>     {</span><br><span> #if defined(_WIN32)</span><=
br><span>         dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, a=
ddr-&gt;v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                c-&gt;c2=2Etls_multi-&gt;pee=
r_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                   c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #=
else</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4=2Eaddr);=
</span><br><span>         const in_addr_t *gateway =3D &amp;mi-&gt;context=
=2Ec2=2Epush_ifconfig_local;</span><br><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index caaa769=2E=2Ea941f69 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -2209,7 +2209,7 @@</span><br><span> </span=
><br><span>     if (o-&gt;use_peer_id)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;=
, peer-id: %d&quot;, o-&gt;peer_id);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        buf_printf(&amp;out, &quot;, rx-peer-id: %u, tx-pe=
er-id: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id, c-&gt;c2=2Etls_multi-=
&gt;tx_peer_id);</span><br><span>     }</span><br><span> </span><br><span> =
#ifdef USE_COMP</span><br><span>@@ -2688,7 +2688,11 @@</span><br><span>    =
 {</span><br><span>         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-id=
 set&quot;);</span><br><span>         c-&gt;c2=2Etls_multi-&gt;use_peer_id =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&g=
t;c2=2Etls_multi-&gt;peer_id =3D c-&gt;options=2Epeer_id;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Etls_multi-&gt;tx_p=
eer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!c-&gt;c2=2Etls_multi-&gt;use_asymmetric_peer_i=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_=
multi-&gt;rx_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><s=
pan> </span><br><span>     /* process (potentially) pushed options */</span=
><br><span>@@ -3485,6 +3489,10 @@</span><br><span>     if (c-&gt;c2=2Etls_m=
ulti)</span><br><span>     {</span><br><span>         tls_multi_init_finali=
ze(c-&gt;c2=2Etls_multi, c-&gt;options=2Ece=2Etls_mtu);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=2Etls_multi-&gt;rx=
_peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         c-&gt;options=2Euse_peer_id =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span>         ASSERT(c-&gt;=
c2=2Etls_multi-&gt;opt=2Eframe=2Ebuf=2Epayload_size &lt;=3D c-&gt;c2=2Efram=
e=2Ebuf=2Epayload_size);</span><br><span>         frame_print(&amp;c-&gt;c2=
=2Etls_multi-&gt;opt=2Eframe, D_MTU_INFO, &quot;Control Channel MTU parms&q=
uot;);</span><br><span> </span><br><span>diff --git a/src/openvpn/misc=2Ec =
b/src/openvpn/misc=2Ec</span><br><span>index 10bfc35=2E=2Ea8c88c9 100644</s=
pan><br><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/=
misc=2Ec</span><br><span>@@ -765,14 +765,15 @@</span><br><span>     {</span=
><br><span>         chomp(line);</span><br><span>         if (validate_peer=
_info_line(line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(li=
ne, &quot;UV_&quot;, 3) =3D=3D 0))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =
=3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                || strncmp(line, &quot;I=
D&quot;, 2) =3D=3D 0))</span><br><span>         {</span><br><span>         =
    msg(M_INFO, &quot;peer info: %s&quot;, line);</span><br><span>         =
    env_set_add(es, line);</span><br><span>         }</span><br><span>     =
    else</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(M_WARN, &quot;validation failed on peer_info =
line received from client&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_WARN, &quot;validation failed on peer_info =
line received&quot;);</span><br><span>         }</span><br><span>     }</sp=
an><br><span> }</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/op=
envpn/multi=2Ec</span><br><span>index fe2badb=2E=2Ef823f5b 100644</span><br=
><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
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
dex 60df7ce=2E=2Eb1bfe85 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</=
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
@ -1181,6 +1184,27 @@</span><br><span> </span><br><span>     tls_session_in=
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
     uint8_t peerid[3];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            do<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                if (rand_b=
ytes(peerid, sizeof(peerid)) !=3D 1)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    msg(M_FATAL, &quot;rand_bytes() failed&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;rx_peer_=
id =3D ((uint32_t)peerid[0] &lt;&lt; 16)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                    | ((uint32_t)peeri=
d[1] &lt;&lt; 8)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                 | (uint32_t)peerid[2];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            } while (multi-&gt;rx_peer_=
id =3D=3D MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span> }</span><br><span> </span><br><span> /*</span><br><span>@@=
 -1858,6 +1882,25 @@</span><br><span>     return str;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_peer_in=
fo_peerid(struct buffer *out, struct tls_multi *multi, struct tls_session *=
session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;rx_peer_id =
=3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_enabled)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* No valid peer id or DCO is enabled=2E Canno=
t use this feature */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we only =
add this when the client has announced its</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * support for the feature */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;mode !=3D =
MODE_SERVER || multi-&gt;use_asymmetric_peer_id)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return buf_printf(out, &quot;ID=3D%x\n&quot;, multi-=
&gt;rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Prepares the IV=
_ and UV_ variables that are part of the</span><br><span>  * exchange to si=
gnal the peer&#39;s capabilities=2E The amount</span><br><span>@@ -1871,15 =
+1914,22 @@</span><br><span>  *</span><br><span>  * @param buf       the bu=
ffer to write these variables to</span><br><span>  * @param session   the T=
LS session object</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param multi     the TLS multi object</span><br><span>  * @return         =
 true if no error was encountered</span><br><span>  */</span><br><span> sta=
tic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_peer_inf=
o(struct buffer *buf, struct tls_session *session)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+push_peer_info(struct buffer *buf, struct tl=
s_multi *multi, struct tls_session *session)</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span>     bool ret =
=3D false;</span><br><span>     struct buffer out =3D alloc_buf_gc(512 * 3,=
 &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* The asymmetric peer-id is always written when enabled */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_inf=
o_peerid(&amp;out, multi, session))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     if (session-&gt;opt-&gt;push_peer_info_detail &gt; 1)</span><br><=
span>     {</span><br><span>         /* push version */</span><br><span>@@ =
-2027,9 +2077,19 @@</span><br><span>     }</span><br><span>     else</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (!write_empty_string(buf)) /* no peer info */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt;opt-&gt;mode =3D=
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
0 </div>
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
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianma=
rco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</=
body></html>
--E0JLy6cSWZE=--


--===============8131252801034579785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8131252801034579785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8131252801034579785==--

