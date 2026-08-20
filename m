Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9159AC5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r45zJ4j5aoY/sLXckOk+QN7dUlBRUvfazfT1xjXOzvA=; b=A9Whtp8Bp+csBvEeVpj3HR2KXr
	yXdDtm67837Pv9aHzn7fLj9bkCsttFOS1HxTy+/mbqND9S4OX9tuHzu9LPbUvI7rX+Q+05T97q/HP
	xCi8NWoQRQLqkeDtUEoPTNpCU9KRb6G8iQAn/GqZbtmZ9K4d6HLVMs4vQfOiQCVxq2/0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx9bw-0002rC-KQ;
	Thu, 20 Aug 2026 20:43:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx9bv-0002r6-6h
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 20:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mj/UG1qBLyX5qnekBJbSbvcixIpqOl8JrgMVeJ2h6/k=; b=RevjehsgzbOkixXotT7+0I+Ipe
 CsTlpLLJ5VuttfRyWvg2CqjVebSseexROEqobmliCc0YIQbWCrNzgigCcVoJJ9V7uRTpRa6a6Kvs3
 4SHt1NocxPTHVXdLbvmVELvpoF5AwxLpAGiIixvcO5K9X/u1W8zghWiDo+iIHZWqIctw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mj/UG1qBLyX5qnekBJbSbvcixIpqOl8JrgMVeJ2h6/k=; b=c
 U9amAIJ28se9tgE8kTRSZq0BOpiNVOgGm45pgPEdbJimjNn3hKQkWb/yCjF/gEkpD05b7g2yJO3Qa
 v2cHZyeR9MRld7hctdS+7oyX3m315uiT2V+FHE6OTqnTgHmENTZkA6q6AUlTOIMetJKAcCSr6J1uV
 rhNCdp5b3Mamoo6Q=;
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx9bl-000589-MN for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 20:43:36 +0000
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c2074710751so53381066b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787258603; x=1787863403; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mj/UG1qBLyX5qnekBJbSbvcixIpqOl8JrgMVeJ2h6/k=;
 b=ZzHehYHzINypjMo6SrxbFoY8k6Yl4g7sExCscpl39C/PA3g7/xj3B+ztScRrTuqCw0
 N8ByQHjhwmjXAff3hbo0XbRI3K5C7gWgroYCLAsgvJa2NUocQ8RQxDLTr2cztEqGGfUR
 VLjJNXNsOCQaB/qqDfVWaYKG6IIwXL7JxNdXqcNxUeeIyxFWNSgqOKmWWPFHv7j5OEh5
 nnfmaC1Rt7G6FBGRtyqahtHOmS0YIWUFeBgY9sCGvlMWj8oIGNSERmYoLepRt1ZS5oaj
 YaY2NkxzS+iBD2ksUQDn1vZ8mzpfS79jzrCe0v1zHiVxDe1H29fgxhgs7P9z/9+r32YR
 31Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787258603; x=1787863403;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mj/UG1qBLyX5qnekBJbSbvcixIpqOl8JrgMVeJ2h6/k=;
 b=iV2/mcUn7G8VFlozpuX3ZY6145QdmqXVXBJd7hb7Jnxz/zLcm48QfqKM1uLiKAnRBo
 59cKaels8cUJpennVNbXVLrL3f068o39xWTtVA5Mr9xtD4NXeJnledFNxf6z5sznBrEx
 pHxaQujcMAEXd3xdnPDHyB13WIIRJO5iAznraBE/pGfipeCPsd0ijoEDVAceEDnunlE0
 xj4DhOklza7MhXZlH2rF6WW0eYW3fWev45XvlRowNkcbwHdug66UcF96U6oo0QLq4IYF
 gy9puJ6LBGCNcQ/hk8vQ3Rddccqc3ZO0a/x4A+1CphHH/aFfe2Dy+EfkRwpBHApQgxMa
 jOsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTLR+gWhLbUxlkUphDrcLRVp3i0WL4zpJqBzWLRGZgx/9QbLDB6rU2EZehSzbjGPhfXqd22Wx0Kg7E26/C@lists.sourceforge.net
X-Gm-Message-State: AOJu0YymtPlVYomlqo2KGsRBPLC8DEK/wX47ZiONdmCt6weHgeexHptG
 KppaMhUjYjRJnuL6jUdqM48bPrkP9CFBmKehAY8w/pXjG2ERGAcpRSyBFRfLIk/dsnC7MB0nBD6
 cvqjcIj7yeq+/NZ2NEn+iBXGEM6ZelcFZgUIIH38bUG1GXsA4nKBOMiBCJioMKH+d2qyRojB2Vu
 hzRHymqQ==
X-Gm-Gg: AR+sD12MyiBswq7IzvlB1IXr0bdB0SNAGMebcr5jwiGFvrs9ylqy+drkIkX5QznDNKN
 eEzVzOHKUicJw2g3OfOdZ25NlVFK1R0CXSwaAOKMT9WnuGS1AcCYf2jGCYfm6tCFuJNECositwD
 zvUJH3y89JWgjqwhQnlu5SdetL71a5bJ7CpGbcPugV2Rj5eCjvRYPiSplFsTiY2I7Ulfd7i47Xs
 Lh4N2pn4Go8o3TGX/Pnal1RckDnCGWsIT9fZh1ErXCHiqlxcg6IklFLYIfs/xCuWQQT53IdNP1t
 YfvXnP1zRovh3jsFv63KqSuMt1/PKB+lnEzfrwFxHcPASNv7KkOIOSTbIiR+fW93FEkIQW6QokX
 RDutpDmlA1bBnf4ifIgjamsU2EXoYodZT3ZwblNMG2+HBkUObjJfVHtezsT/eskCLatT4DBFiLe
 6EIPxxeKv/N4I0nEccHBGIWsnjxGJIrMjRoTemjTC8pgh/QHKkTZ5Dvi9bjOmgpLQ5Y2Rbo0v2W
 p9QiqoBLmzEte5BDPqWQsjC3ck6POR61eXsr4DZPsGw/QLA2s8Ssz9YFE3GRNH0e3Be1m1Z/n9S
 UGsryv7eKOIZ2kJKWjOYHldEj+aNv9DEuCTlNW7zsT4D3X9zkuID8lbX38S+Mg==
X-Received: by 2002:a17:907:a49:b0:c20:31d1:a89f with SMTP id
 a640c23a62f3a-c246b5f63femr89409866b.24.1787258602632; 
 Thu, 20 Aug 2026 13:43:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e1b0csm132058466b.8.2026.08.20.13.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:43:22 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 20:43:21 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: 3e8dfe34b01f4ea727ba4a0ce1cf3093087cf960
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <707e123d9b169ce8baa37db965f0aac84adf40ab-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx9bl-000589-MN
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 options_string code from options.c
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3436786020203003050=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3436786020203003050==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1IkqdFur5jU="; charset=UTF-8

--1IkqdFur5jU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1773?usp=3Demail )

Change subject: options: Factor out options_string =
code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

options: Factor out options_string code from options=2Ec

option=
s=2Ec is a huge, unwieldly file=2E So remove some
closely related code that=
 has no direct dependencies
with the other functions in the file=2E

This t=
ime it is the functions related to the creation
and testing of the options =
string=2E

Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
Signed-off-=
by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1773
Message-Id: <20260820124355=2E23332-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg38563=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/init=2Ec
M src/o=
penvpn/occ=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/op=
envpn/options_string=2Ec
A src/openvpn/options_string=2Eh
M src/openvpn/ssl=
=2Ec
9 files changed, 532 insertions(+), 458 deletions(-)




diff --git a/=
CMakeLists=2Etxt b/CMakeLists=2Etxt
index 8866520=2E=2E2c3324d 100644
--- a=
/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -533,6 +533,8 @@
     src/openv=
pn/options_parse=2Ec
     src/openvpn/options_show=2Ec
     src/openvpn/opt=
ions_show=2Eh
+    src/openvpn/options_string=2Ec
+    src/openvpn/options_=
string=2Eh
     src/openvpn/otime=2Ec
     src/openvpn/otime=2Eh
     src/o=
penvpn/ovpn_dco_win=2Eh
diff --git a/src/openvpn/Makefile=2Eam b/src/openvp=
n/Makefile=2Eam
index 42b4404=2E=2E7fd12b4 100644
--- a/src/openvpn/Makefil=
e=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -110,6 +110,7 @@
 	openvpn=2Ec op=
envpn=2Eh \
 	options=2Ec options=2Eh \
 	options_show=2Ec options_show=2Eh=
 \
+	options_string=2Ec options_string=2Eh \
 	options_util=2Ec options_uti=
l=2Eh \
 	options_parse=2Ec \
 	otime=2Ec otime=2Eh \
diff --git a/src/open=
vpn/init=2Ec b/src/openvpn/init=2Ec
index a90fe69=2E=2Efa62cdd 100644
--- a=
/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -54,6 +54,7 @@
 #includ=
e "dco=2Eh"
 #include "tun_afunix=2Eh"
 #include "schedule=2Eh"
+#include "=
options_string=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/occ=
=2Ec b/src/openvpn/occ=2Ec
index aa262a8=2E=2Ef25ae19 100644
--- a/src/open=
vpn/occ=2Ec
+++ b/src/openvpn/occ=2Ec
@@ -29,7 +29,7 @@
 #include "occ=2Eh"=

 #include "forward=2Eh"
 #include "memdbg=2Eh"
