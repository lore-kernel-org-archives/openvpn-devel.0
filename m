Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2EDC44502
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=py34AeYOTFekDvk1/jugj+NiN1dNCq9MbKiwWz73JbA=; b=g77uBQDQNCXRfu
	gHuE3sPUjb0betv7REh/UG4QHULdkngTGQQE+xjt9n/aP9CRz9X9Wokja2d8fHXw3N997WyloaJn/
	yP0mm8L+211NbrSPFEAi1m+U39RcTHBkj9VZ8Ve5qp2kenu95cejEDtU3QMItMPVdopvbBNvRtNeS
	5Ys=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgdAn-0005rB-1B;
	Mon, 06 Jul 2026 06:51:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgdAm-0005r3-0J
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bv15x88VadMvQDp55vwByD0I/EzhKWN+p95vSU11Y90=; b=V0g8JYV/gaNM1ZEJgutPOZaAAx
 he2VNtzZ/5h9HgkLdGz0EIF5Do5xrmckDD5CPs5zcrrypMClzwD7mmwJ/cLteXCcZ51MrAWxxmrhc
 hP+r+ZhnGFoRNEfWm96nLeWQ3Pa+Fl5jnebKqtj0MdvHz2qJObeUUP9k6sKU5RrORDvA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bv15x88VadMvQDp55vwByD0I/EzhKWN+p95vSU11Y90=; b=k
 3uM6TxgdNsGyQD871UbOtJyiPhlcUQH4b2G8/ndh0/4YPg915LhCGTHB0TbruqWh7fvVDGQr1kVwW
 G2xMAbK+7v1s1LlFCBW1bNg88xdAmhtPt6SnZpPHC3S/Z1C8KPc0QUBUOg3UDdnMpa4VV/61WzMDq
 N8tIMEDgiNRdMYSM=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgdAj-00047t-TS for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:19 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b61b52b6so17384595e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 05 Jul 2026 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783320667; x=1783925467; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bv15x88VadMvQDp55vwByD0I/EzhKWN+p95vSU11Y90=;
 b=BJEkoa3OItfqjnXOaheyxZHaGuhQSQOMcrp69GAVoaMZqgR/qqvQCE3f6zo1kewxsN
 kXgk9jxjb8pAv1TQXZ+tyehjiiOjl+XCqWGK42OApLLFuOPfquYw2yfuirRhigBiJUtO
 xMmK4oBXKYxXPQIxAnP6AOd++wUVUcN6VpDI5+TlMLsHND9ZqfS3rR04wxPf6qzf50Vq
 eSvXM8KvWgjn/c/nw/IUC+YaYPwwWEB2iNg+O8A4D/QwKnh5dKVfY+GFkbJfwFem653R
 Xghryt3/FzZdTOxH1vZxwzUTh0cGQ39qo6xs/EAWp2X+RBT35YpwMYCDJet8dYMxqpAs
 oBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783320667; x=1783925467;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bv15x88VadMvQDp55vwByD0I/EzhKWN+p95vSU11Y90=;
 b=Eg3bnCllPDXqS1rXbL7b0/IBF/OpjYXOdE+ZK3/S1haNzuNLe8hlRhisXqKH6njFnG
 eBH81qGNtgo8wgj5r3vJXdGaEOf3ZUJ2QQtyP8u4vfRoCkVC7H4M6BPfgt3Yp7VQRl6h
 Z0PDUbGeVM/vfCUvoXEkXeQgpv4LbfQ2KHZXINeEk8R0GPtelf3GyUP2N/LOg42tcVAx
 kVAidW5PJeebMdVY8cq7Az7ue+u5uhdhsfEhIE+iGShlYosSGMUBvj3R0suRPyWnrYDb
 Nbrz1s1L28Dq51moQ5kDyHcb7kt1zJU3/km15eVBhwjIa//srX7icyq/F7xNO6rjOCth
 4VpA==
X-Gm-Message-State: AOJu0YxgNk5WC7X30VwA79VWlAM+xZ7tEuCQawUjwRWqwgh/ztydMF4n
 2hsBJ/AuIPsY5DeGv3nTtQiGSA60hY6W2cdlEoOoCxBItFBMIrWJJlr55Q84u0bszOOBqeoRyZB
 598bO/FtqiR58Z37oS4772bIIDXAIki5paF7m21O4DkqfGWT9EpHWlEF9BubDbU8UkNo4vmOVxW
 89vY2tmg==
