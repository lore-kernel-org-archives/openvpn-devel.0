Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B86CDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cAKxLS3nwNVHvav9wUS4p7jCGoZsKJU8K1fUK66gy+g=; b=Gj3HEvhNnrKsnES7ie5hJBTq77
	Lo5KBxdvSxDOQltm/wyaE0RFrWDzhJctSjvJRYjbxKVSOc/Redxx6ND421KT0Zc2Oi7J9iu41KCnk
	OhlLK8wuqjd3vnsjNqNUh598M99eZTyCJpQeKb0CTVvabEoEKJ2OIC2b44q+zy/US/jU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckH2-0007aJ-87;
	Thu, 25 Jun 2026 13:37:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckH1-0007a9-Cr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=arRmypA3NEjyhrvJBNK6+ykd+yl5+kcL3i52HZR9mGM=; b=AN9SoBWWnYeVS+oh/p8RrW2Oep
 eWId3DxU8SDM8GP14IKR0iUiLGhITUeCHtzTiBmv5yv9mnvB2bm5K4mThOtzBSYqucsmuyPNQ2DgG
 H7f851rw2daigCVcRsCxLmONJ45bhQIVg8BiEqxjITIPpu60+9GxujdS4Xl3ylFttFc8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=arRmypA3NEjyhrvJBNK6+ykd+yl5+kcL3i52HZR9mGM=; b=R
 MblZg4gcChS6fIQiXnMIpcBBpVZHX75ATc3QKVF2PITBfBBvV8MHOTIwG3pFH/UZl87CYv8XGBZIo
 K2nkRhaGIkEiaPhUsRx4/sBN73oOIflT+7vfIDMngFb8CEy4BGg1P0TQEl8/BjMVvLiKqLkC1/KbR
 62bGy95ZdkSfLm5k=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckGx-0001Ir-0C for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:40 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-492329c5514so4655875e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394648; x=1782999448; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=arRmypA3NEjyhrvJBNK6+ykd+yl5+kcL3i52HZR9mGM=;
 b=aKNdb15IrHKKVZr79HdBv6LLWjaa3ZAxbbfPq49TUd99kBR3353i2z+mH1TGG/sR13
 EV5iPnmpQ21NVYSuvW76VgXdPQFg4ELMQOpB6voJmO5I1+54I7zF+o37nIBXoW9ZUVcg
 11YSPZKtl3W6kkPSRpnTSG0x4CbD6Xsz3ck0dOR3twkGfJVNL0EiLRwIdBrDgW1QRew3
 OL1LrgUUkUSJ8TurWqWxJ69WpuUhe+0oQRW1r9JRYaW/L2udNrH71F/iBTPFIKfl7Nsy
 EjJKatJjKPuPnO4rR2HJjrAuVx+lToU8FfRKieGJGB04K6MARXoX4ArzgUgJRRj+Qmvt
 eIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394648; x=1782999448;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=arRmypA3NEjyhrvJBNK6+ykd+yl5+kcL3i52HZR9mGM=;
 b=fooyqxGIRQhjJBMcmsvjsBdPaej65tj/E5S4Q4hIJdhI70Bzg8GZXoSExz22AzXbCH
 ikO+yYjAlGkl7gonSpCVeXrkC3x5OKrRgMMYSPm5amM2gy9PhIJUcCPWDHFUuf+dQEeu
 uNtkWeNzCzrFGj5sqZhkRbyMEwfDsyAHlpiCgXoRFcG0HukUEDksRHmxHN/TJIiaEejs
 HQUlxKB2EETgu5HtImQX+3EVNQ+hK5Mim7sy2bjKA/dSRacl25kTY5cdp8OHa6XqHXC2
 t4FkCG+Jr8QUH3Otemtj1/JdPsSoDYm1TN4tBZ1dDN7cYD4r6AxAtqs1amYv9uXka6SR
 YQgg==
X-Gm-Message-State: AOJu0Yw0DLb/ZbHZGs6w0t02Ao2NzDIR9xw2yAune+KyD7nuLOyF67yn
 BNQ4qYxjfOFzi914MdRgVhPcl59mFWH3/mMt5v3X7Aj+54lw/7Pfn2POBIo8SvHJ1Y2VK3Nw320
 QeZVNsbTANczHTl3lAtlBFmBjmOfXDRtLqK7Y/WA7q/HIRMyPOoUoJnR4eEi3n0nnz77V6wa1n3
 5ck/xw5g==
