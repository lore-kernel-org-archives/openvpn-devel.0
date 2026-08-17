Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF89C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=172acC0xA+2J2cIfimt67cKwmDJmAvbCVfg9Cs8cnPE=; b=WJQId89Mf4sGwdV1Ka1sQE4flu
	RYhyn9jEx4fTWjnQHZ9b/cvBtZrLhL+W2S3gq3kuy4kLv8ceGufnw5HmsyhtTnUu6tj2lcADX4d4G
	GqFxsJVob6+6t7icCkyrpn24sRmOMsrOaGc17wN1d57s61LmLoWjWqGOIDPNBOGmqsq8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvw90-0001PA-U7;
	Mon, 17 Aug 2026 12:08:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvw8z-0001P2-LT
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xjt+q0wWvxcCMhkfp/z5o6zYb8fIWwQtSSWjpQerGpY=; b=ejDv/VzWHhS6OyEvaJBQsJwqQO
 g/xdokjEqoDu8YmV6H8xbBz5iEyxfGVDYwi7ZfV6rJepXnAihI+DHtEuehZjGOrB2IWZ//EIH1Sk1
 qkes3EOZXVR5nDuyPpouyU/OI6zgL2+5kKQX8bdxuAIpwAY101X+xZ52AMHxE2F31Erc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xjt+q0wWvxcCMhkfp/z5o6zYb8fIWwQtSSWjpQerGpY=; b=K
 51ZCA/EsrjfUdVMaGVLj2thFKeGExUHFpIG6xRugxkeLZP0D5208pMz7Ckrt5SSH7vN6cZrXCXQqY
 QqIunVw5T04KZi7/GX0FE5ZamVBH0PwinnZHmz91qnvgEtJ0hRi7gRgxLHPH94dsxqv4vwLi6T5WA
 /VS+aa4u1BjwoX9Q=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvw8s-00054j-6k for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:43 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so31533825e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786968512; x=1787573312; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xjt+q0wWvxcCMhkfp/z5o6zYb8fIWwQtSSWjpQerGpY=;
 b=JpXSRDYYKYO1PpQSBm7NvfoCoURvAJ6g0WuUHA4ERgTcFFamLIvFGRzM7uTISSg8Q8
 SPv8txhALZwJeMLqL43MhqmCcA85YgbCT1qQXyImNqvg4LI4TyO5EcwtyMSIQNq9EZ5y
 drLPZ4JMSKcYbXLJFSgeaw/Fui3rpStB1OD2F6LU9JbupQiZd2zkTWpQhpwunCMnUJ7c
 auCnUaPrhpAuxQ4Zo2KLf+mtzfaveh4trB+QIiaZEvDgUN60T2Lg5oHL2ZaW44HUK22s
 hBPSmI6RwSagHA+Ke0rWoQVR+C2EqeF7hS1Jp3cwxgTeIaPifLeLkZ84CTQ9h+NiBxpw
 QR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968512; x=1787573312;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xjt+q0wWvxcCMhkfp/z5o6zYb8fIWwQtSSWjpQerGpY=;
 b=hUBnTbat0ND/A0R65MNYsnVa9tkgcT0ATefDL6BNR9opwm/tXZQ7hdxGRE1WCeLwy1
 SjgjzJfOup0FH2GUdZbLUhUI7OdlYqqGpf7nJPtdJNXx6zqof5f9HJDjcm8keNTNvv3w
 AmsvqRbA7q+xpWDZbqfHFPTC9Uyc8sEKc4xrh9WMUXKW4lYQaYFmcbBz5TZldY2MeHeM
 jfbJ2zOS+PtfMwSs0ATRvRylyylV9YlMudL71ScT9F5bdBQShSPbHtkecBWofnVGaaih
 8oCNY/savvhcTerNBcKL+ATEuZ0ntDDNV42gA9589MfzlrqFYm168grcRBDABIs4HmuX
 rJLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAk3DdSgpnDMx/YXf5RKo79eeHoKJL2xxK6TqF02P2GhxE0gt1GJXetj0oqoLdlJ1xuOXT6MgVvBgnFBxj@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yys/iekGL69wrDkPaWzG7Q/IxAEE6puPlw1bbW7DkOS3UXLqpmx
 5d3yMASOHl1r+JyvMQwhfxOVZjdwO5IK6H0ODtVSxCLksXVUz8xpr5IREhLiBiYy/wX6d75H1s/
 a/YFNoWo6DB1TkH/WhPWDKFywMWHzXkGfQyP8oibjPtenv33FYSK1iaj6rVD4kpgZbQkYLEjw78
 +7VNwOlA==
X-Gm-Gg: AR+sD13MMdFnDwcRh/4l815Oc6CFUbarufyxdBC2gvPZ/sbQXrxgiEqdDVkpxQ4rvcc
 lRTzk6fyDz+hT5Yno36lMKu/ON4ozLN2LqRMjbKp02ZnTCqIVNoUk9ffeB/w+0TjSL4nNqGo/do
 3tnGKwEuCCe9kDshJZzdKj32z28mR3jUzJ5PhU3GPBf3m+wu647Qtg44AYYfBAr6W855erzRNAy
 HZu6aTg9CkVXBeOvv4NmZTmAmjsDeTJNUx3K/Y8IH2ij1QH+AHhTeSwUIXuXDbo7rywHvdiYMC/
 4N82PtTbtAdQ2GjCV24D6diLDh3HfpnTwdBMlStrhbg0UGlrxj68QkJV/fBadLdBtpnoLet9s+m
 o+EFY5pUSKx1M/9jmS2du5t4ND3+SXZDnv9OO1a/E0jNiMMMlE/qu5pkhAkgsoVQiF2BIgs44d+
 dqSEtAETlBWySYMfmFoL0eSxp9+wdbeTAzWc15158God+9ICbBd2gx8pJC+pKAICI4wh3BhR0x5
 oxZAS/ajYWq2K3v97EcMQsa5FBuf6AVnRUCL0V8Y0pfHqFyJQQcZmO5GZyPFWQ95kz2ES9oelA7
 1ThKCD6aCGPPQpZaExgsd2ZDOGfeej7hyGI6BM8c7GeI8pZ/zUQ=
X-Received: by 2002:a05:600c:8b37:b0:497:ff73:68d5 with SMTP id
 5b1f17b1804b1-499878cf9bamr364516335e9.0.1786968510949; 
 Mon, 17 Aug 2026 05:08:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a315d3sm3592018f8f.6.2026.08.17.05.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:08:27 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:08:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 16f746e22115b096bb1e6f1723cb4f63f0f6885c
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0438b0b5a5eca47e23fc7fd16fca06d2e610b79e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvw8s-00054j-6k
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 options display code from options.c
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
Content-Type: multipart/mixed; boundary="===============3142066366018501511=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3142066366018501511==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PfbalsEuivw="; charset=UTF-8

--PfbalsEuivw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail

to look at the new patch=
 set (#3)=2E


Change subject: options: Factor out options display code fro=
m options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


options: Factor out options display code from options=2Ec

options=2Ec is=
 a huge, unwieldly file=2E So remove some
closely related code that has no =
direct dependencies
with the other functions in the file=2E

In this case i=
t is the code that prints out the current
configuration=2E

Change-Id: I617=
62374c141662d596bbf88b64ca7f7472b5149
Signed-off-by: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M =
src/openvpn/openvpn=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh=

A src/openvpn/options_show=2Ec
A src/openvpn/options_show=2Eh
7 files chan=
ged, 681 insertions(+), 620 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/72/1772/3

diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt
index ad7de6e=2E=2E540992b 100644
--- a/CMakeLists=2Etx=
t
+++ b/CMakeLists=2Etxt
@@ -527,6 +527,8 @@
     src/openvpn/options_util=
=2Ec
     src/openvpn/options_util=2Eh
     src/openvpn/options_parse=2Ec
+=
    src/openvpn/options_show=2Ec
+    src/openvpn/options_show=2Eh
     src=
/openvpn/otime=2Ec
     src/openvpn/otime=2Eh
     src/openvpn/ovpn_dco_win=
=2Eh
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
ind=
ex 1f77384=2E=2E2092e96 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/op=
envpn/Makefile=2Eam
@@ -108,6 +108,7 @@
 	pkcs11_mbedtls=2Ec \
 	openvpn=2E=
c openvpn=2Eh \
 	options=2Ec options=2Eh \
+	options_show=2Ec options_show=
=2Eh \
 	options_util=2Ec options_util=2Eh \
 	options_parse=2Ec \
 	otime=
=2Ec otime=2Eh \
diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=
=2Ec
index 5e1f680=2E=2E24d6bb6 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/=
src/openvpn/openvpn=2Ec
@@ -30,6 +30,7 @@
 #include "forward=2Eh"
 #include=
 "multi=2Eh"
 #include "win32=2Eh"
+#include "options_show=2Eh"
 #include "=
platform=2Eh"
 
 #include "memdbg=2Eh"
diff --git a/src/openvpn/options=2Ec=
 b/src/openvpn/options=2Ec
index 5e74a41=2E=2E87da344 100644
--- a/src/open=
vpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -931,41 +931,6 @@
     gc_=
free(&o->dns_options=2Egc);
 }
 
-#ifndef ENABLE_SMALL
-
-static const char=
 *
-pull_filter_type_name(int type)
-{
-    if (type =3D=3D PUF_TYPE_ACCEPT=
)
-    {
-        return "accept";
-    }
-    if (type =3D=3D PUF_TYPE_IGN=
ORE)
-    {
-        return "ignore";
-    }
-    if (type =3D=3D PUF_TYPE_=
REJECT)
-    {
-        return "reject";
-    }
-    else
-    {
-        r=
eturn "???";
-    }
-}
-
-#define SHOW_PARM(name, value, format) msg(D_SHOW=
_PARMS, "  " #name " =3D " format, (value))
-#define SHOW_STR(var)         =
         SHOW_PARM(var, (o->var ? o->var : "[UNDEF]"), "'%s'")
-#define SHO=
W_STR_INLINE(var) \
-    SHOW_PARM(var, o->var##_inline ? "[INLINE]" : (o->=
var ? o->var : "[UNDEF]"), "'%s'")
-#define SHOW_INT(var)      SHOW_PARM(va=
r, o->var, "%d")
-#define SHOW_UINT(var)     SHOW_PARM(var, o->var, "%u")
-=
#define SHOW_INT64(var)    SHOW_PARM(var, o->var, "%" PRIi64)
-#define SHOW=
_UNSIGNED(var) SHOW_PARM(var, o->var, "0x%08x")
-#define SHOW_BOOL(var)    =
 SHOW_PARM(var, (o->var ? "ENABLED" : "DISABLED"), "%s");
-
-#endif /* ifnd=
ef ENABLE_SMALL */
-
 static void
 setenv_connection_entry(struct env_set *=
es, const struct connection_entry *e, const int i)
 {
@@ -1257,55 +1222,6 @=
@
 
     return ret;
 }
-#ifdef _WIN32
-
-#ifndef ENABLE_SMALL
-
-static vo=
id
-show_dhcp_option_list(const char *name, const char *const *array, unsig=
ned int len)
-{
-    for (unsigned int i =3D 0; i < len; ++i)
-    {
-     =
   msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, array[i]);
-    }
-}
-
-st=
atic void
-show_dhcp_option_addrs(const char *name, const in_addr_t *array,=
 unsigned int len)
-{
-    struct gc_arena gc =3D gc_new();
-    for (unsig=
ned int i =3D 0; i < len; ++i)
-    {
-        msg(D_SHOW_PARMS, "  %s[%u] =
=3D %s", name, i, print_in_addr_t(array[i], 0, &gc));
-    }
-    gc_free(&=
gc);
-}
-
-static void
-show_tuntap_options(const struct tuntap_options *o)=

-{
-    SHOW_BOOL(ip_win32_defined);
-    SHOW_INT(ip_win32_type);
-    SH=
OW_INT(dhcp_masq_offset);
-    SHOW_INT(dhcp_lease_time);
-    SHOW_INT(tap=
_sleep);
-    SHOW_UNSIGNED(dhcp_options);
-    SHOW_BOOL(dhcp_renew);
-   =
 SHOW_BOOL(dhcp_pre_release);
-    SHOW_STR(domain);
-    SHOW_STR(netbios_=
scope);
-    SHOW_UNSIGNED(netbios_node_type);
-    SHOW_BOOL(disable_nbt);=

-
-    show_dhcp_option_addrs("DNS", o->dns, o->dns_len);
-    show_dhcp_o=
ption_addrs("WINS", o->wins, o->wins_len);
-    show_dhcp_option_addrs("NTP=
", o->ntp, o->ntp_len);
-    show_dhcp_option_addrs("NBDD", o->nbdd, o->nbd=
d_len);
-    show_dhcp_option_list("DOMAIN-SEARCH", o->domain_search_list, =
o->domain_search_list_len);
-}
-
-#endif /* ifndef ENABLE_SMALL */
-#endif =
/* ifdef _WIN32 */
 
 static void
 dhcp_option_dns6_parse(const char *parm,=
 struct in6_addr *dns6_list, unsigned int *len, msglvl_t msglevel)
@@ -1348=
,116 +1264,6 @@
     }
 }
 
-#ifndef ENABLE_SMALL
-static const char *
-pri=
nt_vlan_accept(enum vlan_acceptable_frames mode)
-{
-    switch (mode)
-   =
 {
-        case VLAN_ONLY_TAGGED:
-            return "tagged";
-
-       =
 case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
-            return "untagged";
-
-  =
      case VLAN_ALL:
-            return "all";
-    }
-    return NULL;
-}=

