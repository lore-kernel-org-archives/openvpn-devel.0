Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985E606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BxsoRe9X;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=F/jly3ZG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aGwBFWp6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QLceeaUg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6/9if5o3cHhaNn11Wj0eJu+2rKvgHUsiTR+UNwUpLxY=; b=BxsoRe9XYWazZKI70IeoQTsxcd
	P/WCTINBwk1CIhGgO4S+Jjpw2wY+QrUEIfFEFEPtPHwDFSg+eliX5b0ojP72E6ODPW6esh7ukDMUO
	R1skvPByz9txsOfib1MmbV43VEMxaJgPuIc5p6kg7WKZG+J7Cfd1dRVdE7movgNZNcog=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSy3I-000000005QH-3TrD;
	Mon, 16 Nov 2026 14:51:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSy3H-000000005QB-3egf
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iaRZMClHNXfdROI8erq/ypiAb+h4qZLDp8S1f9JRn30=; b=F/jly3ZGTjbppLMefMgNqb73Lj
 mHc9/zyVGI/fNODxZgtPL45aLiJwLqlDfcbbQLH5fQAr/fHrgMrDUpzLmSV8TNirtQXupZiJFoHVi
 mjyxosS52foxbMwUr3xE1IC6m/JVdSYxK1Xr9wxm/R6wrCWnMxXyxa+i7zQSq9JoBUwA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iaRZMClHNXfdROI8erq/ypiAb+h4qZLDp8S1f9JRn30=; b=aGwBFWp6WwNMyp3DAlWr57YioM
 qjTcOhRCv2rx2RbWB2WhqHXeUn3bzz0lkUObXUZnHKnkwWaCDZfIHDoYjk6tCSd7T1ovwGAMy7omn
 l/wztRn4YdI7yGxE7N51BMQ3+k3RPI6E+o/qy4tujdTY9cKHM4XLnsNcYponcRlu/2iI=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSy3G-000000006UH-29KE for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:51:23 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so1685518f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794840676; x=1795445476; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iaRZMClHNXfdROI8erq/ypiAb+h4qZLDp8S1f9JRn30=;
 b=QLceeaUgGy3kxoEKXtmRAtLIG9DQ6s6rw1D50UPKHPWYDhToNASio4CvlzeYZ2MTZ2
 MWHv50F+dsXz4YLJWi24V/kI0nbnVD7uLNa0Z9GoPheR0ZpIpL19VliY1BTX/i0i6IBB
 1H2vo/UeZq6Ef8q+DzmICAyBu/xknEWgYuJaTScGjyQKqEXZT8etWLv4mcPwpB7cQucw
 5c0EbDvQdJatXwteyGuDcEXahe8krMDuFJ+SwnFYRYlYkH/tZfOuLzylVcykWCvUQyL1
 k8Re3ZIoEMCbygIynXS+n/a76+WddfOfgKUATlEguyE2rtCd/8pnp5WrFB0x1lc7QL7W
 kkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794840676; x=1795445476;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iaRZMClHNXfdROI8erq/ypiAb+h4qZLDp8S1f9JRn30=;
 b=M52G6eVeHJ9ArHOTkCT64Pc/xzWYqtrMqj/J757VR/nKsd5c5VRoFDLrCxOLZ4jQAW
 1Fyk6YmvOI/ilND5qyZdZ23EcTbN0VH/kIqeK4nJr7i20QSK350Dqa6CLbNmAOZ0gOdP
 5AWkbckdl3+Z+k9Wa+kMfkYbXJM1S0p8mEZdX5dktzBJn2/sYT4A9oTHbfvjroiO3f9V
 qMN7GohZa/rI+Lwh1YAQOmkZtat7QxHsOZvAte9Z2dxg9HNIQNAeLmcJBMtd+hzdto51
 jmk/9nE+fXgl5iedS8yzXe7bMnGXP7SsDhOvh0Dsn1saGsaURqlPPllcUIFy9lX/vGzW
 Qgew==
