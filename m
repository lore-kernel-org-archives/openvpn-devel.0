Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1782BC982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DSHTK59DEUsBb7ng+lkloA0zF6Nv4uVs8Y4UG9vHD4A=; b=Yo2ugzN7TYqPZYdOSx4Xr+oTqr
	8JvQewne+wTKPMWWdB0h6CwNjvkUH8+A2ZLM+ZEl9yyUaInClOAc6Z84i7fT+VwH9znw8H5FF7Jc+
	qMFyW5BCAqO5Ui2de2NiwFfdcmgzEGQ0rEUBrNaGWJqHvlMW/1C6wQTuaGJzAlU35AKA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6s80-0004i0-0d;
	Wed, 16 Sep 2026 16:04:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6s7y-0004hu-P0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 16:04:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WUnCREsRiyLJgIrHIJcahonBtdGM/o2+SiLco49Y18U=; b=KRBqCsmmXZ1d2iZFnS3M2iwcRF
 tKE3nVCQcxsoi6hRO3VCwCurONlhYDytIDWqDJxL79swcsi/W3+kCVaQx3g7rGtj0ZXRTQvMBIr/f
 zKm67leSm5D1ns9eFRUOIplKh37ysCzimpS3QHUIZmjVoKAA2Pw3YDgQTgcH3NK6eYl0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WUnCREsRiyLJgIrHIJcahonBtdGM/o2+SiLco49Y18U=; b=b
 dzZX6bmEEIkaZkGuxbXS7o8rqnSl9jkAuAuUvazho0vJhEMsA8QgVXqRHRFJ7L0uDH24Ca8gnJ/mq
 GG/EgAv0nGTgjdiAFpuabyS7B7PiNXMH34m4zMWjdC3A2DEnMM/HQkHGJoEejeNzZ4M8659O4I4x7
 182E31mb+mIMYOeI=;
