Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF471CC6B1A
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4wLi/YYoqBcc1qxDZckArK1s8fLuM+ml/WEHxedjFo=; b=eD6PWpramVRtWe+iYShWP/Pozk
	XhlJzUEc7xzvQwVLanV+BAU68Mputd49E+T/HR5Sl9LbnZOX3mb16q70Zkd3PCg4fssvQ6T1Kz6KB
	zCjiZF2kZOcJhn3d9ULx9qwHu6/Ss3OdQlNwttl25gct+Bs1ZZPmqhdzgWoBZ+g7JuPQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxAa-0008D2-VU;
	Wed, 14 Oct 2026 11:29:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxAY-0008Ci-KT
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dYEF5UEUXAxIDAJMPp7UYzFlhgy6eV6ZbziJm1SijzU=; b=jE7+7PqqNfVImXUfrhA+zmPR+9
 BCcNuGwDlQ1VpED0LAhZoSKdmDR9ywMHdN59vYqw0W7/butJfJQz/MUYC7Rpa1cMSJO/599TXBSSc
 IJkZ+G71iif0yTuzI9/lUdTuMzYqTnkOouQ4u+UPjBPAd631FcBRsqje7O4RogUnVmjo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dYEF5UEUXAxIDAJMPp7UYzFlhgy6eV6ZbziJm1SijzU=; b=V
 D6wMuij4a7Lq5Qembly5BIWrp8kDg7YodWYP0BFuKuzjNMSd0mjNlvHuYgYNf38c26vyxWCpMBaMJ
 t7q9gRsdtK5H17nGCARrHSi20iZ0V9MBicdxYRa+dYlLYMBVcXE2kziXaxvGreJILAfGLq9ARL4E1
 g+AJv9rtY1cOV8mI=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxAU-0004BW-Ta for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:15 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c02782159so2435500f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791977344; x=1792582144; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dYEF5UEUXAxIDAJMPp7UYzFlhgy6eV6ZbziJm1SijzU=;
 b=X9mj4laifFcka0dHYIhizhEDtLYMqltReOggiIRJ6pW9Ez0u6GL2MJTwmH76O6GZA5
 Cla9LQNlgS33R8CEQwstP6mdt1Wp092aMHao8Kn3W0ZlAuB1v3YTuOzkU5y96JIrxebE
 jbO8bVPS4dJvMyYaT9xcnhYUkWgRE1tXfoZW7HwGlI2l4Ivi76mqD2+gECY1V+k6yb6+
 mcJWPYT/Z5I8/WnyHxBGKe+Stc2iLKAowH+jJVxwFX6+i8cC6MIxSq3HLLlddd65OWQe
 ZfML1+3BqhDUtmCVn3Q2JiMoZlYd6pw6mFGHkY0lhAYqa568fN/l/dGLfM5XPvwEsoAn
 FKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977344; x=1792582144;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dYEF5UEUXAxIDAJMPp7UYzFlhgy6eV6ZbziJm1SijzU=;
 b=pWSTw7HfsjWLxzyKw7mKF3Al8Qum+Mrx6A8kJoPL26gh+XuEQLa8wKgKEPnxwSMiOa
 QicMQQYFe+Lu4wA5g4Ol/f3a/jWiP7lpNkxKNOr5Ys15DcjFDkNf+dmdvS5QNQbiZakL
 sGwghH0cIUTgb+Wt4CtVSK8DJqJ9oYDMDyvv3ZfVOV2VqgAZCHDYK47xqzSaGZ0mzgJx
 lM93UiAjGWTHD/VPFqdK5wjsAl4R3LYWZcqD73bciTSw8Lk8hmfrsJirRnvjpN7subZr
 ujEuE1Ke89/DB4f4BkUUjNpcLMKTsWFPDFZ1vfy0038Sfsp+ZG0XXM7jB/dvUkZ24any
 VJ1Q==
X-Gm-Message-State: AFq9FYKxN4oFnsLqlJJ9WE3Xic9jiceUJdg81WoZ0AEpGZ9X23hY4bSa
 PIuWR8zYnCMhZP09G6Jt5iQcYru9TIvSYWtCHoV3v+trHIvzfVVC85UPo/IaBc48s1KreX//G2N
 ac8VJ7rWKvHSxLfo41ZS4Ev8DtJJVelYjobKd2WHiy4GeiZgKXvKJ6A4jOGCZUjbJXVgrCfpeKy
 iJn7+XTQ==
X-Gm-Gg: AYBFou0Eu5RwqvGB02sHNl9jbZ8uMNqU1GdDZhBw8MbPkR2BvstqaxzZR8sy/nnKNPP
 Jcnerf+3rYRpwpJMSFjpsde1WnOFUcJrW5/wVjHdFS/wq4KAP6Arlg+wH4CAMC6M9n+x7MOOMwJ
 PE42XwiIllqKK2cgNS/IZHpvqcraZ6YjjaIG2Ln1aDsOMD5Kxr9BwMcO7qGlvFJImb3zzuZ5nl3
 mOvIJ3MxVyakmyDHs1PANXTBvxrRFjTG/foV355VkKkwa5L6aSdg3WYuB24eI35/mt1szbT0t0z
 qPzvQT1a1pVOGSqsPl1LpEtQB60sG8GL87PDD473+Nu6UzhmgVO0/z8kQhyJrA4PDhA1FiT0q4s
 zxi7R4WOwoBEldncXT4UVxEuGFWB5PZEfJzgdRIKVBthN8aZYxCrOGoaBbTk0zayLGlSUwYKS2S
 Z3YhN2gmsLz9VOCDwnK177kDt2iB5fCWgIKiRLs1gTuWGFOEmd41Pq+F+EWowVsSBQWW7qic5ML
 zT3X7uqCV43ik2V9HuSA0c0Saw3rlWfOpWrqs2U8wenH2jwAejm45ZetYGEPYcAdi2HQljjt7dC
 dhFMV3J4ZBplDF56vWDyetwMtnLHOukdOFE4v5gYlq3SbEy2YRHwhlqkdivi1cff+UBnvUQ=
X-Received: by 2002:a05:6000:29c3:b0:48b:7179:59da with SMTP id
 ffacd0b85a97d-48dba784b98mr21457976f8f.1.1791977342971; 
 Wed, 14 Oct 2026 04:29:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaad1sm11071711f8f.17.2026.10.14.04.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:29:02 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:28:57 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
X-Gerrit-Change-Number: 1995
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1995?usp=email>
X-Gerrit-Commit: 8c89419a3c7a16eec9f51c0d5a62b219d29f51bb
In-Reply-To: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
References: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkliMWI0YTk1NDRlMDk1MDZlOTUwMDE2MDkyNjIyNjlhYjgxNTQyNDFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36a84e2bde5f5d073c1e08d5fa16481f9a81260c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxAU-0004BW-Ta
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0694038402508991912=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0694038402508991912==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+/a6UlLnw5o="; charset=UTF-8

--+/a6UlLnw5o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1995?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: Replace strncpynt with strlcpy
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace strncpynt with strlcpy
=

Mostly a straight-forward replacement=2E But in a few
places I used the ad=
ditional return code from strlcpy
instead of duplicating the strlen call=2E=


Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
Signed-off-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/auth_token=2Ec
M s=
rc/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/dns=2Ec
M src/=
openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/misc=2Ec
M src/open=
vpn/multi=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/openssl_comp=
at=2Eh
M src/openvpn/options_string=2Ec
M src/openvpn/pkcs11=2Ec
M src/open=
vpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socks=2Ec
M src/openvp=
n/ssl=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_verify=2Ec
M src/=
openvpn/ssl_verify_openssl=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/xkey_hel=
per=2Ec
M tests/unit_tests/openvpn/test_auth_token=2Ec
M tests/unit_tests/o=
penvpn/test_pkcs11=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
24 fil=
es changed, 63 insertions(+), 86 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/95/1995/2

diff --git a/src/openvpn=
/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index b457b6f=2E=2E969f37f 100=
644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -4=
64,7 +464,7 @@
 
     struct user_pass up;
     CLEAR(up);
-    strncpynt(u=
p=2Eusername, multi->locked_username, sizeof(up=2Eusername));
+    strlcpy(=
up=2Eusername, multi->locked_username, sizeof(up=2Eusername));
 
     gener=
ate_auth_token(&up, multi);
 
diff --git a/src/openvpn/buffer=2Ec b/src/ope=
nvpn/buffer=2Ec
index a90ddae=2E=2Ecc1b300 100644
--- a/src/openvpn/buffer=
=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -257,9 +257,8 @@
     int cap =3D buf_=
