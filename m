Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F99C43638
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=H8BFtfh25Rn0rE1wLVepsM2GbXdTDCvL3nNcGZ8/HuQ=; b=c/xVU/Wo/P2Hzd
	PqSn6G7z0/4HzbDu5k6ikYMHVUq9bME55QfOVjEOUOI8DJaR50hVoQXm1gaDm/LwchZDsqdF3pyss
	xh+UpF63Na3FvreqEF9EJEZ2Cvena5hxaZ9fRgK1KHLiJkT+uOqp88dDz06xn7Ek7ogC+xf9LK/3z
	Dkc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tZ-0001D6-Qj;
	Mon, 29 Jun 2026 07:59:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tY-0001Cw-R2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6pI7B3DXTy+Y4f659SBfxX0fO6YOA9GwrJeHivlH1A8=; b=nVp50B6hI//Ih85uJPKfr2mstb
 tOjlcO04w8GDYUWpsmtshTkrjLO8aR717gKk2UkMD/3J+ewWIF/P0e4kMSbiMDRo+z4sAMPfBLEVW
 ldx3K4tdb1GV6sd45J1b7LSC9Ruiti6LH7iiifBfxsvpWMMU0zY0QZEj4vmPD69wvhyA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6pI7B3DXTy+Y4f659SBfxX0fO6YOA9GwrJeHivlH1A8=; b=d
 GaBEtkbYgbYmMpra+cSKsK5RMFDYEcvJaeQN3prM9y2Grf1XEVfiDRIewjQqinoRwNRhvq7Ur2wLX
 YS3xQ9Y1+dp3nsP0ueElCPkNmcE3aTUD1lJ2+7ghog3jmP2CktFs53UQEFDwERerXG/h79R2rZYhF
 +KRv83vkfQF6ibvk=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tV-0008NG-8g for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:08 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-46066e640easo1558955f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719939; x=1783324739; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pI7B3DXTy+Y4f659SBfxX0fO6YOA9GwrJeHivlH1A8=;
 b=cex+4GKRkncDg4pQAKVq+0kJHWB2z/FhxUYwD2Vb7N/T7BqE8qpiBI2UV8QTFm8JQg
 daXtu41yAKbjytt69eFkvGirdfHQJarDJLLFfbt5HkF4NFhdWBXBjTJ3YRxYqpZE/gUN
 NYgeXQsCZqjPj3X8jnNEXiTBnTh/cbS2fO3dp4gSFraFBM+mcK99FuCpvMSZjgWjAoaY
 HV1AXxw2y+7J44oI5gr/OfIZrIFuTfzr3IGJWaOOGOh0a2Tcl24pusyIX00OJAVOM8/F
 WDVJpY9MSloFDHgxZyZ0wjdmCXzfQOzbPmTq22QlLIyb8kc1+Qt2AHsV15hSdP4JpiS3
 0yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719939; x=1783324739;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6pI7B3DXTy+Y4f659SBfxX0fO6YOA9GwrJeHivlH1A8=;
 b=M3NboYqklGxP4P1+Kz820J4z5ZXXp/fVNimwWkE3cAl148ohnSFLLhk5PNwJ+e1bvd
 iUmng1GIUuU7pq/zU9Kc/h/hTlrB5ZGwxJD6Y+ZdVMy9tXWn7KhyJjou2jHJwnI8NmGk
 XVYW9OpQSKzP0+ftDggBTK2N6mXvNsl/pHnFCVGFLzBWxq9aM8PCsPkE3NyU9bYyl820
 E9tp0OmEmkdMuGFkuNb8v068XFA8YT+X3S4Ydm+epCU13ctD2KbBk6sD3wTIiiVzhefp
 yTOw1QHC/gOn4A1S5Nii1ldmg+kpX/W/ts4XFzWbZ8OPw1kSLKSjh/wA7HBgTL5ryzKI
 WJDg==
