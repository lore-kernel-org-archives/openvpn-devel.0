Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3ECC88E5E
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=grYWxhEp/STvb5Aa6UtoKH9AnFfQjNb5/F4IiM7PJvU=; b=GOhC5xZVMeNmafV18QPtsuYqjR
	vyY2dqWrNYPk9BRR6dyZ+lufEzHYOJsVIS6mMswkS3VujRUt0/8SODeQ0Ez7caNXfRmscUaHGGu27
	TkiNcqTiHUmYS9/i7WNDabURH3/9n0qrwAZoDjUeLn2PjFpixuV7iAK27y56YSvZfeUo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x536w-0008Jk-Sa;
	Fri, 11 Sep 2026 15:24:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x536q-0008IW-7H
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AczktQiiQ708QsxLAmwJuU95f0CGYF8nNq4NM4tK2Y8=; b=Gdo41wOiJ8gUj1+8EGS+u3cA+u
 SFBbTcif+yz6hxN37IK4qVdylVtR1yFITWG741oqCAkBEn7jn756Jzb//b/dMdHFR5+u0RenrEAig
 UpG+8O8Cqm8MtOtfVWSTsMlulllSqYR2mLuppjYgHNnlNs7zL6nzSk/ABkOMOMfzBWOo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AczktQiiQ708QsxLAmwJuU95f0CGYF8nNq4NM4tK2Y8=; b=A
 1kbTbWeaBUSseoWg15sngjtAhBk9HWTvNH89kmYdzEe/03UU1nqbnio/nTr0oWfdTpOwU0UcrOqdl
 KH8zg0Raf1lbTtFVTL9yxlJEPCo9DJb78ThAPm6HtICepzq9FuENsC77fiGYRskBA8dxpyiKz1pjS
 QvJB7QnuqMJ761Y4=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x536K-00019N-Uh for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:46 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4956869750eso9541575e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140214; x=1789745014; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AczktQiiQ708QsxLAmwJuU95f0CGYF8nNq4NM4tK2Y8=;
 b=Xpo41BxaGFfaSRq4tF1WNOgqyiTKjXP09RsPJTg4//3tQ0aLBL6wIdP3SQMblTd7HR
 Jaw+vR+WtKdNG5VSrqq7nOGzrKJRQANtEBbad2UqteZvwh3MwFP4MRsXp3ARFSGjHKFG
 ScQoO43PgVkuk4d1+3lpMPzXSwKP3bD0o9UAwlYKnZU+nEF1bJmzR/Pd+0pItyvOlml7
 4KJ5q5G+D8nNBzfsbpRKBlZ1rLT3ziIpClFy2Ze9cY0Qcas0Jd6uLjT8f/RKT9gFvGQ1
 XSPOlV8xkuKAKxXWO2djfa0we4Qt9738+PnrKRATVB4ShXMATJtAfM6dMlK+8y68mULy
 Bzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140214; x=1789745014;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AczktQiiQ708QsxLAmwJuU95f0CGYF8nNq4NM4tK2Y8=;
 b=kp+xnHLsxeq5RKPt8B7MYQKn93iSvY1GHxfCnXS04SsXwRDTsoFZqARKG5sYnoSd/i
 X+Rt/n3TZmx8WRee7RYpsuVl7C6lZrpmfoDszh9S2nmzHfLvhg0rrXUijr4op3OGvQDb
 RNZQbCZQwJvt6wsEnzNCJbzzprFU+pua8E4mE0Uu5JoW9sUl+8t4CG9YsG4eT7MwvFCz
 +OdZ1Il5LN5bq+9CNbLwHL+Tlz7dldM0Sgvi41l3lXpFi2i/4X7utIoYsHb2GMTd3+da
 BCg6dmd/ph8kjbsf+Va35X9TCa2b7o2uOrMtDw2cHWRa6Rzq/Q6FPetJ1+TW2xDt+vFz
 g+8Q==
X-Gm-Message-State: AFuF++maiFEqycG/uHlU1Isj753994rZ7vmIIeemultOoFm+3jxBd2/x
 tb/aD+szma1qtsAXbPiVtq4UhXi0WW1VN6/p8ALvQlsCswijBGiqOB4rfMeU7rBJ5YjabKiR5Xp
 4QRW6kj8nzapo8nyapvfSkzNBpGC9IT2vZzmzEhc40QJdQE/8NHc5hA0IFssn3tepeYp/
