Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBBCC531FC
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFiq15Mk3fs1hBjef4z9a2zy2QZAiY+Z3Ql+Exwayy4=; b=TChvMPI3bN29u2KdmUKs6t2OWZ
	DHlMQTqf7C3UFRIoBjO2DEtbcQ7HYvFUDyavoC+Ee6yVbX4+Pze1oViSOOF+ONVN1rQvAeLBPIoB9
	FqJRcfg00u4QLUakjXv+krvxbADHzW65nEMqcJV5TSCqysYfJgy33IsX46z8SarTqpYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woMf8-0002uV-Ck;
	Mon, 27 Jul 2026 14:50:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woMeo-0002uD-I1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:50:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A2xRA0J0MmrjZ/YeYNwMzPGfc/Ln1WYkpRFbAaXESQ4=; b=gl0+s/JFu26wWoXbliC6ebkD14
 MWGLUhoRvsaD7njlwPTu71URtwhQreu1nh8EYm4Ask5ymR+8qAzCYV8Ojp+QRjRfAhvAd2beKSUFE
 3Cv4yV2uO1Ezy/pdAALU+eN/q8aSaA7u3UexRRTF2M6jp2CVTw2o9UJDnpQMiL3PNsps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A2xRA0J0MmrjZ/YeYNwMzPGfc/Ln1WYkpRFbAaXESQ4=; b=I
 leOVybZvi/Nba2v4X8qKcvhxRNIcA+q9/O22Iay9zh9a+THAawyJ2aBniAysnu94IxDGKICp3oEBH
 4qHsb5+y7glMKK7bmtNOQbP1G/dOdZAVAHBgB7QRtz2dT4gIlgN7dW1idZoYzsSUH7s48P5QDd2JA
 dnchyG52xGpFXYiw=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woMeh-0000XU-CW for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:50:14 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-495437bb891so26212355e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785163805; x=1785768605; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A2xRA0J0MmrjZ/YeYNwMzPGfc/Ln1WYkpRFbAaXESQ4=;
 b=FjRLxBy7AmJ4cPRIJyRWFMb+f3QYIOjKuV/gMnL5oI0X8oE2TGctuns8TnErWpkBLg
 CkM7m3ohOH8OTwCCATRK1yjN5Tf3NoT2B6rTS0dWem2u1YDvitgxW17oINMAZM/azILh
 UW2irlgO3P9D/GDFX/AD8qlaCOZzs9Chu1H4gfiJVbcFeQHoIdIFE23+Dx30Q75+aoIi
 Ae9VQlL/dNAyskvSU40M2WCJjhp4xphsHcWqhjPAJZnbTCY5G5gWlAmbfje0DlAl5r63
 QEl76fr+DeN1YUC2eamxCzwaREpS2GnCzy4lFI+NYHemCG7Ue6E0Ym0i8EbIDO3H34XO
 VzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785163805; x=1785768605;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A2xRA0J0MmrjZ/YeYNwMzPGfc/Ln1WYkpRFbAaXESQ4=;
 b=R4QtvXwh+lzDfa506zesyvOU6F/FdDcVbbVu0vndcpCP3xWHwCZYVhKB0750C1wY01
 imdaiZBfVmXN9MZPBgOVE59EFIioOcv4obGh3Q18yzaEuD+dtYKGSx9fvZjjwvuY+48K
 ZmxS2OjLDfVKGFqWDr4VoVgGV8ZUD6rVhGEOePdje2uqmQMJM/GLLzrppuWa0gdGlBbr
 p7aD7zqcifVAU+Zhd7qPx7St5PaeulLngTll5Bl3EB+XxveRcWNimIhLGzVs9khzW3Yv
 YGUfE+UUAdnHIfA0nGF4Da0w/p1KAN0WGBrd7BvVtnoUmUMLwVHB9Elhxx/Euj+rhwpu
 Qs9g==
X-Gm-Message-State: AOJu0Yw2S3kIvAR95K7sdEPyirp4Qq5VHvRKNCEwAu+ncJ+fc4bLkvU8
 Isq1pFWMYAnW7gnlDfy+o9bwofeCXw+p90c0kHn/apmCIfWq7v/5txnd3YKqfBTxuv4U2d0bnA4
 c2jyGjLTZMRTGPoe7v0IHRcbZTECnA9lNjSee+W1R7rPstTDbBKeG+HIh1CZAnXuII9A/Pq+rhC
 0+S5UWAg==
X-Gm-Gg: AR+sD12RLyrQO5+VfKciJxUfUM48ttQDLUQnjt8CHQp9JlpSKwQ3btGKEJpd67fMTFs
 ku5Wn5gGWFO0lFSrw6LyPI1KKs5T4tUT++K1ldb9GVAnHph6ZEiMVM9PK9CGRx1A9apf6TqX7UT
 5RmiOlxrYwaIZFZYaNyK/tbDrbzfHRl52siSTA6p5Ozg4FOt+rS7E5ZNuSab5GivIlxX7VDHvEs
 AVbWzHju7TetU44EMcg3RQ9Q1qwpZKZTe1iiizblqezAaPIbgj58J/iLMYCBbOUTqQitDt9n3+9
 5tI4pT9NBnWgJ+vLMJh/e0F8HywyyFWljDtJn0oZs5AErAwn1mT4OrpEjkSBjpGyHE6XrfqOHDb
 JzPQ/5zANdTbakG/zRdTQ6P0f53rAC4ycbUd7ekfn9/QZ+QRKDPIKO2SAOceleEBz4GxQ2FLHST
 KOIG/hnthQxVKjg6vk58ggFTuC6mApiN4flAmHxNgqRuQh3rtMQCPLw7ivSdfORE2kdOfg6XP4x
 QKFZh5abzXisA4ENKh7bJ/2+p9FDyjKvbyVcPxHetQxm6mbcH8GpHEMfFETP9u5eaQZ
