Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4199CD4851
	for <openvpn-devel@archiver.kernel.org>; Sat, 16 May 2026 20:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:Cc:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=F840OPZcrdi7t+ZHiOMKopZrxcmrdhX5OaG6NR2gMSY=; b=KEwq9Rgibt5ft0
	FlRYeCF0ejFbwFNUjnbfpzC7wxn33gClILJMkMNDqZeYLuxvwRoc3PbTvSdfN/eDlUsBZYnmIb2aO
	TqAQBW/LWW4BcfhJcpbItK3hVWBi/v2k7r2ye83odfrKezEsbrNnFjodrRqfqep2r9rOJj17Etpa0
	pps=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOLbe-00021A-2D;
	Sat, 16 May 2026 20:27:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wOLbc-00020w-OV
 for openvpn-devel@lists.sourceforge.net;
 Sat, 16 May 2026 20:27:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WIw+inTt7evzgv8gfyD7YA6hh4z8gHWZ7xDh2JPdqXs=; b=KOzh6ukGLcQ5fR0UtbOMHXb9nk
 zMH2wLM+p/ryYFQFzP92oFrWOuuTLWKHHqYu9U68uODgJam9Q43EBgx/pR0aKQb1xxUup++uBwokD
 8XTZ+ZVmClBt0k6rTExxzBdjXArIXEN6cHBU4+aBD6cJy/x9j0foMe2PiC+3XCyZNtL4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WIw+inTt7evzgv8gfyD7YA6hh4z8gHWZ7xDh2JPdqXs=; b=Y
 St9o4OCSoCCCxAPrFjW4XK/Vz1NBkIMXDz4Mu/fxOO4McaU5iZ4lHqbV124y9bpFWbVWqvfWrQscE
 As6qcTlvGD1DIlJtG9lzdh5HVGIiqsKw5ts+S7z8gvkHSM8aTFiMzgjZeKaT4V8CT/PkPGHhYtVCi
 W4uBjgV7POosHHX0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wOLbb-0004VT-Of for openvpn-devel@lists.sourceforge.net;
 Sat, 16 May 2026 20:27:29 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so9323535e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 16 May 2026 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778963236; x=1779568036; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIw+inTt7evzgv8gfyD7YA6hh4z8gHWZ7xDh2JPdqXs=;
 b=XRVLcCh8SsVNgcxfyhj3qC8lW7Lr+MdSEocF8Itc6Eo5VF55UMt1qrvI20NEIOYdqN
 b5385dRsugozzLcvv8LGeesr/K5PG28QnXrbk77loj188Bkjgew0RMf3i9CPIMr5A9Yx
 cUd5JXAvmFLuRTCBWX9EM9alzoNFCelDJWe3D+BAa1EsZPD7rMb/eQ5mSsahN5Y8bySz
 dCMRtmHn56B8qugl1ktNH0JXBhNITAlfTG+9N3hW6s2QrUuB8tYiQN3GXhQqW9VVsqMA
 +5M47dgUut0CIzGjFQ5z3U0A1LU6WiJPBsV1i/ioKMpY6bLxk5gphcUrACMpXVRyxiO/
 Y3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778963236; x=1779568036;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WIw+inTt7evzgv8gfyD7YA6hh4z8gHWZ7xDh2JPdqXs=;
 b=ruKOwyidKfw3znfLFmuD2hWxT0up4YihjjEwkdllyP6tmQV1yeheYV+4DoxXxzIcf1
 kJRyxKaRd/pMnMvsfrWXMgdvWWNPq9cmNR+TUkYigWz6aPInKEROxgEDVXc7ZNp0JGJ6
 wMhnpWQ8sMZYPk0ohnKkAlorkIniU/0qFbT0D42zxRtTdrnUoCQ2jo8JcUx1y4r9dDdp
 kGZHQK7oI+paCfeyoTiPzSXaMMJoMVLC0YpS63P+pSN63q4GrsyhQJA5iqSgUAh15doU
 U2Jr3hx/3AFgK3UdVspy8QKpFYACJxcasQ16OcD1uMv8smLo2SWQl6cuBXjh1jWA1Vhg
 va7w==
