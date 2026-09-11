Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F8EC88E5B
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Y+ymtRQQIUN+a3WVN7fMwfPYVnfZ09OtujakZd4B7LE=; b=C9fCA0shfbaQjM
	6D6jDQygmcalR60pYbvPGwp4h3ZMRnqsc3gTSIaKMffhle0oTXOusGlusdkzIdEhkLFmUgpv6GUG+
	kwF5wMdhM/wHddcSykesISQyVVwwe5SneODG3hNjAQjmTozZuFZmJlsdPAUxeFbgc5dVxr/JGtwGP
	Ae0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x536x-0007rS-7Q;
	Fri, 11 Sep 2026 15:24:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x536t-0007qO-Fc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9zxSX6k8BMjRbeg2D2J7peLX9kxiyh+D3xNN3P3PGpY=; b=V7EimefJulGeJpfLrADhE8oXeE
 yp5aGo/e946TX9RrH7fFAmRJtHf/ZqHgXRRncEf6mFZN8R5QV2R2fsZU978HWqzr1XxrHsbdOMtbN
 RTOlpPHi1kPD9F5cin0+NRpt8Vs+k0EV/Qv4zDFZ7sWcOT7MBiKsgQ8WFhesHeZPi+No=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9zxSX6k8BMjRbeg2D2J7peLX9kxiyh+D3xNN3P3PGpY=; b=O
 PS0clAwmTUIiRMkCJ/20zL3FrIDJFO62pyFzscxowW7BgsgprFaFk7lVCkO3ImGTW2M8+PBUWhxx1
 A0U0iczV7JoW/WmDIuunycrHb7z/7gSNllssXDSzSJKlXziXJ4J6/thpHx4qQ/IyXi/xaz4VuQZcg
 AYr1XEFb1no57QR8=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x536O-00019W-38 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:46 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso9631165e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140217; x=1789745017; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9zxSX6k8BMjRbeg2D2J7peLX9kxiyh+D3xNN3P3PGpY=;
 b=J7Uvr/H0eQi4awvjI4JzomZ58eneymuEx0E3UtD1w6OaC2Y42ffBBfDT1WPlP70pxY
 J49itn4B4TODZ3klID+1rejEuN2Sali8NBU33tlI+6jXJa7DTCVNgaiqlj+6utAzLT+s
 +L6qvO0yM7cgpFYp2lW0jMVAlptrmXAxMXR0SyEaQdS0L8Tj4sBYjZQ1TmxJ2A5MiznB
 9jQswqz+ApLkzJiwUUsxwN+uOyQ3iNoMH/f4DReo4tlDu41erLMhHBR9WEEHz2VhF/UO
 qr79cmShKIoly8qkJrb2QJ9FYQ1VeGfM2nQw2l58skfyuVGVTmuHnjxD7Qf1XLPEcysG
 f7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140217; x=1789745017;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9zxSX6k8BMjRbeg2D2J7peLX9kxiyh+D3xNN3P3PGpY=;
 b=i6eNlWbfqPeCEfLRvmc9teCQMrJ4oghXtf+QzI0uoNNZ5kyuGZRr1ZzFYNaPJdoCVf
 /EISfjXXX93bhzIKJK1SSdrEnfmv6FC93Equ1hFtJUm77o1xC1EnY0lff8aoraAHXoeW
 ZZqkzEqARPzx7sH7gT/yJNdY1zoWEB9dsLCehQvhw5f0itQXCqfyXFaHNl9D5PyvBc6i
 9l04hEx3iS07nzKg9/9Mi/vsw52AsJm9Ffk/RgE1KCC5mA4FMa5SnzKel6rsKBsV41T8
 EuBXa/tmoIqqDNgz1+SadPX2pZfEO8pL4oY8gW4O2tv+TxRjoFRBlX7lgybm2Lf/dzHj
 lcLw==
X-Gm-Message-State: AFuF++lfzZfEFBzTsXGcNKfhqZrGKs86ib8kXsPsrUeX4hHsKRjesVw8
 +Vb6HSV0W1nLkq/pEBcT1ZrXZZBfrWyW95zTjXW1YBu2+N95ILVfVyQFiKrr0Xjf49yc05x+fDc
 8OiscEER/5qgli/aVi8Mk+xhS7BfJz5M+7Lna6cHKmnhoibXLp03mlKmrhrWvhGDwnzMf
X-Gm-Gg: AYBFou2AWe0Mqdag/wZWMnkG2jOwQiKVbMitDEpGrufjD8cCn72lSstdwpiZssQ2kx3
 olEoLlX9C2ZlcWMZCCbJ/87ioSRX0yOBeHmhpIRTPbNBmzg8Um78LDI1e6VZ6lrluoNghxywKOs
 v/JyaRfhDpw2xqZtrMU828Y1qspfKlPQl3NJ66JpEipnBNqoT2obmXwDkJ0AwuZshJlOvqvdQRL
 uGo7sFDmKj7K2lx0UVF2XbEDo+L9hDSNinf0xdwrmMTDrhakbFsli9/aqNkAg27jAtbfrnxF2aA
 Ukd3rlmc3N/tgENOUgCtKUxgx9KlpdExSXHXADBOw6aOC9WhF3NRS1au5Ed6EaPRQKKwQ6OIJsR
 TuByoyH9BJZUFaYo+/frnIsx0fAWUlvhrkWCuRkNQy1JtvoYQ19wIGyr5d2/pPP610hPIUqUk0f
 x1MdjQc1HsykyscYAcidU0q3RhOPmFt/v/qVMnjnl84Tb6gdH4NglE9zKumqEBpj7Dz8nWfiDfC
 pU29fstYC/js0+GLcF+8YcesNhYizdgnEP8sdmnMlfRS/nq2ZUIc7oCS3qM3J8C0nximgzpY0u+
 BlVlDanW112JE/82VmoURY82JUPB66Se9TgDpl7sG+IwKi2OZ6bwNgNNj+VUVsLeo8lG+c9G
