Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4E606A32E
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VQ+qtl79;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ASIo2W8G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jcpzdCbQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ST55voT7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RUyjv8N9mCh0bsUPD1wZl/uzYHALxgQtomp18YH4fOs=; b=VQ+qtl79uU2dTRMKoUNYl1JXAT
	KDdLe9wn69S6eA+vUmxr+A/k41Hg2zSa2GUHs9Jo8KJUWRn4F3dtbuvyGib9kysmCfYfzSVWhufYe
	3Uo/uJdiw30UCQnuVgrUllyGJlM6X1IVywHDHRI2IKrb+4avfSOnvYPRrhiqkjNaRwSs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSFXQ-000000005LT-2Rk5;
	Sat, 14 Nov 2026 15:19:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSFXO-000000005LN-32fe
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:19:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oCL2tPz6nGPdYy0dHThbNJFw+Y7CvCqJ0ganVwoZUxU=; b=ASIo2W8GePJ3HxSZPwOAL7iuon
 Q/xCQQArjYG0ORyuaXmsNzFy1KCBxXNxHEL18MnjUK+ip8sKk4rVjS/LmWTRhbPtaeptiWh7TuWZx
 N5l21UwrZbUKvjRN5c1iusmirTOFBTer3yWEAq51zSUpkwHg99AhgnM6OuQPzgEO7uFg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oCL2tPz6nGPdYy0dHThbNJFw+Y7CvCqJ0ganVwoZUxU=; b=jcpzdCbQAYx1GYvmBIY0IqZI6j
 G6R1eGB8AimaOlzn2uPLs5LmiiYPitaM34CNKjxgniKxEFfDn5YZ12g/KjoI9ry6ESWtmsWSQKbuV
 ZcY1w0XLxQsueg9Y8sT6jIXFjeQj0i3iMb6hk+Y1vXgr3Rpz2Wiv0egfc0WS/df52l5o=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSFXN-000000008OC-0AL7 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:19:30 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so23136765e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794669562; x=1795274362; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oCL2tPz6nGPdYy0dHThbNJFw+Y7CvCqJ0ganVwoZUxU=;
 b=ST55voT7SZgkYHSRjKxkG2lpTnz+qKVc5GPUM7FBfxqYIRWbdjdGf4IRfEsAfNz00e
 R5/CuHqx1Qm6ztNFqWlGnmDTSNprmgcY0yWcRtvmoJe1cg+Jt2oac+rNByNRYMmHXDN6
 fcQ/B2xfc4HptUjGg0dBvqKKBWlVqcXuMwWe17Vll5yzjZxwcm5d8VOi3VNDZuacq1YZ
 SMS6mp6Hrv0fPILaYUXukfF5v72JavFQtGKcIsz107Ci5GTtT+jRIM0NeiG++2H2dw3n
 jmtVuXs/l+u5yH8ZG9R+qp0ENvFwF1nkgAy8Af9DrJ/g4oO/xDFKcXxttR6ezA5tm70O
 Wbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794669562; x=1795274362;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oCL2tPz6nGPdYy0dHThbNJFw+Y7CvCqJ0ganVwoZUxU=;
 b=EV0klkA5fRR2SMtPWp5SjCIwhb0Zw0fuGpQiXovtV2m9cxAOA6xIhcvzMeWaOzfjma
 q9BJOpFD8xzaWNCBQ5V8LYof4Y6/R/EtCcPORQv8DxLEs5rlVikIWM+dHvcpRoY80C4C
 HgOQgdLN5BQTBAkLGwEONMEcUNAHhb2Pne1tWc8LOEAlO5jxCeR+aKu+CF5bhH7CYxBh
 tygQChiCcd5Fth5IunQuKw028wjZxYg4eAB6Lw86kyGWoduGYq9S8sxYe4e7BG1fiFSO
 x2d6ZlKmsVleGBygvMm0nGWqn4QLGPsc3zafpfHWzMdt+mpTuMG8TA+qJ22JrC5aRurt
 HWoQ==
X-Gm-Message-State: APuU4Z98ajK8kLRqN38SQXMhzhvXryzjmmcdBnxZBMqX4g5dpQ0i13W1
 fW1gM+htn50D1pPoA9AQsTt/cGaK3oP8Sieil7KntxSkSBXx5aAv1xwkn4bxqMpO1VEZh0/C+ej
 Tv/+04tnSUm12Gl8qb7tpH8welXjVJG/1VnyXdNu6i1c+4mK0LS/XI8woZY3MY+BwpSdQ
