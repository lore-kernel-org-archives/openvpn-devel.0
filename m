Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9915FCD8CB9
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QVZuTOcatjXBOiQUXfwPVbHP4pW28lzQFtIBG6uzAS0=; b=EZlJnBU4anDtrSgPrdcIHoNUuL
	hmRtmumknQww0br0DoAbCV0EAXuZej26lsfJc+ue8Q8zkHmAr2wEfBmJJRloeC3E+SdA2e8fmCw4r
	OYIu55b91lJ95ItBOHuOJPdLyj3SIqC+xf79QmhWdQgrnBjreeP8i2C2AnrwZ5YH8Klg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXHDj-0004se-Ei;
	Wed, 10 Jun 2026 11:35:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXHDK-0004qV-V1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:35:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/fmxF/SKtni/NyrmH5U69CHG6dguWoruOo68XDcr+vs=; b=A5FozGQYhTCezCRgQ/1QMjYTko
 SiaisAGyg4N5Nf9f55nIY+b2glgTOo26w9t1ZMEV+p9MijCdnCDwSsu0Jb7VcEOQBMeUWMQ1q4yD3
 sWhOMFHgjsP8lJhNoPP/75I1tGyu0rRimapivJfQqfOHbzRl91g2xfvvcBsDOEcgJS4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/fmxF/SKtni/NyrmH5U69CHG6dguWoruOo68XDcr+vs=; b=f
 8xRCr9EC3UU23oZik70N/xRdoO8jlUt3rCkWKSlVnBgaQZHx0+5sfSWJYh2d5bIPfNc9TyzFC+FNd
 k0fnLKFkuswyml+TFRF5Q2jqUJmU48z7QW34y6f5JDU4mq16khNFec31BpJVtVMU+47XhHvY8cKBD
 mfOFv405Fiy8T1gY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXHDA-0000h3-NE for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:35:13 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490e1904089so152175e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 04:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781091298; x=1781696098; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/fmxF/SKtni/NyrmH5U69CHG6dguWoruOo68XDcr+vs=;
 b=Ots2tSpVP6u34tiucjNYH6BwhJOCiFR44y5hvigJxktr9iWPi33v7/BmzBMOmUe0HF
 axH5RRDE59kOLtIJllPj2ILNqrkyqMQqaz9MFhf6MyzLhJNFEu+OazsUEOZNR1Nxgv8R
 SAgq+5YL+N/2HxvC0W1bFHfkIHD1g49GNCE4SvJgY0i+k0mEjJngTOw9UYpzgYu0QnGO
 8N4LOvJ5Yag8tHTpwjADtPNtqNvZI7058eQIpYZR6YkVes1O+MAUc6V7XdWBhVjhYPqy
 Zyu51SPZlonRQy+M42XfF2ZyF9cRDQcYMGbouhbU8rswnwein+XQr1dzTAnn18FJEuwz
 QMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091298; x=1781696098;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/fmxF/SKtni/NyrmH5U69CHG6dguWoruOo68XDcr+vs=;
 b=Fwzo7YJq7dJla1D5q/NdW4JZeGl4kN2rcDt1UytbQxP445SE7nAp+0dkmqvOG6axLb
 od5tmnPjgLCJVdlRfQgdtYOSgOprHEB19d+6kaBUsNMoDdMnabXvFyhZP0VsBx9K94oT
 dJj/Jcmk8YGUc67dW/f+eew8ygKc5SEenUClRUt81e/10VNDeOfZzfkOtgApd8AHmxnb
 WvBG1eOsaOInNSGxoRv7HzxJWdElfoxfooZzsXeNdbhbbMkpOkOarb5nkOzdIBID/QWY
 ph1hpU647zdXq+8gYcaUXJkXOvn9yyP63QCF86wCpfJ+fhN1sNJ73/RPpMIEaL/f7grd
 mAdA==
X-Gm-Message-State: AOJu0YxjtWnNlO+XdG8uMDsC2aP/vFMvqykMaCW3aM3Q8CoqPnHGz7OP
 TKwhZzMwIpUhNXjCWs7qNHpOMz0raPRw+UCZw59Cvtx+nzksNbNdwx8ZhqSzagM2/nKn2kJ6cW/
 Bqhl1+EhDLWwlJ0esfz3Zk6l/DKrjNZf5EZpq0+zsg1B6GIzdtdb6vmmUSL56DGkqYU7Qaq2HIY
 muhLirXg==
X-Gm-Gg: Acq92OHm76mkOScCEjguuwbmYhYMZkOCHQCAwHa2/DZH73NGet8trYVNr1LPsd1Hj5i
 HaKQ4cy1+jpd67pCmmfAZXWfPOGHRuqKLAJx1GadQiuIkCvYfVj70nTNSMPrPvam2/sxRdsdR9T
 nBfO/wpkcnHDcIZB3BOQqRvayO0x0gUfNgeRGJJUGor7FJ1hUBkKgNWVqAdm2oRcCwwKALWsVnw
 KBlJcK0Oj6qi4xVNoxo5IP9Xrv0k0+fMsWRXLaU8r1rLc78oKdHjSp6jl6GMTWnitCbD+X0O6dg
 3oD1RZ1M9FgzONLAb3Praw0B+/ePLge0w624ZADDZ4rq/4TwI9eBBwr0JTDxFivtHpTv9JkIEZ7
 2darjrdiK3qBvGGpBe6GgtBv35iH3t0Hvd+fG1yhFo8mImiQlWiFkhBVnsOeYx2sOAJADLNNGF8
 BexnQcgpvHvLHtDebSk7sgXjPQWS3/cyJNRSiUMpLI4Uzugw05CwLhYFjEXYlTW8efue8dH2FmG
 /Sw8OaTkBFw80P5730BrW+rmM+uCTA53ItQxh4d4xQCFpcSIZeTUXoNtgKoqSpeN79BGEtBvB9C
 D6P3tRd0ZPNP1L7pgYkY2jOX
X-Received: by 2002:a05:600c:45c6:b0:490:b9fe:e64d with SMTP id
 5b1f17b1804b1-490c2612b7fmr405993995e9.23.1781091297147; 
 Wed, 10 Jun 2026 04:34:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc413541sm598555745e9.14.2026.06.10.04.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:34:56 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 11:34:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
X-Gerrit-Change-Number: 1521
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1521?usp=email>
X-Gerrit-Commit: 8d6e298c87a5a6cf4ac0b094eee0388809af6346
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@gerrit.openvpn.net>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcwOTg2MTE4MDAwLkk4YjBkMWNhZDcwNjI4NTZhYmNjNDBjNGUxNmVjOTNiNDUyOTViYmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a2bb09c50d6fdc8638c84f3858b1ce89bfb3787-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXHDA-0000h3-NE
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1362501230513947116=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1362501230513947116==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="47cvmmVc6kM="; charset=UTF-8

--47cvmmVc6kM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos=2E

Hello flicht=
enheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit

  =
  http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail

to look at th=
e new patch set (#12)=2E

The change is no longer submittable: checks~Check=
sSubmitRule is unsatisfied now=2E


Change subject: Add support for user de=
fined network namespace
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Add support for user defined network namespace

Introduce the --=
netns option to allow interface creation
into a user-defined network namesp=
ace=2E
This allows the VPN data plane to be isolated from the main
OpenVPN =
process namespace=2E

The current netlink library integration supports inte=
rface creation
and deletion in a target namespace=2E However, subsequent co=
nfiguration
operations (e=2Eg=2E address or mtu set) are executed in the ca=
ller's
namespace, as they rely on the default netlink socket context=2E
As =
a result, interface-related configuration performed after creation
may be a=
pplied in the wrong namespace=2E
Introduce helper functions to temporarily =
switch the process to the
requested network namespace using setns(2), execu=
te the required
netlink operations, and then restore the original namespace=
=2E
The namespace switch is temporary and scoped to each netlink
operation=
=2E Once the operation completes, the original namespace
is restored to pre=
serve the process execution context=2E

Note: This feature is Linux-only an=
d depends on setns(2)=2E
It is not compatible (yet) with Data Channel Offlo=
ad (DCO)=2E

Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Signed-of=
f-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M doc/man-sectio=
ns/vpn-network-options=2Erst
M src/openvpn/dco=2Ec
M src/openvpn/networking=
=2Eh
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/networking_sitnl=2Eh
=
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/tun=2Ec
8=
 files changed, 605 insertions(+), 83 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/1521/12

diff --git a/doc/m=
an-sections/vpn-network-options=2Erst b/doc/man-sections/vpn-network-option=
s=2Erst
index 33ebedb=2E=2E181c990 100644
--- a/doc/man-sections/vpn-networ=
k-options=2Erst
+++ b/doc/man-sections/vpn-network-options=2Erst
@@ -304,6 =
+304,12 @@
   Specify the link layer address, more commonly known as the MA=
C address=2E
   Only applied to TAP devices=2E
 
+--netns name
+  Specify t=
he network namespace in which the tunnel interface will be created=2E
+  Th=
e namespace must already exist=2E
+
+  (Supported on Linux only, on other p=
latforms this is a no-op)=2E
+
 --persist-tun
   Don't close and reopen TUN=
/TAP device or run up/down scripts across
   :code:`SIGUSR1` or ``--ping-re=
start`` restarts=2E
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
=
index f5b7081=2E=2Efbefcb6 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openv=
pn/dco=2Ec
@@ -389,6 +389,12 @@
                 ret);
         }
     }
+
=
+    if (o->netns)
+    {
+        msg(msglevel, "Note: --netns not support=
ed by DCO, disabling data channel offload=2E");
+        return false;
+   =
 }
 #endif /* if defined(_WIN32) */
 
 #if defined(HAVE_LIBCAPNG)
diff --gi=
t a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index bce0c19=
=2E=2Efab6bbf 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/net=
working=2Eh
@@ -39,10 +39,10 @@
 typedef void *openvpn_net_iface_t;
 #endif=
 /* ifdef ENABLE_SITNL */
 
-/* Only the iproute2 backend implements these =
functions,
+/* Only the iproute2 and sitnl backend implements these functio=
ns,
  * the rest can rely on these stubs
  */
-#if !defined(ENABLE_IPROUTE)=

+#if !defined(ENABLE_IPROUTE) && !defined(ENABLE_SITNL) || defined(TARGET_=
ANDROID)
 static inline int
 net_ctx_init(struct context *c, openvpn_net_ct=
x_t *ctx)
 {
@@ -63,7 +63,7 @@
 {
     (void)ctx;
 }
-#endif /* !defined(EN=
ABLE_IPROUTE) */
+#endif /* !defined(ENABLE_IPROUTE) && !defined(ENABLE_SIT=
NL) || defined(TARGET_ANDROID) */
 
 #if defined(ENABLE_SITNL) || defined(E=
NABLE_IPROUTE)
 
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvp=
n/networking_sitnl=2Ec
index b3f8e2b=2E=2Eb60131f 100644
--- a/src/openvpn/=
networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -33,14 +33,1=
7 @@
 #include "networking=2Eh"
 #include "proto=2Eh"
 #include "route=2Eh"=

+#include "openvpn=2Eh"
 
 #include <errno=2Eh>
 #include <string=2Eh>
 #i=
nclude <unistd=2Eh>
+#include <sched=2Eh>
 #include <sys/types=2Eh>
 #inclu=
de <sys/socket=2Eh>
 #include <linux/netlink=2Eh>
 #include <linux/rtnetlin=
k=2Eh>
+#include <linux/net_namespace=2Eh>
 
 #define SNDBUF_SIZE (1024 * 2=
)
 #define RCVBUF_SIZE (1024 * 4)
