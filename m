Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6200FC55160
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FWi1XLf9OTr+cnGRRffj/SajpVp1eUdCPSAgaX6nw44=; b=DkJa/9g1PsFkLS/hqIPYSrAfwl
	HwVyVeU7dWE5BwcKjbG2OhDt2YFCtOUT/iyzWNx5lE6akGGMtSlZg9LUerDgWm6ImdEDzzzYPiKWS
	MPt5N92cevjBV6J01mHwn1fSaM0bYRyeEa7c4lJ+lLqL4TQ7MY8qgOMgAnVaFHF02zCg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpPUb-00067C-Be;
	Thu, 30 Jul 2026 12:04:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpPUZ-00066z-L1
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3B9FkgihNzAleZci7lhNCun/3crqwpgZRGva/NE2Etg=; b=XK/9F/V+2BE1UK4ITn8GrlOyxF
 T7M4WjXZZT1qv92lwUHuFM2bWFHkyS3LIJCNfE65EkAuHfdPT2X/gWQ1aY2f9vHd6UaPklIQiu16t
 GGBFn15hUvV8pNcvIwsP0Vdk7vUFXAk9drizubbKE1b8+cllSPv+4UgEhDvj4RkshtTE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3B9FkgihNzAleZci7lhNCun/3crqwpgZRGva/NE2Etg=; b=X
 YgXGIePfmoPQOSskKh9jziLN2cOAFkoZK6O/SkESF0L00GO0pXjLoeLin9r+yPrz6AkpKUN8EIGr4
 tmf+G41kDWAf940pMKHiNxl1EaGTAgc4COm1f0K3dh/VA7sMH3lYeeGtGGU+o5I+nwxPYUvk2MppQ
 zO0yd4nCPgz9vOOM=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpPUY-0008RI-FQ for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:04 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so12205065e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785413036; x=1786017836; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3B9FkgihNzAleZci7lhNCun/3crqwpgZRGva/NE2Etg=;
 b=gaPcBN5XjZLIO0BB2HFU2PPMHE4fZTud5EjJli86j7jDA3gjNeJXbXwQLlWwgNOqrw
 MWxWTQuokbvnLtOntyuU/UaFE5oXttxiVJW0HmsGH/skNeVISCYtdUpsp8aVcM6HWPxF
 ucKGJ//YSXDv9tZJVLRiTrsX00ghf8mUqKkL4C2fSja6g+gpev9zSOq22QXg2d2SRff9
 hyYI/VrKRZt9aqsVtW/Yu6a8Mjx0VSruE607CX89LfYm5ggZt9cOpJKV+Nz0XOckNVAp
 Hx1ibmor+UoQQxmtKgUhwxx4nJQGI5DzC1uJYAhIDBwC1IpbIqhnBCNI+CFaLbQsl6hA
 +Urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785413036; x=1786017836;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3B9FkgihNzAleZci7lhNCun/3crqwpgZRGva/NE2Etg=;
 b=HUHwPl2PBpU8+s9PZM7m1BZ87gMKmAPTQ/AegqtWDzdCL/T+CqHSbs8dJLgLDpFNvH
 h4kKQgvUcFEcGJk+AF12W91W4KFR/s8by6ZrIfYOUeFavqWBd93LI1Omeqz+RFw+/F1e
 CMZuyqgJg1c1KN088JTucaeAjKvhmDQl/ARbCk5QNkA3EiGJ9mTKxtqOIvwOQUz4xA5H
 2mp+aQDAJUWXT+H7vv+Y/CbD7EA/POrcvChowCMQfq6exTHjiukrSz8sCODm0RjO75GZ
 Lbs4YvlqJ3QPSpKiBOGNNci0RZXA5iKuJjij0IAXG60egYxAr1HB6ojfXIP+WiaHNrYb
 NsRg==
X-Gm-Message-State: AOJu0YxUiT8iX+bbndwwP1iPNs4YDSlxKaGCKna5+LlG5CLNNXOYiRMj
 XSLiK3fiPX53NG4jGpQVVty/okTf2x+G9Eo0lEN2vin1mYld54bKQ8rbVydvosHg7tWh6n6BRC6
 5PaeOqiiuGUC3L9/QTQc611xFKsMJIMkV7mL56PvKh4Boz7ZhV6PgSMhyOgZCvfKm6Wrm+vxWSU
 Z3X2VbQg==
