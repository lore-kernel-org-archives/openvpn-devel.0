Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67641C88E73
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b3aIWeCtzUM5o2pGx1kpTw+6xIOFgaw32yLtwHTc+IY=; b=kZfijYI/LUNeKRMA1T1PIeOlYH
	dGCZr1Kna6J8WbaT1Vcfe7ircUm0oQ1Fc1sxnE01IGUuregokpjJD5ZkZiTzppuEfR8MaysKTGhv/
	ddGZQOqlLZVJqZH763SA0bvadDkLeSBgJDB8n3AtVymXvedP6i6rDchoCzf4uTk4BYyE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Wg-0006gf-Qx;
	Mon, 14 Sep 2026 14:19:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67Wf-0006gW-O2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m9u04mE/FbGxpfb7yXZXn4ISZfSYcbdEtTZ7hGtANoQ=; b=McOPn8W4hVA3+Z8pzm/zEi4XO0
 XqZNPhqpqUan4PjE5FMRDpk4cqQZL4oXFWI3EsyTQ8RomWuiA1Ib9kFg6Xuhiwz8trZwocZ6HUMDX
 3RKGj2cljiEZ4QGrNfcI4QsFlHeNwsxRhxdZhvSbxDEyHy8aI2tmG33asEWFemnnxkhY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m9u04mE/FbGxpfb7yXZXn4ISZfSYcbdEtTZ7hGtANoQ=; b=M
 bdFU4LDlQsi9MNOMM/qEvVSI4CCyj3bcGswyu8JA9adNxbT+euS/Zcb6k+eDhaaxR8i4MeVwVPqLw
 k8uNvvaDPv4msytfRBJWla6vbyRwWtaj/BousvQAAP6Df7Xag4iUOZyA1gtskdi8A1mLzhGQk/hEK
 SgVAIuUGd0r0PL4g=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WZ-0001Sn-H7 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:17 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca94bso10450865e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395545; x=1790000345; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m9u04mE/FbGxpfb7yXZXn4ISZfSYcbdEtTZ7hGtANoQ=;
 b=ZmzgGA8gKwtjHfIhVGE31+dGGo19znLIAya5BgMoZ5FBFiRJPnZaJOAt5V3kKq7/9C
 VjXgFr7PWgRw+yqjpWJXHu+1+yrcRkcBgF/jbGgjJLo0JegqjzgHF65KBrk/444bMOOv
 KlQkmrQi6hHtF2S4K8GC5/yKPfzzjX2M2bly0DvrS2K8LGW6NtDs9hUGO26Xce1oC7gN
 0kpHqqWx5TpbGKRvHvCeU7eFzK46xoVp2ENkZvUPd8g5bBx7MxFgXkjgoC9DJzNh8GCS
 fUa5A7GOKG3ytFsY7hgNi4UBOFj0Vdhwu3qbnU4Hvv66R3bQOMWb91Jc+d0Uw34XfD6k
 HArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395545; x=1790000345;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m9u04mE/FbGxpfb7yXZXn4ISZfSYcbdEtTZ7hGtANoQ=;
 b=FvfXHPLOw0b6ZBHTHR5b7ht4v1d2Xsx47I2t1nqukDbvECsck8uxJLMWcb78DJD2+M
 RgfbHMjNjBmmGdvJjpZ07cGpbYn5RSKxFNIRYk/VtylNwcBli29H/2Pt5kTqYT632HdS
 zyRkbX88AFmdN77i3XK2FvxcbzOzpFC1f0edniARObmVZdOOs8NL0djRIvXu3slo6PJx
 nPkXu8rx2AADcMl87ERcDDhI1umaHtE9JZ6iFHoADbfRmO0biQ9mFpK1sOs8SHec8m6C
 FA/HAyx8jSHLT/EneDGnHxxaLQNjfRUvo9lDdgc7LcXPVpRYumlh4P3dvOI/fTCsnFdN
 i98Q==
X-Gm-Message-State: AFuF++lqt6YzpfRQIhYcnQt9XV5idpsBgYi9wmSjW5FYNBv+2nD8S8VE
 0Ytj0c8bPywkb3o1nd+FGKsvRyGwlJElvSOUP6wRtDQor6XNF5erQ+Xsphtayw4dt49/HNrFSMH
 rccyzkCWDNM9X2xfo+GIKGXIH4DrjXeGd545GJSBeVkvC0KCcnLkdzqjKwJM21PxjwacP
X-Gm-Gg: AYBFou0e7lGXuNYxhBK0s6LrUxzrmLxqGR5KVpgyDnwFweFeon8LKdWR1YCIYXdfWzo
 d3Sn2Gcmqu/iNmE+htHDdKKSroDpPyaPBHEWnVO4FhMxxG2UCDDaC2JXsSgT6fOVKF5fjgzXB37
 3hi8FFuRUaHpfcLpWsLn+8RPaTbeapy5W6msN2QOSwNrdUaVZj/V6NyzU9PTwLhtvLjyhswk7sj
 95IgPEUktxhn4yS6GWVnKZ7B2xzUbOjcDAPH5WXUAhe3XGPtPsWXzqPXAzBIvWlcvJZDkGMhWOl
 moVdVNOQFfg1ugvDvjbLACRPW+tLi46jGvSgZ182tb6eQMKEWS9uU8ckHJ+aSXFYUQ6VTldffn/
 nL5UTcAfJA1j++HhfNF3ifnqcLxRvv6qVyz3/tiz20fDpayq9cZELpVlS2s2mycnLb6F95xU9T0
 K+ezIsrFlwPa/GGQFOvMbKYWqvAM6YzTTwG6K93TndOxzM75AjjJLvZvx1w9YN6t3SAh+pddVI+
 DCN4RW0FXRlZkneoy4r1JOBkiIj/UDhG5sbdl7T789t7p5CZxNLX80Q3nxwTSwzfv6Dx7UxWD5H
 McAE65m2FOOitvcd1pMc1+fxMIDXNmotzHd2+bqvDDFVCPIyUW20QR6gUrCjkw==