X-Gm-Message-State: AOJu0YzKdpDIjTxzyU8vaXR9486fv2ocWDOEs3TG/NdC4tZRCz4AKQFG
 nkCjTpsyMfZsNsTF3qK6pnpJQK2MoS2VNdla5qY96lFRUidEQ2YCjXUy8DMhhwQVu/KA8yEBaos
 SQN1kCpei+Wdjwm6T8xT98QLHj4LnJs1FfaH2KXHI76OzBhICiYrr5N37OtfJ/PssQ90eijnScV
 fZj2bNkQ==
X-Gm-Gg: Acq92OGBOyavpiDxWAjOAfySpy1gYkwToexTGzB5DRA74972kiPaJrvnEQaOeAIQZbG
 46yRwIC22tWqQY2ZuEBy4oFYCzKWn2lI6DJcDW5/OywpPOjh/EucdoPqZ/4iacLeMZYd0AbOgBt
 aH+1xaUsi1i71bUh3drl0SuKKqoSYXqYt99QvPQwxMoAMbqOMAGWtSZlkiy/mupvzeVIuw+m7Cs
 3UMW7awflaeLf7sXz2mI74PZsj7xYlp/D0mcuhctnx07U+w5qeBRaRcGnlYgMGMx7id00c9ijVX
 JB7RApxB6rcE/h68I42MFKffJTQUUzdiMZ3LS/Bzff3+9tlmPT9dsFp94NV8/ar2Yi6E8JuOc8E
 iI0eIHouEOkPC6BFEtPrd4pK4+mFYOPauCZPjOHd+F+CLSspTaG0gPI78CASpy8AzwvtrvjrYaV
 UwJJm56rzmc2I7xAyWXLBqaPiEeTZRoYOGL/PBfJ5b7Kefeb8qb4K/QmNNX7XGQDlfd/9FFYt6B
 RbGYvQksSRGdKmDx24kaM5atGvGj+wHBGQWGiOhiV6zI4LpatFyq3ziaU1/G00e4ADZR+fXvLfg
 J3asQvoUCBglG23/jxCzbryc
X-Received: by 2002:a05:600c:858d:b0:48a:66a8:9981 with SMTP id
 5b1f17b1804b1-48fe66129efmr83501105e9.27.1778963236277; 
 Sat, 16 May 2026 13:27:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694fcasm129951615e9.5.2026.05.16.13.27.15
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 13:27:15 -0700 (PDT)
From: "plaisthos (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 16 May 2026 20:27:15 +0000
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: 64785e381b1fc65b47958a14c0b6f7ac48a8fc59
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e93f12a6b05a7663dee8aa3ad20191fd076add55-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wOLbb-0004VT-Of
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace strtok with
 strtok_r
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============4780790297580902801=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4780790297580902801==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7vadKnaqTHA="; charset=UTF-8

--7vadKnaqTHA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1679?usp=3Demail )


Change subject: Replace strtok with=
 strtok_r
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

R=
eplace strtok with strtok_r

This dos not change anything in our source cod=
e but makes compiling
with newer Android NDKs (version 30 pre release) -Wer=
ror safe again
as it has started throwing warning on this=2E

Change-Id: I7=
0560efd113308b7377424127eb2c1da4266371a
Signed-off-by: Arne Schwabe <arne@r=
fc2549=2Eorg>
---
M src/openvpn/options_util=2Ec
M src/openvpn/ssl_mbedtls=
=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_verify=2Ec
4 files changed=
, 15 insertions(+), 10 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/79/1679/1

diff --git a/src/openvpn/options_=
util=2Ec b/src/openvpn/options_util=2Ec
index 47fe0bc=2E=2Efbc64fa 100644
-=
-- a/src/openvpn/options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -48=
,7 +48,8 @@
         message =3D strstr(reason, "]") + 1;
         /* null =
terminate the substring to only looks for flags between [ and ] */
        =
 *endofflags =3D '\x00';
-        const char *token =3D strtok(m, "[,");
+ =
       char *lasts;
