Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F145606A329
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PF9AcfXL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iZNiRO/B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=heW1yNC+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ThFtIHUf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AX9h7MNZKXXXFAYJD1DX4vc8UG1+9OMsNgeHWB/yDJ4=; b=PF9AcfXLP9L79oy/FKr3dLm2wU
	2opfz4+hUI2K4SJ7UElPlwAG2Sd4OqxjtQ2ocHCY18jIxk5V3Pn36Ple/7Uj/O1Isi1EB8qRchCoU
	4Ff4i4i0OYof05XNrBey0z0pQeyZRwCOCrW/hcygqSQtsKuPzCquV73/tL/twfouCePg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzwO-000000007YW-0eBn;
	Mon, 02 Nov 2026 21:51:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNzwN-000000007YP-0Dc5
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8V5DXVrZAJdzvcTcpvGodW3hLn2CHQfcbCECe7HMrFA=; b=iZNiRO/BnJXstq4Fu4V5AFJyRW
 zuI8q0PiWhB/gONzRCwm+EiqdZIg7uARNiYPKM3yWqku9nwLPrUmUwXQomXUsKaQuUuznZB5aSrGR
 Qb2cuCMN9JBiNGYG66rhobInrdf14TubjG69Dqm5PC4fXgsd6xoDyewtjKD/bXEQhqPI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8V5DXVrZAJdzvcTcpvGodW3hLn2CHQfcbCECe7HMrFA=; b=heW1yNC+dzpoQkglMMbkgz8Z1/
 KxgWEo+x8FLsNzzgdRu4UUL9Hy/hs0qjZPMpDRk6wMMsLbnBHrhrJ/21kV0cfa9ZUPYGEJI8ps5Xd
 LPocs+SEYFGjjnV5/YXholIjemQRKa+zdqbnosDW/jjcs5ME6tjpX9J+VtwwutIgk0CU=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNzwK-000000006Yz-3g3l for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:42 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso34263955e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793656294; x=1794261094; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8V5DXVrZAJdzvcTcpvGodW3hLn2CHQfcbCECe7HMrFA=;
 b=ThFtIHUfR3eyoqgQEvRGtwQyGxVreYpBzwHfv6LDFEZ9tntR3j7pXnsFQOyUPoSwB5
 ey0NHttlgIjl6ut9Zhp4TT/DttcD2oeVV3yOP8SeHWJ9rtsb9X1EHqqOwwEHvzoOcPgC
 ulfFC7lmqbO/SDao+sVcke9uY11ECFQDmVMo8HFBJ72/NIt3FGRk3urcoP2TpW/k1sSR
 l36YajpFzp0kveJIoZPsFRTajnbnDW4noJsNkp6/i1+P6qqfcccxoHTyHO/kksEtwCDR
 z0jB7PbZHbi76Bljs44yzi+NY40R/3Q9XW6VCrI3IljivbgtIXEUhzt1Af2YdZCHkShi
 cQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793656294; x=1794261094;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8V5DXVrZAJdzvcTcpvGodW3hLn2CHQfcbCECe7HMrFA=;
 b=r+CVdMElotlt/rffwUOuF+ZtgDWDyBvJKWfYku5fagENCz3c2TI1SUvJk0q7eER/8Z
 6plICysRXVW4YmTIVqHGgQUsZWHk7Enei+FnPx3/Xe9b5AsOMdG1BGpI6/d7iOHpJNQP
 /WO1m/24OUjf59ROGSj09OtFB4iq12jfQB1U7HPmBDply4dioXMr12JJExkrYIk2wNAA
 CBjDLKBVrXEMEhRhAIngT6o4ivYKV/vtx7MIC8VBuyJjL0u2icioM6kucMnzA3VIsmg7
 J8ZCpY7HgJ2xPfV1e6bec3yj3eOAhOWyqL7OjMgVP89ZldyvtnCry7kylobCrASCiUNQ
 4ReA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHw1TrnxWiNDVLNJ6u0qRHzxJVwsmY4Xy21UmIW6URKABy+a3vkXe2Nmv5AteOoBehIfLSx/KV8csebCA8@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJnKy/Ezg01meSUSFh1CG4whquS63e/Z9PGHnuScVi1p9q0kTFB
 NY9Df5zdG4oNmU1Lb8K0RJR1bK7THqDU4X5095Fkpr8SU734Snj7fM03IwPnhOq0MX5jEFeVi4G
 U2Iy5HUcTyiGs7nGlcqAHmDpVossVYcEw/2dx+TL8b+sXxtm/Sl1G1c7pUls8moTU2JJB