X-Received: by 2002:a05:600c:34d4:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49e7a637f39mr30527135e9.7.1789395544455; 
 Mon, 14 Sep 2026 07:19:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac411asm305951895e9.8.2026.09.14.07.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:19:00 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: 43645c205354c85bad18af559df53e73568a2070
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <66169fa6fb116e67fe797a59277df943c2fc41f6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WZ-0001Sn-H7
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: start the
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
Content-Type: multipart/mixed; boundary="===============0981404372172168858=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0981404372172168858==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OqvOwwpsVbU="; charset=UTF-8

--OqvOwwpsVbU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#18)=2E
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

Three things guard the sho=
rtcut=2E The reply's session id is rejected
unless it is defined: it become=
s the remote session id, and the phantom
ACK means reliable_ack_write() wou=
ld assert on an all-zero one, so a
server -- or, without tls-auth/tls-crypt=
, anyone who answers first --
could otherwise kill the client with a single=
 packet=2E

The probe socket and the cookie belong to the remote that answe=
red, so
both are given up unless next_connection_entry() selected that same=

remote=2E The entry is mapped by value and the management interface may
re=
write the copy, so the check compares the resulting host, port and
proxy se=
ttings rather than which entry was picked=2E

Finally, the server honours i=
ts reply only for the advertised
connect_lifetime, which a passphrase or to=
ken prompt during init can
outlast; the shortcut is dropped when it has ela=
psed=2E Steps after that
point fall to the short fallback deadline instead=
=2E

Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M Changes=2Emd
M doc/man-sections/client=
-options=2Erst
M src/openvpn/init=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/o=
ob_client=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn=
/ssl=2Eh
8 files changed, 281 insertions(+), 12 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/18

diff --g=
it a/Changes=2Emd b/Changes=2Emd
index cb85456=2E=2Efb92bef 100644
--- a/Ch=
anges=2Emd
+++ b/Changes=2Emd
@@ -10,6 +10,14 @@
   weight with DNS-SRV-lik=
e semantics=2E Servers advertise these values with
   `--server-probe-reply=
`=2E
 
+* **Probe exchange doubles as the start of the handshake**
+
+  Whe=
n a probing client picks a server that advertises support for it, the probe=

+  and its reply take the place of the client's and server's reset packets=
, so the
+  client does not need a separate reset exchange before the hands=
hake=2E This saves
+  one round trip compared with probing and then connect=
ing, and needs no extra
+  configuration=2E
+
 ## User-visible Changes
 
 *=
 **Parsing Distinguished Names in certificates**
diff --git a/doc/man-secti=
ons/client-options=2Erst b/doc/man-sections/client-options=2Erst
index 74ae=
59e=2E=2E23684a5 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/d=
oc/man-sections/client-options=2Erst
@@ -637,8 +637,34 @@
   whose timestam=
p is within its ``--hand-window`` of its own clock, so a
   client whose cl=
ock is badly wrong receives no replies and keeps the
   configured order=2E=
 Ordering by probe replaces any order that
-  ``--remote-random`` produced=
=2E See ``--server-probe-reply`` for the
-  server side=2E
+  ``--remote-ra=
ndom`` produced=2E
+
+  When the winning server supports it, the probe exch=
ange also starts the
+  handshake: its reply stands in for the server's res=
et packet, so the
+  client sends no reset of its own and the connection is=
 established one
+  round trip sooner=2E This has consequences worth knowin=
g:
+
+  - the connection reuses the probe's socket, and therefore its sourc=
e
+    port, which matters where firewall or NAT rules pin a port;
+  - the=
 connection is pinned to the address that answered, rather than
+    trying=
 that remote's resolved addresses in turn;
+  - the server honours its repl=
y only for a limited time (see
+    ``--server-probe-reply``), so an unusua=
lly slow start-up, such as a
+    private key passphrase or token prompt, c=
an outlast it; the client
+    then falls back to a normal handshake;
+  - =
a handshake started this way is given only a few seconds to draw a
+    res=
ponse, rather than ``--hand-window``=2E If none arrives the client
+    log=
s a key negotiation timeout, restarts the attempt and moves on to
+    the =
next address or remote, so that server is not retried during this
+    cycl=
e=2E The server answered a probe moments earlier, so silence means
+    it =
did not accept the reply as a reset, which happens when a load
+    balance=
r sends the probe and the handshake to different instances,
+    when NAT c=
hanges the source port, or when the server rotated its
+    session id key=
=2E
+
+  The handshake shortcut is not used on Windows while DCO is active=
=2E
+
+  See ``--server-probe-reply`` for the server side=2E
 
 --static-ch=
allenge args
   Enable static challenge/response protocol
diff --git a/src/=
openvpn/init=2Ec b/src/openvpn/init=2Ec
index e506dfe=2E=2Ea683be4 100644
-=
-- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3474,6 +3474,43 @@=

     }
 }
 