forward_capacity(buf);
     if (cap > 0)
     {
-        strncpynt((char *)=
ptr, str, cap);
-        *(buf->data + buf->capacity - 1) =3D 0; /* windows=
 vsnprintf needs this */
-        buf->len +=3D (int)strlen((char *)ptr);
+=
        int str_len =3D (int)strlcpy((char *)ptr, str, cap);
+        buf->=
len +=3D (str_len < cap) ? str_len : cap - 1;
         ret =3D true;
     }=

     return ret;
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh
index 58e10f0=2E=2Ec66ed1a 100644
--- a/src/openvpn/buffer=2Eh
+++ b/s=
rc/openvpn/buffer=2Eh
@@ -696,27 +696,6 @@
 }
 
 /**
- * Like \c strncpy() =
but always null-terminates the destination=2E
- *
- * Copies at most \c max=
len - 1 characters from \c src into \c dest and
- * writes a null terminato=
r at \c dest[\c maxlen - 1]=2E  Does nothing if
- * \c maxlen is zero=2E
- =
*
- * @param dest    Destination buffer=2E
- * @param src     Source string=
=2E
- * @param maxlen  Size of the destination buffer in bytes=2E
- */
-sta=
tic inline void
-strncpynt(char *dest, const char *src, size_t maxlen)
-{
-=
    if (maxlen > 0)
-    {
-        strncpy(dest, src, maxlen - 1);
-      =
  dest[maxlen - 1] =3D 0;
-    }
-}
-
-/**
  * Return true if the string co=
ntains at least one decimal digit=2E
  *
  * @param src   The null-terminat=
ed string to scan=2E
diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec=

index 713f41e=2E=2E87c9c5f 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/open=
vpn/dns=2Ec
@@ -444,7 +444,7 @@
         =2Eiface =3D { =2Eindex =3D tt->ad=
apter_index, =2Ename =3D "" },
         =2Eflags =3D server->dnssec =3D=3D =
DNS_SECURITY_YES ? nrpt_dnssec : 0,
     };
-    strncpynt(nrpt=2Eiface=2En=
ame, tt->actual_name, sizeof(nrpt=2Eiface=2Ename));
+    strlcpy(nrpt=2Eifa=
ce=2Ename, tt->actual_name, sizeof(nrpt=2Eiface=2Ename));
 
     for (size_=
t i =3D 0; i < NRPT_ADDR_NUM; ++i)
     {
diff --git a/src/openvpn/init=2Ec=
 b/src/openvpn/init=2Ec
index 9306a96=2E=2E55d985d 100644
--- a/src/openvpn=
/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -393,8 +393,8 @@
                  =
   ALLOC_OBJ_CLEAR_GC(rhs, struct remote_host_store, &c->options=2Egc);
   =
                  c->options=2Erh_store =3D rhs;
                 }
-      =
          strncpynt(rhs->host, p[2], RH_HOST_LEN);
-                strncpy=
nt(rhs->port, p[3], RH_PORT_LEN);
+                strlcpy(rhs->host, p[2],=
 RH_HOST_LEN);
+                strlcpy(rhs->port, p[3], RH_PORT_LEN);
 
  =
               ce->remote =3D rhs->host;
                 ce->remote_port =
=3D rhs->port;
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec=

index 55e8105=2E=2E8a476e6 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/o=
penvpn/manage=2Ec
@@ -784,7 +784,7 @@
         ASSERT(man->connection=2Eup_=
query_type);
         if (streq(man->connection=2Eup_query_type, type))
   =
      {
-            strncpynt(dest, string, len);
+            strlcpy(des=
t, string, len);
             man_up_finalize(man);
             msg(M_CLIE=
NT, "SUCCESS: '%s' %s entered, but not yet verified", type, prompt);
      =
   }
@@ -2374,7 +2374,7 @@
     }
     struct user_pass up;
     CLEAR(up);=

-    strncpynt(up=2Eusername, msg, sizeof(up=2Eusername));
+    strlcpy(up=
=2Eusername, msg, sizeof(up=2Eusername));
 
     management_query_user_pass=
(management, &up, command, GET_USER_PASS_NEED_OK, (void *)0);
     return s=
trcmp("ok", up=2Epassword) =3D=3D 0;
diff --git a/src/openvpn/misc=2Ec b/sr=
c/openvpn/misc=2Ec
index 0e4669a=2E=2Ea75bd8f 100644
--- a/src/openvpn/misc=
=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -303,7 +303,7 @@
 
                 if (=
password_buf[0])
                 {
-                    strncpynt(up->pass=
word, password_buf, USER_PASS_LEN);
+                    strlcpy(up->passwo=
rd, password_buf, USER_PASS_LEN);
                 }
                 else
=
                 {
@@ -364,7 +364,7 @@
                     {
             =
            msg(M_FATAL, "ERROR: could not read challenge response from std=
in");
                     }
-                    strncpynt(up->username, a=
c->user, USER_PASS_LEN);
+                    strlcpy(up->username, ac->use=
r, USER_PASS_LEN);
                     buf_printf(&packed_resp, "CRV1::%s:=
:%s", ac->state_id, response);
                 }
                 else
@@ =
-452,7 +452,7 @@
         /* Use tag for blank password if we are not promp=
ting for one */
         if (flags & GET_USER_PASS_USERNAME_ONLY)
         =
{
-            strncpynt(up->password, blank_up, sizeof(up->password));
+  =
          strlcpy(up->password, blank_up, sizeof(up->password));
         }=

 
         string_mod(up->username, CC_PRINT, CC_CRLF, 0);
@@ -504,7 +504,=
7 @@
     if (strlen(token))
     {
         unprotect_user_pass(tk);
-    =
    strncpynt(tk->password, token, USER_PASS_LEN);
+        strlcpy(tk->pas=
sword, token, USER_PASS_LEN);
         tk->token_defined =3D true;
 
      =
   /*
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index dda9=
232=2E=2Ea2b4e52 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -461,7 +461,7 @@
     const char *prefix =3D multi_instance_string(=
mi, true, &gc);
     if (prefix)
     {
-        strncpynt(mi->msg_prefix, =
prefix, sizeof(mi->msg_prefix));
+        strlcpy(mi->msg_prefix, prefix, s=
izeof(mi->msg_prefix));
     }
     else
     {
@@ -2657,7 +2657,7 @@
     =
    {
             struct user_pass up;
             CLEAR(up);
-          =
  strncpynt(up=2Eusername, multi->locked_username, sizeof(up=2Eusername));
=
+            strlcpy(up=2Eusername, multi->locked_username, sizeof(up=2Euse=
rname));
 
             generate_auth_token(&up, multi);
         }
diff --=
git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
i=
ndex d6510bb=2E=2E9f1e041 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++=
 b/src/openvpn/networking_sitnl=2Ec
@@ -602,7 +602,7 @@
 
     /* save resu=
lt in output variables */
     memcpy(best_gw, &res=2Egw, res=2Eaddr_size);=

-    strncpynt(best_iface, res=2Eiface, IFNAMSIZ);
+    strlcpy(best_iface=
, res=2Eiface, IFNAMSIZ);
 err:
     return ret;
 }
@@ -1424,7 +1424,7 @@
 =
            return -ENOENT;
         }
 
-        strncpynt(type, RTA_DATA(=
tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_MAX);
+        strlcpy(type, RTA_D=
ATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_MAX);
     }
 
     return 0;
=
diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2E=
h
index 098bdd5=2E=2E49f2419 100644
--- a/src/openvpn/openssl_compat=2Eh
++=
+ b/src/openvpn/openssl_compat=2Eh
@@ -104,10 +104,10 @@
         curve =3D=
 "(error fetching curve name)";
     }
 
-    strncpynt(gname, curve, gname=
_sz);
+    strlcpy(gname, curve, gname_sz);
 
-    /* strncpynt ensures nul=
l termination so just strlen is fine here */
-    *gname_len =3D strlen(cur=
ve);
+    /* strlcpy ensures null termination so just strlen is fine here *=
/
+    *gname_len =3D strlen(gname);
     return 1;
 }
 #endif /* if OPENSS=
L_VERSION_NUMBER < 0x30000000L && !defined(OPENSSL_NO_EC) */
diff --git a/s=
rc/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec
index 88ab79=
8=2E=2Ecfc0595 100644
--- a/src/openvpn/options_string=2Ec
+++ b/src/openvp=
n/options_string=2Ec
@@ -385,9 +385,9 @@
 const char *
 options_string_vers=
ion(const char *s, struct gc_arena *gc)
 {
-    struct buffer out =3D alloc=
_buf_gc(4, gc);
-    strncpynt((char *)BPTR(&out), s, 3);
-    return BSTR(=
&out);
+    char *out =3D gc_malloc(3, false, gc);
+    strlcpy(out, s, 3);=

+    return out;
 }
 
 #if defined(__GNUC__) || defined(__clang__)