X-Gm-Gg: AYBFou1OgG4FPoGMcCrd1aeVeeRz6DcXbeinqfYe23vlVkFxBPJd6rYRW8P+3poeRtO
 YQKpBogpsQrvL6QC0LyhfdxTLq36IwIEZGoo5VOtw7MCnVZI4FCoIjgD7uIvV8Y+UmnHI+bA/XL
 h3C/kPJWKsz/TsQRGoHbWmPNO5fKyTodxRbgdqLYvm67PflBmAV/8BwV4wTYfFEDQ+wly6x8KkH
 nNgu/Zmq29tOX57CRLVgJzQvMwSLi3DcPPOqfPWDl9CGCQyTeUg16Ie/j8a/AaB5vRMmKIrNYQY
 RaxCgdX02bcO5E53niyrE0cb/Kt0kZAInVC101gTCnJOTa7/XeqV43KxYh/DE0F6c9ZAqBXm9M9
 BZ77Dw3MjH7+iDrtmaPBtNXPapbtAO4ECTMzGGjPM3KDcIsFMJhdI5tbIS3jIgEduVWGqZCztVB
 g5dzq+ZyzrpK6S6WZcDN+XWeuube91qRnJqfoiY71ekzM2M8e/WZNAC+3f70Ksja//n/7GqA54A
 WopE1dbUnD/dV6BUjStXO8z45V7XAeKptiW9RInht3566A0Kt4KRH0yRFf87yV1jjL8gBY5Ks63
 T5VMx3s7xF7WcU2E4iu6RWYCUDvta9oT1wW/CFEljfxL3598WN/fo3wSX3PhCz2yHS9Nd2Ve
X-Received: by 2002:a05:600c:c490:b0:49c:ffde:45ff with SMTP id
 5b1f17b1804b1-49e619c18e0mr56416585e9.17.1789140214137; 
 Fri, 11 Sep 2026 08:23:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm6996687f8f.27.2026.09.11.08.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:23:33 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:23:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: 54150d727f9a1391e12f7f28682c823dd5d9d5da
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7eb0fecf136405edd70adb677ae196b2b0037476-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x536K-00019N-Uh
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: start the
 client handshake from the server probe
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
Content-Type: multipart/mixed; boundary="===============0344470529323612497=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0344470529323612497==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gt1DgBqhHVg="; charset=UTF-8

--gt1DgBqhHVg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#16)=2E
=


Change subject: oob: start the client handshake from the server probe
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: start the c=
lient handshake from the server probe

When the best remote answered a prob=
e and advertised a connect_lifetime,
its reply also served as the server's =
HARD_RESET: its session id is a
valid stateless SYN-cookie=2E The client th=
erefore starts the handshake
from that reply instead of running its own res=
et exchange=2E

Note this does not shorten the handshake itself -- the prob=
e and its
reply take the place of the two reset packets rather than removin=
g them=2E
The saving is one RTT compared with probing and then connecting; =
a
client that does not probe is unaffected=2E

  - oob_client=2Ec: when the=
 winner advertised a connect_lifetime, hand
    its probe socket, the captu=
red server session id (cookie), our probe
    session id, the pinned respon=
der address, and the resend-wkc flag to
    the connection via c2; relinqui=
sh that socket (do not close it);
    gate off for dco-win, which has no us=
er-to-kernel socket handoff
    (probing still works, only starting from th=
e reply is skipped)=2E
  - ssl=2Ec session_skip_to_pre_start_client(): seed=
 our session id to the
    probe's (the cookie is an HMAC over it), the rem=
ote session id to
    the cookie, ack the phantom server reset (id 0) so th=
e third packet
    carries the cookie, set CO_RESEND_WKC for tls-crypt-v2, =
and drop to
    S_PRE_START so tls_process() promotes to S_START and sends =
the
    ClientHello (no HARD_RESET sent)=2E
  - init=2Ec: invoke the client=
 skip after tls_multi_init_finalize when
    adopting, and count the probe =
reply as the initial packet received
    (n_sessions++, as the server does =
before its own
    session_skip_to_pre_start) so check_server_poll_timeout(=
) does not
    restart the connected session=2E

Change-Id: I454d5040cbad4d=
373ee4f90b8d683200d2a4c0e4
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
=
---
M Changes=2Erst
M src/openvpn/init=2Ec
M src/openvpn/oob=2Eh
M src/open=
vpn/oob_client=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/ssl=2Ec
M src/op=
envpn/ssl=2Eh
7 files changed, 172 insertions(+), 10 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/16

dif=
f --git a/Changes=2Erst b/Changes=2Erst
index 080d928=2E=2E4d7a16c9 100644
=
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -9,6 +9,13 @@
     measured late=
ncy and advertised weight with DNS-SRV-like semantics=2E
     Servers adver=
tise these values with ``--server-probe-reply``=2E
 
+Probe exchange double=
s as the start of the handshake
+    When a probing client picks a server t=
hat advertises support for it,
+    the probe and its reply take the place =
of the client's and server's
+    reset packets, so the client does not nee=
d a separate reset exchange
+    before the handshake=2E This saves one rou=
nd trip compared with probing
+    and then connecting, and needs no extra =
configuration=2E
+
 
 Overview of changes in 2=2E7
 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/src/=
openvpn/init=2Ec b/src/openvpn/init=2Ec
index ea85bad=2E=2E81562a7 100644
-=
-- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3483,6 +3483,21 @@=

         /* Keep the max mtu also in the frame of tls multi so it can acce=
ss
          * it in push_peer_info */
         c->c2=2Etls_multi->opt=2Efr=
