Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A5FC5DF7E
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wrZkIvSd//YKXKfkW+WajtjMzMYz8UR5FLU0gWddyf8=; b=Ot78DuxzFsQS3tGoUSFs/9lWxs
	oUakm6rEodNlVsrVYpDESKEsEmSoqvl7KyN/+N3EzWVTjR88qeMdUk8HExqnENlPquf+8rn+P/rdy
	Mx5954Xw9CtWjoznReT4p7XPQQHmTwjUBJzm5K+45re3ctgcrgkh7wRFVvxUfzrXJIT8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww4KO-0006ye-5a;
	Mon, 17 Aug 2026 20:53:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ww4KI-0006yM-95
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 20:52:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dMlUo9dSUokVqvERagAVb+YqcgHMQ0LU7nAzP8ZA2t0=; b=MUsmIVCKR9oVw+Lj9JhMKHS8Oz
 BN2a/3dheGgx/zEiHkyzJpDUOM+6E4eTsAhneALFLVcyrrEMVFYJViCInTYT0uRgwAcDr2iypZVhg
 oAh+EsHHfUAEQdlIGaso9J21j8XOXe+2v1aEpqtQisjOGMANtSvp9ix02upylrLNN1EM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dMlUo9dSUokVqvERagAVb+YqcgHMQ0LU7nAzP8ZA2t0=; b=N
 S3UXkXQtB+DqIPSytVKpNFDj8nJg8/gcI+X1mVqfbnkiC+AoPxLWB2kiq7VZkdBsXhFRAIFWoc76Y
 I+Nfvtuv1cQJfp7nA1OLl/tdykdTPwDdVmOYZyYBKnYoHTdUul5YBslQG5ttKrVNUGrfV+FprQ/i/
 1YDqt79D1Acquxxs=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww4KA-0007bk-Nv for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 20:52:58 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso27335865e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786999964; x=1787604764; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dMlUo9dSUokVqvERagAVb+YqcgHMQ0LU7nAzP8ZA2t0=;
 b=Baspe1cm7qKHK9f70yGyiyQYQill7bJ+zMHNLnf5Bo+25HNTQ+KoGC/6/M5BpFP2Ob
 uiab3orN3KYkn1lv5HtndaEcFhXe8vd2EW6dzqSfiTQFUJu/OAKFzsB/zO8k/Fp3XcHI
 8mVXbuMcQpnowNFbdq7rZZ06ofwdYOnJ0qVuQxoaR8y/EwCJmVPN6l08Ej2WhtgXxY8d
 bDIx6UQw7g1O9onko4P+y33ZFM99xEdDrJShY0wFilT8ZeUdtqHjTDJWxbI4SWG7u+Uh
 xLT5caU0jijBeulYnMLbtVJctiH2BxPULzFdmfBgT6ZEldtfL9m1d5lw/OMnosTl8yQi
 B54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999964; x=1787604764;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dMlUo9dSUokVqvERagAVb+YqcgHMQ0LU7nAzP8ZA2t0=;
 b=Usn5DAQBpi54XcKnypwzwB2ft6jsXnsHNDGhFJARslHV3ZUDC9ua49pLNrU6wMXIA7
 z0IMZlXoHaHZ4JgqNz/20hy71PdekjRSXrogKFvlMEBrwKyBUlsrwQoAfe76cKtJh/ix
 vDOuJBAwHCBIryY37YR9tSZQNHiXQi6ajioxsEJmnYdophc0+kPiysasoNVhXHFPbfRO
 NWX5ZY74a01BA5j9zsYfbSkEeoYXzkcBaJAnjoZdMfuZEsYI/QJ9hFgzlP6fq6LByZkq
 4R8pqgEKr3jbWRFy+qpvOAT8TevIXbjUWFpxgyJroyGxz1A1jYng8WNeQpE4rAY1WfBr
 jxtQ==
X-Gm-Message-State: AOJu0YwP9evvkJNRKu9KcSPP/KkpjheIuJpfPMGVj2F2GqFY0uO3YcI3
 0cSSo3jGRwrNeNASV8RHXNNhn63d5VORM0BiBMjBGsrqKfJo+yijFJhXGYvTuyX8f4jeMe4ApTK
 WQw0Hkg4e3qdm4D2sVrJP/38Cw0jUSuokyhe21UJJv6vfPxbLJ9yNcDeNC2DnPjxH6SCo
X-Gm-Gg: AR+sD13HaljJU76SSKVTzUak7Ip/LfBqfOzFGVONiMWMlNfqX89GEXYSxuzA7mhzpRb
 t9GEMUagXk1sr8gnBdQEYftiK0/vzI2xkPWzvQhJo3EWYPw6MBHULW+lsYKwVflDpUHZqEX0esb
 9Mu1LknA65mkfMHeIBYfHWXNYaLujLUvc7Q5fnHkdX2ixutUrEionxTOZA4ikaYB1JaufbFVRGA
 EWVzu7jv0l8OWgTZyGJapfcMEJ+Hd1yHG4Vvdx8tx0jycw7kjNwBBREbFf+ThaJJDhI/Js9mj0I
 29ILGp6i0jcviMFAqk+DXt8Uz95rePSgL01N1Sp6eqbg0doOqlLoyGVNFiiTXd5LbxdQEbHT2Zz
 zYkLlEpXmk4rNqsPkrFbLkCdTO66I8A8lG+SR/L8EdJxEnnJ0bnt28H7Q6e7jui6f8vqtBq0iFP
 UzXPbOFcIDqpvyMSbl91UZGJQycZGFqWGdbad52WXO1W1aHM7O4W/OF9VfYIlVz/eXFqx3lGavX
 QVpyA1QyM4S/PqWJ7erDzxzTZfWRO0AZ6ESPq1OTlbSezVrmLJ7Z1khiwgs6mqdyQM6esy5oH6M
 Ku4QQPR1Ni3B6zuRcmv+/k/RdtuCtKHEg3WoxX4Z5klmoPc9/D8=
X-Received: by 2002:a05:600c:3491:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-4999fb3be75mr54833335e9.11.1786999963711; 
 Mon, 17 Aug 2026 13:52:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0fb872sm87218905e9.9.2026.08.17.13.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:43 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 20:52:40 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 6d18f2ce2df00f9de37edf752391d2f462c9068f
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <40431fd76837fe1a1a8c039276bb831119fb98ed-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ww4KA-0007bk-Nv
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4988315684476071731=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4988315684476071731==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0bcWYNmHA98="; charset=UTF-8

--0bcWYNmHA98=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: options: Factor out options display code from =
options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
ptions: Factor out options display code from options=2Ec

options=2Ec is a =
huge, unwieldly file=2E So remove some
closely related code that has no dir=
ect dependencies
with the other functions in the file=2E

In this case it i=
s the code that prints out the current
configuration=2E

Change-Id: I617623=
74c141662d596bbf88b64ca7f7472b5149
Signed-off-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772
Message-Id: <20260817=
161852=2E8376-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg38466=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/openvpn=
/Makefile=2Eam
M src/openvpn/openvpn=2Ec
M src/openvpn/options=2Ec
M src/op=
envpn/options=2Eh
A src/openvpn/options_show=2Ec
A src/openvpn/options_show=
=2Eh
7 files changed, 683 insertions(+), 620 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/72/1772/5

diff --git a=
/CMakeLists=2Etxt b/CMakeLists=2Etxt
index aae264e=2E=2E4eda75b 100644
--- =
a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -529,6 +529,8 @@
     src/open=
vpn/options_util=2Ec
     src/openvpn/options_util=2Eh
     src/openvpn/opt=
ions_parse=2Ec
+    src/openvpn/options_show=2Ec
+    src/openvpn/options_s=
how=2Eh
     src/openvpn/otime=2Ec
     src/openvpn/otime=2Eh
     src/open=
vpn/ovpn_dco_win=2Eh
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/M=
akefile=2Eam
index 1f77384=2E=2E2092e96 100644
--- a/src/openvpn/Makefile=
=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -108,6 +108,7 @@
 	pkcs11_mbedtls=
=2Ec \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
+	options_sh=
ow=2Ec options_show=2Eh \
 	options_util=2Ec options_util=2Eh \
 	options_p=
arse=2Ec \
 	otime=2Ec otime=2Eh \
diff --git a/src/openvpn/openvpn=2Ec b/s=
rc/openvpn/openvpn=2Ec
index f38660f=2E=2E7d35195 100644
--- a/src/openvpn/=
openvpn=2Ec
+++ b/src/openvpn/openvpn=2Ec
@@ -30,6 +30,7 @@
 #include "forw=
ard=2Eh"
 #include "multi=2Eh"
 #include "win32=2Eh"
+#include "options_sho=
w=2Eh"
 #include "platform=2Eh"
 #include "string=2Eh"
 
diff --git a/src/o=
penvpn/options=2Ec b/src/openvpn/options=2Ec
index 4aebfea=2E=2Ee899fa6 100=
644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -914,41 =
+914,6 @@
     gc_free(&o->dns_options=2Egc);
 }
 
