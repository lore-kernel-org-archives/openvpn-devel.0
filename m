Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1A606A32D
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=csY82vVl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MrxeArZ7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jHCpTVhH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SqDIXocC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NEsgByLL9ZWgFcnUpQd7WRPb4TTLPY2zDM/nSmTjHEE=; b=csY82vVlNVytiMW88Zovkdbh7h
	y3tO84BiUgkPzI3tM5LBmHA+9P71ZvtoWYIYrv6MEsdoEkpIt9fGPVzwDppHKnq40j9Fsn/U4vcoh
	YIyh7KB1uSPM4GpQwV3Tq0W4Rk2NOFf/sqLP9FY0KYfRwFon+Y6qNvAf+VYzqwp6B824=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSZ9c-000000005Zz-3wlx;
	Sun, 15 Nov 2026 12:16:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSZ9L-000000005ZV-2xX6
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 12:15:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1aorQ3a9AaeNTs+mefxSB+3X6ARMcQJWjpRP0nvplsw=; b=MrxeArZ7a+ZjSKaarQ4UtyA4m8
 9UTRgrPZ/sxXxtKt87DyuHnWkQ6kAu/B3Oxt1kzWYZGAUb2/dIiHGh8qDdbxL1479nJW2wVaXwLi5
 TFwCV7AN8xKu6vC7AuMsQaTlZh4hLekCx91N1spFU3KB0pDMYq+YWbkJKVf6qIFQ/Q7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1aorQ3a9AaeNTs+mefxSB+3X6ARMcQJWjpRP0nvplsw=; b=jHCpTVhHaZgFetmP6g/k8vesOD
 pu+O7v/stcnTkAocjzZBtdih6kC+AXFvgwtZ7pNhiNCgRqom8/r/qxrN9cf80tbnP4PUAMOrPLT6Y
 fouDgvIdGWFDp4JtflEG9CsZ+bSCLSqjbYOoMe/q8FRLcQD6kY/m9Ws8owncNC8UJIbA=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSZ9E-000000007Mz-1pgx for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 12:15:53 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so33297125e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 04:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794744945; x=1795349745; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1aorQ3a9AaeNTs+mefxSB+3X6ARMcQJWjpRP0nvplsw=;
 b=SqDIXocCQ8fFosqSyshgHrMEBE4FpS7BMOvMD2+6fOQYIA1YD9usych1rAXiy5POJL
 0QW1e6RDG8YUHkW/yQWZFCqSytaWHBu2ZrUDQl2vXmHiT9mK/9mj4h2qquKyUoypgQz9
 gNOD25xxhKiTfLirUCoh84vc8Yn8o/mIzS3yMPI+IAws/mSMdkKdfcB/N5nW55fXSHkU
 0hnHGeywRQVmniMgBPf5Nq1Cwf6gmU4K2o0WmxKZoGxxh56Hxv4fq/CFR+124VxnZkke
 7aBIb4/onvcbY6chtfu1IlD6QSIHMM42WrRXGwlWm11Y1KD7RGL5TIkcQJ5dogDFRXM3
 l4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794744945; x=1795349745;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1aorQ3a9AaeNTs+mefxSB+3X6ARMcQJWjpRP0nvplsw=;
 b=NDM68IvxoSvtn5mZiEbQXVpXxH2q8A6EvRz6x+zneaskrpHXTIHtqqxBG7dXjPGLfm
 4EcIvoDLF2vACvpPkwiXYGrtXrwREYZuCYnw1Fld290UeihYnkr1cVnpw8YKEZsQkJbj
 Z1byBmaVXR6lU8bkYT0SCnaxvGS5t/C6HRGEjsJw/ztIv7j1vExyxWzmpDZdWZ+6fidD
 u61DwxiBKTgnPWS5uaqeBwWhVJfGxCmjbo0R3imB96ELWdgGzitu22G47Qo6q8lwp+ol
 v9lbTTaA+/mGDHsQ2GkQcJot4yVCHwR/tMX7D6sNzsSq+G3RGMTqBNW2b46Qr0IlERTW
 T9RQ==
