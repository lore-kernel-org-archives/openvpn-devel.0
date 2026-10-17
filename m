Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6D6CC6B2A
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 06:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=khipbOWrYHShKSX6JdiidoTQJg4KZszfYjEYOhRHbpY=; b=ODP4HbJ4tembRRExH7BUiHpgRM
	LZieKhVdrNMjaC4CvQGvRPcaRS005yfYIxCXn8nzpxdAl3ByIMyZDTaUSriKvR1qIc2AjD33VZ2Lt
	jD8/oc360fIAffhavtx5qPxXt57v6OnRTyZgZ7Jjqz6WttecJ6XRnILlD7nmz35ltNEI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHxZz-0005Fd-Ag;
	Sat, 17 Oct 2026 06:07:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <alepacheco99@gmail.com>) id 1xHxZx-0005FW-8Z
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 06:07:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:
 MIME-Version:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ppQ5r8WBuYP3TbhI1YxP779966BZbS4oYJa8j7lc6RY=; b=gZJ1dzHQ2y9y+nZSGD8M7ZxOAV
 T/Qgn10/FnuTbmdG+QdaB8jTaL8KHtRYNjFndCjGbDNmeEHvMNlGYqdgDNa1+JnxrUB6Q1NpBA3bh
 0SWSB4CDvEcDbGrwe9HATCPh97od0rG6STw837rPNSnkT6Y8l3TH0fHTNWz5mf5Tlsao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:MIME-Version:From:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ppQ5r8WBuYP3TbhI1YxP779966BZbS4oYJa8j7lc6RY=; b=e
 BlKtJWVwte/jAIZkYOr6iz2GNijEMRyzLO9b/wx2SccMB+YOyJb0HnM6G20mNRmC4o/iDnra0gOov
 ZboLU2I/sPTABT7iydOWv/fydRFFEu01IvDMNe7ci3a+wMsRNIh6T2zmnWI4xe53cGceDVFENX8Km
 PPDqaGJwWEbiaKXY=;
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHxZw-0000o8-JM for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 06:07:37 +0000
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cd60d155070so301339a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 23:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792217251; cv=none;
 d=google.com; s=arc-20260327;
 b=GsVDB6qeXv7BieD39RYI5B94IMIHTbYJyFtgjCrSQtzoD9h04JL9+lsbNtoPgP8JRm
 D3QQQ8MdEZenferNgzrMDz6xedWdIiV4Mo3TozNUPGjmcnovDwktXC0FWcNTsz7hm5Ir
 EsyhEVTDxwg6rL2K4xroRjnMPkF/l3Gpih4j0i4G1mCeesgcjOhvV3ZJgnNmI8n+eIQz
 TUbnUB1Ozo+kC3ylOkyFP2uwBg7Et8bVIhTvl7xGcpUB62x5hcerdO7WmKOpubhex1YJ
 DqFOFxZII/zHEWk+HYQIZNSZLZ6Lw1HhZtetD0ZNJ3mV8EjldTHUAdISwDzjrB9WPnYm
 s0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=ppQ5r8WBuYP3TbhI1YxP779966BZbS4oYJa8j7lc6RY=;
 fh=4NbAC/LsuMLI0S0hprUlLSLCiHwg6SCAifhH718Jh0Q=;
 b=ssnOx011rGt5xvLf2uRq6RoJG6GNSyfwBGTQ4kjVQhRUnf0WcuV8WIor2qW8c0rK47
 GMlLiwMAMnoaLO0D+/NxDMkfZiN6nRb5sxNPguhp0mIHvyvYrw31bGPCTYFUmfmUezp2
 6HCjleUzh/d/7UNjP7zGePTW/AScjU70BrSylbSd6AvaRxVwEXCIfFHRxbOztTzluOEp
 TzebBfXJBfobMRpz1sGFanvixd9uyOIxYjLyklRSxSp3OUrAzoueCGm2n4u1TZ80ysYw
 AYL1TkgufcXuLBR3xPT5tiAN8Laf7Aw30CRXY+28NiDupY730HEq6OqYf2pc7LVbzqb+
 z6bQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792217251; x=1792822051; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:mime-version:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ppQ5r8WBuYP3TbhI1YxP779966BZbS4oYJa8j7lc6RY=;
 b=QT8CR6/LogWyD7cvh3VUN5t2J2kcVbRG0hxn2cegugufIePuYXHEGM4h23Ra/xH2f3
 D1IcbaEWJ6dOZxfyPH92s3j+Dra2FqNa5oFzENrrCJfll3UB6y27hPB+0CoF4gWlOFtk
 r8EtDcgjQDCUwhHjGdSn/Pnqo989bO6yhJVUJ4lBJN0RzxRgNx1w5dbXeiv47g2BUMgH
 6NFL48ljteozCj2iHBSvglCbuMzXg2u0FpahksAbk+51oIQmko/2CuLo94LQ3Fwuna27
 twM0X8m/Ucy5imwye1eCGQsf6dX0YYCRWWwElbBYO666Ywl+OsW4K7Hf+dvjPGfX/J+I
 DvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792217251; x=1792822051;
 h=content-type:to:subject:message-id:date:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ppQ5r8WBuYP3TbhI1YxP779966BZbS4oYJa8j7lc6RY=;
 b=QkFZLJdWvs04f3hq4ZHLeQi9N02uLC/+sDEoGJyIfmxaA8Qua3Tnr1cTb2pp/nYay4
 /GZ2f5mjdCS8EwJbTtTXjH37AmzLKU7j6eobuHhN9DOHcFwD7d15cM+biHKGFC2tza77
 ah7d4nLKbKOa5MzFAPBpHC4aL3/eSS34zF9OFJTpLSfnClIr4djob1jVs+JnIQjQ/f9i
 tZIwqv5ofSQuE4kfw10rQUJ+R6kOHxxsohg/FyPWy90Xe6g9T9Nl4fQf3cRzLC3WaeW6
 IpM7bTpJ5XlmNyBGYbF3jjzznYPN7cBMT5sD8QbG5bKaw2WendvfGAb4jRL6JyEj0vrP
 7xbA==
