Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF5A606A329
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NDU0wk3e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LbahRaIV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c8tmnoWr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M975v5k0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZWFNBe6j8byHm7kGt0SbpSCEsmEYybCikLzGxNiUtts=; b=NDU0wk3eS7XZbQB+tqSnYchkh0
	jXt9IaGuf5K+kauXctARfPC04LdbWgjeL418BFmZ0v5egBnES7zlK/COnt3a3jh/d0ASXYBF5wdQG
	kilyUKSyq9/QklegRlJuPy+hgcj1NQ2ZnW9/tq6pW9twOcTRKNaN5VILNSUkZ7jQOtX0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPK0M-0000000076Y-0sfJ;
	Fri, 06 Nov 2026 13:29:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPK0K-0000000076O-1u6i
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:29:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NecJCRSK3XISaPjx5Oht9JvAKHdD1xdMwyS2MeqxY20=; b=LbahRaIVDSKlb5U1wZ/NKfEcFT
 S+ektCHbb5EJOOqUThEd1YxEt9IP8drXBRbJ50LSZJyDwRTqKzrjDoDCkOJVN9FxMMfNiQi6Trp4K
 FGM7gZFx9a4wEWq5/4KApyW/da79dcKQ04kuQI2c/crK4EhJaLp87NXkipZayZNRNn4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NecJCRSK3XISaPjx5Oht9JvAKHdD1xdMwyS2MeqxY20=; b=c8tmnoWryZ2YGwefAG0xHF9JaP
 QNRQYgWDeI6gBPNUZxGhhwsLQ6cMU+9eswKOnGO8YjiT9I3RskXh4T68jDfM5imh0sw2zBDD1vnOk
 Sgou+/sZSFsFJiczrXVtwMbcFkst4uzCAHbgiM9Xp4aV6aeLJR+y1X+VGm6XmAg3Ak4A=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPK0F-000000003Sh-3nho for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:29:16 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so5815295e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 05:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793971745; x=1794576545; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NecJCRSK3XISaPjx5Oht9JvAKHdD1xdMwyS2MeqxY20=;
 b=M975v5k0auuRLbi/U1qWBtC/Aga9XSbrR1LIpgYh0PvH9svNX2CVZqcYyvfldiumP2
 CweqnclAst7jp2fPv0swWu6ciMbko7OQuZT1FohPZzRmwI7zCZ6XeA6W8k5rW3zBXgK5
 5vPk8H1xqJo78jZqs9SKOS2rfS2ToD3Y6p+bveGs1gwyDqLRSiaeP/g4kI6nvWTsgU94
 msC4KmAbDY01rwCTPnfmt73HS26ia6L4fwfaKy4RrAjQy81ORSldqc1DnqO4lY/MVG6U
 liOTNk4CNF01ClfJcKOKztMjfALABZXQJ7SuiDgMYgfLBem+9IWERSOfVeo4S53Zkxuj
 PuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793971745; x=1794576545;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NecJCRSK3XISaPjx5Oht9JvAKHdD1xdMwyS2MeqxY20=;
 b=PSkf9OOAv8wApON1cLg1uKMYaKp4gtJ/9qypp3Y52kZAOdoAk28Ius2hA8TnMT4466
 Un/+t/b+YV65XQ6JTHLgQUDiuPvlrZx/qD96PN8mQaBPPj6hbXiw798oVG+L5UziEEt2
 X1eLd5JYAGSipOEEOpNGNj5Kih0c+JU1DJI+m9P8Xb/BisP6vv57o1Tr3AXK//RpypF8
 FtOYBIpzy1s4+HeJJzjtV0ezuofQ4zgZhphh3cuQcP+BpHylDf2G3YJcGZyN5aGNDEcJ
 nYe5MMQSkG5k0bbpSfxuENjUBLJhB/z2wSQ94y7T+dTDzKMjkTW1VeM5iVE7GgOf8ERx
 000A==
X-Gm-Message-State: APuU4Z81MAY8/DHikpLqHZ6b82k6yzJ2cdtLKHJ8ylT9I6s77/uK2tup
 Y5hM6Pf5sFOwvvdU+NKMnRbsY/hzBJMeotwVQm+7FEz+NHunrA4Z6gNrcjjCFHL23syET1LFEnU
 TYTOzYGg+3TDZhW9ODU4wqnaZfGOOL/551bLwIfcHNsVa+3T5c8jbWDso0HTdPw/QBB9M
