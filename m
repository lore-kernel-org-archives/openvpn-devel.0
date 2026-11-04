Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C0606A32E
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E/+8GRv2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ci9pvWn9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m3FxynjT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JxSY3cnZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=C4HLkHcuT7i3mRk2aXdDvB6kgW204UBw7pS9QFN+LLk=; b=E/+8GRv2BDCGt5y+v0BwDoAluj
	p+g3AkgLAd4yLnyn/YXf0qzW7xTa/kNgoOZayispd1c6KYLvOGUCIubUo4rvPw+SoH9cK4Ma5Of69
	GixGfei0HkHMiM0OthmiKLV3jdRBtnJFgUMXxGhXKW5C55sb6+h/Pmu1nlhLnINko96k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOc04-000000003u5-3pRI;
	Wed, 04 Nov 2026 14:30:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOc03-000000003ty-0UcQ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ny2WLwCU7INtFIELId2OvL0JIKqDWP45zsrBy9wV/+c=; b=Ci9pvWn9y34gNZ15ISXVOGKpa3
 a03eYI9tW6kCHsd1xYmhBUIMPgTgN9tMdauLR6/VilSqwbayF+G80ZMiEmg+jeyarfEHU2fVkz9al
 pRFqEVKxhwUql7gOhgYXQsamu3erL7Fhzpv7Mdg5MHM/K73nWeXoXtrYj9bFd19M8F/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ny2WLwCU7INtFIELId2OvL0JIKqDWP45zsrBy9wV/+c=; b=m3FxynjTwnCTq3vN8hq576F0MU
 aNE6aBGhSGQ1UOIXKnTOLos1yogk6rFC2KVwgci4UvckzmQKia+pZB9dM7PfxJrvkGG0lfflJ3AZj
 tqlzUOns7+ZcgBwBlKyUZTE9DnzMHs3+p+lMpK3iyaQKLfnmlRBUdPi0eIw9Sbx6SaxU=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xObzy-0000000035b-3eFI for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:30:02 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso6901195e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793802592; x=1794407392; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ny2WLwCU7INtFIELId2OvL0JIKqDWP45zsrBy9wV/+c=;
 b=JxSY3cnZB7WgsFmmYggu5L5TK38FMe+R556Xf35VA6RyXWhJ1zIE9VAoqEwqiZxge8
 w3AtQY1h3to13HLF8PxRBjNJ77KoI27U2+42mGwVzfBj4uHu385lz1MzXbgNteE8xxhH
 lcu23TcUsPYBm3QTxY8ZyJXG7xhyE19LL1ynLUGW4GsSE3z7H9fmZo4UAdtic6lBz3ho
 C9v59fj0eMjJg/YwZpcW3y4nMONBaYePz0pn2RLi8QzWzfsSorxrvQnxNLePImag4vGR
 3UWETUd6rxyehkvA072TYhVHpqlpqVmm+Z2qtB7Aj+l/Trq+S7i5Rs9kgCcMRyTwV/AC
 sv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802592; x=1794407392;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ny2WLwCU7INtFIELId2OvL0JIKqDWP45zsrBy9wV/+c=;
 b=0fotSIjhsAHgmcPWFRqHe1GxT8SGW/hpxj4kQu2Nkv6RshgFtvmlhjHB2+iQtzbK1T
 VClTNCdoCgYzQAcsnlF7Ew6hY9zfYgpBgoJTZ48j0CguPSBzjqvwxjqsjAuk4cEQuIGq
 ajIKwUuPJ8Xd4lW6fOcvJ0SE8Z1ZIAvQcOzz7shXnVQyjDzyquRJlmdlZVg7rt3Y+/EY
 adBOuElSVwiikzHA1NhSVgosHYhuUJOZh0n9m/ikrz4mYVUJh/c+nchqZP6iw6dba/zF
 8HlZbPxVSi9q+5S7BfSw6PX+wth2vbX5pXljJEfiMIQnks+5pT8obNFjgDuMrYN6mToN
 sDzA==
