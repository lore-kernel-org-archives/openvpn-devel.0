Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7564C5321C
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BxrJs4lB1ZmLRhYQhiSzspZAox3Mbcnl4+XUNOX1i7o=; b=Me73oHo/ml5/HY
	8890bz5SuBhvMP10IDKk68ghHppVbNf8EePsRkaJEpl4dYvuPOc4/TQ7AVFcGSPfO3YFlz2CRAjpG
	RCzCArtks9fUVwyHnetsqER835C09iOY6Sq1K3LHWAfMOQjI7pIfunrj+2fVdt9HgLVBA/rCeYJFf
	zHk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnmOb-0007SY-Bm;
	Sun, 26 Jul 2026 00:07:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnmOU-0007SO-Sq
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:07:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MUsLI23cSQgv9QRPk2P4pKljfcuoHUkRLDT1TO2EeTE=; b=KHz6IiiXLX0+ZEIUdxkTmfTjZs
 kCKQ+MmpKtpNxx+1sn63DY757yYwNLe0aLkBKZternuNqVPVB0CZovilcHgC4h1+vZcDPtK49QTJ+
 URj/7AkSyuly7nf1Ctk/ZE7nTXjFycWahHYLP9KoTwzKrIyqaRwnq0ZkhqaDV4HvAAkU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MUsLI23cSQgv9QRPk2P4pKljfcuoHUkRLDT1TO2EeTE=; b=e
 eIitmwbtJniFkE46Uv2bEq3zLGKloeBe3z2b8jUhcRFJTwF73zNnhT90l3o5psYwHlZoWtRcwsDNE
 W6QxD5SkY/Savq6T9vJfwQbttpu6D2qdQn+hLi3L1FexifLwbKEihJ0LOL08H2EdZKrMa4gnlQrwU
 HbiY17mp257WVqMk=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnmOV-0005yy-2R for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:07:02 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso14962705e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785024413; x=1785629213; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MUsLI23cSQgv9QRPk2P4pKljfcuoHUkRLDT1TO2EeTE=;
 b=b93sLN4VlWUNyXC0EylF0IqnYPToitqXzoRywX1wjwIboKpkF9fpq8gEh1c3NMlgde
 I4GNEQkVq3gjSXTNGmTBGItXGDrs0YpcrOuAzEzaKJO0tkmbig2S0JiRUfJ/eJRTcDWe
 E4HCOotQ/uSQhG/BDNGEwv3wo16jvppYUGMZc6FlkkRzdkRTDp4MZRuFMtDG1QDTWyTv
 Xs4v1dMo6ppl/xkG+fidAuBiv3TaK/9hwe0PbjoAHdWAK8bfgsD2n0Q++kLU0rgHO8Wu
 JVbuAe/Vjqyul4IBB2P+XdZ9lZ7IzFjQ7MExsyjRQnD9yeBagI859sgCqM2CdkuLovRL
 JaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785024413; x=1785629213;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MUsLI23cSQgv9QRPk2P4pKljfcuoHUkRLDT1TO2EeTE=;
 b=bCfyK16uX4NUbrF/07e9PGjwqT+9uHInkEHhMmBfb8LDE2RV5cqDxXxmR8BOY58GW6
 u4p68LGo2/ISCbTzMkkMGz8QvedQvgYfze2mvVs2XembO+uF3pacxF9XNqNXbj/wBTf6
 Tpzbk+RhTf8ZcbrRcDN5FAUeZ4SUCJ9AXdQiu8bQFgeKa3m5CEW1pWh1rUiGHW833lzS
 Ep6Q1ChxeUiRXapbGIfKDflq8zSslHK0EXioWOHoHXCYOTvEpe0Kk7gb1ZhuBJuIi+HT
 iiS/rsv/Q8cdGm4wbDW1CkZHVMs3GRXETfVFx84vc/2i8AOITgGgpSh495fkyFDMi4u/
 ERCw==
X-Gm-Message-State: AOJu0YzI4rHK5+h8qZ5dhyM/zoacdGW1VW8fZCqU8cnZ/KNy/nkohURz
 NIytpf7P4dH1vYGKJ+rZjRhUVcJiV7h6BEHlmKIMCmnamNuqQ2e8OZpv5NKNlI+EKUg8TgoyMeQ
 /YLqWwxIyNRvzNyenQ0q2tzmzKEYOiQpRF0/nyTkKQMBJ0sjkT/GnAR/z9YGgs6Ajk5Y37/YlO0
 H5N9DU1Q==
X-Gm-Gg: AR+sD13oj7VH8qpbJ0HrdDVR7VeyOpIPI5lxSv7wOxvmJzkox3/JPcIDxRr0i4w5GWd
 CCLiHvaHLlHlD5NSehzFCDvA2Cd6A080YkgZgqqQ1sZcrg9KmPylXf+wg8sB830f9AxSGNwrOBI
 MOE/p9N9XydfyohqDtkWe4JsOmTEM06zDxGjraqiRRtwaUpoasrO/YvL/JN2paeIZfbwvCCv1eA
 +sk53GfIFTGM9l4E9UVMpVnBSl4wA3VD2a3iJUHL/O6KjaoqtiA4apQkK9rukSCOh6Q7mlJroQX
 W0s5Ak01INn3BNMJWhAbB0iuXutGBt8M/NZcjd/6UnGTGAUS3vkcZrzhGIPQfKIRPWKBZl40vaX
 AYSPrSBwZuWjQiDimeL+SfAN5OsbTgmkPzbhaOc+FlJBckCsm2FlkS2agFrvEo17FM6Nb4oxqOw
 2RKvzI1jowHPnilPlRZ1GC3x4jAPQM7pECMz8Ue/l2iFZqXiDJzZaRqig2QBhHhpsOTuTKcdqfn
 fHClpLkzMNlLjmmGAcsxS5T5kKF+L7EzfcBXOcgclENQui2nbvfKCSLm7VD4YZkXDL/13M5b81l
 x4U=
X-Received: by 2002:a05:6000:4029:b0:47f:84b2:2671 with SMTP id
 ffacd0b85a97d-47f9fc8d144mr3856065f8f.7.1785024412375; 
 Sat, 25 Jul 2026 17:06:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm37175776f8f.37.2026.07.25.17.06.51
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:06:51 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 00:06:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic3a0809191addea024ff8bd69600f4dbad9c37a6
X-Gerrit-Change-Number: 1824
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1824?usp=email>
X-Gerrit-Commit: 0e8a55d24a15c0df7ee0517b4873208ab4708c3a
References: <gerrit.1785024389000.Ic3a0809191addea024ff8bd69600f4dbad9c37a6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MDI0Mzg5MDAwLkljM2EwODA5MTkxYWRkZWEwMjRmZjhiZDY5NjAwZjRkYmFkOWMzN2E2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <33515dd1ec069811085f84e4802c39419c2fb533-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnmOV-0005yy-2R
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement basic
 multipeer support.
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
Content-Type: multipart/mixed; boundary="===============1963206915996810538=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1963206915996810538==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZRteESgjDvk="; charset=UTF-8

--ZRteESgjDvk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1824?usp=3Demail )


Change subject: Implement basic mul=
tipeer support=2E
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Implement basic multipeer support=2E

Current restriction:
- no tls-cr=
ypt-v2 support
- no TCP support
- no retry logic ( only one attempt at esta=
blishing a connection)
- only literal IP:port support for peer

