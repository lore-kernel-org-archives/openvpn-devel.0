Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164F3CCF2DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EyFmcs4YF6lffbhlWvmmfzAd7zBpn+iPoRkOgSCX4KA=; b=IjwYHlrzkKL2LcZgxfEHL1Who8
	7Ldt7ZoK6nJ3hnD/gEi7hjT0M2z32mD8c6P58g+JhuV/snRwOgsUSKCvvYKIlmaSiuPWHXsbF3YU1
	SO4k1gKa9kEhwwdpdQ34o+0QkcTdPMezoF03ugtj0KlAtspSe+wA9zBxdVGztkARBPOI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIn7J-00066j-Pf;
	Mon, 19 Oct 2026 13:09:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIn7I-00066L-Aj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qwSUT+blB3Vkr6cxurPxO+EYs1Pr8dkDRHEr1VVzEOg=; b=ZcMSvGxGSO75cRWE0FQbN8lwOO
 6W1yNzvUTntFvIHZx0+P4JFPYQ54NDtg5hctAP5gl5DBSu4oKrJ6oB4XaCVa6LG+u+WrGwO9ka7lu
 zPL4hBGbGj7uz94h8/PX7qsH6JOWCuYLUQYuX5raG+D77xcJUDj9L4feeBiXe0lI/twM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qwSUT+blB3Vkr6cxurPxO+EYs1Pr8dkDRHEr1VVzEOg=; b=k
 mih3wCZQSMsfRY8FqNKGhxLTcVjieMBvSfwfoctorQVFLKoH5gtH+kOWd5eUtPvdKLydjpat+Ki8A
 rEbEPvKL1HN+kStu88vh/75AnGb7CCYcVE6zFgLUgfUYKRvXtsmw9BOERNpWyOtXkM5zwhHOcMpzX
 QgDJ+XFMxLnIpR8k=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIn6t-0007mL-Mp for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:09:07 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4956869750eso16458165e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792415337; x=1793020137; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qwSUT+blB3Vkr6cxurPxO+EYs1Pr8dkDRHEr1VVzEOg=;
 b=gq1IipIBi7BZoPbCUe0hVm4blQZZIk3T8DAJtJhszkS0c24oXwNYt5b6qdBSIeIf7X
 hJ8ODcHqoTdHEK9E+E80C6dNjbU4llAZM5KzSA8qpURLKF2OZ6s3KCIT+c9V6hZV2B1H
 8B0WoApJH2pcEi58cdQlSBdQNJSdoRWm51ECWlRBY4uGzK1+cSmVW4sbw43bLL0HiqQ+
 dBdwQFZyDdIGCluJ3FABT53kBMVRMICdKlW9ZZNqGeXpf17t6y0LB0o9nFMcexSSbWKB
 bsUPmCSSLO6VsoZGgoud0JDGDOc8PxmITyJTLZrFTloLxO9p0u+ElrpOnB9jDlY+T74i
 YVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415337; x=1793020137;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qwSUT+blB3Vkr6cxurPxO+EYs1Pr8dkDRHEr1VVzEOg=;
 b=jlGtFXQO3/DQ10Gph1F1pe/rWRjSySEw7aVnQsGTXNKc5rfpDiYKKVq0Ji4Gro0faB
 /LOvMHuvnJ/t8mUnP7N/C6j1yE+oafTxLqlmnjvzClzs1/nFZf+WngXZDnHtEKQ9qfF0
 Z2vPX32aYE9bnZt+sIdDnPSg6quCDJodEt5bVEZt+6mTYJX9tIyFzaNnSnB6rVaGQLmw
 i0QV8AUGB9TETmwYD12UNCUx9J/JkPt5VTiqPdxX+V9CgPs9z1p0RCw0uSe6bDvS+iUY
 ZXt9gdChKHVg5PuwSoWlKK5RbsCZBSv40VEA1ua4pEMeiYB0ME/HT0vp5txWFIHnlQNu
 2w5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFfHZCMh6f27imVhl0Bswarz61uNpMviJqAHtxUo3dhAmZsG6QgFTO0hTe4bi/cEA/+lSA3nwlLBvKRVtQ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJB7mjI/vajcLkSVcNX8Yh73U+E8ync0z7H5QF6PKgj5PEZ6x/I
 +60XC3pdyadKdMyvFDaSANCrj611sYDBoL04zcv8gUpPDmLhvf2SBIByRgTagV8XrUKyRqCIflm
 MzjJwydbF8Uzj2gONMvuFK4aQQxCp4QOp3JssD3ItSN7x3oFIkdilLmOBFolwXOigfek8
X-Gm-Gg: AYBFou2f3PVBPOe+aiVg5mJ50aQFnZuN4M0ZNbPUXwa0pAT4vOct/1dNUex7xPG8XXd
 m4KDsAIsGh344yuw3CVYIxCqwt0jQsJvaYvtYV3nAezvlkFnd0qxwKpQ2vzWXC/IWeHVJKYtMzK
 XsXbfEnajkHqUPAkpZp9FEfJpJrBLulaSIlxVn7zc4SqY2Bm8OfIhj8GIF25tW5FuommN2icc0Q
 JScV1qunHTxH4ENcBeJH8jE+NA2CwzbCOkOkQtfDYs0DFglYbJTpND8xizvRVNKzZLChK2/PdAH
 6ENhyLPElc6M62k8FxKRzYXEfj7DNJ19GoMXULFUTxJoXdxdkXV5SdPqwqwglOnx0amqVsZBiMx
 PsYBzAajAJhlOHSUlk4QbfByS5GZCIV9mWvVhVSVJqPf4LSFS7lY+6P0UwiinkwJtpZEMHrPq7Z
 ZkzRyQNU/tbA3ReORLqtq42Cp4dd0PLaJZVRslZn7XzLHg8GW01CqHIhDuB7kXKA2azse3veuTM
 R8nn0NS5PliiKs+MSqCXVBPoeBL5x+gp1orEvQLfz1TFK47Xjt4p2J9qPw/wk4k+/s2f9CDCOrC
 fWlKiwhJxDjLOJVgBHb8cHpJdG3HLHtA5pKBU/3Zhx+wWmQLj8kFM+jBpHg4Dw==
