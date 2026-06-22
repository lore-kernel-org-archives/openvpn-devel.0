Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364E2CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LKSgeZMqVsCur0rLFwC/RK9YoGeIY+GDkng+oMTKPZ0=; b=UljczGsh7ZwtRK
	7AFaeGmGm0yeHKs0WmtvSBZZGDutuYLeZOABIpSNmB6Gg7+YU/ZCubjseSpg7HowSBaoqB+EGpANq
	6/cSCjLH7yjZoUVCVFU33jbaZLp4am46Ka6r/labNilS6nFr1pp3E34thAp3a+Jcq8PCPx723Hseu
	6UA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbed0-0001Xi-9H;
	Mon, 22 Jun 2026 13:23:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecy-0001XR-Qn
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/S7kE/fGADbGAYt8NA5vvEuaU28Xo0W+OYNeSuEu9vc=; b=XTUnXcRV7Vcyi/FIbYH4vCZUZQ
 zCJVtusRUHZ2vhysJipmvO6TOrbMKE+sYdELIY2MBrQj48r6lT+YqedoImCwH+XKMIBxqmLZINDiG
 UcRL0svvtVOllMIr/3z/3oFiTWNXPlETCzQ8LWNwgnx+aQ7n9k2g7oJJLLO6VwHrqbUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/S7kE/fGADbGAYt8NA5vvEuaU28Xo0W+OYNeSuEu9vc=; b=I
 eBTg4wUDOnismml707RzIsaumkpPjlyaMjvbRAhI8Uet3FjmsgZrCFf63NtoVS2iHo81NTVbxnjjs
 O70bAKSmSx2iqx9Cha4y5f+Q71C6SPpZ68mAAloiWseg3H1IT56q+4P+hJdv1fC+ucMIqYSrB2LcK
 Z5cnqH98me9tM/CI=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecu-0000an-72 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:50 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49258ac7294so2778035e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134622; x=1782739422; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/S7kE/fGADbGAYt8NA5vvEuaU28Xo0W+OYNeSuEu9vc=;
 b=Vh5G1dyzbBw2jN6scdeUPGGIos9mDaFlClyv5XF/m3j0SSgp9MQjQn4Xy0aaHP/jNJ
 Afxiahmyn8n6nvR7cJaHcpl2tqjH3TFrFcZzg51MRLYo9yqbnZ+72xsyaE1di0cFzaHd
 M9H9NaBOhsYnMUVe3TuETtmU9dVxHQ0uwjVSWyBlL17BUJT0ZdibZSNc2MKvrtsnbwXI
 LCmCz1h2qDCuMbBewKWIL6hAq2eYkMFWBFfAFvSowcnrNaJ2f00KEALsimSkMXqVmmN5
 MjF3OdeqCf60UiMUeflDHYOIHNFkyeW4dlJpx/A9rPV9geFXTsF5bXtl901giM5JhKDf
 y2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134622; x=1782739422;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/S7kE/fGADbGAYt8NA5vvEuaU28Xo0W+OYNeSuEu9vc=;
 b=UzaXyIJPJ/guNIrDa6QRBzVSVlnAQASnTKZ9TRZgznteYFm3PkI1S+PP5r06yc99tI
 QoD9YatrG7YGtYvwHRwwF9K7B0lN79lHsE21ioiQHHYQo3rhQdg98ph1MV0Fh05qSydz
 efw/rJ07l4HcFXAuAbLrT0OunUClQt3m6hodm0OEQRY8Fo3X/MMIIIbLwf3znbJ+1d4H
 03ztFBuZpKPj/4fb9lmNn8LLXQCG5iLDlpPO2f9JOBKeidOpRJuBzn5GMB0jW+Zuk9gz
 n9hYI/Wtu6AX/cKUfPlih1eQtAOA5xT8rOe7Nb3Nl8gNqtjU/8q36LTGUq2VvFigKsax
 va5w==
X-Gm-Message-State: AOJu0YziCJrmT+02dGv4pLgGdncnfUoCy8ze/4AKlHEcSoMgauvdqsPv
 qCyEWuJFLfaLCFfMGDIDWWq5kmlaO+FxQCweF1Vi/7zTJjHbxe3di2bBhJwi3YQqT/mvvEXqvu5
 9RRVvf2gMIm8kvwiHhZ17t/rN6qkMmaMSYsY45vn/zc6R5XQj8Oa1fvHpydl2QXkoggKhBhYJFN
 THvdsjxg==
