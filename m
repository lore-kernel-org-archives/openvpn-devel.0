Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE0ACA5FC9
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VpIvayO0DyeKholKdaAmGY2rcuQ9X5FlGISqp3lnim8=; b=KlT1WvnsSNI+zUCieTge+fQaph
	ssXz43NQ2BEo3PPs7itm3vwg4OKMfbYuIpaLJ7FDeFWwdkFarPbS8+qeKQSZ5ZhtI1/nH+daHMOWb
	ogyhGIU3cmSkfIpcPi1sjj5e8ikBSY2EQPU8QO8ujHprWUkKZ0FTzJayaOWNfLuAKLeQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeA-0001YS-Js;
	Wed, 30 Sep 2026 08:26:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpe1-0001X8-2n
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YO8kqI8lZPa4q3T6AIe7cV5Mum/j1pldF/Voh13WwFo=; b=BZ2GyJHR1nTbbpRAyryNIO+ycT
 Ob679Y8g6u2LT5Cg+disdjI3R5tXg1KA5WZKcvh7A7K0Adi07A4XN1jMQOG7mPVugvt0rUJO1jAWD
 FCjMh7Y79G7lU0rK5t0WKYJ/D52c6Tcl1R7pcIPvG3p77S2yk+Aqr24E+FDAFtA5LBp4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YO8kqI8lZPa4q3T6AIe7cV5Mum/j1pldF/Voh13WwFo=; b=I
 6oFktjhPaZaw0Q481TN5JK+6MjFZJ5UzN/Hk3dDpsKthsdeMH9OzTcjSJkqWbvwDXnmlp/1xBJj2b
 VGhR1eEna6TsDXXzXsp8lcfGwwHVMyXneaLMmGiq53cMrDdQaZwx+Qze0ay/oBmxWGJG2kgL4TYcl
 E/XgxAYvQ9M+VndY=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdx-0005pB-LL for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:29 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4887f6cf16bso3158761f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756779; x=1791361579; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YO8kqI8lZPa4q3T6AIe7cV5Mum/j1pldF/Voh13WwFo=;
 b=MVrCqP8rc/gN3kH3h1gluaC+CFCywrwMnOazU9zp5Pchos/gmEGSYSFoMcM2qmsOmE
 2FmlLh/tQRm+ro6RBI4N2K5fQppUVH7vBCWdAjAXtMccmCXBClOfTO2qpcAOkMpoaBEn
 O0JTltJKMQITiqeypdGE4iqqHC537UqbW4XMeEnfEQGt/qNeeC4DAOSMmMqHF4SlF4nW
 H3sNjcn2QBE16cQAjEdzEWsBs5GA4fcnF7fojqetTNTkAG54OlIduD1363F6srN9GQYN
 cunCKLn1/hmGupL14PzMrIDyYKtufXjrWpOqc3a6tnleykfevV72+tzAPoeyGclVsIRt
 dDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756779; x=1791361579;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YO8kqI8lZPa4q3T6AIe7cV5Mum/j1pldF/Voh13WwFo=;
 b=Blp2kZ4tHl9ABDtmEbN9Z2zoQNv5SCUe4ZhFCmdcVmY8umRYGecVUocLy4CiyO3KkL
 rAl4bGHGvKlX3/sEZVj+cIBHJBqeVNhc07Hb2V9HAKWdeZgTsTInW6EyRihti/xp9SOG
 /TGv3JP7xs+3Gv9nw2wvpF70ekpjgBJD8Wyyg5cYufsygJtXPYeYyatIeDca4UrDXsdJ
 JWJnFeZb7958t+5jZD5Nx7FhoZpYm4iyNu4Oo730FpzlX9HBRUu5d0RVmcGM00u0On7U
 KWCxZQEoQwnphBESdSJvCwrLzchi/SGJs8PVpo4ivintckDvJrpwo1JBmg13vUYfQ1N1
 IIoQ==
X-Gm-Message-State: AFq9FYLQ9OFlt8KyCqenmSSm/+VMGDpvEzXJVnOJdMZ9jVv9yTT5EZ+7
 /hEHxonkhcCrtIFZbCNMzV6EylJRGgTXKOCWR+mDbehZpEVOEmRsf9Z23b1lMwSILCeUq0VIlga
 P5xOTRDkU3ia+EEp+YHrZDnbs2vouHpjOw/fm8C3XQhKYUsBXwwYz8zJc2DpBNY4nlRlV
