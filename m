Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B133C531FA
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sx1MRrl4/bH2ow6+Q9hqh2XlpW7stYgbXV5JjvLgej4=; b=gzS67rIH6B7ItAOuF/4I3hJeO+
	HAGykEcjAAGo7GVJ/chfx75A49rAEeSWhqMGwnv5KNSaf81ydXUmKGywHsKy4UtRs8XvWLYvplaH8
	8cShyZJOLwG9TCbC/FBQHfiU3chAW0j9rCurOSI+2gtGYmx/4RB5t18/XilWWtqVk+tE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmw1k-0002yn-FB;
	Thu, 23 Jul 2026 16:12:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmw1b-0002yR-89
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 16:11:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=H1NEV3KNT6xmX0EHSbokYml5CsRwr5XvXlfenYHFKwA=; b=fW6As/g47E6pnUPTGF9BJhDZhi
 vo3kQ5at8h1ibYHEqLZ2dU/d+U70d6AKR0x1Y+fGcH23W0GONhFauPmMrAPUwOG/ZCIhF+EI+1VdD
 gA4JlcFiHMLSboAgmcBgWDMbBCM2m0Ani7wkSSelnWAd4HUV9Eh6cVXuX7+twhMiKrN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=H1NEV3KNT6xmX0EHSbokYml5CsRwr5XvXlfenYHFKwA=; b=V
 g9ZuOTVzbBGkUeMST8N4jKxkc3q8k6EESQ/LXQfVslrPxmKL1ZsGqBszh8n6QHfFhfy695qAXGerF
 4UKT+iSaC2U2p52lL3VMCpB5dNNZVwc7naSYN/VS+hUGKLTiTxUUhpSgJ9U/t4uvnWElCVruXFEYf
 fW6YA53yYOE4SZlM=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmw1a-0002tG-4S for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 16:11:55 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so6495765e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784823107; x=1785427907; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H1NEV3KNT6xmX0EHSbokYml5CsRwr5XvXlfenYHFKwA=;
 b=MK0MqQQi9wFm10rgeY9Ns6/FCeFEeFziNCxYW3jCQwDL6W1hGlgTN0V7Yjvj6AnMmx
 41MtoMzhcvGSLD1kpu2lanp0IP4OjxUb3/pvYshIounEWjFxFUG1vA9mjDkaMhosPPrk
 RL8PrVLpP+Iwp57aNyR+giJLrNiIquCRisjBijiwXk8ons473N7mazDrduO5d5kaTsqn
 U8TjL5p2IXksujS2rfKwl1C8nlvOgwF+m3hE8z4LNB1EFj59WQX/6ve9O7BOv5C+VBUW
 t18TFSfyr9ALgYbS4hVM3dvhsYGR933Fqxyj1I/21HHqI+nCc3KJKkYZMpPT1fAyUOQv
 F5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784823107; x=1785427907;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=H1NEV3KNT6xmX0EHSbokYml5CsRwr5XvXlfenYHFKwA=;
 b=UAzZvZT0idpPaMJP79vwkECE7Kuo/v/n5dGJlpgkjX6kfvMJopxCpPCj6GM4SCwN/2
 pQi01iR+nS7AOB/luc5u96Im1hiSyuESIT+fqDaiwieA+T87KkZBnspGhz2oJTSxP1pw
 58fK3xEiLPS+VZ2mHIRsuanqxKVfR9ZqEyVTAotswLe84gsMeeg2Z6YfnIbtfnF2TtTA
 k9/5bpzDswWfx4LEk37cZTH1igmLZUDCysO1sCQmGj5ZTi79tIPhE3df7cqWP3f2km9X
 HF1QMbQJOf3r0va0eP3tP07OT+AHWUUGXu284iRpmGhBixxhzxFqpZWtWvioFyLY2goT
 d9jg==
X-Gm-Message-State: AOJu0Yw7s5nekVlU1ErbPNTJaRN96qdJPQKz0YVxZfZBtvAmDo8YZSTC
 752e/YsB4c5L+mEzwfqnB+f/8YcQT1/OGWvAxlzaCLb20giE1tVtsbztZNLDZRHO2S8NhuKLV1D
 Dbrc3wiUjWzz9uDRY3HIKePDb//cZJKk3c2pBbUf/qiopcs45fkPLf7/2fakrpapRLM1rLfFJ6N
 uC2KtFnw==
