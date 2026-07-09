Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23633C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yhJ1F9UZM2952TJroaBKQsSh/R1dBzvOnDl388YWxNQ=; b=dFzT9kh4gtyyIfSlBfjuEKBP8v
	ybaQkP6wQ8qc0E+IDaybFa1Sdn7BmcirCyuLP5e7M/Srw7L34uC8UaKZ1JvWdvEEqHQTffw0h7XSa
	6/fl6iZQITl1f/NoE3zg6Dqh10bHJgZJbogR6EWcydV6k8qRaX1SlQ5OBVT2mDyuSnZY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqHp-0003lf-51;
	Thu, 09 Jul 2026 15:03:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqHn-0003lY-O4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:03:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=I0wXOWfoPXhhX0Rj2YmcHCJEdqU9iFtVhUUJZlS7Irk=; b=EyMzcfHo9yyK2/VlnD9UPj2cJg
 9FinJr/OUJ3RhSCp72MrESPUV82p85Wn9zLjAPM48U3q11vscD5NbCZg7TM6/TDoWvQVtN0Uzwhvi
 jIG0Tybm3G0gHSlArdf7Gj++8nyHNoAuI8w7n3G07LX4e2kj8W+sEAcV8Mt46HNJYcAg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I0wXOWfoPXhhX0Rj2YmcHCJEdqU9iFtVhUUJZlS7Irk=; b=c
 6CC/ZdfStTSxz8f+t2dD2ddu90K8/P8QTjsJHNX1/3J3gGWO6ufXjcZL2KCsKP7tMKZ8FGxZSVKKC
 0k0qKRcNgEZ+ZeP/1yZduW5MRGLtSvAcaWq9HNgPEVytKklQ1xVNz/m0C6I497+amWDTPwJh+aB/0
 si5JWEReZx8Gkjf0=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqHh-00063P-Sh for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:03:35 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso16112925e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783609398; x=1784214198; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I0wXOWfoPXhhX0Rj2YmcHCJEdqU9iFtVhUUJZlS7Irk=;
 b=SQqNec+BAhITjNKbmazr8tQVlsjDTMSzCz+avpfElbKE/xHO/RiO7+4nrCTHkvDqgW
 m1pjtKYljNRwHFGaohY7naVskAKud1eFNgCyh/cmRuSiyhnZr/GDKI4smlP6pRM88qcv
 XbHpkt85DUguTlOtGDFH38TH/9ItVkZMXLnB3P5eYgjPrzrPZqJjGsBODlXW6+UozCTf
 WUi8lalhLCq6L/K2OdAakschc1RCJn03aCpQbR13b1tQmAqwvIZoAfpw/K6Q5WgJvTAB
 NKVmBkt4jls/qQYluN1NzFbPURwQGXDFi4JbK1A7ZEhtnSuJSJmE7969KX8e43GngNHL
 fp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609398; x=1784214198;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I0wXOWfoPXhhX0Rj2YmcHCJEdqU9iFtVhUUJZlS7Irk=;
 b=gSUelAJE++vo8XI0sMoVR5X+Y7QoWSYYWU+g3u/8u3tdHZYpculndzZnO28GFp2WJH
 ADJnyRqMb+GhUItGOxrMlECfgwUYn42O+vm4TaeHVfTYd71eLHWN7tD/fr63wXK1zcax
 DhrxM9f6tpGP6czitpBMyfYeV9Rc3VX9ACMsEfY/z4k5tbFQyg/6jn4abrBnAamtu+cq
 j4r/72MiNQn7hXLAAluP0haDYbSw7gEUmweO1Oa9BXhVPRKRD/jXXq3dK1Bg3WM6X9WE
 YpEJxtxZSWvXBespiHBL6+UUZ1RM+B+dPYd7DLESBsRLvX9lPZj7F7TQVELy7QhOF0vb
 ACZw==
X-Gm-Message-State: AOJu0YzWSYgI3UkesYcANqbCbfeh8p3HgPYzkPgDChaF4dwHUUuotWEH
 UFTEyto6ZzL+fAvIsg9hJZwf8klajvKY6PLxIZwpgazOIGyYIWXCKVp7+oQLKq17DqT+95Oaxeg
 kt+bdC0rTd89YbQMVRhDwwNwolXbQlVqZZNBGMV9Pa1AVKRjf4F1wFsZ/fisCOdMDRpdJrZ1d0I
 dnSm8hIw==
X-Gm-Gg: AfdE7cmUyn0BUBDvllY3YnSIBbUQyv5PhgC+Fubw/tVba2ajgt/rKxt2gVNy1slF34G
 Htw38NQjlAGpZEcvJHzoBCkEEcMwxSZWNPWM6z8nQfSyC372pdxJpUYTXC8PGmrVRJ1zI/K7kzd
 fBiTbPfvjXSHtrkLjAzsNblNMxZNGk8hAKHmM02vpUrOnZT3LIq4SpDFeUP0cKPGTBxCR9sx23x
 UxGT1owUtWSFHYJxsb1FjdJ5Bt5T7aLrQLM+Ss35JWIyn5wS4PeHx2lIvcVI7GU1Ibpgy2IRAUf
 l7YtbFuhWq3Cw1GtD7+hPW/9IVr+vfnJXZaeblUwAM+nehpeqUvRU1okRv9TH5DT1r7skvLuPIt
 jrewQ4cK/vU3Uf9ffADPTG4LF4hcR3tAmMj8K/h5hSi3cyH/pTQ5KcTfKpQeJih5MpVFUl2u+Ay
 Ah9ooBlL3HA1dCZx1MyLYrCPPReFBIzf9Aa/TQ8TTqDVB05UL/ABinbkUdpn6fh71aT1wSHTpyG
 fQfZl12OM3ZOKk6dsqXQKCl4x7QzuZ+ra4mBoQujdiEz3L5f5Wnd+5cV0e4mP0CMHUDjQbd6iGb
 EhI=
X-Received: by 2002:a05:6000:382:b0:478:65a8:262d with SMTP id
 ffacd0b85a97d-47df07157f1mr7232197f8f.9.1783602952696; 
 Thu, 09 Jul 2026 06:15:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8f1sm52179140f8f.3.2026.07.09.06.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:15:51 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 13:15:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: cb70de4b43ae34fc00ffcd8162f776e4b9a0cf3f
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b274a2e1cba1770b3d94a8c3272d17b529fcbed-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqHh-00063P-Sh
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6825653246281733672=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6825653246281733672==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DbUsjCvCm18="; charset=UTF-8

--DbUsjCvCm18=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1772?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: options: Factor out options display code from options=2Ec
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: Fact=
or out options display code from options=2Ec

options=2Ec is a huge, unwiel=
dly file=2E So remove some
closely related code that has no direct dependen=
cies
with the other functions in the file=2E

In this case it is the code t=
hat prints out the current
configuration=2E

Change-Id: I61762374c141662d59=
6bbf88b64ca7f7472b5149
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/op=
envpn=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/openvpn=
/options_show=2Ec
A src/openvpn/options_show=2Eh
7 files changed, 677 inser=
tions(+), 619 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/72/1772/2

diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt
index 4779d69=2E=2Eb6054d6 100644
--- a/CMakeLists=2Etxt
+++ b/CMake=
Lists=2Etxt
@@ -518,6 +518,8 @@
     src/openvpn/options_util=2Ec
     src/=
openvpn/options_util=2Eh
     src/openvpn/options_parse=2Ec
+    src/openvp=
n/options_show=2Ec
+    src/openvpn/options_show=2Eh
     src/openvpn/otime=
=2Ec
     src/openvpn/otime=2Eh
     src/openvpn/ovpn_dco_win=2Eh
diff --gi=
t a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index ff8cc54=2E=
=2E0fbd006 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefil=
e=2Eam
@@ -108,6 +108,7 @@
 	pkcs11_mbedtls=2Ec \
 	openvpn=2Ec openvpn=2Eh=
 \
 	options=2Ec options=2Eh \
+	options_show=2Ec options_show=2Eh \
 	opti=
ons_util=2Ec options_util=2Eh \
 	options_parse=2Ec \
 	otime=2Ec otime=2Eh=
 \
diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec
index 5e1=
f680=2E=2E24d6bb6 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/src/openvpn/op=
envpn=2Ec
@@ -30,6 +30,7 @@
 #include "forward=2Eh"
 #include "multi=2Eh"
 =
#include "win32=2Eh"
+#include "options_show=2Eh"
 #include "platform=2Eh"
=
 
 #include "memdbg=2Eh"
diff --git a/src/openvpn/options=2Ec b/src/openvpn=
/options=2Ec
index 2dcb707=2E=2E8f5bc2a 100644
--- a/src/openvpn/options=2E=
c
+++ b/src/openvpn/options=2Ec
@@ -927,40 +927,6 @@
     gc_free(&o->dns_o=
ptions=2Egc);
 }
 
-#ifndef ENABLE_SMALL
-
-static const char *
-pull_filte=
r_type_name(int type)
-{
-    if (type =3D=3D PUF_TYPE_ACCEPT)
-    {
-    =
    return "accept";
-    }
-    if (type =3D=3D PUF_TYPE_IGNORE)
-    {
- =
       return "ignore";
-    }
-    if (type =3D=3D PUF_TYPE_REJECT)
-    {=

-        return "reject";
-    }
-    else
-    {
-        return "???";
-=
    }
-}
-
-#define SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, "  " #=
name " =3D " format, (value))
-#define SHOW_STR(var)                  SHOW_=
PARM(var, (o->var ? o->var : "[UNDEF]"), "'%s'")
-#define SHOW_STR_INLINE(v=
ar) \
-    SHOW_PARM(var, o->var##_inline ? "[INLINE]" : (o->var ? o->var :=
 "[UNDEF]"), "'%s'")
-#define SHOW_INT(var)      SHOW_PARM(var, o->var, "%d=
")
-#define SHOW_UINT(var)     SHOW_PARM(var, o->var, "%u")
-#define SHOW_I=
NT64(var)    SHOW_PARM(var, o->var, "%" PRIi64)
-#define SHOW_UNSIGNED(var)=
 SHOW_PARM(var, o->var, "0x%08x")
-#define SHOW_BOOL(var)     SHOW_PARM(var=
, (o->var ? "ENABLED" : "DISABLED"), "%s");
-
-#endif /* ifndef ENABLE_SMAL=
L */
 
 static void
 setenv_connection_entry(struct env_set *es, const stru=
ct connection_entry *e, const int i)
@@ -1253,55 +1219,6 @@
 
     return r=
et;
 }
-#ifdef _WIN32
-
-#ifndef ENABLE_SMALL
-
-static void
-show_dhcp_opt=
ion_list(const char *name, const char *const *array, unsigned int len)
-{
-=
    for (unsigned int i =3D 0; i < len; ++i)
-    {
-        msg(D_SHOW_PAR=
MS, "  %s[%u] =3D %s", name, i, array[i]);
-    }
-}
-
-static void
-show_d=
hcp_option_addrs(const char *name, const in_addr_t *array, unsigned int len=
)
-{
-    struct gc_arena gc =3D gc_new();
-    for (unsigned int i =3D 0; =
i < len; ++i)
-    {
-        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i,=
 print_in_addr_t(array[i], 0, &gc));
-    }
-    gc_free(&gc);
-}
-
-static=
 void