diff --=
git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec
index d7dee97=2E=2E09=
c8996 100644
--- a/src/openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -=
224,7 +224,7 @@
     }
     else
     {
-        strncpynt(pin, token_pass=
=2Epassword, pin_max);
+        strlcpy(pin, token_pass=2Epassword, pin_max=
);
         purge_user_pass(&token_pass, true);
 
         if (strlen(pin) =
=3D=3D 0)
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index =
9209a76=2E=2E60a1f5b 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/r=
oute=2Ec
@@ -2968,7 +2968,7 @@
 
     if (msg=2Eiface=2Eindex =3D=3D TUN_AD=
APTER_INDEX_INVALID)
     {
-        strncpynt(msg=2Eiface=2Ename, tt->actu=
al_name, sizeof(msg=2Eiface=2Ename));
+        strlcpy(msg=2Eiface=2Ename, =
tt->actual_name, sizeof(msg=2Eiface=2Ename));
     }
 
     status =3D do_r=
oute_service(add, &msg, sizeof(msg), tt->options=2Emsg_channel);
@@ -3137,7=
 +3137,7 @@
                 addr =3D ntohl(((struct sockaddr_in *)&ifr->if=
r_addr)->sin_addr=2Es_addr);
 
                 /* get interface name */
- =
               strncpynt(ifreq=2Eifr_name, ifr->ifr_name, sizeof(ifreq=2Eif=
r_name));
+                strlcpy(ifreq=2Eifr_name, ifr->ifr_name, sizeof(=
ifreq=2Eifr_name));
 
                 /* check that the interface is up */=

                 if (ioctl(sd, SIOCGIFFLAGS, &ifreq) < 0)
@@ -3190,7 +3190=
,7 @@
                 }
 
                 /* save iface name */
-        =
        strncpynt(rgi->iface, ifreq=2Eifr_name, sizeof(rgi->iface));
+     =
           strlcpy(rgi->iface, ifreq=2Eifr_name, sizeof(rgi->iface));
     =
            rgi->flags |=3D RGI_IFACE_DEFINED;
 
                 /* now ge=
t the hardware address=2E */
@@ -3458,7 +3458,7 @@
 
         CLEAR(ifr);
 =
        ifr=2Eifr_addr=2Esa_family =3D AF_INET;
-        strncpynt(ifr=2Eif=
r_name, rgi->iface, IFNAMSIZ);
+        strlcpy(ifr=2Eifr_name, rgi->iface,=
 IFNAMSIZ);
 
         if (ioctl(sockfd, SIOCGIFNETMASK, (char *)&ifr) < 0)=

         {
@@ -3487,7 +3487,7 @@
         struct ifreq ifreq =3D { 0 };
 
=
         /* now get the hardware address=2E */
-        strncpynt(ifreq=2Ei=
fr_name, rgi->iface, sizeof(ifreq=2Eifr_name));
+        strlcpy(ifreq=2Eif=
r_name, rgi->iface, sizeof(ifreq=2Eifr_name));
         if (ioctl(sockfd, S=
IOCGIFHWADDR, &ifreq) < 0)
         {
             msg(M_WARN, "GDG: SIOCGI=
FHWADDR(%s) failed", ifreq=2Eifr_name);
@@ -3746,7 +3746,7 @@
         {
  =
           rgi->gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)route=2Egat=
eway)->sin_addr=2Es_addr);
             rgi->flags =3D RGI_ADDR_DEFINED | R=
GI_IFACE_DEFINED;
-            strncpynt(rgi->iface, interface->ifr_name, s=
izeof(rgi->iface));
+            strlcpy(rgi->iface, interface->ifr_name, s=
izeof(rgi->iface));
         }
 
         int32 address_size =3D 0;
diff --=
git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 33def4e=2E=2E0c=
585ad 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -=
3077,7 +3077,7 @@
 sockaddr_unix_init(struct sockaddr_un *local, const char=
 *path)
 {
     local->sun_family =3D PF_UNIX;
-    strncpynt(local->sun_pa=
th, path, sizeof(local->sun_path));
+    strlcpy(local->sun_path, path, siz=
eof(local->sun_path));
 }
 
 void
diff --git a/src/openvpn/socks=2Ec b/src/=
openvpn/socks=2Ec
index b84da24=2E=2E781a5d9 100644
--- a/src/openvpn/socks=
=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -58,12 +58,12 @@
     ASSERT(server);
 =
    ASSERT(port);
 
-    strncpynt(p->server, server, sizeof(p->server));
+=
    strlcpy(p->server, server, sizeof(p->server));
     p->port =3D port;
 =

     if (authfile)
     {
-        strncpynt(p->authfile, authfile, sizeof=
(p->authfile));
+        strlcpy(p->authfile, authfile, sizeof(p->authfile)=
);
     }
     else
     {
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/s=
sl=2Ec
index aeec020=2E=2E7b61725 100644
--- a/src/openvpn/ssl=2Ec
+++ b/sr=
c/openvpn/ssl=2Ec
@@ -272,7 +272,7 @@
         /* prompt for password even =
if --askpass wasn't specified */
         pem_password_setup(NULL);
       =
  ASSERT(!passbuf=2Eprotected);
-        strncpynt(buf, passbuf=2Epassword,=
 (size_t)size);
+        strlcpy(buf, passbuf=2Epassword, (size_t)size);
  =
       purge_user_pass(&passbuf, false);
 
         return (int)strlen(buf)=
;
@@ -2228,7 +2228,7 @@
         if (session->opt->pull && up !=3D &auth_to=
ken)
         {
             unprotect_user_pass(&auth_token);
-           =
 strncpynt(auth_token=2Eusername, up->username, USER_PASS_LEN);
+          =
  strlcpy(auth_token=2Eusername, up->username, USER_PASS_LEN);
            =
 protect_user_pass(&auth_token);
         }
         protect_user_pass(up);=

diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
ind=
ex 02fd556=2E=2E2d0be92 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/=
openvpn/ssl_openssl=2Ec
@@ -427,15 +427,14 @@
      * historically used nam=
es with - in them=2E Silently convert names
      * with - to names with _ =
to support both
      */
-    if (strlen(ciphers) >=3D (len - 1))
+    size=
_t ciphers_len =3D strlcpy(openssl_ciphers, ciphers, len);
+    if (ciphers=
_len >=3D len)
     {
-        msg(M_FATAL, "Failed to set restricted TLS 1=
=2E3 cipher list, too long (>%zd)=2E",
+        msg(M_FATAL, "Failed to set=
 restricted TLS 1=2E3 cipher list, too long (>%zu)=2E",
             len - =
1);
     }
 
-    strncpynt(openssl_ciphers, ciphers, len);
-
-    for (siz=
e_t i =3D 0; i < strlen(openssl_ciphers); i++)
+    for (size_t i =3D 0; i =
< ciphers_len; i++)
     {
         if (openssl_ciphers[i] =3D=3D '-')
    =
     {
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec=

index 43ed980=2E=2Ebdcb8fc 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/s=
rc/openvpn/ssl_verify=2Ec
@@ -1640,7 +1640,7 @@
             "TLS: Replacin=
g client provided username '%s' with "
             "username from override=
-user '%s'",
             up->username, multi->locked_username);
-        s=
trncpynt(up->username, multi->locked_username, sizeof(up->username));
+    =
    strlcpy(up->username, multi->locked_username, sizeof(up->username));
  =
   }
 
     /*
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvp=
n/ssl_verify_openssl=2Ec
index 6073e4e=2E=2E146a384 100644
--- a/src/openvp=
n/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -157,1=
4 +157,16 @@
                     if ((ssize_t)strlen(buf) !=3D ASN1_STRING=
_length(name->d=2Erfc822Name))
                     {
                     =
    msg(D_TLS_ERRORS, "ASN1 ERROR: string contained terminating zero");
-  =
                      OPENSSL_free(buf);
+                    }
+          =
          else if (strlcpy(out, buf, size) >=3D size)
+                    =
{
+                        msg(D_TLS_ERRORS, "ASN1 ERROR: string too long")=
;
                     }
                     else
                     {
-=
                        strncpynt(out, buf, size);
-                       =
 OPENSSL_free(buf);
                         retval =3D true;
             =
        }
+                    OPENSSL_free(buf);
                     brea=
k;
 
                 default:
@@ -243,9 +245,7 @@
         goto exit;
    =
 }
 
-    strncpynt(out, (char *)buf, size);
-
-    ret =3D (strlen((char *=
)buf) < size) ? SUCCESS : FAILURE;
+    ret =3D (strlcpy(out, (char *)buf, =
size) < size) ? SUCCESS : FAILURE;
 
 exit:
     OPENSSL_free(buf);
diff --=
git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 9e7e7d7=2E=2E478c109 =
100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -127,7 +127,7=
 @@
 
     if (addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)
     =
{
-        strncpynt(addr=2Eiface=2Ename, tt->actual_name, sizeof(addr=2Eif=
ace=2Ename));
+        strlcpy(addr=2Eiface=2Ename, tt->actual_name, sizeof=
(addr=2Eiface=2Ename));
     }
 
     if (addr=2Efamily =3D=3D AF_INET)
@@ =
-188,12 +188,12 @@
     };
 
     /* interface name is required */
-    str=
ncpynt(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename));
+ =
   strlcpy(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename))=
