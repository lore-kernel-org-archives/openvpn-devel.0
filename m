Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61E5C88E66
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y+OA9p1xLTqI9Ns9NP1UoEbIAEo/sSXc3MzJMRs67+c=; b=XrSMpUo5aD1a7pHDb1WhckYFZY
	1wJsBuWUFz7T2mWj9UmgEIqQ/rG4ucj4YSmRLaWwjAeUl05I6Vwgkp9cDP3KaUTDbpUImfxApAkI4
	YmrfuwFrBE3Qh4W6luS/hvwcOft0IwIWdi6OB4AojIBoRg+PPz4JCAlWqFqMtIE7uMa4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5jur-0006ca-TC;
	Sun, 13 Sep 2026 13:06:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5juo-0006cU-Le
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:06:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9qVy0IpvKZXwqvFqneM1xYlIKx4LYGONbup7TncGQ94=; b=JFYGihZ1uZIrGurIm2WSjcrkX2
 Ypg0QVJbic3vjwaGusc+tQt2IXJCqbF6sNJR/t5f8+aWvxTA6pVzubHJnyOPpy0sZD21VCSaAULpa
 ksVozJ6c+Kwzm36feTu+Kh2x6DFF9XslPqM6ycAyBkIhus8S+iHXVuV+dLKNRHC2ifjo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9qVy0IpvKZXwqvFqneM1xYlIKx4LYGONbup7TncGQ94=; b=h
 7WBa+SRBrirAaTrwNN4R3AIUwwC8kJ947Irv7vFixyP7wNwduwSOE3GvuWLordPNKuWR+dB7MmnMY
 5id7vI0DQ/cq/KcQbtporqlnp5f3AF0E37cR5K4k+wGplo90tSXQenIRARWNRozUIeSxw6QcU2kLH
 VAcXfO3hDuoKQe0Q=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5jui-0006Cp-JP for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:06:36 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so7604075e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789304786; x=1789909586; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9qVy0IpvKZXwqvFqneM1xYlIKx4LYGONbup7TncGQ94=;
 b=CQVwSXdNy43dgLMqwAWsW0JFjzoKsy8IWC4w0C/kj2IVL0vKbcUevv0IEBYXKIwQyB
 2eJzMLBmTmG3wkZ+gRKSzjd4pdaf0v7bNy3UUp2ZHi/izur1Pqubg3+NBnzV3vCG1K91
 2xKWKKCaSAJzYLrM6CP+41rXkHwrh9msZ519iL1k2MtY93PNdDj/5tA6z7t68EH2sB3D
 sfzbJquJfOTMw/2dTIMi/UjwyCEW8Z2ycMbFhCXaA9EBhmWggKT3sB6yKJ6St56zRrUs
 ridD5wsiFSaUGFA6Tjpxmonv6D4ECxLOWC34c5HaKU+fa5kYiglYKEUYFVclftPCJGuX
 PQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789304786; x=1789909586;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9qVy0IpvKZXwqvFqneM1xYlIKx4LYGONbup7TncGQ94=;
 b=H4LyhO58j2+8ZDD2Xu6402B8HqyFWeTacD7bDzTx+uZajpl+q+Vk1zlNMMvjUr+qLJ
 NujA8Hk5pywBbZqEzLVqyDrbdVzVehT/2E/wBAuFsYMO2QVa9L94yMEhCELGtiBvnGku
 TExKUn4Dn42bAu1oeogbGlwHQo+i9le1haBvW9DHRIG5YIXmpBwsbQeOs+rqZ6qia351
 2Z+CoGH28qCPxJHmx1IcyI0S/vgNrsjGS5BYZmtjukwMqorqg2flRXo/8juIFpsTkH9r
 e+fezdeFEIoPc9o/YxBfwsup8NjIj5vefJAvRE2zuKkx+249HZFPZe0khIOl2SS6ijTr
 nHOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBww0zCPZzQqmZgholT51Mzp63ZDFGvXea0QbK5jj35yhlrgNdWN6qsI4fZb70XDk0rQiFsGmn+zOa9AkRtn@lists.sourceforge.net
X-Gm-Message-State: AFuF++kHq0rn9BJ5tr0p+XBEXNXTxcLSvksX8HbZdEfOUn8eFJLiLjBU
 BiEUQ+nAMP3bOHIDnjQw62AE5j49kosMXU2ApHltu9PlmQNdmW+RxUvdKSyvK9sLxTh9wVvg/jD
 N4hDFmVWJFPvPCsGmL5VgHs3dUfLiFZanE+fIhSwMbrZwmDtfyAPZ0qatW97bCuG8LAWW
X-Gm-Gg: AYBFou1DvSWTc51yPmyoAhbNnoKUOIv3VLZ91383N033+MEfzNa2mnZAzIQPg6r+QKw
 PodL16DkFs8Bl5b/EmePn///hGlLDU2Z3z1aLi6lJ+cdSYZ50yFls0bDIJ67twZw2qBbTOy0opu
 f/yMJNzZrJwHGczRLXPbojYJkHcclIWdQXs2fgcKsXitt1+JNUqbvJ37fdcAh9p+YJk7j01Btzt
 F9kw1nOXgrpbwCE+fD+2BwCKp3ZtEpIqyhAhmirWTVXOgubOoEwv8iKsfwo8C1Wj/rLdIE1N/3L
 agHWEH+wScVhKNxi/dl4D4oHBzmKbt6JKhGD2Ujl9pzHp7PmUv7m7uOayoSg3aoUk1flTJ+elF4
 ZVIb2sibJ53ASfHCflOTWyzMU/OKBwgOt2hdHbDcP8LZ9ZkgKreNZ5sYSWJ6QIyC+L/F+UJAyMO
 bucqvcQQW3k6RW0MfCo1aTyciqyqMecIngaa1gmV0HJ6bsujvBj9ZLRSNlpbNAKFUbXIb+J3UR2
 BBwVV6X9cbi/mDDzvUhpRl9PCbifxBDZtwVINAduB/3wC6qdcdooz7Q7jAL+gGJlZyN94k7OwDf
 Mws5ryvO6fvtxvqCgjo7kp2pG36SmK/vzreBoA+AFVp/cO4bxHQtpg1Q8aYGB+4=
X-Received: by 2002:a05:600c:4ecc:b0:49e:6be6:d783 with SMTP id
 5b1f17b1804b1-49e6be6d9dbmr146098375e9.0.1789304785828; 
 Sun, 13 Sep 2026 06:06:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adaee4sm350622555e9.14.2026.09.13.06.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 06:06:25 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 13:06:24 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: a57e39923d55987336f544ce0c1b3b42c35f0ec0
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5648005050205e57aee1c5f40b81b5835fe47277-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5jui-0006Cp-JP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0614431526862647432=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0614431526862647432==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Fl7irJ3Pb0M="; charset=UTF-8

