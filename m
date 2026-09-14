Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A59C88E7E
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=omCXPRxy3rm3YrBi/jtYhmWpCQblmTl+LT2fl0FNQnc=; b=HcDQ01wXPMz54gMW6AVyRZCxQG
	AA1LR1bwpv+3isYoysrmWhwxr3iF34P4GbPTKbezEFjVg4CmDSuH1xKtrdAcQPP1P3nZHopuF5AQM
	jSK5Z8nRkUYKy9jt0GuHkBQeKSjJ1vFp+ZgfABisxzUh834qCUavLP8KUaENodaVeT2I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67WU-0006f4-7u;
	Mon, 14 Sep 2026 14:19:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WS-0006ew-JX
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DxPFsZgME5Ev9gIQOf1xEFLbf/Z0NFreAC9gzSy/DtY=; b=iIC74xLpGuUlW4u9cP8D8PODtO
 XcH8PNsXBdctNpZl3w7aq1hlzONGMVo7B6WMchtNNCrCtpzrHli6S4RG/3JYpBILW97H02o4AeHIE
 l7jh0CdZNtM64eExk7cyfldCI4wvLMHN75hiVwOklHmiK/Lk+mGnknYaWwpw+u4narmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DxPFsZgME5Ev9gIQOf1xEFLbf/Z0NFreAC9gzSy/DtY=; b=l
 +7831ROn0UnVRb7buwYRBkTWUVrp+BgSUr+8T9bgyOOMT8nkY1Aa/0dcyY+Y20OruXW//M6pji+Er
 jbuHyjjTTsX2G/mRVGN1gOVbXWHZQ1s/RWpAd3aX28HafqjZWbhflJ0DpbmuUaK3AeMrAADx2Np7f
 gvEzjTt/SdWV4zBg=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WN-0001SA-17 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:04 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49e6b280cadso27678745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395532; x=1790000332; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DxPFsZgME5Ev9gIQOf1xEFLbf/Z0NFreAC9gzSy/DtY=;
 b=fUpBAEXokrktKVH0WMlWljBFntFdMO1+qOvZt66POg5pZxbIFJT2dShrNiGTMTpvfm
 F8xQgX2YBKfBIU3gMtc4QAkPgaRhO00v+KRQvT1m7FR6V2XfODJJAIjSFRZkut81V53N
 X925NUdOe/rLIt8rDh5WUxctkuQJBHd+ZMQA4BVZ1YWGmHCgH5NfgPKhRaHHm/ON3HCd
 btZazV7NmoYCbFnQtJsRcfIuiH4pikqXt1ldcZ0D6uV9YYlJ31tSb5e2cVMmFCxUBLUC
 oi7fU8FsC0ZaXF3uX9GfWGdS4/cL/spnxIQWnPWtXrWxtLvsrCTlhkgctPW40yJnRzMv
 05tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395532; x=1790000332;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DxPFsZgME5Ev9gIQOf1xEFLbf/Z0NFreAC9gzSy/DtY=;
 b=W0D7XSJKN0W5NVwx/MWAyRHgG9IcqnEvoXPMjLfsjHWXAVLSdKBSGWkHGNxEnmPFeY
 vtQg54CRvUmQgASJFGEw/7H+0O5ZQAInywD1fko/NWC+sacpjov5FVXs4ynFeqMkYarT
 imRjwozK7CFZpP+k/DX9OjJrdfu+7riyrDSvaLahUQ5OEGwS/QjmPk7dUdKJFk5AsCtd
 vncBSbH51H6muNL/buMdqC5Owb2hiyizBTB5LHlCC7T5ct0bKRa/ieNU0xnZdjoceQk5
 q2gAzaydiAZHblcDd2ouC9O6IJbtEHqVTAqzPF6CkWszLLLai7QHUuvDbF5ALQpGJM1X
 8Y6w==
X-Gm-Message-State: AFuF++nComZNKOTozmE7lfqS2EuuqKKGOkDp7OhItxnP0T7BIjfO2xb7
 s7L8E8LURWguZwMtObjX7te11/vuos0Ogtkf3XAJ/BPZRmgW1sYRRKwnAoON1M6w95wDbLTf7Yg
 3iZKnJq3ZyZJeo3bHxAMtyT86oYsQQGBT1SeK2FQ/iy48JAkyeAI43Co5mgkcg/m1Uh/0
X-Gm-Gg: AYBFou1jJCbA/DteoWSvnNoJ5vYZ8r0JJuEIqaVTm0c6dNO7007HhDgniRyG0gUIpJh
 zmiKa9IvMtjlVbUQnO0cP3jtnpXWFcJxKZLoBlLtbdVt3QVO5T2OnEsthDOd+BScvcT9enbqK+K
 m372KZs6Q8234nwCeCue+85Hf7Lb8NsMDQkHboCBeFesMXo296/5DTNx1fpCWz4GvpDlbijw43u
 r0YK8Q58Mbsw9HGe6eXSdr0xk9K6R2NvlAPwrPyj98vAAcC60eatw4yD2XYr93YHdT3THqlCEFO
 8QJslGi5bldD5Krcj83+JEZN21204oo0wwolFpQ1heHbCBwtYoGzYWVCLn9nIjU8MR4VRENmthK
 1tQQ42RFJSnfRkm2g8EgpDgJAKzAemdGcX3HlHgGQyy06X3q2entXn6d9u/h8W8/bPqCWtOrEog
 9ZFbJUYfKjanL0as7sYUpAfy6Q2KdxNl5JYyfds4sNcuuSYpQp40eGfZbxYGDUKHBzZ05HuZLOl
 NFhWNNsP7nVP8fscB1ZgJg44g+uv9shoEAFXZirsMdbdMIx8h4cu+1nkXZa8HBEp2/2JUI+UMEa
 suxEu2x6Pewcln7lcllJfpDm6TXbBfFzrqhEFm7KL8Lje2Eak0fxQLkV+wvotA==
