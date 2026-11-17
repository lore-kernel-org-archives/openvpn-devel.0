Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5A606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XPtet6Tg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OZnKXvba;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KfM3oUwe;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QheGx8C5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Uyi2TqeerLROqKO0UsogO8s4VKJlN2oD4bRbs+RgVSc=; b=XPtet6TgBTAJmHu0QhxunccWwP
	a5tiEo4q6uqUtufaff8uOjTf3PMdqcMrd9aTBUcPbL2yCQPIL4yxJnqjdE+MNIJBt8wlV6nxhrgZP
	6WsK23BMnNlh19ODJXGYpkeJ01OZOlEFURHumJqP88uokkEQf28u9yLiX1rL086THrqY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNHj-000000003BZ-2iDI;
	Tue, 17 Nov 2026 17:47:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTNHi-000000003BS-1WxN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:47:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2efyA3/Up05tBD5/TE+pY/PKj/l92ZhLUXBC97HId8s=; b=OZnKXvbaYJnyX30SJwQBNT4rY0
 9xFvkUto9Ach/9Psy8YhQtyyljKd7Pov/iFP5VHYa2Z84WEC3kCeaTzTB9VTCwSQdybmRDa2oJw4K
 C2KI5TaypcA1JjXW5HTAPHD0mfWeaYwLuYjgEC73uDEzMVzdj/iGFVjPsSOyWPEKHLGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2efyA3/Up05tBD5/TE+pY/PKj/l92ZhLUXBC97HId8s=; b=KfM3oUwePhhLp6JTpRid8S51zd
 00w6DsSzjz//uWE7bJPr0DzkC5lHcai+DRHwWz8id4vrLFMuPKWkmZyh/I70vHb1niT70eJjt+oad
 VlbRlHYc3XBXeDZYSGIXv84SOavEJFuZeXOtGhuWt+rx1dgXkohFdBz+fKqcpStwZ1Ts=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTNHg-000000000RW-3uWU for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:47:58 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so1072615e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794937670; x=1795542470; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2efyA3/Up05tBD5/TE+pY/PKj/l92ZhLUXBC97HId8s=;
 b=QheGx8C5gZn+fpo8fkHfNsCxgpdpy4g97wnfq2iC95V+CdNMKWm4QqkBPq10ggkp4R
 tQJg8HigPXyIMHToPGoj3XyCj37utBwlT1EA0jUO5sxegpHfDbFUxQJtB5dbBj+IXr/i
 7Tl1y26LhynLSnEq7RgRy6t0wTdZnc97QJyBsw5pfNB09ASuG3ZWaI8Tp3ymtgVoDOV9
 9+1cJN56ALzDEV8uGmxceNra8sF+v1DalEM+AhKwcQJr3kMJQaZ2uJXBUQr7ML5yLQ77
 p5DOIXJUS6J0QDK1VG13QFaaEvbGraw0LdQ7JkbabotPUhubu9+v5ixwwmZrT7q2aKy7
 0LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794937670; x=1795542470;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2efyA3/Up05tBD5/TE+pY/PKj/l92ZhLUXBC97HId8s=;
 b=TrnJP/CoCsU9fbsImgvFKm/gTnnaeSwwBt/OmmMl16zQJS2DwGJFBuD4pxT5LoIhOv
 n9h2GFLxfMVMFSIby4e0bXijTbLXR3itaknplkkBHGVbaTOKu2YT0qMP/Sdv4VA0jP7Q
 9oVw6R0YcxjqePH4jTPkEpm7RLD+fq2N812CTCcSqA0EHj3mc1a/DYgp58fHnwx4xQjX
 ej5LAnjAy0x5MsPXs2YY/T/fvpk0spXCR9BgSL8tQjLYS9eqOMC3RjojkbareOs2xHW+
 tcA1lOACdqS6jNyeFbz/jybWqpTY234xhSxUIxgrxdOzejmJix0zWO5DsyQBvoVYRa5l
 JV8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHn/XGaCC73FIVDcB8tJavAc6LrkXEtFaFkj8+wXqDFLK4h72xn73Z9ocb24C0YBwTFWpCc8J0bZ3mthAP7@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+CBVCchB6Z5apW+q3eSXFeoUmKR6uC4l1akiGJ8++Q+0KO4rIu
 AeezuvZGBqF16CM9W8w/0z+an/32gql+27Zn8Is/EGG0DYgqSQNw2Wih2Wk6L7+EaH9ThXpYE6m
 MIZpHFj5LKmd0+XUMN4TAjRln/ON5TrYa+CitiFlp2V+AYZQRhgR3iDGhUoI9nOcUHP8w