-show_tuntap_options(const struct tuntap_options *o)
-{
-    SHOW_BOO=
L(ip_win32_defined);
-    SHOW_INT(ip_win32_type);
-    SHOW_INT(dhcp_masq_=
offset);
-    SHOW_INT(dhcp_lease_time);
-    SHOW_INT(tap_sleep);
-    SHO=
W_UNSIGNED(dhcp_options);
-    SHOW_BOOL(dhcp_renew);
-    SHOW_BOOL(dhcp_p=
re_release);
-    SHOW_STR(domain);
-    SHOW_STR(netbios_scope);
-    SHOW=
_UNSIGNED(netbios_node_type);
-    SHOW_BOOL(disable_nbt);
-
-    show_dhcp=
_option_addrs("DNS", o->dns, o->dns_len);
-    show_dhcp_option_addrs("WINS=
", o->wins, o->wins_len);
-    show_dhcp_option_addrs("NTP", o->ntp, o->ntp=
_len);
-    show_dhcp_option_addrs("NBDD", o->nbdd, o->nbdd_len);
-    show=
_dhcp_option_list("DOMAIN-SEARCH", o->domain_search_list, o->domain_search_=
list_len);
-}
-
-#endif /* ifndef ENABLE_SMALL */
-#endif /* ifdef _WIN32 *=
/
 
 static void
 dhcp_option_dns6_parse(const char *parm, struct in6_addr =
*dns6_list, unsigned int *len, msglvl_t msglevel)
@@ -1344,116 +1261,6 @@
 =
    }
 }
 
