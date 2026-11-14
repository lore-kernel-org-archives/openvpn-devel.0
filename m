Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA0606A32D
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IwT3zpPx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZLEYE1xG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WKj4TrDa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GWaGJDmC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3CFjvbVF143MEPDBo4nfKFN98OC96urO/dPLw7hLgzU=; b=IwT3zpPxF1vG7n46kyFqfzIggd
	xSCKtPOIL+V7iG5Bxuj9IrUV41zk2SntSvFIc00TT1GPWkTkSNExx+14LdPR0sTMQ4UF1KB+ptdhY
	nYxz/jbRS/KIQeJmVWM/z8qoIwD0U0pN+1bd1P7mlDG5iArOkZLWZERfVjs3bQhD2BW8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSFXS-000000002Gr-1Cg8;
	Sat, 14 Nov 2026 15:19:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSFXQ-000000002Gj-17vr
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:19:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v3UKK9ouvqNI5U4j8hDgZ0KVR4FDnxtUfFRBx2buQH4=; b=ZLEYE1xGWVJZfRx7dZex5oibXx
 OGzXVlsChuEZlEHg4ds9eZQs7qDLdBD0Tu5JzQn96WPuz6kbMdAljbmEjdEem6PdM2gU4aP7+1Cuv
 UaZxLPA/VRqkWdb/PqzYrG+62ci3g+CzsJBMviwZvcWIwDLwWV+bS8vD0VnIhEFI3XDU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v3UKK9ouvqNI5U4j8hDgZ0KVR4FDnxtUfFRBx2buQH4=; b=WKj4TrDaIIbJuMLCtjl9kCQVqB
 9WheJAnGOQrMTHk9g2UnbQfI1tynu0t/qUOPhv2R4t/UAmhtx08+FsEItxTIYgDRwdyTFdzEfdkwD
 HQO+OubQRVt/cyEc6wFKybMhPbffa3D5QmRtb8EwLU34U3WEVDhZ/6YJE1o+bDh1Gs+E=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSFXO-000000008OD-3Dza for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:19:32 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-491971ac844so1970722f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 07:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794669564; x=1795274364; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v3UKK9ouvqNI5U4j8hDgZ0KVR4FDnxtUfFRBx2buQH4=;
 b=GWaGJDmCtdv9k7nzEJjeLtwnVZOmJrT3KsGbFxqXQNBFI5yuBzOvV0wb7j9kNXXhMy
 sr7j5zpb2BPiKLHfkPB9F8+mG2m7JTbwFRfNeIkCjccvuVuOu0eJNMrimFoybkBjzf2h
 bgPM6RqVGDvu7ex8MI/DvnTwdwdiRpITw17NZiYcr4Pob6N8tj/+6K2JX2GisMUE2pmD
 K7QfHTXEx0oQ13E5YipQ2+xyiCNJi8NIofezyBou1Mwu5rruOLAWme4WEY3pkSfBMk9r
 mcCjguLncBI/IEhxB0hicvULgErI8COOQ1TjrcrIdT40dmpD0+9VxZO8d+rqwpgGT1TK
 nEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794669564; x=1795274364;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v3UKK9ouvqNI5U4j8hDgZ0KVR4FDnxtUfFRBx2buQH4=;
 b=vpV40uBv/4x9I3hIaCsUoG1QHFD9q4t3QbtjaNiZUOOz96iPOZiVKoLfiFVmE+yf+C
 Jg9x6j0DXMLzzyOj0IWpBazq4jH4rZVUK5SP447NvYZkuXZkWLBlAfUxDs8If1Y4sxm5
 vchInGYyOs1Hhn/NoNgB4aYJkBXPGqqXKba81qKFNbfnKd2gLoCroNuh2oXfYqut2oNV
 RF3n82kyAn+MBOssxRnkfrBIu33Ps4dsznvYx68NAH3K1sO6BpeO6KiHgqxLdEigj+Qg
 S2+Mi9Ih40rpB3/W8LUuRhy6FHBzmulL2trgVwHGgDCGElbncQPomlB9U7aGHH1iiett
 IqqQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFG1mes/SCaIMtgU4NDF6DqYSYKFaV09SYkSaUwq0CTtd1psbb+EeGxfTIRCBFDPy/VHl2zPPA+sAbT9QUO@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/wdoDW2/0NpPyGcNCfLwP2f4etQsMEvjOMqpDPEB9zcLgGSurJ
 qQIJ+CZXzZjw8hNJ1xzZf7obeP8SeTx7F02AMFjNPUDk4fwwTeRe2eXHLsIlubqdLOMmTduOMci
 V9QVUc0XePXoExVCYpuDfKKHM9s4QOfcHxZnWt8HDPSooD1Ix8lKtN9VZ167ZZDZCi3RG