X-Gm-Message-State: APuU4Z/RiWsvVXHvcS71WYTAfyCVV2ZLMsVWLPQ6+zBfWw64UA+YDUCq
 Nt/egpq5m75ePgMmzo4a8vsE8UXpOqAXrDp0vh2ij/R3Xn6bbAAUwpwp+1+alQuJn57Kc1dd2Zw
 mMuirkkV52JA6wbcCemkiNk13AKUJgmslJl7LdzEdLUznHFtQvmWagX8zeNKLeOWMDuZu
X-Gm-Gg: AYBFou0btSHmlf9Rf6GJiw7hD+p0NG4uOThR2CltaD1NZzOfU01PAnNyraWxY4sAGK0
 jZja0kJvrqqxVaGYJ16KjsJuT0cYYYYlQhD01tU1+mtZJjwV4mIrpUkc2aFUDPfEtFMxLzsYX1h
 SKX4rRDvRrd2h5UCKCow+oVFDykxFcmZIKl3YuZfq+0UhlRGGqu5Gwn/UGBNScsQtP/feKT/9HN
 4vQddiYBi7/vW1/OKlUUR1U4QPmQAXZv5yF3KZzVUOnHTqgqilvUeK62pGt11MKClJWRSIIdE69
 fCrrNSnvSc/A+pVc1jhst4t/yUfZIfNyNm53cEMucKQKGqGJ6SOFAvJsNI+uW+rE0QuC+oUOOOy
 cCgEXb1jbVVfdlLDO7BNaq1WrZRTaJtPaAo13dq5HKP/Mm0sb4d8CsKMn3DCKdeUgnXQFc6+Jma
 lOQ98Z/6cLXh3yOp++rPVWEh6YxDik//zXENOnX3zBaONm0skc6Gc7aSgFl65vH3IErZu05Ng8P
 U49tT9S2ANhcVScD3FlwYT4iAQ8AlSYDCYyPKkelmp38jyFeQ7HOe5xgXn71srx9kc10F8tk2vG
 zEM6GXWO2Su2ndw/sBb8GjFQf+CYQhnfiM94WsVapYXMgN0AJHzEJCW6PuxgeEZp5eKFAXvGtTv
 aks4oy46EqeXO/pcqR2pmd//T8tCcrIvtZSmnNieOPPHaOrKBpkWl+TMRqaYwOI7RI+P15gdCk5
 aSV/zOyiPE71PAN3E=
X-Received: by 2002:a05:600c:1d16:b0:4a2:84c:52f3 with SMTP id
 5b1f17b1804b1-4bb55a4502amr239528675e9.6.1794840675620; 
 Mon, 16 Nov 2026 06:51:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae501bsm317427215e9.10.2026.11.16.06.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:51:14 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:51:12 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253
X-Gerrit-Change-Number: 2197
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2197?usp=email>
X-Gerrit-Commit: e7a1fc7dac733dcc0f3f5d3f6dc90f67ad2d7209
In-Reply-To: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
References: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkkzM2Y3MDgyNWMwNThjMjRlY2FiZDhlODBlNWFjODRiZmYwN2M5MjUzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d76a672d4dd690e08a47ed3039ac4eb828d085c9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSy3G-000000006UH-29KE
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various trivial
 -Wsign-conversion fixes (part 2)
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
Content-Type: multipart/mixed; boundary="===============5056436810893041938=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5056436810893041938==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gltUg0M5riU="; charset=UTF-8

--gltUg0M5riU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2197?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: Various trivial -Wsign-conversion fixes (part 2)
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Various trivi=
al -Wsign-conversion fixes (part 2)

Change-Id: I33f70825c058c24ecabd8e80e5=
ac84bff07c9253
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
-=
--
M src/openvpn/env_set=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/ps=2Ec
=
M src/openvpn/ssl_mbedtls=2Ec
M tests/unit_tests/openvpn/test_buffer=2Ec
M =
tests/unit_tests/openvpn/test_cryptoapi=2Ec
6 files changed, 15 insertions(=
+), 60 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/97/2197/2

diff --git a/src/openvpn/env_set=2Ec b/src/openvpn=
/env_set=2Ec
index d59115a=2E=2E55190b8 100644
--- a/src/openvpn/env_set=2E=
c
+++ b/src/openvpn/env_set=2Ec
@@ -432,11 +432,6 @@
     return (script_se=
curity() >=3D SSEC_PW_ENV || !is_password_env_var(str));
 }
 
