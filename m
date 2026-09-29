Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BD4CA5FA1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8KZVWOgncLtkozqCvO16ACIljAYs+efFff2l2Vvn0wc=; b=dNGfrGvMsBeg6OkCCA2DPbACvx
	4HUVaubf9PxhoDmdTF6N1iYZgGqyZ7SFTfXK1r4NdV31l8Zn5f7UZPTjy8LfLswnzpZ+iCgcwHcZV
	zTs0LgKEHt8xPuS3BHdtnIFReVkKyzZRebrGrAI5dl6FxyeoxZgeVDhO/xqZEIczfaLQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhj-0005UC-1t;
	Tue, 29 Sep 2026 13:17:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhh-0005Ty-Jr
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MnN6WyLtS5ciKTOo/jgnkDLZzPJGR9TCVcnhHQh7xLg=; b=fYMt6lALzj3lHweNSo4icrHfCO
 VQtDyl8GMmRYyfbP+fZqYY8uS2ROvIKn5e8bmLLVb/hUjYcjfMOQ8ixo8khwmIesHEItDOaMlOhWg
 XrKRodXLnYyBTnzxQFENfOZBqyGPy1BoQeNaypOo1K/73Sqb9bwZUvz06obrwQ7emE54=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MnN6WyLtS5ciKTOo/jgnkDLZzPJGR9TCVcnhHQh7xLg=; b=B
 37ZK96VeQBc/bppKMfgbbl5bL06Qv0pMeZB8UKzM+jKzgmPgfsjGBJKJqz3DoEYvLxX5BgbKRxZWH
 Xqt4mAW1Pt3+mLOrmbs5cer9SFTxUkX81gnnG7H4qQUDQG7BAtmZp0k+L4piIcW6r/aLY3eHqBnxf
 voshtQbfImJ77wis=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhf-0001Fo-4r for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:06 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c3ee4cfso2053301f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687816; x=1791292616; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MnN6WyLtS5ciKTOo/jgnkDLZzPJGR9TCVcnhHQh7xLg=;
 b=AcI0HzLAs3LlT8L6IcoHJBxhM1G+FYcBmHT9C2IwEUCgBgNBbYPSXaPO+OOoHRFmK0
 QLxMyfjwXleECs456KVLB1WNQ4v5m7cqPBOyqiD0wnxySPJGLGR4hd5b4p8YRY1VcRCG
 L8FxBsSbzzFHLrWre7SJUj/65EDw9VWE+jzwbA8jeBr/U7WFp3482uvXGAA4ZeVE3dua
 b5s155N+9taABX9VGNBksnhXTpNiT+u/nP7mxwNbvntbEr90qEmgoLWksQUp/XTQ+JTZ
 1zyOUvK5ejZxSKH8Z1b5ROXXHCRmasUO8t9MsRB1dbWOlBaNTF9bQQa05HHOBgzKVAhr
 s06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687816; x=1791292616;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MnN6WyLtS5ciKTOo/jgnkDLZzPJGR9TCVcnhHQh7xLg=;
 b=Su1gbyRR7Qz3X18wyUMs5IWi5SpoIe7GASeH/hcoYCv+56dqTMQxpL+xdgDM3sQTr9
 PuWtuKAmU9tkwNm7afm/+9UqczYf/2NpFu1+fp4zrYNh6d/xLvleGlpj/YJHhSNPaWM4
 G/DyW6D87u0Um6COO1tL9Tk8aGAjjPsQ0W0lcXTQCRdOz9/9iBWlNgZn/yiFxiQQoXw6
 HisX9UQtSHgLRYJlsdOcHsNxkfibprWAEIulcefwKDH4hByU3vFp7689ggsjSj8mDxbK
 PKOqn1Z/RTEQb5mNCPtXQMSq9v3pF5xHBwHlNqxV1SrQcG2r1ynHeFU4EiPADAkqDHVF
 dTag==
X-Gm-Message-State: AFq9FYLkHl+Y0IX0UQJX0s2c3lAX5hQnhlxGapNpbUyE9h+LSca/2hhO
 qf7GrLgio7AUWAfSihWGHERlXsWGCtWwtuSc+U7jsnLwlRalEKYp1iB+tt5CFfNSwtz+dGvFhvo
 GTnFLbusfbpCTGdruf16DyWv8p4t6q6vJlvEnolu4ZbDMkb64PdxXOUSMR5s9IizA26L9v2YaY7
 G/ieHDGA==
