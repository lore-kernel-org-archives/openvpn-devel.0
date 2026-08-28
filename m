Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCB2C61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x22gAneD4sJyKPayCvZA/FV1bhPakyfPKUNBTflKoNs=; b=PDXzSx6UtmDexJ3lcyNQ8THjjF
	Ts5JMCwITWd70P1jAb92XNzL/sbDaiKz0MqtgBukQIqcatMXKvvA8WL5TfL/PJLfXB+1m00E2K7a/
	A3u+TBmEtwyYNg+j14FWgXHY5LoXVQmaKdVgnsx9az3Jq11Bm14PPLRvDiF9wGLIO/QA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw3V-0000ql-0x;
	Fri, 28 Aug 2026 12:51:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw3R-0000qI-BV
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yipz626rZOZp8KHQL9j2k24Bfw9e8O8lvAUpZFKQ+Y4=; b=ijGVVuf4hZyI+VRNNWknaRmMS5
 06yNFXv9vv7NAMC7XuO+vMQyPhkIUy6bZjYKs3DD/bm0BLInhvYmHU96mn0siwxgl2kBk+CthUQK1
 4SPidk5xDH68mAy0NRvzDVf4I2btJcoLiro5CVtnRFZy7Dqvsu1z6uCgSpbKxT2z0cEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yipz626rZOZp8KHQL9j2k24Bfw9e8O8lvAUpZFKQ+Y4=; b=Y
 UTzp/LktP7frTTeQUxKWw+5hQ0nWG66+bKg0JMzmEAbBR39f75J90VIJej88IgJq7s3zXefiIZqtY
 og3DOWd5Jf+wUBAqj2Gh/6FN/bW6FaxDYt+XwW1yyibGE0tq3qpWAJM2rC9vWXJi/s7hlpllktyKh
 m07/xGjBS4JLiUSA=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw3C-0005Fz-UZ for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:33 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso9507195e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921472; x=1788526272; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yipz626rZOZp8KHQL9j2k24Bfw9e8O8lvAUpZFKQ+Y4=;
 b=AamBgSOkl50I34yy2rZTv/0QzM3SpN4r6qal2JliAH/tYKMlYXcGsl8w+lyN83yg/m
 moKRhIq676BUN3yJCj1AKGpG39RGSdyABljkJT11ILVjgCzngBaGB46dUQJM8ua7ZvOo
 6Xyse2ak/MF/qL96J1kJe3W6y17uIfuz1B1ABN/96b7xv3TjXs7mI26jJtmQGcQSwAdo
 5rSyH+V8850Wkekia4ck8RB54LwFwXFj+oAHE6TTN74VR+H/vbz6kGusqjRBHM7l9VJx
 jdH483wNOEN3v83IRrYzLc/PJ1EmGz/FrhRLMXpv7G3qcu6jjMgUnuVBanVJc16/AakX
 almg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921472; x=1788526272;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yipz626rZOZp8KHQL9j2k24Bfw9e8O8lvAUpZFKQ+Y4=;
 b=snxZgcobD2dO9v3zDNNXlqs2eSb5eqrNnwhasRx+RRAo3/ubvN2BoOwPnHFkDzIcou
 ap4vb1ck0LV+SFBgOxP2FIb4pyf/gS9mvEkq64SiI4r8jIBq7WvRK/I9rR9rKBDFx7Fh
 qEYpsUOMwSrvHS4h3cqeD6YYb2T2Y64c2czfhJ1/yIPs76UPGyCRZHbXPXl1x9M19aNq
 vC7Pnf0QKhnYmik8WsZ1o7VFESKamAsTREALH7Yce09Se/2MvixwPAs9MMkWsjzsKWUi
 HtOvczL3mP0FFG7UGCz7vaiWfR5OzJs91yst/ZQ/h5BlCHVq+cHcmn5aq3Sjmc0AGjlE
 wAbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMMTanmXNwggIpsek+CV1cwfvydssrvbfwWuXN8grTPm4xBZrlsecd4eH4N2/437itG0eXQJ8v1y4kwu2Q@lists.sourceforge.net
