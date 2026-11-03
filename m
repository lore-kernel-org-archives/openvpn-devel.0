Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC0606A33D
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kMVQb4ZC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gdEPrf6t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R1meHs5l;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HgqQUvGW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=FVIh7gARjy3SMedc04HpGEgsPK2MXs/NHfZL0YFgx5E=; b=kMVQb4ZCXhdp25Bd0/umGhHjqU
	mV/zAR4ChbvRu/uUXRPrLkBbn810hhWrlrYY/8f1xaOeUFarL35XKI8pxxbSgTrTtCF1+O7lam87h
	8jgigUtiCti+CL8+L9R8yrAHQ7g3uB7ZiDNi2E2sfjx8ohl5qF7iz/nbL4AaMh/6wFa4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO7pW-000000007nu-0nkN;
	Tue, 03 Nov 2026 06:17:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO7pV-000000007no-16yY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 06:17:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yEV1mg/ngrFiodRaVOMN0/9DDmFLrlqzb5z7nidcTUM=; b=gdEPrf6t9WO+BkZolSxplauJMs
 hHWv3AAxUHENjclIEh9lszxf+Tu2uzcts+a+WIieZ6FgSCPs3vEht1GVe38SF1pozpVwNBqHdMhzi
 m1tgPByfN8RMMGWTp9B15otVglP3KAM/kbawdSkNeZ+ljZqQv0vxdwfBt5vFBnqGBtZ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yEV1mg/ngrFiodRaVOMN0/9DDmFLrlqzb5z7nidcTUM=; b=R1meHs5lm1JOYMA3vYBPjonxjo
 je0ev1OnFm/hUL5UpHlXxsVQy9Um7hgrkn9rx9VoKyj2Pr3xZjtT480HWJngtyjSxdg/7jYj0bG4L
 JOQWymVAlbywJSGnibtLxvat7BACWMZjm5exRZH8rdTbtzKQfhBcuuUwTY/c99vT0KCU=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO7pT-000000000uP-38hN for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 06:17:09 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so2283983f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 22:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793686621; x=1794291421; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yEV1mg/ngrFiodRaVOMN0/9DDmFLrlqzb5z7nidcTUM=;
 b=HgqQUvGW37mrqYIpxS4NRqOvqVvwX+C/vx9hW86jE6/zr9BgqsJyFhjI0LTWo/zSS4
 KEl5I/jsRjX5d/Skf6W8v5NmVfG7mtxNZBolxeJkAywpz7vs7/0DckbbboKLuROba5O7
 Xy34nmGy2h3a0M2CVQ/mzMfhAoKg7VjM7l8fSbVI7XK682epN72uhTt29gpAG145Cf1i
 JRZzU2Tm6vVtW7wXKMuFMRJ+mdJCMqil1A5hoX6br4E/XWFG6cULRh64l7w4sKOd8geS
 gJP/XVAI6V0GcL6Px48tDelQ0krwWPOFYkePtLtP4MLyEJd1UWiedSUtCETz+7ZAYFPa
 2qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686621; x=1794291421;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yEV1mg/ngrFiodRaVOMN0/9DDmFLrlqzb5z7nidcTUM=;
 b=w2Ec5J+6u0QuHIXVZNshY6xPflNCR0lCByNqYx0CaysXekOlLCnuQ4z8zWYrEDC0Pf
 E87GZ9+GB7Ht/g07UmglwQKxLeccntgAr3WSBsMNKX9D9oD6mbyT0ZPG4q/7rMI5de1+
 qPvwXkUZMebT8XagL19cV5dFDZfBv9k0ddB+HqQXJclrCeEAoq2QUXcaTxn0eOyLL/lW
 t5sGbZEw8qx+bztOKo5nJ0SplhS78XxrUfO0JQX7HUajI0gr4vIQ8mBpWYXeXOs499ph
 r19rKjqdB4nGAczgOW0+fENLwHoleRAAm9uz550hQ3rdEmF7alohK6rK2FCjPU9XOaYM
 RzrA==
X-Gm-Message-State: APuU4Z8yjW6U16hu1wGjo6qoEFbrHj9819HH1jZwulYV/ZHrsQ262vqR
 N2cN9YG89FqXgtyzit17Op3iQ0lOxHvKIIPEpr2/SfG6CiwSKmB46uQM4+6zLJlfUa4ivWvc4Gr
 B0i7fhOz0QEzUfTztsbfJKnt1Wmt8mYHvZvd81uQewr/zaBnR0n3Mtj+yxYCAvlh6RpGZW+LnIl
 xbALo6NA==