X-Gm-Gg: AYBFou3Pvbq1S1IZuJDFlCj94iMCTFanNPyZo6RiDdtwSBN+7F/7WJA/oPRLGhXaBRJ
 Zfoei50q9S3RLzN+zb2N1XMiSYW3QW7r1d4LkS+MTKSjSKAK1YW1rSDzUZauzC7i/x5x/pgdQYg
 ksQrwrBkOWj+tj/vJBSUdVfN2I5eQ7jSjigOqwpx/zZ1eKwqoXYwwqafYcnjd/T/MmJKPSDS8jv
 YSYodwP5sBzCBq5If9/S6FDSEhZ72REKDJUeOsLC4IOWxGczemLNbHXB2rnRRuf2RFqDZwOMYop
 25oFXOTg2FI0zboGnyN2QeZzz2JOPLjPb0fP9LFtBzFUiW4/aW2hKKnIsw02Gng5ZmlhaXFI7pU
 ea6z0x+JIdBJ7L6W0ke3tFRBdFWPepbGADBIZHfCxL/BoXqTMAdBpvqaid7/+4pNkZb0QCipYaG
 p4is4a7eg3O/CdCa15IVxzODfGjEJK5c+qr5r6tKRHj+7mKo/LLXQCoKlQiUjjE1KH3KkMpIz3J
 ujmou/d1/T7wr5rlNr26AUxLLYxfRFSxcGuS8Zb3sUqin4/MUzP+ls26/La+ClL5u+/uajud0v+
 Zo3oXm7RmviXUW6YOidcxN0KlhYdp1PcoAVasLDzsD0cItpXvQhjtTz1wF2j
X-Received: by 2002:a05:6000:1888:b0:487:2777:6354 with SMTP id
 ffacd0b85a97d-488717166dfmr37421470f8f.48.1790687816178; 
 Tue, 29 Sep 2026 06:16:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af502da06sm4682233f8f.11.2026.09.29.06.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:55 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: 70f2a3018386bce458c1658391c3e556af95e067
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ca11da08fadad6cd704556e10e39e00206685dfd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhf-0001Fo-4r
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
Content-Type: multipart/mixed; boundary="===============4636714926312273669=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4636714926312273669==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2ESC16XGRR8="; charset=UTF-8

--2ESC16XGRR8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail

to look a=
t the new patch set (#28)=2E

The following approvals got outdated and were=
 removed:
Code-Review+1 by ralf_lici


Change subject: oob: Wrap the client=
 SERVER_PROBE with tls-auth/tls-crypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

oob: Wrap the client SERVER_PROBE with tls-auth/t=
ls-crypt

The client --server-probe sent a plaintext SERVER_PROBE and parse=
d
replies by hand, so it only worked against a server with no
control-chann=
el wrapping=2E

Build a standalone wrapping context for the probe, mirrorin=
g the
server's tls_auth_standalone, and send probes and unwrap replies thro=
ugh
the regular control-channel path (tls_wrap_oob_standalone() and
read_co=
ntrol_auth())=2E Replies are unwrapped on a per-packet copy of the
context,=
 as tls_pre_decrypt_lite() does=2E Each transmission is wrapped on
its own,=
 as each carries its own request_id; with tls-auth or tls-crypt
that also g=
ives each its own replay packet id=2E Without either, the
probe goes out in=
 plaintext as before=2E

tls-crypt-v2 is not supported yet: the server only=
 learns the client
key from the WKc carried in the TLS handshake, which an =
out-of-band
probe cannot provide=2E Such configurations skip probing and ke=
ep the
configured remote order=2E

The probe is wrapped with the key of the=
 first remote we can probe --
the same entry the other probed remotes are c=
ompared against -- so
probing is declined when another one of them is keyed=
 differently=2E The
key material loaded for the probe is released afterward=
s; init loads it
again for the connection=2E

Change-Id: I1f9d7b5a5ec19bf77=
c0c212795f583c5ba4c03ac
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---=

M doc/man-sections/client-options=2Erst
M src/openvpn/oob_client=2Ec
2 fil=
es changed, 141 insertions(+), 27 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/50/1750/28

diff --git a/doc/man-s=
ections/client-options=2Erst b/doc/man-sections/client-options=2Erst
index =
9835403=2E=2Ef1f004f 100644
--- a/doc/man-sections/client-options=2Erst
+++=
 b/doc/man-sections/client-options=2Erst
@@ -620,20 +620,23 @@
   priority =
group a candidate, since replies only arrive within the
   one-second probe=
 window; the group is then ordered by weight alone=2E
 
-  The probe is cur=
rently sent without control-channel wrapping, so it only
-  works against a=
 server configured without ``--tls-auth``,
-  ``--tls-crypt`` or ``--tls-cr=
ypt-v2``=2E
+  The probe carries the same control-channel wrapping as a nor=
mal
+  connection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E W=
ith
+  ``--tls-crypt-v2`` the remotes are left in their configured order,
+=
  because the server cannot unwrap an out-of-band probe yet=2E
 
   Only UD=
P remotes are probed, and only when there are at least two
   remotes; remo=
tes reached through a SOCKS proxy are not probed=2E The
   probes are sent =
from one socket per address family, set up like the
   connection socket of=
 the first remote that can be probed; all probed
   remotes must therefore =
share its local bind settings (``--local``,
-  ``--lport``, ``--bind``), ot=
herwise probing is skipped and the
-  configured order is used=2E Remotes t=
hat answered are tried first, in the
-  order described above; all other re=
motes, including TCP ones, follow in
-  their configured order=2E Probing r=
uns once per process, before the first
-  connection attempt; a reconnect o=
r a SIGUSR1 restart does not probe again=2E
+  ``--lport``, ``--bind``) and=
 control-channel key, otherwise probing is
