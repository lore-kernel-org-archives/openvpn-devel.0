Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC90C44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M9OZ+pUsSPRP4/nBPXladV+F5Ahk63TI3dZbMNFy4g0=; b=dSPQ1vQUKbJkJD0b/tjboddXCE
	rSk1EqLG/xICWXcVHQ9g6jtOUVbrivqdHWdhWa9SBq67fVDCoLM1hbPt0HULRAM+SqdcLu9zdxN+O
	uhv1Ol/0gbLbjdgRDL0dn+DMOLzucvg5Z5e3PNUGtILY9D1wdE1+hwhIhaI35sB+KQSY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1QW-0008EY-MO;
	Wed, 15 Jul 2026 15:21:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1QV-0008ER-2P
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kU7dRNebRCB28NDcf35NqNbh5GvwhXcZN9G0WUvcchQ=; b=mnvY64BmOfCaINofHb25pJUdQh
 wvabRq6UVBJEOTvOyO3mV0WqMV2egi7b3Z0Bixmn66IuV13xtPNxuA2xCPNff1JOOBxU/NoBOgZTA
 XDNO1I0U5RMg+vMOWrpzBeMErLt+RWB5KFet0apTmt7KqJK30xgwd4TdOSfCFZX7L4ac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kU7dRNebRCB28NDcf35NqNbh5GvwhXcZN9G0WUvcchQ=; b=l
 iy/nrJsDvzmE+dSEpa30dkSJgsupmkWE0LbmmIwKkcxKy4bhag9Cay/LI9qaLFYaoquqgY7f07Qjz
 7VEqwthcEVr8VgPeXxgV4zG88z8BvapMWX3kLiYF9ZVJg4cgqV/qR1chu0lxufZh5TPyNxgw6STGN
 6LOWbnE/CzhVAT4U=;