-
-static void
-show_p2mp_parms(const struct options *o)
-{
-    struct gc=
_arena gc =3D gc_new();
-
-    msg(D_SHOW_PARMS, "  server_network =3D %s",=
 print_in_addr_t(o->server_network, 0, &gc));
-    msg(D_SHOW_PARMS, "  ser=
ver_netmask =3D %s", print_in_addr_t(o->server_netmask, 0, &gc));
-    msg(=
D_SHOW_PARMS, "  server_network_ipv6 =3D %s", print_in6_addr(o->server_netw=
ork_ipv6, 0, &gc));
-    SHOW_INT(server_netbits_ipv6);
-    msg(D_SHOW_PAR=
MS, "  server_bridge_ip =3D %s", print_in_addr_t(o->server_bridge_ip, 0, &g=
c));
-    msg(D_SHOW_PARMS, "  server_bridge_netmask =3D %s",
-        prin=
t_in_addr_t(o->server_bridge_netmask, 0, &gc));
-    msg(D_SHOW_PARMS, "  s=
erver_bridge_pool_start =3D %s",
-        print_in_addr_t(o->server_bridge_=
pool_start, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_bridge_pool_end =3D =
%s",
-        print_in_addr_t(o->server_bridge_pool_end, 0, &gc));
-    if =
(o->push_list=2Ehead)
-    {
-        const struct push_entry *e =3D o->pus=
h_list=2Ehead;
-        while (e)
-        {
-            if (e->enable)
- =
           {
-                msg(D_SHOW_PARMS, "  push_entry =3D '%s'", e-=
>option);
-            }
-            e =3D e->next;
-        }
-    }
-   =
 SHOW_BOOL(ifconfig_pool_defined);
-    msg(D_SHOW_PARMS, "  ifconfig_pool_=
start =3D %s",
-        print_in_addr_t(o->ifconfig_pool_start, 0, &gc));
-=
    msg(D_SHOW_PARMS, "  ifconfig_pool_end =3D %s", print_in_addr_t(o->ifco=
nfig_pool_end, 0, &gc));
-    msg(D_SHOW_PARMS, "  ifconfig_pool_netmask =
=3D %s",
-        print_in_addr_t(o->ifconfig_pool_netmask, 0, &gc));
-    =
SHOW_STR(ifconfig_pool_persist_filename);
-    SHOW_INT(ifconfig_pool_persi=
st_refresh_freq);
-    SHOW_BOOL(ifconfig_ipv6_pool_defined);
-    msg(D_SH=
OW_PARMS, "  ifconfig_ipv6_pool_base =3D %s",
-        print_in6_addr(o->if=
config_ipv6_pool_base, 0, &gc));
-    SHOW_INT(ifconfig_ipv6_pool_netbits);=

-    SHOW_INT(n_bcast_buf);
-    SHOW_INT(tcp_queue_limit);
-    SHOW_INT(=
real_hash_size);
-    SHOW_INT(virtual_hash_size);
-    SHOW_STR(client_con=
nect_script);
-    SHOW_STR(learn_address_script);
-    SHOW_STR(client_dis=
connect_script);
-    SHOW_STR(client_crresponse_script);
-    SHOW_STR(cli=
ent_config_dir);
-    SHOW_BOOL(ccd_exclusive);
-    SHOW_STR(tmp_dir);
-  =
  SHOW_BOOL(push_ifconfig_defined);
-    msg(D_SHOW_PARMS, "  push_ifconfig=
_local =3D %s",
-        print_in_addr_t(o->push_ifconfig_local, 0, &gc));
=
-    msg(D_SHOW_PARMS, "  push_ifconfig_remote_netmask =3D %s",
-        pr=
int_in_addr_t(o->push_ifconfig_remote_netmask, 0, &gc));
-    SHOW_BOOL(pus=
h_ifconfig_ipv6_defined);
-    msg(D_SHOW_PARMS, "  push_ifconfig_ipv6_loca=
l =3D %s/%d",
-        print_in6_addr(o->push_ifconfig_ipv6_local, 0, &gc),=
 o->push_ifconfig_ipv6_netbits);
-    msg(D_SHOW_PARMS, "  push_ifconfig_ip=
v6_remote =3D %s",
-        print_in6_addr(o->push_ifconfig_ipv6_remote, 0,=
 &gc));
-    SHOW_BOOL(enable_c2c);
-    SHOW_BOOL(duplicate_cn);
-    SHOW=
_INT(cf_max);
-    SHOW_INT(cf_per);
-    SHOW_INT(cf_initial_max);
-    SH=
OW_INT(cf_initial_per);
-    SHOW_UINT(max_clients);
-    SHOW_INT(max_rout=
es_per_client);
-    SHOW_STR(auth_user_pass_verify_script);
-    SHOW_BOOL=
(auth_user_pass_verify_script_via_file);
-    SHOW_BOOL(auth_token_generate=
);
-    SHOW_BOOL(force_key_material_export);
-    SHOW_INT(auth_token_life=
time);
-    SHOW_STR_INLINE(auth_token_secret_file);
-#if PORT_SHARE
-    S=
HOW_STR(port_share_host);
-    SHOW_STR(port_share_port);
-#endif
-    SHOW=
_BOOL(vlan_tagging);
-    msg(D_SHOW_PARMS, "  vlan_accept =3D %s", print_v=
lan_accept(o->vlan_accept));
-    SHOW_INT(vlan_pvid);
-
-    SHOW_BOOL(cli=
ent);
-    SHOW_BOOL(pull);
-    SHOW_STR_INLINE(auth_user_pass_file);
-
- =
   gc_free(&gc);
-}
-
-#endif /* ! ENABLE_SMALL */
-
 static void
 option_i=
route(struct options *o, const char *network_str, const char *netmask_str,
=
               msglvl_t msglevel)
@@ -1502,37 +1308,6 @@
     o->iroutes_ip=
v6 =3D ir;
 }
 
-#ifndef ENABLE_SMALL
-static void
-show_http_proxy_options=
(const struct http_proxy_options *o)
-{
-    int i;
-    msg(D_SHOW_PARMS, =
"BEGIN http_proxy");
-    SHOW_STR(server);
-    SHOW_STR(port);
-    SHOW_=
STR(auth_method_string);
-    SHOW_STR(auth_file);
-    SHOW_STR(auth_file_=
up);
-    SHOW_BOOL(inline_creds);
-    SHOW_BOOL(nocache);
-    SHOW_STR(h=
ttp_version);
-    SHOW_STR(user_agent);
-    for (i =3D 0; i < MAX_CUSTOM_=
HTTP_HEADER && o->custom_headers[i]=2Ename; i++)
-    {
-        if (o->cus=
tom_headers[i]=2Econtent)
-        {
-            msg(D_SHOW_PARMS, "  cust=
om_header[%d] =3D %s: %s", i, o->custom_headers[i]=2Ename,
-               =
 o->custom_headers[i]=2Econtent);
-        }
-        else
-        {
-    =
        msg(D_SHOW_PARMS, "  custom_header[%d] =3D %s", i, o->custom_header=
s[i]=2Ename);
-        }
-    }
-    msg(D_SHOW_PARMS, "END http_proxy");
-=
}
-#endif /* ifndef ENABLE_SMALL */
-
 void
 options_detach(struct options =
*o)
 {
@@ -1580,399 +1355,6 @@
     }
 }
 