X-Gm-Gg: AfdE7cl6PyttsD2PFrq8IN2p3y/TsO0lrXf0yXm9eZTwWkUfF3g5Ppry4JZdzg7t5r6
 FMqbt4xS7heYD4ba+PGFxQMxyqZXabtGPiLAT9Qc3xi9x5TuRutlWsvEpWpQuhk9e7XrcxanFVc
 Q+75E/0OUviWYjTH2y2coAgsbWl0S2ZHTi8b8LBT1kGpcgpzhOjt/EFD4U7nGMvvOl93UDPLQJl
 dqTgbMcQKAhxEVo+N2b4VeqSCPGHoDRLoPCZOndm+t4y26aEq048J6JqGDg6sQiwFCmsJWHgsip
 V5G8/GfHvwiEmdTmKPfShM9K+mDhUSWpt2t/Hy3/c6QCCrztTt7alWHCzu2FSgXj1su5tcRU75K
 Fud9Dq+Geg4CJWvIjXXPZIJKA9KmMA6KACp5C/bJAzvhqQtBe3QrpBf8SdcWiRJqhwsx6/VSPZ2
 MUfQe9S4rfsdNrMXrlMZp0YfqSkWjxg0g59Xxcw1HMqz0vFf7wjwC3SWkDYzLSRp2cEhYHUoTSG
 s+679DS4UlE3L6KgQ1VZuoE5uV8UfBrOab2poNQPOn+MjZWQc7bCaSrw/F2PMgAKV3wCyGg7937
 UC9JBVTBaJzg2w==
X-Received: by 2002:a7b:ca51:0:b0:490:be41:87c6 with SMTP id
 5b1f17b1804b1-49240e3778bmr182662335e9.10.1782134620862; 
 Mon, 22 Jun 2026 06:23:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492492338e5sm236727305e9.3.2026.06.22.06.23.40
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:40 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: c6be58f905f2caf0c4f8049671b0cf1aad287c28
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ebd9c1441dff4ab9227b817ad3f61a2055112657-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecu-0000an-72
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Split
 multi_get_create_instance_udp into data and control parts
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4239274015333879756=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4239274015333879756==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ixUqJzbR7sU="; charset=UTF-8

--ixUqJzbR7sU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1726?usp=3Demail )


Change subject: Split multi_get_cre=
ate_instance_udp into data and control parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Split multi_get_create_instance_udp into da=
ta and control parts

This currently leads to a bit of code duplication but=
 this refactoring
will make the follow up patches cleaner and better to und=
erstand when
the control channel lookup will be changed to use session ids =
instead of
IP addresses=2E

Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b=
5cfc3
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/mu=
dp=2Ec
1 file changed, 88 insertions(+), 52 deletions(-)



  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/1726/1

