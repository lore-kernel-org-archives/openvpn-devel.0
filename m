Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37273CA5FC5
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dwc+xVQ1FCK7tXZjGOl4/AAImGeM8DcDsAtKku444Es=; b=Xb6gAol3UZNh27LlRedX+uX3TX
	IqJIXBBX8GbANAf6dkA1wPD/bNUwNFPQCU2OT4cUWuRbidHh95fHCeLvyWaQj5u/e74IeRHDWVK4J
	sYartO9BYywVcYNf1CJmzJtyopCbKggN5WIFXJJDQiUkKJ6V2+zOYHt3k9vC8jlgRKO8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xC0mq-0000Q9-P2;
	Wed, 30 Sep 2026 20:20:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xC0mp-0000Q3-Mt
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 20:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pQMaFPYDe1LOxWwtDpOMtoMHSz7ze3MqLhBsxsanr28=; b=NpEsUfjaRYxkJl47LejGBPE2W7
 4BmQhEZtzjv1V5e9MRhDy6CXLKvIlsjIXX5E8jrioBUD+P4QiIZI1oQ27l/TZWzaRBWxzQyiov56c
 a0PBonUb6pAjW3UPcuy+nlRybsDeNccWGtNH9kfjmy98AOKaAeWC5UNxAx+gNtLHgqbI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pQMaFPYDe1LOxWwtDpOMtoMHSz7ze3MqLhBsxsanr28=; b=T
 k1jFy4z3HaA2TfWKKYVOf2pd+BQG9hbfNV8Y/0aBR9y/KfJnCX5L/vyhimvAPVHxAQqZzEASIoC7k
 OPccCjDaqxgJvmgzeFbpkPlCa1pn78W6IJj/mEpTxkl9yKuS0AwBVBxu0SqcBmo/8kGpWX5kbnbqe
 SsdY0AwqxhPtVzbo=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xC0mj-0006WS-LH for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 20:20:19 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a01ff8c098so51925e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790799607; x=1791404407; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pQMaFPYDe1LOxWwtDpOMtoMHSz7ze3MqLhBsxsanr28=;
 b=b4SHWGyoBtJfItA9GOAf9w/HWWb8oE/+uKwEyjEu95qArWmnHFeo4bqk5zreVkyHxH
 bHGGEKH5n6l0ftaUEQFkKBJfPjmQxPUXHTd/fRHcSV1cnXMAhOcrZHEBE+Yryhl1NXbG
 buq+rAUFFxmnS7qAsZvAisX8gzRn3CUye/QkycDloWKz2t3D0TZ80oxv/Qs3agq/pJGK
 CChJjH66R8nQtCgAt9eATsKEAiGUhmOnFC8ziS/zbkQ4EdUCRKYqJ9jkagCrHzytbVt+
 dyEAyb8kTWLvsgtNpmkz2aWGHP/v5vv3i87DTHJEbvuYEm1Di1+saIax3KY1RrFyHxrH
 meiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790799607; x=1791404407;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pQMaFPYDe1LOxWwtDpOMtoMHSz7ze3MqLhBsxsanr28=;
 b=Eaf0gyq9W5PaL2nEod3GkNfa4EPTq9f2pXpySm7fVYJHRJj4da5zRqjKTBokh2uIaT
 0xJze4PzKqo1BTyvzihgbnb3GGRtuhTb/rwAT91DBXn/ixR/ZIkdapL9fjMxYo3BS/W4
 o6mU8IY9D/pOLh8nz8FZQioiYy1a9NQMx0P8Q/vIMLsCCChVKo8nDkpHPL95mXMhvhV9
 2zbQNbF+ZZPa/kNdebVUb6PPHa+kfKv9eCGADdemCB437D02BIQ2ga7367Dj91+ph4CU
 RvI6i1ss/DWjtyXkCVYdEXNJFqgdU6pofY5mHxDXY11GMv5wlEGIzlHBelgCE4yGVyqs
 1BjA==
X-Gm-Message-State: AFuF++mQzQ/LomF9KChsA14tLzCFnRQD+8AHtv42rF/uY7EX3zVPPA6m
 ekGbw4941YwgYDbh7CUHmffuogaZDOol46EHISBDCTVdDxsJHH0++rrncHkIoYEMWU7O9tljr+u
 h/U4ae/86Ix7IEezLGLCJEoD2BE+Mg6+MtckF6PrnBNhwkF5VdPTjTqgSehwR+USEjMFcjgUilT
 IcBaWajA==
X-Gm-Gg: AYBFou36arDF56Czp31MgZ+ieEjM2aCwI8/RExUjaPYKca/w7DRpSD4pMHeU/TWiID5
 qSKiMlnDBUWiq1H5z8p3aZoKj1p5M4KwUQOkMSGfMdE/iH1Un2pISvx7zRhwMoYuYwsnOlEwS3i
 f33Aik0aD0whc4EkMhAMotZP73etUblIqw/0kLB811URjmgn4H1C6n+7xak2Vexiu/o8eZKBthy
 uqX22IGaAs73xU4BZp3tdaff7OubdphWy8O9Jpk/knN4XKFZgVpTUcWI2T2AMrOM9kpXKE/n+0d
 c70D6exS4jT6SdqEaM07KpuCZffdoV9ZMlHH1dVhRt1DftmnV4+O++dFAFGjJXZZ85ba7Uy7YdO
 KP1wFSvAClZfHIpS7Vb8jVLwHwJvXh3MFhUyxoiPb9fi7mklNUiLOpunM4a01m/cFgLjClxz3KM
 c50OKgVCl7zip2dR96xP2nJDwt8LCUihTMhEWZGNLfq7QR6ZM6BBa6KwdSmHAfR2EfwLcP3Qygx
 iLmajr70jVndIVmdYH+dcNXkWvPvZ4WkTYHFbzYmVGqB0Qz44BGxqV4NEBa+J4Yf3qkOyloirEw
 J/8J7Z5LpeXd/YcUjhu9QTs2OjeiEFcLkQjDEi3nQRgRBbYnA/8e3sCS0WYAbsUPL+0bN2o=
X-Received: by 2002:a05:600c:1c11:b0:49f:bd0d:59f5 with SMTP id
 5b1f17b1804b1-4a01afff3dbmr53181195e9.18.1790799606803; 
 Wed, 30 Sep 2026 13:20:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f91466asm8768295e9.4.2026.09.30.13.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:20:06 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 20:19:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: bbd5d34254dd376aadf7e0eb05717950bda17bc8
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <be7055a4de32d3a4db6f3bb0f43ead195e91d4ad-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xC0mj-0006WS-LH
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Start the
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
Content-Type: multipart/mixed; boundary="===============3652031265310967386=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3652031265310967386==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WXlMx16uRdQ="; charset=UTF-8

--WXlMx16uRdQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#28)=2E
=


Change subject: oob: Start the client handshake from the server probe
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Start the c=
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
der address, its resolved address list
    and the resend-wkc flag to the c=
onnection via c2, and relinquish
    that socket=2E Gated off for dco-win, =
which has no user-to-kernel
    socket handoff (probing still works, only s=
tarting from the reply is
    skipped)=2E
  - oob_client=2Ec: resolve each =
remote as the connection would, from the
    --preresolve cache when there =
is one (hence get_cached_dns_entry()
    is exported), and keep the lookups=
, so the winner's becomes the
    connection's remote list (see the previou=
s commit)=2E
  - ssl=2Ec session_skip_to_pre_start_client(): seed our sessi=
