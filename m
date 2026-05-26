Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC604CD5BB1
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/yfbMuLm8IEeIf+bas2ztpUL4yHUFi/BV2DLUWj294=; b=Je3jPIL+QBy2IMMJXMpv6/GG38
	jiZprVX/Dgtiy4qH+25x5pXYU1bjv5q+nlKsoB/JzQT2NTHA3FrY88sH4Xp04f/OsXW0niVTGhIP9
	uvoKBBz2qeRpIrZglQxU5nGrkrhU+bbWyk4CljsRe1nd97eQuuCyTQH0+c4z3jh39hmM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRqlZ-0006qG-GO;
	Tue, 26 May 2026 12:20:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wRqlN-0006pl-Jo
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:20:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=K1MkhLfUhyd7y45iQRWGzN7beCO920A5UBzg1Ojn6OE=; b=RY2KEejediQledBxd859UGrTa2
 7G4PumByRAvFCj5DbEZjVoY29wtwCArvA6otQUxhnjVNhH1e7YQIcxcnms+2RbOqPgk2cdIodFUE3
 1g9riuRgvAavtxDaHOMA5NFjCv8m0vFQwYnh62Sf/xEA3smMJaXBbLjtRCPpqlrx5kdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K1MkhLfUhyd7y45iQRWGzN7beCO920A5UBzg1Ojn6OE=; b=N
 b9Bcey28Cj62N7PGSnikevha+EVvjuzUrBaspu1Y5FQ9XOpk/MwzWoTete+6Ezux/dq1iHobV5oUK
 yxFAN1CV+gMCQZXTNPcjPkXET9LK/9kyrFvFLKxOPx4e+iFzZl2fG5+w8qBVCmlktufG6FwH8rPJ8
 ZLZCnRQYPXoqfHBI=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wRqlI-00068b-3S for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:20:02 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so49518785e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 26 May 2026 05:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779797985; x=1780402785; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K1MkhLfUhyd7y45iQRWGzN7beCO920A5UBzg1Ojn6OE=;
 b=VW0kb81FIy52v1tKdof44WMNhQbu/0+3YxeVG1/xYbUJ2VWU84DNaH/peTa7M+A3Yb
 F28B/eugT07liAxu9mhyIdZf9YeiXSUEue4BsUC8vR4mtYDeRsXbBHgdbeyNYhFPFcEU
 bhH0ogKqhT9dzLRr6gW80zSdsaSWqBT0gWXPGcmdd4EyHlqTWII1v0Q5BCoLilxRQj79
 /EtFUJjAP+XRFqWbi6QqCuuW2ShrEgItBx3Azc1urU7LGbK2hj7DOGB9E2smtOLtKm3K
 owIf7NeIX5KYQPePTdzfm+tkhvknOejqnY8HU6bH1i4I2aHN2hCNEvtikxIP/1GkbDf7
 7FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779797985; x=1780402785;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K1MkhLfUhyd7y45iQRWGzN7beCO920A5UBzg1Ojn6OE=;
 b=KrHvF+ydD73ZTauOIUi3gDN5nL+2QNSwK8cfddxREHe9SFGPCmABD/7ttO2VOdqpw2
 4Xkr8hCm/zUOypI+QpJEbgYRP9zanHJlmkqkltK9OY3RlT02j8OWJ0V+ewjAS004xYBh
 SXmoqWGbNcOjYu2JN5KWLhsfxKSMGJ2945eG9AW6DEeo34D68V8ToY6nxi1WkmXKJb+p
 csLzz4xvrulEpZcJ11IY9GM/lZalXsOqhtG2GCO1BsJdHuSQ9B4uC0RyNDLMrDZWz+zH
 jBJZ7jvorcm/KmEdyE1DQFcabH4MKctD3o5s8n7qR1w/hUrMeLlVf69Zu6bLFalEsoIZ
 X4tQ==
X-Gm-Message-State: AOJu0YxWm+dGgU5DMdhJxUPFdD6KAENBkS04pTtGVTlOI7kdxr4x/xtC
 vPCVcCNQMCNlmps+cTzNQXaF777nThAq+8BFDbegOkywq8p22qfVQPctxienOCg/6lMRnMPYb7R
 Z04Vrb/+e/fgh5fCA4VwGgUFeURvtPH9W8qr60rf95g5t/6D/7Eq1oOfCifTJnLfZytgf
X-Gm-Gg: Acq92OGKuybQKsIxgDCQnv1WwZxkTBNz+XyTFkhXt6h5lae2XU9BfoVvnkoazQIxhbR
 T3OKoZEpYadLlw5rXl8Bi0m9Rgh+IMfDo/9N57OwmjjUKKmhmPQWw/DBzuXGCLLZyj6n5JmBnzS
 s+B341jsM5zFTd04JKrLpKRLOfoQH3l0z7S8A46l2EHPwejHXTBLtiDIHpmFcUAErUGas7Fq2Ow
 8g4VnnHZrC16G6fxfi+T198RhRnBRKxA5DPCguEVZRdkkpPEd2aNAyZb5eX9QbgpVv8Hu7DDGQx
 yyLrNFSmxSDyKXFeT82ZqX50uj+4LMoCtB6aGHcrLrXLOdNXfV6VAsoJHBBImY50Tzq+Nf2e/r9
 356zijC0X43MLXP5O86dr14yfIw+wRQvrgLu+QbqEtKXoHZVzMiskO8wJHm3xtpHYR8CSCY+RPs
 dtsWU644hTPfmCvnXbZEZ6Qc4LlIJCHfrafyIgkjyHT/YHo64mKZFN0WuhfWf4SfA7Pol+lmoDJ
 E+1fEOxWjGCcKebZpqXNp65HzEYXjPOCAYAxP2nSCWuuCc0LAZcCn5QvdlfuW+jM+jYUbq99SHZ
 imHVm7v3bZryKw==
X-Received: by 2002:a05:600c:3541:b0:490:6e12:542c with SMTP id
 5b1f17b1804b1-4906e125469mr91516225e9.23.1779797984141; 
 Tue, 26 May 2026 05:19:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49049093822sm132562505e9.0.2026.05.26.05.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 05:19:43 -0700 (PDT)
From: "its_Giaan (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 26 May 2026 12:19:40 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
X-Gerrit-Change-Number: 1521
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1521?usp=email>
X-Gerrit-Commit: 0356b37647206fa103cd845e666a8c1f80906477
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@gerrit.openvpn.net>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcwOTg2MTE4MDAwLkk4YjBkMWNhZDcwNjI4NTZhYmNjNDBjNGUxNmVjOTNiNDUyOTViYmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46afd1b36e0eb0936c7b7c47300c9d0d171cdc0b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wRqlI-00068b-3S
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for user
 defined network namespace
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
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4050621623289867407=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4050621623289867407==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TEh38X8qads="; charset=UTF-8

--TEh38X8qads=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos=2E=


Hello flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Pl=
ease visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail
=

to look at the new patch set (#11)=2E

The following approvals got outdate=
d and were removed:
Code-Review+2 by flichtenheld

The change is no longer =
submittable: Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E=



Change subject: Add support for user defined network namespace
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add support for user d=
efined network namespace

Introduce the --netns option to allow interface c=
reation
into a user-defined network namespace=2E
This allows the VPN data p=
lane to be isolated from the main
OpenVPN process namespace=2E

The current=
 netlink library integration supports interface creation
and deletion in a =
target namespace=2E However, subsequent configuration
operations (e=2Eg=2E =
address or mtu set) are executed in the caller's
namespace, as they rely on=
 the default netlink socket context=2E
As a result, interface-related confi=
guration performed after creation
may be applied in the wrong namespace=2E
=
Introduce helper functions to temporarily switch the process to the
request=
ed network namespace using setns(2), execute the required
netlink operation=
s, and then restore the original namespace=2E
The namespace switch is tempo=
rary and scoped to each netlink
operation=2E Once the operation completes, =
the original namespace
is restored to preserve the process execution contex=
t=2E

Note: This feature is Linux-only and depends on setns(2)=2E
It is not=
 compatible (yet) with Data Channel Offload (DCO)=2E

Change-Id: I8b0d1cad7=
062856abcc40c4e16ec93b45295bbd3
Signed-off-by: Gianmarco De Gregori <gianma=
rco@mandelbit=2Ecom>
---
M doc/man-sections/vpn-network-options=2Erst
M src=
/openvpn/dco=2Ec
M src/openvpn/networking=2Eh
M src/openvpn/networking_sitn=
l=2Ec
M src/openvpn/networking_sitnl=2Eh
M src/openvpn/options=2Ec
M src/op=
envpn/options=2Eh
M src/openvpn/tun=2Ec
8 files changed, 605 insertions(+),=
 83 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/21/1521/11

diff --git a/doc/man-sections/vpn-network-options=2E=
rst b/doc/man-sections/vpn-network-options=2Erst
index 33ebedb=2E=2E181c990=
 100644
--- a/doc/man-sections/vpn-network-options=2Erst
+++ b/doc/man-sect=
ions/vpn-network-options=2Erst
@@ -304,6 +304,12 @@
   Specify the link lay=
er address, more commonly known as the MAC address=2E
   Only applied to TA=
P devices=2E
 
+--netns name
+  Specify the network namespace in which the =
tunnel interface will be created=2E
+  The namespace must already exist=2E
=
+
+  (Supported on Linux only, on other platforms this is a no-op)=2E
+
 --=
persist-tun
   Don't close and reopen TUN/TAP device or run up/down scripts=
 across
   :code:`SIGUSR1` or ``--ping-restart`` restarts=2E
diff --git a/s=
rc/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f5b7081=2E=2Efbefcb6 100644
=
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -389,6 +389,12 @@
  =
               ret);
         }
     }
