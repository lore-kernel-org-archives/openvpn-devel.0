Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D91C88E53
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WDNCB9FjrC4PIiNzonOoyZ8Xj3enEP8m4Gcwt9lub4I=; b=ZOkLrZBLdp3pkpYHiu4DQWK9lW
	jOaBxWN+9iiPckkFSgHphnuh2PWoUfsnKvAV4DC0SW+1DaXcIAENJhve4SB3tUWYzgTZTRScw4i1H
	YKEGAPMJ0TrtGbvIw7aoFDjEfKUGhIzrRltywli/IoPfMrAKIWf1XCK3ikit9Rc+14b0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6SYO-0002ZD-Uw;
	Tue, 15 Sep 2026 12:46:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6SYN-0002Z5-67
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:46:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4POmTqvqx4u82fjpLbPO5vTwMt0ZizQhl4ZUj0qrlTo=; b=b+ujfKBcGD4kp5X9jPshKYyrAW
 qna1UPbcR5XUnK+ZiLquJz77S+AU/3zD29tyyoujqzl3v+gqVGxKybu8XHTHlIFaiQMpzZS/asWAZ
 CuKBg20NZPCCWryTJ4oiVSNDsVTPFGAkJKfZSwp7j+1kThTXfgp3Bpl5XwHGtN4HmjTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4POmTqvqx4u82fjpLbPO5vTwMt0ZizQhl4ZUj0qrlTo=; b=P
 YMx0+nyhkXGL1+MaxNhvzdR7Ufh3CkmkViEzrr1D9zqNqeBxCIzP+iWQA2iONvkYSxz5sutsSSsRA
 aRik496I/WMI6Qcxrj86Fy/55BiqdiXrqwiysJ3A7D2W6uSbWXFfNJO/f1YKk+Ht7feEBnGI79Q/y
 edwtST4/lBJST8QE=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6SYK-0002I0-CZ for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:46:27 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso30270085e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789476378; x=1790081178; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4POmTqvqx4u82fjpLbPO5vTwMt0ZizQhl4ZUj0qrlTo=;
 b=aFEnc+tiB9C+KhK41/5cE1MuT194h7CWOZBXVlmaBOCXSDHpifKsxCZ5vFr3i1RR8/
 pPRMwcdl4iQHDjWfyZ9dTVsEcnk6x3lXkMPHE63d3oogM9iYfNQ0pcZzYntdLdskyvmk
 +v69nFYaQkQ7jw/KatplmZUY3Q+NHNBKnzxrk2QSTAFU1eeVkfq5nz+zvWYg1O8DMP7d
 m5LDS+jubAQfDe5Oj142UaMqePDhytQHO9SW7FddFxMrKpZoH2W3TW3suqoiA32tWTh6
 XBsIlHoeQ0ctV6CcAclQ9agGmJ9WiuSeXTYqNzK9cVzrVDUN+pgNA7lV91iNomenuftm
 Faqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789476378; x=1790081178;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4POmTqvqx4u82fjpLbPO5vTwMt0ZizQhl4ZUj0qrlTo=;
 b=Aem8S5Yn09NY/BYdFxnJzoKD5ga416UbPyYMeD9wfx6Ram3oha6FkoyJHCQEPF2wYT
 gbOHAY6MwQAyeZiwBJj3Nahy9LqlxrjKbtmBd+pFDapL9N4Fx43ffXQKDwgVU0tF64vY
 30MrVjEBFeqiAWm0ErIMvSaALG2njo5t4rlu6zMUtxDTwLtYuWRI2wozRXnwMrrMjMmt
 6nSV0lFs4N0K665j7M8xZUFHeUD8PQWj5YDwcE7h0PZrqd/MiXqQm4sUhKAKzdpRaflO
 5/scDw1vDREVrZQKGDT6TKX5qZQ2VjvwLzzN0zK0DGdqQvhFIyHgG08kewFy7dK6YVzy
 3n/Q==
X-Gm-Message-State: AFuF++k6R+N9IpMkDA/x+RF2fnUF1S+gYVPxYDx8ce7A8cjYALvm2J3F
 3zJsDTUfydvgkJ9TmcQHUUNgLMJJaMSNNiVPjXxSwODE5dVjfKH40lR6bN9kNGbzND0cTqcpVuX
 6WD7izZ8b98/vcEJn48g9g0zpNOYSlqB8NaTWnnTzoi66iFgVEZD+ZDMcwFbvrgGhD+MEnfbdHV
 DLuum+Sg==