X-Gm-Message-State: AFq9FYKTVAy+D3R9nCM5I3kRdSrUTqdEL3uE0z+5g1lNIWngq3eNFI7k
 JjD/Z5JNNfSv1lJHZ3oUnF3pmeD5Tnlg62UT5eyboKyFtab3a2QG5ZoqT3si0jm0vD7hPv0/ZnY
 gDTB6nQjZLm3VstkKeDydWjMUD23fgOglgQ8ArbCStmMK
X-Gm-Gg: AYBFou04hIpE22dn3zr6NY4wIEl4QnMjGV4uWVUGEZ9RILL74fmzGixLCz/v8Xih7HV
 mSc3Pt55uhN8L17UrRYjp4UUcc/Ueglnw8y6/ARF/PVPVm5qLvLsZFnLxKPD9IgKNw1d/VxLj++
 B0T32Zv9Kih0nMLYvHJGDnc1ye6dAzrvWi3qpqvtqbhaj3Hs0jiFwVw6G88TLTq9n5Gfy4qJSV9
 jjeU8pfO5EGBdDvZxgibGEKGU5ZWbR3UX6+Zy80IxQOrK3/WZakhEz7aa/FMVX1BHkxcrNW6t7B
 JCfFPannM+zDl2QvpGuilIvjXAToURQPPbw2uX1rc+4ksUjOkDdhpIes/4kNCXG/7i+kz9fQ1eY
 CfqF/p2Su3Brl3Pd8bLNf7n2W1OvNdqGecMIjlw==
X-Received: by 2002:a05:6a20:cd8f:b0:3e1:482c:77ca with SMTP id
 adf61e73a8af0-3e225d22ccamr1259794637.5.1792217250574; Fri, 16 Oct 2026
 23:07:30 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 02:07:30 -0400
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 02:07:30 -0400
From: Alejandro Pacheco <alepacheco99@gmail.com>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 02:07:30 -0400
X-Gm-Features: AclHuK_rkkklcGBi202Wx2Zl8T0qU1jTZNdAukGJIsEgJ5u55plDinvQQ7QmL1A
Message-ID: <CAB8Pm=zZCRoNH8ZkbOWbawmvHUd9+AgY+yas5p_5N6695weFTQ@mail.gmail.com>
To: openvpn-devel@lists.sourceforge.net
X-Headers-End: 1xHxZw-0000o8-JM
Subject: [Openvpn-devel] [PATCH] Keep the outgoing control packet in a
 buffer owned by tls_multi
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

