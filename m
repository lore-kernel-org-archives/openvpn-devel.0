Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24CAC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8kvPsQmf3dwXp+Nw3Mc7OXefyNmKZUSd1IMwm1Xmx60=; b=fJEzKftDFmFb0Lci8HN5l4PNYG
	oNFPpkGTq+CscfbV5tEMAsyZYBxONT1+FhUO+R2ArgsHMdrzY1RArcVpyKQwqD4QK0ZHSaTMihfFn
	D1mpABKEery/gR8FxtP4yGK6Or2Cc5zAcQ8D9uTK/H6YWNAggy9OB6cDLASvkuQHhYnQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvvgZ-0001OT-33;
	Mon, 17 Aug 2026 11:39:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvvgX-0001OL-9i
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:39:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2S3bh1FDQ1e297argrnE+u/6cqRqlLf7mEI9XvVLYuY=; b=GzRug2XoaAMG6bAOFSkFKRB1MY
 5RICa5rEvt3G4/67ZcL/0RbWYrG/EZ1YEbnHbT8haFP7dtigE23SYkMOuBG/j9KQkC5b7sMH9HzDC
 +lDgSKVleV4QBROJi/OFL8yZQ/1Ywumq23xwMibpE4wDJ7bmH8zCRpT33qwCl0JKFS7M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2S3bh1FDQ1e297argrnE+u/6cqRqlLf7mEI9XvVLYuY=; b=e
 dwN8UHu0ShSo26TP87lOR+viWdUMk4HtO2SC45VPwr0SUhOuYN5gc0qXPq/O0IwD+YBTfCtp/EpR0
 y/ZaNkfoiPhfPC22wthZ7EAWYgvj0mefDPqHTp83z7UJ5Ua51NaYqVu25AP9xV8lC54W9iPI5uUNa
 PL2paxyifw7D0edg=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvvgV-0003ee-QW for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:39:21 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so40986775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786966753; x=1787571553; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2S3bh1FDQ1e297argrnE+u/6cqRqlLf7mEI9XvVLYuY=;
 b=CCCwgFs5L+U/JPnnJiz7Rv+ZiP7rLZ5xvRXPBdTaF+JcV4CsKrm4xPqRCirmf3L60C
 mOhjQgR5Yv6qxODc3McX7+lldEAT9Xk2PZkR/XFAPrc4vGsdiXK/6cIbffRAuvrCexI3
 ep1JP9/GMAcCT6iZ7pkAcgXA03wsx5oM3SL8nPLpc0vdtO+OGQl5fFcs+0uvGaePYowt
 f+iAayeNJCUhYhsuZDTd3S6SHlGN0BXayw8q0oA5YqTmIzEn4qIzmUY7OQ0zny6y+gBw
 VS8BG6YJSI9pGSG09fxYrp8hC2FvS0TC5uL6bV5Vb+82qvFLHKPY2hwKCBRkN0ZVdA3H
 MbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786966753; x=1787571553;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2S3bh1FDQ1e297argrnE+u/6cqRqlLf7mEI9XvVLYuY=;
 b=ctiksD909Ju9C5tPEMmNtQl1QPF21IiJwCB0I4I1j3mh3BpOwonVcoPmYlYOistDQ1
 LSLzzaZ7OqGO07khRbgLWi/HqYfHhbUXoeVyzl/h3XojM1EbPxIpAPoFzMBRbTzPqM2d
 qo/1wHLrFTv/YodIZvuX6jP6lHDCoUAhDX/KJM93GQPDjscOvTqJ+tUHzxzEjQZlTbL1
 0y61jbwu+T23vlRP7U/WX7yq58GQ51Fa37BrGnn0wqG6QcJe1XkKUjNMUaNaiJho1QQq
 EC04osfRBtntsXwIDcBIl3TGR1Xx52Xat745Agn34G8unMGJBkFcGny4RXH7XUKqqkWP
 ODQg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5gprT+X2XuA6szBvScm7gUSqrZGxfj4ceTo2Bm/nqNOzHkr1T08NEWNp4ArzB8jORaLHueMACSON9jnFr@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz5+/zdRaQiCco5/pbO091x5uv0EJYAgP+pStnzh2p62LRcABv5
 BbARhKhs6P/+ceXIlIW/kpNhWkzQC1wI94eR0aE4gTIUMPq0T2xw5bLPoEMnB4Y+gAth4REB5Wa
 UK0/8wHQkzDqBFrOf+u4WI3oWXcjDQuEBl1A8RV6GjmWRQFqpJEppbruBX6dXGQYdpX6U