on id to the
    probe's (the cookie is an HMAC over it), the remote sessio=
n id to
    the cookie, ack the phantom server reset (id 0) so the third pa=
cket
    carries the cookie, set CO_RESEND_WKC for tls-crypt-v2, and drop t=
o
    S_PRE_START so tls_process() promotes to S_START and sends the
    Cl=
ientHello (no HARD_RESET sent)=2E
  - init=2Ec: invoke the client skip afte=
r tls_multi_init_finalize when
    adopting, and count the probe reply as t=
he initial packet received
    (n_sessions++, as the server does before its=
 own
    session_skip_to_pre_start) so check_server_poll_timeout() does not=

    restart the connected session=2E

Three things guard the shortcut=2E T=
he reply's session id is rejected
unless it is defined: it becomes the remo=
te session id, and the phantom
ACK means reliable_ack_write() would assert =
on an all-zero one, so a
server -- or, without tls-auth/tls-crypt, anyone w=
ho answers first --
could otherwise kill the client with a single packet=2E=


The probe socket and the cookie belong to the remote that answered, so
bo=
th are given up unless next_connection_entry() selected that same
remote=2E=
 The entry is mapped by value and the management interface may
rewrite the =
copy, so the check compares the resulting host, port and
proxy settings rat=
her than which entry was picked=2E

Finally, the server honours its reply o=
nly for the advertised
connect_lifetime, which a passphrase or token prompt=
 during init can
outlast; the shortcut is dropped when it has elapsed=2E As=
 the spec asks,
it is counted from when the probe request the reply answers=
 was sent,
not from when the reply arrived=2E

Change-Id: I454d5040cbad4d37=
3ee4f90b8d683200d2a4c0e4
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
--=
-
M Changes=2Emd
M doc/man-sections/client-options=2Erst
M src/openvpn/init=
=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/oob_client=2Ec
M src/openvpn/openv=
pn=2Eh
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/ssl=
=2Ec
M src/openvpn/ssl=2Eh
10 files changed, 327 insertions(+), 20 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/7=
0/1770/28

diff --git a/Changes=2Emd b/Changes=2Emd
index cb85456=2E=2Efb92=
bef 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -10,6 +10,14 @@
   weig=
ht with DNS-SRV-like semantics=2E Servers advertise these values with
   `-=
-server-probe-reply`=2E
 
+* **Probe exchange doubles as the start of the h=
andshake**
+
+  When a probing client picks a server that advertises suppor=
t for it, the probe
+  and its reply take the place of the client's and ser=
ver's reset packets, so the
+  client does not need a separate reset exchan=
ge before the handshake=2E This saves
+  one round trip compared with probi=
ng and then connecting, and needs no extra
+  configuration=2E
+
 ## User-v=
isible Changes
 
 * **Parsing Distinguished Names in certificates**
diff --=
git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-optio=
ns=2Erst
index 370ef60=2E=2E80f760f 100644
--- a/doc/man-sections/client-op=
tions=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -646,8 +646,25 @=
@
   probes per period whose timestamp is more than its ``--hand-window``
 =
  away from its own clock, so a client whose clock is badly wrong may get
 =
  no replies and then keeps the configured order=2E Ordering by probe
-  re=
places any order that ``--remote-random`` produced=2E See
-  ``--server-pro=
be-reply`` for the server side=2E
+  replaces any order that ``--remote-ran=
dom`` produced=2E
+
+  When the winning server supports it, the probe excha=
nge also starts the
+  handshake: its reply stands in for the server's rese=
t packet, so the
+  client sends no reset of its own and the connection is =
established one
+  round trip sooner=2E This has consequences worth knowing=
:
+
+  - the connection reuses the probe's socket, and therefore its source=

+    port, which matters where firewall or NAT rules pin a port;
+  - the =
connection first tries the address that answered, rather than
+    the remo=
te's first resolved address;
+  - the server honours its reply only for a l=
imited time (see
+    ``--server-probe-reply``), so an unusually slow start=
-up, such as a
+    private key passphrase or token prompt, can outlast it;=
 the client
+    then falls back to a normal handshake=2E
+
+  The handshak=
e shortcut is not used on Windows while DCO is active=2E
+
+  See ``--serve=
r-probe-reply`` for the server side=2E
 
 --static-challenge args
   Enable=
 static challenge/response protocol
diff --git a/src/openvpn/init=2Ec b/src=
/openvpn/init=2Ec
index 5609534=2E=2E0848489 100644
--- a/src/openvpn/init=
=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3479,6 +3479,44 @@
     c->c2=2Eoob_pro=
be_remote_list =3D NULL;
 }
 
