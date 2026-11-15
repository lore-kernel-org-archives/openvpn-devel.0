Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451E606A31D
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kgNTl3a4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Lvr2WZxK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iqXtj0L+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L5TRKi28
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0pQsHMa/QTrdN6KuALTlt6ZUWFzia1l5EwA2NwQO6dM=; b=kgNTl3a4aAcha25U9QHGwoebZ6
	fHrj6TJS7c/eO4O4xBR5zywYn9HvxrOvoK49SXBCI1MRIvC5qBFmfcO7nQBlenWio94M3B8B3o7XC
	nJ8DScDjVtvAvPVxX36JACEIB/ypdQJdEv24aX+EkOHOkwvUnH3Yp9NE8LacL7rAoMmA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSehe-000000001n7-0hmH;
	Sun, 15 Nov 2026 18:11:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSehb-000000001n0-1gOM
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 18:11:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=taNFf8dYg0Bx+m2vx0A+62mNy0mzNy6/OBsCcnD7P0A=; b=Lvr2WZxKraBc9B7n6JdxwawGB1
 dJW64Y78jDJ05EFMv+sZfdIUHptxtB57reYGnySAGZshs9Inoou4VeHEHizjVH0H7dS33YkUKHh56
 sae1d+RgbZBWGHMOo4fNBc+kvcAvqSLckv5G0ZznkFpK8Oq8se0WmFOiKWDfGg9r0coc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=taNFf8dYg0Bx+m2vx0A+62mNy0mzNy6/OBsCcnD7P0A=; b=iqXtj0L+hTsU/2Qd4auN5W7D1a
 nEQiXzyaPKNwhbGMuyZyzyIRDj5RuiyAoHQ7zc2L3X837vAlzqvel/wE6S/OnkGMfcfmbeXg114mG
 J+6Ky2TKWRZ70ce2kvdVRBhe9OowmTl7zHSlvt6bSpY9zpPqHPCksXtC1YCZdttvd5N4=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSeha-000000006ae-0Iqd for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 18:11:43 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso30924835e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 10:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794766295; x=1795371095; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=taNFf8dYg0Bx+m2vx0A+62mNy0mzNy6/OBsCcnD7P0A=;
 b=L5TRKi28yw9e3elzja7xNa7xwQgrBvnuenWS/9PP3pfQTy7Lnlb4jo4DiOa/TwjZFJ
 yP9cvrKJ9K1LKzRniyE7A6vKA/mga2mlty8Av44QdsjAlY0BV6bBE6cdaIsrnlgDZJbr
 JP3BgXh1reWHM1tGTe/cYwbRhjPbZ7NicfZbDjvqTWaXe5UeExko1HM7SAGXDaqGj8vK
 5yGZYIv6WhaAqPRHll7R3xmEyxd2pbNTXTCC0oMgIAKb/Q8/lEGv65flIDYVvBFdZIVe
 ivawvTejKYO4N0AC1vHqai7RkLPbotEc3P3hXB/atgjN5ZA8azpFC2MVzUn5KgOgjm2M
 tRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794766295; x=1795371095;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=taNFf8dYg0Bx+m2vx0A+62mNy0mzNy6/OBsCcnD7P0A=;
 b=SgSuiUePxbUTpiZGOJdooaNkY11WUMgiXA7mCOeGyqiOK95oc2SmRr0SyJtf6+pCUt
 s2mQM91ub0xkDqXCOUVLVD0fqCr0ax2e21EmnEYrLcFq1TwG7f5kq9Eazc+2BeXlJtPV
 XqM6IjKBp423+C1OruSYH9vHxk9nuwW9qJth45VNqDQcJeusjsLI0TBvyl/+xI0KursC
 PXEc3M3XN9xAjE0ZyDpJQRsLGCwgPdD7EoLCFxrHy7lYEwronpqyEc/Dz/RnupynRK7R
 rKhpxRWOFxqK/GE5rdVujYaPcU5cUOFouG+HCgU+6dxrhKAWEVpJAH5xfrHbsqXKQ57r
 6TmA==
