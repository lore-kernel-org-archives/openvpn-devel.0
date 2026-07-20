Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509CEC44520
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/17YviHKIQDMVEVT9hoh7hsLZNTo0MxQXMbLVAiZcQ=; b=WXSxcrf5j1+Zom7rh0l9bF+1RT
	niWgt2vAx8a2HVdUXVLtDfCTxrLlOZpJsrRbU0tl2jaBnQ5EcCaWHPxDA+HlF/5kuYbbqIYAUaREt
	VC4fPghjATDqg3nSR0OpOMqlZ4wARjiQwmewjvup865x3l28dmHGWtiDXLh2yQ1p0LXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlxVB-0000Si-Li;
	Mon, 20 Jul 2026 23:34:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wlxVA-0000Sb-Au
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 23:34:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2Wt/jD/xd5XtyEnPorr6pCa/vCywetMvUJ95grCF5gI=; b=kyi8CKz5bpBlqM7GIhcspNjWKO
 JcWhA+5Eb2dCzoHWlSw/ww3704IG4TcNQc6xijJgNlkwfimd5yMNiE0si3NUZnZoqCMuZx/rbqTSL
 aJX6G2CQylZz8gKusq2LxjJZR4k+ZfC3qMqrIOkqRt+i0Pv2Oe8IxHxoXrxd/6zjwuLc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2Wt/jD/xd5XtyEnPorr6pCa/vCywetMvUJ95grCF5gI=; b=Q
 jPCS5zUZ+emkPtB5A5bV6C+xQFOa+6xO9ZS56jkNdM1w8xB2MdkAV5WoNDJbYl+m8JyjmNdKBgAIW
 C0lBrpNbPCmbuSFYGJruItlefQ2/4G/1XULKLoKrP97ce1eI/wKGqR22XKShYYVl6ImZWXihqVeks
 +Pm19XWnt4SKE2+E=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlxV6-00080a-4s for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 23:34:21 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso30957615e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 16:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784590448; x=1785195248; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2Wt/jD/xd5XtyEnPorr6pCa/vCywetMvUJ95grCF5gI=;
 b=AcMZX+XGjPv4Uk/D5woYS80aUFWo190nJRujDeLRUMvakAGiq+tzCZiGLrcGoeBkdF
 6sgTqPjTSOr0uWrLyRQ0/AZbcEKUrzj9aPeSHBG/05BDIUuULGmtOMCh/vgZ8n7lOOHm
 UoP80TZMuSZ7MNY+LPFIH+AFX5cjOqNVh77Gez9j+XRILNdfgUAWIifdt7mDruAc3hyq
 JBvOXWiIjMl0HbZKysiKpL709KgHCUJAy7ET8/49KQV3SBH/n+u+k0Wd+APSVyRin15Q
 kart9PSQ3RB7FPV7WPvGFjqAm65e1Ut8hnb+MgVlVJoJSSO8D3j2STuFv1KHfMKOtTj0
 Wd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784590448; x=1785195248;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2Wt/jD/xd5XtyEnPorr6pCa/vCywetMvUJ95grCF5gI=;
 b=rklycm3jCWNvpYk6xFD5G4r/nJIEwdhB8t+sP6/0pLTlv1KKpv5gcH59ubQBbj1hNC
 OzG9mQjOveHPoKaeGI9BUTbUvWAVsKkbtaji9k0hvy1XKEU+FhGxKRL0SLGrVvixhprh
 qlEvAek5Ripjq8JksWWhXnMmqG7orfNRip7SANaZcxTO7/RY3aK10F3gDUkD+O0Ss9Rr
 nO7Zd86AsbdQ316/KEu3f6x6aBk6gb7+nTcU9KS3ihayV74iBoXLsb185TanLIqhF3Gy
 fwSZw7fEAtiRz2FF8A5CZo0w77HFZe+B3DQAzgKC6JyZAr7plE2dlTdcyzxhe59RS3OO
 bgLg==
X-Gm-Message-State: AOJu0YxV0anXdVXHZi78rwTSAdaxPQsvhw5jn6K6QoaDfB0iJ63DTFmd
 3/47a6cRBJyUIw6a6a9XP4M2zHnU6g7n7zkT92E7IUK9xL/YF8W7DqZudvd+J8Kp2E4YrUcGdMy
 RChz8uIcne8YNZae7y6urHl9rwyrKwTOXgF0spgc+n/T4gd8bIR0BfT7Z6e7TmUL87f4jDP1b7p
 Vgbo5NNg==
