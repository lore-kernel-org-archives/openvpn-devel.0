Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924AECCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EuLkIEBlgkdwiasUf7jyJXd71MOd8Zj9JsLXX8k8a+I=; b=S+WDRc3gTRiW4WKOn2ddcrLbrO
	wNJwTwSrtLrVHBmynRmZc4ib2HMCVg4pNEFcCiwO/yMkSY0fepCpcx4/4cc8wRhxU0BgOc2GgXsu+
	EBq4wcQeb2vmIBgS7j1Mw0APlt5OoVjECIlw3OKCcC+QhtdKA27LBuLTO1y6ZZJN+3nI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQVN-0006Y3-1Z;
	Sun, 18 Oct 2026 13:00:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQVL-0006Xr-3A
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7moU4DTqiMZY80ux8zclv8nUCUcVblKIvjtlIRuCbGk=; b=en3/ZIyAZugHLQaOodX1hda8rx
 du+JfxSaTGw0TwsBm/xVvMx8+73mAVV87JJlcVOsR0cSKmAfgfjdt/mN0fMYEZfHWXjd3V+DUpBLJ
 HUDd3zWjlJXBWy9a8SEtT9RcSA7H18qAHCwIQ3hzNhoq9uvsJbQJjvugFQuzg3v12xoA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7moU4DTqiMZY80ux8zclv8nUCUcVblKIvjtlIRuCbGk=; b=d
 GVb4IDEgXfrKO5LsH+0fsySNYEHoc7NJeWzKRaewBDhFmyMo1/yAVN4JDqmayUFkkaew4jwAS98rP
 SixOn72XAtrtD8cTYg/uwF4lTVVxaLEtKgU0LHhovUxBJokkReX2i4NRu/zdgFJZefEn7UgyCDGY4
 iDJ/dE2fhXVg8auA=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQVG-0006Tg-GU for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:00:47 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so16113355e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792328436; x=1792933236; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7moU4DTqiMZY80ux8zclv8nUCUcVblKIvjtlIRuCbGk=;
 b=cxacLfMdcFKZo5efDltY3BJUpTAQT99dxQGs/LuU2DcCx6aJJrFFmF6DxoDOmAj2sG
 8J8T3aw8rmTP14CEEdfzPh6h2CY6snWJ2Mp42/U7WOAAbKWo0vQe7T17WkeUD+q66K7n
 1B+QgDl3Ii1GHuDptMmTaM6U/MeN4FoiuaRHoHYakQL2kzFNgwbS4XqeRKPVRlGgxyL+
 7YmHHSsZE0CXBVMc+5i588M+zliWUmij9cleP/ferDol64quZtz/xedd4own+5lj3+UK
 G+UAUxykZbg6rANXV71HnShdc4GgvHS3BU29rsqWa24WKAP2BEkaSf//G7cYYm0TAdW6
 7NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792328436; x=1792933236;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7moU4DTqiMZY80ux8zclv8nUCUcVblKIvjtlIRuCbGk=;
 b=c5beNWA1EhqfHEj2Kha/TkJMTeyGYJ7xwSpkdyn/+6VCjGSFVRcZjuvTZNyw06nB2M
 5dkW+nMVaRW/VLzx7Du+7qrzt+8GnYEqqa1l6/st6iodXYD7kGS0w27QSifz3feBfav6
 LsNlO3M3CPEjEvwK6f70zP9ZsetkZovKMKv51iM0YRxly786ozbHklfDmiviP6FMh3PV
 jkZarGK+xcro4HhgOCn6gP6Uv8NI4CUwCZleNF3Jyh9qbiBo/jgg7zpQLDRQ69mJEZhE
 PGdRpJJp7WJgLPf4s7JfkHFQc81pSCQM09q66u6cG/4ZEfmzQy6mQmYeTl1wfrtgRyzG
 79SQ==
X-Gm-Message-State: AFq9FYLiJBc+LIxKtVl/LywDqTI0mWfQNSboWFDn01IwQjBEPpDdg9SW
 uuXIiWXwx0JsHv6lwfnMgcNp+9CjLgnreG76zbkJZVq7rIZqxMEPoRWLcim/xf3uc2IyH5izOqQ
 0LgtNHpq2ve3L5A3Gn1wrGByFVf36OHLenV7/HI8xUjueOhIFYoN6XoGzvp7jYKoIaYDL
X-Gm-Gg: AYBFou1E+3PBHhk20Lut60KV2rx3arD47QBmHL51QsQcsw5nDK8MHigwFOLfNd5kS7V
 yn9UMBb5e3uKBE6Xc36WjF7C7ClqGDrj+PbmV4zhaEwq73dHlKuVaM0hGJvyWgilOX38n2RvrKL
 oJSqkjrCHQkfAGdXRBn5WA0U7BXtrxHX5noj02G6z9c8fgUyCSjw3QxWu8keli4/ObqVPT2x7Si
 aREqxjgFbqLG+4jozBgYScoLGjoHK8v4PeFVPNRSl6v2ILDt14yqYnI+ZnIOufbfbORaxPxw9/u
 TXYBpEhkDW9FXfUelsv/ny5SXDioOhXxYmjX/Rp0GlA9fNDu4yTgwCFZf5kY+rHMv8bJE634VWb
 0AYeyCkOxqL7zwBh1sH7e6MPUsP3g1BNXtfvWATR2tVdHb/BTMZ6+9HspFsnWMfD0Ay/ySLf2z9
 eeASA/WCamy03hgGUXKw7ca2ULhaDGIbFF0DwdHHf0DnEqjOr284bd3c44appDjZiSj21YOhmCk
 a+sW2qb/9fvFR3Glmc/npL1r5yGh8Mp4QKT6FjMaXPEl/vMSSKRyg7L0xXHs1qPW9e4V0Nux9gq
 mENvnPL/+wl0NdWpkgc60V1Ghl0JrVGeAxM78xFhY1ioo2i968gMGnn2ixFO
X-Received: by 2002:a05:600c:34cc:b0:4a1:dec1:4e1 with SMTP id
 5b1f17b1804b1-4a1dec1097amr73102305e9.22.1792328435456; 
 Sun, 18 Oct 2026 06:00:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b8ebdsm326041555e9.10.2026.10.18.06.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:00:34 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:00:33 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
X-Gerrit-Change-Number: 1995
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1995?usp=email>
X-Gerrit-Commit: 670cc976b2cd497983fdb584a20bd8d1942fadfd
In-Reply-To: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
References: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkliMWI0YTk1NDRlMDk1MDZlOTUwMDE2MDkyNjIyNjlhYjgxNTQyNDFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9ae72788d01fa38328eada979a07c2ee2a635a08-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQVG-0006Tg-GU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strncpynt
 with strlcpy
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8074174010021742111=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8074174010021742111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wuYcml/YjWY="; charset=UTF-8

--wuYcml/YjWY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
995?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Gert Doering


Change subject: Replace strncpynt with strlc=
py
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace st=
rncpynt with strlcpy

Mostly a straight-forward replacement=2E But in a few=

places I used the additional return code from strlcpy
instead of duplicati=
ng the strlen call=2E

Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e=

Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1995
Message-Id: <20261017165735=2E14540-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg39944=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/auth_token=2Ec
M src/openvpn/buffer=2Ec
M src/open=
vpn/buffer=2Eh
M src/openvpn/dns=2Ec
M src/openvpn/init=2Ec
M src/openvpn/m=
anage=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/netw=
orking_sitnl=2Ec
M src/openvpn/openssl_compat=2Eh
M src/openvpn/options_str=
ing=2Ec
M src/openvpn/pkcs11=2Ec
M src/openvpn/route=2Ec
M src/openvpn/sock=
et=2Ec
M src/openvpn/socks=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_open=
ssl=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M=
 src/openvpn/tun=2Ec
M src/openvpn/xkey_helper=2Ec
M tests/unit_tests/openv=
pn/test_auth_token=2Ec
M tests/unit_tests/openvpn/test_pkcs11=2Ec
M tests/u=
nit_tests/openvpn/test_user_pass=2Ec
24 files changed, 63 insertions(+), 86=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/95/1995/3

diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/au=
th_token=2Ec
index b457b6f=2E=2E969f37f 100644
--- a/src/openvpn/auth_token=
=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -464,7 +464,7 @@
 
     struct use=
r_pass up;
     CLEAR(up);
-    strncpynt(up=2Eusername, multi->locked_user=
name, sizeof(up=2Eusername));
+    strlcpy(up=2Eusername, multi->locked_use=
rname, sizeof(up=2Eusername));
 
     generate_auth_token(&up, multi);
 
di=
ff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index a90ddae=2E=
=2Ecc1b300 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec=