+
+    if (o->netns)
+    {
+       =
 msg(msglevel, "Note: --netns not supported by DCO, disabling data channel =
offload=2E");
+        return false;
+    }
 #endif /* if defined(_WIN32) *=
/
 
 #if defined(HAVE_LIBCAPNG)
diff --git a/src/openvpn/networking=2Eh b/s=
rc/openvpn/networking=2Eh
index bce0c19=2E=2Efab6bbf 100644
--- a/src/openv=
pn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -39,10 +39,10 @@
 typ=
edef void *openvpn_net_iface_t;
 #endif /* ifdef ENABLE_SITNL */
 
-/* Only=
 the iproute2 backend implements these functions,
+/* Only the iproute2 and=
 sitnl backend implements these functions,
  * the rest can rely on these s=
tubs
  */
-#if !defined(ENABLE_IPROUTE)
+#if !defined(ENABLE_IPROUTE) && !d=
efined(ENABLE_SITNL) || defined(TARGET_ANDROID)
 static inline int
 net_ctx=
_init(struct context *c, openvpn_net_ctx_t *ctx)
 {
@@ -63,7 +63,7 @@
 {
  =
   (void)ctx;
 }
-#endif /* !defined(ENABLE_IPROUTE) */
+#endif /* !defined=
(ENABLE_IPROUTE) && !defined(ENABLE_SITNL) || defined(TARGET_ANDROID) */
 
=
 #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)
 
diff --git a/src/op=
envpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index b3f8e2b=
=2E=2Eb60131f 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openv=
pn/networking_sitnl=2Ec
@@ -33,14 +33,17 @@
 #include "networking=2Eh"
 #in=
clude "proto=2Eh"
 #include "route=2Eh"
+#include "openvpn=2Eh"
 
 #include=
 <errno=2Eh>
 #include <string=2Eh>
 #include <unistd=2Eh>
+#include <sched=
=2Eh>
 #include <sys/types=2Eh>
 #include <sys/socket=2Eh>
 #include <linux=
/netlink=2Eh>
 #include <linux/rtnetlink=2Eh>
+#include <linux/net_namespac=
e=2Eh>
 
 #define SNDBUF_SIZE (1024 * 2)
 #define RCVBUF_SIZE (1024 * 4)
@@=
 -65,6 +68,12 @@
         _nest->rta_len =3D (unsigned short)((void *)sitnl=
_nlmsg_tail(_msg) - (void *)_nest); \
     }
 
+#define SITNL_NETNS_RTA(r) =
\
+    ((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct rtgenms=
g))))
+
+#define NETNS_RUN_DIR  "/run/netns"
+#define NETNS_ORIG_DIR "/proc=
/self/ns/net"
+
 /* This function was originally implemented as a macro, bu=
t compiling with
  * gcc and -O3 was getting confused about the math and th=
us raising
  * security warnings on subsequent memcpy() calls=2E
@@ -121,6 =
+130,16 @@
     char buf[256];
 };
 
+/**
+ * Network namespace NSID reques=
t message
+ */
+struct sitnl_nsid_req
+{
+    struct nlmsghdr n;
+    struc=
t rtgenmsg g;
+    char buf[256];
+};
+
 typedef int (*sitnl_parse_reply_cb=
)(struct nlmsghdr *msg, void *arg);
 
 /**
@@ -156,6 +175,105 @@
     retur=
n 0;
 }
 
+#if defined(TARGET_LINUX) && defined(ENABLE_SITNL)
+
+static int=
 netns_id_from_name_sitnl(const char *name);
+static int set_netns_id_from_=
name_sitnl(const char *name);
+
+int
+net_ctx_init(struct context *c, openv=
pn_net_ctx_t *ctx)
+{
+    struct stat st;
+    char path[PATH_MAX];
+
+   =
 ctx->netns =3D NULL;
+
+    if (c && c->options=2Enetns)
+    {
+        s=
nprintf(path, sizeof(path), "%s/%s", NETNS_RUN_DIR, c->options=2Enetns);
+
=
+        if (stat(path, &st) !=3D 0)
+        {
+            msg(M_ERR, "%s=
: Network namespace %s does not exist", __func__, path);
+        }
+
+    =
    ctx->netns =3D c->options=2Enetns;
+    }
+
+    ctx->gc =3D gc_new();
=
+    return 0;
+}
+
+void
+net_ctx_reset(openvpn_net_ctx_t *ctx)
+{
+    gc=
_reset(&ctx->gc);
+}
+
+void
+net_ctx_free(openvpn_net_ctx_t *ctx)
+{
+    =
gc_free(&ctx->gc);
+}
+
+int
+netns_switch(openvpn_net_ctx_t *ctx)
+{
+    =
char net_path[PATH_MAX];
+    int orig_fd =3D -1, netns_fd;
+    const char=
 *netns =3D ctx ? ctx->netns : NULL;
+
+    if (!netns)
+    {
+        ret=
urn -1;
+    }
+
+    /* Save current netns descriptor */
+    orig_fd =3D =
open(NETNS_ORIG_DIR, O_RDONLY | O_CLOEXEC);
+    if (orig_fd < 0)
+    {
+ =
       msg(M_WARN | M_ERRNO, "%s: Cannot open original network namespace", =
__func__);
+        return -1;
+    }
+
+    snprintf(net_path, sizeof(net_=
path), "%s/%s", NETNS_RUN_DIR, netns);
+    netns_fd =3D open(net_path, O_R=
DONLY | O_CLOEXEC);
+    if (netns_fd < 0)
+    {
+        msg(M_WARN | M_E=
RRNO, "%s: Cannot open network namespace \"%s\"", __func__, netns);
+      =
  close(orig_fd);
+        return -1;
+    }
+
+    if (setns(netns_fd, CLO=
NE_NEWNET) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: setting the netw=
ork namespace \"%s\" failed", __func__, netns);
+        close(netns_fd);
+=
        close(orig_fd);
+        return -1;
+    }
+
+    close(netns_fd);
=
+    return orig_fd;
+}
+
+void
+netns_restore(int orig_fd)
+{
+    if (ori=
g_fd < 0)
+    {
+        return;
+    }
+
+    if (setns(orig_fd, CLONE_NE=
WNET) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: Cannot restore origin=
al network namespace", __func__);
+    }
+
+    close(orig_fd);
+}
+#endif =
/* defined (TARGET_LINUX) && defined (ENABLE_SITNL) */
+
 /**
  * Open RTNL=
 socket
  */
@@ -445,6 +563,285 @@
     return ret;
 }
 
+#ifdef ENABLE_SIT=
NL
+/**
+ * Netlink callback to extract the interface index from a RTM_NEWL=
INK message=2E
+ *
+ * This function is used as a Netlink response handler=
=2E It inspects incoming
+ * Netlink messages and, when a RTM_NEWLINK messa=
ge is received, copies the
+ * contained `struct ifinfomsg` into the caller=
-provided result structure=2E
+ *
+ * @param n    Netlink message header re=
ceived from the kernel=2E
+ * @param arg  Pointer to a `struct sitnl_link_r=
eq` used to store the result=2E
+ *
+ * @return 0 to stop Netlink message p=
rocessing once the interface is found,
+ *         1 to continue processing=
 other messages=2E
+ */
+static int
+sitnl_link_get_ifindex(struct nlmsghdr=
 *n, void *arg)
+{
+    struct sitnl_link_req *res =3D arg;
+    struct ifi=
nfomsg *ifi;
+
+    if (n->nlmsg_type !=3D RTM_NEWLINK)
+    {
+        ret=
urn 1;
+    }
+
+    ifi =3D NLMSG_DATA(n);
+    res->i =3D *ifi;
+
+    re=
turn 0;
+}
+
+/**
+ * Retrieve the interface index of a network device in a=
 specific network namespace=2E
+ *
+ * Sends an RTM_GETLINK Netlink request=
 targeting the given network namespace ID
+ * and interface name, and extra=
cts the resulting interface index from the kernel
+ * response=2E
+ *
+ * O=
n failure, this function returns 0, matching the behavior of
+ * `if_nameto=
index()`=2E
+ *
+ * @param ifname   Name of the network interface=2E
+ * @p=
aram netnsid  Target network namespace ID=2E
+ *
+ * @return Interface inde=
x on success, or 0 on error=2E
+ */
+static int
+get_ifindex_in_netns(const=
 char *ifname, int netnsid)
+{
+    struct sitnl_link_req req;
+    struct =
sitnl_link_req res;
+    int ret =3D -1, ifindex =3D 0;
+
+    CLEAR(req);
=
+    CLEAR(res);
+
+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei=
));
+    req=2En=2Enlmsg_type =3D RTM_GETLINK;
+    req=2En=2Enlmsg_flags =
=3D NLM_F_REQUEST;
+
+    SITNL_ADDATTR(&req=2En, sizeof(req), IFLA_TARGET_=
NETNSID, &netnsid, sizeof(int));
+    SITNL_ADDATTR(&req=2En, sizeof(req), =
IFLA_IFNAME, ifname, strlen(ifname) + 1);
+
+    ret =3D sitnl_send(&req=2E=
n, 0, 0, sitnl_link_get_ifindex, &res);
+
+    if (ret < 0)
+    {
+       =
 return ret;
+    }
+
+    ifindex =3D res=2Ei=2Eifi_index;
+
+err:
+    re=
turn ifindex;
+}
+
+static void
+sitnl_parse_rtattr_flags(struct rtattr *tb=
[], size_t max, struct rtattr *rta, size_t len,
+                         u=
nsigned short flags)
+{
+    unsigned short type;
+
+    memset(tb, 0, size=
of(struct rtattr *) * (max + 1));
+
+    while (RTA_OK(rta, len))
+    {
+ =
       type =3D rta->rta_type & ~flags;
+
+        if ((type <=3D max) && (=
!tb[type]))
+        {
+            tb[type] =3D rta;
+        }
+
+       =
 rta =3D RTA_NEXT(rta, len);
+    }
+
+    if (len)
+    {
+        msg(D_R=
OUTE, "%s: %zu bytes not parsed! (rta_len=3D%u)", __func__, len, rta->rta_l=
en);
+    }
+}
+
+static void
+sitnl_parse_rtattr(struct rtattr *tb[], size=
_t max, struct rtattr *rta, size_t len)
+{
+    sitnl_parse_rtattr_flags(tb=
, max, rta, len, 0);
+}
+
+#define sitnl_parse_rtattr_nested(tb, max, rta) =
\
+    (sitnl_parse_rtattr_flags(tb, max, RTA_DATA(rta), RTA_PAYLOAD(rta), =
NLA_F_NESTED))
+
+/**
+ * Netlink callback to extract and store a network n=
amespace ID (NSID)=2E
+ *
+ * This function processes Netlink responses to =
RTM_GETNSID requests=2E
+ * If a NETNSA_NSID attribute is present, its valu=
e is copied into the
+ * caller-provided storage=2E
+ *
+ * If a Netlink er=
ror message is received, the contained error code is
+ * returned directly=
=2E
+ *
+ * @param n    Netlink message header received from the kernel=2E
=
+ * @param arg  Pointer to an integer where the NSID will be stored=2E
+ *
=
+ * @return 0 on success, a negative error code on failure=2E
+ */
+static =
int
+sitnl_nsid_save(struct nlmsghdr *n, void *arg)
+{
+    int *nsid =3D a=
rg;
+    struct rtgenmsg *g =3D NLMSG_DATA(n);
+    struct rtattr *tb[NETNS=
A_MAX + 1];
+
+    if (n->nlmsg_type =3D=3D NLMSG_ERROR)
+    {
+        st=
ruct nlmsgerr *err =3D NLMSG_DATA(n);
+        return err->error;
+    }
+
=
+    sitnl_parse_rtattr(tb, NETNSA_MAX, SITNL_NETNS_RTA(g), NLMSG_PAYLOAD(n=
, sizeof(*g)));
+
+    if (!tb[NETNSA_NSID])
+    {
+        return -ENOENT=
;
+    }
+
+    memcpy(nsid, RTA_DATA(tb[NETNSA_NSID]), sizeof(*nsid));
+  =
  return 0;
+}
+
+/**
+ * Retrieve the network namespace ID (NSID) associat=
ed with a namespace name=2E
+ *
+ * This function opens the network namespa=
ce identified by the given path
+ * and sends an RTM_GETNSID Netlink reques=
t to retrieve its assigned NSID=2E
+ *
+ * @param name  Name of the network=
 namespace=2E
+ *
+ * @return The network namespace ID on success, or a neg=
ative value on failure=2E
+ */
+static int
+netns_id_from_name_sitnl(const =
char *name)
+{
+    struct sitnl_nsid_req req;
+
+    int netnsid =3D -1;
+=
    CLEAR(req);
+
+    int netns_fd =3D open(name, O_RDONLY);
+    if (netn=
s_fd < 0)
+    {
+        goto err;
+    }
+
+    req=2En=2Enlmsg_len =3D N=
LMSG_LENGTH(sizeof(req=2Eg));
+    req=2En=2Enlmsg_type =3D RTM_GETNSID;
+ =
   req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
+    req=2Eg=2Ertgen_family =3D=
 AF_UNSPEC;
+
+    SITNL_ADDATTR(&req=2En, sizeof(req), NETNSA_FD, &netns_f=
d, sizeof(int));
+
+    sitnl_send(&req=2En, 0, 0, sitnl_nsid_save, &netnsi=
d);
+
+err:
+    if (netns_fd >=3D 0)
+    {
+        close(netns_fd);
+   =
 }
+    return netnsid;
+}
+
+/**
+ * Assign a network namespace ID (NSID) =
to a namespace=2E
+ *
+ * This function sends an RTM_NEWNSID Netlink reques=
t to associate a
+ * NSID with the network namespace identified by the give=
n path=2E
+ *
+ * @param name  Name of the network namespace=2E
+ *
+ * @re=
turn 0 on success, or a negative error code on failure=2E
+ */
+static int
=
+set_netns_id_from_name_sitnl(const char *name)
+{
+    struct sitnl_nsid_r=
eq req;
+
+    int ret =3D -1, netnsid =3D -1;
+    CLEAR(req);
+
+    int =
netns_fd =3D open(name, O_RDONLY);
+    if (netns_fd < 0)
+    {
+        g=
oto err;
+    }
+
+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Eg)=
);
+    req=2En=2Enlmsg_type =3D RTM_NEWNSID;
+    req=2En=2Enlmsg_flags =
=3D NLM_F_REQUEST;
+    req=2Eg=2Ertgen_family =3D AF_UNSPEC;
+
+    SITNL_=
ADDATTR(&req=2En, sizeof(req), NETNSA_FD, &netns_fd, sizeof(int));
+    SIT=
NL_ADDATTR(&req=2En, sizeof(req), NETNSA_NSID, &netnsid, sizeof(int));
+
+ =
   ret =3D sitnl_send(&req=2En, 0, 0, NULL, NULL);