X-Gm-Gg: AYBFou255/8WP1FfbzC6YMS6M7cZK3yqK+FITyGAo75XJ+ZiQnQVy9XaDtMa3noITPv
 F5K2UUNJwhOGD2/id/5KAQ2H4hWtDpwZRE0lpj7FJEYuNIkZKRXucPbcXg+zewSWiqlQf3HG76s
 0KgQjQK60EL5FMwWMrDKcMFBu8Scl4r/iNSICPK4WV88nXZsx75Aypmm41UW359UHfg4VYBc6ls
 IBr5aNKeOVBhhrwusvgWEZxj2EyhaMPIGrQ7t1i6P8cWlS6pkXpSzR8UAdAKiw/oKVozTAbeq1x
 qiYSHN8dBEUZWCmY/J+sKdJ+wDE2MfEnqsIa8RWRSrvDp6JLXAe8SN3AwonOtoAbEMGST5lSB7d
 BKugEbW4WpBsrsprtxOWVhaYBBBUmTjGn27PkTb/QDmFHkeWJHBxYAMeI0EDoJu8o0kjK/Q3OmZ
 Zyksu/43UUiklVfnEsoYiXmUNjNpI+xgqcwCcWFZMLaprdNZ1dd4f1PsfVEqQ2ED/JXcJznuE5r
 WOCPZOsMiRGfeo9OI2VHw/UoWgeNv+d80rzRsyAZpjrbyI0pDsG4k/xqsxgBTcdAb035rN46nlC
 KB+ObvRUkNnv0zSwWajhI6QWkFPkpcjVDkCocHB1h6aLXzhOY6URMxTXFI9DgrGhxYjXTAdV5E1
 TxO9Qe8qgFbiCj3W2qvHzWRf7IUmwPjZxGvFluAcevUQHV8PXPEAA4wxcG6Zh83CbjQS69d9/5f
 6I5dLZX+HgVtNYhw==
X-Received: by 2002:a05:600c:6306:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4b6dea69843mr48942215e9.10.1793971744826; 
 Fri, 06 Nov 2026 05:29:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6162sm3648720f8f.47.2026.11.06.05.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:29:04 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 13:29:01 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 79ac17e36f3ee793bcc75f8fbf4c5ebaf24df874
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7189261149ca1e08d6a46f1d7d5e2fe86035f420-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPK0F-000000003Sh-3nho
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
Content-Type: multipart/mixed; boundary="===============8210808822291717026=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8210808822291717026==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9HvmJiy03uo="; charset=UTF-8

--9HvmJiy03uo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici=2E

Hello Arne Schwabe, Ralf Lici, 

I'd like you to re=
examine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1744?usp=3Demail

to look at the new patch set (#22)=2E


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
744/22

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 217b=
299=2E=2E73dd1f9 100644
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
+        struct probe_request req;
+        enum probe_verdict p=
robe =3D
+            probe_request_check(&state->newbuf, (uint64_t)now, (u=
int64_t)handwindow, &req);
+        if (probe =3D=3D PROBE_INVALID)
+      =
  {
+            return PRE_DECRYPT_NO_ACTION;
+        }
+
+        /* a b=
udget of its own for stale requests, so that an unsynchronised
+         * =
clock is not locked out and a replay gets no more than that */
+        if =
(probe =3D=3D PROBE_STALE && !reflect_filter_rate_limit_check(m->stale_prob=
e_limiter))
+        {
+            return PRE_DECRYPT_NO_ACTION;
+        =
}
+
+        /* charged against the reset replies' budget, and only now tha=
t we
+         * know a reply is going out, so probes are capped like reset=
s */
+        if (!reflect_filter_rate_limit_check(m->initial_rate_limiter)=
)
+        {
+            return PRE_DECRYPT_NO_ACTION;
+        }
+
+     =
   struct probe_reply reply =3D { =2Erequest_id =3D req=2Erequest_id };
+
+=
        /* We answer with the handshake's own stateless cookie, so we keep
=
+         * nothing per probe and the reply can later stand in for our rese=
t=2E */
+        struct session_id sid =3D
+            calculate_session_i=
d_hmac(state->peer_session_id, from, hmac_key, handwindow, 0);
+
+        s=
end_probe_reply(m, state, tas, &reply, &sid, sock);
+
+        /* a probe n=
ever creates a session */
+        return PRE_DECRYPT_NO_ACTION;
+    }
 
 =
    /* VERDICT_INVALID */
     return PRE_DECRYPT_NO_ACTION;
diff --git a/s=
rc/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3f514d6=2E=2E862a957 100=
644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -334,6 +334,=
14 @@
     m->new_connection_limiter =3D frequency_limit_init(t->options=2E=
cf_max, t->options=2Ecf_per);
     m->initial_rate_limiter =3D
         ini=
tial_rate_limit_init(t->options=2Ecf_initial_max, t->options=2Ecf_initial_p=
er);
+    /* Answers to stale probe requests get a budget of their own, a t=
wentieth
+     * of the initial packet rate and at least one per period, so=
 that they
+     * cannot crowd out the handshakes the main budget is for=
=2E */
+    m->stale_probe_limiter =3D initial_rate_limit_init(max_int(1, t=
->options=2Ecf_initial_max / 20),
+                                        =
             t->options=2Ecf_initial_per);
+    /* A replayed probe request=
 is what normally runs this budget out, and
+     * saying so in the log on=
 every period would be the flood doing it=2E */