Change-Id: =
Ic3a0809191addea024ff8bd69600f4dbad9c37a6
Signed-off-by: Arne Schwabe <arne=
@rfc2549=2Eorg>
---
M src/openvpn/dco=2Ec
M src/openvpn/init=2Ec
M src/open=
vpn/init=2Eh
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/mu=
lti=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Eh
M src/openvpn/soc=
ket_util=2Ec
M src/openvpn/socket_util=2Eh
M src/openvpn/ssl=2Ec
11 files c=
hanged, 342 insertions(+), 21 deletions(-)



  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/24/1824/1

diff --git a/src/openvpn/d=
co=2Ec b/src/openvpn/dco=2Ec
index d4beb04=2E=2E9c3e71d 100644
--- a/src/op=
envpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -365,6 +365,13 @@
         }
   =
  }
 
+    if (o->peer_list)
+    {
+        msg(msglevel, "Note: peer conn=
ections require asymmetric peer-id, "
+                      "disabling dat=
a channel offload");
+        return false;
+    }
+
 #if defined(_WIN32)
 =
    if ((o->mode =3D=3D MODE_SERVER) && !dco_win_supports_multipeer())
    =
 {
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 0e649f8=
=2E=2Ee8644f4 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
=
@@ -4818,12 +4818,19 @@
 }
 
 void
-inherit_context_child(struct context *d=
est, const struct context *src, struct link_socket *sock)
+inherit_context_=
child(struct context *dest, const struct context *src, struct link_socket *=
sock, bool peer_connection)
 {
     CLEAR(*dest);
 
     /* proto_is_dgram =
will ASSERT(0) if proto is invalid */
-    dest->mode =3D proto_is_dgram(so=
ck->info=2Eproto) ? CM_CHILD_UDP : CM_CHILD_TCP;
+    if (peer_connection)
=
+    {
+        dest->mode =3D proto_is_dgram(sock->info=2Eproto) ? CM_PEER=
_UDP : CM_PEER_TCP;
+    }
+    else
+    {
+        dest->mode =3D proto_i=
s_dgram(sock->info=2Eproto) ? CM_CHILD_UDP : CM_CHILD_TCP;
+    }
 
     de=
st->gc =3D gc_new();
 
@@ -4854,6 +4861,12 @@
 
     dest->c2=2Eevent_set =
=3D src->c2=2Eevent_set;
 
+    if (peer_connection)
+    {
+        dest->=
options=2Etls_client =3D true;
+        dest->options=2Etls_server =3D fals=
e;
+    }
+
     if (dest->mode =3D=3D CM_CHILD_TCP)
     {
         /*
@@ =
-4893,7 +4906,7 @@
         ALLOC_OBJ_GC(dest->c2=2Elink_socket_infos[0], s=
truct link_socket_info, &dest->gc);
         *dest->c2=2Elink_socket_infos[=
0] =3D sock->info;
 
-        /* locally override some link_socket_info fie=
lds */
+        /* locally override some link_socket_info fields=2E FIXME: =
copy from right socket?! */
         dest->c2=2Elink_socket_infos[0]->lsa =
=3D &dest->c1=2Elink_socket_addrs[0];
         dest->c2=2Elink_socket_infos=
[0]->connection_established =3D false;
     }
diff --git a/src/openvpn/init=
=2Eh b/src/openvpn/init=2Eh
index 9d5050d=2E=2Ecc2f90a 100644
--- a/src/ope=
nvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -102,7 +102,7 @@
 bool do_defer=
red_options(struct context *c, const uint64_t found, const bool is_update);=

 
 void inherit_context_child(struct context *dest, const struct context *=
src,
-                           struct link_socket *sock);
+              =
             struct link_socket *sock, bool peer_connection);
 
 void inher=
it_context_top(struct context *dest, const struct context *src);
 
diff --g=
it a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index eb4e944=2E=2Edde38b7=
 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -43,7 +43,=
7 @@
     struct gc_arena gc =3D gc_new();
     struct multi_instance *mi =
=3D NULL;
 
-    mi =3D multi_create_instance(m, NULL, sock);
+    mi =3D m=
ulti_create_instance(m, NULL, sock, false);
     if (mi)
     {
         mi=
->real=2Eproto =3D sock->info=2Eproto;
diff --git a/src/openvpn/mudp=2Ec b/=
src/openvpn/mudp=2Ec
index 657055c=2E=2Ef74e74c 100644
--- a/src/openvpn/mu=
dp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -231,7 +231,7 @@
              * conne=
ct-freq but not against connect-freq-initial */
             reflect_filter=
_rate_limit_decrease(m->initial_rate_limiter);
 
-            mi =3D multi_=
create_instance(m, real, sock);
+            mi =3D multi_create_instance(m=
, real, sock, false);
             if (mi)
             {
                 =
multi_assign_peer_id(m, mi);
@@ -283,11 +283,9 @@
 }
 
 
-static struct mul=
ti_instance *
-multi_get_instance_udp_control(struct multi_context *m)
+sta=
tic inline struct session_id
+multi_get_extract_sesison_id(struct multi_con=
text *m)
 {
-    /* Copy buffer, to a tmp buffer, so that reading the sesis=
on does not
-     * modify the internal pointers */
     struct buffer tmp =
=3D m->top=2Ec2=2Ebuf;
 
     /* op code */
@@ -296,7 +294,17 @@
 
     str=
uct session_id sid =3D { 0 };
     session_id_read(&sid, &tmp);
+    return=
 sid;
+}
 
+static struct multi_instance *
+multi_get_instance_udp_control(=
struct multi_context *m)
+{
+    /* Copy buffer, to a tmp buffer, so that r=
eading the sesison does not
+     * modify the internal pointers */
+
+
+  =
  struct session_id sid =3D multi_get_extract_sesison_id(m);
     struct ha=
sh_element *he_sid =3D multi_hash_sid_lookup(m, &sid);
 
     if (he_sid)
@=
@ -336,7 +344,16 @@
                 =3D=3D sock->info=2Eproto)
           =
  {
                 mi =3D m->instances[peer_id];
-                *floate=
d =3D !link_socket_actual_match(&mi->context=2Ec2=2Efrom, &m->top=2Ec2=2Efr=
om);
+
+                /* FIXME:figure out if we want to setup from at the=
 right place */
+                if (mi->context=2Ec2=2Efrom=2Edest=2Eaddr=
=2Esa=2Esa_family =3D=3D 0)
+                {
+                    *floate=
d =3D true;
+                }
+                else
+                {
+  =
                  *floated =3D !link_socket_actual_match(&mi->context=2Ec2=
=2Efrom, &m->top=2Ec2=2Efrom);
+                }
 
                 if (*f=
loated)
                 {
@@ -359,6 +376,44 @@
     return NULL;
 }
 
+sta=
tic struct multi_instance *
+multi_get_instance_udp_peer(struct multi_conte=
xt *m, struct mroute_addr *real)
+{
+    /* If we have an outgoing connecti=
on we need to look it
+     * up some way=2E Since this might be a tls-cryp=
t-v2 session,
+     * we would need the tls-crypt-v2 key before decrypting
=
+     * the packet, so we fall back to a simple lookup by address
+     * h=
ere */
+    struct multi_instance *mi =3D multi_get_instance_udp_real(m, re=
al);
+    if (!mi)
+    {
+        return NULL;
+    }
+
+    const struct =
key_state *ks =3D get_primary_key(mi->context=2Ec2=2Etls_multi);
+    ASSER=
T(ks);
+    if (session_id_defined(&ks->session_id_remote))
+    {
+       =
 struct gc_arena gc =3D gc_new();
+        msg(D_MULTI_MEDIUM, "Peer connec=
tion: Peer already has established "
+                            "session =
id %s=2E",
+            mroute_addr_print(real, &gc));
+        gc_free(&gc=
);
+        return NULL;
+    }
+    /* we now just assume that this a poss=
ible session id for the session
+     * and therefore add the hash of the r=
emote session id to the hash map */
+
+    /* We might have had another res=
et packet before */
+    if (session_id_defined(&mi->sid_hashed_value))
+  =
  {
+        multi_hash_sid_remove(m, &mi->sid_hashed_value);
+    }
+    s=
truct session_id sid =3D multi_get_extract_sesison_id(m);
+    multi_hash_s=
id_add(m, &sid, mi);
+    return mi;
+}
+
 struct multi_instance *
 multi_g=
et_create_instance_udp(struct multi_context *m, bool *floated, struct link_=
socket *sock)
 {
@@ -400,7 +455,14 @@
          * packets can create a sess=
ion=2E Data packets cannot */
         if (!mi)
         {
-            mi =
=3D handle_connection_attempt(m, sock, &real);
+            if (op !=3D P_C=
ONTROL_HARD_RESET_SERVER_V2)
+            {
+                mi =3D handle_=
connection_attempt(m, sock, &real);
+            }
+            else
+     =
       {
+                mi =3D multi_get_instance_udp_peer(m, &real);
+  =
          }
         }
     }
 
diff --git a/src/openvpn/multi=2Ec b/src/op=
envpn/multi=2Ec
index ff9121d=2E=2E0b7dd02 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -422,6 +422,13 @@
         event_timeou=
t_init(&m->stale_routes_check_et, t->options=2Estale_routes_check_interval,=
 0);
     }
 
+    if (t->options=2Econnection_list)
+    {
+        /* For=
 now we will check every 7s=2E Might later add an option
+         * to cha=
nge the interval as a user */
+        event_timeout_init(&m->peer_connecti=
on_et, 7, now);
+    }
+
     m->deferred_shutdown_signal=2Esignal_received=
 =3D 0;
 }
 
@@ -717,7 +724,7 @@
  */
 struct multi_instance *
 multi_creat=
e_instance(struct multi_context *m, const struct mroute_addr *real,
-      =
                struct link_socket *sock)
+                      struct lin=
k_socket *sock, bool peer_connection)
 {
     struct gc_arena gc =3D gc_new=
();
     struct multi_instance *mi;
@@ -738,7 +745,7 @@
         generate_p=
refix(mi);
     }
 
