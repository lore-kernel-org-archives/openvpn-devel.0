Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4F7C88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rcu9LHqq/yMyg5up/a4rrba1LmpTi1yncTl2rp6EOwo=; b=FcvbMoRP63e4KtGqLoQdoQ+I6k
	fs6dPpPSQZe5wcwAD0DE5I112UhEb2Q8ARUwMaz9Ofc1iO+6XcKEmrVg7162VEra60lhu74LLVNhM
	PIZhLq6moEirDUJY1lsrn2Asrn8lc0CHGOGGojqAn2uI+U7XYwobemZEmVZydZsPlQrw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6SlD-0002om-Cs;
	Tue, 15 Sep 2026 12:59:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6SlC-0002oe-4j
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9CpCmnWGiuGP4YDaRf+W5fW/qMwn/LZ88ys/sd5qpLY=; b=HutIfug+b4es1DUhBVnIkNR2Fy
 7KNgXHKcOeyhMt7jhGV0ADyqNvkLmWKxApVC+6yOTaxfpC87JY5xkBKdH7By3evaNRrdvvVcHRPcK
 2g7WYRhYQlxgqmEePDgXGQqW2IEHOYjjwhd85YYIvQEOwAj0BXspl2MUYGjEBnrRHRhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9CpCmnWGiuGP4YDaRf+W5fW/qMwn/LZ88ys/sd5qpLY=; b=G
 sG0zAs46spD6ykmmGoahyd5gdLGf99Ekm2e9BUHkJZoTqMk4ompmSf49xaMvtoZfHehOmczNpVjx0
 wzYCODieSZoGxFO1iTXfMz9v/Ky6YGlmsnMfPmKX4ZBLSd8pWwGgCPgWpTCZHjWRgy9I20qvqIulN
 cE4B7WU84OINndT0=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6Sl7-0002ja-0Q for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:42 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48439feca17so218527f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789477170; x=1790081970; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9CpCmnWGiuGP4YDaRf+W5fW/qMwn/LZ88ys/sd5qpLY=;
 b=YAZ6k/422GqWYVFPdeyZ99O2g0qiB8aVTDeNnlrysJAithrqMVSzwcI0ClX6pEc0nS
 PLGWzvbV1VFh9UG21bExT0kYmjWtIBLkL6mERv0KQzj+cxbUgmzokZu+Q4W/CMD33XcA
 XbRkb+4qiFNDXwNVKicmjEtqOYA9eBVg7M25I2v2ND+OO7ZKskDWaN46szCfMJWLxzPp
 W9o4EAYYz3iiqiylk7S0ER1pnD7EZn2T4/uAo2H4jTKLICC3sQAQk7ASpZteT7ILDHvm
 FIVbyIqgTipMk+LM1jJAnsZfhGlneNng7QmBflu/S6NzXjZWhHIbQO6BwCVIF52LJsVD
 ambw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789477170; x=1790081970;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9CpCmnWGiuGP4YDaRf+W5fW/qMwn/LZ88ys/sd5qpLY=;
 b=ygJB6sn+30a4FBusFfZY0PrhSfYH/RtwaiHu/hIPZZPsTorMJXAVPAMDXUK+PuPiHP
 z6ncJKffuuUpkR6XZJ2cBAvmlii3uTwusgENHH5BvRKjwF2Iu4H1EF9fRiAGeMl2kW35
 jLcf8CpTL/QMx2X3mbHfhEWvrbuQrrKfPqSkTSA8M8rDmhEFrMkRoOM27SAxD+87U5fC
 YjCI7ER9zMNgyU7t0RDjcG/v7uYGclfxSVTvt42rJ7Mlcl+tQIro7i431XpJIuVPzb9A
 ofLTZ9d156t11o5LKywBUiX99qSVr3fKBxdSod+fsLcysEV2KtAwLo+d3e/l+S7Lzv+f
 GlnA==
X-Gm-Message-State: AFuF++ktrDCJ5PLyECerv4Lq+TujGgwfTd0eL32fCM4pAdnespUKAoMz
 qkrpd20dyK2+iEl100UvVQzzlpwy7yc/VIIj1AozdcC7EdWDKGZ3jDcdSp+41ALSiNvOTWIIGt3
 hhij5B5QtAulaOwuuNpyTkkqR29vDaE5QnpN0bmet3Vj5UnaVHhhCPrwV4GIuqG04/eFM
X-Gm-Gg: AYBFou062VEZyNQY/LaFQZI/bg/q3mpgAioovJrFokt6QaH1HvQpm1kTFQUnZBoUSIu
 GkSs2F6JkBII6Cjt8wbGpBn9OFn0XbXTUyiLCv3viPlEL83Qm3jj5wXk2c4MLsr7BmcS3AUAJKH
 4NA4BK6GN6AvpprAmYt8MkObHcglYUYsihAwwsuU+DSMP+RbgRWw8DwI6EQE5i3VBM66y/7Aq3Y
 7AIaZ2L0g4TNkGNbVc2gjOtewYwONZsbgeXlIsD2LCqJM6fvNgLiVuuDErsYgCpifaPA/+s8yFX
 ckBCJNi0wxDC+YgG/Wiul51Pe0XyrNOBCCtWJ2708VrfxLWwAIaZgzyozvebEkrPpVu5Mae5KEi
 E8Qon+kKf82nbJCmJ16Nc875i9QFMVjBYAgcRt1Nu/3dZFQzhHsXlUigMMutK4139QfTGOofu1k
 EdOO9NVuK5czKa0g9yxLemtWMRxBGK5t05rHsnTIaD7naXTufLpms5XcKlA9+hXtwygqv98Vx4r
 hTRJddrHkhE4dZGtsu73m1OgnxA6iiCvCgJEl0ZgEQ3hzpn59tLhJmMnkj3zJe09tE3LhUjZQmu
 7J5xyzZiSAgvB/o7hai28osBtWqDwYkXBiqEMDBd75Gs/hUd00wwx/njAVN+cJg=
