Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A39606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fB8e9yCX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QMGzzeyY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nQTyvauL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HQHgpy4l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lZZQhrC9EqoYPx5/bIOw9L5DCd37EsH+GMOye8Mf8a0=; b=fB8e9yCX0roRsp7Y/qdKEsFaOc
	vZ7eQCz7EG+jAXt7Guvg09t3v4vStcf0vEONouBaj4P4eZy522vwly9BgR+4OB8t+E3k/UyKfd1WP
	+cvLr/iAR5bNQh3wK+xX3xFWmiksH/B1kiWbD+5HQD1P6OFo4EE0CYPfyPX6orgk7XXo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjCv-000000003EK-3LDz;
	Wed, 18 Nov 2026 17:12:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTjCu-000000003EB-01ty
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DZB/5KOkx+pdqBaHkB+0HWpeoWh1zPBwIHDgV+SJFtA=; b=QMGzzeyY/VAuwzvAkF0nuRf0zm
 vyP6b58mlOiAvda5V+gbSOdxMrjaTK/7jH29xv/cFNDRdQrJGn9ZpLoHWDXIPWR+wnp4nY0FQwnK0
 SeyV5P1PStbyTAQduDjBljhH35OuRZJrYljH0oljVMKnx8xN6iTShhB33xJ167G3xlk0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DZB/5KOkx+pdqBaHkB+0HWpeoWh1zPBwIHDgV+SJFtA=; b=nQTyvauLIC0OnBBqCi2PsLgftg
 y6TYOaflnrkx0iaLFOxUjReFaDIXP+SYdo5VGNsBWJPis3J4wRPvVzcjCX0/vJgn14HbKQsNa2A5g
 ob/1QFCBy/cHKbne7R6v2SecaTOPb7K0x5nqXXFoTb82LUgChn1VOlxJUdvzC+Brng0c=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTjCr-000000006yp-3SDX for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:12:27 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so10496565e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795021939; x=1795626739; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DZB/5KOkx+pdqBaHkB+0HWpeoWh1zPBwIHDgV+SJFtA=;
 b=HQHgpy4lEqyah5BBS0y1WuzbFTGCVXGSBe6VUpXJBRWluwDnZaYb+K0KcpnlJR9AP5
 sGC+IUqeX+FG1OGb3Jy+Lo6Ssq4eEyvMbhM+s/UAnLJMCmwqD8KHIeM/16Ipu02viN6k
 vwkzL/4BNn/g2Guy1PHFmbMZ2xsI/7TNP9vZrMYR/mbqcynDYBRJzfJv6PPYOyK4IIyC
 P+5sZC7yJ1kKcffNWp2IOyDbyX7ByU3Ol3oRNDq5L4ekCizg/xYVTA1cn4MD/Y0HZDSt
 3qtLdqBu1efgU3XWzq6yd5VtIVUOHwsH1L7ID4/1rSQmoKMVempQyzSJDxS1p6ymHE6q
 rX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021939; x=1795626739;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DZB/5KOkx+pdqBaHkB+0HWpeoWh1zPBwIHDgV+SJFtA=;
 b=XjjtV5c19KzvrupJe8V+MI1TFch854g/p+XVar0DT4woe9/fZbdm/HRhzGmu0nPIhp
 0Cr8eikFGpJD1XHIzrRxpDUpTCroxJNy534/NjK4CK75v8o/lc1bDo6aJo9GPioRXCFM
 oKrQh8bA6PUzsq3HOzcNtBT1/8MiiXbTDP8cLAEXOvw82qWctRZ2I2UXqqJwcQ9z0vdk
 Su5JCmruibr4fmYZRs7JZKRc9TwzN0d2/uy3kMCS+xP+sB78fqSC8A1Nzwi+miDGCNoE
 5nEj9rALJAkunTKk8L350k7nRV+RZnw35BDouLRuC7FeD4bTyNDAzUFVeQxn/myWecEa
 iweQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHuZM+JHCwJUL5hH9MmLMCvDWMDKVvEWX4yxtRxukgHl6bILw8ngXZk52mUohJ0uCre+R1Uowbq3hhP0qZl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/ShEJ9k9vlfIDJjD5MyqSdW+LqQaorBIIbXubi6P6qJeTxlBEG
 N6lS+mY+2vfBkQpSHeZoVAnXGSCDptww+1iiw8d07ADyDxJ9DRYVGBqnNxff4BxfLceiiTX4eD3
 4gF0nUpS2BpSAKA4tHauvAbOi+1Q5gMcdkXgaBPlE+0FEUTBngPJA6h4ztwd4xHeSfnKSJjZhaO
 W1bEAnQg==
