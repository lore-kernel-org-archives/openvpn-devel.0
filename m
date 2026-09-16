Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC8CC982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5KPSKmh8E6Blv97yJbJUf0+wIRkD88FfETUpffzHYtM=; b=cf5DSC90wCq1p3vQW320Vi0wDQ
	U8K1fmZZJ8jCVAh9S7ZOz8ZVxF0fNj7tVB3bSNl4+bX7o0WIRKAnlEaeIY6OR9XabEPJpXxjpxsSY
	tH+u+D7TtUp9k5Cu7pIRfLL2m7HobGlJsLgJ907649fj7pVbXTBF9r4mvTT/Hcxeua1k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6wGr-0003lz-JT;
	Wed, 16 Sep 2026 20:30:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6wGp-0003lh-St
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:30:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YBvzjXAtB7OlszGiVyx/o7HmHavOF3/O2PGAZtrH2Gg=; b=ixwZ1cs0cZAsLNiPcoxUtiv8Kr
 VSL4IvJ9HQT1cXjoWqIgj3tTrZwSqp6v84SDQC8Z/W72ZtZBvdVFVe/YwNqpHR3oNj3vBbDbmOk1e
 VU0ZNvB2o1w3oq6qgupNtjEFqWSWhTExX+64CAML8IHBF14tHiP8IJ68fCP59yoho1r8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YBvzjXAtB7OlszGiVyx/o7HmHavOF3/O2PGAZtrH2Gg=; b=O
 9CTHEa/JuZ45ASVMpQXjWrLx+zxI4H56K5tX9zAi9bPe0F/FAJVCobxuOvr8DUkU0K81hodbYx3Z2
 qY5h1G2g1V7GI5rapL3zmOkBjSMol7I3kDLXMnhWnA07+aWAoZrWKRbRvir/syFiUmiD6JBZO7bQF
 CyJ6KmgGTms471fk=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6wGo-00039L-NM for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:30:20 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so795725e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789590612; x=1790195412; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YBvzjXAtB7OlszGiVyx/o7HmHavOF3/O2PGAZtrH2Gg=;
 b=eg5+8h+q3qKBKC5tErVuveAERPaFuvqgdHy5mU0On+eAx+kn/oRKiL+UNPtN7pQAvf
 Y7N/2HA/HdzxjlBZkU/8sw8792J5Em4nNyUv1oKSG0TN+MDl1a6gLULyOyTYh6L8aLAu
 0bC/VVm+7/CwdfZI4F09dCeioYg1zavmMugdk2bVcxmdBndWpngXKJE4ZWySbcux7pid
 4CcLTfuCOzHpR70+8FbNQu4V66VNmDjuahQ7RZ37l1MRZbXttCTyfykIH6baY2KYZR3/
 10+qyWKIizHVoD/coGgoCtB9UJsHrFmlVgmo93r5igenTxAujEUv8uht0lxLnqc4D5lh
 gYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789590612; x=1790195412;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YBvzjXAtB7OlszGiVyx/o7HmHavOF3/O2PGAZtrH2Gg=;
 b=ho2gMOr0dIQ5PS07mbaJuuoN3xjR1ce3ksJ0L8mTZ+838V8/nEuCDEaGEp1pXkE/dQ
 IiYQhhT7mCqjd7EbjhwrYqcc6uNRCid3ncXv+oPTSDfwXVmGT/KH5Z+nHpfMyReJfQ6p
 Kl54DpRpv2OixyflUSZiihf9ZMG8LLkXJFNShjmguFv08QVCEZSb2RdiTxahLfRIIXAN
 2Xo1eiA63Ja4AHW0nZzGJ0crNlOmdN8e975t1knUQXQ7BtPZ5ZSwnqq6ynALeG7cgWze
 ge0196l2Xv5KmsbBRP8uMcom26zl64ntEmIFEM1kysHEiYVkLDyTShbKav3RcG8VmeMc
 HdWw==
X-Gm-Message-State: AFuF++li/9d+rXooA/oZH5DlgWYmC0ZwNvnaZTAPC/l+UQinnokact6o
 sJoNqGlQPUVr0IKmsJ5QcPrpTIGWwtmr8B+t2rwFEZH6YNyOubaU7c4Vj8ReMNMFKv6+zSo5PSM
 BIuz+c6zfyM+5LoMzP5UABvzwVrehwqnMPV06m7/IQ8gqlJO0gXX4UkOrjW91ZSRyRB0l0b63Sr
 37g+CEiw==
