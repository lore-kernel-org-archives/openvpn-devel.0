Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F3606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Gfo8Yt29;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dbO21qKL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kDJPiFow;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=C59g+1NU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b20itrETv7chxLxYkRQX8DIYVk3DgrsNp6Hf02BoSOw=; b=Gfo8Yt294ldJvT7IkmlPd7CwA7
	gL4jzW1T2QXfD8UcxMBMbiaUusSk/liCRvmW3OWj7MhjZG0NOAGetYFLIyiTNQ1n1ptbWudnj5zVS
	96KxlQB0KVWwzRT2D1BNXZJBQdvusBfrHUK/A6U8uKRmthHwu6vZXEwguc1NOgSPiqP0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTMkp-000000001jY-2Xhn;
	Tue, 17 Nov 2026 17:13:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTMkn-000000001jP-22TA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:13:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VkXK3pponZSRE+yniU3uZ5s8xSKly1Ej/1m4T8hbTC4=; b=dbO21qKLOgcOmTQ7btB5AOqENE
 /h2iAc01hdpT6zVbL/P3q+rH+AX8L5IN1EKGyBQihchE2l3u/td06KMiVnORAws5IS4LeTSvBQ5MN
 fRVUmI/opuqe0fLmXTiMjvjPmR0DWjbWCaUrOrsbMHEUye8QUCimZGC/n4cPh10E3qXM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VkXK3pponZSRE+yniU3uZ5s8xSKly1Ej/1m4T8hbTC4=; b=kDJPiFowrlqlKVn9bDfoMGR0Yk
 /v3ZsfuXJt1gJ3ynOfwL/tldSzvlziOTMbenRdH+kvk0M+9YAg2j19C+g8cEIukOz2FG6g2BWZOOF
 d1MwG0UPyKD/idkhE2S0+hBJHSjCQtnQOC7nQQgxQCKJkO2ZjbZnJU99FfcqlJGTBVKo=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTMkm-0000000046A-0oHF for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:13:57 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so1000793f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794935630; x=1795540430; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VkXK3pponZSRE+yniU3uZ5s8xSKly1Ej/1m4T8hbTC4=;
 b=C59g+1NUDS6thF+lm6XC6OE7/ye3rE1ImtFKLXofCD4SDBR1yU7WvOsCT2fDVlkHEN
 3TU9fNp6dPgj9SHNr2Jy2HqLiTZOrqGmayd2xbT9WmEKjBWAZG1ts0KO/J4QPbTqbVJa
 TRQIJlyn2D533h3gQ2EY75Ot87x2q1XbwtengfBhHjhpKuQ/ne4jTFOa0Q6YI6JO3lD7
 07gn3lF+AN9SkFk/jQUbRq9/uVFSRilYx7Jr+MZ9qSwrXJ7ELMw1g4EWZFOk/EfRyutF
 r3jV5wXHb2eWj8wFhZTVCcsFD4QTqTNyZen7vCRbGzQbkcojM1ZJeyZwf4oLiA6Q7FJA
 rEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794935630; x=1795540430;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VkXK3pponZSRE+yniU3uZ5s8xSKly1Ej/1m4T8hbTC4=;
 b=Kt0a2AdlyJi3e3Br68PhFFOgwi3w9i69VDJMs7T2brTHsX1a3HUQv+s5hxzO785JVX
 1Rbrw5UiGOuTJM7f+VXMj1cuEFouh32GxHnQ2ProJ+Ft+KW/KhWngWbaQatYu0ejmn2W
 MY5NgY/DbTZHvWRZ0ocK4O3sRDhidClqtPtonnTw2VUJLkUisD+Xyj5sbzNUxXLLAAYs
 jFC0fC1dZb/l4Y0Jq8pPP3/MPmi6+enr4VwQaT4bTk97ATtUSDoINqA7bZoxeQ46fvvI
 7OBGGiE/0aVwpSfyXBoZf1f8yG/v7QS+kY8U3WI0WKO7gGmFQf2jMshMUFkpaV7vP6AQ
 5iuA==