X-Gm-Gg: AYBFou324Ohgy1gooskaex8xspeJu3YmEImhtyp57LK1yf3CT/JcN63Rr8j1ZAaF5RZ
 IDE7bfUJ/4DeCJJwRcQ2UOoI1VhFS0Xv6JsExcv4hV8jon9TiTeNYnLZOYi8Zx9RD5J/w0uALUe
 lNSEfZYvr7NDR/8NRKc0tFM7UxH21IoCB+ZPQB/jiWSYHN0DjSGIopRDOEi2VvCQm+S0CyRUMUf
 R44gbOpijAzoTFnbZOkFzHGDPtY5J87bYqnTlsDFTcVAb1yle2/g4rzrR0hkZ3KJ2Gmr+M8WOIc
 +TBnJyghbSybVELd/ti5gcodDuAw39YqWdpDfHfE/GbLDlG+8rgaf3P1fhWu/K2mY+Bvei5DrKh
 FUkxGA9evvojwFcXhJ9itXmdNcM+HdKnIC/8DaGEFIcfzgoFYE+21XQ28gAcLhyk0pr67GM9ExL
 Hj6T2LCsyAYJns9Hy1digaCf+KszmpCFg88qb1aKPf8eijBHZM7B3xsXjPzptSrLeJgDNMwtFI1
 CmCrNiGHPsrwl8UhE11ioumHu/GMPjbvY9O3if9a97eo0jtjROlV+t2BBL9UDkuamyw+B8lTADZ
 GxldcndNUjd7ZzuXAbLQoPMxLI5WlyZRTT6y03qxG0aHug70wA4VVfy3+Ts5FNPN2X47kX8nMJw
 QnawLkL5zp59FiDlBhyXY2aRcP/DGM3doVYGXM7s0HrTuJJMrGSDg7PiWlZXTKAzltw0aIJoK5X
 5l4F2n7AHWhRex8S0=
X-Received: by 2002:a05:600c:8b6d:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4bb7d6d1d71mr66867355e9.2.1795021938941; 
 Wed, 18 Nov 2026 09:12:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573ba95csm6333237f8f.56.2026.11.18.09.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:12:18 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:12:18 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
X-Gerrit-Change-Number: 2200
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2200?usp=email>
X-Gerrit-Commit: d0b779bd20b6c6da7510f24ecba66afa73bbbb40
In-Reply-To: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
References: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODQwNjcyMDAwLkkzNGRkN2Q0NmM5YmMxNWUzMmYyMzM3NDFjNTI1NzU5NzE1YmI4NDdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2063e30c8ed68ff0ddde81a14bf597a0cf6c47b2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTjCr-000000006yp-3SDX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: manage: Switch all
 sleep methods to unsigned
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
Content-Type: multipart/mixed; boundary="===============0843142726566901043=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0843142726566901043==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HlDKcGBzibc="; charset=UTF-8

--HlDKcGBzibc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2200?usp=3Demail )

Change subject: manage: Switch all sleep me=
thods to unsigned
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

manage: Switch all sleep methods to unsigned

That is consistent with =
sleep(3)=2E

Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2200
Message-Id: <20261117102414=2E31377-1-gert@greenie=2Emuc=2Ede>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg41512=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/resolve=2Ec=

M src/openvpn/win32=2Ec
M src/openvpn/win32=2Eh
M tests/unit_tests/openvpn=
/mock_management=2Ec
6 files changed, 34 insertions(+), 77 deletions(-)



=

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ae30930=
=2E=2E86c498e 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=
=2Ec
@@ -3615,32 +3615,23 @@
     }
 }
 
-#if defined(__GNUC__) || defined(=
__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-W=
sign-conversion"
-#endif
-
 /*
  * Process the management event loop for se=
c seconds
  */
 void
