Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380ABC88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfvFn0AzOYGCel+BX5w2EL9Z9REAoXV2hS/1LgFoR/8=; b=bBQtQwnRvRYHXC0Bt1W1kLV7rk
	C2MoX4hQ1wBBSblAh71M2/cnj3lrP4kHQEha1zT88kP4VfI0CqeDJ1UZOY7+xP3+5crRtVkbmQnOG
	cPJ3HnG+7UbUUWjSZ11ZoqKJAWuLo3vJlzEwQg2HSfEaqhQiSEGPabg/+KTZ9VF2AcwI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x79lK-0002He-Nv;
	Thu, 17 Sep 2026 10:54:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x79lH-0002H9-T4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 10:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ihgXwHQJC2iAt0ipC4yCT/lQEXpgwZQKDHOGSsUvwRA=; b=iDH2/dFuR8I5FdDBF7u8JjueqP
 z/8EMvhSOmWu1OntVD61JNIbw4azVIMVifiRrfnMoNZXEUxyk3mBT/NKJfcO9x3RN9btZt5zUxzss
 CQ66Dv2PUQdYyqteOd4AC+mpT4EN1XHR6rSOjCdCxFkEP5wKsUyI9I8SQAs58Vl2Sx3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ihgXwHQJC2iAt0ipC4yCT/lQEXpgwZQKDHOGSsUvwRA=; b=A
 yY0uNJ9FWe1HNCag1/kgDYhSHiXftPn/7kTCFb4DcYoglb+60Zmi4m0Ar4c4v6kid5fIPVHlYGLJ1
 J8GBvTEk18cXOVCOFpl9hEgrgjTkntIMyD+ucRoQ8OvQsZxZ74oqfLeDHbREsEOm3qEYUzsYN/9GT
 ZXJfIdOBvAFQU9HY=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x79kr-00064P-Ki for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 10:54:15 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4858bc96fabso538461f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789642447; x=1790247247; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ihgXwHQJC2iAt0ipC4yCT/lQEXpgwZQKDHOGSsUvwRA=;
 b=T6ClqduTHORflyKOUjn+zj2TmSagZzPsD4C3dUobpTavdE4eAueqUbDR66jQln6lSV
 zlq6Z0s25gxr/pashfaYaLE2G2O0dKwzP4Jj1hl+ceLmdriiy5DBTgmVjLL+nGh+GQkj
 X/LaRe9BdlP013CEMZM1IsSSDxj0sqYYh8yfi7z9ue8FJDuTTr7WQgfyNi1v9ESmTNwG
 8Gz9LFdSN/zPxBAnI4TnBOnZGJbw3u4429POMSyr4DfMISQOcwxTMhrMr+JZw7tpibnC
 NuBmwUTc8evJVZrpXm2ePkVeD98ryoNlTeQqSL5qCkjPLGxVF/w3rLxFZ9FgZFLRjkRO
 0oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789642447; x=1790247247;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ihgXwHQJC2iAt0ipC4yCT/lQEXpgwZQKDHOGSsUvwRA=;
 b=HOQd7vT6gkmm8+kqJhxnenpog6uicYCRhX+yTTOkXXS5HMt+GV27Y5GMxZ3LLWXU7p
 hQvtDTbnP+jLm5Px2c/OCnwzBn2d8lRYCp5m8WJZhR9tzs7pylm9F8DspQsazO8m/gmz
 hi4YLX9uNhzh4lOEyhWAt4+2fSShFQPD0SCUldFUj7COF1cVcXAHcC7SSvkng1uMEkJS
 X7eKeP8hvo8vznRvzP3v7bqyk9UZXr2kdC8N/GHWqBZXyOKOX3WnWmEOTLfKcQYloMfi
 mSAHmAQOuSBSghZQWE9CaJHmYjZHYOkfsKSmSJo6BNEAobt7ezec1ZEICxF59eiNO1tS
 yLOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwMNnCBxyRUfYpO3GIw7aqprp8zGl2JxeyXuR9kliqz/XvreZo2PkCWdm39Yvont8uEK+2NBOczq0o3mlD@lists.sourceforge.net
X-Gm-Message-State: AFuF++mhqh6brJQ7Vbr+LaeM1JHIKfyLXt/Ee3GBqt3nsvY7hoAn3Fv/
 JM2FSoIZ4IwWDZoBJyUl7D6aT6q8Apk3G5m8B124HVTI5KXKHGQQ0EoSiw+XDe5Y3ASFtnuqcX/
 qRw6rcff6Ym00MxiO3PxcJYXU0BpOpujjCzNGbN34qUmglx+zG8I3tpM8scPtMi7BzDrLOUKYDQ
 GvAb71jQ==