+    m->stale_probe_limiter=
->quiet =3D true;
 
     /*
      * Allocate broadcast/multicast buffer lis=
t
@@ -713,6 +721,7 @@
         ifconfig_pool_free(m->ifconfig_pool);
      =
   frequency_limit_free(m->new_connection_limiter);
         initial_rate_l=
imit_free(m->initial_rate_limiter);
+        initial_rate_limit_free(m->sta=
le_probe_limiter);
         multi_reap_free(m->reaper);
         mroute_hel=
per_free(m->route_helper);
         multi_io_free(m->multi_io);
diff --git =
a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3d2e932=2E=2Eecc7158 =
100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -194,6 +1=
94,8 @@
     struct ifconfig_pool *ifconfig_pool;
     struct frequency_lim=
it *new_connection_limiter;
     struct initial_packet_rate_limit *initial_=
rate_limiter;
+    /** budget for answering probe requests whose timestamp =
is stale */
+    struct initial_packet_rate_limit *stale_probe_limiter;
   =
  struct mroute_helper *route_helper;
     struct multi_reap *reaper;
     =
struct mroute_addr local;
diff --git a/src/openvpn/reflect_filter=2Ec b/src=
/openvpn/reflect_filter=2Ec
index e5226e4=2E=2E5bb1cf4 100644
--- a/src/ope=
nvpn/reflect_filter=2Ec
+++ b/src/openvpn/reflect_filter=2Ec
@@ -44,7 +44,7=
 @@
     if (now > irl->last_period_reset + irl->period_length)
     {
    =
     int64_t dropped =3D irl->curr_period_counter - irl->max_per_period;
- =
       if (dropped > 0)
+        if (dropped > 0 && !irl->quiet)
         {=

             msg(D_TLS_DEBUG_LOW,
                 "Dropped %" PRId64 " in=
itial handshake packets"
@@ -60,7 +60,7 @@
 
     bool over_limit =3D irl->=
curr_period_counter > irl->max_per_period;
 
-    if (over_limit && !irl->w=
arning_displayed)
+    if (over_limit && !irl->warning_displayed && !irl->q=
uiet)
     {
         msg(M_WARN,
             "Note: --connect-freq-initia=
l %" PRId64 " %d rate limit "
@@ -95,6 +95,7 @@
     irl->period_length =3D=
 period_length;
     irl->curr_period_counter =3D 0;
     irl->last_period_=
reset =3D 0;
+    irl->quiet =3D false;
 
     return irl;
 }
diff --git a/=
src/openvpn/reflect_filter=2Eh b/src/openvpn/reflect_filter=2Eh
index 84915=
e8c6=2E=2Efce36b5 100644
--- a/src/openvpn/reflect_filter=2Eh
+++ b/src/ope=
nvpn/reflect_filter=2Eh
@@ -44,6 +44,11 @@
     /* we want to warn once per=
 period that packets are being started to
      * be dropped */
     bool w=
arning_displayed;
+
+    /* drop silently: no warning and no per-period sum=
mary in the log=2E For a
+     * limiter that caps something an attacker ca=
n trigger at will, where the
+     * log messages would only turn the flood=
 into a second flood */
+    bool quiet;
 };
 
 
diff --git a/src/openvpn/s=
sl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index ccb841e=2E=2E7f0e170 100644
--- =
a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -317,7 +317,8 @@=

 
     /* Allow only the reset packet or the first packet of the actual ha=
ndshake=2E */
     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 && op !=3D P_=
CONTROL_HARD_RESET_CLIENT_V3
-        && op !=3D P_CONTROL_V1 && op !=3D P_=
CONTROL_WKC_V1 && op !=3D P_ACK_V1)
+        && op !=3D P_CONTROL_V1 && op =
!=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1
+        && op !=3D P_CONTROL_V2)=

     {
         /*
          * This can occur due to bogus data or DoS pac=
kets=2E
@@ -392,6 +393,10 @@
     {
         return VERDICT_VALID_WKC_V1;
 =
    }
+    else if (op =3D=3D P_CONTROL_V2)
+    {
+        return VERDICT_=
VALID_CONTROL_V2;
+    }
     else
     {
         return VERDICT_VALID_RES=
ET_V2;
@@ -445,6 +450,29 @@
     return buf;
 }
 
+struct buffer
+tls_wrap_=
control_v2_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_stand=
alone *tas,
+                               const struct session_id *own_si=
d, const struct buffer *payload)
+{
+    /* Copy buffer here to point at th=
e same data but allow tls_wrap_control
+     * to potentially change buf to=
 point to another buffer without
+     * modifying the buffer in tas */
+  =
  struct buffer buf =3D tas->workbuf;
+    ASSERT(buf_init(&buf, tas->frame=
=2Ebuf=2Eheadroom));
+
+    /* A P_CONTROL_V2 message is the session id and=
 then the TLVs: no ACK
+     * array and no message id, so the payload goes=
 in as it is=2E */
+    ASSERT(buf_copy(&buf, payload));
+
+    uint8_t hea=
der =3D (uint8_t)(P_CONTROL_V2 << P_OPCODE_SHIFT);
+
+    /* Add tls-auth/t=
ls-crypt wrapping, this might replace buf with
+     * ctx->work */
+    tl=
s_wrap_control(ctx, header, &buf, own_sid);
+
+    return buf;
+}
+
 struct=
 session_id
 calculate_session_id_hmac(struct session_id client_sid, const =
struct openvpn_sockaddr *from,
                           const uint8_t *ke=
y, int handwindow, int offset)
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/o=
penvpn/ssl_pkt=2Eh
index 3b45492=2E=2E4d24437 100644
--- a/src/openvpn/ssl_=
pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -133,6 +133,10 @@
     VERDICT_VAL=
ID_ACK_V1,
     /** The packet is a valid control packet with appended wrap=
ped client key */
     VERDICT_VALID_WKC_V1,
+    /** This packet is a vali=
d P_CONTROL_V2 message, e=2Eg=2E a server probe=2E It
+     * belongs to no=
 session and must not create one; what it carries is for
+     * the caller=
 to work out from its TLVs=2E */
+    VERDICT_VALID_CONTROL_V2,
     /** th=
e packet failed on of the various checks */
     VERDICT_INVALID
 };