X-Gm-Gg: AfdE7cnGnqqtMqtI5TJBhw5iJZa73tUiLHiCF1FkAiYfp7cwuUr/kd65rzfZVENscLp
 oDo5kg0VwtoZ77tOgGClOTfgrGB8cCvuYHxvh77FX1yMvNkmg46sychRKTczMcAJ/iYXN6+2sBz
 oXTF+e1t+UK3vVVg61Jav19ZmSeTPbMDZvUMmnFA29saiteQWwO1AbkBx72GXcG6MxGnPKY4xM0
 73ICWp+3tigewldwZ8M7n1fD/pQLwLPW/u1iZSJCRzZsBZel40skJtuj6OzlzIIJl+kbTAFV7ZI
 zCe2PPNJkW1kRhrFJNTUSEVaP4eGyk2kwslEzsROqZM4G2hBjBxPWhytD1kHfy6mmGyUB4Mp/kK
 D01Xxj0IdITeaNVfb9TBmHdO4DPt13JEEwVG95xnGQFOLNbOMiGf/Q6tkc5JPeIybWxjBAV0ReW
 Jsd0sLDMYLP3pqKjTIAjfA8OlVInQQWVaK7a7r9o/ipJI13xFDP1IgaBkwprzvWX6Yy9BuTBiu3
 /ZPPnhs49rsLcGtM0jQpUMu0LxvnIgRWMUix8V2B//HL1FoWSZs3rffn5j7a/yop6rBIZY2y2H1
 b0A=
X-Received: by 2002:a05:600c:35ce:b0:493:b877:fbc with SMTP id
 5b1f17b1804b1-493d2396eccmr106072975e9.21.1783320666680; 
 Sun, 05 Jul 2026 23:51:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960816sm21194944f8f.29.2026.07.05.23.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 23:51:06 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 06:51:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 0d31896c89ab6af6d01adf0b3bc129befac23d7d
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7479ca2631304c34560f18f21a4c8e899456d6bd-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgdAj-00047t-TS
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: advertise a
 connect_lifetime handshake shortcut
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5250283220600071355=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5250283220600071355==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="55UN68Ice34="; charset=UTF-8

--55UN68Ice34=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1768?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: advertise a connect_lifetime handshake shortcut
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: advertise a conne=
ct_lifetime handshake shortcut

A server answering an out-of-band SERVER_PR=
OBE now also advertises a
connect_lifetime in the PROBE_REPLY: the seconds =
the reply doubles as a
handshake shortcut, letting a probing client reuse i=
t as the server's
HARD_RESET and start the three-way handshake at the third=
 packet=2E

The value is inferred, not configurable: the reply is only vali=
d as a shortcut
while its stateless SYN-cookie is, i=2Ee=2E the guaranteed =
cookie window of
~handshake_window (2 quantised buckets; see check_session_=
hmac_and_pkt_id), so
the server advertises exactly that=2E A tls-crypt-v2 p=
robe (unwrapped via its
WKc) also sets OOB_PROBE_REPLY_FLAG_RESEND_WKC, tel=
ling the client to resend
the WKc when completing the handshake, since the =
server keeps no state=2E

Only the wire advertisement and its plumbing thro=
ugh oob_build_probe_reply()
are added here; the client side that acts on it=
 follows=2E

Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Signed-of=
f-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/ope=
nvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
=
4 files changed, 39 insertions(+), 11 deletions(-)



  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1768/1

diff --git a/src/o=
penvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 7ce7ecc=2E=2E4566fd7 100644
--=
- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -239,13 +239,29 @@
 =
        /* Out-of-band server probe=2E state->newbuf points at the TLV payl=
oad
          * (read_control_auth has stripped the opcode, session id and =
any
          * tls-auth/tls-crypt wrapping)=2E Answer it without creating =
a session=2E */
+
+        /* A tls-crypt-v2 probe was unwrapped via its WK=
c (cleanup_key_ctx is set
+         * by tls_crypt_v2_extract_client_key); =
such a client must resend the WKc
+         * if it later uses this reply a=
s a handshake shortcut, since we keep no
+         * state=2E */
+        u=
int32_t reply_flags =3D
+            state->tls_wrap_tmp=2Ecleanup_key_ctx =
? OOB_PROBE_REPLY_FLAG_RESEND_WKC : 0;
+
+        /* The shortcut third pac=
ket validates only while its SYN-cookie does, so
+         * the advertised=
 connect_lifetime is inferred (not configurable): the
+         * guarantee=
d cookie window of ~handshake_window (2 quantised buckets; see
+         * =
check_session_hmac_and_pkt_id)=2E Advertising more would make the client
+ =
        * trust an already-expired cookie=2E (RFC: connect_lifetime is how =
long the
+         * server considers the reply valid=2E) */
+        int c=
onnect_lifetime =3D 2 * ((handwindow + 1) / 2);
+
         struct oob_probe=