X-Gm-Gg: AR+sD11PoU3xiDO6cIDt3qopY9HGmZ9F2CJ8v2pE+GvybepZXhLbXP597SuOotAyVzS
 NzFL8yCZg+LrF3aUhLq8re9hhSnR5q9JQdL8XkJZKdXF4uUHl3F/tVXlzp+6qFG5VslA3JYly9/
 nhCXayR/fk45UoMn9kqo6MWwDrEs3G9N1G2gZSL/K4m7BEbBAVDtHJ01JZ+cQFLhvGWN8TVbo4D
 gyYkbry5x38ROyH+F75Ja9lTyQFXEEMdYwF25USzEPN7Vx7KIMTtwglZOkNsKxYOX7UEwFsDsBH
 x+V1eznfbe3xvap6ti32YVc2HKGsZSQCmdoyvhXff5vorCECNhi4Td8ZEKG/lmJGOrtZppBjM3g
 bik+6uCIL2Ljref65BRjCq7X5F0u/Angs4vB3FIirUhCyr9mpFYXD87MrsOXkworUTAc25pcodf
 ugHiT8ivE4jzPNUuJpi+cfSY6Ryu0y/d8hzOOnZ3TeFpjcvDa5updf09G1ZQcapA4Xhcxpb2sqz
 JR5J9tEKdS97jOx97xK1X6CFW+s0UtUkZDhIDmxWHcEcVKqBeevn1voDD0uSkq+B+xnSyA9UEZ/
 reQNLCq3e37b9wvpFOBw9//rG6EfIDkNYydeCjCNErRtQ0C092c=
X-Received: by 2002:a05:600c:34c3:b0:497:ff80:538f with SMTP id
 5b1f17b1804b1-49800eac133mr30200135e9.29.1785413035699; 
 Thu, 30 Jul 2026 05:03:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d6e5bsm5864079f8f.3.2026.07.30.05.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:03:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 12:03:44 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: 60ede402287691d88b34f485f97a5c557c33bd0e
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb7c51057fa26c8d008de6b1867d489495283bc8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpPUY-0008RI-FQ
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7731073159917752974=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7731073159917752974==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i/Koy45Sn0E="; charset=UTF-8

--i/Koy45Sn0E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1726?usp=3Demail

