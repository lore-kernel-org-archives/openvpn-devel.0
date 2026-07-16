Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEE3C44516
	for <openvpn-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b/9+uEeOPJuakVutVgNdIOYcXcEWN5wgl50RQdkW0ck=; b=WK6WmQn/OWAcMTM5YF6paF2G5B
	swjl64UrOp8ElwzwMzj0QNrsCeiKa/nq7B8UETYOZevQoI9OXZZ2pBoqhAJzOBtKA8pF3+JMBjha3
	S59c/CAFf3zw2ozRAu/anrHkZYBs/Og4zalyTGYRmPqT/S16UAyvUqPVr5dwdIsc4pWs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkGvi-0002ye-JX;
	Thu, 16 Jul 2026 07:54:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkGvg-0002yW-Mg
 for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 07:54:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZIGHEz5Pm4BkCa31qakt+9eiHmNB1Xjt/U6ZN7X8Z0Y=; b=Mttwnk0+o/liBe6viiucn+Ixvh
 isFrOj0jq3dwX0pea8jw+gX5mAlve0V6iz7maatUfcKu/hQAFxFok5HKdsiG1L7shPj5VmNuUgSQ1
 ji+e4YCqUfAektpkN2Qv7f23Tdg4Ar/oH2a3bHNBWjxe4aV+x/NUQ5a2k3UI+4Vwwy/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZIGHEz5Pm4BkCa31qakt+9eiHmNB1Xjt/U6ZN7X8Z0Y=; b=d
 +R6vI2ScSN5Or8onTJSayIbhJ/Kh/A7nXJZkt89QlAF1qiRgXbs1583UerZ25gygMKHaZ1UYk0FnN
 1zUujT7BcNlNDXbPg8eYyhKzvgVi1hDVt6M+du+DNKB27LGRGO5cZj1UfmT91oJWweMoK4QHqaOt7
 AxaY+E/whygyPKoM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkGva-0004W7-Gp for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 07:54:46 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso17211365e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2026 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784188471; x=1784793271; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZIGHEz5Pm4BkCa31qakt+9eiHmNB1Xjt/U6ZN7X8Z0Y=;
 b=XH+3DYtczMMJZakDBF6qkk9L48CgbnxqvoxRsKZD5E7AVWfdy3UgtTFaem5wdpHc5I
 lgo2wT1lC9jkS9I61+IWLxwTiLJrNnAwibCOsyzlC34VcG3VsATsoHVSGuTZumxoel7n
 efxNkS7KqOGPXtGFc+cijga7gdXXMrQmO00MjzLaooKUw5XJ38kpDL47t4GD4EodDpqc
 8dFzc5PRmwrSfEFWrHRpO7wAzSTT9eDZG6ZHexWREbBbUHyN1dMn4SjShjOPahWyPgL5
 MscfpgBa1AZfoWPs8Zd0X0sEUkNYD5h7u9TCEYAmJh9EHpOyuXJSvqzHIx4of/GbisDc
 Cdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784188471; x=1784793271;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZIGHEz5Pm4BkCa31qakt+9eiHmNB1Xjt/U6ZN7X8Z0Y=;
 b=B2tE6VB1/5YVNOJ9YsivoXs8YYCD2z3Px8pinc4/ZGfIbn1u/9MDKZJ7YmIRT74b8p
 tQc+vXEjUPc2EhDWEKZAAbY2ABfxRFOXLHcy3h+33QqTt56ykb1RACyYHBo57TnShUDq
 6ukzo1GnbDX8+e5rsRpZxAdKNxeRIaY4oIAKLFtloZKFWL4pr61IhQnFtEJYnVoppCWk
 f5b0LNuUvNN0m55fwvhztxHfW0Ju7wh4ubqSEEzCZf+aMxqlYPAm0m1TnR9kwhNPIBgD
 R24Raq0GhjcMw98RbrLs/7o3yEgoTmAv7Wi3fnJ4RFya5v31x/9aUtRIdoNU03cePpwD
 LF/w==
X-Gm-Message-State: AOJu0YxkFgzzVPLBcXASrSkn7FuImM32H8lU9netzPl8t5qzZJYhzv4n
 19ero7l1wcbiVstEF+5Re0RiLQre1jyFgSTHzjEvn4JatQKVYgVU/8xUx5wKJmjKBS++Q6Vy+Ux
 8XH0shKAHryhU+YIIJ3FAhr0rMxcJjGiWzxj+t1Gu2GaXZyKyUBxrgY0G/bdA+M84vGVK
