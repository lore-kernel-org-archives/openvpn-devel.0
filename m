Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE313CD6E44
	for <openvpn-devel@archiver.kernel.org>; Wed, 27 May 2026 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/xb+kFLhMVyNPwCamDXmvJa7g/l0NcpEFL48DnsfbqI=; b=Njtc2yIRe3Hc/2oI0Mtlg4yO+y
	AMZEfBaSpqrGzpszAoaP98JpygcePVlMwvmE9iUXwDpIQfh9er0/z8ndMxtXT4eReFstv0hW+l92m
	YY95NmYGIBfS0EDXzIt7an83xBuEX9chlSKlT5K0N4KVpFbrJotddVaFi1esYDA/yXZs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSG0v-00012a-2i;
	Wed, 27 May 2026 15:17:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wSG0Y-000110-Bj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZldJUn5TWkWwqk7dSh49RBpz8Xm+bt3w0gjn5qQne4M=; b=ZJe9FZ4xhopqtcp5Juvn9avBQ9
 aPBFkwxdusFSJCirkEHFuplWHmGX8U4qLJnV/yzp2iq6KKbf90ExRQsN5Bc7Dm8v48VwgelytcJ50
 NsKVVEUxAQQK8v7r02MiUL6uoXN+Rv4IynPT7q8Bwbhw0QnwyyDBLJAFctRvRv6U3ShA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZldJUn5TWkWwqk7dSh49RBpz8Xm+bt3w0gjn5qQne4M=; b=n
 C8We3uQnJ1+0C9o9Ev7cFHDeLFbx2bi6qImLwLA4QDvaBVhdn/GA80wZPTn0/4iDmo6ooq1xctx8J
 E9v3ZZO3oxIlnGjl/Xv5hMDzzu/C0NeMpgkJHkYS3pnQFsWT/S84OLmapkqN1lV84mg8bfw5E3yDi
 Cx3lXkndTOuEgTA8=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wSG0L-0002Ei-6Y for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:17:14 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so55729175e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 27 May 2026 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779895018; x=1780499818; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZldJUn5TWkWwqk7dSh49RBpz8Xm+bt3w0gjn5qQne4M=;
 b=F8mx+xmJ/Ajd+GkPxURQXsji+0R8ueEfQQlTAHwSJqFAf4lVb7ZaYLOP43XZZc1cfS
 S2V46fvLRLI95cMdQ9EWuG7a4vZ8qZHJuqqj7G51CYXcFbkmSzTc61r3J4Yi4F5XBUln
 aBU+pPaUTuWz6kImbgsYPmcZLBvQ/OYxApanwKKKalsvQjhhDjaNsXcRbPPS07BTXtDI
 Q7ctmig8i+2I79c63m5suEnB1MtF6ufjSSflcokoOlxzhNKlU1GjvValRpOtL3D7iz7z
 2wHkZHDisc2+iTtq0AVKra9FTbT6A+KtXqM1HHr9DhbL55lOPn8aILVyjB+UZVv0sSwu
 yZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779895018; x=1780499818;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZldJUn5TWkWwqk7dSh49RBpz8Xm+bt3w0gjn5qQne4M=;
 b=gMOadwULam51hKjdkenT102sAGH7fXlLR3IEXqodHa1+QnF6coUpUvUc/CK3EFeeKA
 yuD80O9iWjLPGZV0BXSnFzXv2l81PUnGHhy9MkJgn0IYc+BcMF7lLd5wun/q5pidrH92
 wNPpyfPSHD0Z1SvYPLxEzA2q4lC7J9PYhrLMmyUW63IvSxp9bf+BM/CElKaoyznbKV+l
 LmhLEpx9djou7A9ZoksH9095MTIwYvl5s9RFxKL+G+oUNgrTdFP18NPGzgYls5mWVJQj
 93rJIlQrbwVyaOnuUUy15oNaYVJND6YOx2pRqMxMfFrQ05PzTWxHUz71BuM520s/Ww2d
 Khpg==
X-Gm-Message-State: AOJu0YznCkaZETNCKbsyNTTfGLCFd8/nvUu3wHyVMs0VcWHm1p5ff8va
 3+LEqFkc7O0+UziOo1uG6ID4OWP2YDv0BjkS/LpzaMF2dNFGLaDZYPA9LJ3bQG8/5QkBIo/wy17
 18HQ9OmTWTsq5mGeJBo997B8LYRE0qvr1/CMBsip47+5WG8nJw9r0+FmW4H8L8Wy5eFX1
X-Gm-Gg: Acq92OEk59u0tVLKzHZ88nDRefA+9x3pxRobgrP1HAlS/XaQSNWbrgRGekwE6c6xRRE
 /pxCU52uZujFIH8v7xZLLggMMBex1wn+ju3ofYAYe83lJO4KyctJtWPjdyNOfi26qX9NC13iDLe
 Sn3I+P07isng9jULQif0bWTFJugViVHsK46V4MLNbr6TXbWwPqgh4e6wLmPcO6GgCaxlBTutXVj
 aIOPxioJKdiY0V6CRu65eoDg09D/5wtgv/xgw6gTbW4qEqkIivAKejx4m/RsGMVN/YURRg59jZo
 vT+j4h+ew5aUbaOGXLOWP9fAWLTvKPRxTQfbYb6L7Yl8JZy0CiH0uY0fHzOzlOooAsbuQ1yrZTl
 9lMWlRQhM+CpLwHZFgn3GfPX6A7san32r+inlCukUCeFvtQkEY+DWGW2frOS9k1uWFrASeYP26z
 Fdo8PTVRBhXZqvRPGV8NTk2ow9IPhYnxHe6CjBN60adK+QUAyy7K58W3QPBh7L75lTXGiQOp4E9
 UAxyGZM+wIGyyjXr4DzLK6n5cJjq/JOobMiJFLl73SdK8dgjoUOGO1eYbHn5dlZsyx2ix2zLRuR
 zSnpPCwqEnwP4gRICNtTPxeZ
X-Received: by 2002:a05:600c:4746:b0:490:469c:556b with SMTP id
 5b1f17b1804b1-490469c56d6mr372615095e9.12.1779895017564; 
 Wed, 27 May 2026 08:16:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527dbf3sm380190135e9.6.2026.05.27.08.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:16:56 -0700 (PDT)
From: "its_Giaan (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 27 May 2026 15:16:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 040bb8548c15c48df5d615e916e46e7669c8d32b
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c678cef3cef77a4f76f92f46d4be05a66e618d95-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wSG0L-0002Ei-6Y
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
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7599005063714334722=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7599005063714334722==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kBxnyei8dXU="; charset=UTF-8

--kBxnyei8dXU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos=2E=


Hello cron2, flichtenheld, plaisthos, 

I'd like you to reexamine a chang=
e=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=
=3Demail