-#ifndef ENABLE_SMALL
-
=
-static const char *
-pull_filter_type_name(int type)
-{
-    if (type =3D=
=3D PUF_TYPE_ACCEPT)
-    {
-        return "accept";
-    }
-    if (type =
=3D=3D PUF_TYPE_IGNORE)
-    {
-        return "ignore";
-    }
-    if (ty=
pe =3D=3D PUF_TYPE_REJECT)
-    {
-        return "reject";
-    }
-    els=
e
-    {
-        return "???";
-    }
-}
-
-#define SHOW_PARM(name, value,=
 format) msg(D_SHOW_PARMS, "  " #name " =3D " format, (value))
-#define SHO=
W_STR(var)                  SHOW_PARM(var, (o->var ? o->var : "[UNDEF]"), "=
'%s'")
-#define SHOW_STR_INLINE(var) \
-    SHOW_PARM(var, o->var##_inline =
? "[INLINE]" : (o->var ? o->var : "[UNDEF]"), "'%s'")
-#define SHOW_INT(var=
)      SHOW_PARM(var, o->var, "%d")
-#define SHOW_UINT(var)     SHOW_PARM(v=
ar, o->var, "%u")
-#define SHOW_INT64(var)    SHOW_PARM(var, o->var, "%" PR=
Ii64)
-#define SHOW_UNSIGNED(var) SHOW_PARM(var, o->var, "0x%08x")
-#define=
 SHOW_BOOL(var)     SHOW_PARM(var, (o->var ? "ENABLED" : "DISABLED"), "%s")=
;
-
-#endif /* ifndef ENABLE_SMALL */
-
 static void
 setenv_connection_ent=
ry(struct env_set *es, const struct connection_entry *e, const int i)
 {
@@=
 -1240,55 +1205,6 @@
 
     return ret;
 }
-#ifdef _WIN32
-
-#ifndef ENABLE=
_SMALL
-
-static void
-show_dhcp_option_list(const char *name, const char *=
const *array, unsigned int len)
-{
-    for (unsigned int i =3D 0; i < len;=
 ++i)
-    {
-        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, array[i=
]);
-    }
-}
-
-static void
-show_dhcp_option_addrs(const char *name, cons=
t in_addr_t *array, unsigned int len)
-{
-    struct gc_arena gc =3D gc_new=
();
-    for (unsigned int i =3D 0; i < len; ++i)
-    {
-        msg(D_SHO=
W_PARMS, "  %s[%u] =3D %s", name, i, print_in_addr_t(array[i], 0, &gc));
- =
   }
-    gc_free(&gc);
-}
-
-static void
-show_tuntap_options(const struct=
 tuntap_options *o)
-{
-    SHOW_BOOL(ip_win32_defined);
-    SHOW_INT(ip_w=
in32_type);
-    SHOW_INT(dhcp_masq_offset);
-    SHOW_INT(dhcp_lease_time)=
;
-    SHOW_INT(tap_sleep);
-    SHOW_UNSIGNED(dhcp_options);
-    SHOW_BOO=
L(dhcp_renew);
-    SHOW_BOOL(dhcp_pre_release);
-    SHOW_STR(domain);
-  =
  SHOW_STR(netbios_scope);
-    SHOW_UNSIGNED(netbios_node_type);
-    SHOW=
_BOOL(disable_nbt);
-
-    show_dhcp_option_addrs("DNS", o->dns, o->dns_len=
);
-    show_dhcp_option_addrs("WINS", o->wins, o->wins_len);
-    show_dhc=
p_option_addrs("NTP", o->ntp, o->ntp_len);
-    show_dhcp_option_addrs("NBD=
D", o->nbdd, o->nbdd_len);
-    show_dhcp_option_list("DOMAIN-SEARCH", o->d=
omain_search_list, o->domain_search_list_len);
-}
-
-#endif /* ifndef ENABL=
E_SMALL */
-#endif /* ifdef _WIN32 */
 
 static void
 dhcp_option_dns6_pars=
e(const char *parm, struct in6_addr *dns6_list, unsigned int *len, msglvl_t=
 msglevel)
@@ -1331,116 +1247,6 @@
     }
 }
 
