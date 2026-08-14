Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FDBC5CFDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gjlZ5tLA/GKPIVt5G+fOyYrRtq6qxcW6Ai7RQ5AJubY=; b=T3vH5oRszH16jHVzH3kr4vuSzc
	tM24RdL3Iau1Zlzo1zARmGtOgs84IYCeRQTBXnfeogqTTJ2IgpSTTRwkBnR7Lljj4uphHTZ/2znGM
	0+gv3jaKx+teayUEd5pQCPS4LU4+IUJDNdONI2r3EpDR6Hh1oPCOlbogPc65iSKqA2Xc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wup0c-0007lm-A6;
	Fri, 14 Aug 2026 10:19:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wup0a-0007le-QF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=34YzbDix7NLv3DujM1fFVKbdcHOvSZft8OhD5P7w+dI=; b=YbAGMU6dgTeSXa+HZeGMMJRSOp
 ZcT35IR11Jq8DaH93NkDCTnRWyMc+QUyJKSvlUt2MifeGeAj3r1Zzmla7lzKHIW/cnt/KVZH/Ijfl
 ylNCSJ2kfxHroq+rGcpPo478a1Uyi86fM4y/JZBmG7DRvL56sAZc/xqeIBvpj6jIeXM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=34YzbDix7NLv3DujM1fFVKbdcHOvSZft8OhD5P7w+dI=; b=N
 ifnM54Mg7L1HB8s+5CZ9p+9I2KEOZUJuWP8apNhQ2HjKZmmnNZdnDxNe1lLeFCG9XiujD3eJ+ggO/
 QElDdLBKcHiJYSwQvQjSntu9je2iQtXcY65NTW+JzBaqFvObKEwLFXkvtEYZrrG3QjhEvhyKzZlEI
 SQ5fpdu+xlgmjmKs=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wup0Z-0001BZ-4Q for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:19:28 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso799956f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786702761; x=1787307561; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=34YzbDix7NLv3DujM1fFVKbdcHOvSZft8OhD5P7w+dI=;
 b=TFx7ov5wBacsEAS93PWoQ5jEOZtiCbq2Q6QMmMLucrhEJpsXRWM02DSh3KtkrQpppm
 HeAUxNA5g8BPSs7qj4nH3oZhr1f08P4kYpYRt2fHOSGABw8D7GR3wOPUJGFxBvgblkax
 vXPjFd1ZYl7GS3h0LAgNYpr9kkKLLv5Rr5eI1v/gNPYY7orld3iWOtjLgaYb2NqsAppQ
 Cij4L03t+TVTlB2/wEY6YU+LzOjhMtFdfKVkFpiDsjeQrPfe6aJHqRuYzqjqAZfeMKBD
 I65Ta9unDp+xAm6KLc3mHXmvLjp5bYOkwniuxkLMhNDAht8yeZdLpKF/29SMHrrOb1fK
 5HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786702761; x=1787307561;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=34YzbDix7NLv3DujM1fFVKbdcHOvSZft8OhD5P7w+dI=;
 b=S5k37C7Poue8FxySoGfNoipPndPNIspA1UbwPYJwHraAzwQt5puUgcM/rIqhRje3t+
 PpCR/3qKhADRueu2jbyIUgzgKX77tMZRHauuW7y30oIbEj72bBUbv2HeYrGfOUg9rVX8
 B+dO/9aeMUkQdy3sIzCfQljKuTME6nNWzExzk9ajr1J7lYg+Sfw9Oxxb2sXpXodVCatS
 5WTHq8ih1dnCka5ZpjKezebiywiyT7MHofxGuDDiZYslltcbEMaLSX9aVFy85gNsqAJt
 kFp3OZAxyibA2X8yB8nzDqN9mirrPP/kKj/ZoLtpqUJPfo5d66QUYHiNDXP8mW0UvXuL
 X/Ow==
