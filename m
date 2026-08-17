Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ADFC5DF7D
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uE8DTBRd7yueDaCbYlq7H+/XpcU7ztw51KdKdpiqIlI=; b=JRlixmxAYTjoHt2ATkc0YOmr0P
	b7q46mfzq12tKlKwcKfaWFjZ9eynT1ffj9e+48WJB4GgbjxDmp93fikAfku3mUr++6ao1wGJ67R15
	8XrxDLH+tXG7ZDmVDylzS/0pswWsUtZjBQrrH529T7BlO8QnOiDcT5EEwsqa44985kiU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww4KL-00047X-HY;
	Mon, 17 Aug 2026 20:53:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ww4KJ-00047Q-Rq
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 20:52:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kUTbRcQNchtXrUGcEOu/UxzqDK8fQTc8JXH5603QX78=; b=eCBQGLZTlyUgNztxHfTqxqTAT9
 Juz2J9qBALjlSTi0qqlE0AM1caZxGNVvrfDo2EN07SezoAgKs5kBSmnE0kZEbOBeMeuzP0l2mt8EU
 3emFa9NPhGvC8K8zVwvCGPXdi8fhjBgvbS+XAMaCn8gz8olkGIZgCBWvC46jEsGxDG3A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kUTbRcQNchtXrUGcEOu/UxzqDK8fQTc8JXH5603QX78=; b=N
 R1mTv5A8dZpC0+w17TmnekxxjIaby3pRjnE5VyoVc8axXxJhHCYx1ndRJJJ/o35mCtj58bItiWlQE
 hMkoRx0X4i4yCpuhOKL6J/aSuphYEClt7z7yc1g0rMTbYp7AZti/2uvATCT6lWTjCA39Xvc1RI0FH
 F9ZgOqHhm+vRDThE=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww4KF-0003te-Kj for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 20:52:59 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso1493128f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786999965; x=1787604765; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kUTbRcQNchtXrUGcEOu/UxzqDK8fQTc8JXH5603QX78=;
 b=Vzwa4Jnt0qG2vRAIOJ5QmQif5BEK/+uuoHXdfhKCWl9JsKtw1VrbUSnEWq4UGs9RS+
 U+VgfoyQiSIans2x36oQHHQwVMxyr76S8yAJZu7Pmo068Oa1xRRgusQV/a8lddLa308q
 MR0VVWUwpaiEBBTZLLB6bdhlFHIXhQuz5CtCwWRkZh8vv20Lgv13Gekr7e2J2rwhzg1o
 KkDBZGF5GiMmXD8qKZgM+uB5vcSa3wGepcR7emmfytf7cAZvNRnC6KPaCj8U6yS8uhux
 +mgkAYuaZjfVwC9zLzDbWQVcpXQGIlH//5xF6pKMMNMKoCFmURIwLxJfmdrw/oRSG6fC
 uPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999965; x=1787604765;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kUTbRcQNchtXrUGcEOu/UxzqDK8fQTc8JXH5603QX78=;
 b=DpVH1W7b2uB5UpEs9cUWf0eFWn+BtE9G/mDDr4oi/zpUrtg06Wu1R9USywj+rOYeJV
 gXtu2Cvk/R4zbCE3ebDe1/hZNghaZ2fem+IN3zpF/7xnsgGW9ugjnRo/SNQfrduKmjTv
 jxCxBl0fdf7oA227v6ZhzuXgwhmSeWOxCU7xGsk2M5v8gZtlCbHewfnG5gpomWgFX45N
 vj80/VxvKQTOsF87E8h4AsFT8enlIREFbLXsFsXC8o8k4tyHV/ZqoB2+Hxgficze0k38
 p08iv7I14Ve1gVIbm/s0AlcIsyogVRjPjq1LExuijUBiL/u1cSAzvsblZ+ecO/RMLLXi
 mXaw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqtl5Gc1jW2SRkfGb2O5yyvS8xaS6fQP3YncvCGXDpv8QXsDWXRR5gU9B/a12k5D5Evoqf//7DvTOWi8gYM@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyZYFnj3rgQ88qg7oY8eG7XLIi2jzHR6AI9jnPQgNJ/MyFNAMRI
 gYnX/JK/WF8NwO9QuyQMbALd2ShzdDEZ7Momu9OaqOTJrtK2zXd4i4ybdLugNOJL65plYKryFFG
 s+0frzbHhZBm8NaF6Jr6u+wCTN1imp1YwofmKT6dwoy/Qh6PVsyPQEol91zJec4kgfqW0mFKuL2
 TbeglEOg==
X-Gm-Gg: AR+sD13AgBHI5veXKtwSykuVlyDFLFqxExWe20D+a2eYh6w7Q5YdKwUaxsbemq2QazJ
 ilR/XBStt2QDFUhbExOV1BtKIzbcachSKPgU59KeJ5A1DWoBizdQ3pqWUbIfb0Ci7RK13VeEshZ
 yR3rSUCdwigfzKSTnmfULAgEAA8JNJo25AiCFIgkSuMhbPNi0EyKe9IFe5r1PjloQ8/Vvl6RRAa
 y2ZDwLg+GEfLGSJy/nGPiWiH2eWDUWH/VVXJC8ngO2gnm9Qu6c2xlmFa6txOMGGC3G6ax3Jldmg
 a900JHDFiueaUHZFlKFecRWX6EpH8U3G5aYvrfFrlmYSuGl/eoXiz6vhhIjl1dAAtIzRfj5zXCr
 rKwGSN1gNOQQpeVFvgf7pHXOHF4ma/qdUoRY/abMOOl3gInxhTMqOrlcNiQku+ZK3BBFr//jGTv
 nAnT7Hbq8qceQiISC5Y4SCgygj1jridI2FCe0oQ5nsukyjFXIVR+H0I5zwrqWRJtm7hH3xRoWm1
 hGmwKHVzGat/JQLv9C2mt8GayoabeySHc7ZLJsN79CojYR3oTBfY2jGmYjDAz6t6XnRoOUPDiJq
 BQEa8opFBzTb8oMYp2yxxmSX4tUILEa6yw+nZuhmfUfzOyWon1w=
X-Received: by 2002:a05:6000:2308:b0:47f:9096:3ef1 with SMTP id
 ffacd0b85a97d-482a8ff6eaemr5283848f8f.9.1786999964896; 
 Mon, 17 Aug 2026 13:52:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7bc6esm7067410f8f.19.2026.08.17.13.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:44 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 20:52:43 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 6d18f2ce2df00f9de37edf752391d2f462c9068f
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <40431fd76837fe1a1a8c039276bb831119fb98ed-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ww4KF-0003te-Kj
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4572282635726065852=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4572282635726065852==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zWGPk4/eFv0="; charset=UTF-8

--zWGPk4/eFv0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1772?usp=3Demail )

Change subject: options: Factor out options display=
 code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

options: Factor out options display code from options=2Ec

optio=
ns=2Ec is a huge, unwieldly file=2E So remove some
closely related code tha=
t has no direct dependencies
with the other functions in the file=2E

In th=
is case it is the code that prints out the current
configuration=2E

Change=
-Id: I61762374c141662d596bbf88b64ca7f7472b5149
Signed-off-by: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772
Message=
-Id: <20260817161852=2E8376-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38466=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt=

M src/openvpn/Makefile=2Eam
M src/openvpn/openvpn=2Ec
M src/openvpn/option=
s=2Ec
M src/openvpn/options=2Eh
A src/openvpn/options_show=2Ec
A src/openvp=
n/options_show=2Eh
7 files changed, 683 insertions(+), 620 deletions(-)



=

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index aae264e=2E=2E4eda75=
b 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -529,6 +529,8 @@
=
     src/openvpn/options_util=2Ec
     src/openvpn/options_util=2Eh
     sr=
c/openvpn/options_parse=2Ec
+    src/openvpn/options_show=2Ec
+    src/open=
vpn/options_show=2Eh
     src/openvpn/otime=2Ec
     src/openvpn/otime=2Eh
=
     src/openvpn/ovpn_dco_win=2Eh
diff --git a/src/openvpn/Makefile=2Eam b/=
src/openvpn/Makefile=2Eam
index 1f77384=2E=2E2092e96 100644
--- a/src/openv=
pn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -108,6 +108,7 @@
 	pkcs=
11_mbedtls=2Ec \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
+	=
options_show=2Ec options_show=2Eh \
 	options_util=2Ec options_util=2Eh \
 =
	options_parse=2Ec \
 	otime=2Ec otime=2Eh \
diff --git a/src/openvpn/openv=
pn=2Ec b/src/openvpn/openvpn=2Ec
index f38660f=2E=2E7d35195 100644
--- a/sr=
c/openvpn/openvpn=2Ec
+++ b/src/openvpn/openvpn=2Ec
@@ -30,6 +30,7 @@
 #inc=
lude "forward=2Eh"
 #include "multi=2Eh"
 #include "win32=2Eh"
+#include "o=
ptions_show=2Eh"
 #include "platform=2Eh"
 #include "string=2Eh"
 
diff --g=
it a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 4aebfea=2E=2Ee=
899fa6 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@=
@ -914,41 +914,6 @@
     gc_free(&o->dns_options=2Egc);
 }
 
-#ifndef ENABL=
E_SMALL
-
-static const char *
-pull_filter_type_name(int type)
-{
-    if =
(type =3D=3D PUF_TYPE_ACCEPT)
-    {
-        return "accept";
-    }
-    =
if (type =3D=3D PUF_TYPE_IGNORE)
-    {
-        return "ignore";
-    }
- =
   if (type =3D=3D PUF_TYPE_REJECT)
-    {
-        return "reject";
-    }=

-    else
-    {
-        return "???";
-    }
-}
-
-#define SHOW_PARM(nam=
e, value, format) msg(D_SHOW_PARMS, "  " #name " =3D " format, (value))
-#d=
efine SHOW_STR(var)                  SHOW_PARM(var, (o->var ? o->var : "[UN=
DEF]"), "'%s'")
-#define SHOW_STR_INLINE(var) \
-    SHOW_PARM(var, o->var#=
#_inline ? "[INLINE]" : (o->var ? o->var : "[UNDEF]"), "'%s'")
-#define SHO=
W_INT(var)      SHOW_PARM(var, o->var, "%d")
-#define SHOW_UINT(var)     SH=
OW_PARM(var, o->var, "%u")
-#define SHOW_INT64(var)    SHOW_PARM(var, o->va=
r, "%" PRIi64)
-#define SHOW_UNSIGNED(var) SHOW_PARM(var, o->var, "0x%08x")=

-#define SHOW_BOOL(var)     SHOW_PARM(var, (o->var ? "ENABLED" : "DISABLED=
"), "%s");
-
-#endif /* ifndef ENABLE_SMALL */
-
 static void
 setenv_conne=
ction_entry(struct env_set *es, const struct connection_entry *e, const int=
 i)
 {
@@ -1240,55 +1205,6 @@
 
     return ret;
 }
-#ifdef _WIN32
-
-#ifnd=
ef ENABLE_SMALL
-
-static void
-show_dhcp_option_list(const char *name, con=
st char *const *array, unsigned int len)
-{
-    for (unsigned int i =3D 0;=
 i < len; ++i)
-    {
-        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i=
, array[i]);
-    }
-}
-
-static void
-show_dhcp_option_addrs(const char *n=
ame, const in_addr_t *array, unsigned int len)
-{
-    struct gc_arena gc =
=3D gc_new();
-    for (unsigned int i =3D 0; i < len; ++i)
-    {
-       =
 msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, print_in_addr_t(array[i], 0,=
 &gc));
-    }
-    gc_free(&gc);
-}
-
-static void
-show_tuntap_options(co=
nst struct tuntap_options *o)
-{
-    SHOW_BOOL(ip_win32_defined);
-    SHO=
W_INT(ip_win32_type);
-    SHOW_INT(dhcp_masq_offset);
-    SHOW_INT(dhcp_l=
ease_time);
-    SHOW_INT(tap_sleep);
-    SHOW_UNSIGNED(dhcp_options);
-  =
  SHOW_BOOL(dhcp_renew);
-    SHOW_BOOL(dhcp_pre_release);
-    SHOW_STR(do=
main);
-    SHOW_STR(netbios_scope);
-    SHOW_UNSIGNED(netbios_node_type);=

-    SHOW_BOOL(disable_nbt);
-
-    show_dhcp_option_addrs("DNS", o->dns, =
o->dns_len);
-    show_dhcp_option_addrs("WINS", o->wins, o->wins_len);
-  =
  show_dhcp_option_addrs("NTP", o->ntp, o->ntp_len);
-    show_dhcp_option_=
addrs("NBDD", o->nbdd, o->nbdd_len);
-    show_dhcp_option_list("DOMAIN-SEA=
RCH", o->domain_search_list, o->domain_search_list_len);
-}
-
-#endif /* if=
ndef ENABLE_SMALL */
-#endif /* ifdef _WIN32 */
 
 static void
 dhcp_option=
_dns6_parse(const char *parm, struct in6_addr *dns6_list, unsigned int *len=
, msglvl_t msglevel)
@@ -1331,116 +1247,6 @@
     }
 }
 
