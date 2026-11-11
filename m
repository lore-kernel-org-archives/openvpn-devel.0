Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E1606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Bwc6PA33;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LTEJObfh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lFSPJhLq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K5LOouRk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0+pjN63nOrHHFPyczN3gR1fZkeAtKDFNz0XUKYJ/Qmw=; b=Bwc6PA334CMx49LXx/JViORRuX
	f/Mtni1VH0U786vqGw4T0vIjN2gw1RK471lugDB0arykujG0x8OgJEA86sGYXFB3hNoTUQBAP19oM
	Pw16282yjqDrxaCBVXkXGUTwjLeCeuTS6ojXaLesAIp77znKvJHxfNdTXTcsVd5ZLy4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRBv9-000000006NY-0lZn;
	Wed, 11 Nov 2026 17:15:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRBv6-000000006NH-3hJf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:15:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4tFNY0FVP5H8+SKMnNLpLdC/4lC6UdeWLaN68qcp1nw=; b=LTEJObfh1OFn2ccKn2ME666jQz
 B+Y2SBBjuCkAIkstGiN4Z/eCzNf0feqyE9BNJzGBP4m7x6f3sFJBVtjWoAOIY3qnEpDfXGcEgChlO
 itg06XXdVMmYE7KdCz+4eEaWEs7/Rk5hZbR0vv9FTBfrBOzw6W0AF8MAudejOivJFHvg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4tFNY0FVP5H8+SKMnNLpLdC/4lC6UdeWLaN68qcp1nw=; b=lFSPJhLqTL/qD/UphWCardlQu3
 qP7b3K/sEZDdIuVmYkN6WVteiYPqiS1ZZ8zT3iFYlJsioGqR2Jpke4a0DDYOOJh3FFCxss2VeGAug
 MWkEPK5GENkhwWZhvBfxT5dyG2YX4UrwXnrvGwKh+DkCeW1mZilFdhi8zwBRtC3hbJZU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRBv3-000000003Mt-49Rp for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:15:36 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so467735e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 09:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794417327; x=1795022127; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4tFNY0FVP5H8+SKMnNLpLdC/4lC6UdeWLaN68qcp1nw=;
 b=K5LOouRk2ubmZE/fPpjykBVfgk0AwOEvaAHaMkQw0KXd5rC0H2eYI6S6Byy4B9+YEw
 B6c1bXI3fW+uJRQ4Z28Ne/C/7YDXFM61acLgZ+MmBi/7gWpAH4PGOBFXXWU9sHJIk7JL
 nfbPcOV6z50ewwbNg+4QzuBgUE58kiHOBRjBkQ73USLSSrqlBjq+1UzagVUT4+kCV4S5
 ynGhfmBTrkFHhkxdQOeC+da4JneGWa/PCK9VtdGB3thl0Fug6qAqhB60NqUQXghFE0+Y
 VPhnPkLR+uWs0GbF4/KMZqsA8aHphka/8g3Sl1vkvN9eA1k6BNGUEkexIBKcCm3X/dQb
 Rp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417327; x=1795022127;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4tFNY0FVP5H8+SKMnNLpLdC/4lC6UdeWLaN68qcp1nw=;
 b=d5OWjVdCJu+PohupEeuaCeZfcSE8a5KbLxCh8uiu2AY2jXApP+m1TlmHVEjA2rUn0Y
 49aYGMYvCrXUsIrc5xJhyWIfvwNT/iMywfDofyAgRoz+nk3DumCn1g4vuwvppmBcynRq
 jvxV7bZpoK/957j/QlCYPo62q04Fgdzu74ydvdoLWwV+N6df/ZXD0Hl5jm7LdDLU8nBS
 SFxk/4iC1lamcmAr0AvsLYbRANKQe/Diq0B6u3Pk/GGOFklkAd0OLfA6WFoW84mmmvsT
 G3gbqqBlzTwGZZ1CLxEqrx2dEB3l/ozCGmvkdfwSrRjiNCw/Pq5GKMVXEePHZDqpZhDj
 ckjQ==
