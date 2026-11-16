Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75734606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZehbcqIT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N0wCTsV2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Xl8BrUa7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NPJulDhP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pN1LZ6+HZwGiPAq/lngiI/UEZvh7EHJtCixxCpKJMLI=; b=ZehbcqITTtJo/0wVrKyRDiKXz3
	uPQClRJIjwpKjX0TAFU4Y+x6CeKgqsssNERUAHOBRRkWHSoK4ftf1Rqro8EiEs9OYaUxIi7Z/NGhO
	delC7EI2qRDHGzr7rkrM2o2p/ukepvXwuJdmOlA49CFIuvdlcVRipWNJZS0Y0K7xxGZo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0kd-000000001GL-0knB;
	Mon, 16 Nov 2026 17:44:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT0kb-000000001GE-1Y1U
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:44:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6k8gq8jNx1HduJIKy6wvUhuvFqapp0jZLJh6l7rbwog=; b=N0wCTsV244xMLVNFHAqn6dm/Eg
 2XnqdK7EP8NmAWjeyP5Xtrx35jaVVkkLuObmKiAwdKhfzONtuvLXLH3jAtOe835l2TYauKGtuL52y
 Ge7FtNmi8fo3gx1RHtUpIS39DWhwJjfXrXDM+ZlIRlEfE32/+I1QlJGfcTTpMY9p31S0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6k8gq8jNx1HduJIKy6wvUhuvFqapp0jZLJh6l7rbwog=; b=Xl8BrUa78nt8s6CNVmvvgNtQTn
 7Qc0tC9Lc4YlLL3IUNYxY0vJjHV7bHKA4zfnouhk6wLx9AFNHoCUGKR6NhMEN6dlt5HRgJTm/vc/U
 WWpBtfOzMq2gQlN5Jf3bvkFPGmKJJgozbyXv7J2ZGMlKPxHEnCm/15QnLDOiV8iZFBKs=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT0kX-000000005DA-1uFR for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:44:17 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so437025e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 09:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794851047; x=1795455847; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6k8gq8jNx1HduJIKy6wvUhuvFqapp0jZLJh6l7rbwog=;
 b=NPJulDhPgVs/CGvU0RDQATO05QS6DswgxGBUMb9B9FEo02fL3fiviaXCT47fI260XA
 h5t0tfmb5qQvbO5VZWipBgVg9k5f3T7qkElbJ66Vz7WaWCGXVqIC3V/6RvffZ//asmbw
 ALVa3OqKc0wMdTiB6i51CcZSgEzLEJlMawxvmqTouob+x+13b61FS9uNEvkETimGeKtu
 /PXCXrcfiljoGDGjiCI3NQmvV855LJH7kd7bn2eHGEZt5udHLK5sOr3cbDZXK4l1K9oI
 tkC/v4kNtZGkDKLubhiw8ObZuWe2oYknT6WSUFK+fD/hY7xMusZ+vj0OXBv0nHNOjUVv
 AFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794851047; x=1795455847;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6k8gq8jNx1HduJIKy6wvUhuvFqapp0jZLJh6l7rbwog=;
 b=nJe6k0qawpykKLo/Sk0RiS9pJuJNcTYfgGZlE5iw96jsLwnfhKEBXW6YExKu6sYYxn
 +v7V2GU19cMqunst6zN9MFJPAqdSrugulTxE/srd0wZT07YDFBvsTIrf+bDIoGPgo9/f
 lzYB2R80lJ6rFqnTah6WuXRyQ42UfJSXMPnukgLSpaDma1YRqphhD/xLW602Pgrv8Kal
 HBGDhVf4+cGXdYn47OYn9MVXi7s4acow7dectnRUtYDN559yLGQwDhEVPaMCFVeev2KN
 CCt8W8MvEj8yBX5NKergWtuml9gNxaSg4j867/okxWqwHa5DBLkliOrXogYVdsathJx7
 G05g==