X-Received: by 2002:a05:6000:4b19:b0:485:aabb:af2b with SMTP id
 ffacd0b85a97d-4870a97c49cmr898839f8f.24.1789477170128; 
 Tue, 15 Sep 2026 05:59:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecf23sm35406297f8f.5.2026.09.15.05.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:59:29 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 12:59:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: fef050d631e4f3c467777a59a8f495251ceac0fa
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <493abf8ad3f9b514fe50a8c395ff177340091bbd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6Sl7-0002ja-0Q
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Wrap the client
 SERVER_PROBE with tls-auth/tls-crypt
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8841773612881565726=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8841773612881565726==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q59Hb54zQto="; charset=UTF-8

--Q59Hb54zQto=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail

to look at the n=
ew patch set (#22)=2E


Change subject: oob: Wrap the client SERVER_PROBE w=
ith tls-auth/tls-crypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

oob: Wrap the client SERVER_PROBE with tls-auth/tls-crypt

The c=
lient --server-probe previously sent a plaintext SERVER_PROBE and
parsed re=
plies by hand, so it only worked against a server with no
control-channel w=
rapping=2E Build a standalone wrapping context for the
probe (mirroring the=
 server's tls_auth_standalone) and route both the
outgoing probe and the in=
coming replies through the same control-channel
path the rest of the code u=
ses:

  - tls_wrap_oob_standalone() wraps the probe payload, applying the
 =
   tls-auth HMAC or tls-crypt encryption (or nothing, when neither is
    c=
onfigured)=2E
  - read_control_auth() unwraps each reply, verifying the HMA=
C /
    decrypting and stripping the opcode + session id, on a per-packet
 =
   copy of the wrapping context (as tls_pre_decrypt_lite() does)=2E It
    =
decrypts in place, so oob_probe_handle_reply() now takes a mutable
    buff=
er=2E

With neither tls-auth nor tls-crypt configured the context stays in
=
TLS_WRAP_NONE and the on-wire probe is byte-for-byte identical to
before, s=
o the plaintext case is unchanged=2E

tls-crypt-v2 is not supported yet: th=
e server only learns the client key
from the WKc carried in the TLS handsha=
ke, which an out-of-band probe
cannot provide=2E Such configurations skip p=
robing and keep the configured
remote order=2E

The probe is wrapped with t=
he key of the first remote we can probe --
the same entry the other probed =
remotes are compared against -- so
probing is declined when another one of =
them is keyed differently=2E The
key material loaded for the probe is relea=
sed afterwards; init loads it
again for the connection=2E

Change-Id: I1f9d=
7b5a5ec19bf77c0c212795f583c5ba4c03ac
Signed-off-by: Lev Stipakov <lev@openv=
pn=2Enet>
---
M doc/man-sections/client-options=2Erst
M src/openvpn/oob_cli=
ent=2Ec
2 files changed, 176 insertions(+), 40 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/1750/22

diff --gi=
t a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=
=2Erst
index aeeea37=2E=2Ead43819 100644
--- a/doc/man-sections/client-opti=
ons=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -620,20 +620,22 @@=

   priority group a candidate, since replies only arrive within the
   one=
-second probe window; the group is then ordered by weight alone=2E
 
-  The=
 probe is currently sent without control-channel wrapping, so it only
-  wo=
rks against a server configured without ``--tls-auth``,
-  ``--tls-crypt`` =
or ``--tls-crypt-v2``=2E
+  The probe carries the same control-channel wrap=
ping as a normal
+  connection (``--tls-auth`` or ``--tls-crypt``, when con=
figured)=2E With
+  ``--tls-crypt-v2`` the remotes are left in their config=
ured order,
+  because the server cannot unwrap an out-of-band probe yet=2E=

 
   Only UDP remotes are probed, and only when there are at least two
   =
remotes; remotes reached through a SOCKS proxy are not probed=2E The
   pro=
bes are sent from one socket per address family, set up like the
   connect=
ion socket of the first remote that can be probed; all probed
   remotes mu=
st therefore share its local bind settings (``--local``,
-  ``--lport``, ``=
--bind``), otherwise probing is skipped and the
-  configured order is used=
=2E Remotes that answered are tried first, in the
-  order described above;=
 all other remotes, including TCP ones, follow in
-  their configured order=
=2E Probing runs once per process, before the first
-  connection attempt; =
a reconnect or a SIGUSR1 restart does not probe again=2E
+  ``--lport``, ``=
--bind``) and control-channel key, otherwise probing is
+  skipped and the =
configured order is used=2E
+  Remotes that answered are tried first, in th=
e order described above;
+  all other remotes, including TCP ones, follow i=
n their configured
+  order=2E Probing runs once per process, before the fi=
rst connection
+  attempt; a reconnect or a SIGUSR1 restart does not probe =
again=2E
 
   Probing delays the first connection attempt by up to one seco=
nd, plus
   the time needed to resolve each remote=2E A server only answers=
 a probe
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=
=2Ec
index 61e2602=2E=2E5a3042a 100644
--- a/src/openvpn/oob_client=2Ec
+++=
 b/src/openvpn/oob_client=2Ec
@@ -29,6 +29,8 @@
 #include "oob_client=2Eh"
=
 #include "openvpn=2Eh"
 #include "oob=2Eh"
+#include "init=2Eh"
+#include =
"ssl=2Eh"
 #include "ssl_pkt=2Eh"
 #include "session_id=2Eh"
 #include "soc=
ket=2Eh"
@@ -79,21 +81,78 @@
     return (af =3D=3D AF_INET6) ? PROBE_AF_V6=
 : PROBE_AF_V4;
 }
 
