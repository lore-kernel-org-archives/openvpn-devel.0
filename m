Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E7BC88E72
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=VbNfr5O2vvYNAiTvjV/N3LT0QsELPO28EZW5jyrUSjA=; b=j6in6e3OV5hBDR
	FmxeTWxA/ZIijuFAz3ZZwU9jA2KPFz8M3X4Ph3qQGj8gRDwGHKEHEmNdgA6SuzPxWgVdj0mowCP6U
	7oTig2fM1Nyj9J5bYKwGlDn+wf1kDMscGPvkndVXH2SBD9I4TRVLWyNeST9JEIN3NNR1jDn6JLWMp
	XJ8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Ws-0000OR-3b;
	Mon, 14 Sep 2026 14:19:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67Wq-0000O8-Nf
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bQnVwpdxj74SQ5KHq/tENnTa4qXFvtw7fD4fUmWVQrE=; b=E3xt7916vfgISTzC3cxGD/aWi/
 uRErz6cpy6gKWMvwNiwxo9YmREh0xbbEdGOyURxtCmrGYUNNc0mChx1t5UyP3l10zO2WWTkm9R9yj
 Ju/wDkgYgEA9WDy9BTWPDOjhviWHJXTRCOWi1MgT22wcAACDvXbxDic6ZfR6ryljWXFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bQnVwpdxj74SQ5KHq/tENnTa4qXFvtw7fD4fUmWVQrE=; b=M
 vuesiLmYglqgktzf2Tvvu59RwtlhgrzRNLubYJCRRC6Cwa3C+k6Y60ltx4pFD25bhe6dSt6jmI2YH
 Q86bG105l/aSNDlikrxS3m/MFhKG28okJ5sNziI768g89pMEWQ6EDx7Obq2O8RwOPhLvmvxheSdrE
 g5gSfpxrLuotp6l0=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67Wc-0001T4-S4 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:29 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49e6deb520eso27245745e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395548; x=1790000348; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bQnVwpdxj74SQ5KHq/tENnTa4qXFvtw7fD4fUmWVQrE=;
 b=ZBRZyb+2yVO6enfqHfQA21lw5pS/SCcCS52sqzJ2I8EZd7lIOjozOvkfhgnM4TplC9
 ujpbFTWD8TP7Vco/Skd5LBgUKk4efQCVFlqJoFf9MgnCBKCMkvE9VAu80q62Ao94W6Ih
 uIapLxGc428PTtjEm3zQ+ykJJBY5sx15LADZKUWgctWbJSgWHHhTmzT8F6FbE/f0vDgM
 qRd6EwsR+n2TFmKoZhwWWcpTxxEWyuDsMD74X6Jpcn/6RyUFHg0r/7Fv1Qg3uQRKTyKL
 AtkvfWRUyVXQbU2XOSWsXfU7hzLVVNr9ilFcLL7hS8bmgwF7FFL/SCBDUxQ/nSoNdATH
 0Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395548; x=1790000348;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQnVwpdxj74SQ5KHq/tENnTa4qXFvtw7fD4fUmWVQrE=;
 b=SLpRJL/7pNElmp90X6zfq/GEBvWANuENxuTY4ZqjDZRcitDxschTZThrvNcW3gAOCG
 d41xAevz2MBQcC+3Nq1zMAAS9ThS8j3scRQI6MFq3Y1qOVUSPUt7j4vhTnFFMiv5KkBS
 ESjlFlDJi0kacrT7KaZB4VlfUyOY7dHuuGjYU0N5GxNKGfVuzZ1kCAQTx9yhamwrvZog
 2Nd2yc1TzLBSszU7bIrMKaKNRLwKVbJNXoXIOhZjuCYL4BXIKZ/wvIkb6+zCy4oEmiYz
 eEgu3D1aO7TSgebXeNouEjNJXCldNblRs7dpJubIsnIEJ7kMq+Rws+r1qhYxvuPJTMyO
 z8VA==