X-Gm-Gg: AYBFou1bsvsTjokDbb9qgHx2DKrVl+s2axKKqytqokwklgu1aKpLHdv6LQ1xJ1WGsqi
 6xesksqM4Ifsfx9OfpPFwwZQbVyJnvY8bslR0fT6DglMtofp0C3g9rL36TKnWo/LHWW6JXWlhQj
 hS69LmTSymx4DguOAKR39lONdbGdR0JwA+aOarIyNOCpZTwcyUXRJRfBcyT1wC0AzoY1vPG9jTu
 WgfWg2Mp8E+/HcBu1Gm1fBMsAmSHsVXc/7UsmRNznvaWKSRjMvBRRycyTnM8E8thFwYmn3fzskG
 PoD3TUM9wt05EBKgolUNZtt2mFCpBdpC7HI/ZkW228FifbEfKEeRxm84/vrWLJ1i3yQUyOdRPga
 F/TIMUPlDc8W/SlWLMkAwitlU+dqkcEJsRSfswCGZmQ445NTdyyneFINRO+cV3g12vhZeci899W
 tnEYQadNU7QXn9RFivyNj7Udwk41bEt+ohcS+950SSOkKCVp0oqymTcON6xKIXnRRwJAKTReSY9
 qdP+g5lty8/cgmgS9uGmLowvwwtfa2vyaqrC3K/Bklx1mT9+SDkIIZqxfp7121KVRmobrYoJX8B
 Q1G/IYgVw38SoJcTL7i+XnsN3TUoH/NwezOJ62DmGmcy+7kOs3Hhc+W2KOqW0/DHyVPP5aSkgYC
 zQqIN+IXXvnl/esQ6/sFGb52jRvcFQs0FtNr48krVAyWS42zUJRk3mGHREksnrtAa10jL863CFq
 am6mBR2qYWlBCfqg==
X-Received: by 2002:a05:600c:524c:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4ac17470f97mr266216495e9.10.1793656294183; 
 Mon, 02 Nov 2026 13:51:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abebe33e79sm219238055e9.2.2026.11.02.13.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:51:33 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 21:51:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
X-Gerrit-Change-Number: 2080
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2080?usp=email>
X-Gerrit-Commit: b6cfa6924986c5371097b09034e25878a1868ee4
In-Reply-To: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljNWNmNWVmNzIzYTMzYWQzMDRiMDgwZWYxOWRiMmU0YTBmNGJiMmViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bee2edea1707aa521d38bdde39605a1e65349868-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNzwK-000000006Yz-3g3l
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
Content-Type: multipart/mixed; boundary="===============4600986550729008307=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4600986550729008307==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LHD0uojUyhA="; charset=UTF-8

--LHD0uojUyhA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2080?usp=3Demail )

Change subject: Clean up weak key check
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Clean up weak ke=
y check

These methods only check for zero keys after weak DES checks were =
removed=2E
Simplify all this to always the first 32 bytes of key and hmac a=
nd ensure
that they are not zero=2E

This now always raises a FATAL alert i=
nstead of handling this error
gracefully but a all zeros keys should never =
ever happen=2E

Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Signed=
-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Steffan Karger <steffa=
n@karger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080
=
Message-Id: <20261102134915=2E26599-1-gert@greenie=2Emuc=2Ede>
URL: https:/=
/lore=2Ekernel=2Eorg/openvpn-devel/20261102134915=2E26599-1-gert@greenie=2E=
muc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/op=
envpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/ssl=2Ec
3 files cha=
nged, 14 insertions(+), 57 deletions(-)




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
merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic5c=
f5ef723a33ad304b080ef19db2e4a0f4bb2eb
Gerrit-Change-Number: 2080
Gerrit-Pat=
chSet: 4
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Steffan=
 Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--LHD0uojUyhA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2080?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Clean up weak key check<br><br>The=
se methods only check for zero keys after weak DES checks were removed=2E<b=
r>Simplify all this to always the first 32 bytes of key and hmac and ensure=
<br>that they are not zero=2E<br><br>This now always raises a FATAL alert i=
nstead of handling this error<br>gracefully but a all zeros keys should nev=
er ever happen=2E<br><br>Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2=
eb<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: S=
teffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2080<br>Message-Id: &lt;20261102134915=2E26599-1-g=
ert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-deve=
l/20261102134915=2E26599-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/crypto=2Ec<b=
r>M src/openvpn/crypto=2Eh<br>M src/openvpn/ssl=2Ec<br>3 files changed, 14 =
insertions(+), 57 deletions(-)<br><br></pre>
<pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cr=
ypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 3d3ab0c=2E=2Eff17b2=
2 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b=
/src/openvpn/crypto=2Ec</span><br><span>@@ -1104,40 +1104,6 @@</span><br><s=
pan>     ctx-&gt;initialized =3D false;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-key_is_zero(const struct key *=
key, const struct key_type *kt)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t=
 cipher_length =3D cipher_kt_key_size(kt-&gt;cipher);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; cipher_leng=
th; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (key-&gt;cipher[i]=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            return false;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    msg(D_CRYPT_ERRORS, &quot;CRYPTO INFO: WARNING: zero=
 key detected&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Make sure that cipher key is a valid key for current key_type=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-check_key(const struct key *key, const struct key_typ=
e *kt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (cipher_defined(kt-&gt;ciphe=
r))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * Check for zero key</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (key_is_zero(key, kt))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 /*</span><br><span>  * Generate a random key=2E</span><br><span>  */</span=
><br><span>@@ -1307,8 +1273,8 @@</span><br><span>             print_key_fil=
ename(key_file, key_inline));</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* check for and fix h=
ighly unlikely key problems */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    verify_fix_key2(&amp;key2, key_type, key_file);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* check for highly unlikely k=
ey problems */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
heck_key2(&amp;key2);</span><br><span> </span><br><span>     /* handle key =
direction */</span><br><span>     key_direction_state_init(&amp;kds, key_di=
rection);</span><br><span>@@ -1708,18 +1674,19 @@</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-verify_fix_key2(struct key2 *key2, const struct key_type *kt, c=
onst char *shared_secret_file)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+check_key2(struct key2 *key2)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Check the first 128 bit of every key sl=
ot to be not 0=2E This is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * not a comprehensive check, but no valid key should fail this c=
heck */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    for (i =3D 0; i &lt; key2-&gt;n; ++i)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t zero_key[16] =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (memcmp_constant_time(key2-&gt;keys[0]=2Eciph=
er, zero_key, sizeof(zero_key)) =3D=3D 0</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        || memcmp_constant_time(key2-&gt;keys[1]=2Ecip=
her, zero_key, sizeof(zero_key)) =3D=3D 0</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        || memcmp_constant_time(key2-&gt;keys[0]=2Ehm=
ac, zero_key, sizeof(zero_key)) =3D=3D 0</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        || memcmp_constant_time(key2-&gt;keys[1]=2Ehma=
c, zero_key, sizeof(zero_key)) =3D=3D 0)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* This should be a very =
improbable failure */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (!check_key(&amp;key2-&gt;keys[i], kt))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(M_FATAL, &quot;Key #%d in &#39;%s&#39; is =
bad=2E  Try making a new key with --genkey=2E&quot;, i + 1,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                shared_secret_file);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;One k=
ey in static key/generated key  is all zero=2E&quot;);</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/op=
envpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>index e3c1c6a=2E=
=2Edbe0802 100644</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><s=
pan>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -414,8 +414,6 @@</span>=
<br><span>  */</span><br><span> int write_key_file(const int nkeys, const c=
har *filename);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bool check_key(const struct key *key, const struct key_type *kt=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /=
**</span><br><span>  * Initialize a key_type structure with=2E</span><br><s=
pan>  *</span><br><span>@@ -621,7 +619,7 @@</span><br><span> </span><br><sp=
an> void key_direction_state_init(struct key_direction_state *kds, int key_=
direction);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-void verify_fix_key2(struct key2 *key2, const struct key_type *kt, =
const char *shared_secret_file);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void check_key2(struct key2 *key2);</span><br><span> </span><b=
r><span> void must_have_n_keys(const char *filename, const char *option, co=
nst struct key2 *key2, int n);</span><br><span> </span><br><span>diff --git=
 a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=
=2E=2Eddee3eb 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1583,15 +1583,7 @@</span>=
<br><span>     key2_print(&amp;key2, &amp;session-&gt;opt-&gt;key_type, &qu=
ot;Master Encrypt&quot;, &quot;Master Decrypt&quot;);</span><br><span> </sp=
an><br><span>     /* check for weak keys */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; 2; ++i)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!check_key(&amp;key2=2Ekeys[i], &amp;sessi=
on-&gt;opt-&gt;key_type))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(D_TLS_ERRORS, &quot;TLS Error: Bad dynamic key generated&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto exit;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    check_key2(&amp;key2);</span><br><span>     ret =3D init_key_conte=
xts(ks, multi, &amp;session-&gt;opt-&gt;key_type, server, &amp;key2,</span>=
<br><span>                             session-&gt;opt-&gt;dco_enabled);</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2080?usp=3Demail">change 2080</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2080?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb=
2eb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2080 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--LHD0uojUyhA=--


--===============4600986550729008307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4600986550729008307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4600986550729008307==--

