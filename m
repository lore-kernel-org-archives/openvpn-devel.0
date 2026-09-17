Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7FAC982D0
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/FUIZi7V6UnKWeez5R8dQNhGq8jSlp94OoCCIIc8u3A=; b=mndrtTNJLqynEwljesM8zRoi4H
	Sq3W8j/8hzwcIR2DchEtxP4fgMJkNuVsyo7YjU7CgZwjtBXrNNkckFKVvMEbKtbmGzFUn92ZwhPAW
	9E4Lha42U3Ta2H9f3SIKOQ9cGuPTxkT060TDROfqMETt1vHVnYr7/g3Gir1I1thHlwFM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x767l-0004zb-G5;
	Thu, 17 Sep 2026 07:01:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x767i-0004zS-Sh
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mrpZrIifL1EQq2dJK2RbdN3h9+hkcIfug6ZNo8uXmJQ=; b=hAOoI7KRYqBFa65vxPltn39tnn
 x06LfDtXVBmFC0IF3QMtMfDrUSDg+kYVx2MRibxJkmD+aBHVrqtK19KAgFS7YEeFh0UfaeVfaWilM
 MD50gF+WRn+Ag8DSgVnsTBcrXaYKbeJJJyoMfu/AObBoqLSSn5lYYVYpqTpCc38jc8mo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mrpZrIifL1EQq2dJK2RbdN3h9+hkcIfug6ZNo8uXmJQ=; b=Y
 YdsmE05T2lUaYylGdZNtfIYG8udJShIQhEMns4jlXX+UEQjFsgdLONl+9B50gQ+p6Z4LHCOseZFHO
 W8VW5kJNWpWCbDX+nOAsBHY1JdiEPdwjg4OY6TQV5GvlcD+msJvFEmfV+GKKVaWO43TkTpVSHnBph
 WX816cq7tfZ0HfIc=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x767f-0006nF-7T for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:34 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so2444185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628485; x=1790233285; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mrpZrIifL1EQq2dJK2RbdN3h9+hkcIfug6ZNo8uXmJQ=;
 b=FPn/xhloH4ch+1yQjiBH4HfMGmGDIdEyVDTz35ralGsNWgN3efTjhxVJpCmC26Pa+i
 j2iajLagEaqGK2R/xl7PwTLSMKSTs5uTgkbFLzcZUL16BeM4SAgyITdHJitHR66oteJj
 a46R5peZ8sSVMswzATEqx241zol+txad1iElOVYTvJbB2HKCkdXWwv+wZljlbXl83NGw
 AhSuMR1hppnxwObeA1VlpXTdXBi2I7vW2jXeNYxiOPRMVpQok4Kf9P9u44QgsAOEJAdD
 NjOI+EA3jmccvtJh/+jLJ4aVGJqtwRXozDvSxQn42q2vXDiwhFCY+ZnL9mDG5mhHKGd5
 X6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628485; x=1790233285;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mrpZrIifL1EQq2dJK2RbdN3h9+hkcIfug6ZNo8uXmJQ=;
 b=jLbLNhsOcBoSHde2A1H/FbEUYZ1Cy2XAYB9ZjDTGSemSaMgFXN4Gzx0x4uOsc/3uFS
 mB9sU89coifl8yIHAv9hohBROFmxb9EuVj+3641f6G9UoCgOoTqPvHSipTYVAOsb5ZaZ
 Beo0a3aX759wN81pnyril/S69bAzDv4/3rjfmY28rWIGj87L1en3mOn+HU+5nI4ozkvL
 R72QKHwZApRigLuOTYeCkRTO21c8tvWi3ly5n9gXp4EMpuysvAs15R4CCK2MoroJGC/v
 ihVhqYMjIgZEB9iWnorD1sXbynDcb4P9fci9Nibk5bbSdzlMy38MZOzT/DydEhLALU+x
 Fszg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYbjZFWANdVUggMwOLRxNHH8J8oHkAwfHWy057fRGQpqVHnPVPk+1KAFkWeq3NV6i7FOovpHVfd1Ie27Qx@lists.sourceforge.net
X-Gm-Message-State: AFuF++m549vGw+3+Ojm6D72SNnHQW7WKEbnqHXgzOKOw8IZ2izKvIJZA
 hCS8Z7DsGe1XWJF1XF5QQ8TJelZE2QpqeQkl2aO5+qmlIjiyuBdRY6zAbaZytO0e0WNjPYO78VV
 eXH3l5FFfmXZZ1RuQ5ZnmkephQyX7+6OJDchmyUQKaK+2mGJKozKdMUCqTnebovvTC3Fd
X-Gm-Gg: AYBFou2G83z7592vBKsg5Tut2UxbuJii5J6alsyE1pArL/Iw7kpVXnAKnNvmN2PN1Fw
 Y9Bcf6KY9frqPNz9YbIndXX5npvV7WxAxXo7aj+xJIa1Df5EuH1oSeKs40HOCf06aI3s4PBProT
 OC8LE0ixUm1V34uvisJdTyoQrV13wRZTS/9kPLQka/q/8Ww1sdhQ9xuS4jhB7jl6wdwt/i0bJbP
 q6HP6meEpiFHxln+vVLc3I85IyjYKSSipA/HYTpizeRT6R/l0ajQk/g+UZGgp02KvW4q7SpE010
 5FUYpOoOTkEwDsrc+Bs1kKZ1gslLVAcRPlv1FwNB/rcLO3djmruDFAFPdapI/qL61i5ItQmdUMC
 Ct1J206lOmyZJOyJKME28DV7NTefvNzojWnxdKi3tAlJ7KUffkqlyfQVMTmIUsjjmS/tuYZzMvA
 deRV9yBNFJ6zHfLtk766qAXiIbhZRUeq+uKjAI7aCIh88k7hl7SHwBCV7qvvy+lyCEIuJWNbQak
 VFzlILru3X12Jgi8IYzzufNGrSq05Y40oTRsu+WDibA+iQ/jp4K1463BGnOgfcNvpbjnFGFv/Rg
 r22Q1NCpNARXXqCHKchVxtLxQYJ/vb6M19/26IISCDX13prtSo2WuH7o9ki1YA==