_reply reply;
         if (!oob_build_probe_reply(&state->newbuf, (uint64_t=
)now, (uint64_t)handwindow,
                                    &state->pee=
r_session_id,
                                    (uint16_t)m->top=2Eoption=
s=2Eserver_probe_reply_priority,
                                    (uint1=
6_t)m->top=2Eoptions=2Eserver_probe_reply_weight,
                         =
           (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff=
,
-                                   &reply))
+                           =
        (uint16_t)connect_lifetime, reply_flags, &reply))
         {
      =
       /* malformed or replayed/stale probe: silently drop */
             =
return false;
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index =
2f51ad5=2E=2E00dd9a4 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=
=2Ec
@@ -223,7 +223,8 @@
 bool
 oob_build_probe_reply(struct buffer *probe_=
payload, uint64_t now, uint64_t window_secs,
                       const s=
truct session_id *peer_sid, uint16_t priority, uint16_t weight,
-          =
            uint16_t max_latency_diff, struct oob_probe_reply *reply)
+    =
                  uint16_t max_latency_diff, uint16_t connect_lifetime, uin=
t32_t flags,
+                      struct oob_probe_reply *reply)
 {
     =
struct oob_probe_parameter param;
     if (!oob_server_probe_read(probe_pay=
load, &param))
@@ -242,7 +243,8 @@
     reply->priority =3D priority;
     =
reply->weight =3D weight;
     reply->max_latency_diff =3D max_latency_diff=
;
-    /* connect_lifetime/flags left at 0 for now */
+    reply->connect_l=
ifetime =3D connect_lifetime;
+    reply->flags =3D flags;
     return true=
;
 }
 
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 0acad80=
=2E=2E44a51ec 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@=
 -197,13 +197,19 @@
  */
 bool oob_timestamp_in_window(uint64_t probe_ts, u=
int64_t now, uint64_t window_secs);
 
+/* probe_reply flags (the reply TLV'=
s 32-bit flags field) */
+/* bit 0: the client must resend the wrapped clie=
nt key (via P_CONTROL_WKC_V1)
+ * when it completes the three-way handshake=
 using this reply as a shortcut=2E Set
+ * by a tls-crypt-v2 server, which =
is stateless and discarded the WKc=2E */
+#define OOB_PROBE_REPLY_FLAG_RESE=
ND_WKC 0x1
+
 /**
  * Process the TLV payload of a received SERVER_PROBE an=
d decide whether to
  * answer it=2E Combines oob_server_probe_read() and o=
ob_timestamp_in_window():
  * the probe is dropped (false returned) if it h=
as no valid probe_parameter or
  * its timestamp is outside the acceptable =
window=2E On success @p reply is
- * populated with the peer's session id e=
choed back and the given priority and
- * weight (other fields zeroed), rea=
dy to be wrapped and sent=2E
+ * populated with the peer's session id echoe=
d back and the advertised values,
+ * ready to be wrapped and sent=2E
  *
 =
 * This is the transport-agnostic decision step; the caller performs the se=
nd=2E
  *
@@ -214,12 +220,15 @@
  * @param priority       priority to adver=
tise (DNS-SRV semantics; lower preferred)
  * @param weight         weight =
to advertise (DNS-SRV semantics; higher preferred)
  * @param max_latency_d=
iff  candidate-band margin (ms) to advertise; 0 =3D defer to client
+ * @pa=
ram connect_lifetime  seconds the reply is valid as a handshake shortcut; 0=
 =3D none
+ * @param flags          reply flags to advertise (OOB_PROBE_REP=
LY_FLAG_*)
  * @param reply          filled with the reply to send on succe=
ss
  * @return true if a reply should be sent, false to silently drop the p=
robe
  */
 bool oob_build_probe_reply(struct buffer *probe_payload, uint64_=
t now, uint64_t window_secs,
                            const struct sessi=
on_id *peer_sid, uint16_t priority, uint16_t weight,
-                     =
      uint16_t max_latency_diff, struct oob_probe_reply *reply);