X-Gm-Gg: AfdE7clXYEuP0xFfTMwSsROD1+mSBAI+6Hua7kRg3rHSS1TGL+MW8RZKeRHtvE7hMfW
 KgBM118d5tXlz6+f7xcGYI3c6X/D+UgAcwTWbpBz8zC1F1FMnIb0LxGju7DQQX5TPk1x+gKxrcj
 x7vqoFfrat6w9183zGCXk/xuAunwZWilIQANeyQ8Z9pVvJbmfkSRJ73Jk1WJ7+ANAktVkvbDENl
 cvKKjLcTKF6vn/F9CDKOSBgGrDoBAC8YAgFlClBD2h+t/iDO/8qJMslxX5N/L1qxUz5v8TfjHtd
 b+lg7Fm2Dh3qDl2yuSXkmH/Bhcdvjz9OW8Cdm5knUiyyapTV0nY1IlO5etwY5uraQqUdg6/NP5h
 YL8kiHZsVVEHtbBbIeSYD+STR+BbwfORnt/3D9VJ5UFxwPQNJbTPNm+X7atGUcEWF4TwWqLr1BE
 AiB3nO89RUAG3dUYcphodMEDFYr5rZ/3y6cj+OtQn3xC5CW1vfP+DrNNN2lf7GJvax1aSriGlWy
 Z0uFxVN7Dp01OtZLYGM/bMBc0auFWUQAUa3mRMLtGiISKHpbP5paok7OHkg9sR4WPUT
X-Received: by 2002:a05:600c:5943:b0:495:43ab:4f6b with SMTP id
 5b1f17b1804b1-4954a3e73e0mr109425545e9.8.1784590448336; 
 Mon, 20 Jul 2026 16:34:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955a9e5f26sm119968115e9.0.2026.07.20.16.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 16:34:07 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 23:34:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: 3f3d4b30df229e59ffa72bd725fcc167d64284de
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <73a002e9288ea63a534d3712837153166329566b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wlxV6-00080a-4s
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable TCP_NODELAY
 by default and deprecate --tcp-nodelay
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4239336630162505564=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4239336630162505564==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZPaO3t8TVp8="; charset=UTF-8

--ZPaO3t8TVp8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1797?usp=3Demail

to look at the new patch set (#=
2)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by plaisthos


Change subject: Enable TCP_NODELAY by default and deprecate=
 --tcp-nodelay
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Enable TCP_NODELAY by default and deprecate --tcp-nodelay

TCP_NODELAY di=
sables Nagle's algorithm, which is
beneficial for tunnelled traffic and has=
 long been
recommended for OpenVPN over TCP=2E Until now it had
to be reque=
sted explicitly via --tcp-nodelay or
"socket-flags TCP_NODELAY"=2E

Enable =
it unconditionally on every TCP socket (dco-win
is skipped as it manages it=
s own socket) and drop the
socket_set_flags()/link_socket_update_flags() pl=
umbing
that only ever applied it; the SF_TCP_NODELAY sockflag
is now unused=
 but kept reserved=2E

--tcp-nodelay and "socket-flags TCP_NODELAY" become
=
no-ops, kept for backwards compatibility; the
--tcp-nodelay helper, its SF_=
TCP_NODELAY_HELPER flag
and the client-side warning are dropped as well=2E
=

Measured over a p2p TCP tunnel: bulk throughput is
unchanged (~1=2E7 Gbit/=
s, within 0=2E4%), while
small-packet interactive latency improves sharply
=
where Nagle bites: a request/response turn that
spans several packets drops=
 from ~82 ms to ~0=2E03 ms
round-trip=2E A turn of a single packet stays fa=
st
with or without TCP_NODELAY, as Nagle cannot delay
a lone packet=2E

Cha=
nge-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
Signed-off-by: Antonio Qu=
artulli <antonio@mandelbit=2Ecom>
---
M doc/man-sections/link-options=2Erst=

M src/openvpn/helper=2Ec
M src/openvpn/helper=2Eh
M src/openvpn/init=2Ec
M=
 src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/socket=2Ec=

