Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FE3C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xyLr0ombmiJYTCSw7eZ8vHGpdJ5NTv+zeVo5YNNlvjw=; b=MWhwN+rHgHhBrvvb6e7ZVdUhid
	zWgSFyvH9z1rYBMIuphkCd0VfiCbORPk7PE0NMFs0V+/di3dPu+Gm3PkkMFP6XZgASIzl7C73YmkO
	pqXTVkjroIK6EhcEQ2HQH0zbjA6ePt3drQbsusBiEFqqF3BIPCXOVn5GHPp5uWfGja+U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wup0Z-00034f-SE;
	Fri, 14 Aug 2026 10:19:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wup0Z-00034Z-8f
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0XTiexLC1OON11+8UFVe3RvIOWK+ADDq/iaNQkLoKDw=; b=N3heiBapadIpjfH4CoOuzfuLSK
 fE/1I1PB5Pik9Hy50GOd0Zesu3A7ubKtK6ANyDQ+dRt8WiT6W5uadY53F4cjpUg7tSpPNyuKkUVW/
 PLs3HIVQotwt/ObmuL5rDiTgFnm/RxFwdWMCG7rkXEA49e0kJIdQ9mEoiXuAQot9AvdI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0XTiexLC1OON11+8UFVe3RvIOWK+ADDq/iaNQkLoKDw=; b=Q
 UMfkc7z1/mN0tP5RrDxR09ksElezvjYrVRKWE9PoMhj+hkl04TrNKrUysYFEM1mdrVxy7iQ6LGbAW
 VWoXkbooJ044QHSMryzvqoX47HdbsFbq7gMlIy+hKcWFleAK2b9ZVuq22HXx2McVvK6RABv2zZ5k5
 FpCy2aRiTWfgpkSY=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wup0Y-0001BX-8V for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:19:27 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47db714766aso1164250f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786702760; x=1787307560; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0XTiexLC1OON11+8UFVe3RvIOWK+ADDq/iaNQkLoKDw=;
 b=VApGHgeWuAPy4r8SyKr428HuBYJ4l4HBvkycORLpGMPZFyiHbFf1lrJmsiGDX+9PIe
 ixHwHpWl1F3ATliJ3W9pVBhP/OC1f05yewIzJt8ONTrthgFxQXJXCYrgosfvpLnWf4eS
 XeyZdoHJjPVj6z/XFVBSvv/N/e/2wyWB7gmrQuthBu7DYx2yCLc3LoHxSobDz3H2iYeG
 tnKEUbppB11xp2qsFbMXu1MIcUy5KXbCRBk0F9FaVOVknfYi4cBzUGOwsuowB85AAkZu
 TsJtfzUdlR7JZKYFhtWWq4/wERxmJIewWLzznuM2AH8nAehIYKZlWbYltWgA2h8SvyKD
 BmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786702760; x=1787307560;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0XTiexLC1OON11+8UFVe3RvIOWK+ADDq/iaNQkLoKDw=;
 b=YTaUnxRqvSNa6gSCsT84uS2p06K7uyY0Q2qFD8QLcxVWZs9LRoN7FGlMp3aAVYCMHP
 L5Y1YoRaXfVdBuTWkHV52g3q9gIaps0Ibsxwb8WBYOX9lqd2rRyq/nyds/Jw4z+WB+sr
 zXHw73M5f/KggmPqYZ5VXhM5nev87vh57fsPwZ0ahgaCpIJev/F+4cCoLs1Fy8PM7VMe
 Yhuo1arcKD9lfk05BrjeVAMzOyhCxk/tC33mwqKPwcdP3M1lYHe5e7p/eflV2FS+AxoZ
 VSWSzSGWQp1zjGyP24IWoipn54XU5ulFKXx0T6Ug6zizDZgJeNH4DdiDuVh5rhIJ0pJc
 gy8w==
X-Gm-Message-State: AOJu0YyKFYPcjZzHgakBcgSAfrSqurLThE9OETVhbJaCpKWgvm/+erB/
 JGmYsrMoizzwtIFEonJEnvEUaUNOZYjnU7T4HzWIpel/TpggbbNk0fk2WHqRMOd249CRmwA4YGW
 Mx6xqWq+NilvEsxrHhjmfevV7x7WFWT5jXh4/HuGo1ST3QpYfMTCjJ3+QyzOc9oJkdkbh