X-Gm-Message-State: AFuF++k7nmtJjejrztovklColXj3U75j/gP5k+Cjxt78xlcyEWoSmlrQ
 HM7LMUGRQzKqHlsLYlpX1H3ZqIkJJwGYgZqo/mUgPyx8ZozKYQsCLO0YU8WlNCOJEpJOWN9WVka
 j3N577wld4TxODwg6GDTSoqB3iAZOpp0Mi4TBqDOQ274zG6g0tEjJtzLXdKLWzIK+gOC6
X-Gm-Gg: AR+sD12F+WCcM97brbBbHBzMpOosQ9IeWl1xpfjBDgn4v5AFiGBJal2UUXnzEl9FEi+
 B260yPOovH6F54aGrVWOf+wV6pVTO2RJUnLG7xtdEdMMsYAkvcjPDcSNKdrUKSNfZC8dR6283md
 dtk2K9ptXDALDbLUjAEUIbdh0mHyvCtaXdl125GVx2emtLyNIQhXwALqW0kblwDrENxWR+HWRgg
 nmT2lgAixX/gDduWnMFUq5HgfzMrZb5l+4EwYVdjvh8fOAj3kTFDEYpbplRGgSVkyMMOow/5D0L
 ZhUT46144sOUiE3W2Lsz7mZ3GVdP61T56uUxUcu4TCi/pUy78vdhMjTRswIh7s8xWefnI8xO37s
 2AtPDaoVb/flafCQSL+pn4N89Io9Gh4BWmJmkpWatZOVw3YHLs1TEDudktQFLuLvOYpdTGP7bZ9
 JgY30cgIr6dFLJNWrBdG3Qi0HYltUS1uH7vmf/PmwTml1bcLf30JqS6M4tauBaaiLQEpRZ1xPY+
 9K+jVI4x4B+ecT/GCUvQrsBtkHAUt9OxkgENoeiylGibIsSr9PfsqvrQDuX9mLZ7JlUdsQJ5loJ
 mrFl3TOX8x2LKAif4h6l34hpdk6OYKdSCPDzfUYXyA3KC9rBj76xwlY5PIBcKQ==
X-Received: by 2002:a05:600c:c4aa:b0:499:d513:e507 with SMTP id
 5b1f17b1804b1-49b91c17d72mr80436865e9.2.1787921471280; 
 Fri, 28 Aug 2026 05:51:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4e2c1af7sm131186875e9.15.2026.08.28.05.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:51:10 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:51:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: a5e4c6c7420d0a40fd560f4b51a5e3796d101fec
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <afdaa0452b251eb8fe4eb937365a8dee6c510be2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw3C-0005Fz-UZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0368379735656289217=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0368379735656289217==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7TdtJq1cVQM="; charset=UTF-8

--7TdtJq1cVQM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail

to look at the new patch=
 set (#12)=2E


Change subject: oob: Answer SERVER_PROBE on the server (P_C=
ONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


oob: Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)

Make a --mode =
server UDP listener answer an out-of-band SERVER_PROBE without
creating a s=
ession, so probing costs the server no state:

  - tls_pre_decrypt_lite() a=
ccepts P_CONTROL_OOB_V1 and returns the new
    VERDICT_VALID_OOB_V1 verdic=
t=2E
  - tls_wrap_oob_standalone() builds a session-less P_CONTROL_OOB_V1 p=
acket:
    opcode + session id + the usual tls-auth/tls-crypt wrapping arou=
nd a bare
    TLV payload (no reliability/ACK fields), mirroring tls_reset_=
standalone()=2E
  - oob_client_reply_write() writes the PROBE_REPLY message=
 (message-type
    header + probe_reply TLV)=2E
  - do_pre_decrypt_check() =
handles the new verdict: it asks
    oob_build_probe_reply() whether to ans=
wer, and if so sends a PROBE_REPLY
    via send_probe_reply() (synchronous,=
 stateless, like the HMAC reset path)
    and returns false so no session i=
s created=2E The verdict joins the reset
    verdicts in the reflect_filter=
 rate-limit check, so a probe flood is capped
    like a reset flood=2E

Th=
e reply carries, as its own session id, the stateless SYN-cookie the three-=
way
handshake uses, so the server keeps nothing per probe and a client can =
later
reuse the reply as the server's reset=2E

Change-Id: I930d3789e0313aa=
0c3bc51ee5fd1d108343d59f0
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
-=
--
M src/openvpn/mudp=2Ec
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M src=
/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
5 files changed, 118 inserti=
ons(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/44/1744/12

diff --git a/src/openvpn/mudp=2Ec b/src/openvp=
n/mudp=2Ec
index de3d467=2E=2E01d7441 100644
--- a/src/openvpn/mudp=2Ec
+++=
 b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
 #includ=
e "ssl_pkt=2Eh"
+#include "oob=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include =
<sys/inotify=2Eh>
@@ -87,6 +88,34 @@
                           "Reset pack=
et from client, sending HMAC based reset challenge", sock);
 }
 
+/* Send a=
n out-of-band PROBE_REPLY back to the source of a SERVER_PROBE,
+ * synchro=
nously and without keeping any state, mirroring the reset path=2E */
+stati=
c void
+send_probe_reply(struct multi_context *m, struct tls_pre_decrypt_st=
ate *state,
+                 struct tls_auth_standalone *tas, const struct=
 oob_probe_reply *reply,
+                 struct session_id *own_sid, stru=
ct link_socket *sock)
+{
+    struct gc_arena gc =3D gc_new();
+
+    /* Bu=
ild the payload of the reply (message-type header + probe_reply TLV) */
+  =
  struct buffer payload =3D alloc_buf_gc(128, &gc);
+    if (!oob_client_re=
ply_write(&payload, reply))
+    {
+        gc_free(&gc);
+        return;
=
+    }
+
+    /* OOB replies use the same control-channel wrapping as the r=
equest */
+    reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=
=2Esend);
+    state->tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =
=3D true;
+
+    struct buffer buf =3D tls_wrap_oob_standalone(&state->tls_=
wrap_tmp, tas, own_sid, &payload);
+    send_standalone_reply(m, &buf, "Ser=
ver Probe", "Server probe from client, sending probe reply",
+             =
             sock);
+
+    gc_free(&gc);
+}
+
 
 /* Returns true if this pa=
cket should create a new session */
 static bool
@@ -105,7 +134,8 @@
     c=
onst struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     int=
 handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
-    if (verdict =3D=
=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2)
+    i=
f (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RE=
SET_V2
+        || verdict =3D=3D VERDICT_VALID_OOB_V1)
     {
         /* =
Check if we are still below our limit for sending out
          * responses=
 */
@@ -203,6 +233,31 @@
 
         return ret;
     }
+    else if (verdic=
t =3D=3D VERDICT_VALID_OOB_V1)
+    {
+        /* Out-of-band server probe=
=2E state->newbuf points at the TLV payload
+         * (read_control_auth =
has stripped the opcode, session id and any
+         * tls-auth/tls-crypt =
wrapping)=2E Answer it without creating a session=2E */
+        struct oob=
_probe_reply reply;
+        if (!oob_build_probe_reply(&state->newbuf, (ui=
nt64_t)now, (uint64_t)handwindow,
+                                   &stat=
e->peer_session_id, &reply))
+        {
+            /* malformed or replay=
ed/stale probe: silently drop */
+            return false;
+        }
+
+ =
       /* Our session id is a stateless SYN cookie (the same HMAC the three=
-way
+         * handshake uses): we keep no per-probe state, and the reply=
 can later
+         * also serve as the server's CONTROL_HARD_RESET_SERVER=
_V2, so a client
+         * can start the handshake from it (the connect_l=
ifetime advertisement)=2E */
+        struct session_id sid =3D
+          =
  calculate_session_id_hmac(state->peer_session_id, from, hmac_key, handwin=
dow, 0);
+
+        send_probe_reply(m, state, tas, &reply, &sid, sock);
+
=
+        /* An OOB probe never creates a session */
+        return false;
=
+    }
 
     /* VERDICT_INVALID */
     return false;
diff --git a/src/ope=
nvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 930b213=2E=2Ec841d59 100644
--- a/=
src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -106,6 +106,12 @@
 }
 
 bo=
ol
+oob_client_reply_write(struct buffer *buf, const struct oob_probe_reply=
 *reply)