+         =
                  uint16_t max_latency_diff, uint16_t connect_lifetime, uin=
t32_t flags,
+                           struct oob_probe_reply *reply);
 
=
 /* Candidate-band margin (ms) used when neither the client nor the server
=
  * specifies one=2E */
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec =
b/tests/unit_tests/openvpn/test_oob=2Ec
index e703db5=2E=2E8ffbdc7 100644
-=
-- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/t=
est_oob=2Ec
@@ -300,12 +300,13 @@
     memcpy(peer=2Eid, "PEER1234", SID_SI=
ZE);
 
     struct oob_probe_reply reply;
-    assert_true(oob_build_probe_=
reply(&buf, now, 30, &peer, 5, 50, 25, &reply));
+    assert_true(oob_build=
_probe_reply(&buf, now, 30, &peer, 5, 50, 25, 120,
+                       =
               OOB_PROBE_REPLY_FLAG_RESEND_WKC, &reply));
     assert_memor=
y_equal(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZE);
     assert_int=
_equal(reply=2Epriority, 5);
     assert_int_equal(reply=2Eweight, 50);
-  =
  assert_int_equal(reply=2Econnect_lifetime, 0);
-    assert_int_equal(repl=
y=2Eflags, 0);
+    assert_int_equal(reply=2Econnect_lifetime, 120);
+    a=
ssert_int_equal(reply=2Eflags, OOB_PROBE_REPLY_FLAG_RESEND_WKC);
     asser=
t_int_equal(reply=2Emax_latency_diff, 25);
 
     gc_free(&gc);
@@ -324,7 +=
325,7 @@
 
     struct session_id peer =3D { 0 };
     struct oob_probe_rep=
ly reply;
-    assert_false(oob_build_probe_reply(&buf, now, 30, &peer, 0, =
0, 0, &reply));
+    assert_false(oob_build_probe_reply(&buf, now, 30, &pee=
r, 0, 0, 0, 0, 0, &reply));
 
     gc_free(&gc);
 }
@@ -342,7 +343,7 @@
 
 =
    struct session_id peer =3D { 0 };
     struct oob_probe_reply reply;
- =
   assert_false(oob_build_probe_reply(&buf, 1000000, 30, &peer, 0, 0, 0, &r=
eply));
+    assert_false(oob_build_probe_reply(&buf, 1000000, 30, &peer, 0=
, 0, 0, 0, 0, &reply));
 
     gc_free(&gc);
 }

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Gerr=
it-Change-Number: 1768
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--55UN68Ice34=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1768?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: advertise a connect_lifetime handshake shortcut<br><br>A server answerin=
g an out-of-band SERVER_PROBE now also advertises a<br>connect_lifetime in =
the PROBE_REPLY: the seconds the reply doubles as a<br>handshake shortcut, =
letting a probing client reuse it as the server&#39;s<br>HARD_RESET and sta=
rt the three-way handshake at the third packet=2E<br><br>The value is infer=
red, not configurable: the reply is only valid as a shortcut<br>while its s=
tateless SYN-cookie is, i=2Ee=2E the guaranteed cookie window of<br>~handsh=
ake_window (2 quantised buckets; see check_session_hmac_and_pkt_id), so<br>=
the server advertises exactly that=2E A tls-crypt-v2 probe (unwrapped via i=
ts<br>WKc) also sets OOB_PROBE_REPLY_FLAG_RESEND_WKC, telling the client to=
 resend<br>the WKc when completing the handshake, since the server keeps no=
 state=2E<br><br>Only the wire advertisement and its plumbing through oob_b=