ame=2Etun_max_mtu =3D c->c2=2Eframe=2Etun_max_mtu;
+
+        /* OOB server=
 probe: the probe reply already served as the server's
+         * HARD_RES=
ET (it carried a valid SYN-cookie), so the handshake starts
+         * fro=
m that reply and we send no reset of our own=2E Count
+         * the reply=
 as the initial packet received (as the server does before its
+         * =
own session_skip_to_pre_start), so tls_initial_packet_received() is true
+ =
        * and check_server_poll_timeout() does not restart a connected sess=
ion=2E */
+        if (c->c2=2Eoob_probe_adopt)
+        {
+            c->=
c2=2Etls_multi->n_sessions++;
+            session_skip_to_pre_start_client=
(&c->c2=2Etls_multi->session[TM_ACTIVE],
+                                 =
            &c->c2=2Eoob_probe_client_sid,
+                               =
              &c->c2=2Eoob_probe_server_sid, &c->c2=2Eoob_probe_remote,
+  =
                                           c->c2=2Eoob_probe_resend_wkc);
+=
        }
     }
     if (c->c2=2Etls_auth_standalone)
     {
diff --git a/=
src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 9fde094=2E=2E5568177 100644=

--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -192,8 +192,11 @@
 =
{
     int index;
     bool responded;
-    unsigned int rtt_ms;          /=
* probe round-trip time in ms (responders only) */
-    struct oob_probe_re=
ply reply; /* the values the server advertised */
+    unsigned int rtt_ms;=
 /* probe round-trip time in ms (responders only) */
+    /* Captured from =
the packet and its reply TLV (responders only): */
+    struct session_id s=
erver_sid;      /* the packet's own session id =3D server SYN-cookie */
+  =
  struct openvpn_sockaddr responder; /* address that answered (pin the conn=
ection to it) */
+    struct oob_probe_reply reply;      /* the values the =
server advertised */
 };
 
 /* Where the client probed one connection entry=
: its resolved addresses=2E */
diff --git a/src/openvpn/oob_client=2Ec b/sr=
c/openvpn/oob_client=2Ec
index fb59104=2E=2Edd9e3c6a 100644
--- a/src/openv=
pn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -38,6 +38,7 @@
 #incl=
ude "otime=2Eh"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "dc=
o=2Eh"
 #include "error=2Eh"
 
 #include "memdbg=2Eh"
@@ -343,6 +344,13 @@
=
         return;
     }
 
+    /* The reply's own session id (the server's =
stateless SYN-cookie) follows the
+     * opcode byte=2E Capture it before =
read_control_auth() strips it: a client may
+     * reuse it to start the h=
andshake from this reply (the connect_lifetime
+     * advertisement)=2E */=

+    struct session_id server_sid;
+    memcpy(server_sid=2Eid, data + 1, =
SID_SIZE);
+
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)=
len);
 
@@ -386,6 +394,8 @@
 
         results[i]=2Eresponded =3D true;
   =
      results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
+        res=
ults[i]=2Eserver_sid =3D server_sid;
+        results[i]=2Eresponder =3D *f=
rom; /* pin the connection to the address that answered */
         results=
[i]=2Ereply =3D reply;
 
         i =3D oob_probe_next_target_at(from, targ=
ets, results, n, i + 1);
@@ -753,11 +763,6 @@
         oob_probe_collect(&p=
c, &probe, &client_sid, &tas->tls_wrap, targets, results, l->len,
         =
                  c->sig);
     }
-    oob_probe_sockets_close(&pc);
-    i=
f (bind_local)
-    {
-        freeaddrinfo(bind_local);
-    }
 
     /* L=
og each remote's outcome while results[i] still maps to array[i]=2E */
    =
 int responded =3D 0;
@@ -773,10 +778,10 @@
             int margin =3D oob=
_effective_margin(&results[i], client_margin);
             const char *mar=
