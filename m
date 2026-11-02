Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D4606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Gs05/smd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a0/ZWf17;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bjZs4dAY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XsPNPuAB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=vP40hG74ewmnaGkKAfIXhxTcXqViiHrU6RTdIzOgXe8=; b=Gs05/smd9xLezntG3WxS2sLKmX
	aJEBVwVOWUqeY3MDQ2Qoq5nwX2FH/CcP0Y1R6+e0tiSkytoBultVw8koCg317Aowi6yhaAHsIIKvp
	iWoLPVOo34lcbM4/WLpmIi9esftwOlfkiKtjjuQPOuxCGHr4LLb00KJQ9zaQ2DEeubhw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNq2a-000000005JZ-25b7;
	Mon, 02 Nov 2026 11:17:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNq2Y-000000005JS-1iUL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:17:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2lpX1hZD2fWugnLeq9RoMoa2M0zAlYVgOzGI5RSV3DI=; b=a0/ZWf17kCkzKVGLsSq4Fk/iKq
 1lrTCaJsxB3zoyJRosjtwaOxz9kkYl6ygfVeP+0uyG46L4fHqojmnD7oLOTd1NGNjZkGqzkQ6HCp5
 dAw0zf3dtagjIqSnKo72SovSJVJ2z937HE++yhrV5mRzbmiSwVQO9MmodgZS0e6/MMjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2lpX1hZD2fWugnLeq9RoMoa2M0zAlYVgOzGI5RSV3DI=; b=bjZs4dAYiDkkbxhy/5a4Zg2S5p
 YUrWN5dk9Zql64q9JB86woVawX9WGwNsoYZsOofososNQk1ZUD/ECtOmWjq1fltG3YxiaSVuF8QXq
 Zn+oR2XEoBt9Nd/8M1Lm/IAo4Q3msUIuyvodLwEO/ndWSi2yUHDNh/CV439zN7nlF6dQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNq2W-000000004VT-2VlQ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:17:26 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so17890545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793618238; x=1794223038; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2lpX1hZD2fWugnLeq9RoMoa2M0zAlYVgOzGI5RSV3DI=;
 b=XsPNPuABV0UkX8PwGOsRRd+ntU0L82/cZJi2BKLwJgPGH+86rhe4VuO+u0IapPbDg4
 LivxOulDLtUloGvh0vk/EohM6TfoXDbYr0qwrfACKfN1oDWLfbRDu+0b29UQ9SIrRWxP
 LWZ3eYubmo3CRDvdK4Xl8i2LZGVMbM6y2c5xl1oJyXU6UU6kfWxQNtYF2spaLsqWUa4k
 xORTnMcyZzqqJ9qPxcFgR9Pnk75PYvkEz6gPzbZ03vgUIV0MAwBC72Fn2moN4qUIJyXk
 Lfpv74jwYQL8APJAxmJ+ian/0Q9YH/zdr6SMj/P8TDDttsVZVypKG4yNSrGpITeMGACI
 /IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793618238; x=1794223038;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2lpX1hZD2fWugnLeq9RoMoa2M0zAlYVgOzGI5RSV3DI=;
 b=NNjY4Hjfa+NYG01nla+hF5V1zJWveUBlG0TEp0V0HB4t7DhCt54vDFC3MdSSGLeQwP
 1ZfQfkYALrVRM6PAPIxpQYWBa1ChkWt2GT8BlqmCUlWKnpalmvjizCNtN9aBq86YCkjY
 v3IXzP0crxLnwJ6Qt9TcKfegyyKSc7DEET27RqXtbmgHPUjBzgHlZZHrfYLCqdUtFuSC
 RL2gmKEhG6/J7i+joh8ezAqaLU1X3hAHmZMHRpCgHQZWAfZe7+0CSCvlsaOuGuumX9b+
 5P4sDe4ffyAUAwIUEIiFQYipRpWGY7czBNuNU8/4USk/IjV9dr6WSiycg/gARgMcDAOY
 vItQ==
X-Gm-Message-State: AFq9FYLQo64VFdzOQKmkpCkxWyeMoKt+BUmlcpcB7pLFUe/KQ0+3lRG5
 s547E6Pmjik6tFQFfUd0VP2slW0Po9wENhEwrZMTohVEKo5FVJaYiUt6qqfQ0QdyvB6Amu8zHGS
 fCPhtFf9j+LoJo5nfk8e22jmfTyWELATkpflCdy4FVbOQwgdP7EmZaPXC80n4pJ+z9kbmqHiKQD
 L6it8e9w==