X-Received: by 2002:a05:600c:3b01:b0:49c:fc89:59cb with SMTP id
 5b1f17b1804b1-49eac46390amr63161805e9.5.1789628484040; 
 Thu, 17 Sep 2026 00:01:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd226ef3sm50230055e9.1.2026.09.17.00.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:23 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 010736ef7f721f4841eb67570de51563739399a5
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b326e07bd93a61b8082f087a83e52214d977be36-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x767f-0006nF-7T
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
Content-Type: multipart/mixed; boundary="===============2976997628260969760=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2976997628260969760==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bT88NlRh16A="; charset=UTF-8

--bT88NlRh16A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello plaisthos, ralf_lici, 

I'd like you to reexamine a change=
=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3D=
email

to look at the new patch set (#16)=2E


Change subject: oob: Answer =
SERVER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Answer SERVER_PROBE on the server (=
P_CONTROL_OOB_V1)

Make a --mode server UDP listener answer an out-of-band =
SERVER_PROBE without
creating a session, so probing costs the server no sta=
te:

  - tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns the ne=
w
    VERDICT_VALID_OOB_V1 verdict=2E
  - tls_wrap_oob_standalone() builds =
a session-less P_CONTROL_OOB_V1 packet:
    opcode + session id + the usual=
 tls-auth/tls-crypt wrapping around a bare
    TLV payload (no reliability/=
ACK fields), mirroring tls_reset_standalone()=2E
  - oob_client_reply_write=
() writes the PROBE_REPLY message (message-type
    header + probe_reply TL=
V)=2E
  - do_pre_decrypt_check() handles the new verdict: it asks
    oob_s=
erver_probe_accept() whether to answer, and if so builds the
    PROBE_REPL=
Y, echoing the peer's session id, and sends it via
    send_probe_reply() (=
synchronous, stateless, like the HMAC reset path)
    and returns false so =
no session is created=2E The verdict joins the reset
    verdicts in the re=
flect_filter rate-limit check, so a probe flood is capped
    like a reset =
flood=2E

The reply carries, as its own session id, the stateless SYN-cooki=
e the three-way
handshake uses, so the server keeps nothing per probe and a=
 client can later
reuse the reply as the server's reset=2E

Change-Id: I930=
d3789e0313aa0c3bc51ee5fd1d108343d59f0
Signed-off-by: Lev Stipakov <lev@open=
vpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn=
/multi=2Eh
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/reflec=
t_filter=2Ec
M src/openvpn/reflect_filter=2Eh
M src/openvpn/ssl_pkt=2Ec
M s=
rc/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
10 files cha=
nged, 247 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/44/1744/16

diff --git a/src/openvpn/mudp=
=2Ec b/src/openvpn/mudp=2Ec
index de3d467=2E=2Ed592d40 100644
--- a/src/ope=
nvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "mem=
dbg=2Eh"
 #include "ssl_pkt=2Eh"
+#include "oob=2Eh"
 
 #ifdef HAVE_SYS_INO=
TIFY_H
 #include <sys/inotify=2Eh>
@@ -87,6 +88,34 @@
                     =
      "Reset packet from client, sending HMAC based reset challenge", sock)=
;
 }
 
+/* Send an out-of-band PROBE_REPLY back to the source of a SERVER_P=
ROBE,
+ * synchronously and without keeping any state, mirroring the reset =
path=2E */
+static void
+send_probe_reply(struct multi_context *m, struct t=
ls_pre_decrypt_state *state,
+                 struct tls_auth_standalone *=
tas, const struct oob_probe_reply *reply,
+                 struct session_=
id *own_sid, struct link_socket *sock)
+{
+    struct gc_arena gc =3D gc_ne=
w();
+
+    /* Build the payload of the reply (message-type header + probe_=
reply TLV) */
+    struct buffer payload =3D alloc_buf_gc(128, &gc);
+    i=
f (!oob_client_reply_write(&payload, reply))
+    {
+        gc_free(&gc);
=
+        return;
+    }
+
+    /* OOB replies use the same control-channel =
wrapping as the request */
+    reset_packet_id_send(&state->tls_wrap_tmp=
=2Eopt=2Epacket_id=2Esend);
+    state->tls_wrap_tmp=2Eopt=2Epacket_id=2Ere=
c=2Einitialized =3D true;
+
+    struct buffer buf =3D tls_wrap_oob_standal=
one(&state->tls_wrap_tmp, tas, own_sid, &payload);
+    send_standalone_rep=
ly(m, &buf, "Server Probe", "Server probe from client, sending probe reply"=
,
+                          sock);
+
+    gc_free(&gc);
+}
+
 
 /* Returns=
 true if this packet should create a new session */
 static bool
@@ -105,7 =
+134,8 @@
     const struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=
=2Edest;
     int handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
-  =
  if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID=
_RESET_V2)
+    if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D=
 VERDICT_VALID_RESET_V2
+        || verdict =3D=3D VERDICT_VALID_OOB_V1)
  =
   {
         /* Check if we are still below our limit for sending out
    =
      * responses */
@@ -203,6 +233,40 @@
 
         return ret;
     }
+  =
  else if (verdict =3D=3D VERDICT_VALID_OOB_V1)