to look at the new patch set (#11)=2E

The following approvals go=
t outdated and were removed:
Code-Review-1 by plaisthos


Change subject: m=
ultipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

multipeer: introduce asymmetric peer-id

In order=
 to achieve a multipeer functionality, peers now
use separate IDs for sendi=
ng (tx_peer_id) and receiving
(rx_peer_id)=2E

Each peer announces its own =
ID through pushing peer-info
using 'ID=3D7f1' hex format so identification =
can still
happen even if IP/port changes=2E

In P2P mode, peer switch to us=
ing the announced IDs after
mutual exchange=2E
In P2MP mode, clients always=
 announce their ID, and servers
can optionally respond with their own to en=
able the same
behavior=2E

Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff63=
9bf9
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M =
src/openvpn/dco=2Ec
M src/openvpn/init=2Ec
M src/openvpn/misc=2Ec
M src/ope=
nvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/push=2Ec
M src/openv=
pn/push_util=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M src/o=
penvpn/ssl_ncp=2Ec
M src/openvpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
12=
 files changed, 189 insertions(+), 47 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1089/11

diff --git a/src/o=
penvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f5b7081=2E=2E901b9bd 100644
--- =
a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -528,14 +528,15 @@
     =
    c->c2=2Etls_multi->dco_peer_id =3D -1;
     }
 #endif
-    int ret =3D =
dco_new_peer(&c->c1=2Etuntap->dco, multi->peer_id, sock->sd, NULL,
-       =
                    proto_is_dgram(sock->info=2Eproto) ? remoteaddr : NULL,=
 NULL, NULL);
+    int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx=
_peer_id, sock->sd, NULL,
+                           proto_is_dgram(sock->=
info=2Eproto) ? remoteaddr : NULL,
+                           NULL, NULL);=

     if (ret < 0)
     {
         return ret;
     }
 
-    c->c2=2Etls_mu=
lti->dco_peer_id =3D multi->peer_id;
+    c->c2=2Etls_multi->dco_peer_id =
=3D multi->rx_peer_id;
 
     return 0;
 }
@@ -610,7 +611,7 @@
 {
     stru=
ct context *c =3D &mi->context;
 
-    int peer_id =3D c->c2=2Etls_multi->p=
eer_id;
+    int peer_id =3D c->c2=2Etls_multi->rx_peer_id;
     struct soc=
kaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =
=3D { 0 };
     const socket_descriptor_t sd =3D c->c2=2Elink_sockets[0]->s=
d;
@@ -689,8 +690,7 @@
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if d=
efined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr-=
>v6=2Eaddr, addr->netbits,
-                                c->c2=2Etls_mul=
ti->peer_id);
+        dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr->=
v6=2Eaddr, addr->netbits, c->c2=2Etls_multi->rx_peer_id);
 #else
         c=
onst struct in6_addr *gateway =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_lo=
cal;
         if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -706,8 +706,7 @@
    =
 else if (addrtype =3D=3D MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-      =
  dco_win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netb=
its,
-                                c->c2=2Etls_multi->peer_id);
+       =
 dco_win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbi=
ts, c->c2=2Etls_multi->rx_peer_id);
 #else
         in_addr_t dest =3D hton=
l(addr->v4=2Eaddr);
         const in_addr_t *gateway =3D &mi->context=2Ec2=
=2Epush_ifconfig_local;
diff --git a/src/openvpn/init=2Ec b/src/openvpn/ini=
t=2Ec
index caaa769=2E=2E468c260 100644
--- a/src/openvpn/init=2Ec
+++ b/sr=
c/openvpn/init=2Ec
@@ -2209,7 +2209,7 @@
 
     if (o->use_peer_id)
     {
=
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_printf=
(&out, ", rx-peer-id: %u, tx-peer-id: %u", c->c2=2Etls_multi->rx_peer_id, c=
->c2=2Etls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2688,7 +2688,1=
2 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
    =
     c->c2=2Etls_multi->use_peer_id =3D true;
-        c->c2=2Etls_multi->p=
eer_id =3D c->options=2Epeer_id;
+        c->c2=2Etls_multi->tx_peer_id =3D=
 c->options=2Epeer_id;
+        if (!c->c2=2Etls_multi->use_asymmetric_peer=
_id)
+        {
+            c->c2=2Etls_multi->rx_peer_id =3D c->options=
=2Epeer_id;
+            c->c2=2Etls_multi->tx_peer_id =3D c->options=2Epee=
r_id;
+        }
     }
 
     /* process (potentially) pushed options */
@=
@ -3485,6 +3490,10 @@
     if (c->c2=2Etls_multi)
     {
         tls_multi=
_init_finalize(c->c2=2Etls_multi, c->options=2Ece=2Etls_mtu);
+        if (=
c->c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
+        {
+            c->=
options=2Euse_peer_id =3D true;
+        }
         ASSERT(c->c2=2Etls_mult=
i->opt=2Eframe=2Ebuf=2Epayload_size <=3D c->c2=2Eframe=2Ebuf=2Epayload_size=
);
         frame_print(&c->c2=2Etls_multi->opt=2Eframe, D_MTU_INFO, "Contr=
ol Channel MTU parms");
 
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/m=
isc=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/openvpn/misc=2Ec
+++ b/=
src/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
         chomp(line);
   =
      if (validate_peer_info_line(line)
-            && (strncmp(line, "IV_=
", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
+            && (strnc=
mp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0
+          =
      || strncmp(line, "ID", 2) =3D=3D 0))
         {
             msg(M_IN=
FO, "peer info: %s", line);
             env_set_add(es, line);
         }
=
         else
         {
-            msg(M_WARN, "validation failed on pee=
r_info line received from client");
+            msg(M_WARN, "validation fa=
iled on peer_info line received");
         }
     }
 }
diff --git a/src/op=
envpn/multi=2Ec b/src/openvpn/multi=2Ec
index a957fdf=2E=2Ee96d43c 100644
-=
-- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -430,7 +430,7 @@
=
         if (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)=

             && dco_enabled(&mi->context=2Eoptions))
         {
-         =
   buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=2Etls_multi->peer_id)=
;
+            buf_printf(&out, " rx-peer-id=3D%d", mi->context=2Ec2=2Etls_=
multi->rx_peer_id);
         }
         return BSTR(&out);
     }
@@ -598,9=
 +598,9 @@
         }
 #endif
 
-        if (mi->context=2Ec2=2Etls_multi->=
peer_id !=3D MAX_PEER_ID)
+        if (mi->context=2Ec2=2Etls_multi->rx_pee=
r_id !=3D MAX_PEER_ID)
         {
-            m->instances[mi->context=2Ec=
2=2Etls_multi->peer_id] =3D NULL;
+            m->instances[mi->context=2Ec=
2=2Etls_multi->rx_peer_id] =3D NULL;
 
             /* Adjust the max_peeri=
d as this might have been the highest
              * peer id instance */
@=
@ -908,8 +908,7 @@
 #else
                         sep,
 #endif
-          =
              sep,
-                        mi->context=2Ec2=2Etls_multi ? =
mi->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+                      =
  sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->rx_peer=
_id : MAX_PEER_ID,
                         sep, translate_cipher_name_to_o=
penvpn(mi->context=2Eoptions=2Eciphername));
                 }
           =
      gc_free(&gc);
@@ -1727,6 +1726,7 @@
         tls_multi->use_peer_id =
=3D true;
         o->use_peer_id =3D true;
     }