X-Gm-Gg: AR+sD12m4xOEthbDACu5iz5K2unO3xYkE+MP42lBqqio0RoatT6PAl31UB78+C+/YSP
 O38W3HqHHAVSIFuyoyphXBPhZ1T7CocqZx1ZMBXkQ87lf5rvxUHcC0gWczA8nzcUMx3O5XObqoM
 UvE0xl1JXFkZKYFYeB9ZuwotVdEm+rDco0uW2WVNCMbSMrnL3Wt89JT69FHzCsVwzxAzUyI2fUo
 upPBdEpujnv+Xkk+6Q90BHh5pQ21in7ULe3xz6d5XcrtiUKJqqa+0rcq7EnkDxIUbVNI22VjdFz
 rq4g8EkAardfkU+Gg09J/d33SCIf0Kkfl4YCT9jm7D/UsC4IUvtWlf/yumsRfXFc6acWtxmhYSO
 K8vMXrVR1iJdeNn8RMQihaE3x1t1jC43X6nJFu0O1IGvEEkGF44739uJ5dnZkk1In89f81X55Hx
 0PsHLlo4IOiuyZXgD6tYE3Y4MIOEdIMUADgLeCKhMJdOiaMvhSrF1QcOh7j+GxGMDFDFByLG0HF
 C5xmoUle8Ibo3jbWm4gz/N1FuRWgvM9x4L90PF4kCfhjCwmenxEhJ2VqqkaoiD1U7t5SlfjtC7R
 Gm4nweHqOvCW4refGeN83TAhxFoZkv7hH3dlj8mOaf4OV0tm4E+sMq1WR9UPUQ==
X-Received: by 2002:adf:f288:0:b0:47f:f002:3656 with SMTP id
 ffacd0b85a97d-48160797e95mr5762363f8f.12.1786702759457; 
 Fri, 14 Aug 2026 03:19:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c18cbsm5935571f8f.29.2026.08.14.03.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:19:18 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:19:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: 6ff04417a4250b558da06a3b58b5cda697cd5ee3
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7126a77db6cda8796c585fcc9b2c1f04fbc2ef6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wup0Y-0001BX-8V
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2277824998130236790=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2277824998130236790==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RfNF/6m1Fi8="; charset=UTF-8

--RfNF/6m1Fi8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#21) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 flichtenheld


Change subject: Split multi_get_create_instance_udp into da=
ta and control parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Split multi_get_create_instance_udp into data and control parts

Th=
is currently leads to a bit of code duplication but this refactoring
will m=
ake the follow up patches cleaner and better to understand when
the control=
 channel lookup will be changed to use session ids instead of
IP addresses=
=2E

Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726
Mess=
age-Id: <20260813184950=2E6709-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38338=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
mudp=2Ec
1 file changed, 97 insertions(+), 54 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/1726/21

diff --git=
 a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 08d79c9=2E=2E632b064 1=
