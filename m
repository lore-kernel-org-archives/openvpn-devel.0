Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B59CA5FC4
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DLMuYvTavbImOTlE3Q7udf3c6FuYnzvdBSYRKfdHckM=; b=j5boRjHaSZpU4I0PcbP66r04kA
	O+iWYDUNGnR1hGnXzHjXKmf/sZoDfqw3dd2KB9IEiLR7nVSLx99s/oeBespYKzF/ff/Ffa8LGl8Th
	NzLt6Ma2Pe8BW/InA3jLrrZhk0GoC8/lqnP5u2XIjNrpulAP72xPtqaKpIzgP1Iav0pk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeP-0003ON-1N;
	Wed, 30 Sep 2026 08:26:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpe4-0003HH-Pp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZiMZcflJG7OW35ICfLzdCDgwmvUpj745yZLeV5KVIgY=; b=RLUGrlCuh252lZl/NVWy7xeRDK
 CsCR4+gyLP51P7swJVa8yeRnzjTYFCTEKtXEPoGCvj2glU/Gdwmyk/ttIUXz/SWMSA/kC5FG+h2T/
 baStvXv4xR/rczDWFqQk4OG+cP6BRtlyVngN/O3yYt83E9+EeQPiTkhdzJTW+vi1ElRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZiMZcflJG7OW35ICfLzdCDgwmvUpj745yZLeV5KVIgY=; b=A
 3xdGhErt+WmEDriQzmtJDnR4OPpTJAQAvBkBs4a5DlNTTIJ3502rsGaDVimDcSYoMUZei6Mbxs0pV
 nL6DNcl5Lc6hDM08TtKmsF1RFgmlVFs4dUp65/iZAKYM0t3NJX3ojJVO39krDtZtpwLkqZxBH/Lld
 U0YAB05OA6x+QWUU=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdw-0005p5-38 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:30 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso20966195e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756777; x=1791361577; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZiMZcflJG7OW35ICfLzdCDgwmvUpj745yZLeV5KVIgY=;
 b=CXZoTMQvvre3aphsWJtIGema1yjHXeZLn0A/pVDwfMXCNb3xAN+pZPfXxP3UcPlubI
 4UlrOHprJNjyvpgYJXg5BSG3uxuJFdmYkahoS5gP/dDhYSVGT9aVj9gc6dEXzJtmfi8e
 kn8lq0zGhyOa+SBxYxgnNDJUZ+b8rkwv6zIPk1a1PW3rdQLLeZaOb6Z29aFhJYf+mwJ6
 rbsqLyOpJ/khYgi9q1Pp+UTkJ+H/9xfEWW5963+4EI2MlxyqBfwDDMhXK9ExXofqNTzW
 yoeb+1u1daTp1aYNkczkg65o1YuG95IQR4PXtmFVgMANRBMFJA8Yh/vNnqjfvQaiZJQe
 TUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756777; x=1791361577;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZiMZcflJG7OW35ICfLzdCDgwmvUpj745yZLeV5KVIgY=;
 b=mXrKMuVy/95HutYwBGrK89oHRnkoRyybkOd57O2cAmivnoCxVB56EbaOuWC5ltNq6F
 gHZALB1B/VQp9fyZlsYETBoLDade1h+emitBhOWmQDlmN8/p0TPCtrhdRGkNje0yWGKY
 MMZXf5jjXl8G12iFOVD0Bno81PSiWtw0gem4PJKSut93q3ldtkGeRPw5xhLrdURdVV9a
 lBDOEWjdw7X5Ap9ve43zqCOMTZ4ezjZmkY4vwiBCN8Esp0wqh9b7+2ic0bhArh6a25t2
 8VxTiunkuSLfVCeCMu/GSMnsYx9BfyDK5JsiVg4ocaPm0DX3AyPycf7FPr30DOYM29Un
 nRbQ==
X-Gm-Message-State: AFuF++lDF1WDa36yaHDAYWcfLscIn0gdbL09VmLUjWNhw7kwv28zk+uh
 8EOmedbmKlche7RFnEmo6PxL2DT4k896cbKmwrwaBgzf9s+enXi9LiAIv68+POTwyldqZP2bjbl
 sr3ZteNq2VWb+gHTbZugCpUY3VcDvDUl6gvR/7yezDNHy/OC+KPiMrayZvYucrGmJaCCga1Enqh
 sJ9CFYjw==
X-Gm-Gg: AYBFou1P7JQMh2IXBRLtQ8Te57RqJOsBtMPAZ2VDxGfhTSUL3CyvRsY7GF/RK9aT9FC
 ZlhIIp8kPGidhTJKSCDdu3EjLvUF1Tcc7/Est/FGZb9nimbbk4birCpdDkxPt/B2eDsQLtmJ70G
 Dx20mLfceELzwawylf/E77wEVAZEGX3lW2/yIPCgNiPfivsZ1c+k7kU23inr3Id7R+v8i87vfRe
 NTlcesT2SyO3vLwY86QMStYYpe75wcmnx31IQQ8Z3/1cN9w4b+Q2D0Ki+BErD3JEhLPfUKnzWat
 wP3YMjUcCX/DI60sPH/zNXhUZ1Gf4dMrleo7m7A5mhxLABcyfUgYP8DsInlBllUUzeho9rFksmg
 SxdDtuNIPD8dreGefodlsA/R3ZzVYItu4CD4JgeKYCq56W/jHfMmBdAxacuTtOTcE3lzWmOBsX2
 svLWOFIBpUJnlMnuSwV4Cin0vluSeZSX66IIJXOUbvqczbmiisqgjGnRCusSkX83rnchUJqmtRy
 BvTeq5Ky6Q+q1f5OLamYpMkelxUrKfOuIL3HLa5smE4zVXQpUh6T8HiC36m9bM+ypHk4Wee4aGv
 0IlOS8eQDnWhID5dhLqeIYkaItHj0hjQeu8+K1CsBVPssHy1zd01Ezu3vyd6
X-Received: by 2002:a05:600c:3548:b0:4a0:8f:7e42 with SMTP id
 5b1f17b1804b1-4a01affad8amr8702475e9.13.1790756776976; 
 Wed, 30 Sep 2026 01:26:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029bef64sm2246908f8f.10.2026.09.30.01.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:16 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: e536c98997f4e4ae80035d0a4f6fac7fa251940a
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <77da6986d2d8ac5eb1a0eedbb409fe94e472a27a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdw-0005p5-38
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
Content-Type: multipart/mixed; boundary="===============0610298680598674011=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0610298680598674011==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mQjQn5nhRNk="; charset=UTF-8

--mQjQn5nhRNk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#27)=2E
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
outlast; the shortcut is dropped when it has elapsed=2E

C=
hange-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
Signed-off-by: Lev Stip=
akov <lev@openvpn=2Enet>
---
M Changes=2Emd
M doc/man-sections/client-optio=
ns=2Erst
M src/openvpn/init=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/oob_cli=
ent=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/socket=2Ec
M src/openvpn/so=
cket=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
10 files changed, 324 =
insertions(+), 20 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/70/1770/27

diff --git a/Changes=2Emd b/Changes=2E=
md
index cb85456=2E=2Efb92bef 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
=
@@ -10,6 +10,14 @@
   weight with DNS-SRV-like semantics=2E Servers adverti=
