Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97A606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=B2lNkRbG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YuGeBz8z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jTtQXEb6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=P/j4G2VE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=U16bvhKO21bwFwhumIXLJsr3rDals5xQ4M+KKJcajKQ=; b=B2lNkRbGJZTc/kCjJjh6x7PAPE
	DrudvzJjdurZyDsjRRfLN8ac78u3QB6gPV17E04aSqkcS9sFqtGCAqcRJ5aN6hXcjgzziKPJEjsWg
	cDwHnjp7mn/dI8ThyQ+1mogEqo1mf1eOVfEYPvqTbR1UBt1AjQoQbVB7wHZj9NgwaaO4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKWv-000000007eJ-3dvL;
	Tue, 17 Nov 2026 14:51:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKWt-000000007dn-00tB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+MU6aG5XIhMUO0Kd8oqUPfM/BtCO3fM2fb5JeIipd8c=; b=YuGeBz8zZqp9+QgBrHQB78kj0g
 82y6s0WAqzh1L5qZcJBtrcHim1WRSng/3O+XsdtWWAD424PWHVnmwNIz7xJCWuQcRpQccrjvkMH84
 60MQawY97QEUGTMbrqc7/8ipPTEhl2oTyb1WekzHBxLPGMmL8rRgSY6Xph5KkJkn9U48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+MU6aG5XIhMUO0Kd8oqUPfM/BtCO3fM2fb5JeIipd8c=; b=jTtQXEb6q/eUcKBJCgE5xSuVJ9
 i1yT8lcgk8cSYWbFwxQz6bM2oVcOlgRGZ3+q9YONEXDS522Ez+erJhX/wcNDMicJItsgksO3Qt+fU
 1ANUKoGY1QR3BESi5c4ofqouh9OOWRMMxiuWRuv06o3bbYxYItijYznD0zvyqYAR/zgw=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKWP-000000000Yz-2Ith for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:51:00 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so35675475e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794927051; x=1795531851; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+MU6aG5XIhMUO0Kd8oqUPfM/BtCO3fM2fb5JeIipd8c=;
 b=P/j4G2VE4hvvCH2VT6XXK7G90AKLEf1Ttxd0v7mVuDZpYGzfYS6Y63Kj+f7hNIuIgr
 NTOWtWmuTm1AvMU5s8QcAei+tvVUyPk6Gu4+TFu5egbXYtrhrDUZjc3ztv7byLe04dSQ
 8kkp28uvO+dT4JFDdxUGXbhIhrQP5o5cYaa+Aan+f6/SsD7mGiP7uOq5fHOAy4BeXoWE
 XbNQQcmY3bfXITIsQdZ1Obpx/ZxldlqHuu/a6341Hd82nt1uFgE5LtxQwFYSLoayo2FX
 l49ctYcAV8sHGfX0HzeozJsAnnA0qyFLyMYdoIU4i+hvis+BdBjAbNXz1u8ioCChxgiW
 WBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927051; x=1795531851;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+MU6aG5XIhMUO0Kd8oqUPfM/BtCO3fM2fb5JeIipd8c=;
 b=pYabCP6NbOq99sPXoR4pR7Qqlzr6P+XkQZ8+4Ecu7JTpJV+lAmRRMsuXiN1urkdC2S
 uQTk1+M2empPUMmzO3CfP0mRWE9F/8bdj9/Ct97oZp1PepeBOZGlEGEo28/VwsRH8QiV
 n6sBsOkC8IwMcU5o/DmZi67hDBxpbebS/6f3lUuVZxGdEe9xaex2HNpulgahHOAmfFdj
 0eAh+ueaFhIgnCm4d9x0Gxgnqnh5Fw2orQYf0Pt4uLC8k/JUbHTLZ3R5qNPWBSpnDk0E
 2OFaw47RXGulg1G9sWHeYiJ0bn0Yk86V7vKSt9IUeax6yA0+sm/rM+7Rz2KOL15fAGF8
 L6VA==