X-Received: by 2002:a05:600c:c48f:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-496b5b53259mr109315505e9.7.1785163804320; 
 Mon, 27 Jul 2026 07:50:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f395aasm226003115e9.15.2026.07.27.07.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:50:03 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 14:50:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 1051a4ef164c3c97f42459c97e27384b2e500bf4
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <88e456bb8366ea5d35c84c0fc4bad1633ca915a4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woMeh-0000XU-CW
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
Content-Type: multipart/mixed; boundary="===============1672051377104907059=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1672051377104907059==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ud3u7ljv7Ho="; charset=UTF-8

--ud3u7ljv7Ho=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, ordex=
=2E

Hello cron2, flichtenheld, plaisthos, 

I'd like you to reexamine a ch=
ange=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?us=
p=3Demail

to look at the new patch set (#28)=2E


Change subject: multipee=
r: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

multipeer: introduce asymmetric peer-id

In order to ac=
hieve a multipeer functionality, peers now
use separate IDs for sending (tx=
_peer_id) and receiving
(rx_peer_id)=2E

Each peer announces its own ID thr=
ough pushing peer-info
using 'ID=3D7f1' hex format so identification can st=
ill
happen even if IP/port changes=2E

In P2P mode, peer switch to using th=
e announced IDs after
mutual exchange=2E
In P2MP mode, clients always annou=
nce their ID, and servers
can optionally respond with their own to enable t=
he same
behavior=2E

Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
S=
igned-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/op=
envpn/dco=2Ec
M src/openvpn/init=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/m=
ulti=2Ec
M src/openvpn/push=2Ec
M src/openvpn/push_util=2Ec
M src/openvpn/s=
sl=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_ncp=2Ec
M src/openvpn=
/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
11 files changed, 191 insertions(+=
), 53 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/89/1089/28

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
index 914d191=2E=2Ee300af1 100644
--- a/src/openvpn/init=2Ec
+++ b/s=
rc/openvpn/init=2Ec
@@ -2209,7 +2209,7 @@
 
     if (o->use_peer_id)
     {=

-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_print=
f(&out, ", rx-peer-id: %u, tx-peer-id: %u", c->c2=2Etls_multi->rx_peer_id, =
c->c2=2Etls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2679,7 +2679,=
11 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
   =
      c->c2=2Etls_multi->use_peer_id =3D true;
-        c->c2=2Etls_multi->=
peer_id =3D c->options=2Epeer_id;
+        c->c2=2Etls_multi->tx_peer_id =
=3D c->options=2Epeer_id;
+        if (!c->c2=2Etls_multi->use_asymmetric_p=
eer_id)
+        {
+            c->c2=2Etls_multi->rx_peer_id =3D c->option=
s=2Epeer_id;
+        }
     }
 
     /* process (potentially) pushed optio=
ns */
@@ -3476,6 +3480,10 @@
     if (c->c2=2Etls_multi)
     {
         tl=
s_multi_init_finalize(c->c2=2Etls_multi, c->options=2Ece=2Etls_mtu);
+     =
   if (c->c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
+        {
+        =
    c->options=2Euse_peer_id =3D true;
+        }
         ASSERT(c->c2=2Et=
ls_multi->opt=2Eframe=2Ebuf=2Epayload_size <=3D c->c2=2Eframe=2Ebuf=2Epaylo=
ad_size);
         frame_print(&c->c2=2Etls_multi->opt=2Eframe, D_MTU_INFO,=
 "Control Channel MTU parms");
 
diff --git a/src/openvpn/misc=2Ec b/src/op=
envpn/misc=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/openvpn/misc=2Ec=

+++ b/src/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
         chomp(lin=
e);
         if (validate_peer_info_line(line)
-            && (strncmp(lin=
e, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
+            &&=
 (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0
+   =
             || strncmp(line, "ID", 2) =3D=3D 0))
         {
             m=
sg(M_INFO, "peer info: %s", line);
             env_set_add(es, line);
    =
     }
         else
         {
-            msg(M_WARN, "validation failed=
 on peer_info line received from client");
+            msg(M_WARN, "valida=
tion failed on peer_info line received");
         }
     }
 }
diff --git a=
/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index fe2badb=2E=2Ef823f5b 1=
00644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -430,7 +43=
0,7 @@
         if (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO=
_DEBUG)
             && dco_enabled(&mi->context=2Eoptions))
         {
-  =
          buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=2Etls_multi->p=
eer_id);
+            buf_printf(&out, " rx-peer-id=3D%d", mi->context=2Ec2=
=2Etls_multi->rx_peer_id);
         }
         return BSTR(&out);
     }
@@=
 -598,9 +598,9 @@
         }
 #endif
 
-        if (mi->context=2Ec2=2Etls_=
multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context=2Ec2=2Etls_multi-=
>rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->instances[mi->cont=
ext=2Ec2=2Etls_multi->peer_id] =3D NULL;
+            m->instances[mi->cont=
ext=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
 
             /* Adjust the ma=
x_peerid as this might have been the highest
              * peer id instan=
ce */
@@ -908,8 +908,7 @@
 #else
                         sep,
 #endif
-   =
                     sep,
-                        mi->context=2Ec2=2Etls_m=
ulti ? mi->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+               =
         sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->=
rx_peer_id : MAX_PEER_ID,
                         sep, translate_cipher_na=
me_to_openvpn(mi->context=2Eoptions=2Eciphername));
                 }
    =
             gc_free(&gc);
@@ -3121,12 +3120,12 @@
          * has, so we d=
isallow it=2E This can happen if a DCO netlink notification
          * get=
s lost and we miss a floating step=2E
          */
-        if (m1->peer_id=
 =3D=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
   =
      {
             msg(M_WARN,
                 "disallowing peer %" PRIu=
32 " (%s) from floating to "
                 "its own address (%s)",
-    =
            m1->peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, fals=
e),
+                m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls=
_multi, false),
                 mroute_addr_print(&mi->real, &gc));
      =
       goto done;
         }
@@ -3139,7 +3138,8 @@
     }
 
     msg(D_MULT=
I_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-        mi->conte=
xt=2Ec2=2Etls_multi->peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi,=
 false),
