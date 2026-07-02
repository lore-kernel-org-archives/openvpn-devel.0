Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BFBC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=TNhr3k769wk30Y2wQ3hM79TaqBIOks/9fcxdC/tz1dE=; b=c7LUSyFHI4QAbj
	VHMo2HAj8upllTj/aZEEKoaX6QQdYdLqLgcOyoObecXnuKsezyjVhsHKnWdYs2+5WZv6ACUg6Vz+X
	8YE49qZLtsL26EViNyXzyPXuzBh5tn9+2PMJXZVyeSfiUO22PQ9Hp5zPc6LUSnzc/0tqxRRw8miAT
	N1A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfFnS-0007jT-CM;
	Thu, 02 Jul 2026 11:41:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfFnO-0007jA-RK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:41:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3tbFGHoEoDVxrjFpyJrRNp71cBRPj1ucinvE4jN4W98=; b=H8IfE/40bhGYfxu7c4KCQBXdgB
 2wUj8tqrrSeaCKH7MtnJ1XzFHT8ojRUIkOol4GUBMKRqnQDO8B0egaFZfP7yqhWbN0lJ31By7dysd
 kWwm97GGAQW01EDV8maFzj4nNtLd4biJ8LCTdRl9tE586Eh1URYtXgxq6m0F6QFKIj8s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3tbFGHoEoDVxrjFpyJrRNp71cBRPj1ucinvE4jN4W98=; b=W
 ZowQe2fk+eQF4VNjOrtZc8dxSFk87AG/754edc052cLBLsKTNJA6Jx/q/UT/bpEjsOFKdWtzK3A4m
 B+FhnGxLt55guRY01Pkt8MliIKkXuNWMNc7HpvzVSdqSK5mlGC4rLrcpSNAizVyHEPUmp8mLHSs/w
 LtivhS1n5COMK1cQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfFnL-0003ZL-5K for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:41:30 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493c1950518so2581915e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782992481; x=1783597281; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tbFGHoEoDVxrjFpyJrRNp71cBRPj1ucinvE4jN4W98=;
 b=gE9CVXsOMyDtdY3qMYjd/3eODvn12Pvj5y8riVQYH2O9Nw4ZcbLbIkNFky2VMbO2mM
 CorY9zASlJpMd9W4L/0R2ZfLQsdvB4xwD3c0q2K3YsyCEzIZTbbEd/AyFCNIDrzcRKh8
 OCqCg3yn/Dsawm7BdoseRaMZ51ysgcx5BncA2tsY5Ix+j+7bumXfLvga05lkQvjQcoeN
 wgMzW72yMuggqJ6IP9XBZ454lyGWWUKFnMLrQR/wPgQWPxpGEqgl2TzMr3NzHUhylIAY
 tMxMotKaW48dW2jpR3aiOTKNhJNtML0LJ13dHGYAxEQ018DOl/bx5kBMidxLame0rOVF
 oK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782992481; x=1783597281;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3tbFGHoEoDVxrjFpyJrRNp71cBRPj1ucinvE4jN4W98=;
 b=RN1EGFU7xDThDDT6LxB5n/nv1P1SXrK2D3/UWPnpWdGngdq8hYyMBV2qto6RE6LFTW
 bvceCjOl61JxpzlT/+VS0cNbhKeRGWURYxY4yw4wFQ06ZoW9LBKmsJfrvuw36v+7o2/6
 DdeoxBjEVd6ilVB6zcXEJLLeDpHlQDUrri7P9j0bmcVThTPa1SWCQMPiv9t6rfM2toDn
 iJAbrNXVfp4h5jmuvilUlA8cRquDsmppfqNPW/HEBs8vZ/PTRSHJwldvTCVtTB9NLY9M
 VuWVoaMmkuTX3IkLBbgrOJ74FuyFKSYC0jkw7z/nIgEXnhXAMRWYmiQRTymLJN9PdKAf
 qOdQ==