X-Gm-Gg: AfdE7ckp6tgukxPZxDD42flCsQKXDI8y6Z7IxoQIJG3Twyef+xPCelhrJj0Ifmwc8n5
 tefOwIOvMWx3JrUPeA8QfjcEjL+xkBM6TpzOxDmHxmASaLC9PgsmGzxhohdzzhqrVNiMNhuzzVU
 5I+RnueZNidcGjoXaWdi3JSAAELrrEKWAgn2s/06wSiwCne4Z3ZYmJ8e+GI8RbyeeZUsY/nT2cO
 T0i/p/pbDOQZp6lsyuvFSBZJGA8ciB3BjrKqeLt2wTACOgrNd3A+e2xCeHbrE5w5SIBHuog9TZM
 3MzAE6MYJL9zSpCFmniN2ZOfqqoqwNSNKGVcIaxbQVVd+rQbTN3vNgBrY6uVXEINZJJzy8mkzhv
 jAl3DucmDQhW6xtJICmQcXwmuevOUXX69J6MQODM1/fmrawcX9UGohUTM98S+4Hb+tc0Q3E3+8X
 j7y9Jk+kjb9zHFAukgGbZPVTMXR+JluEARioHUx1ZS05R1iDNXsUVEuR9X9D2Fh/ExbAqmEHftN
 MuWmbpqAjA7oy1Us130M8lEqzwyxnAJf9ugz+3l5/tKEgSRZADTvCbPEStYM21G6cWevOTtQJmp
 4RQ=
X-Received: by 2002:a05:600c:1551:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-492664241a4mr31080325e9.13.1782394647559; 
 Thu, 25 Jun 2026 06:37:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660b6221sm60435045e9.7.2026.06.25.06.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:37:22 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:37:02 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: 30112912578226bfe2e750920037a567b6ca5a16
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2de3f8e4d2295bad9399cd74cad0202434b79c12-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckGx-0001Ir-0C
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
Content-Type: multipart/mixed; boundary="===============7327134517545557273=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7327134517545557273==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3Zu8yRr4ipE="; charset=UTF-8

--3Zu8yRr4ipE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#3)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1726?usp=3Demail )


Change subject: Split multi_get_create=
_instance_udp into data and control parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Split multi_get_create_instance_udp into data =
and control parts

This currently leads to a bit of code duplication but th=
is refactoring
will make the follow up patches cleaner and better to unders=
tand when
the control channel lookup will be changed to use session ids ins=
tead of
IP addresses=2E

Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cf=
c3
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/mudp=
=2Ec
1 file changed, 88 insertions(+), 52 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/1726/3

diff --git a/sr=
c/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index e867ffe=2E=2E128afbb 100644=