--Fl7irJ3Pb0M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1617?usp=3Demail )

Change subject: Remove various useless assignments
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove variou=
s useless assignments

The values assigned by these are never actually used=

for something=2E

Identified by cppcheck=2E

Change-Id: Id0caa497c4ff1ad87=
43cb23f332f003b2d3393ed
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617
Message-Id: <20260912200747=2E26=
711-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg39142=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
M src/ope=
nvpn/console_builtin=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/error=2Eh
M=
 src/openvpn/forward=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/options=2Ec=

M src/openvpn/pkcs11=2Ec
M src/openvpn/pkcs11_openssl=2Ec
M src/openvpn/pu=
sh_util=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/op=
envpn/win32=2Ec
M src/openvpnmsica/openvpnmsica=2Ec
M src/tapctl/tap=2Ec
M =
tests/unit_tests/openvpn/test_ssl=2Ec
16 files changed, 43 insertions(+), 6=
3 deletions(-)




diff --git a/dev-tools/cppcheck-suppression b/dev-tools/=
cppcheck-suppression
index e1ffe37=2E=2E299d7a3 100644
--- a/dev-tools/cppc=
heck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -5,9 +5,6 @@
 cons=
tParameterPointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
-re=
dundantAssignment
-redundantInitialization
-unreadVariable
 unusedFunction
=
 usleepCalled
 variableScope
@@ -74,7 +71,7 @@
 # IGN: strlen(NULL) is not =
nice code, but seems to work
 nullPointerRedundantCheck:src/openvpn/init=2E=
c:301
 # FP: cppcheck doesn't understand ZeroMemory
-redundantAssignment:sr=
c/openvpnserv/interactive=2Ec:203
+redundantAssignment:src/openvpnserv/inte=
ractive=2Ec:204
 # IGN: We reuse the same variable name due to macro usage
=
 shadowVariable:src/openvpn/options=2Ec:1948
 shadowVariable:src/openvpn/op=
tions=2Ec:1966
diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/c=
onsole_builtin=2Ec
index 2a9f3b6=2E=2E9c8d72a 100644
--- a/src/openvpn/cons=
ole_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -192,7 +192,6 @@
 =
static bool
 get_console_input(const char *prompt, const bool echo, char *i=
nput, const int capacity)
 {
-    bool ret =3D false;
     ASSERT(prompt);
=
     ASSERT(input);
     ASSERT(capacity > 0);
@@ -200,8 +199,11 @@
 
 #if =
defined(_WIN32)
     return get_console_input_win32(prompt, echo, input, ca=
pacity);
-#elif defined(HAVE_TERMIOS_H)
+#elif !defined(HAVE_TERMIOS_H)
+  =
  msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prom=
pt);
+#else
     bool restore_tty =3D false;
+    bool ret =3D false;
     =
struct termios tty_tmp, tty_save;
 
     /* did we --daemon'ize before aski=
ng for passwords?
@@ -258,10 +260,8 @@
     }
 
     close_tty(fp);
-#else =
 /* if defined(_WIN32) */
-    msg(M_FATAL, "Sorry, but I can't get console=
 input on this OS (%s)", prompt);
-#endif /* if defined(_WIN32) */
     ret=
urn ret;
+#endif /* if defined(_WIN32) */
 }
 
 /**
diff --git a/src/openvp=
n/crypto=2Ec b/src/openvpn/crypto=2Ec
index 8bbc566=2E=2Ee5ad31a 100644
---=
 a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1204,8 +1204,6 @=
@
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     stru=
ct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     st=
ruct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
-    =
struct buffer buf =3D clear_buf();
-    void *buf_p;
 
     /* init work */=

     ASSERT(buf_init(&work, frame->buf=2Eheadroom));
@@ -1242,8 +1240,8 @@=

         prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy source to =
input buf */
-        buf =3D work;
-        buf_p =3D buf_write_alloc(&buf=
, BLENZ(&src));
+        struct buffer buf =3D work;
+        void *buf_p =
=3D buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
         me=
mcpy(buf_p, BPTR(&src), BLENZ(&src));
 
diff --git a/src/openvpn/error=2Eh =
b/src/openvpn/error=2Eh
index 45826a2=2E=2Ea887fc7 100644
--- a/src/openvpn=
/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -408,8 +408,8 @@
 openvpn_errno_m=