X-Gm-Gg: AYBFou1CEe2NGT+8uskPSzRQsNV8jJaF/2IxefI6hkXm21C51AulJi26ZLHppMORCF0
 L6kc63tUTsbWZ0m5tlY6raJP3MlDGPKy8ArKxdBwenHxpbOtNkq/+MwL5d50ldkgfMY2/6op3hr
 AjhGBBs8lbIal9v4/CW+cypGiDgRE+Yg/vKKomy2b+gNYUCol+Z3MHQdRzFb9dB01XhEoZ9J/Oo
 foZlv+TJt4Wt8DkHSpBXOAX1gyMUKWRxpUrAWQN7JP17/RbmrHB3yHXHptOux3NyVZQoL5NK7mL
 M4PDePQYej45wW0lR4UBUYV56jnhX1Do8I1Ece2DhszSyfqPrDQPM23RM3o+pjp4tMHF8ywlBCJ
 f9u0wVMX3dL+6dGTijrnrUUsJ/shBv7VkWVEh/a7OmZlJzC6/gz9+KNsIJqcBu9k7Tw8PJPUAsE
 I+Dmm4qfEQu3Ud1JTWrEGsuKAAiFBwar08AtUzlynsDkzkUfRX/8UAJkY/yu4LjGZulQLACBg5M
 vaST9uH/XHv5C3CAieGxpTwlH4FDGRYRp2IWwLAl3UpcziOQWN+jKbyYvBErmdvmzcigLRl/V4c
 TH2HssWzrnzTsiO85gFs2gszOrIt9TR3fRFtJaXsWRe4j7abbeWsdL7n1ybHTA==
X-Received: by 2002:a05:600c:1909:b0:49e:715e:ec1f with SMTP id
 5b1f17b1804b1-49eb7339c99mr43137765e9.30.1789590611962; 
 Wed, 16 Sep 2026 13:30:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1d0d0bsm18690445e9.1.2026.09.16.13.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 13:30:11 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 20:30:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
X-Gerrit-Change-Number: 1766
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1766?usp=email>
X-Gerrit-Commit: 69e40fabd902321e8d30622094d6ea7bf9992db1
In-Reply-To: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTkyNDc4MDAwLkkxNjE4NzE1M2U1YjEwN2ViMDhjY2I3YzljOWVkNGFjZDYzNzdhZjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97f0841c70d10bd2f6e8a41306da7cb605016d8f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6wGo-00039L-NM
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
Content-Type: multipart/mixed; boundary="===============3861854825638411544=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3861854825638411544==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P/YglE3Q5Z8="; charset=UTF-8

--P/YglE3Q5Z8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
razvanc


Change subject: Backport stricter check for valid tokens
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Backport stricter c=
heck for valid tokens

OpenVPN 2=2E5 does not have the logic to keep a sess=
ion id for the auth
token=2E So it does not suffer the same problem that 2=
=2E6 and 2=2E7 did
(CVE 2026-13122)=2E

However the improvement that we are=
 a lot stricter to check what might
be an auth token is a good thing to bac=
kport as well to avoid any other
potential issues that might be there=2E

P=
artial cherry pick from ee119b24b3=2E This drops the parts that are not
pre=
sent in 2=2E5 and also forgoes back porting the new unit tests=2E

Change-I=
d: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Signed-off-by: Arne Schwabe <a=
rne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766
Message-Id: <20260916=
164648=2E31293-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39256=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/auth_token=2Ec
=
M src/openvpn/auth_token=2Eh
2 files changed, 29 insertions(+), 14 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/6=
6/1766/4

diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=
=2Ec
index 7c4d15d=2E=2E5205ef3 100644
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
 to be multiple of 3");