tls_multi_process() returns the outgoing control packet in to_link.
Until now to_link pointed into memory owned by a session or key state:
the reliable send buffer, ks->ack_write_buf, or the tls_wrap or
tls_wrap_reneg work buffer.  When that session or key state was freed
or reset before the packet was written to the link, to_link was left
pointing to freed memory.  This caused CVE-2023-46850, CVE-2026-40215,
CVE-2026-12996, CVE-2026-13117 and CVE-2026-84471.

The fixes so far added check_session_buf_not_used() and
check_keystate_buf_not_used(), which compare to_link against a list of
the buffers of a session or key state before it is freed and drop the
packet on a match.  This only works as long as the list names every
buffer a packet can end up in and every caller that frees a session or
key state passes to_link down: key_state_soft_reset() is called without
it from tls_pre_decrypt() and tls_session_soft_reset().

Fix the ownership instead.  write_control_auth() now copies the
finished packet into a buffer the caller owns, and tls_multi_process()
returns it in multi->to_link_buf, which lives as long as the tls_multi,
like multi->to_link_addr already does for the address.  Freeing or
moving sessions and key states no longer affects a pending packet, so
the checks and the to_link parameters of key_state_free(),
tls_session_free(), move_session(), reset_session() and
key_state_soft_reset() are removed.  A packet that is pending when its
session is freed is now sent instead of dropped; the peer handles it
like any late packet of that session.

The copy costs one memcpy of a control channel packet.  The new unit
test checks that the packet written by write_control_auth() stays
intact and valid after the buffers it was built from are overwritten,
with no wrapping, tls-auth and tls-crypt.

