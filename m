Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB212606A32C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PtYR2m5h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ATJppjle;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y8egiQVz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gtkCZhdC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=bMJ1R9rz+ePIK5J15q2T+z5aIOiVEysGWwYK+sBNCx4=; b=PtYR2m5hzwbLXfRzITGhVGpfZF
	CmKJBDo7a6RT9rPcr66myPVIaHGr8zG1bNMQrzZaj8ID4BwXPfk9upmrLaxWNiDdTGY54Sb1OaEnQ
	NXOWjItpO+2V3y0NH1SIeZQ2xRod5v29kTyEKvS40qvYzGacsX5LKpJa3tf+628EHmiY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSudr-00000000677-3Flt;
	Mon, 16 Nov 2026 11:12:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSudq-0000000066z-0fnZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8PdRtoBXqaMIiTigqn0dWAK08AW+wmuCwnLeApNv0+8=; b=ATJppjleIj3qchCliuwW3aIBbW
 rVgaIYrfcjlmfvB7i/D68/F06B6j4ZM68aKAYn8oj2qrm2snK22OnsfG6Tm7AxR8IYHZTvRy7MsM8
 DAisrIzsX0RGMDguJafHATvVKjwAThw3q4Fi7T8faWxL+QWCbl0x1668NrRGjA7M6a5s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8PdRtoBXqaMIiTigqn0dWAK08AW+wmuCwnLeApNv0+8=; b=Y8egiQVzvsY+z6jKXWKEhn2LE0
 TNtcI8HmNjhs60ER9RwmhYJfDGuWqS9ullQxzhscgOJSTxSJi2F15t8vs7rI7m3Mw6w8AvHjxsjT/
 a9GymvqNMH35bCp2PVEveTt0BFr5UK437L2OHnrxOk6vuAjdodg8z5yP/dQgE1xhHdIQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSudo-000000001xu-0ylz for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:12:54 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso34859325e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794827566; x=1795432366; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8PdRtoBXqaMIiTigqn0dWAK08AW+wmuCwnLeApNv0+8=;
 b=gtkCZhdCfyotWxEOENe3Ab7Bysish7tzeh77OKqC5V21oWkrgynD+qdmQc+E8sy0rD
 jW30fGAaoNsVuvFI9V8raM6iD1JSdJ6lOrPFVCIQWfczBu1EXDIgngU6jgHMJ3HLHvn6
 lTLeVHwnRjsEdj6g/nILdri5/c4bBYbiURR2Bc3AId5ILGMNldOBz1SL1e2XV3lZ6Sdb
 juJn/0DfriuRqDEj3IzMjyWqScDgRnpBUFr+Bn+gMEwjdZOSuSRUwL3Spiz9Ju+Nmg09
 fv59cXmDpX7HLoJJ6CdTUrcmSW7lbo369Y3thfw6/v/O5kJJYG0M4d7vIFnoMlgMe+qN
 xgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827566; x=1795432366;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8PdRtoBXqaMIiTigqn0dWAK08AW+wmuCwnLeApNv0+8=;
 b=FTn5U+cK50FOX4M0NA1sada69AIFYy6OHkFo69u2+hvyx8l/uPu95tNZxlntHI2Ajv
 vcfCc+UbmcUsLefLycOfZCWy41b1U9o/6kUcKIlrHMhyGCEnmPwYsE604EUAvqNbw3mR
 bMhSAMYG0ls/K17GrmbfdzX7lc+95M5kyzNdVTUUKm7RKZxqgc35948dSmfDeo6WfmFV
 7vm9zRIxtxm6zDT8a+1F8rF/gPJegQWZkEz7ZQn8FICy7spqtdfxTDUQlMf42Gv/tNGQ
 Pr8Aby0O1KN2mJZ209cPx69mfEIyQu40ainuECNHljiIqxGdzs/azotowdj/N1/rBMDZ
 reQw==
X-Gm-Message-State: APuU4Z85VoD6cJnZ0LhwkD9L9w3Cem8tqJfUZHVqgAM2SB8I0NaDnCeS
 uFlBICEnGm4hX+T+N25qE2yM2wrgiej5xDIzA6gr2PcDVlxX2rxSqhbo0C/WBJvSe3DSBvoSZq9
 N2rmKe+6PolvADLgHUY/c5L+AfytX/7CEvFAD4Pv5FdJiJ6rcY+smABpYgmUEbu+Psv+++bxs3F
 qhoqHE1w==