;
 
     /* only use domain when there are no search domains */
     if (o-=
>domain && !o->domain_search_list[0])
     {
-        strncpynt(dns=2Edomai=
ns, o->domain, sizeof(dns=2Edomains));
+        strlcpy(dns=2Edomains, o->d=
omain, sizeof(dns=2Edomains));
     }
 
     /* Create a comma separated li=
st of search domains */
@@ -260,7 +260,7 @@
                               =
=2Eaddr_len =3D addr_len };
 
     /* interface name is required */
-    st=
rncpynt(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename));
+=
    strlcpy(dns=2Eiface=2Ename, tt->actual_name, sizeof(dns=2Eiface=2Ename)=
);
 
     if (addr_len > _countof(dns=2Eaddr))
     {
@@ -324,7 +324,7 @@
 =
                                =2Eaddr_len =3D addr_len };
 
     /* inter=
face name is required */
-    strncpynt(wins=2Eiface=2Ename, tt->actual_nam=
e, sizeof(wins=2Eiface=2Ename));
+    strlcpy(wins=2Eiface=2Ename, tt->actu=
al_name, sizeof(wins=2Eiface=2Ename));
 
     if (addr_len > _countof(wins=
=2Eaddr))
     {
@@ -372,7 +372,7 @@
                                   =2E=
iface =3D { =2Eindex =3D tt->adapter_index },
                             =
      =2Emtu =3D mtu,
                                   =2Efamily =3D fami=
ly };
-    strncpynt(mtu_msg=2Eiface=2Ename, tt->actual_name, sizeof(mtu_ms=
g=2Eiface=2Ename));
+    strlcpy(mtu_msg=2Eiface=2Ename, tt->actual_name, s=
izeof(mtu_msg=2Eiface=2Ename));
     if (family =3D=3D AF_INET6 && mtu < 12=
80)
     {
         msg(M_INFO,
@@ -2119,7 +2119,7 @@
          */
        =
 if (strcmp(dev, "tun") && strcmp(dev, "tap"))
         {
-            strn=
cpynt(ifr=2Eifr_name, dev, IFNAMSIZ);
+            strlcpy(ifr=2Eifr_name, =
dev, IFNAMSIZ);
         }
 
         /*
@@ -2145,7 +2145,7 @@
            =
 if ((ctl_fd =3D socket(AF_INET, SOCK_DGRAM, 0)) >=3D 0)
             {
   =
              CLEAR(netifr);
-                strncpynt(netifr=2Eifr_name, =
ifr=2Eifr_name, IFNAMSIZ);
+                strlcpy(netifr=2Eifr_name, ifr=
=2Eifr_name, IFNAMSIZ);
                 netifr=2Eifr_qlen =3D tt->options=
=2Etxqueuelen;
                 if (ioctl(ctl_fd, SIOCSIFTXQLEN, (void *)&n=
etifr) >=3D 0)
                 {
@@ -2401,7 +2401,7 @@
         {
        =
     msg(M_ERR, "Can't get flags");
         }
-        strncpynt(ifr=2Elif=
r_name, tt->actual_name, sizeof(ifr=2Elifr_name));
+        strlcpy(ifr=2El=
ifr_name, tt->actual_name, sizeof(ifr=2Elifr_name));
         ifr=2Elifr_pp=
a =3D ppa;
         /* Assign ppa according to the unit number returned by =
tun device */
         if (ioctl(if_fd, SIOCSLIFNAME, &ifr) < 0)
@@ -2469,7=
 +2469,7 @@
     }
 
     CLEAR(ifr);
-    strncpynt(ifr=2Elifr_name, tt->a=
ctual_name, sizeof(ifr=2Elifr_name));
+    strlcpy(ifr=2Elifr_name, tt->act=
ual_name, sizeof(ifr=2Elifr_name));
     ifr=2Elifr_ip_muxid =3D ip_muxid;
=
     if (tt->type =3D=3D DEV_TYPE_TAP)
     {
@@ -2510,7 +2510,7 @@
     {
=
         struct lifreq ifr;
         CLEAR(ifr);
-        strncpynt(ifr=2El=
ifr_name, tt->actual_name, sizeof(ifr=2Elifr_name));
+        strlcpy(ifr=
=2Elifr_name, tt->actual_name, sizeof(ifr=2Elifr_name));
 
         if (ioc=
tl(tt->ip_fd, SIOCGLIFFLAGS, &ifr) < 0)
         {
diff --git a/src/openvpn=
/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec
index 69be67a=2E=2E1149c7b 1=
00644
--- a/src/openvpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_helper=2Ec
@=
@ -198,7 +198,7 @@
     {
         if (!strcmp(alg=2Eop, "Sign"))
         =
{
-            strncpynt(alg_str, "ECDSA", sizeof(alg_str));
+            s=
trlcpy(alg_str, "ECDSA", sizeof(alg_str));
         }
         else
       =
  {
@@ -207,7 +207,7 @@
     }
     else if (!strcmp(alg=2Ekeytype, "ED448"=
) || !strcmp(alg=2Ekeytype, "ED25519"))
     {
-        strncpynt(alg_str, =
alg=2Ekeytype, sizeof(alg_str));
+        strlcpy(alg_str, alg=2Ekeytype, s=
izeof(alg_str));
     }
     /* else assume RSA key */
     else if (!strcm=
p(alg=2Epadmode, "pkcs1") && (flags & MF_EXTERNAL_KEY_PKCS1PAD))
@@ -221,7 =
+221,7 @@
             }
             tbs =3D enc;
             tbslen =3D =
enc_len;
-            strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_st=
r));
+            strlcpy(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
 =
        }
         /* For undigested message, add hashalg=3Ddigest paramete=
r */
         else
@@ -232,7 +232,7 @@
     else if (!strcmp(alg=2Epadmode,=
 "none") && (flags & MF_EXTERNAL_KEY_NOPADDING)
              && !strcmp(al=
g=2Eop, "Sign")) /* NO_PADDING requires digested data */
     {
-        st=
rncpynt(alg_str, "RSA_NO_PADDING", sizeof(alg_str));
+        strlcpy(alg_s=
tr, "RSA_NO_PADDING", sizeof(alg_str));
     }
     else if (!strcmp(alg=2E=
padmode, "pss") && (flags & MF_EXTERNAL_KEY_PSSPAD))
     {
diff --git a/te=
sts/unit_tests/openvpn/test_auth_token=2Ec b/tests/unit_tests/openvpn/test_=
auth_token=2Ec
index 89c418e=2E=2E3a3bfb4 100644
--- a/tests/unit_tests/ope=
nvpn/test_auth_token=2Ec
+++ b/tests/unit_tests/openvpn/test_auth_token=2Ec=

@@ -273,7 +273,7 @@
     }
     else if (streq(name, "session_id"))
     {=

-        strncpynt(last_session_id_value, value, sizeof(last_session_id_va=
lue));
+        strlcpy(last_session_id_value, value, sizeof(last_session_i=
d_value));
     }
 }
 
diff --git a/tests/unit_tests/openvpn/test_pkcs11=2E=
c b/tests/unit_tests/openvpn/test_pkcs11=2Ec
index a54c504=2E=2E3351eac 100=
644
--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec
+++ b/tests/unit_tests/o=
penvpn/test_pkcs11=2Ec
@@ -164,7 +164,7 @@
     if (!strcmp(prefix, "pkcs11=
-id-request") && flags & GET_USER_PASS_NEED_STR)
     {
         assert_tru=
e(pkcs11_id_management);
-        strncpynt(up->password, pkcs11_id_current=
, sizeof(up->password));
+        strlcpy(up->password, pkcs11_id_current, =
sizeof(up->password));
     }
     else if (flags & GET_USER_PASS_PASSWORD_=
ONLY)
     {
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tes=
ts/unit_tests/openvpn/test_user_pass=2Ec
index 5ad4730=2E=2Ed1b4c97 100644
=
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/op=
envpn/test_user_pass=2Ec
@@ -53,7 +53,7 @@
     for (int i =3D 0; i < QUERY=
_USER_NUMSLOTS && query_user[i]=2Eresponse !=3D NULL; i++)
     {
         =
check_expected_ptr(query_user[i]=2Eprompt);
-        strncpynt(query_user[i=
]=2Eresponse, mock_ptr_type(char *), query_user[i]=2Eresponse_len);
+      =
  strlcpy(query_user[i]=2Eresponse, mock_ptr_type(char *), query_user[i]=2E=
response_len);
     }
 
     return mock();

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
Ge=
rrit-Change-Number: 1995
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--+/a6UlLnw5o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Replace strncpynt with strlcpy<br><br>Mostly a straight-forward repl=
acement=2E But in a few<br>places I used the additional return code from st=
rlcpy<br>instead of duplicating the strlen call=2E<br><br>Change-Id: Ib1b4a=
9544e09506e95001609262269ab8154241e<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/auth_token=2Ec<br>M sr=
c/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/dns=2Ec<b=
r>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/misc=
=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M =
src/openvpn/openssl_compat=2Eh<br>M src/openvpn/options_string=2Ec<br>M src=
/openvpn/pkcs11=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/socket=2Ec<=
br>M src/openvpn/socks=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_op=
enssl=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl_verify_opens=
sl=2Ec<br>M src/openvpn/tun=2Ec<br>M src/openvpn/xkey_helper=2Ec<br>M tests=
/unit_tests/openvpn/test_auth_token=2Ec<br>M tests/unit_tests/openvpn/test_=
pkcs11=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=2Ec<br>24 files cha=
nged, 63 insertions(+), 86 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/95/1995/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span>=
<br><span>index b457b6f=2E=2E969f37f 100644</span><br><span>--- a/src/openv=
pn/auth_token=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><b=
r><span>@@ -464,7 +464,7 @@</span><br><span> </span><br><span>     struct u=
ser_pass up;</span><br><span>     CLEAR(up);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    strncpynt(up=2Eusername, multi-&gt;locked_userna=
me, sizeof(up=2Eusername));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    strlcpy(up=2Eusername, multi-&gt;locked_username, sizeof(up=2Eu=
sername));</span><br><span> </span><br><span>     generate_auth_token(&amp;=
up, multi);</span><br><span> </span><br><span>diff --git a/src/openvpn/buff=
er=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index a90ddae=2E=2Ecc1b300 =
100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/s=
rc/openvpn/buffer=2Ec</span><br><span>@@ -257,9 +257,8 @@</span><br><span> =
    int cap =3D buf_forward_capacity(buf);</span><br><span>     if (cap &gt=
; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        strncpynt((char *)ptr, str, cap);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        *(buf-&gt;data + buf-&gt;capacity - 1) =
=3D 0; /* windows vsnprintf needs this */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        buf-&gt;len +=3D (int)strlen((char *)ptr);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int str_len =3D =
(int)strlcpy((char *)ptr, str, cap);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        buf-&gt;len +=3D (str_len &lt; cap) ? str_len : ca=
p - 1;</span><br><span>         ret =3D true;</span><br><span>     }</span>=
<br><span>     return ret;</span><br><span>diff --git a/src/openvpn/buffer=
=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 58e10f0=2E=2Ec66ed1a 10=
0644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src=
/openvpn/buffer=2Eh</span><br><span>@@ -696,27 +696,6 @@</span><br><span> }=
</span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * Like \c strncpy() but always null-terminates the desti=
nation=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Copies at most \c maxlen - 1=
 characters from \c src into \c dest and</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * writes a null terminator at \c dest[\c maxlen - 1]=2E=
  Does nothing if</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * \=
c maxlen is zero=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param dest    Des=
tination buffer=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
@param src     Source string=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param maxlen  Size of the destination buffer in bytes=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-strncpynt(char *dest, const char *src, size_t =
maxlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (maxlen &gt; 0)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        strncpy(dest, src, maxlen - 1);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        dest[maxlen - 1] =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
</span><br><span>  * Return true if the string contains at least one decima=
l digit=2E</span><br><span>  *</span><br><span>  * @param src   The null-te=
rminated string to scan=2E</span><br><span>diff --git a/src/openvpn/dns=2Ec=
 b/src/openvpn/dns=2Ec</span><br><span>index 713f41e=2E=2E87c9c5f 100644</s=
pan><br><span>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/d=
ns=2Ec</span><br><span>@@ -444,7 +444,7 @@</span><br><span>         =2Eifac=
e =3D { =2Eindex =3D tt-&gt;adapter_index, =2Ename =3D &quot;&quot; },</spa=
n><br><span>         =2Eflags =3D server-&gt;dnssec =3D=3D DNS_SECURITY_YES=
 ? nrpt_dnssec : 0,</span><br><span>     };</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    strncpynt(nrpt=2Eiface=2Ename, tt-&gt;actual_name=
, sizeof(nrpt=2Eiface=2Ename));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    strlcpy(nrpt=2Eiface=2Ename, tt-&gt;actual_name, sizeof(nrp=
t=2Eiface=2Ename));</span><br><span> </span><br><span>     for (size_t i =
=3D 0; i &lt; NRPT_ADDR_NUM; ++i)</span><br><span>     {</span><br><span>di=
ff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>inde=
x 9306a96=2E=2E55d985d 100644</span><br><span>--- a/src/openvpn/init=2Ec</s=
pan><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -393,8 +393,8 @=
@</span><br><span>                     ALLOC_OBJ_CLEAR_GC(rhs, struct remot=
e_host_store, &amp;c-&gt;options=2Egc);</span><br><span>                   =
  c-&gt;options=2Erh_store =3D rhs;</span><br><span>                 }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                strncpynt(=
rhs-&gt;host, p[2], RH_HOST_LEN);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                strncpynt(rhs-&gt;port, p[3], RH_PORT_LEN);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                strlcpy=
(rhs-&gt;host, p[2], RH_HOST_LEN);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                strlcpy(rhs-&gt;port, p[3], RH_PORT_LEN);</s=
pan><br><span> </span><br><span>                 ce-&gt;remote =3D rhs-&gt;=
host;</span><br><span>                 ce-&gt;remote_port =3D rhs-&gt;port;=
</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec</span><br><span>index 55e8105=2E=2E8a476e6 100644</span><br><span>--- =
a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span=
><br><span>@@ -784,7 +784,7 @@</span><br><span>         ASSERT(man-&gt;conn=
ection=2Eup_query_type);</span><br><span>         if (streq(man-&gt;connect=
ion=2Eup_query_type, type))</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            strncpynt(dest, string, len);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            strlcpy(=
dest, string, len);</span><br><span>             man_up_finalize(man);</spa=
n><br><span>             msg(M_CLIENT, &quot;SUCCESS: &#39;%s&#39; %s enter=
ed, but not yet verified&quot;, type, prompt);</span><br><span>         }</=
span><br><span>@@ -2374,7 +2374,7 @@</span><br><span>     }</span><br><span=
>     struct user_pass up;</span><br><span>     CLEAR(up);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(up=2Eusername, msg, size=
of(up=2Eusername));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    strlcpy(up=2Eusername, msg, sizeof(up=2Eusername));</span><br><span> </=
span><br><span>     management_query_user_pass(management, &amp;up, command=
, GET_USER_PASS_NEED_OK, (void *)0);</span><br><span>     return strcmp(&qu=
ot;ok&quot;, up=2Epassword) =3D=3D 0;</span><br><span>diff --git a/src/open=
vpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index 0e4669a=2E=2Ea75b=
d8f 100644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b=
/src/openvpn/misc=2Ec</span><br><span>@@ -303,7 +303,7 @@</span><br><span> =
</span><br><span>                 if (password_buf[0])</span><br><span>    =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             strncpynt(up-&gt;password, password_buf, USER_PASS_LEN);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    strlc=
py(up-&gt;password, password_buf, USER_PASS_LEN);</span><br><span>         =
        }</span><br><span>                 else</span><br><span>           =
      {</span><br><span>@@ -364,7 +364,7 @@</span><br><span>               =
      {</span><br><span>                         msg(M_FATAL, &quot;ERROR: =
could not read challenge response from stdin&quot;);</span><br><span>      =
               }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               strncpynt(up-&gt;username, ac-&gt;user, USER_PASS_LEN);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    strl=
cpy(up-&gt;username, ac-&gt;user, USER_PASS_LEN);</span><br><span>         =
            buf_printf(&amp;packed_resp, &quot;CRV1::%s::%s&quot;, ac-&gt;s=
tate_id, response);</span><br><span>                 }</span><br><span>    =
             else</span><br><span>@@ -452,7 +452,7 @@</span><br><span>     =
    /* Use tag for blank password if we are not prompting for one */</span>=