+
+err:
+    if (netns_f=
d >=3D 0)
+    {
+        close(netns_fd);
+    }
+    return ret;
+}
+
+in=
t
+get_or_create_netnsid_sitnl(const char *name)
+{
+    char net_path[PATH=
_MAX];
+    int netnsid;
+    snprintf(net_path, sizeof(net_path), "%s/%s",=
 NETNS_RUN_DIR, name);
+
+    /* First get */
+    netnsid =3D netns_id_fro=
m_name_sitnl(net_path);
+    if (netnsid >=3D 0)
+    {
+        return net=
nsid;
+    }
+
+    /* No netnsid yet? Try to assign one */
+    netnsid =
=3D set_netns_id_from_name_sitnl(net_path);
+    if (netnsid < 0)
+    {
+ =
       return -1;
+    }
+
+    /* Second get */
+    netnsid =3D netns_id_=
from_name_sitnl(net_path);
+    if (netnsid >=3D 0)
+    {
+        return =
netnsid;
+    }
+
+    return -1;
+}
+
+int
+openvpn_if_nametoindex(const c=
har *ifname, openvpn_net_ctx_t *ctx)
+{
+    const char *netns =3D ctx ? ct=
x->netns : NULL;
+    int netnsid =3D get_or_create_netnsid_sitnl(netns);
+=

+    if (netnsid < 0)
+    {
+        return if_nametoindex(ifname);
+    =
}
+
+    return get_ifindex_in_netns(ifname, netnsid);
+}
+#endif /* ifdef =
ENABLE_SITNL */
+
 typedef struct
 {
     size_t addr_size;
@@ -652,7 +1049=
,7 @@
 net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
=
     struct sitnl_link_req req;
-    int ifindex;
+    int ifindex, orig =
=3D -1;
 
     CLEAR(req);
 
@@ -662,13 +1059,15 @@
         return -EINVAL=
;
     }
 
-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn=
_if_nametoindex(iface, ctx);
     if (ifindex =3D=3D 0)
     {
-        msg=
(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, iface, strerr=
or(errno));
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex fo=
r %s", __func__, iface);
         return -ENOENT;
     }
 
+    orig =3D ne=
tns_switch(ctx);
+
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei=
));
     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
     req=2En=2Enlmsg_type=
 =3D RTM_NEWLINK;
@@ -687,24 +1086,30 @@
 
     msg(M_INFO, "%s: set %s %s"=
, __func__, iface, up ? "up" : "down");
 
-    return sitnl_send(&req=2En, =
0, 0, NULL, NULL);
+    int ret =3D sitnl_send(&req=2En, 0, 0, NULL, NULL);=

+
+    netns_restore(orig);
+
+    return ret;
 }
 
 int
 net_iface_mtu_se=
t(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct s=
itnl_link_req req;
-    int ifindex, ret =3D -1;
+    int ifindex, orig =3D=
 -1, ret =3D -1;
 
     CLEAR(req);
 
-    ifindex =3D if_nametoindex(iface=
);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
     if (ifindex =
=3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifind=
ex for %s", __func__, iface);
         return -1;
     }
 
+    orig =3D ne=
tns_switch(ctx);
+
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei=
));
     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
     req=2En=2Enlmsg_type=
 =3D RTM_NEWLINK;
@@ -717,7 +1122,9 @@
     msg(M_INFO, "%s: mtu %u for %s"=
, __func__, mtu, iface);
 
     ret =3D sitnl_send(&req=2En, 0, 0, NULL, NU=
LL);
+
 err:
+    netns_restore(orig);
     return ret;
 }
 
@@ -725,17 +11=
32,19 @@
 net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t=
 *iface, uint8_t *addr)
 {
     struct sitnl_link_req req;
-    int ifindex=
, ret =3D -1;
+    int ifindex, orig =3D -1, ret =3D -1;
 
     CLEAR(req);=

 
-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_name=
toindex(iface, ctx);
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN =
| M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
       =
  return -1;
     }
 
+    orig =3D netns_switch(ctx);
+
     req=2En=2Enlm=
sg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
     req=2En=2Enlmsg_flags =3D NL=
M_F_REQUEST;
     req=2En=2Enlmsg_type =3D RTM_NEWLINK;
@@ -748,17 +1157,19=
 @@
     msg(M_INFO, "%s: lladdr " MAC_FMT " for %s", __func__, MAC_PRINT_A=
RG(addr), iface);
 
     ret =3D sitnl_send(&req=2En, 0, 0, NULL, NULL);
+
=
 err:
+    netns_restore(orig);
     return ret;
 }
 
 static int
-sitnl_ad=
dr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family,
+s=
itnl_addr_set(openvpn_net_ctx_t *ctx, uint16_t cmd, uint16_t flags, int ifi=
ndex, sa_family_t af_family,
                const inet_address_t *local, c=
onst inet_address_t *remote, int prefixlen)
 {
     struct sitnl_addr_req r=
eq;
     uint32_t size;
-    int ret =3D -EINVAL;
+    int ret =3D -EINVAL,=
 orig =3D -1;
 
     CLEAR(req);
 
@@ -810,17 +1221,22 @@
         SITNL_AD=
DATTR(&req=2En, sizeof(req), IFA_BROADCAST, &broadcast, size);
     }
 
+  =
  orig =3D netns_switch(ctx);
+
     ret =3D sitnl_send(&req=2En, 0, 0, NUL=
L, NULL);
+
     if (ret =3D=3D -EEXIST)
     {
         ret =3D 0;
     }
=
+
 err:
+    netns_restore(orig);
     return ret;
 }
 
 static int
-sitnl_=
addr_ptp_add(sa_family_t af_family, const char *iface, const inet_address_t=
 *local,
+sitnl_addr_ptp_add(openvpn_net_ctx_t *ctx, sa_family_t af_family,=
 const char *iface, const inet_address_t *local,
                    const =
inet_address_t *remote)
 {
     int ifindex;
@@ -841,19 +1257,19 @@
       =
  return -EINVAL;
     }
 
-    ifindex =3D if_nametoindex(iface);
+    ifi=
ndex =3D openvpn_if_nametoindex(iface, ctx);
     if (ifindex =3D=3D 0)
   =
  {
-        msg(M_WARN, "%s: cannot get ifindex for %s: %s", __func__, np(=
iface), strerror(errno));
+        msg(M_WARN | M_ERRNO, "%s: cannot get if=
index for %s", __func__, np(iface));
         return -ENOENT;
     }
 
-   =
 return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, =
af_family, local,
+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE=
 | NLM_F_REPLACE, ifindex, af_family, local,
                           rem=
ote, 0);
 }
 
 static int
-sitnl_addr_ptp_del(sa_family_t af_family, const =
char *iface, const inet_address_t *local)
+sitnl_addr_ptp_del(openvpn_net_c=
tx_t *ctx, sa_family_t af_family, const char *iface, const inet_address_t *=
local)
 {
     int ifindex;
 
@@ -873,23 +1289,23 @@
         return -EINVA=
L;
     }
 
-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvp=
n_if_nametoindex(iface, ctx);
     if (ifindex =3D=3D 0)
     {
         ms=
g(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, iface);
    =
     return -ENOENT;
     }
 
-    return sitnl_addr_set(RTM_DELADDR, 0, if=
index, af_family, local, NULL, 0);
+    return sitnl_addr_set(ctx, RTM_DELA=
DDR, 0, ifindex, af_family, local, NULL, 0);
 }
 
 static int
-sitnl_route_=
set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const=
 void *dst,
+sitnl_route_set(openvpn_net_ctx_t *ctx, uint16_t cmd, uint16_t=
 flags, int ifindex, sa_family_t af_family, const void *dst,
              =
   int prefixlen, const void *gw, enum rt_class_t table, int metric,
      =
           enum rt_scope_t scope, unsigned char protocol, unsigned char typ=
e)
 {
     struct sitnl_route_req req;
-    int ret =3D -1, size;
+    int =
ret =3D -1, size, orig =3D -1;
 
     CLEAR(req);
 
@@ -948,14 +1364,17 @@
=
     {
         SITNL_ADDATTR(&req=2En, sizeof(req), RTA_PRIORITY, &metric,=
 4);
     }
+    orig =3D netns_switch(ctx);
 
     ret =3D sitnl_send(&req=
=2En, 0, 0, NULL, NULL);
+
 err:
+    netns_restore(orig);
     return ret;=

 }
 
 static int
-sitnl_addr_add(sa_family_t af_family, const char *iface,=
 const inet_address_t *addr, int prefixlen)
+sitnl_addr_add(openvpn_net_ctx=
_t *ctx, sa_family_t af_family, const char *iface, const inet_address_t *ad=
dr, int prefixlen)
 {
     int ifindex;
 
@@ -975,19 +1394,19 @@
         r=
eturn -EINVAL;
     }
 
-    ifindex =3D if_nametoindex(iface);
+    ifinde=
x =3D openvpn_if_nametoindex(iface, ctx);
     if (ifindex =3D=3D 0)
     {=

         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fu=
nc__, iface);
         return -ENOENT;
     }
 
-    return sitnl_addr_set(=
RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,
=
+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, =
ifindex, af_family, addr, NULL,
                           prefixlen);
 }
 =

 static int
-sitnl_addr_del(sa_family_t af_family, const char *iface, inet=
_address_t *addr, int prefixlen)
+sitnl_addr_del(openvpn_net_ctx_t *ctx, sa=
_family_t af_family, const char *iface, inet_address_t *addr, int prefixlen=
)
 {
     int ifindex;
 
@@ -1007,14 +1426,14 @@
         return -EINVAL;
 =
    }
 
-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if=
_nametoindex(iface, ctx);
     if (ifindex =3D=3D 0)
     {
         msg(M_=
WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
  =
       return -ENOENT;
     }
 
-    return sitnl_addr_set(RTM_DELADDR, 0, =
ifindex, af_family, addr, NULL, prefixlen);
+    return sitnl_addr_set(ctx,=
 RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);
 }
 
 int
@@ -=
1033,7 +1452,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(=
AF_INET, &addr_v4=2Eipv4, buf, sizeof(buf)),
         prefixlen, iface);
 
=
-    return sitnl_addr_add(AF_INET, iface, &addr_v4, prefixlen);
+    retur=
n sitnl_addr_add(ctx, AF_INET, iface, &addr_v4, prefixlen);
 }
 
 int
@@ -1=
053,7 +1472,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(A=
F_INET6, &addr_v6=2Eipv6, buf, sizeof(buf)),
         prefixlen, iface);
 
=
-    return sitnl_addr_add(AF_INET6, iface, &addr_v6, prefixlen);
+    retu=
rn sitnl_addr_add(ctx, AF_INET6, iface, &addr_v6, prefixlen);
 }
 
 int