X-Gm-Gg: AYBFou1BtMAk8AM23EaJ7JmfwIhC4BcycnyZgSbz11odbJB98XMeUHNvhzXci4mqRgU
 cz/QzE2EotnqbhjdN4Lzo/6BMzy5SlunfjOA/zPDLJ5BVEOj1shwjajjomTyXS1MaNS0aH04Q3w
 T61P84wEgsoDaDZtXYRgk9HQhKKhiGTOwOyOki4RhJ41G8a4wyw2tFsHxBsfBWJhYXLzZV8hpsx
 /aK0WWa/bpYMSMwQPFxV2D01ZLWIqseQ3qWJUW0TJGvOWeQsOcr0s7a2UlA8P4ucbFGnxXLpZQe
 CAAmDij1bVawDe9bi3uiy/ymoQle2fSN41t9eFHeAamE+SvHElvBHXSYvSpBYNG6pGdRrrT0evB
 SCmCDNaNLGJs0FVWvSLg3RTT+IGxmhOINIOkwAwxJvm4MTnT2bDG+N80J+3WDUtF9jOxAqaWqtT
 sAd/e51qktgYIDl4mEt3jBMJDFf3u3VH2/kb8sq6ExU8ocjiK3uxFIfz/5NiImG17Uq+c7ihoIe
 NcXxz6QXjVdLo/uELeH3/OXLDm5r5cPkavGXz1envqc1rdkRMFZiJpfqGL+tBU7pJRgPBbm67Nq
 yzTtaDQWYJ1lHNADLXyGmIsSc2vcduwmTglC3Uyrmcuvx+/UL34Rn7ZdmNrmZL+zYYf4S40m
X-Received: by 2002:a05:600c:3594:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-49e7a66275fmr100293775e9.9.1789476376849; 
 Tue, 15 Sep 2026 05:46:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef9228fsm63211245e9.15.2026.09.15.05.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:46:16 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 12:46:14 +0000
To: flichtenheld <frank@lichtenheld.com>,
 razvanc <razvanc@mailbox.org>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 0999fc1bb083c87bb4acd3e3011d11ad1e55e426
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a905e3a2a8d32ade025bf52e5db4e2d48d945c92-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6SYK-0002I0-CZ
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
Content-Type: multipart/mixed; boundary="===============7860015339675078464=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7860015339675078464==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C+sclkf/8YE="; charset=UTF-8

--C+sclkf/8YE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, razvanc, stipa=2E

Hell=
o flichtenheld, razvanc, stipa, 

I'd like you to reexamine a change=2E Ple=
ase visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail

=
to look at the new patch set (#10)=2E

The following approvals got outdated=
 and were removed:
Code-Review+2 by razvanc, Code-Review-1 by flichtenheld
=

The change is no longer submittable: Code-Review and checks~ChecksSubmitRu=
le are unsatisfied now=2E


Change subject: Make required action returned f=
rom pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Make required action returned from pre_decrypt_ve=
rdict more explicit

The current code relies on the condition if state=2Ese=
rver_session_id
is defined to decide if session_skip_to_pre_start should be=
 used=2E

Instead explicitly return the intent and use that to decide if
se=
ssion_skip_to_pre_start should be called=2E

Change-Id: Iccdd4cfad090c565aa=
c27e16cdaa9871106c2f89
---
M src/openvpn/mudp=2Ec
1 file changed, 46 insert=
ions(+), 19 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/26/1826/10

diff --git a/src/openvpn/mudp=2Ec b/src/open=
vpn/mudp=2Ec
index de3d467=2E=2E88b0091 100644
--- a/src/openvpn/mudp=2Ec
+=
++ b/src/openvpn/mudp=2Ec
@@ -87,9 +87,28 @@
                           "Re=
set packet from client, sending HMAC based reset challenge", sock);
 }
 
+/=
**
+ * Verdict if this packet should create a new session=2E If a packet is=
 invalid
+ * or we send out an HMAC based challenge, we do not want to crea=
te a new
+ * session=2E
+ */
+enum pre_decrypt_verdict
+{
+    /** This pac=
ket should not create a new session */
+    PRE_DECRYPT_NO_ACTION,
+    /**=
 This packet creates a new session on the first packet on the session=2E
+ =
    * We only do this for legacy tls-crypt-v2 clients that do not work with=

+     * the HMAC cookie challenge approach where we need to keep the clien=
t
+     * specific tls-crypt key to be able to decrypt the third packet */
=
+    PRE_DECRYPT_CREATE_SESSION,
+    /** Creates a new session=2E The HMAC=
 challenge has been already completed
+     * and the first two packets of =
the three way handshake are skipped in
+     * the session setup */
+    PR=
E_DECRYPT_CREATE_SESSION_SKIP
+};
 