X-Gm-Message-State: AOJu0Yx4Ir2+X6XzMxeRvznnyOAwoN7j9cIfRtVIJ5jacfbDltdXlOTt
 luwGTW3pJr1xgifVwc36HFwFniA7rvNIl9iZVk7T0aLwx6i8Xid2xWvWIotOHQ9dx7KmM3dhJyS
 2gZDCRkq5tRdd/SS9Lwo39MccN5kwl0uNa7oKt4uhnQdUqZqVG1kduSAFjUt8XG4GLAFzFLomVW
 ZaDX4K8Q==
X-Gm-Gg: AfdE7cnj/8h+KVTvbjjVaD/bkz7VfnF4fybPE8ZgGDMgTISu8ABhgiWdPbl2/eTbVGd
 h0SkyTmYUr5LYYJ+Dy3JT7qgZ64skqj33c+XBvMUrwc4DFFREU/RpNQKfsN8j2TV/3pO4E6oXdr
 DMawc8vGU/YBySbtB9O9htpa+lpNCrwYIhy67ruqp8/abxvIf8Ff2fFObKxUbrZh9FEC01ZajQh
 AuODSv7FeERP85ILm1jphLXFsbXsgDLr1z800sJ3TZv8bwRP+nco5EQ0k53JVToN5ActhnPqA/J
 fWVPq9+q0UqYwKxBWR3J26AU2pTR0tuWR2K5eRJ3ojy1JfiRqn+rrxacy9qC4VHJeVHfu1RZ7ly
 z/RId14246dVw/DfqaMlTOZc3/4QzyLEdPsHe0mOBBDeqEpPp2gx2Y+nGm0xltgDj4KFe3UbPge
 vdkxd2fw8xv39eGYn6qV72B7LDIcKRiIMBujL9TnLMdO5zmOn4q2XB1y5LlwmIv4bW8mZ64HyhG
 Ga2Kg65Lkb8l4Q/nX48BsrZb21D8xQvSew/xHYRygvXV15yd2CGtXFBJ2exuRBMGIC+DRLaxEjW
 6zFfg0B916AGSQ==
X-Received: by 2002:a05:600c:2d86:b0:492:2ffd:8a74 with SMTP id
 5b1f17b1804b1-493bc2493f4mr89829455e9.12.1782992480797; 
 Thu, 02 Jul 2026 04:41:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94c8ccsm8484604f8f.21.2026.07.02.04.41.20
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 04:41:20 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 11:41:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
X-Gerrit-Change-Number: 1766
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1766?usp=email>
X-Gerrit-Commit: abf505b43e81379893327db19314920f5271556e
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTkyNDc4MDAwLkkxNjE4NzE1M2U1YjEwN2ViMDhjY2I3YzljOWVkNGFjZDYzNzdhZjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f42b220232f79fb2641049ca034808fb99c76e72-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfFnL-0003ZL-5K
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6948004168343093911=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6948004168343093911==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UzFJ8UgCXaU="; charset=UTF-8

--UzFJ8UgCXaU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1766?usp=3Demail )


Change subject: Backport stricter c=
heck for valid tokens
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Backport stricter check for valid tokens

This also improves is_=
auth_token to check for the correct length and
adds a few unit tests=2E

Op=
enVPN 2=2E5 does not have the logic to keep a session id for the auth
token=
=2E So it does not suffer the same problem that 2=2E6 and 2=2E7 did
(CVE 20=
26-13122)=2E

However the improvement that we are a lot stricter to check w=
hat might
be an auth token is a good thing to backport as well to avoid any=
 other
potential issues that might be there=2E