+/* Give up the probe socket and the handshak=
e shortcut that came with it=2E */
+static void
+oob_probe_drop_adoption(st=
ruct context *c)
+{
+    openvpn_close_socket(c->c2=2Eoob_probe_sd);
+    c=
->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
+    oob_probe_free_remote_list(c=
);
+    c->c2=2Eoob_probe_adopt =3D false;
+}
+
+/* The probe socket and th=
e handshake shortcut belong to the remote that
+ * answered: give them up i=
f next_connection_entry() picked a different one=2E */
+static void
+oob_pr=
obe_confirm_adoption(struct context *c)
+{
+    if (!c->c2=2Eoob_probe_adop=
t)
+    {
+        return;
+    }
+
+    /* next_connection_entry() maps th=
e entry by value and the management
+     * interface may then rewrite that=
 copy, so compare what we ended up with,
+     * not just which entry was p=
icked=2E */
+    const struct connection_list *l =3D c->options=2Econnectio=
n_list;
+    const struct connection_entry *won =3D c->c2=2Eoob_probe_ce;
+=
    const struct connection_entry *ce =3D &c->options=2Ece;
+    if (l->arr=
ay[l->current] =3D=3D won && proto_is_udp(ce->proto) && !ce->socks_proxy_se=
rver
+        && !ce->http_proxy_options && ce->remote && won->remote
+    =
    && streq(ce->remote, won->remote) && ce->remote_port && won->remote_por=
t
+        && streq(ce->remote_port, won->remote_port))
+    {
+        ret=
urn;
+    }
+
+    msg(D_LOW, "server-probe: a different remote was selecte=
d, not adopting the probe socket");
+    oob_probe_drop_adoption(c);
+}
+
 =
static void
 do_init_frame_tls(struct context *c)
 {
@@ -3491,6 +3529,33 @@=

         /* Keep the max mtu also in the frame of tls multi so it can acce=
ss
          * it in push_peer_info */
         c->c2=2Etls_multi->opt=2Efr=
ame=2Etun_max_mtu =3D c->c2=2Eframe=2Etun_max_mtu;
+
+        /* OOB server=
 probe: the reply already served as the server's HARD_RESET
+         * (it=
 carried a valid SYN-cookie), so the handshake starts from it and we
+     =
    * send no reset of our own=2E Count it as the initial packet received, =
as
+         * the server does, so check_server_poll_timeout() does not res=
tart us=2E
+         * The reply only stands for as long as the server adve=
rtised, counted
+         * from when we sent the probe request it answers,=
 which a passphrase or
+         * token prompt can outlast=2E */
+        =
update_time();
+        if (c->c2=2Eoob_probe_adopt
+            && now >=
=3D c->c2=2Eoob_probe_probed_at + c->c2=2Eoob_probe_connect_lifetime)
+    =
    {
+            msg(D_LOW,
+                "server-probe: the reply's c=
onnect-lifetime (%d s) elapsed before the handshake"
+                " cou=
ld start; connecting normally",
+                c->c2=2Eoob_probe_connect_=
lifetime);
+            oob_probe_drop_adoption(c);
+        }
+
+        i=
f (c->c2=2Eoob_probe_adopt)
+        {
+            c->c2=2Etls_multi->n_se=
ssions++;
+            session_skip_to_pre_start_client(&c->c2=2Etls_multi-=
>session[TM_ACTIVE],
+                                             &c->c2=
=2Eoob_probe_client_sid,
+                                             &c->=
c2=2Eoob_probe_server_sid, &c->c2=2Eoob_probe_remote,
+                    =
                         c->c2=2Eoob_probe_resend_wkc);
+        }
     }
 =
    if (c->c2=2Etls_auth_standalone)
     {
@@ -4497,6 +4562,8 @@
     /* m=
ap in current connection entry */
     next_connection_entry(c);
 
+    oob=
_probe_confirm_adoption(c);
+
     /* should we disable paging? */
     if =
(c->first_time && options->mlock)
     {
diff --git a/src/openvpn/oob=2Eh b=
/src/openvpn/oob=2Eh
index b87e1a0=2E=2E868b4d0 100644
--- a/src/openvpn/oo=
b=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -174,8 +174,12 @@
 {
     int index;
   =
  bool responded;
-    unsigned int rtt_ms;          /* probe round-trip ti=
me in ms (responders only) */
-    struct oob_probe_reply reply; /* the val=
ues the server advertised */
+    unsigned int rtt_ms; /* probe round-trip =
time in ms (responders only) */
+    /* Captured from the packet and its re=
ply TLV (responders only): */
+    struct session_id server_sid;      /* th=
e packet's own session id =3D server SYN-cookie */
+    time_t probed_at;  =
                /* when the probe request it answers was sent */
+    struc=
t openvpn_sockaddr responder; /* address that answered (pin the connection =
to it) */
+    struct oob_probe_reply reply;      /* the values the server =
advertised */
 };
 
 /* Where the client probed one connection entry: its r=
esolved addresses=2E */
diff --git a/src/openvpn/oob_client=2Ec b/src/openv=
pn/oob_client=2Ec
index 35c71e3=2E=2E9a9b4ca 100644
--- a/src/openvpn/oob_c=
lient=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -38,6 +38,7 @@
 #include "oti=
me=2Eh"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "dco=2Eh"
 =
#include "error=2Eh"
 
 #include "memdbg=2Eh"
@@ -365,6 +366,20 @@
     }
 =
}
 
+/* Free the lookups not handed to the connection; a --preresolve one b=
elongs to
+ * the DNS cache=2E */
+static void
+oob_probe_free_resolved(str=
uct addrinfo **resolved, const bool *cached, int n)
+{
+    for (int i =3D =
0; i < n; i++)
+    {
+        if (resolved[i] && !cached[i])
+        {
+ =
           freeaddrinfo(resolved[i]);
+        }
+    }
+}
+
 /* Does any a=
ddress of t have a probe socket of its family? */
 static bool
 oob_probe_t=
arget_reachable(const struct probe_ctx *pc, const struct oob_probe_target *=
t)
@@ -427,6 +442,20 @@
         return;
     }
 
+    /* The reply's own s=
ession id (the server's stateless SYN-cookie) follows the
+     * opcode by=
te=2E Capture it before read_control_auth() strips it: a client may
+     *=
 reuse it to start the handshake from this reply (the connect_lifetime
+   =
  * advertisement)=2E */
+    struct session_id server_sid;
+    memcpy(ser=
ver_sid=2Eid, data + 1, SID_SIZE);
+    if (!session_id_defined(&server_sid=
))
+    {
+        /* No usable cookie, and starting a handshake from it wo=
uld assert in
+         * reliable_ack_write()=2E tls_pre_decrypt() rejects=
 an undefined session
+         * id the same way=2E */
+        return;
+ =
   }
+
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)len);
=
 
@@ -461,6 +490,8 @@
     {
         return; /* answers no probe we sent t=
o that address */
     }
+    /* its connect_lifetime runs from when that p=
robe request was sent */
+    const time_t probed_at =3D pc->sends[reply=2E=
request_id - pc->id_base]=2Esent_at=2Etv_sec;
 
     /* Credit the reply to=
 every still-unanswered remote that was probed at its
      * source addres=
s: several entries can resolve to the same address, and each
@@ -471,6 +502=
,9 @@
     {
         results[i]=2Eresponded =3D true;
         results[i]=
=2Ertt_ms =3D (unsigned int)ms;
+        results[i]=2Eserver_sid =3D server=
_sid;
+        results[i]=2Eprobed_at =3D probed_at;
+        results[i]=2E=
responder =3D *from; /* pin the connection to the address that answered */
=
         results[i]=2Ereply =3D reply;
 
         i =3D oob_probe_next_targ=
et_at(from, targets, results, n, i + 1);
@@ -647,7 +681,8 @@
 
     struct =
gc_arena gc =3D gc_new();
 
-    /* A single random session id is the sende=
r session id of all our probes */
+    /* A single random session id for al=
l of our probes: the server's handshake
+     * cookie is computed over it,=
 so a handshake started from a reply uses it=2E */
     struct session_id c=
lient_sid;
     session_id_random(&client_sid);
 
@@ -725,8 +760,10 @@
    =
     l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 
     /* Resolve every remot=
e first, so only the address families actually in use
-     * get a probe s=
ocket=2E */
+     * get a probe socket=2E Each lookup is kept for the winne=
r's connection=2E */
     bool need_af[PROBE_AF_COUNT] =3D { false, false }=
;
+    struct addrinfo **resolved =3D gc_malloc(sizeof(*resolved) * l->len,=
 true, &gc);
+    bool *resolved_cached =3D gc_malloc(sizeof(*resolved_cach=
ed) * l->len, true, &gc);
     for (int i =3D 0; i < l->len; i++)
     {
  =
       results[i]=2Eindex =3D i;
@@ -743,15 +780,29 @@
             continu=
e;
         }
 
-        /* ce->af honours a udp4/udp6 remote, as the conne=
ction does */
+        /* Resolve as the connection would, from the --prere=
solve cache when
+         * there is one: the winner's connection takes th=
is list as its remote
+         * list=2E ce->af honours a udp4/udp6 remote=
, as the connection does=2E */
+        unsigned int flags =3D GETADDR_RESO=
LVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM;
+        if (c->options=2Esockfl=
ags & SF_HOST_RANDOMIZE)
+        {
+            flags |=3D GETADDR_RANDOMI=
ZE; /* --remote-random-hostname */
+        }
         struct addrinfo *ai =
=3D NULL;
-        int status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GET=
ADDR_TRY_ONCE | GETADDR_DATAGRAM,
-                                        =
 ce->remote, ce->remote_port, 0, NULL, ce->af, &ai);
-        if (status !=
=3D 0 || !ai)
+        resolved_cached[i] =3D get_cached_dns_entry(c->c1=2E=
dns_cache, ce->remote, ce->remote_port,
+                                  =
                ce->af, flags, &ai)
+                             =3D=3D 0;=

+        if (!resolved_cached[i]
+            && openvpn_getaddrinfo(flags=
, ce->remote, ce->remote_port, 0, NULL, ce->af, &ai) !=3D 0)
+        {
+  =
          ai =3D NULL;
+        }
+        if (!ai)
         {
            =
 msg(D_LOW, "server-probe: %s:%s: could not resolve", ce->remote, ce->remot=
e_port);
             continue;
         }
