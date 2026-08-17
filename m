Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEB2C5DF74
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vje7yBfTFho690qUCB2A+8wEOEyn7Ptk7JQr07bEC3E=; b=QSwqiTMzeyDCyYK82feNkgq75L
	1jmGlxhMmDYerPfFXNIimBuqv8R5utUfrbyarVSL2FJxZvAGmyAl+SQKRgBV6+cnpbuB7CcXdYuQF
	9HuS7V0TSYXNB5xo0skg6lp/YmLVnpl58Ez5gMDDKy4t/5I2D2CzUgL5F+g3axThn9lI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvy5v-0004SX-0N;
	Mon, 17 Aug 2026 14:13:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvy5t-0004SR-JD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=D1iBqGWp1nf6VYOmp02NuPaPSR9HTnkf/HM5zoG7En4=; b=INNJaQLV2bPWL7uRk/zsOkOFLK
 oJwHw8jYM1UN8nbZhyxgPXXNBgSGCRonPZtugAp0k1P61aWdaa4WB8V4eCwOk4Y1dbE39fTfAkwbz
 9rKbcaTMd4L/VhQAuKB2y13Re5gtr563y4QowN2aO+Kznmxd/qX79bnOuiQhD8PD1Sks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D1iBqGWp1nf6VYOmp02NuPaPSR9HTnkf/HM5zoG7En4=; b=K
 qYql4dCh27s30ExoVE3+mvPx0BOQNKMB7rfWyi30nLqJsBo6Y2JSD1QW4WE9TWLSfPPOq3gfq4bNI
 zBzW1YQYmeYNQBxI919SpLwyhTHLmm+lUnI+lVyrvmXKMts6Qz2FGiaCMW0eSsmzdCXgRSu8+oICc
 MYIsgaYGncyG2pY0=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvy5o-0007yv-6P for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:13:41 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso26424955e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786976006; x=1787580806; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D1iBqGWp1nf6VYOmp02NuPaPSR9HTnkf/HM5zoG7En4=;
 b=OqeZ4lPvIIe6yvYIVfHMoTJQT6HZuHAQCv0eNlrqW0KEl0a9aiHKcpGI7V0Lemnn0N
 UMY3+MlPAXLJALXhf3ojtSmQxqD7UChGzmgWdpx1ngLFjg+PCQKJh9FAm18yJ6PnfiVr
 GpFPEInR7k/KUMb2MgXkt8Rgio1QIRPEvA6PEYaHou9ZVtlPcTa3ENahpLBd5Sh23NkS
 LIwh+r0lYWz7VA8yJ9aOCD5J5pObKtLSAoYWXTyvT8GZeztxM1t7JW0z/w6sbzemb0oR
 nvcYQd0vqm1iF1/UEx4yLlTjeJDAxw6gqhV+6Zzyl8KjqbevxQhjVtCCUfSlzneHisgu
 6qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976006; x=1787580806;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=D1iBqGWp1nf6VYOmp02NuPaPSR9HTnkf/HM5zoG7En4=;
 b=a7hVxSx/n5ZMlLKn09k2giwThO8LzblelzLIoTYEscTRSLfU65ZdLkgEjYW4yJ8hnv
 8+sG+iRdOCbs39omQb2iZEgMvjGcml/QLuEv0+qcW1z0YDKig2WRlQY/qHFPqiiCua+u
 wjoo7/GpKLvcOg26VeWd5le0g/8hIZ1OycnanjnCXladraTtNv6UmDL631qLw6EJDQgq
 tCM3jDo3yge5FMO4Fl8pN+4bc8K0kCA917u8zq39wvu2gHXBy2mlA6nFetP07rwO2BNI
 OhXDOq4fCh/GSuofqhBvn0F0pvnV2j3GMzsVBGBrFiKrwztTtrcno1m4dhrJoFUJqRMx
 ov4Q==
X-Gm-Message-State: AOJu0YwZdflX1j6RhI9WecHHSYKstOV2eTO1XBMiwnp/wFLtPFvbGspS
 q4pEv8IVpe/jHrEgqqywa4psyh0XP/zfbu4AaC36r2KNO+LsjOc1XgPLMfyjnDUWR1d3deVzIDr
 2luFOiOYtrZoOyDVslgL3RNXxd/AJaFUa0tClTp7B9F2CY5oTz0xT9RJbJ0V2MJvX1Dso1/Ylil
 4SIburFA==
X-Gm-Gg: AR+sD12JoXrz7knfLfbXWRfZxmAsk6bYPHi4lCSKpzdOh0jPp7uu5JEfSED5MT9QR4T
 KEi3kKItos+hF7rTUiFYIdedp4aV4Di8B3TQaWedElxzGRguAc5j0HmDx7EWTY+H3H8hbmMQt52
 YJxMPIhKsTdCqe/A/G4dHjJNM2HNS7I0hJE0/iDAliL8Rx7HixPn1qXPn/YgnbBnrsFRZFahopw
 ClPt1rifS8qjP4gE0ZgC+iEuPjnTZHSTGdxWo3rR3HdvOz+MCTQMTy1j+jtmB8YBV0cXt8l2NAM
 t8uWlJ5Lh4E6fe+FY0PCkmXIgYPI3ID9TzsWN7hAIZWq9ydGxOL7PXlDfjg8HLAx865Ks1g2zEp
 1J+u/PbFVXLh39br42P8gUDdCABOduhOQCMEyQYqN/w2/SCunPU8G9m3o1KI9Ciz5I/0zsA2ZEV
 zY9tFX8yeWduwfM2+PkE9mVpC3r2zld+Qq9cjbeLP4+JpGr0Oh7T2qYpRGTkEfdrUC/uuskL2rr
 5FC97XyE1g59msX85zD12kAfdynBJJ5TY5GokfAHHRuw9Q0si4N1GX79gFr3p1dWza3MRkOgo9o
 yDYGUfcADQAjBU0/iAzcAKjviKV7agCgCboKUVtCe7vdGjlKtfY=