X-Gm-Gg: AYBFou3e/5Zwcsy1ZvAOwYAmSY3h5rDrXz05u6S6R/Q0cNXaEniAo2d+jp8CndyxUr4
 DC4uhZMWpvMTQbEcjnMaDd5QbTnNC1Sx/K/dmsBU7v/RLgh6wsX4kD2byaFyjfHzZAa+19CGLWv
 OHVzdyuMJFOmI+05Cp9gSGoChSBF5RXMkKIA4kP5DbP87IFYcLo5QCzJdDow1jEuZIgdC14mnvp
 eOEoKZMoqzNfzkKsgVIfmkJ7L9zGZEQslr5+dpGTBqZVX4iQmwkX990xg10QMg2vjf72vP94utT
 a0RyOGX6DrHYjkaNtsuzKGbSGbKiSX7WwARttqTYPlhE3KMdxE60SX+xCFSWdHsVQgeusFemPPg
 DA6RVKLMLKrmp33fgavX+Rem9Jo0vkpq7U4rKv3Vps+7qrrfw+XNBjpHFiRcOIlpYDjMlQdTOqa
 j8yGTNUcHaIcpMlNgYbbnvH47iCBdk1lvqKODWRb0/r9nUKzs5SI3AShq5RSryMMBBT4EhnZzQ9
 KsTIO7Zs2e9FCA779wckZQqqklPymUPqojko/cN0gYpDBPYecCFaztvWc9YNqCXnPZw8sN4G1Cr
 gYaw/bX+40vlM8lUrVEt9mDc7kXBDAM/9i5AcROK1CTfL2aJURPOvx0I4V5aIiDwW6mdY7SZHLp
 0MQRPZOKPFc1eJCqbeXN+kDpJvZrSo0AtJD35n29ylDkwf9kDqlIIAQumrQCXtXp88pBjzef79t
 gU2TLxt0jCGEczLuY=
X-Received: by 2002:a05:600c:1daa:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4bb55a4da43mr229798045e9.15.1794827565360; 
 Mon, 16 Nov 2026 03:12:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571d7e87sm193593115e9.3.2026.11.16.03.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:12:45 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 11:12:44 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f
X-Gerrit-Change-Number: 2189
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2189?usp=email>
X-Gerrit-Commit: dea7ae31523558340a40a3115efb4a78151e5b97
References: <gerrit.1794827563000.Ib645e0bf5c8941f4b1e14f13397794be15eab68f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI3NTYzMDAwLkliNjQ1ZTBiZjVjODk0MWY0YjFlMTRmMTMzOTc3OTRiZTE1ZWFiNjhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21113d2c79fcd9e16c0e3d405ad36b002a313180-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSudo-000000001xu-0ylz
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: remove obsolete
 preprocessor guards
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
Content-Type: multipart/mixed; boundary="===============3201206095878867504=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3201206095878867504==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oNi+M63yR+E="; charset=UTF-8

--oNi+M63yR+E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2189?usp=3Demail

to review the following change=2E
=


Change subject: ssl: remove obsolete preprocessor guards
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: remove obsolete preproc=
essor guards

- MBEDTLS_SSL_CBC_RECORD_SPLITTING and its API were removed i=
n
  mbed TLS 3; the minimum is now 4=2E0=2E
- INFO_CALLBACK_SSL_CONST is ne=
ver defined=2E
- TLS1_3_VERSION is already used unguarded, and the only cal=
ler of
  convert_tls13_list_to_openssl() isn't guarded=2E

Change-Id: Ib645=
e0bf5c8941f4b1e14f13397794be15eab68f
Signed-off-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
---
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openss=
l=2Ec
2 files changed, 1 insertion(+), 15 deletions(-)



  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/2189/1

diff --git a/s=
rc/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 43bb0ff=2E=
=2E84e633c 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_m=
bedtls=2Ec
@@ -897,15 +897,6 @@
     mbedtls_ssl_conf_renegotiation(ks_ssl-=
>ssl_config, MBEDTLS_SSL_RENEGOTIATION_DISABLED);
 #endif /* MBEDTLS_SSL_RE=
NEGOTIATION */
 
-    /* Disable record splitting (for now)=2E  OpenVPN ass=
umes records are sent
-     * unfragmented, and changing that will require =
thorough review and
-     * testing=2E  Since OpenVPN is not susceptible to=
 BEAST, we can just
-     * disable record splitting as a quick fix=2E */
-=
#if defined(MBEDTLS_SSL_CBC_RECORD_SPLITTING)
-    mbedtls_ssl_conf_cbc_rec=
ord_splitting(ks_ssl->ssl_config,
-                                        =
  MBEDTLS_SSL_CBC_RECORD_SPLITTING_DISABLED);
-#endif /* MBEDTLS_SSL_CBC_RE=
CORD_SPLITTING */
-
     /* Initialise authentication information */
     (=
void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl->ssl_config, ssl_ctx->crt_cha=
in, ssl_ctx->priv_key));
 
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/o=
penvpn/ssl_openssl=2Ec
index e190935=2E=2E020d11f 100644
--- a/src/openvpn/=
ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -159,11 +159,8 @@
  * =
