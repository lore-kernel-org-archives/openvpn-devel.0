Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3178C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=vgPpiesPRp7XIRPX8hSesHaWMkViGGC43DsIz1X5mN0=; b=k46oEFfrlnZTFn
	DyKeJ0h3vkfdjszVoZ4dPMq5D66KR7XHaGGfk7tIA59znsVTs66tgEGBcdw8oX8UsLiO6IAzimTC0
	DcZeOjwrlKS+xUzhZ2QipfR1jNFr+VUdpHB8GdRyqCqCpC7vepSivf5Ks21UxKRlA9dHXc9h5c6zc
	P/A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqXn-0004Np-Qb;
	Thu, 09 Jul 2026 15:20:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqXZ-0004Mt-OT
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:19:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QukLyAARaiBeEkPbSD8zbcuZb6wfrVPCGZSGx1T5tY0=; b=QC/idw4pGQ6BZTu9u3pEIljzYj
 igqLRcMx/Id9p8gmpc4n412glRlaMRQRe893KcCgGRqtOXpODcFwhYV5Dxws2UQsF7NrdcsPJpUS/
 Yn1ETmQvQD39CHZmIg4nglfmxJ3V2BGZYKrtrsv02EMwPJ/wAjGdi21rqlYqUoU7i+WU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QukLyAARaiBeEkPbSD8zbcuZb6wfrVPCGZSGx1T5tY0=; b=D
 wULV0gyR8ax6Ops5kaANE5S1blMfT6+k4uF/Hk/+kDc8KirIcZrVwsPmB7b+MiQZghQI3hbXhKKkM
 H58N79t8xgg0Qog1akkDzkTgOtpOiwuhVZziz9iMwL9wdypByV/9lcBvMHVcj83Lp0TBUrLf7hXIw
 G3hUWmjj6nQIFrpg=;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqXU-0007Yz-4G for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:19:52 +0000
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-69c19a37eeaso305813a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783610381; x=1784215181; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QukLyAARaiBeEkPbSD8zbcuZb6wfrVPCGZSGx1T5tY0=;
 b=PHK9Du6AnotGKfmq7tvf1Z8K1s9+C0klqGgntJyuF9jnBQ4jI5A3GAVsxFbWLKr3tF
 mQ5OpKslzOM2jAv/6CeegETiFn7uJ5gDCqP7HlMcnRRBOJSpH449csNrBNdbkGwTsclA
 7kwEDCDEtQUtZtBhL7K2zOh7Dq3JyBVHgDJ0hoD6VP+mdhNurHPY3lHlsSLZ4fGM1rv2
 3pFk4Q8F9ZKc+pVqUIMBQDw65XPDSZcbITWWiNNkw5N7nTJIv9X26t64iegMSHeAeHXv
 QbaczEtD9DdSppbpRkOQUbOceJHUocaoDd8U5fCEWRpIEvrCfg21cJ7YtywB/tIJeg2C
 EgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783610381; x=1784215181;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QukLyAARaiBeEkPbSD8zbcuZb6wfrVPCGZSGx1T5tY0=;
 b=lnWd0D2IoOa5MWv/zrxn0AP8BNyfxauorXOqE4bhIuJ3hvrKPv0tMQPbqLGryDZvTA
 vcmTq8GKHrdVqE6kV+D9qnRmSzrWINV6gvATWGp7goAYLZq4OI8FgnMpoTmvUDWqb9E5
 j8FMceUQI4ZJs+cvha/suTuBGsIhr97Jc+Ref4u9b5cptSCvqYig64QJqj1x4pHlN6cr
 s9Vox3ecE60zRjy/icq6A126xzXM4tuy9+vjl7i7JP0vfJg5dvQe8nvCRM3HnR+b/RWN
 232cLCqPu4nWacCP1d63LmJQGjmdxQhSJuBTwWsgA9lWfz6teFUgCU5rZNsE/Syh73YI
 /hVg==
X-Gm-Message-State: AOJu0YwMldXeshP/SXNhDbh6fupXzkZVFFjSk1x0c+UDACoteBNnG0jc
 10QuyoDK5DV56YHTVZcIOe/+WPyxxyXYNSgspr94o9Qe4V0pS0AdcbgYeY2llhlDPRKByn8dILn
 uMPrndGp40px8M3lf5bkKhEay4/SAe7Nkeq6nn2Arzr+tBY7BA9khYP6lTT3X6BpK+mA7HuyV6F
 ZjaYLB2g==
X-Gm-Gg: AfdE7cleOPq1833EMxg81MyzdbFwbfy6sVO15K1jJRbZEAPpJgH2rAU6kmPUooS/r1D
 o5psTZquNR83q9O3f7qTorO697db8p6DZUGTurSIyOzcQ5tCNTFdAm1dCXu9DUc1/AJ9nNaDwqz
 YoCaBuo4SPTzl0x1UE6OdCS6evTz0q8YClgvUvZPC06f7oBF95Ac5FHgN48j8UdM6A1U9KdtsoY
 CZTv+HOcsgTcG20cvigDdD/v4DRib9CEhfO9EHNl6KRhwSvoRlg0cwnDz3ZitzaPO+UqhZM+iQH
 lRG44D2qX1DQU7++1JuD2UyEv97UeM0hh+k8I2egGz1qOOeIsyR3aWaDxxIV98ozJeHf1ZfALbF
 Pl342E6hs7BjhGt/NppTKziSeJ9sLzEwYARQU2/7oJLEvwiaj/bGCUcfjismfN2kWkmOiNqAlqG
 Ox24jf0YHdABNDaaUdtDwkXpEvqLFZl97hccAHMFk7kfSqfdZfQVzBb5S/+Y0QMydsBy5AjJsKs
 xn0hxNEFAU9b2y6bGU5/UbjeNrwYncqzg8QaMvMVPW59gApgGopdQy51/WM917l1yFlTx3VxIST
 nmQ=
X-Received: by 2002:a05:600c:4745:b0:493:bd67:316 with SMTP id
 5b1f17b1804b1-493e684b001mr65884645e9.16.1783600911786; 
 Thu, 09 Jul 2026 05:41:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ee2bcac0sm49149665e9.0.2026.07.09.05.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:41:51 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 12:41:50 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: f37a70fd93b2aa934e3ddc309fbc717c88322605
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb7c37c6954ec84245a5c1aaf20a1a66f88f0c4c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqXU-0007Yz-4G
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1489103106318894798=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1489103106318894798==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gg4XHE4qAIo="; charset=UTF-8

--Gg4XHE4qAIo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1773?usp=3Demail

to review the following change=2E


Chang=
e subject: options: Factor out options_string code from options=2Ec
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: Factor out=
 options_string code from options=2Ec

options=2Ec is a huge, unwieldly fil=
e=2E So remove some
closely related code that has no direct dependencies
wi=
th the other functions in the file=2E

This time it is the functions relate=
d to the creation
and testing of the options string=2E

Change-Id: I6824058=
fc9c4efd48ceeb32d4164f97b2a243d85
Signed-off-by: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/=
openvpn/init=2Ec
M src/openvpn/occ=2Ec
M src/openvpn/options=2Ec
M src/open=
vpn/options=2Eh
A src/openvpn/options_string=2Ec
A src/openvpn/options_stri=
ng=2Eh
M src/openvpn/ssl=2Ec
9 files changed, 532 insertions(+), 458 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/73/1773/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index b6054d6=
=2E=2E3981bae 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -520,=
6 +520,8 @@
     src/openvpn/options_parse=2Ec
     src/openvpn/options_sho=
w=2Ec
     src/openvpn/options_show=2Eh
+    src/openvpn/options_string=2Ec=

+    src/openvpn/options_string=2Eh
     src/openvpn/otime=2Ec
     src/op=
envpn/otime=2Eh
     src/openvpn/ovpn_dco_win=2Eh
diff --git a/src/openvpn/=
Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 0fbd006=2E=2E9778f32 100644=

--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -109,6 =
+109,7 @@
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options=
_show=2Ec options_show=2Eh \
+	options_string=2Ec options_string=2Eh \
 	op=
