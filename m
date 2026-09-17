Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C03C982D0
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NPH4d1xwlaRohTLkQY1zZdFpxMRIRyJfnJb3VXZC8MA=; b=miFuCDUUStBPzQ//efTOnS+Kjz
	RNej51LcICmYlNL9G9raZb5UG4VczxCvcErhurC5KGA03bOe7hdHrBa3D/dOh1CmNcG8rI8C4EMWM
	RfLOGORDUhJo5x2m1ubF9tZ8uM2RdxkfGMtpGOJFfEYKoPl290Bmbk5/dGeoSnGakSuA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x767w-00050t-6u;
	Thu, 17 Sep 2026 07:01:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x767u-00050g-LV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=85ki6/W9gGjSvmb15sip2Rx9DsINi/oR0/QjEbX+u2s=; b=XHPNaVKDayJyNQmjI2Fnl8P6ya
 Ehf64UwzCfgelpJyCkZ3QQ8QNYn15/+Lr3ngIEeIUhOlMj5Z6/Njyib7SQxjwJqPVDIv9z7DPhXrm
 w2CPvrwe6sEodK1MfN2AzXiKtaBPoO7RvMbRpRYLDXRGUrTOFqQ7M/cdvQJcNFrtFnRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=85ki6/W9gGjSvmb15sip2Rx9DsINi/oR0/QjEbX+u2s=; b=d
 /SO+LFMWB7KE7V6VWC+lKrnBitVGtSxeAMxsec5ir+7Pf6V3WsiUykukW53OHtvNwHP09gldAcpf/
 ZreEQLnwH8aeNpoOF3UKpa2lRUficU/jWUqo19qowg2RBcYRrAnS2STN4+VWGg18IOBcpBDC41kgK
 SAGmZG8zjfTeDMvc=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x767q-0006ne-Jv for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:46 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485ac898fa4so361739f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628496; x=1790233296; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=85ki6/W9gGjSvmb15sip2Rx9DsINi/oR0/QjEbX+u2s=;
 b=WLfqV9kPNjyQn1af1BOSNbIYea4ryUNUO02B9kLTDi+ObHWZ/jDy3zFNnXAqyQXPgo
 8CmyGLjYvHuuIipZUHs+B2UPn2wNU4DopK5SfyGueR1xpirdsAmyyJXyP79MgPaIrSPl
 G1/UjPKEVF3PMsEF1i5PEDcEu8dJKji8R21yKNFb01rg/8KyAudK1tgZ8B0IcJx7HMIf
 mRuLS1LZfm+z8ikic089d5CDcMaCOhd0oYjrYEm2triT+roB+/pXgROX1ZD4fPqy/6EN
 +f71iPSYVmE4gHg9HDBHfF5UO/4olHPglU1UyGCxNSB9eGWyhq/n6emSGDTysn2IbOGZ
 dCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628496; x=1790233296;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=85ki6/W9gGjSvmb15sip2Rx9DsINi/oR0/QjEbX+u2s=;
 b=aHq9odEU433D811ANBqLpz5+sCyBTPw8rnUIW7xLsUONLk5+rn2ryS+ePWU7GQRCs7
 PpYwnGX64qyD9j0K886SfVM9dPvrNkLoIY3n/ASi79u9SfQMtQ7OEgQbkLTIzsAnw7ZF
 28E1qykVv4ZX5d8mSkiSgv1g2ZuGLhviIScHoaxn7I1EUty/DMnXwo3WzjL+lsLwhCnM
 SRLUlAl8UXhKJI2aZYDKC7a5mTd6bO3NB0w5NjXzDgg3SCjpFcSQac6OVHqcs6hRyfQG
 BnTKmBt5CTU/V95pFaCC2KpiT94r/qzrn2+e59y0gCmMJg3RmKNEvrzkz2RD9NMP4wWU
 itlQ==
X-Gm-Message-State: AFuF++k/UOr4aixt2bFVFTQB2yur1KbXITm/5/7d5X40LEdj8Q6Qe6It
 68moaxHcFVSSTUbTsxg7mPimneZMd/VyRDiVjMRb7Wm6jNO+iv5TJzAxtOT3U2vSX6Go0ukK/gE
 5ZfoSD6J/xcriJ/jB5/qNRaoogYUHUtmIUa/QInh3GItCls+AxoooQ34XIo1h24a0EY6R
X-Gm-Gg: AYBFou1eftYaQ1ggAj4Edh2Aa3QdMqpAI42mmRWoL7oYhQmw6gdWKkvKswe7szXzk52
 fB8qeLKvxAlXe/D8EfUDjLt/F3SLDNkQKpilXJAqTFH0Tp3rtQR8NeIVXA7zXMC+dZeI9fw4jt5
 d+XIZDL1BfTIqjJ8C6ycqBirIzly0Fn0ygr89UTvUbvxvo2jpZlFel3Ynj91sftf5ODe4Yl/24C
 hBWEKbBq1lF+WHGFrQ5X1JuLCBzxpisd5ailiLkzcEPj3Rknr2ezi8Ym+qQBnzGkPrkZandU5De
 RUvXXgNX0RJwGXhzGYDBsLxpUmvZWtW/qvynRb5dyA06eOHiQvUmgAyzin/SGB5GpKlSJk0+OHP
 TaiG62n7OyZYLI+boA8Hq6PIevkcjJkcarvqD8gKcHYBUd8BotsSqfyP3O3dbOdJ4B8iyUI/MrA
 TzSTIHnMLUwnvPqW/1KwDpTiDxxvLb1GWucPn9mmn8EF8VBMYH3tN+gSA2Vsie+NzErmfKqdAPw
 y27L1qMgMeuxUU4DNk3cjvgylbAvptHmJtevSzKKQLcJvsRx0jIgPv0cFIsYiItyXio/cktN+Ws
 7szD4YSW45jXBv6Zpf4fiusLBMcIUVmudlaPFWapJcwzY5gntbAm5bZNCWkv4g==