X-Gm-Gg: AYBFou1PsqvkAGTNOGaO1ydXrkczXxT4DHp8KICxVtzpEHt9zfA7v15wTq4POnaSoqi
 AUON1SQlBov5T+wJ3nM7blj3GREzovFOR7stJRzZWrDR1ssaJNNnF82WO2C6T+cMCcK1GE9Onl/
 zmDl6Qhpl627zh8ljB+SuMr26Ce7I54VxXcKSDEqnYBritLWjFyq/FcFf9I7lNyDUbYzVwFequW
 Y6c2qmmQQ4eC5Q8nKTBv6LxrgkWSxc2V2r9Y6Ma+3w/MRjCHvwa+19iJR+OPLDgfWeE2/J5I877
 P5qEFoz7jk7QH7W9xJUOnDug44okr4shFOuDHHr3YiB26sv3x7cz5jd0jXRQxFRvhrCQLJyMS60
 h7X4SEgHFFqO8HG1vbRQMlqnLKX/VKfUxWGWLYbyuz5ytV2Xr57OijucPZk6L1azhyyTCpgdQvs
 ftvy4onDVuNeParALdAMidC/8X+bgzOzdynYGaedtl76we+1DnmEW+VGPTeoodw2rGrgaR913TY
 XFXZpNTh192X4X0Z/KOfSOsf2X9GystP0dAhRmq2oTLq5ni6UyBj/V3wA/Yzn//Smf8p/zWWyMO
 dNigOGeIm46Fr9YdNaMlhVE/djC7C974LPu57zOWXgxIzPdxTlQzjwK/ESDIIhs=
X-Received: by 2002:a05:600c:6290:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49eac45b9bcmr68210985e9.7.1789642447053; 
 Thu, 17 Sep 2026 03:54:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1d0d0bsm64722995e9.1.2026.09.17.03.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 03:54:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 10:54:06 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0
X-Gerrit-Change-Number: 1918
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1918?usp=email>
X-Gerrit-Commit: 17f6cec06fbced967cb64338c83e902e949ece95
In-Reply-To: <gerrit.1789560307000.Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0@gerrit.openvpn.net>
References: <gerrit.1789560307000.Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTYwMzA3MDAwLkliZjcyMzhiYWRlMmFlZDgxYWM3ZmU0ZmRhMmFmNThlMDkxZGM4Y2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <61889cababbf5a8ed3d4e44a3ae1686ada520496-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x79kr-00064P-Ki
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Improve auth token
 related comments
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
Content-Type: multipart/mixed; boundary="===============4370653152284141976=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4370653152284141976==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZF35xBg0cww="; charset=UTF-8

--ZF35xBg0cww=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1918?usp=3Demail )

Change subject: Improve auth token related comments=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Improve au=
th token related comments

Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc=
8cd0
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Raz=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1918
Message-Id: <20260916203425=2E21448-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg39269=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/auth_token=2Ec
M src/openvpn/auth_token=2Eh
=
2 files changed, 4 insertions(+), 6 deletions(-)




diff --git a/src/openv=
pn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index f928a41=2E=2Eb457b6f 1=
00644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ =
-22,7 +22,7 @@
 #define AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_LE=
NGTH(AUTH_TOKEN_SESSION_ID_LEN))
 
 /* We want our token to be a multiple o=
f 3 bytes to avoid the base64 padding */
-static_assert(AUTH_TOKEN_SESSION_=
ID_LEN % 3 =3D=3D 0, "AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3");=

+static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, "AUTH_TOKEN_SESSION=
_ID_LEN must be multiple of 3");
 
 #define AUTH_TOKEN_HMAC_LEN   SHA256_DI=
GEST_LENGTH
 /* Size of the data of the token (not b64 encoded and without =
prefix) */
@@ -34,7 +34,7 @@
 
 /* Ensure that TOKEN_DATA_LEN is a multiple=
 of 3 so the we avoid the base64
  * padding */