Received: from mail-lf1-f43.google.com ([209.85.167.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1QU-00087o-CM for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:21:35 +0000
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5aea0fff535so2455712e87.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784128883; x=1784733683; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kU7dRNebRCB28NDcf35NqNbh5GvwhXcZN9G0WUvcchQ=;
 b=RKrPswSQVL+HVnHzh5NTMN3qGGB/2RwWhGjUZ7aPcvGZCjtUbDLhLTXkfrtJKzdNhu
 7F2welBTgV+JL9XShG3ggFeXP+MrTXTEeYWtrALuBGTWXShHIsNbo+VPKJNsiMXmPk1F
 wrjuNBTLt+Ep1w5I6N2O2shgPB6mILzBFwgqbDc7xGmNXzisb7zDr220IViAYuyVHUg1
 O2rFDoEwPpVlzLz9LoXHLNnoUxbIbyXYVyvTzfk9AxLqwsw23H7Miyav4SFa9c1g7bFy
 vSNazVqTUDiMp/9FlOiEbUgeC9dpAEOHQyrfXtyzNcXsUEzwlNVX/Eel+zHBdpoyATku
 Ka5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128883; x=1784733683;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kU7dRNebRCB28NDcf35NqNbh5GvwhXcZN9G0WUvcchQ=;
 b=F2MxWaZ5mkud8uMm6ZT3iRaQL+K7Njs0tFuzBgwVwv3afIwy8fjzwHBg+XaVrezPJP
 bMQp5uEEYYVe67VpEQg21WSP/HXHPMTGTCoK4AxoCtsJfS1cJdfgt68IqXrILTnIXwit
 zxHmbZkVAe3uC7dj80DVJy6hmxEqJqlxkv8XYJwpCLfmge0QadD53kJ7SrRK3OxR1qzk
 J25VCXlXBwXdrlNv99YADmcW58CeYbdat4B+y0I/yFgZa5ysqh4eJYpwVFUUTuVYMpqf
 ZSSaBAmIpvcmKg3deASsj5N8Y7rZQlBDJ5lr20gg236XfKktOvUB2AzPon7NYFBWz7ar
 5fVw==
X-Gm-Message-State: AOJu0Yw3QMtaM1l6yWiEw/NQJCs1LB2DhbOiwaytZwnf1q9ffNaiZY55
 gHiwT7xIbFYFiTAEMHhdEnKoCF/oeeRVO4MuYF2oRKJCa5HQi3j8v42xKEneQu1ScTa5zxvzd/l
 ef2c1/wjpJg43gVvpy3n+AQKMGhgKdUXB1ZdwjHdwFwdS8HOv/vtU2VBZkzmsQEjK3PpnLgnQdo
 hq2BddKw==
X-Gm-Gg: AfdE7clu10b++fgblSMeNNUJ192F/FTpXMib/CmtxVh/HpmZA4YjeSurrQ17RMCj6nO
 EMP5u3HoSoocPJBcYyGkYGtmtxfsEdKzjPNolSaxLWIlegr/kfvvHv5cWpNZ1cXYaXfg/JdJ5fj
 bsTmDjSz+MUUgdOLow+pwLJ4oiHp7A7De9fh1Gea3eKuUYy9lZH6ZRukWIXhqUVQC5uKvSsix4o
 +QXx7Afe1v3gLysLcSNF9CK+sIJ2rpllZxH3mN6Y4bPkWnri4vGl2L5rEQ1fCJ8GG6cujd0ITyc
 N91nfn5JtypYbceXO7djDkRNkth5XadRsMgrPj02TcPBpUd0N25rAvIvyFFY2bMlmoEVWE9mVl2
 /2HZauuhn0QvQi0gb0ChtNGphg3dI3G3P+ahFS+fZsGn9om65O9SPexOzOxaXBYCRZkfBgSa2H/
 91J9ETjehpj5fnNzpFgfILp14KCanJ7O3QKz+zsYiebccE7RnJZlIRlZEfWxYRN4gUH7ka1Z2mI
 duYWxEa1GtMLFLDDjK0Ewi14QhtZ/f5MJNh1EztEfIuqh7PGnnjrDSuyChcD9fKYxCj6KCJGEoX
 JPo5ljZIPUZjrQ==
X-Received: by 2002:a05:600c:6989:b0:493:bfbf:1da4 with SMTP id
 5b1f17b1804b1-493f881de65mr170007295e9.22.1784117905311; 
 Wed, 15 Jul 2026 05:18:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495087366c0sm267804085e9.7.2026.07.15.05.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:18:23 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 12:18:22 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: d501861ad4ca12f7c402c999e914430ee48fc480
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1f34c155210c2a441be328270382d0fe77d5714-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1QU-00087o-CM
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
Content-Type: multipart/mixed; boundary="===============3006652198604740725=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3006652198604740725==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Tl5X3voZdto="; charset=UTF-8

--Tl5X3voZdto=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1726?usp=3Demail

to look at the new patch set (#5=
)=2E


Change subject: Split multi_get_create_instance_udp into data and co=
ntrol parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

S=
plit multi_get_create_instance_udp into data and control parts

This curren=
tly leads to a bit of code duplication but this refactoring
will make the f=
ollow up patches cleaner and better to understand when
the control channel =
lookup will be changed to use session ids instead of
IP addresses=2E

Chang=
e-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
Signed-off-by: Arne Schwabe=
 <arne@rfc2549=2Eorg>
---
M src/openvpn/mudp=2Ec
1 file changed, 97 inserti=
ons(+), 54 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/26/1726/5

diff --git a/src/openvpn/mudp=2Ec b/src/openvp=
n/mudp=2Ec
index d22c53b=2E=2E9658b18 100644
--- a/src/openvpn/mudp=2Ec
+++=
 b/src/openvpn/mudp=2Ec
@@ -204,8 +204,7 @@
 static struct multi_instance *=

 handle_connection_attempt(struct multi_context *m,
                      =
     struct link_socket *sock,
-                          struct mroute_add=
r *real,
-                          struct hash_bucket *bucket)
+          =
                struct mroute_addr *real)
 {
     struct hash *hash =3D m->=
hash;
     struct tls_pre_decrypt_state state =3D { 0 };
@@ -236,7 +235,9 @=
@
             if (mi)
             {
                 const uint64_t hv =
=3D hash_value(hash, real);
+                struct hash_bucket *bucket =3D=
 hash_bucket(hash, hv);
                 hash_add_fast(hash, bucket, &mi->r=
eal, hv, mi);
+
                 mi->did_real_hash =3D true;
              =
   multi_assign_peer_id(m, mi);
 
@@ -285,6 +286,19 @@
     return NULL;
 }=

 
+struct multi_instance *
+multi_get_instance_udp_control(struct multi_co=
ntext *m, struct link_socket *sock)
+{
+    struct mroute_addr real =3D { 0=
 };
+    real=2Eproto =3D sock->info=2Eproto;
+
+    if (mroute_extract_ope=
nvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=
=2Elen > 0)
+    {
+        return multi_get_instance_udp_real(m, &real);
+=
    }
+
+    return NULL;
+}
 
 /**
  * Get a client instance based on real=
 address=2E  If
@@ -292,72 +306,101 @@
  * maintaining real address hash ta=
ble atomicity=2E
  */
 struct multi_instance *
-multi_get_create_instance_u=
dp(struct multi_context *m, bool *floated, struct link_socket *sock)
+multi=
_get_instance_udp_data(struct multi_context *m, bool *floated, struct mrout=
e_addr *real, struct link_socket *sock)
 {
-    struct gc_arena gc =3D gc_n=
ew();
-    struct mroute_addr real =3D { 0 };
     struct multi_instance *m=
i =3D NULL;
-    struct hash *hash =3D m->hash;
-    real=2Eproto =3D sock-=
>info=2Eproto;
 
-    if (mroute_extract_openvpn_sockaddr(&real, &m->top=2E=
c2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+    uint8_t *ptr =
=3D BPTR(&m->top=2Ec2=2Ebuf);
+    uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;=

+    bool v2 =3D (op =3D=3D P_DATA_V2) && (m->top=2Ec2=2Ebuf=2Elen >=3D (1=
 + 3));
+    bool peer_id_disabled =3D false;
+
+    /* make sure buffer ha=
s enough length to read opcode (1 byte) and peer-id (3 bytes) */
+    if (v=
2)
     {
-        const uint64_t hv =3D hash_value(hash, &real);
-        =
struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-        uint8_t *ptr=
 =3D BPTR(&m->top=2Ec2=2Ebuf);
-        uint8_t op =3D ptr[0] >> P_OPCODE_S=
HIFT;
-        bool v2 =3D (op =3D=3D P_DATA_V2) && (m->top=2Ec2=2Ebuf=2Ele=
n >=3D (1 + 3));
-        bool peer_id_disabled =3D false;
+        uint32_=
t peer_id =3D ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2] << 8) | ((uint32=
_t)ptr[3]);
+        peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);
 
-=
        /* make sure buffer has enough length to read opcode (1 byte) and p=
eer-id (3 bytes) */
-        if (v2)
+        if (!peer_id_disabled && (pee=
r_id < m->max_clients) && (m->instances[peer_id]))
         {
-            =
uint32_t peer_id =3D ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2] << 8) | (=
(uint32_t)ptr[3]);
-            peer_id_disabled =3D (peer_id =3D=3D MAX_PE=
ER_ID);
-
-            if (!peer_id_disabled && (peer_id < m->max_clients) =
&& m->instances[peer_id])
+            /* Floating on TCP will never be pos=
sible, so ensure we only process
+             * UDP clients */
+          =
  if (m->instances[peer_id]->context=2Ec2=2Elink_sockets[0]->info=2Eproto
+=
                =3D=3D sock->info=2Eproto)
             {
-                =
/* Floating on TCP will never be possible, so ensure we only process
-     =
            * UDP clients */
-                if (m->instances[peer_id]->co=
ntext=2Ec2=2Elink_sockets[0]->info=2Eproto
-                    =3D=3D sock=
->info=2Eproto)
-                {
-                    mi =3D m->instances=
[peer_id];
-                    *floated =3D !link_socket_actual_match(&mi-=
>context=2Ec2=2Efrom, &m->top=2Ec2=2Efrom);
+                mi =3D m->inst=
ances[peer_id];
+                *floated =3D !link_socket_actual_match(&mi=
->context=2Ec2=2Efrom, &m->top=2Ec2=2Efrom);
 
-                    if (*fl=
oated)
-                    {
-                        /* reset prefix, sin=
ce here we are not sure peer is the one it claims to be
-                  =
       */
-                        ungenerate_prefix(mi);
-                =
        msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu32 " to %s", p=
eer_id,
-                            mroute_addr_print(&real, &gc));
-     =
               }
+                if (*floated)
+                {
+       =
             /* reset prefix, since here we are not sure peer is the one it=
 claims to be
+                     */
+                    ungenerate_pref=
ix(mi);
+                    struct gc_arena gc =3D gc_new();
+            =
        msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu32 " to %s", p=
eer_id,
+                        mroute_addr_print(real, &gc));
+          =
          gc_free(&gc);
                 }
+                return mi;
    =
         }
         }