+        const char *token =3D strtok_r(m, "[,", &lasts=
);
         while (token)
         {
             if (!strncmp(token, "back=
off ", strlen("backoff ")))
@@ -81,7 +82,7 @@
             {
              =
   msg(D_PUSH_ERRORS, "WARNING: unknown AUTH_FAIL,TEMP flag: %s", token);
 =
            }
-            token =3D strtok(NULL, "[,");
+            token=
 =3D strtok_r(NULL, "[,", &lasts);
         }
     }
 
diff --git a/src/ope=
nvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 8a0f7d2=2E=2E7f0af=
3f 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=
=2Ec
@@ -318,9 +318,10 @@
 
     /* Parse allowed ciphers, getting IDs */
 =
    int i =3D 0;
+    char *lasts;
     tmp_ciphers_orig =3D tmp_ciphers =
=3D string_alloc(ciphers, NULL);
 
-    token =3D strtok(tmp_ciphers, ":");=

+    token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
    =
 {
         ctx->allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite_id(tls_=
translate_cipher_name(token));
@@ -328,7 +329,7 @@
         {
             =
i++;
         }
-        token =3D strtok(NULL, ":");
+        token =3D st=
rtok_r(NULL, ":", &lasts);
     }
     free(tmp_ciphers_orig);
 }
diff --gi=
t a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index 649665a=2E=2E33=
f33ef 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@=
 -100,7 +100,8 @@
     struct buffer new_list =3D alloc_buf(MAX_NCP_CIPHERS=
_LENGTH);
 
     char *const tmp_ciphers =3D string_alloc(list, NULL);
-   =
 const char *token =3D strtok(tmp_ciphers, ":");
