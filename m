Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8027606A32C
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eq9luVpn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hktRQD4z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QKcO0Nq/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZR7tft9R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L9JbFJODAi32+FJJblbvl0Lf1Q9oioAasTCxmRlvr8M=; b=eq9luVpneoTOr6lxbzhcy7d9tA
	l7I73eW2Hunh3QcUlbiVpODTPoPjBEQ/bnFmrQ4sdSOYRpGL9enlrWX/+jgekph+9kRj4FLbX8A23
	ceV2I3zWRi38A3WnFjVNR2P97tkESUPeDFr50hpaPIqtfyHBU7aarUG7nQBnLMuNrlO4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPK9M-000000007Mp-2Nph;
	Fri, 06 Nov 2026 13:38:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPK9K-000000007Mi-3oz5
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WTYftcqTrR9An/zm/15OVsrQ2fzm7lU27a8VrRvOm9I=; b=hktRQD4zxOPUucfeUV7N+F4Mkg
 sjGZNFvZYslcTJozOzC8vdzQtO9k3jQGy9rdvB9GO8m9eG7yCrfzFr2r8DEf5EymyxEwIcidnRKgR
 2nQa2gW3JC1EQK5Go2Nqj3b2HnmIMCAU7QgeXvsEaiUHHNAkcpJj9sVyaAyVO4/hNSpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WTYftcqTrR9An/zm/15OVsrQ2fzm7lU27a8VrRvOm9I=; b=QKcO0Nq/xswmukc/UXOfIwnvc3
 A6gT5YRRf5tuLjhH0oAb00N3L3HFRsXFZ4XskfDa2xvVRgQ9rhoJ1qsh6WMCldMHNt8SdhMpRrE2+
 661GtsUbJhDFyqEKLR0Hw/tjAgdGhUN7tN9Js0+U25TBO7T3BZPSC87uebz6u/vA+QBg=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPK9H-000000006tJ-0Q8B for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:38:34 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so5493995e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 05:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793972304; x=1794577104; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WTYftcqTrR9An/zm/15OVsrQ2fzm7lU27a8VrRvOm9I=;
 b=ZR7tft9RBoeF/JG7DHEFSmMUNsNgRle6z9eN7RL+eVO3iyChmnpgSYayfnvrTPgGIz
 EiM2ocwmc5ER5K2KOH9E8MocfSrA4XdVuY+1ZfqmOzMdlZ2pSBSdK9ljUFNqWVO61CXH
 fnLudyyoJLt9saqYY4zISRbE/0qMy1grTlLirlIAMy+atp1aAMZ6v2CAzgczFtciZpN6
 WLsvTao2ymnzfj5I+UnzADlbfMA1t/kxZDCQAZ2WHVm5ksKCNGcsIk/7pDn74i5k+zs2
 qTu3WBFP1hiHDNPmnFVjczPM9GbOoN+YDN7U3KOb62IlpYN67ogogWeA6j3SgOmsqrQH
 6wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972304; x=1794577104;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WTYftcqTrR9An/zm/15OVsrQ2fzm7lU27a8VrRvOm9I=;
 b=qf4dD+/5nxcp8EpxjQCW4cnQcB+JDU/R6J69f/TL0sieuUCvCmXBEa5lhjWPfpCy1V
 0UiV/waUdsr4mdP9rhgq59d9ECLWDBXtshXsIYGinWEuZtdOd3b6S+5wltKgHB/x/Eus
 nhqE/Wiq2/CjcJvlZ+UHczricPjvjDYf5w36ZuRi1lbqfnNlkgLBy2Ew9BSLMf7r4Z1J
 i31GSiAwbHFeAKqzUuHiQqBlHQpPB378zUzdItNm8J6rnURvgwkO+t0LpfNX57AByjf/
 8nzQQiWUIAt3rCf/9+pMNRAY0MDwwQxOTFE3g3/yEWqiaLYCNP1Nc+DeOvz/R3r50ANN
 nL6Q==
X-Gm-Message-State: APuU4Z91TexwgruSueP98NmuRLWrTvSVQqQqybiAzeIHqKn71g2vAzPh
 pOeOXKESNcy/5rsvTlzurz3bTn2kduvLYUEC3wY4NR5G8er24wapLjXOrRL7yCgGdFl8hk1sFMP
 SpTn0W8eluRoKJoao2CMaExJczbGpUfchtJtBJtz3RbqoRA/AXZ9HkJz/X0pN4ENPVnOr
X-Gm-Gg: AYBFou3oM5J6BYk81mjqsKfQc2mq38rkYKcIBmDuN1p7JY8reXB2jLsi/CEsjE1c8rp
 gal9bj+Bseat2VcE3cVHisrlE1aPFKuItLSWWEjNaz9FLQe0CjfAqbZCIzCCcFDlGa06mUw260u
 3Ltq7x3V5ysx+04ugORAanrvl5etW9Ptr5Y8i1d5IHnS6GEJCHt4mc1pfjn2QvJ7akNtDinKhPD
 uXXmfurD0wlLAHqUwqZbDV5uYTyWwc5TWndb3gfCge2FxD8NSPZK3rYeeBuOMDegq8Py04/6Xjo
 IFYwbx0XWnCHAE9Hzpbt5LqYK+ZmLSATn1fujh1zwPa4MkA0S4OExn/SJk7LtVoa9f7R2R9whSV
 HA5VyU/ESmgK/wetMmCrjMOJwXSoJREW8dr0HHEcfwLg8+mL3GiqpuUt59zkZRQLWqHSAzOU0oS
 ogXbL53etji4aWUnge84bq6CT3pOBl+tbzbcqPWGgaRNML1IMiG1SqHxTOfO7lLXDbkaJjz/GGJ
 RPXDTmtYhFelgYvj6PdvNnJRF9XcZGj/i4ItAzmEST2h+JJ8t37PHkRaP9U+DWJMJB+OXaDQRF+
 XEgR9GORAlfOwnsZlWLwiMEsyGQ0q3UxM8cE6+WSzMnuTsOwW+3+I+zaaXmQMTtKMHH4KtHShCA
 VSF95wF/UE40wArIyCYAiSx3fKcXX03VBdjny/g/CcqRv4Kv55KFm2fvqpinu9RilB2RJ5CA+Ph
 KN/NZADDhaOaLu5A==