@@ -257,9 +257,8 @@
     int cap =3D buf_forward_capacity(buf);
     if (c=
ap > 0)
     {
-        strncpynt((char *)ptr, str, cap);
-        *(buf->d=
ata + buf->capacity - 1) =3D 0; /* windows vsnprintf needs this */
-       =
 buf->len +=3D (int)strlen((char *)ptr);
+        int str_len =3D (int)strl=
cpy((char *)ptr, str, cap);
+        buf->len +=3D (str_len < cap) ? str_le=
n : cap - 1;
         ret =3D true;
     }
     return ret;
diff --git a/sr=
c/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 063a2d4=2E=2E74e166c 10=
0644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -696,27 +=
696,6 @@
 }
 
 /**
- * Like \c strncpy() but always null-terminates the des=
tination=2E
- *
- * Copies at most \c maxlen - 1 characters from \c src int=
o \c dest and
- * writes a null terminator at \c dest[\c maxlen - 1]=2E  Do=
es nothing if
- * \c maxlen is zero=2E
- *
- * @param dest    Destination b=
uffer=2E
- * @param src     Source string=2E
- * @param maxlen  Size of the=
 destination buffer in bytes=2E
- */
-static inline void
-strncpynt(char *d=
est, const char *src, size_t maxlen)
-{
-    if (maxlen > 0)
-    {
-      =
  strncpy(dest, src, maxlen - 1);
-        dest[maxlen - 1] =3D 0;
-    }
-=
}
-
-/**
  * Return true if the string contains at least one decimal digit=
=2E
  *
  * @param src   The null-terminated string to scan=2E
diff --git a=
/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 713f41e=2E=2E87c9c5f 10064=
4
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -444,7 +444,7 @@
 =
        =2Eiface =3D { =2Eindex =3D tt->adapter_index, =2Ename =3D "" },
  =
       =2Eflags =3D server->dnssec =3D=3D DNS_SECURITY_YES ? nrpt_dnssec : =
0,
     };
-    strncpynt(nrpt=2Eiface=2Ename, tt->actual_name, sizeof(nrpt=
=2Eiface=2Ename));
+    strlcpy(nrpt=2Eiface=2Ename, tt->actual_name, sizeo=
f(nrpt=2Eiface=2Ename));
 
     for (size_t i =3D 0; i < NRPT_ADDR_NUM; ++i=
)
     {
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 3c2=
ebf9=2E=2Ed8fd844 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=
=2Ec
@@ -393,8 +393,8 @@
                     ALLOC_OBJ_CLEAR_GC(rhs, struc=
t remote_host_store, &c->options=2Egc);
                     c->options=2Er=
h_store =3D rhs;
                 }
-                strncpynt(rhs->host, p=
[2], RH_HOST_LEN);
-                strncpynt(rhs->port, p[3], RH_PORT_LEN)=
;
+                strlcpy(rhs->host, p[2], RH_HOST_LEN);
+                =
strlcpy(rhs->port, p[3], RH_PORT_LEN);
 
                 ce->remote =3D rh=
s->host;
                 ce->remote_port =3D rhs->port;
diff --git a/src/o=
penvpn/manage=2Ec b/src/openvpn/manage=2Ec
index e15d7bd=2E=2E007dd2a 10064=
4
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -784,7 +784,=
7 @@
         ASSERT(man->connection=2Eup_query_type);
         if (streq(m=
an->connection=2Eup_query_type, type))
         {
-            strncpynt(de=
st, string, len);
+            strlcpy(dest, string, len);
             man=
_up_finalize(man);
             msg(M_CLIENT, "SUCCESS: '%s' %s entered, bu=
t not yet verified", type, prompt);
         }
@@ -2374,7 +2374,7 @@
     }=

     struct user_pass up;
     CLEAR(up);
-    strncpynt(up=2Eusername, ms=
g, sizeof(up=2Eusername));
+    strlcpy(up=2Eusername, msg, sizeof(up=2Euse=
rname));
 
     management_query_user_pass(management, &up, command, GET_US=
ER_PASS_NEED_OK, (void *)0);
     return strcmp("ok", up=2Epassword) =3D=3D=
 0;
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index 0e4669a=
=2E=2Ea75bd8f 100644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
=
@@ -303,7 +303,7 @@
 
                 if (password_buf[0])
               =
  {
-                    strncpynt(up->password, password_buf, USER_PASS_LE=
N);
+                    strlcpy(up->password, password_buf, USER_PASS_LEN)=
;
                 }
                 else
                 {
@@ -364,7 +36=
4,7 @@
                     {
                         msg(M_FATAL, "ERROR:=
 could not read challenge response from stdin");
                     }
-  =
                  strncpynt(up->username, ac->user, USER_PASS_LEN);
+      =
              strlcpy(up->username, ac->user, USER_PASS_LEN);
             =
        buf_printf(&packed_resp, "CRV1::%s::%s", ac->state_id, response);
 =
                }
                 else
@@ -452,7 +452,7 @@
         /* Use=
 tag for blank password if we are not prompting for one */
         if (fla=
gs & GET_USER_PASS_USERNAME_ONLY)
         {
-            strncpynt(up->pas=
sword, blank_up, sizeof(up->password));
+            strlcpy(up->password, =
blank_up, sizeof(up->password));
         }
 
         string_mod(up->usern=
ame, CC_PRINT, CC_CRLF, 0);
@@ -504,7 +504,7 @@
     if (strlen(token))
   =
  {
         unprotect_user_pass(tk);
-        strncpynt(tk->password, toke=
n, USER_PASS_LEN);
+        strlcpy(tk->password, token, USER_PASS_LEN);
  =
       tk->token_defined =3D true;
 
         /*
diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec
index a2cfdbf=2E=2Ee302a81 100644
--- a/sr=
c/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -461,7 +461,7 @@
     co=
nst char *prefix =3D multi_instance_string(mi, true, &gc);
     if (prefix)=

     {
-        strncpynt(mi->msg_prefix, prefix, sizeof(mi->msg_prefix));=

+        strlcpy(mi->msg_prefix, prefix, sizeof(mi->msg_prefix));
     }
 =
    else
     {
@@ -2657,7 +2657,7 @@
         {
             struct user_p=
ass up;
             CLEAR(up);
-            strncpynt(up=2Eusername, multi=
->locked_username, sizeof(up=2Eusername));
+            strlcpy(up=2Euserna=
me, multi->locked_username, sizeof(up=2Eusername));
 
             generate=
_auth_token(&up, multi);
         }
diff --git a/src/openvpn/networking_sit=
nl=2Ec b/src/openvpn/networking_sitnl=2Ec
index f9596a5=2E=2Ebbdfcb7 100644=

--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=
=2Ec
@@ -602,7 +602,7 @@
 
     /* save result in output variables */
     =
memcpy(best_gw, &res=2Egw, res=2Eaddr_size);
-    strncpynt(best_iface, res=
=2Eiface, IFNAMSIZ);
+    strlcpy(best_iface, res=2Eiface, IFNAMSIZ);
 err:=

     return ret;
 }
@@ -1424,7 +1424,7 @@
             return -ENOENT;
   =
      }
 
-        strncpynt(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE=
_TYPE_LEN_MAX);
+        strlcpy(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), I=
FACE_TYPE_LEN_MAX);
     }
 
     return 0;
diff --git a/src/openvpn/openss=
l_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index 1a934db=2E=2E4305fea 10=
0644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=
=2Eh
@@ -104,10 +104,10 @@
         curve =3D "(error fetching curve name)"=
;
     }
 
-    strncpynt(gname, curve, gname_sz);
+    strlcpy(gname, curv=
e, gname_sz);
 
-    /* strncpynt ensures null termination so just strlen i=
s fine here */
-    *gname_len =3D strlen(curve);
+    /* strlcpy ensures n=
ull termination so just strlen is fine here */
+    *gname_len =3D strlen(g=
name);
     return 1;
 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L=
 && !defined(OPENSSL_NO_EC) */
diff --git a/src/openvpn/options_string=2Ec =
b/src/openvpn/options_string=2Ec
index 88ab798=2E=2Ecfc0595 100644
--- a/sr=
c/openvpn/options_string=2Ec
+++ b/src/openvpn/options_string=2Ec
@@ -385,9=
 +385,9 @@
 const char *
 options_string_version(const char *s, struct gc_a=
rena *gc)
 {
-    struct buffer out =3D alloc_buf_gc(4, gc);
-    strncpynt=
((char *)BPTR(&out), s, 3);
-    return BSTR(&out);
+    char *out =3D gc_m=
alloc(3, false, gc);
+    strlcpy(out, s, 3);
+    return out;
 }
 
 #if de=
fined(__GNUC__) || defined(__clang__)
diff --git a/src/openvpn/pkcs11=2Ec b=
/src/openvpn/pkcs11=2Ec
index d7dee97=2E=2E09c8996 100644
--- a/src/openvpn=
/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -224,7 +224,7 @@
     }
     el=