+  skipped and the configured or=
der is used=2E
+
+  Remotes that answered are tried first, in the order des=
cribed above;
+  all other remotes, including TCP ones, follow in their con=
figured
+  order=2E Probing runs once per process, before the first connect=
ion
+  attempt; a reconnect or a SIGUSR1 restart does not probe again=2E
 
=
   Probing delays the first connection attempt by up to one second, plus
  =
 the time needed to resolve each remote=2E A server answers only a few
diff=
 --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 960a=
cd2=2E=2E65a4bd0 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/=
oob_client=2Ec
@@ -29,6 +29,8 @@
 #include "oob_client=2Eh"
 #include "open=
vpn=2Eh"
 #include "oob=2Eh"
+#include "init=2Eh"
+#include "ssl=2Eh"
 #inc=
lude "ssl_pkt=2Eh"
 #include "session_id=2Eh"
 #include "socket=2Eh"
@@ -69=
,9 +71,9 @@
     int round_start;  /* first transmission of the current rou=
nd */
     uint32_t id_base; /* random, so request_ids cannot be guessed */=

     /* What each probe is built from; only the request_id differs=2E */
+=
    struct tls_auth_standalone *tas;
     struct session_id *client_sid;
  =
   struct oob_probe_request req;
-    uint8_t packet[64];                /*=
 the probe being sent */
 #ifdef TARGET_ANDROID
     bool fd_protected[PROB=
E_AF_COUNT]; /* VPNService protect(), once per socket */
 #endif
@@ -85,20 =
+87,73 @@
     return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
 }
=
 
-/* Build a plaintext SERVER_PROBE packet with the given request_id:
- * =
  [opcode | key_id=3D0] [client session id] [probe request TLV]
- * This is=
 the unauthenticated OOB wire format; adding tls-auth/tls-crypt
- * wrappin=
g for the probe is a follow-up (it only works against a server with
- * no =
control-channel wrapping for now)=2E The result points into pc->packet:
- *=
 send it before building the next=2E */
+/* Build the standalone wrapping c=
ontext the probe is sent with, mirroring the
+ * one the server answers it =
with, keyed like ce, the entry every other probed
+ * remote was checked ag=
ainst; without tls-auth/tls-crypt it stays in
+ * TLS_WRAP_NONE and the pro=
be goes out in plaintext=2E Returns NULL (and logs)
+ * for tls-crypt-v2, w=
hich the probe cannot carry yet=2E */
+static struct tls_auth_standalone *
=
+oob_probe_init_tls_auth_standalone(struct context *c, const struct connect=
ion_entry *ce,
+                                   struct gc_arena *gc)
+{
=
+    /* tls-crypt-v2 wraps with a per-client key the server only learns fro=
m the
+     * wrapped client key (WKc) carried in the TLS handshake=2E An o=
ut-of-band
+     * probe carries no WKc, so the server cannot unwrap it; sk=
ip probing rather
+     * than send something unverifiable=2E */
+    if (c=
e->tls_crypt_v2_file)
+    {
+        msg(D_LOW, "server-probe: not support=
ed with tls-crypt-v2; using configured order");
+        return NULL;
+    =
}
+
+    /* options=2Ece is not mapped yet; options_postprocess_mutate_ce()=
 has already
+     * copied any global key into ce=2E Loaded again per-conn=
ection later=2E */
+    do_init_tls_wrap_key(c, ce);
+
+    struct tls_opti=
ons to;
+    CLEAR(to);
+    init_tls_wrap_ctx(&to=2Etls_wrap, ce, c->optio=
ns=2Etls_client, &c->c1=2Eks, &c->c1=2Epid_persist);
+    to=2Ereplay_windo=
w =3D c->options=2Ereplay_window;
+    to=2Ereplay_time =3D c->options=2Ere=
play_time;
+
+    struct tls_auth_standalone *tas =3D tls_auth_standalone_i=
nit(&to, gc);
+
+    tls_init_control_channel_frame_parameters(&tas->frame,=
 ce->tls_mtu);
+    tas->tls_wrap=2Ework =3D alloc_buf_gc(BUF_SIZE(&tas->fr=
ame), gc);
+    tas->workbuf =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+=

+    return tas;
+}
+
+/* Release the probe's wrapping context and the key=
 material
+ * do_init_tls_wrap_key() loaded for it: do_init_crypto_tls_c1()=
 loads the same
+ * fields again later without freeing them first=2E */
+st=
atic void
+oob_probe_free_wrap(struct context *c, struct tls_auth_standalon=
e *tas)
+{
+    tls_auth_standalone_free(tas);
+    free_key_ctx_bi(&c->c1=
=2Eks=2Etls_wrap_key);
+    CLEAR(c->c1=2Eks=2Etls_wrap_key);
+    /* the r=
aw key bytes too: do_init_crypto_tls_c1() may never load a key over
+     *=
 them, so they would otherwise stay resident for the process lifetime */
+ =
   secure_memzero(&c->c1=2Eks=2Eoriginal_wrap_keydata, sizeof(c->c1=2Eks=2E=
original_wrap_keydata));
+}
+
+/* Build a wrapped SERVER_PROBE with the giv=
en request_id=2E The result points
+ * into tas's work buffers: send it bef=
ore building the next=2E */
 static bool
 oob_probe_build(struct probe_ctx =
*pc, uint32_t request_id, struct buffer *probe)
 {
+    uint8_t data[64];
+=
    struct buffer payload;
+    buf_set_write(&payload, data, sizeof(data))=
;
     pc->req=2Erequest_id =3D request_id;
-    buf_set_write(probe, pc->p=
acket, sizeof(pc->packet));
-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB=
_V1 << P_OPCODE_SHIFT);
-    return buf_write_u8(probe, header) && session_=
id_write(pc->client_sid, probe)
-           && oob_probe_request_write(prob=
e, &pc->req);
+    if (!oob_probe_request_write(&payload, &pc->req))
+    {=

+        return false;
+    }
+    *probe =3D tls_wrap_oob_standalone(&pc-=
>tas->tls_wrap, pc->tas, pc->client_sid, &payload);
+    return BLEN(probe)=
 > 0;
 }
 
 /* Was addr already probed in the current round? */
