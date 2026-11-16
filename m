Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D3606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kW7NOMpG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h4yPeBOn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AzRgX1+b;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Gq/jK7yD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yWp508mNzwZrHiuj5YcXOjVSFQZ4N8WDVbIbu+NSqjk=; b=kW7NOMpGDNRZZArxWca+lEzKHj
	msQfFtAyqsQ09P4cA/vs0YumqAPQH/Q17u3B9oCsYl/4QZRg7RsXt+eBhf0BbEC471/z3ZZrAjZ5m
	7WGY7lcsI5RxjyIYrLfD6UfK4nNxXznRU/WBpuKlUHsOJso0TyZsmKAbvzvdO/h8V8m4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSy3L-000000002Nz-0zjp;
	Mon, 16 Nov 2026 14:51:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSy3J-000000002Nt-3m7c
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYLIIOA341LIQkuR1O0h/0g5D1fQmlwkhRY6StZ4SWE=; b=h4yPeBOnef0g5XOP0tIRdE/asA
 cvRuEesrsSpwjV6gjTABxo6DjOLz2fhcnLWjqF6LG7a0KGTLoVq5YoPgqxHbkFURTQH4QBI0KHK2c
 YGhrpZOBypUzrGFX3Uetv5VDgvCq2MK101cgjwKOxiB5Pp4Rygw5g6mGBcQc2GiR1ygk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYLIIOA341LIQkuR1O0h/0g5D1fQmlwkhRY6StZ4SWE=; b=AzRgX1+b20SWMAHPCVnr61Zu74
 mUgka3zQe9BYJ3LUIIvRfzX2gGrCcwT7YKk8n8reXqh9wKM/5bdwxMQzj4gwYiN5/MnRSaEDR0jDx
 NNqVhmVJkrQ181qYt7XK5tJ/za3QPOGnjrRP+28NY1cVm+o+AmLP8r3bdTMjN13IGnss=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSy3H-000000006UK-4BgM for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:51:25 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so19447755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794840677; x=1795445477; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vYLIIOA341LIQkuR1O0h/0g5D1fQmlwkhRY6StZ4SWE=;
 b=Gq/jK7yDYrO/CawFed0/5b9hPJB+mawhIU941qv51TF+vCskt2igFfMX86EPP+bRl/
 3E7smzpP9dqOkjJgmGtcwXcYHFWkuF1G5+6VA+UrgXAmwcCOV4WvAHf4W29zHunz3UEO
 D6dhz+NBeFCRKVraiv9bZ+JjBCO3hboY+16YafUpVh7Z7pNKaqiiBlcyrE1X66ENi2tu
 Vvwmlc4aStwyqLXVk4e2r/FWNZY1y2om4Gce2Nq0b+bm27ryWkT3pEsGBN7vf8JhXRml
 QG+E+CdE7gHucPvmhykP8yQz7eAgNZ2pbuBhJCcn/IZj4PX/EjpjKKYi85ZCM0+GaR1P
 2RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794840677; x=1795445477;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vYLIIOA341LIQkuR1O0h/0g5D1fQmlwkhRY6StZ4SWE=;
 b=kOc6r1RbE4eodq3WW2XDI2WmbnsXQlr/7DuRbaU2/huENKa9cEPpIHX9UA9U7zTfsu
 +NOpzMfv8MKpNMp5bx0N65ykAXFwhklE0qiha81m2NkrbhqPyUrmoY1GoRCFQTYt0eRT
 yvNEVg+ldBLEqTqq81+vMXtiN693coEXgPsgjqaZQXmeueOe0tZApBgOm3esyBijOei9
 zQ8Dqb9m8HTHtbzQ/kr22uRL+X5SDscfU6pCrhjic0nF6i57sdiIO3ocwiGmxsrp6K5q
 vTi0GEEHc9MxIISDH3fnNgCG3bybzYKD3gHIdrgOZ3CEbC+BGgHUlvTCNCkJacR28fvy
 wGcg==
X-Gm-Message-State: APuU4Z+NOp5vIdtxQup/GFy2C9LrX4i6rC01HySQEdESMAhLXWwoP+T4
 iwBOApzF2TJ47oQVBokJia/GWxCUI6zVkypEQg4TFl6v95cWl1ulN+T4ipq1xShjR+UCC2vOS+G
 8lJ0Qm6ezkzBKJACUBu5i+TB1kfmbVN93+9GZLwXXtRoHR714DBzg9UGUg2FkTz0maNMo