+
     else if (dco_enab=
led(o))
     {
         msg(M_INFO, "Client does not support DATA_V2=2E Dat=
a channel offloading "
@@ -3121,12 +3121,12 @@
          * has, so we disal=
low it=2E This can happen if a DCO netlink notification
          * gets lo=
st and we miss a floating step=2E
          */
-        if (m1->peer_id =3D=
=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
       =
  {
             msg(M_WARN,
                 "disallowing peer %" PRIu32 "=
 (%s) from floating to "
                 "its own address (%s)",
-        =
        m1->peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
=
+                m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_mul=
ti, false),
                 mroute_addr_print(&mi->real, &gc));
          =
   goto done;
         }
@@ -3139,9 +3139,10 @@
     }
 
     msg(D_MULTI_M=
EDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-        mi->context=
=2Ec2=2Etls_multi->peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, f=
alse),
-        mroute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
-  =
      mroute_addr_print_ex(&real, MAPF_SHOW_FAMILY, &gc));
+        mi->con=
text=2Ec2=2Etls_multi->rx_peer_id,
+        tls_common_name(mi->context=2Ec=
2=2Etls_multi, false),
+        mroute_addr_print(&mi->real, &gc),
+       =
 print_link_socket_actual(&m->top=2Ec2=2Efrom, &gc));
 
     /* remove old =
address from hash table before changing address */
     ASSERT(hash_remove(=
m->hash, &mi->real));
@@ -4086,7 +4087,7 @@
     {
         if (!m->instanc=
es[i])
         {
-            mi->context=2Ec2=2Etls_multi->peer_id =3D i;=

+            mi->context=2Ec2=2Etls_multi->rx_peer_id =3D i;
             =
m->instances[i] =3D mi;
             break;
         }
@@ -4095,11 +4096,11=
 @@
     /* should not really end up here, since multi_create_instance retu=
rns null
      * if amount of clients exceeds max_clients and this method w=
ould then
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
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn=
/options=2Ec
index 0c2866c=2E=2Eed5897d 100644
--- a/src/openvpn/options=2E=
c
+++ b/src/openvpn/options=2Ec
@@ -3871,6 +3871,7 @@
                     =
 "incompatible with each other=2E");
     }
 
+
     if (dco_enabled(o))
  =
   {
         /* check if any option should force disabling DCO */
diff --g=
it a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 564ce86=2E=2Eddd1b7e=
 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -661,9 +66=
1,10 @@
                         print_in_addr_t(c->c2=2Epush_ifconfig_remo=
te_netmask, 0, gc));
     }
 
-    if (tls_multi->use_peer_id)
+    if (!tl=
s_multi->use_asymmetric_peer_id)
     {
-        push_option_fmt(gc, push_l=
ist, M_USAGE, "peer-id %d", tls_multi->peer_id);
+        push_option_fmt(g=
c, push_list, M_USAGE, "peer-id %d",
+                        tls_multi->rx=
_peer_id);
     }
     /*
      * If server uses --auth-gen-token and we ha=
ve an auth token
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_=
util=2Ec
index f57f54d=2E=2Ec927f26 100644
--- a/src/openvpn/push_util=2Ec
=
+++ b/src/openvpn/push_util=2Ec
@@ -188,7 +188,7 @@
         unsigned int p=
ermission_mask =3D pull_permission_mask(c);
         if (process_push_updat=
e(c, &o, permission_mask, &option_types_found, &tmp_msg, true) =3D=3D PUSH_=
MSG_ERROR)
         {
-            msg(M_WARN, "Failed to process push upda=
te message sent to client ID: %u", c->c2=2Etls_multi->peer_id);
+          =
  msg(M_WARN, "Failed to process push update message sent to client ID: %u"=
, c->c2=2Etls_multi->rx_peer_id);
         }
         e =3D e->next;
     }=

@@ -294,7 +294,7 @@
 
         if (!support_push_update(mi))
         {
- =
           msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported p=
eer with ID: %u", mi->context=2Ec2=2Etls_multi->peer_id);
+            msg(=
M_CLIENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u=
", mi->context=2Ec2=2Etls_multi->rx_peer_id);
             buffer_list_free=
(msgs);
             gc_free(&gc);
             return 0;
@@ -329,7 +329,7 =
@@
         /* Type is UPT_BROADCAST so we update every client */
         =
if (!send_single_push_update(m, curr_mi, msgs))
         {
-            msg=
(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi->context=2Ec2=
=2Etls_multi->peer_id);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has =
not been updated", curr_mi->context=2Ec2=2Etls_multi->rx_peer_id);
        =
     continue;
         }
         count++;
diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec
index d332359c=2E=2Efdb4f2a 100644
--- a/src/openvp=
n/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1168,7 +1168,10 @@
     /* get comm=
and line derived options */
     ret->opt =3D *tls_options;
     ret->dco_p=
eer_id =3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+    ret->use_asymmetric_=
peer_id =3D false;
+    /* The rx_peer_id is also used to identify DCO clie=
nts */
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    ret->tx_peer_id =3D MAX_P=
EER_ID;
 
     return ret;
 }
@@ -1181,6 +1184,22 @@
 
     tls_session_ini=
t(multi, &multi->session[TM_ACTIVE]);
     tls_session_init(multi, &multi->=
session[TM_INITIAL]);
+
+    if (!multi->opt=2Edco_enabled)
+    {
+       =
 /* Calculate the asymmetric peer-id */
+        if (multi->rx_peer_id =3D=
=3D MAX_PEER_ID && multi->session[TM_INITIAL]=2Eopt->mode !=3D MODE_SERVER)=

+        {
+            uint8_t peerid[3];
+            srand((unsigned)ti=
me(NULL));
+            for (int i =3D 0; i < 3; i++)
+            {
+     =
           peerid[i] =3D (uint8_t)rand();
+            }
+
+            mul=
ti->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+     =
   }
+    }
 }
 
 /*
@@ -1858,6 +1877,25 @@
     return str;
 }
 
+static b=
ool
+push_peer_info_peerid(struct buffer *out, struct tls_multi *multi, str=
uct tls_session *session)
+{
+    if (multi->rx_peer_id =3D=3D MAX_PEER_ID =
|| session->opt->dco_enabled)
+    {
+        /* No valid peer id or DCO is=
 enabled=2E Cannot use this feature */