-#if defined(=
__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC d=
iagnostic ignored "-Wsign-conversion"
-#endif
-
 /* Make arrays of strings =
*/
 
 const char **
@@ -444,7 +439,7 @@
 {
     char **ret =3D NULL;
     s=
truct env_item *e =3D NULL;
-    int i =3D 0, n =3D 0;
+    size_t i =3D 0,=
 n =3D 0;
 
     /* figure length of es */
     if (es)
@@ -475,7 +470,3 @@=

     ret[i] =3D NULL;
     return (const char **)ret;
 }
-
-#if defined(__=
GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --gi=
t a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ca0a7dd=2E=2Eae30=
930 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -77=
9,14 +779,9 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#p=
ragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversio=
n"
-#endif
-
 static void
 man_query_user_pass(struct management *man, cons=
t char *type, const char *string, const bool needed,
-                    c=
onst char *prompt, char *dest, int len)
+                    const char *pr=
ompt, char *dest, size_t len)
 {
     if (needed)
     {
@@ -809,10 +804,6 =
@@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC di=
agnostic pop
-#endif
-
 static void
 man_query_username(struct management *=
man, const char *type, const char *string)
 {
@@ -2700,11 +2691,6 @@
     C=
LEAR(*mp);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC d=
iagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
=
-
 static void
 man_settings_init(struct man_settings *ms, const char *addr=
, const char *port,
                   const char *pass_file, const char *c=
lient_user, const char *client_group,
@@ -3315,15 +3301,11 @@
         {
  =
           return false;
         }
-        *persistent =3D n;
+        *p=
ersistent =3D (unsigned int)n;
     }
     return true;
 }
 
-#if defined(_=
_GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifde=
f _WIN32
 
 void
@@ -3708,7 +3690,7 @@
         struct buffer alert_msg =3D=
 alloc_buf_gc(256, &gc);
         const char *alert_type =3D NULL;
        =
 const char *prefix =3D NULL;
-        unsigned int up_query_mode =3D 0;
+ =
       int up_query_mode =3D 0;
         const char *sc =3D NULL;
         =
ret =3D true;
         /* This is so M_CLIENT messages will be correctly pa=
ssed through msg() */
@@ -4052,8 +4034,8 @@
         const bool standalone_=
disabled_save =3D man->persist=2Estandalone_disabled;
         struct gc_ar=
ena gc =3D gc_new();
 
-        man->persist=2Estandalone_disabled =3D
-   =
         false; /* This is so M_CLIENT messages will be correctly passed th=
rough msg() */
+        /* This is so M_CLIENT messages will be correctly p=
assed through msg() */
+        man->persist=2Estandalone_disabled =3D fals=
e;
         man->persist=2Especial_state_msg =3D NULL;
         man->settin=
gs=2Emansig |=3D MANSIG_IGNORE_USR1_HUP;
 
diff --git a/src/openvpn/ps=2Ec =
b/src/openvpn/ps=2Ec
index 86b4fc9=2E=2E89ae371 100644
--- a/src/openvpn/ps=
=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -159,7 +159,7 @@
     }
 }
 