X-Gm-Gg: AYBFou30zrptaZqj5j7tsCjoEqqNrjRyuPhK5bqRWH3XXLEBWy0fn7HxaOp/BOoVpUI
 vJol6HqBM6cvpEslXCG4R9AkyJ3maw7NBQfTkB5Bo4ykRT7BGcwve18pUqD4Zf+Cy2kS31ekvgB
 oKqK0HJoKW2iK6rLFuBfMfWAJK+lyuqu2PdGC+o1CBOO8jiZYltOpHVtre4frF9AM2+RR39LocK
 ziTqrOY/+P7QW7fRRqT98GpUnCwjY7DVUJdiAeYPHFTQ0ojR5jAO4XoQx3RCJFtJRyVvDPBhGCA
 3utSjJHOJIn2iHX9/ILQCca6jMSe7kLVHeg0WP2SGRWFvQg24YkqRO5yuNFmBDXb8wKud4l6A3T
 /7jx/b+/8UBED1pBawGoPS3XtjXfIoVEcVtEW6WgUKW31Vwgtj5kbUTB3XFLhgn4C+vv5mQDXp+
 0p56sl/jOGmZNYaFA16Wtyi+L05dNdDZv72MilZ9VVl4Eg/5E+dSMwdZYXYU0f/qSnKfVt+RebM
 kA1G2tOS+Ohc+tENCBaFVBqiq5a2i7uJCvmi8SGLRp+poyaX5zbTVSFSagBO9jCeopQY8sd/a6v
 E99nlZx85pje7IotQ+OSUF1yeE+irRJQWia+9hSpMIo9OFGEfL5LB2NEpK99HUc0fcVBBjZodYJ
 7K04Zr51s0PqodkW/fdGGFf/UbhEsCIocvnIifiaLLmw2LBaskNQ4Ux6/+m9vuknx8ocTB2Qo/X
 7IY/3Z9/b/e6RECgs=
X-Received: by 2002:a05:600c:c166:b0:4ba:6d8:df8f with SMTP id
 5b1f17b1804b1-4bb55a832c0mr252271295e9.15.1794840676972; 
 Mon, 16 Nov 2026 06:51:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5b4a3fcdsm265751435e9.0.2026.11.16.06.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:51:16 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:51:12 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
X-Gerrit-Change-Number: 2198
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2198?usp=email>
X-Gerrit-Commit: 4a4389a2ae44a3ce9b24bfba4bc64dfccecfa83d
In-Reply-To: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkk5YzI0MDNjMjFlZjhmMjFhMGZiZDk5ODM0NmM4YWQ3MTliNGI5OTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b85b657082c77265077127192822c8cb1df3f68-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSy3H-000000006UK-4BgM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Switch
 buf_forward_capacity and buf_write_set to size_t
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============0686033037787306414=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0686033037787306414==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AFU+9IA2h7c="; charset=UTF-8

--AFU+9IA2h7c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2198?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: buffer: Switch buf_forward_capacity and buf_write_s=
et to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


buffer: Switch buf_forward_capacity and buf_write_set to size_t

To make =
them consistent with buf_forward_capacity_total
and buf_read_set that were =
already switched=2E

Review call sites=2E

Change-Id: I9c2403c21ef8f21a0fbd=
998346c8ad719b4b9972
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/cr=
ypto=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/openvpn/push=2Ec
M src/open=
vpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_openssl=2Ec=

M src/openvpn/status=2Ec
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tun=2Ec=

11 files changed, 39 insertions(+), 55 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/2198/2

