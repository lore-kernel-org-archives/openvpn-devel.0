Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401E606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pt+uv1Nd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gXQjI4Rt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SzjWmirG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OG6MKoKn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gGEUAetFTluWIHCeriCIHoZ8swhb6MnslNI09QWSHik=; b=Pt+uv1NdfGddXoFuskPyWcpYqB
	BL5Emx1QwDbfSOtqTci7ymIzc+t06/5o4fEOo4MA8SDi3rI5cBcV6Jmc4JxMUbvB/PCWZOQqjGoXy
	bCG78mL7HF5WIC/MWqDr1W5nwBwiSaKlHmRQiAVcUjNvwF4koczTyGYxYE7YgiM9BF/U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxms-000000006WG-0ZLK;
	Mon, 16 Nov 2026 14:34:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxmT-000000006VQ-0yqr
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3sGQwTOM/j/FQU+str+UFw3WprqMC3ir65dTwajp8bY=; b=gXQjI4RtNOPJ5OmPtnrEUYid/X
 r1AM2GfJ3Ow65mn2Yx47W/h0rKvQwHRAdCpQ5Q9wmFZj7j6SfjX1ouGPNd1cUyRmdpXAhVUyI2fbF
 38+ok5xRwiJ00AOsoOTt74v03G5KcxCkOLj3k3+GFQVA+r9etisvvbBiqlxVwvdqTzNc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3sGQwTOM/j/FQU+str+UFw3WprqMC3ir65dTwajp8bY=; b=SzjWmirGL5BpSwhwHvHZfijjMp
 prj+NR8ylNn+f5PcBkainu2SHnu47G8Huz8+0WP2A/XtiOafDMr6PJFHrO4Go3OSiKT3zpOHn5o+r
 vIPAf3g5kKJA0eghc+tg/x89SFdcvZ5Z3RZOdpI5WHhRQbAXyRIVbA2Vo3wr5V7ZF64k=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxmD-0000000064T-22U7 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:33:48 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-491846221ffso3226523f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794839619; x=1795444419; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3sGQwTOM/j/FQU+str+UFw3WprqMC3ir65dTwajp8bY=;
 b=OG6MKoKnuyM7m321uQFnozGI9y2ujIUE68uIodKzLiqcU1ZuauUQWl4IZA9eEWEx95
 zJkDMujM8JQaVi3iCoPzIRXgDirZaVovnmuIbxEU/+BSMk9htKXSnsEbrH05T8NFkB66
 dbTsKvdpWLW8OdwgHx34EyGAAb4JmLxbEnwemA7zMR5hh62WU7zZk9UH7nuEp4xOsdDY
 jU1zM+bUBvsdd5f2vgCfXat1ZmR2QOD9VqSr/LUfCtJmlNTV9w3x1CkQuSS6DIv21QoC
 kTdhBgf4mxPYKQZHlVVBcpf8AmCYdoaE3tv1DcaopJ+Mjb6hQpHYAm86yyE2iGyxZWXR
 wIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839619; x=1795444419;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3sGQwTOM/j/FQU+str+UFw3WprqMC3ir65dTwajp8bY=;
 b=kVX7mhXzC9ebDFXuuAqFPSpPy+7rtoRJqUySzBAGUR9gIPxHtvxgqrTFKmkuQN+q54
 XYdM577ijqNWkE2M6Z8qqIqQjOz43/o2wyc///7+0feQmF7bPmi6ypgvbnE06R8rZGs5
 OtUl1zcERqZrRBltDTWxOvSbpfPKeneZVPRrxRPUnyE2da0OHJo3J6xXdA7TzXfJQUAP
 StWqY5RcKW2vaUS0W7YjJC8u95ocqzq8uALAoGFFg/p32MBOH8GKwxK2uTJuR5lqGCYN
 2tX48quPF0uiHzHQyBe5Tv63Esuo2bR/SDVWdIWcLraZKkI1zobpZmwB/gACD1AL5353
 AKog==
X-Gm-Message-State: APuU4Z9d/iM+mWqWq3gc/i71aoNVqETtAOKtLwL3kYirFHfnBqueT21Q
 vjkXrFTnYHoOl58ZE+9vxjW43vGElXgIaTBrXSPLBKGvANCTyJYsWB+AetVZb0n5wPUpdFYQTdA
 4cGmhMMDjatGjEji+n5BbHbMPXQ0UB36h+y+flQzDQOQuA/VdIIfrMmPEkFtlLoOJ2A+0