-#ifndef ENABLE_SMALL
-stati=
c const char *
-print_vlan_accept(enum vlan_acceptable_frames mode)
-{
-   =
 switch (mode)
-    {
-        case VLAN_ONLY_TAGGED:
-            return "=
tagged";
-
-        case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
-            retur=
n "untagged";
-
-        case VLAN_ALL:
-            return "all";
-    }
-=
    return NULL;
-}
-
-static void
-show_p2mp_parms(const struct options *o=
)
-{
-    struct gc_arena gc =3D gc_new();
-
-    msg(D_SHOW_PARMS, "  serv=
er_network =3D %s", print_in_addr_t(o->server_network, 0, &gc));
-    msg(D=
_SHOW_PARMS, "  server_netmask =3D %s", print_in_addr_t(o->server_netmask, =
0, &gc));
-    msg(D_SHOW_PARMS, "  server_network_ipv6 =3D %s", print_in6_=
addr(o->server_network_ipv6, 0, &gc));
-    SHOW_INT(server_netbits_ipv6);
=
-    msg(D_SHOW_PARMS, "  server_bridge_ip =3D %s", print_in_addr_t(o->serv=
er_bridge_ip, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_bridge_netmask =3D=
 %s",
-        print_in_addr_t(o->server_bridge_netmask, 0, &gc));
-    msg=
(D_SHOW_PARMS, "  server_bridge_pool_start =3D %s",
-        print_in_addr_=
t(o->server_bridge_pool_start, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_b=
ridge_pool_end =3D %s",
-        print_in_addr_t(o->server_bridge_pool_end,=
 0, &gc));
-    if (o->push_list=2Ehead)
-    {
-        const struct push_=
entry *e =3D o->push_list=2Ehead;
-        while (e)
-        {
-          =
  if (e->enable)
-            {
-                msg(D_SHOW_PARMS, "  push_=
entry =3D '%s'", e->option);
-            }
-            e =3D e->next;
-  =
      }
-    }
-    SHOW_BOOL(ifconfig_pool_defined);
-    msg(D_SHOW_PARMS=
, "  ifconfig_pool_start =3D %s",
-        print_in_addr_t(o->ifconfig_pool=
_start, 0, &gc));
-    msg(D_SHOW_PARMS, "  ifconfig_pool_end =3D %s", prin=
t_in_addr_t(o->ifconfig_pool_end, 0, &gc));
-    msg(D_SHOW_PARMS, "  ifcon=
fig_pool_netmask =3D %s",
-        print_in_addr_t(o->ifconfig_pool_netmask=
, 0, &gc));
-    SHOW_STR(ifconfig_pool_persist_filename);
-    SHOW_INT(if=
config_pool_persist_refresh_freq);
-    SHOW_BOOL(ifconfig_ipv6_pool_define=
d);
-    msg(D_SHOW_PARMS, "  ifconfig_ipv6_pool_base =3D %s",
-        pri=
nt_in6_addr(o->ifconfig_ipv6_pool_base, 0, &gc));
-    SHOW_INT(ifconfig_ip=
v6_pool_netbits);
-    SHOW_INT(n_bcast_buf);
-    SHOW_INT(tcp_queue_limit=
);
-    SHOW_INT(real_hash_size);
-    SHOW_INT(virtual_hash_size);
-    SH=
OW_STR(client_connect_script);
-    SHOW_STR(learn_address_script);
-    SH=
OW_STR(client_disconnect_script);
-    SHOW_STR(client_crresponse_script);
=
-    SHOW_STR(client_config_dir);
-    SHOW_BOOL(ccd_exclusive);
-    SHOW_=
STR(tmp_dir);
-    SHOW_BOOL(push_ifconfig_defined);
-    msg(D_SHOW_PARMS,=
 "  push_ifconfig_local =3D %s",
-        print_in_addr_t(o->push_ifconfig_=
local, 0, &gc));
-    msg(D_SHOW_PARMS, "  push_ifconfig_remote_netmask =3D=
 %s",
-        print_in_addr_t(o->push_ifconfig_remote_netmask, 0, &gc));
-=
    SHOW_BOOL(push_ifconfig_ipv6_defined);
-    msg(D_SHOW_PARMS, "  push_i=
fconfig_ipv6_local =3D %s/%d",
-        print_in6_addr(o->push_ifconfig_ipv=
6_local, 0, &gc), o->push_ifconfig_ipv6_netbits);
-    msg(D_SHOW_PARMS, " =
 push_ifconfig_ipv6_remote =3D %s",
-        print_in6_addr(o->push_ifconfi=
g_ipv6_remote, 0, &gc));
-    SHOW_BOOL(enable_c2c);
-    SHOW_BOOL(duplica=
te_cn);
-    SHOW_INT(cf_max);
-    SHOW_INT(cf_per);
-    SHOW_INT(cf_init=
ial_max);
-    SHOW_INT(cf_initial_per);
-    SHOW_UINT(max_clients);
-    =
SHOW_INT(max_routes_per_client);
-    SHOW_STR(auth_user_pass_verify_script=
);
-    SHOW_BOOL(auth_user_pass_verify_script_via_file);
-    SHOW_BOOL(au=
th_token_generate);
-    SHOW_BOOL(force_key_material_export);
-    SHOW_IN=
T(auth_token_lifetime);
-    SHOW_STR_INLINE(auth_token_secret_file);
-#if =
PORT_SHARE
-    SHOW_STR(port_share_host);
-    SHOW_STR(port_share_port);
=
-#endif
-    SHOW_BOOL(vlan_tagging);
-    msg(D_SHOW_PARMS, "  vlan_accept=
 =3D %s", print_vlan_accept(o->vlan_accept));
-    SHOW_INT(vlan_pvid);
-
-=
    SHOW_BOOL(client);
-    SHOW_BOOL(pull);
-    SHOW_STR_INLINE(auth_user=
_pass_file);
-
-    gc_free(&gc);
-}
-
-#endif /* ! ENABLE_SMALL */
-
 stat=
ic void
 option_iroute(struct options *o, const char *network_str, const ch=
ar *netmask_str,
               msglvl_t msglevel)
@@ -1485,37 +1291,6 @@
 =
    o->iroutes_ipv6 =3D ir;
 }
 
-#ifndef ENABLE_SMALL
-static void
-show_h=
ttp_proxy_options(const struct http_proxy_options *o)
-{
-    int i;
-    m=
sg(D_SHOW_PARMS, "BEGIN http_proxy");
-    SHOW_STR(server);
-    SHOW_STR(=
port);
-    SHOW_STR(auth_method_string);
-    SHOW_STR(auth_file);
-    SH=
OW_STR(auth_file_up);
-    SHOW_BOOL(inline_creds);
-    SHOW_BOOL(nocache)=
;
-    SHOW_STR(http_version);
-    SHOW_STR(user_agent);
-    for (i =3D 0=
; i < MAX_CUSTOM_HTTP_HEADER && o->custom_headers[i]=2Ename; i++)
-    {
- =
       if (o->custom_headers[i]=2Econtent)
-        {
-            msg(D_SH=
OW_PARMS, "  custom_header[%d] =3D %s: %s", i, o->custom_headers[i]=2Ename,=

-                o->custom_headers[i]=2Econtent);
-        }
-        else=

-        {
-            msg(D_SHOW_PARMS, "  custom_header[%d] =3D %s", i,=
 o->custom_headers[i]=2Ename);
-        }
-    }
-    msg(D_SHOW_PARMS, "EN=
D http_proxy");
-}
-#endif /* ifndef ENABLE_SMALL */
-
 void
 options_detac=
h(struct options *o)
 {
@@ -1563,399 +1338,6 @@
     }
 }
 
-#ifndef ENABLE=
_SMALL
-static void
-show_connection_entry(const struct connection_entry *o=
)
-{
-    /* Display the global proto only in client mode or with no '--loc=
al'*/
-    if (o->local_list->len =3D=3D 1)
-    {
-        msg(D_SHOW_PARM=
S, "  proto =3D %s", proto2ascii(o->proto, o->af, false));
-    }
-
-    ms=
g(D_SHOW_PARMS, "  Local Sockets:");
-    for (int i =3D 0; i < o->local_li=
st->len; i++)
-    {
-        msg(D_SHOW_PARMS, "    [%s]:%s-%s", o->local_=
list->array[i]->local,
-            o->local_list->array[i]->port,
-       =
     proto2ascii(o->local_list->array[i]->proto, o->af, false));
-    }
-  =
  SHOW_STR(remote);
-    SHOW_STR(remote_port);
-    SHOW_BOOL(remote_float=
);
-    SHOW_BOOL(bind_defined);
-    SHOW_BOOL(bind_local);
-    SHOW_BOOL=
(bind_ipv6_only);
-    SHOW_INT(connect_retry_seconds);
-    SHOW_INT(conne=
ct_timeout);
-
-    if (o->http_proxy_options)
-    {
-        show_http_pr=
oxy_options(o->http_proxy_options);
-    }
-    SHOW_STR(socks_proxy_server=
);
-    SHOW_STR(socks_proxy_port);
-    SHOW_INT(tun_mtu);
-    SHOW_BOOL(=
tun_mtu_defined);
-    SHOW_INT(link_mtu);
-    SHOW_BOOL(link_mtu_defined)=
;
-    SHOW_INT(tun_mtu_extra);
-    SHOW_BOOL(tun_mtu_extra_defined);
-   =
 SHOW_INT(tls_mtu);
-
-    SHOW_INT(mtu_discover_type);
-
-#ifdef ENABLE_FR=
AGMENT
-    SHOW_INT(fragment);
-#endif
-    SHOW_INT(mssfix);
-    SHOW_BO=
OL(mssfix_encap);
-    SHOW_BOOL(mssfix_fixed);
-
-    SHOW_INT(explicit_ex=
it_notification);
-
-    SHOW_STR_INLINE(tls_auth_file);
-    SHOW_PARM(key=
_direction, keydirection2ascii(o->key_direction, false, true), "%s");
-    =
SHOW_STR_INLINE(tls_crypt_file);
-    SHOW_STR_INLINE(tls_crypt_v2_file);
-=
}
-
-
-static void
-show_connection_entries(const struct options *o)
-{
-  =
  if (o->connection_list)
-    {
-        const struct connection_list *l =
=3D o->connection_list;
-        int i;
-        for (i =3D 0; i < l->len; =
++i)
-        {
-            msg(D_SHOW_PARMS, "Connection profiles [%d]:",=
 i);
-            show_connection_entry(l->array[i]);
-        }
-    }
-  =
  else
-    {
-        msg(D_SHOW_PARMS, "Connection profiles [default]:");=

-        show_connection_entry(&o->ce);
-    }
-    msg(D_SHOW_PARMS, "Con=
nection profiles END");
-}
-
-static void
-show_pull_filter_list(const stru=
ct pull_filter_list *l)
-{
-    struct pull_filter *f;
-    if (!l)
-    {
=
-        return;
-    }
-
-    msg(D_SHOW_PARMS, "  Pull filters:");
-    f=
or (f =3D l->head; f; f =3D f->next)
-    {
-        msg(D_SHOW_PARMS, "   =
 %s \"%s\"", pull_filter_type_name(f->type), f->pattern);
-    }
-}
-
-#end=
if /* ifndef ENABLE_SMALL */
-
-void
-show_settings(const struct options *o=
)
-{
-#ifndef ENABLE_SMALL
-    msg(D_SHOW_PARMS, "Current Parameter Settin=
gs:");
-
-    SHOW_STR(config);
-
-    SHOW_INT(mode);
-
-#ifdef ENABLE_FEA=
TURE_TUN_PERSIST
-    SHOW_BOOL(persist_config);
-    SHOW_INT(persist_mode=
);
-#endif
-
-    SHOW_BOOL(show_ciphers);
-    SHOW_BOOL(show_digests);
- =
   SHOW_BOOL(show_engines);
-    SHOW_BOOL(genkey);
-    SHOW_STR(genkey_fi=
lename);
-    SHOW_STR(key_pass_file);
-    SHOW_BOOL(show_tls_ciphers);
-
=
-    SHOW_INT(connect_retry_max);
-    show_connection_entries(o);
-
-    S=
HOW_BOOL(remote_random);
-
-    SHOW_STR(ipchange);
-    SHOW_STR(dev);
-  =
  SHOW_STR(dev_type);
-    SHOW_STR(dev_node);
-#if defined(ENABLE_DCO)
-  =
  SHOW_BOOL(disable_dco);
-#endif
-    SHOW_STR(lladdr);
-    SHOW_INT(topo=
logy);
-    SHOW_STR(ifconfig_local);
-    SHOW_STR(ifconfig_remote_netmask=
);
-    SHOW_BOOL(ifconfig_noexec);
-    SHOW_BOOL(ifconfig_nowarn);
-    S=
HOW_STR(ifconfig_ipv6_local);
-    SHOW_INT(ifconfig_ipv6_netbits);
-    SH=
OW_STR(ifconfig_ipv6_remote);
-
-    SHOW_INT(shaper);
-    SHOW_INT(mtu_te=
st);
-
-    SHOW_BOOL(mlock);
-
-    SHOW_INT(keepalive_ping);
-    SHOW_IN=
T(keepalive_timeout);
-    SHOW_INT(inactivity_timeout);
-    SHOW_INT(sess=
ion_timeout);
-    SHOW_INT64(inactivity_minimum_bytes);
-    SHOW_INT(ping=
_send_timeout);
-    SHOW_INT(ping_rec_timeout);
-    SHOW_INT(ping_rec_tim=
eout_action);
-    SHOW_BOOL(ping_timer_remote);
-    SHOW_INT(remap_sigusr=
1);
-    SHOW_BOOL(persist_tun);
-    SHOW_BOOL(persist_local_ip);
-    SHO=
W_BOOL(persist_remote_ip);
-
-#if PASSTOS_CAPABILITY
-    SHOW_BOOL(passtos=
);
-#endif
-
-    SHOW_INT(resolve_retry_seconds);
-    SHOW_BOOL(resolve_i=
n_advance);
-
-    SHOW_STR(username);
-    SHOW_STR(groupname);
-    SHOW_=
STR(chroot_dir);
-    SHOW_STR(cd_dir);
-#ifdef ENABLE_SELINUX
-    SHOW_ST=
R(selinux_context);
-#endif
-    SHOW_STR(writepid);
-    SHOW_STR(up_scrip=
t);
-    SHOW_STR(down_script);
-    SHOW_BOOL(down_pre);
-    SHOW_BOOL(up=
_restart);
-    SHOW_BOOL(up_delay);
-    SHOW_BOOL(daemon);
-    SHOW_BOOL=
(log);
-    SHOW_BOOL(suppress_timestamps);
-    SHOW_BOOL(machine_readable=
_output);
-    SHOW_INT(nice);
-    SHOW_INT(verbosity);
-    SHOW_INT(mute=
);
-#ifdef ENABLE_DEBUG
-    SHOW_INT(gremlin);
-#endif
-    SHOW_STR(statu=
s_file);
-    SHOW_INT(status_file_version);
-    SHOW_INT(status_file_upda=
te_freq);
-
-    SHOW_BOOL(occ);
-    SHOW_INT(rcvbuf);
-    SHOW_INT(sndbu=
f);
-#if defined(TARGET_LINUX)
-    SHOW_INT(mark);
-#endif
-    SHOW_INT(s=
ockflags);
-
-    SHOW_INT(comp=2Ealg);
-    SHOW_INT(comp=2Eflags);
-
-   =
 SHOW_STR(route_script);
-    SHOW_STR(route_default_gateway);
-    SHOW_IN=
T(route_default_metric);
-    SHOW_INT(route_default_table_id);
-    SHOW_B=
OOL(route_noexec);
-    SHOW_INT(route_delay);
-    SHOW_INT(route_delay_wi=
ndow);
-    SHOW_BOOL(route_delay_defined);
-    SHOW_BOOL(route_nopull);
-=
    SHOW_BOOL(route_gateway_via_dhcp);
-    SHOW_BOOL(allow_pull_fqdn);
-  =
  show_pull_filter_list(o->pull_filter_list);
-
-    if (o->routes)
-    {
=
-        print_route_options(o->routes, D_SHOW_PARMS);
-    }
-
-    if (o-=
>client_nat)
-    {
-        print_client_nat_list(o->client_nat, D_SHOW_PA=
RMS);
-    }
-
-    show_dns_options(&o->dns_options);
-
-#ifdef ENABLE_MAN=
AGEMENT
-    SHOW_STR(management_addr);
-    SHOW_STR(management_port);
-  =
  SHOW_STR(management_user_pass);
-    SHOW_INT(management_log_history_cach=
e);
-    SHOW_INT(management_echo_buffer_size);
-    SHOW_STR(management_cl=
ient_user);
-    SHOW_STR(management_client_group);
-    SHOW_INT(managemen=
t_flags);
-#endif
-#ifdef ENABLE_PLUGIN
-    if (o->plugin_list)
-    {
-  =
      plugin_option_list_print(o->plugin_list, D_SHOW_PARMS);
-    }
-#endi=
f
-
-    SHOW_STR_INLINE(shared_secret_file);
-    SHOW_PARM(key_direction,=
 keydirection2ascii(o->key_direction, false, true), "%s");
-    SHOW_STR(ci=
phername);
-    SHOW_STR(ncp_ciphers);
-    SHOW_STR(authname);
-#ifndef EN=
ABLE_CRYPTO_MBEDTLS
-    SHOW_BOOL(engine);
-#endif /* ENABLE_CRYPTO_MBEDTL=
S */
-    SHOW_BOOL(mute_replay_warnings);
-    SHOW_INT(replay_window);
- =
   SHOW_INT(replay_time);
-    SHOW_STR(packet_id_file);
-    SHOW_BOOL(tes=
t_crypto);
-
-    SHOW_BOOL(tls_server);
-    SHOW_BOOL(tls_client);
-    S=
HOW_STR_INLINE(ca_file);
-    SHOW_STR(ca_path);
-    SHOW_STR_INLINE(dh_fi=
le);
-    if ((o->management_flags & MF_EXTERNAL_CERT))
-    {
-        SHO=
W_PARM("cert_file", "EXTERNAL_CERT", "%s");
-    }
-    else
-    {
-      =
  SHOW_STR_INLINE(cert_file);
-    }
-    SHOW_STR_INLINE(extra_certs_file)=
;
-
-    if ((o->management_flags & MF_EXTERNAL_KEY))
-    {
-        SHOW_=
PARM("priv_key_file", "EXTERNAL_PRIVATE_KEY", "%s");
-    }
-    else
-    =
{
-        SHOW_STR_INLINE(priv_key_file);
-    }
-#ifndef ENABLE_CRYPTO_MB=
EDTLS
-    SHOW_STR_INLINE(pkcs12_file);
-#endif
-#ifdef ENABLE_CRYPTOAPI
-=
    SHOW_STR(cryptoapi_cert);
-#endif
-    SHOW_STR(cipher_list);
-    SHOW=
_STR(cipher_list_tls13);
-    SHOW_STR(tls_cert_profile);
-    SHOW_STR(tls=
_verify);
-    SHOW_STR(tls_export_peer_cert_dir);
-    SHOW_INT(verify_x50=
9_type);
-    SHOW_STR(verify_x509_name);
-    SHOW_STR_INLINE(crl_file);
-=
    SHOW_INT(ns_cert_type);
-    {
-        int i;
-        for (i =3D 0; i=
 < MAX_PARMS; i++)
-        {
-            SHOW_INT(remote_cert_ku[i]);
-  =
      }
-    }
-    SHOW_STR(remote_cert_eku);
-    if (o->verify_hash)
-  =
  {
-        SHOW_INT(verify_hash_algo);
-        SHOW_INT(verify_hash_dept=
h);
-        struct gc_arena gc =3D gc_new();
-        struct verify_hash_l=
ist *hl =3D o->verify_hash;
-        int digest_len =3D
-            (o->ve=
rify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGEST_LENGTH;
=
-        while (hl)
-        {
-            char *s =3D format_hex_ex(hl->h=
ash, digest_len, 0, 1, ":", &gc);
-            SHOW_PARM(verify_hash, s, "%=
s");
-            hl =3D hl->next;
-        }
-        gc_free(&gc);
-    }=

-    SHOW_INT(ssl_flags);
-
-    SHOW_INT(tls_timeout);
-
-    SHOW_INT64(=
renegotiate_bytes);
-    SHOW_INT64(renegotiate_packets);
-    SHOW_INT(ren=
egotiate_seconds);
-
-    SHOW_INT(handshake_window);
-    SHOW_INT(transit=
ion_window);
-
-    SHOW_BOOL(single_session);
-    SHOW_BOOL(push_peer_inf=
o);
-    SHOW_BOOL(tls_exit);
-
-    SHOW_STR(tls_crypt_v2_metadata);
-
-#i=
fdef ENABLE_PKCS11
-    {
-        int i;
-        for (i =3D 0; i < MAX_PA=
RMS && o->pkcs11_providers[i] !=3D NULL; i++)
-        {
-            SHOW_=
PARM(pkcs11_providers, o->pkcs11_providers[i], "%s");
-        }
-    }
-  =
  {
-        int i;
-        for (i =3D 0; i < MAX_PARMS; i++)
-        {
-=
            SHOW_PARM(pkcs11_protected_authentication,
-                   =
   o->pkcs11_protected_authentication[i] ? "ENABLED" : "DISABLED", "%s");
-=
        }
-    }
-    {
-        int i;
-        for (i =3D 0; i < MAX_PARM=
S; i++)
-        {
-            SHOW_PARM(pkcs11_private_mode, o->pkcs11_pr=
ivate_mode[i], "%08x");
-        }
-    }
-    {
-        int i;
-        f=
or (i =3D 0; i < MAX_PARMS; i++)
-        {
-            SHOW_PARM(pkcs11_c=
ert_private, o->pkcs11_cert_private[i] ? "ENABLED" : "DISABLED",
-         =
             "%s");
-        }
-    }
-    SHOW_INT(pkcs11_pin_cache_period=
);
-    SHOW_STR(pkcs11_id);
-    SHOW_BOOL(pkcs11_id_management);
-#endif =
/* ENABLE_PKCS11 */
-
-    show_p2mp_parms(o);
-
-#ifdef _WIN32
-    SHOW_B=
OOL(show_net_up);
-    SHOW_INT(route_method);
-    SHOW_BOOL(block_outside=
_dns);
-    show_tuntap_options(&o->tuntap_options);
-#endif
-#endif /* ifn=
def ENABLE_SMALL */
-}
-
-#undef SHOW_PARM
-#undef SHOW_STR
-#undef SHOW_IN=
T
-#undef SHOW_BOOL
-
 #ifdef ENABLE_MANAGEMENT
 
 static struct http_proxy=
_options *
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
i=
ndex 30a146f=2E=2Ed42773f 100644
--- a/src/openvpn/options=2Eh
+++ b/src/op=
envpn/options=2Eh
@@ -901,8 +901,6 @@
 
 void setenv_settings(struct env_se=
t *es, const struct options *o);
 
-void show_settings(const struct options=
 *o);
-
 bool string_defined_equal(const char *s1, const char *s2);
 
 cons=
t char *options_string_version(const char *s, struct gc_arena *gc);
diff --=
git a/src/openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec
new file =
mode 100644
index 0000000=2E=2Eff090774
--- /dev/null
+++ b/src/openvpn/opt=
ions_show=2Ec
@@ -0,0 +1,633 @@
+/*
+ *  OpenVPN -- An application to secur=
ely tunnel IP networks
+ *             over a single UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sal=
es@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistrib=
ute it and/or modify
+ *  it under the terms of the GNU General Public Lice=
nse version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ * =
 This program is distributed in the hope that it will be useful,
+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public=
 License for more details=2E
+ *
+ *  You should have received a copy of th=
e GNU General Public License along
+ *  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "=
config=2Eh"
+#endif
+
+#ifndef ENABLE_SMALL
+
+#include "syshead=2Eh"
+
+#i=
nclude "options_show=2Eh"
+
+#include "crypto=2Eh"
+#include "error=2Eh"
+#=
include "options=2Eh"
+
+static const char *
+pull_filter_type_name(int typ=
e)
+{
+    if (type =3D=3D PUF_TYPE_ACCEPT)
+    {
+        return "accept"=
;
+    }
+    if (type =3D=3D PUF_TYPE_IGNORE)
+    {
+        return "igno=
re";
+    }
+    if (type =3D=3D PUF_TYPE_REJECT)
+    {
+        return "r=
eject";
+    }
+    else
+    {
+        return "???";
+    }
+}
+
+#define=
 SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, "  " #name " =3D " format=
, (value))
+#define SHOW_STR(var)                  SHOW_PARM(var, (o->var ?=
 o->var : "[UNDEF]"), "'%s'")
+#define SHOW_STR_INLINE(var) \
+    SHOW_PAR=
M(var, o->var##_inline ? "[INLINE]" : (o->var ? o->var : "[UNDEF]"), "'%s'"=
)
+#define SHOW_INT(var)      SHOW_PARM(var, o->var, "%d")
+#define SHOW_UI=
NT(var)     SHOW_PARM(var, o->var, "%u")
+#define SHOW_INT64(var)    SHOW_P=
ARM(var, o->var, "%" PRIi64)
+#define SHOW_UNSIGNED(var) SHOW_PARM(var, o->=
var, "0x%08x")
+#define SHOW_BOOL(var)     SHOW_PARM(var, (o->var ? "ENABLE=
D" : "DISABLED"), "%s");
+
+#ifdef _WIN32
+
+static void
+show_dhcp_option_=
list(const char *name, const char *const *array, unsigned int len)
+{
+    =
for (unsigned int i =3D 0; i < len; ++i)
+    {
+        msg(D_SHOW_PARMS, =
"  %s[%u] =3D %s", name, i, array[i]);
+    }
+}
+
+static void
+show_dhcp_=
option_addrs(const char *name, const in_addr_t *array, unsigned int len)
+{=

+    struct gc_arena gc =3D gc_new();
+    for (unsigned int i =3D 0; i < =
len; ++i)
+    {
+        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, pri=
nt_in_addr_t(array[i], 0, &gc));
+    }
+    gc_free(&gc);
+}
+
+static voi=
d
+show_tuntap_options(const struct tuntap_options *o)
+{
+    SHOW_BOOL(ip=
_win32_defined);
+    SHOW_INT(ip_win32_type);
+    SHOW_INT(dhcp_masq_offs=
et);
+    SHOW_INT(dhcp_lease_time);
+    SHOW_INT(tap_sleep);
+    SHOW_UN=
SIGNED(dhcp_options);
+    SHOW_BOOL(dhcp_renew);
+    SHOW_BOOL(dhcp_pre_r=
elease);
+    SHOW_STR(domain);
+    SHOW_STR(netbios_scope);
+    SHOW_UNS=
IGNED(netbios_node_type);
+    SHOW_BOOL(disable_nbt);
+
+    show_dhcp_opt=
ion_addrs("DNS", o->dns, o->dns_len);
+    show_dhcp_option_addrs("WINS", o=
->wins, o->wins_len);
+    show_dhcp_option_addrs("NTP", o->ntp, o->ntp_len=
);
+    show_dhcp_option_addrs("NBDD", o->nbdd, o->nbdd_len);
+    show_dhc=
p_option_list("DOMAIN-SEARCH", o->domain_search_list, o->domain_search_list=
_len);
+}
+#endif /* ifdef _WIN32 */
+
+static const char *
+print_vlan_acc=
ept(enum vlan_acceptable_frames mode)
+{
+    switch (mode)
+    {
+       =
 case VLAN_ONLY_TAGGED:
+            return "tagged";
+
+        case VLAN_=
ONLY_UNTAGGED_OR_PRIORITY:
+            return "untagged";
+
+        case =
VLAN_ALL:
+            return "all";
+    }
+    return NULL;
+}
+
+static =
void
+show_p2mp_parms(const struct options *o)
+{
+    struct gc_arena gc =
=3D gc_new();
+
+    msg(D_SHOW_PARMS, "  server_network =3D %s", print_in_=
addr_t(o->server_network, 0, &gc));
+    msg(D_SHOW_PARMS, "  server_netmas=
k =3D %s", print_in_addr_t(o->server_netmask, 0, &gc));
+    msg(D_SHOW_PAR=
MS, "  server_network_ipv6 =3D %s", print_in6_addr(o->server_network_ipv6, =
0, &gc));
+    SHOW_INT(server_netbits_ipv6);
+    msg(D_SHOW_PARMS, "  ser=
ver_bridge_ip =3D %s", print_in_addr_t(o->server_bridge_ip, 0, &gc));
+    =
msg(D_SHOW_PARMS, "  server_bridge_netmask =3D %s",
+        print_in_addr_=
t(o->server_bridge_netmask, 0, &gc));
+    msg(D_SHOW_PARMS, "  server_brid=
ge_pool_start =3D %s",
+        print_in_addr_t(o->server_bridge_pool_start=
, 0, &gc));
+    msg(D_SHOW_PARMS, "  server_bridge_pool_end =3D %s",
+    =
    print_in_addr_t(o->server_bridge_pool_end, 0, &gc));
+    if (o->push_l=
ist=2Ehead)
+    {
+        const struct push_entry *e =3D o->push_list=2Eh=
ead;
+        while (e)
+        {
+            if (e->enable)
+           =
 {
+                msg(D_SHOW_PARMS, "  push_entry =3D '%s'", e->option);
=
+            }
+            e =3D e->next;
+        }
+    }
+    SHOW_BOOL=
(ifconfig_pool_defined);
+    msg(D_SHOW_PARMS, "  ifconfig_pool_start =3D =
%s",
+        print_in_addr_t(o->ifconfig_pool_start, 0, &gc));
+    msg(D_=
SHOW_PARMS, "  ifconfig_pool_end =3D %s", print_in_addr_t(o->ifconfig_pool_=
end, 0, &gc));
+    msg(D_SHOW_PARMS, "  ifconfig_pool_netmask =3D %s",
+  =
      print_in_addr_t(o->ifconfig_pool_netmask, 0, &gc));
+    SHOW_STR(ifc=
onfig_pool_persist_filename);
+    SHOW_INT(ifconfig_pool_persist_refresh_f=
req);
+    SHOW_BOOL(ifconfig_ipv6_pool_defined);
+    msg(D_SHOW_PARMS, " =
 ifconfig_ipv6_pool_base =3D %s",
+        print_in6_addr(o->ifconfig_ipv6_=
pool_base, 0, &gc));
+    SHOW_INT(ifconfig_ipv6_pool_netbits);
+    SHOW_I=
NT(n_bcast_buf);
+    SHOW_INT(tcp_queue_limit);
+    SHOW_INT(real_hash_si=
ze);
+    SHOW_INT(virtual_hash_size);
+    SHOW_STR(client_connect_script)=
;
+    SHOW_STR(learn_address_script);
+    SHOW_STR(client_disconnect_scri=
pt);
+    SHOW_STR(client_crresponse_script);
+    SHOW_STR(client_config_d=
ir);
+    SHOW_BOOL(ccd_exclusive);
+    SHOW_STR(tmp_dir);
+    SHOW_BOOL(=
push_ifconfig_defined);
+    msg(D_SHOW_PARMS, "  push_ifconfig_local =3D %=
s",
+        print_in_addr_t(o->push_ifconfig_local, 0, &gc));
+    msg(D_S=
HOW_PARMS, "  push_ifconfig_remote_netmask =3D %s",
+        print_in_addr_=
t(o->push_ifconfig_remote_netmask, 0, &gc));
+    SHOW_BOOL(push_ifconfig_i=
pv6_defined);
+    msg(D_SHOW_PARMS, "  push_ifconfig_ipv6_local =3D %s/%d"=
,
+        print_in6_addr(o->push_ifconfig_ipv6_local, 0, &gc), o->push_ifc=
onfig_ipv6_netbits);
+    msg(D_SHOW_PARMS, "  push_ifconfig_ipv6_remote =
=3D %s",
+        print_in6_addr(o->push_ifconfig_ipv6_remote, 0, &gc));
+ =
   SHOW_BOOL(enable_c2c);
+    SHOW_BOOL(duplicate_cn);
+    SHOW_INT(cf_ma=
x);
+    SHOW_INT(cf_per);
+    SHOW_INT(cf_initial_max);
+    SHOW_INT(cf_=
initial_per);
+    SHOW_UINT(max_clients);
+    SHOW_INT(max_routes_per_cli=
ent);
+    SHOW_STR(auth_user_pass_verify_script);
+    SHOW_BOOL(auth_user=
_pass_verify_script_via_file);
+    SHOW_BOOL(auth_token_generate);
+    SH=
OW_BOOL(force_key_material_export);
+    SHOW_INT(auth_token_lifetime);
+  =
  SHOW_STR_INLINE(auth_token_secret_file);
+#if PORT_SHARE
+    SHOW_STR(po=
rt_share_host);
+    SHOW_STR(port_share_port);
+#endif
+    SHOW_BOOL(vlan=
_tagging);
+    msg(D_SHOW_PARMS, "  vlan_accept =3D %s", print_vlan_accept=
(o->vlan_accept));
+    SHOW_INT(vlan_pvid);
+
+    SHOW_BOOL(client);
+   =
 SHOW_BOOL(pull);
+    SHOW_STR_INLINE(auth_user_pass_file);
+
+    gc_free=
(&gc);
+}
+
+static void
+show_http_proxy_options(const struct http_proxy_o=
ptions *o)
+{
+    int i;
+    msg(D_SHOW_PARMS, "BEGIN http_proxy");
+    =
SHOW_STR(server);
+    SHOW_STR(port);
+    SHOW_STR(auth_method_string);
+=
    SHOW_STR(auth_file);
+    SHOW_STR(auth_file_up);
+    SHOW_BOOL(inline=
_creds);
+    SHOW_BOOL(nocache);
+    SHOW_STR(http_version);
+    SHOW_ST=
R(user_agent);
+    for (i =3D 0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_h=
eaders[i]=2Ename; i++)
+    {
+        if (o->custom_headers[i]=2Econtent)
=
+        {
+            msg(D_SHOW_PARMS, "  custom_header[%d] =3D %s: %s",=
 i, o->custom_headers[i]=2Ename,
+                o->custom_headers[i]=2Eco=
ntent);
+        }
+        else
+        {
+            msg(D_SHOW_PARMS, =
"  custom_header[%d] =3D %s", i, o->custom_headers[i]=2Ename);
+        }
+=
    }
+    msg(D_SHOW_PARMS, "END http_proxy");
+}
+
+static void
+show_con=
nection_entry(const struct connection_entry *o)
+{
+    /* Display the glob=
al proto only in client mode or with no '--local'*/
+    if (o->local_list-=
>len =3D=3D 1)
+    {
+        msg(D_SHOW_PARMS, "  proto =3D %s", proto2as=
cii(o->proto, o->af, false));
+    }
+
+    msg(D_SHOW_PARMS, "  Local Sock=
ets:");
+    for (int i =3D 0; i < o->local_list->len; i++)
+    {
+       =
 msg(D_SHOW_PARMS, "    [%s]:%s-%s", o->local_list->array[i]->local,
+     =
       o->local_list->array[i]->port,
+            proto2ascii(o->local_lis=
t->array[i]->proto, o->af, false));
+    }
+    SHOW_STR(remote);
+    SHOW=
_STR(remote_port);
+    SHOW_BOOL(remote_float);
+    SHOW_BOOL(bind_define=
d);
+    SHOW_BOOL(bind_local);
+    SHOW_BOOL(bind_ipv6_only);
+    SHOW_I=
NT(connect_retry_seconds);
+    SHOW_INT(connect_timeout);
+
+    if (o->ht=
tp_proxy_options)
+    {
+        show_http_proxy_options(o->http_proxy_opt=
ions);
+    }
+    SHOW_STR(socks_proxy_server);
+    SHOW_STR(socks_proxy_=
port);
+    SHOW_INT(tun_mtu);
+    SHOW_BOOL(tun_mtu_defined);
+    SHOW_I=
NT(link_mtu);
+    SHOW_BOOL(link_mtu_defined);
+    SHOW_INT(tun_mtu_extra=
);
+    SHOW_BOOL(tun_mtu_extra_defined);
+    SHOW_INT(tls_mtu);
+
+    SH=
OW_INT(mtu_discover_type);
+
+#ifdef ENABLE_FRAGMENT
+    SHOW_INT(fragment=
);
+#endif
+    SHOW_INT(mssfix);
+    SHOW_BOOL(mssfix_encap);
+    SHOW_B=
OOL(mssfix_fixed);
+
+    SHOW_INT(explicit_exit_notification);
+
+    SHOW=
_STR_INLINE(tls_auth_file);
+    SHOW_PARM(key_direction, keydirection2asci=
i(o->key_direction, false, true), "%s");
+    SHOW_STR_INLINE(tls_crypt_fil=
e);
+    SHOW_STR_INLINE(tls_crypt_v2_file);
+}
+
+
+static void
+show_conn=
ection_entries(const struct options *o)
+{
+    if (o->connection_list)
+  =
  {
+        const struct connection_list *l =3D o->connection_list;
+     =
   int i;
+        for (i =3D 0; i < l->len; ++i)
+        {
+            m=
sg(D_SHOW_PARMS, "Connection profiles [%d]:", i);
+            show_connect=
ion_entry(l->array[i]);
+        }
+    }
+    else
+    {
+        msg(D_S=
HOW_PARMS, "Connection profiles [default]:");
+        show_connection_entr=
y(&o->ce);
+    }
+    msg(D_SHOW_PARMS, "Connection profiles END");
+}
+
+=
static void
+show_pull_filter_list(const struct pull_filter_list *l)
+{
+  =
  struct pull_filter *f;
+    if (!l)
+    {
+        return;
+    }
+
+   =
 msg(D_SHOW_PARMS, "  Pull filters:");
+    for (f =3D l->head; f; f =3D f-=
>next)
+    {
+        msg(D_SHOW_PARMS, "    %s \"%s\"", pull_filter_type_=
name(f->type), f->pattern);
+    }
+}
+
+void
+show_settings(const struct o=
ptions *o)
+{
+    msg(D_SHOW_PARMS, "Current Parameter Settings:");
+
+   =
 SHOW_STR(config);
+
+    SHOW_INT(mode);
+
+#ifdef ENABLE_FEATURE_TUN_PERS=
IST
+    SHOW_BOOL(persist_config);
+    SHOW_INT(persist_mode);
+#endif
+
=
+    SHOW_BOOL(show_ciphers);
+    SHOW_BOOL(show_digests);
+    SHOW_BOOL(=
show_engines);
+    SHOW_BOOL(genkey);
+    SHOW_STR(genkey_filename);
+   =
 SHOW_STR(key_pass_file);
+    SHOW_BOOL(show_tls_ciphers);
+
+    SHOW_INT=
(connect_retry_max);
+    show_connection_entries(o);
+
+    SHOW_BOOL(remo=
te_random);
+
+    SHOW_STR(ipchange);
+    SHOW_STR(dev);
+    SHOW_STR(de=
v_type);
+    SHOW_STR(dev_node);
+#if defined(ENABLE_DCO)
+    SHOW_BOOL(d=
isable_dco);
+#endif
+    SHOW_STR(lladdr);
+    SHOW_INT(topology);
+    S=
HOW_STR(ifconfig_local);
+    SHOW_STR(ifconfig_remote_netmask);
+    SHOW_=
BOOL(ifconfig_noexec);
+    SHOW_BOOL(ifconfig_nowarn);
+    SHOW_STR(ifcon=
fig_ipv6_local);
+    SHOW_INT(ifconfig_ipv6_netbits);
+    SHOW_STR(ifconf=
ig_ipv6_remote);
+
+    SHOW_INT(shaper);
+    SHOW_INT(mtu_test);
+
+    S=
HOW_BOOL(mlock);
+
+    SHOW_INT(keepalive_ping);
+    SHOW_INT(keepalive_t=
imeout);
+    SHOW_INT(inactivity_timeout);
+    SHOW_INT(session_timeout);=

+    SHOW_INT64(inactivity_minimum_bytes);
+    SHOW_INT(ping_send_timeout=
);
+    SHOW_INT(ping_rec_timeout);
+    SHOW_INT(ping_rec_timeout_action);=

+    SHOW_BOOL(ping_timer_remote);
+    SHOW_INT(remap_sigusr1);
+    SHOW=
_BOOL(persist_tun);
+    SHOW_BOOL(persist_local_ip);
+    SHOW_BOOL(persis=
t_remote_ip);
+
+#if PASSTOS_CAPABILITY
+    SHOW_BOOL(passtos);
+#endif
+
=
+    SHOW_INT(resolve_retry_seconds);
+    SHOW_BOOL(resolve_in_advance);
+=

+    SHOW_STR(username);
+    SHOW_STR(groupname);
+    SHOW_STR(chroot_di=
r);
+    SHOW_STR(cd_dir);
+#ifdef ENABLE_SELINUX
+    SHOW_STR(selinux_con=
text);
+#endif
+    SHOW_STR(writepid);
+    SHOW_STR(up_script);
+    SHOW=
_STR(down_script);
+    SHOW_BOOL(down_pre);
+    SHOW_BOOL(up_restart);
+ =
   SHOW_BOOL(up_delay);
+    SHOW_BOOL(daemon);
+    SHOW_BOOL(log);
+    S=
HOW_BOOL(suppress_timestamps);
+    SHOW_BOOL(machine_readable_output);
+  =
  SHOW_INT(nice);
+    SHOW_INT(verbosity);
+    SHOW_INT(mute);
+#ifdef EN=
ABLE_DEBUG
+    SHOW_INT(gremlin);
+#endif
+    SHOW_STR(status_file);
+   =
 SHOW_INT(status_file_version);
+    SHOW_INT(status_file_update_freq);
+
+=
    SHOW_BOOL(occ);
+    SHOW_INT(rcvbuf);
+    SHOW_INT(sndbuf);
+#if defi=
ned(TARGET_LINUX)
+    SHOW_INT(mark);
+#endif
+    SHOW_INT(sockflags);
+
=
+    SHOW_INT(comp=2Ealg);
+    SHOW_INT(comp=2Eflags);
+
+    SHOW_STR(rou=
te_script);
+    SHOW_STR(route_default_gateway);
+    SHOW_INT(route_defau=
lt_metric);
+    SHOW_INT(route_default_table_id);
+    SHOW_BOOL(route_noe=
xec);
+    SHOW_INT(route_delay);
+    SHOW_INT(route_delay_window);
+    S=
HOW_BOOL(route_delay_defined);
+    SHOW_BOOL(route_nopull);
+    SHOW_BOOL=
(route_gateway_via_dhcp);
+    SHOW_BOOL(allow_pull_fqdn);
+    show_pull_f=
ilter_list(o->pull_filter_list);
+
+    if (o->routes)
+    {
+        prin=
t_route_options(o->routes, D_SHOW_PARMS);
+    }
+
+    if (o->client_nat)
=
+    {
+        print_client_nat_list(o->client_nat, D_SHOW_PARMS);
+    }
=
+
+    show_dns_options(&o->dns_options);
+
+#ifdef ENABLE_MANAGEMENT
+    =
SHOW_STR(management_addr);
+    SHOW_STR(management_port);
+    SHOW_STR(ma=
nagement_user_pass);
+    SHOW_INT(management_log_history_cache);
+    SHOW=
_INT(management_echo_buffer_size);
+    SHOW_STR(management_client_user);
+=
    SHOW_STR(management_client_group);
+    SHOW_INT(management_flags);
+#e=
ndif
+#ifdef ENABLE_PLUGIN
+    if (o->plugin_list)
+    {
+        plugin_=
option_list_print(o->plugin_list, D_SHOW_PARMS);
+    }
+#endif
+
+    SHOW=
_STR_INLINE(shared_secret_file);
+    SHOW_PARM(key_direction, keydirection=
2ascii(o->key_direction, false, true), "%s");
+    SHOW_STR(ciphername);
+ =
   SHOW_STR(ncp_ciphers);
+    SHOW_STR(authname);
+#ifndef ENABLE_CRYPTO_M=
BEDTLS
+    SHOW_BOOL(engine);
+#endif /* ENABLE_CRYPTO_MBEDTLS */
+    SHO=
W_BOOL(mute_replay_warnings);
+    SHOW_INT(replay_window);
+    SHOW_INT(r=
eplay_time);
+    SHOW_STR(packet_id_file);
+    SHOW_BOOL(test_crypto);
+
=
+    SHOW_BOOL(tls_server);
+    SHOW_BOOL(tls_client);
+    SHOW_STR_INLIN=
E(ca_file);
+    SHOW_STR(ca_path);
+    SHOW_STR_INLINE(dh_file);
+    if =
((o->management_flags & MF_EXTERNAL_CERT))
+    {
+        SHOW_PARM("cert_=
file", "EXTERNAL_CERT", "%s");
+    }
+    else
+    {
+        SHOW_STR_IN=
LINE(cert_file);
+    }
+    SHOW_STR_INLINE(extra_certs_file);
+
+    if (=
(o->management_flags & MF_EXTERNAL_KEY))
+    {
+        SHOW_PARM("priv_ke=
y_file", "EXTERNAL_PRIVATE_KEY", "%s");
+    }
+    else
+    {
+        SH=
OW_STR_INLINE(priv_key_file);
+    }
+#ifndef ENABLE_CRYPTO_MBEDTLS
+    SH=
OW_STR_INLINE(pkcs12_file);
+#endif
+#ifdef ENABLE_CRYPTOAPI
+    SHOW_STR(=
cryptoapi_cert);
+#endif
+    SHOW_STR(cipher_list);
+    SHOW_STR(cipher_l=
ist_tls13);
+    SHOW_STR(tls_cert_profile);
+    SHOW_STR(tls_verify);
+  =
  SHOW_STR(tls_export_peer_cert_dir);
+    SHOW_INT(verify_x509_type);
+   =
 SHOW_STR(verify_x509_name);
+    SHOW_STR_INLINE(crl_file);
+    SHOW_INT(=
ns_cert_type);
+    {
+        int i;
+        for (i =3D 0; i < MAX_PARMS;=
 i++)
+        {
+            SHOW_INT(remote_cert_ku[i]);
+        }
+    =
}
+    SHOW_STR(remote_cert_eku);
+    if (o->verify_hash)
+    {
+        =
SHOW_INT(verify_hash_algo);
+        SHOW_INT(verify_hash_depth);
+        =
struct gc_arena gc =3D gc_new();
+        const struct verify_hash_list *hl=
 =3D o->verify_hash;
+        int digest_len =3D
+            (o->verify_ha=
sh_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGEST_LENGTH;
+      =
  while (hl)
+        {
+            char *s =3D format_hex_ex(hl->hash, di=
gest_len, 0, 1, ":", &gc);
+            SHOW_PARM(verify_hash, s, "%s");
+ =
           hl =3D hl->next;
+        }
+        gc_free(&gc);
+    }
+    S=
HOW_INT(ssl_flags);
+
+    SHOW_INT(tls_timeout);
+
+    SHOW_INT64(renegot=
iate_bytes);
+    SHOW_INT64(renegotiate_packets);
+    SHOW_INT(renegotiat=
e_seconds);
+
+    SHOW_INT(handshake_window);
+    SHOW_INT(transition_win=
dow);
+
+    SHOW_BOOL(single_session);
+    SHOW_BOOL(push_peer_info);
+  =
  SHOW_BOOL(tls_exit);
+
+    SHOW_STR(tls_crypt_v2_metadata);
+
+#ifdef EN=
ABLE_PKCS11
+    {
+        int i;
+        for (i =3D 0; i < MAX_PARMS && =
o->pkcs11_providers[i] !=3D NULL; i++)
+        {
+            SHOW_PARM(pk=
cs11_providers, o->pkcs11_providers[i], "%s");
+        }
+    }
+    {
+  =
      int i;
+        for (i =3D 0; i < MAX_PARMS; i++)
+        {
+       =
     SHOW_PARM(pkcs11_protected_authentication,
+                      o->p=
kcs11_protected_authentication[i] ? "ENABLED" : "DISABLED", "%s");
+       =
 }
+    }
+    {
+        int i;
+        for (i =3D 0; i < MAX_PARMS; i++)=

+        {
+            SHOW_PARM(pkcs11_private_mode, o->pkcs11_private_m=
ode[i], "%08x");
+        }
+    }
+    {
+        int i;
+        for (i =
=3D 0; i < MAX_PARMS; i++)
+        {
+            SHOW_PARM(pkcs11_cert_pr=
ivate, o->pkcs11_cert_private[i] ? "ENABLED" : "DISABLED",
+               =
       "%s");
+        }
+    }
+    SHOW_INT(pkcs11_pin_cache_period);
+  =
  SHOW_STR(pkcs11_id);
+    SHOW_BOOL(pkcs11_id_management);
+#endif /* ENA=
BLE_PKCS11 */
+
+    show_p2mp_parms(o);
+
+#ifdef _WIN32
+    SHOW_BOOL(sh=
ow_net_up);
+    SHOW_INT(route_method);
+    SHOW_BOOL(block_outside_dns);=

+    show_tuntap_options(&o->tuntap_options);
+#endif
+}
+
+#endif /* ifnd=
ef ENABLE_SMALL */
diff --git a/src/openvpn/options_show=2Eh b/src/openvpn/=
options_show=2Eh
new file mode 100644
index 0000000=2E=2Efb233fc
--- /dev/n=
ull
+++ b/src/openvpn/options_show=2Eh
@@ -0,0 +1,46 @@
+/*
+ *  OpenVPN --=
 An application to securely tunnel IP networks
+ *             over a singl=
e UDP port, with support for SSL/TLS-based
+ *             session authenti=
cation and key exchange,
+ *             packet encryption, packet authenti=
cation, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 20=
02-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free sof=
tware; you can redistribute it and/or modify
+ *  it under the terms of the=
 GNU General Public License version 2
+ *  as published by the Free Softwar=
e Foundation=2E
+ *
+ *  This program is distributed in the hope that it wi=
ll be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=

+ *  GNU General Public License for more details=2E
+ *
+ *  You should ha=
ve received a copy of the GNU General Public License along
+ *  with this p=
rogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef =
OPTIONS_SHOW_H
+#define OPTIONS_SHOW_H
+
+#ifdef HAVE_CONFIG_H
+#include "c=
onfig=2Eh"
+#endif
+
+#include "options=2Eh"
+
+#ifdef ENABLE_SMALL
+
+stat=
ic inline void
+show_settings(const struct options *o)
+{
+    (void)o;
+}
=
+
+#else
+
+void show_settings(const struct options *o);
+
+#endif /* ENABL=
E_SMALL */
+
+#endif /* OPTIONS_SHOW_H */

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
Gerrit-C=
hange-Number: 1772
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--0bcWYNmHA98=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">options: Factor out opti=
ons display code from options=2Ec<br><br>options=2Ec is a huge, unwieldly f=
ile=2E So remove some<br>closely related code that has no direct dependenci=
es<br>with the other functions in the file=2E<br><br>In this case it is the=
 code that prints out the current<br>configuration=2E<br><br>Change-Id: I61=
762374c141662d596bbf88b64ca7f7472b5149<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
772<br>Message-Id: &lt;20260817161852=2E8376-1-gert@greenie=2Emuc=2Ede&gt;<=
br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38466=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M=
 src/openvpn/openvpn=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/opti=
ons=2Eh<br>A src/openvpn/options_show=2Ec<br>A src/openvpn/options_show=2Eh=
<br>7 files changed, 683 insertions(+), 620 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/7=
2/1772/5</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br=
><span>index aae264e=2E=2E4eda75b 100644</span><br><span>--- a/CMakeLists=
=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -529,6 +52=
9,8 @@</span><br><span>     src/openvpn/options_util=2Ec</span><br><span>  =
   src/openvpn/options_util=2Eh</span><br><span>     src/openvpn/options_pa=
rse=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/open=
vpn/options_show=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    src/openvpn/options_show=2Eh</span><br><span>     src/openvpn/otime=2E=
c</span><br><span>     src/openvpn/otime=2Eh</span><br><span>     src/openv=
pn/ovpn_dco_win=2Eh</span><br><span>diff --git a/src/openvpn/Makefile=2Eam =
b/src/openvpn/Makefile=2Eam</span><br><span>index 1f77384=2E=2E2092e96 1006=
44</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/sr=
c/openvpn/Makefile=2Eam</span><br><span>@@ -108,6 +108,7 @@</span><br><span=
> 	pkcs11_mbedtls=2Ec \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</span><=
br><span> 	options=2Ec options=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	options_show=2Ec options_show=2Eh \</span><br><span> 	opt=
ions_util=2Ec options_util=2Eh \</span><br><span> 	options_parse=2Ec \</spa=
n><br><span> 	otime=2Ec otime=2Eh \</span><br><span>diff --git a/src/openvp=
n/openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>index f38660f=2E=2E=
7d35195 100644</span><br><span>--- a/src/openvpn/openvpn=2Ec</span><br><spa=
n>+++ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -30,6 +30,7 @@</span><br=
><span> #include &quot;forward=2Eh&quot;</span><br><span> #include &quot;mu=
lti=2Eh&quot;</span><br><span> #include &quot;win32=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_show=2Eh&q=
uot;</span><br><span> #include &quot;platform=2Eh&quot;</span><br><span> #i=
nclude &quot;string=2Eh&quot;</span><br><span> </span><br><span>diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 4=
aebfea=2E=2Ee899fa6 100644</span><br><span>--- a/src/openvpn/options=2Ec</s=
pan><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -914,41 +914=
,6 @@</span><br><span>     gc_free(&amp;o-&gt;dns_options=2Egc);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pull_filter_type_na=
me(int type)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (type =3D=3D PUF_TYPE_=
ACCEPT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return &quot;accept&qu=
ot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (type =3D=3D PUF_TYPE_IGNO=
RE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return &quot;ignore&quot;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (type =3D=3D PUF_TYPE_REJECT)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return &quot;reject&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return &quot;???&quot;;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define SHOW_PARM(name, value, format) msg=
(D_SHOW_PARMS, &quot;  &quot; #name &quot; =3D &quot; format, (value))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_STR(var)     =
             SHOW_PARM(var, (o-&gt;var ? o-&gt;var : &quot;[UNDEF]&quot;), =
&quot;&#39;%s&#39;&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define SHOW_STR_INLINE(var) \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SHOW_PARM(var, o-&gt;var##_inline ? &quot;[INLINE]&quot; :=
 (o-&gt;var ? o-&gt;var : &quot;[UNDEF]&quot;), &quot;&#39;%s&#39;&quot;)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_INT(var)  =
    SHOW_PARM(var, o-&gt;var, &quot;%d&quot;)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define SHOW_UINT(var)     SHOW_PARM(var, o-&gt;var=
, &quot;%u&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine SHOW_INT64(var)    SHOW_PARM(var, o-&gt;var, &quot;%&quot; PRIi64)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHOW_UNSIGNED(var)=
 SHOW_PARM(var, o-&gt;var, &quot;0x%08x&quot;)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define SHOW_BOOL(var)     SHOW_PARM(var, (o-&gt;v=
ar ? &quot;ENABLED&quot; : &quot;DISABLED&quot;), &quot;%s&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif /* ifndef ENABLE_SMALL */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br>=
<span> setenv_connection_entry(struct env_set *es, const struct connection_=
entry *e, const int i)</span><br><span> {</span><br><span>@@ -1240,55 +1205=
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
@ -1331,116 +1247,6 @@</span><br><span>     }</span><br><span> }</span><br>=
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
an><br><span>               msglvl_t msglevel)</span><br><span>@@ -1485,37 =
+1291,6 @@</span><br><span>     o-&gt;iroutes_ipv6 =3D ir;</span><br><span>=
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
<br><span> {</span><br><span>@@ -1563,399 +1338,6 @@</span><br><span>     }=
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
span style=3D"color: hsl(0, 100%, 40%);">-        struct verify_hash_list *=
hl =3D o-&gt;verify_hash;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        int digest_len =3D</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            (o-&gt;verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_L=
ENGTH : SHA256_DIGEST_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        while (hl)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     char *s =3D format_hex_ex(hl-&gt;hash, digest_len, 0, 1, &quot;:&quot;=
, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  SHOW_PARM(verify_hash, s, &quot;%s&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            hl =3D hl-&gt;next;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SHOW_INT(ssl_flags);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_=
INT(tls_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT64(renegotiat=
e_bytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT=
64(renegotiate_packets);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_INT(renegotiate_seconds);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_INT(handshake_window);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_INT(transition_window);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_BOOL(single_session);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SHOW_BOOL(push_peer_info);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SHOW_BOOL(tls_exit);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_STR(tls_crypt_v2_metadata);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENAB=
LE_PKCS11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; MAX_PA=
RMS &amp;&amp; o-&gt;pkcs11_providers[i] !=3D NULL; i++)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            SHOW_PARM(pkcs11_providers, o-&gt;pkcs11=
_providers[i], &quot;%s&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; MAX_PARMS; i=
++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            SHOW_PARM(pkcs11_p=
rotected_authentication,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                      o-&gt;pkcs11_protected_authentication[i] ? &quot;E=
NABLED&quot; : &quot;DISABLED&quot;, &quot;%s&quot;);</span><br><span style=
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
br><span>index 0000000=2E=2Eff090774</span><br><span>--- /dev/null</span><b=
r><span>+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ -0,0 +1,633 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to se=
curely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             over a single UDP port, with support for SSL/TLS-based=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is free software; you can redistribute it an=
d/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it u=
nder the terms of the GNU General Public License version 2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Softwar=
e Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is d=
istributed in the hope that it will be useful,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licen=
se for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef H=
AVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;options_show=2Eh&quot;</span><br><sp=
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
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--0bcWYNmHA98=--


--===============4988315684476071731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4988315684476071731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4988315684476071731==--