+        mi->context=2Ec2=2Etls_multi->rx_peer_id,
+        tls_co=
mmon_name(mi->context=2Ec2=2Etls_multi, false),
         mroute_addr_print_=
ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
         mroute_addr_print_ex(&real, =
MAPF_SHOW_FAMILY, &gc));
 
@@ -4099,7 +4099,7 @@
     {
         if (!m->in=
stances[i])
         {
-            mi->context=2Ec2=2Etls_multi->peer_id =
=3D i;
+            mi->context=2Ec2=2Etls_multi->rx_peer_id =3D i;
       =
      m->instances[i] =3D mi;
             break;
         }
@@ -4108,11 +4=
108,11 @@
     /* should not really end up here, since multi_create_instanc=
e returns null
      * if amount of clients exceeds max_clients and this me=
thod would then
      * also not have been called */
-    ASSERT(mi->contex=
t=2Ec2=2Etls_multi->peer_id < m->max_clients);
+    ASSERT(mi->context=2Ec2=
=2Etls_multi->rx_peer_id < m->max_clients);
 
-    if (mi->context=2Ec2=2Et=
ls_multi->peer_id > m->max_peerid)
+    if (mi->context=2Ec2=2Etls_multi->r=
x_peer_id > m->max_peerid)
     {
-        m->max_peerid =3D mi->context=2E=
c2=2Etls_multi->peer_id;
+        m->max_peerid =3D mi->context=2Ec2=2Etls_=
multi->rx_peer_id;
     }
 }
 
diff --git a/src/openvpn/push=2Ec b/src/open=
vpn/push=2Ec
index e391147=2E=2E633c007d 100644
--- a/src/openvpn/push=2Ec
=
+++ b/src/openvpn/push=2Ec
@@ -661,9 +661,9 @@
                         pri=
nt_in_addr_t(c->c2=2Epush_ifconfig_remote_netmask, 0, gc));
     }
 
-    i=
f (tls_multi->use_peer_id)
+    if (tls_multi->use_peer_id && !tls_multi->u=
se_asymmetric_peer_id)
     {
-        push_option_fmt(gc, push_list, M_USA=
GE, "peer-id %d", tls_multi->peer_id);
+        push_option_fmt(gc, push_li=
st, M_USAGE, "peer-id %d", tls_multi->rx_peer_id);
     }
     /*
      * I=
f server uses --auth-gen-token and we have an auth token
diff --git a/src/o=
penvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index f57f54d=2E=2Ec927f26=
 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ =
-188,7 +188,7 @@
         unsigned int permission_mask =3D pull_permission_=
mask(c);
         if (process_push_update(c, &o, permission_mask, &option_t=
ypes_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
-            =
msg(M_WARN, "Failed to process push update message sent to client ID: %u", =
c->c2=2Etls_multi->peer_id);
+            msg(M_WARN, "Failed to process pu=
sh update message sent to client ID: %u", c->c2=2Etls_multi->rx_peer_id);
 =
        }
         e =3D e->next;
     }
@@ -294,7 +294,7 @@
 
         if =
(!support_push_update(mi))
         {
-            msg(M_CLIENT, "PUSH_UPDA=
TE: not sending message to unsupported peer with ID: %u", mi->context=2Ec2=
=2Etls_multi->peer_id);
+            msg(M_CLIENT, "PUSH_UPDATE: not sendin=
g message to unsupported peer with ID: %u", mi->context=2Ec2=2Etls_multi->r=
x_peer_id);
             buffer_list_free(msgs);
             gc_free(&gc);=

             return 0;
@@ -329,7 +329,7 @@
         /* Type is UPT_BROADCA=
ST so we update every client */
         if (!send_single_push_update(m, cu=
rr_mi, msgs))
         {
-            msg(M_CLIENT, "ERROR: Peer ID: %u has=
 not been updated", curr_mi->context=2Ec2=2Etls_multi->peer_id);
+         =
   msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi->contex=
t=2Ec2=2Etls_multi->rx_peer_id);
             continue;
         }
        =
 count++;
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 60df=
7ce=2E=2E39985ac 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec=

@@ -1168,7 +1168,10 @@
     /* get command line derived options */
     re=
t->opt =3D *tls_options;
     ret->dco_peer_id =3D -1;
-    ret->peer_id =
=3D MAX_PEER_ID;
+    ret->use_asymmetric_peer_id =3D false;
+    /* The rx=
_peer_id is also used to identify DCO clients */
+    ret->rx_peer_id =3D M=
AX_PEER_ID;
+    ret->tx_peer_id =3D MAX_PEER_ID;
 
     return ret;
 }