diff --git a=
/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index e8d8128=2E=2Eaa7defe 100=
644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -197,8 +197,7 =
@@
 struct multi_instance *
 handle_connection_attempt(struct multi_context=
 *m,
                           struct link_socket *sock,
-                =
          struct mroute_addr *real,
-                          struct hash_=
bucket *bucket)
+                          struct mroute_addr *real)
 {
   =
  struct hash *hash =3D m->hash;
     struct tls_pre_decrypt_state state =
=3D { 0 };
@@ -229,7 +228,9 @@
             if (mi)
             {
        =
         const uint64_t hv =3D hash_value(hash, real);
+                str=
uct hash_bucket *bucket =3D hash_bucket(hash, hv);
                 hash_ad=
d_fast(hash, bucket, &mi->real, hv, mi);
+
                 mi->did_real_ha=
sh =3D true;
                 multi_assign_peer_id(m, mi);
 
@@ -278,6 +279=
,19 @@
     return NULL;
 }
 
+struct multi_instance *
+multi_get_instance_=
udp_control(struct multi_context *m, struct link_socket *sock)
+{
+    stru=
ct mroute_addr real =3D { 0 };
+    real=2Eproto =3D sock->info=2Eproto;
+
=
+    if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest,=
 true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+    {
+        return multi_get_ins=
tance_real_udp_real(m, &real);
+    }
+
+    return NULL;
+}
 
 /**
  * Get=
 a client instance based on real address=2E  If
@@ -285,72 +299,94 @@
  * m=
aintaining real address hash table atomicity=2E
  */
 struct multi_instance=
 *
-multi_get_create_instance_udp(struct multi_context *m, bool *floated, s=
truct link_socket *sock)
+multi_get_instance_udp_data(struct multi_context =
*m, bool *floated, struct mroute_addr *real, struct link_socket *sock)
 {
-=
    struct gc_arena gc =3D gc_new();
-    struct mroute_addr real =3D { 0 }=
;
     struct multi_instance *mi =3D NULL;
-    struct hash *hash =3D m->ha=
sh;
-    real=2Eproto =3D sock->info=2Eproto;
 
-    if (mroute_extract_ope=
nvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=
=2Elen > 0)
+    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    uint8_t op=
 =3D ptr[0] >> P_OPCODE_SHIFT;
+    bool v2 =3D (op =3D=3D P_DATA_V2) && (m=
->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
+    bool peer_id_disabled =3D false;=

+
+    /* make sure buffer has enough length to read opcode (1 byte) and p=
eer-id (3 bytes) */
+    if (v2)
     {
-        const uint64_t hv =3D hash=
_value(hash, &real);
-        struct hash_bucket *bucket =3D hash_bucket(ha=
sh, hv);
-        uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
-        uint8=
_t op =3D ptr[0] >> P_OPCODE_SHIFT;
-        bool v2 =3D (op =3D=3D P_DATA_=
V2) && (m->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
-        bool peer_id_disabl=
ed =3D false;
+        uint32_t peer_id =3D ((uint32_t)ptr[1] << 16) | ((ui=
nt32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
+        peer_id_disabled =3D (pe=
er_id =3D=3D MAX_PEER_ID);
 
-        /* make sure buffer has enough length=
 to read opcode (1 byte) and peer-id (3 bytes) */
-        if (v2)
+       =
 if (!peer_id_disabled && (peer_id < m->max_clients) && (m->instances[peer_=
id]))
         {
-            uint32_t peer_id =3D ((uint32_t)ptr[1] << 16)=
 | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
-            peer_id_disab=
led =3D (peer_id =3D=3D MAX_PEER_ID);
-
-            if (!peer_id_disabled =
&& (peer_id < m->max_clients) && m->instances[peer_id])
+            /* Flo=
ating on TCP will never be possible, so ensure we only process
+           =
  * UDP clients */
+            if (m->instances[peer_id]->context=2Ec2=2El=
ink_sockets[0]->info=2Eproto
+                =3D=3D sock->info=2Eproto)
  =
           {
-                /* Floating on TCP will never be possible, so=
 ensure we only process
-                 * UDP clients */
-               =
 if (m->instances[peer_id]->context=2Ec2=2Elink_sockets[0]->info=2Eproto
- =
                   =3D=3D sock->info=2Eproto)
-                {
-         =
           mi =3D m->instances[peer_id];
-                    *floated =3D =
!link_socket_actual_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=2Efrom);
+=
                mi =3D m->instances[peer_id];
+                *floated =3D=
 !link_socket_actual_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=2Efrom);
=
 
-                    if (*floated)
-                    {
-              =
          /* reset prefix, since here we are not sure peer is the one it cl=
aims to be
-                         */
-                        ungenerate=
_prefix(mi);
-                        msg(D_MULTI_MEDIUM, "Float requested =
for peer %" PRIu32 " to %s", peer_id,
-                            mroute_a=
ddr_print(&real, &gc));
-                    }
+                if (*floate=
d)
+                {
+                    /* reset prefix, since here we a=
re not sure peer is the one it claims to be
+                     */
+     =
               ungenerate_prefix(mi);
+                    struct gc_arena =
gc =3D gc_new();
+                    msg(D_MULTI_MEDIUM, "Float requested =
for peer %" PRIu32 " to %s", peer_id,
+                        mroute_addr_=
print(real, &gc));
+                    gc_free(&gc);
                 }
+ =
               return mi;
             }
         }
-        if (!v2 || pee=
r_id_disabled)
-        {
-            mi =3D multi_get_instance_real_udp_r=
eal(m, &real);
-        }
+    }
+    if (!v2 || peer_id_disabled)
+    {
+=
        return multi_get_instance_real_udp_real(m, real);
+    }
+    retur=
n NULL;
+}
 
-        /* we have no existing multi instance for this connec=
tion */
-        if (!mi)
-        {
-            mi =3D handle_connection_=
attempt(m, sock, &real, bucket);
-        }
+struct multi_instance *
+multi=
_get_create_instance_udp(struct multi_context *m, bool *floated, struct lin=
k_socket *sock)
+{
+    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    uin=
t8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
 
-#ifdef ENABLE_DEBUG
-        if (c=
heck_debug_level(D_MULTI_DEBUG))
-        {
-            const char *status=
 =3D mi ? "[ok]" : "[failed]";
+    struct mroute_addr real =3D { 0 };
+   =
 real=2Eproto =3D sock->info=2Eproto;
 
-            dmsg(D_MULTI_DEBUG, "G=
ET INST BY REAL: %s %s", mroute_addr_print(&real, &gc), status);
-        }=

-#endif
+    if (!mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efr=
om=2Edest, true) || m->top=2Ec2=2Ebuf=2Elen =3D=3D 0)
+    {
+        retur=
n NULL;
     }
 
-    gc_free(&gc);
+    struct multi_instance *mi =3D NULL=
;
+    if (op =3D=3D P_DATA_V1 || op =3D=3D P_DATA_V2)
+    {
+        mi =
=3D multi_get_instance_udp_data(m, floated, &real, sock);
+    }
+    else
=
+    {
+        mi =3D multi_get_instance_udp_control(m, sock);
+
+        =
/* we have no existing multi instance for this connection, control
+       =
  * packets can create a session=2E Data packets cannot */
+        if (!mi=
)
+        {
+            mi =3D handle_connection_attempt(m, sock, &real);=

+        }
+    }
+
+#ifdef ENABLE_DEBUG
+    if (check_debug_level(D_MULT=
I_DEBUG))
+    {
+        struct gc_arena gc =3D gc_new();
+        const c=
har *status =3D mi ? "[ok]" : "[failed]";
+
+        dmsg(D_MULTI_DEBUG, "G=
ET INST BY REAL/SID: %s %s", mroute_addr_print(&real, &gc), status);
+     =
   gc_free(&gc);
+    }
+#endif
+
     ASSERT(!(mi && mi->halt));
     retu=
rn mi;
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
6?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchang=
e
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e9923b5=
1b77f184c7d49d697004cb02d2b5cfc3
Gerrit-Change-Number: 1726
Gerrit-PatchSet=
: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ixUqJzbR7sU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Split multi_get_create_instance_udp into data and control parts<br=
><br>This currently leads to a bit of code duplication but this refactoring=
<br>will make the follow up patches cleaner and better to understand when<b=
r>the control channel lookup will be changed to use session ids instead of<=
br>IP addresses=2E<br><br>Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5c=
fc3<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M s=
rc/openvpn/mudp=2Ec<br>1 file changed, 88 insertions(+), 52 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/26/1726/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/op=
envpn/mudp=2Ec</span><br><span>index e8d8128=2E=2Eaa7defe 100644</span><br>=
<span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec=
</span><br><span>@@ -197,8 +197,7 @@</span><br><span> struct multi_instance=
 *</span><br><span> handle_connection_attempt(struct multi_context *m,</spa=
n><br><span>                           struct link_socket *sock,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                          struct=
 mroute_addr *real,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                        struct hash_bucket *bucket)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          struct mroute_a=
ddr *real)</span><br><span> {</span><br><span>     struct hash *hash =3D m-=
&gt;hash;</span><br><span>     struct tls_pre_decrypt_state state =3D { 0 }=
;</span><br><span>@@ -229,7 +228,9 @@</span><br><span>             if (mi)<=
/span><br><span>             {</span><br><span>                 const uint6=
4_t hv =3D hash_value(hash, real);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                struct hash_bucket *bucket =3D hash_bucket(h=
ash, hv);</span><br><span>                 hash_add_fast(hash, bucket, &amp=
;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>                 mi-&gt;did_real_hash =3D true;</span><=
br><span>                 multi_assign_peer_id(m, mi);</span><br><span> </s=
pan><br><span>@@ -278,6 +279,19 @@</span><br><span>     return NULL;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct multi_instance *</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+multi_get_instance_udp_control(struct multi_context *m, stru=
ct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mrout=
e_addr real =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=
=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return multi_get_instance_re=
al_udp_real(m, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br=
><span> /**</span><br><span>  * Get a client instance based on real address=
=2E  If</span><br><span>@@ -285,72 +299,94 @@</span><br><span>  * maintaini=
ng real address hash table atomicity=2E</span><br><span>  */</span><br><spa=
n> struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-multi_get_create_instance_udp(struct multi_context *m, bool *floated, =
struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+multi_get_instance_udp_data(struct multi_context *m, bool *floated, s=
truct mroute_addr *real, struct link_socket *sock)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct m=
route_addr real =3D { 0 };</span><br><span>     struct multi_instance *mi =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct h=
ash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (mroute_extract_openvpn_=
sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&=
gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D ptr[0] &gt=
;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool v2 =3D (op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top=2Ec2=2Ebuf=2E=
len &gt;=3D (1 + 3));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool peer_id_disabled =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* make sure buffer has enough length to read opcode (1 byte) and peer-=
id (3 bytes) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (v2)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        const uint64_t hv =3D hash_value(hash, &amp;real);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        struct hash_bucket *b=
ucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t op =3D ptr[0=
] &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        bool v2 =3D (op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top=2Ec2=
=2Ebuf=2Elen &gt;=3D (1 + 3));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        bool peer_id_disabled =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        uint32_t peer_id =3D ((uint32_t)ptr[1=
] &lt;&lt; 16) | ((uint32_t)ptr[2] &lt;&lt; 8) | ((uint32_t)ptr[3]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        peer_id_disabled =
=3D (peer_id =3D=3D MAX_PEER_ID);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* make sure buffer has enough leng=
th to read opcode (1 byte) and peer-id (3 bytes) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (v2)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (!peer_id_disabled &amp;&amp; (peer_=
id &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        uint32_t peer_id =3D ((uint32_t)ptr[1] &lt;&lt; 16) | ((uint32_t)pt=
r[2] &lt;&lt; 8) | ((uint32_t)ptr[3]);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_=
ID);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (!peer_id_disabled &amp=
;&amp; (peer_id &lt; m-&gt;max_clients) &amp;&amp; m-&gt;instances[peer_id]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Flo=
ating on TCP will never be possible, so ensure we only process</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             * UDP clients */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (m-&gt;=
instances[peer_id]-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                =3D=3D s=
ock-&gt;info=2Eproto)</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                /* Floating on TCP will nev=
er be possible, so ensure we only process</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                 * UDP clients */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (m-&gt;instances[peer_id=
]-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    =3D=3D sock-&gt;info=2E=
proto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 mi =3D m-&gt;instances[peer_id];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    *floated =3D !link_socket_actual_match(&amp=
;mi-&gt;context=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                mi =3D m-&gt;instance=
s[peer_id];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        *floated =3D !link_socket_actual_match(&amp;mi-&gt;context=2Ec2=2Ef=
rom, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if (*floated)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        /* rese=
t prefix, since here we are not sure peer is the one it claims to be</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                         */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
  ungenerate_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        msg(D_MULTI_MEDIUM, &quot;Float requested for pe=
er %&quot; PRIu32 &quot; to %s&quot;, peer_id,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                            mroute_addr_print(&amp=
;real, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              if (*floated)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    /* reset prefix, since here we are not sure peer =
is the one it claims to be</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    ungenerate_prefix(mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              msg(D_MULTI_MEDIUM, &quot;Float requested for peer %&quot; PR=
Iu32 &quot; to %s&quot;, peer_id,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        mroute_addr_print(real, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    gc=
_free(&amp;gc);</span><br><span>                 }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                return mi;</span><br><span> =
            }</span><br><span>         }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (!v2 || peer_id_disabled)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            mi =3D multi_get_instance_real_udp_real(m=
, &amp;real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!v2 || peer_id_disabled)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return multi_get_instance=
_real_udp_real(m, real);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* we =
have no existing multi instance for this connection */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (!mi)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            mi =3D handle_connection_attempt(m, sock, &amp;=
real, bucket);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_inst=
ance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_cre=
ate_instance_udp(struct multi_context *m, bool *floated, struct link_socket=
 *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *ptr =3D BPTR(&amp=
;m-&gt;top=2Ec2=2Ebuf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (check_debug_le=
vel(D_MULTI_DEBUG))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            co=
nst char *status =3D mi ? &quot;[ok]&quot; : &quot;[failed]&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct mroute_addr real =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    real=
=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_MULTI_DEBUG, &quot;GET I=
NST BY REAL: %s %s&quot;, mroute_addr_print(&amp;real, &amp;gc), status);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!mroute_extract_openvpn_sockaddr(&amp;re=
al, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) || m-&gt;top=2Ec2=2Ebuf=2Elen =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct multi_instance *mi =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (op =3D=3D P_DATA_V1 || op =3D=
=3D P_DATA_V2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi =3D mult=
i_get_instance_udp_data(m, floated, &amp;real, sock);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   mi =3D multi_get_instance_udp_control(m, sock);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* we have no existing multi instance for this connecti=
on, control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * packets can create a session=2E Data packets cannot */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!mi)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            mi =3D handle_connection_attempt(m, so=
ck, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (check_debug_level(D_MULTI_DEBUG))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char=
 *status =3D mi ? &quot;[ok]&quot; : &quot;[failed]&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        dmsg(D_MULTI_DEBUG, &quot;GET INST BY REAL/SID:=
 %s %s&quot;, mroute_addr_print(&amp;real, &amp;gc), status);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     ASSERT(!(mi &amp;&amp; mi-&gt;ha=
lt));</span><br><span>     return mi;</span><br><span> }</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1726?usp=3Demail">change 1726</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1726?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5=
cfc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1726 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--ixUqJzbR7sU=--


--===============4239274015333879756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4239274015333879756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4239274015333879756==--