-
+#include "options_string=
=2Eh"
 
 /*
  * This random string identifies an OpenVPN
diff --git a/src/o=
penvpn/options=2Ec b/src/openvpn/options=2Ec
index 391739c=2E=2E9bd6f01 100=
644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3363,43=
6 +3363,6 @@
 }
 
 /*
- * Build an options string to represent data channel=
 encryption options=2E
- * This string must match exactly between peers=2E =
 The keysize is checked
- * separately by read_key()=2E
- *
- * The followi=
ng options must match on both peers:
- *
- * Tunnel options:
- *
- * --dev =
tun|tap [unit number need not match]
- * --dev-type tun|tap
- * --link-mtu
=
- * --udp-mtu
- * --tun-mtu
- * --proto udp
- * --proto tcp-client [matched=
 with --proto tcp-server
- *                     on the other end of the co=
nnection]
- * --proto tcp-server [matched with --proto tcp-client on
- *   =
                  the other end of the connection]
- * --tun-ipv6
- * --ifc=
onfig x y [matched with --ifconfig y x on
- *                 the other end=
 of the connection]
- *
- * --comp-lzo
- * --compress alg
- * --fragment
- =
*
- * Crypto Options:
- *
- * --cipher
- * --auth
- * --secret
- *
- * SSL =
Options:
- *
- * --tls-auth
- * --tls-client [matched with --tls-server on
=
- *               the other end of the connection]
- * --tls-server [matche=
d with --tls-client on
- *               the other end of the connection]
-=
 */
