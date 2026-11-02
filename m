Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA648606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aUzGPDWY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PZM8ax2w;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RIkhu2Vb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PeOk5IuW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=V5XpCK7uyd5GxNi0K+cOlQ5Z9NlgU2YE4J2Cjq8lCF4=; b=aUzGPDWYxzsg68ac6AU9hDwL4L
	LS82K0gQzYi478HCwqOSmcGgM6jKNf3VcHFI4lJCxCbGOsM6aH8u51N9EofeiRvrqpmhwJWpSKTeP
	J5426yfHDydqVeP0Oj5d94ZiTc64usF5gCjGgzTL815Mt3VpmagJtp+weUsjVQY2cX2A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqe8-000000001rO-1AHG;
	Mon, 02 Nov 2026 11:56:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqe7-000000001rI-05qI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:56:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lbBYZPWQhBxCU9dtFDaz3E9yUFHViEeCAsQSLF6H84g=; b=PZM8ax2wWhRed4j+lQ+hCU+JCi
 CNK7BhtLWBgUA7hVmFQ0o88g/a0SqVaAXAGZdZnoq8fNYBYKhdKsOvULzDkFvsa+Qpgzpq9TwBem2
 w0NRri9HsSYHAVUsvtSHeUmyw8cyjlruTdh9C205yAWWOGyRgvxiDvMKi771a3pQlubE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lbBYZPWQhBxCU9dtFDaz3E9yUFHViEeCAsQSLF6H84g=; b=RIkhu2VbIDN00Ud7QiuU+qAFyi
 kxF13e/KTimqIopgh3m2TRr322/39UlY1M7Hd1flyU/WOL8xx6Jp1iFfNFIR8EEF40J8ZALoFm4Nb
 LHGJbQncqgrpNYamAX9zynPwvVn+paZ6szi6TY0p+iNRNxekTlgAqQItATEO7t1BoPPY=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqe6-0000000062O-1Wc8 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:56:14 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so22096745e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793620568; x=1794225368; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lbBYZPWQhBxCU9dtFDaz3E9yUFHViEeCAsQSLF6H84g=;
 b=PeOk5IuWtiSYQNrb0fXeq7KbiHKA4ULUWUIwyW08rTwN7wm83y6jQs8eK6FgAzNKfV
 1YhEtGUVpMl6Mk/EOg5v/yAV6OWS4YU5yKMS8fLgKlSjRMhCM+4E4KKD9EW/+J+GSiBJ
 +uFcKUyClo79mD21gsEkt5hkThT2epGR8hGf3mn4YLNuGj+r2oUFF4JWuNma6bOpKVvi
 O68RTYTMXcQQEoIhvMpL6DSQGbDFR3p9CE0duH7YcKSOXHJBikEfVhRvECHSEQxhwAVW
 DApMTnB20WdGL1++/lqVFtJd6KUcu+ebp10I/RLfJUa5Vaswadu+LATbQ2tHgQYutK99
 PFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620568; x=1794225368;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbBYZPWQhBxCU9dtFDaz3E9yUFHViEeCAsQSLF6H84g=;
 b=sElPAsCxU1ZtRAxgMnPbikXHg8BCY7cd3LINRj/7+DS470/A8SWQ9mjg9MmN0QyExa
 W/tB+9fXsOpGsa0uXHwzW4jVldj3FV/XiAcnr8ctAheWfGN40VDMU8aol5T0DJkTJSFQ
 3rIGWzWjGFtT9XZ939YZpJEUeHJ4RT4lOIlOokX5YZgFYkRMQvhQzdxN0+bkUMXCvWEu
 bHa3R+sqg5P6vU+XTbfxeTMFlgrofCAf3UyR4jY3A/APDO8jLUGWjy95AHKZA4lHKi7i
 2pJdfferc/otgjNgbI8bAsmFy6xX9XGtgMTnkOP6VODh1/kG+68VXyqSQvvtYV527y+D
 6LJA==
X-Gm-Message-State: AFq9FYIYHBSHu3/9WHH0HjYLTkmh3kDKVBvwmEdmr3VGLf+fC+eOdVO9
 ZjX8xMf4lGrotSak5MhRNLURR5xjd4hBdrBwEa8gaRkwxHEMUlO6ICgUyNj/pUp/fs6vuPqKneP
 NxDoj6bvoSDx+Ex3CXEpCJoPDRVPvMwUPXX4xK7AvbYJLLj9rdX/6F+hQzaDHJc3L2IQ/d89RxO
 ue4YC10w==
X-Gm-Gg: AYBFou0LjJ7uapxdMGnIUiIfDLRItjR/wGYSz+jsq87pSOQlZNO/ChH9HF/8fjCSByw
 B+Z4qljs5SfAVh53brHldFu8mg4WX4rGZRKirZTTMGgJDjgZVq9JnYOgxEQtXZEDuO6ISqE++e2
 4NEwX6qdG+pueZWqRCyNn/uMoI22QO6s0ZGds8VF75H0963h06n7/fOREobNcIy7UuCl9WLooJu
 m1YWU9/NnED/FHUd9yu2GdeAPLyB7gMWAn8nown4JvUiN1O6tF7Su2gnPGltJyBXVE0XzHNE3KO
 8urptf997YMoJlilbyUlRR2q6Vd+8a9fJvkOkbnNQiqz5jKe1KiLfB2t5UZk9G7zhrgs2mXHS7w
 5zURUHvOx8ugiXNqjAt18qa0QEqiY+Z96jq7fRZDum21U4w7zMFLW9V1Vh/dYh87V9oQu3Ntn5k
 vYWBXFQ3dGlSwDJCQp3OOHLd8ntWLXwH51EIPjt9d0JJsGo8plmYDyEzw0bIJ1cvdEFZOu/80eq
 y2Q69sJUe3/VunkaaieioYQMYH+JfpOKuxcxbrrTJLdQV+3x2uO3+pWkn8STUrU7atwn1wwaJKG
 6ccP/KHeCV9gtdHKTjl2LxdDzNzjU7H+wkDR/6jKqCl4AmFEa5iGDUGTmqN/19/V71Wqs0BZwKn
 Uj7P4lMQvmQ+a07/9WLXAWrQiAT33GvKrnj96qdd/NUQwa2mvLWrF8Ik9SnZm8OyOaBlVVcX1FR
 KzYrld7JQkNszBvQ==