X-Gm-Gg: AR+sD13nm+5YlHXlxfFjoWgpOnOc4A7vEKZOlYj5Q8ePhAahxOzPRTgXkKDSJfs6azR
 o4pvcF/GB8Rp7OfIEP5qyuAi5xaUUuenTGsEeMgH+kTQ0npEGuwiRbjM1segwAVHKyzDdVG48Ud
 8T9Fl6pwDcy00nRLh8AcC9sM1W3U0YZXbLDtGHsDVXO9wtfuRBOPepBqXSOH1gUQyBfj/qoEU5p
 JOsczZvcdCsySNHlU+yD8dyHfSEcoy9Cu5bcSHILpGZaRxpwYRDZqfqSJRrEod35xIe9O24uEHe
 E62H4to8IcdTPjqcHpqwmXYbfGZCvK+3mcnu08zt6djfSOgkqRtq71eAk3fc4faQVEJx8aeu8MQ
 lE9ovXm89P/+ntro47lPhkdy5ulyWS+6mG/UemQwPg96xcB0WHPJQUbebknGA6GYXMDYghLw/h0
 VU04cd9lPNBg88idNCse75Keyradhvj9MwnPbtQG/1g2b6xTu03A534iDZ6xlZJ/Axt3RoIpnZd
 OLgtRcsrzU4ajzkUB33SQDqN5ZOyrZQ/f9WjJ40FswZDVGdOhk1x0jPmr5JbGxG3pNSQamCVD1q
 ypE7kFL9p+WikN9hzWVvW8li5mQRyny43/MkX/mxe/PAyN7QBmzY7ZlpJsaduA==
X-Received: by 2002:a05:600c:a45:b0:499:48be:3189 with SMTP id
 5b1f17b1804b1-499878ccebcmr308739585e9.0.1786966752856; 
 Mon, 17 Aug 2026 04:39:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610966dsm185607235e9.5.2026.08.17.04.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 04:39:12 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 11:39:08 +0000
To: flichtenheld <frank@lichtenheld.com>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 793301a47dcc96dfdd667c31e923d1c416f069e0
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <da38fec05f10daa6fd2da897f3d5664220e19563-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvvgV-0003ee-QW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9132581103906190196=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9132581103906190196==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4UEj2UOUWkg="; charset=UTF-8

--4UEj2UOUWkg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo flichtenheld, stipa, 

I'd like you to reexamine a change=2E Please vis=
it

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail

to look=
 at the new patch set (#9)=2E


Change subject: Make required action return=
ed from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make required action returned from pre_decrypt=
_verdict more explicit

The current code relies on the condition if state=
=2Eserver_session_id
is defined to decide if session_skip_to_pre_start shou=
ld be used=2E

Instead explicitly return the intent and use that to decide =
if
session_skip_to_pre_start should be called=2E

Change-Id: Iccdd4cfad090c=
565aac27e16cdaa9871106c2f89
---
M src/openvpn/mudp=2Ec
1 file changed, 42 i=
nsertions(+), 19 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/26/1826/9

diff --git a/src/openvpn/mudp=2Ec b/src/=
openvpn/mudp=2Ec
index 632b064=2E=2Eb370b6b 100644
--- a/src/openvpn/mudp=
=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -87,9 +87,24 @@
                        =
   "Reset packet from client, sending HMAC based reset challenge", sock);
 =
}
 
+/**
+ * Verdict if this packet should create a new session=2E If a pac=
ket is invalid
+ * or we send out an HMAC based challenge, we do not want t=
o create a new
+ * session=2E
+ */
+enum pre_decrypt_verdict
+{
+    /** Th=
is packet should not create a new session */
+    PRE_DECRYPT_NO_ACTION,
+ =
   /** This packet creates a new session normally */
+    PRE_DECRYPT_CREAT=
E_SESSION,
+    /** Create a new session but skip the first two packets of
=
+     * the three way handshake */
+    PRE_DECRYPT_CREATE_SESSION_SKIP
+};=

 
-/* Returns true if this packet should create a new session */
-static b=
ool
+/** Returns a verdict if this packet should create a new session */
+s=
tatic enum pre_decrypt_verdict
 do_pre_decrypt_check(struct multi_context *=
m, struct tls_pre_decrypt_state *state,
                      struct mroute=
_addr addr, struct link_socket *sock)
 {
@@ -111,7 +126,7 @@
          * re=
sponses */
         if (!reflect_filter_rate_limit_check(m->initial_rate_li=
miter))
         {
-            return false;
+            return PRE_DECRY=
PT_NO_ACTION;
         }
     }
 