X-Gm-Gg: AfdE7cm97rTyN2Ng4qxagdYINSXmU0vBZ/hn61UpLpd1JZ92cl4M/FTdtws6MUUKilU
 gYOFtzkyyhW47eB2jj4XxtTt3n+GxAf6mvbYKp8cZzMei/jJoWFu2oZ/skuAmPf+24/LuD91iFj
 k0bv38xdzNXddFyy6DHJZJ6SJl3rU98UPB4j22qWkHHvOhEauQvYs3PrfCJ8uafOXL+5izMKfjP
 lonRX1f9o0KLxaM4OjD1p4nL9Zr4MtXKp+ja9N8osI7F673Bgxls26MYlDSMmfITS2goXVNjE+/
 h6fDnjRRBJcmbleFABJbTVs/zOQT9mUR/cNa70KwXYKbPD+4Uy60XXIyVZeRZM1xuGiVXXylrCc
 u4fIQKgsQTGquQFgh/9il+cnlFv1zAp6q2ZAsifT24YIWJh3YsoMNIqlcEU20f3t2tNmVKhR7/w
 f4JqTkqglr7GlPP6pn3TnN2ghM2tEZmJQ4BlFRDoEI3i6JoXlni3OSw5tWiCUpXC46PC114u3hi
 9mrFVn0/WgNEgsG6gSttBILemCcsC+apWRl7sI0yHnXIpMWkVa2Y02KAVL1VdBFVM4A
X-Received: by 2002:a05:600c:a09:b0:495:4438:796f with SMTP id
 5b1f17b1804b1-49544387adcmr6654145e9.24.1784188470657; 
 Thu, 16 Jul 2026 00:54:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e8edc7sm35121235e9.8.2026.07.16.00.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 00:54:30 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 16 Jul 2026 07:54:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: 8c83de24372c690a1dc968ab24133511d794258a
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5e76681425a3d8f8ca8f43fb5cf4906bb69e622-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkGva-0004W7-Gp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: client
 handshake shortcut via a server probe
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
Content-Type: multipart/mixed; boundary="===============7615210995115701877=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7615210995115701877==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pjAcWrGjywY="; charset=UTF-8

--pjAcWrGjywY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#6)=2E

=

Change subject: oob: client handshake shortcut via a server probe
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: client handsha=
ke shortcut via a server probe

When the best remote answered a probe and a=
dvertised a connect_lifetime, the
client now skips its own three-way handsh=
ake and starts at the third packet,
reusing the probe reply as the server's=
 HARD_RESET (its session id is a valid
stateless SYN-cookie)=2E Saves one R=
TT on connect=2E

  - oob_client=2Ec: on a shortcut-capable winner, hand it=
s probe socket, the
    captured server session id (cookie), our probe sess=
ion id, the pinned
    responder address, and the resend-wkc flag to the co=
nnection via c2;
    relinquish that socket (do not close it); gate off for=
 dco-win, which has
    no user-to-kernel socket handoff (probing still wor=
ks, only the shortcut is
    skipped)=2E
  - ssl=2Ec session_skip_to_pre_st=
art_client(): seed our session id to the probe's
    (the cookie is an HMAC=
 over it), the remote session id to the cookie, ack
    the phantom server =
reset (id 0) so the third packet carries the cookie, set
    CO_RESEND_WKC =
for tls-crypt-v2, and drop to S_PRE_START so tls_process()
    promotes to =
S_START and sends the ClientHello (no HARD_RESET sent)=2E
  - init=2Ec: inv=
oke the client skip after tls_multi_init_finalize when adopting=2E

Change-=
Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
Signed-off-by: Lev Stipakov <=
lev@openvpn=2Enet>
---
M Changes=2Erst
M src/openvpn/init=2Ec
M src/openvpn=
/oob=2Eh
M src/openvpn/oob_client=2Ec
M src/openvpn/openvpn=2Eh
M src/openv=
pn/ssl=2Ec
M src/openvpn/ssl=2Eh
7 files changed, 177 insertions(+), 4 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/70/1770/6

diff --git a/Changes=2Erst b/Changes=2Erst
index 080d928=2E=
=2E0fad132 100644
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -9,6 +9,11 @@
=
     measured latency and advertised weight with DNS-SRV-like semantics=2E
=
     Servers advertise these values with ``--server-probe-reply``=2E
 
+Han=
dshake shortcut for probing clients
+    A probing client reuses the probe =
reply to skip one round trip of
+    the three-way handshake when the chose=
n server advertises support
+    for it=2E This needs no extra configuratio=
n=2E
+
 
 Overview of changes in 2=2E7
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec
index 8eca6f7=2E=2Efc44f41 100644
--- a/src/ope=
nvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3505,6 +3505,21 @@
         /*=
 Keep the max mtu also in the frame of tls multi so it can access
         =
 * it in push_peer_info */
         c->c2=2Etls_multi->opt=2Eframe=2Etun_ma=
