Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B32606A328
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Hbx+Lh2u;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YI+9XNSO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VtbIPSVY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TPEXAaMG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=B51xTWUZtrke8+ZPTiujNWLmNStqDD8hrCC1mL3aCdQ=; b=Hbx+Lh2unrE03r2ni6N60t0KM1
	aEvD7RKiuwONN4QNFGLB1HA76vBvUdcoIrd4sZVerhvWypQOkGavbwWqHOwTILL0TQF3ML3XG+qut
	/i8Y+lzss6WLOV7QEBkVj6lcZr+O4OfHVnbCUjl4yIHIsGXg36OQcJgM+Ee0RMgGGftA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHYo-000000000ht-2BFC;
	Tue, 03 Nov 2026 16:40:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOHYl-000000000hV-1Sqm
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BXf/yBSmkWyZkol/zL/RgwUaDPuVRj1wL7IW/W5pgvw=; b=YI+9XNSO8YU23PZ/HvwMww+8R7
 zkeaVgue3BqeO3mG5a6ekN/yS8QfIEQSdoHs+HSH2iaBtqr+D4v2uptsxPcIsKDHglyqe77qcBdVy
 ZExRijouk52DCaSRcyyi/txweXC9nXGqVQ2QMPqLYgB5SntuI68wnYxcgCLjrl0HmgKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BXf/yBSmkWyZkol/zL/RgwUaDPuVRj1wL7IW/W5pgvw=; b=VtbIPSVYlGwZq6+k42PphXTfpK
 i/6zImDg79C/0GxRITLJ1wVJiVFcQYO4qWNzOczaU0pd/Lo61XdZYctk8NcZrxqAT/OEj/FUKWdCO
 VCmEt3bRRU3761onoc8JoSV9S6AXuOj4ygf0JP43lmDq9Peg2C4+kS792LNIU7nVJWfk=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOHYV-000000001o2-1qB0 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:40:17 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so5751425e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793724009; x=1794328809; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BXf/yBSmkWyZkol/zL/RgwUaDPuVRj1wL7IW/W5pgvw=;
 b=TPEXAaMGrs65u5pXktQSNMXFsjoiWk1nIJHjO8TONF9RzXZQTp4zOcMjwIiSxFBGlb
 CsiuaS8gyWTcGK5REGy8eOVQBVyzAG+A1b2PNWnW4xRB7p1/RUpSTnK8Q1TBZXg+/Pv8
 8FVMapUJ1St/+KiQqTiPYkiaVsQww7Ox+QXln4/MUXmma9yW1gwLUe97ZWdGQl3AO2WV
 DbTtWDqppCKVWwDxSdIIcKyWCvU/20OUfwQP406JpwtVn9YiGqDD0vJGe7bsmLDyeS1D
 B/9mwSnnBW1OkgNxG6DXbQr8hcIWF4XoXjceuhwPtGBpAor4otYoeK0Ojn1wLsHU/cAy
 LtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724009; x=1794328809;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BXf/yBSmkWyZkol/zL/RgwUaDPuVRj1wL7IW/W5pgvw=;
 b=c/J7i4mlwanTaBkcMAGvmdubVGIgcwuj0fFBAT2brc4JeqArQSdpwCZ5M2aNIJL6pQ
 lEpkRZfQz3+e6ZqHvMc/2BZCsTRhK9guvduoWTJVswaey83uAJgdZ1KQktc1Bq7YwIuD
 srkSJAO1Gl8pJPHMSYr3A4hJelW0iJ8xCtFeWGBV3ufXmuTsYkHK6z5ccg2GuRVQ35lG
 SSA3DG39Xb7Dopy5nBEgKk3ZrGmcW09noCsv8OhM6qPv4DOebGJShup125+2bYW6q+yT
 8pbCJVFFiWX44a4GuUtjOz4QzX/pYZMjq/pzAT+fXaoqFho9b0vPV5OHn4RByOf6il1B
 f45Q==
X-Gm-Message-State: APuU4Z/bszylsLEfLto09MRbvRB/ejhssAosXRcdNlCnZZF36jjZWjlP
 noYFwAIoMZggQcb1iTQGokIC5XrJ83+mHRhv1SGQXpDoMA2p2odkfy4OJj5wIMJmYYfaJk13z8I
 jcShDMYvmkjVE0LEMg2TXTaDgEWVNfYj/i5bMZBTJXEyVykwnLrsscfrk6RmOc6Iw5juf
X-Gm-Gg: AYBFou2VopBjXURgowuPjtplC4uV5iKTtLb5H9p2uCUDeJnYuZ+dMEmCNs85Nv96FnP
 S0/hRuFEgLxa/a21XH0RDQY9xnwoXxlPz31sxvVO6E8ZWxULACjuGGZs0YWBPzxn7OAItOVcdYT
 rSXjyRrKfH319Rszwr/vTkcYIoDRfBIZK6qCxHq2gN+nSvrIi3SS90VzOKhrFg5VmujflXJ2PLj
 HeDcRe+ux35RdrO29Sz9+IRuBSx3ww0JtE9t6ZWlzTUVqFWVzVl4zMyBrmDrN7KYHDkqJ0fa7Cd
 lcadKvGOQN3pIR/opJu+JF0EYlytDcVeSvyT0PjcADFt3Rs0M6wWIIHB22lyZ8ar2yNjlN/prYe
 9CcE4Rd96i3nnPOK5dsHkDpH2xjzgyRmAYBakN2WQMrVXMAes6oEewj6U4wLHb73jB+MZNXPjcS
 DoldchpO2/EaCuZheXvrFXX3K0DKY4iAW6yrUi9w3QEiWsc8/h4M5E75Ot77leac27iiWfNk5jt
 PAuqiaIv2RN4d4URHwrwGUsUvo3TNJGFSimIUxSktQEA3SELdRa+Nk4F20/TRZGZoloi8O7PHu1
 kYop4rZh20RRG2hTV8gId5/FnXBjWifAoDivBIDJYF81+9bcKVhsEL66MZSHtnei8Rzh3r21ZuM
 +x6Kh0U5BYyjZAyTM9XplIuSkBNO9P0SbEEtOdBf5HXqkkZDICRgGyMIeLgSW4yuJNH35cmPROv
 Xnb5j1gkY+jX9wEw==