gin_src =3D client_margin >=3D 0 ? "client" : "server-advertised";
        =
     msg(D_LOW,
-                "server-probe: %s:%s answered (priority %d=
, weight %d, rtt %u ms;"
-                " latency margin %d ms [%s])",
+ =
               "server-probe: %s:%s answered (priority %d, weight %d, conne=
ct-lifetime %d s,"
+                " rtt %u ms; latency margin %d ms [%s])=
",
                 ce->remote, ce->remote_port, results[i]=2Ereply=2Eprior=
ity, results[i]=2Ereply=2Eweight,
-                results[i]=2Ertt_ms, mar=
gin, margin_src);
+                results[i]=2Ereply=2Econnect_lifetime, r=
esults[i]=2Ertt_ms, margin, margin_src);
         }
         else
         =
{
@@ -798,6 +803,65 @@
     msg(M_INFO, "server-probe: %d of %d remote(s) a=
nswered; connecting best-first", responded,
         l->len);
 
+    /* If =
the winner advertised a connect_lifetime, its reply also served as the
+   =
  * server's reset: hand its probe socket and the captured cookie to the
+ =
    * connection, which then starts the handshake from that reply (see
+   =
  * session_skip_to_pre_start_client)=2E Reusing that socket keeps the sour=
ce
+     * IP+port the cookie is bound to=2E dco-win cannot hand a socket t=
o the
+     * kernel, so it only gets the probe ordering=2E */
+
+    /* Si=
ngle-use, so the RFC's connect_lifetime expiry check is not needed yet:
+  =
   * we probe once (c->first_time) and arm only results[0]=2E */
+    bool =
probe_start =3D results[0]=2Eresponded && results[0]=2Ereply=2Econnect_life=
time > 0;
+    bool dco_win_gate =3D false;
+#if defined(_WIN32)
+    if (d=
co_enabled(&c->options))
+    {
+        probe_start =3D false;
+        dc=
o_win_gate =3D true;
+    }
+#endif
+    if (probe_start)
+    {
+        c=
onst int af_idx =3D probe_af_index(results[0]=2Eresponder=2Eaddr=2Esa=2Esa_=
family);
+        c->c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];
+        pc=2Es=
d[af_idx] =3D SOCKET_UNDEFINED; /* relinquish: the connection owns it now *=
/
+
+        c->c2=2Eoob_probe_remote =3D results[0]=2Eresponder;
+        =
c->c2=2Eoob_probe_client_sid =3D client_sid;
+        c->c2=2Eoob_probe_ser=
ver_sid =3D results[0]=2Eserver_sid;
+        c->c2=2Eoob_probe_resend_wkc =
=3D
+            (results[0]=2Ereply=2Eflags & OOB_PROBE_REPLY_FLAG_RESEND_=
WKC) !=3D 0;
+        c->c2=2Eoob_probe_adopt =3D true;
+
+        msg(D_LO=
W, "server-probe: starting handshake from probe reply of %s:%s"
+          =
         " (connect-lifetime %d s)",
+            l->array[0]->remote, l->a=
rray[0]->remote_port, results[0]=2Ereply=2Econnect_lifetime);
+    }
+    e=
lse if (results[0]=2Eresponded)
+    {
+        /* A server answered but we=
 won't start the handshake from it -- say why=2E */
+        if (dco_win_ga=
te)
+        {
+            msg(D_LOW, "server-probe: cannot start the hand=
shake from a probe reply"
+                       " with dco-win;"
+       =
                " using a full handshake");
+        }
+        else if (re=
sults[0]=2Ereply=2Econnect_lifetime =3D=3D 0)
+        {
+            msg(D=
_LOW, "server-probe: %s:%s did not advertise a connect-lifetime"
+         =
              " (connect-lifetime 0); using a full handshake",
+           =
     l->array[0]->remote, l->array[0]->remote_port);
+        }
+    }
+
+ =
   /* Close any probe sockets we did not hand off to the connection=2E */
+=
    oob_probe_sockets_close(&pc);
+
+    if (bind_local)
+    {
+        fr=
eeaddrinfo(bind_local);
+    }
     oob_probe_free_wrap(c, tas);
     gc_fr=
ee(&gc);
 }
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
=
index 09c6a3c=2E=2E238eba2 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/o=
penvpn/openvpn=2Eh
@@ -250,6 +250,9 @@
     bool oob_probe_adopt;
     sock=
et_descriptor_t oob_probe_sd;
     struct openvpn_sockaddr oob_probe_remote=
;
+    struct session_id oob_probe_client_sid;  /* our probe session id (co=
okie was minted over it) */
+    struct session_id oob_probe_server_sid;  /=
* the reply's session id =3D server cookie to echo back */
+    bool oob_pr=
obe_resend_wkc;               /* reply asked to complete with CONTROL_WKC_V=
1 (v2) */
 
     struct link_socket_actual *to_link_addr; /* IP address of =
remote */
     struct link_socket_actual from;          /* address of incom=
ing datagram */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
inde=
x c8fc465=2E=2Eccd5fda 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/s=
sl=2Ec
@@ -2569,6 +2569,59 @@
     return session_move_pre_start(session, k=
s, true);
 }
 
+bool
+session_skip_to_pre_start_client(struct tls_session *=
session, const struct session_id *client_sid,
+                            =
     const struct session_id *server_sid,
+                                =
 const struct openvpn_sockaddr *remote, bool resend_wkc)
