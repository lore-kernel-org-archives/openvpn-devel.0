Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFB606A887
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LLc65RjB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SAOVbATw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y5/FGYkj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Dkdxos4y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gp4JwsD4+BJGx0HuGf0WwQe/O57jyba7zKWe4l3rEMA=; b=LLc65RjB0ATaYsUlJpOJMU1kHL
	ImoZCgZqzptyHUpHnAAhUz0w616oCsnrrngi+GH2MLBbJpmL2UB3dKVjRSbNeUsaYs2LY2fDSOU1U
	/6DZxchmZLOeFakCz2deFjg2vp4xqiGxykFKSdPIYspuUAOoYPYDnm6Amw5EbNtaLnIU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTHAc-000000006fx-1oCR;
	Tue, 17 Nov 2026 11:16:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTHAa-000000006fr-2cKG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:16:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YnEqj6hmlOl3pmMt4RxL7bNdpUxzYpMfXT4Hdz1X8j0=; b=SAOVbATwsxvx+AKTkJLekqpMnJ
 7TXkjt4S0eu0lYo00OnqvJI7bSQ8+h0v+rHio4pEP/Mys4ZP1Nw2p/54PV3b6r5daFCeCCb/gyICR
 7LGEf0Cwhe4SoKrAEwSX4j2COI/A3IY6ySFxrTVJhLxDv60AsMU6zaQq+UieWAqKp6pM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YnEqj6hmlOl3pmMt4RxL7bNdpUxzYpMfXT4Hdz1X8j0=; b=Y5/FGYkjfnVGlGcHVuYxyWiFwU
 4LQYxhA2M02MZ38Ly3Q/curH/NeOWGROBSI5dr64QrDrk+0MeHuab4lcL9FwkcgOXpUM0g9ezyKZD
 nVCg1/v+RZsVipxmyRtJjK4h0LrxaSxmuD97/5mstpjXbEbvO+WbSCOPluxGSJxjN2E0=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTHAY-0000000039y-1Fdj for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:16:12 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so41330365e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 03:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794914164; x=1795518964; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YnEqj6hmlOl3pmMt4RxL7bNdpUxzYpMfXT4Hdz1X8j0=;
 b=Dkdxos4yZ48095Xu63HAOHIohmWfyg+efBa7NPip9ayXgwv0PzgUzdsgVOGsa98r4V
 g3K8OGbb3t9u9wjbxch8ZeakRM0cwwbksUkEFXqlJwbS+IeQZ75yZy6G//OE0CuS68EU
 mN+hGCFR5jSbqQU/P/S8h5xR94Qo4FAksz5DblIwXcBt8/Spzkw6epOOuwuQmktEYnhk
 d+kqRlxDOyj6dWPqIflUPaJFye1Q8VnPzjEosNEBKD+4oJlqOL84OahviOGgXK2eGLsm
 IVPbzc5Y/TK/N3spbcfvaQqbxq4tXpVW8BfgefBms4kUQD6rHD8K0K3cE4+HU3UDXuUD
 3iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794914164; x=1795518964;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YnEqj6hmlOl3pmMt4RxL7bNdpUxzYpMfXT4Hdz1X8j0=;
 b=uFFPDfRvZ9uxncXjotx6yBDCsGF+e/n/KMRgzh/R/XYIhpjtGXFqui5m89NZZkgYVW
 FCSF2md4+W/JmPQnuYYy3HqDXMt7m0a/6jHh4cS87en53f+nJCjC4Cr2ZV+FhqUz+uIw
 y9r/L5MIh2iKQqltUOqCGMMWlkjZl50enkJTaEGjf7wfBXF4h3Nk28szCpCf6GvZzUYT
 6s3jnWlBXG+YQdBUReZx34d7WjxpNhbHB5RZ933KmagW/skBfTp+aeba++5bLNOf5E5c
 EPdMh9ybEp5ko+dz6akDupsx/a+3XgDiQea4anSrWgP1A7vrld1cggtqdQTOvWD8ipvG
 8IjA==
X-Forwarded-Encrypted: i=1;
 AL+hErFoR07HkxZGnx27AkFsHoHRlhnjuLVFn9+wCs97z41TPI9QjTjulrTzx4M54W6KrDDNqxUTBw7pOkjalSF2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/PYue/SGKYeR1RtdAHji3wWIigJ8V82l1qyeFnc0wQhY8w64L3
 ZIdpbVzg9gZS4p/4VLAQHDPsWOgcjuiryi4ysb8uWNtw5IqcBSZvWLSceYWfExO+Fp3KvQ+L6sT
 Gf5QWflcn6YDruombmd6cAq6BbPvH/ckVIjOL6pWUgWr54l7lgQBdStv/iRoWHAy6wh5e