X-Gm-Message-State: AFuF++kNlvxgQH5J/cwSuZHokmXNhBr8Kh1/FAv4gHzOq7kZMFpChUy3
 5z7vYtTzJgO7Go6g2+rJRbGEKKu2awKVKUMAqDfulwitO6S9PnJ1VrFRCNUwW59sjfDo9mBEdfE
 WsZps6y3BJkeAHEO4XYUq1X6Wehm7RxpNEtWKgUFo2TLqiJ1n4K4dtM0IJn2vUmJaYQtiq3Vs+E
 mZPg31qg==
X-Gm-Gg: AYBFou0W2nZrNYLiO3O7kfzZ71pyAKp8zBc0LA8n9uFU62AzlKsQdkbuI87S2z2lXkY
 7fisrZyGjJwryrW8NlbYZa7ahCJyOjEPT5H8jZYo83sHYMhVpSWSKWpzau9oNJGso3Zf5Qirev0
 YCWrrxX6cZ/XMgamuEuWAfMEjSe85Ks6QBNRv0ZAObBqwR1FVR1v6AOUZSDB2/T71VBGHJw7kXy
 gp3HVHrl+WmcV+6yzaDc86INw4P29XBC9jWw6OwQJ4TMiFNvTnYZCii4r19MlX3j3kIxXU8RJSl
 43StbKy/lUeY1Xi1yQc4LfqKHF4ix7mKlzp9wlFrCO7x75+QBTEE/w/+bpGS7aou+B711+RSoCE
 EcCRCmhgc4CSwPCJM6PZDtl9Jfd2anB9OIedeoHmG6ON2ucUPu/6Ep/oI2BVT45iBT+rMNa2dB8
 fEHscMv8Nnq7awMuy8eGwCtYertiW+UmCFz9FPj8/e04mLnFeY1Vt5U+fn1YQxBkyAaPDturUq/
 BLjNMxrcqlD1fjWUubpbNNEcnViJziMx1ah4Hh9YPG8pOMT8qsmoX8NltzkAvkABPkryJvgIa5s
 bwO5p3LSoUCfCdiRywEspQrGuD939Ggnl422VKdlO2P3wajCcpTrxGvF3fo76w==
X-Received: by 2002:a05:600d:8494:20b0:49e:799a:8969 with SMTP id
 5b1f17b1804b1-49e7a691acemr26187225e9.30.1789395548190; 
 Mon, 14 Sep 2026 07:19:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e0asm460500405e9.1.2026.09.14.07.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:19:07 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:19:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 563fb85b2ea27e5d94c6fe80f8ca5d995776eeae
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2bc5420f9fbdf501740fbc9343985f318bfd7a27-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67Wc-0001T4-S4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: let an
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2267828702022496903=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2267828702022496903==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sBnmMC6HtCY="; charset=UTF-8

--sBnmMC6HtCY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1915?usp=3Demail

to review the following change=2E


Chang=
e subject: socket: let an optional UDP socket give up on a failed bind
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: let an o=
ptional UDP socket give up on a failed bind

create_socket_udp_configured()=
's "optional" argument covers only the
socket() call: socket_bind() is fata=
l, so a caller that can do without
the socket still dies if the address is =
unavailable=2E

That is a problem for --server-probe, which binds a probe s=
ocket for
every address family in use, while a connection binds only the fa=
mily of
the remote it is about to try=2E A --lport whose IPv6 port happens =
to be
taken by another process therefore kills a client that would have
con=
nected over IPv4=2E

Give socket_bind() a msglevel and a return value, and =
let "optional"
apply to the bind as well: the socket is closed and SOCKET_U=
NDEFINED is
returned, so the caller can skip that address family=2E Every e=
xisting
caller passes M_FATAL and keeps its behaviour=2E

