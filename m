Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391A1CA5FCA
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqtcurLV8SgmTjzbuKekg69KYqL/oNWorU1uhhsLgno=; b=WdXDWVHnj6Tk7QrQDK9XvLsj+K
	JOJiUGtnpASYnEQnJkBt4mafNAUKjJPVzSIVlE75HHS+aH7KgZRvHvkPir1Hrt1im7KgUNZFky2LO
	Iea1MK7d3ff6T9rgNuR4gl+w+dtGQNI4roCZLFOb/J+hd0KBXZS9b3Pk2t3AxFD7HMVo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeE-0003Zy-1V;
	Wed, 30 Sep 2026 08:26:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdy-0003YM-UD
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=98i7r8KtoyCT+QVDkv6wW+9T2ovfopmvSQJDi4PUFn0=; b=YYXf/Jt2duQDgMq/F3S8ochDmT
 7MQVSPsYlgNMlVVLCtfWSzgpb3mHe6ZvTcujzofW770rZjJaK0KVB2Y/NLeVAghM8FKEvOAXBlN0r
 bWK+ODtz/vRwIDiZf2ws5VXNpmUO5yPLrVNv+K2Cxs8bwir+nxP6jf0BFb8ggFzH1lVo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=98i7r8KtoyCT+QVDkv6wW+9T2ovfopmvSQJDi4PUFn0=; b=n
 UZDTDmL96oLh5YSgnvQl73ELqWDML5XT/r9dystYxhmvTlpK3Mq6j1ID4urtWbMEQkK1E+Tarzx6x
 emYBXi93CQ7Lrx7x9kTNvEOeQbhDwPNp14tl/HyUJrD5mcIdpJQ2aojhArMa7RRpeDE1WvB2KPril
 bBmg7BKFEx0y3GH8=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdQ-0005nL-D6 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:25:57 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso37382615e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756746; x=1791361546; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=98i7r8KtoyCT+QVDkv6wW+9T2ovfopmvSQJDi4PUFn0=;
 b=PAv07gkYxuZA9rHlZmzByc3isuShXSKW0Nhbu27nmg9eyN76m75k/XYLcbpg9HaHp6
 fxeRwRHfe+Sm2AQGtwDIJVdnTrYHcAih713u+8CuWZrZs2jzlRwU9Ttabi8U2HajyE0k
 i+ZzhF2/1nVyTGp/eOjgNEZu4bf0qbYhqhKyoaldYhrClBaXBgKhTz5Rr73HX6LWkQ+1
 MXzzNWFBWHj+RA5mkVGXItG2cki7maRS+FjUBaZs0vl4Kt8DvNoL/ifYupMbMNFFxqIG
 SR4uFCgki1GUTW80zUdLzbtAjJCY8sFRvJOCcTBIdwJBWSOyql/+MCqjTwJzj4dlN5o4
 nLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756746; x=1791361546;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=98i7r8KtoyCT+QVDkv6wW+9T2ovfopmvSQJDi4PUFn0=;
 b=dnqF+4hjMz/1lDnUS+Lj78G9DtdZBC0wXD0Q3WhPi5gzkC8E0TUj9Fl9LS7magqyj5
 AknRi1O8S6V8t6GJyzBs241me6GiCiY3TgW2q49xg2qXHW0khieZNoH02dY39qVoO+kE
 AmvwV3jh9LvmZvu+7CqbDxd4fqalTW4JuUerkWpiiSD90nlLBsdzVvDTp+X/QnWzM0PH
 o6t4N+W8SVGr3YmRDYrGdGvrCytZM1kHFgaxJ8LZeppZAVeQeAW3R9haAnOqEbOs1hZO
 nLp8+ICaOvqCleRdEqxonAqgf0D81bbSb/96W2qMbc0cT4ZsVYFvAB1zMCwFQjav2C+a
 Gevg==
X-Gm-Message-State: AFuF++ktA49bO6UiUDN/itIZIyZgcNGiyKyp1tx5UnGRUFD4oz1QPGSw
 0BAOGD8DB8MbZhj7YWXVIOJ5QDNzprSdPErNFMjH7qwG4r0IyP7n6nAE0CP32Nvsfk+mFdD1MQS
 LprrZ3A7AUlzBxQpLp5JPOq42r/1Zuif+vSmesrLEvI2A+HiJ4KabXCtqoy2na1Z5ddG6
X-Gm-Gg: AYBFou0ZsDgMZV8No1jatWhDqMflneUuErwpxQ+OSNn9IZMQCkYlRnqYM/PHG4AdVQe
 CY9nUsNKxfzUr80p/+hf+7MUGGxn3RvUylS7r6NzIxZR57W8lPadZ37zugUhYRkT4RE+EjlQ1yX
 LiDb2zr1EpfN0YpExe77SstVYJS+9Ic5E4tP8rrkSUzE0+AGjhSe8I8C6101f5nj7YXT3PBFbD7
 a8JIlWkoH0qeifqPmOBDxMSYb3Edhv98uzkloKU323dKJXtqaOb43ob/dQpv5qQwmCRYPxiD1cF
 LxpRWsQ4z5fxRPRLg3jbkuR3Mz0vE8wDXEFy1mBnSgYQ+6hcbN/AG8aHEVtWltBV2sSXuNSjiLS
 eWBd7LCJRznwY8w5PgYiKc7ubUvUXNCWAPWCrNq24OaxXa5mZSgFkFSlltr9qcJsf2V8NX6/5QA
 4Jllc8e0JwUhMuCHF1bWgPb+hazBPbg0yXCiMBYf3XqPSuB3ds6o8VHeu/jOF6hGqtloQ7fzX7m
 JaFz/9HNsclkckj7DY6G0fFU97pUSHpeUtqB/6qkK6A7WwuJZxgt/pWV9GIKwlBpdYxjctXRlQh
 KXUPTWErgHs9w6iQcppUDCvu+5QSEWSLgTwYv7sdBcm1zyJI0iLsM1RNmHmB