-static_assert(TOKEN_DATA_L=
EN % 3 =3D=3D 0, "TOKEN_DATA_BASE64_LEN is not a multiple of 3");
+static_a=
ssert(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a multiple of 3")=
;
 
 bool
 is_auth_token(const char *password)
diff --git a/src/openvpn/aut=
h_token=2Eh b/src/openvpn/auth_token=2Eh
index fd8317d=2E=2E62ac012 100644
=
--- a/src/openvpn/auth_token=2Eh
+++ b/src/openvpn/auth_token=2Eh
@@ -109,1=
6 +109,14 @@
 #define SESSION_ID_PREFIX "SESS_ID_AT_"
 
 /**
- * Return if =
the password string has the format of a password=2E
+ * Return if the passw=
ord string has the format of an auth token=2E
  *
- * This function will al=
ways read as many bytes as SESSION_ID_PREFIX is longer
- * the caller needs=
 ensure that password memory is at least that long (true for
- * calling wi=
th struct user_pass)
  * @param password
  * @return whether the password s=
tring starts with the session token prefix
  */
 bool
 is_auth_token(const =
char *password);
+
 /**
  * Checks if a client should be sent a new auth to=
ken to update its
  * current auth-token

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0
Gerrit-Change=
-Number: 1918
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ZF35xBg0cww=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1918?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Improve auth token related comments<br><br=
>Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0<br>Signed-off-by: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1918<br>Message-Id: &lt;20260916203425=2E21448-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg39269=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/auth_token=2Ec<br>M src/o=
penvpn/auth_token=2Eh<br>2 files changed, 4 insertions(+), 6 deletions(-)<b=
r><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_=
token=2Ec</span><br><span>index f928a41=2E=2Eb457b6f 100644</span><br><span=
>--- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/src/openvpn/auth_to=
ken=2Ec</span><br><span>@@ -22,7 +22,7 @@</span><br><span> #define AUTH_TOK=
EN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_LENGTH(AUTH_TOKEN_SESSION_ID_LEN))=
</span><br><span> </span><br><span> /* We want our token to be a multiple o=
f 3 bytes to avoid the base64 padding */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, &q=
uot;AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static_assert(AUTH_TOKEN_SESSION=
_ID_LEN % 3 =3D=3D 0, &quot;AUTH_TOKEN_SESSION_ID_LEN must be multiple of 3=
&quot;);</span><br><span> </span><br><span> #define AUTH_TOKEN_HMAC_LEN   S=
HA256_DIGEST_LENGTH</span><br><span> /* Size of the data of the token (not =
b64 encoded and without prefix) */</span><br><span>@@ -34,7 +34,7 @@</span>=
<br><span> </span><br><span> /* Ensure that TOKEN_DATA_LEN is a multiple of=
 3 so the we avoid the base64</span><br><span>  * padding */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static_assert(TOKEN_DATA_LEN % 3 =3D=
=3D 0, &quot;TOKEN_DATA_BASE64_LEN is not a multiple of 3&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static_assert(TOKEN_DATA_LEN =
% 3 =3D=3D 0, &quot;TOKEN_DATA_LEN is not a multiple of 3&quot;);</span><br=
><span> </span><br><span> bool</span><br><span> is_auth_token(const char *p=
assword)</span><br><span>diff --git a/src/openvpn/auth_token=2Eh b/src/open=
vpn/auth_token=2Eh</span><br><span>index fd8317d=2E=2E62ac012 100644</span>=
<br><span>--- a/src/openvpn/auth_token=2Eh</span><br><span>+++ b/src/openvp=
n/auth_token=2Eh</span><br><span>@@ -109,16 +109,14 @@</span><br><span> #de=
fine SESSION_ID_PREFIX &quot;SESS_ID_AT_&quot;</span><br><span> </span><br>=
<span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return i=
f the password string has the format of a password=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Return if the password string has the =
format of an auth token=2E</span><br><span>  *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * This function will always read as many bytes as=
 SESSION_ID_PREFIX is longer</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * the caller needs ensure that password memory is at least that lon=
g (true for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * calling=
 with struct user_pass)</span><br><span>  * @param password</span><br><span=
>  * @return whether the password string starts with the session token pref=
ix</span><br><span>  */</span><br><span> bool</span><br><span> is_auth_toke=
n(const char *password);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /**</span><br><span>  * Checks if a client should be=
 sent a new auth token to update its</span><br><span>  * current auth-token=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3Demail">change 1918</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibf7238bade2aed81ac7fe=
4fda2af58e091dc8cd0 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1918 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--ZF35xBg0cww=--


--===============4370653152284141976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4370653152284141976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4370653152284141976==--