+    {
+        /* Out-of-b=
and server probe=2E state->newbuf points at the TLV payload
+         * (re=
ad_control_auth has stripped the opcode, session id and any
+         * tls=
-auth/tls-crypt wrapping)=2E Answer it without creating a session=2E */
+  =
      enum oob_probe_verdict probe =3D
+            oob_server_probe_check(=
&state->newbuf, (uint64_t)now, (uint64_t)handwindow);
+        if (probe =
=3D=3D OOB_PROBE_INVALID)
+        {
+            return false; /* malforme=
d: silently drop */
+        }
+        /* A client whose clock is off by m=
ore than --hand-window still gets a
+         * few probes per period answe=
red, which is also all a replayed probe
+         * can get=2E */
+        =
if (probe =3D=3D OOB_PROBE_STALE && !reflect_filter_rate_limit_check(m->sta=
le_probe_limiter))
+        {
+            return false;
+        }
+
+    =
    /* the reply echoes the peer's session id */
+        struct oob_probe_=
reply reply =3D { =2Epeer_session_id =3D state->peer_session_id };
+
+     =
   /* Our session id is a stateless SYN cookie (the same HMAC the three-way=

+         * handshake uses): we keep no per-probe state, and the reply can=
 later
+         * also serve as the server's CONTROL_HARD_RESET_SERVER_V2,=
 so a client
+         * can start the handshake from it (the connect_lifet=
ime advertisement)=2E */
+        struct session_id sid =3D
+            ca=
lculate_session_id_hmac(state->peer_session_id, from, hmac_key, handwindow,=
 0);
+
+        send_probe_reply(m, state, tas, &reply, &sid, sock);
+
+   =
     /* An OOB probe never creates a session */
+        return false;
+   =
 }
 
     /* VERDICT_INVALID */
     return false;
diff --git a/src/openvpn=
/multi=2Ec b/src/openvpn/multi=2Ec
index 3e72b92=2E=2Ea438a34 100644
--- a/=
src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -326,6 +326,12 @@
    =
 m->new_connection_limiter =3D frequency_limit_init(t->options=2Ecf_max, t-=
>options=2Ecf_per);
     m->initial_rate_limiter =3D
         initial_rate_=
limit_init(t->options=2Ecf_initial_max, t->options=2Ecf_initial_per);
+    =
/* stale server probes: a twentieth of the initial-packet rate, at least 1
=
+     * per period (5 per 10 s by default, the wire protocol's own example)=
=2E
+     * Quiet, as a replayed probe hitting the limit is not worth a war=
ning=2E */
+    m->stale_probe_limiter =3D
+        initial_rate_limit_init=
(max_int(1, t->options=2Ecf_initial_max / 20), t->options=2Ecf_initial_per)=
;
+    m->stale_probe_limiter->quiet =3D true;
 
     /*
      * Allocate b=
roadcast/multicast buffer list
@@ -689,6 +695,7 @@
         ifconfig_pool_f=
ree(m->ifconfig_pool);
         frequency_limit_free(m->new_connection_limi=
ter);
         initial_rate_limit_free(m->initial_rate_limiter);
+        i=
nitial_rate_limit_free(m->stale_probe_limiter);
         multi_reap_free(m-=
>reaper);
         mroute_helper_free(m->route_helper);
         multi_io_f=
ree(m->multi_io);
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2E=
h
index 6cb86c7=2E=2Ed33bf85 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/o=
penvpn/multi=2Eh
@@ -178,6 +178,7 @@
     struct ifconfig_pool *ifconfig_po=
ol;
     struct frequency_limit *new_connection_limiter;
     struct initia=
l_packet_rate_limit *initial_rate_limiter;
+    struct initial_packet_rate_=
limit *stale_probe_limiter; /**< stale --server-probe answers */
     struc=
t mroute_helper *route_helper;
     struct multi_reap *reaper;
     struct =
mroute_addr local;
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
i=
ndex 655c791=2E=2Ec3e4bc9 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvp=
n/oob=2Ec
@@ -106,6 +106,12 @@
 }
 
 bool
+oob_client_reply_write(struct bu=
ffer *buf, const struct oob_probe_reply *reply)
+{
+    return buf_write_u1=
6(buf, OOB_MSG_PROBE_REPLY) && oob_probe_reply_write(buf, reply);
+}
+
+boo=
l
 oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window=
_secs)
 {
     uint64_t diff =3D (now > probe_ts) ? (now - probe_ts) : (pro=
be_ts - now);
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index =
6d83eca=2E=2Ed8eca60 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=
=2Eh
@@ -127,6 +127,12 @@
 bool oob_server_probe_read(struct buffer *payloa=
d, struct oob_probe_parameter *param);
 
 /**
+ * Write a complete PROBE_RE=
PLY message (message-type header + probe_reply TLV)
+ * to buf=2E Sent by t=
he server=2E
+ */
+bool oob_client_reply_write(struct buffer *buf, const st=
ruct oob_probe_reply *reply);
+
+/**
  * Check whether a probe timestamp is=
 within an acceptable window around the
  * current time=2E Used to cheaply=
 drop replayed or implausibly-timed probes
  * before doing any further wor=
k (see the probe_parameter timestamp rationale
diff --git a/src/openvpn/ref=
lect_filter=2Ec b/src/openvpn/reflect_filter=2Ec
index e5226e4=2E=2Eb50f72e=
 100644
--- a/src/openvpn/reflect_filter=2Ec
+++ b/src/openvpn/reflect_filt=
er=2Ec
@@ -44,7 +44,7 @@
     if (now > irl->last_period_reset + irl->perio=
d_length)
     {
         int64_t dropped =3D irl->curr_period_counter - ir=
l->max_per_period;
-        if (dropped > 0)
+        if (dropped > 0 && !i=
rl->quiet)
         {
             msg(D_TLS_DEBUG_LOW,
                 "D=
ropped %" PRId64 " initial handshake packets"
@@ -60,7 +60,7 @@
 
     bool=
 over_limit =3D irl->curr_period_counter > irl->max_per_period;
 
-    if (=
over_limit && !irl->warning_displayed)
+    if (over_limit && !irl->warning=
_displayed && !irl->quiet)
     {
         msg(M_WARN,
             "Note: =
--connect-freq-initial %" PRId64 " %d rate limit "
diff --git a/src/openvpn=
/reflect_filter=2Eh b/src/openvpn/reflect_filter=2Eh
index 84915e8c6=2E=2Ee=
996d07 100644
--- a/src/openvpn/reflect_filter=2Eh
+++ b/src/openvpn/reflec=
t_filter=2Eh
@@ -44,6 +44,9 @@
     /* we want to warn once per period that=
 packets are being started to
      * be dropped */
     bool warning_displ=
ayed;
+
+    /* drop silently: no per-period warning or summary in the log =
*/
+    bool quiet;
 };
 
 
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/open=
vpn/ssl_pkt=2Ec
index 4e6b98b=2E=2E8e78444 100644
--- a/src/openvpn/ssl_pkt=
=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -315,7 +315,8 @@
 
     /* Allow only=
 the reset packet or the first packet of the actual handshake=2E */
     if=
 (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 && op !=3D P_CONTROL_HARD_RESET_CL=
IENT_V3
-        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op =
!=3D P_ACK_V1)
+        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1=
 && op !=3D P_ACK_V1