X-Forwarded-Encrypted: i=1;
 AHgh+Rruiif8aY25q1ya1EfTu/YHTdiT2hdo3Jq/XaCq3ZfrXKG4azXbrPL43HX35K+cZLkRg43vGGoUHAvrDSh9@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxh57W+kz8Dqpczfv6WMSKgpQj1lskDeBpzw19744uatgbUIsm+
 wr3Kv7e1/9XxrAmDyhT7s/lcK+vu/PqMuXMrabDSk1iPPdvCFrmmeVy3dlydp+giUkFKKeKjDhv
 exIMCrnYNp9GtfeheuKMvvHKUzamy75P2I0QYZk8QZKt7jUKNf12Mv+vppAoaWCz29fm9W5nBvC
 x8lfJruQ==
X-Gm-Gg: AR+sD13KosJQIVWsRN9VLMk0L6/sCn2aFM4wtkasBOvxyz8483Gf6hFUOho9cmEmIUW
 uuxhPyH+4auaeBkg63D4a7+4e0ZamRO6ruWvSWs244ToGEMKv+wlIyUc4bLxglwJhHAYPxUkcoF
 6xqK0W+qYxfgdwnkDobVsZhyv4kCoOcg39hlFvlabQHnJdGvY2+KK7qihORr4jjKOzIT6qjEd34
 1xA+4C2YdbC7vVY95QCKENfRjVP/Q5F0BOXBX3GyrKLCOidMVjoW+7waXT/d7w1D6sNIcBToF9H
 LR7AGEd6MmysAxPHWUAoyG0oGygnAsjpyeUBTyKuAx3FNAknf0fJmnBI14EoWIMzHe8haAGqrfk
 oIgcrxm9bXG0Ex1c0iTw0VhT1VL/i7auMlf5evu8SsZoqTp8IXoBth9GvrhGMhhOehA/XnGx22b
 JZ0eDI9gWwWreTlHDxsKKE+w3JZPJRAc3zXgplno58lVa4P/PDrGJmKE36qo8mC7sZKOCuReB0P
 e9CnEc/0uC0c9cJTUobptny7o717zOo8HBFAhVo+hmuKK3LIfaOAsPBECJ6AWSBEzMYosy3drN8
 LsG60KQefxo2WFtEOkSWXhWQhNZy2WJTVhB4fr+qUSUSQeZ0gGU=
X-Received: by 2002:adf:e18b:0:b0:481:5c41:b417 with SMTP id
 ffacd0b85a97d-48160760e33mr6824371f8f.23.1786702760433; 
 Fri, 14 Aug 2026 03:19:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2ccc00sm6625937f8f.35.2026.08.14.03.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:19:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:19:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: 6ff04417a4250b558da06a3b58b5cda697cd5ee3
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7126a77db6cda8796c585fcc9b2c1f04fbc2ef6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wup0Z-0001BZ-4Q
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
Content-Type: multipart/mixed; boundary="===============3083666392737785202=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3083666392737785202==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ePTl4Z4s4BE="; charset=UTF-8

--ePTl4Z4s4BE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1726?usp=3Demail )

Change subject: Split multi_get_create_instance_udp=
 into data and control parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Split multi_get_create_instance_udp into data and control =
parts

This currently leads to a bit of code duplication but this refactori=
ng
will make the follow up patches cleaner and better to understand when
th=
e control channel lookup will be changed to use session ids instead of
IP a=
ddresses=2E

Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
Signed-of=
f-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
726
Message-Id: <20260813184950=2E6709-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg383=
38=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/o=
penvpn/mudp=2Ec
1 file changed, 97 insertions(+), 54 deletions(-)




diff =
--git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 08d79c9=2E=2E632b=
064 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -218,8 =
+218,7 @@
 static struct multi_instance *
 handle_connection_attempt(struct=
 multi_context *m,
                           struct link_socket *sock,
-  =
                        struct mroute_addr *real,
-                        =
  struct hash_bucket *bucket)