X-Gm-Message-State: APuU4Z+U3OdZvUGpuI8hxCrP23ovIjKnynNZS/s133Y/8Wv0glJbaglT
 rfSZ+pqVIN2vb20wp3kX38VfmLrlPT+fnY3vg1vGZDaZpTSuMrM776T7oiFZrYNm5rRQ0RBvn7Y
 xmbbHfE+ZyO4+GBTMPH4Dm1UTYL0/+YSObUQvBkmFOjDGB/IF+ExGLjacmOiAS4ffzuDm
X-Gm-Gg: AYBFou11/BPHjVuC/QPtNwoXTZc4ZKO6iFXZaymvDd+usZcCJkCFJzaDaem70NUfm13
 zFK3Gx3DKvzuoH20tTbbLsyqUyfG8jUr73x6o1ETttgsyzqylt2rE4YILnkYub6T8qHB1Et62Pw
 bjrfK92OqSwPRcM1ZZrJSHVFFlDNQwHDFy5A5dO0n5pI2miLqw0J2dsew2KXvM+xyJSqVgc1/Zx
 ax8kNQi79XRWUEB+dMLxGdlC6JlC/yZ0PM/qvH6gYfHP9VPf2kdIOjswWkMeDr+ydPPnLxy6SQD
 Z3VUtTI1s8W42+aQbauDckkuGSkVyhwwFAkhQpiwME0k93X354fqxjRTXEnCj1loquropQ+kCXk
 c8cQUIqET4BTs0ekT2Ydc9fEo2fdZwvMDf1dK/ucLzoIsWJ3lEweKH5fq04/xjFGxzN4ZAq4TQm
 UdOtzqRkg8QG+AbCcyW6fTEcuEubdh+4aCrUV7iB3wXMkG+HUT4OtY6+tuPzsTCKJ38r0O3dtM6
 gJSq3QLatTPa8R3NrItHgOlngOL2vFFEIUsgqJYealS1ssiNd4JZm9XHJiVjCMt8CPA8sbBey0i
 SWdC2ANKn8LUa04Bk7T+gZFuYmKpw25v7VcrkibiJXQ7w26sKeUHCsEPF8qkd6MGhoJfZlJxy++
 6LGMbmMndLQH2Fusb8TV9DQDxIogQwbsrxhCKd/FLtWnwhGRM4FJq6+lvsYGDo/6IzAmEbNSVLD
 aMHovCyYcendRWouQ=
X-Received: by 2002:a05:600c:6090:b0:4bb:6752:8413 with SMTP id
 5b1f17b1804b1-4bb67528699mr199414615e9.8.1794927050607; 
 Tue, 17 Nov 2026 06:50:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783965b8sm71772925e9.8.2026.11.17.06.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:50:50 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:50:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8
X-Gerrit-Change-Number: 2203
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2203?usp=email>
X-Gerrit-Commit: f07e67b526a76e9343beb2bb248844443692b769
In-Reply-To: <gerrit.1794854317000.Ice2151259fcaa256d7aee588bc3d68c835ea9eb8@gerrit.openvpn.net>
References: <gerrit.1794854317000.Ice2151259fcaa256d7aee588bc3d68c835ea9eb8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODU0MzE3MDAwLkljZTIxNTEyNTlmY2FhMjU2ZDdhZWU1ODhiYzNkNjhjODM1ZWE5ZWI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe5d0dedcd4137d3691c2c1eb11a9f755e3784eb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTKWP-000000000Yz-2Ith
Subject: [Openvpn-devel] [M] Change in openvpn[master]: proxy: drop
 always-on PROXY_DIGEST_AUTH guards
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5399642020527743929=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5399642020527743929==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bG0yfmOqkUw="; charset=UTF-8

--bG0yfmOqkUw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2203?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: proxy: drop always-on PRO=
XY_DIGEST_AUTH guards
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

proxy: drop always-on PROXY_DIGEST_AUTH guards

PROXY_DIGEST_AUT=
H is unconditionally defined to 1=2E Remove it and its
#if blocks=2E In the=
 digest branch of establish_http_proxy_passthru(),
also drop the re-check o=
f auth_method =3D=3D HTTP_AUTH_DIGEST, which the
enclosing condition alread=
y guarantees, and its dead else=2E