X-Received: by 2002:a05:600c:46c8:b0:4a0:f0a:976a with SMTP id
 5b1f17b1804b1-4a01ade9bd2mr9194365e9.13.1790756745267; 
 Wed, 30 Sep 2026 01:25:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01b1e79e4sm14961365e9.2.2026.09.30.01.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:25:44 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 0160c1f0066118d78f9fcc46420134293de271b1
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d4531e612b1450060ed6b04b3b78ed6edfa42eb6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdQ-0005nL-D6
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Answer probe
 requests on the server (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6208571382961941042=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6208571382961941042==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kfP5R7PjzfQ="; charset=UTF-8

--kfP5R7PjzfQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello plaisthos, ralf_lici, 

I'd like you to reexamine a change=
=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3D=
email

to look at the new patch set (#20)=2E


Change subject: oob: Answer =
probe requests on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Answer probe requests on the server=
 (P_CONTROL_OOB_V1)

Make a --mode server UDP listener answer an out-of-ban=
d probe request
without creating a session, so probing costs the server no =
state=2E

tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns the n=
ew
VERDICT_VALID_OOB_V1, and tls_wrap_oob_standalone() wraps a bare OOB
mes=
sage with the usual tls-auth/tls-crypt wrapping but no reliability
fields, =
mirroring tls_reset_standalone()=2E do_pre_decrypt_check()
classifies the p=
robe with oob_probe_request_check() and answers with a
probe reply that ech=
oes the probe's request_id=2E

A reply is charged against the same rate lim=
it as the reset replies,
once one is going to be sent, so a probe flood is =
capped like a reset
flood=2E A stale probe, one whose timestamp is outside =
--hand-window, is
still answered, but only within a separate budget of a tw=
entieth of
--connect-freq-initial per period (at least one): a client with =
a
skewed clock can still probe, and a replayed probe gets no more than
that=
 budget=2E The budget's limiter is quiet, as a replayed probe
hitting it is=
 not worth a warning=2E

The reply carries, as its own session id, the stat=
eless SYN cookie the
three-way handshake uses, so the server keeps nothing =
per probe and a
client can later start the handshake from the reply=2E

Cha=
nge-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Signed-off-by: Lev Stipak=
ov <lev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M=
 src/openvpn/multi=2Eh
M src/openvpn/reflect_filter=2Ec
M src/openvpn/refle=
ct_filter=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn=
/ssl_pkt=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
9 files changed, 249 i=
nsertions(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/44/1744/20

diff --git a/src/openvpn/mudp=2Ec b/src/=
openvpn/mudp=2Ec
index de3d467=2E=2Ee97ac39 100644
--- a/src/openvpn/mudp=
=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
=
 #include "ssl_pkt=2Eh"
+#include "oob=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #=
include <sys/inotify=2Eh>
@@ -87,6 +88,34 @@
                           "Re=
set packet from client, sending HMAC based reset challenge", sock);
 }
 
+/=
* Send an out-of-band probe reply back to the source of a probe request,
+ =
* synchronously and without keeping any state, mirroring the reset path=2E =
*/
+static void
+send_probe_reply(struct multi_context *m, struct tls_pre_d=
ecrypt_state *state,
+                 struct tls_auth_standalone *tas, con=
st struct oob_probe_reply *reply,
+                 struct session_id *own_=
sid, struct link_socket *sock)
+{
+    struct gc_arena gc =3D gc_new();
+
+=
    /* The reply carries just the probe reply TLV */
+    struct buffer pay=
load =3D alloc_buf_gc(128, &gc);
+    if (!oob_probe_reply_write(&payload, =
reply))
+    {
+        gc_free(&gc);
+        return;
+    }
+
+    /* OOB=
 replies use the same control-channel wrapping as the request */
+    reset=
_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
+    state-=
>tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;
+
+    struct=
 buffer buf =3D tls_wrap_oob_standalone(&state->tls_wrap_tmp, tas, own_sid,=
 &payload);
+    send_standalone_reply(m, &buf, "Server Probe", "Server pro=
be from client, sending probe reply",
+                          sock);
+
+=
    gc_free(&gc);
+}
+
 
 /* Returns true if this packet should create a ne=
w session */
 static bool
@@ -203,6 +232,47 @@
 
         return ret;
     =
}
+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1)
+    {
+        /* Out=
-of-band server probe=2E state->newbuf points at the OOB message
+         =
* (read_control_auth has stripped the opcode, session id and any
+         =
* tls-auth/tls-crypt wrapping)=2E Answer it without creating a session=2E *=
/
+        struct oob_probe_request req;
+        enum oob_probe_verdict pr=
obe =3D
+            oob_probe_request_check(&state->newbuf, (uint64_t)now,=
 (uint64_t)handwindow, &req);
+        if (probe =3D=3D OOB_PROBE_INVALID)
=
+        {
+            return false; /* malformed: silently drop */
+     =
   }
+        /* A client whose clock is off by more than --hand-window sti=
ll gets a
+         * few probes per period answered, which is also all a r=
eplayed probe
+         * can get=2E */
+        if (probe =3D=3D OOB_PROBE=
_STALE && !reflect_filter_rate_limit_check(m->stale_probe_limiter))
+      =
  {
+            return false;
+        }
+        /* The reply counts agai=
nst the same limit as the reset replies, charged
+         * only now that =
we know one is going to be sent=2E */
+        if (!reflect_filter_rate_lim=
it_check(m->initial_rate_limiter))
+        {
+            return false;
+ =
       }
+
+        /* the reply echoes the probe's request_id */
+        =
struct oob_probe_reply reply =3D { =2Erequest_id =3D req=2Erequest_id };
+
=
+        /* Our session id is a stateless SYN cookie (the same HMAC the thr=
ee-way
+         * handshake uses): we keep no per-probe state, and the rep=
ly can later
+         * also serve as the server's CONTROL_HARD_RESET_SERV=
ER_V2, so a client
+         * can start the handshake from it=2E */
+     =
   struct session_id sid =3D
+            calculate_session_id_hmac(state->=
peer_session_id, from, hmac_key, handwindow, 0);
+
+        send_probe_repl=
y(m, state, tas, &reply, &sid, sock);
+
+        /* An OOB probe never crea=
tes a session */
+        return false;
+    }
 
     /* VERDICT_INVALID */=

     return false;
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index 3e72b92=2E=2Ea438a34 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -326,6 +326,12 @@
     m->new_connection_limiter =3D=
 frequency_limit_init(t->options=2Ecf_max, t->options=2Ecf_per);
     m->in=