-/* Returns true if this packet should =
create a new session */
-static bool
+/** Returns a verdict if this packet =
should create a new session */
+static enum pre_decrypt_verdict
 do_pre_dec=
rypt_check(struct multi_context *m, struct tls_pre_decrypt_state *state,
  =
                    struct mroute_addr addr, struct link_socket *sock)
 {
@=
@ -111,7 +130,7 @@
          * responses */
         if (!reflect_filter_ra=
te_limit_check(m->initial_rate_limiter))
         {
-            return fal=
se;
+            return PRE_DECRYPT_NO_ACTION;
         }
     }
 
@@ -136,=
7 +155,7 @@
                 calculate_session_id_hmac(state->peer_session_=
id, from, hmac_key, handwindow, 0);
             send_hmac_reset_packet(m, =
state, tas, &sid, true, sock);
 
-            return false;
+            re=
turn PRE_DECRYPT_NO_ACTION;
         }
         else
         {
@@ -153,11 =
+172,11 @@
                     "ignoring connection attempt from old clien=
t (%s)",
                     peer);
                 gc_free(&gc);
-      =
          return false;
+                return PRE_DECRYPT_NO_ACTION;
    =
         }
             else
             {
-                return true;
+=
                return PRE_DECRYPT_CREATE_SESSION;
             }
         =
}
     }
@@ -170,7 +189,7 @@
         send_hmac_reset_packet(m, state, tas,=
 &sid, false, sock);
 
         /* We have a reply do not create a new sess=
ion */
-        return false;
+        return PRE_DECRYPT_NO_ACTION;
     }=

     else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 || verdict =3D=3D VE=
RDICT_VALID_ACK_V1
              || verdict =3D=3D VERDICT_VALID_WKC_V1)
@@=
 -181,6 +200,7 @@
 
         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VA=
LID_ACK_V1);
         bool ret =3D check_session_hmac_and_pkt_id(state, fro=
m, hmac_key, handwindow, pkt_is_ack);
+        enum pre_decrypt_verdict act=
ion =3D PRE_DECRYPT_NO_ACTION;
 
         const char *peer =3D print_link_s=
ocket_actual(&m->top=2Ec2=2Efrom, &gc);
         uint8_t pkt_firstbyte =3D =
*BPTR(&m->top=2Ec2=2Ebuf);
@@ -198,14 +218,15 @@
                 "Valid pa=
cket (%s) with HMAC challenge from peer (%s), "
                 "accepting=
 new connection=2E",
                 packet_opcode_name(op), peer);
+     =
       action =3D PRE_DECRYPT_CREATE_SESSION_SKIP;
         }
         gc_f=
ree(&gc);
 
-        return ret;
+        return action;
     }
 
     /* V=
ERDICT_INVALID */
-    return false;
+    return PRE_DECRYPT_NO_ACTION;
 }
=
 
 /**
@@ -220,9 +241,6 @@
                           struct link_socket *s=
ock,
                           struct mroute_addr *real)
 {
-    struct ha=
sh *hash =3D m->hash;
-    struct tls_pre_decrypt_state state =3D { 0 };
- =
   struct multi_instance *mi =3D NULL;
     struct gc_arena gc =3D gc_new()=
;
 
     if (m->deferred_shutdown_signal=2Esignal_received)
@@ -231,8 +249,=
17 @@
             "MULTI: Connection attempt from %s ignored while server =
is "
             "shutting down",
             mroute_addr_print(real, &gc=
));
+        gc_free(&gc);
+        return NULL;
     }
-    else if (do_pr=
e_decrypt_check(m, &state, *real, sock))
+
+    struct hash *hash =3D m->ha=
sh;
+    struct tls_pre_decrypt_state state =3D { 0 };
+    struct multi_in=
stance *mi =3D NULL;
+
+    enum pre_decrypt_verdict verdict =3D do_pre_dec=
rypt_check(m, &state, *real, sock);
+
+    if (verdict !=3D PRE_DECRYPT_NO_=
ACTION)
     {
         /* This is an unknown session but with valid tls-au=
th/tls-crypt
          * (or no auth at all)=2E  If this is the initial pac=
ket of a
@@ -255,14 +282,14 @@
                 mi->did_real_hash =3D true;=

                 multi_assign_peer_id(m, mi);
 
-                /* If we =
have a session id already, ensure that the
-                 * state is usi=
ng the same */
-                if (session_id_defined(&state=2Eserver_sess=
ion_id)
-                    && session_id_defined((&state=2Epeer_session_i=
d)))
+                struct tls_session *session =3D
+                    =
&mi->context=2Ec2=2Etls_multi->session[TM_INITIAL];
+
+                if (=
verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)
                 {
+       =
             /* This verdict is only possible if we have a peer session ID =
*/
+                    ASSERT(session_id_defined(&state=2Epeer_session_id)=
);
                     mi->context=2Ec2=2Etls_multi->n_sessions++;
-      =
              struct tls_session *session =3D
-                        &mi-=
>context=2Ec2=2Etls_multi->session[TM_INITIAL];
                     sessio=
n_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
                =
 }
             }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1826?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Iccdd4cfad090c565aac27e16cdaa9871106c2f89