+{
+    return buf_write_u16(buf, OOB_MSG_PROBE_REPLY) && oob_prob=
e_reply_write(buf, reply);
+}
+
+bool
 oob_timestamp_in_window(uint64_t pro=
be_ts, uint64_t now, uint64_t window_secs)
 {
     uint64_t diff =3D (now >=
 probe_ts) ? (now - probe_ts) : (probe_ts - now);
diff --git a/src/openvpn/=
oob=2Eh b/src/openvpn/oob=2Eh
index 1afabbd=2E=2E49d64e8 100644
--- a/src/o=
penvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -126,6 +126,12 @@
 bool oob_ser=
ver_probe_read(struct buffer *payload, struct oob_probe_parameter *param);
=
 
 /**
+ * Write a complete PROBE_REPLY message (message-type header + prob=
e_reply TLV)
+ * to buf=2E Sent by the server=2E
+ */
+bool oob_client_repl=
y_write(struct buffer *buf, const struct oob_probe_reply *reply);
+
+/**
  =
* Check whether a probe timestamp is within an acceptable window around the=

  * current time=2E Used to cheaply drop replayed or implausibly-timed pro=
bes
  * before doing any further work (see the probe_parameter timestamp ra=
tionale
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
inde=
x 39cb648=2E=2E78552c4 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openv=
pn/ssl_pkt=2Ec
@@ -314,7 +314,8 @@
 
     /* Allow only the reset packet or=
 the first packet of the actual handshake=2E */
     if (op !=3D P_CONTROL_=
HARD_RESET_CLIENT_V2 && op !=3D P_CONTROL_HARD_RESET_CLIENT_V3
-        && =
op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1)
+    =
    && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1=

+        && !opcode_is_oob(op))
     {
         /*
          * This can oc=
cur due to bogus data or DoS packets=2E
@@ -389,6 +390,10 @@
     {
       =
  return VERDICT_VALID_WKC_V1;
     }
+    else if (opcode_is_oob(op))
+   =
 {
+        return VERDICT_VALID_OOB_V1;
+    }
     else
     {
         r=
eturn VERDICT_VALID_RESET_V2;
@@ -443,6 +448,29 @@
     return buf;
 }
 
+s=
truct buffer
+tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_=
auth_standalone *tas,
+                        struct session_id *own_sid, =
const struct buffer *payload)
+{
+    /* Copy buffer here to point at the s=
ame data but allow tls_wrap_control
+     * to potentially change buf to po=
int to another buffer without
+     * modifying the buffer in tas */
+    s=
truct buffer buf =3D tas->workbuf;
+    ASSERT(buf_init(&buf, tas->frame=2E=
buf=2Eheadroom));
+
+    /* Out-of-band messages carry the payload directly=
, with no reliability
+     * or ACK fields=2E */
+    ASSERT(buf_copy(&buf=
, payload));
+
+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCO=
DE_SHIFT);
+
+    /* Add tls-auth/tls-crypt wrapping, this might replace bu=
f with
+     * ctx->work */
+    tls_wrap_control(ctx, header, &buf, own_si=
d);
+
+    return buf;
+}
+
 struct session_id
 calculate_session_id_hmac(s=
truct session_id client_sid, const struct openvpn_sockaddr *from,
         =
                  const uint8_t *key, int handwindow, int offset)
diff --gi=
t a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index d46b8c5=2E=2E58=
1ec48 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@=
 -62,8 +62,9 @@
  * control channel session (e=2Eg=2E a server probe)=2E In=
herently unreliable:
  * there is no protocol-level retransmission=2E
  *
-=
 * It is not legal on an established session; see opcode_valid_in_session()=

- * below=2E */
+ * On the server this is accepted via the tls_pre_decrypt=
_lite() allowlist and
+ * handled in the new-connection path (it never crea=
tes a session)=2E It is not
+ * legal on an established session; see opcode=
_valid_in_session() below=2E */
 #define P_CONTROL_OOB_V1 12
 
 /* define t=
he range of defined opcodes, in- and out-of-band=2E Note this is not
@@ -13=
6,6 +137,9 @@
     VERDICT_VALID_ACK_V1,
     /** The packet is a valid con=
trol packet with appended wrapped client key */
     VERDICT_VALID_WKC_V1,