-static int
+=
static socklen_t
 cmsg_size(void)
 {
     return CMSG_SPACE(sizeof(socket_d=
escriptor_t));
@@ -357,8 +357,8 @@
         }
         if (fd !=3D -1)
    =
     {
-            ssize_t write_len =3D strlen(f);
-            if (write=
(fd, f, write_len) !=3D write_len)
+            const size_t write_len =3D =
strlen(f);
+            if (write(fd, f, write_len) !=3D (ssize_t)write_len=
)
             {
                 msg(M_WARN, "PORT SHARE: writing to journ=
al file (%s) failed", jfn);
             }
diff --git a/src/openvpn/ssl_mbe=
dtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 43bb0ff=2E=2Eaa843c1 100644
--=
- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1017,=
7 +1017,7 @@
 
     if (1 =3D=3D retval)
     {
-        memset(BPTR(buf), =
0, BLEN(buf)); /* erase data just written */
+        memset(BPTR(buf), 0, =
BLENZ(buf)); /* erase data just written */
         buf->len =3D 0;
     }
=
 
@@ -1039,7 +1039,7 @@
 
     ASSERT(data);
 
-    retval =3D mbedtls_ssl_=
write(ks->ctx, data, len);
+    retval =3D mbedtls_ssl_write(ks->ctx, data,=
 (size_t)len);
 
     if (retval < 0)
     {
@@ -1143,7 +1143,7 @@
     /* =
successful write */
     dmsg(D_HANDSHAKE_VERBOSE, "write tls_write_ciphert=
ext %d bytes", retval);
 
-    memset(BPTR(buf), 0, BLEN(buf)); /* erase da=
ta just written */
+    memset(BPTR(buf), 0, BLENZ(buf)); /* erase data jus=
t written */
     buf->len =3D 0;
 
     return 1;
diff --git a/tests/unit_=
tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
in=
dex b480985=2E=2E14f5d1d 100644
--- a/tests/unit_tests/openvpn/test_buffer=
=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -106,20 +106,15 @@
 =
    gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragm=
a GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-=
#endif
-
 static void
 test_buffer_format_hex_ex(void **state)
 {
-    cons=
t int input_size =3D 10;
+    const size_t input_size =3D 10;
     const ui=
nt8_t input[] =3D { 0x01, 0x00, 0xff, 0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0=
x0a };
     char *output;
     struct gc_arena gc =3D gc_new();
 
-    int =
maxoutput =3D 0;
+    size_t maxoutput =3D 0;
     unsigned int blocksize =
=3D 5;
     const char *separator =3D " ";
     output =3D format_hex_ex(in=
put, input_size, maxoutput, blocksize, separator, &gc);
@@ -144,10 +139,6 @=
@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pr=
agma GCC diagnostic pop
-#endif
-
 struct test_buffer_list_aggregate_ctx
 {=

     struct buffer_list *empty;
diff --git a/tests/unit_tests/openvpn/test=
_cryptoapi=2Ec b/tests/unit_tests/openvpn/test_cryptoapi=2Ec
index 55aafbb=
=2E=2E2517a55 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi=2Ec
+++ =
b/tests/unit_tests/openvpn/test_cryptoapi=2Ec
@@ -137,11 +137,6 @@
     ret=
urn c->cert ? c : NULL;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-=
#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-convers=
ion"
-#endif
-
 /* import sample certificates into windows cert store */
 s=
tatic void
 import_certs(void **state)
@@ -201,7 +196,7 @@
             fai=
l_msg("Failed to DER encode PKCS12: <%s>", c->friendly_name);
             =
return;
         }
-        blob=2EcbData =3D len;
+        blob=2EcbData =
=3D (DWORD)len;
 
         DWORD flags =3D PKCS12_ALLOW_OVERWRITE_KEY | PKC=
S12_ALWAYS_CNG_KSP;
         HCERTSTORE tmp_store =3D PFXImportCertStore(&b=
lob, wpass, flags);
@@ -228,10 +223,6 @@
     certs_loaded =3D true;
 }
 
-=
#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#e=
ndif
-
 static int
 cleanup(void **state)
 {

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2197?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253
Ge=
rrit-Change-Number: 2197
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--gltUg0M5riU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2197?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Various trivial -Wsign-conversion fixes (part 2)<br><br>Change-Id: I=
33f70825c058c24ecabd8e80e5ac84bff07c9253<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/env_set=2Ec<br>M =
src/openvpn/manage=2Ec<br>M src/openvpn/ps=2Ec<br>M src/openvpn/ssl_mbedtls=
=2Ec<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>M tests/unit_tests/op=
envpn/test_cryptoapi=2Ec<br>6 files changed, 15 insertions(+), 60 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/97/2197/2</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/env_set=2Ec=
 b/src/openvpn/env_set=2Ec</span><br><span>index d59115a=2E=2E55190b8 10064=
4</span><br><span>--- a/src/openvpn/env_set=2Ec</span><br><span>+++ b/src/o=
penvpn/env_set=2Ec</span><br><span>@@ -432,11 +432,6 @@</span><br><span>   =
  return (script_security() &gt;=3D SSEC_PW_ENV || !is_password_env_var(str=
));</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignor=
ed &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> /* Make arrays of strings */</span><br><span> </span><br><spa=
n> const char **</span><br><span>@@ -444,7 +439,7 @@</span><br><span> {</sp=
an><br><span>     char **ret =3D NULL;</span><br><span>     struct env_item=
 *e =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
i =3D 0, n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size_t i =3D 0, n =3D 0;</span><br><span> </span><br><span>     /* figure=
 length of es */</span><br><span>     if (es)</span><br><span>@@ -475,7 +47=
0,3 @@</span><br><span>     ret[i] =3D NULL;</span><br><span>     return (c=
onst char **)ret;</span><br><span> }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span>diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ca0a7dd=2E=2Eae30930 10=
0644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src=
/openvpn/manage=2Ec</span><br><span>@@ -779,14 +779,9 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic igno=
red &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> static void</span><br><span> man_query_user_pass(struct mana=
gement *man, const char *type, const char *string, const bool needed,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    const c=
har *prompt, char *dest, int len)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    const char *prompt, char *dest, size_t le=
n)</span><br><span> {</span><br><span>     if (needed)</span><br><span>    =
 {</span><br><span>@@ -809,10 +804,6 @@</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static void</span><br><span> man_query_u=
sername(struct management *man, const char *type, const char *string)</span=
><br><span> {</span><br><span>@@ -2700,11 +2691,6 @@</span><br><span>     C=
LEAR(*mp);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> static void</span><br><span> man_settings_init(struct =
man_settings *ms, const char *addr, const char *port,</span><br><span>     =
              const char *pass_file, const char *client_user, const char *c=
lient_group,</span><br><span>@@ -3315,15 +3301,11 @@</span><br><span>      =
   {</span><br><span>             return false;</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *persistent =
=3D n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *pers=
istent =3D (unsigned int)n;</span><br><span>     }</span><br><span>     ret=
urn true;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</span>=
<br><span> </span><br><span> void</span><br><span>@@ -3708,7 +3690,7 @@</sp=
an><br><span>         struct buffer alert_msg =3D alloc_buf_gc(256, &amp;gc=
);</span><br><span>         const char *alert_type =3D NULL;</span><br><spa=
n>         const char *prefix =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        unsigned int up_query_mode =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        int up_query_mode =3D 0;</s=
pan><br><span>         const char *sc =3D NULL;</span><br><span>         re=
t =3D true;</span><br><span>         /* This is so M_CLIENT messages will b=
e correctly passed through msg() */</span><br><span>@@ -4052,8 +4034,8 @@</=
span><br><span>         const bool standalone_disabled_save =3D man-&gt;per=
sist=2Estandalone_disabled;</span><br><span>         struct gc_arena gc =3D=
 gc_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        man-&gt;persist=2Estandalone_disabled =3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            false; /* This is so M_CLIEN=
T messages will be correctly passed through msg() */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* This is so M_CLIENT messages w=
ill be correctly passed through msg() */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        man-&gt;persist=2Estandalone_disabled =3D fals=
e;</span><br><span>         man-&gt;persist=2Especial_state_msg =3D NULL;</=
span><br><span>         man-&gt;settings=2Emansig |=3D MANSIG_IGNORE_USR1_H=
UP;</span><br><span> </span><br><span>diff --git a/src/openvpn/ps=2Ec b/src=
/openvpn/ps=2Ec</span><br><span>index 86b4fc9=2E=2E89ae371 100644</span><br=
><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</s=
pan><br><span>@@ -159,7 +159,7 @@</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static sockl=
en_t</span><br><span> cmsg_size(void)</span><br><span> {</span><br><span>  =
   return CMSG_SPACE(sizeof(socket_descriptor_t));</span><br><span>@@ -357,=
8 +357,8 @@</span><br><span>         }</span><br><span>         if (fd !=3D=
 -1)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            ssize_t write_len =3D strlen(f);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (write(fd, f, write_len) !=
=3D write_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       const size_t write_len =3D strlen(f);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (write(fd, f, write_len) !=3D (ssiz=
e_t)write_len)</span><br><span>             {</span><br><span>             =
    msg(M_WARN, &quot;PORT SHARE: writing to journal file (%s) failed&quot;=
, jfn);</span><br><span>             }</span><br><span>diff --git a/src/ope=
nvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 43=
bb0ff=2E=2Eaa843c1 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec=
</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -1017=
,7 +1017,7 @@</span><br><span> </span><br><span>     if (1 =3D=3D retval)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        memset(BPTR(buf)=
, 0, BLENZ(buf)); /* erase data just written */</span><br><span>         bu=
f-&gt;len =3D 0;</span><br><span>     }</span><br><span> </span><br><span>@=
@ -1039,7 +1039,7 @@</span><br><span> </span><br><span>     ASSERT(data);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
etval =3D mbedtls_ssl_write(ks-&gt;ctx, data, len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    retval =3D mbedtls_ssl_write(ks-&gt;c=
tx, data, (size_t)len);</span><br><span> </span><br><span>     if (retval &=
lt; 0)</span><br><span>     {</span><br><span>@@ -1143,7 +1143,7 @@</span><=
br><span>     /* successful write */</span><br><span>     dmsg(D_HANDSHAKE_=
VERBOSE, &quot;write tls_write_ciphertext %d bytes&quot;, retval);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memset(B=
PTR(buf), 0, BLEN(buf)); /* erase data just written */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    memset(BPTR(buf), 0, BLENZ(buf)); /*=
 erase data just written */</span><br><span>     buf-&gt;len =3D 0;</span><=
br><span> </span><br><span>     return 1;</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=
=2Ec</span><br><span>index b480985=2E=2E14f5d1d 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/tests/unit=
_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -106,20 +106,15 @@</span>=
<br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> tes=
t_buffer_format_hex_ex(void **state)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const int input_size =3D 10;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t input_size =
=3D 10;</span><br><span>     const uint8_t input[] =3D { 0x01, 0x00, 0xff, =
0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0x0a };</span><br><span>     char *outp=
ut;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int maxoutput =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t maxou=
tput =3D 0;</span><br><span>     unsigned int blocksize =3D 5;</span><br><s=
pan>     const char *separator =3D &quot; &quot;;</span><br><span>     outp=
ut =3D format_hex_ex(input, input_size, maxoutput, blocksize, separator, &a=
mp;gc);</span><br><span>@@ -144,10 +139,6 @@</span><br><span>     gc_free(&=
amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct test_buffer_li=
st_aggregate_ctx</span><br><span> {</span><br><span>     struct buffer_list=
 *empty;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoa=
pi=2Ec b/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><br><span>index =
55aafbb=2E=2E2517a55 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_cryptoapi=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_cryp=
toapi=2Ec</span><br><span>@@ -137,11 +137,6 @@</span><br><span>     return =
c-&gt;cert ? c : NULL;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /* import sample certificates into windo=
ws cert store */</span><br><span> static void</span><br><span> import_certs=
(void **state)</span><br><span>@@ -201,7 +196,7 @@</span><br><span>        =
     fail_msg(&quot;Failed to DER encode PKCS12: &lt;%s&gt;&quot;, c-&gt;fr=
iendly_name);</span><br><span>             return;</span><br><span>        =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        blob=2EcbDa=
ta =3D len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
blob=2EcbData =3D (DWORD)len;</span><br><span> </span><br><span>         DW=
ORD flags =3D PKCS12_ALLOW_OVERWRITE_KEY | PKCS12_ALWAYS_CNG_KSP;</span><br=
><span>         HCERTSTORE tmp_store =3D PFXImportCertStore(&amp;blob, wpas=
s, flags);</span><br><span>@@ -228,10 +223,6 @@</span><br><span>     certs_=
loaded =3D true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</s=
pan><br><span> cleanup(void **state)</span><br><span> {</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197?u=
sp=3Demail">change 2197</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2197?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2197 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--gltUg0M5riU=--


--===============5056436810893041938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5056436810893041938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5056436810893041938==--