se these values with
   `--server-probe-reply`=2E
 
+* **Probe exchange dou=
bles as the start of the handshake**
+
+  When a probing client picks a ser=
ver that advertises support for it, the probe
+  and its reply take the pla=
ce of the client's and server's reset packets, so the
+  client does not ne=
ed a separate reset exchange before the handshake=2E This saves
+  one roun=
d trip compared with probing and then connecting, and needs no extra
+  con=
figuration=2E
+
 ## User-visible Changes
 
 * **Parsing Distinguished Names=
 in certificates**
diff --git a/doc/man-sections/client-options=2Erst b/doc=
/man-sections/client-options=2Erst
index 370ef60=2E=2E80f760f 100644
--- a/=
doc/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=
=2Erst
@@ -646,8 +646,25 @@
   probes per period whose timestamp is more th=
an its ``--hand-window``
   away from its own clock, so a client whose cloc=
k is badly wrong may get
   no replies and then keeps the configured order=
=2E Ordering by probe
-  replaces any order that ``--remote-random`` produc=
ed=2E See
-  ``--server-probe-reply`` for the server side=2E
+  replaces an=
y order that ``--remote-random`` produced=2E
+
+  When the winning server s=
upports it, the probe exchange also starts the
+  handshake: its reply stan=
ds in for the server's reset packet, so the
+  client sends no reset of its=
 own and the connection is established one
+  round trip sooner=2E This has=
 consequences worth knowing:
+
+  - the connection reuses the probe's socke=
t, and therefore its source
+    port, which matters where firewall or NAT =
rules pin a port;
+  - the connection first tries the address that answered=
, rather than
+    the remote's first resolved address;
+  - the server hon=
ours its reply only for a limited time (see
+    ``--server-probe-reply``),=
 so an unusually slow start-up, such as a
+    private key passphrase or to=
ken prompt, can outlast it; the client
+    then falls back to a normal han=
dshake=2E
+
+  The handshake shortcut is not used on Windows while DCO is a=
ctive=2E
+
+  See ``--server-probe-reply`` for the server side=2E
 
 --stat=
ic-challenge args
   Enable static challenge/response protocol
diff --git a=
/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 5609534=2E=2E4650eb3 100=
644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3479,6 +3479,=
44 @@
     c->c2=2Eoob_probe_remote_list =3D NULL;
 }
 
+/* Give up the pro=
be socket and the handshake shortcut that came with it=2E */
+static void
+=
oob_probe_drop_adoption(struct context *c)
+{
+    openvpn_close_socket(c->=
c2=2Eoob_probe_sd);
+    c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
+    oo=
b_probe_free_remote_list(c);
+    c->c2=2Eoob_probe_adopt =3D false;
+}
+
+=
/* The probe socket and the handshake shortcut belong to the remote that
+ =
* answered: give them up if next_connection_entry() picked a different one=
=2E */
+static void
+oob_probe_confirm_adoption(struct context *c)
+{
+    =
if (!c->c2=2Eoob_probe_adopt)
+    {
+        return;
+    }
+
+    /* next=
_connection_entry() maps the entry by value and the management
+     * inte=
rface may then rewrite that copy, so compare what we ended up with,
+     *=
 not just which entry was picked=2E */
+    const struct connection_list *l=
 =3D c->options=2Econnection_list;
+    const struct connection_entry *won =
=3D c->c2=2Eoob_probe_ce;
+    const struct connection_entry *ce =3D &c->op=
tions=2Ece;
+    if (l->array[l->current] =3D=3D won && proto_is_udp(ce->pr=
oto) && !ce->socks_proxy_server
+        && !ce->http_proxy_options && ce->=
remote && won->remote
+        && streq(ce->remote, won->remote) && ce->rem=
ote_port && won->remote_port
+        && streq(ce->remote_port, won->remote=
_port))
+    {
+        return;
+    }
+
+    msg(D_LOW, "server-probe: a d=
ifferent remote was selected, not adopting the probe socket");
+    oob_pro=
be_drop_adoption(c);
+}
+
 static void
 do_init_frame_tls(struct context *c=
)
 {
@@ -3491,6 +3529,32 @@
         /* Keep the max mtu also in the frame =
of tls multi so it can access
          * it in push_peer_info */
         =
c->c2=2Etls_multi->opt=2Eframe=2Etun_max_mtu =3D c->c2=2Eframe=2Etun_max_mt=
u;
+
+        /* OOB server probe: the reply already served as the server's=
 HARD_RESET
+         * (it carried a valid SYN-cookie), so the handshake s=
tarts from it and we
+         * send no reset of our own=2E Count it as th=
e initial packet received, as
+         * the server does, so check_server_=
poll_timeout() does not restart us=2E
+         * The reply only stands for=
 as long as the server advertised, which a
+         * passphrase or token =
prompt can outlast=2E */
+        update_time();
+        if (c->c2=2Eoob_p=
robe_adopt
+            && now >=3D c->c2=2Eoob_probe_reply_at + c->c2=2Eoo=
b_probe_connect_lifetime)
+        {
+            msg(D_LOW,
+             =
   "server-probe: the reply's connect-lifetime (%d s) elapsed before the ha=
ndshake"
+                " could start; connecting normally",
+           =
     c->c2=2Eoob_probe_connect_lifetime);
+            oob_probe_drop_adopt=
ion(c);
+        }
+
+        if (c->c2=2Eoob_probe_adopt)
+        {
+    =
        c->c2=2Etls_multi->n_sessions++;
+            session_skip_to_pre_s=
tart_client(&c->c2=2Etls_multi->session[TM_ACTIVE],
+                      =
                       &c->c2=2Eoob_probe_client_sid,
+                    =
                         &c->c2=2Eoob_probe_server_sid, &c->c2=2Eoob_probe_=
remote,
+                                             c->c2=2Eoob_probe_res=
end_wkc);
+        }
     }
     if (c->c2=2Etls_auth_standalone)
     {
@@=
 -4497,6 +4561,8 @@
     /* map in current connection entry */
     next_co=
nnection_entry(c);
 
+    oob_probe_confirm_adoption(c);
+
     /* should w=
e disable paging? */
     if (c->first_time && options->mlock)
     {
diff =
--git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index b87e1a0=2E=2Ebc9898=
9 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -174,8 +174=
,12 @@
 {
     int index;
     bool responded;
-    unsigned int rtt_ms;   =
       /* probe round-trip time in ms (responders only) */
-    struct oob_=
probe_reply reply; /* the values the server advertised */
+    unsigned int=
 rtt_ms; /* probe round-trip time in ms (responders only) */
+    /* Captur=
ed from the packet and its reply TLV (responders only): */
+    struct sess=
ion_id server_sid;      /* the packet's own session id =3D server SYN-cooki=
e */
+    time_t received_at;                /* when the reply arrived, for=
 its connect_lifetime */
+    struct openvpn_sockaddr responder; /* address=
 that answered (pin the connection to it) */
+    struct oob_probe_reply re=
ply;      /* the values the server advertised */
 };
 
 /* Where the client=
 probed one connection entry: its resolved addresses=2E */
diff --git a/src=
/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 35c71e3=2E=2Edbb=
6af4 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=
=2Ec
@@ -38,6 +38,7 @@
 #include "otime=2Eh"
 #include "fdmisc=2Eh"
 #inclu=
de "crypto=2Eh"
+#include "dco=2Eh"
 #include "error=2Eh"
 
 #include "memd=
bg=2Eh"
@@ -365,6 +366,20 @@
     }
 }
 
+/* Free the lookups not handed to=
 the connection; a --preresolve one belongs to
+ * the DNS cache=2E */
+sta=
tic void
+oob_probe_free_resolved(struct addrinfo **resolved, const bool *c=
ached, int n)
+{
+    for (int i =3D 0; i < n; i++)
+    {
+        if (res=
olved[i] && !cached[i])
+        {
+            freeaddrinfo(resolved[i]);
=
+        }
+    }
+}
+
 /* Does any address of t have a probe socket of its=
 family? */
 static bool
 oob_probe_target_reachable(const struct probe_ctx=
 *pc, const struct oob_probe_target *t)
@@ -427,6 +442,20 @@
         retur=
n;
     }
 