+        return true;
+    }
+
+    =
/* In server mode we only add this when the client has announced its
+     =
* support for the feature */
+    if (session->opt->mode !=3D MODE_SERVER |=
| multi->use_asymmetric_peer_id)
+    {
+        return buf_printf(out, "ID=
=3D%x\n", multi->rx_peer_id);
+    }
+
+    return true;
+}
+
 /**
  * Prep=
ares the IV_ and UV_ variables that are part of the
  * exchange to signal =
the peer's capabilities=2E The amount
@@ -1871,15 +1909,22 @@
  *
  * @para=
m buf       the buffer to write these variables to
  * @param session   the=
 TLS session object
+ * @param multi     the TLS multi object
  * @return  =
        true if no error was encountered
  */
 static bool
-push_peer_info(=
struct buffer *buf, struct tls_session *session)
+push_peer_info(struct buf=
fer *buf, struct tls_multi *multi, struct tls_session *session)
 {
     str=
uct gc_arena gc =3D gc_new();
     bool ret =3D false;
     struct buffer o=
ut =3D alloc_buf_gc(512 * 3, &gc);
 
+    /* The asymmetric peer-id is alwa=
ys written when enabled */
+    if (!push_peer_info_peerid(&out, multi, ses=
sion))
+    {
+        goto error;
+    }
+
     if (session->opt->push_pee=
r_info_detail > 1)
     {
         /* push version */
@@ -2027,7 +2072,9 @@=

     }
     else
     {
-        if (!write_empty_string(buf)) /* no peer =
info */
+        if (!(session->opt->mode =3D=3D MODE_SERVER && multi->use_=
asymmetric_peer_id
+                  ? write_string(buf, BSTR(&out), -1)
+=
                  : write_empty_string(buf)))
         {
             goto =
error;
         }
@@ -2156,7 +2203,7 @@
         }
     }
 
-    if (!push_=
peer_info(buf, session))
+    if (!push_peer_info(buf, multi, session))
   =
  {
         goto error;
     }
@@ -2269,6 +2316,44 @@
     if (multi->peer=
_info)
     {
         output_peer_info_env(session->opt->es, multi->peer_i=
nfo);
+        if (session->opt->mode =3D=3D MODE_SERVER)
+        {
+     =
       if (!session->opt->dco_enabled)
+            {
+                uint=
32_t peer_id =3D extract_asymmetric_peer_id(multi->peer_info);
+           =
     if (peer_id !=3D MAX_PEER_ID)
+                {
+                    =
multi->tx_peer_id =3D peer_id;
+                    multi->use_asymmetric_p=
eer_id =3D true;
+                    multi->use_peer_id =3D true;
+       =
         }
+                else
+                {
+                    /*=
 Client has no asymmetric peer-id capability */
+                    multi-=
>tx_peer_id =3D multi->rx_peer_id;
+                }
+            }
+     =
       else
+            {
+                /* With DCO we don't need the t=
x_peer_id atm */
+                multi->tx_peer_id =3D multi->rx_peer_id;
=
+            }
+        }
+    }
+    else
+    {
+        free(multi->peer=
_info);
+        multi->peer_info =3D read_string_alloc(buf);
+    }
+    i=
f (session->opt->mode =3D=3D MODE_POINT_TO_POINT && !session->opt->dco_enab=
led)
+    {
+        uint32_t peer_id =3D extract_asymmetric_peer_id(multi-=
>peer_info);
+        if (peer_id !=3D MAX_PEER_ID)
+        {
+           =
 multi->tx_peer_id =3D peer_id;
+            multi->use_asymmetric_peer_id =
=3D true;
+            multi->use_peer_id =3D true;
+        }
     }
 
   =
  free(multi->remote_ciphername);
@@ -4005,8 +4090,8 @@
     msg(D_TLS_DEBU=
G, __func__);
 
     ASSERT(ks);
-
-    peer =3D htonl(((P_DATA_V2 << P_OPC=
ODE_SHIFT) | ks->key_id) << 24 | (multi->peer_id & 0xFFFFFF));
+    peer =
=3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24
+             =
    | (multi->tx_peer_id & 0xFFFFFF));
     ASSERT(buf_write_prepend(buf, &=
peer, 4));
 }
 
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_c=
ommon=2Eh
index 6f310a5=2E=2E9a36fcf 100644
--- a/src/openvpn/ssl_common=2E=
h
+++ b/src/openvpn/ssl_common=2Eh
@@ -697,8 +697,10 @@
 #define AUTH_TOKEN=
_VALID_EMPTYUSER (1 << 2)
 
     /* For P_DATA_V2 */
-    uint32_t peer_id;=

+    uint32_t rx_peer_id;
+    uint32_t tx_peer_id;
     bool use_peer_id;=

+    bool use_asymmetric_peer_id;
 
     char *remote_ciphername; /**< cip=
her specified in peer's config file */
     bool remote_usescomp;    /**< r=
emote announced comp-lzo in OCC string */
diff --git a/src/openvpn/ssl_ncp=
=2Ec b/src/openvpn/ssl_ncp=2Ec
index 649665a=2E=2Ee860f6d 100644
--- a/src/=
openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -406,6 +406,7 @@
 {
  =
   /* will return 0 if peer_info is null */
     const unsigned int iv_prot=
o_peer =3D extract_iv_proto(multi->peer_info);
+    const unsigned int tx_p=
eer_id =3D extract_asymmetric_peer_id(multi->peer_info);
 
     /* The othe=
r peer does not support P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_=
P2P))
@@ -416,7 +417,11 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     =
{
         multi->use_peer_id =3D true;
-        multi->peer_id =3D 0x76706=
e; /* 'v' 'p' 'n' */
+        if (tx_peer_id =3D=3D MAX_PEER_ID)
+        {=

+            multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+          =
  multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        }
     }
 
   =
  if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -440,8 +445,16 @@
     {
=
         session->opt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
 
=
-        if (multi->use_peer_id)
+        /* The asymmetric peer-id trumps =
on the EKM generated ones */
+        if ((tx_peer_id !=3D MAX_PEER_ID) && =
(!multi->opt=2Edco_enabled))
         {
+            multi->tx_peer_id =3D =
tx_peer_id;
+            multi->use_asymmetric_peer_id =3D true;
+        }=

+        else
+        {
+            multi->rx_peer_id =3D 0x76706e; /* '=
v' 'p' 'n' */
+            multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' *=
/
             /* Using a non hardcoded peer-id makes a tiny bit harder to
=
              * fingerprint packets and also gives each connection a unique=

              * peer-id that can be useful for NAT tracking etc=2E */
@@ -=
458,7 +471,8 @@
             }
             else
             {
-          =
      multi->peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
=
+                multi->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8)=
 + peerid[2];
+                multi->tx_peer_id =3D multi->rx_peer_id;
   =
          }
         }
     }
