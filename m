Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12B5C88E45
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OQdYJFy15exNr4ZYAn4RDq3zF+LHsn9sqJ5f4ljOMro=; b=iomF5+nwbjNU92kxRQ78ZsZIzK
	ktg0lmifMh+o+WY/7CRZXu83fK7JA9R7xKbA+zSGtJ3aEiAmOR87iWlp+sjFRz45+VOvyWZDknIGl
	JvlhY94qjh3XcjcCmYZk/buc5QmgJ8zFExojk5AsXHsXJPQnxJUQeZFlE5KdEC4vSAt8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5Hrq-0007mk-R3;
	Sat, 12 Sep 2026 07:09:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5Hrk-0007kk-QY
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 07:09:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bEmPgQ8PEv0OhJMg4vnUtRhhdhkr1wVUsOWV/c7+zc0=; b=HA3wLQRWHBwZpKHUwWF3hfeqx9
 wKqi0rvr4w0XbidAJGjfvIi+8OJD7exBu1V+wWcOaVDBXhWVIQgJAIYoCc0/pVobx/5ICua4PFnQt
 NCFN9obDkcxwxeGn82gw0Xa+t9Y+oQZWQOjKc7vAz+ROWot1l8snLtz+lCAhNQ88mVgo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bEmPgQ8PEv0OhJMg4vnUtRhhdhkr1wVUsOWV/c7+zc0=; b=b
 Rh6w5t/6q839cpsgImYsT2Q5at2rrDK4iHKy08odkXK9PDZYstfNpktQLeK5+ziwT+ghGfKwDppM6
 lETtuROrb6TUeyZX1KnPFaxILCq+t5Gvfs7ItrV0vtC54C93PN14p2/PdKiGV9oSXOWT7bDNda+hh
 tQpFqNFt3HZdK6gA=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5HrG-0007pD-Pv for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 07:09:11 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso2199475e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789196940; x=1789801740; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bEmPgQ8PEv0OhJMg4vnUtRhhdhkr1wVUsOWV/c7+zc0=;
 b=CE3SZumDidudXUaH7W410sky6ZtAm6Zf8S8CBnatHz+coLqbCL2MZcbXQZ8+QJXn4D
 EKLnUgPJy6Kt9ye31LyX4BQWe1EMoK+dSQMUDXYh47+IAMMddamLNQjuQfDH9HMR+ySD
 Ipzg7iyu7waYuwRGUNOXgm0TUysnfPVomgSGn+mo7gcQt3UGNAxDFVUs6JiEKM3p55Qd
 G7ITMyeYu5AZ+HUtQLW0dSDeNHOOqd57LmPwY5T5ow2M2XG+CHJpyzfgR+DXRgHsaI5R
 nAUkotqMll0nRdvbe8DBtDIGqBz4VwaFfO+iyb6TEl7FB7DFk7G+7N+QX9cLZOSESWPW
 SSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789196940; x=1789801740;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bEmPgQ8PEv0OhJMg4vnUtRhhdhkr1wVUsOWV/c7+zc0=;
 b=oM5tD9f9trWOCWXbk+zTZBzKdZiLXLXd8/Vu3HvC4M5/0wZhARSCXb3CboLqtDbJNL
 QvpZ7W+XNQoLA/pn6XeWQ4nn8K04MQaPtZmt11uzSIGDqtaBvN05Aj5aFxEW9kz8JY8e
 SQLO3DKs3+x+rJICBMOkY1ls9ch7GwdijPl4f8iRp3rxC8x9y4c6OFgp974wgb3cEaAu
 GOT2HptmMQ1STwW41mnXgOSisGe/54hJ+ZNWpvbch04pbDMij7YeQpRd9oMQZm1wvHM7
 XDDsEoj7y0BNOI+IQEgr+EISHsz1Gg3BAzHX2fpAFkdI/l4cu7BKlU3Cc+4AIl/Q42bx
 6y1g==
X-Gm-Message-State: AFuF++kb87VA1djO1JJ5R2LQp/fXojUsK/ZtBXO49GfzzmGqqxT9QDVZ
 zLlE2kZZFJi+WwzUEhY+gtqqZzznh48FUGfR3aFw0ahrLcShjg6RvUnaxSikpHl5TM3B3j4Lvoa
 IuwoltdSe6GhJofXYwJ/1nmkNdjahahzRJ10PvzgYJHlWBW+54sDbchrM74g5okPKACCj
X-Gm-Gg: AYBFou34tSlTxzYqE+JNKBVO2jE2WGnrM039XQXj1rYbjpu1cAETHHKqXeYLgBDvi4X
 4W90GiGJfS9AHsYl0MFcvNKZQiS1O5nJgZuA7pIEdEi2iZPxOi+KaP4ruRiJQNqjo3tairhhMB3
 3EYX/ZNoUbmbZtgDUVYvZ0m6ycgsZZ31uWN9aAf6qdER/M6i3gTx5C++9t+iFXyrR0+JPF8gZdn
 RwrUfGaS5SKnMz/KFhP1w1/xIbjwPGGdCNM0NKIk71xPi7dTw9BWa5lLyA80FtKmYRb5Whj06rF
 or/duabxpHyQyrFDvM/u5IiQO+1BahRQbkvh5jfX0oM9KhHP1CJ7a5ImNl8kFrlWOd5sZfptDg4
 pn6y15d7fg0FRXGwDhyywfDUUDSl5YZq9j78CMT0vfmFGO9YtA5ccgfKqvsZ5yuWBlPOQqvJJyW
 jyKlllpbbo8wt8CYGCYAHke6XhvnYJgT0RfDB8qRInkhQUYZJSRMGsjT2gGulfR0q4Wci/lLb/k
 6JxXOawhUtTJqCzjYpVI/xQlMwvFZMEh2SJ9Yc4DrNDrLEtjxfaETcPSLp9C1B98bgX54mkPSwc
 teNZPme98QLDdJHcvAPOgM3/7+kbG7RQD5iyLzm5fsyyDKQXMF/U8CpvTzvksQ==