-    inherit_context_child(&mi->context, &m->top, sock)=
;
+    inherit_context_child(&mi->context, &m->top, sock, peer_connection);=

     if (IS_SIG(&mi->context))
     {
         goto err;
@@ -749,7 +756,7 =
@@
     if (hash_n_elements(m->hash) >=3D m->max_clients)
     {
         m=
sg(D_MULTI_ERRORS,
-            "MULTI: new incoming connection would excee=
d maximum number of clients (%d)",
+            "MULTI: new connection woul=
d exceed maximum number of clients (%d)",
             m->max_clients);
   =
      goto err;
     }
@@ -1791,7 +1798,7 @@
 
     /* Print a warning if w=
e detect the client being in P2P mode=2E The
      * negotiations will be o=
therwise compatible */
-    if (proto & IV_PROTO_NCP_P2P)
+    if (proto & =
IV_PROTO_NCP_P2P && !cm_mode_peer(c->mode))
     {
         multi_client_se=
t_protocol_warnings_p2p(c);
     }
@@ -2520,6 +2527,19 @@
 multi_client_con=
nect_real_addr(struct multi_context *m, struct multi_instance *mi,
        =
                        bool deferred, uint64_t *option_types_found)
 {
+  =
  if (cm_mode_peer(mi->context=2Emode))
+    {
+        /* If we have a mul=
ti client instance it should already be assigned
+         * to its address=
 in its creation */
+        bool address_assigned =3D hash_lookup(m->hash,=
 &mi->real) =3D=3D mi;
+        if (!address_assigned)
+        {
+        =
    msg(D_MULTI_ERRORS, "MULTI: Address for client connection is "
+       =
                         "not correctly set up=2E Terminating connection");=

+        }
+        return address_assigned ? CC_RET_SUCCEEDED : CC_RET_FA=
ILED;
+    }
+
     /* If the address is already taken up by another client=
 we fail the new
      * connection */
     if (!multi_check_dest_addr_allo=
wed(m, mi, &mi->real))
@@ -2537,6 +2557,30 @@
 }
 
 /**
+ * This checks if =
all the conditions of an outgoing peer connection are met=2E
+ */
+static e=
num client_connect_return
+multi_client_connect_peer(struct multi_context *=
m, struct multi_instance *mi,
+                          bool deferred, uin=
t64_t *option_types_found)
+{
+    if (!cm_mode_peer(mi->context=2Emode))
+=
    {
+        return CC_RET_SUCCEEDED;
+    }
+
+    struct tls_multi *mul=
ti =3D mi->context=2Ec2=2Etls_multi;
+    if (!multi->use_asymmetric_peer_i=
d)
+    {
+        msg(D_MULTI_ERRORS, "Connecting to another server/peer r=
equires "
+                            "asymmetric peer-id support=2E The p=
eer lacks this "
+                            "support=2E Terminating conne=
ction=2E");
+        return CC_RET_FAILED;
+    }
+
+    return CC_RET_SUCC=
EEDED;
+}
+
+/**
  *  Do the necessary modification for doing the compress =
migrate=2E This is
  *  implemented as a connect handler as it fits the mod=
ify config for a client
  *  paradigm and also is early enough in the chain=
 to be overwritten by another
@@ -2630,6 +2674,7 @@
     uint64_t *option_t=
ypes_found);
 
 static const multi_client_connect_handler client_connect_ha=
ndlers[] =3D {
+    multi_client_connect_peer,
     multi_client_connect_re=
al_addr,
     multi_client_connect_compress_migrate,
     multi_client_conn=
ect_source_ccd,
@@ -3873,6 +3918,186 @@
     return event_timeout_trigger(&=
m->stale_routes_check_et, &null, ETT_DEFAULT);
 }
 
+static bool
+peer_conn=
ection_trigger(struct multi_context *m)
+{
+    struct timeval null;
+    C=
LEAR(null);
+    return event_timeout_trigger(&m->peer_connection_et, &null=
, ETT_DEFAULT);
+}
+
+static bool
+multi_resolve_peer_addr(struct connectio=
n_entry *ce, struct mroute_addr *real, struct openvpn_sockaddr *sa,
+      =
                  bool have_udp4, bool have_udp6)
+{
+    unsigned int flag=
s =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL;
+    if (proto_is_dgram(ce-=
>proto))
+    {
+        if (!have_udp6 && !have_udp4)
+        {
+        =
    msg(M_INFO, "Cannot connect to %s:%s: no UDP sockets available", ce->re=
mote, ce->remote_port);
+            return false;
+        }
+        flag=
s |=3D GETADDR_DATAGRAM;
+    }
+
+    if (have_udp6 && !have_udp4)
+    {
=
+        /* The address family needs to match the socket address family=2E =
If we only
+         * have IPv6 sockets, we force IPv6 mapped IPv4 address=
 with this=2E For
+         * TCP client, we create new sockets and don't h=
ave to worry about this */
+        flags |=3D GETADDR_FORCE_FAMILY;
+    }=

+
+    struct addrinfo *ai;
+    int status =3D openvpn_getaddrinfo(flags,=
 ce->remote, ce->remote_port, 0,
+                                     NULL=
, AF_INET6, &ai);
+
+    bool ret =3D false;
+    if (status !=3D 0)
+    {=

+        msg(M_INFO, "Failure to resolve %s:%s as peer address=2E Currentl=
y only "
+                    "literal IP/IPv6 addresses are supported",
+ =
           ce->remote, ce->remote_port);
+        goto error;
+    }
+
+   =
 mroute_addr_init(real);
+    real->proto =3D proto_is_dgram(ce->proto) ? P=
ROTO_UDP : PROTO_TCP;
+
+    if (ai->ai_family =3D=3D AF_INET)
+    {
+    =
    struct sockaddr_in *sin =3D (struct sockaddr_in *)ai->ai_addr;
+       =
 sa->addr=2Ein4 =3D *sin;
+    }
+    else if (ai->ai_family =3D=3D AF_INET=
6)
+    {
+        struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)ai-=
>ai_addr;
+        sa->addr=2Ein6 =3D *sin6;
+    }
+    else
+    {
+     =
   ASSERT(0);
+    }
+
+    if (!mroute_extract_openvpn_sockaddr(real, sa, =
true))
+    {
+        msg(M_INFO, "Failure to convert resolve result for  =
%s:%s", ce->remote, ce->remote_port);
+        goto error;
+    }
+
+    re=
t =3D true;
+
+error:
+    freeaddrinfo(ai);
+    return ret;
+}
+
+static =
void
+multi_create_peer_instance(struct multi_context *m, struct connection=
_entry *ce)
+{
+    struct mroute_addr real;
+    struct openvpn_sockaddr s=
a =3D { 0 };
+
+    /* Remember if we have a udp4 and udp6 link sockets */
=
+    struct link_socket *udp4_link_sock =3D NULL;
+    struct link_socket *=
udp6_link_sock =3D NULL;
+
+    /* Check what kind of UDP sockets we have=
=2E Currently this takes the first
+     * UDP socket with AF_INET and firs=
t AF_INET6=2E We might later consider
+     * giving the user a finer contr=
ol about the outgoing socket selection=2E
+     */
+    for (int i =3D 0; i=
 < m->top=2Ec1=2Elink_sockets_num; i++)
+    {
+        struct addrinfo *bi=
ndlocal =3D m->top=2Ec1=2Elink_socket_addrs[i]=2Ebind_local;
+        if (!=
udp6_link_sock && bindlocal->ai_family =3D=3D AF_INET6 && bindlocal->ai_soc=
ktype =3D=3D SOCK_DGRAM)
+        {
+            udp6_link_sock =3D m->top=
=2Ec2=2Elink_sockets[i];
+        }
+        if (!udp4_link_sock && bindloc=
al->ai_family =3D=3D AF_INET && bindlocal->ai_socktype =3D=3D SOCK_DGRAM)
+=
        {
+            udp4_link_sock =3D m->top=2Ec2=2Elink_sockets[i];
+ =
       }
+    }
+
+    /* Check if we can resolve the remote address=2E Thi=
s method will already
+     * print warnings if it cannot resolve, so just =
return here when it fails */
+    if (!multi_resolve_peer_addr(ce, &real, &=
sa, (udp4_link_sock !=3D NULL), (udp6_link_sock !=3D NULL)))
+    {
+      =
  return;
+    }
+
+    struct multi_instance *existing_mi =3D hash_lookup(=
m->hash, &real);
+    if (existing_mi)
+    {
+        msg(D_MULTI_LOW, "Ca=
nnot establish connection to %s:%s=2E Client or peer "
+                   =
      "instance with this IP and port already exists",
+            ce->rem=
ote, ce->remote_port);
+        return;
+    }
+
+    struct link_socket *l=
ink_sock =3D NULL;
+
+    if (proto_is_dgram(ce->proto) && (real=2Etype & M=
R_ADDR_MASK) =3D=3D MR_ADDR_IPV4)
+    {
+        link_sock =3D udp4_link_s=
ock;
+    }
+    else if (proto_is_dgram(ce->proto) && (real=2Etype & MR_AD=
DR_MASK) =3D=3D MR_ADDR_IPV6)
+    {
+        link_sock =3D udp6_link_sock;=

+    }
+
+    if (!link_sock)
+    {
+        msg(D_MULTI_LOW, "Cannot det=
ermine outgoing socket for %s:%s %s=2E",
+            ce->remote, ce->remot=
e_port, proto2ascii(ce->proto, sa=2Eaddr=2Esa=2Esa_family, true));
+       =
 return;
+    }
+
+    struct multi_instance *mi =3D multi_create_instance(=
m, &real, link_sock, true);
+
+    if (!mi)
+    {
+        msg(D_MULTI_LOW=
, "Cannot create multi instance for %s:%s %s=2E",
+            ce->remote, =
ce->remote_port, proto2ascii(ce->proto, sa=2Eaddr=2Esa=2Esa_family, true));=

+        return;
+    }
+
+    multi_assign_peer_id(m, mi);
+
+    /* todo=
 check */
+    mi->did_real_hash =3D true;
+    ASSERT(hash_add(m->hash, &m=
i->real, mi, false));
+
+
+    /* This should be probably handled by settin=
g link_socket_info while
+     * creating the multi_instance */
+    struct=
 key_state *ks =3D &mi->context=2Ec2=2Etls_multi->session[TM_INITIAL]=2Ekey=
[KS_PRIMARY];
+    ks->remote_addr=2Edest =3D sa;
+
+    mi->context=2Ec2=
=2Etls_multi->n_sessions++;
+    ce->peer_connection_initiated =3D true;
+}=