X-Gm-Gg: AYBFou3uDYgv0KlNTt7ma5k3FO8pUFSnak036dTBHsm1ibngQgTd0IklIYCSbhyZTdK
 xPv+sxH2urKAHiY+wA+R+ic/4/iu5MtDVMKe72MuasdAnuQd4JUXhgoZ28FCjfbTtMVcHa96IyI
 h7l0/2B5kePXQldq1t0N56iZvPjovNhqdqvdG8b86hdQAx1a3XD7yeLxalExfmmWNGDdgIEvmB5
 ksIJYgTvExUDiZCNXp9ceKVKqv0k8DRhak7ZpR7RCwqB/dLHZKM588jEZmT0gf6GwC2b4xrFOkY
 lnCMgbCJRYXhc0a+tANtcEOicU626yBMfdEwZa4ow+eg++s7urnCKRJ2F0zzzd4ORoalYOdmTo5
 dZpz1UpyNyTdADN/Wy7/sUq/sN01Myx7NMQrWvQ1SDR8bph+eSzIzo5ohCWjOne+R0GleuqPR4l
 nEKfb/WFzUx76+OvbEXNfhIhmGxl5r7DhYFaOeYwxwzTDX0tna3VFgUzj9PZ32RDUQlwh77DELl
 3HdlGSJeueZs0MnpugPVeHjAZYxXeJY9cglgzwSmJ9Js+RU8ZLW67vWJdmmGX8O493FUuyuyXl5
 8WBuB2IlP5qAE14glsK9uYq0VlQ9XOhqonLsm/f2D86fLCNhFp88RrCpR4OAZck7OlS7YyY=
X-Received: by 2002:a5d:5e84:0:b0:48a:fba3:d5b1 with SMTP id
 ffacd0b85a97d-48b025753f5mr1283311f8f.55.1790756778955; 
 Wed, 30 Sep 2026 01:26:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02a00421sm1699257f8f.31.2026.09.30.01.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:18 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
X-Gerrit-Change-Number: 1771
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1771?usp=email>
X-Gerrit-Commit: 476297e8effb9384594bdcc8db53211319379073
In-Reply-To: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
References: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkljZWM0Njk2ZmYyNjNhYjM5ZWJhYjA2ZThkNDc4Mzk1YTVkZGZhYWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c9f725bc3c81c312c37d33c801aa8151d77c1b3b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdx-0005pB-LL
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Fall back
 quickly when a probe-started handshake is ignored
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
Content-Type: multipart/mixed; boundary="===============5974202430913461931=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5974202430913461931==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eMVnWJHIX78="; charset=UTF-8

--eMVnWJHIX78=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici, stipa=2E

Hello plaisthos,=
 ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail

to look at the new p=
atch set (#27)=2E


Change subject: oob: Fall back quickly when a probe-sta=
rted handshake is ignored
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

oob: Fall back quickly when a probe-started handshake is igno=
red

If the server does not accept the third packet of a handshake started
=
from a probe reply, the client stalled for the full handshake_window
(~60s)=
 before recovering=2E

In a normal handshake, no answer could mean the serv=
er is down, so
waiting is right=2E Here we know it is up, since it answered=
 a probe a
moment ago -- so no answer means it did not accept the reply as =
a reset,
and waiting 60s is pointless=2E That happens when a load balancer =
sends
the probe and the handshake to different instances, when NAT changes =
the
source port the cookie is bound to, or when the server restarted and
ro=
tated its session-id HMAC key=2E

Give such a session a short first-respons=
e deadline
(min(handshake_window, 5s)); once the server answers, tls_pre_de=
crypt()
restores the full window so a slow-but-working handshake is not cut=
 off=2E
If no response arrives the session times out quickly and the client=

restarts the attempt rather than retrying in place: the restart moves on
t=
o the next resolved address or connection entry, so the address that
answer=
ed the probe is not retried this cycle (with --persist-remote-ip
the restar=
t keeps it, as for any restart)=2E A rejected reply therefore
costs a few s=
econds instead of ~60=2E

Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfa=
ab9
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections/=
client-options=2Erst
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
3 f=
iles changed, 51 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/71/1771/27

diff --git a/doc/man-s=
ections/client-options=2Erst b/doc/man-sections/client-options=2Erst
index =
80f760f=2E=2Ee35de8c 100644
--- a/doc/man-sections/client-options=2Erst
+++=
 b/doc/man-sections/client-options=2Erst
@@ -660,7 +660,16 @@
   - the serv=
er honours its reply only for a limited time (see
     ``--server-probe-rep=
ly``), so an unusually slow start-up, such as a
     private key passphrase=
 or token prompt, can outlast it; the client
-    then falls back to a norm=
al handshake=2E
+    then falls back to a normal handshake;
+  - a handshak=
e started this way is given only a few seconds to draw a
+    response, rat=
her than ``--hand-window``=2E If none arrives the client
+    logs a key ne=
gotiation timeout, restarts the attempt and moves on to
+    the next addre=
ss or remote, so the address that answered the probe is
+    not retried du=
ring this cycle=2E The server answered a probe moments
+    earlier, so sil=
ence means it did not accept the reply as a reset,
+    which happens when =
a load balancer sends the probe and the handshake
+    to different instanc=
es, when NAT changes the source port, or when the
+    server rotated its s=
ession id key=2E
 
   The handshake shortcut is not used on Windows while D=
CO is active=2E
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
in=
dex 7d54130=2E=2E8f5e0d1 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn=
/ssl=2Ec
@@ -2588,6 +2588,11 @@
     return session_move_pre_start(session,=
 ks, true);
 }
 
+/* Seconds to wait for the server's first response to a p=
robe-started handshake
+ * before giving up and falling back to a normal ha=
ndshake=2E A couple of
+ * control-channel retransmits; capped at handshake=
_window by the caller=2E */
+#define OOB_PROBE_START_FALLBACK_SECS 5
+
 boo=
l
 session_skip_to_pre_start_client(struct tls_session *session, const stru=
ct session_id *client_sid,
                                  const struct s=
ession_id *server_sid,
@@ -2640,6 +2645,10 @@
         return false;
     }=

     ks->state =3D S_PRE_START;
+
+    /* Fail fast if the server ignores =
it: wait seconds, not handshake_window=2E
+     * tls_pre_decrypt() restore=
s the full window once the server answers=2E */
+    ks->oob_probe_start =
=3D true;
     return true;
 }
 
@@ -2880,12 +2889,31 @@
         continue_=
tls_process =3D session_move_pre_start(session, ks, false);
     }
 
+    /=
* Start the probe-started fallback clock only once our first control packet=

+     * is queued: opening the tun, plugin init and chroot all happen befo=
re that
+     * and must not be counted against a deadline meant for the se=
rver's reply=2E */
+    if (ks->oob_probe_start && !reliable_empty(ks->send=
_reliable))
+    {
+        const time_t deadline =3D
+            now + mi=
n_int(session->opt->handshake_window, OOB_PROBE_START_FALLBACK_SECS);
+    =
    if (ks->must_negotiate > deadline)
+        {
+            ks->must_neg=
otiate =3D deadline;
+        }
+    }
+
     /* Are we timed out on receiv=
e? */
     if (now >=3D ks->must_negotiate && ks->state >=3D S_UNDEF && ks-=
>state < S_ACTIVE)
     {
+        /* Report the window that actually appli=
ed: an unanswered probe-started
+         * handshake times out on the shor=
t fallback deadline, not
+         * handshake_window=2E */
+        int wi=
ndow =3D ks->oob_probe_start
+                         ? min_int(session->o=
pt->handshake_window, OOB_PROBE_START_FALLBACK_SECS)
+                     =
    : session->opt->handshake_window;
         msg(D_TLS_ERRORS,
          =
   "TLS Error: TLS key negotiation failed to occur within %d seconds (check=
 your network connectivity)",
-            session->opt->handshake_window);=

+            window);
         goto error;
     }
 
@@ -3997,6 +4025,16 @@=

         goto error;
     }
 