X-Received: by 2002:a05:6000:1a8d:b0:487:f01:158 with SMTP id
 ffacd0b85a97d-4870f0103ffmr6143570f8f.20.1789628495520; 
 Thu, 17 Sep 2026 00:01:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fe7esm13086356f8f.6.2026.09.17.00.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:35 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: bc61cb4fa00c62cb4f6054a2c8e5ca1c6a944491
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a2fb376b6ba08b52d7b797df232965a8c8872b03-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x767q-0006ne-Jv
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
Content-Type: multipart/mixed; boundary="===============3242684818762158625=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3242684818762158625==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bn0wNATrdvo="; charset=UTF-8

--Bn0wNATrdvo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#21)=2E
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
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/21

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
index dc74=
6a9=2E=2E28ad8dd 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/d=
oc/man-sections/client-options=2Erst
@@ -642,8 +642,34 @@
   away from its =
own clock, so a client whose clock is badly wrong may get
   no replies and=
 then keeps the configured order=2E Ordering by probe
   replaces any order=
 that
-  ``--remote-random`` produced=2E See ``--server-probe-reply`` for t=
he
-  server side=2E
+  ``--remote-random`` produced=2E
+
+  When the winni=
ng server supports it, the probe exchange also starts the
+  handshake: its=
 reply stands in for the server's reset packet, so the
+  client sends no r=
eset of its own and the connection is established one
+  round trip sooner=
=2E This has consequences worth knowing:
+
+  - the connection reuses the p=
robe's socket, and therefore its source
+    port, which matters where fire=
wall or NAT rules pin a port;
+  - the connection is pinned to the address =
that answered, rather than
+    trying that remote's resolved addresses in =
turn;
+  - the server honours its reply only for a limited time (see
+    `=
`--server-probe-reply``), so an unusually slow start-up, such as a
+    pri=
vate key passphrase or token prompt, can outlast it; the client
+    then f=
alls back to a normal handshake;
+  - a handshake started this way is given=
 only a few seconds to draw a
+    response, rather than ``--hand-window``=
=2E If none arrives the client
+    logs a key negotiation timeout, restart=
s the attempt and moves on to
+    the next address or remote, so that serv=
er is not retried during this
+    cycle=2E The server answered a probe mom=
ents earlier, so silence means
+    it did not accept the reply as a reset,=
 which happens when a load
+    balancer sends the probe and the handshake =
to different instances,
+    when NAT changes the source port, or when the =
server rotated its
+    session id key=2E
+
+  The handshake shortcut is no=
t used on Windows while DCO is active=2E
+
+  See ``--server-probe-reply`` =
for the server side=2E
 
 --static-challenge args
   Enable static challeng=
e/response protocol
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2E=
c
index e506dfe=2E=2Ea683be4 100644
--- a/src/openvpn/init=2Ec
+++ b/src/op=
envpn/init=2Ec
@@ -3474,6 +3474,43 @@
     }
 }
 