-#ifndef ENABLE_SMALL
-static const char *
-print_vlan_accept(en=
um vlan_acceptable_frames mode)
-{
-    switch (mode)
-    {
-        case =
VLAN_ONLY_TAGGED:
-            return "tagged";
-
-        case VLAN_ONLY_U=
NTAGGED_OR_PRIORITY:
-            return "untagged";
-
-        case VLAN_A=
LL:
-            return "all";
-    }
-    return NULL;
-}
-
-static void
-=
show_p2mp_parms(const struct options *o)
-{
-    struct gc_arena gc =3D gc_=
new();
-
-    msg(D_SHOW_PARMS, "  server_network =3D %s", print_in_addr_t(=
o->server_network, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_netmask =3D %=
s", print_in_addr_t(o->server_netmask, 0, &gc));
-    msg(D_SHOW_PARMS, "  =
server_network_ipv6 =3D %s", print_in6_addr(o->server_network_ipv6, 0, &gc)=
);
-    SHOW_INT(server_netbits_ipv6);
-    msg(D_SHOW_PARMS, "  server_bri=
dge_ip =3D %s", print_in_addr_t(o->server_bridge_ip, 0, &gc));
-    msg(D_S=
HOW_PARMS, "  server_bridge_netmask =3D %s",
-        print_in_addr_t(o->se=
rver_bridge_netmask, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_bridge_pool=
_start =3D %s",
-        print_in_addr_t(o->server_bridge_pool_start, 0, &g=
c));
-    msg(D_SHOW_PARMS, "  server_bridge_pool_end =3D %s",
-        pri=
nt_in_addr_t(o->server_bridge_pool_end, 0, &gc));
-    if (o->push_list=2Eh=
ead)
-    {
-        const struct push_entry *e =3D o->push_list=2Ehead;
- =
       while (e)
-        {
-            if (e->enable)
-            {
-   =
             msg(D_SHOW_PARMS, "  push_entry =3D '%s'", e->option);
-      =
      }
-            e =3D e->next;
-        }
-    }
-    SHOW_BOOL(ifconf=
ig_pool_defined);
-    msg(D_SHOW_PARMS, "  ifconfig_pool_start =3D %s",
- =
       print_in_addr_t(o->ifconfig_pool_start, 0, &gc));
-    msg(D_SHOW_PA=
RMS, "  ifconfig_pool_end =3D %s", print_in_addr_t(o->ifconfig_pool_end, 0,=
 &gc));
-    msg(D_SHOW_PARMS, "  ifconfig_pool_netmask =3D %s",
-        p=
rint_in_addr_t(o->ifconfig_pool_netmask, 0, &gc));
-    SHOW_STR(ifconfig_p=
ool_persist_filename);
-    SHOW_INT(ifconfig_pool_persist_refresh_freq);
-=
    SHOW_BOOL(ifconfig_ipv6_pool_defined);
-    msg(D_SHOW_PARMS, "  ifconf=
ig_ipv6_pool_base =3D %s",
-        print_in6_addr(o->ifconfig_ipv6_pool_ba=
se, 0, &gc));
-    SHOW_INT(ifconfig_ipv6_pool_netbits);
-    SHOW_INT(n_bc=
ast_buf);
-    SHOW_INT(tcp_queue_limit);
-    SHOW_INT(real_hash_size);
- =
   SHOW_INT(virtual_hash_size);
-    SHOW_STR(client_connect_script);
-    =
SHOW_STR(learn_address_script);
-    SHOW_STR(client_disconnect_script);
- =
   SHOW_STR(client_crresponse_script);
-    SHOW_STR(client_config_dir);
- =
   SHOW_BOOL(ccd_exclusive);
-    SHOW_STR(tmp_dir);
-    SHOW_BOOL(push_if=
config_defined);
-    msg(D_SHOW_PARMS, "  push_ifconfig_local =3D %s",
-  =
      print_in_addr_t(o->push_ifconfig_local, 0, &gc));
-    msg(D_SHOW_PAR=
MS, "  push_ifconfig_remote_netmask =3D %s",
-        print_in_addr_t(o->pu=
sh_ifconfig_remote_netmask, 0, &gc));
-    SHOW_BOOL(push_ifconfig_ipv6_def=
ined);
-    msg(D_SHOW_PARMS, "  push_ifconfig_ipv6_local =3D %s/%d",
-    =
    print_in6_addr(o->push_ifconfig_ipv6_local, 0, &gc), o->push_ifconfig_i=
pv6_netbits);
-    msg(D_SHOW_PARMS, "  push_ifconfig_ipv6_remote =3D %s",
=
-        print_in6_addr(o->push_ifconfig_ipv6_remote, 0, &gc));
-    SHOW_B=
OOL(enable_c2c);
-    SHOW_BOOL(duplicate_cn);
-    SHOW_INT(cf_max);
-    =
SHOW_INT(cf_per);
-    SHOW_INT(cf_initial_max);
-    SHOW_INT(cf_initial_p=
er);
-    SHOW_UINT(max_clients);
-    SHOW_INT(max_routes_per_client);
-  =
  SHOW_STR(auth_user_pass_verify_script);
-    SHOW_BOOL(auth_user_pass_ver=
ify_script_via_file);
-    SHOW_BOOL(auth_token_generate);
-    SHOW_BOOL(f=
orce_key_material_export);
-    SHOW_INT(auth_token_lifetime);
-    SHOW_ST=
R_INLINE(auth_token_secret_file);
-#if PORT_SHARE
-    SHOW_STR(port_share_=
host);
-    SHOW_STR(port_share_port);
-#endif
-    SHOW_BOOL(vlan_tagging)=
;
-    msg(D_SHOW_PARMS, "  vlan_accept =3D %s", print_vlan_accept(o->vlan_=
accept));
-    SHOW_INT(vlan_pvid);
-
-    SHOW_BOOL(client);
-    SHOW_BOO=
L(pull);
-    SHOW_STR_INLINE(auth_user_pass_file);
-
-    gc_free(&gc);
-}=

-
-#endif /* ! ENABLE_SMALL */
-
 static void
 option_iroute(struct option=
s *o, const char *network_str, const char *netmask_str,
               msgl=
vl_t msglevel)
@@ -1498,37 +1305,6 @@
     o->iroutes_ipv6 =3D ir;
 }
 
-#i=
fndef ENABLE_SMALL
-static void
-show_http_proxy_options(const struct http_=
proxy_options *o)
-{
-    int i;
-    msg(D_SHOW_PARMS, "BEGIN http_proxy")=
;
-    SHOW_STR(server);
-    SHOW_STR(port);
-    SHOW_STR(auth_method_str=
ing);
-    SHOW_STR(auth_file);
-    SHOW_STR(auth_file_up);
-    SHOW_BOOL=
(inline_creds);
-    SHOW_BOOL(nocache);
-    SHOW_STR(http_version);
-    =
SHOW_STR(user_agent);
-    for (i =3D 0; i < MAX_CUSTOM_HTTP_HEADER && o->c=
ustom_headers[i]=2Ename; i++)
-    {
-        if (o->custom_headers[i]=2Eco=
ntent)
-        {
-            msg(D_SHOW_PARMS, "  custom_header[%d] =3D %=
s: %s", i, o->custom_headers[i]=2Ename,
-                o->custom_headers[=
i]=2Econtent);
-        }
-        else
-        {
-            msg(D_SHOW_=
PARMS, "  custom_header[%d] =3D %s", i, o->custom_headers[i]=2Ename);
-    =
    }
-    }
-    msg(D_SHOW_PARMS, "END http_proxy");
-}
-#endif /* ifndef=
 ENABLE_SMALL */
-
 void
 options_detach(struct options *o)
 {
@@ -1576,399=
 +1352,6 @@
     }
 }
 
-#ifndef ENABLE_SMALL
-static void
-show_connection=
_entry(const struct connection_entry *o)
-{
-    /* Display the global prot=
o only in client mode or with no '--local'*/
-    if (o->local_list->len =
=3D=3D 1)
-    {
-        msg(D_SHOW_PARMS, "  proto =3D %s", proto2ascii(o=
->proto, o->af, false));
-    }
-
-    msg(D_SHOW_PARMS, "  Local Sockets:"=
);
-    for (int i =3D 0; i < o->local_list->len; i++)
-    {
-        msg(=
D_SHOW_PARMS, "    [%s]:%s-%s", o->local_list->array[i]->local,
-          =
  o->local_list->array[i]->port,
-            proto2ascii(o->local_list->ar=
ray[i]->proto, o->af, false));
-    }
-    SHOW_STR(remote);
-    SHOW_STR(=
remote_port);
-    SHOW_BOOL(remote_float);
-    SHOW_BOOL(bind_defined);
-=
    SHOW_BOOL(bind_local);
-    SHOW_BOOL(bind_ipv6_only);
-    SHOW_INT(co=
nnect_retry_seconds);
-    SHOW_INT(connect_timeout);
-
-    if (o->http_pr=
oxy_options)
-    {
-        show_http_proxy_options(o->http_proxy_options)=
;
-    }
-    SHOW_STR(socks_proxy_server);
-    SHOW_STR(socks_proxy_port)=
;
-    SHOW_INT(tun_mtu);
-    SHOW_BOOL(tun_mtu_defined);
-    SHOW_INT(li=
nk_mtu);
-    SHOW_BOOL(link_mtu_defined);
-    SHOW_INT(tun_mtu_extra);
- =
   SHOW_BOOL(tun_mtu_extra_defined);
-    SHOW_INT(tls_mtu);
-
-    SHOW_IN=
T(mtu_discover_type);
-
-#ifdef ENABLE_FRAGMENT
-    SHOW_INT(fragment);
-#=
endif
-    SHOW_INT(mssfix);
-    SHOW_BOOL(mssfix_encap);
-    SHOW_BOOL(m=
ssfix_fixed);
-
-    SHOW_INT(explicit_exit_notification);
-
-    SHOW_STR_=
INLINE(tls_auth_file);
-    SHOW_PARM(key_direction, keydirection2ascii(o->=
key_direction, false, true), "%s");
-    SHOW_STR_INLINE(tls_crypt_file);
-=
    SHOW_STR_INLINE(tls_crypt_v2_file);
-}
-
-
-static void
-show_connectio=
n_entries(const struct options *o)
-{
-    if (o->connection_list)
-    {
-=
        const struct connection_list *l =3D o->connection_list;
-        in=
t i;
-        for (i =3D 0; i < l->len; ++i)
-        {
-            msg(D_=
SHOW_PARMS, "Connection profiles [%d]:", i);
-            show_connection_e=
ntry(l->array[i]);
-        }
-    }
-    else
-    {
-        msg(D_SHOW_P=
ARMS, "Connection profiles [default]:");
-        show_connection_entry(&o-=
>ce);
-    }
-    msg(D_SHOW_PARMS, "Connection profiles END");
-}
-
-stati=
c void
-show_pull_filter_list(const struct pull_filter_list *l)
-{
-    str=
uct pull_filter *f;
-    if (!l)
-    {
-        return;
-    }
-
-    msg(=
D_SHOW_PARMS, "  Pull filters:");
-    for (f =3D l->head; f; f =3D f->next=
)
-    {
-        msg(D_SHOW_PARMS, "    %s \"%s\"", pull_filter_type_name(=
f->type), f->pattern);
-    }
-}
-
-#endif /* ifndef ENABLE_SMALL */
-
-voi=
d
-show_settings(const struct options *o)
-{
-#ifndef ENABLE_SMALL
-    msg=
(D_SHOW_PARMS, "Current Parameter Settings:");
-
-    SHOW_STR(config);
-
-=
    SHOW_INT(mode);
-
-#ifdef ENABLE_FEATURE_TUN_PERSIST
-    SHOW_BOOL(per=
sist_config);
-    SHOW_INT(persist_mode);
-#endif
-
-    SHOW_BOOL(show_ci=
phers);
-    SHOW_BOOL(show_digests);
-    SHOW_BOOL(show_engines);
-    SH=
OW_BOOL(genkey);
-    SHOW_STR(genkey_filename);
-    SHOW_STR(key_pass_fil=
e);
-    SHOW_BOOL(show_tls_ciphers);
-
-    SHOW_INT(connect_retry_max);
-=
    show_connection_entries(o);
-
-    SHOW_BOOL(remote_random);
-
-    SHO=
W_STR(ipchange);
-    SHOW_STR(dev);
-    SHOW_STR(dev_type);
-    SHOW_STR=
(dev_node);
-#if defined(ENABLE_DCO)
-    SHOW_BOOL(disable_dco);
-#endif
-=
    SHOW_STR(lladdr);
-    SHOW_INT(topology);
-    SHOW_STR(ifconfig_local=
);
-    SHOW_STR(ifconfig_remote_netmask);
-    SHOW_BOOL(ifconfig_noexec);=

-    SHOW_BOOL(ifconfig_nowarn);
-    SHOW_STR(ifconfig_ipv6_local);
-    =
SHOW_INT(ifconfig_ipv6_netbits);
-    SHOW_STR(ifconfig_ipv6_remote);
-
-  =
  SHOW_INT(shaper);
-    SHOW_INT(mtu_test);
-
-    SHOW_BOOL(mlock);
-
-  =
  SHOW_INT(keepalive_ping);
-    SHOW_INT(keepalive_timeout);
-    SHOW_INT=
(inactivity_timeout);
-    SHOW_INT(session_timeout);
-    SHOW_INT64(inact=
ivity_minimum_bytes);
-    SHOW_INT(ping_send_timeout);
-    SHOW_INT(ping_=
rec_timeout);
-    SHOW_INT(ping_rec_timeout_action);
-    SHOW_BOOL(ping_t=
imer_remote);
-    SHOW_INT(remap_sigusr1);
-    SHOW_BOOL(persist_tun);
- =
   SHOW_BOOL(persist_local_ip);
-    SHOW_BOOL(persist_remote_ip);
-
-#if P=
ASSTOS_CAPABILITY
-    SHOW_BOOL(passtos);
-#endif
-
-    SHOW_INT(resolve_=
retry_seconds);
-    SHOW_BOOL(resolve_in_advance);
-
-    SHOW_STR(usernam=
e);
-    SHOW_STR(groupname);
-    SHOW_STR(chroot_dir);
-    SHOW_STR(cd_d=
ir);
-#ifdef ENABLE_SELINUX
-    SHOW_STR(selinux_context);
-#endif
-    SH=
OW_STR(writepid);
-    SHOW_STR(up_script);
-    SHOW_STR(down_script);
-  =
  SHOW_BOOL(down_pre);
-    SHOW_BOOL(up_restart);
-    SHOW_BOOL(up_delay)=
;
-    SHOW_BOOL(daemon);
-    SHOW_BOOL(log);
-    SHOW_BOOL(suppress_time=
stamps);
-    SHOW_BOOL(machine_readable_output);
-    SHOW_INT(nice);
-   =
 SHOW_INT(verbosity);
-    SHOW_INT(mute);
-#ifdef ENABLE_DEBUG
-    SHOW_I=
NT(gremlin);
-#endif
-    SHOW_STR(status_file);
-    SHOW_INT(status_file_=
version);
-    SHOW_INT(status_file_update_freq);
-
-    SHOW_BOOL(occ);
- =
   SHOW_INT(rcvbuf);
-    SHOW_INT(sndbuf);
-#if defined(TARGET_LINUX)
-   =
 SHOW_INT(mark);
-#endif
-    SHOW_INT(sockflags);
-
-    SHOW_INT(comp=2Ea=
lg);
-    SHOW_INT(comp=2Eflags);
-
-    SHOW_STR(route_script);
-    SHOW_=
STR(route_default_gateway);
-    SHOW_INT(route_default_metric);
-    SHOW_=
INT(route_default_table_id);
-    SHOW_BOOL(route_noexec);
-    SHOW_INT(ro=
ute_delay);
-    SHOW_INT(route_delay_window);
-    SHOW_BOOL(route_delay_d=
efined);
-    SHOW_BOOL(route_nopull);
-    SHOW_BOOL(route_gateway_via_dhc=
p);
-    SHOW_BOOL(allow_pull_fqdn);
-    show_pull_filter_list(o->pull_fil=
ter_list);
-
-    if (o->routes)
-    {
-        print_route_options(o->rou=
tes, D_SHOW_PARMS);
-    }
-
-    if (o->client_nat)
-    {
-        print_=
client_nat_list(o->client_nat, D_SHOW_PARMS);
-    }
-
-    show_dns_option=
s(&o->dns_options);
-
-#ifdef ENABLE_MANAGEMENT
-    SHOW_STR(management_ad=
dr);
-    SHOW_STR(management_port);
-    SHOW_STR(management_user_pass);
-=
    SHOW_INT(management_log_history_cache);
-    SHOW_INT(management_echo_b=
uffer_size);
-    SHOW_STR(management_client_user);
-    SHOW_STR(managemen=
t_client_group);
-    SHOW_INT(management_flags);
-#endif
-#ifdef ENABLE_PL=
UGIN
-    if (o->plugin_list)
-    {
-        plugin_option_list_print(o->p=
lugin_list, D_SHOW_PARMS);
-    }
-#endif
-
-    SHOW_STR_INLINE(shared_sec=
ret_file);
-    SHOW_PARM(key_direction, keydirection2ascii(o->key_directio=
n, false, true), "%s");
-    SHOW_STR(ciphername);
-    SHOW_STR(ncp_cipher=
s);
-    SHOW_STR(authname);
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    SHOW_BOOL(=
engine);
-#endif /* ENABLE_CRYPTO_MBEDTLS */
-    SHOW_BOOL(mute_replay_war=
nings);
-    SHOW_INT(replay_window);
-    SHOW_INT(replay_time);
-    SHOW=
_STR(packet_id_file);
-    SHOW_BOOL(test_crypto);
-
-    SHOW_BOOL(tls_ser=
ver);
-    SHOW_BOOL(tls_client);
-    SHOW_STR_INLINE(ca_file);
-    SHOW_=
STR(ca_path);
-    SHOW_STR_INLINE(dh_file);
-    if ((o->management_flags =
& MF_EXTERNAL_CERT))
-    {
-        SHOW_PARM("cert_file", "EXTERNAL_CERT"=
, "%s");
-    }
-    else
-    {
-        SHOW_STR_INLINE(cert_file);
-    =
}
-    SHOW_STR_INLINE(extra_certs_file);
-
-    if ((o->management_flags &=
 MF_EXTERNAL_KEY))
-    {
-        SHOW_PARM("priv_key_file", "EXTERNAL_PRI=
VATE_KEY", "%s");
-    }
-    else
-    {
-        SHOW_STR_INLINE(priv_key=
_file);
-    }
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    SHOW_STR_INLINE(pkcs12_f=
ile);
-#endif
-#ifdef ENABLE_CRYPTOAPI
-    SHOW_STR(cryptoapi_cert);
-#end=
if
-    SHOW_STR(cipher_list);
-    SHOW_STR(cipher_list_tls13);
-    SHOW_=
STR(tls_cert_profile);
-    SHOW_STR(tls_verify);
-    SHOW_STR(tls_export_=
peer_cert_dir);
-    SHOW_INT(verify_x509_type);
-    SHOW_STR(verify_x509_=
name);
-    SHOW_STR_INLINE(crl_file);
-    SHOW_INT(ns_cert_type);
-    {
=
-        int i;
-        for (i =3D 0; i < MAX_PARMS; i++)
-        {
-    =
        SHOW_INT(remote_cert_ku[i]);
-        }
-    }
-    SHOW_STR(remote=
_cert_eku);
-    if (o->verify_hash)
-    {
-        SHOW_INT(verify_hash_a=
lgo);
-        SHOW_INT(verify_hash_depth);
-        struct gc_arena gc =3D=
 gc_new();
-        const struct verify_hash_list *hl =3D o->verify_hash;
-=
        int digest_len =3D
-            (o->verify_hash_algo =3D=3D MD_SHA1=
) ? SHA_DIGEST_LENGTH : SHA256_DIGEST_LENGTH;
-        while (hl)
-        =
{
-            char *s =3D format_hex_ex(hl->hash, digest_len, 0, 1, ":", &=
gc);
-            SHOW_PARM(verify_hash, s, "%s");
-            hl =3D hl->=
next;
-        }
-        gc_free(&gc);
-    }
-    SHOW_INT(ssl_flags);
-
=
-    SHOW_INT(tls_timeout);
-
-    SHOW_INT64(renegotiate_bytes);
-    SHOW=
_INT64(renegotiate_packets);
-    SHOW_INT(renegotiate_seconds);
-
-    SHO=
W_INT(handshake_window);
-    SHOW_INT(transition_window);
-
-    SHOW_BOOL=
(single_session);
-    SHOW_BOOL(push_peer_info);
-    SHOW_BOOL(tls_exit);=

-
-    SHOW_STR(tls_crypt_v2_metadata);
-
-#ifdef ENABLE_PKCS11
-    {
-  =
      int i;
-        for (i =3D 0; i < MAX_PARMS && o->pkcs11_providers[i]=
 !=3D NULL; i++)
-        {
-            SHOW_PARM(pkcs11_providers, o->pkc=
s11_providers[i], "%s");
-        }
-    }
-    {
-        int i;
-        =
for (i =3D 0; i < MAX_PARMS; i++)
-        {
-            SHOW_PARM(pkcs11_=
protected_authentication,
-                      o->pkcs11_protected_authen=
tication[i] ? "ENABLED" : "DISABLED", "%s");
-        }
-    }
-    {
-    =
    int i;
-        for (i =3D 0; i < MAX_PARMS; i++)
-        {
-         =
   SHOW_PARM(pkcs11_private_mode, o->pkcs11_private_mode[i], "%08x");
-    =
    }
-    }
-    {
-        int i;
-        for (i =3D 0; i < MAX_PARMS; i=
++)
-        {
-            SHOW_PARM(pkcs11_cert_private, o->pkcs11_cert_p=
rivate[i] ? "ENABLED" : "DISABLED",
-                      "%s");
-        =
}
-    }
-    SHOW_INT(pkcs11_pin_cache_period);
-    SHOW_STR(pkcs11_id);
=
-    SHOW_BOOL(pkcs11_id_management);
-#endif /* ENABLE_PKCS11 */
-
-    sh=
ow_p2mp_parms(o);
-
-#ifdef _WIN32
-    SHOW_BOOL(show_net_up);
-    SHOW_I=
NT(route_method);
-    SHOW_BOOL(block_outside_dns);
-    show_tuntap_optio=
ns(&o->tuntap_options);
-#endif
-#endif /* ifndef ENABLE_SMALL */
-}
-
-#un=
def SHOW_PARM
-#undef SHOW_STR
-#undef SHOW_INT
-#undef SHOW_BOOL
-
 #ifdef=
 ENABLE_MANAGEMENT
 
 static struct http_proxy_options *
diff --git a/src/o=
penvpn/options=2Eh b/src/openvpn/options=2Eh
index a111cf8=2E=2E85d16f9 100=
644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -896,8 +=
896,6 @@
 
 void setenv_settings(struct env_set *es, const struct options *=
o);
 
-void show_settings(const struct options *o);
-
 bool string_defined_=
equal(const char *s1, const char *s2);
 
 const char *options_string_versio=
n(const char *s, struct gc_arena *gc);
diff --git a/src/openvpn/options_sho=
w=2Ec b/src/openvpn/options_show=2Ec
new file mode 100644
index 0000000=2E=
=2E34c00df
--- /dev/null
+++ b/src/openvpn/options_show=2Ec
@@ -0,0 +1,631 =
@@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *   =
          over a single UDP port, with support for SSL/TLS-based
+ *       =
      session authentication and key exchange,
+ *             packet encry=
ption, packet authentication, and
+ *             packet compression=2E
+ *=

+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  Th=
is program is free software; you can redistribute it and/or modify
+ *  it =
under the terms of the GNU General Public License version 2
+ *  as publish=
ed by the Free Software Foundation=2E
+ *
+ *  This program is distributed =
in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without =
even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
=
+ *
+ *  You should have received a copy of the GNU General Public License =
along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses=
/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifnde=
f ENABLE_SMALL
+
+#include "syshead=2Eh"
+
+#include "crypto=2Eh"
+#include=
 "error=2Eh"
+#include "options=2Eh"
+
+static const char *
+pull_filter_ty=
pe_name(int type)
+{
+    if (type =3D=3D PUF_TYPE_ACCEPT)
+    {
+        =
return "accept";
+    }
+    if (type =3D=3D PUF_TYPE_IGNORE)
+    {
+     =
   return "ignore";
+    }
+    if (type =3D=3D PUF_TYPE_REJECT)
+    {
+  =
      return "reject";
+    }
+    else
+    {
+        return "???";
+    =
}
+}
+
+#define SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, "  " #name=
 " =3D " format, (value))
+#define SHOW_STR(var)                  SHOW_PARM=
(var, (o->var ? o->var : "[UNDEF]"), "'%s'")
+#define SHOW_STR_INLINE(var) =
\
+    SHOW_PARM(var, o->var##_inline ? "[INLINE]" : (o->var ? o->var : "[U=
NDEF]"), "'%s'")
+#define SHOW_INT(var)      SHOW_PARM(var, o->var, "%d")
+=
#define SHOW_UINT(var)     SHOW_PARM(var, o->var, "%u")
+#define SHOW_INT64=
(var)    SHOW_PARM(var, o->var, "%" PRIi64)
+#define SHOW_UNSIGNED(var) SHO=
W_PARM(var, o->var, "0x%08x")
+#define SHOW_BOOL(var)     SHOW_PARM(var, (o=
->var ? "ENABLED" : "DISABLED"), "%s");
+
+#ifdef _WIN32
+
+static void
+sh=
ow_dhcp_option_list(const char *name, const char *const *array, unsigned in=
t len)
+{
+    for (unsigned int i =3D 0; i < len; ++i)
+    {
+        msg=
(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, array[i]);
+    }
+}
+
+static v=
oid
+show_dhcp_option_addrs(const char *name, const in_addr_t *array, unsig=
ned int len)
+{
+    struct gc_arena gc =3D gc_new();
+    for (unsigned in=
t i =3D 0; i < len; ++i)
+    {
+        msg(D_SHOW_PARMS, "  %s[%u] =3D %s=
", name, i, print_in_addr_t(array[i], 0, &gc));
+    }
+    gc_free(&gc);
+=
}
+
+static void
+show_tuntap_options(const struct tuntap_options *o)
+{
+ =
   SHOW_BOOL(ip_win32_defined);
+    SHOW_INT(ip_win32_type);
+    SHOW_INT=
(dhcp_masq_offset);
+    SHOW_INT(dhcp_lease_time);
+    SHOW_INT(tap_sleep=
);
+    SHOW_UNSIGNED(dhcp_options);
+    SHOW_BOOL(dhcp_renew);
+    SHOW_=
BOOL(dhcp_pre_release);
+    SHOW_STR(domain);
+    SHOW_STR(netbios_scope)=
;
+    SHOW_UNSIGNED(netbios_node_type);
+    SHOW_BOOL(disable_nbt);
+
+  =
  show_dhcp_option_addrs("DNS", o->dns, o->dns_len);
+    show_dhcp_option_=
addrs("WINS", o->wins, o->wins_len);
+    show_dhcp_option_addrs("NTP", o->=
ntp, o->ntp_len);
+    show_dhcp_option_addrs("NBDD", o->nbdd, o->nbdd_len)=
;
+    show_dhcp_option_list("DOMAIN-SEARCH", o->domain_search_list, o->dom=
ain_search_list_len);
+}
+#endif /* ifdef _WIN32 */
+
+static const char *
=
+print_vlan_accept(enum vlan_acceptable_frames mode)
+{
+    switch (mode)
=
+    {
+        case VLAN_ONLY_TAGGED:
+            return "tagged";
+
+   =
     case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
+            return "untagged";
+=

+        case VLAN_ALL:
+            return "all";
+    }
+    return NULL=
;
+}
+
+static void
+show_p2mp_parms(const struct options *o)
+{
+    struc=
t gc_arena gc =3D gc_new();
+
+    msg(D_SHOW_PARMS, "  server_network =3D =
%s", print_in_addr_t(o->server_network, 0, &gc));
+    msg(D_SHOW_PARMS, " =
 server_netmask =3D %s", print_in_addr_t(o->server_netmask, 0, &gc));
+    =
msg(D_SHOW_PARMS, "  server_network_ipv6 =3D %s", print_in6_addr(o->server_=
network_ipv6, 0, &gc));
+    SHOW_INT(server_netbits_ipv6);
+    msg(D_SHOW=
_PARMS, "  server_bridge_ip =3D %s", print_in_addr_t(o->server_bridge_ip, 0=
, &gc));
+    msg(D_SHOW_PARMS, "  server_bridge_netmask =3D %s",
+        =
print_in_addr_t(o->server_bridge_netmask, 0, &gc));
+    msg(D_SHOW_PARMS, =
"  server_bridge_pool_start =3D %s",
+        print_in_addr_t(o->server_bri=
dge_pool_start, 0, &gc));
+    msg(D_SHOW_PARMS, "  server_bridge_pool_end =
=3D %s",
+        print_in_addr_t(o->server_bridge_pool_end, 0, &gc));
+   =
 if (o->push_list=2Ehead)
+    {
+        const struct push_entry *e =3D o-=
>push_list=2Ehead;
+        while (e)
+        {
+            if (e->enable=
)
+            {
+                msg(D_SHOW_PARMS, "  push_entry =3D '%s'"=
, e->option);
+            }
+            e =3D e->next;
+        }
+    }
=
+    SHOW_BOOL(ifconfig_pool_defined);
+    msg(D_SHOW_PARMS, "  ifconfig_p=
ool_start =3D %s",
+        print_in_addr_t(o->ifconfig_pool_start, 0, &gc)=
);
+    msg(D_SHOW_PARMS, "  ifconfig_pool_end =3D %s", print_in_addr_t(o->=
ifconfig_pool_end, 0, &gc));
+    msg(D_SHOW_PARMS, "  ifconfig_pool_netmas=
k =3D %s",
+        print_in_addr_t(o->ifconfig_pool_netmask, 0, &gc));
+  =
  SHOW_STR(ifconfig_pool_persist_filename);
+    SHOW_INT(ifconfig_pool_per=
sist_refresh_freq);
+    SHOW_BOOL(ifconfig_ipv6_pool_defined);
+    msg(D_=
SHOW_PARMS, "  ifconfig_ipv6_pool_base =3D %s",
+        print_in6_addr(o->=
ifconfig_ipv6_pool_base, 0, &gc));
+    SHOW_INT(ifconfig_ipv6_pool_netbits=
);
+    SHOW_INT(n_bcast_buf);
+    SHOW_INT(tcp_queue_limit);
+    SHOW_IN=
T(real_hash_size);
+    SHOW_INT(virtual_hash_size);
+    SHOW_STR(client_c=
onnect_script);
+    SHOW_STR(learn_address_script);
+    SHOW_STR(client_d=
isconnect_script);
+    SHOW_STR(client_crresponse_script);
+    SHOW_STR(c=
lient_config_dir);
+    SHOW_BOOL(ccd_exclusive);
+    SHOW_STR(tmp_dir);
+=
    SHOW_BOOL(push_ifconfig_defined);
+    msg(D_SHOW_PARMS, "  push_ifconf=
ig_local =3D %s",
+        print_in_addr_t(o->push_ifconfig_local, 0, &gc))=
;
+    msg(D_SHOW_PARMS, "  push_ifconfig_remote_netmask =3D %s",
+        =
print_in_addr_t(o->push_ifconfig_remote_netmask, 0, &gc));
+    SHOW_BOOL(p=
ush_ifconfig_ipv6_defined);
+    msg(D_SHOW_PARMS, "  push_ifconfig_ipv6_lo=
cal =3D %s/%d",
+        print_in6_addr(o->push_ifconfig_ipv6_local, 0, &gc=
), o->push_ifconfig_ipv6_netbits);
+    msg(D_SHOW_PARMS, "  push_ifconfig_=
ipv6_remote =3D %s",
+        print_in6_addr(o->push_ifconfig_ipv6_remote, =
0, &gc));
+    SHOW_BOOL(enable_c2c);
+    SHOW_BOOL(duplicate_cn);
+    SH=
OW_INT(cf_max);
+    SHOW_INT(cf_per);
+    SHOW_INT(cf_initial_max);
+    =
SHOW_INT(cf_initial_per);
+    SHOW_UINT(max_clients);
+    SHOW_INT(max_ro=
utes_per_client);
+    SHOW_STR(auth_user_pass_verify_script);
+    SHOW_BO=
OL(auth_user_pass_verify_script_via_file);
+    SHOW_BOOL(auth_token_genera=
te);
+    SHOW_BOOL(force_key_material_export);
+    SHOW_INT(auth_token_li=
fetime);
+    SHOW_STR_INLINE(auth_token_secret_file);
+#if PORT_SHARE
+   =
 SHOW_STR(port_share_host);
+    SHOW_STR(port_share_port);
+#endif
+    SH=
OW_BOOL(vlan_tagging);
+    msg(D_SHOW_PARMS, "  vlan_accept =3D %s", print=
_vlan_accept(o->vlan_accept));
+    SHOW_INT(vlan_pvid);
+
+    SHOW_BOOL(c=
lient);
+    SHOW_BOOL(pull);
+    SHOW_STR_INLINE(auth_user_pass_file);
+
=
+    gc_free(&gc);
+}
+
+static void
+show_http_proxy_options(const struct =
http_proxy_options *o)
+{
+    int i;
+    msg(D_SHOW_PARMS, "BEGIN http_pr=
oxy");
+    SHOW_STR(server);
+    SHOW_STR(port);
+    SHOW_STR(auth_metho=
d_string);
+    SHOW_STR(auth_file);
+    SHOW_STR(auth_file_up);
+    SHOW=
_BOOL(inline_creds);
+    SHOW_BOOL(nocache);
+    SHOW_STR(http_version);
=
+    SHOW_STR(user_agent);
+    for (i =3D 0; i < MAX_CUSTOM_HTTP_HEADER &&=
 o->custom_headers[i]=2Ename; i++)
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
index 0000000=2E=2E54a1998=

--- /dev/null
+++ b/src/openvpn/options_show=2Eh
@@ -0,0 +1,42 @@
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
+#include "options=2Eh=
"
+
+#ifdef ENABLE_SMALL
+
+static inline void
+show_settings(const struct =
options *o)
+{
+    (void)o;
+}
+
+#else
+
+void show_settings(const struct=
 options *o);
+
+#endif /* ENABLE_SMALL */
+
+#endif

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b51=
49
Gerrit-Change-Number: 1772
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--DbUsjCvCm18=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">op=
tions: Factor out options display code from options=2Ec<br><br>options=2Ec =
is a huge, unwieldly file=2E So remove some<br>closely related code that ha=
s no direct dependencies<br>with the other functions in the file=2E<br><br>=
In this case it is the code that prints out the current<br>configuration=2E=
<br><br>Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeList=
s=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/openvpn=2Ec<br>M sr=
c/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/openvpn/options=
_show=2Ec<br>A src/openvpn/options_show=2Eh<br>7 files changed, 677 inserti=
ons(+), 619 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/72/1772/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 4779d69=2E=2Eb605=
4d6 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMa=
keLists=2Etxt</span><br><span>@@ -518,6 +518,8 @@</span><br><span>     src/=
openvpn/options_util=2Ec</span><br><span>     src/openvpn/options_util=2Eh<=
/span><br><span>     src/openvpn/options_parse=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpn/options_show=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options_show=2E=
h</span><br><span>     src/openvpn/otime=2Ec</span><br><span>     src/openv=
pn/otime=2Eh</span><br><span>     src/openvpn/ovpn_dco_win=2Eh</span><br><s=
pan>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</spa=
n><br><span>index ff8cc54=2E=2E0fbd006 100644</span><br><span>--- a/src/ope=
nvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><b=
r><span>@@ -108,6 +108,7 @@</span><br><span> 	pkcs11_mbedtls=2Ec \</span><b=
r><span> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=
=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	options_show=
=2Ec options_show=2Eh \</span><br><span> 	options_util=2Ec options_util=2Eh=
 \</span><br><span> 	options_parse=2Ec \</span><br><span> 	otime=2Ec otime=
=2Eh \</span><br><span>diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/o=
penvpn=2Ec</span><br><span>index 5e1f680=2E=2E24d6bb6 100644</span><br><spa=
n>--- a/src/openvpn/openvpn=2Ec</span><br><span>+++ b/src/openvpn/openvpn=
=2Ec</span><br><span>@@ -30,6 +30,7 @@</span><br><span> #include &quot;forw=
ard=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><sp=
an> #include &quot;win32=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;options_show=2Eh&quot;</span><br><span> #incl=
ude &quot;platform=2Eh&quot;</span><br><span> </span><br><span> #include &q=
uot;memdbg=2Eh&quot;</span><br><span>diff --git a/src/openvpn/options=2Ec b=
/src/openvpn/options=2Ec</span><br><span>index 2dcb707=2E=2E8f5bc2a 100644<=
/span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/ope=
nvpn/options=2Ec</span><br><span>@@ -927,40 +927,6 @@</span><br><span>     =
gc_free(&amp;o-&gt;dns_options=2Egc);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-pull_filter_type_name(int type)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (type =3D=3D PUF_TYPE_ACCEPT)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return &quot;accept&quot;;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (type =3D=3D PUF_TYPE_IGNORE)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return &quot;ignore&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (type =3D=3D PUF_TYPE_REJECT)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return &quot;reject&quot;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return &=
quot;???&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, &quot;=
  &quot; #name &quot; =3D &quot; format, (value))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define SHOW_STR(var)                  SHOW_PAR=
M(var, (o-&gt;var ? o-&gt;var : &quot;[UNDEF]&quot;), &quot;&#39;%s&#39;&qu=
ot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_STR_=
INLINE(var) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_PARM(var, o-&gt;var##_inline ? &quot;[INLINE]&quot; : (o-&gt;var ? o-&gt;v=
ar : &quot;[UNDEF]&quot;), &quot;&#39;%s&#39;&quot;)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define SHOW_INT(var)      SHOW_PARM(var, o=
-&gt;var, &quot;%d&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define SHOW_UINT(var)     SHOW_PARM(var, o-&gt;var, &quot;%u&quot;)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_INT64(var) =
   SHOW_PARM(var, o-&gt;var, &quot;%&quot; PRIi64)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define SHOW_UNSIGNED(var) SHOW_PARM(var, o-&g=
t;var, &quot;0x%08x&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define SHOW_BOOL(var)     SHOW_PARM(var, (o-&gt;var ? &quot;ENABLED&q=
uot; : &quot;DISABLED&quot;), &quot;%s&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif /* ifndef ENABLE_SMALL */</span><br><span> </span><br><span> sta=
tic void</span><br><span> setenv_connection_entry(struct env_set *es, const=
 struct connection_entry *e, const int i)</span><br><span>@@ -1253,55 +1219=
,6 @@</span><br><span> </span><br><span>     return ret;</span><br><span> }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_dh=
cp_option_list(const char *name, const char *const *array, unsigned int len=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    for (unsigned int i =3D 0; i &lt; le=
n; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quo=
t;  %s[%u] =3D %s&quot;, name, i, array[i]);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-show_dhcp_option_addrs(const char *name, co=
nst in_addr_t *array, unsigned int len)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    for (unsigned int i =3D 0; i &lt; len; ++i)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s&quot=
;, name, i, print_in_addr_t(array[i], 0, &amp;gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-show_tuntap_options(const struct tu=
ntap_options *o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ip_win32_de=
fined);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(i=
p_win32_type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHO=
W_INT(dhcp_masq_offset);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_INT(dhcp_lease_time);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    SHOW_INT(tap_sleep);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    SHOW_UNSIGNED(dhcp_options);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_BOOL(dhcp_renew);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(dhcp_pre_release);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(domain);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(netbios_scope);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_UNSIGNED(netbios=
_node_type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_=
BOOL(disable_nbt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_dhcp_option_add=
rs(&quot;DNS&quot;, o-&gt;dns, o-&gt;dns_len);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    show_dhcp_option_addrs(&quot;WINS&quot;, o-&gt=
;wins, o-&gt;wins_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    show_dhcp_option_addrs(&quot;NTP&quot;, o-&gt;ntp, o-&gt;ntp_len);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_dhcp_option_add=
rs(&quot;NBDD&quot;, o-&gt;nbdd, o-&gt;nbdd_len);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    show_dhcp_option_list(&quot;DOMAIN-SEARCH&q=
uot;, o-&gt;domain_search_list, o-&gt;domain_search_list_len);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif /* ifndef ENABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif /* ifdef _WIN32 */</span><br><span> </span><br><span> sta=
tic void</span><br><span> dhcp_option_dns6_parse(const char *parm, struct i=
n6_addr *dns6_list, unsigned int *len, msglvl_t msglevel)</span><br><span>@=
@ -1344,116 +1261,6 @@</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE=
_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const ch=
ar *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_vlan_accept=
(enum vlan_acceptable_frames mode)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swi=
tch (mode)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        case VLAN_ONLY_TAGG=
ED:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return=
 &quot;tagged&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case VLAN_ONLY=
_UNTAGGED_OR_PRIORITY:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            return &quot;untagged&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       case VLAN_ALL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            return &quot;all&quot;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-show_p2mp_parms(const struct options *o)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_network =3D %s&quot;, print=
_in_addr_t(o-&gt;server_network, 0, &amp;gc));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_netmask =3D %=
s&quot;, print_in_addr_t(o-&gt;server_netmask, 0, &amp;gc));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server=
_network_ipv6 =3D %s&quot;, print_in6_addr(o-&gt;server_network_ipv6, 0, &a=
mp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(=
server_netbits_ipv6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg(D_SHOW_PARMS, &quot;  server_bridge_ip =3D %s&quot;, print_in_addr_=
t(o-&gt;server_bridge_ip, 0, &amp;gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_bridge_netmask =3D %=
s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print=
_in_addr_t(o-&gt;server_bridge_netmask, 0, &amp;gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_bridge=
_pool_start =3D %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        print_in_addr_t(o-&gt;server_bridge_pool_start, 0, &amp;gc));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &=
quot;  server_bridge_pool_end =3D %s&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;server_bridge_pool_end,=
 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(o-&gt;push_list=2Ehead)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const=
 struct push_entry *e =3D o-&gt;push_list=2Ehead;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        while (e)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            if (e-&gt;enable)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                msg(D_SHOW_PARMS, &quot;  push_entry =3D &#39;%=
s&#39;&quot;, e-&gt;option);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           e =3D e-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ifconfi=
g_pool_defined);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg(D_SHOW_PARMS, &quot;  ifconfig_pool_start =3D %s&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;ifconfig=
_pool_start, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_end =3D %s&quot;, print_in=
_addr_t(o-&gt;ifconfig_pool_end, 0, &amp;gc));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_netmas=
k =3D %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  print_in_addr_t(o-&gt;ifconfig_pool_netmask, 0, &amp;gc));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(ifconfig_pool_persist_f=
ilename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT=
(ifconfig_pool_persist_refresh_freq);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_BOOL(ifconfig_ipv6_pool_defined);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  ifconfig=
_ipv6_pool_base =3D %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        print_in6_addr(o-&gt;ifconfig_ipv6_pool_base, 0, &amp;gc));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ifconfig=
_ipv6_pool_netbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_INT(n_bcast_buf);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_INT(tcp_queue_limit);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SHOW_INT(real_hash_size);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_INT(virtual_hash_size);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(client_connect_script);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(learn_address_s=
cript);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(c=
lient_disconnect_script);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_STR(client_crresponse_script);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    SHOW_STR(client_config_dir);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ccd_exclusive);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(tmp_dir);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(push_ifconfig_defin=
ed);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PA=
RMS, &quot;  push_ifconfig_local =3D %s&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;push_ifconfig_local,=
 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_SHOW_PARMS, &quot;  push_ifconfig_remote_netmask =3D %s&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        print_in_addr_t(o-&gt;p=
ush_ifconfig_remote_netmask, 0, &amp;gc));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_BOOL(push_ifconfig_ipv6_defined);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  pus=
h_ifconfig_ipv6_local =3D %s/%d&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        print_in6_addr(o-&gt;push_ifconfig_ipv6_local, 0, =
&amp;gc), o-&gt;push_ifconfig_ipv6_netbits);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  push_ifconfig_ipv6_rem=
ote =3D %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    print_in6_addr(o-&gt;push_ifconfig_ipv6_remote, 0, &amp;gc));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(enable_c2c);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(duplicate_cn=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(cf_max=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(cf_per=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(cf_ini=
tial_max);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_IN=
T(cf_initial_per);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_UINT(max_clients);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_INT(max_routes_per_client);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_STR(auth_user_pass_verify_script);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(auth_user_pass_verify=
_script_via_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_BOOL(auth_token_generate);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_BOOL(force_key_material_export);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(auth_token_lifetime);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(auth_token=
_secret_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if POR=
T_SHARE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(p=
ort_share_host);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_STR(port_share_port);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BO=
OL(vlan_tagging);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
msg(D_SHOW_PARMS, &quot;  vlan_accept =3D %s&quot;, print_vlan_accept(o-&gt=
;vlan_accept));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SH=
OW_INT(vlan_pvid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(client);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(pull);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(auth=
_user_pass_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif /* ! ENABLE_SMALL */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static void</span><br><span> option_irou=
te(struct options *o, const char *network_str, const char *netmask_str,</sp=
an><br><span>               msglvl_t msglevel)</span><br><span>@@ -1498,37 =
+1305,6 @@</span><br><span>     o-&gt;iroutes_ipv6 =3D ir;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_http_pr=
oxy_options(const struct http_proxy_options *o)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg(D_SHOW_PARMS, &quot;BEGIN http_proxy&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_STR(server);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_STR(port);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_STR(auth_method_string);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(auth_file);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(auth_file_up);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(inline_creds);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(nocache);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(http_ver=
sion);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(us=
er_agent);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; MAX_CUSTOM_HTTP_HEADER &amp;&amp; o-&gt;custom_headers[i]=2En=
ame; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;custom_hea=
ders[i]=2Econtent)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(D_SHOW_PARMS, &quot;  custom_header[%d] =3D %s: %s&quot;, i, o-&gt;custom_=
headers[i]=2Ename,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             o-&gt;custom_headers[i]=2Econtent);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      msg(D_SHOW_PARMS, &quot;  custom_header[%d] =3D %s&quot;, i, o-&gt;cu=
stom_headers[i]=2Ename);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &qu=
ot;END http_proxy&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef=
 ENABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> void</span><br><span> options_detach(struct options *o)</span>=
<br><span> {</span><br><span>@@ -1576,399 +1352,6 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-show_connection_entry(const struct connection_entry *o)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* Display the global proto only in client mode or w=
ith no &#39;--local&#39;*/</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (o-&gt;local_list-&gt;len =3D=3D 1)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(D_SHOW_PARMS, &quot;  proto =3D %s&quot;, proto2ascii=
(o-&gt;proto, o-&gt;af, false));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quo=
t;  Local Sockets:&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    for (int i =3D 0; i &lt; o-&gt;local_list-&gt;len; i++)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quot;    [%s]:%s-%s&q=
uot;, o-&gt;local_list-&gt;array[i]-&gt;local,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            o-&gt;local_list-&gt;array[i]-&gt;port=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            proto2as=
cii(o-&gt;local_list-&gt;array[i]-&gt;proto, o-&gt;af, false));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_STR(remote);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_STR(remote_port);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(remote_float);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(bind_defined);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(bind_local);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(bind_ipv6_=
only);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(co=
nnect_retry_seconds);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_INT(connect_timeout);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&g=
t;http_proxy_options)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        show_htt=
p_proxy_options(o-&gt;http_proxy_options);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_STR(socks_proxy_server);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    SHOW_STR(socks_proxy_port);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_INT(tun_mtu);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_BOOL(tun_mtu_defined);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(link_mtu);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(link_mtu_defined);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(tun_mtu_ext=
ra);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(tun=
_mtu_extra_defined);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_INT(tls_mtu);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(mtu_disc=
over_type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_FRAGMENT</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(fragment);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(mssfix);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(mssfix_encap);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(mssfix_fixed);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    SHOW_INT(explicit_exit_notification);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(tls_auth_file);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    SHOW_PARM(key_direction, keydirec=
tion2ascii(o-&gt;key_direction, false, true), &quot;%s&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(tls_crypt_file=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE=
(tls_crypt_v2_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-show_connection_entries(const struct options *o)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (o-&gt;connection_list)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        const struct connection_list *l =3D o-&gt;connection_list;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; l-&gt;=
len; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_SHOW_P=
ARMS, &quot;Connection profiles [%d]:&quot;, i);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            show_connection_entry(l-&gt;array[i]=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(D_SHOW_PARMS, &quot;Connection profiles [default]:&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        show_connection_ent=
ry(&amp;o-&gt;ce);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARM=
S, &quot;Connection profiles END&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-show_pull_filter_list(const stru=
ct pull_filter_list *l)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct pull_fi=
lter *f;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!l)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg(D_SHOW_PARMS, &quot;  Pull filters:&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    for (f =3D l-&gt;head; f; f =3D f-&gt;next)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quot;    %s \=
&quot;%s\&quot;&quot;, pull_filter_type_name(f-&gt;type), f-&gt;pattern);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f /* ifndef ENABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-show_settings(const struct optio=
ns *o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;Current =
Parameter Settings:&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(co=
nfig);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(mode);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_BOOL(persist_config);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(persist_mode);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_BOOL(show_ciphers);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_BOOL(show_digests);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_BOOL(show_engines);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_BOOL(genkey);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    SHOW_STR(genkey_filename);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(key_pass_file);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(show_tls_ciphers=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(connect_retry_max);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    show_connection_entries(o=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(remote_random);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    SHOW_STR(ipchange);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_STR(dev);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_STR(dev_type);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_STR(dev_node);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_BOOL(disable_dco);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_STR(lladdr);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_INT(topology);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_STR(ifconfig_local);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    SHOW_STR(ifconfig_remote_netmask);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ifconfig_noexec)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(ifconf=
ig_nowarn);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_S=
TR(ifconfig_ipv6_local);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_INT(ifconfig_ipv6_netbits);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_STR(ifconfig_ipv6_remote);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_INT(shaper);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_INT(mtu_test);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_BOOL(mlock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(keepalive_ping);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(keepaliv=
e_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_I=
NT(inactivity_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_INT(session_timeout);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_INT64(inactivity_minimum_bytes);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ping_send_timeout);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ping_rec_timeout);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ping_rec_=
timeout_action);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_BOOL(ping_timer_remote);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_INT(remap_sigusr1);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_BOOL(persist_tun);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_BOOL(persist_local_ip);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(persist_remote_ip);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if PASSTOS_CAPABILITY</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_BOOL(passtos);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_I=
NT(resolve_retry_seconds);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_BOOL(resolve_in_advance);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_STR(username);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_STR(groupname);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_STR(chroot_dir);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    SHOW_STR(cd_dir);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_SELINUX</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    SHOW_STR(selinux_context);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_STR(writepid);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_STR(up_script);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_STR(down_script);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    SHOW_BOOL(down_pre);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SHOW_BOOL(up_restart);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_BOOL(up_delay);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_BOOL(daemon);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    SHOW_BOOL(log);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_BOOL(suppress_timestamps);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(machine_readable_output);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(nice);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(verbosity);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(mute);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(gremlin);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(status_file);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(status_file_version);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(status_fi=
le_update_freq);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(occ);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(rcvbuf);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(sndbuf);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(mark);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(sockflags);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_INT(comp=2Ealg);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_INT(comp=2Eflags);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_STR(route_script);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_STR(route_default_gateway);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_INT(route_default_metric);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(route_default_table_id=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(route=
_noexec);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT=
(route_delay);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHO=
W_INT(route_delay_window);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_BOOL(route_delay_defined);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    SHOW_BOOL(route_nopull);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    SHOW_BOOL(route_gateway_via_dhcp);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(allow_pull_fqdn);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_pull_filter_l=
ist(o-&gt;pull_filter_list);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;=
routes)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        print_route_options(o-=
&gt;routes, D_SHOW_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;client_nat)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        print_client_nat_list(o-&gt;client_=
nat, D_SHOW_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    show_dns_options(&amp;o-&gt;dns_opt=
ions);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_addr);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_=
port);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(ma=
nagement_user_pass);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_INT(management_log_history_cache);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_INT(management_echo_buffer_size);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(management_client_us=
er);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(mana=
gement_client_group);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    SHOW_INT(management_flags);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_PLUGIN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (o-&gt;plugin_list)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        plugin_op=
tion_list_print(o-&gt;plugin_list, D_SHOW_PARMS);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(shar=
ed_secret_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_PARM(key_direction, keydirection2ascii(o-&gt;key_direction, false, true=
), &quot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  SHOW_STR(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_STR(ncp_ciphers);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHOW_STR(authname);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    SHOW_BOOL(engine);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(mute_replay_warnings);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(replay_window);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(replay_t=
ime);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(pac=
ket_id_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_BOOL(test_crypto);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(tls_serve=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(tls_=
client);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_=
INLINE(ca_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_STR(ca_path);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_STR_INLINE(dh_file);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if ((o-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        SHOW_PARM(&quot;cert_file&quot;, &quot;EXTER=
NAL_CERT&quot;, &quot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        SHOW_STR_INLINE(cert_file)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(extra_certs_file=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if ((o-&gt;management_flags &amp; MF=
_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        SHOW_PARM(&quo=
t;priv_key_file&quot;, &quot;EXTERNAL_PRIVATE_KEY&quot;, &quot;%s&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        SHOW_STR_INLINE(priv_key_file);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    SHOW_STR_INLINE(pkcs12_file);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_STR(cryptoapi_cert);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SHOW_STR(cipher_list);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_STR(cipher_list_tls13);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    SHOW_STR(tls_cert_profile);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(tls_verify);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(tls_export_peer_cert_di=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(verif=
y_x509_type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_STR(verify_x509_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_STR_INLINE(crl_file);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_INT(ns_cert_type);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            SHOW_INT(remote_cert_ku[i]);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
SHOW_STR(remote_cert_eku);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (o-&gt;verify_hash)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  SHOW_INT(verify_hash_algo);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        SHOW_INT(verify_hash_depth);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        const struct verify_hash_=
list *hl =3D o-&gt;verify_hash;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        int digest_len =3D</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            (o-&gt;verify_hash_algo =3D=3D MD_SHA1) ? SHA_DI=
GEST_LENGTH : SHA256_DIGEST_LENGTH;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        while (hl)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           char *s =3D format_hex_ex(hl-&gt;hash, digest_len, 0, 1, &quot;:=
&quot;, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        SHOW_PARM(verify_hash, s, &quot;%s&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            hl =3D hl-&gt;next;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    SHOW_INT(ssl_flags);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  SHOW_INT(tls_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT64(ren=
egotiate_bytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_INT64(renegotiate_packets);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    SHOW_INT(renegotiate_seconds);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_INT(handshake_window);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    SHOW_INT(transition_window);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_BOOL(single_session);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    SHOW_BOOL(push_peer_info);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SHOW_BOOL(tls_exit);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_STR(tls_crypt_v2_metadata);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_PKCS11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt;=
 MAX_PARMS &amp;&amp; o-&gt;pkcs11_providers[i] !=3D NULL; i++)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            SHOW_PARM(pkcs11_providers, o-&=
gt;pkcs11_providers[i], &quot;%s&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; MAX=
_PARMS; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            SHOW_PARM=
(pkcs11_protected_authentication,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                      o-&gt;pkcs11_protected_authentication[i] =
? &quot;ENABLED&quot; : &quot;DISABLED&quot;, &quot;%s&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fo=
r (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            SHOW_PARM(pkcs11_private_mode, o-&gt;pkcs11_private_mode[i], &=
quot;%08x&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            SHOW_PARM(pkcs11_cert_private, =
o-&gt;pkcs11_cert_private[i] ? &quot;ENABLED&quot; : &quot;DISABLED&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
&quot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(pkcs11_pin_cache_per=
iod);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(pkc=
s11_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL=
(pkcs11_id_management);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif /* ENABLE_PKCS11 */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_p2mp_=
parms(o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(show_net_up);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(route_method);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(block_outside_d=
ns);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    show_tuntap_o=
ptions(&amp;o-&gt;tuntap_options);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif /* ifndef ENABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#undef SHOW_PARM</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#undef SHOW_STR</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#undef SHOW_INT</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#undef SHOW_BOOL</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><=
span> </span><br><span> static struct http_proxy_options *</span><br><span>=
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><s=
pan>index a111cf8=2E=2E85d16f9 100644</span><br><span>--- a/src/openvpn/opt=
ions=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -=
896,8 +896,6 @@</span><br><span> </span><br><span> void setenv_settings(str=
uct env_set *es, const struct options *o);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void show_settings(const struct opti=
ons *o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> bool string_defined_equal(const char *s1, const char *s2);</span><br><=
span> </span><br><span> const char *options_string_version(const char *s, s=
truct gc_arena *gc);</span><br><span>diff --git a/src/openvpn/options_show=
=2Ec b/src/openvpn/options_show=2Ec</span><br><span>new file mode 100644</s=
pan><br><span>index 0000000=2E=2E34c00df</span><br><span>--- /dev/null</spa=
n><br><span>+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ -0,0 +1,6=
31 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application t=
o securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             over a single UDP port, with support for SSL/TLS-b=
ased</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
session authentication and key exchange,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet encryption, packet authenticatio=
n, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright=
 (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  This program is free software; you can redistribute i=
t and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
it under the terms of the GNU General Public License version 2</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Sof=
tware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program =
is distributed in the hope that it will be useful,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even t=
he implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public L=
icense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sh=
ould have received a copy of the GNU General Public License along</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not=
, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+pull_filter_type_name(int ty=
pe)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (type =3D=3D PUF_TYPE_ACCEP=
T)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;accept&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (type =3D=3D PUF_TYPE_I=
GNORE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;ignore=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (type =3D=3D PUF_TY=
PE_REJECT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;re=
ject&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return &quot;???&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SHO=
W_PARM(name, value, format) msg(D_SHOW_PARMS, &quot;  &quot; #name &quot; =
=3D &quot; format, (value))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define SHOW_STR(var)                  SHOW_PARM(var, (o-&gt;var ? =
o-&gt;var : &quot;[UNDEF]&quot;), &quot;&#39;%s&#39;&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define SHOW_STR_INLINE(var) \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_PARM(var, o-&gt=
;var##_inline ? &quot;[INLINE]&quot; : (o-&gt;var ? o-&gt;var : &quot;[UNDE=
F]&quot;), &quot;&#39;%s&#39;&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define SHOW_INT(var)      SHOW_PARM(var, o-&gt;var, &quot=
;%d&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S=
HOW_UINT(var)     SHOW_PARM(var, o-&gt;var, &quot;%u&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define SHOW_INT64(var)    SHOW_PAR=
M(var, o-&gt;var, &quot;%&quot; PRIi64)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define SHOW_UNSIGNED(var) SHOW_PARM(var, o-&gt;var, &q=
uot;0x%08x&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine SHOW_BOOL(var)     SHOW_PARM(var, (o-&gt;var ? &quot;ENABLED&quot; : =
&quot;DISABLED&quot;), &quot;%s&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+show_dhcp_option_list(const char=
 *name, const char *const *array, unsigned int len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; len; ++i)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D =
%s&quot;, name, i, array[i]);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+show_dhcp_option_addrs(const char *name, const in=
_addr_t *array, unsigned int len)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (unsigned int i =3D 0; i &lt; len; ++i)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s&=
quot;, name, i, print_in_addr_t(array[i], 0, &amp;gc));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_tuntap_options(c=
onst struct tuntap_options *o)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_BOOL(ip_win32_defined);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    SHOW_INT(ip_win32_type);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    SHOW_INT(dhcp_masq_offset);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_INT(dhcp_lease_time);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(tap_sleep);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UNSIGNED(dhcp_options);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(dhcp_=
renew);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOO=
L(dhcp_pre_release);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_STR(domain);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SHOW_STR(netbios_scope);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    SHOW_UNSIGNED(netbios_node_type);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_BOOL(disable_nbt);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    show_dhcp_option_addrs(&quot;DNS&quot;, o-&gt;dns, o=
-&gt;dns_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
how_dhcp_option_addrs(&quot;WINS&quot;, o-&gt;wins, o-&gt;wins_len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    show_dhcp_option_addrs=
(&quot;NTP&quot;, o-&gt;ntp, o-&gt;ntp_len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    show_dhcp_option_addrs(&quot;NBDD&quot;, o-&gt=
;nbdd, o-&gt;nbdd_len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    show_dhcp_option_list(&quot;DOMAIN-SEARCH&quot;, o-&gt;domain_searc=
h_list, o-&gt;domain_search_list_len);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const=
 char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_vlan_a=
ccept(enum vlan_acceptable_frames mode)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    switch (mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case V=
LAN_ONLY_TAGGED:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return &quot;tagged&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     case VLAN_ONLY_UNTAGGED_OR_PRIORITY:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return &quot;untagged&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        case VLAN_ALL:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return &quot;all&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_p2mp_parms(con=
st struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PAR=
MS, &quot;  server_network =3D %s&quot;, print_in_addr_t(o-&gt;server_netwo=
rk, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  msg(D_SHOW_PARMS, &quot;  server_netmask =3D %s&quot;, print_in_addr_t(o-=
&gt;server_netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  server_network_ipv6 =3D %s&quot=
;, print_in6_addr(o-&gt;server_network_ipv6, 0, &amp;gc));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(server_netbits_ipv6);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS,=
 &quot;  server_bridge_ip =3D %s&quot;, print_in_addr_t(o-&gt;server_bridge=
_ip, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_SHOW_PARMS, &quot;  server_bridge_netmask =3D %s&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        print_in_addr_t(o-&gt;=
server_bridge_netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  server_bridge_pool_start =3D=
 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
rint_in_addr_t(o-&gt;server_bridge_pool_start, 0, &amp;gc));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  serv=
er_bridge_pool_end =3D %s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        print_in_addr_t(o-&gt;server_bridge_pool_end, 0, &amp;=
gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;=
push_list=2Ehead)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const st=
ruct push_entry *e =3D o-&gt;push_list=2Ehead;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        while (e)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (e-&gt;enable)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                msg(D_SHOW_PARMS, &quot;  push_entry =3D=
 &#39;%s&#39;&quot;, e-&gt;option);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            e =3D e-&gt;next;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_BOOL(ifconfig_pool_defined);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_start =3D %s&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_in_=
addr_t(o-&gt;ifconfig_pool_start, 0, &amp;gc));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_end=
 =3D %s&quot;, print_in_addr_t(o-&gt;ifconfig_pool_end, 0, &amp;gc));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &qu=
ot;  ifconfig_pool_netmask =3D %s&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        print_in_addr_t(o-&gt;ifconfig_pool_netmask, 0=
, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_STR(ifconfig_pool_persist_filename);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_INT(ifconfig_pool_persist_refresh_freq);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(ifconfig_ipv=
6_pool_defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg(D_SHOW_PARMS, &quot;  ifconfig_ipv6_pool_base =3D %s&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        print_in6_addr(o-&gt;i=
fconfig_ipv6_pool_base, 0, &amp;gc));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    SHOW_INT(ifconfig_ipv6_pool_netbits);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(n_bcast_buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(tcp_queue_limit=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(real=
_hash_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_INT(virtual_hash_size);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    SHOW_STR(client_connect_script);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    SHOW_STR(learn_address_script);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(client_disconnect_scrip=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(cli=
ent_crresponse_script);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SHOW_STR(client_config_dir);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_BOOL(ccd_exclusive);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_STR(tmp_dir);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_BOOL(push_ifconfig_defined);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot=
;  push_ifconfig_local =3D %s&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        print_in_addr_t(o-&gt;push_ifconfig_local, 0, &amp=
;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHO=
W_PARMS, &quot;  push_ifconfig_remote_netmask =3D %s&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        print_in_addr_t(o-&gt;push_=
ifconfig_remote_netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_BOOL(push_ifconfig_ipv6_defined);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  pus=
h_ifconfig_ipv6_local =3D %s/%d&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        print_in6_addr(o-&gt;push_ifconfig_ipv6_local, 0=
, &amp;gc), o-&gt;push_ifconfig_ipv6_netbits);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  push_ifconfig_ipv6=
_remote =3D %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        print_in6_addr(o-&gt;push_ifconfig_ipv6_remote, 0, &amp;gc));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(enable_c2=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(du=
plicate_cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_INT(cf_max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_INT(cf_per);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_INT(cf_initial_max);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_INT(cf_initial_per);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_UINT(max_clients);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_INT(max_routes_per_client);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_user_pass_verif=
y_script);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
BOOL(auth_user_pass_verify_script_via_file);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_BOOL(auth_token_generate);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(force_key_material_e=
xport);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT=
(auth_token_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SHOW_STR_INLINE(auth_token_secret_file);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if PORT_SHARE</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    SHOW_STR(port_share_host);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(port_share_port);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(vlan_tagging);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  vl=
an_accept =3D %s&quot;, print_vlan_accept(o-&gt;vlan_accept));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(vlan_pvid);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_BOOL(client);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(pull);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(auth_user_pass_file)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_=
http_proxy_options(const struct http_proxy_options *o)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_SHOW_PARMS, &quot;BEGIN http_proxy&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(server);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(port);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_method_string)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_=
file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(=
auth_file_up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_BOOL(inline_creds);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SHOW_BOOL(nocache);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_STR(http_version);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_STR(user_agent);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (i =3D 0; i &lt; MAX_CUSTOM_HTTP_HEADER &amp;=
&amp; o-&gt;custom_headers[i]=2Ename; i++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (o-&gt;custom_headers[i]=2Econtent)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(D_SHOW_PARMS, &quot;  custom_head=
er[%d] =3D %s: %s&quot;, i, o-&gt;custom_headers[i]=2Ename,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                o-&gt;custom_header=
s[i]=2Econtent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_SHOW_PARMS, =
&quot;  custom_header[%d] =3D %s&quot;, i, o-&gt;custom_headers[i]=2Ename);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;END http_prox=
y&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+show_connection_entry(const struct connection_entry *o)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Display the global proto only =
in client mode or with no &#39;--local&#39;*/</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (o-&gt;local_list-&gt;len =3D=3D 1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;  proto =
=3D %s&quot;, proto2ascii(o-&gt;proto, o-&gt;af, false));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(D_SHOW_PARMS, &quot;  Local Sockets:&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; o-&gt;lo=
cal_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(D_SHOW_PARMS, &quot;    [%s]:%s-%s&quot;, o-&gt;local_list-&gt;array[i]-&g=
t;local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 o-&gt;local_list-&gt;array[i]-&gt;port,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            proto2ascii(o-&gt;local_list-&gt;array[i]-=
&gt;proto, o-&gt;af, false));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_STR(remote);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_STR(remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_BOOL(remote_float);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_BOOL(bind_defined);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    SHOW_BOOL(bind_local);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_BOOL(bind_ipv6_only);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(connect_retry_seconds=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(conn=
ect_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;http_proxy_=
options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        show_http_proxy_o=
ptions(o-&gt;http_proxy_options);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_STR(socks_proxy_server);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_STR(socks_proxy_port);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SHOW_INT(tun_mtu);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_BOOL(tun_mtu_defined);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(link_mtu);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(link_mtu_defined=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(tun_=
mtu_extra);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_BOOL(tun_mtu_extra_defined);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_INT(tls_mtu);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_INT(mtu_discover_type);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABL=
E_FRAGMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
INT(fragment);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(mssfi=
x);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(ms=
sfix_encap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_BOOL(mssfix_fixed);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(expl=
icit_exit_notification);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_I=
NLINE(tls_auth_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SHOW_PARM(key_direction, keydirection2ascii(o-&gt;key_direction, fals=
e, true), &quot;%s&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_STR_INLINE(tls_crypt_file);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(tls_crypt_v2_file);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_connection_entr=
ies(const struct options *o)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o=
-&gt;connection_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t struct connection_list *l =3D o-&gt;connection_list;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        int i;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; l-&gt;len; ++i)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_SHOW_PARMS, =
&quot;Connection profiles [%d]:&quot;, i);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            show_connection_entry(l-&gt;array[i]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(D_SHOW_PARMS, &quot;Connection profiles [default]:&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        show_connec=
tion_entry(&amp;o-&gt;ce);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_SHOW_PARMS, &quot;Connection profiles END&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_pull_f=
ilter_list(const struct pull_filter_list *l)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct pull_filter *f;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!l)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  Pull filters:&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (f =
=3D l-&gt;head; f; f =3D f-&gt;next)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(D_SHOW_PARMS, &quot;    %s \&quot;%s\&quot;&quot;, pull_filt=
er_type_name(f-&gt;type), f-&gt;pattern);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+show_settings(const struct options *o)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;Current Param=
eter Settings:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(con=
fig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(mode);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(persist_config);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(persist_mode);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    SHOW_BOOL(show_ciphers);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(show_digests);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(show_engines);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(genkey);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(genkey_=
filename);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
STR(key_pass_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_BOOL(show_tls_ciphers);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_INT(connect_retry_max);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    show_connection_entries(o);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_BOOL(remote_random);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
STR(ipchange);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_STR(dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_STR(dev_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_STR(dev_node);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    SHOW_BOOL(disable_dco);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_STR(lladdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SHOW_INT(topology);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_STR(ifconfig_local);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_STR(ifconfig_remote_netmask);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(ifconfig_noexec);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(ifconfig_nowa=
rn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(if=
config_ipv6_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_INT(ifconfig_ipv6_netbits);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_STR(ifconfig_ipv6_remote);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    SHOW_INT(shaper);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_INT(mtu_test);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SHOW_BOOL(mlock);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ke=
epalive_ping);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    S=
HOW_INT(keepalive_timeout);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_INT(inactivity_timeout);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_INT(session_timeout);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT64(inactivity_minimum_bytes);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(ping_s=
end_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_INT(ping_rec_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    SHOW_INT(ping_rec_timeout_action);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_BOOL(ping_timer_remote);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(remap_sigusr1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(persist_tun);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(persi=
st_local_ip);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_BOOL(persist_remote_ip);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if PASSTOS=
_CAPABILITY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_BOOL(passtos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(resolve_retry_seconds);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(resol=
ve_in_advance);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(username);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(groupn=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(c=
hroot_dir);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_STR(cd_dir);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef=
 ENABLE_SELINUX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_STR(selinux_context);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_STR(writepid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_STR(up_script);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SHOW_STR(down_script);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_BOOL(down_pre);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    SHOW_BOOL(up_restart);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_BOOL(up_delay);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_BOOL(daemon);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_BOOL(log);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_BOOL(suppress_timestamps);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(machine_readabl=
e_output);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
INT(nice);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
INT(verbosity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_INT(mute);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_INT(gremlin);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(s=
tatus_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_INT(status_file_version);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_INT(status_file_update_freq);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_BOOL(occ);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_INT(rcvbuf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_INT(sndbuf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    SHOW_INT(mark);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_INT(sockflags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
INT(comp=2Ealg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_INT(comp=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(r=
oute_script);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_STR(route_default_gateway);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    SHOW_INT(route_default_metric);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_INT(route_default_table_id);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(route_noexec);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(route_de=
lay);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(r=
oute_delay_window);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_BOOL(route_delay_defined);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    SHOW_BOOL(route_nopull);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_BOOL(route_gateway_via_dhcp);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(allow_pull_fqdn);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    show_pull_filte=
r_list(o-&gt;pull_filter_list);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(o-&gt;routes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_route=
_options(o-&gt;routes, D_SHOW_PARMS);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;c=
lient_nat)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_client_na=
t_list(o-&gt;client_nat, D_SHOW_PARMS);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    show_dns_=
options(&amp;o-&gt;dns_options);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef=
 ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   SHOW_STR(management_addr);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_STR(management_port);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    SHOW_STR(management_user_pass);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(management_log_history_ca=
che);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(m=
anagement_echo_buffer_size);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    SHOW_STR(management_client_user);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_STR(management_client_group);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(management_flags=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;plugin_list)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        plugin_option_list_print(o-&=
gt;plugin_list, D_SHOW_PARMS);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR_INLINE(shared_secret_f=
ile);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_PARM(=
key_direction, keydirection2ascii(o-&gt;key_direction, false, true), &quot;=
%s&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
STR(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 SHOW_STR(ncp_ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SHOW_STR(authname);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    SHOW_BOOL(engine);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(mute_replay_warnings);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(replay_wi=
ndow);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(=
replay_time);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_STR(packet_id_file);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SHOW_BOOL(test_crypto);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_BOOL(tls_server);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    SHOW_BOOL(tls_client);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_STR_INLINE(ca_file);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SHOW_STR(ca_path);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SHOW_STR_INLINE(dh_file);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if ((o-&gt;management_flags &amp; MF_EXTE=
RNAL_CERT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        SHOW_PARM(&quo=
t;cert_file&quot;, &quot;EXTERNAL_CERT&quot;, &quot;%s&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        SHOW_STR_INLINE(cert_file);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    SHOW_STR_INLINE(extra_certs_file);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if ((o-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        SHOW_PARM(&quot;priv_key_file&quot;, &q=
uot;EXTERNAL_PRIVATE_KEY&quot;, &quot;%s&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SH=
OW_STR_INLINE(priv_key_file);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    SHOW_STR_INLINE(pkcs12_file);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    SHOW_STR(cryptoapi_cert);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SHOW_STR(cipher_list);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    SHOW_STR(cipher_list_tls13);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SHOW_STR(tls_cert_profile);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(tls_verify);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(tls_export_peer_=
cert_dir);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
INT(verify_x509_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SHOW_STR(verify_x509_name);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    SHOW_STR_INLINE(crl_file);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SHOW_INT(ns_cert_type);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        int i;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            SHOW_INT(remote_cert_ku[i]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SHOW_STR(remote_cert_eku);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;verify_hash)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        SHOW_INT(verify_hash_algo);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        SHOW_INT(verify_hash=
_depth);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const struct verify_hash_list *hl =3D o-&gt;verify_hash;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int digest_l=
en =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (=
o-&gt;verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGEST_=
LENGTH;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        whil=
e (hl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            char *s =3D=
 format_hex_ex(hl-&gt;hash, digest_len, 0, 1, &quot;:&quot;, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            SHOW_PARM(ve=
rify_hash, s, &quot;%s&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            hl =3D hl-&gt;next;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SHOW_INT(ssl_flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_=
INT(tls_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT64(renego=
tiate_bytes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_INT64(renegotiate_packets);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    SHOW_INT(renegotiate_seconds);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_INT(handshake_window);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    SHOW_INT(transition_window);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    SHOW_BOOL(single_session);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SHOW_BOOL(push_peer_info);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(tls_exit);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    SHOW_STR(tls_crypt_v2_metadata);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef ENABLE_PKCS11</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (i =3D 0; i &lt; MAX_PARMS &amp;&amp; o-&gt;pkcs11_providers=
[i] !=3D NULL; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  SHOW_PARM(pkcs11_providers, o-&gt;pkcs11_providers[i], &quot;%s&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        int i;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            SHOW_PARM(pkcs11_protected_authentica=
tion,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
        o-&gt;pkcs11_protected_authentication[i] ? &quot;ENABLED&quot; : &q=
uot;DISABLED&quot;, &quot;%s&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int i;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &l=
t; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 SHOW_PARM(pkcs11_private_mode, o-&gt;pkcs11_private_mode[i], &quot;%08x&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        int i;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            SHOW_PARM(pkcs11_cert_private=
, o-&gt;pkcs11_cert_private[i] ? &quot;ENABLED&quot; : &quot;DISABLED&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
    &quot;%s&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(pkcs11_pin=
_cache_period);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SHOW_STR(pkcs11_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_BOOL(pkcs11_id_management);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif /* ENABLE_PKCS11 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    show_p2mp_parms(o);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _W=
IN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(s=
how_net_up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHO=
W_INT(route_method);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_BOOL(block_outside_dns);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    show_tuntap_options(&amp;o-&gt;tuntap_options);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif /* ifndef ENABLE_SMALL */</span><br><span>diff --git a/src/openvpn/opti=
ons_show=2Eh b/src/openvpn/options_show=2Eh</span><br><span>new file mode 1=
00644</span><br><span>index 0000000=2E=2E54a1998</span><br><span>--- /dev/n=
ull</span><br><span>+++ b/src/openvpn/options_show=2Eh</span><br><span>@@ -=
0,0 +1,42 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applic=
ation to securely tunnel IP networks</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             over a single UDP port, with support for SS=
L/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       session authentication and key exchange,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             packet encryption, packet authen=
tication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         packet compression=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Co=
pyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  This program is free software; you can redistr=
ibute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  it under the terms of the GNU General Public License version 2</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the F=
ree Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is distributed in the hope that it will be useful,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without=
 even the implied warranty of</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General P=
ublic License for more details=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 You should have received a copy of the GNU General Public License along</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program;=
 if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef OPTIONS_SHOW_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define OPTIONS_SHOW_H</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_SM=
ALL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+show_settings(const struct options *=
o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    (void)o;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void show_settings(const struct opti=
ons *o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_SMALL */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?=
usp=3Demail">change 1772</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1772?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1772 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--DbUsjCvCm18=--


--===============6825653246281733672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6825653246281733672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6825653246281733672==--