@@ =
-1072,7 +1491,7 @@
     msg(M_INFO, "%s: %s dev %s", __func__, inet_ntop(AF=
_INET, &addr_v4=2Eipv4, buf, sizeof(buf)),
         iface);
 
-    return s=
itnl_addr_del(AF_INET, iface, &addr_v4, prefixlen);
+    return sitnl_addr_=
del(ctx, AF_INET, iface, &addr_v4, prefixlen);
 }
 
 int
@@ -1092,7 +1511,7=
 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET6, &add=
r_v6=2Eipv6, buf, sizeof(buf)),
         prefixlen, iface);
 
-    return s=
itnl_addr_del(AF_INET6, iface, &addr_v6, prefixlen);
+    return sitnl_addr=
_del(ctx, AF_INET6, iface, &addr_v6, prefixlen);
 }
 
 int
@@ -1120,7 +1539=
,7 @@
         inet_ntop(AF_INET, &local_v4=2Eipv4, buf1, sizeof(buf1)),
  =
       inet_ntop(AF_INET, &remote_v4=2Eipv4, buf2, sizeof(buf2)), iface);
 =

-    return sitnl_addr_ptp_add(AF_INET, iface, &local_v4, &remote_v4);
+  =
  return sitnl_addr_ptp_add(ctx, AF_INET, iface, &local_v4, &remote_v4);
 }=

 
 int
@@ -1141,11 +1560,11 @@
     msg(M_INFO, "%s: %s dev %s", __func__,=
 inet_ntop(AF_INET, &local_v4=2Eipv4, buf, sizeof(buf)),
         iface);
 =

-    return sitnl_addr_ptp_del(AF_INET, iface, &local_v4);
+    return sit=
nl_addr_ptp_del(ctx, AF_INET, iface, &local_v4);
 }
 
 static int
-sitnl_ro=
ute_add(const char *iface, sa_family_t af_family, const void *dst, int pref=
ixlen,
+sitnl_route_add(openvpn_net_ctx_t *ctx, const char *iface, sa_famil=
y_t af_family, const void *dst, int prefixlen,
                 const void =
*gw, uint32_t table, int metric)
 {
     enum rt_scope_t scope =3D RT_SCOPE=
_UNIVERSE;
@@ -1153,7 +1572,7 @@
 
     if (iface)
     {
-        ifindex =
=3D if_nametoindex(iface);
+        ifindex =3D openvpn_if_nametoindex(ifac=
e, ctx);
         if (ifindex =3D=3D 0)
         {
             msg(M_WARN =
| M_ERRNO, "%s: rtnl: can't get ifindex for %s", __func__, iface);
@@ -1171=
,7 +1590,7 @@
         scope =3D RT_SCOPE_LINK;
     }
 
-    return sitnl_=
route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, g=
w,
+    return sitnl_route_set(ctx, RTM_NEWROUTE, NLM_F_CREATE, ifindex, af=
_family, dst, prefixlen, gw,
                            table, metric, sco=
pe, RTPROT_BOOT, RTN_UNICAST);
 }
 
@@ -1200,7 +1619,7 @@
         inet_nto=
p(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
         inet_nto=
p(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
- =
   return sitnl_route_add(iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table=
, metric);
+    return sitnl_route_add(ctx, iface, AF_INET, dst_ptr, prefix=
len, gw_ptr, table, metric);
 }
 
 int
@@ -1226,18 +1645,18 @@
         ine=
t_ntop(AF_INET6, &dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
    =
     inet_ntop(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface),=
 table, metric);
 
-    return sitnl_route_add(iface, AF_INET6, dst, prefix=
len, gw, table, metric);
+    return sitnl_route_add(ctx, iface, AF_INET6, =
dst, prefixlen, gw, table, metric);
 }
 
 static int
-sitnl_route_del(const=
 char *iface, sa_family_t af_family, inet_address_t *dst, int prefixlen,
+s=
itnl_route_del(openvpn_net_ctx_t *ctx, const char *iface, sa_family_t af_fa=
mily, inet_address_t *dst, int prefixlen,
                 inet_address_t *=
gw, uint32_t table, int metric)
 {
     int ifindex =3D 0;
 
     if (iface=
)
     {
-        ifindex =3D if_nametoindex(iface);
+        ifindex =3D o=
penvpn_if_nametoindex(iface, ctx);
         if (ifindex =3D=3D 0)
         =
{
             msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", =
__func__, iface);
@@ -1250,7 +1669,7 @@
         table =3D RT_TABLE_MAIN;
 =
    }
 
-    return sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, ds=
t, prefixlen, gw, table, metric,
+    return sitnl_route_set(ctx, RTM_DELRO=
UTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,
            =
                RT_SCOPE_NOWHERE, 0, 0);
 }
 
@@ -1277,7 +1696,7 @@
       =
  inet_ntop(AF_INET, &dst_v4=2Eipv4, dst_str, sizeof(dst_str)), prefixlen,
=
         inet_ntop(AF_INET, &gw_v4=2Eipv4, gw_str, sizeof(gw_str)), np(ifac=
e), table, metric);
 
-    return sitnl_route_del(iface, AF_INET, &dst_v4, =
prefixlen, &gw_v4, table, metric);
+    return sitnl_route_del(ctx, iface, =
AF_INET, &dst_v4, prefixlen, &gw_v4, table, metric);
 }
 
 int
@@ -1303,7 +=
1722,7 @@
         inet_ntop(AF_INET6, &dst_v6=2Eipv6, dst_str, sizeof(dst_=
str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeo=
f(gw_str)), np(iface), table, metric);
 
-    return sitnl_route_del(iface,=
 AF_INET6, &dst_v6, prefixlen, &gw_v6, table, metric);
+    return sitnl_ro=
ute_del(ctx, iface, AF_INET6, &dst_v6, prefixlen, &gw_v6, table, metric);
 =
}
 
 
@@ -1347,45 +1766,11 @@
     msg(D_ROUTE, "%s: add %s type %s", __fun=
c__, iface, type);
 
     ret =3D sitnl_send(&req=2En, 0, 0, NULL, NULL);
+=

 err:
     return ret;
 }
 
-static void
-sitnl_parse_rtattr_flags(struct =
rtattr *tb[], size_t max, struct rtattr *rta, size_t len,
-                =
         unsigned short flags)
-{
-    unsigned short type;
-
-    memset(t=
b, 0, sizeof(struct rtattr *) * (max + 1));
-
-    while (RTA_OK(rta, len))=

-    {
-        type =3D rta->rta_type & ~flags;
-
-        if ((type <=3D=
 max) && (!tb[type]))
-        {
-            tb[type] =3D rta;
-        }
=
-
-        rta =3D RTA_NEXT(rta, len);
-    }
-
-    if (len)
-    {
-     =
   msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_len=3D%u)", __func__, len, =
rta->rta_len);
-    }
-}
-
-static void
-sitnl_parse_rtattr(struct rtattr *=
tb[], size_t max, struct rtattr *rta, size_t len)
-{
-    sitnl_parse_rtatt=
r_flags(tb, max, rta, len, 0);
-}
-
-#define sitnl_parse_rtattr_nested(tb, =
max, rta) \
-    (sitnl_parse_rtattr_flags(tb, max, RTA_DATA(rta), RTA_PAYL=
OAD(rta), NLA_F_NESTED))
-
 static int
 sitnl_type_save(struct nlmsghdr *n,=
 void *arg)
 {
@@ -1416,13 +1801,16 @@
 net_iface_type(openvpn_net_ctx_t *c=
tx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     struct sitnl_=
link_req req =3D {};
-    int ifindex =3D if_nametoindex(iface);
+    int i=
findex =3D openvpn_if_nametoindex(iface, ctx);
+    int orig =3D -1;
 
    =
 if (!ifindex)
     {
         return -errno;
     }
 
+    orig =3D netns_=
switch(ctx);
+
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
=
     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
     req=2En=2Enlmsg_type =3D=
 RTM_GETLINK;
@@ -1435,26 +1823,32 @@
     int ret =3D sitnl_send(&req=2En,=
 0, 0, sitnl_type_save, type);
     if (ret < 0)
     {
+        netns_rest=
ore(orig);
         msg(D_ROUTE, "%s: cannot retrieve iface %s: %s (%d)", _=
_func__, iface, strerror(-ret), ret);
         return ret;
     }
 
     ms=
g(D_ROUTE, "%s: type of %s: %s", __func__, iface, type);
 
+    netns_resto=
re(orig);
+
     return 0;
 }
 
 int
 net_iface_del(openvpn_net_ctx_t *ctx,=
 const char *iface)
 {
+    int ret =3D -1, orig =3D -1;
     struct sitnl_=
link_req req =3D {};
-    int ifindex =3D if_nametoindex(iface);
+    int i=
findex =3D openvpn_if_nametoindex(iface, ctx);
 
     if (!ifindex)
     {
=
         return -errno;
     }
 
+    orig =3D netns_switch(ctx);
+
     re=
q=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
     req=2En=2Enlmsg_f=
lags =3D NLM_F_REQUEST;
     req=2En=2Enlmsg_type =3D RTM_DELLINK;
@@ -1464=
,7 +1858,11 @@
 
     msg(D_ROUTE, "%s: delete %s", __func__, iface);
 
-  =
  return sitnl_send(&req=2En, 0, 0, NULL, NULL);
+    ret =3D sitnl_send(&r=
eq=2En, 0, 0, NULL, NULL);
+
+    netns_restore(orig);
+
+    return ret;
 =
}
 
 #endif /* !ENABLE_SITNL */
diff --git a/src/openvpn/networking_sitnl=
=2Eh b/src/openvpn/networking_sitnl=2Eh
index 481cc36=2E=2E7e723fe 100644
-=
-- a/src/openvpn/networking_sitnl=2Eh
+++ b/src/openvpn/networking_sitnl=2E=
h
@@ -21,7 +21,97 @@
 #ifndef NETWORKING_SITNL_H_
 #define NETWORKING_SITNL=
_H_
 
+#include "env_set=2Eh"
+
 typedef char openvpn_net_iface_t;
-typedef=
 void *openvpn_net_ctx_t;
+
+struct openvpn_net_ctx
+{
+    const char *net=
ns;
+    struct gc_arena gc;
+};
+
+typedef struct openvpn_net_ctx openvpn_=
net_ctx_t;
+
+/**
+ * @brief Switch the current thread to the network names=
pace specified
+ *        in the given OpenVPN network context=2E
+ *
+ * T=
his function changes the calling thread's network namespace to the one
+ * =
identified by ctx->netns=2E The current (original) network namespace file
+=
 * descriptor is saved and returned, so it can later be restored using
+ * =
netns_restore()=2E
+ *
+ * If @p ctx is NULL or ctx->netns is NULL, the fun=
ction fails and returns -1=2E
+ *
+ * The switch is performed using setns(2=
)=2E This approach is required because
+ * the netlink library does not sup=
port performing operations in an arbitrary
+ * target network namespace, ex=
cept for interface creation and deletion=2E
+ * Therefore, in order to exec=
ute generic netlink operations inside a
+ * specific network namespace, the=
 thread must temporarily enter
+ * that namespace via setns()=2E
+ *
+ * @p=
aram ctx  Pointer to an OpenVPN network context structure containing
+ *   =
          the target network namespace name (ctx->netns)=2E The namespace
+=
 *             is expected to exist under NETNS_RUN_DIR (e=2Eg=2E /run/netn=
s/)=2E
+ *
+ * @return On success, returns a file descriptor referring to t=
he original
+ *         network namespace=2E This descriptor must be passed=
 to
+ *         netns_restore() to switch back=2E
+ * @return -1 on failure=
 (an error is logged and no namespace switch is kept)=2E
+ *
+ * @note The =
returned file descriptor must be passed to netns_restore(),
+ *       which=
 will restore the original namespace and close it=2E
+ */
+int netns_switch=
(openvpn_net_ctx_t *ctx);
+
+/**
+ * @brief Restore the previously saved ne=
twork namespace=2E
+ *
+ * This function restores the network namespace sav=
ed by netns_switch()
+ * using the file descriptor returned by that functio=
n=2E
+ *
+ * If @p orig_fd is negative, the function does nothing and retur=
ns
+ * immediately=2E
+ *
+ * The restoration is performed using setns(2), =
switching the calling
+ * thread back to its original network namespace=2E
=
+ *
+ * @param orig_fd  File descriptor of the original network namespace,
=
+ *                 as returned by netns_switch()=2E
+ *
+ * @note This fun=
ction always closes @p orig_fd if it is >=3D 0,
+ *       regardless of whe=
ther setns() succeeds or fails=2E
+ *       After calling this function, @p=
 orig_fd must not be reused=2E
+ */
+void netns_restore(int orig_fd);
+
+/*=
*
+ * Resolve a network interface name to its interface index=2E
+ *
+ * If=
 a valid network namespace ID is provided, the lookup is performed inside
+=
 * that network namespace using Netlink=2E Otherwise, this function falls b=
ack
+ * to the standard `if_nametoindex()` call in the current namespace=2E=

+ *
+ * @param ifname   Name of the network interface=2E
+ * @param ctx   =
   The network context where we retrieve
+ *                 the network na=
mespace name=2E
+ *
+ * @return Interface index on success, or 0 on error=
=2E
+ */
+int openvpn_if_nametoindex(const char *ifname, openvpn_net_ctx_t =
*ctx);
+
+/**
+ * Retrieve or create a network namespace ID (NSID) for a gi=
ven namespace=2E
+ *
+ * This function first attempts to retrieve the NSID =
associated with the
+ * specified network namespace=2E If no NSID is curren=
tly assigned, it
+ * requests the kernel to create one and then retries the=
 lookup=2E
+ *
+ * @param name  Name of the network namespace=2E
+ *
+ * @r=
eturn The network namespace ID on success, or -1 on failure=2E
+ */
+int ge=
t_or_create_netnsid_sitnl(const char *name);
 
 #endif /* NETWORKING_SITNL_=
H_ */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index =
0c2866c=2E=2Ebde3680 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn=
/options=2Ec
@@ -6488,6 +6488,14 @@
         VERIFY_PERMISSION(OPT_P_GENERA=
L);
         options->mtu_test =3D true;
     }