-char *
-options_string(const struct options *o, const struct frame *fr=
ame, struct tuntap *tt,
-               openvpn_net_ctx_t *ctx, bool remote=
, struct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf(OPTION_LINE_=
SIZE);
-    bool tt_local =3D false;
-
-    buf_printf(&out, "V4");
-
-    =
/*
-     * Tunnel Options
-     */
-
-    buf_printf(&out, ",dev-type %s", =
dev_type_string(o->dev, o->dev_type));
-    /* the link-mtu that we send ha=
s only a meaning if have a fixed
-     * cipher (p2p) or have a fallback ci=
pher configured for older non
-     * ncp clients=2E But not sending it wil=
l make even 2=2E4 complain
-     * about it being missing=2E So still send =
it=2E */
-    buf_printf(&out, ",link-mtu %u", (unsigned int)calc_options_s=
tring_link_mtu(o, frame));
-
-    if (o->ce=2Eocc_mtu !=3D 0)
-    {
-     =
   buf_printf(&out, ",tun-mtu %d", o->ce=2Eocc_mtu);
-    }
-    else
-    =
{
-        buf_printf(&out, ",tun-mtu %d", frame->tun_mtu);
-    }
-
-    b=
uf_printf(&out, ",proto %s", proto_remote(o->ce=2Eproto, remote));
-
-    b=
ool p2p_nopull =3D o->mode =3D=3D MODE_POINT_TO_POINT && !PULL_DEFINED(o);
=
-    /* send tun_ipv6 only in peer2peer mode - in client/server mode, it
- =
    * is usually pushed by the server, triggering a non-helpful warning
-  =
   */
-    if (o->ifconfig_ipv6_local && p2p_nopull)
-    {
-        buf_pr=
intf(&out, ",tun-ipv6");
-    }
-
-    /*
-     * Try to get ifconfig param=
eters into the options string=2E
-     * If tt is undefined, make a tempora=
ry instantiation=2E
-     */
-    if (!tt)
-    {
-        tt =3D init_tun(=
o->dev, o->dev_type, o->topology, o->ifconfig_local,
-                     =
 o->ifconfig_remote_netmask, o->ifconfig_ipv6_local, o->ifconfig_ipv6_netbi=
ts,
-                      o->ifconfig_ipv6_remote, NULL, NULL, false, NULL=
, ctx, NULL);
-        if (tt)
-        {
-            tt_local =3D true;
-=
        }
-    }
-
-    if (tt && p2p_nopull)
-    {
-        const char *i=
os =3D ifconfig_options_string(tt, remote, o->ifconfig_nowarn, gc);
-      =
  if (ios && strlen(ios))
-        {
-            buf_printf(&out, ",ifconf=
ig %s", ios);
-        }
-    }
-    if (tt_local)
-    {
-        free(tt)=
;
-        tt =3D NULL;
-    }
-
-#ifdef USE_COMP
-    if (o->comp=2Ealg !=
=3D COMP_ALG_UNDEF)
-    {
-        buf_printf(&out, ",comp-lzo"); /* for c=
ompatibility, this simply indicates that compression
-                     =
                     context is active, not necessarily LZO per-se */
-    =
}
-#endif
-
-#ifdef ENABLE_FRAGMENT
-    if (o->ce=2Efragment)
-    {
-    =
    buf_printf(&out, ",mtu-dynamic");
-    }
-#endif
-
-#define TLS_CLIENT =
(o->tls_client)
-#define TLS_SERVER (o->tls_server)
-
-    /*
-     * Key d=
irection
-     */
-    {
-        const char *kd =3D keydirection2ascii(o->=
key_direction, remote, false);
-        if (kd)
-        {
-            buf=
_printf(&out, ",keydir %s", kd);
-        }
-    }
-
-    /*
-     * Crypto=
 Options
-     */
-    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVE=
R)
-    {
-        struct key_type kt;
-
-        ASSERT((o->shared_secret_=
file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) <=3D =
1);
-
-        /* Skip resolving BF-CBC to allow SSL libraries without BF-C=
BC
-         * to work here in the default configuration */
-        const =
char *ciphername =3D o->ciphername;
-        size_t keysize =3D 0;
-
-     =
   if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
-        {
-            in=
it_key_type(&kt, "none", o->authname, true, false);
-            keysize =
=3D 128;
-        }
-        else
-        {
-            init_key_type(&kt=
, o->ciphername, o->authname, true, false);
-            ciphername =3D cip=
her_kt_name(kt=2Ecipher);
-            if (cipher_defined(o->ciphername))
-=
            {
-                keysize =3D cipher_kt_key_size(kt=2Ecipher) =
* 8;
-            }
-        }
-        /* Only announce the cipher to our =
peer if we are willing to
-         * support it */
-        if (p2p_nopull=
 || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
-        {
-      =
      buf_printf(&out, ",cipher %s", ciphername);
-        }
-        buf_p=
rintf(&out, ",auth %s", md_kt_name(kt=2Edigest));
-        buf_printf(&out,=
 ",keysize %zu", keysize);
-        if (o->shared_secret_file)
-        {
-=
            buf_printf(&out, ",secret");
-        }
-    }
-
-    /*
-     =
* SSL Options
-     */
-    {
-        if (TLS_CLIENT || TLS_SERVER)
-     =
   {
-            if (o->ce=2Etls_auth_file)
-            {
-              =
  buf_printf(&out, ",tls-auth");
-            }
-            /* Not adding =
tls-crypt here, because we won't reach this code if
-             * tls-aut=
h/tls-crypt does not match=2E  Removing tls-auth here would
-             *=
 break stuff, so leaving that in place=2E */
-
-            buf_printf(&out=
, ",key-method %d", KEY_METHOD_2);
-        }
-
-        if (remote)
-     =
   {
-            if (TLS_CLIENT)
-            {
-                buf_print=
f(&out, ",tls-server");
-            }
-            else if (TLS_SERVER)
- =
           {
-                buf_printf(&out, ",tls-client");
-           =
 }
-        }
-        else
-        {
-            if (TLS_CLIENT)
-      =
      {
-                buf_printf(&out, ",tls-client");
-            }
- =
           else if (TLS_SERVER)
-            {
-                buf_printf(=
&out, ",tls-server");
-            }
-        }
-    }
-
-#undef TLS_CLIENT=

-#undef TLS_SERVER
-
-    return BSTR(&out);
-}
-
-/*
- * Compare option s=
trings for equality=2E
- * If the first two chars of the strings differ, it=
 means that
- * we are looking at different versions of the options string,=

- * therefore don't compare them and return true=2E
- */
-
-bool
-options_=
cmp_equal(char *actual, const char *expected)
-{
-    return options_cmp_eq=
ual_safe(actual, expected, strlen(actual) + 1);
-}
-
-void
-options_warning=
(char *actual, const char *expected)
-{
-    options_warning_safe(actual, e=
xpected, strlen(actual) + 1);
-}
-
-static const char *
-options_warning_ex=
tract_parm1(const char *option_string, struct gc_arena *gc_ret)
-{
-    str=
uct gc_arena gc =3D gc_new();
-    struct buffer b =3D string_alloc_buf(opt=
ion_string, &gc);
-    char *p =3D gc_malloc(OPTION_PARM_SIZE, false, &gc);=

-    const char *ret;
-
-    buf_parse(&b, ' ', p, OPTION_PARM_SIZE);
-   =
 ret =3D string_alloc(p, gc_ret);
-    gc_free(&gc);
-    return ret;
-}
-
=
-static void
-options_warning_safe_scan2(const msglvl_t msglevel, const int=
 delim,
-                           const bool report_inconsistent, const c=
har *p1,
-                           const struct buffer *b2_src, const cha=
r *b1_name,
-                           const char *b2_name)
-{
-    /* We =
will stop sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
-     *=
 OCC in a future version (because it's not useful)=2E To reduce questions
-=
     * when interoperating, we no longer printing a warning about it=2E
-  =
   */
-    if (strprefix(p1, "key-method ") || strprefix(p1, "keydir ") || =
strprefix(p1, "proto ")
-        || streq(p1, "tls-auth") || strprefix(p1, =
"tun-ipv6") || strprefix(p1, "cipher "))
-    {
-        return;
-    }
-
-=
    if (strlen(p1) > 0)
-    {
-        struct gc_arena gc =3D gc_new();
- =
       struct buffer b2 =3D *b2_src;
-        const char *p1_prefix =3D opt=
ions_warning_extract_parm1(p1, &gc);
-        char *p2 =3D gc_malloc(OPTION=
_PARM_SIZE, false, &gc);
-
-        while (buf_parse(&b2, delim, p2, OPTION=
_PARM_SIZE))
-        {
-            if (strlen(p2))
-            {
-      =
          const char *p2_prefix =3D options_warning_extract_parm1(p2, &gc);=

-
-                if (!strcmp(p1, p2))
-                {
-              =
      goto done;
-                }
-                if (!strcmp(p1_prefix,=
 p2_prefix))
-                {
-                    if (report_inconsisten=
t)
-                    {
-                        msg(msglevel, "WARNING: =
'%s' is used inconsistently, %s=3D'%s', %s=3D'%s'",
-                      =
      safe_print(p1_prefix, &gc), b1_name, safe_print(p1, &gc), b2_name,
- =
                           safe_print(p2, &gc));
-                    }
-  =
                  goto done;
-                }
-            }
-        }
-=

-        msg(msglevel, "WARNING: '%s' is present in %s config but missing =
in %s config, %s=3D'%s'",
-            safe_print(p1_prefix, &gc), b1_name,=
 b2_name, b1_name, safe_print(p1, &gc));
-
-done:
-        gc_free(&gc);
- =
   }
-}
-
-static void
-options_warning_safe_scan1(const msglvl_t msglevel,=
 const int delim,
-                           const bool report_inconsisten=
t, const struct buffer *b1_src,
-                           const struct bu=
ffer *b2_src, const char *b1_name, const char *b2_name)
-{
-    struct gc_a=
rena gc =3D gc_new();
-    struct buffer b =3D *b1_src;
-    char *p =3D gc=
_malloc(OPTION_PARM_SIZE, true, &gc);
-
-    while (buf_parse(&b, delim, p,=
 OPTION_PARM_SIZE))
-    {
-        options_warning_safe_scan2(msglevel, de=
lim, report_inconsistent, p, b2_src, b1_name,
-                            =
       b2_name);
-    }
-
-    gc_free(&gc);
-}
-
-static void
-options_war=
ning_safe_ml(const msglvl_t msglevel, char *actual, const char *expected, s=
ize_t actual_n)
-{
-    struct gc_arena gc =3D gc_new();
-
-    if (actual_=
n > 0)
-    {
-        struct buffer local =3D alloc_buf_gc(OPTION_PARM_SIZ=
E + 16, &gc);
-        struct buffer remote =3D alloc_buf_gc(OPTION_PARM_SI=
ZE + 16, &gc);
-        actual[actual_n - 1] =3D 0;
-
-        buf_printf(&=
local, "version %s", expected);
-        buf_printf(&remote, "version %s", =
actual);
-
-        options_warning_safe_scan1(msglevel, ',', true, &local,=
 &remote, "local", "remote");
-
-        options_warning_safe_scan1(msgleve=
l, ',', false, &remote, &local, "remote", "local");
-    }
-
-    gc_free(&=
gc);
-}
-
-bool
-options_cmp_equal_safe(char *actual, const char *expected,=
 size_t actual_n)
-{
-    struct gc_arena gc =3D gc_new();
-    bool ret =
=3D true;
-
-    if (actual_n > 0)
-    {
-        actual[actual_n - 1] =3D=
 0;
-        if (strncmp(actual, expected, 2))
-        {
-            msg(=
D_SHOW_OCC, "NOTE: Options consistency check may be skewed by version diffe=
rences");
-            options_warning_safe_ml(D_SHOW_OCC, actual, expected=
, actual_n);
-        }
-        else
-        {
-            ret =3D !strc=
mp(actual, expected);
-        }
-    }
-    gc_free(&gc);
-    return ret;=

-}
-
-void
-options_warning_safe(char *actual, const char *expected, size_=
t actual_n)
-{
-    options_warning_safe_ml(D_SHOW_OCC, actual, expected, a=
ctual_n);
-}
-
-const char *
-options_string_version(const char *s, struct =
gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(4, gc);
-    strnc=
pynt((char *)BPTR(&out), s, 3);
-    return BSTR(&out);
-}
-
-#if defined(_=
_GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC di=
agnostic ignored "-Wsign-compare"
-#endif
-
-char *
-options_string_extract=
_option(const char *options_string, const char *opt_name, struct gc_arena *=
gc)
-{
-    char *ret =3D NULL;
-    const size_t opt_name_len =3D strlen(o=
pt_name);
-
-    const char *p =3D options_string;
-    while (p)
-    {
- =
       if (0 =3D=3D strncmp(p, opt_name, opt_name_len) && strlen(p) > (opt_=
name_len + 1)
-            && p[opt_name_len] =3D=3D ' ')
-        {
-     =
       /* option found, extract value */
-            const char *start =3D=
 &p[opt_name_len + 1];
-            const char *end =3D strchr(p, ',');
-  =
          size_t val_len =3D end ? end - start : strlen(start);
-          =
  ret =3D gc_malloc(val_len + 1, true, gc);
-            memcpy(ret, start,=
 val_len);
-            break;
-        }
-        p =3D strchr(p, ',');
- =
       if (p)
-        {
-            p++; /* skip delimiter */
-        }
=
-    }
-    return ret;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-=
#pragma GCC diagnostic pop
-#endif
-
-/*
  * parse/print topology coding
  =
*/
 
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index d=
42773f=2E=2E0fd505a 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/=
options=2Eh
@@ -903,33 +903,6 @@
 
 bool string_defined_equal(const char *s=
1, const char *s2);
 
-const char *options_string_version(const char *s, st=
ruct gc_arena *gc);
-
-char *options_string(const struct options *o, const =
struct frame *frame, struct tuntap *tt,
-                     openvpn_net_c=
tx_t *ctx, bool remote, struct gc_arena *gc);
-
-bool options_cmp_equal_saf=
e(char *actual, const char *expected, size_t actual_n);
-
-void options_war=
ning_safe(char *actual, const char *expected, size_t actual_n);
-
-bool opt=
ions_cmp_equal(char *actual, const char *expected);
-
-void options_warning=
(char *actual, const char *expected);
-
-/**
- * Given an OpenVPN options s=
tring, extract the value of an option=2E
- *
- * @param options_string     =
   Zero-terminated, comma-separated options string
- * @param opt_name     =
         The name of the option to extract
- * @param gc                   =
 The gc to allocate the return value
- *
- * @return gc-allocated value of =
option with name opt_name if option was found,
- *         or NULL otherwis=
e=2E
- */
-char *options_string_extract_option(const char *options_string, =
const char *opt_name,
-                                    struct gc_arena =
*gc);
-
-
 void options_postprocess(struct options *options, struct env_set=
 *es);
 
 bool options_postprocess_pull(struct options *o, struct env_set *=
es);
diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/options_stri=
ng=2Ec
new file mode 100644
index 0000000=2E=2Ed3b29b8
--- /dev/null
+++ b/=
src/openvpn/options_string=2Ec
@@ -0,0 +1,429 @@
+/*
+ *  OpenVPN -- An app=
lication to securely tunnel IP networks
+ *             over a single UDP p=
ort, with support for SSL/TLS-based
+ *             session authentication =
and key exchange,
+ *             packet encryption, packet authentication,=
 and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026=
 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; =
you can redistribute it and/or modify
+ *  it under the terms of the GNU Ge=
neral Public License version 2
+ *  as published by the Free Software Found=
ation=2E
+ *
+ *  This program is distributed in the hope that it will be u=
seful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  G=
NU General Public License for more details=2E
+ *
+ *  You should have rece=
ived a copy of the GNU General Public License along
+ *  with this program;=
 if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CON=
FIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include =
"buffer=2Eh"
+#include "crypto=2Eh"
+#include "error=2Eh"
+#include "mtu=2E=
h"
+#include "options=2Eh"
+#include "socket_util=2Eh"
+#include "ssl=2Eh"
=
+#include "ssl_ncp=2Eh"
+#include "tun=2Eh"
+
+#include <string=2Eh>
+
+cha=
r *
+options_string(const struct options *o, const struct frame *frame, str=
uct tuntap *tt,
+               openvpn_net_ctx_t *ctx, bool remote, struct=
 gc_arena *gc)
+{
+    struct buffer out =3D alloc_buf(OPTION_LINE_SIZE);
+=
    bool tt_local =3D false;
+
+    buf_printf(&out, "V4");
+
+    /*
+    =
 * Tunnel Options
+     */
+
+    buf_printf(&out, ",dev-type %s", dev_type=
_string(o->dev, o->dev_type));
+    /* the link-mtu that we send has only a=
 meaning if have a fixed
+     * cipher (p2p) or have a fallback cipher con=
figured for older non
+     * ncp clients=2E But not sending it will make e=
ven 2=2E4 complain
+     * about it being missing=2E So still send it=2E */=

+    buf_printf(&out, ",link-mtu %u", (unsigned int)calc_options_string_li=
nk_mtu(o, frame));
+
+    if (o->ce=2Eocc_mtu !=3D 0)
+    {
+        buf_p=
rintf(&out, ",tun-mtu %d", o->ce=2Eocc_mtu);
+    }
+    else
+    {
+     =
   buf_printf(&out, ",tun-mtu %d", frame->tun_mtu);
+    }
+
+    buf_print=
f(&out, ",proto %s", proto_remote(o->ce=2Eproto, remote));
+
+    bool p2p_=
nopull =3D o->mode =3D=3D MODE_POINT_TO_POINT && !PULL_DEFINED(o);
+    /* =
send tun_ipv6 only in peer2peer mode - in client/server mode, it
+     * is=
 usually pushed by the server, triggering a non-helpful warning
+     */
+ =
   if (o->ifconfig_ipv6_local && p2p_nopull)
+    {
+        buf_printf(&ou=
t, ",tun-ipv6");
+    }
+
+    /*
+     * Try to get ifconfig parameters in=
to the options string=2E
+     * If tt is undefined, make a temporary insta=
ntiation=2E
+     */
+    if (!tt)
+    {
+        tt =3D init_tun(o->dev, =
o->dev_type, o->topology, o->ifconfig_local,
+                      o->ifco=
nfig_remote_netmask, o->ifconfig_ipv6_local, o->ifconfig_ipv6_netbits,
+   =
                   o->ifconfig_ipv6_remote, NULL, NULL, false, NULL, ctx, N=
ULL);
+        if (tt)
+        {
+            tt_local =3D true;
+        =
}
+    }
+
+    if (tt && p2p_nopull)
+    {
+        const char *ios =3D i=
fconfig_options_string(tt, remote, o->ifconfig_nowarn, gc);
+        if (io=
s && strlen(ios))
+        {
+            buf_printf(&out, ",ifconfig %s", =
ios);
+        }
+    }
+    if (tt_local)
+    {
+        free(tt);
+     =
   tt =3D NULL;
+    }
+
+#ifdef USE_COMP
+    if (o->comp=2Ealg !=3D COMP_=
ALG_UNDEF)
+    {
+        /* for compatibility, this simply indicates that=
 compression
+         * context is active, not necessarily LZO per-se */
+=
        buf_printf(&out, ",comp-lzo");
+    }
+#endif
+
+#ifdef ENABLE_FRAG=
MENT
+    if (o->ce=2Efragment)
+    {
+        buf_printf(&out, ",mtu-dyna=
mic");
+    }
+#endif
+
+#define TLS_CLIENT (o->tls_client)
+#define TLS_SE=
RVER (o->tls_server)
+
+    /*
+     * Key direction
+     */
+    {
+     =
   const char *kd =3D keydirection2ascii(o->key_direction, remote, false);
=
+        if (kd)
+        {
+            buf_printf(&out, ",keydir %s", kd)=
;
+        }
+    }
+
+    /*
+     * Crypto Options
+     */
+    if (o->s=
hared_secret_file || TLS_CLIENT || TLS_SERVER)
+    {
+        struct key_t=
ype kt;
+
+        ASSERT((o->shared_secret_file !=3D NULL) + (TLS_CLIENT =
=3D=3D true) + (TLS_SERVER =3D=3D true) <=3D 1);
+
+        /* Skip resolvi=
ng BF-CBC to allow SSL libraries without BF-CBC
+         * to work here in=
 the default configuration */
+        const char *ciphername =3D o->cipher=
name;
+        size_t keysize =3D 0;
+
+        if (strcmp(o->ciphername, "=
BF-CBC") =3D=3D 0)
+        {
+            init_key_type(&kt, "none", o->au=
thname, true, false);
+            keysize =3D 128;
+        }
+        els=
e
+        {
+            init_key_type(&kt, o->ciphername, o->authname, tr=
ue, false);
+            ciphername =3D cipher_kt_name(kt=2Ecipher);
+     =
       if (cipher_defined(o->ciphername))
+            {
+                k=
eysize =3D cipher_kt_key_size(kt=2Ecipher) * 8;
+            }
+        }
+=
        /* Only announce the cipher to our peer if we are willing to
+     =
    * support it */
+        if (p2p_nopull || tls_item_in_cipher_list(ciph=
ername, o->ncp_ciphers))
+        {
+            buf_printf(&out, ",cipher =
%s", ciphername);
+        }
+        buf_printf(&out, ",auth %s", md_kt_na=
me(kt=2Edigest));
+        buf_printf(&out, ",keysize %zu", keysize);
+    =
    if (o->shared_secret_file)
+        {
+            buf_printf(&out, ",s=
ecret");
+        }
+    }
+
+    /*
+     * SSL Options
+     */
+    {
+ =
       if (TLS_CLIENT || TLS_SERVER)
+        {
+            if (o->ce=2Etl=
s_auth_file)
+            {
+                buf_printf(&out, ",tls-auth");=

+            }
+            /* Not adding tls-crypt here, because we won't=
 reach this code if
+             * tls-auth/tls-crypt does not match=2E  R=
emoving tls-auth here would
+             * break stuff, so leaving that in=
 place=2E */
+
+            buf_printf(&out, ",key-method %d", KEY_METHOD_2=
);
+        }
+
+        if (remote)
+        {
+            if (TLS_CLIENT=
)
+            {
+                buf_printf(&out, ",tls-server");
+       =
     }
+            else if (TLS_SERVER)
+            {
+                bu=
f_printf(&out, ",tls-client");
+            }
+        }
+        else
+   =
     {
+            if (TLS_CLIENT)
+            {
+                buf_pri=
ntf(&out, ",tls-client");
+            }
+            else if (TLS_SERVER)
=
+            {
+                buf_printf(&out, ",tls-server");
+         =
   }
+        }
+    }
+
+#undef TLS_CLIENT
+#undef TLS_SERVER
+
+    retur=
n BSTR(&out);
+}
+
+/**
+ * Compare option strings for equality=2E
+ *
+ * =
If the first two chars of the strings differ, it means that
+ * we are look=
ing at different versions of the options string,
+ * therefore don't compar=
e them and return true=2E
+ */
+static const char *
+options_warning_extrac=
t_parm1(const char *option_string, struct gc_arena *gc_ret)
+{
+    struct =
gc_arena gc =3D gc_new();
+    struct buffer b =3D string_alloc_buf(option_=
string, &gc);
+    char *p =3D gc_malloc(OPTION_PARM_SIZE, false, &gc);
+  =
  const char *ret;
+
+    buf_parse(&b, ' ', p, OPTION_PARM_SIZE);
+    ret=
 =3D string_alloc(p, gc_ret);
+    gc_free(&gc);
+    return ret;
+}
+
+sta=
tic void
+options_warning_safe_scan2(const msglvl_t msglevel, const int del=
im,
+                           const bool report_inconsistent, const char =
*p1,
+                           const struct buffer *b2_src, const char *b=
1_name,
+                           const char *b2_name)
+{
+    /* We will=
 stop sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
+     * OCC=
 in a future version (because it's not useful)=2E To reduce questions
+    =
 * when interoperating, we no longer printing a warning about it=2E
+     *=
/
+    if (strprefix(p1, "key-method ") || strprefix(p1, "keydir ") || strp=
refix(p1, "proto ")
+        || streq(p1, "tls-auth") || strprefix(p1, "tun=
-ipv6") || strprefix(p1, "cipher "))
+    {
+        return;
+    }
+
+    =
if (strlen(p1) > 0)
+    {
+        struct gc_arena gc =3D gc_new();
+     =
   struct buffer b2 =3D *b2_src;
+        const char *p1_prefix =3D options=
_warning_extract_parm1(p1, &gc);
+        char *p2 =3D gc_malloc(OPTION_PAR=
M_SIZE, false, &gc);
+
+        while (buf_parse(&b2, delim, p2, OPTION_PAR=
M_SIZE))
+        {
+            if (strlen(p2))
+            {
+          =
      const char *p2_prefix =3D options_warning_extract_parm1(p2, &gc);
+
+=
                if (!strcmp(p1, p2))
+                {
+                  =
  goto done;
+                }
+                if (!strcmp(p1_prefix, p2_=
prefix))
+                {
+                    if (report_inconsistent)
+=
                    {
+                        msg(msglevel, "WARNING: '%s'=
 is used inconsistently, %s=3D'%s', %s=3D'%s'",
+                          =
  safe_print(p1_prefix, &gc), b1_name, safe_print(p1, &gc), b2_name,
+     =
                       safe_print(p2, &gc));
+                    }
+      =
              goto done;
+                }
+            }
+        }
+
+  =
      msg(msglevel, "WARNING: '%s' is present in %s config but missing in %=
s config, %s=3D'%s'",
+            safe_print(p1_prefix, &gc), b1_name, b2_=
name, b1_name, safe_print(p1, &gc));
+
+done:
+        gc_free(&gc);
+    }=

+}
+
+static void
+options_warning_safe_scan1(const msglvl_t msglevel, con=
st int delim,
+                           const bool report_inconsistent, c=
onst struct buffer *b1_src,
+                           const struct buffer=
 *b2_src, const char *b1_name, const char *b2_name)
+{
+    struct gc_arena=
 gc =3D gc_new();
+    struct buffer b =3D *b1_src;
+    char *p =3D gc_mal=
loc(OPTION_PARM_SIZE, true, &gc);
+
+    while (buf_parse(&b, delim, p, OPT=
ION_PARM_SIZE))
+    {
+        options_warning_safe_scan2(msglevel, delim,=
 report_inconsistent, p, b2_src, b1_name,
+                                =
   b2_name);
+    }
+
+    gc_free(&gc);
+}
+
+static void
+options_warning=
_safe_ml(const msglvl_t msglevel, char *actual, const char *expected, size_=
t actual_n)
+{
+    struct gc_arena gc =3D gc_new();
+
+    if (actual_n > =
0)
+    {
+        struct buffer local =3D alloc_buf_gc(OPTION_PARM_SIZE + =
16, &gc);
+        struct buffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE +=
 16, &gc);
+        actual[actual_n - 1] =3D 0;
+
+        buf_printf(&loca=
l, "version %s", expected);
+        buf_printf(&remote, "version %s", actu=
al);
+
+        options_warning_safe_scan1(msglevel, ',', true, &local, &re=
mote, "local", "remote");
+
+        options_warning_safe_scan1(msglevel, '=
,', false, &remote, &local, "remote", "local");
+    }
+
+    gc_free(&gc);=

+}
+
+bool
+options_cmp_equal_safe(char *actual, const char *expected, siz=
e_t actual_n)
+{
+    struct gc_arena gc =3D gc_new();
+    bool ret =3D tr=
ue;
+
+    if (actual_n > 0)
+    {
+        actual[actual_n - 1] =3D 0;
+ =
       if (strncmp(actual, expected, 2))
+        {
+            msg(D_SHOW=
_OCC, "NOTE: Options consistency check may be skewed by version differences=
");
+            options_warning_safe_ml(D_SHOW_OCC, actual, expected, actu=
al_n);
+        }
+        else
+        {
+            ret =3D !strcmp(act=
ual, expected);
+        }
+    }
+    gc_free(&gc);
+    return ret;
+}
+
=
+bool
+options_cmp_equal(char *actual, const char *expected)
+{
+    return=
 options_cmp_equal_safe(actual, expected, strlen(actual) + 1);
+}
+
+void
+=
options_warning_safe(char *actual, const char *expected, size_t actual_n)
+=
{
+    options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
+}
=
+
+void
+options_warning(char *actual, const char *expected)
+{
+    option=
s_warning_safe(actual, expected, strlen(actual) + 1);
+}
+
+const char *
+o=
ptions_string_version(const char *s, struct gc_arena *gc)
+{
+    struct bu=
ffer out =3D alloc_buf_gc(4, gc);
+    strncpynt((char *)BPTR(&out), s, 3);=

+    return BSTR(&out);
+}
+
+#if defined(__GNUC__) || defined(__clang__)
=
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compar=
e"
+#endif
+
+char *
+options_string_extract_option(const char *options_str=
ing, const char *opt_name, struct gc_arena *gc)
+{
+    char *ret =3D NULL;=

+    const size_t opt_name_len =3D strlen(opt_name);
+
+    const char *p =
=3D options_string;
+    while (p)
+    {
+        if (0 =3D=3D strncmp(p, =
opt_name, opt_name_len) && strlen(p) > (opt_name_len + 1)
+            && p=
[opt_name_len] =3D=3D ' ')
+        {
+            /* option found, extract=
 value */
+            const char *start =3D &p[opt_name_len + 1];
+       =
     const char *end =3D strchr(p, ',');
+            size_t val_len =3D en=
d ? end - start : strlen(start);
+            ret =3D gc_malloc(val_len + 1=
, true, gc);
+            memcpy(ret, start, val_len);
+            break;
=
+        }
+        p =3D strchr(p, ',');
+        if (p)
+        {
+     =
       p++; /* skip delimiter */
+        }
+    }
+    return ret;
+}
+
+#=
if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#en=
dif
diff --git a/src/openvpn/options_string=2Eh b/src/openvpn/options_strin=
g=2Eh
new file mode 100644
index 0000000=2E=2E02efed3
--- /dev/null
+++ b/s=
rc/openvpn/options_string=2Eh
@@ -0,0 +1,97 @@
+/*
+ *  OpenVPN -- An appli=
cation to securely tunnel IP networks
+ *             over a single UDP por=
t, with support for SSL/TLS-based
+ *             session authentication an=
d key exchange,
+ *             packet encryption, packet authentication, a=
nd
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 O=
penVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; yo=
u can redistribute it and/or modify
+ *  it under the terms of the GNU Gene=
ral Public License version 2
+ *  as published by the Free Software Foundat=
ion=2E
+ *
+ *  This program is distributed in the hope that it will be use=
ful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU=
 General Public License for more details=2E
+ *
+ *  You should have receiv=
ed a copy of the GNU General Public License along
+ *  with this program; i=
f not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef OPTIONS_S=
TRING_H
+#define OPTIONS_STRING_H
+
+#include "buffer=2Eh"
+#include "optio=
ns=2Eh"
+
+const char *options_string_version(const char *s, struct gc_aren=
a *gc);
+
+/**
+ * Build an options string to represent data channel encryp=
tion options=2E
+ * This string must match exactly between peers=2E  The ke=
ysize is checked
+ * separately by read_key()=2E
+ *
+ * The following opti=
ons must match on both peers:
+ *
+ * Tunnel options:
+ *
+ * --dev tun|tap=
 [unit number need not match]
+ * --dev-type tun|tap
+ * --link-mtu
+ * --u=
dp-mtu
+ * --tun-mtu
+ * --proto udp
+ * --proto tcp-client [matched with -=
-proto tcp-server
+ *                     on the other end of the connectio=
n]
+ * --proto tcp-server [matched with --proto tcp-client on
+ *          =
           the other end of the connection]
+ * --tun-ipv6
+ * --ifconfig x=
 y [matched with --ifconfig y x on
+ *                 the other end of the=
 connection]
+ *
+ * --comp-lzo
+ * --compress alg
+ * --fragment
+ *
+ * C=
rypto Options:
+ *
+ * --cipher
+ * --auth
+ * --secret
+ *
+ * SSL Options=
:
+ *
+ * --tls-auth
+ * --tls-client [matched with --tls-server on
+ *    =
           the other end of the connection]
+ * --tls-server [matched with =
--tls-client on
+ *               the other end of the connection]
+ */
+ch=
ar *options_string(const struct options *o, const struct frame *frame, stru=
ct tuntap *tt,
+                     openvpn_net_ctx_t *ctx, bool remote, s=
truct gc_arena *gc);
+
+bool options_cmp_equal_safe(char *actual, const cha=
r *expected, size_t actual_n);
+
+void options_warning_safe(char *actual, c=
onst char *expected, size_t actual_n);
+
+bool options_cmp_equal(char *actu=
al, const char *expected);
+
+void options_warning(char *actual, const char=
 *expected);
+
+/**
+ * Given an OpenVPN options string, extract the value =
of an option=2E
+ *
+ * @param options_string        Zero-terminated, comma=
-separated options string
+ * @param opt_name              The name of the =
option to extract
+ * @param gc                    The gc to allocate the r=
eturn value
+ *
+ * @return gc-allocated value of option with name opt_name=
 if option was found,
+ *         or NULL otherwise=2E
+ */
+char *options_=
string_extract_option(const char *options_string, const char *opt_name,
+  =
                                  struct gc_arena *gc);
+
+
+#endif
diff --=
git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 01e45fd=2E=2Ed5bd602 =
100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -62,6 +62,7 @=
@
 #include "auth_token=2Eh"
 #include "mss=2Eh"
 #include "dco=2Eh"
+#incl=
ude "options_string=2Eh"
 
 #include "memdbg=2Eh"
 #include "openvpn=2Eh"

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6824058fc9c4efd48ceeb3=
2d4164f97b2a243d85
Gerrit-Change-Number: 1773
Gerrit-PatchSet: 6
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--1IkqdFur5jU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1773?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">options: Factor out options_string code fr=
om options=2Ec<br><br>options=2Ec is a huge, unwieldly file=2E So remove so=
me<br>closely related code that has no direct dependencies<br>with the othe=
r functions in the file=2E<br><br>This time it is the functions related to =
the creation<br>and testing of the options string=2E<br><br>Change-Id: I682=
4058fc9c4efd48ceeb32d4164f97b2a243d85<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
73<br>Message-Id: &lt;20260820124355=2E23332-1-gert@greenie=2Emuc=2Ede&gt;<=
br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38563=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M=
 src/openvpn/init=2Ec<br>M src/openvpn/occ=2Ec<br>M src/openvpn/options=2Ec=
<br>M src/openvpn/options=2Eh<br>A src/openvpn/options_string=2Ec<br>A src/=
openvpn/options_string=2Eh<br>M src/openvpn/ssl=2Ec<br>9 files changed, 532=
 insertions(+), 458 deletions(-)<br><br></pre>
<pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index 8866520=2E=2E2c3324d 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -533,6 +533,8 @@</span><br><span>     src/openvpn/op=
tions_parse=2Ec</span><br><span>     src/openvpn/options_show=2Ec</span><br=
><span>     src/openvpn/options_show=2Eh</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    src/openvpn/options_string=2Ec</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options_string=2Eh</spa=
n><br><span>     src/openvpn/otime=2Ec</span><br><span>     src/openvpn/oti=
me=2Eh</span><br><span>     src/openvpn/ovpn_dco_win=2Eh</span><br><span>di=
ff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br>=
<span>index 42b4404=2E=2E7fd12b4 100644</span><br><span>--- a/src/openvpn/M=
akefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><spa=
n>@@ -110,6 +110,7 @@</span><br><span> 	openvpn=2Ec openvpn=2Eh \</span><br=
><span> 	options=2Ec options=2Eh \</span><br><span> 	options_show=2Ec optio=
ns_show=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	optio=
ns_string=2Ec options_string=2Eh \</span><br><span> 	options_util=2Ec optio=
ns_util=2Eh \</span><br><span> 	options_parse=2Ec \</span><br><span> 	otime=
=2Ec otime=2Eh \</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/op=
envpn/init=2Ec</span><br><span>index a90fe69=2E=2Efa62cdd 100644</span><br>=
<span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec=
</span><br><span>@@ -54,6 +54,7 @@</span><br><span> #include &quot;dco=2Eh&=
quot;</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span>=
 #include &quot;schedule=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;options_string=2Eh&quot;</span><br><span> </s=
pan><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/occ=2Ec b/src/openvpn/occ=2Ec</span><br><spa=
n>index aa262a8=2E=2Ef25ae19 100644</span><br><span>--- a/src/openvpn/occ=
=2Ec</span><br><span>+++ b/src/openvpn/occ=2Ec</span><br><span>@@ -29,7 +29=
,7 @@</span><br><span> #include &quot;occ=2Eh&quot;</span><br><span> #inclu=
de &quot;forward=2Eh&quot;</span><br><span> #include &quot;memdbg=2Eh&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_string=2Eh&quot;<=
/span><br><span> </span><br><span> /*</span><br><span>  * This random strin=
g identifies an OpenVPN</span><br><span>diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec</span><br><span>index 391739c=2E=2E9bd6f01 1006=
44</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/=
openvpn/options=2Ec</span><br><span>@@ -3363,436 +3363,6 @@</span><br><span=
> }</span><br><span> </span><br><span> /*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Build an options string to represent data channel en=
cryption options=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 This string must match exactly between peers=2E  The keysize is checked</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * separately by read_ke=
y()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * The following options must matc=
h on both peers:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Tunnel options:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * --dev tun|tap [unit number need not match]<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --dev-type tun|tap<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --link-mtu</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * --udp-mtu</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * --tun-mtu</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * --proto udp</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * --proto tcp-client [matched with --proto tcp-server<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *                    =
 on the other end of the connection]</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * --proto tcp-server [matched with --proto tcp-client on</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *                     t=
he other end of the connection]</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * --tun-ipv6</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * --ifconfig x y [matched with --ifconfig y x on</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *                 the other end of the con=
nection]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * --comp-lzo</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * --compress alg</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * --fragment</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Crypto Options:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --cipher</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * --auth</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * --secret</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * SSL Options:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tls-auth</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tls-client [matched w=
ith --tls-server on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
               the other end of the connection]</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * --tls-server [matched with --tls-client on</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *               the othe=
r end of the connection]</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-options_string(const struct op=
tions *o, const struct frame *frame, struct tuntap *tt,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-               openvpn_net_ctx_t *ctx, bo=
ol remote, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 buffer out =3D alloc_buf(OPTION_LINE_SIZE);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    bool tt_local =3D false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    buf_printf(&amp;out, &quot;V4&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 * Tunnel Options</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;,dev-typ=
e %s&quot;, dev_type_string(o-&gt;dev, o-&gt;dev_type));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* the link-mtu that we send has onl=
y a meaning if have a fixed</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * cipher (p2p) or have a fallback cipher configured for older no=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * ncp clients=
=2E But not sending it will make even 2=2E4 complain</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * about it being missing=2E So still s=
end it=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_p=
rintf(&amp;out, &quot;,link-mtu %u&quot;, (unsigned int)calc_options_string=
_link_mtu(o, frame));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;ce=2Eoc=
c_mtu !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;=
out, &quot;,tun-mtu %d&quot;, o-&gt;ce=2Eocc_mtu);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_prin=
tf(&amp;out, &quot;,tun-mtu %d&quot;, frame-&gt;tun_mtu);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   buf_printf(&amp;out, &quot;,proto %s&quot;, proto_remote(o-&gt;ce=2Eprot=
o, remote));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    bool p2p_nopull =3D o-&gt;=
mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !PULL_DEFINED(o);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* send tun_ipv6 only in peer2pe=
er mode - in client/server mode, it</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * is usually pushed by the server, triggering a non-help=
ful warning</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;ifconfig_i=
pv6_local &amp;&amp; p2p_nopull)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   buf_printf(&amp;out, &quot;,tun-ipv6&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Try to get ifconfig=
 parameters into the options string=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * If tt is undefined, make a temporary instantiation=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!tt)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        tt =3D init_tun(o-&gt;dev, o-&gt;dev_type, o-&gt;=
topology, o-&gt;ifconfig_local,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                      o-&gt;ifconfig_remote_netmask, o-&gt;ifconf=
ig_ipv6_local, o-&gt;ifconfig_ipv6_netbits,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                      o-&gt;ifconfig_ipv6_remote, NUL=
L, NULL, false, NULL, ctx, NULL);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (tt)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      tt_local =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (tt &amp;&amp; p2p_nopull)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        const char *ios =3D ifconfig_options_strin=
g(tt, remote, o-&gt;ifconfig_nowarn, gc);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (ios &amp;&amp; strlen(ios))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,ifconfig =
%s&quot;, ios);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (tt_local)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        free(tt);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        tt =3D NULL;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef USE_COMP</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;comp=2Ealg !=
=3D COMP_ALG_UNDEF)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf=
(&amp;out, &quot;,comp-lzo&quot;); /* for compatibility, this simply indica=
tes that compression</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                         context is active, not necessarily=
 LZO per-se */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef ENABLE_FRAGMENT</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (o-&gt;ce=2Efragment)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        buf_printf(&amp;out, &quot;,mtu-dynamic&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TL=
S_CLIENT (o-&gt;tls_client)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define TLS_SERVER (o-&gt;tls_server)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Key dir=
ection</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const char *kd =3D keydirection2asc=
ii(o-&gt;key_direction, remote, false);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (kd)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            buf_printf(&amp;out, &quot;,keydir %s&quot;, kd);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Crypto Options</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;shared_secret_file || TL=
S_CLIENT || TLS_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 key_type kt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT((o-&gt;shared_=
secret_file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true=
) &lt;=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Skip resolving BF-=
CBC to allow SSL libraries without BF-CBC</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-         * to work here in the default configuration */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *c=
iphername =3D o-&gt;ciphername;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        size_t keysize =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            init_key_type(&amp;kt, &quot;no=
ne&quot;, o-&gt;authname, true, false);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            keysize =3D 128;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname, true, false);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ciphername=
 =3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            if (cipher_defined(o-&gt;ciphername))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                keysize =3D cipher_kt_key_s=
ize(kt=2Ecipher) * 8;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Only anno=
unce the cipher to our peer if we are willing to</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-         * support it */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (p2p_nopull || tls_item_in_ciphe=
r_list(ciphername, o-&gt;ncp_ciphers))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            buf_printf(&amp;out, &quot;,cipher %s&quot;, ciphername);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot=
;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;,keysize %zu&quot;,=
 keysize);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     buf_printf(&amp;out, &quot;,secret&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * SSL Options</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (o-&gt;ce=2Etls_auth_file)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-auth&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Not addin=
g tls-crypt here, because we won&#39;t reach this code if</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             * tls-auth/tls-crypt does =
not match=2E  Removing tls-auth here would</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-             * break stuff, so leaving that in place=
=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &qu=
ot;,key-method %d&quot;, KEY_METHOD_2);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (rem=
ote)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (TLS_CLIENT)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&amp=
;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            else if (TLS_SERVER)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                buf_printf(&amp;out, &quot;,tls-client&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (TLS_CLIENT)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                buf_printf(&amp;out, &quot;,tls-client&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            else if (TLS_SERVER)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&amp;out,=
 &quot;,tls-server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#undef TLS_CLIENT</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#undef TLS_SERVER</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn BSTR(&amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Compare option strings for equality=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * If the first two chars of the strings =
differ, it means that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * we are looking at different versions of the options string,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * therefore don&#39;t compare the=
m and return true=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-options_cmp_equal(char *actual, const char *expected)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return options_cmp_equal_safe(actual, e=
xpected, strlen(actual) + 1);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-options_warning(char *actual, const char *expected=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    options_warning_safe(actual, expecte=
d, strlen(actual) + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-options_warning_extract_parm1(const char =
*option_string, struct gc_arena *gc_ret)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct buffer b =3D string_alloc_buf(option_string, &amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *p =3D g=
c_malloc(OPTION_PARM_SIZE, false, &amp;gc);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const char *ret;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    buf_parse(&amp;b, &#39; &#39;, p, OPTION_PARM_SIZE);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ret =3D string_alloc(p, gc_ret);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options=
_warning_safe_scan2(const msglvl_t msglevel, const int delim,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                           const bo=
ol report_inconsistent, const char *p1,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                           const struct buffer *b2_src, c=
onst char *b1_name,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                         const char *b2_name)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* We will stop sending &#39;key-method&#39;, &#39;keydir&#39;, &#3=
9;proto&#39; and &#39;tls-auth&#39; in</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * OCC in a future version (because it&#39;s not usefu=
l)=2E To reduce questions</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * when interoperating, we no longer printing a warning about it=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (strprefix(p1, &quot;key-met=
hod &quot;) || strprefix(p1, &quot;keydir &quot;) || strprefix(p1, &quot;pr=
oto &quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ||=
 streq(p1, &quot;tls-auth&quot;) || strprefix(p1, &quot;tun-ipv6&quot;) || =
strprefix(p1, &quot;cipher &quot;))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (strlen(p1) &gt; 0)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct buffer b2 =3D *b2_sr=
c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char =
*p1_prefix =3D options_warning_extract_parm1(p1, &amp;gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        char *p2 =3D gc_malloc(OPTION_=
PARM_SIZE, false, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        while (=
buf_parse(&amp;b2, delim, p2, OPTION_PARM_SIZE))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (strlen(p2))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                const char *p2_prefix =3D options_warning_extr=
act_parm1(p2, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if =
(!strcmp(p1, p2))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             if (!strcmp(p1_prefix, p2_prefix))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    if (report_inconsistent)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        msg(ms=
glevel, &quot;WARNING: &#39;%s&#39; is used inconsistently, %s=3D&#39;%s&#3=
9;, %s=3D&#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                            safe_print(p1_prefix, &amp;gc), b1_name,=
 safe_print(p1, &amp;gc), b2_name,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                            safe_print(p2, &amp;gc));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    goto done;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(msglevel, &quot;WARNING: &#39;%s&#39; is present in =
%s config but missing in %s config, %s=3D&#39;%s&#39;&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            safe_print(p1_prefix, &a=
mp;gc), b1_name, b2_name, b1_name, safe_print(p1, &amp;gc));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-done:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-options_warning_safe_scan1(const msglvl_t msglevel, const int=
 delim,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
             const bool report_inconsistent, const struct buffer *b1_src,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
    const struct buffer *b2_src, const char *b1_name, const char *b2_name)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer b =3D *b1=
_src;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *p =3D =
gc_malloc(OPTION_PARM_SIZE, true, &amp;gc);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    while (buf_parse(&amp;b, delim, p, OPTION_PARM_SIZE))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        options_warning_safe_scan2(msglevel, delim, re=
port_inconsistent, p, b2_src, b1_name,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                   b2_name);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-options_warning_safe_ml(const msglvl_t msglevel,=
 char *actual, const char *expected, size_t actual_n)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (actual_n &gt; 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 struct buffer local =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &amp;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer remo=
te =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        actual[actual_n - 1] =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        buf_printf(&amp;local, &quot;version %s&qu=
ot;, expected);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  buf_printf(&amp;remote, &quot;version %s&quot;, actual);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        options_warning_safe_scan1(msglevel, &#39;,&#39;, t=
rue, &amp;local, &amp;remote, &quot;local&quot;, &quot;remote&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        options_warning_safe_scan1(msglevel, &#3=
9;,&#39;, false, &amp;remote, &amp;local, &quot;remote&quot;, &quot;local&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-options_cmp_equal_safe(char *actual=
, const char *expected, size_t actual_n)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    bool ret =3D true;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (actual_n &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        actual[actu=
al_n - 1] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (strncmp(actual, expected, 2))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(D_SHOW_OCC, &quot;NOTE: Options consistency check may be=
 skewed by version differences&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            options_warning_safe_ml(D_SHOW_OCC, actual, ex=
pected, actual_n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            ret =3D !strcmp(actual, =
expected);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-options_warning_safe(char =
*actual, const char *expected, size_t actual_n)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-options_string_version(const char *s, struct gc_arena *gc)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf_gc(4, gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt((char *)BPTR(&am=
p;out), s, 3);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn BSTR(&amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-options_string_extract_option(=
const char *options_string, const char *opt_name, struct gc_arena *gc)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    char *ret =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const size_t opt_name_len =3D strlen(op=
t_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const char *p =3D options_stri=
ng;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (p)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (0 =3D=3D strncmp(p, opt_name, =
opt_name_len) &amp;&amp; strlen(p) &gt; (opt_name_len + 1)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; p[opt_name_len]=
 =3D=3D &#39; &#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /=
* option found, extract value */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            const char *start =3D &amp;p[opt_name_len + 1];</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            const char *en=
d =3D strchr(p, &#39;,&#39;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            size_t val_len =3D end ? end - start : strlen(start);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D gc_=
malloc(val_len + 1, true, gc);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            memcpy(ret, start, val_len);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        p =3D strchr(p, &#39;,&#39;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (p)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            p++; /* skip delimiter */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/*</span><br><span>  * parse/print topology coding</span><=
br><span>  */</span><br><span> </span><br><span>diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh</span><br><span>index d42773f=2E=2E0fd5=
05a 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>++=
+ b/src/openvpn/options=2Eh</span><br><span>@@ -903,33 +903,6 @@</span><br>=
<span> </span><br><span> bool string_defined_equal(const char *s1, const ch=
ar *s2);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-const char *options_string_version(const char *s, struct gc_arena *gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-char *options_string(const struct options=
 *o, const struct frame *frame, struct tuntap *tt,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                     openvpn_net_ctx_t *ctx, b=
ool remote, struct gc_arena *gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool opti=
ons_cmp_equal_safe(char *actual, const char *expected, size_t actual_n);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void options_warning_safe(char *actual, con=
st char *expected, size_t actual_n);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool o=
ptions_cmp_equal(char *actual, const char *expected);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void options_warning(char *actual, const char *expected);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Given an OpenVPN options string, extract the value of an option=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * @param options_string        Zero-=
terminated, comma-separated options string</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @param opt_name              The name of the option=
 to extract</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param =
gc                    The gc to allocate the return value</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @return gc-allocated value of option with name opt_name=
 if option was found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *         or NULL otherwise=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *op=
tions_string_extract_option(const char *options_string, const char *opt_nam=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                 struct gc_arena *gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> void options_postprocess(struct options *options, struct env_=
set *es);</span><br><span> </span><br><span> bool options_postprocess_pull(=
struct options *o, struct env_set *es);</span><br><span>diff --git a/src/op=
envpn/options_string=2Ec b/src/openvpn/options_string=2Ec</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2Ed3b29b8</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpn/options_string=2Ec</spa=
n><br><span>@@ -0,0 +1,429 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software=
; you can redistribute it and/or modify</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licens=
e version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as p=
ublished by the Free Software Foundation=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is distributed in the hope that it will be useful,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY =
WARRANTY; without even the implied warranty of</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  GNU General Public License for more details=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  w=
ith this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;mtu=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_=
util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;tun=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_string(co=
nst struct options *o, const struct frame *frame, struct tuntap *tt,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+               openvpn_net=
_ctx_t *ctx, bool remote, struct gc_arena *gc)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer out =3D alloc_buf(OPTION_LINE_SIZE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool tt_local =3D false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;V4&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * Tunnel Options</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_printf(&amp;out, &quot;,dev-type %s&quot;, dev_type_string(o-&gt;dev, o-=
&gt;dev_type));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* the link-mtu that we send has only a meaning if have a fixed</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * cipher (p2p) or have a f=
allback cipher configured for older non</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * ncp clients=2E But not sending it will make even=
 2=2E4 complain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * about it being missing=2E So still send it=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,link-mtu =
%u&quot;, (unsigned int)calc_options_string_link_mtu(o, frame));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (o-&gt;ce=2Eocc_mtu !=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,tun-mtu %d&q=
uot;, o-&gt;ce=2Eocc_mtu);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &qu=
ot;,tun-mtu %d&quot;, frame-&gt;tun_mtu);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_pri=
ntf(&amp;out, &quot;,proto %s&quot;, proto_remote(o-&gt;ce=2Eproto, remote)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool p2p_nopull =3D o-&gt;mode =
=3D=3D MODE_POINT_TO_POINT &amp;&amp; !PULL_DEFINED(o);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* send tun_ipv6 only in peer2peer =
mode - in client/server mode, it</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * is usually pushed by the server, triggering a non-helpf=
ul warning</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;ifconfi=
g_ipv6_local &amp;&amp; p2p_nopull)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        buf_printf(&amp;out, &quot;,tun-ipv6&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Try =
to get ifconfig parameters into the options string=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * If tt is undefined, make a tempora=
ry instantiation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tt)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        tt =3D init_tun(o-&gt;dev=
, o-&gt;dev_type, o-&gt;topology, o-&gt;ifconfig_local,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                      o-&gt;ifconfig_re=
mote_netmask, o-&gt;ifconfig_ipv6_local, o-&gt;ifconfig_ipv6_netbits,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                      o-&=
gt;ifconfig_ipv6_remote, NULL, NULL, false, NULL, ctx, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (tt)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            tt_local =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (tt &amp;&amp; p2p_nopull)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const char *ios =3D ifconfig_options_string(tt, remote, o-&gt;ifconfig_=
nowarn, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (ios &amp;&amp; strlen(ios))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            buf_printf(&amp;out, &quot;,ifconfig %s&quot;, ios);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (tt_local)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        free(tt);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        tt =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef USE_COMP</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;comp=2Ealg !=3D =
COMP_ALG_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* for com=
patibility, this simply indicates that compression</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * context is active, not necessaril=
y LZO per-se */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    buf_printf(&amp;out, &quot;,comp-lzo&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_FRA=
GMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;=
ce=2Efragment)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(=
&amp;out, &quot;,mtu-dynamic&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define TLS_CLIENT (o-&gt;tls=
_client)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLS=
_SERVER (o-&gt;tls_server)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Key direction</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const char *kd =3D keydirection2ascii(o-&g=
t;key_direction, remote, false);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (kd)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           buf_printf(&amp;out, &quot;,keydir %s&quot;, kd);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Crypto O=
ptions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;shared_secr=
et_file || TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct key_type kt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ASSERT((o-&gt;shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (T=
LS_SERVER =3D=3D true) &lt;=3D 1);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * to work here in t=
he default configuration */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        const char *ciphername =3D o-&gt;ciphername;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        size_t keysize =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (strcmp(o-&gt;ciphername, &quo=
t;BF-CBC&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        init_key_type(&amp;kt, &quot;none&quot;, o-&gt;authname, true, fals=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            keys=
ize =3D 128;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            init_key_type(&amp;kt,=
 o-&gt;ciphername, o-&gt;authname, true, false);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            ciphername =3D cipher_kt_name(kt=
=2Ecipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (cipher_defined(o-&gt;ciphername))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                keysize =3D cipher_kt_key_size(kt=2Ecipher)=
 * 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* Only announce the c=
ipher to our peer if we are willing to</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * support it */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (p2p_nopull || tls_item_in_cipher_list(c=
iphername, o-&gt;ncp_ciphers))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            buf_printf(&amp;out, &quot;,cipher %s&quot;, ciphername);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot=
;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,keysize %zu&quot=
;, keysize);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            buf_printf(&amp;out, &quot;,secret&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * SSL Options</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (TLS_CLIENT || TLS_SERVER)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (o-&gt;ce=2Etls_auth_fil=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_pri=
ntf(&amp;out, &quot;,tls-auth&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            /* Not adding tls-crypt here, because we won&#39;t =
reach this code if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
            * tls-auth/tls-crypt does not match=2E  Removing tls-auth here =
would</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             *=
 break stuff, so leaving that in place=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            buf_printf(&amp;out, &quot;,key-method %d&quot;, KEY_METH=
OD_2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (remote)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (TLS_CLIENT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &quot;,tls=
-server&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  else if (TLS_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             buf_printf(&amp;out, &quot;,tls-client&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (TLS_CLIENT)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                buf_printf(&amp;out, &quot;,tls-client&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            else if (TLS_SERV=
ER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_pr=
intf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#undef TLS_CLIENT</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#undef TLS_SERVER</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return BSTR(&amp;out);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Compare option stri=
ngs for equality=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If the first t=
wo chars of the strings differ, it means that</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * we are looking at different versions of the op=
tions string,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the=
refore don&#39;t compare them and return true=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+options_warning_extract_parm1(const char *option_string, struc=
t gc_arena *gc_ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer b =3D string_alloc_buf(option_string, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char *p =3D gc_malloc(OPTI=
ON_PARM_SIZE, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *ret;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf=
_parse(&amp;b, &#39; &#39;, p, OPTION_PARM_SIZE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(p, gc_ret);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
options_warning_safe_scan2(const msglvl_t msglevel, const int delim,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
 const bool report_inconsistent, const char *p1,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                           const struct buffer=
 *b2_src, const char *b1_name,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                           const char *b2_name)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* We will stop sending &#39;key-method&#39;, &#39=
;keydir&#39;, &#39;proto&#39; and &#39;tls-auth&#39; in</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * OCC in a future version (because=
 it&#39;s not useful)=2E To reduce questions</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * when interoperating, we no longer printing =
a warning about it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (st=
rprefix(p1, &quot;key-method &quot;) || strprefix(p1, &quot;keydir &quot;) =
|| strprefix(p1, &quot;proto &quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        || streq(p1, &quot;tls-auth&quot;) || strprefix(p1=
, &quot;tun-ipv6&quot;) || strprefix(p1, &quot;cipher &quot;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
strlen(p1) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct buffer b2 =3D *b2_src;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const char *p1_prefix =3D options_warning_e=
xtract_parm1(p1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        char *p2 =3D gc_malloc(OPTION_PARM_SIZE, false, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        while (buf_parse(&amp;b2, delim, =
p2, OPTION_PARM_SIZE))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (strlen(p2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           const char *p2_prefix =3D options_warning_extract_parm1(p2, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                if (!strcmp(p1, p=
2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       if (!strcmp(p1_prefix, p2_prefix))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    if (report_inconsistent)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        msg(=
msglevel, &quot;WARNING: &#39;%s&#39; is used inconsistently, %s=3D&#39;%s&=
#39;, %s=3D&#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                            safe_print(p1_prefix, &amp;gc), b1_n=
ame, safe_print(p1, &amp;gc), b2_name,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                            safe_print(p2, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;WARNING: &#39;%s&#=
39; is present in %s config but missing in %s config, %s=3D&#39;%s&#39;&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            safe=
_print(p1_prefix, &amp;gc), b1_name, b2_name, b1_name, safe_print(p1, &amp;=
gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+options_warning_safe_scan=
1(const msglvl_t msglevel, const int delim,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                           const bool report_incons=
istent, const struct buffer *b1_src,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                           const struct buffer *b2_src, co=
nst char *b1_name, const char *b2_name)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer b =3D *b1_src;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *p =3D gc_malloc(OPTION_PARM_SIZ=
E, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (buf_parse=
(&amp;b, delim, p, OPTION_PARM_SIZE))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        options_warning_safe_scan2(msglevel, delim, report_inconsistent=
, p, b2_src, b1_name,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                   b2_name);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+options_warning_safe_ml(const msglvl_t msglevel, =
char *actual, const char *expected, size_t actual_n)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (actual_n &gt; 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct buffer local =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct buffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        actual[actual_n - 1=
] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;local,=
 &quot;version %s&quot;, expected);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        buf_printf(&amp;remote, &quot;version %s&quot;, act=
ual);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        options_warning_safe_scan=
1(msglevel, &#39;,&#39;, true, &amp;local, &amp;remote, &quot;local&quot;, =
&quot;remote&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options_wa=
rning_safe_scan1(msglevel, &#39;,&#39;, false, &amp;remote, &amp;local, &qu=
ot;remote&quot;, &quot;local&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+options_cmp_equal_safe(char *actual, const char *expected, size_t =
actual_n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool re=
t =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (actual_n &gt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        actual[actual_n - 1] =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strncmp(=
actual, expected, 2))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(D_SHOW_OCC, &quot;NOTE: Options consistency check may be skewed by =
version differences&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            options_warning_safe_ml(D_SHOW_OCC, actual, expected, a=
ctual_n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            ret =3D !strcmp(actual, e=
xpected);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_cmp_e=
qual(char *actual, const char *expected)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return options_cmp_equal_safe(actual, expected, strlen(actual) + 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+options_warning_safe(char *actual, const char *expected, size_t actual_=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    options_warning_safe_ml(D_SHOW_=
OCC, actual, expected, actual_n);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+options_warning(char *actual, const ch=
ar *expected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    options_warning_safe=
(actual, expected, strlen(actual) + 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+options_string_version(c=
onst char *s, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer out =3D alloc_buf_gc(4, gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    strncpynt((char *)BPTR(&amp;out), s, 3);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;out);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic i=
gnored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+options_string_extract_option(c=
onst char *options_string, const char *opt_name, struct gc_arena *gc)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const size_t opt_name_len =3D str=
len(opt_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *p =3D op=
tions_string;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wh=
ile (p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (0 =3D=3D strnc=
mp(p, opt_name, opt_name_len) &amp;&amp; strlen(p) &gt; (opt_name_len + 1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&am=
p; p[opt_name_len] =3D=3D &#39; &#39;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* option found, extract value */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            const char *start =3D &amp;p=
[opt_name_len + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            const char *end =3D strchr(p, &#39;,&#39;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            size_t val_len =3D end ? en=
d - start : strlen(start);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ret =3D gc_malloc(val_len + 1, true, gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            memcpy(ret, start, val=
_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b=
reak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        p =3D strchr(p, =
&#39;,&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            p++; /* s=
kip delimiter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/s=
rc/openvpn/options_string=2Eh b/src/openvpn/options_string=2Eh</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2E02efed3</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/options_string=2Eh=
</span><br><span>@@ -0,0 +1,97 @@</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 OpenVPN -- An application to securely tunnel IP networks</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef OPTIONS_STRING_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OPTIONS_STRING_H</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+const char *options_string_version(const char *=
s, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Build an options string to =
represent data channel encryption options=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * This string must match exactly between peers=2E=
  The keysize is checked</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * separately by read_key()=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* The following options must match on both peers:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Tunnel options:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --=
dev tun|tap [unit number need not match]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * --dev-type tun|tap</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * --link-mtu</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * --udp-mtu</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * --tun-mtu</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * --proto udp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 --proto tcp-client [matched with --proto tcp-server</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                     on the other end o=
f the connection]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 --proto tcp-server [matched with --proto tcp-client on</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *                     the other end of=
 the connection]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
--tun-ipv6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --ifco=
nfig x y [matched with --ifconfig y x on</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *                 the other end of the connection]</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * --comp-lzo</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * --compress alg</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * --fragment</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Crypto Options:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --cipher</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --auth</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * --secret</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * SSL Options:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 --tls-auth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls=
-client [matched with --tls-server on</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *               the other end of the connection]</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls-server [matched wi=
th --tls-client on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*               the other end of the connection]</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+char *options_string(const struct options *o, const struct fra=
me *frame, struct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                     openvpn_net_ctx_t *ctx, bool remote, struct =
gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool options_cmp_equal_s=
afe(char *actual, const char *expected, size_t actual_n);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void options_warning_safe(char *actual, const char *expe=
cted, size_t actual_n);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool options_cm=
p_equal(char *actual, const char *expected);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void options_warning(char *actual, const char *expected);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Given an OpenVPN options string, extract the value of an option=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param options_string        Z=
ero-terminated, comma-separated options string</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param opt_name              The name of the =
option to extract</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param gc                    The gc to allocate the return value</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return gc-allocated value of option with n=
ame opt_name if option was found,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *         or NULL otherwise=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+char *options_string_extract_option(const char *options_string, c=
onst char *opt_name,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                    struct gc_arena *gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec</span><br><span>index 01e45fd=2E=2Ed5bd602 100644</span><br><span>--- =
a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><=
span>@@ -62,6 +62,7 @@</span><br><span> #include &quot;auth_token=2Eh&quot;=
</span><br><span> #include &quot;mss=2Eh&quot;</span><br><span> #include &q=
uot;dco=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;options_string=2Eh&quot;</span><br><span> </span><br><span> #i=
nclude &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;openvpn=2Eh&q=
uot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">change 1773</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6824058fc9c4efd48=
ceeb32d4164f97b2a243d85 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1773 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--1IkqdFur5jU=--


--===============3436786020203003050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3436786020203003050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3436786020203003050==--