x_mtu =3D c->c2=2Eframe=2Etun_max_mtu;
+
+        /* OOB server-probe hands=
hake shortcut: the probe reply already served as
+         * the server's H=
ARD_RESET (it carried a valid SYN-cookie), so skip our
+         * own rese=
t exchange and start the handshake at the third packet=2E Count
+         *=
 the reply as the initial packet received (as the server does before its
+ =
        * own session_skip_to_pre_start), so tls_initial_packet_received() =
is true
+         * and check_server_poll_timeout() does not restart a conn=
ected session=2E */
+        if (c->c2=2Eoob_probe_adopt)
+        {
+     =
       c->c2=2Etls_multi->n_sessions++;
+            session_skip_to_pre_st=
art_client(&c->c2=2Etls_multi->session[TM_ACTIVE],
+                       =
                      &c->c2=2Eoob_probe_client_sid,
+                     =
                        &c->c2=2Eoob_probe_server_sid, &c->c2=2Eoob_probe_r=
emote,
+                                             c->c2=2Eoob_probe_rese=
nd_wkc);
+        }
     }
     if (c->c2=2Etls_auth_standalone)
     {
dif=
f --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 015a405=2E=2Ecf22=
f5c 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -248,6 +2=
48,11 @@
     uint16_t weight;
     uint16_t max_latency_diff; /* margin ad=
vertised by this server (ms); 0 =3D use client default */
     unsigned int=
 rtt_ms;       /* probe round-trip time in ms (responders only) */
+    /* =
Captured from the reply for the handshake shortcut (responders only): */
+ =
   struct session_id server_sid;      /* the reply's own session id =3D ser=
ver SYN-cookie */
+    uint16_t connect_lifetime;         /* seconds the re=
ply is valid as a shortcut; 0 =3D none */
+    uint32_t reply_flags;       =
       /* OOB_PROBE_REPLY_FLAG_* advertised by the server */
+    struct so=
ckaddr_storage responder; /* address that answered (pin the connection to i=
t) */
 };
 
 /**
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_=
client=2Ec
index 1521ee3=2E=2E2b573aa 100644
--- a/src/openvpn/oob_client=
=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -38,6 +38,7 @@
 #include "otime=2E=
h"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "dco=2Eh"
 #incl=
ude "error=2Eh"
 
 #include "memdbg=2Eh"
@@ -217,6 +218,13 @@
         retu=
rn;
     }
 
+    /* The reply's own session id (the server's stateless SYN=
-cookie) follows the
+     * opcode byte=2E Capture it before read_control_=
auth() strips it: a client may
+     * reuse it to skip to the third handsh=
ake packet (the connect_lifetime
+     * shortcut)=2E */
+    struct sessio=
n_id server_sid;
+    memcpy(server_sid=2Eid, data + 1, SID_SIZE);
+
     s=
truct buffer buf;
     buf_set_read(&buf, data, (size_t)len);
 
@@ -275,6 +=
283,10 @@
         results[i]=2Eweight =3D reply=2Eweight;
         results=
[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;
         results[i]=2E=
rtt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
+        results[i]=2Eserver_si=
d =3D server_sid;
+        results[i]=2Econnect_lifetime =3D reply=2Econnec=
t_lifetime;
+        results[i]=2Ereply_flags =3D reply=2Eflags;
+        r=
esults[i]=2Eresponder =3D *from; /* pin the connection to the address that =
answered */
         break;
     }
 }
@@ -590,7 +602,6 @@
     {
         o=
ob_probe_collect(&pc, &probe, &client_sid, &tas->tls_wrap, targets, results=
, l->len);
     }
-    oob_probe_sockets_close(&pc);
 
     /* Log each rem=
ote's outcome while results[i] still maps to array[i]=2E */
     int respon=
ded =3D 0;
@@ -609,10 +620,10 @@
                                      : re=