diff --git a/src/=
openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index c60936a=2E=2Ec33a987 1006=
44
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -234,17 +23=
4,16 @@
     if (buf_defined(buf))
     {
         char *ptr =3D (char *)BE=
ND(buf);
-        int cap =3D buf_forward_capacity(buf);
+        size_t ca=
p =3D buf_forward_capacity(buf);
 
         if (cap > 1) /* can write more =
than \0 */
         {
-            int stat;
             va_list arglist;
=
             va_start(arglist, format);
-            stat =3D vsnprintf(ptr=
, cap, format, arglist);
+            int stat =3D vsnprintf(ptr, cap, form=
at, arglist);
             va_end(arglist);
             buf->len +=3D (int=
)strnlen(ptr, cap);
-            if (stat >=3D 0 && stat < cap)
+          =
  if (stat >=3D 0 && stat < (int)cap)
             {
                 ret =
=3D true;
             }
@@ -257,11 +256,11 @@
 buf_puts(struct buffer *buf=
, const char *str)
 {
     char *ptr =3D (char *)BEND(buf);
-    int cap =
=3D buf_forward_capacity(buf);
+    size_t cap =3D buf_forward_capacity(buf=
);
     if (cap > 1) /* can write more than \0 */
     {
-        int str_l=
en =3D (int)strlcpy(ptr, str, cap);
-        buf->len +=3D (str_len < cap) =
? str_len : cap - 1;
+        size_t str_len =3D strlcpy(ptr, str, cap);
+ =
       buf->len +=3D (str_len < cap) ? (int)str_len : (int)cap - 1;
     }
=
 }
 
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 541=
f0bd=2E=2E32b49d3 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buf=
fer=2Eh
@@ -643,11 +643,6 @@
     return true;
 }
 
-#if defined(__GNUC__) =
|| defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic =
ignored "-Wsign-conversion"
-#endif
-
 /**
  * Initialise a buffer with an =
externally provided writable memory region=2E
  *
@@ -660,7 +655,7 @@
  * @=
param size  Size of the memory region in bytes=2E
  */
 static inline void
=
-buf_set_write(struct buffer *buf, uint8_t *data, int size)
+buf_set_write(=
struct buffer *buf, uint8_t *data, size_t size)
 {
     if (!buf_size_valid=
(size))
     {
@@ -668,7 +663,7 @@
     }
     buf->len =3D 0;
     buf->of=
fset =3D 0;
-    buf->capacity =3D size;
+    buf->capacity =3D (int)size;
=
     buf->data =3D data;
     if (size > 0 && data)
     {
@@ -1039,7 +1034=
,7 @@
  * @return Number of bytes available for appending, or 0 if \c buf i=
s
  *         invalid=2E
  */
-static inline int
+static inline size_t
 buf=
_forward_capacity(const struct buffer *buf)
 {
     if (buf_valid(buf))
@@ =
-1049,7 +1044,7 @@
         {
             ret =3D 0;
         }
-        r=
eturn ret;
+        return (size_t)ret;
     }
     else
     {
@@ -1252,6 =
+1247,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clan=
g__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-c=
onversion"
+#endif
+
 /**
  * Prepend data to a buffer=2E
  *
diff --git a/=
src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index db1cb41=2E=2E8b4cc3b =
100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1825,7=
 +1825,7 @@
 bool
 generate_ephemeral_key(struct buffer *key, const char *k=
ey_name)
 {
-    const int len =3D BCAP(key);
+    const int len =3D (int)B=
CAP(key);
 
     msg(M_INFO, "Using random %s=2E", key_name);
 
diff --git =
a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index 0a1=
d00c=2E=2E1246bc6 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/ope=
nvpn/crypto_openssl=2Ec
@@ -523,7 +523,7 @@
     uint8_t *dst_data =3D buf_=
write_alloc(dst, data_read_len);
     if (!dst_data)
     {
-        dmsg(D=
_CRYPT_ERRORS, "%s: dst too small (%i, needs %li)", __func__, BCAP(dst),
+ =
       dmsg(D_CRYPT_ERRORS, "%s: dst too small (%zu, needs %li)", __func__,=
 BCAP(dst),
              data_read_len);
         goto cleanup;
     }
dif=
f --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 6f628b8=2E=2Eeb=
11107 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -805,=
7 +805,7 @@
 #endif
 
 static bool
-send_push_options(struct context *c, st=
ruct buffer *buf, struct push_list *push_list, int safe_cap,
+send_push_opt=
ions(struct context *c, struct buffer *buf, struct push_list *push_list, si=
ze_t safe_cap,
                   bool *push_sent, bool *multi_push)
 {
   =
  struct push_entry *e =3D push_list->head;
@@ -820,7 +820,7 @@
           =
      msg(M_WARN, "--push option is too long");
                 return fal=
se;
             }
-            if (BLEN(buf) + (int)l >=3D safe_cap)
+    =
        if (BLENZ(buf) + l >=3D safe_cap)
             {
                 b=
uf_printf(buf, ",push-continuation 2");
                 {
@@ -835,7 +835,7=
 @@
                     buf_printf(buf, "%s", push_reply_cmd);
           =
      }
             }
-            if (BLEN(buf) + (int)l >=3D safe_cap)
+=
            if (BLENZ(buf) + l >=3D safe_cap)
             {
              =
   msg(M_WARN, "--push option is too long");
                 return false;=

@@ -873,8 +873,8 @@
     struct gc_arena gc =3D gc_new();
     struct buff=
er buf =3D alloc_buf_gc(PUSH_BUNDLE_SIZE, &gc);
     bool multi_push =3D fa=
lse;
-    const int extra =3D 84; /* extra space for possible trailing ifco=
nfig and push-continuation */
-    const int safe_cap =3D BCAP(&buf) - extr=
a;
+    const size_t extra =3D 84; /* extra space for possible trailing ifc=
onfig and push-continuation */
+    const size_t safe_cap =3D BCAP(&buf) - =
extra;
     bool push_sent =3D false;
 
     buf_printf(&buf, "%s", push_re=
ply_cmd);
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtl=
s=2Ec
index aa843c1=2E=2E2d29e60 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+=
++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1068,7 +1068,6 @@
 key_state_read_ciph=
ertext(struct key_state_ssl *ks, struct buffer *buf)
 {
     int retval =3D=
 0;
-    int len =3D 0;
 
     ASSERT(NULL !=3D ks);
     ASSERT(buf);
@@ -=
1079,9 +1078,7 @@
         return 0;
     }
 
-    len =3D buf_forward_capa=
city(buf);
-
-    retval =3D endless_buf_read(&ks->bio_ctx->out, BPTR(buf),=
 len);
+    retval =3D endless_buf_read(&ks->bio_ctx->out, BPTR(buf), BCAP(=
buf));
 
     /* Error during read, check for retry error */
     if (retva=
l < 0)
@@ -1153,7 +1150,6 @@
 key_state_read_plaintext(struct key_state_ssl=
 *ks, struct buffer *buf)
 {
     int retval =3D 0;
-    int len =3D 0;
 
 =
    ASSERT(NULL !=3D ks);
     ASSERT(buf);
@@ -1164,9 +1160,7 @@
         =
return 0;
     }
 
-    len =3D buf_forward_capacity(buf);
-
-    retval =
=3D mbedtls_ssl_read(ks->ctx, BPTR(buf), len);
+    retval =3D mbedtls_ssl_=
read(ks->ctx, BPTR(buf), BCAP(buf));
 
     /* Error during read, check for=
 retry error */
     if (retval < 0)
diff --git a/src/openvpn/ssl_ncp=2Ec b=
/src/openvpn/ssl_ncp=2Ec
index df9e42c=2E=2E0f4c94c 100644
--- a/src/openvp=
n/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -154,7 +154,7 @@
           =
  }
 
             /* Ensure buffer has capacity for cipher name + : + \0 *=
/
-            if (buf_forward_capacity(&new_list) < (int)strlen(ovpn_ciphe=
r_name) + 2)
+            if (buf_forward_capacity(&new_list) < strlen(ovpn=
_cipher_name) + 2)
             {
                 msg(M_WARN, "Length of -=
-data-ciphers is over the "
                             "limit of 127 char=
s");
@@ -564,7 +564,7 @@
 
     struct buffer ncp_ciphers_buf;
     ASSERT(=
ncp_ciphers_len <=3D INT_MAX);
-    buf_set_write(&ncp_ciphers_buf, ncp_cip=
hers, (int)ncp_ciphers_len);
+    buf_set_write(&ncp_ciphers_buf, ncp_ciphe=
rs, ncp_ciphers_len);
 
     const char *def =3D strstr(o->ncp_ciphers, sea=
rch);
 
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=
=2Ec
index e190935=2E=2E7622d88 100644
--- a/src/openvpn/ssl_openssl=2Ec
++=
+ b/src/openvpn/ssl_openssl=2Ec
@@ -2163,13 +2163,12 @@
          * if the =
buffer is not empty */
         return 0;
     }
-    int len =3D buf_forwa=
rd_capacity(buf);
 
     /*
      * BIO_read brackets most of the serious R=
SA
      * key negotiation number crunching=2E
      */
-    int i =3D BIO_=
read(bio, BPTR(buf), len);
+    int i =3D BIO_read(bio, BPTR(buf), (int)BCA=
P(buf));
 
     VALGRIND_MAKE_READABLE((void *)&i, sizeof(i));
 
diff --git=
 a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec
index 533619f=2E=2E0a3fc=
019 100644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -21=
5,11 +215,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__cl=
ang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign=
-conversion"
-#endif
-
 #define STATUS_PRINTF_MAXLEN 512
 
 void
@@ -281,7 =
+276,7 @@
             if (c =3D=3D -1)
             {
                 ASS=
ERT(buf_init(&so->read_buf, 0));
-                ssize_t len =3D read(so->=
fd, BPTR(&so->read_buf), BCAP(&so->read_buf));
+                ssize_t len=
 =3D read(so->fd, BPTR(&so->read_buf), (unsigned int)BCAP(&so->read_buf));
=
                 if (len <=3D 0)
                 {
                     br=
eak;
@@ -311,7 +306,3 @@
 
     return ret;
 }
-
-#if defined(__GNUC__) || =
defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/ope=
nvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index d7f69f7=2E=2E5617ad3 1=
00644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -3=
80,8 +380,8 @@
         msg(M_WARN, "ERROR: could not write tag");
        =
 return false;
     }
-    const int data_len =3D BLEN(src_metadata) + size=
of(src_key->keys) + sizeof(uint16_t);
-    const int tagged_len =3D data_le=
n + TLS_CRYPT_TAG_SIZE;
+    const size_t data_len =3D BLENZ(src_metadata) =
+ sizeof(src_key->keys) + sizeof(uint16_t);
+    const size_t tagged_len =
=3D data_len + TLS_CRYPT_TAG_SIZE;
     const uint16_t net_len =3D htons((u=
int16_t)tagged_len);
     hmac_ctx_t *hmac_ctx =3D server_key->hmac;
     h=
mac_ctx_reset(hmac_ctx);
@@ -396,7 +396,7 @@
     ASSERT(cipher_ctx_reset(c=
ipher_ctx, tag));
 
     /* Overflow check (OpenSSL requires an extra block=
 in the dst buffer) */
-    const int padded_len =3D data_len + cipher_ctx_=
block_size(cipher_ctx);
+    const size_t padded_len =3D data_len + cipher_=
ctx_block_size(cipher_ctx);
     if (buf_forward_capacity(&work) < padded_l=
en)
     {
         msg(M_WARN, "ERROR: could not crypt: insufficient space=
 in dst");
@@ -735,7 +735,7 @@
         size_t b64_length =3D strlen(b64_me=
tadata);
         metadata =3D alloc_buf_gc(OPENVPN_BASE64_DECODED_LENGTH(b=
64_length) + 1, &gc);
         ASSERT(buf_write(&metadata, &TLS_CRYPT_METAD=
ATA_TYPE_USER, 1));
-        int decoded_len =3D openvpn_base64_decode(b64_=
metadata, BEND(&metadata), BCAP(&metadata));
+        int decoded_len =3D o=
penvpn_base64_decode(b64_metadata, BEND(&metadata), (int)BCAP(&metadata));
=
         if (decoded_len < 0)
         {
             msg(M_FATAL, "ERROR: =
failed to base64 decode provided metadata");
diff --git a/src/openvpn/tun=
=2Ec b/src/openvpn/tun=2Ec
index 0ba8a4a=2E=2Ec56ace3 100644
--- a/src/open=
vpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -4008,7 +4008,7 @@
  * registry fo=
r the TAP device # =3D device_number=2E
  */
 static const char *
-get_unsp=
ecified_device_guid(const int device_number, uint8_t *actual_name, int actu=
al_name_size,
+get_unspecified_device_guid(const int device_number, uint8_t=
 *actual_name, size_t actual_name_size,
                             const =
struct tap_reg *tap_reg_src,
                             const struct pane=
l_reg *panel_reg_src,
                             enum tun_driver_type *wi=
ndows_driver, struct gc_arena *gc)
@@ -4071,7 +4071,7 @@
  * returning the =
GUID and optional actual_name and device type
  */
 static const char *
-ge=
t_device_guid(const char *name, uint8_t *actual_name, int actual_name_size,=

+get_device_guid(const char *name, uint8_t *actual_name, size_t actual_nam=
e_size,
                 enum tun_driver_type *windows_driver, const struct=
 tap_reg *tap_reg,
                 const struct panel_reg *panel_reg, stru=
ct gc_arena *gc)
 {
@@ -6087,8 +6087,9 @@
     {
         struct buffer out=
 =3D alloc_buf_gc(256, gc);
         DWORD len;
-        if (DeviceIoContro=
l(tt->hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&out), BCAP(&out), BSTR(&out),
-  =
                          BCAP(&out), &len, NULL))
+        if (DeviceIoCon=
trol(tt->hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&out),
+                       =
     (DWORD)BCAP(&out), BSTR(&out),
+                            (DWORD)BCA=
P(&out), &len, NULL))
         {
             return BSTR(&out);
         }=

@@ -6103,8 +6104,8 @@
     {
         struct buffer out =3D alloc_buf(1024=
);
         DWORD len;
-        while (DeviceIoControl(tt->hand, TAP_WIN_IO=
CTL_GET_LOG_LINE, BSTR(&out), BCAP(&out),
-                               B=
STR(&out), BCAP(&out), &len, NULL))
+        while (DeviceIoControl(tt->han=
d, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&out), (DWORD)BCAP(&out),
+            =
                   BSTR(&out), (DWORD)BCAP(&out), &len, NULL))
         {
 =
            msg(D_TAP_WIN_DEBUG, "TAP-Windows: %s", BSTR(&out));
         }=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9c2403c21ef8f=
21a0fbd998346c8ad719b4b9972
Gerrit-Change-Number: 2198
Gerrit-PatchSet: 2
G=
errit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>

--AFU+9IA2h7c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">buffer: Switch buf_forward_capacity and buf_write_set to size_t<br><=
br>To make them consistent with buf_forward_capacity_total<br>and buf_read_=
set that were already switched=2E<br><br>Review call sites=2E<br><br>Change=
-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<=
br>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/cr=
ypto_openssl=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec=
<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/ope=
nvpn/status=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpn/tun=2Ec<br>=
11 files changed, 39 insertions(+), 55 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/219=
8/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</s=
pan><br><span>index c60936a=2E=2Ec33a987 100644</span><br><span>--- a/src/o=
penvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><s=
pan>@@ -234,17 +234,16 @@</span><br><span>     if (buf_defined(buf))</span>=
<br><span>     {</span><br><span>         char *ptr =3D (char *)BEND(buf);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int cap =3D bu=
f_forward_capacity(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        size_t cap =3D buf_forward_capacity(buf);</span><br><span> </s=
pan><br><span>         if (cap &gt; 1) /* can write more than \0 */</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          int stat;</span><br><span>             va_list arglist;</span><br=
><span>             va_start(arglist, format);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            stat =3D vsnprintf(ptr, cap, format, a=
rglist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 int stat =3D vsnprintf(ptr, cap, format, arglist);</span><br><span>       =
      va_end(arglist);</span><br><span>             buf-&gt;len +=3D (int)s=
trnlen(ptr, cap);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (stat &gt;=3D 0 &amp;&amp; stat &lt; cap)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (stat &gt;=3D 0 &amp;&amp;=
 stat &lt; (int)cap)</span><br><span>             {</span><br><span>       =
          ret =3D true;</span><br><span>             }</span><br><span>@@ -=
257,11 +256,11 @@</span><br><span> buf_puts(struct buffer *buf, const char =
*str)</span><br><span> {</span><br><span>     char *ptr =3D (char *)BEND(bu=
f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int cap =3D bu=
f_forward_capacity(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    size_t cap =3D buf_forward_capacity(buf);</span><br><span>     if =
(cap &gt; 1) /* can write more than \0 */</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        int str_len =3D (int)str=
lcpy(ptr, str, cap);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       buf-&gt;len +=3D (str_len &lt; cap) ? str_len : cap - 1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        size_t str_len =3D strl=
cpy(ptr, str, cap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        buf-&gt;len +=3D (str_len &lt; cap) ? (int)str_len : (int)cap - 1;<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><sp=
an>index 541f0bd=2E=2E32b49d3 100644</span><br><span>--- a/src/openvpn/buff=
er=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -643=
,11 +643,6 @@</span><br><span>     return true;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><sp=
an>  * Initialise a buffer with an externally provided writable memory regi=
on=2E</span><br><span>  *</span><br><span>@@ -660,7 +655,7 @@</span><br><sp=
an>  * @param size  Size of the memory region in bytes=2E</span><br><span> =
 */</span><br><span> static inline void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-buf_set_write(struct buffer *buf, uint8_t *data, int size=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_set_write(stru=
ct buffer *buf, uint8_t *data, size_t size)</span><br><span> {</span><br><s=
pan>     if (!buf_size_valid(size))</span><br><span>     {</span><br><span>=
@@ -668,7 +663,7 @@</span><br><span>     }</span><br><span>     buf-&gt;len=
 =3D 0;</span><br><span>     buf-&gt;offset =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    buf-&gt;capacity =3D size;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;capacity =3D (int)size;=
</span><br><span>     buf-&gt;data =3D data;</span><br><span>     if (size =
&gt; 0 &amp;&amp; data)</span><br><span>     {</span><br><span>@@ -1039,7 +=
1034,7 @@</span><br><span>  * @return Number of bytes available for appendi=
ng, or 0 if \c buf is</span><br><span>  *         invalid=2E</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline siz=
e_t</span><br><span> buf_forward_capacity(const struct buffer *buf)</span><=
br><span> {</span><br><span>     if (buf_valid(buf))</span><br><span>@@ -10=
49,7 +1044,7 @@</span><br><span>         {</span><br><span>             ret=
 =3D 0;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return ret;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return (size_t)ret;</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span>@@ -1252,6 +1247,11 @=
@</span><br><span>     return true;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span=
>  * Prepend data to a buffer=2E</span><br><span>  *</span><br><span>diff -=
-git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>inde=
x db1cb41=2E=2E8b4cc3b 100644</span><br><span>--- a/src/openvpn/crypto=2Ec<=
/span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1825,7 +18=
25,7 @@</span><br><span> bool</span><br><span> generate_ephemeral_key(struc=
t buffer *key, const char *key_name)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const int len =3D BCAP(key);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const int len =3D (int)B=
CAP(key);</span><br><span> </span><br><span>     msg(M_INFO, &quot;Using ra=
ndom %s=2E&quot;, key_name);</span><br><span> </span><br><span>diff --git a=
/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br>=
<span>index 0a1d00c=2E=2E1246bc6 100644</span><br><span>--- a/src/openvpn/c=
rypto_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</spa=
n><br><span>@@ -523,7 +523,7 @@</span><br><span>     uint8_t *dst_data =3D =
buf_write_alloc(dst, data_read_len);</span><br><span>     if (!dst_data)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       dmsg(D_CRYPT_ERRORS, &quot;%s: dst too small (%i, needs %li)&quot;, =
__func__, BCAP(dst),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        dmsg(D_CRYPT_ERRORS, &quot;%s: dst too small (%zu, needs %li)&quot=
;, __func__, BCAP(dst),</span><br><span>              data_read_len);</span=
><br><span>         goto cleanup;</span><br><span>     }</span><br><span>di=
ff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>inde=
x 6f628b8=2E=2Eeb11107 100644</span><br><span>--- a/src/openvpn/push=2Ec</s=
pan><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -805,7 +805,7 @=
@</span><br><span> #endif</span><br><span> </span><br><span> static bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-send_push_options(struct=
 context *c, struct buffer *buf, struct push_list *push_list, int safe_cap,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_options(s=
truct context *c, struct buffer *buf, struct push_list *push_list, size_t s=
afe_cap,</span><br><span>                   bool *push_sent, bool *multi_pu=
sh)</span><br><span> {</span><br><span>     struct push_entry *e =3D push_l=
ist-&gt;head;</span><br><span>@@ -820,7 +820,7 @@</span><br><span>         =
        msg(M_WARN, &quot;--push option is too long&quot;);</span><br><span=
>                 return false;</span><br><span>             }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(buf) + (int)l=
 &gt;=3D safe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (BLENZ(buf) + l &gt;=3D safe_cap)</span><br><span>           =
  {</span><br><span>                 buf_printf(buf, &quot;,push-continuati=
on 2&quot;);</span><br><span>                 {</span><br><span>@@ -835,7 +=
835,7 @@</span><br><span>                     buf_printf(buf, &quot;%s&quot=
;, push_reply_cmd);</span><br><span>                 }</span><br><span>    =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (BLEN(buf) + (int)l &gt;=3D safe_cap)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (BLENZ(buf) + l &gt;=3D safe_cap)</spa=
n><br><span>             {</span><br><span>                 msg(M_WARN, &qu=
ot;--push option is too long&quot;);</span><br><span>                 retur=
n false;</span><br><span>@@ -873,8 +873,8 @@</span><br><span>     struct gc=
_arena gc =3D gc_new();</span><br><span>     struct buffer buf =3D alloc_bu=
f_gc(PUSH_BUNDLE_SIZE, &amp;gc);</span><br><span>     bool multi_push =3D f=
alse;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int ex=
tra =3D 84; /* extra space for possible trailing ifconfig and push-continua=
tion */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int =
safe_cap =3D BCAP(&amp;buf) - extra;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const size_t extra =3D 84; /* extra space for possible=
 trailing ifconfig and push-continuation */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const size_t safe_cap =3D BCAP(&amp;buf) - extr=
a;</span><br><span>     bool push_sent =3D false;</span><br><span> </span><=
br><span>     buf_printf(&amp;buf, &quot;%s&quot;, push_reply_cmd);</span><=
br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>index aa843c1=2E=2E2d29e60 100644</span><br><span>--- =
a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>@@ -1068,7 +1068,6 @@</span><br><span> key_state_read_=
ciphertext(struct key_state_ssl *ks, struct buffer *buf)</span><br><span> {=
</span><br><span>     int retval =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int len =3D 0;</span><br><span> </span><br><span>    =
 ASSERT(NULL !=3D ks);</span><br><span>     ASSERT(buf);</span><br><span>@@=
 -1079,9 +1078,7 @@</span><br><span>         return 0;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   len =3D buf_forward_capacity(buf);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
etval =3D endless_buf_read(&amp;ks-&gt;bio_ctx-&gt;out, BPTR(buf), len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    retval =3D endless=
_buf_read(&amp;ks-&gt;bio_ctx-&gt;out, BPTR(buf), BCAP(buf));</span><br><sp=
an> </span><br><span>     /* Error during read, check for retry error */</s=
pan><br><span>     if (retval &lt; 0)</span><br><span>@@ -1153,7 +1150,6 @@=
</span><br><span> key_state_read_plaintext(struct key_state_ssl *ks, struct=
 buffer *buf)</span><br><span> {</span><br><span>     int retval =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D 0;</span>=
<br><span> </span><br><span>     ASSERT(NULL !=3D ks);</span><br><span>    =
 ASSERT(buf);</span><br><span>@@ -1164,9 +1160,7 @@</span><br><span>       =
  return 0;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    len =3D buf_forward_capacity(buf);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    retval =3D mbedtls_ssl_read(ks-&gt;ctx, BPT=
R(buf), len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
tval =3D mbedtls_ssl_read(ks-&gt;ctx, BPTR(buf), BCAP(buf));</span><br><spa=
n> </span><br><span>     /* Error during read, check for retry error */</sp=
an><br><span>     if (retval &lt; 0)</span><br><span>diff --git a/src/openv=
pn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index df9e42c=2E=
=2E0f4c94c 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><=
span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -154,7 +154,7 @@</spa=
n><br><span>             }</span><br><span> </span><br><span>             /=
* Ensure buffer has capacity for cipher name + : + \0 */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (buf_forward_capacity(&am=
p;new_list) &lt; (int)strlen(ovpn_cipher_name) + 2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (buf_forward_capacity(&amp=
;new_list) &lt; strlen(ovpn_cipher_name) + 2)</span><br><span>             =
{</span><br><span>                 msg(M_WARN, &quot;Length of --data-ciphe=
rs is over the &quot;</span><br><span>                             &quot;li=
mit of 127 chars&quot;);</span><br><span>@@ -564,7 +564,7 @@</span><br><spa=
n> </span><br><span>     struct buffer ncp_ciphers_buf;</span><br><span>   =
  ASSERT(ncp_ciphers_len &lt;=3D INT_MAX);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    buf_set_write(&amp;ncp_ciphers_buf, ncp_ciphers, (=
int)ncp_ciphers_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buf_set_write(&amp;ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);</s=
pan><br><span> </span><br><span>     const char *def =3D strstr(o-&gt;ncp_c=
iphers, search);</span><br><span> </span><br><span>diff --git a/src/openvpn=
/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index e19093=
5=2E=2E7622d88 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</sp=
an><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -2163,13 =
+2163,12 @@</span><br><span>          * if the buffer is not empty */</span=
><br><span>         return 0;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int len =3D buf_forward_capacity(buf);<=
/span><br><span> </span><br><span>     /*</span><br><span>      * BIO_read =
brackets most of the serious RSA</span><br><span>      * key negotiation nu=
mber crunching=2E</span><br><span>      */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int i =3D BIO_read(bio, BPTR(buf), len);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D BIO_read(bio, B=
PTR(buf), (int)BCAP(buf));</span><br><span> </span><br><span>     VALGRIND_=
MAKE_READABLE((void *)&amp;i, sizeof(i));</span><br><span> </span><br><span=
>diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec</span><br><sp=
an>index 533619f=2E=2E0a3fc019 100644</span><br><span>--- a/src/openvpn/sta=
tus=2Ec</span><br><span>+++ b/src/openvpn/status=2Ec</span><br><span>@@ -21=
5,11 +215,6 @@</span><br><span>     return ret;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define STATUS_PR=
INTF_MAXLEN 512</span><br><span> </span><br><span> void</span><br><span>@@ =
-281,7 +276,7 @@</span><br><span>             if (c =3D=3D -1)</span><br><s=
pan>             {</span><br><span>                 ASSERT(buf_init(&amp;so=
-&gt;read_buf, 0));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              ssize_t len =3D read(so-&gt;fd, BPTR(&amp;so-&gt;read_buf), B=
CAP(&amp;so-&gt;read_buf));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                ssize_t len =3D read(so-&gt;fd, BPTR(&amp;so-&gt;re=
ad_buf), (unsigned int)BCAP(&amp;so-&gt;read_buf));</span><br><span>       =
          if (len &lt;=3D 0)</span><br><span>                 {</span><br><=
span>                     break;</span><br><span>@@ -311,7 +306,3 @@</span>=
<br><span> </span><br><span>     return ret;</span><br><span> }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>diff=
 --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><s=
pan>index d7f69f7=2E=2E5617ad3 100644</span><br><span>--- a/src/openvpn/tls=
_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>=
@@ -380,8 +380,8 @@</span><br><span>         msg(M_WARN, &quot;ERROR: could=
 not write tag&quot;);</span><br><span>         return false;</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const in=
t data_len =3D BLEN(src_metadata) + sizeof(src_key-&gt;keys) + sizeof(uint1=
6_t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int ta=
gged_len =3D data_len + TLS_CRYPT_TAG_SIZE;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const size_t data_len =3D BLENZ(src_metadata) +=
 sizeof(src_key-&gt;keys) + sizeof(uint16_t);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const size_t tagged_len =3D data_len + TLS_CR=
YPT_TAG_SIZE;</span><br><span>     const uint16_t net_len =3D htons((uint16=
_t)tagged_len);</span><br><span>     hmac_ctx_t *hmac_ctx =3D server_key-&g=
t;hmac;</span><br><span>     hmac_ctx_reset(hmac_ctx);</span><br><span>@@ -=
396,7 +396,7 @@</span><br><span>     ASSERT(cipher_ctx_reset(cipher_ctx, ta=
g));</span><br><span> </span><br><span>     /* Overflow check (OpenSSL requ=
ires an extra block in the dst buffer) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const int padded_len =3D data_len + cipher_ctx_bloc=
k_size(cipher_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const size_t padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx=
);</span><br><span>     if (buf_forward_capacity(&amp;work) &lt; padded_len=
)</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;ERROR: =
could not crypt: insufficient space in dst&quot;);</span><br><span>@@ -735,=
7 +735,7 @@</span><br><span>         size_t b64_length =3D strlen(b64_metad=
ata);</span><br><span>         metadata =3D alloc_buf_gc(OPENVPN_BASE64_DEC=
ODED_LENGTH(b64_length) + 1, &amp;gc);</span><br><span>         ASSERT(buf_=
write(&amp;metadata, &amp;TLS_CRYPT_METADATA_TYPE_USER, 1));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        int decoded_len =3D openvpn_=
base64_decode(b64_metadata, BEND(&amp;metadata), BCAP(&amp;metadata));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int decoded_len =
=3D openvpn_base64_decode(b64_metadata, BEND(&amp;metadata), (int)BCAP(&amp=
;metadata));</span><br><span>         if (decoded_len &lt; 0)</span><br><sp=
an>         {</span><br><span>             msg(M_FATAL, &quot;ERROR: failed=
 to base64 decode provided metadata&quot;);</span><br><span>diff --git a/sr=
c/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 0ba8a4a=2E=2E=
c56ace3 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>++=
+ b/src/openvpn/tun=2Ec</span><br><span>@@ -4008,7 +4008,7 @@</span><br><sp=
an>  * registry for the TAP device # =3D device_number=2E</span><br><span> =
 */</span><br><span> static const char *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-get_unspecified_device_guid(const int device_number, uin=
t8_t *actual_name, int actual_name_size,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+get_unspecified_device_guid(const int device_number, u=
int8_t *actual_name, size_t actual_name_size,</span><br><span>             =
                const struct tap_reg *tap_reg_src,</span><br><span>        =
                     const struct panel_reg *panel_reg_src,</span><br><span=
>                             enum tun_driver_type *windows_driver, struct =
gc_arena *gc)</span><br><span>@@ -4071,7 +4071,7 @@</span><br><span>  * ret=
urning the GUID and optional actual_name and device type</span><br><span>  =
*/</span><br><span> static const char *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-get_device_guid(const char *name, uint8_t *actual_name, i=
nt actual_name_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+get_device_guid(const char *name, uint8_t *actual_name, size_t actual_name=
_size,</span><br><span>                 enum tun_driver_type *windows_drive=
r, const struct tap_reg *tap_reg,</span><br><span>                 const st=
ruct panel_reg *panel_reg, struct gc_arena *gc)</span><br><span> {</span><b=
r><span>@@ -6087,8 +6087,9 @@</span><br><span>     {</span><br><span>      =
   struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>         DW=
ORD len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (D=
eviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&amp;out), BCAP(&a=
mp;out), BSTR(&amp;out),</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                            BCAP(&amp;out), &amp;len, NULL))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (DeviceIoControl(tt-=
&gt;hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&amp;out),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            (DWORD)BCAP(&amp;=
out), BSTR(&amp;out),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                            (DWORD)BCAP(&amp;out), &amp;len, NULL))</span=
><br><span>         {</span><br><span>             return BSTR(&amp;out);</=
span><br><span>         }</span><br><span>@@ -6103,8 +6104,8 @@</span><br><=
span>     {</span><br><span>         struct buffer out =3D alloc_buf(1024);=
</span><br><span>         DWORD len;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        while (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GE=
T_LOG_LINE, BSTR(&amp;out), BCAP(&amp;out),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                               BSTR(&amp;out), BCAP(&=
amp;out), &amp;len, NULL))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        while (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GET_LOG_LI=
NE, BSTR(&amp;out), (DWORD)BCAP(&amp;out),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                               BSTR(&amp;out), (DWOR=
D)BCAP(&amp;out), &amp;len, NULL))</span><br><span>         {</span><br><sp=
an>             msg(D_TAP_WIN_DEBUG, &quot;TAP-Windows: %s&quot;, BSTR(&amp=
;out));</span><br><span>         }</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail">change 21=
98</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2198 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html=
>
--AFU+9IA2h7c=--


--===============0686033037787306414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0686033037787306414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0686033037787306414==--