tions_util=2Ec options_util=2Eh \
 	options_parse=2Ec \
 	otime=2Ec otime=
=2Eh \
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 41fa5=
57=2E=2E7c4fce8 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2E=
c
@@ -53,6 +53,7 @@
 #include "mudp=2Eh"
 #include "dco=2Eh"
 #include "tun=
_afunix=2Eh"
+#include "options_string=2Eh"
 
 #include "memdbg=2Eh"
 
diff=
 --git a/src/openvpn/occ=2Ec b/src/openvpn/occ=2Ec
index aa262a8=2E=2Ef25ae=
19 100644
--- a/src/openvpn/occ=2Ec
+++ b/src/openvpn/occ=2Ec
@@ -29,7 +29,=
7 @@
 #include "occ=2Eh"
 #include "forward=2Eh"
 #include "memdbg=2Eh"
-
+=
#include "options_string=2Eh"
 
 /*
  * This random string identifies an Op=
enVPN
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index =
8f5bc2a=2E=2E6e314a1 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn=
/options=2Ec
@@ -3705,436 +3705,6 @@
 }
 
 /*
- * Build an options string t=
o represent data channel encryption options=2E
- * This string must match e=
xactly between peers=2E  The keysize is checked
- * separately by read_key(=
)=2E
- *
- * The following options must match on both peers:
- *
- * Tunnel=
 options:
- *
- * --dev tun|tap [unit number need not match]
- * --dev-type=
 tun|tap
- * --link-mtu
- * --udp-mtu
- * --tun-mtu
- * --proto udp
- * --p=
roto tcp-client [matched with --proto tcp-server
- *                     on=
 the other end of the connection]
- * --proto tcp-server [matched with --pr=
oto tcp-client on
- *                     the other end of the connection]
=
- * --tun-ipv6
- * --ifconfig x y [matched with --ifconfig y x on
- *      =
           the other end of the connection]
- *
- * --comp-lzo
- * --compre=
ss alg
- * --fragment
- *
- * Crypto Options:
- *
- * --cipher
- * --auth
-=
 * --secret
- *
- * SSL Options:
- *
- * --tls-auth
- * --tls-client [match=
ed with --tls-server on
- *               the other end of the connection]
=
- * --tls-server [matched with --tls-client on
- *               the other =
end of the connection]
- */
-char *
-options_string(const struct options *o=
, const struct frame *frame, struct tuntap *tt,
-               openvpn_net=
_ctx_t *ctx, bool remote, struct gc_arena *gc)
-{
-    struct buffer out =
=3D alloc_buf(OPTION_LINE_SIZE);
-    bool tt_local =3D false;
-
-    buf_p=
rintf(&out, "V4");
-
-    /*
-     * Tunnel Options
-     */
-
-    buf_pri=
ntf(&out, ",dev-type %s", dev_type_string(o->dev, o->dev_type));
-    /* th=
e link-mtu that we send has only a meaning if have a fixed
-     * cipher (=
p2p) or have a fallback cipher configured for older non
-     * ncp clients=
=2E But not sending it will make even 2=2E4 complain
-     * about it being=
 missing=2E So still send it=2E */
-    buf_printf(&out, ",link-mtu %u", (u=
nsigned int)calc_options_string_link_mtu(o, frame));
-
-    if (o->ce=2Eocc=
_mtu !=3D 0)
-    {
-        buf_printf(&out, ",tun-mtu %d", o->ce=2Eocc_mt=
u);
-    }
-    else
-    {
-        buf_printf(&out, ",tun-mtu %d", frame-=
>tun_mtu);
-    }
-
-    buf_printf(&out, ",proto %s", proto_remote(o->ce=
=2Eproto, remote));
-
-    bool p2p_nopull =3D o->mode =3D=3D MODE_POINT_TO=
_POINT && !PULL_DEFINED(o);
-    /* send tun_ipv6 only in peer2peer mode - =
in client/server mode, it
-     * is usually pushed by the server, triggeri=
ng a non-helpful warning
-     */
-    if (o->ifconfig_ipv6_local && p2p_no=
pull)
-    {
-        buf_printf(&out, ",tun-ipv6");
-    }
-
-    /*
-    =
 * Try to get ifconfig parameters into the options string=2E
-     * If tt =
is undefined, make a temporary instantiation=2E
-     */
-    if (!tt)
-   =
 {
-        tt =3D init_tun(o->dev, o->dev_type, o->topology, o->ifconfig_l=
ocal,
-                      o->ifconfig_remote_netmask, o->ifconfig_ipv6_l=
ocal, o->ifconfig_ipv6_netbits,
-                      o->ifconfig_ipv6_rem=
ote, NULL, NULL, false, NULL, ctx, NULL);
-        if (tt)
-        {
-    =
        tt_local =3D true;
-        }
-    }
-
-    if (tt && p2p_nopull)
-=
    {
-        const char *ios =3D ifconfig_options_string(tt, remote, o->i=
fconfig_nowarn, gc);
-        if (ios && strlen(ios))
-        {
-         =
   buf_printf(&out, ",ifconfig %s", ios);
-        }
-    }
-    if (tt_loc=
al)
-    {
-        free(tt);
-        tt =3D NULL;
-    }
-
-#ifdef USE_CO=
MP
-    if (o->comp=2Ealg !=3D COMP_ALG_UNDEF)
-    {
-        buf_printf(&=
out, ",comp-lzo"); /* for compatibility, this simply indicates that compres=
sion
-                                          context is active, not nece=
ssarily LZO per-se */
-    }
-#endif
-
-#ifdef ENABLE_FRAGMENT
-    if (o->=
ce=2Efragment)
-    {
-        buf_printf(&out, ",mtu-dynamic");
-    }
-#e=
ndif
-
-#define TLS_CLIENT (o->tls_client)
-#define TLS_SERVER (o->tls_serv=
er)
-
-    /*
-     * Key direction
-     */
-    {
-        const char *kd=
 =3D keydirection2ascii(o->key_direction, remote, false);
-        if (kd)
=
-        {
-            buf_printf(&out, ",keydir %s", kd);
-        }
-   =
 }
-
-    /*
-     * Crypto Options
-     */
-    if (o->shared_secret_file=
 || TLS_CLIENT || TLS_SERVER)
-    {
-        struct key_type kt;
-
-      =
  ASSERT((o->shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TL=
S_SERVER =3D=3D true) <=3D 1);
-
-        /* Skip resolving BF-CBC to allow=
 SSL libraries without BF-CBC
-         * to work here in the default confi=
guration */
-        const char *ciphername =3D o->ciphername;
-        siz=
e_t keysize =3D 0;
-
-        if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)=