Gerrit-Change-Number: 1826
Gerri=
t-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: razvanc <razv=
anc@mailbox=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--C+sclkf/8YE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, razvanc, stipa=2E </p>
<p>plaisthos <st=
rong>uploaded patch set #10</strong> to this change=2E</p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p=
><p>The following approvals got outdated and were removed:
Code-Review+2 by=
 razvanc, Code-Review-1 by flichtenheld</p><p>The change is no longer submi=
ttable: Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E</p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Make required action returned from pre_decrypt_verdict more ex=
plicit<br><br>The current code relies on the condition if state=2Eserver_se=
ssion_id<br>is defined to decide if session_skip_to_pre_start should be use=
d=2E<br><br>Instead explicitly return the intent and use that to decide if<=
br>session_skip_to_pre_start should be called=2E<br><br>Change-Id: Iccdd4cf=
ad090c565aac27e16cdaa9871106c2f89<br>---<br>M src/openvpn/mudp=2Ec<br>1 fil=
e changed, 46 insertions(+), 19 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/1826/10</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><s=
pan>index de3d467=2E=2E88b0091 100644</span><br><span>--- a/src/openvpn/mud=
p=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -87,9 +=
87,28 @@</span><br><span>                           &quot;Reset packet from=
 client, sending HMAC based reset challenge&quot;, sock);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Verdict if th=
is packet should create a new session=2E If a packet is invalid</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * or we send out an HMAC based=
 challenge, we do not want to create a new</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * session=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+enum pre_decrypt_verdict</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** This=
 packet should not create a new session */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    PRE_DECRYPT_NO_ACTION,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /** This packet creates a new session on =
the first packet on the session=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * We only do this for legacy tls-crypt-v2 clients that =
do not work with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * the HMAC cookie challenge approach where we need to keep the client</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * specific tls-cry=
pt key to be able to decrypt the third packet */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    PRE_DECRYPT_CREATE_SESSION,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /** Creates a new session=2E T=
he HMAC challenge has been already completed</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * and the first two packets of the three way =
handshake are skipped in</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * the session setup */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    PRE_DECRYPT_CREATE_SESSION_SKIP</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+};</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/* Returns true if this packet should create a =
new session */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Returns a v=
erdict if this packet should create a new session */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static enum pre_decrypt_verdict</span><br=
><span> do_pre_decrypt_check(struct multi_context *m, struct tls_pre_decryp=
t_state *state,</span><br><span>                      struct mroute_addr ad=
dr, struct link_socket *sock)</span><br><span> {</span><br><span>@@ -111,7 =
+130,7 @@</span><br><span>          * responses */</span><br><span>        =
 if (!reflect_filter_rate_limit_check(m-&gt;initial_rate_limiter))</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return PRE_DECRYPT_NO_ACTION;</span><br><span>         }</sp=
an><br><span>     }</span><br><span> </span><br><span>@@ -136,7 +155,7 @@</=
span><br><span>                 calculate_session_id_hmac(state-&gt;peer_se=
ssion_id, from, hmac_key, handwindow, 0);</span><br><span>             send=
_hmac_reset_packet(m, state, tas, &amp;sid, true, sock);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn PRE_DECRYPT_NO_ACTION;</span><br><span>         }</span><br><span>      =
   else</span><br><span>         {</span><br><span>@@ -153,11 +172,11 @@</s=
pan><br><span>                     &quot;ignoring connection attempt from o=
ld client (%s)&quot;,</span><br><span>                     peer);</span><br=
><span>                 gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                return PRE_DECRYPT_NO_ACTION;=
</span><br><span>             }</span><br><span>             else</span><br=
><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                return PRE_DECRYPT_CREATE_SESSION;</span><br><span=
>             }</span><br><span>         }</span><br><span>     }</span><br=
><span>@@ -170,7 +189,7 @@</span><br><span>         send_hmac_reset_packet(=
m, state, tas, &amp;sid, false, sock);</span><br><span> </span><br><span>  =
       /* We have a reply do not create a new session */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return PRE_DECRYPT_NO_ACTION;<=