-        if (!v2 || peer_id_disabled)
-        {
-   =
         mi =3D multi_get_instance_udp_real(m, &real);
-        }
+    }
+ =
   if (!v2 || peer_id_disabled)
+    {
+        return multi_get_instance_u=
dp_real(m, real);
+    }
+    return NULL;
+}
 
-        /* we have no exis=
ting multi instance for this connection */
-        if (!mi)
-        {
-  =
          mi =3D handle_connection_attempt(m, sock, &real, bucket);
-      =
  }
-
-#ifdef ENABLE_DEBUG
-        if (check_debug_level(D_MULTI_DEBUG))
-=
        {
-            const char *status =3D mi ? "[ok]" : "[failed]";
-
-=
            dmsg(D_MULTI_DEBUG, "GET INST BY REAL: %s %s", mroute_addr_prin=
t(&real, &gc), status);
-        }
-#endif
+struct multi_instance *
+multi_=
get_create_instance_udp(struct multi_context *m, bool *floated, struct link=
_socket *sock)
+{
+    /* If the buffer is empty, the packet has no op code=
 and can be neither
+     * a (valid) data nor control packet */
+    if (m=
->top=2Ec2=2Ebuf=2Elen <=3D 0)
+    {
+        return NULL;
     }
 
-    g=
c_free(&gc);
+    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    uint8_t o=
p =3D ptr[0] >> P_OPCODE_SHIFT;
+
+    struct mroute_addr real =3D { 0 };
+=
    real=2Eproto =3D sock->info=2Eproto;
+
+    if (!mroute_extract_openvpn=
_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true))
+    {
+        return =
NULL;
+    }
+
+    struct multi_instance *mi =3D NULL;
+    if (op =3D=3D =
P_DATA_V1 || op =3D=3D P_DATA_V2)
+    {
+        mi =3D multi_get_instance=
_udp_data(m, floated, &real, sock);
+    }
+    else
+    {
+        mi =3D=
 multi_get_instance_udp_control(m, sock);
+
+        /* we have no existing=
 multi instance for this connection, control
+         * packets can create=
 a session=2E Data packets cannot */
+        if (!mi)
+        {
+        =
    mi =3D handle_connection_attempt(m, sock, &real);
+        }
+    }
+
+=
#ifdef ENABLE_DEBUG
+    if (check_debug_level(D_MULTI_DEBUG))
+    {
+    =
    struct gc_arena gc =3D gc_new();
+        const char *status =3D mi ? "=
[ok]" : "[failed]";
+
+        dmsg(D_MULTI_DEBUG, "GET INST BY REAL/SID: %=
s %s", mroute_addr_print(&real, &gc), status);
+        gc_free(&gc);
+    =
}
+#endif
+
     ASSERT(!(mi && mi->halt));
     return mi;
 }