@@ -127,6 +=
182,7 @@
     struct buffer probe;
     if (!oob_probe_build(pc, pc->id_bas=
e + (uint32_t)pc->n_sends, &probe))
     {
+        msg(D_LOW, "server-prob=
e: could not build probe packet");
         return false;
     }
     openv=
pn_gettimeofday(&s->sent_at, NULL);
@@ -201,6 +257,22 @@
            && str=
_equal_or_both_null(port_a, port_b);
 }
 
+/* Do a and b wrap the control c=
hannel with the same key (--tls-auth,
+ * --tls-crypt, --tls-crypt-v2 and k=
ey direction)? Probes are wrapped with the
+ * first probeable entry's key,=
 so a server keyed differently could never answer
+ * them=2E */
+static bo=
ol
+oob_probe_same_wrap(const struct connection_entry *a, const struct conn=
ection_entry *b)
+{
+    return str_equal_or_both_null(a->tls_auth_file, b-=
>tls_auth_file)
+           && a->tls_auth_file_inline =3D=3D b->tls_auth_f=
ile_inline
+           && a->key_direction =3D=3D b->key_direction
+       =
    && str_equal_or_both_null(a->tls_crypt_file, b->tls_crypt_file)
+      =
     && a->tls_crypt_file_inline =3D=3D b->tls_crypt_file_inline
+         =
  && str_equal_or_both_null(a->tls_crypt_v2_file, b->tls_crypt_v2_file)
+  =
         && a->tls_crypt_v2_file_inline =3D=3D b->tls_crypt_v2_file_inline;=

+}
+
 /* Resolve the local bind address of ce's connection socket; NULL wi=
th --nobind=2E
  * Fatal on failure, like the link socket=2E */
 static str=
uct addrinfo *
@@ -295,7 +367,7 @@
 /* Parse one received datagram as a PRO=
BE_REPLY and, if valid and answering one
  * of the probes we sent, record =
the reply in results=2E */
 static void
-oob_probe_handle_reply(const struc=
t probe_ctx *pc, const uint8_t *data, int len,
+oob_probe_handle_reply(cons=
t struct probe_ctx *pc, uint8_t *data, int len,
                        con=
st struct openvpn_sockaddr *from, const struct oob_probe_target *targets,
 =
                       struct oob_probe_result *results, int n)
 {
@@ -307,=
7 +379,19 @@
 
     struct buffer buf;
     buf_set_read(&buf, data, (size_=
t)len);
-    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + server sessi=
on id */
+
+    /* Unwrap the reply with the same control-channel path the =
server used to
+     * wrap it: this verifies the tls-auth HMAC / decrypts =
tls-crypt, and (in all
+     * modes) strips the opcode + server session id=
, leaving buf at the OOB
+     * message=2E read_control_auth() mutates the=
 wrapping context, so we work on a
+     * per-packet copy (as tls_pre_decr=
ypt_lite() does on the server)=2E The peer
+     * address is only used for=
 log messages, and tls_options only for
+     * tls-crypt-v2 metadata check=
s, so both are passed as NULL=2E */
+    struct tls_wrap_ctx wrap =3D pc->t=
as->tls_wrap;
+    if (!read_control_auth(&buf, &wrap, NULL, NULL))
+    {
=
+        return; /* not for us, or failed authentication */
+    }
 
     s=
truct oob_probe_reply reply;
     if (!oob_client_reply_read(&buf, &reply))=

@@ -537,11 +621,20 @@
             tmpl =3D ce;
             continue;
   =
      }
+        const char *differs =3D NULL;
         if (!oob_probe_same=
_bind(tmpl, ce, &c->options))
         {
-            msg(D_LOW, "server-pr=
obe: %s:%s binds differently from %s:%s;"
+            differs =3D "binds";=

+        }
+        else if (!oob_probe_same_wrap(tmpl, ce))
+        {
+ =
           differs =3D "wraps the control channel";
+        }
+        if =
(differs)
+        {
+            msg(D_LOW, "server-probe: %s:%s %s differ=
ently from %s:%s;"
                        " not probing, using configured =
order",
-                ce->remote, ce->remote_port, tmpl->remote, tmpl->r=
emote_port);
+                ce->remote, ce->remote_port, differs, tmpl->r=
emote, tmpl->remote_port);
             gc_free(&gc);
             return;
=
         }
@@ -553,12 +646,25 @@
         return;
     }
 