uild_probe_reply()<br>are added here; the client side that acts on it follo=
ws=2E<br><br>Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae<br>Signed=
-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mud=
p=2Ec<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tes=
ts/openvpn/test_oob=2Ec<br>4 files changed, 39 insertions(+), 11 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/68/1768/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/s=
rc/openvpn/mudp=2Ec</span><br><span>index 7ce7ecc=2E=2E4566fd7 100644</span=
><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mud=
p=2Ec</span><br><span>@@ -239,13 +239,29 @@</span><br><span>         /* Out=
-of-band server probe=2E state-&gt;newbuf points at the TLV payload</span><=
br><span>          * (read_control_auth has stripped the opcode, session id=
 and any</span><br><span>          * tls-auth/tls-crypt wrapping)=2E Answer=
 it without creating a session=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* A tls-crypt-v2 probe was unwrapped via its WKc (cleanup_key_ctx is=
 set</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * by t=
ls_crypt_v2_extract_client_key); such a client must resend the WKc</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * if it later uses =
this reply as a handshake shortcut, since we keep no</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * state=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uint32_t reply_flags =3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            state-&gt;tls=
_wrap_tmp=2Ecleanup_key_ctx ? OOB_PROBE_REPLY_FLAG_RESEND_WKC : 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* The shortcut third packet validates =
only while its SYN-cookie does, so</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * the advertised connect_lifetime is inferred (not =
configurable): the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * guaranteed cookie window of ~handshake_window (2 quantised bucket=
s; see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * ch=
eck_session_hmac_and_pkt_id)=2E Advertising more would make the client</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * trust an alre=
ady-expired cookie=2E (RFC: connect_lifetime is how long the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * server considers the re=
ply valid=2E) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     int connect_lifetime =3D 2 * ((handwindow + 1) / 2);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         struct oob_=
probe_reply reply;</span><br><span>         if (!oob_build_probe_reply(&amp=
;state-&gt;newbuf, (uint64_t)now, (uint64_t)handwindow,</span><br><span>   =
                                 &amp;state-&gt;peer_session_id,</span><br>=
<span>                                    (uint16_t)m-&gt;top=2Eoptions=2Es=
erver_probe_reply_priority,</span><br><span>                               =
     (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</span><br><=
span>                                    (uint16_t)m-&gt;top=2Eoptions=2Ese=
rver_probe_reply_max_latency_diff,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                   &amp;reply))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
 (uint16_t)connect_lifetime, reply_flags, &amp;reply))</span><br><span>    =
     {</span><br><span>             /* malformed or replayed/stale probe: s=
ilently drop */</span><br><span>             return false;</span><br><span>=
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>inde=
x 2f51ad5=2E=2E00dd9a4 100644</span><br><span>--- a/src/openvpn/oob=2Ec</sp=
an><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -223,7 +223,8 @@<=
/span><br><span> bool</span><br><span> oob_build_probe_reply(struct buffer =
*probe_payload, uint64_t now, uint64_t window_secs,</span><br><span>       =
                const struct session_id *peer_sid, uint16_t priority, uint1=
6_t weight,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
            uint16_t max_latency_diff, struct oob_probe_reply *reply)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                      uin=
t16_t max_latency_diff, uint16_t connect_lifetime, uint32_t flags,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                      struct=
 oob_probe_reply *reply)</span><br><span> {</span><br><span>     struct oob=
_probe_parameter param;</span><br><span>     if (!oob_server_probe_read(pro=
be_payload, &amp;param))</span><br><span>@@ -242,7 +243,8 @@</span><br><spa=
n>     reply-&gt;priority =3D priority;</span><br><span>     reply-&gt;weig=
ht =3D weight;</span><br><span>     reply-&gt;max_latency_diff =3D max_late=
ncy_diff;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* conne=
ct_lifetime/flags left at 0 for now */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    reply-&gt;connect_lifetime =3D connect_lifetime;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    reply-&gt;flags =3D=
 flags;</span><br><span>     return true;</span><br><span> }</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh<=