+        && !opcode_is_oob(op))
     {
         /*
   =
       * This can occur due to bogus data or DoS packets=2E
@@ -390,6 +391,=
10 @@
     {
         return VERDICT_VALID_WKC_V1;
     }
+    else if (opc=
ode_is_oob(op))
+    {
+        return VERDICT_VALID_OOB_V1;
+    }
     el=
se
     {
         return VERDICT_VALID_RESET_V2;
@@ -444,6 +449,29 @@
    =
 return buf;
 }
 
+struct buffer
+tls_wrap_oob_standalone(struct tls_wrap_c=
tx *ctx, struct tls_auth_standalone *tas,
+                        struct s=
ession_id *own_sid, const struct buffer *payload)
+{
+    /* Copy buffer he=
re to point at the same data but allow tls_wrap_control
+     * to potentia=
lly change buf to point to another buffer without
+     * modifying the buf=
fer in tas */
+    struct buffer buf =3D tas->workbuf;
+    ASSERT(buf_init=
(&buf, tas->frame=2Ebuf=2Eheadroom));
+
+    /* Out-of-band messages carry =
the payload directly, with no reliability
+     * or ACK fields=2E */
+    =
ASSERT(buf_copy(&buf, payload));
+
+    uint8_t header =3D (uint8_t)(P_CONT=
ROL_OOB_V1 << P_OPCODE_SHIFT);
+
+    /* Add tls-auth/tls-crypt wrapping, t=
his might replace buf with
+     * ctx->work */
+    tls_wrap_control(ctx, =
header, &buf, own_sid);
+
+    return buf;
+}
+
 struct session_id
 calcula=
te_session_id_hmac(struct session_id client_sid, const struct openvpn_socka=
ddr *from,
                           const uint8_t *key, int handwindow, i=
nt offset)
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
i=
ndex d8d4b5e=2E=2Ea7dc6d9 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/op=
envpn/ssl_pkt=2Eh
@@ -106,6 +106,9 @@
     VERDICT_VALID_ACK_V1,
     /** T=
he packet is a valid control packet with appended wrapped client key */
   =
  VERDICT_VALID_WKC_V1,
+    /** This packet is a valid out-of-band control=
 message (e=2Eg=2E a server
+     * probe)=2E It does not belong to a sessi=
on and must not create one=2E */
+    VERDICT_VALID_OOB_V1,
     /** the pa=
cket failed on of the various checks */
     VERDICT_INVALID
 };
@@ -226,6 =
+229,21 @@
                                    struct session_id *own_sid, =
struct session_id *remote_sid,
                                    uint8_t =
header, bool request_resend_wkc);
 