M src/openvpn/socket=2Eh
8 files changed, 23 insertions(+), 113 deletions(=
-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/=
1797/2

diff --git a/doc/man-sections/link-options=2Erst b/doc/man-sections=
/link-options=2Erst
index df8c917=2E=2Ece7200f 100644
--- a/doc/man-section=
s/link-options=2Erst
+++ b/doc/man-sections/link-options=2Erst
@@ -465,24 +=
465,19 @@
   trying to group several smaller packets into a larger packet=
=2E  This can
   result in a considerably improvement in latency=2E
 
-  Th=
is option is pushable from server to client, and should be used on
-  both =
client and server for maximum effect=2E
+  Since OpenVPN 2=2E7 :code:`TCP_N=
ODELAY` is enabled by default on every TCP
+  socket, so specifying it here=
 is no longer necessary=2E
 
 --tcp-nodelay
-  This macro sets the :code:`T=
CP_NODELAY` socket flag on the server as well
-  as pushes it to connecting=
 clients=2E The :code:`TCP_NODELAY` flag disables
-  the Nagle algorithm on=
 TCP sockets causing packets to be transmitted
-  immediately with low late=
ncy, rather than waiting a short period of time
-  in order to aggregate se=
veral packets into a larger containing packet=2E
-  In VPN applications ove=
r TCP, :code:`TCP_NODELAY` is generally a good
-  latency optimization=2E
+=
  (DEPRECATED) The :code:`TCP_NODELAY` socket flag is now enabled by defaul=
t
+  on every TCP socket, so this option no longer has any effect and is
+ =
 ignored=2E
 
-  The macro expands as follows:
-  ::
-
-     if mode server=
:
-         socket-flags TCP_NODELAY
-         push "socket-flags TCP_NODEL=
AY"
+  :code:`TCP_NODELAY` disables the Nagle algorithm on TCP sockets, cau=
sing
+  packets to be transmitted immediately with low latency, rather than=

+  waiting a short period of time in order to aggregate several packets in=
to
+  a larger containing packet=2E In VPN applications over TCP this is ge=
nerally
+  a good latency optimization=2E
 
 --max-packet-size size
   This=
 option will instruct OpenVPN to try to limit the maximum on-write packet
d=
iff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec
index 4c540a6=
=2E=2Ebe2e246 100644
--- a/src/openvpn/helper=2Ec
+++ b/src/openvpn/helper=
=2Ec
@@ -99,14 +99,6 @@
     return BSTR(&out);
 }
 
-static const char *
-=
print_str(const char *str, struct gc_arena *gc)
-{
-    struct buffer out =
=3D alloc_buf_gc(128, gc);
-    buf_printf(&out, "%s", str);
-    return BS=
TR(&out);
-}
-
 static void
 helper_add_route(const in_addr_t network, cons=
t in_addr_t netmask, struct options *o)
 {
@@ -587,32 +579,3 @@
         }
=
     }
 }
-
-/*
- *
- * HELPER DIRECTIVE:
- *
- * tcp-nodelay
- *
- * EXPAN=
DS TO:
- *
- * if mode server:
- *   socket-flags TCP_NODELAY
- *   push "s=
ocket-flags TCP_NODELAY"
- */
-void
-helper_tcp_nodelay(struct options *o)
=
-{
-    if (o->server_flags & SF_TCP_NODELAY_HELPER)
-    {
-        if (o-=
>mode =3D=3D MODE_SERVER)
-        {
-            o->sockflags |=3D SF_TCP_=
NODELAY;
-            push_option(o, print_str("socket-flags TCP_NODELAY", =
&o->gc), M_USAGE);
-        }
-        else
-        {
-            o->sock=
flags |=3D SF_TCP_NODELAY;
-        }
-    }
-}
diff --git a/src/openvpn/he=
lper=2Eh b/src/openvpn/helper=2Eh
index d29257c=2E=2Ed4e7015 100644
--- a/s=
rc/openvpn/helper=2Eh
+++ b/src/openvpn/helper=2Eh
@@ -35,6 +35,4 @@
 
 voi=
d helper_client_server(struct options *o);
 
-void helper_tcp_nodelay(struc=
t options *o);
-
 #endif
diff --git a/src/openvpn/init=2Ec b/src/openvpn/in=
it=2Ec
index caaa769=2E=2E914d191 100644
--- a/src/openvpn/init=2Ec
+++ b/s=
rc/openvpn/init=2Ec
@@ -2650,15 +2650,6 @@
         }
     }
 
