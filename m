Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E6606A329
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G6Y8SNrK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WCEDsILr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a5qKCF8d;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KCIQysWB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UASQXuViHtlU5BUWcRRQYpqHCES9RlbAG5qtLQxneAU=; b=G6Y8SNrKRoMxI733uIp6+Ud/nU
	YGJCJ8y0ocVqLbOlbTlf/vy01CLRsD/PbjmO12zdmGjAITQ0/WeikXsjsNz9POw0MPGf5bIQcpmmQ
	xOWHDKnz91kER0AvVZ8rcmg1XI8KHDj1LLLt+fm8CWKzXjXUF8MluhK/xxT8y/c+Tiio=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzwM-000000001E7-408I;
	Mon, 02 Nov 2026 21:51:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNzwL-000000001E0-3Qsi
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eoFffJ4Ck0sWBaoHXAWThSktehwLv6zz67tVzOWsUhw=; b=WCEDsILrJQcgVJ+8ZZ2biCQsxC
 uiH5KUBTQ/HFsRlt5tKFEygjYw+M/EOs6+br9AKJh2Ysy26h2TNe6g0CX6MbuzsA7iFaR2LJtaWGa
 mSb0VdT5FDHhaS/CeC20yHrbRINzSno8plrIvEP3hfvJP7QA7H9+ytIIkMvUG0PC/qJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eoFffJ4Ck0sWBaoHXAWThSktehwLv6zz67tVzOWsUhw=; b=a5qKCF8d3TaWved1nWRx7arUP6
 cj6h791vwQkt7q3GKRYjh6tk9fu/NYmsMm2hmNqgRBst1O94g/3kvln2GRwvJpVPBD2AbK/8ukvQm
 +roA1SNtrgBOrSt3yl7U8l8cJHWL/U1pKAc2c2krXqjy5SKSscNQV1KRZdLyBpd+pteU=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNzwK-000000006Aq-0aWR for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:41 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso35303275e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793656293; x=1794261093; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eoFffJ4Ck0sWBaoHXAWThSktehwLv6zz67tVzOWsUhw=;
 b=KCIQysWBx0ZUVkzQRprbLtHIcPDW98Ha4FMHbMiXL+f0vZD3syqQET93EtEuHh8aEL
 siEIs7RwRKn/jcCGX2iIo1EKlHYLxqDiipfsfLAuFTtfAHJEnCnUYsuu5T0qwRB/M/6h
 5Eh4PUrUHH0zq42+dgZ+V5W6aT/gaEteiWuIRBqbbU7Rq4CmlvJ9ECnbGgJQNe7x05oR
 ffhkw5JFck/caSnxhl75iHQEBapSoDFIPV7O7LZ3LlWbdCD/6hjF7eWHYXlnTUE4GisI
 gtEvnGmD10ibtoNQWqbopDp+YFwypch/p9DNwrIgI9k0D7o9V8NhdIeboMb1QCh851L7
 2Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793656293; x=1794261093;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eoFffJ4Ck0sWBaoHXAWThSktehwLv6zz67tVzOWsUhw=;
 b=SJs1+0TCX6uRUQWa8aNLyX6xaBeXOF255a3v47B7gIPP0QYtHcoMAyMD1HQk3wILGb
 VymlRQy9fptbRljQc6kvbRG4bWan2DFcLBgsMIO9MZKvDhJIgMiO/13yOsZqQh7ivg1j
 b0plstdUO0E6W3rCJKEIv2HtAUobO+7hF7T2mWKi9iN/X/a7wngc6+cY01KJCT2lpwy2
 wM6RazsyXZ7eJUXAaTYr365PS3V5g1ilAI66HsGCIyiCGfv6A/0T3QkRTyoBSjXfZS8J
 zyIpflhoc0GXMMXWxi9eTgCvdZz00YHmATLi//sTmxOqFmKRbxGx6wI8J5VeVDW0eTOW
 fOJg==
X-Gm-Message-State: AFq9FYI0zbodqQ2RQ9kMKMn573BucQOnT8taBz7vdaNrG30ksmv4zmKP
 y5AruPGKeGa9MMmaItGczKwQUZZEm81dJxah/Apg83COsWWMuA7AJynLzXhINdgDs07G8kxRM5Y
 LsFVMtqJlp9VKHgbgoCZW630vEqm7BErKDzqSwCch06mYeq/dG3arAv74hpW+AuGiQsJdQ6CMRk
 UKEylLWQ==