+
+static void
+check_peer_connections(struct multi_context *m)
+{
+    /*=
 If no peers are configured, there is nothing to do */
+    if (!m->top=2Eo=
ptions=2Epeer_list)
+    {
+        return;
+    }
+
+    for (int i =3D 0;=
 i < m->top=2Eoptions=2Epeer_list->len; i++)
+    {
+        struct connect=
ion_entry *ce =3D m->top=2Eoptions=2Epeer_list->array[i];
+        if (!ce-=
>peer_connection_initiated)
+        {
+            multi_create_peer_insta=
nce(m, ce);
+        }
+    }
+}
+
 /*
  * Process timers in the top-level =
context
  */
@@ -3903,6 +4128,12 @@
     {
         check_stale_routes(m);
=
     }
+
+    /* Should we check for mesh peers that need to connect? */
+ =
   if (m->top=2Eoptions=2Econnection_list && peer_connection_trigger(m))
+ =
   {
+        check_peer_connections(m);
+    }
 }
 
 static void
diff --gi=
t a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 98547b0=2E=2Ea5c4ce=
5 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -220,6 =
+220,9 @@
      */
     struct event_timeout stale_routes_check_et;
 
+    =
/** Timer object for peer connection check */
+    struct event_timeout pee=
r_connection_et;
+
 #ifdef ENABLE_ASYNC_PUSH
     /* mapping between inotif=
y watch descriptors and multi_instances */
     struct hash *inotify_watche=
