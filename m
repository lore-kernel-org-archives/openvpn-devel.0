Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB426C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8M8S8ea1nUWHHV+A2JD3yu2Krda8CSVQ2i4RB2RnBw=; b=lbPgvvbDmjC1c59s5Q5AYQxNSD
	stF4aioHK5J7ZAfezfrtQOTb6NoC6ydaFto6uBMj5RWLrvNf1rAG526j9JAgV5cuP6Yk0oirgz/Cy
	5gDN8VHipafTO5xZ5QNjvzczhReU420GqMD5EcXKdiqzBIHHt4cv/vDWY1u+HF0l90mc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvw91-0002ND-Jy;
	Mon, 17 Aug 2026 12:08:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvw90-0002Mz-6m
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2DqKVDbLq6yW5sOH7B37ebb5tf9uzH8ukj0ez+akmuI=; b=NHEzHDsE325loHiLMfjCHOazQ+
 /cV1mVmupXwAsgwM7rjaF+i65MxkG3BwGjh/llOysy3YrILr+MMXiIB7ba/nwpmVXBd0s9klFxW/n
 /SjWUYWiaOCewsHyKedCPc+O3FBM6Zz4E+zubDW9GFlF7OFr/g8NLcZk/RadLML1t9mE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2DqKVDbLq6yW5sOH7B37ebb5tf9uzH8ukj0ez+akmuI=; b=M
 miN0sQrbWtWoaaqZeUAPYv6P89uJMmM0qT6kLUqML0oSv4200m/p5P8F91BXBcCErICIPUgzXBn1+
 Rv2tChJuHLn6tdX4uAvGLKY3WlfAoWXMWkOG2KvDWIrRVYCsASdisTjaH+ZxWTrOb453rxrN0n0po
 N8Yon/RM616Fyq2M=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvw8w-00054w-Qn for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:46 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso17000165e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786968516; x=1787573316; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2DqKVDbLq6yW5sOH7B37ebb5tf9uzH8ukj0ez+akmuI=;
 b=UuzGoXNxK4+RNXut5dN0LhBFiZbFk0oXraruyhyx0MGC5wRHBT8jyuadZ5yq32d9+D
 scHeO/xljd5lj3ycYzE6sKsK82zAOJ/4SUJ0GFUDD/c+ZswIuNroZcKQPUt6MXTGrGZZ
 cmtBj9wF9We736Fux9Yh+OnoHzAydg2GJZN27t/B6UzhBE+hvxvwZCGLLHpDDVxgCgP2
 lcSdK5jTyyg3uQVtRc4iQOPLfTJkiDntc1mGB+CiWD1yvYYv/NxIvcffJf9zPr0kdAEP
 emLveTvnELonqyhqsiB5xx6bvajxy+5fXpEYf/l+UYKAgi7cT54f2LmsH7zspNW+z6kV
 hDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968516; x=1787573316;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2DqKVDbLq6yW5sOH7B37ebb5tf9uzH8ukj0ez+akmuI=;
 b=oLJtevskgp2Cs4zDSKtc719+DQVZ8a2+0w25jBtGO2HIKoihuTcjlIJBNPFLkxnNLg
 viXnJ6IWLyA502aPrp35alj9mvAaG0BUF6pleT3moKlWALeXpxiidEEzQLcrl+tgXZAF
 84h3AYF+/Mv4wFwypuptzuMISsKu7aOKqbrz5KkFx0c9lSwhg6sbbm2WtoXGKo2BOfWE
 K7Q+I3akYy7SfkcqnEo77IQGCqVBIJFK3ecXVHTnCLv263Q/FmeeFP9z9Vdn2P9uAv50
 b3rbMcxA3HbvAV+GFS7qgoVSq2zMRWOT4wMZsPlCr8aatidsSHT8FiIO9EFewUux0Nu7
 wLFw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+uE0puelxSGyPMtnvY8NmQNstxbDmTtOV/gYG/dEaqX/Tv098dyYIOLPJVaFhEzy4Hd9ZB1Ploc3+uaeI@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy05x51DXdXXTMHw+TWO7lG9SqMZzxLPU586Ueq/aUWeV/nfZFn
 WW7Ihlyiycm3dA0HSFkIKzdi4X2a6eWKLT4xt1UgGyB6S+abRbOFq7dzKJY52yFlR4JROOJRDbJ
 MlQNXGeaE7MAvpC91ZmBUEMPHli2NAzysypYMNLSTEXFU9ij5GlGfjNdM0qaVWMz6yKaK
X-Gm-Gg: AR+sD10paV/BYMQ2wCRRHBlSSmYdw1sDYBZ1CVRUenaKQvJ0ElOVtu87jnBCzFqKTUA
 OMVKGDudSbcGo5IIPLFdha2mZOIr2zseEGTtkCqELZmsqOG5gKVeukwUFK+SAU8FXAWs1BXZqKG
 OTfPfdCYcnO2qS1enzb1KONsq5f3Fb9SAxUS8jBST6JBbWUuNM4M9sQoGBUk9uwdEgb5TA0+NZy
 sjcCmkbG5UuenLQyOOeB/92H9uciPIGxqrY6zQZUXV7f5uetaN9PDxf1FAPi9eycJCLuFuOaOy8
 B3bYWj7oDtji45wwqNjpOPMgD1iD0eJpEefxLXttP1QvNZ6IVE05XKmgcq9gmDCjeYY8epu0RE/
 jHCs5zRnvxyzVx40snzs5kC08uOuYA5ewM5tosozetT2xj7nhSWOnRzSRgiCMOuebIanoAi/B4a
 jAhjIbsg6fPz23E7oevBgp1U76s0jw+DiC5ygYKCcw52GiClTp6EHrpcjzeh3V9yLoZYtiPWWvY
 TIQhqPIRlvAYvVE+10BHOMub0FubhjjeD8K0iqYw8EDvmwlODLNXa+yls8Q9jOMHFqjFtoSsVJJ
 O6XWpT9fUkHnr8b5relLj1Cl56TgTMKfiHoWuhLzgrcSG8JLQsk=
X-Received: by 2002:a05:600c:4690:b0:498:2b1f:e0c6 with SMTP id
 5b1f17b1804b1-499879af606mr352665205e9.18.1786968515705; 
 Mon, 17 Aug 2026 05:08:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b43dsm3360763f8f.12.2026.08.17.05.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:08:33 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:08:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: ac5bba75869ca630b9d4e01dc0482b9e34f78b5f
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <391092603f3c7963726c851aff82c808590ee9ee-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvw8w-00054w-Qn
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2591676614086758759=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2591676614086758759==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fmCGOvT/3Ko="; charset=UTF-8

--fmCGOvT/3Ko=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail

to look at the new patch set=
 (#3)=2E


Change subject: options: Factor out options_string code from opt=
ions=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

opti=
ons: Factor out options_string code from options=2Ec

options=2Ec is a huge=
, unwieldly file=2E So remove some
closely related code that has no direct =
dependencies
with the other functions in the file=2E

This time it is the f=
unctions related to the creation
and testing of the options string=2E

Chan=
ge-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
---
M CMakeLists=2Etxt
M src/openvpn/Makef=
ile=2Eam
M src/openvpn/init=2Ec
M src/openvpn/occ=2Ec
M src/openvpn/options=
=2Ec
M src/openvpn/options=2Eh
A src/openvpn/options_string=2Ec
A src/openv=
pn/options_string=2Eh
M src/openvpn/ssl=2Ec
9 files changed, 532 insertions=
(+), 458 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/73/1773/3

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt=

index 540992b=2E=2Ed7a5e08 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=
=2Etxt
@@ -529,6 +529,8 @@
     src/openvpn/options_parse=2Ec
     src/open=
vpn/options_show=2Ec
     src/openvpn/options_show=2Eh
+    src/openvpn/opt=
ions_string=2Ec
+    src/openvpn/options_string=2Eh
     src/openvpn/otime=
=2Ec
     src/openvpn/otime=2Eh
     src/openvpn/ovpn_dco_win=2Eh
diff --gi=
t a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 2092e96=2E=
=2E4650ddd 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefil=
e=2Eam
@@ -109,6 +109,7 @@
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec option=
s=2Eh \
 	options_show=2Ec options_show=2Eh \
+	options_string=2Ec options_=
string=2Eh \
 	options_util=2Ec options_util=2Eh \
 	options_parse=2Ec \
 	=
otime=2Ec otime=2Eh \
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec
index d528c40=2E=2E38db7fa 100644
--- a/src/openvpn/init=2Ec
+++ b/src=
/openvpn/init=2Ec
@@ -54,6 +54,7 @@
 #include "dco=2Eh"
 #include "tun_afun=
ix=2Eh"
 #include "schedule=2Eh"
+#include "options_string=2Eh"
 
 #include=
 "memdbg=2Eh"
 
diff --git a/src/openvpn/occ=2Ec b/src/openvpn/occ=2Ec
inde=
x aa262a8=2E=2Ef25ae19 100644
--- a/src/openvpn/occ=2Ec
+++ b/src/openvpn/o=
cc=2Ec
@@ -29,7 +29,7 @@
 #include "occ=2Eh"
 #include "forward=2Eh"
 #incl=
ude "memdbg=2Eh"
-
+#include "options_string=2Eh"
 
 /*
  * This random str=
ing identifies an OpenVPN
diff --git a/src/openvpn/options=2Ec b/src/openvp=
n/options=2Ec
index 87da344=2E=2E30a1029 100644
--- a/src/openvpn/options=
=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3713,436 +3713,6 @@
 }
 
 /*
- * Bui=
ld an options string to represent data channel encryption options=2E
- * Th=
is string must match exactly between peers=2E  The keysize is checked
- * s=
eparately by read_key()=2E
- *
- * The following options must match on both=
 peers:
- *
- * Tunnel options:
- *
- * --dev tun|tap [unit number need not=
 match]
- * --dev-type tun|tap
- * --link-mtu
- * --udp-mtu
- * --tun-mtu
-=
 * --proto udp
- * --proto tcp-client [matched with --proto tcp-server
- * =
                    on the other end of the connection]
- * --proto tcp-ser=
ver [matched with --proto tcp-client on
- *                     the other e=
nd of the connection]
- * --tun-ipv6
- * --ifconfig x y [matched with --ifc=
onfig y x on
- *                 the other end of the connection]
- *
- * -=
-comp-lzo
- * --compress alg
- * --fragment
- *
- * Crypto Options:
- *
- *=
 --cipher
- * --auth
- * --secret
- *
- * SSL Options:
- *
- * --tls-auth
-=
 * --tls-client [matched with --tls-server on
- *               the other e=
nd of the connection]
- * --tls-server [matched with --tls-client on
- *   =
            the other end of the connection]
- */
-char *
-options_string(c=
onst struct options *o, const struct frame *frame, struct tuntap *tt,
-    =
           openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc)
-{
-  =
  struct buffer out =3D alloc_buf(OPTION_LINE_SIZE);
-    bool tt_local =3D=
 false;
-
-    buf_printf(&out, "V4");
-
-    /*
-     * Tunnel Options
-  =
   */
-
-    buf_printf(&out, ",dev-type %s", dev_type_string(o->dev, o->de=
v_type));
-    /* the link-mtu that we send has only a meaning if have a fi=
xed
-     * cipher (p2p) or have a fallback cipher configured for older non=

-     * ncp clients=2E But not sending it will make even 2=2E4 complain
- =
    * about it being missing=2E So still send it=2E */
-    buf_printf(&out=
, ",link-mtu %u", (unsigned int)calc_options_string_link_mtu(o, frame));
-
=
-    if (o->ce=2Eocc_mtu !=3D 0)
-    {
-        buf_printf(&out, ",tun-mtu=
 %d", o->ce=2Eocc_mtu);
-    }
-    else
-    {
-        buf_printf(&out, "=
,tun-mtu %d", frame->tun_mtu);
-    }
-
-    buf_printf(&out, ",proto %s", =
proto_remote(o->ce=2Eproto, remote));
-
-    bool p2p_nopull =3D o->mode =
=3D=3D MODE_POINT_TO_POINT && !PULL_DEFINED(o);
-    /* send tun_ipv6 only =
in peer2peer mode - in client/server mode, it
-     * is usually pushed by =
the server, triggering a non-helpful warning
-     */
-    if (o->ifconfig_=
ipv6_local && p2p_nopull)
-    {
-        buf_printf(&out, ",tun-ipv6");
- =
   }
-
-    /*
-     * Try to get ifconfig parameters into the options stri=
ng=2E
-     * If tt is undefined, make a temporary instantiation=2E
-     *=
/
-    if (!tt)
-    {
-        tt =3D init_tun(o->dev, o->dev_type, o->top=
ology, o->ifconfig_local,
-                      o->ifconfig_remote_netmask=
, o->ifconfig_ipv6_local, o->ifconfig_ipv6_netbits,
-                      =
o->ifconfig_ipv6_remote, NULL, NULL, false, NULL, ctx, NULL);
-        if (=
tt)
-        {
-            tt_local =3D true;
-        }
-    }
-
-    if =
(tt && p2p_nopull)
-    {
-        const char *ios =3D ifconfig_options_str=
ing(tt, remote, o->ifconfig_nowarn, gc);
-        if (ios && strlen(ios))
-=
        {
-            buf_printf(&out, ",ifconfig %s", ios);
-        }
- =
   }
-    if (tt_local)
-    {
-        free(tt);
-        tt =3D NULL;
-  =
  }
-
-#ifdef USE_COMP
-    if (o->comp=2Ealg !=3D COMP_ALG_UNDEF)
-    {
-=
        buf_printf(&out, ",comp-lzo"); /* for compatibility, this simply in=
dicates that compression
-                                          context=
 is active, not necessarily LZO per-se */
-    }
-#endif
-
-#ifdef ENABLE_F=
RAGMENT
-    if (o->ce=2Efragment)
-    {
-        buf_printf(&out, ",mtu-d=
ynamic");
-    }
-#endif
-
-#define TLS_CLIENT (o->tls_client)
-#define TLS=
_SERVER (o->tls_server)
-
-    /*
-     * Key direction
-     */
-    {
-  =
      const char *kd =3D keydirection2ascii(o->key_direction, remote, false=
);
-        if (kd)
-        {
-            buf_printf(&out, ",keydir %s", =
kd);
-        }
-    }
-
-    /*
-     * Crypto Options
-     */
-    if (o=
->shared_secret_file || TLS_CLIENT || TLS_SERVER)
-    {
-        struct ke=
y_type kt;
-
-        ASSERT((o->shared_secret_file !=3D NULL) + (TLS_CLIEN=
T =3D=3D true) + (TLS_SERVER =3D=3D true) <=3D 1);
-
-        /* Skip resol=
ving BF-CBC to allow SSL libraries without BF-CBC
-         * to work here =
in the default configuration */
-        const char *ciphername =3D o->ciph=
ername;
-        size_t keysize =3D 0;
-
-        if (strcmp(o->ciphername,=
 "BF-CBC") =3D=3D 0)
-        {
-            init_key_type(&kt, "none", o->=
authname, true, false);
-            keysize =3D 128;
-        }
-        e=
lse
-        {
-            init_key_type(&kt, o->ciphername, o->authname, =
true, false);
-            ciphername =3D cipher_kt_name(kt=2Ecipher);
-   =
         if (cipher_defined(o->ciphername))
-            {
-               =
 keysize =3D cipher_kt_key_size(kt=2Ecipher) * 8;
-            }
-        }=

-        /* Only announce the cipher to our peer if we are willing to
-   =
      * support it */
-        if (p2p_nopull || tls_item_in_cipher_list(ci=
phername, o->ncp_ciphers))
-        {
-            buf_printf(&out, ",ciphe=
r %s", ciphername);
-        }
-        buf_printf(&out, ",auth %s", md_kt_=
name(kt=2Edigest));
-        buf_printf(&out, ",keysize %zu", keysize);
-  =
      if (o->shared_secret_file)
-        {
-            buf_printf(&out, "=
,secret");
-        }
-    }
-
-    /*
-     * SSL Options
-     */
-    {
=
-        if (TLS_CLIENT || TLS_SERVER)
-        {
-            if (o->ce=2E=
tls_auth_file)
-            {
-                buf_printf(&out, ",tls-auth"=
);
-            }
-            /* Not adding tls-crypt here, because we won=
't reach this code if
-             * tls-auth/tls-crypt does not match=2E =
 Removing tls-auth here would
-             * break stuff, so leaving that =
in place=2E */
-
-            buf_printf(&out, ",key-method %d", KEY_METHOD=
_2);
-        }
-
-        if (remote)
-        {
-            if (TLS_CLIE=
NT)
-            {
-                buf_printf(&out, ",tls-server");
-     =
       }
-            else if (TLS_SERVER)
-            {
-                =
buf_printf(&out, ",tls-client");
-            }
-        }
-        else
- =
       {
-            if (TLS_CLIENT)
-            {
-                buf_p=
rintf(&out, ",tls-client");
-            }
-            else if (TLS_SERVER=
)
-            {
-                buf_printf(&out, ",tls-server");
-       =
     }
-        }
-    }
-
-#undef TLS_CLIENT
-#undef TLS_SERVER
-
-    ret=
urn BSTR(&out);
-}
-
-/*
- * Compare option strings for equality=2E
- * If =
the first two chars of the strings differ, it means that
- * we are looking=
 at different versions of the options string,
- * therefore don't compare t=
hem and return true=2E
- */
-
-bool
-options_cmp_equal(char *actual, const =
char *expected)
-{
-    return options_cmp_equal_safe(actual, expected, str=
len(actual) + 1);
-}
-
-void
-options_warning(char *actual, const char *exp=
ected)
-{
-    options_warning_safe(actual, expected, strlen(actual) + 1);
=
-}
-
-static const char *
-options_warning_extract_parm1(const char *option=
_string, struct gc_arena *gc_ret)
-{
-    struct gc_arena gc =3D gc_new();
=
-    struct buffer b =3D string_alloc_buf(option_string, &gc);
-    char *p=
 =3D gc_malloc(OPTION_PARM_SIZE, false, &gc);
-    const char *ret;
-
-    =
buf_parse(&b, ' ', p, OPTION_PARM_SIZE);
-    ret =3D string_alloc(p, gc_re=
t);
-    gc_free(&gc);
-    return ret;
-}
-
-static void
-options_warning_=
safe_scan2(const msglvl_t msglevel, const int delim,
-                     =
      const bool report_inconsistent, const char *p1,
-                    =
       const struct buffer *b2_src, const char *b1_name,
-                 =
          const char *b2_name)
-{
-    /* We will stop sending 'key-method'=
, 'keydir', 'proto' and 'tls-auth' in
-     * OCC in a future version (beca=
use it's not useful)=2E To reduce questions
-     * when interoperating, we=
 no longer printing a warning about it=2E
-     */
-    if (strprefix(p1, "=
key-method ") || strprefix(p1, "keydir ") || strprefix(p1, "proto ")
-     =
   || streq(p1, "tls-auth") || strprefix(p1, "tun-ipv6") || strprefix(p1, "=
cipher "))
-    {
-        return;
-    }
-
-    if (strlen(p1) > 0)
-    {=

-        struct gc_arena gc =3D gc_new();
-        struct buffer b2 =3D *b=
2_src;
-        const char *p1_prefix =3D options_warning_extract_parm1(p1,=
 &gc);
-        char *p2 =3D gc_malloc(OPTION_PARM_SIZE, false, &gc);
-
-  =
      while (buf_parse(&b2, delim, p2, OPTION_PARM_SIZE))
-        {
-     =
       if (strlen(p2))
-            {
-                const char *p2_prefi=
x =3D options_warning_extract_parm1(p2, &gc);
-
-                if (!strcm=
p(p1, p2))
-                {
-                    goto done;
-            =
    }
-                if (!strcmp(p1_prefix, p2_prefix))
-                =
{
-                    if (report_inconsistent)
-                    {
-   =
                     msg(msglevel, "WARNING: '%s' is used inconsistently, %=
s=3D'%s', %s=3D'%s'",
-                            safe_print(p1_prefix, &g=
c), b1_name, safe_print(p1, &gc), b2_name,
-                            saf=
e_print(p2, &gc));
-                    }
-                    goto done;
-=
                }
-            }
-        }
-
-        msg(msglevel, "WARNI=
NG: '%s' is present in %s config but missing in %s config, %s=3D'%s'",
-   =
         safe_print(p1_prefix, &gc), b1_name, b2_name, b1_name, safe_print(=
p1, &gc));
-
-done:
-        gc_free(&gc);
-    }
-}
-
-static void
-option=
s_warning_safe_scan1(const msglvl_t msglevel, const int delim,
-           =
                const bool report_inconsistent, const struct buffer *b1_src=
,
-                           const struct buffer *b2_src, const char *b1_n=
ame, const char *b2_name)
-{
-    struct gc_arena gc =3D gc_new();
-    str=
uct buffer b =3D *b1_src;
-    char *p =3D gc_malloc(OPTION_PARM_SIZE, true=
, &gc);
-
-    while (buf_parse(&b, delim, p, OPTION_PARM_SIZE))
-    {
-  =
      options_warning_safe_scan2(msglevel, delim, report_inconsistent, p, b=
2_src, b1_name,
-                                   b2_name);
-    }
-
-   =
 gc_free(&gc);
-}
-
-static void
-options_warning_safe_ml(const msglvl_t ms=
glevel, char *actual, const char *expected, size_t actual_n)
-{
-    struct=
 gc_arena gc =3D gc_new();
-
-    if (actual_n > 0)
-    {
-        struct =
buffer local =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
-        struct =
buffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
-        actual=
[actual_n - 1] =3D 0;
-
-        buf_printf(&local, "version %s", expected)=
;
-        buf_printf(&remote, "version %s", actual);
-
-        options_wa=
rning_safe_scan1(msglevel, ',', true, &local, &remote, "local", "remote");
=
-
-        options_warning_safe_scan1(msglevel, ',', false, &remote, &local=
, "remote", "local");
-    }
-
-    gc_free(&gc);
-}
-
-bool
-options_cmp_e=
qual_safe(char *actual, const char *expected, size_t actual_n)
-{
-    stru=
ct gc_arena gc =3D gc_new();
-    bool ret =3D true;
-
-    if (actual_n > =
0)
-    {
-        actual[actual_n - 1] =3D 0;
-        if (strncmp(actual,=
 expected, 2))
-        {
-            msg(D_SHOW_OCC, "NOTE: Options consi=
stency check may be skewed by version differences");
-            options_w=
arning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
-        }
-       =
 else
-        {
-            ret =3D !strcmp(actual, expected);
-        }=

-    }
-    gc_free(&gc);
-    return ret;
-}
-
-void
-options_warning_saf=
e(char *actual, const char *expected, size_t actual_n)
-{
-    options_warn=
ing_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
-}
-
-const char *
-op=
tions_string_version(const char *s, struct gc_arena *gc)
-{
-    struct buf=
fer out =3D alloc_buf_gc(4, gc);
-    strncpynt((char *)BPTR(&out), s, 3);
=
-    return BSTR(&out);
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-=
#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare=
"
-#endif
-
-char *
-options_string_extract_option(const char *options_stri=
ng, const char *opt_name, struct gc_arena *gc)
-{
-    char *ret =3D NULL;
=
-    const size_t opt_name_len =3D strlen(opt_name);
-
-    const char *p =
=3D options_string;
-    while (p)
-    {
-        if (0 =3D=3D strncmp(p, =
opt_name, opt_name_len) && strlen(p) > (opt_name_len + 1)
-            && p=
[opt_name_len] =3D=3D ' ')
-        {
-            /* option found, extract=
 value */
-            const char *start =3D &p[opt_name_len + 1];
-       =
     const char *end =3D strchr(p, ',');
-            size_t val_len =3D en=
d ? end - start : strlen(start);
-            ret =3D gc_malloc(val_len + 1=
, true, gc);
-            memcpy(ret, start, val_len);
-            break;
=
-        }
-        p =3D strchr(p, ',');
-        if (p)
-        {
-     =
       p++; /* skip delimiter */
-        }
-    }
-    return ret;
-}
-
-#=
if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#en=
dif
-
-/*
  * parse/print topology coding
  */
 
diff --git a/src/openvpn/o=
ptions=2Eh b/src/openvpn/options=2Eh
index d42773f=2E=2E0fd505a 100644
--- =
a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -903,33 +903,6 @=
@
 
 bool string_defined_equal(const char *s1, const char *s2);
 
-const ch=
ar *options_string_version(const char *s, struct gc_arena *gc);
-
-char *op=
tions_string(const struct options *o, const struct frame *frame, struct tun=
tap *tt,
-                     openvpn_net_ctx_t *ctx, bool remote, struct =
gc_arena *gc);
-
-bool options_cmp_equal_safe(char *actual, const char *exp=
ected, size_t actual_n);
-
-void options_warning_safe(char *actual, const c=
har *expected, size_t actual_n);
-
-bool options_cmp_equal(char *actual, co=
nst char *expected);
-
-void options_warning(char *actual, const char *expe=
cted);
-
-/**
- * Given an OpenVPN options string, extract the value of an =
option=2E
- *
- * @param options_string        Zero-terminated, comma-separ=
ated options string
- * @param opt_name              The name of the option=
 to extract
- * @param gc                    The gc to allocate the return =
value
- *
- * @return gc-allocated value of option with name opt_name if op=
tion was found,
- *         or NULL otherwise=2E
- */
-char *options_string=
_extract_option(const char *options_string, const char *opt_name,
-        =
                            struct gc_arena *gc);
-
-
 void options_postpro=
cess(struct options *options, struct env_set *es);
 
 bool options_postproc=
ess_pull(struct options *o, struct env_set *es);
diff --git a/src/openvpn/o=
ptions_string=2Ec b/src/openvpn/options_string=2Ec
new file mode 100644
ind=
ex 0000000=2E=2E9c0313f
--- /dev/null
+++ b/src/openvpn/options_string=2Ec
=
@@ -0,0 +1,470 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP =
networks
+ *             over a single UDP port, with support for SSL/TLS-b=
ased
+ *             session authentication and key exchange,
+ *          =
   packet encryption, packet authentication, and
+ *             packet com=
pression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2En=
et>
+ *
+ *  This program is free software; you can redistribute it and/or =
modify
+ *  it under the terms of the GNU General Public License version 2
=
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program =
is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for m=
ore details=2E
+ *
+ *  You should have received a copy of the GNU General =
Public License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#=
endif
+
+#include "syshead=2Eh"
+
+#include "buffer=2Eh"
+#include "crypto=
=2Eh"
+#include "error=2Eh"
+#include "mtu=2Eh"
+#include "options=2Eh"
+#i=
nclude "socket_util=2Eh"
+#include "ssl=2Eh"
+#include "ssl_ncp=2Eh"
+#incl=
ude "tun=2Eh"
+
+#include <string=2Eh>
+
+/*
+ * Build an options string to=
 represent data channel encryption options=2E
+ * This string must match ex=
actly between peers=2E  The keysize is checked
+ * separately by read_key()=
=2E
+ *
+ * The following options must match on both peers:
+ *
+ * Tunnel =
options:
+ *
+ * --dev tun|tap [unit number need not match]
+ * --dev-type =
tun|tap
+ * --link-mtu
+ * --udp-mtu
+ * --tun-mtu
+ * --proto udp
+ * --pr=
oto tcp-client [matched with --proto tcp-server
+ *                     on =
the other end of the connection]
+ * --proto tcp-server [matched with --pro=
to tcp-client on
+ *                     the other end of the connection]
+=
 * --tun-ipv6
+ * --ifconfig x y [matched with --ifconfig y x on
+ *       =
          the other end of the connection]
+ *
+ * --comp-lzo
+ * --compres=
s alg
+ * --fragment
+ *
+ * Crypto Options:
+ *
+ * --cipher
+ * --auth
+ =
* --secret
+ *
+ * SSL Options:
+ *
+ * --tls-auth
+ * --tls-client [matche=
d with --tls-server on
+ *               the other end of the connection]
+=
 * --tls-server [matched with --tls-client on
+ *               the other e=
nd of the connection]
+ */
+char *
+options_string(const struct options *o,=
 const struct frame *frame, struct tuntap *tt,
+               openvpn_net_=
ctx_t *ctx, bool remote, struct gc_arena *gc)
+{
+    struct buffer out =3D=
 alloc_buf(OPTION_LINE_SIZE);
+    bool tt_local =3D false;
+
+    buf_prin=
tf(&out, "V4");
+
+    /*
+     * Tunnel Options
+     */
+
+    buf_printf=
(&out, ",dev-type %s", dev_type_string(o->dev, o->dev_type));
+    /* the l=
ink-mtu that we send has only a meaning if have a fixed
+     * cipher (p2p=
) or have a fallback cipher configured for older non
+     * ncp clients=2E=
 But not sending it will make even 2=2E4 complain
+     * about it being mi=
ssing=2E So still send it=2E */
+    buf_printf(&out, ",link-mtu %u", (unsi=
gned int)calc_options_string_link_mtu(o, frame));
+
+    if (o->ce=2Eocc_mt=
u !=3D 0)
+    {
+        buf_printf(&out, ",tun-mtu %d", o->ce=2Eocc_mtu);=

+    }
+    else
+    {
+        buf_printf(&out, ",tun-mtu %d", frame->tu=
n_mtu);
+    }
+
+    buf_printf(&out, ",proto %s", proto_remote(o->ce=2Epr=
oto, remote));
+
+    bool p2p_nopull =3D o->mode =3D=3D MODE_POINT_TO_POIN=
T && !PULL_DEFINED(o);
+    /* send tun_ipv6 only in peer2peer mode - in cl=
ient/server mode, it
+     * is usually pushed by the server, triggering a =
non-helpful warning
+     */
+    if (o->ifconfig_ipv6_local && p2p_nopull)=

+    {
+        buf_printf(&out, ",tun-ipv6");
+    }
+
+    /*
+     * Tr=
y to get ifconfig parameters into the options string=2E
+     * If tt is un=
defined, make a temporary instantiation=2E
+     */
+    if (!tt)
+    {
+ =
       tt =3D init_tun(o->dev, o->dev_type, o->topology, o->ifconfig_local,=

+                      o->ifconfig_remote_netmask, o->ifconfig_ipv6_local,=
 o->ifconfig_ipv6_netbits,
+                      o->ifconfig_ipv6_remote, =
NULL, NULL, false, NULL, ctx, NULL);
+        if (tt)
+        {
+         =
   tt_local =3D true;
+        }
+    }
+
+    if (tt && p2p_nopull)
+    {=

+        const char *ios =3D ifconfig_options_string(tt, remote, o->ifconf=
ig_nowarn, gc);
+        if (ios && strlen(ios))
+        {
+            bu=
f_printf(&out, ",ifconfig %s", ios);
+        }
+    }
+    if (tt_local)
+=
    {
+        free(tt);
+        tt =3D NULL;
+    }
+
+#ifdef USE_COMP
+ =
   if (o->comp=2Ealg !=3D COMP_ALG_UNDEF)
+    {
+        /* for compatibil=
ity, this simply indicates that compression
+         * context is active, =
not necessarily LZO per-se */
+        buf_printf(&out, ",comp-lzo");
+    =
}
+#endif
+
+#ifdef ENABLE_FRAGMENT
+    if (o->ce=2Efragment)
+    {
+    =
    buf_printf(&out, ",mtu-dynamic");
+    }
+#endif
+
+#define TLS_CLIENT =
(o->tls_client)
+#define TLS_SERVER (o->tls_server)
+
+    /*
+     * Key d=
irection
+     */
+    {
+        const char *kd =3D keydirection2ascii(o->=
key_direction, remote, false);
+        if (kd)
+        {
+            buf=
_printf(&out, ",keydir %s", kd);
+        }
+    }
+
+    /*
+     * Crypto=
 Options
+     */
+    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVE=
R)
+    {
+        struct key_type kt;
+
+        ASSERT((o->shared_secret_=
file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) <=3D =
1);
+
+        /* Skip resolving BF-CBC to allow SSL libraries without BF-C=
BC
+         * to work here in the default configuration */
+        const =
char *ciphername =3D o->ciphername;
+        size_t keysize =3D 0;
+
+     =
   if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
+        {
+            in=
it_key_type(&kt, "none", o->authname, true, false);
+            keysize =
=3D 128;
+        }
+        else
+        {
+            init_key_type(&kt=
, o->ciphername, o->authname, true, false);
+            ciphername =3D cip=
her_kt_name(kt=2Ecipher);
+            if (cipher_defined(o->ciphername))
+=
            {
+                keysize =3D cipher_kt_key_size(kt=2Ecipher) =
* 8;
+            }
+        }
+        /* Only announce the cipher to our =
peer if we are willing to
+         * support it */
+        if (p2p_nopull=
 || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
+        {
+      =
      buf_printf(&out, ",cipher %s", ciphername);
+        }
+        buf_p=
rintf(&out, ",auth %s", md_kt_name(kt=2Edigest));
+        buf_printf(&out,=
 ",keysize %zu", keysize);
+        if (o->shared_secret_file)
+        {
+=
            buf_printf(&out, ",secret");
+        }
+    }
+
+    /*
+     =
* SSL Options
+     */
+    {
+        if (TLS_CLIENT || TLS_SERVER)
+     =
   {
+            if (o->ce=2Etls_auth_file)
+            {
+              =
  buf_printf(&out, ",tls-auth");
+            }
+            /* Not adding =
tls-crypt here, because we won't reach this code if
+             * tls-aut=
h/tls-crypt does not match=2E  Removing tls-auth here would
+             *=
 break stuff, so leaving that in place=2E */
+
+            buf_printf(&out=
, ",key-method %d", KEY_METHOD_2);
+        }
+
+        if (remote)
+     =
   {
+            if (TLS_CLIENT)
+            {
+                buf_print=
f(&out, ",tls-server");
+            }
+            else if (TLS_SERVER)
+ =
           {
+                buf_printf(&out, ",tls-client");
+           =
 }
+        }
+        else
+        {
+            if (TLS_CLIENT)
+      =
      {
+                buf_printf(&out, ",tls-client");
+            }
+ =
           else if (TLS_SERVER)
+            {
+                buf_printf(=
&out, ",tls-server");
+            }
+        }
+    }
+
+#undef TLS_CLIENT=

+#undef TLS_SERVER
+
+    return BSTR(&out);
+}
+
+/*
+ * Compare option s=
trings for equality=2E
+ * If the first two chars of the strings differ, it=
 means that
+ * we are looking at different versions of the options string,=

+ * therefore don't compare them and return true=2E
+ */
+
+static const c=
har *
+options_warning_extract_parm1(const char *option_string, struct gc_a=
rena *gc_ret)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer b=
 =3D string_alloc_buf(option_string, &gc);
+    char *p =3D gc_malloc(OPTIO=
N_PARM_SIZE, false, &gc);
+    const char *ret;
+
+    buf_parse(&b, ' ', p=
, OPTION_PARM_SIZE);
+    ret =3D string_alloc(p, gc_ret);
+    gc_free(&gc=
);
+    return ret;
+}
+
+static void
+options_warning_safe_scan2(const msg=
lvl_t msglevel, const int delim,
+                           const bool rep=
ort_inconsistent, const char *p1,
+                           const struct =
buffer *b2_src, const char *b1_name,
+                           const char=
 *b2_name)
+{
+    /* We will stop sending 'key-method', 'keydir', 'proto' =
and 'tls-auth' in
+     * OCC in a future version (because it's not useful)=
=2E To reduce questions
+     * when interoperating, we no longer printing =
a warning about it=2E
+     */
+    if (strprefix(p1, "key-method ") || str=
prefix(p1, "keydir ") || strprefix(p1, "proto ")
+        || streq(p1, "tls=
-auth") || strprefix(p1, "tun-ipv6") || strprefix(p1, "cipher "))
+    {
+ =
       return;
+    }
+
+    if (strlen(p1) > 0)
+    {
+        struct gc_=
arena gc =3D gc_new();
+        struct buffer b2 =3D *b2_src;
+        cons=
t char *p1_prefix =3D options_warning_extract_parm1(p1, &gc);
+        char=
 *p2 =3D gc_malloc(OPTION_PARM_SIZE, false, &gc);
+
+        while (buf_par=
se(&b2, delim, p2, OPTION_PARM_SIZE))
+        {
+            if (strlen(p2=
))
+            {
+                const char *p2_prefix =3D options_warnin=
g_extract_parm1(p2, &gc);
+
+                if (!strcmp(p1, p2))
+        =
        {
+                    goto done;
+                }
+             =
   if (!strcmp(p1_prefix, p2_prefix))
+                {
+                 =
   if (report_inconsistent)
+                    {
+                       =
 msg(msglevel, "WARNING: '%s' is used inconsistently, %s=3D'%s', %s=3D'%s'"=
,
+                            safe_print(p1_prefix, &gc), b1_name, safe_pr=
int(p1, &gc), b2_name,
+                            safe_print(p2, &gc));
+=
                    }
+                    goto done;
+                }
+ =
           }
+        }
+
+        msg(msglevel, "WARNING: '%s' is present =
in %s config but missing in %s config, %s=3D'%s'",
+            safe_print(=
p1_prefix, &gc), b1_name, b2_name, b1_name, safe_print(p1, &gc));
+
+done:
=
+        gc_free(&gc);
+    }
+}
+
+static void
+options_warning_safe_scan1=
(const msglvl_t msglevel, const int delim,
+                           cons=
t bool report_inconsistent, const struct buffer *b1_src,
+                 =
          const struct buffer *b2_src, const char *b1_name, const char *b2_=
name)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer b =3D *b1=
_src;
+    char *p =3D gc_malloc(OPTION_PARM_SIZE, true, &gc);
+
+    while=
 (buf_parse(&b, delim, p, OPTION_PARM_SIZE))
+    {
+        options_warnin=
g_safe_scan2(msglevel, delim, report_inconsistent, p, b2_src, b1_name,
+   =
                                b2_name);
+    }
+
+    gc_free(&gc);
+}
+
=
+static void
+options_warning_safe_ml(const msglvl_t msglevel, char *actual=
, const char *expected, size_t actual_n)
+{
+    struct gc_arena gc =3D gc_=
new();
+
+    if (actual_n > 0)
+    {
+        struct buffer local =3D all=
oc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
+        struct buffer remote =3D al=
loc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
+        actual[actual_n - 1] =3D 0=
;
+
+        buf_printf(&local, "version %s", expected);
+        buf_print=
f(&remote, "version %s", actual);
+
+        options_warning_safe_scan1(msg=
level, ',', true, &local, &remote, "local", "remote");
+
+        options_w=
arning_safe_scan1(msglevel, ',', false, &remote, &local, "remote", "local")=
;
+    }
+
+    gc_free(&gc);
+}
+
+bool
+options_cmp_equal_safe(char *actu=
al, const char *expected, size_t actual_n)
+{
+    struct gc_arena gc =3D g=
c_new();
+    bool ret =3D true;
+
+    if (actual_n > 0)
+    {
+        a=
ctual[actual_n - 1] =3D 0;
+        if (strncmp(actual, expected, 2))
+    =
    {
+            msg(D_SHOW_OCC, "NOTE: Options consistency check may be =
skewed by version differences");
+            options_warning_safe_ml(D_SHO=
W_OCC, actual, expected, actual_n);
+        }
+        else
+        {
+  =
          ret =3D !strcmp(actual, expected);
+        }
+    }
+    gc_free=
(&gc);
+    return ret;
+}
+
+bool
+options_cmp_equal(char *actual, const c=
har *expected)
+{
+    return options_cmp_equal_safe(actual, expected, strl=
en(actual) + 1);
+}
+
+void
+options_warning_safe(char *actual, const char =
*expected, size_t actual_n)
+{
+    options_warning_safe_ml(D_SHOW_OCC, act=
ual, expected, actual_n);
+}
+
+void
+options_warning(char *actual, const c=
har *expected)
+{
+    options_warning_safe(actual, expected, strlen(actual=
) + 1);
+}
+
+const char *
+options_string_version(const char *s, struct gc=
_arena *gc)
+{
+    struct buffer out =3D alloc_buf_gc(4, gc);
+    strncpy=
nt((char *)BPTR(&out), s, 3);
+    return BSTR(&out);
+}
+
+#if defined(__G=
NUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diag=
nostic ignored "-Wsign-compare"
+#endif
+
+char *
+options_string_extract_o=
ption(const char *options_string, const char *opt_name, struct gc_arena *gc=
)
+{
+    char *ret =3D NULL;
+    const size_t opt_name_len =3D strlen(opt=
_name);
+
+    const char *p =3D options_string;
+    while (p)
+    {
+   =
     if (0 =3D=3D strncmp(p, opt_name, opt_name_len) && strlen(p) > (opt_na=
me_len + 1)
+            && p[opt_name_len] =3D=3D ' ')
+        {
+       =
     /* option found, extract value */
+            const char *start =3D &=
p[opt_name_len + 1];
+            const char *end =3D strchr(p, ',');
+    =
        size_t val_len =3D end ? end - start : strlen(start);
+            =
ret =3D gc_malloc(val_len + 1, true, gc);
+            memcpy(ret, start, v=
al_len);
+            break;
+        }
+        p =3D strchr(p, ',');
+   =
     if (p)
+        {
+            p++; /* skip delimiter */
+        }
+ =
   }
+    return ret;
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#p=
ragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/options_string=2E=
h b/src/openvpn/options_string=2Eh
new file mode 100644
index 0000000=2E=2E=
33f9700
--- /dev/null
+++ b/src/openvpn/options_string=2Eh
@@ -0,0 +1,56 @@=

+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *     =
        over a single UDP port, with support for SSL/TLS-based
+ *         =
    session authentication and key exchange,
+ *             packet encrypt=
ion, packet authentication, and
+ *             packet compression=2E
+ *
+=
 *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This=
 program is free software; you can redistribute it and/or modify
+ *  it un=
der the terms of the GNU General Public License version 2
+ *  as published=
 by the Free Software Foundation=2E
+ *
+ *  This program is distributed in=
 the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ =
*
+ *  You should have received a copy of the GNU General Public License al=
ong
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifndef OPTIONS_STRING_H
+#define OPTIONS_STRING_H
+
+#include =
"buffer=2Eh"
+#include "options=2Eh"
+
+const char *options_string_version(=
const char *s, struct gc_arena *gc);
+
+char *options_string(const struct o=
ptions *o, const struct frame *frame, struct tuntap *tt,
+                 =
    openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc);
+
+bool opti=
ons_cmp_equal_safe(char *actual, const char *expected, size_t actual_n);
+
=
+void options_warning_safe(char *actual, const char *expected, size_t actua=
l_n);
+
+bool options_cmp_equal(char *actual, const char *expected);
+
+voi=
d options_warning(char *actual, const char *expected);
+
+/**
+ * Given an =
OpenVPN options string, extract the value of an option=2E
+ *
+ * @param op=
tions_string        Zero-terminated, comma-separated options string
+ * @pa=
ram opt_name              The name of the option to extract
+ * @param gc  =
                  The gc to allocate the return value
+ *
+ * @return gc-al=
located value of option with name opt_name if option was found,
+ *        =
 or NULL otherwise=2E
+ */
+char *options_string_extract_option(const char =
*options_string, const char *opt_name,
+                                   =
 struct gc_arena *gc);
+
+
+#endif
diff --git a/src/openvpn/ssl=2Ec b/src/o=
penvpn/ssl=2Ec
index 0ec03b9=2E=2E3e011dd 100644
--- a/src/openvpn/ssl=2Ec
=
+++ b/src/openvpn/ssl=2Ec
@@ -62,6 +62,7 @@
 #include "auth_token=2Eh"
 #in=
clude "mss=2Eh"
 #include "dco=2Eh"
+#include "options_string=2Eh"
 
 #incl=
ude "memdbg=2Eh"
 #include "openvpn=2Eh"

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
Gerrit-C=
hange-Number: 1773
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: =
razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--fmCGOvT/3Ko=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld <strong>up=
loaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">options: Factor out options_string code from options=2Ec<br><br>opti=
ons=2Ec is a huge, unwieldly file=2E So remove some<br>closely related code=
 that has no direct dependencies<br>with the other functions in the file=2E=
<br><br>This time it is the functions related to the creation<br>and testin=
g of the options string=2E<br><br>Change-Id: I6824058fc9c4efd48ceeb32d4164f=
97b2a243d85<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/o=
penvpn/init=2Ec<br>M src/openvpn/occ=2Ec<br>M src/openvpn/options=2Ec<br>M =
src/openvpn/options=2Eh<br>A src/openvpn/options_string=2Ec<br>A src/openvp=
n/options_string=2Eh<br>M src/openvpn/ssl=2Ec<br>9 files changed, 532 inser=
tions(+), 458 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/1773/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 540992b=2E=2Ed7a5=
e08 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMa=
keLists=2Etxt</span><br><span>@@ -529,6 +529,8 @@</span><br><span>     src/=
openvpn/options_parse=2Ec</span><br><span>     src/openvpn/options_show=2Ec=
</span><br><span>     src/openvpn/options_show=2Eh</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpn/options_string=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options_strin=
g=2Eh</span><br><span>     src/openvpn/otime=2Ec</span><br><span>     src/o=
penvpn/otime=2Eh</span><br><span>     src/openvpn/ovpn_dco_win=2Eh</span><b=
r><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam<=
/span><br><span>index 2092e96=2E=2E4650ddd 100644</span><br><span>--- a/src=
/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</spa=
n><br><span>@@ -109,6 +109,7 @@</span><br><span> 	openvpn=2Ec openvpn=2Eh \=
</span><br><span> 	options=2Ec options=2Eh \</span><br><span> 	options_show=
=2Ec options_show=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	options_string=2Ec options_string=2Eh \</span><br><span> 	options_util=
=2Ec options_util=2Eh \</span><br><span> 	options_parse=2Ec \</span><br><sp=
an> 	otime=2Ec otime=2Eh \</span><br><span>diff --git a/src/openvpn/init=2E=
c b/src/openvpn/init=2Ec</span><br><span>index d528c40=2E=2E38db7fa 100644<=
/span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvp=
n/init=2Ec</span><br><span>@@ -54,6 +54,7 @@</span><br><span> #include &quo=
t;dco=2Eh&quot;</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span>=
<br><span> #include &quot;schedule=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;options_string=2Eh&quot;</span><br>=
<span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/occ=2Ec b/src/openvpn/occ=2Ec</spa=
n><br><span>index aa262a8=2E=2Ef25ae19 100644</span><br><span>--- a/src/ope=
nvpn/occ=2Ec</span><br><span>+++ b/src/openvpn/occ=2Ec</span><br><span>@@ -=
29,7 +29,7 @@</span><br><span> #include &quot;occ=2Eh&quot;</span><br><span=
> #include &quot;forward=2Eh&quot;</span><br><span> #include &quot;memdbg=
=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_string=
=2Eh&quot;</span><br><span> </span><br><span> /*</span><br><span>  * This r=
andom string identifies an OpenVPN</span><br><span>diff --git a/src/openvpn=
/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 87da344=2E=2E3=
0a1029 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span=
>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3713,436 +3713,6 @@</spa=
n><br><span> }</span><br><span> </span><br><span> /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Build an options string to represent dat=
a channel encryption options=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * This string must match exactly between peers=2E  The keysize i=
s checked</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * separatel=
y by read_key()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The following optio=
ns must match on both peers:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Tunnel op=
tions:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * --dev tun|tap [unit number need=
 not match]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --dev-t=
ype tun|tap</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --link-=
mtu</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --udp-mtu</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tun-mtu</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * --proto udp</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * --proto tcp-client [matched with --proto=
 tcp-server</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        =
             on the other end of the connection]</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * --proto tcp-server [matched with --proto tcp-=
client on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *          =
           the other end of the connection]</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * --tun-ipv6</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * --ifconfig x y [matched with --ifconfig y x on</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *                 the other end =
of the connection]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --comp-lzo</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * --compress alg</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * --fragment</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Crypto Options:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --cip=
her</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --auth</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * --secret</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * SSL Options:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tls-=
auth</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tls-client [=
matched with --tls-server on</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *               the other end of the connection]</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * --tls-server [matched with --tls-clie=
nt on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *              =
 the other end of the connection]</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_string(const =
struct options *o, const struct frame *frame, struct tuntap *tt,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-               openvpn_net_ctx_t=
 *ctx, bool remote, struct gc_arena *gc)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct buffer out =3D alloc_buf(OPTION_LINE_SIZE);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool tt_local =3D false;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;V4&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * Tunnel Options</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;,d=
ev-type %s&quot;, dev_type_string(o-&gt;dev, o-&gt;dev_type));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* the link-mtu that we send h=
as only a meaning if have a fixed</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * cipher (p2p) or have a fallback cipher configured for ol=
der non</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * ncp cli=
ents=2E But not sending it will make even 2=2E4 complain</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * about it being missing=2E So stil=
l send it=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bu=
f_printf(&amp;out, &quot;,link-mtu %u&quot;, (unsigned int)calc_options_str=
ing_link_mtu(o, frame));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;ce=
=2Eocc_mtu !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(=
&amp;out, &quot;,tun-mtu %d&quot;, o-&gt;ce=2Eocc_mtu);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf=
_printf(&amp;out, &quot;,tun-mtu %d&quot;, frame-&gt;tun_mtu);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    buf_printf(&amp;out, &quot;,proto %s&quot;, proto_remote(o-&gt;ce=
=2Eproto, remote));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool p2p_nopull =3D=
 o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !PULL_DEFINED(o);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* send tun_ipv6 only in =
peer2peer mode - in client/server mode, it</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * is usually pushed by the server, triggering a n=
on-helpful warning</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;ifc=
onfig_ipv6_local &amp;&amp; p2p_nopull)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        buf_printf(&amp;out, &quot;,tun-ipv6&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Try to get i=
fconfig parameters into the options string=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * If tt is undefined, make a temporary instant=
iation=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tt)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        tt =3D init_tun(o-&gt;dev, o-&gt;dev_type, =
o-&gt;topology, o-&gt;ifconfig_local,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                      o-&gt;ifconfig_remote_netmask, o-&gt;=
ifconfig_ipv6_local, o-&gt;ifconfig_ipv6_netbits,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                      o-&gt;ifconfig_ipv6_remot=
e, NULL, NULL, false, NULL, ctx, NULL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (tt)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            tt_local =3D true;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (tt &amp;&amp; p2p_nopull)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const char *ios =3D ifconfig_option=
s_string(tt, remote, o-&gt;ifconfig_nowarn, gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (ios &amp;&amp; strlen(ios))</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,if=
config %s&quot;, ios);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt_local)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        free(tt);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        tt =3D NULL;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef USE_COM=
P</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;comp=
=2Ealg !=3D COMP_ALG_UNDEF)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bu=
f_printf(&amp;out, &quot;,comp-lzo&quot;); /* for compatibility, this simpl=
y indicates that compression</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                          context is active, not nec=
essarily LZO per-se */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_FRAGMENT</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (o-&gt;ce=2Efragment)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        buf_printf(&amp;out, &quot;,mtu-dynamic&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine TLS_CLIENT (o-&gt;tls_client)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define TLS_SERVER (o-&gt;tls_server)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 * Key direction</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        const char *kd =3D keydirec=
tion2ascii(o-&gt;key_direction, remote, false);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (kd)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            buf_printf(&amp;out, &quot;,keydir %s&quot;, kd);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Crypto Op=
tions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;shared_secret_fi=
le || TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct key_type kt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT((o-&gt=
;shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=
=3D true) &lt;=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Skip resol=
ving BF-CBC to allow SSL libraries without BF-CBC</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         * to work here in the default configur=
ation */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const=
 char *ciphername =3D o-&gt;ciphername;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        size_t keysize =3D 0;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            init_key_type(&amp;kt, &q=
uot;none&quot;, o-&gt;authname, true, false);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            keysize =3D 128;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname, true, f=
alse);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cip=
hername =3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (cipher_defined(o-&gt;ciphername))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                keysize =3D cipher_k=
t_key_size(kt=2Ecipher) * 8;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* On=
ly announce the cipher to our peer if we are willing to</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         * support it */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (p2p_nopull || tls_item_in_=
cipher_list(ciphername, o-&gt;ncp_ciphers))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            buf_printf(&amp;out, &quot;,cipher %s&quot;, cipherna=
me);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, =
&quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;,keysize %zu&q=
uot;, keysize);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          buf_printf(&amp;out, &quot;,secret&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     * SSL Options</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if (o-&gt;ce=2Etls_auth_file)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-a=
uth&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Not=
 adding tls-crypt here, because we won&#39;t reach this code if</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-             * tls-auth/tls-crypt=
 does not match=2E  Removing tls-auth here would</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-             * break stuff, so leaving that in p=
lace=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out,=
 &quot;,key-method %d&quot;, KEY_METHOD_2);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(remote)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (TLS_CLIEN=
T)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_printf(=
&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            else if (TLS_SERVER)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                buf_printf(&amp;out, &quot;,tls-client&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (TLS_CLIENT)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                buf_printf(&amp;out, &quot;,tls-client&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            else if (TLS_SERVER)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&am=
p;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#undef TLS_CLIENT</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#undef TLS_SERVER</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return BSTR(&amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Compare option strings for equality=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * If the first two chars of the st=
rings differ, it means that</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * we are looking at different versions of the options string,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * therefore don&#39;t compa=
re them and return true=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-options_cmp_equal(char *actual, const char *expecte=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return options_cmp_equal_safe(actua=
l, expected, strlen(actual) + 1);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-options_warning(char *actual, const char *expe=
cted)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    options_warning_safe(actual, exp=
ected, strlen(actual) + 1);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-options_warning_extract_parm1(const c=
har *option_string, struct gc_arena *gc_ret)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct buffer b =3D string_alloc_buf(option_string, &=
amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *p =
=3D gc_malloc(OPTION_PARM_SIZE, false, &amp;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const char *ret;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    buf_parse(&amp;b, &#39; &#39;, p, OPTION_PARM_SIZE);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ret =3D string_alloc(p, gc_ret)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-op=
tions_warning_safe_scan2(const msglvl_t msglevel, const int delim,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                           con=
st bool report_inconsistent, const char *p1,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                           const struct buffer *b2_s=
rc, const char *b1_name,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                           const char *b2_name)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* We will stop sending &#39;key-method&#39;, &#39;keydir&#39;=
, &#39;proto&#39; and &#39;tls-auth&#39; in</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     * OCC in a future version (because it&#39;s not =
useful)=2E To reduce questions</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     * when interoperating, we no longer printing a warning about =
it=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (strprefix(p1, &quot;ke=
y-method &quot;) || strprefix(p1, &quot;keydir &quot;) || strprefix(p1, &qu=
ot;proto &quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   || streq(p1, &quot;tls-auth&quot;) || strprefix(p1, &quot;tun-ipv6&quot;=
) || strprefix(p1, &quot;cipher &quot;))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (strlen(p1) &gt; 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer b2 =3D *b2=
_src;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const ch=
ar *p1_prefix =3D options_warning_extract_parm1(p1, &amp;gc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        char *p2 =3D gc_malloc(OPTI=
ON_PARM_SIZE, false, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        whil=
e (buf_parse(&amp;b2, delim, p2, OPTION_PARM_SIZE))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (strlen(p2))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                const char *p2_prefix =3D options_warning=
_extract_parm1(p2, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  if (!strcmp(p1, p2))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 goto done;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                if (!strcmp(p1_prefix, p2_prefix))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    if (report_inconsistent)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
msg(msglevel, &quot;WARNING: &#39;%s&#39; is used inconsistently, %s=3D&#39=
;%s&#39;, %s=3D&#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                            safe_print(p1_prefix, &amp;gc), b1=
_name, safe_print(p1, &amp;gc), b2_name,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                            safe_print(p2, &amp;gc));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    goto=
 done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        msg(msglevel, &quot;WARNING: &#39;%s&#39; is present=
 in %s config but missing in %s config, %s=3D&#39;%s&#39;&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            safe_print(p1_prefix=
, &amp;gc), b1_name, b2_name, b1_name, safe_print(p1, &amp;gc));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-done:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-options_warning_safe_scan1(const msglvl_t msglevel, const=
 int delim,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                 const bool report_inconsistent, const struct buffer *b1_sr=
c,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
        const struct buffer *b2_src, const char *b1_name, const char *b2_na=
me)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer b =3D=
 *b1_src;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *p =
=3D gc_malloc(OPTION_PARM_SIZE, true, &amp;gc);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    while (buf_parse(&amp;b, delim, p, OPTION_PARM_SIZE))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        options_warning_safe_scan2(msglevel, delim=
, report_inconsistent, p, b2_src, b1_name,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                   b2_name);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-options_warning_safe_ml(const msglvl_t msgl=
evel, char *actual, const char *expected, size_t actual_n)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (actual_n &gt; 0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      struct buffer local =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer=
 remote =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        actual[actual_n - 1] =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;local, &quot;version %=
s&quot;, expected);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      buf_printf(&amp;remote, &quot;version %s&quot;, actual);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        options_warning_safe_scan1(msglevel, &#39;,&#39=
;, true, &amp;local, &amp;remote, &quot;local&quot;, &quot;remote&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options_warning_safe_scan1(msglevel=
, &#39;,&#39;, false, &amp;remote, &amp;local, &quot;remote&quot;, &quot;lo=
cal&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-options_cmp_equal_safe(char *a=
ctual, const char *expected, size_t actual_n)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bool ret =3D true;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (actual_n &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        actual=
[actual_n - 1] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (strncmp(actual, expected, 2))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(D_SHOW_OCC, &quot;NOTE: Options consistency check m=
ay be skewed by version differences&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            options_warning_safe_ml(D_SHOW_OCC, actua=
l, expected, actual_n);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D !strcmp(act=
ual, expected);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_warning_safe(ch=
ar *actual, const char *expected, size_t actual_n)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-options_string_version(const char *s, struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf_gc(4, gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt((char *)BPTR(=
&amp;out), s, 3);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return BSTR(&amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-options_string_extract_opti=
on(const char *options_string, const char *opt_name, struct gc_arena *gc)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D NULL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const size_t opt_name_len =3D strlen(=
opt_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const char *p =3D options_st=
ring;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (p)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (0 =3D=3D strncmp(p, opt_name=
, opt_name_len) &amp;&amp; strlen(p) &gt; (opt_name_len + 1)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; p[opt_name_le=
n] =3D=3D &#39; &#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 /* option found, extract value */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            const char *start =3D &amp;p[opt_name_len + 1];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            const char *=
end =3D strchr(p, &#39;,&#39;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            size_t val_len =3D end ? end - start : strlen(start);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D g=
c_malloc(val_len + 1, true, gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            memcpy(ret, start, val_len);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        p =3D strchr(p, &#39;,&#39;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (p)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            p++; /* skip delimiter */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/*</span><br><span>  * parse/print topology coding</=
span><br><span>  */</span><br><span> </span><br><span>diff --git a/src/open=
vpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index d42773f=2E=
=2E0fd505a 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><=
span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -903,33 +903,6 @@</sp=
an><br><span> </span><br><span> bool string_defined_equal(const char *s1, c=
onst char *s2);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-const char *options_string_version(const char *s, struct gc_are=
na *gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-char *options_string(const struct =
options *o, const struct frame *frame, struct tuntap *tt,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                     openvpn_net_ctx_t =
*ctx, bool remote, struct gc_arena *gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bo=
ol options_cmp_equal_safe(char *actual, const char *expected, size_t actual=
_n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void options_warning_safe(char *actual=
, const char *expected, size_t actual_n);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-b=
ool options_cmp_equal(char *actual, const char *expected);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void options_warning(char *actual, const char *expected);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Given an OpenVPN options string, extract the value of an o=
ption=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * @param options_string        =
Zero-terminated, comma-separated options string</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @param opt_name              The name of the o=
ption to extract</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @p=
aram gc                    The gc to allocate the return value</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @return gc-allocated value of option with name opt=
_name if option was found,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *         or NULL otherwise=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cha=
r *options_string_extract_option(const char *options_string, const char *op=
t_name,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                      struct gc_arena *gc);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> void options_postprocess(struct options *options, struct=
 env_set *es);</span><br><span> </span><br><span> bool options_postprocess_=
pull(struct options *o, struct env_set *es);</span><br><span>diff --git a/s=
rc/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2E9c0313f</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/options_string=2Ec=
</span><br><span>@@ -0,0 +1,470 @@</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  OpenVPN -- An application to securely tunnel IP networks</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
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
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;mtu=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
ocket_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;tun=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Build an o=
ptions string to represent data channel encryption options=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * This string must match exactly=
 between peers=2E  The keysize is checked</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * separately by read_key()=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * The following options must match on both peers:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Tunnel options:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * --dev tun|tap [unit number need not match]</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * --dev-type tun|tap</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * --link-mtu</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * --udp-mtu</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * --tun-mtu</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * --proto udp</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * --proto tcp-client [matched with --proto tcp-server</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                     o=
n the other end of the connection]</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * --proto tcp-server [matched with --proto tcp-client on</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                    =
 the other end of the connection]</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * --tun-ipv6</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * --ifconfig x y [matched with --ifconfig y x on</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *                 the other end of t=
he connection]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --comp-lzo</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * --compress alg</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * --fragment</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Crypto Options:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * --cipher</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * -=
-auth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --secret</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * SSL Options:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * --tls-auth</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * --tls-client [matched with --tls-server on</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *               the other end of the =
connection]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls=
-server [matched with --tls-client on</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *               the other end of the connection]</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+options_string(const struct options *o, const struct f=
rame *frame, struct tuntap *tt,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+               openvpn_net_ctx_t *ctx, bool remote, struct gc_a=
rena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer out =3D al=
loc_buf(OPTION_LINE_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool tt_local =3D false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 buf_printf(&amp;out, &quot;V4&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Tunnel=
 Options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,dev-type =
%s&quot;, dev_type_string(o-&gt;dev, o-&gt;dev_type));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* the link-mtu that we send has onl=
y a meaning if have a fixed</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * cipher (p2p) or have a fallback cipher configured for older =
non</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ncp clien=
ts=2E But not sending it will make even 2=2E4 complain</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * about it being missing=2E So stil=
l send it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buf_printf(&amp;out, &quot;,link-mtu %u&quot;, (unsigned int)calc_options_s=
tring_link_mtu(o, frame));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&g=
t;ce=2Eocc_mtu !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf=
_printf(&amp;out, &quot;,tun-mtu %d&quot;, o-&gt;ce=2Eocc_mtu);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        buf_printf(&amp;out, &quot;,tun-mtu %d&quot;, frame-&gt;tun_mt=
u);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,proto %s&quot;, p=
roto_remote(o-&gt;ce=2Eproto, remote));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bool p2p_nopull =3D o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !=
PULL_DEFINED(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* send tun_ipv6 only in peer2peer mode - in client/server mode, it</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * is usually pushed b=
y the server, triggering a non-helpful warning</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (o-&gt;ifconfig_ipv6_local &amp;&amp; p2p_nopull)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,t=
un-ipv6&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * Try to get ifconfig parameters into the opt=
ions string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* If tt is undefined, make a temporary instantiation=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!tt)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        tt =3D init_tun(o-&gt;dev, o-&gt;dev_type, o-&gt;topology, o-&gt=
;ifconfig_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   o-&gt;ifconfig_remote_netmask, o-&gt;ifconfig_ipv6_local=
, o-&gt;ifconfig_ipv6_netbits,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                      o-&gt;ifconfig_ipv6_remote, NULL, NULL, fa=
lse, NULL, ctx, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 tt_local =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tt &amp;&amp; p2p_nopull)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const char *ios =3D ifconfig_opti=
ons_string(tt, remote, o-&gt;ifconfig_nowarn, gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (ios &amp;&amp; strlen(ios))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &=
quot;,ifconfig %s&quot;, ios);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt_lo=
cal)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        free(tt);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        tt =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifdef USE_COMP</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (o-&gt;comp=2Ealg !=3D COMP_ALG_UNDEF)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* for compatibility, this simply indicates tha=
t compression</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * context is active, not necessarily LZO per-se */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,comp-=
lzo&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef ENABLE_FRAGMENT</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (o-&gt;ce=2Efragment)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,mtu-dynamic&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define TLS_CLIENT (o-&gt;tls_client)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define TLS_SERVER (o-&gt;tls_server)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * Key direction</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st char *kd =3D keydirection2ascii(o-&gt;key_direction, remote, false);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (kd)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quo=
t;,keydir %s&quot;, kd);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * Crypto Options</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (o-&gt;shared_secret_file || TLS_CLIENT || TLS_SERVER)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct key_type kt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        ASSERT((o-&gt;shared_secret_file !=
=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) &lt;=3D 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* Skip resolving BF-CBC to al=
low SSL libraries without BF-CBC</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * to work here in the default configuration */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *cipher=
name =3D o-&gt;ciphername;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        size_t keysize =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            init_key_type(&amp;kt, &quot=
;none&quot;, o-&gt;authname, true, false);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            keysize =3D 128;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname,=
 true, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ciphername =3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (cipher_defined(o-&gt;ciphern=
ame))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                keys=
ize =3D cipher_kt_key_size(kt=2Ecipher) * 8;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* Only announce the cipher to our peer if we are willing =
to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * suppor=
t it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
p2p_nopull || tls_item_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &q=
uot;,cipher %s&quot;, ciphername);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        buf_printf(&amp;out, &quot;,auth %s&quot;, md_kt_name(kt=2Edig=
est));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_p=
rintf(&amp;out, &quot;,keysize %zu&quot;, keysize);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;shared_secret_file)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, =
&quot;,secret&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * SSL Options</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (o-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                buf_printf(&amp;out, &quot;,tls-auth&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Not add=
ing tls-crypt here, because we won&#39;t reach this code if</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             * tls-auth/tls-crypt d=
oes not match=2E  Removing tls-auth here would</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+             * break stuff, so leaving that in p=
lace=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;=
out, &quot;,key-method %d&quot;, KEY_METHOD_2);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (TLS_CLIENT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       buf_printf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else if (TLS_SERVER)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &qu=
ot;,tls-client&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (TLS_CLIENT)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                buf_printf(&=
amp;out, &quot;,tls-client&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            else if (TLS_SERVER)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                buf_printf(&amp;out, &quot;,tls-server&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#undef TLS_CLIENT</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#undef TLS_SERVER</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return BS=
TR(&amp;out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Compare option strings for equality=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * If the first two chars of the str=
ings differ, it means that</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * we are looking at different versions of the options string,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * therefore don&#39;t co=
mpare them and return true=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+options_warning_extract_p=
arm1(const char *option_string, struct gc_arena *gc_ret)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer b =3D string_alloc_bu=
f(option_string, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char *p =3D gc_malloc(OPTION_PARM_SIZE, false, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ret;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_parse(&amp;b, &#39; &#39;, p, OPTION_=
PARM_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D string_alloc(p, gc_ret);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+options_warning_safe_scan2(const msglv=
l_t msglevel, const int delim,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                           const bool report_inconsistent, const=
 char *p1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                  const struct buffer *b2_src, const char *b1_name,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
const char *b2_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We will st=
op sending &#39;key-method&#39;, &#39;keydir&#39;, &#39;proto&#39; and &#39=
;tls-auth&#39; in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * OCC in a future version (because it&#39;s not useful)=2E To reduce que=
stions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * when i=
nteroperating, we no longer printing a warning about it=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (strprefix(p1, &quot;key-method &quot;) |=
| strprefix(p1, &quot;keydir &quot;) || strprefix(p1, &quot;proto &quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || streq(p1, =
&quot;tls-auth&quot;) || strprefix(p1, &quot;tun-ipv6&quot;) || strprefix(p=
1, &quot;cipher &quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (strlen(p1) &gt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct buffer b2 =3D *b2=
_src;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
char *p1_prefix =3D options_warning_extract_parm1(p1, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        char *p2 =3D gc_malloc(=
OPTION_PARM_SIZE, false, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    while (buf_parse(&amp;b2, delim, p2, OPTION_PARM_SIZE))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (strlen(p2))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const char *p2_prefix =3D=
 options_warning_extract_parm1(p2, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                if (!strcmp(p1, p2))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    goto done;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if (!strcmp(p1_prefix, p2=
_prefix))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        if (report_inconsistent)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        msg(msglevel, &quot;WARNING: &#39;%s=
&#39; is used inconsistently, %s=3D&#39;%s&#39;, %s=3D&#39;%s&#39;&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       safe_print(p1_prefix, &amp;gc), b1_name, safe_print(p1, &amp;gc), b2=
_name,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
               safe_print(p2, &amp;gc));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    goto done;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(msglevel, &quot;WARNING: &#39;%s&#39; is present in %s config bu=
t missing in %s config, %s=3D&#39;%s&#39;&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            safe_print(p1_prefix, &amp;gc), b1=
_name, b2_name, b1_name, safe_print(p1, &amp;gc));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+options_warning_safe_scan1(const msglvl_t msglevel, con=
st int delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                     const bool report_inconsistent, const struct buffer *b=
1_src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
              const struct buffer *b2_src, const char *b1_name, const char =
*b2_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer b =3D *b1_src;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char *p =3D gc_malloc(OPTION_PARM_SIZE, true, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    while (buf_parse(&amp;b, delim, p, OPTION_PARM_S=
IZE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        options_warning_safe=
_scan2(msglevel, delim, report_inconsistent, p, b2_src, b1_name,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
     b2_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+option=
s_warning_safe_ml(const msglvl_t msglevel, char *actual, const char *expect=
ed, size_t actual_n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (actual_n &g=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer local =
=3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct buffer remote =3D alloc_buf_gc=
(OPTION_PARM_SIZE + 16, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        actual[actual_n - 1] =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_printf(&amp;local, &quot;version %s&quot;, expected)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf=
(&amp;remote, &quot;version %s&quot;, actual);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        options_warning_safe_scan1(msglevel, &#39;,&#39;, true, &am=
p;local, &amp;remote, &quot;local&quot;, &quot;remote&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        options_warning_safe_scan1(msglevel, &#39;,&=
#39;, false, &amp;remote, &amp;local, &quot;remote&quot;, &quot;local&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+options_cmp_equal_safe(ch=
ar *actual, const char *expected, size_t actual_n)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (actual_n &gt; 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        actual[actual_n - 1] =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (strncmp(actual, expected, 2))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_SHOW_OCC, &quot;NOTE: O=
ptions consistency check may be skewed by version differences&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            options_warni=
ng_safe_ml(D_SHOW_OCC, actual, expected, actual_n);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ret =3D !strcmp(actual, expected);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+options_cmp_equal(char *actual, const char *=
expected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return options_cmp_equal=
_safe(actual, expected, strlen(actual) + 1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+options_warning_safe(char *=
actual, const char *expected, size_t actual_n)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+options_warning(char *actual, const char *expected)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    options_warning_safe(actual, expected, strlen(actua=
l) + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+options_string_version(const char *s, struct gc_arena *=
gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer out =3D alloc_bu=
f_gc(4, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
ncpynt((char *)BPTR(&amp;out), s, 3);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return BSTR(&amp;out);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+options_string_extract_option(const char *options_string, cons=
t char *opt_name, struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    char *ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const size_t opt_name_len =3D strlen(opt_name);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *p =3D options_string;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    while (p)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (0 =3D=3D strncmp(p, opt_name, opt_name_len) &am=
p;&amp; strlen(p) &gt; (opt_name_len + 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &amp;&amp; p[opt_name_len] =3D=3D &#39; &=
#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* option fo=
und, extract value */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            const char *start =3D &amp;p[opt_name_len + 1];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            const char *end =3D s=
trchr(p, &#39;,&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            size_t val_len =3D end ? end - start : strlen(start);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D gc_mal=
loc(val_len + 1, true, gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            memcpy(ret, start, val_len);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        p =3D strchr(p, &#39;,&#39;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (p)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            p++; /* skip delimiter */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span>diff --git a/src/openvpn/options_string=2Eh b/s=
rc/openvpn/options_string=2Eh</span><br><span>new file mode 100644</span><b=
r><span>index 0000000=2E=2E33f9700</span><br><span>--- /dev/null</span><br>=
<span>+++ b/src/openvpn/options_string=2Eh</span><br><span>@@ -0,0 +1,56 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to sec=
urely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             over a single UDP port, with support for SSL/TLS-based<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessi=
on authentication and key exchange,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet encryption, packet authentication, an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) =
2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  This program is free software; you can redistribute it and=
/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it un=
der the terms of the GNU General Public License version 2</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software=
 Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is di=
stributed in the hope that it will be useful,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the im=
plied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licens=
e for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see=
 &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef O=
PTIONS_STRING_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine OPTIONS_STRING_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buf=
fer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *=
options_string_version(const char *s, struct gc_arena *gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+char *options_string(const struct options *o, const st=
ruct frame *frame, struct tuntap *tt,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                     openvpn_net_ctx_t *ctx, bool remote,=
 struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool options_cmp=
_equal_safe(char *actual, const char *expected, size_t actual_n);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void options_warning_safe(char *actual, const ch=
ar *expected, size_t actual_n);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool op=
tions_cmp_equal(char *actual, const char *expected);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void options_warning(char *actual, const char *expected);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Given an OpenVPN options string, extract the value of =
an option=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param options_string=
        Zero-terminated, comma-separated options string</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param opt_name              The nam=
e of the option to extract</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param gc                    The gc to allocate the return value<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return gc-allocated value of opti=
on with name opt_name if option was found,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *         or NULL otherwise=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+char *options_string_extract_option(const char *options_=
string, const char *opt_name,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                    struct gc_arena *gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/ope=
nvpn/ssl=2Ec</span><br><span>index 0ec03b9=2E=2E3e011dd 100644</span><br><s=
pan>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</sp=
an><br><span>@@ -62,6 +62,7 @@</span><br><span> #include &quot;auth_token=
=2Eh&quot;</span><br><span> #include &quot;mss=2Eh&quot;</span><br><span> #=
include &quot;dco=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;options_string=2Eh&quot;</span><br><span> </span><br=
><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ope=
nvpn=2Eh&quot;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">change 1773=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
6824058fc9c4efd48ceeb32d4164f97b2a243d85 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1773 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</bod=
y></html>
--fmCGOvT/3Ko=--


--===============2591676614086758759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2591676614086758759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2591676614086758759==--