+
+#define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENG=
TH
 /* Size of the data of the token (not b64 encoded and without prefix) *=
/
-#define TOKEN_DATA_LEN (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN =
+ 32)
+#define TOKEN_DATA_LEN        (2 * sizeof(int64_t) + AUTH_TOKEN_SESS=
ION_ID_LEN + AUTH_TOKEN_HMAC_LEN)
+#define TOKEN_DATA_BASE64_LEN (OPENVPN_B=
ASE64_LENGTH(TOKEN_DATA_LEN))
+
+
+#define TOTAL_SESSION_TOKEN_LEN (strlen(=
SESSION_ID_PREFIX) + TOKEN_DATA_BASE64_LEN)
+
+/* Ensure that TOKEN_DATA_LE=
N is a multiple of 3 so the we avoid the base64
+ * padding */
+static_asse=
rt(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a multiple of 3");
+=

+bool
+is_auth_token(const char *password)
+{
+    if (strlen(password) !=
=3D TOTAL_SESSION_TOKEN_LEN)
+    {
+        return false;
+    }
+
+    re=
turn (memcmp_constant_time(SESSION_ID_PREFIX, password, strlen(SESSION_ID_P=
REFIX)) =3D=3D 0);
+}
 
 static struct key_type
 auth_token_kt(void)
diff -=
-git a/src/openvpn/auth_token=2Eh b/src/openvpn/auth_token=2Eh
index 0fa4db=
a=2E=2Ea975344a 100644
--- a/src/openvpn/auth_token=2Eh
+++ b/src/openvpn/a=
uth_token=2Eh
@@ -115,18 +115,12 @@
 #define SESSION_ID_PREFIX "SESS_ID_AT_=
"
 
 /**
- * Return if the password string has the format of a password=2E
=
+ * Return if the password string has the format of an auth token=2E
  *
- =
* This fuction will always read as many bytes as SESSION_ID_PREFIX is longe=
r
- * the caller needs ensure that password memory is at least that long (t=
rue for
- * calling with struct user_pass)
  * @param password
  * @return =
whether the password string starts with the session token prefix
  */
-stat=
ic inline bool
-is_auth_token(const char *password)
-{
-    return (memcmp_=
constant_time(SESSION_ID_PREFIX, password,
-                               =
  strlen(SESSION_ID_PREFIX)) =3D=3D 0);
-}
+bool
+is_auth_token(const char =
*password);
+
 #endif /* AUTH_TOKEN_H */

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
release/2=2E5
Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
G=
errit-Change-Number: 1766
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--P/YglE3Q5Z8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">Backport stricter check f=
or valid tokens<br><br>OpenVPN 2=2E5 does not have the logic to keep a sess=
ion id for the auth<br>token=2E So it does not suffer the same problem that=
 2=2E6 and 2=2E7 did<br>(CVE 2026-13122)=2E<br><br>However the improvement =
that we are a lot stricter to check what might<br>be an auth token is a goo=
d thing to backport as well to avoid any other<br>potential issues that mig=
ht be there=2E<br><br>Partial cherry pick from ee119b24b3=2E This drops the=
 parts that are not<br>present in 2=2E5 and also forgoes back porting the n=
ew unit tests=2E<br><br>Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0=
c<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1766<br>Message-Id: &lt;20260916164648=2E31293=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg39256=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/auth_token=
=2Ec<br>M src/openvpn/auth_token=2Eh<br>2 files changed, 29 insertions(+), =
14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/66/1766/4</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index 7c4d15d=
=2E=2E5205ef3 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span=
><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -21,12 +21,3=
3 @@</span><br><span> const char *auth_token_pem_name =3D &quot;OpenVPN aut=
h-token server key&quot;;</span><br><span> </span><br><span> #define AUTH_T=
OKEN_SESSION_ID_LEN 12</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if AUTH_TOKEN_SESSION_ID_LEN % 3</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#error AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define AUTH_TOKEN_SESSION_ID_BASE64_LE=
N (OPENVPN_BASE64_LENGTH(AUTH_TOKEN_SESSION_ID_LEN))</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* We want our token to =
be a multiple of 3 bytes to avoid the base64 padding */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static_assert(AUTH_TOKEN_SESSION_ID_LEN=
 % 3 =3D=3D 0, &quot;AUTH_TOKEN_SESSION_ID_LEN needs to be multiple of 3&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define AUTH_TOKEN_HMAC_LEN   SHA=
256_DIGEST_LENGTH</span><br><span> /* Size of the data of the token (not b6=
4 encoded and without prefix) */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define TOKEN_DATA_LEN (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION=
_ID_LEN + 32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e TOKEN_DATA_LEN        (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + =
AUTH_TOKEN_HMAC_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define TOKEN_DATA_BASE64_LEN (OPENVPN_BASE64_LENGTH(TOKEN_DATA_LEN))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define TOTAL_SESSION_TOKEN_LEN (strlen(SESSION_ID_PREFIX) +=
 TOKEN_DATA_BASE64_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Ensure that =
TOKEN_DATA_LEN is a multiple of 3 so the we avoid the base64</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * padding */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static_assert(TOKEN_DATA_LEN % 3 =3D=3D =
0, &quot;TOKEN_DATA_LEN is not a multiple of 3&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+is_auth_token(const char *password)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (strlen(password) !=3D TOTAL_SESSION_TOKEN_LEN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
(memcmp_constant_time(SESSION_ID_PREFIX, password, strlen(SESSION_ID_PREFIX=
)) =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span> </span><br><span> static struct key_type</span><br><span> auth=
_token_kt(void)</span><br><span>diff --git a/src/openvpn/auth_token=2Eh b/s=
rc/openvpn/auth_token=2Eh</span><br><span>index 0fa4dba=2E=2Ea975344a 10064=
4</span><br><span>--- a/src/openvpn/auth_token=2Eh</span><br><span>+++ b/sr=
c/openvpn/auth_token=2Eh</span><br><span>@@ -115,18 +115,12 @@</span><br><s=
pan> #define SESSION_ID_PREFIX &quot;SESS_ID_AT_&quot;</span><br><span> </s=
pan><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
Return if the password string has the format of a password=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Return if the password string =
has the format of an auth token=2E</span><br><span>  *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * This fuction will always read as many b=
ytes as SESSION_ID_PREFIX is longer</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * the caller needs ensure that password memory is at least t=
hat long (true for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
calling with struct user_pass)</span><br><span>  * @param password</span><b=
r><span>  * @return whether the password string starts with the session tok=
en prefix</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-is_auth_token(const char *password)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return (memcmp_constant_time(SESSION_ID_PREFIX, password,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                 st=
rlen(SESSION_ID_PREFIX)) =3D=3D 0);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+is_auth_token(const=
 char *password);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> #endif /* AUTH_TOKEN_H */</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766=
?usp=3Demail">change 1766</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1766?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: release/2=2E5 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 1766 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"=
> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--P/YglE3Q5Z8=--


--===============3861854825638411544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3861854825638411544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3861854825638411544==--