+    /* The reply's own session id (the server's stateless SYN-=
cookie) follows the
+     * opcode byte=2E Capture it before read_control_a=
uth() strips it: a client may
+     * reuse it to start the handshake from =
this reply (the connect_lifetime
+     * advertisement)=2E */
+    struct s=
ession_id server_sid;
+    memcpy(server_sid=2Eid, data + 1, SID_SIZE);
+  =
  if (!session_id_defined(&server_sid))
+    {
+        /* No usable cookie=
, and starting a handshake from it would assert in
+         * reliable_ack=
_write()=2E tls_pre_decrypt() rejects an undefined session
+         * id t=
he same way=2E */
+        return;
+    }
+
     struct buffer buf;
     bu=
f_set_read(&buf, data, (size_t)len);
 
@@ -471,6 +500,9 @@
     {
         =
results[i]=2Eresponded =3D true;
         results[i]=2Ertt_ms =3D (unsigned=
 int)ms;
+        results[i]=2Eserver_sid =3D server_sid;
+        results[=
i]=2Ereceived_at =3D rcv=2Etv_sec;
+        results[i]=2Eresponder =3D *fro=
m; /* pin the connection to the address that answered */
         results[i=
]=2Ereply =3D reply;
 
         i =3D oob_probe_next_target_at(from, target=
s, results, n, i + 1);
@@ -647,7 +679,8 @@
 
     struct gc_arena gc =3D gc=
_new();
 
-    /* A single random session id is the sender session id of al=
l our probes */
+    /* A single random session id for all of our probes: t=
he server's handshake
+     * cookie is computed over it, so a handshake st=
arted from a reply uses it=2E */
     struct session_id client_sid;
     se=
ssion_id_random(&client_sid);
 
@@ -725,8 +758,10 @@
         l->len, OOB_P=
ROBE_WINDOW_MS, wrap_name);
 
     /* Resolve every remote first, so only t=
he address families actually in use
-     * get a probe socket=2E */
+     =
* get a probe socket=2E Each lookup is kept for the winner's connection=2E =
*/
     bool need_af[PROBE_AF_COUNT] =3D { false, false };
+    struct addr=
info **resolved =3D gc_malloc(sizeof(*resolved) * l->len, true, &gc);
+    =
bool *resolved_cached =3D gc_malloc(sizeof(*resolved_cached) * l->len, true=
, &gc);
     for (int i =3D 0; i < l->len; i++)
     {
         results[i]=
=2Eindex =3D i;
@@ -743,15 +778,29 @@
             continue;
         }
 
-=
        /* ce->af honours a udp4/udp6 remote, as the connection does */
+  =
      /* Resolve as the connection would, from the --preresolve cache when
=
+         * there is one: the winner's connection takes this list as its re=
mote
+         * list=2E ce->af honours a udp4/udp6 remote, as the connecti=
on does=2E */
+        unsigned int flags =3D GETADDR_RESOLVE | GETADDR_TRY=
_ONCE | GETADDR_DATAGRAM;
+        if (c->options=2Esockflags & SF_HOST_RAN=
DOMIZE)
+        {
+            flags |=3D GETADDR_RANDOMIZE; /* --remote-r=
andom-hostname */
+        }
         struct addrinfo *ai =3D NULL;
-      =
  int status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | G=
ETADDR_DATAGRAM,
-                                         ce->remote, ce->=
remote_port, 0, NULL, ce->af, &ai);
-        if (status !=3D 0 || !ai)
+   =
     resolved_cached[i] =3D get_cached_dns_entry(c->c1=2Edns_cache, ce->rem=
ote, ce->remote_port,
+                                                  ce=
->af, flags, &ai)
+                             =3D=3D 0;
+        if (!res=
olved_cached[i]
+            && openvpn_getaddrinfo(flags, ce->remote, ce->=
remote_port, 0, NULL, ce->af, &ai) !=3D 0)
+        {
+            ai =3D N=
ULL;
+        }
+        if (!ai)
         {
             msg(D_LOW, "serve=
r-probe: %s:%s: could not resolve", ce->remote, ce->remote_port);
         =
    continue;
         }
+        resolved[i] =3D ai;
 
         /* Store e=
very resolved address natively (no IPv4-mapping); each is later
          *=
 probed on its family's socket=2E */
@@ -770,7 +819,6 @@
             t->n_=
dests++;
             need_af[probe_af_index(a->ai_family)] =3D true;
     =
    }
-        freeaddrinfo(ai);
     }
 
     struct addrinfo *bind_local =
=3D oob_probe_bind_addrinfo(tmpl, &c->options);
@@ -781,6 +829,7 @@
       =
  {
             freeaddrinfo(bind_local);
         }
+        oob_probe_fr=
ee_resolved(resolved, resolved_cached, l->len);
         oob_probe_free_wra=
p(c, tas);
         gc_free(&gc);
         return;
@@ -819,11 +868,6 @@
   =
  {
         oob_probe_collect(&pc, targets, results, l->len, c->sig);
    =
 }
-    oob_probe_sockets_close(&pc);
-    if (bind_local)
-    {
-        =
freeaddrinfo(bind_local);
-    }
 
     /* Log each remote's outcome while =
results[i] still maps to array[i]=2E */
     int responded =3D 0;
@@ -839,1=
0 +883,10 @@
             int margin =3D oob_effective_margin(&results[i], =
client_margin);
             const char *margin_src =3D client_margin >=3D =