X-Received: by 2002:a05:600c:4fcb:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-49987928d0cmr427353095e9.3.1786976004599; 
 Mon, 17 Aug 2026 07:13:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996109652sm192744895e9.4.2026.08.17.07.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:13:24 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 14:13:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: f2165dfdf57e6037d5a43a8b6226c98d088b5b4e
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <226ba6c90254c3699ba5ef7c74a1a3eb2aa4ae05-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvy5o-0007yv-6P
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
Content-Type: multipart/mixed; boundary="===============0381151520319635220=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0381151520319635220==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UNq3ij/qlbU="; charset=UTF-8

--UNq3ij/qlbU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail

to loo=
k at the new patch set (#4)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc

The change is no longer submittable: =
Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Change sub=
ject: options: Factor out options display code from options=2Ec
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: Factor out op=
tions display code from options=2Ec

options=2Ec is a huge, unwieldly file=
=2E So remove some
closely related code that has no direct dependencies
wit=
h the other functions in the file=2E

In this case it is the code that prin=
ts out the current
configuration=2E

Change-Id: I61762374c141662d596bbf88b6=
4ca7f7472b5149
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
-=
--
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/openvpn=2Ec=

M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/openvpn/options_=
show=2Ec
A src/openvpn/options_show=2Eh
7 files changed, 683 insertions(+),=
 620 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/72/1772/4

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
ind=
ex aae264e=2E=2E4eda75b 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etx=
t
@@ -529,6 +529,8 @@
     src/openvpn/options_util=2Ec
     src/openvpn/op=
tions_util=2Eh
     src/openvpn/options_parse=2Ec
+    src/openvpn/options_=
show=2Ec
+    src/openvpn/options_show=2Eh
     src/openvpn/otime=2Ec
     =
src/openvpn/otime=2Eh
     src/openvpn/ovpn_dco_win=2Eh
diff --git a/src/op=
envpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 1f77384=2E=2E2092e96 =
100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -=
108,6 +108,7 @@
 	pkcs11_mbedtls=2Ec \
 	openvpn=2Ec openvpn=2Eh \
 	option=
s=2Ec options=2Eh \
+	options_show=2Ec options_show=2Eh \
 	options_util=2E=
c options_util=2Eh \
 	options_parse=2Ec \
 	otime=2Ec otime=2Eh \
diff --g=
it a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec
index f38660f=2E=2E7=
d35195 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/src/openvpn/openvpn=2Ec
@=
@ -30,6 +30,7 @@
 #include "forward=2Eh"
 #include "multi=2Eh"
 #include "w=
in32=2Eh"
+#include "options_show=2Eh"
 #include "platform=2Eh"
 #include "=
string=2Eh"
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2E=
c
index 4aebfea=2E=2Ee899fa6 100644
--- a/src/openvpn/options=2Ec
+++ b/src=
/openvpn/options=2Ec
@@ -914,41 +914,6 @@
     gc_free(&o->dns_options=2Egc=
);
 }
 
-#ifndef ENABLE_SMALL
-
-static const char *
-pull_filter_type_name=
(int type)
-{
-    if (type =3D=3D PUF_TYPE_ACCEPT)
-    {
-        return =
"accept";
-    }
-    if (type =3D=3D PUF_TYPE_IGNORE)
-    {
-        retu=
rn "ignore";
-    }
-    if (type =3D=3D PUF_TYPE_REJECT)
-    {
-        r=
eturn "reject";
-    }
-    else
-    {
-        return "???";
-    }
-}
-
=
-#define SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, "  " #name " =3D =
" format, (value))
-#define SHOW_STR(var)                  SHOW_PARM(var, (=
o->var ? o->var : "[UNDEF]"), "'%s'")
-#define SHOW_STR_INLINE(var) \
-    =
SHOW_PARM(var, o->var##_inline ? "[INLINE]" : (o->var ? o->var : "[UNDEF]")=
, "'%s'")
-#define SHOW_INT(var)      SHOW_PARM(var, o->var, "%d")
-#define=
 SHOW_UINT(var)     SHOW_PARM(var, o->var, "%u")
-#define SHOW_INT64(var)  =
  SHOW_PARM(var, o->var, "%" PRIi64)
-#define SHOW_UNSIGNED(var) SHOW_PARM(=
var, o->var, "0x%08x")
-#define SHOW_BOOL(var)     SHOW_PARM(var, (o->var ?=
 "ENABLED" : "DISABLED"), "%s");
-
-#endif /* ifndef ENABLE_SMALL */
-
 sta=
tic void
 setenv_connection_entry(struct env_set *es, const struct connecti=
on_entry *e, const int i)
 {
@@ -1240,55 +1205,6 @@
 
     return ret;
 }