<br><span>         if (flags &amp; GET_USER_PASS_USERNAME_ONLY)</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      strncpynt(up-&gt;password, blank_up, sizeof(up-&gt;password));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            strlcpy(up-&gt=
;password, blank_up, sizeof(up-&gt;password));</span><br><span>         }</=
span><br><span> </span><br><span>         string_mod(up-&gt;username, CC_PR=
INT, CC_CRLF, 0);</span><br><span>@@ -504,7 +504,7 @@</span><br><span>     =
if (strlen(token))</span><br><span>     {</span><br><span>         unprotec=
t_user_pass(tk);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   strncpynt(tk-&gt;password, token, USER_PASS_LEN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        strlcpy(tk-&gt;password, token, U=
SER_PASS_LEN);</span><br><span>         tk-&gt;token_defined =3D true;</spa=
n><br><span> </span><br><span>         /*</span><br><span>diff --git a/src/=
openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index dda9232=2E=
=2Ea2b4e52 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -461,7 +461,7 @@</span><b=
r><span>     const char *prefix =3D multi_instance_string(mi, true, &amp;gc=
);</span><br><span>     if (prefix)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(mi-&gt;msg_prefix, p=
refix, sizeof(mi-&gt;msg_prefix));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        strlcpy(mi-&gt;msg_prefix, prefix, sizeof(mi-&gt;msg=
_prefix));</span><br><span>     }</span><br><span>     else</span><br><span=
>     {</span><br><span>@@ -2657,7 +2657,7 @@</span><br><span>         {</s=
pan><br><span>             struct user_pass up;</span><br><span>           =
  CLEAR(up);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   strncpynt(up=2Eusername, multi-&gt;locked_username, sizeof(up=2Eusername=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            strl=
cpy(up=2Eusername, multi-&gt;locked_username, sizeof(up=2Eusername));</span=
><br><span> </span><br><span>             generate_auth_token(&amp;up, mult=
i);</span><br><span>         }</span><br><span>diff --git a/src/openvpn/net=
working_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index =
d6510bb=2E=2E9f1e041 100644</span><br><span>--- a/src/openvpn/networking_si=
tnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><s=
pan>@@ -602,7 +602,7 @@</span><br><span> </span><br><span>     /* save resu=
lt in output variables */</span><br><span>     memcpy(best_gw, &amp;res=2Eg=
w, res=2Eaddr_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   strncpynt(best_iface, res=2Eiface, IFNAMSIZ);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    strlcpy(best_iface, res=2Eiface, IFNAMSIZ)=
;</span><br><span> err:</span><br><span>     return ret;</span><br><span> }=
</span><br><span>@@ -1424,7 +1424,7 @@</span><br><span>             return =
-ENOENT;</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        strncpynt(type, RTA_DATA(tb_link[IF=
LA_INFO_KIND]), IFACE_TYPE_LEN_MAX);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        strlcpy(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), I=
FACE_TYPE_LEN_MAX);</span><br><span>     }</span><br><span> </span><br><spa=
n>     return 0;</span><br><span>diff --git a/src/openvpn/openssl_compat=2E=
h b/src/openvpn/openssl_compat=2Eh</span><br><span>index 098bdd5=2E=2E49f24=
19 100644</span><br><span>--- a/src/openvpn/openssl_compat=2Eh</span><br><s=
pan>+++ b/src/openvpn/openssl_compat=2Eh</span><br><span>@@ -104,10 +104,10=
 @@</span><br><span>         curve =3D &quot;(error fetching curve name)&qu=