@@ -136,7 +151,7 @@
                 calc=
ulate_session_id_hmac(state->peer_session_id, from, hmac_key, handwindow, 0=
);
             send_hmac_reset_packet(m, state, tas, &sid, true, sock);
 
=
-            return false;
+            return PRE_DECRYPT_NO_ACTION;
     =
    }
         else
         {
@@ -153,11 +168,11 @@
                     "=
ignoring connection attempt from old client (%s)",
                     pee=
r);
                 gc_free(&gc);
-                return false;
+        =
        return PRE_DECRYPT_NO_ACTION;
             }
             else
    =
         {
-                return true;
+                return PRE_DECRYP=
T_CREATE_SESSION;
             }
         }
     }
@@ -170,7 +185,7 @@
    =
     send_hmac_reset_packet(m, state, tas, &sid, false, sock);
 
         /=
* We have a reply do not create a new session */
-        return false;
+  =
      return PRE_DECRYPT_NO_ACTION;
     }
     else if (verdict =3D=3D VER=
DICT_VALID_CONTROL_V1 || verdict =3D=3D VERDICT_VALID_ACK_V1
              =
|| verdict =3D=3D VERDICT_VALID_WKC_V1)
@@ -181,6 +196,7 @@
 
         bool=
 pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
         bool ret =
=3D check_session_hmac_and_pkt_id(state, from, hmac_key, handwindow, pkt_is=
_ack);
+        enum pre_decrypt_verdict action =3D PRE_DECRYPT_NO_ACTION;
=
 
         const char *peer =3D print_link_socket_actual(&m->top=2Ec2=2Efro=
m, &gc);
         uint8_t pkt_firstbyte =3D *BPTR(&m->top=2Ec2=2Ebuf);
@@ -=
198,14 +214,15 @@
                 "Valid packet (%s) with HMAC challenge f=
rom peer (%s), "
                 "accepting new connection=2E",
          =
       packet_opcode_name(op), peer);
+            action =3D PRE_DECRYPT_C=
REATE_SESSION_SKIP;
         }
         gc_free(&gc);
 
-        return ret=
;
+        return action;
     }
 
     /* VERDICT_INVALID */
-    return f=
alse;
+    return PRE_DECRYPT_NO_ACTION;
 }
 
 /**
@@ -220,9 +237,6 @@
    =
                       struct link_socket *sock,
                          =
 struct mroute_addr *real)
 {
-    struct hash *hash =3D m->hash;
-    stru=
ct tls_pre_decrypt_state state =3D { 0 };
-    struct multi_instance *mi =
=3D NULL;
     struct gc_arena gc =3D gc_new();
 
     if (m->deferred_shut=
down_signal=2Esignal_received)
@@ -231,8 +245,17 @@
             "MULTI: Co=
nnection attempt from %s ignored while server is "
             "shutting d=
own",
             mroute_addr_print(real, &gc));
+        gc_free(&gc);
+ =
       return NULL;
     }
-    else if (do_pre_decrypt_check(m, &state, *r=
eal, sock))
+
+    struct hash *hash =3D m->hash;
+    struct tls_pre_decry=
pt_state state =3D { 0 };
+    struct multi_instance *mi =3D NULL;
+
+    e=
num pre_decrypt_verdict verdict =3D do_pre_decrypt_check(m, &state, *real, =
sock);
+
+    if (verdict !=3D PRE_DECRYPT_NO_ACTION)
     {
         /* Th=
is is an unknown session but with valid tls-auth/tls-crypt
          * (or =
no auth at all)=2E  If this is the initial packet of a
@@ -255,14 +278,14 @=
@
                 mi->did_real_hash =3D true;
                 multi_assig=
n_peer_id(m, mi);
 
-                /* If we have a session id already, en=
sure that the
-                 * state is using the same */
-             =
   if (session_id_defined(&state=2Eserver_session_id)
-                    =
&& session_id_defined((&state=2Epeer_session_id)))
+                struct =
tls_session *session =3D
+                    &mi->context=2Ec2=2Etls_multi=
->session[TM_INITIAL];
+
+                if (verdict =3D=3D PRE_DECRYPT_CR=
EATE_SESSION_SKIP)
                 {
+                    /* This verdict =
is only possible if we have a peer session ID */
+                    ASSER=
T(session_id_defined(&state=2Epeer_session_id));
                     mi->c=
ontext=2Ec2=2Etls_multi->n_sessions++;
-                    struct tls_sess=
ion *session =3D
-                        &mi->context=2Ec2=2Etls_multi->se=
ssion[TM_INITIAL];
                     session_skip_to_pre_start(session, =
&state, &m->top=2Ec2=2Efrom);
                 }
             }

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cda=
a9871106c2f89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 9
Gerrit-Owner: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvan=
c <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Att=
ention: stipa <lstipakov@gmail=2Ecom>