+{
+    struct key=
_state *ks =3D &session->key[KS_PRIMARY];
+
+    /* Our session id must be =
the one used for the probe: the server's cookie
+     * (server_sid) is an =
HMAC over it, and the server re-derives and checks it
+     * when it valid=
ates our third packet=2E */
+    session->session_id =3D *client_sid;
+    =
ks->session_id_remote =3D *server_sid;
+
+    struct link_socket_actual act=
 =3D { 0 };
+    act=2Edest =3D *remote;
+    ks->remote_addr =3D act;
+   =
 session->untrusted_addr =3D act;
+    session->burst =3D true;
+
+    /* t=
ls-crypt-v2: the stateless server discarded the WKc after the probe, so
+  =
   * complete the handshake with P_CONTROL_WKC_V1 (drives control_packet_ne=
eds_wkc)=2E */
+    if (resend_wkc)
+    {
+        ks->crypto_options=2Efl=
ags |=3D CO_RESEND_WKC;
+    }
+
+    /* We never received the server's HAR=
D_RESET (id 0) -- the probe reply stood
+     * in for it=2E Acknowledge th=
at phantom id 0 so our third packet carries an
+     * ACK together with th=
e server session id (the cookie): reliable_ack_write()
+     * only emits t=
hat session id when at least one ACK is present, and the server
+     * nee=
ds it to validate the stateless cookie=2E */
+    reliable_ack_acknowledge_=
packet_id(ks->rec_ack, 0);
+
+    /* Skip one (RESET) packet in each direct=
ion, so ids start at 1 (see
+     * session_skip_to_pre_start)=2E */
+    k=
s->rec_reliable->packet_id =3D 1;
+    session->tls_wrap=2Eopt=2Epacket_id=
=2Esend=2Eid =3D 1;
+
+    /* Do not send our own HARD_RESET=2E Unlike the =
server's skip, the client must
+     * send first: the stateless server onl=
y replies once it sees our third
+     * packet=2E session_move_pre_start(s=
kip=3Dtrue) leaves us in S_PRE_START_SKIP,
+     * which only advances when=
 a packet is *received*; instead drop to
+     * S_PRE_START with an empty =
send-reliable (the initial packet was generated
+     * and immediately del=
eted), so tls_process() promotes us to S_START and
+     * sends the Client=
Hello without waiting for a server reset=2E */
+    if (!session_move_pre_s=
tart(session, ks, true))
+    {
+        return false;
+    }
+    ks->stat=
e =3D S_PRE_START;
+    return true;
+}
+
 /**
  * Parses the TLVs (type, l=
ength, value) in the early negotiation
  */
diff --git a/src/openvpn/ssl=2E=
h b/src/openvpn/ssl=2Eh
index 7ddf965=2E=2Ea534007 100644
--- a/src/openvpn=
/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -576,4 +576,21 @@
 bool session_skip_=
to_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *sta=
te,
                                struct link_socket_actual *from);
 
+/*=
*
+ * Client counterpart of session_skip_to_pre_start(): start the handshak=
e from a
+ * server session id (SYN-cookie) learned earlier from an OOB ser=
ver probe
+ * reply, which already served as the server's HARD_RESET, so we=
 send none=2E
+ *
+ * @param session     the (client) TLS session to fast-f=
orward
+ * @param client_sid  session id used for the probe (the cookie is =
an HMAC over it)
+ * @param server_sid  the server's cookie, echoed back to=
 complete the handshake
+ * @param remote      the probed (pinned) server a=
ddress to connect to
+ * @param resend_wkc  true to complete with P_CONTROL=
_WKC_V1 (tls-crypt-v2)
+ * @return true if the session was fast-forwarded, =
false on failure
+ */
+bool session_skip_to_pre_start_client(struct tls_ses=
sion *session,
+                                      const struct session_=
id *client_sid,
+                                      const struct session=
_id *server_sid,
+                                      const struct openvp=
n_sockaddr *remote, bool resend_wkc);
+
 #endif /* ifndef OPENVPN_SSL_H */
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I454d5040cbad4d=
373ee4f90b8d683200d2a4c0e4
Gerrit-Change-Number: 1770
Gerrit-PatchSet: 16
G=
errit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--gt1DgBqhHVg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #16</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1770?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: sta=
rt the client handshake from the server probe<br><br>When the best remote a=
nswered a probe and advertised a connect_lifetime,<br>its reply also served=
 as the server&#39;s HARD_RESET: its session id is a<br>valid stateless SYN=
-cookie=2E The client therefore starts the handshake<br>from that reply ins=
tead of running its own reset exchange=2E<br><br>Note this does not shorten=
 the handshake itself -- the probe and its<br>reply take the place of the t=
wo reset packets rather than removing them=2E<br>The saving is one RTT comp=
ared with probing and then connecting; a<br>client that does not probe is u=
naffected=2E<br><br>  - oob_client=2Ec: when the winner advertised a connec=
t_lifetime, hand<br>    its probe socket, the captured server session id (c=
ookie), our probe<br>    session id, the pinned responder address, and the =
resend-wkc flag to<br>    the connection via c2; relinquish that socket (do=
 not close it);<br>    gate off for dco-win, which has no user-to-kernel so=
cket handoff<br>    (probing still works, only starting from the reply is s=
kipped)=2E<br>  - ssl=2Ec session_skip_to_pre_start_client(): seed our sess=
ion id to the<br>    probe&#39;s (the cookie is an HMAC over it), the remot=
e session id to<br>    the cookie, ack the phantom server reset (id 0) so t=
he third packet<br>    carries the cookie, set CO_RESEND_WKC for tls-crypt-=
v2, and drop to<br>    S_PRE_START so tls_process() promotes to S_START and=
 sends the<br>    ClientHello (no HARD_RESET sent)=2E<br>  - init=2Ec: invo=