to look at the new patch set (#16)=
=2E

The change is no longer submittable: checks~ChecksSubmitRule is unsati=
sfied now=2E


Change subject: Split multi_get_create_instance_udp into dat=
a and control parts
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
---
M src/openvpn/mudp=2Ec
1 file changed, =
97 insertions(+), 54 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/26/1726/16

diff --git a/src/openvpn/mudp=2Ec b=
/src/openvpn/mudp=2Ec
index 596a458=2E=2Ef176655 100644
--- a/src/openvpn/m=
udp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -204,8 +204,7 @@
 static struct multi=
_instance *
 handle_connection_attempt(struct multi_context *m,
           =
                struct link_socket *sock,
-                          struct=
 mroute_addr *real,
-                          struct hash_bucket *bucket)
=
+                          struct mroute_addr *real)
 {
     struct hash *h=
ash =3D m->hash;
     struct tls_pre_decrypt_state state =3D { 0 };
@@ -236=
,7 +235,9 @@
             if (mi)
             {
                 const uin=
t64_t hv =3D hash_value(hash, real);
+                struct hash_bucket *b=
ucket =3D hash_bucket(hash, hv);
                 hash_add_fast(hash, bucke=
t, &mi->real, hv, mi);
+
                 mi->did_real_hash =3D true;
     =
            multi_assign_peer_id(m, mi);
 
@@ -285,6 +286,19 @@
     return=
 NULL;
 }
 
+struct multi_instance *
+multi_get_instance_udp_control(struct=
 multi_context *m, struct link_socket *sock)
+{
+    struct mroute_addr rea=
l =3D { 0 };
+    real=2Eproto =3D sock->info=2Eproto;
+
+    if (mroute_ex=
tract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=
=2Ec2=2Ebuf=2Elen > 0)
+    {
+        return multi_get_instance_udp_real(m=
, &real);
+    }
+
+    return NULL;
+}
 
 /**
  * Get a client instance ba=
sed on real address=2E  If
@@ -292,72 +306,101 @@
  * maintaining real addr=
ess hash table atomicity=2E
  */
 struct multi_instance *
-multi_get_create=
_instance_udp(struct multi_context *m, bool *floated, struct link_socket *s=
ock)
+multi_get_instance_udp_data(struct multi_context *m, bool *floated, s=
truct mroute_addr *real, struct link_socket *sock)
 {
-    struct gc_arena =
gc =3D gc_new();
-    struct mroute_addr real =3D { 0 };
     struct multi_=
instance *mi =3D NULL;
-    struct hash *hash =3D m->hash;
-    real=2Eprot=
o =3D sock->info=2Eproto;
 
-    if (mroute_extract_openvpn_sockaddr(&real,=
 &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+    uin=
t8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    uint8_t op =3D ptr[0] >> P_OPC=
ODE_SHIFT;
+    bool v2 =3D (op =3D=3D P_DATA_V2) && (m->top=2Ec2=2Ebuf=2El=
en >=3D (1 + 3));
+    bool peer_id_disabled =3D false;
+
+    /* make sure=
 buffer has enough length to read opcode (1 byte) and peer-id (3 bytes) */
=
+    if (v2)
     {
-        const uint64_t hv =3D hash_value(hash, &real);=

-        struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-        ui=
nt8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
-        uint8_t op =3D ptr[0] >> =
P_OPCODE_SHIFT;
-        bool v2 =3D (op =3D=3D P_DATA_V2) && (m->top=2Ec2=
=2Ebuf=2Elen >=3D (1 + 3));
-        bool peer_id_disabled =3D false;
+    =
    uint32_t peer_id =3D ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2] << 8)=
 | ((uint32_t)ptr[3]);
+        peer_id_disabled =3D (peer_id =3D=3D MAX_PE=
ER_ID);
 
-        /* make sure buffer has enough length to read opcode (1 =
byte) and peer-id (3 bytes) */
-        if (v2)
+        if (!peer_id_disab=
led && (peer_id < m->max_clients) && (m->instances[peer_id]))
         {
- =
           uint32_t peer_id =3D ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2=
] << 8) | ((uint32_t)ptr[3]);
-            peer_id_disabled =3D (peer_id =
=3D=3D MAX_PEER_ID);
-
-            if (!peer_id_disabled && (peer_id < m->=
max_clients) && m->instances[peer_id])
+            /* Floating on TCP will=
 never be possible, so ensure we only process
+             * UDP clients *=
/
+            if (m->instances[peer_id]->context=2Ec2=2Elink_sockets[0]->i=
nfo=2Eproto
+                =3D=3D sock->info=2Eproto)
             {
-   =
             /* Floating on TCP will never be possible, so ensure we only p=
rocess
-                 * UDP clients */
-                if (m->instances=
[peer_id]->context=2Ec2=2Elink_sockets[0]->info=2Eproto
-                  =
  =3D=3D sock->info=2Eproto)
-                {
-                    mi =3D=
 m->instances[peer_id];
-                    *floated =3D !link_socket_actu=
al_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=2Efrom);
+                m=
i =3D m->instances[peer_id];
+                *floated =3D !link_socket_act=
ual_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=2Efrom);
 
-              =
      if (*floated)
-                    {
-                        /* rese=
t prefix, since here we are not sure peer is the one it claims to be
-     =
                    */
-                        ungenerate_prefix(mi);
-   =
                     msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu3=
2 " to %s", peer_id,
-                            mroute_addr_print(&real, =
&gc));
-                    }
+                if (*floated)
+             =
   {
+                    /* reset prefix, since here we are not sure peer =
is the one it claims to be
+                     */
+                    un=
generate_prefix(mi);
+                    struct gc_arena gc =3D gc_new();
=
+                    msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu3=
2 " to %s", peer_id,
+                        mroute_addr_print(real, &gc))=
;
+                    gc_free(&gc);
                 }
+                re=
turn mi;
             }
         }