@@ -500,11 +514,13 @@
         common_cipher =
=3D BSTR(&out);
     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP n=
egotiation result: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, e=
poch=3D%d, cipher=3D%s",
-        (bool)(session->opt->crypto_flags & CO_US=
E_TLS_KEY_MATERIAL_EXPORT), multi->use_peer_id,
-        multi->peer_id, (b=
ool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D_TLS=
_DEBUG_LOW, "P2P mode NCP negotiation result: "
+                         "=
TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, ci=
pher=3D%s",
+        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MAT=
ERIAL_EXPORT),
+        multi->use_peer_id,
+        multi->rx_peer_id,
+  =
      multi->tx_peer_id,
+        (bool)(session->opt->crypto_flags & CO_EP=
OCH_DATA_KEY_FORMAT),
         common_cipher);
 
     gc_free(&gc);
diff --=
git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 71fbc9e=2E=
=2E6561c48 100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=
=2Ec
@@ -24,7 +24,7 @@
 #endif
 
 #include "syshead=2Eh"
-
+#include "openv=
pn=2Eh"
 #include "ssl_util=2Eh"
 
 char *
@@ -72,6 +72,24 @@
     return 0=
;
 }
 
+uint32_t
+extract_asymmetric_peer_id(const char *peer_info)
+{
+   =
 const char *optstr =3D peer_info ? strstr(peer_info, "ID=3D") : NULL;
+   =
 if (optstr)
+    {
+        uint32_t peer_id =3D 0;
+        int r =3D ssc=
anf(optstr, "ID=3D%x", &peer_id);
+        {
+            if (r =3D=3D 1 &&=
 peer_id < MAX_PEER_ID)
+            {
+                return peer_id;
+  =
          }
+        }
+    }
+    return MAX_PEER_ID;
+}
+
 const char *
 =
options_string_compat_lzo(const char *options, struct gc_arena *gc)
 {
diff=
 --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 2177d94=
=2E=2E1a69e6f 100644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_u=
til=2Eh
@@ -53,6 +53,15 @@
  */
 unsigned int extract_iv_proto(const char *=
peer_info);
 
+
+/**
+ * Extracts the ID variable and returns its value or
=
+ * MAX_PEER_ID if it cannot be extracted=2E
+ *
+ * @param peer_info     p=
eer info string to search for ID
+ */
+uint32_t extract_asymmetric_peer_id(=
const char *peer_info);
+
 /**
  * Takes a locally produced OCC string for =
TLS server mode and modifies as
  * if the option comp-lzo was enabled=2E T=
his is to send a client in

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1=
089
Gerrit-PatchSet: 11
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>=

Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: flichtenheld <f=
rank@lichtenheld=2Ecom>

--kBxnyei8dXU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos=2E </p>
<p>its_Gia=
an <strong>uploaded patch set #11</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">multipeer: introduce asymmetric peer-id<=
br><br>In order to achieve a multipeer functionality, peers now<br>use sepa=
rate IDs for sending (tx_peer_id) and receiving<br>(rx_peer_id)=2E<br><br>E=
ach peer announces its own ID through pushing peer-info<br>using &#39;ID=3D=
7f1&#39; hex format so identification can still<br>happen even if IP/port c=
hanges=2E<br><br>In P2P mode, peer switch to using the announced IDs after<=
br>mutual exchange=2E<br>In P2MP mode, clients always announce their ID, an=
d servers<br>can optionally respond with their own to enable the same<br>be=
havior=2E<br><br>Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9<br>Si=
gned-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<=
br>M src/openvpn/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/misc=2E=
c<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/=
push=2Ec<br>M src/openvpn/push_util=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/o=
penvpn/ssl_common=2Eh<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_uti=
l=2Ec<br>M src/openvpn/ssl_util=2Eh<br>12 files changed, 189 insertions(+),=
 47 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/89/1089/11</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index f5b7081=2E=2E901b9bd=
 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src=
/openvpn/dco=2Ec</span><br><span>@@ -528,14 +528,15 @@</span><br><span>    =
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
span>     return 0;</span><br><span> }</span><br><span>@@ -610,7 +611,7 @@<=
/span><br><span> {</span><br><span>     struct context *c =3D &amp;mi-&gt;c=
ontext;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;peer_id;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int peer_id =3D c-&gt;c2=2Etls_mu=
lti-&gt;rx_peer_id;</span><br><span>     struct sockaddr *remoteaddr, *loca=
laddr =3D NULL;</span><br><span>     struct sockaddr_storage local =3D { 0 =
};</span><br><span>     const socket_descriptor_t sd =3D c-&gt;c2=2Elink_so=
ckets[0]-&gt;sd;</span><br><span>@@ -689,8 +690,7 @@</span><br><span>     i=
f (addrtype =3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span> #i=
f defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    dco_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Ea=
ddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                c-&gt;c2=2Etls_multi-&gt;peer_id);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_=
ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits, =
c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #else</span><br><spa=
n>         const struct in6_addr *gateway =3D &amp;mi-&gt;context=2Ec2=2Epu=
sh_ifconfig_ipv6_local;</span><br><span>         if (addr-&gt;type &amp; MR=
_ONLINK_DCO_ADDR)</span><br><span>@@ -706,8 +706,7 @@</span><br><span>     =
else if (addrtype =3D=3D MR_ADDR_IPV4)</span><br><span>     {</span><br><sp=
an> #if defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;=
v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                c-&gt;c2=2Etls_multi-&gt;peer_id);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_i=
route_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, addr-&gt;net=
bits, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #else</span><b=
r><span>         in_addr_t dest =3D htonl(addr-&gt;v4=2Eaddr);</span><br><s=
pan>         const in_addr_t *gateway =3D &amp;mi-&gt;context=2Ec2=2Epush_i=
fconfig_local;</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/open=
vpn/init=2Ec</span><br><span>index caaa769=2E=2E468c260 100644</span><br><s=
pan>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</=
span><br><span>@@ -2209,7 +2209,7 @@</span><br><span> </span><br><span>    =
 if (o-&gt;use_peer_id)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;, peer-id: %d&q=
uot;, o-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        buf_printf(&amp;out, &quot;, rx-peer-id: %u, tx-peer-id: %u&quot;=
, c-&gt;c2=2Etls_multi-&gt;rx_peer_id, c-&gt;c2=2Etls_multi-&gt;tx_peer_id)=
;</span><br><span>     }</span><br><span> </span><br><span> #ifdef USE_COMP=
</span><br><span>@@ -2688,7 +2688,12 @@</span><br><span>     {</span><br><s=
pan>         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-id set&quot;);</s=
pan><br><span>         c-&gt;c2=2Etls_multi-&gt;use_peer_id =3D true;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Etls_mult=
i-&gt;peer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        c-&gt;c2=2Etls_multi-&gt;tx_peer_id =3D c-&g=
t;options=2Epeer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!c-&gt;c2=2Etls_multi-&gt;use_asymmetric_peer_id)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_multi-&gt;rx_p=
eer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            c-&gt;c2=2Etls_multi-&gt;tx_peer_id =3D c-&gt;o=
ptions=2Epeer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span>     }</span><br><span> </span><br><span>     /* pr=
ocess (potentially) pushed options */</span><br><span>@@ -3485,6 +3490,10 @=
@</span><br><span>     if (c-&gt;c2=2Etls_multi)</span><br><span>     {</sp=
an><br><span>         tls_multi_init_finalize(c-&gt;c2=2Etls_multi, c-&gt;o=
ptions=2Ece=2Etls_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (c-&gt;c2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=2Euse_pee=
r_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>         ASSERT(c-&gt;c2=2Etls_multi-&gt;opt=2Eframe=
=2Ebuf=2Epayload_size &lt;=3D c-&gt;c2=2Eframe=2Ebuf=2Epayload_size);</span=
><br><span>         frame_print(&amp;c-&gt;c2=2Etls_multi-&gt;opt=2Eframe, =
D_MTU_INFO, &quot;Control Channel MTU parms&quot;);</span><br><span> </span=
><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><=
br><span>index 10bfc35=2E=2Ea8c88c9 100644</span><br><span>--- a/src/openvp=
n/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -7=
65,14 +765,15 @@</span><br><span>     {</span><br><span>         chomp(line=
);</span><br><span>         if (validate_peer_info_line(line)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (strncmp(lin=
e, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D=
 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &am=
p;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line, &quot;=
UV_&quot;, 3) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                || strncmp(line, &quot;ID&quot;, 2) =3D=3D 0))</span><br=
><span>         {</span><br><span>             msg(M_INFO, &quot;peer info:=
 %s&quot;, line);</span><br><span>             env_set_add(es, line);</span=
><br><span>         }</span><br><span>         else</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_=
WARN, &quot;validation failed on peer_info line received from client&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
WARN, &quot;validation failed on peer_info line received&quot;);</span><br>=
<span>         }</span><br><span>     }</span><br><span> }</span><br><span>=
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>=
index a957fdf=2E=2Ee96d43c 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -430,7 =
+430,7 @@</span><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi &amp=
;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span>             &amp;&am=
p; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(=
&amp;out, &quot; peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;pe=
er_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
buf_printf(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etl=
s_multi-&gt;rx_peer_id);</span><br><span>         }</span><br><span>       =
  return BSTR(&amp;out);</span><br><span>     }</span><br><span>@@ -598,9 +=