X-Gm-Message-State: APuU4Z+lubYXEM6mH6IFzep7wlhxMznFYGceYTIR2HLSPBkOK6qRJINq
 f7da2My65i43YHR4OnysE5juQi8lUw7muLlqe3VvUOm4EOvamdlq0p56WY6GkJirkcu53dKrwOv
 zYW7qqRWJy72/INQCvi3DmEQMLpeWZm7mgz0Re2pqnivVmfCe1rsVJByfInJh3qzokSrJuKsUuz
 gdH7bAtw==
X-Gm-Gg: AYBFou3BaJUAoTnQKwX5JqfhNkoZijl1FcboSLg4mygl/NK1W6HAgCkmWDYHXzRHu6Y
 jhXIPS1eofK05tcPzMF+COj+rb3v+Fr9ODs2Ok9hPj5VYVdHVft/K+s9vUQuG8l0cBi+ic+4yhn
 uvY/S97BQZoc3DmcfwV/K3K/Zfl5n4DjmfjPozdHj9CKXLnW+LkZSv74g2YjM3aCiKVwzUIHA6+
 Coe+DS8A8Ov8hrHmFAcg4kyxeR5TCh0ulApKYivmpOtxKnNs214OHd4IQyZp5BHFuTRNC1rlyhK
 EI5FWDLMk80yZahgzkZTcNOUfd1GutBx1YSE8+w4uR/TzqadM4r93g7kPImifhcsllXSPg2cdu9
 SyZ5OHDyCZiZLi28BaGbbNMeH1uEXge4zusudvZMmXb4zC5lKd5A1YiHk5g0ftr0o/JSkjnNE8J
 2E653EKvn85VNsj5fEMzbtzkCp78QKECzNdRTRCvFSEhA3bLu2uM5ICTKoxX+QsAoj55Amzr82p
 o5+FyI69rzkD3h45VbPnP2Uj0nHdKq3LnV8pGTND0Foo8w2Heci/21Uk8XqSb21RWmAQjxfK3Fs
 52f2EslHbde41svX8YH7NnPFoVAACIUp8CmFq9wPyIgWkJCrF9Dm0OYy4NGNz3Mk/4N9iNrD1mk
 yLVzRC4xJmrd1XYdNqlTKLWpxsftfUPiws9rbf+SKz4GsW8P+yPSz15fPOnevqmRrpaFqpz1Ent
 1Gq+D5lXtE/Wxd5g==
X-Received: by 2002:a05:600c:5397:b0:4a3:5991:719 with SMTP id
 5b1f17b1804b1-4ac1899353bmr362287845e9.31.1793802591109; 
 Wed, 04 Nov 2026 06:29:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab00ff3dsm262584825e9.14.2026.11.04.06.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 06:29:50 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 14:29:40 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 784196dabfe07410b20b9197bd46d58894aef69e
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <37f734b8b8f46e34041292f61390e74ee65a7eba-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xObzy-0000000035b-3eFI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Let an
 optional UDP socket give up on a failed bind
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3675156003690887119=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3675156003690887119==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eISSnw+wGRM="; charset=UTF-8

--eISSnw+wGRM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=
=2E

Hello Arne Schwabe, Ralf Lici, 

I'd like you to reexamine a change=2E=
 Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Dem=
ail

