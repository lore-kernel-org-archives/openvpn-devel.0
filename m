Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E72C982C4
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Q3joL3JdxGudd9HOjGfiv5mfpRiy5NczftCkYrD5+BM=; b=Udu5lVbVLUKtDi
	/ANpsB8MTxy8WVHY9KcGHGVgmP68bzvHZMiFdUQ0Bj85SbU5GbG1ZX8JyDWkyG6IHQj3tDuriD8Uq
	WazpMW5r6kYW1XCwDPhIytBrH40e2v1Z8eGKazQTNczUWQheB1k+YZDoTen99gFh+g0PMkMxf5lZB
	TIY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6rFX-0005AG-Fh;
	Wed, 16 Sep 2026 15:08:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6rFW-0005A3-5U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:08:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3mxwIZYAhENMq3qgH+2aCszaMQbCKqjF0KxQU1q+to8=; b=g3EXB/LShC1nQtt7E9Ruwt+EA6
 bFn/PnRGMhCVZuwsDlkZBIukc1jMV9DaW3oj8FPr8rUqrGZt4QfTdFgK5yeYymuNqAJur0iSDw5A2
 FGB3B/Rfcd0RPEczTMk4Vi0Rmn5HnZofS6a3uSoeuWO/JgJULRs6VYzDJpw31Eyth4Ps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3mxwIZYAhENMq3qgH+2aCszaMQbCKqjF0KxQU1q+to8=; b=N
 N5gFWj5ZlO5Z6DyEu2EqL4o/xXZ+DkNOLySpsDI3I/z2zitpDZ+PArkRNS6d3sWEA9k7oJE3opdFb
 KmSMsgkOj8u+zovMLMA/68MZtsMHfSl4wmUXj2g+zQ2Tk8o4y5rYsiKUtK4n+Dv4Ce69g4n3wFhnH
 E4N/IDIOe9uJtO+4=;