ot;;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    strncpynt(gname, curve, gname_sz);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(gname, curve, gname_=
sz);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* strncpynt ensures null termination so just strlen is fine here */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *gname_len =3D strl=
en(curve);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* st=
rlcpy ensures null termination so just strlen is fine here */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    *gname_len =3D strlen(gname);=
</span><br><span>     return 1;</span><br><span> }</span><br><span> #endif =
/* if OPENSSL_VERSION_NUMBER &lt; 0x30000000L &amp;&amp; !defined(OPENSSL_N=
O_EC) */</span><br><span>diff --git a/src/openvpn/options_string=2Ec b/src/=
openvpn/options_string=2Ec</span><br><span>index 88ab798=2E=2Ecfc0595 10064=
4</span><br><span>--- a/src/openvpn/options_string=2Ec</span><br><span>+++ =
b/src/openvpn/options_string=2Ec</span><br><span>@@ -385,9 +385,9 @@</span>=
<br><span> const char *</span><br><span> options_string_version(const char =
*s, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf_gc(4, gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt((char *)BPTR(&=
amp;out), s, 3);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn BSTR(&amp;out);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char *out =3D gc_malloc(3, false, gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    strlcpy(out, s, 3);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return out;</span><br><span> }</span><br><=
span> </span><br><span> #if defined(__GNUC__) || defined(__clang__)</span><=
br><span>diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span=
><br><span>index d7dee97=2E=2E09c8996 100644</span><br><span>--- a/src/open=
vpn/pkcs11=2Ec</span><br><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span=
>@@ -224,7 +224,7 @@</span><br><span>     }</span><br><span>     else</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    strncpynt(pin, token_pass=2Epassword, pin_max);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        strlcpy(pin, token_pass=2Epasswor=
d, pin_max);</span><br><span>         purge_user_pass(&amp;token_pass, true=
);</span><br><span> </span><br><span>         if (strlen(pin) =3D=3D 0)</sp=
an><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</sp=
an><br><span>index 9209a76=2E=2E60a1f5b 100644</span><br><span>--- a/src/op=
envpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span=
>@@ -2968,7 +2968,7 @@</span><br><span> </span><br><span>     if (msg=2Eifa=
ce=2Eindex =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(msg=2Eiface=
=2Ename, tt-&gt;actual_name, sizeof(msg=2Eiface=2Ename));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        strlcpy(msg=2Eiface=2Ename, t=
t-&gt;actual_name, sizeof(msg=2Eiface=2Ename));</span><br><span>     }</spa=
n><br><span> </span><br><span>     status =3D do_route_service(add, &amp;ms=
g, sizeof(msg), tt-&gt;options=2Emsg_channel);</span><br><span>@@ -3137,7 +=
3137,7 @@</span><br><span>                 addr =3D ntohl(((struct sockaddr=
_in *)&amp;ifr-&gt;ifr_addr)-&gt;sin_addr=2Es_addr);</span><br><span> </spa=
n><br><span>                 /* get interface name */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                strncpynt(ifreq=2Eifr_name,=
 ifr-&gt;ifr_name, sizeof(ifreq=2Eifr_name));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                strlcpy(ifreq=2Eifr_name, ifr-&gt=
;ifr_name, sizeof(ifreq=2Eifr_name));</span><br><span> </span><br><span>   =
              /* check that the interface is up */</span><br><span>        =
         if (ioctl(sd, SIOCGIFFLAGS, &amp;ifreq) &lt; 0)</span><br><span>@@=
 -3190,7 +3190,7 @@</span><br><span>                 }</span><br><span> </s=
