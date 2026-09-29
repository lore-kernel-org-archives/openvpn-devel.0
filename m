Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AABCA5FA5
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VQDc2bH07bGQWHeU0F+NLMqKGUytVI6HsdrHZnL9n9o=; b=HIWotQgwqPH34+rLQqs0No7FIL
	UFWOqvxF/QRZgIfZBFEt0F1sguhqDOZNmymXYeWQRx1B87kkwxoHVPeEuzQCynRkxHTiREY6Yh6Iq
	MnjmuOsq3bJTPkAsUxMWNmohB7h67Y1+o+eatxItaVR/0w0LYktIJ9hzrX6bF3tBjWt8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhZ-00083i-VE;
	Tue, 29 Sep 2026 13:16:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhZ-00083X-AH
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QB0vs7NaNsLBbIcrUk27Gy8AJSXhIu7E52IASAEA7Mg=; b=bH1PfUr2Bfz7AwvrOs06Sco/ku
 DUTC5WQMrisEI8amEkM5/o0NAgMLXL6Bv7mPjUQdFR854O+pMD4pyVmNrtGlIpHmbIokOkk8wPGW9
 hVC31n1FPkVJNZVKa0X3Yli1xriFdx1SP/h1JCV8YTuNo5qYRgAw+8/jdQTbzM21yQvo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QB0vs7NaNsLBbIcrUk27Gy8AJSXhIu7E52IASAEA7Mg=; b=A
 8BZPUrw8TSnogYQnmGB8SnLeHF9i3AzwulHzpLtCcZw4/5NNpWeBkInPfjzcQnZSSvQEka8tqXsHC
 CRbZFzIVlGljv/E1LtR+FxVbnMqnkWeZWywmNTF+k0A/eSxjzL/YLazOcKalGJckWbig21886HAAp
 +j2zu/PaQP7t1ets=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhX-0007lO-N4 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:58 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48870973bddso336862f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687809; x=1791292609; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QB0vs7NaNsLBbIcrUk27Gy8AJSXhIu7E52IASAEA7Mg=;
 b=NkgpGos3/UCzTkRByhYcadEI82fvYPcZlAJpHRM4nlgzyeHu8BXOILaTMSwzWEuO9c
 0zp34sfei7p4GAuykwaELnH+ktQRS242rjzjqZ8Ws60G4f4xy7WKFBa6eZfc2wXlwKLH
 RU01/dyz6uCOkLnG6lDr48wQ4MI/5fv85Sg98l/VnEDIfiUQX+iXS5jl8NwSKaBhy6mO
 F3fZW3waypaROuWKCNvYpjEJvpI1TfyiLRWulp2S5PLiiYMjJ30I8J7P+/48rq4cGrnl
 jYzieTa2MsT8ZhEIf89EdfJTii5Lq0WxNk3ORgvO0BkmHmZYdxuOSnErexQQcr8LizPA
 BZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687809; x=1791292609;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QB0vs7NaNsLBbIcrUk27Gy8AJSXhIu7E52IASAEA7Mg=;
 b=uaFwCe9WvYTZdV0wnFKXvzm+J2SXVyvGb6JWdxH2NMt+UqeOgT4w0TuzWsE8aiASSc
 G8vt3lv7Gov63SH09sCxKUkRRw1n7V0TFoZ7c0Po+1Znf3T1hQKdJhOmdh/rjZm29Sjx
 +74EX8JwMxYwMpyiN/tNZw6JC+4uhToAinFW+dun4SvX7T2FKw6LIjIEsKpqcRNNET7c
 Z1u75zUOXBMhG1JjZPotUkz49RuswS2Rln0RVbHo8KmYFNCYIBbBvisbXBryJA1+OaMb
 D1gzyune4JnXwpuz3kNHZcFXDXa/MPVQbhj9cWEZmvIuqMyeaju1WvXlLZBbxtpc0F6S
 Hc6A==
X-Gm-Message-State: AFq9FYJ/ob/vmyH6Blfz7p1oyMVLUFtkCh1xA7RoGSpHkckytTdJGDDg
 OR26BIfaaTfYClxHF+GQV4QfKnfnDBXOGZuq+XtfRreV1vF6aV1YU4fvuFkPj91rNifv40Q5nMY
 LVCDvs7vSJMi8FRjNZ+WBnH5GddogALY5e51yZh9ugJ0pBrjgAnVBS/PAB7ipQWDzwXbEQKZyik
 tci+YqHQ==
