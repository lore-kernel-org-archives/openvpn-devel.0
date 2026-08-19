Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC85AC5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DtsvJ+tfKobx0VKUmvEFVPjyAKk7oW2pihdpBmji4hI=; b=Crjk9RCvoWfHgjOiJXwxPhS7RK
	iS792GA6CMyPvLSoXmMGB6EzsHY4H5s1uJBe+C5lupV8Jrxmh/IzXWtz9LmYAG1ZOTMtX4m17fV/s
	/7WGij+U4nZokwuNtVJDj6gYmYQz44JRQllVCZQYTB6ZlFgamIU0WFbLtgBPcATS3kjI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiWC-0003zf-Ao;
	Wed, 19 Aug 2026 15:47:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiW9-0003zO-KE
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Dn6GrczCnDJPLN6MtfWtB//cg/70ZwNDLclVNnuFLVY=; b=YT2GXyWGrfj20MKCJAhIgqUNCS
 QRcDNd/srV8RXt8TR/1B2Pm1j9Zf69QLVwXqH2poTNjn79IDBCtoK5MFVmXWCE0KkrzsAFZ0qeT0E
 CrZSDy0ispqoJwEje0woE1vMHBoupVjy71EFP9uhmIa3kqfBrEmyaP9FRizA7sV0nalw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dn6GrczCnDJPLN6MtfWtB//cg/70ZwNDLclVNnuFLVY=; b=Q
 8cJejAyCBxqTNw/J+ImoXhbmMfhbNTHA+Ts4NS6yMzQA+XCQMJeB4wBKKCc4unTIevHUKw1NI9+IN
 IwBfdLY6CoiOM+LRPZkJDyiq/p4L5cQGYD3+Gn5NqxeagXok3PesGsAHjqBULN+F+Bi4qtRAQGaua
 6iUGIqpsS0gzItWk=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiVj-0008CA-97 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:47:32 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f84023916so1102241f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787154441; x=1787759241; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dn6GrczCnDJPLN6MtfWtB//cg/70ZwNDLclVNnuFLVY=;
 b=bILW3PobwcTBXUjul2BrvD39BueZExy3XA43X04PxbEumUVFLtlS1EPDSCMeNFIK91
 b2/AetZPmQnNAu6judOTus2nGnX3Juf1o5HR+NeY6Z+WWG0iv4vd0U9pIqJvYDeDXY7J
 iNBhlz5w9uk4DinLmkp9FgVLt6rHu2lnniubQuvYITDkSI23wuZ84tWtn+jUT9hxAs47
 nXXTrskaeLrcUSzhdO2OY9USYZdCJunqpNpLFLqarVbZLZ4TXfhcv+U9/xC2YKIpk54y
 QGhpYpT3iH5FxCpaPJur2cFD9t+qCRMp2tl1HUYBgZq6IOXT+TFtnVlI/kJ6r6FEkl2+
 Ljbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154441; x=1787759241;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dn6GrczCnDJPLN6MtfWtB//cg/70ZwNDLclVNnuFLVY=;
 b=TmJf0wghJhe0xuxqhzVbu8yXRigpDmktm5RD2SKyJG+lXVo/PX9MtYH6aXaKaiCron
 r8a/6bYQM3R6m6kjLUrV+WNEX/EboGSPjErV1Fnzm0esgHuRr3tyX0rKxlQQHz613daB
 rcu8xmcndSrYNLSlTobXvYzOG6SKHLmOkkD/wr3vUR7YfSw0E/wo1qM7nAPJYd6azGqD
 RcxvipNYEhA6vMhdk4J4M5gyGHoCHAGzpBRheO8hN+5uoIOxtsTEda2MKdkAt6Rj0d1w
 OS194Vphc1OoooZ1MYbsaIn7dgftlEVIuX+dDsXVc1y0ogeMHrTmeqkx4Ft+EdFgooo+
 dTVg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4fznfWCbBHJ23OyujxkiuGmUDp6VIp7+myCOvFrHvRlogyqzd+9P8DM9E5OUwcWPgZOlGaDdYuyH1LngU@lists.sourceforge.net
X-Gm-Message-State: AFuF++lPcRPyG8NjcGiSStXDRK5BDi7gMOzOd0KMcvWxUdYhigZVG1LW
 tZ6PLyFGFwkW/VYC019cmQZD3LRPlOTHlEcBuWlul9O6A7pFzG7qO9MLEYqhGD28Se4j4j9FobY
 y0AIQ2as1dsi4Y1QMxV3ShXG3c1TFUT/ofiTC6iugUtYS2X4Yvc/OJ4tyMSBDOm6CW1cvofhioN
 /wrnyLeg==
X-Gm-Gg: AR+sD12ZtDxoUkZJcXKJQNwuf0LihrfNwwSZiP+vZJlkP2JuXa+t8mCGyXqk2PgKSHI
 x2xnSgikwr5qHc0z1ypXw8WqJ0G53v15oHh4rocaR+A69BHf+vZ9BpBgKIMHKRtYE61tB2VLtPK
 LzGOBtTfvA9MmkZw2g3CHY7Y0x3DF2P53qXh+CNIJ0knSEMwEseHZ0HRTp+z7DEjtN60u2nEKmd
 JVi4JcuaeXEesZAG6Rtn+9v2yfBrYYyDMhMQnnG7c+x0VPq5SfGt9q2U59QWvR8hVmoyaENYOKd
 NWbMiBRiSlg7kZDu0/UpX422Pc0YDCyVVG4tXBCp04KpnSYIeNveXos1qh29Y3NT4QETyq/q/Rv
 +VtSSJvwrfmnRguA1dFbaM+B3fS1jPI/fUYqHzvF+OMj1nC5l8wIFRSbRMW8hBb3Eh25hBqck4J
 CrFyoYUJNDiUReeIYANGJdM6iD/Lokl3IcUQMMM43VSgZl/XkyziU21dfEkXIUD+xLhM+feG0rw
 jvAfgMdvnAZgaJjvng3rPQm+1rjGQd0DoSBp645XzLJo4UjhCZMOTe/ZHf7wrTHCS2uNkq4lk5x
 0rXnMb+J3uImQLFOAJHbzrGEbznVFFvgw3kRcirjupLzO+M8Fa8=
X-Received: by 2002:a05:600c:3553:b0:499:8156:cd3f with SMTP id
 5b1f17b1804b1-499aa1b0350mr88249785e9.8.1787153955976; 
 Wed, 19 Aug 2026 08:39:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa11fd3asm62638085e9.8.2026.08.19.08.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:39:15 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:39:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: 76db269d466ea06988a46af08705dbbf7f7f3d4b
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ffff3ef38fbd2068d1ca1b81d29bd3fa2bec8cd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiVj-0008CA-97
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
Content-Type: multipart/mixed; boundary="===============0972363233414395954=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0972363233414395954==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="erHvOmIGs9A="; charset=UTF-8

--erHvOmIGs9A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail

to look at the new patch=
 set (#5)=2E


Change subject: options: Factor out options_string code from=
 options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


options: Factor out options_string code from options=2Ec

options=2Ec is =
a huge, unwieldly file=2E So remove some
closely related code that has no d=
irect dependencies
with the other functions in the file=2E

This time it is=
 the functions related to the creation
and testing of the options string=2E=


Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
Signed-off-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
---
M CMakeLists=2Etxt
M src/openvpn=
/Makefile=2Eam
M src/openvpn/init=2Ec
M src/openvpn/occ=2Ec
M src/openvpn/o=
ptions=2Ec
M src/openvpn/options=2Eh
A src/openvpn/options_string=2Ec
A src=
/openvpn/options_string=2Eh
M src/openvpn/ssl=2Ec
9 files changed, 532 inse=
rtions(+), 458 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/73/1773/5

diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt
index 9af7870=2E=2E4375090 100644
--- a/CMakeLists=2Etxt
+++ b/CMake=
Lists=2Etxt
@@ -531,6 +531,8 @@
     src/openvpn/options_parse=2Ec
     src=
/openvpn/options_show=2Ec
     src/openvpn/options_show=2Eh
+    src/openvp=
n/options_string=2Ec
+    src/openvpn/options_string=2Eh
     src/openvpn/o=
time=2Ec
     src/openvpn/otime=2Eh
     src/openvpn/ovpn_dco_win=2Eh
diff =
--git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 4220d07=
=2E=2Ed607f80 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Make=
file=2Eam
@@ -109,6 +109,7 @@
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec opt=
ions=2Eh \
 	options_show=2Ec options_show=2Eh \
+	options_string=2Ec optio=
ns_string=2Eh \
 	options_util=2Ec options_util=2Eh \
 	options_parse=2Ec \=

 	otime=2Ec otime=2Eh \
diff --git a/src/openvpn/init=2Ec b/src/openvpn/in=
it=2Ec
index a90fe69=2E=2Efa62cdd 100644
--- a/src/openvpn/init=2Ec
+++ b/s=
rc/openvpn/init=2Ec
@@ -54,6 +54,7 @@
 #include "dco=2Eh"
 #include "tun_af=
unix=2Eh"
 #include "schedule=2Eh"
+#include "options_string=2Eh"
 
 #inclu=
de "memdbg=2Eh"
 
diff --git a/src/openvpn/occ=2Ec b/src/openvpn/occ=2Ec
in=
dex aa262a8=2E=2Ef25ae19 100644
--- a/src/openvpn/occ=2Ec
+++ b/src/openvpn=
/occ=2Ec
@@ -29,7 +29,7 @@
 #include "occ=2Eh"
 #include "forward=2Eh"
 #in=
clude "memdbg=2Eh"
-
+#include "options_string=2Eh"
 
 /*
  * This random s=
tring identifies an OpenVPN
diff --git a/src/openvpn/options=2Ec b/src/open=
vpn/options=2Ec
index e899fa6=2E=2Ef5163d6 100644
--- a/src/openvpn/options=
=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3697,436 +3697,6 @@
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
ex 0000000=2E=2Ed3b29b8
--- /dev/null
+++ b/src/openvpn/options_string=2Ec
=
@@ -0,0 +1,429 @@
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
+char *
+options_string(const stru=
ct options *o, const struct frame *frame, struct tuntap *tt,
+             =
  openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc)
+{
+    struct =
buffer out =3D alloc_buf(OPTION_LINE_SIZE);
+    bool tt_local =3D false;
+=

+    buf_printf(&out, "V4");
+
+    /*
+     * Tunnel Options
+     */
+
+=
    buf_printf(&out, ",dev-type %s", dev_type_string(o->dev, o->dev_type));=

+    /* the link-mtu that we send has only a meaning if have a fixed
+    =
 * cipher (p2p) or have a fallback cipher configured for older non
+     * =
ncp clients=2E But not sending it will make even 2=2E4 complain
+     * abo=
ut it being missing=2E So still send it=2E */
+    buf_printf(&out, ",link-=
mtu %u", (unsigned int)calc_options_string_link_mtu(o, frame));
+
+    if (=
o->ce=2Eocc_mtu !=3D 0)
+    {
+        buf_printf(&out, ",tun-mtu %d", o->=
ce=2Eocc_mtu);
+    }
+    else
+    {
+        buf_printf(&out, ",tun-mtu =
%d", frame->tun_mtu);
+    }
+
+    buf_printf(&out, ",proto %s", proto_rem=
ote(o->ce=2Eproto, remote));
+
+    bool p2p_nopull =3D o->mode =3D=3D MODE=
_POINT_TO_POINT && !PULL_DEFINED(o);
+    /* send tun_ipv6 only in peer2pee=
r mode - in client/server mode, it
+     * is usually pushed by the server,=
 triggering a non-helpful warning
+     */
+    if (o->ifconfig_ipv6_local =
&& p2p_nopull)
+    {
+        buf_printf(&out, ",tun-ipv6");
+    }
+
+   =
 /*
+     * Try to get ifconfig parameters into the options string=2E
+    =
 * If tt is undefined, make a temporary instantiation=2E
+     */
+    if (=
!tt)
+    {
+        tt =3D init_tun(o->dev, o->dev_type, o->topology, o->i=
fconfig_local,
+                      o->ifconfig_remote_netmask, o->ifconf=
ig_ipv6_local, o->ifconfig_ipv6_netbits,
+                      o->ifconfig=
_ipv6_remote, NULL, NULL, false, NULL, ctx, NULL);
+        if (tt)
+      =
  {
+            tt_local =3D true;
+        }
+    }
+
+    if (tt && p2p_=
nopull)
+    {
+        const char *ios =3D ifconfig_options_string(tt, rem=
ote, o->ifconfig_nowarn, gc);
+        if (ios && strlen(ios))
+        {
+=
            buf_printf(&out, ",ifconfig %s", ios);
+        }
+    }
+    i=
f (tt_local)
+    {
+        free(tt);
+        tt =3D NULL;
+    }
+
+#ifd=
ef USE_COMP
+    if (o->comp=2Ealg !=3D COMP_ALG_UNDEF)
+    {
+        /* =
for compatibility, this simply indicates that compression
+         * conte=
xt is active, not necessarily LZO per-se */
+        buf_printf(&out, ",com=
p-lzo");
+    }
+#endif
+
+#ifdef ENABLE_FRAGMENT
+    if (o->ce=2Efragment=
)
+    {
+        buf_printf(&out, ",mtu-dynamic");
+    }
+#endif
+
+#defi=
ne TLS_CLIENT (o->tls_client)
+#define TLS_SERVER (o->tls_server)
+
+    /*=

+     * Key direction
+     */
+    {
+        const char *kd =3D keydirec=
tion2ascii(o->key_direction, remote, false);
+        if (kd)
+        {
+ =
           buf_printf(&out, ",keydir %s", kd);
+        }
+    }
+
+    /*
=
+     * Crypto Options
+     */
+    if (o->shared_secret_file || TLS_CLIEN=
T || TLS_SERVER)
+    {
+        struct key_type kt;
+
+        ASSERT((o->=
shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=
=3D true) <=3D 1);
+
+        /* Skip resolving BF-CBC to allow SSL librari=
es without BF-CBC
+         * to work here in the default configuration */
=
+        const char *ciphername =3D o->ciphername;
+        size_t keysize =
=3D 0;
+
+        if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
+        {
=
+            init_key_type(&kt, "none", o->authname, true, false);
+       =
     keysize =3D 128;
+        }
+        else
+        {
+            init=
_key_type(&kt, o->ciphername, o->authname, true, false);
+            ciphe=
rname =3D cipher_kt_name(kt=2Ecipher);
+            if (cipher_defined(o->c=
iphername))
+            {
+                keysize =3D cipher_kt_key_size(=
kt=2Ecipher) * 8;
+            }
+        }
+        /* Only announce the c=
ipher to our peer if we are willing to
+         * support it */
+        i=
f (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
+    =
    {
+            buf_printf(&out, ",cipher %s", ciphername);
+        }
+=
        buf_printf(&out, ",auth %s", md_kt_name(kt=2Edigest));
+        buf=
_printf(&out, ",keysize %zu", keysize);
+        if (o->shared_secret_file)=

+        {
+            buf_printf(&out, ",secret");
+        }
+    }
+
+=
    /*
+     * SSL Options
+     */
+    {
+        if (TLS_CLIENT || TLS_S=
ERVER)
+        {
+            if (o->ce=2Etls_auth_file)
+            {
+ =
               buf_printf(&out, ",tls-auth");
+            }
+            /=
* Not adding tls-crypt here, because we won't reach this code if
+         =
    * tls-auth/tls-crypt does not match=2E  Removing tls-auth here would
+ =
            * break stuff, so leaving that in place=2E */
+
+            bu=
f_printf(&out, ",key-method %d", KEY_METHOD_2);
+        }
+
+        if (r=
emote)
+        {
+            if (TLS_CLIENT)
+            {
+            =
    buf_printf(&out, ",tls-server");
+            }
+            else if (T=
LS_SERVER)
+            {
+                buf_printf(&out, ",tls-client");=

+            }
+        }
+        else
+        {
+            if (TLS_CL=
IENT)
+            {
+                buf_printf(&out, ",tls-client");
+   =
         }
+            else if (TLS_SERVER)
+            {
+              =
  buf_printf(&out, ",tls-server");
+            }
+        }
+    }
+
+#und=
ef TLS_CLIENT
+#undef TLS_SERVER
+
+    return BSTR(&out);
+}
+
+/**
+ * Co=
mpare option strings for equality=2E
+ *
+ * If the first two chars of the =
strings differ, it means that
+ * we are looking at different versions of t=
he options string,
+ * therefore don't compare them and return true=2E
+ */=

+static const char *
+options_warning_extract_parm1(const char *option_str=
ing, struct gc_arena *gc_ret)
+{
+    struct gc_arena gc =3D gc_new();
+   =
 struct buffer b =3D string_alloc_buf(option_string, &gc);
+    char *p =3D=
 gc_malloc(OPTION_PARM_SIZE, false, &gc);
+    const char *ret;
+
+    buf_=
parse(&b, ' ', p, OPTION_PARM_SIZE);
+    ret =3D string_alloc(p, gc_ret);
=
+    gc_free(&gc);
+    return ret;
+}
+
+static void
+options_warning_safe=
_scan2(const msglvl_t msglevel, const int delim,
+                         =
  const bool report_inconsistent, const char *p1,
+                        =
   const struct buffer *b2_src, const char *b1_name,
+                     =
      const char *b2_name)
+{
+    /* We will stop sending 'key-method', 'k=
eydir', 'proto' and 'tls-auth' in
+     * OCC in a future version (because =
it's not useful)=2E To reduce questions
+     * when interoperating, we no =
longer printing a warning about it=2E
+     */
+    if (strprefix(p1, "key-=
method ") || strprefix(p1, "keydir ") || strprefix(p1, "proto ")
+        |=
| streq(p1, "tls-auth") || strprefix(p1, "tun-ipv6") || strprefix(p1, "ciph=
er "))
+    {
+        return;
+    }
+
+    if (strlen(p1) > 0)
+    {
+  =
      struct gc_arena gc =3D gc_new();
+        struct buffer b2 =3D *b2_sr=
c;
+        const char *p1_prefix =3D options_warning_extract_parm1(p1, &gc=
);
+        char *p2 =3D gc_malloc(OPTION_PARM_SIZE, false, &gc);
+
+      =
  while (buf_parse(&b2, delim, p2, OPTION_PARM_SIZE))
+        {
+         =
   if (strlen(p2))
+            {
+                const char *p2_prefix =
=3D options_warning_extract_parm1(p2, &gc);
+
+                if (!strcmp(=
p1, p2))
+                {
+                    goto done;
+              =
  }
+                if (!strcmp(p1_prefix, p2_prefix))
+                {
=
+                    if (report_inconsistent)
+                    {
+     =
                   msg(msglevel, "WARNING: '%s' is used inconsistently, %s=
=3D'%s', %s=3D'%s'",
+                            safe_print(p1_prefix, &gc=
), b1_name, safe_print(p1, &gc), b2_name,
+                            safe=
_print(p2, &gc));
+                    }
+                    goto done;
+ =
               }
+            }
+        }
+
+        msg(msglevel, "WARNIN=
G: '%s' is present in %s config but missing in %s config, %s=3D'%s'",
+    =
        safe_print(p1_prefix, &gc), b1_name, b2_name, b1_name, safe_print(p=
1, &gc));
+
+done:
+        gc_free(&gc);
+    }
+}
+
+static void
+options=
_warning_safe_scan1(const msglvl_t msglevel, const int delim,
+            =
               const bool report_inconsistent, const struct buffer *b1_src,=

+                           const struct buffer *b2_src, const char *b1_na=
me, const char *b2_name)
+{
+    struct gc_arena gc =3D gc_new();
+    stru=
ct buffer b =3D *b1_src;
+    char *p =3D gc_malloc(OPTION_PARM_SIZE, true,=
 &gc);
+
+    while (buf_parse(&b, delim, p, OPTION_PARM_SIZE))
+    {
+   =
     options_warning_safe_scan2(msglevel, delim, report_inconsistent, p, b2=
_src, b1_name,
+                                   b2_name);
+    }
+
+    =
gc_free(&gc);
+}
+
+static void
+options_warning_safe_ml(const msglvl_t msg=
level, char *actual, const char *expected, size_t actual_n)
+{
+    struct =
gc_arena gc =3D gc_new();
+
+    if (actual_n > 0)
+    {
+        struct b=
uffer local =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
+        struct b=
uffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
+        actual[=
actual_n - 1] =3D 0;
+
+        buf_printf(&local, "version %s", expected);=

+        buf_printf(&remote, "version %s", actual);
+
+        options_war=
ning_safe_scan1(msglevel, ',', true, &local, &remote, "local", "remote");
+=

+        options_warning_safe_scan1(msglevel, ',', false, &remote, &local,=
 "remote", "local");
+    }
+
+    gc_free(&gc);
+}
+
+bool
+options_cmp_eq=
ual_safe(char *actual, const char *expected, size_t actual_n)
+{
+    struc=
t gc_arena gc =3D gc_new();
+    bool ret =3D true;
+
+    if (actual_n > 0=
)
+    {
+        actual[actual_n - 1] =3D 0;
+        if (strncmp(actual, =
expected, 2))
+        {
+            msg(D_SHOW_OCC, "NOTE: Options consis=
tency check may be skewed by version differences");
+            options_wa=
rning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
+        }
+        =
else
+        {
+            ret =3D !strcmp(actual, expected);
+        }
=
+    }
+    gc_free(&gc);
+    return ret;
+}
+
+bool
+options_cmp_equal(ch=
ar *actual, const char *expected)
+{
+    return options_cmp_equal_safe(act=
ual, expected, strlen(actual) + 1);
+}
+
+void
+options_warning_safe(char *=
actual, const char *expected, size_t actual_n)
+{
+    options_warning_safe=
_ml(D_SHOW_OCC, actual, expected, actual_n);
+}
+
+void
+options_warning(ch=
ar *actual, const char *expected)
+{
+    options_warning_safe(actual, expe=
cted, strlen(actual) + 1);
+}
+
+const char *
+options_string_version(const=
 char *s, struct gc_arena *gc)
+{
+    struct buffer out =3D alloc_buf_gc(4=
, gc);
+    strncpynt((char *)BPTR(&out), s, 3);
+    return BSTR(&out);
+}=

+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pus=
h
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
+char *
+optio=
ns_string_extract_option(const char *options_string, const char *opt_name, =
struct gc_arena *gc)
+{
+    char *ret =3D NULL;
+    const size_t opt_name=
_len =3D strlen(opt_name);
+
+    const char *p =3D options_string;
+    wh=
ile (p)
+    {
+        if (0 =3D=3D strncmp(p, opt_name, opt_name_len) && =
strlen(p) > (opt_name_len + 1)
+            && p[opt_name_len] =3D=3D ' ')
=
+        {
+            /* option found, extract value */
+            cons=
t char *start =3D &p[opt_name_len + 1];
+            const char *end =3D st=
rchr(p, ',');
+            size_t val_len =3D end ? end - start : strlen(st=
art);
+            ret =3D gc_malloc(val_len + 1, true, gc);
+            m=
emcpy(ret, start, val_len);
+            break;
+        }
+        p =3D s=
trchr(p, ',');
+        if (p)
+        {
+            p++; /* skip delimit=
er */
+        }
+    }
+    return ret;
+}
+
+#if defined(__GNUC__) || def=
ined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvp=
n/options_string=2Eh b/src/openvpn/options_string=2Eh
new file mode 100644
=
index 0000000=2E=2E02efed3
--- /dev/null
+++ b/src/openvpn/options_string=
=2Eh
@@ -0,0 +1,97 @@
+/*
+ *  OpenVPN -- An application to securely tunnel=
 IP networks
+ *             over a single UDP port, with support for SSL/T=
LS-based
+ *             session authentication and key exchange,
+ *      =
       packet encryption, packet authentication, and
+ *             packet=
 compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=
=2Enet>
+ *
+ *  This program is free software; you can redistribute it and=
/or modify
+ *  it under the terms of the GNU General Public License versio=
n 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This prog=
ram is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License f=
or more details=2E
+ *
+ *  You should have received a copy of the GNU Gene=
ral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef OPTIONS_STRING_H
+#define OPTION=
S_STRING_H
+
+#include "buffer=2Eh"
+#include "options=2Eh"
+
+const char *=
options_string_version(const char *s, struct gc_arena *gc);
+
+/**
+ * Buil=
d an options string to represent data channel encryption options=2E
+ * Thi=
s string must match exactly between peers=2E  The keysize is checked
+ * se=
parately by read_key()=2E
+ *
+ * The following options must match on both =
peers:
+ *
+ * Tunnel options:
+ *
+ * --dev tun|tap [unit number need not =
match]
+ * --dev-type tun|tap
+ * --link-mtu
+ * --udp-mtu
+ * --tun-mtu
+ =
* --proto udp
+ * --proto tcp-client [matched with --proto tcp-server
+ *  =
                   on the other end of the connection]
+ * --proto tcp-serv=
er [matched with --proto tcp-client on
+ *                     the other en=
d of the connection]
+ * --tun-ipv6
+ * --ifconfig x y [matched with --ifco=
nfig y x on
+ *                 the other end of the connection]
+ *
+ * --=
comp-lzo
+ * --compress alg
+ * --fragment
+ *
+ * Crypto Options:
+ *
+ * =
--cipher
+ * --auth
+ * --secret
+ *
+ * SSL Options:
+ *
+ * --tls-auth
+ =
* --tls-client [matched with --tls-server on
+ *               the other en=
d of the connection]
+ * --tls-server [matched with --tls-client on
+ *    =
           the other end of the connection]
+ */
+char *options_string(cons=
t struct options *o, const struct frame *frame, struct tuntap *tt,
+       =
              openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc);
+
=
+bool options_cmp_equal_safe(char *actual, const char *expected, size_t act=
ual_n);
+
+void options_warning_safe(char *actual, const char *expected, si=
ze_t actual_n);
+
+bool options_cmp_equal(char *actual, const char *expecte=
d);
+
+void options_warning(char *actual, const char *expected);
+
+/**
+ *=
 Given an OpenVPN options string, extract the value of an option=2E
+ *
+ *=
 @param options_string        Zero-terminated, comma-separated options stri=
ng
+ * @param opt_name              The name of the option to extract
+ * @=
param gc                    The gc to allocate the return value
+ *
+ * @re=
turn gc-allocated value of option with name opt_name if option was found,
+=
 *         or NULL otherwise=2E
+ */
+char *options_string_extract_option(c=
onst char *options_string, const char *opt_name,
+                         =
           struct gc_arena *gc);
+
+
+#endif
diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index 01e45fd=2E=2Ed5bd602 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -62,6 +62,7 @@
 #include "auth_tok=
en=2Eh"
 #include "mss=2Eh"
 #include "dco=2Eh"
+#include "options_string=
=2Eh"
 
 #include "memdbg=2Eh"
 #include "openvpn=2Eh"

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a24=
3d85
Gerrit-Change-Number: 1773
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>

--erHvOmIGs9A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">options: Factor out options_string code from options=2Ec<br><br=
>options=2Ec is a huge, unwieldly file=2E So remove some<br>closely related=
 code that has no direct dependencies<br>with the other functions in the fi=
le=2E<br><br>This time it is the functions related to the creation<br>and t=
esting of the options string=2E<br><br>Change-Id: I6824058fc9c4efd48ceeb32d=
4164f97b2a243d85<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M=
 src/openvpn/init=2Ec<br>M src/openvpn/occ=2Ec<br>M src/openvpn/options=2Ec=
<br>M src/openvpn/options=2Eh<br>A src/openvpn/options_string=2Ec<br>A src/=
openvpn/options_string=2Eh<br>M src/openvpn/ssl=2Ec<br>9 files changed, 532=
 insertions(+), 458 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/1773/5</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 9af7870=
=2E=2E4375090 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span=
>+++ b/CMakeLists=2Etxt</span><br><span>@@ -531,6 +531,8 @@</span><br><span=
>     src/openvpn/options_parse=2Ec</span><br><span>     src/openvpn/option=
s_show=2Ec</span><br><span>     src/openvpn/options_show=2Eh</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options_string=2Ec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/opt=
ions_string=2Eh</span><br><span>     src/openvpn/otime=2Ec</span><br><span>=
     src/openvpn/otime=2Eh</span><br><span>     src/openvpn/ovpn_dco_win=2E=
h</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Make=
file=2Eam</span><br><span>index 4220d07=2E=2Ed607f80 100644</span><br><span=
>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=
=2Eam</span><br><span>@@ -109,6 +109,7 @@</span><br><span> 	openvpn=2Ec ope=
nvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span><br><span> 	op=
tions_show=2Ec options_show=2Eh \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	options_string=2Ec options_string=2Eh \</span><br><span> 	op=
tions_util=2Ec options_util=2Eh \</span><br><span> 	options_parse=2Ec \</sp=
an><br><span> 	otime=2Ec otime=2Eh \</span><br><span>diff --git a/src/openv=
pn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index a90fe69=2E=2Efa62c=
dd 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/=
src/openvpn/init=2Ec</span><br><span>@@ -54,6 +54,7 @@</span><br><span> #in=
clude &quot;dco=2Eh&quot;</span><br><span> #include &quot;tun_afunix=2Eh&qu=
ot;</span><br><span> #include &quot;schedule=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_string=2Eh&quot;<=
/span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/occ=2Ec b/src/openvpn/oc=
c=2Ec</span><br><span>index aa262a8=2E=2Ef25ae19 100644</span><br><span>---=
 a/src/openvpn/occ=2Ec</span><br><span>+++ b/src/openvpn/occ=2Ec</span><br>=
<span>@@ -29,7 +29,7 @@</span><br><span> #include &quot;occ=2Eh&quot;</span=
><br><span> #include &quot;forward=2Eh&quot;</span><br><span> #include &quo=
t;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=
_string=2Eh&quot;</span><br><span> </span><br><span> /*</span><br><span>  *=
 This random string identifies an OpenVPN</span><br><span>diff --git a/src/=
openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index e899fa6=
=2E=2Ef5163d6 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><b=
r><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3697,436 +3697,6 =
@@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Build an options string to represe=
nt data channel encryption options=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * This string must match exactly between peers=2E  The key=
size is checked</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * sep=
arately by read_key()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The following=
 options must match on both peers:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Tun=
nel options:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * --dev tun|tap [unit numbe=
r need not match]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * -=
-dev-type tun|tap</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * -=
-link-mtu</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --udp-mtu=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tun-mtu</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * --proto udp</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * --proto tcp-client [matched with -=
-proto tcp-server</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
                   on the other end of the connection]</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * --proto tcp-server [matched with --prot=
o tcp-client on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    =
                 the other end of the connection]</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * --tun-ipv6</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * --ifconfig x y [matched with --ifconfig y x on</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *                 the othe=
r end of the connection]</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --comp-lzo</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * --compress alg</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * --fragment</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Crypto Options:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 --cipher</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --auth</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * --secret</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * SSL Options:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
--tls-auth</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tls-cl=
ient [matched with --tls-server on</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *               the other end of the connection]</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * --tls-server [matched with --tl=
s-client on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        =
       the other end of the connection]</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_string(=
const struct options *o, const struct frame *frame, struct tuntap *tt,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-               openvpn_net=
_ctx_t *ctx, bool remote, struct gc_arena *gc)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct buffer out =3D alloc_buf(OPTION_LINE_SIZE);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    bool tt_local =3D false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;V4&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     * Tunnel Options</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &q=
uot;,dev-type %s&quot;, dev_type_string(o-&gt;dev, o-&gt;dev_type));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* the link-mtu that we =
send has only a meaning if have a fixed</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * cipher (p2p) or have a fallback cipher configured =
for older non</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * n=
cp clients=2E But not sending it will make even 2=2E4 complain</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * about it being missing=2E S=
o still send it=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    buf_printf(&amp;out, &quot;,link-mtu %u&quot;, (unsigned int)calc_optio=
ns_string_link_mtu(o, frame));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&g=
t;ce=2Eocc_mtu !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_pri=
ntf(&amp;out, &quot;,tun-mtu %d&quot;, o-&gt;ce=2Eocc_mtu);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 buf_printf(&amp;out, &quot;,tun-mtu %d&quot;, frame-&gt;tun_mtu);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    buf_printf(&amp;out, &quot;,proto %s&quot;, proto_remote(o-&gt;=
ce=2Eproto, remote));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool p2p_nopull =
=3D o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !PULL_DEFINED(o);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* send tun_ipv6 only =
in peer2peer mode - in client/server mode, it</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * is usually pushed by the server, triggering =
a non-helpful warning</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;=
ifconfig_ipv6_local &amp;&amp; p2p_nopull)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        buf_printf(&amp;out, &quot;,tun-ipv6&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Try to ge=
t ifconfig parameters into the options string=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * If tt is undefined, make a temporary inst=
antiation=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tt)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        tt =3D init_tun(o-&gt;dev, o-&gt;dev_typ=
e, o-&gt;topology, o-&gt;ifconfig_local,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                      o-&gt;ifconfig_remote_netmask, o-&=
gt;ifconfig_ipv6_local, o-&gt;ifconfig_ipv6_netbits,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                      o-&gt;ifconfig_ipv6_r=
emote, NULL, NULL, false, NULL, ctx, NULL);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (tt)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            tt_local =3D true;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (tt &amp;&amp; p2p_nopull)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        const char *ios =3D ifconfig_opt=
ions_string(tt, remote, o-&gt;ifconfig_nowarn, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (ios &amp;&amp; strlen(ios))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quo=
t;,ifconfig %s&quot;, ios);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt_local)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        free(tt);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        tt =3D NULL;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef US=
E_COMP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;c=
omp=2Ealg !=3D COMP_ALG_UNDEF)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 buf_printf(&amp;out, &quot;,comp-lzo&quot;); /* for compatibility, this si=
mply indicates that compression</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                          context is active, not =
necessarily LZO per-se */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef ENABLE_FRAGMENT</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (o-&gt;ce=2Efragment)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;,mtu-dynamic&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define TLS_CLIENT (o-&gt;tls_client)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define TLS_SERVER (o-&gt;tls_server)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * Key direction</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        const char *kd =3D keydire=
ction2ascii(o-&gt;key_direction, remote, false);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (kd)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            buf_printf(&amp;out, &quot;,keydir %s&quot;, kd);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Crypto O=
ptions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;shared_secret_f=
ile || TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct key_type kt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT((o-&g=
t;shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =
=3D=3D true) &lt;=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Skip re=
solving BF-CBC to allow SSL libraries without BF-CBC</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * to work here in the default conf=
iguration */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
onst char *ciphername =3D o-&gt;ciphername;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        size_t keysize =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D =
0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            init_key_type(&amp;=
kt, &quot;none&quot;, o-&gt;authname, true, false);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            keysize =3D 128;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname, =
true, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    ciphername =3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (cipher_defined(o-&gt;ciphername))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                keysize =3D c=
ipher_kt_key_size(kt=2Ecipher) * 8;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  /* Only announce the cipher to our peer if we are willing to</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         * support it */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (p2p_nopull || tls_i=
tem_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,cipher %s&quot;, c=
iphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&am=
p;out, &quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;,keysiz=
e %zu&quot;, keysize);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            buf_printf(&amp;out, &quot;,secret&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * SSL Options</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (TLS_CLIENT || TLS_SERVER)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (o-&gt;ce=2Etls_auth_file)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;=
,tls-auth&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
/* Not adding tls-crypt here, because we won&#39;t reach this code if</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-             * tls-auth/tls=
-crypt does not match=2E  Removing tls-auth here would</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-             * break stuff, so leaving tha=
t in place=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&am=
p;out, &quot;,key-method %d&quot;, KEY_METHOD_2);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (remote)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (TLS=
_CLIENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_p=
rintf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            else if (TLS_SERVER)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-client&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (TLS_CLIENT)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                buf_printf(&amp;out, &quot;,tls-client&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (TLS_SERV=
ER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_printf=
(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#undef TLS_CLIENT</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#undef TLS_SERVER</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return BSTR(&amp;out);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Compare option strings for equality=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * If the first two chars of th=
e strings differ, it means that</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * we are looking at different versions of the options string,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * therefore don&#39;t c=
ompare them and return true=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-options_cmp_equal(char *actual, const char *exp=
ected)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return options_cmp_equal_safe(a=
ctual, expected, strlen(actual) + 1);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-options_warning(char *actual, const char *=
expected)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    options_warning_safe(actual,=
 expected, strlen(actual) + 1);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-options_warning_extract_parm1(con=
st char *option_string, struct gc_arena *gc_ret)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct buffer b =3D string_alloc_buf(option_strin=
g, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char =
*p =3D gc_malloc(OPTION_PARM_SIZE, false, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *ret;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    buf_parse(&amp;b, &#39; &#39;, p, OPTION_PARM_SIZE);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D string_alloc(p, g=
c_ret);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-options_warning_safe_scan2(const msglvl_t msglevel, const int delim,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
   const bool report_inconsistent, const char *p1,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                           const struct buffer=
 *b2_src, const char *b1_name,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                           const char *b2_name)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* We will stop sending &#39;key-method&#39;, &#39;keydi=
r&#39;, &#39;proto&#39; and &#39;tls-auth&#39; in</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * OCC in a future version (because it&#39;=
s not useful)=2E To reduce questions</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * when interoperating, we no longer printing a warning =
about it=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (strprefix(p1, &q=
uot;key-method &quot;) || strprefix(p1, &quot;keydir &quot;) || strprefix(p=
1, &quot;proto &quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        || streq(p1, &quot;tls-auth&quot;) || strprefix(p1, &quot;tun-ipv6=
&quot;) || strprefix(p1, &quot;cipher &quot;))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (strlen(p1) &gt; 0)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer b2=
 =3D *b2_src;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
const char *p1_prefix =3D options_warning_extract_parm1(p1, &amp;gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *p2 =3D gc_mal=
loc(OPTION_PARM_SIZE, false, &amp;gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    while (buf_parse(&amp;b2, delim, p2, OPTION_PARM_SIZE))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (strlen(p2))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                const char *p2_prefix =3D options_w=
arning_extract_parm1(p2, &amp;gc);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        if (!strcmp(p1, p2))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    goto done;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                if (!strcmp(p1_prefix, p2_prefix))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    if (report_inconsisten=
t)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     msg(msglevel, &quot;WARNING: &#39;%s&#39; is used inconsistently, %s=
=3D&#39;%s&#39;, %s=3D&#39;%s&#39;&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                            safe_print(p1_prefix, &amp;=
gc), b1_name, safe_print(p1, &amp;gc), b2_name,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                            safe_print(p2, &amp;g=
c));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        msg(msglevel, &quot;WARNING: &#39;%s&#39; is =
present in %s config but missing in %s config, %s=3D&#39;%s&#39;&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            safe_print(p1=
_prefix, &amp;gc), b1_name, b2_name, b1_name, safe_print(p1, &amp;gc));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-done:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-options_warning_safe_scan1(const msglvl_t msglevel=
, const int delim,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                        const bool report_inconsistent, const struct buffer=
 *b1_src,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
               const struct buffer *b2_src, const char *b1_name, const char=
 *b2_name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffe=
r b =3D *b1_src;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
har *p =3D gc_malloc(OPTION_PARM_SIZE, true, &amp;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    while (buf_parse(&amp;b, delim, p, OPTION_PARM_SIZE))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options_warning_safe_scan2(msglevel=
, delim, report_inconsistent, p, b2_src, b1_name,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                   b2_name);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-options_warning_safe_ml(const msglvl_=
t msglevel, char *actual, const char *expected, size_t actual_n)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (actual_n &gt; 0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        struct buffer local =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &am=
p;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct =
buffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &amp;gc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        actual[actual_n - 1] =3D =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;local, &quot;ver=
sion %s&quot;, expected);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        buf_printf(&amp;remote, &quot;version %s&quot;, actual);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        options_warning_safe_scan1(msglevel, &#39=
;,&#39;, true, &amp;local, &amp;remote, &quot;local&quot;, &quot;remote&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        options_warning_safe_scan1(msg=
level, &#39;,&#39;, false, &amp;remote, &amp;local, &quot;remote&quot;, &qu=
ot;local&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-options_cmp_equal_safe(ch=
ar *actual, const char *expected, size_t actual_n)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    bool ret =3D true;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (actual_n &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a=
ctual[actual_n - 1] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (strncmp(actual, expected, 2))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(D_SHOW_OCC, &quot;NOTE: Options consistency ch=
eck may be skewed by version differences&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            options_warning_safe_ml(D_SHOW_OCC, =
actual, expected, actual_n);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D !strcm=
p(actual, expected);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_warning_sa=
fe(char *actual, const char *expected, size_t actual_n)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    options_warning_safe_ml(D_SHOW_OCC, actual, expected, act=
ual_n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-options_string_version(const char *s, struct gc_arena *gc)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf_gc(4, gc);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt((char *)=
BPTR(&amp;out), s, 3);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return BSTR(&amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_string_extract=
_option(const char *options_string, const char *opt_name, struct gc_arena *=
gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const size_t opt_name_len =3D st=
rlen(opt_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *p =3D optio=
ns_string;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (=
p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (0 =3D=3D strncmp(p, opt=
_name, opt_name_len) &amp;&amp; strlen(p) &gt; (opt_name_len + 1)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; p[opt_na=
me_len] =3D=3D &#39; &#39;)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      /* option found, extract value */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            const char *start =3D &amp;p[opt_name_len + 1=
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const c=
har *end =3D strchr(p, &#39;,&#39;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            size_t val_len =3D end ? end - start : strlen(st=
art);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =
=3D gc_malloc(val_len + 1, true, gc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            memcpy(ret, start, val_len);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        p =3D strchr(p, &#39;,&#39;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (p)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            p++; /* skip delimiter */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/*</span><br><span>  * parse/print topology coding<=
/span><br><span>  */</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index d42773f=2E=
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
pan>new file mode 100644</span><br><span>index 0000000=2E=2Ed3b29b8</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/options_string=2Ec=
</span><br><span>@@ -0,0 +1,429 @@</span><br><span style=3D"color: hsl(120,=
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
;">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_s=
tring(const struct options *o, const struct frame *frame, struct tuntap *tt=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               ope=
nvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer out =3D alloc_buf(OPTION_LINE_SIZE);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool tt_local =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;V4=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * Tunnel Options</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_printf(&amp;out, &quot;,dev-type %s&quot;, dev_type_string(o-&=
gt;dev, o-&gt;dev_type));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* the link-mtu that we send has only a meaning if have a fixed</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cipher (p2p) o=
r have a fallback cipher configured for older non</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * ncp clients=2E But not sending it will=
 make even 2=2E4 complain</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * about it being missing=2E So still send it=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,l=
ink-mtu %u&quot;, (unsigned int)calc_options_string_link_mtu(o, frame));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;ce=2Eocc_mtu !=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,tun-=
mtu %d&quot;, o-&gt;ce=2Eocc_mtu);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;=
out, &quot;,tun-mtu %d&quot;, frame-&gt;tun_mtu);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 buf_printf(&amp;out, &quot;,proto %s&quot;, proto_remote(o-&gt;ce=2Eproto,=
 remote));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool p2p_nopull =3D o-&g=
t;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !PULL_DEFINED(o);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* send tun_ipv6 only in pee=
r2peer mode - in client/server mode, it</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * is usually pushed by the server, triggering a no=
n-helpful warning</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;=
ifconfig_ipv6_local &amp;&amp; p2p_nopull)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf_printf(&amp;out, &quot;,tun-ipv6&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * Try to get ifconfig parameters into the options string=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * If tt is undefined, make a =
temporary instantiation=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tt =3D init_tun(o-=
&gt;dev, o-&gt;dev_type, o-&gt;topology, o-&gt;ifconfig_local,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                      o-&gt;ifco=
nfig_remote_netmask, o-&gt;ifconfig_ipv6_local, o-&gt;ifconfig_ipv6_netbits=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
    o-&gt;ifconfig_ipv6_remote, NULL, NULL, false, NULL, ctx, NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tt)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            tt_local =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (tt &amp;&amp; p2p_nopull)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        const char *ios =3D ifconfig_options_string(tt, remote, o-&gt;if=
config_nowarn, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (ios &amp;&amp; strlen(ios))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            buf_printf(&amp;out, &quot;,ifconfig %s&quot;, ios);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (tt_local)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        free(tt);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        tt =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef USE_COMP</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;comp=2Eal=
g !=3D COMP_ALG_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
for compatibility, this simply indicates that compression</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * context is active, not nec=
essarily LZO per-se */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        buf_printf(&amp;out, &quot;,comp-lzo&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENA=
BLE_FRAGMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(o-&gt;ce=2Efragment)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_=
printf(&amp;out, &quot;,mtu-dynamic&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLS_CLIENT (o-=
&gt;tls_client)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine TLS_SERVER (o-&gt;tls_server)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Key directi=
on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const char *kd =3D keydirection2a=
scii(o-&gt;key_direction, remote, false);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (kd)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            buf_printf(&amp;out, &quot;,keydir %s&quot;, kd);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 Crypto Options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;sh=
ared_secret_file || TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct key_type kt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ASSERT((o-&gt;shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D t=
rue) + (TLS_SERVER =3D=3D true) &lt;=3D 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * to work =
here in the default configuration */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        const char *ciphername =3D o-&gt;ciphername;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t keysize =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (strcmp(o-&gt;ciphern=
ame, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            init_key_type(&amp;kt, &quot;none&quot;, o-&gt;authname, t=
rue, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     keysize =3D 128;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            init_key_type=
(&amp;kt, o-&gt;ciphername, o-&gt;authname, true, false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            ciphername =3D cipher_kt_=
name(kt=2Ecipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (cipher_defined(o-&gt;ciphername))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                keysize =3D cipher_kt_key_size(kt=2E=
cipher) * 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Only announc=
e the cipher to our peer if we are willing to</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * support it */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (p2p_nopull || tls_item_in_cipher=
_list(ciphername, o-&gt;ncp_ciphers))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            buf_printf(&amp;out, &quot;,cipher %s&quot;, ciphername=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out=
, &quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,keysize %=
zu&quot;, keysize);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            buf_printf(&amp;out, &quot;,secret&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * SSL O=
ptions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (TLS_CLIENT || TLS_SERVER)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (o-&gt;ce=2Etls_=
auth_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 buf_printf(&amp;out, &quot;,tls-auth&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            /* Not adding tls-crypt here, because we wo=
n&#39;t reach this code if</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             * tls-auth/tls-crypt does not match=2E  Removing tls-au=
th here would</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       * break stuff, so leaving that in place=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            buf_printf(&amp;out, &quot;,key-method %d&quot;,=
 KEY_METHOD_2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (remote)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (TLS_CLIENT)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &q=
uot;,tls-server&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          else if (TLS_SERVER)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                buf_printf(&amp;out, &quot;,tls-client&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (TLS_CLIENT)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                buf_printf(&amp;out, &quot;,tls-client&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if=
 (TLS_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    buf_printf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef TLS_CLIENT<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef TLS_SERVER</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;out);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Compare o=
ption strings for equality=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If t=
he first two chars of the strings differ, it means that</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * we are looking at different versions=
 of the options string,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * therefore don&#39;t compare them and return true=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+options_warning_extract_parm1(const char *option_str=
ing, struct gc_arena *gc_ret)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer b =3D string_alloc_buf(option_string, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *p =3D gc_m=
alloc(OPTION_PARM_SIZE, false, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_parse(&amp;b, &#39; &#39;, p, OPTION_PARM_SIZE);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(p, gc_ret)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+options_warning_safe_scan2(const msglvl_t msglevel, const int del=
im,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
           const bool report_inconsistent, const char *p1,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                           const str=
uct buffer *b2_src, const char *b1_name,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                           const char *b2_name)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* We will stop sending &#39;key-method&=
#39;, &#39;keydir&#39;, &#39;proto&#39; and &#39;tls-auth&#39; in</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * OCC in a future versio=
n (because it&#39;s not useful)=2E To reduce questions</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * when interoperating, we no longer=
 printing a warning about it=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (strprefix(p1, &quot;key-method &quot;) || strprefix(p1, &quot;keydi=
r &quot;) || strprefix(p1, &quot;proto &quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        || streq(p1, &quot;tls-auth&quot;) || st=
rprefix(p1, &quot;tun-ipv6&quot;) || strprefix(p1, &quot;cipher &quot;))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (strlen(p1) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct buffer b2 =3D *b2_src;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const char *p1_prefix =3D options=
_warning_extract_parm1(p1, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        char *p2 =3D gc_malloc(OPTION_PARM_SIZE, false, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        while (buf_parse(&amp;b=
2, delim, p2, OPTION_PARM_SIZE))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (strlen(p2))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                const char *p2_prefix =3D options_warning_extract_parm=
1(p2, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (!st=
rcmp(p1, p2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                if (!strcmp(p1_prefix, p2_prefix))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    if (report_inconsiste=
nt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          msg(msglevel, &quot;WARNING: &#39;%s&#39; is used inconsistently,=
 %s=3D&#39;%s&#39;, %s=3D&#39;%s&#39;&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                            safe_print(p1_prefix, =
&amp;gc), b1_name, safe_print(p1, &amp;gc), b2_name,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            safe_print(p2=
, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               goto done;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;WAR=
NING: &#39;%s&#39; is present in %s config but missing in %s config, %s=3D&=
#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           safe_print(p1_prefix, &amp;gc), b1_name, b2_name, b1_name, safe_=
print(p1, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_wa=
rning_safe_scan1(const msglvl_t msglevel, const int delim,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                           const boo=
l report_inconsistent, const struct buffer *b1_src,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           const struct b=
uffer *b2_src, const char *b1_name, const char *b2_name)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer b =3D *b1_src;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *p =3D gc_malloc(=
OPTION_PARM_SIZE, true, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
hile (buf_parse(&amp;b, delim, p, OPTION_PARM_SIZE))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        options_warning_safe_scan2(msglevel, delim, rep=
ort_inconsistent, p, b2_src, b1_name,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                   b2_name);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+options_warning_safe_ml(const msg=
lvl_t msglevel, char *actual, const char *expected, size_t actual_n)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (actual_n &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct buffer local =3D alloc_buf_gc(OPTION_PAR=
M_SIZE + 16, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct buffer remote =3D alloc_buf_gc(OPTION_PARM_SIZE + 16, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        actua=
l[actual_n - 1] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_prin=
tf(&amp;local, &quot;version %s&quot;, expected);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        buf_printf(&amp;remote, &quot;version=
 %s&quot;, actual);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options_war=
ning_safe_scan1(msglevel, &#39;,&#39;, true, &amp;local, &amp;remote, &quot=
;local&quot;, &quot;remote&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    options_warning_safe_scan1(msglevel, &#39;,&#39;, false, &amp;remote, &=
amp;local, &quot;remote&quot;, &quot;local&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+options_cmp_equal_safe(char *actual, const char *exp=
ected, size_t actual_n)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (actua=
l_n &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        actual[actual_=
n - 1] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (strncmp(actual, expected, 2))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(D_SHOW_OCC, &quot;NOTE: Options consistency check may=
 be skewed by version differences&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            options_warning_safe_ml(D_SHOW_OCC, actua=
l, expected, actual_n);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D !st=
rcmp(actual, expected);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+options_cmp_equal(char *actual, const char *expected)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return options_cmp_equal_safe(actual, expected, strlen=
(actual) + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+options_warning_safe(char *actual, const char *expected,=
 size_t actual_n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    options_warning_=
safe_ml(D_SHOW_OCC, actual, expected, actual_n);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+options_warning(char *a=
ctual, const char *expected)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    optio=
ns_warning_safe(actual, expected, strlen(actual) + 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_s=
tring_version(const char *s, struct gc_arena *gc)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer out =3D alloc_buf_gc(4, gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    strncpynt((char *)BPTR(&amp;out)=
, s, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
BSTR(&amp;out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cha=
r *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_string_e=
xtract_option(const char *options_string, const char *opt_name, struct gc_a=
rena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t opt_nam=
e_len =3D strlen(opt_name);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *p =3D options_string;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    while (p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (0=
 =3D=3D strncmp(p, opt_name, opt_name_len) &amp;&amp; strlen(p) &gt; (opt_n=
ame_len + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &amp;&amp; p[opt_name_len] =3D=3D &#39; &#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* option found, extract value */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            const char *s=
tart =3D &amp;p[opt_name_len + 1];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const char *end =3D strchr(p, &#39;,&#39;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            size_t val_l=
en =3D end ? end - start : strlen(start);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            ret =3D gc_malloc(val_len + 1, true, gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(=
ret, start, val_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
 =3D strchr(p, &#39;,&#39;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (p)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      p++; /* skip delimiter */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return r=
et;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
>diff --git a/src/openvpn/options_string=2Eh b/src/openvpn/options_string=
=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E02efed3</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
options_string=2Eh</span><br><span>@@ -0,0 +1,97 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the =
GNU General Public License version 2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPTIONS_STRING_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPTIONS_STRI=
NG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+const char *options_string_v=
ersion(const char *s, struct gc_arena *gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Build an=
 options string to represent data channel encryption options=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * This string must match exact=
ly between peers=2E  The keysize is checked</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * separately by read_key()=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * The following options must match on both peers:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Tunnel options:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * --dev tun|tap [unit number need not match]</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * --dev-type tun|tap</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * --link-mtu</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * --udp-mtu</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * --tun-mtu</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * --proto udp</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * --proto tcp-client [matched with --proto tcp-serve=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                =
     on the other end of the connection]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * --proto tcp-server [matched with --proto tcp-client=
 on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              =
       the other end of the connection]</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * --tun-ipv6</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * --ifconfig x y [matched with --ifconfig y x on</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *                 the other en=
d of the connection]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --comp-lzo</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --compress alg</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --fragment</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Crypto Options:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * --cipher</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * --auth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --sec=
ret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * SSL Options:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * --tls-auth</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * --tls-client [matched with --tls-server on</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *               the other end of =
the connection]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * -=
-tls-server [matched with --tls-client on</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *               the other end of the connection]</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+char *options_string(const struct optio=
ns *o, const struct frame *frame, struct tuntap *tt,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     openvpn_net_ctx_t *c=
tx, bool remote, struct gc_arena *gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool options_cmp_equal_safe(char *actual, const char *expected, size_t actu=
al_n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void options_warning_safe(char *=
actual, const char *expected, size_t actual_n);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool options_cmp_equal(char *actual, const char *expected);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void options_warning(char *actual, const char=
 *expected);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Given an OpenVPN options string, extra=
ct the value of an option=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m options_string        Zero-terminated, comma-separated options string</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opt_name     =
         The name of the option to extract</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param gc                    The gc to allocate t=
he return value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return gc-allocat=
ed value of option with name opt_name if option was found,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *         or NULL otherwise=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+char *options_string_extract_option(cons=
t char *options_string, const char *opt_name,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                    struct gc_are=
na *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/s=
sl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 01e45fd=2E=2Ed5bd602 100=
644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl=2Ec</span><br><span>@@ -62,6 +62,7 @@</span><br><span> #include &q=
uot;auth_token=2Eh&quot;</span><br><span> #include &quot;mss=2Eh&quot;</spa=
n><br><span> #include &quot;dco=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;options_string=2Eh&quot;</span><br><sp=
an> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #inc=
lude &quot;openvpn=2Eh&quot;</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail"=
>change 1773</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1773 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>

</body></html>
--erHvOmIGs9A=--


--===============0972363233414395954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0972363233414395954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0972363233414395954==--