@@ -65,6 +68,12 @@
         _nest->rta_le=
n =3D (unsigned short)((void *)sitnl_nlmsg_tail(_msg) - (void *)_nest); \
 =
    }
 
+#define SITNL_NETNS_RTA(r) \
+    ((struct rtattr *)(((char *)(r))=
 + NLMSG_ALIGN(sizeof(struct rtgenmsg))))
+
+#define NETNS_RUN_DIR  "/run/n=
etns"
+#define NETNS_ORIG_DIR "/proc/self/ns/net"
+
 /* This function was o=
riginally implemented as a macro, but compiling with
  * gcc and -O3 was ge=
tting confused about the math and thus raising
  * security warnings on sub=
sequent memcpy() calls=2E
@@ -121,6 +130,16 @@
     char buf[256];
 };
 
+/=
**
+ * Network namespace NSID request message
+ */
+struct sitnl_nsid_req
+=
{
+    struct nlmsghdr n;
+    struct rtgenmsg g;
+    char buf[256];
+};
+=

 typedef int (*sitnl_parse_reply_cb)(struct nlmsghdr *msg, void *arg);
 
 =
/**
@@ -156,6 +175,105 @@
     return 0;
 }
 
+#if defined(TARGET_LINUX) &&=
 defined(ENABLE_SITNL)
+
+static int netns_id_from_name_sitnl(const char *n=
ame);
+static int set_netns_id_from_name_sitnl(const char *name);
+
+int
+n=
et_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+{
+    struct stat =
st;
+    char path[PATH_MAX];
+
+    ctx->netns =3D NULL;
+
+    if (c && c=
->options=2Enetns)
+    {
+        snprintf(path, sizeof(path), "%s/%s", NE=
TNS_RUN_DIR, c->options=2Enetns);
+
+        if (stat(path, &st) !=3D 0)
+ =
       {
+            msg(M_ERR, "%s: Network namespace %s does not exist",=
 __func__, path);
+        }
+
+        ctx->netns =3D c->options=2Enetns;
=
+    }
+
+    ctx->gc =3D gc_new();
+    return 0;
+}
+
+void
+net_ctx_rese=
t(openvpn_net_ctx_t *ctx)
+{
+    gc_reset(&ctx->gc);
+}
+
+void
+net_ctx_f=
ree(openvpn_net_ctx_t *ctx)
+{
+    gc_free(&ctx->gc);
+}
+
+int
+netns_swi=
tch(openvpn_net_ctx_t *ctx)
+{
+    char net_path[PATH_MAX];
+    int orig_=
fd =3D -1, netns_fd;
+    const char *netns =3D ctx ? ctx->netns : NULL;
+
=
+    if (!netns)
+    {
+        return -1;
+    }
+
+    /* Save current n=
etns descriptor */
+    orig_fd =3D open(NETNS_ORIG_DIR, O_RDONLY | O_CLOEX=
EC);
+    if (orig_fd < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: Canno=
t open original network namespace", __func__);
+        return -1;
+    }
+=

+    snprintf(net_path, sizeof(net_path), "%s/%s", NETNS_RUN_DIR, netns);
=
+    netns_fd =3D open(net_path, O_RDONLY | O_CLOEXEC);
+    if (netns_fd <=
 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: Cannot open network namespac=
e \"%s\"", __func__, netns);
+        close(orig_fd);
+        return -1;
+=
    }
+
+    if (setns(netns_fd, CLONE_NEWNET) < 0)
+    {
+        msg(M_W=
ARN | M_ERRNO, "%s: setting the network namespace \"%s\" failed", __func__,=
 netns);
+        close(netns_fd);
+        close(orig_fd);
+        return=
 -1;
+    }
+
+    close(netns_fd);
+    return orig_fd;
+}
+
+void
+netns_=
restore(int orig_fd)
+{
+    if (orig_fd < 0)
+    {
+        return;
+    =
}
+
+    if (setns(orig_fd, CLONE_NEWNET) < 0)
+    {
+        msg(M_WARN |=
 M_ERRNO, "%s: Cannot restore original network namespace", __func__);
+    =
}
+
+    close(orig_fd);
+}
+#endif /* defined (TARGET_LINUX) && defined (E=
NABLE_SITNL) */
+
 /**
  * Open RTNL socket
  */
@@ -445,6 +563,285 @@
    =
 return ret;
 }
 
+#ifdef ENABLE_SITNL
+/**
+ * Netlink callback to extract=
 the interface index from a RTM_NEWLINK message=2E
+ *
+ * This function is=
 used as a Netlink response handler=2E It inspects incoming
+ * Netlink mes=
sages and, when a RTM_NEWLINK message is received, copies the
+ * contained=
 `struct ifinfomsg` into the caller-provided result structure=2E
+ *
+ * @p=
aram n    Netlink message header received from the kernel=2E
+ * @param arg=
  Pointer to a `struct sitnl_link_req` used to store the result=2E
+ *
+ * =
@return 0 to stop Netlink message processing once the interface is found,
+=
 *         1 to continue processing other messages=2E
+ */
+static int
+sit=
nl_link_get_ifindex(struct nlmsghdr *n, void *arg)
+{
+    struct sitnl_lin=
k_req *res =3D arg;
+    struct ifinfomsg *ifi;
+
+    if (n->nlmsg_type !=
=3D RTM_NEWLINK)
+    {
+        return 1;
+    }
+
+    ifi =3D NLMSG_DATA=
(n);
+    res->i =3D *ifi;
+
+    return 0;
+}
+
+/**
+ * Retrieve the inte=
rface index of a network device in a specific network namespace=2E
+ *
+ * =
Sends an RTM_GETLINK Netlink request targeting the given network namespace =
ID
+ * and interface name, and extracts the resulting interface index from =
the kernel
+ * response=2E
+ *
+ * On failure, this function returns 0, mat=
ching the behavior of
+ * `if_nametoindex()`=2E
+ *
+ * @param ifname   Nam=
e of the network interface=2E
+ * @param netnsid  Target network namespace =
ID=2E
+ *
+ * @return Interface index on success, or 0 on error=2E
+ */
+st=
atic int
+get_ifindex_in_netns(const char *ifname, int netnsid)
+{
+    str=
uct sitnl_link_req req;
+    struct sitnl_link_req res;
+    int ret =3D -1=
, ifindex =3D 0;
+
+    CLEAR(req);
+    CLEAR(res);
+
+    req=2En=2Enlmsg=
_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
+    req=2En=2Enlmsg_type =3D RTM_G=
ETLINK;
+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
+
+    SITNL_ADDATTR(=
&req=2En, sizeof(req), IFLA_TARGET_NETNSID, &netnsid, sizeof(int));
+    SI=
TNL_ADDATTR(&req=2En, sizeof(req), IFLA_IFNAME, ifname, strlen(ifname) + 1)=
;
+
+    ret =3D sitnl_send(&req=2En, 0, 0, sitnl_link_get_ifindex, &res);
=
+
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    ifindex =3D r=
es=2Ei=2Eifi_index;
+
+err:
+    return ifindex;
+}
+
+static void
+sitnl_p=
arse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta, size=
_t len,
+                         unsigned short flags)
+{
+    unsigned sh=
ort type;
+
+    memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
+
+   =
 while (RTA_OK(rta, len))
+    {
+        type =3D rta->rta_type & ~flags;
=
+
+        if ((type <=3D max) && (!tb[type]))
+        {
+            tb[t=
ype] =3D rta;
+        }
+
+        rta =3D RTA_NEXT(rta, len);
+    }
+
+ =
   if (len)
+    {
+        msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_le=
n=3D%u)", __func__, len, rta->rta_len);
+    }
+}
+
+static void
+sitnl_par=
se_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len)
=
+{
+    sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
+}
+
+#define sitnl=
_parse_rtattr_nested(tb, max, rta) \
+    (sitnl_parse_rtattr_flags(tb, max=
, RTA_DATA(rta), RTA_PAYLOAD(rta), NLA_F_NESTED))
+
+/**
+ * Netlink callba=
ck to extract and store a network namespace ID (NSID)=2E
+ *
+ * This funct=
ion processes Netlink responses to RTM_GETNSID requests=2E
+ * If a NETNSA_=
NSID attribute is present, its value is copied into the
+ * caller-provided=
 storage=2E
+ *
+ * If a Netlink error message is received, the contained e=
rror code is
+ * returned directly=2E
+ *
+ * @param n    Netlink message h=
eader received from the kernel=2E
+ * @param arg  Pointer to an integer whe=
re the NSID will be stored=2E
+ *
+ * @return 0 on success, a negative erro=
r code on failure=2E
+ */
+static int
+sitnl_nsid_save(struct nlmsghdr *n, =
void *arg)
+{
+    int *nsid =3D arg;
+    struct rtgenmsg *g =3D NLMSG_DAT=
A(n);
+    struct rtattr *tb[NETNSA_MAX + 1];
+
+    if (n->nlmsg_type =3D=
=3D NLMSG_ERROR)
+    {
+        struct nlmsgerr *err =3D NLMSG_DATA(n);
+ =
       return err->error;
+    }
+
+    sitnl_parse_rtattr(tb, NETNSA_MAX, =
SITNL_NETNS_RTA(g), NLMSG_PAYLOAD(n, sizeof(*g)));
+
+    if (!tb[NETNSA_NS=
ID])
+    {
+        return -ENOENT;
+    }
+
+    memcpy(nsid, RTA_DATA(tb=
[NETNSA_NSID]), sizeof(*nsid));
+    return 0;
+}
+
+/**
+ * Retrieve the n=
etwork namespace ID (NSID) associated with a namespace name=2E
+ *
+ * This=
 function opens the network namespace identified by the given path
+ * and =
sends an RTM_GETNSID Netlink request to retrieve its assigned NSID=2E
+ *
+=
 * @param name  Name of the network namespace=2E
+ *
+ * @return The networ=
k namespace ID on success, or a negative value on failure=2E
+ */
+static i=
nt
+netns_id_from_name_sitnl(const char *name)
+{
+    struct sitnl_nsid_re=
q req;
+
+    int netnsid =3D -1;
+    CLEAR(req);
+
+    int netns_fd =3D =
open(name, O_RDONLY);
+    if (netns_fd < 0)
+    {
+        goto err;
+   =
 }
+
+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Eg));
+    req=
=2En=2Enlmsg_type =3D RTM_GETNSID;
+    req=2En=2Enlmsg_flags =3D NLM_F_REQ=
UEST;
+    req=2Eg=2Ertgen_family =3D AF_UNSPEC;
+
+    SITNL_ADDATTR(&req=
=2En, sizeof(req), NETNSA_FD, &netns_fd, sizeof(int));
+
+    sitnl_send(&r=
eq=2En, 0, 0, sitnl_nsid_save, &netnsid);
+
+err:
+    if (netns_fd >=3D 0)=