0 ? "client" : "server-advertised";
             msg(D_LOW,
-              =
  "server-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;"
-     =
           " latency margin %d ms [%s])",
+                "server-probe: %=
s:%s answered (priority %d, weight %d, connect-lifetime %d s,"
+           =
     " rtt %u ms; latency margin %d ms [%s])",
                 ce->remote,=
 ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweigh=
t,
-                results[i]=2Ertt_ms, margin, margin_src);
+            =
    results[i]=2Ereply=2Econnect_lifetime, results[i]=2Ertt_ms, margin, mar=
gin_src);
         }
         else
         {
@@ -864,6 +908,83 @@
     msg=
(M_INFO, "server-probe: %d of %d probed remote(s) answered; connecting best=
-first",
         responded, sent_count);
 
+    /* If the winner advertise=
d a connect_lifetime, its reply also served as the
+     * server's reset: =
hand its probe socket and the captured cookie to the
+     * connection, wh=
ich then starts the handshake from that reply (see
+     * session_skip_to_=
pre_start_client)=2E Reusing that socket keeps the source
+     * IP+port t=
he cookie is bound to=2E dco-win cannot hand a socket to the
+     * kernel=
, so it only gets the probe ordering=2E */
+
+    bool probe_start =3D resu=
lts[0]=2Eresponded && results[0]=2Ereply=2Econnect_lifetime > 0;
+    bool =
wkc_gate =3D false;
+    /* Our first packet carries the WKc only if the se=
rver asked for it; without
+     * that a stateless tls-crypt-v2 server can=
not decrypt it=2E */
+    if (probe_start && tas->tls_wrap=2Etls_crypt_v2_w=
kc
+        && !(results[0]=2Ereply=2Eflags & OOB_PROBE_REPLY_FLAG_RESEND_W=
KC))
+    {
+        probe_start =3D false;
+        wkc_gate =3D true;
+  =
  }
+    bool dco_win_gate =3D false;
+#if defined(_WIN32)
+    if (dco_ena=
bled(&c->options))
+    {
+        probe_start =3D false;
+        dco_win_=
gate =3D true;
+    }
+#endif
+    if (probe_start)
+    {
+        const i=
nt af_idx =3D probe_af_index(results[0]=2Eresponder=2Eaddr=2Esa=2Esa_family=
);
+        c->c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];
+        pc=2Esd[af_i=
dx] =3D SOCKET_UNDEFINED; /* relinquish: the connection owns it now */
+
+ =
       c->c2=2Eoob_probe_remote =3D results[0]=2Eresponder;
+        c->c2=
=2Eoob_probe_remote_list =3D resolved[results[0]=2Eindex];
+        resolve=
d[results[0]=2Eindex] =3D NULL; /* the connection's remote list now */
+   =
     c->c2=2Eoob_probe_client_sid =3D client_sid;
+        c->c2=2Eoob_prob=
e_server_sid =3D results[0]=2Eserver_sid;
+        c->c2=2Eoob_probe_resend=
_wkc =3D
+            (results[0]=2Ereply=2Eflags & OOB_PROBE_REPLY_FLAG_RE=
SEND_WKC) !=3D 0;
+        c->c2=2Eoob_probe_adopt =3D true;
+        c->c2=
=2Eoob_probe_ce =3D l->array[0];
+        c->c2=2Eoob_probe_reply_at =3D re=
sults[0]=2Ereceived_at;
+        c->c2=2Eoob_probe_connect_lifetime =3D res=
ults[0]=2Ereply=2Econnect_lifetime;
+
+        msg(D_LOW, "server-probe: st=
arting handshake from probe reply of %s:%s"
+                   " (connect-=
lifetime %d s)",
+            l->array[0]->remote, l->array[0]->remote_port=
, results[0]=2Ereply=2Econnect_lifetime);
+    }
+    else if (results[0]=
=2Eresponded)
+    {
+        /* A server answered but we won't start the h=
andshake from it -- say why=2E */
+        if (dco_win_gate)
+        {
+  =
          msg(D_LOW, "server-probe: cannot start the handshake from a probe=
 reply"
+                       " with dco-win; using a full handshake");
+=
        }
+        else if (wkc_gate)
+        {
+            msg(D_LOW, "s=
erver-probe: %s:%s did not ask for the wrapped client key;"
+              =
         " using a full handshake",
+                l->array[0]->remote, l=
->array[0]->remote_port);
+        }
+        else if (results[0]=2Ereply=
=2Econnect_lifetime =3D=3D 0)
+        {
+            msg(D_LOW, "server-pr=
obe: %s:%s did not advertise a connect-lifetime"
+                       " =
(connect-lifetime 0); using a full handshake",
+                l->array[0]=
->remote, l->array[0]->remote_port);
+        }
+    }
+
+    /* Close any =
probe sockets we did not hand off to the connection=2E */
+    oob_probe_so=
ckets_close(&pc);
+
+    if (bind_local)
+    {
+        freeaddrinfo(bind_=
local);
+    }
+    oob_probe_free_resolved(resolved, resolved_cached, l->l=
en);
     oob_probe_free_wrap(c, tas);
     gc_free(&gc);
 }
diff --git a/s=
rc/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index c0c6ccc=2E=2E0600e8c=
 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -248=
,10 +248,16 @@
      * address probed) as the outgoing address, so the sour=
ce IP+port and the
      * destination match what the server's handshake co=
okie is bound to=2E */
     bool oob_probe_adopt;
+    const struct connect=
ion_entry *oob_probe_ce; /* the entry the probe won on */
+    time_t oob_p=
robe_reply_at;                   /* when its reply arrived */
+    int oob_=
probe_connect_lifetime;              /* how long that reply stays usable */=

     socket_descriptor_t oob_probe_sd;
     struct openvpn_sockaddr oob_pr=
obe_remote;
     /* the lookup the probe used; the connection takes it as i=
ts remote_list */
     struct addrinfo *oob_probe_remote_list;
+    struct =
session_id oob_probe_client_sid;  /* our probe session id (cookie was minte=
d over it) */
+    struct session_id oob_probe_server_sid;  /* the reply's =
session id =3D server cookie to echo back */
+    bool oob_probe_resend_wkc=
;               /* reply asked to complete with CONTROL_WKC_V1 (v2) */
 
  =
   struct link_socket_actual *to_link_addr; /* IP address of remote */
    =
 struct link_socket_actual from;          /* address of incoming datagram *=
/
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index f3d6ef=
0=2E=2Ef939528 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=
=2Ec
@@ -252,7 +252,7 @@
  * get_cached_dns_entry return 0 on success and -=
1
  * otherwise=2E (like getaddrinfo)
  */
-static int
+int
 get_cached_dns=
_entry(struct cached_dns_entry *dns_cache, const char *hostname, const char=
 *servname,
                      int ai_family, unsigned int resolve_flags=
, struct addrinfo **ai)
 {
diff --git a/src/openvpn/socket=2Eh b/src/openvp=
n/socket=2Eh
index c17d3bb=2E=2E1a7f0dd 100644
--- a/src/openvpn/socket=2Eh=

+++ b/src/openvpn/socket=2Eh
@@ -375,6 +375,16 @@
 
 void do_preresolve(st=
ruct context *c);
 
+/**
+ * Look up a --preresolve result for hostname:ser=
vname=2E *ai then points into
+ * the cache, which owns it=2E
+ *
+ * @retu=
rn 0 if found, -1 otherwise (like getaddrinfo)
+ */
+int get_cached_dns_ent=
ry(struct cached_dns_entry *dns_cache, const char *hostname,
+             =
            const char *servname, int ai_family, unsigned int resolve_flags=
,
+                         struct addrinfo **ai);
+
 void link_socket_clos=
e(struct link_socket *sock);
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/o=
penvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index e8a3d20=2E=2E7d54130 100644
--- =
a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2588,6 +2588,61 @@
    =
 return session_move_pre_start(session, ks, true);
 }
 