sults[i]=2Emax_latency_diff > 0 ? "server-advertised"
                     =
                                                   : "default";
           =
  msg(D_LOW,
-                "server-probe: %s:%s answered (priority %d, w=
eight %d, rtt %u ms;"
-                " latency margin %d ms [%s])",
+    =
            "server-probe: %s:%s answered (priority %d, weight %d, connect-=
lifetime %d s,"
+                " rtt %u ms; latency margin %d ms [%s])",
=
                 ce->remote, ce->remote_port, results[i]=2Epriority, result=
s[i]=2Eweight,
-                results[i]=2Ertt_ms, margin, margin_src);
+=
                results[i]=2Econnect_lifetime, results[i]=2Ertt_ms, margin,=
 margin_src);
         }
         else
         {
@@ -634,6 +645,70 @@
    =
 msg(M_INFO, "server-probe: %d of %d remote(s) answered; connecting best-fi=
rst", responded,
         l->len);
 
+    /* Handshake shortcut: if the bes=
t remote (now l->array[0] / results[0])
+     * answered and advertised a c=
onnect_lifetime, hand its probe socket and the
+     * captured cookie/deta=
ils to the connection so it starts at the third packet
+     * (see session=
_skip_to_pre_start_client)=2E The winner's AF socket becomes the
+     * co=
nnection socket, preserving the source IP+port the server's cookie is
+    =
 * bound to=2E Not possible with dco-win (no user->kernel socket handoff), =
so
+     * skip the shortcut there; probing/ordering still applied above=2E=
 */
+    /* The RFC also requires the client to fall back to a full handsha=
ke once
+     * more than connect_lifetime seconds have elapsed since the p=
robe=2E We probe
+     * immediately before connecting (~0 s gap), so that =
check is a no-op today;
+     * add an elapsed-time guard here if probe res=
ults are ever cached and reused
+     * across reconnects=2E */
+    bool s=
hortcut =3D results[0]=2Eresponded && results[0]=2Econnect_lifetime > 0;
+ =
   bool dco_win_gate =3D false;
+#if defined(_WIN32)
+    if (dco_enabled(&=
c->options))
+    {
+        shortcut =3D false;
+        dco_win_gate =3D =
true;
+    }
+#endif
+    if (shortcut)
+    {
+        const int af_idx =
=3D probe_af_index(results[0]=2Eresponder=2Ess_family);
+        c->c2=2Eoo=
b_probe_sd =3D pc=2Esd[af_idx];
+        pc=2Esd[af_idx] =3D SOCKET_UNDEFIN=
ED; /* relinquish: the connection owns it now */
+
+        CLEAR(c->c2=2Eo=
ob_probe_remote);
+        if (results[0]=2Eresponder=2Ess_family =3D=3D AF=
_INET)
+        {
+            c->c2=2Eoob_probe_remote=2Eaddr=2Ein4 =3D *(=
struct sockaddr_in *)(void *)&results[0]=2Eresponder;
+        }
+        e=
lse
+        {
+            c->c2=2Eoob_probe_remote=2Eaddr=2Ein6 =3D *(str=
uct sockaddr_in6 *)(void *)&results[0]=2Eresponder;
+        }
+        c->=
c2=2Eoob_probe_client_sid =3D client_sid;
+        c->c2=2Eoob_probe_server=
_sid =3D results[0]=2Eserver_sid;
+        c->c2=2Eoob_probe_resend_wkc =3D=

+            (results[0]=2Ereply_flags & OOB_PROBE_REPLY_FLAG_RESEND_WKC) =
!=3D 0;
+        c->c2=2Eoob_probe_adopt =3D true;
+
+        msg(D_LOW, "s=
erver-probe: using handshake shortcut to %s:%s (connect-lifetime %d s)",
+ =
           l->array[0]->remote, l->array[0]->remote_port, results[0]=2Econn=
ect_lifetime);
+    }
+    else if (results[0]=2Eresponded)
+    {
+       =
 /* A server answered but we won't take the shortcut -- say why=2E */
+    =
    if (dco_win_gate)
+        {
+            msg(D_LOW, "server-probe: han=
dshake shortcut unavailable with dco-win;"
+                       " using =
a full handshake");
+        }
+        else if (results[0]=2Econnect_lifet=
ime =3D=3D 0)
+        {
+            msg(D_LOW, "server-probe: %s:%s did n=
ot offer a handshake shortcut"
+                       " (connect-lifetime =
0); using a full handshake",
+                l->array[0]->remote, l->array=
[0]->remote_port);
+        }
+    }
+
+    /* Close any probe sockets we d=
id not hand off to the connection=2E */
+    oob_probe_sockets_close(&pc);
=
+
     tls_auth_standalone_free(tas);
     gc_free(&gc);
 }
diff --git a/sr=
c/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index e5a1d76=2E=2E69eec10 =
100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -249,=
6 +249,9 @@
     bool oob_probe_adopt;
     socket_descriptor_t oob_probe_s=
d;
     struct openvpn_sockaddr oob_probe_remote;
+    struct session_id oo=
b_probe_client_sid;  /* our probe session id (cookie was minted over it) */=

+    struct session_id oob_probe_server_sid;  /* the reply's session id =
=3D server cookie to echo back */
+    bool oob_probe_resend_wkc;          =
     /* reply asked to complete with CONTROL_WKC_V1 (v2) */
 
     struct l=
ink_socket_actual *to_link_addr; /* IP address of remote */
     struct lin=
k_socket_actual from;          /* address of incoming datagram */
diff --gi=
t a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 60df7ce=2E=2E5b34856 10=
0644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2516,6 +2516,5=
9 @@
     return session_move_pre_start(session, ks, true);
 }
 