itial_rate_limiter =3D
         initial_rate_limit_init(t->options=2Ecf_ini=
tial_max, t->options=2Ecf_initial_per);
+    /* stale server probes: a twen=
tieth of the initial-packet rate, at least 1
+     * per period (5 per 10 s=
 by default, the wire protocol's own example)=2E
+     * Quiet, as a replay=
ed probe hitting the limit is not worth a warning=2E */
+    m->stale_probe=
_limiter =3D
+        initial_rate_limit_init(max_int(1, t->options=2Ecf_in=
itial_max / 20), t->options=2Ecf_initial_per);
+    m->stale_probe_limiter-=
>quiet =3D true;
 
     /*
      * Allocate broadcast/multicast buffer list=

@@ -689,6 +695,7 @@
         ifconfig_pool_free(m->ifconfig_pool);
       =
  frequency_limit_free(m->new_connection_limiter);
         initial_rate_li=
mit_free(m->initial_rate_limiter);
+        initial_rate_limit_free(m->stal=
e_probe_limiter);
         multi_reap_free(m->reaper);
         mroute_help=
er_free(m->route_helper);
         multi_io_free(m->multi_io);
diff --git a=
/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 6cb86c7=2E=2E615290d 1=
00644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -178,6 +17=
8,7 @@
     struct ifconfig_pool *ifconfig_pool;
     struct frequency_limi=
t *new_connection_limiter;
     struct initial_packet_rate_limit *initial_r=
ate_limiter;
+    struct initial_packet_rate_limit *stale_probe_limiter; /*=
*< stale probe request answers */
     struct mroute_helper *route_helper;
=
     struct multi_reap *reaper;
     struct mroute_addr local;