+    /* Wrapping=
 context for the probe (tls-auth/tls-crypt, or plaintext if
+     * neither=
)=2E NULL means this configuration cannot be probed; keep the
+     * confi=
gured order=2E */
+    struct tls_auth_standalone *tas =3D oob_probe_init_t=
ls_auth_standalone(c, tmpl, &gc);
+    if (!tas)
+    {
+        gc_free(&g=
c);
+        return;
+    }
+
     struct probe_ctx pc =3D { =2Esd =3D { SO=
CKET_UNDEFINED, SOCKET_UNDEFINED } };
     struct oob_probe_target *targets=
 =3D gc_malloc(sizeof(*targets) * l->len, true, &gc);
     struct oob_probe=
_result *results =3D gc_malloc(sizeof(*results) * l->len, true, &gc);
 
-  =
  /* Every probe carries the same session id and timestamp; each
-     * tr=
ansmission gets a request_id of its own=2E */
+    /* Every probe is a sing=
le probe request TLV, wrapped (or sent in
+     * plaintext) like any other=
 control packet, with the client session id as
+     * the sender session i=
d=2E Each transmission is built on its own, as each
+     * carries its own=
 request_id=2E */
+    pc=2Etas =3D tas;
     pc=2Eclient_sid =3D &client_s=
id;
     pc=2Eid_base =3D (uint32_t)get_random();
     pc=2Ereq =3D (struct=
 oob_probe_request){
@@ -566,8 +672,11 @@
         =2Eflags =3D 0,
     };
=
 
-    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window",=
 l->len,
-        OOB_PROBE_WINDOW_MS);
+    const char *wrap_name =3D (tas=
->tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
+                  =
          : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
+     =
                                                               : "none (pla=
intext)";
+    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms =
window, control-channel wrapping: %s",
+        l->len, OOB_PROBE_WINDOW_MS=
, wrap_name);
 
     /* Resolve every remote first, so only the address fam=
ilies actually in use
      * get a probe socket=2E */
@@ -614,6 +723,7 @@
=
         {
             freeaddrinfo(bind_local);
         }
+        oob_p=
robe_free_wrap(c, tas);
         gc_free(&gc);
         return;
     }
@@ -=
707,5 +817,6 @@
     msg(M_INFO, "server-probe: %d of %d probed remote(s) a=
nswered; connecting best-first",
         responded, sent_count);
 
+    oo=
b_probe_free_wrap(c, tas);
     gc_free(&gc);
 }

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
G=
errit-Change-Number: 1750
Gerrit-PatchSet: 28
Gerrit-Owner: stipa <lstipako=
v@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--2ESC16XGRR8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #28</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Wrap the client SERVER_PROBE with tls-auth/tls-=
crypt<br><br>The client --server-probe sent a plaintext SERVER_PROBE and pa=
rsed<br>replies by hand, so it only worked against a server with no<br>cont=
rol-channel wrapping=2E<br><br>Build a standalone wrapping context for the =
probe, mirroring the<br>server&#39;s tls_auth_standalone, and send probes a=
nd unwrap replies through<br>the regular control-channel path (tls_wrap_oob=
_standalone() and<br>read_control_auth())=2E Replies are unwrapped on a per=
-packet copy of the<br>context, as tls_pre_decrypt_lite() does=2E Each tran=
smission is wrapped on<br>its own, as each carries its own request_id; with=
 tls-auth or tls-crypt<br>that also gives each its own replay packet id=2E =
Without either, the<br>probe goes out in plaintext as before=2E<br><br>tls-=
crypt-v2 is not supported yet: the server only learns the client<br>key fro=
m the WKc carried in the TLS handshake, which an out-of-band<br>probe canno=
t provide=2E Such configurations skip probing and keep the<br>configured re=
mote order=2E<br><br>The probe is wrapped with the key of the first remote =
we can probe --<br>the same entry the other probed remotes are compared aga=
inst -- so<br>probing is declined when another one of them is keyed differe=
ntly=2E The<br>key material loaded for the probe is released afterwards; in=
it loads it<br>again for the connection=2E<br><br>Change-Id: I1f9d7b5a5ec19=
bf77c0c212795f583c5ba4c03ac<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M src/openv=
pn/oob_client=2Ec<br>2 files changed, 141 insertions(+), 27 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/50/1750/28</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-opti=
ons=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index 983=
5403=2E=2Ef1f004f 100644</span><br><span>--- a/doc/man-sections/client-opti=
ons=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst</span=
><br><span>@@ -620,20 +620,23 @@</span><br><span>   priority group a candid=
ate, since replies only arrive within the</span><br><span>   one-second pro=
be window; the group is then ordered by weight alone=2E</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The probe is currentl=
y sent without control-channel wrapping, so it only</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  works against a server configured without=
 ``--tls-auth``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``-=
