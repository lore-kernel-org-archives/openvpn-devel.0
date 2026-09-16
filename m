Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1814AC982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S0zCDCsnaRLLH9w/OZejiEqCDSWqOgQGnVeNSMx6Nd4=; b=LVmZ5GyWzityyCwoi4AyU8pWDr
	fgKVmo1TUgk32RAV+QUaaCSDvnjQD/Kqb2FaJJNlQdSWFdjvSHdHZECoOxmSIrp65Zi7WJ5eWhjLz
	tY2hy32dRcV9J7aM55shVAaXRmPcmY/QVx0uz8Q9dEQjDPLdKF/m4QHYbpe768fHiY98=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6rkD-00030l-Ca;
	Wed, 16 Sep 2026 15:40:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6rkC-00030f-ID
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BpQIxgc0DcXjii8ofi6PWLMDXhzCJZ8X/gIBO8ZwdOY=; b=Iry5l+nD1uPER9m5x6L2m2hdeK
 Hb6LrrHmhnbie5WZuEAeVMaBTv/CFXLTiO3PDnq4sCo4vThQ+ERLsrFT1yZrMRr6PlYusn2V6I4k2
 tG4lEOZg06IV5Vmwrezya6po82U2rjW73yJKyaKLgGjwH4SpUkrukrhduuN4rXjjXjhA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BpQIxgc0DcXjii8ofi6PWLMDXhzCJZ8X/gIBO8ZwdOY=; b=f
 TOLeqh9NVDK0qOGKsLnNqoPUer0DDkfT6EpW/2CXlwe1+uO5dioZPgUeo2Q0dcvAhSI6UjMRA88iP
 /n3PK1AdPPVlWi8E3qwdAw2WQFnGHrat7ez2Zf6OU1g29Q9B8aww8Bc9Byg9gMDkeHwgNeqAdXmF+
 7tIxD4AcCmxA1gKg=;