+/* Give up the probe soc=
ket and the handshake shortcut that came with it=2E */
+static void
+oob_pr=
obe_drop_adoption(struct context *c)
+{
+    openvpn_close_socket(c->c2=2Eo=
ob_probe_sd);
+    c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
+    c->c2=2E=
oob_probe_adopt =3D false;
+}
+
+/* The probe socket and the handshake shor=
tcut belong to the remote that
+ * answered: give them up if next_connectio=
n_entry() picked a different one=2E */
+static void
+oob_probe_confirm_adop=
tion(struct context *c)
+{
+    if (!c->c2=2Eoob_probe_adopt)
+    {
+     =
   return;
+    }
+
+    /* next_connection_entry() maps the entry by value=
 and the management
+     * interface may then rewrite that copy, so compar=
e what we ended up with,
+     * not just which entry was picked=2E */
+   =
 const struct connection_list *l =3D c->options=2Econnection_list;
+    con=
st struct connection_entry *won =3D c->c2=2Eoob_probe_ce;
+    const struct=
 connection_entry *ce =3D &c->options=2Ece;
+    if (l->array[l->current] =
=3D=3D won && proto_is_udp(ce->proto) && !ce->socks_proxy_server
+        &=
& !ce->http_proxy_options && ce->remote && won->remote
+        && streq(ce=
->remote, won->remote) && ce->remote_port && won->remote_port
+        && s=
treq(ce->remote_port, won->remote_port))
+    {
+        return;
+    }
+
+=
    msg(D_LOW, "server-probe: a different remote was selected, not adopting=
 the probe socket");
+    oob_probe_drop_adoption(c);
+}
+
 static void
 do=
_init_frame_tls(struct context *c)
 {
@@ -3486,6 +3523,32 @@
         /* Ke=
ep the max mtu also in the frame of tls multi so it can access
          * =
it in push_peer_info */
         c->c2=2Etls_multi->opt=2Eframe=2Etun_max_m=
tu =3D c->c2=2Eframe=2Etun_max_mtu;
+
+        /* OOB server probe: the rep=
ly already served as the server's HARD_RESET
+         * (it carried a vali=
d SYN-cookie), so the handshake starts from it and we
+         * send no r=
eset of our own=2E Count it as the initial packet received, as
+         * =
the server does, so check_server_poll_timeout() does not restart us=2E
+   =
      * The reply only stands for as long as the server advertised, which a=

+         * passphrase or token prompt can outlast=2E */
+        update_t=
ime();
+        if (c->c2=2Eoob_probe_adopt
+            && now >=3D c->c2=
=2Eoob_probe_reply_at + c->c2=2Eoob_probe_connect_lifetime)
+        {
+   =
         msg(D_LOW,
+                "server-probe: the reply's connect-lif=
etime (%d s) elapsed before the handshake"
+                " could start; =
connecting normally",
+                c->c2=2Eoob_probe_connect_lifetime);=

+            oob_probe_drop_adoption(c);
+        }
+
+        if (c->c2=
=2Eoob_probe_adopt)
+        {
+            c->c2=2Etls_multi->n_sessions++=
;
+            session_skip_to_pre_start_client(&c->c2=2Etls_multi->session=
[TM_ACTIVE],
+                                             &c->c2=2Eoob_pro=
be_client_sid,
+                                             &c->c2=2Eoob_p=
robe_server_sid, &c->c2=2Eoob_probe_remote,
+                              =
               c->c2=2Eoob_probe_resend_wkc);
+        }
     }
     if (c-=
>c2=2Etls_auth_standalone)
     {
@@ -4491,6 +4554,8 @@
     /* map in curr=
ent connection entry */
     next_connection_entry(c);
 
+    oob_probe_con=
firm_adoption(c);
+
     /* should we disable paging? */
     if (c->first_=
time && options->mlock)
     {
diff --git a/src/openvpn/oob=2Eh b/src/openv=
pn/oob=2Eh
index 09780c8=2E=2Ef7679eeb 100644
--- a/src/openvpn/oob=2Eh
+++=
 b/src/openvpn/oob=2Eh
@@ -197,8 +197,12 @@
 {
     int index;
     bool re=
sponded;
-    unsigned int rtt_ms;          /* probe round-trip time in ms =
(responders only) */
-    struct oob_probe_reply reply; /* the values the s=
erver advertised */
+    unsigned int rtt_ms; /* probe round-trip time in m=
s (responders only) */
+    /* Captured from the packet and its reply TLV (=
responders only): */
+    struct session_id server_sid;      /* the packet'=
s own session id =3D server SYN-cookie */
+    time_t received_at;         =
       /* when the reply arrived, for its connect_lifetime */
+    struct o=
penvpn_sockaddr responder; /* address that answered (pin the connection to =
it) */
+    struct oob_probe_reply reply;      /* the values the server adv=
ertised */
 };
 
 /* Where the client probed one connection entry: its reso=
lved addresses=2E */
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/=
oob_client=2Ec
index 5e949f4=2E=2Ee545aaf 100644
--- a/src/openvpn/oob_clie=
nt=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -38,6 +38,7 @@
 #include "otime=
=2Eh"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "dco=2Eh"
 #i=
nclude "error=2Eh"
 
 #include "memdbg=2Eh"
@@ -404,6 +405,20 @@
         r=
eturn;
     }
 
+    /* The reply's own session id (the server's stateless =
SYN-cookie) follows the
+     * opcode byte=2E Capture it before read_contr=
ol_auth() strips it: a client may
+     * reuse it to start the handshake f=
rom this reply (the connect_lifetime
+     * advertisement)=2E */
+    stru=
ct session_id server_sid;
+    memcpy(server_sid=2Eid, data + 1, SID_SIZE);=

+    if (!session_id_defined(&server_sid))
+    {
+        /* No usable co=
okie, and starting a handshake from it would assert in
+         * reliable=
_ack_write()=2E tls_pre_decrypt() rejects an undefined session
+         * =
id the same way=2E */
+        return;
+    }
+
     struct buffer buf;
   =
  buf_set_read(&buf, data, (size_t)len);
 
@@ -449,6 +464,9 @@
 
         r=
esults[i]=2Eresponded =3D true;
         results[i]=2Ertt_ms =3D (ms > 0) ?=
 (unsigned int)ms : 0;
+        results[i]=2Eserver_sid =3D server_sid;
+  =
      results[i]=2Ereceived_at =3D rcv=2Etv_sec;
+        results[i]=2Eresp=
onder =3D *from; /* pin the connection to the address that answered */
    =
     results[i]=2Ereply =3D reply;
 
         i =3D oob_probe_next_target_a=
t(from, targets, results, n, i + 1);
@@ -823,11 +841,6 @@
         oob_prob=
e_collect(&pc, &probe, &client_sid, &tas->tls_wrap, targets, results, l->le=
n,
                           c->sig);
     }
-    oob_probe_sockets_close(=
&pc);
-    if (bind_local)
-    {
-        freeaddrinfo(bind_local);
-    }=

 
     /* Log each remote's outcome while results[i] still maps to array[i=
]=2E */
     int responded =3D 0;
@@ -843,10 +856,10 @@
             int ma=
rgin =3D oob_effective_margin(&results[i], client_margin);
             con=
st char *margin_src =3D client_margin >=3D 0 ? "client" : "server-advertise=
d";
             msg(D_LOW,
-                "server-probe: %s:%s answered =
(priority %d, weight %d, rtt %u ms;"
-                " latency margin %d m=
s [%s])",
+                "server-probe: %s:%s answered (priority %d, weig=
ht %d, connect-lifetime %d s,"
+                " rtt %u ms; latency margin=
 %d ms [%s])",
                 ce->remote, ce->remote_port, results[i]=2Er=
eply=2Epriority, results[i]=2Ereply=2Eweight,
-                results[i]=
=2Ertt_ms, margin, margin_src);
+                results[i]=2Ereply=2Econne=
ct_lifetime, results[i]=2Ertt_ms, margin, margin_src);
         }
         =