X-Received: by 2002:a05:600c:548f:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49e6caa69e8mr13730035e9.7.1789196940045; 
 Sat, 12 Sep 2026 00:09:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62232cb7sm99366395e9.4.2026.09.12.00.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:08:59 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 07:08:46 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c
X-Gerrit-Change-Number: 1913
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1913?usp=email>
X-Gerrit-Commit: dbc36f56a69d0ca4c77a76b126678ada4d74f259
In-Reply-To: <gerrit.1789140193000.I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c@gerrit.openvpn.net>
References: <gerrit.1789140193000.I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTQwMTkzMDAwLkk3ZDhkYjE1YzIyMjYxMjc3YzQ0YTJlZmQzZDJlN2NmNzFmMjNlYTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <70ec97ebdc883f656c4bb591ab1ad4f4c4c4947b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5HrG-0007pD-Pv
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
Content-Type: multipart/mixed; boundary="===============4302236586353142446=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4302236586353142446==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0yibj6UAvfM="; charset=UTF-8

--0yibj6UAvfM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1913?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: oob: Wrap the client SERVER_PROBE with tls-auth/tls-crypt
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Wrap the=
 client SERVER_PROBE with tls-auth/tls-crypt

The client --server-probe pre=
viously sent a plaintext SERVER_PROBE and
parsed replies by hand, so it onl=
y worked against a server with no
control-channel wrapping=2E Build a stand=
alone wrapping context for the
probe (mirroring the server's tls_auth_stand=
alone) and route both the
outgoing probe and the incoming replies through t=
he same control-channel
path the rest of the code uses:

  - tls_wrap_oob_s=
tandalone() wraps the probe payload, applying the
    tls-auth HMAC or tls-=
crypt encryption (or nothing, when neither is
    configured)=2E
  - read_c=
ontrol_auth() unwraps each reply, verifying the HMAC /
    decrypting and s=
tripping the opcode + session id, on a per-packet
    copy of the wrapping =
context (as tls_pre_decrypt_lite() does)=2E It
    decrypts in place, so oo=
b_probe_handle_reply() now takes a mutable
    buffer=2E

With neither tls-=
auth nor tls-crypt configured the context stays in
TLS_WRAP_NONE and the on=
-wire probe is byte-for-byte identical to
before, so the plaintext case is =
unchanged=2E

tls-crypt-v2 is not supported yet: the server only learns the=
 client key
from the WKc carried in the TLS handshake, which an out-of-band=
 probe
cannot provide=2E Such configurations skip probing and keep the conf=
igured
remote order=2E

The probe is wrapped with the first remote's key, s=
o probing is declined
when another remote is keyed differently=2E The key m=
aterial loaded for
the probe is released afterwards; init loads it again fo=
r the
connection=2E Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Si=
gned-off-by: Lev Stipakov <lev@openvpn=2Enet>

Change-Id: I7d8db15c22261277=
c44a2efd3d2e7cf71f23ea0c
---
M doc/man-sections/client-options=2Erst
M src/=
openvpn/oob_client=2Ec
2 files changed, 166 insertions(+), 42 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/13/191=
3/2

diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/=
client-options=2Erst
index 76ec107=2E=2Efbc5d4b 100644
--- a/doc/man-sectio=
ns/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -617=
,20 +617,22 @@
   compared on latency alone, so only the fastest server of =
its priority
   group is treated as best=2E
 
-  The probe is currently sen=
t without control-channel wrapping, so it only
-  works against a server co=
nfigured without ``--tls-auth``,
-  ``--tls-crypt`` or ``--tls-crypt-v2``=
=2E
+  The probe carries the same control-channel wrapping as a normal
+  c=
onnection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With
+  `=
`--tls-crypt-v2`` the remotes are left in their configured order,
+  becaus=
e the server cannot unwrap an out-of-band probe yet=2E
 
   Only UDP remote=
s are probed, and only when there are at least two
   remotes; remotes reac=
hed through a SOCKS proxy are not probed=2E All
   probed remotes must shar=
e the local bind settings (``--local``,
-  ``--lport``, ``--bind``) of the =
first one among them, since a single
-  socket per address family carries t=
he probes; otherwise probing is
-  skipped and the configured order is used=
=2E Remotes that answered are tried first, in the
-  order described above;=
 all other remotes, including TCP ones, follow in
-  their configured order=
=2E Probing runs once, before the first connection
-  attempt; a restart do=
es not probe again=2E See ``--server-probe-reply``
-  for the server side=
=2E
+  ``--lport``, ``--bind``) and the control-channel key of the first on=
e
+  among them, since a single socket per address family carries the
+  pr=
obes; otherwise probing is skipped and the configured order is used=2E
+  R=
emotes that answered are tried first, in the order described above;
+  all =
other remotes, including TCP ones, follow in their configured
+  order=2E P=
robing runs once, before the first connection attempt; a
+  restart does no=
t probe again=2E See ``--server-probe-reply`` for the
+  server side=2E
 
 =