X-Gm-Gg: AYBFou0aUFkUmHQCcjO+eyLtV9V/e6r2XSMyD9saAKg1MTKD3jByT7CFqEFOvUm+sXf
 DfToO+aUnWjDagE+v7k9sDvkr3rkaVrvQRV46hWb3wIQbbLswi/PfFA7bizcd79mDF2SSLaYX93
 ZHOnfh1gvPY6eXXLAtICrb9o8VB3Tah8uvS+0XV6HiNWBSa9AjlDdsAP/Wl5J7ra8gTl20YwNGX
 jsvaYThdAxoX3NHunIyj8BjTvrf0TawHRd3uEFap8pZ+MYy6RIamKZWvocX8iZwzXq48ayybwix
 HKKvAG7PMpq2goywLkdyWbevqsWEfLt0Xw4KeVngM6lyFM1Zs44OZxWDqrT2wvDesZDMvnljxSe
 75NKKWzDZDgtARtSCAkQUZmTvmqJ0RFZAoMcqc4lJLZqJgzMfDrNYnY+Pp34SwQeaUdv1YGpqQN
 2u9R3JtnZlbOqsHpB45//KLIweAHWaLn6OQsyPuM8BO8DiuBuV31bsiizT66SGIQ9TCx/4gffl4
 R+6F8ya2BzRTIsWj1WJ/DhQ3SCxv3hwFEFo82Qh9rekv5vJkTrvQUlnxjMcK8xicnrJkSl11RDz
 e+Fb6TQ95xPkVCjQv+XZw7W7fTy5HhqAKsyOKIYU5SgprcvBpZd2o8zfYdjf+sSWIfxK98bcc0u
 x/OG3FKmzsa+VcgEJjTZNt0oyusm5jEplzxR94ZPt8scRvGNDJdAPnxGJPk8t97MPLP+r1zMZ4n
 MKRKBtZ+Cuh5UKkXU=
X-Received: by 2002:a05:600c:8b56:b0:4a6:44b:2593 with SMTP id
 5b1f17b1804b1-4bb55ad0711mr312416275e9.29.1794937670151; 
 Tue, 17 Nov 2026 09:47:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2c3c93sm825335e9.13.2026.11.17.09.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:47:49 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:47:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
X-Gerrit-Change-Number: 2214
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2214?usp=email>
X-Gerrit-Commit: c19bdda311b56048c2de66d827c09eb3a255019e
In-Reply-To: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
References: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTM0OTkyMDAwLkkzMzEyM2ZlNjIxNTEyMzc2NDEwNzY1MDMxZmM5YWU2OGNkZDkxYTZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <63d80479d4baf96d7196f54edaf626399c372f80-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTNHg-000000000RW-3uWU
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7968848037512135694=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7968848037512135694==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vb0FLiic19U="; charset=UTF-8

--Vb0FLiic19U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2214?usp=3Demail )

Change subject: ssl_openssl: fix -Wsign-con=
version in tls_ctx_set_tls_groups()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

ssl_openssl: fix -Wsign-conversion in tls_ctx_set_tl=
s_groups()

Since 7d46ff17 dropped the -Wsign-conversion pragma, LibreSSL a=
nd
AWS-LC CI builds fail: their SSL_CTX_set1_groups() takes a size_t
length=
, but glistlen is an int=2E

The buildbot LibreSSL builds pass because the =
headers also define
SSL_CTX_set1_groups as a macro, and clang suppresses wa=
rnings in
expansions of system header macros=2E CI includes the libraries w=
ith
plain -I, so their headers aren't system headers and the warning fires=
=2E

OpenSSL 1=2E1=2E1's macro passes the length to SSL_CTX_ctrl() as a lon=
g,
so add openssl_groups_len_t to pick the type per library=2E

Change-Id: =
I33123fe621512376410765031fc9ae68cdd91a6c
Signed-off-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214
Message-Id: <2=
0261117172524=2E11381-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41565=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/openssl_co=
mpat=2Eh
M src/openvpn/ssl_openssl=2Ec
2 files changed, 9 insertions(+), 1 =
deletion(-)




diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/o=
penssl_compat=2Eh
index 8309cee=2E=2Eae182d2 100644
--- a/src/openvpn/opens=
sl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -61,6 +61,14 @@
 type=