-#ifndef ENABLE_SM=
ALL
-static const char *
-print_vlan_accept(enum vlan_acceptable_frames mod=
e)
-{
-    switch (mode)
-    {
-        case VLAN_ONLY_TAGGED:
-          =
  return "tagged";
-
-        case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
-       =
     return "untagged";
-
-        case VLAN_ALL:
-            return "all"=
;
-    }
-    return NULL;
-}
-
-static void
-show_p2mp_parms(const struct =
options *o)
-{
-    struct gc_arena gc =3D gc_new();
-
-    msg(D_SHOW_PARM=
S, "  server_network =3D %s", print_in_addr_t(o->server_network, 0, &gc));
=
-    msg(D_SHOW_PARMS, "  server_netmask =3D %s", print_in_addr_t(o->server=
_netmask, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_network_ipv6 =3D %s", =
print_in6_addr(o->server_network_ipv6, 0, &gc));
-    SHOW_INT(server_netbi=
ts_ipv6);
-    msg(D_SHOW_PARMS, "  server_bridge_ip =3D %s", print_in_addr=
_t(o->server_bridge_ip, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_bridge_n=
etmask =3D %s",
-        print_in_addr_t(o->server_bridge_netmask, 0, &gc))=
;
-    msg(D_SHOW_PARMS, "  server_bridge_pool_start =3D %s",
-        prin=
t_in_addr_t(o->server_bridge_pool_start, 0, &gc));
-    msg(D_SHOW_PARMS, "=
  server_bridge_pool_end =3D %s",
-        print_in_addr_t(o->server_bridge=
_pool_end, 0, &gc));
-    if (o->push_list=2Ehead)
-    {
-        const st=
ruct push_entry *e =3D o->push_list=2Ehead;
-        while (e)
-        {
-=
            if (e->enable)
-            {
-                msg(D_SHOW_PARMS=
, "  push_entry =3D '%s'", e->option);
-            }
-            e =3D e-=
>next;
-        }
-    }
-    SHOW_BOOL(ifconfig_pool_defined);
-    msg(D_=
SHOW_PARMS, "  ifconfig_pool_start =3D %s",
-        print_in_addr_t(o->ifc=
onfig_pool_start, 0, &gc));
-    msg(D_SHOW_PARMS, "  ifconfig_pool_end =3D=
 %s", print_in_addr_t(o->ifconfig_pool_end, 0, &gc));
-    msg(D_SHOW_PARMS=
, "  ifconfig_pool_netmask =3D %s",
-        print_in_addr_t(o->ifconfig_po=
ol_netmask, 0, &gc));
-    SHOW_STR(ifconfig_pool_persist_filename);
-    S=
HOW_INT(ifconfig_pool_persist_refresh_freq);
-    SHOW_BOOL(ifconfig_ipv6_p=
ool_defined);
-    msg(D_SHOW_PARMS, "  ifconfig_ipv6_pool_base =3D %s",
- =
       print_in6_addr(o->ifconfig_ipv6_pool_base, 0, &gc));
-    SHOW_INT(i=
fconfig_ipv6_pool_netbits);
-    SHOW_INT(n_bcast_buf);
-    SHOW_INT(tcp_q=
ueue_limit);
-    SHOW_INT(real_hash_size);
-    SHOW_INT(virtual_hash_size=
);
-    SHOW_STR(client_connect_script);
-    SHOW_STR(learn_address_script=
);
-    SHOW_STR(client_disconnect_script);
-    SHOW_STR(client_crresponse=
_script);
-    SHOW_STR(client_config_dir);
-    SHOW_BOOL(ccd_exclusive);
=
-    SHOW_STR(tmp_dir);
-    SHOW_BOOL(push_ifconfig_defined);
-    msg(D_S=
HOW_PARMS, "  push_ifconfig_local =3D %s",
-        print_in_addr_t(o->push=
_ifconfig_local, 0, &gc));
-    msg(D_SHOW_PARMS, "  push_ifconfig_remote_n=
etmask =3D %s",
-        print_in_addr_t(o->push_ifconfig_remote_netmask, 0=
, &gc));
-    SHOW_BOOL(push_ifconfig_ipv6_defined);
-    msg(D_SHOW_PARMS,=
 "  push_ifconfig_ipv6_local =3D %s/%d",
-        print_in6_addr(o->push_if=
config_ipv6_local, 0, &gc), o->push_ifconfig_ipv6_netbits);
-    msg(D_SHOW=
_PARMS, "  push_ifconfig_ipv6_remote =3D %s",
-        print_in6_addr(o->pu=
sh_ifconfig_ipv6_remote, 0, &gc));
-    SHOW_BOOL(enable_c2c);
-    SHOW_BO=
OL(duplicate_cn);
-    SHOW_INT(cf_max);
-    SHOW_INT(cf_per);
-    SHOW_I=
NT(cf_initial_max);
-    SHOW_INT(cf_initial_per);
-    SHOW_UINT(max_clien=
ts);
-    SHOW_INT(max_routes_per_client);
-    SHOW_STR(auth_user_pass_ver=
ify_script);
-    SHOW_BOOL(auth_user_pass_verify_script_via_file);
-    SH=
OW_BOOL(auth_token_generate);
-    SHOW_BOOL(force_key_material_export);
- =
   SHOW_INT(auth_token_lifetime);
-    SHOW_STR_INLINE(auth_token_secret_fi=
le);
-#if PORT_SHARE
-    SHOW_STR(port_share_host);
-    SHOW_STR(port_sha=
re_port);
-#endif
-    SHOW_BOOL(vlan_tagging);
-    msg(D_SHOW_PARMS, "  v=
lan_accept =3D %s", print_vlan_accept(o->vlan_accept));
-    SHOW_INT(vlan_=
pvid);
-
-    SHOW_BOOL(client);
-    SHOW_BOOL(pull);
-    SHOW_STR_INLINE=
(auth_user_pass_file);
-
-    gc_free(&gc);
-}
-
-#endif /* ! ENABLE_SMALL =
*/
-
 static void
 option_iroute(struct options *o, const char *network_str=
, const char *netmask_str,
               msglvl_t msglevel)
@@ -1485,37 +1=
291,6 @@
     o->iroutes_ipv6 =3D ir;
 }
 
-#ifndef ENABLE_SMALL
-static vo=
id
-show_http_proxy_options(const struct http_proxy_options *o)
-{
-    int=
 i;
-    msg(D_SHOW_PARMS, "BEGIN http_proxy");
-    SHOW_STR(server);
-   =
 SHOW_STR(port);
-    SHOW_STR(auth_method_string);
-    SHOW_STR(auth_file=
);
-    SHOW_STR(auth_file_up);
-    SHOW_BOOL(inline_creds);
-    SHOW_BOO=
L(nocache);
-    SHOW_STR(http_version);
-    SHOW_STR(user_agent);
-    fo=
r (i =3D 0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_headers[i]=2Ename; i++)=

-    {
-        if (o->custom_headers[i]=2Econtent)
-        {
-          =
  msg(D_SHOW_PARMS, "  custom_header[%d] =3D %s: %s", i, o->custom_headers[=
i]=2Ename,
-                o->custom_headers[i]=2Econtent);
-        }
-  =
      else
-        {
-            msg(D_SHOW_PARMS, "  custom_header[%d] =
=3D %s", i, o->custom_headers[i]=2Ename);
-        }
-    }
-    msg(D_SHOW=
_PARMS, "END http_proxy");
-}
-#endif /* ifndef ENABLE_SMALL */
-
 void
 op=
tions_detach(struct options *o)
 {
@@ -1563,399 +1338,6 @@
     }
 }
 
-#if=
ndef ENABLE_SMALL
-static void
-show_connection_entry(const struct connecti=
on_entry *o)
-{
-    /* Display the global proto only in client mode or wit=
h no '--local'*/
-    if (o->local_list->len =3D=3D 1)
-    {
-        msg(=
D_SHOW_PARMS, "  proto =3D %s", proto2ascii(o->proto, o->af, false));
-    =
}
-
-    msg(D_SHOW_PARMS, "  Local Sockets:");
-    for (int i =3D 0; i < =
o->local_list->len; i++)
-    {
-        msg(D_SHOW_PARMS, "    [%s]:%s-%s"=
, o->local_list->array[i]->local,
-            o->local_list->array[i]->por=
t,
-            proto2ascii(o->local_list->array[i]->proto, o->af, false));=

-    }
-    SHOW_STR(remote);
-    SHOW_STR(remote_port);
-    SHOW_BOOL(r=
emote_float);
-    SHOW_BOOL(bind_defined);
-    SHOW_BOOL(bind_local);
-  =
  SHOW_BOOL(bind_ipv6_only);
-    SHOW_INT(connect_retry_seconds);
-    SHO=
W_INT(connect_timeout);
-
-    if (o->http_proxy_options)
-    {
-        s=
how_http_proxy_options(o->http_proxy_options);
-    }
-    SHOW_STR(socks_p=
roxy_server);
-    SHOW_STR(socks_proxy_port);
-    SHOW_INT(tun_mtu);
-   =
 SHOW_BOOL(tun_mtu_defined);
-    SHOW_INT(link_mtu);
-    SHOW_BOOL(link_m=
tu_defined);
-    SHOW_INT(tun_mtu_extra);
-    SHOW_BOOL(tun_mtu_extra_def=
ined);
-    SHOW_INT(tls_mtu);
-
-    SHOW_INT(mtu_discover_type);
-
-#ifde=
f ENABLE_FRAGMENT
-    SHOW_INT(fragment);
-#endif
-    SHOW_INT(mssfix);
-=
    SHOW_BOOL(mssfix_encap);
-    SHOW_BOOL(mssfix_fixed);
-
-    SHOW_INT(=
explicit_exit_notification);
-
-    SHOW_STR_INLINE(tls_auth_file);
-    SH=
OW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true), "=
%s");
-    SHOW_STR_INLINE(tls_crypt_file);
-    SHOW_STR_INLINE(tls_crypt_=
v2_file);
-}
-
-
-static void
-show_connection_entries(const struct options=
 *o)
-{
-    if (o->connection_list)
-    {
-        const struct connectio=
n_list *l =3D o->connection_list;
-        int i;
-        for (i =3D 0; i =
< l->len; ++i)
-        {
-            msg(D_SHOW_PARMS, "Connection profil=
es [%d]:", i);
-            show_connection_entry(l->array[i]);
-        }
=
-    }
-    else
-    {
-        msg(D_SHOW_PARMS, "Connection profiles [de=
fault]:");
-        show_connection_entry(&o->ce);
-    }
-    msg(D_SHOW_P=
ARMS, "Connection profiles END");
-}
-
-static void
-show_pull_filter_list(=
const struct pull_filter_list *l)
-{
-    struct pull_filter *f;
-    if (!=
l)
-    {
-        return;
-    }
-
-    msg(D_SHOW_PARMS, "  Pull filters:=
");
-    for (f =3D l->head; f; f =3D f->next)
-    {
-        msg(D_SHOW_P=
ARMS, "    %s \"%s\"", pull_filter_type_name(f->type), f->pattern);
-    }
=
-}
-
-#endif /* ifndef ENABLE_SMALL */
-
-void
-show_settings(const struct =
options *o)
-{
-#ifndef ENABLE_SMALL
-    msg(D_SHOW_PARMS, "Current Parame=
ter Settings:");
-
-    SHOW_STR(config);
-
-    SHOW_INT(mode);
-
-#ifdef =
ENABLE_FEATURE_TUN_PERSIST
-    SHOW_BOOL(persist_config);
-    SHOW_INT(pe=
rsist_mode);
-#endif
-
-    SHOW_BOOL(show_ciphers);
-    SHOW_BOOL(show_di=
gests);
-    SHOW_BOOL(show_engines);
-    SHOW_BOOL(genkey);
-    SHOW_STR=
(genkey_filename);
-    SHOW_STR(key_pass_file);
-    SHOW_BOOL(show_tls_ci=
phers);
-
-    SHOW_INT(connect_retry_max);
-    show_connection_entries(o)=
;
-
-    SHOW_BOOL(remote_random);
-
-    SHOW_STR(ipchange);
-    SHOW_STR=
(dev);
-    SHOW_STR(dev_type);
-    SHOW_STR(dev_node);
-#if defined(ENABL=
E_DCO)
-    SHOW_BOOL(disable_dco);
-#endif
-    SHOW_STR(lladdr);
-    SHO=
W_INT(topology);
-    SHOW_STR(ifconfig_local);
-    SHOW_STR(ifconfig_remo=
te_netmask);
-    SHOW_BOOL(ifconfig_noexec);
-    SHOW_BOOL(ifconfig_nowar=
n);
-    SHOW_STR(ifconfig_ipv6_local);
-    SHOW_INT(ifconfig_ipv6_netbits=
);
-    SHOW_STR(ifconfig_ipv6_remote);
-
-    SHOW_INT(shaper);
-    SHOW_=
INT(mtu_test);
-
-    SHOW_BOOL(mlock);
-
-    SHOW_INT(keepalive_ping);
- =
   SHOW_INT(keepalive_timeout);
-    SHOW_INT(inactivity_timeout);
-    SHO=
W_INT(session_timeout);
-    SHOW_INT64(inactivity_minimum_bytes);
-    SHO=
W_INT(ping_send_timeout);
-    SHOW_INT(ping_rec_timeout);
-    SHOW_INT(pi=
ng_rec_timeout_action);
-    SHOW_BOOL(ping_timer_remote);
-    SHOW_INT(re=
map_sigusr1);
-    SHOW_BOOL(persist_tun);
-    SHOW_BOOL(persist_local_ip)=
;
-    SHOW_BOOL(persist_remote_ip);
-
-#if PASSTOS_CAPABILITY
-    SHOW_BO=
OL(passtos);
-#endif
-
-    SHOW_INT(resolve_retry_seconds);
-    SHOW_BOOL=
(resolve_in_advance);
-
-    SHOW_STR(username);
-    SHOW_STR(groupname);
=
-    SHOW_STR(chroot_dir);
-    SHOW_STR(cd_dir);
-#ifdef ENABLE_SELINUX
- =
   SHOW_STR(selinux_context);
-#endif
-    SHOW_STR(writepid);
-    SHOW_ST=
R(up_script);
-    SHOW_STR(down_script);
-    SHOW_BOOL(down_pre);
-    SH=
OW_BOOL(up_restart);
-    SHOW_BOOL(up_delay);
-    SHOW_BOOL(daemon);
-   =
 SHOW_BOOL(log);
-    SHOW_BOOL(suppress_timestamps);
-    SHOW_BOOL(machin=
e_readable_output);
-    SHOW_INT(nice);
-    SHOW_INT(verbosity);
-    SHO=
W_INT(mute);
-#ifdef ENABLE_DEBUG
-    SHOW_INT(gremlin);
-#endif
-    SHOW=
_STR(status_file);
-    SHOW_INT(status_file_version);
-    SHOW_INT(status=
_file_update_freq);
-
-    SHOW_BOOL(occ);
-    SHOW_INT(rcvbuf);
-    SHOW=
_INT(sndbuf);
-#if defined(TARGET_LINUX)
-    SHOW_INT(mark);
-#endif
-    =
SHOW_INT(sockflags);
-
-    SHOW_INT(comp=2Ealg);
-    SHOW_INT(comp=2Eflag=
s);
-
-    SHOW_STR(route_script);
-    SHOW_STR(route_default_gateway);
- =
   SHOW_INT(route_default_metric);
-    SHOW_INT(route_default_table_id);
-=
    SHOW_BOOL(route_noexec);
-    SHOW_INT(route_delay);
-    SHOW_INT(rout=
e_delay_window);
-    SHOW_BOOL(route_delay_defined);
-    SHOW_BOOL(route_=
nopull);
-    SHOW_BOOL(route_gateway_via_dhcp);
-    SHOW_BOOL(allow_pull_=
fqdn);
-    show_pull_filter_list(o->pull_filter_list);
-
-    if (o->route=
s)
-    {
-        print_route_options(o->routes, D_SHOW_PARMS);
-    }
-
-=
    if (o->client_nat)
-    {
-        print_client_nat_list(o->client_nat,=
 D_SHOW_PARMS);
-    }
-
-    show_dns_options(&o->dns_options);
-
-#ifdef =
ENABLE_MANAGEMENT
-    SHOW_STR(management_addr);
-    SHOW_STR(management_=
port);
-    SHOW_STR(management_user_pass);
-    SHOW_INT(management_log_hi=
story_cache);
-    SHOW_INT(management_echo_buffer_size);
-    SHOW_STR(man=
agement_client_user);
-    SHOW_STR(management_client_group);
-    SHOW_INT=
(management_flags);
-#endif
-#ifdef ENABLE_PLUGIN
-    if (o->plugin_list)
=
-    {
-        plugin_option_list_print(o->plugin_list, D_SHOW_PARMS);
-  =
  }
-#endif
-
-    SHOW_STR_INLINE(shared_secret_file);
-    SHOW_PARM(key_=
direction, keydirection2ascii(o->key_direction, false, true), "%s");
-    S=
HOW_STR(ciphername);
-    SHOW_STR(ncp_ciphers);
-    SHOW_STR(authname);
-=
#ifndef ENABLE_CRYPTO_MBEDTLS
-    SHOW_BOOL(engine);
-#endif /* ENABLE_CRY=
PTO_MBEDTLS */
-    SHOW_BOOL(mute_replay_warnings);
-    SHOW_INT(replay_w=
indow);
-    SHOW_INT(replay_time);
-    SHOW_STR(packet_id_file);
-    SHO=
W_BOOL(test_crypto);
-
-    SHOW_BOOL(tls_server);
-    SHOW_BOOL(tls_clien=
t);
-    SHOW_STR_INLINE(ca_file);
-    SHOW_STR(ca_path);
-    SHOW_STR_IN=
LINE(dh_file);
-    if ((o->management_flags & MF_EXTERNAL_CERT))
-    {
- =
       SHOW_PARM("cert_file", "EXTERNAL_CERT", "%s");
-    }
-    else
-   =
 {
-        SHOW_STR_INLINE(cert_file);
-    }
-    SHOW_STR_INLINE(extra_c=
erts_file);
-
-    if ((o->management_flags & MF_EXTERNAL_KEY))
-    {
-   =
     SHOW_PARM("priv_key_file", "EXTERNAL_PRIVATE_KEY", "%s");
-    }
-    =
else
-    {
-        SHOW_STR_INLINE(priv_key_file);
-    }
-#ifndef ENABLE=
_CRYPTO_MBEDTLS
-    SHOW_STR_INLINE(pkcs12_file);
-#endif
-#ifdef ENABLE_C=
RYPTOAPI
-    SHOW_STR(cryptoapi_cert);
-#endif
-    SHOW_STR(cipher_list);=

-    SHOW_STR(cipher_list_tls13);
-    SHOW_STR(tls_cert_profile);
-    SH=
OW_STR(tls_verify);
-    SHOW_STR(tls_export_peer_cert_dir);
-    SHOW_INT(=
verify_x509_type);
-    SHOW_STR(verify_x509_name);
-    SHOW_STR_INLINE(cr=
l_file);
-    SHOW_INT(ns_cert_type);
-    {
-        int i;
-        for (=
i =3D 0; i < MAX_PARMS; i++)
-        {
-            SHOW_INT(remote_cert_k=
u[i]);
-        }
-    }
-    SHOW_STR(remote_cert_eku);
-    if (o->verify=
_hash)
-    {
-        SHOW_INT(verify_hash_algo);
-        SHOW_INT(verify=
_hash_depth);
-        struct gc_arena gc =3D gc_new();
-        struct ver=
ify_hash_list *hl =3D o->verify_hash;
-        int digest_len =3D
-        =
    (o->verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGES=
T_LENGTH;
-        while (hl)
-        {
-            char *s =3D format_he=
x_ex(hl->hash, digest_len, 0, 1, ":", &gc);
-            SHOW_PARM(verify_h=
ash, s, "%s");
-            hl =3D hl->next;
-        }
-        gc_free(&g=
c);
-    }
-    SHOW_INT(ssl_flags);
-
-    SHOW_INT(tls_timeout);
-
-    S=
HOW_INT64(renegotiate_bytes);
-    SHOW_INT64(renegotiate_packets);
-    SH=
OW_INT(renegotiate_seconds);
-
-    SHOW_INT(handshake_window);
-    SHOW_I=
NT(transition_window);
-
-    SHOW_BOOL(single_session);
-    SHOW_BOOL(pus=
h_peer_info);
-    SHOW_BOOL(tls_exit);
-
-    SHOW_STR(tls_crypt_v2_metada=
ta);
-
-#ifdef ENABLE_PKCS11
-    {
-        int i;
-        for (i =3D 0; =
i < MAX_PARMS && o->pkcs11_providers[i] !=3D NULL; i++)
-        {
-       =
     SHOW_PARM(pkcs11_providers, o->pkcs11_providers[i], "%s");
-        }
=
-    }
-    {
-        int i;
-        for (i =3D 0; i < MAX_PARMS; i++)
- =
       {
-            SHOW_PARM(pkcs11_protected_authentication,
-         =
             o->pkcs11_protected_authentication[i] ? "ENABLED" : "DISABLED"=
, "%s");
-        }
-    }
-    {
-        int i;
-        for (i =3D 0; i =
< MAX_PARMS; i++)
-        {
-            SHOW_PARM(pkcs11_private_mode, o-=
>pkcs11_private_mode[i], "%08x");
-        }
-    }
-    {
-        int i;
=
-        for (i =3D 0; i < MAX_PARMS; i++)
-        {
-            SHOW_PAR=
M(pkcs11_cert_private, o->pkcs11_cert_private[i] ? "ENABLED" : "DISABLED",
=
-                      "%s");
-        }
-    }
-    SHOW_INT(pkcs11_pin_ca=
che_period);
-    SHOW_STR(pkcs11_id);
-    SHOW_BOOL(pkcs11_id_management)=
;
-#endif /* ENABLE_PKCS11 */
-
-    show_p2mp_parms(o);
-
-#ifdef _WIN32
-=
    SHOW_BOOL(show_net_up);
-    SHOW_INT(route_method);
-    SHOW_BOOL(blo=
ck_outside_dns);
-    show_tuntap_options(&o->tuntap_options);
-#endif
-#en=
dif /* ifndef ENABLE_SMALL */
-}
-
-#undef SHOW_PARM
-#undef SHOW_STR
-#und=
ef SHOW_INT
-#undef SHOW_BOOL
-
 #ifdef ENABLE_MANAGEMENT
 
 static struct =
http_proxy_options *
diff --git a/src/openvpn/options=2Eh b/src/openvpn/opt=
ions=2Eh
index 30a146f=2E=2Ed42773f 100644
--- a/src/openvpn/options=2Eh
++=
+ b/src/openvpn/options=2Eh
@@ -901,8 +901,6 @@
 
 void setenv_settings(str=
uct env_set *es, const struct options *o);
 
-void show_settings(const stru=
ct options *o);
-
 bool string_defined_equal(const char *s1, const char *s2=
);
 
 const char *options_string_version(const char *s, struct gc_arena *gc=
);
diff --git a/src/openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec=

new file mode 100644
index 0000000=2E=2Eff090774
--- /dev/null
+++ b/src/o=
penvpn/options_show=2Ec
@@ -0,0 +1,633 @@
+/*
+ *  OpenVPN -- An applicatio=
n to securely tunnel IP networks
+ *             over a single UDP port, wi=
th support for SSL/TLS-based
+ *             session authentication and key=
 exchange,
+ *             packet encryption, packet authentication, and
+ =
*             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVP=
N Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can=
 redistribute it and/or modify
+ *  it under the terms of the GNU General P=
ublic License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H=

+#include "config=2Eh"
+#endif
+
+#ifndef ENABLE_SMALL
+
+#include "syshea=
d=2Eh"
+
+#include "options_show=2Eh"
+
+#include "crypto=2Eh"
+#include "e=
rror=2Eh"
+#include "options=2Eh"
+
+static const char *
+pull_filter_type_=
name(int type)
+{
+    if (type =3D=3D PUF_TYPE_ACCEPT)
+    {
+        ret=
urn "accept";
+    }
+    if (type =3D=3D PUF_TYPE_IGNORE)
+    {
+        =
return "ignore";
+    }
+    if (type =3D=3D PUF_TYPE_REJECT)
+    {
+     =
   return "reject";
+    }
+    else
+    {
+        return "???";
+    }
+=
}
+
+#define SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, "  " #name " =
=3D " format, (value))
+#define SHOW_STR(var)                  SHOW_PARM(va=
r, (o->var ? o->var : "[UNDEF]"), "'%s'")
+#define SHOW_STR_INLINE(var) \
+=
    SHOW_PARM(var, o->var##_inline ? "[INLINE]" : (o->var ? o->var : "[UNDE=
F]"), "'%s'")
+#define SHOW_INT(var)      SHOW_PARM(var, o->var, "%d")
+#de=
fine SHOW_UINT(var)     SHOW_PARM(var, o->var, "%u")
+#define SHOW_INT64(va=
r)    SHOW_PARM(var, o->var, "%" PRIi64)
+#define SHOW_UNSIGNED(var) SHOW_P=
ARM(var, o->var, "0x%08x")
+#define SHOW_BOOL(var)     SHOW_PARM(var, (o->v=
ar ? "ENABLED" : "DISABLED"), "%s");
+
+#ifdef _WIN32
+
+static void
+show_=
dhcp_option_list(const char *name, const char *const *array, unsigned int l=
en)
+{
+    for (unsigned int i =3D 0; i < len; ++i)
+    {
+        msg(D_=
SHOW_PARMS, "  %s[%u] =3D %s", name, i, array[i]);
+    }
+}
+
+static void=

+show_dhcp_option_addrs(const char *name, const in_addr_t *array, unsigned=
 int len)
+{
+    struct gc_arena gc =3D gc_new();
+    for (unsigned int i=
 =3D 0; i < len; ++i)
+    {
+        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", =
name, i, print_in_addr_t(array[i], 0, &gc));
+    }
+    gc_free(&gc);
+}
+=

+static void
+show_tuntap_options(const struct tuntap_options *o)
+{
+    =
SHOW_BOOL(ip_win32_defined);
+    SHOW_INT(ip_win32_type);
+    SHOW_INT(dh=
cp_masq_offset);
+    SHOW_INT(dhcp_lease_time);
+    SHOW_INT(tap_sleep);
=
+    SHOW_UNSIGNED(dhcp_options);
+    SHOW_BOOL(dhcp_renew);
+    SHOW_BOO=
L(dhcp_pre_release);
+    SHOW_STR(domain);
+    SHOW_STR(netbios_scope);
+=
    SHOW_UNSIGNED(netbios_node_type);
+    SHOW_BOOL(disable_nbt);
+
+    s=
how_dhcp_option_addrs("DNS", o->dns, o->dns_len);
+    show_dhcp_option_add=
rs("WINS", o->wins, o->wins_len);
+    show_dhcp_option_addrs("NTP", o->ntp=
, o->ntp_len);
+    show_dhcp_option_addrs("NBDD", o->nbdd, o->nbdd_len);
+=
    show_dhcp_option_list("DOMAIN-SEARCH", o->domain_search_list, o->domain=
_search_list_len);
+}
+#endif /* ifdef _WIN32 */
+
+static const char *
+pr=
int_vlan_accept(enum vlan_acceptable_frames mode)
+{
+    switch (mode)
+  =
  {
+        case VLAN_ONLY_TAGGED:
+            return "tagged";
+
+      =
  case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
+            return "untagged";
+
+ =
       case VLAN_ALL:
+            return "all";
+    }
+    return NULL;
+=
}
+
+static void
+show_p2mp_parms(const struct options *o)
+{
+    struct g=
c_arena gc =3D gc_new();
+
+    msg(D_SHOW_PARMS, "  server_network =3D %s"=
, print_in_addr_t(o->server_network, 0, &gc));
+    msg(D_SHOW_PARMS, "  se=
rver_netmask =3D %s", print_in_addr_t(o->server_netmask, 0, &gc));
+    msg=
(D_SHOW_PARMS, "  server_network_ipv6 =3D %s", print_in6_addr(o->server_net=
work_ipv6, 0, &gc));
+    SHOW_INT(server_netbits_ipv6);
+    msg(D_SHOW_PA=
RMS, "  server_bridge_ip =3D %s", print_in_addr_t(o->server_bridge_ip, 0, &=
gc));
+    msg(D_SHOW_PARMS, "  server_bridge_netmask =3D %s",
+        pri=
nt_in_addr_t(o->server_bridge_netmask, 0, &gc));
+    msg(D_SHOW_PARMS, "  =
server_bridge_pool_start =3D %s",
+        print_in_addr_t(o->server_bridge=
_pool_start, 0, &gc));
+    msg(D_SHOW_PARMS, "  server_bridge_pool_end =3D=
 %s",
+        print_in_addr_t(o->server_bridge_pool_end, 0, &gc));
+    if=
 (o->push_list=2Ehead)
+    {
+        const struct push_entry *e =3D o->pu=
sh_list=2Ehead;
+        while (e)
+        {
+            if (e->enable)
+=
            {
+                msg(D_SHOW_PARMS, "  push_entry =3D '%s'", e=
->option);
+            }
+            e =3D e->next;
+        }
+    }
+  =
  SHOW_BOOL(ifconfig_pool_defined);
+    msg(D_SHOW_PARMS, "  ifconfig_pool=
_start =3D %s",
+        print_in_addr_t(o->ifconfig_pool_start, 0, &gc));
=
+    msg(D_SHOW_PARMS, "  ifconfig_pool_end =3D %s", print_in_addr_t(o->ifc=
onfig_pool_end, 0, &gc));
+    msg(D_SHOW_PARMS, "  ifconfig_pool_netmask =
=3D %s",
+        print_in_addr_t(o->ifconfig_pool_netmask, 0, &gc));
+    =
SHOW_STR(ifconfig_pool_persist_filename);
+    SHOW_INT(ifconfig_pool_persi=
st_refresh_freq);
+    SHOW_BOOL(ifconfig_ipv6_pool_defined);
+    msg(D_SH=
OW_PARMS, "  ifconfig_ipv6_pool_base =3D %s",
+        print_in6_addr(o->if=
config_ipv6_pool_base, 0, &gc));
+    SHOW_INT(ifconfig_ipv6_pool_netbits);=

+    SHOW_INT(n_bcast_buf);
+    SHOW_INT(tcp_queue_limit);
+    SHOW_INT(=
real_hash_size);
+    SHOW_INT(virtual_hash_size);
+    SHOW_STR(client_con=
nect_script);
+    SHOW_STR(learn_address_script);
+    SHOW_STR(client_dis=
connect_script);
+    SHOW_STR(client_crresponse_script);
+    SHOW_STR(cli=
ent_config_dir);
+    SHOW_BOOL(ccd_exclusive);
+    SHOW_STR(tmp_dir);
+  =
  SHOW_BOOL(push_ifconfig_defined);
+    msg(D_SHOW_PARMS, "  push_ifconfig=
_local =3D %s",
+        print_in_addr_t(o->push_ifconfig_local, 0, &gc));
=
+    msg(D_SHOW_PARMS, "  push_ifconfig_remote_netmask =3D %s",
+        pr=
int_in_addr_t(o->push_ifconfig_remote_netmask, 0, &gc));
+    SHOW_BOOL(pus=
h_ifconfig_ipv6_defined);
+    msg(D_SHOW_PARMS, "  push_ifconfig_ipv6_loca=
l =3D %s/%d",
+        print_in6_addr(o->push_ifconfig_ipv6_local, 0, &gc),=
 o->push_ifconfig_ipv6_netbits);
+    msg(D_SHOW_PARMS, "  push_ifconfig_ip=
v6_remote =3D %s",
+        print_in6_addr(o->push_ifconfig_ipv6_remote, 0,=
 &gc));
+    SHOW_BOOL(enable_c2c);
+    SHOW_BOOL(duplicate_cn);
+    SHOW=
_INT(cf_max);
+    SHOW_INT(cf_per);
+    SHOW_INT(cf_initial_max);
+    SH=
OW_INT(cf_initial_per);
+    SHOW_UINT(max_clients);
+    SHOW_INT(max_rout=
es_per_client);
+    SHOW_STR(auth_user_pass_verify_script);
+    SHOW_BOOL=
(auth_user_pass_verify_script_via_file);
+    SHOW_BOOL(auth_token_generate=
);
+    SHOW_BOOL(force_key_material_export);
+    SHOW_INT(auth_token_life=
time);
+    SHOW_STR_INLINE(auth_token_secret_file);
+#if PORT_SHARE
+    S=
HOW_STR(port_share_host);
+    SHOW_STR(port_share_port);
+#endif
+    SHOW=
_BOOL(vlan_tagging);
+    msg(D_SHOW_PARMS, "  vlan_accept =3D %s", print_v=
lan_accept(o->vlan_accept));
+    SHOW_INT(vlan_pvid);
+
+    SHOW_BOOL(cli=
ent);
+    SHOW_BOOL(pull);
+    SHOW_STR_INLINE(auth_user_pass_file);
+
+ =
   gc_free(&gc);
+}
+
+static void
+show_http_proxy_options(const struct ht=
tp_proxy_options *o)
+{
+    int i;
+    msg(D_SHOW_PARMS, "BEGIN http_prox=
y");
+    SHOW_STR(server);
+    SHOW_STR(port);
+    SHOW_STR(auth_method_=
string);
+    SHOW_STR(auth_file);
+    SHOW_STR(auth_file_up);
+    SHOW_B=
OOL(inline_creds);
+    SHOW_BOOL(nocache);
+    SHOW_STR(http_version);
+ =
   SHOW_STR(user_agent);
+    for (i =3D 0; i < MAX_CUSTOM_HTTP_HEADER && o=
->custom_headers[i]=2Ename; i++)
+    {
+        if (o->custom_headers[i]=
=2Econtent)
+        {
+            msg(D_SHOW_PARMS, "  custom_header[%d] =
=3D %s: %s", i, o->custom_headers[i]=2Ename,
+                o->custom_hea=
ders[i]=2Econtent);
+        }
+        else
+        {
+            msg(D_=
SHOW_PARMS, "  custom_header[%d] =3D %s", i, o->custom_headers[i]=2Ename);
=
+        }
+    }
+    msg(D_SHOW_PARMS, "END http_proxy");
+}
+
+static vo=
id
+show_connection_entry(const struct connection_entry *o)
+{
+    /* Disp=
lay the global proto only in client mode or with no '--local'*/
+    if (o-=
>local_list->len =3D=3D 1)
+    {
+        msg(D_SHOW_PARMS, "  proto =3D %=
s", proto2ascii(o->proto, o->af, false));
+    }
+
+    msg(D_SHOW_PARMS, "=
  Local Sockets:");
+    for (int i =3D 0; i < o->local_list->len; i++)
+  =
  {
+        msg(D_SHOW_PARMS, "    [%s]:%s-%s", o->local_list->array[i]->l=
ocal,
+            o->local_list->array[i]->port,
+            proto2ascii(=
o->local_list->array[i]->proto, o->af, false));
+    }
+    SHOW_STR(remote=
);
+    SHOW_STR(remote_port);
+    SHOW_BOOL(remote_float);
+    SHOW_BOOL=
(bind_defined);
+    SHOW_BOOL(bind_local);
+    SHOW_BOOL(bind_ipv6_only);=

+    SHOW_INT(connect_retry_seconds);
+    SHOW_INT(connect_timeout);
+
+ =
   if (o->http_proxy_options)
+    {
+        show_http_proxy_options(o->ht=
tp_proxy_options);
+    }
+    SHOW_STR(socks_proxy_server);
+    SHOW_STR(=
socks_proxy_port);
+    SHOW_INT(tun_mtu);
+    SHOW_BOOL(tun_mtu_defined);=

+    SHOW_INT(link_mtu);
+    SHOW_BOOL(link_mtu_defined);
+    SHOW_INT(t=
un_mtu_extra);
+    SHOW_BOOL(tun_mtu_extra_defined);
+    SHOW_INT(tls_mtu=
);
+
+    SHOW_INT(mtu_discover_type);
+
+#ifdef ENABLE_FRAGMENT
+    SHOW_=
INT(fragment);
+#endif
+    SHOW_INT(mssfix);
+    SHOW_BOOL(mssfix_encap);=

+    SHOW_BOOL(mssfix_fixed);
+
+    SHOW_INT(explicit_exit_notification);=

+
+    SHOW_STR_INLINE(tls_auth_file);
+    SHOW_PARM(key_direction, keydi=
rection2ascii(o->key_direction, false, true), "%s");
+    SHOW_STR_INLINE(t=
ls_crypt_file);
+    SHOW_STR_INLINE(tls_crypt_v2_file);
+}
+
+
+static voi=
d
+show_connection_entries(const struct options *o)
+{
+    if (o->connecti=
on_list)
+    {
+        const struct connection_list *l =3D o->connection_=
list;
+        int i;
+        for (i =3D 0; i < l->len; ++i)
+        {
+ =
           msg(D_SHOW_PARMS, "Connection profiles [%d]:", i);
+            =
show_connection_entry(l->array[i]);
+        }
+    }
+    else
+    {
+   =
     msg(D_SHOW_PARMS, "Connection profiles [default]:");
+        show_con=
nection_entry(&o->ce);
+    }
+    msg(D_SHOW_PARMS, "Connection profiles E=
ND");
+}
+
+static void
+show_pull_filter_list(const struct pull_filter_lis=
t *l)
+{
+    struct pull_filter *f;
+    if (!l)
+    {
+        return;
+=
    }
+
+    msg(D_SHOW_PARMS, "  Pull filters:");
+    for (f =3D l->head;=
 f; f =3D f->next)
+    {
+        msg(D_SHOW_PARMS, "    %s \"%s\"", pull_=
filter_type_name(f->type), f->pattern);
+    }
+}
+
+void
+show_settings(co=
nst struct options *o)
+{
+    msg(D_SHOW_PARMS, "Current Parameter Setting=
s:");
+
+    SHOW_STR(config);
+
+    SHOW_INT(mode);
+
+#ifdef ENABLE_FEAT=
URE_TUN_PERSIST
+    SHOW_BOOL(persist_config);
+    SHOW_INT(persist_mode)=
;
+#endif
+
+    SHOW_BOOL(show_ciphers);
+    SHOW_BOOL(show_digests);
+  =
  SHOW_BOOL(show_engines);
+    SHOW_BOOL(genkey);
+    SHOW_STR(genkey_fil=
ename);
+    SHOW_STR(key_pass_file);
+    SHOW_BOOL(show_tls_ciphers);
+
+=
    SHOW_INT(connect_retry_max);
+    show_connection_entries(o);
+
+    SH=
OW_BOOL(remote_random);
+
+    SHOW_STR(ipchange);
+    SHOW_STR(dev);
+   =
 SHOW_STR(dev_type);
+    SHOW_STR(dev_node);
+#if defined(ENABLE_DCO)
+   =
 SHOW_BOOL(disable_dco);
+#endif
+    SHOW_STR(lladdr);
+    SHOW_INT(topol=
ogy);
+    SHOW_STR(ifconfig_local);
+    SHOW_STR(ifconfig_remote_netmask)=
;
+    SHOW_BOOL(ifconfig_noexec);
+    SHOW_BOOL(ifconfig_nowarn);
+    SH=
OW_STR(ifconfig_ipv6_local);
+    SHOW_INT(ifconfig_ipv6_netbits);
+    SHO=
W_STR(ifconfig_ipv6_remote);
+
+    SHOW_INT(shaper);
+    SHOW_INT(mtu_tes=
t);
+
+    SHOW_BOOL(mlock);
+
+    SHOW_INT(keepalive_ping);
+    SHOW_INT=
(keepalive_timeout);
+    SHOW_INT(inactivity_timeout);
+    SHOW_INT(sessi=
on_timeout);
+    SHOW_INT64(inactivity_minimum_bytes);
+    SHOW_INT(ping_=
send_timeout);
+    SHOW_INT(ping_rec_timeout);
+    SHOW_INT(ping_rec_time=
out_action);
+    SHOW_BOOL(ping_timer_remote);
+    SHOW_INT(remap_sigusr1=
);
+    SHOW_BOOL(persist_tun);
+    SHOW_BOOL(persist_local_ip);
+    SHOW=
_BOOL(persist_remote_ip);
+
+#if PASSTOS_CAPABILITY
+    SHOW_BOOL(passtos)=
;
+#endif
+
+    SHOW_INT(resolve_retry_seconds);
+    SHOW_BOOL(resolve_in=
_advance);
+
+    SHOW_STR(username);
+    SHOW_STR(groupname);
+    SHOW_S=
TR(chroot_dir);
+    SHOW_STR(cd_dir);
+#ifdef ENABLE_SELINUX
+    SHOW_STR=
(selinux_context);
+#endif
+    SHOW_STR(writepid);
+    SHOW_STR(up_script=
);
+    SHOW_STR(down_script);
+    SHOW_BOOL(down_pre);
+    SHOW_BOOL(up_=
restart);
+    SHOW_BOOL(up_delay);
+    SHOW_BOOL(daemon);
+    SHOW_BOOL(=
log);
+    SHOW_BOOL(suppress_timestamps);
+    SHOW_BOOL(machine_readable_=
output);
+    SHOW_INT(nice);
+    SHOW_INT(verbosity);
+    SHOW_INT(mute)=
;
+#ifdef ENABLE_DEBUG
+    SHOW_INT(gremlin);
+#endif
+    SHOW_STR(status=
_file);
+    SHOW_INT(status_file_version);
+    SHOW_INT(status_file_updat=
e_freq);
+
+    SHOW_BOOL(occ);
+    SHOW_INT(rcvbuf);
+    SHOW_INT(sndbuf=
);
+#if defined(TARGET_LINUX)
+    SHOW_INT(mark);
+#endif
+    SHOW_INT(so=
ckflags);
+
+    SHOW_INT(comp=2Ealg);
+    SHOW_INT(comp=2Eflags);
+
+    =
SHOW_STR(route_script);
+    SHOW_STR(route_default_gateway);
+    SHOW_INT=
(route_default_metric);
+    SHOW_INT(route_default_table_id);
+    SHOW_BO=
OL(route_noexec);
+    SHOW_INT(route_delay);
+    SHOW_INT(route_delay_win=
dow);
+    SHOW_BOOL(route_delay_defined);
+    SHOW_BOOL(route_nopull);
+ =
   SHOW_BOOL(route_gateway_via_dhcp);
+    SHOW_BOOL(allow_pull_fqdn);
+   =
 show_pull_filter_list(o->pull_filter_list);
+
+    if (o->routes)
+    {
+=
        print_route_options(o->routes, D_SHOW_PARMS);
+    }
+
+    if (o->=
client_nat)
+    {
+        print_client_nat_list(o->client_nat, D_SHOW_PAR=
MS);
+    }
+
+    show_dns_options(&o->dns_options);
+
+#ifdef ENABLE_MANA=
GEMENT
+    SHOW_STR(management_addr);
+    SHOW_STR(management_port);
+   =
 SHOW_STR(management_user_pass);
+    SHOW_INT(management_log_history_cache=
);
+    SHOW_INT(management_echo_buffer_size);
+    SHOW_STR(management_cli=
ent_user);
+    SHOW_STR(management_client_group);
+    SHOW_INT(management=
_flags);
+#endif
+#ifdef ENABLE_PLUGIN
+    if (o->plugin_list)
+    {
+   =
     plugin_option_list_print(o->plugin_list, D_SHOW_PARMS);
+    }
+#endif=

+
+    SHOW_STR_INLINE(shared_secret_file);
+    SHOW_PARM(key_direction, =
keydirection2ascii(o->key_direction, false, true), "%s");
+    SHOW_STR(cip=
hername);
+    SHOW_STR(ncp_ciphers);
+    SHOW_STR(authname);
+#ifndef ENA=
BLE_CRYPTO_MBEDTLS
+    SHOW_BOOL(engine);
+#endif /* ENABLE_CRYPTO_MBEDTLS=
 */
+    SHOW_BOOL(mute_replay_warnings);
+    SHOW_INT(replay_window);
+  =
  SHOW_INT(replay_time);
+    SHOW_STR(packet_id_file);
+    SHOW_BOOL(test=
_crypto);
+
+    SHOW_BOOL(tls_server);
+    SHOW_BOOL(tls_client);
+    SH=
OW_STR_INLINE(ca_file);
+    SHOW_STR(ca_path);
+    SHOW_STR_INLINE(dh_fil=
e);
+    if ((o->management_flags & MF_EXTERNAL_CERT))
+    {
+        SHOW=
_PARM("cert_file", "EXTERNAL_CERT", "%s");
+    }
+    else
+    {
+       =
 SHOW_STR_INLINE(cert_file);
+    }
+    SHOW_STR_INLINE(extra_certs_file);=

+
+    if ((o->management_flags & MF_EXTERNAL_KEY))
+    {
+        SHOW_P=
ARM("priv_key_file", "EXTERNAL_PRIVATE_KEY", "%s");
+    }
+    else
+    {=

+        SHOW_STR_INLINE(priv_key_file);
+    }
+#ifndef ENABLE_CRYPTO_MBE=
DTLS
+    SHOW_STR_INLINE(pkcs12_file);
+#endif
+#ifdef ENABLE_CRYPTOAPI
+ =
   SHOW_STR(cryptoapi_cert);
+#endif
+    SHOW_STR(cipher_list);
+    SHOW_=
STR(cipher_list_tls13);
+    SHOW_STR(tls_cert_profile);
+    SHOW_STR(tls_=
verify);
+    SHOW_STR(tls_export_peer_cert_dir);
+    SHOW_INT(verify_x509=
_type);
+    SHOW_STR(verify_x509_name);
+    SHOW_STR_INLINE(crl_file);
+ =
   SHOW_INT(ns_cert_type);
+    {
+        int i;
+        for (i =3D 0; i =
< MAX_PARMS; i++)
+        {
+            SHOW_INT(remote_cert_ku[i]);
+   =
     }
+    }
+    SHOW_STR(remote_cert_eku);
+    if (o->verify_hash)
+   =
 {
+        SHOW_INT(verify_hash_algo);
+        SHOW_INT(verify_hash_depth=
);
+        struct gc_arena gc =3D gc_new();
+        const struct verify_h=
ash_list *hl =3D o->verify_hash;
+        int digest_len =3D
+            (=
o->verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGEST_LEN=
GTH;
+        while (hl)
+        {
+            char *s =3D format_hex_ex(=
hl->hash, digest_len, 0, 1, ":", &gc);
+            SHOW_PARM(verify_hash, =
s, "%s");
+            hl =3D hl->next;
+        }
+        gc_free(&gc);
+=
    }
+    SHOW_INT(ssl_flags);
+
+    SHOW_INT(tls_timeout);
+
+    SHOW_I=
NT64(renegotiate_bytes);
+    SHOW_INT64(renegotiate_packets);
+    SHOW_IN=
T(renegotiate_seconds);
+
+    SHOW_INT(handshake_window);
+    SHOW_INT(tr=
ansition_window);
+
+    SHOW_BOOL(single_session);
+    SHOW_BOOL(push_pee=
r_info);
+    SHOW_BOOL(tls_exit);
+
+    SHOW_STR(tls_crypt_v2_metadata);
=
+
+#ifdef ENABLE_PKCS11
+    {
+        int i;
+        for (i =3D 0; i < M=
AX_PARMS && o->pkcs11_providers[i] !=3D NULL; i++)
+        {
+            =
SHOW_PARM(pkcs11_providers, o->pkcs11_providers[i], "%s");
+        }
+    =
}
+    {
+        int i;
+        for (i =3D 0; i < MAX_PARMS; i++)
+      =
  {
+            SHOW_PARM(pkcs11_protected_authentication,
+              =
        o->pkcs11_protected_authentication[i] ? "ENABLED" : "DISABLED", "%s=
");
+        }
+    }
+    {
+        int i;
+        for (i =3D 0; i < MAX=
_PARMS; i++)
+        {
+            SHOW_PARM(pkcs11_private_mode, o->pkcs=
11_private_mode[i], "%08x");
+        }
+    }
+    {
+        int i;
+    =
    for (i =3D 0; i < MAX_PARMS; i++)
+        {
+            SHOW_PARM(pkc=
s11_cert_private, o->pkcs11_cert_private[i] ? "ENABLED" : "DISABLED",
+    =
                  "%s");
+        }
+    }
+    SHOW_INT(pkcs11_pin_cache_p=
eriod);
+    SHOW_STR(pkcs11_id);
+    SHOW_BOOL(pkcs11_id_management);
+#e=
ndif /* ENABLE_PKCS11 */
+
+    show_p2mp_parms(o);
+
+#ifdef _WIN32
+    S=
HOW_BOOL(show_net_up);
+    SHOW_INT(route_method);
+    SHOW_BOOL(block_ou=
tside_dns);
+    show_tuntap_options(&o->tuntap_options);
+#endif
+}
+
+#en=
dif /* ifndef ENABLE_SMALL */
diff --git a/src/openvpn/options_show=2Eh b/s=
rc/openvpn/options_show=2Eh
new file mode 100644
index 0000000=2E=2Efb233fc=

--- /dev/null
+++ b/src/openvpn/options_show=2Eh
@@ -0,0 +1,46 @@
+/*
+ * =
 OpenVPN -- An application to securely tunnel IP networks
+ *             o=
ver a single UDP port, with support for SSL/TLS-based
+ *             sessi=
on authentication and key exchange,
+ *             packet encryption, pack=
et authentication, and
+ *             packet compression=2E
+ *
+ *  Copyr=
ight (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program =
is free software; you can redistribute it and/or modify
+ *  it under the t=
erms of the GNU General Public License version 2
+ *  as published by the F=
ree Software Foundation=2E
+ *
+ *  This program is distributed in the hope=
 that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the im=
plied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */=

+
+#ifndef OPTIONS_SHOW_H
+#define OPTIONS_SHOW_H
+
+#ifdef HAVE_CONFIG_H
=
+#include "config=2Eh"
+#endif
+
+#include "options=2Eh"
+
+#ifdef ENABLE_S=
MALL
+
+static inline void
+show_settings(const struct options *o)
+{
+    =
(void)o;
+}
+
+#else
+
+void show_settings(const struct options *o);
+
+#en=
dif /* ENABLE_SMALL */
+
+#endif /* OPTIONS_SHOW_H */

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
G=
errit-Change-Number: 1772
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--zWGPk4/eFv0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1772?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">options: Factor out options display code f=
rom options=2Ec<br><br>options=2Ec is a huge, unwieldly file=2E So remove s=
ome<br>closely related code that has no direct dependencies<br>with the oth=
er functions in the file=2E<br><br>In this case it is the code that prints =
out the current<br>configuration=2E<br><br>Change-Id: I61762374c141662d596b=
bf88b64ca7f7472b5149<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772<br>Message-Id:=
 &lt;20260817161852=2E8376-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38466=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/openvp=
n=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/op=
envpn/options_show=2Ec<br>A src/openvpn/options_show=2Eh<br>7 files changed=
, 683 insertions(+), 620 deletions(-)<br><br></pre>
<pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt</span><br><span>index aae264e=2E=2E4eda75b 100=
644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -529,6 +529,8 @@</span><br><span>     src/openvpn=
/options_util=2Ec</span><br><span>     src/openvpn/options_util=2Eh</span><=
br><span>     src/openvpn/options_parse=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    src/openvpn/options_show=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options_show=2Eh</span=
><br><span>     src/openvpn/otime=2Ec</span><br><span>     src/openvpn/otim=
e=2Eh</span><br><span>     src/openvpn/ovpn_dco_win=2Eh</span><br><span>dif=
f --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><=
span>index 1f77384=2E=2E2092e96 100644</span><br><span>--- a/src/openvpn/Ma=
kefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span=
>@@ -108,6 +108,7 @@</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span=
> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	options_show=2Ec opti=
ons_show=2Eh \</span><br><span> 	options_util=2Ec options_util=2Eh \</span>=
<br><span> 	options_parse=2Ec \</span><br><span> 	otime=2Ec otime=2Eh \</sp=
an><br><span>diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec=
</span><br><span>index f38660f=2E=2E7d35195 100644</span><br><span>--- a/sr=
c/openvpn/openvpn=2Ec</span><br><span>+++ b/src/openvpn/openvpn=2Ec</span><=
br><span>@@ -30,6 +30,7 @@</span><br><span> #include &quot;forward=2Eh&quot=
;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><span> #include=
 &quot;win32=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;options_show=2Eh&quot;</span><br><span> #include &quot;pl=
atform=2Eh&quot;</span><br><span> #include &quot;string=2Eh&quot;</span><br=
><span> </span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn=
/options=2Ec</span><br><span>index 4aebfea=2E=2Ee899fa6 100644</span><br><s=
pan>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -914,41 +914,6 @@</span><br><span>     gc_free(&amp=
;o-&gt;dns_options=2Egc);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static const char *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-pull_filter_type_name(int type)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (type =3D=3D PUF_TYPE_ACCEPT)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return &quot;accept&quot;;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (type =3D=3D PUF_TYPE_IGNORE)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return &quot;ignore&quot;;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (type =3D=3D PUF_TYPE_REJECT)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return &quot;reject&quot;;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return &quot;???&quot;;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, &quot;  &quot; #name &qu=
ot; =3D &quot; format, (value))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define SHOW_STR(var)                  SHOW_PARM(var, (o-&gt;var =
? o-&gt;var : &quot;[UNDEF]&quot;), &quot;&#39;%s&#39;&quot;)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_STR_INLINE(var) \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_PARM(var, o-&gt;v=
ar##_inline ? &quot;[INLINE]&quot; : (o-&gt;var ? o-&gt;var : &quot;[UNDEF]=
&quot;), &quot;&#39;%s&#39;&quot;)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define SHOW_INT(var)      SHOW_PARM(var, o-&gt;var, &quot;%d&=
quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_UI=
NT(var)     SHOW_PARM(var, o-&gt;var, &quot;%u&quot;)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define SHOW_INT64(var)    SHOW_PARM(var, o=
-&gt;var, &quot;%&quot; PRIi64)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define SHOW_UNSIGNED(var) SHOW_PARM(var, o-&gt;var, &quot;0x%08x=
&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_B=
OOL(var)     SHOW_PARM(var, (o-&gt;var ? &quot;ENABLED&quot; : &quot;DISABL=
ED&quot;), &quot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifnde=
f ENABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> static void</span><br><span> setenv_connection_entry(struct e=
nv_set *es, const struct connection_entry *e, const int i)</span><br><span>=
 {</span><br><span>@@ -1240,55 +1205,6 @@</span><br><span> </span><br><span=
>     return ret;</span><br><span> }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE=
_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-show_dhcp_option_list(const char *name, const =
char *const *array, unsigned int len)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
for (unsigned int i =3D 0; i &lt; len; ++i)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s&quot;, name, i, array=
[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_dhc=
p_option_addrs(const char *name, const in_addr_t *array, unsigned int len)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (unsigned int i =3D=
 0; i &lt; len; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_SHO=
W_PARMS, &quot;  %s[%u] =3D %s&quot;, name, i, print_in_addr_t(array[i], 0,=
 &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sh=
ow_tuntap_options(const struct tuntap_options *o)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    SHOW_BOOL(ip_win32_defined);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    SHOW_INT(ip_win32_type);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_INT(dhcp_masq_offset);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(dhcp_lease_time);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(tap_sleep);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_UNSIGNED(dhcp_opti=
ons);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(dh=
cp_renew);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BO=
OL(dhcp_pre_release);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_STR(domain);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_STR(netbios_scope);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_UNSIGNED(netbios_node_type);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_BOOL(disable_nbt);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    show_dhcp_option_addrs(&quot;DNS&quot;, o-&gt;dns, o-&gt;dns_le=
n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_dhcp_opti=
on_addrs(&quot;WINS&quot;, o-&gt;wins, o-&gt;wins_len);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    show_dhcp_option_addrs(&quot;NTP&quot=
;, o-&gt;ntp, o-&gt;ntp_len);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    show_dhcp_option_addrs(&quot;NBDD&quot;, o-&gt;nbdd, o-&gt;nbdd=
_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_dhcp_o=
ption_list(&quot;DOMAIN-SEARCH&quot;, o-&gt;domain_search_list, o-&gt;domai=
n_search_list_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef ENABLE_SMALL */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef _WIN32 */</span>=
<br><span> </span><br><span> static void</span><br><span> dhcp_option_dns6_=
parse(const char *parm, struct in6_addr *dns6_list, unsigned int *len, msgl=
vl_t msglevel)</span><br><span>@@ -1331,116 +1247,6 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static const char *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-print_vlan_accept(enum vlan_acceptable_frames mode)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    switch (mode)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        case VLAN_ONLY_TAGGED:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            return &quot;tagged&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        case VLAN_ONLY_UNTAGGED_OR_PRIORITY:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            return &quot;untagged&quot;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case VLAN_ALL:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            return &quot;all&quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-show_p2mp_parms(const st=
ruct options *o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot; =
 server_network =3D %s&quot;, print_in_addr_t(o-&gt;server_network, 0, &amp=
;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_=
PARMS, &quot;  server_netmask =3D %s&quot;, print_in_addr_t(o-&gt;server_ne=
tmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   msg(D_SHOW_PARMS, &quot;  server_network_ipv6 =3D %s&quot;, print_in6_ad=
dr(o-&gt;server_network_ipv6, 0, &amp;gc));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    SHOW_INT(server_netbits_ipv6);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_bri=
dge_ip =3D %s&quot;, print_in_addr_t(o-&gt;server_bridge_ip, 0, &amp;gc));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, =
&quot;  server_bridge_netmask =3D %s&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;server_bridge_netmask, =
0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
D_SHOW_PARMS, &quot;  server_bridge_pool_start =3D %s&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;server=
_bridge_pool_start, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_bridge_pool_end =3D %s&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_in_a=
ddr_t(o-&gt;server_bridge_pool_end, 0, &amp;gc));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (o-&gt;push_list=2Ehead)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        const struct push_entry *e =3D o-&gt;push_lis=
t=2Ehead;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        whil=
e (e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (e-&gt;enable=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_SHOW_P=
ARMS, &quot;  push_entry =3D &#39;%s&#39;&quot;, e-&gt;option);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            e =3D e-&gt;next;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_BOOL(ifconfig_pool_defined);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  ifconfig_pool=
_start =3D %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       print_in_addr_t(o-&gt;ifconfig_pool_start, 0, &amp;gc));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  ifc=
onfig_pool_end =3D %s&quot;, print_in_addr_t(o-&gt;ifconfig_pool_end, 0, &a=
mp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHO=
W_PARMS, &quot;  ifconfig_pool_netmask =3D %s&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;ifconfig_pool=
_netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_STR(ifconfig_pool_persist_filename);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_INT(ifconfig_pool_persist_refresh_freq);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ifconfi=
g_ipv6_pool_defined);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg(D_SHOW_PARMS, &quot;  ifconfig_ipv6_pool_base =3D %s&quot;,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        print_in6_addr(o-&gt;=
ifconfig_ipv6_pool_base, 0, &amp;gc));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    SHOW_INT(ifconfig_ipv6_pool_netbits);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(n_bcast_buf);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(tcp_queue_limit);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(real_hash_s=
ize);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(vir=
tual_hash_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_STR(client_connect_script);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    SHOW_STR(learn_address_script);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_STR(client_disconnect_script);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(client_crresponse_sc=
ript);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(cl=
ient_config_dir);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_BOOL(ccd_exclusive);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_STR(tmp_dir);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_BOOL(push_ifconfig_defined);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  push_ifconfig_local =3D =
%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        prin=
t_in_addr_t(o-&gt;push_ifconfig_local, 0, &amp;gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  push_ifconfig=
_remote_netmask =3D %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        print_in_addr_t(o-&gt;push_ifconfig_remote_netmask, 0, &amp=
;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(p=
ush_ifconfig_ipv6_defined);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(D_SHOW_PARMS, &quot;  push_ifconfig_ipv6_local =3D %s/%d&quot=
;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_in6_a=
ddr(o-&gt;push_ifconfig_ipv6_local, 0, &amp;gc), o-&gt;push_ifconfig_ipv6_n=
etbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHO=
W_PARMS, &quot;  push_ifconfig_ipv6_remote =3D %s&quot;,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        print_in6_addr(o-&gt;push_ifconf=
ig_ipv6_remote, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    SHOW_BOOL(enable_c2c);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SHOW_BOOL(duplicate_cn);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_INT(cf_max);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_INT(cf_per);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_INT(cf_initial_max);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_INT(cf_initial_per);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_UINT(max_clients);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(max_routes_per_clien=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(auth_=
user_pass_verify_script);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_BOOL(auth_user_pass_verify_script_via_file);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(auth_token_generate);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(force_key_m=
aterial_export);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_INT(auth_token_lifetime);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    SHOW_STR_INLINE(auth_token_secret_file);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if PORT_SHARE</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    SHOW_STR(port_share_host);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(port_share_port);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_BOOL(vlan_tagging);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  vlan_accep=
t =3D %s&quot;, print_vlan_accept(o-&gt;vlan_accept));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(vlan_pvid);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    SHOW_BOOL(client);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_BOOL(pull);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    SHOW_STR_INLINE(auth_user_pass_file);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ! ENABLE_SMALL */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> sta=
tic void</span><br><span> option_iroute(struct options *o, const char *netw=
ork_str, const char *netmask_str,</span><br><span>               msglvl_t m=
sglevel)</span><br><span>@@ -1485,37 +1291,6 @@</span><br><span>     o-&gt;=
iroutes_ipv6 =3D ir;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-show_http_proxy_options(const struct http_proxy_op=
tions *o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;BEGIN http_prox=
y&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR=
(server);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR=
(port);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(a=
uth_method_string);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  SHOW_STR(auth_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    SHOW_STR(auth_file_up);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_BOOL(inline_creds);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_BOOL(nocache);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_STR(http_version);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    SHOW_STR(user_agent);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; MAX_CUSTOM_HTTP_HEADER &=
amp;&amp; o-&gt;custom_headers[i]=2Ename; i++)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (o-&gt;custom_headers[i]=2Econtent)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(D_SHOW_PARMS, &quot;  custom_header[%=
d] =3D %s: %s&quot;, i, o-&gt;custom_headers[i]=2Ename,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                o-&gt;custom_headers[i]=
=2Econtent);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(D_SHOW_PARMS, &quot;  cust=
om_header[%d] =3D %s&quot;, i, o-&gt;custom_headers[i]=2Ename);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;END http_proxy&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* ifndef ENABLE_SMALL */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span>=
 options_detach(struct options *o)</span><br><span> {</span><br><span>@@ -1=
563,399 +1338,6 @@</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMA=
LL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-show_connection_entry(const s=
truct connection_entry *o)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Display =
the global proto only in client mode or with no &#39;--local&#39;*/</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;local_list-&gt;=
len =3D=3D 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS=
, &quot;  proto =3D %s&quot;, proto2ascii(o-&gt;proto, o-&gt;af, false));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  Local Sockets:&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; =
o-&gt;local_list-&gt;len; i++)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(D_SHOW_PARMS, &quot;    [%s]:%s-%s&quot;, o-&gt;local_list-&gt;array[i=
]-&gt;local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   o-&gt;local_list-&gt;array[i]-&gt;port,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            proto2ascii(o-&gt;local_list-&gt;array[i]-=
&gt;proto, o-&gt;af, false));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_STR(remote);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_STR(remote_port);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_BOOL(remote_float);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_BOOL(bind_defined);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_BOOL(bind_local);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_BOOL(bind_ipv6_only);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    SHOW_INT(connect_retry_seconds);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(connect_timeout);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (o-&gt;http_proxy_options)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        show_http_proxy_options(o-&gt;http_proxy_op=
tions);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(socks_proxy_serve=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(socks=
_proxy_port);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_INT(tun_mtu);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHO=
W_BOOL(tun_mtu_defined);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_INT(link_mtu);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_BOOL(link_mtu_defined);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_INT(tun_mtu_extra);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_BOOL(tun_mtu_extra_defined);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(tls_mtu);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    SHOW_INT(mtu_discover_type);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_FRAGMENT</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    SHOW_INT(fragment);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_INT(mssfix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_BOOL(mssfix_encap);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    SHOW_BOOL(mssfix_fixed);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_INT(explicit_exit_notification);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_=
STR_INLINE(tls_auth_file);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_PARM(key_direction, keydirection2ascii(o-&gt;key_direction, f=
alse, true), &quot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    SHOW_STR_INLINE(tls_crypt_file);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(tls_crypt_v2_file);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-show_connection_entries(const s=
truct options *o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;connection=
_list)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        const struct connection=
_list *l =3D o-&gt;connection_list;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        for (i =3D 0; i &lt; l-&gt;len; ++i)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(D_SHOW_PARMS, &quot;Connection profiles=
 [%d]:&quot;, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        show_connection_entry(l-&gt;array[i]);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quot;=
Connection profiles [default]:&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        show_connection_entry(&amp;o-&gt;ce);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;Connection profiles EN=
D&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-show_pull_filter_list(const struct pull_filter_list *l)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct pull_filter *f;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!l)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  Pull fi=
lters:&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for=
 (f =3D l-&gt;head; f; f =3D f-&gt;next)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(D_SHOW_PARMS, &quot;    %s \&quot;%s\&quot;&quot;, pull_filt=
er_type_name(f-&gt;type), f-&gt;pattern);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef ENABLE_SMALL */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-show_settings(const struct options *o)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    msg(D_SHOW_PARMS, &quot;Current Parameter Settings:&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_STR(config);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_INT(mode);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_FE=
ATURE_TUN_PERSIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_BOOL(persist_config);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_INT(persist_mode);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(show_cipher=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(show=
_digests);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BO=
OL(show_engines);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_BOOL(genkey);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_STR(genkey_filename);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    SHOW_STR(key_pass_file);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SHOW_BOOL(show_tls_ciphers);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_INT(connect_retry_max);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    show_connection_entries(o);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_BOOL(remote_random);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_S=
TR(ipchange);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_STR(dev);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_ST=
R(dev_type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_=
STR(dev_node);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(ENABLE_DCO)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_BOOL(disable_dco);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(l=
laddr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(t=
opology);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR=
(ifconfig_local);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_STR(ifconfig_remote_netmask);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SHOW_BOOL(ifconfig_noexec);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_BOOL(ifconfig_nowarn);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(ifconfig_ipv6_local);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ifconfig_ipv6_ne=
tbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(i=
fconfig_ipv6_remote);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(shaper);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(mtu_test=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(mlock);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_INT(keepalive_ping);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    SHOW_INT(keepalive_timeout);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(inactivity_timeout);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(session_timeout);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT64(inacti=
vity_minimum_bytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_INT(ping_send_timeout);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    SHOW_INT(ping_rec_timeout);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_INT(ping_rec_timeout_action);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ping_timer_remote);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(remap_sigusr1=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(persi=
st_tun);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL=
(persist_local_ip);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  SHOW_BOOL(persist_remote_ip);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if PASSTOS=
_CAPABILITY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_B=
OOL(passtos);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(resolve_retry_seconds);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(resolve_in_adv=
ance);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(username);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(groupname);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(chroot_dir);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(cd_dir);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_SELINUX</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(selinux_contex=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(writepid);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(up_script);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(down_script);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(down_pre)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(up_res=
tart);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(u=
p_delay);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOO=
L(daemon);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BO=
OL(log);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL=
(suppress_timestamps);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    SHOW_BOOL(machine_readable_output);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    SHOW_INT(nice);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    SHOW_INT(verbosity);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_INT(mute);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_INT(gremlin);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_STR(status_file);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_INT(status_file_version);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_INT(status_file_update_freq);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_BOOL(occ);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_INT(rcvbuf);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_INT(sndbuf);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_INT(mark);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    SHOW_INT(sockflags);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(comp=
=2Ealg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(=
comp=2Eflags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(route_script);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(route_def=
ault_gateway);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHO=
W_INT(route_default_metric);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_INT(route_default_table_id);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_BOOL(route_noexec);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(route_delay);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(route_delay_window);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(route_delay_=
defined);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOO=
L(route_nopull);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_BOOL(route_gateway_via_dhcp);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    SHOW_BOOL(allow_pull_fqdn);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    show_pull_filter_list(o-&gt;pull_filter_list);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;routes)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        print_route_options(o-&gt;routes, D_SHOW_PARMS);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (o-&gt;client_nat)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        print_client_nat_list(o-&gt;client_nat, D_SHOW_PARMS);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    show_dns_options(&amp;o-&gt;dns_options);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_STR(management_addr);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_STR(management_port);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_user_pass);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(management_log_h=
istory_cache);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHO=
W_INT(management_echo_buffer_size);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_STR(management_client_user);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_client_group);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(management_fl=
ags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PLUGIN</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;plugin_list)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        plugin_option_list_print(o-&gt;plug=
in_list, D_SHOW_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(shared_secret_file);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_PARM(key_direction, ke=
ydirection2ascii(o-&gt;key_direction, false, true), &quot;%s&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(ciphername);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(ncp_ciphers=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(authna=
me);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_CR=
YPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_=
BOOL(engine);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_BOOL(mute_replay_warnings);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_INT(replay_window);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_INT(replay_time);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(packet_id_file);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(test_crypto);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    SHOW_BOOL(tls_server);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(tls_client);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(ca_file);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(ca_path);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(dh_file);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((o-&gt;manage=
ment_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      SHOW_PARM(&quot;cert_file&quot;, &quot;EXTERNAL_CERT&quot;, &quot;%s&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        SHOW_STR_INLINE(cert_file);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_STR_INLINE(extra_certs_file);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if ((o-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        SHOW_PARM(&quot;priv_key_file&quot;=
, &quot;EXTERNAL_PRIVATE_KEY&quot;, &quot;%s&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        SHOW_=
STR_INLINE(priv_key_file);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENA=
BLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_STR_INLINE(pkcs12_file);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_STR(cryptoapi_cert);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_ST=
R(cipher_list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SH=
OW_STR(cipher_list_tls13);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_STR(tls_cert_profile);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    SHOW_STR(tls_verify);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    SHOW_STR(tls_export_peer_cert_dir);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(verify_x509_type);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(verify_x509_nam=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLIN=
E(crl_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_=
INT(ns_cert_type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &l=
t; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            SHO=
W_INT(remote_cert_ku[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(remote_cert=
_eku);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;v=
erify_hash)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        SHOW_INT(verify_ha=
sh_algo);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        SHOW=
_INT(verify_hash_depth);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct verify_hash_list *hl =3D o-&gt;verify_=
hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int dige=
st_len =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 (o-&gt;verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGES=
T_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        whil=
e (hl)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            char *s =3D for=
mat_hex_ex(hl-&gt;hash, digest_len, 0, 1, &quot;:&quot;, &amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            SHOW_PARM(verify_h=
ash, s, &quot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            hl =3D hl-&gt;next;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_IN=
T(ssl_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(tls_timeout);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT64(renegotiate_bytes);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT64(renegotiate_pac=
kets);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(re=
negotiate_seconds);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(handshake_=
window);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(=
transition_window);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(single_se=
ssion);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(=
push_peer_info);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_BOOL(tls_exit);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(tls_crypt_=
v2_metadata);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PKCS11</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; MAX_PARMS &amp;&amp; o-&=
gt;pkcs11_providers[i] !=3D NULL; i++)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            SHOW_PARM(pkcs11_providers, o-&gt;pkcs11_providers[i], &qu=
ot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            SHOW_PARM(pkcs11_protected_authentic=
ation,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
       o-&gt;pkcs11_protected_authentication[i] ? &quot;ENABLED&quot; : &qu=
ot;DISABLED&quot;, &quot;%s&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; MAX_PARM=
S; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            SHOW_PARM(pkcs=
11_private_mode, o-&gt;pkcs11_private_mode[i], &quot;%08x&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            SHOW_PARM(pkcs11_cert_private, o-&gt;pkcs11_cert_private[i]=
 ? &quot;ENABLED&quot; : &quot;DISABLED&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                      &quot;%s&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_INT(pkcs11_pin_cache_period);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(pkcs11_id);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(pkcs11_id_management);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_PKCS11 =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    show_p2mp_parms(o);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    SHOW_BOOL(show_net_up);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_INT(route_method);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_BOOL(block_outside_dns);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    show_tuntap_options(&amp;o-&gt;tuntap_o=
ptions);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef ENABLE_SMAL=
L */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#undef SHOW_PARM</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#undef SHOW_STR</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#undef SHOW_INT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#undef SHOW_BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br><span> st=
atic struct http_proxy_options *</span><br><span>diff --git a/src/openvpn/o=
ptions=2Eh b/src/openvpn/options=2Eh</span><br><span>index 30a146f=2E=2Ed42=
773f 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+=
++ b/src/openvpn/options=2Eh</span><br><span>@@ -901,8 +901,6 @@</span><br>=
<span> </span><br><span> void setenv_settings(struct env_set *es, const str=
uct options *o);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void show_settings(const struct options *o);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool string_defined_e=
qual(const char *s1, const char *s2);</span><br><span> </span><br><span> co=
nst char *options_string_version(const char *s, struct gc_arena *gc);</span=
><br><span>diff --git a/src/openvpn/options_show=2Ec b/src/openvpn/options_=
show=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2Eff090774</span><br><span>--- /dev/null</span><br><span>+++ b/src/open=
vpn/options_show=2Ec</span><br><span>@@ -0,0 +1,633 @@</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP netwo=
rks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             o=
ver a single UDP port, with support for SSL/TLS-based</span><br><span style=
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
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;options_show=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+pull_filter_type_name(int type)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (type =3D=3D PUF_TYPE_ACCEPT)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return &quot;accept&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (type =3D=3D PUF_TYPE_IGNORE)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return &quot;ignore&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (type =3D=3D PUF_TYPE_REJECT)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return &quot;reject&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return &quot;???&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define SHOW_PARM(name, value, fo=
rmat) msg(D_SHOW_PARMS, &quot;  &quot; #name &quot; =3D &quot; format, (val=
ue))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SHOW_ST=
R(var)                  SHOW_PARM(var, (o-&gt;var ? o-&gt;var : &quot;[UNDE=
F]&quot;), &quot;&#39;%s&#39;&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define SHOW_STR_INLINE(var) \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SHOW_PARM(var, o-&gt;var##_inline ? &quot;[=
INLINE]&quot; : (o-&gt;var ? o-&gt;var : &quot;[UNDEF]&quot;), &quot;&#39;%=
s&#39;&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e SHOW_INT(var)      SHOW_PARM(var, o-&gt;var, &quot;%d&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define SHOW_UINT(var)     SHOW_=
PARM(var, o-&gt;var, &quot;%u&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define SHOW_INT64(var)    SHOW_PARM(var, o-&gt;var, &quot=
;%&quot; PRIi64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine SHOW_UNSIGNED(var) SHOW_PARM(var, o-&gt;var, &quot;0x%08x&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SHOW_BOOL(var)   =
  SHOW_PARM(var, (o-&gt;var ? &quot;ENABLED&quot; : &quot;DISABLED&quot;), =
&quot;%s&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+show_dhcp_option_list(const char *name, const char *con=
st *array, unsigned int len)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
unsigned int i =3D 0; i &lt; len; ++i)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s&quot;, name, i, array[=
i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+show_dhcp_option_addrs(const char *name, const in_addr_t *array, unsigned =
int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uns=
igned int i =3D 0; i &lt; len; ++i)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s&quot;, name, i, print_in_=
addr_t(array[i], 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+show_tuntap_options(const struct tuntap_option=
s *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(ip_win32_defined);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ip_win=
32_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_I=
NT(dhcp_masq_offset);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SHOW_INT(dhcp_lease_time);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SHOW_INT(tap_sleep);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    SHOW_UNSIGNED(dhcp_options);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(dhcp_renew);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(dhcp_pre_release);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(domain);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(netbios_s=
cope);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UNSI=
GNED(netbios_node_type);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_BOOL(disable_nbt);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sh=
ow_dhcp_option_addrs(&quot;DNS&quot;, o-&gt;dns, o-&gt;dns_len);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    show_dhcp_option_addrs(&qu=
ot;WINS&quot;, o-&gt;wins, o-&gt;wins_len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    show_dhcp_option_addrs(&quot;NTP&quot;, o-&gt;n=
tp, o-&gt;ntp_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    show_dhcp_option_addrs(&quot;NBDD&quot;, o-&gt;nbdd, o-&gt;nbdd_len);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    show_dhcp_option_=
list(&quot;DOMAIN-SEARCH&quot;, o-&gt;domain_search_list, o-&gt;domain_sear=
ch_list_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef _WIN32 *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+print_vlan_accept(enum vlan_acceptabl=
e_frames mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (mode)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        case VLAN_ONLY_TAGGED:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;tag=
ged&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        case VLAN_ONLY_UNTAG=
GED_OR_PRIORITY:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return &quot;untagged&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       case VLAN_ALL:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return &quot;all&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+show_p2mp_parms(const struct options *o)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  server_netw=
ork =3D %s&quot;, print_in_addr_t(o-&gt;server_network, 0, &amp;gc));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &qu=
ot;  server_netmask =3D %s&quot;, print_in_addr_t(o-&gt;server_netmask, 0, =
&amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_SHOW_PARMS, &quot;  server_network_ipv6 =3D %s&quot;, print_in6_addr(o-&gt=
;server_network_ipv6, 0, &amp;gc));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_INT(server_netbits_ipv6);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  server_bridge_=
ip =3D %s&quot;, print_in_addr_t(o-&gt;server_bridge_ip, 0, &amp;gc));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &q=
uot;  server_bridge_netmask =3D %s&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        print_in_addr_t(o-&gt;server_bridge_netmask, =
0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms=
g(D_SHOW_PARMS, &quot;  server_bridge_pool_start =3D %s&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        print_in_addr_t(o-&gt;se=
rver_bridge_pool_start, 0, &amp;gc));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  server_bridge_pool_end =3D =
%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pr=
int_in_addr_t(o-&gt;server_bridge_pool_end, 0, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;push_list=2Ehead)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const struct push_entry *e =3D =
o-&gt;push_list=2Ehead;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        while (e)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (e-&gt;enable)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            msg(D_SHOW_PARMS, &quot;  push_entry =3D &#39;%s&#39;&quot;, e-=
&gt;option);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
 =3D e-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(ifconfig_pool=
_defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_SHOW_PARMS, &quot;  ifconfig_pool_start =3D %s&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        print_in_addr_t(o-&gt;ifconfig_p=
ool_start, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_end =3D %s&quot;, print_in=
_addr_t(o-&gt;ifconfig_pool_end, 0, &amp;gc));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_netm=
ask =3D %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      print_in_addr_t(o-&gt;ifconfig_pool_netmask, 0, &amp;gc));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(ifconfig_pool_per=
sist_filename);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_INT(ifconfig_pool_persist_refresh_freq);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SHOW_BOOL(ifconfig_ipv6_pool_defined);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quo=
t;  ifconfig_ipv6_pool_base =3D %s&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        print_in6_addr(o-&gt;ifconfig_ipv6_pool_base,=
 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_INT(ifconfig_ipv6_pool_netbits);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_INT(n_bcast_buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    SHOW_INT(tcp_queue_limit);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(real_hash_size);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(virtual_hash_size=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(clie=
nt_connect_script);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_STR(learn_address_script);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_STR(client_disconnect_script);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(client_crresponse_script);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(client=
_config_dir);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_BOOL(ccd_exclusive);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SHOW_STR(tmp_dir);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_BOOL(push_ifconfig_defined);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  push_ifconfig_local =
=3D %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  print_in_addr_t(o-&gt;push_ifconfig_local, 0, &amp;gc));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  push_i=
fconfig_remote_netmask =3D %s&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        print_in_addr_t(o-&gt;push_ifconfig_remote_netmask=
, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_BOOL(push_ifconfig_ipv6_defined);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  push_ifconfig_ipv6_local =
=3D %s/%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     print_in6_addr(o-&gt;push_ifconfig_ipv6_local, 0, &amp;gc), o-&gt;push=
_ifconfig_ipv6_netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(D_SHOW_PARMS, &quot;  push_ifconfig_ipv6_remote =3D %s&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_in6_ad=
dr(o-&gt;push_ifconfig_ipv6_remote, 0, &amp;gc));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_BOOL(enable_c2c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(duplicate_cn);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(cf_max);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(cf_per);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(cf_initial_m=
ax);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(cf=
_initial_per);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_UINT(max_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SHOW_INT(max_routes_per_client);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_STR(auth_user_pass_verify_script);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(auth_user_pass_ve=
rify_script_via_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SHOW_BOOL(auth_token_generate);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_BOOL(force_key_material_export);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(auth_token_lifetime);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE=
(auth_token_secret_file);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if PORT_SHARE</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_STR(port_share_host);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    SHOW_STR(port_share_port);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_BOOL(vlan_tagging);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  vlan_accept =3D %s&quot;, =
print_vlan_accept(o-&gt;vlan_accept));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_INT(vlan_pvid);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_BOOL(client);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_BOOL(pull);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    SHOW_STR_INLINE(auth_user_pass_file);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+show_http_proxy_options(const s=
truct http_proxy_options *o)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PAR=
MS, &quot;BEGIN http_proxy&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    SHOW_STR(server);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_STR(port);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_STR(auth_method_string);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_file);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_file_up);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(inline_creds);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(nocache)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(http_=
version);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_S=
TR(user_agent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (i =3D 0; i &lt; MAX_CUSTOM_HTTP_HEADER &amp;&amp; o-&gt;custom_headers=
[i]=2Ename; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt=
;custom_headers[i]=2Econtent)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(D_SHOW_PARMS, &quot;  custom_header[%d] =3D %s: %s&quot;, i=
, o-&gt;custom_headers[i]=2Ename,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                o-&gt;custom_headers[i]=2Econtent);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(D_SHOW_PARMS, &quot;  custom_header[%d] =
=3D %s&quot;, i, o-&gt;custom_headers[i]=2Ename);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(D_SHOW_PARMS, &quot;END http_proxy&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_con=
nection_entry(const struct connection_entry *o)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Display the global proto only in client mode or with no &#=
39;--local&#39;*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (o-&gt;local_list-&gt;len =3D=3D 1)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(D_SHOW_PARMS, &quot;  proto =3D %s&quot;, proto2ascii(o-=
&gt;proto, o-&gt;af, false));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &=
quot;  Local Sockets:&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int i =3D 0; i &lt; o-&gt;local_list-&gt;len; i++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;    [%s=
]:%s-%s&quot;, o-&gt;local_list-&gt;array[i]-&gt;local,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            o-&gt;local_list-&gt;array[=
i]-&gt;port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     proto2ascii(o-&gt;local_list-&gt;array[i]-&gt;proto, o-&gt;af, false))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(remote);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(remote_port);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(remote_fl=
oat);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(=
bind_defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_BOOL(bind_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SHOW_BOOL(bind_ipv6_only);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SHOW_INT(connect_retry_seconds);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_INT(connect_timeout);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (o-&gt;http_proxy_options)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        show_http_proxy_options(o-&gt;http_proxy_opti=
ons);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(socks_proxy_ser=
ver);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(s=
ocks_proxy_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_INT(tun_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_BOOL(tun_mtu_defined);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SHOW_INT(link_mtu);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_BOOL(link_mtu_defined);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_INT(tun_mtu_extra);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(tun_mtu_extra_defined)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(tls_m=
tu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(mtu_discover_type);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_FRAGMENT</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(fragment);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_INT(mssfix);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(mssfix_encap);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(mssfix_fixed);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_INT(explicit_exit_notification);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(tls_auth_file);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_PARM(key_directi=
on, keydirection2ascii(o-&gt;key_direction, false, true), &quot;%s&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(=
tls_crypt_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_STR_INLINE(tls_crypt_v2_file);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+show_connection_entries(const struct options *o=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;connection_list)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const struct connection_list *l=
 =3D o-&gt;connection_list;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (i =3D 0; i &lt; l-&gt;len; ++i)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(D_SHOW_PARMS, &quot;Connection profiles [=
%d]:&quot;, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        show_connection_entry(l-&gt;array[i]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PAR=
MS, &quot;Connection profiles [default]:&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        show_connection_entry(&amp;o-&gt;ce);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;Connec=
tion profiles END&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+show_pull_filter_list(const struct pull=
_filter_list *l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct pull_filte=
r *f;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!l)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    msg(D_SHOW_PARMS, &quot;  Pull filters:&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (f =3D l-&gt;head; f; f =3D f-&gt=
;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &=
quot;    %s \&quot;%s\&quot;&quot;, pull_filter_type_name(f-&gt;type), f-&g=
t;pattern);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+show_settings(const struct options *o)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    msg(D_SHOW_PARMS, &quot;Current Parameter Settings:&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_STR(config);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_INT(mode);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef EN=
ABLE_FEATURE_TUN_PERSIST</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_BOOL(persist_config);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_INT(persist_mode);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_BOOL(show_ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_BOOL(show_digests);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_BOOL(show_engines);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_BOOL(genkey);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_STR(genkey_filename);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(key_pass_file);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(show_tls_ciphers);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(connect_retry_max);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    show_connection_entri=
es(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(remote_random);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(ipchange);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(dev);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(dev_type);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(dev_node);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(disable_dco)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(lladdr);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(topology);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(ifconfig_loc=
al);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(if=
config_remote_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SHOW_BOOL(ifconfig_noexec);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_BOOL(ifconfig_nowarn);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SHOW_STR(ifconfig_ipv6_local);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ifconfig_ipv6_netbi=
ts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(if=
config_ipv6_remote);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(shape=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(mtu=
_test);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(mlock);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_INT(keepalive_ping);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(keepalive_timeout);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(inactivity_t=
imeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_IN=
T(session_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_INT64(inactivity_minimum_bytes);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_INT(ping_send_timeout);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ping_rec_timeout);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ping_rec_timeou=
t_action);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
BOOL(ping_timer_remote);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_INT(remap_sigusr1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_BOOL(persist_tun);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_BOOL(persist_local_ip);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(persist_remote_ip);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if PASSTOS_CAPABILITY</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(passtos);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    SHOW_INT(resolve_retry_seconds);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    SHOW_BOOL(resolve_in_advance);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_STR(username);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    SHOW_STR(groupname);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SHOW_STR(chroot_dir);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(cd_dir);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_SELINUX</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(selinux_context);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(writepid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(up_script);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(down_script);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(down_pre)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(up_r=
estart);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BO=
OL(up_delay);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_BOOL(daemon);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_BOOL(log);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_BOOL(suppress_timestamps);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SHOW_BOOL(machine_readable_output);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(nice);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(verbosity);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(mute);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(gremlin);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_STR(status_file);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(status_file_version);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(status_file=
_update_freq);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(occ);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(rcvbuf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(sndbuf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_L=
INUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(m=
ark);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(sockflags);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(comp=2Ealg);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(comp=2Eflags);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_STR(route_script);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(route_default_gateway);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(route_de=
fault_metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_INT(route_default_table_id);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SHOW_BOOL(route_noexec);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_INT(route_delay);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_INT(route_delay_window);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(route_delay_define=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(ro=
ute_nopull);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_BOOL(route_gateway_via_dhcp);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    SHOW_BOOL(allow_pull_fqdn);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    show_pull_filter_list(o-&gt;pull_filter_list);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;routes)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        print_route_options(o-&gt;routes, D_SHOW_PA=
RMS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (o-&gt;client_nat)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        print_client_nat_list(o-&gt;client_nat, D_SHOW_=
PARMS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    show_dns_options(&amp;o-&gt;dns_options);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(management_addr);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(managemen=
t_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_ST=
R(management_user_pass);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_INT(management_log_history_cache);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_INT(management_echo_buffer_size);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(management=
_client_user);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_STR(management_client_group);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_INT(management_flags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (o-&gt;plugin_list)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        plugin_option_list_print(o-&gt;plugin_list, D_SHOW_PARMS);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_STR_INLINE(shared_secret_file);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_PARM(key_direction, keydirection2asci=
i(o-&gt;key_direction, false, true), &quot;%s&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(ciphername);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(ncp_ciphers);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(authname);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_CRYPTO_MB=
EDTLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(=
engine);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* E=
NABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SHOW_BOOL(mute_replay_warnings);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    SHOW_INT(replay_window);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_INT(replay_time);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(packet_id_file);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(test_crypto);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(tls_server);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(tls_client);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(ca_fi=
le);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(ca=
_path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR=
_INLINE(dh_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if ((o-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        SHOW_PARM(&quot;cert_file&quot;, &quot;EXTERNA=
L_CERT&quot;, &quot;%s&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        SHOW_STR_INLINE(cert=
_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(extra_=
certs_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((o-&gt;management_=
flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    SHOW_PARM(&quot;priv_key_file&quot;, &quot;EXTERNAL_PRIVATE_KEY&quot;, =
&quot;%s&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        SHOW_STR_INLINE(priv_key_file);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_CRYPTO_MBEDTLS</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(pkcs1=
2_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTOAPI<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(cryptoa=
pi_cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(cipher_lis=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(cip=
her_list_tls13);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_STR(tls_cert_profile);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    SHOW_STR(tls_verify);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    SHOW_STR(tls_export_peer_cert_dir);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(verify_x509_type);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(verify_x509_nam=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INL=
INE(crl_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_INT(ns_cert_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int=
 i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =
=3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            SHOW_INT(remote_cert_ku[i]);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_STR(remote_cert_eku);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (o-&gt;verify_hash)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        SHOW_INT(verify_hash_algo);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        SHOW_INT(verify_hash_depth);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct=
 verify_hash_list *hl =3D o-&gt;verify_hash;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        int digest_len =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            (o-&gt;verify_hash_algo =3D=
=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGEST_LENGTH;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        while (hl)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            char *s =3D format_hex_ex(hl-&gt;hash=
, digest_len, 0, 1, &quot;:&quot;, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            SHOW_PARM(verify_hash, s, &quot;%s&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            hl =
=3D hl-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ssl_flag=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(tls_timeout);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SHOW_INT64(renegotiate_bytes);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT64(renegotiate_packe=
ts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(re=
negotiate_seconds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(handsh=
ake_window);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_INT(transition_window);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL=
(single_session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_BOOL(push_peer_info);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    SHOW_BOOL(tls_exit);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_STR(tls_crypt_v2_metadata);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
ENABLE_PKCS11</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int i;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &=
lt; MAX_PARMS &amp;&amp; o-&gt;pkcs11_providers[i] !=3D NULL; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            SHOW_PARM(pkcs11_providers=
, o-&gt;pkcs11_providers[i], &quot;%s&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int =
i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =
=3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            SHOW_PARM(pkcs11_protected_authentication,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                      o-&gt;pkcs11_prote=
cted_authentication[i] ? &quot;ENABLED&quot; : &quot;DISABLED&quot;, &quot;=
%s&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        int i;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            SHOW_PARM(pkcs11_private_=
mode, o-&gt;pkcs11_private_mode[i], &quot;%08x&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            SHOW_PARM(pkcs11_cert_private, o-&gt;pkcs11_cert_private=
[i] ? &quot;ENABLED&quot; : &quot;DISABLED&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                      &quot;%s&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_INT(pkcs11_pin_cache_period);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(pkcs11_id);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(pkcs11_id_ma=
nagement);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 ENABLE_PKCS11 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    show_p2mp_parms(o=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(show_net_up);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(route_method);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(block_outsi=
de_dns);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    show_tu=
ntap_options(&amp;o-&gt;tuntap_options);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef ENABLE_SMALL=
 */</span><br><span>diff --git a/src/openvpn/options_show=2Eh b/src/openvpn=
/options_show=2Eh</span><br><span>new file mode 100644</span><br><span>inde=
x 0000000=2E=2Efb233fc</span><br><span>--- /dev/null</span><br><span>+++ b/=
src/openvpn/options_show=2Eh</span><br><span>@@ -0,0 +1,46 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel I=
P networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      over a single UDP port, with support for SSL/TLS-based</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticat=
ion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             packet encryption, packet authentication, and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 Open=
VPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is free software; you can redistribute it and/or modify</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms =
of the GNU General Public License version 2</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in t=
he hope that it will be useful,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty=
 of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more d=
etails=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receive=
d a copy of the GNU General Public License along</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:/=
/www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPTIONS_SHOW_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPTIONS_SH=
OW_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef ENABLE_SMALL</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show=
_settings(const struct options *o)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 (void)o;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
show_settings(const struct options *o);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* ENABLE_SMALL */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* OP=
TIONS_SHOW_H */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">change 1772=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I61762=
374c141662d596bbf88b64ca7f7472b5149 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1772 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>

</body></html>
--zWGPk4/eFv0=--


--===============4572282635726065852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4572282635726065852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4572282635726065852==--