X-Gm-Gg: AYBFou0cXV/TmZ0kR6OcYXSuzvCFKNxeL9xeM276/EOB9Y4pQu9jCJ6WWI4OsDgrjO4
 +m1mIqBgCXx6Pk/zxVV8Fxe8JunxM6nc7g3zBmkQKz3XGy7CByZWH390ep1L+4PPf/evPoIgjR+
 viMs7CJ/tkcXOa9ATLz9FFEHXV+PhjAopHssNB2CuwRT7Gs/NWiQUcIyIA+QYXhnF/gpXdw+oWh
 bp11Wr1waArKzv/nr6KcXOllMxRRW9lBCuJzLeB4gjNOYJx/y7F5sLZ4gNAnJ/ZGfS72SdwNpK9
 wBV7JUhQigsnaSEHuBdCmhbiCtqMUzjU/TLfVZgEsTsVrvT2NoMih3Rv4x2+ovmtLzKnL9NATsJ
 PTuh3MxQSXsyup0PYNkbQA4Su25gYCokjjOzGL/KhNiCEoA23SSsKRUeVr/D7GuIwBB3d0d6xbl
 pl0jU/5BD6ETH0d0FCA08clMAuEkERJhDcnT2arNMAM/rpdbMCm+/mBGaJ+eByOL9Epqm/v+ueJ
 SeG7Ccw9cDwUQaVpMdYcW9JK0yxEXGvX0XoaT5k0dZOxKW4NXVx8UXRgvoorsjzX6aiAsnteHvP
 mBP7IAroqvTWOOdAGfuslyj35mGwwsBQcsjxamIeG9c2bG1il3hDeyXaefSQ4UCSjAyWbR68vE8
 y+YIt18stVK/gk2M0j3JJZfs/7C2JPtgYa7uP77CC6HYHuGsskebU8Uii+CsktKCYzbpV/rQH9z
 HHxs+HYc6EksCHoEfPDoF/cU3gQceUmIzarVS9
X-Received: by 2002:a05:600c:3e10:b0:4bb:6651:9eda with SMTP id
 5b1f17b1804b1-4bb6651a042mr184309955e9.14.1794914163500; 
 Tue, 17 Nov 2026 03:16:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a43d41ec38sm3022286f8f.19.2026.11.17.03.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 03:16:03 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 11:16:02 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
X-Gerrit-Change-Number: 2198
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2198?usp=email>
X-Gerrit-Commit: 823653286f82e2fbcd1ff1687a8a01b3fb6302e6
In-Reply-To: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkk5YzI0MDNjMjFlZjhmMjFhMGZiZDk5ODM0NmM4YWQ3MTliNGI5OTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad6eb75aab8ed151d3e513f563352edc53d1b680-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTHAY-0000000039y-1Fdj
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Switch
 buf_forward_capacity and buf_set_write to size_t
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1430979497467605159=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1430979497467605159==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="75vRYuTmv0I="; charset=UTF-8

--75vRYuTmv0I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2198?usp=3Demail )

Change subject: buffer: Switch buf_forward_=
capacity and buf_set_write to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Switch buf_forward_capacity and buf_set_w=
rite to size_t

To make them consistent with buf_forward_capacity_total
and=
 buf_set_read that were already switched=2E

Review call sites=2E

Change-I=
d: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
Signed-off-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198
Message-Id:=
 <20261117101909=2E30743-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41509=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/buffer=
=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/crypto=2Ec
M src/openvpn/crypto=
_openssl=2Ec
M src/openvpn/push=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M src/ope=
nvpn/ssl_ncp=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/status=2Ec
M s=
rc/openvpn/tls_crypt=2Ec
M src/openvpn/tun=2Ec
11 files changed, 39 inserti=
ons(+), 56 deletions(-)