--static-challenge args
   Enable static challenge/response protocol
diff -=
-git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 264ab6=
b=2E=2E1d936a6 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oo=
b_client=2Ec
@@ -29,6 +29,8 @@
 #include "oob_client=2Eh"
 #include "openvp=
n=2Eh"
 #include "oob=2Eh"
+#include "init=2Eh"
+#include "ssl=2Eh"
 #inclu=
de "ssl_pkt=2Eh"
 #include "session_id=2Eh"
 #include "socket=2Eh"
@@ -74,2=
1 +76,67 @@
     return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
 =
}
 
-/* Build a plaintext SERVER_PROBE packet:
- *   [opcode | key_id=3D0] =
[client session id] [SERVER_PROBE message]
- * This is the unauthenticated =
OOB wire format; adding tls-auth/tls-crypt
- * wrapping for the probe is a =
follow-up (it only works against a server with
- * no control-channel wrapp=
ing for now)=2E */
-static bool
-oob_probe_build_packet(struct buffer *buf,=
 const struct session_id *client_sid)
+/* Build a standalone control-channe=
l wrapping context for the probe, mirroring
+ * the tls_auth_standalone the=
 server uses to answer it=2E With neither tls-auth
+ * nor tls-crypt config=
ured the context stays in TLS_WRAP_NONE and the probe is
+ * sent in plaint=
ext, exactly as before; with either configured the probe is
+ * authenticat=
ed/encrypted like any other control packet=2E Returns NULL (and
+ * logs) f=
or configurations the probe cannot wrap yet, in which case the caller
+ * s=
kips probing and keeps the configured remote order=2E */
+static struct tls=
_auth_standalone *
+oob_probe_init_tls_auth_standalone(struct context *c, s=
truct gc_arena *gc)
 {
-    const struct oob_probe_parameter param =3D {
- =
       =2Etimestamp =3D (uint64_t)now,
-        =2Eflags =3D 0,
-    };
-  =
  uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
-    re=
turn buf_write_u8(buf, header) && session_id_write(client_sid, buf)
-      =
     && oob_server_probe_write(buf, &param);
+    /* The probe runs before =
next_connection_entry() maps a connection entry
+     * into options=2Ece, =
so take the wrapping config from the first connection
+     * entry directl=
y=2E A global --tls-auth/--tls-crypt is copied into every
+     * connectio=
n-list entry by options_postprocess_mutate_ce(), so the first
+     * entry=
 carries it even though options=2Ece does not yet=2E (Probing wraps a
+    =
 * single packet for all remotes, so per-connection-block keys are not
+   =
  * supported; the first entry's wrapping is used for all=2E) */
+    const=
 struct connection_entry *ce =3D c->options=2Econnection_list->array[0];
+
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
+    /* Load the tls-auth/tls-crypt key material into c->c1=2Eks (a no-=
op if neither
+     * is configured)=2E This is run again per-connection la=
ter; calling it early
+     * here is harmless=2E */
+    do_init_tls_wrap_=
key(c, ce);
+
+    struct tls_options to;
+    CLEAR(to);
+    init_tls_wra=
p_ctx(&to=2Etls_wrap, ce, c->options=2Etls_client, &c->c1=2Eks, &c->c1=2Epi=
d_persist);
+    to=2Ereplay_window =3D c->options=2Ereplay_window;
+    to=
=2Ereplay_time =3D c->options=2Ereplay_time;
+
+    struct tls_auth_standal=
one *tas =3D tls_auth_standalone_init(&to, gc);
+
+    /* Control-channel f=
rame and work buffers, mirroring do_init_frame_tls()=2E */
+    tls_init_co=
ntrol_channel_frame_parameters(&tas->frame, ce->tls_mtu);
+    tas->tls_wra=
p=2Ework =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+    tas->workbuf =3D=
 alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+
+    return tas;
+}
+
+/* Relea=
se the probe's wrapping context and the key material
+ * do_init_tls_wrap_k=
ey() loaded for it: do_init_crypto_tls_c1() loads the same
+ * fields again=
 later without freeing them first=2E */
+static void
+oob_probe_free_wrap(s=
truct context *c, struct tls_auth_standalone *tas)
+{
+    tls_auth_standal=
one_free(tas);
+    free_key_ctx_bi(&c->c1=2Eks=2Etls_wrap_key);
+    CLEAR=
(c->c1=2Eks=2Etls_wrap_key);
+    buf_clear(&c->c1=2Eks=2Etls_crypt_v2_wkc)=
;
+    free_buf(&c->c1=2Eks=2Etls_crypt_v2_wkc);
 }
 
 /* The local address=
 and port ce's connection socket binds: its first --local,
@@ -148,6 +196,2=
1 @@
            && str_equal_or_both_null(port_a, port_b);
 }
 
+/* Do a a=
nd b wrap the control channel with the same key (--tls-auth,
+ * --tls-cryp=
t, --tls-crypt-v2 and key direction)? The one probe is wrapped
+ * with ent=
ry 0's key, so a server keyed differently could never answer it=2E */
+stat=
ic bool
+oob_probe_same_wrap(const struct connection_entry *a, const struct=
 connection_entry *b)