+    {
+        close(netns_fd);
+    }
+    return netnsid;
+}
+
+/**
+ *=
 Assign a network namespace ID (NSID) to a namespace=2E
+ *
+ * This functi=
on sends an RTM_NEWNSID Netlink request to associate a
+ * NSID with the ne=
twork namespace identified by the given path=2E
+ *
+ * @param name  Name o=
f the network namespace=2E
+ *
+ * @return 0 on success, or a negative erro=
r code on failure=2E
+ */
+static int
+set_netns_id_from_name_sitnl(const c=
har *name)
+{
+    struct sitnl_nsid_req req;
+
+    int ret =3D -1, netnsi=
d =3D -1;
+    CLEAR(req);
+
+    int netns_fd =3D open(name, O_RDONLY);
+ =
   if (netns_fd < 0)
+    {
+        goto err;
+    }
+
+    req=2En=2Enlms=
g_len =3D NLMSG_LENGTH(sizeof(req=2Eg));
+    req=2En=2Enlmsg_type =3D RTM_=
NEWNSID;
+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
+    req=2Eg=2Ertgen=
_family =3D AF_UNSPEC;
+
+    SITNL_ADDATTR(&req=2En, sizeof(req), NETNSA_F=
D, &netns_fd, sizeof(int));
+    SITNL_ADDATTR(&req=2En, sizeof(req), NETNS=
A_NSID, &netnsid, sizeof(int));
+
+    ret =3D sitnl_send(&req=2En, 0, 0, N=
ULL, NULL);
+
+err:
+    if (netns_fd >=3D 0)
+    {
+        close(netns_f=
d);
+    }
+    return ret;
+}
+
+int
+get_or_create_netnsid_sitnl(const ch=
ar *name)
+{
+    char net_path[PATH_MAX];
+    int netnsid;
+    snprintf(=
net_path, sizeof(net_path), "%s/%s", NETNS_RUN_DIR, name);
+
+    /* First =
get */
+    netnsid =3D netns_id_from_name_sitnl(net_path);
+    if (netnsi=
d >=3D 0)
+    {
+        return netnsid;
+    }
+
+    /* No netnsid yet? =
Try to assign one */
+    netnsid =3D set_netns_id_from_name_sitnl(net_path=
);
+    if (netnsid < 0)
+    {
+        return -1;
+    }
+
+    /* Second=
 get */
+    netnsid =3D netns_id_from_name_sitnl(net_path);
+    if (netns=
id >=3D 0)
+    {
+        return netnsid;
+    }
+
+    return -1;
+}
+
+i=
nt
+openvpn_if_nametoindex(const char *ifname, openvpn_net_ctx_t *ctx)
+{
+=
    const char *netns =3D ctx ? ctx->netns : NULL;
+    int netnsid =3D get=
_or_create_netnsid_sitnl(netns);
+
+    if (netnsid < 0)
+    {
+        re=
turn if_nametoindex(ifname);
+    }
+
+    return get_ifindex_in_netns(ifna=
me, netnsid);
+}
+#endif /* ifdef ENABLE_SITNL */
+
 typedef struct
 {
    =
 size_t addr_size;
@@ -652,7 +1049,7 @@
 net_iface_up(openvpn_net_ctx_t *ct=
x, const char *iface, bool up)
 {
     struct sitnl_link_req req;
-    int =
ifindex;
+    int ifindex, orig =3D -1;
 
     CLEAR(req);
 
@@ -662,13 +10=
59,15 @@
         return -EINVAL;
     }
 
-    ifindex =3D if_nametoindex(=
iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
     if (ifind=
ex =3D=3D 0)
     {
-        msg(M_WARN, "%s: rtnl: cannot get ifindex for =
%s: %s", __func__, iface, strerror(errno));
+        msg(M_WARN | M_ERRNO, =
"%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -E=
NOENT;
     }
 
+    orig =3D netns_switch(ctx);
+
     req=2En=2Enlmsg_len=
 =3D NLMSG_LENGTH(sizeof(req=2Ei));
     req=2En=2Enlmsg_flags =3D NLM_F_RE=
QUEST;
     req=2En=2Enlmsg_type =3D RTM_NEWLINK;
@@ -687,24 +1086,30 @@
 
=
     msg(M_INFO, "%s: set %s %s", __func__, iface, up ? "up" : "down");
 
-=
    return sitnl_send(&req=2En, 0, 0, NULL, NULL);
+    int ret =3D sitnl_s=
end(&req=2En, 0, 0, NULL, NULL);
+
+    netns_restore(orig);
+
+    return =
ret;
 }
 
 int
 net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface=
, uint32_t mtu)
 {
     struct sitnl_link_req req;
-    int ifindex, ret =
=3D -1;
+    int ifindex, orig =3D -1, ret =3D -1;
 
     CLEAR(req);
 
-  =
  ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoinde=
x(iface, ctx);
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ER=
RNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
         retu=
rn -1;
     }
 
+    orig =3D netns_switch(ctx);
+
     req=2En=2Enlmsg_len=
 =3D NLMSG_LENGTH(sizeof(req=2Ei));
     req=2En=2Enlmsg_flags =3D NLM_F_RE=
QUEST;
     req=2En=2Enlmsg_type =3D RTM_NEWLINK;
@@ -717,7 +1122,9 @@
    =
 msg(M_INFO, "%s: mtu %u for %s", __func__, mtu, iface);
 
     ret =3D sit=
nl_send(&req=2En, 0, 0, NULL, NULL);
+
 err:
+    netns_restore(orig);
    =
 return ret;
 }
 
@@ -725,17 +1132,19 @@
 net_addr_ll_set(openvpn_net_ctx_t=
 *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
 {
     struct sitn=
l_link_req req;
-    int ifindex, ret =3D -1;
+    int ifindex, orig =3D -1=
, ret =3D -1;
 
     CLEAR(req);
 
-    ifindex =3D if_nametoindex(iface);
=
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
     if (ifindex =3D=
=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex =
for %s", __func__, iface);
         return -1;
     }
 
+    orig =3D netns=
_switch(ctx);
+
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));=

     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
     req=2En=2Enlmsg_type =
=3D RTM_NEWLINK;
@@ -748,17 +1157,19 @@
     msg(M_INFO, "%s: lladdr " MAC_=
FMT " for %s", __func__, MAC_PRINT_ARG(addr), iface);
 
     ret =3D sitnl_=
send(&req=2En, 0, 0, NULL, NULL);
+
 err:
+    netns_restore(orig);
     re=
turn ret;
 }
 
 static int
-sitnl_addr_set(uint16_t cmd, uint16_t flags, in=
t ifindex, sa_family_t af_family,
+sitnl_addr_set(openvpn_net_ctx_t *ctx, u=
int16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family,
          =
      const inet_address_t *local, const inet_address_t *remote, int prefix=
len)
 {
     struct sitnl_addr_req req;
     uint32_t size;
-    int ret =
=3D -EINVAL;
+    int ret =3D -EINVAL, orig =3D -1;
 
     CLEAR(req);
 
@@=
 -810,17 +1221,22 @@
         SITNL_ADDATTR(&req=2En, sizeof(req), IFA_BROA=
DCAST, &broadcast, size);
     }
 
+    orig =3D netns_switch(ctx);
+
     =
ret =3D sitnl_send(&req=2En, 0, 0, NULL, NULL);
+
     if (ret =3D=3D -EEXI=
ST)
     {
         ret =3D 0;
     }
+
 err:
+    netns_restore(orig);
   =
  return ret;
 }
 
 static int
-sitnl_addr_ptp_add(sa_family_t af_family, c=
onst char *iface, const inet_address_t *local,
+sitnl_addr_ptp_add(openvpn_=
net_ctx_t *ctx, sa_family_t af_family, const char *iface, const inet_addres=
s_t *local,
                    const inet_address_t *remote)
 {
     int i=
findex;
@@ -841,19 +1257,19 @@
         return -EINVAL;
     }
 
-    ifind=
ex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface=
, ctx);
     if (ifindex =3D=3D 0)
     {
-        msg(M_WARN, "%s: cannot =
get ifindex for %s: %s", __func__, np(iface), strerror(errno));
+        ms=
g(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, np(iface));
=
         return -ENOENT;
     }
 
-    return sitnl_addr_set(RTM_NEWADDR, N=
LM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,
+    return sitnl_a=
ddr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family,=
 local,
                           remote, 0);
 }
 
 static int
-sitnl_addr=
_ptp_del(sa_family_t af_family, const char *iface, const inet_address_t *lo=
cal)
+sitnl_addr_ptp_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, con=
st char *iface, const inet_address_t *local)
 {
     int ifindex;
 
@@ -873=
,23 +1289,23 @@
         return -EINVAL;
     }
 
-    ifindex =3D if_namet=
oindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
     if=
 (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: cannot get i=
findex for %s", __func__, iface);
         return -ENOENT;
     }
 
-    re=
turn sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);
+ =
   return sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, local, NU=
LL, 0);
 }
 
 static int
-sitnl_route_set(uint16_t cmd, uint16_t flags, int=
 ifindex, sa_family_t af_family, const void *dst,
+sitnl_route_set(openvpn_=
net_ctx_t *ctx, uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_f=
amily, const void *dst,
                 int prefixlen, const void *gw, enu=
m rt_class_t table, int metric,
                 enum rt_scope_t scope, uns=
igned char protocol, unsigned char type)
 {
     struct sitnl_route_req req=
;
-    int ret =3D -1, size;
+    int ret =3D -1, size, orig =3D -1;
 
    =
 CLEAR(req);
 
@@ -948,14 +1364,17 @@
     {
         SITNL_ADDATTR(&req=2E=
n, sizeof(req), RTA_PRIORITY, &metric, 4);
     }
+    orig =3D netns_switc=
h(ctx);
 
     ret =3D sitnl_send(&req=2En, 0, 0, NULL, NULL);
+
 err:
+   =
 netns_restore(orig);
     return ret;
 }
 
 static int
-sitnl_addr_add(sa_=
family_t af_family, const char *iface, const inet_address_t *addr, int pref=
ixlen)
+sitnl_addr_add(openvpn_net_ctx_t *ctx, sa_family_t af_family, const=
 char *iface, const inet_address_t *addr, int prefixlen)
 {
     int ifinde=
x;
 
@@ -975,19 +1394,19 @@
         return -EINVAL;
     }
 
-    ifindex =
=3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, c=
tx);
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: =
rtnl: cannot get ifindex for %s", __func__, iface);
         return -ENOENT=
;
     }
 
-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REP=
LACE, ifindex, af_family, addr, NULL,
+    return sitnl_addr_set(ctx, RTM_N=
EWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,
     =
                      prefixlen);
 }
 
 static int
-sitnl_addr_del(sa_famil=
y_t af_family, const char *iface, inet_address_t *addr, int prefixlen)
+sit=
nl_addr_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *ifac=
e, inet_address_t *addr, int prefixlen)
 {
     int ifindex;
 
@@ -1007,14 =
+1426,14 @@
         return -EINVAL;
     }
 
-    ifindex =3D if_nametoind=
ex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
     if (if=
index =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get=
 ifindex for %s", __func__, iface);
         return -ENOENT;
     }
 
-    =
return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefi=
xlen);
+    return sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, =
addr, NULL, prefixlen);
 }
 
 int
@@ -1033,7 +1452,7 @@
     msg(M_INFO, "%=
s: %s/%d dev %s", __func__, inet_ntop(AF_INET, &addr_v4=2Eipv4, buf, sizeof=
(buf)),
         prefixlen, iface);
 
-    return sitnl_addr_add(AF_INET, i=
face, &addr_v4, prefixlen);
+    return sitnl_addr_add(ctx, AF_INET, iface,=
 &addr_v4, prefixlen);
 }
 
 int
@@ -1053,7 +1472,7 @@
     msg(M_INFO, "%s=
: %s/%d dev %s", __func__, inet_ntop(AF_INET6, &addr_v6=2Eipv6, buf, sizeof=
(buf)),
         prefixlen, iface);
 
-    return sitnl_addr_add(AF_INET6, =
iface, &addr_v6, prefixlen);
+    return sitnl_addr_add(ctx, AF_INET6, ifac=
e, &addr_v6, prefixlen);
 }
 
 int
@@ -1072,7 +1491,7 @@
     msg(M_INFO, "=
%s: %s dev %s", __func__, inet_ntop(AF_INET, &addr_v4=2Eipv4, buf, sizeof(b=
uf)),
         iface);
 
