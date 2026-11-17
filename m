Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C4606A331
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lwWK+IHI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MTJ8cNy7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HL/qNUtj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NAQxfyR3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=C3TLu8gTdr6gxrwf184YHJUCoQURnXmOHh4f9h8KaCM=; b=lwWK+IHIbj1M3keJsO4abnZo4H
	R/QONUgBfv/h1LNm3s1vVlTMM56TX2XJpZlyW0rVbEmN4+SUwov1pvgJPCaMreEKMunPi+sQk9Fey
	y6AjUyALD29YY+x+Y15qoUnBVOqEkdVjhRKDsEvIfiZ9knMWfheQg8lA4NdfT4ibf8JU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGB7-000000001Wg-0oZZ;
	Tue, 17 Nov 2026 10:12:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTGB5-000000001WZ-1G0E
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4mpwOaeiD63mG4f80IF/Zyi9N+uGWjmRkMdkexZrXhM=; b=MTJ8cNy7CKnSiGGBzS/OvmGD3U
 4sPHhgQ7vPeYJMMbo0S/JhhoF5/PfuH/vlxQNCxlDrTZ8GSImcQVIOJc/Ygu80iJEp7sso8lx/ZQB
 oHsuLMEJ3sc82cm4R6RuOJDPDVfmkuKebHQm6o7ZvX0mt/geSUoLKb4xX8ao71zUUGTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4mpwOaeiD63mG4f80IF/Zyi9N+uGWjmRkMdkexZrXhM=; b=HL/qNUtjpa+AvlPl/9rmWCasvi
 Pcw+hfQRtGMWzGgShCJqyAJAql6mXH54IEo4LyI2yFd0pDAjh5HnbP2lp0yxzOx2zY87Kd1VYESo0
 uMlVLOrSVDun2jGoA4Z1FjJJbuTrZhDkgUJv0u5cVvlf/yLUZVpq54D0tGQl1DFoAN7M=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTGB3-000000001iw-1NY4 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:12:39 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so28327475e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794910351; x=1795515151; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4mpwOaeiD63mG4f80IF/Zyi9N+uGWjmRkMdkexZrXhM=;
 b=NAQxfyR3/K6UFKgvMEG8gMxVszLuh7X/CulHgqrbMUgNbY4IFr6W243LIdRM+STmBu
 iipZBZo7q20MOjaFYipSkVuoTmzSOJVkWniYMvam+TGz+flKPghKfTjYE5R8Nb2RZgcX
 DuEpHwXa1nrsXm8T+Ru0Bx4oM3GfbPsRY8/6wTb9qf1CCXRyTl3V1f7UrkauqN0KF1IE
 n81Re+xxRfneZ1d0+a64bOGI5Qz8TVt8ib6uICtENBz3adIbs/W4PVDaOe+0Peb8OngO
 9GtZztaFeBhj1S6ikui0FkqFTI+aTf7SSCeXDa3XQIuDxhWyqXd/eVrocNzJuvK8lXQU
 IgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794910351; x=1795515151;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4mpwOaeiD63mG4f80IF/Zyi9N+uGWjmRkMdkexZrXhM=;
 b=OCXSt/E9HDfYMdlz2EQdVTMaC678FqylUPzgfQAYoSiheFMfxb1RbiH2IO4NeO7rBH
 s9jCdbwU8WLTzhSKE5QqoAqkGtHYQsPDtJReAXeur25dDbjVlAmwmzuEHjkJ0wQ21fGZ
 uoXEGHzId+qVSPEQdUnDqqjmgUwgyi8hawXhK7yKBhjuIS1S+IWSkEtb12U6d0eNxn1W
 JEyyL0i8qyxWyT4T188gribAU/aY8/JNxdh5bLacCS1C6D+5O2ei3YK6Hq5F5dkw5yIn
 Uw0Wu03zV5vV7Ezrvp+UtZDZjnAZm39UhpqExybC18r4fNvNWYYkXNo7N14Kt4RpkuLD
 Jdig==
X-Gm-Message-State: APuU4Z9hZjzH8TOOIVKKjw0J3hhMyZ0FbmkPWkrKHGh0t05x9HRlMtm6
 9wHDifu9P+pCnLRGNWE8mfuVaap3qCsl+JNix5GwfJ1umvevxgQjRYURu2nqE3AvuSYEZ/XGBT6
 Kdw6BbdJRvX/uVt4s3KNsY1NRZO1iny1TkJmHv1vwB+X2gtRPebNN5yVlnrKocG6xaw3O