X-Gm-Gg: AZFdTZeS3nGhF/ldoUsCvrbztw6LF53WPcs8DevUebuXZXW6v+vPBGr77u3HSKScvSX
 e1KX7sercWAoR340xkM0TWsrmfVyl9BwxUZuCbjXnPkz4RTM3cuL0Q8vpvvsR5zJUKGybNaYdTY
 Pmouq5g27hcFTSKD71ILPE6pXIzvBuFKDgRJ+N9RhkDD+se6ZEEvSP9JkmItXcMJOHK8ibH9dMx
 Js1X46lhVQEFCVs25P7qOhCVIcZvV4yyaS/UCHe3zfHUTSaX9b6JBnKuqE2vpVQB0EIUbFXiq4t
 BqvhkfyO58niZZfACR0lZGXaJIls/bqC/NjJB2L0VPoZGoEnZqb0yWS7HaXCEteCXmR/h7yIHmo
 KpjeoftW66+gXTQcgFbJWPuROGWOHiiy4FVcYA9afV729s5sQEUNnck8qAyKcePh5UJWSVvB+/Q
 d393xvonUEOgkBCbUEjJaRQaDFPCjIT0UAssaIYhN2+GnxLtpw9u41TX/F9LlO0cSGJT7syrwGU
 3Vhgy5Xv6GlIYXrMPxoEZh0Xs+8IEmvXa2O5H64nXw/p/6L54iVp7r+8Gbww73WWWeo0L7M5Vzt
 yQY8fvkvSI3XtsWdRbkyzYgfzNWVB9jPmhi8t6J0xGMmJIJT2kUzcEEqxtszx0a1GydlVNUWq7M
 eKNvmu1B6aJfA7aZ63W/4LSYIZiHAV27mxm20ZG4pmUz5HYnoO+8FCv/lN4KIZSxQpGx/wvswsd
 uNjZGe7GwgVTuIxNs=
X-Received: by 2002:a05:6000:1a8c:b0:48e:6812:5ef1 with SMTP id
 ffacd0b85a97d-49c713ae346mr23260452f8f.25.1794839618095; 
 Mon, 16 Nov 2026 06:33:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f78214dsm22738947f8f.25.2026.11.16.06.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:33:37 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:33:32 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 54c84b7fcd4c2102a57d71b5bf599e1b14dff76c
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <25b6fc5e2184c0df7efcae75ca8e9da1d73b63b9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxmD-0000000064T-22U7
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
Content-Type: multipart/mixed; boundary="===============0018905994839290265=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0018905994839290265==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o17DOdHNpZ8="; charset=UTF-8

--o17DOdHNpZ8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Ralf=
 Lici, R=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, Ralf Lici, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1744?usp=3Demail

to look at the new patch set (#26)=2E


Cha=
nge subject: probe: Answer probe requests on the server (P_CONTROL_V2)
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

probe: Answer pr=
obe requests on the server (P_CONTROL_V2)

Let a --mode server UDP listener=
 answer a server probe without creating
a session, so that probing costs th=
e server no state at all=2E

tls_pre_decrypt_lite() now accepts P_CONTROL_V=
2 and reports it as
VERDICT_VALID_CONTROL_V2, and tls_wrap_control_v2_stand=
alone() wraps a
bare TLV payload the way tls_reset_standalone() wraps a res=
et, minus
the reliability layer's fields, which P_CONTROL_V2 does not carry=
=2E
do_pre_decrypt_check() classifies what arrived with
probe_request_check=
() and answers with a probe reply naming the request
it answers=2E

A reply=
 is charged against the same budget as the reset replies, and
only once one=
 is going to be sent, so that a flood of probes is capped
exactly like a fl=
ood of resets=2E A stale request, one whose timestamp is
outside the window=
, is still answered, but out of a budget of its own,
a twentieth of --conne=
ct-freq-initial per period and at least one: a
client with an unsynchronise=
d clock can still probe, and a replayed
request gets no more than that=2E T=
hat budget's limiter is quiet, since
saying in the log that a replayed prob=
e hit it would be the flood
writing the log=2E

The wire protocol leaves th=
e width of that window to the server and
only gives 10 seconds as an exampl=
e=2E We pass --hand-window, 60 seconds
by default, because that is what the=
 cookie below is already tied to:
calculate_session_id_hmac() quantises tim=
e into slots half that wide
and check_session_hmac_and_pkt_id() accepts the=
 current slot and the
two before it, so answering an older request would ha=
nd out a cookie
the handshake would no longer take=2E

The reply carries as=
 its own session id that stateless cookie, so that
the server keeps nothing=
 per probe and the reply can later stand in for
its reset, which is what le=
ts a client carry on into a handshake from
it=2E That part comes later; for=
 now the client never sends a probe=2E

Until a later patch advertises a no=
n-zero connect_lifetime, this server
answers every probe with 0=2E For a pr=
obe_only request that is a correct
answer, meaning we hold no state for the=
 client, but a client probing
with probe_only unset has to read it as a ref=
usal and move on to the
next remote rather than fall back to a normal hands=
hake=2E Our own client
cannot hit this, as it does not probe yet, but it do=
es mean this patch
should not reach a release without the connect_lifetime =
one=2E

P_CONTROL_WKC_V2, a probe from a tls-crypt-v2 client that appends i=
ts
wrapped key, is not accepted yet and is rejected like any other opcode
t=
hat does not belong here=2E It needs the key unwrapped before the
message c=
an be read, and that follows separately=2E

Change-Id: I930d3789e0313aa0c3b=
c51ee5fd1d108343d59f0
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M=
 src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src=
/openvpn/reflect_filter=2Ec
M src/openvpn/reflect_filter=2Eh
M src/openvpn/=
ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/test_pkt=
=2Ec
8 files changed, 258 insertions(+), 3 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/1744/26

diff --git a/=
src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 217b299=2E=2E0037f19 1006=
44
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -34,6 +34,7 @@
=
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
 #include "sid_hash=2Eh"
+#i=
nclude "probe=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>=

@@ -90,6 +91,34 @@
                           "Reset packet from client, s=
ending HMAC based reset challenge", sock);
 }
 
