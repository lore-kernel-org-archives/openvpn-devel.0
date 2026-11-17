Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC0606A331
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cUKhjGkh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=K8JPr2As;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gQg+lHNL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FxLM6YSO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=bD9UIK7YXBxKusdJmPHbJBqrxWU3AwXNQPoZqWGAcEU=; b=cUKhjGkhmbLy/grvJC1vHTvmtz
	jA+S7iThf4uNnT2rFIMsscygfgHAhyprv9RUu6Lff6JxFlrU26OBhXF7LcOnNQV91dIMGcgWGXhEL
	Mv1br1LlLrxjfbRpqL8spUOE6i4Pg+c7rSKdZYQD4N2IADJtuxZQhzNTE59hb2/9mbTM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTMaa-000000002Gg-1v7V;
	Tue, 17 Nov 2026 17:03:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTMaZ-000000002GY-0KkW
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FJsbMvWNNMuq0rVxniKJ+JAr4uMCjxsDl0dMhbNU1Kc=; b=K8JPr2AsDzeMpzu7yFpqNLUqfA
 PTdBZ14+Bv7ZkLSD/jHm2POIVxMEQ1AbUuFLJci8LxCfNEmFecdmHiDwqHY+zJMeKBrC5eXFTN9zo
 UMSmupU5s0CGtm1ehB/PxJd4qlO5/G76jKvqxF7uFOiDnEyBL0WsxOggwIhr4FYQ1/tA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FJsbMvWNNMuq0rVxniKJ+JAr4uMCjxsDl0dMhbNU1Kc=; b=gQg+lHNL0C9ACRC0BlL9A92qLg
 CjFZxV5Moc4Cb2uDoj4Y9KsEZOZep9RZkSYLUnvtODg9dcc+BabPo6YEIdeSkQUS9mtBIoS7L6OJX
 PVO8+AWGKUi2NI6zYC7i1wYY3e6A0f61IKmKTdVG/KlQwMLzLEQyEg4ETdTFOdzcaNq0=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTMaX-000000003sK-3C65 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:03:23 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso872529f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794934995; x=1795539795; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FJsbMvWNNMuq0rVxniKJ+JAr4uMCjxsDl0dMhbNU1Kc=;
 b=FxLM6YSOvObocwqGK1TcNgm+FuU6a/c0Kopz1cRWGMZ9O1F1+xvNtfG7UtZ/obgZyk
 0ui5c6GRerb2W6m4dzxHVsXZsxonxx0TvhsqqzP+Q/tt+uCTjnVoeVMdm2kkB3oHms/O
 oUhgOnYyG48ECc4x8CYmo0cbY//Uli9K+oHZZ50/ZkHcntWGCqdITn0lJLN4wjkaS8Ki
 b+iaM8lilHDd5O/wYVgrL7uW7PA0XxHzO52sLPxE0KoY8W5J5u362K1va/pNjzB/7I7t
 4b2hoBYI2ImP+I0jsSXgySJA9aBjHsZUe9ThPPkJE3jZwQgxs5i90ayK+heCY96pYrT6
 oK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794934995; x=1795539795;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FJsbMvWNNMuq0rVxniKJ+JAr4uMCjxsDl0dMhbNU1Kc=;
 b=AMCKTIngiR16KuFhqgLmSy2i81W8JYVhhWvl6A7kvDfZqgnq3OklCohweGpp3uUIaL
 e33WDBhKyV5YnJayhoV4H+cUBGfmHOEoeM1ZaL6o6RAYHeTYjnsyZzsGrGewFH/XBbU4
 GxdAwt4RFKqR3Yg/1jf8r4kK5PdzQqjsLPj+V8Dv0K+S0opi/RXfxAfIhkqe3H4UWxc9
 Edo6BmHqLLcwYHIWffvkgAYFddFf1QN3+Phx2iFLiCsQoI/vVxqIeaUeX2ppEyqNjbdv
 D5V2sSN7OHyYnWG+ZbqRj1btnNiLT0/qeVSxFiSpNZAWj7caY5yEtvlXzyLmn9A1AkjI
 SH/Q==