Received: from mail-ed2-f12.google.com ([74.125.228.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6s7y-0004Zg-15 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 16:04:55 +0000
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae54so1959944a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789574687; x=1790179487; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WUnCREsRiyLJgIrHIJcahonBtdGM/o2+SiLco49Y18U=;
 b=RoEiYg7kBoiVXo1W3ZaMOsVQ47rrbxDcLG93WLwB49fDbF46QW8n7fv2EW862r8VB2
 DiAASKp4dOi4avVe7NvDUJwZJdmVOnrWjin3vWH3/6/xZVH44kVoJjQFaMxmmAdIBu0v
 VXLCWKO7tipQXdYzXRqhhQZrLiZP+Q4YIopOBsggBEbBPTe/80nJGUk3sMhpYFpLEhhy
 /JuUvGbtuDXgY7CybRtxPcugIlusqiZ8DAdB79LGV9Ev26M2eupz0YDf8brPc4jHjjt+
 l+183BT1MF2J5havcL2Jh8xHPhRPZ7AaqvXCBGdrZqlU17Uqqnk/rrM8+dZis4bkUcH1
 QnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789574687; x=1790179487;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WUnCREsRiyLJgIrHIJcahonBtdGM/o2+SiLco49Y18U=;
 b=Rqiu+lPomy6oF6MqXvtmgPRrMqWiEu1Nh/VT0c8yCqV7pIIDTWRTi43pb6gyzJNMhY
 B3odG1kH5aupTVsu5/IENw4/G98MWE//VaG3KeO1UCysm0ibOh64n7JCNDxC4oi2krn1
 cN98dgiXqBMBtWQwX+NgsVV3eRRZp6JrvPwEQs+R7K0bWWiz2YVbv9z8eOa7YuyhlG5i
 AvCxnpnelegPi/aHSLQ5VEGaT9xU/GhDtcc0JousNZQTCxOg0gq6kJU5t0kbeZHwcv9y
 YbhuvYwyWWewRbu7olkxSB9Z3A4D115hf9NbOY4P57DfEaRpve/SIrNk5njF2mUchEQ0
 UVeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxd+LIYoHy0e5VBQXNAP0+E6ZUi8JUhICzmHxewdyEAPVx+vE1jXF6KXVdEOZDp4H5FSma6gEzREMat4S0h@lists.sourceforge.net
X-Gm-Message-State: AFuF++mQQLYtNZUt30kmHh/gwRDmm7+Wih/4hRpiqZMQszwqiyBl0+tF
 Af0hx6i6hPiFD0ULnrvjaBat3ySwCkiwI5x1yK/+0AEAQikqn9rAzhECwNkJDAt4iE6eefxaqZ5
 0NZATlaSYDrH2Xv60/C+DmQtSlSyPD/KX/hi5FyDkpKJukGI8M7imluW1qJK5OHTOP5A8FumL+U
 OTPlgHVA==
X-Gm-Gg: AYBFou0zwLhbhFjyFs8+HOqzKQ2ouKzX2/EeCtHo+mLD3apO545P8RLIFm9uuXP2e7f
 4Eu/+6u1PQdOZyKCp3S1Kyc1X24r0MacUuJtJd+m+vFAXPuUZjOeOXfYVqiHzVLw1ZD0xLS3IvY
 24DFZHUOuT55B4NV9GD6Je5+jaRKIsmTmZoohuqzPyeUk548B1rWUybyoaz8tdrei5msYxCBN7A
 /H2Hck2LlugK3EvIBL67VBycLVkQIN5vOyHewhad/oVucyWiHQtvaAHXKRA+7yoLbJuCIK7uw1l
 Ga/cdGERuu79qjcTAWfq3QFbWpaclStwcxYTqo++MT7tmQ+6pNQFhq4IKgcru5MDoUz+aF637IX
 0QXsU7AkhaN1+Du+lyKmXvUWoQJSC1sSNhvfRsi/ErMUittdyLRBK446QllMR+e/nlEGJx/CJMC
 6G07oap6IgP0KWjiZetGPI0CZtyKtykMYgabG/N5gjDRgn5Bqk+Wtu4KH1pYenimVNPkTc5IMyw
 n8yWCLciA6g7MwYNdioSJAs0qmRtv/7joKKCztbXQyxFUE6hb3flxegToZwWC0Qj//298Bx8P26
 E67ud/jvyf1q1mCrIsRfk+++0GwzBmvQho+jYqRpqIRBweOwg2NmcXnNqRml7w==
X-Received: by 2002:a05:600c:620d:b0:49e:6692:27fd with SMTP id
 5b1f17b1804b1-49eac46430amr58152695e9.2.1789560384793; 
 Wed, 16 Sep 2026 05:06:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf3494dsm6488371f8f.28.2026.09.16.05.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:06:24 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 12:06:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
X-Gerrit-Change-Number: 1766
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1766?usp=email>
X-Gerrit-Commit: 8f83012ce38ef3afa7a1335f301b503c101e5ec8
In-Reply-To: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTkyNDc4MDAwLkkxNjE4NzE1M2U1YjEwN2ViMDhjY2I3YzljOWVkNGFjZDYzNzdhZjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3b52f25968b0b37fed4d150af8ec7376f5cebb9f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6s7y-0004Zg-15
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
Content-Type: multipart/mixed; boundary="===============3004456132820116121=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3004456132820116121==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ILjrk+UMUkw="; charset=UTF-8

--ILjrk+UMUkw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has uploaded a =
new patch set (#3)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=
=3Demail )


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
2 files changed, 28 insertions(+), 14 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/66/1766/3

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
index 0fa4dba=2E=2E075b662 100644
=
--- a/src/openvpn/auth_token=2Eh
+++ b/src/openvpn/auth_token=2Eh
@@ -115,1=
8 +115,11 @@
 #define SESSION_ID_PREFIX "SESS_ID_AT_"
 
 /**
- * Return if =
the password string has the format of a password=2E
+ * Return if the passw=
ord string has the format of an auth token=2E
  *
- * This fuction will alw=
ays read as many bytes as SESSION_ID_PREFIX is longer
- * the caller needs =
ensure that password memory is at least that long (true for
- * calling wit=
h struct user_pass)
  * @param password
  * @return whether the password st=
ring starts with the session token prefix
  */
-static inline bool
-is_auth=
_token(const char *password)
-{
-    return (memcmp_constant_time(SESSION_I=
D_PREFIX, password,
-                                 strlen(SESSION_ID_PRE=
FIX)) =3D=3D 0);
-}
+bool
+is_auth_token(const char *password);
 #endif /* =
AUTH_TOKEN_H */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1766?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E5
Gerrit-Chang=
e-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Gerrit-Change-Number: 1766
=
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: =
razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=
=2Eorg>

--ILjrk+UMUkw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p>plaisthos <strong>uploaded patch s=
et #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
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
<br>2 files changed, 28 insertions(+), 14 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/66/=
1766/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
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
><span>index 0fa4dba=2E=2E075b662 100644</span><br><span>--- a/src/openvpn/=
auth_token=2Eh</span><br><span>+++ b/src/openvpn/auth_token=2Eh</span><br><=
span>@@ -115,18 +115,11 @@</span><br><span> #define SESSION_ID_PREFIX &quot=
;SESS_ID_AT_&quot;</span><br><span> </span><br><span> /**</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Return if the password string has th=
e format of a password=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Return if the password string has the format of an auth token=2E</=
span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
This fuction will always read as many bytes as SESSION_ID_PREFIX is longer<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the caller needs en=
sure that password memory is at least that long (true for</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * calling with struct user_pass)</span=
><br><span>  * @param password</span><br><span>  * @return whether the pass=
word string starts with the session token prefix</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-is_auth_token(const char *pass=
word)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return (memcmp_constant_time(SES=
SION_ID_PREFIX, password,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                 strlen(SESSION_ID_PREFIX)) =3D=3D 0);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+is_auth_token(const char *password);</span><br><span> #=
endif /* AUTH_TOKEN_H */</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail">cha=
nge 1766</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: release/2=2E5 </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1766 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvan=
c &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--ILjrk+UMUkw=--


--===============3004456132820116121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3004456132820116121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3004456132820116121==--