+/* Send a probe reply back=
 to the peer that sent us a probe request,
+ * synchronously and without ke=
eping any state, as the reset path does=2E */
+static void
+send_probe_repl=
y(struct multi_context *m, struct tls_pre_decrypt_state *state,
+          =
       const struct tls_auth_standalone *tas, const struct probe_reply *rep=
ly,
+                 const struct session_id *own_sid, struct link_socket =
*sock)
+{
+    struct gc_arena gc =3D gc_new();
+
+    /* the message is th=
e reply TLV and nothing else */
+    struct buffer payload =3D alloc_buf_gc=
(128, &gc);
+    if (!probe_reply_write(&payload, reply))
+    {
+        g=
c_free(&gc);
+        return;
+    }
+
+    reset_packet_id_send(&state->tl=
s_wrap_tmp=2Eopt=2Epacket_id=2Esend);
+    state->tls_wrap_tmp=2Eopt=2Epack=
et_id=2Erec=2Einitialized =3D true;
+
+    struct buffer buf =3D
+        t=
ls_wrap_control_v2_standalone(&state->tls_wrap_tmp, tas, own_sid, &payload)=
;
+    send_standalone_reply(m, &buf, "Server Probe", "Probe request from c=
lient, sending probe reply",
+                          sock);
+
+    gc_fr=
ee(&gc);
+}
+
 /**
  * Verdict if this packet should create a new session=
=2E If a packet is invalid
  * or we send out an HMAC based challenge, we d=
o not want to create a new
@@ -227,6 +256,47 @@
 
         return action;
 =
    }
+    else if (verdict =3D=3D VERDICT_VALID_CONTROL_V2)
+    {
+      =
  /* read_control_auth() has taken off the opcode, the session id and
+    =
     * any wrapping, so newbuf is positioned at the TLVs=2E The protocol
+ =
        * leaves the window's width to us; --hand-window is about how long
=
+         * the cookie we reply with stays valid, so an older request would=
 be
+         * answered with one that has already expired=2E */
+        s=
truct probe_request req =3D { 0 };
+        enum probe_verdict probe =3D
+ =
           probe_request_check(&state->newbuf, (uint64_t)now, (uint64_t)han=
dwindow, &req);
+        if (probe =3D=3D PROBE_INVALID)
+        {
+      =
      return PRE_DECRYPT_NO_ACTION;
+        }
+
+        /* a budget of it=
s own for stale requests, so that an unsynchronised
+         * clock is no=
t locked out and a replay gets no more than that */
+        if (probe =3D=
=3D PROBE_STALE && !reflect_filter_rate_limit_check(m->stale_probe_limiter)=
)
+        {
+            return PRE_DECRYPT_NO_ACTION;
+        }
+
+     =
   /* charged against the reset replies' budget, and only now that we
+    =
     * know a reply is going out, so probes are capped like resets */
+    =
    if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
+       =
 {
+            return PRE_DECRYPT_NO_ACTION;
+        }
+
+        struct =
probe_reply reply =3D { =2Erequest_id =3D req=2Erequest_id };
+
+        /*=
 We answer with the handshake's own stateless cookie, so we keep
+         =
* nothing per probe and the reply can later stand in for our reset=2E */
+ =
       struct session_id sid =3D
+            calculate_session_id_hmac(sta=
te->peer_session_id, from, hmac_key, handwindow, 0);
+
+        send_probe_=
reply(m, state, tas, &reply, &sid, sock);
+
+        /* a probe never creat=
es a session */
+        return PRE_DECRYPT_NO_ACTION;
+    }
 
     /* VER=
DICT_INVALID */
     return PRE_DECRYPT_NO_ACTION;
diff --git a/src/openvpn=
/multi=2Ec b/src/openvpn/multi=2Ec
index 3f514d6=2E=2E862a957 100644
--- a/=
src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -334,6 +334,14 @@
    =
 m->new_connection_limiter =3D frequency_limit_init(t->options=2Ecf_max, t-=
>options=2Ecf_per);
     m->initial_rate_limiter =3D
         initial_rate_=