pan><br><span>                 /* save iface name */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                strncpynt(rgi-&gt;iface, if=
req=2Eifr_name, sizeof(rgi-&gt;iface));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                strlcpy(rgi-&gt;iface, ifreq=2Eifr_name=
, sizeof(rgi-&gt;iface));</span><br><span>                 rgi-&gt;flags |=
=3D RGI_IFACE_DEFINED;</span><br><span> </span><br><span>                 /=
* now get the hardware address=2E */</span><br><span>@@ -3458,7 +3458,7 @@<=
/span><br><span> </span><br><span>         CLEAR(ifr);</span><br><span>    =
     ifr=2Eifr_addr=2Esa_family =3D AF_INET;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        strncpynt(ifr=2Eifr_name, rgi-&gt;iface, IFN=
AMSIZ);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strl=
cpy(ifr=2Eifr_name, rgi-&gt;iface, IFNAMSIZ);</span><br><span> </span><br><=
span>         if (ioctl(sockfd, SIOCGIFNETMASK, (char *)&amp;ifr) &lt; 0)</=
span><br><span>         {</span><br><span>@@ -3487,7 +3487,7 @@</span><br><=
span>         struct ifreq ifreq =3D { 0 };</span><br><span> </span><br><sp=
an>         /* now get the hardware address=2E */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        strncpynt(ifreq=2Eifr_name, rgi-&gt;ifa=
ce, sizeof(ifreq=2Eifr_name));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        strlcpy(ifreq=2Eifr_name, rgi-&gt;iface, sizeof(ifreq=2E=
ifr_name));</span><br><span>         if (ioctl(sockfd, SIOCGIFHWADDR, &amp;=
ifreq) &lt; 0)</span><br><span>         {</span><br><span>             msg(=
M_WARN, &quot;GDG: SIOCGIFHWADDR(%s) failed&quot;, ifreq=2Eifr_name);</span=
><br><span>@@ -3746,7 +3746,7 @@</span><br><span>         {</span><br><span=
>             rgi-&gt;gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)route=
=2Egateway)-&gt;sin_addr=2Es_addr);</span><br><span>             rgi-&gt;fl=
ags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            strncpynt(rgi-&gt;iface, interface-&gt;=
ifr_name, sizeof(rgi-&gt;iface));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            strlcpy(rgi-&gt;iface, interface-&gt;ifr_name, si=
zeof(rgi-&gt;iface));</span><br><span>         }</span><br><span> </span><b=
r><span>         int32 address_size =3D 0;</span><br><span>diff --git a/src=
/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 33def4e=
=2E=2E0c585ad 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br=
><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -3077,7 +3077,7 @@</=
span><br><span> sockaddr_unix_init(struct sockaddr_un *local, const char *p=
ath)</span><br><span> {</span><br><span>     local-&gt;sun_family =3D PF_UN=
IX;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(loca=
l-&gt;sun_path, path, sizeof(local-&gt;sun_path));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    strlcpy(local-&gt;sun_path, path, sizeof=
(local-&gt;sun_path));</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/soc=
ks=2Ec</span><br><span>index b84da24=2E=2E781a5d9 100644</span><br><span>--=
- a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span=
><br><span>@@ -58,12 +58,12 @@</span><br><span>     ASSERT(server);</span><=
br><span>     ASSERT(port);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    strncpynt(p-&gt;server, server, sizeof(p-&gt;se=
rver));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy(=
p-&gt;server, server, sizeof(p-&gt;server));</span><br><span>     p-&gt;por=
t =3D port;</span><br><span> </span><br><span>     if (authfile)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
trncpynt(p-&gt;authfile, authfile, sizeof(p-&gt;authfile));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(p-&gt;authfile, aut=
hfile, sizeof(p-&gt;authfile));</span><br><span>     }</span><br><span>    =
 else</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index aeec020=2E=2E7b61725 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -272,7 +272,7 @@</span><br><span>         /* =
prompt for password even if --askpass wasn&#39;t specified */</span><br><sp=
an>         pem_password_setup(NULL);</span><br><span>         ASSERT(!pass=
buf=2Eprotected);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    strncpynt(buf, passbuf=2Epassword, (size_t)size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        strlcpy(buf, passbuf=2Epassword, =
(size_t)size);</span><br><span>         purge_user_pass(&amp;passbuf, false=
);</span><br><span> </span><br><span>         return (int)strlen(buf);</spa=
n><br><span>@@ -2228,7 +2228,7 @@</span><br><span>         if (session-&gt;=
opt-&gt;pull &amp;&amp; up !=3D &amp;auth_token)</span><br><span>         {=
</span><br><span>             unprotect_user_pass(&amp;auth_token);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            strncpynt(auth_to=
ken=2Eusername, up-&gt;username, USER_PASS_LEN);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            strlcpy(auth_token=2Eusername, up-=
&gt;username, USER_PASS_LEN);</span><br><span>             protect_user_pas=
s(&amp;auth_token);</span><br><span>         }</span><br><span>         pro=
tect_user_pass(up);</span><br><span>diff --git a/src/openvpn/ssl_openssl=2E=
c b/src/openvpn/ssl_openssl=2Ec</span><br><span>index 02fd556=2E=2E2d0be92 =
100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>++=
+ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -427,15 +427,14 @@</span=
><br><span>      * historically used names with - in them=2E Silently conve=
rt names</span><br><span>      * with - to names with _ to support both</sp=
an><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (strlen(ciphers) &gt;=3D (len - 1))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    size_t ciphers_len =3D strlcpy(openssl_ciphers, =
ciphers, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (ciphers_len &gt;=3D len)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;Failed to set restr=
icted TLS 1=2E3 cipher list, too long (&gt;%zd)=2E&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;Failed to =
set restricted TLS 1=2E3 cipher list, too long (&gt;%zu)=2E&quot;,</span><b=
r><span>             len - 1);</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(openssl_cip=
hers, ciphers, len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (size_t i =3D =
0; i &lt; strlen(openssl_ciphers); i++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; ciphers_len; i++)</span=
><br><span>     {</span><br><span>         if (openssl_ciphers[i] =3D=3D &#=
39;-&#39;)</span><br><span>         {</span><br><span>diff --git a/src/open=
vpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 43ed9=
80=2E=2Ebdcb8fc 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</sp=
an><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1640,7 +1=
640,7 @@</span><br><span>             &quot;TLS: Replacing client provided =
username &#39;%s&#39; with &quot;</span><br><span>             &quot;userna=
me from override-user &#39;%s&#39;&quot;,</span><br><span>             up-&=
gt;username, multi-&gt;locked_username);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        strncpynt(up-&gt;username, multi-&gt;locked_user=
name, sizeof(up-&gt;username));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        strlcpy(up-&gt;username, multi-&gt;locked_username, siz=
eof(up-&gt;username));</span><br><span>     }</span><br><span> </span><br><=
span>     /*</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2E=
c b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index 6073e4e=2E=2E1=
46a384 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -15=
7,14 +157,16 @@</span><br><span>                     if ((ssize_t)strlen(bu=
f) !=3D ASN1_STRING_length(name-&gt;d=2Erfc822Name))</span><br><span>      =
               {</span><br><span>                         msg(D_TLS_ERRORS,=
 &quot;ASN1 ERROR: string contained terminating zero&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                        OPENSSL_free=
(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         else if (strlcpy(out, buf, size) &gt;=3D size)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        msg(D_TLS_ERR=
ORS, &quot;ASN1 ERROR: string too long&quot;);</span><br><span>            =
         }</span><br><span>                     else</span><br><span>      =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   strncpynt(out, buf, size);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                        OPENSSL_free(buf);</span><b=
r><span>                         retval =3D true;</span><br><span>         =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              OPENSSL_free(buf);</span><br><span>                     break=
;</span><br><span> </span><br><span>                 default:</span><br><sp=
an>@@ -243,9 +245,7 @@</span><br><span>         goto exit;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    strncpynt(out, (char *)buf, size);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D (strlcpy(out, (char=
 *)buf, size) &lt; size) ? SUCCESS : FAILURE;</span><br><span> </span><br><=
span> exit:</span><br><span>     OPENSSL_free(buf);</span><br><span>diff --=
git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 9e7e7=
d7=2E=2E478c109 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br>=
<span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -127,7 +127,7 @@</span><=
br><span> </span><br><span>     if (addr=2Eiface=2Eindex =3D=3D TUN_ADAPTER=
_INDEX_INVALID)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        strncpynt(addr=2Eiface=2Ename, tt-&gt;actual_name,=
 sizeof(addr=2Eiface=2Ename));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        strlcpy(addr=2Eiface=2Ename, tt-&gt;actual_name, sizeof(=
addr=2Eiface=2Ename));</span><br><span>     }</span><br><span> </span><br><=
span>     if (addr=2Efamily =3D=3D AF_INET)</span><br><span>@@ -188,12 +188=
,12 @@</span><br><span>     };</span><br><span> </span><br><span>     /* in=
terface name is required */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    strncpynt(dns=2Eiface=2Ename, tt-&gt;actual_name, sizeof(dns=2Eif=
ace=2Ename));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
rlcpy(dns=2Eiface=2Ename, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename));<=
/span><br><span> </span><br><span>     /* only use domain when there are no=
 search domains */</span><br><span>     if (o-&gt;domain &amp;&amp; !o-&gt;=
domain_search_list[0])</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        strncpynt(dns=2Edomains, o-&gt;domain, size=
of(dns=2Edomains));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        strlcpy(dns=2Edomains, o-&gt;domain, sizeof(dns=2Edomains));</span>=
<br><span>     }</span><br><span> </span><br><span>     /* Create a comma s=
eparated list of search domains */</span><br><span>@@ -260,7 +260,7 @@</spa=
n><br><span>                               =2Eaddr_len =3D addr_len };</spa=
n><br><span> </span><br><span>     /* interface name is required */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(dns=2Eiface=2En=
ame, tt-&gt;actual_name, sizeof(dns=2Eiface=2Ename));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    strlcpy(dns=2Eiface=2Ename, tt-&gt;ac=
tual_name, sizeof(dns=2Eiface=2Ename));</span><br><span> </span><br><span> =
    if (addr_len &gt; _countof(dns=2Eaddr))</span><br><span>     {</span><b=
r><span>@@ -324,7 +324,7 @@</span><br><span>                               =
  =2Eaddr_len =3D addr_len };</span><br><span> </span><br><span>     /* int=
erface name is required */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    strncpynt(wins=2Eiface=2Ename, tt-&gt;actual_name, sizeof(wins=2Ei=
face=2Ename));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
trlcpy(wins=2Eiface=2Ename, tt-&gt;actual_name, sizeof(wins=2Eiface=2Ename)=
);</span><br><span> </span><br><span>     if (addr_len &gt; _countof(wins=
=2Eaddr))</span><br><span>     {</span><br><span>@@ -372,7 +372,7 @@</span>=
<br><span>                                   =2Eiface =3D { =2Eindex =3D tt=
-&gt;adapter_index },</span><br><span>                                   =
=2Emtu =3D mtu,</span><br><span>                                   =2Efamil=
y =3D family };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
rncpynt(mtu_msg=2Eiface=2Ename, tt-&gt;actual_name, sizeof(mtu_msg=2Eiface=
=2Ename));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlc=
py(mtu_msg=2Eiface=2Ename, tt-&gt;actual_name, sizeof(mtu_msg=2Eiface=2Enam=
e));</span><br><span>     if (family =3D=3D AF_INET6 &amp;&amp; mtu &lt; 12=
80)</span><br><span>     {</span><br><span>         msg(M_INFO,</span><br><=
span>@@ -2119,7 +2119,7 @@</span><br><span>          */</span><br><span>   =
      if (strcmp(dev, &quot;tun&quot;) &amp;&amp; strcmp(dev, &quot;tap&quo=
t;))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            strncpynt(ifr=2Eifr_name, dev, IFNAMSIZ);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            strlcpy(ifr=2Eifr_n=
ame, dev, IFNAMSIZ);</span><br><span>         }</span><br><span> </span><br=
><span>         /*</span><br><span>@@ -2145,7 +2145,7 @@</span><br><span>  =
           if ((ctl_fd =3D socket(AF_INET, SOCK_DGRAM, 0)) &gt;=3D 0)</span=
><br><span>             {</span><br><span>                 CLEAR(netifr);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                strncpy=
nt(netifr=2Eifr_name, ifr=2Eifr_name, IFNAMSIZ);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                strlcpy(netifr=2Eifr_name, ifr=
=2Eifr_name, IFNAMSIZ);</span><br><span>                 netifr=2Eifr_qlen =
=3D tt-&gt;options=2Etxqueuelen;</span><br><span>                 if (ioctl=
(ctl_fd, SIOCSIFTXQLEN, (void *)&amp;netifr) &gt;=3D 0)</span><br><span>   =
              {</span><br><span>@@ -2401,7 +2401,7 @@</span><br><span>     =
    {</span><br><span>             msg(M_ERR, &quot;Can&#39;t get flags&quo=
t;);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        strncpynt(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=
=2Elifr_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    strlcpy(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));<=
/span><br><span>         ifr=2Elifr_ppa =3D ppa;</span><br><span>         /=
* Assign ppa according to the unit number returned by tun device */</span><=
br><span>         if (ioctl(if_fd, SIOCSLIFNAME, &amp;ifr) &lt; 0)</span><b=
r><span>@@ -2469,7 +2469,7 @@</span><br><span>     }</span><br><span> </spa=
n><br><span>     CLEAR(ifr);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    strncpynt(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr=
_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strlcpy=
(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elifr_name));</span><br><=
span>     ifr=2Elifr_ip_muxid =3D ip_muxid;</span><br><span>     if (tt-&gt=
;type =3D=3D DEV_TYPE_TAP)</span><br><span>     {</span><br><span>@@ -2510,=
7 +2510,7 @@</span><br><span>     {</span><br><span>         struct lifreq =
ifr;</span><br><span>         CLEAR(ifr);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        strncpynt(ifr=2Elifr_name, tt-&gt;actual_name, =
sizeof(ifr=2Elifr_name));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        strlcpy(ifr=2Elifr_name, tt-&gt;actual_name, sizeof(ifr=2Elif=
r_name));</span><br><span> </span><br><span>         if (ioctl(tt-&gt;ip_fd=
, SIOCGLIFFLAGS, &amp;ifr) &lt; 0)</span><br><span>         {</span><br><sp=
an>diff --git a/src/openvpn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec</=
span><br><span>index 69be67a=2E=2E1149c7b 100644</span><br><span>--- a/src/=
openvpn/xkey_helper=2Ec</span><br><span>+++ b/src/openvpn/xkey_helper=2Ec</=
span><br><span>@@ -198,7 +198,7 @@</span><br><span>     {</span><br><span> =
        if (!strcmp(alg=2Eop, &quot;Sign&quot;))</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            strncpynt=
(alg_str, &quot;ECDSA&quot;, sizeof(alg_str));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            strlcpy(alg_str, &quot;ECDSA&quot;, =
sizeof(alg_str));</span><br><span>         }</span><br><span>         else<=
/span><br><span>         {</span><br><span>@@ -207,7 +207,7 @@</span><br><s=
pan>     }</span><br><span>     else if (!strcmp(alg=2Ekeytype, &quot;ED448=
&quot;) || !strcmp(alg=2Ekeytype, &quot;ED25519&quot;))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(=
alg_str, alg=2Ekeytype, sizeof(alg_str));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        strlcpy(alg_str, alg=2Ekeytype, sizeof(alg_st=
r));</span><br><span>     }</span><br><span>     /* else assume RSA key */<=
/span><br><span>     else if (!strcmp(alg=2Epadmode, &quot;pkcs1&quot;) &am=
p;&amp; (flags &amp; MF_EXTERNAL_KEY_PKCS1PAD))</span><br><span>@@ -221,7 +=
221,7 @@</span><br><span>             }</span><br><span>             tbs =
=3D enc;</span><br><span>             tbslen =3D enc_len;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            strncpynt(alg_str, &quot;RS=
A_PKCS1_PADDING&quot;, sizeof(alg_str));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            strlcpy(alg_str, &quot;RSA_PKCS1_PADDING&q=
uot;, sizeof(alg_str));</span><br><span>         }</span><br><span>        =
 /* For undigested message, add hashalg=3Ddigest parameter */</span><br><sp=