@@ -25=
6,6 +260,25 @@
 
 
 /**
+ * Wrap an already-built TLV payload into a standa=
lone P_CONTROL_V2 packet, to
+ * be sent without a session: it prepends the=
 opcode and own_sid and applies
+ * the same tls-auth/tls-crypt wrapping as=
 any other control channel packet,
+ * but writes none of the reliability l=
ayer's fields, which P_CONTROL_V2 does
+ * not have=2E It is to a probe rep=
ly what tls_reset_standalone() is to a reset=2E
+ *
+ * @param ctx       tl=
s wrapping context, from the pre-decrypt state
+ * @param tas       standal=
one auth context, providing the work buffer
+ * @param own_sid   the sessio=
n id to send as ours
+ * @param payload   the TLVs to wrap
+ * @return     =
     the wrapped packet, ready to send
+ */
+struct buffer tls_wrap_control=
_v2_standalone(struct tls_wrap_ctx *ctx,
+                                 =
            const struct tls_auth_standalone *tas,
+                       =
                      const struct session_id *own_sid,
+                  =
                           const struct buffer *payload);
+
+
+/**
  * Extr=
acts a control channel message from buf and adjusts the size of
  * buf aft=
er the message has been extracted
  * @param buf   The buffer the message s=
hould be extracted from
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec =
b/tests/unit_tests/openvpn/test_pkt=2Ec
index 0cb2ea5=2E=2Ec2a4754 100644
-=
-- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/t=
est_pkt=2Ec
@@ -38,6 +38,7 @@
 #include "options=2Eh"
 #include "ssl_backen=
d=2Eh"
 #include "control_msg=2Eh"
+#include "probe=2Eh"
 #include "ssl_pkt=
=2Eh"
 #include "tls_crypt=2Eh"
 
@@ -785,6 +786,119 @@
     free_tas(&tas)=
;
 }
 
+/* Wrap a probe request as a standalone P_CONTROL_V2 with the clien=
t side of a
+ * tls-auth/tls-crypt pair (or with neither), run it through t=
he server's
+ * stateless first-packet path, and check the verdict, the rec=
overed session id
+ * and the payload=2E This is the chain mudp=2Ec walks f=
or a probe=2E */
+static void
+control_v2_standalone_roundtrip(struct tls_a=
uth_standalone *tas_client,
+                                struct tls_aut=
h_standalone *tas_server)
+{
+    struct link_socket_actual from =3D { 0 };=

+    struct tls_pre_decrypt_state state =3D { 0 };
+    struct session_id =
sid =3D { { 0x0b, 1, 2, 3, 4, 5, 6, 0x0b } };
+
+    const struct probe_req=
uest req =3D {
+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,
+        =
=2Etimestamp =3D 0x22446688,
+        =2Eflags =3D PROBE_REQUEST_FLAG_PROBE=
_ONLY,
+    };
+    struct buffer payload =3D alloc_buf(64);
+    assert_tr=
ue(probe_request_write(&payload, &req));
+
+    /* Client side: opcode, ses=
sion id and the wrapping around the bare TLVs,
+     * with none of the rel=
iability layer's fields=2E */
+    struct buffer buf =3D
+        tls_wrap_=
control_v2_standalone(&tas_client->tls_wrap, tas_client, &sid, &payload);
+=
    assert_int_equal((BPTR(&buf))[0] >> P_OPCODE_SHIFT, P_CONTROL_V2);
+
+ =
   /* Server side: the stateless path must take the opcode, verify the
+   =
  * wrapping and leave exactly the TLVs in newbuf, which is what the probe
=
+     * parser is then handed=2E */
+    enum first_packet_verdict verdict =
=3D tls_pre_decrypt_lite(tas_server, &state, &from, &buf);
+    assert_int_=
equal(verdict, VERDICT_VALID_CONTROL_V2);
+    assert_memory_equal(state=2E=
peer_session_id=2Eid, sid=2Eid, SID_SIZE);
+    assert_int_equal(BLEN(&stat=
e=2Enewbuf), BLEN(&payload));
+    assert_memory_equal(BPTR(&state=2Enewbuf=
), BPTR(&payload), BLEN(&payload));
+
+    struct probe_request got =3D { 0=
 };
+    assert_int_equal(probe_request_check(&state=2Enewbuf, req=2Etimest=
amp, 30, &got), PROBE_OK);
+    assert_true(got=2Erequest_id =3D=3D req=2Er=
equest_id);
+    free_tls_pre_decrypt_state(&state);
+
+    /* Flipping any=
 single byte must fail authentication: the flip runs over
+     * the opcod=
e, session id, packet id, HMAC or tag and payload alike=2E Not
+     * for =
TLS_WRAP_NONE, where an altered payload is legitimately accepted=2E */
+   =
 if (tas_server->tls_wrap=2Emode !=3D TLS_WRAP_NONE)
+    {
+        struct=
 buffer copy =3D alloc_buf(BLEN(&buf));
+        for (int i =3D 0; i < BLEN=
(&buf); i++)
+        {
+            buf_reset_len(&copy);
+            buf=
_write(&copy, BPTR(&buf), BLEN(&buf));
+            (BPTR(&copy))[i] ^=3D 0=
xff;
+            struct tls_pre_decrypt_state tstate =3D { 0 };
+         =
   verdict =3D tls_pre_decrypt_lite(tas_server, &tstate, &from, &copy);
+  =
          assert_int_equal(verdict, VERDICT_INVALID);
+            free_tls=
_pre_decrypt_state(&tstate);
+        }
+        free_buf(&copy);
+    }
+
=
+    free_buf(&payload);
+}
+
+static void
+test_control_v2_standalone_plai=
n(void **ut_state)
+{
+    struct tls_auth_standalone tas =3D { 0 };
+    s=
truct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =
=3D 1400 }, 0 };
+    tas=2Eframe =3D frame;
+    tas=2Etls_wrap=2Emode =3D=
 TLS_WRAP_NONE;