def uint64_t openssl_opt_t;
 #endif
 
+/* SSL_CTX_set1_groups() length: siz=
e_t in LibreSSL and AWS-LC, passed to
+ * SSL_CTX_ctrl() as long by OpenSSL=
 1=2E1=2E1's macro */
+#if defined(LIBRESSL_VERSION_NUMBER) || defined(OPEN=
SSL_IS_AWSLC)
+typedef size_t openssl_groups_len_t;
+#else
+typedef long op=
enssl_groups_len_t;
+#endif
+
 
 /* Functionality missing in LibreSSL befor=
e 3=2E5 */
 #if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER=
 < 0x3050000fL
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_o=
penssl=2Ec
index 30ef383=2E=2Eb95de8e 100644
--- a/src/openvpn/ssl_openssl=
=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -535,7 +535,7 @@
     ALLOC_ARRAY=
_CLEAR_GC(glist, int, groups_count, &gc);
 
     /* Parse allowed ciphers, =
getting IDs */
-    int glistlen =3D 0;
+    openssl_groups_len_t glistlen =
=3D 0;
     char *tmp_groups =3D string_alloc(groups, &gc);
 
     const ch=
ar *token;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
214?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merge=
d
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33123fe6=
21512376410765031fc9ae68cdd91a6c
Gerrit-Change-Number: 2214
Gerrit-PatchSet=
: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--Vb0FLiic19U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2214?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_openssl: fix -Wsign-conversion=
 in tls_ctx_set_tls_groups()<br><br>Since 7d46ff17 dropped the -Wsign-conve=
rsion pragma, LibreSSL and<br>AWS-LC CI builds fail: their SSL_CTX_set1_gro=
ups() takes a size_t<br>length, but glistlen is an int=2E<br><br>The buildb=
ot LibreSSL builds pass because the headers also define<br>SSL_CTX_set1_gro=
ups as a macro, and clang suppresses warnings in<br>expansions of system he=
ader macros=2E CI includes the libraries with<br>plain -I, so their headers=
 aren&#39;t system headers and the warning fires=2E<br><br>OpenSSL 1=2E1=2E=
1&#39;s macro passes the length to SSL_CTX_ctrl() as a long,<br>so add open=
ssl_groups_len_t to pick the type per library=2E<br><br>Change-Id: I33123fe=
621512376410765031fc9ae68cdd91a6c<br>Signed-off-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214<b=
r>Message-Id: &lt;20261117172524=2E11381-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg41565=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/ssl_opens=
sl=2Ec<br>2 files changed, 9 insertions(+), 1 deletion(-)<br><br></pre>
<pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2E=
h</span><br><span>index 8309cee=2E=2Eae182d2 100644</span><br><span>--- a/s=
rc/openvpn/openssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_com=
pat=2Eh</span><br><span>@@ -61,6 +61,14 @@</span><br><span> typedef uint64_=
t openssl_opt_t;</span><br><span> #endif</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* SSL_CTX_set1_groups() length: siz=
e_t in LibreSSL and AWS-LC, passed to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * SSL_CTX_ctrl() as long by OpenSSL 1=2E1=2E1&#39;s macr=
o */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIB=
RESSL_VERSION_NUMBER) || defined(OPENSSL_IS_AWSLC)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+typedef size_t openssl_groups_len_t;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+typedef long openssl_groups_len_t;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /* =
Functionality missing in LibreSSL before 3=2E5 */</span><br><span> #if defi=
ned(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x3050=
000fL</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvp=
n/ssl_openssl=2Ec</span><br><span>index 30ef383=2E=2Eb95de8e 100644</span><=
br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvp=
n/ssl_openssl=2Ec</span><br><span>@@ -535,7 +535,7 @@</span><br><span>     =
ALLOC_ARRAY_CLEAR_GC(glist, int, groups_count, &amp;gc);</span><br><span> <=
/span><br><span>     /* Parse allowed ciphers, getting IDs */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int glistlen =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    openssl_groups_len_t glistl=
en =3D 0;</span><br><span>     char *tmp_groups =3D string_alloc(groups, &a=
mp;gc);</span><br><span> </span><br><span>     const char *token;</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2214?usp=3Demail">change 2214</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2214?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2214 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--Vb0FLiic19U=--


--===============7968848037512135694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7968848037512135694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7968848037512135694==--