=
+    /** This packet is a valid out-of-band control message (e=2Eg=2E a ser=
ver
+     * probe)=2E It does not belong to a session and must not create o=
ne=2E */
+    VERDICT_VALID_OOB_V1,
     /** the packet failed on of the va=
rious checks */
     VERDICT_INVALID
 };
@@ -256,6 +260,21 @@
             =
                       struct session_id *own_sid, struct session_id *remot=
e_sid,
                                    uint8_t header, bool request_res=
end_wkc);
 
+/**
+ * Wrap an already-built out-of-band payload (e=2Eg=2E pr=
obe-reply TLVs) into a
+ * standalone, session-less P_CONTROL_OOB_V1 packet=
: it prepends the opcode and
+ * own_sid and applies the same tls-auth/tls-=
crypt wrapping as a regular
+ * control packet, but carries no reliability/=
ACK fields=2E
+ *
+ * @param ctx       tls wrapping context (from the pre-d=
ecrypt state)
+ * @param tas       standalone auth context providing the wo=
rk buffer
+ * @param own_sid   session id to use as our session id in the h=
eader
+ * @param payload   the OOB message payload (TLV stream) to wrap
+ *=
 @return          the wrapped packet buffer, ready to send
+ */
+struct buf=
fer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_stand=
alone *tas,
+                                      struct session_id *own_s=
id, const struct buffer *payload);
+
 
 /**
  * Extracts a control channel =
message from buf and adjusts the size of

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-C=
hange-Number: 1744
Gerrit-PatchSet: 12
Gerrit-Owner: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--7TdtJq1cVQM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>stipa <strong>uplo=
aded patch set #12</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">oob: Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)<br><br>Make=
 a --mode server UDP listener answer an out-of-band SERVER_PROBE without<br=
>creating a session, so probing costs the server no state:<br><br>  - tls_p=
re_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns the new<br>    VERDI=
CT_VALID_OOB_V1 verdict=2E<br>  - tls_wrap_oob_standalone() builds a sessio=
n-less P_CONTROL_OOB_V1 packet:<br>    opcode + session id + the usual tls-=
auth/tls-crypt wrapping around a bare<br>    TLV payload (no reliability/AC=
K fields), mirroring tls_reset_standalone()=2E<br>  - oob_client_reply_writ=
e() writes the PROBE_REPLY message (message-type<br>    header + probe_repl=
y TLV)=2E<br>  - do_pre_decrypt_check() handles the new verdict: it asks<br=
>    oob_build_probe_reply() whether to answer, and if so sends a PROBE_REP=
LY<br>    via send_probe_reply() (synchronous, stateless, like the HMAC res=
et path)<br>    and returns false so no session is created=2E The verdict j=
oins the reset<br>    verdicts in the reflect_filter rate-limit check, so a=
 probe flood is capped<br>    like a reset flood=2E<br><br>The reply carrie=
s, as its own session id, the stateless SYN-cookie the three-way<br>handsha=
ke uses, so the server keeps nothing per probe and a client can later<br>re=
use the reply as the server&#39;s reset=2E<br><br>Change-Id: I930d3789e0313=
aa0c3bc51ee5fd1d108343d59f0<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/oob=2Ec<br>M s=
rc/openvpn/oob=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2E=
h<br>5 files changed, 118 insertions(+), 4 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44=
/1744/12</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</=
span><br><span>index de3d467=2E=2E01d7441 100644</span><br><span>--- a/src/=
openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span=
>@@ -32,6 +32,7 @@</span><br><span> </span><br><span> #include &quot;memdbg=
=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span=
><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #i=
nclude &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -87,6 +88,34 @@</span><br=
><span>                           &quot;Reset packet from client, sending H=
MAC based reset challenge&quot;, sock);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Send an out-of-=
band PROBE_REPLY back to the source of a SERVER_PROBE,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * synchronously and without keeping any=
 state, mirroring the reset path=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+send_probe_reply(struct multi_context *m, struct tls_pre_decrypt=
_state *state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
            struct tls_auth_standalone *tas, const struct oob_probe_reply *=
reply,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
    struct session_id *own_sid, struct link_socket *sock)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Build the payload of the reply (message-type heade=
r + probe_reply TLV) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer payload =3D alloc_buf_gc(128, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_client_reply_write(&=
amp;payload, reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* OOB replies use the same control-chan=
nel wrapping as the request */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epac=
ket_id=2Esend);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D tls_wrap_oob_st=
andalone(&amp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    send_standalone_reply(m,=
 &amp;buf, &quot;Server Probe&quot;, &quot;Server probe from client, sendin=
g probe reply&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          sock);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </s=
pan><br><span> /* Returns true if this packet should create a new session *=
/</span><br><span> static bool</span><br><span>@@ -105,7 +134,8 @@</span><b=
r><span>     const struct openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2E=
from=2Edest;</span><br><span>     int handwindow =3D m-&gt;top=2Eoptions=2E=
handshake_window;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=
=3D VERDICT_VALID_RESET_V2)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VER=
DICT_VALID_RESET_V2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        || verdict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span>     {</spa=
n><br><span>         /* Check if we are still below our limit for sending o=
ut</span><br><span>          * responses */</span><br><span>@@ -203,6 +233,=
31 @@</span><br><span> </span><br><span>         return ret;</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if=
 (verdict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* Out-of-band server probe=2E state-&gt;newbuf points at the =
TLV payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * (read_control_auth has stripped the opcode, session id and any</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * tls-auth/tls-crypt=
 wrapping)=2E Answer it without creating a session=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_reply reply;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_bui=
ld_probe_reply(&amp;state-&gt;newbuf, (uint64_t)now, (uint64_t)handwindow,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
               &amp;state-&gt;peer_session_id, &amp;reply))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* malformed or replayed/stale pr=
obe: silently drop */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Our sessio=
n id is a stateless SYN cookie (the same HMAC the three-way</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * handshake uses): we keep=
 no per-probe state, and the reply can later</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * also serve as the server&#39;s CONTROL_=
HARD_RESET_SERVER_V2, so a client</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * can start the handshake from it (the connect_lifet=
ime advertisement)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        struct session_id sid =3D</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            calculate_session_id_hmac(state-&gt;peer_ses=
sion_id, from, hmac_key, handwindow, 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        send_probe_reply(m, state, tas, &amp;reply, &amp;sid, sock);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* An OOB probe never creates a s=
ession */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> </span><br><span>     /* VERDICT_INVALID */</span><br><span>=
     return false;</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/o=
penvpn/oob=2Ec</span><br><span>index 930b213=2E=2Ec841d59 100644</span><br>=
<span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</=
span><br><span>@@ -106,6 +106,12 @@</span><br><span> }</span><br><span> </s=
pan><br><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_client_reply_write(struct buffer *buf, const struct oob_probe_reply *re=
ply)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, OOB=
_MSG_PROBE_REPLY) &amp;&amp; oob_probe_reply_write(buf, reply);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span> oob_timestamp_in_window(uint64_t probe_ts, uin=
t64_t now, uint64_t window_secs)</span><br><span> {</span><br><span>     ui=
nt64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now);<=
/span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</spa=
n><br><span>index 1afabbd=2E=2E49d64e8 100644</span><br><span>--- a/src/ope=
nvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -=
126,6 +126,12 @@</span><br><span> bool oob_server_probe_read(struct buffer =
*payload, struct oob_probe_parameter *param);</span><br><span> </span><br><=
span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a=
 complete PROBE_REPLY message (message-type header + probe_reply TLV)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to buf=2E Sent by the =
