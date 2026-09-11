Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AC9C88E53
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7LD6cEi7ueZc5+J40oG580jgGMar7Z7RGxFtcWGFfyw=; b=jCdjLY04KtIFx8bthj8+tX8uuL
	by+wwYNm6Z9KOVJgRLMlKR53fcJ4hJ5PYzOFmmj2EtcTND5gL3eRh2V4ePbASgt/aCfqzJ479bdSY
	vdLnL31x4CApMifwfS98JMVHZudRxDKoqzxt2ApSC0CxLexBtwEhAbNVlTeNWgGP/GQI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4wT5-0003gm-TX;
	Fri, 11 Sep 2026 08:18:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4wT4-0003gY-Mc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kyn4Ga6G4RwVLpoA3c0HnUor1WgOw91vCzav2xn5ER4=; b=KAg5HfArcG7CWvHyi7d3F+DPYA
 fkMOgTekDnt8gm5DwbhnPWOGrbL+SlAwRkGIZsEG3AX0yBa4vPA2CQpV7XCg+QWyV7wlTNRTV6OLy
 fFIIJyZI3bZxwH2qv+bv/b7jK3pU+GQTZsX/Q5zwzYBBgMs8tMbhBd0NlozS+AMQKfHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kyn4Ga6G4RwVLpoA3c0HnUor1WgOw91vCzav2xn5ER4=; b=A
 xRd04PMMvlqa6t00nwoMc/u2hvg2Gyqq847ALEDbei8z1mJ4vSmgdl/t6oq32azzY5z8xF2gI0hKY
 89TuBmZo4XirNcMmFzuKFZJ9EoTPkN/LR7Jv18RGyrzeXUeD1t+Ay89eBskVWKb4y/DmJqCKTqnBz
 v8YOf7u1uu7bw7HE=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4wSu-000414-UK for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:43 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso4689785e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789114706; x=1789719506; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kyn4Ga6G4RwVLpoA3c0HnUor1WgOw91vCzav2xn5ER4=;
 b=BUmJx5sbvyzUzfQNPKEglMdLI/h9jtiRLxitdSHZ5zueZP7Igz18LTObeqH0crS9Pl
 1HGhak0sWU9gIlGwImreresunIqFNK0pzmkFk8/vRC2Vz7t2EQLsut8muwifnolNogPF
 if7LNwZXTCyd16RClys4hkoP8Nk2XfonYgs3KdtQkSFp6RP8uzbTJOsPokQW9gPQZ2bg
 6JngNOh+uP3CEsM0eY4uvZcf3IxFaLnqQLuB9MmV1BeRIQKICiQ6lk999ccu/b6Vn95p
 9VTjemcOlRdNIa80/78fR2VpKziCRPtcPQ9r54Xm+S9GPlbrNlF8EqbHqQpqQ73N0WN9
 R5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789114706; x=1789719506;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kyn4Ga6G4RwVLpoA3c0HnUor1WgOw91vCzav2xn5ER4=;
 b=eAlLxiQa7z/e038OYCHuauHB+MczASr/odLZJKzdFk2cNSvZbdsNzIJfDh4K2aizkw
 iIxud+5OotTM6y7dfcTfzHOVqNSwU2HmYcU/1O8XIqlUIZDFrwEm7pTq4VZSQzvokrj7
 d9KrHnSRLuF5fj8xf+trQX/CXRYJVcQYal+H4XBgAB4QH5bgguDZF2uxehtsbwC7I51Q
 wBT+l6HtlW4y+wihk1W3nw/onZ3GISJkzabhkehMaUd6VD0EAL0NvNCBChPoMA4sLNel
 TJIMY0CGJtq5mONj7esAeDo5ei2sGtUXUX99fIyapx77c1lOohTxnHijAh53criV7akM
 nNug==
X-Gm-Message-State: AFuF++lVfPhqsAJBVZDEXjFyQS9eb5RG+f7Fmx/Yz1t+EJ7dz/eSjUU4
 0gS1PZKBNbdRlfeBLZPgQtRHqRt6M8j5Aj0wHcAsW69MhcesulVNyqkfl9HbYFificE98rU+evE
 0QmNPeaCiKwKFLCRIisSRdTmp4JWe/CVRTNei5oVuV2Z8gSHFgcUfdPAxaDNbVVtXRQOUp/JdLN
 9TXQbdaw==