+    /* First valid response to a probe-star=
ted handshake: the server accepted it,
+     * so restore the normal negoti=
ation window (it was shortened to fail fast if
+     * the probe reply had =
been ignored)=2E Only after the source address matched,
+     * or any forg=
ed packet could re-arm the long window=2E */
+    if (ks->oob_probe_start)
=
+    {
+        ks->oob_probe_start =3D false;
+        ks->must_negotiate =
=3D now + session->opt->handshake_window;
+    }
+
     /*
      * Should w=
e do a retransmit of all unacknowledged packets in
      * the send buffer?=
  This improves the start-up efficiency of the
diff --git a/src/openvpn/ssl=
_common=2Eh b/src/openvpn/ssl_common=2Eh
index f6392f9=2E=2E905006c 100644
=
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -227,6=
 +227,8 @@
     time_t initial;                        /* when we created t=
his session */
     time_t established;                    /* when our stat=
e went S_ACTIVE */
     time_t must_negotiate;                 /* key negot=
iation times out if not finished before this time */
+    bool oob_probe_st=
art;                  /* probe-started handshake: must_negotiate is a short=

+                                            * first-response deadline, no=
t the full window */
     time_t must_die;                       /* this ob=
ject is destroyed at this time */
     time_t peer_last_packet;            =
   /* Last time we received a packet in this control session */
 

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icec4696ff263ab39ebab06e8=
d478395a5ddfaab9
Gerrit-Change-Number: 1771
Gerrit-PatchSet: 27
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2E=
com>

--eMVnWJHIX78=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #27</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1771?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">o=
ob: Fall back quickly when a probe-started handshake is ignored<br><br>If t=
he server does not accept the third packet of a handshake started<br>from a=
 probe reply, the client stalled for the full handshake_window<br>(~60s) be=
fore recovering=2E<br><br>In a normal handshake, no answer could mean the s=
erver is down, so<br>waiting is right=2E Here we know it is up, since it an=
swered a probe a<br>moment ago -- so no answer means it did not accept the =
reply as a reset,<br>and waiting 60s is pointless=2E That happens when a lo=
ad balancer sends<br>the probe and the handshake to different instances, wh=
en NAT changes the<br>source port the cookie is bound to, or when the serve=
r restarted and<br>rotated its session-id HMAC key=2E<br><br>Give such a se=
ssion a short first-response deadline<br>(min(handshake_window, 5s)); once =
the server answers, tls_pre_decrypt()<br>restores the full window so a slow=
-but-working handshake is not cut off=2E<br>If no response arrives the sess=
ion times out quickly and the client<br>restarts the attempt rather than re=
trying in place: the restart moves on<br>to the next resolved address or co=
nnection entry, so the address that<br>answered the probe is not retried th=
is cycle (with --persist-remote-ip<br>the restart keeps it, as for any rest=
art)=2E A rejected reply therefore<br>costs a few seconds instead of ~60=2E=
<br><br>Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9<br>Signed-off-=
by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-sections/cli=
ent-options=2Erst<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<=
br>3 files changed, 51 insertions(+), 2 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/17=
71/27</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/doc/man-sections/client-options=2Erst b/doc/man-=
sections/client-options=2Erst</span><br><span>index 80f760f=2E=2Ee35de8c 10=
0644</span><br><span>--- a/doc/man-sections/client-options=2Erst</span><br>=
<span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@@ -660,7=
 +660,16 @@</span><br><span>   - the server honours its reply only for a li=
mited time (see</span><br><span>     ``--server-probe-reply``), so an unusu=
ally slow start-up, such as a</span><br><span>     private key passphrase o=
r token prompt, can outlast it; the client</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    then falls back to a normal handshake=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    then falls back to a norm=
al handshake;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  - a =
handshake started this way is given only a few seconds to draw a</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    response, rather than ``--=
hand-window``=2E If none arrives the client</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    logs a key negotiation timeout, restarts the at=
tempt and moves on to</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    the next address or remote, so the address that answered the probe is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    not retried dur=
ing this cycle=2E The server answered a probe moments</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    earlier, so silence means it did not =
accept the reply as a reset,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    which happens when a load balancer sends the probe and the han=
dshake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to differ=
ent instances, when NAT changes the source port, or when the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    server rotated its session id =
key=2E</span><br><span> </span><br><span>   The handshake shortcut is not u=
sed on Windows while DCO is active=2E</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 7=
d54130=2E=2E8f5e0d1 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span>=
<br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2588,6 +2588,11 @@<=
/span><br><span>     return session_move_pre_start(session, ks, true);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* Seconds to wait for the server&#39;s first response to a pr=
obe-started handshake</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * before giving up and falling back to a normal handshake=2E A couple of=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control-channel =
retransmits; capped at handshake_window by the caller=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_START_FALLBACK_SE=
CS 5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> bool</span><br><span> session_skip_to_pre_start_client(struct tls_sessio=
n *session, const struct session_id *client_sid,</span><br><span>          =
                        const struct session_id *server_sid,</span><br><spa=
n>@@ -2640,6 +2645,10 @@</span><br><span>         return false;</span><br><=
span>     }</span><br><span>     ks-&gt;state =3D S_PRE_START;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Fail fast if the server ignores it: wait sec=
onds, not handshake_window=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * tls_pre_decrypt() restores the full window once the server=
 answers=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    k=