X-Received: by 2002:a05:600c:1552:b0:4a7:b304:253e with SMTP id
 5b1f17b1804b1-4b6dfbac6a9mr42832635e9.22.1793972304143; 
 Fri, 06 Nov 2026 05:38:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b761c10f57sm16884045e9.4.2026.11.06.05.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:38:23 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 13:38:19 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 1f96baff85475aa28360a45022d6a93106f23bf8
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed385a1bb2f886d1f371890468b503bee92bc9b4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPK9H-000000006tJ-0Q8B
Subject: [Openvpn-devel] [L] Change in openvpn[master]: probe: Answer probe
 requests on the server (P_CONTROL_V2)
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org, ralf@mandelbit.com,
 frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1478580277639800765=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1478580277639800765==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ezp54RgaiDI="; charset=UTF-8

--ezp54RgaiDI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici=2E

Hello Arne Schwabe, Ralf Lici, 

I'd like you to re=
examine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1744?usp=3Demail

to look at the new patch set (#23)=2E


Change subj=
ect: probe: Answer probe requests on the server (P_CONTROL_V2)
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

probe: Answer probe reque=
sts on the server (P_CONTROL_V2)

Let a --mode server UDP listener answer a=
 server probe without creating
a session, so that probing costs the server =
no state at all=2E

tls_pre_decrypt_lite() now accepts P_CONTROL_V2 and rep=
orts it as
VERDICT_VALID_CONTROL_V2, and tls_wrap_control_v2_standalone() w=
raps a
bare TLV payload the way tls_reset_standalone() wraps a reset, minus=

the reliability layer's fields, which P_CONTROL_V2 does not carry=2E
do_pr=
e_decrypt_check() classifies what arrived with
probe_request_check() and an=
swers with a probe reply naming the request
it answers=2E

A reply is charg=
ed against the same budget as the reset replies, and
only once one is going=
 to be sent, so that a flood of probes is capped
exactly like a flood of re=
sets=2E A stale request, one whose timestamp is
outside the window, is stil=
l answered, but out of a budget of its own,
a twentieth of --connect-freq-i=
nitial per period and at least one: a
client with an unsynchronised clock c=
an still probe, and a replayed
request gets no more than that=2E That budge=
t's limiter is quiet, since
saying in the log that a replayed probe hit it =
would be the flood
writing the log=2E

The wire protocol leaves the width o=
f that window to the server and
only gives 10 seconds as an example=2E We p=
ass --hand-window, 60 seconds
by default, because that is what the cookie b=
elow is already tied to:
calculate_session_id_hmac() quantises time into sl=
ots half that wide
and check_session_hmac_and_pkt_id() accepts the current =
slot and the
two before it, so answering an older request would hand out a =
cookie
the handshake would no longer take=2E

The reply carries as its own =
session id that stateless cookie, so that
the server keeps nothing per prob=
e and the reply can later stand in for
its reset, which is what lets a clie=
nt carry on into a handshake from
it=2E That part comes later; for now the =
client never sends a probe=2E

P_CONTROL_WKC_V2, a probe from a tls-crypt-v=
2 client that appends its
wrapped key, is not accepted yet and is rejected =
like any other opcode
that does not belong here=2E It needs the key unwrapp=
ed before the
message can be read, and that follows separately=2E

Change-I=
d: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Signed-off-by: Lev Stipakov <l=
ev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/=
openvpn/multi=2Eh
M src/openvpn/reflect_filter=2Ec
M src/openvpn/reflect_fi=
lter=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_t=
ests/openvpn/test_pkt=2Ec
8 files changed, 258 insertions(+), 3 deletions(-=
)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/1=
744/23

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 217b=
299=2E=2E0037f19 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=
=2Ec
@@ -34,6 +34,7 @@
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
 #inc=
lude "sid_hash=2Eh"
+#include "probe=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #in=
clude <sys/inotify=2Eh>
@@ -90,6 +91,34 @@
                           "Rese=
t packet from client, sending HMAC based reset challenge", sock);
 }
 
+/* =
Send a probe reply back to the peer that sent us a probe request,
+ * synch=
ronously and without keeping any state, as the reset path does=2E */
+stati=
c void
+send_probe_reply(struct multi_context *m, struct tls_pre_decrypt_st=
ate *state,
+                 const struct tls_auth_standalone *tas, const =
struct probe_reply *reply,
+                 const struct session_id *own_s=
id, struct link_socket *sock)
+{
+    struct gc_arena gc =3D gc_new();
+
+ =
   /* the message is the reply TLV and nothing else */
+    struct buffer p=
ayload =3D alloc_buf_gc(128, &gc);
+    if (!probe_reply_write(&payload, re=
ply))
+    {
+        gc_free(&gc);
+        return;
+    }
+
+    reset_pa=
cket_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
+    state->tl=
s_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;
+
+    struct bu=
ffer buf =3D
+        tls_wrap_control_v2_standalone(&state->tls_wrap_tmp, =
tas, own_sid, &payload);
+    send_standalone_reply(m, &buf, "Server Probe"=
, "Probe request from client, sending probe reply",
+                      =
    sock);
+
+    gc_free(&gc);
+}
+
 /**
  * Verdict if this packet should=
 create a new session=2E If a packet is invalid
  * or we send out an HMAC =
based challenge, we do not want to create a new
@@ -227,6 +256,47 @@
 
    =
     return action;
     }
+    else if (verdict =3D=3D VERDICT_VALID_CONTR=
OL_V2)
+    {
+        /* read_control_auth() has taken off the opcode, the=
 session id and
+         * any wrapping, so newbuf is positioned at the TL=
Vs=2E The protocol
+         * leaves the window's width to us; --hand-wind=
ow is about how long
+         * the cookie we reply with stays valid, so a=
n older request would be
+         * answered with one that has already exp=
ired=2E */
+        struct probe_request req =3D { 0 };
+        enum probe=
_verdict probe =3D
+            probe_request_check(&state->newbuf, (uint64=
_t)now, (uint64_t)handwindow, &req);
+        if (probe =3D=3D PROBE_INVALI=
D)
+        {
+            return PRE_DECRYPT_NO_ACTION;
+        }
+
+    =
    /* a budget of its own for stale requests, so that an unsynchronised
+ =
        * clock is not locked out and a replay gets no more than that */