X-Gm-Gg: AYBFou0w433u/00QGbZtZZsWPJ7NJCkcHwqif7YmXVplh6lnMwv8fzaO6Pnk+RRT42T
 K2GnhL7Ka7ZsH7r3jcQFPTnLbjE94fYDVK073IL8IHgPzM0rd1ijxkvQqJHj1E7ClEbxRzcM3dD
 ItEIPmIeSTRLFx8hkJFjW3swahgvZuQp7aZEGT/FShERssg9rRZJdqZtI1SCUVPVGRUAABX+ZAt
 3zgks9y5MqEdFX+2lh2cyYB9G8VyA1ds9H+QSWO6UJw30oz4nVyoPeMy/a8cKvSvG3lX7LI2ZrH
 24jEpATVazfvKk1Ef2fcO6oKy3Pv+RZmNH3iDg8xQnxJSrJ/8T+6TLKorNT6wYe8FrvKv/2g6ll
 8xNHumFtDaw0aaIf+wVXymKXJQ8IU2WfHqtkL8il+TlBpCnmqNpN9kSNXtNloC75IIpSvzkCTjW
 S5thz6D9MILc+fseIa+bHgV+dIS9CDR4IxI+C+ToCq7BKE8Q0gZPP5ZbdVva9GOaQ2EdN6rZtbQ
 4mZ1TsrmxcjCzCzGnn66TWlOfcDeIKKDgwZDCLzZty7u4POjpVHLvA7EUS/QkRTUZETed2uBsaw
 4H4x5rutuWb6xDeqhhCE2qCvOTVWH5kFAp9YWq5KHQ3besw1irz+RG+Ou0qLcTq4mNfB8agi
X-Received: by 2002:a05:600c:4505:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49e61a03b32mr58443375e9.13.1789114706159; 
 Fri, 11 Sep 2026 01:18:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac42b9sm55544815e9.6.2026.09.11.01.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:18:25 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 08:18:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: 9603e06393f7ec72519197dfa7ea61a30a8b758b
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2bee49ead7c4aa8926592b3702758cc664ab31df-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4wSu-000414-UK
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
Content-Type: multipart/mixed; boundary="===============6052958449894533869=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6052958449894533869==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7qo+sHO6sxQ="; charset=UTF-8

--7qo+sHO6sxQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1750?usp=3Demail