-management_event_loop_n_seconds(struct management *ma=
n, int sec)
+management_event_loop_n_seconds(struct management *man, unsign=
ed int sec)
 {
     if (man_standalone_ok(man))
     {
         volatile in=
t signal_received =3D 0;
         const bool standalone_disabled_save =3D m=
an->persist=2Estandalone_disabled;
-        time_t expire =3D 0;
+        t=
ime_t expire =3D now + sec;
 
         /* This is so M_CLIENT messages will=
 be correctly passed through msg() */
         man->persist=2Estandalone_di=
sabled =3D false;
 
         /* set expire time */
         update_time();
=
-        if (sec >=3D 0)
-        {
-            expire =3D now + sec;
-   =
     }
 
         /* if no client connection, wait for one */
         man_=
wait_for_client_connection(man, &signal_received, expire, 0);
@@ -3662,7 +3=
653,7 @@
                 return;
             }
             update_time()=
;
-        } while (expire && expire > now);
+        } while (expire > now=
);
 
         /* revert state */
         man->persist=2Estandalone_disable=
d =3D standalone_disabled_save;
@@ -4026,7 +4017,7 @@
  * Return true if th=
e caller should not sleep for an additional time interval=2E
  */
 bool
-ma=
nagement_hold(struct management *man, int holdtime)
+management_hold(struct=
 management *man, unsigned int holdtime)
 {
     if (management_would_hold(=
man))
     {
@@ -4044,7 +4035,7 @@
         if (!signal_received)
         =
{
             struct buffer out =3D alloc_buf_gc(128, &gc);
-            b=
uf_printf(&out, ">HOLD:Waiting for hold release:%d", holdtime);
+          =
  buf_printf(&out, ">HOLD:Waiting for hold release:%u", holdtime);
        =
     man->persist=2Especial_state_msg =3D BSTR(&out);
             msg(M_CL=
IENT, "%s", man->persist=2Especial_state_msg);
 
@@ -4244,8 +4235,9 @@
 log=
_history_obj_init(struct log_history *h, int capacity)
 {
     CLEAR(*h);
+=
    ASSERT(capacity > 0);
     h->capacity =3D capacity;
-    ALLOC_ARRAY_C=
LEAR(h->array, struct log_entry, capacity);
+    ALLOC_ARRAY_CLEAR(h->array=
, struct log_entry, (size_t)capacity);
 }
 
 struct log_history *
@@ -4332,=
34 +4324,6 @@
 }
 
 void
-management_sleep(const int n)
-{
-    if (n < 0)
=
-    {
-        return;
-    }
-    else if (management)
-    {
-        ma=
nagement_event_loop_n_seconds(management, n);
-    }
-    else
-    {
-#ifd=
ef _WIN32
-        win32_sleep(n);
-#else
-        if (n > 0)
-        {
- =
           sleep(n);
-        }
-#endif
-    }
-}
-
-#if defined(__GNUC__) =
|| defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-void
 manageme=
nt_check_bytecount_client(struct context *c, struct management *man, struct=
 timeval *timeval)
 {
     if (man->persist=2Ecallback=2Eflags & MCF_SERVER=
)
@@ -4490,30 +4454,28 @@
     gc_free(&gc);
     return false;
 }
-#else /=
* ifdef ENABLE_MANAGEMENT */
+#endif /* ENABLE_MANAGEMENT */
 
 #include "w=
in32=2Eh"
 
-#if !defined(_WIN32) && (defined(__GNUC__) || defined(__clang_=
_))
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-co=
nversion"
-#endif
-
 void
-management_sleep(const int n)
+management_sleep(=
const unsigned int n)
 {
-#ifdef _WIN32
-    win32_sleep(n);
-#else
-    if=
 (n > 0)
+#ifdef ENABLE_MANAGEMENT
+    if (management)
     {
-        sle=
ep(n);
+        management_event_loop_n_seconds(management, n);
     }
-#en=
dif /* ifdef _WIN32 */
-}
-
-#if !defined(_WIN32) && (defined(__GNUC__) || =
defined(__clang__))
-#pragma GCC diagnostic pop
+    else
 #endif