+bool
+ses=
sion_skip_to_pre_start_client(struct tls_session *session, const struct ses=
sion_id *client_sid,
+                                 const struct session=
_id *server_sid,
+                                 const struct openvpn_soc=
kaddr *remote, bool resend_wkc)
+{
+    struct key_state *ks =3D &session->=
key[KS_PRIMARY];
+
+    /* Our session id must be the one used for the prob=
e: the server's cookie
+     * (server_sid) is an HMAC over it, and the ser=
ver re-derives and checks it
+     * when it validates our (shortcut) third=
 packet=2E */
+    session->session_id =3D *client_sid;
+    ks->session_id=
_remote =3D *server_sid;
+
+    struct link_socket_actual act =3D { 0 };
+ =
   act=2Edest =3D *remote;
+    ks->remote_addr =3D act;
+    session->untr=
usted_addr =3D act;
+    session->burst =3D true;
+
+    /* tls-crypt-v2: t=
he stateless server discarded the WKc after the probe, so
+     * complete =
the handshake with P_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E */=

+    if (resend_wkc)
+    {
+        ks->crypto_options=2Eflags |=3D CO_RE=
SEND_WKC;
+    }
+
+    /* We never received the server's HARD_RESET (id 0)=
 =E2=80=94 the probe reply stood
+     * in for it=2E Acknowledge that phan=
tom id 0 so our third packet carries an
+     * ACK together with the serve=
r session id (the cookie): reliable_ack_write()
+     * only emits that ses=
sion id when at least one ACK is present, and the server
+     * needs it t=
o validate the stateless cookie=2E */
+    reliable_ack_acknowledge_packet_=
id(ks->rec_ack, 0);
+
+    /* Skip one (RESET) packet in each direction, so=
 ids start at 1 (see
+     * session_skip_to_pre_start)=2E */
+    ks->rec_=
reliable->packet_id =3D 1;
+    session->tls_wrap=2Eopt=2Epacket_id=2Esend=
=2Eid =3D 1;
+
+    /* Do not send our own HARD_RESET=2E Unlike the server'=
s skip, the client must
+     * send first: the stateless server only repli=
es once it sees our third
+     * packet=2E session_move_pre_start(skip=3Dt=
rue) leaves us in S_PRE_START_SKIP,
+     * which only advances when a pack=
et is *received*; instead drop to
+     * S_PRE_START with an empty send-re=
liable (the initial packet was generated
+     * and immediately deleted), =
so tls_process() promotes us to S_START and
+     * sends the ClientHello w=
ithout waiting for a server reset=2E */
+    if (!session_move_pre_start(se=
ssion, ks, true))
+    {
+        return false;
+    }
+    ks->state =3D S=
_PRE_START;
+    return true;
+}
+
 /**
  * Parses the TLVs (type, length, =
value) in the early negotiation
  */
diff --git a/src/openvpn/ssl=2Eh b/src=
/openvpn/ssl=2Eh
index 7ddf965=2E=2E14d3680 100644
--- a/src/openvpn/ssl=2E=
h
+++ b/src/openvpn/ssl=2Eh
@@ -576,4 +576,21 @@
 bool session_skip_to_pre_=
start(struct tls_session *session, struct tls_pre_decrypt_state *state,
   =
                             struct link_socket_actual *from);
 
+/**
+ * C=
lient counterpart of session_skip_to_pre_start(): start the handshake at th=
e
+ * third packet using a server session id (SYN-cookie) learned earlier f=
rom an
+ * OOB server probe reply, instead of sending our own HARD_RESET=2E=
 Saves one RTT=2E
+ *
+ * @param session     the (client) TLS session to fa=
st-forward
+ * @param client_sid  session id used for the probe (the cookie=
 is an HMAC over it)
+ * @param server_sid  the server's cookie, echoed bac=
k to complete the handshake
+ * @param remote      the probed (pinned) serv=
er address to connect to
+ * @param resend_wkc  true to complete with P_CON=
TROL_WKC_V1 (tls-crypt-v2)
+ * @return true if the session was fast-forward=
ed, false on failure
+ */
+bool session_skip_to_pre_start_client(struct tls=
_session *session,
+                                      const struct sess=
ion_id *client_sid,
+                                      const struct ses=
sion_id *server_sid,
+                                      const struct op=
envpn_sockaddr *remote, bool resend_wkc);
+
 #endif /* ifndef OPENVPN_SSL_H=
 */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I454d5040cba=
d4d373ee4f90b8d683200d2a4c0e4
Gerrit-Change-Number: 1770
Gerrit-PatchSet: 6=

Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--pjAcWrGjywY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #6</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1770?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: clie=
nt handshake shortcut via a server probe<br><br>When the best remote answer=
ed a probe and advertised a connect_lifetime, the<br>client now skips its o=
wn three-way handshake and starts at the third packet,<br>reusing the probe=
 reply as the server&#39;s HARD_RESET (its session id is a valid<br>statele=
ss SYN-cookie)=2E Saves one RTT on connect=2E<br><br>  - oob_client=2Ec: on=
 a shortcut-capable winner, hand its probe socket, the<br>    captured serv=
er session id (cookie), our probe session id, the pinned<br>    responder a=
ddress, and the resend-wkc flag to the connection via c2;<br>    relinquish=
 that socket (do not close it); gate off for dco-win, which has<br>    no u=
ser-to-kernel socket handoff (probing still works, only the shortcut is<br>=
    skipped)=2E<br>  - ssl=2Ec session_skip_to_pre_start_client(): seed our=
 session id to the probe&#39;s<br>    (the cookie is an HMAC over it), the =
remote session id to the cookie, ack<br>    the phantom server reset (id 0)=
 so the third packet carries the cookie, set<br>    CO_RESEND_WKC for tls-c=
rypt-v2, and drop to S_PRE_START so tls_process()<br>    promotes to S_STAR=
T and sends the ClientHello (no HARD_RESET sent)=2E<br>  - init=2Ec: invoke=
 the client skip after tls_multi_init_finalize when adopting=2E<br><br>Chan=