X-Gm-Gg: AR+sD11yub5T7E9y/Y75e5lyaFbjw7fat+zfDw1HS3gNr2DajHzvayv/NUnMT3wWamS
 UxC06mBPPXa8VcROENxG/eE7rM8lySmrbbuExb7cDrX7RdE60XXlP2kRUUt+sBpiEyn6EiHXqZ0
 YujTIqt6p+9znyFMih2C7ep9J36ida2kRjMOiJWnXzk/389QT05SLcvBWS+KK2hBRBPKSDvHRsB
 JVvfA7kaz4hKKWsM7U3xNby1VqO0GW3V3OQr4J8VCdymtbkVQOTLQu1lu5VU98MWMRq/XFFPS7L
 i14XAOwXDMoMShsus5lnwYFJOesGVhs6PLJsckpZQmPSBr5hpGawOISa1HSJRUWIpKtVSGhBbH3
 kKhLKUlacEheGzjbYWX5FEW/cwRYNQ5Lx/YZ5F1xaUez4hNtANoD9C+Re6lNN3t6uDo8svn2/kj
 YXLRpoXHbmqA1vRYtHA5M1F36h3TdYNl2R+vae6KGxNVhrYd/xOFGBpjmAc5CzncEpUAUv7w9Ra
 QaNf8G1PJIxZZzCqL1N2gxtPW/AdTCNOE49LTSBues7KpoUJs5RSdUUmKPBQrvKPrIhlTlaBjWB
 O74=
X-Received: by 2002:a05:600c:4f12:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-49573ccd035mr50071475e9.9.1784823107446; 
 Thu, 23 Jul 2026 09:11:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bd850asm16546351f8f.15.2026.07.23.09.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 09:11:47 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 16:11:36 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: 65b380fdcf4dd4fd5302ab4d10c276b5952e8244
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0dfc44831722d5939dcdf9215ee2eac4c317d559-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmw1a-0002tG-4S
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
Content-Type: multipart/mixed; boundary="===============3510045746052871683=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3510045746052871683==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hy6z2fVIF1U="; charset=UTF-8

--Hy6z2fVIF1U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1726?usp=3Demail