X-Gm-Message-State: APuU4Z+vNC4tGmSAG2cqinzYdN8tH0ZboCfsjFw+CI3seKJq7ltOfm/e
 KPGM+a6Tjb9miWT1VTLRCGxBADdp95GJrrZYfWqN29xIGlux7r35jmuuJDkTLhy9gQ+UaQ21I++
 PYAxTUMp9fUa5JMYgd2PUEInE2kHFGcQUzjyqnc8cDIYz6jziZNzD+4JmHnmIf7w0NuT/rlAQDL
 HJM4Pm/A==
X-Gm-Gg: AZFdTZfnGQhEEAfn3hm2oXzGNldtTJ7rYh25CTRY99FDDEOWs7qFT6gF5JxRVB/eDgN
 VNsAzBQnmkV/DDPnugwNafbb6A39J5gszX1Y8EOnLNBgu+T1hI1pqmuVBdR5mWm1DWY2NIpkzzM
 ctj5tdTONoOkqAR3pIJB35I/i1g/fuudL2t2MsdI2ZKMCOmm7OOHGIWvZ96zSuc/lxijq1Iw3Jz
 UbOpMfMRbx+zyFAWXMUPHUboga9P4Otydmsw67MThWdIHqPt+xR887+ClljYp5Wwi1Ho+pwab3X
 7rGln3bC04nh7rp20fDdvFD0UmxKAiwS6+UzdmyUxrbN6mK/o/6jp5xMWVjlBZIwXB+wD0xTSx5
 xyz1F5Angb+mC4SWbvXAXqbBnGeYNcN2tSTSvl4aI5L3SXSclRFHiD9HH6LA038CmLZ4wfndc8v
 6Vw7vYw+eb4WTBobadPzvW4hL9zL5jBxm3FTVD/c4FOwm/3PzBS53qRrVq3chQWl8gITNDYW1np
 6Vzz165mbLS1m1QSpJjscOqD12olY/A5gS4SI1lI/84zJyTVFDEYJq9eZf2FLrTRrQYtTzumTdl
 ALoz9j0nlHbp6hRbtPVJefaIRpIMMA7CQiRGFrNsq+/JPho8VhpQVdxIgPlxA4M4K/hE4elLC+8
 BeSazSm1pNpP/ya13+Kpme5jPq6j8wUiyOwupBFvWOGyi/rcYqOEFd+IihWo99/VQUrmAnIzUHd
 3bBr5eL5Zim30AoPpwG0+lhJNMR7nQtJRdMh4r
X-Received: by 2002:a05:6000:4b0e:b0:491:c392:1f31 with SMTP id
 ffacd0b85a97d-4a377f4eef4mr6866771f8f.28.1794934994799; 
 Tue, 17 Nov 2026 09:03:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a47c515104sm4228391f8f.10.2026.11.17.09.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:03:14 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:03:14 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
X-Gerrit-Change-Number: 2214
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2214?usp=email>
X-Gerrit-Commit: cfc1a78e40e0a11ab2ef03577f4bb3aabafaf2cb
References: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTM0OTkyMDAwLkkzMzEyM2ZlNjIxNTEyMzc2NDEwNzY1MDMxZmM5YWU2OGNkZDkxYTZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <032716fa32de3343762ce0888951edb9b1232297-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTMaX-000000003sK-3C65
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_openssl: fix
 -Wsign-conversion in tls_ctx_set_tls_groups()
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
Content-Type: multipart/mixed; boundary="===============5415747334045866327=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5415747334045866327==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jtSTSBj6m5A="; charset=UTF-8

--jtSTSBj6m5A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2214?usp=3Demail

to review the following change=2E
=


Change subject: ssl_openssl: fix -Wsign-conversion in tls_ctx_set_tls_gro=
ups()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_ope=
nssl: fix -Wsign-conversion in tls_ctx_set_tls_groups()

Since 7d46ff17 dro=
pped the -Wsign-conversion pragma, LibreSSL and
AWS-LC builds fail: their S=
SL_CTX_set1_groups() takes a size_t length,
but glistlen is an int=2E OpenS=
SL 1=2E1=2E1's macro passes it to
SSL_CTX_ctrl() as a long, so add openssl_=
groups_len_t to pick the type
per library=2E