X-Gm-Message-State: AOJu0YwnA+PYj2qX+g7YKVR39EblnSDQupyoYEC/4SzQCjmIo/92RD+C
 nse0y3BJ9Aq+mIuolzA3V4mr4Prq+D6kinORRgHcPsmkWitHmZiDoIcqfluNRfTcHJJXsXooIrr
 mQvPG3n11h92btIiSv3J9ZPDSrJddU26DXranQRaINpS2+6kVE/Dw+upgDVIrG7Q34TvJW1L6WN
 yHFuBX0w==
X-Gm-Gg: AfdE7ckQpmwgP2VwXP/983c6sBW0MSBmQP43ON6W4m2027y7a0meRXNXk78hlcDO4vQ
 P5ACgPlA264zVX8XzkQMQXV/fMHG2GNalWzmz4ib5nb2UEVHfHMUq8Vf8g2P5N3S7NSK+Y9SMZq
 8o2iKgviHwEgZXUxMp8H8A7l3HcTIG4/HItfIB9nWb/3gFDgK/2OJhrYCHB4zRaOEvga49Chf0P
 7e3yrk/asER4bEHAuY+qJDyLmMBTeJGCVWtzLmOQTrWsdP4fdbCK0hDGxtZxJ0ofdpj/TZxu9Sx
 USDUrqKOFgpaPPlSA04cmhMdXMpp+STdLHvPVfJANIQFg/EOKJiwUqHBsmwjoCEBJr7viMZIBbj
 SFCkGHSuHNfFfepIQM9VyX/bsrlgNR8ZbgYMTzibsQncXnCKhMxmEV4BEyJMCDks2lLC2TrZKHs
 nYxtDgf8DFOQivehe0V0wodgX7Dz5+wCVl00C7UN+xaz71kaElS4wfnTPovYQfHEP5ajst3CWhe
 gWXk3Bt70wId8zr/X7WXhuBncCt80UviBZxO16JxQsE5mayQq68X1EX/WHFgMu1F/16NC7JUKZH
 DXGMSFbVPNQ+pA==
X-Received: by 2002:a05:600c:3b96:b0:493:b4a3:5a97 with SMTP id
 5b1f17b1804b1-493b4a35cd2mr11845305e9.16.1782719938962; 
 Mon, 29 Jun 2026 00:58:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49270671e4esm235087415e9.13.2026.06.29.00.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:58:58 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:58:58 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: ba0990d5a06591518855e29695471871e113fbb5
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <99f90fa98f1915a24bce9879bc8a1de2e8507cec-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tV-0008NG-8g
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5922563308816324697=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5922563308816324697==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="74Z5zuqfrsY="; charset=UTF-8

--74Z5zuqfrsY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1744?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Answer SERVER_=
PROBE on the server (P_CONTROL_OOB_V1)

Make a --mode server UDP listener a=
nswer an out-of-band SERVER_PROBE without
creating a session:

  - tls_pre_=
decrypt_lite() accepts P_CONTROL_OOB_V1 and returns the new
    VERDICT_VAL=
ID_OOB_V1 verdict=2E
  - tls_wrap_oob_standalone() builds a session-less P_=
CONTROL_OOB_V1 packet:
    opcode + session id + the usual tls-auth/tls-cry=
pt wrapping around a bare
    TLV payload (no reliability/ACK fields), mirr=
oring tls_reset_standalone()=2E
  - do_pre_decrypt_check() handles the new =
verdict: it asks
    oob_build_probe_reply() whether to answer, and if so s=
ends a PROBE_REPLY
    via send_probe_reply() (synchronous, stateless, like=
 the HMAC reset path)
    and returns false so no session is created=2E

Th=
e reply's own session id is the stateless SYN-cookie used by the three-way
=
handshake, so the responder keeps no state and the reply can later serve as=

the handshake reset (connect_lifetime shortcut)=2E

P_LAST_OPCODE is inten=
tionally not widened: the server path uses the
tls_pre_decrypt_lite() allow=
list and tls_wrap_control() directly, so opcode 12
need not pass the establ=
ished-session opcode gate yet=2E That gate (and the
matching tls_pre_decryp=
t() handler) is widened together with the client
receive path=2E