598,9 @@</span><br><span>         }</span><br><span> #endif</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;=
context=2Ec2=2Etls_multi-&gt;peer_id !=3D MAX_PEER_ID)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;context=2Ec2=2Etls_mu=
lti-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            m-&gt;instances[mi-&g=
t;context=2Ec2=2Etls_multi-&gt;peer_id] =3D NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            m-&gt;instances[mi-&gt;context=2E=
c2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br><span> </span><br><span>=
             /* Adjust the max_peerid as this might have been the highest</=
span><br><span>              * peer id instance */</span><br><span>@@ -908,=
8 +908,7 @@</span><br><span> #else</span><br><span>                        =
 sep,</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        sep,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                        mi-&gt;context=2Ec2=2Etls_multi ? mi=
-&gt;context=2Ec2=2Etls_multi-&gt;peer_id : UINT32_MAX,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        sep, mi-&gt;con=
text=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id : MA=
X_PEER_ID,</span><br><span>                         sep, translate_cipher_n=
ame_to_openvpn(mi-&gt;context=2Eoptions=2Eciphername));</span><br><span>   =
              }</span><br><span>                 gc_free(&amp;gc);</span><b=
r><span>@@ -1727,6 +1726,7 @@</span><br><span>         tls_multi-&gt;use_pe=
er_id =3D true;</span><br><span>         o-&gt;use_peer_id =3D true;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     else if (dco_enabled(o))</span><br><span>     {</span><b=
r><span>         msg(M_INFO, &quot;Client does not support DATA_V2=2E Data =
channel offloading &quot;</span><br><span>@@ -3121,12 +3121,12 @@</span><br=
><span>          * has, so we disallow it=2E This can happen if a DCO netli=
nk notification</span><br><span>          * gets lost and we miss a floatin=
g step=2E</span><br><span>          */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (m1-&gt;peer_id =3D=3D m2-&gt;peer_id)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (m1-&gt;rx_peer_i=
d =3D=3D m2-&gt;rx_peer_id)</span><br><span>         {</span><br><span>    =
         msg(M_WARN,</span><br><span>                 &quot;disallowing pee=
r %&quot; PRIu32 &quot; (%s) from floating to &quot;</span><br><span>      =
           &quot;its own address (%s)&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                m1-&gt;peer_id, tls_common_name(mi-&=
gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                m1-&gt;rx_peer_id, tls_common_name(mi-&gt;=
context=2Ec2=2Etls_multi, false),</span><br><span>                 mroute_a=
ddr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span>             goto do=
ne;</span><br><span>         }</span><br><span>@@ -3139,9 +3139,10 @@</span=
><br><span>     }</span><br><span> </span><br><span>     msg(D_MULTI_MEDIUM=
, &quot;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Ec2=
=2Etls_multi-&gt;peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, =
false),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mroute=
_addr_print_ex(&amp;mi-&gt;real, MAPF_SHOW_FAMILY, &amp;gc),</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        mroute_addr_print_ex(&amp;re=
al, MAPF_SHOW_FAMILY, &amp;gc));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_common_name(mi=
-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        mroute_addr_print(&amp;mi-&gt;real, &amp;gc),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_link_soc=
ket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc));</span><br><span> </span><=
br><span>     /* remove old address from hash table before changing address=
 */</span><br><span>     ASSERT(hash_remove(m-&gt;hash, &amp;mi-&gt;real));=
</span><br><span>@@ -4086,7 +4087,7 @@</span><br><span>     {</span><br><sp=
an>         if (!m-&gt;instances[i])</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec2=
=2Etls_multi-&gt;peer_id =3D i;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id =3D =
i;</span><br><span>             m-&gt;instances[i] =3D mi;</span><br><span>=
             break;</span><br><span>         }</span><br><span>@@ -4095,11 =
+4096,11 @@</span><br><span>     /* should not really end up here, since mu=
lti_create_instance returns null</span><br><span>      * if amount of clien=
ts exceeds max_clients and this method would then</span><br><span>      * a=
lso not have been called */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id &lt; m-&gt;max=
_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSER=
T(mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id &lt; m-&gt;max_clients);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id &gt; m-&gt;max_peerid)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2E=
c2=2Etls_multi-&gt;rx_peer_id &gt; m-&gt;max_peerid)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;max_pee=
rid =3D mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        m-&gt;max_peerid =3D mi-&gt;conte=
xt=2Ec2=2Etls_multi-&gt;rx_peer_id;</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span>diff --git a/src/openvpn/options=2Ec b=
/src/openvpn/options=2Ec</span><br><span>index 0c2866c=2E=2Eed5897d 100644<=
/span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/ope=
nvpn/options=2Ec</span><br><span>@@ -3871,6 +3871,7 @@</span><br><span>    =
                  &quot;incompatible with each other=2E&quot;);</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     if (dco_enabled(o))</span><br><span>     {<=
/span><br><span>         /* check if any option should force disabling DCO =
*/</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec=
</span><br><span>index 564ce86=2E=2Eddd1b7e 100644</span><br><span>--- a/sr=
c/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><sp=
an>@@ -661,9 +661,10 @@</span><br><span>                         print_in_a=
ddr_t(c-&gt;c2=2Epush_ifconfig_remote_netmask, 0, gc));</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (tls_multi-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!tls_multi-&gt;use_asymmetric_peer_id)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        push=
_option_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;p=
eer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pus=
h_option_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        tls_multi-=
&gt;rx_peer_id);</span><br><span>     }</span><br><span>     /*</span><br><=
span>      * If server uses --auth-gen-token and we have an auth token</spa=
n><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=
=2Ec</span><br><span>index f57f54d=2E=2Ec927f26 100644</span><br><span>--- =
a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec=
</span><br><span>@@ -188,7 +188,7 @@</span><br><span>         unsigned int =
permission_mask =3D pull_permission_mask(c);</span><br><span>         if (p=
rocess_push_update(c, &amp;o, permission_mask, &amp;option_types_found, &am=
p;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;=
Failed to process push update message sent to client ID: %u&quot;, c-&gt;c2=
=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_WARN, &quot;Failed to process push update message =
sent to client ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><b=
r><span>         }</span><br><span>         e =3D e-&gt;next;</span><br><sp=
an>     }</span><br><span>@@ -294,7 +294,7 @@</span><br><span> </span><br><=
span>         if (!support_push_update(mi))</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, =
&quot;PUSH_UPDATE: not sending message to unsupported peer with ID: %u&quot=
;, mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;PUSH_UPDATE: n=
ot sending message to unsupported peer with ID: %u&quot;, mi-&gt;context=2E=
c2=2Etls_multi-&gt;rx_peer_id);</span><br><span>             buffer_list_fr=
ee(msgs);</span><br><span>             gc_free(&amp;gc);</span><br><span>  =
           return 0;</span><br><span>@@ -329,7 +329,7 @@</span><br><span>  =
       /* Type is UPT_BROADCAST so we update every client */</span><br><spa=