+/* Give up the probe socket and the handshake shortcut that c=
ame with it=2E */
+static void
+oob_probe_drop_adoption(struct context *c)
=
+{
+    openvpn_close_socket(c->c2=2Eoob_probe_sd);
+    c->c2=2Eoob_probe_=
sd =3D SOCKET_UNDEFINED;
+    c->c2=2Eoob_probe_adopt =3D false;
+}
+
+/* T=
he probe socket and the handshake shortcut belong to the remote that
+ * an=
swered: give them up if next_connection_entry() picked a different one=2E *=
/
+static void
+oob_probe_confirm_adoption(struct context *c)
+{
+    if (!=
c->c2=2Eoob_probe_adopt)
+    {
+        return;
+    }
+
+    /* next_conn=
ection_entry() maps the entry by value and the management
+     * interface=
 may then rewrite that copy, so compare what we ended up with,
+     * not =
just which entry was picked=2E */
+    const struct connection_list *l =3D =
c->options=2Econnection_list;
+    const struct connection_entry *won =3D c=
->c2=2Eoob_probe_ce;
+    const struct connection_entry *ce =3D &c->options=
=2Ece;
+    if (l->array[l->current] =3D=3D won && proto_is_udp(ce->proto) =
&& !ce->socks_proxy_server
+        && !ce->http_proxy_options && ce->remot=
e && won->remote
+        && streq(ce->remote, won->remote) && ce->remote_p=
ort && won->remote_port
+        && streq(ce->remote_port, won->remote_port=
))
+    {
+        return;
+    }
+
+    msg(D_LOW, "server-probe: a differ=
ent remote was selected, not adopting the probe socket");
+    oob_probe_dr=
op_adoption(c);
+}
+
 static void
 do_init_frame_tls(struct context *c)
 {
=
@@ -3486,6 +3523,32 @@
         /* Keep the max mtu also in the frame of tl=
s multi so it can access
          * it in push_peer_info */
         c->c2=
=2Etls_multi->opt=2Eframe=2Etun_max_mtu =3D c->c2=2Eframe=2Etun_max_mtu;
+
=
+        /* OOB server probe: the reply already served as the server's HARD=
_RESET
+         * (it carried a valid SYN-cookie), so the handshake starts=
 from it and we
+         * send no reset of our own=2E Count it as the ini=
tial packet received, as
+         * the server does, so check_server_poll_=
timeout() does not restart us=2E
+         * The reply only stands for as l=
ong as the server advertised, which a
+         * passphrase or token promp=
t can outlast=2E */
+        update_time();
+        if (c->c2=2Eoob_probe_=
adopt
+            && now >=3D c->c2=2Eoob_probe_reply_at + c->c2=2Eoob_pro=
be_connect_lifetime)
+        {
+            msg(D_LOW,
+                "s=
erver-probe: the reply's connect-lifetime (%d s) elapsed before the handsha=
ke"
+                " could start; connecting normally",
+                =
c->c2=2Eoob_probe_connect_lifetime);
+            oob_probe_drop_adoption(c=
);
+        }
+
+        if (c->c2=2Eoob_probe_adopt)
+        {
+         =
   c->c2=2Etls_multi->n_sessions++;
+            session_skip_to_pre_start_=
client(&c->c2=2Etls_multi->session[TM_ACTIVE],
+                           =
                  &c->c2=2Eoob_probe_client_sid,
+                         =
                    &c->c2=2Eoob_probe_server_sid, &c->c2=2Eoob_probe_remot=
e,
+                                             c->c2=2Eoob_probe_resend_w=
kc);
+        }
     }
     if (c->c2=2Etls_auth_standalone)
     {
@@ -449=
1,6 +4554,8 @@
     /* map in current connection entry */
     next_connect=
ion_entry(c);
 
+    oob_probe_confirm_adoption(c);
+
     /* should we dis=
able paging? */
     if (c->first_time && options->mlock)
     {
diff --git=
 a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index c12c5c4=2E=2Ea711451 100=
644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -192,8 +192,12 @=
@
 {
     int index;
     bool responded;
-    unsigned int rtt_ms;        =
  /* probe round-trip time in ms (responders only) */
-    struct oob_probe=
_reply reply; /* the values the server advertised */
+    unsigned int rtt_=
ms; /* probe round-trip time in ms (responders only) */
+    /* Captured fr=
om the packet and its reply TLV (responders only): */
+    struct session_i=
d server_sid;      /* the packet's own session id =3D server SYN-cookie */
=
+    time_t received_at;                /* when the reply arrived, for its =
connect_lifetime */
+    struct openvpn_sockaddr responder; /* address that=
 answered (pin the connection to it) */
+    struct oob_probe_reply reply; =
     /* the values the server advertised */
 };
 
 /* Where the client prob=
ed one connection entry: its resolved addresses=2E */
diff --git a/src/open=
vpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 3072d3c=2E=2Ef8b3d02 =
100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@=
 -38,6 +38,7 @@
 #include "otime=2Eh"
 #include "fdmisc=2Eh"
 #include "cry=
pto=2Eh"
+#include "dco=2Eh"
 #include "error=2Eh"
 
 #include "memdbg=2Eh"=

@@ -403,6 +404,20 @@
         return;
     }
 
+    /* The reply's own ses=
sion id (the server's stateless SYN-cookie) follows the
+     * opcode byte=
=2E Capture it before read_control_auth() strips it: a client may
+     * r=
euse it to start the handshake from this reply (the connect_lifetime
+     =
* advertisement)=2E */
+    struct session_id server_sid;
+    memcpy(serve=
r_sid=2Eid, data + 1, SID_SIZE);
+    if (!session_id_defined(&server_sid))=

+    {
+        /* No usable cookie, and starting a handshake from it woul=
d assert in
+         * reliable_ack_write()=2E tls_pre_decrypt() rejects a=
n undefined session
+         * id the same way=2E */
+        return;
+   =
 }
+
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)len);
 
=
@@ -448,6 +463,9 @@
 
         results[i]=2Eresponded =3D true;
         re=
sults[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
+        results[i]=
=2Eserver_sid =3D server_sid;
+        results[i]=2Ereceived_at =3D rcv=2Et=
v_sec;
+        results[i]=2Eresponder =3D *from; /* pin the connection to =
the address that answered */
         results[i]=2Ereply =3D reply;
 
     =
    i =3D oob_probe_next_target_at(from, targets, results, n, i + 1);
@@ -8=
22,11 +840,6 @@
         oob_probe_collect(&pc, &probe, &client_sid, &tas->=
tls_wrap, targets, results, l->len,
                           c->sig);
   =
  }
-    oob_probe_sockets_close(&pc);
-    if (bind_local)
-    {
-       =
 freeaddrinfo(bind_local);
-    }
 
     /* Log each remote's outcome while=
 results[i] still maps to array[i]=2E */
     int responded =3D 0;