X-Received: by 2002:a05:600c:4e50:b0:4a9:2a92:231f with SMTP id
 5b1f17b1804b1-4ac16bc461emr224822745e9.7.1793620567611; 
 Mon, 02 Nov 2026 03:56:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea72254csm145364325e9.1.2026.11.02.03.56.07
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:56:07 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:56:06 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
X-Gerrit-Change-Number: 2087
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2087?usp=email>
X-Gerrit-Commit: 52625259fc60721c075d28eacd378babdd76333d
References: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIwNTY1MDAwLkkxYmZmMzEwN2Y5NWI0MDNkNTU0YmVhNDI2MmMyZGRhMjcwYTFmYzc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9a3baf31e052f9ff7f43ca5a6e607582987bed9b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNqe6-0000000062O-1Wc8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use
 ASN1_STRING_get_length instead of ASN1_STRING_length
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
Content-Type: multipart/mixed; boundary="===============5055272672721096325=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5055272672721096325==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BhKlzATBRqg="; charset=UTF-8

--BhKlzATBRqg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2087?usp=3Demail )


Change subject: Use ASN1_STRING_=
get_length instead of ASN1_STRING_length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Use ASN1_STRING_get_length instead of ASN1_STR=
ING_length

OpenSSL 4=2E1 introduced ASN1_STRING_get_length and at the same=

time deprecated the ASN1_STRING_get_length method=2E Use the
new method an=
d keep and compat macro for older versions and
other OpenSSL like libraries=
=2E

Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/openssl_compat=2Eh
M src/=
openvpn/ssl_verify_openssl=2Ec
2 files changed, 6 insertions(+), 1 deletion=
(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/8=
7/2087/1

diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl=
_compat=2Eh
index 4305fea=2E=2E8309cee 100644
--- a/src/openvpn/openssl_com=
pat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -204,4 +204,9 @@
 #define E=
VP_CIPH_FLAG_ENC_THEN_MAC 0x10000000
 #endif
 
+/* Introduced in OpenSSL 4=
=2E1=2E0 */
+#if OPENSSL_VERSION_NUMBER < 0x40100000
+#define ASN1_STRING_g=
et_length (size_t)ASN1_STRING_length
+#endif
+
 #endif /* OPENSSL_COMPAT_H_=
 */
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verif=
y_openssl=2Ec
index 146a384=2E=2E0c36cf2 100644
--- a/src/openvpn/ssl_verif=
y_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -154,7 +154,7 @@
=
                     {
                         continue;
                 =
    }
-                    if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length=
(name->d=2Erfc822Name))
+                    if (strlen(buf) !=3D ASN1_STRI=
NG_get_length(name->d=2Erfc822Name))
                     {
               =
          msg(D_TLS_ERRORS, "ASN1 ERROR: string contained terminating zero"=
);
                     }

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2087?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
Gerrit-Change-Number: 20=
87
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--BhKlzATBRqg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Use ASN1_STRING_get_length instead of ASN1_STRING_length<br><b=
r>OpenSSL 4=2E1 introduced ASN1_STRING_get_length and at the same<br>time d=
eprecated the ASN1_STRING_get_length method=2E Use the<br>new method and ke=
ep and compat macro for older versions and<br>other OpenSSL like libraries=
=2E<br><br>Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/open=
ssl_compat=2Eh<br>M src/openvpn/ssl_verify_openssl=2Ec<br>2 files changed, =
6 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/2087/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span=
><br><span>index 4305fea=2E=2E8309cee 100644</span><br><span>--- a/src/open=
vpn/openssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh=
</span><br><span>@@ -204,4 +204,9 @@</span><br><span> #define EVP_CIPH_FLAG=
_ENC_THEN_MAC 0x10000000</span><br><span> #endif</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Introduced in OpenSSL 4=
=2E1=2E0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPEN=
SSL_VERSION_NUMBER &lt; 0x40100000</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define ASN1_STRING_get_length (size_t)ASN1_STRING_length</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OPENSSL=
_COMPAT_H_ */</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=
=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index 146a384=2E=
=2E0c36cf2 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec<=
/span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@=
 -154,7 +154,7 @@</span><br><span>                     {</span><br><span>  =
                       continue;</span><br><span>                     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if ((=
ssize_t)strlen(buf) !=3D ASN1_STRING_length(name-&gt;d=2Erfc822Name))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if (s=
trlen(buf) !=3D ASN1_STRING_get_length(name-&gt;d=2Erfc822Name))</span><br>=
<span>                     {</span><br><span>                         msg(D=
_TLS_ERRORS, &quot;ASN1 ERROR: string contained terminating zero&quot;);</s=
pan><br><span>                     }</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=3Demail">change =
2087</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2087 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--BhKlzATBRqg=--


--===============5055272672721096325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5055272672721096325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5055272672721096325==--