+    char *lasts;
+    con=
st char *token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
 =
    {
         /*
@@ -174,7 +175,7 @@
                 buf_puts(&new_list, =
ovpn_cipher_name);
             }
         }
-        token =3D strtok(NULL=
, ":");
+        token =3D strtok_r(NULL, ":", &lasts);
     }
 
 
@@ -207,=
15 +208,16 @@
 {
     char *tmp_ciphers =3D string_alloc(list, NULL);
     =
char *tmp_ciphers_orig =3D tmp_ciphers;
+    char *lasts;
 
-    const char=
 *token =3D strtok(tmp_ciphers, ":");
+    const char *token =3D strtok_r(t=
mp_ciphers, ":", &lasts);
     while (token)
     {
         if (0 =3D=3D s=
trcmp(token, item))
         {
             break;
         }
-        toke=
n =3D strtok(NULL, ":");
+        token =3D strtok_r(NULL, ":", &lasts);
  =
   }
     free(tmp_ciphers_orig);
 
diff --git a/src/openvpn/ssl_verify=2Ec=
 b/src/openvpn/ssl_verify=2Ec
index 0804d2d=2E=2E8c6e2bc 100644
--- a/src/o=
penvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -868,7 +868,8 @@
=
         return false;
     }
 
-    const char *client_method =3D strtok(i=
v_sso, ",");
+    char *lasts;
+    const char *client_method =3D strtok_r(=
iv_sso, ",", &lasts);
     bool supported =3D false;
 
     while (client_m=
ethod)
@@ -878,7 +879,7 @@
             supported =3D true;
             br=
eak;
         }
-        client_method =3D strtok(NULL, ",");
+        clie=
nt_method =3D strtok_r(NULL, ",", &lasts);
     }
 
     gc_free(&gc);

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70560efd113308b7377424=
127eb2c1da4266371a
Gerrit-Change-Number: 1679
Gerrit-PatchSet: 1
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--7vadKnaqTHA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Replace strtok with strtok_r<br><br>This dos not change anything i=
n our source code but makes compiling<br>with newer Android NDKs (version 3=
0 pre release) -Werror safe again<br>as it has started throwing warning on =
this=2E<br><br>Change-Id: I70560efd113308b7377424127eb2c1da4266371a<br>Sign=
ed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/=
options_util=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ncp=
=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>4 files changed, 15 insertions(+), =
10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/79/1679/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/options_util=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index 47f=
e0bc=2E=2Efbc64fa 100644</span><br><span>--- a/src/openvpn/options_util=2Ec=
</span><br><span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ -48,=
7 +48,8 @@</span><br><span>         message =3D strstr(reason, &quot;]&quot=
;) + 1;</span><br><span>         /* null terminate the substring to only lo=
oks for flags between [ and ] */</span><br><span>         *endofflags =3D &=
#39;\x00&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 const char *token =3D strtok(m, &quot;[,&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        char *lasts;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        const char *token =3D strtok_r(m, &q=
uot;[,&quot;, &amp;lasts);</span><br><span>         while (token)</span><br=
><span>         {</span><br><span>             if (!strncmp(token, &quot;ba=
ckoff &quot;, strlen(&quot;backoff &quot;)))</span><br><span>@@ -81,7 +82,7=
 @@</span><br><span>             {</span><br><span>                 msg(D_P=
USH_ERRORS, &quot;WARNING: unknown AUTH_FAIL,TEMP flag: %s&quot;, token);</=
span><br><span>             }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            token =3D strtok(NULL, &quot;[,&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            token =3D strtok_r(NULL=
, &quot;[,&quot;, &amp;lasts);</span><br><span>         }</span><br><span> =
    }</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_mbedtl=
s=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 8a0f7d2=2E=2E7f0a=
f3f 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><spa=
n>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -318,9 +318,10 @@</s=
pan><br><span> </span><br><span>     /* Parse allowed ciphers, getting IDs =
*/</span><br><span>     int i =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    char *lasts;</span><br><span>     tmp_ciphers_orig =3D=
 tmp_ciphers =3D string_alloc(ciphers, NULL);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    token =3D strtok(tmp_ciphers,=
 &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;lasts);</span><br><spa=
n>     while (token)</span><br><span>     {</span><br><span>         ctx-&g=
t;allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite_id(tls_translate_ciphe=
r_name(token));</span><br><span>@@ -328,7 +329,7 @@</span><br><span>       =
  {</span><br><span>             i++;</span><br><span>         }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        token =3D strtok(NULL, &=
quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span>   =
  }</span><br><span>     free(tmp_ciphers_orig);</span><br><span> }</span><=
br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</sp=
an><br><span>index 649665a=2E=2E33f33ef 100644</span><br><span>--- a/src/op=
envpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><=
span>@@ -100,7 +100,8 @@</span><br><span>     struct buffer new_list =3D al=
loc_buf(MAX_NCP_CIPHERS_LENGTH);</span><br><span> </span><br><span>     cha=
r *const tmp_ciphers =3D string_alloc(list, NULL);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const char *token =3D strtok(tmp_ciphers, =
&quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
char *lasts;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;lasts);</span>=
<br><span>     while (token)</span><br><span>     {</span><br><span>       =
  /*</span><br><span>@@ -174,7 +175,7 @@</span><br><span>                 b=
uf_puts(&amp;new_list, ovpn_cipher_name);</span><br><span>             }</s=
pan><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        token =3D strtok(NULL, &quot;:&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL, &quot;:&quot=
;, &amp;lasts);</span><br><span>     }</span><br><span> </span><br><span> <=
/span><br><span>@@ -207,15 +208,16 @@</span><br><span> {</span><br><span>  =
   char *tmp_ciphers =3D string_alloc(list, NULL);</span><br><span>     cha=
r *tmp_ciphers_orig =3D tmp_ciphers;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    char *lasts;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *token =3D strtok(tmp_cipher=
s, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;lasts);<=
/span><br><span>     while (token)</span><br><span>     {</span><br><span> =
        if (0 =3D=3D strcmp(token, item))</span><br><span>         {</span>=
<br><span>             break;</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        token =3D strtok(NULL, &quot;:&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        token=
 =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span>     }</spa=
n><br><span>     free(tmp_ciphers_orig);</span><br><span> </span><br><span>=
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span>=
<br><span>index 0804d2d=2E=2E8c6e2bc 100644</span><br><span>--- a/src/openv=
pn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><b=
r><span>@@ -868,7 +868,8 @@</span><br><span>         return false;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    const char *client_method =3D strtok(iv_sso, &quot;,&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *client=
_method =3D strtok_r(iv_sso, &quot;,&quot;, &amp;lasts);</span><br><span>  =
   bool supported =3D false;</span><br><span> </span><br><span>     while (=
client_method)</span><br><span>@@ -878,7 +879,7 @@</span><br><span>        =
     supported =3D true;</span><br><span>             break;</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
lient_method =3D strtok(NULL, &quot;,&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        client_method =3D strtok_r(NULL, &quot;,&=
quot;, &amp;lasts);</span><br><span>     }</span><br><span> </span><br><spa=
n>     gc_free(&amp;gc);</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail">cha=
nge 1679</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I70560efd113308b7377424127eb2c1da4266371a </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1679 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--7vadKnaqTHA=--


--===============4780790297580902801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4780790297580902801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4780790297580902801==--