oob=2Ec i=
s now wired into the openvpn build as it has a real caller=2E

Change-Id: I=
930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Signed-off-by: Lev Stipakov <lev@o=
penvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/open=
vpn/mudp=2Ec
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/ssl_=
pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
7 files changed, 131 insertions(+), 6 del=
etions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/44/1744/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index d2b8=
8c0=2E=2E608e39e4 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -=
518,6 +518,8 @@
     src/openvpn/multi_io=2Ec
     src/openvpn/occ=2Ec
    =
 src/openvpn/occ=2Eh
+    src/openvpn/oob=2Ec
+    src/openvpn/oob=2Eh
    =
 src/openvpn/openvpn=2Ec
     src/openvpn/openvpn=2Eh
     src/openvpn/open=
vpn_win32_resources=2Erc
diff --git a/src/openvpn/Makefile=2Eam b/src/openv=
pn/Makefile=2Eam
index ff8cc54=2E=2Eb4b1b92 100644
--- a/src/openvpn/Makefi=
le=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -106,6 +106,7 @@
 	pkcs11=2Ec pk=
cs11=2Eh pkcs11_backend=2Eh \
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \=

+	oob=2Ec oob=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh =
\
 	options_util=2Ec options_util=2Eh \
diff --git a/src/openvpn/mudp=2Ec b=
/src/openvpn/mudp=2Ec
index d3b529f=2E=2E9bc2d9c 100644
--- a/src/openvpn/m=
udp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2E=
h"
 #include "ssl_pkt=2Eh"
+#include "oob=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H=

 #include <sys/inotify=2Eh>
@@ -84,6 +85,34 @@
                           =
"Reset packet from client, sending HMAC based reset challenge", sock);
 }
 =

+/* Send an out-of-band PROBE_REPLY back to the source of a SERVER_PROBE,
=
+ * synchronously and without keeping any state, mirroring the reset path=
=2E */
+static void
+send_probe_reply(struct multi_context *m, struct tls_p=
re_decrypt_state *state,
+                 struct tls_auth_standalone *tas,=
 const struct oob_probe_reply *reply,
+                 struct session_id *=
own_sid, struct link_socket *sock)
+{
+    struct gc_arena gc =3D gc_new();=

+
+    /* Build the payload of the reply (message-type header + probe_repl=
y TLV) */
+    struct buffer payload =3D alloc_buf_gc(128, &gc);
+    if (!=
oob_client_reply_write(&payload, reply))
+    {
+        gc_free(&gc);
+   =
     return;
+    }
+
+    /* OOB replies use the same control-channel wrap=
ping as the request */
+    reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=
=2Epacket_id=2Esend);
+    state->tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Ein=
itialized =3D true;
+
+    struct buffer buf =3D tls_wrap_oob_standalone(&s=
tate->tls_wrap_tmp, tas, own_sid, &payload);
+    send_standalone_reply(m, =
&buf, "Server Probe", "Server probe from client, sending probe reply",
+   =
                       sock);
+
+    gc_free(&gc);
+}
+
 
 /* Returns true =
if this packet should create a new session */
 static bool
@@ -200,6 +229,3=
9 @@
 
         return ret;
     }
