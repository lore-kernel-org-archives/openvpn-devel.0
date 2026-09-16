Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0841C982D0
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FbmyomOsVZCF1ADklv9ET78lNQ6Fl4c+l6ye4x9esoU=; b=S9M2Yk9NdCn4/b5S2J0vA/g0g4
	0LXPnPucTv/ZsbdqmWQA4zSpRowWEpDy19WjWDJB9iGuy5FO5nQJtpEeJ1gMpRaQHhS9YhiLhxeNa
	xXg3ecMxI1+7g5tPx3o64skKdDPQ2e1NlWpPXa5cj1Lxq5PYrzRB1x96YOgo4TWM9lNY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6wGu-0001yu-Cy;
	Wed, 16 Sep 2026 20:30:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6wGs-0001yo-EN
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2vKXRS6NWzENP8bj46tFin1xr7KxIID/kCW7p/8i8ls=; b=bdwbOKG4j3OiGD19IrSyKdKx65
 Fmq3QisCx0lYnwLqDa8otvoY/545Y8unKLQTZPPLskjNuGeban+sbL/mOSaccE/Qx9tSvY9WKZc9q
 wLdClFfX0eF24GGlPnXoYYU/j/QVT8r3GzWOs+32zLeZ3FFfj1jSdvbTyBF6L3JsZQNY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2vKXRS6NWzENP8bj46tFin1xr7KxIID/kCW7p/8i8ls=; b=L
 2xJ4VTeyIA1l7pSiAmX5AeNcwHHmCdipmTMR4VTihnXJpFHpr6Kirm+G2QjudRWeLW6CzupWZtCeD
 NU1FGRlM8Xj60w0fZOS9yaICK/FA/YvLUa7cM2PaQ7oH9UwLhoK3JnRIxRe4xA9uRh1/EF8LBRbLF
 FrSCSWWjgBGi0v3s=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6wGp-0007tC-Ga for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:30:23 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633ecdeso138486f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789590613; x=1790195413; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2vKXRS6NWzENP8bj46tFin1xr7KxIID/kCW7p/8i8ls=;
 b=d4JByqkhlgd+/lVXnh4z8zUmJqQQEcUVo3AY13n5kNDBfOv1KKKzhPg9vUoHwOt9wx
 YFtAx22RqkGHuZHuMa/ew84FjffRc33HH8PmUvunHkaJPi+1oDgnb/QyH4dWjDuDmr+b
 ASx+eKSIZQucbd+VtjNW0jim46CzTOewxVgs+rgU3Io2Two+qnvfhi+UReLd0z/BUMh+
 XJRNxcbIcgJLuNMEbIak6Ug18nNX8xUEHVl7Chlzg5nTQFX62hoOrcsHtKKnNhhUOvHS
 OIaXyIPWnfGZThxQ2N5dT/ctosvHOX5W+7F7bfFVOyqD9YuGle1Jxw0AJQgoXq6Jte/Q
 BABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789590613; x=1790195413;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2vKXRS6NWzENP8bj46tFin1xr7KxIID/kCW7p/8i8ls=;
 b=a8DfQSLqN+I7ZBQ0aRsuSV2iR2V9XIP5rEAH89Sk39yHiO/fSkWXJKt5+opQsMuFYb
 WE5hFjz0feEzB1TwwPNsZZjQCIUk3D4KFFVmRp1e3u+CssWS7EohP4O/Ap8FpRUERobg
 Eqgbv+gj6um6tIERuj8X+wR1iT8KuuezKzR59P8/Ezm7daf/T/b9hrRdswbmWYr37Ay5
 jj/4mIsPSilObQbusKN7Qh4OgSVo6FNtEUj8NvAAECtoviKfNxBSpNByAsf4MOhtK1jR
 UswIkK/KxPQjFJ0GagT5PvEsv/3h85J2JccU4gsMrT41b617OXbrLS7S1ubj2nU8q4OQ
 VoYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwt9sR8RKf+1n3qc2F6G1ZrbwrjwG27AUV4icw3Xl155nBgNnSL3M59E6Em/mDhu7zVMjb560cip8fYvYGO@lists.sourceforge.net