Received: from mail-ed2-f35.google.com ([74.125.228.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6rkA-0000Cg-MP for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:40:20 +0000
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so1719267a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789573212; x=1790178012; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BpQIxgc0DcXjii8ofi6PWLMDXhzCJZ8X/gIBO8ZwdOY=;
 b=ZlrnK9s2Qm+cVg1SbSd3KjEbSF31laWUtsZbrvCofSVB5bDYYksijiB9Y/5tdD5PTE
 03Yhax/F5eN7c3yzlAjnHePm6KY+das6fAmR3c7XjMMEuJOeZXI0BXA1gS7JBWeQEH5F
 ejfhaBgGjaTBNlDCD52vxgZHk9smMpZ/otTedvWsbzZq4JkpMBuv9HdTvMBth7kUbgUi
 4JiW+hXLbQhewtyygFtIzH9xKLS1PPIiaduOWRIg67RrJY/9exD4wDGpHfkrnDuhzBIS
 VPcJGU9VW/qTydEOt/MtCNRpGpDF+7eCObVzEa0N1MpR9JCVKE91pkyKJGOo8M1wOIFL
 sYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789573212; x=1790178012;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BpQIxgc0DcXjii8ofi6PWLMDXhzCJZ8X/gIBO8ZwdOY=;
 b=fNY2gKwVvtkZB6Kt+W6GhQdkGrFBytredyu211TWn4aY6yA7zgRtlWKVwVVNqzDmRj
 WaPATfboTcvYoNyJX2BA9BWtZiiqwwbJzHtW5tSZ3ZLHDqJAGavqwo6wrLzR3Yon5GVE
 ezujyB68WlbfuWZAm64QafFS0WnRzionydgoCw0CYNPHvZiueJl4CIdx3DViTVxHIokE
 b54FDG9NnmEHlPhr2GoUO1YxWUfVD7RJqX6nERkbEZcktgxqLgMswFfgk0Uj8GfIj0az
 KzJS/YmcKTdO8/AgN+BgRSTNtTLBxowzJUE8vjwCZRm58+uRW3pHvfMvvU6tjCq6RACJ
 PmGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoK5gPJNTWs7m/xJaRClvi0OviG4981KRO7UCee3DyNuCi6zCpoQWlDrjO5dgOeecHWmTi/R/X5blzinWt@lists.sourceforge.net
X-Gm-Message-State: AFuF++nEGSmwFKJvjkXTCALFsXbTO5c2AJKYLjUvdpEvar+9ePiQ23lV
 WY0UcCzSJCv+NS1jbwYajIBJLcsuIrh9P6fFDpPy5hr6AujbPIOw2KdUcj0VxAZtQdXjwTu8x1R
 ZGNuCvSEKJKfRwwPPbFz1/MFfoF30u6g9ArDTWyULwOds+yE4eo3jPRqVsHhxyCt4ms8cZqoqRj
 Stoxq8QQ==
X-Gm-Gg: AYBFou1AKk4HJaS4W7cgRKStAiQ1dLHANo2u1+CIba7Ws5LfmXVp5inYI+RbEFO05mB
 ibo0mZfYOmxMWIVxCIu9CHL9dRqDwADxF/0kyDCBegfSoi/YJ2UOAvzLeVyfunUIFiFwEOFBTWx
 n0M3O8+/Pr9OwmslQBBQ5BjLB+fYrKFFmHDt6PnlDgyJaSy86K/X6baP4f2kBrqkaTcsV7W8b6O
 DibLX8zFUkidVSL7TBrAVyffbKUjSRb4suxoUnb15tBYVJfnvBEoHGvUpmVpb8poPKXpN99mO/a
 8R68iiUokwyTwftpClsXwqpDhlVd9yVN0Je4p42QZT3aQfD/STYgnK1/8QCJ2NM/0SGDfCLrAdZ
 nSi6vXC/mO6cTP46ZSz/fyrI/AjY4Frc4J8PT2bBPB0uG2E/RbdEAS/qftzXiulFzmRye71KSGV
 zbjXPVPSStnklEvvKOOzDKip5XSSX/rqkeqSauHFdgnHrDwYD1ZI3Lj5c2+Geg9rYxTV7RRkWGa
 8Tf/W3WFJEVmCSuxepF8xfHnajC5c+zZtLPyvS/MTnwtVyTG56yYDUOqi01wiq3zATl8jBLTJpl
 U0UIq4derqlwWcegEXWGdT/d+upSrv4dRhwycRCYwSrB/7OQgTMo0qldI5WkcQ==
X-Received: by 2002:a05:6000:2502:b0:487:88b:4681 with SMTP id
 ffacd0b85a97d-4870cf037d3mr5596016f8f.10.1789560102952; 
 Wed, 16 Sep 2026 05:01:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa70sm6379884f8f.9.2026.09.16.05.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:01:42 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 12:01:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
X-Gerrit-Change-Number: 1766
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1766?usp=email>
X-Gerrit-Commit: a910137b2e1847e47fe1bdb82df13814f07ce7a8
In-Reply-To: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTkyNDc4MDAwLkkxNjE4NzE1M2U1YjEwN2ViMDhjY2I3YzljOWVkNGFjZDYzNzdhZjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2a2dd7c22551d2d3390b2ddd59405f510b8f4f83-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6rkA-0000Cg-MP
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3610302295838023473=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3610302295838023473==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vBDLs436RiY="; charset=UTF-8

--vBDLs436RiY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

plaisthos has uploaded =
a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?us=
p=3Demail )


Change subject: Backport stricter check for valid tokens
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Backport stricte=
r check for valid tokens

OpenVPN 2=2E5 does not have the logic to keep a s=
ession id for the auth
token=2E So it does not suffer the same problem that=
 2=2E6 and 2=2E7 did
(CVE 2026-13122)=2E

However the improvement that we a=
re a lot stricter to check what might
be an auth token is a good thing to b=
ackport as well to avoid any other
potential issues that might be there=2E
=

Partial cherry pick from ee119b24b3=2E This drops the parts that are not
p=
resent in 2=2E5 and also forgoes back porting the new unit tests=2E

Change=
-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Signed-off-by: Arne Schwabe =
<arne@rfc2549=2Eorg>
---
M src/openvpn/auth_token=2Ec
M src/openvpn/auth_to=
ken=2Eh
2 files changed, 27 insertions(+), 13 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/66/1766/2

diff --git =
a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index 7c4d15d=2E=
=2E5205ef3 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_t=
oken=2Ec
@@ -21,12 +21,33 @@
 const char *auth_token_pem_name =3D "OpenVPN =
auth-token server key";
 
 #define AUTH_TOKEN_SESSION_ID_LEN 12
-#if AUTH_T=
OKEN_SESSION_ID_LEN % 3
-#error AUTH_TOKEN_SESSION_ID_LEN needs to be multi=
ple a 3
-#endif
+#define AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_L=
ENGTH(AUTH_TOKEN_SESSION_ID_LEN))
 