+        resolved[i] =3D ai;
 
 =
        /* Store every resolved address natively (no IPv4-mapping); each is=
 later
          * probed on its family's socket=2E */
@@ -770,7 +821,6 @@
=
             t->n_dests++;
             need_af[probe_af_index(a->ai_family=
)] =3D true;
         }
-        freeaddrinfo(ai);
     }
 
     struct add=
rinfo *bind_local =3D oob_probe_bind_addrinfo(tmpl, &c->options);
@@ -781,6=
 +831,7 @@
         {
             freeaddrinfo(bind_local);
         }
+  =
      oob_probe_free_resolved(resolved, resolved_cached, l->len);
         =
oob_probe_free_wrap(c, tas);
         gc_free(&gc);
         return;
@@ -81=
9,11 +870,6 @@
     {
         oob_probe_collect(&pc, targets, results, l->=
len, c->sig);
     }
-    oob_probe_sockets_close(&pc);
-    if (bind_local=
)
-    {
-        freeaddrinfo(bind_local);
-    }
 
     /* Log each remot=
e's outcome while results[i] still maps to array[i]=2E */
     int responde=
d =3D 0;
@@ -839,10 +885,10 @@
             int margin =3D oob_effective_ma=
rgin(&results[i], client_margin);
             const char *margin_src =3D c=
lient_margin >=3D 0 ? "client" : "server-advertised";
             msg(D_LO=
W,
-                "server-probe: %s:%s answered (priority %d, weight %d, =
rtt %u ms;"
-                " latency margin %d ms [%s])",
+              =
  "server-probe: %s:%s answered (priority %d, weight %d, connect-lifetime %=
d s,"
+                " rtt %u ms; latency margin %d ms [%s])",
          =
       ce->remote, ce->remote_port, results[i]=2Ereply=2Epriority, results[=
i]=2Ereply=2Eweight,
-                results[i]=2Ertt_ms, margin, margin_s=
rc);
+                results[i]=2Ereply=2Econnect_lifetime, results[i]=2Er=
tt_ms, margin, margin_src);
         }
         else
         {
@@ -864,6 +=
910,83 @@
     msg(M_INFO, "server-probe: %d of %d probed remote(s) answere=
d; connecting best-first",
         responded, sent_count);
 
+    /* If th=
e winner advertised a connect_lifetime, its reply also served as the
+     =
* server's reset: hand its probe socket and the captured cookie to the
+   =
  * connection, which then starts the handshake from that reply (see
+     =
* session_skip_to_pre_start_client)=2E Reusing that socket keeps the source=

+     * IP+port the cookie is bound to=2E dco-win cannot hand a socket to =
the
+     * kernel, so it only gets the probe ordering=2E */
+
+    bool pr=
obe_start =3D results[0]=2Eresponded && results[0]=2Ereply=2Econnect_lifeti=
me > 0;
+    bool wkc_gate =3D false;
+    /* Our first packet carries the =
WKc only if the server asked for it; without
+     * that a stateless tls-c=
rypt-v2 server cannot decrypt it=2E */
+    if (probe_start && tas->tls_wra=
p=2Etls_crypt_v2_wkc
+        && !(results[0]=2Ereply=2Eflags & OOB_PROBE_R=
EPLY_FLAG_RESEND_WKC))
+    {
+        probe_start =3D false;
+        wkc_=
gate =3D true;
+    }
+    bool dco_win_gate =3D false;
+#if defined(_WIN32=
)
+    if (dco_enabled(&c->options))
+    {
+        probe_start =3D false;=

+        dco_win_gate =3D true;
+    }
+#endif
+    if (probe_start)
+    =
{
+        const int af_idx =3D probe_af_index(results[0]=2Eresponder=2Eadd=
r=2Esa=2Esa_family);
+        c->c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];
+  =
      pc=2Esd[af_idx] =3D SOCKET_UNDEFINED; /* relinquish: the connection o=
wns it now */
+
+        c->c2=2Eoob_probe_remote =3D results[0]=2Eresponde=
r;
+        c->c2=2Eoob_probe_remote_list =3D resolved[results[0]=2Eindex];=

+        resolved[results[0]=2Eindex] =3D NULL; /* the connection's remote=
 list now */
+        c->c2=2Eoob_probe_client_sid =3D client_sid;
+       =
 c->c2=2Eoob_probe_server_sid =3D results[0]=2Eserver_sid;
+        c->c2=
=2Eoob_probe_resend_wkc =3D
+            (results[0]=2Ereply=2Eflags & OOB_=
PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;
+        c->c2=2Eoob_probe_adopt =3D t=
rue;
+        c->c2=2Eoob_probe_ce =3D l->array[0];
+        c->c2=2Eoob_pr=
obe_probed_at =3D results[0]=2Eprobed_at;
+        c->c2=2Eoob_probe_connec=
t_lifetime =3D results[0]=2Ereply=2Econnect_lifetime;
+
+        msg(D_LOW,=
 "server-probe: starting handshake from probe reply of %s:%s"
+            =
       " (connect-lifetime %d s)",
+            l->array[0]->remote, l->arr=
ay[0]->remote_port, results[0]=2Ereply=2Econnect_lifetime);
+    }
+    els=
e if (results[0]=2Eresponded)
+    {
+        /* A server answered but we w=
on't start the handshake from it -- say why=2E */
+        if (dco_win_gate=
)
+        {
+            msg(D_LOW, "server-probe: cannot start the handsh=
ake from a probe reply"
+                       " with dco-win; using a ful=
l handshake");
+        }
+        else if (wkc_gate)
+        {
+         =
   msg(D_LOW, "server-probe: %s:%s did not ask for the wrapped client key;"=

+                       " using a full handshake",
+                l->arr=
ay[0]->remote, l->array[0]->remote_port);
+        }
+        else if (resu=
lts[0]=2Ereply=2Econnect_lifetime =3D=3D 0)
+        {
+            msg(D_L=
OW, "server-probe: %s:%s did not advertise a connect-lifetime"
+           =
            " (connect-lifetime 0); using a full handshake",
+             =
   l->array[0]->remote, l->array[0]->remote_port);
+        }
+    }
+
+   =
 /* Close any probe sockets we did not hand off to the connection=2E */
+  =
  oob_probe_sockets_close(&pc);
+
+    if (bind_local)
+    {
+        free=
addrinfo(bind_local);
+    }
+    oob_probe_free_resolved(resolved, resolve=
d_cached, l->len);
     oob_probe_free_wrap(c, tas);
     gc_free(&gc);
 }
=
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index c0c6cc=
c=2E=2E3bb545e 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openv=
pn=2Eh
@@ -248,10 +248,16 @@
      * address probed) as the outgoing addres=
s, so the source IP+port and the
      * destination match what the server'=
s handshake cookie is bound to=2E */
     bool oob_probe_adopt;
+    const =
struct connection_entry *oob_probe_ce; /* the entry the probe won on */
+  =
  time_t oob_probe_probed_at;                  /* when the probe request it=
 won with was sent */
+    int oob_probe_connect_lifetime;              /* =
how long that reply stays usable */
     socket_descriptor_t oob_probe_sd;
=
     struct openvpn_sockaddr oob_probe_remote;
     /* the lookup the probe=
 used; the connection takes it as its remote_list */
     struct addrinfo *=