X-Gm-Gg: AYBFou2rjDNMf4M6J8VSm0DlMlmcs0vWbqLpHQLkD4FH/qaTMm9l1XjY3MHIUGQrCEz
 VaveB719xOQ0m5Tm1jAhU5Y9mPik++lGEkgupTcv5fkcYmO7iREUkZgQ173EBmprEuywcgRFmpM
 hk1JLj6IPKMLO2QG10M4d7/NWUPUpjXF/FyJOA9OkB90fQsOjGa3AcduTdADc7vCDaPl+co1p9P
 lxbqCWGsWLOmNs5S448utEsDU6HSWWJ9xa1exDUNXlvszKc3xPLS6/vF5ixPiA2S+9w6Iuywg78
 WDD2xZNUStVi5T9rXZPNJ0a7UAe3bakcYEihAu9qp9xtV24+9+poLc1dLqN7vqpC6OcbzTHMmvf
 +G2bw2MNYMaFs2UNOpgUaWjPqqzFsca5Vse+4sNRVKESXJbus3Cm0ZsuEUSAqozLPBn647Bkb1A
 fRJ9GLtRh2EmeZtTn9uYqP0zMpqVUc9u2wbNSLTNT6flDFYY7R+BNDgob2GbAT143uVdkOEjbkv
 K/BvbvQuPSJ17YeVfL/KSRiQiCH+PzcAitV2mcC5/0/fATtZANG8/WIuAE5IhbDBjgBaWuugiXP
 ul0TlwQ1ly0/K5ueJhE+E5FHGzdxgAt/Kg8n4V9QPKkYu3IuZ3FKwVDimrn+LHkmwl8IGwkTRUW
 jdvsfsbrpquUYFVH3y9GUrd3IHnqZI9Yd43EnPhR+N/xCyrIwI2oT3elQ95uRvfmwDix0LwobA6
 /j3IT6Eh7xpg2RyEY=
X-Received: by 2002:a05:600c:6286:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4bb55a5d634mr260908475e9.5.1794910350312; 
 Tue, 17 Nov 2026 02:12:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571d7e87sm251234005e9.3.2026.11.17.02.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:12:29 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:12:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
X-Gerrit-Change-Number: 2198
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2198?usp=email>
X-Gerrit-Commit: 6fd15e316f10888e29a439d4da99e1ff4b032f5c
In-Reply-To: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkk5YzI0MDNjMjFlZjhmMjFhMGZiZDk5ODM0NmM4YWQ3MTliNGI5OTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3de2a73601be86da0c1ca526b8f77e8ac5456ae-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTGB3-000000001iw-1NY4
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5165980454857116859=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5165980454857116859==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GnpLl8fpExI="; charset=UTF-8

--GnpLl8fpExI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2198?usp=3Demail