rs;
@@ -274,7 +277,8 @@
 
 struct multi_instance *multi_create_instance(str=
uct multi_context *m,
                                              const s=
truct mroute_addr *real,
-                                             stru=
ct link_socket *sock);
+                                             struct=
 link_socket *sock,
+                                             bool peer=
_connection);
 
 void multi_close_instance(struct multi_context *m, struct =
multi_instance *mi, bool shutdown);
 
diff --git a/src/openvpn/options=2Eh =
b/src/openvpn/options=2Eh
index 353a9a4=2E=2Ea7fa9fc 100644
--- a/src/openv=
pn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -107,6 +107,8 @@
 
 struct =
connection_entry
 {
+    /* TODO: actually check */
+    bool peer_connecti=
on_initiated;
     struct local_list *local_list;
     int proto;
     sa_f=
amily_t af;
@@ -759,9 +761,10 @@
 #define OPT_P_INLINE          (1u << 29)
=
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1=
u << 31)
-#define OPT_P_PEER            (1u << 32)
+#define OPT_P_PEER     =
       (1uLL << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL=
_MODE))
+/* Use 0uLL to force 64-bit here */
+#define OPT_P_DEFAULT (~(0uLL=
 | OPT_P_INSTANCE | OPT_P_PULL_MODE))
 
 #define PULL_DEFINED(opt) ((opt)->=
pull)
 
diff --git a/src/openvpn/socket_util=2Ec b/src/openvpn/socket_util=
=2Ec
index 0194f38=2E=2Eb0ccfcf 100644
--- a/src/openvpn/socket_util=2Ec
++=
+ b/src/openvpn/socket_util=2Ec
@@ -590,7 +590,7 @@
 
     /* if hostname i=
s not set, we want to bind to 'ANY', with
      * the correct address famil=
y - v4-only or v6/v6-dual-stack */
-    if (!hostname)
+    if (!hostname |=
| (flags & GETADDR_FORCE_FAMILY))
     {
         hints=2Eai_family =3D ai_=
family;
     }
diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socke=
t_util=2Eh
index 13deeaa=2E=2Ecb4f9ab 100644
--- a/src/openvpn/socket_util=
=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -126,6 +126,7 @@
 #define GETADDR=
_RANDOMIZE               (1u << 9)
 #define GETADDR_PASSIVE                =
 (1u << 10)
 #define GETADDR_DATAGRAM                (1u << 11)
+#define GE=
TADDR_FORCE_FAMILY            (1u << 12)
 
 #define GETADDR_CACHE_MASK (GET=
ADDR_DATAGRAM | GETADDR_PASSIVE)
 
diff --git a/src/openvpn/ssl=2Ec b/src/o=
penvpn/ssl=2Ec
index 22b3f48=2E=2E245f937 100644
--- a/src/openvpn/ssl=2Ec
=
+++ b/src/openvpn/ssl=2Ec
@@ -2458,7 +2458,7 @@
         setenv_del(session=
->opt->es, "exported_keying_material");
     }
 