X-Gm-Gg: AYBFou2NLj3lRG+nPKfuJkwV8ETN0Gmlrq/y96foTPFzX+/jzbWzpt3c9AUG+O7jxRI
 i4r4KeExb7GG8c3vIiRPz57AJ3beiNDdhlczEFoPyDmtbhkeodStrSPcVO+BIbtWwTGoQcweoVn
 jfZZIHp7zhSbAajTKUW18ZRtuSE74u4zEOD47HVLkwh9qaOt557tu2XAOllckRm3dVn9CcAhtNy
 AU9hJGVg2rQLu/N00VzKl/s+zZSkL/uuIm61qSuRAmQeiIkJV0tsJO+h5IS3J1FVnUa4uK3XLON
 P7ghcAMUh1+/n4prR1ITB6ekl6cABnxdBidJAI163/u8LfiH2C8SzqZ7AQePLWx//gN5nWpZ1k+
 rx4UvNYYIcRrkTLsTkW8Hwm4cZ6XCznHUrxE77j9IO/JKP68JylLQS4JooLMStrvFrHT+lTbP6V
 /Y0IXMJVitn5BU4Y6+M32wpRwAZrTLcuoGKo79UDxk79njqXkaSjoPufe20ToQO8M1K4AUEbQHE
 LIZlbbMq/ricDMQY4Bb2PVJ18O7o6RQ8sYcFtTxO8NzyvZ0S7786CDIE3AzMqNykGXCcnQQEbiA
 MoFCLaVTWU5nb39gqwdQWx553uAEW+0uQoPdrP8u1GfPGHj/JKOlQ7faEAQzHmJN1eUe/NjIQRy
 ayILjVEBaP9aca3LeV0Msr+gTXXTPGFfEGR88+pk0AvkOHBwW9qBhmHjmRkRACKGGmH8HRW7TZb
 vl/MIVXHy5Dz1XK4I=
X-Received: by 2002:a05:600c:3547:b0:4b6:267a:dd6e with SMTP id
 5b1f17b1804b1-4bb55a8a402mr119539995e9.28.1794669562137; 
 Sat, 14 Nov 2026 07:19:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c81a63b1csm10531900f8f.4.2026.11.14.07.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 07:19:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 15:19:20 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3
X-Gerrit-Change-Number: 2168
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2168?usp=email>
X-Gerrit-Commit: e767bd21b00c017c1989177ef19637478bcaa879
In-Reply-To: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
References: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzIxNDQyMDAwLkkxYzg3ZmFlZmQzYWRjMmQ5NWI1MzE4NDM3ZDA5N2MzOTcwYTEyMGQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21eced14b930037ad281dac2716c96d27cd364f4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSFXN-000000008OC-0AL7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: console: Switch
 response_len to size_t
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0820918567391371756=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0820918567391371756==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aCOSHRINetY="; charset=UTF-8

--aCOSHRINetY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
168?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: console: Switch resp=
onse_len to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

console: Switch response_len to size_t

We need some casts either w=
ay since the system
APIs are just too different=2E But overall it feels
cle=
aner when using size_t=2E

Change-Id: I1c87faefd3adc2d95b5318437d097c3970a1=
20d3
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2168
Message-Id: <20261110150027=2E17743-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41097=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/op=
envpn/console=2Ec
M src/openvpn/console=2Eh
M src/openvpn/console_builtin=
=2Ec
M src/openvpn/console_systemd=2Ec
M tests/unit_tests/openvpn/test_user=
_pass=2Ec
7 files changed, 20 insertions(+), 47 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/2168/4

diff --gi=
t a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index e672b74=2E=2Ec609=
36a 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -57=
6,9 +576,9 @@
  * like buf_null_terminate, but operate on strings
  */
 voi=