se
     {
-        strncpynt(pin, token_pass=2Epassword, pin_max);
+       =
 strlcpy(pin, token_pass=2Epassword, pin_max);
         purge_user_pass(&to=
ken_pass, true);
 
         if (strlen(pin) =3D=3D 0)
diff --git a/src/open=
vpn/route=2Ec b/src/openvpn/route=2Ec
index 9c80f3b=2E=2E8e93404 100644
---=
 a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2970,7 +2970,7 @@
=
 
     if (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
     {
-  =
      strncpynt(msg=2Eiface=2Ename, tt->actual_name, sizeof(msg=2Eiface=2En=
ame));
+        strlcpy(msg=2Eiface=2Ename, tt->actual_name, sizeof(msg=2Ei=
face=2Ename));
     }
 
     status =3D do_route_service(add, &msg, sizeof(=
msg), tt->options=2Emsg_channel);
@@ -3139,7 +3139,7 @@
                 ad=
dr =3D ntohl(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr=2Es_addr);
 
=
                 /* get interface name */
-                strncpynt(ifreq=
=2Eifr_name, ifr->ifr_name, sizeof(ifreq=2Eifr_name));
+                str=
lcpy(ifreq=2Eifr_name, ifr->ifr_name, sizeof(ifreq=2Eifr_name));
 
        =
         /* check that the interface is up */
                 if (ioctl(sd=
, SIOCGIFFLAGS, &ifreq) < 0)
@@ -3192,7 +3192,7 @@
                 }
 
   =
              /* save iface name */
-                strncpynt(rgi->iface, =
ifreq=2Eifr_name, sizeof(rgi->iface));
+                strlcpy(rgi->iface,=
 ifreq=2Eifr_name, sizeof(rgi->iface));
                 rgi->flags |=3D RG=
I_IFACE_DEFINED;
 
                 /* now get the hardware address=2E */
@=
@ -3460,7 +3460,7 @@
 
         CLEAR(ifr);
         ifr=2Eifr_addr=2Esa_fa=
mily =3D AF_INET;
-        strncpynt(ifr=2Eifr_name, rgi->iface, IFNAMSIZ);=

+        strlcpy(ifr=2Eifr_name, rgi->iface, IFNAMSIZ);
 
         if (ioc=
tl(sockfd, SIOCGIFNETMASK, (char *)&ifr) < 0)
         {
@@ -3489,7 +3489,7=
 @@
         struct ifreq ifreq =3D { 0 };
 
         /* now get the hardwa=
re address=2E */
-        strncpynt(ifreq=2Eifr_name, rgi->iface, sizeof(if=
req=2Eifr_name));
+        strlcpy(ifreq=2Eifr_name, rgi->iface, sizeof(ifr=
eq=2Eifr_name));
         if (ioctl(sockfd, SIOCGIFHWADDR, &ifreq) < 0)
   =
      {
             msg(M_WARN, "GDG: SIOCGIFHWADDR(%s) failed", ifreq=2Ei=
fr_name);
@@ -3748,7 +3748,7 @@
         {
             rgi->gateway=2Eaddr=
 =3D ntohl(((struct sockaddr_in *)route=2Egateway)->sin_addr=2Es_addr);
   =
          rgi->flags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
-           =
 strncpynt(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
+         =
   strlcpy(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
         }=

 
         int32 address_size =3D 0;
diff --git a/src/openvpn/socket=2Ec b=
/src/openvpn/socket=2Ec
index df8e400=2E=2Ef516a14 100644
--- a/src/openvpn=
/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -3077,7 +3077,7 @@
 sockaddr_un=
ix_init(struct sockaddr_un *local, const char *path)
 {
     local->sun_fam=
ily =3D PF_UNIX;
-    strncpynt(local->sun_path, path, sizeof(local->sun_pa=
th));
+    strlcpy(local->sun_path, path, sizeof(local->sun_path));
 }
 
 v=
oid
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index 029634=
9=2E=2Ecab9af6 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=
=2Ec
@@ -58,12 +58,12 @@
     ASSERT(server);
     ASSERT(port);
 
-    str=
ncpynt(p->server, server, sizeof(p->server));
+    strlcpy(p->server, serve=
r, sizeof(p->server));
     p->port =3D port;
 
     if (authfile)
     {
-=
        strncpynt(p->authfile, authfile, sizeof(p->authfile));
+        str=
lcpy(p->authfile, authfile, sizeof(p->authfile));
     }
     else
     {
d=
iff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 3594871=2E=2E49=
a9cb6 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -272,7 =
+272,7 @@
         /* prompt for password even if --askpass wasn't specifie=
d */
         pem_password_setup(NULL);
         ASSERT(!passbuf=2Eprotecte=
d);
-        strncpynt(buf, passbuf=2Epassword, (size_t)size);
+        str=
lcpy(buf, passbuf=2Epassword, (size_t)size);
         purge_user_pass(&pass=
buf, false);
 
         return (int)strlen(buf);
@@ -2230,7 +2230,7 @@
    =
     if (session->opt->pull && up !=3D &auth_token)
         {
            =
 unprotect_user_pass(&auth_token);
-            strncpynt(auth_token=2Euser=
name, up->username, USER_PASS_LEN);
+            strlcpy(auth_token=2Eusern=
ame, up->username, USER_PASS_LEN);
             protect_user_pass(&auth_tok=
en);
         }
         protect_user_pass(up);
diff --git a/src/openvpn/ss=
l_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index e0f34cd=2E=2Efe2bfda 1006=
44
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -=
427,15 +427,14 @@
      * historically used names with - in them=2E Silentl=
y convert names
      * with - to names with _ to support both
      */
-  =
  if (strlen(ciphers) >=3D (len - 1))
+    size_t ciphers_len =3D strlcpy(o=
penssl_ciphers, ciphers, len);
+    if (ciphers_len >=3D len)
     {
-     =
   msg(M_FATAL, "Failed to set restricted TLS 1=2E3 cipher list, too long (=
>%zd)=2E",
+        msg(M_FATAL, "Failed to set restricted TLS 1=2E3 cipher=
 list, too long (>%zu)=2E",
             len - 1);
     }
 
-    strncpynt(=
openssl_ciphers, ciphers, len);
-
-    for (size_t i =3D 0; i < strlen(open=
ssl_ciphers); i++)
+    for (size_t i =3D 0; i < ciphers_len; i++)
     {
 =
        if (openssl_ciphers[i] =3D=3D '-')
         {
diff --git a/src/open=
vpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index a744e07=2E=2E73e3696 =
100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@=
 -1640,7 +1640,7 @@
             "TLS: Replacing client provided username '=
%s' with "
             "username from override-user '%s'",
             up=
->username, multi->locked_username);
-        strncpynt(up->username, multi=
->locked_username, sizeof(up->username));
+        strlcpy(up->username, mu=
lti->locked_username, sizeof(up->username));
     }
 
     /*
diff --git a/=
src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
ind=
ex 6073e4e=2E=2E146a384 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++=
 b/src/openvpn/ssl_verify_openssl=2Ec
@@ -157,14 +157,16 @@
               =
      if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length(name->d=2Erfc822Name=
))
                     {
                         msg(D_TLS_ERRORS, "ASN1 =
ERROR: string contained terminating zero");
-                        OPENSS=
L_free(buf);
+                    }
+                    else if (strlcpy(o=
ut, buf, size) >=3D size)
+                    {
+                        m=
sg(D_TLS_ERRORS, "ASN1 ERROR: string too long");
                     }
   =
                  else
                     {
-                        strn=
cpynt(out, buf, size);
-                        OPENSSL_free(buf);
        =
                 retval =3D true;
                     }
+                 =
   OPENSSL_free(buf);
                     break;
 
                 defaul=
t:
@@ -243,9 +245,7 @@
         goto exit;
     }
 
-    strncpynt(out, (ch=
ar *)buf, size);
-
-    ret =3D (strlen((char *)buf) < size) ? SUCCESS : FA=
ILURE;
+    ret =3D (strlcpy(out, (char *)buf, size) < size) ? SUCCESS : FA=
ILURE;
 
 exit:
     OPENSSL_free(buf);
diff --git a/src/openvpn/tun=2Ec b/=
src/openvpn/tun=2Ec
index 2c2766f=2E=2Ea226fc4 100644
--- a/src/openvpn/tun=
=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -127,7 +127,7 @@
 
     if (addr=2Eiface=
=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
     {
-        strncpynt(addr=
=2Eiface=2Ename, tt->actual_name, sizeof(addr=2Eiface=2Ename));
+        st=
rlcpy(addr=2Eiface=2Ename, tt->actual_name, sizeof(addr=2Eiface=2Ename));
 =
    }
 
     if (addr=2Efamily =3D=3D AF_INET)
@@ -188,12 +188,12 @@
     }=
;
 
     /* interface name is required */
-    strncpynt(dns=2Eiface=2Ename=
, tt->actual_name, sizeof(dns=2Eiface=2Ename));
+    strlcpy(dns=2Eiface=2E=
name, tt->actual_name, sizeof(dns=2Eiface=2Ename));
 
     /* only use doma=
in when there are no search domains */
     if (o->domain && !o->domain_sea=
rch_list[0])
     {
-        strncpynt(dns=2Edomains, o->domain, sizeof(dns=
=2Edomains));
+        strlcpy(dns=2Edomains, o->domain, sizeof(dns=2Edomai=
ns));
     }
 
     /* Create a comma separated list of search domains */
@=
@ -260,7 +260,7 @@
                               =2Eaddr_len =3D addr_len =
};
 
     /* interface name is required */
-    strncpynt(dns=2Eiface=2Enam=
e, tt->actual_name, sizeof(dns=2Eiface=2Ename));
+    strlcpy(dns=2Eiface=
=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename));
 
     if (addr_len =
> _countof(dns=2Eaddr))
     {
@@ -324,7 +324,7 @@
                        =
         =2Eaddr_len =3D addr_len };
 
     /* interface name is required *=
/
-    strncpynt(wins=2Eiface=2Ename, tt->actual_name, sizeof(wins=2Eiface=
=2Ename));
+    strlcpy(wins=2Eiface=2Ename, tt->actual_name, sizeof(wins=
=2Eiface=2Ename));
 
     if (addr_len > _countof(wins=2Eaddr))
     {
@@ -=
372,7 +372,7 @@
                                   =2Eiface =3D { =2Eindex =
=3D tt->adapter_index },
                                   =2Emtu =3D mtu,=

                                   =2Efamily =3D family };
-    strncpynt(=
mtu_msg=2Eiface=2Ename, tt->actual_name, sizeof(mtu_msg=2Eiface=2Ename));
+=
    strlcpy(mtu_msg=2Eiface=2Ename, tt->actual_name, sizeof(mtu_msg=2Eiface=
=2Ename));
     if (family =3D=3D AF_INET6 && mtu < 1280)
     {
         m=
sg(M_INFO,
@@ -2121,7 +2121,7 @@
          */
         if (strcmp(dev, "tun=
") && strcmp(dev, "tap"))
         {
-            strncpynt(ifr=2Eifr_name,=
 dev, IFNAMSIZ);
+            strlcpy(ifr=2Eifr_name, dev, IFNAMSIZ);
     =
    }
 
         /*
@@ -2147,7 +2147,7 @@
             if ((ctl_fd =3D sock=
et(AF_INET, SOCK_DGRAM, 0)) >=3D 0)
             {
                 CLEAR(n=
etifr);
-                strncpynt(netifr=2Eifr_name, ifr=2Eifr_name, IFNAM=
SIZ);
+                strlcpy(netifr=2Eifr_name, ifr=2Eifr_name, IFNAMSIZ)=
;
                 netifr=2Eifr_qlen =3D tt->options=2Etxqueuelen;
        =
         if (ioctl(ctl_fd, SIOCSIFTXQLEN, (void *)&netifr) >=3D 0)
        =
         {
@@ -2403,7 +2403,7 @@
         {
             msg(M_ERR, "Can't =
get flags");
         }
-        strncpynt(ifr=2Elifr_name, tt->actual_name=
, sizeof(ifr=2Elifr_name));
+        strlcpy(ifr=2Elifr_name, tt->actual_na=
me, sizeof(ifr=2Elifr_name));
         ifr=2Elifr_ppa =3D ppa;
         /* =
Assign ppa according to the unit number returned by tun device */
         =
if (ioctl(if_fd, SIOCSLIFNAME, &ifr) < 0)
@@ -2471,7 +2471,7 @@
     }
 
  =
   CLEAR(ifr);
-    strncpynt(ifr=2Elifr_name, tt->actual_name, sizeof(ifr=
=2Elifr_name));
+    strlcpy(ifr=2Elifr_name, tt->actual_name, sizeof(ifr=
=2Elifr_name));
     ifr=2Elifr_ip_muxid =3D ip_muxid;
     if (tt->type =
=3D=3D DEV_TYPE_TAP)
     {
@@ -2512,7 +2512,7 @@
     {
         struct li=
freq ifr;
         CLEAR(ifr);
-        strncpynt(ifr=2Elifr_name, tt->actu=
al_name, sizeof(ifr=2Elifr_name));
+        strlcpy(ifr=2Elifr_name, tt->ac=
tual_name, sizeof(ifr=2Elifr_name));
 
         if (ioctl(tt->ip_fd, SIOCGL=
IFFLAGS, &ifr) < 0)
         {
diff --git a/src/openvpn/xkey_helper=2Ec b/s=
rc/openvpn/xkey_helper=2Ec
index 69be67a=2E=2E1149c7b 100644
--- a/src/open=
vpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_helper=2Ec
@@ -198,7 +198,7 @@
 =
    {
         if (!strcmp(alg=2Eop, "Sign"))
         {
-            strnc=
pynt(alg_str, "ECDSA", sizeof(alg_str));
+            strlcpy(alg_str, "ECD=
SA", sizeof(alg_str));
         }
         else
         {
@@ -207,7 +207,7=
 @@
     }
     else if (!strcmp(alg=2Ekeytype, "ED448") || !strcmp(alg=2Ek=
eytype, "ED25519"))
     {
-        strncpynt(alg_str, alg=2Ekeytype, sizeo=
f(alg_str));
+        strlcpy(alg_str, alg=2Ekeytype, sizeof(alg_str));
   =
  }
     /* else assume RSA key */
     else if (!strcmp(alg=2Epadmode, "pk=
cs1") && (flags & MF_EXTERNAL_KEY_PKCS1PAD))
@@ -221,7 +221,7 @@
          =
   }
             tbs =3D enc;
             tbslen =3D enc_len;
-          =
  strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
+            st=
rlcpy(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
         }
         /=
* For undigested message, add hashalg=3Ddigest parameter */
         else
@=
@ -232,7 +232,7 @@
     else if (!strcmp(alg=2Epadmode, "none") && (flags &=
 MF_EXTERNAL_KEY_NOPADDING)
              && !strcmp(alg=2Eop, "Sign")) /* =
NO_PADDING requires digested data */
     {
-        strncpynt(alg_str, "RS=
A_NO_PADDING", sizeof(alg_str));
+        strlcpy(alg_str, "RSA_NO_PADDING"=
, sizeof(alg_str));
     }
     else if (!strcmp(alg=2Epadmode, "pss") && (=
flags & MF_EXTERNAL_KEY_PSSPAD))
     {
diff --git a/tests/unit_tests/openv=
pn/test_auth_token=2Ec b/tests/unit_tests/openvpn/test_auth_token=2Ec
index=
 89c418e=2E=2E3a3bfb4 100644
--- a/tests/unit_tests/openvpn/test_auth_token=
=2Ec
+++ b/tests/unit_tests/openvpn/test_auth_token=2Ec
@@ -273,7 +273,7 @@=

     }
     else if (streq(name, "session_id"))
     {
-        strncpynt(=
last_session_id_value, value, sizeof(last_session_id_value));
+        strl=
cpy(last_session_id_value, value, sizeof(last_session_id_value));
     }
 }=

 
diff --git a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/unit_tests=
/openvpn/test_pkcs11=2Ec
index a54c504=2E=2E3351eac 100644
--- a/tests/unit=
_tests/openvpn/test_pkcs11=2Ec
+++ b/tests/unit_tests/openvpn/test_pkcs11=
=2Ec
@@ -164,7 +164,7 @@
     if (!strcmp(prefix, "pkcs11-id-request") && f=
lags & GET_USER_PASS_NEED_STR)
     {
         assert_true(pkcs11_id_manage=
ment);
-        strncpynt(up->password, pkcs11_id_current, sizeof(up->passw=
ord));
+        strlcpy(up->password, pkcs11_id_current, sizeof(up->passwor=
d));
     }
     else if (flags & GET_USER_PASS_PASSWORD_ONLY)
     {
diff =
--git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/open=
vpn/test_user_pass=2Ec
index c8c69bf=2E=2Eadcf74a 100644
--- a/tests/unit_t=
ests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/test_user_pa=
ss=2Ec
@@ -53,7 +53,7 @@
     for (int i =3D 0; i < QUERY_USER_NUMSLOTS && =
query_user[i]=2Eresponse !=3D NULL; i++)
     {
         check_expected_ptr=
(query_user[i]=2Eprompt);
-        strncpynt(query_user[i]=2Eresponse, mock=
_ptr_type(char *), query_user[i]=2Eresponse_len);
+        strlcpy(query_us=
er[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=2Eresponse_len);
   =
  }
 
     return mock();

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1995?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
Gerrit-Change-Number: =
1995
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--wuYcml/YjWY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1995?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Replac=
e strncpynt with strlcpy<br><br>Mostly a straight-forward replacement=2E Bu=
t in a few<br>places I used the additional return code from strlcpy<br>inst=
ead of duplicating the strlen call=2E<br><br>Change-Id: Ib1b4a9544e09506e95=
001609262269ab8154241e<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995<br>Message-Id=
: &lt;20261017165735=2E14540-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39944=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/auth_token=2Ec<br>M src/openvpn/buffer=2Ec<br>M src/ope=
nvpn/buffer=2Eh<br>M src/openvpn/dns=2Ec<br>M src/openvpn/init=2Ec<br>M src=
/openvpn/manage=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/multi=2Ec<br=
>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/openssl_compat=2Eh<br>=
M src/openvpn/options_string=2Ec<br>M src/openvpn/pkcs11=2Ec<br>M src/openv=
pn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socks=2Ec<br>M sr=
c/openvpn/ssl=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_ver=
ify=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M src/openvpn/tun=2Ec<br=
>M src/openvpn/xkey_helper=2Ec<br>M tests/unit_tests/openvpn/test_auth_toke=
n=2Ec<br>M tests/unit_tests/openvpn/test_pkcs11=2Ec<br>M tests/unit_tests/o=
penvpn/test_user_pass=2Ec<br>24 files changed, 63 insertions(+), 86 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/95/1995/3</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/auth_toke=
n=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index b457b6f=2E=2E969f3=
7f 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><br><span>=
+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -464,7 +464,7 @@</span>=
<br><span> </span><br><span>     struct user_pass up;</span><br><span>     =
CLEAR(up);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy=
nt(up=2Eusername, multi-&gt;locked_username, sizeof(up=2Eusername));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(up=2Eusername,=
 multi-&gt;locked_username, sizeof(up=2Eusername));</span><br><span> </span=
><br><span>     generate_auth_token(&amp;up, multi);</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</s=
pan><br><span>index a90ddae=2E=2Ecc1b300 100644</span><br><span>--- a/src/o=
penvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><s=
pan>@@ -257,9 +257,8 @@</span><br><span>     int cap =3D buf_forward_capaci=
ty(buf);</span><br><span>     if (cap &gt; 0)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt((char *)pt=
r, str, cap);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
*(buf-&gt;data + buf-&gt;capacity - 1) =3D 0; /* windows vsnprintf needs th=
is */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf-&gt;=
len +=3D (int)strlen((char *)ptr);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        int str_len =3D (int)strlcpy((char *)ptr, str, cap);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf-&gt;len=
 +=3D (str_len &lt; cap) ? str_len : cap - 1;</span><br><span>         ret =
=3D true;</span><br><span>     }</span><br><span>     return ret;</span><br=
><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><=
br><span>index 063a2d4=2E=2E74e166c 100644</span><br><span>--- a/src/openvp=
n/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@=
@ -696,27 +696,6 @@</span><br><span> }</span><br><span> </span><br><span> /=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Like \c strncpy(=
) but always null-terminates the destination=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * Copies at most \c maxlen - 1 characters from \c src into \c dest =
and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * writes a null t=
erminator at \c dest[\c maxlen - 1]=2E  Does nothing if</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * \c maxlen is zero=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param dest    Destination buffer=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param src     Source string=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param maxlen  Size of t=
he destination buffer in bytes=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-strncpynt=
(char *dest, const char *src, size_t maxlen)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (maxlen &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strn=
cpy(dest, src, maxlen - 1);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        dest[maxlen - 1] =3D 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span>  * Return true if th=
e string contains at least one decimal digit=2E</span><br><span>  *</span><=
br><span>  * @param src   The null-terminated string to scan=2E</span><br><=
span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span><br><span=
>index 713f41e=2E=2E87c9c5f 100644</span><br><span>--- a/src/openvpn/dns=2E=
c</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -444,7 +444,=
7 @@</span><br><span>         =2Eiface =3D { =2Eindex =3D tt-&gt;adapter_in=
dex, =2Ename =3D &quot;&quot; },</span><br><span>         =2Eflags =3D serv=
er-&gt;dnssec =3D=3D DNS_SECURITY_YES ? nrpt_dnssec : 0,</span><br><span>  =
   };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(nr=
pt=2Eiface=2Ename, tt-&gt;actual_name, sizeof(nrpt=2Eiface=2Ename));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(nrpt=2Eiface=
=2Ename, tt-&gt;actual_name, sizeof(nrpt=2Eiface=2Ename));</span><br><span>=
 </span><br><span>     for (size_t i =3D 0; i &lt; NRPT_ADDR_NUM; ++i)</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/=
openvpn/init=2Ec</span><br><span>index 3c2ebf9=2E=2Ed8fd844 100644</span><b=
r><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -393,8 +393,8 @@</span><br><span>                  =
   ALLOC_OBJ_CLEAR_GC(rhs, struct remote_host_store, &amp;c-&gt;options=2Eg=
c);</span><br><span>                     c-&gt;options=2Erh_store =3D rhs;<=
/span><br><span>                 }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                strncpynt(rhs-&gt;host, p[2], RH_HOST_LEN);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                strncpyn=
t(rhs-&gt;port, p[3], RH_PORT_LEN);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                strlcpy(rhs-&gt;host, p[2], RH_HOST_LEN);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                strlc=
py(rhs-&gt;port, p[3], RH_PORT_LEN);</span><br><span> </span><br><span>    =
             ce-&gt;remote =3D rhs-&gt;host;</span><br><span>              =
   ce-&gt;remote_port =3D rhs-&gt;port;</span><br><span>diff --git a/src/op=
envpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index e15d7bd=2E=
=2E007dd2a 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -784,7 +784,7 @@</span>=
<br><span>         ASSERT(man-&gt;connection=2Eup_query_type);</span><br><s=
pan>         if (streq(man-&gt;connection=2Eup_query_type, type))</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        strncpynt(dest, string, len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            strlcpy(dest, string, len);</span><br><span> =
            man_up_finalize(man);</span><br><span>             msg(M_CLIENT=
, &quot;SUCCESS: &#39;%s&#39; %s entered, but not yet verified&quot;, type,=
 prompt);</span><br><span>         }</span><br><span>@@ -2374,7 +2374,7 @@<=
/span><br><span>     }</span><br><span>     struct user_pass up;</span><br>=
<span>     CLEAR(up);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    strncpynt(up=2Eusername, msg, sizeof(up=2Eusername));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    strlcpy(up=2Eusername, msg, sizeo=
f(up=2Eusername));</span><br><span> </span><br><span>     management_query_=
user_pass(management, &amp;up, command, GET_USER_PASS_NEED_OK, (void *)0);<=
/span><br><span>     return strcmp(&quot;ok&quot;, up=2Epassword) =3D=3D 0;=
</span><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</=
span><br><span>index 0e4669a=2E=2Ea75bd8f 100644</span><br><span>--- a/src/=
openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span=
>@@ -303,7 +303,7 @@</span><br><span> </span><br><span>                 if =
(password_buf[0])</span><br><span>                 {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    strncpynt(up-&gt;passwo=
rd, password_buf, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    strlcpy(up-&gt;password, password_buf, US=
ER_PASS_LEN);</span><br><span>                 }</span><br><span>          =
       else</span><br><span>                 {</span><br><span>@@ -364,7 +3=
64,7 @@</span><br><span>                     {</span><br><span>            =
             msg(M_FATAL, &quot;ERROR: could not read challenge response fr=
om stdin&quot;);</span><br><span>                     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    strncpynt(up-&gt;user=
name, ac-&gt;user, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    strlcpy(up-&gt;username, ac-&gt;user, US=
ER_PASS_LEN);</span><br><span>                     buf_printf(&amp;packed_r=
esp, &quot;CRV1::%s::%s&quot;, ac-&gt;state_id, response);</span><br><span>=
                 }</span><br><span>                 else</span><br><span>@@=
 -452,7 +452,7 @@</span><br><span>         /* Use tag for blank password if=
 we are not prompting for one */</span><br><span>         if (flags &amp; G=
ET_USER_PASS_USERNAME_ONLY)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            strncpynt(up-&gt;password, bla=
nk_up, sizeof(up-&gt;password));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            strlcpy(up-&gt;password, blank_up, sizeof(up-&gt;p=
assword));</span><br><span>         }</span><br><span> </span><br><span>   =
      string_mod(up-&gt;username, CC_PRINT, CC_CRLF, 0);</span><br><span>@@=
 -504,7 +504,7 @@</span><br><span>     if (strlen(token))</span><br><span> =
    {</span><br><span>         unprotect_user_pass(tk);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        strncpynt(tk-&gt;password, token,=
 USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     strlcpy(tk-&gt;password, token, USER_PASS_LEN);</span><br><span>      =
   tk-&gt;token_defined =3D true;</span><br><span> </span><br><span>       =
  /*</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index a2cfdbf=2E=2Ee302a81 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -461,7 +461,7 @@</span><br><span>     const char *prefix =3D mu=
lti_instance_string(mi, true, &amp;gc);</span><br><span>     if (prefix)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       strncpynt(mi-&gt;msg_prefix, prefix, sizeof(mi-&gt;msg_prefix));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(mi-&gt;=
msg_prefix, prefix, sizeof(mi-&gt;msg_prefix));</span><br><span>     }</spa=
n><br><span>     else</span><br><span>     {</span><br><span>@@ -2657,7 +26=
57,7 @@</span><br><span>         {</span><br><span>             struct user=
_pass up;</span><br><span>             CLEAR(up);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            strncpynt(up=2Eusername, multi-&gt;=
locked_username, sizeof(up=2Eusername));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            strlcpy(up=2Eusername, multi-&gt;locked_us=
ername, sizeof(up=2Eusername));</span><br><span> </span><br><span>         =
    generate_auth_token(&amp;up, multi);</span><br><span>         }</span><=
br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networ=
king_sitnl=2Ec</span><br><span>index f9596a5=2E=2Ebbdfcb7 100644</span><br>=
<span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/open=
vpn/networking_sitnl=2Ec</span><br><span>@@ -602,7 +602,7 @@</span><br><spa=
n> </span><br><span>     /* save result in output variables */</span><br><s=
pan>     memcpy(best_gw, &amp;res=2Egw, res=2Eaddr_size);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    strncpynt(best_iface, res=2Eiface, =
IFNAMSIZ);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlc=
py(best_iface, res=2Eiface, IFNAMSIZ);</span><br><span> err:</span><br><spa=
n>     return ret;</span><br><span> }</span><br><span>@@ -1424,7 +1424,7 @@=
</span><br><span>             return -ENOENT;</span><br><span>         }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  strncpynt(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_MAX);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(type,=
 RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_MAX);</span><br><span>  =
   }</span><br><span> </span><br><span>     return 0;</span><br><span>diff =
--git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</sp=
an><br><span>index 1a934db=2E=2E4305fea 100644</span><br><span>--- a/src/op=
envpn/openssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=
=2Eh</span><br><span>@@ -104,10 +104,10 @@</span><br><span>         curve =
=3D &quot;(error fetching curve name)&quot;;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpy=
nt(gname, curve, gname_sz);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    strlcpy(gname, curve, gname_sz);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* strncpynt ensures null term=
ination so just strlen is fine here */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    *gname_len =3D strlen(curve);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* strlcpy ensures null termination so j=
ust strlen is fine here */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    *gname_len =3D strlen(gname);</span><br><span>     return 1;</sp=
an><br><span> }</span><br><span> #endif /* if OPENSSL_VERSION_NUMBER &lt; 0=
x30000000L &amp;&amp; !defined(OPENSSL_NO_EC) */</span><br><span>diff --git=
 a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec</span><b=
r><span>index 88ab798=2E=2Ecfc0595 100644</span><br><span>--- a/src/openvpn=
/options_string=2Ec</span><br><span>+++ b/src/openvpn/options_string=2Ec</s=
pan><br><span>@@ -385,9 +385,9 @@</span><br><span> const char *</span><br><=
span> options_string_version(const char *s, struct gc_arena *gc)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct bu=
ffer out =3D alloc_buf_gc(4, gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    strncpynt((char *)BPTR(&amp;out), s, 3);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&amp;out);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    char *out =3D gc_malloc(3, fa=
lse, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcp=
y(out, s, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn out;</span><br><span> }</span><br><span> </span><br><span> #if defined=
(__GNUC__) || defined(__clang__)</span><br><span>diff --git a/src/openvpn/p=
kcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span>index d7dee97=2E=2E09c89=
96 100644</span><br><span>--- a/src/openvpn/pkcs11=2Ec</span><br><span>+++ =
b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -224,7 +224,7 @@</span><br><spa=
n>     }</span><br><span>     else</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        strncpynt(pin, token_pass=2Epas=
sword, pin_max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     strlcpy(pin, token_pass=2Epassword, pin_max);</span><br><span>        =
 purge_user_pass(&amp;token_pass, true);</span><br><span> </span><br><span>=
         if (strlen(pin) =3D=3D 0)</span><br><span>diff --git a/src/openvpn=
/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 9c80f3b=2E=2E8e934=
04 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b=
/src/openvpn/route=2Ec</span><br><span>@@ -2970,7 +2970,7 @@</span><br><spa=
n> </span><br><span>     if (msg=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_I=
NVALID)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        strncpynt(msg=2Eiface=2Ename, tt-&gt;actual_name, sizeof(m=
sg=2Eiface=2Ename));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        strlcpy(msg=2Eiface=2Ename, tt-&gt;actual_name, sizeof(msg=2Eiface=
=2Ename));</span><br><span>     }</span><br><span> </span><br><span>     st=
atus =3D do_route_service(add, &amp;msg, sizeof(msg), tt-&gt;options=2Emsg_=
channel);</span><br><span>@@ -3139,7 +3139,7 @@</span><br><span>           =
      addr =3D ntohl(((struct sockaddr_in *)&amp;ifr-&gt;ifr_addr)-&gt;sin_=
addr=2Es_addr);</span><br><span> </span><br><span>                 /* get i=
nterface name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           strncpynt(ifreq=2Eifr_name, ifr-&gt;ifr_name, sizeof(ifreq=2Eifr=
_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     strlcpy(ifreq=2Eifr_name, ifr-&gt;ifr_name, sizeof(ifreq=2Eifr_name));=
</span><br><span> </span><br><span>                 /* check that the inter=
face is up */</span><br><span>                 if (ioctl(sd, SIOCGIFFLAGS, =
&amp;ifreq) &lt; 0)</span><br><span>@@ -3192,7 +3192,7 @@</span><br><span> =
                }</span><br><span> </span><br><span>                 /* sav=
e iface name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          strncpynt(rgi-&gt;iface, ifreq=2Eifr_name, sizeof(rgi-&gt;iface))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                st=
rlcpy(rgi-&gt;iface, ifreq=2Eifr_name, sizeof(rgi-&gt;iface));</span><br><s=
pan>                 rgi-&gt;flags |=3D RGI_IFACE_DEFINED;</span><br><span>=
 </span><br><span>                 /* now get the hardware address=2E */</s=
pan><br><span>@@ -3460,7 +3460,7 @@</span><br><span> </span><br><span>     =
    CLEAR(ifr);</span><br><span>         ifr=2Eifr_addr=2Esa_family =3D AF_=
INET;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpyn=
t(ifr=2Eifr_name, rgi-&gt;iface, IFNAMSIZ);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        strlcpy(ifr=2Eifr_name, rgi-&gt;iface, IFNA=
MSIZ);</span><br><span> </span><br><span>         if (ioctl(sockfd, SIOCGIF=
NETMASK, (char *)&amp;ifr) &lt; 0)</span><br><span>         {</span><br><sp=
an>@@ -3489,7 +3489,7 @@</span><br><span>         struct ifreq ifreq =3D { =
0 };</span><br><span> </span><br><span>         /* now get the hardware add=
ress=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        str=
ncpynt(ifreq=2Eifr_name, rgi-&gt;iface, sizeof(ifreq=2Eifr_name));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(ifreq=2Eifr_=
name, rgi-&gt;iface, sizeof(ifreq=2Eifr_name));</span><br><span>         if=
 (ioctl(sockfd, SIOCGIFHWADDR, &amp;ifreq) &lt; 0)</span><br><span>        =
 {</span><br><span>             msg(M_WARN, &quot;GDG: SIOCGIFHWADDR(%s) fa=
iled&quot;, ifreq=2Eifr_name);</span><br><span>@@ -3748,7 +3748,7 @@</span>=
<br><span>         {</span><br><span>             rgi-&gt;gateway=2Eaddr =
=3D ntohl(((struct sockaddr_in *)route=2Egateway)-&gt;sin_addr=2Es_addr);</=
span><br><span>             rgi-&gt;flags =3D RGI_ADDR_DEFINED | RGI_IFACE_=
DEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            s=
trncpynt(rgi-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-&gt;iface));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            strlcpy(rgi=
-&gt;iface, interface-&gt;ifr_name, sizeof(rgi-&gt;iface));</span><br><span=
>         }</span><br><span> </span><br><span>         int32 address_size =
=3D 0;</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/so=
cket=2Ec</span><br><span>index df8e400=2E=2Ef516a14 100644</span><br><span>=
--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</=
span><br><span>@@ -3077,7 +3077,7 @@</span><br><span> sockaddr_unix_init(st=
ruct sockaddr_un *local, const char *path)</span><br><span> {</span><br><sp=
an>     local-&gt;sun_family =3D PF_UNIX;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    strncpynt(local-&gt;sun_path, path, sizeof(local-&g=
t;sun_path));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
rlcpy(local-&gt;sun_path, path, sizeof(local-&gt;sun_path));</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span>diff --git a/s=
rc/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index 0296349=
=2E=2Ecab9af6 100644</span><br><span>--- a/src/openvpn/socks=2Ec</span><br>=
<span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ -58,12 +58,12 @@</span=
><br><span>     ASSERT(server);</span><br><span>     ASSERT(port);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpyn=
t(p-&gt;server, server, sizeof(p-&gt;server));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    strlcpy(p-&gt;server, server, sizeof(p-&gt;s=
erver));</span><br><span>     p-&gt;port =3D port;</span><br><span> </span>=
<br><span>     if (authfile)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        strncpynt(p-&gt;authfile, authfile,=
 sizeof(p-&gt;authfile));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        strlcpy(p-&gt;authfile, authfile, sizeof(p-&gt;authfile));</s=
pan><br><span>     }</span><br><span>     else</span><br><span>     {</span=
><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br=
><span>index 3594871=2E=2E49a9cb6 100644</span><br><span>--- a/src/openvpn/=
ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -272,7=
 +272,7 @@</span><br><span>         /* prompt for password even if --askpas=
s wasn&#39;t specified */</span><br><span>         pem_password_setup(NULL)=
;</span><br><span>         ASSERT(!passbuf=2Eprotected);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        strncpynt(buf, passbuf=2Epasswor=
d, (size_t)size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      strlcpy(buf, passbuf=2Epassword, (size_t)size);</span><br><span>     =
    purge_user_pass(&amp;passbuf, false);</span><br><span> </span><br><span=
>         return (int)strlen(buf);</span><br><span>@@ -2230,7 +2230,7 @@</s=
pan><br><span>         if (session-&gt;opt-&gt;pull &amp;&amp; up !=3D &amp=
;auth_token)</span><br><span>         {</span><br><span>             unprot=
ect_user_pass(&amp;auth_token);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            strncpynt(auth_token=2Eusername, up-&gt;username, USE=
R_PASS_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     strlcpy(auth_token=2Eusername, up-&gt;username, USER_PASS_LEN);</span>=
<br><span>             protect_user_pass(&amp;auth_token);</span><br><span>=
         }</span><br><span>         protect_user_pass(up);</span><br><span>=
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</spa=
n><br><span>index e0f34cd=2E=2Efe2bfda 100644</span><br><span>--- a/src/ope=
nvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</spa=
n><br><span>@@ -427,15 +427,14 @@</span><br><span>      * historically used=
 names with - in them=2E Silently convert names</span><br><span>      * wit=
h - to names with _ to support both</span><br><span>      */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (strlen(ciphers) &gt;=3D (len=
 - 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t ci=
phers_len =3D strlcpy(openssl_ciphers, ciphers, len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ciphers_len &gt;=3D len)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_FATAL, &quot;Failed to set restricted TLS 1=2E3 cipher list, too lon=
g (&gt;%zd)=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_FATAL, &quot;Failed to set restricted TLS 1=2E3 cipher list=
, too long (&gt;%zu)=2E&quot;,</span><br><span>             len - 1);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    strncpynt(openssl_ciphers, ciphers, len);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; strlen(openssl_ciphers); i=
++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t =
i =3D 0; i &lt; ciphers_len; i++)</span><br><span>     {</span><br><span>  =
       if (openssl_ciphers[i] =3D=3D &#39;-&#39;)</span><br><span>         =
{</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl=
_verify=2Ec</span><br><span>index a744e07=2E=2E73e3696 100644</span><br><sp=
an>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_v=
erify=2Ec</span><br><span>@@ -1640,7 +1640,7 @@</span><br><span>           =
  &quot;TLS: Replacing client provided username &#39;%s&#39; with &quot;</s=
pan><br><span>             &quot;username from override-user &#39;%s&#39;&q=
uot;,</span><br><span>             up-&gt;username, multi-&gt;locked_userna=
me);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt=
(up-&gt;username, multi-&gt;locked_username, sizeof(up-&gt;username));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(up-&gt;u=
sername, multi-&gt;locked_username, sizeof(up-&gt;username));</span><br><sp=
an>     }</span><br><span> </span><br><span>     /*</span><br><span>diff --=
git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=
=2Ec</span><br><span>index 6073e4e=2E=2E146a384 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_=
verify_openssl=2Ec</span><br><span>@@ -157,14 +157,16 @@</span><br><span>  =
                   if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length(name-&g=
t;d=2Erfc822Name))</span><br><span>                     {</span><br><span> =
                        msg(D_TLS_ERRORS, &quot;ASN1 ERROR: string containe=
d terminating zero&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        OPENSSL_free(buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    else if (strlcpy(out, buf=
, size) &gt;=3D size)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        msg(D_TLS_ERRORS, &quot;ASN1 ERROR: string too =
long&quot;);</span><br><span>                     }</span><br><span>       =
              else</span><br><span>                     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        strncpynt(out, =
buf, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              OPENSSL_free(buf);</span><br><span>                         r=
etval =3D true;</span><br><span>                     }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    OPENSSL_free(buf);</=
span><br><span>                     break;</span><br><span> </span><br><spa=
n>                 default:</span><br><span>@@ -243,9 +245,7 @@</span><br><=
span>         goto exit;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(out, (char *)buf,=
 size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ret =3D (strlen((char *)buf) &l=
t; size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ret =3D (strlcpy(out, (char *)buf, size) &lt; size) ? SUCCESS=
 : FAILURE;</span><br><span> </span><br><span> exit:</span><br><span>     O=
PENSSL_free(buf);</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/op=
envpn/tun=2Ec</span><br><span>index 2c2766f=2E=2Ea226fc4 100644</span><br><=
span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</s=
pan><br><span>@@ -127,7 +127,7 @@</span><br><span> </span><br><span>     if=
 (addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt=
(addr=2Eiface=2Ename, tt-&gt;actual_name, sizeof(addr=2Eiface=2Ename));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(addr=2E=
iface=2Ename, tt-&gt;actual_name, sizeof(addr=2Eiface=2Ename));</span><br><=
span>     }</span><br><span> </span><br><span>     if (addr=2Efamily =3D=3D=
 AF_INET)</span><br><span>@@ -188,12 +188,12 @@</span><br><span>     };</sp=
an><br><span> </span><br><span>     /* interface name is required */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(dns=2Eiface=2E=
name, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    strlcpy(dns=2Eiface=2Ename, tt-&gt;a=
ctual_name, sizeof(dns=2Eiface=2Ename));</span><br><span> </span><br><span>=
     /* only use domain when there are no search domains */</span><br><span=
>     if (o-&gt;domain &amp;&amp; !o-&gt;domain_search_list[0])</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
rncpynt(dns=2Edomains, o-&gt;domain, sizeof(dns=2Edomains));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(dns=2Edomains, o-&=
gt;domain, sizeof(dns=2Edomains));</span><br><span>     }</span><br><span> =
</span><br><span>     /* Create a comma separated list of search domains */=
</span><br><span>@@ -260,7 +260,7 @@</span><br><span>                      =
         =2Eaddr_len =3D addr_len };</span><br><span> </span><br><span>    =
 /* interface name is required */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    strncpynt(dns=2Eiface=2Ename, tt-&gt;actual_name, sizeof(dn=
s=2Eiface=2Ename));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    strlcpy(dns=2Eiface=2Ename, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ena=
me));</span><br><span> </span><br><span>     if (addr_len &gt; _countof(dns=
=2Eaddr))</span><br><span>     {</span><br><span>@@ -324,7 +324,7 @@</span>=
<br><span>                                 =2Eaddr_len =3D addr_len };</spa=
n><br><span> </span><br><span>     /* interface name is required */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(wins=2Eiface=2E=
name, tt-&gt;actual_name, sizeof(wins=2Eiface=2Ename));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    strlcpy(wins=2Eiface=2Ename, tt-&gt=
;actual_name, sizeof(wins=2Eiface=2Ename));</span><br><span> </span><br><sp=
an>     if (addr_len &gt; _countof(wins=2Eaddr))</span><br><span>     {</sp=
an><br><span>@@ -372,7 +372,7 @@</span><br><span>                          =
         =2Eiface =3D { =2Eindex =3D tt-&gt;adapter_index },</span><br><spa=
n>                                   =2Emtu =3D mtu,</span><br><span>      =
                             =2Efamily =3D family };</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    strncpynt(mtu_msg=2Eiface=2Ename, tt-&g=
t;actual_name, sizeof(mtu_msg=2Eiface=2Ename));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    strlcpy(mtu_msg=2Eiface=2Ename, tt-&gt;actu=
al_name, sizeof(mtu_msg=2Eiface=2Ename));</span><br><span>     if (family =
=3D=3D AF_INET6 &amp;&amp; mtu &lt; 1280)</span><br><span>     {</span><br>=
<span>         msg(M_INFO,</span><br><span>@@ -2121,7 +2121,7 @@</span><br>=
<span>          */</span><br><span>         if (strcmp(dev, &quot;tun&quot;=
) &amp;&amp; strcmp(dev, &quot;tap&quot;))</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            strncpynt(ifr=
=2Eifr_name, dev, IFNAMSIZ);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            strlcpy(ifr=2Eifr_name, dev, IFNAMSIZ);</span><br><spa=
n>         }</span><br><span> </span><br><span>         /*</span><br><span>=
@@ -2147,7 +2147,7 @@</span><br><span>             if ((ctl_fd =3D socket(A=
F_INET, SOCK_DGRAM, 0)) &gt;=3D 0)</span><br><span>             {</span><br=
><span>                 CLEAR(netifr);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                strncpynt(netifr=2Eifr_name, ifr=2Eifr_nam=
e, IFNAMSIZ);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          strlcpy(netifr=2Eifr_name, ifr=2Eifr_name, IFNAMSIZ);</span><br><=
span>                 netifr=2Eifr_qlen =3D tt-&gt;options=2Etxqueuelen;</s=
pan><br><span>                 if (ioctl(ctl_fd, SIOCSIFTXQLEN, (void *)&am=
p;netifr) &gt;=3D 0)</span><br><span>                 {</span><br><span>@@ =
-2403,7 +2403,7 @@</span><br><span>         {</span><br><span>             =
msg(M_ERR, &quot;Can&#39;t get flags&quot;);</span><br><span>         }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(ifr=2El=
ifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        strlcpy(ifr=2Elifr_name, tt-&gt=
;actual_name, sizeof(ifr=2Elifr_name));</span><br><span>         ifr=2Elifr=
_ppa =3D ppa;</span><br><span>         /* Assign ppa according to the unit =
number returned by tun device */</span><br><span>         if (ioctl(if_fd, =
SIOCSLIFNAME, &amp;ifr) &lt; 0)</span><br><span>@@ -2471,7 +2471,7 @@</span=
><br><span>     }</span><br><span> </span><br><span>     CLEAR(ifr);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(ifr=2Elifr_nam=
e, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    strlcpy(ifr=2Elifr_name, tt-&gt;actual_nam=
e, sizeof(ifr=2Elifr_name));</span><br><span>     ifr=2Elifr_ip_muxid =3D i=
p_muxid;</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TAP)</span><b=
r><span>     {</span><br><span>@@ -2512,7 +2512,7 @@</span><br><span>     {=
</span><br><span>         struct lifreq ifr;</span><br><span>         CLEAR=
(ifr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy=
nt(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(ifr=2Elifr_na=
me, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><span> </span><=
br><span>         if (ioctl(tt-&gt;ip_fd, SIOCGLIFFLAGS, &amp;ifr) &lt; 0)<=
/span><br><span>         {</span><br><span>diff --git a/src/openvpn/xkey_he=
lper=2Ec b/src/openvpn/xkey_helper=2Ec</span><br><span>index 69be67a=2E=2E1=
149c7b 100644</span><br><span>--- a/src/openvpn/xkey_helper=2Ec</span><br><=
span>+++ b/src/openvpn/xkey_helper=2Ec</span><br><span>@@ -198,7 +198,7 @@<=
/span><br><span>     {</span><br><span>         if (!strcmp(alg=2Eop, &quot=
;Sign&quot;))</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            strncpynt(alg_str, &quot;ECDSA&quot;, sizeof=
(alg_str));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    strlcpy(alg_str, &quot;ECDSA&quot;, sizeof(alg_str));</span><br><span> =
        }</span><br><span>         else</span><br><span>         {</span><b=
r><span>@@ -207,7 +207,7 @@</span><br><span>     }</span><br><span>     els=
e if (!strcmp(alg=2Ekeytype, &quot;ED448&quot;) || !strcmp(alg=2Ekeytype, &=
quot;ED25519&quot;))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        strncpynt(alg_str, alg=2Ekeytype, sizeof(alg_=
str));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlc=
py(alg_str, alg=2Ekeytype, sizeof(alg_str));</span><br><span>     }</span><=
br><span>     /* else assume RSA key */</span><br><span>     else if (!strc=
mp(alg=2Epadmode, &quot;pkcs1&quot;) &amp;&amp; (flags &amp; MF_EXTERNAL_KE=
Y_PKCS1PAD))</span><br><span>@@ -221,7 +221,7 @@</span><br><span>          =
   }</span><br><span>             tbs =3D enc;</span><br><span>            =
 tbslen =3D enc_len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           strncpynt(alg_str, &quot;RSA_PKCS1_PADDING&quot;, sizeof(alg_str=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            strl=
cpy(alg_str, &quot;RSA_PKCS1_PADDING&quot;, sizeof(alg_str));</span><br><sp=
an>         }</span><br><span>         /* For undigested message, add hasha=
lg=3Ddigest parameter */</span><br><span>         else</span><br><span>@@ -=
232,7 +232,7 @@</span><br><span>     else if (!strcmp(alg=2Epadmode, &quot;=
none&quot;) &amp;&amp; (flags &amp; MF_EXTERNAL_KEY_NOPADDING)</span><br><s=
pan>              &amp;&amp; !strcmp(alg=2Eop, &quot;Sign&quot;)) /* NO_PAD=
DING requires digested data */</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        strncpynt(alg_str, &quot;RSA_NO_PAD=
DING&quot;, sizeof(alg_str));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        strlcpy(alg_str, &quot;RSA_NO_PADDING&quot;, sizeof(alg_s=
tr));</span><br><span>     }</span><br><span>     else if (!strcmp(alg=2Epa=
dmode, &quot;pss&quot;) &amp;&amp; (flags &amp; MF_EXTERNAL_KEY_PSSPAD))</s=
pan><br><span>     {</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_auth_token=2Ec b/tests/unit_tests/openvpn/test_auth_token=2Ec</span><b=
r><span>index 89c418e=2E=2E3a3bfb4 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_auth_token=2Ec</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_auth_token=2Ec</span><br><span>@@ -273,7 +273,7 @@</span><br><sp=
an>     }</span><br><span>     else if (streq(name, &quot;session_id&quot;)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        strncpynt(last_session_id_value, value, sizeof(last_session_id_v=
alue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strl=
cpy(last_session_id_value, value, sizeof(last_session_id_value));</span><br=
><span>     }</span><br><span> }</span><br><span> </span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/unit_tests/openvpn/te=
st_pkcs11=2Ec</span><br><span>index a54c504=2E=2E3351eac 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>@@ -164,7 +164,7 @@=
</span><br><span>     if (!strcmp(prefix, &quot;pkcs11-id-request&quot;) &a=
mp;&amp; flags &amp; GET_USER_PASS_NEED_STR)</span><br><span>     {</span><=
br><span>         assert_true(pkcs11_id_management);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        strncpynt(up-&gt;password, pkcs11_i=
d_current, sizeof(up-&gt;password));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        strlcpy(up-&gt;password, pkcs11_id_current, sizeof=
(up-&gt;password));</span><br><span>     }</span><br><span>     else if (fl=
ags &amp; GET_USER_PASS_PASSWORD_ONLY)</span><br><span>     {</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_te=
sts/openvpn/test_user_pass=2Ec</span><br><span>index c8c69bf=2E=2Eadcf74a 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass=2Ec</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><s=
pan>@@ -53,7 +53,7 @@</span><br><span>     for (int i =3D 0; i &lt; QUERY_U=
SER_NUMSLOTS &amp;&amp; query_user[i]=2Eresponse !=3D NULL; i++)</span><br>=
<span>     {</span><br><span>         check_expected_ptr(query_user[i]=2Epr=
ompt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy=
nt(query_user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=2Erespons=
e_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strl=
cpy(query_user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=2Erespon=
se_len);</span><br><span>     }</span><br><span> </span><br><span>     retu=
rn mock();</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1995?usp=3Demail">change 1995</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib1b4a9544e09506e9=
5001609262269ab8154241e </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1995 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--wuYcml/YjWY=--


--===============8074174010021742111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8074174010021742111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8074174010021742111==--