@@ -842,=
10 +855,10 @@
             int margin =3D oob_effective_margin(&results[i],=
 client_margin);
             const char *margin_src =3D client_margin >=3D=
 0 ? "client" : "server-advertised";
             msg(D_LOW,
-             =
   "server-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;"
-    =
            " latency margin %d ms [%s])",
+                "server-probe: =
%s:%s answered (priority %d, weight %d, connect-lifetime %d s,"
+          =
      " rtt %u ms; latency margin %d ms [%s])",
                 ce->remote=
, ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweig=
ht,
-                results[i]=2Ertt_ms, margin, margin_src);
+           =
     results[i]=2Ereply=2Econnect_lifetime, results[i]=2Ertt_ms, margin, ma=
rgin_src);
         }
         else
         {
@@ -867,6 +880,81 @@
     ms=
g(M_INFO, "server-probe: %d of %d probed remote(s) answered; connecting bes=
t-first",
         responded, sent_count);
 
+    /* If the winner advertis=
ed a connect_lifetime, its reply also served as the
+     * server's reset:=
 hand its probe socket and the captured cookie to the
+     * connection, w=
hich then starts the handshake from that reply (see
+     * session_skip_to=
_pre_start_client)=2E Reusing that socket keeps the source
+     * IP+port =
the cookie is bound to=2E dco-win cannot hand a socket to the
+     * kerne=
l, so it only gets the probe ordering=2E */
+
+    bool probe_start =3D res=
ults[0]=2Eresponded && results[0]=2Ereply=2Econnect_lifetime > 0;
+    bool=
 wkc_gate =3D false;
+    /* Our first packet carries the WKc only if the s=
erver asked for it; without
+     * that a stateless tls-crypt-v2 server ca=
nnot decrypt it=2E */
+    if (probe_start && tas->tls_wrap=2Etls_crypt_v2_=
wkc
+        && !(results[0]=2Ereply=2Eflags & OOB_PROBE_REPLY_FLAG_RESEND_=
WKC))
+    {
+        probe_start =3D false;
+        wkc_gate =3D true;
+ =
   }
+    bool dco_win_gate =3D false;
+#if defined(_WIN32)
+    if (dco_en=
abled(&c->options))
+    {
+        probe_start =3D false;
+        dco_win=
_gate =3D true;
+    }
+#endif
+    if (probe_start)
+    {
+        const =
int af_idx =3D probe_af_index(results[0]=2Eresponder=2Eaddr=2Esa=2Esa_famil=
y);
+        c->c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];
+        pc=2Esd[af_=
idx] =3D SOCKET_UNDEFINED; /* relinquish: the connection owns it now */
+
+=
        c->c2=2Eoob_probe_remote =3D results[0]=2Eresponder;
+        c->c2=
=2Eoob_probe_client_sid =3D client_sid;
+        c->c2=2Eoob_probe_server_s=
id =3D results[0]=2Eserver_sid;
+        c->c2=2Eoob_probe_resend_wkc =3D
+=
            (results[0]=2Ereply=2Eflags & OOB_PROBE_REPLY_FLAG_RESEND_WKC) =
!=3D 0;
+        c->c2=2Eoob_probe_adopt =3D true;
+        c->c2=2Eoob_pro=
be_ce =3D l->array[0];
+        c->c2=2Eoob_probe_reply_at =3D results[0]=
=2Ereceived_at;
+        c->c2=2Eoob_probe_connect_lifetime =3D results[0]=
=2Ereply=2Econnect_lifetime;
+
+        msg(D_LOW, "server-probe: starting =
handshake from probe reply of %s:%s"
+                   " (connect-lifetim=
e %d s)",
+            l->array[0]->remote, l->array[0]->remote_port, resul=
ts[0]=2Ereply=2Econnect_lifetime);
+    }
+    else if (results[0]=2Erespon=
ded)
+    {
+        /* A server answered but we won't start the handshake =
from it -- say why=2E */
+        if (dco_win_gate)
+        {
+           =
 msg(D_LOW, "server-probe: cannot start the handshake from a probe reply"
+=
                       " with dco-win;"
+                       " using a f=
ull handshake");
+        }
+        else if (wkc_gate)
+        {
+       =
     msg(D_LOW, "server-probe: %s:%s did not ask for the wrapped client key=
;"
+                       " using a full handshake",
+                l->a=
rray[0]->remote, l->array[0]->remote_port);
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
index 09c6a3c=2E=2E4278cea 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/o=
penvpn/openvpn=2Eh
@@ -248,8 +248,14 @@
      * address probed) as the outg=
oing address, so the source IP+port and the
      * destination match what =
the server's handshake cookie is bound to=2E */
     bool oob_probe_adopt;
=
+    const struct connection_entry *oob_probe_ce; /* the entry the probe wo=
n on */
+    time_t oob_probe_reply_at;                   /* when its reply=
 arrived */
+    int oob_probe_connect_lifetime;              /* how long t=
hat reply stays usable */
     socket_descriptor_t oob_probe_sd;
     struc=
t openvpn_sockaddr oob_probe_remote;
+    struct session_id oob_probe_clien=
t_sid;  /* our probe session id (cookie was minted over it) */
+    struct =
session_id oob_probe_server_sid;  /* the reply's session id =3D server cook=
ie to echo back */
+    bool oob_probe_resend_wkc;               /* reply a=
sked to complete with CONTROL_WKC_V1 (v2) */
 
     struct link_socket_actu=
al *to_link_addr; /* IP address of remote */
     struct link_socket_actual=
 from;          /* address of incoming datagram */
diff --git a/src/openvpn=
/ssl=2Ec b/src/openvpn/ssl=2Ec
index 7184a2c=2E=2Eec6c212 100644
--- a/src/=
openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2587,6 +2587,61 @@
     retur=
n session_move_pre_start(session, ks, true);
 }
 
+bool
+session_skip_to_pr=
e_start_client(struct tls_session *session, const struct session_id *client=
_sid,
+                                 const struct session_id *server_sid=
,
+                                 const struct openvpn_sockaddr *remote, =
bool resend_wkc)
+{
+    struct key_state *ks =3D &session->key[KS_PRIMARY]=
;
+
+    /* Our session id must be the one used for the probe: the server's=
 cookie
+     * (server_sid) is an HMAC over it, and the server re-derives =
and checks it
+     * when it validates our third packet=2E */
+    session=
->session_id =3D *client_sid;
+    ks->session_id_remote =3D *server_sid;
+=

+    struct link_socket_actual act =3D { 0 };
+    act=2Edest =3D *remote;=

+    ks->remote_addr =3D act;
+    session->untrusted_addr =3D act;
+    s=
ession->burst =3D true;
+
+    /* tls-crypt-v2: the stateless server discar=
ded the WKc after the probe, so
+     * complete the handshake with P_CONTR=
OL_WKC_V1 (drives control_packet_needs_wkc)=2E
+     * The flag comes from =
the reply, so only act on it when this client has a
+     * WKc to resend=
=2E */
+    if (resend_wkc && session->tls_wrap=2Etls_crypt_v2_wkc)
+    {
=
+        ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+    }
+
+    /* We=
 never received the server's HARD_RESET (id 0) -- the probe reply stood
+  =
   * in for it=2E Acknowledge that phantom id 0 so our third packet carries=
 an
+     * ACK together with the server session id (the cookie): reliable_=
ack_write()
+     * only emits that session id when at least one ACK is pre=
sent, and the server
+     * needs it to validate the stateless cookie=2E *=
/
+    reliable_ack_acknowledge_packet_id(ks->rec_ack, 0);
+
+    /* Skip o=
ne (RESET) packet in each direction, so ids start at 1 (see
+     * session=
_skip_to_pre_start)=2E */
+    ks->rec_reliable->packet_id =3D 1;
+    sess=
ion->tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;
+
+    /* Do not send ou=
r own HARD_RESET=2E Unlike the server's skip, the client must
+     * send =
first: the stateless server only replies once it sees our third
+     * pac=
ket=2E session_move_pre_start(skip=3Dtrue) leaves us in S_PRE_START_SKIP,
+=
     * which only advances when a packet is *received*; instead drop to
+  =
   * S_PRE_START with an empty send-reliable (the initial packet was genera=
ted
+     * and immediately deleted), so tls_process() promotes us to S_STA=
RT and
+     * sends the ClientHello without waiting for a server reset=2E =
*/
+    if (!session_move_pre_start(session, ks, true))
+    {
+        ret=
urn false;
+    }
+    ks->state =3D S_PRE_START;
+    return true;
+}
+
 /=
**
  * Parses the TLVs (type, length, value) in the early negotiation
  */
=
diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 7ddf965=2E=2Ea=
534007 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -576,4=
 +576,21 @@
 bool session_skip_to_pre_start(struct tls_session *session, st=
ruct tls_pre_decrypt_state *state,
                                struct l=
ink_socket_actual *from);
 
+/**
+ * Client counterpart of session_skip_to_=
pre_start(): start the handshake from a
+ * server session id (SYN-cookie) =
learned earlier from an OOB server probe
+ * reply, which already served as=
 the server's HARD_RESET, so we send none=2E
+ *
+ * @param session     the=
 (client) TLS session to fast-forward
+ * @param client_sid  session id use=
d for the probe (the cookie is an HMAC over it)
+ * @param server_sid  the =
server's cookie, echoed back to complete the handshake
+ * @param remote   =
   the probed (pinned) server address to connect to
+ * @param resend_wkc  =
true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)
+ * @return true if t=
he session was fast-forwarded, false on failure
+ */
+bool session_skip_to_=
pre_start_client(struct tls_session *session,
+                            =
          const struct session_id *client_sid,
+                           =
           const struct session_id *server_sid,
+                          =
            const struct openvpn_sockaddr *remote, bool resend_wkc);
+
 #en=
dif /* ifndef OPENVPN_SSL_H */

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
Gerrit-Change-Numb=
er: 1770
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--OqvOwwpsVbU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #18</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
><br>Three things guard the shortcut=2E The reply&#39;s session id is rejec=
ted<br>unless it is defined: it becomes the remote session id, and the phan=
tom<br>ACK means reliable_ack_write() would assert on an all-zero one, so a=
<br>server -- or, without tls-auth/tls-crypt, anyone who answers first --<b=
r>could otherwise kill the client with a single packet=2E<br><br>The probe =
socket and the cookie belong to the remote that answered, so<br>both are gi=
ven up unless next_connection_entry() selected that same<br>remote=2E The e=
ntry is mapped by value and the management interface may<br>rewrite the cop=
y, so the check compares the resulting host, port and<br>proxy settings rat=
her than which entry was picked=2E<br><br>Finally, the server honours its r=
eply only for the advertised<br>connect_lifetime, which a passphrase or tok=
en prompt during init can<br>outlast; the shortcut is dropped when it has e=
lapsed=2E Steps after that<br>point fall to the short fallback deadline ins=
tead=2E<br><br>Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4<br>Sign=
ed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Emd<=
br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/init=2Ec<br>M s=
rc/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M src/openvpn/openvpn=
=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>8 files changed, =
281 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/18</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index cb85456=2E=2Efb9=
2bef 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Change=
s=2Emd</span><br><span>@@ -10,6 +10,14 @@</span><br><span>   weight with DN=
S-SRV-like semantics=2E Servers advertise these values with</span><br><span=
>   `--server-probe-reply`=2E</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+* **Probe exchange doubles as the start of the =
handshake**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  When a probing client pic=
ks a server that advertises support for it, the probe</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  and its reply take the place of the cli=
ent&#39;s and server&#39;s reset packets, so the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  client does not need a separate reset exchan=
ge before the handshake=2E This saves</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  one round trip compared with probing and then connectin=
g, and needs no extra</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  configuration=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> ## User-visible Changes</span><br><span> </span><br><spa=
n> * **Parsing Distinguished Names in certificates**</span><br><span>diff -=
-git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-opti=
ons=2Erst</span><br><span>index 74ae59e=2E=2E23684a5 100644</span><br><span=
>--- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-=
sections/client-options=2Erst</span><br><span>@@ -637,8 +637,34 @@</span><b=
r><span>   whose timestamp is within its ``--hand-window`` of its own clock=
, so a</span><br><span>   client whose clock is badly wrong receives no rep=
lies and keeps the</span><br><span>   configured order=2E Ordering by probe=
 replaces any order that</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  ``--remote-random`` produced=2E See ``--server-probe-reply`` for the</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  server side=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--remote-random`` prod=
uced=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  When the winning server suppo=
rts it, the probe exchange also starts the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  handshake: its reply stands in for the server&#39;=
s reset packet, so the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  client sends no reset of its own and the connection is established one=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  round trip sooner=
=2E This has consequences worth knowing:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  - the connection reuses the probe&#39;s socket, and therefore its sourc=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    port, which ma=
tters where firewall or NAT rules pin a port;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  - the connection is pinned to the address that =
answered, rather than</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    trying that remote&#39;s resolved addresses in turn;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  - the server honours its reply onl=
y for a limited time (see</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ``--server-probe-reply``), so an unusually slow start-up, such as=
 a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    private key p=
assphrase or token prompt, can outlast it; the client</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    then falls back to a normal handshake=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  - a handshake st=
arted this way is given only a few seconds to draw a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    response, rather than ``--hand-window=
``=2E If none arrives the client</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    logs a key negotiation timeout, restarts the attempt and m=
oves on to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    the n=
ext address or remote, so that server is not retried during this</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    cycle=2E The server answer=
ed a probe moments earlier, so silence means</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    it did not accept the reply as a reset, which =
happens when a load</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    balancer sends the probe and the handshake to different instances,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    when NAT changes the=
 source port, or when the server rotated its</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    session id key=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  The handshake shortcut is not used on Windows while DCO is active=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  See ``--server-probe-reply`` for =
the server side=2E</span><br><span> </span><br><span> --static-challenge ar=
gs</span><br><span>   Enable static challenge/response protocol</span><br><=
span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><sp=
an>index e506dfe=2E=2Ea683be4 100644</span><br><span>--- a/src/openvpn/init=
=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3474,6 =
+3474,43 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Give up the probe so=
cket and the handshake shortcut that came with it=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+oob_probe_drop_adoption(struct context *c)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_close_socket(c-&gt;c2=2Eoob_p=
robe_sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;=
c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    c-&gt;c2=2Eoob_probe_adopt =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* The probe socket and the handshake shortcut belong to the remote th=
at</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * answered: give=
 them up if next_connection_entry() picked a different one=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+oob_probe_confirm_adoption(struct cont=
ext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;c2=2Eoob_probe_=
adopt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* next_connection_entry() maps the entry by value and the m=
anagement</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * int=
erface may then rewrite that copy, so compare what we ended up with,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * not just which entr=
y was picked=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct connection_list *l =3D c-&gt;options=2Econnection_list;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct connec=
tion_entry *won =3D c-&gt;c2=2Eoob_probe_ce;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct connection_entry *ce =3D &amp;c-&=
gt;options=2Ece;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (l-&gt;array[l-&gt;current] =3D=3D won &amp;&amp; proto_is_udp(ce-&gt;p=
roto) &amp;&amp; !ce-&gt;socks_proxy_server</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        &amp;&amp; !ce-&gt;http_proxy_options &amp;=
&amp; ce-&gt;remote &amp;&amp; won-&gt;remote</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        &amp;&amp; streq(ce-&gt;remote, won-&gt;r=
emote) &amp;&amp; ce-&gt;remote_port &amp;&amp; won-&gt;remote_port</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; streq(ce=
-&gt;remote_port, won-&gt;remote_port))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-pro=
be: a different remote was selected, not adopting the probe socket&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_drop_a=
doption(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static v=
oid</span><br><span> do_init_frame_tls(struct context *c)</span><br><span> =
{</span><br><span>@@ -3486,6 +3523,32 @@</span><br><span>         /* Keep t=
he max mtu also in the frame of tls multi so it can access</span><br><span>=
          * it in push_peer_info */</span><br><span>         c-&gt;c2=2Etls=
_multi-&gt;opt=2Eframe=2Etun_max_mtu =3D c-&gt;c2=2Eframe=2Etun_max_mtu;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* OOB server probe: the reply al=
ready served as the server&#39;s HARD_RESET</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * (it carried a valid SYN-cookie), so the =
handshake starts from it and we</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * send no reset of our own=2E Count it as the initial =
packet received, as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * the server does, so check_server_poll_timeout() does not restart=
 us=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Th=
e reply only stands for as long as the server advertised, which a</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * passphrase or toke=
n prompt can outlast=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        update_time();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (c-&gt;c2=2Eoob_probe_adopt</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &amp;&amp; now &gt;=3D c-&gt;c2=2E=
oob_probe_reply_at + c-&gt;c2=2Eoob_probe_connect_lifetime)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(D_LOW,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;server-probe: the r=
eply&#39;s connect-lifetime (%d s) elapsed before the handshake&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot; co=
uld start; connecting normally&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                c-&gt;c2=2Eoob_probe_connect_lifetime);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            oob_probe=
_drop_adoption(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=2Eoob_pro=
be_adopt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=
=2Etls_multi-&gt;n_sessions++;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            session_skip_to_pre_start_client(&amp;c-&gt;c2=2Etls=
_multi-&gt;session[TM_ACTIVE],</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                             &amp;c-&gt;c2=2Eoob=
_probe_client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                            &amp;c-&gt;c2=2Eoob_probe_serve=
r_sid, &amp;c-&gt;c2=2Eoob_probe_remote,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                             c-&gt;c2=
=2Eoob_probe_resend_wkc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span>     }</span><br><span>     if (c-&gt;c2=2E=
tls_auth_standalone)</span><br><span>     {</span><br><span>@@ -4491,6 +455=
4,8 @@</span><br><span>     /* map in current connection entry */</span><br=
><span>     next_connection_entry(c);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    oob_probe_confirm_adoption(c);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*=
 should we disable paging? */</span><br><span>     if (c-&gt;first_time &am=
p;&amp; options-&gt;mlock)</span><br><span>     {</span><br><span>diff --gi=
t a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index c12c5c4=
=2E=2Ea711451 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><s=
pan>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -192,8 +192,12 @@</span><b=
r><span> {</span><br><span>     int index;</span><br><span>     bool respon=
ded;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int =
rtt_ms;          /* probe round-trip time in ms (responders only) */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct oob_probe_reply r=
eply; /* the values the server advertised */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    unsigned int rtt_ms; /* probe round-trip time =
in ms (responders only) */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Captured from the packet and its reply TLV (responders only):=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sessi=
on_id server_sid;      /* the packet&#39;s own session id =3D server SYN-co=
okie */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    time_t r=
eceived_at;                /* when the reply arrived, for its connect_lifet=
ime */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct op=
envpn_sockaddr responder; /* address that answered (pin the connection to i=
t) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob=
_probe_reply reply;      /* the values the server advertised */</span><br><=
span> };</span><br><span> </span><br><span> /* Where the client probed one =
connection entry: its resolved addresses=2E */</span><br><span>diff --git a=
/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>in=
dex 3072d3c=2E=2Ef8b3d02 100644</span><br><span>--- a/src/openvpn/oob_clien=
t=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -=
38,6 +38,7 @@</span><br><span> #include &quot;otime=2Eh&quot;</span><br><sp=
an> #include &quot;fdmisc=2Eh&quot;</span><br><span> #include &quot;crypto=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;dco=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><=
br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span=
>@@ -403,6 +404,20 @@</span><br><span>         return;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* The reply&#39;s own session id (the server&#39;s stateless SYN-cook=
ie) follows the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * opcode byte=2E Capture it before read_control_auth() strips it: a client=
 may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * reuse it=
 to start the handshake from this reply (the connect_lifetime</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * advertisement)=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id ser=
ver_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(=
server_sid=2Eid, data + 1, SID_SIZE);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!session_id_defined(&amp;server_sid))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* No usable cookie, and starting a h=
andshake from it would assert in</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * reliable_ack_write()=2E tls_pre_decrypt() rejects a=
n undefined session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * id the same way=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     struct buffer buf;</span><br><span>     buf_set_read(&amp;=
buf, data, (size_t)len);</span><br><span> </span><br><span>@@ -448,6 +463,9=
 @@</span><br><span> </span><br><span>         results[i]=2Eresponded =3D t=
rue;</span><br><span>         results[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsign=
ed int)ms : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   results[i]=2Eserver_sid =3D server_sid;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        results[i]=2Ereceived_at =3D rcv=2Etv_sec;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2E=
responder =3D *from; /* pin the connection to the address that answered */<=
/span><br><span>         results[i]=2Ereply =3D reply;</span><br><span> </s=
pan><br><span>         i =3D oob_probe_next_target_at(from, targets, result=
s, n, i + 1);</span><br><span>@@ -822,11 +840,6 @@</span><br><span>        =
 oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_w=
rap, targets, results, l-&gt;len,</span><br><span>                         =
  c-&gt;sig);</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    oob_probe_sockets_close(&amp;pc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (bind_local)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        freeaddrinfo(bind_local);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span>     /*=
 Log each remote&#39;s outcome while results[i] still maps to array[i]=2E *=
/</span><br><span>     int responded =3D 0;</span><br><span>@@ -842,10 +855=
,10 @@</span><br><span>             int margin =3D oob_effective_margin(&am=
p;results[i], client_margin);</span><br><span>             const char *marg=
in_src =3D client_margin &gt;=3D 0 ? &quot;client&quot; : &quot;server-adve=
rtised&quot;;</span><br><span>             msg(D_LOW,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &quot;server-probe: %s:%s a=
nswered (priority %d, weight %d, rtt %u ms;&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                &quot; latency margin %d ms [%s=
])&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      &quot;server-probe: %s:%s answered (priority %d, weight %d, connect-l=
ifetime %d s,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot; rtt %u ms; latency margin %d ms [%s])&quot;,</span><=
br><span>                 ce-&gt;remote, ce-&gt;remote_port, results[i]=2Er=
eply=2Epriority, results[i]=2Ereply=2Eweight,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                results[i]=2Ertt_ms, margin, margin=
_src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   results[i]=2Ereply=2Econnect_lifetime, results[i]=2Ertt_ms, margin, marg=
in_src);</span><br><span>         }</span><br><span>         else</span><br=
><span>         {</span><br><span>@@ -867,6 +880,81 @@</span><br><span>    =
 msg(M_INFO, &quot;server-probe: %d of %d probed remote(s) answered; connec=
ting best-first&quot;,</span><br><span>         responded, sent_count);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* If the winner advertised a connect_lifetime, its reply also served as the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * server&#39;s=
 reset: hand its probe socket and the captured cookie to the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * connection, which then star=
ts the handshake from that reply (see</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * session_skip_to_pre_start_client)=2E Reusing that =
socket keeps the source</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * IP+port the cookie is bound to=2E dco-win cannot hand a socket t=
o the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * kernel,=
 so it only gets the probe ordering=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool probe_start =3D results[0]=2Eresponded &amp;&amp; results[0]=2E=
reply=2Econnect_lifetime &gt; 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool wkc_gate =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Our first packet carries the WKc only if the s=
erver asked for it; without</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * that a stateless tls-crypt-v2 server cannot decrypt it=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (probe_start=
 &amp;&amp; tas-&gt;tls_wrap=2Etls_crypt_v2_wkc</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &amp;&amp; !(results[0]=2Ereply=2Eflags=
 &amp; OOB_PROBE_REPLY_FLAG_RESEND_WKC))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        probe_start =3D false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        wkc_gate =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool dco_win_gate =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;c-&gt;options))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        probe_start =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        dco_win_gate =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (probe_start)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const int af_idx =3D probe_af_index(results[0]=2Erespo=
nder=2Eaddr=2Esa=2Esa_family);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        pc=2Esd[af_idx] =3D SOC=
KET_UNDEFINED; /* relinquish: the connection owns it now */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_remote =3D results[0]=2Er=
esponder;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-=
&gt;c2=2Eoob_probe_client_sid =3D client_sid;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_server_sid =3D resul=
ts[0]=2Eserver_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        c-&gt;c2=2Eoob_probe_resend_wkc =3D</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            (results[0]=2Ereply=2Eflags &amp; OOB_P=
ROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_adopt =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_ce =
=3D l-&gt;array[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        c-&gt;c2=2Eoob_probe_reply_at =3D results[0]=2Ereceived_at;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_prob=
e_connect_lifetime =3D results[0]=2Ereply=2Econnect_lifetime;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: starting hand=
shake from probe reply of %s:%s&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   &quot; (connect-lifetime %d s)&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            l-&gt;ar=
ray[0]-&gt;remote, l-&gt;array[0]-&gt;remote_port, results[0]=2Ereply=2Econ=
nect_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (resul=
ts[0]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* A se=
rver answered but we won&#39;t start the handshake from it -- say why=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dco_win=
_gate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, =
&quot;server-probe: cannot start the handshake from a probe reply&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
&quot; with dco-win;&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                       &quot; using a full handshake&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else if (wkc_gate)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-prob=
e: %s:%s did not ask for the wrapped client key;&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                       &quot; using a fu=
ll handshake&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                l-&gt;array[0]-&gt;remote, l-&gt;array[0]-&gt;remote_port);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else if (results[0]=
=2Ereply=2Econnect_lifetime =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(D_LOW, &quot;server-probe: %s:%s did not advertise =
a connect-lifetime&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                       &quot; (connect-lifetime 0); using a full hands=
hake&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        l-&gt;array[0]-&gt;remote, l-&gt;array[0]-&gt;remote_port);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Close any probe sockets we did not hand off to the connection=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe=
_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bind_l=
ocal)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(bind_lo=
cal);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span>     oob_probe_free_wrap(c, tas);</span><br><span>     gc_free(&amp=
;gc);</span><br><span> }</span><br><span>diff --git a/src/openvpn/openvpn=
=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index 09c6a3c=2E=2E4278cea 1=
00644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/s=
rc/openvpn/openvpn=2Eh</span><br><span>@@ -248,8 +248,14 @@</span><br><span=
>      * address probed) as the outgoing address, so the source IP+port and=
 the</span><br><span>      * destination match what the server&#39;s handsh=
ake cookie is bound to=2E */</span><br><span>     bool oob_probe_adopt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct connec=
tion_entry *oob_probe_ce; /* the entry the probe won on */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    time_t oob_probe_reply_at;      =
             /* when its reply arrived */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int oob_probe_connect_lifetime;              /* h=
ow long that reply stays usable */</span><br><span>     socket_descriptor_t=
 oob_probe_sd;</span><br><span>     struct openvpn_sockaddr oob_probe_remot=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sessio=
n_id oob_probe_client_sid;  /* our probe session id (cookie was minted over=
 it) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
ession_id oob_probe_server_sid;  /* the reply&#39;s session id =3D server c=
ookie to echo back */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool oob_probe_resend_wkc;               /* reply asked to complete w=
ith CONTROL_WKC_V1 (v2) */</span><br><span> </span><br><span>     struct li=
nk_socket_actual *to_link_addr; /* IP address of remote */</span><br><span>=
     struct link_socket_actual from;          /* address of incoming datagr=
am */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2E=
c</span><br><span>index 7184a2c=2E=2Eec6c212 100644</span><br><span>--- a/s=
rc/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><spa=
n>@@ -2587,6 +2587,61 @@</span><br><span>     return session_move_pre_start=
(session, ks, true);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+session_skip_to_pre_start_client(struct tls_session =
*session, const struct session_id *client_sid,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                 const struct se=
ssion_id *server_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                 const struct openvpn_sockaddr *remote, b=
ool resend_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_state *=
ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Our session id must be the one used for the probe: the server&#39;=
s cookie</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (ser=
ver_sid) is an HMAC over it, and the server re-derives and checks it</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * when it validates o=
ur third packet=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    session-&gt;session_id =3D *client_sid;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ks-&gt;session_id_remote =3D *server_sid;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_actual act =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    act=2Edest =
=3D *remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-=
&gt;remote_addr =3D act;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    session-&gt;untrusted_addr =3D act;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    session-&gt;burst =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* tls-crypt-v2: the stateless server discarded the W=
Kc after the probe, so</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * complete the handshake with P_CONTROL_WKC_V1 (drives control_pack=
et_needs_wkc)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * The flag comes from the reply, so only act on it when this client has a=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * WKc to resen=
d=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rese=
nd_wkc &amp;&amp; session-&gt;tls_wrap=2Etls_crypt_v2_wkc)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        ks-&gt;crypto_options=2Eflags |=3D CO_RESE=
ND_WKC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* We never received the server&#39;s HAR=
D_RESET (id 0) -- the probe reply stood</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * in for it=2E Acknowledge that phantom id 0 so ou=
r third packet carries an</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * ACK together with the server session id (the cookie): reliable=
_ack_write()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
only emits that session id when at least one ACK is present, and the server=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * needs it to =
validate the stateless cookie=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    reliable_ack_acknowledge_packet_id(ks-&gt;rec_ack, 0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Skip one (RESET) packet in each =
direction, so ids start at 1 (see</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * session_skip_to_pre_start)=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;rec_reliable-&gt;packet_id =3D=
 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;=
tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Do not send our own HARD_RESET=2E Unlike the server&#39;s ski=
p, the client must</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * send first: the stateless server only replies once it sees our third<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * packet=2E ses=
sion_move_pre_start(skip=3Dtrue) leaves us in S_PRE_START_SKIP,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * which only advances when=
 a packet is *received*; instead drop to</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * S_PRE_START with an empty send-reliable (the in=
itial packet was generated</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * and immediately deleted), so tls_process() promotes us to S_S=
TART and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * send=
s the ClientHello without waiting for a server reset=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!session_move_pre_start(sess=
ion, ks, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;state =3D S_PRE_STA=
RT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span=
>  * Parses the TLVs (type, length, value) in the early negotiation</span><=
br><span>  */</span><br><span>diff --git a/src/openvpn/ssl=2Eh b/src/openvp=
n/ssl=2Eh</span><br><span>index 7ddf965=2E=2Ea534007 100644</span><br><span=
>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2Eh</span>=
<br><span>@@ -576,4 +576,21 @@</span><br><span> bool session_skip_to_pre_st=
art(struct tls_session *session, struct tls_pre_decrypt_state *state,</span=
><br><span>                                struct link_socket_actual *from)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Client counte=
rpart of session_skip_to_pre_start(): start the handshake from a</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * server session id (SYN-cook=
ie) learned earlier from an OOB server probe</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * reply, which already served as the server&#39;s=
 HARD_RESET, so we send none=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram session     the (client) TLS session to fast-forward</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param client_sid  session id used=
 for the probe (the cookie is an HMAC over it)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param server_sid  the server&#39;s cookie, e=
choed back to complete the handshake</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param remote      the probed (pinned) server address t=
o connect to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am resend_wkc  true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the ses=
sion was fast-forwarded, false on failure</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool session_skip_to_pre_start_client(struct tls_session *session,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
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
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--OqvOwwpsVbU=--


--===============0981404372172168858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0981404372172168858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0981404372172168858==--