/span><br><span>index 0acad80=2E=2E44a51ec 100644</span><br><span>--- a/src=
/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>=
@@ -197,13 +197,19 @@</span><br><span>  */</span><br><span> bool oob_timest=
amp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs);</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* prob=
e_reply flags (the reply TLV&#39;s 32-bit flags field) */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* bit 0: the client must resend the =
wrapped client key (via P_CONTROL_WKC_V1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * when it completes the three-way handshake using th=
is reply as a shortcut=2E Set</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * by a tls-crypt-v2 server, which is stateless and discarded the=
 WKc=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define O=
OB_PROBE_REPLY_FLAG_RESEND_WKC 0x1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> /**</span><br><span>  * Process the TLV pa=
yload of a received SERVER_PROBE and decide whether to</span><br><span>  * =
answer it=2E Combines oob_server_probe_read() and oob_timestamp_in_window()=
:</span><br><span>  * the probe is dropped (false returned) if it has no va=
lid probe_parameter or</span><br><span>  * its timestamp is outside the acc=
eptable window=2E On success @p reply is</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * populated with the peer&#39;s session id echoed back =
and the given priority and</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * weight (other fields zeroed), ready to be wrapped and sent=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * populated with the pee=
r&#39;s session id echoed back and the advertised values,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * ready to be wrapped and sent=2E</s=
pan><br><span>  *</span><br><span>  * This is the transport-agnostic decisi=
on step; the caller performs the send=2E</span><br><span>  *</span><br><spa=
n>@@ -214,12 +220,15 @@</span><br><span>  * @param priority       priority =
to advertise (DNS-SRV semantics; lower preferred)</span><br><span>  * @para=
m weight         weight to advertise (DNS-SRV semantics; higher preferred)<=
/span><br><span>  * @param max_latency_diff  candidate-band margin (ms) to =
advertise; 0 =3D defer to client</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param connect_lifetime  seconds the reply is valid as a ha=
ndshake shortcut; 0 =3D none</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param flags          reply flags to advertise (OOB_PROBE_REPLY=
_FLAG_*)</span><br><span>  * @param reply          filled with the reply to=
 send on success</span><br><span>  * @return true if a reply should be sent=
, false to silently drop the probe</span><br><span>  */</span><br><span> bo=
ol oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, uint64=
_t window_secs,</span><br><span>                            const struct se=
ssion_id *peer_sid, uint16_t priority, uint16_t weight,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                           uint16_t max_l=
atency_diff, struct oob_probe_reply *reply);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                           uint16_t max_latency_di=
ff, uint16_t connect_lifetime, uint32_t flags,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                           struct oob_probe_repl=
y *reply);</span><br><span> </span><br><span> /* Candidate-band margin (ms)=
 used when neither the client nor the server</span><br><span>  * specifies =
one=2E */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2E=
c b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index e703db5=2E=
=2E8ffbdc7 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br>=
<span>@@ -300,12 +300,13 @@</span><br><span>     memcpy(peer=2Eid, &quot;PE=
ER1234&quot;, SID_SIZE);</span><br><span> </span><br><span>     struct oob_=
probe_reply reply;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_true(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, 5, 50, 25,=
 &amp;reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, 5, 50, 25, 1=
20,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                      OOB_PROBE_REPLY_FLAG_RESEND_WKC, &amp;reply));</span>=
<br><span>     assert_memory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid,=
 SID_SIZE);</span><br><span>     assert_int_equal(reply=2Epriority, 5);</sp=
an><br><span>     assert_int_equal(reply=2Eweight, 50);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(reply=2Econnect_life=
time, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_i=
nt_equal(reply=2Eflags, 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(reply=2Econnect_lifetime, 120);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Eflags=
, OOB_PROBE_REPLY_FLAG_RESEND_WKC);</span><br><span>     assert_int_equal(r=
eply=2Emax_latency_diff, 25);</span><br><span> </span><br><span>     gc_fre=
e(&amp;gc);</span><br><span>@@ -324,7 +325,7 @@</span><br><span> </span><br=
><span>     struct session_id peer =3D { 0 };</span><br><span>     struct o=
ob_probe_reply reply;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    assert_false(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, 0, 0, =
0, &amp;reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, 0, 0, 0, =
0, 0, &amp;reply));</span><br><span> </span><br><span>     gc_free(&amp;gc)=
;</span><br><span> }</span><br><span>@@ -342,7 +343,7 @@</span><br><span> <=
/span><br><span>     struct session_id peer =3D { 0 };</span><br><span>    =
 struct oob_probe_reply reply;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_false(oob_build_probe_reply(&amp;buf, 1000000, 30, &amp=
;peer, 0, 0, 0, &amp;reply));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(oob_build_probe_reply(&amp;buf, 1000000, 30, &am=
p;peer, 0, 0, 0, 0, 0, &amp;reply));</span><br><span> </span><br><span>    =
 gc_free(&amp;gc);</span><br><span> }</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=
=3Demail">change 1768</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1768?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1768 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--55UN68Ice34=--


--===============5250283220600071355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5250283220600071355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5250283220600071355==--