X-Forwarded-Encrypted: i=1;
 AL+hErFTiQqc0qAfgQdrz7ooy9kUB+79kS7HO8cE0si0Y3M4WxfM4HFguu1WOdW9e82XFWxiby4ETiPSFrDRFFFQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/ObuONYksBdntk7E28odzSzdknePSqmKxpnHq3xAncvJ0fmE0a
 t4+VXX0/jFZoGX74LM+nC231cIgNBKNYWfSp/tiZPFcSzrRu8JKX2JnK4ylt5wAM3AQglznG3nq
 A3vC8zG2GAqtB+XsOKpcepO+nPoskzaZCkjuapa5vAWWxCD6YRZi8H6E/OqR1UG+zXOPY
X-Gm-Gg: AYBFou1B/kDgX2m4Vk4Xdtz5bOB1lEd4zAdlT26JHdunbnZbu8tV4co9L7nHd+6r3Da
 eDRdlCCONGPTPolS2ug/NSAwbnsEMsKP1kOJD9DwOoP2HiMpZjL42TXlCvMObA3PX+FxG2Egrza
 9fhBl2c2eu9qLxrP68dqf7MH2/tkBEGgwC6FIg1t6W2GacFggLSEZfzQtoIwGApchtvSCEjFbMm
 hO9DwHaxnEg3INiqAU9wA7wSj+K1+pMUp7ItdJlcEktWIKykpNRZ31HP8J2XmjodQLi0J+mChfn
 EN2mMHl55rTME4OwS0l7HA1Sm/pse5Bwi98Nyv34ZYKgWHnJLZk7xy8/HK0JaOe3D14XjZDsY3Z
 P9N3Dod1yX7HOm3YDubjT/w2o2RvjoWh781kKcw8WuLQ99N2O7pUdri+12Przv+CwhKOiMjsdKd
 8JA/FKK57GLAzDfXyHtCzD9xOfwKqth5DEQSuMs4urhZR1w1hPxMlS1KkSLplKPQRJLXn7TCanv
 xYHv2HE7TTuix775UwLd3C8ms79wcXvMNI9C2XxV6BNoBsrhsVLrR+CPWIYLdXMxxZYy+zTBcXK
 juxuh+ECLiniUlVhKydmCvcp9tQIfTPid0m8fcS3M6P61zQKtdqhUE3iVDlWFQcDLwG2n7E1YXY
 wFayZzj843kMAAA5CNxHicW4RvPaM6b2zTkjtPKOAQV2exO1QW4KZYPduBFTG1DxOdhtFRXBnWk
 6fWAkkHYMQukXg0TE=
X-Received: by 2002:a05:600c:19d2:b0:4bb:60bd:53b2 with SMTP id
 5b1f17b1804b1-4bb60bd55eamr123155845e9.6.1794766295233; 
 Sun, 15 Nov 2026 10:11:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb62d5ec30sm216901295e9.15.2026.11.15.10.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:11:34 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 18:11:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
X-Gerrit-Change-Number: 2155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2155?usp=email>
X-Gerrit-Commit: df3f9099bd16670a0a8a8571b4a7c9143c150d83
In-Reply-To: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
References: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5MTIxMDAwLkk2MDMzMjFhZTY4OTNkYmRiMDU0ZGVhZTVhOWJmZjVlNTJjYmI3NDI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9023fe1f4de053492f784bf13532ac7e3609d02c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSeha-000000006ae-0Iqd
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1230248435496290270=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1230248435496290270==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uF3C4Bo0djo="; charset=UTF-8

--uF3C4Bo0djo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2155?usp=3Demail )

Change subject: Check the result of uncheck=
ed allocations in the server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Check the result of unchecked allocations in the server

S=
everal allocations were used without a NULL check, so a failed
allocation c=
rashed the server on a NULL pointer instead of stopping
with "Out of Memory=
" like the rest of the code:

- multi_init(): calloc() of m->instances; the=
 server started and then
  crashed in multi_assign_peer_id() on the first c=
lient
- generate_auth_token(), verify_user_pass(): strdup() of auth tokens;=

  generate_auth_token() then called strdup(NULL)