X-Gm-Gg: AYBFou2cBLwUfMfoVpgy0cXHFYXG0SmRsw7n+Px2/k32XLGhj+7lZgAUu4cImqvTtEp
 r9HAWLlGVEeND4KsijaIIynqvG07aALxtKM2dvgJ8lAknae4tH/GN5qynB1/Nd1W++n1mAUc8wT
 ed8IBS4i4WFnjNJcXkRwQuQ0+yhs8/CdBNfSqQBFB6ruLVOJRJt46BUkU6FSF0VKmwggeOCqFvN
 sjHivjhQfOIIl1RsK8W6EKDVGSX0ij2iQiqUNIM2dK0qJfMxu7izdW852NuIjomKD6EX0RCSEJD
 FlVInDpY96CruDg8ySg6Uwiv+dyuO0UtfXTYlQCkO+Ddk8aUul2MR2UD7qGVeuYoPl+Jsjjf/0E
 e/h+WSqwXXhY1GMmWvblAtlaeoEpGsipCanvZ0QWyW4gQBZspKMAn16m8/VaT3rfBaFveG2XhvL
 muSERVrCYDQXI+BaDxKCscu81gzdtG9DvSmIUrdhbpuXsA6rN2HE1eY8agwB+98uQIUwuD2iRyt
 flbfbn8VzFsCYQcIiC8gJ5hHmRKRhQuceFAyx2aazQ18K0av0jNLco4QHjBjMYdyJAI1X4f40gZ
 +F/9nSwQULlSpsAlYhxqzZLbAjZ+C46xZYZ7EFOAMNTNFq++dqyiLtS7xcjGdC3S2Pee5KITi+f
 feyOtLkaX4O+7jc7TCZBMPgFGpNp2j1Q0TIuyrLog+pprk8p6cA69UsUUkb8/14RQmk7TK88joS
 YiMb3QFKqzVtQR1pU=
X-Received: by 2002:a05:6000:25c3:b0:49d:7e8c:e8a2 with SMTP id
 ffacd0b85a97d-49d7e8cea6emr8804748f8f.33.1794669563664; 
 Sat, 14 Nov 2026 07:19:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm19020888f8f.7.2026.11.14.07.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 07:19:23 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 15:19:22 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3
X-Gerrit-Change-Number: 2168
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2168?usp=email>
X-Gerrit-Commit: e767bd21b00c017c1989177ef19637478bcaa879
In-Reply-To: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
References: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzIxNDQyMDAwLkkxYzg3ZmFlZmQzYWRjMmQ5NWI1MzE4NDM3ZDA5N2MzOTcwYTEyMGQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21eced14b930037ad281dac2716c96d27cd364f4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSFXO-000000008OD-3Dza
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6012078003614682036=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6012078003614682036==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cbt+NOckZg8="; charset=UTF-8

--cbt+NOckZg8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2168?usp=3Demail )

Change subject: console: Switch response_le=
n to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

c=
onsole: Switch response_len to size_t

We need some casts either way since =
the system
APIs are just too different=2E But overall it feels
cleaner when=
 using size_t=2E

Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2168
Message-Id: <20261110150027=2E17743-1-gert@greenie=2Emuc=2Ed=
e>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41097=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/conso=
le=2Ec
M src/openvpn/console=2Eh
M src/openvpn/console_builtin=2Ec
M src/op=
envpn/console_systemd=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
7 f=
iles changed, 20 insertions(+), 47 deletions(-)




diff --git a/src/openvp=
n/buffer=2Ec b/src/openvpn/buffer=2Ec
index e672b74=2E=2Ec60936a 100644
---=
 a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -576,9 +576,9 @@
=
  * like buf_null_terminate, but operate on strings
  */
 void