X-Received: by 2002:a05:600c:4454:b0:4a2:5ef:1400 with SMTP id
 5b1f17b1804b1-4aa8ac7dacfmr412414175e9.12.1793724008567; 
 Tue, 03 Nov 2026 08:40:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a6bsm26025081f8f.27.2026.11.03.08.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:40:08 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:40:07 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
X-Gerrit-Change-Number: 2087
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2087?usp=email>
X-Gerrit-Commit: 238274cb2139615379fe8300462b38c8ce096d07
In-Reply-To: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
References: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIwNTY1MDAwLkkxYmZmMzEwN2Y5NWI0MDNkNTU0YmVhNDI2MmMyZGRhMjcwYTFmYzc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <acb67a134af1de0af75c987898076d04c64c9fc9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOHYV-000000001o2-1qB0
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7177978519147394416=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7177978519147394416==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3bKC15LLHI4="; charset=UTF-8

--3bKC15LLHI4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Use ASN1_STRING_get_lengt=
h instead of ASN1_STRING_length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Use ASN1_STRING_get_length instead of ASN1_STRING_lengt=
h

OpenSSL 4=2E1 introduced ASN1_STRING_get_length and at the same
time dep=
recated the ASN1_STRING_length method=2E Use the
new method and add a compa=
t macro for older versions and
other OpenSSL like libraries=2E

Change-Id: =
I1bff3107f95b403d554bea4262c2dda270a1fc79
Signed-off-by: Arne Schwabe <arne=
@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087
Message-Id: <20261102141=
709=2E30018-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg40439=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/openssl_compat=2Eh
M=
 src/openvpn/ssl_verify_openssl=2Ec
2 files changed, 6 insertions(+), 1 del=
etion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/87/2087/3

diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/ope=
nssl_compat=2Eh
index 4305fea=2E=2E8309cee 100644
--- a/src/openvpn/openssl=
_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -204,4 +204,9 @@
 #defi=
ne EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000000
 #endif
 
+/* Introduced in OpenSS=
L 4=2E1=2E0 */
+#if OPENSSL_VERSION_NUMBER < 0x40100000
+#define ASN1_STRIN=
G_get_length (size_t)ASN1_STRING_length
+#endif
+
 #endif /* OPENSSL_COMPAT=
_H_ */
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_ve=
rify_openssl=2Ec
index 146a384=2E=2E0c36cf2 100644
--- a/src/openvpn/ssl_ve=
rify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -154,7 +154,7 =
@@
                     {
                         continue;
              =
       }
-                    if ((ssize_t)strlen(buf) !=3D ASN1_STRING_len=
gth(name->d=2Erfc822Name))
+                    if (strlen(buf) !=3D ASN1_S=
TRING_get_length(name->d=2Erfc822Name))
                     {
            =
             msg(D_TLS_ERRORS, "ASN1 ERROR: string contained terminating ze=
ro");
                     }

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2087?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
Gerrit-Change-Num=
ber: 2087
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--3bKC15LLHI4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/208=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Use=
 ASN1_STRING_get_length instead of ASN1_STRING_length<br><br>OpenSSL 4=2E1 =
introduced ASN1_STRING_get_length and at the same<br>time deprecated the AS=
N1_STRING_length method=2E Use the<br>new method and add a compat macro for=
 older versions and<br>other OpenSSL like libraries=2E<br><br>Change-Id: I1=
bff3107f95b403d554bea4262c2dda270a1fc79<br>Signed-off-by: Arne Schwabe &lt;=
arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087<br>Me=
ssage-Id: &lt;20261102141709=2E30018-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g40439=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/ssl_verify_op=
enssl=2Ec<br>2 files changed, 6 insertions(+), 1 deletion(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/87/2087/3</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/open=
vpn/openssl_compat=2Eh</span><br><span>index 4305fea=2E=2E8309cee 100644</s=
pan><br><span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/sr=
c/openvpn/openssl_compat=2Eh</span><br><span>@@ -204,4 +204,9 @@</span><br>=
<span> #define EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000000</span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Introduced in OpenSSL 4=2E1=2E0 */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt; 0x40100000</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define ASN1_STRING_get_length (si=
ze_t)ASN1_STRING_length</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #endif /* OPENSSL_COMPAT_H_ */</span><br><span>diff --git a/src/op=
envpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br=
><span>index 146a384=2E=2E0c36cf2 100644</span><br><span>--- a/src/openvpn/=
ssl_verify_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=
=2Ec</span><br><span>@@ -154,7 +154,7 @@</span><br><span>                  =
   {</span><br><span>                         continue;</span><br><span>   =
                  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length(name-&gt=
;d=2Erfc822Name))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  if (strlen(buf) !=3D ASN1_STRING_get_length(name-&gt;d=2E=
rfc822Name))</span><br><span>                     {</span><br><span>       =
                  msg(D_TLS_ERRORS, &quot;ASN1 ERROR: string contained term=
inating zero&quot;);</span><br><span>                     }</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
87?usp=3Demail">change 2087</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2087?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 2087 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--3bKC15LLHI4=--


--===============7177978519147394416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7177978519147394416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7177978519147394416==--