X-Gm-Message-State: APuU4Z+f4+BxTYxXafwkFzr2c/KCwwVNo1XuMsSvHAT/Lnk3/xyzarWI
 UFfCnGhIyFuwb4Oj9iemvj01QUnLgMJgRj7Dqh76EqH82awduIx27gUyjdhP/fa5wL870R7IXSp
 Rljpu9wlobvcVtG95qEWCvrEl7oO9gD4QuCSVHV9buIokPk0p66reR5qn86wgDrm/xd80
X-Gm-Gg: AYBFou3VnxIOO9u/DSub+zal/ZmrucZtG8bXxkPnl70Zb3vKDqnm7b7WPfLq9mZHmsO
 m41KSkn+G9CKB2pHQ5UGUjqB89AYmU6qjKSTasDO+ni7R6j4/hG/gj3o+qRVvYPQxW69MIa9VLv
 f0pYx6NIWfc4e/t7z691jp9kJ/gZNMLGDJE906Yloc6ds/FrOQx7edq0zRX7xltKatSoqBAG6UT
 85Uj/IUG4wNNBFbLm6G67L04hQ1VvKD5iHkdN5yMMheeDDGyybjzS3pfB+85UKSkU33w1Lduybu
 3pjIbG9H4k6XlPo/j5IinnTBL1YxiTYO7pe2WmxvWN8EEr9M4pNFtNuX25DR6VsZKSe6kdsGTXI
 ieJlR0gmJfVp9/wAG4ldlbRpOYecjlajaNf5zQH6Ne+INjwGqyFJPwkrZtjA74SHyulroWSgcBB
 4LFOVJ5IacQfIeWp3tdKQG0rSiagHY6BMxF5sbfC8k0RHJIduUMCQyuA/HrnKVyA9T7XFQ7Ji4O
 nmckBNd7fqDx1JOriNeq0CiiUqIvDWRqVgHeCEtdZPtivhK8+v2WVqvLXbKkJvBtt9khI5Wbcly
 K6WkGRPGUAUvCWIKLpHnM/ehmMzeAmQW/3LMFmgTrcGqJyxCOkaR7Z8prVURA8T7Xk6GV/PbGdg
 1K233wONSRbuyuylWBcOgi7ficFUU282COvvjtmziy70tQwgUcv3VrfvSWBqJ7th9TYJHaZY2Tm
 efHMvh2Wx9nQCB+F0=
X-Received: by 2002:a05:600c:c16d:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4bb4e29ac6bmr1931015e9.17.1794417327048; 
 Wed, 11 Nov 2026 09:15:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e251c26sm2655225e9.1.2026.11.11.09.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:15:26 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 17:15:22 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3
X-Gerrit-Change-Number: 2168
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2168?usp=email>
X-Gerrit-Commit: 2c0abb972e7c12700b545b4fc692988d1a36a690
In-Reply-To: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
References: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzIxNDQyMDAwLkkxYzg3ZmFlZmQzYWRjMmQ5NWI1MzE4NDM3ZDA5N2MzOTcwYTEyMGQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9558b5d272a2e5a3dba5af33f0ecf4488934ee7c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRBv3-000000003Mt-49Rp
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7988367911297997258=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7988367911297997258==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9aJX2myflZI="; charset=UTF-8

--9aJX2myflZI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a chan=
ge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=
=3Demail