limit_init(t->options=2Ecf_initial_max, t->options=2Ecf_initial_per);
+    =
/* Answers to stale probe requests get a budget of their own, a twentieth
+=
     * of the initial packet rate and at least one per period, so that they=

+     * cannot crowd out the handshakes the main budget is for=2E */
+    =
m->stale_probe_limiter =3D initial_rate_limit_init(max_int(1, t->options=2E=
cf_initial_max / 20),
+                                                    =
 t->options=2Ecf_initial_per);
+    /* A replayed probe request is what nor=
mally runs this budget out, and
+     * saying so in the log on every perio=
d would be the flood doing it=2E */
+    m->stale_probe_limiter->quiet =3D =
true;
 
     /*
      * Allocate broadcast/multicast buffer list
@@ -713,6 =
+721,7 @@
         ifconfig_pool_free(m->ifconfig_pool);
         frequency=
_limit_free(m->new_connection_limiter);
         initial_rate_limit_free(m-=
>initial_rate_limiter);
+        initial_rate_limit_free(m->stale_probe_lim=
iter);
         multi_reap_free(m->reaper);
         mroute_helper_free(m->=
route_helper);
         multi_io_free(m->multi_io);
diff --git a/src/openvp=
n/multi=2Eh b/src/openvpn/multi=2Eh
index 3d2e932=2E=2Eecc7158 100644
--- a=
/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -194,6 +194,8 @@
    =
 struct ifconfig_pool *ifconfig_pool;
     struct frequency_limit *new_conn=
ection_limiter;
     struct initial_packet_rate_limit *initial_rate_limiter=
;
+    /** budget for answering probe requests whose timestamp is stale */
=
+    struct initial_packet_rate_limit *stale_probe_limiter;
     struct mro=
ute_helper *route_helper;
     struct multi_reap *reaper;
     struct mrout=
e_addr local;
diff --git a/src/openvpn/reflect_filter=2Ec b/src/openvpn/ref=
lect_filter=2Ec
index 953fff5=2E=2E8ba742d 100644
--- a/src/openvpn/reflect=
_filter=2Ec
+++ b/src/openvpn/reflect_filter=2Ec
@@ -44,7 +44,7 @@
     if =
(now > irl->last_period_reset + irl->period_length)
     {
         int64_t=
 dropped =3D irl->curr_period_counter - irl->max_per_period;
-        if (d=
ropped > 0)
+        if (dropped > 0 && !irl->quiet)
         {
           =
  msg(D_TLS_DEBUG_LOW,
                 "Dropped %" PRId64 " initial handsh=
ake packets"
@@ -60,7 +60,7 @@
 
     bool over_limit =3D irl->curr_period_=
counter > irl->max_per_period;
 
-    if (over_limit && !irl->warning_displ=
ayed)
+    if (over_limit && !irl->warning_displayed && !irl->quiet)
     {=

         msg(M_WARN,
             "Note: --connect-freq-initial %" PRId64 =
" %d rate limit "
@@ -96,6 +96,7 @@
     irl->curr_period_counter =3D 0;
  =
   irl->last_period_reset =3D 0;
     irl->warning_displayed =3D false;
+  =
  irl->quiet =3D false;
 
     return irl;
 }
diff --git a/src/openvpn/refl=
ect_filter=2Eh b/src/openvpn/reflect_filter=2Eh
index 84915e8c6=2E=2Efce36b=
5 100644
--- a/src/openvpn/reflect_filter=2Eh
+++ b/src/openvpn/reflect_fil=
ter=2Eh
@@ -44,6 +44,11 @@
     /* we want to warn once per period that pac=
kets are being started to
      * be dropped */
     bool warning_displayed=
;
+
+    /* drop silently: no warning and no per-period summary in the log=
=2E For a
+     * limiter that caps something an attacker can trigger at wi=
ll, where the
+     * log messages would only turn the flood into a second =
flood */
+    bool quiet;
 };
 
 
diff --git a/src/openvpn/ssl_pkt=2Ec b/sr=
c/openvpn/ssl_pkt=2Ec
index ccb841e=2E=2E7f0e170 100644
--- a/src/openvpn/s=
sl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -317,7 +317,8 @@
 
     /* Allo=
w only the reset packet or the first packet of the actual handshake=2E */
 =
    if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 && op !=3D P_CONTROL_HARD_RE=
SET_CLIENT_V3
-        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 =
&& op !=3D P_ACK_V1)
+        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_=
WKC_V1 && op !=3D P_ACK_V1
+        && op !=3D P_CONTROL_V2)
     {
       =
  /*
          * This can occur due to bogus data or DoS packets=2E
@@ -392=
,6 +393,10 @@
     {
         return VERDICT_VALID_WKC_V1;
     }
+    else=
 if (op =3D=3D P_CONTROL_V2)
+    {
+        return VERDICT_VALID_CONTROL_V=
2;
+    }
     else
     {
         return VERDICT_VALID_RESET_V2;
@@ -445,=
6 +450,29 @@
     return buf;
 }
 
+struct buffer
+tls_wrap_control_v2_stan=
dalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+  =
                             const struct session_id *own_sid, const struct=
 buffer *payload)
+{
+    /* Copy buffer here to point at the same data but=
 allow tls_wrap_control
+     * to potentially change buf to point to anoth=
er buffer without
+     * modifying the buffer in tas */
+    struct buffer=
 buf =3D tas->workbuf;
+    ASSERT(buf_init(&buf, tas->frame=2Ebuf=2Eheadro=
om));
+
+    /* A P_CONTROL_V2 message is the session id and then the TLVs:=
 no ACK
+     * array and no message id, so the payload goes in as it is=2E=
 */
+    ASSERT(buf_copy(&buf, payload));
+
+    uint8_t header =3D (uint8_=
t)(P_CONTROL_V2 << P_OPCODE_SHIFT);
+
+    /* Add tls-auth/tls-crypt wrappi=
ng, this might replace buf with
+     * ctx->work */
+    tls_wrap_control(=
ctx, header, &buf, own_sid);
+
+    return buf;
+}
+
 struct session_id
 ca=
lculate_session_id_hmac(struct session_id client_sid, const struct openvpn_=
sockaddr *from,
                           const uint8_t *key, int handwind=
ow, int offset)
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=
=2Eh
index 3b45492=2E=2E4d24437 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/=
src/openvpn/ssl_pkt=2Eh
@@ -133,6 +133,10 @@
     VERDICT_VALID_ACK_V1,
   =
  /** The packet is a valid control packet with appended wrapped client key=
 */
     VERDICT_VALID_WKC_V1,
+    /** This packet is a valid P_CONTROL_V2=
 message, e=2Eg=2E a server probe=2E It
+     * belongs to no session and m=
ust not create one; what it carries is for
+     * the caller to work out f=
rom its TLVs=2E */
+    VERDICT_VALID_CONTROL_V2,
     /** the packet faile=
d on of the various checks */
     VERDICT_INVALID
 };