+    else if (streq(p[0], "=
netns") && p[1] && !p[2])
+    {
+#ifndef ENABLE_SITNL
+        msg(M_WARN,=
 "NOTE: --netns is supported only on Linux when compiled with SITNL");
+#en=
dif
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->netns =3D =
p[1];
+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
   =
      VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b=
/src/openvpn/options=2Eh
index a111cf8=2E=2E88a6dfa 100644
--- a/src/openvp=
n/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -315,6 +315,7 @@
 
     stru=
ct dns_options dns_options;
 
+    const char *netns;
     bool remote_rand=
om;
     const char *ipchange;
     const char *dev;
diff --git a/src/openv=
pn/tun=2Ec b/src/openvpn/tun=2Ec
index e7193d8=2E=2E51d9bed 100644
--- a/sr=
c/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -2082,6 +2082,13 @@
     }
 =
    else
     {
+#if defined(TARGET_LINUX) && defined(ENABLE_SITNL)
+      =
  int orig_fd =3D -1;
+        if (ctx->netns)
+        {
+            orig=
_fd =3D netns_switch(ctx);
+        }
+#endif /* if defined(TARGET_LINUX) &=
& defined(ENABLE_SITNL) */
         /*
          * Process --dev-node
     =
     */
@@ -2098,6 +2105,12 @@
         {
             msg(M_ERR, "ERROR: C=
annot open TUN/TAP dev %s", node);
         }
+#if defined(TARGET_LINUX) &&=
 defined(ENABLE_SITNL)
+        if (orig_fd !=3D -1)
+        {
+          =
  netns_restore(orig_fd);
+        }
+#endif
 
         /*
          * Proc=
ess --tun-ipv6

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8=
b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit-Change-Number: 1521
Gerrit-P=
atchSet: 11
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>

--TEh38X8qads=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos=2E </p>
<p>its_Gia=
an <strong>uploaded patch set #11</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by flichtenheld</p><p>The change is no longer submittable: Code-Review=
 and checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Add su=
pport for user defined network namespace<br><br>Introduce the --netns optio=
n to allow interface creation<br>into a user-defined network namespace=2E<b=
r>This allows the VPN data plane to be isolated from the main<br>OpenVPN pr=
ocess namespace=2E<br><br>The current netlink library integration supports =
interface creation<br>and deletion in a target namespace=2E However, subseq=
uent configuration<br>operations (e=2Eg=2E address or mtu set) are executed=
 in the caller&#39;s<br>namespace, as they rely on the default netlink sock=
et context=2E<br>As a result, interface-related configuration performed aft=
er creation<br>may be applied in the wrong namespace=2E<br>Introduce helper=
 functions to temporarily switch the process to the<br>requested network na=
mespace using setns(2), execute the required<br>netlink operations, and the=
n restore the original namespace=2E<br>The namespace switch is temporary an=
d scoped to each netlink<br>operation=2E Once the operation completes, the =
original namespace<br>is restored to preserve the process execution context=
=2E<br><br>Note: This feature is Linux-only and depends on setns(2)=2E<br>I=
t is not compatible (yet) with Data Channel Offload (DCO)=2E<br><br>Change-=
Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3<br>Signed-off-by: Gianmarco D=
e Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/vp=
n-network-options=2Erst<br>M src/openvpn/dco=2Ec<br>M src/openvpn/networkin=
g=2Eh<br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/networking_sit=
nl=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/o=
penvpn/tun=2Ec<br>8 files changed, 605 insertions(+), 83 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/21/1521/11</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/doc/man-sections/vpn-network-op=
tions=2Erst b/doc/man-sections/vpn-network-options=2Erst</span><br><span>in=
dex 33ebedb=2E=2E181c990 100644</span><br><span>--- a/doc/man-sections/vpn-=
network-options=2Erst</span><br><span>+++ b/doc/man-sections/vpn-network-op=
tions=2Erst</span><br><span>@@ -304,6 +304,12 @@</span><br><span>   Specify=
 the link layer address, more commonly known as the MAC address=2E</span><b=
r><span>   Only applied to TAP devices=2E</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+--netns name</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Specify the network namespace in which =
the tunnel interface will be created=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  The namespace must already exist=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  (Supported on Linux only, on other platforms this is a=
 no-op)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> --persist-tun</span><br><span>   Don&#39;t close and reopen TUN/TA=
P device or run up/down scripts across</span><br><span>   :code:`SIGUSR1` o=
r ``--ping-restart`` restarts=2E</span><br><span>diff --git a/src/openvpn/d=
co=2Ec b/src/openvpn/dco=2Ec</span><br><span>index f5b7081=2E=2Efbefcb6 100=
644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/ope=
nvpn/dco=2Ec</span><br><span>@@ -389,6 +389,12 @@</span><br><span>         =
        ret);</span><br><span>         }</span><br><span>     }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (o-&gt;netns)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(msglevel, &quot;Note: --netns not supported by DCO,=
 disabling data channel offload=2E&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span> #endif /* if defined(_WIN32=
) */</span><br><span> </span><br><span> #if defined(HAVE_LIBCAPNG)</span><b=
r><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2E=
h</span><br><span>index bce0c19=2E=2Efab6bbf 100644</span><br><span>--- a/s=
rc/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh<=
/span><br><span>@@ -39,10 +39,10 @@</span><br><span> typedef void *openvpn_=
net_iface_t;</span><br><span> #endif /* ifdef ENABLE_SITNL */</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Only the iprou=
te2 backend implements these functions,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Only the iproute2 and sitnl backend implements these=
 functions,</span><br><span>  * the rest can rely on these stubs</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !define=
d(ENABLE_IPROUTE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f !defined(ENABLE_IPROUTE) &amp;&amp; !defined(ENABLE_SITNL) || defined(TAR=
GET_ANDROID)</span><br><span> static inline int</span><br><span> net_ctx_in=
it(struct context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br>=
<span>@@ -63,7 +63,7 @@</span><br><span> {</span><br><span>     (void)ctx;<=
/span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif /* !defined(ENABLE_IPROUTE) */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif /* !defined(ENABLE_IPROUTE) &amp;&amp; !defined(ENABL=
E_SITNL) || defined(TARGET_ANDROID) */</span><br><span> </span><br><span> #=
if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)</span><br><span> </span=
><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/netw=
orking_sitnl=2Ec</span><br><span>index b3f8e2b=2E=2Eb60131f 100644</span><b=
r><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/op=
envpn/networking_sitnl=2Ec</span><br><span>@@ -33,14 +33,17 @@</span><br><s=
pan> #include &quot;networking=2Eh&quot;</span><br><span> #include &quot;pr=
oto=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;<=
/span><br><span> </span><br><span> #include &lt;errno=2Eh&gt;</span><br><sp=
an> #include &lt;string=2Eh&gt;</span><br><span> #include &lt;unistd=2Eh&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sched=
=2Eh&gt;</span><br><span> #include &lt;sys/types=2Eh&gt;</span><br><span> #=
include &lt;sys/socket=2Eh&gt;</span><br><span> #include &lt;linux/netlink=
=2Eh&gt;</span><br><span> #include &lt;linux/rtnetlink=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;linux/net_namespace=
=2Eh&gt;</span><br><span> </span><br><span> #define SNDBUF_SIZE (1024 * 2)<=
/span><br><span> #define RCVBUF_SIZE (1024 * 4)</span><br><span>@@ -65,6 +6=
8,12 @@</span><br><span>         _nest-&gt;rta_len =3D (unsigned short)((vo=
id *)sitnl_nlmsg_tail(_msg) - (void *)_nest); \</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e SITNL_NETNS_RTA(r) \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct rtgenms=
g))))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define NETNS_RUN_DIR  &quot;/run=
/netns&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 NETNS_ORIG_DIR &quot;/proc/self/ns/net&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /* This function was originally=
 implemented as a macro, but compiling with</span><br><span>  * gcc and -O3=
 was getting confused about the math and thus raising</span><br><span>  * s=
ecurity warnings on subsequent memcpy() calls=2E</span><br><span>@@ -121,6 =
+130,16 @@</span><br><span>     char buf[256];</span><br><span> };</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Network namespace NSID =
request message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct sitnl_nsid_re=
q</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct nlmsghdr n;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct rtgenmsg g;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char buf[256];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> typedef int (*sitnl_parse_repl=
y_cb)(struct nlmsghdr *msg, void *arg);</span><br><span> </span><br><span> =
/**</span><br><span>@@ -156,6 +175,105 @@</span><br><span>     return 0;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; defined(ENABLE_SITNL)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static int netns_id_from_name_sitnl(cons=
t char *name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c int set_netns_id_from_name_sitnl(const char *name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+n=
et_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct stat st;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    char path[PATH_MAX];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ctx-&gt;netns =3D NULL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
c &amp;&amp; c-&gt;options=2Enetns)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        snprintf(path, sizeof(path), &quot;%s/%s&quot;, NETNS_RUN_DIR, c-=
&gt;options=2Enetns);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (stat(=
path, &amp;st) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_ERR, &quot;%s: Network namespace %s does not exist&quot;, __func=
__, path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ctx-&gt;netns =3D c-&gt;option=
s=2Enetns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_reset(o=
penvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_reset(&a=
mp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+net_ctx_free(openvpn_net_ctx_t *ctx)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    gc_free(&amp;ctx-&gt;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+netns_switch(openvpn_net_=
ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char net_path[PATH_MAX=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int orig_fd =
=3D -1, netns_fd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *netns =3D ctx ? ctx-&gt;netns : NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!netns)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Save current netns descriptor =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    orig_fd =3D o=
pen(NETNS_ORIG_DIR, O_RDONLY | O_CLOEXEC);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (orig_fd &lt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: Cannot open original n=
etwork namespace&quot;, __func__);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(net_pa=
th, sizeof(net_path), &quot;%s/%s&quot;, NETNS_RUN_DIR, netns);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    netns_fd =3D open(net_path,=
 O_RDONLY | O_CLOEXEC);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (netns_fd &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_WARN | M_ERRNO, &quot;%s: Cannot open network namespace \&quot;%s\=
&quot;&quot;, __func__, netns);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        close(orig_fd);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (setns(netn=
s_fd, CLONE_NEWNET) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_WARN | M_ERRNO, &quot;%s: setting the network namespace \&quot;%s\&=
quot; failed&quot;, __func__, netns);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        close(netns_fd);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        close(orig_fd);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    clo=
se(netns_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn orig_fd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+netns_restore(int orig_fd)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (orig_fd &lt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (setns(orig_fd, CLONE_NEWNET) &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO=
, &quot;%s: Cannot restore original network namespace&quot;, __func__);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    close(orig_fd);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* defined (TARGET_LINUX) &amp;&amp; defined (ENABLE_SITNL) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</s=
pan><br><span>  * Open RTNL socket</span><br><span>  */</span><br><span>@@ =
-445,6 +563,285 @@</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef=
 ENABLE_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Netlink callback to=
 extract the interface index from a RTM_NEWLINK message=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * This function is used as a Netlink response handle=
r=2E It inspects incoming</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Netlink messages and, when a RTM_NEWLINK message is received, copi=
es the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * contained =
`struct ifinfomsg` into the caller-provided result structure=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param n    Netlink message header received f=
rom the kernel=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param arg  Pointer to a `struct sitnl_link_req` used to store the result=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return 0 to stop Netlink mess=
age processing once the interface is found,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *         1 to continue processing other messages=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_link_get_ifindex(struct nlmsghdr *n=
, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sitnl_link_req=
 *res =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct ifinfomsg *ifi;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (n-&gt;nlm=
sg_type !=3D RTM_NEWLINK)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ifi =3D NLMSG_DATA(n);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    res-&gt;i =3D *ifi;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Retrieve the interface index o=
f a network device in a specific network namespace=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Sends an RTM_GETLINK Netlink request targeting the give=
n network namespace ID</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * and interface name, and extracts the resulting interface index from t=
he kernel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * respons=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * On failure, this function ret=
urns 0, matching the behavior of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * `if_nametoindex()`=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param ifname   Name of the network interface=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param netnsid  Target network namespa=
ce ID=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Interface index o=
n success, or 0 on error=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ifindex_in_ne=
tns(const char *ifname, int netnsid)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct sitnl_link_req req;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct sitnl_link_req res;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int ret =3D -1, ifindex =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    CLEAR(req);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    CLEAR(res);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2E=
n=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D RTM_GETLINK;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_flag=
s =3D NLM_F_REQUEST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(=
&amp;req=2En, sizeof(req), IFLA_TARGET_NETNSID, &amp;netnsid, sizeof(int));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&=
amp;req=2En, sizeof(req), IFLA_IFNAME, ifname, strlen(ifname) + 1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req=2En, 0, 0, sit=
nl_link_get_ifindex, &amp;res);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return ret;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ifindex =3D res=2Ei=2Eifi_index;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_parse_rtattr_flags(struct rtattr *t=
b[], size_t max, struct rtattr *rta, size_t len,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                         unsigned short flags)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    unsigned short type;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    memset(tb, 0, sizeof(struct rtattr *) * (max + =
1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    while (RTA_OK(rta, len))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        type =3D rta-&gt;rta_type &amp;=
 ~flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if ((type &lt;=3D max)=
 &amp;&amp; (!tb[type]))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       tb[type] =3D rta;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        rta =3D RTA_NEXT=
(rta, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(D_ROUTE, &quot;%s: %zu bytes not parsed! (rta_len=
=3D%u)&quot;, __func__, len, rta-&gt;rta_len);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+sitnl_parse_rtattr(struct rtattr=
 *tb[], size_t max, struct rtattr *rta, size_t len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    sitnl_parse_rtattr_flags(tb, max, rta, len, 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define sitnl_parse_rtattr_nested(tb, max, rta) \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    (sitnl_parse_rtattr_flags(tb, =
max, RTA_DATA(rta), RTA_PAYLOAD(rta), NLA_F_NESTED))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Netlink callback to extract and store a network namespace ID (NSID)=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * This function processes Netlink resp=
onses to RTM_GETNSID requests=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * If a NETNSA_NSID attribute is present, its value is copied =
into the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * caller-p=
rovided storage=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If a Netlink er=
ror message is received, the contained error code is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * returned directly=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param n    Netlink message header received from th=
e kernel=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m arg  Pointer to an integer where the NSID will be stored=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return 0 on success, a negative error code on =
failure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+sitnl_nsid_save(struct nlmsghdr *n=
, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int *nsid =3D arg;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct rtgenmsg *g=
 =3D NLMSG_DATA(n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct rtattr *tb[NETNSA_MAX + 1];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (n-&gt;nlmsg_type =3D=3D NLMSG_ERROR)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct nlmsgerr *err =3D NLMSG_DATA(n);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return err-&gt;error;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    sitnl_parse_rtattr(tb, NETNSA_MAX, SITNL_NETNS_RTA(g), =
NLMSG_PAYLOAD(n, sizeof(*g)));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!tb[NETNSA_NSID])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -=
ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    memcpy(nsid, RTA_DATA(tb[NETNSA_NSID]), s=
izeof(*nsid));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Retrieve the network namespace ID (NSID) associated with a na=
mespace name=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function open=
s the network namespace identified by the given path</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * and sends an RTM_GETNSID Netlink reque=
st to retrieve its assigned NSID=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param name  Name of the network namespace=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return The network namespace ID on success, or a negative va=
lue on failure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+netns_id_from_name_sitnl(co=
nst char *name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sitnl_nsid_=
req req;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int netnsid =3D -1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(req);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int netns_fd =3D open(name, O_RDONLY);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netns_fd &lt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Eg));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D RT=
M_GETNSID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=
=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    req=2Eg=2Ertgen_family =3D AF_UNSPEC;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    SITNL_ADDATTR(&amp;req=2En, sizeof(req), NETNSA_FD=
, &amp;netns_fd, sizeof(int));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sitn=
l_send(&amp;req=2En, 0, 0, sitnl_nsid_save, &amp;netnsid);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (netns_fd &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       close(netns_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 netnsid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Assign a network namespace ID (NSID) to a namespace=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This function sends an RTM_NEWNSID Net=
link request to associate a</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * NSID with the network namespace identified by the given path=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param name  Name of the network n=
amespace=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return 0 on success, =
or a negative error code on failure=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set_ne=
tns_id_from_name_sitnl(const char *name)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct sitnl_nsid_req req;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt ret =3D -1, netnsid =3D -1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    CLEAR(req);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int netn=
s_fd =3D open(name, O_RDONLY);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (netns_fd &lt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_len =3D NLMSG=
_LENGTH(sizeof(req=2Eg));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    req=2En=2Enlmsg_type =3D RTM_NEWNSID;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Eg=2Ertgen_fa=
mily =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&=
amp;req=2En, sizeof(req), NETNSA_FD, &amp;netns_fd, sizeof(int));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&amp;req=2E=
n, sizeof(req), NETNSA_NSID, &amp;netnsid, sizeof(int));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (netns_fd &gt;=3D 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        close(netns_fd);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+get_or_create_netnsid_sitnl(const char *name)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    char net_path[PATH_MAX];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int netnsid;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    snprintf(net_path, sizeof(net_path=
), &quot;%s/%s&quot;, NETNS_RUN_DIR, name);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* First get */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    netnsid =3D netns_id_from_name_sitnl(net_path);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (netnsid &gt;=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return netnsid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* No netnsid yet? Try to assign one */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    netnsid =3D set_netns_id_from_name_sitnl(net_p=
ath);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netnsi=
d &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Second get */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    netnsid =3D netns_id_from_name_sitnl(net_path);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netnsid &gt;=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return netnsid;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return -1;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+openvpn_if_nametoindex(const char *ifname=
, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *netns =3D ctx ? ctx-&gt;netns : NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int netnsid =3D get_or_create_netnsid_sitnl(netns=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (netnsid &lt; 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return if_nametoindex(ifname);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return get_ifindex_in_netns(ifname, netnsid);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_SITNL */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef struct</sp=
an><br><span> {</span><br><span>     size_t addr_size;</span><br><span>@@ -=
652,7 +1049,7 @@</span><br><span> net_iface_up(openvpn_net_ctx_t *ctx, cons=
t char *iface, bool up)</span><br><span> {</span><br><span>     struct sitn=
l_link_req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i=
findex, orig =3D -1;</span><br><span> </span><br><span>     CLEAR(req);</sp=
an><br><span> </span><br><span>@@ -662,13 +1059,15 @@</span><br><span>     =
    return -EINVAL;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifindex =3D o=
penvpn_if_nametoindex(iface, ctx);</span><br><span>     if (ifindex =3D=3D =
0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(M_WARN, &quot;%s: rtnl: cannot get ifindex for %s: %s&quot;=
, __func__, iface, strerror(errno));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get i=
findex for %s&quot;, __func__, iface);</span><br><span>         return -ENO=
ENT;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    orig =3D netns_switch(ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     req=2En=2Enlmsg=
_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>     req=2En=2Enlms=
g_flags =3D NLM_F_REQUEST;</span><br><span>     req=2En=2Enlmsg_type =3D RT=
M_NEWLINK;</span><br><span>@@ -687,24 +1086,30 @@</span><br><span> </span><=
br><span>     msg(M_INFO, &quot;%s: set %s %s&quot;, __func__, iface, up ? =
&quot;up&quot; : &quot;down&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return sitnl_send(&amp;req=2En, 0, 0, N=
ULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    netns_restore(orig);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return ret;</span><br><span> }</span><br><span> </span><br><span> int<=
/span><br><span> net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *ifac=
e, uint32_t mtu)</span><br><span> {</span><br><span>     struct sitnl_link_=
req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifind=
ex, ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int ifindex, orig =3D -1, ret =3D -1;</span><br><span> </span><br><span>   =
  CLEAR(req);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ifindex =3D openvpn_if_nametoindex(iface, =
ctx);</span><br><span>     if (ifindex =3D=3D 0)</span><br><span>     {</sp=
an><br><span>         msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifin=
dex for %s&quot;, __func__, iface);</span><br><span>         return -1;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    orig =3D netns_switch(ctx);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     req=2En=2Enlmsg_len =3D=
 NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>     req=2En=2Enlmsg_flags =
=3D NLM_F_REQUEST;</span><br><span>     req=2En=2Enlmsg_type =3D RTM_NEWLIN=
K;</span><br><span>@@ -717,7 +1122,9 @@</span><br><span>     msg(M_INFO, &q=
uot;%s: mtu %u for %s&quot;, __func__, mtu, iface);</span><br><span> </span=
><br><span>     ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> err:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    netns_restore(orig);=
</span><br><span>     return ret;</span><br><span> }</span><br><span> </spa=
n><br><span>@@ -725,17 +1132,19 @@</span><br><span> net_addr_ll_set(openvpn=
_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)</span><br=
><span> {</span><br><span>     struct sitnl_link_req req;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int ifindex, ret =3D -1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int ifindex, orig =3D -1, =
ret =3D -1;</span><br><span> </span><br><span>     CLEAR(req);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D =
if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>    =
 if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span>         msg(=
M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__=
, iface);</span><br><span>         return -1;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    orig=
 =3D netns_switch(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=
=2Ei));</span><br><span>     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span=
><br><span>     req=2En=2Enlmsg_type =3D RTM_NEWLINK;</span><br><span>@@ -7=
48,17 +1157,19 @@</span><br><span>     msg(M_INFO, &quot;%s: lladdr &quot; =
MAC_FMT &quot; for %s&quot;, __func__, MAC_PRINT_ARG(addr), iface);</span><=
br><span> </span><br><span>     ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL=
, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    netn=
s_restore(orig);</span><br><span>     return ret;</span><br><span> }</span>=
<br><span> </span><br><span> static int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex,=
 sa_family_t af_family,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+sitnl_addr_set(openvpn_net_ctx_t *ctx, uint16_t cmd, uint16_t flags, in=
t ifindex, sa_family_t af_family,</span><br><span>                const ine=
t_address_t *local, const inet_address_t *remote, int prefixlen)</span><br>=
<span> {</span><br><span>     struct sitnl_addr_req req;</span><br><span>  =
   uint32_t size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int ret =3D -EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int ret =3D -EINVAL, orig =3D -1;</span><br><span> </span><br><span>  =
   CLEAR(req);</span><br><span> </span><br><span>@@ -810,17 +1221,22 @@</sp=
an><br><span>         SITNL_ADDATTR(&amp;req=2En, sizeof(req), IFA_BROADCAS=
T, &amp;broadcast, size);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    orig =3D netns_switch(ct=
x);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (ret =3D=3D =
-EEXIST)</span><br><span>     {</span><br><span>         ret =3D 0;</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   netns_restore(orig);</span><br><span>     return ret;</span><br><span> }=
</span><br><span> </span><br><span> static int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-sitnl_addr_ptp_add(sa_family_t af_family, const ch=
ar *iface, const inet_address_t *local,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+sitnl_addr_ptp_add(openvpn_net_ctx_t *ctx, sa_family_t =
af_family, const char *iface, const inet_address_t *local,</span><br><span>=
                    const inet_address_t *remote)</span><br><span> {</span>=
<br><span>     int ifindex;</span><br><span>@@ -841,19 +1257,19 @@</span><b=
r><span>         return -EINVAL;</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_name=
toindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>     if (if=
index =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(M_WARN, &quot;%s: cannot get ifindex for %s: %=
s&quot;, __func__, np(iface), strerror(errno));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: cannot =
get ifindex for %s&quot;, __func__, np(iface));</span><br><span>         re=
turn -ENOENT;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_NEWADDR, NLM=
_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_set(ctx, RTM_NEWADD=
R, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,</span><br><span=
>                           remote, 0);</span><br><span> }</span><br><span>=
 </span><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-sitnl_addr_ptp_del(sa_family_t af_family, const char *iface, const =
inet_address_t *local)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+sitnl_addr_ptp_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, const =
char *iface, const inet_address_t *local)</span><br><span> {</span><br><spa=
n>     int ifindex;</span><br><span> </span><br><span>@@ -873,23 +1289,23 @=
@</span><br><span>         return -EINVAL;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>=
     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span>         =
msg(M_WARN | M_ERRNO, &quot;%s: cannot get ifindex for %s&quot;, __func__, =
iface);</span><br><span>         return -ENOENT;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_s=
et(ctx, RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);</span><br><spa=
n> }</span><br><span> </span><br><span> static int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-sitnl_route_set(uint16_t cmd, uint16_t flags, =
int ifindex, sa_family_t af_family, const void *dst,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_route_set(openvpn_net_ctx_t *ctx, u=
int16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void=
 *dst,</span><br><span>                 int prefixlen, const void *gw, enum=
 rt_class_t table, int metric,</span><br><span>                 enum rt_sco=
pe_t scope, unsigned char protocol, unsigned char type)</span><br><span> {<=
/span><br><span>     struct sitnl_route_req req;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int ret =3D -1, size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1, size, orig =3D -1;</s=
pan><br><span> </span><br><span>     CLEAR(req);</span><br><span> </span><b=
r><span>@@ -948,14 +1364,17 @@</span><br><span>     {</span><br><span>     =
    SITNL_ADDATTR(&amp;req=2En, sizeof(req), RTA_PRIORITY, &amp;metric, 4);=
</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    orig =3D netns_switch(ctx);</span><br><span> </span><br><span>     =
ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> err:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    netns_restore(orig);</span><br><sp=
an>     return ret;</span><br><span> }</span><br><span> </span><br><span> s=
tatic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_a=
dd(sa_family_t af_family, const char *iface, const inet_address_t *addr, in=
t prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_a=
ddr_add(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *iface, c=
onst inet_address_t *addr, int prefixlen)</span><br><span> {</span><br><spa=
n>     int ifindex;</span><br><span> </span><br><span>@@ -975,19 +1394,19 @=
@</span><br><span>         return -EINVAL;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>=
     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span>         =
msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __fu=
nc__, iface);</span><br><span>         return -ENOENT;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex=
, af_family, addr, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLA=
CE, ifindex, af_family, addr, NULL,</span><br><span>                       =
    prefixlen);</span><br><span> }</span><br><span> </span><br><span> stati=
c int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_del(s=
a_family_t af_family, const char *iface, inet_address_t *addr, int prefixle=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_del(op=
envpn_net_ctx_t *ctx, sa_family_t af_family, const char *iface, inet_addres=
s_t *addr, int prefixlen)</span><br><span> {</span><br><span>     int ifind=
ex;</span><br><span> </span><br><span>@@ -1007,14 +1426,14 @@</span><br><sp=
an>         return -EINVAL;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoind=
ex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifind=
ex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>     if (ifindex=
 =3D=3D 0)</span><br><span>     {</span><br><span>         msg(M_WARN | M_E=
RRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, iface);</s=
pan><br><span>         return -ENOENT;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_=
addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_set(=
ctx, RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);</span><br>=
<span> }</span><br><span> </span><br><span> int</span><br><span>@@ -1033,7 =
+1452,7 @@</span><br><span>     msg(M_INFO, &quot;%s: %s/%d dev %s&quot;, _=
_func__, inet_ntop(AF_INET, &amp;addr_v4=2Eipv4, buf, sizeof(buf)),</span><=
br><span>         prefixlen, iface);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_add(AF_INET, iface, =
&amp;addr_v4, prefixlen);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return sitnl_addr_add(ctx, AF_INET, iface, &amp;addr_v4, prefixle=
n);</span><br><span> }</span><br><span> </span><br><span> int</span><br><sp=
an>@@ -1053,7 +1472,7 @@</span><br><span>     msg(M_INFO, &quot;%s: %s/%d d=
ev %s&quot;, __func__, inet_ntop(AF_INET6, &amp;addr_v6=2Eipv6, buf, sizeof=
(buf)),</span><br><span>         prefixlen, iface);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_add(A=
F_INET6, iface, &amp;addr_v6, prefixlen);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return sitnl_addr_add(ctx, AF_INET6, iface, &amp;=
addr_v6, prefixlen);</span><br><span> }</span><br><span> </span><br><span> =
int</span><br><span>@@ -1072,7 +1491,7 @@</span><br><span>     msg(M_INFO, =
&quot;%s: %s dev %s&quot;, __func__, inet_ntop(AF_INET, &amp;addr_v4=2Eipv4=
, buf, sizeof(buf)),</span><br><span>         iface);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_del=
(AF_INET, iface, &amp;addr_v4, prefixlen);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return sitnl_addr_del(ctx, AF_INET, iface, &amp;=
addr_v4, prefixlen);</span><br><span> }</span><br><span> </span><br><span> =
int</span><br><span>@@ -1092,7 +1511,7 @@</span><br><span>     msg(M_INFO, =
&quot;%s: %s/%d dev %s&quot;, __func__, inet_ntop(AF_INET6, &amp;addr_v6=2E=
ipv6, buf, sizeof(buf)),</span><br><span>         prefixlen, iface);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 sitnl_addr_del(AF_INET6, iface, &amp;addr_v6, prefixlen);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_del(ctx, AF_IN=
ET6, iface, &amp;addr_v6, prefixlen);</span><br><span> }</span><br><span> <=
/span><br><span> int</span><br><span>@@ -1120,7 +1539,7 @@</span><br><span>=
         inet_ntop(AF_INET, &amp;local_v4=2Eipv4, buf1, sizeof(buf1)),</spa=
n><br><span>         inet_ntop(AF_INET, &amp;remote_v4=2Eipv4, buf2, sizeof=
(buf2)), iface);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return sitnl_addr_ptp_add(AF_INET, iface, &amp;local_v4, &=
amp;remote_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return sitnl_addr_ptp_add(ctx, AF_INET, iface, &amp;local_v4, &amp;remote_v=
4);</span><br><span> }</span><br><span> </span><br><span> int</span><br><sp=
an>@@ -1141,11 +1560,11 @@</span><br><span>     msg(M_INFO, &quot;%s: %s de=
v %s&quot;, __func__, inet_ntop(AF_INET, &amp;local_v4=2Eipv4, buf, sizeof(=
buf)),</span><br><span>         iface);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_ptp_del(AF_INET, =
iface, &amp;local_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return sitnl_addr_ptp_del(ctx, AF_INET, iface, &amp;local_v4);</span=
><br><span> }</span><br><span> </span><br><span> static int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_add(const char *iface, sa=
_family_t af_family, const void *dst, int prefixlen,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_route_add(openvpn_net_ctx_t *ctx, c=
onst char *iface, sa_family_t af_family, const void *dst, int prefixlen,</s=
pan><br><span>                 const void *gw, uint32_t table, int metric)<=
/span><br><span> {</span><br><span>     enum rt_scope_t scope =3D RT_SCOPE_=
UNIVERSE;</span><br><span>@@ -1153,7 +1572,7 @@</span><br><span> </span><br=
><span>     if (iface)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        ifindex =3D if_nametoindex(iface);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        ifindex =3D openvpn_=
if_nametoindex(iface, ctx);</span><br><span>         if (ifindex =3D=3D 0)<=
/span><br><span>         {</span><br><span>             msg(M_WARN | M_ERRN=
O, &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, __func__, iface);</s=
pan><br><span>@@ -1171,7 +1590,7 @@</span><br><span>         scope =3D RT_S=
COPE_LINK;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM_NEWROUTE, NL=
M_F_CREATE, ifindex, af_family, dst, prefixlen, gw,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_set(ctx, RTM_NEWRO=
UTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,</span><br><span>=
                            table, metric, scope, RTPROT_BOOT, RTN_UNICAST)=
;</span><br><span> }</span><br><span> </span><br><span>@@ -1200,7 +1619,7 @=
@</span><br><span>         inet_ntop(AF_INET, &amp;dst_be, dst_str, sizeof(=
dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw_b=
e, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_a=
dd(iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table, metric);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_add(ctx, =
iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table, metric);</span><br><span=
> }</span><br><span> </span><br><span> int</span><br><span>@@ -1226,18 +164=
5,18 @@</span><br><span>         inet_ntop(AF_INET6, &amp;dst_v6=2Eipv6, ds=
t_str, sizeof(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_I=
NET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return sitnl_route_add(iface, AF_INET6, dst, prefixlen, gw, table, metric=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_=
route_add(ctx, iface, AF_INET6, dst, prefixlen, gw, table, metric);</span><=
br><span> }</span><br><span> </span><br><span> static int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-sitnl_route_del(const char *iface, sa_f=
amily_t af_family, inet_address_t *dst, int prefixlen,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+sitnl_route_del(openvpn_net_ctx_t *ctx, =
const char *iface, sa_family_t af_family, inet_address_t *dst, int prefixle=
n,</span><br><span>                 inet_address_t *gw, uint32_t table, int=
 metric)</span><br><span> {</span><br><span>     int ifindex =3D 0;</span><=
br><span> </span><br><span>     if (iface)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ifindex =3D if_nametoin=
dex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>         if=
 (ifindex =3D=3D 0)</span><br><span>         {</span><br><span>            =
 msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, =
__func__, iface);</span><br><span>@@ -1250,7 +1669,7 @@</span><br><span>   =
      table =3D RT_TABLE_MAIN;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_se=
t(RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_rout=
e_set(ctx, RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, =
metric,</span><br><span>                            RT_SCOPE_NOWHERE, 0, 0)=
;</span><br><span> }</span><br><span> </span><br><span>@@ -1277,7 +1696,7 @=
@</span><br><span>         inet_ntop(AF_INET, &amp;dst_v4=2Eipv4, dst_str, =
sizeof(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &a=
mp;gw_v4=2Eipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 sitnl_route_del(iface, AF_INET, &amp;dst_v4, prefixlen, &amp;gw_v4, table,=
 metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 sitnl_route_del(ctx, iface, AF_INET, &amp;dst_v4, prefixlen, &amp;gw_v4, t=
able, metric);</span><br><span> }</span><br><span> </span><br><span> int</s=
pan><br><span>@@ -1303,7 +1722,7 @@</span><br><span>         inet_ntop(AF_I=
NET6, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><=
span>         inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)=
), np(iface), table, metric);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return sitnl_route_del(iface, AF_INET6, &amp;=
dst_v6, prefixlen, &amp;gw_v6, table, metric);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return sitnl_route_del(ctx, iface, AF_INET6,=
 &amp;dst_v6, prefixlen, &amp;gw_v6, table, metric);</span><br><span> }</sp=
an><br><span> </span><br><span> </span><br><span>@@ -1347,45 +1766,11 @@</s=
pan><br><span>     msg(D_ROUTE, &quot;%s: add %s type %s&quot;, __func__, i=
face, type);</span><br><span> </span><br><span>     ret =3D sitnl_send(&amp=
;req=2En, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> err:</span><br><span>     return ret;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl=
_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta, si=
ze_t len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
             unsigned short flags)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uns=
igned short type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    memset(tb, 0, sizeof(=
struct rtattr *) * (max + 1));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (R=
TA_OK(rta, len))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        type =3D rta-=
&gt;rta_type &amp; ~flags;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((typ=
e &lt;=3D max) &amp;&amp; (!tb[type]))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            tb[type] =3D rta;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rta =3D RTA_=
NEXT(rta, len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (len)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(D_ROUTE, &quot;%s: %zu bytes not parsed! (rta_len=3D%u)&=
quot;, __func__, len, rta-&gt;rta_len);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-sitnl_parse_rtattr(struct rtattr *tb[], size_t ma=
x, struct rtattr *rta, size_t len)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sit=
nl_parse_rtattr_flags(tb, max, rta, len, 0);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define sitnl_pars=
e_rtattr_nested(tb, max, rta) \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    (sitnl_parse_rtattr_flags(tb, max, RTA_DATA(rta), RTA_PAYLOAD=
(rta), NLA_F_NESTED))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> static int</span><br><span> sitnl_type_save(struct nlmsgh=
dr *n, void *arg)</span><br><span> {</span><br><span>@@ -1416,13 +1801,16 @=
@</span><br><span> net_iface_type(openvpn_net_ctx_t *ctx, const char *iface=
, char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span><br><span>     st=
ruct sitnl_link_req req =3D {};</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int ifindex =3D if_nametoindex(iface);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int ifindex =3D openvpn_if_nametoinde=
x(iface, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt orig =3D -1;</span><br><span> </span><br><span>     if (!ifindex)</span>=
<br><span>     {</span><br><span>         return -errno;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    orig =3D netns_switch(ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(s=
izeof(req=2Ei));</span><br><span>     req=2En=2Enlmsg_flags =3D NLM_F_REQUE=
ST;</span><br><span>     req=2En=2Enlmsg_type =3D RTM_GETLINK;</span><br><s=
pan>@@ -1435,26 +1823,32 @@</span><br><span>     int ret =3D sitnl_send(&am=
p;req=2En, 0, 0, sitnl_type_save, type);</span><br><span>     if (ret &lt; =
0)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        netns_restore(orig);</span><br><span>         msg(D_ROUTE, &q=
uot;%s: cannot retrieve iface %s: %s (%d)&quot;, __func__, iface, strerror(=
-ret), ret);</span><br><span>         return ret;</span><br><span>     }</s=
pan><br><span> </span><br><span>     msg(D_ROUTE, &quot;%s: type of %s: %s&=
quot;, __func__, iface, type);</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    netns_restore(orig);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</span><br=
><span> }</span><br><span> </span><br><span> int</span><br><span> net_iface=
_del(openvpn_net_ctx_t *ctx, const char *iface)</span><br><span> {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1, orig =3D=
 -1;</span><br><span>     struct sitnl_link_req req =3D {};</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D if_nametoindex(if=
ace);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ifinde=
x =3D openvpn_if_nametoindex(iface, ctx);</span><br><span> </span><br><span=
>     if (!ifindex)</span><br><span>     {</span><br><span>         return =
-errno;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    orig =3D netns_switch(ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     req=2En=2Enl=
msg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>     req=2En=2En=
lmsg_flags =3D NLM_F_REQUEST;</span><br><span>     req=2En=2Enlmsg_type =3D=
 RTM_DELLINK;</span><br><span>@@ -1464,7 +1858,11 @@</span><br><span> </spa=
n><br><span>     msg(D_ROUTE, &quot;%s: delete %s&quot;, __func__, iface);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req=2En, 0, 0, N=
ULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    netns_restore(orig);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</span>=
<br><span> </span><br><span> #endif /* !ENABLE_SITNL */</span><br><span>dif=
f --git a/src/openvpn/networking_sitnl=2Eh b/src/openvpn/networking_sitnl=
=2Eh</span><br><span>index 481cc36=2E=2E7e723fe 100644</span><br><span>--- =
a/src/openvpn/networking_sitnl=2Eh</span><br><span>+++ b/src/openvpn/networ=
king_sitnl=2Eh</span><br><span>@@ -21,7 +21,97 @@</span><br><span> #ifndef =
NETWORKING_SITNL_H_</span><br><span> #define NETWORKING_SITNL_H_</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;env_set=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> typedef char openvpn_net_iface_t;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-typedef void *openvpn_net_ctx_t;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+struct openvpn_net_ctx</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *netns;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct gc_arena gc;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct ope=
nvpn_net_ctx openvpn_net_ctx_t;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Switch the cu=
rrent thread to the network namespace specified</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *        in the given OpenVPN network context=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * This function changes the call=
ing thread&#39;s network namespace to the one</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * identified by ctx-&gt;netns=2E The current (or=
iginal) network namespace file</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * descriptor is saved and returned, so it can later be restored=
 using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * netns_rest=
ore()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * If @p ctx is NULL or ctx-=
&gt;netns is NULL, the function fails and returns -1=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * The switch is performed using setns(2)=2E This approa=
ch is required because</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * the netlink library does not support performing operations in an arbi=
trary</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * target netw=
ork namespace, except for interface creation and deletion=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Therefore, in order to execute =
generic netlink operations inside a</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * specific network namespace, the thread must temporarily =
enter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that namesp=
ace via setns()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx  Poi=
nter to an OpenVPN network context structure containing</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             the target network names=
pace name (ctx-&gt;netns)=2E The namespace</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             is expected to exist under NETNS_RUN_=
DIR (e=2Eg=2E /run/netns/)=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn On success, returns a file descriptor referring to the original</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *         network namespac=
e=2E This descriptor must be passed to</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *         netns_restore() to switch back=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return -1 on failure (an er=
ror is logged and no namespace switch is kept)=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @note The returned file descriptor must be passed to netns_=
restore(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
which will restore the original namespace and close it=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+int netns_switch(openvpn_net_ctx_t *ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @brief Restore the previously saved network namespace=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This function restores the network nam=
espace saved by netns_switch()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * using the file descriptor returned by that function=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * If @p orig_fd is negative, the functio=
n does nothing and returns</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * immediately=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The resto=
ration is performed using setns(2), switching the calling</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * thread back to its original networ=
k namespace=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param orig_fd  Fil=
e descriptor of the original network namespace,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *                 as returned by netns_switch(=
)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @note This function always cl=
oses @p orig_fd if it is &gt;=3D 0,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *       regardless of whether setns() succeeds or fails=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       After call=
ing this function, @p orig_fd must not be reused=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void netns_restore(int orig_fd);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * R=
esolve a network interface name to its interface index=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * If a valid network namespace ID is provided, the lo=
okup is performed inside</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * that network namespace using Netlink=2E Otherwise, this function fa=
lls back</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to the s=
tandard `if_nametoindex()` call in the current namespace=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param ifname   Name of the network interface=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx      T=
he network context where we retrieve</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *                 the network namespace name=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return Interface index on success, or 0 on=
 error=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+int openvpn_if_nametoindex=
(const char *ifname, openvpn_net_ctx_t *ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retrie=
ve or create a network namespace ID (NSID) for a given namespace=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * This function first attempts to retrieve =
the NSID associated with the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * specified network namespace=2E If no NSID is currently assigned=
, it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * requests the=
 kernel to create one and then retries the lookup=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param name  Name of the network namespace=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return The network namespace ID on success=
, or -1 on failure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int get_or_cre=
ate_netnsid_sitnl(const char *name);</span><br><span> </span><br><span> #en=
dif /* NETWORKING_SITNL_H_ */</span><br><span>diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec</span><br><span>index 0c2866c=2E=2Ebde368=
0 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ =
b/src/openvpn/options=2Ec</span><br><span>@@ -6488,6 +6488,14 @@</span><br>=
<span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         o=
ptions-&gt;mtu_test =3D true;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;netns&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef ENABLE_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_WARN, &quot;NOTE: --netns is supported only on Linux when=
 compiled with SITNL&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        options-&gt;netns =3D p[1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq=
(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>=
     {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);</span><br><s=
pan>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><b=
r><span>index a111cf8=2E=2E88a6dfa 100644</span><br><span>--- a/src/openvpn=
/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>=
@@ -315,6 +315,7 @@</span><br><span> </span><br><span>     struct dns_optio=
ns dns_options;</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *netns;</span><br><span>     bool remote_rando=
m;</span><br><span>     const char *ipchange;</span><br><span>     const ch=
ar *dev;</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=
=2Ec</span><br><span>index e7193d8=2E=2E51d9bed 100644</span><br><span>--- =
a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><=
span>@@ -2082,6 +2082,13 @@</span><br><span>     }</span><br><span>     els=
e</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(TARGET_LINUX) &amp;&amp; defined(ENABLE_SITNL)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        int orig_fd =3D -1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ctx-&gt;net=
ns)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            orig_fd =3D ne=
tns_switch(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if =
defined(TARGET_LINUX) &amp;&amp; defined(ENABLE_SITNL) */</span><br><span> =
        /*</span><br><span>          * Process --dev-node</span><br><span> =
         */</span><br><span>@@ -2098,6 +2105,12 @@</span><br><span>        =
 {</span><br><span>             msg(M_ERR, &quot;ERROR: Cannot open TUN/TAP=
 dev %s&quot;, node);</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; defined(E=
NABLE_SITNL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (orig_fd !=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    netns_restore(orig_fd);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span> </span><br><span>         /*</span><br><span>        =
  * Process --tun-ipv6</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail">chang=
e 1521</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Gia=
an &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--TEh38X8qads=--


--===============4050621623289867407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4050621623289867407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4050621623289867407==--