+bool
+session_skip=
_to_pre_start_client(struct tls_session *session, const struct session_id *=
client_sid,
+                                 const struct session_id *serv=
er_sid,
+                                 const struct openvpn_sockaddr *re=
mote, bool resend_wkc)
+{
+    struct key_state *ks =3D &session->key[KS_PR=
IMARY];
+
+    /* Our session id must be the one used for the probe: the se=
rver's cookie
+     * (server_sid) is an HMAC over it, and the server re-de=
rives and checks it
+     * when it validates our third packet=2E */
+    s=
ession->session_id =3D *client_sid;
+    ks->session_id_remote =3D *server_=
sid;
+
+    struct link_socket_actual act =3D { 0 };
+    act=2Edest =3D *r=
emote;
+    ks->remote_addr =3D act;
+    session->untrusted_addr =3D act;
=
+    session->burst =3D true;
+
+    /* tls-crypt-v2: the stateless server =
discarded the WKc after the probe, so
+     * complete the handshake with P=
_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E
+     * The flag comes=
 from the reply, so only act on it when this client has a
+     * WKc to re=
send=2E */
+    if (resend_wkc && session->tls_wrap=2Etls_crypt_v2_wkc)
+  =
  {
+        ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+    }
+
+    /=
* We never received the server's HARD_RESET (id 0) -- the probe reply stood=

+     * in for it=2E Acknowledge that phantom id 0 so our third packet car=
ries an
+     * ACK together with the server session id (the cookie): relia=
ble_ack_write()
+     * only emits that session id when at least one ACK is=
 present, and the server
+     * needs it to validate the stateless cookie=
=2E */
+    reliable_ack_acknowledge_packet_id(ks->rec_ack, 0);
+
+    /* S=
kip one (RESET) packet in each direction, so ids start at 1 (see
+     * se=
ssion_skip_to_pre_start)=2E */
+    ks->rec_reliable->packet_id =3D 1;
+   =
 session->tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;
+
+    /* Do not se=
nd our own HARD_RESET=2E Unlike the server's skip, the client must
+     * =
send first: the stateless server only replies once it sees our third
+     =
* packet=2E session_move_pre_start(skip=3Dtrue) leaves us in S_PRE_START_SK=
IP,
+     * which only advances when a packet is *received*; instead drop t=
o
+     * S_PRE_START with an empty send-reliable (the initial packet was g=
enerated
+     * and immediately deleted), so tls_process() promotes us to =
S_START and
+     * sends the ClientHello without waiting for a server rese=
t=2E */
+    if (!session_move_pre_start(session, ks, true))
+    {
+      =
  return false;
+    }
+    ks->state =3D S_PRE_START;
+    return true;
+}=

+
 /**
  * Parses the TLVs (type, length, value) in the early negotiation
=
  */
diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 7ddf965=
=2E=2Ea534007 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@=
 -576,4 +576,21 @@
 bool session_skip_to_pre_start(struct tls_session *sess=
ion, struct tls_pre_decrypt_state *state,
                                s=
truct link_socket_actual *from);
 
+/**
+ * Client counterpart of session_s=
kip_to_pre_start(): start the handshake from a
+ * server session id (SYN-c=
ookie) learned earlier from an OOB server probe
+ * reply, which already se=
rved as the server's HARD_RESET, so we send none=2E
+ *
+ * @param session =
    the (client) TLS session to fast-forward
+ * @param client_sid  session=
 id used for the probe (the cookie is an HMAC over it)
+ * @param server_si=
d  the server's cookie, echoed back to complete the handshake
+ * @param re=
mote      the probed (pinned) server address to connect to
+ * @param resen=
d_wkc  true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)
+ * @return tr=
ue if the session was fast-forwarded, false on failure
+ */
+bool session_s=
kip_to_pre_start_client(struct tls_session *session,
+                     =
                 const struct session_id *client_sid,
+                    =
                  const struct session_id *server_sid,
+                   =
                   const struct openvpn_sockaddr *remote, bool resend_wkc);=

+
 #endif /* ifndef OPENVPN_SSL_H */

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1770?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
Gerrit-Chang=
e-Number: 1770
Gerrit-PatchSet: 27
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>

--mQjQn5nhRNk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #27</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
when it has elapsed=2E<br><br>Change-Id: I454d5040cbad4d373ee4f90b8d683200d=
2a4c0e4<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>=
M Changes=2Emd<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/=
init=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M src/=
openvpn/openvpn=2Eh<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh=
<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>10 files changed, 324=
 insertions(+), 20 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/27</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/Changes=2Emd b/Changes=2Emd</span><br><span>index cb85456=2E=2Efb92be=
f 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=
=2Emd</span><br><span>@@ -10,6 +10,14 @@</span><br><span>   weight with DNS=
-SRV-like semantics=2E Servers advertise these values with</span><br><span>=
   `--server-probe-reply`=2E</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+* **Probe exchange doubles as the start of the h=
andshake**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  When a probing client pick=
s a server that advertises support for it, the probe</span><br><span style=
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
ons=2Erst</span><br><span>index 370ef60=2E=2E80f760f 100644</span><br><span=
>--- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-=
sections/client-options=2Erst</span><br><span>@@ -646,8 +646,25 @@</span><b=
r><span>   probes per period whose timestamp is more than its ``--hand-wind=
ow``</span><br><span>   away from its own clock, so a client whose clock is=
 badly wrong may get</span><br><span>   no replies and then keeps the confi=