Change-Id: I24e59=
25a72aaede53ef9e863fe96fcd7363df402
Signed-off-by: Lev Stipakov <lev@openvp=
n=2Enet>
---
M src/openvpn/manage=2Ec
M src/openvpn/socket=2Ec
M src/openvp=
n/socket=2Eh
3 files changed, 29 insertions(+), 14 deletions(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/1915/1

diff =
--git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index e121b38=2E=2E=
46b0abe 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@=
 -2044,7 +2044,7 @@
         {
             man->connection=2Esd_top =3D cr=
eate_socket_tcp(man->settings=2Elocal);
             socket_bind(man->conne=
ction=2Esd_top, man->settings=2Elocal, man->settings=2Elocal->ai_family,
- =
                       "MANAGEMENT", false);
+                        "MANA=
GEMENT", false, M_FATAL);
         }
 
         /*
diff --git a/src/openvpn=
/socket=2Ec b/src/openvpn/socket=2Ec
index 41c8bac=2E=2E4c0aab5 100644
--- =
a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -627,12 +627,13 @@=

     {
         if (sock->socks_proxy && sock->info=2Eproto =3D=3D PROTO_U=
DP)
         {
-            socket_bind(sock->ctrl_sd, sock->info=2Elsa->bi=
nd_local, sock->info=2Eaf, "SOCKS", false);
+            socket_bind(sock->=
ctrl_sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "SOCKS", false,
+  =
                      M_FATAL);
         }
         else
         {
       =
      socket_bind(sock->sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, =
"TCP/UDP",
-                        sock->info=2Ebind_ipv6_only);
+        =
                sock->info=2Ebind_ipv6_only, M_FATAL);
         }
     }
 }=

@@ -678,9 +679,11 @@
     }
 
     socket_apply_options(sd, sbs, mark, bin=
d_dev);
-    if (bind_addr)
+    if (bind_addr
+        && !socket_bind(sd,=
 bind_addr, af, "TCP/UDP", bind_ipv6_only, optional ? D_LOW : M_FATAL))
   =
  {
-        socket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only);
+  =
      openvpn_close_socket(sd);
+        return SOCKET_UNDEFINED;
     }
  =
   return sd;
 }
@@ -914,9 +917,9 @@
     return new_sd;
 }
 
-void
+bool
 =
socket_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_family, =
const char *prefix,
-            bool ipv6only)
+            bool ipv6only,=
 msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -940,8 +9=
43,10 @@
     }
     if (!cur)
     {
-        msg(M_FATAL, "%s: Socket bin=
d failed: Addr to bind has no %s record", prefix,
+        msg(msglevel, "%=
s: Socket bind failed: Addr to bind has no %s record", prefix,
            =
 addr_family_name(ai_family));
+        gc_free(&gc);
+        return false=
;
     }
 
     if (ai_family =3D=3D AF_INET6)
@@ -956,10 +961,13 @@
     }=

     if (openvpn_bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
-        =
msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local address %s", prefix=
,
+        msg(msglevel | M_ERRNO, "%s: Socket bind failed on local address=
 %s", prefix,
             print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_P=
ORT, &gc));
+        gc_free(&gc);
+        return false;
     }
     gc_fr=
ee(&gc);
+    return true;
 }
 
 int
diff --git a/src/openvpn/socket=2Eh b/=
src/openvpn/socket=2Eh
index 46fa29c=2E=2E20c10c2 100644
--- a/src/openvpn/=
socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -348,8 +348,15 @@
 
 struct link=
_socket *link_socket_new(void);
 
-void socket_bind(socket_descriptor_t sd,=
 struct addrinfo *local, int af_family, const char *prefix,
-              =
   bool ipv6only);
+/**
+ * Bind @p sd to the first @p af_family address of=
 @p local=2E A failure is
+ * reported at @p msglevel, so a caller that can=
 do without the bind passes a
+ * non-fatal level and checks the result=2E
=
+ *
+ * @return whether the socket was bound
+ */
+bool socket_bind(socket_=
descriptor_t sd, struct addrinfo *local, int af_family, const char *prefix,=

+                 bool ipv6only, msglvl_t msglevel);
 
 int openvpn_connec=
t(socket_descriptor_t sd, const struct sockaddr *remote, int connect_timeou=
t,
                     volatile int *signal_received);
@@ -405,9 +412,9 @@=

  * Create a UDP socket for @p af set up the way a link socket is: --sndbu=
f/--rcvbuf,
  * --mark, --bind-dev and, when @p bind_addr is given, the loc=
al bind (IPV6_V6ONLY
  * per @p bind_ipv6_only)=2E Shared by create_socket(=
) and the --server-probe sockets,
- * so a probe socket is the connection s=
ocket it may become=2E A failed bind is
- * fatal; with @p optional a socke=
t the host cannot create is not, so
- * --server-probe can skip that addres=
s family (SOCKET_UNDEFINED is returned)=2E
+ * so a probe socket is the con=
nection socket it may become=2E With @p optional a
+ * socket the host cann=
ot create or bind is not fatal, so --server-probe can skip
+ * that address=
 family (SOCKET_UNDEFINED is returned)=2E
  */
 socket_descriptor_t create_=
socket_udp_configured(sa_family_t af, unsigned int sockflags,
             =
                                     const struct socket_buffer_size *sbs, =
int mark,

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/191=
5?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchang=
e
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24e5925a=
72aaede53ef9e863fe96fcd7363df402
Gerrit-Change-Number: 1915
Gerrit-PatchSet=
: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--sBnmMC6HtCY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1915?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">so=
cket: let an optional UDP socket give up on a failed bind<br><br>create_soc=
ket_udp_configured()&#39;s &quot;optional&quot; argument covers only the<br=
>socket() call: socket_bind() is fatal, so a caller that can do without<br>=
the socket still dies if the address is unavailable=2E<br><br>That is a pro=
blem for --server-probe, which binds a probe socket for<br>every address fa=
mily in use, while a connection binds only the family of<br>the remote it i=
s about to try=2E A --lport whose IPv6 port happens to be<br>taken by anoth=
er process therefore kills a client that would have<br>connected over IPv4=
=2E<br><br>Give socket_bind() a msglevel and a return value, and let &quot;=
optional&quot;<br>apply to the bind as well: the socket is closed and SOCKE=
T_UNDEFINED is<br>returned, so the caller can skip that address family=2E E=
very existing<br>caller passes M_FATAL and keeps its behaviour=2E<br><br>Ch=
ange-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402<br>Signed-off-by: Lev St=
ipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M sr=
c/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>3 files changed, 29 ins=
ertions(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/1915/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index e121=
b38=2E=2E46b0abe 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span>=
<br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2044,7 +2044,7 @=
@</span><br><span>         {</span><br><span>             man-&gt;connectio=
n=2Esd_top =3D create_socket_tcp(man-&gt;settings=2Elocal);</span><br><span=
>             socket_bind(man-&gt;connection=2Esd_top, man-&gt;settings=2El=
ocal, man-&gt;settings=2Elocal-&gt;ai_family,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                        &quot;MANAGEMENT&quot;, fal=
se);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         &quot;MANAGEMENT&quot;, false, M_FATAL);</span><br><span>         =
}</span><br><span> </span><br><span>         /*</span><br><span>diff --git =
a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 41c=
8bac=2E=2E4c0aab5 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span=
><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -627,12 +627,13 =
@@</span><br><span>     {</span><br><span>         if (sock-&gt;socks_proxy=
 &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            socket=
_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=
=2Eaf, &quot;SOCKS&quot;, false);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            socket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa=
-&gt;bind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, false,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        M_FATAL)=
;</span><br><span>         }</span><br><span>         else</span><br><span>=
         {</span><br><span>             socket_bind(sock-&gt;sd, sock-&gt;i=
nfo=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;TCP/UDP&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        sock-&=
gt;info=2Ebind_ipv6_only);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        sock-&gt;info=2Ebind_ipv6_only, M_FATAL);</s=
pan><br><span>         }</span><br><span>     }</span><br><span> }</span><b=
r><span>@@ -678,9 +679,11 @@</span><br><span>     }</span><br><span> </span=
><br><span>     socket_apply_options(sd, sbs, mark, bind_dev);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (bind_addr)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (bind_addr</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !socket_bind(sd, b=
ind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_only, optional ? D_LOW : M_FAT=
AL))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6=
_only);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        open=
vpn_close_socket(sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return SOCKET_UNDEFINED;</span><br><span>     }</span><br><span> =
    return sd;</span><br><span> }</span><br><span>@@ -914,9 +917,9 @@</span=
><br><span>     return new_sd;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span> socket_bind(socket_des=
criptor_t sd, struct addrinfo *local, int ai_family, const char *prefix,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            bool ipv6onl=
y)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bool =
ipv6only, msglvl_t msglevel)</span><br><span> {</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -940,8 +943=
,10 @@</span><br><span>     }</span><br><span>     if (!cur)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_FATAL, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;, =
prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
msglevel, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;=
, prefix,</span><br><span>             addr_family_name(ai_family));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span>     }</span><br><span> </span><br><span>     if (ai_fami=
ly =3D=3D AF_INET6)</span><br><span>@@ -956,10 +961,13 @@</span><br><span> =
    }</span><br><span>     if (openvpn_bind(sd, cur-&gt;ai_addr, cur-&gt;ai=
_addrlen))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_FATAL | M_ERRNO, &quot;%s: Socket bind failed on =
local address %s&quot;, prefix,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(msglevel | M_ERRNO, &quot;%s: Socket bind failed on=
 local address %s&quot;, prefix,</span><br><span>             print_sockadd=
r_ex(local-&gt;ai_addr, &quot;:&quot;, PS_SHOW_PORT, &amp;gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span>diff --git a/src/ope=
nvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 46fa29c=2E=
=2E20c10c2 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><s=
pan>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -348,8 +348,15 @@</span=
><br><span> </span><br><span> struct link_socket *link_socket_new(void);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void s=
ocket_bind(socket_descriptor_t sd, struct addrinfo *local, int af_family, c=
onst char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
              bool ipv6only);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Bin=
d @p sd to the first @p af_family address of @p local=2E A failure is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reported at @p msgleve=
l, so a caller that can do without the bind passes a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * non-fatal level and checks the result=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return whether the socket was=
 bound</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool socket_bind(socket_descr=
iptor_t sd, struct addrinfo *local, int af_family, const char *prefix,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                 bool ip=
v6only, msglvl_t msglevel);</span><br><span> </span><br><span> int openvpn_=
connect(socket_descriptor_t sd, const struct sockaddr *remote, int connect_=
timeout,</span><br><span>                     volatile int *signal_received=
);</span><br><span>@@ -405,9 +412,9 @@</span><br><span>  * Create a UDP soc=
ket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,</span><br=
><span>  * --mark, --bind-dev and, when @p bind_addr is given, the local bi=
nd (IPV6_V6ONLY</span><br><span>  * per @p bind_ipv6_only)=2E Shared by cre=
ate_socket() and the --server-probe sockets,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * so a probe socket is the connection socket it may=
 become=2E A failed bind is</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * fatal; with @p optional a socket the host cannot create is not, so=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --server-probe can=
 skip that address family (SOCKET_UNDEFINED is returned)=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * so a probe socket is the connect=
ion socket it may become=2E With @p optional a</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * socket the host cannot create or bind is not =
fatal, so --server-probe can skip</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * that address family (SOCKET_UNDEFINED is returned)=2E</spa=
n><br><span>  */</span><br><span> socket_descriptor_t create_socket_udp_con=
figured(sa_family_t af, unsigned int sockflags,</span><br><span>           =
                                       const struct socket_buffer_size *sbs=
, int mark,</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">change 1915</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24e592=
5a72aaede53ef9e863fe96fcd7363df402 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1915 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--sBnmMC6HtCY=--


--===============2267828702022496903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2267828702022496903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2267828702022496903==--