X-Gm-Message-State: AFuF++lPj9Tq1n+NI+FtNm7quzqc3rXkDou3o7F4D/uULcP+kRLAndkA
 QPYjjN776MSL7ID/1K0IEAGSLkXs+CFd4eqYgmB4Sl1I30wkodKGUW6F9Ic7XtD+5qNw1avGPTB
 G/orBdKYN8lL4jmXrHLhThbxBM7p9hA70CXDJGhsBULDj8NvJiESPvrnfLAUg61D+pbFq
X-Gm-Gg: AYBFou1yYI8DVb8es4KglHteEC88sE0BdcaXrCtN60h5IYaQumdsREJrtwumU8wePqN
 mLOuo4WTku2CY+Uot32r4fb7b9ntZHY7JExXmlXyRUKGBeSAeGsDGSQd1OLeg3ODRF9hdd5na+S
 piLMMQJOZXkUf0q20kdHVG0f0Gjdtq6ZihLl0wEODtRa40p5K3sVFMH2CuuEhaagNUni2RE5i9+
 Vrgaw2zbwhhcGVv4EKSwYBHrKC3YiJcgJ7b4w4gQiu0j7TcMBUy9W0/ovMximHX7hTikm2uRnL5
 s8FspNX8+H7bAi6Qp4m97G3pr8+Fb5Vl+MfLHmGawgCT/zESwBqbVDwxJQrTcTePpk/GgHpwqj2
 P0bXLS3vZ27i6Xl9xRbQgo0uWs+BxikDIGJ8vD3pTO7h86bDVncg3hLro9hERkeBDzGVOzs9lcZ
 CD/6wJtoufhUnEXQdlpjJvJZHN8J5845ts6sWRSc3ZrLLrX9fnU2WzPeN7+8sBiEptfFSzz5J+w
 OEZTxeBXGSUeSwRIt7Vhy8z/CPrF/J7dAQEbOnIAJt9Pt29bjaJpYzVNRM4mItuTE3kOwJE8+Ck
 qPO3SyUVsFCP2z+OI+xHaAaUrw76OgOgjRZJ67SgsR+22jyag3M7DiybOshVVw==
X-Received: by 2002:a05:6000:248a:b0:486:e9b7:cb9 with SMTP id
 ffacd0b85a97d-4870d16d791mr4924318f8f.45.1789590612733; 
 Wed, 16 Sep 2026 13:30:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fe7esm9547128f8f.6.2026.09.16.13.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 13:30:12 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 20:30:12 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
X-Gerrit-Change-Number: 1766
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1766?usp=email>
X-Gerrit-Commit: 69e40fabd902321e8d30622094d6ea7bf9992db1
In-Reply-To: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTkyNDc4MDAwLkkxNjE4NzE1M2U1YjEwN2ViMDhjY2I3YzljOWVkNGFjZDYzNzdhZjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97f0841c70d10bd2f6e8a41306da7cb605016d8f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6wGp-0007tC-Ga
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.5]: Backport
 stricter check for valid tokens
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5873093916582962279=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5873093916582962279==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QvHbFjStr9s="; charset=UTF-8

--QvHbFjStr9s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1766?usp=3Demail )

Change subject: Backport stricter check for valid t=
okens
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Backpor=
t stricter check for valid tokens

OpenVPN 2=2E5 does not have the logic to=
 keep a session id for the auth
token=2E So it does not suffer the same pro=
blem that 2=2E6 and 2=2E7 did
(CVE 2026-13122)=2E

However the improvement =
that we are a lot stricter to check what might
be an auth token is a good t=
hing to backport as well to avoid any other
potential issues that might be =
there=2E

Partial cherry pick from ee119b24b3=2E This drops the parts that =
are not
present in 2=2E5 and also forgoes back porting the new unit tests=
=2E

Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766
Message=
-Id: <20260916164648=2E31293-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39256=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/aut=
h_token=2Ec
M src/openvpn/auth_token=2Eh
2 files changed, 29 insertions(+),=
 14 deletions(-)




diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/=
auth_token=2Ec
index 7c4d15d=2E=2E5205ef3 100644
--- a/src/openvpn/auth_tok=
en=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -21,12 +21,33 @@
 const char *au=
th_token_pem_name =3D "OpenVPN auth-token server key";
 
 #define AUTH_TOKE=
N_SESSION_ID_LEN 12
-#if AUTH_TOKEN_SESSION_ID_LEN % 3
-#error AUTH_TOKEN_S=
ESSION_ID_LEN needs to be multiple a 3
-#endif
+#define AUTH_TOKEN_SESSION_=
ID_BASE64_LEN (OPENVPN_BASE64_LENGTH(AUTH_TOKEN_SESSION_ID_LEN))
 
+/* We w=
ant our token to be a multiple of 3 bytes to avoid the base64 padding */
+s=
tatic_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, "AUTH_TOKEN_SESSION_ID=
_LEN needs to be multiple of 3");
+
+#define AUTH_TOKEN_HMAC_LEN   SHA256_D=
IGEST_LENGTH
 /* Size of the data of the token (not b64 encoded and without=
 prefix) */
-#define TOKEN_DATA_LEN (2 * sizeof(int64_t) + AUTH_TOKEN_SESSI=
ON_ID_LEN + 32)
+#define TOKEN_DATA_LEN        (2 * sizeof(int64_t) + AUTH_=
TOKEN_SESSION_ID_LEN + AUTH_TOKEN_HMAC_LEN)
+#define TOKEN_DATA_BASE64_LEN =
(OPENVPN_BASE64_LENGTH(TOKEN_DATA_LEN))
+
+
+#define TOTAL_SESSION_TOKEN_LE=
N (strlen(SESSION_ID_PREFIX) + TOKEN_DATA_BASE64_LEN)
+
+/* Ensure that TOK=
EN_DATA_LEN is a multiple of 3 so the we avoid the base64
+ * padding */
+s=
tatic_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a multiple=
 of 3");
+
+bool
+is_auth_token(const char *password)
+{
+    if (strlen(pa=
ssword) !=3D TOTAL_SESSION_TOKEN_LEN)
+    {
+        return false;
+    }
=
+
+    return (memcmp_constant_time(SESSION_ID_PREFIX, password, strlen(SES=
SION_ID_PREFIX)) =3D=3D 0);
+}
 
 static struct key_type
 auth_token_kt(voi=
d)
diff --git a/src/openvpn/auth_token=2Eh b/src/openvpn/auth_token=2Eh
ind=
ex 0fa4dba=2E=2Ea975344a 100644
--- a/src/openvpn/auth_token=2Eh
+++ b/src/=
openvpn/auth_token=2Eh
@@ -115,18 +115,12 @@
 #define SESSION_ID_PREFIX "SE=
SS_ID_AT_"
 
 /**
- * Return if the password string has the format of a pas=
sword=2E
+ * Return if the password string has the format of an auth token=
=2E
  *
- * This fuction will always read as many bytes as SESSION_ID_PREFI=
X is longer
- * the caller needs ensure that password memory is at least th=
at long (true for
- * calling with struct user_pass)
  * @param password
  =
* @return whether the password string starts with the session token prefix
=
  */
-static inline bool
-is_auth_token(const char *password)
-{
-    retur=
n (memcmp_constant_time(SESSION_ID_PREFIX, password,
-                     =
            strlen(SESSION_ID_PREFIX)) =3D=3D 0);
-}
+bool
+is_auth_token(c=
onst char *password);
+
 #endif /* AUTH_TOKEN_H */

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bran=
ch: release/2=2E5
Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af=
0c
Gerrit-Change-Number: 1766
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--QvHbFjStr9s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1766?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Backport stricter check for valid tokens<b=
r><br>OpenVPN 2=2E5 does not have the logic to keep a session id for the au=
th<br>token=2E So it does not suffer the same problem that 2=2E6 and 2=2E7 =
did<br>(CVE 2026-13122)=2E<br><br>However the improvement that we are a lot=
 stricter to check what might<br>be an auth token is a good thing to backpo=