--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -204,8 +204,7 @@
=
 static struct multi_instance *
 handle_connection_attempt(struct multi_con=
text *m,
                           struct link_socket *sock,
-            =
              struct mroute_addr *real,
-                          struct h=
ash_bucket *bucket)
+                          struct mroute_addr *real)
 {=

     struct hash *hash =3D m->hash;
     struct tls_pre_decrypt_state stat=
e =3D { 0 };
@@ -236,7 +235,9 @@
             if (mi)
             {
      =
           const uint64_t hv =3D hash_value(hash, real);
+                s=
truct hash_bucket *bucket =3D hash_bucket(hash, hv);
                 hash_=
add_fast(hash, bucket, &mi->real, hv, mi);
+
                 mi->did_real_=
hash =3D true;
                 multi_assign_peer_id(m, mi);
 
@@ -285,6 +2=
86,19 @@
     return NULL;
 }
 
+struct multi_instance *
+multi_get_instanc=
e_udp_control(struct multi_context *m, struct link_socket *sock)
+{
+    st=
ruct mroute_addr real =3D { 0 };
+    real=2Eproto =3D sock->info=2Eproto;
=
+
+    if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edes=
t, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+    {
+        return multi_get_i=
nstance_real_udp_real(m, &real);
+    }
+
+    return NULL;
+}
 
 /**
  * G=
et a client instance based on real address=2E  If
@@ -292,72 +306,94 @@
  *=
 maintaining real address hash table atomicity=2E
  */
 struct multi_instan=
ce *
-multi_get_create_instance_udp(struct multi_context *m, bool *floated,=
 struct link_socket *sock)
+multi_get_instance_udp_data(struct multi_contex=
t *m, bool *floated, struct mroute_addr *real, struct link_socket *sock)
 {=

-    struct gc_arena gc =3D gc_new();
-    struct mroute_addr real =3D { 0=
 };
     struct multi_instance *mi =3D NULL;
-    struct hash *hash =3D m->=
hash;
-    real=2Eproto =3D sock->info=2Eproto;
 
-    if (mroute_extract_o=
penvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Eb=
uf=2Elen > 0)
+    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    uint8_t =
op =3D ptr[0] >> P_OPCODE_SHIFT;
+    bool v2 =3D (op =3D=3D P_DATA_V2) && =
(m->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
+    bool peer_id_disabled =3D fals=
e;
+
+    /* make sure buffer has enough length to read opcode (1 byte) and=
 peer-id (3 bytes) */
+    if (v2)
     {
-        const uint64_t hv =3D ha=
sh_value(hash, &real);
-        struct hash_bucket *bucket =3D hash_bucket(=
hash, hv);
-        uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
-        uin=
t8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
-        bool v2 =3D (op =3D=3D P_DAT=
A_V2) && (m->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
-        bool peer_id_disa=
bled =3D false;
+        uint32_t peer_id =3D ((uint32_t)ptr[1] << 16) | ((=
uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
+        peer_id_disabled =3D (=
peer_id =3D=3D MAX_PEER_ID);
 
-        /* make sure buffer has enough leng=
th to read opcode (1 byte) and peer-id (3 bytes) */
-        if (v2)
+     =
   if (!peer_id_disabled && (peer_id < m->max_clients) && (m->instances[pee=
r_id]))
         {
-            uint32_t peer_id =3D ((uint32_t)ptr[1] << 1=
6) | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
-            peer_id_dis=
abled =3D (peer_id =3D=3D MAX_PEER_ID);
-
-            if (!peer_id_disable=
d && (peer_id < m->max_clients) && m->instances[peer_id])
+            /* F=
loating on TCP will never be possible, so ensure we only process
+         =
    * UDP clients */
+            if (m->instances[peer_id]->context=2Ec2=
=2Elink_sockets[0]->info=2Eproto
+                =3D=3D sock->info=2Eproto=
)
             {
-                /* Floating on TCP will never be possible=
, so ensure we only process
-                 * UDP clients */
-           =
     if (m->instances[peer_id]->context=2Ec2=2Elink_sockets[0]->info=2Eprot=
o
-                    =3D=3D sock->info=2Eproto)
-                {
-     =
               mi =3D m->instances[peer_id];
-                    *floated =
=3D !link_socket_actual_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=2Efrom=
);
+                mi =3D m->instances[peer_id];
+                *floated=
 =3D !link_socket_actual_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=2Efro=
m);
 
-                    if (*floated)
-                    {
-          =
              /* reset prefix, since here we are not sure peer is the one i=
t claims to be
-                         */
-                        ungene=
rate_prefix(mi);
-                        msg(D_MULTI_MEDIUM, "Float reques=
ted for peer %" PRIu32 " to %s", peer_id,
-                            mrou=
te_addr_print(&real, &gc));
-                    }
+                if (*fl=
oated)
+                {
+                    /* reset prefix, since here =
we are not sure peer is the one it claims to be
+                     */
+ =
                   ungenerate_prefix(mi);
+                    struct gc_ar=
ena gc =3D gc_new();
+                    msg(D_MULTI_MEDIUM, "Float reques=
ted for peer %" PRIu32 " to %s", peer_id,
+                        mroute_a=
ddr_print(real, &gc));
+                    gc_free(&gc);
                 =
}
+                return mi;
             }
         }
-        if (!v2 ||=
 peer_id_disabled)
-        {
-            mi =3D multi_get_instance_udp_re=
al(m, &real);
-        }
+    }
+    if (!v2 || peer_id_disabled)
+    {
+ =
       return multi_get_instance_udp_real(m, real);
+    }
+    return NULL=
;
+}
 
-        /* we have no existing multi instance for this connection *=
/
-        if (!mi)
-        {
-            mi =3D handle_connection_attemp=
t(m, sock, &real, bucket);
-        }
+struct multi_instance *
+multi_get_c=
reate_instance_udp(struct multi_context *m, bool *floated, struct link_sock=
et *sock)
+{
+    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    uint8_t o=
p =3D ptr[0] >> P_OPCODE_SHIFT;
 
-#ifdef ENABLE_DEBUG
-        if (check_d=
ebug_level(D_MULTI_DEBUG))
-        {
-            const char *status =3D m=
i ? "[ok]" : "[failed]";
+    struct mroute_addr real =3D { 0 };
+    real=
=2Eproto =3D sock->info=2Eproto;
 
-            dmsg(D_MULTI_DEBUG, "GET IN=
ST BY REAL: %s %s", mroute_addr_print(&real, &gc), status);
-        }
-#en=
dif
+    if (!mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2E=
dest, true) || m->top=2Ec2=2Ebuf=2Elen =3D=3D 0)
+    {
+        return NUL=
L;
     }
 
-    gc_free(&gc);
+    struct multi_instance *mi =3D NULL;
+  =
  if (op =3D=3D P_DATA_V1 || op =3D=3D P_DATA_V2)
+    {
+        mi =3D mu=
lti_get_instance_udp_data(m, floated, &real, sock);
+    }
+    else
+    {=

+        mi =3D multi_get_instance_udp_control(m, sock);
+
+        /* we =
have no existing multi instance for this connection, control
+         * pa=
ckets can create a session=2E Data packets cannot */
+        if (!mi)
+   =
     {
+            mi =3D handle_connection_attempt(m, sock, &real);
+    =
    }
+    }
+
+#ifdef ENABLE_DEBUG
+    if (check_debug_level(D_MULTI_DEBU=
G))
+    {
+        struct gc_arena gc =3D gc_new();
+        const char *s=
tatus =3D mi ? "[ok]" : "[failed]";
+
+        dmsg(D_MULTI_DEBUG, "GET INS=
T BY REAL/SID: %s %s", mroute_addr_print(&real, &gc), status);
+        gc_=
free(&gc);
+    }
+#endif
+
     ASSERT(!(mi && mi->halt));
     return mi;=

 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e9923b51b7=
7f184c7d49d697004cb02d2b5cfc3
Gerrit-Change-Number: 1726
Gerrit-PatchSet: 3=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--3Zu8yRr4ipE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Split multi_get_create_instance_udp into data and control parts<b=
r><br>This currently leads to a bit of code duplication but this refactorin=
g<br>will make the follow up patches cleaner and better to understand when<=
br>the control channel lookup will be changed to use session ids instead of=
<br>IP addresses=2E<br><br>Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5=
cfc3<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M =
src/openvpn/mudp=2Ec<br>1 file changed, 88 insertions(+), 52 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/26/1726/3</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/o=
penvpn/mudp=2Ec</span><br><span>index e867ffe=2E=2E128afbb 100644</span><br=
><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2E=
c</span><br><span>@@ -204,8 +204,7 @@</span><br><span> static struct multi_=
instance *</span><br><span> handle_connection_attempt(struct multi_context =
*m,</span><br><span>                           struct link_socket *sock,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
  struct mroute_addr *real,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                          struct hash_bucket *bucket)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                          struct mr=
oute_addr *real)</span><br><span> {</span><br><span>     struct hash *hash =
=3D m-&gt;hash;</span><br><span>     struct tls_pre_decrypt_state state =3D=
 { 0 };</span><br><span>@@ -236,7 +235,9 @@</span><br><span>             if=
 (mi)</span><br><span>             {</span><br><span>                 const=
 uint64_t hv =3D hash_value(hash, real);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                struct hash_bucket *bucket =3D hash_bu=
cket(hash, hv);</span><br><span>                 hash_add_fast(hash, bucket=
, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>                 mi-&gt;did_real_hash =3D true;</=
span><br><span>                 multi_assign_peer_id(m, mi);</span><br><spa=
n> </span><br><span>@@ -285,6 +286,19 @@</span><br><span>     return NULL;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct multi_instance *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_get_instance_udp_control(struct multi_context *m=
, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 mroute_addr real =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&g=
t;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return multi_get_instan=
ce_real_udp_real(m, &amp;real);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </spa=
n><br><span> /**</span><br><span>  * Get a client instance based on real ad=
dress=2E  If</span><br><span>@@ -292,72 +306,94 @@</span><br><span>  * main=
taining real address hash table atomicity=2E</span><br><span>  */</span><br=
><span> struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-multi_get_create_instance_udp(struct multi_context *m, bool *floa=
ted, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+multi_get_instance_udp_data(struct multi_context *m, bool *float=
ed, struct mroute_addr *real, struct link_socket *sock)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct mroute_addr real =3D { 0 };</span><br><span>     struct multi_instance =
*mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mroute_extract_open=
vpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp;=
 m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D ptr[0]=
 &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    bool v2 =3D (op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top=2Ec2=2Ebu=
f=2Elen &gt;=3D (1 + 3));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    bool peer_id_disabled =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* make sure buffer has enough length to read opcode (1 byte) and p=
eer-id (3 bytes) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (v2)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        const uint64_t hv =3D hash_value(hash, &amp;real);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct hash_bucke=
t *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t op =3D p=
tr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        bool v2 =3D (op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top=2E=
c2=2Ebuf=2Elen &gt;=3D (1 + 3));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        bool peer_id_disabled =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uint32_t peer_id =3D ((uint32_t)p=
tr[1] &lt;&lt; 16) | ((uint32_t)ptr[2] &lt;&lt; 8) | ((uint32_t)ptr[3]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        peer_id_disabl=
ed =3D (peer_id =3D=3D MAX_PEER_ID);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* make sure buffer has enough len=
gth to read opcode (1 byte) and peer-id (3 bytes) */</span><br><span style=
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
 hsl(0, 100%, 40%);">-            mi =3D multi_get_instance_udp_real(m, &am=
p;real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!v2 || peer_id_disabled)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return multi_get_instance_udp_=
real(m, real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* we have no ex=
isting multi instance for this connection */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (!mi)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            mi =3D handle_connection_attempt(m, sock, &amp;real, buck=
et);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_create_instan=
ce_udp(struct multi_context *m, bool *floated, struct link_socket *sock)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint8_t *ptr =3D BPTR(&amp;m-&gt;top=
=2Ec2=2Ebuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (check_debug_level(D_MULT=
I_DEBUG))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            const char *=
status =3D mi ? &quot;[ok]&quot; : &quot;[failed]&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct mroute_addr real =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    real=2Eproto =
=3D sock-&gt;info=2Eproto;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            dmsg(D_MULTI_DEBUG, &quot;GET INST BY RE=
AL: %s %s&quot;, mroute_addr_print(&amp;real, &amp;gc), status);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!mroute_extract_openvpn_sockaddr(&amp;real, &amp=
;m-&gt;top=2Ec2=2Efrom=2Edest, true) || m-&gt;top=2Ec2=2Ebuf=2Elen =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct multi_instance *mi =3D NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (op =3D=3D P_DATA_V1 || op =3D=3D P_DA=
TA_V2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        mi =3D multi_get_in=
stance_udp_data(m, floated, &amp;real, sock);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi =
=3D multi_get_instance_udp_control(m, sock);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* we have no existing multi instance for this connection, co=
ntrol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * pac=
kets can create a session=2E Data packets cannot */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!mi)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            mi =3D handle_connection_attempt(m, sock, =
&amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (check_debug_level(D_MULTI_DEBUG))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *=
status =3D mi ? &quot;[ok]&quot; : &quot;[failed]&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        dmsg(D_MULTI_DEBUG, &quot;GET INST BY REAL/SID: %=
s %s&quot;, mroute_addr_print(&amp;real, &amp;gc), status);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
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
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2=
b5cfc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1726 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--3Zu8yRr4ipE=--


--===============7327134517545557273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7327134517545557273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7327134517545557273==--