Change-Id: Ice2151259fcaa256d7aee588bc3=
d68c835ea9eb8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-=
by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2203
Message-Id: <20261116190900=2E2482-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg41494=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/httpdigest=2Ec
M src/openvpn/httpdigest=2Eh
=
M src/openvpn/proxy=2Ec
M src/openvpn/syshead=2Eh
4 files changed, 93 inser=
tions(+), 121 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/03/2203/3

diff --git a/src/openvpn/httpdigest=2Ec b/s=
rc/openvpn/httpdigest=2Ec
index 9bfa074=2E=2Ea6803e9 100644
--- a/src/openv=
pn/httpdigest=2Ec
+++ b/src/openvpn/httpdigest=2Ec
@@ -26,8 +26,6 @@
 
 #in=
clude "syshead=2Eh"
 
-#if PROXY_DIGEST_AUTH
-
 #include "crypto=2Eh"
 #inc=
lude "httpdigest=2Eh"
 
@@ -141,5 +139,3 @@
     md_ctx_free(md5_ctx);
    =
 CvtHex(RespHash, Response);
 }
-
-#endif /* if PROXY_DIGEST_AUTH */
diff -=
-git a/src/openvpn/httpdigest=2Eh b/src/openvpn/httpdigest=2Eh
index 37f3d9=
8=2E=2E20db1c4 100644
--- a/src/openvpn/httpdigest=2Eh
+++ b/src/openvpn/ht=
tpdigest=2Eh
@@ -20,8 +20,6 @@
  *  with this program; if not, see <https:/=
/www=2Egnu=2Eorg/licenses/>=2E
  */
 
-#if PROXY_DIGEST_AUTH
-
 #define HAS=
HLEN 16
 typedef unsigned char HASH[HASHLEN];
 #define HASHHEXLEN 32
@@ -42=
,5 +40,3 @@
                         const HASHHEX HEntity,     /* H(entity=
 body) if qop=3D"auth-int" */
                         HASHHEX Response    =
       /* request-digest or response-digest */
 );
-
-#endif /* if PROXY_DI=
GEST_AUTH */
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
ind=
ex cd9f3b2=2E=2E437733e 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvp=
n/proxy=2Ec
@@ -348,14 +348,12 @@
                 *data =3D string_alloc(b=
uf + 26, NULL);
                 ret =3D HTTP_AUTH_BASIC;
             }
-#=
if PROXY_DIGEST_AUTH
             else if (!strncmp(buf + 20, "Digest ", 7)=
)
             {
                 msg(D_PROXY, "PROXY AUTH DIGEST: '%s'", b=
uf);
                 *data =3D string_alloc(buf + 27, NULL);
             =
    ret =3D HTTP_AUTH_DIGEST;
             }
-#endif
         }
     }
 }
@=
@ -714,121 +712,108 @@
         {
             processed =3D true;
        =
 }