X-Received: by 2002:a05:600c:4e89:b0:49c:fc6e:8cbd with SMTP id
 5b1f17b1804b1-49e7a683a35mr33663935e9.33.1789395532042; 
 Mon, 14 Sep 2026 07:18:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm678228805e9.6.2026.09.14.07.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:51 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: 7ae449254bdf2e78c59214b71fe4e36cf389e76d
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <73ee2e3ef6185c54e49943fd867a50c616ededc7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WN-0001SA-17
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
Content-Type: multipart/mixed; boundary="===============9177283630962212218=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9177283630962212218==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r233bwS/ZQ8="; charset=UTF-8

--r233bwS/ZQ8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1750?usp=3Demail

to look at the new patch set (#20)=2E
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
 on-wire probe is byte-for-byte identical to
before, so the plaintext case =
is unchanged=2E

tls-crypt-v2 is not supported yet: the server only learns =
the client key
from the WKc carried in the TLS handshake, which an out-of-b=
and probe
cannot provide=2E Such configurations skip probing and keep the c=
onfigured
remote order=2E

The probe is wrapped with the first remote's key=
, so probing is declined
when another remote is keyed differently=2E The ke=
y material loaded for
the probe is released afterwards; init loads it again=
 for the
connection=2E

Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03a=
c
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections/cl=
ient-options=2Erst
M src/openvpn/oob_client=2Ec
2 files changed, 176 insert=
ions(+), 41 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/50/1750/20

diff --git a/doc/man-sections/client-options=
=2Erst b/doc/man-sections/client-options=2Erst
index 766e3bc=2E=2E8b6bb2f 1=
00644
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections/cl=
ient-options=2Erst
@@ -617,19 +617,21 @@
   server advertising :code:`0` as=
ks to be considered only while it ties
   the fastest of its priority group=
, without constraining the others=2E
 
-  The probe is currently sent witho=
ut control-channel wrapping, so it only
-  works against a server configure=
d without ``--tls-auth``,
-  ``--tls-crypt`` or ``--tls-crypt-v2``=2E
+  Th=
e probe carries the same control-channel wrapping as a normal
+  connection=
 (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With
+  ``--tls-cr=
ypt-v2`` the remotes are left in their configured order,
+  because the ser=
ver cannot unwrap an out-of-band probe yet=2E
 
   Only UDP remotes are pro=
bed, and only when there are at least two
   remotes; remotes reached throu=
gh a SOCKS proxy are not probed=2E All
   probed remotes must share the loc=
al bind settings (``--local``,
-  ``--lport``, ``--bind``) of the first one=
 among them, since a single
-  socket per address family carries the probes=
; otherwise probing is
-  skipped and the configured order is used=2E Remot=
es that answered are tried first, in the
-  order described above; all othe=
r remotes, including TCP ones, follow in
-  their configured order=2E Probi=
ng runs once, before the first connection
-  attempt; a restart does not pr=
obe again=2E
+  ``--lport``, ``--bind``) and the control-channel key of the=
 first one
+  among them, since a single socket per address family carries =
the
+  probes; otherwise probing is skipped and the configured order is use=
d=2E
+  Remotes that answered are tried first, in the order described above=
;
+  all other remotes, including TCP ones, follow in their configured
+  o=
rder=2E Probing runs once, before the first connection attempt; a
+  restar=
t does not probe again=2E
 
   Probing delays the first connection attempt =
by up to one second, plus
   the time needed to resolve each remote=2E A se=
rver only answers a probe
diff --git a/src/openvpn/oob_client=2Ec b/src/ope=
nvpn/oob_client=2Ec
index 61e2602=2E=2Ec3e2e2b 100644
--- a/src/openvpn/oob=
_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -29,6 +29,8 @@
 #include "o=
ob_client=2Eh"
 #include "openvpn=2Eh"
 #include "oob=2Eh"
+#include "init=
=2Eh"
+#include "ssl=2Eh"
 #include "ssl_pkt=2Eh"
 #include "session_id=2Eh=
"
 #include "socket=2Eh"
@@ -79,21 +81,78 @@
     return (af =3D=3D AF_INET=
6) ? PROBE_AF_V6 : PROBE_AF_V4;
 }
 
-/* Build a plaintext SERVER_PROBE pac=
ket:
- *   [opcode | key_id=3D0] [client session id] [SERVER_PROBE message]=

- * This is the unauthenticated OOB wire format; adding tls-auth/tls-crypt=

- * wrapping for the probe is a follow-up (it only works against a server =
with
- * no control-channel wrapping for now)=2E */
-static bool
-oob_probe=
_build_packet(struct buffer *buf, const struct session_id *client_sid)
+sta=
tic bool oob_probe_eligible(const struct connection_entry *ce);
+
+/* Build=
 a standalone control-channel wrapping context for the probe, mirroring
+ *=
 the tls_auth_standalone the server uses to answer it=2E With neither tls-a=
uth
+ * nor tls-crypt configured the context stays in TLS_WRAP_NONE and the=
 probe is
+ * sent in plaintext, exactly as before; with either configured =
the probe is
+ * authenticated/encrypted like any other control packet=2E R=
eturns NULL (and
+ * logs) for configurations the probe cannot wrap yet, in=
 which case the caller
+ * skips probing and keeps the configured remote or=
der=2E */
+static struct tls_auth_standalone *
+oob_probe_init_tls_auth_sta=
ndalone(struct context *c, struct gc_arena *gc)
 {
-    const struct oob_pr=
obe_parameter param =3D {
-        =2Etimestamp =3D (uint64_t)now,
-       =
 =2Eflags =3D 0,
-    };
-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1=
 << P_OPCODE_SHIFT);