X-Gm-Gg: AYBFou21Wx5e42wT2Dw64zxSHKKk5DAi6IjwEXUC8K67qrS36WuqMSHeDnaIrwJDRyF
 A7pXLoiMxJcBE9nRb7q9JcUbHk2HClMcjN8TezAGaDL5lHFE8fefHB0Ft2n3yhAmoH2SMBtY+V+
 mPHv0z5Pi+Qh9kSCm9QVxP4b4eYVm6o6P2KyX8GD8vXtn5UBu0PbSp0+sKiETIfPNypOEvIblBV
 w7y9d/4sRVKL73OhOsXhWVsgyjoxs8yVOIuDk9G5GqPhaGmlYc3lfUFNq0JUP+0Rx1G/J+0IdQj
 lop/7UNwDMk/LqIUhHpbCdwVdabakdfuL1IbgqxSI7kFXqRjKGuiflvtI5a4haiImF0fFqCIALX
 dzs9mQgJ4pctf75gjd7toNTUO0zrfFSX0Gwd6Jxy4ihD+hGVfM7f5mSX+JQJWGcxbRK2cZR9pQa
 9LAfdRthBsaOCGJBeMUt1z1kGhNL0RXRYlnfFwVKOmtI8jTclrVNGJyA+KzDcsTRF4l9MNxXpOB
 SpED36VGBX0u3Z8JI0NuiZSVtrY03V8+tEetmsihNt+a/x/iKw98X4Nj/v+7zT5Pj0G8TO1cmij
 wjRqPtabHyDK+FrKGBSy+AHNqSvuzgE+htaXswtJzbYqJAkrvrtjvlEcnr3WbtgqupYSkUiDZTv
 bKJGrSAmycvgHmuvjkRn7OP0eqqCeik+Oh5GS/xrWn2czew4KfItix4t+voD1zoj9qjbm05KSxC
 uDTJEhv67sj48sRQ==
X-Received: by 2002:a05:600c:4e8c:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4ac1793ff26mr256855975e9.15.1793656293396; 
 Mon, 02 Nov 2026 13:51:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cebc1sm19772955e9.1.2026.11.02.13.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:51:32 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 21:51:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Steffan Karger <steffan@karger.me>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
X-Gerrit-Change-Number: 2080
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2080?usp=email>
X-Gerrit-Commit: b6cfa6924986c5371097b09034e25878a1868ee4
In-Reply-To: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljNWNmNWVmNzIzYTMzYWQzMDRiMDgwZWYxOWRiMmU0YTBmNGJiMmViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bee2edea1707aa521d38bdde39605a1e65349868-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNzwK-000000006Aq-0aWR
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7639823005113053777=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7639823005113053777==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fWEUP3ROGAo="; charset=UTF-8

--fWEUP3ROGAo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Steffan Karger


Change subject: Clean up weak key check
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Clean up weak key c=
heck

These methods only check for zero keys after weak DES checks were rem=
oved=2E
Simplify all this to always the first 32 bytes of key and hmac and =
ensure
that they are not zero=2E

This now always raises a FATAL alert inst=
ead of handling this error
gracefully but a all zeros keys should never eve=
r happen=2E

Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Signed-of=
f-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Steffan Karger <steffan@k=
arger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080
Mes=
sage-Id: <20261102134915=2E26599-1-gert@greenie=2Emuc=2Ede>
URL: https://lo=
re=2Ekernel=2Eorg/openvpn-devel/20261102134915=2E26599-1-gert@greenie=2Emuc=
=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openv=
pn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/ssl=2Ec
3 files change=
d, 14 insertions(+), 57 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/80/2080/4

diff --git a/src/openvpn/crypto=
=2Ec b/src/openvpn/crypto=2Ec
index 3d3ab0c=2E=2Eff17b22 100644
--- a/src/o=
penvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1104,40 +1104,6 @@
     =
ctx->initialized =3D false;
 }
 
-static bool
-key_is_zero(const struct key=
 *key, const struct key_type *kt)
-{
-    size_t cipher_length =3D cipher_k=
t_key_size(kt->cipher);
-    for (size_t i =3D 0; i < cipher_length; ++i)
-=
    {
-        if (key->cipher[i])
-        {
-            return false;
- =
       }
-    }
-    msg(D_CRYPT_ERRORS, "CRYPTO INFO: WARNING: zero key de=
tected");
-    return true;
-}
-
-/*
- * Make sure that cipher key is a val=
id key for current key_type=2E
- */
-bool
-check_key(const struct key *key,=
 const struct key_type *kt)
-{
-    if (cipher_defined(kt->cipher))
-    {
=
-        /*
-         * Check for zero key
-         */
-        if (key_is=
_zero(key, kt))
-        {
-            return false;
-        }
-    }
-  =
  return true;
-}
-
 /*
  * Generate a random key=2E
  */
@@ -1307,8 +1273,=
8 @@
             print_key_filename(key_file, key_inline));
     }
 