server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_client_reply_writ=
e(struct buffer *buf, const struct oob_probe_reply *reply);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span>  * Check whether a probe timestam=
p is within an acceptable window around the</span><br><span>  * current tim=
e=2E Used to cheaply drop replayed or implausibly-timed probes</span><br><s=
pan>  * before doing any further work (see the probe_parameter timestamp ra=
tionale</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/=
ssl_pkt=2Ec</span><br><span>index 39cb648=2E=2E78552c4 100644</span><br><sp=
an>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=
=2Ec</span><br><span>@@ -314,7 +314,8 @@</span><br><span> </span><br><span>=
     /* Allow only the reset packet or the first packet of the actual hands=
hake=2E */</span><br><span>     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 =
&amp;&amp; op !=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        &amp;&amp; op !=3D P_CONTROL_V1 &amp;&a=
mp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; op !=3D P_CONTROL_=
V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !opcode_i=
s_oob(op))</span><br><span>     {</span><br><span>         /*</span><br><sp=
an>          * This can occur due to bogus data or DoS packets=2E</span><br=
><span>@@ -389,6 +390,10 @@</span><br><span>     {</span><br><span>        =
 return VERDICT_VALID_WKC_V1;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (opcode_is_oob(op))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return VERDICT_VALID_OOB_V1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>  =
   else</span><br><span>     {</span><br><span>         return VERDICT_VALI=
D_RESET_V2;</span><br><span>@@ -443,6 +448,29 @@</span><br><span>     retur=
n buf;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct =
tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        struct session_id *own_sid, const struct buff=
er *payload)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer here t=
o point at the same data but allow tls_wrap_control</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * to potentially change buf to point=
 to another buffer without</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * modifying the buffer in tas */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer buf =3D tas-&gt;workbuf;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;bu=
f, tas-&gt;frame=2Ebuf=2Eheadroom));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Out-of-band messages carry the payload directly, with no reliability</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * or ACK fields=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(bu=
f_copy(&amp;buf, payload));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t=
 header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Add tls-auth/tls-crypt wrapping, this migh=