-tls-crypt`` or ``--tls-crypt-v2``=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  The probe carries the same control-channel wrapping as =
a normal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  connectio=
n (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-crypt-v2`` the remotes=
 are left in their configured order,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  because the server cannot unwrap an out-of-band probe ye=
t=2E</span><br><span> </span><br><span>   Only UDP remotes are probed, and =
only when there are at least two</span><br><span>   remotes; remotes reache=
d through a SOCKS proxy are not probed=2E The</span><br><span>   probes are=
 sent from one socket per address family, set up like the</span><br><span> =
  connection socket of the first remote that can be probed; all probed</spa=
n><br><span>   remotes must therefore share its local bind settings (``--lo=
cal``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--lport``, =
``--bind``), otherwise probing is skipped and the</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  configured order is used=2E Remotes that answ=
ered are tried first, in the</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  order described above; all other remotes, including TCP ones, foll=
ow in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  their configur=
ed order=2E Probing runs once per process, before the first</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  connection attempt; a reconnect or =
a SIGUSR1 restart does not probe again=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  ``--lport``, ``--bind``) and control-channel key, o=
therwise probing is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  skipped and the configured order is used=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  Remotes that answered are tried first, in the order described abov=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  all other remot=
es, including TCP ones, follow in their configured</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  order=2E Probing runs once per process, be=
fore the first connection</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  attempt; a reconnect or a SIGUSR1 restart does not probe again=2E</=
span><br><span> </span><br><span>   Probing delays the first connection att=
empt by up to one second, plus</span><br><span>   the time needed to resolv=
e each remote=2E A server answers only a few</span><br><span>diff --git a/s=
rc/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>inde=
x 960acd2=2E=2E65a4bd0 100644</span><br><span>--- a/src/openvpn/oob_client=
=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -2=
9,6 +29,8 @@</span><br><span> #include &quot;oob_client=2Eh&quot;</span><br=
><span> #include &quot;openvpn=2Eh&quot;</span><br><span> #include &quot;oo=
b=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;init=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;ssl=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&=
quot;</span><br><span> #include &quot;session_id=2Eh&quot;</span><br><span>=
 #include &quot;socket=2Eh&quot;</span><br><span>@@ -69,9 +71,9 @@</span><b=
r><span>     int round_start;  /* first transmission of the current round *=
/</span><br><span>     uint32_t id_base; /* random, so request_ids cannot b=
e guessed */</span><br><span>     /* What each probe is built from; only th=
e request_id differs=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct tls_auth_standalone *tas;</span><br><span>     struct ses=
sion_id *client_sid;</span><br><span>     struct oob_probe_request req;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t packet[64];  =
              /* the probe being sent */</span><br><span> #ifdef TARGET_AND=