@@ -256,6 +260,25 @@=

 
 
 /**
+ * Wrap an already-built TLV payload into a standalone P_CONTROL=
_V2 packet, to
+ * be sent without a session: it prepends the opcode and ow=
n_sid and applies
+ * the same tls-auth/tls-crypt wrapping as any other con=
trol channel packet,
+ * but writes none of the reliability layer's fields,=
 which P_CONTROL_V2 does
+ * not have=2E It is to a probe reply what tls_re=
set_standalone() is to a reset=2E
+ *
+ * @param ctx       tls wrapping con=
text, from the pre-decrypt state
+ * @param tas       standalone auth conte=
xt, providing the work buffer
+ * @param own_sid   the session id to send a=
s ours
+ * @param payload   the TLVs to wrap
+ * @return          the wrapp=
ed packet, ready to send
+ */
+struct buffer tls_wrap_control_v2_standalone=
(struct tls_wrap_ctx *ctx,
+                                             co=
nst struct tls_auth_standalone *tas,
+                                     =
        const struct session_id *own_sid,
+                                =
             const struct buffer *payload);
+
+
+/**
  * Extracts a control=
 channel message from buf and adjusts the size of
  * buf after the message=
 has been extracted
  * @param buf   The buffer the message should be extra=
cted from
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_t=
ests/openvpn/test_pkt=2Ec
index 415c78d=2E=2E53b06ff 100644
--- a/tests/uni=
t_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@=
 -38,6 +38,7 @@
 #include "options=2Eh"
 #include "ssl_backend=2Eh"
 #inclu=
de "control_msg=2Eh"
+#include "probe=2Eh"
 #include "ssl_pkt=2Eh"
 #includ=
e "tls_crypt=2Eh"
 
@@ -784,6 +785,119 @@
     free_tas(&tas);
 }
 
+/* Wra=
p a probe request as a standalone P_CONTROL_V2 with the client side of a
+ =
* tls-auth/tls-crypt pair (or with neither), run it through the server's
+ =
* stateless first-packet path, and check the verdict, the recovered session=
 id
+ * and the payload=2E This is the chain mudp=2Ec walks for a probe=2E =
*/
+static void
+control_v2_standalone_roundtrip(struct tls_auth_standalone=
 *tas_client,
+                                struct tls_auth_standalone *=
tas_server)
+{
+    struct link_socket_actual from =3D { 0 };
+    struct t=
ls_pre_decrypt_state state =3D { 0 };
+    struct session_id sid =3D { { 0x=
0b, 1, 2, 3, 4, 5, 6, 0x0b } };
+
+    const struct probe_request req =3D {=

+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,
+        =2Etimestamp =
=3D 0x22446688,
+        =2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,
+    }=
;
+    struct buffer payload =3D alloc_buf(64);
+    assert_true(probe_requ=
est_write(&payload, &req));
+
+    /* Client side: opcode, session id and t=
he wrapping around the bare TLVs,
+     * with none of the reliability laye=
r's fields=2E */
+    struct buffer buf =3D
+        tls_wrap_control_v2_st=
andalone(&tas_client->tls_wrap, tas_client, &sid, &payload);
+    assert_in=
t_equal((BPTR(&buf))[0] >> P_OPCODE_SHIFT, P_CONTROL_V2);
+
+    /* Server =
side: the stateless path must take the opcode, verify the
+     * wrapping =
and leave exactly the TLVs in newbuf, which is what the probe
+     * parse=
r is then handed=2E */
+    enum first_packet_verdict verdict =3D tls_pre_d=
ecrypt_lite(tas_server, &state, &from, &buf);
+    assert_int_equal(verdict=
, VERDICT_VALID_CONTROL_V2);
+    assert_memory_equal(state=2Epeer_session_=
id=2Eid, sid=2Eid, SID_SIZE);
+    assert_int_equal(BLEN(&state=2Enewbuf), =
BLEN(&payload));
+    assert_memory_equal(BPTR(&state=2Enewbuf), BPTR(&payl=
oad), BLEN(&payload));
+
+    struct probe_request got =3D { 0 };
+    asse=
rt_int_equal(probe_request_check(&state=2Enewbuf, req=2Etimestamp, 30, &got=
), PROBE_OK);
+    assert_true(got=2Erequest_id =3D=3D req=2Erequest_id);
+=
    free_tls_pre_decrypt_state(&state);
+
+    /* Flipping any single byte =
must fail authentication: the flip runs over
+     * the opcode, session id=
, packet id, HMAC or tag and payload alike=2E Not
+     * for TLS_WRAP_NONE=
, where an altered payload is legitimately accepted=2E */
+    if (tas_serv=
er->tls_wrap=2Emode !=3D TLS_WRAP_NONE)
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
+test_control_v2_standalone_plain(void **ut=
_state)
+{
+    struct tls_auth_standalone tas =3D { 0 };
+    struct frame=
 frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, =
0 };
+    tas=2Eframe =3D frame;
+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NO=
NE;
+    tas=2Eworkbuf =3D alloc_buf(1600);
+
+    control_v2_standalone_ro=
undtrip(&tas, &tas);
+
+    free_tas(&tas);
+}
+
+static void
+test_control=
_v2_standalone_tls_auth(void **ut_state)
+{
+    struct tls_auth_standalone=
 tas_server =3D init_tas_auth(KEY_DIRECTION_NORMAL);
+    struct tls_auth_s=
tandalone tas_client =3D init_tas_auth(KEY_DIRECTION_INVERSE);
+    packet_=
id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+  =
  /* the server only consumes the tls-auth packet id with packet-id state,
=
+     * which tls_auth_standalone_init() sets up for the real one */
+    p=
acket_id_init(&tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0=
);
+
+    now =3D 0x22446688;
+    control_v2_standalone_roundtrip(&tas_cli=
ent, &tas_server);
+
+    packet_id_free(&tas_client=2Etls_wrap=2Eopt=2Epac=
ket_id);
+    packet_id_free(&tas_server=2Etls_wrap=2Eopt=2Epacket_id);
+  =
  free_tas(&tas_client);
+    free_tas(&tas_server);
+}
+
+static void
+tes=
t_control_v2_standalone_tls_crypt(void **ut_state)
+{
+    struct frame fra=
me =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };=