-    return sitnl_addr_del(AF_INET, iface, &addr_v=
4, prefixlen);
+    return sitnl_addr_del(ctx, AF_INET, iface, &addr_v4, pr=
efixlen);
 }
 
 int
@@ -1092,7 +1511,7 @@
     msg(M_INFO, "%s: %s/%d dev %=
s", __func__, inet_ntop(AF_INET6, &addr_v6=2Eipv6, buf, sizeof(buf)),
     =
    prefixlen, iface);
 
-    return sitnl_addr_del(AF_INET6, iface, &addr_=
v6, prefixlen);
+    return sitnl_addr_del(ctx, AF_INET6, iface, &addr_v6, =
prefixlen);
 }
 
 int
@@ -1120,7 +1539,7 @@
         inet_ntop(AF_INET, &lo=
cal_v4=2Eipv4, buf1, sizeof(buf1)),
         inet_ntop(AF_INET, &remote_v4=
=2Eipv4, buf2, sizeof(buf2)), iface);
 
-    return sitnl_addr_ptp_add(AF_I=
NET, iface, &local_v4, &remote_v4);
+    return sitnl_addr_ptp_add(ctx, AF_=
INET, iface, &local_v4, &remote_v4);
 }
 
 int
@@ -1141,11 +1560,11 @@
    =
 msg(M_INFO, "%s: %s dev %s", __func__, inet_ntop(AF_INET, &local_v4=2Eipv4=
, buf, sizeof(buf)),
         iface);
 
-    return sitnl_addr_ptp_del(AF_I=
NET, iface, &local_v4);
+    return sitnl_addr_ptp_del(ctx, AF_INET, iface,=
 &local_v4);
 }
 
 static int