+/* We want our token to be a multiple =
of 3 bytes to avoid the base64 padding */
+static_assert(AUTH_TOKEN_SESSION=
_ID_LEN % 3 =3D=3D 0, "AUTH_TOKEN_SESSION_ID_LEN needs to be multiple of 3"=
);
+
+#define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGTH
 /* Size of the da=
ta of the token (not b64 encoded and without prefix) */
-#define TOKEN_DATA=
_LEN (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + 32)
+#define TOKEN_=
DATA_LEN        (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + AUTH_TOK=
EN_HMAC_LEN)
+#define TOKEN_DATA_BASE64_LEN (OPENVPN_BASE64_LENGTH(TOKEN_DA=
TA_LEN))
+
+
+#define TOTAL_SESSION_TOKEN_LEN (strlen(SESSION_ID_PREFIX) + =
TOKEN_DATA_BASE64_LEN)
+
+/* Ensure that TOKEN_DATA_LEN is a multiple of 3 =
so the we avoid the base64
+ * padding */
+static_assert(TOKEN_DATA_LEN % 3=
 =3D=3D 0, "TOKEN_DATA_LEN is not a multiple of 3");
+
+bool
+is_auth_token=
(const char *password)
+{
+    if (strlen(password) !=3D TOTAL_SESSION_TOKE=
N_LEN)
+    {
+        return false;
+    }
+
+    return (memcmp_constant_=
time(SESSION_ID_PREFIX, password, strlen(SESSION_ID_PREFIX)) =3D=3D 0);
+}
=
 
 static struct key_type
 auth_token_kt(void)
diff --git a/src/openvpn/aut=
h_token=2Eh b/src/openvpn/auth_token=2Eh
index 0fa4dba=2E=2Ea1fb460 100644
=
--- a/src/openvpn/auth_token=2Eh
+++ b/src/openvpn/auth_token=2Eh
@@ -117,1=
6 +117,9 @@
 /**
  * Return if the password string has the format of a pass=
word=2E
  *
- * This fuction will always read as many bytes as SESSION_ID_P=
REFIX is longer
- * the caller needs ensure that password memory is at leas=
t that long (true for
- * calling with struct user_pass)
  * @param passwor=
d
  * @return whether the password string starts with the session token pre=
fix
  */
-static inline bool
-is_auth_token(const char *password)
-{
-    r=
eturn (memcmp_constant_time(SESSION_ID_PREFIX, password,
-                 =
                strlen(SESSION_ID_PREFIX)) =3D=3D 0);
-}
+bool
+is_auth_tok=
en(const char *password);
 #endif /* AUTH_TOKEN_H */

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: release/2=2E5
Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4ac=
d6377af0c
Gerrit-Change-Number: 1766
Gerrit-PatchSet: 2
Gerrit-Owner: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--vBDLs436RiY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1766?usp=3Demail">View Change</a></p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Backp=
ort stricter check for valid tokens<br><br>OpenVPN 2=2E5 does not have the =
logic to keep a session id for the auth<br>token=2E So it does not suffer t=
he same problem that 2=2E6 and 2=2E7 did<br>(CVE 2026-13122)=2E<br><br>Howe=
ver the improvement that we are a lot stricter to check what might<br>be an=
 auth token is a good thing to backport as well to avoid any other<br>poten=