@@ =
-1181,6 +1184,15 @@
 
     tls_session_init(multi, &multi->session[TM_ACTIV=
E]);
     tls_session_init(multi, &multi->session[TM_INITIAL]);
+
+    if (=
!multi->opt=2Edco_enabled)
+    {
+        /* Calculate the asymmetric peer=
-id */
+        if (multi->rx_peer_id =3D=3D MAX_PEER_ID && multi->session[=
TM_INITIAL]=2Eopt->mode !=3D MODE_SERVER)
+        {
+            multi->rx=
_peer_id =3D (uint32_t)(get_random() % (MAX_PEER_ID - 1));
+        }
+    =
}
 }
 
 /*
@@ -1858,6 +1870,25 @@
     return str;
 }
 
+static bool
+push_=
peer_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls_se=
ssion *session)
+{
+    if (multi->rx_peer_id =3D=3D MAX_PEER_ID || session=
->opt->dco_enabled)
+    {
+        /* No valid peer id or DCO is enabled=
=2E Cannot use this feature */
+        return true;
+    }
+
+    /* In se=
rver mode we only add this when the client has announced its
+     * suppor=
t for the feature */
+    if (session->opt->mode !=3D MODE_SERVER || multi-=
>use_asymmetric_peer_id)
+    {
+        return buf_printf(out, "ID=3D%x\n"=
, multi->rx_peer_id);
+    }
+
+    return true;
+}
+
 /**
  * Prepares the=
 IV_ and UV_ variables that are part of the
  * exchange to signal the peer=
's capabilities=2E The amount
@@ -1871,15 +1902,22 @@
  *
  * @param buf   =
    the buffer to write these variables to
  * @param session   the TLS ses=
sion object
+ * @param multi     the TLS multi object
  * @return          =
true if no error was encountered
  */
 static bool
-push_peer_info(struct b=
uffer *buf, struct tls_session *session)
+push_peer_info(struct buffer *buf=
, struct tls_multi *multi, struct tls_session *session)
 {
     struct gc_a=
rena gc =3D gc_new();
     bool ret =3D false;
     struct buffer out =3D a=
lloc_buf_gc(512 * 3, &gc);
 
+    /* The asymmetric peer-id is always writt=
en when enabled */
+    if (!push_peer_info_peerid(&out, multi, session))
+=
    {
+        goto error;
+    }
+
     if (session->opt->push_peer_info_d=
etail > 1)
     {
         /* push version */
@@ -2027,9 +2065,19 @@
     }=

     else
     {
-        if (!write_empty_string(buf)) /* no peer info */=

+        if (session->opt->mode =3D=3D MODE_SERVER && multi->use_asymmetri=
c_peer_id)
         {
-            goto error;
+            if (!write_stri=
ng(buf, BSTR(&out), -1))
+            {
+                goto error;
+     =
       }
+        }
+        else
+        {
+            if (!write_empty_=
string(buf))
+            {
+                goto error;
+            }
   =
      }
     }
     ret =3D true;
@@ -2156,7 +2204,7 @@
         }
     }
 =

-    if (!push_peer_info(buf, session))
+    if (!push_peer_info(buf, mult=
i, session))
     {
         goto error;
     }
@@ -2269,6 +2317,39 @@
    =
 if (multi->peer_info)
     {
         output_peer_info_env(session->opt->e=
s, multi->peer_info);
+        if (session->opt->mode =3D=3D MODE_SERVER)
+=
        {
+            if (!session->opt->dco_enabled)
+            {
+    =
            uint32_t peer_id =3D extract_asymmetric_peer_id(multi->peer_inf=
o);
+                if (peer_id !=3D MAX_PEER_ID)
+                {
+    =
                multi->tx_peer_id =3D peer_id;
+                    multi->=
use_asymmetric_peer_id =3D true;
+                    multi->use_peer_id =
=3D true;
+                }
+                else
+                {
+    =
                /* Client has no asymmetric peer-id capability */
+        =
            multi->tx_peer_id =3D multi->rx_peer_id;
+                }
+  =
          }
+            else
+            {
+                /* With DCO w=
e don't need the tx_peer_id atm */
+                multi->tx_peer_id =3D m=
ulti->rx_peer_id;
+            }
+        }
+        if (session->opt->mode=
 =3D=3D MODE_POINT_TO_POINT && !session->opt->dco_enabled)
+        {
+    =
        uint32_t peer_id =3D extract_asymmetric_peer_id(multi->peer_info);
=
+            if (peer_id !=3D MAX_PEER_ID)
+            {
+                =
multi->tx_peer_id =3D peer_id;
+                multi->use_asymmetric_peer_=
id =3D true;
+                multi->use_peer_id =3D true;
+            }
+=
        }
     }
 
     free(multi->remote_ciphername);
@@ -4016,8 +4097,8 =
@@
     msg(D_TLS_DEBUG, __func__);
 
     ASSERT(ks);
-
-    peer =3D hton=
l(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24 | (multi->peer_id & 0x=
FFFFFF));
+    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) =
<< 24
+                 | (multi->tx_peer_id & 0xFFFFFF));
     ASSERT(buf_=
write_prepend(buf, &peer, 4));
 }
 
diff --git a/src/openvpn/ssl_common=2Eh=
 b/src/openvpn/ssl_common=2Eh
index 9c90242=2E=2Ef6392f9 100644
--- a/src/o=
penvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -696,8 +696,10 @@=

 #define AUTH_TOKEN_VALID_EMPTYUSER (1 << 2)
 
     /* For P_DATA_V2 */