-string_null=
_terminate(char *str, int len, int capacity)
+string_null_terminate(char *s=
tr, size_t len, size_t capacity)
 {
-    ASSERT(len >=3D 0 && len <=3D capa=
city && capacity > 0);
+    ASSERT(len <=3D capacity && capacity > 0);
    =
 if (len < capacity)
     {
         *(str + len) =3D '\0';
diff --git a/sr=
c/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index ae6dcb7=2E=2E541f0bd 10=
0644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -872,7 +8=
72,7 @@
  * @param capacity  Total size of the character buffer in bytes=2E=

  */
 #ifdef _WIN32
-void string_null_terminate(char *str, int len, int ca=
pacity);
+void string_null_terminate(char *str, size_t len, size_t capacity=
);
 #endif
 /**@}*/
 /* End of string utility functions */
diff --git a/src=
/openvpn/console=2Ec b/src/openvpn/console=2Ec
index 78f445b=2E=2E358b9ae 1=
00644
--- a/src/openvpn/console=2Ec
+++ b/src/openvpn/console=2Ec
@@ -53,7 =
+53,7 @@
 
 
 void
-query_user_add(char *prompt, char *resp, int resp_len, =
bool echo)
+query_user_add(char *prompt, char *resp, size_t resp_len, bool =
echo)
 {
     int i;
 
diff --git a/src/openvpn/console=2Eh b/src/openvpn/c=
onsole=2Eh
index 89550ce=2E=2E94b1032 100644
--- a/src/openvpn/console=2Eh
=
+++ b/src/openvpn/console=2Eh
@@ -32,10 +32,10 @@
  */
 struct _query_user
=
 {
-    char *prompt;     /**< Prompt to present to the user */
-    char *=
response;   /**< The user's response */
-    int response_len; /**< Length =
the of the user response */
-    bool echo;        /**< True: The user shou=
ld see what is being typed, otherwise mask it */
+    char *prompt;        =
/**< Prompt to present to the user */
+    char *response;      /**< The us=
er's response */
+    size_t response_len; /**< Length the of the user resp=
onse */
+    bool echo;           /**< True: The user should see what is be=
ing typed, otherwise mask it */
 };
 
 #define QUERY_USER_NUMSLOTS 10
@@ -5=
7,7 +57,7 @@
  * @param echo       Should the user input be echoed to the u=
ser?  If False, input will be masked
  *
  */
-void query_user_add(char *pr=
ompt, char *resp, int resp_len, bool echo);
+void query_user_add(char *prom=
pt, char *resp, size_t resp_len, bool echo);
 
 
 /**
@@ -115,7 +115,7 @@
 =
 *
  */
 static inline bool
-query_user_SINGLE(char *prompt, char *resp, in=
t resp_len, bool echo)
+query_user_SINGLE(char *prompt, char *resp, size_t =
resp_len, bool echo)
 {
     query_user_clear();
     query_user_add(prompt=
, resp, resp_len, echo);
diff --git a/src/openvpn/console_builtin=2Ec b/src=
/openvpn/console_builtin=2Ec
index 0353ade=2E=2E8206d3d 100644
--- a/src/op=
envpn/console_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -41,11 +=
41,6 @@
 #include <termios=2Eh>
 #endif
 
-#if defined(__GNUC__) || defined=
(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-=
Wsign-conversion"
-#endif
-
 #ifdef _WIN32
 
 #include "win32=2Eh"
@@ -62,1=
1 +57,11 @@
  *         exit event is signaled=2E
  */
 static bool
-get_co=
nsole_input_win32(const char *prompt, const bool echo, char *input, const i=
nt capacity)
+get_console_input_win32(const char *prompt, const bool echo, =
char *input, const size_t capacity)
 {
     ASSERT(prompt);
     ASSERT(inp=
ut);
-    ASSERT(capacity > 0);
+    ASSERT(capacity > 0 && capacity < INT_=
MAX);
 
     input[0] =3D '\0';
 
@@ -110,16 +105,16 @@
             return=
 false;
         }
 
-        status =3D ReadConsoleW(in, winput, capacity,=
 &len, NULL);
-        WideCharToMultiByte(CP_UTF8, 0, winput, len, input, =
capacity, NULL, NULL);
+        status =3D ReadConsoleW(in, winput, (DWORD)=
capacity, &len, NULL);
+        WideCharToMultiByte(CP_UTF8, 0, winput, (in=
t)len, input, (int)capacity, NULL, NULL);
         free(winput);
     }
   =
  else
     {
-        status =3D ReadFile(in, input, capacity, &len, NULL)=
;
+        status =3D ReadFile(in, input, (DWORD)capacity, &len, NULL);
   =
  }
 
-    string_null_terminate(input, (int)len, capacity);
+    string_nu=
ll_terminate(input, len, capacity);
     chomp(input);
 
     if (!echo)
@@=
 -191,11 +186,11 @@
  *  @returns Returns True if user input was gathered
 =
 */
 static bool
-get_console_input(const char *prompt, const bool echo, ch=
ar *input, const int capacity)
+get_console_input(const char *prompt, const=
 bool echo, char *input, const size_t capacity)
 {
     ASSERT(prompt);
   =
  ASSERT(input);
-    ASSERT(capacity > 0);
+    ASSERT(capacity > 0 && cap=
acity <=3D INT_MAX);
     input[0] =3D '\0';
 
 #ifdef _WIN32
@@ -238,7 +23=
3,7 @@
         restore_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &tty_tmp)=
 =3D=3D 0);
     }
 
-    if (fgets(input, capacity, fp) !=3D NULL)
+    if=
 (fgets(input, (int)capacity, fp) !=3D NULL)
     {
         chomp(input);
=
         ret =3D true;
@@ -294,7 +289,3 @@
 
     return ret;
 }
-
-#if def=
ined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
di=
ff --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/console_systemd=2E=
c
index 8fc7f72=2E=2Ef0ca7fa 100644
--- a/src/openvpn/console_systemd=2Ec
+=
++ b/src/openvpn/console_systemd=2Ec
@@ -53,13 +53,8 @@
     return (sd_boo=
ted() > 0) && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) =3D=3D 0);
 }
 