diff --git a=
/src/openvpn/reflect_filter=2Ec b/src/openvpn/reflect_filter=2Ec
index e522=
6e4=2E=2E4887f01 100644
--- a/src/openvpn/reflect_filter=2Ec
+++ b/src/open=
vpn/reflect_filter=2Ec
@@ -44,7 +44,7 @@
     if (now > irl->last_period_re=
set + irl->period_length)
     {
         int64_t dropped =3D irl->curr_per=
iod_counter - irl->max_per_period;
-        if (dropped > 0)
+        if (d=
ropped > 0 && !irl->quiet)
         {
             msg(D_TLS_DEBUG_LOW,
   =
              "Dropped %" PRId64 " initial handshake packets"
@@ -60,7 +60,=
7 @@
 
     bool over_limit =3D irl->curr_period_counter > irl->max_per_per=
iod;
 
-    if (over_limit && !irl->warning_displayed)
+    if (over_limit =
&& !irl->warning_displayed && !irl->quiet)
     {
         msg(M_WARN,
    =
         "Note: --connect-freq-initial %" PRId64 " %d rate limit "
@@ -89,7=
 +89,7 @@
     struct initial_packet_rate_limit *irl;
 
 
-    ALLOC_OBJ(ir=
l, struct initial_packet_rate_limit);
+    ALLOC_OBJ_CLEAR(irl, struct init=
ial_packet_rate_limit);
 
     irl->max_per_period =3D max_per_period;
    =
 irl->period_length =3D period_length;
diff --git a/src/openvpn/reflect_fil=
ter=2Eh b/src/openvpn/reflect_filter=2Eh
index 84915e8c6=2E=2Ee996d07 10064=
4
--- a/src/openvpn/reflect_filter=2Eh
+++ b/src/openvpn/reflect_filter=2Eh=

@@ -44,6 +44,9 @@
     /* we want to warn once per period that packets are=
 being started to
      * be dropped */
     bool warning_displayed;
+
+   =
 /* drop silently: no per-period warning or summary in the log */
+    bool=
 quiet;
 };
 
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
inde=
x 8e2a459=2E=2Ee8a3d20 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/s=
sl=2Ec
@@ -3702,7 +3702,8 @@
     struct session_id sid; /* remote session =
ID */
 
     /* verify legal opcode=2E An out-of-band packet has no control=
 message id and
-     * no ACK array, which is what we parse next=2E */
+  =
   * no ACK array, which is what we parse next; do_pre_decrypt_check() answ=
ers
+     * those=2E */
     if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE =
|| opcode_is_oob(op))
     {
         if (op =3D=3D P_CONTROL_HARD_RESET_CL=
IENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
diff --git a/src/openv=
pn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 38fb8ed=2E=2Ed3463b8 100644
=
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -169,7 +169,=
8 @@
 {
     ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
  =
   ASSERT(opcode >=3D 0 && opcode <=3D P_LAST_OPCODE);
-    /* OOB packets =
carry no message id or ACK array */
+    /* OOB packets carry no message id=
 or ACK array; tls_wrap_oob_standalone()
+     * builds them */
     ASSERT=
(!opcode_is_oob(opcode));
     uint8_t header =3D (uint8_t)(ks->key_id | (o=
pcode << P_OPCODE_SHIFT));
 
@@ -317,7 +318,8 @@
 
     /* Allow only the r=
eset packet or the first packet of the actual handshake=2E */
     if (op !=
=3D P_CONTROL_HARD_RESET_CLIENT_V2 && op !=3D P_CONTROL_HARD_RESET_CLIENT_V=
3
-        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P=
_ACK_V1)
+        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op=
 !=3D P_ACK_V1
+        && !opcode_is_oob(op))
     {
         /*
         =
 * This can occur due to bogus data or DoS packets=2E
@@ -392,6 +394,10 @@
=
     {
         return VERDICT_VALID_WKC_V1;
     }
+    else if (opcode_is=
_oob(op))
+    {
+        return VERDICT_VALID_OOB_V1;
+    }
     else
   =
  {
         return VERDICT_VALID_RESET_V2;
@@ -445,6 +451,29 @@
     retur=
n buf;
 }
 
+struct buffer
+tls_wrap_oob_standalone(struct tls_wrap_ctx *ct=
x, struct tls_auth_standalone *tas,
+                        struct session=
_id *own_sid, const struct buffer *payload)
+{
+    /* Copy buffer here to =
point at the same data but allow tls_wrap_control
+     * to potentially ch=
ange buf to point to another buffer without
+     * modifying the buffer in=
 tas */
+    struct buffer buf =3D tas->workbuf;
+    ASSERT(buf_init(&buf,=
 tas->frame=2Ebuf=2Eheadroom));
+
+    /* Out-of-band messages carry the pa=
yload directly, with no reliability
+     * or ACK fields=2E */
+    ASSERT=
(buf_copy(&buf, payload));
+
+    uint8_t header =3D (uint8_t)(P_CONTROL_OO=
B_V1 << P_OPCODE_SHIFT);
+
+    /* Add tls-auth/tls-crypt wrapping, this mi=
ght replace buf with
+     * ctx->work */
+    tls_wrap_control(ctx, header=
, &buf, own_sid);
+
+    return buf;
+}
+
 struct session_id
 calculate_ses=
sion_id_hmac(struct session_id client_sid, const struct openvpn_sockaddr *f=
rom,
                           const uint8_t *key, int handwindow, int off=
set)
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index d=
477d5a=2E=2E5060a4a 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/=
ssl_pkt=2Eh
@@ -59,8 +59,9 @@
 #define P_CONTROL_WKC_V1 11
 
 /* Out-of-ban=
d control message, e=2Eg=2E a server probe=2E Not part of the reliable
- * =
control channel: no control message id and no ACK array, just TLVs
- * afte=
r the session id; never handled by tls_pre_decrypt()=2E */
+ * control chan=
nel: no control message id and no ACK array, just TLVs after
+ * the sessio=
n id=2E Answered statelessly in do_pre_decrypt_check(), never
+ * handled b=
y tls_pre_decrypt()=2E */
 #define P_CONTROL_OOB_V1 12
 
 /* define the ran=
ge of defined opcodes, in- and out-of-band
@@ -106,6 +107,9 @@
     VERDICT=
_VALID_ACK_V1,
     /** The packet is a valid control packet with appended =
wrapped client key */
     VERDICT_VALID_WKC_V1,
+    /** This packet is a =
valid out-of-band control message (e=2Eg=2E a server
+     * probe)=2E It d=
oes not belong to a session and must not create one=2E */
+    VERDICT_VALI=
D_OOB_V1,
     /** the packet failed on of the various checks */
     VERDI=
CT_INVALID
 };
@@ -226,6 +230,21 @@
                                    str=
uct session_id *own_sid, struct session_id *remote_sid,
                   =
                 uint8_t header, bool request_resend_wkc);
 
+/**
+ * Wrap =
an already-built out-of-band message (e=2Eg=2E a probe reply) into a
+ * st=
andalone, session-less P_CONTROL_OOB_V1 packet: it prepends the opcode and
=
+ * own_sid and applies the same tls-auth/tls-crypt wrapping as a regular
+=
 * control packet, but carries no reliability/ACK fields=2E
+ *
+ * @param =
ctx       tls wrapping context (from the pre-decrypt state)
+ * @param tas =
      standalone auth context providing the work buffer
+ * @param own_sid =
  session id to use as our session id in the header
+ * @param payload   th=
e OOB message (header and TLVs) to wrap
+ * @return          the wrapped pa=
cket buffer, ready to send
+ */
+struct buffer tls_wrap_oob_standalone(stru=
ct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
+                   =
                   struct session_id *own_sid, const struct buffer *payload=
);
+
 
 /**
  * Extracts a control channel message from buf and adjusts the=
 size of
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_te=
sts/openvpn/test_pkt=2Ec
index 0398a1f=2E=2E887526b 100644
--- a/tests/unit=
_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ =
-739,6 +739,114 @@
     free_tas(&tas_server);
 }
 
+/* Payload every OOB r=
ound-trip below wraps: one TLV (type 1, 4 bytes of
+ * value)=2E */
+static=
 const uint8_t oob_payload[] =3D { 0x00, 0x01, 0x00, 0x04, 0xde, 0xad, 0xbe=
, 0xef };
+
+/* Wrap oob_payload as a standalone P_CONTROL_OOB_V1 with the =
client side of a
+ * tls-auth/tls-crypt pair (or none), run it through the =
server's stateless
+ * first-packet path, and check verdict, recovered sess=
ion id and payload=2E */
+static void
+oob_standalone_roundtrip(struct tls_=
auth_standalone *tas_client,
+                         struct tls_auth_stan=
dalone *tas_server)
+{
+    struct link_socket_actual from =3D { 0 };
+    =
struct tls_pre_decrypt_state state =3D { 0 };
+    struct session_id sid =
=3D { { 0x0b, 1, 2, 3, 4, 5, 6, 0x0b } };
+
+    struct buffer payload =3D =
alloc_buf(64);
+    buf_write(&payload, oob_payload, sizeof(oob_payload));
=
+
+    /* Client side: opcode + session id + tls-auth/tls-crypt wrapping ar=
ound the
+     * bare payload, with none of the reliability/ACK fields a co=
ntrol packet
+     * carries=2E */
+    struct buffer buf =3D
+        tls_=
wrap_oob_standalone(&tas_client->tls_wrap, tas_client, &sid, &payload);
+  =
  assert_int_equal((BPTR(&buf))[0] >> P_OPCODE_SHIFT, P_CONTROL_OOB_V1);
+
=
+    /* Server side: the stateless first-packet path must recognise the opc=
ode,
+     * verify the wrapping and leave exactly the payload in newbuf --=
 that is
+     * what mudp=2Ec hands to the probe parser=2E */
+    enum fi=
rst_packet_verdict verdict =3D tls_pre_decrypt_lite(tas_server, &state, &fr=
om, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_OOB_V1);
+    asser=
t_memory_equal(state=2Epeer_session_id=2Eid, sid=2Eid, SID_SIZE);
+    asse=
rt_int_equal(BLEN(&state=2Enewbuf), (int)sizeof(oob_payload));
+    assert_=
memory_equal(BPTR(&state=2Enewbuf), oob_payload, sizeof(oob_payload));
+   =
 free_tls_pre_decrypt_state(&state);
+
+    /* Tampering with any single by=
te must fail authentication: the flip runs
+     * over opcode, session id,=
 packet id, HMAC/tag and payload alike=2E Skipped
+     * for TLS_WRAP_NONE=
, where a changed payload is legitimately accepted=2E */
+    if (tas_serve=
r->tls_wrap=2Emode !=3D TLS_WRAP_NONE)
+    {
+        struct buffer copy =
=3D alloc_buf(BLEN(&buf));
+        for (int i =3D 0; i < BLEN(&buf); i++)
=
+        {
+            buf_reset_len(&copy);
+            buf_write(&copy,=
 BPTR(&buf), BLEN(&buf));
+            (BPTR(&copy))[i] ^=3D 0xff;
+       =
     struct tls_pre_decrypt_state tstate =3D { 0 };
+            verdict =
=3D tls_pre_decrypt_lite(tas_server, &tstate, &from, &copy);
+            a=
ssert_int_equal(verdict, VERDICT_INVALID);
+            free_tls_pre_decryp=
t_state(&tstate);
+        }
+        free_buf(&copy);
+    }
+
+    free_b=
uf(&payload);
+}
+
+static void
+test_oob_standalone_plain(void **ut_state)=

+{
+    struct tls_auth_standalone tas =3D { 0 };
+    struct frame frame =
=3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+ =
   tas=2Eframe =3D frame;
+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+  =
  tas=2Eworkbuf =3D alloc_buf(1600);
+
+    oob_standalone_roundtrip(&tas, =
&tas);
+
+    free_tas(&tas);
+}
+
+static void
+test_oob_standalone_tls_au=
th(void **ut_state)
+{
+    struct tls_auth_standalone tas_server =3D init_=
tas_auth(KEY_DIRECTION_NORMAL);
+    struct tls_auth_standalone tas_client =
=3D init_tas_auth(KEY_DIRECTION_INVERSE);
+    packet_id_init(&tas_client=
=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+    /* the server con=
sumes the tls-auth packet id only with packet-id state,
+     * which tls_a=
uth_standalone_init() sets up for the real one */
+    packet_id_init(&tas_=
server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+
+    now =3D 0=
x22446688;
+    oob_standalone_roundtrip(&tas_client, &tas_server);
+
+    =
packet_id_free(&tas_client=2Etls_wrap=2Eopt=2Epacket_id);
+    packet_id_fr=
ee(&tas_server=2Etls_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+=
    free_tas(&tas_server);
+}
+
+static void
+test_oob_standalone_tls_crypt=
(void **ut_state)
+{
+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom=
 =3D 200, =2Epayload_size =3D 1400 }, 0 };
+    struct tls_auth_standalone =
tas_server =3D init_tas_crypt(true);
+    struct tls_auth_standalone tas_cl=
ient =3D init_tas_crypt(false);
+    tas_server=2Eframe =3D frame;
+    tas=
_client=2Eframe =3D frame;
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=
=2Epacket_id, 5, 5, "UNITTEST", 0);
+
+    now =3D 0x22446688;
+    oob_sta=
ndalone_roundtrip(&tas_client, &tas_server);
+
+    packet_id_free(&tas_cli=
ent=2Etls_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+    free_ta=
s(&tas_server);
+}
+
 static void
 test_extract_control_message(void **ut_s=
tate)
 {
@@ -790,6 +898,9 @@
         cmocka_unit_test(test_generate_reset_=
packet_plain),
         cmocka_unit_test(test_generate_reset_packet_resend_=
wkc),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
+    =
    cmocka_unit_test(test_oob_standalone_plain),
+        cmocka_unit_test(=
test_oob_standalone_tls_auth),
+        cmocka_unit_test(test_oob_standalon=
e_tls_crypt),
         cmocka_unit_test(test_extract_control_message)
     =
};
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I930d3789e03=
13aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 2=
0
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom=
>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ra=
lf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichte=
nheld <frank@lichtenheld=2Ecom>

--kfP5R7PjzfQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #20</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">oob: Answer probe requests on the server (P_CONTROL=
_OOB_V1)<br><br>Make a --mode server UDP listener answer an out-of-band pro=
be request<br>without creating a session, so probing costs the server no st=
ate=2E<br><br>tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns t=
he new<br>VERDICT_VALID_OOB_V1, and tls_wrap_oob_standalone() wraps a bare =
OOB<br>message with the usual tls-auth/tls-crypt wrapping but no reliabilit=
y<br>fields, mirroring tls_reset_standalone()=2E do_pre_decrypt_check()<br>=
classifies the probe with oob_probe_request_check() and answers with a<br>p=
robe reply that echoes the probe&#39;s request_id=2E<br><br>A reply is char=
ged against the same rate limit as the reset replies,<br>once one is going =
to be sent, so a probe flood is capped like a reset<br>flood=2E A stale pro=
be, one whose timestamp is outside --hand-window, is<br>still answered, but=
 only within a separate budget of a twentieth of<br>--connect-freq-initial =
per period (at least one): a client with a<br>skewed clock can still probe,=
 and a replayed probe gets no more than<br>that budget=2E The budget&#39;s =
limiter is quiet, as a replayed probe<br>hitting it is not worth a warning=
=2E<br><br>The reply carries, as its own session id, the stateless SYN cook=
ie the<br>three-way handshake uses, so the server keeps nothing per probe a=
nd a<br>client can later start the handshake from the reply=2E<br><br>Chang=
e-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0<br>Signed-off-by: Lev Stipa=
kov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/ope=
nvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/reflect_filter=
=2Ec<br>M src/openvpn/reflect_filter=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/=
openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/open=
vpn/test_pkt=2Ec<br>9 files changed, 249 insertions(+), 8 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/44/1744/20</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/ope=
nvpn/mudp=2Ec</span><br><span>index de3d467=2E=2Ee97ac39 100644</span><br><=
span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec<=
/span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span><br><span> #inclu=
de &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=
=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</sp=
an><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -87,6 +88=
,34 @@</span><br><span>                           &quot;Reset packet from c=
lient, sending HMAC based reset challenge&quot;, sock);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Send an out-of-band probe reply back to the source of a probe request,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * synchronously and wi=
thout keeping any state, mirroring the reset path=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+send_probe_reply(struct multi_context *m, struc=
t tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                 struct tls_auth_standalone *tas, const struct =
oob_probe_reply *reply,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 struct session_id *own_sid, struct link_socket *sock)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* The reply carries just the probe =
reply TLV */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer payload =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!oob_probe_reply_write(&amp;payload,=
 reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* OOB replies use the same control-channel wrapping=
 as the request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esen=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    state-&gt;tl=
s_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D tls_wrap_oob_standalone(&amp;=
state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    send_standalone_reply(m, &amp;buf, &q=
uot;Server Probe&quot;, &quot;Server probe from client, sending probe reply=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
              sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span=
> /* Returns true if this packet should create a new session */</span><br><=
span> static bool</span><br><span>@@ -203,6 +232,47 @@</span><br><span> </s=
pan><br><span>         return ret;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (verdict =3D=3D VERDICT_V=
ALID_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Out-of-ban=
d server probe=2E state-&gt;newbuf points at the OOB message</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * (read_control_auth has =
stripped the opcode, session id and any</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * tls-auth/tls-crypt wrapping)=2E Answer it wi=
thout creating a session=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct oob_probe_request req;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        enum oob_probe_verdict probe =3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            oob_probe_req=
uest_check(&amp;state-&gt;newbuf, (uint64_t)now, (uint64_t)handwindow, &amp=
;req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p=
robe =3D=3D OOB_PROBE_INVALID)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return false; /* malformed: silently drop */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* A client whose clock is off by more =
than --hand-window still gets a</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * few probes per period answered, which is also all a =
replayed probe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * can get=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (probe =3D=3D OOB_PROBE_STALE &amp;&amp; !reflect_filter_rate_li=
mit_check(m-&gt;stale_probe_limiter))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* The reply counts against the same limit as the reset replies=
, charged</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 only now that we know one is going to be sent=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!reflect_filter_rate_limit_ch=
eck(m-&gt;initial_rate_limiter))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the reply=
 echoes the probe&#39;s request_id */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        struct oob_probe_reply reply =3D { =2Erequest_id =
=3D req=2Erequest_id };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Our =
session id is a stateless SYN cookie (the same HMAC the three-way</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * handshake uses): w=
e keep no per-probe state, and the reply can later</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * also serve as the server&#39;s CO=
NTROL_HARD_RESET_SERVER_V2, so a client</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * can start the handshake from it=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct session_id =
sid =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwi=
ndow, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        send_probe_reply(m, s=
tate, tas, &amp;reply, &amp;sid, sock);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* An OOB probe never creates a session */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span=
>     /* VERDICT_INVALID */</span><br><span>     return false;</span><br><s=
pan>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><s=
pan>index 3e72b92=2E=2Ea438a34 100644</span><br><span>--- a/src/openvpn/mul=
ti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -326,=
6 +326,12 @@</span><br><span>     m-&gt;new_connection_limiter =3D frequenc=
y_limit_init(t-&gt;options=2Ecf_max, t-&gt;options=2Ecf_per);</span><br><sp=
an>     m-&gt;initial_rate_limiter =3D</span><br><span>         initial_rat=
e_limit_init(t-&gt;options=2Ecf_initial_max, t-&gt;options=2Ecf_initial_per=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* stale serv=
er probes: a twentieth of the initial-packet rate, at least 1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * per period (5 per 10 s by =
default, the wire protocol&#39;s own example)=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * Quiet, as a replayed probe hitting the =
limit is not worth a warning=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    m-&gt;stale_probe_limiter =3D</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        initial_rate_limit_init(max_int(1, t-&=
gt;options=2Ecf_initial_max / 20), t-&gt;options=2Ecf_initial_per);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;stale_probe_limit=
er-&gt;quiet =3D true;</span><br><span> </span><br><span>     /*</span><br>=
<span>      * Allocate broadcast/multicast buffer list</span><br><span>@@ -=
689,6 +695,7 @@</span><br><span>         ifconfig_pool_free(m-&gt;ifconfig_=
pool);</span><br><span>         frequency_limit_free(m-&gt;new_connection_l=
imiter);</span><br><span>         initial_rate_limit_free(m-&gt;initial_rat=
e_limiter);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
initial_rate_limit_free(m-&gt;stale_probe_limiter);</span><br><span>       =
  multi_reap_free(m-&gt;reaper);</span><br><span>         mroute_helper_fre=
e(m-&gt;route_helper);</span><br><span>         multi_io_free(m-&gt;multi_i=
o);</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh</span><br><span>index 6cb86c7=2E=2E615290d 100644</span><br><span>--- =
a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><=
br><span>@@ -178,6 +178,7 @@</span><br><span>     struct ifconfig_pool *ifc=
onfig_pool;</span><br><span>     struct frequency_limit *new_connection_lim=
iter;</span><br><span>     struct initial_packet_rate_limit *initial_rate_l=
imiter;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct i=
nitial_packet_rate_limit *stale_probe_limiter; /**&lt; stale probe request =
answers */</span><br><span>     struct mroute_helper *route_helper;</span><=
br><span>     struct multi_reap *reaper;</span><br><span>     struct mroute=
_addr local;</span><br><span>diff --git a/src/openvpn/reflect_filter=2Ec b/=
src/openvpn/reflect_filter=2Ec</span><br><span>index e5226e4=2E=2E4887f01 1=
00644</span><br><span>--- a/src/openvpn/reflect_filter=2Ec</span><br><span>=
+++ b/src/openvpn/reflect_filter=2Ec</span><br><span>@@ -44,7 +44,7 @@</spa=
n><br><span>     if (now &gt; irl-&gt;last_period_reset + irl-&gt;period_le=
ngth)</span><br><span>     {</span><br><span>         int64_t dropped =3D i=
rl-&gt;curr_period_counter - irl-&gt;max_per_period;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (dropped &gt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (dropped &gt; 0 &amp;&am=
p; !irl-&gt;quiet)</span><br><span>         {</span><br><span>             =
msg(D_TLS_DEBUG_LOW,</span><br><span>                 &quot;Dropped %&quot;=
 PRId64 &quot; initial handshake packets&quot;</span><br><span>@@ -60,7 +60=
,7 @@</span><br><span> </span><br><span>     bool over_limit =3D irl-&gt;cu=
rr_period_counter &gt; irl-&gt;max_per_period;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (over_limit &amp;&amp; !i=
rl-&gt;warning_displayed)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (over_limit &amp;&amp; !irl-&gt;warning_displayed &amp;&amp; !=
irl-&gt;quiet)</span><br><span>     {</span><br><span>         msg(M_WARN,<=
/span><br><span>             &quot;Note: --connect-freq-initial %&quot; PRI=
d64 &quot; %d rate limit &quot;</span><br><span>@@ -89,7 +89,7 @@</span><br=
><span>     struct initial_packet_rate_limit *irl;</span><br><span> </span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_=
OBJ(irl, struct initial_packet_rate_limit);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(irl, struct initial_packet_rate=
_limit);</span><br><span> </span><br><span>     irl-&gt;max_per_period =3D =
max_per_period;</span><br><span>     irl-&gt;period_length =3D period_lengt=
h;</span><br><span>diff --git a/src/openvpn/reflect_filter=2Eh b/src/openvp=
n/reflect_filter=2Eh</span><br><span>index 84915e8c6=2E=2Ee996d07 100644</s=
pan><br><span>--- a/src/openvpn/reflect_filter=2Eh</span><br><span>+++ b/sr=
c/openvpn/reflect_filter=2Eh</span><br><span>@@ -44,6 +44,9 @@</span><br><s=
pan>     /* we want to warn once per period that packets are being started =
to</span><br><span>      * be dropped */</span><br><span>     bool warning_=
displayed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* drop silently: no per=
-period warning or summary in the log */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool quiet;</span><br><span> };</span><br><span> <=
/span><br><span> </span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/op=
envpn/ssl=2Ec</span><br><span>index 8e2a459=2E=2Ee8a3d20 100644</span><br><=
span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</s=
pan><br><span>@@ -3702,7 +3702,8 @@</span><br><span>     struct session_id =
sid; /* remote session ID */</span><br><span> </span><br><span>     /* veri=
fy legal opcode=2E An out-of-band packet has no control message id and</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * no ACK array, which=
 is what we parse next=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * no ACK array, which is what we parse next; do_pre_decrypt_c=
heck() answers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* those=2E */</span><br><span>     if (op &lt; P_FIRST_OPCODE || op &gt; P_=
LAST_OPCODE || opcode_is_oob(op))</span><br><span>     {</span><br><span>  =
       if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_=
HARD_RESET_SERVER_V1)</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec =
b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 38fb8ed=2E=2Ed3463b8 100644=
</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_pkt=2Ec</span><br><span>@@ -169,7 +169,8 @@</span><br><span> {</s=
pan><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id =
&lt;=3D P_KEY_ID_MASK);</span><br><span>     ASSERT(opcode &gt;=3D 0 &amp;&=
amp; opcode &lt;=3D P_LAST_OPCODE);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* OOB packets carry no message id or ACK array */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OOB packets carry n=
o message id or ACK array; tls_wrap_oob_standalone()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * builds them */</span><br><span>   =
  ASSERT(!opcode_is_oob(opcode));</span><br><span>     uint8_t header =3D (=
uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</span><br><span=
> </span><br><span>@@ -317,7 +318,8 @@</span><br><span> </span><br><span>  =
   /* Allow only the reset packet or the first packet of the actual handsha=
ke=2E */</span><br><span>     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 &a=
mp;&amp; op !=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        &amp;&amp; op !=3D P_CONTROL_V1 &amp;&amp=
; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; op !=3D P_CONTROL_V1=
 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !opcode_is_=
oob(op))</span><br><span>     {</span><br><span>         /*</span><br><span=
>          * This can occur due to bogus data or DoS packets=2E</span><br><=
span>@@ -392,6 +394,10 @@</span><br><span>     {</span><br><span>         r=
eturn VERDICT_VALID_WKC_V1;</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (opcode_is_oob(op))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return VERDICT_VALID_OOB_V1;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     el=
se</span><br><span>     {</span><br><span>         return VERDICT_VALID_RES=
ET_V2;</span><br><span>@@ -445,6 +451,29 @@</span><br><span>     return buf=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_a=
uth_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        struct session_id *own_sid, const struct buffer *p=
ayload)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer here to poi=
nt at the same data but allow tls_wrap_control</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * to potentially change buf to point to ano=
ther buffer without</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * modifying the buffer in tas */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer buf =3D tas-&gt;workbuf;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;buf, tas-=
&gt;frame=2Ebuf=2Eheadroom));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ou=
t-of-band messages carry the payload directly, with no reliability</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * or ACK fields=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_copy(&=
amp;buf, payload));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =
=3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Add tls-auth/tls-crypt wrapping, this might replac=
e buf with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ct=
x-&gt;work */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tl=
s_wrap_control(ctx, header, &amp;buf, own_sid);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return buf;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> struct session_id</span><br><span> calculate_session_id_hmac(struct se=
ssion_id client_sid, const struct openvpn_sockaddr *from,</span><br><span> =
                          const uint8_t *key, int handwindow, int offset)</=
span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=
=2Eh</span><br><span>index d477d5a=2E=2E5060a4a 100644</span><br><span>--- =
a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</sp=
an><br><span>@@ -59,8 +59,9 @@</span><br><span> #define P_CONTROL_WKC_V1 11=
</span><br><span> </span><br><span> /* Out-of-band control message, e=2Eg=
=2E a server probe=2E Not part of the reliable</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * control channel: no control message id and no A=
CK array, just TLVs</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 after the session id; never handled by tls_pre_decrypt()=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * control channel: no control =
message id and no ACK array, just TLVs after</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * the session id=2E Answered statelessly in do_pr=
e_decrypt_check(), never</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * handled by tls_pre_decrypt()=2E */</span><br><span> #define P_CONTR=
OL_OOB_V1 12</span><br><span> </span><br><span> /* define the range of defi=
ned opcodes, in- and out-of-band</span><br><span>@@ -106,6 +107,9 @@</span>=
<br><span>     VERDICT_VALID_ACK_V1,</span><br><span>     /** The packet is=
 a valid control packet with appended wrapped client key */</span><br><span=
>     VERDICT_VALID_WKC_V1,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /** This packet is a valid out-of-band control message (e=2Eg=
=2E a server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
probe)=2E It does not belong to a session and must not create one=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    VERDICT_VALID_OOB_V=
1,</span><br><span>     /** the packet failed on of the various checks */</=
span><br><span>     VERDICT_INVALID</span><br><span> };</span><br><span>@@ =
-226,6 +230,21 @@</span><br><span>                                    struc=
t session_id *own_sid, struct session_id *remote_sid,</span><br><span>     =
                               uint8_t header, bool request_resend_wkc);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wrap an already-b=
uilt out-of-band message (e=2Eg=2E a probe reply) into a</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * standalone, session-less P_CONTROL_=
OOB_V1 packet: it prepends the opcode and</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * own_sid and applies the same tls-auth/tls-crypt wr=
apping as a regular</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * control packet, but carries no reliability/ACK fields=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param ctx       tls wrapping context (from the p=
re-decrypt state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param tas       standalone auth context providing the work buffer</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param own_sid   session=
 id to use as our session id in the header</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param payload   the OOB message (header and TLVs=
) to wrap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
          the wrapped packet buffer, ready to send</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *c=
tx, struct tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                      struct session_id *o=
wn_sid, const struct buffer *payload);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> </span><br><span> /**</span><br><span>=
  * Extracts a control channel message from buf and adjusts the size of</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/uni=
t_tests/openvpn/test_pkt=2Ec</span><br><span>index 0398a1f=2E=2E887526b 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -739,6 =
+739,114 @@</span><br><span>     free_tas(&amp;tas_server);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Payload every OOB round-trip below wraps: one TLV (type 1, 4 bytes of<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value)=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static const uint8_t oob=
_payload[] =3D { 0x00, 0x01, 0x00, 0x04, 0xde, 0xad, 0xbe, 0xef };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Wrap oob_payload as a standalone P_CONTROL_O=
OB_V1 with the client side of a</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * tls-auth/tls-crypt pair (or none), run it through the server=
&#39;s stateless</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
first-packet path, and check verdict, recovered session id and payload=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+oob_standalone_roundtrip(s=
truct tls_auth_standalone *tas_client,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                         struct tls_auth_standalone *tas=
_server)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_actual=
 from =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct session_id sid =3D { { 0x0b, 1, 2, 3,=
 4, 5, 6, 0x0b } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer p=
ayload =3D alloc_buf(64);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf_write(&amp;payload, oob_payload, sizeof(oob_payload));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Client side: opcode + session id + tls=
-auth/tls-crypt wrapping around the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * bare payload, with none of the reliability/ACK field=
s a control packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * carries=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer buf =3D</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        tls_wrap_oob_standalone(&amp;tas_client-&gt;tls_wrap, tas_cli=
ent, &amp;sid, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal((BPTR(&amp;buf))[0] &gt;&gt; P_OPCODE_SHIFT,=
 P_CONTROL_OOB_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Server side:=
 the stateless first-packet path must recognise the opcode,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * verify the wrapping and leav=
e exactly the payload in newbuf -- that is</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * what mudp=2Ec hands to the probe parser=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum first_pack=
et_verdict verdict =3D tls_pre_decrypt_lite(tas_server, &amp;state, &amp;fr=
om, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(verdict, VERDICT_VALID_OOB_V1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_memory_equal(state=2Epeer_session_id=
=2Eid, sid=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(BLEN(&amp;state=2Enewbuf), (int)sizeof(oob_pay=
load));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_m=
emory_equal(BPTR(&amp;state=2Enewbuf), oob_payload, sizeof(oob_payload));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_decr=
ypt_state(&amp;state);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Tampering=
 with any single byte must fail authentication: the flip runs</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * over opcode, session id, p=
acket id, HMAC/tag and payload alike=2E Skipped</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * for TLS_WRAP_NONE, where a changed paylo=
ad is legitimately accepted=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (tas_server-&gt;tls_wrap=2Emode !=3D TLS_WRAP_NONE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        struct buffer copy =3D alloc=
_buf(BLEN(&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        for (int i =3D 0; i &lt; BLEN(&amp;buf); i++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            buf_reset_len(&amp;copy);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            buf_write(&amp;copy=
, BPTR(&amp;buf), BLEN(&amp;buf));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            (BPTR(&amp;copy))[i] ^=3D 0xff;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            struct tls_pre_decrypt_s=
tate tstate =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            verdict =3D tls_pre_decrypt_lite(tas_server, &amp;tstate, &a=
mp;from, &amp;copy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            assert_int_equal(verdict, VERDICT_INVALID);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            free_tls_pre_decrypt_state=
(&amp;tstate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free_bu=
f(&amp;copy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;payload);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_oob_standalone_plain(void **ut_state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct tls_auth_standalone tas =3D { 0 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2E=
headroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRA=
P_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Ewo=
rkbuf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_stan=
dalone_roundtrip(&amp;tas, &amp;tas);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   free_tas(&amp;tas);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_oob_standalone_tls_auth(void **ut_st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone ta=
s_server =3D init_tas_auth(KEY_DIRECTION_NORMAL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_client =3D=
 init_tas_auth(KEY_DIRECTION_INVERSE);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    packet_id_init(&amp;tas_client=2Etls_wrap=2Eopt=2Epa=
cket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* the server consumes the tls-auth packet id only=
 with packet-id state,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * which tls_auth_standalone_init() sets up for the real one */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;=
tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    oob_standalone_roundtrip(&amp;tas=
_client, &amp;tas_server);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_i=
d_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_server=2Etls_=
wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free_tas(&amp;tas_client);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    free_tas(&amp;tas_server);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_oob_standalon=
e_tls_crypt(void **ut_state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1=
400 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct tls_auth_standalone tas_server =3D init_tas_crypt(true);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_=
client =3D init_tas_crypt(false);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    tas_server=2Eframe =3D frame;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tas_client=2Eframe =3D frame;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_clien=
t=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    oob_standalone_roundtrip(&amp;tas_client, =
&amp;tas_server);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&a=
mp;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_client);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_server);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span>=
 test_extract_control_message(void **ut_state)</span><br><span> {</span><br=
><span>@@ -790,6 +898,9 @@</span><br><span>         cmocka_unit_test(test_g=
enerate_reset_packet_plain),</span><br><span>         cmocka_unit_test(test=
_generate_reset_packet_resend_wkc),</span><br><span>         cmocka_unit_te=
st(test_generate_reset_packet_tls_auth),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_oob_standalone_plain),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_oob_standalone_tls_auth),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_oob_standalone_tls_crypt),</sp=
an><br><span>         cmocka_unit_test(test_extract_control_message)</span>=
<br><span>     };</span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">change 1744</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I930d3789e0313aa0=
c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1744 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>

</body></html>
--kfP5R7PjzfQ=--


--===============6208571382961941042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6208571382961941042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6208571382961941042==--