Print debugging information on SSL/TLS session negotiation=2E
  */
 
-#ifnd=
ef INFO_CALLBACK_SSL_CONST
-#define INFO_CALLBACK_SSL_CONST const
-#endif
 =
static void
-info_callback(INFO_CALLBACK_SSL_CONST SSL *s, int where, int r=
et)
+info_callback(const SSL *s, int where, int ret)
 {
     if (where & SS=
L_CB_LOOP)
     {
@@ -425,7 +422,6 @@
     }
 }
 
-#ifdef TLS1_3_VERSION
 s=
tatic void
 convert_tls13_list_to_openssl(char *openssl_ciphers, size_t len=
, const char *ciphers)
 {
@@ -449,7 +445,6 @@
         }
     }
 }
-#endif
=
 
 void
 tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const cha=
r *ciphers)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2189?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib645=
e0bf5c8941f4b1e14f13397794be15eab68f
Gerrit-Change-Number: 2189
Gerrit-Patc=
hSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>

--oNi+M63yR+E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl: remove obsolete preprocessor guards<br><br>- MBEDT=
LS_SSL_CBC_RECORD_SPLITTING and its API were removed in<br>  mbed TLS 3; th=
e minimum is now 4=2E0=2E<br>- INFO_CALLBACK_SSL_CONST is never defined=2E<=
br>- TLS1_3_VERSION is already used unguarded, and the only caller of<br>  =
convert_tls13_list_to_openssl() isn&#39;t guarded=2E<br><br>Change-Id: Ib64=
5e0bf5c8941f4b1e14f13397794be15eab68f<br>Signed-off-by: Razvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src=
/openvpn/ssl_openssl=2Ec<br>2 files changed, 1 insertion(+), 15 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/89/2189/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_mbedtls=
=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 43bb0ff=2E=2E84e63=
3c 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -897,15 +897,6 @@</sp=
an><br><span>     mbedtls_ssl_conf_renegotiation(ks_ssl-&gt;ssl_config, MBE=
DTLS_SSL_RENEGOTIATION_DISABLED);</span><br><span> #endif /* MBEDTLS_SSL_RE=
NEGOTIATION */</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* Disable record splitting (for now)=2E  OpenVPN assumes re=
cords are sent</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
unfragmented, and changing that will require thorough review and</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     * testing=2E  Since OpenVPN=
 is not susceptible to BEAST, we can just</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * disable record splitting as a quick fix=2E */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(MBEDTLS_SSL_=
CBC_RECORD_SPLITTING)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    mbedtls_ssl_conf_cbc_record_splitting(ks_ssl-&gt;ssl_config,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
          MBEDTLS_SSL_CBC_RECORD_SPLITTING_DISABLED);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
   /* Initialise authentication information */</span><br><span>     (void)m=
bed_ok(mbedtls_ssl_conf_own_cert(ks_ssl-&gt;ssl_config, ssl_ctx-&gt;crt_cha=
in, ssl_ctx-&gt;priv_key));</span><br><span> </span><br><span>diff --git a/=
src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>i=
ndex e190935=2E=2E020d11f 100644</span><br><span>--- a/src/openvpn/ssl_open=
ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@=
@ -159,11 +159,8 @@</span><br><span>  * Print debugging information on SSL/=
TLS session negotiation=2E</span><br><span>  */</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef INFO_CALLBACK_SSL_CONST=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define INFO_CALLBACK=
_SSL_CONST const</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-info_callback(INFO_CALLBACK_SSL_CONST SSL *s, int where, int ret)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+info_callback(const =
SSL *s, int where, int ret)</span><br><span> {</span><br><span>     if (whe=
re &amp; SSL_CB_LOOP)</span><br><span>     {</span><br><span>@@ -425,7 +422=
,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef TLS1_3_VERSION</span><br=
><span> static void</span><br><span> convert_tls13_list_to_openssl(char *op=
enssl_ciphers, size_t len, const char *ciphers)</span><br><span> {</span><b=
r><span>@@ -449,7 +445,6 @@</span><br><span>         }</span><br><span>    =
 }</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span> </span><br><span> void</span><br><span> tls_ctx_res=
trict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2189?usp=3Demail">change 2189</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2189?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </di=
v>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"=
display:none"> Gerrit-Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f =
</div>
<div style=3D"display:none"> Gerrit-Change-Number: 2189 </div>
<div =
style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>

</body></html>
--oNi+M63yR+E=--


--===============3201206095878867504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3201206095878867504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3201206095878867504==--