X-Gm-Gg: AYBFou1h8JjiFq1xHlAf9HEe9G+1jQ20oH0o9aNF0JOzFQBSsHl7MmJzWegW8icnGHd
 bmu8bsnjnCEvmtqonEswdVl41BUSD8xmQ/nJcMeH0Ar5HE8jhwlDbIAigy71bW8BssTAp868bCa
 z06jPnwuaavCh4ItgLGu/Tmj3nLbIQUolntBDOAmA2Vl9XhFoUZhCGNJlvDPxPM3jax1iwiFl1g
 jI/681GcU5d9dtTeLDG4ClKqKN8ZG4lrplq/Z/Oeyc+H1oV1T6UbsM+yfKpD7xwpgYKdM9Y9oIH
 hxdEyq+Ip3XXC2XXBZrYL2P1QHX1FFPbLL2PNEorUz27SyQ9LU8QeouF/8+T8BSTiAUtq4N3Zq8
 rnNlI9VVeDY+4KRceiGCORAARNBsO1gk+TnGsIYRIIwkWSOqA4ypIA3OyJ0fOvGlh89NLM2kM3b
 OcZdG7K80csepS/8nthu0DTXPabPvl1HcTGcKOcjdNO/m+I0SMDpyaqTeaNS3Cv/8tB9NoQR8a3
 SGNIf8CFlgnQ7AcU3Ec3K1dUXzB2tYLcgA1Qh9fU/lK3VEgSIERwxBI2RbMVClDIVmgUdUSqCRr
 /hP5FDEFEBBWeuwO7pS1T1NlLWjfboVHWJXkfWbgI6aHbuNCkHjzw+2a2/tn5ko9Syq49qNzIQz
 guE2ieIUk0jCHIKwvEi7e48Fhu7oszI9kdaHuDKZyPNn42cE3ypYGfCQKagDQnK7tj/16g9UB3t
 0KcDpsTKHx1kxOJQ==
X-Received: by 2002:a05:600c:6285:b0:4a1:fa27:df7c with SMTP id
 5b1f17b1804b1-4ac182dc8f6mr218771095e9.34.1793618237799; 
 Mon, 02 Nov 2026 03:17:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm21852410f8f.6.2026.11.02.03.17.17
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:17:17 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:17:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
X-Gerrit-Change-Number: 2080
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2080?usp=email>
X-Gerrit-Commit: 2de62e2fe5ed7b35cfb8bc64155e9256d4b7954f
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljNWNmNWVmNzIzYTMzYWQzMDRiMDgwZWYxOWRiMmU0YTBmNGJiMmViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f23cdf760d7fae65cad2b9c90381c75b771ebc2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNq2W-000000004VT-2VlQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Clean up weak key
 check
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3384860788285791817=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3384860788285791817==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HMYU2kayTmE="; charset=UTF-8

--HMYU2kayTmE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2080?usp=3Demail )


Change subject: Clean up weak ke=
y check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Clea=
n up weak key check

These methods only check for zero keys after weak DES =
checks were removed=2E
Simplify all this to always the first 32 bytes of ke=
y and hmac and ensure
that they are not zero=2E

This now always raises a F=
ATAL alert instead of handling this error
gracefully but a all zeros keys s=
hould never ever happen=2E

Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4=
bb2eb
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/cr=
ypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/ssl=2Ec
3 files changed, 14=
 insertions(+), 57 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/80/2080/1

diff --git a/src/openvpn/crypto=2Ec b=
/src/openvpn/crypto=2Ec
index 3d3ab0c=2E=2Ec5a5c55 100644
--- a/src/openvpn=
/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1104,40 +1104,6 @@
     ctx->i=
nitialized =3D false;
 }
 
-static bool
-key_is_zero(const struct key *key,=
 const struct key_type *kt)
-{
-    size_t cipher_length =3D cipher_kt_key_=
size(kt->cipher);
-    for (size_t i =3D 0; i < cipher_length; ++i)
-    {
=
-        if (key->cipher[i])
-        {
-            return false;
-       =
 }
-    }
-    msg(D_CRYPT_ERRORS, "CRYPTO INFO: WARNING: zero key detected=
");
-    return true;
-}
-
-/*
- * Make sure that cipher key is a valid key=
 for current key_type=2E
- */
-bool
-check_key(const struct key *key, const=
 struct key_type *kt)
-{
-    if (cipher_defined(kt->cipher))
-    {
-     =
   /*
-         * Check for zero key
-         */
-        if (key_is_zero(=
key, kt))
-        {
-            return false;
-        }
-    }
-    retu=
rn true;
-}
-
 /*
  * Generate a random key=2E
  */
@@ -1307,8 +1273,8 @@
 =
            print_key_filename(key_file, key_inline));
     }
 