+/**
+ * Wrap an already-built out-of-b=
and payload (e=2Eg=2E probe-reply TLVs) into a
+ * standalone, session-less=
 P_CONTROL_OOB_V1 packet: it prepends the opcode and
+ * own_sid and applie=
s the same tls-auth/tls-crypt wrapping as a regular
+ * control packet, but=
 carries no reliability/ACK fields=2E
+ *
+ * @param ctx       tls wrapping=
 context (from the pre-decrypt state)
+ * @param tas       standalone auth =
context providing the work buffer
+ * @param own_sid   session id to use as=
 our session id in the header
+ * @param payload   the OOB message payload =
(TLV stream) to wrap
+ * @return          the wrapped packet buffer, ready =
to send
+ */
+struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ct=
x, struct tls_auth_standalone *tas,
+                                      =
struct session_id *own_sid, const struct buffer *payload);
+
 
 /**
  * Ext=
racts a control channel message from buf and adjusts the size of
diff --git=
 a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pk=
t=2Ec
index a732c2b=2E=2Eca3045a 100644
--- a/tests/unit_tests/openvpn/test=
_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -695,6 +695,113 @@
=
     free_tas(&tas_server);
 }
 
+/* Payload every OOB round-trip below wra=
ps: a message header and one TLV=2E */
+static const uint8_t oob_payload[] =
=3D { 0x01, 0x00, 0x00, 0x01, 0x00, 0x04, 0xde, 0xad, 0xbe, 0xef };
+
+/* W=
rap oob_payload as a standalone P_CONTROL_OOB_V1 with the client side of a
=
+ * tls-auth/tls-crypt pair (or none), run it through the server's stateles=
s
+ * first-packet path, and check verdict, recovered session id and payloa=
d=2E */
+static void
+oob_standalone_roundtrip(struct tls_auth_standalone *=
tas_client,
+                         struct tls_auth_standalone *tas_serve=
r)
+{
+    struct link_socket_actual from =3D { 0 };
+    struct tls_pre_de=
crypt_state state =3D { 0 };
+    struct session_id sid =3D { { 0x0b, 1, 2,=
 3, 4, 5, 6, 0x0b } };
+
+    struct buffer payload =3D alloc_buf(64);
+   =
 buf_write(&payload, oob_payload, sizeof(oob_payload));
+
+    /* Client si=
de: opcode + session id + tls-auth/tls-crypt wrapping around the
+     * ba=
re payload, with none of the reliability/ACK fields a control packet
+     =
* carries=2E */
+    struct buffer buf =3D
+        tls_wrap_oob_standalone=
(&tas_client->tls_wrap, tas_client, &sid, &payload);
+    assert_int_equal(=
(BPTR(&buf))[0] >> P_OPCODE_SHIFT, P_CONTROL_OOB_V1);
+
+    /* Server side=
: the stateless first-packet path must recognise the opcode,
+     * verify=
 the wrapping and leave exactly the payload in newbuf -- that is
+     * wh=
at mudp=2Ec hands to the probe parser=2E */
+    enum first_packet_verdict =
verdict =3D tls_pre_decrypt_lite(tas_server, &state, &from, &buf);
+    ass=
ert_int_equal(verdict, VERDICT_VALID_OOB_V1);
+    assert_memory_equal(stat=
e=2Epeer_session_id=2Eid, sid=2Eid, SID_SIZE);
+    assert_int_equal(BLEN(&=
state=2Enewbuf), (int)sizeof(oob_payload));
+    assert_memory_equal(BPTR(&=
state=2Enewbuf), oob_payload, sizeof(oob_payload));
+    free_tls_pre_decry=
pt_state(&state);
+
+    /* Tampering with any single byte must fail authen=
tication: the flip runs
+     * over opcode, session id, packet id, HMAC/ta=
g and payload alike=2E Skipped
+     * for TLS_WRAP_NONE, where a changed p=
ayload is legitimately accepted=2E */
+    if (tas_server->tls_wrap=2Emode =
!=3D TLS_WRAP_NONE)
+    {
+        struct buffer copy =3D alloc_buf(BLEN(&=
buf));
+        for (int i =3D 0; i < BLEN(&buf); i++)
+        {
+        =
    buf_reset_len(&copy);
+            buf_write(&copy, BPTR(&buf), BLEN(&b=
uf));
+            (BPTR(&copy))[i] ^=3D 0xff;
+            struct tls_pre_=
decrypt_state tstate =3D { 0 };
+            verdict =3D tls_pre_decrypt_li=
te(tas_server, &tstate, &from, &copy);
+            assert_int_equal(verdic=
t, VERDICT_INVALID);
+            free_tls_pre_decrypt_state(&tstate);
+   =
     }
+        free_buf(&copy);
+    }
+
+    free_buf(&payload);
+}
+
+st=
atic void
+test_oob_standalone_plain(void **ut_state)
+{
+    struct tls_au=
th_standalone tas =3D { 0 };
+    struct frame frame =3D { =2Ebuf =3D { =2E=
headroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+    tas=2Eframe =3D fra=
me;
+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    tas=2Eworkbuf =3D al=
loc_buf(1600);
+
+    oob_standalone_roundtrip(&tas, &tas);
+
+    free_tas=
(&tas);
+}
+
+static void
+test_oob_standalone_tls_auth(void **ut_state)
+{=

+    struct tls_auth_standalone tas_server =3D init_tas_auth(KEY_DIRECTION=
_NORMAL);
+    struct tls_auth_standalone tas_client =3D init_tas_auth(KEY_=
DIRECTION_INVERSE);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epack=
et_id, 5, 5, "UNITTEST", 0);
+    /* the server consumes the tls-auth packe=
t id only with packet-id state,
+     * which tls_auth_standalone_init() se=
ts up for the real one */
+    packet_id_init(&tas_server=2Etls_wrap=2Eopt=
=2Epacket_id, 5, 5, "UNITTEST", 0);
+
+    now =3D 0x22446688;
+    oob_sta=
ndalone_roundtrip(&tas_client, &tas_server);
+
+    packet_id_free(&tas_cli=
ent=2Etls_wrap=2Eopt=2Epacket_id);
+    packet_id_free(&tas_server=2Etls_wr=
ap=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+    free_tas(&tas_serve=
r);
+}
+
+static void
+test_oob_standalone_tls_crypt(void **ut_state)
+{
+ =
   struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_si=
ze =3D 1400 }, 0 };
+    struct tls_auth_standalone tas_server =3D init_tas=
_crypt(true);
+    struct tls_auth_standalone tas_client =3D init_tas_crypt=
(false);
+    tas_server=2Eframe =3D frame;
+    tas_client=2Eframe =3D fra=
me;
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UN=
ITTEST", 0);
+
+    now =3D 0x22446688;
+    oob_standalone_roundtrip(&tas_=
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
@@ -745,6 +852=
,9 @@
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
  =
       cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_=
unit_test(test_generate_reset_packet_tls_auth),
+        cmocka_unit_test(t=
est_oob_standalone_plain),
+        cmocka_unit_test(test_oob_standalone_tl=
s_auth),
+        cmocka_unit_test(test_oob_standalone_tls_crypt),
        =
 cmocka_unit_test(test_extract_control_message)
     };
 

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d1083=
43d59f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 16
Gerrit-Owner: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attenti=
on: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gma=
il=2Ecom>

--bT88NlRh16A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #16</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">oob: Answer SERVER_PROBE on the server (P_CONTROL_O=
OB_V1)<br><br>Make a --mode server UDP listener answer an out-of-band SERVE=
R_PROBE without<br>creating a session, so probing costs the server no state=
:<br><br>  - tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns th=
e new<br>    VERDICT_VALID_OOB_V1 verdict=2E<br>  - tls_wrap_oob_standalone=
() builds a session-less P_CONTROL_OOB_V1 packet:<br>    opcode + session i=
d + the usual tls-auth/tls-crypt wrapping around a bare<br>    TLV payload =
(no reliability/ACK fields), mirroring tls_reset_standalone()=2E<br>  - oob=
_client_reply_write() writes the PROBE_REPLY message (message-type<br>    h=
eader + probe_reply TLV)=2E<br>  - do_pre_decrypt_check() handles the new v=
erdict: it asks<br>    oob_server_probe_accept() whether to answer, and if =
so builds the<br>    PROBE_REPLY, echoing the peer&#39;s session id, and se=
nds it via<br>    send_probe_reply() (synchronous, stateless, like the HMAC=
 reset path)<br>    and returns false so no session is created=2E The verdi=