to look at the new patch set (#2)=2E

The change is no longer sub=
mittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: c=
onsole: Switch response_len to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

console: Switch response_len to size_t

We need s=
ome casts either way since the system
APIs are just too different=2E But ov=
erall it feels
cleaner when using size_t=2E

Change-Id: I1c87faefd3adc2d95b=
5318437d097c3970a120d3
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn=
/console=2Ec
M src/openvpn/console=2Eh
M src/openvpn/console_builtin=2Ec
M =
src/openvpn/console_systemd=2Ec
M tests/unit_tests/openvpn/test_user_pass=
=2Ec
7 files changed, 20 insertions(+), 47 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/2168/2

diff --git a/s=
rc/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index a4e2809=2E=2E05c4e30 1=
00644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -576,9 +=
576,9 @@
  * like buf_null_terminate, but operate on strings
  */
 void
-st=
ring_null_terminate(char *str, int len, int capacity)
+string_null_terminat=
e(char *str, size_t len, size_t capacity)
 {
-    ASSERT(len >=3D 0 && len =
<=3D capacity && capacity > 0);
+    ASSERT(len <=3D capacity && capacity >=
 0);
     if (len < capacity)
     {
         *(str + len) =3D '\0';
diff -=
-git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index ae6dcb7=2E=2E5=
41f0bd 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ =
-872,7 +872,7 @@
  * @param capacity  Total size of the character buffer in=
 bytes=2E
  */
 #ifdef _WIN32
-void string_null_terminate(char *str, int le=
n, int capacity);
+void string_null_terminate(char *str, size_t len, size_t=
 capacity);
 #endif
 /**@}*/
 /* End of string utility functions */
diff --=
git a/src/openvpn/console=2Ec b/src/openvpn/console=2Ec
index 78f445b=2E=2E=
358b9ae 100644
--- a/src/openvpn/console=2Ec
+++ b/src/openvpn/console=2Ec
=
@@ -53,7 +53,7 @@
 
 
 void
-query_user_add(char *prompt, char *resp, int r=
esp_len, bool echo)
+query_user_add(char *prompt, char *resp, size_t resp_l=
en, bool echo)
 {
     int i;
 
diff --git a/src/openvpn/console=2Eh b/src/=
openvpn/console=2Eh
index 89550ce=2E=2E94b1032 100644
--- a/src/openvpn/con=
sole=2Eh
+++ b/src/openvpn/console=2Eh
@@ -32,10 +32,10 @@
  */
 struct _qu=
ery_user
 {
-    char *prompt;     /**< Prompt to present to the user */
- =
   char *response;   /**< The user's response */
-    int response_len; /**=
< Length the of the user response */
-    bool echo;        /**< True: The =
user should see what is being typed, otherwise mask it */
+    char *prompt=
;        /**< Prompt to present to the user */
+    char *response;      /*=
*< The user's response */
+    size_t response_len; /**< Length the of the =
user response */
+    bool echo;           /**< True: The user should see w=
hat is being typed, otherwise mask it */
 };
 
 #define QUERY_USER_NUMSLOTS=
 10
@@ -57,7 +57,7 @@
  * @param echo       Should the user input be echoed=
 to the user?  If False, input will be masked
  *
  */
-void query_user_add=
(char *prompt, char *resp, int resp_len, bool echo);
+void query_user_add(c=
har *prompt, char *resp, size_t resp_len, bool echo);
 
 
 /**
@@ -115,7 +1=
15,7 @@
  *
  */
 static inline bool
-query_user_SINGLE(char *prompt, char =
*resp, int resp_len, bool echo)
+query_user_SINGLE(char *prompt, char *resp=
, size_t resp_len, bool echo)
 {
     query_user_clear();
     query_user_a=
dd(prompt, resp, resp_len, echo);
diff --git a/src/openvpn/console_builtin=
=2Ec b/src/openvpn/console_builtin=2Ec
index 0353ade=2E=2E8206d3d 100644
--=
- a/src/openvpn/console_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@=
@ -41,11 +41,6 @@
 #include <termios=2Eh>
 #endif
 
-#if defined(__GNUC__) =
|| defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic =
ignored "-Wsign-conversion"
-#endif
-
 #ifdef _WIN32
 
 #include "win32=2Eh=
"
@@ -62,11 +57,11 @@
  *         exit event is signaled=2E
  */
 static bo=
ol
-get_console_input_win32(const char *prompt, const bool echo, char *inpu=
t, const int capacity)
+get_console_input_win32(const char *prompt, const b=
ool echo, char *input, const size_t capacity)
 {
     ASSERT(prompt);
     =
ASSERT(input);
-    ASSERT(capacity > 0);
+    ASSERT(capacity > 0 && capac=
ity < INT_MAX);
 
     input[0] =3D '\0';
 
@@ -110,16 +105,16 @@
         =
    return false;
         }
 
-        status =3D ReadConsoleW(in, winput,=
 capacity, &len, NULL);
-        WideCharToMultiByte(CP_UTF8, 0, winput, le=
n, input, capacity, NULL, NULL);
+        status =3D ReadConsoleW(in, winpu=
t, (DWORD)capacity, &len, NULL);
+        WideCharToMultiByte(CP_UTF8, 0, w=
input, (int)len, input, (int)capacity, NULL, NULL);
         free(winput);
=
     }
     else
     {
-        status =3D ReadFile(in, input, capacity, &=
len, NULL);
+        status =3D ReadFile(in, input, (DWORD)capacity, &len, =
NULL);
     }
 
-    string_null_terminate(input, (int)len, capacity);
+   =
 string_null_terminate(input, len, capacity);
     chomp(input);
 
     if =
(!echo)
@@ -191,11 +186,11 @@
  *  @returns Returns True if user input was =
gathered
  */
 static bool
-get_console_input(const char *prompt, const boo=
l echo, char *input, const int capacity)
+get_console_input(const char *pro=
mpt, const bool echo, char *input, const size_t capacity)
 {
     ASSERT(pr=
ompt);
     ASSERT(input);
-    ASSERT(capacity > 0);
+    ASSERT(capacity =
> 0 && capacity <=3D INT_MAX);
     input[0] =3D '\0';
 
 #ifdef _WIN32
@@ =
-238,7 +233,7 @@
         restore_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH,=
 &tty_tmp) =3D=3D 0);
     }
 
-    if (fgets(input, capacity, fp) !=3D NUL=
L)
+    if (fgets(input, (int)capacity, fp) !=3D NULL)
     {
         chom=
p(input);
         ret =3D true;
@@ -294,7 +289,3 @@
 
     return ret;
 }
=
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
=
-#endif
diff --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/console_=
systemd=2Ec
index 8fc7f72=2E=2Ef0ca7fa 100644
--- a/src/openvpn/console_sys=
temd=2Ec
+++ b/src/openvpn/console_systemd=2Ec
@@ -53,13 +53,8 @@
     retu=
rn (sd_booted() > 0) && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) =3D=3D 0);
 }