ke the client skip after tls_multi_init_finalize when<br>    adopting, and =
count the probe reply as the initial packet received<br>    (n_sessions++, =
as the server does before its own<br>    session_skip_to_pre_start) so chec=
k_server_poll_timeout() does not<br>    restart the connected session=2E<br=
><br>Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4<br>Signed-off-by:=
 Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Erst<br>M src/=
openvpn/init=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<b=
r>M src/openvpn/openvpn=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=
=2Eh<br>7 files changed, 172 insertions(+), 10 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/70/1770/16</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/Changes=2Erst b/Changes=2Erst</span><br><=
span>index 080d928=2E=2E4d7a16c9 100644</span><br><span>--- a/Changes=2Erst=
</span><br><span>+++ b/Changes=2Erst</span><br><span>@@ -9,6 +9,13 @@</span=
><br><span>     measured latency and advertised weight with DNS-SRV-like se=
mantics=2E</span><br><span>     Servers advertise these values with ``--ser=
ver-probe-reply``=2E</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+Probe exchange doubles as the start of the handshake</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    When a probing clie=
nt picks a server that advertises support for it,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    the probe and its reply take the place of=
 the client&#39;s and server&#39;s</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    reset packets, so the client does not need a separate re=
set exchange</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bef=
ore the handshake=2E This saves one round trip compared with probing</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    and then connecting, a=
nd needs no extra configuration=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> </span><br><span> Overview of changes in 2=
=2E7</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index ea85bad=2E=2E81562a7 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -3483,6 +3483,21 @@</span><br><span>      =
   /* Keep the max mtu also in the frame of tls multi so it can access</spa=
n><br><span>          * it in push_peer_info */</span><br><span>         c-=
&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Etun_max_mtu =3D c-&gt;c2=2Eframe=2Etun=
_max_mtu;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* OOB server probe: =
the probe reply already served as the server&#39;s</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * HARD_RESET (it carried a valid SY=
N-cookie), so the handshake starts</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * from that reply and we send no reset of our own=
=2E Count</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 the reply as the initial packet received (as the server does before its</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * own session=
_skip_to_pre_start), so tls_initial_packet_received() is true</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * and check_server_poll_=
timeout() does not restart a connected session=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=2Eoob_probe_adopt)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_mult=
i-&gt;n_sessions++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            session_skip_to_pre_start_client(&amp;c-&gt;c2=2Etls_multi-&gt;=
session[TM_ACTIVE],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                             &amp;c-&gt;c2=2Eoob_probe_clie=
nt_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                 &amp;c-&gt;c2=2Eoob_probe_server_sid, &amp=
;c-&gt;c2=2Eoob_probe_remote,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                             c-&gt;c2=2Eoob_probe=
_resend_wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span>     }</span><br><span>     if (c-&gt;c2=2Etls_auth_sta=
ndalone)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/oo=
b=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 9fde094=2E=2E5568177 1006=
44</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/open=
vpn/oob=2Eh</span><br><span>@@ -192,8 +192,11 @@</span><br><span> {</span><=
br><span>     int index;</span><br><span>     bool responded;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    unsigned int rtt_ms;          /=
* probe round-trip time in ms (responders only) */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct oob_probe_reply reply; /* the value=
s the server advertised */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int rtt_ms; /* probe round-trip time in ms (responders =
only) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Capt=
ured from the packet and its reply TLV (responders only): */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct session_id server_sid; =
     /* the packet&#39;s own session id =3D server SYN-cookie */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr re=
sponder; /* address that answered (pin the connection to it) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply repl=
y;      /* the values the server advertised */</span><br><span> };</span><b=
r><span> </span><br><span> /* Where the client probed one connection entry:=
 its resolved addresses=2E */</span><br><span>diff --git a/src/openvpn/oob_=
client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index fb59104=2E=2E=
dd9e3c6a 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br>=
<span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -38,6 +38,7 @@</s=
pan><br><span> #include &quot;otime=2Eh&quot;</span><br><span> #include &qu=
ot;fdmisc=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;dco=2Eh&quo=
t;</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span>@@ -343,6 +344,1=
3 @@</span><br><span>         return;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The reply=
&#39;s own session id (the server&#39;s stateless SYN-cookie) follows the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * opcode byte=2E=
 Capture it before read_control_auth() strips it: a client may</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * reuse it to start the han=