-    return buf_write_u8(buf, header) && session_id_wr=
ite(client_sid, buf)
-           && oob_server_probe_write(buf, &param);
+ =
   /* Wrap with the first entry we can actually probe: that is the entry ev=
ery
+     * other probed remote is checked against, so the key on the wire =
is the one
+     * they were checked for=2E Falls back to entry 0 when noth=
ing is probeable,
+     * in which case the caller bails out before anythin=
g is sent=2E */
+    const struct connection_list *l =3D c->options=2Econne=
ction_list;
+    const struct connection_entry *ce =3D l->array[0];
+    fo=
r (int i =3D 0; i < l->len; i++)
+    {
+        if (oob_probe_eligible(l->=
array[i]))
+        {
+            ce =3D l->array[i];
+            break;
=
+        }
+    }
+
+    /* tls-crypt-v2 wraps with a per-client key the se=
rver only learns from the
+     * wrapped client key (WKc) carried in the T=
LS handshake=2E An out-of-band
+     * probe carries no WKc, so the server =
cannot unwrap it; skip probing rather
+     * than send something unverifia=
ble=2E */
+    if (ce->tls_crypt_v2_file)
+    {
+        msg(D_LOW, "serve=
r-probe: not supported with tls-crypt-v2; using configured order");
+      =
  return NULL;
+    }
+
+    /* Load the tls-auth/tls-crypt key material in=
to c->c1=2Eks (a no-op if neither
+     * is configured)=2E This is run aga=
in per-connection later; calling it early
+     * here is harmless=2E */
+ =
   do_init_tls_wrap_key(c, ce);
+
+    struct tls_options to;
+    CLEAR(to=
);
+    init_tls_wrap_ctx(&to=2Etls_wrap, ce, c->options=2Etls_client, &c->=
c1=2Eks, &c->c1=2Epid_persist);
+    to=2Ereplay_window =3D c->options=2Ere=
play_window;
+    to=2Ereplay_time =3D c->options=2Ereplay_time;
+
+    str=
uct tls_auth_standalone *tas =3D tls_auth_standalone_init(&to, gc);
+
+    =
/* Control-channel frame and work buffers, mirroring do_init_frame_tls()=2E=
 */
+    tls_init_control_channel_frame_parameters(&tas->frame, ce->tls_mtu=
);
+    tas->tls_wrap=2Ework =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+=
    tas->workbuf =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+
+    return=
 tas;
+}
+
+/* Release the probe's wrapping context and the key material
+ =
* do_init_tls_wrap_key() loaded for it: do_init_crypto_tls_c1() loads the s=
ame
+ * fields again later without freeing them first=2E */
+static void
+o=
ob_probe_free_wrap(struct context *c, struct tls_auth_standalone *tas)
+{
+=
    tls_auth_standalone_free(tas);
+    free_key_ctx_bi(&c->c1=2Eks=2Etls_w=
rap_key);
+    CLEAR(c->c1=2Eks=2Etls_wrap_key);
+    buf_clear(&c->c1=2Eks=
=2Etls_crypt_v2_wkc);
+    free_buf(&c->c1=2Eks=2Etls_crypt_v2_wkc);
+    /=
* the raw key bytes too: do_init_crypto_tls_c1() may never load a key over
=
+     * them, so they would otherwise stay resident for the process lifetim=
e */
+    secure_memzero(&c->c1=2Eks=2Eoriginal_wrap_keydata, sizeof(c->c1=
=2Eks=2Eoriginal_wrap_keydata));
 }
 
 /* The local address and port ce's c=
onnection socket binds: its first --local,
@@ -156,6 +215,21 @@
           =
 && str_equal_or_both_null(port_a, port_b);
 }
 
+/* Do a and b wrap the co=
ntrol channel with the same key (--tls-auth,
+ * --tls-crypt, --tls-crypt-v=
2 and key direction)? The one probe is wrapped
+ * with entry 0's key, so a=
 server keyed differently could never answer it=2E */
+static bool
+oob_pro=
be_same_wrap(const struct connection_entry *a, const struct connection_entr=
y *b)
+{
+    return str_equal_or_both_null(a->tls_auth_file, b->tls_auth_f=
ile)
+           && a->tls_auth_file_inline =3D=3D b->tls_auth_file_inline
=
+           && a->key_direction =3D=3D b->key_direction
+           && str_=
equal_or_both_null(a->tls_crypt_file, b->tls_crypt_file)
+           && a->=
tls_crypt_file_inline =3D=3D b->tls_crypt_file_inline
+           && str_eq=
ual_or_both_null(a->tls_crypt_v2_file, b->tls_crypt_v2_file)
+           &&=
 a->tls_crypt_v2_file_inline =3D=3D b->tls_crypt_v2_file_inline;
+}
+
 /* R=
esolve the local bind address of ce's connection socket; NULL with --nobind=
=2E
  * Fatal on failure, like the link socket=2E */
 static struct addrinf=
o *
@@ -250,9 +324,9 @@
 /* Parse one received datagram as a PROBE_REPLY an=
d, if valid and matching one
  * of the probes we sent, record the reply in=
 results=2E */
 static void
-oob_probe_handle_reply(const uint8_t *data, in=
t len, const struct session_id *client_sid,
-                       const s=
truct openvpn_sockaddr *from, const struct oob_probe_target *targets,
-    =
                   struct oob_probe_result *results, int n)