ge-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4<br>Signed-off-by: Lev Stip=
akov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Erst<br>M src/openvpn/i=
nit=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M src/o=
penvpn/openvpn=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>7 f=
iles changed, 177 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/6<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/Changes=2Erst b/Changes=2Erst</span><br><span>index 08=
0d928=2E=2E0fad132 100644</span><br><span>--- a/Changes=2Erst</span><br><sp=
an>+++ b/Changes=2Erst</span><br><span>@@ -9,6 +9,11 @@</span><br><span>   =
  measured latency and advertised weight with DNS-SRV-like semantics=2E</sp=
an><br><span>     Servers advertise these values with ``--server-probe-repl=
y``=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+Handshake shortcut for probing clients</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    A probing client reuses the probe reply to skip=
 one round trip of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   the three-way handshake when the chosen server advertises support</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for it=2E This needs n=
o extra configuration=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> </span><br><span> Overview of changes in 2=2E7</span=
><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/ope=
nvpn/init=2Ec</span><br><span>index 8eca6f7=2E=2Efc44f41 100644</span><br><=
span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec<=
/span><br><span>@@ -3505,6 +3505,21 @@</span><br><span>         /* Keep the=
 max mtu also in the frame of tls multi so it can access</span><br><span>  =
        * it in push_peer_info */</span><br><span>         c-&gt;c2=2Etls_m=
ulti-&gt;opt=2Eframe=2Etun_max_mtu =3D c-&gt;c2=2Eframe=2Etun_max_mtu;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* OOB server-probe handshake sho=
rtcut: the probe reply already served as</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         * the server&#39;s HARD_RESET (it carried a v=
alid SYN-cookie), so skip our</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * own reset exchange and start the handshake at the thir=
d packet=2E Count</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * the reply as the initial packet received (as the server does befor=
e its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * own=
 session_skip_to_pre_start), so tls_initial_packet_received() is true</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * and check_serv=
er_poll_timeout() does not restart a connected session=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=2Eoob_probe_a=
dopt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Et=
ls_multi-&gt;n_sessions++;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            session_skip_to_pre_start_client(&amp;c-&gt;c2=2Etls_mul=
ti-&gt;session[TM_ACTIVE],</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                             &amp;c-&gt;c2=2Eoob_pro=
be_client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                        &amp;c-&gt;c2=2Eoob_probe_server_si=
d, &amp;c-&gt;c2=2Eoob_probe_remote,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                             c-&gt;c2=2Eoo=
b_probe_resend_wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span>     }</span><br><span>     if (c-&gt;c2=2Etls_a=
uth_standalone)</span><br><span>     {</span><br><span>diff --git a/src/ope=
nvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 015a405=2E=2Ecf22f=
5c 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/s=
rc/openvpn/oob=2Eh</span><br><span>@@ -248,6 +248,11 @@</span><br><span>   =
  uint16_t weight;</span><br><span>     uint16_t max_latency_diff; /* margi=
n advertised by this server (ms); 0 =3D use client default */</span><br><sp=
an>     unsigned int rtt_ms;       /* probe round-trip time in ms (responde=
rs only) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* C=
aptured from the reply for the handshake shortcut (responders only): */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id s=
erver_sid;      /* the reply&#39;s own session id =3D server SYN-cookie */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t connect=
_lifetime;         /* seconds the reply is valid as a shortcut; 0 =3D none =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t repl=
y_flags;              /* OOB_PROBE_REPLY_FLAG_* advertised by the server */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr=
_storage responder; /* address that answered (pin the connection to it) */<=
/span><br><span> };</span><br><span> </span><br><span> /**</span><br><span>=
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span>=
<br><span>index 1521ee3=2E=2E2b573aa 100644</span><br><span>--- a/src/openv=
pn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><b=
r><span>@@ -38,6 +38,7 @@</span><br><span> #include &quot;otime=2Eh&quot;</=
span><br><span> #include &quot;fdmisc=2Eh&quot;</span><br><span> #include &=
quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;dco=2Eh&quot;</span><br><span> #include &quot;error=2Eh&qu=
ot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</spa=
n><br><span>@@ -217,6 +218,13 @@</span><br><span>         return;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* The reply&#39;s own session id (the server&#39;s statele=
ss SYN-cookie) follows the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * opcode byte=2E Capture it before read_control_auth() strips i=
t: a client may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * reuse it to skip to the third handshake packet (the connect_lifetime</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * shortcut)=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_i=
d server_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    me=
mcpy(server_sid=2Eid, data + 1, SID_SIZE);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     struct buffer buf;</span><br><=
span>     buf_set_read(&amp;buf, data, (size_t)len);</span><br><span> </spa=
n><br><span>@@ -275,6 +283,10 @@</span><br><span>         results[i]=2Eweig=
ht =3D reply=2Eweight;</span><br><span>         results[i]=2Emax_latency_di=
ff =3D reply=2Emax_latency_diff;</span><br><span>         results[i]=2Ertt_=
ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        results[i]=2Eserver_sid =3D server_sid;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Econ=
nect_lifetime =3D reply=2Econnect_lifetime;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        results[i]=2Ereply_flags =3D reply=2Eflags;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=
=2Eresponder =3D *from; /* pin the connection to the address that answered =
*/</span><br><span>         break;</span><br><span>     }</span><br><span> =
}</span><br><span>@@ -590,7 +602,6 @@</span><br><span>     {</span><br><spa=
n>         oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, &amp;tas=
-&gt;tls_wrap, targets, results, l-&gt;len);</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    oob_probe_sockets_close(&=
amp;pc);</span><br><span> </span><br><span>     /* Log each remote&#39;s ou=
tcome while results[i] still maps to array[i]=2E */</span><br><span>     in=
t responded =3D 0;</span><br><span>@@ -609,10 +620,10 @@</span><br><span>  =
                                    : results[i]=2Emax_latency_diff &gt; 0 =