X-Forwarded-Encrypted: i=1;
 AL+hErEy9DhDz7eE7j0vGEhUvM1nqsCOTCyYZ3Cl3wo1Ob0LvdnIIIumYqUgakVmtcZG8zYIgxp0ThIxB4+pB0jo@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/IkSVk3517xGyPi7TzIygzaafqvHEURaok1z8RCip7Ub/GeEBG
 O4zD3vssJUdSiRv0LH0CTDwduHb8spNhA92RFkKic1NALN/dQ5jJ0XS74goxF+DitxDRXVfx0DT
 rGTRdOMxBBCexHbhmNax7mRIchOrFhQue81dNR97lefhSEHs2X1rNu2T7olCsqPi0Dlxb
X-Gm-Gg: AYBFou28sUPNOsIBX4lYhuunyu1jt+svGrP75IckrJN8dBXKLez3Y1mnwHJiEZse3a7
 ORNG61VMomTi5cG4ubclSF2vv8mFCI5RpFDidGGlF/vFS8dal00eSAZDRb67Tsd2ASEMysleqf7
 fkbzaaUmcUEh38wszixOVm8yo6jNYkFk5RipcjDKssVYvemUUBqfe75nUgTxSs3BNrjRS7EdMu5
 j2zJn4KvS7XQcJMbQD0X5NlntW6c+NWZjgXVExf/c77wLi28AcxwMUwSWsWit0PiaOTpnzahfro
 OxLXcj+LH+oAVaprKba+pbztfnPwoZyISttEGeCB9jJPzG6GPqalDS3IxqPjQth7B325zo3GAJN
 Sd/0Mnr362WFPKZ4dugeTf8rG9rLzcfOpbIvrIHiRqamX/YWYLW8ZBsvopTe17BzSjQaE/7pAec
 51s35Vm9oiqXVylbKLmMtib4m5bIr3MOArv9aBKB+UJQYI+CmpsebiceHlJRpms0tjo9NzG6tPi
 x65bo8kmlEmq+sE7hXVPOVBwXA7LcKP86ewY1Yb0Z07J9Q34vhrRVgQTyfFphmmpnLQu1KLfaYN
 EnIxB3Zhqfz1ZOcAjcDaCD9S+i5dNZ5/3WTwx/AJkcbOhp1/gMOLHRIeNv6cj32SX8WO2kITepS
 x0XTDKn+urG2FEOtDxZguORJ+/gBOABcNDnqFo+54f6kJERUZee/Y6XkDJercEGh2K4Q1zIsTB3
 uA+6tc04kTNz2+ku0=
X-Received: by 2002:a05:600c:6589:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4bb783725bdmr6149735e9.4.1794851046739; 
 Mon, 16 Nov 2026 09:44:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb732a2a9csm69326735e9.3.2026.11.16.09.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:44:06 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 17:44:05 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0
X-Gerrit-Change-Number: 2199
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2199?usp=email>
X-Gerrit-Commit: 7d46ff17248908acf906134ee1e03ded831634a6
In-Reply-To: <gerrit.1794839855000.If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0@gerrit.openvpn.net>
References: <gerrit.1794839855000.If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLklmNzlkNDM1NmI1ZGE4MmMyODQ0Y2Q5ZThjNTlhMGZjNDFhZWZmM2MwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <68e359d642abddb0ce260c1980a85c53bb122066-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT0kX-000000005DA-1uFR
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_util: Switch
 get_num_elements to size_t
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
Content-Type: multipart/mixed; boundary="===============9005956907125552903=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9005956907125552903==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E6DaPCZEraY="; charset=UTF-8

--E6DaPCZEraY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2199?usp=3Demail )

Change subject: ssl_util: Switch get_num_el=
ements to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl_util: Switch get_num_elements to size_t

ALLOC_ARRAY already wants=
 size_t=2E

Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0
Signed-off=
-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2199
Message-Id: <20261116145745=2E8299-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg41458=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl=
_util=2Ec
M src/openvpn/ssl_util=2Eh
4 files changed, 6 insertions(+), 23 d=
eletions(-)




diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_=
mbedtls=2Ec
index 43bb0ff=2E=2Edc9f527 100644
--- a/src/openvpn/ssl_mbedtls=
=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -199,11 +199,6 @@
         cipher=