-    if (fou=
nd & OPT_P_SOCKFLAGS)
-    {
-        msg(D_PUSH, "OPTIONS IMPORT: --socket=
-flags option modified");
-        for (int i =3D 0; i < c->c1=2Elink_socke=
ts_num; i++)
-        {
-            link_socket_update_flags(c->c2=2Elink_=
sockets[i], c->options=2Esockflags);
-        }
-    }
-
     if (found & O=
PT_P_PERSIST)
     {
         msg(D_PUSH, "OPTIONS IMPORT: --persist option=
s modified");
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2E=
c
index 87218d4=2E=2Ef3af379 100644
--- a/src/openvpn/options=2Ec
+++ b/src=
/openvpn/options=2Ec
@@ -486,8 +486,7 @@
     "                  virtual ad=
dress table to v=2E\n"
     "--bcast-buffers n : Allocate n broadcast buffe=
rs=2E\n"
     "--tcp-queue-limit n : Maximum number of queued TCP output pa=
ckets=2E\n"
-    "--tcp-nodelay   : Macro that sets TCP_NODELAY socket flag=
 on the server\n"
-    "                  as well as pushes it to connectin=
g clients=2E\n"
+    "--tcp-nodelay   : (DEPRECATED) TCP_NODELAY is now ena=
bled by default=2E\n"
     "--learn-address cmd : Run command cmd to valida=
te client virtual addresses=2E\n"
     "--connect-freq n s : Allow a maximu=
m of n new connections per s seconds=2E\n"
     "--connect-freq-initial n s=
 : Allow a maximum of n replies for initial connections attempts per s seco=
nds=2E\n"
@@ -2644,12 +2643,6 @@
                       "verify-client-cert=
");
         MUST_BE_FALSE(options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAM=
E, "username-as-common-name");
         MUST_BE_FALSE(options->ssl_flags & =
SSLF_AUTH_USER_PASS_OPTIONAL, "auth-user-pass-optional");
-        if (opti=
ons->server_flags & SF_TCP_NODELAY_HELPER)
-        {
-            msg(M_WA=
RN, "WARNING: setting tcp-nodelay on the client side will not "
-          =
              "affect the server=2E To have TCP_NODELAY in both direction u=
se "
-                        "tcp-nodelay in the server configuration inst=
ead=2E");
-        }
         MUST_BE_UNDEF(auth_user_pass_verify_script, "=
auth-user-pass-verify");
         MUST_BE_UNDEF(auth_token_generate, "auth-=
gen-token");
 #if PORT_SHARE
@@ -3769,7 +3762,6 @@
     /* must be called a=
fter helpers that might set --mode */
     helper_setdefault_topology(o);
 =
    helper_keepalive(o);
-    helper_tcp_nodelay(o);
 
     if (o->mode =3D=
=3D MODE_SERVER)
     {
@@ -6535,11 +6527,9 @@
         VERIFY_PERMISSION(O=
PT_P_SOCKFLAGS);
         for (j =3D 1; j < MAX_PARMS && p[j]; ++j)
       =
  {
-            if (streq(p[j], "TCP_NODELAY"))
-            {
-          =
      options->sockflags |=3D SF_TCP_NODELAY;
-            }
-            e=
lse
+            /* TCP_NODELAY is enabled by default; the flag is still ac=
cepted
+             * for backwards compatibility but no longer has any ef=
fect */
+            if (!streq(p[j], "TCP_NODELAY"))
             {
      =
           msg(msglevel, "unknown socket flag: %s", p[j]);
             }
@=
@ -7715,7 +7705,7 @@
     else if (streq(p[0], "tcp-nodelay") && !p[1])
   =
  {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->server_fla=
gs |=3D SF_TCP_NODELAY_HELPER;
+        msg(M_WARN, "DEPRECATED OPTION: --t=
cp-nodelay is ignored, it is now enabled by default=2E");
     }
     else =
if (streq(p[0], "stale-routes-check") && p[1] && !p[3])
     {
diff --git a=
/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index a111cf8=2E=2E7aa79=
28 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -4=
70,8 +470,7 @@
     unsigned int server_netbits_ipv6;    /* IPv6 */
 
 #def=
ine SF_NOPOOL                (1 << 0)
-#define SF_TCP_NODELAY_HELPER    (1 =
<< 1)
-#define SF_NO_PUSH_ROUTE_GATEWAY (1 << 2)
+#define SF_NO_PUSH_ROUTE_=
GATEWAY (1 << 1)
     unsigned int server_flags;
 
     bool server_bridge_=
proxy_dhcp;
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
in=
dex df2cc9e=2E=2Eb73a5df 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/open=
vpn/socket=2Ec
@@ -516,34 +516,6 @@
 #endif
 }
 
-static bool
-socket_set_f=
lags(socket_descriptor_t sd, unsigned int sockflags)
-{
-    /* SF_TCP_NODE=
LAY doesn't make sense for dco-win */
-    if ((sockflags & SF_TCP_NODELAY)=
 && (!(sockflags & SF_DCO_WIN)))
-    {
-        return socket_set_tcp_node=
lay(sd, 1);
-    }
-    else
-    {
-        return true;
-    }
-}
-
-bool=

-link_socket_update_flags(struct link_socket *sock, unsigned int sockflags=
)
-{
-    if (sock && socket_defined(sock->sd))
-    {
-        sock->sockf=
lags |=3D sockflags;
-        return socket_set_flags(sock->sd, sock->sockf=
lags);
-    }
-    else
-    {
-        return false;
-    }
-}
-
 void
 li=
nk_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int snd=
buf)
 {
@@ -1485,8 +1457,12 @@
 static void
 phase2_set_socket_flags(struct=
 link_socket *sock)
 {
-    /* set misc socket parameters */
-    socket_se=
t_flags(sock->sd, sock->sockflags);
+    /* TCP_NODELAY is enabled by defau=
lt on every TCP socket; dco-win is
+     * skipped as it manages its own so=
cket */
+    if (proto_is_tcp(sock->info=2Eproto) && !(sock->sockflags & SF=
_DCO_WIN))
+    {
+        socket_set_tcp_nodelay(sock->sd, 1);
+    }
 
  =
   /* set socket to non-blocking mode */
     set_nonblock(sock->sd);
diff =
--git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index cd4e8ed=2E=2E=
5883592 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@=
 -207,7 +207,7 @@
     int mtu; /* OS discovered MTU, or 0 if unknown */
 
=
 #define SF_USE_IP_PKTINFO    (1 << 0)
-#define SF_TCP_NODELAY       (1 << =
1)
+#define SF_TCP_NODELAY       (1 << 1) /* unused: flag always enabled */=

 #define SF_PORT_SHARE        (1 << 2)
 #define SF_HOST_RANDOMIZE    (1 <<=
 3)
 #define SF_GETADDRINFO_DGRAM (1 << 4)
@@ -390,8 +390,6 @@
 
 void sete=
nv_trusted(struct env_set *es, const struct link_socket_info *info);
 
-boo=
l link_socket_update_flags(struct link_socket *sock, unsigned int sockflags=
);
-
 void link_socket_update_buffer_sizes(struct link_socket *sock, int rc=
vbuf, int sndbuf);
 
 /*

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1797?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
Gerrit-Change-Number: 179=
7
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>

--ZPaO3t8TVp8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>ordex <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1797?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">Enable TCP_NODELAY by default and deprecate --tcp-nodelay<br><br=
>TCP_NODELAY disables Nagle&#39;s algorithm, which is<br>beneficial for tun=
nelled traffic and has long been<br>recommended for OpenVPN over TCP=2E Unt=
il now it had<br>to be requested explicitly via --tcp-nodelay or<br>&quot;s=
ocket-flags TCP_NODELAY&quot;=2E<br><br>Enable it unconditionally on every =
TCP socket (dco-win<br>is skipped as it manages its own socket) and drop th=
e<br>socket_set_flags()/link_socket_update_flags() plumbing<br>that only ev=
er applied it; the SF_TCP_NODELAY sockflag<br>is now unused but kept reserv=
ed=2E<br><br>--tcp-nodelay and &quot;socket-flags TCP_NODELAY&quot; become<=
br>no-ops, kept for backwards compatibility; the<br>--tcp-nodelay helper, i=
ts SF_TCP_NODELAY_HELPER flag<br>and the client-side warning are dropped as=
 well=2E<br><br>Measured over a p2p TCP tunnel: bulk throughput is<br>uncha=
nged (~1=2E7 Gbit/s, within 0=2E4%), while<br>small-packet interactive late=
ncy improves sharply<br>where Nagle bites: a request/response turn that<br>=
spans several packets drops from ~82 ms to ~0=2E03 ms<br>round-trip=2E A tu=
rn of a single packet stays fast<br>with or without TCP_NODELAY, as Nagle c=
annot delay<br>a lone packet=2E<br><br>Change-Id: I434a5373f77b0f7570a6a2aa=
fe0eaf970e2eabe7<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt;<br>---<br>M doc/man-sections/link-options=2Erst<br>M src/openvpn=
/helper=2Ec<br>M src/openvpn/helper=2Eh<br>M src/openvpn/init=2Ec<br>M src/=
openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/socket=2E=
c<br>M src/openvpn/socket=2Eh<br>8 files changed, 23 insertions(+), 113 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/97/1797/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/=
link-options=2Erst b/doc/man-sections/link-options=2Erst</span><br><span>in=
dex df8c917=2E=2Ece7200f 100644</span><br><span>--- a/doc/man-sections/link=
-options=2Erst</span><br><span>+++ b/doc/man-sections/link-options=2Erst</s=
pan><br><span>@@ -465,24 +465,19 @@</span><br><span>   trying to group seve=
ral smaller packets into a larger packet=2E  This can</span><br><span>   re=
sult in a considerably improvement in latency=2E</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  This option is pushable from=
 server to client, and should be used on</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  both client and server for maximum effect=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  Since OpenVPN 2=2E7 :code:`=
TCP_NODELAY` is enabled by default on every TCP</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  socket, so specifying it here is no longer ne=
cessary=2E</span><br><span> </span><br><span> --tcp-nodelay</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  This macro sets the :code:`TCP_NODE=
LAY` socket flag on the server as well</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  as pushes it to connecting clients=2E The :code:`TCP_NOD=
ELAY` flag disables</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
the Nagle algorithm on TCP sockets causing packets to be transmitted</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  immediately with low laten=
cy, rather than waiting a short period of time</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  in order to aggregate several packets into a lar=
ger containing packet=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  In VPN applications over TCP, :code:`TCP_NODELAY` is generally a good<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  latency optimization=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (DEPRECATED) T=
he :code:`TCP_NODELAY` socket flag is now enabled by default</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  on every TCP socket, so this opt=
ion no longer has any effect and is</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  ignored=2E</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  The macro expands as follows:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  ::</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  if mode server:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
     socket-flags TCP_NODELAY</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         push &quot;socket-flags TCP_NODELAY&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  :code:`TCP_NODELAY` disables the N=
agle algorithm on TCP sockets, causing</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  packets to be transmitted immediately with low latency=
, rather than</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  wait=
ing a short period of time in order to aggregate several packets into</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  a larger containing pac=
ket=2E In VPN applications over TCP this is generally</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  a good latency optimization=2E</span><b=
r><span> </span><br><span> --max-packet-size size</span><br><span>   This o=
ption will instruct OpenVPN to try to limit the maximum on-write packet</sp=
an><br><span>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec</=
span><br><span>index 4c540a6=2E=2Ebe2e246 100644</span><br><span>--- a/src/=
openvpn/helper=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><br><=
span>@@ -99,14 +99,6 @@</span><br><span>     return BSTR(&amp;out);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static const char *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-print_str(const char *str, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct buffer out =3D alloc_buf_gc(128, gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;%s&qu=
ot;, str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
BSTR(&amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static v=
oid</span><br><span> helper_add_route(const in_addr_t network, const in_add=
r_t netmask, struct options *o)</span><br><span> {</span><br><span>@@ -587,=
32 +579,3 @@</span><br><span>         }</span><br><span>     }</span><br><s=
pan> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * HELPER DIRECTIVE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * tcp-nodelay</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * EXPANDS TO:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * if mode server:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *   socket-flags TCP_NODELAY</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *   push &quot;socket-flags TCP_NODELAY&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-helper_tcp_nodelay(struct options *o)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (o-&gt;server_flags &amp; SF_TCP_NODELAY_HELPER)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            o-&gt;sockflags |=3D SF_TCP_NODELAY;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            push_option=
(o, print_str(&quot;socket-flags TCP_NODELAY&quot;, &amp;o-&gt;gc), M_USAGE=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            o-&gt;sockflags |=3D SF_TCP_NODELAY;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/src/openvpn/helper=2Eh=
 b/src/openvpn/helper=2Eh</span><br><span>index d29257c=2E=2Ed4e7015 100644=
</span><br><span>--- a/src/openvpn/helper=2Eh</span><br><span>+++ b/src/ope=
nvpn/helper=2Eh</span><br><span>@@ -35,6 +35,4 @@</span><br><span> </span><=
br><span> void helper_client_server(struct options *o);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void helper_tcp_nodelay=
(struct options *o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> #endif</span><br><span>diff --git a/src/openvpn/init=2Ec b=
/src/openvpn/init=2Ec</span><br><span>index caaa769=2E=2E914d191 100644</sp=
an><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/i=
nit=2Ec</span><br><span>@@ -2650,15 +2650,6 @@</span><br><span>         }</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (found &amp; OPT_P_SOCKFLAGS)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(D_PUSH, &quot;OPTIONS IMPORT: --socket-flags o=
ption modified&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        for (int i =3D 0; i &lt; c-&gt;c1=2Elink_sockets_num; i++)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            link_socket_update_flags(c-&g=
t;c2=2Elink_sockets[i], c-&gt;options=2Esockflags);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span>     if (found &amp; OPT_P_PERSIST)</span><br><span>  =
   {</span><br><span>         msg(D_PUSH, &quot;OPTIONS IMPORT: --persist o=
ptions modified&quot;);</span><br><span>diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec</span><br><span>index 87218d4=2E=2Ef3af379 1006=
44</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/=
openvpn/options=2Ec</span><br><span>@@ -486,8 +486,7 @@</span><br><span>   =
  &quot;                  virtual address table to v=2E\n&quot;</span><br><=
span>     &quot;--bcast-buffers n : Allocate n broadcast buffers=2E\n&quot;=
</span><br><span>     &quot;--tcp-queue-limit n : Maximum number of queued =
TCP output packets=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &quot;--tcp-nodelay   : Macro that sets TCP_NODELAY socket flag=
 on the server\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &quot;                  as well as pushes it to connecting clients=2E\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--=
tcp-nodelay   : (DEPRECATED) TCP_NODELAY is now enabled by default=2E\n&quo=
t;</span><br><span>     &quot;--learn-address cmd : Run command cmd to vali=
date client virtual addresses=2E\n&quot;</span><br><span>     &quot;--conne=
ct-freq n s : Allow a maximum of n new connections per s seconds=2E\n&quot;=
</span><br><span>     &quot;--connect-freq-initial n s : Allow a maximum of=
 n replies for initial connections attempts per s seconds=2E\n&quot;</span>=
<br><span>@@ -2644,12 +2643,6 @@</span><br><span>                       &qu=
ot;verify-client-cert&quot;);</span><br><span>         MUST_BE_FALSE(option=
s-&gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME, &quot;username-as-commo=
n-name&quot;);</span><br><span>         MUST_BE_FALSE(options-&gt;ssl_flags=
 &amp; SSLF_AUTH_USER_PASS_OPTIONAL, &quot;auth-user-pass-optional&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&g=
t;server_flags &amp; SF_TCP_NODELAY_HELPER)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(M_WARN, &quot;WARNING: setting tcp-nodelay on the=
 client side will not &quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        &quot;affect the server=2E To have TCP_NODEL=
AY in both direction use &quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                        &quot;tcp-nodelay in the server configura=
tion instead=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span>         MUST_BE_UNDEF(auth_user_pass_verify_sc=
ript, &quot;auth-user-pass-verify&quot;);</span><br><span>         MUST_BE_=
UNDEF(auth_token_generate, &quot;auth-gen-token&quot;);</span><br><span> #i=
f PORT_SHARE</span><br><span>@@ -3769,7 +3762,6 @@</span><br><span>     /* =
must be called after helpers that might set --mode */</span><br><span>     =
helper_setdefault_topology(o);</span><br><span>     helper_keepalive(o);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    helper_tcp_nodelay(o=
);</span><br><span> </span><br><span>     if (o-&gt;mode =3D=3D MODE_SERVER=
)</span><br><span>     {</span><br><span>@@ -6535,11 +6527,9 @@</span><br><=
span>         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);</span><br><span>         =
for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j]; ++j)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (s=
treq(p[j], &quot;TCP_NODELAY&quot;))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                options-&gt;sockflags |=3D SF_TCP_NODELAY;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* TCP_NODELAY is enabled by =
default; the flag is still accepted</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             * for backwards compatibility but no longer ha=
s any effect */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (!streq(p[j], &quot;TCP_NODELAY&quot;))</span><br><span>        =
     {</span><br><span>                 msg(msglevel, &quot;unknown socket =
flag: %s&quot;, p[j]);</span><br><span>             }</span><br><span>@@ -7=
715,7 +7705,7 @@</span><br><span>     else if (streq(p[0], &quot;tcp-nodela=
y&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>         =
VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        options-&gt;server_flags |=3D SF_TCP_NODELAY_HELPER;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &q=
uot;DEPRECATED OPTION: --tcp-nodelay is ignored, it is now enabled by defau=
lt=2E&quot;);</span><br><span>     }</span><br><span>     else if (streq(p[=
0], &quot;stale-routes-check&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span=
><br><span>     {</span><br><span>diff --git a/src/openvpn/options=2Eh b/sr=
c/openvpn/options=2Eh</span><br><span>index a111cf8=2E=2E7aa7928 100644</sp=
an><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvp=
n/options=2Eh</span><br><span>@@ -470,8 +470,7 @@</span><br><span>     unsi=
gned int server_netbits_ipv6;    /* IPv6 */</span><br><span> </span><br><sp=
an> #define SF_NOPOOL                (1 &lt;&lt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define SF_TCP_NODELAY_HELPER    (1 &lt;&lt=
; 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SF_NO_PUS=
H_ROUTE_GATEWAY (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define SF_NO_PUSH_ROUTE_GATEWAY (1 &lt;&lt; 1)</span><br><span>=
     unsigned int server_flags;</span><br><span> </span><br><span>     bool=
 server_bridge_proxy_dhcp;</span><br><span>diff --git a/src/openvpn/socket=
=2Ec b/src/openvpn/socket=2Ec</span><br><span>index df2cc9e=2E=2Eb73a5df 10=
0644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src=
/openvpn/socket=2Ec</span><br><span>@@ -516,34 +516,6 @@</span><br><span> #=
endif</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-socket_set_flags(socket_descriptor_t sd, unsigned int sockflags)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* SF_TCP_NODELAY doesn&#39;t make se=
nse for dco-win */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if ((sockflags &amp; SF_TCP_NODELAY) &amp;&amp; (!(sockflags &amp; SF_DCO_=
WIN)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return socket_set_tcp_n=
odelay(sd, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return true;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-link_socket_update_flags(struct link_socket *sock, u=
nsigned int sockflags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock &amp;&=
amp; socket_defined(sock-&gt;sd))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    sock-&gt;sockflags |=3D sockflags;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return socket_set_flags(sock-&gt;sd, sock-&gt;sock=
flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> vo=
id</span><br><span> link_socket_update_buffer_sizes(struct link_socket *soc=
k, int rcvbuf, int sndbuf)</span><br><span> {</span><br><span>@@ -1485,8 +1=
457,12 @@</span><br><span> static void</span><br><span> phase2_set_socket_f=
lags(struct link_socket *sock)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* set misc socket parameters */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    socket_set_flags(sock-&gt;sd=
, sock-&gt;sockflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* TCP_NODELAY is enabled by default on every TCP socket; dco-win is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * skipped as i=
t manages its own socket */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (proto_is_tcp(sock-&gt;info=2Eproto) &amp;&amp; !(sock-&gt;s=
ockflags &amp; SF_DCO_WIN))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  socket_set_tcp_nodelay(sock-&gt;sd, 1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     /* set s=
ocket to non-blocking mode */</span><br><span>     set_nonblock(sock-&gt;sd=
);</span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=
=2Eh</span><br><span>index cd4e8ed=2E=2E5883592 100644</span><br><span>--- =
a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span=
><br><span>@@ -207,7 +207,7 @@</span><br><span>     int mtu; /* OS discover=
ed MTU, or 0 if unknown */</span><br><span> </span><br><span> #define SF_US=
E_IP_PKTINFO    (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define SF_TCP_NODELAY       (1 &lt;&lt; 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SF_TCP_NODELAY       (1 &lt;&lt; =
1) /* unused: flag always enabled */</span><br><span> #define SF_PORT_SHARE=
        (1 &lt;&lt; 2)</span><br><span> #define SF_HOST_RANDOMIZE    (1 &lt=
;&lt; 3)</span><br><span> #define SF_GETADDRINFO_DGRAM (1 &lt;&lt; 4)</span=
><br><span>@@ -390,8 +390,6 @@</span><br><span> </span><br><span> void sete=
nv_trusted(struct env_set *es, const struct link_socket_info *info);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool link_=
socket_update_flags(struct link_socket *sock, unsigned int sockflags);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void lin=
k_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndb=
uf);</span><br><span> </span><br><span> /*</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/179=
7?usp=3Demail">change 1797</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1797?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1797 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerr=
it-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>

</body></html>
--ZPaO3t8TVp8=--


--===============4239336630162505564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4239336630162505564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4239336630162505564==--