oob_probe_remote_list;
+    struct session_id oob_probe_client_sid;  /* our=
 probe session id (cookie was minted over it) */
+    struct session_id oob=
_probe_server_sid;  /* the reply's session id =3D server cookie to echo bac=
k */
+    bool oob_probe_resend_wkc;               /* reply asked to comple=
te with CONTROL_WKC_V1 (v2) */
 
     struct link_socket_actual *to_link_ad=
dr; /* IP address of remote */
     struct link_socket_actual from;        =
  /* address of incoming datagram */
diff --git a/src/openvpn/socket=2Ec b/=
src/openvpn/socket=2Ec
index f3d6ef0=2E=2Ef939528 100644
--- a/src/openvpn/=
socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -252,7 +252,7 @@
  * get_cached_=
dns_entry return 0 on success and -1
  * otherwise=2E (like getaddrinfo)
  =
*/
-static int
+int
 get_cached_dns_entry(struct cached_dns_entry *dns_cach=
e, const char *hostname, const char *servname,
                      int ai=
_family, unsigned int resolve_flags, struct addrinfo **ai)
 {
diff --git a/=
src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index c17d3bb=2E=2E1a7f0dd =
100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -375,6 =
+375,16 @@
 
 void do_preresolve(struct context *c);
 
+/**
+ * Look up a -=
-preresolve result for hostname:servname=2E *ai then points into
+ * the ca=
che, which owns it=2E
+ *
+ * @return 0 if found, -1 otherwise (like getadd=
rinfo)
+ */
+int get_cached_dns_entry(struct cached_dns_entry *dns_cache, c=
onst char *hostname,
+                         const char *servname, int ai=
_family, unsigned int resolve_flags,
+                         struct addri=
nfo **ai);
+
 void link_socket_close(struct link_socket *sock);
 
 #ifdef E=
NABLE_MANAGEMENT
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
ind=
ex e8a3d20=2E=2E7d54130 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/=
ssl=2Ec
@@ -2588,6 +2588,61 @@
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
Gerrit-PatchSet: 28
Gerri=
t-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--WXlMx16uRdQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #28</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1770?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Sta=
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
ookie), our probe<br>    session id, the pinned responder address, its reso=
lved address list<br>    and the resend-wkc flag to the connection via c2, =
and relinquish<br>    that socket=2E Gated off for dco-win, which has no us=
er-to-kernel<br>    socket handoff (probing still works, only starting from=
 the reply is<br>    skipped)=2E<br>  - oob_client=2Ec: resolve each remote=
 as the connection would, from the<br>    --preresolve cache when there is =
one (hence get_cached_dns_entry()<br>    is exported), and keep the lookups=
, so the winner&#39;s becomes the<br>    connection&#39;s remote list (see =
the previous commit)=2E<br>  - ssl=2Ec session_skip_to_pre_start_client(): =
seed our session id to the<br>    probe&#39;s (the cookie is an HMAC over i=
t), the remote session id to<br>    the cookie, ack the phantom server rese=
t (id 0) so the third packet<br>    carries the cookie, set CO_RESEND_WKC f=
or tls-crypt-v2, and drop to<br>    S_PRE_START so tls_process() promotes t=
o S_START and sends the<br>    ClientHello (no HARD_RESET sent)=2E<br>  - i=
nit=2Ec: invoke the client skip after tls_multi_init_finalize when<br>    a=
dopting, and count the probe reply as the initial packet received<br>    (n=
_sessions++, as the server does before its own<br>    session_skip_to_pre_s=
tart) so check_server_poll_timeout() does not<br>    restart the connected =
session=2E<br><br>Three things guard the shortcut=2E The reply&#39;s sessio=
n id is rejected<br>unless it is defined: it becomes the remote session id,=
 and the phantom<br>ACK means reliable_ack_write() would assert on an all-z=
ero one, so a<br>server -- or, without tls-auth/tls-crypt, anyone who answe=
rs first --<br>could otherwise kill the client with a single packet=2E<br><=
br>The probe socket and the cookie belong to the remote that answered, so<b=
r>both are given up unless next_connection_entry() selected that same<br>re=
mote=2E The entry is mapped by value and the management interface may<br>re=
write the copy, so the check compares the resulting host, port and<br>proxy=
 settings rather than which entry was picked=2E<br><br>Finally, the server =
honours its reply only for the advertised<br>connect_lifetime, which a pass=
phrase or token prompt during init can<br>outlast; the shortcut is dropped =
when it has elapsed=2E As the spec asks,<br>it is counted from when the pro=
be request the reply answers was sent,<br>not from when the reply arrived=
=2E<br><br>Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Emd<br>M=
 doc/man-sections/client-options=2Erst<br>M src/openvpn/init=2Ec<br>M src/o=
penvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M src/openvpn/openvpn=2Eh=
<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/s=
sl=2Ec<br>M src/openvpn/ssl=2Eh<br>10 files changed, 327 insertions(+), 20 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/70/1770/28</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes=2Emd =
b/Changes=2Emd</span><br><span>index cb85456=2E=2Efb92bef 100644</span><br>=
<span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd</span><br><span=
>@@ -10,6 +10,14 @@</span><br><span>   weight with DNS-SRV-like semantics=
=2E Servers advertise these values with</span><br><span>   `--server-probe-=
reply`=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+* **Probe exchange doubles as the start of the handshake**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  When a probing client picks a server that adv=
ertises support for it, the probe</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  and its reply take the place of the client&#39;s and server=
&#39;s reset packets, so the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  client does not need a separate reset exchange before the handsh=
ake=2E This saves</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
one round trip compared with probing and then connecting, and needs no extr=
a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  configuration=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #=
# User-visible Changes</span><br><span> </span><br><span> * **Parsing Disti=
nguished Names in certificates**</span><br><span>diff --git a/doc/man-secti=
ons/client-options=2Erst b/doc/man-sections/client-options=2Erst</span><br>=
<span>index 370ef60=2E=2E80f760f 100644</span><br><span>--- a/doc/man-secti=
ons/client-options=2Erst</span><br><span>+++ b/doc/man-sections/client-opti=
ons=2Erst</span><br><span>@@ -646,8 +646,25 @@</span><br><span>   probes pe=
r period whose timestamp is more than its ``--hand-window``</span><br><span=
>   away from its own clock, so a client whose clock is badly wrong may get=
</span><br><span>   no replies and then keeps the configured order=2E Order=
ing by probe</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  replace=
s any order that ``--remote-random`` produced=2E See</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  ``--server-probe-reply`` for the server s=
ide=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  replaces an=
y order that ``--remote-random`` produced=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  When the winning server supports it, the probe exchange also starts=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  handshake: it=
s reply stands in for the server&#39;s reset packet, so the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  client sends no reset of its own =
and the connection is established one</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  round trip sooner=2E This has consequences worth knowin=
g:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  - the connection reuses the probe&=
#39;s socket, and therefore its source</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    port, which matters where firewall or NAT rules pin =
a port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  - the conn=
ection first tries the address that answered, rather than</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    the remote&#39;s first resolved a=
ddress;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  - the serv=
er honours its reply only for a limited time (see</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ``--server-probe-reply``), so an unusuall=
y slow start-up, such as a</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    private key passphrase or token prompt, can outlast it; the clie=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    then falls ba=
ck to a normal handshake=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The hands=
hake shortcut is not used on Windows while DCO is active=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  See ``--server-probe-reply`` for the server side=2E<=
/span><br><span> </span><br><span> --static-challenge args</span><br><span>=
   Enable static challenge/response protocol</span><br><span>diff --git a/s=