X-Received: by 2002:a05:600c:c490:b0:49c:ffde:45ff with SMTP id
 5b1f17b1804b1-49e619c18e0mr56419715e9.17.1789140216935; 
 Fri, 11 Sep 2026 08:23:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6221963dsm46446985e9.2.2026.09.11.08.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:23:36 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:23:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c
X-Gerrit-Change-Number: 1913
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1913?usp=email>
X-Gerrit-Commit: e4a4f15eedcf1ee5f7f07edcce62850160437482
References: <gerrit.1789140193000.I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTQwMTkzMDAwLkk3ZDhkYjE1YzIyMjYxMjc3YzQ0YTJlZmQzZDJlN2NmNzFmMjNlYTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8dc82477160e5adcf3e0f97faaf882de82e24c9d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x536O-00019W-38
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3474157188629640021=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3474157188629640021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kMG2CieH50k="; charset=UTF-8

--kMG2CieH50k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1913?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Wrap the client SERVER_PROBE with tls-auth/tls-crypt
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Wrap the clien=
t SERVER_PROBE with tls-auth/tls-crypt

The client --server-probe previousl=
y sent a plaintext SERVER_PROBE and
parsed replies by hand, so it only work=
ed against a server with no
control-channel wrapping=2E Build a standalone =
wrapping context for the
probe (mirroring the server's tls_auth_standalone)=
 and route both the
outgoing probe and the incoming replies through the sam=
e control-channel
path the rest of the code uses:

  - tls_wrap_oob_standal=
one() wraps the probe payload, applying the
    tls-auth HMAC or tls-crypt =
encryption (or nothing, when neither is
    configured)=2E
  - read_control=
_auth() unwraps each reply, verifying the HMAC /
    decrypting and strippi=
ng the opcode + session id, on a per-packet
    copy of the wrapping contex=
t (as tls_pre_decrypt_lite() does)=2E It
    decrypts in place, so oob_prob=
e_handle_reply() now takes a mutable
    buffer=2E

With neither tls-auth n=
or tls-crypt configured the context stays in
TLS_WRAP_NONE and the on-wire =
probe is byte-for-byte identical to
before, so the plaintext case is unchan=
ged=2E

tls-crypt-v2 is not supported yet: the server only learns the clien=
t key
from the WKc carried in the TLS handshake, which an out-of-band probe=

cannot provide=2E Such configurations skip probing and keep the configured=

remote order=2E

The probe is wrapped with the first remote's key, so prob=
ing is declined
when another remote is keyed differently=2E The key materia=
l loaded for
the probe is released afterwards; init loads it again for the
=
connection=2E Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Signed-o=
ff-by: Lev Stipakov <lev@openvpn=2Enet>

Change-Id: I7d8db15c22261277c44a2e=
fd3d2e7cf71f23ea0c
---
M doc/man-sections/client-options=2Erst
M src/openvp=
n/oob_client=2Ec
2 files changed, 168 insertions(+), 43 deletions(-)



  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/13/1913/1

=
diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/clien=
t-options=2Erst
index 8af481f=2E=2E933ed4b 100644
--- a/doc/man-sections/cl=
ient-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -617,19 +=
617,20 @@
   compared on latency alone, so only the fastest server of its p=
riority
   group is treated as best=2E
 
-  The probe is currently sent wit=
hout control-channel wrapping, so it only
-  works against a server configu=
red without ``--tls-auth``,
-  ``--tls-crypt`` or ``--tls-crypt-v2``=2E
+  =
The probe carries the same control-channel wrapping as a normal
+  connecti=
on (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With
+  ``--tls-=
crypt-v2`` the remotes are left in their configured order,
+  because the s=
erver cannot unwrap an out-of-band probe yet=2E
 
   Only UDP remotes are p=
robed, and only when there are at least two
   remotes; remotes reached thr=
ough a SOCKS proxy are not probed=2E All
   remotes must share the local bi=
nd settings (``--local``, ``--lport``,
-  ``--bind``) of the first one, oth=
erwise probing is skipped and the
-  configured order is used=2E Remotes th=
at answered are tried first, in the
-  order described above; all other rem=
otes, including TCP ones, follow in
-  their configured order=2E Probing ru=
ns once, before the first connection
-  attempt; a restart does not probe a=
gain=2E See ``--server-probe-reply``
-  for the server side=2E
+  ``--bind`=
`) and the control-channel key of the first one, otherwise
+  probing is sk=
ipped and the configured order is used=2E Remotes that
+  answered are trie=
d first, in the order described above; all other
+  remotes, including TCP =
ones, follow in their configured order=2E Probing
+  runs once, before the =
first connection attempt; a restart does not probe
+  again=2E See ``--serv=
er-probe-reply`` for the server side=2E
 
 --static-challenge args
   Enabl=
e static challenge/response protocol
diff --git a/src/openvpn/oob_client=2E=
c b/src/openvpn/oob_client=2Ec
index 05ccfc9=2E=2Ea6ae526 100644
--- a/src/=
openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -29,6 +29,8 @@
 =
#include "oob_client=2Eh"
 #include "openvpn=2Eh"
 #include "oob=2Eh"
+#inc=
lude "init=2Eh"
+#include "ssl=2Eh"
 #include "ssl_pkt=2Eh"
 #include "sess=
ion_id=2Eh"
 #include "socket=2Eh"
@@ -74,21 +76,67 @@
     return (af =3D=
=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
 }
 
-/* Build a plaintext SERVE=
R_PROBE packet:
- *   [opcode | key_id=3D0] [client session id] [SERVER_PRO=
BE message]
- * This is the unauthenticated OOB wire format; adding tls-aut=
h/tls-crypt
- * wrapping for the probe is a follow-up (it only works agains=
t a server with
- * no control-channel wrapping for now)=2E */
-static bool=

-oob_probe_build_packet(struct buffer *buf, const struct session_id *clien=
t_sid)
+/* Build a standalone control-channel wrapping context for the prob=
e, mirroring
+ * the tls_auth_standalone the server uses to answer it=2E Wi=
th neither tls-auth
+ * nor tls-crypt configured the context stays in TLS_W=
RAP_NONE and the probe is
+ * sent in plaintext, exactly as before; with ei=
ther configured the probe is
+ * authenticated/encrypted like any other con=
trol packet=2E Returns NULL (and
+ * logs) for configurations the probe can=
not wrap yet, in which case the caller
+ * skips probing and keeps the conf=
igured remote order=2E */
+static struct tls_auth_standalone *
+oob_probe_i=
nit_tls_auth_standalone(struct context *c, struct gc_arena *gc)
 {
-    con=
st struct oob_probe_parameter param =3D {
-        =2Etimestamp =3D (uint64=
_t)now,
-        =2Eflags =3D 0,
-    };
-    uint8_t header =3D (uint8_t)(=
P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
-    return buf_write_u8(buf, header) =
&& session_id_write(client_sid, buf)
-           && oob_server_probe_write(=
buf, &param);
+    /* The probe runs before next_connection_entry() maps a =
connection entry
+     * into options=2Ece, so take the wrapping config fro=
m the first connection
+     * entry directly=2E A global --tls-auth/--tls-=
crypt is copied into every
+     * connection-list entry by options_postpro=
cess_mutate_ce(), so the first
+     * entry carries it even though options=
=2Ece does not yet=2E (Probing wraps a
+     * single packet for all remote=
s, so per-connection-block keys are not
+     * supported; the first entry'=
s wrapping is used for all=2E) */
+    const struct connection_entry *ce =
=3D c->options=2Econnection_list->array[0];
+
+    /* tls-crypt-v2 wraps wi=
th a per-client key the server only learns from the
+     * wrapped client =
key (WKc) carried in the TLS handshake=2E An out-of-band
+     * probe carr=
ies no WKc, so the server cannot unwrap it; skip probing rather
+     * tha=
n send something unverifiable=2E */
+    if (ce->tls_crypt_v2_file)
+    {
=
+        msg(D_LOW, "server-probe: not supported with tls-crypt-v2; using c=
onfigured order");
+        return NULL;
+    }
+
+    /* Load the tls-auth=
/tls-crypt key material into c->c1=2Eks (a no-op if neither
+     * is conf=
igured)=2E This is run again per-connection later; calling it early
+     *=
 here is harmless=2E */
+    do_init_tls_wrap_key(c, ce);
+
+    struct tls=
_options to;
+    CLEAR(to);
+    init_tls_wrap_ctx(&to=2Etls_wrap, ce, c->=
options=2Etls_client, &c->c1=2Eks, &c->c1=2Epid_persist);
+    to=2Ereplay_=
window =3D c->options=2Ereplay_window;
+    to=2Ereplay_time =3D c->options=
=2Ereplay_time;
+
+    struct tls_auth_standalone *tas =3D tls_auth_standal=
one_init(&to, gc);
+
+    /* Control-channel frame and work buffers, mirror=
ing do_init_frame_tls()=2E */
+    tls_init_control_channel_frame_parameter=
s(&tas->frame, ce->tls_mtu);
+    tas->tls_wrap=2Ework =3D alloc_buf_gc(BUF=
_SIZE(&tas->frame), gc);
+    tas->workbuf =3D alloc_buf_gc(BUF_SIZE(&tas->=
frame), gc);
+
+    return tas;
+}
+
+/* Release the probe's wrapping conte=
xt and the key material
+ * do_init_tls_wrap_key() loaded for it: do_init_c=
rypto_tls_c1() loads the same
+ * fields again later without freeing them f=
irst=2E */
+static void
+oob_probe_free_wrap(struct context *c, struct tls_=
auth_standalone *tas)
+{
+    tls_auth_standalone_free(tas);
+    free_key_=
ctx_bi(&c->c1=2Eks=2Etls_wrap_key);
+    CLEAR(c->c1=2Eks=2Etls_wrap_key);
=
+    buf_clear(&c->c1=2Eks=2Etls_crypt_v2_wkc);
+    free_buf(&c->c1=2Eks=
=2Etls_crypt_v2_wkc);
 }
 
 /* The local address and port ce's connection s=
ocket binds: its first --local,
@@ -140,6 +188,21 @@
            && str_equ=
al_or_both_null(port_a, port_b);
 }
 
+/* Do a and b wrap the control chann=
el with the same key (--tls-auth,
+ * --tls-crypt, --tls-crypt-v2 and key d=
irection)? The one probe is wrapped
+ * with entry 0's key, so a server key=
ed differently could never answer it=2E */
+static bool
+oob_probe_same_wra=
p(const struct connection_entry *a, const struct connection_entry *b)
+{
+ =
   return str_equal_or_both_null(a->tls_auth_file, b->tls_auth_file)
+     =
      && a->tls_auth_file_inline =3D=3D b->tls_auth_file_inline
+          =
 && a->key_direction =3D=3D b->key_direction
+           && str_equal_or_bo=
th_null(a->tls_crypt_file, b->tls_crypt_file)
+           && a->tls_crypt_f=
ile_inline =3D=3D b->tls_crypt_file_inline
+           && str_equal_or_both=
_null(a->tls_crypt_v2_file, b->tls_crypt_v2_file)
+           && a->tls_cry=
pt_v2_file_inline =3D=3D b->tls_crypt_v2_file_inline;
+}
+
 /* Resolve the =
local bind address of ce's connection socket; NULL with --nobind=2E
  * Fat=
al on failure, like the link socket=2E */
 static struct addrinfo *
@@ -228=
,9 +291,9 @@
 /* Parse one received datagram as a PROBE_REPLY and, if valid=
 and matching one
  * of the probes we sent, record the reply in results=2E=
 */
 static void
-oob_probe_handle_reply(const uint8_t *data, int len, cons=
t struct session_id *client_sid,
-                       const struct openv=
pn_sockaddr *from, const struct oob_probe_target *targets,
-               =
        struct oob_probe_result *results, int n)
+oob_probe_handle_reply(ui=
nt8_t *data, int len, const struct session_id *client_sid,
+               =
        const struct tls_wrap_ctx *base_wrap, const struct openvpn_sockaddr=
 *from,
+                       const struct oob_probe_target *targets, str=
uct oob_probe_result *results, int n)
 {
     /* Need at least the opcode b=
yte and the session id=2E */
     if (len < 1 + (int)SID_SIZE || (data[0] >=
> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
@@ -240,7 +303,20 @@
 
     struct=
 buffer buf;
     buf_set_read(&buf, data, (size_t)len);
-    buf_advance(&=
buf, 1 + SID_SIZE); /* skip opcode + server session id */
+
+    /* Unwrap =
the reply with the same control-channel path the server used to
+     * wra=
p it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in all
+  =
   * modes) strips the opcode + server session id, leaving buf at the TLV
+=
     * payload=2E With no tls-auth/tls-crypt it just strips those header by=
tes, as
+     * before=2E read_control_auth() mutates the wrapping context,=
 so we work on a
+     * per-packet copy (as tls_pre_decrypt_lite() does on=
 the server)=2E The peer
+     * address is only used for log messages, and=
 tls_options only for
+     * tls-crypt-v2 metadata checks, so both are pas=
sed as NULL=2E */
+    struct tls_wrap_ctx wrap =3D *base_wrap;
+    if (!r=
ead_control_auth(&buf, &wrap, NULL, NULL))
+    {
+        return; /* not f=
or us, or failed authentication */
+    }
 
     struct oob_probe_reply rep=
ly;
     if (!oob_client_reply_read(&buf, &reply))
@@ -290,8 +366,9 @@
  * =
matches a probe we sent=2E Returns true if every sent probe has been answer=
ed=2E */
 static bool
 oob_probe_receive_slice(const struct probe_ctx *pc, =
const struct timeval *deadline,
-                        const struct sessi=
on_id *client_sid, const struct oob_probe_target *targets,
-               =
         struct oob_probe_result *results, int n, int outstanding)
+       =
                 const struct session_id *client_sid, const struct tls_wrap=
_ctx *wrap,
+                        const struct oob_probe_target *targets=
, struct oob_probe_result *results, int n,
+                        int out=
standing)
 {
     while (true)
     {
@@ -341,7 +418,7 @@
                 =
                    (struct sockaddr *)&from, &fromlen);
             if (l=
en > 0)
             {
-                oob_probe_handle_reply(data, len, c=
lient_sid, &from, targets, results, n);
+                oob_probe_handle_r=
eply(data, len, client_sid, wrap, &from, targets, results, n);
            =
 }
         }
         if (oob_count_answered(targets, results, n) >=3D out=
standing)
@@ -383,8 +460,8 @@
  * once the window elapses or every sent pro=
be has been answered=2E */
 static void
 oob_probe_collect(struct probe_ctx=
 *pc, const struct buffer *probe,
-                  const struct session_i=
d *client_sid, const struct oob_probe_target *targets,
-                  s=
truct oob_probe_result *results, int n,
+                  const struct ses=
sion_id *client_sid, const struct tls_wrap_ctx *wrap,
+                  co=
nst struct oob_probe_target *targets, struct oob_probe_result *results, int=
 n,
                   const struct signal_info *sig)
 {
     /* number of =
probes we actually sent: stop early once they all answer */
@@ -409,7 +486,=
7 @@
             deadline=2Etv_usec -=3D 1000000;
         }
 
-        if=
 (oob_probe_receive_slice(pc, &deadline, client_sid, targets, results, n, w=
ant)
+        if (oob_probe_receive_slice(pc, &deadline, client_sid, wrap, =
targets, results, n, want)
             || sig->signal_received)
         {=

             return; /* all answered, or we are being told to stop */
@@ -=
452,6 +529,16 @@
 
     struct gc_arena gc =3D gc_new();
 
+    /* Wrapping=
 context for the probe (tls-auth/tls-crypt, or plaintext if
+     * neither=
)=2E NULL means this configuration cannot be probed; keep the
+     * confi=
gured order=2E */
+    struct tls_auth_standalone *tas =3D oob_probe_init_t=
ls_auth_standalone(c, &gc);
+    if (!tas)
+    {
+        gc_free(&gc);
+ =
       return;
+    }
+
     /* A single random session id identifies all o=
f our probes; servers echo it
      * back in the reply's peer_session_id, =
letting us reject spoofed replies=2E */
     struct session_id client_sid;
=
@@ -463,12 +550,25 @@
     for (int i =3D 1; i < l->len; i++)
     {
      =
   const struct connection_entry *ce =3D l->array[i];
-        if (ce->remo=
te && proto_is_udp(ce->proto)
-            && !oob_probe_same_bind(l->array=
[0], ce, &c->options))
+        if (!ce->remote || !proto_is_udp(ce->proto)=
)
         {
-            msg(D_LOW, "server-probe: %s:%s binds differently=
 from the first remote;"
+            continue;
+        }
+        const c=
har *differs =3D NULL;
+        if (!oob_probe_same_bind(l->array[0], ce, &=
c->options))
+        {
+            differs =3D "binds";
+        }
+     =
   else if (!oob_probe_same_wrap(l->array[0], ce))
+        {
+            =
differs =3D "wraps the control channel";
+        }
+        if (differs)
+=
        {
+            msg(D_LOW, "server-probe: %s:%s %s differently from =
the first remote;"
                        " not probing, using configured =
order",
-                ce->remote, ce->remote_port);
+                ce-=
>remote, ce->remote_port, differs);
+            oob_probe_free_wrap(c, tas=
);
             gc_free(&gc);
             return;
         }
@@ -478,17 +5=
78,39 @@
     struct oob_probe_target *targets =3D gc_malloc(sizeof(*target=
s) * l->len, true, &gc);
     struct oob_probe_result *results =3D gc_mallo=
c(sizeof(*results) * l->len, true, &gc);
 
-    struct buffer probe =3D all=
oc_buf_gc(256, &gc);
-    if (!oob_probe_build_packet(&probe, &client_sid))=

+    /* Build the probe once and reuse the same bytes for every remote and=
 for
+     * resends: the SERVER_PROBE payload is a single probe_parameter =
TLV, wrapped
+     * (or sent in plaintext) like any other control packet=
=2E The client session
+     * id is prepended as the sender session id=2E =
*/
+    struct buffer payload =3D alloc_buf_gc(64, &gc);
+    const struct =
oob_probe_parameter param =3D {
+        =2Etimestamp =3D (uint64_t)now,
+ =
       =2Eflags =3D 0,
+    };
+    if (!oob_server_probe_write(&payload, &=
param))
     {
-        msg(D_LOW, "server-probe: could not build probe pac=
ket; using configured order");
+        msg(D_LOW, "server-probe: could not=
 build probe payload; using configured order");
         oob_probe_sockets_=
close(&pc);
+        oob_probe_free_wrap(c, tas);
         gc_free(&gc);
  =
       return;
     }
 
-    msg(D_LOW, "server-probe: probing %d remote(s)=
 with a %d ms window", l->len,
-        OOB_PROBE_WINDOW_MS);
+    struct b=
uffer probe =3D tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_sid, &=
payload);
+    if (!BLEN(&probe))
+    {
+        msg(D_LOW, "server-probe:=
 could not wrap probe packet; using configured order");
+        oob_probe_=
sockets_close(&pc);
+        oob_probe_free_wrap(c, tas);
+        gc_free(=
&gc);
+        return;
+    }
+
+    const char *wrap_name =3D (tas->tls_wr=
ap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
+                          =
  : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
+             =
                                                       : "none (plaintext)"=
;
+    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window, =
control-channel wrapping: %s",
+        l->len, OOB_PROBE_WINDOW_MS, wrap_n=
ame);
 
     /* Resolve every remote first, so only the address families ac=
tually in use
      * get a probe socket=2E */
@@ -543,6 +665,7 @@
        =
 {
             freeaddrinfo(bind_local);
         }
+        oob_probe_fre=
e_wrap(c, tas);
         gc_free(&gc);
         return;
     }
@@ -584,7 +7=
07,7 @@
 
     if (sent_count > 0)
     {
-        oob_probe_collect(&pc, &=
probe, &client_sid, targets, results, l->len,
+        oob_probe_collect(&p=
c, &probe, &client_sid, &tas->tls_wrap, targets, results, l->len,
         =
                  c->sig);
     }
     oob_probe_sockets_close(&pc);
@@ -63=
2,5 +755,6 @@
     msg(M_INFO, "server-probe: %d of %d remote(s) answered; =
connecting best-first", responded,
         l->len);
 
+    oob_probe_free_=
wrap(c, tas);
     gc_free(&gc);
 }

-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1913?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c
Gerrit-Change-Nu=
mber: 1913
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>

--kMG2CieH50k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1913?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Wrap the client SERVER_PROBE with tls-auth/tls-crypt<br><br>The client -=
-server-probe previously sent a plaintext SERVER_PROBE and<br>parsed replie=
s by hand, so it only worked against a server with no<br>control-channel wr=
apping=2E Build a standalone wrapping context for the<br>probe (mirroring t=
he server&#39;s tls_auth_standalone) and route both the<br>outgoing probe a=
nd the incoming replies through the same control-channel<br>path the rest o=
f the code uses:<br><br>  - tls_wrap_oob_standalone() wraps the probe paylo=
ad, applying the<br>    tls-auth HMAC or tls-crypt encryption (or nothing, =
when neither is<br>    configured)=2E<br>  - read_control_auth() unwraps ea=
ch reply, verifying the HMAC /<br>    decrypting and stripping the opcode +=
 session id, on a per-packet<br>    copy of the wrapping context (as tls_pr=
e_decrypt_lite() does)=2E It<br>    decrypts in place, so oob_probe_handle_=
reply() now takes a mutable<br>    buffer=2E<br><br>With neither tls-auth n=
or tls-crypt configured the context stays in<br>TLS_WRAP_NONE and the on-wi=
re probe is byte-for-byte identical to<br>before, so the plaintext case is =
unchanged=2E<br><br>tls-crypt-v2 is not supported yet: the server only lear=
ns the client key<br>from the WKc carried in the TLS handshake, which an ou=
t-of-band probe<br>cannot provide=2E Such configurations skip probing and k=
eep the configured<br>remote order=2E<br><br>The probe is wrapped with the =
first remote&#39;s key, so probing is declined<br>when another remote is ke=
yed differently=2E The key material loaded for<br>the probe is released aft=
erwards; init loads it again for the<br>connection=2E Change-Id: I1f9d7b5a5=
ec19bf77c0c212795f583c5ba4c03ac<br>Signed-off-by: Lev Stipakov &lt;lev@open=
vpn=2Enet&gt;<br><br>Change-Id: I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c<b=
r>---<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob_clien=
t=2Ec<br>2 files changed, 168 insertions(+), 43 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/13/1913/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/doc/man-sections/client-options=2Erst b/d=
oc/man-sections/client-options=2Erst</span><br><span>index 8af481f=2E=2E933=
ed4b 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst</sp=
an><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@@=
 -617,19 +617,20 @@</span><br><span>   compared on latency alone, so only t=
he fastest server of its priority</span><br><span>   group is treated as be=
st=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  The probe is currently sent without control-channel wrapping, so it onl=
y</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  works against a se=
rver configured without ``--tls-auth``,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  ``--tls-crypt`` or ``--tls-crypt-v2``=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  The probe carries the same contr=
ol-channel wrapping as a normal</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  connection (``--tls-auth`` or ``--tls-crypt``, when configure=
d)=2E With</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls=
-crypt-v2`` the remotes are left in their configured order,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  because the server cannot unwrap =
an out-of-band probe yet=2E</span><br><span> </span><br><span>   Only UDP r=
emotes are probed, and only when there are at least two</span><br><span>   =
remotes; remotes reached through a SOCKS proxy are not probed=2E All</span>=
<br><span>   remotes must share the local bind settings (``--local``, ``--l=
port``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--bind``) =
of the first one, otherwise probing is skipped and the</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  configured order is used=2E Remotes that=
 answered are tried first, in the</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  order described above; all other remotes, including TCP ones,=
 follow in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  their con=
figured order=2E Probing runs once, before the first connection</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  attempt; a restart does not pro=
be again=2E See ``--server-probe-reply``</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  for the server side=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  ``--bind``) and the control-channel key of the fi=
rst one, otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 probing is skipped and the configured order is used=2E Remotes that</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  answered are tried first=
, in the order described above; all other</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  remotes, including TCP ones, follow in their config=
ured order=2E Probing</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  runs once, before the first connection attempt; a restart does not prob=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  again=2E See ``-=
-server-probe-reply`` for the server side=2E</span><br><span> </span><br><s=
pan> --static-challenge args</span><br><span>   Enable static challenge/res=
ponse protocol</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/sr=
c/openvpn/oob_client=2Ec</span><br><span>index 05ccfc9=2E=2Ea6ae526 100644<=
/span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/=
openvpn/oob_client=2Ec</span><br><span>@@ -29,6 +29,8 @@</span><br><span> #=
include &quot;oob_client=2Eh&quot;</span><br><span> #include &quot;openvpn=
=2Eh&quot;</span><br><span> #include &quot;oob=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;init=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl=2Eh&quot;=
</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span> #includ=
e &quot;session_id=2Eh&quot;</span><br><span> #include &quot;socket=2Eh&quo=
t;</span><br><span>@@ -74,21 +76,67 @@</span><br><span>     return (af =3D=
=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Build a plaint=
ext SERVER_PROBE packet:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *   [opcode | key_id=3D0] [client session id] [SERVER_PROBE message]</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * This is the unauthent=
icated OOB wire format; adding tls-auth/tls-crypt</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * wrapping for the probe is a follow-up (it on=
ly works against a server with</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * no control-channel wrapping for now)=2E */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-oob_probe_build_packet(struct buffer *buf, const str=
uct session_id *client_sid)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Build a standalone control-channel wrapping context for the prob=
e, mirroring</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the =
tls_auth_standalone the server uses to answer it=2E With neither tls-auth</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * nor tls-crypt conf=
igured the context stays in TLS_WRAP_NONE and the probe is</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * sent in plaintext, exactly as bef=
ore; with either configured the probe is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * authenticated/encrypted like any other control pack=
et=2E Returns NULL (and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * logs) for configurations the probe cannot wrap yet, in which case th=
e caller</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * skips pr=
obing and keeps the configured remote order=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static struct tls_auth_standalone *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_init_tls_auth_stand=
alone(struct context *c, struct gc_arena *gc)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const struct oob_probe_param=
eter param =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   =2Etimestamp =3D (uint64_t)now,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return buf_write_=
u8(buf, header) &amp;&amp; session_id_write(client_sid, buf)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; oob_server_pro=
be_write(buf, &amp;param);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* The probe runs before next_connection_entry() maps a connecti=
on entry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * into=
 options=2Ece, so take the wrapping config from the first connection</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * entry directly=2E A=
 global --tls-auth/--tls-crypt is copied into every</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * connection-list entry by options_p=
ostprocess_mutate_ce(), so the first</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * entry carries it even though options=2Ece does not =
yet=2E (Probing wraps a</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * single packet for all remotes, so per-connection-block keys are =
not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * supported=
; the first entry&#39;s wrapping is used for all=2E) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct connection_entry *ce =
=3D c-&gt;options=2Econnection_list-&gt;array[0];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* tls-crypt-v2 wraps with a per-client key the server only =
learns from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * wrapped client key (WKc) carried in the TLS handshake=2E An out-of-band<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * probe carries=
 no WKc, so the server cannot unwrap it; skip probing rather</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * than send something unverif=
iable=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
ce-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(D_LOW, &quot;server-probe: not supported with tls-crypt-v2; using confi=
gured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Load the tls-auth/tls-cry=
pt key material into c-&gt;c1=2Eks (a no-op if neither</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * is configured)=2E This is run aga=
in per-connection later; calling it early</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * here is harmless=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    do_init_tls_wrap_key(c, ce);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct tls_options to;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    CLEAR(to);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, ce,=
 c-&gt;options=2Etls_client, &amp;c-&gt;c1=2Eks, &amp;c-&gt;c1=2Epid_persis=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_=
window =3D c-&gt;options=2Ereplay_window;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone *tas =
=3D tls_auth_standalone_init(&amp;to, gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Control-channel frame and work buffers, mirroring do_init_frame_=
tls()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_=
init_control_channel_frame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;tls_wrap=
=2Ework =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;workbuf =3D alloc_buf_g=
c(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return tas;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Release the probe&#39;s wrapping conte=
xt and the key material</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * do_init_tls_wrap_key() loaded for it: do_init_crypto_tls_c1() loads =
the same</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fields a=
gain later without freeing them first=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+oob_probe_free_wrap(struct context *c, struct tls_auth_stan=
dalone *tas)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_auth_standalone_f=
ree(tas);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_k=
ey_ctx_bi(&amp;c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    CLEAR(c-&gt;c1=2Eks=2Etls_wrap_key);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;c-&gt;c1=
=2Eks=2Etls_crypt_v2_wkc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free_buf(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc);</span><br><span=
> }</span><br><span> </span><br><span> /* The local address and port ce&#39=
;s connection socket binds: its first --local,</span><br><span>@@ -140,6 +1=
88,21 @@</span><br><span>            &amp;&amp; str_equal_or_both_null(port=
_a, port_b);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Do a and b wrap the control channel with t=
he same key (--tls-auth,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * --tls-crypt, --tls-crypt-v2 and key direction)? The one probe is wr=
apped</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * with entry =
0&#39;s key, so a server keyed differently could never answer it=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+oob_probe_same_wrap(const struct=
 connection_entry *a, const struct connection_entry *b)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return str_equal_or_both_null(a-&gt;tls_auth_file, b-=
&gt;tls_auth_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
          &amp;&amp; a-&gt;tls_auth_file_inline =3D=3D b-&gt;tls_auth_file_=
inline</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &a=
mp;&amp; a-&gt;key_direction =3D=3D b-&gt;key_direction</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; str_equal_or_both=
_null(a-&gt;tls_crypt_file, b-&gt;tls_crypt_file)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt;tls_crypt_file_in=
line =3D=3D b-&gt;tls_crypt_file_inline</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+           &amp;&amp; str_equal_or_both_null(a-&gt;tls_=
crypt_v2_file, b-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+           &amp;&amp; a-&gt;tls_crypt_v2_file_inline =
=3D=3D b-&gt;tls_crypt_v2_file_inline;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> /* Resolve the local bind address of ce&#39;s connection=
 socket; NULL with --nobind=2E</span><br><span>  * Fatal on failure, like t=
he link socket=2E */</span><br><span> static struct addrinfo *</span><br><s=
pan>@@ -228,9 +291,9 @@</span><br><span> /* Parse one received datagram as =
a PROBE_REPLY and, if valid and matching one</span><br><span>  * of the pro=
bes we sent, record the reply in results=2E */</span><br><span> static void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-oob_probe_handle_repl=
y(const uint8_t *data, int len, const struct session_id *client_sid,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                       const=
 struct openvpn_sockaddr *from, const struct oob_probe_target *targets,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                       st=
ruct oob_probe_result *results, int n)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_probe_handle_reply(uint8_t *data, int len, const str=
uct session_id *client_sid,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                       const struct tls_wrap_ctx *base_wrap, const =
struct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                       const struct oob_probe_target *targets, s=
truct oob_probe_result *results, int n)</span><br><span> {</span><br><span>=
     /* Need at least the opcode byte and the session id=2E */</span><br><s=
pan>     if (len &lt; 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_SHIFT=
) !=3D P_CONTROL_OOB_V1)</span><br><span>@@ -240,7 +303,20 @@</span><br><sp=
an> </span><br><span>     struct buffer buf;</span><br><span>     buf_set_r=
ead(&amp;buf, data, (size_t)len);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    buf_advance(&amp;buf, 1 + SID_SIZE); /* skip opcode + serve=
r session id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Unwrap the reply=
 with the same control-channel path the server used to</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * wrap it: this verifies the tls-au=
th HMAC / decrypts tls-crypt, and (in all</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * modes) strips the opcode + server session id, =
leaving buf at the TLV</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * payload=2E With no tls-auth/tls-crypt it just strips those header=
 bytes, as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * be=
fore=2E read_control_auth() mutates the wrapping context, so we work on a</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * per-packet cop=
y (as tls_pre_decrypt_lite() does on the server)=2E The peer</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * address is only used for lo=
g messages, and tls_options only for</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * tls-crypt-v2 metadata checks, so both are passed as=
 NULL=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct tls_wrap_ctx wrap =3D *base_wrap;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!read_control_auth(&amp;buf, &amp;wrap, NULL, NULL=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return; /* not for us, =
or failed authentication */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span> </span><br><span>     struct oob_probe_reply=
 reply;</span><br><span>     if (!oob_client_reply_read(&amp;buf, &amp;repl=
y))</span><br><span>@@ -290,8 +366,9 @@</span><br><span>  * matches a probe=
 we sent=2E Returns true if every sent probe has been answered=2E */</span>=
<br><span> static bool</span><br><span> oob_probe_receive_slice(const struc=
t probe_ctx *pc, const struct timeval *deadline,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        const struct session_id =
*client_sid, const struct oob_probe_target *targets,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        struct oob_probe_re=
sult *results, int n, int outstanding)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        const struct session_id *client_=
sid, const struct tls_wrap_ctx *wrap,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        const struct oob_probe_target *ta=
rgets, struct oob_probe_result *results, int n,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        int outstanding)</span>=
<br><span> {</span><br><span>     while (true)</span><br><span>     {</span=
><br><span>@@ -341,7 +418,7 @@</span><br><span>                            =
         (struct sockaddr *)&amp;from, &amp;fromlen);</span><br><span>     =
        if (len &gt; 0)</span><br><span>             {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                oob_probe_handle_reply(dat=
a, len, client_sid, &amp;from, targets, results, n);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                oob_probe_handle_reply(da=
ta, len, client_sid, wrap, &amp;from, targets, results, n);</span><br><span=
>             }</span><br><span>         }</span><br><span>         if (oob=
_count_answered(targets, results, n) &gt;=3D outstanding)</span><br><span>@=
@ -383,8 +460,8 @@</span><br><span>  * once the window elapses or every sen=
t probe has been answered=2E */</span><br><span> static void</span><br><spa=
n> oob_probe_collect(struct probe_ctx *pc, const struct buffer *probe,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                  const st=
ruct session_id *client_sid, const struct oob_probe_target *targets,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                  struct oob=
_probe_result *results, int n,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                  const struct session_id *client_sid, const str=
uct tls_wrap_ctx *wrap,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                  const struct oob_probe_target *targets, struct oob_pr=
obe_result *results, int n,</span><br><span>                   const struct=
 signal_info *sig)</span><br><span> {</span><br><span>     /* number of pro=
bes we actually sent: stop early once they all answer */</span><br><span>@@=
 -409,7 +486,7 @@</span><br><span>             deadline=2Etv_usec -=3D 1000=
000;</span><br><span>         }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (oob_probe_receive_slice(pc, &amp;de=
adline, client_sid, targets, results, n, want)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (oob_probe_receive_slice(pc, &amp;dea=
dline, client_sid, wrap, targets, results, n, want)</span><br><span>       =
      || sig-&gt;signal_received)</span><br><span>         {</span><br><spa=
n>             return; /* all answered, or we are being told to stop */</sp=
an><br><span>@@ -452,6 +529,16 @@</span><br><span> </span><br><span>     st=
ruct gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Wrapping context for the probe (tls-aut=
h/tls-crypt, or plaintext if</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * neither)=2E NULL means this configuration cannot be probed;=
 keep the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * con=
figured order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct tls_auth_standalone *tas =3D oob_probe_init_tls_auth_standalone(=
c, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!tas)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* A single rando=
m session id identifies all of our probes; servers echo it</span><br><span>=
      * back in the reply&#39;s peer_session_id, letting us reject spoofed =
replies=2E */</span><br><span>     struct session_id client_sid;</span><br>=
<span>@@ -463,12 +550,25 @@</span><br><span>     for (int i =3D 1; i &lt; l=
-&gt;len; i++)</span><br><span>     {</span><br><span>         const struct=
 connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (ce-&gt;remote &amp;&amp; proto_is_udp(ce-&g=
t;proto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &=
amp;&amp; !oob_probe_same_bind(l-&gt;array[0], ce, &amp;c-&gt;options))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ce-&gt;rem=
ote || !proto_is_udp(ce-&gt;proto))</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LOW, &quot;serve=
r-probe: %s:%s binds differently from the first remote;&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const char *differs =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_probe_=
same_bind(l-&gt;array[0], ce, &amp;c-&gt;options))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            differs =3D &quot;binds&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else if (!oob_probe_same_wrap(l-&=
gt;array[0], ce))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
differs =3D &quot;wraps the control channel&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (differs)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s %s differently=
 from the first remote;&quot;</span><br><span>                        &quot=
; not probing, using configured order&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                ce-&gt;remote, ce-&gt;remote_port);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ce-&=
gt;remote, ce-&gt;remote_port, differs);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            oob_probe_free_wrap(c, tas);</span><br><sp=
an>             gc_free(&amp;gc);</span><br><span>             return;</spa=
n><br><span>         }</span><br><span>@@ -478,17 +578,39 @@</span><br><spa=
n>     struct oob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l-=
&gt;len, true, &amp;gc);</span><br><span>     struct oob_probe_result *resu=
lts =3D gc_malloc(sizeof(*results) * l-&gt;len, true, &amp;gc);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buff=
er probe =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!oob_probe_build_packet(&amp;probe, &amp;client_=
sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Build t=
he probe once and reuse the same bytes for every remote and for</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * resends: the SERVER_PROB=
E payload is a single probe_parameter TLV, wrapped</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * (or sent in plaintext) like any other=
 control packet=2E The client session</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * id is prepended as the sender session id=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer paylo=
ad =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct oob_probe_parameter param =3D {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D (uint64=
_t)now,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ef=
lags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_server_p=
robe_write(&amp;payload, &amp;param))</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;server-prob=
e: could not build probe packet; using configured order&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server=
-probe: could not build probe payload; using configured order&quot;);</span=
><br><span>         oob_probe_sockets_close(&amp;pc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        oob_probe_free_wrap(c, tas);</spa=
n><br><span>         gc_free(&amp;gc);</span><br><span>         return;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    msg(D_LOW, &quot;server-probe: probing %d remote(s) wit=
h a %d ms window&quot;, l-&gt;len,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        OOB_PROBE_WINDOW_MS);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer probe =3D tls_wrap_oob_standalone(=
&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!BLEN(&amp;probe))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: co=
uld not wrap probe packet; using configured order&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        oob_probe_sockets_close(&amp;=
pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_pro=
be_free_wrap(c, tas);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *wrap_name =3D=
 (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &quot;tls-crypt&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? &quot;tls-auth&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                                                    : &quot;none (plaintext=
)&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_L=
OW, &quot;server-probe: probing %d remote(s) with a %d ms window, control-c=
hannel wrapping: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_name);</span><br><span>=
 </span><br><span>     /* Resolve every remote first, so only the address f=
amilies actually in use</span><br><span>      * get a probe socket=2E */</s=
pan><br><span>@@ -543,6 +665,7 @@</span><br><span>         {</span><br><spa=
n>             freeaddrinfo(bind_local);</span><br><span>         }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_free_wrap=
(c, tas);</span><br><span>         gc_free(&amp;gc);</span><br><span>      =
   return;</span><br><span>     }</span><br><span>@@ -584,7 +707,7 @@</span=
><br><span> </span><br><span>     if (sent_count &gt; 0)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        oob_probe=
_collect(&amp;pc, &amp;probe, &amp;client_sid, targets, results, l-&gt;len,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_c=
ollect(&amp;pc, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wrap, targets=
, results, l-&gt;len,</span><br><span>                           c-&gt;sig)=
;</span><br><span>     }</span><br><span>     oob_probe_sockets_close(&amp;=
pc);</span><br><span>@@ -632,5 +755,6 @@</span><br><span>     msg(M_INFO, &=
quot;server-probe: %d of %d remote(s) answered; connecting best-first&quot;=
, responded,</span><br><span>         l-&gt;len);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_free_wrap(c, =
tas);</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1913?usp=3Demail">change 1913</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1913?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I7d8db15c22261277c44a2efd3d2=
e7cf71f23ea0c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 191=
3 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>

</body></html>
--kMG2CieH50k=--


--===============3474157188629640021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3474157188629640021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3474157188629640021==--