-        {
-            init_key_type(&kt, "none", o->authname, true, fals=
e);
-            keysize =3D 128;
-        }
-        else
-        {
-    =
        init_key_type(&kt, o->ciphername, o->authname, true, false);
-     =
       ciphername =3D cipher_kt_name(kt=2Ecipher);
-            if (cipher_=
defined(o->ciphername))
-            {
-                keysize =3D cipher_=
kt_key_size(kt=2Ecipher) * 8;
-            }
-        }
-        /* Only an=
nounce the cipher to our peer if we are willing to
-         * support it *=
/
-        if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_cip=
hers))
-        {
-            buf_printf(&out, ",cipher %s", ciphername);
=
-        }
-        buf_printf(&out, ",auth %s", md_kt_name(kt=2Edigest));
=
-        buf_printf(&out, ",keysize %zu", keysize);
-        if (o->shared_=
secret_file)
-        {
-            buf_printf(&out, ",secret");
-        =
}
-    }
-
-    /*
-     * SSL Options
-     */
-    {
-        if (TLS_CLI=
ENT || TLS_SERVER)
-        {
-            if (o->ce=2Etls_auth_file)
-    =
        {
-                buf_printf(&out, ",tls-auth");
-            }
- =
           /* Not adding tls-crypt here, because we won't reach this code i=
f
-             * tls-auth/tls-crypt does not match=2E  Removing tls-auth h=
ere would
-             * break stuff, so leaving that in place=2E */
-
-  =
          buf_printf(&out, ",key-method %d", KEY_METHOD_2);
-        }
-
- =
       if (remote)
-        {
-            if (TLS_CLIENT)
-            {
-=
                buf_printf(&out, ",tls-server");
-            }
-          =
  else if (TLS_SERVER)
-            {
-                buf_printf(&out, ",t=
ls-client");
-            }
-        }
-        else
-        {
-          =
  if (TLS_CLIENT)
-            {
-                buf_printf(&out, ",tls-cl=
ient");
-            }
-            else if (TLS_SERVER)
-            {
-  =
              buf_printf(&out, ",tls-server");
-            }
-        }
- =
   }
-
-#undef TLS_CLIENT
-#undef TLS_SERVER
-
-    return BSTR(&out);
-}
-=

-/*
- * Compare option strings for equality=2E
- * If the first two chars =
of the strings differ, it means that
- * we are looking at different versio=
ns of the options string,
- * therefore don't compare them and return true=
=2E
- */
-
-bool
-options_cmp_equal(char *actual, const char *expected)
-{
=
-    return options_cmp_equal_safe(actual, expected, strlen(actual) + 1);
-=
}
-
-void
-options_warning(char *actual, const char *expected)
-{
-    opti=
ons_warning_safe(actual, expected, strlen(actual) + 1);
-}
-
-static const =
char *
-options_warning_extract_parm1(const char *option_string, struct gc_=
arena *gc_ret)
-{
-    struct gc_arena gc =3D gc_new();
-    struct buffer =
b =3D string_alloc_buf(option_string, &gc);
-    char *p =3D gc_malloc(OPTI=
ON_PARM_SIZE, false, &gc);
-    const char *ret;
-
-    buf_parse(&b, ' ', =
p, OPTION_PARM_SIZE);
-    ret =3D string_alloc(p, gc_ret);
-    gc_free(&g=
c);
-    return ret;
-}
-
-static void
-options_warning_safe_scan2(const ms=
glvl_t msglevel, const int delim,
-                           const bool re=
port_inconsistent, const char *p1,
-                           const struct=
 buffer *b2_src, const char *b1_name,
-                           const cha=
r *b2_name)
-{
-    /* We will stop sending 'key-method', 'keydir', 'proto'=
 and 'tls-auth' in
-     * OCC in a future version (because it's not useful=
)=2E To reduce questions
-     * when interoperating, we no longer printing=
 a warning about it=2E
-     */
-    if (strprefix(p1, "key-method ") || st=
rprefix(p1, "keydir ") || strprefix(p1, "proto ")
-        || streq(p1, "tl=
s-auth") || strprefix(p1, "tun-ipv6") || strprefix(p1, "cipher "))
-    {
-=
        return;
-    }
-
-    if (strlen(p1) > 0)
-    {
-        struct gc=
_arena gc =3D gc_new();
-        struct buffer b2 =3D *b2_src;
-        con=
st char *p1_prefix =3D options_warning_extract_parm1(p1, &gc);
-        cha=
r *p2 =3D gc_malloc(OPTION_PARM_SIZE, false, &gc);
-
-        while (buf_pa=
rse(&b2, delim, p2, OPTION_PARM_SIZE))
-        {
-            if (strlen(p=
2))
-            {
-                const char *p2_prefix =3D options_warni=
ng_extract_parm1(p2, &gc);
-
-                if (!strcmp(p1, p2))
-       =
         {
-                    goto done;
-                }
-            =
    if (!strcmp(p1_prefix, p2_prefix))
-                {
-                =
    if (report_inconsistent)
-                    {
-                      =
  msg(msglevel, "WARNING: '%s' is used inconsistently, %s=3D'%s', %s=3D'%s'=
",
-                            safe_print(p1_prefix, &gc), b1_name, safe_p=
rint(p1, &gc), b2_name,
-                            safe_print(p2, &gc));
=
-                    }
-                    goto done;
-                }
-=
            }
-        }
-
-        msg(msglevel, "WARNING: '%s' is present=
 in %s config but missing in %s config, %s=3D'%s'",
-            safe_print=
(p1_prefix, &gc), b1_name, b2_name, b1_name, safe_print(p1, &gc));
-
-done:=

-        gc_free(&gc);
-    }
-}
-
-static void
-options_warning_safe_scan=
1(const msglvl_t msglevel, const int delim,
-                           con=
st bool report_inconsistent, const struct buffer *b1_src,
-                =
           const struct buffer *b2_src, const char *b1_name, const char *b2=
_name)
-{
-    struct gc_arena gc =3D gc_new();
-    struct buffer b =3D *b=
1_src;
-    char *p =3D gc_malloc(OPTION_PARM_SIZE, true, &gc);
-
-    whil=
e (buf_parse(&b, delim, p, OPTION_PARM_SIZE))
-    {
-        options_warni=
ng_safe_scan2(msglevel, delim, report_inconsistent, p, b2_src, b1_name,
-  =
                                 b2_name);
-    }
-
-    gc_free(&gc);
-}
-=

-static void
-options_warning_safe_ml(const msglvl_t msglevel, char *actua=
l, const char *expected, size_t actual_n)
-{
-    struct gc_arena gc =3D gc=
_new();
-
-    if (actual_n > 0)
-    {
-        struct buffer local =3D al=
loc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
-        struct buffer remote =3D a=
lloc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
-        actual[actual_n - 1] =3D =
0;
-
-        buf_printf(&local, "version %s", expected);
-        buf_prin=
tf(&remote, "version %s", actual);
-
-        options_warning_safe_scan1(ms=
glevel, ',', true, &local, &remote, "local", "remote");
-
-        options_=
warning_safe_scan1(msglevel, ',', false, &remote, &local, "remote", "local"=
);
-    }
-
-    gc_free(&gc);
-}
-
-bool
-options_cmp_equal_safe(char *act=
ual, const char *expected, size_t actual_n)
-{
-    struct gc_arena gc =3D =
gc_new();
-    bool ret =3D true;
-
-    if (actual_n > 0)
-    {
-        =
actual[actual_n - 1] =3D 0;
-        if (strncmp(actual, expected, 2))
-   =
     {
-            msg(D_SHOW_OCC, "NOTE: Options consistency check may be=
 skewed by version differences");
-            options_warning_safe_ml(D_SH=
OW_OCC, actual, expected, actual_n);
-        }
-        else
-        {
- =
           ret =3D !strcmp(actual, expected);
-        }
-    }
-    gc_fre=
e(&gc);
-    return ret;
-}
-
-void
-options_warning_safe(char *actual, con=
st char *expected, size_t actual_n)
-{
-    options_warning_safe_ml(D_SHOW_=
OCC, actual, expected, actual_n);
-}
-
-const char *
-options_string_versio=
n(const char *s, struct gc_arena *gc)
-{
-    struct buffer out =3D alloc_b=
uf_gc(4, gc);
-    strncpynt((char *)BPTR(&out), s, 3);
-    return BSTR(&o=
ut);
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnos=
tic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
-char *=

-options_string_extract_option(const char *options_string, const char *opt=
_name, struct gc_arena *gc)
-{
-    char *ret =3D NULL;
-    const size_t o=
pt_name_len =3D strlen(opt_name);
-
-    const char *p =3D options_string;
=
-    while (p)
-    {
-        if (0 =3D=3D strncmp(p, opt_name, opt_name_l=
en) && strlen(p) > (opt_name_len + 1)
-            && p[opt_name_len] =3D=
=3D ' ')
-        {
-            /* option found, extract value */
-       =
     const char *start =3D &p[opt_name_len + 1];
-            const char *e=
nd =3D strchr(p, ',');
-            size_t val_len =3D end ? end - start : =
strlen(start);
-            ret =3D gc_malloc(val_len + 1, true, gc);
-    =
        memcpy(ret, start, val_len);
-            break;
-        }
-      =
  p =3D strchr(p, ',');
-        if (p)
-        {
-            p++; /* ski=
p delimiter */
-        }
-    }
-    return ret;
-}
-
-#if defined(__GNUC_=
_) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-/*
  * pars=
e/print topology coding
  */
 
diff --git a/src/openvpn/options=2Eh b/src/o=
penvpn/options=2Eh
index 85d16f9=2E=2Ed950a67 100644
--- a/src/openvpn/opti=
ons=2Eh
+++ b/src/openvpn/options=2Eh
@@ -898,33 +898,6 @@
 
 bool string_d=
efined_equal(const char *s1, const char *s2);
 
-const char *options_string=
_version(const char *s, struct gc_arena *gc);
-
-char *options_string(const=
 struct options *o, const struct frame *frame, struct tuntap *tt,
-        =
             openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc);
-
-=
bool options_cmp_equal_safe(char *actual, const char *expected, size_t actu=
al_n);
-
-void options_warning_safe(char *actual, const char *expected, siz=
e_t actual_n);
-
-bool options_cmp_equal(char *actual, const char *expected=
);
-
-void options_warning(char *actual, const char *expected);
-
-/**
- * =
Given an OpenVPN options string, extract the value of an option=2E
- *
- * =
@param options_string        Zero-terminated, comma-separated options strin=
g
- * @param opt_name              The name of the option to extract
- * @p=
aram gc                    The gc to allocate the return value
- *
- * @ret=
urn gc-allocated value of option with name opt_name if option was found,
- =
*         or NULL otherwise=2E
- */
-char *options_string_extract_option(co=
nst char *options_string, const char *opt_name,
-                          =
          struct gc_arena *gc);
-
-
 void options_postprocess(struct option=
s *options, struct env_set *es);
 
 bool options_postprocess_pull(struct op=
tions *o, struct env_set *es);
diff --git a/src/openvpn/options_string=2Ec =
b/src/openvpn/options_string=2Ec
new file mode 100644
index 0000000=2E=2E9c=
0313f
--- /dev/null
+++ b/src/openvpn/options_string=2Ec
@@ -0,0 +1,470 @@
=
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *      =
       over a single UDP port, with support for SSL/TLS-based
+ *          =
   session authentication and key exchange,
+ *             packet encrypti=
on, packet authentication, and
+ *             packet compression=2E
+ *
+ =
*  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This =
program is free software; you can redistribute it and/or modify
+ *  it und=
er the terms of the GNU General Public License version 2
+ *  as published =
by the Free Software Foundation=2E
+ *
+ *  This program is distributed in =
the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *=

+ *  You should have received a copy of the GNU General Public License alo=
ng
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include=
 "syshead=2Eh"
+
+#include "buffer=2Eh"
+#include "crypto=2Eh"
+#include "e=
rror=2Eh"
+#include "mtu=2Eh"
+#include "options=2Eh"
+#include "socket_uti=
l=2Eh"
+#include "ssl=2Eh"
+#include "ssl_ncp=2Eh"
+#include "tun=2Eh"
+
+#=
include <string=2Eh>
+
+/*
+ * Build an options string to represent data ch=
annel encryption options=2E
+ * This string must match exactly between peer=
s=2E  The keysize is checked
+ * separately by read_key()=2E
+ *
+ * The fo=
llowing options must match on both peers:
+ *
+ * Tunnel options:
+ *
+ * -=
-dev tun|tap [unit number need not match]
+ * --dev-type tun|tap
+ * --link=
-mtu
+ * --udp-mtu
+ * --tun-mtu
+ * --proto udp
+ * --proto tcp-client [ma=
tched with --proto tcp-server
+ *                     on the other end of t=
he connection]
+ * --proto tcp-server [matched with --proto tcp-client on
+=
 *                     the other end of the connection]
+ * --tun-ipv6
+ * =
--ifconfig x y [matched with --ifconfig y x on
+ *                 the othe=
r end of the connection]
+ *
+ * --comp-lzo
+ * --compress alg
+ * --fragme=
nt
+ *
+ * Crypto Options:
+ *
+ * --cipher
+ * --auth
+ * --secret
+ *
+ *=
 SSL Options:
+ *
+ * --tls-auth
+ * --tls-client [matched with --tls-serve=
r on
+ *               the other end of the connection]
+ * --tls-server [m=
atched with --tls-client on
+ *               the other end of the connecti=
on]
+ */
+char *
+options_string(const struct options *o, const struct fram=
e *frame, struct tuntap *tt,
+               openvpn_net_ctx_t *ctx, bool r=
emote, struct gc_arena *gc)
+{
+    struct buffer out =3D alloc_buf(OPTION_=
LINE_SIZE);
+    bool tt_local =3D false;
+
+    buf_printf(&out, "V4");
+
=
+    /*
+     * Tunnel Options
+     */
+
+    buf_printf(&out, ",dev-type =
%s", dev_type_string(o->dev, o->dev_type));
+    /* the link-mtu that we se=
nd has only a meaning if have a fixed
+     * cipher (p2p) or have a fallba=
ck cipher configured for older non
+     * ncp clients=2E But not sending i=
t will make even 2=2E4 complain
+     * about it being missing=2E So still =
send it=2E */
+    buf_printf(&out, ",link-mtu %u", (unsigned int)calc_opti=
ons_string_link_mtu(o, frame));
+
+    if (o->ce=2Eocc_mtu !=3D 0)
+    {
+=
        buf_printf(&out, ",tun-mtu %d", o->ce=2Eocc_mtu);
+    }
+    else
=
+    {
+        buf_printf(&out, ",tun-mtu %d", frame->tun_mtu);
+    }
+
+=
    buf_printf(&out, ",proto %s", proto_remote(o->ce=2Eproto, remote));
+
+=
    bool p2p_nopull =3D o->mode =3D=3D MODE_POINT_TO_POINT && !PULL_DEFINED=
(o);
+    /* send tun_ipv6 only in peer2peer mode - in client/server mode, =
it
+     * is usually pushed by the server, triggering a non-helpful warnin=
g
+     */
+    if (o->ifconfig_ipv6_local && p2p_nopull)
+    {
+        b=
uf_printf(&out, ",tun-ipv6");
+    }
+
+    /*
+     * Try to get ifconfig =
parameters into the options string=2E
+     * If tt is undefined, make a te=
mporary instantiation=2E
+     */
+    if (!tt)
+    {
+        tt =3D init=
_tun(o->dev, o->dev_type, o->topology, o->ifconfig_local,
+                =
      o->ifconfig_remote_netmask, o->ifconfig_ipv6_local, o->ifconfig_ipv6_=
netbits,
+                      o->ifconfig_ipv6_remote, NULL, NULL, false,=
 NULL, ctx, NULL);
+        if (tt)
+        {
+            tt_local =3D tr=
ue;
+        }
+    }
+
+    if (tt && p2p_nopull)
+    {
+        const ch=
ar *ios =3D ifconfig_options_string(tt, remote, o->ifconfig_nowarn, gc);
+ =
       if (ios && strlen(ios))
+        {
+            buf_printf(&out, ",i=
fconfig %s", ios);
+        }
+    }
+    if (tt_local)
+    {
+        fre=
e(tt);
+        tt =3D NULL;
+    }
+
+#ifdef USE_COMP
+    if (o->comp=2Ea=
lg !=3D COMP_ALG_UNDEF)
+    {
+        /* for compatibility, this simply i=
ndicates that compression
+         * context is active, not necessarily LZ=
O per-se */
+        buf_printf(&out, ",comp-lzo");
+    }
+#endif
+
+#ifde=
f ENABLE_FRAGMENT
+    if (o->ce=2Efragment)
+    {
+        buf_printf(&ou=
t, ",mtu-dynamic");
+    }
+#endif
+
+#define TLS_CLIENT (o->tls_client)
+#=
define TLS_SERVER (o->tls_server)
+
+    /*
+     * Key direction
+     */
=
+    {
+        const char *kd =3D keydirection2ascii(o->key_direction, rem=
ote, false);
+        if (kd)
+        {
+            buf_printf(&out, ",ke=
ydir %s", kd);
+        }
+    }
+
+    /*
+     * Crypto Options
+     */
=
+    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVER)
+    {
+       =
 struct key_type kt;
+
+        ASSERT((o->shared_secret_file !=3D NULL) + =
(TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) <=3D 1);
+
+        /* =
Skip resolving BF-CBC to allow SSL libraries without BF-CBC
+         * to =
work here in the default configuration */
+        const char *ciphername =
=3D o->ciphername;
+        size_t keysize =3D 0;
+
+        if (strcmp(o->=
ciphername, "BF-CBC") =3D=3D 0)
+        {
+            init_key_type(&kt, =
"none", o->authname, true, false);
+            keysize =3D 128;
+        }=

+        else
+        {
+            init_key_type(&kt, o->ciphername, o-=
>authname, true, false);
+            ciphername =3D cipher_kt_name(kt=2Eci=
pher);
+            if (cipher_defined(o->ciphername))
+            {
+    =
            keysize =3D cipher_kt_key_size(kt=2Ecipher) * 8;
+            }=

+        }
+        /* Only announce the cipher to our peer if we are will=
ing to
+         * support it */
+        if (p2p_nopull || tls_item_in_cip=
her_list(ciphername, o->ncp_ciphers))
+        {
+            buf_printf(&o=
ut, ",cipher %s", ciphername);
+        }
+        buf_printf(&out, ",auth =
%s", md_kt_name(kt=2Edigest));
+        buf_printf(&out, ",keysize %zu", ke=
ysize);
+        if (o->shared_secret_file)
+        {
+            buf_pri=
ntf(&out, ",secret");
+        }
+    }
+
+    /*
+     * SSL Options
+    =
 */
+    {
+        if (TLS_CLIENT || TLS_SERVER)
+        {
+            i=
f (o->ce=2Etls_auth_file)
+            {
+                buf_printf(&out, =
",tls-auth");
+            }
+            /* Not adding tls-crypt here, bec=
ause we won't reach this code if
+             * tls-auth/tls-crypt does no=
t match=2E  Removing tls-auth here would
+             * break stuff, so le=
aving that in place=2E */
+
+            buf_printf(&out, ",key-method %d",=
 KEY_METHOD_2);
+        }
+
+        if (remote)
+        {
+            i=
f (TLS_CLIENT)
+            {
+                buf_printf(&out, ",tls-serve=
r");
+            }
+            else if (TLS_SERVER)
+            {
+     =
           buf_printf(&out, ",tls-client");
+            }
+        }
+    =
    else
+        {
+            if (TLS_CLIENT)
+            {
+          =
      buf_printf(&out, ",tls-client");
+            }
+            else if =
(TLS_SERVER)
+            {
+                buf_printf(&out, ",tls-server"=
);
+            }
+        }
+    }
+
+#undef TLS_CLIENT
+#undef TLS_SERVER=

+
+    return BSTR(&out);
+}
+
+/*
+ * Compare option strings for equality=
=2E
+ * If the first two chars of the strings differ, it means that
+ * we =
are looking at different versions of the options string,
+ * therefore don'=
t compare them and return true=2E
+ */
+
+static const char *
+options_warn=
ing_extract_parm1(const char *option_string, struct gc_arena *gc_ret)
+{
+ =
   struct gc_arena gc =3D gc_new();
+    struct buffer b =3D string_alloc_b=
uf(option_string, &gc);
+    char *p =3D gc_malloc(OPTION_PARM_SIZE, false,=
 &gc);
+    const char *ret;
+
+    buf_parse(&b, ' ', p, OPTION_PARM_SIZE)=
;
+    ret =3D string_alloc(p, gc_ret);
+    gc_free(&gc);
+    return ret;=

+}
+
+static void
+options_warning_safe_scan2(const msglvl_t msglevel, con=
st int delim,
+                           const bool report_inconsistent, c=
onst char *p1,
+                           const struct buffer *b2_src, con=
st char *b1_name,
+                           const char *b2_name)
+{
+    =
/* We will stop sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
+=
     * OCC in a future version (because it's not useful)=2E To reduce quest=
ions
+     * when interoperating, we no longer printing a warning about it=
=2E
+     */
+    if (strprefix(p1, "key-method ") || strprefix(p1, "keydir=
 ") || strprefix(p1, "proto ")
+        || streq(p1, "tls-auth") || strpref=
ix(p1, "tun-ipv6") || strprefix(p1, "cipher "))
+    {
+        return;
+  =
  }
+
+    if (strlen(p1) > 0)
+    {
+        struct gc_arena gc =3D gc_ne=
w();
+        struct buffer b2 =3D *b2_src;
+        const char *p1_prefix =
=3D options_warning_extract_parm1(p1, &gc);
+        char *p2 =3D gc_malloc=
(OPTION_PARM_SIZE, false, &gc);
+
+        while (buf_parse(&b2, delim, p2,=
 OPTION_PARM_SIZE))
+        {
+            if (strlen(p2))
+            {
=
+                const char *p2_prefix =3D options_warning_extract_parm1(p2=
, &gc);
+
+                if (!strcmp(p1, p2))
+                {
+       =
             goto done;
+                }
+                if (!strcmp(p1_=
prefix, p2_prefix))
+                {
+                    if (report_inco=
nsistent)
+                    {
+                        msg(msglevel, "WA=
RNING: '%s' is used inconsistently, %s=3D'%s', %s=3D'%s'",
+               =
             safe_print(p1_prefix, &gc), b1_name, safe_print(p1, &gc), b2_n=
ame,
+                            safe_print(p2, &gc));
+                  =
  }
+                    goto done;
+                }
+            }
+    =
    }
+
+        msg(msglevel, "WARNING: '%s' is present in %s config but m=
issing in %s config, %s=3D'%s'",
+            safe_print(p1_prefix, &gc), b=
1_name, b2_name, b1_name, safe_print(p1, &gc));
+
+done:
+        gc_free(&=
gc);
+    }
+}
+
+static void
+options_warning_safe_scan1(const msglvl_t ms=
glevel, const int delim,
+                           const bool report_inco=
nsistent, const struct buffer *b1_src,
+                           const st=
ruct buffer *b2_src, const char *b1_name, const char *b2_name)
+{
+    stru=
ct gc_arena gc =3D gc_new();
+    struct buffer b =3D *b1_src;
+    char *p=
 =3D gc_malloc(OPTION_PARM_SIZE, true, &gc);
+
+    while (buf_parse(&b, de=
lim, p, OPTION_PARM_SIZE))
+    {
+        options_warning_safe_scan2(msgle=
vel, delim, report_inconsistent, p, b2_src, b1_name,
+                     =
              b2_name);
+    }
+
+    gc_free(&gc);
+}
+
+static void
+opti=
ons_warning_safe_ml(const msglvl_t msglevel, char *actual, const char *expe=
cted, size_t actual_n)
+{
+    struct gc_arena gc =3D gc_new();
+
+    if (=
actual_n > 0)
+    {
+        struct buffer local =3D alloc_buf_gc(OPTION_P=
ARM_SIZE + 16, &gc);
+        struct buffer remote =3D alloc_buf_gc(OPTION_=
PARM_SIZE + 16, &gc);
+        actual[actual_n - 1] =3D 0;
+
+        buf_p=
rintf(&local, "version %s", expected);
+        buf_printf(&remote, "versio=
n %s", actual);
+
+        options_warning_safe_scan1(msglevel, ',', true, =
&local, &remote, "local", "remote");
+
+        options_warning_safe_scan1(=
msglevel, ',', false, &remote, &local, "remote", "local");
+    }
+
+    gc=
_free(&gc);
+}
+
+bool
+options_cmp_equal_safe(char *actual, const char *ex=
pected, size_t actual_n)
+{
+    struct gc_arena gc =3D gc_new();
+    bool=
 ret =3D true;
+
+    if (actual_n > 0)
+    {
+        actual[actual_n - 1=
] =3D 0;
+        if (strncmp(actual, expected, 2))
+        {
+           =
 msg(D_SHOW_OCC, "NOTE: Options consistency check may be skewed by version =
differences");
+            options_warning_safe_ml(D_SHOW_OCC, actual, exp=
ected, actual_n);
+        }
+        else
+        {
+            ret =3D =
!strcmp(actual, expected);
+        }
+    }
+    gc_free(&gc);
+    return=
 ret;
+}
+
+bool
+options_cmp_equal(char *actual, const char *expected)
+{
=
+    return options_cmp_equal_safe(actual, expected, strlen(actual) + 1);
+=
}
+
+void
+options_warning_safe(char *actual, const char *expected, size_t =
actual_n)
+{
+    options_warning_safe_ml(D_SHOW_OCC, actual, expected, act=
ual_n);
+}
+
+void
+options_warning(char *actual, const char *expected)
+{
=
+    options_warning_safe(actual, expected, strlen(actual) + 1);
+}
+
+cons=
t char *
+options_string_version(const char *s, struct gc_arena *gc)
+{
+  =
  struct buffer out =3D alloc_buf_gc(4, gc);
+    strncpynt((char *)BPTR(&o=
ut), s, 3);
+    return BSTR(&out);
+}
+
+#if defined(__GNUC__) || defined(=
__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-W=
sign-compare"
+#endif
+
+char *
+options_string_extract_option(const char *=
options_string, const char *opt_name, struct gc_arena *gc)
+{
+    char *re=
t =3D NULL;
+    const size_t opt_name_len =3D strlen(opt_name);
+
+    con=
st char *p =3D options_string;
+    while (p)
+    {
+        if (0 =3D=3D =
strncmp(p, opt_name, opt_name_len) && strlen(p) > (opt_name_len + 1)
+     =
       && p[opt_name_len] =3D=3D ' ')
+        {
+            /* option fou=
nd, extract value */
+            const char *start =3D &p[opt_name_len + 1=
];
+            const char *end =3D strchr(p, ',');
+            size_t val=
_len =3D end ? end - start : strlen(start);
+            ret =3D gc_malloc(=
val_len + 1, true, gc);
+            memcpy(ret, start, val_len);
+        =
    break;
+        }
+        p =3D strchr(p, ',');
+        if (p)
+     =
   {
+            p++; /* skip delimiter */
+        }
+    }
+    return r=
et;
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnost=
ic pop
+#endif
diff --git a/src/openvpn/options_string=2Eh b/src/openvpn/op=
tions_string=2Eh
new file mode 100644
index 0000000=2E=2E49a1cac
--- /dev/n=
ull
+++ b/src/openvpn/options_string=2Eh
@@ -0,0 +1,56 @@
+/*
+ *  OpenVPN =
-- An application to securely tunnel IP networks
+ *             over a sin=
gle UDP port, with support for SSL/TLS-based
+ *             session authen=
tication and key exchange,
+ *             packet encryption, packet authen=
tication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) =
2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free s=
oftware; you can redistribute it and/or modify
+ *  it under the terms of t=
he GNU General Public License version 2
+ *  as published by the Free Softw=
are Foundation=2E
+ *
+ *  This program is distributed in the hope that it =
will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied war=
ranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See t=
he
+ *  GNU General Public License for more details=2E
+ *
+ *  You should =
have received a copy of the GNU General Public License along
+ *  with this=
 program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifnde=
f OPTIONS_SHOW_H
+#define OPTIONS_SHOW_H
+
+#include "buffer=2Eh"
+#include=
 "options=2Eh"
+
+const char *options_string_version(const char *s, struct =
gc_arena *gc);
+
+char *options_string(const struct options *o, const struc=
t frame *frame, struct tuntap *tt,
+                     openvpn_net_ctx_t =
*ctx, bool remote, struct gc_arena *gc);
+
+bool options_cmp_equal_safe(cha=
r *actual, const char *expected, size_t actual_n);
+
+void options_warning_=
safe(char *actual, const char *expected, size_t actual_n);
+
+bool options_=
cmp_equal(char *actual, const char *expected);
+
+void options_warning(char=
 *actual, const char *expected);
+
+/**
+ * Given an OpenVPN options string=
, extract the value of an option=2E
+ *
+ * @param options_string        Ze=
ro-terminated, comma-separated options string
+ * @param opt_name          =
    The name of the option to extract
+ * @param gc                    The =
gc to allocate the return value
+ *
+ * @return gc-allocated value of optio=
n with name opt_name if option was found,
+ *         or NULL otherwise=2E
=
+ */
+char *options_string_extract_option(const char *options_string, const=
 char *opt_name,
+                                    struct gc_arena *gc);=

+
+
+#endif
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 9=
cb38c6=2E=2Efa4ae7f 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -62,6 +62,7 @@
 #include "auth_token=2Eh"
 #include "mss=2Eh"
 #inc=
lude "dco=2Eh"
+#include "options_string=2Eh"
 
 #include "memdbg=2Eh"
 #in=
clude "openvpn=2Eh"

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1773?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I6824058fc9c4efd48ceeb32d4164f97b2a243d85
Gerrit-Change-Number: 1773
Gerri=
t-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>

--Gg4XHE4qAIo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">options: Factor out options_string code from options=2Ec<br><br>option=
s=2Ec is a huge, unwieldly file=2E So remove some<br>closely related code t=
hat has no direct dependencies<br>with the other functions in the file=2E<b=
r><br>This time it is the functions related to the creation<br>and testing =
of the options string=2E<br><br>Change-Id: I6824058fc9c4efd48ceeb32d4164f97=
b2a243d85<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/ope=
nvpn/init=2Ec<br>M src/openvpn/occ=2Ec<br>M src/openvpn/options=2Ec<br>M sr=
c/openvpn/options=2Eh<br>A src/openvpn/options_string=2Ec<br>A src/openvpn/=
options_string=2Eh<br>M src/openvpn/ssl=2Ec<br>9 files changed, 532 inserti=
ons(+), 458 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/1773/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index b6054d6=2E=2E3981=
bae 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMa=
keLists=2Etxt</span><br><span>@@ -520,6 +520,8 @@</span><br><span>     src/=
openvpn/options_parse=2Ec</span><br><span>     src/openvpn/options_show=2Ec=
</span><br><span>     src/openvpn/options_show=2Eh</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpn/options_string=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options_strin=
g=2Eh</span><br><span>     src/openvpn/otime=2Ec</span><br><span>     src/o=
penvpn/otime=2Eh</span><br><span>     src/openvpn/ovpn_dco_win=2Eh</span><b=
r><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam<=
/span><br><span>index 0fbd006=2E=2E9778f32 100644</span><br><span>--- a/src=
/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</spa=
n><br><span>@@ -109,6 +109,7 @@</span><br><span> 	openvpn=2Ec openvpn=2Eh \=
</span><br><span> 	options=2Ec options=2Eh \</span><br><span> 	options_show=
=2Ec options_show=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	options_string=2Ec options_string=2Eh \</span><br><span> 	options_util=
=2Ec options_util=2Eh \</span><br><span> 	options_parse=2Ec \</span><br><sp=
an> 	otime=2Ec otime=2Eh \</span><br><span>diff --git a/src/openvpn/init=2E=
c b/src/openvpn/init=2Ec</span><br><span>index 41fa557=2E=2E7c4fce8 100644<=
/span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvp=
n/init=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><br><span> #include &quo=
t;mudp=2Eh&quot;</span><br><span> #include &quot;dco=2Eh&quot;</span><br><s=
pan> #include &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;options_string=2Eh&quot;</span><br><spa=
n> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/occ=2Ec b/src/openvpn/occ=2Ec</span><b=
r><span>index aa262a8=2E=2Ef25ae19 100644</span><br><span>--- a/src/openvpn=
/occ=2Ec</span><br><span>+++ b/src/openvpn/occ=2Ec</span><br><span>@@ -29,7=
 +29,7 @@</span><br><span> #include &quot;occ=2Eh&quot;</span><br><span> #i=
nclude &quot;forward=2Eh&quot;</span><br><span> #include &quot;memdbg=2Eh&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_string=2Eh&qu=
ot;</span><br><span> </span><br><span> /*</span><br><span>  * This random s=
tring identifies an OpenVPN</span><br><span>diff --git a/src/openvpn/option=
s=2Ec b/src/openvpn/options=2Ec</span><br><span>index 8f5bc2a=2E=2E6e314a1 =
100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/=
src/openvpn/options=2Ec</span><br><span>@@ -3705,436 +3705,6 @@</span><br><=
span> }</span><br><span> </span><br><span> /*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Build an options string to represent data channe=
l encryption options=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * This string must match exactly between peers=2E  The keysize is checke=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * separately by rea=
d_key()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * The following options must =
match on both peers:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Tunnel options:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * --dev tun|tap [unit number need not mat=
ch]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --dev-type tun|=
tap</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --link-mtu</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * --udp-mtu</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * --tun-mtu</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * --proto udp</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * --proto tcp-client [matched with --proto tcp-se=
rver</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *               =
      on the other end of the connection]</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * --proto tcp-server [matched with --proto tcp-client =
on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *                 =
    the other end of the connection]</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * --tun-ipv6</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * --ifconfig x y [matched with --ifconfig y x on</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *                 the other end of the =
connection]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * --comp-lzo</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * --compress alg</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * --fragment</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * Crypto Options:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --cipher</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * --auth</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * --secret</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * SSL Options:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tls-auth</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tls-client [matched=
 with --tls-server on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *               the other end of the connection]</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * --tls-server [matched with --tls-client on</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *               the ot=
her end of the connection]</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-options_string(const struct =
options *o, const struct frame *frame, struct tuntap *tt,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-               openvpn_net_ctx_t *ctx, =
bool remote, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct buffer out =3D alloc_buf(OPTION_LINE_SIZE);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    bool tt_local =3D false;</span><br><span style=
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
tions=2Eh b/src/openvpn/options=2Eh</span><br><span>index 85d16f9=2E=2Ed950=
a67 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>++=
+ b/src/openvpn/options=2Eh</span><br><span>@@ -898,33 +898,6 @@</span><br>=
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
ew file mode 100644</span><br><span>index 0000000=2E=2E9c0313f</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpn/options_string=2Ec</spa=
n><br><span>@@ -0,0 +1,470 @@</span><br><span style=3D"color: hsl(120, 100%=
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
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Build an options s=
tring to represent data channel encryption options=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This string must match exactly between=
 peers=2E  The keysize is checked</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * separately by read_key()=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * The following options must match on both peers:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Tunnel options:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * --dev tun|tap [unit number need not match]</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * --dev-type tun|tap</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * --link-mtu</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * --udp-mtu</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * --tun-mtu</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * --proto udp</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * --proto tcp-client [matched with --proto tcp-server</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *                     on the o=
ther end of the connection]</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * --proto tcp-server [matched with --proto tcp-client on</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *                     the ot=
her end of the connection]</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * --tun-ipv6</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * --ifconfig x y [matched with --ifconfig y x on</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *                 the other end of the conn=
ection]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * --comp-lzo</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * --compress alg</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * --fragment</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Crypto Options:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* --cipher</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --auth=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --secret</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * SSL Options:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * --tls-auth</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * --tls-client [matched with --tls-server on</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *               the other end of the connect=
ion]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls-server=
 [matched with --tls-client on</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *               the other end of the connection]</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+options_string(const struct options *o, const struct frame *fra=
me, struct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+               openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer out =3D alloc_buf(O=
PTION_LINE_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool tt_local =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_prin=
tf(&amp;out, &quot;V4&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Tunnel Options<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,dev-type %s&quot;, =
dev_type_string(o-&gt;dev, o-&gt;dev_type));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* the link-mtu that we send has only a meanin=
g if have a fixed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * cipher (p2p) or have a fallback cipher configured for older non</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * ncp clients=2E But =
not sending it will make even 2=2E4 complain</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * about it being missing=2E So still send it=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_print=
f(&amp;out, &quot;,link-mtu %u&quot;, (unsigned int)calc_options_string_lin=
k_mtu(o, frame));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;ce=2Eoc=
c_mtu !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&=
amp;out, &quot;,tun-mtu %d&quot;, o-&gt;ce=2Eocc_mtu);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    buf_printf(&amp;out, &quot;,tun-mtu %d&quot;, frame-&gt;tun_mtu);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buf_printf(&amp;out, &quot;,proto %s&quot;, proto_remo=
te(o-&gt;ce=2Eproto, remote));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 p2p_nopull =3D o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !PULL_DEFI=
NED(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* send =
tun_ipv6 only in peer2peer mode - in client/server mode, it</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * is usually pushed by the ser=
ver, triggering a non-helpful warning</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (o-&gt;ifconfig_ipv6_local &amp;&amp; p2p_nopull)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,tun-ipv6&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * Try to get ifconfig parameters into the options stri=
ng=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * If tt i=
s undefined, make a temporary instantiation=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!tt)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  tt =3D init_tun(o-&gt;dev, o-&gt;dev_type, o-&gt;topology, o-&gt;ifconfig=
_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
          o-&gt;ifconfig_remote_netmask, o-&gt;ifconfig_ipv6_local, o-&gt;i=
fconfig_ipv6_netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                      o-&gt;ifconfig_ipv6_remote, NULL, NULL, false, NULL=
, ctx, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tt_local=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (tt &amp;&amp; p2p_nopull)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const char *ios =3D ifconfig_options_string(=
tt, remote, o-&gt;ifconfig_nowarn, gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (ios &amp;&amp; strlen(ios))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,ifcon=
fig %s&quot;, ios);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt_local)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        free(tt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tt =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef USE_COMP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (o-&gt;comp=2Ealg !=3D COMP_ALG_UNDEF)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* for compatibility, this simply indicates that compress=
ion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * conte=
xt is active, not necessarily LZO per-se */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,comp-lzo&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef ENABLE_FRAGMENT</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (o-&gt;ce=2Efragment)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf_printf(&amp;out, &quot;,mtu-dynamic&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define TLS_CLIENT (o-&gt;tls_client)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define TLS_SERVER (o-&gt;tls_server)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * Key direction</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *kd=
 =3D keydirection2ascii(o-&gt;key_direction, remote, false);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (kd)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,keydir %=
s&quot;, kd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * Crypto Options</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (o-&gt;shared_secret_file || TLS_CLIENT || TLS_SERVER)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct key_type kt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ASSERT((o-&gt;shared_secret_file !=3D NULL) + (=
TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) &lt;=3D 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* Skip resolving BF-CBC to allow SSL libra=
ries without BF-CBC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * to work here in the default configuration */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const char *ciphername =3D o-&g=
t;ciphername;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  size_t keysize =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (str=
cmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            init_key_type(&amp;kt, &quot;none&quot;=
, o-&gt;authname, true, false);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            keysize =3D 128;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname, true, false)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cipher=
name =3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (cipher_defined(o-&gt;ciphername))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                keysize =3D ciphe=
r_kt_key_size(kt=2Ecipher) * 8;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* Only announce the cipher to our peer if we are willing to</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * support it */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p2p_nopull ||=
 tls_item_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,cipher %=
s&quot;, ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
buf_printf(&amp;out, &quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;ou=
t, &quot;,keysize %zu&quot;, keysize);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (o-&gt;shared_secret_file)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,secret&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * SSL Options</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TLS_CLIEN=
T || TLS_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (o-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                buf_printf(&amp;out, &quot;,tls-auth&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* Not adding tls-crypt h=
ere, because we won&#39;t reach this code if</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             * tls-auth/tls-crypt does not match=
=2E  Removing tls-auth here would</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+             * break stuff, so leaving that in place=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,k=
ey-method %d&quot;, KEY_METHOD_2);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (re=
mote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (TLS_CLIE=
NT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_pr=
intf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            else if (TLS_SERVER)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                buf_printf(&amp;out, &quot;,tls-clien=
t&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (TLS_CLIENT)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &q=
uot;,tls-client&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          else if (TLS_SERVER)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                buf_printf(&amp;out, &quot;,tls-server&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#undef TLS_CLIENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
undef TLS_SERVER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;o=
ut);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Compare option strings for equality=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * If the first two chars of the strings differ=
, it means that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * w=
e are looking at different versions of the options string,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * therefore don&#39;t compare them =
and return true=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+options_warning_extract_parm1(const =
char *option_string, struct gc_arena *gc_ret)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer b =3D string_alloc_buf(option_st=
ring, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
char *p =3D gc_malloc(OPTION_PARM_SIZE, false, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *ret;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_parse(&amp;b, &#39; &#39;, p, OPTION_PARM_SIZE);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_=
alloc(p, gc_ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+options_warning_safe_scan2(const msglvl_t msgleve=
l, const int delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                           const bool report_inconsistent, const char *p1,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       const struct buffer *b2_src, const char *b1_name,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                           const char =
*b2_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* We will stop sending =
&#39;key-method&#39;, &#39;keydir&#39;, &#39;proto&#39; and &#39;tls-auth&#=
39; in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * OCC in=
 a future version (because it&#39;s not useful)=2E To reduce questions</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * when interoperati=
ng, we no longer printing a warning about it=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (strprefix(p1, &quot;key-method &quot;) || strprefix=
(p1, &quot;keydir &quot;) || strprefix(p1, &quot;proto &quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        || streq(p1, &quot;tls-a=
uth&quot;) || strprefix(p1, &quot;tun-ipv6&quot;) || strprefix(p1, &quot;ci=
pher &quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (strlen(p1) &gt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer b2 =3D *b2_src;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *p1_=
prefix =3D options_warning_extract_parm1(p1, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        char *p2 =3D gc_malloc(OPTION_PA=
RM_SIZE, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        while=
 (buf_parse(&amp;b2, delim, p2, OPTION_PARM_SIZE))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (strlen(p2))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                const char *p2_prefix =3D options_wa=
rning_extract_parm1(p2, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           if (!strcmp(p1, p2))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    goto done;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                if (!strcmp(p1_prefix, p2_prefix))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    if (rep=
ort_inconsistent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        msg(msglevel, &quot;WARNING: &#39;%s&#39; is used i=
nconsistently, %s=3D&#39;%s&#39;, %s=3D&#39;%s&#39;&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                            safe_pri=
nt(p1_prefix, &amp;gc), b1_name, safe_print(p1, &amp;gc), b2_name,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
safe_print(p2, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    goto done;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglev=
el, &quot;WARNING: &#39;%s&#39; is present in %s config but missing in %s c=
onfig, %s=3D&#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            safe_print(p1_prefix, &amp;gc), b1_name, b2_name, b=
1_name, safe_print(p1, &amp;gc));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+options_warning_safe_scan1(const msglvl_t msglevel, const int delim,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
    const bool report_inconsistent, const struct buffer *b1_src,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                           con=
st struct buffer *b2_src, const char *b1_name, const char *b2_name)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b =3D *b1_=
src;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *p =3D=
 gc_malloc(OPTION_PARM_SIZE, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    while (buf_parse(&amp;b, delim, p, OPTION_PARM_SIZE))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        options_warning_safe_scan2(msglevel, =
delim, report_inconsistent, p, b2_src, b1_name,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                   b2_name);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+options_warning_safe_ml=
(const msglvl_t msglevel, char *actual, const char *expected, size_t actual=
_n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (actual_n &gt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct buffer local =3D alloc_buf_gc(=
OPTION_PARM_SIZE + 16, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct buffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE=
 + 16, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     actual[actual_n - 1] =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  buf_printf(&amp;local, &quot;version %s&quot;, expected);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;remote, &qu=
ot;version %s&quot;, actual);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ptions_warning_safe_scan1(msglevel, &#39;,&#39;, true, &amp;local, &amp;rem=
ote, &quot;local&quot;, &quot;remote&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        options_warning_safe_scan1(msglevel, &#39;,&#39;, false, &amp=
;remote, &amp;local, &quot;remote&quot;, &quot;local&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+options_cmp_equal_safe(char *actual, cons=
t char *expected, size_t actual_n)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    bool ret =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (actual_n &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        act=
ual[actual_n - 1] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (strncmp(actual, expected, 2))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(D_SHOW_OCC, &quot;NOTE: Options consistenc=
y check may be skewed by version differences&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            options_warning_safe_ml(D_SHO=
W_OCC, actual, expected, actual_n);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 ret =3D !strcmp(actual, expected);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+options_cmp_equal(char *actual, const char *expected)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return options_cmp_equal_safe(actual, expe=
cted, strlen(actual) + 1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+options_warning_safe(char *actual, const char=
 *expected, size_t actual_n)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    optio=
ns_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_warn=
ing(char *actual, const char *expected)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    options_warning_safe(actual, expected, strlen(actual) + 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+options_string_version(const char *s, struct gc_arena *gc)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer out =3D alloc_buf_gc(4, gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    strncpynt((char *)BPT=
R(&amp;out), s, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return BSTR(&amp;out);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+optio=
ns_string_extract_option(const char *options_string, const char *opt_name, =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const siz=
e_t opt_name_len =3D strlen(opt_name);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *p =3D options_string;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    while (p)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (0 =3D=3D strncmp(p, opt_name, opt_name_len) &amp;&amp; strlen(p) =
&gt; (opt_name_len + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &amp;&amp; p[opt_name_len] =3D=3D &#39; &#39;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* option found, extract valu=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
st char *start =3D &amp;p[opt_name_len + 1];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            const char *end =3D strchr(p, &#39;,&#=
39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            si=
ze_t val_len =3D end ? end - start : strlen(start);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ret =3D gc_malloc(val_len + 1=
, true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     memcpy(ret, start, val_len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        p =3D strchr(p, &#39;,&#39;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (p)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            p++; /* skip delimiter */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span>diff --git a/src/openvpn/options_string=2Eh b/src/openvpn/opti=
ons_string=2Eh</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E49a1cac</span><br><span>--- /dev/null</span><br><span>+++ b/src=
/openvpn/options_string=2Eh</span><br><span>@@ -0,0 +1,56 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP=
 networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     over a single UDP port, with support for SSL/TLS-based</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticati=
on and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             packet encryption, packet authentication, and</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms o=
f the GNU General Public License version 2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in th=
e hope that it will be useful,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty =
of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more deta=
ils=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPTIONS_SHOW_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPTIONS_SHOW_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+const char *options_string_vers=
ion(const char *s, struct gc_arena *gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+char *options_string(const struct options *o, const struct frame *frame, =
struct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool options_cmp_equal_safe(char *a=
ctual, const char *expected, size_t actual_n);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void options_warning_safe(char *actual, const char *expected, size_=
t actual_n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool options_cmp_equal(cha=
r *actual, const char *expected);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
options_warning(char *actual, const char *expected);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Given an OpenVPN options string, extract the value of an option=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param options_string        Zero-term=
inated, comma-separated options string</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param opt_name              The name of the option t=
o extract</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
gc                    The gc to allocate the return value</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return gc-allocated value of option with name opt_=
name if option was found,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *         or NULL otherwise=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+char *options_string_extract_option(const char *options_string, const cha=
r *opt_name,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                             struct gc_arena *gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</spa=
n><br><span>index 9cb38c6=2E=2Efa4ae7f 100644</span><br><span>--- a/src/ope=
nvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -=
62,6 +62,7 @@</span><br><span> #include &quot;auth_token=2Eh&quot;</span><b=
r><span> #include &quot;mss=2Eh&quot;</span><br><span> #include &quot;dco=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;options_string=2Eh&quot;</span><br><span> </span><br><span> #include =
&quot;memdbg=2Eh&quot;</span><br><span> #include &quot;openvpn=2Eh&quot;</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">change 1773</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6824058fc9c4efd48ce=
eb32d4164f97b2a243d85 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1773 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--Gg4XHE4qAIo=--


--===============1489103106318894798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1489103106318894798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1489103106318894798==--