-    if (!session->opt->se=
rver && !session->opt->pull && ks->key_id =3D=3D 0)
+    if (!session->opt-=
>server && !session->opt->pull && ks->key_id =3D=3D 0 && session->opt->mode=
 !=3D MODE_SERVER)
     {
         /* We are a p2p tls-client without pull,=
 enable common
          * protocol options */

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1824?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ic3a0809191addea024ff8bd69600f4dbad9c37a6
Gerr=
it-Change-Number: 1824
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--ZRteESgjDvk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1824?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Implement basic multipeer support=2E<br><br>Current restriction:<b=
r>- no tls-crypt-v2 support<br>- no TCP support<br>- no retry logic ( only =
one attempt at establishing a connection)<br>- only literal IP:port support=
 for peer<br><br>Change-Id: Ic3a0809191addea024ff8bd69600f4dbad9c37a6<br>Si=
gned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvp=
n/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/init=2Eh<br>M src/open=
vpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/=
openvpn/multi=2Eh<br>M src/openvpn/options=2Eh<br>M src/openvpn/socket_util=
=2Ec<br>M src/openvpn/socket_util=2Eh<br>M src/openvpn/ssl=2Ec<br>11 files =
changed, 342 insertions(+), 21 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/24/1824/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>=
index d4beb04=2E=2E9c3e71d 100644</span><br><span>--- a/src/openvpn/dco=2Ec=
</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -365,6 +365,1=
3 @@</span><br><span>         }</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;peer_lis=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;Not=
e: peer connections require asymmetric peer-id, &quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                      &quot;disabling da=
ta channel offload&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> #if defined(_WIN32)</span><br><span>     if ((o-&gt;mode =3D=
=3D MODE_SERVER) &amp;&amp; !dco_win_supports_multipeer())</span><br><span>=
     {</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index 0e649f8=2E=2Ee8644f4 100644</span><br><span>--- =
a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br=
><span>@@ -4818,12 +4818,19 @@</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-inherit=
_context_child(struct context *dest, const struct context *src, struct link=
_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+inher=
it_context_child(struct context *dest, const struct context *src, struct li=
nk_socket *sock, bool peer_connection)</span><br><span> {</span><br><span> =
    CLEAR(*dest);</span><br><span> </span><br><span>     /* proto_is_dgram =
will ASSERT(0) if proto is invalid */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    dest-&gt;mode =3D proto_is_dgram(sock-&gt;info=2Eproto)=
 ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (peer_connection)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        dest-&gt;mode =3D proto_is_dgram(sock-&gt;info=2Eproto) ? CM_PEE=
R_UDP : CM_PEER_TCP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        dest-&gt;mode =3D proto_is_dgr=
am(sock-&gt;info=2Eproto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><spa=
n>     dest-&gt;gc =3D gc_new();</span><br><span> </span><br><span>@@ -4854=
,6 +4861,12 @@</span><br><span> </span><br><span>     dest-&gt;c2=2Eevent_s=
et =3D src-&gt;c2=2Eevent_set;</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (peer_connection)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        dest-&gt;options=2Etls_client =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        dest-&gt;options=2E=
tls_server =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     if (dest-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>     {</sp=
an><br><span>         /*</span><br><span>@@ -4893,7 +4906,7 @@</span><br><s=
pan>         ALLOC_OBJ_GC(dest-&gt;c2=2Elink_socket_infos[0], struct link_s=
ocket_info, &amp;dest-&gt;gc);</span><br><span>         *dest-&gt;c2=2Elink=
_socket_infos[0] =3D sock-&gt;info;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* locally override some link_socke=
t_info fields */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* locally override some link_socket_info fields=2E FIXME: copy from r=
ight socket?! */</span><br><span>         dest-&gt;c2=2Elink_socket_infos[0=
]-&gt;lsa =3D &amp;dest-&gt;c1=2Elink_socket_addrs[0];</span><br><span>    =
     dest-&gt;c2=2Elink_socket_infos[0]-&gt;connection_established =3D fals=
e;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/init=2Eh=
 b/src/openvpn/init=2Eh</span><br><span>index 9d5050d=2E=2Ecc2f90a 100644</=
span><br><span>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/openvpn=
/init=2Eh</span><br><span>@@ -102,7 +102,7 @@</span><br><span> bool do_defe=
rred_options(struct context *c, const uint64_t found, const bool is_update)=
;</span><br><span> </span><br><span> void inherit_context_child(struct cont=
ext *dest, const struct context *src,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                           struct link_socket *sock);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  struct link_socket *sock, bool peer_connection);</span><br><span> </span>=
<br><span> void inherit_context_top(struct context *dest, const struct cont=
ext *src);</span><br><span> </span><br><span>diff --git a/src/openvpn/mtcp=
=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index eb4e944=2E=2Edde38b7 1006=
44</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/ope=
nvpn/mtcp=2Ec</span><br><span>@@ -43,7 +43,7 @@</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span>     struct multi_instance *mi =
=3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    mi =3D multi_create_instance(m, NULL, sock);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    mi =3D multi_create_instance(m, NULL=
, sock, false);</span><br><span>     if (mi)</span><br><span>     {</span><=
br><span>         mi-&gt;real=2Eproto =3D sock-&gt;info=2Eproto;</span><br>=
<span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><s=
pan>index 657055c=2E=2Ef74e74c 100644</span><br><span>--- a/src/openvpn/mud=
p=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -231,7 =
+231,7 @@</span><br><span>              * connect-freq but not against conn=
ect-freq-initial */</span><br><span>             reflect_filter_rate_limit_=
decrease(m-&gt;initial_rate_limiter);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            mi =3D multi_create_instance(=
m, real, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        mi =3D multi_create_instance(m, real, sock, false);</span><br><span=
>             if (mi)</span><br><span>             {</span><br><span>      =
           multi_assign_peer_id(m, mi);</span><br><span>@@ -283,11 +283,9 @=
@</span><br><span> }</span><br><span> </span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static struct multi_instance *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_instance_udp_control(=
struct multi_context *m)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static inline struct session_id</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+multi_get_extract_sesison_id(struct multi_context *m)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
Copy buffer, to a tmp buffer, so that reading the sesison does not</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * modify the internal poi=
nters */</span><br><span>     struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</=
span><br><span> </span><br><span>     /* op code */</span><br><span>@@ -296=
,7 +294,17 @@</span><br><span> </span><br><span>     struct session_id sid =
=3D { 0 };</span><br><span>     session_id_read(&amp;sid, &amp;tmp);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return sid;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static struct multi_instance *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_=
udp_control(struct multi_context *m)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Copy buffer, to a tmp buffer, so that reading the sesison does not</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modify the inte=
rnal pointers */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid =3D multi_get_e=
xtract_sesison_id(m);</span><br><span>     struct hash_element *he_sid =3D =
multi_hash_sid_lookup(m, &amp;sid);</span><br><span> </span><br><span>     =
if (he_sid)</span><br><span>@@ -336,7 +344,16 @@</span><br><span>          =
       =3D=3D sock-&gt;info=2Eproto)</span><br><span>             {</span><=
br><span>                 mi =3D m-&gt;instances[peer_id];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                *floated =3D !link_soc=
ket_actual_match(&amp;mi-&gt;context=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Efro=
m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                /* FIXME:figure out=
 if we want to setup from at the right place */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                if (mi-&gt;context=2Ec2=2Efrom=
=2Edest=2Eaddr=2Esa=2Esa_family =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    *floated =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    *floated =3D !link_=
socket_actual_match(&amp;mi-&gt;context=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2E=
from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   }</span><br><span> </span><br><span>                 if (*floated)</span=
><br><span>                 {</span><br><span>@@ -359,6 +376,44 @@</span><b=
r><span>     return NULL;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static struct multi_instance *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_ud=
p_peer(struct multi_context *m, struct mroute_addr *real)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* If we have an outgoing connection we need to loo=
k it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * up some =
way=2E Since this might be a tls-crypt-v2 session,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * we would need the tls-crypt-v2 key be=
fore decrypting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * the packet, so we fall back to a simple lookup by address</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * here */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D multi=
_get_instance_udp_real(m, real);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct key_state *ks =3D get_p=
rimary_key(mi-&gt;context=2Ec2=2Etls_multi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(ks);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (session_id_defined(&amp;ks-&gt;session_id_remo=
te))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(D_MULTI_MEDIUM, &quot;Peer connection: Peer already has established &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
              &quot;session id %s=2E&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            mroute_addr_print(real, &amp;gc));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* we now just assume that =
this a possible session id for the session</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * and therefore add the hash of the remote sess=
ion id to the hash map */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We mig=
ht have had another reset packet before */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (session_id_defined(&amp;mi-&gt;sid_hashed_va=
lue))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        multi_hash_sid_remov=
e(m, &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct session_id sid =3D multi_get_extract_sesison_id(m);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    multi_hash_sid_add(m, &amp=
;sid, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct multi_i=
nstance *</span><br><span> multi_get_create_instance_udp(struct multi_conte=
xt *m, bool *floated, struct link_socket *sock)</span><br><span> {</span><b=
r><span>@@ -400,7 +455,14 @@</span><br><span>          * packets can create=
 a session=2E Data packets cannot */</span><br><span>         if (!mi)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            mi =3D handle_connection_attempt(m, sock, &amp;real);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (op !=3D P_CO=
NTROL_HARD_RESET_SERVER_V2)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                mi =3D handle_connection_attempt(m, sock, &amp;real);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                mi =3D multi_get_insta=
nce_udp_peer(m, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span>         }</span><br><span>     }</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec</span><br><span>index ff9121d=2E=2E0b7dd02 100644</span><br>=
<span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -422,6 +422,13 @@</span><br><span>         event_ti=
meout_init(&amp;m-&gt;stale_routes_check_et, t-&gt;options=2Estale_routes_c=
heck_interval, 0);</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (t-&gt;options=2Econnection_=
list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* For now we will c=
heck every 7s=2E Might later add an option</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * to change the interval as a user */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        event_timeout_ini=
t(&amp;m-&gt;peer_connection_et, 7, now);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     m-&gt;deferred_shutdown_signal=2Esignal_recei=
ved =3D 0;</span><br><span> }</span><br><span> </span><br><span>@@ -717,7 +=
724,7 @@</span><br><span>  */</span><br><span> struct multi_instance *</spa=
n><br><span> multi_create_instance(struct multi_context *m, const struct mr=
oute_addr *real,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                 struct link_socket *sock)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                      struct link_socket *sock, bool=
 peer_connection)</span><br><span> {</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span>     struct multi_instance *mi;</span><br><=
span>@@ -738,7 +745,7 @@</span><br><span>         generate_prefix(mi);</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    inherit_context_child(&amp;mi-&gt;context, &amp;m-&gt;to=
p, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inheri=
t_context_child(&amp;mi-&gt;context, &amp;m-&gt;top, sock, peer_connection)=
;</span><br><span>     if (IS_SIG(&amp;mi-&gt;context))</span><br><span>   =
  {</span><br><span>         goto err;</span><br><span>@@ -749,7 +756,7 @@<=
/span><br><span>     if (hash_n_elements(m-&gt;hash) &gt;=3D m-&gt;max_clie=
nts)</span><br><span>     {</span><br><span>         msg(D_MULTI_ERRORS,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;MULTI:=
 new incoming connection would exceed maximum number of clients (%d)&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;M=
ULTI: new connection would exceed maximum number of clients (%d)&quot;,</sp=
an><br><span>             m-&gt;max_clients);</span><br><span>         goto=
 err;</span><br><span>     }</span><br><span>@@ -1791,7 +1798,7 @@</span><b=
r><span> </span><br><span>     /* Print a warning if we detect the client b=
eing in P2P mode=2E The</span><br><span>      * negotiations will be otherw=
ise compatible */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (proto &amp; IV_PROTO_NCP_P2P)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (proto &amp; IV_PROTO_NCP_P2P &amp;&amp; !cm_mode_peer=
(c-&gt;mode))</span><br><span>     {</span><br><span>         multi_client_=
set_protocol_warnings_p2p(c);</span><br><span>     }</span><br><span>@@ -25=
20,6 +2527,19 @@</span><br><span> multi_client_connect_real_addr(struct mul=
ti_context *m, struct multi_instance *mi,</span><br><span>                 =
               bool deferred, uint64_t *option_types_found)</span><br><span=
> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cm_mode_=
peer(mi-&gt;context=2Emode))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* If we have a multi client instance it should already be assigned</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * to its addres=
s in its creation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        bool address_assigned =3D hash_lookup(m-&gt;hash, &amp;mi-&gt;real=
) =3D=3D mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!address_assigned)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(D_MULTI_ERRORS, &quot;MULTI: Address for client connection is &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                &quot;not correctly set up=2E Terminating connection&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return address_assig=
ned ? CC_RET_SUCCEEDED : CC_RET_FAILED;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     /* If the address is already taken up by anothe=
r client we fail the new</span><br><span>      * connection */</span><br><s=
pan>     if (!multi_check_dest_addr_allowed(m, mi, &amp;mi-&gt;real))</span=
><br><span>@@ -2537,6 +2557,30 @@</span><br><span> }</span><br><span> </spa=
n><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
This checks if all the conditions of an outgoing peer connection are met=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static enum client_connect_return</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_connect_=
peer(struct multi_context *m, struct multi_instance *mi,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                          bool deferre=
d, uint64_t *option_types_found)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!cm_mode_peer(mi-&gt;context=2Emode))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return CC_RET_SUCCEEDED;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tl=
s_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;use_asymmetric_peer_id=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS, &quo=
t;Connecting to another server/peer requires &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            &quot;asymmet=
ric peer-id support=2E The peer lacks this &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            &quot;support=2E =
Terminating connection=2E&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return CC_RET_FAILED;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n CC_RET_SUCCEEDED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  *  Do the neces=
sary modification for doing the compress migrate=2E This is</span><br><span=
>  *  implemented as a connect handler as it fits the modify config for a c=
lient</span><br><span>  *  paradigm and also is early enough in the chain t=
o be overwritten by another</span><br><span>@@ -2630,6 +2674,7 @@</span><br=
><span>     uint64_t *option_types_found);</span><br><span> </span><br><spa=
n> static const multi_client_connect_handler client_connect_handlers[] =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_client_c=
onnect_peer,</span><br><span>     multi_client_connect_real_addr,</span><br=
><span>     multi_client_connect_compress_migrate,</span><br><span>     mul=
ti_client_connect_source_ccd,</span><br><span>@@ -3873,6 +3918,186 @@</span=
><br><span>     return event_timeout_trigger(&amp;m-&gt;stale_routes_check_=
et, &amp;null, ETT_DEFAULT);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+peer_connection_trigger(struct multi_=
context *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct timeval null;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(null);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return event_timeout=
_trigger(&amp;m-&gt;peer_connection_et, &amp;null, ETT_DEFAULT);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
multi_resolve_peer_addr(struct connection_entry *ce, struct mroute_addr *re=
al, struct openvpn_sockaddr *sa,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        bool have_udp4, bool have_udp6)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D GETADDR_RESOLVE |=
 GETADDR_WARN_ON_SIGNAL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (proto_is_dgram(ce-&gt;proto))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!have_udp6 &amp;&amp; !have_udp4)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;Cannot connect to %s=
:%s: no UDP sockets available&quot;, ce-&gt;remote, ce-&gt;remote_port);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D GETADDR=
_DATAGRAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (have_udp6 &amp;&amp; !have_udp4)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* The address family need=
s to match the socket address family=2E If we only</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * have IPv6 sockets, we force IPv6 =
mapped IPv4 address with this=2E For</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * TCP client, we create new sockets and don&#39;t=
 have to worry about this */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        flags |=3D GETADDR_FORCE_FAMILY;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct addrinfo *ai;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int status =3D openvpn_getaddrinfo(flags, ce-&gt;remote, ce-&gt;remot=
e_port, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                            NULL, AF_INET6, &amp;ai);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (status !=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_INFO, &quot;Failure to resolve %s:%s as peer address=
=2E Currently only &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    &quot;literal IP/IPv6 addresses are supported&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ce-&=
gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        goto error;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mroute_addr_init(=
real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    real-&gt;=
proto =3D proto_is_dgram(ce-&gt;proto) ? PROTO_UDP : PROTO_TCP;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (ai-&gt;ai_family =3D=3D AF_INET)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_in *sin =3D (stru=
ct sockaddr_in *)ai-&gt;ai_addr;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        sa-&gt;addr=2Ein4 =3D *sin;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else if (ai-&gt;ai_family =3D=3D AF_INET6)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct sockaddr_in6 *sin6 =3D (struct s=
ockaddr_in6 *)ai-&gt;ai_addr;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        sa-&gt;addr=2Ein6 =3D *sin6;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSE=
RT(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!mroute_extract_openvpn_sockaddr(real,=
 sa, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &q=
uot;Failure to convert resolve result for  %s:%s&quot;, ce-&gt;remote, ce-&=
gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ret =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+error:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_create_peer_instance(struct multi_c=
ontext *m, struct connection_entry *ce)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct mroute_addr real;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct openvpn_sockaddr sa =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Remember if we have a udp4 and udp6 link sockets */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socke=
t *udp4_link_sock =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct link_socket *udp6_link_sock =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Check what kind of UDP sockets we have=2E Currentl=
y this takes the first</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * UDP socket with AF_INET and first AF_INET6=2E We might later cons=
ider</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * giving t=
he user a finer control about the outgoing socket selection=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; m-&gt;top=2Ec1=
=2Elink_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct addrinfo *bindlocal =3D m-&gt;top=2Ec1=2Elink_socket_addrs[i]=2Ebind=
_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
!udp6_link_sock &amp;&amp; bindlocal-&gt;ai_family =3D=3D AF_INET6 &amp;&am=
p; bindlocal-&gt;ai_socktype =3D=3D SOCK_DGRAM)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            udp6_link_sock =3D m-&gt;top=2Ec2=2Elink_sock=
ets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!udp4_link=
_sock &amp;&amp; bindlocal-&gt;ai_family =3D=3D AF_INET &amp;&amp; bindloca=
l-&gt;ai_socktype =3D=3D SOCK_DGRAM)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            udp4_link_sock =3D m-&gt;top=2Ec2=2Elink_sockets[i];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Check if we can resolve the remote address=2E This method w=
ill already</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * p=
rint warnings if it cannot resolve, so just return here when it fails */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_resolve=
_peer_addr(ce, &amp;real, &amp;sa, (udp4_link_sock !=3D NULL), (udp6_link_s=
ock !=3D NULL)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct multi_instance *existing_mi =3D hash_lookup=
(m-&gt;hash, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (existing_mi)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(D_MULTI_LOW, &quot;Cannot establish connection to %s:%s=2E Client or pe=
er &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
               &quot;instance with this IP and port already exists&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ce-&gt;re=
mote, ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket *link_s=
ock =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (proto_is_dgram(ce=
-&gt;proto) &amp;&amp; (real=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        link_sock =3D udp4_link_=
sock;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else if (proto_is_dgram(=
ce-&gt;proto) &amp;&amp; (real=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IP=
V6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        link_sock =3D udp6_lin=
k_sock;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!link_sock)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;Cannot determine outgoing so=
cket for %s:%s %s=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            ce-&gt;remote, ce-&gt;remote_port, proto2ascii(ce-&gt;p=
roto, sa=2Eaddr=2Esa=2Esa_family, true));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mult=
i_instance *mi =3D multi_create_instance(m, &amp;real, link_sock, true);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!mi)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(D_MULTI_LOW, &quot;Cannot create multi instance fo=
r %s:%s %s=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            ce-&gt;remote, ce-&gt;remote_port, proto2ascii(ce-&gt;proto, s=
a=2Eaddr=2Esa=2Esa_family, true));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_assign_peer_=
id(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* todo check */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_real_hash =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(hash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* This should be probably handled by setting link_socket_info while</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * creating the multi_=
instance */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct key_state *ks =3D &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[TM_IN=
ITIAL]=2Ekey[KS_PRIMARY];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ks-&gt;remote_addr=2Edest =3D sa;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ce-&gt;peer_connection_initiated=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+check_peer_connections(struct multi_context *m)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* If no peers are configured, there is =
nothing to do */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!m-&gt;top=2Eoptions=2Epeer_list)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; m-&=
gt;top=2Eoptions=2Epeer_list-&gt;len; i++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct connection_entry *ce =3D m-&gt;top=2Eoptions=2Epeer=
_list-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!ce-&gt;peer_connection_initiated)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            multi_create_peer_instance(m, ce);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /*</span><br><span>  * Process timers in the top-level =
context</span><br><span>  */</span><br><span>@@ -3903,6 +4128,12 @@</span><=
br><span>     {</span><br><span>         check_stale_routes(m);</span><br><=
span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Should we check for =
mesh peers that need to connect? */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (m-&gt;top=2Eoptions=2Econnection_list &amp;&amp; pe=
er_connection_trigger(m))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
check_peer_connections(m);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span> }</span><br><span> </span><br><span> static v=
oid</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh</span><br><span>index 98547b0=2E=2Ea5c4ce5 100644</span><br><span>--- =
a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><=
br><span>@@ -220,6 +220,9 @@</span><br><span>      */</span><br><span>     =
struct event_timeout stale_routes_check_et;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /** Timer object for peer con=
nection check */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct event_timeout peer_connection_et;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br>=
<span>     /* mapping between inotify watch descriptors and multi_instances=
 */</span><br><span>     struct hash *inotify_watchers;</span><br><span>@@ =
-274,7 +277,8 @@</span><br><span> </span><br><span> struct multi_instance *=
multi_create_instance(struct multi_context *m,</span><br><span>            =
                                  const struct mroute_addr *real,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
              struct link_socket *sock);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                             struct li=
nk_socket *sock,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                          bool peer_connection);</span><br>=
<span> </span><br><span> void multi_close_instance(struct multi_context *m,=
 struct multi_instance *mi, bool shutdown);</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br=
><span>index 353a9a4=2E=2Ea7fa9fc 100644</span><br><span>--- a/src/openvpn/=
options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@=
@ -107,6 +107,8 @@</span><br><span> </span><br><span> struct connection_ent=
ry</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* TODO: actually check */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool peer_connection_initiated;</span><br><span>     struc=
t local_list *local_list;</span><br><span>     int proto;</span><br><span> =
    sa_family_t af;</span><br><span>@@ -759,9 +761,10 @@</span><br><span> #=
define OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><span> #define OPT_=
P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TAB=
LE     (1u &lt;&lt; 31)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define OPT_P_PEER            (1u &lt;&lt; 32)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define OPT_P_PEER            (1uLL &lt;&lt; 3=
2)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Use 0uLL to force 64-bit here */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAUL=
T (~(0uLL | OPT_P_INSTANCE | OPT_P_PULL_MODE))</span><br><span> </span><br>=
<span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><=
br><span>diff --git a/src/openvpn/socket_util=2Ec b/src/openvpn/socket_util=
=2Ec</span><br><span>index 0194f38=2E=2Eb0ccfcf 100644</span><br><span>--- =
a/src/openvpn/socket_util=2Ec</span><br><span>+++ b/src/openvpn/socket_util=
=2Ec</span><br><span>@@ -590,7 +590,7 @@</span><br><span> </span><br><span>=
     /* if hostname is not set, we want to bind to &#39;ANY&#39;, with</spa=
n><br><span>      * the correct address family - v4-only or v6/v6-dual-stac=
k */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!hostname=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!hostname =
|| (flags &amp; GETADDR_FORCE_FAMILY))</span><br><span>     {</span><br><sp=
an>         hints=2Eai_family =3D ai_family;</span><br><span>     }</span><=
br><span>diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=
=2Eh</span><br><span>index 13deeaa=2E=2Ecb4f9ab 100644</span><br><span>--- =
a/src/openvpn/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socket_util=
=2Eh</span><br><span>@@ -126,6 +126,7 @@</span><br><span> #define GETADDR_R=
ANDOMIZE               (1u &lt;&lt; 9)</span><br><span> #define GETADDR_PAS=
SIVE                 (1u &lt;&lt; 10)</span><br><span> #define GETADDR_DATA=
GRAM                (1u &lt;&lt; 11)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define GETADDR_FORCE_FAMILY            (1u &lt;&lt; 12)</=
span><br><span> </span><br><span> #define GETADDR_CACHE_MASK (GETADDR_DATAG=
RAM | GETADDR_PASSIVE)</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 22b3f48=2E=2E245=
f937 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b=
/src/openvpn/ssl=2Ec</span><br><span>@@ -2458,7 +2458,7 @@</span><br><span>=
         setenv_del(session-&gt;opt-&gt;es, &quot;exported_keying_material&=
quot;);</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!session-&gt;opt-&gt;server &amp;&amp; !=
session-&gt;opt-&gt;pull &amp;&amp; ks-&gt;key_id =3D=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!session-&gt;opt-&gt;server=
 &amp;&amp; !session-&gt;opt-&gt;pull &amp;&amp; ks-&gt;key_id =3D=3D 0 &am=
p;&amp; session-&gt;opt-&gt;mode !=3D MODE_SERVER)</span><br><span>     {</=
span><br><span>         /* We are a p2p tls-client without pull, enable com=
mon</span><br><span>          * protocol options */</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1824?usp=3Demail">change 1824</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1824?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Ic3a0809191addea024ff8bd69600f4dbad9c37a6 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1824 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--ZRteESgjDvk=--


--===============1963206915996810538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1963206915996810538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1963206915996810538==--