-#ifndef ENABLE_SMALL
-static vo=
id
-show_connection_entry(const struct connection_entry *o)
-{
-    /* Disp=
lay the global proto only in client mode or with no '--local'*/
-    if (o-=
>local_list->len =3D=3D 1)
-    {
-        msg(D_SHOW_PARMS, "  proto =3D %=
s", proto2ascii(o->proto, o->af, false));
-    }
-
-    msg(D_SHOW_PARMS, "=
  Local Sockets:");
-    for (int i =3D 0; i < o->local_list->len; i++)
-  =
  {
-        msg(D_SHOW_PARMS, "    [%s]:%s-%s", o->local_list->array[i]->l=
ocal,
-            o->local_list->array[i]->port,
-            proto2ascii(=
o->local_list->array[i]->proto, o->af, false));
-    }
-    SHOW_STR(remote=
);
-    SHOW_STR(remote_port);
-    SHOW_BOOL(remote_float);
-    SHOW_BOOL=
(bind_defined);
-    SHOW_BOOL(bind_local);
-    SHOW_BOOL(bind_ipv6_only);=

-    SHOW_INT(connect_retry_seconds);
-    SHOW_INT(connect_timeout);
-
- =
   if (o->http_proxy_options)
-    {
-        show_http_proxy_options(o->ht=
tp_proxy_options);
-    }
-    SHOW_STR(socks_proxy_server);
-    SHOW_STR(=
socks_proxy_port);
-    SHOW_INT(tun_mtu);
-    SHOW_BOOL(tun_mtu_defined);=

-    SHOW_INT(link_mtu);
-    SHOW_BOOL(link_mtu_defined);
-    SHOW_INT(t=
un_mtu_extra);
-    SHOW_BOOL(tun_mtu_extra_defined);
-    SHOW_INT(tls_mtu=
);
-
-    SHOW_INT(mtu_discover_type);
-
-#ifdef ENABLE_FRAGMENT
-    SHOW_=
INT(fragment);
-#endif
-    SHOW_INT(mssfix);
-    SHOW_BOOL(mssfix_encap);=

-    SHOW_BOOL(mssfix_fixed);
-
-    SHOW_INT(explicit_exit_notification);=

-
-    SHOW_STR_INLINE(tls_auth_file);
-    SHOW_PARM(key_direction, keydi=
rection2ascii(o->key_direction, false, true), "%s");
-    SHOW_STR_INLINE(t=
ls_crypt_file);
-    SHOW_STR_INLINE(tls_crypt_v2_file);
-}
-
-
-static voi=
d
-show_connection_entries(const struct options *o)
-{
-    if (o->connecti=
on_list)
-    {
-        const struct connection_list *l =3D o->connection_=
list;
-        int i;
-        for (i =3D 0; i < l->len; ++i)
-        {
- =
           msg(D_SHOW_PARMS, "Connection profiles [%d]:", i);
-            =
show_connection_entry(l->array[i]);
-        }
-    }
-    else
-    {
-   =
     msg(D_SHOW_PARMS, "Connection profiles [default]:");
-        show_con=
nection_entry(&o->ce);
-    }
-    msg(D_SHOW_PARMS, "Connection profiles E=
ND");
-}
-
-static void
-show_pull_filter_list(const struct pull_filter_lis=
t *l)
-{
-    struct pull_filter *f;
-    if (!l)
-    {
-        return;
-=
    }
-
-    msg(D_SHOW_PARMS, "  Pull filters:");
-    for (f =3D l->head;=
 f; f =3D f->next)
-    {
-        msg(D_SHOW_PARMS, "    %s \"%s\"", pull_=
filter_type_name(f->type), f->pattern);
-    }
-}
-
-#endif /* ifndef ENABL=
E_SMALL */
-
-void
-show_settings(const struct options *o)
-{
-#ifndef ENAB=
LE_SMALL
-    msg(D_SHOW_PARMS, "Current Parameter Settings:");
-
-    SHOW=
_STR(config);
-
-    SHOW_INT(mode);
-
-#ifdef ENABLE_FEATURE_TUN_PERSIST
-=
    SHOW_BOOL(persist_config);
-    SHOW_INT(persist_mode);
-#endif
-
-    =
SHOW_BOOL(show_ciphers);
-    SHOW_BOOL(show_digests);
-    SHOW_BOOL(show_=
engines);
-    SHOW_BOOL(genkey);
-    SHOW_STR(genkey_filename);
-    SHOW=
_STR(key_pass_file);
-    SHOW_BOOL(show_tls_ciphers);
-
-    SHOW_INT(conn=
ect_retry_max);
-    show_connection_entries(o);
-
-    SHOW_BOOL(remote_ra=
ndom);
-
-    SHOW_STR(ipchange);
-    SHOW_STR(dev);
-    SHOW_STR(dev_typ=
e);
-    SHOW_STR(dev_node);
-#if defined(ENABLE_DCO)
-    SHOW_BOOL(disabl=
e_dco);
-#endif
-    SHOW_STR(lladdr);
-    SHOW_INT(topology);
-    SHOW_S=
TR(ifconfig_local);
-    SHOW_STR(ifconfig_remote_netmask);
-    SHOW_BOOL(=
ifconfig_noexec);
-    SHOW_BOOL(ifconfig_nowarn);
-    SHOW_STR(ifconfig_i=
pv6_local);
-    SHOW_INT(ifconfig_ipv6_netbits);
-    SHOW_STR(ifconfig_ip=
v6_remote);
-
-    SHOW_INT(shaper);
-    SHOW_INT(mtu_test);
-
-    SHOW_B=
OOL(mlock);
-
-    SHOW_INT(keepalive_ping);
-    SHOW_INT(keepalive_timeou=
t);
-    SHOW_INT(inactivity_timeout);
-    SHOW_INT(session_timeout);
-   =
 SHOW_INT64(inactivity_minimum_bytes);
-    SHOW_INT(ping_send_timeout);
- =
   SHOW_INT(ping_rec_timeout);
-    SHOW_INT(ping_rec_timeout_action);
-   =
 SHOW_BOOL(ping_timer_remote);
-    SHOW_INT(remap_sigusr1);
-    SHOW_BOOL=
(persist_tun);
-    SHOW_BOOL(persist_local_ip);
-    SHOW_BOOL(persist_rem=
ote_ip);
-
-#if PASSTOS_CAPABILITY
-    SHOW_BOOL(passtos);
-#endif
-
-    =
SHOW_INT(resolve_retry_seconds);
-    SHOW_BOOL(resolve_in_advance);
-
-   =
 SHOW_STR(username);
-    SHOW_STR(groupname);
-    SHOW_STR(chroot_dir);
-=
    SHOW_STR(cd_dir);
-#ifdef ENABLE_SELINUX
-    SHOW_STR(selinux_context)=
;
-#endif
-    SHOW_STR(writepid);
-    SHOW_STR(up_script);
-    SHOW_STR(=
down_script);
-    SHOW_BOOL(down_pre);
-    SHOW_BOOL(up_restart);
-    SH=
OW_BOOL(up_delay);
-    SHOW_BOOL(daemon);
-    SHOW_BOOL(log);
-    SHOW_B=
OOL(suppress_timestamps);
-    SHOW_BOOL(machine_readable_output);
-    SHO=
W_INT(nice);
-    SHOW_INT(verbosity);
-    SHOW_INT(mute);
-#ifdef ENABLE_=
DEBUG
-    SHOW_INT(gremlin);
-#endif
-    SHOW_STR(status_file);
-    SHOW=
_INT(status_file_version);
-    SHOW_INT(status_file_update_freq);
-
-    S=
HOW_BOOL(occ);
-    SHOW_INT(rcvbuf);
-    SHOW_INT(sndbuf);
-#if defined(T=
ARGET_LINUX)
-    SHOW_INT(mark);
-#endif
-    SHOW_INT(sockflags);
-
-    =
SHOW_INT(comp=2Ealg);
-    SHOW_INT(comp=2Eflags);
-
-    SHOW_STR(route_sc=
ript);
-    SHOW_STR(route_default_gateway);
-    SHOW_INT(route_default_me=
tric);
-    SHOW_INT(route_default_table_id);
-    SHOW_BOOL(route_noexec);=

-    SHOW_INT(route_delay);
-    SHOW_INT(route_delay_window);
-    SHOW_B=
OOL(route_delay_defined);
-    SHOW_BOOL(route_nopull);
-    SHOW_BOOL(rout=
e_gateway_via_dhcp);
-    SHOW_BOOL(allow_pull_fqdn);
-    show_pull_filter=
_list(o->pull_filter_list);
-
-    if (o->routes)
-    {
-        print_rou=
te_options(o->routes, D_SHOW_PARMS);
-    }
-
-    if (o->client_nat)
-    =
{
-        print_client_nat_list(o->client_nat, D_SHOW_PARMS);
-    }
-
-  =
  show_dns_options(&o->dns_options);
-
-#ifdef ENABLE_MANAGEMENT
-    SHOW_=
STR(management_addr);
-    SHOW_STR(management_port);
-    SHOW_STR(managem=
ent_user_pass);
-    SHOW_INT(management_log_history_cache);
-    SHOW_INT(=
management_echo_buffer_size);
-    SHOW_STR(management_client_user);
-    S=
HOW_STR(management_client_group);
-    SHOW_INT(management_flags);
-#endif
=
-#ifdef ENABLE_PLUGIN
-    if (o->plugin_list)
-    {
-        plugin_optio=
n_list_print(o->plugin_list, D_SHOW_PARMS);
-    }
-#endif
-
-    SHOW_STR_=
INLINE(shared_secret_file);
-    SHOW_PARM(key_direction, keydirection2asci=
i(o->key_direction, false, true), "%s");
-    SHOW_STR(ciphername);
-    SH=
OW_STR(ncp_ciphers);
-    SHOW_STR(authname);
-#ifndef ENABLE_CRYPTO_MBEDTL=
S
-    SHOW_BOOL(engine);
-#endif /* ENABLE_CRYPTO_MBEDTLS */
-    SHOW_BOO=
L(mute_replay_warnings);
-    SHOW_INT(replay_window);
-    SHOW_INT(replay=
_time);
-    SHOW_STR(packet_id_file);
-    SHOW_BOOL(test_crypto);
-
-    =
SHOW_BOOL(tls_server);
-    SHOW_BOOL(tls_client);
-    SHOW_STR_INLINE(ca_=
file);
-    SHOW_STR(ca_path);
-    SHOW_STR_INLINE(dh_file);
-    if ((o->=
management_flags & MF_EXTERNAL_CERT))
-    {
-        SHOW_PARM("cert_file"=
, "EXTERNAL_CERT", "%s");
-    }
-    else
-    {
-        SHOW_STR_INLINE(=
cert_file);
-    }
-    SHOW_STR_INLINE(extra_certs_file);
-
-    if ((o->m=
anagement_flags & MF_EXTERNAL_KEY))
-    {
-        SHOW_PARM("priv_key_fil=
e", "EXTERNAL_PRIVATE_KEY", "%s");
-    }
-    else
-    {
-        SHOW_ST=
R_INLINE(priv_key_file);
-    }
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    SHOW_ST=
R_INLINE(pkcs12_file);
-#endif
-#ifdef ENABLE_CRYPTOAPI
-    SHOW_STR(crypt=
oapi_cert);
-#endif
-    SHOW_STR(cipher_list);
-    SHOW_STR(cipher_list_t=
ls13);
-    SHOW_STR(tls_cert_profile);
-    SHOW_STR(tls_verify);
-    SHO=
W_STR(tls_export_peer_cert_dir);
-    SHOW_INT(verify_x509_type);
-    SHOW=
_STR(verify_x509_name);
-    SHOW_STR_INLINE(crl_file);
-    SHOW_INT(ns_ce=
rt_type);
-    {
-        int i;
-        for (i =3D 0; i < MAX_PARMS; i++)=

-        {
-            SHOW_INT(remote_cert_ku[i]);
-        }
-    }
-  =
  SHOW_STR(remote_cert_eku);
-    if (o->verify_hash)
-    {
-        SHOW_=
INT(verify_hash_algo);
-        SHOW_INT(verify_hash_depth);
-        struc=
t gc_arena gc =3D gc_new();
-        const struct verify_hash_list *hl =3D =
o->verify_hash;
-        int digest_len =3D
-            (o->verify_hash_al=
go =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGEST_LENGTH;
-        whi=
le (hl)
-        {
-            char *s =3D format_hex_ex(hl->hash, digest_=
len, 0, 1, ":", &gc);
-            SHOW_PARM(verify_hash, s, "%s");
-      =
      hl =3D hl->next;
-        }
-        gc_free(&gc);
-    }
-    SHOW_I=
NT(ssl_flags);
-
-    SHOW_INT(tls_timeout);
-
-    SHOW_INT64(renegotiate_=
bytes);
-    SHOW_INT64(renegotiate_packets);
-    SHOW_INT(renegotiate_sec=
onds);
-
-    SHOW_INT(handshake_window);
-    SHOW_INT(transition_window);=

-
-    SHOW_BOOL(single_session);
-    SHOW_BOOL(push_peer_info);
-    SHO=
W_BOOL(tls_exit);
-
-    SHOW_STR(tls_crypt_v2_metadata);
-
-#ifdef ENABLE_=
PKCS11
-    {
-        int i;
-        for (i =3D 0; i < MAX_PARMS && o->pk=
cs11_providers[i] !=3D NULL; i++)
-        {
-            SHOW_PARM(pkcs11_=
providers, o->pkcs11_providers[i], "%s");
-        }
-    }
-    {
-       =
 int i;
-        for (i =3D 0; i < MAX_PARMS; i++)
-        {
-            =
SHOW_PARM(pkcs11_protected_authentication,
-                      o->pkcs11=
_protected_authentication[i] ? "ENABLED" : "DISABLED", "%s");
-        }
- =
   }
-    {
-        int i;
-        for (i =3D 0; i < MAX_PARMS; i++)
-   =
     {
-            SHOW_PARM(pkcs11_private_mode, o->pkcs11_private_mode[i=
], "%08x");
-        }
-    }
-    {
-        int i;
-        for (i =3D 0;=
 i < MAX_PARMS; i++)
-        {
-            SHOW_PARM(pkcs11_cert_private,=
 o->pkcs11_cert_private[i] ? "ENABLED" : "DISABLED",
-                     =
 "%s");
-        }
-    }
-    SHOW_INT(pkcs11_pin_cache_period);
-    SHOW=
_STR(pkcs11_id);
-    SHOW_BOOL(pkcs11_id_management);
-#endif /* ENABLE_PK=
CS11 */
-
-    show_p2mp_parms(o);
-
-#ifdef _WIN32
-    SHOW_BOOL(show_net=
_up);
-    SHOW_INT(route_method);
-    SHOW_BOOL(block_outside_dns);
-    =
show_tuntap_options(&o->tuntap_options);
-#endif
-#endif /* ifndef ENABLE_S=
MALL */
-}
-
-#undef SHOW_PARM
-#undef SHOW_STR
-#undef SHOW_INT
-#undef SH=
OW_BOOL
-
 #ifdef ENABLE_MANAGEMENT
 
 static struct http_proxy_options *
d=
iff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 30a146f=
=2E=2Ed42773f 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/option=
s=2Eh
@@ -901,8 +901,6 @@
 
 void setenv_settings(struct env_set *es, const=
 struct options *o);
 
-void show_settings(const struct options *o);
-
 boo=
l string_defined_equal(const char *s1, const char *s2);
 
 const char *opti=
ons_string_version(const char *s, struct gc_arena *gc);
diff --git a/src/op=
envpn/options_show=2Ec b/src/openvpn/options_show=2Ec
new file mode 100644
=
index 0000000=2E=2E34c00df
--- /dev/null
+++ b/src/openvpn/options_show=2Ec=

@@ -0,0 +1,631 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP=
 networks
+ *             over a single UDP port, with support for SSL/TLS-=
based
+ *             session authentication and key exchange,
+ *         =
    packet encryption, packet authentication, and
+ *             packet co=
mpression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2E=
net>
+ *
+ *  This program is free software; you can redistribute it and/or=
 modify
+ *  it under the terms of the GNU General Public License version 2=

+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program=
 is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WA=
RRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNES=
S FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for =
more details=2E
+ *
+ *  You should have received a copy of the GNU General=
 Public License along
+ *  with this program; if not, see <https://www=2Egn=
u=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+=
#endif
+
+#ifndef ENABLE_SMALL
+
+#include "syshead=2Eh"
+
+#include "crypt=
o=2Eh"
+#include "error=2Eh"
+#include "options=2Eh"
+
+static const char *=

+pull_filter_type_name(int type)
+{
+    if (type =3D=3D PUF_TYPE_ACCEPT)
=
+    {
+        return "accept";
+    }
+    if (type =3D=3D PUF_TYPE_IGNOR=
E)
+    {
+        return "ignore";
+    }
+    if (type =3D=3D PUF_TYPE_RE=
JECT)
+    {
+        return "reject";
+    }
+    else
+    {
+        ret=
urn "???";
+    }
+}
+
+#define SHOW_PARM(name, value, format) msg(D_SHOW_P=
ARMS, "  " #name " =3D " format, (value))
+#define SHOW_STR(var)           =
       SHOW_PARM(var, (o->var ? o->var : "[UNDEF]"), "'%s'")
+#define SHOW_=
STR_INLINE(var) \
+    SHOW_PARM(var, o->var##_inline ? "[INLINE]" : (o->va=
r ? o->var : "[UNDEF]"), "'%s'")
+#define SHOW_INT(var)      SHOW_PARM(var,=
 o->var, "%d")
+#define SHOW_UINT(var)     SHOW_PARM(var, o->var, "%u")
+#d=
efine SHOW_INT64(var)    SHOW_PARM(var, o->var, "%" PRIi64)
+#define SHOW_U=
NSIGNED(var) SHOW_PARM(var, o->var, "0x%08x")
+#define SHOW_BOOL(var)     S=
HOW_PARM(var, (o->var ? "ENABLED" : "DISABLED"), "%s");
+
+#ifdef _WIN32
+
=
+static void
+show_dhcp_option_list(const char *name, const char *const *ar=
ray, unsigned int len)
+{
+    for (unsigned int i =3D 0; i < len; ++i)
+  =
  {
+        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, array[i]);
+    =
}
+}
+
+static void
+show_dhcp_option_addrs(const char *name, const in_addr=
_t *array, unsigned int len)
+{
+    struct gc_arena gc =3D gc_new();
+    =
for (unsigned int i =3D 0; i < len; ++i)
+    {
+        msg(D_SHOW_PARMS, =
"  %s[%u] =3D %s", name, i, print_in_addr_t(array[i], 0, &gc));
+    }
+   =
 gc_free(&gc);
+}
+
+static void
+show_tuntap_options(const struct tuntap_o=
ptions *o)
+{
+    SHOW_BOOL(ip_win32_defined);
+    SHOW_INT(ip_win32_type=
);
+    SHOW_INT(dhcp_masq_offset);
+    SHOW_INT(dhcp_lease_time);
+    SH=
OW_INT(tap_sleep);
+    SHOW_UNSIGNED(dhcp_options);
+    SHOW_BOOL(dhcp_re=
new);
+    SHOW_BOOL(dhcp_pre_release);
+    SHOW_STR(domain);
+    SHOW_ST=
R(netbios_scope);
+    SHOW_UNSIGNED(netbios_node_type);
+    SHOW_BOOL(dis=
able_nbt);
+
+    show_dhcp_option_addrs("DNS", o->dns, o->dns_len);
+    s=
how_dhcp_option_addrs("WINS", o->wins, o->wins_len);
+    show_dhcp_option_=
addrs("NTP", o->ntp, o->ntp_len);
+    show_dhcp_option_addrs("NBDD", o->nb=
dd, o->nbdd_len);
+    show_dhcp_option_list("DOMAIN-SEARCH", o->domain_sea=
rch_list, o->domain_search_list_len);
+}
+#endif /* ifdef _WIN32 */
+
+stat=
ic const char *
+print_vlan_accept(enum vlan_acceptable_frames mode)
+{
+  =
  switch (mode)
+    {
+        case VLAN_ONLY_TAGGED:
+            return =
"tagged";
+
+        case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
+            retu=
rn "untagged";
+
+        case VLAN_ALL:
+            return "all";
+    }
=
+    return NULL;
+}
+
+static void
+show_p2mp_parms(const struct options *=
o)
+{
+    struct gc_arena gc =3D gc_new();
+
+    msg(D_SHOW_PARMS, "  ser=
ver_network =3D %s", print_in_addr_t(o->server_network, 0, &gc));
+    msg(=
D_SHOW_PARMS, "  server_netmask =3D %s", print_in_addr_t(o->server_netmask,=
 0, &gc));
+    msg(D_SHOW_PARMS, "  server_network_ipv6 =3D %s", print_in6=
_addr(o->server_network_ipv6, 0, &gc));
+    SHOW_INT(server_netbits_ipv6);=

+    msg(D_SHOW_PARMS, "  server_bridge_ip =3D %s", print_in_addr_t(o->ser=
ver_bridge_ip, 0, &gc));
+    msg(D_SHOW_PARMS, "  server_bridge_netmask =
=3D %s",
+        print_in_addr_t(o->server_bridge_netmask, 0, &gc));
+    =
msg(D_SHOW_PARMS, "  server_bridge_pool_start =3D %s",
+        print_in_ad=
dr_t(o->server_bridge_pool_start, 0, &gc));
+    msg(D_SHOW_PARMS, "  serve=
r_bridge_pool_end =3D %s",
+        print_in_addr_t(o->server_bridge_pool_e=
nd, 0, &gc));
+    if (o->push_list=2Ehead)
+    {
+        const struct pu=
sh_entry *e =3D o->push_list=2Ehead;
+        while (e)
+        {
+       =
     if (e->enable)
+            {
+                msg(D_SHOW_PARMS, "  pu=
sh_entry =3D '%s'", e->option);
+            }
+            e =3D e->next;
=
+        }
+    }
+    SHOW_BOOL(ifconfig_pool_defined);
+    msg(D_SHOW_PA=
RMS, "  ifconfig_pool_start =3D %s",
+        print_in_addr_t(o->ifconfig_p=
ool_start, 0, &gc));
+    msg(D_SHOW_PARMS, "  ifconfig_pool_end =3D %s", p=
rint_in_addr_t(o->ifconfig_pool_end, 0, &gc));
+    msg(D_SHOW_PARMS, "  if=
config_pool_netmask =3D %s",
+        print_in_addr_t(o->ifconfig_pool_netm=
ask, 0, &gc));
+    SHOW_STR(ifconfig_pool_persist_filename);
+    SHOW_INT=
(ifconfig_pool_persist_refresh_freq);
+    SHOW_BOOL(ifconfig_ipv6_pool_def=
ined);
+    msg(D_SHOW_PARMS, "  ifconfig_ipv6_pool_base =3D %s",
+        =
print_in6_addr(o->ifconfig_ipv6_pool_base, 0, &gc));
+    SHOW_INT(ifconfig=
_ipv6_pool_netbits);
+    SHOW_INT(n_bcast_buf);
+    SHOW_INT(tcp_queue_li=
mit);
+    SHOW_INT(real_hash_size);
+    SHOW_INT(virtual_hash_size);
+   =
 SHOW_STR(client_connect_script);
+    SHOW_STR(learn_address_script);
+   =
 SHOW_STR(client_disconnect_script);
+    SHOW_STR(client_crresponse_script=
);
+    SHOW_STR(client_config_dir);
+    SHOW_BOOL(ccd_exclusive);
+    SH=
OW_STR(tmp_dir);
+    SHOW_BOOL(push_ifconfig_defined);
+    msg(D_SHOW_PAR=
MS, "  push_ifconfig_local =3D %s",
+        print_in_addr_t(o->push_ifconf=
ig_local, 0, &gc));
+    msg(D_SHOW_PARMS, "  push_ifconfig_remote_netmask =
=3D %s",
+        print_in_addr_t(o->push_ifconfig_remote_netmask, 0, &gc))=
;
+    SHOW_BOOL(push_ifconfig_ipv6_defined);
+    msg(D_SHOW_PARMS, "  pus=
h_ifconfig_ipv6_local =3D %s/%d",
+        print_in6_addr(o->push_ifconfig_=
ipv6_local, 0, &gc), o->push_ifconfig_ipv6_netbits);
+    msg(D_SHOW_PARMS,=
 "  push_ifconfig_ipv6_remote =3D %s",
+        print_in6_addr(o->push_ifco=
nfig_ipv6_remote, 0, &gc));
+    SHOW_BOOL(enable_c2c);
+    SHOW_BOOL(dupl=
icate_cn);
+    SHOW_INT(cf_max);
+    SHOW_INT(cf_per);
+    SHOW_INT(cf_i=
nitial_max);
+    SHOW_INT(cf_initial_per);
+    SHOW_UINT(max_clients);
+ =
   SHOW_INT(max_routes_per_client);
+    SHOW_STR(auth_user_pass_verify_scr=
ipt);
+    SHOW_BOOL(auth_user_pass_verify_script_via_file);
+    SHOW_BOOL=
(auth_token_generate);
+    SHOW_BOOL(force_key_material_export);
+    SHOW=
_INT(auth_token_lifetime);
+    SHOW_STR_INLINE(auth_token_secret_file);
+#=
if PORT_SHARE
+    SHOW_STR(port_share_host);
+    SHOW_STR(port_share_port=
);
+#endif
+    SHOW_BOOL(vlan_tagging);
+    msg(D_SHOW_PARMS, "  vlan_acc=
ept =3D %s", print_vlan_accept(o->vlan_accept));
+    SHOW_INT(vlan_pvid);
=
+
+    SHOW_BOOL(client);
+    SHOW_BOOL(pull);
+    SHOW_STR_INLINE(auth_u=
ser_pass_file);
+
+    gc_free(&gc);
+}
+
+static void
+show_http_proxy_opt=
ions(const struct http_proxy_options *o)
+{
+    int i;
+    msg(D_SHOW_PAR=
MS, "BEGIN http_proxy");
+    SHOW_STR(server);
+    SHOW_STR(port);
+    S=
HOW_STR(auth_method_string);
+    SHOW_STR(auth_file);
+    SHOW_STR(auth_f=
ile_up);
+    SHOW_BOOL(inline_creds);
+    SHOW_BOOL(nocache);
+    SHOW_S=
TR(http_version);
+    SHOW_STR(user_agent);
+    for (i =3D 0; i < MAX_CUS=
TOM_HTTP_HEADER && o->custom_headers[i]=2Ename; i++)
+    {
+        if (o-=
>custom_headers[i]=2Econtent)
+        {
+            msg(D_SHOW_PARMS, "  =
custom_header[%d] =3D %s: %s", i, o->custom_headers[i]=2Ename,
+           =
     o->custom_headers[i]=2Econtent);
+        }
+        else
+        {
+=
            msg(D_SHOW_PARMS, "  custom_header[%d] =3D %s", i, o->custom_he=
aders[i]=2Ename);
+        }
+    }
+    msg(D_SHOW_PARMS, "END http_proxy"=
);
+}
+
+static void
+show_connection_entry(const struct connection_entry *=
o)
+{
+    /* Display the global proto only in client mode or with no '--lo=
cal'*/
+    if (o->local_list->len =3D=3D 1)
+    {
+        msg(D_SHOW_PAR=
MS, "  proto =3D %s", proto2ascii(o->proto, o->af, false));
+    }
+
+    m=
sg(D_SHOW_PARMS, "  Local Sockets:");
+    for (int i =3D 0; i < o->local_l=
ist->len; i++)
+    {
+        msg(D_SHOW_PARMS, "    [%s]:%s-%s", o->local=
_list->array[i]->local,
+            o->local_list->array[i]->port,
+      =
      proto2ascii(o->local_list->array[i]->proto, o->af, false));
+    }
+ =
   SHOW_STR(remote);
+    SHOW_STR(remote_port);
+    SHOW_BOOL(remote_floa=
t);
+    SHOW_BOOL(bind_defined);
+    SHOW_BOOL(bind_local);
+    SHOW_BOO=
L(bind_ipv6_only);
+    SHOW_INT(connect_retry_seconds);
+    SHOW_INT(conn=
ect_timeout);
+
+    if (o->http_proxy_options)
+    {
+        show_http_p=
roxy_options(o->http_proxy_options);
+    }
+    SHOW_STR(socks_proxy_serve=
r);
+    SHOW_STR(socks_proxy_port);
+    SHOW_INT(tun_mtu);
+    SHOW_BOOL=
(tun_mtu_defined);
+    SHOW_INT(link_mtu);
+    SHOW_BOOL(link_mtu_defined=
);
+    SHOW_INT(tun_mtu_extra);
+    SHOW_BOOL(tun_mtu_extra_defined);
+  =
  SHOW_INT(tls_mtu);
+
+    SHOW_INT(mtu_discover_type);
+
+#ifdef ENABLE_F=
RAGMENT
+    SHOW_INT(fragment);
+#endif
+    SHOW_INT(mssfix);
+    SHOW_B=
OOL(mssfix_encap);
+    SHOW_BOOL(mssfix_fixed);
+
+    SHOW_INT(explicit_e=
xit_notification);
+
+    SHOW_STR_INLINE(tls_auth_file);
+    SHOW_PARM(ke=
y_direction, keydirection2ascii(o->key_direction, false, true), "%s");
+   =
 SHOW_STR_INLINE(tls_crypt_file);
+    SHOW_STR_INLINE(tls_crypt_v2_file);
=
+}
+
+
+static void
+show_connection_entries(const struct options *o)
+{
+ =
   if (o->connection_list)
+    {
+        const struct connection_list *l =
=3D o->connection_list;
+        int i;
+        for (i =3D 0; i < l->len; =
++i)
+        {
+            msg(D_SHOW_PARMS, "Connection profiles [%d]:",=
 i);
+            show_connection_entry(l->array[i]);
+        }
+    }
+  =
  else
+    {
+        msg(D_SHOW_PARMS, "Connection profiles [default]:");=

+        show_connection_entry(&o->ce);
+    }
+    msg(D_SHOW_PARMS, "Con=
nection profiles END");
+}
+
+static void
+show_pull_filter_list(const stru=
ct pull_filter_list *l)
+{
+    struct pull_filter *f;
+    if (!l)
+    {
=
+        return;
+    }
+
+    msg(D_SHOW_PARMS, "  Pull filters:");
+    f=
or (f =3D l->head; f; f =3D f->next)
+    {
+        msg(D_SHOW_PARMS, "   =
 %s \"%s\"", pull_filter_type_name(f->type), f->pattern);
+    }
+}
+
+void=

+show_settings(const struct options *o)
+{
+    msg(D_SHOW_PARMS, "Current=
 Parameter Settings:");
+
+    SHOW_STR(config);
+
+    SHOW_INT(mode);
+
+=
#ifdef ENABLE_FEATURE_TUN_PERSIST
+    SHOW_BOOL(persist_config);
+    SHOW=
_INT(persist_mode);
+#endif
+
+    SHOW_BOOL(show_ciphers);
+    SHOW_BOOL(=
show_digests);
+    SHOW_BOOL(show_engines);
+    SHOW_BOOL(genkey);
+    S=
HOW_STR(genkey_filename);
+    SHOW_STR(key_pass_file);
+    SHOW_BOOL(show=
_tls_ciphers);
+
+    SHOW_INT(connect_retry_max);
+    show_connection_ent=
ries(o);
+
+    SHOW_BOOL(remote_random);
+
+    SHOW_STR(ipchange);
+    S=
HOW_STR(dev);
+    SHOW_STR(dev_type);
+    SHOW_STR(dev_node);
+#if define=
d(ENABLE_DCO)
+    SHOW_BOOL(disable_dco);
+#endif
+    SHOW_STR(lladdr);
+=
    SHOW_INT(topology);
+    SHOW_STR(ifconfig_local);
+    SHOW_STR(ifconf=
ig_remote_netmask);
+    SHOW_BOOL(ifconfig_noexec);
+    SHOW_BOOL(ifconfi=
g_nowarn);
+    SHOW_STR(ifconfig_ipv6_local);
+    SHOW_INT(ifconfig_ipv6_=
netbits);
+    SHOW_STR(ifconfig_ipv6_remote);
+
+    SHOW_INT(shaper);
+  =
  SHOW_INT(mtu_test);
+
+    SHOW_BOOL(mlock);
+
+    SHOW_INT(keepalive_pi=
ng);
+    SHOW_INT(keepalive_timeout);
+    SHOW_INT(inactivity_timeout);
+=
    SHOW_INT(session_timeout);
+    SHOW_INT64(inactivity_minimum_bytes);
+=
    SHOW_INT(ping_send_timeout);
+    SHOW_INT(ping_rec_timeout);
+    SHOW=
_INT(ping_rec_timeout_action);
+    SHOW_BOOL(ping_timer_remote);
+    SHOW=
_INT(remap_sigusr1);
+    SHOW_BOOL(persist_tun);
+    SHOW_BOOL(persist_lo=
cal_ip);
+    SHOW_BOOL(persist_remote_ip);
+
+#if PASSTOS_CAPABILITY
+    =
SHOW_BOOL(passtos);
+#endif
+
+    SHOW_INT(resolve_retry_seconds);
+    SH=
OW_BOOL(resolve_in_advance);
+
+    SHOW_STR(username);
+    SHOW_STR(group=
name);
+    SHOW_STR(chroot_dir);
+    SHOW_STR(cd_dir);
+#ifdef ENABLE_SEL=
INUX
+    SHOW_STR(selinux_context);
+#endif
+    SHOW_STR(writepid);
+    =
SHOW_STR(up_script);
+    SHOW_STR(down_script);
+    SHOW_BOOL(down_pre);
=
+    SHOW_BOOL(up_restart);
+    SHOW_BOOL(up_delay);
+    SHOW_BOOL(daemon=
);
+    SHOW_BOOL(log);
+    SHOW_BOOL(suppress_timestamps);
+    SHOW_BOOL=
(machine_readable_output);
+    SHOW_INT(nice);
+    SHOW_INT(verbosity);
+=
    SHOW_INT(mute);
+#ifdef ENABLE_DEBUG
+    SHOW_INT(gremlin);
+#endif
+ =
   SHOW_STR(status_file);
+    SHOW_INT(status_file_version);
+    SHOW_INT=
(status_file_update_freq);
+
+    SHOW_BOOL(occ);
+    SHOW_INT(rcvbuf);
+ =
   SHOW_INT(sndbuf);
+#if defined(TARGET_LINUX)
+    SHOW_INT(mark);
+#endi=
f
+    SHOW_INT(sockflags);
+
+    SHOW_INT(comp=2Ealg);
+    SHOW_INT(comp=
=2Eflags);
+
+    SHOW_STR(route_script);
+    SHOW_STR(route_default_gatew=
ay);
+    SHOW_INT(route_default_metric);
+    SHOW_INT(route_default_table=
_id);
+    SHOW_BOOL(route_noexec);
+    SHOW_INT(route_delay);
+    SHOW_I=
NT(route_delay_window);
+    SHOW_BOOL(route_delay_defined);
+    SHOW_BOOL=
(route_nopull);
+    SHOW_BOOL(route_gateway_via_dhcp);
+    SHOW_BOOL(allo=
w_pull_fqdn);
+    show_pull_filter_list(o->pull_filter_list);
+
+    if (o=
->routes)
+    {
+        print_route_options(o->routes, D_SHOW_PARMS);
+  =
  }
+
+    if (o->client_nat)
+    {
+        print_client_nat_list(o->clie=
nt_nat, D_SHOW_PARMS);
+    }
+
+    show_dns_options(&o->dns_options);
+
+=
#ifdef ENABLE_MANAGEMENT
+    SHOW_STR(management_addr);
+    SHOW_STR(mana=
gement_port);
+    SHOW_STR(management_user_pass);
+    SHOW_INT(management=
_log_history_cache);
+    SHOW_INT(management_echo_buffer_size);
+    SHOW_=
STR(management_client_user);
+    SHOW_STR(management_client_group);
+    S=
HOW_INT(management_flags);
+#endif
+#ifdef ENABLE_PLUGIN
+    if (o->plugin=
_list)
+    {
+        plugin_option_list_print(o->plugin_list, D_SHOW_PARM=
S);
+    }
+#endif
+
+    SHOW_STR_INLINE(shared_secret_file);
+    SHOW_PA=
RM(key_direction, keydirection2ascii(o->key_direction, false, true), "%s");=

+    SHOW_STR(ciphername);
+    SHOW_STR(ncp_ciphers);
+    SHOW_STR(authn=
ame);
+#ifndef ENABLE_CRYPTO_MBEDTLS
+    SHOW_BOOL(engine);
+#endif /* ENA=
BLE_CRYPTO_MBEDTLS */
+    SHOW_BOOL(mute_replay_warnings);
+    SHOW_INT(r=
eplay_window);
+    SHOW_INT(replay_time);
+    SHOW_STR(packet_id_file);
+=
    SHOW_BOOL(test_crypto);
+
+    SHOW_BOOL(tls_server);
+    SHOW_BOOL(tl=
s_client);
+    SHOW_STR_INLINE(ca_file);
+    SHOW_STR(ca_path);
+    SHOW=
_STR_INLINE(dh_file);
+    if ((o->management_flags & MF_EXTERNAL_CERT))
+ =
   {
+        SHOW_PARM("cert_file", "EXTERNAL_CERT", "%s");
+    }
+    el=
se
+    {
+        SHOW_STR_INLINE(cert_file);
+    }
+    SHOW_STR_INLINE(=
extra_certs_file);
+
+    if ((o->management_flags & MF_EXTERNAL_KEY))
+   =
 {
+        SHOW_PARM("priv_key_file", "EXTERNAL_PRIVATE_KEY", "%s");
+    =
}
+    else
+    {
+        SHOW_STR_INLINE(priv_key_file);
+    }
+#ifndef=
 ENABLE_CRYPTO_MBEDTLS
+    SHOW_STR_INLINE(pkcs12_file);
+#endif
+#ifdef E=
NABLE_CRYPTOAPI
+    SHOW_STR(cryptoapi_cert);
+#endif
+    SHOW_STR(cipher=
_list);
+    SHOW_STR(cipher_list_tls13);
+    SHOW_STR(tls_cert_profile);
=
+    SHOW_STR(tls_verify);
+    SHOW_STR(tls_export_peer_cert_dir);
+    SH=
OW_INT(verify_x509_type);
+    SHOW_STR(verify_x509_name);
+    SHOW_STR_IN=
LINE(crl_file);
+    SHOW_INT(ns_cert_type);
+    {
+        int i;
+      =
  for (i =3D 0; i < MAX_PARMS; i++)
+        {
+            SHOW_INT(remote=
_cert_ku[i]);
+        }
+    }
+    SHOW_STR(remote_cert_eku);
+    if (o-=
>verify_hash)
+    {
+        SHOW_INT(verify_hash_algo);
+        SHOW_INT=
(verify_hash_depth);
+        struct gc_arena gc =3D gc_new();
+        con=
st struct verify_hash_list *hl =3D o->verify_hash;
+        int digest_len =
=3D
+            (o->verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH :=
 SHA256_DIGEST_LENGTH;
+        while (hl)
+        {
+            char *s =
=3D format_hex_ex(hl->hash, digest_len, 0, 1, ":", &gc);
+            SHOW_=
PARM(verify_hash, s, "%s");
+            hl =3D hl->next;
+        }
+     =
   gc_free(&gc);
+    }
+    SHOW_INT(ssl_flags);
+
+    SHOW_INT(tls_timeo=
ut);
+
+    SHOW_INT64(renegotiate_bytes);
+    SHOW_INT64(renegotiate_pack=
ets);
+    SHOW_INT(renegotiate_seconds);
+
+    SHOW_INT(handshake_window)=
;
+    SHOW_INT(transition_window);
+
+    SHOW_BOOL(single_session);
+    =
SHOW_BOOL(push_peer_info);
+    SHOW_BOOL(tls_exit);
+
+    SHOW_STR(tls_cr=
ypt_v2_metadata);
+
+#ifdef ENABLE_PKCS11
+    {
+        int i;
+        f=
or (i =3D 0; i < MAX_PARMS && o->pkcs11_providers[i] !=3D NULL; i++)
+     =
   {
+            SHOW_PARM(pkcs11_providers, o->pkcs11_providers[i], "%s")=
;
+        }
+    }
+    {
+        int i;
+        for (i =3D 0; i < MAX_P=
ARMS; i++)
+        {
+            SHOW_PARM(pkcs11_protected_authenticatio=
n,
+                      o->pkcs11_protected_authentication[i] ? "ENABLED"=
 : "DISABLED", "%s");
+        }
+    }
+    {
+        int i;
+        for=
 (i =3D 0; i < MAX_PARMS; i++)
+        {
+            SHOW_PARM(pkcs11_pri=
vate_mode, o->pkcs11_private_mode[i], "%08x");
+        }
+    }
+    {
+  =
      int i;
+        for (i =3D 0; i < MAX_PARMS; i++)
+        {
+       =
     SHOW_PARM(pkcs11_cert_private, o->pkcs11_cert_private[i] ? "ENABLED" :=
 "DISABLED",
+                      "%s");
+        }
+    }
+    SHOW_INT(=
pkcs11_pin_cache_period);
+    SHOW_STR(pkcs11_id);
+    SHOW_BOOL(pkcs11_i=
d_management);
+#endif /* ENABLE_PKCS11 */
+
+    show_p2mp_parms(o);
+
+#i=
fdef _WIN32
+    SHOW_BOOL(show_net_up);
+    SHOW_INT(route_method);
+    =
SHOW_BOOL(block_outside_dns);
+    show_tuntap_options(&o->tuntap_options);=

+#endif
+}
+
+#endif /* ifndef ENABLE_SMALL */
diff --git a/src/openvpn/op=
tions_show=2Eh b/src/openvpn/options_show=2Eh
new file mode 100644
index 00=
00000=2E=2Efb233fc
--- /dev/null
+++ b/src/openvpn/options_show=2Eh
@@ -0,0=
 +1,46 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks=

+ *             over a single UDP port, with support for SSL/TLS-based
+ *=
             session authentication and key exchange,
+ *             packe=
t encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
=
+ *  This program is free software; you can redistribute it and/or modify
+=
 *  it under the terms of the GNU General Public License version 2
+ *  as =
published by the Free Software Foundation=2E
+ *
+ *  This program is distr=
ibuted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more deta=
ils=2E
+ *
+ *  You should have received a copy of the GNU General Public L=
icense along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/l=
icenses/>=2E
+ */
+
+#ifndef OPTIONS_SHOW_H
+#define OPTIONS_SHOW_H
+
+#ifd=
ef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "options=2Eh"
+=

+#ifdef ENABLE_SMALL
+
+static inline void
+show_settings(const struct opt=
ions *o)
+{
+    (void)o;
+}
+
+#else
+
+void show_settings(const struct op=
tions *o);
+
+#endif /* ENABLE_SMALL */
+
+#endif /* OPTIONS_SHOW_H */

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I61762374c141662d596b=
bf88b64ca7f7472b5149
Gerrit-Change-Number: 1772
Gerrit-PatchSet: 3
Gerrit-O=
wner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <=
frank@lichtenheld=2Ecom>

--PfbalsEuivw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">options: Factor out options display code from options=2Ec<br><b=
r>options=2Ec is a huge, unwieldly file=2E So remove some<br>closely relate=
d code that has no direct dependencies<br>with the other functions in the f=
ile=2E<br><br>In this case it is the code that prints out the current<br>co=
nfiguration=2E<br><br>Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<=
br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/openv=
pn=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/o=
penvpn/options_show=2Ec<br>A src/openvpn/options_show=2Eh<br>7 files change=
d, 681 insertions(+), 620 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/72/1772/3</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index ad7de=
6e=2E=2E540992b 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><sp=
an>+++ b/CMakeLists=2Etxt</span><br><span>@@ -527,6 +527,8 @@</span><br><sp=
an>     src/openvpn/options_util=2Ec</span><br><span>     src/openvpn/optio=
ns_util=2Eh</span><br><span>     src/openvpn/options_parse=2Ec</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options_show=2Ec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/opt=
ions_show=2Eh</span><br><span>     src/openvpn/otime=2Ec</span><br><span>  =
   src/openvpn/otime=2Eh</span><br><span>     src/openvpn/ovpn_dco_win=2Eh<=
/span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefi=
le=2Eam</span><br><span>index 1f77384=2E=2E2092e96 100644</span><br><span>-=
-- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=
=2Eam</span><br><span>@@ -108,6 +108,7 @@</span><br><span> 	pkcs11_mbedtls=
=2Ec \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	option=
s=2Ec options=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	options_show=2Ec options_show=2Eh \</span><br><span> 	options_util=2Ec opt=
ions_util=2Eh \</span><br><span> 	options_parse=2Ec \</span><br><span> 	oti=
me=2Ec otime=2Eh \</span><br><span>diff --git a/src/openvpn/openvpn=2Ec b/s=
rc/openvpn/openvpn=2Ec</span><br><span>index 5e1f680=2E=2E24d6bb6 100644</s=
pan><br><span>--- a/src/openvpn/openvpn=2Ec</span><br><span>+++ b/src/openv=
pn/openvpn=2Ec</span><br><span>@@ -30,6 +30,7 @@</span><br><span> #include =
&quot;forward=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</sp=
an><br><span> #include &quot;win32=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;options_show=2Eh&quot;</span><br><s=
pan> #include &quot;platform=2Eh&quot;</span><br><span> </span><br><span> #=
include &quot;memdbg=2Eh&quot;</span><br><span>diff --git a/src/openvpn/opt=
ions=2Ec b/src/openvpn/options=2Ec</span><br><span>index 5e74a41=2E=2E87da3=
44 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++=
 b/src/openvpn/options=2Ec</span><br><span>@@ -931,41 +931,6 @@</span><br><=
span>     gc_free(&amp;o-&gt;dns_options=2Egc);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENAB=
LE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-pull_filter_type_name(int type)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (type =3D=3D PUF_TYPE_ACCEPT)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return &quot;accept&quot;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (type =3D=3D PUF_TYPE_IGNORE)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return &quot;ignore&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (type =3D=3D PUF_TYPE_REJECT)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return &quot;reject&quot;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn &quot;???&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, &q=
uot;  &quot; #name &quot; =3D &quot; format, (value))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define SHOW_STR(var)                  SHOW=
_PARM(var, (o-&gt;var ? o-&gt;var : &quot;[UNDEF]&quot;), &quot;&#39;%s&#39=
;&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_=
STR_INLINE(var) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_PARM(var, o-&gt;var##_inline ? &quot;[INLINE]&quot; : (o-&gt;var ? o-&=
gt;var : &quot;[UNDEF]&quot;), &quot;&#39;%s&#39;&quot;)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define SHOW_INT(var)      SHOW_PARM(var=
, o-&gt;var, &quot;%d&quot;)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define SHOW_UINT(var)     SHOW_PARM(var, o-&gt;var, &quot;%u&quot;)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_INT64(va=
r)    SHOW_PARM(var, o-&gt;var, &quot;%&quot; PRIi64)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define SHOW_UNSIGNED(var) SHOW_PARM(var, o=
-&gt;var, &quot;0x%08x&quot;)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define SHOW_BOOL(var)     SHOW_PARM(var, (o-&gt;var ? &quot;ENABLE=
D&quot; : &quot;DISABLED&quot;), &quot;%s&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif /* ifndef ENABLE_SMALL */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> static void</span><br><span> setenv_con=
nection_entry(struct env_set *es, const struct connection_entry *e, const i=
nt i)</span><br><span> {</span><br><span>@@ -1257,55 +1222,6 @@</span><br><=
span> </span><br><span>     return ret;</span><br><span> }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-show_dhcp_option_list(co=
nst char *name, const char *const *array, unsigned int len)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for (unsigned int i =3D 0; i &lt; len; ++i)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s=
&quot;, name, i, array[i]);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-show_dhcp_option_addrs(const char *name, const in_addr_t *arr=
ay, unsigned int len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    f=
or (unsigned int i =3D 0; i &lt; len; ++i)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s&quot;, name, i, print_=
in_addr_t(array[i], 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-show_tuntap_options(const struct tuntap_options *o)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ip_win32_defined);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ip_win32_type);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(dhcp_masq_of=
fset);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(dh=
cp_lease_time);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SH=
OW_INT(tap_sleep);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_UNSIGNED(dhcp_options);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    SHOW_BOOL(dhcp_renew);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SHOW_BOOL(dhcp_pre_release);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_STR(domain);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_STR(netbios_scope);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_UNSIGNED(netbios_node_type);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(disable_nbt);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    show_dhcp_option_addrs(&quot;DNS&quot;=
, o-&gt;dns, o-&gt;dns_len);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    show_dhcp_option_addrs(&quot;WINS&quot;, o-&gt;wins, o-&gt;wins_=
len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_dhcp_op=
tion_addrs(&quot;NTP&quot;, o-&gt;ntp, o-&gt;ntp_len);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    show_dhcp_option_addrs(&quot;NBDD&quot=
;, o-&gt;nbdd, o-&gt;nbdd_len);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    show_dhcp_option_list(&quot;DOMAIN-SEARCH&quot;, o-&gt;domain=
_search_list, o-&gt;domain_search_list_len);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef E=
NABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif =
/* ifdef _WIN32 */</span><br><span> </span><br><span> static void</span><br=
><span> dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list=
, unsigned int *len, msglvl_t msglevel)</span><br><span>@@ -1348,116 +1264,=
6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-print_vlan_accept(enum vlan_accepta=
ble_frames mode)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (mode)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case VLAN_ONLY_TAGGED:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            return &quot;tagged&qu=
ot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        case VLAN_ONLY_UNTAGGED_OR_PRI=
ORITY:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn &quot;untagged&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case VLAN=
_ALL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retu=
rn &quot;all&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-show_p2mp_parms(const struct options *o)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(D_SHOW_PARMS, &quot;  server_network =3D %s&quot;, print_in_addr_t(o-&gt;=
server_network, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    msg(D_SHOW_PARMS, &quot;  server_netmask =3D %s&quot;, print_in=
_addr_t(o-&gt;server_netmask, 0, &amp;gc));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_network_ipv6 =3D=
 %s&quot;, print_in6_addr(o-&gt;server_network_ipv6, 0, &amp;gc));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(server_netbits_ip=
v6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PA=
RMS, &quot;  server_bridge_ip =3D %s&quot;, print_in_addr_t(o-&gt;server_br=
idge_ip, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg(D_SHOW_PARMS, &quot;  server_bridge_netmask =3D %s&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;=
server_bridge_netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_bridge_pool_start =3D %=
s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print=
_in_addr_t(o-&gt;server_bridge_pool_start, 0, &amp;gc));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_bri=
dge_pool_end =3D %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        print_in_addr_t(o-&gt;server_bridge_pool_end, 0, &amp;gc));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;push_list=
=2Ehead)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct push_ent=
ry *e =3D o-&gt;push_list=2Ehead;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        while (e)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (e-&gt;enable)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            msg(D_SHOW_PARMS, &quot;  push_entry =3D &#39;%s&#39;&quot;, e-=
&gt;option);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e =3D=
 e-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ifconfig_pool_defined);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS,=
 &quot;  ifconfig_pool_start =3D %s&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;ifconfig_pool_start, 0, =
&amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_S=
HOW_PARMS, &quot;  ifconfig_pool_end =3D %s&quot;, print_in_addr_t(o-&gt;if=
config_pool_end, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_netmask =3D %s&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_in_addr_=
t(o-&gt;ifconfig_pool_netmask, 0, &amp;gc));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_STR(ifconfig_pool_persist_filename);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ifconfig_pool_p=
ersist_refresh_freq);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_BOOL(ifconfig_ipv6_pool_defined);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  ifconfig_ipv6_pool_base =
=3D %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
print_in6_addr(o-&gt;ifconfig_ipv6_pool_base, 0, &amp;gc));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ifconfig_ipv6_pool_netbi=
ts);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(n_bc=
ast_buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT=
(tcp_queue_limit);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_INT(real_hash_size);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_INT(virtual_hash_size);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_STR(client_connect_script);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(learn_address_script);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(client_disconnec=
t_script);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_ST=
R(client_crresponse_script);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_STR(client_config_dir);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_BOOL(ccd_exclusive);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_STR(tmp_dir);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_BOOL(push_ifconfig_defined);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  pu=
sh_ifconfig_local =3D %s&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        print_in_addr_t(o-&gt;push_ifconfig_local, 0, &amp;gc));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, =
&quot;  push_ifconfig_remote_netmask =3D %s&quot;,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;push_ifconfig_re=
mote_netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    SHOW_BOOL(push_ifconfig_ipv6_defined);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  push_ifconfig_ipv6=
_local =3D %s/%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        print_in6_addr(o-&gt;push_ifconfig_ipv6_local, 0, &amp;gc), o-&gt=
;push_ifconfig_ipv6_netbits);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    msg(D_SHOW_PARMS, &quot;  push_ifconfig_ipv6_remote =3D %s&quot=
;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_in6_a=
ddr(o-&gt;push_ifconfig_ipv6_remote, 0, &amp;gc));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(enable_c2c);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(duplicate_cn);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(cf_max);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(cf_per);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(cf_initial_max);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(cf_initial_pe=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_UINT(max_=
clients);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT=
(max_routes_per_client);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_STR(auth_user_pass_verify_script);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    SHOW_BOOL(auth_user_pass_verify_script_via_fil=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(auth=
_token_generate);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_BOOL(force_key_material_export);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_INT(auth_token_lifetime);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(auth_token_secret_file);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if PORT_SHARE</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(port_share_host);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(port_sha=
re_port);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(vlan_tagging)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS=
, &quot;  vlan_accept =3D %s&quot;, print_vlan_accept(o-&gt;vlan_accept));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(vlan_pvid=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(client);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(pull);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(auth_user_pass_file)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif =
/* ! ENABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> static void</span><br><span> option_iroute(struct options =
*o, const char *network_str, const char *netmask_str,</span><br><span>     =
          msglvl_t msglevel)</span><br><span>@@ -1502,37 +1308,6 @@</span><=
br><span>     o-&gt;iroutes_ipv6 =3D ir;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMAL=
L</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-show_http_proxy_options(const =
struct http_proxy_options *o)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &=
quot;BEGIN http_proxy&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    SHOW_STR(server);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    SHOW_STR(port);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    SHOW_STR(auth_method_string);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_STR(auth_file);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_STR(auth_file_up);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_BOOL(inline_creds);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(nocache);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(http_version);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(user_agent);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; MAX_=
CUSTOM_HTTP_HEADER &amp;&amp; o-&gt;custom_headers[i]=2Ename; i++)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (o-&gt;custom_headers[i]=2Econtent)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_SHOW_PARMS, &qu=
ot;  custom_header[%d] =3D %s: %s&quot;, i, o-&gt;custom_headers[i]=2Ename,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                o-&gt=
;custom_headers[i]=2Econtent);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_SHOW_P=
ARMS, &quot;  custom_header[%d] =3D %s&quot;, i, o-&gt;custom_headers[i]=2E=
name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;END http_proxy&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef ENABLE_SMALL */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void<=
/span><br><span> options_detach(struct options *o)</span><br><span> {</span=
><br><span>@@ -1580,399 +1355,6 @@</span><br><span>     }</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_connecti=
on_entry(const struct connection_entry *o)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* Display the global proto only in client mode or with no &#39;--loca=
l&#39;*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt=
;local_list-&gt;len =3D=3D 1)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
msg(D_SHOW_PARMS, &quot;  proto =3D %s&quot;, proto2ascii(o-&gt;proto, o-&g=
t;af, false));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  Local Sockets=
:&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int=
 i =3D 0; i &lt; o-&gt;local_list-&gt;len; i++)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(D_SHOW_PARMS, &quot;    [%s]:%s-%s&quot;, o-&gt;local=
_list-&gt;array[i]-&gt;local,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            o-&gt;local_list-&gt;array[i]-&gt;port,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            proto2ascii(o-&gt;local_l=
ist-&gt;array[i]-&gt;proto, o-&gt;af, false));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SHOW_STR(remote);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SHOW_STR(remote_port);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_BOOL(remote_float);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_BOOL(bind_defined);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_BOOL(bind_local);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(bind_ipv6_only);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(connect_retry_second=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(conne=
ct_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;http_proxy_optio=
ns)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        show_http_proxy_options(o-=
&gt;http_proxy_options);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(=
socks_proxy_server);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_STR(socks_proxy_port);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SHOW_INT(tun_mtu);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    SHOW_BOOL(tun_mtu_defined);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_INT(link_mtu);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    SHOW_BOOL(link_mtu_defined);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(tun_mtu_extra);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(tun_mtu_extra_defined=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(tls_mt=
u);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(mtu_discover_type);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef ENABLE_FRAGMENT</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_INT(fragment);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_INT(mssfix);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_BOOL(mssfix_encap);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_BOOL(mssfix_fixed);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_INT(explicit_exit_notification);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    SHOW_STR_INLINE(tls_auth_file);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_PARM(key_direction, keydirection2ascii(o-&gt;k=
ey_direction, false, true), &quot;%s&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(tls_crypt_file);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(tls_crypt_v2_file=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_connection_=
entries(const struct options *o)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o=
-&gt;connection_list)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const st=
ruct connection_list *l =3D o-&gt;connection_list;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; l-&gt;len; ++i)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(D_SHOW_PARMS, &quot;Connec=
tion profiles [%d]:&quot;, i);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            show_connection_entry(l-&gt;array[i]);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_SHOW_=
PARMS, &quot;Connection profiles [default]:&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        show_connection_entry(&amp;o-&gt;ce=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;Connect=
ion profiles END&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-show_pull_filter_list(const struct pull_filter_l=
ist *l)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct pull_filter *f;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!l)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &=
quot;  Pull filters:&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (f =3D l-&gt;head; f; f =3D f-&gt;next)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quot;    %s \&quot;%s\&quot;&qu=
ot;, pull_filter_type_name(f-&gt;type), f-&gt;pattern);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef ENABLE=
_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-show_settings(const struct options *o)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;Current Parameter Settings=
:&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(config);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_INT(mode);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef ENABLE_FEATURE_TUN_PERSIST</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    SHOW_BOOL(persist_config);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    SHOW_INT(persist_mode);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BO=
OL(show_ciphers);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_BOOL(show_digests);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_BOOL(show_engines);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    SHOW_BOOL(genkey);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_STR(genkey_filename);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_STR(key_pass_file);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_BOOL(show_tls_ciphers);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    SHOW_INT(connect_retry_max);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    show_connection_entries(o);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    SHOW_BOOL(remote_random);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_STR(ipchange);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    SHOW_STR(dev);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_STR(dev_type);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_STR(dev_node);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SHOW_BOOL(disable_dco);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_STR(lladdr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_INT(topology);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_STR(ifconfig_local);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    SHOW_STR(ifconfig_remote_netmask);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_BOOL(ifconfig_noexec);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ifconfig_nowarn);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(ifconfig_ipv6_l=
ocal);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(if=
config_ipv6_netbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_STR(ifconfig_ipv6_remote);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHO=
W_INT(shaper);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHO=
W_INT(mtu_test);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(mlock);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_INT(keepalive_ping);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(keepalive_timeout);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(inactivity_time=
out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ses=
sion_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHO=
W_INT64(inactivity_minimum_bytes);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SHOW_INT(ping_send_timeout);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_INT(ping_rec_timeout);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ping_rec_timeout_action);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ping_timer=
_remote);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT=
(remap_sigusr1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_BOOL(persist_tun);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    SHOW_BOOL(persist_local_ip);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    SHOW_BOOL(persist_remote_ip);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if PASSTOS_CAPABILITY</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_BOOL(passtos);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(resolve_retry_sec=
onds);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(r=
esolve_in_advance);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(username);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(groupnam=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(chroo=
t_dir);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(c=
d_dir);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
SELINUX</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(s=
elinux_context);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(writepi=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(up_sc=
ript);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(do=
wn_script);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_B=
OOL(down_pre);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHO=
W_BOOL(up_restart);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  SHOW_BOOL(up_delay);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    SHOW_BOOL(daemon);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_BOOL(log);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_BOOL(suppress_timestamps);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_BOOL(machine_readable_output);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(nice);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(verbosity);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(mute);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(gremlin);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_STR(status_file);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_INT(status_file_version);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(status_file_update_freq);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(occ);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(rcvbuf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(sndbuf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(mark);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    SHOW_INT(sockflags);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    SHOW_INT(comp=2Ealg);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_INT(comp=2Eflags);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_S=
TR(route_script);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_STR(route_default_gateway);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_INT(route_default_metric);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    SHOW_INT(route_default_table_id);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(route_noexec);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(route_delay);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(route_del=
ay_window);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_B=
OOL(route_delay_defined);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_BOOL(route_nopull);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_BOOL(route_gateway_via_dhcp);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_BOOL(allow_pull_fqdn);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    show_pull_filter_list(o-&gt;pull_=
filter_list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;routes)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        print_route_options(o-&gt;routes, D=
_SHOW_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;client_nat)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        print_client_nat_list(o-&gt;client_nat, D_SHOW_=
PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    show_dns_options(&amp;o-&gt;dns_options);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_addr);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_port);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_u=
ser_pass);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_IN=
T(management_log_history_cache);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_INT(management_echo_buffer_size);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_client_user);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_cli=
ent_group);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_I=
NT(management_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_P=
LUGIN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;pl=
ugin_list)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        plugin_option_list_=
print(o-&gt;plugin_list, D_SHOW_PARMS);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(shared_secret_=
file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_PARM(k=
ey_direction, keydirection2ascii(o-&gt;key_direction, false, true), &quot;%=
s&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR=
(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_STR(ncp_ciphers);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_STR(authname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_BOOL(engine);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_BOOL(mute_replay_warnings);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(replay_window);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(replay_time);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(packet_id_file=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(test_=
crypto);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(tls_server);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(tls_client);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(ca_f=
ile);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(ca_=
path);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_IN=
LINE(dh_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
((o-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        SHOW_PARM(&quot;cert_file&quot;, &quot;EXTERNAL_CERT&qu=
ot;, &quot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        SHOW_STR_INLINE(cert_file);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(extra_certs_file);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if ((o-&gt;management_flags &amp; MF_EXTERN=
AL_KEY))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        SHOW_PARM(&quot;priv_=
key_file&quot;, &quot;EXTERNAL_PRIVATE_KEY&quot;, &quot;%s&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        SHOW_STR_INLINE(priv_key_file);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    SHOW_STR_INLINE(pkcs12_file);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SHOW_STR(cryptoapi_cert);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_STR(cipher_list);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_STR(cipher_list_tls13);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_STR(tls_cert_profile);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_STR(tls_verify);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(tls_export_peer_cert_dir);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(verify_x509_=
type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(ve=
rify_x509_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_STR_INLINE(crl_file);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_INT(ns_cert_type);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (=
i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          SHOW_INT(remote_cert_ku[i]);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_ST=
R(remote_cert_eku);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (o-&gt;verify_hash)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        SHOW_=
INT(verify_hash_algo);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        SHOW_INT(verify_hash_depth);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        const struct verify_hash_list *h=
l =3D o-&gt;verify_hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int digest_len =3D</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            (o-&gt;verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LE=
NGTH : SHA256_DIGEST_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        while (hl)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    char *s =3D format_hex_ex(hl-&gt;hash, digest_len, 0, 1, &quot;:&quot;,=
 &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 SHOW_PARM(verify_hash, s, &quot;%s&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            hl =3D hl-&gt;next;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    SHOW_INT(ssl_flags);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_I=
NT(tls_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT64(renegotiate=
_bytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT6=
4(renegotiate_packets);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_INT(renegotiate_seconds);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SH=
OW_INT(handshake_window);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_INT(transition_window);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SH=
OW_BOOL(single_session);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_BOOL(push_peer_info);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    SHOW_BOOL(tls_exit);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SH=
OW_STR(tls_crypt_v2_metadata);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABL=
E_PKCS11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; MAX_PAR=
MS &amp;&amp; o-&gt;pkcs11_providers[i] !=3D NULL; i++)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            SHOW_PARM(pkcs11_providers, o-&gt;pkcs11_=
providers[i], &quot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; MAX_PARMS; i+=
+)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            SHOW_PARM(pkcs11_pr=
otected_authentication,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                      o-&gt;pkcs11_protected_authentication[i] ? &quot;EN=
ABLED&quot; : &quot;DISABLED&quot;, &quot;%s&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int =
i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D =
0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    SHOW_PARM(pkcs11_private_mode, o-&gt;pkcs11_private_mode[i], &quot;%08x=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            SHOW_PARM(pkcs11_cert_private, o-&gt;pkcs=
11_cert_private[i] ? &quot;ENABLED&quot; : &quot;DISABLED&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                      &quot;%s&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(pkcs11_pin_cache_period);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(pkcs11_id);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(pkcs11_id=
_management);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* ENABLE_PKCS11 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_p2mp_parms(o);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_BOOL(show_net_up);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(route_method);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(block_outside_dns);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_tuntap_options(&=
amp;o-&gt;tuntap_options);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* =
ifndef ENABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#undef SHOW_PARM</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#undef SHOW_STR</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#undef SHOW_INT</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#undef SHOW_BOOL</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> =
</span><br><span> static struct http_proxy_options *</span><br><span>diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>in=
dex 30a146f=2E=2Ed42773f 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -901,=
8 +901,6 @@</span><br><span> </span><br><span> void setenv_settings(struct =
env_set *es, const struct options *o);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void show_settings(const struct options =
*o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 bool string_defined_equal(const char *s1, const char *s2);</span><br><span=
> </span><br><span> const char *options_string_version(const char *s, struc=
t gc_arena *gc);</span><br><span>diff --git a/src/openvpn/options_show=2Ec =
b/src/openvpn/options_show=2Ec</span><br><span>new file mode 100644</span><=
br><span>index 0000000=2E=2E34c00df</span><br><span>--- /dev/null</span><br=
><span>+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ -0,0 +1,631 @@=
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
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HA=
VE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+pull_filter_type_name(int type)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (type =3D=3D PUF_TYPE_ACCEPT)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return &quot;accept&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (type =3D=3D PUF_TYPE_IGNORE)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return &quot;ignore&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (type =3D=3D PUF_TYPE_REJE=
CT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;reject&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return &quot;???&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SHOW_PARM=
(name, value, format) msg(D_SHOW_PARMS, &quot;  &quot; #name &quot; =3D &qu=
ot; format, (value))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define SHOW_STR(var)                  SHOW_PARM(var, (o-&gt;var ? o-&gt;v=
ar : &quot;[UNDEF]&quot;), &quot;&#39;%s&#39;&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SHOW_STR_INLINE(var) \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_PARM(var, o-&gt;var##=
_inline ? &quot;[INLINE]&quot; : (o-&gt;var ? o-&gt;var : &quot;[UNDEF]&quo=
t;), &quot;&#39;%s&#39;&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define SHOW_INT(var)      SHOW_PARM(var, o-&gt;var, &quot;%d&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SHOW_UI=
NT(var)     SHOW_PARM(var, o-&gt;var, &quot;%u&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SHOW_INT64(var)    SHOW_PARM(var,=
 o-&gt;var, &quot;%&quot; PRIi64)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define SHOW_UNSIGNED(var) SHOW_PARM(var, o-&gt;var, &quot;0x=
%08x&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
SHOW_BOOL(var)     SHOW_PARM(var, (o-&gt;var ? &quot;ENABLED&quot; : &quot;=
DISABLED&quot;), &quot;%s&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+show_dhcp_option_list(const char *name=
, const char *const *array, unsigned int len)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (unsigned int i =3D 0; i &lt; len; ++i)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s&quot;=
, name, i, array[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+show_dhcp_option_addrs(const char *name, const in_addr_t =
*array, unsigned int len)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (unsigned int i =3D 0; i &lt; len; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s&quot;, =
name, i, print_in_addr_t(array[i], 0, &amp;gc));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+show_tuntap_options(const st=
ruct tuntap_options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(=
ip_win32_defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   SHOW_INT(ip_win32_type);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_INT(dhcp_masq_offset);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_INT(dhcp_lease_time);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    SHOW_INT(tap_sleep);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_UNSIGNED(dhcp_options);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(dhcp_renew);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(dhcp_=
pre_release);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_STR(domain);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_STR(netbios_scope);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_UNSIGNED(netbios_node_type);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    SHOW_BOOL(disable_nbt);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    show_dhcp_option_addrs(&quot;DNS&quot;, o-&gt;dns, o-&gt;dn=
s_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    show_dhc=
p_option_addrs(&quot;WINS&quot;, o-&gt;wins, o-&gt;wins_len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    show_dhcp_option_addrs(&quot;=
NTP&quot;, o-&gt;ntp, o-&gt;ntp_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    show_dhcp_option_addrs(&quot;NBDD&quot;, o-&gt;nbdd, =
o-&gt;nbdd_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 show_dhcp_option_list(&quot;DOMAIN-SEARCH&quot;, o-&gt;domain_search_list,=
 o-&gt;domain_search_list_len);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
 /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_vlan_accept(e=
num vlan_acceptable_frames mode)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
witch (mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case VLAN_ONL=
Y_TAGGED:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return &quot;tagged&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
se VLAN_ONLY_UNTAGGED_OR_PRIORITY:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return &quot;untagged&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        case VLAN_ALL:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return &quot;all&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+show_p2mp_parms(const stru=
ct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &qu=
ot;  server_network =3D %s&quot;, print_in_addr_t(o-&gt;server_network, 0, =
&amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_SHOW_PARMS, &quot;  server_netmask =3D %s&quot;, print_in_addr_t(o-&gt;ser=
ver_netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg(D_SHOW_PARMS, &quot;  server_network_ipv6 =3D %s&quot;, prin=
t_in6_addr(o-&gt;server_network_ipv6, 0, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(server_netbits_ipv6);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quo=
t;  server_bridge_ip =3D %s&quot;, print_in_addr_t(o-&gt;server_bridge_ip, =
0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms=
g(D_SHOW_PARMS, &quot;  server_bridge_netmask =3D %s&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        print_in_addr_t(o-&gt;serve=
r_bridge_netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    msg(D_SHOW_PARMS, &quot;  server_bridge_pool_start =3D %s&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_=
in_addr_t(o-&gt;server_bridge_pool_start, 0, &amp;gc));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  server_br=
idge_pool_end =3D %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        print_in_addr_t(o-&gt;server_bridge_pool_end, 0, &amp;gc));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;push_=
list=2Ehead)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct =
push_entry *e =3D o-&gt;push_list=2Ehead;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        while (e)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (e-&gt;enable)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                msg(D_SHOW_PARMS, &quot;  push_entry =3D &#39=
;%s&#39;&quot;, e-&gt;option);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            e =3D e-&gt;next;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
BOOL(ifconfig_pool_defined);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_start =3D %s&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_in_addr_=
t(o-&gt;ifconfig_pool_start, 0, &amp;gc));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_end =3D =
%s&quot;, print_in_addr_t(o-&gt;ifconfig_pool_end, 0, &amp;gc));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  =
ifconfig_pool_netmask =3D %s&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        print_in_addr_t(o-&gt;ifconfig_pool_netmask, 0, &am=
p;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR=
(ifconfig_pool_persist_filename);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_INT(ifconfig_pool_persist_refresh_freq);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(ifconfig_ipv6_poo=
l_defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_SHOW_PARMS, &quot;  ifconfig_ipv6_pool_base =3D %s&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        print_in6_addr(o-&gt;ifconf=
ig_ipv6_pool_base, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SHOW_INT(ifconfig_ipv6_pool_netbits);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(n_bcast_buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(tcp_queue_limit);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(real_hash=
_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT=
(virtual_hash_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_STR(client_connect_script);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    SHOW_STR(learn_address_script);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(client_disconnect_script);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(client_c=
rresponse_script);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   SHOW_STR(client_config_dir);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    SHOW_BOOL(ccd_exclusive);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_STR(tmp_dir);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_BOOL(push_ifconfig_defined);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  pu=
sh_ifconfig_local =3D %s&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        print_in_addr_t(o-&gt;push_ifconfig_local, 0, &amp;gc))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PAR=
MS, &quot;  push_ifconfig_remote_netmask =3D %s&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        print_in_addr_t(o-&gt;push_ifcon=
fig_remote_netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_BOOL(push_ifconfig_ipv6_defined);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  push_ifc=
onfig_ipv6_local =3D %s/%d&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        print_in6_addr(o-&gt;push_ifconfig_ipv6_local, 0, &am=
p;gc), o-&gt;push_ifconfig_ipv6_netbits);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  push_ifconfig_ipv6_remo=
te =3D %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     print_in6_addr(o-&gt;push_ifconfig_ipv6_remote, 0, &amp;gc));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(enable_c2c);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(duplica=
te_cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT=
(cf_max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_I=
NT(cf_per);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_INT(cf_initial_max);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SHOW_INT(cf_initial_per);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    SHOW_UINT(max_clients);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_INT(max_routes_per_client);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_user_pass_verify_scr=
ipt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(=
auth_user_pass_verify_script_via_file);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_BOOL(auth_token_generate);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(force_key_material_export=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(auth=
_token_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_STR_INLINE(auth_token_secret_file);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if PORT_SHARE</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    SHOW_STR(port_share_host);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_STR(port_share_port);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_BOOL(vlan_tagging);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  vlan_acce=
pt =3D %s&quot;, print_vlan_accept(o-&gt;vlan_accept));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(vlan_pvid);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_BOOL(client);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_BOOL(pull);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(auth_user_pass_file);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_http_prox=
y_options(const struct http_proxy_options *o)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_SHOW_PARMS, &quot;BEGIN http_proxy&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(server);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(port);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_method_string);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_file);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_fi=
le_up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOO=
L(inline_creds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_BOOL(nocache);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_STR(http_version);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    SHOW_STR(user_agent);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (i =3D 0; i &lt; MAX_CUSTOM_HTTP_HEADER &amp;&amp; o=
-&gt;custom_headers[i]=2Ename; i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (o-&gt;custom_headers[i]=2Econtent)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(D_SHOW_PARMS, &quot;  custom_header[%d] =
=3D %s: %s&quot;, i, o-&gt;custom_headers[i]=2Ename,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                o-&gt;custom_headers[i]=
=2Econtent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(D_SHOW_PARMS, &quo=
t;  custom_header[%d] =3D %s&quot;, i, o-&gt;custom_headers[i]=2Ename);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;END http_proxy&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+show_connection_entry(const struct connection_entry *o)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Display the global proto only in c=
lient mode or with no &#39;--local&#39;*/</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (o-&gt;local_list-&gt;len =3D=3D 1)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;  proto =3D =
%s&quot;, proto2ascii(o-&gt;proto, o-&gt;af, false));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_SHOW_PARMS, &quot;  Local Sockets:&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; o-&gt;local_=
list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_S=
HOW_PARMS, &quot;    [%s]:%s-%s&quot;, o-&gt;local_list-&gt;array[i]-&gt;lo=
cal,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&=
gt;local_list-&gt;array[i]-&gt;port,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            proto2ascii(o-&gt;local_list-&gt;array[i]-&gt;=
proto, o-&gt;af, false));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_STR(remote);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_STR(remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_BOOL(remote_float);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_BOOL(bind_defined);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_BOOL(bind_local);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SHOW_BOOL(bind_ipv6_only);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(connect_retry_seconds);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(connect_=
timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;http_proxy_opti=
ons)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        show_http_proxy_optio=
ns(o-&gt;http_proxy_options);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_STR(socks_proxy_server);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_STR(socks_proxy_port);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_INT(tun_mtu);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_BOOL(tun_mtu_defined);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(link_mtu);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(link_mtu_defined);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(tun_mtu_=
extra);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOO=
L(tun_mtu_extra_defined);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    SHOW_INT(tls_mtu);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_I=
NT(mtu_discover_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_FR=
AGMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(=
fragment);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(mssfix);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(mssfix=
_encap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BO=
OL(mssfix_fixed);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(explicit=
_exit_notification);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INLIN=
E(tls_auth_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_PARM(key_direction, keydirection2ascii(o-&gt;key_direction, false, t=
rue), &quot;%s&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SHOW_STR_INLINE(tls_crypt_file);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_STR_INLINE(tls_crypt_v2_file);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+show_connection_entries(=
const struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt=
;connection_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const st=
ruct connection_list *l =3D o-&gt;connection_list;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        int i;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; l-&gt;len; ++i)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(D_SHOW_PARMS, &quo=
t;Connection profiles [%d]:&quot;, i);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            show_connection_entry(l-&gt;array[i]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(D_SHOW_PARMS, &quot;Connection profiles [default]:&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        show_connection=
_entry(&amp;o-&gt;ce);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_S=
HOW_PARMS, &quot;Connection profiles END&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_pull_filter=
_list(const struct pull_filter_list *l)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct pull_filter *f;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  Pull filters:&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (f =3D l-&=
gt;head; f; f =3D f-&gt;next)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_SHOW_PARMS, &quot;    %s \&quot;%s\&quot;&quot;, pull_filter_type=
_name(f-&gt;type), f-&gt;pattern);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+show_settings(const struct options *o)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;Current Parameter Sett=
ings:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(config);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(mode);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_BOOL(persist_config);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(persist_mode);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_BOOL(show_ciphers);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_BOOL(show_digests);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(show_engines);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(genkey);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(genkey_filename)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(key_p=
ass_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
BOOL(show_tls_ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(co=
nnect_retry_max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  show_connection_entries(o);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
BOOL(remote_random);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(ipcha=
nge);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(d=
ev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(de=
v_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_ST=
R(dev_node);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_BOOL(disable_dco);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_STR(lladdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_INT(topology);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_STR(ifconfig_local);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_STR(ifconfig_remote_netmask);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_BOOL(ifconfig_noexec);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(ifconfig_nowarn);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(ifconfig_ip=
v6_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
INT(ifconfig_ipv6_netbits);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_STR(ifconfig_ipv6_remote);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_INT(shaper);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_INT(mtu_test);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_BOOL(mlock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(keepalive_pi=
ng);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ke=
epalive_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_INT(inactivity_timeout);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    SHOW_INT(session_timeout);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    SHOW_INT64(inactivity_minimum_bytes);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ping_send_timeout=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ping=
_rec_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_INT(ping_rec_timeout_action);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_BOOL(ping_timer_remote);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SHOW_INT(remap_sigusr1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(persist_tun);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(persist_local_ip=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(per=
sist_remote_ip);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if PASSTOS_CAPABILITY=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(passt=
os);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SHOW_INT(resolve_retry_seconds);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(resolve_in_advan=
ce);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(username);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(groupname);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(chroot_dir);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(cd_dir=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_SEL=
INUX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(se=
linux_context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(writ=
epid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(=
up_script);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_STR(down_script);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   SHOW_BOOL(down_pre);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SHOW_BOOL(up_restart);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    SHOW_BOOL(up_delay);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_BOOL(daemon);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_BOOL(log);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_BOOL(suppress_timestamps);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(machine_readable_output);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(nice);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(verbosi=
ty);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(mu=
te);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_D=
EBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(gr=
emlin);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(status_file)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(statu=
s_file_version);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_INT(status_file_update_freq);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_BOOL(occ);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_INT(rcvbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   SHOW_INT(sndbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_INT(mark);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_INT(sockflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(comp=2E=
alg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(c=
omp=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(route_script=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(rout=
e_default_gateway);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_INT(route_default_metric);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_INT(route_default_table_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(route_noexec);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(route_delay);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(route_delay_=
window);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BO=
OL(route_delay_defined);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_BOOL(route_nopull);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_BOOL(route_gateway_via_dhcp);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(allow_pull_fqdn);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    show_pull_filter_list(o-&=
gt;pull_filter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;rou=
tes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        print_route_options(o=
-&gt;routes, D_SHOW_PARMS);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;client_nat)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        print_client_nat_list(o-&=
gt;client_nat, D_SHOW_PARMS);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    show_dns_options(&a=
mp;o-&gt;dns_options);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MA=
NAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_ST=
R(management_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_STR(management_port);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    SHOW_STR(management_user_pass);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_INT(management_log_history_cache);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(management_=
echo_buffer_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   SHOW_STR(management_client_user);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_STR(management_client_group);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(management_flags);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;plugin_list)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        plugin_option_list_print(o-&gt;plugin_=
list, D_SHOW_PARMS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(shared_secret_file);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_PARM(key_direct=
ion, keydirection2ascii(o-&gt;key_direction, false, true), &quot;%s&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(cipher=
name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(=
ncp_ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_STR(authname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fndef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_BOOL(engine);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SHOW_BOOL(mute_replay_warnings);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(replay_window);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(replay_tim=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(pac=
ket_id_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_BOOL(test_crypto);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(tls=
_server);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_B=
OOL(tls_client);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_STR_INLINE(ca_file);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_STR(ca_path);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_STR_INLINE(dh_file);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if ((o-&gt;management_flags &amp; MF_EXTERNAL_CERT)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        SHOW_PARM(&quot;cert_fil=
e&quot;, &quot;EXTERNAL_CERT&quot;, &quot;%s&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   SHOW_STR_INLINE(cert_file);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_STR_INLINE(extra_certs_file);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if ((o-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        SHOW_PARM(&quot;priv_key_file&quot;, &quot;EXTE=
RNAL_PRIVATE_KEY&quot;, &quot;%s&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SHOW_STR_I=
NLINE(priv_key_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENAB=
LE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_STR_INLINE(pkcs12_file);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SHOW_STR(cryptoapi_cert);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_STR(cipher_list);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_STR(cipher_list_tls13);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_STR(tls_cert_profile);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(tls_verify);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(tls_export_peer_cert_d=
ir);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ve=
rify_x509_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_STR(verify_x509_name);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    SHOW_STR_INLINE(crl_file);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_INT(ns_cert_type);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int i;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            SHOW_INT(remote_cert_ku[i]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    SHOW_STR(remote_cert_eku);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;verify_hash)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        SHOW_INT(verify_hash_algo);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        SHOW_INT(verify_hash_dep=
th);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const struct verify_hash_list *hl =3D o-&gt;verify_hash;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int digest_len =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (o-&=
gt;verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGEST_LEN=
GTH;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        while (=
hl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            char *s =3D fo=
rmat_hex_ex(hl-&gt;hash, digest_len, 0, 1, &quot;:&quot;, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            SHOW_PARM(verif=
y_hash, s, &quot;%s&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            hl =3D hl-&gt;next;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SHOW_INT(ssl_flags);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT=
(tls_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT64(renegotia=
te_bytes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
INT64(renegotiate_packets);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_INT(renegotiate_seconds);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SHOW_INT(handshake_window);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_INT(transition_window);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_BOOL(single_session);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    SHOW_BOOL(push_peer_info);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(tls_exit);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_STR(tls_crypt_v2_metadata);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef ENABLE_PKCS11</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        for (i =3D 0; i &lt; MAX_PARMS &amp;&amp; o-&gt;pkcs11_providers[i]=
 !=3D NULL; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            S=
HOW_PARM(pkcs11_providers, o-&gt;pkcs11_providers[i], &quot;%s&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        int i;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            SHOW_PARM(pkcs11_protected_authenticati=
on,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
      o-&gt;pkcs11_protected_authentication[i] ? &quot;ENABLED&quot; : &quo=
t;DISABLED&quot;, &quot;%s&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int i;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt;=
 MAX_PARMS; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            S=
HOW_PARM(pkcs11_private_mode, o-&gt;pkcs11_private_mode[i], &quot;%08x&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        int i;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            SHOW_PARM(pkcs11_cert_private, o=
-&gt;pkcs11_cert_private[i] ? &quot;ENABLED&quot; : &quot;DISABLED&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
 &quot;%s&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(pkcs11_pin_ca=
che_period);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_STR(pkcs11_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_BOOL(pkcs11_id_management);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif /* ENABLE_PKCS11 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    show_p2mp_parms(o);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN3=
2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(show=
_net_up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_I=
NT(route_method);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_BOOL(block_outside_dns);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    show_tuntap_options(&amp;o-&gt;tuntap_options);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
 /* ifndef ENABLE_SMALL */</span><br><span>diff --git a/src/openvpn/options=
_show=2Eh b/src/openvpn/options_show=2Eh</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2Efb233fc</span><br><span>--- /dev/null=
</span><br><span>+++ b/src/openvpn/options_show=2Eh</span><br><span>@@ -0,0=
 +1,46 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             over a single UDP port, with support for SSL/T=
LS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    session authentication and key exchange,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet encryption, packet authentic=
ation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  This program is free software; you can redistribu=
te it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  it under the terms of the GNU General Public License version 2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free=
 Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is distributed in the hope that it will be useful,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publ=
ic License for more details=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if=
 not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef OPTIONS_SHOW_H</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define OPTIONS_SHOW_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_C=
ONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_SMALL</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+show_settings(const struct options *o)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    (void)o;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void show_settings(const struct options *o);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* ENABLE_SMALL */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif /* OPTIONS_SHOW_H */</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=
=3Demail">change 1772</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1772?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1772 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>

</body></html>
--PfbalsEuivw=--


--===============3142066366018501511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3142066366018501511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3142066366018501511==--