--4UEj2UOUWkg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>plaisthos <=
strong>uploaded patch set #9</strong> to this change=2E</p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></=
p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">Make required action returned from pre_decrypt_verdict more=
 explicit<br><br>The current code relies on the condition if state=2Eserver=
_session_id<br>is defined to decide if session_skip_to_pre_start should be =
used=2E<br><br>Instead explicitly return the intent and use that to decide =
if<br>session_skip_to_pre_start should be called=2E<br><br>Change-Id: Iccdd=
4cfad090c565aac27e16cdaa9871106c2f89<br>---<br>M src/openvpn/mudp=2Ec<br>1 =
file changed, 42 insertions(+), 19 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/1826/9<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br>=
<span>index 632b064=2E=2Eb370b6b 100644</span><br><span>--- a/src/openvpn/m=
udp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -87,9=
 +87,24 @@</span><br><span>                           &quot;Reset packet fr=
om client, sending HMAC based reset challenge&quot;, sock);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Verdict if =
this packet should create a new session=2E If a packet is invalid</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * or we send out an HMAC bas=
ed challenge, we do not want to create a new</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * session=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+enum pre_decrypt_verdict</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Th=
is packet should not create a new session */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    PRE_DECRYPT_NO_ACTION,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** This packet creates a new session=
 normally */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE=
_DECRYPT_CREATE_SESSION,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /** Create a new session but skip the first two packets of</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * the three way handsh=
ake */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRY=
PT_CREATE_SESSION_SKIP</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+};</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/* Returns true if this packet should create a new session */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** Returns a verdict if this packet shou=
ld create a new session */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static enum pre_decrypt_verdict</span><br><span> do_pre_decrypt_chec=
k(struct multi_context *m, struct tls_pre_decrypt_state *state,</span><br><=
span>                      struct mroute_addr addr, struct link_socket *soc=
k)</span><br><span> {</span><br><span>@@ -111,7 +126,7 @@</span><br><span> =
         * responses */</span><br><span>         if (!reflect_filter_rate_l=
imit_check(m-&gt;initial_rate_limiter))</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return PRE_D=
ECRYPT_NO_ACTION;</span><br><span>         }</span><br><span>     }</span><=
br><span> </span><br><span>@@ -136,7 +151,7 @@</span><br><span>            =
     calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, h=
andwindow, 0);</span><br><span>             send_hmac_reset_packet(m, state=
, tas, &amp;sid, true, sock);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_ACTION;=
</span><br><span>         }</span><br><span>         else</span><br><span> =
        {</span><br><span>@@ -153,11 +168,11 @@</span><br><span>           =
          &quot;ignoring connection attempt from old client (%s)&quot;,</sp=
an><br><span>                     peer);</span><br><span>                 g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                return PRE_DECRYPT_NO_ACTION;</span><br><span>        =
     }</span><br><span>             else</span><br><span>             {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
return PRE_DECRYPT_CREATE_SESSION;</span><br><span>             }</span><br=
><span>         }</span><br><span>     }</span><br><span>@@ -170,7 +185,7 @=
@</span><br><span>         send_hmac_reset_packet(m, state, tas, &amp;sid, =
false, sock);</span><br><span> </span><br><span>         /* We have a reply=
 do not create a new session */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return PRE_DECRYPT_NO_ACTION;</span><br><span>     }</s=