Signed-off-by: Alejandro Pacheco <alepacheco99@gmail.com>
---
64fae9d8 ("Ensure that buffer of freed session are not used") and
2a881d73 ("Move check_session_buf_not_used method into the method that
free the buffer") call the check_*_buf_not_used() checks a band-aid that
a real fix would replace with more refactoring.  This patch does that for
the to_link buffer only: it does not remove TM_INITIAL or change how
sessions are moved.

Tested on an ASan/UBSan build with OpenSSL 3.5.4: all unit tests,
t_lpback.sh, and t_cltsrv.sh, whose loopback configs renegotiate every
10 seconds with tls-auth (22 renegotiations, no sanitizer reports).

 src/openvpn/ssl.c                   | 169 +++++-----------------------
 src/openvpn/ssl_common.h            |   8 ++
 src/openvpn/ssl_pkt.c               |  20 +++-
 src/openvpn/ssl_pkt.h               |  25 +++-
 tests/unit_tests/openvpn/test_pkt.c | 103 +++++++++++++++++
 5 files changed, 178 insertions(+), 147 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 35948715..d52d539c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -96,14 +96,6 @@ show_tls_performance_stats(void)

 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */

-/* forward decleration since tls_process needs this function prototype */
-static void
-check_session_buf_not_used(struct buffer *to_link, struct tls_session
*session);
-
-static void
-check_keystate_buf_not_used(struct buffer *to_link, const struct
key_state *ks);
-
-
 /**
  * Limit the reneg_bytes value when using a small-block (<128 bytes) cipher.
  *
@@ -904,15 +896,10 @@ key_state_init(struct tls_session *session,
struct key_state *ks)
  *                       cleaned up.
  * @param clear        - Whether the memory allocated for the \a ks object
  *                       should be overwritten with 0s.
- *
- * @param to_link      - if not NULL, check that the buffer does not contain
- *                       any pointer to one of the internal structs of ks
  */
 static void
-key_state_free(struct key_state *ks, bool clear, struct buffer *to_link)
+key_state_free(struct key_state *ks, bool clear)
 {
-    check_keystate_buf_not_used(to_link, ks);
-
     ks->state = S_UNDEF;

     key_state_ssl_free(&ks->ks_ssl);
@@ -1056,14 +1043,10 @@ tls_session_init(struct tls_multi *multi,
struct tls_session *session)
  *                       object should be overwritten with 0s. This
  *                       implicitly sets many states to 0/false,
  *                       e.g. the validity of the keys in the structure
- * @param to_link      - if not NULL, check that the buffer does not contain
- *                       any pointer to one of the internal structs of ks
- *
  */
 static void
-tls_session_free(struct tls_session *session, bool clear, struct
buffer *to_link)
+tls_session_free(struct tls_session *session, bool clear)
 {
-    check_session_buf_not_used(to_link, session);
     tls_wrap_free(&session->tls_wrap);
     tls_wrap_free(&session->tls_wrap_reneg);

@@ -1072,7 +1055,7 @@ tls_session_free(struct tls_session *session,
bool clear, struct buffer *to_link
         /* we don't need clear=true for this call since
          * the structs are part of session and get cleared
          * as part of session */
-        key_state_free(&session->key[i], false, to_link);
+        key_state_free(&session->key[i], false);
     }

     free(session->common_name);
@@ -1091,16 +1074,14 @@ tls_session_free(struct tls_session *session,
bool clear, struct buffer *to_link


 static void
-move_session(struct tls_multi *multi, int dest, int src, bool reinit_src,
-             struct buffer *to_link)
+move_session(struct tls_multi *multi, int dest, int src, bool reinit_src)
 {
-    check_session_buf_not_used(to_link, &multi->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session: dest=%s src=%s reinit_src=%d",
         session_index_name(dest), session_index_name(src), reinit_src);
     ASSERT(src != dest);
     ASSERT(src >= 0 && src < TM_SIZE);
     ASSERT(dest >= 0 && dest < TM_SIZE);
-    tls_session_free(&multi->session[dest], false, to_link);
+    tls_session_free(&multi->session[dest], false);
     multi->session[dest] = multi->session[src];

     if (reinit_src)
@@ -1116,9 +1097,9 @@ move_session(struct tls_multi *multi, int dest,
int src, bool reinit_src,
 }

 static void
-reset_session(struct tls_multi *multi, struct tls_session *session,
struct buffer *to_link)
+reset_session(struct tls_multi *multi, struct tls_session *session)
 {
-    tls_session_free(session, false, to_link);
+    tls_session_free(session, false);
     tls_session_init(multi, session);
 }

@@ -1192,6 +1173,8 @@ void
 tls_multi_init_finalize(struct tls_multi *multi, int tls_mtu)
 {
     tls_init_control_channel_frame_parameters(&multi->opt.frame, tls_mtu);
+    multi->to_link_buf = alloc_buf(BUF_SIZE(&multi->opt.frame));
+
     /* initialize the active and untrusted sessions */

     tls_session_init(multi, &multi->session[TM_ACTIVE]);
@@ -1283,9 +1266,11 @@ tls_multi_free(struct tls_multi *multi, bool clear)

     for (int i = 0; i < TM_SIZE; ++i)
     {
-        tls_session_free(&multi->session[i], false, NULL);
+        tls_session_free(&multi->session[i], false);
     }

+    free_buf(&multi->to_link_buf);
+
     if (clear)
     {
         secure_memzero(multi, sizeof(*multi));
@@ -1816,13 +1801,13 @@ flush_payload_buffer(struct key_state *ks)
  * active key.
  */
 static void
-key_state_soft_reset(struct tls_session *session, struct buffer *to_link)
+key_state_soft_reset(struct tls_session *session)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];        /* primary key */
     struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */

     ks->must_die = now + session->opt->transition_window;    /*
remaining lifetime of old key */
-    key_state_free(ks_lame, false, to_link);
+    key_state_free(ks_lame, false);
     *ks_lame = *ks;

     key_state_init(session, ks);
@@ -1833,7 +1818,7 @@ key_state_soft_reset(struct tls_session
*session, struct buffer *to_link)
 void
 tls_session_soft_reset(struct tls_multi *tls_multi)
 {
-    key_state_soft_reset(&tls_multi->session[TM_ACTIVE], NULL);
+    key_state_soft_reset(&tls_multi->session[TM_ACTIVE]);
 }

 /*
@@ -2914,18 +2899,15 @@ tls_process_state(struct tls_multi *multi,
struct tls_session *session, struct b

         const struct buffer *buf = reliable_send(ks->send_reliable, &opcode);
         ASSERT(buf);
-        struct buffer b = *buf;
         INCR_SENT;

-        write_control_auth(session, ks, &b, to_link_addr, opcode,
CONTROL_SEND_ACK_MAX, true);
-        *to_link = b;
+        write_control_auth(session, ks, buf, &multi->to_link_buf,
to_link_addr, opcode,
+                           CONTROL_SEND_ACK_MAX, true);
+        *to_link = multi->to_link_buf;
         dmsg(D_TLS_DEBUG, "Reliable -> TCP/UDP");

-        /* This changed the state of the outgoing buffer. In order to avoid
-         * running this function again/further and invalidating the key_state
-         * buffer and accessing the buffer that is now in to_link
after it being
-         * freed for a potential error, we shortcircuit exiting of the outer
-         * process here. */
+        /* This changed the state of the outgoing buffer. Stop this
+         * processing pass so that the event loop can send the packet. */
         return false;
     }

@@ -3165,13 +3147,13 @@ tls_process(struct tls_multi *multi, struct
tls_session *session, struct buffer
             session->opt->aead_usage_limit,
             ks->crypto_options.key_ctx_bi.decrypt.plaintext_blocks +
ks->n_packets,
             session->opt->aead_usage_limit);
-        key_state_soft_reset(session, to_link);
+        key_state_soft_reset(session);
     }

     /* Kill lame duck key transition_window seconds after primary key
negotiation */
     if (lame_duck_must_die(session, wakeup))
     {
-        key_state_free(ks_lame, true, to_link);
+        key_state_free(ks_lame, true);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }

@@ -3220,8 +3202,9 @@ tls_process(struct tls_multi *multi, struct
tls_session *session, struct buffer
         {
             struct buffer buf = ks->ack_write_buf;
             ASSERT(buf_init(&buf, multi->opt.frame.buf.headroom));
-            write_control_auth(session, ks, &buf, to_link_addr,
P_ACK_V1, RELIABLE_ACK_SIZE, false);
-            *to_link = buf;
+            write_control_auth(session, ks, &buf,
&multi->to_link_buf, to_link_addr, P_ACK_V1,
+                               RELIABLE_ACK_SIZE, false);
+            *to_link = multi->to_link_buf;
             dmsg(D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
         }
     }
@@ -3264,98 +3247,6 @@ tls_process(struct tls_multi *multi, struct
tls_session *session, struct buffer
     return false;
 }

-static void
-check_keystate_buf_not_used(struct buffer *to_link, const struct key_state *ks)
-{
-    if (ks->state == S_UNDEF || !to_link || !to_link->data)
-    {
-        return;
-    }
-
-    const uint8_t *dataptr = to_link->data;
-
-    /* we don't expect send_reliable to be NULL when state is
-     * not S_UNDEF, but people have reported crashes nonetheless,
-     * therefore we better catch this event, report and exit.
-     */
-    if (!ks->send_reliable)
-    {
-        msg(M_FATAL,
-            "ERROR: ks.send_reliable (key-id %d), is NULL "
-            "while key state is %s. Exiting.",
-            ks->key_id, state_name(ks->state));
-    }
-
-    for (int j = 0; j < ks->send_reliable->size; j++)
-    {
-        if (ks->send_reliable->array[j].buf.data == dataptr)
-        {
-            msg(M_INFO,
-                "Warning buffer of freed TLS session is still in"
-                " use (key-id %d, ks.send_reliable->array[%d])",
-                ks->key_id, j);
-
-            goto used;
-        }
-    }
-
-    if (ks->ack_write_buf.data == dataptr)
-    {
-        msg(M_INFO, "Warning buffer of freed TLS session is still in use "
-                    "(ks.ack_write_buf, key-id %d)",
-            ks->key_id);
-
-        goto used;
-    }
-    return;
-
-used:
-    to_link->len = 0;
-    to_link->data = 0;
-}
-
-/**
- * This is a safe guard function to double check that a buffer from a
session is
- * not used in a session to avoid a use after free.
- *
- * @param to_link
- * @param session
- */
-static void
-check_session_buf_not_used(struct buffer *to_link, struct tls_session *session)
-{
-    if (!to_link || !to_link->data)
-    {
-        return;
-    }
-    const uint8_t *dataptr = to_link->data;
-
-    /* Checks buffers in tls_wrap */
-    if (session->tls_wrap.work.data == dataptr)
-    {
-        msg(M_INFO, "Warning buffer of freed TLS session is "
-                    "still in use (tls_wrap.work.data)");
-        goto used;
-    }
-    if (session->tls_wrap_reneg.work.data == dataptr)
-    {
-        msg(M_INFO, "Warning buffer of freed TLS session is "
-                    "still in use (tls_wrap_reneg.work.data)");
-        goto used;
-    }
-
-    for (int i = 0; i < KS_SIZE; i++)
-    {
-        const struct key_state *ks = &session->key[i];
-        check_keystate_buf_not_used(to_link, ks);
-    }
-    return;
-
-used:
-    to_link->len = 0;
-    to_link->data = 0;
-    /* for debugging, you can add an ASSERT(0); here to trigger an abort */
-}
 /*
  * Called by the top-level event loop.
  *
@@ -3444,11 +3335,11 @@ tls_multi_process(struct tls_multi *multi,
struct buffer *to_link,
                 if (i == TM_ACTIVE && ks_lame->state >= S_GENERATED_KEYS
                     && !multi->opt.single_session)
                 {
-                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE,
true, to_link);
+                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
                 }
                 else
                 {
-                    reset_session(multi, session, to_link);
+                    reset_session(multi, session);
                 }
             }
         }
@@ -3511,7 +3402,7 @@ tls_multi_process(struct tls_multi *multi,
struct buffer *to_link,
      */
     if (lame_duck_must_die(&multi->session[TM_LAME_DUCK], wakeup))
     {
-        tls_session_free(&multi->session[TM_LAME_DUCK], true, to_link);
+        tls_session_free(&multi->session[TM_LAME_DUCK], true);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed expiring key");
     }

@@ -3526,7 +3417,7 @@ tls_multi_process(struct tls_multi *multi,
struct buffer *to_link,
      */
     if (TLS_AUTHENTICATED(multi, &multi->session[TM_INITIAL].key[KS_PRIMARY]))
     {
-        move_session(multi, TM_ACTIVE, TM_INITIAL, true, to_link);
+        move_session(multi, TM_ACTIVE, TM_INITIAL, true);
         tas = tls_authentication_status(multi);
         msg(D_TLS_DEBUG_LOW,
             "TLS: tls_multi_process: initial untrusted "
@@ -3938,7 +3829,7 @@ tls_pre_decrypt(struct tls_multi *multi, const
struct link_socket_actual *from,
                 goto error;
             }

-            key_state_soft_reset(session, NULL);
+            key_state_soft_reset(session);

             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V1
s=%d sid=%s", i,
                  session_id_print(&sid, &gc));
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f6392f9a..a0f677ec 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -627,6 +627,14 @@ struct tls_multi
      */
     struct link_socket_actual to_link_addr;

+    /**
+     * Holds the outgoing control packet returned by tls_multi_process.
+     * It belongs to the tls_multi and not to a session or key state, so
+     * it stays valid when these are freed or moved before the packet is
+     * written to the link.
+     */
+    struct buffer to_link_buf;
+
     int n_sessions; /**< Number of sessions negotiated thus
                      *   far. */
     enum multi_status multi_state;
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index f78782fa..d8a1cefa 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -163,10 +163,14 @@ tls_wrap_control(struct tls_wrap_ctx *ctx,
uint8_t header, struct buffer *buf,
 }

 void
-write_control_auth(struct tls_session *session, struct key_state *ks,
struct buffer *buf,
-                   struct link_socket_actual **to_link_addr, int
opcode, int max_ack,
-                   bool prepend_ack)
+write_control_auth(struct tls_session *session, struct key_state *ks,
const struct buffer *payload,
+                   struct buffer *out, struct link_socket_actual
**to_link_addr, int opcode,
+                   int max_ack, bool prepend_ack)
 {
+    /* Work on a copy so that tls_wrap_control can point it at another
+     * buffer without modifying the caller's buffer */
+    struct buffer buf = *payload;
+
     ASSERT(ks->key_id >= 0 && ks->key_id <= P_KEY_ID_MASK);
     ASSERT(opcode >= 0 && opcode <= P_LAST_OPCODE);
     uint8_t header = (uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT));
@@ -181,14 +185,20 @@ write_control_auth(struct tls_session *session,
struct key_state *ks, struct buf
     }

     ASSERT(link_socket_actual_defined(&ks->remote_addr));
-    ASSERT(reliable_ack_write(ks->rec_ack, ks->lru_acks, buf,
&ks->session_id_remote, max_ack,
+    ASSERT(reliable_ack_write(ks->rec_ack, ks->lru_acks, &buf,
&ks->session_id_remote, max_ack,
                               prepend_ack));

     msg(D_TLS_DEBUG, "%s(): %s", __func__, packet_opcode_name(opcode));

-    tls_wrap_control(tls_session_get_tls_wrap(session, ks->key_id),
header, buf,
+    tls_wrap_control(tls_session_get_tls_wrap(session, ks->key_id),
header, &buf,
                      &session->session_id);

+    /* buf now points into memory owned by ks or session (the payload's
+     * buffer or the tls_wrap work buffer).  Either can be freed before
+     * the packet is written to the link, so copy the packet to out. */
+    ASSERT(buf_init(out, buf.offset));
+    ASSERT(buf_copy(out, &buf));
+
     *to_link_addr = &ks->remote_addr;
 }

diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 8203e4ac..d02b4b09 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -185,10 +185,29 @@ struct session_id
calculate_session_id_hmac(struct session_id client_sid,
 bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state
*state, const struct openvpn_sockaddr *from,
                                    const uint8_t *key, int
handwindow, bool pkt_is_ack);

-/*
- * Write a control channel authentication record.
+/**
+ * Write a control channel packet: add the ACKs, the opcode and session id
+ * header and the tls-auth/tls-crypt wrapping to \c payload.
+ *
+ * @param session           the TLS session the packet belongs to
+ * @param ks                the key state the packet belongs to
+ * @param payload           the packet payload. Its data is left
+ *                          unchanged, but the space around it in its
+ *                          buffer is used to build the packet.
+ * @param out               buffer the finished packet is written to, at
+ *                          the offset it was built at. It must be owned
+ *                          by the caller, not share memory with \c payload
+ *                          or the tls_wrap work buffers, and have room for
+ *                          the packet at that offset (a buffer of
+ *                          BUF_SIZE() of the session's frame does).
+ * @param to_link_addr      set to the address the packet is sent to
+ * @param opcode            opcode of the packet
+ * @param max_ack           maximum number of ACKs to add
+ * @param prepend_ack       add the ACKs in front of the payload instead
+ *                          of writing them into it
  */
-void write_control_auth(struct tls_session *session, struct key_state
*ks, struct buffer *buf,
+void write_control_auth(struct tls_session *session, struct key_state *ks,
+                        const struct buffer *payload, struct buffer *out,
                         struct link_socket_actual **to_link_addr, int
opcode, int max_ack,
                         bool prepend_ack);

diff --git a/tests/unit_tests/openvpn/test_pkt.c
b/tests/unit_tests/openvpn/test_pkt.c
index 51c73d8e..120f98f6 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -741,6 +741,108 @@ test_wkc_not_appended_without_key(void **ut_state)
     free_tas(&tas);
 }

+/* write_control_auth() writes the finished packet to the out buffer of the
+ * caller, so the packet stays valid when the buffers of the session and key
+ * state are reused or freed before it is sent. */
+static void
+check_write_control_auth_out_buf(struct tls_wrap_ctx *wrap, struct
tls_wrap_ctx *peer_wrap)
+{
+    struct tls_options opt = { 0 };
+    opt.server = true;
+
+    struct tls_session session = { 0 };
+    session.opt = &opt;
+    session.tls_wrap = *wrap;
+    session.session_id = (struct session_id){ { 1, 2, 3, 4, 5, 6, 7, 8 } };
+
+    struct reliable_ack rec_ack = { .len = 1, .packet_id = { 7 } };
+    struct reliable_ack lru_acks = { 0 };
+    struct key_state ks = { 0 };
+    ks.rec_ack = &rec_ack;
+    ks.lru_acks = &lru_acks;
+    ks.session_id_remote = (struct session_id){ { 8, 7, 6, 5, 4, 3, 2, 1 } };
+    ks.remote_addr.dest.addr.sa.sa_family = AF_INET;
+    ks.remote_addr.dest.addr.in4.sin_addr.s_addr = htonl(0x01020304);
+
+    const uint8_t data[] = "control channel payload";
+    struct buffer payload = alloc_buf(1600);
+    struct buffer out = alloc_buf(1600);
+
+    /* a control packet with the ACK in front of its payload, as sent from
+     * the reliability layer, and a dedicated ACK packet */
+    for (int i = 0; i < 2; i++)
+    {
+        const bool dedicated_ack = (i == 1);
+        const size_t len = dedicated_ack ? 0 : sizeof(data);
+
+        assert_true(buf_init(&payload, 200));
+        assert_true(buf_write(&payload, data, len));
+
+        struct link_socket_actual *to_link_addr = NULL;
+        write_control_auth(&session, &ks, &payload, &out, &to_link_addr,
+                           dedicated_ack ? P_ACK_V1 : P_CONTROL_V1,
RELIABLE_ACK_SIZE,
+                           !dedicated_ack);
+
+        assert_ptr_equal(to_link_addr, &ks.remote_addr);
+        assert_int_equal(BLEN(&payload), len);
+        assert_memory_equal(BPTR(&payload), data, len);
+        assert_true(BLENZ(&out) > len);
+
+        /* the packet is still intact after the session buffers are
overwritten */
+        memset(payload.data, 0x55, payload.capacity);
+        if (session.tls_wrap.work.data)
+        {
+            memset(session.tls_wrap.work.data, 0x55,
session.tls_wrap.work.capacity);
+        }
+
+        struct link_socket_actual from = { 0 };
+        assert_true(read_control_auth(&out, peer_wrap, &from, &opt));
+
+        struct reliable_ack ack;
+        struct session_id sid;
+        assert_true(reliable_ack_parse(&out, &ack, &sid));
+        assert_int_equal(ack.len, 1);
+        assert_int_equal(ack.packet_id[0], 7);
+        assert_memory_equal(&sid, &ks.session_id_remote, SID_SIZE);
+        assert_int_equal(BLEN(&out), len);
+        assert_memory_equal(BPTR(&out), data, len);
+    }
+
+    free_buf(&out);
+    free_buf(&payload);
+}
+
+static void
+test_write_control_auth_out_buf(void **ut_state)
+{
+    now = 0x22446688;
+
+    struct tls_wrap_ctx none = { .mode = TLS_WRAP_NONE };
+    check_write_control_auth_out_buf(&none, &none);
+
+    struct tls_auth_standalone tas_client =
init_tas_auth(KEY_DIRECTION_INVERSE);
+    struct tls_auth_standalone tas_server =
init_tas_auth(KEY_DIRECTION_NORMAL);
+    packet_id_init(&tas_client.tls_wrap.opt.packet_id, 5, 5, "UNITTEST", 0);
+    packet_id_init(&tas_server.tls_wrap.opt.packet_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
+    check_write_control_auth_out_buf(&tas_client.tls_wrap,
&tas_server.tls_wrap);
+    packet_id_free(&tas_client.tls_wrap.opt.packet_id);
+    packet_id_free(&tas_server.tls_wrap.opt.packet_id);
+    free_tas(&tas_client);
+    free_tas(&tas_server);
+
+    tas_client = init_tas_crypt(false);
+    tas_server = init_tas_crypt(true);
+    packet_id_init(&tas_client.tls_wrap.opt.packet_id, 5, 5, "UNITTEST", 0);
+    packet_id_init(&tas_server.tls_wrap.opt.packet_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
+    check_write_control_auth_out_buf(&tas_client.tls_wrap,
&tas_server.tls_wrap);
+    packet_id_free(&tas_client.tls_wrap.opt.packet_id);
+    packet_id_free(&tas_server.tls_wrap.opt.packet_id);
+    free_tas(&tas_client);
+    free_tas(&tas_server);
+}
+
 static void
 test_extract_control_message(void **ut_state)
 {
@@ -792,6 +894,7 @@ main(void)
         cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
         cmocka_unit_test(test_wkc_not_appended_without_key),
+        cmocka_unit_test(test_write_control_auth_out_buf),
         cmocka_unit_test(test_extract_control_message)
     };

-- 
2.53.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