ROID</span><br><span>     bool fd_protected[PROBE_AF_COUNT]; /* VPNService =
protect(), once per socket */</span><br><span> #endif</span><br><span>@@ -8=
5,20 +87,73 @@</span><br><span>     return (af =3D=3D AF_INET6) ? PROBE_AF_=
V6 : PROBE_AF_V4;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/* Build a plaintext SERVER_PROBE packet w=
ith the given request_id:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *   [opcode | key_id=3D0] [client session id] [probe request TLV]</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * This is the unauthentic=
ated OOB wire format; adding tls-auth/tls-crypt</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * wrapping for the probe is a follow-up (it only=
 works against a server with</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * no control-channel wrapping for now)=2E The result points into pc=
-&gt;packet:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * send i=
t before building the next=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* Build the standalone wrapping context the probe is sent wit=
h, mirroring the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
one the server answers it with, keyed like ce, the entry every other probed=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * remote was check=
ed against; without tls-auth/tls-crypt it stays in</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * TLS_WRAP_NONE and the probe goes out in p=
laintext=2E Returns NULL (and logs)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * for tls-crypt-v2, which the probe cannot carry yet=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct tls_a=
uth_standalone *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob=
_probe_init_tls_auth_standalone(struct context *c, const struct connection_=
entry *ce,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                          struct gc_arena *gc)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* tls-crypt-v2 wraps with a per-client key the server only le=
arns from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 wrapped client key (WKc) carried in the TLS handshake=2E An out-of-band</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * probe carries n=
o WKc, so the server cannot unwrap it; skip probing rather</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * than send something unverifia=
ble=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce=
-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_LOW, &quot;server-probe: not supported with tls-crypt-v2; using configu=
red order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* options=2Ece is not mapped =
yet; options_postprocess_mutate_ce() has already</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * copied any global key into ce=2E Loaded=
 again per-connection later=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    do_init_tls_wrap_key(c, ce);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct tls_options to;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(to);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, ce, c-&gt;options=2Etls=
_client, &amp;c-&gt;c1=2Eks, &amp;c-&gt;c1=2Epid_persist);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_window =3D c-&gt;opt=
ions=2Ereplay_window;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct tls_auth_standalone *tas =3D tls_auth_standalon=
e_init(&amp;to, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_init_contr=
ol_channel_frame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;tls_wrap=2Ework =
=3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;workbuf =3D alloc_buf_gc(BUF_=
SIZE(&amp;tas-&gt;frame), gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn tas;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Release the probe&#39;s wrapping context and t=
he key material</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * d=
o_init_tls_wrap_key() loaded for it: do_init_crypto_tls_c1() loads the same=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fields again lat=
er without freeing them first=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+oob_probe_free_wrap(struct context *c, struct tls_auth_standalone *=
tas)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    tls_auth_standalone_free(tas)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx_b=
i(&amp;c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    CLEAR(c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* the raw key bytes too: do_ini=
t_crypto_tls_c1() may never load a key over</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * them, so they would otherwise stay resident =
for the process lifetime */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    secure_memzero(&amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata, size=
of(c-&gt;c1=2Eks=2Eoriginal_wrap_keydata));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Build a wr=
apped SERVER_PROBE with the given request_id=2E The result points</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * into tas&#39;s work buffer=
s: send it before building the next=2E */</span><br><span> static bool</spa=
n><br><span> oob_probe_build(struct probe_ctx *pc, uint32_t request_id, str=
uct buffer *probe)</span><br><span> {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint8_t data[64];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer payload;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf_set_write(&amp;payload, data, sizeof(dat=
a));</span><br><span>     pc-&gt;req=2Erequest_id =3D request_id;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    buf_set_write(probe, pc-&gt=
;packet, sizeof(pc-&gt;packet));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPC=
ODE_SHIFT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 buf_write_u8(probe, header) &amp;&amp; session_id_write(pc-&gt;client_sid,=
 probe)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &am=
p;&amp; oob_probe_request_write(probe, &amp;pc-&gt;req);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!oob_probe_request_write(&amp;=
payload, &amp;pc-&gt;req))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *probe =3D tls_=
wrap_oob_standalone(&amp;pc-&gt;tas-&gt;tls_wrap, pc-&gt;tas, pc-&gt;client=
_sid, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return BLEN(probe) &gt; 0;</span><br><span> }</span><br><span> </span>=
<br><span> /* Was addr already probed in the current round? */</span><br><s=
pan>@@ -127,6 +182,7 @@</span><br><span>     struct buffer probe;</span><br=
><span>     if (!oob_probe_build(pc, pc-&gt;id_base + (uint32_t)pc-&gt;n_se=
nds, &amp;probe))</span><br><span>     {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: could not build=
 probe packet&quot;);</span><br><span>         return false;</span><br><spa=
