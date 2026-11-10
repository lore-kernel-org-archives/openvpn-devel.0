Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0B606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gZL5rejG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OV7az235;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LURQE573;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=R0Y+5vhn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=vaEUC9IWT54z6i0eIbw8itxOyvcENDY/vPymVv/kAHg=; b=gZL5rejGfmrU/pSbupj9V3z0YG
	70+2RB6tqTZLqUNen7348gNDYEQv678adpaTpZ5qtnWRoax/MxTtxnAtx3MucgkRyfR1E3J2TJUZG
	nhkZW0QG8L/SZiQs9rz7EBO2FRyXOrwuh4mrU556XqQypjAnS1rvGitP9gPgpTyPrcBo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmys-000000005WZ-0gj0;
	Tue, 10 Nov 2026 14:37:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQmyj-000000005WQ-3SjJ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jzsd9Ca8xJg5Mgob4UpwB6IUT6Vw17qriMKPslhkI/0=; b=OV7az235JpS2FqkN3xtQGXF3ko
 SRw8UUVw1gbgWBZdo7mhudgC63C8/T0CTnTvOOPOGPGAJ1aT0V1SsZCZEuIKwGDXbanG6fezIM7hb
 0PHH+5GM9/RNLi6H7aFNx5fF1GypTKBAz92ZdY42SvBsZBVTsC2Z2cZjc/O9SOhZkPUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jzsd9Ca8xJg5Mgob4UpwB6IUT6Vw17qriMKPslhkI/0=; b=LURQE573BaceJow7zmyWsgae4H
 xvRGLM2/Q6VlTt9DdxoNgfSo3wP+FyLjWzq5eZZZOY64N5aC5kNCVAmGwcBfbaoSTMhOh0Fu/5Tyd
 LnCVfhvHCVvsaUoCTI/a33ipBV+ggT4ODGpclZpc54s3pmxl+zk9G9NsxumQQcjqyYGI=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQmyh-000000000MK-3nAk for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:37:41 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so14816165e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794321453; x=1794926253; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jzsd9Ca8xJg5Mgob4UpwB6IUT6Vw17qriMKPslhkI/0=;
 b=R0Y+5vhn1Arcg4YfVrtaxWK3dwEapfpa7XApdUFr2bcLb/Xy1B11RTKxjMzTfX9VID
 TUiih0Gx/kwwktE4yt70OUq4YooRSTwGbiFKI0k3JGE93CKPKibNa8j4nJD/OX/zenr0
 //8NxdjO6YWTxaQn1pHmbeYIzLvgXy8y4AFhqK3jrWbTWNhg/VKZo8QS5ZM4zQZ9gyAz
 XJggyRDMXrD08qQr5mlrCiqYZQrfyjFzDUNhTm/tFWE3XP1/U3Uw7N46BaEOTLC961M9
 Nx/2PdI1sIQzWftDOaFm8uIpBvy17HzxfWapEAiceRbG5OSOSGlXp/ga2MM1Eow+XPTo
 tBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794321453; x=1794926253;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jzsd9Ca8xJg5Mgob4UpwB6IUT6Vw17qriMKPslhkI/0=;
 b=Q9Ck87KnuZX/JOgb7hUmd6rwAc1Nqmz71FJNX/QOiQYJMKq/3ZAuc3n59MzNHMVj6D
 FXJtsWgMyipYy/f8NhDZbJZFnCW1xIXUK6XDyGhyaxh1/FCdYF6hej8UR6xSwduio2yO
 oOx9CiuL4MwTmVkiNm75udYoVKoidROvtcvBxq6CmT1r68thqwaNZC0zYksgp0itpnYS
 Ta2pWLnCTD0/V/w6RNVMlhmkgPKGZ27mUTayThHUbNQWnycLiRIw7pNaavhMNMfZ6yCp
 HX09ISwtVj9eiS14e3xCiD+NtplLpEb+mlWbcXJpDqFrIKa3wKkhBOFreWmOYe0vOt8+
 wDLQ==
X-Gm-Message-State: APuU4Z+uy145/83ZZLQ4Dk1yX/M8gseRYcuqYMo9dLZhSqj02LITjLDZ
 1Q5xWNu/XJFlP8iFKypLJn1VtMzf56tPjiONuVWVf9w6cJg1ev2OQ2dibzBWDKt85bpBNDuALBT
 /1XLYnLmrRAkm9HEheh3CHrldoMTSnO9yZ0AlxaolmG9OX+dvcIZrvicxqejIuORPUEz4