+ =
       if (probe =3D=3D PROBE_STALE && !reflect_filter_rate_limit_check(m->=
stale_probe_limiter))
+        {
+            return PRE_DECRYPT_NO_ACTION;=

+        }
+
+        /* charged against the reset replies' budget, and on=
ly now that we
+         * know a reply is going out, so probes are capped =
like resets */
+        if (!reflect_filter_rate_limit_check(m->initial_rat=
e_limiter))
+        {
+            return PRE_DECRYPT_NO_ACTION;
+        =
}
+
+        struct probe_reply reply =3D { =2Erequest_id =3D req=2Erequest=
_id };
+
+        /* We answer with the handshake's own stateless cookie, s=
o we keep
+         * nothing per probe and the reply can later stand in fo=
r our reset=2E */
+        struct session_id sid =3D
+            calculate=
_session_id_hmac(state->peer_session_id, from, hmac_key, handwindow, 0);
+
=
+        send_probe_reply(m, state, tas, &reply, &sid, sock);
+
+        /*=
 a probe never creates a session */
+        return PRE_DECRYPT_NO_ACTION;
=
+    }
 
     /* VERDICT_INVALID */
     return PRE_DECRYPT_NO_ACTION;
diff=
 --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3f514d6=2E=2E8=
62a957 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3=
34,6 +334,14 @@
     m->new_connection_limiter =3D frequency_limit_init(t->=
options=2Ecf_max, t->options=2Ecf_per);
     m->initial_rate_limiter =3D
  =
       initial_rate_limit_init(t->options=2Ecf_initial_max, t->options=2Ecf=
_initial_per);
+    /* Answers to stale probe requests get a budget of thei=
r own, a twentieth
+     * of the initial packet rate and at least one per =
period, so that they
+     * cannot crowd out the handshakes the main budge=
t is for=2E */
+    m->stale_probe_limiter =3D initial_rate_limit_init(max_=
int(1, t->options=2Ecf_initial_max / 20),
+                                =
                     t->options=2Ecf_initial_per);
+    /* A replayed probe=
 request is what normally runs this budget out, and
+     * saying so in th=
e log on every period would be the flood doing it=2E */
+    m->stale_probe=
_limiter->quiet =3D true;
 
     /*
      * Allocate broadcast/multicast bu=
ffer list
@@ -713,6 +721,7 @@
         ifconfig_pool_free(m->ifconfig_pool)=
;
         frequency_limit_free(m->new_connection_limiter);
         initia=
l_rate_limit_free(m->initial_rate_limiter);
+        initial_rate_limit_fre=
e(m->stale_probe_limiter);
         multi_reap_free(m->reaper);
         mr=
oute_helper_free(m->route_helper);
         multi_io_free(m->multi_io);
dif=
f --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3d2e932=2E=2E=
ecc7158 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -=
194,6 +194,8 @@
     struct ifconfig_pool *ifconfig_pool;
     struct frequ=
ency_limit *new_connection_limiter;
     struct initial_packet_rate_limit *=
initial_rate_limiter;
+    /** budget for answering probe requests whose ti=
mestamp is stale */
+    struct initial_packet_rate_limit *stale_probe_limi=
ter;
     struct mroute_helper *route_helper;
     struct multi_reap *reape=
r;
     struct mroute_addr local;
diff --git a/src/openvpn/reflect_filter=
=2Ec b/src/openvpn/reflect_filter=2Ec
index e5226e4=2E=2E5bb1cf4 100644
---=
 a/src/openvpn/reflect_filter=2Ec
+++ b/src/openvpn/reflect_filter=2Ec
@@ -=
44,7 +44,7 @@
     if (now > irl->last_period_reset + irl->period_length)
 =
    {
         int64_t dropped =3D irl->curr_period_counter - irl->max_per_=
period;
-        if (dropped > 0)
+        if (dropped > 0 && !irl->quiet)
=
         {
             msg(D_TLS_DEBUG_LOW,
                 "Dropped %" P=
RId64 " initial handshake packets"
@@ -60,7 +60,7 @@
 
     bool over_limit=
 =3D irl->curr_period_counter > irl->max_per_period;
 
-    if (over_limit =
&& !irl->warning_displayed)
+    if (over_limit && !irl->warning_displayed =
&& !irl->quiet)
     {
         msg(M_WARN,
             "Note: --connect-f=
req-initial %" PRId64 " %d rate limit "
@@ -95,6 +95,7 @@
     irl->period_=
length =3D period_length;
     irl->curr_period_counter =3D 0;
     irl->la=
st_period_reset =3D 0;
+    irl->quiet =3D false;
 
     return irl;
 }
dif=
f --git a/src/openvpn/reflect_filter=2Eh b/src/openvpn/reflect_filter=2Eh
i=
ndex 84915e8c6=2E=2Efce36b5 100644
--- a/src/openvpn/reflect_filter=2Eh
+++=
 b/src/openvpn/reflect_filter=2Eh
@@ -44,6 +44,11 @@
     /* we want to war=
n once per period that packets are being started to
      * be dropped */
 =
    bool warning_displayed;
+
+    /* drop silently: no warning and no per-=
period summary in the log=2E For a
+     * limiter that caps something an a=
ttacker can trigger at will, where the
+     * log messages would only turn=
 the flood into a second flood */
+    bool quiet;
 };
 
 
diff --git a/src=
/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index ccb841e=2E=2E7f0e170 1=
00644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -317,7=
 +317,8 @@
 
     /* Allow only the reset packet or the first packet of the=
 actual handshake=2E */
     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 && =
op !=3D P_CONTROL_HARD_RESET_CLIENT_V3
-        && op !=3D P_CONTROL_V1 && =
op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1)
+        && op !=3D P_CONTROL=
_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1
+        && op !=3D P_C=
ONTROL_V2)
     {
         /*
          * This can occur due to bogus data =
or DoS packets=2E
@@ -392,6 +393,10 @@
     {
         return VERDICT_VALID=
_WKC_V1;
     }
+    else if (op =3D=3D P_CONTROL_V2)
+    {
+        retur=
n VERDICT_VALID_CONTROL_V2;
+    }
     else
     {
         return VERDICT=
_VALID_RESET_V2;
@@ -445,6 +450,29 @@
     return buf;
 }
 
+struct buffer
=
+tls_wrap_control_v2_standalone(struct tls_wrap_ctx *ctx, const struct tls_=
auth_standalone *tas,
+                               const struct session_=
id *own_sid, const struct buffer *payload)
+{
+    /* Copy buffer here to p=
oint at the same data but allow tls_wrap_control
+     * to potentially cha=
nge buf to point to another buffer without
+     * modifying the buffer in =
tas */
+    struct buffer buf =3D tas->workbuf;
+    ASSERT(buf_init(&buf, =
tas->frame=2Ebuf=2Eheadroom));
+
+    /* A P_CONTROL_V2 message is the sess=
ion id and then the TLVs: no ACK
+     * array and no message id, so the pa=
yload goes in as it is=2E */
+    ASSERT(buf_copy(&buf, payload));
+
+    u=
int8_t header =3D (uint8_t)(P_CONTROL_V2 << P_OPCODE_SHIFT);
+
+    /* Add =
tls-auth/tls-crypt wrapping, this might replace buf with
+     * ctx->work =
*/
+    tls_wrap_control(ctx, header, &buf, own_sid);
+
+    return buf;
+}=

+
 struct session_id
 calculate_session_id_hmac(struct session_id client_s=
id, const struct openvpn_sockaddr *from,
                           const u=
int8_t *key, int handwindow, int offset)
diff --git a/src/openvpn/ssl_pkt=
=2Eh b/src/openvpn/ssl_pkt=2Eh
index 3b45492=2E=2E4d24437 100644
--- a/src/=
openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -133,6 +133,10 @@
    =
 VERDICT_VALID_ACK_V1,
     /** The packet is a valid control packet with a=
ppended wrapped client key */
     VERDICT_VALID_WKC_V1,
+    /** This pack=
et is a valid P_CONTROL_V2 message, e=2Eg=2E a server probe=2E It
+     * b=
elongs to no session and must not create one; what it carries is for
+     =
* the caller to work out from its TLVs=2E */
+    VERDICT_VALID_CONTROL_V2,=

     /** the packet failed on of the various checks */
     VERDICT_INVALI=
D
 };