- override_locked_usernam=
e(): strdup() of the override username; the
  strlcpy() from locked_usernam=
e then crashed (with --auth-gen-token)
- backend_x509_get_serial_hex(): mal=
loc() of the serial buffer, which
  BN_bn2binpad() then wrote to

Use strin=
g_alloc(=2E=2E=2E, NULL) instead of strdup(), add
check_malloc_return() aft=
er the calloc(), and allocate the serial
buffer with gc_malloc(), which als=
o copes with a zero serial number
(BN_num_bytes() is 0 there, and malloc(0)=
 may return NULL)=2E

GitHub: closes OpenVPN/openvpn#1142

Assisted-by: Cla=
ude Code:claude-opus-5-5
Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb74=
29
Signed-off-by: Alexandre Laroche <larochealexandre@hotmail=2Ecom>
Acked-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2155
Message-Id: <20261115134718=2E22576-1-gert@gre=
enie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41355=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/auth_token=2Ec
M src/openvpn/multi=2Ec
M =
src/openvpn/ssl_verify=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
4 files cha=
nged, 7 insertions(+), 7 deletions(-)




diff --git a/src/openvpn/auth_tok=
en=2Ec b/src/openvpn/auth_token=2Ec
index b69092c=2E=2E703a0b2 100644
--- a=
/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -275,7 +275=
,7 @@
 
     /* free the auth-token if defined, we will replace it with a n=
ew one */
     free(multi->auth_token);
-    multi->auth_token =3D strdup((=
char *)BPTR(&session_token));
+    multi->auth_token =3D string_alloc((char=
 *)BPTR(&session_token), NULL);
 
     dmsg(D_SHOW_KEYS, "Generated token f=
or client: %s (%s)", multi->auth_token, up->username);
 
@@ -285,7 +285,7 @=
@
          * Save the initial auth token to continue using the same sessio=
n ID
          * and timestamp in updates
          */
-        multi->auth=
_token_initial =3D strdup(multi->auth_token);
+        multi->auth_token_in=
itial =3D string_alloc(multi->auth_token, NULL);
     }
 
     gc_free(&gc)=
;
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 0890480=
=2E=2Eca650ec 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -400,6 +400,7 @@
     m->max_clients =3D t->options=2Emax_clients;
 
 =
    m->instances =3D calloc(m->max_clients, sizeof(struct multi_instance *)=
);
+    check_malloc_return(m->instances);
 
     m->top=2Ec2=2Eevent_set =
=3D t->c2=2Eevent_set;
 
@@ -2623,7 +2624,7 @@
         }
 
         multi-=
>locked_original_username =3D multi->locked_username;
-        multi->locke=
d_username =3D strdup(options->override_username);
+        multi->locked_u=
sername =3D string_alloc(options->override_username, NULL);
 
         /* O=
verride also the common name if username should be set as common
          =
* name */
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=
=2Ec
index 6e9ecb5=2E=2E8641d15 100644
--- a/src/openvpn/ssl_verify=2Ec
+++=
 b/src/openvpn/ssl_verify=2Ec
@@ -1665,7 +1665,7 @@
          * using the s=
ame session ID and initial timestamp in new tokens */
         if (!multi->=
auth_token_initial && (ks->auth_token_state_flags & AUTH_TOKEN_HMAC_OK))
  =
       {
-            multi->auth_token_initial =3D strdup(up->password);
+=
            multi->auth_token_initial =3D string_alloc(up->password, NULL);=

         }
 
         if (session->opt->auth_token_call_auth)