else
         {
@@ -868,6 +881,81 @@
     msg(M_INFO, "server-probe: %d of =
%d probed remote(s) answered; connecting best-first",
         responded, s=
ent_count);
 
+    /* If the winner advertised a connect_lifetime, its repl=
y also served as the
+     * server's reset: hand its probe socket and the =
captured cookie to the
+     * connection, which then starts the handshake =
from that reply (see
+     * session_skip_to_pre_start_client)=2E Reusing t=
hat socket keeps the source
+     * IP+port the cookie is bound to=2E dco-w=
in cannot hand a socket to the
+     * kernel, so it only gets the probe or=
dering=2E */
+
+    bool probe_start =3D results[0]=2Eresponded && results[=
0]=2Ereply=2Econnect_lifetime > 0;
+    bool wkc_gate =3D false;
+    /* Ou=
r first packet carries the WKc only if the server asked for it; without
+  =
   * that a stateless tls-crypt-v2 server cannot decrypt it=2E */
+    if (=
probe_start && tas->tls_wrap=2Etls_crypt_v2_wkc
+        && !(results[0]=2E=
reply=2Eflags & OOB_PROBE_REPLY_FLAG_RESEND_WKC))
+    {
+        probe_sta=
rt =3D false;
+        wkc_gate =3D true;
+    }
+    bool dco_win_gate =3D=
 false;
+#if defined(_WIN32)
+    if (dco_enabled(&c->options))
+    {
+   =
     probe_start =3D false;
+        dco_win_gate =3D true;
+    }
+#endif
=
+    if (probe_start)
+    {
+        const int af_idx =3D probe_af_index(r=
esults[0]=2Eresponder=2Eaddr=2Esa=2Esa_family);
+        c->c2=2Eoob_probe_=
sd =3D pc=2Esd[af_idx];
+        pc=2Esd[af_idx] =3D SOCKET_UNDEFINED; /* r=
elinquish: the connection owns it now */
+
+        c->c2=2Eoob_probe_remot=
e =3D results[0]=2Eresponder;
+        c->c2=2Eoob_probe_client_sid =3D cli=
ent_sid;
+        c->c2=2Eoob_probe_server_sid =3D results[0]=2Eserver_sid;=

+        c->c2=2Eoob_probe_resend_wkc =3D
+            (results[0]=2Ereply=
=2Eflags & OOB_PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;
+        c->c2=2Eoob_pr=
obe_adopt =3D true;
+        c->c2=2Eoob_probe_ce =3D l->array[0];
+       =
 c->c2=2Eoob_probe_reply_at =3D results[0]=2Ereceived_at;
+        c->c2=2E=
oob_probe_connect_lifetime =3D results[0]=2Ereply=2Econnect_lifetime;
+
+  =
      msg(D_LOW, "server-probe: starting handshake from probe reply of %s:%=
s"
+                   " (connect-lifetime %d s)",
+            l->array[0]=
->remote, l->array[0]->remote_port, results[0]=2Ereply=2Econnect_lifetime);=

+    }
+    else if (results[0]=2Eresponded)
+    {
+        /* A server a=
nswered but we won't start the handshake from it -- say why=2E */
+        =
if (dco_win_gate)
+        {
+            msg(D_LOW, "server-probe: cannot =
start the handshake from a probe reply"
+                       " with dco-=
win;"
+                       " using a full handshake");
+        }
+     =
   else if (wkc_gate)
+        {
+            msg(D_LOW, "server-probe: %s:=
%s did not ask for the wrapped client key;"
+                       " using=
 a full handshake",
+                l->array[0]->remote, l->array[0]->remo=
te_port);
+        }
+        else if (results[0]=2Ereply=2Econnect_lifetim=
e =3D=3D 0)
+        {
+            msg(D_LOW, "server-probe: %s:%s did not=
 advertise a connect-lifetime"
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
+    if (bind_local)
+    {
+        freeaddrinfo(bind_local);
+    }
   =
  oob_probe_free_wrap(c, tas);
     gc_free(&gc);
 }
diff --git a/src/openv=
pn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index 09c6a3c=2E=2E4278cea 100644
=
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -248,8 +248,=
14 @@
      * address probed) as the outgoing address, so the source IP+por=
t and the
      * destination match what the server's handshake cookie is b=
ound to=2E */
     bool oob_probe_adopt;
+    const struct connection_entry=
 *oob_probe_ce; /* the entry the probe won on */
+    time_t oob_probe_repl=
y_at;                   /* when its reply arrived */
+    int oob_probe_con=
nect_lifetime;              /* how long that reply stays usable */
     soc=
ket_descriptor_t oob_probe_sd;
     struct openvpn_sockaddr oob_probe_remot=
e;
+    struct session_id oob_probe_client_sid;  /* our probe session id (c=
ookie was minted over it) */
+    struct session_id oob_probe_server_sid;  =
/* the reply's session id =3D server cookie to echo back */
+    bool oob_p=
robe_resend_wkc;               /* reply asked to complete with CONTROL_WKC_=
V1 (v2) */
 
     struct link_socket_actual *to_link_addr; /* IP address of=
 remote */
     struct link_socket_actual from;          /* address of inco=
ming datagram */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
ind=
ex f0cd720=2E=2Ea350e64 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/=
ssl=2Ec
@@ -2587,6 +2587,61 @@
     return session_move_pre_start(session, =
ks, true);
 }
 
+bool
+session_skip_to_pre_start_client(struct tls_session =
*session, const struct session_id *client_sid,
+                           =
      const struct session_id *server_sid,
+                               =
  const struct openvpn_sockaddr *remote, bool resend_wkc)
+{
+    struct ke=
y_state *ks =3D &session->key[KS_PRIMARY];
+
+    /* Our session id must be=
 the one used for the probe: the server's cookie
+     * (server_sid) is an=
 HMAC over it, and the server re-derives and checks it
+     * when it vali=
dates our third packet=2E */
+    session->session_id =3D *client_sid;
+   =
 ks->session_id_remote =3D *server_sid;
+
+    struct link_socket_actual ac=
t =3D { 0 };
+    act=2Edest =3D *remote;
+    ks->remote_addr =3D act;
+  =
  session->untrusted_addr =3D act;
+    session->burst =3D true;
+
+    /* =
tls-crypt-v2: the stateless server discarded the WKc after the probe, so
+ =
    * complete the handshake with P_CONTROL_WKC_V1 (drives control_packet_n=
eeds_wkc)=2E
+     * The flag comes from the reply, so only act on it when =
this client has a
+     * WKc to resend=2E */
+    if (resend_wkc && sessio=
n->tls_wrap=2Etls_crypt_v2_wkc)
+    {
+        ks->crypto_options=2Eflags =
|=3D CO_RESEND_WKC;
+    }
+
+    /* We never received the server's HARD_RE=
SET (id 0) -- the probe reply stood
+     * in for it=2E Acknowledge that p=
hantom id 0 so our third packet carries an
+     * ACK together with the se=
rver session id (the cookie): reliable_ack_write()
+     * only emits that =
session id when at least one ACK is present, and the server
+     * needs i=
t to validate the stateless cookie=2E */
+    reliable_ack_acknowledge_pack=
et_id(ks->rec_ack, 0);
+
+    /* Skip one (RESET) packet in each direction,=
 so ids start at 1 (see
+     * session_skip_to_pre_start)=2E */
+    ks->r=
ec_reliable->packet_id =3D 1;
+    session->tls_wrap=2Eopt=2Epacket_id=2Ese=
nd=2Eid =3D 1;
+
+    /* Do not send our own HARD_RESET=2E Unlike the serve=
r's skip, the client must
+     * send first: the stateless server only rep=
lies once it sees our third
+     * packet=2E session_move_pre_start(skip=
=3Dtrue) leaves us in S_PRE_START_SKIP,
+     * which only advances when a =
packet is *received*; instead drop to
+     * S_PRE_START with an empty sen=
d-reliable (the initial packet was generated
+     * and immediately delete=
d), so tls_process() promotes us to S_START and
+     * sends the ClientHel=
lo without waiting for a server reset=2E */
+    if (!session_move_pre_star=
t(session, ks, true))
+    {
+        return false;
+    }
+    ks->state =
=3D S_PRE_START;
+    return true;
+}
+
 /**
  * Parses the TLVs (type, len=
gth, value) in the early negotiation
  */
diff --git a/src/openvpn/ssl=2Eh =
b/src/openvpn/ssl=2Eh
index 7ddf965=2E=2Ea534007 100644
--- a/src/openvpn/s=
sl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -576,4 +576,21 @@
 bool session_skip_to=
_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *state=
,
                                struct link_socket_actual *from);
 
+/**
=
+ * Client counterpart of session_skip_to_pre_start(): start the handshake =
from a
+ * server session id (SYN-cookie) learned earlier from an OOB serve=
r probe
+ * reply, which already served as the server's HARD_RESET, so we s=
end none=2E
+ *
+ * @param session     the (client) TLS session to fast-for=
ward
+ * @param client_sid  session id used for the probe (the cookie is an=
 HMAC over it)
+ * @param server_sid  the server's cookie, echoed back to c=
omplete the handshake
+ * @param remote      the probed (pinned) server add=
ress to connect to
+ * @param resend_wkc  true to complete with P_CONTROL_W=
KC_V1 (tls-crypt-v2)
+ * @return true if the session was fast-forwarded, fa=
lse on failure
+ */
+bool session_skip_to_pre_start_client(struct tls_sessi=
on *session,
+                                      const struct session_id=
 *client_sid,
+                                      const struct session_i=
d *server_sid,
+                                      const struct openvpn_=
sockaddr *remote, bool resend_wkc);
+
 #endif /* ifndef OPENVPN_SSL_H */

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I454d5040cbad4d373e=
e4f90b8d683200d2a4c0e4
Gerrit-Change-Number: 1770
Gerrit-PatchSet: 21
Gerri=
t-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Bn0wNATrdvo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #21</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/21</pre><pre st=
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
ons=2Erst</span><br><span>index dc746a9=2E=2E28ad8dd 100644</span><br><span=
>--- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-=
sections/client-options=2Erst</span><br><span>@@ -642,8 +642,34 @@</span><b=
r><span>   away from its own clock, so a client whose clock is badly wrong =
may get</span><br><span>   no replies and then keeps the configured order=
=2E Ordering by probe</span><br><span>   replaces any order that</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  ``--remote-random`` produced=
=2E See ``--server-probe-reply`` for the</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  server side=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  ``--remote-random`` produced=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  When the winning server supports it, the probe exchange also s=
tarts the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  handshak=
e: its reply stands in for the server&#39;s reset packet, so the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  client sends no reset of its=
 own and the connection is established one</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  round trip sooner=2E This has consequences worth k=
nowing:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  - the connection reuses the p=
robe&#39;s socket, and therefore its source</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    port, which matters where firewall or NAT rules=
 pin a port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  - the=
 connection is pinned to the address that answered, rather than</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    trying that remote&#39;s re=
solved addresses in turn;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  - the server honours its reply only for a limited time (see</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ``--server-probe-reply`=
`), so an unusually slow start-up, such as a</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    private key passphrase or token prompt, can ou=
tlast it; the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    then falls back to a normal handshake;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  - a handshake started this way is given only a fe=
w seconds to draw a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    response, rather than ``--hand-window``=2E If none arrives the client</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    logs a key negoti=
ation timeout, restarts the attempt and moves on to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    the next address or remote, so that s=
erver is not retried during this</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    cycle=2E The server answered a probe moments earlier, so s=
ilence means</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    it =
did not accept the reply as a reset, which happens when a load</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    balancer sends the probe and=
 the handshake to different instances,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    when NAT changes the source port, or when the server=
 rotated its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ses=
sion id key=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  The handshake shortcut=
 is not used on Windows while DCO is active=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  See ``--server-probe-reply`` for the server side=2E</span><br><sp=
an> </span><br><span> --static-challenge args</span><br><span>   Enable sta=
tic challenge/response protocol</span><br><span>diff --git a/src/openvpn/in=
it=2Ec b/src/openvpn/init=2Ec</span><br><span>index e506dfe=2E=2Ea683be4 10=
0644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/o=
penvpn/init=2Ec</span><br><span>@@ -3474,6 +3474,43 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Give up the probe socket and the handshake shortcut =
that came with it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_=
probe_drop_adoption(struct context *c)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    openvpn_close_socket(c-&gt;c2=2Eoob_probe_sd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UN=
DEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c=
2=2Eoob_probe_adopt =3D false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* The probe socket and th=
e handshake shortcut belong to the remote that</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * answered: give them up if next_connection_ent=
ry() picked a different one=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+oob_probe_confirm_adoption(struct context *c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!c-&gt;c2=2Eoob_probe_adopt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* next_conne=
ction_entry() maps the entry by value and the management</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * interface may then rewrite that=
 copy, so compare what we ended up with,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * not just which entry was picked=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct connection_l=
ist *l =3D c-&gt;options=2Econnection_list;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct connection_entry *won =3D c-&gt;c2=
=2Eoob_probe_ce;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct connection_entry *ce =3D &amp;c-&gt;options=2Ece;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (l-&gt;array[l-&gt;curre=
nt] =3D=3D won &amp;&amp; proto_is_udp(ce-&gt;proto) &amp;&amp; !ce-&gt;soc=
ks_proxy_server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    &amp;&amp; !ce-&gt;http_proxy_options &amp;&amp; ce-&gt;remote &amp;&am=
p; won-&gt;remote</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      &amp;&amp; streq(ce-&gt;remote, won-&gt;remote) &amp;&amp; ce-&gt;rem=
ote_port &amp;&amp; won-&gt;remote_port</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        &amp;&amp; streq(ce-&gt;remote_port, won-&gt;re=
mote_port))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: a different remote was s=
elected, not adopting the probe socket&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    oob_probe_drop_adoption(c);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> do_init=
_frame_tls(struct context *c)</span><br><span> {</span><br><span>@@ -3486,6=
 +3523,32 @@</span><br><span>         /* Keep the max mtu also in the frame=
 of tls multi so it can access</span><br><span>          * it in push_peer_=
info */</span><br><span>         c-&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Etun=
_max_mtu =3D c-&gt;c2=2Eframe=2Etun_max_mtu;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* OOB server probe: the reply already served as the server&#=
39;s HARD_RESET</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * (it carried a valid SYN-cookie), so the handshake starts from it and=
 we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * send =
no reset of our own=2E Count it as the initial packet received, as</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * the server does, =
so check_server_poll_timeout() does not restart us=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * The reply only stands for as l=
ong as the server advertised, which a</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * passphrase or token prompt can outlast=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        update_time()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;=
c2=2Eoob_probe_adopt</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &amp;&amp; now &gt;=3D c-&gt;c2=2Eoob_probe_reply_at + c-&gt;c=
2=2Eoob_probe_connect_lifetime)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(D_LOW,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;server-probe: the reply&#39;s connect-lifetime (=
%d s) elapsed before the handshake&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                &quot; could start; connecting normall=
y&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     c-&gt;c2=2Eoob_probe_connect_lifetime);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            oob_probe_drop_adoption(c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (c-&gt;c2=2Eoob_probe_adopt)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_multi-&gt;n_sessions++=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sessio=
n_skip_to_pre_start_client(&amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                           &amp;c-&gt;c2=2Eoob_probe_client_sid,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
               &amp;c-&gt;c2=2Eoob_probe_server_sid, &amp;c-&gt;c2=2Eoob_pr=
obe_remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                     c-&gt;c2=2Eoob_probe_resend_wkc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n>     }</span><br><span>     if (c-&gt;c2=2Etls_auth_standalone)</span><br=
><span>     {</span><br><span>@@ -4491,6 +4554,8 @@</span><br><span>     /*=
 map in current connection entry */</span><br><span>     next_connection_en=
try(c);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    oob_probe_confirm_adoption(c);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     /* should we disable paging? */<=
/span><br><span>     if (c-&gt;first_time &amp;&amp; options-&gt;mlock)</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/=
openvpn/oob=2Eh</span><br><span>index 09780c8=2E=2Ef7679eeb 100644</span><b=
r><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh=
</span><br><span>@@ -197,8 +197,12 @@</span><br><span> {</span><br><span>  =
   int index;</span><br><span>     bool responded;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    unsigned int rtt_ms;          /* probe rou=
nd-trip time in ms (responders only) */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct oob_probe_reply reply; /* the values the serve=
r advertised */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
unsigned int rtt_ms; /* probe round-trip time in ms (responders only) */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Captured from t=
he packet and its reply TLV (responders only): */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct session_id server_sid;      /* the=
 packet&#39;s own session id =3D server SYN-cookie */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    time_t received_at;                /*=
 when the reply arrived, for its connect_lifetime */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr responder; /*=
 address that answered (pin the connection to it) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply reply;      /*=
 the values the server advertised */</span><br><span> };</span><br><span> <=
/span><br><span> /* Where the client probed one connection entry: its resol=
ved addresses=2E */</span><br><span>diff --git a/src/openvpn/oob_client=2Ec=
 b/src/openvpn/oob_client=2Ec</span><br><span>index 5e949f4=2E=2Ee545aaf 10=
0644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b=
/src/openvpn/oob_client=2Ec</span><br><span>@@ -38,6 +38,7 @@</span><br><sp=
an> #include &quot;otime=2Eh&quot;</span><br><span> #include &quot;fdmisc=
=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;dco=2Eh&quot;</span>=
<br><span> #include &quot;error=2Eh&quot;</span><br><span> </span><br><span=
> #include &quot;memdbg=2Eh&quot;</span><br><span>@@ -404,6 +405,20 @@</spa=
n><br><span>         return;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The reply&#39;s ow=
n session id (the server&#39;s stateless SYN-cookie) follows the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * opcode byte=2E Capture =
it before read_control_auth() strips it: a client may</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * reuse it to start the handshake fr=
om this reply (the connect_lifetime</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * advertisement)=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct session_id server_sid;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    memcpy(server_sid=2Eid, data + 1,=
 SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!session_id_defined(&amp;server_sid))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* No usable cookie, and starting a handshake from it would ass=
ert in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * re=
liable_ack_write()=2E tls_pre_decrypt() rejects an undefined session</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * id the same way=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct bu=
ffer buf;</span><br><span>     buf_set_read(&amp;buf, data, (size_t)len);</=
span><br><span> </span><br><span>@@ -449,6 +464,9 @@</span><br><span> </spa=
n><br><span>         results[i]=2Eresponded =3D true;</span><br><span>     =
    results[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Eserver_sid=
 =3D server_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     results[i]=2Ereceived_at =3D rcv=2Etv_sec;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        results[i]=2Eresponder =3D *from; /* pi=
n the connection to the address that answered */</span><br><span>         r=
esults[i]=2Ereply =3D reply;</span><br><span> </span><br><span>         i =
=3D oob_probe_next_target_at(from, targets, results, n, i + 1);</span><br><=
span>@@ -823,11 +841,6 @@</span><br><span>         oob_probe_collect(&amp;p=
c, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wrap, targets, results, l-=
&gt;len,</span><br><span>                           c-&gt;sig);</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    oob_pr=
obe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (bind_local)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free=
addrinfo(bind_local);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span> </span><br><span>     /* Log each remote&#39;s outco=
me while results[i] still maps to array[i]=2E */</span><br><span>     int r=
esponded =3D 0;</span><br><span>@@ -843,10 +856,10 @@</span><br><span>     =
        int margin =3D oob_effective_margin(&amp;results[i], client_margin)=
;</span><br><span>             const char *margin_src =3D client_margin &gt=
;=3D 0 ? &quot;client&quot; : &quot;server-advertised&quot;;</span><br><spa=
n>             msg(D_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                &quot;server-probe: %s:%s answered (priority %d, weight=
 %d, rtt %u ms;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                &quot; latency margin %d ms [%s])&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                &quot;server-probe: %s=
:%s answered (priority %d, weight %d, connect-lifetime %d s,&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                &quot; rtt %=
u ms; latency margin %d ms [%s])&quot;,</span><br><span>                 ce=
-&gt;remote, ce-&gt;remote_port, results[i]=2Ereply=2Epriority, results[i]=
=2Ereply=2Eweight,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             results[i]=2Ertt_ms, margin, margin_src);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                results[i]=2Ereply=2Econ=
nect_lifetime, results[i]=2Ertt_ms, margin, margin_src);</span><br><span>  =
       }</span><br><span>         else</span><br><span>         {</span><br=
><span>@@ -868,6 +881,81 @@</span><br><span>     msg(M_INFO, &quot;server-p=
robe: %d of %d probed remote(s) answered; connecting best-first&quot;,</spa=
n><br><span>         responded, sent_count);</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* If the winner advertised =
a connect_lifetime, its reply also served as the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * server&#39;s reset: hand its probe sock=
et and the captured cookie to the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * connection, which then starts the handshake from that =
reply (see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * se=
ssion_skip_to_pre_start_client)=2E Reusing that socket keeps the source</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * IP+port the cook=
ie is bound to=2E dco-win cannot hand a socket to the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * kernel, so it only gets the probe =
ordering=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool probe_start =3D=
 results[0]=2Eresponded &amp;&amp; results[0]=2Ereply=2Econnect_lifetime &g=
t; 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool wkc_g=
ate =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Our first packet carries the WKc only if the server asked for it; without=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * that a state=
less tls-crypt-v2 server cannot decrypt it=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (probe_start &amp;&amp; tas-&gt;tls_wra=
p=2Etls_crypt_v2_wkc</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        &amp;&amp; !(results[0]=2Ereply=2Eflags &amp; OOB_PROBE_REPLY_FLAG=
_RESEND_WKC))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_start =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        w=
kc_gate =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool dco_win=
_gate =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        probe_start =3D false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dco_win_gate =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (probe_start)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
int af_idx =3D probe_af_index(results[0]=2Eresponder=2Eaddr=2Esa=2Esa_famil=
y);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=
=2Eoob_probe_sd =3D pc=2Esd[af_idx];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        pc=2Esd[af_idx] =3D SOCKET_UNDEFINED; /* relinquis=
h: the connection owns it now */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  c-&gt;c2=2Eoob_probe_remote =3D results[0]=2Eresponder;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_client_s=
id =3D client_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       c-&gt;c2=2Eoob_probe_server_sid =3D results[0]=2Eserver_sid;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_prob=
e_resend_wkc =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         (results[0]=2Ereply=2Eflags &amp; OOB_PROBE_REPLY_FLAG_RESEND_WKC)=
 !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&=
gt;c2=2Eoob_probe_adopt =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        c-&gt;c2=2Eoob_probe_ce =3D l-&gt;array[0];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_=
reply_at =3D results[0]=2Ereceived_at;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_connect_lifetime =3D result=
s[0]=2Ereply=2Econnect_lifetime;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(D_LOW, &quot;server-probe: starting handshake from probe reply of %s:=
%s&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
        &quot; (connect-lifetime %d s)&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            l-&gt;array[0]-&gt;remote, l-&gt;arra=
y[0]-&gt;remote_port, results[0]=2Ereply=2Econnect_lifetime);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else if (results[0]=2Eresponded)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* A server answered but we won&#39;=
t start the handshake from it -- say why=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (dco_win_gate)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: cannot s=
tart the handshake from a probe reply&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                       &quot; with dco-win;&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
  &quot; using a full handshake&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        else if (wkc_gate)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(D_LOW, &quot;server-probe: %s:%s did not ask for the=
 wrapped client key;&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                       &quot; using a full handshake&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                l-&gt;array[=
0]-&gt;remote, l-&gt;array[0]-&gt;remote_port);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else if (results[0]=2Ereply=2Econnect_lifetime =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LO=
W, &quot;server-probe: %s:%s did not advertise a connect-lifetime&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
&quot; (connect-lifetime 0); using a full handshake&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                l-&gt;array[0]-&gt;r=
emote, l-&gt;array[0]-&gt;remote_port);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Close any probe =
sockets we did not hand off to the connection=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (bind_local)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        freeaddrinfo(bind_local);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     oob_probe_free=
_wrap(c, tas);</span><br><span>     gc_free(&amp;gc);</span><br><span> }</s=
pan><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2E=
h</span><br><span>index 09c6a3c=2E=2E4278cea 100644</span><br><span>--- a/s=
rc/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span>=
<br><span>@@ -248,8 +248,14 @@</span><br><span>      * address probed) as t=
he outgoing address, so the source IP+port and the</span><br><span>      * =
destination match what the server&#39;s handshake cookie is bound to=2E */<=
/span><br><span>     bool oob_probe_adopt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const struct connection_entry *oob_probe_ce; /* =
the entry the probe won on */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    time_t oob_probe_reply_at;                   /* when its repl=
y arrived */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 oob_probe_connect_lifetime;              /* how long that reply stays usab=
le */</span><br><span>     socket_descriptor_t oob_probe_sd;</span><br><spa=
n>     struct openvpn_sockaddr oob_probe_remote;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct session_id oob_probe_client_sid;  /=
* our probe session id (cookie was minted over it) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id oob_probe_server_si=
d;  /* the reply&#39;s session id =3D server cookie to echo back */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    bool oob_probe_resend_w=
kc;               /* reply asked to complete with CONTROL_WKC_V1 (v2) */</s=
pan><br><span> </span><br><span>     struct link_socket_actual *to_link_add=
r; /* IP address of remote */</span><br><span>     struct link_socket_actua=
l from;          /* address of incoming datagram */</span><br><span>diff --=
git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index f0cd7=
20=2E=2Ea350e64 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br>=
<span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2587,6 +2587,61 @@</spa=
n><br><span>     return session_move_pre_start(session, ks, true);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sessio=
n_skip_to_pre_start_client(struct tls_session *session, const struct sessio=
n_id *client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                               const struct session_id *server_sid,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
      const struct openvpn_sockaddr *remote, bool resend_wkc)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct key_state *ks =3D &amp;session-&gt;key[K=
S_PRIMARY];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Our session id must =
be the one used for the probe: the server&#39;s cookie</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * (server_sid) is an HMAC over it, =
and the server re-derives and checks it</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * when it validates our third packet=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;session_id =
=3D *client_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ks-&gt;session_id_remote =3D *server_sid;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct link_socket_actual act =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    act=2Edest =3D *remote;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;remote_addr =3D act;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;untrusted_=
addr =3D act;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    se=
ssion-&gt;burst =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tls-cr=
ypt-v2: the stateless server discarded the WKc after the probe, so</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * complete the handshak=
e with P_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * The flag comes from the rep=
ly, so only act on it when this client has a</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * WKc to resend=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (resend_wkc &amp;&amp; session-&gt=
;tls_wrap=2Etls_crypt_v2_wkc)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ks-&gt;crypto_options=2Eflags |=3D CO_RESEND_WKC;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* We never received the server&#39;s HARD_RESET (id 0) -- the probe r=
eply stood</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in=
 for it=2E Acknowledge that phantom id 0 so our third packet carries an</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ACK together wit=
h the server session id (the cookie): reliable_ack_write()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * only emits that session id wh=
en at least one ACK is present, and the server</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * needs it to validate the stateless cookie=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reliable_=
ack_acknowledge_packet_id(ks-&gt;rec_ack, 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Skip one (RESET) packet in each direction, so ids start at 1 =
(see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * session_=
skip_to_pre_start)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ks-&gt;rec_reliable-&gt;packet_id =3D 1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    session-&gt;tls_wrap=2Eopt=2Epacket_id=2E=
send=2Eid =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Do not send our=
 own HARD_RESET=2E Unlike the server&#39;s skip, the client must</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * send first: the statele=
ss server only replies once it sees our third</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * packet=2E session_move_pre_start(skip=3Dtr=
ue) leaves us in S_PRE_START_SKIP,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * which only advances when a packet is *received*; inst=
ead drop to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * S=
_PRE_START with an empty send-reliable (the initial packet was generated</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and immediately=
 deleted), so tls_process() promotes us to S_START and</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * sends the ClientHello without wai=
ting for a server reset=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!session_move_pre_start(session, ks, true))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ks-&gt;state =3D S_PRE_START;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> /**</span><br><span>  * Parses the TLVs (type, l=
ength, value) in the early negotiation</span><br><span>  */</span><br><span=
>diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>ind=
ex 7ddf965=2E=2Ea534007 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</s=
pan><br><span>+++ b/src/openvpn/ssl=2Eh</span><br><span>@@ -576,4 +576,21 @=
@</span><br><span> bool session_skip_to_pre_start(struct tls_session *sessi=
on, struct tls_pre_decrypt_state *state,</span><br><span>                  =
              struct link_socket_actual *from);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Client counterpart of session_skip_to_pre_=
start(): start the handshake from a</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * server session id (SYN-cookie) learned earlier from an O=
OB server probe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * r=
eply, which already served as the server&#39;s HARD_RESET, so we send none=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param session     the (client=
) TLS session to fast-forward</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param client_sid  session id used for the probe (the cookie i=
s an HMAC over it)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param server_sid  the server&#39;s cookie, echoed back to complete the h=
andshake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param r=
emote      the probed (pinned) server address to connect to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param resend_wkc  true to compl=
ete with P_CONTROL_WKC_V1 (tls-crypt-v2)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return true if the session was fast-forwarded, fal=
se on failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool session_skip_to_p=
re_start_client(struct tls_session *session,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                      const struct=
 session_id *client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                      const struct session_id *server_=
sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                       const struct openvpn_sockaddr *remote, bool resend_w=
kc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #endif /* ifndef OPENVPN_SSL_H */</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=
=3Demail">change 1770</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1770?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1770 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Bn0wNATrdvo=--


--===============3242684818762158625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3242684818762158625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3242684818762158625==--