to look at the new patch set (#18)=2E
=


Change subject: oob: Wrap the client SERVER_PROBE with tls-auth/tls-crypt=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Wrap =
the client SERVER_PROBE with tls-auth/tls-crypt

The client --server-probe =
previously sent a plaintext SERVER_PROBE and
parsed replies by hand, so it =
only worked against a server with no
control-channel wrapping=2E Build a st=
andalone wrapping context for the
probe (mirroring the server's tls_auth_st=
andalone) and route both the
outgoing probe and the incoming replies throug=
h the same control-channel
path the rest of the code uses:

  - tls_wrap_oo=
b_standalone() wraps the probe payload, applying the
    tls-auth HMAC or t=
ls-crypt encryption (or nothing, when neither is
    configured)=2E
  - rea=
d_control_auth() unwraps each reply, verifying the HMAC /
    decrypting an=
d stripping the opcode + session id, on a per-packet
    copy of the wrappi=
ng context (as tls_pre_decrypt_lite() does)=2E It
    decrypts in place, so=
 oob_probe_handle_reply() now takes a mutable
    buffer=2E

With neither t=
ls-auth nor tls-crypt configured the context stays in
TLS_WRAP_NONE and the=
 on-wire probe is byte-for-byte identical to before,
so the plaintext case =
is unchanged=2E

tls-crypt-v2 is not supported yet: the server only learns =
the client key
from the WKc carried in the TLS handshake, which an out-of-b=
and probe
cannot provide=2E Such configurations skip probing and keep the c=
onfigured
remote order=2E

Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c=
03ac
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections=
/client-options=2Erst
M src/openvpn/oob_client=2Ec
2 files changed, 118 ins=
ertions(+), 33 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/50/1750/18

diff --git a/doc/man-sections/client-opti=
ons=2Erst b/doc/man-sections/client-options=2Erst
index 76b9b9b=2E=2Ef582dc=
9 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections=
/client-options=2Erst
@@ -617,9 +617,10 @@
   compared on latency alone, so=
 only the fastest server of its priority
   group is treated as best=2E
 
-=
  The probe is currently sent without control-channel wrapping, so it only
=
-  works against a server configured without ``--tls-auth``,
-  ``--tls-cry=
pt`` or ``--tls-crypt-v2``=2E
+  The probe carries the same control-channel=
 wrapping as a normal
+  connection (``--tls-auth`` or ``--tls-crypt``, whe=
n configured)=2E With
+  ``--tls-crypt-v2`` the remotes are left in their c=
onfigured order,
+  because the server cannot unwrap an out-of-band probe y=
et=2E
 
   Only UDP remotes are probed=2E Remotes that answered are tried f=
irst, in
   the order described above; all other remotes, including TCP one=
s, follow
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=
=2Ec
index 9df8b95=2E=2E07e13a0 100644
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
@@ -74,21 +76,54 @@
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
+/* Build a standalo=
ne control-channel wrapping context for the probe, mirroring
+ * the tls_au=
th_standalone the server uses to answer it=2E With neither tls-auth
+ * nor=
 tls-crypt configured the context stays in TLS_WRAP_NONE and the probe is
+=
 * sent in plaintext, exactly as before; with either configured the probe i=
s
+ * authenticated/encrypted like any other control packet=2E Returns NULL=
 (and
+ * logs) for configurations the probe cannot wrap yet, in which case=
 the caller
+ * skips probing and keeps the configured remote order=2E */
+=
static struct tls_auth_standalone *
+oob_probe_init_tls_auth_standalone(str=
uct context *c, struct gc_arena *gc)
 {
-    const struct oob_probe_paramet=
er param =3D {
-        =2Etimestamp =3D (uint64_t)now,
-        =2Eflags =
=3D 0,
-    };
-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCO=
DE_SHIFT);
-    return buf_write_u8(buf, header) && session_id_write(client=
_sid, buf)
-           && oob_server_probe_write(buf, &param);
+    /* The =
probe runs before next_connection_entry() maps a connection entry
+     * i=
nto options=2Ece, so take the wrapping config from the first connection
+  =
   * entry directly=2E A global --tls-auth/--tls-crypt is copied into every=

+     * connection-list entry by options_postprocess_mutate_ce(), so the f=
irst
+     * entry carries it even though options=2Ece does not yet=2E (Pro=
bing wraps a
+     * single packet for all remotes, so per-connection-block=
 keys are not
+     * supported; the first entry's wrapping is used for all=
=2E) */
+    const struct connection_entry *ce =3D c->options=2Econnection_=
list->array[0];
+
+    /* tls-crypt-v2 wraps with a per-client key the serv=
er only learns from the
+     * wrapped client key (WKc) carried in the TLS=
 handshake=2E An out-of-band
+     * probe carries no WKc, so the server ca=
nnot unwrap it; skip probing rather
+     * than send something unverifiabl=
e=2E */
+    if (ce->tls_crypt_v2_file)
+    {
+        msg(D_LOW, "server-=
probe: not supported with tls-crypt-v2; using configured order");
+        =
return NULL;
+    }
+
+    /* Load the tls-auth/tls-crypt key material into=
 c->c1=2Eks (a no-op if neither
+     * is configured)=2E This is run again=
 per-connection later; calling it early
+     * here is harmless=2E */
+   =
 do_init_tls_wrap_key(c, ce);
+
+    struct tls_options to;
+    CLEAR(to);=

+    init_tls_wrap_ctx(&to=2Etls_wrap, ce, c->options=2Etls_client, &c->c1=
=2Eks, &c->c1=2Epid_persist);
+    to=2Ereplay_window =3D c->options=2Erepl=
ay_window;
+    to=2Ereplay_time =3D c->options=2Ereplay_time;
+
+    struc=
t tls_auth_standalone *tas =3D tls_auth_standalone_init(&to, gc);
+
+    /*=
 Control-channel frame and work buffers, mirroring do_init_frame_tls()=2E *=
/
+    tls_init_control_channel_frame_parameters(&tas->frame, ce->tls_mtu);=

+    tas->tls_wrap=2Ework =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+  =
  tas->workbuf =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+
+    return t=
as;
 }
 
 /* The local address and port ce's connection socket binds: its f=
irst --local,
@@ -228,9 +263,9 @@
 /* Parse one received datagram as a PROB=
E_REPLY and, if valid and matching one
  * of the probes we sent, record th=
e reply in results=2E */
 static void
-oob_probe_handle_reply(const uint8_t=
 *data, int len, const struct session_id *client_sid,
-                    =
   const struct openvpn_sockaddr *from, const struct oob_probe_target *targ=
ets,
-                       struct oob_probe_result *results, int n)
+oob_=
probe_handle_reply(uint8_t *data, int len, const struct session_id *client_=
sid,
+                       const struct tls_wrap_ctx *base_wrap, const st=
ruct openvpn_sockaddr *from,
+                       const struct oob_probe=
_target *targets, struct oob_probe_result *results, int n)
 {
     /* Need =
at least the opcode byte and the session id=2E */
     if (len < 1 + (int)S=
ID_SIZE || (data[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
@@ -240,7 +27=
5,20 @@
 
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)len=
);
-    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + server session id=
 */
+
+    /* Unwrap the reply with the same control-channel path the serve=
r used to
+     * wrap it: this verifies the tls-auth HMAC / decrypts tls-c=
rypt, and (in all
+     * modes) strips the opcode + server session id, lea=
ving buf at the TLV
+     * payload=2E With no tls-auth/tls-crypt it just s=
trips those header bytes, as
+     * before=2E read_control_auth() mutates =
the wrapping context, so we work on a
+     * per-packet copy (as tls_pre_d=
ecrypt_lite() does on the server)=2E The peer
+     * address is only used =
for log messages, and tls_options only for
+     * tls-crypt-v2 metadata ch=
ecks, so both are passed as NULL=2E */
+    struct tls_wrap_ctx wrap =3D *b=
ase_wrap;
+    if (!read_control_auth(&buf, &wrap, NULL, NULL))
+    {
+   =
     return; /* not for us, or failed authentication */
+    }
 
     struc=
t oob_probe_reply reply;
     if (!oob_client_reply_read(&buf, &reply))
@@ =
-290,8 +338,9 @@
  * matches a probe we sent=2E Returns true if every sent =
probe has been answered=2E */
 static bool
 oob_probe_receive_slice(const s=
truct probe_ctx *pc, const struct timeval *deadline,
-                     =
   const struct session_id *client_sid, const struct oob_probe_target *targ=
ets,
-                        struct oob_probe_result *results, int n, int =
outstanding)
+                        const struct session_id *client_sid, =
const struct tls_wrap_ctx *wrap,
+                        const struct oob_=
probe_target *targets, struct oob_probe_result *results, int n,
+          =
              int outstanding)
 {
     while (true)
     {
@@ -341,7 +390,7=
 @@
                                     (struct sockaddr *)&from, &fromlen=
);
             if (len > 0)
             {
-                oob_probe_hand=
le_reply(data, len, client_sid, &from, targets, results, n);
+             =
   oob_probe_handle_reply(data, len, client_sid, wrap, &from, targets, resu=
lts, n);
             }
         }
         if (oob_count_answered(targets,=
 results, n) >=3D outstanding)
@@ -383,8 +432,8 @@
  * once the window elap=
ses or every sent probe has been answered=2E */
 static void
 oob_probe_col=
lect(struct probe_ctx *pc, const struct buffer *probe,
-                  c=
onst struct session_id *client_sid, const struct oob_probe_target *targets,=

-                  struct oob_probe_result *results, int n)
+             =
     const struct session_id *client_sid, const struct tls_wrap_ctx *wrap,
=
+                  const struct oob_probe_target *targets, struct oob_probe=
_result *results, int n)
 {
     /* number of probes we actually sent: stop=
 early once they all answer */
     int want =3D 0;
@@ -408,7 +457,7 @@
   =
          deadline=2Etv_usec -=3D 1000000;
         }
 
-        if (oob_pr=
obe_receive_slice(pc, &deadline, client_sid, targets, results, n, want))
+ =
       if (oob_probe_receive_slice(pc, &deadline, client_sid, wrap, targets=
, results, n, want))
         {
             return; /* all answered */
   =
      }
@@ -450,6 +499,16 @@
 
     struct gc_arena gc =3D gc_new();
 
+   =
 /* Wrapping context for the probe (tls-auth/tls-crypt, or plaintext if
+  =
   * neither)=2E NULL means this configuration cannot be probed; keep the
+=
     * configured order=2E */
+    struct tls_auth_standalone *tas =3D oob_=
probe_init_tls_auth_standalone(c, &gc);
+    if (!tas)
+    {
+        gc_f=
ree(&gc);
+        return;
+    }
+
     /* A single random session id iden=
tifies all of our probes; servers echo it
      * back in the reply's peer_=
session_id, letting us reject spoofed replies=2E */
     struct session_id =
client_sid;
@@ -467,6 +526,7 @@
             msg(D_LOW, "server-probe: %s:%=
s binds differently from the first remote;"
                        " not p=
robing, using configured order",
                 ce->remote, ce->remote_po=
rt);
+            tls_auth_standalone_free(tas);
             gc_free(&gc);=

             return;
         }
@@ -476,17 +536,39 @@
     struct oob_prob=
e_target *targets =3D gc_malloc(sizeof(*targets) * l->len, true, &gc);
    =
 struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l->len, =
true, &gc);
 