@@ -1780,7 +=
1780,7 @@
             if (!multi->auth_token && (ks->auth_token_state_flag=
s & AUTH_TOKEN_HMAC_OK)
                 && !(ks->auth_token_state_flags & =
AUTH_TOKEN_EXPIRED))
             {
-                multi->auth_token =3D =
strdup(up->password);
+                multi->auth_token =3D string_alloc(u=
p->password, NULL);
             }
 
             /*
diff --git a/src/openv=
pn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index 19339a=
d=2E=2E731ab3e 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/op=
envpn/ssl_verify_openssl=2Ec
@@ -328,11 +328,10 @@
     const ASN1_INTEGER =
*asn1_i =3D X509_get_serialNumber(cert);
     BIGNUM *bn_serial =3D ASN1_IN=
TEGER_to_BN(asn1_i, NULL);
     int len_serial =3D BN_num_bytes(bn_serial);=

-    unsigned char *buf =3D malloc(len_serial);
+    unsigned char *buf =
=3D gc_malloc(len_serial, false, gc);
     BN_bn2binpad(bn_serial, buf, len=
_serial);
 
     char *ret =3D format_hex_ex(buf, len_serial, 0, 1, ":", gc=
);
-    free(buf);
     BN_free(bn_serial);
 
     return ret;

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff=
5e52cbb7429
Gerrit-Change-Number: 2155
Gerrit-PatchSet: 3
Gerrit-Owner: Ale=
xandre Laroche
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--uF3C4Bo0djo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2155?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Check the result of unchecked allo=
cations in the server<br><br>Several allocations were used without a NULL c=
heck, so a failed<br>allocation crashed the server on a NULL pointer instea=
d of stopping<br>with &quot;Out of Memory&quot; like the rest of the code:<=
br><br>- multi_init(): calloc() of m-&gt;instances; the server started and =
then<br>  crashed in multi_assign_peer_id() on the first client<br>- genera=
te_auth_token(), verify_user_pass(): strdup() of auth tokens;<br>  generate=
_auth_token() then called strdup(NULL)<br>- override_locked_username(): str=
dup() of the override username; the<br>  strlcpy() from locked_username the=
n crashed (with --auth-gen-token)<br>- backend_x509_get_serial_hex(): mallo=
c() of the serial buffer, which<br>  BN_bn2binpad() then wrote to<br><br>Us=
e string_alloc(=2E=2E=2E, NULL) instead of strdup(), add<br>check_malloc_re=
turn() after the calloc(), and allocate the serial<br>buffer with gc_malloc=
(), which also copes with a zero serial number<br>(BN_num_bytes() is 0 ther=
e, and malloc(0) may return NULL)=2E<br><br>GitHub: closes OpenVPN/openvpn#=
1142<br><br>Assisted-by: Claude Code:claude-opus-5-5<br>Change-Id: I603321a=
e6893dbdb054deae5a9bff5e52cbb7429<br>Signed-off-by: Alexandre Laroche &lt;l=
arochealexandre@hotmail=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2155<br>Message-Id: &lt;20261115134718=2E22576-1-gert@greenie=2Emuc=2Ede&g=
t;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefor=
ge=2Enet/msg41355=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M src/openvpn/auth_token=2Ec<br>M src/openvpn/multi=
=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl_verify_openssl=2E=
c<br>4 files changed, 7 insertions(+), 7 deletions(-)<br><br></pre>
<pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br>=
<span>index b69092c=2E=2E703a0b2 100644</span><br><span>--- a/src/openvpn/a=
uth_token=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><s=
pan>@@ -275,7 +275,7 @@</span><br><span> </span><br><span>     /* free the =
auth-token if defined, we will replace it with a new one */</span><br><span=
>     free(multi-&gt;auth_token);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    multi-&gt;auth_token =3D strdup((char *)BPTR(&amp;session_t=
oken));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&g=
t;auth_token =3D string_alloc((char *)BPTR(&amp;session_token), NULL);</spa=
n><br><span> </span><br><span>     dmsg(D_SHOW_KEYS, &quot;Generated token =
for client: %s (%s)&quot;, multi-&gt;auth_token, up-&gt;username);</span><b=
r><span> </span><br><span>@@ -285,7 +285,7 @@</span><br><span>          * S=
ave the initial auth token to continue using the same session ID</span><br>=
<span>          * and timestamp in updates</span><br><span>          */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;auth_to=
ken_initial =3D strdup(multi-&gt;auth_token);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        multi-&gt;auth_token_initial =3D string_a=
lloc(multi-&gt;auth_token, NULL);</span><br><span>     }</span><br><span> <=
/span><br><span>     gc_free(&amp;gc);</span><br><span>diff --git a/src/ope=
nvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 0890480=2E=2Ec=
a650ec 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+=
++ b/src/openvpn/multi=2Ec</span><br><span>@@ -400,6 +400,7 @@</span><br><s=
pan>     m-&gt;max_clients =3D t-&gt;options=2Emax_clients;</span><br><span=
> </span><br><span>     m-&gt;instances =3D calloc(m-&gt;max_clients, sizeo=
f(struct multi_instance *));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    check_malloc_return(m-&gt;instances);</span><br><span> </span>=
<br><span>     m-&gt;top=2Ec2=2Eevent_set =3D t-&gt;c2=2Eevent_set;</span><=
br><span> </span><br><span>@@ -2623,7 +2624,7 @@</span><br><span>         }=
</span><br><span> </span><br><span>         multi-&gt;locked_original_usern=
ame =3D multi-&gt;locked_username;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        multi-&gt;locked_username =3D strdup(options-&gt;overr=
ide_username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   multi-&gt;locked_username =3D string_alloc(options-&gt;override_username=
, NULL);</span><br><span> </span><br><span>         /* Override also the co=
mmon name if username should be set as common</span><br><span>          * n=
ame */</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvp=
n/ssl_verify=2Ec</span><br><span>index 6e9ecb5=2E=2E8641d15 100644</span><b=
r><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/=
ssl_verify=2Ec</span><br><span>@@ -1665,7 +1665,7 @@</span><br><span>      =
    * using the same session ID and initial timestamp in new tokens */</spa=
n><br><span>         if (!multi-&gt;auth_token_initial &amp;&amp; (ks-&gt;a=
uth_token_state_flags &amp; AUTH_TOKEN_HMAC_OK))</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi-&gt=
;auth_token_initial =3D strdup(up-&gt;password);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            multi-&gt;auth_token_initial =3D s=
tring_alloc(up-&gt;password, NULL);</span><br><span>         }</span><br><s=
pan> </span><br><span>         if (session-&gt;opt-&gt;auth_token_call_auth=
)</span><br><span>@@ -1780,7 +1780,7 @@</span><br><span>             if (!m=
ulti-&gt;auth_token &amp;&amp; (ks-&gt;auth_token_state_flags &amp; AUTH_TO=
KEN_HMAC_OK)</span><br><span>                 &amp;&amp; !(ks-&gt;auth_toke=
n_state_flags &amp; AUTH_TOKEN_EXPIRED))</span><br><span>             {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                multi-&gt=
;auth_token =3D strdup(up-&gt;password);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                multi-&gt;auth_token =3D string_alloc(=
up-&gt;password, NULL);</span><br><span>             }</span><br><span> </s=
pan><br><span>             /*</span><br><span>diff --git a/src/openvpn/ssl_=
verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>ind=
ex 19339ad=2E=2E731ab3e 100644</span><br><span>--- a/src/openvpn/ssl_verify=
_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span=
><br><span>@@ -328,11 +328,10 @@</span><br><span>     const ASN1_INTEGER *a=
sn1_i =3D X509_get_serialNumber(cert);</span><br><span>     BIGNUM *bn_seri=
al =3D ASN1_INTEGER_to_BN(asn1_i, NULL);</span><br><span>     int len_seria=
l =3D BN_num_bytes(bn_serial);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    unsigned char *buf =3D malloc(len_serial);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    unsigned char *buf =3D gc_malloc(le=
n_serial, false, gc);</span><br><span>     BN_bn2binpad(bn_serial, buf, len=
_serial);</span><br><span> </span><br><span>     char *ret =3D format_hex_e=
x(buf, len_serial, 0, 1, &quot;:&quot;, gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    free(buf);</span><br><span>     BN_free(bn_seria=
l);</span><br><span> </span><br><span>     return ret;</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?us=
p=3Demail">change 2155</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2155?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2155 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Alexandre Laroche </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--uF3C4Bo0djo=--


--===============1230248435496290270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1230248435496290270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1230248435496290270==--