t replace buf with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * ctx-&gt;work */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tls_wrap_control(ctx, header, &amp;buf, own_sid);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return buf;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> struct session_id</span><br><span> calculate_session_id_hmac(s=
truct session_id client_sid, const struct openvpn_sockaddr *from,</span><br=
><span>                           const uint8_t *key, int handwindow, int o=
ffset)</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/s=
sl_pkt=2Eh</span><br><span>index d46b8c5=2E=2E581ec48 100644</span><br><spa=
n>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=
=2Eh</span><br><span>@@ -62,8 +62,9 @@</span><br><span>  * control channel =
session (e=2Eg=2E a server probe)=2E Inherently unreliable:</span><br><span=
>  * there is no protocol-level retransmission=2E</span><br><span>  *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * It is not legal on an es=
tablished session; see opcode_valid_in_session()</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * below=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * On the server this is accepted via the tls_pre_dec=
rypt_lite() allowlist and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * handled in the new-connection path (it never creates a session)=2E=
 It is not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * legal =
on an established session; see opcode_valid_in_session() below=2E */</span>=
<br><span> #define P_CONTROL_OOB_V1 12</span><br><span> </span><br><span> /=
* define the range of defined opcodes, in- and out-of-band=2E Note this is =
not</span><br><span>@@ -136,6 +137,9 @@</span><br><span>     VERDICT_VALID_=
ACK_V1,</span><br><span>     /** The packet is a valid control packet with =
appended wrapped client key */</span><br><span>     VERDICT_VALID_WKC_V1,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** This packet i=
s a valid out-of-band control message (e=2Eg=2E a server</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * probe)=2E It does not belong to=
 a session and must not create one=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    VERDICT_VALID_OOB_V1,</span><br><span>     /** the=
 packet failed on of the various checks */</span><br><span>     VERDICT_INV=
ALID</span><br><span> };</span><br><span>@@ -256,6 +260,21 @@</span><br><sp=
an>                                    struct session_id *own_sid, struct s=
ession_id *remote_sid,</span><br><span>                                    =
uint8_t header, bool request_resend_wkc);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Wrap an already-built out-of-band payload (e=2Eg=
=2E probe-reply TLVs) into a</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * standalone, session-less P_CONTROL_OOB_V1 packet: it prepends t=
he opcode and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * own=
_sid and applies the same tls-auth/tls-crypt wrapping as a regular</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * control packet, but carri=
es no reliability/ACK fields=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram ctx       tls wrapping context (from the pre-decrypt state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param tas       standalone=
 auth context providing the work buffer</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param own_sid   session id to use as our session id=
 in the header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram payload   the OOB message payload (TLV stream) to wrap</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return          the wrapped pac=
ket buffer, ready to send</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buf=
fer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_stand=
alone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                              struct session_id *own_sid, const struct buff=
er *payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> </span><br><span> /**</span><br><span>  * Extracts a control ch=
annel message from buf and adjusts the size of</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1744?usp=3Demail">change 1744</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1744?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1744 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none">=
 Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>

</body></html>
--7TdtJq1cVQM=--


--===============0368379735656289217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0368379735656289217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0368379735656289217==--