an>         else</span><br><span>@@ -232,7 +232,7 @@</span><br><span>     e=
lse if (!strcmp(alg=2Epadmode, &quot;none&quot;) &amp;&amp; (flags &amp; MF=
_EXTERNAL_KEY_NOPADDING)</span><br><span>              &amp;&amp; !strcmp(a=
lg=2Eop, &quot;Sign&quot;)) /* NO_PADDING requires digested data */</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  strncpynt(alg_str, &quot;RSA_NO_PADDING&quot;, sizeof(alg_str));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(alg_str, &qu=
ot;RSA_NO_PADDING&quot;, sizeof(alg_str));</span><br><span>     }</span><br=
><span>     else if (!strcmp(alg=2Epadmode, &quot;pss&quot;) &amp;&amp; (fl=
ags &amp; MF_EXTERNAL_KEY_PSSPAD))</span><br><span>     {</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_auth_token=2Ec b/tests/unit_tests=
/openvpn/test_auth_token=2Ec</span><br><span>index 89c418e=2E=2E3a3bfb4 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_auth_token=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_auth_token=2Ec</span><br><s=
pan>@@ -273,7 +273,7 @@</span><br><span>     }</span><br><span>     else if=
 (streq(name, &quot;session_id&quot;))</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(last_session_id_v=
alue, value, sizeof(last_session_id_value));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        strlcpy(last_session_id_value, value, size=
of(last_session_id_value));</span><br><span>     }</span><br><span> }</span=
><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkc=
s11=2Ec b/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>index a5=
4c504=2E=2E3351eac 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_pkcs11=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11=2E=
c</span><br><span>@@ -164,7 +164,7 @@</span><br><span>     if (!strcmp(pref=
ix, &quot;pkcs11-id-request&quot;) &amp;&amp; flags &amp; GET_USER_PASS_NEE=
D_STR)</span><br><span>     {</span><br><span>         assert_true(pkcs11_i=
d_management);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 strncpynt(up-&gt;password, pkcs11_id_current, sizeof(up-&gt;password));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(up-&gt=
;password, pkcs11_id_current, sizeof(up-&gt;password));</span><br><span>   =
  }</span><br><span>     else if (flags &amp; GET_USER_PASS_PASSWORD_ONLY)<=
/span><br><span>     {</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><b=
r><span>index 5ad4730=2E=2Ed1b4c97 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_user_pass=2Ec</span><br><span>@@ -53,7 +53,7 @@</span><br><span> =
    for (int i =3D 0; i &lt; QUERY_USER_NUMSLOTS &amp;&amp; query_user[i]=
=2Eresponse !=3D NULL; i++)</span><br><span>     {</span><br><span>        =
 check_expected_ptr(query_user[i]=2Eprompt);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        strncpynt(query_user[i]=2Eresponse, mock_ptr=
_type(char *), query_user[i]=2Eresponse_len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        strlcpy(query_user[i]=2Eresponse, mock_pt=
r_type(char *), query_user[i]=2Eresponse_len);</span><br><span>     }</span=
><br><span> </span><br><span>     return mock();</span><br></pre><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Dem=
ail">change 1995</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1995?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1995 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--+/a6UlLnw5o=--


--===============0694038402508991912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0694038402508991912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0694038402508991912==--