X-Gm-Message-State: APuU4Z9GIkrqIaMM4eW+shkKvzqM6UxlM6GIx4Yi1U67nttrSnlKPRXJ
 /eh0wN00t7s5cIWG3LyUt/+a4+vrj63yO65o32MkZDbIUqHbGSM3uPC3jWtbKe7ObIllXFzWm44
 1Q8dVqhfKXM+eSnlVZp0Ki4crOa6ccQwdXyPUuq4qIuQeZlauYXcDoimQnmqRKCbaW2zT
X-Gm-Gg: AYBFou3cTOUcjC5PFh5jIqPWs0xe/TYPEKP2jKFn8SSuXEOeMOI7ibDstnpmsHlsnHK
 UQwlnGeEkyVTqQ7DDfr+FceMlzR5VYh7ASbBm6hxCrNnOkM1QFIgmLrd4YngVNX37T2u49Rv+tq
 KA7z/I5jLj3JvPSi/y8C8mASjkape5OlicLVnK8SrgN9KOEieWQ9BP8tQF4e+AGitKyZSM3/Axt
 yeExI+A0h9G/JCGWa/Zsc5OOy3IGJ3VQ+PbbeoMkVN8E8DNH/24T2G1DlZVVCWd3QsLXtf6TdfG
 ZNid1Kj1WZdaO/VeqvigAsrCGynmhSLANroMBcqJwMV3pynEpAO9WE2igvYwF7pujB1Y9/f6myz
 3nKCvo5vkVNaAA4ur3vA9AQZMRLS5kCGer1n6yHLPqNu9VBg0vjw8IqvR1GyNbnXLwcdq9x1eno
 9mX/yrfwPiRBY0dVybapL1FndD5UIV1l9NZMlU4qL2K3wmuwi8/dt5OFP4BA1tR1NeMUjSm3mss
 JQ5ZYiEycGQOUfwAgdSwC9VyS+uOFCl3KCyDoGBBFkDNKObVIB6ehivR7bhu9R015glTNzwTiLs
 Q63qDRKj0JIozApe+QYtkpxzt+uSOrgq4oJuDTFls+IRHJOaFsWUGph7XX1wm7sfXDSiwGgeDum
 cyiyISp7hAQi89fHTDvxK7UYlpTg6GFar7O+H9AeA1VISTSV9c/LBV6G/SkBY+3oNc/lmd4Nm52
 AtE7dsfP4OzWGeTCw=
X-Received: by 2002:a05:600c:19d2:b0:4bb:60bd:53b2 with SMTP id
 5b1f17b1804b1-4bb60bd55eamr103274165e9.6.1794744944451; 
 Sun, 15 Nov 2026 04:15:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe373casm15708307f8f.30.2026.11.15.04.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 04:15:43 -0800 (PST)
X-Google-Original-From: "Alexandre Laroche (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 12:15:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
X-Gerrit-Change-Number: 2155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2155?usp=email>
X-Gerrit-Commit: 6a596ff7bfdfe93fb03bc11d7967a8507bff1f5d
In-Reply-To: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
References: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5MTIxMDAwLkk2MDMzMjFhZTY4OTNkYmRiMDU0ZGVhZTVhOWJmZjVlNTJjYmI3NDI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dbbc7195d22fbad836a85356bec0ed635cff8e4b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSZ9E-000000007Mz-1pgx
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Check the result of
 unchecked allocations in the server
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alexandre Laroche \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Alexandre Laroche \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7103644466042044682=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7103644466042044682==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="POjKvpC3Iwo="; charset=UTF-8

--POjKvpC3Iwo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Alexandre Laroche, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2155?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: Check the result of unchecked allocations in=
 the server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

C=
heck the result of unchecked allocations in the server

Several allocations=
 were used without a NULL check, so a failed