+    tas=2Eworkbuf =3D alloc_buf(1600);
+
+    control_v2_s=
tandalone_roundtrip(&tas, &tas);
+
+    free_tas(&tas);
+}
+
+static void
+=
test_control_v2_standalone_tls_auth(void **ut_state)
+{
+    struct tls_aut=
h_standalone tas_server =3D init_tas_auth(KEY_DIRECTION_NORMAL);
+    struc=
t tls_auth_standalone tas_client =3D init_tas_auth(KEY_DIRECTION_INVERSE);
=
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTE=
ST", 0);
+    /* the server only consumes the tls-auth packet id with packe=
t-id state,
+     * which tls_auth_standalone_init() sets up for the real o=
ne */
+    packet_id_init(&tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "=
UNITTEST", 0);
+
+    now =3D 0x22446688;
+    control_v2_standalone_roundt=
rip(&tas_client, &tas_server);
+
+    packet_id_free(&tas_client=2Etls_wrap=
=2Eopt=2Epacket_id);
+    packet_id_free(&tas_server=2Etls_wrap=2Eopt=2Epac=
ket_id);
+    free_tas(&tas_client);
+    free_tas(&tas_server);
+}
+
+stat=
ic void
+test_control_v2_standalone_tls_crypt(void **ut_state)
+{
+    stru=
ct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D =
1400 }, 0 };
+    struct tls_auth_standalone tas_server =3D init_tas_crypt(=
true);
+    struct tls_auth_standalone tas_client =3D init_tas_crypt(false)=
;
+    tas_server=2Eframe =3D frame;
+    tas_client=2Eframe =3D frame;
+  =
  packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST"=
, 0);
+
+    now =3D 0x22446688;
+    control_v2_standalone_roundtrip(&tas_=
client, &tas_server);
+
+    packet_id_free(&tas_client=2Etls_wrap=2Eopt=2E=
packet_id);
+    free_tas(&tas_client);
+    free_tas(&tas_server);
+}
+
 s=
tatic void
 test_extract_control_message(void **ut_state)
 {
@@ -837,6 +951=
,9 @@
         cmocka_unit_test(test_generate_reset_packet_resend_wkc),
   =
      cmocka_unit_test(test_generate_reset_packet_tls_auth),
         cmock=
a_unit_test(test_wkc_not_appended_without_key),
+        cmocka_unit_test(t=
est_control_v2_standalone_plain),
+        cmocka_unit_test(test_control_v2=
_standalone_tls_auth),
+        cmocka_unit_test(test_control_v2_standalone=
_tls_crypt),
         cmocka_unit_test(test_extract_control_message),
     =
    cmocka_unit_test(test_tlv_write_u16_wire_format),
         cmocka_unit_=
test(test_tlv_header_roundtrip),

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-N=
umber: 1744
Gerrit-PatchSet: 22
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipako=
v <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--9HvmJiy03uo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #22</strong> to this=
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
pn=2Enet:29418/openvpn refs/changes/44/1744/22</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 217b299=2E=2E73d=
d1f9 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ =
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
eq;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        enum pro=
be_verdict probe =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            probe_request_check(&amp;state-&gt;newbuf, (uint64_t)now, (uin=
t64_t)handwindow, &amp;req);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (probe =3D=3D PROBE_INVALID)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return PRE_DECRYPT_NO_ACTION;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* a budget of its own for stale requests, so that an u=
nsynchronised</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * clock is not locked out and a replay gets no more than that */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (probe =3D=3D PR=
OBE_STALE &amp;&amp; !reflect_filter_rate_limit_check(m-&gt;stale_probe_lim=
iter))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return PRE_=
DECRYPT_NO_ACTION;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* charged against the=
 reset replies&#39; budget, and only now that we</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * know a reply is going out, so probe=
s are capped like resets */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!reflect_filter_rate_limit_check(m-&gt;initial_rate_lim=
iter))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return PRE_=
DECRYPT_NO_ACTION;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct probe_reply rep=
ly =3D { =2Erequest_id =3D req=2Erequest_id };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* We answer with the handshake&#39;s own stateless cookie,=
 so we keep</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * nothing per probe and the reply can later stand in for our reset=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sessio=