X-Received: by 2002:a05:600c:4e03:b0:49c:fa20:cbfc with SMTP id
 5b1f17b1804b1-4a1d75ffbdamr180509445e9.19.1792415336872; 
 Mon, 19 Oct 2026 06:08:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d2e93a01sm270670085e9.0.2026.10.19.06.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:08:56 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 13:08:56 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69
X-Gerrit-Change-Number: 2007
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2007?usp=email>
X-Gerrit-Commit: 9f5effdbe1734fb24de01e439ac2276e11f5987d
In-Reply-To: <gerrit.1792255622000.Iae70a03c2bcc502f62133abcbfd1c92528e65d69@gerrit.openvpn.net>
References: <gerrit.1792255622000.Iae70a03c2bcc502f62133abcbfd1c92528e65d69@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLklhZTcwYTAzYzJiY2M1MDJmNjIxMzNhYmNiZmQxYzkyNTI4ZTY1ZDY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a503b43dcf23553775936e53a63dcc8260aea1a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIn6t-0007mL-Mp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify_mbedtls:
 Avoid conversion warning in x509_get_fingerprint
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3517893232462838509=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3517893232462838509==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WX2AWQFo67E="; charset=UTF-8

--WX2AWQFo67E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2007?usp=3Demail )

Change subject: ssl_verify_mbedtls: Avoid c=
onversion warning in x509_get_fingerprint
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_verify_mbedtls: Avoid conversion warning i=
n x509_get_fingerprint

We already convert mbedtls_md_get_size to int in ot=
her
places, so just use that here as well=2E

Change-Id: Iae70a03c2bcc502f6=
2133abcbfd1c92528e65d69
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007
Message-Id: <20261018154604=2E24=
008-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg40020=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify_mbedtls=2Ec
1 fil=
e changed, 1 insertion(+), 10 deletions(-)




diff --git a/src/openvpn/ssl=
_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index b9a36a6=2E=
=2E6680ccc 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvp=
n/ssl_verify_mbedtls=2Ec
@@ -542,25 +542,16 @@
     return FAILURE;
 }
 
-#=
if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#p=
ragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static struct buffer=

 x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *=
cert, struct gc_arena *gc)
 {
     const size_t md_size =3D mbedtls_md_get_=
size(md_info);
     struct buffer fingerprint =3D alloc_buf_gc(md_size, gc)=
;
     mbedtls_md(md_info, cert->raw=2Ep, cert->raw=2Elen, BPTR(&fingerprin=
t));
-    ASSERT(buf_inc_len(&fingerprint, md_size));
+    ASSERT(buf_inc_l=
en(&fingerprint, (int)md_size));
     return fingerprint;
 }
 
-#if defined=
(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 str=
uct buffer
 x509_get_sha1_fingerprint(mbedtls_x509_crt *cert, struct gc_are=
na *gc)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
007?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merge=
d
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae70a03c=
2bcc502f62133abcbfd1c92528e65d69
Gerrit-Change-Number: 2007
Gerrit-PatchSet=
: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--WX2AWQFo67E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2007?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_verify_mbedtls: Avoid conversi=
on warning in x509_get_fingerprint<br><br>We already convert mbedtls_md_get=
_size to int in other<br>places, so just use that here as well=2E<br><br>Ch=
ange-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2007<br>Message-Id: &lt;20261018154604=2E24008-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40020=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>=
1 file changed, 1 insertion(+), 10 deletions(-)<br><br></pre>
<pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec<=
/span><br><span>index b9a36a6=2E=2E6680ccc 100644</span><br><span>--- a/src=
/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verif=
y_mbedtls=2Ec</span><br><span>@@ -542,25 +542,16 @@</span><br><span>     re=
turn FAILURE;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> static struct buffer</span><br><span> x509_get_fingerpri=
nt(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert, struct gc_aren=
a *gc)</span><br><span> {</span><br><span>     const size_t md_size =3D mbe=
dtls_md_get_size(md_info);</span><br><span>     struct buffer fingerprint =
=3D alloc_buf_gc(md_size, gc);</span><br><span>     mbedtls_md(md_info, cer=
t-&gt;raw=2Ep, cert-&gt;raw=2Elen, BPTR(&amp;fingerprint));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp;fingerpri=
nt, md_size));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    A=
SSERT(buf_inc_len(&amp;fingerprint, (int)md_size));</span><br><span>     re=
turn fingerprint;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct buffe=
r</span><br><span> x509_get_sha1_fingerprint(mbedtls_x509_crt *cert, struct=
 gc_arena *gc)</span><br><span> {</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Demail">change 200=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae=
70a03c2bcc502f62133abcbfd1c92528e65d69 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 2007 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--WX2AWQFo67E=--


--===============3517893232462838509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3517893232462838509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3517893232462838509==--