rt as well to avoid any other<br>potential issues that might be there=2E<br=
><br>Partial cherry pick from ee119b24b3=2E This drops the parts that are n=
ot<br>present in 2=2E5 and also forgoes back porting the new unit tests=2E<=
br><br>Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c<br>Signed-off-b=
y: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1766<br>Message-Id: &lt;20260916164648=2E31293-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg39256=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/auth_token=2Ec<br>M src/openv=
pn/auth_token=2Eh<br>2 files changed, 29 insertions(+), 14 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_to=
ken=2Ec</span><br><span>index 7c4d15d=2E=2E5205ef3 100644</span><br><span>-=
-- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/src/openvpn/auth_toke=
n=2Ec</span><br><span>@@ -21,12 +21,33 @@</span><br><span> const char *auth=
_token_pem_name =3D &quot;OpenVPN auth-token server key&quot;;</span><br><s=
pan> </span><br><span> #define AUTH_TOKEN_SESSION_ID_LEN 12</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if AUTH_TOKEN_SESSION_ID_LEN % 3</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#error AUTH_TOKEN_SESSION=
_ID_LEN needs to be multiple a 3</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_LENGTH(AUTH_TOKEN_SE=
SSION_ID_LEN))</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* We want our token to be a multiple of 3 bytes to avoid the =
base64 padding */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, &quot;AUTH_TOKEN_SESSIO=
N_ID_LEN needs to be multiple of 3&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGTH</span><br><span> /* =
Size of the data of the token (not b64 encoded and without prefix) */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TOKEN_DATA_LEN (2 *=
 sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + 32)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define TOKEN_DATA_LEN        (2 * sizeof(in=
t64_t) + AUTH_TOKEN_SESSION_ID_LEN + AUTH_TOKEN_HMAC_LEN)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define TOKEN_DATA_BASE64_LEN (OPENVP=
N_BASE64_LENGTH(TOKEN_DATA_LEN))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TOTAL_SESSION_TOK=
EN_LEN (strlen(SESSION_ID_PREFIX) + TOKEN_DATA_BASE64_LEN)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Ensure that TOKEN_DATA_LEN is a multiple of 3 so the=
 we avoid the base64</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * padding */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_LEN is not a multipl=
e of 3&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+is_auth_token(const char *password)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (strlen(password) !=3D TOTAL_SESSI=
ON_TOKEN_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return (memcmp_constant_time(SESSION_ID_PREFIX,=
 password, strlen(SESSION_ID_PREFIX)) =3D=3D 0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> static st=
ruct key_type</span><br><span> auth_token_kt(void)</span><br><span>diff --g=
it a/src/openvpn/auth_token=2Eh b/src/openvpn/auth_token=2Eh</span><br><spa=
n>index 0fa4dba=2E=2Ea975344a 100644</span><br><span>--- a/src/openvpn/auth=
_token=2Eh</span><br><span>+++ b/src/openvpn/auth_token=2Eh</span><br><span=
>@@ -115,18 +115,12 @@</span><br><span> #define SESSION_ID_PREFIX &quot;SES=
S_ID_AT_&quot;</span><br><span> </span><br><span> /**</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Return if the password string has the fo=
rmat of a password=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Return if the password string has the format of an auth token=2E</span=
><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This=
 fuction will always read as many bytes as SESSION_ID_PREFIX is longer</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * the caller needs ensure=
 that password memory is at least that long (true for</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * calling with struct user_pass)</span><br=
><span>  * @param password</span><br><span>  * @return whether the password=
 string starts with the session token prefix</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-is_auth_token(const char *password=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return (memcmp_constant_time(SESSION=
_ID_PREFIX, password,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                 strlen(SESSION_ID_PREFIX)) =3D=3D 0);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+is_auth_token(const char *password);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* AUTH_TOKEN_H =
*/</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail">change 1766</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerri=
t-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: relea=
se/2=2E5 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16187153e5b=
107eb08ccb7c9c9ed4acd6377af0c </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1766 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </=
div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--QvHbFjStr9s=--


--===============5873093916582962279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5873093916582962279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5873093916582962279==--