to look at the new patch set (#11)=2E


Change subject: socket: Let an=
 optional UDP socket give up on a failed bind
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: Let an optional UDP socket give =
up on a failed bind

create_socket_udp_configured()'s "optional" argument c=
overs only the
socket() call: socket_bind() is fatal, so a caller that can =
do without
the socket still dies if the address is unavailable=2E

That is =
a problem for the upcoming --server-probe, which binds a probe
socket for e=
very address family in use, while a connection binds only
the family of the=
 remote it is about to try=2E A --lport whose IPv6 port
happens to be taken=
 by another process would therefore kill a client
that could have connected=
 over IPv4=2E

Give socket_bind() a msglevel and a return value, and let "o=
ptional"
apply to the bind as well: the socket is closed and SOCKET_UNDEFIN=
ED is
returned, so the caller can skip that address family=2E Every existin=
g
caller passes M_FATAL and keeps its behaviour=2E

Change-Id: I24e5925a72a=
aede53ef9e863fe96fcd7363df402
Signed-off-by: Lev Stipakov <lev@openvpn=2Ene=
t>
---
M src/openvpn/manage=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/sock=
et=2Eh
3 files changed, 29 insertions(+), 14 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/1915/11

diff --git =
a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 58f63e6=2E=2E013d51=
6 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2105=
,7 +2105,7 @@
         {
             man->connection=2Esd_top =3D create_s=
ocket_tcp(man->settings=2Elocal);
             socket_bind(man->connection=
=2Esd_top, man->settings=2Elocal, man->settings=2Elocal->ai_family,
-      =
                  "MANAGEMENT", false);
+                        "MANAGEMEN=
T", false, M_FATAL);
         }
 
         /*
diff --git a/src/openvpn/sock=
et=2Ec b/src/openvpn/socket=2Ec
index 307b5c6=2E=2E988814e 100644
--- a/src=
/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -268,12 +268,13 @@
    =
 {
         if (sock->socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
 =
        {
-            socket_bind(sock->ctrl_sd, sock->info=2Elsa->bind_lo=
cal, sock->info=2Eaf, "SOCKS", false);
+            socket_bind(sock->ctrl_=
sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "SOCKS", false,
+       =
                 M_FATAL);
         }
         else
         {
            =
 socket_bind(sock->sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "TCP/=
UDP",
-                        sock->info=2Ebind_ipv6_only);
+             =
           sock->info=2Ebind_ipv6_only, M_FATAL);
         }
     }
 }
@@ -=
319,9 +320,11 @@
     }
 
     socket_apply_options(sd, sbs, mark, bind_dev=
);
-    if (bind_addr)
+    if (bind_addr
+        && !socket_bind(sd, bind=
_addr, af, "TCP/UDP", bind_ipv6_only, optional ? D_LOW : M_FATAL))
     {
-=
        socket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only);
+       =
 openvpn_close_socket(sd);
+        return SOCKET_UNDEFINED;
     }
     re=
turn sd;
 }
@@ -556,9 +559,9 @@
     return new_sd;
 }
 
-void
+bool
 socke=
t_bind(socket_descriptor_t sd, const struct addrinfo *local, int ai_family,=

-            const char *prefix, bool ipv6only)
+            const char *p=
refix, bool ipv6only, msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_=
new();
 
@@ -582,8 +585,10 @@
     }
     if (!cur)
     {
-        msg(M_F=
ATAL, "%s: Socket bind failed: Addr to bind has no %s record", prefix,
+   =
     msg(msglevel, "%s: Socket bind failed: Addr to bind has no %s record",=
 prefix,
             addr_family_name(ai_family));
+        gc_free(&gc);
=
+        return false;
     }
 
     if (ai_family =3D=3D AF_INET6)
@@ -598=
,10 +603,13 @@
     }
     if (openvpn_bind(sd, cur->ai_addr, cur->ai_addrl=
en))
     {
-        msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on loca=
l address %s", prefix,
+        msg(msglevel | M_ERRNO, "%s: Socket bind fa=
iled on local address %s", prefix,
             print_sockaddr_ex(local->ai=
_addr, ":", PS_SHOW_PORT, &gc));
+        gc_free(&gc);
+        return fal=
se;
     }
     gc_free(&gc);
+    return true;
 }
 
 int
diff --git a/src/=
openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 52e09c9=2E=2E88c51fa 1006=
44
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -337,8 +337=
,15 @@
 
 struct link_socket *link_socket_new(void);
 
-void socket_bind(so=
cket_descriptor_t sd, const struct addrinfo *local, int af_family,
-       =
          const char *prefix, bool ipv6only);
+/**
+ * Bind @p sd to the fi=
rst @p af_family address of @p local=2E A failure is
+ * reported at @p msg=
level, so a caller that can do without the bind passes a
+ * non-fatal leve=
l and checks the result=2E
+ *
+ * @return whether the socket was bound
+ *=
/
+bool socket_bind(socket_descriptor_t sd, const struct addrinfo *local, i=
nt af_family,
+                 const char *prefix, bool ipv6only, msglvl_t=
 msglevel);
 
 int openvpn_connect(socket_descriptor_t sd, const struct soc=
kaddr *remote, int connect_timeout,
                     volatile int *sign=
al_received);
@@ -392,9 +399,9 @@
  * Create a UDP socket for @p af set up =
the way a link socket is: --sndbuf/--rcvbuf,
  * --mark, --bind-dev and, wh=
en @p bind_addr is given, the local bind (IPV6_V6ONLY
  * per @p bind_ipv6_=
only)=2E Shared by create_socket() and the --server-probe sockets,
- * so a=
 probe socket is the connection socket it may become=2E A failed bind is
- =
* fatal; with @p optional a socket the host cannot create is not, so
- * --=
server-probe can skip that address family (SOCKET_UNDEFINED is returned)=2E=

+ * so a probe socket is the connection socket it may become=2E With @p op=
tional a
+ * socket the host cannot create or bind is not fatal, so --serve=
r-probe can skip
+ * that address family (SOCKET_UNDEFINED is returned)=2E
=
  */
 socket_descriptor_t create_socket_udp_configured(sa_family_t af, unsi=
gned int sockflags,
                                                  const=
 struct socket_buffer_size *sbs, int mark,

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Gerri=
t-Change-Number: 1915
Gerrit-PatchSet: 11
Gerrit-Owner: Lev Stipakov <lstip=
akov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ra=
lf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--eISSnw+wGRM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=2E </p>
<p>Lev =
Stipakov <strong>uploaded patch set #11</strong> to this change=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">View =
Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">socket: Let an optional UDP socket give up on a=
 failed bind<br><br>create_socket_udp_configured()&#39;s &quot;optional&quo=
t; argument covers only the<br>socket() call: socket_bind() is fatal, so a =
caller that can do without<br>the socket still dies if the address is unava=
ilable=2E<br><br>That is a problem for the upcoming --server-probe, which b=
inds a probe<br>socket for every address family in use, while a connection =
binds only<br>the family of the remote it is about to try=2E A --lport whos=
e IPv6 port<br>happens to be taken by another process would therefore kill =
a client<br>that could have connected over IPv4=2E<br><br>Give socket_bind(=
) a msglevel and a return value, and let &quot;optional&quot;<br>apply to t=
he bind as well: the socket is closed and SOCKET_UNDEFINED is<br>returned, =
so the caller can skip that address family=2E Every existing<br>caller pass=
es M_FATAL and keeps its behaviour=2E<br><br>Change-Id: I24e5925a72aaede53e=
f9e863fe96fcd7363df402<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet=
&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/socket=2Ec<br>M sr=
c/openvpn/socket=2Eh<br>3 files changed, 29 insertions(+), 14 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/15/1915/11</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/s=
rc/openvpn/manage=2Ec</span><br><span>index 58f63e6=2E=2E013d516 100644</sp=
an><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn=
/manage=2Ec</span><br><span>@@ -2105,7 +2105,7 @@</span><br><span>         =
{</span><br><span>             man-&gt;connection=2Esd_top =3D create_socke=
t_tcp(man-&gt;settings=2Elocal);</span><br><span>             socket_bind(m=
an-&gt;connection=2Esd_top, man-&gt;settings=2Elocal, man-&gt;settings=2Elo=
cal-&gt;ai_family,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     &quot;MANAGEMENT&quot;, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;MANAGEMENT&=
quot;, false, M_FATAL);</span><br><span>         }</span><br><span> </span>=
<br><span>         /*</span><br><span>diff --git a/src/openvpn/socket=2Ec b=
/src/openvpn/socket=2Ec</span><br><span>index 307b5c6=2E=2E988814e 100644</=
span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openv=
pn/socket=2Ec</span><br><span>@@ -268,12 +268,13 @@</span><br><span>     {<=
/span><br><span>         if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=
=2Eproto =3D=3D PROTO_UDP)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            socket_bind(sock-&gt;ctrl_sd, s=
ock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, f=
alse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
ocket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;i=
nfo=2Eaf, &quot;SOCKS&quot;, false,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        M_FATAL);</span><br><span>         =
}</span><br><span>         else</span><br><span>         {</span><br><span>=
             socket_bind(sock-&gt;sd, sock-&gt;info=2Elsa-&gt;bind_local, s=
ock-&gt;info=2Eaf, &quot;TCP/UDP&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        sock-&gt;info=2Ebind_ipv6_only);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    sock-&gt;info=2Ebind_ipv6_only, M_FATAL);</span><br><span>         }</s=
pan><br><span>     }</span><br><span> }</span><br><span>@@ -319,9 +320,11 @=
@</span><br><span>     }</span><br><span> </span><br><span>     socket_appl=
y_options(sd, sbs, mark, bind_dev);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (bind_addr)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (bind_addr</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        &amp;&amp; !socket_bind(sd, bind_addr, af, &quot;TCP/UDP=
&quot;, bind_ipv6_only, optional ? D_LOW : M_FATAL))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_bind(s=
d, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_only);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        openvpn_close_socket(sd);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return SOCKET_UND=
EFINED;</span><br><span>     }</span><br><span>     return sd;</span><br><s=
pan> }</span><br><span>@@ -556,9 +559,9 @@</span><br><span>     return new_=
sd;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span> socket_bind(socket_descriptor_t sd, const struct =
addrinfo *local, int ai_family,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            const char *prefix, bool ipv6only)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            const char *prefix, bool i=
pv6only, msglvl_t msglevel)</span><br><span> {</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -582,8 +585,=
10 @@</span><br><span>     }</span><br><span>     if (!cur)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_=
FATAL, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;, p=
refix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(m=
sglevel, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;,=
 prefix,</span><br><span>             addr_family_name(ai_family));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span>     }</span><br><span> </span><br><span>     if (ai_famil=
y =3D=3D AF_INET6)</span><br><span>@@ -598,10 +603,13 @@</span><br><span>  =
   }</span><br><span>     if (openvpn_bind(sd, cur-&gt;ai_addr, cur-&gt;ai_=
addrlen))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(M_FATAL | M_ERRNO, &quot;%s: Socket bind failed on l=
ocal address %s&quot;, prefix,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msg(msglevel | M_ERRNO, &quot;%s: Socket bind failed on =
local address %s&quot;, prefix,</span><br><span>             print_sockaddr=
_ex(local-&gt;ai_addr, &quot;:&quot;, PS_SHOW_PORT, &amp;gc));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</spa=
n><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span> }</=
span><br><span> </span><br><span> int</span><br><span>diff --git a/src/open=
vpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 52e09c9=2E=2E=
88c51fa 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span=
>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -337,8 +337,15 @@</span><b=
r><span> </span><br><span> struct link_socket *link_socket_new(void);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void sock=
et_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_family=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 con=
st char *prefix, bool ipv6only);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Bind @p sd to the first @p af_family address of @p local=2E A failure is</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reported at @p msgl=
evel, so a caller that can do without the bind passes a</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * non-fatal level and checks the resul=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return whether the socket wa=
s bound</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool socket_bind(socket_desc=
riptor_t sd, const struct addrinfo *local, int af_family,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                 const char *prefix, =
bool ipv6only, msglvl_t msglevel);</span><br><span> </span><br><span> int o=
penvpn_connect(socket_descriptor_t sd, const struct sockaddr *remote, int c=
onnect_timeout,</span><br><span>                     volatile int *signal_r=
eceived);</span><br><span>@@ -392,9 +399,9 @@</span><br><span>  * Create a =
UDP socket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,</s=
pan><br><span>  * --mark, --bind-dev and, when @p bind_addr is given, the l=
ocal bind (IPV6_V6ONLY</span><br><span>  * per @p bind_ipv6_only)=2E Shared=
 by create_socket() and the --server-probe sockets,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * so a probe socket is the connection sock=
et it may become=2E A failed bind is</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * fatal; with @p optional a socket the host cannot create i=
s not, so</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --server-=
probe can skip that address family (SOCKET_UNDEFINED is returned)=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * so a probe socket is th=
e connection socket it may become=2E With @p optional a</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * socket the host cannot create or bin=
d is not fatal, so --server-probe can skip</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * that address family (SOCKET_UNDEFINED is returned=
)=2E</span><br><span>  */</span><br><span> socket_descriptor_t create_socke=
t_udp_configured(sa_family_t af, unsigned int sockflags,</span><br><span>  =
                                                const struct socket_buffer_=
size *sbs, int mark,</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">change 1915</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24e5925a72=
aaede53ef9e863fe96fcd7363df402 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1915 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipako=
v@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
alf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>

</body></html>
--eISSnw+wGRM=--


--===============3675156003690887119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3675156003690887119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3675156003690887119==--