-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004=
cb02d2b5cfc3
Gerrit-Change-Number: 1726
Gerrit-PatchSet: 5
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--Tl5X3voZdto=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Sp=
lit multi_get_create_instance_udp into data and control parts<br><br>This c=
urrently leads to a bit of code duplication but this refactoring<br>will ma=
ke the follow up patches cleaner and better to understand when<br>the contr=
ol channel lookup will be changed to use session ids instead of<br>IP addre=
sses=2E<br><br>Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3<br>Sign=
ed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/=
mudp=2Ec<br>1 file changed, 97 insertions(+), 54 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/26/1726/5</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec</span><br><span>index d22c53b=2E=2E9658b18 100644</span><br><span>--- =
a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br=
><span>@@ -204,8 +204,7 @@</span><br><span> static struct multi_instance *<=
/span><br><span> handle_connection_attempt(struct multi_context *m,</span><=
br><span>                           struct link_socket *sock,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                          struct mr=
oute_addr *real,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                     struct hash_bucket *bucket)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                          struct mroute_addr *=
real)</span><br><span> {</span><br><span>     struct hash *hash =3D m-&gt;h=
ash;</span><br><span>     struct tls_pre_decrypt_state state =3D { 0 };</sp=
an><br><span>@@ -236,7 +235,9 @@</span><br><span>             if (mi)</span=
><br><span>             {</span><br><span>                 const uint64_t h=
v =3D hash_value(hash, real);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                struct hash_bucket *bucket =3D hash_bucket(hash, =
hv);</span><br><span>                 hash_add_fast(hash, bucket, &amp;mi-&=
gt;real, hv, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>                 mi-&gt;did_real_hash =3D true;</span><br><s=
pan>                 multi_assign_peer_id(m, mi);</span><br><span> </span><=
br><span>@@ -285,6 +286,19 @@</span><br><span>     return NULL;</span><br><=
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
pan><br><span>@@ -292,72 +306,101 @@</span><br><span>  * maintaining real a=
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
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e99=
23b51b77f184c7d49d697004cb02d2b5cfc3 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1726 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--Tl5X3voZdto=--


--===============3006652198604740725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3006652198604740725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3006652198604740725==--