-    struct buffer probe =3D alloc_buf_gc(256, &gc);
-    if =
(!oob_probe_build_packet(&probe, &client_sid))
+    /* Build the probe once=
 and reuse the same bytes for every remote and for
+     * resends: the SER=
VER_PROBE payload is a single probe_parameter TLV, wrapped
+     * (or sent=
 in plaintext) like any other control packet=2E The client session
+     * =
id is prepended as the sender session id=2E */
+    struct buffer payload =
=3D alloc_buf_gc(64, &gc);
+    const struct oob_probe_parameter param =3D =
{
+        =2Etimestamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+    };=

+    if (!oob_server_probe_write(&payload, &param))
     {
-        msg(D_=
LOW, "server-probe: could not build probe packet; using configured order");=

+        msg(D_LOW, "server-probe: could not build probe payload; using co=
nfigured order");
         oob_probe_sockets_close(&pc);
+        tls_auth_=
standalone_free(tas);
         gc_free(&gc);
         return;
     }
 
-   =
 msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window", l->le=
n,
-        OOB_PROBE_WINDOW_MS);
+    struct buffer probe =3D tls_wrap_oob=
_standalone(&tas->tls_wrap, tas, &client_sid, &payload);
+    if (!BLEN(&pr=
obe))
+    {
+        msg(D_LOW, "server-probe: could not wrap probe packet=
; using configured order");
+        oob_probe_sockets_close(&pc);
+       =
 tls_auth_standalone_free(tas);
+        gc_free(&gc);
+        return;
+  =
  }
+
+    const char *wrap_name =3D (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_=
CRYPT)  ? "tls-crypt"
+                            : (tas->tls_wrap=2Emode =
=3D=3D TLS_WRAP_AUTH) ? "tls-auth"
+                                       =
                             : "none (plaintext)";
+    msg(D_LOW, "server-=
probe: probing %d remote(s) with a %d ms window, control-channel wrapping: =
%s",
+        l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 
     /* Resolve ev=
ery remote first, so only the address families actually in use
      * get =
a probe socket=2E */
@@ -541,6 +623,7 @@
         {
             freeaddrin=
fo(bind_local);
         }
+        tls_auth_standalone_free(tas);
        =
 gc_free(&gc);
         return;
     }
@@ -582,7 +665,7 @@
 
     if (sent_=
count > 0)
     {
-        oob_probe_collect(&pc, &probe, &client_sid, targ=
ets, results, l->len);
+        oob_probe_collect(&pc, &probe, &client_sid,=
 &tas->tls_wrap, targets, results, l->len);
     }
     oob_probe_sockets_c=
lose(&pc);
     if (bind_local)
@@ -629,5 +712,6 @@
     msg(M_INFO, "serve=
r-probe: %d of %d remote(s) answered; connecting best-first", responded,
  =
       l->len);
 
+    tls_auth_standalone_free(tas);
     gc_free(&gc);
 }=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1f9d7b5a5ec19b=