-/* Build a plaintext SERVER_PROBE packet:
- *   [opco=
de | key_id=3D0] [client session id] [SERVER_PROBE message]
- * This is the=
 unauthenticated OOB wire format; adding tls-auth/tls-crypt
- * wrapping fo=
r the probe is a follow-up (it only works against a server with
- * no cont=
rol-channel wrapping for now)=2E */
-static bool
-oob_probe_build_packet(st=
ruct buffer *buf, const struct session_id *client_sid)
+static bool oob_pro=
be_eligible(const struct connection_entry *ce);
+
+/* Build a standalone co=
ntrol-channel wrapping context for the probe, mirroring
+ * the tls_auth_st=
andalone the server uses to answer it=2E With neither tls-auth
+ * nor tls-=
crypt configured the context stays in TLS_WRAP_NONE and the probe is
+ * se=
nt in plaintext, exactly as before; with either configured the probe is
+ *=
 authenticated/encrypted like any other control packet=2E Returns NULL (and=

+ * logs) for configurations the probe cannot wrap yet, in which case the =
caller
+ * skips probing and keeps the configured remote order=2E */
+stati=
c struct tls_auth_standalone *
+oob_probe_init_tls_auth_standalone(struct c=
ontext *c, struct gc_arena *gc)
 {
-    const struct oob_probe_parameter pa=
ram =3D {
-        =2Etimestamp =3D (uint64_t)now,
-        =2Eflags =3D 0,=

-    };
-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHI=
FT);
-    return buf_write_u8(buf, header) && session_id_write(client_sid, =
buf)
-           && oob_server_probe_write(buf, &param);
+    /* Wrap with =
the first entry we can actually probe: that is the entry every
+     * othe=
r probed remote is checked against, so the key on the wire is the one
+    =
 * they were checked for=2E Falls back to entry 0 when nothing is probeable=
,
+     * in which case the caller bails out before anything is sent=2E */
=
+    const struct connection_list *l =3D c->options=2Econnection_list;
+   =
 const struct connection_entry *ce =3D l->array[0];
+    for (int i =3D 0; =
i < l->len; i++)
+    {
+        if (oob_probe_eligible(l->array[i]))
+    =
    {
+            ce =3D l->array[i];
+            break;
+        }
+    =
}
+
+    /* tls-crypt-v2 wraps with a per-client key the server only learns=
 from the
+     * wrapped client key (WKc) carried in the TLS handshake=2E =
An out-of-band
+     * probe carries no WKc, so the server cannot unwrap it=
; skip probing rather
+     * than send something unverifiable=2E */
+    i=
f (ce->tls_crypt_v2_file)
+    {
+        msg(D_LOW, "server-probe: not sup=
ported with tls-crypt-v2; using configured order");
+        return NULL;
+=
    }
+
+    /* Load the tls-auth/tls-crypt key material into c->c1=2Eks (a=
 no-op if neither
+     * is configured)=2E This is run again per-connectio=
n later; calling it early
+     * here is harmless=2E */
+    do_init_tls_w=
rap_key(c, ce);
+
+    struct tls_options to;
+    CLEAR(to);
+    init_tls=
_wrap_ctx(&to=2Etls_wrap, ce, c->options=2Etls_client, &c->c1=2Eks, &c->c1=
=2Epid_persist);
+    to=2Ereplay_window =3D c->options=2Ereplay_window;
+ =
   to=2Ereplay_time =3D c->options=2Ereplay_time;
+
+    struct tls_auth_st=
andalone *tas =3D tls_auth_standalone_init(&to, gc);
+
+    /* Control-chan=
nel frame and work buffers, mirroring do_init_frame_tls()=2E */
+    tls_in=
it_control_channel_frame_parameters(&tas->frame, ce->tls_mtu);
+    tas->tl=
s_wrap=2Ework =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+    tas->workbu=
f =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+
+    return tas;
+}
+
+/* =
Release the probe's wrapping context and the key material
+ * do_init_tls_w=
rap_key() loaded for it: do_init_crypto_tls_c1() loads the same
+ * fields =
again later without freeing them first=2E */
+static void
+oob_probe_free_w=
rap(struct context *c, struct tls_auth_standalone *tas)
+{
+    tls_auth_st=
andalone_free(tas);
+    free_key_ctx_bi(&c->c1=2Eks=2Etls_wrap_key);
+    =
CLEAR(c->c1=2Eks=2Etls_wrap_key);
+    buf_clear(&c->c1=2Eks=2Etls_crypt_v2=
_wkc);
+    free_buf(&c->c1=2Eks=2Etls_crypt_v2_wkc);
+    /* the raw key b=
ytes too: do_init_crypto_tls_c1() may never load a key over
+     * them, s=
o they would otherwise stay resident for the process lifetime */
+    secur=
e_memzero(&c->c1=2Eks=2Eoriginal_wrap_keydata, sizeof(c->c1=2Eks=2Eoriginal=
_wrap_keydata));
 }
 
 /* The local address and port ce's connection socket=
 binds: its first --local,
@@ -156,6 +215,22 @@
            && str_equal_or=
_both_null(port_a, port_b);
 }
 
+/* Do a and b wrap the control channel wi=
th the same key (--tls-auth,
+ * --tls-crypt, --tls-crypt-v2 and key direct=
ion)? The one probe is wrapped with
+ * the first probeable entry's key, so=
 a server keyed differently could never
+ * answer it=2E */
+static bool
+o=
ob_probe_same_wrap(const struct connection_entry *a, const struct connectio=
n_entry *b)
+{
+    return str_equal_or_both_null(a->tls_auth_file, b->tls_=
auth_file)
+           && a->tls_auth_file_inline =3D=3D b->tls_auth_file_i=
nline
+           && a->key_direction =3D=3D b->key_direction
+           &=
& str_equal_or_both_null(a->tls_crypt_file, b->tls_crypt_file)
+           =
&& a->tls_crypt_file_inline =3D=3D b->tls_crypt_file_inline
+           && =
str_equal_or_both_null(a->tls_crypt_v2_file, b->tls_crypt_v2_file)
+       =
    && a->tls_crypt_v2_file_inline =3D=3D b->tls_crypt_v2_file_inline;
+}
+=

 /* Resolve the local bind address of ce's connection socket; NULL with --=
nobind=2E
  * Fatal on failure, like the link socket=2E */
 static struct a=