-#if PROXY_DIGEST_AUTH
         else if (p->auth_method =3D=3D HTTP_AUTH=
_DIGEST && !processed)
         {
             const char *pa =3D p->proxy_=
authenticate;
-            const int method =3D p->auth_method;
           =
  ASSERT(pa);
 
-            if (method =3D=3D HTTP_AUTH_DIGEST)
+         =
   const char *http_method =3D "CONNECT";
+            const char *nonce_co=
unt =3D "00000001";
+            const char *qop =3D "auth";
+            c=
onst char *username =3D p->up=2Eusername;
+            const char *password=
 =3D p->up=2Epassword;
+            char *opaque_kv =3D "";
+            ch=
ar uri[128];
+            uint8_t cnonce_raw[8];
+            HASHHEX sessi=
on_key;
+            HASHHEX response;
+
+            const char *realm =3D=
 get_pa_var("realm", pa, &gc);
+            const char *nonce =3D get_pa_va=
r("nonce", pa, &gc);
+            const char *algor =3D get_pa_var("algorit=
hm", pa, &gc);
+            const char *opaque =3D get_pa_var("opaque", pa,=
 &gc);
+
+            if (!realm || !nonce)
             {
-               =
 const char *http_method =3D "CONNECT";
-                const char *nonce_=
count =3D "00000001";
-                const char *qop =3D "auth";
-       =
         const char *username =3D p->up=2Eusername;
-                const =
char *password =3D p->up=2Epassword;
-                char *opaque_kv =3D "=
";
-                char uri[128];
-                uint8_t cnonce_raw[8];
=
-                uint8_t *cnonce;
-                HASHHEX session_key;
-  =
              HASHHEX response;
-
-                const char *realm =3D ge=
t_pa_var("realm", pa, &gc);
-                const char *nonce =3D get_pa_v=
ar("nonce", pa, &gc);
-                const char *algor =3D get_pa_var("al=
gorithm", pa, &gc);
-                const char *opaque =3D get_pa_var("opa=
que", pa, &gc);
-
-                if (!realm || !nonce)
-                {=

-                    msg(D_LINK_ERRORS, "HTTP proxy: digest auth failed, m=
alformed response "
-                                       "from server: r=
ealm=3D or nonce=3D missing");
-                    goto error;
-          =
      }
-
-                /* generate a client nonce */
-                p=
rng_bytes(cnonce_raw, sizeof(cnonce_raw));
-                cnonce =3D make=
_base64_string2(cnonce_raw, sizeof(cnonce_raw), &gc);
-
-
-                =
/* build the digest response */
-                snprintf(uri, sizeof(uri),=
 "%s:%s", host, port);
-
-                if (opaque)
-                {
- =
                   const size_t len =3D strlen(opaque) + 16;
-             =
       opaque_kv =3D gc_malloc(len, false, &gc);
-                    snpri=
ntf(opaque_kv, len, ", opaque=3D\"%s\"", opaque);
-                }
-
-   =
             DigestCalcHA1(algor, username, realm, password, nonce, (char *=
)cnonce, session_key);
-                DigestCalcResponse(session_key, non=
ce, nonce_count, (char *)cnonce, qop,
-                                   h=
ttp_method, uri, NULL, response);
-
-                /* format HTTP CONNECT=
 message */
-                snprintf(buf, sizeof(buf), "%s %s HTTP/%s", ht=
tp_method, uri,
-                         p->options=2Ehttp_version);
-
-  =
              msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
-
-           =
     /* send HTTP CONNECT message to proxy */
-                if (!send_li=
ne_crlf(sd, buf))
-                {
-                    goto error;
-    =
            }
-
-                /* send HOST etc, */
-                if (=
!add_proxy_headers(p, sd, host))
-                {
-                    go=
to error;
-                }
-
-                /* send digest response */
=
-                if (!checked_snprintf(
-                        buf, sizeo=
f(buf),
-                        "Proxy-Authorization: Digest username=3D\"=
%s\", realm=3D\"%s\", nonce=3D\"%s\", uri=3D\"%s\", qop=3D%s, nc=3D%s, cnon=
ce=3D\"%s\", response=3D\"%s\"%s",
-                        username, realm=
, nonce, uri, qop, nonce_count, cnonce, response, opaque_kv))
-            =
    {
-                    goto error;
-                }
-
-              =
  msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
-                if (!send=
_line_crlf(sd, buf))
-                {
-                    goto error;
- =
               }
-                if (!send_crlf(sd))
-                {
- =
                   goto error;
-                }
-                /* clear=
 any sensitive content in buf */
-                secure_memzero(buf, sizeo=
f(buf));
-
-                /* receive reply from proxy */
-               =
 if (!recv_line(sd, buf, sizeof(buf),
-                               get_s=
erver_poll_remaining_time(server_poll_timeout), true, NULL,
-              =
                 signal_received))
-                {
-                    =
goto error;
-                }
-
-                /* remove trailing CR, LF=
 */
-                chomp(buf);
-
-                msg(D_PROXY, "HTTP prox=
y returned: '%s'", buf);
-
-                /* parse return string */
-    =
            nparms =3D sscanf(buf, "%*s %d", &status);
-                pro=
cessed =3D true;
-            }
-            else
-            {
-         =
       msg(D_PROXY, "HTTP proxy: digest method not supported");
+          =
      msg(D_LINK_ERRORS, "HTTP proxy: digest auth failed, malformed respons=
e "
+                                   "from server: realm=3D or nonce=3D =
missing");
                 goto error;
             }
+
+            /* ge=
nerate a client nonce */
+            prng_bytes(cnonce_raw, sizeof(cnonce_=
raw));
+            uint8_t *cnonce =3D make_base64_string2(cnonce_raw, siz=
eof(cnonce_raw), &gc);
+
+            /* build the digest response */
+    =
        snprintf(uri, sizeof(uri), "%s:%s", host, port);
+
+            if =
(opaque)
+            {
+                const size_t len =3D strlen(opaque=
) + 16;
+                opaque_kv =3D gc_malloc(len, false, &gc);
+       =
         snprintf(opaque_kv, len, ", opaque=3D\"%s\"", opaque);
+          =
  }
+
+            DigestCalcHA1(algor, username, realm, password, nonce, (=
char *)cnonce, session_key);
+            DigestCalcResponse(session_key, n=
once, nonce_count, (char *)cnonce, qop,
+                               htt=
p_method, uri, NULL, response);
+
+            /* format HTTP CONNECT messa=
ge */
+            snprintf(buf, sizeof(buf), "%s %s HTTP/%s", http_method,=
 uri,
+                     p->options=2Ehttp_version);
+
+            msg(=
D_PROXY, "Send to HTTP proxy: '%s'", buf);
+
+            /* send HTTP CONN=
ECT message to proxy */
+            if (!send_line_crlf(sd, buf))
+       =
     {
+                goto error;
+            }
+
+            /* send H=
OST etc, */
+            if (!add_proxy_headers(p, sd, host))
+            =
{
+                goto error;
+            }
+
+            /* send digest=
 response */
+            if (!checked_snprintf(
+                    buf, =
sizeof(buf),
+                    "Proxy-Authorization: Digest username=3D\=
"%s\", realm=3D\"%s\", nonce=3D\"%s\", uri=3D\"%s\", qop=3D%s, nc=3D%s, cno=
nce=3D\"%s\", response=3D\"%s\"%s",
+                    username, realm, n=
once, uri, qop, nonce_count, cnonce, response, opaque_kv))
+            {
+=
                goto error;
+            }
+
+            msg(D_PROXY, "Sen=
d to HTTP proxy: '%s'", buf);
+            if (!send_line_crlf(sd, buf))
+ =
           {
+                goto error;
+            }
+            if (!=
send_crlf(sd))
+            {
+                goto error;
+            }
+=
            /* clear any sensitive content in buf */
+            secure_me=
mzero(buf, sizeof(buf));
+
+            /* receive reply from proxy */
+   =
         if (!recv_line(sd, buf, sizeof(buf),
+                           g=
et_server_poll_remaining_time(server_poll_timeout), true, NULL,
+          =
                 signal_received))
+            {
+                goto err=
or;
+            }
+
+            /* remove trailing CR, LF */
+           =
 chomp(buf);
+
+            msg(D_PROXY, "HTTP proxy returned: '%s'", buf);=

+
+            /* parse return string */
+            nparms =3D sscanf(bu=
f, "%*s %d", &status);
+            processed =3D true;
         }
-#endif =
/* if PROXY_DIGEST_AUTH */
         else if (p->options=2Eauth_retry)
     =
    {
             /* figure out what kind of authentication the proxy need=
s */
diff --git a/src/openvpn/syshead=2Eh b/src/openvpn/syshead=2Eh
index 6=
5baee3=2E=2E8f27436 100644
--- a/src/openvpn/syshead=2Eh
+++ b/src/openvpn/=
syshead=2Eh
@@ -480,11 +480,6 @@
 #endif
 
 /*
- * Should we include proxy =
digest auth functionality
- */
-#define PROXY_DIGEST_AUTH 1
-
-/*
  * Do we=
 have CryptoAPI capability?
  */
 #if defined(_WIN32) && defined(ENABLE_CRY=
PTO_OPENSSL) && !defined(ENABLE_CRYPTO_WOLFSSL)

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8
=
Gerrit-Change-Number: 2203
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--bG0yfmOqkUw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2203?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">pro=
xy: drop always-on PROXY_DIGEST_AUTH guards<br><br>PROXY_DIGEST_AUTH is unc=
onditionally defined to 1=2E Remove it and its<br>#if blocks=2E In the dige=
st branch of establish_http_proxy_passthru(),<br>also drop the re-check of =
auth_method =3D=3D HTTP_AUTH_DIGEST, which the<br>enclosing condition alrea=
dy guarantees, and its dead else=2E<br><br>Change-Id: Ice2151259fcaa256d7ae=
e588bc3d68c835ea9eb8<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203<br>Message-Id: &lt=
;20261116190900=2E2482-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41494=2Ehtml<=
br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =
src/openvpn/httpdigest=2Ec<br>M src/openvpn/httpdigest=2Eh<br>M src/openvpn=
/proxy=2Ec<br>M src/openvpn/syshead=2Eh<br>4 files changed, 93 insertions(+=
), 121 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/03/2203/3</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/httpdigest=2Ec b/src/openvpn/httpdigest=2Ec</span><br><span>index 9bfa=
074=2E=2Ea6803e9 100644</span><br><span>--- a/src/openvpn/httpdigest=2Ec</s=
pan><br><span>+++ b/src/openvpn/httpdigest=2Ec</span><br><span>@@ -26,8 +26=
,6 @@</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if P=
ROXY_DIGEST_AUTH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #include &quo=
t;httpdigest=2Eh&quot;</span><br><span> </span><br><span>@@ -141,5 +139,3 @=
@</span><br><span>     md_ctx_free(md5_ctx);</span><br><span>     CvtHex(Re=
spHash, Response);</span><br><span> }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f /* if PROXY_DIGEST_AUTH */</span><br><span>diff --git a/src/openvpn/httpd=
igest=2Eh b/src/openvpn/httpdigest=2Eh</span><br><span>index 37f3d98=2E=2E2=
0db1c4 100644</span><br><span>--- a/src/openvpn/httpdigest=2Eh</span><br><s=
pan>+++ b/src/openvpn/httpdigest=2Eh</span><br><span>@@ -20,8 +20,6 @@</spa=
n><br><span>  *  with this program; if not, see &lt;https://www=2Egnu=2Eorg=
/licenses/&gt;=2E</span><br><span>  */</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if PROXY_DIGEST_AUTH</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define HASHLEN 16</sp=
an><br><span> typedef unsigned char HASH[HASHLEN];</span><br><span> #define=
 HASHHEXLEN 32</span><br><span>@@ -42,5 +40,3 @@</span><br><span>          =
               const HASHHEX HEntity,     /* H(entity body) if qop=3D&quot;=
auth-int&quot; */</span><br><span>                         HASHHEX Response=
           /* request-digest or response-digest */</span><br><span> );</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* if PROXY_DIGEST_AUTH */</span><br><sp=
an>diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><sp=
an>index cd9f3b2=2E=2E437733e 100644</span><br><span>--- a/src/openvpn/prox=
y=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -348,1=
4 +348,12 @@</span><br><span>                 *data =3D string_alloc(buf + =
26, NULL);</span><br><span>                 ret =3D HTTP_AUTH_BASIC;</span>=
<br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if PROXY_DIGEST_AUTH</span><br><span>             else if (!strncmp(buf=
 + 20, &quot;Digest &quot;, 7))</span><br><span>             {</span><br><s=
pan>                 msg(D_PROXY, &quot;PROXY AUTH DIGEST: &#39;%s&#39;&quo=
t;, buf);</span><br><span>                 *data =3D string_alloc(buf + 27,=
 NULL);</span><br><span>                 ret =3D HTTP_AUTH_DIGEST;</span><b=
r><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span>         }</span><br><span>     }</span><br><span> =
}</span><br><span>@@ -714,121 +712,108 @@</span><br><span>         {</span>=
<br><span>             processed =3D true;</span><br><span>         }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if PROXY_DIGEST_AUTH</span=
><br><span>         else if (p-&gt;auth_method =3D=3D HTTP_AUTH_DIGEST &amp=
;&amp; !processed)</span><br><span>         {</span><br><span>             =
const char *pa =3D p-&gt;proxy_authenticate;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            const int method =3D p-&gt;auth_method;<=
/span><br><span>             ASSERT(pa);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (method =3D=3D HTTP_AUT=
H_DIGEST)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  const char *http_method =3D &quot;CONNECT&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            const char *nonce_count =3D &quo=
t;00000001&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          const char *qop =3D &quot;auth&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            const char *username =3D p-&gt;up=
=2Eusername;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     const char *password =3D p-&gt;up=2Epassword;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            char *opaque_kv =3D &quot;&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            char u=
ri[128];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 uint8_t cnonce_raw[8];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            HASHHEX session_key;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            HASHHEX response;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            const char *realm =3D get_pa_var(&quot;realm&quot;, pa,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   const char *nonce =3D get_pa_var(&quot;nonce&quot;, pa, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            const char *al=
gor =3D get_pa_var(&quot;algorithm&quot;, pa, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            const char *opaque =3D get_=
pa_var(&quot;opaque&quot;, pa, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (!realm || !nonce)</span><br><span>             {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                const char *ht=
tp_method =3D &quot;CONNECT&quot;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                const char *nonce_count =3D &quot;00000001&quo=
t;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                co=
nst char *qop =3D &quot;auth&quot;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                const char *username =3D p-&gt;up=2Eusername;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                const=
 char *password =3D p-&gt;up=2Epassword;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                char *opaque_kv =3D &quot;&quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                char uri[128=
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                uin=
t8_t cnonce_raw[8];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              uint8_t *cnonce;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                HASHHEX session_key;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                HASHHEX response;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                const char *realm =3D get_pa_var(&quot;realm=
&quot;, pa, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                const char *nonce =3D get_pa_var(&quot;nonce&quot;, pa, &am=
p;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 const char *algor =3D get_pa_var(&quot;algorithm&quot;, pa, &amp;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                const char=
 *opaque =3D get_pa_var(&quot;opaque&quot;, pa, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                if (!realm || !nonce)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    msg(D_LINK_ERRORS, &quot;HT=
TP proxy: digest auth failed, malformed response &quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                       &q=
uot;from server: realm=3D or nonce=3D missing&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    goto error;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                /* generate a client nonce */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                prng_bytes(cnonce_=
raw, sizeof(cnonce_raw));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                cnonce =3D make_base64_string2(cnonce_raw, sizeof(cnonc=
e_raw), &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                /* build the digest response *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                snpr=
intf(uri, sizeof(uri), &quot;%s:%s&quot;, host, port);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                if (opaque)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    const size_t len =3D strlen(opaque) + 16;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    o=
paque_kv =3D gc_malloc(len, false, &amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    snprintf(opaque_kv, len, &quot;,=
 opaque=3D\&quot;%s\&quot;&quot;, opaque);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            DigestCalcHA1(algor, username, realm, password, nonce, (char *)=
cnonce, session_key);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                DigestCalcResponse(session_key, nonce, nonce_count, (char *=
)cnonce, qop,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                           http_method, uri, NULL, response);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                /* format HTTP CONNECT message */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                snprintf(buf=
, sizeof(buf), &quot;%s %s HTTP/%s&quot;, http_method, uri,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                         p-&gt;option=
s=2Ehttp_version);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_PR=
OXY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                /* send HTTP CONNECT message to proxy */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!send_=
line_crlf(sd, buf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* se=
nd HOST etc, */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          if (!add_proxy_headers(p, sd, host))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    goto error;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                /* send digest response */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                if (!checked_snprintf(</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        buf, s=
izeof(buf),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              &quot;Proxy-Authorization: Digest username=3D\&quot;%s\&quot;=
, realm=3D\&quot;%s\&quot;, nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot=
;, qop=3D%s, nc=3D%s, cnonce=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quot=
;%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             username, realm, nonce, uri, qop, nonce_count, cnonce, respons=
e, opaque_kv))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_PROX=
Y, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                if (!send_line_crlf(sd, bu=
f))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    go=
to error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
if (!send_crlf(sd))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                /* clear any sensitive content in buf */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                secure_memzero(buf, size=
of(buf));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                /* receive reply =
from proxy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        if (!recv_line(sd, buf, sizeof(buf),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                               get_server_poll_remai=
ning_time(server_poll_timeout), true, NULL,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                               signal_received))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    goto error=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                /* remove trailing CR, LF *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                chom=
p(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                msg(D_PROXY, &quot;=
HTTP proxy returned: &#39;%s&#39;&quot;, buf);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                /* parse return string */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                nparms =3D sscanf(buf, &quot;%*s %d=
&quot;, &amp;status);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                processed =3D true;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         msg(D_PROXY, &quot;HTTP proxy: digest method not supported&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg=
(D_LINK_ERRORS, &quot;HTTP proxy: digest auth failed, malformed response &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                    &quot;from server: realm=3D or nonce=3D missing&quot;);=
</span><br><span>                 goto error;</span><br><span>             =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* generate a client nonc=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            prn=
g_bytes(cnonce_raw, sizeof(cnonce_raw));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            uint8_t *cnonce =3D make_base64_string2(cn=
once_raw, sizeof(cnonce_raw), &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* build the digest response */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            snprintf(uri, sizeof(uri), &quot;%s:%s=
&quot;, host, port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (op=
aque)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cons=
t size_t len =3D strlen(opaque) + 16;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                opaque_kv =3D gc_malloc(len, false, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 snprintf(opaque_kv, len, &quot;, opaque=3D\&quot;%s\&quot;&quot;, opaque);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            DigestCalcHA1(algor, username, r=
ealm, password, nonce, (char *)cnonce, session_key);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            DigestCalcResponse(session_ke=
y, nonce, nonce_count, (char *)cnonce, qop,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                               http_method, uri, NU=
LL, response);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* format HT=
TP CONNECT message */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            snprintf(buf, sizeof(buf), &quot;%s %s HTTP/%s&quot;, http_me=
thod, uri,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            p-&gt;options=2Ehttp_version);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, =
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* send HTTP CONNECT =
message to proxy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (!send_line_crlf(sd, buf))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                goto error;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           /* send HOST etc, */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!add_proxy_headers(p, sd, host))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                goto error;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            /* send digest response */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (!checked_snprintf(</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    buf=
, sizeof(buf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               &quot;Proxy-Authorization: Digest username=3D\&quot;%s\&quot=
;, realm=3D\&quot;%s\&quot;, nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quo=
t;, qop=3D%s, nc=3D%s, cnonce=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quo=
t;%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            username, realm, nonce, uri, qop, nonce_count, cnonce, response=
, opaque_kv))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PROXY, &quo=
t;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (!send_line_crlf(sd, buf))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                goto error;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (!send_crlf(sd=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto er=
ror;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* clear =
any sensitive content in buf */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            secure_memzero(buf, sizeof(buf));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            /* receive reply from proxy */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (!recv_line(sd, bu=
f, sizeof(buf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                       get_server_poll_remaining_time(server_poll_timeout),=
 true, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                    signal_received))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                goto error;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* remove trailing CR, LF */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            chomp(buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_PROXY, &quot;HTTP proxy returned: &#39;%s&#39;&quot;, bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /* parse return string =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            nparm=
s =3D sscanf(buf, &quot;%*s %d&quot;, &amp;status);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            processed =3D true;</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* if PROXY_DIGEST_AUTH */</span><br><span>         else if (p-&gt;optio=
ns=2Eauth_retry)</span><br><span>         {</span><br><span>             /*=
 figure out what kind of authentication the proxy needs */</span><br><span>=
diff --git a/src/openvpn/syshead=2Eh b/src/openvpn/syshead=2Eh</span><br><s=
pan>index 65baee3=2E=2E8f27436 100644</span><br><span>--- a/src/openvpn/sys=
head=2Eh</span><br><span>+++ b/src/openvpn/syshead=2Eh</span><br><span>@@ -=
480,11 +480,6 @@</span><br><span> #endif</span><br><span> </span><br><span>=
 /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Should we inclu=
de proxy digest auth functionality</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne PROXY_DIGEST_AUTH 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span> =
 * Do we have CryptoAPI capability?</span><br><span>  */</span><br><span> #=
if defined(_WIN32) &amp;&amp; defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; !de=
fined(ENABLE_CRYPTO_WOLFSSL)</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=3Demail">change 2203</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic=
e2151259fcaa256d7aee588bc3d68c835ea9eb8 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2203 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;=
openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--bG0yfmOqkUw=--


--===============5399642020527743929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5399642020527743929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5399642020527743929==--