@@ -256,6 +260,25 @@
 
 
 /**
+ * Wrap an already-built TLV payload i=
nto a standalone P_CONTROL_V2 packet, to
+ * be sent without a session: it =
prepends the opcode and own_sid and applies
+ * the same tls-auth/tls-crypt=
 wrapping as any other control channel packet,
+ * but writes none of the r=
eliability layer's fields, which P_CONTROL_V2 does
+ * not have=2E It is to=
 a probe reply what tls_reset_standalone() is to a reset=2E
+ *
+ * @param =
ctx       tls wrapping context, from the pre-decrypt state
+ * @param tas  =
     standalone auth context, providing the work buffer
+ * @param own_sid =
  the session id to send as ours
+ * @param payload   the TLVs to wrap
+ * =
@return          the wrapped packet, ready to send
+ */
+struct buffer tls_=
wrap_control_v2_standalone(struct tls_wrap_ctx *ctx,
+                     =
                        const struct tls_auth_standalone *tas,
+           =
                                  const struct session_id *own_sid,
+      =
                                       const struct buffer *payload);
+
+
+=
/**
  * Extracts a control channel message from buf and adjusts the size of=

  * buf after the message has been extracted
  * @param buf   The buffer t=
he message should be extracted from
diff --git a/tests/unit_tests/openvpn/t=
est_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 0cb2ea5=2E=2Ec2a4=
754 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tes=
ts/openvpn/test_pkt=2Ec
@@ -38,6 +38,7 @@
 #include "options=2Eh"
 #include=
 "ssl_backend=2Eh"
 #include "control_msg=2Eh"
+#include "probe=2Eh"
 #incl=
ude "ssl_pkt=2Eh"
 #include "tls_crypt=2Eh"
 
@@ -785,6 +786,119 @@
     fr=
ee_tas(&tas);
 }
 
+/* Wrap a probe request as a standalone P_CONTROL_V2 wi=
th the client side of a
+ * tls-auth/tls-crypt pair (or with neither), run =
it through the server's
+ * stateless first-packet path, and check the verd=
ict, the recovered session id
+ * and the payload=2E This is the chain mudp=
=2Ec walks for a probe=2E */
+static void
+control_v2_standalone_roundtrip(=
struct tls_auth_standalone *tas_client,
+                                st=
ruct tls_auth_standalone *tas_server)
+{
+    struct link_socket_actual fro=
m =3D { 0 };
+    struct tls_pre_decrypt_state state =3D { 0 };
+    struct=
 session_id sid =3D { { 0x0b, 1, 2, 3, 4, 5, 6, 0x0b } };
+
+    const stru=
ct probe_request req =3D {
+        =2Erequest_id =3D 0xdeadbeefcafef00dULL=
,
+        =2Etimestamp =3D 0x22446688,
+        =2Eflags =3D PROBE_REQUEST=
_FLAG_PROBE_ONLY,
+    };
+    struct buffer payload =3D alloc_buf(64);
+  =
  assert_true(probe_request_write(&payload, &req));
+
+    /* Client side: =
opcode, session id and the wrapping around the bare TLVs,
+     * with none=
 of the reliability layer's fields=2E */
+    struct buffer buf =3D
+      =
  tls_wrap_control_v2_standalone(&tas_client->tls_wrap, tas_client, &sid, &=
payload);
+    assert_int_equal((BPTR(&buf))[0] >> P_OPCODE_SHIFT, P_CONTRO=
L_V2);
+
+    /* Server side: the stateless path must take the opcode, veri=
fy the
+     * wrapping and leave exactly the TLVs in newbuf, which is what=
 the probe
+     * parser is then handed=2E */
+    enum first_packet_verdi=
ct verdict =3D tls_pre_decrypt_lite(tas_server, &state, &from, &buf);
+    =
assert_int_equal(verdict, VERDICT_VALID_CONTROL_V2);
+    assert_memory_equ=
al(state=2Epeer_session_id=2Eid, sid=2Eid, SID_SIZE);
+    assert_int_equal=
(BLEN(&state=2Enewbuf), BLEN(&payload));
+    assert_memory_equal(BPTR(&sta=
te=2Enewbuf), BPTR(&payload), BLEN(&payload));
+
+    struct probe_request =
got =3D { 0 };
+    assert_int_equal(probe_request_check(&state=2Enewbuf, r=
eq=2Etimestamp, 30, &got), PROBE_OK);
+    assert_true(got=2Erequest_id =3D=
=3D req=2Erequest_id);
+    free_tls_pre_decrypt_state(&state);
+
+    /* F=
lipping any single byte must fail authentication: the flip runs over
+     =
* the opcode, session id, packet id, HMAC or tag and payload alike=2E Not
+=
     * for TLS_WRAP_NONE, where an altered payload is legitimately accepted=
=2E */
+    if (tas_server->tls_wrap=2Emode !=3D TLS_WRAP_NONE)
+    {
+   =
     struct buffer copy =3D alloc_buf(BLEN(&buf));
+        for (int i =3D =
0; i < BLEN(&buf); i++)
+        {
+            buf_reset_len(&copy);
+    =
        buf_write(&copy, BPTR(&buf), BLEN(&buf));
+            (BPTR(&copy)=
)[i] ^=3D 0xff;
+            struct tls_pre_decrypt_state tstate =3D { 0 };=

+            verdict =3D tls_pre_decrypt_lite(tas_server, &tstate, &from, =
&copy);
+            assert_int_equal(verdict, VERDICT_INVALID);
+         =
   free_tls_pre_decrypt_state(&tstate);
+        }
+        free_buf(&copy)=
;
+    }
+
+    free_buf(&payload);
+}
+
+static void
+test_control_v2_stan=
dalone_plain(void **ut_state)
+{
+    struct tls_auth_standalone tas =3D { =
0 };
+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epay=
load_size =3D 1400 }, 0 };
+    tas=2Eframe =3D frame;
+    tas=2Etls_wrap=
=2Emode =3D TLS_WRAP_NONE;
+    tas=2Eworkbuf =3D alloc_buf(1600);
+
+    c=
ontrol_v2_standalone_roundtrip(&tas, &tas);
+
+    free_tas(&tas);
+}
+
+st=
atic void
+test_control_v2_standalone_tls_auth(void **ut_state)
+{
+    str=
uct tls_auth_standalone tas_server =3D init_tas_auth(KEY_DIRECTION_NORMAL);=

+    struct tls_auth_standalone tas_client =3D init_tas_auth(KEY_DIRECTION=
_INVERSE);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5,=
 5, "UNITTEST", 0);