n>         if (!send_single_push_update(m, curr_mi, msgs))</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(M_CLIENT, &quot;ERROR: Peer ID: %u has not been updated&quot;, curr_mi=
-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERROR: Peer ID: %u =
has not been updated&quot;, curr_mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_pee=
r_id);</span><br><span>             continue;</span><br><span>         }</s=
pan><br><span>         count++;</span><br><span>diff --git a/src/openvpn/ss=
l=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index d332359c=2E=2Efdb4f2a 100=
644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl=2Ec</span><br><span>@@ -1168,7 +1168,10 @@</span><br><span>     /*=
 get command line derived options */</span><br><span>     ret-&gt;opt =3D *=
tls_options;</span><br><span>     ret-&gt;dco_peer_id =3D -1;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ret-&gt;peer_id =3D MAX_PEER_ID=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;use_as=
ymmetric_peer_id =3D false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* The rx_peer_id is also used to identify DCO clients */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;rx_peer_id =
=3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ret-&gt;tx_peer_id =3D MAX_PEER_ID;</span><br><span> </span><br><span>    =
 return ret;</span><br><span> }</span><br><span>@@ -1181,6 +1184,22 @@</spa=
n><br><span> </span><br><span>     tls_session_init(multi, &amp;multi-&gt;s=
ession[TM_ACTIVE]);</span><br><span>     tls_session_init(multi, &amp;multi=
-&gt;session[TM_INITIAL]);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mul=
ti-&gt;opt=2Edco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* Calculate the asymmetric peer-id */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp=
;&amp; multi-&gt;session[TM_INITIAL]=2Eopt-&gt;mode !=3D MODE_SERVER)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            uint8_t peerid[3];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            srand((unsig=
ned)time(NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         for (int i =3D 0; i &lt; 3; i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                peerid[i] =3D (uint8_t)rand();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; =
16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> /*<=
/span><br><span>@@ -1858,6 +1877,25 @@</span><br><span>     return str;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+push_peer_info_peerid(struct buffer *out, struct tls_multi *multi, st=
ruct tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mul=
ti-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_enabled)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* No valid peer id or DCO i=
s enabled=2E Cannot use this feature */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In se=
rver mode we only add this when the client has announced its</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * support for the feature */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;=
opt-&gt;mode !=3D MODE_SERVER || multi-&gt;use_asymmetric_peer_id)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return buf_printf(out, &quot;ID=
=3D%x\n&quot;, multi-&gt;rx_peer_id);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><spa=
n>  * Prepares the IV_ and UV_ variables that are part of the</span><br><sp=
an>  * exchange to signal the peer&#39;s capabilities=2E The amount</span><=
br><span>@@ -1871,15 +1909,22 @@</span><br><span>  *</span><br><span>  * @p=
aram buf       the buffer to write these variables to</span><br><span>  * @=
param session   the TLS session object</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param multi     the TLS multi object</span><br><span=
>  * @return          true if no error was encountered</span><br><span>  */=
</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-push_peer_info(struct buffer *buf, struct tls_session *session)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+push_peer_info(struct b=
uffer *buf, struct tls_multi *multi, struct tls_session *session)</span><br=
><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><=
span>     bool ret =3D false;</span><br><span>     struct buffer out =3D al=
loc_buf_gc(512 * 3, &amp;gc);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* The asymmetric peer-id is always written=
 when enabled */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!push_peer_info_peerid(&amp;out, multi, session))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto error;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     if (session-&gt;opt-&gt;push_peer_info_detail =
&gt; 1)</span><br><span>     {</span><br><span>         /* push version */<=
/span><br><span>@@ -2027,7 +2072,9 @@</span><br><span>     }</span><br><spa=
n>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (!write_empty_string(buf)) /* no peer info */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(session-&gt=
;opt-&gt;mode =3D=3D MODE_SERVER &amp;&amp; multi-&gt;use_asymmetric_peer_i=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
? write_string(buf, BSTR(&amp;out), -1)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                  : write_empty_string(buf)))</span><br=
><span>         {</span><br><span>             goto error;</span><br><span>=
         }</span><br><span>@@ -2156,7 +2203,7 @@</span><br><span>         }=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (!push_peer_info(buf, session))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_info(buf, multi, =
session))</span><br><span>     {</span><br><span>         goto error;</span=
><br><span>     }</span><br><span>@@ -2269,6 +2316,44 @@</span><br><span>  =
   if (multi-&gt;peer_info)</span><br><span>     {</span><br><span>        =
 output_peer_info_env(session-&gt;opt-&gt;es, multi-&gt;peer_info);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt;opt=
-&gt;mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (!session-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                uint32_t peer_id =3D extract_asymme=
tric_peer_id(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                if (peer_id !=3D MAX_PEER_ID)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    multi-&gt;tx_pee=
r_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  multi-&gt;use_asymmetric_peer_id =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    multi-&gt;use_=
peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               /* Client has no asymmetric peer-id capability */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    multi-&gt;=
tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                /* With DCO we don&#39;t need the tx_peer_id atm */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;t=
x_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        free(multi-&gt;peer_info);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;peer_i=
nfo =3D read_string_alloc(buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (session-&gt;opt-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !sessi=
on-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  uint32_t peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (peer_id !=
=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
ulti-&gt;tx_peer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            multi-&gt;use_asymmetric_peer_id =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;use_p=
eer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span>     }</span><br><span> </span><br><span>     free(m=
ulti-&gt;remote_ciphername);</span><br><span>@@ -4005,8 +4090,8 @@</span><b=
r><span>     msg(D_TLS_DEBUG, __func__);</span><br><span> </span><br><span>=
     ASSERT(ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    peer =3D htonl(((P_DAT=
A_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24 | (multi-&gt;pee=
r_id &amp; 0xFFFFFF));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id)=
 &lt;&lt; 24</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
          | (multi-&gt;tx_peer_id &amp; 0xFFFFFF));</span><br><span>     AS=
SERT(buf_write_prepend(buf, &amp;peer, 4));</span><br><span> }</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn=
/ssl_common=2Eh</span><br><span>index 6f310a5=2E=2E9a36fcf 100644</span><br=
><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/s=
sl_common=2Eh</span><br><span>@@ -697,8 +697,10 @@</span><br><span> #define=
 AUTH_TOKEN_VALID_EMPTYUSER (1 &lt;&lt; 2)</span><br><span> </span><br><spa=
n>     /* For P_DATA_V2 */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    uint32_t peer_id;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint32_t rx_peer_id;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint32_t tx_peer_id;</span><br><span>     bool use_peer_id;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool use_asymme=
tric_peer_id;</span><br><span> </span><br><span>     char *remote_ciphernam=
e; /**&lt; cipher specified in peer&#39;s config file */</span><br><span>  =
   bool remote_usescomp;    /**&lt; remote announced comp-lzo in OCC string=
 */</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_=
ncp=2Ec</span><br><span>index 649665a=2E=2Ee860f6d 100644</span><br><span>-=
-- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec<=
/span><br><span>@@ -406,6 +406,7 @@</span><br><span> {</span><br><span>    =
 /* will return 0 if peer_info is null */</span><br><span>     const unsign=
ed int iv_proto_peer =3D extract_iv_proto(multi-&gt;peer_info);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int tx_peer_=
id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</span><br><span> </=
span><br><span>     /* The other peer does not support P2P NCP */</span><br=
><span>     if (!(iv_proto_peer &amp; IV_PROTO_NCP_P2P))</span><br><span>@@=
 -416,7 +417,11 @@</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_DA=
TA_V2)</span><br><span>     {</span><br><span>         multi-&gt;use_peer_i=
d =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mu=
lti-&gt;peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tx_peer_id =
=3D=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39;=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mult=
i-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan>     }</span><br><span> </span><br><span>     if (iv_proto_peer &amp; I=
V_PROTO_CC_EXIT_NOTIFY)</span><br><span>@@ -440,8 +445,16 @@</span><br><spa=
n>     {</span><br><span>         session-&gt;opt-&gt;crypto_flags |=3D CO_=
USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (multi-&gt;use_peer_id)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* The asymmetric peer-id t=
rumps on the EKM generated ones */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if ((tx_peer_id !=3D MAX_PEER_ID) &amp;&amp; (!multi=
-&gt;opt=2Edco_enabled))</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D tx_p=
eer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
multi-&gt;use_asymmetric_peer_id =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;=
n&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39;=
 */</span><br><span>             /* Using a non hardcoded peer-id makes a t=
iny bit harder to</span><br><span>              * fingerprint packets and a=
lso gives each connection a unique</span><br><span>              * peer-id =
that can be useful for NAT tracking etc=2E */</span><br><span>@@ -458,7 +47=
1,8 @@</span><br><span>             }</span><br><span>             else</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                multi-&gt;peer_id =3D (peerid[0] &lt;&lt; 16) + (peer=
id[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 16)=
 + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                multi-&gt;tx_peer_id =3D multi-&gt;rx_pe=
er_id;</span><br><span>             }</span><br><span>         }</span><br>=
<span>     }</span><br><span>@@ -500,11 +514,13 @@</span><br><span>        =
 common_cipher =3D BSTR(&amp;out);</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_TLS_DEBUG_L=
OW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;P2P =
mode NCP negotiation result: &quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        &quot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoc=
h=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_M=
ATERIAL_EXPORT), multi-&gt;use_peer_id,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        multi-&gt;peer_id, (bool)(session-&gt;opt-&gt;cry=
pto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiat=
ion result: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                        &quot;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d,=
 tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto_flags =
&amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        multi-&gt;use_peer_id,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        multi-&gt;rx_peer_id,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;tx_peer_id,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        (bool)(session-&g=
t;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span>   =
      common_cipher);</span><br><span> </span><br><span>     gc_free(&amp;g=
c);</span><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl=
_util=2Ec</span><br><span>index 71fbc9e=2E=2E6561c48 100644</span><br><span=
>--- a/src/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=
=2Ec</span><br><span>@@ -24,7 +24,7 @@</span><br><span> #endif</span><br><s=
pan> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span> #include &=
quot;ssl_util=2Eh&quot;</span><br><span> </span><br><span> char *</span><br=
><span>@@ -72,6 +72,24 @@</span><br><span>     return 0;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
int32_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_asym=
metric_peer_id(const char *peer_info)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *optstr =3D peer_info ? strstr(peer_info, &quot;ID=3D&quot;)=
 : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt=
str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uint32_t peer_id =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int r =3D=
 sscanf(optstr, &quot;ID=3D%x&quot;, &amp;peer_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (r =3D=3D 1 &amp;&amp; peer_id &lt; =
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
none"> Gerrit-PatchSet: 11 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_=
Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</b=
ody></html>
--kBxnyei8dXU=--


--===============7599005063714334722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7599005063714334722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7599005063714334722==--