-
-#endif=
 /* ENABLE_MANAGEMENT */
+    {
+#ifdef _WIN32
+        win32_sleep(n);
+#e=
lse
+        if (n > 0)
+        {
+            sleep(n);
+        }
+#endi=
f
+    }
+}
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
in=
dex 82c0caa=2E=2E697f830 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/open=
vpn/manage=2Eh
@@ -387,9 +387,9 @@
 
 bool management_would_hold(struct man=
agement *man);
 
-bool management_hold(struct management *man, int holdtime=
);
+bool management_hold(struct management *man, unsigned int holdtime);
 
=
-void management_event_loop_n_seconds(struct management *man, int sec);
+vo=
id management_event_loop_n_seconds(struct management *man, unsigned int sec=
);
 
 void management_up_down(const struct management *man, const char *upd=
own, const struct env_set *es);
 
@@ -522,6 +522,6 @@
  * A sleep function =
that services the management layer for n seconds rather
  * than doing noth=
ing=2E
  */
-void management_sleep(const int n);
+void management_sleep(con=
st unsigned int n);
 
 #endif /* ifndef MANAGE_H */
diff --git a/src/openvp=
n/resolve=2Ec b/src/openvpn/resolve=2Ec
index b8d9899=2E=2E544e5ea 100644
-=
-- a/src/openvpn/resolve=2Ec
+++ b/src/openvpn/resolve=2Ec
@@ -161,13 +161,=
13 @@
     }
 
     status =3D getaddrinfo(hostname, servname, &hints, res)=
;
-
-    if (status !=3D 0)                      /* parse as numeric addres=
s failed? */
+    /* parse as numeric address failed? */
+    if (status !=
=3D 0)
     {
-        const int fail_wait_interval =3D 5; /* seconds */
+ =
       const unsigned int fail_wait_interval =3D 5; /* seconds */
         =
/* Add +4 to cause integer division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 =
*/
         int resolve_retries =3D
-            (flags & GETADDR_TRY_ONCE)=
 ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
+            (fl=
ags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / (int)fail_wait=
_interval);
         const char *fmt;
         msglvl_t level =3D 0;
 
diff=
 --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 079869f=2E=2Ef=
10c16d 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1=
533,13 +1533,8 @@
 }
 
 void
-win32_sleep(const int n)
+win32_sleep(const u=
nsigned int n)
 {
-    if (n < 0)
-    {
-        return;
-    }
-
     /* =
Sleep() is not interruptible=2E Use a WAIT_OBJECT to catch signal */
 
    =
 if (!HANDLE_DEFINED(win32_signal=2Ein=2Eread))
diff --git a/src/openvpn/wi=
n32=2Eh b/src/openvpn/win32=2Eh
index 39ff7d8=2E=2E8152e71 100644
--- a/src=
/openvpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -323,7 +323,7 @@
 int ope=
nvpn_execve(const struct argv *a, const struct env_set *es, const unsigned =
int flags);
 
 /* Sleep that can be interrupted by signals and exit event *=
/
-void win32_sleep(const int n);
+void win32_sleep(const unsigned int n);
=
 
 /**
  * @brief Fetches a registry value for OpenVPN registry key=2E
diff=
 --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/op=
envpn/mock_management=2Ec
index f572dbb=2E=2Eaea43da 100644
--- a/tests/uni=
t_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_man=
agement=2Ec
@@ -59,6 +59,6 @@
 #endif
 
 void
-management_sleep(const int n=
)
+management_sleep(const unsigned int n)
 {
 }

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
Gerri=
t-Change-Number: 2200
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--HlDKcGBzibc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2200?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: Switch all sleep methods t=
o unsigned<br><br>That is consistent with sleep(3)=2E<br><br>Change-Id: I34=
dd7d46c9bc15e32f233741c525759715bb847c<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
200<br>Message-Id: &lt;20261117102414=2E31377-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41512=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<b=
r>M src/openvpn/resolve=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpn/win=
32=2Eh<br>M tests/unit_tests/openvpn/mock_management=2Ec<br>6 files changed=
, 34 insertions(+), 77 deletions(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ae30930=2E=2E8=
6c498e 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>=
+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3615,32 +3615,23 @@</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /*</span><br><span>  * Process the management ev=
ent loop for sec seconds</span><br><span>  */</span><br><span> void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-management_event_loop_n_secon=
ds(struct management *man, int sec)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+management_event_loop_n_seconds(struct management *man, uns=
igned int sec)</span><br><span> {</span><br><span>     if (man_standalone_o=
k(man))</span><br><span>     {</span><br><span>         volatile int signal=
_received =3D 0;</span><br><span>         const bool standalone_disabled_sa=
ve =3D man-&gt;persist=2Estandalone_disabled;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        time_t expire =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        time_t expire =3D now + sec;</spa=
n><br><span> </span><br><span>         /* This is so M_CLIENT messages will=
 be correctly passed through msg() */</span><br><span>         man-&gt;pers=
ist=2Estandalone_disabled =3D false;</span><br><span> </span><br><span>    =
     /* set expire time */</span><br><span>         update_time();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (sec &gt;=3D 0)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            expire =3D now + sec;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
> </span><br><span>         /* if no client connection, wait for one */</sp=
an><br><span>         man_wait_for_client_connection(man, &amp;signal_recei=
ved, expire, 0);</span><br><span>@@ -3662,7 +3653,7 @@</span><br><span>    =
             return;</span><br><span>             }</span><br><span>       =
      update_time();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       } while (expire &amp;&amp; expire &gt; now);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        } while (expire &gt; now);</span>=