-=
#ifdef _WIN32
-
-#ifndef ENABLE_SMALL
-
-static void
-show_dhcp_option_list=
(const char *name, const char *const *array, unsigned int len)
-{
-    for =
(unsigned int i =3D 0; i < len; ++i)
-    {
-        msg(D_SHOW_PARMS, "  %=
s[%u] =3D %s", name, i, array[i]);
-    }
-}
-
-static void
-show_dhcp_opti=
on_addrs(const char *name, const in_addr_t *array, unsigned int len)
-{
-  =
  struct gc_arena gc =3D gc_new();
-    for (unsigned int i =3D 0; i < len;=
 ++i)
-    {
-        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, print_i=
n_addr_t(array[i], 0, &gc));
-    }
-    gc_free(&gc);
-}
-
-static void
-s=
how_tuntap_options(const struct tuntap_options *o)
-{
-    SHOW_BOOL(ip_win=
32_defined);
-    SHOW_INT(ip_win32_type);
-    SHOW_INT(dhcp_masq_offset);=

-    SHOW_INT(dhcp_lease_time);
-    SHOW_INT(tap_sleep);
-    SHOW_UNSIGN=
ED(dhcp_options);
-    SHOW_BOOL(dhcp_renew);
-    SHOW_BOOL(dhcp_pre_relea=
se);
-    SHOW_STR(domain);
-    SHOW_STR(netbios_scope);
-    SHOW_UNSIGNE=
D(netbios_node_type);
-    SHOW_BOOL(disable_nbt);
-
-    show_dhcp_option_=
addrs("DNS", o->dns, o->dns_len);
-    show_dhcp_option_addrs("WINS", o->wi=
ns, o->wins_len);
-    show_dhcp_option_addrs("NTP", o->ntp, o->ntp_len);
-=
    show_dhcp_option_addrs("NBDD", o->nbdd, o->nbdd_len);
-    show_dhcp_op=
tion_list("DOMAIN-SEARCH", o->domain_search_list, o->domain_search_list_len=
);
-}
-
-#endif /* ifndef ENABLE_SMALL */
-#endif /* ifdef _WIN32 */
 
 sta=
tic void
 dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_li=
st, unsigned int *len, msglvl_t msglevel)
@@ -1331,116 +1247,6 @@
     }
 }=

 