tial issues that might be there=2E<br><br>Partial cherry pick from ee119b24=
b3=2E This drops the parts that are not<br>present in 2=2E5 and also forgoe=
s back porting the new unit tests=2E<br><br>Change-Id: I16187153e5b107eb08c=
cb7c9c9ed4acd6377af0c<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg=
&gt;<br>---<br>M src/openvpn/auth_token=2Ec<br>M src/openvpn/auth_token=2Eh=
<br>2 files changed, 27 insertions(+), 13 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/66/=
1766/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_t=
oken=2Ec</span><br><span>index 7c4d15d=2E=2E5205ef3 100644</span><br><span>=
--- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/src/openvpn/auth_tok=
en=2Ec</span><br><span>@@ -21,12 +21,33 @@</span><br><span> const char *aut=
h_token_pem_name =3D &quot;OpenVPN auth-token server key&quot;;</span><br><=
span> </span><br><span> #define AUTH_TOKEN_SESSION_ID_LEN 12</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if AUTH_TOKEN_SESSION_ID_LEN % 3</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#error AUTH_TOKEN_SESSIO=
N_ID_LEN needs to be multiple a 3</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_LENGTH(AUTH_TOKEN_S=
ESSION_ID_LEN))</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* We want our token to be a multiple of 3 bytes to avoid the=
 base64 padding */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, &quot;AUTH_TOKEN_SESSI=
ON_ID_LEN needs to be multiple of 3&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGTH</span><br><span> /*=
 Size of the data of the token (not b64 encoded and without prefix) */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TOKEN_DATA_LEN (2 =
* sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + 32)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TOKEN_DATA_LEN        (2 * sizeof=
(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + AUTH_TOKEN_HMAC_LEN)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define TOKEN_DATA_BASE64_LEN (OPE=
NVPN_BASE64_LENGTH(TOKEN_DATA_LEN))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TOTAL_SESSION_=
TOKEN_LEN (strlen(SESSION_ID_PREFIX) + TOKEN_DATA_BASE64_LEN)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Ensure that TOKEN_DATA_LEN is a multiple of 3 so =
the we avoid the base64</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * padding */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_LEN is not a mult=
iple of 3&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+is_auth_token(const char *password)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (strlen(password) !=3D TOTAL_SE=
SSION_TOKEN_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return (memcmp_constant_time(SESSION_ID_PREF=
IX, password, strlen(SESSION_ID_PREFIX)) =3D=3D 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> stat=
ic struct key_type</span><br><span> auth_token_kt(void)</span><br><span>dif=
f --git a/src/openvpn/auth_token=2Eh b/src/openvpn/auth_token=2Eh</span><br=
><span>index 0fa4dba=2E=2Ea1fb460 100644</span><br><span>--- a/src/openvpn/=
auth_token=2Eh</span><br><span>+++ b/src/openvpn/auth_token=2Eh</span><br><=
span>@@ -117,16 +117,9 @@</span><br><span> /**</span><br><span>  * Return i=
f the password string has the format of a password=2E</span><br><span>  *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This fuction will al=
ways read as many bytes as SESSION_ID_PREFIX is longer</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * the caller needs ensure that password m=
emory is at least that long (true for</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * calling with struct user_pass)</span><br><span>  * @para=
m password</span><br><span>  * @return whether the password string starts w=
ith the session token prefix</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-is_auth_token(const char *password)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return (memcmp_constant_time(SESSION_ID_PREFIX, pass=
word,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                 strlen(SESSION_ID_PREFIX)) =3D=3D 0);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
is_auth_token(const char *password);</span><br><span> #endif /* AUTH_TOKEN_=
H */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail">change 1766</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 release/2=2E5 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16187=
153e5b107eb08ccb7c9c9ed4acd6377af0c </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1766 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--vBDLs436RiY=--


--===============3610302295838023473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3610302295838023473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3610302295838023473==--