X-Gm-Gg: AYBFou2c6U5TqUUCfo8JlU+QMIoKoKQfJIQRMqsYBLJ5RKOVgU9QOxJDGJvcTSz6eyp
 TIxDL/PKOZqwU4r3R0Gd7gDQRb01pIUTWE5Vt4UPPXAJJXnV5oJ83zd/4x0gyEulSB38sqsaf/d
 zDF7kA4bsEpX3IrRgk6T0q88TwVmOp2Z5NQ1E5SDaONV/neR2Cq7jCNYUh3xHakg1IkejV91zx+
 eYfcdTXDYy4Xuk+FaH12az0SmW42GP4DCkkjJ7U02BaTJtdhXks8UCi0nngIZiCE8qQ3EwZr3LU
 kPAQIMfEG5EImX5MbBcRUDL9IOB9KD0Q6FgIvpGUSm4wDVPbmIR+se6Y9iYUzwjojd1wf8W3yBv
 EO3AEPCcfz60bp8ggJkTGM2HT3CyoMdCk07yG6x8TPvTCJYA5PnAqA8yseNnj+BPpkP7QMcKGAP
 c3HtxcoA4Psfmxhj3bgbqitASUaNRuXuVl9FKXwaC2h4Z1sYljiQ6mTP7XRE2K8J6yKugqTipHE
 1krH2F7YbQzl69mr2raPT4YRrTUmjY/PGfClQaD9TWciT4tvcOri3qqg6u7ciPE9elRN3KXlDqg
 0C6xkJ/56cHP+QuUa7Bh9KMKg26DWD5ln5cBoHobcWn7/AqcXcebW0eSo8rC
X-Received: by 2002:a05:6000:64a:b0:488:781a:f7c0 with SMTP id
 ffacd0b85a97d-48af1b58847mr4859149f8f.13.1790687808891; 
 Tue, 29 Sep 2026 06:16:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af502f79dsm4292199f8f.6.2026.09.29.06.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:48 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 60955fa2850644ef36cf46527b2b44f5fa2c5a48
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0e3004f255d4b3eb87f71d70a16f0c47242cbc2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhX-0007lO-N4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Let an
 optional UDP socket give up on a failed bind
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
Content-Type: multipart/mixed; boundary="===============2375970682841018447=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2375970682841018447==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PzyEuiR8po8="; charset=UTF-8

--PzyEuiR8po8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail

to look a=
t the new patch set (#8)=2E

The following approvals got outdated and were =
removed:
Code-Review+1 by ralf_lici


Change subject: socket: Let an option=
al UDP socket give up on a failed bind
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

socket: Let an optional UDP socket give up on a f=
ailed bind

create_socket_udp_configured()'s "optional" argument covers onl=
y the
socket() call: socket_bind() is fatal, so a caller that can do withou=
t
the socket still dies if the address is unavailable=2E

That is a problem=
 for the upcoming --server-probe, which binds a probe
socket for every addr=
ess family in use, while a connection binds only
the family of the remote i=
t is about to try=2E A --lport whose IPv6 port
happens to be taken by anoth=
er process would therefore kill a client
that could have connected over IPv=
4=2E

Give socket_bind() a msglevel and a return value, and let "optional"
=
apply to the bind as well: the socket is closed and SOCKET_UNDEFINED is
ret=
urned, so the caller can skip that address family=2E Every existing
caller =
passes M_FATAL and keeps its behaviour=2E

Change-Id: I24e5925a72aaede53ef9=
e863fe96fcd7363df402
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M =
src/openvpn/manage=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
3 =
files changed, 29 insertions(+), 14 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/1915/8

diff --git a/src/ope=
nvpn/manage=2Ec b/src/openvpn/manage=2Ec
index e121b38=2E=2E46b0abe 100644
=
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2044,7 +2044,=
7 @@
         {
             man->connection=2Esd_top =3D create_socket_tcp=
(man->settings=2Elocal);
             socket_bind(man->connection=2Esd_top,=
 man->settings=2Elocal, man->settings=2Elocal->ai_family,
-                =
        "MANAGEMENT", false);
+                        "MANAGEMENT", false,=
 M_FATAL);
         }
 
         /*
diff --git a/src/openvpn/socket=2Ec b/s=
rc/openvpn/socket=2Ec
index 41c8bac=2E=2E4c0aab5 100644
--- a/src/openvpn/s=
ocket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -627,12 +627,13 @@
     {
       =
  if (sock->socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
         {
=
-            socket_bind(sock->ctrl_sd, sock->info=2Elsa->bind_local, sock-=
>info=2Eaf, "SOCKS", false);
+            socket_bind(sock->ctrl_sd, sock->=
info=2Elsa->bind_local, sock->info=2Eaf, "SOCKS", false,
+                 =
       M_FATAL);
         }
         else
         {
             socket_bi=
nd(sock->sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "TCP/UDP",
-   =
                     sock->info=2Ebind_ipv6_only);
+                       =
 sock->info=2Ebind_ipv6_only, M_FATAL);
         }
     }
 }
@@ -678,9 +679=
,11 @@
     }
 
     socket_apply_options(sd, sbs, mark, bind_dev);
-    if=
 (bind_addr)
+    if (bind_addr
+        && !socket_bind(sd, bind_addr, af,=
 "TCP/UDP", bind_ipv6_only, optional ? D_LOW : M_FATAL))
     {
-        so=
cket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only);
+        openvpn_c=
lose_socket(sd);
+        return SOCKET_UNDEFINED;
     }
     return sd;
 =
}
@@ -914,9 +917,9 @@
     return new_sd;
 }
 
-void
+bool
 socket_bind(soc=
ket_descriptor_t sd, struct addrinfo *local, int ai_family, const char *pre=
fix,
-            bool ipv6only)
+            bool ipv6only, msglvl_t msgle=
vel)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -940,8 +943,10 @@
     }=

     if (!cur)
     {
-        msg(M_FATAL, "%s: Socket bind failed: Addr =
to bind has no %s record", prefix,
+        msg(msglevel, "%s: Socket bind =
failed: Addr to bind has no %s record", prefix,
             addr_family_na=
me(ai_family));
+        gc_free(&gc);
+        return false;
     }
 
    =
 if (ai_family =3D=3D AF_INET6)
@@ -956,10 +961,13 @@
     }
     if (openv=
pn_bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
-        msg(M_FATAL | M=
_ERRNO, "%s: Socket bind failed on local address %s", prefix,
+        msg(=
msglevel | M_ERRNO, "%s: Socket bind failed on local address %s", prefix,
 =
            print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
+  =
      gc_free(&gc);
+        return false;
     }
     gc_free(&gc);
+    r=
eturn true;
 }
 
 int
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/soc=
ket=2Eh
index 46fa29c=2E=2E20c10c2 100644
--- a/src/openvpn/socket=2Eh
+++ =
b/src/openvpn/socket=2Eh
@@ -348,8 +348,15 @@
 
 struct link_socket *link_s=
ocket_new(void);
 
-void socket_bind(socket_descriptor_t sd, struct addrinf=
o *local, int af_family, const char *prefix,
-                 bool ipv6onl=
y);
+/**
+ * Bind @p sd to the first @p af_family address of @p local=2E A =
failure is
+ * reported at @p msglevel, so a caller that can do without the=
 bind passes a
+ * non-fatal level and checks the result=2E
+ *
+ * @return=
 whether the socket was bound
+ */
+bool socket_bind(socket_descriptor_t sd=
, struct addrinfo *local, int af_family, const char *prefix,
+             =
    bool ipv6only, msglvl_t msglevel);
 
 int openvpn_connect(socket_descri=
ptor_t sd, const struct sockaddr *remote, int connect_timeout,
            =
         volatile int *signal_received);
@@ -405,9 +412,9 @@
  * Create a U=
DP socket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,
  *=
 --mark, --bind-dev and, when @p bind_addr is given, the local bind (IPV6_V=
6ONLY
  * per @p bind_ipv6_only)=2E Shared by create_socket() and the --ser=