ddrinfo *
@@ -250,9 +325,9 @@
 /* Parse one received datagram as a PROBE_RE=
PLY and, if valid and matching one
  * of the probes we sent, record the re=
ply in results=2E */
 static void
-oob_probe_handle_reply(const uint8_t *da=
ta, int len, const struct session_id *client_sid,
-                       c=
onst struct openvpn_sockaddr *from, const struct oob_probe_target *targets,=

-                       struct oob_probe_result *results, int n)
+oob_prob=
e_handle_reply(uint8_t *data, int len, const struct session_id *client_sid,=

+                       const struct tls_wrap_ctx *base_wrap, const struct=
 openvpn_sockaddr *from,
+                       const struct oob_probe_tar=
get *targets, struct oob_probe_result *results, int n)
 {
     /* Need at l=
east the opcode byte and the session id=2E */
     if (len < 1 + (int)SID_S=
IZE || (data[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
@@ -262,7 +337,20=
 @@
 
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)len);
-=
    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + server session id */
=
+
+    /* Unwrap the reply with the same control-channel path the server us=
ed to
+     * wrap it: this verifies the tls-auth HMAC / decrypts tls-crypt=
, and (in all
+     * modes) strips the opcode + server session id, leaving=
 buf at the TLV
+     * payload=2E With no tls-auth/tls-crypt it just strip=
s those header bytes, as
+     * before=2E read_control_auth() mutates the =
wrapping context, so we work on a
+     * per-packet copy (as tls_pre_decry=
pt_lite() does on the server)=2E The peer
+     * address is only used for =
log messages, and tls_options only for
+     * tls-crypt-v2 metadata checks=
, so both are passed as NULL=2E */
+    struct tls_wrap_ctx wrap =3D *base_=
wrap;
+    if (!read_control_auth(&buf, &wrap, NULL, NULL))
+    {
+       =
 return; /* not for us, or failed authentication */
+    }
 
     struct oo=
b_probe_reply reply;
     if (!oob_client_reply_read(&buf, &reply))
@@ -314=
,8 +402,9 @@
  * matches a probe we sent=2E Returns true if every sent prob=
e has been answered=2E */
 static bool
 oob_probe_receive_slice(const struc=
t probe_ctx *pc, const struct timeval *deadline,
-                        c=
onst struct session_id *client_sid, const struct oob_probe_target *targets,=

-                        struct oob_probe_result *results, int n, int outs=
tanding)
+                        const struct session_id *client_sid, cons=
t struct tls_wrap_ctx *wrap,
+                        const struct oob_prob=
e_target *targets, struct oob_probe_result *results, int n,
+              =
          int outstanding)
 {
     while (true)
     {
@@ -365,7 +454,7 @@
=
                                     (struct sockaddr *)&from, &fromlen);
 =
            if (len > 0)
             {
-                oob_probe_handle_r=
eply(data, len, client_sid, &from, targets, results, n);
+                o=
ob_probe_handle_reply(data, len, client_sid, wrap, &from, targets, results,=
 n);
             }
         }
         if (oob_count_answered(targets, res=
ults, n) >=3D outstanding)
@@ -418,8 +507,8 @@
  * once the window elapses =
or every sent probe has been answered=2E */
 static void
 oob_probe_collect=
(struct probe_ctx *pc, const struct buffer *probe,
-                  const=
 struct session_id *client_sid, struct oob_probe_target *targets,
-        =
          struct oob_probe_result *results, int n,
+                  const=
 struct session_id *client_sid, const struct tls_wrap_ctx *wrap,
+         =
         struct oob_probe_target *targets, struct oob_probe_result *results=
, int n,
                   const struct signal_info *sig)
 {
     /* numbe=
r of probes we actually sent: stop early once they all answer */
@@ -444,7 =
+533,7 @@
             deadline=2Etv_usec -=3D 1000000;
         }
 
-     =
   if (oob_probe_receive_slice(pc, &deadline, client_sid, targets, results,=
 n, want)
+        if (oob_probe_receive_slice(pc, &deadline, client_sid, w=
rap, targets, results, n, want)
             || sig->signal_received)
     =
    {
             return; /* all answered, or we are being told to stop */=

@@ -487,6 +576,16 @@
 
     struct gc_arena gc =3D gc_new();
 
+    /* Wra=
pping context for the probe (tls-auth/tls-crypt, or plaintext if
+     * ne=
ither)=2E NULL means this configuration cannot be probed; keep the
+     * =
configured order=2E */
+    struct tls_auth_standalone *tas =3D oob_probe_i=
nit_tls_auth_standalone(c, &gc);
+    if (!tas)
+    {
+        gc_free(&gc=
);
+        return;
+    }
+
     /* A single random session id identifies =
all of our probes; servers echo it
      * back in the reply's peer_session=
_id, letting us reject spoofed replies=2E */
     struct session_id client_=
sid;
@@ -508,11 +607,21 @@
             tmpl =3D ce;
             continue;=

         }
+        const char *differs =3D NULL;
         if (!oob_probe_=
same_bind(tmpl, ce, &c->options))
         {
-            msg(D_LOW, "serve=
r-probe: %s:%s binds differently from %s:%s;"
+            differs =3D "bin=
ds";
+        }
+        else if (!oob_probe_same_wrap(tmpl, ce))
+        =
{
+            differs =3D "wraps the control channel";
+        }
+       =
 if (differs)
+        {
+            msg(D_LOW, "server-probe: %s:%s %s di=
fferently from %s:%s;"
                        " not probing, using configu=
red order",
-                ce->remote, ce->remote_port, tmpl->remote, tmp=
l->remote_port);
+                ce->remote, ce->remote_port, differs, tmp=
l->remote, tmpl->remote_port);
+            oob_probe_free_wrap(c, tas);
  =
           gc_free(&gc);
             return;
         }
@@ -520,6 +629,7 @=
@
     if (!tmpl)
     {
         msg(D_LOW, "server-probe: no remote can b=
e probed; using configured order");
+        oob_probe_free_wrap(c, tas);
 =
        gc_free(&gc);
         return;
     }
@@ -528,17 +638,39 @@
     st=
ruct oob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l->len, tru=
e, &gc);
     struct oob_probe_result *results =3D gc_malloc(sizeof(*result=
s) * l->len, true, &gc);
 
-    struct buffer probe =3D alloc_buf_gc(256, &=
gc);
-    if (!oob_probe_build_packet(&probe, &client_sid))
+    /* Build t=
he probe once and reuse the same bytes for every remote and for
+     * res=
ends: the SERVER_PROBE payload is a single probe_parameter TLV, wrapped
+  =
   * (or sent in plaintext) like any other control packet=2E The client ses=
sion
+     * id is prepended as the sender session id=2E */
+    struct buf=
fer payload =3D alloc_buf_gc(64, &gc);
+    const struct oob_probe_paramete=
r param =3D {
+        =2Etimestamp =3D (uint64_t)now,
+        =2Eflags =
=3D 0,
+    };
+    if (!oob_server_probe_write(&payload, &param))
     {
-=
        msg(D_LOW, "server-probe: could not build probe packet; using confi=
gured order");
+        msg(D_LOW, "server-probe: could not build probe pay=
load; using configured order");
         oob_probe_sockets_close(&pc);
+   =
     oob_probe_free_wrap(c, tas);
         gc_free(&gc);
         return;
 =
    }
 
-    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms wi=
ndow", l->len,
-        OOB_PROBE_WINDOW_MS);
+    struct buffer probe =3D =
tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_sid, &payload);
+    i=
f (!BLEN(&probe))
+    {
+        msg(D_LOW, "server-probe: could not wrap =
probe packet; using configured order");
+        oob_probe_sockets_close(&p=
c);
+        oob_probe_free_wrap(c, tas);
+        gc_free(&gc);
+        r=
eturn;
+    }
+
+    const char *wrap_name =3D (tas->tls_wrap=2Emode =3D=3D=
 TLS_WRAP_CRYPT)  ? "tls-crypt"
+                            : (tas->tls_wr=
ap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
+                             =
                                       : "none (plaintext)";
+    msg(D_LOW=
, "server-probe: probing %d remote(s) with a %d ms window, control-channel =
wrapping: %s",
+        l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 
     /* =
Resolve every remote first, so only the address families actually in use
  =
    * get a probe socket=2E */
@@ -585,6 +717,7 @@
         {
             =
freeaddrinfo(bind_local);
         }
+        oob_probe_free_wrap(c, tas);
=
         gc_free(&gc);
         return;
     }
@@ -646,7 +779,7 @@
 
     i=
f (sent_count > 0)
     {
-        oob_probe_collect(&pc, &probe, &client_s=
id, targets, results, l->len,
+        oob_probe_collect(&pc, &probe, &clie=
nt_sid, &tas->tls_wrap, targets, results, l->len,
                         =
  c->sig);
     }
     oob_probe_sockets_close(&pc);
@@ -694,5 +827,6 @@
  =
   msg(M_INFO, "server-probe: %d of %d probed remote(s) answered; connectin=
g best-first",
         responded, sent_count);
 
+    oob_probe_free_wrap(=
c, tas);
     gc_free(&gc);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1750?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Gerrit-Change-Numb=
er: 1750
Gerrit-PatchSet: 22
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf=
_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>

--Q59Hb54zQto=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #22</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">oob: Wrap the client SERVER_PROBE with tls-auth/tls-crypt<br><br>The c=
lient --server-probe previously sent a plaintext SERVER_PROBE and<br>parsed=
 replies by hand, so it only worked against a server with no<br>control-cha=
nnel wrapping=2E Build a standalone wrapping context for the<br>probe (mirr=
oring the server&#39;s tls_auth_standalone) and route both the<br>outgoing =
probe and the incoming replies through the same control-channel<br>path the=
 rest of the code uses:<br><br>  - tls_wrap_oob_standalone() wraps the prob=
e payload, applying the<br>    tls-auth HMAC or tls-crypt encryption (or no=
thing, when neither is<br>    configured)=2E<br>  - read_control_auth() unw=
raps each reply, verifying the HMAC /<br>    decrypting and stripping the o=
pcode + session id, on a per-packet<br>    copy of the wrapping context (as=
 tls_pre_decrypt_lite() does)=2E It<br>    decrypts in place, so oob_probe_=
handle_reply() now takes a mutable<br>    buffer=2E<br><br>With neither tls=
-auth nor tls-crypt configured the context stays in<br>TLS_WRAP_NONE and th=
e on-wire probe is byte-for-byte identical to<br>before, so the plaintext c=
ase is unchanged=2E<br><br>tls-crypt-v2 is not supported yet: the server on=
ly learns the client key<br>from the WKc carried in the TLS handshake, whic=
h an out-of-band probe<br>cannot provide=2E Such configurations skip probin=
g and keep the configured<br>remote order=2E<br><br>The probe is wrapped wi=
th the key of the first remote we can probe --<br>the same entry the other =
probed remotes are compared against -- so<br>probing is declined when anoth=
er one of them is keyed differently=2E The<br>key material loaded for the p=
robe is released afterwards; init loads it<br>again for the connection=2E<b=
r><br>Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac<br>Signed-off-by=
: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-sections/clien=
t-options=2Erst<br>M src/openvpn/oob_client=2Ec<br>2 files changed, 176 ins=
ertions(+), 40 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/1750/22</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=
=2Erst</span><br><span>index aeeea37=2E=2Ead43819 100644</span><br><span>--=
- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-sec=
tions/client-options=2Erst</span><br><span>@@ -620,20 +620,22 @@</span><br>=
<span>   priority group a candidate, since replies only arrive within the</=
span><br><span>   one-second probe window; the group is then ordered by wei=
ght alone=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  The probe is currently sent without control-channel wrapping, so=
 it only</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  works again=
st a server configured without ``--tls-auth``,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  ``--tls-crypt`` or ``--tls-crypt-v2``=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  The probe carries the sam=
e control-channel wrapping as a normal</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  connection (``--tls-auth`` or ``--tls-crypt``, when co=
nfigured)=2E With</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
``--tls-crypt-v2`` the remotes are left in their configured order,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  because the server cannot =
unwrap an out-of-band probe yet=2E</span><br><span> </span><br><span>   Onl=
y UDP remotes are probed, and only when there are at least two</span><br><s=
pan>   remotes; remotes reached through a SOCKS proxy are not probed=2E The=
</span><br><span>   probes are sent from one socket per address family, set=
 up like the</span><br><span>   connection socket of the first remote that =
can be probed; all probed</span><br><span>   remotes must therefore share i=
ts local bind settings (``--local``,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  ``--lport``, ``--bind``), otherwise probing is skipped and=
 the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  configured orde=
r is used=2E Remotes that answered are tried first, in the</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  order described above; all other rem=
otes, including TCP ones, follow in</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  their configured order=2E Probing runs once per process, be=
fore the first</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  conne=
ction attempt; a reconnect or a SIGUSR1 restart does not probe again=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--lport``, ``--bind=
``) and control-channel key, otherwise probing is</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  skipped and the configured order is used=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Remotes that answ=
ered are tried first, in the order described above;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  all other remotes, including TCP ones, =
follow in their configured</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  order=2E Probing runs once per process, before the first connectio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  attempt; a recon=
nect or a SIGUSR1 restart does not probe again=2E</span><br><span> </span><=
br><span>   Probing delays the first connection attempt by up to one second=
, plus</span><br><span>   the time needed to resolve each remote=2E A serve=
r only answers a probe</span><br><span>diff --git a/src/openvpn/oob_client=
=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 61e2602=2E=2E5a3042=
a 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+=
++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -29,6 +29,8 @@</span><br=
><span> #include &quot;oob_client=2Eh&quot;</span><br><span> #include &quot=
;openvpn=2Eh&quot;</span><br><span> #include &quot;oob=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;init=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl=
=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><spa=
n> #include &quot;session_id=2Eh&quot;</span><br><span> #include &quot;sock=
et=2Eh&quot;</span><br><span>@@ -79,21 +81,78 @@</span><br><span>     retur=
n (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Build=
 a plaintext SERVER_PROBE packet:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *   [opcode | key_id=3D0] [client session id] [SERVER_PROBE me=
ssage]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This is the =
unauthenticated OOB wire format; adding tls-auth/tls-crypt</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * wrapping for the probe is a follow-=
up (it only works against a server with</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * no control-channel wrapping for now)=2E */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-oob_probe_build_packet(struct buffer *buf, =
const struct session_id *client_sid)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static bool oob_probe_eligible(const struct connection_ent=
ry *ce);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Build a standalone control-=
channel wrapping context for the probe, mirroring</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * the tls_auth_standalone the server uses to=
 answer it=2E With neither tls-auth</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * nor tls-crypt configured the context stays in TLS_WRAP_N=
ONE and the probe is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * sent in plaintext, exactly as before; with either configured the probe =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * authenticated/=
encrypted like any other control packet=2E Returns NULL (and</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * logs) for configurations the pr=
obe cannot wrap yet, in which case the caller</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * skips probing and keeps the configured remote =
order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static s=
truct tls_auth_standalone *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+oob_probe_init_tls_auth_standalone(struct context *c, struct gc_are=
na *gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const struct oob_probe_parameter param =3D {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        =2Etimestamp =3D (uint64_t)now,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        =2Eflags =3D 0,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    };</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    uint8_t header =3D (uint8_t)(P_CON=
TROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return buf_write_u8(buf, header) &amp;&amp; session_id_=
write(client_sid, buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-           &amp;&amp; oob_server_probe_write(buf, &amp;param);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Wrap with the first entr=
y we can actually probe: that is the entry every</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * other probed remote is checked against,=
 so the key on the wire is the one</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * they were checked for=2E Falls back to entry 0 when n=
othing is probeable,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * in which case the caller bails out before anything is sent=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct conne=
ction_list *l =3D c-&gt;options=2Econnection_list;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const struct connection_entry *ce =3D l-=
&gt;array[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (oob_probe_eligible(l-&gt;array[i]))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            ce =3D l-&gt;array[i];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* tls-crypt-v2 wraps with a per-client key the server only learns from the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * wrapped clien=
t key (WKc) carried in the TLS handshake=2E An out-of-band</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * probe carries no WKc, so the =
server cannot unwrap it; skip probing rather</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * than send something unverifiable=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt=
_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot=
;server-probe: not supported with tls-crypt-v2; using configured order&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Load the tls-auth/tls-crypt key material =
into c-&gt;c1=2Eks (a no-op if neither</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * is configured)=2E This is run again per-connectio=
n later; calling it early</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * here is harmless=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    do_init_tls_wrap_key(c, ce);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct tls_options to;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    CLEAR(to);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, ce, c-&gt;options=2Et=
ls_client, &amp;c-&gt;c1=2Eks, &amp;c-&gt;c1=2Epid_persist);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_window =3D c-&gt;o=
ptions=2Ereplay_window;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct tls_auth_standalone *tas =3D tls_auth_standal=
one_init(&amp;to, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Control-c=
hannel frame and work buffers, mirroring do_init_frame_tls()=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    tls_init_control_channel=
_frame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;tls_wrap=2Ework =3D alloc_bu=
f_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    tas-&gt;workbuf =3D alloc_buf_gc(BUF_SIZE(&amp;tas-=
&gt;frame), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tas;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Release the probe&#39;s wrapping context and the key materia=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * do_init_tls_wra=
p_key() loaded for it: do_init_crypto_tls_c1() loads the same</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * fields again later without fre=
eing them first=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_pr=
obe_free_wrap(struct context *c, struct tls_auth_standalone *tas)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tls_auth_standalone_free(tas);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx_bi(&amp;c-&gt;c=
1=2Eks=2Etls_wrap_key);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    CLEAR(c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf_clear(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wk=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&am=
p;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* the raw key bytes too: do_init_crypto_tls_c1() may =
never load a key over</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * them, so they would otherwise stay resident for the process lifeti=
me */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_mem=
zero(&amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata, sizeof(c-&gt;c1=2Eks=2Eori=
ginal_wrap_keydata));</span><br><span> }</span><br><span> </span><br><span>=
 /* The local address and port ce&#39;s connection socket binds: its first =
--local,</span><br><span>@@ -156,6 +215,22 @@</span><br><span>            &=
amp;&amp; str_equal_or_both_null(port_a, port_b);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Do a =
and b wrap the control channel with the same key (--tls-auth,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt, --tls-crypt-v2 an=
d key direction)? The one probe is wrapped with</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * the first probeable entry&#39;s key, so a se=
rver keyed differently could never</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * answer it=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+oob_probe_same_wrap(const struct connection_entry *a, const struct co=
nnection_entry *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return str_equa=
l_or_both_null(a-&gt;tls_auth_file, b-&gt;tls_auth_file)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt;tls_auth_f=
ile_inline =3D=3D b-&gt;tls_auth_file_inline</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt;key_direction =3D=3D b=
-&gt;key_direction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
          &amp;&amp; str_equal_or_both_null(a-&gt;tls_crypt_file, b-&gt;tls=
_crypt_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
    &amp;&amp; a-&gt;tls_crypt_file_inline =3D=3D b-&gt;tls_crypt_file_inli=
ne</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&=
amp; str_equal_or_both_null(a-&gt;tls_crypt_v2_file, b-&gt;tls_crypt_v2_fil=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&=
amp; a-&gt;tls_crypt_v2_file_inline =3D=3D b-&gt;tls_crypt_v2_file_inline;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Resolve the local=
 bind address of ce&#39;s connection socket; NULL with --nobind=2E</span><b=
r><span>  * Fatal on failure, like the link socket=2E */</span><br><span> s=
tatic struct addrinfo *</span><br><span>@@ -250,9 +325,9 @@</span><br><span=
> /* Parse one received datagram as a PROBE_REPLY and, if valid and matchin=
g one</span><br><span>  * of the probes we sent, record the reply in result=
s=2E */</span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-oob_probe_handle_reply(const uint8_t *data, int len, const s=
truct session_id *client_sid,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                       const struct openvpn_sockaddr *from, const s=
truct oob_probe_target *targets,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                       struct oob_probe_result *results, int n)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_handle_rep=
ly(uint8_t *data, int len, const struct session_id *client_sid,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                       const st=
ruct tls_wrap_ctx *base_wrap, const struct openvpn_sockaddr *from,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                       const=
 struct oob_probe_target *targets, struct oob_probe_result *results, int n)=
</span><br><span> {</span><br><span>     /* Need at least the opcode byte a=
nd the session id=2E */</span><br><span>     if (len &lt; 1 + (int)SID_SIZE=
 || (data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><spa=
n>@@ -262,7 +337,20 @@</span><br><span> </span><br><span>     struct buffer=
 buf;</span><br><span>     buf_set_read(&amp;buf, data, (size_t)len);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_advance(&amp;buf, 1=
 + SID_SIZE); /* skip opcode + server session id */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Unwrap the reply with the same control-channel path t=
he server used to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * wrap it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in=
 all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modes) s=
trips the opcode + server session id, leaving buf at the TLV</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * payload=2E With no tls-auth=
/tls-crypt it just strips those header bytes, as</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * before=2E read_control_auth() mutates t=
he wrapping context, so we work on a</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * per-packet copy (as tls_pre_decrypt_lite() does on =
the server)=2E The peer</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * address is only used for log messages, and tls_options only for<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * tls-crypt-v2 =
metadata checks, so both are passed as NULL=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct tls_wrap_ctx wrap =3D *base_wrap;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!read_contro=
l_auth(&amp;buf, &amp;wrap, NULL, NULL))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return; /* not for us, or failed authentication */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span=
><br><span>     struct oob_probe_reply reply;</span><br><span>     if (!oob=
_client_reply_read(&amp;buf, &amp;reply))</span><br><span>@@ -314,8 +402,9 =
@@</span><br><span>  * matches a probe we sent=2E Returns true if every sen=
t probe has been answered=2E */</span><br><span> static bool</span><br><spa=
n> oob_probe_receive_slice(const struct probe_ctx *pc, const struct timeval=
 *deadline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              const struct session_id *client_sid, const struct oob_probe_t=
arget *targets,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  struct oob_probe_result *results, int n, int outstanding)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     const struct session_id *client_sid, const struct tls_wrap_ctx *wrap,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    const struct oob_probe_target *targets, struct oob_probe_result *result=
s, int n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              int outstanding)</span><br><span> {</span><br><span>     whil=
e (true)</span><br><span>     {</span><br><span>@@ -365,7 +454,7 @@</span><=
br><span>                                     (struct sockaddr *)&amp;from,=
 &amp;fromlen);</span><br><span>             if (len &gt; 0)</span><br><spa=
n>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           oob_probe_handle_reply(data, len, client_sid, &amp;from, targets=
, results, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           oob_probe_handle_reply(data, len, client_sid, wrap, &amp;from, t=
argets, results, n);</span><br><span>             }</span><br><span>       =
  }</span><br><span>         if (oob_count_answered(targets, results, n) &g=
t;=3D outstanding)</span><br><span>@@ -418,8 +507,8 @@</span><br><span>  * =
once the window elapses or every sent probe has been answered=2E */</span><=
br><span> static void</span><br><span> oob_probe_collect(struct probe_ctx *=
pc, const struct buffer *probe,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                  const struct session_id *client_sid, struct oob=
_probe_target *targets,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                  struct oob_probe_result *results, int n,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                  const struct ses=
sion_id *client_sid, const struct tls_wrap_ctx *wrap,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  struct oob_probe_target=
 *targets, struct oob_probe_result *results, int n,</span><br><span>       =
            const struct signal_info *sig)</span><br><span> {</span><br><sp=
an>     /* number of probes we actually sent: stop early once they all answ=
er */</span><br><span>@@ -444,7 +533,7 @@</span><br><span>             dead=
line=2Etv_usec -=3D 1000000;</span><br><span>         }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (oob_probe_r=
eceive_slice(pc, &amp;deadline, client_sid, targets, results, n, want)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_probe_re=
ceive_slice(pc, &amp;deadline, client_sid, wrap, targets, results, n, want)=
</span><br><span>             || sig-&gt;signal_received)</span><br><span> =
        {</span><br><span>             return; /* all answered, or we are b=
eing told to stop */</span><br><span>@@ -487,6 +576,16 @@</span><br><span> =
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Wrapping contex=
t for the probe (tls-auth/tls-crypt, or plaintext if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * neither)=2E NULL means this config=
uration cannot be probed; keep the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * configured order=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct tls_auth_standalone *tas =3D oob_probe_=
init_tls_auth_standalone(c, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!tas)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     /* A single random session id identifies all of our probes; servers=
 echo it</span><br><span>      * back in the reply&#39;s peer_session_id, l=
etting us reject spoofed replies=2E */</span><br><span>     struct session_=
id client_sid;</span><br><span>@@ -508,11 +607,21 @@</span><br><span>      =
       tmpl =3D ce;</span><br><span>             continue;</span><br><span>=
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst char *differs =3D NULL;</span><br><span>         if (!oob_probe_same_b=
ind(tmpl, ce, &amp;c-&gt;options))</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LOW, &quot;server=
-probe: %s:%s binds differently from %s:%s;&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            differs =3D &quot;binds&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else if (!oob_probe_same=
_wrap(tmpl, ce))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            d=
iffers =3D &quot;wraps the control channel&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (differs)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s %s differently =
from %s:%s;&quot;</span><br><span>                        &quot; not probin=
g, using configured order&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                ce-&gt;remote, ce-&gt;remote_port, tmpl-&gt;remo=
te, tmpl-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                ce-&gt;remote, ce-&gt;remote_port, differs, tmpl-&gt=
;remote, tmpl-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            oob_probe_free_wrap(c, tas);</span><br><span>      =
       gc_free(&amp;gc);</span><br><span>             return;</span><br><sp=
an>         }</span><br><span>@@ -520,6 +629,7 @@</span><br><span>     if (=
!tmpl)</span><br><span>     {</span><br><span>         msg(D_LOW, &quot;ser=
ver-probe: no remote can be probed; using configured order&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_free_wrap(=
c, tas);</span><br><span>         gc_free(&amp;gc);</span><br><span>       =
  return;</span><br><span>     }</span><br><span>@@ -528,17 +638,39 @@</spa=
n><br><span>     struct oob_probe_target *targets =3D gc_malloc(sizeof(*tar=
gets) * l-&gt;len, true, &amp;gc);</span><br><span>     struct oob_probe_re=
sult *results =3D gc_malloc(sizeof(*results) * l-&gt;len, true, &amp;gc);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct buffer probe =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!oob_probe_build_packet(&amp;probe, &a=
mp;client_sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Build the probe once and reuse the same bytes for every remote and for</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * resends: the S=
ERVER_PROBE payload is a single probe_parameter TLV, wrapped</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * (or sent in plaintext) like=
 any other control packet=2E The client session</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * id is prepended as the sender session id=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer payload =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct oob_probe_parameter param =3D {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =
=3D (uint64_t)now,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o=
ob_server_probe_write(&amp;payload, &amp;param))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;=
server-probe: could not build probe packet; using configured order&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &=
quot;server-probe: could not build probe payload; using configured order&qu=
ot;);</span><br><span>         oob_probe_sockets_close(&amp;pc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_free_wrap(c,=
 tas);</span><br><span>         gc_free(&amp;gc);</span><br><span>         =
return;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;server-probe: probing %d re=
mote(s) with a %d ms window&quot;, l-&gt;len,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        OOB_PROBE_WINDOW_MS);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D tls_wrap_oob_=
standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!BLEN(&amp;probe=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server=
-probe: could not wrap probe packet; using configured order&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_sockets_c=
lose(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   oob_probe_free_wrap(c, tas);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *wra=
p_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &quot;tls-cry=
pt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                 : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? &quot;t=
ls-auth&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                                              : &quot;none =
(plaintext)&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_LOW, &quot;server-probe: probing %d remote(s) with a %d ms window,=
 control-channel wrapping: %s&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_name);</span>=
<br><span> </span><br><span>     /* Resolve every remote first, so only the=
 address families actually in use</span><br><span>      * get a probe socke=
t=2E */</span><br><span>@@ -585,6 +717,7 @@</span><br><span>         {</spa=
n><br><span>             freeaddrinfo(bind_local);</span><br><span>        =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe=
_free_wrap(c, tas);</span><br><span>         gc_free(&amp;gc);</span><br><s=
pan>         return;</span><br><span>     }</span><br><span>@@ -646,7 +779,=
7 @@</span><br><span> </span><br><span>     if (sent_count &gt; 0)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, targets, results, =
l-&gt;len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wra=
p, targets, results, l-&gt;len,</span><br><span>                           =
c-&gt;sig);</span><br><span>     }</span><br><span>     oob_probe_sockets_c=
lose(&amp;pc);</span><br><span>@@ -694,5 +827,6 @@</span><br><span>     msg=
(M_INFO, &quot;server-probe: %d of %d probed remote(s) answered; connecting=
 best-first&quot;,</span><br><span>         responded, sent_count);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_p=
robe_free_wrap(c, tas);</span><br><span>     gc_free(&amp;gc);</span><br><s=
pan> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">change 1750</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1f9d7b5a5e=
c19bf77c0c212795f583c5ba4c03ac </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 =
</div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--Q59Hb54zQto=--


--===============8841773612881565726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8841773612881565726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8841773612881565726==--