+    else if (verdict =3D=3D VERDICT_VAL=
ID_OOB_V1)
+    {
+        /* Out-of-band server probe=2E state->newbuf poi=
nts at the TLV payload
+         * (read_control_auth has stripped the opco=
de, session id and any
+         * tls-auth/tls-crypt wrapping)=2E Answer i=
t without creating a session=2E */
+        struct oob_probe_reply reply;
+=
        if (!oob_build_probe_reply(&state->newbuf, (uint64_t)now, (uint64_t=
)handwindow,
+                                   &state->peer_session_id, &=
reply))
+        {
+            /* malformed or replayed/stale probe: silen=
tly drop */
+            return false;
+        }
+
+        /* Rate-limit =
replies, as the reset path does, so an unauthenticated
+         * probe fl=
ood (no tls-auth/tls-crypt) cannot use us as a reflector=2E */
+        if =
(!reflect_filter_rate_limit_check(m->initial_rate_limiter))
+        {
+   =
         return false;
+        }
+
+        /* Our session id is a statele=
ss SYN cookie (the same HMAC the three-way
+         * handshake uses): we =
keep no per-probe state, and the reply can later
+         * also serve as =
the server's CONTROL_HARD_RESET_SERVER_V2, letting a
+         * client ski=
p the first two handshake messages (the connect_lifetime
+         * shortc=
ut)=2E */
+        struct session_id sid =3D
+            calculate_session=
_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
+
+        sen=
d_probe_reply(m, state, tas, &reply, &sid, sock);
+
+        /* An OOB prob=
e never creates a session */
+        return false;
+    }
 
     /* VERDIC=
T_INVALID */
     return false;
diff --git a/src/openvpn/oob=2Ec b/src/open=
vpn/oob=2Ec
index 58d47c0=2E=2Ef7af0ef 100644
--- a/src/openvpn/oob=2Ec
+++=
 b/src/openvpn/oob=2Ec
@@ -193,6 +193,12 @@
 }
 
 bool
+oob_client_reply_wr=
ite(struct buffer *buf, const struct oob_probe_reply *reply)
+{
+    return=
 oob_msg_write_header(buf, OOB_MSG_PROBE_REPLY) && oob_probe_reply_write(bu=
f, reply);
+}
+
+bool
 oob_timestamp_in_window(uint64_t probe_ts, uint64_t =
now, uint64_t window_secs)
 {
     uint64_t diff =3D (now > probe_ts) ? (no=
w - probe_ts) : (probe_ts - now);
diff --git a/src/openvpn/oob=2Eh b/src/op=
envpn/oob=2Eh
index 48fcfa1=2E=2E93c44b0 100644
--- a/src/openvpn/oob=2Eh
+=
++ b/src/openvpn/oob=2Eh
@@ -164,6 +164,12 @@
 bool oob_server_probe_read(s=
truct buffer *payload, struct oob_probe_parameter *param);
 
 /**
+ * Write=
 a complete PROBE_REPLY message (message-type header + probe_reply TLV)
+ *=
 to @p buf=2E Sent by the server=2E
+ */
+bool oob_client_reply_write(struc=
t buffer *buf, const struct oob_probe_reply *reply);
+
+/**
  * Check wheth=
er a probe timestamp is within an acceptable window around the
  * current =
time=2E Used to cheaply drop replayed or implausibly-timed probes
  * befor=
e doing any further work (see the probe_parameter timestamp rationale
diff =
--git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 1805995=2E=
=2E86e42c1 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=
=2Ec
@@ -315,7 +315,8 @@
 
     /* Allow only the reset packet or the first=
 packet of the actual handshake=2E */
     if (op !=3D P_CONTROL_HARD_RESET=
_CLIENT_V2 && op !=3D P_CONTROL_HARD_RESET_CLIENT_V3
-        && op !=3D P_=
CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1)
+        && op =
!=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1
+        =
&& op !=3D P_CONTROL_OOB_V1)
     {
         /*
          * This can occur =
due to bogus data or DoS packets=2E
@@ -390,6 +391,10 @@
     {
         re=
turn VERDICT_VALID_WKC_V1;
     }
+    else if (op =3D=3D P_CONTROL_OOB_V1)=

+    {
+        return VERDICT_VALID_OOB_V1;
+    }
     else
     {
     =
    return VERDICT_VALID_RESET_V2;
@@ -444,6 +449,29 @@
     return buf;
 }=

 
+struct buffer
+tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct=
 tls_auth_standalone *tas,
+                        struct session_id *own_=
sid, const struct buffer *payload)
+{
+    /* Copy buffer here to point at =
the same data but allow tls_wrap_control
+     * to potentially change buf =
to point to another buffer without
+     * modifying the buffer in tas */
+=
    struct buffer buf =3D tas->workbuf;
+    ASSERT(buf_init(&buf, tas->fra=
me=2Ebuf=2Eheadroom));
+
+    /* Out-of-band messages carry the payload dir=
ectly, with no reliability
+     * or ACK fields=2E */
+    ASSERT(buf_copy=
(&buf, payload));
+
+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P=
_OPCODE_SHIFT);
+
+    /* Add tls-auth/tls-crypt wrapping, this might repla=
ce buf with
+     * ctx->work */
+    tls_wrap_control(ctx, header, &buf, o=
wn_sid);
+
+    return buf;
+}
+
 hmac_ctx_t *
 session_id_hmac_init(void)