f77c0c212795f583c5ba4c03ac
Gerrit-Change-Number: 1750
Gerrit-PatchSet: 18
G=
errit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--7qo+sHO6sxQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #18</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1750?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Wra=
p the client SERVER_PROBE with tls-auth/tls-crypt<br><br>The client --serve=
r-probe previously sent a plaintext SERVER_PROBE and<br>parsed replies by h=
and, so it only worked against a server with no<br>control-channel wrapping=
=2E Build a standalone wrapping context for the<br>probe (mirroring the ser=
ver&#39;s tls_auth_standalone) and route both the<br>outgoing probe and the=
 incoming replies through the same control-channel<br>path the rest of the =
code uses:<br><br>  - tls_wrap_oob_standalone() wraps the probe payload, ap=
plying the<br>    tls-auth HMAC or tls-crypt encryption (or nothing, when n=
either is<br>    configured)=2E<br>  - read_control_auth() unwraps each rep=
ly, verifying the HMAC /<br>    decrypting and stripping the opcode + sessi=
on id, on a per-packet<br>    copy of the wrapping context (as tls_pre_decr=
ypt_lite() does)=2E It<br>    decrypts in place, so oob_probe_handle_reply(=
) now takes a mutable<br>    buffer=2E<br><br>With neither tls-auth nor tls=
-crypt configured the context stays in<br>TLS_WRAP_NONE and the on-wire pro=
be is byte-for-byte identical to before,<br>so the plaintext case is unchan=
ged=2E<br><br>tls-crypt-v2 is not supported yet: the server only learns the=
 client key<br>from the WKc carried in the TLS handshake, which an out-of-b=
and probe<br>cannot provide=2E Such configurations skip probing and keep th=
e configured<br>remote order=2E<br><br>Change-Id: I1f9d7b5a5ec19bf77c0c2127=
95f583c5ba4c03ac<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<b=
r>---<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob_clien=
t=2Ec<br>2 files changed, 118 insertions(+), 33 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/50/1750/18</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/doc/man-sections/client-options=2Erst b/=
doc/man-sections/client-options=2Erst</span><br><span>index 76b9b9b=2E=2Ef5=
82dc9 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst</s=
pan><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@=
@ -617,9 +617,10 @@</span><br><span>   compared on latency alone, so only t=
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
emotes are probed=2E Remotes that answered are tried first, in</span><br><s=
pan>   the order described above; all other remotes, including TCP ones, fo=
llow</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/=
oob_client=2Ec</span><br><span>index 9df8b95=2E=2E07e13a0 100644</span><br>=
<span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oo=
b_client=2Ec</span><br><span>@@ -29,6 +29,8 @@</span><br><span> #include &q=
uot;oob_client=2Eh&quot;</span><br><span> #include &quot;openvpn=2Eh&quot;<=
/span><br><span> #include &quot;oob=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;init=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl=2Eh&quot;</span><br>=
<span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span> #include &quot;ses=
sion_id=2Eh&quot;</span><br><span> #include &quot;socket=2Eh&quot;</span><b=
r><span>@@ -74,21 +76,54 @@</span><br><span>     return (af =3D=3D AF_INET6=
) ? PROBE_AF_V6 : PROBE_AF_V4;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/* Build a plaintext SERVER_P=
ROBE packet:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   [opc=
ode | key_id=3D0] [client session id] [SERVER_PROBE message]</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * This is the unauthenticated OOB w=
ire format; adding tls-auth/tls-crypt</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * wrapping for the probe is a follow-up (it only works aga=
inst a server with</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
no control-channel wrapping for now)=2E */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-oob_probe_build_packet(struct buffer *buf, const struct session_=
id *client_sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* B=
uild a standalone control-channel wrapping context for the probe, mirroring=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the tls_auth_sta=
ndalone the server uses to answer it=2E With neither tls-auth</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * nor tls-crypt configured the c=
ontext stays in TLS_WRAP_NONE and the probe is</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * sent in plaintext, exactly as before; with ei=
ther configured the probe is</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * authenticated/encrypted like any other control packet=2E Return=
s NULL (and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * logs)=
 for configurations the probe cannot wrap yet, in which case the caller</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * skips probing and ke=
eps the configured remote order=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static struct tls_auth_standalone *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_probe_init_tls_auth_standalone(struct=
 context *c, struct gc_arena *gc)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const struct oob_probe_parameter param =
=3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =2Etimes=
tamp =3D (uint64_t)now,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t=
 header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return buf_write_u8(buf, hea=
der) &amp;&amp; session_id_write(client_sid, buf)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-           &amp;&amp; oob_server_probe_write(bu=
f, &amp;param);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* The probe runs before next_connection_entry() maps a connection entry</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * into options=2E=
ce, so take the wrapping config from the first connection</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * entry directly=2E A global --t=
ls-auth/--tls-crypt is copied into every</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * connection-list entry by options_postprocess_mu=
tate_ce(), so the first</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * entry carries it even though options=2Ece does not yet=2E (Probi=
ng wraps a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * si=
ngle packet for all remotes, so per-connection-block keys are not</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * supported; the first e=
ntry&#39;s wrapping is used for all=2E) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const struct connection_entry *ce =3D c-&gt;opti=
ons=2Econnection_list-&gt;array[0];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* tls-crypt-v2 wraps with a per-client key the server only learns from th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * wrapped cli=
ent key (WKc) carried in the TLS handshake=2E An out-of-band</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * probe carries no WKc, so th=
e server cannot unwrap it; skip probing rather</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * than send something unverifiable=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_cry=
pt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &qu=
ot;server-probe: not supported with tls-crypt-v2; using configured order&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Load the tls-auth/tls-crypt key materia=
l into c-&gt;c1=2Eks (a no-op if neither</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * is configured)=2E This is run again per-connect=
ion later; calling it early</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * here is harmless=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    do_init_tls_wrap_key(c, ce);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct tls_options to;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    CLEAR(to);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, ce, c-&gt;options=
=2Etls_client, &amp;c-&gt;c1=2Eks, &amp;c-&gt;c1=2Epid_persist);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_window =3D c-&=
gt;options=2Ereplay_window;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct tls_auth_standalone *tas =3D tls_auth_sta=
ndalone_init(&amp;to, gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Contr=
ol-channel frame and work buffers, mirroring do_init_frame_tls()=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_init_control_cha=
nnel_frame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;tls_wrap=2Ework =3D allo=
c_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    tas-&gt;workbuf =3D alloc_buf_gc(BUF_SIZE(&amp;=
tas-&gt;frame), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tas;</s=
pan><br><span> }</span><br><span> </span><br><span> /* The local address an=
d port ce&#39;s connection socket binds: its first --local,</span><br><span=
>@@ -228,9 +263,9 @@</span><br><span> /* Parse one received datagram as a P=
ROBE_REPLY and, if valid and matching one</span><br><span>  * of the probes=
 we sent, record the reply in results=2E */</span><br><span> static void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-oob_probe_handle_reply(c=
onst uint8_t *data, int len, const struct session_id *client_sid,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                       const st=
ruct openvpn_sockaddr *from, const struct oob_probe_target *targets,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                       struc=
t oob_probe_result *results, int n)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+oob_probe_handle_reply(uint8_t *data, int len, const struct=
 session_id *client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                       const struct tls_wrap_ctx *base_wrap, const str=
uct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                       const struct oob_probe_target *targets, stru=
ct oob_probe_result *results, int n)</span><br><span> {</span><br><span>   =
  /* Need at least the opcode byte and the session id=2E */</span><br><span=
>     if (len &lt; 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_SHIFT) !=
=3D P_CONTROL_OOB_V1)</span><br><span>@@ -240,7 +275,20 @@</span><br><span>=
 </span><br><span>     struct buffer buf;</span><br><span>     buf_set_read=
(&amp;buf, data, (size_t)len);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    buf_advance(&amp;buf, 1 + SID_SIZE); /* skip opcode + server s=
ession id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Unwrap the reply wi=
th the same control-channel path the server used to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * wrap it: this verifies the tls-aut=
h HMAC / decrypts tls-crypt, and (in all</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * modes) strips the opcode + server session id, l=
eaving buf at the TLV</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * payload=2E With no tls-auth/tls-crypt it just strips those header =
bytes, as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * bef=
ore=2E read_control_auth() mutates the wrapping context, so we work on a</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * per-packet copy=
 (as tls_pre_decrypt_lite() does on the server)=2E The peer</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * address is only used for log=
 messages, and tls_options only for</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * tls-crypt-v2 metadata checks, so both are passed as =
NULL=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tls_wrap_ctx wrap =3D *base_wrap;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!read_control_auth(&amp;buf, &amp;wrap, NULL, NULL)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return; /* not for us, o=
r failed authentication */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span> </span><br><span>     struct oob_probe_reply =
reply;</span><br><span>     if (!oob_client_reply_read(&amp;buf, &amp;reply=
))</span><br><span>@@ -290,8 +338,9 @@</span><br><span>  * matches a probe =
we sent=2E Returns true if every sent probe has been answered=2E */</span><=
br><span> static bool</span><br><span> oob_probe_receive_slice(const struct=
 probe_ctx *pc, const struct timeval *deadline,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        const struct session_id *=
client_sid, const struct oob_probe_target *targets,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        struct oob_probe_re=
sult *results, int n, int outstanding)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        const struct session_id *client_=
sid, const struct tls_wrap_ctx *wrap,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        const struct oob_probe_target *ta=
rgets, struct oob_probe_result *results, int n,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        int outstanding)</span>=
<br><span> {</span><br><span>     while (true)</span><br><span>     {</span=
><br><span>@@ -341,7 +390,7 @@</span><br><span>                            =
         (struct sockaddr *)&amp;from, &amp;fromlen);</span><br><span>     =
        if (len &gt; 0)</span><br><span>             {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                oob_probe_handle_reply(dat=
a, len, client_sid, &amp;from, targets, results, n);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                oob_probe_handle_reply(da=
ta, len, client_sid, wrap, &amp;from, targets, results, n);</span><br><span=
>             }</span><br><span>         }</span><br><span>         if (oob=
_count_answered(targets, results, n) &gt;=3D outstanding)</span><br><span>@=
@ -383,8 +432,8 @@</span><br><span>  * once the window elapses or every sen=
t probe has been answered=2E */</span><br><span> static void</span><br><spa=
n> oob_probe_collect(struct probe_ctx *pc, const struct buffer *probe,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                  const st=
ruct session_id *client_sid, const struct oob_probe_target *targets,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                  struct oob=
_probe_result *results, int n)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                  const struct session_id *client_sid, const str=
uct tls_wrap_ctx *wrap,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                  const struct oob_probe_target *targets, struct oob_pr=
obe_result *results, int n)</span><br><span> {</span><br><span>     /* numb=
er of probes we actually sent: stop early once they all answer */</span><br=
><span>     int want =3D 0;</span><br><span>@@ -408,7 +457,7 @@</span><br><=
span>             deadline=2Etv_usec -=3D 1000000;</span><br><span>        =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, targets, =
results, n, want))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, wrap, tar=
gets, results, n, want))</span><br><span>         {</span><br><span>       =
      return; /* all answered */</span><br><span>         }</span><br><span=