<br><span> </span><br><span>         /* revert state */</span><br><span>   =
      man-&gt;persist=2Estandalone_disabled =3D standalone_disabled_save;</=
span><br><span>@@ -4026,7 +4017,7 @@</span><br><span>  * Return true if the=
 caller should not sleep for an additional time interval=2E</span><br><span=
>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-management_hold(struct management *man, int holdtime)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+management_hold(struct management *=
man, unsigned int holdtime)</span><br><span> {</span><br><span>     if (man=
agement_would_hold(man))</span><br><span>     {</span><br><span>@@ -4044,7 =
+4035,7 @@</span><br><span>         if (!signal_received)</span><br><span> =
        {</span><br><span>             struct buffer out =3D alloc_buf_gc(1=
28, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    buf_printf(&amp;out, &quot;&gt;HOLD:Waiting for hold release:%d&quot;, =
holdtime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   buf_printf(&amp;out, &quot;&gt;HOLD:Waiting for hold release:%u&quot;, h=
oldtime);</span><br><span>             man-&gt;persist=2Especial_state_msg =
=3D BSTR(&amp;out);</span><br><span>             msg(M_CLIENT, &quot;%s&quo=
t;, man-&gt;persist=2Especial_state_msg);</span><br><span> </span><br><span=
>@@ -4244,8 +4235,9 @@</span><br><span> log_history_obj_init(struct log_his=
tory *h, int capacity)</span><br><span> {</span><br><span>     CLEAR(*h);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(capacity &=
gt; 0);</span><br><span>     h-&gt;capacity =3D capacity;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY_CLEAR(h-&gt;array, stru=
ct log_entry, capacity);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ALLOC_ARRAY_CLEAR(h-&gt;array, struct log_entry, (size_t)capacity)=
;</span><br><span> }</span><br><span> </span><br><span> struct log_history =
*</span><br><span>@@ -4332,34 +4324,6 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-management_sleep(const int n)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n=
 &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (management)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        management_event_loop_n_seconds(management, n);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
win32_sleep(n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (n &gt; 0)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            sleep(n);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void</span><br><span> management_check_bytecount_cli=
ent(struct context *c, struct management *man, struct timeval *timeval)</sp=
an><br><span> {</span><br><span>     if (man-&gt;persist=2Ecallback=2Eflags=
 &amp; MCF_SERVER)</span><br><span>@@ -4490,30 +4454,28 @@</span><br><span>=
     gc_free(&amp;gc);</span><br><span>     return false;</span><br><span> =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef ENABL=
E_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if /* ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #include &quo=
t;win32=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if !defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined=
(__clang__))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-management_sleep(const int n)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+management_sleep(const unsigned int n)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    win32_sle=
ep(n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (n &gt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 sleep(n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
anagement_event_loop_n_seconds(management, n);</span><br><span>     }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef _WIN32 */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if !defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__=
clang__))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABL=
E_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        win32_sleep(n);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (n &gt; 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            sleep(n);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=
=2Eh</span><br><span>index 82c0caa=2E=2E697f830 100644</span><br><span>--- =
a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span=
><br><span>@@ -387,9 +387,9 @@</span><br><span> </span><br><span> bool mana=
gement_would_hold(struct management *man);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-bool management_hold(struct manageme=
nt *man, int holdtime);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool management_hold(struct management *man, unsigned int holdtime);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void m=
anagement_event_loop_n_seconds(struct management *man, int sec);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void management_event_loop_n_s=
econds(struct management *man, unsigned int sec);</span><br><span> </span><=
br><span> void management_up_down(const struct management *man, const char =
*updown, const struct env_set *es);</span><br><span> </span><br><span>@@ -5=
22,6 +522,6 @@</span><br><span>  * A sleep function that services the manag=
ement layer for n seconds rather</span><br><span>  * than doing nothing=2E<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid management_sleep(const int n);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void management_sleep(const unsigned int n);</span><br><span=
> </span><br><span> #endif /* ifndef MANAGE_H */</span><br><span>diff --git=
 a/src/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec</span><br><span>index =
b8d9899=2E=2E544e5ea 100644</span><br><span>--- a/src/openvpn/resolve=2Ec</=
span><br><span>+++ b/src/openvpn/resolve=2Ec</span><br><span>@@ -161,13 +16=
1,13 @@</span><br><span>     }</span><br><span> </span><br><span>     statu=
s =3D getaddrinfo(hostname, servname, &amp;hints, res);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (status !=3D 0)                      /* parse as numeri=
c address failed? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* parse as numeric address failed? */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (status !=3D 0)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int fail_wait=
_interval =3D 5; /* seconds */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const unsigned int fail_wait_interval =3D 5; /* seconds =
*/</span><br><span>         /* Add +4 to cause integer division rounding up=
 (1 + 4) =3D 5, (0+4)/5=3D0 */</span><br><span>         int resolve_retries=
 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            (flag=
s &amp; GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_in=
terval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 (flags &amp; GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / (int)f=
ail_wait_interval);</span><br><span>         const char *fmt;</span><br><sp=
an>         msglvl_t level =3D 0;</span><br><span> </span><br><span>diff --=
git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 0=
79869f=2E=2Ef10c16d 100644</span><br><span>--- a/src/openvpn/win32=2Ec</spa=
n><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -1533,13 +1533,8=
 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-win32_sleep(const int n)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+win32_sleep(const unsigned in=
t n)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (n &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Sleep() is not =
interruptible=2E Use a WAIT_OBJECT to catch signal */</span><br><span> </sp=
an><br><span>     if (!HANDLE_DEFINED(win32_signal=2Ein=2Eread))</span><br>=
<span>diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh</span><br>=
<span>index 39ff7d8=2E=2E8152e71 100644</span><br><span>--- a/src/openvpn/w=
in32=2Eh</span><br><span>+++ b/src/openvpn/win32=2Eh</span><br><span>@@ -32=
3,7 +323,7 @@</span><br><span> int openvpn_execve(const struct argv *a, con=
st struct env_set *es, const unsigned int flags);</span><br><span> </span><=
br><span> /* Sleep that can be interrupted by signals and exit event */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void win32_sleep(const in=
t n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void win32_sle=
ep(const unsigned int n);</span><br><span> </span><br><span> /**</span><br>=
<span>  * @brief Fetches a registry value for OpenVPN registry key=2E</span=
><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/test=
s/unit_tests/openvpn/mock_management=2Ec</span><br><span>index f572dbb=2E=
=2Eaea43da 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_manag=
ement=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2E=
c</span><br><span>@@ -59,6 +59,6 @@</span><br><span> #endif</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-management_sleep(const int n)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+management_sleep(const unsigned int n)</span><br><span> {</spa=
n><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail">change 2200</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I34dd7d46c9bc15e32f23=
3741c525759715bb847c </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 2200 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--HlDKcGBzibc=--


--===============0843142726566901043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0843142726566901043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0843142726566901043==--