ver-probe sockets,
- * so a probe socket is the connection socket it may be=
come=2E A failed bind is
- * fatal; with @p optional a socket the host cann=
ot create is not, so
- * --server-probe can skip that address family (SOCKE=
T_UNDEFINED is returned)=2E
+ * so a probe socket is the connection socket =
it may become=2E With @p optional a
+ * socket the host cannot create or bi=
nd is not fatal, so --server-probe can skip
+ * that address family (SOCKET=
_UNDEFINED is returned)=2E
  */
 socket_descriptor_t create_socket_udp_conf=
igured(sa_family_t af, unsigned int sockflags,
                            =
                      const struct socket_buffer_size *sbs, int mark,

-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24e5925a72aaede53ef9e=
863fe96fcd7363df402
Gerrit-Change-Number: 1915
Gerrit-PatchSet: 8
Gerrit-Ow=
ner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--PzyEuiR8po8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #8</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review+1 by ralf_=
lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">socket: Let an optional UDP socket give up on a faile=
d bind<br><br>create_socket_udp_configured()&#39;s &quot;optional&quot; arg=
ument covers only the<br>socket() call: socket_bind() is fatal, so a caller=
 that can do without<br>the socket still dies if the address is unavailable=
=2E<br><br>That is a problem for the upcoming --server-probe, which binds a=
 probe<br>socket for every address family in use, while a connection binds =
only<br>the family of the remote it is about to try=2E A --lport whose IPv6=
 port<br>happens to be taken by another process would therefore kill a clie=
nt<br>that could have connected over IPv4=2E<br><br>Give socket_bind() a ms=
glevel and a return value, and let &quot;optional&quot;<br>apply to the bin=
d as well: the socket is closed and SOCKET_UNDEFINED is<br>returned, so the=
 caller can skip that address family=2E Every existing<br>caller passes M_F=
ATAL and keeps its behaviour=2E<br><br>Change-Id: I24e5925a72aaede53ef9e863=
fe96fcd7363df402<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<b=
r>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/socket=2Ec<br>M src/open=
vpn/socket=2Eh<br>3 files changed, 29 insertions(+), 14 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/15/1915/8</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/open=
vpn/manage=2Ec</span><br><span>index e121b38=2E=2E46b0abe 100644</span><br>=
<span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -2044,7 +2044,7 @@</span><br><span>         {</span=
><br><span>             man-&gt;connection=2Esd_top =3D create_socket_tcp(m=
an-&gt;settings=2Elocal);</span><br><span>             socket_bind(man-&gt;=
connection=2Esd_top, man-&gt;settings=2Elocal, man-&gt;settings=2Elocal-&gt=
;ai_family,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              &quot;MANAGEMENT&quot;, false);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        &quot;MANAGEMENT&quot;, f=
alse, M_FATAL);</span><br><span>         }</span><br><span> </span><br><spa=
n>         /*</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/ope=
nvpn/socket=2Ec</span><br><span>index 41c8bac=2E=2E4c0aab5 100644</span><br=
><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socke=
t=2Ec</span><br><span>@@ -627,12 +627,13 @@</span><br><span>     {</span><b=
r><span>         if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=2Eproto =
=3D=3D PROTO_UDP)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            socket_bind(sock-&gt;ctrl_sd, sock-&gt;i=
nfo=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, false);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            socket_bin=
d(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf,=
 &quot;SOCKS&quot;, false,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        M_FATAL);</span><br><span>         }</span><=
br><span>         else</span><br><span>         {</span><br><span>         =
    socket_bind(sock-&gt;sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;i=
nfo=2Eaf, &quot;TCP/UDP&quot;,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                        sock-&gt;info=2Ebind_ipv6_only);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        sock-=
&gt;info=2Ebind_ipv6_only, M_FATAL);</span><br><span>         }</span><br><=
span>     }</span><br><span> }</span><br><span>@@ -678,9 +679,11 @@</span><=
br><span>     }</span><br><span> </span><br><span>     socket_apply_options=
(sd, sbs, mark, bind_dev);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (bind_addr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (bind_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &amp;&amp; !socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, b=
ind_ipv6_only, optional ? D_LOW : M_FATAL))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        socket_bind(sd, bind_a=
ddr, af, &quot;TCP/UDP&quot;, bind_ipv6_only);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        openvpn_close_socket(sd);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return SOCKET_UNDEFINED;</=
span><br><span>     }</span><br><span>     return sd;</span><br><span> }</s=
pan><br><span>@@ -914,9 +917,9 @@</span><br><span>     return new_sd;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool<=
/span><br><span> socket_bind(socket_descriptor_t sd, struct addrinfo *local=
, int ai_family, const char *prefix,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            bool ipv6only)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            bool ipv6only, msglvl_t msglevel)</span><=
br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br=
><span> </span><br><span>@@ -940,8 +943,10 @@</span><br><span>     }</span>=
<br><span>     if (!cur)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%s: Socket bind failed=
: Addr to bind has no %s record&quot;, prefix,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;%s: Socket bind fail=
ed: Addr to bind has no %s record&quot;, prefix,</span><br><span>          =
   addr_family_name(ai_family));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return false;</span><br><span>     }</span><br><=
span> </span><br><span>     if (ai_family =3D=3D AF_INET6)</span><br><span>=
@@ -956,10 +961,13 @@</span><br><span>     }</span><br><span>     if (openv=
pn_bind(sd, cur-&gt;ai_addr, cur-&gt;ai_addrlen))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL | M_=
ERRNO, &quot;%s: Socket bind failed on local address %s&quot;, prefix,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel | M=
_ERRNO, &quot;%s: Socket bind failed on local address %s&quot;, prefix,</sp=
an><br><span>             print_sockaddr_ex(local-&gt;ai_addr, &quot;:&quot=
;, PS_SHOW_PORT, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return false;</span><br><span>     }</span><br><span>=
     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return true;</span><br><span> }</span><br><span> </span><br><span> i=
nt</span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=
=2Eh</span><br><span>index 46fa29c=2E=2E20c10c2 100644</span><br><span>--- =
a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span=
><br><span>@@ -348,8 +348,15 @@</span><br><span> </span><br><span> struct l=
ink_socket *link_socket_new(void);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void socket_bind(socket_descriptor_t sd, st=
ruct addrinfo *local, int af_family, const char *prefix,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                 bool ipv6only);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Bind @p sd to the first @p af_family a=
ddress of @p local=2E A failure is</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * reported at @p msglevel, so a caller that can do without =
the bind passes a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 non-fatal level and checks the result=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return whether the socket was bound</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool socket_bind(socket_descriptor_t sd, struct addrinfo *local, i=
nt af_family, const char *prefix,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                 bool ipv6only, msglvl_t msglevel);</span><br=
><span> </span><br><span> int openvpn_connect(socket_descriptor_t sd, const=
 struct sockaddr *remote, int connect_timeout,</span><br><span>            =
         volatile int *signal_received);</span><br><span>@@ -405,9 +412,9 @=
@</span><br><span>  * Create a UDP socket for @p af set up the way a link s=
ocket is: --sndbuf/--rcvbuf,</span><br><span>  * --mark, --bind-dev and, wh=
en @p bind_addr is given, the local bind (IPV6_V6ONLY</span><br><span>  * p=
er @p bind_ipv6_only)=2E Shared by create_socket() and the --server-probe s=
ockets,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * so a probe =
socket is the connection socket it may become=2E A failed bind is</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * fatal; with @p optional a so=
cket the host cannot create is not, so</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * --server-probe can skip that address family (SOCKET_UND=
EFINED is returned)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * so a probe socket is the connection socket it may become=2E With @p o=
ptional a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * socket =
the host cannot create or bind is not fatal, so --server-probe can skip</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that address family =
(SOCKET_UNDEFINED is returned)=2E</span><br><span>  */</span><br><span> soc=
ket_descriptor_t create_socket_udp_configured(sa_family_t af, unsigned int =
sockflags,</span><br><span>                                                =
  const struct socket_buffer_size *sbs, int mark,</span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Dem=
ail">change 1915</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1915?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1915 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>

</body></html>
--PzyEuiR8po8=--


--===============2375970682841018447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2375970682841018447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2375970682841018447==--