X-Gm-Message-State: APuU4Z9k9ituKEpzNSt453SBsHYGR2Uai049FL0cswXoiVBza/eMPRvb
 FzuETJnaLHRvOABT6jbe8o5gnDX7mG8qgGsN6YB+4RbyaYEqzTtn8V/1tHz4XBHfK5GYczgvS9g
 GT5AotRHLpEjbhdOTaCEKWbLtUc7aUMfqf9YLBsijPIgBpwGt61aJyJDbU8Q5Utwefn2NiWT7iO
 EBcuR9fw==
X-Gm-Gg: AZFdTZdT8lfU5EBBmz19VmBsHdcU33SK6OvlNXEn8rPS9Z486vkEjV0a5TrlRTHiyy0
 trhuYp9lMS9QgDUpNGY5DZOjWm9CT+abQrlj3hy5FK+qejkE0O+RM5glwistN5Kbr1/eZBK/T1G
 4AeEgkXi+tXa02IpqshbNdoMIoffdMYGFYyETEpCGkSyyZahyWZbuugRv8nQmB81pq7nRySgfvV
 2rsZt0vKteftmxp6ajs4GouqCu9Ov0OGjNDb5YQTEALxyHAn6dGHEGHqG9bFeFs1IOwNp8eH03E
 sE92jIvV/MLwgJIToL/6GBFAI/kEFwSN6s2vEMFDpZlT+75Vvo/WdRJypdKieySCrFbhH7vw1iE
 nDKUmWGu1cfVSy1vCVK4IhWh5Tb2JkzEMyPVjVCD5CAKiY/11rFETeh8lf5LTIKX3EHMaEMBx9O
 Ub3ltb4zYCQ89JH1eUEs2kCKoqdXCumz2uKq/8FMs9wjA6NGQtEtKSTU7wZqeoECvdLrfmraWBl
 Hovk8dM3HrE+nOixNGLVxzWamcI2mBZ+CjHKYvTRR0A0pn1oh5c3cIfZWaE0H0qB+536kO3M5Mi
 6ubYrV7WPPAcdTxgqnJ+gOB37i9SxUyMyyqu8y060daaLjJKHN5iUHOV3yGSlg12jwse6UkpoKG
 uvvOsMhfoRgYfPESpuA6livFDMqY1gan+BHVXjt8Bt5TqaTI0AMhhwskAsSBbRj1pk8bCB1VRRE
 7VMBed/hRtE0YumdM=
X-Received: by 2002:a05:6000:41c2:b0:48e:6651:5956 with SMTP id
 ffacd0b85a97d-4a36609c994mr7229416f8f.0.1794935628882; 
 Tue, 17 Nov 2026 09:13:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm50650921f8f.7.2026.11.17.09.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:13:48 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:13:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
X-Gerrit-Change-Number: 2214
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2214?usp=email>
X-Gerrit-Commit: 3990c07cdf21e87fd14872c86d1633ee38f86ed8
In-Reply-To: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
References: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTM0OTkyMDAwLkkzMzEyM2ZlNjIxNTEyMzc2NDEwNzY1MDMxZmM5YWU2OGNkZDkxYTZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aedd779a3ed76c478c527da631413e53c3cef87a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTMkm-0000000046A-0oHF
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0021025187678311376=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0021025187678311376==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ruroRHA25qA="; charset=UTF-8

--ruroRHA25qA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2214?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review-1 by Frank Licht=
enheld


Change subject: ssl_openssl: fix -Wsign-conversion in tls_ctx_set_=
tls_groups()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


ssl_openssl: fix -Wsign-conversion in tls_ctx_set_tls_groups()

Since 7d4=
6ff17 dropped the -Wsign-conversion pragma, LibreSSL and
AWS-LC CI builds f=
ail: their SSL_CTX_set1_groups() takes a size_t
length, but glistlen is an =
int=2E

The buildbot LibreSSL builds pass because the headers also define
S=
SL_CTX_set1_groups as a macro, and clang suppresses warnings in
expansions =
of system header macros=2E CI includes the libraries with
plain -I, so thei=
r headers aren't system headers and the warning fires=2E

OpenSSL 1=2E1=2E1=
's macro passes the length to SSL_CTX_ctrl() as a long,
so add openssl_grou=
ps_len_t to pick the type per library=2E

Change-Id: I33123fe62151237641076=
5031fc9ae68cdd91a6c
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
=
---
M src/openvpn/openssl_compat=2Eh
M src/openvpn/ssl_openssl=2Ec
2 files =
changed, 9 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/14/2214/2