-        if (!v2 || peer_id_disabled)
- =
       {
-            mi =3D multi_get_instance_udp_real(m, &real);
-      =
  }
+    }
+    if (!v2 || peer_id_disabled)
+    {
+        return multi_g=
et_instance_udp_real(m, real);
+    }
+    return NULL;
+}
 
-        /* we=
 have no existing multi instance for this connection */
-        if (!mi)
-=
        {
-            mi =3D handle_connection_attempt(m, sock, &real, buc=
ket);
-        }
-
-#ifdef ENABLE_DEBUG
-        if (check_debug_level(D_MU=
LTI_DEBUG))
-        {
-            const char *status =3D mi ? "[ok]" : "[=
failed]";
-
-            dmsg(D_MULTI_DEBUG, "GET INST BY REAL: %s %s", mro=
ute_addr_print(&real, &gc), status);
-        }
-#endif
+struct multi_insta=
nce *
+multi_get_create_instance_udp(struct multi_context *m, bool *floated=
, struct link_socket *sock)
+{
+    /* If the buffer is empty, the packet h=
as no op code and can be neither
+     * a (valid) data nor control packet =
*/
+    if (m->top=2Ec2=2Ebuf=2Elen <=3D 0)
+    {
+        return NULL;
  =
   }
 
-    gc_free(&gc);
+    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+=
    uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
+
+    struct mroute_addr real=
 =3D { 0 };
+    real=2Eproto =3D sock->info=2Eproto;
+
+    if (!mroute_ex=
tract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true))
+    {
+  =
      return NULL;
+    }
+
+    struct multi_instance *mi =3D NULL;
+    i=
f (op =3D=3D P_DATA_V1 || op =3D=3D P_DATA_V2)
+    {
+        mi =3D multi=
_get_instance_udp_data(m, floated, &real, sock);
+    }
+    else
+    {
+ =
       mi =3D multi_get_instance_udp_control(m, sock);
+
+        /* we hav=
e no existing multi instance for this connection, control
+         * packe=
ts can create a session=2E Data packets cannot */
+        if (!mi)
+      =
  {
+            mi =3D handle_connection_attempt(m, sock, &real);
+       =
 }
+    }
+
+#ifdef ENABLE_DEBUG
+    if (check_debug_level(D_MULTI_DEBUG))=

+    {
+        struct gc_arena gc =3D gc_new();
+        const char *stat=
us =3D mi ? "[ok]" : "[failed]";
+
+        dmsg(D_MULTI_DEBUG, "GET INST B=
Y REAL/SID: %s %s", mroute_addr_print(&real, &gc), status);
+        gc_fre=
e(&gc);
+    }
+#endif
+
     ASSERT(!(mi && mi->halt));
     return mi;
 }=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e9923b51b77f1=