? &quot;server-advertised&quot;</span><br><span>                           =
                                             : &quot;default&quot;;</span><=
br><span>             msg(D_LOW,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                &quot;server-probe: %s:%s answered (priority %d,=
 weight %d, rtt %u ms;&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                &quot; latency margin %d ms [%s])&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                &quot;server-pr=
obe: %s:%s answered (priority %d, weight %d, connect-lifetime %d s,&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot=
; rtt %u ms; latency margin %d ms [%s])&quot;,</span><br><span>            =
     ce-&gt;remote, ce-&gt;remote_port, results[i]=2Epriority, results[i]=
=2Eweight,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     results[i]=2Ertt_ms, margin, margin_src);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                results[i]=2Econnect_lifetime, r=
esults[i]=2Ertt_ms, margin, margin_src);</span><br><span>         }</span><=
br><span>         else</span><br><span>         {</span><br><span>@@ -634,6=
 +645,70 @@</span><br><span>     msg(M_INFO, &quot;server-probe: %d of %d r=
emote(s) answered; connecting best-first&quot;, responded,</span><br><span>=
         l-&gt;len);</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Handshake shortcut: if the best remote (now l-&gt=
;array[0] / results[0])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * answered and advertised a connect_lifetime, hand its probe socke=
t and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cap=
tured cookie/details to the connection so it starts at the third packet</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (see session_ski=
p_to_pre_start_client)=2E The winner&#39;s AF socket becomes the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * connection socket, pres=
erving the source IP+port the server&#39;s cookie is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * bound to=2E Not possible with dco-=
win (no user-&gt;kernel socket handoff), so</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * skip the shortcut there; probing/ordering st=
ill applied above=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* The RFC also requires the client to fall back to a full handshak=
e once</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * more t=
han connect_lifetime seconds have elapsed since the probe=2E We probe</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * immediately before=
 connecting (~0 s gap), so that check is a no-op today;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * add an elapsed-time guard here i=
f probe results are ever cached and reused</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * across reconnects=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool shortcut =3D results[0]=2Erespon=
ded &amp;&amp; results[0]=2Econnect_lifetime &gt; 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool dco_win_gate =3D false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;c-&=
gt;options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        shortcut =3D =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_w=
in_gate =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (shortcut)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const int af_idx =3D probe_af_index(r=
esults[0]=2Eresponder=2Ess_family);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        pc=2Esd[af_idx] =
=3D SOCKET_UNDEFINED; /* relinquish: the connection owns it now */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        CLEAR(c-&gt;c2=2Eoob_probe_remote);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (results[0]=
=2Eresponder=2Ess_family =3D=3D AF_INET)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            c-&gt;c2=2Eoob_probe_remote=2Eaddr=2Ein4 =3D *(struc=
t sockaddr_in *)(void *)&amp;results[0]=2Eresponder;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            c-&gt;c2=2Eoob_probe_remote=2Eaddr=2Ein6 =3D *(struct so=
ckaddr_in6 *)(void *)&amp;results[0]=2Eresponder;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_client_sid =3D client_sid;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2E=
oob_probe_server_sid =3D results[0]=2Eserver_sid;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_resend_wkc =3D</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (results[=
0]=2Ereply_flags &amp; OOB_PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_ad=
opt =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;=
server-probe: using handshake shortcut to %s:%s (connect-lifetime %d s)&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            l-&g=
t;array[0]-&gt;remote, l-&gt;array[0]-&gt;remote_port, results[0]=2Econnect=
_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (results[0=
]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* A server=
 answered but we won&#39;t take the shortcut -- say why=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (dco_win_gate)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-p=
robe: handshake shortcut unavailable with dco-win;&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                       &quot; using a =
full handshake&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else if (results[0]=2Econnect_lifetime =3D=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s did no=
t offer a handshake shortcut&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                       &quot; (connect-lifetime 0); using a =
full handshake&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                l-&gt;array[0]-&gt;remote, l-&gt;array[0]-&gt;remote_port=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Close any probe sockets we did not hand off to the co=
nnection=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
ob_probe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     tls_auth_standalone_free(tas);</span><br=
><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>diff --git=
 a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index =
e5a1d76=2E=2E69eec10 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</=
span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -249,6 +249=
,9 @@</span><br><span>     bool oob_probe_adopt;</span><br><span>     socke=
t_descriptor_t oob_probe_sd;</span><br><span>     struct openvpn_sockaddr o=
ob_probe_remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct session_id oob_probe_client_sid;  /* our probe session id (cookie w=
as minted over it) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct session_id oob_probe_server_sid;  /* the reply&#39;s session i=
d =3D server cookie to echo back */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool oob_probe_resend_wkc;               /* reply asked=
 to complete with CONTROL_WKC_V1 (v2) */</span><br><span> </span><br><span>=
     struct link_socket_actual *to_link_addr; /* IP address of remote */</s=
pan><br><span>     struct link_socket_actual from;          /* address of i=
ncoming datagram */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/=
openvpn/ssl=2Ec</span><br><span>index 60df7ce=2E=2E5b34856 100644</span><br=
><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec<=
/span><br><span>@@ -2516,6 +2516,59 @@</span><br><span>     return session_=
move_pre_start(session, ks, true);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pre_start_client(struc=
t tls_session *session, const struct session_id *client_sid,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                 c=
onst struct session_id *server_sid,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                 const struct openvpn_socka=
ddr *remote, bool resend_wkc)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Our session id must be the one used for the probe: t=
he server&#39;s cookie</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * (server_sid) is an HMAC over it, and the server re-derives and ch=
ecks it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * when =
it validates our (shortcut) third packet=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    session-&gt;session_id =3D *client_sid;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;session_id_re=
mote =3D *server_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_s=
ocket_actual act =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    act=2Edest =3D *remote;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ks-&gt;remote_addr =3D act;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    session-&gt;untrusted_addr =3D act;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;burst =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* tls-crypt-v2: the stateless=
 server discarded the WKc after the probe, so</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * complete the handshake with P_CONTROL_WKC_=
V1 (drives control_packet_needs_wkc)=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (resend_wkc)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        ks-&gt;crypto_options=2Eflags |=3D CO_RESEND_WKC;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* We never received the server&#39;s HARD_RESET (id 0) =
=E2=80=94 the probe reply stood</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * in for it=2E Acknowledge that phantom id 0 so our third =
packet carries an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * ACK together with the server session id (the cookie): reliable_ack_wri=
te()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only emi=
ts that session id when at least one ACK is present, and the server</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * needs it to validate=
 the stateless cookie=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    reliable_ack_acknowledge_packet_id(ks-&gt;rec_ack, 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Skip one (RESET) packet in each directio=
n, so ids start at 1 (see</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * session_skip_to_pre_start)=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ks-&gt;rec_reliable-&gt;packet_id =3D 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;tls_wrap=
=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Do not send our own HARD_RESET=2E Unlike the server&#39;s skip, the c=
lient must</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * se=
nd first: the stateless server only replies once it sees our third</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * packet=2E session_mov=
e_pre_start(skip=3Dtrue) leaves us in S_PRE_START_SKIP,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * which only advances when a packe=
t is *received*; instead drop to</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * S_PRE_START with an empty send-reliable (the initial pa=
cket was generated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * and immediately deleted), so tls_process() promotes us to S_START and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * sends the Cl=
ientHello without waiting for a server reset=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!session_move_pre_start(session, ks,=
 true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;state =3D S_PRE_START;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Par=
ses the TLVs (type, length, value) in the early negotiation</span><br><span=
>  */</span><br><span>diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2E=
h</span><br><span>index 7ddf965=2E=2E14d3680 100644</span><br><span>--- a/s=
rc/openvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2Eh</span><br><spa=
n>@@ -576,4 +576,21 @@</span><br><span> bool session_skip_to_pre_start(stru=
ct tls_session *session, struct tls_pre_decrypt_state *state,</span><br><sp=
an>                                struct link_socket_actual *from);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Client counterpart of=
 session_skip_to_pre_start(): start the handshake at the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * third packet using a server session=
 id (SYN-cookie) learned earlier from an</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * OOB server probe reply, instead of sending our own =
HARD_RESET=2E Saves one RTT=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram session     the (client) TLS session to fast-forward</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param client_sid  session id used =
for the probe (the cookie is an HMAC over it)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param server_sid  the server&#39;s cookie, ec=
hoed back to complete the handshake</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param remote      the probed (pinned) server address to=
 connect to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m resend_wkc  true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the sess=
ion was fast-forwarded, false on failure</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool session_skip_to_pre_start_client(struct tls_session *session,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
               const struct session_id *client_sid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                      con=
st struct session_id *server_sid,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                      const struct openvpn_so=
ckaddr *remote, bool resend_wkc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> #endif /* ifndef OPENVPN_SSL_H */</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1770?usp=3Demail">change 1770</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8=
d683200d2a4c0e4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
770 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--pjAcWrGjywY=--


--===============7615210995115701877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7615210995115701877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7615210995115701877==--