Change-Id: I33123fe6215123764=
10765031fc9ae68cdd91a6c
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
---
M src/openvpn/openssl_compat=2Eh
M src/openvpn/ssl_openssl=2Ec
2 fi=
les changed, 9 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/14/2214/1

diff --git a/src/openvpn/=
openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index 8309cee=2E=2Eae18=
2d2 100644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_c=
ompat=2Eh
@@ -61,6 +61,14 @@
 typedef uint64_t openssl_opt_t;
 #endif
 
+/*=
 SSL_CTX_set1_groups() length: size_t in LibreSSL and AWS-LC, passed to
+ *=
 SSL_CTX_ctrl() as long by OpenSSL 1=2E1=2E1's macro */
+#if defined(LIBRES=
SL_VERSION_NUMBER) || defined(OPENSSL_IS_AWSLC)
+typedef size_t openssl_gro=
ups_len_t;
+#else
+typedef long openssl_groups_len_t;
+#endif
+
 
 /* Funct=
ionality missing in LibreSSL before 3=2E5 */
 #if defined(LIBRESSL_VERSION_=
NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050000fL
diff --git a/src/openvpn/s=
sl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 30ef383=2E=2Eb95de8e 100=
644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ =
-535,7 +535,7 @@
     ALLOC_ARRAY_CLEAR_GC(glist, int, groups_count, &gc);
=
 
     /* Parse allowed ciphers, getting IDs */
-    int glistlen =3D 0;
+ =
   openssl_groups_len_t glistlen =3D 0;
     char *tmp_groups =3D string_al=
loc(groups, &gc);
 
     const char *token;

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
Gerr=
it-Change-Number: 2214
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--jtSTSBj6m5A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_openssl: fix -Wsign-conversion in tls_ctx_set_tls_g=
roups()<br><br>Since 7d46ff17 dropped the -Wsign-conversion pragma, LibreSS=
L and<br>AWS-LC builds fail: their SSL_CTX_set1_groups() takes a size_t len=
gth,<br>but glistlen is an int=2E OpenSSL 1=2E1=2E1&#39;s macro passes it t=
o<br>SSL_CTX_ctrl() as a long, so add openssl_groups_len_t to pick the type=
<br>per library=2E<br><br>Change-Id: I33123fe621512376410765031fc9ae68cdd91=
a6c<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<=
br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/ssl_openssl=2Ec<br>2 f=
iles changed, 9 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/14/2214/1</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_comp=
at=2Eh</span><br><span>index 8309cee=2E=2Eae182d2 100644</span><br><span>--=
- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openss=
l_compat=2Eh</span><br><span>@@ -61,6 +61,14 @@</span><br><span> typedef ui=
nt64_t openssl_opt_t;</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* SSL_CTX_set1_groups() length=
: size_t in LibreSSL and AWS-LC, passed to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * SSL_CTX_ctrl() as long by OpenSSL 1=2E1=2E1&#39;s=
 macro */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(LIBRESSL_VERSION_NUMBER) || defined(OPENSSL_IS_AWSLC)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+typedef size_t openssl_groups_len_t;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+typedef long openssl_groups_len_t;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span=
> /* Functionality missing in LibreSSL before 3=2E5 */</span><br><span> #if=
 defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0=
x3050000fL</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/o=
penvpn/ssl_openssl=2Ec</span><br><span>index 30ef383=2E=2Eb95de8e 100644</s=
pan><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_openssl=2Ec</span><br><span>@@ -535,7 +535,7 @@</span><br><span>=
     ALLOC_ARRAY_CLEAR_GC(glist, int, groups_count, &amp;gc);</span><br><sp=
an> </span><br><span>     /* Parse allowed ciphers, getting IDs */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int glistlen =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    openssl_groups_len_t g=
listlen =3D 0;</span><br><span>     char *tmp_groups =3D string_alloc(group=
s, &amp;gc);</span><br><span> </span><br><span>     const char *token;</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2214?usp=3Demail">change 2214</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2214?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd9=
1a6c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2214 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--jtSTSBj6m5A=--


--===============5415747334045866327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5415747334045866327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5415747334045866327==--