Partial cherry pick from ee=
119b24b3=2E

Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Signed-of=
f-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/auth_token=2Ec
M =
src/openvpn/auth_token=2Eh
2 files changed, 28 insertions(+), 11 deletions(=
-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/66=
/1766/1

diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=
=2Ec
index 7c4d15d=2E=2E5c299a2 100644
--- a/src/openvpn/auth_token=2Ec
+++=
 b/src/openvpn/auth_token=2Ec
@@ -21,12 +21,33 @@
 const char *auth_token_p=
em_name =3D "OpenVPN auth-token server key";
 
 #define AUTH_TOKEN_SESSION_=
ID_LEN 12
-#if AUTH_TOKEN_SESSION_ID_LEN % 3
-#error AUTH_TOKEN_SESSION_ID_=
LEN needs to be multiple a 3
-#endif
+#define AUTH_TOKEN_SESSION_ID_BASE64_=
LEN (OPENVPN_BASE64_LENGTH(AUTH_TOKEN_SESSION_ID_LEN))
 
+/* We want our to=
ken to be a multiple of 3 bytes to avoid the base64 padding */
+static_asse=
rt(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, "AUTH_TOKEN_SESSION_ID_LEN needs=
 to be multiple a 3");
+
+#define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGT=
H
 /* Size of the data of the token (not b64 encoded and without prefix) */=

-#define TOKEN_DATA_LEN (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN +=
 32)
+#define TOKEN_DATA_LEN        (2 * sizeof(int64_t) + AUTH_TOKEN_SESSI=
ON_ID_LEN + AUTH_TOKEN_HMAC_LEN)
+#define TOKEN_DATA_BASE64_LEN (OPENVPN_BA=
SE64_LENGTH(TOKEN_DATA_LEN))
+
+
+#define TOTAL_SESSION_TOKEN_LEN (strlen(S=
ESSION_ID_PREFIX) + TOKEN_DATA_BASE64_LEN)
+
+/* Ensure that TOKEN_DATA_LEN=
 is a multiple of 3 so the we avoid the base64
+ * padding */
+static_asser=
t(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_BASE64_LEN is not a multiple of =
3");
+
+bool
+is_auth_token(const char *password)
+{
+    if (strlen(passwo=
rd) !=3D TOTAL_SESSION_TOKEN_LEN)
+    {
+        return false;
+    }
+
+ =
   return (memcmp_constant_time(SESSION_ID_PREFIX, password, strlen(SESSION=
_ID_PREFIX)) =3D=3D 0);
+}
 
 static struct key_type
 auth_token_kt(void)
d=
iff --git a/src/openvpn/auth_token=2Eh b/src/openvpn/auth_token=2Eh
index 0=
fa4dba=2E=2E85fb3c4 100644
--- a/src/openvpn/auth_token=2Eh
+++ b/src/openv=
pn/auth_token=2Eh
@@ -117,16 +117,12 @@
 /**
  * Return if the password str=
ing has the format of a password=2E
  *
- * This fuction will always read a=
s many bytes as SESSION_ID_PREFIX is longer
+ * This function will always r=
ead as many bytes as SESSION_ID_PREFIX is longer
  * the caller needs ensur=
e that password memory is at least that long (true for
  * calling with str=
uct user_pass)
  * @param password
  * @return whether the password string =
starts with the session token prefix
  */
-static inline bool
-is_auth_toke=
n(const char *password)
-{
-    return (memcmp_constant_time(SESSION_ID_PRE=
FIX, password,
-                                 strlen(SESSION_ID_PREFIX))=
 =3D=3D 0);
-}
+bool
+is_auth_token(const char *password);
 #endif /* AUTH_=
TOKEN_H */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
66?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchan=
ge
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E5
Gerrit-Change-Id: I=
16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Gerrit-Change-Number: 1766
Gerrit-=
PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--UzFJ8UgCXaU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Backport stricter check for valid tokens<br><br>This also improves=
 is_auth_token to check for the correct length and<br>adds a few unit tests=
=2E<br><br>OpenVPN 2=2E5 does not have the logic to keep a session id for t=
he auth<br>token=2E So it does not suffer the same problem that 2=2E6 and 2=
=2E7 did<br>(CVE 2026-13122)=2E<br><br>However the improvement that we are =
a lot stricter to check what might<br>be an auth token is a good thing to b=
ackport as well to avoid any other<br>potential issues that might be there=
=2E<br><br>Partial cherry pick from ee119b24b3=2E<br><br>Change-Id: I161871=
53e5b107eb08ccb7c9c9ed4acd6377af0c<br>Signed-off-by: Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/auth_token=2Ec<br>M src/openvpn/a=
uth_token=2Eh<br>2 files changed, 28 insertions(+), 11 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/66/1766/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/auth_token=2Ec b/src/o=
penvpn/auth_token=2Ec</span><br><span>index 7c4d15d=2E=2E5c299a2 100644</sp=
an><br><span>--- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/src/ope=
nvpn/auth_token=2Ec</span><br><span>@@ -21,12 +21,33 @@</span><br><span> co=
nst char *auth_token_pem_name =3D &quot;OpenVPN auth-token server key&quot;=
;</span><br><span> </span><br><span> #define AUTH_TOKEN_SESSION_ID_LEN 12</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if AUTH_TOKEN_SESSION_=
ID_LEN % 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#error AUTH=
_TOKEN_SESSION_ID_LEN needs to be multiple a 3</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_LENGTH=
(AUTH_TOKEN_SESSION_ID_LEN))</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* We want our token to be a multiple of 3 bytes=
 to avoid the base64 padding */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, &quot;AUT=