X-Gm-Gg: AYBFou0oYPRrFOLldfEBq4FR2HDGK7IDArLLyFSigiam046XMdzudq19xoZ6236rdST
 BIbeag+JnwIc6JVL8aA6/KmrqaxVFJ1upYNekCc5o15xciH+q7vcWST69bQwSyixuZrZHeFY1pj
 5BEzK2WwXLf6cPgmH4H7eIjy0fGHdyXCd+pD08pm0gES++sPlYL7ivEMUOiYpglZ3HIAKLzrs2B
 TJNMbIoD1FQ2BsitVKV7XtZI15pbsVws2+NbGieKrZtVBzmoyqwGfPoXsysRvu7qn9RNEtEcExo
 Yd1eyr3nom0mVdnSMxSBqLsku90f/4mXiLXPFsuv5cMwZ8sMycHmnGZTPRjGxrhQnUD660zByX4
 zq7Zzi/ftVz+vu9laefPEfV8wV7wX2INOiwmsV7dVgZOul8Sip22HQE2apkknHCqp1n75i10Feu
 2bqbbm3U7r+9cfilxjVs0DHEqQQkTpcfOQHf9iS2A20QzsMEzvOEuYJ4w3zVf94LIDR5q7T93r3
 M6dG4JSBXfW8wyz+rbJ/olhdQkUOVbluNTlGnvKwYm7wVHU+YD5ZNsNthkFOuJZTGoh8RN3s7jx
 UuSKcHoJTzuHgHf+kw511rYNMgl+hPMl2LcG9od18lJAGWwRae6/aA5Wat0G9q07nDAddA0wZrf
 R8H17P4fL1l8Qm8tYzixnm+a+3VSy8Y9XqdvmKdjUSdaFY/pM7CjJPPVQKhxkV3zoO3UjFTQKtB
 ULsgOdD79SeWym/w==
X-Received: by 2002:a5d:588e:0:b0:48e:bf0:35c with SMTP id
 ffacd0b85a97d-48e6e4f543cmr25276247f8f.13.1793686620918; 
 Mon, 02 Nov 2026 22:17:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80eb1sm24688181f8f.34.2026.11.02.22.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:17:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 06:17:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0
X-Gerrit-Change-Number: 2098
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2098?usp=email>
X-Gerrit-Commit: d840c13fa2eeba8e522237720ec8a17391976381
References: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2NjE4MDAwLkllNmMxZmE2NjM5NzhlZWRjYTIzOTFmMTI1MDEyOWJjNDY3MzhmYWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47d6c849d40034297de91b51a3afadcb79de3f92-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO7pT-000000000uP-38hN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove unused local
 variables
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8656342574790495158=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8656342574790495158==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oyJL38CelhI="; charset=UTF-8

--oyJL38CelhI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2098?usp=3Demail

to review the following change=2E
=


Change subject: Remove unused local variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove unused local variables

- tls_ses=
sion_generate_dynamic_tls_crypt_key(): kds
- socks_proxy_recv_char(): reads=
 fd_set
- verify_cert_call_command(): gc
- man_dispatch_command(): gc, and =
the unused nparms parameter

Change-Id: Ie6c1fa663978eedca2391f1250129bc467=
38faa0
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/ope=
nvpn/manage=2Ec
M src/openvpn/socks=2Ec
M src/openvpn/ssl_verify=2Ec
M src/=
openvpn/tls_crypt=2Ec
4 files changed, 3 insertions(+), 15 deletions(-)



=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/2098/=
1

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 16864=
c8=2E=2Ec477b58 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manag=
e=2Ec
@@ -1478,11 +1478,8 @@
 }
 
 static void
-man_dispatch_command(struct=
 management *man, struct status_output *so, const char **p,
-              =
       const int nparms)
+man_dispatch_command(struct management *man, stru=
ct status_output *so, const char **p)
 {
-    struct gc_arena gc =3D gc_new=
();
-
     ASSERT(p[0]);
     if (streq(p[0], "exit") || streq(p[0], "quit"=
))
     {
@@ -1843,7 +1840,7 @@
     }
 
 done:
-    gc_free(&gc);
+    ret=
urn;
 }
 
 #ifdef _WIN32
@@ -2250,7 +2247,7 @@
 
         if (nparms > 0)
 =
        {
-            man_dispatch_command(man, so, (const char **)parms, =
nparms);
+            man_dispatch_command(man, so, (const char **)parms);
=
         }
     }
 
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=
=2Ec
index cab9af6=2E=2Ea8c9fd3 100644
--- a/src/openvpn/socks=2Ec
+++ b/sr=
c/openvpn/socks=2Ec
@@ -86,10 +86,6 @@
                       const struct =
event_timeout *server_poll_timeout,
                       volatile int *si=