-sitnl_route_add(const char *iface, sa_family=
_t af_family, const void *dst, int prefixlen,
+sitnl_route_add(openvpn_net_=
ctx_t *ctx, const char *iface, sa_family_t af_family, const void *dst, int =
prefixlen,
                 const void *gw, uint32_t table, int metric)
 {
=
     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;
@@ -1153,7 +1572,7 @@
 
 =
    if (iface)
     {
-        ifindex =3D if_nametoindex(iface);
+        =
ifindex =3D openvpn_if_nametoindex(iface, ctx);
         if (ifindex =3D=3D=
 0)
         {
             msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifin=
dex for %s", __func__, iface);
@@ -1171,7 +1590,7 @@
         scope =3D RT_=
SCOPE_LINK;
     }
 
-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE=
, ifindex, af_family, dst, prefixlen, gw,
+    return sitnl_route_set(ctx, =
RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,
       =
                     table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
=
@@ -1200,7 +1619,7 @@
         inet_ntop(AF_INET, &dst_be, dst_str, sizeof(=
dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw=
_str)), np(iface), table, metric);
 
-    return sitnl_route_add(iface, AF_=
INET, dst_ptr, prefixlen, gw_ptr, table, metric);
+    return sitnl_route_a=
dd(ctx, iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table, metric);
 }
 
 i=
nt
@@ -1226,18 +1645,18 @@
         inet_ntop(AF_INET6, &dst_v6=2Eipv6, dst=
_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6=2Eip=
v6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
-    return sitnl=
_route_add(iface, AF_INET6, dst, prefixlen, gw, table, metric);
+    return=
 sitnl_route_add(ctx, iface, AF_INET6, dst, prefixlen, gw, table, metric);
=
 }
 
 static int
-sitnl_route_del(const char *iface, sa_family_t af_family,=
 inet_address_t *dst, int prefixlen,
+sitnl_route_del(openvpn_net_ctx_t *ct=
x, const char *iface, sa_family_t af_family, inet_address_t *dst, int prefi=
xlen,
                 inet_address_t *gw, uint32_t table, int metric)
 {
 =
    int ifindex =3D 0;
 
     if (iface)
     {
-        ifindex =3D if_nam=
etoindex(iface);
+        ifindex =3D openvpn_if_nametoindex(iface, ctx);
 =
        if (ifindex =3D=3D 0)
         {
             msg(M_WARN | M_ERRNO,=
 "%s: rtnl: can't get ifindex for %s", __func__, iface);
@@ -1250,7 +1669,7=
 @@
         table =3D RT_TABLE_MAIN;
     }
 
-    return sitnl_route_set(=
RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,
+  =
  return sitnl_route_set(ctx, RTM_DELROUTE, 0, ifindex, af_family, dst, pre=
fixlen, gw, table, metric,
                            RT_SCOPE_NOWHERE, 0,=
 0);
 }
 
@@ -1277,7 +1696,7 @@
         inet_ntop(AF_INET, &dst_v4=2Eipv4,=
 dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_v4=
=2Eipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
-    return =
sitnl_route_del(iface, AF_INET, &dst_v4, prefixlen, &gw_v4, table, metric);=

+    return sitnl_route_del(ctx, iface, AF_INET, &dst_v4, prefixlen, &gw_v=
4, table, metric);
 }
 
 int
@@ -1303,7 +1722,7 @@
         inet_ntop(AF_IN=
ET6, &dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_nt=
op(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metr=
ic);
 
-    return sitnl_route_del(iface, AF_INET6, &dst_v6, prefixlen, &gw=
_v6, table, metric);
+    return sitnl_route_del(ctx, iface, AF_INET6, &dst=
_v6, prefixlen, &gw_v6, table, metric);
 }
 
 
@@ -1347,45 +1766,11 @@
    =
 msg(D_ROUTE, "%s: add %s type %s", __func__, iface, type);
 
     ret =3D =
sitnl_send(&req=2En, 0, 0, NULL, NULL);
+
 err:
     return ret;
 }
 
-stat=
ic void
-sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct r=
tattr *rta, size_t len,
-                         unsigned short flags)
-{
=
-    unsigned short type;
-
-    memset(tb, 0, sizeof(struct rtattr *) * (m=
ax + 1));
-
-    while (RTA_OK(rta, len))
-    {
-        type =3D rta->rta=
_type & ~flags;
-
-        if ((type <=3D max) && (!tb[type]))
-        {
-=
            tb[type] =3D rta;
-        }
-
-        rta =3D RTA_NEXT(rta, l=
en);
-    }
-
-    if (len)
-    {
-        msg(D_ROUTE, "%s: %zu bytes not=
 parsed! (rta_len=3D%u)", __func__, len, rta->rta_len);
-    }
-}
-
-static=
 void
-sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *r=
ta, size_t len)
-{
-    sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
-}
=
-
-#define sitnl_parse_rtattr_nested(tb, max, rta) \
-    (sitnl_parse_rtat=
tr_flags(tb, max, RTA_DATA(rta), RTA_PAYLOAD(rta), NLA_F_NESTED))
-
 static=
 int
 sitnl_type_save(struct nlmsghdr *n, void *arg)
 {
@@ -1416,13 +1801,1=
6 @@
 net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[I=
FACE_TYPE_LEN_MAX])
 {
     struct sitnl_link_req req =3D {};
-    int ifin=
dex =3D if_nametoindex(iface);
+    int ifindex =3D openvpn_if_nametoindex(=
iface, ctx);
+    int orig =3D -1;
 
     if (!ifindex)
     {
         ret=
urn -errno;
     }
 
+    orig =3D netns_switch(ctx);
+
     req=2En=2Enlms=
g_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
     req=2En=2Enlmsg_flags =3D NLM=
_F_REQUEST;
     req=2En=2Enlmsg_type =3D RTM_GETLINK;
@@ -1435,26 +1823,32=
 @@
     int ret =3D sitnl_send(&req=2En, 0, 0, sitnl_type_save, type);
   =
  if (ret < 0)
     {
+        netns_restore(orig);
         msg(D_ROUTE, "=
%s: cannot retrieve iface %s: %s (%d)", __func__, iface, strerror(-ret), re=
t);
         return ret;
     }
 
     msg(D_ROUTE, "%s: type of %s: %s", _=
_func__, iface, type);
 
+    netns_restore(orig);
+
     return 0;
 }
 
 i=
nt
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
+    int re=
t =3D -1, orig =3D -1;
     struct sitnl_link_req req =3D {};
-    int ifin=
dex =3D if_nametoindex(iface);
+    int ifindex =3D openvpn_if_nametoindex(=
iface, ctx);
 
     if (!ifindex)
     {
         return -errno;
     }
 
+=
    orig =3D netns_switch(ctx);
+
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH=
(sizeof(req=2Ei));
     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
     req=
=2En=2Enlmsg_type =3D RTM_DELLINK;
@@ -1464,7 +1858,11 @@
 
     msg(D_ROUT=
E, "%s: delete %s", __func__, iface);
 
-    return sitnl_send(&req=2En, 0,=
 0, NULL, NULL);
+    ret =3D sitnl_send(&req=2En, 0, 0, NULL, NULL);
+
+  =
  netns_restore(orig);
+
+    return ret;
 }
 
 #endif /* !ENABLE_SITNL */
=
diff --git a/src/openvpn/networking_sitnl=2Eh b/src/openvpn/networking_sitn=
l=2Eh
index 481cc36=2E=2E7e723fe 100644
--- a/src/openvpn/networking_sitnl=
=2Eh
+++ b/src/openvpn/networking_sitnl=2Eh
@@ -21,7 +21,97 @@
 #ifndef NET=
WORKING_SITNL_H_
 #define NETWORKING_SITNL_H_
 
+#include "env_set=2Eh"
+
 =
typedef char openvpn_net_iface_t;
-typedef void *openvpn_net_ctx_t;
+
+stru=
ct openvpn_net_ctx
+{
+    const char *netns;
+    struct gc_arena gc;
+};
=
+
+typedef struct openvpn_net_ctx openvpn_net_ctx_t;
+
+/**
+ * @brief Swit=
ch the current thread to the network namespace specified
+ *        in the =
given OpenVPN network context=2E
+ *
+ * This function changes the calling =
thread's network namespace to the one
+ * identified by ctx->netns=2E The c=
urrent (original) network namespace file
+ * descriptor is saved and return=
ed, so it can later be restored using
+ * netns_restore()=2E
+ *
+ * If @p =
ctx is NULL or ctx->netns is NULL, the function fails and returns -1=2E
+ *=

+ * The switch is performed using setns(2)=2E This approach is required be=
cause
+ * the netlink library does not support performing operations in an =
arbitrary
+ * target network namespace, except for interface creation and d=
eletion=2E
+ * Therefore, in order to execute generic netlink operations in=
side a
+ * specific network namespace, the thread must temporarily enter
+ =
* that namespace via setns()=2E
+ *
+ * @param ctx  Pointer to an OpenVPN n=
etwork context structure containing
+ *             the target network name=
space name (ctx->netns)=2E The namespace
+ *             is expected to exi=
st under NETNS_RUN_DIR (e=2Eg=2E /run/netns/)=2E
+ *
+ * @return On success=
, returns a file descriptor referring to the original
+ *         network n=
amespace=2E This descriptor must be passed to
+ *         netns_restore() t=
o switch back=2E
+ * @return -1 on failure (an error is logged and no names=
pace switch is kept)=2E
+ *
+ * @note The returned file descriptor must be =
passed to netns_restore(),
+ *       which will restore the original namesp=
ace and close it=2E
+ */
+int netns_switch(openvpn_net_ctx_t *ctx);
+
+/**
=
+ * @brief Restore the previously saved network namespace=2E
+ *
+ * This f=
unction restores the network namespace saved by netns_switch()
+ * using th=
e file descriptor returned by that function=2E
+ *
+ * If @p orig_fd is neg=
ative, the function does nothing and returns
+ * immediately=2E
+ *
+ * The=
 restoration is performed using setns(2), switching the calling
+ * thread =
back to its original network namespace=2E
+ *
+ * @param orig_fd  File desc=
riptor of the original network namespace,
+ *                 as returned b=
y netns_switch()=2E
+ *
+ * @note This function always closes @p orig_fd if=
 it is >=3D 0,
+ *       regardless of whether setns() succeeds or fails=2E=

+ *       After calling this function, @p orig_fd must not be reused=2E
+ =
*/
+void netns_restore(int orig_fd);
+
+/**
+ * Resolve a network interface=
 name to its interface index=2E
+ *
+ * If a valid network namespace ID is =
provided, the lookup is performed inside
+ * that network namespace using N=
etlink=2E Otherwise, this function falls back
+ * to the standard `if_namet=
oindex()` call in the current namespace=2E
+ *
+ * @param ifname   Name of =
the network interface=2E
+ * @param ctx      The network context where we r=
etrieve
+ *                 the network namespace name=2E
+ *
+ * @return I=
nterface index on success, or 0 on error=2E
+ */
+int openvpn_if_nametoinde=
x(const char *ifname, openvpn_net_ctx_t *ctx);
+
+/**
+ * Retrieve or creat=
e a network namespace ID (NSID) for a given namespace=2E
+ *
+ * This funct=
ion first attempts to retrieve the NSID associated with the
+ * specified n=
etwork namespace=2E If no NSID is currently assigned, it
+ * requests the k=
ernel to create one and then retries the lookup=2E
+ *
+ * @param name  Nam=
e of the network namespace=2E
+ *
+ * @return The network namespace ID on s=
uccess, or -1 on failure=2E
+ */
+int get_or_create_netnsid_sitnl(const cha=
r *name);
 
 #endif /* NETWORKING_SITNL_H_ */
diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec
index 62c0bbb=2E=2Eb602dcc 100644
--- a/s=
rc/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6495,6 +6495,14 @@=

         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mtu_test =3D =
true;
     }
+    else if (streq(p[0], "netns") && p[1] && !p[2])
+    {
+#=
ifndef ENABLE_SITNL
+        msg(M_WARN, "NOTE: --netns is supported only o=
n Linux when compiled with SITNL");
+#endif
+        VERIFY_PERMISSION(OPT_=
P_GENERAL);
+        options->netns =3D p[1];
+    }
     else if (streq(p[=
0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE)=
;
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index a111=
cf8=2E=2E88a6dfa 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/opt=
ions=2Eh
@@ -315,6 +315,7 @@
 
     struct dns_options dns_options;
 
+    =
const char *netns;
     bool remote_random;
     const char *ipchange;
    =
 const char *dev;
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
in=
dex e7193d8=2E=2E51d9bed 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn=
/tun=2Ec
@@ -2082,6 +2082,13 @@
     }
     else
     {
+#if defined(TARGET=
_LINUX) && defined(ENABLE_SITNL)
+        int orig_fd =3D -1;
+        if (=
ctx->netns)
+        {
+            orig_fd =3D netns_switch(ctx);
+       =
 }
+#endif /* if defined(TARGET_LINUX) && defined(ENABLE_SITNL) */
        =
 /*
          * Process --dev-node
          */
@@ -2098,6 +2105,12 @@
    =
     {
             msg(M_ERR, "ERROR: Cannot open TUN/TAP dev %s", node);
=
         }
+#if defined(TARGET_LINUX) && defined(ENABLE_SITNL)
+        if =
(orig_fd !=3D -1)
+        {
+            netns_restore(orig_fd);
+        =
}
+#endif
 
         /*
          * Process --tun-ipv6

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295=
bbd3
Gerrit-Change-Number: 1521
Gerrit-PatchSet: 12
Gerrit-Owner: its_Giaan=
 <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianma=
rco@mandelbit=2Ecom>

--47cvmmVc6kM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos=2E </p>
<p>its_Giaan <strong>upl=
oaded patch set #12</strong> to this change=2E</p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail">View Change</a></p><p>The =
change is no longer submittable: checks~ChecksSubmitRule is unsatisfied now=
=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">Add support for user defined network namespace<br><br>=
Introduce the --netns option to allow interface creation<br>into a user-def=
ined network namespace=2E<br>This allows the VPN data plane to be isolated =
from the main<br>OpenVPN process namespace=2E<br><br>The current netlink li=
brary integration supports interface creation<br>and deletion in a target n=
amespace=2E However, subsequent configuration<br>operations (e=2Eg=2E addre=
ss or mtu set) are executed in the caller&#39;s<br>namespace, as they rely =
on the default netlink socket context=2E<br>As a result, interface-related =
configuration performed after creation<br>may be applied in the wrong names=
pace=2E<br>Introduce helper functions to temporarily switch the process to =
the<br>requested network namespace using setns(2), execute the required<br>=
netlink operations, and then restore the original namespace=2E<br>The names=
pace switch is temporary and scoped to each netlink<br>operation=2E Once th=
e operation completes, the original namespace<br>is restored to preserve th=
e process execution context=2E<br><br>Note: This feature is Linux-only and =
depends on setns(2)=2E<br>It is not compatible (yet) with Data Channel Offl=
oad (DCO)=2E<br><br>Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3<br=
>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>-=
--<br>M doc/man-sections/vpn-network-options=2Erst<br>M src/openvpn/dco=2Ec=
<br>M src/openvpn/networking=2Eh<br>M src/openvpn/networking_sitnl=2Ec<br>M=
 src/openvpn/networking_sitnl=2Eh<br>M src/openvpn/options=2Ec<br>M src/ope=
nvpn/options=2Eh<br>M src/openvpn/tun=2Ec<br>8 files changed, 605 insertion=
s(+), 83 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/21/1521/12</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/=
man-sections/vpn-network-options=2Erst b/doc/man-sections/vpn-network-optio=
ns=2Erst</span><br><span>index 33ebedb=2E=2E181c990 100644</span><br><span>=
--- a/doc/man-sections/vpn-network-options=2Erst</span><br><span>+++ b/doc/=
man-sections/vpn-network-options=2Erst</span><br><span>@@ -304,6 +304,12 @@=
</span><br><span>   Specify the link layer address, more commonly known as =
the MAC address=2E</span><br><span>   Only applied to TAP devices=2E</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--netns =
name</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Specify the n=
etwork namespace in which the tunnel interface will be created=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  The namespace must already =
exist=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  (Supported on Linux only, on=
 other platforms this is a no-op)=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> --persist-tun</span><br><span>   Don&#39=
;t close and reopen TUN/TAP device or run up/down scripts across</span><br>=
<span>   :code:`SIGUSR1` or ``--ping-restart`` restarts=2E</span><br><span>=
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>inde=
x f5b7081=2E=2Efbefcb6 100644</span><br><span>--- a/src/openvpn/dco=2Ec</sp=
an><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -389,6 +389,12 @@=
</span><br><span>                 ret);</span><br><span>         }</span><b=
r><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;netns)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;Note: --n=
etns not supported by DCO, disabling data channel offload=2E&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #=
endif /* if defined(_WIN32) */</span><br><span> </span><br><span> #if defin=
ed(HAVE_LIBCAPNG)</span><br><span>diff --git a/src/openvpn/networking=2Eh b=
/src/openvpn/networking=2Eh</span><br><span>index bce0c19=2E=2Efab6bbf 1006=
44</span><br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/s=
rc/openvpn/networking=2Eh</span><br><span>@@ -39,10 +39,10 @@</span><br><sp=
an> typedef void *openvpn_net_iface_t;</span><br><span> #endif /* ifdef ENA=
BLE_SITNL */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-/* Only the iproute2 backend implements these functions,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Only the iproute2 and sitn=
l backend implements these functions,</span><br><span>  * the rest can rely=
 on these stubs</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if !defined(ENABLE_IPROUTE)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if !defined(ENABLE_IPROUTE) &amp;&amp; !defined(EN=
ABLE_SITNL) || defined(TARGET_ANDROID)</span><br><span> static inline int</=
span><br><span> net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</sp=
an><br><span> {</span><br><span>@@ -63,7 +63,7 @@</span><br><span> {</span>=
<br><span>     (void)ctx;</span><br><span> }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* !defined(ENABLE_IPROUTE) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* !defined(ENABLE_IPROUTE)=
 &amp;&amp; !defined(ENABLE_SITNL) || defined(TARGET_ANDROID) */</span><br>=
<span> </span><br><span> #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUT=
E)</span><br><span> </span><br><span>diff --git a/src/openvpn/networking_si=
tnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index b3f8e2b=2E=
=2Eb60131f 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</s=
pan><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -33=
,14 +33,17 @@</span><br><span> #include &quot;networking=2Eh&quot;</span><b=
r><span> #include &quot;proto=2Eh&quot;</span><br><span> #include &quot;rou=
te=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span> #include &lt;e=
rrno=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> =
#include &lt;unistd=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;sched=2Eh&gt;</span><br><span> #include &lt;sys/types=
=2Eh&gt;</span><br><span> #include &lt;sys/socket=2Eh&gt;</span><br><span> =
#include &lt;linux/netlink=2Eh&gt;</span><br><span> #include &lt;linux/rtne=
tlink=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &lt;linux/net_namespace=2Eh&gt;</span><br><span> </span><br><span> #defi=
ne SNDBUF_SIZE (1024 * 2)</span><br><span> #define RCVBUF_SIZE (1024 * 4)</=
span><br><span>@@ -65,6 +68,12 @@</span><br><span>         _nest-&gt;rta_le=
n =3D (unsigned short)((void *)sitnl_nlmsg_tail(_msg) - (void *)_nest); \</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define SITNL_NETNS_RTA(r) \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ((struct rtattr *)(((char *)(r)) + NLMSG_A=
LIGN(sizeof(struct rtgenmsg))))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 NETNS_RUN_DIR  &quot;/run/netns&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define NETNS_ORIG_DIR &quot;/proc/self/ns/net&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Th=
is function was originally implemented as a macro, but compiling with</span=
><br><span>  * gcc and -O3 was getting confused about the math and thus rai=
sing</span><br><span>  * security warnings on subsequent memcpy() calls=2E<=
/span><br><span>@@ -121,6 +130,16 @@</span><br><span>     char buf[256];</s=
pan><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Network namespace NSID request message</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+struct sitnl_nsid_req</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 nlmsghdr n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct rtgenmsg g;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
char buf[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> type=
def int (*sitnl_parse_reply_cb)(struct nlmsghdr *msg, void *arg);</span><br=
><span> </span><br><span> /**</span><br><span>@@ -156,6 +175,105 @@</span><=
br><span>     return 0;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&am=
p; defined(ENABLE_SITNL)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int net=
ns_id_from_name_sitnl(const char *name);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static int set_netns_id_from_name_sitnl(const char *na=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+net_ctx_init(struct context *c, openvpn_net_ctx_t =
*ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct stat st;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    char path[PATH_MAX];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ctx-&gt;netns =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (c &amp;&amp; c-&gt;options=2Enetns)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        snprintf(path, sizeof(path), &quot;%s/%=
s&quot;, NETNS_RUN_DIR, c-&gt;options=2Enetns);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (stat(path, &amp;st) !=3D 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(M_ERR, &quot;%s: Network namespace %s do=
es not exist&quot;, __func__, path);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ctx-=
&gt;netns =3D c-&gt;options=2Enetns;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+net_ctx_reset(openvpn_net_ctx_t *ctx)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_reset(&amp;ctx-&gt;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_free(openvpn_net_ctx_t=
 *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;ctx-&gt;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+netns_switch(openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    char net_path[PATH_MAX];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int orig_fd =3D -1, netns_fd;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *netns =3D ctx ? ctx-&gt;netns : NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!netns)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Save cu=
rrent netns descriptor */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    orig_fd =3D open(NETNS_ORIG_DIR, O_RDONLY | O_CLOEXEC);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (orig_fd &lt; 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s:=
 Cannot open original network namespace&quot;, __func__);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    snprintf(net_path, sizeof(net_path), &quot;%s/%s&quot;, NETNS_RUN_D=
IR, netns);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    netn=
s_fd =3D open(net_path, O_RDONLY | O_CLOEXEC);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (netns_fd &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: Cannot open net=
work namespace \&quot;%s\&quot;&quot;, __func__, netns);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        close(orig_fd);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (setns(netns_fd, CLONE_NEWNET) &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: setting the net=
work namespace \&quot;%s\&quot; failed&quot;, __func__, netns);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        close(netns_fd);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        close(orig_fd);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    close(netns_fd);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return orig_fd;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+netns_restore(int orig_fd)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (orig_fd &lt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (setns=
(orig_fd, CLONE_NEWNET) &lt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(M_WARN | M_ERRNO, &quot;%s: Cannot restore original network names=
pace&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    close(orig_fd);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif /* defined (TARGET_LINUX) &amp;&amp; defi=
ned (ENABLE_SITNL) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /**</span><br><span>  * Open RTNL socket</span><br><spa=
n>  */</span><br><span>@@ -445,6 +563,285 @@</span><br><span>     return re=
t;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef ENABLE_SITNL</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Netlink callback to extract the interface index from a RTM_NEWLINK m=
essage=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function is used as=
 a Netlink response handler=2E It inspects incoming</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Netlink messages and, when a RTM_NEWLI=
NK message is received, copies the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * contained `struct ifinfomsg` into the caller-provided res=
ult structure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n    Netli=
nk message header received from the kernel=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param arg  Pointer to a `struct sitnl_link_re=
q` used to store the result=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn 0 to stop Netlink message processing once the interface is found,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         1 to continue=
 processing other messages=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_link_get_=
ifindex(struct nlmsghdr *n, void *arg)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct sitnl_link_req *res =3D arg;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct ifinfomsg *ifi;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (n-&gt;nlmsg_type !=3D RTM_NEWLINK)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifi =3D NLM=
SG_DATA(n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res-=
&gt;i =3D *ifi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retr=
ieve the interface index of a network device in a specific network namespac=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Sends an RTM_GETLINK Netlink =
request targeting the given network namespace ID</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * and interface name, and extracts the result=
ing interface index from the kernel</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * response=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * On =
failure, this function returns 0, matching the behavior of</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * `if_nametoindex()`=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param ifname   Name of the network interface=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param netnsi=
d  Target network namespace ID=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return Interface index on success, or 0 on error=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+get_ifindex_in_netns(const char *ifname, int netnsid)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct sitnl_link_req req;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct sitnl_link_req res;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1, ifindex =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(req);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(res);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_=
type =3D RTM_GETLINK;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SITNL_ADDATTR(&amp;req=2En, sizeof(req), IFLA_TARGET_NETNSID, &=
amp;netnsid, sizeof(int));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SITNL_ADDATTR(&amp;req=2En, sizeof(req), IFLA_IFNAME, ifname, st=
rlen(ifname) + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D sitnl_se=
nd(&amp;req=2En, 0, 0, sitnl_link_get_ifindex, &amp;res);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ifindex =3D res=2Ei=2Eif=
i_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return ifindex;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_parse_rta=
ttr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
     unsigned short flags)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigne=
d short type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(tb, 0, sizeof(=
struct rtattr *) * (max + 1));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whil=
e (RTA_OK(rta, len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        type =
=3D rta-&gt;rta_type &amp; ~flags;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if ((type &lt;=3D max) &amp;&amp; (!tb[type]))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            tb[type] =3D rta;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        rta =3D RTA_NEXT(rta, len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot;%s: %zu b=
ytes not parsed! (rta_len=3D%u)&quot;, __func__, len, rta-&gt;rta_len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_p=
arse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    sitnl_parse_rtattr_flags(tb, max=
, rta, len, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define sitnl_parse_rtattr_nested(tb, max=
, rta) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (sitnl_=
parse_rtattr_flags(tb, max, RTA_DATA(rta), RTA_PAYLOAD(rta), NLA_F_NESTED))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Netlink callback to extract and store a network nam=
espace ID (NSID)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function =
processes Netlink responses to RTM_GETNSID requests=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * If a NETNSA_NSID attribute is present=
, its value is copied into the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * caller-provided storage=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * If a Netlink error message is received, the contained error code is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * returned directly=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param n    Netlink message he=
ader received from the kernel=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param arg  Pointer to an integer where the NSID will be st=
ored=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return 0 on success, a ne=
gative error code on failure=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_nsid_sa=
ve(struct nlmsghdr *n, void *arg)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int *nsid =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct rtgenmsg *g =3D NLMSG_DATA(n);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct rtattr *tb[NETNSA_MAX + 1];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (n-&gt;nlmsg_type =3D=3D NLMSG_ERROR)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct nlmsgerr *err =3D NLMSG_DA=
TA(n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n err-&gt;error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    sitnl_parse_rtattr(tb, NETNSA_MA=
X, SITNL_NETNS_RTA(g), NLMSG_PAYLOAD(n, sizeof(*g)));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!tb[NETNSA_NSID])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return -ENOENT;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(nsid, RTA_D=
ATA(tb[NETNSA_NSID]), sizeof(*nsid));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Retrieve the network namespace ID (NSI=
D) associated with a namespace name=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * This function opens the network namespace identified by the given path=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and sends an RTM=
_GETNSID Netlink request to retrieve its assigned NSID=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param name  Name of the network namespace=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return The network namespace ID on su=
ccess, or a negative value on failure=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+netn=
s_id_from_name_sitnl(const char *name)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct sitnl_nsid_req req;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 netnsid =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 CLEAR(req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int netns_fd =3D open(=
name, O_RDONLY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (netns_fd &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof=
(req=2Eg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=
=2En=2Enlmsg_type =3D RTM_GETNSID;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    req=2Eg=2Ertgen_family =3D AF_U=
NSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&amp;req=2En, =
sizeof(req), NETNSA_FD, &amp;netns_fd, sizeof(int));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    sitnl_send(&amp;req=2En, 0, 0, sitnl_nsid_save, &amp;net=
nsid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (netns_fd &gt;=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        close(netns_fd);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return netnsid;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Assign a network namespace ID (NSID) =
to a namespace=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function se=
nds an RTM_NEWNSID Netlink request to associate a</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * NSID with the network namespace identified=
 by the given path=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param name =
 Name of the network namespace=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return 0 on success, or a negative error code on failure=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+set_netns_id_from_name_sitnl(const char *name)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct sitnl_nsid_req req;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int ret =3D -1, netnsid =3D -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(req);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int netns_fd =3D open(name, O_RDONLY);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (netns_fd &lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2E=
n=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Eg));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D RTM_NEWNSID;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_flag=
s =3D NLM_F_REQUEST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    req=2Eg=2Ertgen_family =3D AF_UNSPEC;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SITNL_ADDATTR(&amp;req=2En, sizeof(req), NETNSA_FD, &amp;netns_fd, =
sizeof(int));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SI=
TNL_ADDATTR(&amp;req=2En, sizeof(req), NETNSA_NSID, &amp;netnsid, sizeof(in=
t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req=2E=
n, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (netns_fd &gt;=3D 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        close(netns_fd);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+get_or_create_netnsid_sitnl(c=
onst char *name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char net_path[PAT=
H_MAX];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int netn=
sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(ne=
t_path, sizeof(net_path), &quot;%s/%s&quot;, NETNS_RUN_DIR, name);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* First get */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    netnsid =3D netns_id_from_name_sitnl(net_pa=
th);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netnsid=
 &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return netnsid=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* No netnsid yet? Try to assign one */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    netnsid =3D set_netns_i=
d_from_name_sitnl(net_path);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (netnsid &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Second get */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    netnsid =3D netns_id_from_name=
_sitnl(net_path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (netnsid &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn netnsid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_if_nametoin=
dex(const char *ifname, openvpn_net_ctx_t *ctx)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *netns =3D ctx ? ctx-&gt;netns : NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int netnsid =3D get_or_crea=
te_netnsid_sitnl(netns);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netnsi=
d &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return if_nameto=
index(ifname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return get_ifindex_in_netns(ifname=
, netnsid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_SIT=
NL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> typedef struct</span><br><span> {</span><br><span>     size_t addr_size=
;</span><br><span>@@ -652,7 +1049,7 @@</span><br><span> net_iface_up(openvp=
n_net_ctx_t *ctx, const char *iface, bool up)</span><br><span> {</span><br>=
<span>     struct sitnl_link_req req;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int ifindex;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int ifindex, orig =3D -1;</span><br><span> </span><br><spa=
n>     CLEAR(req);</span><br><span> </span><br><span>@@ -662,13 +1059,15 @@=
</span><br><span>         return -EINVAL;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>=
     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: rtnl: cannot get =
ifindex for %s: %s&quot;, __func__, iface, strerror(errno));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quo=
t;%s: rtnl: cannot get ifindex for %s&quot;, __func__, iface);</span><br><s=
pan>         return -ENOENT;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    orig =3D netns_switch=
(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><=
span>     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br><span>     req=
=2En=2Enlmsg_type =3D RTM_NEWLINK;</span><br><span>@@ -687,24 +1086,30 @@</=
span><br><span> </span><br><span>     msg(M_INFO, &quot;%s: set %s %s&quot;=
, __func__, iface, up ? &quot;up&quot; : &quot;down&quot;);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_se=
nd(&amp;req=2En, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    netns_restore(orig);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</span><br><span> =
</span><br><span> int</span><br><span> net_iface_mtu_set(openvpn_net_ctx_t =
*ctx, const char *iface, uint32_t mtu)</span><br><span> {</span><br><span> =
    struct sitnl_link_req req;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int ifindex, ret =3D -1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int ifindex, orig =3D -1, ret =3D -1;</span><br><span=
> </span><br><span>     CLEAR(req);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifindex =3D openvpn_=
if_nametoindex(iface, ctx);</span><br><span>     if (ifindex =3D=3D 0)</spa=
n><br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;%s:=
 rtnl: cannot get ifindex for %s&quot;, __func__, iface);</span><br><span> =
        return -1;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    orig =3D netns_switch(ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     r=
eq=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>     =
req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br><span>     req=2En=2Enlm=
sg_type =3D RTM_NEWLINK;</span><br><span>@@ -717,7 +1122,9 @@</span><br><sp=
an>     msg(M_INFO, &quot;%s: mtu %u for %s&quot;, __func__, mtu, iface);</=
span><br><span> </span><br><span>     ret =3D sitnl_send(&amp;req=2En, 0, 0=
, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  netns_restore(orig);</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span>@@ -725,17 +1132,19 @@</span><br><span> n=
et_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, ui=
nt8_t *addr)</span><br><span> {</span><br><span>     struct sitnl_link_req =
req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex, =
ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
ifindex, orig =3D -1, ret =3D -1;</span><br><span> </span><br><span>     CL=
EAR(req);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx)=
;</span><br><span>     if (ifindex =3D=3D 0)</span><br><span>     {</span><=
br><span>         msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex =
for %s&quot;, __func__, iface);</span><br><span>         return -1;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    orig =3D netns_switch(ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     req=2En=2Enlmsg_len =3D NLM=
SG_LENGTH(sizeof(req=2Ei));</span><br><span>     req=2En=2Enlmsg_flags =3D =
NLM_F_REQUEST;</span><br><span>     req=2En=2Enlmsg_type =3D RTM_NEWLINK;</=
span><br><span>@@ -748,17 +1157,19 @@</span><br><span>     msg(M_INFO, &quo=
t;%s: lladdr &quot; MAC_FMT &quot; for %s&quot;, __func__, MAC_PRINT_ARG(ad=
dr), iface);</span><br><span> </span><br><span>     ret =3D sitnl_send(&amp=
;req=2En, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> err:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    netns_restore(orig);</span><br><span>     return ret;</span=
><br><span> }</span><br><span> </span><br><span> static int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_set(uint16_t cmd, uint16_t=
 flags, int ifindex, sa_family_t af_family,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+sitnl_addr_set(openvpn_net_ctx_t *ctx, uint16_t cmd=
, uint16_t flags, int ifindex, sa_family_t af_family,</span><br><span>     =
           const inet_address_t *local, const inet_address_t *remote, int p=
refixlen)</span><br><span> {</span><br><span>     struct sitnl_addr_req req=
;</span><br><span>     uint32_t size;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int ret =3D -EINVAL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int ret =3D -EINVAL, orig =3D -1;</span><br><span>=
 </span><br><span>     CLEAR(req);</span><br><span> </span><br><span>@@ -81=
0,17 +1221,22 @@</span><br><span>         SITNL_ADDATTR(&amp;req=2En, sizeo=
f(req), IFA_BROADCAST, &amp;broadcast, size);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    orig=
 =3D netns_switch(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL, NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
     if (ret =3D=3D -EEXIST)</span><br><span>     {</span><br><span>       =
  ret =3D 0;</span><br><span>     }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> err:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    netns_restore(orig);</span><br><span>     return ret=
;</span><br><span> }</span><br><span> </span><br><span> static int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_ptp_add(sa_family_t=
 af_family, const char *iface, const inet_address_t *local,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_ptp_add(openvpn_net_ctx_=
t *ctx, sa_family_t af_family, const char *iface, const inet_address_t *loc=
al,</span><br><span>                    const inet_address_t *remote)</span=
><br><span> {</span><br><span>     int ifindex;</span><br><span>@@ -841,19 =
+1257,19 @@</span><br><span>         return -EINVAL;</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><=
br><span>     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: cannot g=
et ifindex for %s: %s&quot;, __func__, np(iface), strerror(errno));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRN=
O, &quot;%s: cannot get ifindex for %s&quot;, __func__, np(iface));</span><=
br><span>         return -ENOENT;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_=
set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr=
_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, lo=
cal,</span><br><span>                           remote, 0);</span><br><span=
> }</span><br><span> </span><br><span> static int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-sitnl_addr_ptp_del(sa_family_t af_family, const=
 char *iface, const inet_address_t *local)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+sitnl_addr_ptp_del(openvpn_net_ctx_t *ctx, sa_family=
_t af_family, const char *iface, const inet_address_t *local)</span><br><sp=
an> {</span><br><span>     int ifindex;</span><br><span> </span><br><span>@=
@ -873,23 +1289,23 @@</span><br><span>         return -EINVAL;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    ifindex =3D if_nametoindex(iface);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx=
);</span><br><span>     if (ifindex =3D=3D 0)</span><br><span>     {</span>=
<br><span>         msg(M_WARN | M_ERRNO, &quot;%s: cannot get ifindex for %=
s&quot;, __func__, iface);</span><br><span>         return -ENOENT;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, l=
ocal, NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, local, NULL,=
 0);</span><br><span> }</span><br><span> </span><br><span> static int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_set(uint16_t cm=
d, uint16_t flags, int ifindex, sa_family_t af_family, const void *dst,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_set(openvpn=
_net_ctx_t *ctx, uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_=
family, const void *dst,</span><br><span>                 int prefixlen, co=
nst void *gw, enum rt_class_t table, int metric,</span><br><span>          =
       enum rt_scope_t scope, unsigned char protocol, unsigned char type)</=
span><br><span> {</span><br><span>     struct sitnl_route_req req;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -1, size;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1, size=
, orig =3D -1;</span><br><span> </span><br><span>     CLEAR(req);</span><br=
><span> </span><br><span>@@ -948,14 +1364,17 @@</span><br><span>     {</spa=
n><br><span>         SITNL_ADDATTR(&amp;req=2En, sizeof(req), RTA_PRIORITY,=
 &amp;metric, 4);</span><br><span>     }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    orig =3D netns_switch(ctx);</span><br><span> </spa=
n><br><span>     ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> err:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    netns_restore(orig)=
;</span><br><span>     return ret;</span><br><span> }</span><br><span> </sp=
an><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-sitnl_addr_add(sa_family_t af_family, const char *iface, const inet_addr=
ess_t *addr, int prefixlen)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+sitnl_addr_add(openvpn_net_ctx_t *ctx, sa_family_t af_family, const=
 char *iface, const inet_address_t *addr, int prefixlen)</span><br><span> {=
</span><br><span>     int ifindex;</span><br><span> </span><br><span>@@ -97=
5,19 +1394,19 @@</span><br><span>         return -EINVAL;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</s=
pan><br><span>     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><=
span>         msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for =
%s&quot;, __func__, iface);</span><br><span>         return -ENOENT;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_RE=
PLACE, ifindex, af_family, addr, NULL,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE=
 | NLM_F_REPLACE, ifindex, af_family, addr, NULL,</span><br><span>         =
                  prefixlen);</span><br><span> }</span><br><span> </span><b=
r><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-si=
tnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *addr=
, int prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sit=
nl_addr_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *ifac=
e, inet_address_t *addr, int prefixlen)</span><br><span> {</span><br><span>=
     int ifindex;</span><br><span> </span><br><span>@@ -1007,14 +1426,14 @@=
</span><br><span>         return -EINVAL;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>=
     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span>         =
msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __fu=
nc__, iface);</span><br><span>         return -ENOENT;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, pr=
efixlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefix=
len);</span><br><span> }</span><br><span> </span><br><span> int</span><br><=
span>@@ -1033,7 +1452,7 @@</span><br><span>     msg(M_INFO, &quot;%s: %s/%d=
 dev %s&quot;, __func__, inet_ntop(AF_INET, &amp;addr_v4=2Eipv4, buf, sizeo=
f(buf)),</span><br><span>         prefixlen, iface);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_add(=
AF_INET, iface, &amp;addr_v4, prefixlen);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return sitnl_addr_add(ctx, AF_INET, iface, &amp;a=
ddr_v4, prefixlen);</span><br><span> }</span><br><span> </span><br><span> i=
nt</span><br><span>@@ -1053,7 +1472,7 @@</span><br><span>     msg(M_INFO, &=
quot;%s: %s/%d dev %s&quot;, __func__, inet_ntop(AF_INET6, &amp;addr_v6=2Ei=
pv6, buf, sizeof(buf)),</span><br><span>         prefixlen, iface);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
sitnl_addr_add(AF_INET6, iface, &amp;addr_v6, prefixlen);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_add(ctx, AF_INE=
T6, iface, &amp;addr_v6, prefixlen);</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span>@@ -1072,7 +1491,7 @@</span><br><span> =
    msg(M_INFO, &quot;%s: %s dev %s&quot;, __func__, inet_ntop(AF_INET, &am=
p;addr_v4=2Eipv4, buf, sizeof(buf)),</span><br><span>         iface);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n sitnl_addr_del(AF_INET, iface, &amp;addr_v4, prefixlen);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_del(ctx, AF_IN=
ET, iface, &amp;addr_v4, prefixlen);</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span>@@ -1092,7 +1511,7 @@</span><br><span> =
    msg(M_INFO, &quot;%s: %s/%d dev %s&quot;, __func__, inet_ntop(AF_INET6,=
 &amp;addr_v6=2Eipv6, buf, sizeof(buf)),</span><br><span>         prefixlen=
, iface);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return sitnl_addr_del(AF_INET6, iface, &amp;addr_v6, prefixlen);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_add=
r_del(ctx, AF_INET6, iface, &amp;addr_v6, prefixlen);</span><br><span> }</s=
pan><br><span> </span><br><span> int</span><br><span>@@ -1120,7 +1539,7 @@<=
/span><br><span>         inet_ntop(AF_INET, &amp;local_v4=2Eipv4, buf1, siz=
eof(buf1)),</span><br><span>         inet_ntop(AF_INET, &amp;remote_v4=2Eip=
v4, buf2, sizeof(buf2)), iface);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return sitnl_addr_ptp_add(AF_INET, iface, =
&amp;local_v4, &amp;remote_v4);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return sitnl_addr_ptp_add(ctx, AF_INET, iface, &amp;local_v=
4, &amp;remote_v4);</span><br><span> }</span><br><span> </span><br><span> i=
nt</span><br><span>@@ -1141,11 +1560,11 @@</span><br><span>     msg(M_INFO,=
 &quot;%s: %s dev %s&quot;, __func__, inet_ntop(AF_INET, &amp;local_v4=2Eip=
v4, buf, sizeof(buf)),</span><br><span>         iface);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_p=
tp_del(AF_INET, iface, &amp;local_v4);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return sitnl_addr_ptp_del(ctx, AF_INET, iface, &amp;=
local_v4);</span><br><span> }</span><br><span> </span><br><span> static int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_add(const=
 char *iface, sa_family_t af_family, const void *dst, int prefixlen,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_add(openvpn_ne=
t_ctx_t *ctx, const char *iface, sa_family_t af_family, const void *dst, in=
t prefixlen,</span><br><span>                 const void *gw, uint32_t tabl=
e, int metric)</span><br><span> {</span><br><span>     enum rt_scope_t scop=
e =3D RT_SCOPE_UNIVERSE;</span><br><span>@@ -1153,7 +1572,7 @@</span><br><s=
pan> </span><br><span>     if (iface)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        ifindex =3D if_nametoindex(i=
face);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ifind=
ex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>         if (ifi=
ndex =3D=3D 0)</span><br><span>         {</span><br><span>             msg(=
M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, __fun=
c__, iface);</span><br><span>@@ -1171,7 +1590,7 @@</span><br><span>        =
 scope =3D RT_SCOPE_LINK;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM=
_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_set(ctx=
, RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,</span=
><br><span>                            table, metric, scope, RTPROT_BOOT, R=
TN_UNICAST);</span><br><span> }</span><br><span> </span><br><span>@@ -1200,=
7 +1619,7 @@</span><br><span>         inet_ntop(AF_INET, &amp;dst_be, dst_s=
tr, sizeof(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET=
, &amp;gw_be, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return si=
tnl_route_add(iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table, metric);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_rout=
e_add(ctx, iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table, metric);</spa=
n><br><span> }</span><br><span> </span><br><span> int</span><br><span>@@ -1=
226,18 +1645,18 @@</span><br><span>         inet_ntop(AF_INET6, &amp;dst_v6=
=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>         ine=
t_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), tab=
le, metric);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return sitnl_route_add(iface, AF_INET6, dst, prefixlen, gw, ta=
ble, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn sitnl_route_add(ctx, iface, AF_INET6, dst, prefixlen, gw, table, metri=
c);</span><br><span> }</span><br><span> </span><br><span> static int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_del(const char *=
iface, sa_family_t af_family, inet_address_t *dst, int prefixlen,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_del(openvpn_net_c=
tx_t *ctx, const char *iface, sa_family_t af_family, inet_address_t *dst, i=
nt prefixlen,</span><br><span>                 inet_address_t *gw, uint32_t=
 table, int metric)</span><br><span> {</span><br><span>     int ifindex =3D=
 0;</span><br><span> </span><br><span>     if (iface)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ifindex =3D =
if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>=
         if (ifindex =3D=3D 0)</span><br><span>         {</span><br><span> =
            msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex for=
 %s&quot;, __func__, iface);</span><br><span>@@ -1250,7 +1669,7 @@</span><b=
r><span>         table =3D RT_TABLE_MAIN;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sit=
nl_route_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table=
, metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 sitnl_route_set(ctx, RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, =
gw, table, metric,</span><br><span>                            RT_SCOPE_NOW=
HERE, 0, 0);</span><br><span> }</span><br><span> </span><br><span>@@ -1277,=
7 +1696,7 @@</span><br><span>         inet_ntop(AF_INET, &amp;dst_v4=2Eipv4=
, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>         inet_ntop(=
AF_INET, &amp;gw_v4=2Eipv4, gw_str, sizeof(gw_str)), np(iface), table, metr=
ic);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return sitnl_route_del(iface, AF_INET, &amp;dst_v4, prefixlen, &amp;gw=
_v4, table, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return sitnl_route_del(ctx, iface, AF_INET, &amp;dst_v4, prefixlen, &a=
mp;gw_v4, table, metric);</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span>@@ -1303,7 +1722,7 @@</span><br><span>         ine=
t_ntop(AF_INET6, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,<=
/span><br><span>         inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, siz=
eof(gw_str)), np(iface), table, metric);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_del(iface, AF_I=
NET6, &amp;dst_v6, prefixlen, &amp;gw_v6, table, metric);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_del(ctx, iface=
, AF_INET6, &amp;dst_v6, prefixlen, &amp;gw_v6, table, metric);</span><br><=
span> }</span><br><span> </span><br><span> </span><br><span>@@ -1347,45 +17=
66,11 @@</span><br><span>     msg(D_ROUTE, &quot;%s: add %s type %s&quot;, =
__func__, iface, type);</span><br><span> </span><br><span>     ret =3D sitn=
l_send(&amp;req=2En, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> err:</span><br><span>     return ret;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtat=
tr *rta, size_t len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                        unsigned short flags)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    unsigned short type;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memset(tb,=
 0, sizeof(struct rtattr *) * (max + 1));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   while (RTA_OK(rta, len))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ty=
pe =3D rta-&gt;rta_type &amp; ~flags;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if ((type &lt;=3D max) &amp;&amp; (!tb[type]))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            tb[type] =3D rta;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
ta =3D RTA_NEXT(rta, len);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (len)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(D_ROUTE, &quot;%s: %zu bytes not parsed! (rta=
_len=3D%u)&quot;, __func__, len, rta-&gt;rta_len);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-sitnl_parse_rtattr(struct rtattr *tb[]=
, size_t max, struct rtattr *rta, size_t len)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    sitnl_parse_rtattr_flags(tb, max, rta, len, 0);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 sitnl_parse_rtattr_nested(tb, max, rta) \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    (sitnl_parse_rtattr_flags(tb, max, RTA_DATA(rta), =
RTA_PAYLOAD(rta), NLA_F_NESTED))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> static int</span><br><span> sitnl_type_save(st=
ruct nlmsghdr *n, void *arg)</span><br><span> {</span><br><span>@@ -1416,13=
 +1801,16 @@</span><br><span> net_iface_type(openvpn_net_ctx_t *ctx, const =
char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span><br><s=
pan>     struct sitnl_link_req req =3D {};</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int ifindex =3D if_nametoindex(iface);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int ifindex =3D openvpn_if_=
nametoindex(iface, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int orig =3D -1;</span><br><span> </span><br><span>     if (!ifind=
ex)</span><br><span>     {</span><br><span>         return -errno;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    orig =3D netns_switch(ctx);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     req=2En=2Enlmsg_len =3D NLMS=
G_LENGTH(sizeof(req=2Ei));</span><br><span>     req=2En=2Enlmsg_flags =3D N=
LM_F_REQUEST;</span><br><span>     req=2En=2Enlmsg_type =3D RTM_GETLINK;</s=
pan><br><span>@@ -1435,26 +1823,32 @@</span><br><span>     int ret =3D sitn=
l_send(&amp;req=2En, 0, 0, sitnl_type_save, type);</span><br><span>     if =
(ret &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        netns_restore(orig);</span><br><span>         msg(D=
_ROUTE, &quot;%s: cannot retrieve iface %s: %s (%d)&quot;, __func__, iface,=
 strerror(-ret), ret);</span><br><span>         return ret;</span><br><span=
>     }</span><br><span> </span><br><span>     msg(D_ROUTE, &quot;%s: type =
of %s: %s&quot;, __func__, iface, type);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    netns_restore(orig);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return 0;=
</span><br><span> }</span><br><span> </span><br><span> int</span><br><span>=
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)</span><br><span> =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1=
, orig =3D -1;</span><br><span>     struct sitnl_link_req req =3D {};</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D if_name=
toindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span> </span=
><br><span>     if (!ifindex)</span><br><span>     {</span><br><span>      =
   return -errno;</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    orig =3D netns_switch(ctx);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     re=
q=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>     r=
eq=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br><span>     req=2En=2Enlms=
g_type =3D RTM_DELLINK;</span><br><span>@@ -1464,7 +1858,11 @@</span><br><s=
pan> </span><br><span>     msg(D_ROUTE, &quot;%s: delete %s&quot;, __func__=
, iface);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req=2E=
n, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    netns_restore=
(orig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span=
> }</span><br><span> </span><br><span> #endif /* !ENABLE_SITNL */</span><br=
><span>diff --git a/src/openvpn/networking_sitnl=2Eh b/src/openvpn/networki=
ng_sitnl=2Eh</span><br><span>index 481cc36=2E=2E7e723fe 100644</span><br><s=
pan>--- a/src/openvpn/networking_sitnl=2Eh</span><br><span>+++ b/src/openvp=
n/networking_sitnl=2Eh</span><br><span>@@ -21,7 +21,97 @@</span><br><span> =
#ifndef NETWORKING_SITNL_H_</span><br><span> #define NETWORKING_SITNL_H_</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;env_set=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> typedef char openvpn_net_iface_t;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-typedef void *openvpn_net_ctx_t;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct openvpn_net_ctx</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *netns;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef st=
ruct openvpn_net_ctx openvpn_net_ctx_t;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Switc=
h the current thread to the network namespace specified</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *        in the given OpenVPN network =
context=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function changes t=
he calling thread&#39;s network namespace to the one</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * identified by ctx-&gt;netns=2E The cur=
rent (original) network namespace file</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * descriptor is saved and returned, so it can later be =
restored using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ne=
tns_restore()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If @p ctx is NULL=
 or ctx-&gt;netns is NULL, the function fails and returns -1=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * The switch is performed using setns(2)=2E Thi=
s approach is required because</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * the netlink library does not support performing operations in=
 an arbitrary</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tar=
get network namespace, except for interface creation and deletion=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Therefore, in order to =
execute generic netlink operations inside a</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * specific network namespace, the thread must temp=
orarily enter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tha=
t namespace via setns()=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
ctx  Pointer to an OpenVPN network context structure containing</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             the target netwo=
rk namespace name (ctx-&gt;netns)=2E The namespace</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             is expected to exist under NE=
TNS_RUN_DIR (e=2Eg=2E /run/netns/)=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return On success, returns a file descriptor referring to the original=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         network =
namespace=2E This descriptor must be passed to</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *         netns_restore() to switch back=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return -1 on failur=
e (an error is logged and no namespace switch is kept)=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @note The returned file descriptor must be passed t=
o netns_restore(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*       which will restore the original namespace and close it=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int netns_switch(openvpn_net_ctx_t *ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @brief Restore the previously saved network namespace=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * This function restores the net=
work namespace saved by netns_switch()</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * using the file descriptor returned by that function=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * If @p orig_fd is negative, the=
 function does nothing and returns</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * immediately=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
he restoration is performed using setns(2), switching the calling</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * thread back to its origina=
l network namespace=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param orig=
_fd  File descriptor of the original network namespace,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *                 as returned by netns=
_switch()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @note This function a=
lways closes @p orig_fd if it is &gt;=3D 0,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *       regardless of whether setns() succeeds or =
fails=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       Af=
ter calling this function, @p orig_fd must not be reused=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void netns_restore(int orig_fd);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Resolve a network interface name to its interface index=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * If a valid network namespace ID is provided, =
the lookup is performed inside</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * that network namespace using Netlink=2E Otherwise, this funct=
ion falls back</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to=
 the standard `if_nametoindex()` call in the current namespace=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param ifname   Name of the network interfa=
ce=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx =
     The network context where we retrieve</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *                 the network namespace name=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return Interface index on success, o=
r 0 on error=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int openvpn_if_namet=
oindex(const char *ifname, openvpn_net_ctx_t *ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Retrieve or create a network namespace ID (NSID) for a given namespace=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * This function first attempts to r=
etrieve the NSID associated with the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * specified network namespace=2E If no NSID is currently =
assigned, it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * requ=
ests the kernel to create one and then retries the lookup=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param name  Name of the network namespace=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return The network namespace ID on =
success, or -1 on failure=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int get=
_or_create_netnsid_sitnl(const char *name);</span><br><span> </span><br><sp=
an> #endif /* NETWORKING_SITNL_H_ */</span><br><span>diff --git a/src/openv=
pn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 62c0bbb=2E=
=2Eb602dcc 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6495,6 +6495,14 @@</=
span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span> =
        options-&gt;mtu_test =3D true;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;ne=
tns&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifndef ENABLE_SITNL</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_WARN, &quot;NOTE: --netns is supported only on Li=
nux when compiled with SITNL&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        options-&gt;netns =3D p[1];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else i=
f (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><b=
r><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);</spa=
n><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh<=
/span><br><span>index a111cf8=2E=2E88a6dfa 100644</span><br><span>--- a/src=
/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><b=
r><span>@@ -315,6 +315,7 @@</span><br><span> </span><br><span>     struct d=
ns_options dns_options;</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *netns;</span><br><span>     bool remo=
te_random;</span><br><span>     const char *ipchange;</span><br><span>     =
const char *dev;</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/ope=
nvpn/tun=2Ec</span><br><span>index e7193d8=2E=2E51d9bed 100644</span><br><s=
pan>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</sp=
an><br><span>@@ -2082,6 +2082,13 @@</span><br><span>     }</span><br><span>=
     else</span><br><span>     {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; defined(ENABLE_SITNL)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int orig_fd =3D=
 -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ctx=
-&gt;netns)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            orig_f=
d =3D netns_switch(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f /* if defined(TARGET_LINUX) &amp;&amp; defined(ENABLE_SITNL) */</span><br=
><span>         /*</span><br><span>          * Process --dev-node</span><br=
><span>          */</span><br><span>@@ -2098,6 +2105,12 @@</span><br><span>=
         {</span><br><span>             msg(M_ERR, &quot;ERROR: Cannot open=
 TUN/TAP dev %s&quot;, node);</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; d=
efined(ENABLE_SITNL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (orig_fd !=3D -1)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            netns_restore(orig_fd);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span> </span><br><span>         /*</span><br><span>=
          * Process --tun-ipv6</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demai=
l">change 1521</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/15=
21?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: i=
ts_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@=
mandelbit=2Ecom&gt; </div>

</body></html>
--47cvmmVc6kM=--


--===============1362501230513947116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1362501230513947116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1362501230513947116==--