- =
   uint32_t peer_id;
+    uint32_t rx_peer_id;
+    uint32_t tx_peer_id;
  =
   bool use_peer_id;
+    bool use_asymmetric_peer_id;
 
     char *remote_=
ciphername; /**< cipher specified in peer's config file */
     bool remote=
_usescomp;    /**< remote announced comp-lzo in OCC string */
diff --git a/=
src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index baf5a95=2E=2Eb450de=
8 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -40=
8,6 +408,7 @@
 {
     /* will return 0 if peer_info is null */
     const u=
nsigned int iv_proto_peer =3D extract_iv_proto(multi->peer_info);
+    cons=
t unsigned int tx_peer_id =3D extract_asymmetric_peer_id(multi->peer_info);=

 
     /* The other peer does not support P2P NCP */
     if (!(iv_proto_p=
eer & IV_PROTO_NCP_P2P))
@@ -418,7 +419,6 @@
     if (iv_proto_peer & IV_PR=
OTO_DATA_V2)
     {
         multi->use_peer_id =3D true;
-        multi->p=
eer_id =3D 0x76706e; /* 'v' 'p' 'n' */
     }
 
     if (iv_proto_peer & IV=
_PROTO_CC_EXIT_NOTIFY)
@@ -441,27 +441,42 @@
     if (iv_proto_peer & IV_PR=
OTO_TLS_KEY_EXPORT)
     {
         session->opt->crypto_flags |=3D CO_USE_=
TLS_KEY_MATERIAL_EXPORT;
+    }
 
-        if (multi->use_peer_id)
+    if =
(multi->use_peer_id)
+    {
+        /* The asymmetric peer-id trumps on th=
e EKM generated ones */
+        if ((iv_proto_peer & IV_PROTO_TLS_KEY_EXPO=
RT)
+            && (tx_peer_id !=3D MAX_PEER_ID) && !multi->opt=2Edco_enab=
led)
         {
+            multi->tx_peer_id =3D tx_peer_id;
+           =
 multi->use_asymmetric_peer_id =3D true;
+        }
+        else
+        =
{
+            uint8_t peerid[3];
             /* Using a non hardcoded pee=
r-id makes a tiny bit harder to
              * fingerprint packets and als=
o gives each connection a unique
              * peer-id that can be useful=
 for NAT tracking etc=2E */
-
-            uint8_t peerid[3];
-            =
if (!key_state_export_keying_material(session, EXPORT_P2P_PEERID_LABEL,
-  =
                                                strlen(EXPORT_P2P_PEERID_LA=
BEL), &peerid, 3))
+            if ((iv_proto_peer & IV_PROTO_TLS_KEY_EXPOR=
T)
+                && key_state_export_keying_material(session, EXPORT_P2P=
_PEERID_LABEL,
+                                                    strlen(=
EXPORT_P2P_PEERID_LABEL), &peerid, 3))
             {
-                /* N=
on DCO setup might still work but also this should never
-                 =
* happen or very likely the TLS encryption key exporter will
-             =
    * also fail */
-                msg(M_NONFATAL, "TLS key export for P2P=
 peer id failed=2E "
-                                "Continuing anyway, e=
xpect problems");
+                multi->rx_peer_id =3D (peerid[0] << 16) =
+ (peerid[1] << 8) + peerid[2];
             }
             else
          =
   {
-                multi->peer_id =3D (peerid[0] << 16) + (peerid[1] << =
8) + peerid[2];
+                if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPOR=
T)
+                {
+                    /* Non DCO setup might still wor=
k but also this should never
+                     * happen or very likely =
the TLS encryption key exporter will
+                     * also fail */
+=
                    msg(M_NONFATAL, "TLS key export for P2P peer id failed=
=2E "
+                                    "Continuing anyway, expect probl=
ems");
+                }
+                multi->rx_peer_id =3D 0x76706e; =
/* 'v' 'p' 'n' */
             }
+            multi->tx_peer_id =3D multi->=
rx_peer_id;
         }
     }
     if (iv_proto_peer & IV_PROTO_DYN_TLS_CRY=
PT)
@@ -502,11 +517,13 @@
         common_cipher =3D BSTR(&out);
     }
 
-=
    msg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP negotiation result: "
-    =
    "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%s",
-=
        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT)=
, multi->use_peer_id,
-        multi->peer_id, (bool)(session->opt->crypto_=
flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D_TLS_DEBUG_LOW, "P2P mode NCP =
negotiation result: "
+                         "TLS_export=3D%d, DATA_v2=
=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s",
+        (bo=
ol)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
+        =
multi->use_peer_id,
+        multi->rx_peer_id,
+        multi->tx_peer_id,=

+        (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
  =
       common_cipher);
 
     gc_free(&gc);
diff --git a/src/openvpn/ssl_ut=
il=2Ec b/src/openvpn/ssl_util=2Ec
index 71fbc9e=2E=2E2f01f8a 100644
--- a/s=
rc/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -24,7 +24,7 @@
 #=
endif
 
 #include "syshead=2Eh"
-
+#include "openvpn=2Eh"
 #include "ssl_ut=
il=2Eh"
 
 char *
@@ -72,6 +72,25 @@
     return 0;
 }
 