=
 {
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 0da=
b524=2E=2E6f05a19 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ss=
l_pkt=2Eh
@@ -62,11 +62,13 @@
  * control channel session (e=2Eg=2E a serve=
r probe)=2E Inherently unreliable:
  * there is no protocol-level retransmi=
ssion=2E
  *
- * NOTE: intentionally not yet included in the P_FIRST_OPCODE=
=2E=2EP_LAST_OPCODE
- * legal range=2E The range acts as an acceptance gate=
 in tls_pre_decrypt();
- * widening it before an OOB receive handler exists=
 would let OOB packets
- * be misparsed as established-session control pack=
ets=2E Bump P_LAST_OPCODE
- * to 12 in the same change that adds the handle=
r=2E */
+ * On the server this is accepted via the tls_pre_decrypt_lite() a=
llowlist and
+ * handled in the new-connection path (it never creates a ses=
sion)=2E It is
+ * deliberately still excluded from the P_FIRST_OPCODE=2E=
=2EP_LAST_OPCODE range
+ * that gates the established-session tls_pre_decry=
pt(): that range is widened
+ * to 12 only together with the established-se=
ssion/client OOB receive handler,
+ * otherwise an OOB packet arriving on a=
n existing session would be misparsed
+ * as a control packet=2E */
 #defin=
e P_CONTROL_OOB_V1 12
 
 /* define the range of legal opcodes
@@ -105,6 +10=
7,9 @@
     VERDICT_VALID_ACK_V1,
     /** The packet is a valid control pa=
cket with appended wrapped client key */
     VERDICT_VALID_WKC_V1,
+    /*=
* This packet is a valid out-of-band control message (e=2Eg=2E a server
+  =
   * probe)=2E It does not belong to a session and must not create one=2E *=
/
+    VERDICT_VALID_OOB_V1,
     /** the packet failed on of the various c=
hecks */
     VERDICT_INVALID
 };
@@ -235,6 +240,21 @@
                    =
                struct session_id *own_sid, struct session_id *remote_sid,
=
                                    uint8_t header, bool request_resend_wkc=
);
 