-#ifndef ENABLE_SMALL
-static const char *
-print_vlan_accept(enum vlan_=
acceptable_frames mode)
-{
-    switch (mode)
-    {
-        case VLAN_ONL=
Y_TAGGED:
-            return "tagged";
-
-        case VLAN_ONLY_UNTAGGED_=
OR_PRIORITY:
-            return "untagged";
-
-        case VLAN_ALL:
-   =
         return "all";
-    }
-    return NULL;
-}
-
-static void
-show_p2m=
p_parms(const struct options *o)
-{
-    struct gc_arena gc =3D gc_new();
-=

-    msg(D_SHOW_PARMS, "  server_network =3D %s", print_in_addr_t(o->serve=
r_network, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_netmask =3D %s", prin=
t_in_addr_t(o->server_netmask, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_n=
etwork_ipv6 =3D %s", print_in6_addr(o->server_network_ipv6, 0, &gc));
-    =
SHOW_INT(server_netbits_ipv6);
-    msg(D_SHOW_PARMS, "  server_bridge_ip =
=3D %s", print_in_addr_t(o->server_bridge_ip, 0, &gc));
-    msg(D_SHOW_PAR=
MS, "  server_bridge_netmask =3D %s",
-        print_in_addr_t(o->server_br=
idge_netmask, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_bridge_pool_start =
=3D %s",
-        print_in_addr_t(o->server_bridge_pool_start, 0, &gc));
- =
   msg(D_SHOW_PARMS, "  server_bridge_pool_end =3D %s",
-        print_in_a=
ddr_t(o->server_bridge_pool_end, 0, &gc));
-    if (o->push_list=2Ehead)
- =
   {
-        const struct push_entry *e =3D o->push_list=2Ehead;
-        =
while (e)
-        {
-            if (e->enable)
-            {
-          =
      msg(D_SHOW_PARMS, "  push_entry =3D '%s'", e->option);
-            }=

-            e =3D e->next;
-        }
-    }
-    SHOW_BOOL(ifconfig_pool=
_defined);
-    msg(D_SHOW_PARMS, "  ifconfig_pool_start =3D %s",
-        =
print_in_addr_t(o->ifconfig_pool_start, 0, &gc));
-    msg(D_SHOW_PARMS, " =
 ifconfig_pool_end =3D %s", print_in_addr_t(o->ifconfig_pool_end, 0, &gc));=

-    msg(D_SHOW_PARMS, "  ifconfig_pool_netmask =3D %s",
-        print_in=
_addr_t(o->ifconfig_pool_netmask, 0, &gc));
-    SHOW_STR(ifconfig_pool_per=
sist_filename);
-    SHOW_INT(ifconfig_pool_persist_refresh_freq);
-    SHO=
W_BOOL(ifconfig_ipv6_pool_defined);
-    msg(D_SHOW_PARMS, "  ifconfig_ipv6=
_pool_base =3D %s",
-        print_in6_addr(o->ifconfig_ipv6_pool_base, 0, =
&gc));
-    SHOW_INT(ifconfig_ipv6_pool_netbits);
-    SHOW_INT(n_bcast_buf=
);
-    SHOW_INT(tcp_queue_limit);
-    SHOW_INT(real_hash_size);
-    SHOW=
_INT(virtual_hash_size);
-    SHOW_STR(client_connect_script);
-    SHOW_ST=
R(learn_address_script);
-    SHOW_STR(client_disconnect_script);
-    SHOW=
_STR(client_crresponse_script);
-    SHOW_STR(client_config_dir);
-    SHOW=
_BOOL(ccd_exclusive);
-    SHOW_STR(tmp_dir);
-    SHOW_BOOL(push_ifconfig_=
defined);
-    msg(D_SHOW_PARMS, "  push_ifconfig_local =3D %s",
-        p=
rint_in_addr_t(o->push_ifconfig_local, 0, &gc));
-    msg(D_SHOW_PARMS, "  =
push_ifconfig_remote_netmask =3D %s",
-        print_in_addr_t(o->push_ifco=
nfig_remote_netmask, 0, &gc));
-    SHOW_BOOL(push_ifconfig_ipv6_defined);
=
-    msg(D_SHOW_PARMS, "  push_ifconfig_ipv6_local =3D %s/%d",
-        pri=
nt_in6_addr(o->push_ifconfig_ipv6_local, 0, &gc), o->push_ifconfig_ipv6_net=
bits);
-    msg(D_SHOW_PARMS, "  push_ifconfig_ipv6_remote =3D %s",
-      =
  print_in6_addr(o->push_ifconfig_ipv6_remote, 0, &gc));
-    SHOW_BOOL(ena=
ble_c2c);
-    SHOW_BOOL(duplicate_cn);
-    SHOW_INT(cf_max);
-    SHOW_IN=
T(cf_per);
-    SHOW_INT(cf_initial_max);
-    SHOW_INT(cf_initial_per);
- =
   SHOW_UINT(max_clients);
-    SHOW_INT(max_routes_per_client);
-    SHOW_=
STR(auth_user_pass_verify_script);
-    SHOW_BOOL(auth_user_pass_verify_scr=
ipt_via_file);
-    SHOW_BOOL(auth_token_generate);
-    SHOW_BOOL(force_ke=
y_material_export);
-    SHOW_INT(auth_token_lifetime);
-    SHOW_STR_INLIN=
E(auth_token_secret_file);
-#if PORT_SHARE
-    SHOW_STR(port_share_host);
=
-    SHOW_STR(port_share_port);
-#endif
-    SHOW_BOOL(vlan_tagging);
-    =
msg(D_SHOW_PARMS, "  vlan_accept =3D %s", print_vlan_accept(o->vlan_accept)=
);
-    SHOW_INT(vlan_pvid);
-
-    SHOW_BOOL(client);
-    SHOW_BOOL(pull)=
;
-    SHOW_STR_INLINE(auth_user_pass_file);
-
-    gc_free(&gc);
-}
-
-#en=
dif /* ! ENABLE_SMALL */
-
 static void
 option_iroute(struct options *o, c=
onst char *network_str, const char *netmask_str,
               msglvl_t ms=
glevel)
@@ -1485,37 +1291,6 @@
     o->iroutes_ipv6 =3D ir;
 }
 
-#ifndef E=
NABLE_SMALL
-static void
-show_http_proxy_options(const struct http_proxy_o=
ptions *o)
-{
-    int i;
-    msg(D_SHOW_PARMS, "BEGIN http_proxy");
-    =
SHOW_STR(server);
-    SHOW_STR(port);
-    SHOW_STR(auth_method_string);
-=
    SHOW_STR(auth_file);
-    SHOW_STR(auth_file_up);
-    SHOW_BOOL(inline=
_creds);
-    SHOW_BOOL(nocache);
-    SHOW_STR(http_version);
-    SHOW_ST=
R(user_agent);
-    for (i =3D 0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_h=
eaders[i]=2Ename; i++)
-    {
-        if (o->custom_headers[i]=2Econtent)
=
-        {
-            msg(D_SHOW_PARMS, "  custom_header[%d] =3D %s: %s",=
 i, o->custom_headers[i]=2Ename,
-                o->custom_headers[i]=2Eco=
ntent);
-        }
-        else
-        {
-            msg(D_SHOW_PARMS, =
"  custom_header[%d] =3D %s", i, o->custom_headers[i]=2Ename);
-        }
-=
    }
-    msg(D_SHOW_PARMS, "END http_proxy");
-}
-#endif /* ifndef ENABLE=
_SMALL */
-
 void
 options_detach(struct options *o)
 {
@@ -1563,399 +1338,=
6 @@
     }
 }
 
-#ifndef ENABLE_SMALL
-static void
-show_connection_entry(=
const struct connection_entry *o)
-{
-    /* Display the global proto only =
in client mode or with no '--local'*/
-    if (o->local_list->len =3D=3D 1)=

-    {
-        msg(D_SHOW_PARMS, "  proto =3D %s", proto2ascii(o->proto, =
o->af, false));
-    }
-
-    msg(D_SHOW_PARMS, "  Local Sockets:");
-    f=
or (int i =3D 0; i < o->local_list->len; i++)
-    {
-        msg(D_SHOW_PA=
RMS, "    [%s]:%s-%s", o->local_list->array[i]->local,
-            o->loca=
l_list->array[i]->port,
-            proto2ascii(o->local_list->array[i]->p=
roto, o->af, false));
-    }
-    SHOW_STR(remote);
-    SHOW_STR(remote_po=
rt);
-    SHOW_BOOL(remote_float);
-    SHOW_BOOL(bind_defined);
-    SHOW_=
BOOL(bind_local);
-    SHOW_BOOL(bind_ipv6_only);
-    SHOW_INT(connect_ret=
ry_seconds);
-    SHOW_INT(connect_timeout);
-
-    if (o->http_proxy_optio=
ns)
-    {
-        show_http_proxy_options(o->http_proxy_options);
-    }
=
-    SHOW_STR(socks_proxy_server);
-    SHOW_STR(socks_proxy_port);
-    SH=
OW_INT(tun_mtu);
-    SHOW_BOOL(tun_mtu_defined);
-    SHOW_INT(link_mtu);
=
-    SHOW_BOOL(link_mtu_defined);
-    SHOW_INT(tun_mtu_extra);
-    SHOW_B=
OOL(tun_mtu_extra_defined);
-    SHOW_INT(tls_mtu);
-
-    SHOW_INT(mtu_dis=
cover_type);
-
-#ifdef ENABLE_FRAGMENT
-    SHOW_INT(fragment);
-#endif
-  =
  SHOW_INT(mssfix);
-    SHOW_BOOL(mssfix_encap);
-    SHOW_BOOL(mssfix_fix=
ed);
-
-    SHOW_INT(explicit_exit_notification);
-
-    SHOW_STR_INLINE(tl=
s_auth_file);
-    SHOW_PARM(key_direction, keydirection2ascii(o->key_direc=
tion, false, true), "%s");
-    SHOW_STR_INLINE(tls_crypt_file);
-    SHOW_=
STR_INLINE(tls_crypt_v2_file);
-}
-
-
-static void
-show_connection_entries=
(const struct options *o)
-{
-    if (o->connection_list)
-    {
-        c=
onst struct connection_list *l =3D o->connection_list;
-        int i;
-   =
     for (i =3D 0; i < l->len; ++i)
-        {
-            msg(D_SHOW_PARM=
S, "Connection profiles [%d]:", i);
-            show_connection_entry(l->a=
rray[i]);
-        }
-    }
-    else
-    {
-        msg(D_SHOW_PARMS, "Co=
nnection profiles [default]:");
-        show_connection_entry(&o->ce);
-  =
  }
-    msg(D_SHOW_PARMS, "Connection profiles END");
-}
-
-static void
-s=
how_pull_filter_list(const struct pull_filter_list *l)
-{
-    struct pull_=
filter *f;
-    if (!l)
-    {
-        return;
-    }
-
-    msg(D_SHOW_PA=
RMS, "  Pull filters:");
-    for (f =3D l->head; f; f =3D f->next)
-    {
=
-        msg(D_SHOW_PARMS, "    %s \"%s\"", pull_filter_type_name(f->type),=
 f->pattern);
-    }
-}
-
-#endif /* ifndef ENABLE_SMALL */
-
-void
-show_s=
ettings(const struct options *o)
-{
-#ifndef ENABLE_SMALL
-    msg(D_SHOW_P=
ARMS, "Current Parameter Settings:");
-
-    SHOW_STR(config);
-
-    SHOW_=
INT(mode);
-
-#ifdef ENABLE_FEATURE_TUN_PERSIST
-    SHOW_BOOL(persist_conf=
ig);
-    SHOW_INT(persist_mode);
-#endif
-
-    SHOW_BOOL(show_ciphers);
-=
    SHOW_BOOL(show_digests);
-    SHOW_BOOL(show_engines);
-    SHOW_BOOL(g=
enkey);
-    SHOW_STR(genkey_filename);
-    SHOW_STR(key_pass_file);
-    =
SHOW_BOOL(show_tls_ciphers);
-
-    SHOW_INT(connect_retry_max);
-    show_=
connection_entries(o);
-
-    SHOW_BOOL(remote_random);
-
-    SHOW_STR(ipc=
hange);
-    SHOW_STR(dev);
-    SHOW_STR(dev_type);
-    SHOW_STR(dev_node=
);
-#if defined(ENABLE_DCO)
-    SHOW_BOOL(disable_dco);
-#endif
-    SHOW_=
STR(lladdr);
-    SHOW_INT(topology);
-    SHOW_STR(ifconfig_local);
-    S=
HOW_STR(ifconfig_remote_netmask);
-    SHOW_BOOL(ifconfig_noexec);
-    SHO=
W_BOOL(ifconfig_nowarn);
-    SHOW_STR(ifconfig_ipv6_local);
-    SHOW_INT(=
ifconfig_ipv6_netbits);
-    SHOW_STR(ifconfig_ipv6_remote);
-
-    SHOW_IN=
T(shaper);
-    SHOW_INT(mtu_test);
-
-    SHOW_BOOL(mlock);
-
-    SHOW_IN=
T(keepalive_ping);
-    SHOW_INT(keepalive_timeout);
-    SHOW_INT(inactivi=
ty_timeout);
-    SHOW_INT(session_timeout);
-    SHOW_INT64(inactivity_min=
imum_bytes);
-    SHOW_INT(ping_send_timeout);
-    SHOW_INT(ping_rec_timeo=
ut);
-    SHOW_INT(ping_rec_timeout_action);
-    SHOW_BOOL(ping_timer_remo=
te);
-    SHOW_INT(remap_sigusr1);
-    SHOW_BOOL(persist_tun);
-    SHOW_B=
OOL(persist_local_ip);
-    SHOW_BOOL(persist_remote_ip);
-
-#if PASSTOS_CA=
PABILITY
-    SHOW_BOOL(passtos);
-#endif
-
-    SHOW_INT(resolve_retry_sec=
onds);
-    SHOW_BOOL(resolve_in_advance);
-
-    SHOW_STR(username);
-    =
SHOW_STR(groupname);
-    SHOW_STR(chroot_dir);
-    SHOW_STR(cd_dir);
-#if=
def ENABLE_SELINUX
-    SHOW_STR(selinux_context);
-#endif
-    SHOW_STR(wr=
itepid);
-    SHOW_STR(up_script);
-    SHOW_STR(down_script);
-    SHOW_BO=
OL(down_pre);
-    SHOW_BOOL(up_restart);
-    SHOW_BOOL(up_delay);
-    SH=
OW_BOOL(daemon);
-    SHOW_BOOL(log);
-    SHOW_BOOL(suppress_timestamps);
=
-    SHOW_BOOL(machine_readable_output);
-    SHOW_INT(nice);
-    SHOW_INT=
(verbosity);
-    SHOW_INT(mute);
-#ifdef ENABLE_DEBUG
-    SHOW_INT(gremli=
n);
-#endif
-    SHOW_STR(status_file);
-    SHOW_INT(status_file_version);=

-    SHOW_INT(status_file_update_freq);
-
-    SHOW_BOOL(occ);
-    SHOW_I=
NT(rcvbuf);
-    SHOW_INT(sndbuf);
-#if defined(TARGET_LINUX)
-    SHOW_INT=
(mark);
-#endif
-    SHOW_INT(sockflags);
-
-    SHOW_INT(comp=2Ealg);
-   =
 SHOW_INT(comp=2Eflags);
-
-    SHOW_STR(route_script);
-    SHOW_STR(route=
_default_gateway);
-    SHOW_INT(route_default_metric);
-    SHOW_INT(route=
_default_table_id);
-    SHOW_BOOL(route_noexec);
-    SHOW_INT(route_delay=
);
-    SHOW_INT(route_delay_window);
-    SHOW_BOOL(route_delay_defined);
=
-    SHOW_BOOL(route_nopull);
-    SHOW_BOOL(route_gateway_via_dhcp);
-    =
SHOW_BOOL(allow_pull_fqdn);
-    show_pull_filter_list(o->pull_filter_list)=
;
-
-    if (o->routes)
-    {
-        print_route_options(o->routes, D_SH=
OW_PARMS);
-    }
-
-    if (o->client_nat)
-    {
-        print_client_na=
t_list(o->client_nat, D_SHOW_PARMS);
-    }
-
-    show_dns_options(&o->dns=
_options);
-
-#ifdef ENABLE_MANAGEMENT
-    SHOW_STR(management_addr);
-   =
 SHOW_STR(management_port);
-    SHOW_STR(management_user_pass);
-    SHOW_=
INT(management_log_history_cache);
-    SHOW_INT(management_echo_buffer_siz=
e);
-    SHOW_STR(management_client_user);
-    SHOW_STR(management_client_=
group);
-    SHOW_INT(management_flags);
-#endif
-#ifdef ENABLE_PLUGIN
-   =
 if (o->plugin_list)
-    {
-        plugin_option_list_print(o->plugin_lis=
t, D_SHOW_PARMS);
-    }
-#endif
-
-    SHOW_STR_INLINE(shared_secret_file)=
;
-    SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false,=
 true), "%s");
-    SHOW_STR(ciphername);
-    SHOW_STR(ncp_ciphers);
-    =
SHOW_STR(authname);
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    SHOW_BOOL(engine);
=
-#endif /* ENABLE_CRYPTO_MBEDTLS */
-    SHOW_BOOL(mute_replay_warnings);
-=
    SHOW_INT(replay_window);
-    SHOW_INT(replay_time);
-    SHOW_STR(pack=
et_id_file);
-    SHOW_BOOL(test_crypto);
-
-    SHOW_BOOL(tls_server);
-  =
  SHOW_BOOL(tls_client);
-    SHOW_STR_INLINE(ca_file);
-    SHOW_STR(ca_pa=
th);
-    SHOW_STR_INLINE(dh_file);
-    if ((o->management_flags & MF_EXTE=
RNAL_CERT))
-    {
-        SHOW_PARM("cert_file", "EXTERNAL_CERT", "%s");
=
-    }
-    else
-    {
-        SHOW_STR_INLINE(cert_file);
-    }
-    SH=
OW_STR_INLINE(extra_certs_file);
-
-    if ((o->management_flags & MF_EXTER=
NAL_KEY))
-    {
-        SHOW_PARM("priv_key_file", "EXTERNAL_PRIVATE_KEY"=
, "%s");
-    }
-    else
-    {
-        SHOW_STR_INLINE(priv_key_file);
-=
    }
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    SHOW_STR_INLINE(pkcs12_file);
-#e=
ndif
-#ifdef ENABLE_CRYPTOAPI
-    SHOW_STR(cryptoapi_cert);
-#endif
-    S=
HOW_STR(cipher_list);
-    SHOW_STR(cipher_list_tls13);
-    SHOW_STR(tls_c=
ert_profile);
-    SHOW_STR(tls_verify);
-    SHOW_STR(tls_export_peer_cert=
_dir);
-    SHOW_INT(verify_x509_type);
-    SHOW_STR(verify_x509_name);
- =
   SHOW_STR_INLINE(crl_file);
-    SHOW_INT(ns_cert_type);
-    {
-        =
int i;
-        for (i =3D 0; i < MAX_PARMS; i++)
-        {
-            S=
HOW_INT(remote_cert_ku[i]);
-        }
-    }
-    SHOW_STR(remote_cert_eku=
);
-    if (o->verify_hash)
-    {
-        SHOW_INT(verify_hash_algo);
-  =
      SHOW_INT(verify_hash_depth);
-        struct gc_arena gc =3D gc_new()=
;
-        struct verify_hash_list *hl =3D o->verify_hash;
-        int dig=
est_len =3D
-            (o->verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_=
LENGTH : SHA256_DIGEST_LENGTH;
-        while (hl)
-        {
-            =
char *s =3D format_hex_ex(hl->hash, digest_len, 0, 1, ":", &gc);
-         =
   SHOW_PARM(verify_hash, s, "%s");
-            hl =3D hl->next;
-        =
}
-        gc_free(&gc);
-    }
-    SHOW_INT(ssl_flags);
-
-    SHOW_INT(t=
ls_timeout);
-
-    SHOW_INT64(renegotiate_bytes);
-    SHOW_INT64(renegoti=
ate_packets);
-    SHOW_INT(renegotiate_seconds);
-
-    SHOW_INT(handshake=
_window);
-    SHOW_INT(transition_window);
-
-    SHOW_BOOL(single_session=
);
-    SHOW_BOOL(push_peer_info);
-    SHOW_BOOL(tls_exit);
-
-    SHOW_ST=
R(tls_crypt_v2_metadata);
-
-#ifdef ENABLE_PKCS11
-    {
-        int i;
- =
       for (i =3D 0; i < MAX_PARMS && o->pkcs11_providers[i] !=3D NULL; i++=
)
-        {
-            SHOW_PARM(pkcs11_providers, o->pkcs11_providers[i=
], "%s");
-        }
-    }
-    {
-        int i;
-        for (i =3D 0; i=
 < MAX_PARMS; i++)
-        {
-            SHOW_PARM(pkcs11_protected_authe=
ntication,
-                      o->pkcs11_protected_authentication[i] ? "=
ENABLED" : "DISABLED", "%s");
-        }
-    }
-    {
-        int i;
-   =
     for (i =3D 0; i < MAX_PARMS; i++)
-        {
-            SHOW_PARM(pk=
cs11_private_mode, o->pkcs11_private_mode[i], "%08x");
-        }
-    }
- =
   {
-        int i;
-        for (i =3D 0; i < MAX_PARMS; i++)
-        {
=
-            SHOW_PARM(pkcs11_cert_private, o->pkcs11_cert_private[i] ? "EN=
ABLED" : "DISABLED",
-                      "%s");
-        }
-    }
-    S=
HOW_INT(pkcs11_pin_cache_period);
-    SHOW_STR(pkcs11_id);
-    SHOW_BOOL(=
pkcs11_id_management);
-#endif /* ENABLE_PKCS11 */
-
-    show_p2mp_parms(o=
);
-
-#ifdef _WIN32
-    SHOW_BOOL(show_net_up);
-    SHOW_INT(route_method=
);
-    SHOW_BOOL(block_outside_dns);
-    show_tuntap_options(&o->tuntap_o=
ptions);
-#endif
-#endif /* ifndef ENABLE_SMALL */
-}
-
-#undef SHOW_PARM
-=
#undef SHOW_STR
-#undef SHOW_INT
-#undef SHOW_BOOL
-
 #ifdef ENABLE_MANAGEM=
ENT
 
 static struct http_proxy_options *
diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh
index 30a146f=2E=2Ed42773f 100644
--- a/src/=
openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -901,8 +901,6 @@
 
 vo=
id setenv_settings(struct env_set *es, const struct options *o);
 
-void sh=
ow_settings(const struct options *o);
-
 bool string_defined_equal(const ch=
ar *s1, const char *s2);
 
 const char *options_string_version(const char *=
s, struct gc_arena *gc);
diff --git a/src/openvpn/options_show=2Ec b/src/op=
envpn/options_show=2Ec
new file mode 100644
index 0000000=2E=2Eff090774
---=
 /dev/null
+++ b/src/openvpn/options_show=2Ec
@@ -0,0 +1,633 @@
+/*
+ *  Op=
enVPN -- An application to securely tunnel IP networks
+ *             over=
 a single UDP port, with support for SSL/TLS-based
+ *             session =
authentication and key exchange,
+ *             packet encryption, packet =
authentication, and
+ *             packet compression=2E
+ *
+ *  Copyrigh=
t (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is =
free software; you can redistribute it and/or modify
+ *  it under the term=
s of the GNU General Public License version 2
+ *  as published by the Free=
 Software Foundation=2E
+ *
+ *  This program is distributed in the hope th=
at it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the impli=
ed warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You s=
hould have received a copy of the GNU General Public License along
+ *  wit=
h this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+=
#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef ENABLE_SMALL=

+
+#include "syshead=2Eh"
+
+#include "options_show=2Eh"
+
+#include "cryp=
to=2Eh"
+#include "error=2Eh"
+#include "options=2Eh"
+
+static const char =
*
+pull_filter_type_name(int type)
+{
+    if (type =3D=3D PUF_TYPE_ACCEPT)=

+    {
+        return "accept";
+    }
+    if (type =3D=3D PUF_TYPE_IGNO=
RE)
+    {
+        return "ignore";
+    }
+    if (type =3D=3D PUF_TYPE_R=
EJECT)
+    {
+        return "reject";
+    }
+    else
+    {
+        re=
turn "???";
+    }
+}
+
+#define SHOW_PARM(name, value, format) msg(D_SHOW_=
PARMS, "  " #name " =3D " format, (value))
+#define SHOW_STR(var)          =
        SHOW_PARM(var, (o->var ? o->var : "[UNDEF]"), "'%s'")
+#define SHOW=
_STR_INLINE(var) \
+    SHOW_PARM(var, o->var##_inline ? "[INLINE]" : (o->v=
ar ? o->var : "[UNDEF]"), "'%s'")
+#define SHOW_INT(var)      SHOW_PARM(var=
, o->var, "%d")
+#define SHOW_UINT(var)     SHOW_PARM(var, o->var, "%u")
+#=
define SHOW_INT64(var)    SHOW_PARM(var, o->var, "%" PRIi64)
+#define SHOW_=
UNSIGNED(var) SHOW_PARM(var, o->var, "0x%08x")
+#define SHOW_BOOL(var)     =
SHOW_PARM(var, (o->var ? "ENABLED" : "DISABLED"), "%s");
+
+#ifdef _WIN32
+=

+static void
+show_dhcp_option_list(const char *name, const char *const *a=
rray, unsigned int len)
+{
+    for (unsigned int i =3D 0; i < len; ++i)
+ =
   {
+        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, array[i]);
+   =
 }
+}
+
+static void
+show_dhcp_option_addrs(const char *name, const in_add=
r_t *array, unsigned int len)
+{
+    struct gc_arena gc =3D gc_new();
+   =
 for (unsigned int i =3D 0; i < len; ++i)
+    {
+        msg(D_SHOW_PARMS,=
 "  %s[%u] =3D %s", name, i, print_in_addr_t(array[i], 0, &gc));
+    }
+  =
  gc_free(&gc);
+}
+
+static void
+show_tuntap_options(const struct tuntap_=
options *o)
+{
+    SHOW_BOOL(ip_win32_defined);
+    SHOW_INT(ip_win32_typ=
e);
+    SHOW_INT(dhcp_masq_offset);
+    SHOW_INT(dhcp_lease_time);
+    S=
HOW_INT(tap_sleep);
+    SHOW_UNSIGNED(dhcp_options);
+    SHOW_BOOL(dhcp_r=
enew);
+    SHOW_BOOL(dhcp_pre_release);
+    SHOW_STR(domain);
+    SHOW_S=
TR(netbios_scope);
+    SHOW_UNSIGNED(netbios_node_type);
+    SHOW_BOOL(di=
sable_nbt);
+
+    show_dhcp_option_addrs("DNS", o->dns, o->dns_len);
+    =
show_dhcp_option_addrs("WINS", o->wins, o->wins_len);
+    show_dhcp_option=
_addrs("NTP", o->ntp, o->ntp_len);
+    show_dhcp_option_addrs("NBDD", o->n=
bdd, o->nbdd_len);
+    show_dhcp_option_list("DOMAIN-SEARCH", o->domain_se=
arch_list, o->domain_search_list_len);
+}
+#endif /* ifdef _WIN32 */
+
+sta=
tic const char *
+print_vlan_accept(enum vlan_acceptable_frames mode)
+{
+ =
   switch (mode)
+    {
+        case VLAN_ONLY_TAGGED:
+            return=
 "tagged";
+
+        case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
+            ret=
urn "untagged";
+
+        case VLAN_ALL:
+            return "all";
+    }=

+    return NULL;
+}
+
+static void
+show_p2mp_parms(const struct options =
*o)
+{
+    struct gc_arena gc =3D gc_new();
+
+    msg(D_SHOW_PARMS, "  se=
rver_network =3D %s", print_in_addr_t(o->server_network, 0, &gc));
+    msg=
(D_SHOW_PARMS, "  server_netmask =3D %s", print_in_addr_t(o->server_netmask=
, 0, &gc));
+    msg(D_SHOW_PARMS, "  server_network_ipv6 =3D %s", print_in=
6_addr(o->server_network_ipv6, 0, &gc));
+    SHOW_INT(server_netbits_ipv6)=
;
+    msg(D_SHOW_PARMS, "  server_bridge_ip =3D %s", print_in_addr_t(o->se=
rver_bridge_ip, 0, &gc));
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
Gerrit-PatchSet: 4
Gerrit-O=
wner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=
=2Eorg>

--UNq3ij/qlbU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>flichtenh=
eld <strong>uploaded patch set #4</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by razvanc</p><p>The change is no longer submittable: Code-Review and =
checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">options: Fa=
ctor out options display code from options=2Ec<br><br>options=2Ec is a huge=
, unwieldly file=2E So remove some<br>closely related code that has no dire=
ct dependencies<br>with the other functions in the file=2E<br><br>In this c=
ase it is the code that prints out the current<br>configuration=2E<br><br>C=
hange-Id: I61762374c141662d596bbf88b64ca7f7472b5149<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<b=
r>M src/openvpn/Makefile=2Eam<br>M src/openvpn/openvpn=2Ec<br>M src/openvpn=
/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/openvpn/options_show=2Ec=
<br>A src/openvpn/options_show=2Eh<br>7 files changed, 683 insertions(+), 6=
20 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/72/1772/4</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index aae264e=2E=2E4eda75b 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -529,6 +529,8 @@</span><br><span>     src/openvpn/op=
tions_util=2Ec</span><br><span>     src/openvpn/options_util=2Eh</span><br>=
<span>     src/openvpn/options_parse=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    src/openvpn/options_show=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options_show=2Eh</span><b=
r><span>     src/openvpn/otime=2Ec</span><br><span>     src/openvpn/otime=
=2Eh</span><br><span>     src/openvpn/ovpn_dco_win=2Eh</span><br><span>diff=
 --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><s=
pan>index 1f77384=2E=2E2092e96 100644</span><br><span>--- a/src/openvpn/Mak=
efile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>=
@@ -108,6 +108,7 @@</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span>=
 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	options_show=2Ec optio=
ns_show=2Eh \</span><br><span> 	options_util=2Ec options_util=2Eh \</span><=
br><span> 	options_parse=2Ec \</span><br><span> 	otime=2Ec otime=2Eh \</spa=
n><br><span>diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec<=
/span><br><span>index f38660f=2E=2E7d35195 100644</span><br><span>--- a/src=
/openvpn/openvpn=2Ec</span><br><span>+++ b/src/openvpn/openvpn=2Ec</span><b=
r><span>@@ -30,6 +30,7 @@</span><br><span> #include &quot;forward=2Eh&quot;=
</span><br><span> #include &quot;multi=2Eh&quot;</span><br><span> #include =
&quot;win32=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;options_show=2Eh&quot;</span><br><span> #include &quot;pla=
tform=2Eh&quot;</span><br><span> #include &quot;string=2Eh&quot;</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/=
options=2Ec</span><br><span>index 4aebfea=2E=2Ee899fa6 100644</span><br><sp=
an>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
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
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
61762374c141662d596bbf88b64ca7f7472b5149 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1772 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@m=
ailbox=2Eorg&gt; </div>

</body></html>
--UNq3ij/qlbU=--


--===============0381151520319635220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0381151520319635220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0381151520319635220==--