X-Gm-Gg: AYBFou3kfnaTQfFMoD438VcY9YSaHTvxXtGxmwk+GFEuH4LxnV7rB81dLNNHWoQUOAi
 VsVAo4e9WmrOq+P4+2EwAaICdhqtonHO54Kbr23ZZgBIF9+kK+ydhNH47ppn3WNduKcO1V2mg3q
 zJK/6AhuHfVmJPKVFqLv5galHb0Im2rI5+7IhYl6NAdeIaS8S1Tve9kj+eG8Cez6/i7aicM9sjU
 1w1CiNLk8y/seCxqbE2jqjnLdDU6JisWVWooqMCTZ41keKGhqOxOpDnxMJyBoibpG6gGwfs2NK5
 8v0xtI222lj/ayf0MtzSpISkObGzcy/Arv35rlXfYk8lt6BZrNvRrw5avqPwRj3+DOVoFHmbww5
 2OTJ2rMtLkEO4O33bF5okBG6mZExlkLOVK23Vn3hREqTpk+5zc7Fk1TAZzTfPGusHoOr6FqfBGB
 d9F6Y2gB6A0/aXQr8O/9SbsF0AdQygZqPBbZK+5Bbls944N3VzkrjglpGW3JOXH6OxAIqTQZcmM
 mMB/wrelVIQAOsWBKfSQsZo2VkxV2/Z28lQRO/06UJEmf1NAxTMTXwPAhhICVP0EmY7fCr5KcnJ
 srQ3Ju9QtrEHrobNZ7xjL0REUZrlDMP5V3h806kCmQNgUcqFdCUXCpX0W4bDAveiBd1rtN+3B23
 gcCKIOJdkITjlYzSr/YaH9Fh8fU8JGO9l7dhTi1HCkcZ4R355rSud0+ujCT4HVQ2kgb0p42g337
 /2w9K6Kixa3TROUK8=
X-Received: by 2002:a05:600c:4fce:b0:4a2:267:25b3 with SMTP id
 5b1f17b1804b1-4ba0235bc8dmr50614405e9.35.1794321453033; 
 Tue, 10 Nov 2026 06:37:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835e20327sm5637696f8f.26.2026.11.10.06.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:37:31 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 14:37:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3
X-Gerrit-Change-Number: 2168
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2168?usp=email>
X-Gerrit-Commit: e15233110ff23b820b082a284b93503d13df1e53
References: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzIxNDQyMDAwLkkxYzg3ZmFlZmQzYWRjMmQ5NWI1MzE4NDM3ZDA5N2MzOTcwYTEyMGQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c71011b5c94e7fea8d8f69779af85c74ac9d627-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQmyh-000000000MK-3nAk
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1572077338227331553=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1572077338227331553==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JVDz4gnOcgo="; charset=UTF-8

--JVDz4gnOcgo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2168?usp=3Demail

to review the following change=2E
=


Change subject: console: Switch response_len to size_t
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

console: Switch response_len to=
 size_t

We need some casts either way since the system
APIs are just too d=
ifferent=2E But overall it feels
cleaner when using size_t=2E

Change-Id: I=
1c87faefd3adc2d95b5318437d097c3970a120d3
Signed-off-by: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=
=2Eh
M src/openvpn/console=2Ec
M src/openvpn/console=2Eh
M src/openvpn/cons=
ole_builtin=2Ec
M src/openvpn/console_systemd=2Ec
M tests/unit_tests/openvp=
n/test_user_pass=2Ec
7 files changed, 20 insertions(+), 47 deletions(-)



=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/2168/=
1

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index a4e28=
09=2E=2E05c4e30 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffe=
r=2Ec
@@ -576,9 +576,9 @@
  * like buf_null_terminate, but operate on strin=
gs
  */
 void