to look at the new patch set (#6)=
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
:29418/openvpn refs/changes/26/1726/6

diff --git a/src/openvpn/mudp=2Ec b/=
src/openvpn/mudp=2Ec
index d22c53b=2E=2E9658b18 100644
--- a/src/openvpn/mu=
dp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -204,8 +204,7 @@
 static struct multi_=
instance *
 handle_connection_attempt(struct multi_context *m,
            =
               struct link_socket *sock,
-                          struct =
mroute_addr *real,
-                          struct hash_bucket *bucket)
+=
                          struct mroute_addr *real)
 {
     struct hash *ha=
sh =3D m->hash;
     struct tls_pre_decrypt_state state =3D { 0 };
@@ -236,=
7 +235,9 @@
             if (mi)
             {
                 const uint=
64_t hv =3D hash_value(hash, real);
+                struct hash_bucket *bu=
cket =3D hash_bucket(hash, hv);
                 hash_add_fast(hash, bucket=
, &mi->real, hv, mi);
+
                 mi->did_real_hash =3D true;
      =
           multi_assign_peer_id(m, mi);
 
@@ -285,6 +286,19 @@
     return =
NULL;
 }
 
+struct multi_instance *
+multi_get_instance_udp_control(struct =
multi_context *m, struct link_socket *sock)
+{
+    struct mroute_addr real=
 =3D { 0 };
+    real=2Eproto =3D sock->info=2Eproto;
+
+    if (mroute_ext=
ract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2E=
c2=2Ebuf=2Elen > 0)
+    {
+        return multi_get_instance_udp_real(m, &=
real);
+    }
+
+    return NULL;
+}
 
 /**
  * Get a client instance based=
 on real address=2E  If
@@ -292,72 +306,101 @@
  * maintaining real address=
 hash table atomicity=2E
  */
 struct multi_instance *
-multi_get_create_in=
stance_udp(struct multi_context *m, bool *floated, struct link_socket *sock=
)
+multi_get_instance_udp_data(struct multi_context *m, bool *floated, stru=
ct mroute_addr *real, struct link_socket *sock)
 {
-    struct gc_arena gc =
=3D gc_new();
-    struct mroute_addr real =3D { 0 };
     struct multi_ins=
tance *mi =3D NULL;
-    struct hash *hash =3D m->hash;
-    real=2Eproto =
=3D sock->info=2Eproto;
 
-    if (mroute_extract_openvpn_sockaddr(&real, &=
m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+    uint8=
_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    uint8_t op =3D ptr[0] >> P_OPCOD=
E_SHIFT;
+    bool v2 =3D (op =3D=3D P_DATA_V2) && (m->top=2Ec2=2Ebuf=2Elen=
 >=3D (1 + 3));
+    bool peer_id_disabled =3D false;
+
+    /* make sure b=
uffer has enough length to read opcode (1 byte) and peer-id (3 bytes) */
+ =
   if (v2)
     {
-        const uint64_t hv =3D hash_value(hash, &real);
-=
        struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-        uint=
8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
-        uint8_t op =3D ptr[0] >> P_=
OPCODE_SHIFT;
-        bool v2 =3D (op =3D=3D P_DATA_V2) && (m->top=2Ec2=2E=
buf=2Elen >=3D (1 + 3));
-        bool peer_id_disabled =3D false;
+       =
 uint32_t peer_id =3D ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2] << 8) | =
((uint32_t)ptr[3]);
+        peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_=
ID);
 
-        /* make sure buffer has enough length to read opcode (1 byt=
e) and peer-id (3 bytes) */
-        if (v2)
+        if (!peer_id_disabled=
 && (peer_id < m->max_clients) && (m->instances[peer_id]))
         {
-    =
        uint32_t peer_id =3D ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2] <=
< 8) | ((uint32_t)ptr[3]);
-            peer_id_disabled =3D (peer_id =3D=
=3D MAX_PEER_ID);
-
-            if (!peer_id_disabled && (peer_id < m->max=
_clients) && m->instances[peer_id])
+            /* Floating on TCP will ne=
ver be possible, so ensure we only process
+             * UDP clients */
+=
            if (m->instances[peer_id]->context=2Ec2=2Elink_sockets[0]->info=
=2Eproto
+                =3D=3D sock->info=2Eproto)
             {
-      =
          /* Floating on TCP will never be possible, so ensure we only proc=
ess
-                 * UDP clients */
-                if (m->instances[pe=
er_id]->context=2Ec2=2Elink_sockets[0]->info=2Eproto
-                    =
=3D=3D sock->info=2Eproto)
-                {
-                    mi =3D m=
->instances[peer_id];
-                    *floated =3D !link_socket_actual=
_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=2Efrom);
+                mi =
=3D m->instances[peer_id];
+                *floated =3D !link_socket_actua=
l_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=2Efrom);
 
-                =
    if (*floated)
-                    {
-                        /* reset =
prefix, since here we are not sure peer is the one it claims to be
-       =
                  */
-                        ungenerate_prefix(mi);
-     =
                   msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu32 =
" to %s", peer_id,
-                            mroute_addr_print(&real, &g=
c));
-                    }
+                if (*floated)
+               =
 {
+                    /* reset prefix, since here we are not sure peer is=
 the one it claims to be
+                     */
+                    unge=
nerate_prefix(mi);
+                    struct gc_arena gc =3D gc_new();
+ =
                   msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu32 =
" to %s", peer_id,
+                        mroute_addr_print(real, &gc));
=
+                    gc_free(&gc);
                 }
+                retu=
rn mi;
             }
         }
-        if (!v2 || peer_id_disabled)
-   =
     {
-            mi =3D multi_get_instance_udp_real(m, &real);
-        =
}
+    }
+    if (!v2 || peer_id_disabled)
+    {
+        return multi_get=
_instance_udp_real(m, real);
+    }
+    return NULL;
+}
 