-#if def=
ined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma =
GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static bool
-get_cons=
ole_input_systemd(const char *prompt, const bool echo, char *input, const i=
nt capacity)
+get_console_input_systemd(const char *prompt, const bool echo=
, char *input, const size_t capacity)
 {
     int std_out;
     bool ret =
=3D false;
@@ -91,10 +86,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) =
|| defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  *  Syste=
md aware implementation of query_user_exec()=2E  If systemd is not running
=
  *  it will fall back to use query_user_exec_builtin() instead=2E
diff --g=
it a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn=
/test_user_pass=2Ec
index 5bc1d2a=2E=2E54b3617 100644
--- a/tests/unit_test=
s/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/test_user_pass=
=2Ec
@@ -47,11 +47,6 @@
 }
 #endif
 
-#if defined(__GNUC__) || defined(__cl=
ang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign=
-conversion"
-#endif
-
 bool
 query_user_exec_builtin(void)
 {
@@ -65,10 +6=
0,6 @@
     return mock();
 }
 
-#if defined(__GNUC__) || defined(__clang__=
)
-#pragma GCC diagnostic pop
-#endif
-
 void
 management_auth_failure(cons=
t struct management *man, const char *type, const char *reason)
 {

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c87faefd3adc2d95b5318437d0=
97c3970a120d3
Gerrit-Change-Number: 2168
Gerrit-PatchSet: 4
Gerrit-Owner: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--cbt+NOckZg8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2168?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">console: Switch response_len to si=
ze_t<br><br>We need some casts either way since the system<br>APIs are just=
 too different=2E But overall it feels<br>cleaner when using size_t=2E<br><=
br>Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2168<br>Message-Id: &lt;20261110150027=2E17743-1-gert@green=
ie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg41097=2Ehtml<br>Signed-off-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/ope=
nvpn/buffer=2Eh<br>M src/openvpn/console=2Ec<br>M src/openvpn/console=2Eh<b=
r>M src/openvpn/console_builtin=2Ec<br>M src/openvpn/console_systemd=2Ec<br=
>M tests/unit_tests/openvpn/test_user_pass=2Ec<br>7 files changed, 20 inser=
tions(+), 47 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=
=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index e672b74=2E=2Ec60936a 10=
0644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src=
/openvpn/buffer=2Ec</span><br><span>@@ -576,9 +576,9 @@</span><br><span>  *=
 like buf_null_terminate, but operate on strings</span><br><span>  */</span=
><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-strin=
g_null_terminate(char *str, int len, int capacity)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+string_null_terminate(char *str, size_t len,=
 size_t capacity)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ASSERT(len &gt;=3D 0 &amp;&amp; len &lt;=3D capacity &am=
p;&amp; capacity &gt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(len &lt;=3D capacity &amp;&amp; capacity &gt; 0);</span><b=
r><span>     if (len &lt; capacity)</span><br><span>     {</span><br><span>=
         *(str + len) =3D &#39;\0&#39;;</span><br><span>diff --git a/src/op=
envpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index ae6dcb7=2E=
=2E541f0bd 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><s=
pan>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -872,7 +872,7 @@</span>=
<br><span>  * @param capacity  Total size of the character buffer in bytes=
=2E</span><br><span>  */</span><br><span> #ifdef _WIN32</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void string_null_terminate(char *str, int=
 len, int capacity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void string_null_terminate(char *str, size_t len, size_t capacity);</span>=
<br><span> #endif</span><br><span> /**@}*/</span><br><span> /* End of strin=
g utility functions */</span><br><span>diff --git a/src/openvpn/console=2Ec=
 b/src/openvpn/console=2Ec</span><br><span>index 78f445b=2E=2E358b9ae 10064=
4</span><br><span>--- a/src/openvpn/console=2Ec</span><br><span>+++ b/src/o=
penvpn/console=2Ec</span><br><span>@@ -53,7 +53,7 @@</span><br><span> </spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-query_user_add(char *prompt, char *resp, int resp_len, bool e=
cho)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+query_user_add(=
char *prompt, char *resp, size_t resp_len, bool echo)</span><br><span> {</s=
pan><br><span>     int i;</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/console=2Eh b/src/openvpn/console=2Eh</span><br><span>index 89550=
ce=2E=2E94b1032 100644</span><br><span>--- a/src/openvpn/console=2Eh</span>=
<br><span>+++ b/src/openvpn/console=2Eh</span><br><span>@@ -32,10 +32,10 @@=
</span><br><span>  */</span><br><span> struct _query_user</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *prompt;   =
  /**&lt; Prompt to present to the user */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    char *response;   /**&lt; The user&#39;s response =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int response_le=
n; /**&lt; Length the of the user response */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    bool echo;        /**&lt; True: The user should=
 see what is being typed, otherwise mask it */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    char *prompt;        /**&lt; Prompt to prese=
nt to the user */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  char *response;      /**&lt; The user&#39;s response */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    size_t response_len; /**&lt; Leng=
th the of the user response */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool echo;           /**&lt; True: The user should see what =
is being typed, otherwise mask it */</span><br><span> };</span><br><span> <=
/span><br><span> #define QUERY_USER_NUMSLOTS 10</span><br><span>@@ -57,7 +5=
7,7 @@</span><br><span>  * @param echo       Should the user input be echoe=
d to the user?  If False, input will be masked</span><br><span>  *</span><b=
r><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void quer=
y_user_add(char *prompt, char *resp, int resp_len, bool echo);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void query_user_add(char *prompt=
, char *resp, size_t resp_len, bool echo);</span><br><span> </span><br><spa=
n> </span><br><span> /**</span><br><span>@@ -115,7 +115,7 @@</span><br><spa=
n>  *</span><br><span>  */</span><br><span> static inline bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-query_user_SINGLE(char *prompt, ch=
ar *resp, int resp_len, bool echo)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+query_user_SINGLE(char *prompt, char *resp, size_t resp_len,=
 bool echo)</span><br><span> {</span><br><span>     query_user_clear();</sp=
an><br><span>     query_user_add(prompt, resp, resp_len, echo);</span><br><=
span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/console_bui=
ltin=2Ec</span><br><span>index 0353ade=2E=2E8206d3d 100644</span><br><span>=
--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/openvpn/con=
sole_builtin=2Ec</span><br><span>@@ -41,11 +41,6 @@</span><br><span> #inclu=
de &lt;termios=2Eh&gt;</span><br><span> #endif</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><span> </span=
><br><span> #include &quot;win32=2Eh&quot;</span><br><span>@@ -62,11 +57,11=
 @@</span><br><span>  *         exit event is signaled=2E</span><br><span> =
 */</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-get_console_input_win32(const char *prompt, const bool echo, cha=
r *input, const int capacity)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+get_console_input_win32(const char *prompt, const bool echo, char=
 *input, const size_t capacity)</span><br><span> {</span><br><span>     ASS=
ERT(prompt);</span><br><span>     ASSERT(input);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ASSERT(capacity &gt; 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(capacity &gt; 0 &amp;&amp; c=
apacity &lt; INT_MAX);</span><br><span> </span><br><span>     input[0] =3D =
&#39;\0&#39;;</span><br><span> </span><br><span>@@ -110,16 +105,16 @@</span=
><br><span>             return false;</span><br><span>         }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status=
 =3D ReadConsoleW(in, winput, capacity, &amp;len, NULL);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        WideCharToMultiByte(CP_UTF8, 0, =
winput, len, input, capacity, NULL, NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        status =3D ReadConsoleW(in, winput, (DWORD)c=
apacity, &amp;len, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        WideCharToMultiByte(CP_UTF8, 0, winput, (int)len, input, (int=
)capacity, NULL, NULL);</span><br><span>         free(winput);</span><br><s=
pan>     }</span><br><span>     else</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        status =3D ReadFile(in, input=
, capacity, &amp;len, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        status =3D ReadFile(in, input, (DWORD)capacity, &amp;len, =
NULL);</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    string_null_terminate(input, (int)len, capaci=
ty);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    string_null=
_terminate(input, len, capacity);</span><br><span>     chomp(input);</span>=
<br><span> </span><br><span>     if (!echo)</span><br><span>@@ -191,11 +186=
,11 @@</span><br><span>  *  @returns Returns True if user input was gathere=
d</span><br><span>  */</span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-get_console_input(const char *prompt, const=
 bool echo, char *input, const int capacity)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+get_console_input(const char *prompt, const bool e=
cho, char *input, const size_t capacity)</span><br><span> {</span><br><span=
>     ASSERT(prompt);</span><br><span>     ASSERT(input);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(capacity &gt; 0);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(capacity &gt; 0 &am=
p;&amp; capacity &lt;=3D INT_MAX);</span><br><span>     input[0] =3D &#39;\=
0&#39;;</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span>@@=
 -238,7 +233,7 @@</span><br><span>         restore_tty =3D (tcsetattr(filen=
o(fp), TCSAFLUSH, &amp;tty_tmp) =3D=3D 0);</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (fgets=
(input, capacity, fp) !=3D NULL)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (fgets(input, (int)capacity, fp) !=3D NULL)</span><br><=
span>     {</span><br><span>         chomp(input);</span><br><span>        =
 ret =3D true;</span><br><span>@@ -294,7 +289,3 @@</span><br><span> </span>=
<br><span>     return ret;</span><br><span> }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>diff --git a/src/ope=
nvpn/console_systemd=2Ec b/src/openvpn/console_systemd=2Ec</span><br><span>=
index 8fc7f72=2E=2Ef0ca7fa 100644</span><br><span>--- a/src/openvpn/console=
_systemd=2Ec</span><br><span>+++ b/src/openvpn/console_systemd=2Ec</span><b=
r><span>@@ -53,13 +53,8 @@</span><br><span>     return (sd_booted() &gt; 0)=
 &amp;&amp; (stat(SYSTEMD_ASK_PASSWORD_PATH, &amp;c) =3D=3D 0);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign=
-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> s=
tatic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_console=
_input_systemd(const char *prompt, const bool echo, char *input, const int =
capacity)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_consol=
e_input_systemd(const char *prompt, const bool echo, char *input, const siz=
e_t capacity)</span><br><span> {</span><br><span>     int std_out;</span><b=
r><span>     bool ret =3D false;</span><br><span>@@ -91,10 +86,6 @@</span><=
br><span>     return ret;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**<=
/span><br><span>  *  Systemd aware implementation of query_user_exec()=2E  =
If systemd is not running</span><br><span>  *  it will fall back to use que=
ry_user_exec_builtin() instead=2E</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=
=2Ec</span><br><span>index 5bc1d2a=2E=2E54b3617 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_user_pass=2Ec</span><br><span>@@ -47,11 +47,6 @@</sp=
an><br><span> }</span><br><span> #endif</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> bool</span><br><span> query_user_exec_builti=
n(void)</span><br><span> {</span><br><span>@@ -65,10 +60,6 @@</span><br><sp=
an>     return mock();</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</s=
pan><br><span> management_auth_failure(const struct management *man, const =
char *type, const char *reason)</span><br><span> {</span><br></pre><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3D=
email">change 2168</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2168?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2168 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--cbt+NOckZg8=--


--===============6012078003614682036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6012078003614682036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6012078003614682036==--