allocation crashed the server =
on a NULL pointer instead of stopping
with "Out of Memory" like the rest of=
 the code:

- multi_init(): calloc() of m->instances; the server started an=
d then
  crashed in multi_assign_peer_id() on the first client
- generate_a=
uth_token(), verify_user_pass(): strdup() of auth tokens;
  generate_auth_t=
oken() then called strdup(NULL)
- override_locked_username(): strdup() of t=
he override username; the
  strlcpy() from locked_username then crashed (wi=
th --auth-gen-token)
- backend_x509_get_serial_hex(): malloc() of the seria=
l buffer, which
  BN_bn2binpad() then wrote to

Use string_alloc(=2E=2E=2E,=
 NULL) instead of strdup(), add
check_malloc_return() after the calloc(), a=
nd allocate the serial
buffer with gc_malloc(), which also copes with a zer=
o serial number
(BN_num_bytes() is 0 there, and malloc(0) may return NULL)=
=2E

GitHub: closes OpenVPN/openvpn#1142

Assisted-by: Claude Code:claude-o=
pus-5-5
Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
Signed-off-by:=
 Alexandre Laroche <larochealexandre@hotmail=2Ecom>
---
M src/openvpn/auth_=
token=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvp=
n/ssl_verify_openssl=2Ec
4 files changed, 7 insertions(+), 7 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/2155=
/2

diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
in=
dex 84558af=2E=2E10c656e 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/=
openvpn/auth_token=2Ec
@@ -275,7 +275,7 @@
 
     /* free the auth-token if=
 defined, we will replace it with a new one */
     free(multi->auth_token)=
;
-    multi->auth_token =3D strdup((char *)BPTR(&session_token));
+    mul=
ti->auth_token =3D string_alloc((char *)BPTR(&session_token), NULL);
 
    =
 dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)", multi->auth_token=
, up->username);
 
@@ -285,7 +285,7 @@
          * Save the initial auth to=
ken to continue using the same session ID
          * and timestamp in upda=
tes
          */
-        multi->auth_token_initial =3D strdup(multi->auth_=
token);
+        multi->auth_token_initial =3D string_alloc(multi->auth_tok=
en, NULL);
     }
 
     gc_free(&gc);
diff --git a/src/openvpn/multi=2Ec b=
/src/openvpn/multi=2Ec
index 3f514d6=2E=2E662fc9d 100644
--- a/src/openvpn/=
multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -395,6 +395,7 @@
     m->max_clien=
ts =3D t->options=2Emax_clients;
 
     m->instances =3D calloc(m->max_clie=
nts, sizeof(struct multi_instance *));
+    check_malloc_return(m->instance=
s);
 
     m->top=2Ec2=2Eevent_set =3D t->c2=2Eevent_set;
 
@@ -2653,7 +265=
4,7 @@
         }
 
         multi->locked_original_username =3D multi->loc=
ked_username;
-        multi->locked_username =3D strdup(options->override_=
username);
+        multi->locked_username =3D string_alloc(options->overri=
de_username, NULL);
 
         /* Override also the common name if username=
 should be set as common
          * name */
diff --git a/src/openvpn/ssl_v=
erify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0cdec1e=2E=2E9b3f86d 100644
--=
- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1658,7 =
+1658,7 @@
          * using the same session ID and initial timestamp in n=