00644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -218,8 +218,=
7 @@
 static struct multi_instance *
 handle_connection_attempt(struct mult=
i_context *m,
                           struct link_socket *sock,
-       =
                   struct mroute_addr *real,
-                          str=
uct hash_bucket *bucket)
+                          struct mroute_addr *rea=
l)
 {
     struct hash *hash =3D m->hash;
     struct tls_pre_decrypt_state=
 state =3D { 0 };
@@ -250,7 +249,9 @@
             if (mi)
             {
 =
                const uint64_t hv =3D hash_value(hash, real);
+            =
    struct hash_bucket *bucket =3D hash_bucket(hash, hv);
                 =
hash_add_fast(hash, bucket, &mi->real, hv, mi);
+
                 mi->did_=
real_hash =3D true;
                 multi_assign_peer_id(m, mi);
 
@@ -299=
,6 +300,19 @@
     return NULL;
 }
 
+struct multi_instance *
+multi_get_in=
stance_udp_control(struct multi_context *m, struct link_socket *sock)
+{
+ =
   struct mroute_addr real =3D { 0 };
+    real=2Eproto =3D sock->info=2Epr=
oto;
+
+    if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=
=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+    {
+        return multi=
_get_instance_udp_real(m, &real);
+    }
+
+    return NULL;
+}
 
 /**
  * =
Get a client instance based on real address=2E  If
@@ -306,72 +320,101 @@
 =
 * maintaining real address hash table atomicity=2E
  */
 struct multi_inst=
ance *
-multi_get_create_instance_udp(struct multi_context *m, bool *floate=
d, struct link_socket *sock)
+multi_get_instance_udp_data(struct multi_cont=
ext *m, bool *floated, struct mroute_addr *real, struct link_socket *sock)
=
 {
-    struct gc_arena gc =3D gc_new();
-    struct mroute_addr real =3D {=
 0 };
     struct multi_instance *mi =3D NULL;
-    struct hash *hash =3D m=
->hash;
-    real=2Eproto =3D sock->info=2Eproto;
 
-    if (mroute_extract=
_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=
=2Ebuf=2Elen > 0)
+    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    uint=
8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
+    bool v2 =3D (op =3D=3D P_DATA_V2)=
 && (m->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
+    bool peer_id_disabled =3D =
false;
+
+    /* make sure buffer has enough length to read opcode (1 byte)=
 and peer-id (3 bytes) */
+    if (v2)
     {
-        const uint64_t hv =
=3D hash_value(hash, &real);
-        struct hash_bucket *bucket =3D hash_b=
ucket(hash, hv);
-        uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
-     =
   uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
-        bool v2 =3D (op =3D=3D=
 P_DATA_V2) && (m->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
-        bool peer_i=
d_disabled =3D false;
+        uint32_t peer_id =3D ((uint32_t)ptr[1] << 16=
) | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
+        peer_id_disabled=
 =3D (peer_id =3D=3D MAX_PEER_ID);
 
-        /* make sure buffer has enoug=
h length to read opcode (1 byte) and peer-id (3 bytes) */
-        if (v2)
=
+        if (!peer_id_disabled && (peer_id < m->max_clients) && (m->instanc=
es[peer_id]))
         {
-            uint32_t peer_id =3D ((uint32_t)ptr[1=
] << 16) | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
-            peer_=
id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);
-
-            if (!peer_id_d=
isabled && (peer_id < m->max_clients) && m->instances[peer_id])
+          =
  /* Floating on TCP will never be possible, so ensure we only process
+   =
          * UDP clients */
+            if (m->instances[peer_id]->context=
=2Ec2=2Elink_sockets[0]->info=2Eproto
+                =3D=3D sock->info=2E=
proto)
             {
-                /* Floating on TCP will never be pos=
sible, so ensure we only process
-                 * UDP clients */
-      =
          if (m->instances[peer_id]->context=2Ec2=2Elink_sockets[0]->info=
=2Eproto
-                    =3D=3D sock->info=2Eproto)
-                {=

-                    mi =3D m->instances[peer_id];
-                    *f=
loated =3D !link_socket_actual_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=
=2Efrom);
+                mi =3D m->instances[peer_id];
+                *=
floated =3D !link_socket_actual_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec=
2=2Efrom);
 
-                    if (*floated)
-                    {
-   =
                     /* reset prefix, since here we are not sure peer is th=
e one it claims to be
-                         */
-                       =
 ungenerate_prefix(mi);
-                        msg(D_MULTI_MEDIUM, "Float=
 requested for peer %" PRIu32 " to %s", peer_id,
-                         =
   mroute_addr_print(&real, &gc));
-                    }
+                =
if (*floated)
+                {
+                    /* reset prefix, sinc=
e here we are not sure peer is the one it claims to be
+                   =
  */
+                    ungenerate_prefix(mi);
+                    struc=
t gc_arena gc =3D gc_new();
+                    msg(D_MULTI_MEDIUM, "Float=
 requested for peer %" PRIu32 " to %s", peer_id,
+                        m=
route_addr_print(real, &gc));
+                    gc_free(&gc);
          =
       }
+                return mi;
             }
         }
-        if =
(!v2 || peer_id_disabled)
-        {
-            mi =3D multi_get_instance=
_udp_real(m, &real);
-        }
+    }
+    if (!v2 || peer_id_disabled)
+ =
   {
+        return multi_get_instance_udp_real(m, real);
+    }
+    retu=
rn NULL;
+}
 
-        /* we have no existing multi instance for this conne=
ction */
-        if (!mi)
-        {
-            mi =3D handle_connection=
_attempt(m, sock, &real, bucket);
-        }
-
-#ifdef ENABLE_DEBUG
-      =
  if (check_debug_level(D_MULTI_DEBUG))
-        {
-            const char =
*status =3D mi ? "[ok]" : "[failed]";
-
-            dmsg(D_MULTI_DEBUG, "G=
ET INST BY REAL: %s %s", mroute_addr_print(&real, &gc), status);
-        }=

-#endif
+struct multi_instance *
+multi_get_create_instance_udp(struct mul=
ti_context *m, bool *floated, struct link_socket *sock)
+{
+    /* If the b=
uffer is empty, the packet has no op code and can be neither
+     * a (val=
id) data nor control packet */
+    if (m->top=2Ec2=2Ebuf=2Elen <=3D 0)
+  =
  {
+        return NULL;
     }
 
-    gc_free(&gc);
+    uint8_t *ptr =3D=
 BPTR(&m->top=2Ec2=2Ebuf);
+    uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
+
=
+    struct mroute_addr real =3D { 0 };
+    real=2Eproto =3D sock->info=2E=
proto;
+
+    if (!mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efr=
om=2Edest, true))
+    {
+        return NULL;
+    }
+
+    struct multi_i=
nstance *mi =3D NULL;
+    if (op =3D=3D P_DATA_V1 || op =3D=3D P_DATA_V2)
=
+    {
+        mi =3D multi_get_instance_udp_data(m, floated, &real, sock)=
;
+    }
+    else
+    {
+        mi =3D multi_get_instance_udp_control(m,=
 sock);
+
+        /* we have no existing multi instance for this connectio=
n, control
+         * packets can create a session=2E Data packets cannot =
*/
+        if (!mi)
+        {
+            mi =3D handle_connection_attem=
pt(m, sock, &real);
+        }
+    }
+
+#ifdef ENABLE_DEBUG
+    if (check=
_debug_level(D_MULTI_DEBUG))
+    {
+        struct gc_arena gc =3D gc_new(=
);
+        const char *status =3D mi ? "[ok]" : "[failed]";
+
+        dms=
g(D_MULTI_DEBUG, "GET INST BY REAL/SID: %s %s", mroute_addr_print(&real, &g=
c), status);
+        gc_free(&gc);
+    }
+#endif
+
     ASSERT(!(mi && mi=
->halt));
     return mi;
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1726?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
Gerrit-Change-Number:=
 1726
Gerrit-PatchSet: 21
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--RfNF/6m1Fi8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #21</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Split multi_get_crea=
te_instance_udp into data and control parts<br><br>This currently leads to =
a bit of code duplication but this refactoring<br>will make the follow up p=
atches cleaner and better to understand when<br>the control channel lookup =
will be changed to use session ids instead of<br>IP addresses=2E<br><br>Cha=
nge-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3<br>Signed-off-by: Arne Sc=
hwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1726<br>Message-Id: &lt;20260813184950=2E6709-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg38338=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>1 file changed, 97 inse=
rtions(+), 54 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/1726/21</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 08d79c9=
=2E=2E632b064 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><=
span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -218,8 +218,7 @@</span><=
br><span> static struct multi_instance *</span><br><span> handle_connection=
_attempt(struct multi_context *m,</span><br><span>                         =
  struct link_socket *sock,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                          struct mroute_addr *real,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                          struct hash_b=
ucket *bucket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                     struct mroute_addr *real)</span><br><span> {</span><br=
><span>     struct hash *hash =3D m-&gt;hash;</span><br><span>     struct t=
ls_pre_decrypt_state state =3D { 0 };</span><br><span>@@ -250,7 +249,9 @@</=
span><br><span>             if (mi)</span><br><span>             {</span><b=
r><span>                 const uint64_t hv =3D hash_value(hash, real);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                struct h=
ash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>             =
    hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>                 mi=
-&gt;did_real_hash =3D true;</span><br><span>                 multi_assign_=
peer_id(m, mi);</span><br><span> </span><br><span>@@ -299,6 +300,19 @@</spa=
n><br><span>     return NULL;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_udp_c=
ontrol(struct multi_context *m, struct link_socket *sock)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct mroute_addr real =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    real=2Eproto =3D sock-&gt;info=
=2Eproto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (mroute_extract_openvp=
n_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m=
-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return multi_get_instance_udp_real(m, &amp;real);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span> </span><br><span> /**</span><br><span>  * Get a client=
 instance based on real address=2E  If</span><br><span>@@ -306,72 +320,101 =
@@</span><br><span>  * maintaining real address hash table atomicity=2E</sp=
an><br><span>  */</span><br><span> struct multi_instance *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-multi_get_create_instance_udp(struct m=
ulti_context *m, bool *floated, struct link_socket *sock)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_udp_data(struct mu=
lti_context *m, bool *floated, struct mroute_addr *real, struct link_socket=
 *sock)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct mroute_addr real =3D { 0 };</span><br><span>=
     struct multi_instance *mi =3D NULL;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    real=2Eproto =3D sock-&gt;info=2Epro=
to;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efr=
om=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *ptr =3D BPTR(&amp;m=
-&gt;top=2Ec2=2Ebuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool v2 =3D (op =3D=3D P_DATA_V2) &am=
p;&amp; (m-&gt;top=2Ec2=2Ebuf=2Elen &gt;=3D (1 + 3));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool peer_id_disabled =3D false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* make sure buffer has enough length=
 to read opcode (1 byte) and peer-id (3 bytes) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (v2)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        const uint64_t hv =3D ha=
sh_value(hash, &amp;real);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t *ptr =3D BPTR(=
&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        bool v2 =3D (op =3D=3D P_DAT=
A_V2) &amp;&amp; (m-&gt;top=2Ec2=2Ebuf=2Elen &gt;=3D (1 + 3));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        bool peer_id_disabled =3D =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint3=
2_t peer_id =3D ((uint32_t)ptr[1] &lt;&lt; 16) | ((uint32_t)ptr[2] &lt;&lt;=
 8) | ((uint32_t)ptr[3]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* mak=
e sure buffer has enough length to read opcode (1 byte) and peer-id (3 byte=
s) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (v2)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!peer_id=
_disabled &amp;&amp; (peer_id &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;ins=
tances[peer_id]))</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            uint32_t peer_id =3D ((uint32_t)ptr[1] &=
lt;&lt; 16) | ((uint32_t)ptr[2] &lt;&lt; 8) | ((uint32_t)ptr[3]);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            peer_id_disabled =
=3D (peer_id =3D=3D MAX_PEER_ID);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (!peer_id_disabled &amp;&amp; (peer_id &lt; m-&gt;max_clients) &amp;&=
amp; m-&gt;instances[peer_id])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* Floating on TCP will never be possible, so ensure=
 we only process</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          * UDP clients */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (m-&gt;instances[peer_id]-&gt;context=2Ec2=2Elink_soc=
kets[0]-&gt;info=2Eproto</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                =3D=3D sock-&gt;info=2Eproto)</span><br><span>        =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 /* Floating on TCP will never be possible, so ensure we only process</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                 * UDP clie=
nts */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 if (m-&gt;instances[peer_id]-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=
=2Eproto</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       =3D=3D sock-&gt;info=2Eproto)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    mi =3D m-&gt;instances[peer_id];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    *floated =3D =
!link_socket_actual_match(&amp;mi-&gt;context=2Ec2=2Efrom, &amp;m-&gt;top=
=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           mi =3D m-&gt;instances[peer_id];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                *floated =3D !link_socket_actual_ma=
tch(&amp;mi-&gt;context=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Efrom);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       if (*floated)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       /* reset prefix, since here we are not sure peer is =
the one it claims to be</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                         */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        ungenerate_prefix(mi);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        msg(D_MULTI_MEDIUM=
, &quot;Float requested for peer %&quot; PRIu32 &quot; to %s&quot;, peer_id=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
        mroute_addr_print(&amp;real, &amp;gc));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                if (*floated)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    /* reset prefix, si=
nce here we are not sure peer is the one it claims to be</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                     */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    ungenerate_pre=
fix(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    msg(D_MULTI_MEDIUM, &quot;Float r=
equested for peer %&quot; PRIu32 &quot; to %s&quot;, peer_id,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        mroute_ad=
dr_print(real, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    gc_free(&amp;gc);</span><br><span>               =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
return mi;</span><br><span>             }</span><br><span>         }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!v2 || peer_id_d=
isabled)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi =3D multi_=
get_instance_udp_real(m, &amp;real);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
v2 || peer_id_disabled)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn multi_get_instance_udp_real(m, real);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        /* we have no existing multi instance for this connection */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!mi)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            mi =3D handle_connection_atte=
mpt(m, sock, &amp;real, bucket);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (check_debug_=
level(D_MULTI_DEBUG))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
const char *status =3D mi ? &quot;[ok]&quot; : &quot;[failed]&quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            dmsg(D_MULTI_DEBUG, &quot;GET INST BY=
 REAL: %s %s&quot;, mroute_addr_print(&amp;real, &amp;gc), status);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+struct multi_instance *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+multi_get_create_instance_udp(struct multi_context=
 *m, bool *floated, struct link_socket *sock)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* If the buffer is empty, the packet has no op code and can be=
 neither</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * a (v=
alid) data nor control packet */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt;=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return NULL;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct mroute_addr real =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    real=2Eproto =
=3D sock-&gt;info=2Eproto;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mro=
ute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, =
true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct multi_instance *mi =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (op =3D=3D P_DATA_V1 || op =3D=
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
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2=
b5cfc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1726 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--RfNF/6m1Fi8=--


--===============2277824998130236790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2277824998130236790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2277824998130236790==--