>@@ -450,6 +499,16 @@</span><br><span> </span><br><span>     struct gc_aren=
a gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Wrapping context for the probe (tls-auth/tls-crypt,=
 or plaintext if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * neither)=2E NULL means this configuration cannot be probed; keep the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * configured orde=
r=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct t=
ls_auth_standalone *tas =3D oob_probe_init_tls_auth_standalone(c, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tas)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     /* A single random session id=
 identifies all of our probes; servers echo it</span><br><span>      * back=
 in the reply&#39;s peer_session_id, letting us reject spoofed replies=2E *=
/</span><br><span>     struct session_id client_sid;</span><br><span>@@ -46=
7,6 +526,7 @@</span><br><span>             msg(D_LOW, &quot;server-probe: %=
s:%s binds differently from the first remote;&quot;</span><br><span>       =
                 &quot; not probing, using configured order&quot;,</span><b=
r><span>                 ce-&gt;remote, ce-&gt;remote_port);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            tls_auth_standalone_fr=
ee(tas);</span><br><span>             gc_free(&amp;gc);</span><br><span>   =
          return;</span><br><span>         }</span><br><span>@@ -476,17 +53=
6,39 @@</span><br><span>     struct oob_probe_target *targets =3D gc_malloc=
(sizeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span>     struct =
oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&gt;len, true,=
 &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct buffer probe =3D alloc_buf_gc(256, &amp;gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (!oob_probe_build_packet(&a=
mp;probe, &amp;client_sid))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Build the probe once and reuse the same bytes for every remo=
te and for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * re=
sends: the SERVER_PROBE payload is a single probe_parameter TLV, wrapped</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (or sent in pla=
intext) like any other control packet=2E The client session</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * id is prepended as the sende=
r session id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer payload =3D alloc_buf_gc(64, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter pa=
ram =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
=2Etimestamp =3D (uint64_t)now,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!oob_server_probe_write(&amp;payload, &amp;param))</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
D_LOW, &quot;server-probe: could not build probe packet; using configured o=
rder&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(D_LOW, &quot;server-probe: could not build probe payload; using config=
ured order&quot;);</span><br><span>         oob_probe_sockets_close(&amp;pc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_auth_=
standalone_free(tas);</span><br><span>         gc_free(&amp;gc);</span><br>=
<span>         return;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;server-probe=
: probing %d remote(s) with a %d ms window&quot;, l-&gt;len,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        OOB_PROBE_WINDOW_MS);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =
=3D tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &a=
mp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!BLEN(&amp;probe))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_=
LOW, &quot;server-probe: could not wrap probe packet; using configured orde=
r&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        oo=
b_probe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tls_auth_standalone_free(tas);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRY=
PT)  ? &quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                            : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_=
WRAP_AUTH) ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                             =
       : &quot;none (plaintext)&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remote(s) =
with a %d ms window, control-channel wrapping: %s&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDOW_MS=
, wrap_name);</span><br><span> </span><br><span>     /* Resolve every remot=
e first, so only the address families actually in use</span><br><span>     =
 * get a probe socket=2E */</span><br><span>@@ -541,6 +623,7 @@</span><br><=