gured order=2E Ordering by probe</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  replaces any order that ``--remote-random`` produced=2E See</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--server-probe-reply=
`` for the server side=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  replaces any order that ``--remote-random`` produced=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  When the winning server supports it, the probe e=
xchange also starts the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  handshake: its reply stands in for the server&#39;s reset packet, so =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  client sends n=
o reset of its own and the connection is established one</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  round trip sooner=2E This has conseq=
uences worth knowing:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  - the connectio=
n reuses the probe&#39;s socket, and therefore its source</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    port, which matters where firewal=
l or NAT rules pin a port;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  - the connection first tries the address that answered, rather tha=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    the remote&#39=
;s first resolved address;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  - the server honours its reply only for a limited time (see</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ``--server-probe-reply=
``), so an unusually slow start-up, such as a</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    private key passphrase or token prompt, can o=
utlast it; the client</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    then falls back to a normal handshake=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  The handshake shortcut is not used on Windows while DCO is active=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  See ``--server-probe-reply`` for =
the server side=2E</span><br><span> </span><br><span> --static-challenge ar=
gs</span><br><span>   Enable static challenge/response protocol</span><br><=
span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><sp=
an>index 5609534=2E=2E4650eb3 100644</span><br><span>--- a/src/openvpn/init=
=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3479,6 =
+3479,44 @@</span><br><span>     c-&gt;c2=2Eoob_probe_remote_list =3D NULL;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Give up the probe socket and the handshake shortcut th=
at came with it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_pr=
obe_drop_adoption(struct context *c)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   openvpn_close_socket(c-&gt;c2=2Eoob_probe_sd);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFI=
NED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_f=
ree_remote_list(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    c-&gt;c2=2Eoob_probe_adopt =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The probe so=
cket and the handshake shortcut belong to the remote that</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * answered: give them up if next_con=
nection_entry() picked a different one=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+oob_probe_confirm_adoption(struct context *c)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!c-&gt;c2=2Eoob_probe_adopt)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ne=
xt_connection_entry() maps the entry by value and the management</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * interface may then rewr=
ite that copy, so compare what we ended up with,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * not just which entry was picked=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct conn=
ection_list *l =3D c-&gt;options=2Econnection_list;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct connection_entry *won =
=3D c-&gt;c2=2Eoob_probe_ce;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct connection_entry *ce =3D &amp;c-&gt;options=2Ece;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (l-&gt;array=
[l-&gt;current] =3D=3D won &amp;&amp; proto_is_udp(ce-&gt;proto) &amp;&amp;=
 !ce-&gt;socks_proxy_server</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        &amp;&amp; !ce-&gt;http_proxy_options &amp;&amp; ce-&gt;rem=
ote &amp;&amp; won-&gt;remote</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        &amp;&amp; streq(ce-&gt;remote, won-&gt;remote) &amp;&amp=
; ce-&gt;remote_port &amp;&amp; won-&gt;remote_port</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; streq(ce-&gt;remote_po=
rt, won-&gt;remote_port))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: a differen=
t remote was selected, not adopting the probe socket&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_drop_adoption(c);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br>=
<span> do_init_frame_tls(struct context *c)</span><br><span> {</span><br><s=
pan>@@ -3491,6 +3529,32 @@</span><br><span>         /* Keep the max mtu als=
o in the frame of tls multi so it can access</span><br><span>          * it=
 in push_peer_info */</span><br><span>         c-&gt;c2=2Etls_multi-&gt;opt=
=2Eframe=2Etun_max_mtu =3D c-&gt;c2=2Eframe=2Etun_max_mtu;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* OOB server probe: the reply already served a=
s the server&#39;s HARD_RESET</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * (it carried a valid SYN-cookie), so the handshake star=
ts from it and we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * send no reset of our own=2E Count it as the initial packet receive=
d, as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the=
 server does, so check_server_poll_timeout() does not restart us=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * The reply only s=
tands for as long as the server advertised, which a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * passphrase or token prompt can=
 outlast=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   update_time();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (c-&gt;c2=2Eoob_probe_adopt</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &amp;&amp; now &gt;=3D c-&gt;c2=2Eoob_probe_re=
ply_at + c-&gt;c2=2Eoob_probe_connect_lifetime)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(D_LOW,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                &quot;server-probe: the reply&#39;s co=
nnect-lifetime (%d s) elapsed before the handshake&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                &quot; could start; co=
nnecting normally&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                c-&gt;c2=2Eoob_probe_connect_lifetime);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            oob_probe_drop_adoptio=
n(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
ndalone)</span><br><span>     {</span><br><span>@@ -4497,6 +4561,8 @@</span=
><br><span>     /* map in current connection entry */</span><br><span>     =
next_connection_entry(c);</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    oob_probe_confirm_adoption(c);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* should we d=
isable paging? */</span><br><span>     if (c-&gt;first_time &amp;&amp; opti=
ons-&gt;mlock)</span><br><span>     {</span><br><span>diff --git a/src/open=
vpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index b87e1a0=2E=2Ebc9898=
9 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/sr=
c/openvpn/oob=2Eh</span><br><span>@@ -174,8 +174,12 @@</span><br><span> {</=
span><br><span>     int index;</span><br><span>     bool responded;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int rtt_ms;     =
     /* probe round-trip time in ms (responders only) */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct oob_probe_reply reply; /* the=
 values the server advertised */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    unsigned int rtt_ms; /* probe round-trip time in ms (respo=
nders only) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Captured from the packet and its reply TLV (responders only): */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id server=
_sid;      /* the packet&#39;s own session id =3D server SYN-cookie */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    time_t received_at; =
               /* when the reply arrived, for its connect_lifetime */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockad=
dr responder; /* address that answered (pin the connection to it) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply=
 reply;      /* the values the server advertised */</span><br><span> };</sp=
an><br><span> </span><br><span> /* Where the client probed one connection e=
ntry: its resolved addresses=2E */</span><br><span>diff --git a/src/openvpn=
/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 35c71e3=
=2E=2Edbb6af4 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span=
><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -38,6 +38,7 =
@@</span><br><span> #include &quot;otime=2Eh&quot;</span><br><span> #includ=
e &quot;fdmisc=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;dco=2E=
h&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> </=
span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span>@@ -365,6 +=
366,20 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Free the lookups not h=
anded to the connection; a --preresolve one belongs to</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * the DNS cache=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+oob_probe_free_resolved(struct addrinfo **res=
olved, const bool *cached, int n)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (resolved[i] &amp;&amp; !cached[i])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            freeaddrinfo(resolved[i]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> /* Does any address of t have a probe socket of its family? */</=
span><br><span> static bool</span><br><span> oob_probe_target_reachable(con=
st struct probe_ctx *pc, const struct oob_probe_target *t)</span><br><span>=
@@ -427,6 +442,20 @@</span><br><span>         return;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* The reply&#39;s own session id (the server&#39;s stateless SYN-cooki=
e) follows the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* opcode byte=2E Capture it before read_control_auth() strips it: a client =
may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * reuse it =
to start the handshake from this reply (the connect_lifetime</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * advertisement)=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id serv=
er_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(s=
erver_sid=2Eid, data + 1, SID_SIZE);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!session_id_defined(&amp;server_sid))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* No usable cookie, and starting a ha=
ndshake from it would assert in</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * reliable_ack_write()=2E tls_pre_decrypt() rejects an=
 undefined session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * id the same way=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     struct buffer buf;</span><br><span>     buf_set_read(&amp;b=
uf, data, (size_t)len);</span><br><span> </span><br><span>@@ -471,6 +500,9 =
@@</span><br><span>     {</span><br><span>         results[i]=2Eresponded =
=3D true;</span><br><span>         results[i]=2Ertt_ms =3D (unsigned int)ms=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=
=2Eserver_sid =3D server_sid;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        results[i]=2Ereceived_at =3D rcv=2Etv_sec;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Eresponder =3D=
 *from; /* pin the connection to the address that answered */</span><br><sp=
an>         results[i]=2Ereply =3D reply;</span><br><span> </span><br><span=
>         i =3D oob_probe_next_target_at(from, targets, results, n, i + 1);=
</span><br><span>@@ -647,7 +679,8 @@</span><br><span> </span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* A single random session id is the se=
nder session id of all our probes */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* A single random session id for all of our probes: t=
he server&#39;s handshake</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * cookie is computed over it, so a handshake started from a repl=
y uses it=2E */</span><br><span>     struct session_id client_sid;</span><b=
r><span>     session_id_random(&amp;client_sid);</span><br><span> </span><b=
r><span>@@ -725,8 +758,10 @@</span><br><span>         l-&gt;len, OOB_PROBE_=
WINDOW_MS, wrap_name);</span><br><span> </span><br><span>     /* Resolve ev=
ery remote first, so only the address families actually in use</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * get a probe socket=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * get a probe soc=
ket=2E Each lookup is kept for the winner&#39;s connection=2E */</span><br>=
<span>     bool need_af[PROBE_AF_COUNT] =3D { false, false };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo **resolved =
=3D gc_malloc(sizeof(*resolved) * l-&gt;len, true, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool *resolved_cached =3D gc_m=
alloc(sizeof(*resolved_cached) * l-&gt;len, true, &amp;gc);</span><br><span=
>     for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span>     {</span=
><br><span>         results[i]=2Eindex =3D i;</span><br><span>@@ -743,15 +7=
78,29 @@</span><br><span>             continue;</span><br><span>         }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* ce-&gt;af honours a udp4/udp6 remote, as the connection does */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Resolve as th=
e connection would, from the --preresolve cache when</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * there is one: the winner&#39;s=
 connection takes this list as its remote</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * list=2E ce-&gt;af honours a udp4/udp6 remo=
te, as the connection does=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        unsigned int flags =3D GETADDR_RESOLVE | GETADDR_TRY_O=
NCE | GETADDR_DATAGRAM;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (c-&gt;options=2Esockflags &amp; SF_HOST_RANDOMIZE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            flags |=3D GETADDR_RANDOMI=
ZE; /* --remote-random-hostname */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span>         struct addrinfo *ai =3D N=
ULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int statu=
s =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATA=
GRAM,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                         ce-&gt;remote, ce-&gt;remote_port, 0, NULL, ce-&gt=
;af, &amp;ai);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (status !=3D 0 || !ai)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        resolved_cached[i] =3D get_cached_dns_entry(c-&gt;c1=2Edns_c=
ache, ce-&gt;remote, ce-&gt;remote_port,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                                  ce-&=
gt;af, flags, &amp;ai)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                             =3D=3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!resolved_cached[i]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; openvpn_getaddrinf=
o(flags, ce-&gt;remote, ce-&gt;remote_port, 0, NULL, ce-&gt;af, &amp;ai) !=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            ai =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ai)</span><br><=
span>         {</span><br><span>             msg(D_LOW, &quot;server-probe:=
 %s:%s: could not resolve&quot;, ce-&gt;remote, ce-&gt;remote_port);</span>=
<br><span>             continue;</span><br><span>         }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        resolved[i] =3D ai;</span><=
br><span> </span><br><span>         /* Store every resolved address nativel=
y (no IPv4-mapping); each is later</span><br><span>          * probed on it=
s family&#39;s socket=2E */</span><br><span>@@ -770,7 +819,6 @@</span><br><=
span>             t-&gt;n_dests++;</span><br><span>             need_af[pro=
be_af_index(a-&gt;ai_family)] =3D true;</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        freeaddrinfo(ai);</spa=
n><br><span>     }</span><br><span> </span><br><span>     struct addrinfo *=
bind_local =3D oob_probe_bind_addrinfo(tmpl, &amp;c-&gt;options);</span><br=
><span>@@ -781,6 +829,7 @@</span><br><span>         {</span><br><span>     =
        freeaddrinfo(bind_local);</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_free_resolved(re=
solved, resolved_cached, l-&gt;len);</span><br><span>         oob_probe_fre=
e_wrap(c, tas);</span><br><span>         gc_free(&amp;gc);</span><br><span>=
         return;</span><br><span>@@ -819,11 +868,6 @@</span><br><span>     =
{</span><br><span>         oob_probe_collect(&amp;pc, targets, results, l-&=
gt;len, c-&gt;sig);</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    oob_probe_sockets_close(&amp;pc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (bind_local)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        freeaddrinfo(bind_local);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span>   =
  /* Log each remote&#39;s outcome while results[i] still maps to array[i]=
=2E */</span><br><span>     int responded =3D 0;</span><br><span>@@ -839,10=
 +883,10 @@</span><br><span>             int margin =3D oob_effective_margi=
n(&amp;results[i], client_margin);</span><br><span>             const char =
*margin_src =3D client_margin &gt;=3D 0 ? &quot;client&quot; : &quot;server=
-advertised&quot;;</span><br><span>             msg(D_LOW,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                &quot;server-probe: %s=
:%s answered (priority %d, weight %d, rtt %u ms;&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                &quot; latency margin %d m=
s [%s])&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           &quot;server-probe: %s:%s answered (priority %d, weight %d, conn=
ect-lifetime %d s,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot; rtt %u ms; latency margin %d ms [%s])&quot;,</s=
pan><br><span>                 ce-&gt;remote, ce-&gt;remote_port, results[i=
]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                results[i]=2Ertt_ms, margin, m=
argin_src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        results[i]=2Ereply=2Econnect_lifetime, results[i]=2Ertt_ms, margin,=
 margin_src);</span><br><span>         }</span><br><span>         else</spa=
n><br><span>         {</span><br><span>@@ -864,6 +908,83 @@</span><br><span=
>     msg(M_INFO, &quot;server-probe: %d of %d probed remote(s) answered; c=
onnecting best-first&quot;,</span><br><span>         responded, sent_count)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* If the winner advertised a connect_lifetime, its reply also served a=
s the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * server&=
#39;s reset: hand its probe socket and the captured cookie to the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * connection, which then=
 starts the handshake from that reply (see</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * session_skip_to_pre_start_client)=2E Reusing =
that socket keeps the source</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * IP+port the cookie is bound to=2E dco-win cannot hand a soc=
ket to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ke=
rnel, so it only gets the probe ordering=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool probe_start =3D results[0]=2Eresponded &amp;&amp; results[=
0]=2Ereply=2Econnect_lifetime &gt; 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool wkc_gate =3D false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Our first packet carries the WKc only if =
the server asked for it; without</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * that a stateless tls-crypt-v2 server cannot decrypt it=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (probe=
_start &amp;&amp; tas-&gt;tls_wrap=2Etls_crypt_v2_wkc</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !(results[0]=2Ereply=
=2Eflags &amp; OOB_PROBE_REPLY_FLAG_RESEND_WKC))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        probe_start =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        wkc_gate =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool dco_win_gate =3D false;</span><br><span style=
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
">+        c-&gt;c2=2Eoob_probe_remote_list =3D resolved[results[0]=2Eindex=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolved[=
results[0]=2Eindex] =3D NULL; /* the connection&#39;s remote list now */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob=
_probe_client_sid =3D client_sid;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        c-&gt;c2=2Eoob_probe_server_sid =3D results[0]=2Eserv=
er_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&g=
t;c2=2Eoob_probe_resend_wkc =3D</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            (results[0]=2Ereply=2Eflags &amp; OOB_PROBE_REPLY_F=
LAG_RESEND_WKC) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        c-&gt;c2=2Eoob_probe_adopt =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_ce =3D l-&gt;arra=
y[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;=
c2=2Eoob_probe_reply_at =3D results[0]=2Ereceived_at;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_connect_life=
time =3D results[0]=2Ereply=2Econnect_lifetime;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_LOW, &quot;server-probe: starting handshake from pro=
be reply of %s:%s&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   &quot; (connect-lifetime %d s)&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            l-&gt;array[0]-&gt;rem=
ote, l-&gt;array[0]-&gt;remote_port, results[0]=2Ereply=2Econnect_lifetime)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (results[0]=2Erespon=
ded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* A server answered =
but we won&#39;t start the handshake from it -- say why=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (dco_win_gate)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-p=
robe: cannot start the handshake from a probe reply&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                       &quot; with dc=
o-win; using a full handshake&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else if (wkc_gate)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(D_LOW, &quot;server-probe: %s:%s did not ask for the w=
rapped client key;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                       &quot; using a full handshake&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                l-&gt;array[0]=
-&gt;remote, l-&gt;array[0]-&gt;remote_port);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        else if (results[0]=2Ereply=2Econnect_lifetime =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, =
&quot;server-probe: %s:%s did not advertise a connect-lifetime&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                       &qu=
ot; (connect-lifetime 0); using a full handshake&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                l-&gt;array[0]-&gt;remo=
te, l-&gt;array[0]-&gt;remote_port);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Close any probe soc=
kets we did not hand off to the connection=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (bind_local)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        freeaddrinfo(bind_local);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    oob_probe_free_resolved(resolved, resolved_cached, l-&gt;=
len);</span><br><span>     oob_probe_free_wrap(c, tas);</span><br><span>   =
  gc_free(&amp;gc);</span><br><span> }</span><br><span>diff --git a/src/ope=
nvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index c0c6ccc=2E=
=2E0600e8c 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><=
span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -248,10 +248,16 @@</s=
pan><br><span>      * address probed) as the outgoing address, so the sourc=
e IP+port and the</span><br><span>      * destination match what the server=
&#39;s handshake cookie is bound to=2E */</span><br><span>     bool oob_pro=
be_adopt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct connection_entry *oob_probe_ce; /* the entry the probe won on */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    time_t oob_probe_re=
ply_at;                   /* when its reply arrived */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int oob_probe_connect_lifetime;     =
         /* how long that reply stays usable */</span><br><span>     socket=
_descriptor_t oob_probe_sd;</span><br><span>     struct openvpn_sockaddr oo=
b_probe_remote;</span><br><span>     /* the lookup the probe used; the conn=
ection takes it as its remote_list */</span><br><span>     struct addrinfo =
*oob_probe_remote_list;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct session_id oob_probe_client_sid;  /* our probe session id (c=
ookie was minted over it) */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct session_id oob_probe_server_sid;  /* the reply&#39;s se=
ssion id =3D server cookie to echo back */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool oob_probe_resend_wkc;               /* repl=
y asked to complete with CONTROL_WKC_V1 (v2) */</span><br><span> </span><br=
><span>     struct link_socket_actual *to_link_addr; /* IP address of remot=
e */</span><br><span>     struct link_socket_actual from;          /* addre=
ss of incoming datagram */</span><br><span>diff --git a/src/openvpn/socket=
=2Ec b/src/openvpn/socket=2Ec</span><br><span>index f3d6ef0=2E=2Ef939528 10=
0644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src=
/openvpn/socket=2Ec</span><br><span>@@ -252,7 +252,7 @@</span><br><span>  *=
 get_cached_dns_entry return 0 on success and -1</span><br><span>  * otherw=
ise=2E (like getaddrinfo)</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+int</span><br><span> get_cached_dns_entry(struct cached_dns=
_entry *dns_cache, const char *hostname, const char *servname,</span><br><s=
pan>                      int ai_family, unsigned int resolve_flags, struct=
 addrinfo **ai)</span><br><span> {</span><br><span>diff --git a/src/openvpn=
/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index c17d3bb=2E=2E1a7=
f0dd 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>++=
+ b/src/openvpn/socket=2Eh</span><br><span>@@ -375,6 +375,16 @@</span><br><=
span> </span><br><span> void do_preresolve(struct context *c);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Look up a --preresolve resu=
lt for hostname:servname=2E *ai then points into</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * the cache, which owns it=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return 0 if found, -1 otherwise (like getaddrinf=
o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+int get_cached_dns_entry(struct c=
ached_dns_entry *dns_cache, const char *hostname,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                         const char *servname=
, int ai_family, unsigned int resolve_flags,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                         struct addrinfo **ai);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void=
 link_socket_close(struct link_socket *sock);</span><br><span> </span><br><=
span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index e8a3d20=2E=2E7d54130 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -2588,6 +2588,61 @@</span><br><span>     retu=
rn session_move_pre_start(session, ks, true);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pre_start_c=
lient(struct tls_session *session, const struct session_id *client_sid,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
          const struct session_id *server_sid,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                 const struct op=
envpn_sockaddr *remote, bool resend_wkc)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Our session id must be the one used for t=
he probe: the server&#39;s cookie</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * (server_sid) is an HMAC over it, and the server re-der=
ives and checks it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * when it validates our third packet=2E */</span><br><span style=3D"col=
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
V1 (drives control_packet_needs_wkc)=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * The flag comes from the reply, so only act on it=
 when this client has a</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * WKc to resend=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (resend_wkc &amp;&amp; session-&gt;tls_wrap=2Etls_crypt_v=
2_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;crypto_optio=
ns=2Eflags |=3D CO_RESEND_WKC;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We never receiv=
ed the server&#39;s HARD_RESET (id 0) -- the probe reply stood</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * in for it=2E Acknowledge =
that phantom id 0 so our third packet carries an</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * ACK together with the server session id=
 (the cookie): reliable_ack_write()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * only emits that session id when at least one ACK is =
present, and the server</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * needs it to validate the stateless cookie=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    reliable_ack_acknowledge_packet_=
id(ks-&gt;rec_ack, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip one =
(RESET) packet in each direction, so ids start at 1 (see</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * session_skip_to_pre_start)=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;rec_rel=
iable-&gt;packet_id =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    session-&gt;tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Do not send our own HARD_RESET=2E Unli=
ke the server&#39;s skip, the client must</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * send first: the stateless server only replies =
once it sees our third</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * packet=2E session_move_pre_start(skip=3Dtrue) leaves us in S_PRE_=
START_SKIP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * w=
hich only advances when a packet is *received*; instead drop to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * S_PRE_START with an empt=
y send-reliable (the initial packet was generated</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * and immediately deleted), so tls_proce=
ss() promotes us to S_START and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * sends the ClientHello without waiting for a server reset=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sess=
ion_move_pre_start(session, ks, true))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-=
&gt;state =3D S_PRE_START;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /**</span><br><span>  * Parses the TLVs (type, length, value) in the ea=
rly negotiation</span><br><span>  */</span><br><span>diff --git a/src/openv=
pn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=2Ea534007=
 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src=
/openvpn/ssl=2Eh</span><br><span>@@ -576,4 +576,21 @@</span><br><span> bool=
 session_skip_to_pre_start(struct tls_session *session, struct tls_pre_decr=
ypt_state *state,</span><br><span>                                struct li=
nk_socket_actual *from);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Client counterpart of session_skip_to_pre_start(): start the hand=
shake from a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * serv=
er session id (SYN-cookie) learned earlier from an OOB server probe</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * reply, which already ser=
ved as the server&#39;s HARD_RESET, so we send none=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param session     the (client) TLS session to fast-fo=
rward</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param clie=
nt_sid  session id used for the probe (the cookie is an HMAC over it)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server_sid  the=
 server&#39;s cookie, echoed back to complete the handshake</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param remote      the probed (p=
inned) server address to connect to</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param resend_wkc  true to complete with P_CONTROL_WKC_V=
1 (tls-crypt-v2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return true if the session was fast-forwarded, false on failure</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool session_skip_to_pre_start_client(struct t=
ls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                      const struct session_id *client_sid,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                   const struct session_id *server_sid,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                      c=
onst struct openvpn_sockaddr *remote, bool resend_wkc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef OPEN=
VPN_SSL_H */</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1770?usp=3Demail">change 1770</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I454d5040cbad4d373=
ee4f90b8d683200d2a4c0e4 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1770 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 27 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--mQjQn5nhRNk=--


--===============0610298680598674011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0610298680598674011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0610298680598674011==--