pan><br><span>     else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 || verd=
ict =3D=3D VERDICT_VALID_ACK_V1</span><br><span>              || verdict =
=3D=3D VERDICT_VALID_WKC_V1)</span><br><span>@@ -181,6 +196,7 @@</span><br>=
<span> </span><br><span>         bool pkt_is_ack =3D (verdict =3D=3D VERDIC=
T_VALID_ACK_V1);</span><br><span>         bool ret =3D check_session_hmac_a=
nd_pkt_id(state, from, hmac_key, handwindow, pkt_is_ack);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        enum pre_decrypt_verdict acti=
on =3D PRE_DECRYPT_NO_ACTION;</span><br><span> </span><br><span>         co=
nst char *peer =3D print_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &am=
p;gc);</span><br><span>         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-&gt;=
top=2Ec2=2Ebuf);</span><br><span>@@ -198,14 +214,15 @@</span><br><span>    =
             &quot;Valid packet (%s) with HMAC challenge from peer (%s), &q=
uot;</span><br><span>                 &quot;accepting new connection=2E&quo=
t;,</span><br><span>                 packet_opcode_name(op), peer);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            action =3D PRE_=
DECRYPT_CREATE_SESSION_SKIP;</span><br><span>         }</span><br><span>   =
      gc_free(&amp;gc);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return action;</span><br><span>     }</span><br=
><span> </span><br><span>     /* VERDICT_INVALID */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return PRE_DECRYPT_NO_ACTION;</span><br><=
span> }</span><br><span> </span><br><span> /**</span><br><span>@@ -220,9 +2=
37,6 @@</span><br><span>                           struct link_socket *sock=
,</span><br><span>                           struct mroute_addr *real)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct tls_pre_decrypt_state state =3D { 0 };</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D NULL=
;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </=
span><br><span>     if (m-&gt;deferred_shutdown_signal=2Esignal_received)</=
span><br><span>@@ -231,8 +245,17 @@</span><br><span>             &quot;MULT=
I: Connection attempt from %s ignored while server is &quot;</span><br><spa=
n>             &quot;shutting down&quot;,</span><br><span>             mrou=
te_addr_print(real, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return NULL;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    else if (do_pre_decrypt_check(m,=
 &amp;state, *real, sock))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct h=
ash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct tls_pre_decrypt_state state =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    enum pre_decrypt_verdict verdict =
=3D do_pre_decrypt_check(m, &amp;state, *real, sock);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (verdict !=3D PRE_DECRYPT_NO_ACTION)</span><br><span>=
     {</span><br><span>         /* This is an unknown session but with vali=
d tls-auth/tls-crypt</span><br><span>          * (or no auth at all)=2E  If=
 this is the initial packet of a</span><br><span>@@ -255,14 +278,14 @@</spa=
n><br><span>                 mi-&gt;did_real_hash =3D true;</span><br><span=
>                 multi_assign_peer_id(m, mi);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                /* If we have a =
session id already, ensure that the</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                 * state is using the same */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (session_id_define=
d(&amp;state=2Eserver_session_id)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    &amp;&amp; session_id_defined((&amp;state=
=2Epeer_session_id)))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                struct tls_session *session =3D</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    &amp;mi-&gt;context=2Ec2=
=2Etls_multi-&gt;session[TM_INITIAL];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)</span><b=
r><span>                 {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    /* This verdict is only possible if we have a pe=
er session ID */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 ASSERT(session_id_defined(&amp;state=2Epeer_session_id));<=
/span><br><span>                     mi-&gt;context=2Ec2=2Etls_multi-&gt;n_=
sessions++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          struct tls_session *session =3D</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        &amp;mi-&gt;context=2Ec2=2Etls_=
multi-&gt;session[TM_INITIAL];</span><br><span>                     session=
_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span>=
<br><span>                 }</span><br><span>             }</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1826?usp=3Demail">change 1826</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa98=
71106c2f89 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1826 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"=
display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
=

</body></html>
--4UEj2UOUWkg=--


--===============9132581103906190196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9132581103906190196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9132581103906190196==--