-    =
/* check for and fix highly unlikely key problems */
-    verify_fix_key2(&=
key2, key_type, key_file);
+    /* check for highly unlikely key problems *=
/
+    check_key2(&key2);
 
     /* handle key direction */
     key_direct=
ion_state_init(&kds, key_direction);
@@ -1708,18 +1674,19 @@
 }
 
 void
-ve=
rify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *sha=
red_secret_file)
+check_key2(struct key2 *key2)
 {
-    int i;
+    /* Chec=
k the first 128 bit of every key slot to be not 0=2E This is
+     * not a =
comprehensive check, but no valid key should fail this check */
 
-    for =
(i =3D 0; i < key2->n; ++i)
+    uint8_t zero_key[16] =3D { 0 };
+
+    if =
(memcmp_constant_time(key2->keys[0]=2Ecipher, zero_key, sizeof(zero_key)) =
=3D=3D 0
+        || memcmp_constant_time(key2->keys[1]=2Ecipher, zero_key,=
 sizeof(zero_key)) =3D=3D 0
+        || memcmp_constant_time(key2->keys[0]=
=2Ehmac, zero_key, sizeof(zero_key)) =3D=3D 0
+        || memcmp_constant_t=
ime(key2->keys[1]=2Ehmac, zero_key, sizeof(zero_key)) =3D=3D 0)
     {
-   =
     /* This should be a very improbable failure */
-        if (!check_key=
(&key2->keys[i], kt))
-        {
-            msg(M_FATAL, "Key #%d in '%s'=
 is bad=2E  Try making a new key with --genkey=2E", i + 1,
-               =
 shared_secret_file);
-        }
+        msg(M_FATAL, "One key in static k=
ey/generated key  is all zero=2E");
     }
 }
 
diff --git a/src/openvpn/cr=
ypto=2Eh b/src/openvpn/crypto=2Eh
index e3c1c6a=2E=2Edbe0802 100644
--- a/s=
rc/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -414,8 +414,6 @@
  */=

 int write_key_file(const int nkeys, const char *filename);
 
-bool check_=
key(const struct key *key, const struct key_type *kt);
-
 /**
  * Initializ=
e a key_type structure with=2E
  *
@@ -621,7 +619,7 @@
 
 void key_directio=
n_state_init(struct key_direction_state *kds, int key_direction);
 
-void v=
erify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *sh=
ared_secret_file);
+void check_key2(struct key2 *key2);
 
 void must_have_n=
_keys(const char *filename, const char *option, const struct key2 *key2, in=
t n);
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 086a6f=
c=2E=2Eddee3eb 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@=
@ -1583,15 +1583,7 @@
     key2_print(&key2, &session->opt->key_type, "Mast=
er Encrypt", "Master Decrypt");
 
     /* check for weak keys */
-    for (=
int i =3D 0; i < 2; ++i)
-    {
-        if (!check_key(&key2=2Ekeys[i], &s=
ession->opt->key_type))
-        {
-            msg(D_TLS_ERRORS, "TLS Erro=
r: Bad dynamic key generated");
-            goto exit;
-        }
-    }
-=

+    check_key2(&key2);
     ret =3D init_key_contexts(ks, multi, &session=
->opt->key_type, server, &key2,
                             session->opt->=
dco_enabled);
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2080?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Gerrit-Change-Number: 2080
Gerri=
t-PatchSet: 4
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: St=
effan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--fWEUP3ROGAo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/208=
0?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">Clean up =
weak key check<br><br>These methods only check for zero keys after weak DES=
 checks were removed=2E<br>Simplify all this to always the first 32 bytes o=
f key and hmac and ensure<br>that they are not zero=2E<br><br>This now alwa=
ys raises a FATAL alert instead of handling this error<br>gracefully but a =
all zeros keys should never ever happen=2E<br><br>Change-Id: Ic5cf5ef723a33=
ad304b080ef19db2e4a0f4bb2eb<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080<br>Message-Id: &lt;2=
0261102134915=2E26599-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2E=
kernel=2Eorg/openvpn-devel/20261102134915=2E26599-1-gert@greenie=2Emuc=2Ede=
<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M=
 src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/ssl=2E=
c<br>3 files changed, 14 insertions(+), 57 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/80=
/2080/4</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2E=
c</span><br><span>index 3d3ab0c=2E=2Eff17b22 100644</span><br><span>--- a/s=
rc/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><b=
r><span>@@ -1104,40 +1104,6 @@</span><br><span>     ctx-&gt;initialized =3D=
 false;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-key_is_zero(const struct key *key, const struct key_type *kt)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    size_t cipher_length =3D cipher_kt_key=
_size(kt-&gt;cipher);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (size_t i =3D 0; i &lt; cipher_length; ++i)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (key-&gt;cipher[i])</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            return false;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_C=
RYPT_ERRORS, &quot;CRYPTO INFO: WARNING: zero key detected&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Make sure that ci=
pher key is a valid key for current key_type=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_key=
(const struct key *key, const struct key_type *kt)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (cipher_defined(kt-&gt;cipher))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * Check for zero key</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (key_is_zero(key, kt))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Generate a =
random key=2E</span><br><span>  */</span><br><span>@@ -1307,8 +1273,8 @@</s=
pan><br><span>             print_key_filename(key_file, key_inline));</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* check for and fix highly unlikely key problems */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    verify_fix_key2(&amp;k=
ey2, key_type, key_file);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* check for highly unlikely key problems */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    check_key2(&amp;key2);</span><br><sp=
an> </span><br><span>     /* handle key direction */</span><br><span>     k=
ey_direction_state_init(&amp;kds, key_direction);</span><br><span>@@ -1708,=
18 +1674,19 @@</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-verify_fix_key2(struct =
key2 *key2, const struct key_type *kt, const char *shared_secret_file)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+check_key2(struct key2 *=
key2)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 Check the first 128 bit of every key slot to be not 0=2E This is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * not a comprehensive ch=
eck, but no valid key should fail this check */</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; key2-&=
gt;n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8=
_t zero_key[16] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (memc=
mp_constant_time(key2-&gt;keys[0]=2Ecipher, zero_key, sizeof(zero_key)) =3D=
=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || mem=
cmp_constant_time(key2-&gt;keys[1]=2Ecipher, zero_key, sizeof(zero_key)) =
=3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || =
memcmp_constant_time(key2-&gt;keys[0]=2Ehmac, zero_key, sizeof(zero_key)) =
=3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || =
memcmp_constant_time(key2-&gt;keys[1]=2Ehmac, zero_key, sizeof(zero_key)) =
=3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* This should be a very improbable failure */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (!check_key(&amp;key=
2-&gt;keys[i], kt))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(M_FATAL, &quot;Key #%d in &#39;%s&#39; is bad=2E  Try making a new key wi=
th --genkey=2E&quot;, i + 1,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                shared_secret_file);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_FATAL, &quot;One key in static key/generated key =
 is all zero=2E&quot;);</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/=
crypto=2Eh</span><br><span>index e3c1c6a=2E=2Edbe0802 100644</span><br><spa=
n>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh=
</span><br><span>@@ -414,8 +414,6 @@</span><br><span>  */</span><br><span> =
int write_key_file(const int nkeys, const char *filename);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_key(const=
 struct key *key, const struct key_type *kt);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Initializ=
e a key_type structure with=2E</span><br><span>  *</span><br><span>@@ -621,=
7 +619,7 @@</span><br><span> </span><br><span> void key_direction_state_ini=
t(struct key_direction_state *kds, int key_direction);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void verify_fix_key2(str=
uct key2 *key2, const struct key_type *kt, const char *shared_secret_file);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void check_key2(str=
uct key2 *key2);</span><br><span> </span><br><span> void must_have_n_keys(c=
onst char *filename, const char *option, const struct key2 *key2, int n);</=
span><br><span> </span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/ope=
nvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2Eddee3eb 100644</span><br><s=
pan>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</sp=
an><br><span>@@ -1583,15 +1583,7 @@</span><br><span>     key2_print(&amp;ke=
y2, &amp;session-&gt;opt-&gt;key_type, &quot;Master Encrypt&quot;, &quot;Ma=
ster Decrypt&quot;);</span><br><span> </span><br><span>     /* check for we=
ak keys */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (in=
t i =3D 0; i &lt; 2; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
!check_key(&amp;key2=2Ekeys[i], &amp;session-&gt;opt-&gt;key_type))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &quot;TLS E=
rror: Bad dynamic key generated&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            goto exit;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    check_key2(&amp;key2);</=
span><br><span>     ret =3D init_key_contexts(ks, multi, &amp;session-&gt;o=
pt-&gt;key_type, server, &amp;key2,</span><br><span>                       =
      session-&gt;opt-&gt;dco_enabled);</span><br></pre><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">chan=
ge 2080</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2080 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@k=
arger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--fWEUP3ROGAo=--


--===============7639823005113053777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7639823005113053777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7639823005113053777==--