/span><br><span>     }</span><br><span>     else if (verdict =3D=3D VERDICT=
_VALID_CONTROL_V1 || verdict =3D=3D VERDICT_VALID_ACK_V1</span><br><span>  =
            || verdict =3D=3D VERDICT_VALID_WKC_V1)</span><br><span>@@ -181=
,6 +200,7 @@</span><br><span> </span><br><span>         bool pkt_is_ack =3D=
 (verdict =3D=3D VERDICT_VALID_ACK_V1);</span><br><span>         bool ret =
=3D check_session_hmac_and_pkt_id(state, from, hmac_key, handwindow, pkt_is=
_ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        enum =
pre_decrypt_verdict action =3D PRE_DECRYPT_NO_ACTION;</span><br><span> </sp=
an><br><span>         const char *peer =3D print_link_socket_actual(&amp;m-=
&gt;top=2Ec2=2Efrom, &amp;gc);</span><br><span>         uint8_t pkt_firstby=
te =3D *BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>@@ -198,14 +218,15=
 @@</span><br><span>                 &quot;Valid packet (%s) with HMAC chal=
lenge from peer (%s), &quot;</span><br><span>                 &quot;accepti=
ng new connection=2E&quot;,</span><br><span>                 packet_opcode_=
name(op), peer);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         action =3D PRE_DECRYPT_CREATE_SESSION_SKIP;</span><br><span>      =
   }</span><br><span>         gc_free(&amp;gc);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return ret;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return action;</span><b=
r><span>     }</span><br><span> </span><br><span>     /* VERDICT_INVALID */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return PRE_DECRYPT_=
NO_ACTION;</span><br><span> }</span><br><span> </span><br><span> /**</span>=
<br><span>@@ -220,9 +241,6 @@</span><br><span>                           st=
ruct link_socket *sock,</span><br><span>                           struct m=
route_addr *real)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct tls_pre_decrypt_state state =3D =
{ 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mult=
i_instance *mi =3D NULL;</span><br><span>     struct gc_arena gc =3D gc_new=
();</span><br><span> </span><br><span>     if (m-&gt;deferred_shutdown_sign=
al=2Esignal_received)</span><br><span>@@ -231,8 +249,17 @@</span><br><span>=
             &quot;MULTI: Connection attempt from %s ignored while server i=
s &quot;</span><br><span>             &quot;shutting down&quot;,</span><br>=
<span>             mroute_addr_print(real, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (=
do_pre_decrypt_check(m, &amp;state, *real, sock))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct hash *hash =3D m-&gt;hash;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct tls_pre_decrypt_state state =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi=
_instance *mi =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum pre_de=
crypt_verdict verdict =3D do_pre_decrypt_check(m, &amp;state, *real, sock);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (verdict !=3D PRE_DECRYPT_NO_AC=
TION)</span><br><span>     {</span><br><span>         /* This is an unknown=
 session but with valid tls-auth/tls-crypt</span><br><span>          * (or =
no auth at all)=2E  If this is the initial packet of a</span><br><span>@@ -=
255,14 +282,14 @@</span><br><span>                 mi-&gt;did_real_hash =3D=
 true;</span><br><span>                 multi_assign_peer_id(m, mi);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      /* If we have a session id already, ensure that the</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                 * state is using the s=
ame */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 if (session_id_defined(&amp;state=2Eserver_session_id)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    &amp;&amp; session_id=
_defined((&amp;state=2Epeer_session_id)))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                struct tls_session *session =3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &amp;=
mi-&gt;context=2Ec2=2Etls_multi-&gt;session[TM_INITIAL];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                if (verdict =3D=3D PRE_DECRYPT_CREATE_SES=
SION_SKIP)</span><br><span>                 {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    /* This verdict is only possi=
ble if we have a peer session ID */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    ASSERT(session_id_defined(&amp;state=2E=
peer_session_id));</span><br><span>                     mi-&gt;context=2Ec2=
=2Etls_multi-&gt;n_sessions++;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    struct tls_session *session =3D</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                        &amp;mi-&gt;=
context=2Ec2=2Etls_multi-&gt;session[TM_INITIAL];</span><br><span>         =
            session_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=
=2Ec2=2Efrom);</span><br><span>                 }</span><br><span>         =
    }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">change 1826</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iccdd4cfad09=
0c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1826 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>

</body></html>
--C+sclkf/8YE=--


--===============7860015339675078464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7860015339675078464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7860015339675078464==--