s);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnost=
ic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void=

 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 =
{
@@ -217,7 +212,7 @@
     ASSERT(NULL !=3D ctx);
 
     /* Get number of c=
iphers */
-    int cipher_count =3D get_num_elements(ciphers, ':');
+    si=
ze_t cipher_count =3D get_num_elements(ciphers, ':');
 
     /* Allocate an=
 array for them */
     ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, int, cipher=
_count + 1)
@@ -339,7 +334,7 @@
     struct gc_arena gc =3D gc_new();
 
   =
  /* Get number of groups and allocate an array in ctx */
-    int groups_c=
ount =3D get_num_elements(groups, ':');
+    size_t groups_count =3D get_nu=
m_elements(groups, ':');
     ALLOC_ARRAY_CLEAR(ctx->groups, uint16_t, grou=
ps_count + 1)
 
     /* Parse allowed ciphers, getting IDs */
@@ -1194,10 +=
1189,6 @@
     return 1;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
=
-#pragma GCC diagnostic pop
-#endif
-
 /* *********************************=
*****
  *
  * Information functions
diff --git a/src/openvpn/ssl_openssl=2E=
c b/src/openvpn/ssl_openssl=2Ec
index e190935=2E=2E57ef9f7 100644
--- a/src=
/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -518,11 +518,=
6 @@
 {
     ASSERT(ctx);
 #if OPENSSL_VERSION_NUMBER < 0x30000000L && !def=
ined(ENABLE_CRYPTO_WOLFSSL)
-#if defined(__GNUC__) || defined(__clang__)
-#=
pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversi=
on"
-#endif
-
     struct gc_arena gc =3D gc_new();
     /* This method cou=
ld be as easy as
      *  SSL_CTX_set1_groups_list(ctx->ctx, groups)
@@ -53=
3,7 +528,7 @@
      * Also note that the code is wrong in the presence of O=
penSSL3 providers=2E
      */
 
-    int groups_count =3D get_num_elements(=
groups, ':');
+    size_t groups_count =3D get_num_elements(groups, ':');
 =

     int *glist;
     /* Allocate an array for them */
@@ -569,9 +564,6 @@=

     }
     gc_free(&gc);
 
-#if defined(__GNUC__) || defined(__clang__)
-=
#pragma GCC diagnostic pop
-#endif
 #else  /* if OPENSSL_VERSION_NUMBER < 0=
x30000000L */
     if (!SSL_CTX_set1_groups_list(ctx->ctx, groups))
     {
=
diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 337f=
aed=2E=2E6c17fe5 100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ss=
l_util=2Ec
@@ -359,14 +359,14 @@
     return NULL;
 }
 
-int
+size_t
 get_n=