84c7d49d697004cb02d2b5cfc3
Gerrit-Change-Number: 1726
Gerrit-PatchSet: 16
G=
errit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--i/Koy45Sn0E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #16</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><p>The change is n=
o longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Split multi_get_create_instance_udp into data and control parts<b=
r><br>This currently leads to a bit of code duplication but this refactorin=
g<br>will make the follow up patches cleaner and better to understand when<=
br>the control channel lookup will be changed to use session ids instead of=
<br>IP addresses=2E<br><br>Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5=
cfc3<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M =
src/openvpn/mudp=2Ec<br>1 file changed, 97 insertions(+), 54 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/26/1726/16</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/=
openvpn/mudp=2Ec</span><br><span>index 596a458=2E=2Ef176655 100644</span><b=
r><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=
=2Ec</span><br><span>@@ -204,8 +204,7 @@</span><br><span> static struct mul=
ti_instance *</span><br><span> handle_connection_attempt(struct multi_conte=
xt *m,</span><br><span>                           struct link_socket *sock,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
     struct mroute_addr *real,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                          struct hash_bucket *bucket)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                          struct=
 mroute_addr *real)</span><br><span> {</span><br><span>     struct hash *ha=
sh =3D m-&gt;hash;</span><br><span>     struct tls_pre_decrypt_state state =
=3D { 0 };</span><br><span>@@ -236,7 +235,9 @@</span><br><span>            =
 if (mi)</span><br><span>             {</span><br><span>                 co=
nst uint64_t hv =3D hash_value(hash, real);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                struct hash_bucket *bucket =3D hash=
_bucket(hash, hv);</span><br><span>                 hash_add_fast(hash, buc=
ket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>                 mi-&gt;did_real_hash =3D true=
;</span><br><span>                 multi_assign_peer_id(m, mi);</span><br><=
span> </span><br><span>@@ -285,6 +286,19 @@</span><br><span>     return NUL=
L;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+struct multi_instance *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+multi_get_instance_udp_control(struct multi_context=
 *m, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct mroute_addr real =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-=
&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt=
; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return multi_get_inst=
ance_udp_real(m, &amp;real);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><=
br><span> /**</span><br><span>  * Get a client instance based on real addre=
ss=2E  If</span><br><span>@@ -292,72 +306,101 @@</span><br><span>  * mainta=
ining real address hash table atomicity=2E</span><br><span>  */</span><br><=
span> struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-multi_get_create_instance_udp(struct multi_context *m, bool *floate=
d, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+multi_get_instance_udp_data(struct multi_context *m, bool *floated=
, struct mroute_addr *real, struct link_socket *sock)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct mroute_addr real =3D { 0 };</span><br><span>     struct multi_instance *=
mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mroute_extract_openv=
pn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; =
m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D ptr[0] =
&gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool v2 =3D (op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top=2Ec2=2Ebuf=
=2Elen &gt;=3D (1 + 3));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool peer_id_disabled =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* make sure buffer has enough length to read opcode (1 byte) and pe=
er-id (3 bytes) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (v2)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        const uint64_t hv =3D hash_value(hash, &amp;real);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct hash_bucket=
 *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t op =3D pt=
r[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        bool v2 =3D (op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top=2Ec=
2=2Ebuf=2Elen &gt;=3D (1 + 3));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        bool peer_id_disabled =3D false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uint32_t peer_id =3D ((uint32_t)ptr[=
1] &lt;&lt; 16) | ((uint32_t)ptr[2] &lt;&lt; 8) | ((uint32_t)ptr[3]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        peer_id_disabled =
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
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (check_debug_level(D_MULTI_DEBUG))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            const char *status =3D mi ? =
&quot;[ok]&quot; : &quot;[failed]&quot;;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          dmsg(D_MULTI_DEBUG, &quot;GET INST BY REAL: %s %s&quot;, mroute_a=
ddr_print(&amp;real, &amp;gc), status);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct =
multi_instance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mul=
ti_get_create_instance_udp(struct multi_context *m, bool *floated, struct l=
ink_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If the buffer=
 is empty, the packet has no op code and can be neither</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * a (valid) data nor control packe=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;t=
op=2Ec2=2Ebuf=2Elen &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return NULL;</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *ptr =3D BPTR(&amp;m-&gt=
;top=2Ec2=2Ebuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct mroute_addr real =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    real=2Eproto =3D sock-&gt;info=2Eproto;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!mroute_extract_openvpn_sockaddr(=
&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct m=
ulti_instance *mi =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (op =3D=3D P_DATA_V1 || op =3D=3D P_DATA_V2)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        mi =3D multi_get_instance_udp_data(m, flo=
ated, &amp;real, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        mi =3D multi_get_instance_u=
dp_control(m, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* we have=
 no existing multi instance for this connection, control</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * packets can create a sessio=
n=2E Data packets cannot */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mi =3D handle_connection_attempt(m, sock, &amp;real);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (check_debug_level(D_MULTI_DEBUG))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const char *status =3D mi ? &quot;[ok]&q=
uot; : &quot;[failed]&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dm=
sg(D_MULTI_DEBUG, &quot;GET INST BY REAL/SID: %s %s&quot;, mroute_addr_prin=
t(&amp;real, &amp;gc), status);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     ASSERT(!(mi &amp;&amp; mi-&gt;halt));</span><br><span>     ret=
urn mi;</span><br><span> }</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">c=
hange 1726</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1726 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--i/Koy45Sn0E=--


--===============7731073159917752974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7731073159917752974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7731073159917752974==--