n_id sid =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, h=
andwindow, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        send_probe_reply=
(m, state, tas, &amp;reply, &amp;sid, sock);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* a probe never creates a session */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return PRE_DECRYPT_NO_ACTION;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> =
</span><br><span>     /* VERDICT_INVALID */</span><br><span>     return PRE=
_DECRYPT_NO_ACTION;</span><br><span>diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec</span><br><span>index 3f514d6=2E=2E862a957 100644</span=
><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mu=
lti=2Ec</span><br><span>@@ -334,6 +334,14 @@</span><br><span>     m-&gt;new=
_connection_limiter =3D frequency_limit_init(t-&gt;options=2Ecf_max, t-&gt;=
options=2Ecf_per);</span><br><span>     m-&gt;initial_rate_limiter =3D</spa=
n><br><span>         initial_rate_limit_init(t-&gt;options=2Ecf_initial_max=
, t-&gt;options=2Ecf_initial_per);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Answers to stale probe requests get a budget of their=
 own, a twentieth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * of the initial packet rate and at least one per period, so that they</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cannot crowd o=
ut the handshakes the main budget is for=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    m-&gt;stale_probe_limiter =3D initial_rate_l=
imit_init(max_int(1, t-&gt;options=2Ecf_initial_max / 20),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
                 t-&gt;options=2Ecf_initial_per);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* A replayed probe request is what norma=
lly runs this budget out, and</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * saying so in the log on every period would be the flood do=
ing it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&=
gt;stale_probe_limiter-&gt;quiet =3D true;</span><br><span> </span><br><spa=
n>     /*</span><br><span>      * Allocate broadcast/multicast buffer list<=
/span><br><span>@@ -713,6 +721,7 @@</span><br><span>         ifconfig_pool_=
free(m-&gt;ifconfig_pool);</span><br><span>         frequency_limit_free(m-=
&gt;new_connection_limiter);</span><br><span>         initial_rate_limit_fr=
ee(m-&gt;initial_rate_limiter);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        initial_rate_limit_free(m-&gt;stale_probe_limiter);</sp=
an><br><span>         multi_reap_free(m-&gt;reaper);</span><br><span>      =
   mroute_helper_free(m-&gt;route_helper);</span><br><span>         multi_i=
o_free(m-&gt;multi_io);</span><br><span>diff --git a/src/openvpn/multi=2Eh =
b/src/openvpn/multi=2Eh</span><br><span>index 3d2e932=2E=2Eecc7158 100644</=
span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvp=
n/multi=2Eh</span><br><span>@@ -194,6 +194,8 @@</span><br><span>     struct=
 ifconfig_pool *ifconfig_pool;</span><br><span>     struct frequency_limit =
*new_connection_limiter;</span><br><span>     struct initial_packet_rate_li=
mit *initial_rate_limiter;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /** budget for answering probe requests whose timestamp is stale=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct initi=
al_packet_rate_limit *stale_probe_limiter;</span><br><span>     struct mrou=
te_helper *route_helper;</span><br><span>     struct multi_reap *reaper;</s=
pan><br><span>     struct mroute_addr local;</span><br><span>diff --git a/s=
rc/openvpn/reflect_filter=2Ec b/src/openvpn/reflect_filter=2Ec</span><br><s=
pan>index e5226e4=2E=2E5bb1cf4 100644</span><br><span>--- a/src/openvpn/ref=
lect_filter=2Ec</span><br><span>+++ b/src/openvpn/reflect_filter=2Ec</span>=
<br><span>@@ -44,7 +44,7 @@</span><br><span>     if (now &gt; irl-&gt;last_=
period_reset + irl-&gt;period_length)</span><br><span>     {</span><br><spa=
n>         int64_t dropped =3D irl-&gt;curr_period_counter - irl-&gt;max_pe=
r_period;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
dropped &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (dropped &gt; 0 &amp;&amp; !irl-&gt;quiet)</span><br><span>         =
{</span><br><span>             msg(D_TLS_DEBUG_LOW,</span><br><span>       =
          &quot;Dropped %&quot; PRId64 &quot; initial handshake packets&quo=
t;</span><br><span>@@ -60,7 +60,7 @@</span><br><span> </span><br><span>    =
 bool over_limit =3D irl-&gt;curr_period_counter &gt; irl-&gt;max_per_perio=
d;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (over_limit &amp;&amp; !irl-&gt;warning_displayed)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (over_limit &amp;&amp; !irl-&gt=
;warning_displayed &amp;&amp; !irl-&gt;quiet)</span><br><span>     {</span>=
<br><span>         msg(M_WARN,</span><br><span>             &quot;Note: --c=
onnect-freq-initial %&quot; PRId64 &quot; %d rate limit &quot;</span><br><s=
pan>@@ -95,6 +95,7 @@</span><br><span>     irl-&gt;period_length =3D period=
_length;</span><br><span>     irl-&gt;curr_period_counter =3D 0;</span><br>=
<span>     irl-&gt;last_period_reset =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    irl-&gt;quiet =3D false;</span><br><span> </spa=
n><br><span>     return irl;</span><br><span> }</span><br><span>diff --git =
a/src/openvpn/reflect_filter=2Eh b/src/openvpn/reflect_filter=2Eh</span><br=
><span>index 84915e8c6=2E=2Efce36b5 100644</span><br><span>--- a/src/openvp=
n/reflect_filter=2Eh</span><br><span>+++ b/src/openvpn/reflect_filter=2Eh</=
span><br><span>@@ -44,6 +44,11 @@</span><br><span>     /* we want to warn o=
nce per period that packets are being started to</span><br><span>      * be=
 dropped */</span><br><span>     bool warning_displayed;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* drop silently: no warning and no per-period summar=