um_elements(const char *string, char delimiter)
 {
     const size_t string=
_len =3D strlen(string);
 
     ASSERT(0 !=3D string_len);
 
-    int eleme=
nt_count =3D 1;
+    size_t element_count =3D 1;
     /* Get number of ciph=
ers */
     for (size_t i =3D 0; i < string_len; i++)
     {
diff --git a/s=
rc/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 6f9f65b=2E=2Edb5e1=
7c 100644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
@@ =
-125,6 +125,6 @@
  * @param delimiter     the delimiter to count, typically=
 ':'
  * @return              occrrences of delimiter + 1
  */
-int get_num=
_elements(const char *string, char delimiter);
+size_t get_num_elements(con=
st char *string, char delimiter);
 
 #endif /* ifndef SSL_UTIL_H_ */

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If79d4356b5da82c2844cd9e8c=
59a0fc41aeff3c0
Gerrit-Change-Number: 2199
Gerrit-PatchSet: 3
Gerrit-Owner:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--E6DaPCZEraY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2199?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_util: Switch get_num_elements =
to size_t<br><br>ALLOC_ARRAY already wants size_t=2E<br><br>Change-Id: If79=
d4356b5da82c2844cd9e8c59a0fc41aeff3c0<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
99<br>Message-Id: &lt;20261116145745=2E8299-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41458=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ope=
nssl=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh<br>4 f=
iles changed, 6 insertions(+), 23 deletions(-)<br><br></pre>
<pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span=
>index 43bb0ff=2E=2Edc9f527 100644</span><br><span>--- a/src/openvpn/ssl_mb=
edtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span=
>@@ -199,11 +199,6 @@</span><br><span>         ciphers);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conver=
sion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</sp=
an><br><span> tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char=
 *ciphers)</span><br><span> {</span><br><span>@@ -217,7 +212,7 @@</span><br=
><span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><br><span>     /=
* Get number of ciphers */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int cipher_count =3D get_num_elements(ciphers, &#39;:&#39;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t cipher_count =
=3D get_num_elements(ciphers, &#39;:&#39;);</span><br><span> </span><br><sp=
an>     /* Allocate an array for them */</span><br><span>     ALLOC_ARRAY_C=
LEAR(ctx-&gt;allowed_ciphers, int, cipher_count + 1)</span><br><span>@@ -33=
9,7 +334,7 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span> </span><br><span>     /* Get number of groups and allocate an arr=
ay in ctx */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int g=
roups_count =3D get_num_elements(groups, &#39;:&#39;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    size_t groups_count =3D get_num_elem=
ents(groups, &#39;:&#39;);</span><br><span>     ALLOC_ARRAY_CLEAR(ctx-&gt;g=
roups, uint16_t, groups_count + 1)</span><br><span> </span><br><span>     /=
* Parse allowed ciphers, getting IDs */</span><br><span>@@ -1194,10 +1189,6=
 @@</span><br><span>     return 1;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> /* **************************************</span><br><span>  *</span><b=
r><span>  * Information functions</span><br><span>diff --git a/src/openvpn/=
ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index e190935=
=2E=2E57ef9f7 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -518,11 +5=
18,6 @@</span><br><span> {</span><br><span>     ASSERT(ctx);</span><br><spa=
n> #if OPENSSL_VERSION_NUMBER &lt; 0x30000000L &amp;&amp; !defined(ENABLE_C=
RYPTO_WOLFSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span>     /* This method could be as ea=
sy as</span><br><span>      *  SSL_CTX_set1_groups_list(ctx-&gt;ctx, groups=
)</span><br><span>@@ -533,7 +528,7 @@</span><br><span>      * Also note tha=
t the code is wrong in the presence of OpenSSL3 providers=2E</span><br><spa=
n>      */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int groups_count =3D get_num_elements(groups, &#39;:&#39;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t groups_count =
=3D get_num_elements(groups, &#39;:&#39;);</span><br><span> </span><br><spa=
n>     int *glist;</span><br><span>     /* Allocate an array for them */</s=
pan><br><span>@@ -569,9 +564,6 @@</span><br><span>     }</span><br><span>  =
   gc_free(&amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> #else  =
/* if OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span>     if (!=
SSL_CTX_set1_groups_list(ctx-&gt;ctx, groups))</span><br><span>     {</span=
><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec=
</span><br><span>index 337faed=2E=2E6c17fe5 100644</span><br><span>--- a/sr=
c/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=2Ec</span=
><br><span>@@ -359,14 +359,14 @@</span><br><span>     return NULL;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</s=
pan><br><span> get_num_elements(const char *string, char delimiter)</span><=
br><span> {</span><br><span>     const size_t string_len =3D strlen(string)=
;</span><br><span> </span><br><span>     ASSERT(0 !=3D string_len);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ele=
ment_count =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size_t element_count =3D 1;</span><br><span>     /* Get number of ciphers=
 */</span><br><span>     for (size_t i =3D 0; i &lt; string_len; i++)</span=
><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl_util=2Eh b/s=
rc/openvpn/ssl_util=2Eh</span><br><span>index 6f9f65b=2E=2Edb5e17c 100644</=
span><br><span>--- a/src/openvpn/ssl_util=2Eh</span><br><span>+++ b/src/ope=
nvpn/ssl_util=2Eh</span><br><span>@@ -125,6 +125,6 @@</span><br><span>  * @=
param delimiter     the delimiter to count, typically &#39;:&#39;</span><br=
><span>  * @return              occrrences of delimiter + 1</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int get_num_elem=
ents(const char *string, char delimiter);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+size_t get_num_elements(const char *string, char deli=
miter);</span><br><span> </span><br><span> #endif /* ifndef SSL_UTIL_H_ */<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2199?usp=3Demail">change 2199</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2199?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41ae=
ff3c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2199 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--E6DaPCZEraY=--


--===============9005956907125552903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9005956907125552903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9005956907125552903==--