+/**
+ * Wrap an already-built out-of-band payload (e=2Eg=2E probe-rep=
ly TLVs) into a
+ * standalone, session-less P_CONTROL_OOB_V1 packet: it pr=
epends the opcode and
+ * @p own_sid and applies the same tls-auth/tls-cryp=
t wrapping as a regular
+ * control packet, but carries no reliability/ACK =
fields=2E
+ *
+ * @param ctx       tls wrapping context (from the pre-decry=
pt state)
+ * @param tas       standalone auth context providing the work b=
uffer
+ * @param own_sid   session id to use as our session id in the heade=
r
+ * @param payload   the OOB message payload (TLV stream) to wrap
+ * @re=
turn          the wrapped packet buffer, ready to send
+ */
+struct buffer =
tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalon=
e *tas,
+                                      struct session_id *own_sid, =
const struct buffer *payload);
+
 
 /**
  * Extracts a control channel mess=
age from buf and adjusts the size of

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-N=
umber: 1744
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>

--74Z5zuqfrsY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)<br><br>Make a --mod=
e server UDP listener answer an out-of-band SERVER_PROBE without<br>creatin=
g a session:<br><br>  - tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and=
 returns the new<br>    VERDICT_VALID_OOB_V1 verdict=2E<br>  - tls_wrap_oob=
_standalone() builds a session-less P_CONTROL_OOB_V1 packet:<br>    opcode =
+ session id + the usual tls-auth/tls-crypt wrapping around a bare<br>    T=
LV payload (no reliability/ACK fields), mirroring tls_reset_standalone()=2E=
<br>  - do_pre_decrypt_check() handles the new verdict: it asks<br>    oob_=
build_probe_reply() whether to answer, and if so sends a PROBE_REPLY<br>   =
 via send_probe_reply() (synchronous, stateless, like the HMAC reset path)<=
br>    and returns false so no session is created=2E<br><br>The reply&#39;s=
 own session id is the stateless SYN-cookie used by the three-way<br>handsh=
ake, so the responder keeps no state and the reply can later serve as<br>th=
e handshake reset (connect_lifetime shortcut)=2E<br><br>P_LAST_OPCODE is in=
tentionally not widened: the server path uses the<br>tls_pre_decrypt_lite()=
 allowlist and tls_wrap_control() directly, so opcode 12<br>need not pass t=
he established-session opcode gate yet=2E That gate (and the<br>matching tl=
s_pre_decrypt() handler) is widened together with the client<br>receive pat=
h=2E<br><br>oob=2Ec is now wired into the openvpn build as it has a real ca=
ller=2E<br><br>Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0<br>Sign=
ed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2E=
txt<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/mudp=2Ec<br>M src/openv=
pn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/o=
penvpn/ssl_pkt=2Eh<br>7 files changed, 131 insertions(+), 6 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/44/1744/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt</span><br><span>index d2b88c0=2E=2E608e39e4 100644</span><br><span>-=
-- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><spa=
n>@@ -518,6 +518,8 @@</span><br><span>     src/openvpn/multi_io=2Ec</span><=
br><span>     src/openvpn/occ=2Ec</span><br><span>     src/openvpn/occ=2Eh<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/oob=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><br><span>     =
src/openvpn/openvpn=2Eh</span><br><span>     src/openvpn/openvpn_win32_reso=
urces=2Erc</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/ope=
nvpn/Makefile=2Eam</span><br><span>index ff8cc54=2E=2Eb4b1b92 100644</span>=
<br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn=
/Makefile=2Eam</span><br><span>@@ -106,6 +106,7 @@</span><br><span> 	pkcs11=
=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><span> 	pkcs11_openssl=2Ec \=
</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><span> 	openvpn=2Ec openvp=
n=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span><br><span> 	optio=
ns_util=2Ec options_util=2Eh \</span><br><span>diff --git a/src/openvpn/mud=
p=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index d3b529f=2E=2E9bc2d9c 100=
644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/op=
envpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span><b=
r><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ss=
l_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;oob=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS=
_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><spa=
n>@@ -84,6 +85,34 @@</span><br><span>                           &quot;Reset=
 packet from client, sending HMAC based reset challenge&quot;, sock);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Send an out-of-band PROBE_REPLY back to the source of a SERV=
ER_PROBE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * synchro=
nously and without keeping any state, mirroring the reset path=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+send_probe_reply(struct multi_cont=
ext *m, struct tls_pre_decrypt_state *state,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 struct tls_auth_standalone *tas, =
const struct oob_probe_reply *reply,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 struct session_id *own_sid, struct link_s=
ocket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Build the payload =
of the reply (message-type header + probe_reply TLV) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D alloc_buf=
_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!oob_client_reply_write(&amp;payload, reply))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OOB =
replies use the same control-channel wrapping as the request */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;s=
tate-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=
=2Erec=2Einitialized =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer buf =3D tls_wrap_oob_standalone(&amp;state-&gt;tls_wrap_tmp, tas,=
 own_sid, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    send_standalone_reply(m, &amp;buf, &quot;Server Probe&quot;, &quot=
;Server probe from client, sending probe reply&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          sock);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> </span><br><span> /* Returns true if this pac=
ket should create a new session */</span><br><span> static bool</span><br><=
span>@@ -200,6 +229,39 @@</span><br><span> </span><br><span>         return=
 ret;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* Out-of-band server probe=2E state-&gt;n=
ewbuf points at the TLV payload</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * (read_control_auth has stripped the opcode, session =
id and any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* tls-auth/tls-crypt wrapping)=2E Answer it without creating a session=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct oob=
_probe_reply reply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!oob_build_probe_reply(&amp;state-&gt;newbuf, (uint64_t)now, (u=
int64_t)handwindow,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                   &amp;state-&gt;peer_session_id, &amp;rep=
ly))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* malformed =
or replayed/stale probe: silently drop */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* Rate-limit replies, as the reset path does, so an unauthenticated=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * probe fl=
ood (no tls-auth/tls-crypt) cannot use us as a reflector=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!reflect_filter_rate=
_limit_check(m-&gt;initial_rate_limiter))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
Our session id is a stateless SYN cookie (the same HMAC the three-way</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * handshake uses=
): we keep no per-probe state, and the reply can later</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * also serve as the server&#39;=
s CONTROL_HARD_RESET_SERVER_V2, letting a</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * client skip the first two handshake messag=
es (the connect_lifetime</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * shortcut)=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct session_id sid =3D</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            calculate_session_id_hmac(state-&gt;p=
eer_session_id, from, hmac, handwindow, 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        send_probe_reply(m, state, tas, &amp;reply, &amp;sid, sock);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* An OOB probe never creates a =
session */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span> </span><br><span>     /* VERDICT_INVALID */</span><br><span=
>     return false;</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/=
openvpn/oob=2Ec</span><br><span>index 58d47c0=2E=2Ef7af0ef 100644</span><br=
><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec<=
/span><br><span>@@ -193,6 +193,12 @@</span><br><span> }</span><br><span> </=
span><br><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+oob_client_reply_write(struct buffer *buf, const struct oob_probe_reply *r=
eply)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return oob_msg_write_header(=
buf, OOB_MSG_PROBE_REPLY) &amp;&amp; oob_probe_reply_write(buf, reply);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span> oob_timestamp_in_window(uint64_t probe=
_ts, uint64_t now, uint64_t window_secs)</span><br><span> {</span><br><span=
>     uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts =
- now);</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=
=2Eh</span><br><span>index 48fcfa1=2E=2E93c44b0 100644</span><br><span>--- =
a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><=
span>@@ -164,6 +164,12 @@</span><br><span> bool oob_server_probe_read(struc=
t buffer *payload, struct oob_probe_parameter *param);</span><br><span> </s=
pan><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Write a complete PROBE_REPLY message (message-type header + probe_reply T=
LV)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to @p buf=2E =
Sent by the server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_clien=
t_reply_write(struct buffer *buf, const struct oob_probe_reply *reply);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Check whether a p=
robe timestamp is within an acceptable window around the</span><br><span>  =
* current time=2E Used to cheaply drop replayed or implausibly-timed probes=
</span><br><span>  * before doing any further work (see the probe_parameter=
 timestamp rationale</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b=
/src/openvpn/ssl_pkt=2Ec</span><br><span>index 1805995=2E=2E86e42c1 100644<=
/span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl_pkt=2Ec</span><br><span>@@ -315,7 +315,8 @@</span><br><span> </spa=
n><br><span>     /* Allow only the reset packet or the first packet of the =
actual handshake=2E */</span><br><span>     if (op !=3D P_CONTROL_HARD_RESE=
T_CLIENT_V2 &amp;&amp; op !=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; op !=3D P_CONTRO=
L_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; op !=
=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_A=
CK_V1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&=
amp; op !=3D P_CONTROL_OOB_V1)</span><br><span>     {</span><br><span>     =
    /*</span><br><span>          * This can occur due to bogus data or DoS =
packets=2E</span><br><span>@@ -390,6 +391,10 @@</span><br><span>     {</spa=
n><br><span>         return VERDICT_VALID_WKC_V1;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (op =3D=3D=
 P_CONTROL_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
VERDICT_VALID_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span>     else</span><br><span>     {</span><br><span>  =
       return VERDICT_VALID_RESET_V2;</span><br><span>@@ -444,6 +449,29 @@<=
/span><br><span>     return buf;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+tls_wrap_oob_standalone(struct =
tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span style=
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
sl(120, 100%, 40%);">+</span><br><span> hmac_ctx_t *</span><br><span> sessi=
on_id_hmac_init(void)</span><br><span> {</span><br><span>diff --git a/src/o=
penvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 0dab524=
=2E=2E6f05a19 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><b=
r><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -62,11 +62,13 @@</=
span><br><span>  * control channel session (e=2Eg=2E a server probe)=2E Inh=
erently unreliable:</span><br><span>  * there is no protocol-level retransm=
ission=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * NOTE: intentionally not yet included in the P_FIRST_OPCODE=2E=2E=
P_LAST_OPCODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * legal=
 range=2E The range acts as an acceptance gate in tls_pre_decrypt();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * widening it before an OOB=
 receive handler exists would let OOB packets</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * be misparsed as established-session control pack=
ets=2E Bump P_LAST_OPCODE</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * to 12 in the same change that adds the handler=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * On the server this is accepted v=
ia the tls_pre_decrypt_lite() allowlist and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * handled in the new-connection path (it never cre=
ates a session)=2E It is</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * deliberately still excluded from the P_FIRST_OPCODE=2E=2EP_LAST_OPC=
ODE range</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that ga=
tes the established-session tls_pre_decrypt(): that range is widened</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * to 12 only together wit=
h the established-session/client OOB receive handler,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * otherwise an OOB packet arriving on an=
 existing session would be misparsed</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * as a control packet=2E */</span><br><span> #define P_CO=
NTROL_OOB_V1 12</span><br><span> </span><br><span> /* define the range of l=
egal opcodes</span><br><span>@@ -105,6 +107,9 @@</span><br><span>     VERDI=
CT_VALID_ACK_V1,</span><br><span>     /** The packet is a valid control pac=
ket with appended wrapped client key */</span><br><span>     VERDICT_VALID_=
WKC_V1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** This=
 packet is a valid out-of-band control message (e=2Eg=2E a server</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * probe)=2E It does not =
belong to a session and must not create one=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    VERDICT_VALID_OOB_V1,</span><br><span>   =
  /** the packet failed on of the various checks */</span><br><span>     VE=
RDICT_INVALID</span><br><span> };</span><br><span>@@ -235,6 +240,21 @@</spa=
n><br><span>                                    struct session_id *own_sid,=
 struct session_id *remote_sid,</span><br><span>                           =
         uint8_t header, bool request_resend_wkc);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Wrap an already-built out-of-band payl=
oad (e=2Eg=2E probe-reply TLVs) into a</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * standalone, session-less P_CONTROL_OOB_V1 packet: it =
prepends the opcode and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @p own_sid and applies the same tls-auth/tls-crypt wrapping as a reg=
ular</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control pack=
et, but carries no reliability/ACK fields=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param ctx       tls wrapping context (from the pre-decrypt stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param tas    =
   standalone auth context providing the work buffer</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param own_sid   session id to use as =
our session id in the header</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param payload   the OOB message payload (TLV stream) to wrap</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return          t=
he wrapped packet buffer, ready to send</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct =
tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                      struct session_id *own_sid, con=
st struct buffer *payload);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> </span><br><span> /**</span><br><span>  * Extract=
s a control channel message from buf and adjusts the size of</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1744?usp=3Demail">change 1744</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108=
343d59f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1744 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--74Z5zuqfrsY=--


--===============5922563308816324697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5922563308816324697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5922563308816324697==--