+    struct tls_auth_standalone tas_server =3D init_tas_crypt(true);
+    =
struct tls_auth_standalone tas_client =3D init_tas_crypt(false);
+    tas_s=
erver=2Eframe =3D frame;
+    tas_client=2Eframe =3D frame;
+    packet_id_=
init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+
+   =
 now =3D 0x22446688;
+    control_v2_standalone_roundtrip(&tas_client, &tas=
_server);
+
+    packet_id_free(&tas_client=2Etls_wrap=2Eopt=2Epacket_id);
=
+    free_tas(&tas_client);
+    free_tas(&tas_server);
+}
+
 static void
 =
test_extract_control_message(void **ut_state)
 {
@@ -836,6 +950,9 @@
      =
   cmocka_unit_test(test_generate_reset_packet_resend_wkc),
         cmocka=
_unit_test(test_generate_reset_packet_tls_auth),
         cmocka_unit_test(=
test_wkc_not_appended_without_key),
+        cmocka_unit_test(test_control_=
v2_standalone_plain),
+        cmocka_unit_test(test_control_v2_standalone_=
tls_auth),
+        cmocka_unit_test(test_control_v2_standalone_tls_crypt),=

         cmocka_unit_test(test_extract_control_message),
         cmocka_u=
nit_test(test_tlv_write_u16_wire_format),
         cmocka_unit_test(test_tl=
v_header_roundtrip),

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1744?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-Number: 1744
=
Gerrit-PatchSet: 26
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ral=
f Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-CC: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--o17DOdHNpZ8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Ralf Lici, R=C4=83zv=
an Cojocaru=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #26</strong>=
 to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1744?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">probe: Answer probe =
requests on the server (P_CONTROL_V2)<br><br>Let a --mode server UDP listen=
er answer a server probe without creating<br>a session, so that probing cos=
ts the server no state at all=2E<br><br>tls_pre_decrypt_lite() now accepts =
P_CONTROL_V2 and reports it as<br>VERDICT_VALID_CONTROL_V2, and tls_wrap_co=
ntrol_v2_standalone() wraps a<br>bare TLV payload the way tls_reset_standal=
one() wraps a reset, minus<br>the reliability layer&#39;s fields, which P_C=
ONTROL_V2 does not carry=2E<br>do_pre_decrypt_check() classifies what arriv=
ed with<br>probe_request_check() and answers with a probe reply naming the =
request<br>it answers=2E<br><br>A reply is charged against the same budget =
as the reset replies, and<br>only once one is going to be sent, so that a f=
lood of probes is capped<br>exactly like a flood of resets=2E A stale reque=
st, one whose timestamp is<br>outside the window, is still answered, but ou=
t of a budget of its own,<br>a twentieth of --connect-freq-initial per peri=
od and at least one: a<br>client with an unsynchronised clock can still pro=
be, and a replayed<br>request gets no more than that=2E That budget&#39;s l=
imiter is quiet, since<br>saying in the log that a replayed probe hit it wo=
uld be the flood<br>writing the log=2E<br><br>The wire protocol leaves the =
width of that window to the server and<br>only gives 10 seconds as an examp=
le=2E We pass --hand-window, 60 seconds<br>by default, because that is what=
 the cookie below is already tied to:<br>calculate_session_id_hmac() quanti=
ses time into slots half that wide<br>and check_session_hmac_and_pkt_id() a=
ccepts the current slot and the<br>two before it, so answering an older req=
uest would hand out a cookie<br>the handshake would no longer take=2E<br><b=
r>The reply carries as its own session id that stateless cookie, so that<br=
>the server keeps nothing per probe and the reply can later stand in for<br=
>its reset, which is what lets a client carry on into a handshake from<br>i=
t=2E That part comes later; for now the client never sends a probe=2E<br><b=
r>Until a later patch advertises a non-zero connect_lifetime, this server<b=
r>answers every probe with 0=2E For a probe_only request that is a correct<=
br>answer, meaning we hold no state for the client, but a client probing<br=
>with probe_only unset has to read it as a refusal and move on to the<br>ne=
xt remote rather than fall back to a normal handshake=2E Our own client<br>=
cannot hit this, as it does not probe yet, but it does mean this patch<br>s=
hould not reach a release without the connect_lifetime one=2E<br><br>P_CONT=
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
pn=2Enet:29418/openvpn refs/changes/44/1744/26</pre><pre style=3D"font-fami=
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
an><br><span>index 953fff5=2E=2E8ba742d 100644</span><br><span>--- a/src/op=
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
span><br><span>@@ -96,6 +96,7 @@</span><br><span>     irl-&gt;curr_period_c=
ounter =3D 0;</span><br><span>     irl-&gt;last_period_reset =3D 0;</span><=
br><span>     irl-&gt;warning_displayed =3D false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    irl-&gt;quiet =3D false;</span><br><span=
> </span><br><span>     return irl;</span><br><span> }</span><br><span>diff=
 --git a/src/openvpn/reflect_filter=2Eh b/src/openvpn/reflect_filter=2Eh</s=