d
-string_null_terminate(char *str, int len, int capacity)
+string_null_ter=
minate(char *str, size_t len, size_t capacity)
 {
-    ASSERT(len >=3D 0 &&=
 len <=3D capacity && capacity > 0);
+    ASSERT(len <=3D capacity && capac=
ity > 0);
     if (len < capacity)
     {
         *(str + len) =3D '\0';
d=
iff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index ae6dcb7=
=2E=2E541f0bd 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=
=2Eh
@@ -872,7 +872,7 @@
  * @param capacity  Total size of the character b=
uffer in bytes=2E
  */
 #ifdef _WIN32
-void string_null_terminate(char *str=
, int len, int capacity);
+void string_null_terminate(char *str, size_t len=
, size_t capacity);
 #endif
 /**@}*/
 /* End of string utility functions */=

diff --git a/src/openvpn/console=2Ec b/src/openvpn/console=2Ec
index 78f44=
5b=2E=2E358b9ae 100644
--- a/src/openvpn/console=2Ec
+++ b/src/openvpn/cons=
ole=2Ec
@@ -53,7 +53,7 @@
 
 
 void
-query_user_add(char *prompt, char *res=
p, int resp_len, bool echo)
+query_user_add(char *prompt, char *resp, size_=
t resp_len, bool echo)
 {
     int i;
 
diff --git a/src/openvpn/console=2E=
h b/src/openvpn/console=2Eh
index 89550ce=2E=2E94b1032 100644
--- a/src/ope=
nvpn/console=2Eh
+++ b/src/openvpn/console=2Eh
@@ -32,10 +32,10 @@
  */
 st=
ruct _query_user
 {
-    char *prompt;     /**< Prompt to present to the us=
er */
-    char *response;   /**< The user's response */
-    int response_=
len; /**< Length the of the user response */
-    bool echo;        /**< Tr=
ue: The user should see what is being typed, otherwise mask it */
+    char=
 *prompt;        /**< Prompt to present to the user */
+    char *response;=
      /**< The user's response */
+    size_t response_len; /**< Length the=
 of the user response */
+    bool echo;           /**< True: The user shou=
ld see what is being typed, otherwise mask it */
 };
 
 #define QUERY_USER_=
NUMSLOTS 10
@@ -57,7 +57,7 @@
  * @param echo       Should the user input b=
e echoed to the user?  If False, input will be masked
  *
  */
-void query_=
user_add(char *prompt, char *resp, int resp_len, bool echo);
+void query_us=
er_add(char *prompt, char *resp, size_t resp_len, bool echo);
 
 
 /**
@@ -=
115,7 +115,7 @@
  *
  */
 static inline bool
-query_user_SINGLE(char *promp=
t, char *resp, int resp_len, bool echo)
+query_user_SINGLE(char *prompt, ch=
ar *resp, size_t resp_len, bool echo)
 {
     query_user_clear();
     quer=
y_user_add(prompt, resp, resp_len, echo);
diff --git a/src/openvpn/console_=
builtin=2Ec b/src/openvpn/console_builtin=2Ec
index 0353ade=2E=2E8206d3d 10=
0644
--- a/src/openvpn/console_builtin=2Ec
+++ b/src/openvpn/console_builti=
n=2Ec
@@ -41,11 +41,6 @@
 #include <termios=2Eh>
 #endif
 
-#if defined(__G=
NUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diag=
nostic ignored "-Wsign-conversion"
-#endif
-
 #ifdef _WIN32
 
 #include "wi=
n32=2Eh"
@@ -62,11 +57,11 @@
  *         exit event is signaled=2E
  */
 st=
atic bool
-get_console_input_win32(const char *prompt, const bool echo, cha=
r *input, const int capacity)
+get_console_input_win32(const char *prompt, =
const bool echo, char *input, const size_t capacity)
 {
     ASSERT(prompt)=
;
     ASSERT(input);
-    ASSERT(capacity > 0);
+    ASSERT(capacity > 0 &=
& capacity < INT_MAX);
 
     input[0] =3D '\0';
 
@@ -110,16 +105,16 @@
  =
           return false;
         }
 
-        status =3D ReadConsoleW(in, =
winput, capacity, &len, NULL);
-        WideCharToMultiByte(CP_UTF8, 0, win=
put, len, input, capacity, NULL, NULL);
+        status =3D ReadConsoleW(in=
, winput, (DWORD)capacity, &len, NULL);
+        WideCharToMultiByte(CP_UTF=
8, 0, winput, (int)len, input, (int)capacity, NULL, NULL);
         free(wi=
nput);
     }
     else
     {
-        status =3D ReadFile(in, input, capa=
city, &len, NULL);
+        status =3D ReadFile(in, input, (DWORD)capacity,=
 &len, NULL);
     }
 
-    string_null_terminate(input, (int)len, capacity=
);
+    string_null_terminate(input, len, capacity);
     chomp(input);
 
 =
    if (!echo)
@@ -191,11 +186,11 @@
  *  @returns Returns True if user inp=
ut was gathered
  */
 static bool
-get_console_input(const char *prompt, co=
nst bool echo, char *input, const int capacity)
+get_console_input(const ch=
ar *prompt, const bool echo, char *input, const size_t capacity)
 {
     AS=
SERT(prompt);
     ASSERT(input);
-    ASSERT(capacity > 0);
+    ASSERT(ca=
pacity > 0 && capacity <=3D INT_MAX);
     input[0] =3D '\0';
 
 #ifdef _WI=
N32
@@ -238,7 +233,7 @@
         restore_tty =3D (tcsetattr(fileno(fp), TCS=
AFLUSH, &tty_tmp) =3D=3D 0);
     }
 
-    if (fgets(input, capacity, fp) !=
=3D NULL)
+    if (fgets(input, (int)capacity, fp) !=3D NULL)
     {
      =
   chomp(input);
         ret =3D true;
@@ -294,7 +289,3 @@
 
     return r=
et;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnost=
ic pop
-#endif
diff --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/c=
onsole_systemd=2Ec
index 8fc7f72=2E=2Ef0ca7fa 100644
--- a/src/openvpn/cons=
ole_systemd=2Ec
+++ b/src/openvpn/console_systemd=2Ec
@@ -53,13 +53,8 @@
  =
   return (sd_booted() > 0) && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) =3D=3D =
0);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnost=
ic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 stat=
ic bool
-get_console_input_systemd(const char *prompt, const bool echo, cha=
r *input, const int capacity)
+get_console_input_systemd(const char *prompt=
, const bool echo, char *input, const size_t capacity)
 {
     int std_out;=

     bool ret =3D false;
@@ -91,10 +86,6 @@
     return ret;
 }
 
-#if def=
ined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
=
 /**
  *  Systemd aware implementation of query_user_exec()=2E  If systemd =
is not running
  *  it will fall back to use query_user_exec_builtin() inst=
ead=2E
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/uni=
t_tests/openvpn/test_user_pass=2Ec
index 5bc1d2a=2E=2E54b3617 100644
--- a/=
tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/=
test_user_pass=2Ec
@@ -47,11 +47,6 @@
 }
 #endif
 
-#if defined(__GNUC__) |=
| defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic i=
gnored "-Wsign-conversion"
-#endif
-
 bool
 query_user_exec_builtin(void)
 =
{
@@ -65,10 +60,6 @@
     return mock();
 }
 
-#if defined(__GNUC__) || def=
ined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 management_aut=
h_failure(const struct management *man, const char *type, const char *reaso=
n)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c87faef=
d3adc2d95b5318437d097c3970a120d3
Gerrit-Change-Number: 2168
Gerrit-PatchSet=
: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--aCOSHRINetY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2168?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">console: Switch response_len to size_t<br><br>We need some casts either=
 way since the system<br>APIs are just too different=2E But overall it feel=
s<br>cleaner when using size_t=2E<br><br>Change-Id: I1c87faefd3adc2d95b5318=
437d097c3970a120d3<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168<br>Message-Id: &=
lt;20261110150027=2E17743-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41097=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/cons=
ole=2Ec<br>M src/openvpn/console=2Eh<br>M src/openvpn/console_builtin=2Ec<b=
r>M src/openvpn/console_systemd=2Ec<br>M tests/unit_tests/openvpn/test_user=
_pass=2Ec<br>7 files changed, 20 insertions(+), 47 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/68/2168/4</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/b=
uffer=2Ec</span><br><span>index e672b74=2E=2Ec60936a 100644</span><br><span=
>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec<=
/span><br><span>@@ -576,9 +576,9 @@</span><br><span>  * like buf_null_termi=
nate, but operate on strings</span><br><span>  */</span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-string_null_terminate(cha=
r *str, int len, int capacity)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+string_null_terminate(char *str, size_t len, size_t capacity)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A=
SSERT(len &gt;=3D 0 &amp;&amp; len &lt;=3D capacity &amp;&amp; capacity &gt=
; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(len=
 &lt;=3D capacity &amp;&amp; capacity &gt; 0);</span><br><span>     if (len=
 &lt; capacity)</span><br><span>     {</span><br><span>         *(str + len=
) =3D &#39;\0&#39;;</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/s=
rc/openvpn/buffer=2Eh</span><br><span>index ae6dcb7=2E=2E541f0bd 100644</sp=
an><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn=
/buffer=2Eh</span><br><span>@@ -872,7 +872,7 @@</span><br><span>  * @param =
capacity  Total size of the character buffer in bytes=2E</span><br><span>  =
*/</span><br><span> #ifdef _WIN32</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void string_null_terminate(char *str, int len, int capacity);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void string_null_term=
inate(char *str, size_t len, size_t capacity);</span><br><span> #endif</spa=
n><br><span> /**@}*/</span><br><span> /* End of string utility functions */=
</span><br><span>diff --git a/src/openvpn/console=2Ec b/src/openvpn/console=
=2Ec</span><br><span>index 78f445b=2E=2E358b9ae 100644</span><br><span>--- =
a/src/openvpn/console=2Ec</span><br><span>+++ b/src/openvpn/console=2Ec</sp=
an><br><span>@@ -53,7 +53,7 @@</span><br><span> </span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-query_us=
er_add(char *prompt, char *resp, int resp_len, bool echo)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+query_user_add(char *prompt, char *re=
sp, size_t resp_len, bool echo)</span><br><span> {</span><br><span>     int=
 i;</span><br><span> </span><br><span>diff --git a/src/openvpn/console=2Eh =
b/src/openvpn/console=2Eh</span><br><span>index 89550ce=2E=2E94b1032 100644=
</span><br><span>--- a/src/openvpn/console=2Eh</span><br><span>+++ b/src/op=
envpn/console=2Eh</span><br><span>@@ -32,10 +32,10 @@</span><br><span>  */<=
/span><br><span> struct _query_user</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    char *prompt;     /**&lt; Prompt to pr=
esent to the user */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   char *response;   /**&lt; The user&#39;s response */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int response_len; /**&lt; Length the =
of the user response */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    bool echo;        /**&lt; True: The user should see what is being typ=
ed, otherwise mask it */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *prompt;        /**&lt; Prompt to present to the user */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *response;     =
 /**&lt; The user&#39;s response */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    size_t response_len; /**&lt; Length the of the user res=
ponse */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ec=
ho;           /**&lt; True: The user should see what is being typed, otherw=
ise mask it */</span><br><span> };</span><br><span> </span><br><span> #defi=
ne QUERY_USER_NUMSLOTS 10</span><br><span>@@ -57,7 +57,7 @@</span><br><span=
>  * @param echo       Should the user input be echoed to the user?  If Fal=
se, input will be masked</span><br><span>  *</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void query_user_add(char *promp=
t, char *resp, int resp_len, bool echo);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void query_user_add(char *prompt, char *resp, size_t r=
esp_len, bool echo);</span><br><span> </span><br><span> </span><br><span> /=
**</span><br><span>@@ -115,7 +115,7 @@</span><br><span>  *</span><br><span>=
  */</span><br><span> static inline bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-query_user_SINGLE(char *prompt, char *resp, int resp_len=
, bool echo)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+query_u=
ser_SINGLE(char *prompt, char *resp, size_t resp_len, bool echo)</span><br>=
<span> {</span><br><span>     query_user_clear();</span><br><span>     quer=
y_user_add(prompt, resp, resp_len, echo);</span><br><span>diff --git a/src/=
openvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec</span><br><sp=
an>index 0353ade=2E=2E8206d3d 100644</span><br><span>--- a/src/openvpn/cons=
ole_builtin=2Ec</span><br><span>+++ b/src/openvpn/console_builtin=2Ec</span=
><br><span>@@ -41,11 +41,6 @@</span><br><span> #include &lt;termios=2Eh&gt;=
</span><br><span> #endif</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ign=
ored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> #ifdef _WIN32</span><br><span> </span><br><span> #include &=
quot;win32=2Eh&quot;</span><br><span>@@ -62,11 +57,11 @@</span><br><span>  =
*         exit event is signaled=2E</span><br><span>  */</span><br><span> s=
tatic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_console=
_input_win32(const char *prompt, const bool echo, char *input, const int ca=
pacity)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_console_=
input_win32(const char *prompt, const bool echo, char *input, const size_t =
capacity)</span><br><span> {</span><br><span>     ASSERT(prompt);</span><br=
><span>     ASSERT(input);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ASSERT(capacity &gt; 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ASSERT(capacity &gt; 0 &amp;&amp; capacity &lt; INT_MAX);=
</span><br><span> </span><br><span>     input[0] =3D &#39;\0&#39;;</span><b=
r><span> </span><br><span>@@ -110,16 +105,16 @@</span><br><span>           =
  return false;</span><br><span>         }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        status =3D ReadConsoleW(in, =
winput, capacity, &amp;len, NULL);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        WideCharToMultiByte(CP_UTF8, 0, winput, len, input, ca=
pacity, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        status =3D ReadConsoleW(in, winput, (DWORD)capacity, &amp;len, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WideChar=
ToMultiByte(CP_UTF8, 0, winput, (int)len, input, (int)capacity, NULL, NULL)=
;</span><br><span>         free(winput);</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        status =3D ReadFile(in, input, capacity, &amp;len, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        statu=
s =3D ReadFile(in, input, (DWORD)capacity, &amp;len, NULL);</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    string_null_terminate(input, (int)len, capacity);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    string_null_terminate(input, len,=
 capacity);</span><br><span>     chomp(input);</span><br><span> </span><br>=
<span>     if (!echo)</span><br><span>@@ -191,11 +186,11 @@</span><br><span=
>  *  @returns Returns True if user input was gathered</span><br><span>  */=
</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-get_console_input(const char *prompt, const bool echo, char *input,=
 const int capacity)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+get_console_input(const char *prompt, const bool echo, char *input, const =
size_t capacity)</span><br><span> {</span><br><span>     ASSERT(prompt);</s=
pan><br><span>     ASSERT(input);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(capacity &gt; 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ASSERT(capacity &gt; 0 &amp;&amp; capacity &lt;=3D=
 INT_MAX);</span><br><span>     input[0] =3D &#39;\0&#39;;</span><br><span>=
 </span><br><span> #ifdef _WIN32</span><br><span>@@ -238,7 +233,7 @@</span>=
<br><span>         restore_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &amp;t=
ty_tmp) =3D=3D 0);</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (fgets(input, capacity, fp) !=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (fg=
ets(input, (int)capacity, fp) !=3D NULL)</span><br><span>     {</span><br><=
span>         chomp(input);</span><br><span>         ret =3D true;</span><b=
r><span>@@ -294,7 +289,3 @@</span><br><span> </span><br><span>     return r=
et;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span>diff --git a/src/openvpn/console_systemd=2Ec =
b/src/openvpn/console_systemd=2Ec</span><br><span>index 8fc7f72=2E=2Ef0ca7f=
a 100644</span><br><span>--- a/src/openvpn/console_systemd=2Ec</span><br><s=
pan>+++ b/src/openvpn/console_systemd=2Ec</span><br><span>@@ -53,13 +53,8 @=
@</span><br><span>     return (sd_booted() &gt; 0) &amp;&amp; (stat(SYSTEMD=
_ASK_PASSWORD_PATH, &amp;c) =3D=3D 0);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-get_console_input_systemd(const cha=
r *prompt, const bool echo, char *input, const int capacity)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+get_console_input_systemd(const ch=
ar *prompt, const bool echo, char *input, const size_t capacity)</span><br>=
<span> {</span><br><span>     int std_out;</span><br><span>     bool ret =
=3D false;</span><br><span>@@ -91,10 +86,6 @@</span><br><span>     return r=
et;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  *  =
Systemd aware implementation of query_user_exec()=2E  If systemd is not run=
ning</span><br><span>  *  it will fall back to use query_user_exec_builtin(=
) instead=2E</span><br><span>diff --git a/tests/unit_tests/openvpn/test_use=
r_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>in=
dex 5bc1d2a=2E=2E54b3617 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
user_pass=2Ec</span><br><span>@@ -47,11 +47,6 @@</span><br><span> }</span><=
br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &qu=
ot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> bool</span><br><span> query_user_exec_builtin(void)</span><br><span=
> {</span><br><span>@@ -65,10 +60,6 @@</span><br><span>     return mock();<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> manageme=
nt_auth_failure(const struct management *man, const char *type, const char =
*reason)</span><br><span> {</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Demail">change 2168</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1=
c87faefd3adc2d95b5318437d097c3970a120d3 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2168 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--aCOSHRINetY=--


--===============0820918567391371756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0820918567391371756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0820918567391371756==--