dshake from this reply (the connect_lifetime</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * advertisement)=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id server_sid;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(server_sid=2Eid,=
 data + 1, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     struct buffer buf;</span><br><span>     buf_set_rea=
d(&amp;buf, data, (size_t)len);</span><br><span> </span><br><span>@@ -386,6=
 +394,8 @@</span><br><span> </span><br><span>         results[i]=2Eresponde=
d =3D true;</span><br><span>         results[i]=2Ertt_ms =3D (ms &gt; 0) ? =
(unsigned int)ms : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        results[i]=2Eserver_sid =3D server_sid;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        results[i]=2Eresponder =3D *from; /* =
pin the connection to the address that answered */</span><br><span>        =
 results[i]=2Ereply =3D reply;</span><br><span> </span><br><span>         i=
 =3D oob_probe_next_target_at(from, targets, results, n, i + 1);</span><br>=
<span>@@ -753,11 +763,6 @@</span><br><span>         oob_probe_collect(&amp;=
pc, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wrap, targets, results, l=
-&gt;len,</span><br><span>                           c-&gt;sig);</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    oob_p=
robe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (bind_local)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fre=
eaddrinfo(bind_local);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span> </span><br><span>     /* Log each remote&#39;s outc=
ome while results[i] still maps to array[i]=2E */</span><br><span>     int =
responded =3D 0;</span><br><span>@@ -773,10 +778,10 @@</span><br><span>    =
         int margin =3D oob_effective_margin(&amp;results[i], client_margin=
);</span><br><span>             const char *margin_src =3D client_margin &g=
t;=3D 0 ? &quot;client&quot; : &quot;server-advertised&quot;;</span><br><sp=
an>             msg(D_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                &quot;server-probe: %s:%s answered (priority %d, weigh=
t %d, rtt %u ms;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                &quot; latency margin %d ms [%s])&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                &quot;server-probe: %=
s:%s answered (priority %d, weight %d, connect-lifetime %d s,&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot; rtt =
%u ms; latency margin %d ms [%s])&quot;,</span><br><span>                 c=
e-&gt;remote, ce-&gt;remote_port, results[i]=2Ereply=2Epriority, results[i]=
=2Ereply=2Eweight,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             results[i]=2Ertt_ms, margin, margin_src);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                results[i]=2Ereply=2Econ=
nect_lifetime, results[i]=2Ertt_ms, margin, margin_src);</span><br><span>  =
       }</span><br><span>         else</span><br><span>         {</span><br=
><span>@@ -798,6 +803,65 @@</span><br><span>     msg(M_INFO, &quot;server-p=
robe: %d of %d remote(s) answered; connecting best-first&quot;, responded,<=
/span><br><span>         l-&gt;len);</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* If the winner advertised a connec=
t_lifetime, its reply also served as the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * server&#39;s reset: hand its probe socket and t=
he captured cookie to the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * connection, which then starts the handshake from that reply (s=
ee</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * session_sk=
ip_to_pre_start_client)=2E Reusing that socket keeps the source</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * IP+port the cookie is bo=
und to=2E dco-win cannot hand a socket to the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * kernel, so it only gets the probe ordering=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Single-use, so the RFC&#3=
9;s connect_lifetime expiry check is not needed yet:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * we probe once (c-&gt;first_time) a=
nd arm only results[0]=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool probe_start =3D results[0]=2Eresponded &amp;&amp; results=
[0]=2Ereply=2Econnect_lifetime &gt; 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool dco_win_gate =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;c-&gt;options))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        probe_start =3D false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_win_gate =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (probe_start)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const int af_idx =3D probe_af_index(result=
s[0]=2Eresponder=2Eaddr=2Esa=2Esa_family);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pc=2Esd[af_=
idx] =3D SOCKET_UNDEFINED; /* relinquish: the connection owns it now */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_remote =3D r=
esults[0]=2Eresponder;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        c-&gt;c2=2Eoob_probe_client_sid =3D client_sid;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_server_=
sid =3D results[0]=2Eserver_sid;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        c-&gt;c2=2Eoob_probe_resend_wkc =3D</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            (results[0]=2Ereply=2Eflag=
s &amp; OOB_PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_adopt =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: s=
tarting handshake from probe reply of %s:%s&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                   &quot; (connect-lifetime %=
d s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    l-&gt;array[0]-&gt;remote, l-&gt;array[0]-&gt;remote_port, results[0]=
=2Ereply=2Econnect_lifetime);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (results[0]=2Eresponded)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* A server answered but we won&#39;t start the handshake from it --=
 say why=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (dco_win_gate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(D_LOW, &quot;server-probe: cannot start the handshake from a probe r=
eply&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              &quot; with dco-win;&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                       &quot; using a full handshake&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (result=
s[0]=2Ereply=2Econnect_lifetime =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s did not advert=
ise a connect-lifetime&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                       &quot; (connect-lifetime 0); using a full h=
andshake&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            l-&gt;array[0]-&gt;remote, l-&gt;array[0]-&gt;remote_port);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Close any probe sockets we did not hand off to the connecti=
on=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_pro=
be_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bind=
_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(bind_=
local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span>     oob_probe_free_wrap(c, tas);</span><br><span>     gc_free(&a=
mp;gc);</span><br><span> }</span><br><span>diff --git a/src/openvpn/openvpn=
=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index 09c6a3c=2E=2E238eba2 1=
00644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/s=
rc/openvpn/openvpn=2Eh</span><br><span>@@ -250,6 +250,9 @@</span><br><span>=
     bool oob_probe_adopt;</span><br><span>     socket_descriptor_t oob_pro=
be_sd;</span><br><span>     struct openvpn_sockaddr oob_probe_remote;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id oob=
_probe_client_sid;  /* our probe session id (cookie was minted over it) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_i=
d oob_probe_server_sid;  /* the reply&#39;s session id =3D server cookie to=
 echo back */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol oob_probe_resend_wkc;               /* reply asked to complete with CONT=
ROL_WKC_V1 (v2) */</span><br><span> </span><br><span>     struct link_socke=
t_actual *to_link_addr; /* IP address of remote */</span><br><span>     str=
uct link_socket_actual from;          /* address of incoming datagram */</s=
pan><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span>=
<br><span>index c8fc465=2E=2Eccd5fda 100644</span><br><span>--- a/src/openv=
pn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -25=
69,6 +2569,59 @@</span><br><span>     return session_move_pre_start(session=
, ks, true);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+session_skip_to_pre_start_client(struct tls_session *session=
, const struct session_id *client_sid,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                 const struct session_id=
 *server_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                           const struct openvpn_sockaddr *remote, bool rese=
nd_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct key_state *ks =3D &=
amp;session-&gt;key[KS_PRIMARY];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 Our session id must be the one used for the probe: the server&#39;s cookie=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (server_sid)=
 is an HMAC over it, and the server re-derives and checks it</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * when it validates our third=
 packet=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    se=
ssion-&gt;session_id =3D *client_sid;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ks-&gt;session_id_remote =3D *server_sid;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct link_socket_actual act =3D { 0 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    act=2Edest =3D *remot=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;remote=
_addr =3D act;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ession-&gt;untrusted_addr =3D act;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    session-&gt;burst =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* tls-crypt-v2: the stateless server discarded the WKc after t=
he probe, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
complete the handshake with P_CONTROL_WKC_V1 (drives control_packet_needs_w=
kc)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (re=
send_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;crypto_op=
tions=2Eflags |=3D CO_RESEND_WKC;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We never rec=
eived the server&#39;s HARD_RESET (id 0) -- the probe reply stood</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * in for it=2E Acknowled=
ge that phantom id 0 so our third packet carries an</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * ACK together with the server sessi=
on id (the cookie): reliable_ack_write()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * only emits that session id when at least one AC=
K is present, and the server</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * needs it to validate the stateless cookie=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    reliable_ack_acknowledge_pa=
cket_id(ks-&gt;rec_ack, 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip=
 one (RESET) packet in each direction, so ids start at 1 (see</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * session_skip_to_pre_start)=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;re=
c_reliable-&gt;packet_id =3D 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    session-&gt;tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Do not send our own HARD_RESET=2E=
 Unlike the server&#39;s skip, the client must</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * send first: the stateless server only rep=
lies once it sees our third</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * packet=2E session_move_pre_start(skip=3Dtrue) leaves us in S=
_PRE_START_SKIP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * which only advances when a packet is *received*; instead drop to</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * S_PRE_START with an=
 empty send-reliable (the initial packet was generated</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * and immediately deleted), so tls_=
process() promotes us to S_START and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * sends the ClientHello without waiting for a server =
reset=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!session_move_pre_start(session, ks, true))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ks-&gt;state =3D S_PRE_START;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /**</span><br><span>  * Parses the TLVs (type, length, value) in t=
he early negotiation</span><br><span>  */</span><br><span>diff --git a/src/=
openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=2Ea5=
34007 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ =
b/src/openvpn/ssl=2Eh</span><br><span>@@ -576,4 +576,21 @@</span><br><span>=
 bool session_skip_to_pre_start(struct tls_session *session, struct tls_pre=
_decrypt_state *state,</span><br><span>                                stru=
ct link_socket_actual *from);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Client counterpart of session_skip_to_pre_start(): start the=
 handshake from a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 server session id (SYN-cookie) learned earlier from an OOB server probe</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reply, which alread=
y served as the server&#39;s HARD_RESET, so we send none=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param session     the (client) TLS session to fa=
st-forward</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 client_sid  session id used for the probe (the cookie is an HMAC over it)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server_sid=
  the server&#39;s cookie, echoed back to complete the handshake</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param remote      the prob=
ed (pinned) server address to connect to</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param resend_wkc  true to complete with P_CONTROL_=
WKC_V1 (tls-crypt-v2)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return true if the session was fast-forwarded, false on failure</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool session_skip_to_pre_start_client(str=
uct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                      const struct session_id *client=
_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                        const struct session_id *server_sid,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
    const struct openvpn_sockaddr *remote, bool resend_wkc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef=
 OPENVPN_SSL_H */</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail">change 177=
0</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I454d5040cbad4d373ee4f90b8d683200d2a4c0e4 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1770 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--gt1DgBqhHVg=--


--===============0344470529323612497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0344470529323612497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0344470529323612497==--