ct joins the reset<br>    verdicts in the reflect_filter rate-limit check, =
so a probe flood is capped<br>    like a reset flood=2E<br><br>The reply ca=
rries, as its own session id, the stateless SYN-cookie the three-way<br>han=
dshake uses, so the server keeps nothing per probe and a client can later<b=
r>reuse the reply as the server&#39;s reset=2E<br><br>Change-Id: I930d3789e=
0313aa0c3bc51ee5fd1d108343d59f0<br>Signed-off-by: Lev Stipakov &lt;lev@open=
vpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<b=
r>M src/openvpn/multi=2Eh<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh=
<br>M src/openvpn/reflect_filter=2Ec<br>M src/openvpn/reflect_filter=2Eh<br=
>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tes=
ts/openvpn/test_pkt=2Ec<br>10 files changed, 247 insertions(+), 4 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/44/1744/16</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b=
/src/openvpn/mudp=2Ec</span><br><span>index de3d467=2E=2Ed592d40 100644</sp=
an><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/m=
udp=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span><br><span=
> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;oob=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOT=
IFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span>@@ =
-87,6 +88,34 @@</span><br><span>                           &quot;Reset pack=
et from client, sending HMAC based reset challenge&quot;, sock);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Send an out-of-band PROBE_REPLY back to the source of a SERVER_PR=
OBE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * synchronousl=
y and without keeping any state, mirroring the reset path=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+send_probe_reply(struct multi_context *=
m, struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 struct tls_auth_standalone *tas, const=
 struct oob_probe_reply *reply,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                 struct session_id *own_sid, struct link_socket=
 *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Build the payload of the =
reply (message-type header + probe_reply TLV) */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer payload =3D alloc_buf_gc(128=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!oob_client_reply_write(&amp;payload, reply))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OOB replies =
use the same control-channel wrapping as the request */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;state-&gt=
;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Ei=
nitialized =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D tls_wrap_oob_standalone(&amp;state-&gt;tls_wrap_tmp, tas, own_sid, =
&amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
end_standalone_reply(m, &amp;buf, &quot;Server Probe&quot;, &quot;Server pr=
obe from client, sending probe reply&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                          sock);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> </span><br><span> /* Returns true if this packet should=
 create a new session */</span><br><span> static bool</span><br><span>@@ -1=
05,7 +134,8 @@</span><br><span>     const struct openvpn_sockaddr *from =3D=
 &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     int handwindow =3D=
 m-&gt;top=2Eoptions=2Ehandshake_window;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (verdict =3D=3D VERDICT_VALID_R=
ESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (verdict =3D=3D VERDICT_VALID_RESET_V3=
 || verdict =3D=3D VERDICT_VALID_RESET_V2</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        || verdict =3D=3D VERDICT_VALID_OOB_V1)</span=
><br><span>     {</span><br><span>         /* Check if we are still below o=
ur limit for sending out</span><br><span>          * responses */</span><br=
><span>@@ -203,6 +233,40 @@</span><br><span> </span><br><span>         retu=
rn ret;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* Out-of-band server probe=2E state-&gt=
;newbuf points at the TLV payload</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * (read_control_auth has stripped the opcode, sessio=
n id and any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * tls-auth/tls-crypt wrapping)=2E Answer it without creating a session=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        enum oob=
_probe_verdict probe =3D</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            oob_server_probe_check(&amp;state-&gt;newbuf, (uint64_t)no=
w, (uint64_t)handwindow);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (probe =3D=3D OOB_PROBE_INVALID)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return false; /* malformed: silently drop *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* A client whose cl=
ock is off by more than --hand-window still gets a</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * few probes per period answered, w=
hich is also all a replayed probe</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * can get=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (probe =3D=3D OOB_PROBE_STALE &amp;&amp; !ref=
lect_filter_rate_limit_check(m-&gt;stale_probe_limiter))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* the reply echoes the peer&#39;s session id */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_reply re=
ply =3D { =2Epeer_session_id =3D state-&gt;peer_session_id };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* Our session id is a stateless SYN cookie =
(the same HMAC the three-way</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * handshake uses): we keep no per-probe state, and the re=
ply can later</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * also serve as the server&#39;s CONTROL_HARD_RESET_SERVER_V2, so a clie=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * can st=
art the handshake from it (the connect_lifetime advertisement)=2E */</span>=
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
=2Eh</span><br><span>index 6cb86c7=2E=2Ed33bf85 100644</span><br><span>--- =
a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><=
br><span>@@ -178,6 +178,7 @@</span><br><span>     struct ifconfig_pool *ifc=
onfig_pool;</span><br><span>     struct frequency_limit *new_connection_lim=
iter;</span><br><span>     struct initial_packet_rate_limit *initial_rate_l=
imiter;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct i=
nitial_packet_rate_limit *stale_probe_limiter; /**&lt; stale --server-probe=
 answers */</span><br><span>     struct mroute_helper *route_helper;</span>=
<br><span>     struct multi_reap *reaper;</span><br><span>     struct mrout=
e_addr local;</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvp=
n/oob=2Ec</span><br><span>index 655c791=2E=2Ec3e4bc9 100644</span><br><span=
>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span>=
<br><span>@@ -106,6 +106,12 @@</span><br><span> }</span><br><span> </span><=
br><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_c=
lient_reply_write(struct buffer *buf, const struct oob_probe_reply *reply)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, OOB_MSG_=
PROBE_REPLY) &amp;&amp; oob_probe_reply_write(buf, reply);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool</span><br><span> oob_timestamp_in_window(uint64_t probe_ts, uint64_t=
 now, uint64_t window_secs)</span><br><span> {</span><br><span>     uint64_=
t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now);</span=
><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br=
><span>index 6d83eca=2E=2Ed8eca60 100644</span><br><span>--- a/src/openvpn/=
oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -127,6=
 +127,12 @@</span><br><span> bool oob_server_probe_read(struct buffer *payl=
oad, struct oob_probe_parameter *param);</span><br><span> </span><br><span>=
 /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a comp=
lete PROBE_REPLY message (message-type header + probe_reply TLV)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * to buf=2E Sent by the serve=
r=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool oob_client_reply_write(str=
uct buffer *buf, const struct oob_probe_reply *reply);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span>  * Check whether a probe timestamp is =
within an acceptable window around the</span><br><span>  * current time=2E =
Used to cheaply drop replayed or implausibly-timed probes</span><br><span> =
 * before doing any further work (see the probe_parameter timestamp rationa=
le</span><br><span>diff --git a/src/openvpn/reflect_filter=2Ec b/src/openvp=
n/reflect_filter=2Ec</span><br><span>index e5226e4=2E=2Eb50f72e 100644</spa=
n><br><span>--- a/src/openvpn/reflect_filter=2Ec</span><br><span>+++ b/src/=
openvpn/reflect_filter=2Ec</span><br><span>@@ -44,7 +44,7 @@</span><br><spa=
n>     if (now &gt; irl-&gt;last_period_reset + irl-&gt;period_length)</spa=
n><br><span>     {</span><br><span>         int64_t dropped =3D irl-&gt;cur=
r_period_counter - irl-&gt;max_per_period;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (dropped &gt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (dropped &gt; 0 &amp;&amp; !irl-&gt=
;quiet)</span><br><span>         {</span><br><span>             msg(D_TLS_D=
EBUG_LOW,</span><br><span>                 &quot;Dropped %&quot; PRId64 &qu=
ot; initial handshake packets&quot;</span><br><span>@@ -60,7 +60,7 @@</span=
><br><span> </span><br><span>     bool over_limit =3D irl-&gt;curr_period_c=
ounter &gt; irl-&gt;max_per_period;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (over_limit &amp;&amp; !irl-&gt;warn=
ing_displayed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (over_limit &amp;&amp; !irl-&gt;warning_displayed &amp;&amp; !irl-&gt;qui=
et)</span><br><span>     {</span><br><span>         msg(M_WARN,</span><br><=
span>             &quot;Note: --connect-freq-initial %&quot; PRId64 &quot; =
%d rate limit &quot;</span><br><span>diff --git a/src/openvpn/reflect_filte=
r=2Eh b/src/openvpn/reflect_filter=2Eh</span><br><span>index 84915e8c6=2E=
=2Ee996d07 100644</span><br><span>--- a/src/openvpn/reflect_filter=2Eh</spa=
n><br><span>+++ b/src/openvpn/reflect_filter=2Eh</span><br><span>@@ -44,6 +=
44,9 @@</span><br><span>     /* we want to warn once per period that packet=
s are being started to</span><br><span>      * be dropped */</span><br><spa=
n>     bool warning_displayed;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* d=
rop silently: no per-period warning or summary in the log */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool quiet;</span><br><span> }=
;</span><br><span> </span><br><span> </span><br><span>diff --git a/src/open=
vpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 4e6b98b=2E=
=2E8e78444 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><=
span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -315,7 +315,8 @@</spa=
n><br><span> </span><br><span>     /* Allow only the reset packet or the fi=
rst packet of the actual handshake=2E */</span><br><span>     if (op !=3D P=
_CONTROL_HARD_RESET_CLIENT_V2 &amp;&amp; op !=3D P_CONTROL_HARD_RESET_CLIEN=
T_V3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp=
; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=
=3D P_ACK_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &amp;&amp; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;=
&amp; op !=3D P_ACK_V1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &amp;&amp; !opcode_is_oob(op))</span><br><span>     {</span><br>=
<span>         /*</span><br><span>          * This can occur due to bogus d=
ata or DoS packets=2E</span><br><span>@@ -390,6 +391,10 @@</span><br><span>=
     {</span><br><span>         return VERDICT_VALID_WKC_V1;</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if=
 (opcode_is_oob(op))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n VERDICT_VALID_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span>     else</span><br><span>     {</span><br><span>=
         return VERDICT_VALID_RESET_V2;</span><br><span>@@ -444,6 +449,29 @=
@</span><br><span>     return buf;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tls_wrap_oob_standalone(struc=
t tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        struct session_id=
 *own_sid, const struct buffer *payload)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Copy buffer here to point at the same data but allow tls_wrap_con=
trol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to poten=
tially change buf to point to another buffer without</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * modifying the buffer in tas */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D tas-&gt;workbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(buf_init(&amp;buf, tas-&gt;frame=2Ebuf=2Eheadroom));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Out-of-band messages carry the payload dir=
ectly, with no reliability</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * or ACK fields=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ASSERT(buf_copy(&amp;buf, payload));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; =
P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Add tls-auth/tl=
s-crypt wrapping, this might replace buf with</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * ctx-&gt;work */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    tls_wrap_control(ctx, header, &amp;buf, ow=
n_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return buf;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> struct session_id</span><br><span> =
calculate_session_id_hmac(struct session_id client_sid, const struct openvp=
n_sockaddr *from,</span><br><span>                           const uint8_t =
*key, int handwindow, int offset)</span><br><span>diff --git a/src/openvpn/=
ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index d8d4b5e=2E=2Ea7=
dc6d9 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>=
+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -106,6 +106,9 @@</span><br=
><span>     VERDICT_VALID_ACK_V1,</span><br><span>     /** The packet is a =
valid control packet with appended wrapped client key */</span><br><span>  =
   VERDICT_VALID_WKC_V1,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /** This packet is a valid out-of-band control message (e=2Eg=2E a=
 server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * probe=
)=2E It does not belong to a session and must not create one=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    VERDICT_VALID_OOB_V1,</s=
pan><br><span>     /** the packet failed on of the various checks */</span>=
<br><span>     VERDICT_INVALID</span><br><span> };</span><br><span>@@ -226,=
6 +229,21 @@</span><br><span>                                    struct ses=
sion_id *own_sid, struct session_id *remote_sid,</span><br><span>          =
                          uint8_t header, bool request_resend_wkc);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wrap an already-built =
out-of-band payload (e=2Eg=2E probe-reply TLVs) into a</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * standalone, session-less P_CONTROL_OO=
B_V1 packet: it prepends the opcode and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * own_sid and applies the same tls-auth/tls-crypt wrap=
ping as a regular</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 control packet, but carries no reliability/ACK fields=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param ctx       tls wrapping context (from the pre=
-decrypt state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param tas       standalone auth context providing the work buffer</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param own_sid   session i=
d to use as our session id in the header</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param payload   the OOB message payload (TLV strea=
m) to wrap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n          the wrapped packet buffer, ready to send</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx=
 *ctx, struct tls_auth_standalone *tas,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                      struct session_id=
 *own_sid, const struct buffer *payload);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> </span><br><span> /**</span><br><sp=
an>  * Extracts a control channel message from buf and adjusts the size of<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/=
unit_tests/openvpn/test_pkt=2Ec</span><br><span>index a732c2b=2E=2Eca3045a =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -695=
,6 +695,113 @@</span><br><span>     free_tas(&amp;tas_server);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Payload every OOB round-trip below wraps: a message header and one =
TLV=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static con=
st uint8_t oob_payload[] =3D { 0x01, 0x00, 0x00, 0x01, 0x00, 0x04, 0xde, 0x=
ad, 0xbe, 0xef };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Wrap oob_payload a=
s a standalone P_CONTROL_OOB_V1 with the client side of a</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * tls-auth/tls-crypt pair (or none),=
 run it through the server&#39;s stateless</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * first-packet path, and check verdict, recovered s=
ession id and payload=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_standalone_roundtrip(struct tls_auth_standalone *tas_client,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                         struc=
t tls_auth_standalone *tas_server)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct link_socket_actual from =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct tls_pre_decrypt_state state =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id =
sid =3D { { 0x0b, 1, 2, 3, 4, 5, 6, 0x0b } };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer payload =3D alloc_buf(64);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;payload, oob_payload, =
sizeof(oob_payload));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Client sid=
e: opcode + session id + tls-auth/tls-crypt wrapping around the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * bare payload, with none =
of the reliability/ACK fields a control packet</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * carries=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;tas_=
client-&gt;tls_wrap, tas_client, &amp;sid, &amp;payload);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal((BPTR(&amp;buf))=
[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_OOB_V1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Server side: the stateless first-packet path must recognise=
 the opcode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
verify the wrapping and leave exactly the payload in newbuf -- that is</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * what mudp=2Ec han=
ds to the probe parser=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    enum first_packet_verdict verdict =3D tls_pre_decrypt_lite(tas=
_server, &amp;state, &amp;from, &amp;buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(verdict, VERDICT_VALID_OOB_V1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_e=
qual(state=2Epeer_session_id=2Eid, sid=2Eid, SID_SIZE);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;state=2E=
newbuf), (int)sizeof(oob_payload));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;state=2Enewbuf), oob_payl=
oad, sizeof(oob_payload));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free_tls_pre_decrypt_state(&amp;state);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Tampering with any single byte must fail authentication:=
 the flip runs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* over opcode, session id, packet id, HMAC/tag and payload alike=2E Skipped=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * for TLS_WRAP=
_NONE, where a changed payload is legitimately accepted=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (tas_server-&gt;tls_wrap=
=2Emode !=3D TLS_WRAP_NONE)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct buffer copy =3D alloc_buf(BLEN(&amp;buf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; BLEN(&am=
p;buf); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_r=
eset_len(&amp;copy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            buf_write(&amp;copy, BPTR(&amp;buf), BLEN(&amp;buf));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            (BPTR(&amp;copy)=
)[i] ^=3D 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        struct tls_pre_decrypt_state tstate =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            verdict =3D tls_pre_decrypt_=
lite(tas_server, &amp;tstate, &amp;from, &amp;copy);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            assert_int_equal(verdict, VER=
DICT_INVALID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       free_tls_pre_decrypt_state(&amp;tstate);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        free_buf(&amp;copy);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fr=
ee_buf(&amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_oob_standalone_plain(void **ut_state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1=
400 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=
=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    tas=2Eworkbuf =3D alloc_buf(1600);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    oob_standalone_roundtrip(&amp;tas, &amp;tas);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
oob_standalone_tls_auth(void **ut_state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct tls_auth_standalone tas_server =3D init_tas_auth(KEY_DIRECTIO=
N_NORMAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tls_auth_standalone tas_client =3D init_tas_auth(KEY_DIRECTION_INVERSE);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&=
amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the server =
consumes the tls-auth packet id only with packet-id state,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * which tls_auth_standalone_ini=
t() sets up for the real one */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    packet_id_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id=
, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    n=
ow =3D 0x22446688;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   oob_standalone_roundtrip(&amp;tas_client, &amp;tas_server);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eopt=
=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
acket_id_free(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_client);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_s=
erver);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_oob_standalone_tls_crypt(void **ut_state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2Ehea=
droom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_server =3D i=
nit_tas_crypt(true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct tls_auth_standalone tas_client =3D init_tas_crypt(false);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Eframe =
=3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_c=
lient=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    packet_id_init(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5,=
 &quot;UNITTEST&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D =
0x22446688;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_=
standalone_roundtrip(&amp;tas_client, &amp;tas_server);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epack=
et_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tas=
(&amp;tas_client);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   free_tas(&amp;tas_server);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> static void</span><br><span> test_extract_control_message(void **=
ut_state)</span><br><span> {</span><br><span>@@ -745,6 +852,9 @@</span><br>=
<span>         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),</s=
pan><br><span>         cmocka_unit_test(test_generate_reset_packet_plain),<=
/span><br><span>         cmocka_unit_test(test_generate_reset_packet_tls_au=
th),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_oob_standalone_plain),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_oob_standalone_tls_auth),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_oob_standalone_tls_crypt),</span><br><span>         cmocka_unit_te=
st(test_extract_control_message)</span><br><span>     };</span><br><span> <=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">change 1744</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I930d3789e0313aa0c=
3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1744 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--bT88NlRh16A=--


--===============2976997628260969760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2976997628260969760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2976997628260969760==--