+                          struct mroute_addr=
 *real)
 {
     struct hash *hash =3D m->hash;
     struct tls_pre_decrypt_=
state state =3D { 0 };
@@ -250,7 +249,9 @@
             if (mi)
           =
  {
                 const uint64_t hv =3D hash_value(hash, real);
+       =
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
            =
     hash_add_fast(hash, bucket, &mi->real, hv, mi);
+
                 mi-=
>did_real_hash =3D true;
                 multi_assign_peer_id(m, mi);
 
@@=
 -299,6 +300,19 @@
     return NULL;
 }
 
+struct multi_instance *
+multi_g=
et_instance_udp_control(struct multi_context *m, struct link_socket *sock)
=
+{
+    struct mroute_addr real =3D { 0 };
+    real=2Eproto =3D sock->info=
=2Eproto;
+
+    if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2E=
from=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+    {
+        return m=
ulti_get_instance_udp_real(m, &real);
+    }
+
+    return NULL;
+}
 
 /**
=
  * Get a client instance based on real address=2E  If
@@ -306,72 +320,101 =
@@
  * maintaining real address hash table atomicity=2E
  */
 struct multi_=
instance *
-multi_get_create_instance_udp(struct multi_context *m, bool *fl=
oated, struct link_socket *sock)
+multi_get_instance_udp_data(struct multi_=
context *m, bool *floated, struct mroute_addr *real, struct link_socket *so=
ck)
 {
-    struct gc_arena gc =3D gc_new();
-    struct mroute_addr real =
=3D { 0 };
     struct multi_instance *mi =3D NULL;
-    struct hash *hash =
=3D m->hash;
-    real=2Eproto =3D sock->info=2Eproto;
 
-    if (mroute_ex=
tract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=
=2Ec2=2Ebuf=2Elen > 0)
+    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+   =
 uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
+    bool v2 =3D (op =3D=3D P_DAT=
A_V2) && (m->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
+    bool peer_id_disabled=
 =3D false;
+
+    /* make sure buffer has enough length to read opcode (1 =
byte) and peer-id (3 bytes) */
+    if (v2)
     {
-        const uint64_t =
hv =3D hash_value(hash, &real);
-        struct hash_bucket *bucket =3D has=
h_bucket(hash, hv);
-        uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
-  =
      uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
-        bool v2 =3D (op =3D=
=3D P_DATA_V2) && (m->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
-        bool pee=
r_id_disabled =3D false;
+        uint32_t peer_id =3D ((uint32_t)ptr[1] <<=
 16) | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
+        peer_id_disab=
led =3D (peer_id =3D=3D MAX_PEER_ID);
 
-        /* make sure buffer has en=
ough length to read opcode (1 byte) and peer-id (3 bytes) */
-        if (v=
2)
+        if (!peer_id_disabled && (peer_id < m->max_clients) && (m->inst=
ances[peer_id]))
         {
-            uint32_t peer_id =3D ((uint32_t)pt=
r[1] << 16) | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
-            pe=
er_id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);
-
-            if (!peer_i=
d_disabled && (peer_id < m->max_clients) && m->instances[peer_id])
+       =
     /* Floating on TCP will never be possible, so ensure we only process
+=
             * UDP clients */
+            if (m->instances[peer_id]->conte=
xt=2Ec2=2Elink_sockets[0]->info=2Eproto
+                =3D=3D sock->info=
=2Eproto)
             {
-                /* Floating on TCP will never be =
possible, so ensure we only process
-                 * UDP clients */
-   =
             if (m->instances[peer_id]->context=2Ec2=2Elink_sockets[0]->inf=
o=2Eproto
-                    =3D=3D sock->info=2Eproto)
-                =
{
-                    mi =3D m->instances[peer_id];
-                    *=
floated =3D !link_socket_actual_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec=
2=2Efrom);
+                mi =3D m->instances[peer_id];
+                =
*floated =3D !link_socket_actual_match(&mi->context=2Ec2=2Efrom, &m->top=2E=
c2=2Efrom);
 
-                    if (*floated)
-                    {
-  =
                      /* reset prefix, since here we are not sure peer is t=
he one it claims to be
-                         */
-                      =
  ungenerate_prefix(mi);
-                        msg(D_MULTI_MEDIUM, "Floa=
t requested for peer %" PRIu32 " to %s", peer_id,
-                        =
    mroute_addr_print(&real, &gc));
-                    }
+               =
 if (*floated)
+                {
+                    /* reset prefix, sin=
ce here we are not sure peer is the one it claims to be
+                  =
   */
+                    ungenerate_prefix(mi);
+                    stru=
ct gc_arena gc =3D gc_new();
+                    msg(D_MULTI_MEDIUM, "Floa=
t requested for peer %" PRIu32 " to %s", peer_id,
+                        =
mroute_addr_print(real, &gc));
+                    gc_free(&gc);
         =
        }
+                return mi;
             }
         }
-        if=
 (!v2 || peer_id_disabled)
-        {
-            mi =3D multi_get_instanc=
e_udp_real(m, &real);
-        }
+    }
+    if (!v2 || peer_id_disabled)
+=
    {
+        return multi_get_instance_udp_real(m, real);
+    }
+    ret=
urn NULL;
+}
 
-        /* we have no existing multi instance for this conn=
ection */
-        if (!mi)
-        {
-            mi =3D handle_connectio=
n_attempt(m, sock, &real, bucket);
-        }
-
-#ifdef ENABLE_DEBUG
-     =
   if (check_debug_level(D_MULTI_DEBUG))
-        {
-            const char=
 *status =3D mi ? "[ok]" : "[failed]";
-
-            dmsg(D_MULTI_DEBUG, "=
GET INST BY REAL: %s %s", mroute_addr_print(&real, &gc), status);
-        =
}
-#endif
+struct multi_instance *
+multi_get_create_instance_udp(struct mu=
lti_context *m, bool *floated, struct link_socket *sock)
+{
+    /* If the =
buffer is empty, the packet has no op code and can be neither
+     * a (va=
lid) data nor control packet */
+    if (m->top=2Ec2=2Ebuf=2Elen <=3D 0)
+ =
   {
+        return NULL;
     }
 
-    gc_free(&gc);
+    uint8_t *ptr =
=3D BPTR(&m->top=2Ec2=2Ebuf);
+    uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;=

+
+    struct mroute_addr real =3D { 0 };
+    real=2Eproto =3D sock->info=
=2Eproto;
+
+    if (!mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=
=2Efrom=2Edest, true))
+    {
+        return NULL;
+    }
+
+    struct mu=
lti_instance *mi =3D NULL;
+    if (op =3D=3D P_DATA_V1 || op =3D=3D P_DATA=
_V2)
+    {
+        mi =3D multi_get_instance_udp_data(m, floated, &real, =
sock);
+    }
+    else
+    {
+        mi =3D multi_get_instance_udp_contr=
ol(m, sock);
+
+        /* we have no existing multi instance for this conn=
ection, control
+         * packets can create a session=2E Data packets ca=
nnot */
+        if (!mi)
+        {
+            mi =3D handle_connection_=
attempt(m, sock, &real);
+        }
+    }
+
+#ifdef ENABLE_DEBUG
+    if (=
check_debug_level(D_MULTI_DEBUG))
+    {
+        struct gc_arena gc =3D gc=
_new();
+        const char *status =3D mi ? "[ok]" : "[failed]";
+
+      =
  dmsg(D_MULTI_DEBUG, "GET INST BY REAL/SID: %s %s", mroute_addr_print(&rea=
l, &gc), status);
+        gc_free(&gc);
+    }
+#endif
+
     ASSERT(!(mi =
&& mi->halt));
     return mi;
 }

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1726?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: merged
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

--ePTl4Z4s4BE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1726?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Split multi_get_create_instance_udp into d=
ata and control parts<br><br>This currently leads to a bit of code duplicat=
ion but this refactoring<br>will make the follow up patches cleaner and bet=
ter to understand when<br>the control channel lookup will be changed to use=
 session ids instead of<br>IP addresses=2E<br><br>Change-Id: I8e9923b51b77f=
184c7d49d697004cb02d2b5cfc3<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<b=
r>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726<br>Message-Id=
: &lt;20260813184950=2E6709-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38338=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpn/mudp=2Ec<br>1 file changed, 97 insertions(+), 54 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec</span><br><span>index 08d79c9=2E=2E632b064 100644</span><br><span>--- =
a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br=
><span>@@ -218,8 +218,7 @@</span><br><span> static struct multi_instance *<=
/span><br><span> handle_connection_attempt(struct multi_context *m,</span><=
br><span>                           struct link_socket *sock,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                          struct mr=
oute_addr *real,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                     struct hash_bucket *bucket)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                          struct mroute_addr *=
real)</span><br><span> {</span><br><span>     struct hash *hash =3D m-&gt;h=
ash;</span><br><span>     struct tls_pre_decrypt_state state =3D { 0 };</sp=
an><br><span>@@ -250,7 +249,9 @@</span><br><span>             if (mi)</span=
><br><span>             {</span><br><span>                 const uint64_t h=
v =3D hash_value(hash, real);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                struct hash_bucket *bucket =3D hash_bucket(hash, =
hv);</span><br><span>                 hash_add_fast(hash, bucket, &amp;mi-&=
gt;real, hv, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>                 mi-&gt;did_real_hash =3D true;</span><br><s=
pan>                 multi_assign_peer_id(m, mi);</span><br><span> </span><=
br><span>@@ -299,6 +300,19 @@</span><br><span>     return NULL;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+struct multi_instance *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+multi_get_instance_udp_control(struct multi_context *m, struct li=
nk_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mroute_add=
r real =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=
=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return multi_get_instance_udp_rea=
l(m, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> /*=
*</span><br><span>  * Get a client instance based on real address=2E  If</s=
pan><br><span>@@ -306,72 +320,101 @@</span><br><span>  * maintaining real a=
ddress hash table atomicity=2E</span><br><span>  */</span><br><span> struct=
 multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mult=
i_get_create_instance_udp(struct multi_context *m, bool *floated, struct li=
nk_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mul=
ti_get_instance_udp_data(struct multi_context *m, bool *floated, struct mro=
ute_addr *real, struct link_socket *sock)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_add=
r real =3D { 0 };</span><br><span>     struct multi_instance *mi =3D NULL;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =
=3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
al=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (mroute_extract_openvpn_sockaddr(&=
amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec=
2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D ptr[0] &gt;&gt; P_OP=
CODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 v2 =3D (op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top=2Ec2=2Ebuf=2Elen &gt;=
=3D (1 + 3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol peer_id_disabled =3D false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* m=
ake sure buffer has enough length to read opcode (1 byte) and peer-id (3 by=
tes) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (v2)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        const uint64_t hv =3D hash_value(hash, &amp;real);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        struct hash_bucket *bucket =
=3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        uint8_t op =3D ptr[0] &gt;=
&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       bool v2 =3D (op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top=2Ec2=2Ebuf=
=2Elen &gt;=3D (1 + 3));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        bool peer_id_disabled =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uint32_t peer_id =3D ((uint32_t)ptr[1] &lt;=
&lt; 16) | ((uint32_t)ptr[2] &lt;&lt; 8) | ((uint32_t)ptr[3]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        peer_id_disabled =3D (pe=
er_id =3D=3D MAX_PEER_ID);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        /* make sure buffer has enough length to rea=
d opcode (1 byte) and peer-id (3 bytes) */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (v2)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!peer_id_disabled &amp;&amp; (peer_id &lt; m-&=
gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            uin=
t32_t peer_id =3D ((uint32_t)ptr[1] &lt;&lt; 16) | ((uint32_t)ptr[2] &lt;&l=
t; 8) | ((uint32_t)ptr[3]);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (!peer_id_disabled &amp;&amp; (pee=
r_id &lt; m-&gt;max_clients) &amp;&amp; m-&gt;instances[peer_id])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /* Floating on TC=
P will never be possible, so ensure we only process</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * UDP clients */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (m-&gt;instances=
[peer_id]-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                =3D=3D sock-&gt;i=
nfo=2Eproto)</span><br><span>             {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                /* Floating on TCP will never be poss=
ible, so ensure we only process</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                 * UDP clients */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                if (m-&gt;instances[peer_id]-&gt;cont=
ext=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    =3D=3D sock-&gt;info=2Eproto)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi =3D m-=
&gt;instances[peer_id];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    *floated =3D !link_socket_actual_match(&amp;mi-&gt;co=
ntext=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                mi =3D m-&gt;instances[peer_id]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                *f=
loated =3D !link_socket_actual_match(&amp;mi-&gt;context=2Ec2=2Efrom, &amp;=
m-&gt;top=2Ec2=2Efrom);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    if (*floated)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        /* reset prefix, si=
nce here we are not sure peer is the one it claims to be</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                         */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        ungenerate=
_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               msg(D_MULTI_MEDIUM, &quot;Float requested for peer %&quot; P=
RIu32 &quot; to %s&quot;, peer_id,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                            mroute_addr_print(&amp;real, &amp;=
gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  if (*floated)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              /* reset prefix, since here we are not sure peer is the one i=
t claims to be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   ungenerate_prefix(mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
msg(D_MULTI_MEDIUM, &quot;Float requested for peer %&quot; PRIu32 &quot; to=
 %s&quot;, peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        mroute_addr_print(real, &amp;gc));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    gc_free(&amp;gc)=
;</span><br><span>                 }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                return mi;</span><br><span>             }<=
/span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (!v2 || peer_id_disabled)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            mi =3D multi_get_instance_udp_real(m, &amp;real);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!v2 || peer_id_disabled)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return multi_get_instance_udp_real(m, real);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        /* we have no existing multi i=
nstance for this connection */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (!mi)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    mi =3D handle_connection_attempt(m, sock, &amp;real, bucket);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (check_debug_level(D_MULTI_DEBUG))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            const char *status =3D mi ? &quot;[ok]&quo=
t; : &quot;[failed]&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg=
(D_MULTI_DEBUG, &quot;GET INST BY REAL: %s %s&quot;, mroute_addr_print(&amp=
;real, &amp;gc), status);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_create_=
instance_udp(struct multi_context *m, bool *floated, struct link_socket *so=
ck)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* If the buffer is empty, the=
 packet has no op code and can be neither</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * a (valid) data nor control packet */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;top=2Ec2=2Ebuf=
=2Elen &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return N=
ULL;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Eb=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =
=3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct mroute_addr real =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!mroute_extract_openvpn_sockaddr(&amp;real, &a=
mp;m-&gt;top=2Ec2=2Efrom=2Edest, true))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance =
*mi =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (op =3D=3D P_DATA_V1 || op =3D=3D P_DATA_V2)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        mi =3D multi_get_instance_udp_data(m, floated, &amp;rea=
l, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        mi =3D multi_get_instance_udp_control(m, =
sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* we have no existing m=
ulti instance for this connection, control</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * packets can create a session=2E Data pack=
ets cannot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi =3D =
handle_connection_attempt(m, sock, &amp;real);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DE=
BUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (check_de=
bug_level(D_MULTI_DEBUG))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const char *status =3D mi ? &quot;[ok]&quot; : &quot;[=
failed]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_MULTI_DEB=
UG, &quot;GET INST BY REAL/SID: %s %s&quot;, mroute_addr_print(&amp;real, &=
amp;gc), status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     A=
SSERT(!(mi &amp;&amp; mi-&gt;halt));</span><br><span>     return mi;</span>=
<br><span> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">change 1726</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e9923b51=
b77f184c7d49d697004cb02d2b5cfc3 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1726 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--ePTl4Z4s4BE=--


--===============3083666392737785202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3083666392737785202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3083666392737785202==--