+{
+    return str_equal_or_both_null(a->tls_auth_fil=
e, b->tls_auth_file)
+           && a->tls_auth_file_inline =3D=3D b->tls_a=
uth_file_inline
+           && a->key_direction =3D=3D b->key_direction
+  =
         && str_equal_or_both_null(a->tls_crypt_file, b->tls_crypt_file)
+ =
          && a->tls_crypt_file_inline =3D=3D b->tls_crypt_file_inline
+    =
       && str_equal_or_both_null(a->tls_crypt_v2_file, b->tls_crypt_v2_file=
)
+           && a->tls_crypt_v2_file_inline =3D=3D b->tls_crypt_v2_file_in=
line;
+}
+
 /* Resolve the local bind address of ce's connection socket; NU=
LL with --nobind=2E
  * Fatal on failure, like the link socket=2E */
 stati=
c struct addrinfo *
@@ -242,9 +305,9 @@
 /* Parse one received datagram as =
a PROBE_REPLY and, if valid and matching one
  * of the probes we sent, rec=
ord the reply in results=2E */
 static void
-oob_probe_handle_reply(const u=
int8_t *data, int len, const struct session_id *client_sid,
-              =
         const struct openvpn_sockaddr *from, const struct oob_probe_target=
 *targets,
-                       struct oob_probe_result *results, int n)=