+    /* the server only consumes the tls-auth packet id=
 with packet-id state,
+     * which tls_auth_standalone_init() sets up for=
 the real one */
+    packet_id_init(&tas_server=2Etls_wrap=2Eopt=2Epacket_=
id, 5, 5, "UNITTEST", 0);
+
+    now =3D 0x22446688;
+    control_v2_standa=
lone_roundtrip(&tas_client, &tas_server);
+
+    packet_id_free(&tas_client=
=2Etls_wrap=2Eopt=2Epacket_id);
+    packet_id_free(&tas_server=2Etls_wrap=
=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+    free_tas(&tas_server)=
;
+}
+
+static void
+test_control_v2_standalone_tls_crypt(void **ut_state)
=
+{
+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epaylo=
ad_size =3D 1400 }, 0 };
+    struct tls_auth_standalone tas_server =3D ini=
t_tas_crypt(true);
+    struct tls_auth_standalone tas_client =3D init_tas_=
crypt(false);
+    tas_server=2Eframe =3D frame;
+    tas_client=2Eframe =
=3D frame;
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5,=
 5, "UNITTEST", 0);
+
+    now =3D 0x22446688;
+    control_v2_standalone_r=
oundtrip(&tas_client, &tas_server);
+
+    packet_id_free(&tas_client=2Etls=
_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+    free_tas(&tas_se=
rver);
+}
+
 static void
 test_extract_control_message(void **ut_state)
 {
=
@@ -837,6 +951,9 @@
         cmocka_unit_test(test_generate_reset_packet_re=
send_wkc),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
=
         cmocka_unit_test(test_wkc_not_appended_without_key),
+        cmoc=
ka_unit_test(test_control_v2_standalone_plain),
+        cmocka_unit_test(t=
est_control_v2_standalone_tls_auth),
+        cmocka_unit_test(test_control=
_v2_standalone_tls_crypt),
         cmocka_unit_test(test_extract_control_m=
essage),
         cmocka_unit_test(test_tlv_write_u16_wire_format),
       =
  cmocka_unit_test(test_tlv_header_roundtrip),

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
G=
errit-Change-Number: 1744
Gerrit-PatchSet: 23
Gerrit-Owner: Lev Stipakov <l=
stipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attent=
ion: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@licht=
enheld=2Ecom>

--ezp54RgaiDI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #23</strong> to this=
 change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744=
?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">probe: Answer probe requests=
 on the server (P_CONTROL_V2)<br><br>Let a --mode server UDP listener answe=
r a server probe without creating<br>a session, so that probing costs the s=
erver no state at all=2E<br><br>tls_pre_decrypt_lite() now accepts P_CONTRO=
L_V2 and reports it as<br>VERDICT_VALID_CONTROL_V2, and tls_wrap_control_v2=
_standalone() wraps a<br>bare TLV payload the way tls_reset_standalone() wr=
aps a reset, minus<br>the reliability layer&#39;s fields, which P_CONTROL_V=
2 does not carry=2E<br>do_pre_decrypt_check() classifies what arrived with<=
br>probe_request_check() and answers with a probe reply naming the request<=
br>it answers=2E<br><br>A reply is charged against the same budget as the r=
eset replies, and<br>only once one is going to be sent, so that a flood of =
probes is capped<br>exactly like a flood of resets=2E A stale request, one =
whose timestamp is<br>outside the window, is still answered, but out of a b=
udget of its own,<br>a twentieth of --connect-freq-initial per period and a=
t least one: a<br>client with an unsynchronised clock can still probe, and =
a replayed<br>request gets no more than that=2E That budget&#39;s limiter i=
s quiet, since<br>saying in the log that a replayed probe hit it would be t=
he flood<br>writing the log=2E<br><br>The wire protocol leaves the width of=
 that window to the server and<br>only gives 10 seconds as an example=2E We=
 pass --hand-window, 60 seconds<br>by default, because that is what the coo=
kie below is already tied to:<br>calculate_session_id_hmac() quantises time=
 into slots half that wide<br>and check_session_hmac_and_pkt_id() accepts t=
he current slot and the<br>two before it, so answering an older request wou=
ld hand out a cookie<br>the handshake would no longer take=2E<br><br>The re=
ply carries as its own session id that stateless cookie, so that<br>the ser=
ver keeps nothing per probe and the reply can later stand in for<br>its res=
et, which is what lets a client carry on into a handshake from<br>it=2E Tha=
t part comes later; for now the client never sends a probe=2E<br><br>P_CONT=
ROL_WKC_V2, a probe from a tls-crypt-v2 client that appends its<br>wrapped =
key, is not accepted yet and is rejected like any other opcode<br>that does=
 not belong here=2E It needs the key unwrapped before the<br>message can be=
 read, and that follows separately=2E<br><br>Change-Id: I930d3789e0313aa0c3=
bc51ee5fd1d108343d59f0<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet=
&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/o=
penvpn/multi=2Eh<br>M src/openvpn/reflect_filter=2Ec<br>M src/openvpn/refle=
ct_filter=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>=
M tests/unit_tests/openvpn/test_pkt=2Ec<br>8 files changed, 258 insertions(=
+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/44/1744/23</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 217b299=2E=2E003=
7f19 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ =
b/src/openvpn/mudp=2Ec</span><br><span>@@ -34,6 +34,7 @@</span><br><span> #=
include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&=
quot;</span><br><span> #include &quot;sid_hash=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;probe=2Eh&quot;</span><=
br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #inc=
lude &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -90,6 +91,34 @@</span><br><=
span>                           &quot;Reset packet from client, sending HMA=
C based reset challenge&quot;, sock);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Send a probe repl=
y back to the peer that sent us a probe request,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * synchronously and without keeping any state=
, as the reset path does=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+send_probe_reply(struct multi_context *m, struct tls_pre_decrypt_state *=
state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
    const struct tls_auth_standalone *tas, const struct probe_reply *reply,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 co=
nst struct session_id *own_sid, struct link_socket *sock)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* the message is the reply TLV and nothing else */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer pay=
load =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!probe_reply_write(&amp;payload, reply))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=
=2Esend);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    state-=
&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_control_v2_standalone(&a=
mp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    send_standalone_reply(m, &amp;buf, =
&quot;Server Probe&quot;, &quot;Probe request from client, sending probe re=
ply&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                 sock);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br=
><span>  * Verdict if this packet should create a new session=2E If a packe=
t is invalid</span><br><span>  * or we send out an HMAC based challenge, we=
 do not want to create a new</span><br><span>@@ -227,6 +256,47 @@</span><br=
><span> </span><br><span>         return action;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (verdict =
=3D=3D VERDICT_VALID_CONTROL_V2)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* read_control_auth() has taken off the opcode, the session id and<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * any wrapp=
ing, so newbuf is positioned at the TLVs=2E The protocol</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * leaves the window&#39;s wid=
th to us; --hand-window is about how long</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * the cookie we reply with stays valid, so a=
n older request would be</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * answered with one that has already expired=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct probe_request r=
eq =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  enum probe_verdict probe =3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            probe_request_check(&amp;state-&gt;newbuf, (uint64_t=
)now, (uint64_t)handwindow, &amp;req);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (probe =3D=3D PROBE_INVALID)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_ACTION;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        /* a budget of its own for stale requests, so=
 that an unsynchronised</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         * clock is not locked out and a replay gets no more than that =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (probe=
 =3D=3D PROBE_STALE &amp;&amp; !reflect_filter_rate_limit_check(m-&gt;stale=
_probe_limiter))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn PRE_DECRYPT_NO_ACTION;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* charged a=
gainst the reset replies&#39; budget, and only now that we</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * know a reply is going out=
, so probes are capped like resets */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!reflect_filter_rate_limit_check(m-&gt;initia=
l_rate_limiter))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn PRE_DECRYPT_NO_ACTION;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct probe=
_reply reply =3D { =2Erequest_id =3D req=2Erequest_id };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* We answer with the handshake&#39;s own statele=
ss cookie, so we keep</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * nothing per probe and the reply can later stand in for our res=
et=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct session_id sid =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            calculate_session_id_hmac(state-&gt;peer_session_id, from, h=
mac_key, handwindow, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        send_p=
robe_reply(m, state, tas, &amp;reply, &amp;sid, sock);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* a probe never creates a session */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return PRE_DECRYPT_NO_ACT=
ION;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span> </span><br><span>     /* VERDICT_INVALID */</span><br><span>     re=
turn PRE_DECRYPT_NO_ACTION;</span><br><span>diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3f514d6=2E=2E862a957 100=
644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/o=
penvpn/multi=2Ec</span><br><span>@@ -334,6 +334,14 @@</span><br><span>     =
m-&gt;new_connection_limiter =3D frequency_limit_init(t-&gt;options=2Ecf_ma=
x, t-&gt;options=2Ecf_per);</span><br><span>     m-&gt;initial_rate_limiter=
 =3D</span><br><span>         initial_rate_limit_init(t-&gt;options=2Ecf_in=
itial_max, t-&gt;options=2Ecf_initial_per);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Answers to stale probe requests get a budget=
 of their own, a twentieth</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * of the initial packet rate and at least one per period, so th=
at they</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * canno=
t crowd out the handshakes the main budget is for=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    m-&gt;stale_probe_limiter =3D initi=
al_rate_limit_init(max_int(1, t-&gt;options=2Ecf_initial_max / 20),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                          t-&gt;options=2Ecf_initial_per);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* A replayed probe request is w=
hat normally runs this budget out, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * saying so in the log on every period would be the=
 flood doing it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    m-&gt;stale_probe_limiter-&gt;quiet =3D true;</span><br><span> </span=
><br><span>     /*</span><br><span>      * Allocate broadcast/multicast buf=
fer list</span><br><span>@@ -713,6 +721,7 @@</span><br><span>         ifcon=
fig_pool_free(m-&gt;ifconfig_pool);</span><br><span>         frequency_limi=
t_free(m-&gt;new_connection_limiter);</span><br><span>         initial_rate=
_limit_free(m-&gt;initial_rate_limiter);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        initial_rate_limit_free(m-&gt;stale_probe_limi=
ter);</span><br><span>         multi_reap_free(m-&gt;reaper);</span><br><sp=
an>         mroute_helper_free(m-&gt;route_helper);</span><br><span>       =
  multi_io_free(m-&gt;multi_io);</span><br><span>diff --git a/src/openvpn/m=
ulti=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 3d2e932=2E=2Eecc7158=
 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/s=
rc/openvpn/multi=2Eh</span><br><span>@@ -194,6 +194,8 @@</span><br><span>  =
   struct ifconfig_pool *ifconfig_pool;</span><br><span>     struct frequen=
cy_limit *new_connection_limiter;</span><br><span>     struct initial_packe=
t_rate_limit *initial_rate_limiter;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /** budget for answering probe requests whose timestamp=
 is stale */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct initial_packet_rate_limit *stale_probe_limiter;</span><br><span>     st=
ruct mroute_helper *route_helper;</span><br><span>     struct multi_reap *r=
eaper;</span><br><span>     struct mroute_addr local;</span><br><span>diff =
--git a/src/openvpn/reflect_filter=2Ec b/src/openvpn/reflect_filter=2Ec</sp=
an><br><span>index e5226e4=2E=2E5bb1cf4 100644</span><br><span>--- a/src/op=
envpn/reflect_filter=2Ec</span><br><span>+++ b/src/openvpn/reflect_filter=
=2Ec</span><br><span>@@ -44,7 +44,7 @@</span><br><span>     if (now &gt; ir=
l-&gt;last_period_reset + irl-&gt;period_length)</span><br><span>     {</sp=
an><br><span>         int64_t dropped =3D irl-&gt;curr_period_counter - irl=
-&gt;max_per_period;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (dropped &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (dropped &gt; 0 &amp;&amp; !irl-&gt;quiet)</span><br><spa=
n>         {</span><br><span>             msg(D_TLS_DEBUG_LOW,</span><br><s=
pan>                 &quot;Dropped %&quot; PRId64 &quot; initial handshake =
packets&quot;</span><br><span>@@ -60,7 +60,7 @@</span><br><span> </span><br=
><span>     bool over_limit =3D irl-&gt;curr_period_counter &gt; irl-&gt;ma=
x_per_period;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (over_limit &amp;&amp; !irl-&gt;warning_displayed)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (over_limit &amp;&am=
p; !irl-&gt;warning_displayed &amp;&amp; !irl-&gt;quiet)</span><br><span>  =
   {</span><br><span>         msg(M_WARN,</span><br><span>             &quo=
t;Note: --connect-freq-initial %&quot; PRId64 &quot; %d rate limit &quot;</=
span><br><span>@@ -95,6 +95,7 @@</span><br><span>     irl-&gt;period_length=
 =3D period_length;</span><br><span>     irl-&gt;curr_period_counter =3D 0;=
</span><br><span>     irl-&gt;last_period_reset =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    irl-&gt;quiet =3D false;</span><br><=
span> </span><br><span>     return irl;</span><br><span> }</span><br><span>=
diff --git a/src/openvpn/reflect_filter=2Eh b/src/openvpn/reflect_filter=2E=
h</span><br><span>index 84915e8c6=2E=2Efce36b5 100644</span><br><span>--- a=
/src/openvpn/reflect_filter=2Eh</span><br><span>+++ b/src/openvpn/reflect_f=
ilter=2Eh</span><br><span>@@ -44,6 +44,11 @@</span><br><span>     /* we wan=
t to warn once per period that packets are being started to</span><br><span=
>      * be dropped */</span><br><span>     bool warning_displayed;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* drop silently: no warning and no per-pe=
riod summary in the log=2E For a</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * limiter that caps something an attacker can trigger at =
will, where the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * log messages would only turn the flood into a second flood */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool quiet;</span><br><spa=
n> };</span><br><span> </span><br><span> </span><br><span>diff --git a/src/=
openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index ccb841e=
=2E=2E7f0e170 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><b=
r><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -317,7 +317,8 @@</=
span><br><span> </span><br><span>     /* Allow only the reset packet or the=
 first packet of the actual handshake=2E */</span><br><span>     if (op !=
=3D P_CONTROL_HARD_RESET_CLIENT_V2 &amp;&amp; op !=3D P_CONTROL_HARD_RESET_=
CLIENT_V3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp=
;&amp; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; =
op !=3D P_ACK_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      &amp;&amp; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &=
amp;&amp; op !=3D P_ACK_V1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        &amp;&amp; op !=3D P_CONTROL_V2)</span><br><span>     {</spa=
n><br><span>         /*</span><br><span>          * This can occur due to b=
ogus data or DoS packets=2E</span><br><span>@@ -392,6 +393,10 @@</span><br>=
<span>     {</span><br><span>         return VERDICT_VALID_WKC_V1;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse if (op =3D=3D P_CONTROL_V2)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return VERDICT_VALID_CONTROL_V2;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span>     else</span><br><span>     {</=
span><br><span>         return VERDICT_VALID_RESET_V2;</span><br><span>@@ -=
445,6 +450,29 @@</span><br><span>     return buf;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct b=
uffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_wrap_contr=
ol_v2_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone=
 *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                  const struct session_id *own_sid, const struct buffer *pa=
yload)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer here to poin=
t at the same data but allow tls_wrap_control</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * to potentially change buf to point to anot=
her buffer without</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * modifying the buffer in tas */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D tas-&gt;workbuf;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;buf, tas-&=
gt;frame=2Ebuf=2Eheadroom));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A P=
_CONTROL_V2 message is the session id and then the TLVs: no ACK</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * array and no message id,=
 so the payload goes in as it is=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ASSERT(buf_copy(&amp;buf, payload));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint8_t header =3D (uint8_t)(P_CONTROL_V2 &lt;&lt;=
 P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Add tls-auth/t=
ls-crypt wrapping, this might replace buf with</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * ctx-&gt;work */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tls_wrap_control(ctx, header, &amp;buf, o=
wn_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return buf;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> struct session_id</span><br><span>=
 calculate_session_id_hmac(struct session_id client_sid, const struct openv=
pn_sockaddr *from,</span><br><span>                           const uint8_t=
 *key, int handwindow, int offset)</span><br><span>diff --git a/src/openvpn=
/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 3b45492=2E=2E4=
d24437 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span=
>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -133,6 +133,10 @@</span><=
br><span>     VERDICT_VALID_ACK_V1,</span><br><span>     /** The packet is =
a valid control packet with appended wrapped client key */</span><br><span>=
     VERDICT_VALID_WKC_V1,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /** This packet is a valid P_CONTROL_V2 message, e=2Eg=2E a serv=
er probe=2E It</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* belongs to no session and must not create one; what it carries is for</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the caller to wo=
rk out from its TLVs=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    VERDICT_VALID_CONTROL_V2,</span><br><span>     /** the packet fa=
iled on of the various checks */</span><br><span>     VERDICT_INVALID</span=
><br><span> };</span><br><span>@@ -256,6 +260,25 @@</span><br><span> </span=
><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Wrap an already-built TLV payload into a standalone P_CONT=
ROL_V2 packet, to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 be sent without a session: it prepends the opcode and own_sid and applies<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the same tls-auth=
/tls-crypt wrapping as any other control channel packet,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * but writes none of the reliability =
layer&#39;s fields, which P_CONTROL_V2 does</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * not have=2E It is to a probe reply what tls_rese=
t_standalone() is to a reset=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram ctx       tls wrapping context, from the pre-decrypt state</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param tas       standalone =
auth context, providing the work buffer</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param own_sid   the session id to send as ours</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param payload   the =
TLVs to wrap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn          the wrapped packet, ready to send</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct buffer tls_wrap_control_v2_standalone(struct tls_wrap_ctx=
 *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                const struct tls_auth_standalone *tas,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                     const struct session_id *own_sid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
     const struct buffer *payload);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  =
* Extracts a control channel message from buf and adjusts the size of</span=
><br><span>  * buf after the message has been extracted</span><br><span>  *=
 @param buf   The buffer the message should be extracted from</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/op=
envpn/test_pkt=2Ec</span><br><span>index 0cb2ea5=2E=2Ec2a4754 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -38,6 +38,7 @@</s=
pan><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &=
quot;ssl_backend=2Eh&quot;</span><br><span> #include &quot;control_msg=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;probe=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><b=
r><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> </span><br><sp=
an>@@ -785,6 +786,119 @@</span><br><span>     free_tas(&amp;tas);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Wrap a probe request as a standalone P_CONTROL_V2 with the clien=
t side of a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tls-a=
uth/tls-crypt pair (or with neither), run it through the server&#39;s</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * stateless first-packet=
 path, and check the verdict, the recovered session id</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * and the payload=2E This is the chain =
mudp=2Ec walks for a probe=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+control_v2_standalone_roundtrip(struct tls_auth_standalone *tas_client=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
              struct tls_auth_standalone *tas_server)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct link_socket_actual from =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct tls_pre_decrypt_state =
state =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct session_id sid =3D { { 0x0b, 1, 2, 3, 4, 5, 6, 0x0b } };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct probe_request req =3D {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0x=
deadbeefcafef00dULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        =2Etimestamp =3D 0x22446688,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        =2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D alloc_bu=
f(64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(probe_request_write(&amp;payload, &amp;req));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Client side: opcode, session id and the wrapping around th=
e bare TLVs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
with none of the reliability layer&#39;s fields=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_control_v2_standal=
one(&amp;tas_client-&gt;tls_wrap, tas_client, &amp;sid, &amp;payload);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal((BP=
TR(&amp;buf))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_V2);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Server side: the stateless path must take the opco=
de, verify the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* wrapping and leave exactly the TLVs in newbuf, which is what the probe</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * parser is then =
handed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    enu=
m first_packet_verdict verdict =3D tls_pre_decrypt_lite(tas_server, &amp;st=
ate, &amp;from, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(verdict, VERDICT_VALID_CONTROL_V2);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(state=
=2Epeer_session_id=2Eid, sid=2Eid, SID_SIZE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;state=2Enewbuf), B=
LEN(&amp;payload));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_memory_equal(BPTR(&amp;state=2Enewbuf), BPTR(&amp;payload), BLEN=
(&amp;payload));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct probe_reque=
st got =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(probe_request_check(&amp;state=2Enewbuf, req=2Etimestamp=
, 30, &amp;got), PROBE_OK);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(got=2Erequest_id =3D=3D req=2Erequest_id);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_sta=
te(&amp;state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Flipping any sin=
gle byte must fail authentication: the flip runs over</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * the opcode, session id, packet id,=
 HMAC or tag and payload alike=2E Not</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * for TLS_WRAP_NONE, where an altered payload is leg=
itimately accepted=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (tas_server-&gt;tls_wrap=2Emode !=3D TLS_WRAP_NONE)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct buffer copy =3D alloc_buf(BLEN=
(&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (int i =3D 0; i &lt; BLEN(&amp;buf); i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            buf_reset_len(&amp;copy);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            buf_write(&amp;copy, BPTR(&a=
mp;buf), BLEN(&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            (BPTR(&amp;copy))[i] ^=3D 0xff;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            struct tls_pre_decrypt_state tsta=
te =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      verdict =3D tls_pre_decrypt_lite(tas_server, &amp;tstate, &amp;from, =
&amp;copy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    assert_int_equal(verdict, VERDICT_INVALID);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            free_tls_pre_decrypt_state(&amp;tst=
ate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        free_buf(&amp;co=
py);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    free_buf(&amp;payload);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_contr=
ol_v2_standalone_plain(void **ut_state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct tls_auth_standalone tas =3D { 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2Ehe=
adroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_=
NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Ework=
buf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    control_v2=
_standalone_roundtrip(&amp;tas, &amp;tas);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    free_tas(&amp;tas);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_control_v2_standalone_tls_auth(v=
oid **ut_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_st=
andalone tas_server =3D init_tas_auth(KEY_DIRECTION_NORMAL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas=
_client =3D init_tas_auth(KEY_DIRECTION_INVERSE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_client=2Etls_wrap=
=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* the server only consumes the tls-a=
uth packet id with packet-id state,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * which tls_auth_standalone_init() sets up for the rea=
l one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_=
id_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&=
quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    control_v2_standalon=
e_roundtrip(&amp;tas_client, &amp;tas_server);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&a=
mp;tas_server=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_client);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_server);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_control_v2_standalone_tls_crypt(void **ut_state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D=
 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct tls_auth_standalone tas_server =3D init_tas_c=
rypt(true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct tls_auth_standalone tas_client =3D init_tas_crypt(false);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Eframe =3D frame;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Efra=
me =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pa=
cket_id_init(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNIT=
TEST&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x22446688;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    control_v2_stan=
dalone_roundtrip(&amp;tas_client, &amp;tas_server);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket=
_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&=
amp;tas_client);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free_tas(&amp;tas_server);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static void</span><br><span> test_extract_control_message(void **ut=
_state)</span><br><span> {</span><br><span>@@ -837,6 +951,9 @@</span><br><s=
pan>         cmocka_unit_test(test_generate_reset_packet_resend_wkc),</span=
><br><span>         cmocka_unit_test(test_generate_reset_packet_tls_auth),<=
/span><br><span>         cmocka_unit_test(test_wkc_not_appended_without_key=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(test_control_v2_standalone_plain),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_control_v2_standalone_=
tls_auth),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_control_v2_standalone_tls_crypt),</span><br><span>    =
     cmocka_unit_test(test_extract_control_message),</span><br><span>      =
   cmocka_unit_test(test_tlv_write_u16_wire_format),</span><br><span>      =
   cmocka_unit_test(test_tlv_header_roundtrip),</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Dema=
il">change 1744</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1744?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1744 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf=
 Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ezp54RgaiDI=--


--===============1478580277639800765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1478580277639800765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1478580277639800765==--