+uint32_t
+extract=
_asymmetric_peer_id(const char *peer_info)
+{
+    for (const char *p =3D p=
eer_info; p && (p =3D strstr(p, "ID=3D")); p +=3D 3)
+    {
+        /* onl=
y accept "ID=3D" at the start of a line, so it does not match
+         * s=
ubstrings like "UV_ID=3D" or "GUID=3D" */
+        if (p =3D=3D peer_info |=
| p[-1] =3D=3D '\n')
+        {
+            uint32_t peer_id =3D 0;
+     =
       if (sscanf(p, "ID=3D%x", &peer_id) =3D=3D 1 && peer_id < MAX_PEER_ID=
)
+            {
+                return peer_id;
+            }
+        }=

+    }
+    return MAX_PEER_ID;
+}
+
 const char *
 options_string_compat_=
lzo(const char *options, struct gc_arena *gc)
 {
diff --git a/src/openvpn/s=
sl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 2177d94=2E=2E1a69e6f 100644
--=
- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
@@ -53,6 +53,15=
 @@
  */
 unsigned int extract_iv_proto(const char *peer_info);
 
+
+/**
+ =
* Extracts the ID variable and returns its value or
+ * MAX_PEER_ID if it c=
annot be extracted=2E
+ *
+ * @param peer_info     peer info string to sear=
ch for ID
+ */
+uint32_t extract_asymmetric_peer_id(const char *peer_info);=

+
 /**
  * Takes a locally produced OCC string for TLS server mode and mod=
ifies as
  * if the option comp-lzo was enabled=2E This is to send a client=
 in

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b67=
06acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 2=
8
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cron=
2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ordex <=
antonio@mandelbit=2Ecom>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <antonio@mand=
elbit=2Ecom>

--ud3u7ljv7Ho=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, ordex=2E </p>
<p>its_=
Giaan <strong>uploaded patch set #28</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">multipeer: introduce asymmetric peer-id<br><br>In o=
rder to achieve a multipeer functionality, peers now<br>use separate IDs fo=
r sending (tx_peer_id) and receiving<br>(rx_peer_id)=2E<br><br>Each peer an=
nounces its own ID through pushing peer-info<br>using &#39;ID=3D7f1&#39; he=
x format so identification can still<br>happen even if IP/port changes=2E<b=
r><br>In P2P mode, peer switch to using the announced IDs after<br>mutual e=
xchange=2E<br>In P2MP mode, clients always announce their ID, and servers<b=
r>can optionally respond with their own to enable the same<br>behavior=2E<b=
r><br>Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9<br>Signed-off-by=
: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/op=
envpn/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/misc=2Ec<br>M src/=
openvpn/multi=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/push_util=2Ec<=
br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M src/openvpn/s=
sl_ncp=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh<br>1=
1 files changed, 191 insertions(+), 53 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/108=
9/28</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><=
br><span>index 2584368=2E=2Ece73701 100644</span><br><span>--- a/src/openvp=
n/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -544=
,14 +544,15 @@</span><br><span>         c-&gt;c2=2Etls_multi-&gt;dco_peer_i=
d =3D -1;</span><br><span>     }</span><br><span> #endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_peer(&amp;c-&gt;=
c1=2Etuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                           proto_is_dg=
ram(sock-&gt;info=2Eproto) ? remoteaddr : NULL, NULL, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_new_peer(&amp;=
c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NULL,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                           NULL, NUL=
L);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</span><br><=
span>         return ret;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Etls_multi-&gt;d=
co_peer_id =3D multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi-&gt;rx_pee=
r_id;</span><br><span> </span><br><span>     return 0;</span><br><span> }</=
span><br><span>@@ -626,7 +627,7 @@</span><br><span> {</span><br><span>     =
struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =3D c-&gt;c2=2Etls_m=
ulti-&gt;peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><br><span>    =
 struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span>     str=
uct sockaddr_storage local =3D { 0 };</span><br><span>     const socket_des=
criptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><br><span>@@ -706=
,7 +707,7 @@</span><br><span>     {</span><br><span> #if defined(_WIN32)</s=
pan><br><span>         dco_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;d=
co, addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                c-&gt;c2=2Etls_multi-&g=
t;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                        c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><sp=
an> #else</span><br><span>         const struct in6_addr *gateway =3D &amp;=
mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span>         if=
 (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><span>@@ -723,7 +724,7 =
@@</span><br><span>     {</span><br><span> #if defined(_WIN32)</span><br><s=
pan>         dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&=
gt;v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                c-&gt;c2=2Etls_multi-&gt;peer_id)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
              c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #else<=
/span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4=2Eaddr);</spa=
n><br><span>         const in_addr_t *gateway =3D &amp;mi-&gt;context=2Ec2=
=2Epush_ifconfig_local;</span><br><span>diff --git a/src/openvpn/init=2Ec b=
/src/openvpn/init=2Ec</span><br><span>index 914d191=2E=2Ee300af1 100644</sp=
an><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/i=
nit=2Ec</span><br><span>@@ -2209,7 +2209,7 @@</span><br><span> </span><br><=
span>     if (o-&gt;use_peer_id)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;, peer=
-id: %d&quot;, o-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_printf(&amp;out, &quot;, rx-peer-id: %u, tx-peer-id:=
 %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id, c-&gt;c2=2Etls_multi-&gt;tx=
_peer_id);</span><br><span>     }</span><br><span> </span><br><span> #ifdef=
 USE_COMP</span><br><span>@@ -2679,7 +2679,11 @@</span><br><span>     {</sp=
an><br><span>         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-id set&q=
uot;);</span><br><span>         c-&gt;c2=2Etls_multi-&gt;use_peer_id =3D tr=
ue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=
=2Etls_multi-&gt;peer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Etls_multi-&gt;tx_peer_=
id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!c-&gt;c2=2Etls_multi-&gt;use_asymmetric_peer_id)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_mult=
i-&gt;rx_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span>=
 </span><br><span>     /* process (potentially) pushed options */</span><br=
><span>@@ -3476,6 +3480,10 @@</span><br><span>     if (c-&gt;c2=2Etls_multi=
)</span><br><span>     {</span><br><span>         tls_multi_init_finalize(c=
-&gt;c2=2Etls_multi, c-&gt;options=2Ece=2Etls_mtu);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=2Etls_multi-&gt;rx_p=
eer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       c-&gt;options=2Euse_peer_id =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>         ASSERT(c-&gt;c2=
=2Etls_multi-&gt;opt=2Eframe=2Ebuf=2Epayload_size &lt;=3D c-&gt;c2=2Eframe=
=2Ebuf=2Epayload_size);</span><br><span>         frame_print(&amp;c-&gt;c2=
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
dex 60df7ce=2E=2E39985ac 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</=
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
an>         /* push version */</span><br><span>@@ -2027,9 +2065,19 @@</span=
><br><span>     }</span><br><span>     else</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (!write_empty_strin=
g(buf)) /* no peer info */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (session-&gt;opt-&gt;mode =3D=3D MODE_SERVER &amp;&amp; m=
ulti-&gt;use_asymmetric_peer_id)</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (!write_string(buf=
, BSTR(&amp;out), -1))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (!write_empty=
_string(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span>         }</span><br><span>     }</span><br><span=
>     ret =3D true;</span><br><span>@@ -2156,7 +2204,7 @@</span><br><span> =
        }</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!push_peer_info(buf, session))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_info(buf=
, multi, session))</span><br><span>     {</span><br><span>         goto err=
or;</span><br><span>     }</span><br><span>@@ -2269,6 +2317,39 @@</span><br=
><span>     if (multi-&gt;peer_info)</span><br><span>     {</span><br><span=
>         output_peer_info_env(session-&gt;opt-&gt;es, multi-&gt;peer_info)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sessio=
n-&gt;opt-&gt;mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (!session-&gt;opt-&gt;dco_enabled)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                uint32_t peer_id =3D extr=
act_asymmetric_peer_id(multi-&gt;peer_info);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (peer_id !=3D MAX_PEER_ID)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    multi-=
&gt;tx_peer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    multi-&gt;use_asymmetric_peer_id =3D true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mult=
i-&gt;use_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    /* Client has no asymmetric peer-id capability */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                /* With DCO we don&#39;t need the tx_peer_id atm =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
ulti-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (session-&gt;opt-&gt;mode =3D=3D MODE_POINT_TO_POINT &=
amp;&amp; !session-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            uint32_t peer_id =3D extract_asymmetric_peer_id(m=
ulti-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                multi-&gt;tx_peer_id =3D peer_id;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;us=
e_asymmetric_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                multi-&gt;use_peer_id =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><b=
r><span> </span><br><span>     free(multi-&gt;remote_ciphername);</span><br=
><span>@@ -4016,8 +4097,8 @@</span><br><span>     msg(D_TLS_DEBUG, __func__=
);</span><br><span> </span><br><span>     ASSERT(ks);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt=
;key_id) &lt;&lt; 24 | (multi-&gt;peer_id &amp; 0xFFFFFF));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    peer =3D htonl(((P_DATA_V2 &lt;=
&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                 | (multi-&gt;tx_peer_id &amp=
; 0xFFFFFF));</span><br><span>     ASSERT(buf_write_prepend(buf, &amp;peer,=
 4));</span><br><span> }</span><br><span> </span><br><span>diff --git a/src=
/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index =
9c90242=2E=2Ef6392f9 100644</span><br><span>--- a/src/openvpn/ssl_common=2E=
h</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -696,=
8 +696,10 @@</span><br><span> #define AUTH_TOKEN_VALID_EMPTYUSER (1 &lt;&lt=
; 2)</span><br><span> </span><br><span>     /* For P_DATA_V2 */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t rx_peer_id;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t tx_peer_id;</=
span><br><span>     bool use_peer_id;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool use_asymmetric_peer_id;</span><br><span> </span>=
<br><span>     char *remote_ciphername; /**&lt; cipher specified in peer&#3=
9;s config file */</span><br><span>     bool remote_usescomp;    /**&lt; re=
mote announced comp-lzo in OCC string */</span><br><span>diff --git a/src/o=
penvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index baf5a95=
=2E=2Eb450de8 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><b=
r><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -408,6 +408,7 @@</=
span><br><span> {</span><br><span>     /* will return 0 if peer_info is nul=
l */</span><br><span>     const unsigned int iv_proto_peer =3D extract_iv_p=
roto(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const unsigned int tx_peer_id =3D extract_asymmetric_peer_id(mul=
ti-&gt;peer_info);</span><br><span> </span><br><span>     /* The other peer=
 does not support P2P NCP */</span><br><span>     if (!(iv_proto_peer &amp;=
 IV_PROTO_NCP_P2P))</span><br><span>@@ -418,7 +419,6 @@</span><br><span>   =
  if (iv_proto_peer &amp; IV_PROTO_DATA_V2)</span><br><span>     {</span><b=
r><span>         multi-&gt;use_peer_id =3D true;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        multi-&gt;peer_id =3D 0x76706e; /* &#39;=
v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span>     }</span><br><span> <=
/span><br><span>     if (iv_proto_peer &amp; IV_PROTO_CC_EXIT_NOTIFY)</span=
><br><span>@@ -441,27 +441,42 @@</span><br><span>     if (iv_proto_peer &am=
p; IV_PROTO_TLS_KEY_EXPORT)</span><br><span>     {</span><br><span>        =
 session-&gt;opt-&gt;crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt;=
use_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(multi-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 The asymmetric peer-id trumps on the EKM generated ones */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if ((iv_proto_peer &amp; IV=
_PROTO_TLS_KEY_EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &amp;&amp; (tx_peer_id !=3D MAX_PEER_ID) &amp;&amp; !multi-&=
gt;opt=2Edco_enabled)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D tx_peer_i=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi=
-&gt;use_asymmetric_peer_id =3D true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   uint8_t peerid[3];</span><br><span>             /* Using a non hardcoded=
 peer-id makes a tiny bit harder to</span><br><span>              * fingerp=
rint packets and also gives each connection a unique</span><br><span>      =
        * peer-id that can be useful for NAT tracking etc=2E */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            uint8_t peerid[3];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!key_state_export_keying_ma=
terial(session, EXPORT_P2P_PEERID_LABEL,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                                  strlen=
(EXPORT_P2P_PEERID_LABEL), &amp;peerid, 3))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if ((iv_proto_peer &amp; IV_PROTO_TLS_K=
EY_EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       &amp;&amp; key_state_export_keying_material(session, EXPORT_P2P_PEER=
ID_LABEL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                          strlen(EXPORT_P2P_PEERID_LABEL), =
&amp;peerid, 3))</span><br><span>             {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                /* Non DCO setup might still work=
 but also this should never</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                 * happen or very likely the TLS encryption key expor=
ter will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
    * also fail */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             msg(M_NONFATAL, &quot;TLS key export for P2P peer id failed=2E=
 &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                  &quot;Continuing anyway, expect problems&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;rx=
_peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];<=
/span><br><span>             }</span><br><span>             else</span><br>=
<span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               multi-&gt;peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &=
lt;&lt; 8) + peerid[2];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                if (iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    /* Non D=
CO setup might still work but also this should never</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     * happen or very lik=
ely the TLS encryption key exporter will</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     * also fail */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    msg(M_NONFATAL, &q=
uot;TLS key export for P2P peer id failed=2E &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    &quot=
;Continuing anyway, expect problems&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                multi-&gt;rx_peer_id =3D 0x76706e; /*=
 &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span>             }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;tx=
_peer_id =3D multi-&gt;rx_peer_id;</span><br><span>         }</span><br><sp=
an>     }</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_DYN_TLS_CRY=
PT)</span><br><span>@@ -502,11 +517,13 @@</span><br><span>         common_c=
ipher =3D BSTR(&amp;out);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_TLS_DEBUG_LOW,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;P2P mode NCP =
negotiation result: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        &quot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, c=
ipher=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_E=
XPORT), multi-&gt;use_peer_id,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        multi-&gt;peer_id, (bool)(session-&gt;opt-&gt;crypto_flags=
 &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiation resul=
t: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
               &quot;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-=
id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_=
USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        multi-&gt;use_peer_id,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        multi-&gt;rx_peer_id,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        multi-&gt;tx_peer_id,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt=
;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span>         com=
mon_cipher);</span><br><span> </span><br><span>     gc_free(&amp;gc);</span=
><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec=
</span><br><span>index 71fbc9e=2E=2E2f01f8a 100644</span><br><span>--- a/sr=
c/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=2Ec</span=
><br><span>@@ -24,7 +24,7 @@</span><br><span> #endif</span><br><span> </spa=
n><br><span> #include &quot;syshead=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;openvpn=2Eh&quot;</span><br><span> #include &quot;ssl_u=
til=2Eh&quot;</span><br><span> </span><br><span> char *</span><br><span>@@ =
-72,6 +72,25 @@</span><br><span>     return 0;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_t</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_asymmetric_pee=
r_id(const char *peer_info)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (c=
onst char *p =3D peer_info; p &amp;&amp; (p =3D strstr(p, &quot;ID=3D&quot;=
)); p +=3D 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* only acce=
pt &quot;ID=3D&quot; at the start of a line, so it does not match</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * substrings like &q=
uot;UV_ID=3D&quot; or &quot;GUID=3D&quot; */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (p =3D=3D peer_info || p[-1] =3D=3D &#3=
9;\n&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint32_=
t peer_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (sscanf(p, &quot;ID=3D%x&quot;, &amp;peer_id) =3D=3D 1 &amp;&am=
p; peer_id &lt; MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                return peer_id;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return MAX_=
PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char =
*</span><br><span> options_string_compat_lzo(const char *options, struct gc=
_arena *gc)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl=
_util=2Eh b/src/openvpn/ssl_util=2Eh</span><br><span>index 2177d94=2E=2E1a6=
9e6f 100644</span><br><span>--- a/src/openvpn/ssl_util=2Eh</span><br><span>=
+++ b/src/openvpn/ssl_util=2Eh</span><br><span>@@ -53,6 +53,15 @@</span><br=
><span>  */</span><br><span> unsigned int extract_iv_proto(const char *peer=
_info);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Extracts the ID variable a=
nd returns its value or</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * MAX_PEER_ID if it cannot be extracted=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param peer_info     peer info string to search for ID</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+uint32_t extract_asymmetric_peer_id(const=
 char *peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /**</span><br><span>  * Takes a locally produced OCC strin=
g for TLS server mode and modifies as</span><br><span>  * if the option com=
p-lzo was enabled=2E This is to send a client in</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1089?usp=3Demail">change 1089</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 28 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--ud3u7ljv7Ho=--


--===============1672051377104907059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1672051377104907059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1672051377104907059==--