n>     }</span><br><span>     openvpn_gettimeofday(&amp;s-&gt;sent_at, NULL=
);</span><br><span>@@ -201,6 +257,22 @@</span><br><span>            &amp;&a=
mp; str_equal_or_both_null(port_a, port_b);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Do a and b =
wrap the control channel with the same key (--tls-auth,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt, --tls-crypt-v2 and key =
direction)? Probes are wrapped with the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * first probeable entry&#39;s key, so a server keyed d=
ifferently could never answer</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * them=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_=
probe_same_wrap(const struct connection_entry *a, const struct connection_e=
ntry *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return str_equal_or_both_=
null(a-&gt;tls_auth_file, b-&gt;tls_auth_file)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt;tls_auth_file_inline=
 =3D=3D b-&gt;tls_auth_file_inline</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+           &amp;&amp; a-&gt;key_direction =3D=3D b-&gt;key_d=
irection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
&amp;&amp; str_equal_or_both_null(a-&gt;tls_crypt_file, b-&gt;tls_crypt_fil=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&=
amp; a-&gt;tls_crypt_file_inline =3D=3D b-&gt;tls_crypt_file_inline</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; str_e=
qual_or_both_null(a-&gt;tls_crypt_v2_file, b-&gt;tls_crypt_v2_file)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt=
;tls_crypt_v2_file_inline =3D=3D b-&gt;tls_crypt_v2_file_inline;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> /* Resolve the local bind addr=
ess of ce&#39;s connection socket; NULL with --nobind=2E</span><br><span>  =
* Fatal on failure, like the link socket=2E */</span><br><span> static stru=
ct addrinfo *</span><br><span>@@ -295,7 +367,7 @@</span><br><span> /* Parse=
 one received datagram as a PROBE_REPLY and, if valid and answering one</sp=
an><br><span>  * of the probes we sent, record the reply in results=2E */</=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-oob_probe_handle_reply(const struct probe_ctx *pc, const uint8_t *dat=
a, int len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_prob=
e_handle_reply(const struct probe_ctx *pc, uint8_t *data, int len,</span><b=
r><span>                        const struct openvpn_sockaddr *from, const =
struct oob_probe_target *targets,</span><br><span>                        s=
truct oob_probe_result *results, int n)</span><br><span> {</span><br><span>=
@@ -307,7 +379,19 @@</span><br><span> </span><br><span>     struct buffer b=
uf;</span><br><span>     buf_set_read(&amp;buf, data, (size_t)len);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_advance(&amp;buf, 1 +=
 SID_SIZE); /* skip opcode + server session id */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Unwrap the reply with the same control-channel path the s=
erver used to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 wrap it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in all=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modes) strip=
s the opcode + server session id, leaving buf at the OOB</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * message=2E read_control_auth() =
mutates the wrapping context, so we work on a</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * per-packet copy (as tls_pre_decrypt_lite()=
 does on the server)=2E The peer</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * address is only used for log messages, and tls_options =
only for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * tls-=
crypt-v2 metadata checks, so both are passed as NULL=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct tls_wrap_ctx wrap =3D pc-=
&gt;tas-&gt;tls_wrap;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!read_control_auth(&amp;buf, &amp;wrap, NULL, NULL))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return; /* not for us, or failed authe=
ntication */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span> </span><br><span>     struct oob_probe_reply reply;</span><=
br><span>     if (!oob_client_reply_read(&amp;buf, &amp;reply))</span><br><=
span>@@ -537,11 +621,20 @@</span><br><span>             tmpl =3D ce;</span>=
<br><span>             continue;</span><br><span>         }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const char *differs =3D NUL=
L;</span><br><span>         if (!oob_probe_same_bind(tmpl, ce, &amp;c-&gt;o=
ptions))</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(D_LOW, &quot;server-probe: %s:%s binds differ=
ently from %s:%s;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            differs =3D &quot;binds&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else if (!oob_probe_same_wrap(tmpl, ce))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            differs =3D &quot;wraps the=
 control channel&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (differs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(D_LOW, &quot;server-probe: %s:%s %s differently from %s:%s;&quot;</span><b=
r><span>                        &quot; not probing, using configured order&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 ce-&gt;remote, ce-&gt;remote_port, tmpl-&gt;remote, tmpl-&gt;remote_port);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ce-=
&gt;remote, ce-&gt;remote_port, differs, tmpl-&gt;remote, tmpl-&gt;remote_p=
ort);</span><br><span>             gc_free(&amp;gc);</span><br><span>      =
       return;</span><br><span>         }</span><br><span>@@ -553,12 +646,2=
5 @@</span><br><span>         return;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Wrapping =
context for the probe (tls-auth/tls-crypt, or plaintext if</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * neither)=2E NULL means this c=
onfiguration cannot be probed; keep the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * configured order=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone *tas =3D oob_p=
robe_init_tls_auth_standalone(c, tmpl, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!tas)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     struct probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, =
SOCKET_UNDEFINED } };</span><br><span>     struct oob_probe_target *targets=
 =3D gc_malloc(sizeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><spa=
n>     struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-=
&gt;len, true, &amp;gc);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* Every probe carries the same session id and tim=
estamp; each</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * tr=
ansmission gets a request_id of its own=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Every probe is a single probe request TLV,=
 wrapped (or sent in</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * plaintext) like any other control packet, with the client session i=
d as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the send=
er session id=2E Each transmission is built on its own, as each</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * carries its own request_=
id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Eta=
s =3D tas;</span><br><span>     pc=2Eclient_sid =3D &amp;client_sid;</span>=
<br><span>     pc=2Eid_base =3D (uint32_t)get_random();</span><br><span>   =
  pc=2Ereq =3D (struct oob_probe_request){</span><br><span>@@ -566,8 +672,1=
1 @@</span><br><span>         =2Eflags =3D 0,</span><br><span>     };</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D=
_LOW, &quot;server-probe: probing %d remote(s) with a %d ms window&quot;, l=
-&gt;len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        OOB_=
PROBE_WINDOW_MS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)=
  ? &quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                            : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRA=
P_AUTH) ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                                                =
    : &quot;none (plaintext)&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remote(s) wit=
h a %d ms window, control-channel wrapping: %s&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDOW_MS, w=
rap_name);</span><br><span> </span><br><span>     /* Resolve every remote f=
irst, so only the address families actually in use</span><br><span>      * =
get a probe socket=2E */</span><br><span>@@ -614,6 +723,7 @@</span><br><spa=
n>         {</span><br><span>             freeaddrinfo(bind_local);</span><=
br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        oob_probe_free_wrap(c, tas);</span><br><span>         gc_free(&amp;=
gc);</span><br><span>         return;</span><br><span>     }</span><br><spa=
n>@@ -707,5 +817,6 @@</span><br><span>     msg(M_INFO, &quot;server-probe: =
%d of %d probed remote(s) answered; connecting best-first&quot;,</span><br>=
<span>         responded, sent_count);</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    oob_probe_free_wrap(c, tas);</span=
><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=
=3Demail">change 1750</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1750?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1750 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 28 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--2ESC16XGRR8=--


--===============4636714926312273669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4636714926312273669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4636714926312273669==--