-        /* we h=
ave no existing multi instance for this connection */
-        if (!mi)
-  =
      {
-            mi =3D handle_connection_attempt(m, sock, &real, bucke=
t);
-        }
-
-#ifdef ENABLE_DEBUG
-        if (check_debug_level(D_MULT=
I_DEBUG))
-        {
-            const char *status =3D mi ? "[ok]" : "[fa=
iled]";
-
-            dmsg(D_MULTI_DEBUG, "GET INST BY REAL: %s %s", mrout=
e_addr_print(&real, &gc), status);
-        }
-#endif
+struct multi_instanc=
e *
+multi_get_create_instance_udp(struct multi_context *m, bool *floated, =
struct link_socket *sock)
+{
+    /* If the buffer is empty, the packet has=
 no op code and can be neither
+     * a (valid) data nor control packet */=

+    if (m->top=2Ec2=2Ebuf=2Elen <=3D 0)
+    {
+        return NULL;
    =
 }
 
-    gc_free(&gc);
+    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+  =
  uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
+
+    struct mroute_addr real =
=3D { 0 };
+    real=2Eproto =3D sock->info=2Eproto;
+
+    if (!mroute_ext=
ract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true))
+    {
+   =
     return NULL;
+    }
+
+    struct multi_instance *mi =3D NULL;
+    if=
 (op =3D=3D P_DATA_V1 || op =3D=3D P_DATA_V2)
+    {
+        mi =3D multi_=
get_instance_udp_data(m, floated, &real, sock);
+    }
+    else
+    {
+  =
      mi =3D multi_get_instance_udp_control(m, sock);
+
+        /* we have=
 no existing multi instance for this connection, control
+         * packet=
s can create a session=2E Data packets cannot */
+        if (!mi)
+       =
 {
+            mi =3D handle_connection_attempt(m, sock, &real);
+        =
}
+    }
+
+#ifdef ENABLE_DEBUG
+    if (check_debug_level(D_MULTI_DEBUG))
=
+    {
+        struct gc_arena gc =3D gc_new();
+        const char *statu=
s =3D mi ? "[ok]" : "[failed]";
+
+        dmsg(D_MULTI_DEBUG, "GET INST BY=
 REAL/SID: %s %s", mroute_addr_print(&real, &gc), status);
+        gc_free=
(&gc);
+    }
+#endif
+
     ASSERT(!(mi && mi->halt));
     return mi;
 }
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e9923b51b77f1=
84c7d49d697004cb02d2b5cfc3
Gerrit-Change-Number: 1726
Gerrit-PatchSet: 6
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--Hy6z2fVIF1U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #6</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><p>The change is no=
 longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Split multi_get_create_instance_udp into data and control parts<br=
><br>This currently leads to a bit of code duplication but this refactoring=
<br>will make the follow up patches cleaner and better to understand when<b=
r>the control channel lookup will be changed to use session ids instead of<=
br>IP addresses=2E<br><br>Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5c=
fc3<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M s=
rc/openvpn/mudp=2Ec<br>1 file changed, 97 insertions(+), 54 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/26/1726/6</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/op=
envpn/mudp=2Ec</span><br><span>index d22c53b=2E=2E9658b18 100644</span><br>=
<span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec=
</span><br><span>@@ -204,8 +204,7 @@</span><br><span> static struct multi_i=
nstance *</span><br><span> handle_connection_attempt(struct multi_context *=
m,</span><br><span>                           struct link_socket *sock,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
 struct mroute_addr *real,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                          struct hash_bucket *bucket)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                          struct mro=
ute_addr *real)</span><br><span> {</span><br><span>     struct hash *hash =
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
ce_udp_real(m, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br=
><span> /**</span><br><span>  * Get a client instance based on real address=
=2E  If</span><br><span>@@ -292,72 +306,101 @@</span><br><span>  * maintain=
ing real address hash table atomicity=2E</span><br><span>  */</span><br><sp=
an> struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-multi_get_create_instance_udp(struct multi_context *m, bool *floated,=
 struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+multi_get_instance_udp_data(struct multi_context *m, bool *floated, =
struct mroute_addr *real, struct link_socket *sock)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
mroute_addr real =3D { 0 };</span><br><span>     struct multi_instance *mi =
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
 Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Hy6z2fVIF1U=--


--===============3510045746052871683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3510045746052871683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3510045746052871683==--