H_TOKEN_SESSION_ID_LEN needs to be multiple a 3&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGTH</span><=
br><span> /* Size of the data of the token (not b64 encoded and without pre=
fix) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TOKEN_=
DATA_LEN (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + 32)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define TOKEN_DATA_LEN        (=
2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + AUTH_TOKEN_HMAC_LEN)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TOKEN_DATA_BASE6=
4_LEN (OPENVPN_BASE64_LENGTH(TOKEN_DATA_LEN))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TOTA=
L_SESSION_TOKEN_LEN (strlen(SESSION_ID_PREFIX) + TOKEN_DATA_BASE64_LEN)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Ensure that TOKEN_DATA_LEN is a multip=
le of 3 so the we avoid the base64</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * padding */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_BASE64=
_LEN is not a multiple of 3&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+is_auth_token(cons=
t char *password)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strlen(passw=
ord) !=3D TOTAL_SESSION_TOKEN_LEN)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return (memcmp_constant_ti=
me(SESSION_ID_PREFIX, password, strlen(SESSION_ID_PREFIX)) =3D=3D 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span=
><br><span> static struct key_type</span><br><span> auth_token_kt(void)</sp=
an><br><span>diff --git a/src/openvpn/auth_token=2Eh b/src/openvpn/auth_tok=
en=2Eh</span><br><span>index 0fa4dba=2E=2E85fb3c4 100644</span><br><span>--=
- a/src/openvpn/auth_token=2Eh</span><br><span>+++ b/src/openvpn/auth_token=
=2Eh</span><br><span>@@ -117,16 +117,12 @@</span><br><span> /**</span><br><=
span>  * Return if the password string has the format of a password=2E</spa=
n><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Thi=
s fuction will always read as many bytes as SESSION_ID_PREFIX is longer</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function will a=
lways read as many bytes as SESSION_ID_PREFIX is longer</span><br><span>  *=
 the caller needs ensure that password memory is at least that long (true f=
or</span><br><span>  * calling with struct user_pass)</span><br><span>  * @=
param password</span><br><span>  * @return whether the password string star=
ts with the session token prefix</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-is_auth_token(const char *password)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return (memcmp_constant_time(SESSION_ID_PREFIX, =
password,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                     strlen(SESSION_ID_PREFIX)) =3D=3D 0);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+is_auth_token(const char *password);</span><br><span> #endif /* AUTH_TO=
KEN_H */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail">change 1766</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: release/2=2E5 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I161=
87153e5b107eb08ccb7c9c9ed4acd6377af0c </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1766 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--UzFJ8UgCXaU=--


--===============6948004168343093911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6948004168343093911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6948004168343093911==--