=
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push=

-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static bool=

-get_console_input_systemd(const char *prompt, const bool echo, char *inpu=
t, const int capacity)
+get_console_input_systemd(const char *prompt, const=
 bool echo, char *input, const size_t capacity)
 {
     int std_out;
     b=
ool ret =3D false;
@@ -91,10 +86,6 @@
     return ret;
 }
 
-#if defined(__=
GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  =
*  Systemd aware implementation of query_user_exec()=2E  If systemd is not =
running
  *  it will fall back to use query_user_exec_builtin() instead=2E
=
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests=
/openvpn/test_user_pass=2Ec
index 5bc1d2a=2E=2E54b3617 100644
--- a/tests/u=
nit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/test_us=
er_pass=2Ec
@@ -47,11 +47,6 @@
 }
 #endif
 
-#if defined(__GNUC__) || defin=
ed(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored =
"-Wsign-conversion"
-#endif
-
 bool
 query_user_exec_builtin(void)
 {
@@ -6=
5,10 +60,6 @@
     return mock();
 }
 
-#if defined(__GNUC__) || defined(__=
clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 management_auth_failu=
re(const struct management *man, const char *type, const char *reason)
 {

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c87faefd3adc2=
d95b5318437d097c3970a120d3
Gerrit-Change-Number: 2168
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--9aJX2myflZI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Frank Lich=
tenheld <strong>uploaded patch set #2</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">console: Switch response_len to siz=
e_t<br><br>We need some casts either way since the system<br>APIs are just =
too different=2E But overall it feels<br>cleaner when using size_t=2E<br><b=
r>Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buf=
fer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/console=2Ec<br>M src/o=
penvpn/console=2Eh<br>M src/openvpn/console_builtin=2Ec<br>M src/openvpn/co=
nsole_systemd=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=2Ec<br>7 fil=
es changed, 20 insertions(+), 47 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/2168/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><b=
r><span>index a4e2809=2E=2E05c4e30 100644</span><br><span>--- a/src/openvpn=
/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@=
 -576,9 +576,9 @@</span><br><span>  * like buf_null_terminate, but operate =
on strings</span><br><span>  */</span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-string_null_terminate(char *str, int len, i=
nt capacity)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+string_=
null_terminate(char *str, size_t len, size_t capacity)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(len &gt;=3D =
0 &amp;&amp; len &lt;=3D capacity &amp;&amp; capacity &gt; 0);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(len &lt;=3D capacity =
&amp;&amp; capacity &gt; 0);</span><br><span>     if (len &lt; capacity)</s=
pan><br><span>     {</span><br><span>         *(str + len) =3D &#39;\0&#39;=
;</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh</span><br><span>index ae6dcb7=2E=2E541f0bd 100644</span><br><span>--- =
a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span=
><br><span>@@ -872,7 +872,7 @@</span><br><span>  * @param capacity  Total s=
ize of the character buffer in bytes=2E</span><br><span>  */</span><br><spa=
n> #ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
string_null_terminate(char *str, int len, int capacity);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void string_null_terminate(char *str, =
size_t len, size_t capacity);</span><br><span> #endif</span><br><span> /**@=
}*/</span><br><span> /* End of string utility functions */</span><br><span>=
diff --git a/src/openvpn/console=2Ec b/src/openvpn/console=2Ec</span><br><s=
pan>index 78f445b=2E=2E358b9ae 100644</span><br><span>--- a/src/openvpn/con=
sole=2Ec</span><br><span>+++ b/src/openvpn/console=2Ec</span><br><span>@@ -=
53,7 +53,7 @@</span><br><span> </span><br><span> </span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-query_user_add(char *prom=
pt, char *resp, int resp_len, bool echo)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+query_user_add(char *prompt, char *resp, size_t resp_l=
en, bool echo)</span><br><span> {</span><br><span>     int i;</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/console=2Eh b/src/openvpn/con=
sole=2Eh</span><br><span>index 89550ce=2E=2E94b1032 100644</span><br><span>=
--- a/src/openvpn/console=2Eh</span><br><span>+++ b/src/openvpn/console=2Eh=
</span><br><span>@@ -32,10 +32,10 @@</span><br><span>  */</span><br><span> =
struct _query_user</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    char *prompt;     /**&lt; Prompt to present to the user=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *response=
;   /**&lt; The user&#39;s response */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int response_len; /**&lt; Length the of the user respo=
nse */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool echo; =
       /**&lt; True: The user should see what is being typed, otherwise mas=
k it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *pr=
ompt;        /**&lt; Prompt to present to the user */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *response;      /**&lt; The user=
&#39;s response */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   size_t response_len; /**&lt; Length the of the user response */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool echo;           /**=
&lt; True: The user should see what is being typed, otherwise mask it */</s=
pan><br><span> };</span><br><span> </span><br><span> #define QUERY_USER_NUM=
SLOTS 10</span><br><span>@@ -57,7 +57,7 @@</span><br><span>  * @param echo =
      Should the user input be echoed to the user?  If False, input will be=
 masked</span><br><span>  *</span><br><span>  */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void query_user_add(char *prompt, char *resp, in=
t resp_len, bool echo);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void query_user_add(char *prompt, char *resp, size_t resp_len, bool ech=
o);</span><br><span> </span><br><span> </span><br><span> /**</span><br><spa=
n>@@ -115,7 +115,7 @@</span><br><span>  *</span><br><span>  */</span><br><s=
pan> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-query_user_SINGLE(char *prompt, char *resp, int resp_len, bool echo)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+query_user_SINGLE(char *=
prompt, char *resp, size_t resp_len, bool echo)</span><br><span> {</span><b=
r><span>     query_user_clear();</span><br><span>     query_user_add(prompt=
, resp, resp_len, echo);</span><br><span>diff --git a/src/openvpn/console_b=
uiltin=2Ec b/src/openvpn/console_builtin=2Ec</span><br><span>index 0353ade=
=2E=2E8206d3d 100644</span><br><span>--- a/src/openvpn/console_builtin=2Ec<=
/span><br><span>+++ b/src/openvpn/console_builtin=2Ec</span><br><span>@@ -4=
1,11 +41,6 @@</span><br><span> #include &lt;termios=2Eh&gt;</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsig=
n-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
#ifdef _WIN32</span><br><span> </span><br><span> #include &quot;win32=2Eh&q=
uot;</span><br><span>@@ -62,11 +57,11 @@</span><br><span>  *         exit e=
vent is signaled=2E</span><br><span>  */</span><br><span> static bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-get_console_input_win32(con=
st char *prompt, const bool echo, char *input, const int capacity)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+get_console_input_win32(cons=
t char *prompt, const bool echo, char *input, const size_t capacity)</span>=
<br><span> {</span><br><span>     ASSERT(prompt);</span><br><span>     ASSE=
RT(input);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
capacity &gt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ASSERT(capacity &gt; 0 &amp;&amp; capacity &lt; INT_MAX);</span><br><span=
> </span><br><span>     input[0] =3D &#39;\0&#39;;</span><br><span> </span>=
<br><span>@@ -110,16 +105,16 @@</span><br><span>             return false;<=
/span><br><span>         }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        status =3D ReadConsoleW(in, winput, capacity=
, &amp;len, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     WideCharToMultiByte(CP_UTF8, 0, winput, len, input, capacity, NULL, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =
=3D ReadConsoleW(in, winput, (DWORD)capacity, &amp;len, NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        WideCharToMultiByte(CP_U=
TF8, 0, winput, (int)len, input, (int)capacity, NULL, NULL);</span><br><spa=
n>         free(winput);</span><br><span>     }</span><br><span>     else</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        status =3D ReadFile(in, input, capacity, &amp;len, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D ReadFile(i=
n, input, (DWORD)capacity, &amp;len, NULL);</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    string_n=
ull_terminate(input, (int)len, capacity);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    string_null_terminate(input, len, capacity);</spa=
n><br><span>     chomp(input);</span><br><span> </span><br><span>     if (!=
echo)</span><br><span>@@ -191,11 +186,11 @@</span><br><span>  *  @returns R=
eturns True if user input was gathered</span><br><span>  */</span><br><span=
> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_cons=
ole_input(const char *prompt, const bool echo, char *input, const int capac=
ity)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_console_inp=
ut(const char *prompt, const bool echo, char *input, const size_t capacity)=
</span><br><span> {</span><br><span>     ASSERT(prompt);</span><br><span>  =
   ASSERT(input);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ASSERT(capacity &gt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ASSERT(capacity &gt; 0 &amp;&amp; capacity &lt;=3D INT_MAX);</span=
><br><span>     input[0] =3D &#39;\0&#39;;</span><br><span> </span><br><spa=
n> #ifdef _WIN32</span><br><span>@@ -238,7 +233,7 @@</span><br><span>      =
   restore_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &amp;tty_tmp) =3D=3D 0=
);</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (fgets(input, capacity, fp) !=3D NULL)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (fgets(input, (int)c=
apacity, fp) !=3D NULL)</span><br><span>     {</span><br><span>         cho=
mp(input);</span><br><span>         ret =3D true;</span><br><span>@@ -294,7=
 +289,3 @@</span><br><span> </span><br><span>     return ret;</span><br><sp=
an> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span>diff --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/con=
sole_systemd=2Ec</span><br><span>index 8fc7f72=2E=2Ef0ca7fa 100644</span><b=
r><span>--- a/src/openvpn/console_systemd=2Ec</span><br><span>+++ b/src/ope=
nvpn/console_systemd=2Ec</span><br><span>@@ -53,13 +53,8 @@</span><br><span=
>     return (sd_booted() &gt; 0) &amp;&amp; (stat(SYSTEMD_ASK_PASSWORD_PAT=
H, &amp;c) =3D=3D 0);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> static bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-get_console_input_systemd(const char *prompt, const b=
ool echo, char *input, const int capacity)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+get_console_input_systemd(const char *prompt, const =
bool echo, char *input, const size_t capacity)</span><br><span> {</span><br=
><span>     int std_out;</span><br><span>     bool ret =3D false;</span><br=
><span>@@ -91,10 +86,6 @@</span><br><span>     return ret;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> /**</span><br><span>  *  Systemd aware impleme=
ntation of query_user_exec()=2E  If systemd is not running</span><br><span>=
  *  it will fall back to use query_user_exec_builtin() instead=2E</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/un=
it_tests/openvpn/test_user_pass=2Ec</span><br><span>index 5bc1d2a=2E=2E54b3=
617 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><=
br><span>@@ -47,11 +47,6 @@</span><br><span> }</span><br><span> #endif</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><b=
r><span> query_user_exec_builtin(void)</span><br><span> {</span><br><span>@=
@ -65,10 +60,6 @@</span><br><span>     return mock();</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> void</span><br><span> management_auth_failure(const=
 struct management *man, const char *type, const char *reason)</span><br><s=
pan> {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2168?usp=3Demail">change 2168</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c87faefd3adc2d95b5318=
437d097c3970a120d3 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2168 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--9aJX2myflZI=--


--===============7988367911297997258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7988367911297997258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7988367911297997258==--