+oob_probe_hand=
le_reply(uint8_t *data, int len, const struct session_id *client_sid,
+    =
                   const struct tls_wrap_ctx *base_wrap, const struct openv=
pn_sockaddr *from,
+                       const struct oob_probe_target *t=
argets, struct oob_probe_result *results, int n)
 {
     /* Need at least t=
he opcode byte and the session id=2E */
     if (len < 1 + (int)SID_SIZE ||=
 (data[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
@@ -262,7 +336,20 @@
 
=
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)len);
-    bu=
f_advance(&buf, 1 + SID_SIZE); /* skip opcode + server session id */
+
+   =
 /* Unwrap the reply with the same control-channel path the server used to
=
+     * wrap it: this verifies the tls-auth HMAC / decrypts tls-crypt, and =
(in all
+     * modes) strips the opcode + server session id, leaving buf a=
t the TLV
+     * payload=2E With no tls-auth/tls-crypt it just strips thos=
e header bytes, as
+     * before=2E read_control_auth() mutates the wrappi=
ng context, so we work on a
+     * per-packet copy (as tls_pre_decrypt_lit=
e() does on the server)=2E The peer
+     * address is only used for log me=
ssages, and tls_options only for
+     * tls-crypt-v2 metadata checks, so b=
oth are passed as NULL=2E */
+    struct tls_wrap_ctx wrap =3D *base_wrap;
=
+    if (!read_control_auth(&buf, &wrap, NULL, NULL))
+    {
+        retur=
n; /* not for us, or failed authentication */
+    }
 
     struct oob_prob=
e_reply reply;
     if (!oob_client_reply_read(&buf, &reply))
@@ -314,8 +40=
1,9 @@
  * matches a probe we sent=2E Returns true if every sent probe has =
been answered=2E */
 static bool
 oob_probe_receive_slice(const struct prob=
e_ctx *pc, const struct timeval *deadline,
-                        const s=
truct session_id *client_sid, const struct oob_probe_target *targets,
-    =
                    struct oob_probe_result *results, int n, int outstandin=
g)
+                        const struct session_id *client_sid, const stru=
ct tls_wrap_ctx *wrap,
+                        const struct oob_probe_targ=
et *targets, struct oob_probe_result *results, int n,
+                    =
    int outstanding)
 {
     while (true)
     {
@@ -365,7 +453,7 @@
      =
                               (struct sockaddr *)&from, &fromlen);
       =
      if (len > 0)
             {
-                oob_probe_handle_reply(d=
ata, len, client_sid, &from, targets, results, n);
+                oob_pro=
be_handle_reply(data, len, client_sid, wrap, &from, targets, results, n);
 =
            }
         }
         if (oob_count_answered(targets, results, =
n) >=3D outstanding)
@@ -418,8 +506,8 @@
  * once the window elapses or eve=
ry sent probe has been answered=2E */
 static void
 oob_probe_collect(struc=
t probe_ctx *pc, const struct buffer *probe,
-                  const struc=
t session_id *client_sid, struct oob_probe_target *targets,
-              =
    struct oob_probe_result *results, int n,
+                  const struc=
t session_id *client_sid, const struct tls_wrap_ctx *wrap,
+               =
   struct oob_probe_target *targets, struct oob_probe_result *results, int =
n,
                   const struct signal_info *sig)
 {
     /* number of p=
robes we actually sent: stop early once they all answer */
@@ -444,7 +532,7=
 @@
             deadline=2Etv_usec -=3D 1000000;
         }
 
-        if =
(oob_probe_receive_slice(pc, &deadline, client_sid, targets, results, n, wa=
nt)
+        if (oob_probe_receive_slice(pc, &deadline, client_sid, wrap, t=
argets, results, n, want)
             || sig->signal_received)
         {
=
             return; /* all answered, or we are being told to stop */
@@ -4=
87,6 +575,16 @@
 
     struct gc_arena gc =3D gc_new();
 
+    /* Wrapping =
context for the probe (tls-auth/tls-crypt, or plaintext if
+     * neither)=
=2E NULL means this configuration cannot be probed; keep the
+     * config=
ured order=2E */
+    struct tls_auth_standalone *tas =3D oob_probe_init_tl=
s_auth_standalone(c, &gc);
+    if (!tas)
+    {
+        gc_free(&gc);
+  =
      return;
+    }
+
     /* A single random session id identifies all of=
 our probes; servers echo it
      * back in the reply's peer_session_id, l=
etting us reject spoofed replies=2E */
     struct session_id client_sid;
@=
@ -508,11 +606,21 @@
             tmpl =3D ce;
             continue;
     =
    }
+        const char *differs =3D NULL;
         if (!oob_probe_same_b=
ind(tmpl, ce, &c->options))
         {
-            msg(D_LOW, "server-prob=
e: %s:%s binds differently from %s:%s;"
+            differs =3D "binds";
+=
        }
+        else if (!oob_probe_same_wrap(tmpl, ce))
+        {
+   =
         differs =3D "wraps the control channel";
+        }
+        if (d=
iffers)
+        {
+            msg(D_LOW, "server-probe: %s:%s %s differen=
tly from %s:%s;"
                        " not probing, using configured or=
der",
-                ce->remote, ce->remote_port, tmpl->remote, tmpl->rem=
ote_port);
+                ce->remote, ce->remote_port, differs, tmpl->rem=
ote, tmpl->remote_port);
+            oob_probe_free_wrap(c, tas);
        =
     gc_free(&gc);
             return;
         }
@@ -520,6 +628,7 @@
    =
 if (!tmpl)
     {
         msg(D_LOW, "server-probe: no remote can be prob=
ed; using configured order");
+        oob_probe_free_wrap(c, tas);
       =
  gc_free(&gc);
         return;
     }
@@ -528,17 +637,39 @@
     struct o=
ob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l->len, true, &gc=
);
     struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l=
->len, true, &gc);
 
-    struct buffer probe =3D alloc_buf_gc(256, &gc);
-=
    if (!oob_probe_build_packet(&probe, &client_sid))
+    /* Build the pro=
be once and reuse the same bytes for every remote and for
+     * resends: =
the SERVER_PROBE payload is a single probe_parameter TLV, wrapped
+     * (=
or sent in plaintext) like any other control packet=2E The client session
+=
     * id is prepended as the sender session id=2E */
+    struct buffer pa=
yload =3D alloc_buf_gc(64, &gc);
+    const struct oob_probe_parameter para=
m =3D {
+        =2Etimestamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+=
    };
+    if (!oob_server_probe_write(&payload, &param))
     {
-        =
msg(D_LOW, "server-probe: could not build probe packet; using configured or=
der");
+        msg(D_LOW, "server-probe: could not build probe payload; us=
ing configured order");
         oob_probe_sockets_close(&pc);
+        oob=
_probe_free_wrap(c, tas);
         gc_free(&gc);
         return;
     }
 
=
-    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window", l=
->len,
-        OOB_PROBE_WINDOW_MS);
+    struct buffer probe =3D tls_wrap=
_oob_standalone(&tas->tls_wrap, tas, &client_sid, &payload);
+    if (!BLEN=
(&probe))
+    {
+        msg(D_LOW, "server-probe: could not wrap probe pa=
cket; using configured order");
+        oob_probe_sockets_close(&pc);
+   =
     oob_probe_free_wrap(c, tas);
+        gc_free(&gc);
+        return;
+=
    }
+
+    const char *wrap_name =3D (tas->tls_wrap=2Emode =3D=3D TLS_WRA=
P_CRYPT)  ? "tls-crypt"
+                            : (tas->tls_wrap=2Emod=
e =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
+                                     =
                               : "none (plaintext)";
+    msg(D_LOW, "serve=
r-probe: probing %d remote(s) with a %d ms window, control-channel wrapping=
: %s",
+        l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 
     /* Resolve =
every remote first, so only the address families actually in use
      * ge=
t a probe socket=2E */
@@ -585,6 +716,7 @@
         {
             freeaddr=
info(bind_local);
         }
+        oob_probe_free_wrap(c, tas);
        =
 gc_free(&gc);
         return;
     }
@@ -646,7 +778,7 @@
 
     if (sent_=
count > 0)
     {
-        oob_probe_collect(&pc, &probe, &client_sid, targ=
ets, results, l->len,
+        oob_probe_collect(&pc, &probe, &client_sid, =
&tas->tls_wrap, targets, results, l->len,
                           c->sig=
);
     }
     oob_probe_sockets_close(&pc);
@@ -694,5 +826,6 @@
     msg(M=
_INFO, "server-probe: %d of %d probed remote(s) answered; connecting best-f=
irst",
         responded, sent_count);
 
+    oob_probe_free_wrap(c, tas);=

     gc_free(&gc);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1750?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Gerrit-Change-Number: 1750
=
Gerrit-PatchSet: 20
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>

--r233bwS/ZQ8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #20</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
be is byte-for-byte identical to<br>before, so the plaintext case is unchan=
ged=2E<br><br>tls-crypt-v2 is not supported yet: the server only learns the=
 client key<br>from the WKc carried in the TLS handshake, which an out-of-b=
and probe<br>cannot provide=2E Such configurations skip probing and keep th=
e configured<br>remote order=2E<br><br>The probe is wrapped with the first =
remote&#39;s key, so probing is declined<br>when another remote is keyed di=
fferently=2E The key material loaded for<br>the probe is released afterward=
s; init loads it again for the<br>connection=2E<br><br>Change-Id: I1f9d7b5a=
5ec19bf77c0c212795f583c5ba4c03ac<br>Signed-off-by: Lev Stipakov &lt;lev@ope=
nvpn=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M src/o=
penvpn/oob_client=2Ec<br>2 files changed, 176 insertions(+), 41 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/50/1750/20</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-=
options=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index=
 766e3bc=2E=2E8b6bb2f 100644</span><br><span>--- a/doc/man-sections/client-=
options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst</=
span><br><span>@@ -617,19 +617,21 @@</span><br><span>   server advertising =
:code:`0` asks to be considered only while it ties</span><br><span>   the f=
astest of its priority group, without constraining the others=2E</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The probe is=
 currently sent without control-channel wrapping, so it only</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  works against a server configured =
without ``--tls-auth``,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  ``--tls-crypt`` or ``--tls-crypt-v2``=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  The probe carries the same control-channel wrapp=
ing as a normal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  co=
nnection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-crypt-v2`` the =
remotes are left in their configured order,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  because the server cannot unwrap an out-of-band p=
robe yet=2E</span><br><span> </span><br><span>   Only UDP remotes are probe=
d, and only when there are at least two</span><br><span>   remotes; remotes=
 reached through a SOCKS proxy are not probed=2E All</span><br><span>   pro=
bed remotes must share the local bind settings (``--local``,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  ``--lport``, ``--bind``) of the fi=
rst one among them, since a single</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  socket per address family carries the probes; otherwise prob=
ing is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  skipped and t=
he configured order is used=2E Remotes that answered are tried first, in th=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  order described ab=
ove; all other remotes, including TCP ones, follow in</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  their configured order=2E Probing runs on=
ce, before the first connection</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  attempt; a restart does not probe again=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ``--lport``, ``--bind``) and the contr=
ol-channel key of the first one</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  among them, since a single socket per address family carries =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  probes; otherw=
ise probing is skipped and the configured order is used=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Remotes that answered are tried fi=
rst, in the order described above;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  all other remotes, including TCP ones, follow in their con=
figured</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  order=2E P=
robing runs once, before the first connection attempt; a</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  restart does not probe again=2E</spa=
n><br><span> </span><br><span>   Probing delays the first connection attemp=
t by up to one second, plus</span><br><span>   the time needed to resolve e=
ach remote=2E A server only answers a probe</span><br><span>diff --git a/sr=
c/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index=
 61e2602=2E=2Ec3e2e2b 100644</span><br><span>--- a/src/openvpn/oob_client=
=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -2=
9,6 +29,8 @@</span><br><span> #include &quot;oob_client=2Eh&quot;</span><br=
><span> #include &quot;openvpn=2Eh&quot;</span><br><span> #include &quot;oo=
b=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;init=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;ssl=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&=
quot;</span><br><span> #include &quot;session_id=2Eh&quot;</span><br><span>=
 #include &quot;socket=2Eh&quot;</span><br><span>@@ -79,21 +81,78 @@</span>=
<br><span>     return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/* Build a plaintext SERVER_PROBE packet:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *   [opcode | key_id=3D0] [client session =
id] [SERVER_PROBE message]</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * This is the unauthenticated OOB wire format; adding tls-auth/tls-cr=
ypt</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * wrapping for th=
e probe is a follow-up (it only works against a server with</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * no control-channel wrapping for no=
w)=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-oob_probe_build_packet(=
struct buffer *buf, const struct session_id *client_sid)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static bool oob_probe_eligible(const s=
truct connection_entry *ce);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Build a=
 standalone control-channel wrapping context for the probe, mirroring</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the tls_auth_standalon=
e the server uses to answer it=2E With neither tls-auth</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * nor tls-crypt configured the context=
 stays in TLS_WRAP_NONE and the probe is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * sent in plaintext, exactly as before; with either c=
onfigured the probe is</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * authenticated/encrypted like any other control packet=2E Returns NULL=
 (and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * logs) for c=
onfigurations the probe cannot wrap yet, in which case the caller</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * skips probing and keeps th=
e configured remote order=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static struct tls_auth_standalone *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+oob_probe_init_tls_auth_standalone(struct conte=
xt *c, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const struct oob_probe_parameter param =3D {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =2Etimestamp =
=3D (uint64_t)now,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     =2Eflags =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t head=
er =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return buf_write_u8(buf, header) =
&amp;&amp; session_id_write(client_sid, buf)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-           &amp;&amp; oob_server_probe_write(buf, &a=
mp;param);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Wr=
ap with the first entry we can actually probe: that is the entry every</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * other probed remo=
te is checked against, so the key on the wire is the one</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * they were checked for=2E Falls =
back to entry 0 when nothing is probeable,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * in which case the caller bails out before any=
thing is sent=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const struct connection_list *l =3D c-&gt;options=2Econnection_list;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct conne=
ction_entry *ce =3D l-&gt;array[0];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (oob_probe_eligible(l-&gt;array[i]))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            ce =3D l-&gt;array=
[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bre=
ak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* tls-crypt-v2 wraps with a per-client key the server =
only learns from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * wrapped client key (WKc) carried in the TLS handshake=2E An out-of-=
band</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * probe ca=
rries no WKc, so the server cannot unwrap it; skip probing rather</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * than send something un=
verifiable=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (ce-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(D_LOW, &quot;server-probe: not supported with tls-crypt-v2; using =
configured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Load the tls-auth/tl=
s-crypt key material into c-&gt;c1=2Eks (a no-op if neither</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * is configured)=2E This is ru=
n again per-connection later; calling it early</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * here is harmless=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    do_init_tls_wrap_key(c, ce);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct tls_options to;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    CLEAR(to);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap,=
 ce, c-&gt;options=2Etls_client, &amp;c-&gt;c1=2Eks, &amp;c-&gt;c1=2Epid_pe=
rsist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Erep=
lay_window =3D c-&gt;options=2Ereplay_window;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    to=2Ereplay_time =3D c-&gt;options=2Ereplay_t=
ime;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone *ta=
s =3D tls_auth_standalone_init(&amp;to, gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Control-channel frame and work buffers, mirroring do_init_fram=
e_tls()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tl=
s_init_control_channel_frame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;tls_wr=
ap=2Ework =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;workbuf =3D alloc_buf=
_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return tas;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
 style=3D"color: hsl(120, 100%, 40%);">+    /* the raw key bytes too: do_in=
it_crypto_tls_c1() may never load a key over</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * them, so they would otherwise stay resident=
 for the process lifetime */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    secure_memzero(&amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata, siz=
eof(c-&gt;c1=2Eks=2Eoriginal_wrap_keydata));</span><br><span> }</span><br><=
span> </span><br><span> /* The local address and port ce&#39;s connection s=
ocket binds: its first --local,</span><br><span>@@ -156,6 +215,21 @@</span>=
<br><span>            &amp;&amp; str_equal_or_both_null(port_a, port_b);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Do a and b wrap the control channel with the same key (--=
tls-auth,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls-c=
rypt, --tls-crypt-v2 and key direction)? The one probe is wrapped</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * with entry 0&#39;s key, so=
 a server keyed differently could never answer it=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+oob_probe_same_wrap(const struct connection_ent=
ry *a, const struct connection_entry *b)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return str_equal_or_both_null(a-&gt;tls_auth_file, b-&gt;tls_auth_fi=
le)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;=
&amp; a-&gt;tls_auth_file_inline =3D=3D b-&gt;tls_auth_file_inline</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt;=
key_direction =3D=3D b-&gt;key_direction</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+           &amp;&amp; str_equal_or_both_null(a-&gt;tls=
_crypt_file, b-&gt;tls_crypt_file)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+           &amp;&amp; a-&gt;tls_crypt_file_inline =3D=3D b-&=
gt;tls_crypt_file_inline</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+           &amp;&amp; str_equal_or_both_null(a-&gt;tls_crypt_v2_file, =
b-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+           &amp;&amp; a-&gt;tls_crypt_v2_file_inline =3D=3D b-&gt;tls_=
crypt_v2_file_inline;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> /* Resolve the local bind address of ce&#39;s connection socket; NULL wit=
h --nobind=2E</span><br><span>  * Fatal on failure, like the link socket=2E=
 */</span><br><span> static struct addrinfo *</span><br><span>@@ -250,9 +32=
4,9 @@</span><br><span> /* Parse one received datagram as a PROBE_REPLY and=
, if valid and matching one</span><br><span>  * of the probes we sent, reco=
rd the reply in results=2E */</span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-oob_probe_handle_reply(const uint8_t *=
data, int len, const struct session_id *client_sid,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       const struct openvpn=
_sockaddr *from, const struct oob_probe_target *targets,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                       struct oob_probe_=
result *results, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+oob_probe_handle_reply(uint8_t *data, int len, const struct session_id =
*client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                const struct tls_wrap_ctx *base_wrap, const struct openvpn_=
sockaddr *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                   const struct oob_probe_target *targets, struct oob_probe=
_result *results, int n)</span><br><span> {</span><br><span>     /* Need at=
 least the opcode byte and the session id=2E */</span><br><span>     if (le=
n &lt; 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTRO=
L_OOB_V1)</span><br><span>@@ -262,7 +336,20 @@</span><br><span> </span><br>=
<span>     struct buffer buf;</span><br><span>     buf_set_read(&amp;buf, d=
ata, (size_t)len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 buf_advance(&amp;buf, 1 + SID_SIZE); /* skip opcode + server session id */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Unwrap the reply with the same =
control-channel path the server used to</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * wrap it: this verifies the tls-auth HMAC / decry=
pts tls-crypt, and (in all</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * modes) strips the opcode + server session id, leaving buf at =
the TLV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * paylo=
ad=2E With no tls-auth/tls-crypt it just strips those header bytes, as</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * before=2E read_co=
ntrol_auth() mutates the wrapping context, so we work on a</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * per-packet copy (as tls_pre_d=
ecrypt_lite() does on the server)=2E The peer</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * address is only used for log messages, and=
 tls_options only for</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * tls-crypt-v2 metadata checks, so both are passed as NULL=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_wrap_ctx=
 wrap =3D *base_wrap;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!read_control_auth(&amp;buf, &amp;wrap, NULL, NULL))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return; /* not for us, or failed authe=
ntication */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span> </span><br><span>     struct oob_probe_reply reply;</span><=
br><span>     if (!oob_client_reply_read(&amp;buf, &amp;reply))</span><br><=
span>@@ -314,8 +401,9 @@</span><br><span>  * matches a probe we sent=2E Ret=
urns true if every sent probe has been answered=2E */</span><br><span> stat=
ic bool</span><br><span> oob_probe_receive_slice(const struct probe_ctx *pc=
, const struct timeval *deadline,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        const struct session_id *client_sid, co=
nst struct oob_probe_target *targets,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        struct oob_probe_result *results, i=
nt n, int outstanding)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        const struct session_id *client_sid, const struc=
t tls_wrap_ctx *wrap,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        const struct oob_probe_target *targets, struct oo=
b_probe_result *results, int n,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        int outstanding)</span><br><span> {</sp=
an><br><span>     while (true)</span><br><span>     {</span><br><span>@@ -3=
65,7 +453,7 @@</span><br><span>                                     (struct=
 sockaddr *)&amp;from, &amp;fromlen);</span><br><span>             if (len =
&gt; 0)</span><br><span>             {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                oob_probe_handle_reply(data, len, client_s=
id, &amp;from, targets, results, n);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                oob_probe_handle_reply(data, len, client_s=
id, wrap, &amp;from, targets, results, n);</span><br><span>             }</=
span><br><span>         }</span><br><span>         if (oob_count_answered(t=
argets, results, n) &gt;=3D outstanding)</span><br><span>@@ -418,8 +506,8 @=
@</span><br><span>  * once the window elapses or every sent probe has been =
answered=2E */</span><br><span> static void</span><br><span> oob_probe_coll=
ect(struct probe_ctx *pc, const struct buffer *probe,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                  const struct session_id *=
client_sid, struct oob_probe_target *targets,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                  struct oob_probe_result *results,=
 int n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
      const struct session_id *client_sid, const struct tls_wrap_ctx *wrap,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  s=
truct oob_probe_target *targets, struct oob_probe_result *results, int n,</=
span><br><span>                   const struct signal_info *sig)</span><br>=
<span> {</span><br><span>     /* number of probes we actually sent: stop ea=
rly once they all answer */</span><br><span>@@ -444,7 +532,7 @@</span><br><=
span>             deadline=2Etv_usec -=3D 1000000;</span><br><span>        =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, targets, =
results, n, want)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, wrap, targ=
ets, results, n, want)</span><br><span>             || sig-&gt;signal_recei=
ved)</span><br><span>         {</span><br><span>             return; /* all=
 answered, or we are being told to stop */</span><br><span>@@ -487,6 +575,1=
6 @@</span><br><span> </span><br><span>     struct gc_arena gc =3D gc_new()=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Wrapping context for the probe (tls-auth/tls-crypt, or plaintext if<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * neither)=2E N=
ULL means this configuration cannot be probed; keep the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * configured order=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalon=
e *tas =3D oob_probe_init_tls_auth_standalone(c, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!tas)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     /* A single random session id identifies all =
of our probes; servers echo it</span><br><span>      * back in the reply&#3=
9;s peer_session_id, letting us reject spoofed replies=2E */</span><br><spa=
n>     struct session_id client_sid;</span><br><span>@@ -508,11 +606,21 @@<=
/span><br><span>             tmpl =3D ce;</span><br><span>             cont=
inue;</span><br><span>         }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const char *differs =3D NULL;</span><br><span>        =
 if (!oob_probe_same_bind(tmpl, ce, &amp;c-&gt;options))</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(D_LOW, &quot;server-probe: %s:%s binds differently from %s:%s;&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            differs =3D=
 &quot;binds&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se if (!oob_probe_same_wrap(tmpl, ce))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            differs =3D &quot;wraps the control channel&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (differs)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe=
: %s:%s %s differently from %s:%s;&quot;</span><br><span>                  =
      &quot; not probing, using configured order&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                ce-&gt;remote, ce-&gt;rem=
ote_port, tmpl-&gt;remote, tmpl-&gt;remote_port);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                ce-&gt;remote, ce-&gt;remote_=
port, differs, tmpl-&gt;remote, tmpl-&gt;remote_port);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            oob_probe_free_wrap(c, tas);=
</span><br><span>             gc_free(&amp;gc);</span><br><span>           =
  return;</span><br><span>         }</span><br><span>@@ -520,6 +628,7 @@</s=