aybe_crt(bool *crt_error)
 {
     int err =3D 0;
-    *crt_error =3D false;=

 #ifdef _WIN32
+    *crt_error =3D false;
     err =3D GetLastError();
   =
  if (err =3D=3D ERROR_SUCCESS)
     {
diff --git a/src/openvpn/forward=2Ec=
 b/src/openvpn/forward=2Ec
index ad43d40=2E=2E83cd113 100644
--- a/src/open=
vpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -1746,7 +1746,6 @@
 proces=
s_outgoing_link(struct context *c, struct link_socket *sock)
 {
     struct=
 gc_arena gc =3D gc_new();
-    int error_code =3D 0;
 
     if (c->c2=2Eto=
_link=2Elen > 0 && c->c2=2Eto_link=2Elen <=3D c->c2=2Eframe=2Ebuf=2Epayload=
_size)
     {
@@ -1821,7 +1820,7 @@
         }
 
         /* Check return s=
tatus */
-        error_code =3D openvpn_errno();
+        int error_code =
=3D openvpn_errno();
         check_status(size, "write", sock, NULL);
 
  =
       if (size > 0)
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/mana=
ge=2Ec
index 3039f24=2E=2Ee121b38 100644
--- a/src/openvpn/manage=2Ec
+++ b=
/src/openvpn/manage=2Ec
@@ -916,10 +916,9 @@
 static void
 man_remote_entry=
_count(struct management *man)
 {
-    unsigned count =3D 0;
     if (man->=
persist=2Ecallback=2Eremote_entry_count)
     {
-        count =3D (*man->p=
ersist=2Ecallback=2Eremote_entry_count)(man->persist=2Ecallback=2Earg);
+  =
      unsigned int count =3D (*man->persist=2Ecallback=2Eremote_entry_count=
)(man->persist=2Ecallback=2Earg);
         msg(M_CLIENT, "%u", count);
    =
     msg(M_CLIENT, "END");
     }
@@ -3743,7 +3742,6 @@
     struct gc_aren=
a gc =3D gc_new();
     int ret =3D 0;
     volatile int signal_received =
=3D 0;
-    struct buffer alert_msg =3D clear_buf();
     const bool standa=
lone_disabled_save =3D man->persist=2Estandalone_disabled;
     struct man_=
connection *mc =3D &man->connection;
 
@@ -3755,6 +3753,7 @@
 
         *st=
ate =3D EKS_SOLICIT;
 
+        struct buffer alert_msg;
         if (b64_d=
ata)
         {
             alert_msg =3D alloc_buf_gc(strlen(b64_data) + =
strlen(prompt) + 3, &gc);
diff --git a/src/openvpn/options=2Ec b/src/openvp=
n/options=2Ec
index 25a3746=2E=2E15f2fcd 100644
--- a/src/openvpn/options=
=2Ec
+++ b/src/openvpn/options=2Ec
@@ -4157,8 +4157,7 @@
 bool
 key_is_exte=
rnal(const struct options *options)
 {
-    bool ret =3D false;
-    ret =
=3D ret || (options->management_flags & MF_EXTERNAL_KEY);
+    bool ret =3D=
 options->management_flags & MF_EXTERNAL_KEY;
 #ifdef ENABLE_PKCS11
     re=
t =3D ret || (options->pkcs11_providers[0] !=3D NULL);
 #endif
@@ -5697,7 +=
5696,6 @@
             if (streq(p[1], "FORWARD_COMPATIBLE") && p[2] && str=
eq(p[2], "1"))
             {
                 options->forward_compatible =
=3D true;
-                msglevel_fc =3D msglevel_forward_compatible(opti=
ons, msglevel);
             }
             setenv_str(es, p[1], p[2] ? p[2=
] : "");
         }
diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs1=
1=2Ec
index 8b06fd0=2E=2Ed7dee97 100644
--- a/src/openvpn/pkcs11=2Ec
+++ b/=
src/openvpn/pkcs11=2Ec
@@ -80,6 +80,9 @@
 static msglvl_t
 _pkcs11_msg_pkcs=
112openvpn(const unsigned flags)
 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    =
return M_INFO;
+#else
     msglvl_t openvpn_flags;
 
     switch (flags)
@@=
 -109,16 +112,16 @@
             break;
     }
 
-#if defined(ENABLE_PKCS11=
_FORCE_DEBUG)
-    openvpn_flags =3D M_INFO;
-#endif
-
     return openvpn_=
flags;
+#endif
 }
 
 static unsigned
 _pkcs11_msg_openvpn2pkcs11(const msgl=
vl_t flags)
 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    return PKCS11H_LOG_DE=
BUG2;
+#else
     unsigned pkcs11_flags;
 
     if ((flags & D_PKCS11_DEBUG=
) !=3D 0)
@@ -146,11 +149,8 @@
         pkcs11_flags =3D PKCS11H_LOG_ERROR;=

     }
 
-#if defined(ENABLE_PKCS11_FORCE_DEBUG)
-    pkcs11_flags =3D PKC=
S11H_LOG_DEBUG2;
-#endif
-
     return pkcs11_flags;
+#endif
 }
 
 static v=
oid
diff --git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openss=
l=2Ec
index b6c1624=2E=2E69c5a50 100644
--- a/src/openvpn/pkcs11_openssl=2E=
c
+++ b/src/openvpn/pkcs11_openssl=2Ec
@@ -384,7 +384,6 @@
     if (certifi=
cate !=3D NULL)
     {
         pkcs11h_certificate_freeCertificate(certifi=
cate);
-        certificate =3D NULL;
     }
 
     /*
@@ -400,7 +399,6 @@
=
     if (openssl_session !=3D NULL)
     {
         pkcs11h_openssl_freeSes=
sion(openssl_session);
-        openssl_session =3D NULL;
     }
     retur=
n ret;
 #endif                                                          /* =
ifdef HAVE_XKEY_PROVIDER */
diff --git a/src/openvpn/push_util=2Ec b/src/op=
envpn/push_util=2Ec
index fcc5411=2E=2E0213041 100644
--- a/src/openvpn/pus=
h_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -99,7 +99,6 @@
     }
 
     =
char *str =3D gc_strdup(s, gc);
-    size_t i =3D 0;
 
     while (*str)
  =
   {
@@ -112,11 +111,11 @@
                 /* if no commas were found go t=
o fail, do not send any message */
                 return false;
         =
    }
+            /* copy from current position to (ci - 1) */
           =
  str[ci] =3D '\0';
-            /* copy from i to (ci -1) */
             =
struct buffer tmp =3D forge_msg(str, ",push-continuation 2", gc);
         =
    buffer_list_push(msgs, BSTR(&tmp));
-            i =3D ci + 1;
+       =
     str +=3D ci + 1;
         }
         else
         {
@@ -130,9 +129,8 =
@@
                 struct buffer tmp =3D forge_msg(str, NULL, gc);
       =
          buffer_list_push(msgs, BSTR(&tmp));
             }
-            i=
 =3D strlen(str);
+            break;
         }
-        str =3D &str[i];
=
     }
     return true;
 }
diff --git a/src/openvpn/socket=2Ec b/src/openv=
pn/socket=2Ec
index f6ebf10=2E=2E41c8bac 100644
--- a/src/openvpn/socket=2E=
c
+++ b/src/openvpn/socket=2Ec
@@ -790,7 +790,7 @@
      */
     socklen_t =
remote_len_af =3D af_addr_size(act->dest=2Eaddr=2Esa=2Esa_family);
     soc=
klen_t remote_len =3D sizeof(act->dest=2Eaddr);
-    socket_descriptor_t ne=
w_sd =3D SOCKET_UNDEFINED;
+    socket_descriptor_t new_sd;
 
     CLEAR(*a=
ct);
 
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=
=2Ec
index 0b01634=2E=2E7cfe9f4 100644
--- a/src/openvpn/ssl_openssl=2Ec
++=
+ b/src/openvpn/ssl_openssl=2Ec
@@ -2283,13 +2283,13 @@
     }
 
     int t=
ypeid =3D EVP_PKEY_id(pkey);
+
+#ifndef OPENSSL_NO_EC
 #if OPENSSL_VERSION_=
NUMBER < 0x30000000L
     bool is_ec =3D typeid =3D=3D EVP_PKEY_EC;
 #else
=
     bool is_ec =3D EVP_PKEY_is_a(pkey, "EC");
 #endif