gnal_received)
 {
-    fd_set reads;
-    FD_ZERO(&reads);
-    openvpn_fd_=
set(sd, &reads);
-
     struct timeval tv;
     tv=2Etv_sec =3D get_server_=
poll_remaining_time(server_poll_timeout);
     tv=2Etv_usec =3D 0;
diff --g=
it a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 73e3696=
=2E=2E167e659 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl=
_verify=2Ec
@@ -515,7 +515,6 @@
                          char *subject)
 {=

     int ret;
-    struct gc_arena gc =3D gc_new();
     struct argv argv =
=3D argv_new();
 
     setenv_str(es, "script_type", "tls-verify");
@@ -526=
,7 +525,6 @@
     argv_msg_prefix(D_TLS_DEBUG, &argv, "TLS: executing verif=
y command");
     ret =3D openvpn_run_script(&argv, es, 0, "--tls-verify sc=
ript");
 
-    gc_free(&gc);
     argv_free(&argv);
 
     if (ret)
diff --=
git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 23c7975=
=2E=2E447262c 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_=
crypt=2Ec
@@ -121,9 +121,6 @@
 
     const int key_direction =3D session->o=
pt->server ? KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
 
-    struct ke=
y_direction_state kds;
-    key_direction_state_init(&kds, key_direction);
=
-
     struct key_type kt =3D tls_crypt_kt();
 
     init_key_ctx_bi(&sessi=
on->tls_wrap_reneg=2Eopt=2Ekey_ctx_bi, &rengokeys, key_direction, &kt,

-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie6c1fa663978eedca239=
1f1250129bc46738faa0
Gerrit-Change-Number: 2098
Gerrit-PatchSet: 1
Gerrit-O=
wner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>

--oyJL38CelhI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Remove unused local variables<br><br>- tls_session_gene=
rate_dynamic_tls_crypt_key(): kds<br>- socks_proxy_recv_char(): reads fd_se=
t<br>- verify_cert_call_command(): gc<br>- man_dispatch_command(): gc, and =
the unused nparms parameter<br><br>Change-Id: Ie6c1fa663978eedca2391f125012=
9bc46738faa0<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/socks=2Ec<br>M src/op=
envpn/ssl_verify=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>4 files changed, 3 i=
nsertions(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/2098/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 16=
864c8=2E=2Ec477b58 100644</span><br><span>--- a/src/openvpn/manage=2Ec</spa=
n><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -1478,11 +1478,=
8 @@</span><br><span> }</span><br><span> </span><br><span> static void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-man_dispatch_command(struc=
t management *man, struct status_output *so, const char **p,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                     const int nparm=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_dispatch_comm=
and(struct management *man, struct status_output *so, const char **p)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     ASSERT(p[0]);</span><br><span>     if (streq(p=
[0], &quot;exit&quot;) || streq(p[0], &quot;quit&quot;))</span><br><span>  =
   {</span><br><span>@@ -1843,7 +1840,7 @@</span><br><span>     }</span><br=
><span> </span><br><span> done:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return;</span><br><span> }</span><br><span> </span><br><spa=
n> #ifdef _WIN32</span><br><span>@@ -2250,7 +2247,7 @@</span><br><span> </s=
pan><br><span>         if (nparms &gt; 0)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            man_dispatch_com=
mand(man, so, (const char **)parms, nparms);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            man_dispatch_command(man, so, (const c=
har **)parms);</span><br><span>         }</span><br><span>     }</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/so=
cks=2Ec</span><br><span>index cab9af6=2E=2Ea8c9fd3 100644</span><br><span>-=
-- a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</spa=
n><br><span>@@ -86,10 +86,6 @@</span><br><span>                       const=
 struct event_timeout *server_poll_timeout,</span><br><span>               =
        volatile int *signal_received)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    fd_set reads;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    FD_ZERO(&amp;reads);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    openvpn_fd_set(sd, &amp;reads);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     stru=
ct timeval tv;</span><br><span>     tv=2Etv_sec =3D get_server_poll_remaini=
ng_time(server_poll_timeout);</span><br><span>     tv=2Etv_usec =3D 0;</spa=
n><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verif=
y=2Ec</span><br><span>index 73e3696=2E=2E167e659 100644</span><br><span>---=
 a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=
=2Ec</span><br><span>@@ -515,7 +515,6 @@</span><br><span>                  =
        char *subject)</span><br><span> {</span><br><span>     int ret;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span>     struct argv argv =3D argv_new();</span><=
br><span> </span><br><span>     setenv_str(es, &quot;script_type&quot;, &qu=
ot;tls-verify&quot;);</span><br><span>@@ -526,7 +525,6 @@</span><br><span> =
    argv_msg_prefix(D_TLS_DEBUG, &amp;argv, &quot;TLS: executing verify com=
mand&quot;);</span><br><span>     ret =3D openvpn_run_script(&amp;argv, es,=
 0, &quot;--tls-verify script&quot;);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span>   =
  argv_free(&amp;argv);</span><br><span> </span><br><span>     if (ret)</sp=
an><br><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=
=2Ec</span><br><span>index 23c7975=2E=2E447262c 100644</span><br><span>--- =
a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec=
</span><br><span>@@ -121,9 +121,6 @@</span><br><span> </span><br><span>    =
 const int key_direction =3D session-&gt;opt-&gt;server ? KEY_DIRECTION_NOR=
MAL : KEY_DIRECTION_INVERSE;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct key_direction_state kds;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    key_direction_state_init(&amp;kd=
s, key_direction);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>     struct key_type kt =3D tls_crypt_kt();</span><br><span> =
</span><br><span>     init_key_ctx_bi(&amp;session-&gt;tls_wrap_reneg=2Eopt=
=2Ekey_ctx_bi, &amp;rengokeys, key_direction, &amp;kt,</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?us=
p=3Demail">change 2098</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2098?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2098 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--oyJL38CelhI=--


--===============8656342574790495158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8656342574790495158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8656342574790495158==--