rc/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 5609534=2E=
=2E0848489 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><spa=
n>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3479,6 +3479,44 @@</span><=
br><span>     c-&gt;c2=2Eoob_probe_remote_list =3D NULL;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Give up the probe socket and the handshake shortcut that came with it=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_drop_adoption(s=
truct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_close_so=
cket(c-&gt;c2=2Eoob_probe_sd);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_free_remote_list(c);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eoob_=
probe_adopt =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* The probe socket and the handsh=
ake shortcut belong to the remote that</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * answered: give them up if next_connection_entry() pic=
ked a different one=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oo=
b_probe_confirm_adoption(struct context *c)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!c-&gt;c2=2Eoob_probe_adopt)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* next_connection_entry=
() maps the entry by value and the management</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * interface may then rewrite that copy, so c=
ompare what we ended up with,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * not just which entry was picked=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct connection_list *l =3D =
c-&gt;options=2Econnection_list;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const struct connection_entry *won =3D c-&gt;c2=2Eoob_prob=
e_ce;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const stru=
ct connection_entry *ce =3D &amp;c-&gt;options=2Ece;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (l-&gt;array[l-&gt;current] =3D=3D=
 won &amp;&amp; proto_is_udp(ce-&gt;proto) &amp;&amp; !ce-&gt;socks_proxy_s=
erver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&=
amp; !ce-&gt;http_proxy_options &amp;&amp; ce-&gt;remote &amp;&amp; won-&gt=
;remote</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp=
;&amp; streq(ce-&gt;remote, won-&gt;remote) &amp;&amp; ce-&gt;remote_port &=
amp;&amp; won-&gt;remote_port</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        &amp;&amp; streq(ce-&gt;remote_port, won-&gt;remote_port)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(D_LOW, &quot;server-probe: a different remote was selected, n=
ot adopting the probe socket&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    oob_probe_drop_adoption(c);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> static void</span><br><span> do_init_frame_tls=
(struct context *c)</span><br><span> {</span><br><span>@@ -3491,6 +3529,33 =
@@</span><br><span>         /* Keep the max mtu also in the frame of tls mu=
lti so it can access</span><br><span>          * it in push_peer_info */</s=
pan><br><span>         c-&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Etun_max_mtu =
=3D c-&gt;c2=2Eframe=2Etun_max_mtu;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* OOB server probe: the reply already served as the server&#39;s HARD=
_RESET</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * (i=
t carried a valid SYN-cookie), so the handshake starts from it and we</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * send no reset =
of our own=2E Count it as the initial packet received, as</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * the server does, so check_=
server_poll_timeout() does not restart us=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * The reply only stands for as long as th=
e server advertised, counted</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * from when we sent the probe request it answers, which a=
 passphrase or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * token prompt can outlast=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        update_time();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (c-&gt;c2=2Eoob_probe_adopt</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; now &gt;=3D c=
-&gt;c2=2Eoob_probe_probed_at + c-&gt;c2=2Eoob_probe_connect_lifetime)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                &quot;server-pr=
obe: the reply&#39;s connect-lifetime (%d s) elapsed before the handshake&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 &quot; could start; connecting normally&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                c-&gt;c2=2Eoob_probe_connect_li=
fetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 oob_probe_drop_adoption(c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=
=2Eoob_probe_adopt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  c-&gt;c2=2Etls_multi-&gt;n_sessions++;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            session_skip_to_pre_start_client(&amp;c-&g=
t;c2=2Etls_multi-&gt;session[TM_ACTIVE],</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                             &amp;c-&g=
t;c2=2Eoob_probe_client_sid,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                             &amp;c-&gt;c2=2Eoob_p=
robe_server_sid, &amp;c-&gt;c2=2Eoob_probe_remote,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                            =
 c-&gt;c2=2Eoob_probe_resend_wkc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span>     }</span><br><span>     if (c-=
&gt;c2=2Etls_auth_standalone)</span><br><span>     {</span><br><span>@@ -44=
97,6 +4562,8 @@</span><br><span>     /* map in current connection entry */<=
/span><br><span>     next_connection_entry(c);</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_confirm_adoption=
(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     /* should we disable paging? */</span><br><span>     if (c-&gt;first=
_time &amp;&amp; options-&gt;mlock)</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>inde=
x b87e1a0=2E=2E868b4d0 100644</span><br><span>--- a/src/openvpn/oob=2Eh</sp=
an><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -174,8 +174,12 @@=
</span><br><span> {</span><br><span>     int index;</span><br><span>     bo=
ol responded;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsi=
gned int rtt_ms;          /* probe round-trip time in ms (responders only) =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct oob_prob=
e_reply reply; /* the values the server advertised */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int rtt_ms; /* probe round-t=
rip time in ms (responders only) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Captured from the packet and its reply TLV (responde=
rs only): */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct session_id server_sid;      /* the packet&#39;s own session id =3D serv=
er SYN-cookie */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 time_t probed_at;                  /* when the probe request it answers wa=
s sent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 openvpn_sockaddr responder; /* address that answered (pin the connection t=
o it) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
oob_probe_reply reply;      /* the values the server advertised */</span><b=
r><span> };</span><br><span> </span><br><span> /* Where the client probed o=
ne connection entry: its resolved addresses=2E */</span><br><span>diff --gi=
t a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span=
>index 35c71e3=2E=2E9a9b4ca 100644</span><br><span>--- a/src/openvpn/oob_cl=
ient=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@=
@ -38,6 +38,7 @@</span><br><span> #include &quot;otime=2Eh&quot;</span><br>=
<span> #include &quot;fdmisc=2Eh&quot;</span><br><span> #include &quot;cryp=
to=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;dco=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</span=
><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><sp=
an>@@ -365,6 +366,20 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Free the=
 lookups not handed to the connection; a --preresolve one belongs to</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * the DNS cache=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_free_resolved(struct =
addrinfo **resolved, const bool *cached, int n)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (resolved[i] &amp;&amp; !cached[i])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            freeaddrinfo(resolved[i]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> /* Does any address of t have a probe socket of it=
s family? */</span><br><span> static bool</span><br><span> oob_probe_target=
_reachable(const struct probe_ctx *pc, const struct oob_probe_target *t)</s=
pan><br><span>@@ -427,6 +442,20 @@</span><br><span>         return;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* The reply&#39;s own session id (the server&#39;s state=
less SYN-cookie) follows the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * opcode byte=2E Capture it before read_control_auth() strips=
 it: a client may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * reuse it to start the handshake from this reply (the connect_lifetime<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * advertisement=
)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
ession_id server_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    memcpy(server_sid=2Eid, data + 1, SID_SIZE);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!session_id_defined(&amp;server_sid)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* No usable cookie, and=
 starting a handshake from it would assert in</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * reliable_ack_write()=2E tls_pre_decryp=
t() rejects an undefined session</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * id the same way=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     struct buffer buf;</span><br><span>     buf_s=
et_read(&amp;buf, data, (size_t)len);</span><br><span> </span><br><span>@@ =
-461,6 +490,8 @@</span><br><span>     {</span><br><span>         return; /*=
 answers no probe we sent to that address */</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* its connect_lifetime=
 runs from when that probe request was sent */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const time_t probed_at =3D pc-&gt;sends[repl=
y=2Erequest_id - pc-&gt;id_base]=2Esent_at=2Etv_sec;</span><br><span> </spa=
n><br><span>     /* Credit the reply to every still-unanswered remote that =
was probed at its</span><br><span>      * source address: several entries c=
an resolve to the same address, and each</span><br><span>@@ -471,6 +502,9 @=
@</span><br><span>     {</span><br><span>         results[i]=2Eresponded =
=3D true;</span><br><span>         results[i]=2Ertt_ms =3D (unsigned int)ms=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=
=2Eserver_sid =3D server_sid;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        results[i]=2Eprobed_at =3D probed_at;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Eresponder =3D *fro=
m; /* pin the connection to the address that answered */</span><br><span>  =
       results[i]=2Ereply =3D reply;</span><br><span> </span><br><span>    =
     i =3D oob_probe_next_target_at(from, targets, results, n, i + 1);</spa=
n><br><span>@@ -647,7 +681,8 @@</span><br><span> </span><br><span>     stru=
ct gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* A single random session id is the sender se=
ssion id of all our probes */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* A single random session id for all of our probes: the serv=
er&#39;s handshake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * cookie is computed over it, so a handshake started from a reply uses =
it=2E */</span><br><span>     struct session_id client_sid;</span><br><span=
>     session_id_random(&amp;client_sid);</span><br><span> </span><br><span=
>@@ -725,8 +760,10 @@</span><br><span>         l-&gt;len, OOB_PROBE_WINDOW_=
MS, wrap_name);</span><br><span> </span><br><span>     /* Resolve every rem=
ote first, so only the address families actually in use</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * get a probe socket=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * get a probe socket=2E =
Each lookup is kept for the winner&#39;s connection=2E */</span><br><span> =
    bool need_af[PROBE_AF_COUNT] =3D { false, false };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo **resolved =3D gc_ma=
lloc(sizeof(*resolved) * l-&gt;len, true, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool *resolved_cached =3D gc_malloc(s=
izeof(*resolved_cached) * l-&gt;len, true, &amp;gc);</span><br><span>     f=
or (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span>     {</span><br><s=
pan>         results[i]=2Eindex =3D i;</span><br><span>@@ -743,15 +780,29 @=
@</span><br><span>             continue;</span><br><span>         }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* =
ce-&gt;af honours a udp4/udp6 remote, as the connection does */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* Resolve as the conne=
ction would, from the --preresolve cache when</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * there is one: the winner&#39;s connect=
ion takes this list as its remote</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * list=2E ce-&gt;af honours a udp4/udp6 remote, as t=
he connection does=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        unsigned int flags =3D GETADDR_RESOLVE | GETADDR_TRY_ONCE | GE=
TADDR_DATAGRAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (c-&gt;options=2Esockflags &amp; SF_HOST_RANDOMIZE)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            flags |=3D GETADDR_RANDOMIZE; /* -=
-remote-random-hostname */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span>         struct addrinfo *ai =3D NULL;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int status =3D op=
envpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
                 ce-&gt;remote, ce-&gt;remote_port, 0, NULL, ce-&gt;af, &am=
p;ai);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (sta=
tus !=3D 0 || !ai)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       resolved_cached[i] =3D get_cached_dns_entry(c-&gt;c1=2Edns_cache, ce=
-&gt;remote, ce-&gt;remote_port,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                                  ce-&gt;af, f=
lags, &amp;ai)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                        =3D=3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (!resolved_cached[i]</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &amp;&amp; openvpn_getaddrinfo(flags,=
 ce-&gt;remote, ce-&gt;remote_port, 0, NULL, ce-&gt;af, &amp;ai) !=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            ai =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!ai)</span><br><span>    =
     {</span><br><span>             msg(D_LOW, &quot;server-probe: %s:%s: c=
ould not resolve&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span=
>             continue;</span><br><span>         }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        resolved[i] =3D ai;</span><br><span>=
 </span><br><span>         /* Store every resolved address natively (no IPv=
4-mapping); each is later</span><br><span>          * probed on its family&=
#39;s socket=2E */</span><br><span>@@ -770,7 +821,6 @@</span><br><span>    =
         t-&gt;n_dests++;</span><br><span>             need_af[probe_af_ind=
ex(a-&gt;ai_family)] =3D true;</span><br><span>         }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        freeaddrinfo(ai);</span><br><sp=
an>     }</span><br><span> </span><br><span>     struct addrinfo *bind_loca=
l =3D oob_probe_bind_addrinfo(tmpl, &amp;c-&gt;options);</span><br><span>@@=
 -781,6 +831,7 @@</span><br><span>         {</span><br><span>             f=
reeaddrinfo(bind_local);</span><br><span>         }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        oob_probe_free_resolved(resolved,=
 resolved_cached, l-&gt;len);</span><br><span>         oob_probe_free_wrap(=
c, tas);</span><br><span>         gc_free(&amp;gc);</span><br><span>       =
  return;</span><br><span>@@ -819,11 +870,6 @@</span><br><span>     {</span=
><br><span>         oob_probe_collect(&amp;pc, targets, results, l-&gt;len,=
 c-&gt;sig);</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    oob_probe_sockets_close(&amp;pc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (bind_local)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        freeaddrinfo(bind_local);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span>     /*=
 Log each remote&#39;s outcome while results[i] still maps to array[i]=2E *=
/</span><br><span>     int responded =3D 0;</span><br><span>@@ -839,10 +885=
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
><span>         {</span><br><span>@@ -864,6 +910,83 @@</span><br><span>    =
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
&gt;c2=2Eoob_probe_remote_list =3D resolved[results[0]=2Eindex];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        resolved[results[0]=2E=
index] =3D NULL; /* the connection&#39;s remote list now */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_client=
_sid =3D client_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        c-&gt;c2=2Eoob_probe_server_sid =3D results[0]=2Eserver_sid;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_pr=
obe_resend_wkc =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           (results[0]=2Ereply=2Eflags &amp; OOB_PROBE_REPLY_FLAG_RESEND_WK=
C) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
-&gt;c2=2Eoob_probe_adopt =3D true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_ce =3D l-&gt;array[0];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_prob=
e_probed_at =3D results[0]=2Eprobed_at;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_connect_lifetime =3D resul=
ts[0]=2Ereply=2Econnect_lifetime;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(D_LOW, &quot;server-probe: starting handshake from probe reply of %s=
:%s&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
         &quot; (connect-lifetime %d s)&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            l-&gt;array[0]-&gt;remote, l-&gt;arr=
ay[0]-&gt;remote_port, results[0]=2Ereply=2Econnect_lifetime);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else if (results[0]=2Eresponded)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* A server answered but we won&#=
39;t start the handshake from it -- say why=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (dco_win_gate)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: cannot=
 start the handshake from a probe reply&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                       &quot; with dco-win; using=
 a full handshake&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else if (wkc_gate)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(D_LOW, &quot;server-probe: %s:%s did not ask for the wrapped clien=
t key;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                &quot; using a full handshake&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                l-&gt;array[0]-&gt;remote=
, l-&gt;array[0]-&gt;remote_port);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else if (results[0]=2Ereply=2Econnect_lifetime =3D=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server=
-probe: %s:%s did not advertise a connect-lifetime&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                       &quot; (connect=
-lifetime 0); using a full handshake&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                l-&gt;array[0]-&gt;remote, l-&gt;ar=
ray[0]-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Close any probe sockets we did =
not hand off to the connection=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (bind_local)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        freeaddrinfo(bind_local);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    oob_probe_free_resolved(resolved, resolved_cached, l-&gt;len);</span>=
<br><span>     oob_probe_free_wrap(c, tas);</span><br><span>     gc_free(&a=
mp;gc);</span><br><span> }</span><br><span>diff --git a/src/openvpn/openvpn=
=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index c0c6ccc=2E=2E3bb545e 1=
00644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/s=
rc/openvpn/openvpn=2Eh</span><br><span>@@ -248,10 +248,16 @@</span><br><spa=
n>      * address probed) as the outgoing address, so the source IP+port an=
d the</span><br><span>      * destination match what the server&#39;s hands=
hake cookie is bound to=2E */</span><br><span>     bool oob_probe_adopt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct conne=
ction_entry *oob_probe_ce; /* the entry the probe won on */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    time_t oob_probe_probed_at;    =
              /* when the probe request it won with was sent */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int oob_probe_connect_lifet=
ime;              /* how long that reply stays usable */</span><br><span>  =
   socket_descriptor_t oob_probe_sd;</span><br><span>     struct openvpn_so=
ckaddr oob_probe_remote;</span><br><span>     /* the lookup the probe used;=
 the connection takes it as its remote_list */</span><br><span>     struct =
addrinfo *oob_probe_remote_list;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct session_id oob_probe_client_sid;  /* our probe sess=
ion id (cookie was minted over it) */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct session_id oob_probe_server_sid;  /* the reply=
&#39;s session id =3D server cookie to echo back */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool oob_probe_resend_wkc;           =
    /* reply asked to complete with CONTROL_WKC_V1 (v2) */</span><br><span>=
 </span><br><span>     struct link_socket_actual *to_link_addr; /* IP addre=
ss of remote */</span><br><span>     struct link_socket_actual from;       =
   /* address of incoming datagram */</span><br><span>diff --git a/src/open=
vpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index f3d6ef0=2E=2E=
f939528 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span=
>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -252,7 +252,7 @@</span><br=
><span>  * get_cached_dns_entry return 0 on success and -1</span><br><span>=
  * otherwise=2E (like getaddrinfo)</span><br><span>  */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int</span><br><span> get_cached_dns_entry(struct =
cached_dns_entry *dns_cache, const char *hostname, const char *servname,</s=
pan><br><span>                      int ai_family, unsigned int resolve_fla=
gs, struct addrinfo **ai)</span><br><span> {</span><br><span>diff --git a/s=
rc/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index c17d3b=
b=2E=2E1a7f0dd 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><b=
r><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -375,6 +375,16 @@</=
span><br><span> </span><br><span> void do_preresolve(struct context *c);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Look up a --prere=
solve result for hostname:servname=2E *ai then points into</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * the cache, which owns it=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return 0 if found, -1 otherwise (like=
 getaddrinfo)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+int get_cached_dns_ent=
ry(struct cached_dns_entry *dns_cache, const char *hostname,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                         const cha=
r *servname, int ai_family, unsigned int resolve_flags,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                         struct addrinf=
o **ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> void link_socket_close(struct link_socket *sock);</span><br><span> <=
/span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/src/=
openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index e8a3d20=2E=2E7d=
54130 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ =
b/src/openvpn/ssl=2Ec</span><br><span>@@ -2588,6 +2588,61 @@</span><br><spa=
n>     return session_move_pre_start(session, ks, true);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session_skip_to_=
pre_start_client(struct tls_session *session, const struct session_id *clie=
nt_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                     const struct session_id *server_sid,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                 cons=
t struct openvpn_sockaddr *remote, bool resend_wkc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMAR=
Y];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Our session id must be the o=
ne used for the probe: the server&#39;s cookie</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * (server_sid) is an HMAC over it, and the =
server re-derives and checks it</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * when it validates our third packet=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;session_id =3D *cli=
ent_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;=
session_id_remote =3D *server_sid;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct link_socket_actual act =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    act=2Edest =3D *remote;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ks-&gt;remote_addr =3D act;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;untrusted_addr =3D=
 act;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&g=
t;burst =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tls-crypt-v2: =
the stateless server discarded the WKc after the probe, so</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * complete the handshake with P=
_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * The flag comes from the reply, so =
only act on it when this client has a</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * WKc to resend=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (resend_wkc &amp;&amp; session-&gt;tls_wrap=
=2Etls_crypt_v2_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ks-&g=
t;crypto_options=2Eflags |=3D CO_RESEND_WKC;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* W=
e never received the server&#39;s HARD_RESET (id 0) -- the probe reply stoo=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in for it=
=2E Acknowledge that phantom id 0 so our third packet carries an</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * ACK together with the s=
erver session id (the cookie): reliable_ack_write()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * only emits that session id when at=
 least one ACK is present, and the server</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * needs it to validate the stateless cookie=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reliable_ack_a=
cknowledge_packet_id(ks-&gt;rec_ack, 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Skip one (RESET) packet in each direction, so ids start at 1 (see<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * session_skip_=
to_pre_start)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ks-&gt;rec_reliable-&gt;packet_id =3D 1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    session-&gt;tls_wrap=2Eopt=2Epacket_id=2Esend=
=2Eid =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Do not send our own=
 HARD_RESET=2E Unlike the server&#39;s skip, the client must</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * send first: the stateless s=
erver only replies once it sees our third</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * packet=2E session_move_pre_start(skip=3Dtrue) =
leaves us in S_PRE_START_SKIP,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * which only advances when a packet is *received*; instead =
drop to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * S_PRE=
_START with an empty send-reliable (the initial packet was generated</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * and immediately del=
eted), so tls_process() promotes us to S_START and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * sends the ClientHello without waiting=
 for a server reset=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!session_move_pre_start(session, ks, true))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ks-&gt;state =3D S_PRE_START;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /**</span><br><span>  * Parses the TLVs (type, lengt=
h, value) in the early negotiation</span><br><span>  */</span><br><span>dif=
f --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 7=
ddf965=2E=2Ea534007 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span>=
<br><span>+++ b/src/openvpn/ssl=2Eh</span><br><span>@@ -576,4 +576,21 @@</s=
pan><br><span> bool session_skip_to_pre_start(struct tls_session *session, =
struct tls_pre_decrypt_state *state,</span><br><span>                      =
          struct link_socket_actual *from);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Client counterpart of session_skip_to_pre_star=
t(): start the handshake from a</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * server session id (SYN-cookie) learned earlier from an OOB s=
erver probe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reply=
, which already served as the server&#39;s HARD_RESET, so we send none=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param session     the (client) TLS=
 session to fast-forward</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param client_sid  session id used for the probe (the cookie is an =
HMAC over it)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram server_sid  the server&#39;s cookie, echoed back to complete the handsh=
ake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param remote=
      the probed (pinned) server address to connect to</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param resend_wkc  true to complete w=
ith P_CONTROL_WKC_V1 (tls-crypt-v2)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @return true if the session was fast-forwarded, false on=
 failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool session_skip_to_pre_st=
art_client(struct tls_session *session,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                      const struct sess=
ion_id *client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                      const struct session_id *server_sid,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                  const struct openvpn_sockaddr *remote, bool resend_wkc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #e=
ndif /* ifndef OPENVPN_SSL_H */</span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail">change 1770=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
454d5040cbad4d373ee4f90b8d683200d2a4c0e4 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1770 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 28 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--WXlMx16uRdQ=--


--===============3652031265310967386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3652031265310967386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3652031265310967386==--