-
-#ifndef OPENSSL_N=
O_EC
     char groupname[64];
     if (is_ec)
     {
@@ -2593,15 +2593,13 @=
@
            "builtin EC curves=2E It does not list additional curves nor =
X448 or X25519\n");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves =
=3D NULL;
-    size_t crv_len =3D 0;
-    size_t n =3D 0;
 
-    crv_len =
=3D EC_get_builtin_curves(NULL, 0);
+    size_t crv_len =3D EC_get_builtin_=
curves(NULL, 0);
     ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
     =
if (EC_get_builtin_curves(curves, crv_len))
     {
         printf("\nAvail=
able Elliptic curves/groups:\n");
-        for (n =3D 0; n < crv_len; n++)
=
+        for (size_t n =3D 0; n < crv_len; n++)
         {
             con=
st char *sname;
             sname =3D OBJ_nid2sn(curves[n]=2Enid);
diff --=
git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 94e79d5e=2E=2E618=
772d 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -134=
0,9 +1340,6 @@
     is_wow64_process2_t is_wow64_process2 =3D
         (is_=
wow64_process2_t)GetProcAddress(GetModuleHandle("Kernel32=2Edll"), "IsWow64=
Process2");
 
-    USHORT process_machine =3D 0;
-    USHORT native_machine=
 =3D 0;
-
 #ifdef _ARM64_
     *process_arch =3D ARCH_ARM64;
 #elif defined=
(_WIN64)
@@ -1350,6 +1347,8 @@
     if (is_wow64_process2)
     {
         =
/* this could be amd64 on arm64 */
+        USHORT process_machine =3D 0;
+=
        USHORT native_machine =3D 0;
         BOOL is_wow64 =3D is_wow64_pr=
ocess2(GetCurrentProcess(), &process_machine, &native_machine);
         if=
 (is_wow64 && native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)
         {
@@=
 -1362,6 +1361,8 @@
     if (is_wow64_process2)
     {
         /* check if=
 we're running on arm64 or amd64 machine */
+        USHORT process_machine=
 =3D 0;
+        USHORT native_machine =3D 0;
         BOOL is_wow64 =3D is=
_wow64_process2(GetCurrentProcess(), &process_machine, &native_machine);
  =
       if (is_wow64)
         {
diff --git a/src/openvpnmsica/openvpnmsica=
=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index 3911006=2E=2Ea861e8a 100644
=
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=
=2Ec
@@ -711,7 +711,6 @@
         uiResult =3D MsiViewFetch(hViewST, &hReco=
rd);
         if (uiResult =3D=3D ERROR_NO_MORE_ITEMS)
         {
-        =
    uiResult =3D ERROR_SUCCESS;
             break;
         }
         els=
e if (uiResult !=3D ERROR_SUCCESS)
diff --git a/src/tapctl/tap=2Ec b/src/ta=
pctl/tap=2Ec
index 769df6c=2E=2Edd22cc5 100644
--- a/src/tapctl/tap=2Ec
+++=
 b/src/tapctl/tap=2Ec
@@ -473,7 +473,7 @@
                         return E=
RROR_OUTOFMEMORY;
                     }
 
-                    dwCountExpR=
esult =3D ExpandEnvironmentStrings(szValue, szValueExp, dwCountExp);
+     =
               ExpandEnvironmentStrings(szValue, szValueExp, dwCountExp);
 =
                    free(szValue);
                     *pszValue =3D szVal=
ueExp;
                     return ERROR_SUCCESS;
@@ -601,8 +601,6 @@
     =
                    _In_ DWORD dwProperty, _Out_opt_ LPDWORD pdwPropertyReg=
DataType,
                         _Out_ LPVOID *ppData)
 {
-    DWORD dwRe=
sult =3D ERROR_BAD_ARGUMENTS;
-
     if (ppData =3D=3D NULL)
     {
       =
  return ERROR_BAD_ARGUMENTS;
@@ -628,7 +626,7 @@
     }
     else
     {
-=
        dwResult =3D GetLastError();
+        DWORD dwResult =3D GetLastErr=
or();
         if (dwResult =3D=3D ERROR_INSUFFICIENT_BUFFER)
         {
  =
           /* Allocate on heap and retry=2E */
diff --git a/tests/unit_test=
s/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index fcebcd=
b=2E=2E4baf8cc 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tes=
ts/unit_tests/openvpn/test_ssl=2Ec
@@ -217,7 +217,7 @@
 
 #if !defined(HAVE=
_OPENSSL_STORE)
     skip();
-#else  /* HAVE_OPENSSL_STORE */
+#else /* HAV=
E_OPENSSL_STORE */
 
     struct tls_root_ctx ctx =3D { 0 };
     const cha=
r *certfile =3D global_state=2Ecertfile;
@@ -228,9 +228,10 @@
     struct b=
uffer keyuri =3D alloc_buf_gc(6 + strlen(keyfile) + 1, gc);   /* 6 bytes fo=
r "file:/" */
 
     /* Windows temp file path starts with drive letter -- =
add a leading slash for URI */
-    const char *lead =3D "";
 #ifdef _WIN32=

-    lead =3D "/";
+    const char *lead =3D "/";
+#else
+    const char *=
lead =3D "";
 #endif /* _WIN32 */
     assert_true(buf_printf(&certuri, "fi=
le:%s%s", lead, certfile));
     assert_true(buf_printf(&keyuri, "file:%s%s=
", lead, keyfile));
@@ -292,8 +293,6 @@
     struct buffer work =3D alloc_b=
uf_gc(BUF_SIZE(&frame), &gc);
     struct buffer encrypt_workspace =3D allo=
c_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer decrypt_workspace =3D a=
lloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struct buffer buf =3D clear_buf();=

-    void *buf_p;
 
     /* init work */
     ASSERT(buf_init(&work, frame=
=2Ebuf=2Eheadroom));
@@ -314,8 +313,8 @@
         prng_bytes(BPTR(&src), BL=
EN(&src));
 
         /* copy source to input buf */
-        buf =3D work;=

-        buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
+        struct buf=
fer buf =3D work;
+        void *buf_p =3D buf_write_alloc(&buf, BLENZ(&src=
));
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLENZ(&src))=
;
 
@@ -345,7 +344,6 @@
     struct buffer encrypt_workspace =3D alloc_buf_=
gc(BUF_SIZE(&frame), &gc);
     struct buffer decrypt_workspace =3D alloc_b=
uf_gc(BUF_SIZE(&frame), &gc);
     struct buffer work =3D alloc_buf_gc(BUF_=
SIZE(&frame), &gc);
-    struct buffer buf =3D clear_buf();
     struct buf=
fer src =3D alloc_buf_gc(frame=2Ebuf=2Epayload_size, &gc);
     void *buf_p=
;
 
@@ -360,7 +358,7 @@
     prng_bytes(BPTR(&src), BLEN(&src));
 
     /* =
copy source to input buf */
-    buf =3D work;
+    struct buffer buf =3D w=
ork;
     buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);=

     memcpy(buf_p, BPTR(&src), BLENZ(&src));
@@ -641,7 +639,6 @@
     stru=
ct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer =
encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buff=
er decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struct b=
uffer buf =3D clear_buf();
     void *buf_p;
 
     /* init work */
@@ -658=
,7 +655,7 @@
     ASSERT(buf_write(&src, plaintext, strlen(plaintext)));
 
=
     /* copy source to input buf */
-    buf =3D work;
+    struct buffer b=
uf =3D work;
     buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
     ASSERT=
(buf_p);
     memcpy(buf_p, BPTR(&src), BLENZ(&src));

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
G=
errit-Change-Number: 1617
Gerrit-PatchSet: 22
Gerrit-Owner: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2Ecom>

--Fl7irJ3Pb0M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1617?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Remove various useless assignments<br><br>=
The values assigned by these are never actually used<br>for something=2E<br=
><br>Identified by cppcheck=2E<br><br>Change-Id: Id0caa497c4ff1ad8743cb23f3=
32f003b2d3393ed<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617<br>Message-Id: &l=
t;20260912200747=2E26711-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39142=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M dev-tools/cppcheck-suppression<br>M src/openvpn/console_builtin=2Ec<br>M=
 src/openvpn/crypto=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/forward=
=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/options=2Ec<br>M src/open=
vpn/pkcs11=2Ec<br>M src/openvpn/pkcs11_openssl=2Ec<br>M src/openvpn/push_ut=
il=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M sr=
c/openvpn/win32=2Ec<br>M src/openvpnmsica/openvpnmsica=2Ec<br>M src/tapctl/=
tap=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>16 files changed, 43 =
insertions(+), 63 deletions(-)<br><br></pre>
<pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppc=
heck-suppression b/dev-tools/cppcheck-suppression</span><br><span>index e1f=
fe37=2E=2E299d7a3 100644</span><br><span>--- a/dev-tools/cppcheck-suppressi=
on</span><br><span>+++ b/dev-tools/cppcheck-suppression</span><br><span>@@ =
-5,9 +5,6 @@</span><br><span> constParameterPointer</span><br><span> invali=
dPrintfArgType_sint</span><br><span> invalidPrintfArgType_uint</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-redundantAssignment</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-redundantInitialization</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-unreadVariable</span><br><span> un=
usedFunction</span><br><span> usleepCalled</span><br><span> variableScope</=
span><br><span>@@ -74,7 +71,7 @@</span><br><span> # IGN: strlen(NULL) is no=
t nice code, but seems to work</span><br><span> nullPointerRedundantCheck:s=
rc/openvpn/init=2Ec:301</span><br><span> # FP: cppcheck doesn&#39;t underst=
and ZeroMemory</span><br><span style=3D"color: hsl(0, 100%, 40%);">-redunda=
ntAssignment:src/openvpnserv/interactive=2Ec:203</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+redundantAssignment:src/openvpnserv/interactiv=
e=2Ec:204</span><br><span> # IGN: We reuse the same variable name due to ma=
cro usage</span><br><span> shadowVariable:src/openvpn/options=2Ec:1948</spa=
n><br><span> shadowVariable:src/openvpn/options=2Ec:1966</span><br><span>di=
ff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2E=
c</span><br><span>index 2a9f3b6=2E=2E9c8d72a 100644</span><br><span>--- a/s=
rc/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/openvpn/console_bu=
iltin=2Ec</span><br><span>@@ -192,7 +192,6 @@</span><br><span> static bool<=
/span><br><span> get_console_input(const char *prompt, const bool echo, cha=
r *input, const int capacity)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br><span>     ASS=
ERT(prompt);</span><br><span>     ASSERT(input);</span><br><span>     ASSER=
T(capacity &gt; 0);</span><br><span>@@ -200,8 +199,11 @@</span><br><span> <=
/span><br><span> #if defined(_WIN32)</span><br><span>     return get_consol=
e_input_win32(prompt, echo, input, capacity);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#elif defined(HAVE_TERMIOS_H)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#elif !defined(HAVE_TERMIOS_H)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;Sorry, =
but I can&#39;t get console input on this OS (%s)&quot;, prompt);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>     bo=
ol restore_tty =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    bool ret =3D false;</span><br><span>     struct termios tty_tmp, =
tty_save;</span><br><span> </span><br><span>     /* did we --daemon&#39;ize=
 before asking for passwords?</span><br><span>@@ -258,10 +260,8 @@</span><b=
r><span>     }</span><br><span> </span><br><span>     close_tty(fp);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(_WIN32)=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_FATAL, &=
quot;Sorry, but I can&#39;t get console input on this OS (%s)&quot;, prompt=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if define=
d(_WIN32) */</span><br><span>     return ret;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif /* if defined(_WIN32) */</span><br><span> =
}</span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/o=
penvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 8bbc566=2E=
=2Ee5ad31a 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><s=
pan>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1204,8 +1204,6 @@</spa=
n><br><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(frame), &amp;=
gc);</span><br><span>     struct buffer encrypt_workspace =3D alloc_buf_gc(=
BUF_SIZE(frame), &amp;gc);</span><br><span>     struct buffer decrypt_works=
pace =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    void *buf_p;</span><br><spa=
n> </span><br><span>     /* init work */</span><br><span>     ASSERT(buf_in=
it(&amp;work, frame-&gt;buf=2Eheadroom));</span><br><span>@@ -1242,8 +1240,=
8 @@</span><br><span>         prng_bytes(BPTR(&amp;src), BLEN(&amp;src));</=
span><br><span> </span><br><span>         /* copy source to input buf */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf =3D work;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_p =3D buf_wr=
ite_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        struct buffer buf =3D work;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        void *buf_p =3D buf_write_alloc(&=
amp;buf, BLENZ(&amp;src));</span><br><span>         ASSERT(buf_p);</span><b=
r><span>         memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/error=2Eh b/src/openvpn/er=
ror=2Eh</span><br><span>index 45826a2=2E=2Ea887fc7 100644</span><br><span>-=
-- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh</spa=
n><br><span>@@ -408,8 +408,8 @@</span><br><span> openvpn_errno_maybe_crt(bo=
ol *crt_error)</span><br><span> {</span><br><span>     int err =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    *crt_error =3D false;</=
span><br><span> #ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    *crt_error =3D false;</span><br><span>     err =3D GetLastErr=
or();</span><br><span>     if (err =3D=3D ERROR_SUCCESS)</span><br><span>  =
   {</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/for=
ward=2Ec</span><br><span>index ad43d40=2E=2E83cd113 100644</span><br><span>=
--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec=
</span><br><span>@@ -1746,7 +1746,6 @@</span><br><span> process_outgoing_li=
nk(struct context *c, struct link_socket *sock)</span><br><span> {</span><b=
r><span>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int error_code =3D 0;</span><br><span> </span><=
br><span>     if (c-&gt;c2=2Eto_link=2Elen &gt; 0 &amp;&amp; c-&gt;c2=2Eto_=
link=2Elen &lt;=3D c-&gt;c2=2Eframe=2Ebuf=2Epayload_size)</span><br><span> =
    {</span><br><span>@@ -1821,7 +1820,7 @@</span><br><span>         }</spa=
n><br><span> </span><br><span>         /* Check return status */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        error_code =3D openvpn_e=
rrno();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int =
error_code =3D openvpn_errno();</span><br><span>         check_status(size,=
 &quot;write&quot;, sock, NULL);</span><br><span> </span><br><span>        =
 if (size &gt; 0)</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src=
/openvpn/manage=2Ec</span><br><span>index 3039f24=2E=2Ee121b38 100644</span=
><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/m=
anage=2Ec</span><br><span>@@ -916,10 +916,9 @@</span><br><span> static void=
</span><br><span> man_remote_entry_count(struct management *man)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned =
count =3D 0;</span><br><span>     if (man-&gt;persist=2Ecallback=2Eremote_e=
ntry_count)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        count =3D (*man-&gt;persist=2Ecallback=2Eremote_entry_=
count)(man-&gt;persist=2Ecallback=2Earg);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        unsigned int count =3D (*man-&gt;persist=2Eca=
llback=2Eremote_entry_count)(man-&gt;persist=2Ecallback=2Earg);</span><br><=
span>         msg(M_CLIENT, &quot;%u&quot;, count);</span><br><span>       =
  msg(M_CLIENT, &quot;END&quot;);</span><br><span>     }</span><br><span>@@=
 -3743,7 +3742,6 @@</span><br><span>     struct gc_arena gc =3D gc_new();</=
span><br><span>     int ret =3D 0;</span><br><span>     volatile int signal=
_received =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct buffer alert_msg =3D clear_buf();</span><br><span>     const bool sta=
ndalone_disabled_save =3D man-&gt;persist=2Estandalone_disabled;</span><br>=
<span>     struct man_connection *mc =3D &amp;man-&gt;connection;</span><br=
><span> </span><br><span>@@ -3755,6 +3753,7 @@</span><br><span> </span><br>=
<span>         *state =3D EKS_SOLICIT;</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct buffer alert_msg;</span=
><br><span>         if (b64_data)</span><br><span>         {</span><br><spa=
n>             alert_msg =3D alloc_buf_gc(strlen(b64_data) + strlen(prompt)=
 + 3, &amp;gc);</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec</span><br><span>index 25a3746=2E=2E15f2fcd 100644</span=
><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/=
options=2Ec</span><br><span>@@ -4157,8 +4157,7 @@</span><br><span> bool</sp=
an><br><span> key_is_external(const struct options *options)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D =
false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ret=
 || (options-&gt;management_flags &amp; MF_EXTERNAL_KEY);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D options-&gt;manageme=
nt_flags &amp; MF_EXTERNAL_KEY;</span><br><span> #ifdef ENABLE_PKCS11</span=
><br><span>     ret =3D ret || (options-&gt;pkcs11_providers[0] !=3D NULL);=
</span><br><span> #endif</span><br><span>@@ -5697,7 +5696,6 @@</span><br><s=
pan>             if (streq(p[1], &quot;FORWARD_COMPATIBLE&quot;) &amp;&amp;=
 p[2] &amp;&amp; streq(p[2], &quot;1&quot;))</span><br><span>             {=
</span><br><span>                 options-&gt;forward_compatible =3D true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msglev=
el_fc =3D msglevel_forward_compatible(options, msglevel);</span><br><span> =
            }</span><br><span>             setenv_str(es, p[1], p[2] ? p[2]=
 : &quot;&quot;);</span><br><span>         }</span><br><span>diff --git a/s=
rc/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span>index 8b06fd=
0=2E=2Ed7dee97 100644</span><br><span>--- a/src/openvpn/pkcs11=2Ec</span><b=
r><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -80,6 +80,9 @@</spa=
n><br><span> static msglvl_t</span><br><span> _pkcs11_msg_pkcs112openvpn(co=
nst unsigned flags)</span><br><span> {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifdef ENABLE_PKCS11_FORCE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return M_INFO;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>     msglvl_t openv=
pn_flags;</span><br><span> </span><br><span>     switch (flags)</span><br><=
span>@@ -109,16 +112,16 @@</span><br><span>             break;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(ENABLE_PKCS11_FORCE_DEBUG)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    openvpn_flags =3D M_INFO;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>     return openvpn_flags;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><b=
r><span> </span><br><span> static unsigned</span><br><span> _pkcs11_msg_ope=
nvpn2pkcs11(const msglvl_t flags)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PKCS11_FORCE_DEBUG</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return PKCS11H_LOG_DEBUG=
2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><=
span>     unsigned pkcs11_flags;</span><br><span> </span><br><span>     if =
((flags &amp; D_PKCS11_DEBUG) !=3D 0)</span><br><span>@@ -146,11 +149,8 @@<=
/span><br><span>         pkcs11_flags =3D PKCS11H_LOG_ERROR;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(ENABLE_PKCS11_FORCE_DEBUG)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    pkcs11_flags =3D PKCS11H_LOG_DEBUG2;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     return pkcs11_flags;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }<=
/span><br><span> </span><br><span> static void</span><br><span>diff --git a=
/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec</span><br>=
<span>index b6c1624=2E=2E69c5a50 100644</span><br><span>--- a/src/openvpn/p=
kcs11_openssl=2Ec</span><br><span>+++ b/src/openvpn/pkcs11_openssl=2Ec</spa=
n><br><span>@@ -384,7 +384,6 @@</span><br><span>     if (certificate !=3D N=
ULL)</span><br><span>     {</span><br><span>         pkcs11h_certificate_fr=
eeCertificate(certificate);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        certificate =3D NULL;</span><br><span>     }</span><br><span>=
 </span><br><span>     /*</span><br><span>@@ -400,7 +399,6 @@</span><br><sp=
an>     if (openssl_session !=3D NULL)</span><br><span>     {</span><br><sp=
an>         pkcs11h_openssl_freeSession(openssl_session);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        openssl_session =3D NULL;</span=
><br><span>     }</span><br><span>     return ret;</span><br><span> #endif =
                                                         /* ifdef HAVE_XKEY=
_PROVIDER */</span><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/o=
penvpn/push_util=2Ec</span><br><span>index fcc5411=2E=2E0213041 100644</spa=
n><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openv=
pn/push_util=2Ec</span><br><span>@@ -99,7 +99,6 @@</span><br><span>     }</=
span><br><span> </span><br><span>     char *str =3D gc_strdup(s, gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t i =3D 0;</span><=
br><span> </span><br><span>     while (*str)</span><br><span>     {</span><=
br><span>@@ -112,11 +111,11 @@</span><br><span>                 /* if no co=
mmas were found go to fail, do not send any message */</span><br><span>    =
             return false;</span><br><span>             }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* copy from current posi=
tion to (ci - 1) */</span><br><span>             str[ci] =3D &#39;\0&#39;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* copy fr=
om i to (ci -1) */</span><br><span>             struct buffer tmp =3D forge=
_msg(str, &quot;,push-continuation 2&quot;, gc);</span><br><span>          =
   buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            i =3D ci + 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            str +=3D ci + 1;</span><br><span>   =
      }</span><br><span>         else</span><br><span>         {</span><br>=
<span>@@ -130,9 +129,8 @@</span><br><span>                 struct buffer tm=
p =3D forge_msg(str, NULL, gc);</span><br><span>                 buffer_lis=
t_push(msgs, BSTR(&amp;tmp));</span><br><span>             }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            i =3D strlen(str);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span>=
<br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       str =3D &amp;str[i];</span><br><span>     }</span><br><span>     ret=
urn true;</span><br><span> }</span><br><span>diff --git a/src/openvpn/socke=
t=2Ec b/src/openvpn/socket=2Ec</span><br><span>index f6ebf10=2E=2E41c8bac 1=
00644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/sr=
c/openvpn/socket=2Ec</span><br><span>@@ -790,7 +790,7 @@</span><br><span>  =
    */</span><br><span>     socklen_t remote_len_af =3D af_addr_size(act-&g=
t;dest=2Eaddr=2Esa=2Esa_family);</span><br><span>     socklen_t remote_len =
=3D sizeof(act-&gt;dest=2Eaddr);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    socket_descriptor_t new_sd =3D SOCKET_UNDEFINED;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    socket_descriptor_t new_sd;=
</span><br><span> </span><br><span>     CLEAR(*act);</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_open=
ssl=2Ec</span><br><span>index 0b01634=2E=2E7cfe9f4 100644</span><br><span>-=
-- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_open=
ssl=2Ec</span><br><span>@@ -2283,13 +2283,13 @@</span><br><span>     }</spa=
n><br><span> </span><br><span>     int typeid =3D EVP_PKEY_id(pkey);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifndef OPENSSL_NO_EC</span><br><span> #if OP=
ENSSL_VERSION_NUMBER &lt; 0x30000000L</span><br><span>     bool is_ec =3D t=
ypeid =3D=3D EVP_PKEY_EC;</span><br><span> #else</span><br><span>     bool =
is_ec =3D EVP_PKEY_is_a(pkey, &quot;EC&quot;);</span><br><span> #endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifndef OPENSSL_NO_EC</span><br><span>     char=
 groupname[64];</span><br><span>     if (is_ec)</span><br><span>     {</spa=
n><br><span>@@ -2593,15 +2593,13 @@</span><br><span>            &quot;built=
in EC curves=2E It does not list additional curves nor X448 or X25519\n&quo=
t;);</span><br><span> #ifndef OPENSSL_NO_EC</span><br><span>     EC_builtin=
_curve *curves =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    size_t crv_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    size_t n =3D 0;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    crv_len =3D EC_get_builtin_curves(NULL, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t crv_len =3D E=
C_get_builtin_curves(NULL, 0);</span><br><span>     ALLOC_ARRAY(curves, EC_=
builtin_curve, crv_len);</span><br><span>     if (EC_get_builtin_curves(cur=
ves, crv_len))</span><br><span>     {</span><br><span>         printf(&quot=
;\nAvailable Elliptic curves/groups:\n&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        for (n =3D 0; n &lt; crv_len; n++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        for (size_t n =3D 0=
; n &lt; crv_len; n++)</span><br><span>         {</span><br><span>         =
    const char *sname;</span><br><span>             sname =3D OBJ_nid2sn(cu=
rves[n]=2Enid);</span><br><span>diff --git a/src/openvpn/win32=2Ec b/src/op=
envpn/win32=2Ec</span><br><span>index 94e79d5e=2E=2E618772d 100644</span><b=
r><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=
=2Ec</span><br><span>@@ -1340,9 +1340,6 @@</span><br><span>     is_wow64_pr=
ocess2_t is_wow64_process2 =3D</span><br><span>         (is_wow64_process2_=
t)GetProcAddress(GetModuleHandle(&quot;Kernel32=2Edll&quot;), &quot;IsWow64=
Process2&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    USHORT process_machine =3D 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    USHORT native_machine =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _ARM64_</span>=
<br><span>     *process_arch =3D ARCH_ARM64;</span><br><span> #elif defined=
(_WIN64)</span><br><span>@@ -1350,6 +1347,8 @@</span><br><span>     if (is_=
wow64_process2)</span><br><span>     {</span><br><span>         /* this cou=
ld be amd64 on arm64 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        USHORT process_machine =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        USHORT native_machine =3D 0;</span><br><span>=
         BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(), &amp;proc=
ess_machine, &amp;native_machine);</span><br><span>         if (is_wow64 &a=
mp;&amp; native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)</span><br><span>  =
       {</span><br><span>@@ -1362,6 +1361,8 @@</span><br><span>     if (is_=
wow64_process2)</span><br><span>     {</span><br><span>         /* check if=
 we&#39;re running on arm64 or amd64 machine */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        USHORT process_machine =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        USHORT native_machine=
 =3D 0;</span><br><span>         BOOL is_wow64 =3D is_wow64_process2(GetCur=
rentProcess(), &amp;process_machine, &amp;native_machine);</span><br><span>=
         if (is_wow64)</span><br><span>         {</span><br><span>diff --gi=
t a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</=
span><br><span>index 3911006=2E=2Ea861e8a 100644</span><br><span>--- a/src/=
openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/src/openvpnmsica/openvp=
nmsica=2Ec</span><br><span>@@ -711,7 +711,6 @@</span><br><span>         uiR=
esult =3D MsiViewFetch(hViewST, &amp;hRecord);</span><br><span>         if =
(uiResult =3D=3D ERROR_NO_MORE_ITEMS)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            uiResult =3D ERROR_S=
UCCESS;</span><br><span>             break;</span><br><span>         }</spa=
n><br><span>         else if (uiResult !=3D ERROR_SUCCESS)</span><br><span>=
diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec</span><br><span>index =
769df6c=2E=2Edd22cc5 100644</span><br><span>--- a/src/tapctl/tap=2Ec</span>=
<br><span>+++ b/src/tapctl/tap=2Ec</span><br><span>@@ -473,7 +473,7 @@</spa=
n><br><span>                         return ERROR_OUTOFMEMORY;</span><br><s=
pan>                     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    dwCountExpResult =3D ExpandEnvir=
onmentStrings(szValue, szValueExp, dwCountExp);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    ExpandEnvironmentStrings(sz=
Value, szValueExp, dwCountExp);</span><br><span>                     free(s=
zValue);</span><br><span>                     *pszValue =3D szValueExp;</sp=
an><br><span>                     return ERROR_SUCCESS;</span><br><span>@@ =
-601,8 +601,6 @@</span><br><span>                         _In_ DWORD dwProp=
erty, _Out_opt_ LPDWORD pdwPropertyRegDataType,</span><br><span>           =
              _Out_ LPVOID *ppData)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    DWORD dwResult =3D ERROR_BAD_ARGUMENTS=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
  if (ppData =3D=3D NULL)</span><br><span>     {</span><br><span>         r=
eturn ERROR_BAD_ARGUMENTS;</span><br><span>@@ -628,7 +626,7 @@</span><br><s=
pan>     }</span><br><span>     else</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        dwResult =3D GetLastError();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD dwResu=
lt =3D GetLastError();</span><br><span>         if (dwResult =3D=3D ERROR_I=
NSUFFICIENT_BUFFER)</span><br><span>         {</span><br><span>            =
 /* Allocate on heap and retry=2E */</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span>=
<br><span>index fcebcdb=2E=2E4baf8cc 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_ssl=2Ec</span><br><span>@@ -217,7 +217,7 @@</span><br><span> </span><=
br><span> #if !defined(HAVE_OPENSSL_STORE)</span><br><span>     skip();</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* HAVE_OPENSSL_ST=
ORE */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* HAVE=
_OPENSSL_STORE */</span><br><span> </span><br><span>     struct tls_root_ct=
x ctx =3D { 0 };</span><br><span>     const char *certfile =3D global_state=
=2Ecertfile;</span><br><span>@@ -228,9 +228,10 @@</span><br><span>     stru=
ct buffer keyuri =3D alloc_buf_gc(6 + strlen(keyfile) + 1, gc);   /* 6 byte=
s for &quot;file:/&quot; */</span><br><span> </span><br><span>     /* Windo=
ws temp file path starts with drive letter -- add a leading slash for URI *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *lead=
 =3D &quot;&quot;;</span><br><span> #ifdef _WIN32</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    lead =3D &quot;/&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *lead =3D &quot;/&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *lead =3D &quot;&q=
uot;;</span><br><span> #endif /* _WIN32 */</span><br><span>     assert_true=
(buf_printf(&amp;certuri, &quot;file:%s%s&quot;, lead, certfile));</span><b=
r><span>     assert_true(buf_printf(&amp;keyuri, &quot;file:%s%s&quot;, lea=
d, keyfile));</span><br><span>@@ -292,8 +293,6 @@</span><br><span>     stru=
ct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><=
span>     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;fr=
ame), &amp;gc);</span><br><span>     struct buffer decrypt_workspace =3D al=
loc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    void *buf_p;</span><br><span> </s=
pan><br><span>     /* init work */</span><br><span>     ASSERT(buf_init(&am=
p;work, frame=2Ebuf=2Eheadroom));</span><br><span>@@ -314,8 +313,8 @@</span=
><br><span>         prng_bytes(BPTR(&amp;src), BLEN(&amp;src));</span><br><=
span> </span><br><span>         /* copy source to input buf */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        buf =3D work;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        buf_p =3D buf_write_alloc(=
&amp;buf, BLENZ(&amp;src));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct buffer buf =3D work;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        void *buf_p =3D buf_write_alloc(&amp;buf, B=
LENZ(&amp;src));</span><br><span>         ASSERT(buf_p);</span><br><span>  =
       memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span> </s=
pan><br><span>@@ -345,7 +344,6 @@</span><br><span>     struct buffer encryp=
t_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><spa=
n>     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame=
), &amp;gc);</span><br><span>     struct buffer work =3D alloc_buf_gc(BUF_S=
IZE(&amp;frame), &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct buffer buf =3D clear_buf();</span><br><span>     struct buf=
fer src =3D alloc_buf_gc(frame=2Ebuf=2Epayload_size, &amp;gc);</span><br><s=
pan>     void *buf_p;</span><br><span> </span><br><span>@@ -360,7 +358,7 @@=
</span><br><span>     prng_bytes(BPTR(&amp;src), BLEN(&amp;src));</span><br=
><span> </span><br><span>     /* copy source to input buf */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    buf =3D work;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D work;</span>=
<br><span>     buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span>=
<br><span>     ASSERT(buf_p);</span><br><span>     memcpy(buf_p, BPTR(&amp;=
src), BLENZ(&amp;src));</span><br><span>@@ -641,7 +639,6 @@</span><br><span=
>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</=
span><br><span>     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SI=
ZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer decrypt_worksp=
ace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</spa=
n><br><span>     void *buf_p;</span><br><span> </span><br><span>     /* ini=
t work */</span><br><span>@@ -658,7 +655,7 @@</span><br><span>     ASSERT(b=
uf_write(&amp;src, plaintext, strlen(plaintext)));</span><br><span> </span>=
<br><span>     /* copy source to input buf */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    buf =3D work;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D work;</span><br><span>     =
buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>     =
ASSERT(buf_p);</span><br><span>     memcpy(buf_p, BPTR(&amp;src), BLENZ(&am=
p;src));</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">change 1617</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id0caa497c4ff1=
ad8743cb23f332f003b2d3393ed </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1617 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2=
 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--Fl7irJ3Pb0M=--


--===============0614431526862647432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0614431526862647432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0614431526862647432==--