to look at the new patch set (#3)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by R=C4=83z=
van Cojocaru

The change is no longer submittable: Code-Review and checks~C=
hecksSubmitRule are unsatisfied now=2E


Change subject: buffer: Switch buf=
_forward_capacity and buf_set_write to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Switch buf_forward_capacity and =
buf_set_write to size_t

To make them consistent with buf_forward_capacity_=
total
and buf_set_read that were already switched=2E

Review call sites=2E
=

Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
Signed-off-by: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
M src/op=
envpn/buffer=2Eh
M src/openvpn/crypto=2Ec
M src/openvpn/crypto_openssl=2Ec
=
M src/openvpn/push=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_ncp=
=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/status=2Ec
M src/openvpn/t=
ls_crypt=2Ec
M src/openvpn/tun=2Ec
11 files changed, 39 insertions(+), 56 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/98/2198/3

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=
=2Ec
index c60936a=2E=2Ec33a987 100644
--- a/src/openvpn/buffer=2Ec
+++ b/s=
rc/openvpn/buffer=2Ec
@@ -234,17 +234,16 @@
     if (buf_defined(buf))
    =
 {
         char *ptr =3D (char *)BEND(buf);
-        int cap =3D buf_forwa=
rd_capacity(buf);
+        size_t cap =3D buf_forward_capacity(buf);
 
    =
     if (cap > 1) /* can write more than \0 */
         {
-            int =
stat;
             va_list arglist;
             va_start(arglist, format);=

-            stat =3D vsnprintf(ptr, cap, format, arglist);
+            i=
nt stat =3D vsnprintf(ptr, cap, format, arglist);
             va_end(argli=
st);
             buf->len +=3D (int)strnlen(ptr, cap);
-            if (st=
at >=3D 0 && stat < cap)
+            if (stat >=3D 0 && stat < (int)cap)
 =
            {
                 ret =3D true;
             }
@@ -257,11 +256=
,11 @@
 buf_puts(struct buffer *buf, const char *str)
 {
     char *ptr =3D=
 (char *)BEND(buf);
-    int cap =3D buf_forward_capacity(buf);
+    size_t=
 cap =3D buf_forward_capacity(buf);
     if (cap > 1) /* can write more tha=
n \0 */
     {
-        int str_len =3D (int)strlcpy(ptr, str, cap);
-     =
   buf->len +=3D (str_len < cap) ? str_len : cap - 1;
+        size_t str_l=
en =3D strlcpy(ptr, str, cap);
+        buf->len +=3D (str_len < cap) ? (in=
t)str_len : (int)cap - 1;
     }
 }
 
diff --git a/src/openvpn/buffer=2Eh b=
/src/openvpn/buffer=2Eh
index 541f0bd=2E=2E32b49d3 100644
--- a/src/openvpn=
/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -643,11 +643,6 @@
     return t=
rue;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnos=
tic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /**=

  * Initialise a buffer with an externally provided writable memory region=
=2E
  *
@@ -660,7 +655,7 @@
  * @param size  Size of the memory region in b=
ytes=2E
  */
 static inline void
-buf_set_write(struct buffer *buf, uint8_t=
 *data, int size)
+buf_set_write(struct buffer *buf, uint8_t *data, size_t =
size)
 {
     if (!buf_size_valid(size))
     {
@@ -668,7 +663,7 @@
     }
=
     buf->len =3D 0;
     buf->offset =3D 0;
-    buf->capacity =3D size;
+=
    buf->capacity =3D (int)size;
     buf->data =3D data;
     if (size > 0=
 && data)
     {
@@ -1039,7 +1034,7 @@
  * @return Number of bytes availabl=
e for appending, or 0 if \c buf is
  *         invalid=2E
  */
-static inli=
ne int
+static inline size_t
 buf_forward_capacity(const struct buffer *buf=
)
 {
     if (buf_valid(buf))
@@ -1049,7 +1044,7 @@
         {
            =
 ret =3D 0;
         }
-        return ret;
+        return (size_t)ret;
  =
   }
     else
     {
@@ -1252,6 +1247,11 @@
     return true;
 }
 
+#if de=
fined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma=
 GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Prepend data=
 to a buffer=2E
  *
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypt=
o=2Ec
index db1cb41=2E=2E8b4cc3b 100644
--- a/src/openvpn/crypto=2Ec
+++ b/=
src/openvpn/crypto=2Ec
@@ -1825,7 +1825,7 @@
 bool
 generate_ephemeral_key(=
struct buffer *key, const char *key_name)
 {
-    const int len =3D BCAP(ke=
y);
+    const int len =3D (int)BCAP(key);
 
     msg(M_INFO, "Using random=
 %s=2E", key_name);
 
diff --git a/src/openvpn/crypto_openssl=2Ec b/src/ope=
nvpn/crypto_openssl=2Ec
index 0a1d00c=2E=2E1246bc6 100644
--- a/src/openvpn=
/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -523,7 +523,7 @=
@
     uint8_t *dst_data =3D buf_write_alloc(dst, data_read_len);
     if (=
!dst_data)
     {
-        dmsg(D_CRYPT_ERRORS, "%s: dst too small (%i, nee=
ds %li)", __func__, BCAP(dst),
+        dmsg(D_CRYPT_ERRORS, "%s: dst too s=
mall (%zu, needs %li)", __func__, BCAP(dst),
              data_read_len);
=
         goto cleanup;
     }
diff --git a/src/openvpn/push=2Ec b/src/openv=
pn/push=2Ec
index 6f628b8=2E=2Eeb11107 100644
--- a/src/openvpn/push=2Ec
++=
+ b/src/openvpn/push=2Ec
@@ -805,7 +805,7 @@
 #endif
 
 static bool
-send_p=
ush_options(struct context *c, struct buffer *buf, struct push_list *push_l=
ist, int safe_cap,
+send_push_options(struct context *c, struct buffer *buf=
, struct push_list *push_list, size_t safe_cap,
                   bool *pu=
sh_sent, bool *multi_push)
 {
     struct push_entry *e =3D push_list->head=
;
@@ -820,7 +820,7 @@
                 msg(M_WARN, "--push option is too lo=
ng");
                 return false;
             }
-            if (BLEN(b=
uf) + (int)l >=3D safe_cap)
+            if (BLENZ(buf) + l >=3D safe_cap)
=
             {
                 buf_printf(buf, ",push-continuation 2");
  =
               {
@@ -835,7 +835,7 @@
                     buf_printf(buf, "=
%s", push_reply_cmd);
                 }
             }
-            if (BL=
EN(buf) + (int)l >=3D safe_cap)
+            if (BLENZ(buf) + l >=3D safe_c=
ap)
             {
                 msg(M_WARN, "--push option is too long"=
);
                 return false;
@@ -873,8 +873,8 @@
     struct gc_arena =
gc =3D gc_new();
     struct buffer buf =3D alloc_buf_gc(PUSH_BUNDLE_SIZE, =
&gc);
     bool multi_push =3D false;
-    const int extra =3D 84; /* extra=
 space for possible trailing ifconfig and push-continuation */
-    const i=
nt safe_cap =3D BCAP(&buf) - extra;
+    const size_t extra =3D 84; /* extr=
a space for possible trailing ifconfig and push-continuation */
+    const =
size_t safe_cap =3D BCAP(&buf) - extra;
     bool push_sent =3D false;
 
  =
   buf_printf(&buf, "%s", push_reply_cmd);
diff --git a/src/openvpn/ssl_mbe=
dtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 93e67fd=2E=2E19a2d48 100644
--=
- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1063,=
7 +1063,6 @@
 key_state_read_ciphertext(struct key_state_ssl *ks, struct bu=
ffer *buf)
 {
     int retval =3D 0;
-    int len =3D 0;
 
     ASSERT(NULL=
 !=3D ks);
     ASSERT(buf);
@@ -1074,9 +1073,7 @@
         return 0;
     =
}
 
-    len =3D buf_forward_capacity(buf);
-
-    retval =3D endless_buf_r=
ead(&ks->bio_ctx->out, BPTR(buf), len);
+    retval =3D endless_buf_read(&k=
s->bio_ctx->out, BPTR(buf), BCAP(buf));
 
     /* Error during read, check =
for retry error */
     if (retval < 0)
@@ -1148,7 +1145,6 @@
 key_state_re=
ad_plaintext(struct key_state_ssl *ks, struct buffer *buf)
 {
     int retv=
al =3D 0;
-    int len =3D 0;
 
     ASSERT(NULL !=3D ks);
     ASSERT(buf)=
;
@@ -1159,9 +1155,7 @@
         return 0;
     }
 
-    len =3D buf_forwar=
d_capacity(buf);
-
-    retval =3D mbedtls_ssl_read(ks->ctx, BPTR(buf), len=
);
+    retval =3D mbedtls_ssl_read(ks->ctx, BPTR(buf), BCAP(buf));
 
     =
/* Error during read, check for retry error */
     if (retval < 0)
diff --=
git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index df9e42c=2E=2E=
7b15f5f 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
=
@@ -154,7 +154,7 @@
             }
 
             /* Ensure buffer has capa=
city for cipher name + : + \0 */
-            if (buf_forward_capacity(&new=
_list) < (int)strlen(ovpn_cipher_name) + 2)
+            if (buf_forward_ca=
pacity(&new_list) < strlen(ovpn_cipher_name) + 2)
             {
          =
       msg(M_WARN, "Length of --data-ciphers is over the "
                =
             "limit of 127 chars");
@@ -563,8 +563,7 @@
     uint8_t *ncp_c=
iphers =3D gc_malloc(ncp_ciphers_len, true, &o->gc);
 
     struct buffer n=
cp_ciphers_buf;
-    ASSERT(ncp_ciphers_len <=3D INT_MAX);
-    buf_set_wri=
te(&ncp_ciphers_buf, ncp_ciphers, (int)ncp_ciphers_len);
+    buf_set_write=
(&ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);
 
     const char *def =
=3D strstr(o->ncp_ciphers, search);
 
diff --git a/src/openvpn/ssl_openssl=
=2Ec b/src/openvpn/ssl_openssl=2Ec
index 57ef9f7=2E=2E30ef383 100644
--- a/=
src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -2155,13 +=
2155,12 @@
          * if the buffer is not empty */
         return 0;
   =
  }
-    int len =3D buf_forward_capacity(buf);
 
     /*
      * BIO_read =
brackets most of the serious RSA
      * key negotiation number crunching=
=2E
      */
-    int i =3D BIO_read(bio, BPTR(buf), len);
+    int i =3D B=
IO_read(bio, BPTR(buf), (int)BCAP(buf));
 
     VALGRIND_MAKE_READABLE((voi=
d *)&i, sizeof(i));
 
diff --git a/src/openvpn/status=2Ec b/src/openvpn/sta=
tus=2Ec
index 533619f=2E=2E0a3fc019 100644
--- a/src/openvpn/status=2Ec
+++=
 b/src/openvpn/status=2Ec
@@ -215,11 +215,6 @@
     return ret;
 }
 
-#if d=
efined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragm=
a GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 #define STATUS_PRIN=
TF_MAXLEN 512
 
 void
@@ -281,7 +276,7 @@
             if (c =3D=3D -1)
   =
          {
                 ASSERT(buf_init(&so->read_buf, 0));
-         =
       ssize_t len =3D read(so->fd, BPTR(&so->read_buf), BCAP(&so->read_buf=
));
+                ssize_t len =3D read(so->fd, BPTR(&so->read_buf), (uns=
igned int)BCAP(&so->read_buf));
                 if (len <=3D 0)
          =
       {
                     break;
@@ -311,7 +306,3 @@
 
     return ret;=

 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic =
pop
-#endif
diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=
=2Ec
index d7f69f7=2E=2E5617ad3 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ =
b/src/openvpn/tls_crypt=2Ec
@@ -380,8 +380,8 @@
         msg(M_WARN, "ERROR=
: could not write tag");
         return false;
     }
-    const int data_=
len =3D BLEN(src_metadata) + sizeof(src_key->keys) + sizeof(uint16_t);
-   =
 const int tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;
+    const size_t =
data_len =3D BLENZ(src_metadata) + sizeof(src_key->keys) + sizeof(uint16_t)=
;
+    const size_t tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;
     cons=
t uint16_t net_len =3D htons((uint16_t)tagged_len);
     hmac_ctx_t *hmac_c=
tx =3D server_key->hmac;
     hmac_ctx_reset(hmac_ctx);
@@ -396,7 +396,7 @@=

     ASSERT(cipher_ctx_reset(cipher_ctx, tag));
 
     /* Overflow check (=
OpenSSL requires an extra block in the dst buffer) */
-    const int padded=
_len =3D data_len + cipher_ctx_block_size(cipher_ctx);
+    const size_t pa=
dded_len =3D data_len + cipher_ctx_block_size(cipher_ctx);
     if (buf_for=
ward_capacity(&work) < padded_len)
     {
         msg(M_WARN, "ERROR: coul=
d not crypt: insufficient space in dst");
@@ -735,7 +735,7 @@
         size=
_t b64_length =3D strlen(b64_metadata);
         metadata =3D alloc_buf_gc(=
OPENVPN_BASE64_DECODED_LENGTH(b64_length) + 1, &gc);
         ASSERT(buf_wr=
ite(&metadata, &TLS_CRYPT_METADATA_TYPE_USER, 1));
-        int decoded_len=
 =3D openvpn_base64_decode(b64_metadata, BEND(&metadata), BCAP(&metadata));=

+        int decoded_len =3D openvpn_base64_decode(b64_metadata, BEND(&met=
adata), (int)BCAP(&metadata));
         if (decoded_len < 0)
         {
   =
          msg(M_FATAL, "ERROR: failed to base64 decode provided metadata");=

diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 0ba8a4a=2E=2E=
c56ace3 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -4008=
,7 +4008,7 @@
  * registry for the TAP device # =3D device_number=2E
  */
 =
static const char *
-get_unspecified_device_guid(const int device_number, u=
int8_t *actual_name, int actual_name_size,
+get_unspecified_device_guid(con=
st int device_number, uint8_t *actual_name, size_t actual_name_size,
      =
                       const struct tap_reg *tap_reg_src,
                 =
            const struct panel_reg *panel_reg_src,
                        =
     enum tun_driver_type *windows_driver, struct gc_arena *gc)
@@ -4071,7 =
+4071,7 @@
  * returning the GUID and optional actual_name and device type
=
  */
 static const char *
-get_device_guid(const char *name, uint8_t *actua=
l_name, int actual_name_size,
+get_device_guid(const char *name, uint8_t *a=
ctual_name, size_t actual_name_size,
                 enum tun_driver_type =
*windows_driver, const struct tap_reg *tap_reg,
                 const stru=
ct panel_reg *panel_reg, struct gc_arena *gc)
 {
@@ -6087,8 +6087,9 @@
    =
 {
         struct buffer out =3D alloc_buf_gc(256, gc);
         DWORD len=
;
-        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&out)=
, BCAP(&out), BSTR(&out),
-                            BCAP(&out), &len, NU=
LL))
+        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&o=
ut),
+                            (DWORD)BCAP(&out), BSTR(&out),
+         =
                   (DWORD)BCAP(&out), &len, NULL))
         {
             =
return BSTR(&out);
         }
@@ -6103,8 +6104,8 @@
     {
         struct =
buffer out =3D alloc_buf(1024);
         DWORD len;
-        while (DeviceI=
oControl(tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&out), BCAP(&out),
-   =
                            BSTR(&out), BCAP(&out), &len, NULL))
+        w=
hile (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&out), (DW=
ORD)BCAP(&out),
+                               BSTR(&out), (DWORD)BCAP(&ou=
t), &len, NULL))
         {
             msg(D_TAP_WIN_DEBUG, "TAP-Windows:=
 %s", BSTR(&out));
         }

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2198?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
Gerrit-Change-Num=
ber: 2198
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>

--GnpLl8fpExI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #3</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/219=
8?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><p>The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">buffer: Switch buf_forward_capacity and buf_set=
_write to size_t<br><br>To make them consistent with buf_forward_capacity_t=
otal<br>and buf_set_read that were already switched=2E<br><br>Review call s=
ites=2E<br><br>Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M sr=
c/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto=2E=
c<br>M src/openvpn/crypto_openssl=2Ec<br>M src/openvpn/push=2Ec<br>M src/op=
envpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_ope=
nssl=2Ec<br>M src/openvpn/status=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M sr=
c/openvpn/tun=2Ec<br>11 files changed, 39 insertions(+), 56 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/98/2198/3</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/=
openvpn/buffer=2Ec</span><br><span>index c60936a=2E=2Ec33a987 100644</span>=
<br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/bu=
ffer=2Ec</span><br><span>@@ -234,17 +234,16 @@</span><br><span>     if (buf=
_defined(buf))</span><br><span>     {</span><br><span>         char *ptr =
=3D (char *)BEND(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        int cap =3D buf_forward_capacity(buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        size_t cap =3D buf_forward_capacity(buf=
);</span><br><span> </span><br><span>         if (cap &gt; 1) /* can write =
more than \0 */</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            int stat;</span><br><span>             va_=
list arglist;</span><br><span>             va_start(arglist, format);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            stat =3D vsnpri=
ntf(ptr, cap, format, arglist);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            int stat =3D vsnprintf(ptr, cap, format, arglist);<=
/span><br><span>             va_end(arglist);</span><br><span>             =
buf-&gt;len +=3D (int)strnlen(ptr, cap);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (stat &gt;=3D 0 &amp;&amp; stat &lt; cap)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (sta=
t &gt;=3D 0 &amp;&amp; stat &lt; (int)cap)</span><br><span>             {</=
span><br><span>                 ret =3D true;</span><br><span>             =
}</span><br><span>@@ -257,11 +256,11 @@</span><br><span> buf_puts(struct bu=
ffer *buf, const char *str)</span><br><span> {</span><br><span>     char *p=
tr =3D (char *)BEND(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int cap =3D buf_forward_capacity(buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size_t cap =3D buf_forward_capacity(buf);</s=
pan><br><span>     if (cap &gt; 1) /* can write more than \0 */</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t str_len =3D (int)strlcpy(ptr, str, cap);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        buf-&gt;len +=3D (str_len &lt; cap) ? str_len =
: cap - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
ize_t str_len =3D strlcpy(ptr, str, cap);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        buf-&gt;len +=3D (str_len &lt; cap) ? (int)st=
r_len : (int)cap - 1;</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/bu=
ffer=2Eh</span><br><span>index 541f0bd=2E=2E32b49d3 100644</span><br><span>=
--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</=
span><br><span>@@ -643,11 +643,6 @@</span><br><span>     return true;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> /**</span><br><span>  * Initialise a buffer with an externally provide=
d writable memory region=2E</span><br><span>  *</span><br><span>@@ -660,7 +=
655,7 @@</span><br><span>  * @param size  Size of the memory region in byte=
s=2E</span><br><span>  */</span><br><span> static inline void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-buf_set_write(struct buffer *buf, u=
int8_t *data, int size)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+buf_set_write(struct buffer *buf, uint8_t *data, size_t size)</span><br=
><span> {</span><br><span>     if (!buf_size_valid(size))</span><br><span> =
    {</span><br><span>@@ -668,7 +663,7 @@</span><br><span>     }</span><br>=
<span>     buf-&gt;len =3D 0;</span><br><span>     buf-&gt;offset =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;capacity =3D=
 size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;c=
apacity =3D (int)size;</span><br><span>     buf-&gt;data =3D data;</span><b=
r><span>     if (size &gt; 0 &amp;&amp; data)</span><br><span>     {</span>=
<br><span>@@ -1039,7 +1034,7 @@</span><br><span>  * @return Number of bytes=
 available for appending, or 0 if \c buf is</span><br><span>  *         inv=
alid=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static inline size_t</span><br><span> buf_forward_capacity(const struc=
t buffer *buf)</span><br><span> {</span><br><span>     if (buf_valid(buf))<=
/span><br><span>@@ -1049,7 +1044,7 @@</span><br><span>         {</span><br>=
<span>             ret =3D 0;</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return ret;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return (size_t)ret;</span><br><s=
pan>     }</span><br><span>     else</span><br><span>     {</span><br><span=
>@@ -1252,6 +1247,11 @@</span><br><span>     return true;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> /**</span><br><span>  * Prepend data to a buffer=2E</span><br><span>  =
*</span><br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=
=2Ec</span><br><span>index db1cb41=2E=2E8b4cc3b 100644</span><br><span>--- =
a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span=
><br><span>@@ -1825,7 +1825,7 @@</span><br><span> bool</span><br><span> gen=
erate_ephemeral_key(struct buffer *key, const char *key_name)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int le=
n =3D BCAP(key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const int len =3D (int)BCAP(key);</span><br><span> </span><br><span>     m=
sg(M_INFO, &quot;Using random %s=2E&quot;, key_name);</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/cryp=
to_openssl=2Ec</span><br><span>index 0a1d00c=2E=2E1246bc6 100644</span><br>=
<span>--- a/src/openvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/openvp=
n/crypto_openssl=2Ec</span><br><span>@@ -523,7 +523,7 @@</span><br><span>  =
   uint8_t *dst_data =3D buf_write_alloc(dst, data_read_len);</span><br><sp=
an>     if (!dst_data)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        dmsg(D_CRYPT_ERRORS, &quot;%s: dst too smal=
l (%i, needs %li)&quot;, __func__, BCAP(dst),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        dmsg(D_CRYPT_ERRORS, &quot;%s: dst too sm=
all (%zu, needs %li)&quot;, __func__, BCAP(dst),</span><br><span>          =
    data_read_len);</span><br><span>         goto cleanup;</span><br><span>=
     }</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=
=2Ec</span><br><span>index 6f628b8=2E=2Eeb11107 100644</span><br><span>--- =
a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br=
><span>@@ -805,7 +805,7 @@</span><br><span> #endif</span><br><span> </span>=
<br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-send_push_options(struct context *c, struct buffer *buf, struct push_list =
*push_list, int safe_cap,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+send_push_options(struct context *c, struct buffer *buf, struct push_=
list *push_list, size_t safe_cap,</span><br><span>                   bool *=
push_sent, bool *multi_push)</span><br><span> {</span><br><span>     struct=
 push_entry *e =3D push_list-&gt;head;</span><br><span>@@ -820,7 +820,7 @@<=
/span><br><span>                 msg(M_WARN, &quot;--push option is too lon=
g&quot;);</span><br><span>                 return false;</span><br><span>  =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (BLEN(buf) + (int)l &gt;=3D safe_cap)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (BLENZ(buf) + l &gt;=3D safe_cap)</s=
pan><br><span>             {</span><br><span>                 buf_printf(bu=
f, &quot;,push-continuation 2&quot;);</span><br><span>                 {</s=
pan><br><span>@@ -835,7 +835,7 @@</span><br><span>                     buf_=
printf(buf, &quot;%s&quot;, push_reply_cmd);</span><br><span>              =
   }</span><br><span>             }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if (BLEN(buf) + (int)l &gt;=3D safe_cap)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (BLENZ(buf) +=
 l &gt;=3D safe_cap)</span><br><span>             {</span><br><span>       =
          msg(M_WARN, &quot;--push option is too long&quot;);</span><br><sp=
an>                 return false;</span><br><span>@@ -873,8 +873,8 @@</span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     struc=
t buffer buf =3D alloc_buf_gc(PUSH_BUNDLE_SIZE, &amp;gc);</span><br><span> =
    bool multi_push =3D false;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const int extra =3D 84; /* extra space for possible trailing i=
fconfig and push-continuation */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    const int safe_cap =3D BCAP(&amp;buf) - extra;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const size_t extra =3D 84; /*=
 extra space for possible trailing ifconfig and push-continuation */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t safe_cap =
=3D BCAP(&amp;buf) - extra;</span><br><span>     bool push_sent =3D false;<=
/span><br><span> </span><br><span>     buf_printf(&amp;buf, &quot;%s&quot;,=
 push_reply_cmd);</span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec =
b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 93e67fd=2E=2E19a2d48 10=
0644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ =
b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -1063,7 +1063,6 @@</span><=
br><span> key_state_read_ciphertext(struct key_state_ssl *ks, struct buffer=
 *buf)</span><br><span> {</span><br><span>     int retval =3D 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D 0;</span><br><sp=
an> </span><br><span>     ASSERT(NULL !=3D ks);</span><br><span>     ASSERT=
(buf);</span><br><span>@@ -1074,9 +1073,7 @@</span><br><span>         retur=
n 0;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    len =3D buf_forward_capacity(buf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    retval =3D endless_buf_read(&amp;ks-&gt;bio_ctx-&gt=
;out, BPTR(buf), len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    retval =3D endless_buf_read(&amp;ks-&gt;bio_ctx-&gt;out, BPTR(buf), =
BCAP(buf));</span><br><span> </span><br><span>     /* Error during read, ch=
eck for retry error */</span><br><span>     if (retval &lt; 0)</span><br><s=
pan>@@ -1148,7 +1145,6 @@</span><br><span> key_state_read_plaintext(struct =
key_state_ssl *ks, struct buffer *buf)</span><br><span> {</span><br><span> =
    int retval =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int len =3D 0;</span><br><span> </span><br><span>     ASSERT(NULL !=3D =
ks);</span><br><span>     ASSERT(buf);</span><br><span>@@ -1159,9 +1155,7 @=
@</span><br><span>         return 0;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D buf_for=
ward_capacity(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retval =3D mbedtls_=
ssl_read(ks-&gt;ctx, BPTR(buf), len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    retval =3D mbedtls_ssl_read(ks-&gt;ctx, BPTR(buf), BC=
AP(buf));</span><br><span> </span><br><span>     /* Error during read, chec=
k for retry error */</span><br><span>     if (retval &lt; 0)</span><br><spa=
n>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br>=
<span>index df9e42c=2E=2E7b15f5f 100644</span><br><span>--- a/src/openvpn/s=
sl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@=
 -154,7 +154,7 @@</span><br><span>             }</span><br><span> </span><b=
r><span>             /* Ensure buffer has capacity for cipher name + : + \0=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (bu=
f_forward_capacity(&amp;new_list) &lt; (int)strlen(ovpn_cipher_name) + 2)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (buf_f=
orward_capacity(&amp;new_list) &lt; strlen(ovpn_cipher_name) + 2)</span><br=
><span>             {</span><br><span>                 msg(M_WARN, &quot;Le=
ngth of --data-ciphers is over the &quot;</span><br><span>                 =
            &quot;limit of 127 chars&quot;);</span><br><span>@@ -563,8 +563=
,7 @@</span><br><span>     uint8_t *ncp_ciphers =3D gc_malloc(ncp_ciphers_l=
en, true, &amp;o-&gt;gc);</span><br><span> </span><br><span>     struct buf=
fer ncp_ciphers_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ASSERT(ncp_ciphers_len &lt;=3D INT_MAX);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    buf_set_write(&amp;ncp_ciphers_buf, ncp_ciphers, =
(int)ncp_ciphers_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_set_write(&amp;ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);</=
span><br><span> </span><br><span>     const char *def =3D strstr(o-&gt;ncp_=
ciphers, search);</span><br><span> </span><br><span>diff --git a/src/openvp=
n/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index 57ef9=
f7=2E=2E30ef383 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</s=
pan><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -2155,13=
 +2155,12 @@</span><br><span>          * if the buffer is not empty */</spa=
n><br><span>         return 0;</span><br><span>     }</span><br><span style=
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
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=


</body></html>
--GnpLl8fpExI=--


--===============5165980454857116859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5165980454857116859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5165980454857116859==--