Received: from mail-ed2-f35.google.com ([74.125.228.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6rFW-0007XD-0i for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:08:38 +0000
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6aa053900f5so1909634a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789571311; x=1790176111; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3mxwIZYAhENMq3qgH+2aCszaMQbCKqjF0KxQU1q+to8=;
 b=Sl5CNRwLNsCjOCNZt+7UGcwcz/rFrXT9uT32ayMXYvy1M0xZ7F24JC6aXHMbUvY4h1
 ohZAGmvQv1oq/kwn1geXXpoTKfinMFpf4iMA94BuM59bmWi8is1/N0uf7HJjcKbaSkw4
 oUnz/3djvLciv2m8VPUNhy0QfXPm6UPxB66kidSnnZNXGqxKBmQj0tUKmHzjKZZbLcLQ
 2oZFRmr6GPJyOHlDu+HIOrk/8wH8E3FGRXeweEM1L4RCTNYJ6+S/N7eoBjlMbHNqKgeN
 83qeoFivMSkvD6cSQaURK3+7y0P3EVKtW1DhpmzcYkbDsot9FLTYDsn2djBzfAvzH3ZI
 aPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789571311; x=1790176111;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3mxwIZYAhENMq3qgH+2aCszaMQbCKqjF0KxQU1q+to8=;
 b=hkaMIGuSUVlyjIH0kAVcqk7RsRC+CJPXfCvDm8dNuSnxXIlb2E9txcwh1ilwGgdkJn
 YQw9ABdW16zdyrwr06JqPSP0fT+ezTUpnyxCa5lqgzefYVIASd5UE0+IL4E/VfvVcYMF
 5VqrvcOooeK7SGTHkMIHtyN9m++u2dQowxnrr6NnMh7U6xrTuQRiG/UEfPA2Se5GdGfO
 svdjwunSdLHLe23/0WiyH+iyUAQDPFO9I07YnkmFN01LTF/zAu+ygoCQpexWvkSQRDEb
 5CJSQ4W92lpD7naaoArMa47PJ6pqhVBin7ZPBXliv8h/igpszA8gdHGwhXVxt2hXpCY+
 OJVg==
X-Gm-Message-State: AFuF++mMmgAsAfJntZiFh/hf6cVcmqm88OeSK8n+VYBlAIAivgS7NSmN
 UDI4dkje6Kj6DjDPTKntyoo3D83BdPa412Ksy1p4Z9Sn4SlPf3K6Iw7yStVSlASlQm0NNZKDla7
 3xyEXtE/i7kMNsbYGqD3bZQdOdrTlqZ4Zt1JEigTpj6qAeuNveEqOoigALaCaGDXj4Pqzxlqgz2
 br0ikEHw==
X-Gm-Gg: AYBFou3vLVgc4Wg1PZ1ctzikiimBCA9l0/8v8JIqRIVKeh2o3blmCOFYgj1VX2HkJku
 fSKaUAb4lWvSHMiqPWtnb3RXOeXs+rPAZnTeH5BpkJsINEWhtpFrNwq+s5RWGhSKBAOjMfvcrKq
 vIMYRgahHASfOjcZzYz/Ak3RPZwL9AWg32Dk7hhiNNvYhjJdcKxS0bmV7Psf3T5NZNzPzM6Lv6A
 30QKZ05r5jvpAYDf/YBNihvD82731JFI9A9nMtvk4uNT9NB5AWsHadd7OE5vyAXjzW8U5N3bSQS
 5+VH69IYllcDS+cj8j3129pBzT0Q3bUZ0kIvk6y2i9BwwJILHUGYiaGTCy74T2jF2XKT3qhZpDJ
 HC4SZa2ohWWa7E+8Kn0qxnA4U/WGenaW1lKWPO++BgKZccyzmyU8o+BhwBgS+CGeqZugq9LNxLL
 jOjIj/hkIMsaoA0+/vF8L5FD27u53B3msCFO5YQtXZLAW35bUV4F96YSTOKRJcAJIWd5dbMVHag
 s0u/DJCMpYNZJUv6OMjomgBUKyy516YYF4GI6XMnVEkWFz4zQPUpOIVuba11RUHWj6/paZeyt+M
 9P0QKXpkWE5t2qoiPE5BQ0AsEHO8T+gcuddYH5FYGA+NV+B0KtO2qfYFGLYxuw==
X-Received: by 2002:a05:600c:5493:b0:49d:286:83d5 with SMTP id
 5b1f17b1804b1-49eaf5ff401mr25884365e9.13.1789560310391; 
 Wed, 16 Sep 2026 05:05:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83d9057dsm84041795e9.3.2026.09.16.05.05.09
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:05:09 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 12:05:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0
X-Gerrit-Change-Number: 1918
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1918?usp=email>
X-Gerrit-Commit: 6e48e34d118139a04976cd29a1e1400a2d58d06e
References: <gerrit.1789560307000.Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTYwMzA3MDAwLkliZjcyMzhiYWRlMmFlZDgxYWM3ZmU0ZmRhMmFmNThlMDkxZGM4Y2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2dcdf636902ec1d40638a4a75342858ea8ce40e7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6rFW-0007XD-0i
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0387867024670667324=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0387867024670667324==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r+a1lob3aAI="; charset=UTF-8

--r+a1lob3aAI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1918?usp=3Demail )


Change subject: Improve auth token =
related comments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Improve auth token related comments

Change-Id: Ibf7238bade2aed81ac7fe=
4fda2af58e091dc8cd0
---
M src/openvpn/auth_token=2Ec
M src/openvpn/auth_tok=
en=2Eh
2 files changed, 4 insertions(+), 6 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/1918/1

diff --git a/=
src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index f928a41=2E=2E=
b457b6f 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_toke=
n=2Ec
@@ -22,7 +22,7 @@
 #define AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_=
BASE64_LENGTH(AUTH_TOKEN_SESSION_ID_LEN))
 
 /* We want our token to be a m=
ultiple of 3 bytes to avoid the base64 padding */
-static_assert(AUTH_TOKEN=
_SESSION_ID_LEN % 3 =3D=3D 0, "AUTH_TOKEN_SESSION_ID_LEN needs to be multip=
le a 3");
+static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, "AUTH_TOKE=
N_SESSION_ID_LEN must be multiple of 3");
 
 #define AUTH_TOKEN_HMAC_LEN   =
SHA256_DIGEST_LENGTH
 /* Size of the data of the token (not b64 encoded and=
 without prefix) */
@@ -34,7 +34,7 @@
 
 /* Ensure that TOKEN_DATA_LEN is a=
 multiple of 3 so the we avoid the base64
  * padding */
-static_assert(TOK=
EN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_BASE64_LEN is not a multiple of 3");
=
+static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a multip=
le of 3");
 
 bool
 is_auth_token(const char *password)
diff --git a/src/op=
envpn/auth_token=2Eh b/src/openvpn/auth_token=2Eh
index fd8317d=2E=2E62ac01=
2 100644
--- a/src/openvpn/auth_token=2Eh
+++ b/src/openvpn/auth_token=2Eh
=
@@ -109,16 +109,14 @@
 #define SESSION_ID_PREFIX "SESS_ID_AT_"
 
 /**
- * R=
eturn if the password string has the format of a password=2E
+ * Return if =
the password string has the format of an auth token=2E
  *
- * This functio=
n will always read as many bytes as SESSION_ID_PREFIX is longer
- * the cal=
ler needs ensure that password memory is at least that long (true for
- * c=
alling with struct user_pass)
  * @param password
  * @return whether the p=
assword string starts with the session token prefix
  */
 bool
 is_auth_tok=
en(const char *password);
+
 /**
  * Checks if a client should be sent a ne=
w auth token to update its
  * current auth-token

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0
Ge=
rrit-Change-Number: 1918
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--r+a1lob3aAI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Improve auth token related comments<br><br>Change-Id: Ibf7238bade2=
aed81ac7fe4fda2af58e091dc8cd0<br>---<br>M src/openvpn/auth_token=2Ec<br>M s=
rc/openvpn/auth_token=2Eh<br>2 files changed, 4 insertions(+), 6 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/18/1918/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/auth_token=
=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index f928a41=2E=2Eb457b6=
f 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><br><span>+=
++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -22,7 +22,7 @@</span><br=
><span> #define AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_LENGTH(AUT=
H_TOKEN_SESSION_ID_LEN))</span><br><span> </span><br><span> /* We want our =
token to be a multiple of 3 bytes to avoid the base64 padding */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static_assert(AUTH_TOKEN_SESSION=
_ID_LEN % 3 =3D=3D 0, &quot;AUTH_TOKEN_SESSION_ID_LEN needs to be multiple =
a 3&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static_a=
ssert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, &quot;AUTH_TOKEN_SESSION_ID_L=
EN must be multiple of 3&quot;);</span><br><span> </span><br><span> #define=
 AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGTH</span><br><span> /* Size of the=
 data of the token (not b64 encoded and without prefix) */</span><br><span>=
@@ -34,7 +34,7 @@</span><br><span> </span><br><span> /* Ensure that TOKEN_D=
ATA_LEN is a multiple of 3 so the we avoid the base64</span><br><span>  * p=
adding */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static_asser=
t(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_BASE64_LEN is not a multipl=
e of 3&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_LEN is not a multipl=
e of 3&quot;);</span><br><span> </span><br><span> bool</span><br><span> is_=
auth_token(const char *password)</span><br><span>diff --git a/src/openvpn/a=
uth_token=2Eh b/src/openvpn/auth_token=2Eh</span><br><span>index fd8317d=2E=
=2E62ac012 100644</span><br><span>--- a/src/openvpn/auth_token=2Eh</span><b=
r><span>+++ b/src/openvpn/auth_token=2Eh</span><br><span>@@ -109,16 +109,14=
 @@</span><br><span> #define SESSION_ID_PREFIX &quot;SESS_ID_AT_&quot;</spa=
n><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Return if the password string has the format of a password=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return if the=
 password string has the format of an auth token=2E</span><br><span>  *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * This function will alw=
ays read as many bytes as SESSION_ID_PREFIX is longer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * the caller needs ensure that password me=
mory is at least that long (true for</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * calling with struct user_pass)</span><br><span>  * @param=
 password</span><br><span>  * @return whether the password string starts wi=
th the session token prefix</span><br><span>  */</span><br><span> bool</spa=
n><br><span> is_auth_token(const char *password);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Che=
cks if a client should be sent a new auth token to update its</span><br><sp=
an>  * current auth-token</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3Demail">ch=
ange 1918</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1918?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1918 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--r+a1lob3aAI=--


--===============0387867024670667324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0387867024670667324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0387867024670667324==--