pan><br><span>index 84915e8c6=2E=2Efce36b5 100644</span><br><span>--- a/src=
/openvpn/reflect_filter=2Eh</span><br><span>+++ b/src/openvpn/reflect_filte=
r=2Eh</span><br><span>@@ -44,6 +44,11 @@</span><br><span>     /* we want to=
 warn once per period that packets are being started to</span><br><span>   =
   * be dropped */</span><br><span>     bool warning_displayed;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* drop silently: no warning and no per-period=
 summary in the log=2E For a</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * limiter that caps something an attacker can trigger at will=
, where the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * l=
og messages would only turn the flood into a second flood */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool quiet;</span><br><span> }=
;</span><br><span> </span><br><span> </span><br><span>diff --git a/src/open=
vpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index ccb841e=2E=
=2E7f0e170 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><=
span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -317,7 +317,8 @@</spa=
n><br><span> </span><br><span>     /* Allow only the reset packet or the fi=
rst packet of the actual handshake=2E */</span><br><span>     if (op !=3D P=
_CONTROL_HARD_RESET_CLIENT_V2 &amp;&amp; op !=3D P_CONTROL_HARD_RESET_CLIEN=
T_V3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp=
; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=
=3D P_ACK_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &amp;&amp; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;=
&amp; op !=3D P_ACK_V1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &amp;&amp; op !=3D P_CONTROL_V2)</span><br><span>     {</span><b=
r><span>         /*</span><br><span>          * This can occur due to bogus=
 data or DoS packets=2E</span><br><span>@@ -392,6 +393,10 @@</span><br><spa=
n>     {</span><br><span>         return VERDICT_VALID_WKC_V1;</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (op =3D=3D P_CONTROL_V2)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return VERDICT_VALID_CONTROL_V2;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span>     else</span><br><span>     {</span=
><br><span>         return VERDICT_VALID_RESET_V2;</span><br><span>@@ -445,=
6 +450,29 @@</span><br><span>     return buf;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffe=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_wrap_control_v=
2_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *ta=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
              const struct session_id *own_sid, const struct buffer *payloa=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer here to point at=
 the same data but allow tls_wrap_control</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * to potentially change buf to point to another =
buffer without</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* modifying the buffer in tas */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer buf =3D tas-&gt;workbuf;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;buf, tas-&gt;f=
rame=2Ebuf=2Eheadroom));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A P_CON=
TROL_V2 message is the session id and then the TLVs: no ACK</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * array and no message id, so =
the payload goes in as it is=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ASSERT(buf_copy(&amp;buf, payload));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint8_t header =3D (uint8_t)(P_CONTROL_V2 &lt;&lt; P_O=
PCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Add tls-auth/tls-c=
rypt wrapping, this might replace buf with</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * ctx-&gt;work */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    tls_wrap_control(ctx, header, &amp;buf, own_s=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return buf;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> struct session_id</span><br><span> cal=
culate_session_id_hmac(struct session_id client_sid, const struct openvpn_s=
ockaddr *from,</span><br><span>                           const uint8_t *ke=
y, int handwindow, int offset)</span><br><span>diff --git a/src/openvpn/ssl=
_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 3b45492=2E=2E4d244=
37 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++=
 b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -133,6 +133,10 @@</span><br><=
span>     VERDICT_VALID_ACK_V1,</span><br><span>     /** The packet is a va=
lid control packet with appended wrapped client key */</span><br><span>    =
 VERDICT_VALID_WKC_V1,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /** This packet is a valid P_CONTROL_V2 message, e=2Eg=2E a server p=
robe=2E It</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * be=
longs to no session and must not create one; what it carries is for</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * the caller to work o=
ut from its TLVs=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    VERDICT_VALID_CONTROL_V2,</span><br><span>     /** the packet failed=
 on of the various checks */</span><br><span>     VERDICT_INVALID</span><br=
><span> };</span><br><span>@@ -256,6 +260,25 @@</span><br><span> </span><br=
><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Wrap an already-built TLV payload into a standalone P_CONTROL_=
V2 packet, to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * be =
sent without a session: it prepends the opcode and own_sid and applies</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the same tls-auth/tls=
-crypt wrapping as any other control channel packet,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * but writes none of the reliability lay=
er&#39;s fields, which P_CONTROL_V2 does</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * not have=2E It is to a probe reply what tls_reset_s=
tandalone() is to a reset=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m ctx       tls wrapping context, from the pre-decrypt state</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param tas       standalone aut=
h context, providing the work buffer</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param own_sid   the session id to send as ours</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param payload   the TLV=
s to wrap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
          the wrapped packet, ready to send</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+struct buffer tls_wrap_control_v2_standalone(struct tls_wrap_ctx *c=
tx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                             const struct tls_auth_standalone *tas,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                  const struct session_id *own_sid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
    const struct buffer *payload);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  *=
 Extracts a control channel message from buf and adjusts the size of</span>=
<br><span>  * buf after the message has been extracted</span><br><span>  * =
@param buf   The buffer the message should be extracted from</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/ope=
nvpn/test_pkt=2Ec</span><br><span>index 415c78d=2E=2E53b06ff 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -38,6 +38,7 @@</sp=
an><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &q=
uot;ssl_backend=2Eh&quot;</span><br><span> #include &quot;control_msg=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
probe=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br=
><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> </span><br><spa=
n>@@ -784,6 +785,119 @@</span><br><span>     free_tas(&amp;tas);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Wrap a probe request as a standalone P_CONTROL_V2 with the client=
 side of a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tls-au=
th/tls-crypt pair (or with neither), run it through the server&#39;s</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * stateless first-packet =
path, and check the verdict, the recovered session id</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * and the payload=2E This is the chain m=
udp=2Ec walks for a probe=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+control_v2_standalone_roundtrip(struct tls_auth_standalone *tas_client,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
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
_state)</span><br><span> {</span><br><span>@@ -836,6 +950,9 @@</span><br><s=
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
none"> Gerrit-PatchSet: 26 </div>
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
it-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--o17DOdHNpZ8=--


--===============0018905994839290265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0018905994839290265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0018905994839290265==--