ew tokens */
         if (!multi->auth_token_initial && (ks->auth_token_sta=
te_flags & AUTH_TOKEN_HMAC_OK))
         {
-            multi->auth_token_i=
nitial =3D strdup(up->password);
+            multi->auth_token_initial =3D=
 string_alloc(up->password, NULL);
         }
 
         if (session->opt->=
auth_token_call_auth)
@@ -1777,7 +1777,7 @@
             if (!multi->auth_t=
oken && (ks->auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
                 =
&& !(ks->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
             {
-    =
            multi->auth_token =3D strdup(up->password);
+                mu=
lti->auth_token =3D string_alloc(up->password, NULL);
             }
 
    =
         /*
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/s=
sl_verify_openssl=2Ec
index 0c36cf2=2E=2E3f1200d 100644
--- a/src/openvpn/s=
sl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -323,11 +=
323,10 @@
     const ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(cert);
=
     BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);
     int len_s=
erial =3D BN_num_bytes(bn_serial);
-    unsigned char *buf =3D malloc(len_s=
erial);
+    unsigned char *buf =3D gc_malloc(len_serial, false, gc);
     =
BN_bn2binpad(bn_serial, buf, len_serial);
 
     char *ret =3D format_hex_e=
x(buf, len_serial, 0, 1, ":", gc);
-    free(buf);
     BN_free(bn_serial);=

 
     return ret;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2155?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
Gerrit-Change-Number: 2155
G=
errit-PatchSet: 2
Gerrit-Owner: Alexandre Laroche
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Attention: Alexandre Laroche
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>

--POjKvpC3Iwo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Alexandre Laroche, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>Alexandre Laroche <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/215=
5?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Che=
ck the result of unchecked allocations in the server<br><br>Several allocat=
ions were used without a NULL check, so a failed<br>allocation crashed the =
server on a NULL pointer instead of stopping<br>with &quot;Out of Memory&qu=
ot; like the rest of the code:<br><br>- multi_init(): calloc() of m-&gt;ins=
tances; the server started and then<br>  crashed in multi_assign_peer_id() =
on the first client<br>- generate_auth_token(), verify_user_pass(): strdup(=
) of auth tokens;<br>  generate_auth_token() then called strdup(NULL)<br>- =
override_locked_username(): strdup() of the override username; the<br>  str=
lcpy() from locked_username then crashed (with --auth-gen-token)<br>- backe=
nd_x509_get_serial_hex(): malloc() of the serial buffer, which<br>  BN_bn2b=
inpad() then wrote to<br><br>Use string_alloc(=2E=2E=2E, NULL) instead of s=
trdup(), add<br>check_malloc_return() after the calloc(), and allocate the =
serial<br>buffer with gc_malloc(), which also copes with a zero serial numb=
er<br>(BN_num_bytes() is 0 there, and malloc(0) may return NULL)=2E<br><br>=
GitHub: closes OpenVPN/openvpn#1142<br><br>Assisted-by: Claude Code:claude-=
opus-5-5<br>Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429<br>Signed-=
off-by: Alexandre Laroche &lt;larochealexandre@hotmail=2Ecom&gt;<br>---<br>=
M src/openvpn/auth_token=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/ss=
l_verify=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>4 files changed, 7 =
insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/2155/2</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>=
index 84558af=2E=2E10c656e 100644</span><br><span>--- a/src/openvpn/auth_to=
ken=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@=
 -275,7 +275,7 @@</span><br><span> </span><br><span>     /* free the auth-t=
oken if defined, we will replace it with a new one */</span><br><span>     =
free(multi-&gt;auth_token);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    multi-&gt;auth_token =3D strdup((char *)BPTR(&amp;session_token))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;auth=
_token =3D string_alloc((char *)BPTR(&amp;session_token), NULL);</span><br>=
<span> </span><br><span>     dmsg(D_SHOW_KEYS, &quot;Generated token for cl=
ient: %s (%s)&quot;, multi-&gt;auth_token, up-&gt;username);</span><br><spa=
n> </span><br><span>@@ -285,7 +285,7 @@</span><br><span>          * Save th=
e initial auth token to continue using the same session ID</span><br><span>=
          * and timestamp in updates</span><br><span>          */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;auth_token_in=
itial =3D strdup(multi-&gt;auth_token);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        multi-&gt;auth_token_initial =3D string_alloc(m=
ulti-&gt;auth_token, NULL);</span><br><span>     }</span><br><span> </span>=
<br><span>     gc_free(&amp;gc);</span><br><span>diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3f514d6=2E=2E662fc9d=
 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi=2Ec</span><br><span>@@ -395,6 +395,7 @@</span><br><span>  =
   m-&gt;max_clients =3D t-&gt;options=2Emax_clients;</span><br><span> </sp=
an><br><span>     m-&gt;instances =3D calloc(m-&gt;max_clients, sizeof(stru=
ct multi_instance *));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    check_malloc_return(m-&gt;instances);</span><br><span> </span><br><s=
pan>     m-&gt;top=2Ec2=2Eevent_set =3D t-&gt;c2=2Eevent_set;</span><br><sp=
an> </span><br><span>@@ -2653,7 +2654,7 @@</span><br><span>         }</span=
><br><span> </span><br><span>         multi-&gt;locked_original_username =
=3D multi-&gt;locked_username;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        multi-&gt;locked_username =3D strdup(options-&gt;override_=
username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
ulti-&gt;locked_username =3D string_alloc(options-&gt;override_username, NU=
LL);</span><br><span> </span><br><span>         /* Override also the common=
 name if username should be set as common</span><br><span>          * name =
*/</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ss=
l_verify=2Ec</span><br><span>index 0cdec1e=2E=2E9b3f86d 100644</span><br><s=
pan>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_=
verify=2Ec</span><br><span>@@ -1658,7 +1658,7 @@</span><br><span>          =
* using the same session ID and initial timestamp in new tokens */</span><b=
r><span>         if (!multi-&gt;auth_token_initial &amp;&amp; (ks-&gt;auth_=
token_state_flags &amp; AUTH_TOKEN_HMAC_OK))</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi-&gt;aut=
h_token_initial =3D strdup(up-&gt;password);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            multi-&gt;auth_token_initial =3D strin=
g_alloc(up-&gt;password, NULL);</span><br><span>         }</span><br><span>=
 </span><br><span>         if (session-&gt;opt-&gt;auth_token_call_auth)</s=
pan><br><span>@@ -1777,7 +1777,7 @@</span><br><span>             if (!multi=
-&gt;auth_token &amp;&amp; (ks-&gt;auth_token_state_flags &amp; AUTH_TOKEN_=
HMAC_OK)</span><br><span>                 &amp;&amp; !(ks-&gt;auth_token_st=
ate_flags &amp; AUTH_TOKEN_EXPIRED))</span><br><span>             {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                multi-&gt;aut=
h_token =3D strdup(up-&gt;password);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                multi-&gt;auth_token =3D string_alloc(up-&=
gt;password, NULL);</span><br><span>             }</span><br><span> </span>=
<br><span>             /*</span><br><span>diff --git a/src/openvpn/ssl_veri=
fy_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index 0=
c36cf2=2E=2E3f1200d 100644</span><br><span>--- a/src/openvpn/ssl_verify_ope=
nssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br=
><span>@@ -323,11 +323,10 @@</span><br><span>     const ASN1_INTEGER *asn1_=
i =3D X509_get_serialNumber(cert);</span><br><span>     BIGNUM *bn_serial =
=3D ASN1_INTEGER_to_BN(asn1_i, NULL);</span><br><span>     int len_serial =
=3D BN_num_bytes(bn_serial);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    unsigned char *buf =3D malloc(len_serial);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned char *buf =3D gc_malloc(len_=
serial, false, gc);</span><br><span>     BN_bn2binpad(bn_serial, buf, len_s=
erial);</span><br><span> </span><br><span>     char *ret =3D format_hex_ex(=
buf, len_serial, 0, 1, &quot;:&quot;, gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    free(buf);</span><br><span>     BN_free(bn_serial)=
;</span><br><span> </span><br><span>     return ret;</span><br></pre><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=
=3Demail">change 2155</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2155?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2155 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Alexandre Laroche </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Alexandre Laroche </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>

</body></html>
--POjKvpC3Iwo=--


--===============7103644466042044682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7103644466042044682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7103644466042044682==--