-string_null_terminate(char *str, int len, int capacity)
+str=
ing_null_terminate(char *str, size_t len, size_t capacity)
 {
-    ASSERT(l=
en >=3D 0 && len <=3D capacity && capacity > 0);
+    ASSERT(len <=3D capac=
ity && capacity > 0);
     if (len < capacity)
     {
         *(str + len)=
 =3D '\0';
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
ind=
ex ae6dcb7=2E=2E541f0bd 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openv=
pn/buffer=2Eh
@@ -872,7 +872,7 @@
  * @param capacity  Total size of the ch=
aracter buffer in bytes=2E
  */
 #ifdef _WIN32
-void string_null_terminate(=
char *str, int len, int capacity);
+void string_null_terminate(char *str, s=
ize_t len, size_t capacity);
 #endif
 /**@}*/
 /* End of string utility fun=
ctions */
diff --git a/src/openvpn/console=2Ec b/src/openvpn/console=2Ec
in=
dex 78f445b=2E=2E358b9ae 100644
--- a/src/openvpn/console=2Ec
+++ b/src/ope=
nvpn/console=2Ec
@@ -53,7 +53,7 @@
 
 
 void
-query_user_add(char *prompt, =
char *resp, int resp_len, bool echo)
+query_user_add(char *prompt, char *re=
sp, size_t resp_len, bool echo)
 {
     int i;
 
diff --git a/src/openvpn/c=
onsole=2Eh b/src/openvpn/console=2Eh
index 89550ce=2E=2E94b1032 100644
--- =
a/src/openvpn/console=2Eh
+++ b/src/openvpn/console=2Eh
@@ -32,10 +32,10 @@=

  */
 struct _query_user
 {
-    char *prompt;     /**< Prompt to present =
to the user */
-    char *response;   /**< The user's response */
-    int =
response_len; /**< Length the of the user response */
-    bool echo;      =
  /**< True: The user should see what is being typed, otherwise mask it */
=
+    char *prompt;        /**< Prompt to present to the user */
+    char *=
response;      /**< The user's response */
+    size_t response_len; /**< L=
ength the of the user response */
+    bool echo;           /**< True: The =
user should see what is being typed, otherwise mask it */
 };
 
 #define QU=
ERY_USER_NUMSLOTS 10
@@ -57,7 +57,7 @@
  * @param echo       Should the use=
r input be echoed to the user?  If False, input will be masked
  *
  */
-vo=
id query_user_add(char *prompt, char *resp, int resp_len, bool echo);
+void=
 query_user_add(char *prompt, char *resp, size_t resp_len, bool echo);
 
 
=
 /**
@@ -115,7 +115,7 @@
  *
  */
 static inline bool
-query_user_SINGLE(ch=
ar *prompt, char *resp, int resp_len, bool echo)
+query_user_SINGLE(char *p=
rompt, char *resp, size_t resp_len, bool echo)
 {
     query_user_clear();
=
     query_user_add(prompt, resp, resp_len, echo);
diff --git a/src/openvpn=
/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec
index 0353ade=2E=2E8=
206d3d 100644
--- a/src/openvpn/console_builtin=2Ec
+++ b/src/openvpn/conso=
le_builtin=2Ec
@@ -41,11 +41,6 @@
 #include <termios=2Eh>
 #endif
 
-#if de=
fined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma=
 GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 #ifdef _WIN32
 
 #in=
clude "win32=2Eh"
@@ -62,11 +57,11 @@
  *         exit event is signaled=2E=

  */
 static bool
-get_console_input_win32(const char *prompt, const bool =
echo, char *input, const int capacity)
+get_console_input_win32(const char =
*prompt, const bool echo, char *input, const size_t capacity)
 {
     ASSER=
T(prompt);
     ASSERT(input);
-    ASSERT(capacity > 0);
+    ASSERT(capac=
ity > 0 && capacity < INT_MAX);
 
     input[0] =3D '\0';
 
@@ -110,16 +105=
,16 @@
             return false;
         }
 
-        status =3D ReadCons=
oleW(in, winput, capacity, &len, NULL);
-        WideCharToMultiByte(CP_UTF=
8, 0, winput, len, input, capacity, NULL, NULL);
+        status =3D ReadCo=
nsoleW(in, winput, (DWORD)capacity, &len, NULL);
+        WideCharToMultiBy=
te(CP_UTF8, 0, winput, (int)len, input, (int)capacity, NULL, NULL);
       =
  free(winput);
     }
     else
     {
-        status =3D ReadFile(in, in=
put, capacity, &len, NULL);
+        status =3D ReadFile(in, input, (DWORD)=
capacity, &len, NULL);
     }
 
-    string_null_terminate(input, (int)len,=
 capacity);
+    string_null_terminate(input, len, capacity);
     chomp(in=
put);
 
     if (!echo)
@@ -191,11 +186,11 @@
  *  @returns Returns True if=
 user input was gathered
  */
 static bool
-get_console_input(const char *p=
rompt, const bool echo, char *input, const int capacity)
+get_console_input=
(const char *prompt, const bool echo, char *input, const size_t capacity)
 =
{
     ASSERT(prompt);
     ASSERT(input);
-    ASSERT(capacity > 0);
+    =
ASSERT(capacity > 0 && capacity <=3D INT_MAX);
     input[0] =3D '\0';
 
 #=
ifdef _WIN32
@@ -238,7 +233,7 @@
         restore_tty =3D (tcsetattr(fileno=
(fp), TCSAFLUSH, &tty_tmp) =3D=3D 0);
     }
 
-    if (fgets(input, capaci=
ty, fp) !=3D NULL)
+    if (fgets(input, (int)capacity, fp) !=3D NULL)
    =
 {
         chomp(input);
         ret =3D true;
@@ -294,7 +289,3 @@
 
    =
 return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC=
 diagnostic pop
-#endif
diff --git a/src/openvpn/console_systemd=2Ec b/src/=
openvpn/console_systemd=2Ec
index 8fc7f72=2E=2Ef0ca7fa 100644
--- a/src/ope=
nvpn/console_systemd=2Ec
+++ b/src/openvpn/console_systemd=2Ec
@@ -53,13 +5=
3,8 @@
     return (sd_booted() > 0) && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c=
) =3D=3D 0);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC=
 diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endi=
f
-
 static bool
-get_console_input_systemd(const char *prompt, const bool =
echo, char *input, const int capacity)
+get_console_input_systemd(const cha=
r *prompt, const bool echo, char *input, const size_t capacity)
 {
     int=
 std_out;
     bool ret =3D false;
@@ -91,10 +86,6 @@
     return ret;
 }
 =

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-=
#endif
-
 /**
  *  Systemd aware implementation of query_user_exec()=2E  If=
 systemd is not running
  *  it will fall back to use query_user_exec_built=
in() instead=2E
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/=
tests/unit_tests/openvpn/test_user_pass=2Ec
index 5bc1d2a=2E=2E54b3617 1006=
44
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests=
/openvpn/test_user_pass=2Ec
@@ -47,11 +47,6 @@
 }
 #endif
 
-#if defined(__=
GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC dia=
gnostic ignored "-Wsign-conversion"
-#endif
-
 bool
 query_user_exec_builti=
n(void)
 {
@@ -65,10 +60,6 @@
     return mock();
 }
 
-#if defined(__GNUC_=
_) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 manag=
ement_auth_failure(const struct management *man, const char *type, const ch=
ar *reason)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2168?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1=
c87faefd3adc2d95b5318437d097c3970a120d3
Gerrit-Change-Number: 2168
Gerrit-P=
atchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>

--JVDz4gnOcgo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">console: Switch response_len to size_t<br><br>We need some=
 casts either way since the system<br>APIs are just too different=2E But ov=
erall it feels<br>cleaner when using size_t=2E<br><br>Change-Id: I1c87faefd=
3adc2d95b5318437d097c3970a120d3<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvp=
n/buffer=2Eh<br>M src/openvpn/console=2Ec<br>M src/openvpn/console=2Eh<br>M=
 src/openvpn/console_builtin=2Ec<br>M src/openvpn/console_systemd=2Ec<br>M =
tests/unit_tests/openvpn/test_user_pass=2Ec<br>7 files changed, 20 insertio=
ns(+), 47 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/68/2168/1</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index a4e2809=
=2E=2E05c4e30 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br=
><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -576,9 +576,9 @@</sp=
an><br><span>  * like buf_null_terminate, but operate on strings</span><br>=
<span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-string_null_terminate(char *str, int len, int capacity)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+string_null_terminate(char *=
str, size_t len, size_t capacity)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(len &gt;=3D 0 &amp;&amp; len &lt=
;=3D capacity &amp;&amp; capacity &gt; 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(len &lt;=3D capacity &amp;&amp; capacity =
&gt; 0);</span><br><span>     if (len &lt; capacity)</span><br><span>     {=
</span><br><span>         *(str + len) =3D &#39;\0&#39;;</span><br><span>di=
ff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>=
index ae6dcb7=2E=2E541f0bd 100644</span><br><span>--- a/src/openvpn/buffer=
=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -872,7=
 +872,7 @@</span><br><span>  * @param capacity  Total size of the character=
 buffer in bytes=2E</span><br><span>  */</span><br><span> #ifdef _WIN32</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void string_null_terminat=
e(char *str, int len, int capacity);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void string_null_terminate(char *str, size_t len, size_t c=
apacity);</span><br><span> #endif</span><br><span> /**@}*/</span><br><span>=
 /* End of string utility functions */</span><br><span>diff --git a/src/ope=
nvpn/console=2Ec b/src/openvpn/console=2Ec</span><br><span>index 78f445b=2E=
=2E358b9ae 100644</span><br><span>--- a/src/openvpn/console=2Ec</span><br><=
span>+++ b/src/openvpn/console=2Ec</span><br><span>@@ -53,7 +53,7 @@</span>=
<br><span> </span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-query_user_add(char *prompt, char *resp, in=
t resp_len, bool echo)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+query_user_add(char *prompt, char *resp, size_t resp_len, bool echo)</sp=
an><br><span> {</span><br><span>     int i;</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/console=2Eh b/src/openvpn/console=2Eh</span><br=
><span>index 89550ce=2E=2E94b1032 100644</span><br><span>--- a/src/openvpn/=
console=2Eh</span><br><span>+++ b/src/openvpn/console=2Eh</span><br><span>@=
@ -32,10 +32,10 @@</span><br><span>  */</span><br><span> struct _query_user=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  char *prompt;     /**&lt; Prompt to present to the user */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    char *response;   /**&lt; The us=
er&#39;s response */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int response_len; /**&lt; Length the of the user response */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    bool echo;        /**&lt; Tru=
e: The user should see what is being typed, otherwise mask it */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char *prompt;        /**&l=
t; Prompt to present to the user */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char *response;      /**&lt; The user&#39;s response */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t response=
_len; /**&lt; Length the of the user response */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool echo;           /**&lt; True: The use=
r should see what is being typed, otherwise mask it */</span><br><span> };<=
/span><br><span> </span><br><span> #define QUERY_USER_NUMSLOTS 10</span><br=
><span>@@ -57,7 +57,7 @@</span><br><span>  * @param echo       Should the u=
ser input be echoed to the user?  If False, input will be masked</span><br>=
<span>  *</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void query_user_add(char *prompt, char *resp, int resp_len, bool e=
cho);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void query_use=
r_add(char *prompt, char *resp, size_t resp_len, bool echo);</span><br><spa=
n> </span><br><span> </span><br><span> /**</span><br><span>@@ -115,7 +115,7=
 @@</span><br><span>  *</span><br><span>  */</span><br><span> static inline=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-query_user_SINGL=
E(char *prompt, char *resp, int resp_len, bool echo)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+query_user_SINGLE(char *prompt, char *res=
p, size_t resp_len, bool echo)</span><br><span> {</span><br><span>     quer=
y_user_clear();</span><br><span>     query_user_add(prompt, resp, resp_len,=
 echo);</span><br><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/=
openvpn/console_builtin=2Ec</span><br><span>index 0353ade=2E=2E8206d3d 1006=
44</span><br><span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>++=
+ b/src/openvpn/console_builtin=2Ec</span><br><span>@@ -41,11 +41,6 @@</spa=
n><br><span> #include &lt;termios=2Eh&gt;</span><br><span> #endif</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</spa=
n><br><span> </span><br><span> #include &quot;win32=2Eh&quot;</span><br><sp=
an>@@ -62,11 +57,11 @@</span><br><span>  *         exit event is signaled=
=2E</span><br><span>  */</span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-get_console_input_win32(const char *prompt,=
 const bool echo, char *input, const int capacity)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+get_console_input_win32(const char *prompt, =
const bool echo, char *input, const size_t capacity)</span><br><span> {</sp=
an><br><span>     ASSERT(prompt);</span><br><span>     ASSERT(input);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(capacity &gt; 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(capacit=
y &gt; 0 &amp;&amp; capacity &lt; INT_MAX);</span><br><span> </span><br><sp=
an>     input[0] =3D &#39;\0&#39;;</span><br><span> </span><br><span>@@ -11=
0,16 +105,16 @@</span><br><span>             return false;</span><br><span>=
         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        status =3D ReadConsoleW(in, winput, capacity, &amp;len, NULL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        WideCharToM=
ultiByte(CP_UTF8, 0, winput, len, input, capacity, NULL, NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        status =3D ReadConsoleW=
(in, winput, (DWORD)capacity, &amp;len, NULL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        WideCharToMultiByte(CP_UTF8, 0, winput, =
(int)len, input, (int)capacity, NULL, NULL);</span><br><span>         free(=
winput);</span><br><span>     }</span><br><span>     else</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =
=3D ReadFile(in, input, capacity, &amp;len, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        status =3D ReadFile(in, input, (DWOR=
D)capacity, &amp;len, NULL);</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    string_null_terminate(i=
nput, (int)len, capacity);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    string_null_terminate(input, len, capacity);</span><br><span>   =
  chomp(input);</span><br><span> </span><br><span>     if (!echo)</span><br=
><span>@@ -191,11 +186,11 @@</span><br><span>  *  @returns Returns True if =
user input was gathered</span><br><span>  */</span><br><span> static bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_console_input(const=
 char *prompt, const bool echo, char *input, const int capacity)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+get_console_input(const char *=
prompt, const bool echo, char *input, const size_t capacity)</span><br><spa=
n> {</span><br><span>     ASSERT(prompt);</span><br><span>     ASSERT(input=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(capacity=
 &gt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(capacity &gt; 0 &amp;&amp; capacity &lt;=3D INT_MAX);</span><br><span>    =
 input[0] =3D &#39;\0&#39;;</span><br><span> </span><br><span> #ifdef _WIN3=
2</span><br><span>@@ -238,7 +233,7 @@</span><br><span>         restore_tty =
=3D (tcsetattr(fileno(fp), TCSAFLUSH, &amp;tty_tmp) =3D=3D 0);</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (fgets(input, capacity, fp) !=3D NULL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (fgets(input, (int)capacity, fp) !=
=3D NULL)</span><br><span>     {</span><br><span>         chomp(input);</sp=
an><br><span>         ret =3D true;</span><br><span>@@ -294,7 +289,3 @@</sp=
an><br><span> </span><br><span>     return ret;</span><br><span> }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>d=
iff --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/console_systemd=
=2Ec</span><br><span>index 8fc7f72=2E=2Ef0ca7fa 100644</span><br><span>--- =
a/src/openvpn/console_systemd=2Ec</span><br><span>+++ b/src/openvpn/console=
_systemd=2Ec</span><br><span>@@ -53,13 +53,8 @@</span><br><span>     return=
 (sd_booted() &gt; 0) &amp;&amp; (stat(SYSTEMD_ASK_PASSWORD_PATH, &amp;c) =
=3D=3D 0);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-get_console_input_systemd(const char *prompt, const bool echo, c=
har *input, const int capacity)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+get_console_input_systemd(const char *prompt, const bool echo, =
char *input, const size_t capacity)</span><br><span> {</span><br><span>    =
 int std_out;</span><br><span>     bool ret =3D false;</span><br><span>@@ -=
91,10 +86,6 @@</span><br><span>     return ret;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> /**</span><br><span>  *  Systemd aware implementation of =
query_user_exec()=2E  If systemd is not running</span><br><span>  *  it wil=
l fall back to use query_user_exec_builtin() instead=2E</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/op=
envpn/test_user_pass=2Ec</span><br><span>index 5bc1d2a=2E=2E54b3617 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>@@=
 -47,11 +47,6 @@</span><br><span> }</span><br><span> #endif</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> qu=
ery_user_exec_builtin(void)</span><br><span> {</span><br><span>@@ -65,10 +6=
0,6 @@</span><br><span>     return mock();</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> void</span><br><span> management_auth_failure(const struct man=
agement *man, const char *type, const char *reason)</span><br><span> {</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2168?usp=3Demail">change 2168</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2168?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I1c87faefd3adc2d95b5318437d097c3970a1=
20d3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2168 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--JVDz4gnOcgo=--


--===============1572077338227331553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1572077338227331553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1572077338227331553==--