span>         {</span><br><span>             freeaddrinfo(bind_local);</spa=
n><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        tls_auth_standalone_free(tas);</span><br><span>         gc_free(=
&amp;gc);</span><br><span>         return;</span><br><span>     }</span><br=
><span>@@ -582,7 +665,7 @@</span><br><span> </span><br><span>     if (sent_=
count &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        oob_probe_collect(&amp;pc, &amp;probe, &amp;client_s=
id, targets, results, l-&gt;len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        oob_probe_collect(&amp;pc, &amp;probe, &amp;client_si=
d, &amp;tas-&gt;tls_wrap, targets, results, l-&gt;len);</span><br><span>   =
  }</span><br><span>     oob_probe_sockets_close(&amp;pc);</span><br><span>=
     if (bind_local)</span><br><span>@@ -629,5 +712,6 @@</span><br><span>  =
   msg(M_INFO, &quot;server-probe: %d of %d remote(s) answered; connecting =
best-first&quot;, responded,</span><br><span>         l-&gt;len);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_aut=
h_standalone_free(tas);</span><br><span>     gc_free(&amp;gc);</span><br><s=
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
<div style=3D"display:none"> Gerrit-PatchSet: 18 =
</div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--7qo+sHO6sxQ=--


--===============6052958449894533869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6052958449894533869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6052958449894533869==--