+oob_probe_handle_reply(uint8_t *data, int len, const struct session_id *c=
lient_sid,
+                       const struct tls_wrap_ctx *base_wrap, co=
nst struct openvpn_sockaddr *from,
+                       const struct oob=
_probe_target *targets, struct oob_probe_result *results, int n)
 {
     /*=
 Need at least the opcode byte and the session id=2E */
     if (len < 1 + =
(int)SID_SIZE || (data[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
@@ -254=
,7 +317,20 @@
 
     struct buffer buf;
     buf_set_read(&buf, data, (size=
_t)len);
-    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + server sess=
ion id */
+
+    /* Unwrap the reply with the same control-channel path the=
 server used to
+     * wrap it: this verifies the tls-auth HMAC / decrypts=
 tls-crypt, and (in all
+     * modes) strips the opcode + server session i=
d, leaving buf at the TLV
+     * payload=2E With no tls-auth/tls-crypt it =
just strips those header bytes, as
+     * before=2E read_control_auth() mu=
tates the wrapping context, so we work on a
+     * per-packet copy (as tls=
_pre_decrypt_lite() does on the server)=2E The peer
+     * address is only=
 used for log messages, and tls_options only for
+     * tls-crypt-v2 metad=
ata checks, so both are passed as NULL=2E */
+    struct tls_wrap_ctx wrap =
=3D *base_wrap;
+    if (!read_control_auth(&buf, &wrap, NULL, NULL))
+    =
{
+        return; /* not for us, or failed authentication */
+    }
 
    =
 struct oob_probe_reply reply;
     if (!oob_client_reply_read(&buf, &reply=
))
@@ -304,8 +380,9 @@
  * matches a probe we sent=2E Returns true if every=
 sent probe has been answered=2E */
 static bool
 oob_probe_receive_slice(c=
onst struct probe_ctx *pc, const struct timeval *deadline,
-               =
         const struct session_id *client_sid, const struct oob_probe_target=
 *targets,
-                        struct oob_probe_result *results, int n=
, int outstanding)
+                        const struct session_id *client=
_sid, const struct tls_wrap_ctx *wrap,
+                        const struc=
t oob_probe_target *targets, struct oob_probe_result *results, int n,
+    =
                    int outstanding)
 {
     while (true)
     {
@@ -355,7 =
+432,7 @@
                                     (struct sockaddr *)&from, &f=
romlen);
             if (len > 0)
             {
-                oob_prob=
e_handle_reply(data, len, client_sid, &from, targets, results, n);
+       =
         oob_probe_handle_reply(data, len, client_sid, wrap, &from, targets=
, results, n);
             }
         }
         if (oob_count_answered(ta=
rgets, results, n) >=3D outstanding)
@@ -397,8 +474,8 @@
  * once the windo=
w elapses or every sent probe has been answered=2E */
 static void
 oob_pro=
be_collect(struct probe_ctx *pc, const struct buffer *probe,
-             =
     const struct session_id *client_sid, const struct oob_probe_target *ta=
rgets,
-                  struct oob_probe_result *results, int n,
+       =
           const struct session_id *client_sid, const struct tls_wrap_ctx *=
wrap,
+                  const struct oob_probe_target *targets, struct oob=
_probe_result *results, int n,
                   const struct signal_info =
*sig)
 {
     /* number of probes we actually sent: stop early once they al=
l answer */
@@ -423,7 +500,7 @@
             deadline=2Etv_usec -=3D 100000=
0;
         }
 
-        if (oob_probe_receive_slice(pc, &deadline, client_=
sid, targets, results, n, want)
+        if (oob_probe_receive_slice(pc, &d=
eadline, client_sid, wrap, targets, results, n, want)
             || sig->=
signal_received)
         {
             return; /* all answered, or we are=
 being told to stop */
@@ -466,6 +543,16 @@
 
     struct gc_arena gc =3D g=
c_new();
 
+    /* Wrapping context for the probe (tls-auth/tls-crypt, or p=
laintext if
+     * neither)=2E NULL means this configuration cannot be pro=
bed; keep the
+     * configured order=2E */
+    struct tls_auth_standalon=
e *tas =3D oob_probe_init_tls_auth_standalone(c, &gc);
+    if (!tas)
+    =
{
+        gc_free(&gc);
+        return;
+    }
+
     /* A single random =
session id identifies all of our probes; servers echo it
      * back in th=
e reply's peer_session_id, letting us reject spoofed replies=2E */
     str=
uct session_id client_sid;
@@ -487,11 +574,21 @@
             tmpl =3D ce;
=
             continue;
         }
+        const char *differs =3D NULL;
  =
       if (!oob_probe_same_bind(tmpl, ce, &c->options))
         {
-       =
     msg(D_LOW, "server-probe: %s:%s binds differently from %s:%s;"
+      =
      differs =3D "binds";
+        }
+        else if (!oob_probe_same_wra=
p(tmpl, ce))
+        {
+            differs =3D "wraps the control channel=
";
+        }
+        if (differs)
+        {
+            msg(D_LOW, "ser=
ver-probe: %s:%s %s differently from %s:%s;"
                        " not =
probing, using configured order",
-                ce->remote, ce->remote_p=
ort, tmpl->remote, tmpl->remote_port);
+                ce->remote, ce->rem=
ote_port, differs, tmpl->remote, tmpl->remote_port);
+            oob_probe=
_free_wrap(c, tas);
             gc_free(&gc);
             return;
       =
  }
@@ -499,6 +596,7 @@
     if (!tmpl)
     {
         msg(D_LOW, "server-=
probe: no remote can be probed; using configured order");
+        oob_prob=
e_free_wrap(c, tas);
         gc_free(&gc);
         return;
     }
@@ -507=
,17 +605,39 @@
     struct oob_probe_target *targets =3D gc_malloc(sizeof(*=
targets) * l->len, true, &gc);
     struct oob_probe_result *results =3D gc=
_malloc(sizeof(*results) * l->len, true, &gc);
 
-    struct buffer probe =
=3D alloc_buf_gc(256, &gc);
-    if (!oob_probe_build_packet(&probe, &clien=
t_sid))
+    /* Build the probe once and reuse the same bytes for every rem=
ote and for
+     * resends: the SERVER_PROBE payload is a single probe_par=
ameter TLV, wrapped
+     * (or sent in plaintext) like any other control p=
acket=2E The client session
+     * id is prepended as the sender session i=
d=2E */
+    struct buffer payload =3D alloc_buf_gc(64, &gc);
+    const st=
ruct oob_probe_parameter param =3D {
+        =2Etimestamp =3D (uint64_t)no=
w,
+        =2Eflags =3D 0,
+    };
+    if (!oob_server_probe_write(&paylo=
ad, &param))
     {
-        msg(D_LOW, "server-probe: could not build prob=
e packet; using configured order");
+        msg(D_LOW, "server-probe: coul=
d not build probe payload; using configured order");
         oob_probe_soc=
kets_close(&pc);
+        oob_probe_free_wrap(c, tas);
         gc_free(&gc=
);
         return;
     }
 
-    msg(D_LOW, "server-probe: probing %d remo=
te(s) with a %d ms window", l->len,
-        OOB_PROBE_WINDOW_MS);
+    str=
uct buffer probe =3D tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_s=
id, &payload);
+    if (!BLEN(&probe))
+    {
+        msg(D_LOW, "server-p=
robe: could not wrap probe packet; using configured order");
+        oob_p=
robe_sockets_close(&pc);
+        oob_probe_free_wrap(c, tas);
+        gc_=
free(&gc);
+        return;
+    }
+
+    const char *wrap_name =3D (tas->t=
ls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
+                     =
       : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
+        =
                                                            : "none (plaint=
ext)";
+    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms win=
dow, control-channel wrapping: %s",
+        l->len, OOB_PROBE_WINDOW_MS, w=
rap_name);
 
     /* Resolve every remote first, so only the address famili=
es actually in use
      * get a probe socket=2E */
@@ -564,6 +684,7 @@
   =
      {
             freeaddrinfo(bind_local);
         }
+        oob_prob=
e_free_wrap(c, tas);
         gc_free(&gc);
         return;
     }
@@ -605=
,7 +726,7 @@
 
     if (sent_count > 0)
     {
-        oob_probe_collect(&=
pc, &probe, &client_sid, targets, results, l->len,
+        oob_probe_colle=
ct(&pc, &probe, &client_sid, &tas->tls_wrap, targets, results, l->len,
    =
                       c->sig);
     }
     oob_probe_sockets_close(&pc);
@=
@ -653,5 +774,6 @@
     msg(M_INFO, "server-probe: %d of %d remote(s) answe=
red; connecting best-first", responded,
         l->len);
 
+    oob_probe_=
free_wrap(c, tas);
     gc_free(&gc);
 }

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1913?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c
Gerrit-C=
hange-Number: 1913
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--0yibj6UAvfM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1913?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Wrap=
 the client SERVER_PROBE with tls-auth/tls-crypt<br><br>The client --server=
-probe previously sent a plaintext SERVER_PROBE and<br>parsed replies by ha=
nd, so it only worked against a server with no<br>control-channel wrapping=
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
be is byte-for-byte identical to<br>before, so the plaintext case is unchan=
ged=2E<br><br>tls-crypt-v2 is not supported yet: the server only learns the=
 client key<br>from the WKc carried in the TLS handshake, which an out-of-b=
and probe<br>cannot provide=2E Such configurations skip probing and keep th=
e configured<br>remote order=2E<br><br>The probe is wrapped with the first =
remote&#39;s key, so probing is declined<br>when another remote is keyed di=
fferently=2E The key material loaded for<br>the probe is released afterward=
s; init loads it again for the<br>connection=2E Change-Id: I1f9d7b5a5ec19bf=
77c0c212795f583c5ba4c03ac<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2E=
net&gt;<br><br>Change-Id: I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c<br>---<=
br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob_client=2Ec<=
br>2 files changed, 166 insertions(+), 42 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/13/=
1913/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/doc/man-sections/client-options=2Erst b/doc/man=
-sections/client-options=2Erst</span><br><span>index 76ec107=2E=2Efbc5d4b 1=
00644</span><br><span>--- a/doc/man-sections/client-options=2Erst</span><br=
><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@@ -617,=
20 +617,22 @@</span><br><span>   compared on latency alone, so only the fas=
test server of its priority</span><br><span>   group is treated as best=2E<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Th=
e probe is currently sent without control-channel wrapping, so it only</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  works against a server c=
onfigured without ``--tls-auth``,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  ``--tls-crypt`` or ``--tls-crypt-v2``=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  The probe carries the same control-cha=
nnel wrapping as a normal</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  connection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E =
With</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-crypt=
-v2`` the remotes are left in their configured order,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  because the server cannot unwrap an out=
-of-band probe yet=2E</span><br><span> </span><br><span>   Only UDP remotes=
 are probed, and only when there are at least two</span><br><span>   remote=
s; remotes reached through a SOCKS proxy are not probed=2E All</span><br><s=
pan>   probed remotes must share the local bind settings (``--local``,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--lport``, ``--bind``)=
 of the first one among them, since a single</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  socket per address family carries the probes; othe=
rwise probing is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ski=
pped and the configured order is used=2E Remotes that answered are tried fi=
rst, in the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  order de=
scribed above; all other remotes, including TCP ones, follow in</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  their configured order=2E Probi=
ng runs once, before the first connection</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  attempt; a restart does not probe again=2E See ``--se=
rver-probe-reply``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  f=
or the server side=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  ``--lport``, ``--bind``) and the control-channel key of the first one</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  among them, since a=
 single socket per address family carries the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  probes; otherwise probing is skipped and the co=
nfigured order is used=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Remotes that answered are tried first, in the order described above=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  all other remote=
s, including TCP ones, follow in their configured</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  order=2E Probing runs once, before the firs=
t connection attempt; a</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  restart does not probe again=2E See ``--server-probe-reply`` for the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server side=2E</sp=
an><br><span> </span><br><span> --static-challenge args</span><br><span>   =
Enable static challenge/response protocol</span><br><span>diff --git a/src/=
openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 2=
64ab6b=2E=2E1d936a6 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec=
</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -29,6 =
+29,8 @@</span><br><span> #include &quot;oob_client=2Eh&quot;</span><br><sp=
an> #include &quot;openvpn=2Eh&quot;</span><br><span> #include &quot;oob=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;init=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;ssl=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot=
;</span><br><span> #include &quot;session_id=2Eh&quot;</span><br><span> #in=
clude &quot;socket=2Eh&quot;</span><br><span>@@ -74,21 +76,67 @@</span><br>=
<span>     return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* Build a plaintext SERVER_PROBE packet:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *   [opcode | key_id=3D0] [client session id] =
[SERVER_PROBE message]</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * This is the unauthenticated OOB wire format; adding tls-auth/tls-crypt<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * wrapping for the pr=
obe is a follow-up (it only works against a server with</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * no control-channel wrapping for now)=
=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-oob_probe_build_packet(st=
ruct buffer *buf, const struct session_id *client_sid)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Build a standalone control-channel wr=
apping context for the probe, mirroring</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * the tls_auth_standalone the server uses to answer it=
=2E With neither tls-auth</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * nor tls-crypt configured the context stays in TLS_WRAP_NONE and th=
e probe is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sent i=
n plaintext, exactly as before; with either configured the probe is</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * authenticated/encrypted =
like any other control packet=2E Returns NULL (and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * logs) for configurations the probe cannot=
 wrap yet, in which case the caller</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * skips probing and keeps the configured remote order=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct tls_=
auth_standalone *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oo=
b_probe_init_tls_auth_standalone(struct context *c, struct gc_arena *gc)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onst struct oob_probe_parameter param =3D {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        =2Etimestamp =3D (uint64_t)now,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        =2Eflags =3D 0,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    };</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V=
1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return buf_write_u8(buf, header) &amp;&amp; session_id_write(clie=
nt_sid, buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
  &amp;&amp; oob_server_probe_write(buf, &amp;param);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* The probe runs before next_connect=
ion_entry() maps a connection entry</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * into options=2Ece, so take the wrapping config from =
the first connection</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * entry directly=2E A global --tls-auth/--tls-crypt is copied into ev=
ery</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * connectio=
n-list entry by options_postprocess_mutate_ce(), so the first</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * entry carries it even thou=
gh options=2Ece does not yet=2E (Probing wraps a</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * single packet for all remotes, so per-c=
onnection-block keys are not</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * supported; the first entry&#39;s wrapping is used for all=
=2E) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const st=
ruct connection_entry *ce =3D c-&gt;options=2Econnection_list-&gt;array[0];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* tls-crypt-v2 wraps with a per-c=
lient key the server only learns from the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * wrapped client key (WKc) carried in the TLS ha=
ndshake=2E An out-of-band</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * probe carries no WKc, so the server cannot unwrap it; skip pro=
bing rather</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * t=
han send something unverifiable=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (ce-&gt;tls_crypt_v2_file)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: not supported wi=
th tls-crypt-v2; using configured order&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Load the tls-auth/tls-crypt key material into c-&gt;c1=2Eks (a no-op if =
neither</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * is co=
nfigured)=2E This is run again per-connection later; calling it early</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * here is harmless=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_init_t=
ls_wrap_key(c, ce);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_opti=
ons to;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(to=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_tls_wrap=
_ctx(&amp;to=2Etls_wrap, ce, c-&gt;options=2Etls_client, &amp;c-&gt;c1=2Eks=
, &amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    to=2Ereplay_window =3D c-&gt;options=2Ereplay_window;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_time =3D =
c-&gt;options=2Ereplay_time;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 tls_auth_standalone *tas =3D tls_auth_standalone_init(&amp;to, gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Control-channel frame and work buffers=
, mirroring do_init_frame_tls()=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    tls_init_control_channel_frame_parameters(&amp;tas-&g=
t;frame, ce-&gt;tls_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    tas-&gt;tls_wrap=2Ework =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;fr=
ame), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas-&=
gt;workbuf =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return tas;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Release the pr=
obe&#39;s wrapping context and the key material</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * do_init_tls_wrap_key() loaded for it: do_ini=
t_crypto_tls_c1() loads the same</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * fields again later without freeing them first=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+oob_probe_free_wrap(struct context =
*c, struct tls_auth_standalone *tas)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   tls_auth_standalone_free(tas);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    free_key_ctx_bi(&amp;c-&gt;c1=2Eks=2Etls_wrap_key);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(c-&gt;c1=2Eks=
=2Etls_wrap_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_clear(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;c-&gt;c1=2Eks=2Etls_cry=
pt_v2_wkc);</span><br><span> }</span><br><span> </span><br><span> /* The lo=
cal address and port ce&#39;s connection socket binds: its first --local,</=
span><br><span>@@ -148,6 +196,21 @@</span><br><span>            &amp;&amp; =
str_equal_or_both_null(port_a, port_b);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Do a and b wrap=
 the control channel with the same key (--tls-auth,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt, --tls-crypt-v2 and key di=
rection)? The one probe is wrapped</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * with entry 0&#39;s key, so a server keyed differently cou=
ld never answer it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob=
_probe_same_wrap(const struct connection_entry *a, const struct connection_=
entry *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return str_equal_or_both=
_null(a-&gt;tls_auth_file, b-&gt;tls_auth_file)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt;tls_auth_file_inlin=
e =3D=3D b-&gt;tls_auth_file_inline</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           &amp;&amp; a-&gt;key_direction =3D=3D b-&gt;key_=
direction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
 &amp;&amp; str_equal_or_both_null(a-&gt;tls_crypt_file, b-&gt;tls_crypt_fi=
le)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;=
&amp; a-&gt;tls_crypt_file_inline =3D=3D b-&gt;tls_crypt_file_inline</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; str_=
equal_or_both_null(a-&gt;tls_crypt_v2_file, b-&gt;tls_crypt_v2_file)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; a-&g=
t;tls_crypt_v2_file_inline =3D=3D b-&gt;tls_crypt_v2_file_inline;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /* Resolve the local bind add=
ress of ce&#39;s connection socket; NULL with --nobind=2E</span><br><span> =
 * Fatal on failure, like the link socket=2E */</span><br><span> static str=
uct addrinfo *</span><br><span>@@ -242,9 +305,9 @@</span><br><span> /* Pars=
e one received datagram as a PROBE_REPLY and, if valid and matching one</sp=
an><br><span>  * of the probes we sent, record the reply in results=2E */</=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-oob_probe_handle_reply(const uint8_t *data, int len, const struct ses=
sion_id *client_sid,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                      const struct openvpn_sockaddr *from, const struct oob=
_probe_target *targets,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                       struct oob_probe_result *results, int n)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_handle_reply(uint8_=
t *data, int len, const struct session_id *client_sid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                       const struct tls_=
wrap_ctx *base_wrap, const struct openvpn_sockaddr *from,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                       const struct o=
ob_probe_target *targets, struct oob_probe_result *results, int n)</span><b=
r><span> {</span><br><span>     /* Need at least the opcode byte and the se=
ssion id=2E */</span><br><span>     if (len &lt; 1 + (int)SID_SIZE || (data=
[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><span>@@ -254=
,7 +317,20 @@</span><br><span> </span><br><span>     struct buffer buf;</sp=
an><br><span>     buf_set_read(&amp;buf, data, (size_t)len);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    buf_advance(&amp;buf, 1 + SID_SI=
ZE); /* skip opcode + server session id */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Unwrap the reply with the same control-channel path the server u=
sed to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * wrap i=
t: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in all</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * modes) strips the o=
pcode + server session id, leaving buf at the TLV</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * payload=2E With no tls-auth/tls-crypt =
it just strips those header bytes, as</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * before=2E read_control_auth() mutates the wrapping=
 context, so we work on a</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * per-packet copy (as tls_pre_decrypt_lite() does on the server)=
=2E The peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
address is only used for log messages, and tls_options only for</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * tls-crypt-v2 metadata ch=
ecks, so both are passed as NULL=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct tls_wrap_ctx wrap =3D *base_wrap;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!read_control_auth(&amp=
;buf, &amp;wrap, NULL, NULL))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return; /* not for us, or failed authentication */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>=
     struct oob_probe_reply reply;</span><br><span>     if (!oob_client_rep=
ly_read(&amp;buf, &amp;reply))</span><br><span>@@ -304,8 +380,9 @@</span><b=
r><span>  * matches a probe we sent=2E Returns true if every sent probe has=
 been answered=2E */</span><br><span> static bool</span><br><span> oob_prob=
e_receive_slice(const struct probe_ctx *pc, const struct timeval *deadline,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   const struct session_id *client_sid, const struct oob_probe_target *targ=
ets,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       struct oob_probe_result *results, int n, int outstanding)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        const =
struct session_id *client_sid, const struct tls_wrap_ctx *wrap,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        const s=
truct oob_probe_target *targets, struct oob_probe_result *results, int n,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   int outstanding)</span><br><span> {</span><br><span>     while (true)</s=
pan><br><span>     {</span><br><span>@@ -355,7 +432,7 @@</span><br><span>  =
                                   (struct sockaddr *)&amp;from, &amp;froml=
en);</span><br><span>             if (len &gt; 0)</span><br><span>         =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
oob_probe_handle_reply(data, len, client_sid, &amp;from, targets, results, =
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
oob_probe_handle_reply(data, len, client_sid, wrap, &amp;from, targets, res=
ults, n);</span><br><span>             }</span><br><span>         }</span><=
br><span>         if (oob_count_answered(targets, results, n) &gt;=3D outst=
anding)</span><br><span>@@ -397,8 +474,8 @@</span><br><span>  * once the wi=
ndow elapses or every sent probe has been answered=2E */</span><br><span> s=
tatic void</span><br><span> oob_probe_collect(struct probe_ctx *pc, const s=
truct buffer *probe,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                 const struct session_id *client_sid, const struct oob_prob=
e_target *targets,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
               struct oob_probe_result *results, int n,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  const struct session_=
id *client_sid, const struct tls_wrap_ctx *wrap,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                  const struct oob_probe_targe=
t *targets, struct oob_probe_result *results, int n,</span><br><span>      =
             const struct signal_info *sig)</span><br><span> {</span><br><s=
pan>     /* number of probes we actually sent: stop early once they all ans=
wer */</span><br><span>@@ -423,7 +500,7 @@</span><br><span>             dea=
dline=2Etv_usec -=3D 1000000;</span><br><span>         }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (oob_probe_=
receive_slice(pc, &amp;deadline, client_sid, targets, results, n, want)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_probe_r=
eceive_slice(pc, &amp;deadline, client_sid, wrap, targets, results, n, want=
)</span><br><span>             || sig-&gt;signal_received)</span><br><span>=
         {</span><br><span>             return; /* all answered, or we are =
being told to stop */</span><br><span>@@ -466,6 +543,16 @@</span><br><span>=
 </span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Wrapping conte=
xt for the probe (tls-auth/tls-crypt, or plaintext if</span><br><span style=
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
id client_sid;</span><br><span>@@ -487,11 +574,21 @@</span><br><span>      =
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
an>         }</span><br><span>@@ -499,6 +596,7 @@</span><br><span>     if (=
!tmpl)</span><br><span>     {</span><br><span>         msg(D_LOW, &quot;ser=
ver-probe: no remote can be probed; using configured order&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_free_wrap(=
c, tas);</span><br><span>         gc_free(&amp;gc);</span><br><span>       =
  return;</span><br><span>     }</span><br><span>@@ -507,17 +605,39 @@</spa=
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
t=2E */</span><br><span>@@ -564,6 +684,7 @@</span><br><span>         {</spa=
n><br><span>             freeaddrinfo(bind_local);</span><br><span>        =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe=
_free_wrap(c, tas);</span><br><span>         gc_free(&amp;gc);</span><br><s=
pan>         return;</span><br><span>     }</span><br><span>@@ -605,7 +726,=
7 @@</span><br><span> </span><br><span>     if (sent_count &gt; 0)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, targets, results, =
l-&gt;len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wra=
p, targets, results, l-&gt;len,</span><br><span>                           =
c-&gt;sig);</span><br><span>     }</span><br><span>     oob_probe_sockets_c=
lose(&amp;pc);</span><br><span>@@ -653,5 +774,6 @@</span><br><span>     msg=
(M_INFO, &quot;server-probe: %d of %d remote(s) answered; connecting best-f=
irst&quot;, responded,</span><br><span>         l-&gt;len);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_fre=
e_wrap(c, tas);</span><br><span>     gc_free(&amp;gc);</span><br><span> }</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1913?usp=3Demail">change 1913</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1913?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8db15c22261277c=
44a2efd3d2e7cf71f23ea0c </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1913 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--0yibj6UAvfM=--


--===============4302236586353142446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4302236586353142446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4302236586353142446==--