diff --git a/src/openvpn/buffer=2Ec b/src/openv=
pn/buffer=2Ec
index c60936a=2E=2Ec33a987 100644
--- a/src/openvpn/buffer=2E=
c
+++ b/src/openvpn/buffer=2Ec
@@ -234,17 +234,16 @@
     if (buf_defined(b=
uf))
     {
         char *ptr =3D (char *)BEND(buf);
-        int cap =3D =
buf_forward_capacity(buf);
+        size_t cap =3D buf_forward_capacity(buf=
);
 
         if (cap > 1) /* can write more than \0 */
         {
-       =
     int stat;
             va_list arglist;
             va_start(arglist,=
 format);
-            stat =3D vsnprintf(ptr, cap, format, arglist);
+    =
        int stat =3D vsnprintf(ptr, cap, format, arglist);
             va_=
end(arglist);
             buf->len +=3D (int)strnlen(ptr, cap);
-         =
   if (stat >=3D 0 && stat < cap)
+            if (stat >=3D 0 && stat < (i=
nt)cap)
             {
                 ret =3D true;
             }
@@ -25=
7,11 +256,11 @@
 buf_puts(struct buffer *buf, const char *str)
 {
     char=
 *ptr =3D (char *)BEND(buf);
-    int cap =3D buf_forward_capacity(buf);
+ =
   size_t cap =3D buf_forward_capacity(buf);
     if (cap > 1) /* can write=
 more than \0 */
     {
-        int str_len =3D (int)strlcpy(ptr, str, cap=
);
-        buf->len +=3D (str_len < cap) ? str_len : cap - 1;
+        siz=
e_t str_len =3D strlcpy(ptr, str, cap);
+        buf->len +=3D (str_len < c=
ap) ? (int)str_len : (int)cap - 1;
     }
 }
 
diff --git a/src/openvpn/buf=
fer=2Eh b/src/openvpn/buffer=2Eh
index 541f0bd=2E=2E32b49d3 100644
--- a/sr=
c/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -643,11 +643,6 @@
    =
 return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GC=
C diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#end=
if
-
 /**
  * Initialise a buffer with an externally provided writable memo=
ry region=2E
  *
@@ -660,7 +655,7 @@
  * @param size  Size of the memory re=
gion in bytes=2E
  */
 static inline void
-buf_set_write(struct buffer *buf=
, uint8_t *data, int size)
+buf_set_write(struct buffer *buf, uint8_t *data=
, size_t size)
 {
     if (!buf_size_valid(size))
     {
@@ -668,7 +663,7 @=
@
     }
     buf->len =3D 0;
     buf->offset =3D 0;
-    buf->capacity =
=3D size;
+    buf->capacity =3D (int)size;
     buf->data =3D data;
     i=
f (size > 0 && data)
     {
@@ -1039,7 +1034,7 @@
  * @return Number of byt=
es available for appending, or 0 if \c buf is
  *         invalid=2E
  */
-=
static inline int
+static inline size_t
 buf_forward_capacity(const struct =
buffer *buf)
 {
     if (buf_valid(buf))
@@ -1049,7 +1044,7 @@
         {
 =
            ret =3D 0;
         }
-        return ret;
+        return (siz=
e_t)ret;
     }
     else
     {
@@ -1252,6 +1247,11 @@
     return true;
 =
}
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pu=
sh
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * P=
repend data to a buffer=2E
  *
diff --git a/src/openvpn/crypto=2Ec b/src/op=
envpn/crypto=2Ec
index db1cb41=2E=2E8b4cc3b 100644
--- a/src/openvpn/crypto=
=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1825,7 +1825,7 @@
 bool
 generate_eph=
emeral_key(struct buffer *key, const char *key_name)
 {
-    const int len =
=3D BCAP(key);
+    const int len =3D (int)BCAP(key);
 
     msg(M_INFO, "U=
sing random %s=2E", key_name);
 
diff --git a/src/openvpn/crypto_openssl=2E=
c b/src/openvpn/crypto_openssl=2Ec
index 0a1d00c=2E=2E1246bc6 100644
--- a/=
src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -523=
,7 +523,7 @@
     uint8_t *dst_data =3D buf_write_alloc(dst, data_read_len)=
;
     if (!dst_data)
     {
-        dmsg(D_CRYPT_ERRORS, "%s: dst too sma=
ll (%i, needs %li)", __func__, BCAP(dst),
+        dmsg(D_CRYPT_ERRORS, "%s=
: dst too small (%zu, needs %li)", __func__, BCAP(dst),
              data_=
read_len);
         goto cleanup;
     }
diff --git a/src/openvpn/push=2Ec =
b/src/openvpn/push=2Ec
index 6f628b8=2E=2Eeb11107 100644
--- a/src/openvpn/=
push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -805,7 +805,7 @@
 #endif
 
 static b=
ool
-send_push_options(struct context *c, struct buffer *buf, struct push_l=
ist *push_list, int safe_cap,
+send_push_options(struct context *c, struct =
buffer *buf, struct push_list *push_list, size_t safe_cap,
                =
   bool *push_sent, bool *multi_push)
 {
     struct push_entry *e =3D push=
_list->head;
@@ -820,7 +820,7 @@
                 msg(M_WARN, "--push optio=
n is too long");
                 return false;
             }
-           =
 if (BLEN(buf) + (int)l >=3D safe_cap)
+            if (BLENZ(buf) + l >=3D=
 safe_cap)
             {
                 buf_printf(buf, ",push-continuat=
ion 2");
                 {
@@ -835,7 +835,7 @@
                     buf_pr=
intf(buf, "%s", push_reply_cmd);
                 }
             }
-       =
     if (BLEN(buf) + (int)l >=3D safe_cap)
+            if (BLENZ(buf) + l =
>=3D safe_cap)
             {
                 msg(M_WARN, "--push option i=
s too long");
                 return false;
@@ -873,8 +873,8 @@
     struc=
t gc_arena gc =3D gc_new();
     struct buffer buf =3D alloc_buf_gc(PUSH_BU=
NDLE_SIZE, &gc);
     bool multi_push =3D false;
-    const int extra =3D 8=
4; /* extra space for possible trailing ifconfig and push-continuation */
-=
    const int safe_cap =3D BCAP(&buf) - extra;
+    const size_t extra =3D =
84; /* extra space for possible trailing ifconfig and push-continuation */
=
+    const size_t safe_cap =3D BCAP(&buf) - extra;
     bool push_sent =3D =
false;
 
     buf_printf(&buf, "%s", push_reply_cmd);
diff --git a/src/open=
vpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 93e67fd=2E=2E19a2d4=
8 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2E=
c
@@ -1063,7 +1063,6 @@
 key_state_read_ciphertext(struct key_state_ssl *ks=
, struct buffer *buf)
 {
     int retval =3D 0;
-    int len =3D 0;
 
     =
ASSERT(NULL !=3D ks);
     ASSERT(buf);
@@ -1074,9 +1073,7 @@
         retu=
rn 0;
     }
 
-    len =3D buf_forward_capacity(buf);
-
-    retval =3D en=
dless_buf_read(&ks->bio_ctx->out, BPTR(buf), len);
+    retval =3D endless_=
buf_read(&ks->bio_ctx->out, BPTR(buf), BCAP(buf));
 
     /* Error during r=
ead, check for retry error */
     if (retval < 0)
@@ -1148,7 +1145,6 @@
 k=
ey_state_read_plaintext(struct key_state_ssl *ks, struct buffer *buf)
 {
  =
   int retval =3D 0;
-    int len =3D 0;
 
     ASSERT(NULL !=3D ks);
     =
ASSERT(buf);
@@ -1159,9 +1155,7 @@
         return 0;
     }
 
-    len =3D=
 buf_forward_capacity(buf);
-
-    retval =3D mbedtls_ssl_read(ks->ctx, BPT=
R(buf), len);
+    retval =3D mbedtls_ssl_read(ks->ctx, BPTR(buf), BCAP(buf=
));
 
     /* Error during read, check for retry error */
     if (retval <=
 0)
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index df=
9e42c=2E=2E7b15f5f 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/s=
sl_ncp=2Ec
@@ -154,7 +154,7 @@
             }
 
             /* Ensure buff=
er has capacity for cipher name + : + \0 */
-            if (buf_forward_ca=
pacity(&new_list) < (int)strlen(ovpn_cipher_name) + 2)
+            if (buf=
_forward_capacity(&new_list) < strlen(ovpn_cipher_name) + 2)
             {=

                 msg(M_WARN, "Length of --data-ciphers is over the "
     =
                        "limit of 127 chars");
@@ -563,8 +563,7 @@
     uin=
t8_t *ncp_ciphers =3D gc_malloc(ncp_ciphers_len, true, &o->gc);
 
     stru=
ct buffer ncp_ciphers_buf;
-    ASSERT(ncp_ciphers_len <=3D INT_MAX);
-    =
buf_set_write(&ncp_ciphers_buf, ncp_ciphers, (int)ncp_ciphers_len);
+    bu=
f_set_write(&ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);
 
     const c=
har *def =3D strstr(o->ncp_ciphers, search);
 
diff --git a/src/openvpn/ssl=
_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 57ef9f7=2E=2E30ef383 10064=
4
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -2=
155,13 +2155,12 @@
          * if the buffer is not empty */
         retur=
n 0;
     }
-    int len =3D buf_forward_capacity(buf);
 
     /*
      * B=
IO_read brackets most of the serious RSA
      * key negotiation number cru=
nching=2E
      */
-    int i =3D BIO_read(bio, BPTR(buf), len);
+    int i=
 =3D BIO_read(bio, BPTR(buf), (int)BCAP(buf));
 
     VALGRIND_MAKE_READABL=
E((void *)&i, sizeof(i));
 
diff --git a/src/openvpn/status=2Ec b/src/openv=
pn/status=2Ec
index 533619f=2E=2E0a3fc019 100644
--- a/src/openvpn/status=
=2Ec
+++ b/src/openvpn/status=2Ec
@@ -215,11 +215,6 @@
     return ret;
 }
=
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push=

-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 #define STA=
TUS_PRINTF_MAXLEN 512
 
 void
@@ -281,7 +276,7 @@
             if (c =3D=3D=
 -1)
             {
                 ASSERT(buf_init(&so->read_buf, 0));
- =
               ssize_t len =3D read(so->fd, BPTR(&so->read_buf), BCAP(&so->=
read_buf));
+                ssize_t len =3D read(so->fd, BPTR(&so->read_bu=
f), (unsigned int)BCAP(&so->read_buf));
                 if (len <=3D 0)
  =
               {
                     break;
@@ -311,7 +306,3 @@
 
     ret=
urn ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC dia=
gnostic pop
-#endif
diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tl=
s_crypt=2Ec
index d7f69f7=2E=2E5617ad3 100644
--- a/src/openvpn/tls_crypt=
=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -380,8 +380,8 @@
         msg(M_WAR=
N, "ERROR: could not write tag");
         return false;
     }
-    const =
int data_len =3D BLEN(src_metadata) + sizeof(src_key->keys) + sizeof(uint16=
_t);
-    const int tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;
+    cons=
t size_t data_len =3D BLENZ(src_metadata) + sizeof(src_key->keys) + sizeof(=
uint16_t);
+    const size_t tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;
=
     const uint16_t net_len =3D htons((uint16_t)tagged_len);
     hmac_ctx_=
t *hmac_ctx =3D server_key->hmac;
     hmac_ctx_reset(hmac_ctx);
@@ -396,7 =
+396,7 @@
     ASSERT(cipher_ctx_reset(cipher_ctx, tag));
 
     /* Overflo=
w check (OpenSSL requires an extra block in the dst buffer) */
-    const i=
nt padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx);
+    const =
size_t padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx);
     if=
 (buf_forward_capacity(&work) < padded_len)
     {
         msg(M_WARN, "ER=
ROR: could not crypt: insufficient space in dst");
@@ -735,7 +735,7 @@
    =
     size_t b64_length =3D strlen(b64_metadata);
         metadata =3D allo=
c_buf_gc(OPENVPN_BASE64_DECODED_LENGTH(b64_length) + 1, &gc);
         ASSE=
RT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_USER, 1));
-        int de=
coded_len =3D openvpn_base64_decode(b64_metadata, BEND(&metadata), BCAP(&me=
tadata));
+        int decoded_len =3D openvpn_base64_decode(b64_metadata, =
BEND(&metadata), (int)BCAP(&metadata));
         if (decoded_len < 0)
     =
    {
             msg(M_FATAL, "ERROR: failed to base64 decode provided me=
tadata");
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 0ba8=
a4a=2E=2Ec56ace3 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec=

@@ -4008,7 +4008,7 @@
  * registry for the TAP device # =3D device_number=
=2E
  */
 static const char *
-get_unspecified_device_guid(const int device=
_number, uint8_t *actual_name, int actual_name_size,
+get_unspecified_devic=
e_guid(const int device_number, uint8_t *actual_name, size_t actual_name_si=
ze,
                             const struct tap_reg *tap_reg_src,
       =
                      const struct panel_reg *panel_reg_src,
              =
               enum tun_driver_type *windows_driver, struct gc_arena *gc)
@=
@ -4071,7 +4071,7 @@
  * returning the GUID and optional actual_name and de=
vice type
  */
 static const char *
-get_device_guid(const char *name, uint=
8_t *actual_name, int actual_name_size,
+get_device_guid(const char *name, =
uint8_t *actual_name, size_t actual_name_size,
                 enum tun_dr=
iver_type *windows_driver, const struct tap_reg *tap_reg,
                 =
const struct panel_reg *panel_reg, struct gc_arena *gc)
 {
@@ -6087,8 +6087=
,9 @@
     {
         struct buffer out =3D alloc_buf_gc(256, gc);
        =
 DWORD len;
-        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_INFO, =
BSTR(&out), BCAP(&out), BSTR(&out),
-                            BCAP(&out)=
, &len, NULL))
+        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_INF=
O, BSTR(&out),
+                            (DWORD)BCAP(&out), BSTR(&out),
=
+                            (DWORD)BCAP(&out), &len, NULL))
         {
   =
          return BSTR(&out);
         }
@@ -6103,8 +6104,8 @@
     {
      =
   struct buffer out =3D alloc_buf(1024);
         DWORD len;
-        whil=
e (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&out), BCAP(&=
out),
-                               BSTR(&out), BCAP(&out), &len, NULL))
=
+        while (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(=
&out), (DWORD)BCAP(&out),
+                               BSTR(&out), (DWOR=
D)BCAP(&out), &len, NULL))
         {
             msg(D_TAP_WIN_DEBUG, "TA=
P-Windows: %s", BSTR(&out));
         }

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
Gerrit-Chang=
e-Number: 2198
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--75vRYuTmv0I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2198?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">buffer: Switch buf_forward_capacit=
y and buf_set_write to size_t<br><br>To make them consistent with buf_forwa=
rd_capacity_total<br>and buf_set_read that were already switched=2E<br><br>=
Review call sites=2E<br><br>Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4=
b9972<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<b=
r>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198<br>Message-Id: &lt;2026111710=
1909=2E30743-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41509=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvp=
n/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto=2Ec<br>M s=
rc/openvpn/crypto_openssl=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/ss=
l_mbedtls=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_openssl=2Ec=
<br>M src/openvpn/status=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvp=
n/tun=2Ec<br>11 files changed, 39 insertions(+), 56 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><=
br><span>index c60936a=2E=2Ec33a987 100644</span><br><span>--- a/src/openvp=
n/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@=
@ -234,17 +234,16 @@</span><br><span>     if (buf_defined(buf))</span><br><=
span>     {</span><br><span>         char *ptr =3D (char *)BEND(buf);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        int cap =3D buf_for=
ward_capacity(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        size_t cap =3D buf_forward_capacity(buf);</span><br><span> </span><=
br><span>         if (cap &gt; 1) /* can write more than \0 */</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     int stat;</span><br><span>             va_list arglist;</span><br><spa=
n>             va_start(arglist, format);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            stat =3D vsnprintf(ptr, cap, format, arglis=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int =
stat =3D vsnprintf(ptr, cap, format, arglist);</span><br><span>            =
 va_end(arglist);</span><br><span>             buf-&gt;len +=3D (int)strnle=
n(ptr, cap);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (stat &gt;=3D 0 &amp;&amp; stat &lt; cap)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (stat &gt;=3D 0 &amp;&amp; stat =
&lt; (int)cap)</span><br><span>             {</span><br><span>             =
    ret =3D true;</span><br><span>             }</span><br><span>@@ -257,11=
 +256,11 @@</span><br><span> buf_puts(struct buffer *buf, const char *str)<=
/span><br><span> {</span><br><span>     char *ptr =3D (char *)BEND(buf);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int cap =3D buf_forw=
ard_capacity(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   size_t cap =3D buf_forward_capacity(buf);</span><br><span>     if (cap &=
gt; 1) /* can write more than \0 */</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        int str_len =3D (int)strlcpy(p=
tr, str, cap);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 buf-&gt;len +=3D (str_len &lt; cap) ? str_len : cap - 1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        size_t str_len =3D strlcpy(pt=
r, str, cap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  buf-&gt;len +=3D (str_len &lt; cap) ? (int)str_len : (int)cap - 1;</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span>diff =
--git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>ind=
ex 541f0bd=2E=2E32b49d3 100644</span><br><span>--- a/src/openvpn/buffer=2Eh=
</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -643,11 +6=
43,6 @@</span><br><span>     return true;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  *=
 Initialise a buffer with an externally provided writable memory region=2E<=
/span><br><span>  *</span><br><span>@@ -660,7 +655,7 @@</span><br><span>  *=
 @param size  Size of the memory region in bytes=2E</span><br><span>  */</s=
pan><br><span> static inline void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-buf_set_write(struct buffer *buf, uint8_t *data, int size)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_set_write(struct buf=
fer *buf, uint8_t *data, size_t size)</span><br><span> {</span><br><span>  =
   if (!buf_size_valid(size))</span><br><span>     {</span><br><span>@@ -66=
8,7 +663,7 @@</span><br><span>     }</span><br><span>     buf-&gt;len =3D 0=
;</span><br><span>     buf-&gt;offset =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    buf-&gt;capacity =3D size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;capacity =3D (int)size;</span=
><br><span>     buf-&gt;data =3D data;</span><br><span>     if (size &gt; 0=
 &amp;&amp; data)</span><br><span>     {</span><br><span>@@ -1039,7 +1034,7=
 @@</span><br><span>  * @return Number of bytes available for appending, or=
 0 if \c buf is</span><br><span>  *         invalid=2E</span><br><span>  */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline size_t</s=
pan><br><span> buf_forward_capacity(const struct buffer *buf)</span><br><sp=
an> {</span><br><span>     if (buf_valid(buf))</span><br><span>@@ -1049,7 +=
1044,7 @@</span><br><span>         {</span><br><span>             ret =3D 0=
;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return ret;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return (size_t)ret;</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span>@@ -1252,6 +1247,11 @@</spa=
n><br><span>     return true;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Prepend data to a buffer=2E</span><br><span>  *</span><br><span>diff --git=
 a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index db=
1cb41=2E=2E8b4cc3b 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</spa=
n><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1825,7 +1825,7=
 @@</span><br><span> bool</span><br><span> generate_ephemeral_key(struct bu=
ffer *key, const char *key_name)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const int len =3D BCAP(key);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const int len =3D (int)BCA=
P(key);</span><br><span> </span><br><span>     msg(M_INFO, &quot;Using rand=
om %s=2E&quot;, key_name);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><s=
pan>index 0a1d00c=2E=2E1246bc6 100644</span><br><span>--- a/src/openvpn/cry=
pto_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span>=
<br><span>@@ -523,7 +523,7 @@</span><br><span>     uint8_t *dst_data =3D bu=
f_write_alloc(dst, data_read_len);</span><br><span>     if (!dst_data)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     dmsg(D_CRYPT_ERRORS, &quot;%s: dst too small (%i, needs %li)&quot;, __=
func__, BCAP(dst),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       dmsg(D_CRYPT_ERRORS, &quot;%s: dst too small (%zu, needs %li)&quot;,=
 __func__, BCAP(dst),</span><br><span>              data_read_len);</span><=
br><span>         goto cleanup;</span><br><span>     }</span><br><span>diff=
 --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index =
6f628b8=2E=2Eeb11107 100644</span><br><span>--- a/src/openvpn/push=2Ec</spa=
n><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -805,7 +805,7 @@<=
/span><br><span> #endif</span><br><span> </span><br><span> static bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-send_push_options(struct c=
ontext *c, struct buffer *buf, struct push_list *push_list, int safe_cap,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_options(str=
uct context *c, struct buffer *buf, struct push_list *push_list, size_t saf=
e_cap,</span><br><span>                   bool *push_sent, bool *multi_push=
)</span><br><span> {</span><br><span>     struct push_entry *e =3D push_lis=
t-&gt;head;</span><br><span>@@ -820,7 +820,7 @@</span><br><span>           =
      msg(M_WARN, &quot;--push option is too long&quot;);</span><br><span> =
                return false;</span><br><span>             }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(buf) + (int)l &=
gt;=3D safe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (BLENZ(buf) + l &gt;=3D safe_cap)</span><br><span>             =
{</span><br><span>                 buf_printf(buf, &quot;,push-continuation=
 2&quot;);</span><br><span>                 {</span><br><span>@@ -835,7 +83=
5,7 @@</span><br><span>                     buf_printf(buf, &quot;%s&quot;,=
 push_reply_cmd);</span><br><span>                 }</span><br><span>      =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (BLEN(buf) + (int)l &gt;=3D safe_cap)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (BLENZ(buf) + l &gt;=3D safe_cap)</span>=
<br><span>             {</span><br><span>                 msg(M_WARN, &quot=
;--push option is too long&quot;);</span><br><span>                 return =
false;</span><br><span>@@ -873,8 +873,8 @@</span><br><span>     struct gc_a=
rena gc =3D gc_new();</span><br><span>     struct buffer buf =3D alloc_buf_=
gc(PUSH_BUNDLE_SIZE, &amp;gc);</span><br><span>     bool multi_push =3D fal=
se;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int extr=
a =3D 84; /* extra space for possible trailing ifconfig and push-continuati=
on */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int sa=
fe_cap =3D BCAP(&amp;buf) - extra;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const size_t extra =3D 84; /* extra space for possible t=
railing ifconfig and push-continuation */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const size_t safe_cap =3D BCAP(&amp;buf) - extra;=
</span><br><span>     bool push_sent =3D false;</span><br><span> </span><br=
><span>     buf_printf(&amp;buf, &quot;%s&quot;, push_reply_cmd);</span><br=
><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>index 93e67fd=2E=2E19a2d48 100644</span><br><span>--- =
a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>@@ -1063,7 +1063,6 @@</span><br><span> key_state_read_=
ciphertext(struct key_state_ssl *ks, struct buffer *buf)</span><br><span> {=
</span><br><span>     int retval =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int len =3D 0;</span><br><span> </span><br><span>    =
 ASSERT(NULL !=3D ks);</span><br><span>     ASSERT(buf);</span><br><span>@@=
 -1074,9 +1073,7 @@</span><br><span>         return 0;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   len =3D buf_forward_capacity(buf);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
etval =3D endless_buf_read(&amp;ks-&gt;bio_ctx-&gt;out, BPTR(buf), len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    retval =3D endless=
_buf_read(&amp;ks-&gt;bio_ctx-&gt;out, BPTR(buf), BCAP(buf));</span><br><sp=
an> </span><br><span>     /* Error during read, check for retry error */</s=
pan><br><span>     if (retval &lt; 0)</span><br><span>@@ -1148,7 +1145,6 @@=
</span><br><span> key_state_read_plaintext(struct key_state_ssl *ks, struct=
 buffer *buf)</span><br><span> {</span><br><span>     int retval =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D 0;</span>=
<br><span> </span><br><span>     ASSERT(NULL !=3D ks);</span><br><span>    =
 ASSERT(buf);</span><br><span>@@ -1159,9 +1155,7 @@</span><br><span>       =
  return 0;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    len =3D buf_forward_capacity(buf);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    retval =3D mbedtls_ssl_read(ks-&gt;ctx, BPT=
R(buf), len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
tval =3D mbedtls_ssl_read(ks-&gt;ctx, BPTR(buf), BCAP(buf));</span><br><spa=
n> </span><br><span>     /* Error during read, check for retry error */</sp=
an><br><span>     if (retval &lt; 0)</span><br><span>diff --git a/src/openv=
pn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index df9e42c=2E=
=2E7b15f5f 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><=
span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -154,7 +154,7 @@</spa=
n><br><span>             }</span><br><span> </span><br><span>             /=
* Ensure buffer has capacity for cipher name + : + \0 */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (buf_forward_capacity(&am=
p;new_list) &lt; (int)strlen(ovpn_cipher_name) + 2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (buf_forward_capacity(&amp=
;new_list) &lt; strlen(ovpn_cipher_name) + 2)</span><br><span>             =
{</span><br><span>                 msg(M_WARN, &quot;Length of --data-ciphe=
rs is over the &quot;</span><br><span>                             &quot;li=
mit of 127 chars&quot;);</span><br><span>@@ -563,8 +563,7 @@</span><br><spa=
n>     uint8_t *ncp_ciphers =3D gc_malloc(ncp_ciphers_len, true, &amp;o-&gt=
;gc);</span><br><span> </span><br><span>     struct buffer ncp_ciphers_buf;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(ncp_cipher=
s_len &lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    buf_set_write(&amp;ncp_ciphers_buf, ncp_ciphers, (int)ncp_ciphers_len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_write=
(&amp;ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);</span><br><span> </sp=
an><br><span>     const char *def =3D strstr(o-&gt;ncp_ciphers, search);</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/=
src/openvpn/ssl_openssl=2Ec</span><br><span>index 57ef9f7=2E=2E30ef383 1006=
44</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/=
src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -2155,13 +2155,12 @@</span><=
br><span>          * if the buffer is not empty */</span><br><span>        =
 return 0;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int len =3D buf_forward_capacity(buf);</span><br><span> </s=
pan><br><span>     /*</span><br><span>      * BIO_read brackets most of the=
 serious RSA</span><br><span>      * key negotiation number crunching=2E</s=
pan><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int i =3D BIO_read(bio, BPTR(buf), len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int i =3D BIO_read(bio, BPTR(buf), (int)BCAP(=
buf));</span><br><span> </span><br><span>     VALGRIND_MAKE_READABLE((void =
*)&amp;i, sizeof(i));</span><br><span> </span><br><span>diff --git a/src/op=
envpn/status=2Ec b/src/openvpn/status=2Ec</span><br><span>index 533619f=2E=
=2E0a3fc019 100644</span><br><span>--- a/src/openvpn/status=2Ec</span><br><=
span>+++ b/src/openvpn/status=2Ec</span><br><span>@@ -215,11 +215,6 @@</spa=
n><br><span>     return ret;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> #define STATUS_PRINTF_MAXLEN 512</sp=
an><br><span> </span><br><span> void</span><br><span>@@ -281,7 +276,7 @@</s=
pan><br><span>             if (c =3D=3D -1)</span><br><span>             {<=
/span><br><span>                 ASSERT(buf_init(&amp;so-&gt;read_buf, 0));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ssize=
_t len =3D read(so-&gt;fd, BPTR(&amp;so-&gt;read_buf), BCAP(&amp;so-&gt;rea=
d_buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     ssize_t len =3D read(so-&gt;fd, BPTR(&amp;so-&gt;read_buf), (unsigned =
int)BCAP(&amp;so-&gt;read_buf));</span><br><span>                 if (len &=
lt;=3D 0)</span><br><span>                 {</span><br><span>              =
       break;</span><br><span>@@ -311,7 +306,3 @@</span><br><span> </span><=
br><span>     return ret;</span><br><span> }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span>diff --git a/src/openvp=
n/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index d7f69f7=
=2E=2E5617ad3 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span>=
<br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -380,8 +380,8 =
@@</span><br><span>         msg(M_WARN, &quot;ERROR: could not write tag&qu=
ot;);</span><br><span>         return false;</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const int data_len =3D BL=
EN(src_metadata) + sizeof(src_key-&gt;keys) + sizeof(uint16_t);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    const int tagged_len =3D data=
_len + TLS_CRYPT_TAG_SIZE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const size_t data_len =3D BLENZ(src_metadata) + sizeof(src_key-&=
gt;keys) + sizeof(uint16_t);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const size_t tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;</sp=
an><br><span>     const uint16_t net_len =3D htons((uint16_t)tagged_len);</=
span><br><span>     hmac_ctx_t *hmac_ctx =3D server_key-&gt;hmac;</span><br=
><span>     hmac_ctx_reset(hmac_ctx);</span><br><span>@@ -396,7 +396,7 @@</=
span><br><span>     ASSERT(cipher_ctx_reset(cipher_ctx, tag));</span><br><s=
pan> </span><br><span>     /* Overflow check (OpenSSL requires an extra blo=
ck in the dst buffer) */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const int padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t =
padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx);</span><br><spa=
n>     if (buf_forward_capacity(&amp;work) &lt; padded_len)</span><br><span=
>     {</span><br><span>         msg(M_WARN, &quot;ERROR: could not crypt: =
insufficient space in dst&quot;);</span><br><span>@@ -735,7 +735,7 @@</span=
><br><span>         size_t b64_length =3D strlen(b64_metadata);</span><br><=
span>         metadata =3D alloc_buf_gc(OPENVPN_BASE64_DECODED_LENGTH(b64_l=
ength) + 1, &amp;gc);</span><br><span>         ASSERT(buf_write(&amp;metada=
ta, &amp;TLS_CRYPT_METADATA_TYPE_USER, 1));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int decoded_len =3D openvpn_base64_decode(b64=
_metadata, BEND(&amp;metadata), BCAP(&amp;metadata));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int decoded_len =3D openvpn_base6=
4_decode(b64_metadata, BEND(&amp;metadata), (int)BCAP(&amp;metadata));</spa=
n><br><span>         if (decoded_len &lt; 0)</span><br><span>         {</sp=
an><br><span>             msg(M_FATAL, &quot;ERROR: failed to base64 decode=
 provided metadata&quot;);</span><br><span>diff --git a/src/openvpn/tun=2Ec=
 b/src/openvpn/tun=2Ec</span><br><span>index 0ba8a4a=2E=2Ec56ace3 100644</s=
pan><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/t=
un=2Ec</span><br><span>@@ -4008,7 +4008,7 @@</span><br><span>  * registry f=
or the TAP device # =3D device_number=2E</span><br><span>  */</span><br><sp=
an> static const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-get_unspecified_device_guid(const int device_number, uint8_t *actual_name=
, int actual_name_size,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+get_unspecified_device_guid(const int device_number, uint8_t *actual_na=
me, size_t actual_name_size,</span><br><span>                             c=
onst struct tap_reg *tap_reg_src,</span><br><span>                         =
    const struct panel_reg *panel_reg_src,</span><br><span>                =
             enum tun_driver_type *windows_driver, struct gc_arena *gc)</sp=
an><br><span>@@ -4071,7 +4071,7 @@</span><br><span>  * returning the GUID a=
nd optional actual_name and device type</span><br><span>  */</span><br><spa=
n> static const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-get_device_guid(const char *name, uint8_t *actual_name, int actual_name_si=
ze,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_device_guid(=
const char *name, uint8_t *actual_name, size_t actual_name_size,</span><br>=
<span>                 enum tun_driver_type *windows_driver, const struct t=
ap_reg *tap_reg,</span><br><span>                 const struct panel_reg *p=
anel_reg, struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -6087,=
8 +6087,9 @@</span><br><span>     {</span><br><span>         struct buffer =
out =3D alloc_buf_gc(256, gc);</span><br><span>         DWORD len;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (DeviceIoControl(tt=
-&gt;hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&amp;out), BCAP(&amp;out), BSTR(&am=
p;out),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
              BCAP(&amp;out), &amp;len, NULL))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (DeviceIoControl(tt-&gt;hand, TAP_WIN=
_IOCTL_GET_INFO, BSTR(&amp;out),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            (DWORD)BCAP(&amp;out), BSTR(&amp;o=
ut),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
             (DWORD)BCAP(&amp;out), &amp;len, NULL))</span><br><span>      =
   {</span><br><span>             return BSTR(&amp;out);</span><br><span>  =
       }</span><br><span>@@ -6103,8 +6104,8 @@</span><br><span>     {</span=
><br><span>         struct buffer out =3D alloc_buf(1024);</span><br><span>=
         DWORD len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      while (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(=
&amp;out), BCAP(&amp;out),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                               BSTR(&amp;out), BCAP(&amp;out), &amp;le=
n, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wh=
ile (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&amp;out=
), (DWORD)BCAP(&amp;out),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                               BSTR(&amp;out), (DWORD)BCAP(&amp;out),=
 &amp;len, NULL))</span><br><span>         {</span><br><span>             m=
sg(D_TAP_WIN_DEBUG, &quot;TAP-Windows: %s&quot;, BSTR(&amp;out));</span><br=
><span>         }</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail">change 2198</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9c2403c21ef8f21a0=
fbd998346c8ad719b4b9972 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2198 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--75vRYuTmv0I=--


--===============1430979497467605159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1430979497467605159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1430979497467605159==--