y in the log=2E For a</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * limiter that caps something an attacker can trigger at will, where=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * log mess=
ages would only turn the flood into a second flood */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool quiet;</span><br><span> };</span=
><br><span> </span><br><span> </span><br><span>diff --git a/src/openvpn/ssl=
_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index ccb841e=2E=2E7f0e1=
70 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++=
 b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -317,7 +317,8 @@</span><br><s=
pan> </span><br><span>     /* Allow only the reset packet or the first pack=
et of the actual handshake=2E */</span><br><span>     if (op !=3D P_CONTROL=
_HARD_RESET_CLIENT_V2 &amp;&amp; op !=3D P_CONTROL_HARD_RESET_CLIENT_V3</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; op !=
=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_A=
CK_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;=
&amp; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; o=
p !=3D P_ACK_V1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    &amp;&amp; op !=3D P_CONTROL_V2)</span><br><span>     {</span><br><span=
>         /*</span><br><span>          * This can occur due to bogus data o=
r DoS packets=2E</span><br><span>@@ -392,6 +393,10 @@</span><br><span>     =
{</span><br><span>         return VERDICT_VALID_WKC_V1;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (op =
=3D=3D P_CONTROL_V2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n VERDICT_VALID_CONTROL_V2;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span>     else</span><br><span>     {</span><br><s=
pan>         return VERDICT_VALID_RESET_V2;</span><br><span>@@ -445,6 +450,=
29 @@</span><br><span>     return buf;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_wrap_control_v2_stand=
alone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
       const struct session_id *own_sid, const struct buffer *payload)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer here to point at the s=
ame data but allow tls_wrap_control</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * to potentially change buf to point to another buffer=
 without</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modi=
fying the buffer in tas */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer buf =3D tas-&gt;workbuf;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;buf, tas-&gt;frame=
=2Ebuf=2Eheadroom));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A P_CONTROL=
_V2 message is the session id and then the TLVs: no ACK</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * array and no message id, so the =
payload goes in as it is=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(buf_copy(&amp;buf, payload));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint8_t header =3D (uint8_t)(P_CONTROL_V2 &lt;&lt; P_OPC=
ODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Add tls-auth/tls-cry=
pt wrapping, this might replace buf with</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * ctx-&gt;work */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    tls_wrap_control(ctx, header, &amp;buf, own_sid=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return buf;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> struct session_id</span><br><span> calcu=
late_session_id_hmac(struct session_id client_sid, const struct openvpn_soc=
kaddr *from,</span><br><span>                           const uint8_t *key,=
 int handwindow, int offset)</span><br><span>diff --git a/src/openvpn/ssl_p=
kt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 3b45492=2E=2E4d24437=
 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b=
/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -133,6 +133,10 @@</span><br><sp=
an>     VERDICT_VALID_ACK_V1,</span><br><span>     /** The packet is a vali=
d control packet with appended wrapped client key */</span><br><span>     V=
ERDICT_VALID_WKC_V1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /** This packet is a valid P_CONTROL_V2 message, e=2Eg=2E a server pro=
be=2E It</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * belo=
ngs to no session and must not create one; what it carries is for</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * the caller to work out=
 from its TLVs=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    VERDICT_VALID_CONTROL_V2,</span><br><span>     /** the packet failed o=
n of the various checks */</span><br><span>     VERDICT_INVALID</span><br><=
span> };</span><br><span>@@ -256,6 +260,25 @@</span><br><span> </span><br><=
span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Wrap an already-built TLV payload into a standalone P_CONTROL_V2=
 packet, to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * be se=
nt without a session: it prepends the opcode and own_sid and applies</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * the same tls-auth/tls-c=
rypt wrapping as any other control channel packet,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * but writes none of the reliability layer&=
#39;s fields, which P_CONTROL_V2 does</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * not have=2E It is to a probe reply what tls_reset_stan=
dalone() is to a reset=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c=
tx       tls wrapping context, from the pre-decrypt state</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param tas       standalone auth c=
ontext, providing the work buffer</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param own_sid   the session id to send as ours</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param payload   the TLVs t=
o wrap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return   =
       the wrapped packet, ready to send</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct buffer tls_wrap_control_v2_standalone(struct tls_wrap_ctx *ctx,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                          const struct tls_auth_standalone *tas,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
               const struct session_id *own_sid,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                             c=
onst struct buffer *payload);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Extr=
acts a control channel message from buf and adjusts the size of</span><br><=
span>  * buf after the message has been extracted</span><br><span>  * @para=
m buf   The buffer the message should be extracted from</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/=
test_pkt=2Ec</span><br><span>index 0cb2ea5=2E=2Ec2a4754 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -38,6 +38,7 @@</span><b=
r><span> #include &quot;options=2Eh&quot;</span><br><span> #include &quot;s=
sl_backend=2Eh&quot;</span><br><span> #include &quot;control_msg=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;probe=
=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><spa=
n> #include &quot;tls_crypt=2Eh&quot;</span><br><span> </span><br><span>@@ =
-785,6 +786,119 @@</span><br><span>     free_tas(&amp;tas);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Wrap a probe request as a standalone P_CONTROL_V2 with the client side=
 of a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tls-auth/tl=
s-crypt pair (or with neither), run it through the server&#39;s</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * stateless first-packet path,=
 and check the verdict, the recovered session id</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * and the payload=2E This is the chain mudp=
=2Ec walks for a probe=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+control_v2_standalone_roundtrip(struct tls_auth_standalone *tas_client,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
          struct tls_auth_standalone *tas_server)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct link_socket_actual from =3D { 0 };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct tls_pre_decrypt_state stat=
e =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct session_id sid =3D { { 0x0b, 1, 2, 3, 4, 5, 6, 0x0b } };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const struct probe_request req =3D {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0xdead=
beefcafef00dULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     =2Etimestamp =3D 0x22446688,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        =2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D alloc_buf(6=
4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
probe_request_write(&amp;payload, &amp;req));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Client side: opcode, session id and the wrapping around the b=
are TLVs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * wit=
h none of the reliability layer&#39;s fields=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_control_v2_standalone=
(&amp;tas_client-&gt;tls_wrap, tas_client, &amp;sid, &amp;payload);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal((BPTR(=
&amp;buf))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_V2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Server side: the stateless path must take the opcode,=
 verify the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * w=
rapping and leave exactly the TLVs in newbuf, which is what the probe</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * parser is then han=
ded=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum f=
irst_packet_verdict verdict =3D tls_pre_decrypt_lite(tas_server, &amp;state=
, &amp;from, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(verdict, VERDICT_VALID_CONTROL_V2);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(state=2Epe=
er_session_id=2Eid, sid=2Eid, SID_SIZE);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;state=2Enewbuf), BLEN(&=
amp;payload));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_memory_equal(BPTR(&amp;state=2Enewbuf), BPTR(&amp;payload), BLEN(&amp=
;payload));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct probe_request go=
t =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(probe_request_check(&amp;state=2Enewbuf, req=2Etimestamp, 30,=
 &amp;got), PROBE_OK);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(got=2Erequest_id =3D=3D req=2Erequest_id);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_state(&a=
mp;state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Flipping any single b=
yte must fail authentication: the flip runs over</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * the opcode, session id, packet id, HMAC=
 or tag and payload alike=2E Not</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * for TLS_WRAP_NONE, where an altered payload is legitima=
tely accepted=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (tas_server-&gt;tls_wrap=2Emode !=3D TLS_WRAP_NONE)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct buffer copy =3D alloc_buf(BLEN(&amp=
;buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for =
(int i =3D 0; i &lt; BLEN(&amp;buf); i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            buf_reset_len(&amp;copy);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            buf_write(&amp;copy, BPTR(&amp;bu=
f), BLEN(&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            (BPTR(&amp;copy))[i] ^=3D 0xff;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            struct tls_pre_decrypt_state tstate =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   verdict =3D tls_pre_decrypt_lite(tas_server, &amp;tstate, &amp;from, &am=
p;copy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 assert_int_equal(verdict, VERDICT_INVALID);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            free_tls_pre_decrypt_state(&amp;tstate=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        free_buf(&amp;copy)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    free_buf(&amp;payload);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_contro=
l_v2_standalone_plain(void **ut_state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct tls_auth_standalone tas =3D { 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2Ehea=
droom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_N=
ONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eworkb=
uf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    control_v2_=
standalone_roundtrip(&amp;tas, &amp;tas);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    free_tas(&amp;tas);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_control_v2_standalone_tls_auth(vo=
id **ut_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_sta=
ndalone tas_server =3D init_tas_auth(KEY_DIRECTION_NORMAL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_=
client =3D init_tas_auth(KEY_DIRECTION_INVERSE);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_client=2Etls_wrap=
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
none"> Gerrit-PatchSet: 22 </div>
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
--9HvmJiy03uo=--


--===============8210808822291717026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8210808822291717026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8210808822291717026==--