pan><br><span>     if (!tmpl)</span><br><span>     {</span><br><span>      =
   msg(D_LOW, &quot;server-probe: no remote can be probed; using configured=
 order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   oob_probe_free_wrap(c, tas);</span><br><span>         gc_free(&amp;gc);<=
/span><br><span>         return;</span><br><span>     }</span><br><span>@@ =
-528,17 +637,39 @@</span><br><span>     struct oob_probe_target *targets =
=3D gc_malloc(sizeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span=
>     struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&=
gt;len, true, &amp;gc);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct buffer probe =3D alloc_buf_gc(256, &amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!oob_probe_bu=
ild_packet(&amp;probe, &amp;client_sid))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Build the probe once and reuse the same bytes f=
or every remote and for</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * resends: the SERVER_PROBE payload is a single probe_parameter TL=
V, wrapped</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (o=
r sent in plaintext) like any other control packet=2E The client session</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * id is prepended=
 as the sender session id=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer payload =3D alloc_buf_gc(64, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe=
_parameter param =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        =2Etimestamp =3D (uint64_t)now,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!oob_server_probe_write(&amp;payload, &amp;param))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(D_LOW, &quot;server-probe: could not build probe packet; using c=
onfigured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(D_LOW, &quot;server-probe: could not build probe payload; u=
sing configured order&quot;);</span><br><span>         oob_probe_sockets_cl=
ose(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  oob_probe_free_wrap(c, tas);</span><br><span>         gc_free(&amp;gc);</=
span><br><span>         return;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;ser=
ver-probe: probing %d remote(s) with a %d ms window&quot;, l-&gt;len,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        OOB_PROBE_WINDOW_MS=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 probe =3D tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_=
sid, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!BLEN(&amp;probe))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(D_LOW, &quot;server-probe: could not wrap probe packet; using configur=
ed order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     oob_probe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        oob_probe_free_wrap(c, tas);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP=
_CRYPT)  ? &quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            : (tas-&gt;tls_wrap=2Emode =3D=3D =
TLS_WRAP_AUTH) ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                                         =
           : &quot;none (plaintext)&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remote=
(s) with a %d ms window, control-channel wrapping: %s&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDO=
W_MS, wrap_name);</span><br><span> </span><br><span>     /* Resolve every r=
emote first, so only the address families actually in use</span><br><span> =
     * get a probe socket=2E */</span><br><span>@@ -585,6 +716,7 @@</span><=
br><span>         {</span><br><span>             freeaddrinfo(bind_local);<=
/span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        oob_probe_free_wrap(c, tas);</span><br><span>         gc_fre=
e(&amp;gc);</span><br><span>         return;</span><br><span>     }</span><=
br><span>@@ -646,7 +778,7 @@</span><br><span> </span><br><span>     if (sen=
t_count &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        oob_probe_collect(&amp;pc, &amp;probe, &amp;client=
_sid, targets, results, l-&gt;len,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        oob_probe_collect(&amp;pc, &amp;probe, &amp;client_s=
id, &amp;tas-&gt;tls_wrap, targets, results, l-&gt;len,</span><br><span>   =
                        c-&gt;sig);</span><br><span>     }</span><br><span>=
     oob_probe_sockets_close(&amp;pc);</span><br><span>@@ -694,5 +826,6 @@<=
/span><br><span>     msg(M_INFO, &quot;server-probe: %d of %d probed remote=
(s) answered; connecting best-first&quot;,</span><br><span>         respond=
ed, sent_count);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    oob_probe_free_wrap(c, tas);</span><br><span>     gc_fre=
e(&amp;gc);</span><br><span> }</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demai=
l">change 1750</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
50?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1750 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: s=
tipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--r233bwS/ZQ8=--


--===============9177283630962212218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9177283630962212218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9177283630962212218==--