s-&gt;oob_probe_start =3D true;</span><br><span>     return true;</span><br=
><span> }</span><br><span> </span><br><span>@@ -2880,12 +2889,31 @@</span><=
br><span>         continue_tls_process =3D session_move_pre_start(session, =
ks, false);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Start the probe-started fallback c=
lock only once our first control packet</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * is queued: opening the tun, plugin init and chro=
ot all happen before that</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * and must not be counted against a deadline meant for the serve=
r&#39;s reply=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (ks-&gt;oob_probe_start &amp;&amp; !reliable_empty(ks-&gt;send_relia=
ble))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const time_t deadlin=
e =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            no=
w + min_int(session-&gt;opt-&gt;handshake_window, OOB_PROBE_START_FALLBACK_=
SECS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (k=
s-&gt;must_negotiate &gt; deadline)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            ks-&gt;must_negotiate =3D deadline;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     /* Are we timed out on receive? */</span><b=
r><span>     if (now &gt;=3D ks-&gt;must_negotiate &amp;&amp; ks-&gt;state =
&gt;=3D S_UNDEF &amp;&amp; ks-&gt;state &lt; S_ACTIVE)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Report=
 the window that actually applied: an unanswered probe-started</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * handshake times out o=
n the short fallback deadline, not</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * handshake_window=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        int window =3D ks-&gt;oob_probe_start<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
     ? min_int(session-&gt;opt-&gt;handshake_window, OOB_PROBE_START_FALLBA=
CK_SECS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
              : session-&gt;opt-&gt;handshake_window;</span><br><span>     =
    msg(D_TLS_ERRORS,</span><br><span>             &quot;TLS Error: TLS key=
 negotiation failed to occur within %d seconds (check your network connecti=
vity)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   session-&gt;opt-&gt;handshake_window);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            window);</span><br><span>         goto er=
ror;</span><br><span>     }</span><br><span> </span><br><span>@@ -3997,6 +4=
025,16 @@</span><br><span>         goto error;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
First valid response to a probe-started handshake: the server accepted it,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so restore th=
e normal negotiation window (it was shortened to fail fast if</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * the probe reply had been i=
gnored)=2E Only after the source address matched,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * or any forged packet could re-arm the =
long window=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (ks-&gt;oob_probe_start)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ks-&gt;oob_probe_start =3D false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ks-&gt;must_negotiate =3D now + session-&gt;opt-&=
gt;handshake_window;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     /*</span><br><span>      * Should we do a retransmit of all unackn=
owledged packets in</span><br><span>      * the send buffer?  This improves=
 the start-up efficiency of the</span><br><span>diff --git a/src/openvpn/ss=
l_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index f6392f9=2E=
=2E905006c 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><b=
r><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -227,6 +227,8 @=
@</span><br><span>     time_t initial;                        /* when we cr=
eated this session */</span><br><span>     time_t established;             =
       /* when our state went S_ACTIVE */</span><br><span>     time_t must_=
negotiate;                 /* key negotiation times out if not finished bef=
ore this time */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 bool oob_probe_start;                  /* probe-started handshake: must_ne=
gotiate is a short</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                           * first-response deadline, not t=
he full window */</span><br><span>     time_t must_die;                    =
   /* this object is destroyed at this time */</span><br><span>     time_t =
peer_last_packet;               /* Last time we received a packet in this c=
ontrol session */</span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail">change 1771</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icec4696ff263ab39=
ebab06e8d478395a5ddfaab9 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1771 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 27 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ral=
f@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--eMVnWJHIX78=--


--===============5974202430913461931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5974202430913461931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5974202430913461931==--