diff --git a/src/openvpn/opens=
sl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index 8309cee=2E=2Eae182d2 1=
00644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=
=2Eh
@@ -61,6 +61,14 @@
 typedef uint64_t openssl_opt_t;
 #endif
 
+/* SSL_=
CTX_set1_groups() length: size_t in LibreSSL and AWS-LC, passed to
+ * SSL_=
CTX_ctrl() as long by OpenSSL 1=2E1=2E1's macro */
+#if defined(LIBRESSL_VE=
RSION_NUMBER) || defined(OPENSSL_IS_AWSLC)
+typedef size_t openssl_groups_l=
en_t;
+#else
+typedef long openssl_groups_len_t;
+#endif
+
 
 /* Functional=
ity missing in LibreSSL before 3=2E5 */
 #if defined(LIBRESSL_VERSION_NUMBE=
R) && LIBRESSL_VERSION_NUMBER < 0x3050000fL
diff --git a/src/openvpn/ssl_op=
enssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 30ef383=2E=2Eb95de8e 100644
-=
-- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -535,=
7 +535,7 @@
     ALLOC_ARRAY_CLEAR_GC(glist, int, groups_count, &gc);
 
   =
  /* Parse allowed ciphers, getting IDs */
-    int glistlen =3D 0;
+    op=
enssl_groups_len_t glistlen =3D 0;
     char *tmp_groups =3D string_alloc(g=
roups, &gc);
 
     const char *token;

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
Gerrit-=
Change-Number: 2214
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>

--ruroRHA25qA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2214?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review-1 by Frank Lichtenheld</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl=
_openssl: fix -Wsign-conversion in tls_ctx_set_tls_groups()<br><br>Since 7d=
46ff17 dropped the -Wsign-conversion pragma, LibreSSL and<br>AWS-LC CI buil=
ds fail: their SSL_CTX_set1_groups() takes a size_t<br>length, but glistlen=
 is an int=2E<br><br>The buildbot LibreSSL builds pass because the headers =
also define<br>SSL_CTX_set1_groups as a macro, and clang suppresses warning=
s in<br>expansions of system header macros=2E CI includes the libraries wit=
h<br>plain -I, so their headers aren&#39;t system headers and the warning f=
ires=2E<br><br>OpenSSL 1=2E1=2E1&#39;s macro passes the length to SSL_CTX_c=
trl() as a long,<br>so add openssl_groups_len_t to pick the type per librar=
y=2E<br><br>Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c<br>Signed-=
off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openv=
pn/openssl_compat=2Eh<br>M src/openvpn/ssl_openssl=2Ec<br>2 files changed, =
9 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/14/2214/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span=
><br><span>index 8309cee=2E=2Eae182d2 100644</span><br><span>--- a/src/open=
vpn/openssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh=
</span><br><span>@@ -61,6 +61,14 @@</span><br><span> typedef uint64_t opens=
sl_opt_t;</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* SSL_CTX_set1_groups() length: size_t i=
n LibreSSL and AWS-LC, passed to</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * SSL_CTX_ctrl() as long by OpenSSL 1=2E1=2E1&#39;s macro */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL=
_VERSION_NUMBER) || defined(OPENSSL_IS_AWSLC)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+typedef size_t openssl_groups_len_t;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+typedef long openssl_groups_len_t;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /* Funct=
ionality missing in LibreSSL before 3=2E5 */</span><br><span> #if defined(L=
IBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x3050000fL=
</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl=
_openssl=2Ec</span><br><span>index 30ef383=2E=2Eb95de8e 100644</span><br><s=
pan>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=
_openssl=2Ec</span><br><span>@@ -535,7 +535,7 @@</span><br><span>     ALLOC=
_ARRAY_CLEAR_GC(glist, int, groups_count, &amp;gc);</span><br><span> </span=
><br><span>     /* Parse allowed ciphers, getting IDs */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int glistlen =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    openssl_groups_len_t glistlen =
=3D 0;</span><br><span>     char *tmp_groups =3D string_alloc(groups, &amp;=
gc);</span><br><span> </span><br><span>     const char *token;</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2214?usp=3Demail">change 2214</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2214?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2214 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>

</body></html>
--ruroRHA25qA=--


--===============0021025187678311376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0021025187678311376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0021025187678311376==--