-    /* che=
ck for and fix highly unlikely key problems */
-    verify_fix_key2(&key2, =
key_type, key_file);
+    /* check for highly unlikely key problems */
+   =
 check_key2(&key2);
 
     /* handle key direction */
     key_direction_st=
ate_init(&kds, key_direction);
@@ -1708,18 +1674,19 @@
 }
 
 void
-verify_f=
ix_key2(struct key2 *key2, const struct key_type *kt, const char *shared_se=
cret_file)
+check_key2(struct key2 *key2)
 {
-    int i;
+    /* Check the =
first 128 bit of every key slot to be not 0=2E This is
+     * not a compre=
ssive check, but no valid key should fail this check */
 
-    for (i =3D 0=
; i < key2->n; ++i)
+    uint8_t zero_key[16] =3D { 0 };
+
+    if (memcmp(=
key2->keys[0]=2Ecipher, zero_key, sizeof(zero_key)) =3D=3D 0
+        || me=
mcmp(key2->keys[1]=2Ecipher, zero_key, sizeof(zero_key)) =3D=3D 0
+        =
|| memcmp(key2->keys[0]=2Ehmac, zero_key, sizeof(zero_key)) =3D=3D 0
+     =
   || memcmp(key2->keys[0]=2Ehmac, zero_key, sizeof(zero_key)) =3D=3D 0)
  =
   {
-        /* This should be a very improbable failure */
-        if (!=
check_key(&key2->keys[i], kt))
-        {
-            msg(M_FATAL, "Key #%=
d in '%s' is bad=2E  Try making a new key with --genkey=2E", i + 1,
-      =
          shared_secret_file);
-        }
+        msg(M_FATAL, "One key in=
 static key/generated key  is all zero=2E");
     }
 }
 
diff --git a/src/o=
penvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index e3c1c6a=2E=2Edbe0802 10064=
4
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -414,8 +414,=
6 @@
  */
 int write_key_file(const int nkeys, const char *filename);
 
-bo=
ol check_key(const struct key *key, const struct key_type *kt);
-
 /**
  * =
Initialize a key_type structure with=2E
  *
@@ -621,7 +619,7 @@
 
 void key=
_direction_state_init(struct key_direction_state *kds, int key_direction);
=
 
-void verify_fix_key2(struct key2 *key2, const struct key_type *kt, const=
 char *shared_secret_file);
+void check_key2(struct key2 *key2);
 
 void mu=
st_have_n_keys(const char *filename, const char *option, const struct key2 =
*key2, int n);
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
ind=
ex 086a6fc=2E=2Eddee3eb 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/=
ssl=2Ec
@@ -1583,15 +1583,7 @@
     key2_print(&key2, &session->opt->key_ty=
pe, "Master Encrypt", "Master Decrypt");
 
     /* check for weak keys */
-=
    for (int i =3D 0; i < 2; ++i)
-    {
-        if (!check_key(&key2=2Eke=
ys[i], &session->opt->key_type))
-        {
-            msg(D_TLS_ERRORS, =
"TLS Error: Bad dynamic key generated");
-            goto exit;
-        }=

-    }
-
+    check_key2(&key2);
     ret =3D init_key_contexts(ks, multi,=
 &session->opt->key_type, server, &key2,
                             sessi=
on->opt->dco_enabled);
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2080?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Gerrit-Change-Number: 208=
0
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--HMYU2kayTmE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Clean up weak key check<br><br>These methods only check for ze=
ro keys after weak DES checks were removed=2E<br>Simplify all this to alway=
s the first 32 bytes of key and hmac and ensure<br>that they are not zero=
=2E<br><br>This now always raises a FATAL alert instead of handling this er=
ror<br>gracefully but a all zeros keys should never ever happen=2E<br><br>C=
hange-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb<br>Signed-off-by: Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/crypto=2Ec<br>M =
src/openvpn/crypto=2Eh<br>M src/openvpn/ssl=2Ec<br>3 files changed, 14 inse=
rtions(+), 57 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/80/2080/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 3d3ab=
0c=2E=2Ec5a5c55 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><=
br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1104,40 +1104,6 @=
@</span><br><span>     ctx-&gt;initialized =3D false;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_is_zero(cons=
t struct key *key, const struct key_type *kt)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    size_t cipher_length =3D cipher_kt_key_size(kt-&gt;cipher);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &l=
t; cipher_length; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (key=
-&gt;cipher[i])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return=
 false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    msg(D_CRYPT_ERRORS, &quot;CRYPTO INFO:=
 WARNING: zero key detected&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return true;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Make sure that cipher key is a valid key for cur=
rent key_type=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-check_key(const struct key *key, const s=
truct key_type *kt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (cipher_defined=
(kt-&gt;cipher))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-         * Check for zero key</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (key_is_zero(key, kt))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> /*</span><br><span>  * Generate a random key=2E</span><br><span> =
 */</span><br><span>@@ -1307,8 +1273,8 @@</span><br><span>             prin=
t_key_filename(key_file, key_inline));</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* check for =
and fix highly unlikely key problems */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    verify_fix_key2(&amp;key2, key_type, key_file);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check for highly u=
nlikely key problems */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    check_key2(&amp;key2);</span><br><span> </span><br><span>     /* ha=
ndle key direction */</span><br><span>     key_direction_state_init(&amp;kd=
s, key_direction);</span><br><span>@@ -1708,18 +1674,19 @@</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-verify_fix_key2(struct key2 *key2, const struct key_ty=
pe *kt, const char *shared_secret_file)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+check_key2(struct key2 *key2)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Check the first 128 bit of eve=
ry key slot to be not 0=2E This is</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * not a compressive check, but no valid key should fail=
 this check */</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    for (i =3D 0; i &lt; key2-&gt;n; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t zero_key[16] =3D { 0 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (memcmp(key2-&gt;keys[0]=2Ecipher, ze=
ro_key, sizeof(zero_key)) =3D=3D 0</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        || memcmp(key2-&gt;keys[1]=2Ecipher, zero_key, sizeo=
f(zero_key)) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        || memcmp(key2-&gt;keys[0]=2Ehmac, zero_key, sizeof(zero_key)) =
=3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || =
memcmp(key2-&gt;keys[0]=2Ehmac, zero_key, sizeof(zero_key)) =3D=3D 0)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* This should be a very improbable failure */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (!check_key(&amp;key2-&gt;keys[i], =
kt))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quo=
t;Key #%d in &#39;%s&#39; is bad=2E  Try making a new key with --genkey=2E&=
quot;, i + 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        shared_secret_file);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_FATAL, &quot;One key in static key/generated key  is all zero=2E=
&quot;);</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</spa=
n><br><span>index e3c1c6a=2E=2Edbe0802 100644</span><br><span>--- a/src/ope=
nvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><spa=
n>@@ -414,8 +414,6 @@</span><br><span>  */</span><br><span> int write_key_f=
ile(const int nkeys, const char *filename);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-bool check_key(const struct key *ke=
y, const struct key_type *kt);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /**</span><br><span>  * Initialize a key_type st=
ructure with=2E</span><br><span>  *</span><br><span>@@ -621,7 +619,7 @@</sp=
an><br><span> </span><br><span> void key_direction_state_init(struct key_di=
rection_state *kds, int key_direction);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void verify_fix_key2(struct key2 *key2,=
 const struct key_type *kt, const char *shared_secret_file);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void check_key2(struct key2 *key2)=
;</span><br><span> </span><br><span> void must_have_n_keys(const char *file=
name, const char *option, const struct key2 *key2, int n);</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</s=
pan><br><span>index 086a6fc=2E=2Eddee3eb 100644</span><br><span>--- a/src/o=
penvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@=
 -1583,15 +1583,7 @@</span><br><span>     key2_print(&amp;key2, &amp;sessio=
n-&gt;opt-&gt;key_type, &quot;Master Encrypt&quot;, &quot;Master Decrypt&qu=
ot;);</span><br><span> </span><br><span>     /* check for weak keys */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &l=
t; 2; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!check_key(&amp=
;key2=2Ekeys[i], &amp;session-&gt;opt-&gt;key_type))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &quot;TLS Error: Bad dyna=
mic key generated&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            goto exit;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_key2(&amp;key2);</span><br><spa=
n>     ret =3D init_key_contexts(ks, multi, &amp;session-&gt;opt-&gt;key_ty=
pe, server, &amp;key2,</span><br><span>                             session=
-&gt;opt-&gt;dco_enabled);</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">change 2080</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic5c=
f5ef723a33ad304b080ef19db2e4a0f4bb2eb </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2080 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--HMYU2kayTmE=--


--===============3384860788285791817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3384860788285791817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3384860788285791817==--

