Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1764606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W8PH2FNB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fW2AoaLY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k9LvW+T9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AeIu5PNB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Rgr+nb9jTrHI1QB76DqMYH7aD96mRlKMotEdLo3oAP4=; b=W8PH2FNBSXs1OF6+3D7oPFKQBi
	oI7ZObQQCDX67H5Sq78JPothA7WVvzJIeL7taqElGpciqMatjhblN/gaGpOIOS7gdv85milBIE17d
	n4/C7b+bKdZ/961PsIqHEqfyP3p0GjUclHTRG72BfkV7dkaK9NbKemPPCUA9nqLt7kPA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxQu-000000003SK-2Pwd;
	Fri, 27 Nov 2026 15:00:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxQt-000000003SD-3kn8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mBpNdndSnPbhU+mE1Rgp5xZen5AJidlxUP7RQ587PrQ=; b=fW2AoaLYo1ukJFJSzPt9sIXMvg
 ZzNhKE85ECPq8aoHEbOHcWgHgw4yXcfZmGrVe3Eu0Wxf2ouqVYctnOceOyhweEuF2EbAFL+cQa29B
 iEAr2nELSXufereLgiP88Yxwfa+MmqMXETUKgf3JrNHK3MBwlEN/jgJreJbX5MJoYIrw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mBpNdndSnPbhU+mE1Rgp5xZen5AJidlxUP7RQ587PrQ=; b=k9LvW+T9aBHAqShhdFagfRYA+G
 7c5Klm1WQ3GzB0uj1eEeu3qKImw43JYsKoTKUawojkMHSwGiDG/VpSeOER8kyRcWBBDiHBg1/b5RK
 2TmcK3l/6wwgWQLqu22aCSmvhNEXjuMEQD/RTbwxW2EmS8PcvrvOlKTO2r9tzl6VFshg=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxQt-000000003gy-0yeU for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:00:15 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bba5e17cbeso27866305e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 07:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795791609; x=1796396409; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mBpNdndSnPbhU+mE1Rgp5xZen5AJidlxUP7RQ587PrQ=;
 b=AeIu5PNBfp+v/6dGE99oGWce6rMUSbWc7GJQhnjUNONfCgB0isaqo/0QL8junAnm9K
 IOLOqDMjqxzszGWAONb6Nokm78ZcHjHkH3PU/2INfGmTlnRvsKq4F/uJuzjAf4ooOMfV
 9yxYb6mK4mvS2pfOv51X3NRte8RXcC/+kE/nvsbODQOacOIpsRJZToKm6qDsFqoPrlOH
 H5kV+v3f+T4QCokwVqRY+xR5zj3UIS293i7xz8NLOxCtM2pgjUJrTUVKx+aaGoW2zjTV
 5z6Ns6OsPwR/mOgkaMobfCGrHjptXHwnWAhRUNETc5CSi0GChssMVJS4XMRWlx3Ih2SN
 g0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791609; x=1796396409;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mBpNdndSnPbhU+mE1Rgp5xZen5AJidlxUP7RQ587PrQ=;
 b=QX2kRmkOMuYeqm/nVXBu2cepnJGf+dONPbNYCZFB5v1Knmu3iSyB6yxLbXK61aV2qC
 8sYyfmq//YCEZykRVBlUtTXTs+CNI8pLwfsGRw+yotC62jC30BpC1JeVq1Ojss/Bke9l
 81uI3R409EnVZRvbIAnImjkak2AHq2Px6vj+HKCyhREbDZ0Z3pYse80iSDkQV8KCrEHf
 T2WVjKuXSEEisVpo95ZyePZzpcy6ryFZGXTEfFoC1pnsSiCAweJ6Ctg4/xMpvS1uVtTN
 AM38a/3quErbnqprLL9/Z1OyHwYw3yj+vmE9XbrXO9fvwUmFDn6ZwDVjcAEVlnIinVlA
 T9ag==
X-Gm-Message-State: APuU4Z/Qjjbm/wtUF8akDZljyywKJFFFWw6n8ba2xP+nm6BVoTgucnFr
 ibkZ/DhkXYEKCaF+VbQxcDlOEfhoFUDwbyecGD3tv95LpM0XQ4QxfDdY27T1Ap3+5fzYfkdhQ+b
 Aa43Xdz1JD02yK4+eTk+v8waC1s5tTdoEFcF5T/CaepARonT92LTV+T4W9mvwysIHjYMj432xIT
 nEz+2obA==
X-Gm-Gg: AZFdTZd8WKzWBaWtfkt3afpPJkW7blmGFbimgwTfT75C95uq6QuOc7cOrtoGUDFEf49
 Qelcigh3fir19Xlx9l2IjI/rAe9lKdZKdUWdo0LwnArny0AX/WITtkaDcUz4wn0lFsZ5HdqDG+t
 JFEOyuwM5IHDKDerzsNL8b8IKnm7VMC9gDNbSacnSZClySukKBdilMd41zuUgLZAaUbCIxQvJ8c
 Qo5k5Qe2SML6Qpna0cHCnUOa9wEr0vJPWu38QTgC10HEZGZjL7y9sRddM9nKL8ib3Pvv2rmCX6S
 Z2nHSKCdlpB6hFzLu1fXgqV9n9lNTDgUzG2MXrpj83G+aiCT5VX6QqpfN74S1EOpx/dk9lpcooe
 Wrho6M7Hqa5OZeiWCzTIm6g/NxorJENT0yDJu2eHrskcZGtUHeAOhJVXg1QuEwPQKuhyDdKy5cw
 T5RDEd8uL2lGgfM7tfMUXGf2NxJaLQvMzf8V/fvIJk4DlLSenQYmQKQYdaR8rYCPlKP5nnCWepa
 YEBYDWt0uvDA1SSr96CjKcese6JnCGRrq47/y3lYA+GjKpjPXz6hSGVfliodiiTpQa10X0HFUDu
 TVRtkO6MKLbg58C9eVWwubQ9TffSPdqUuHDmUcsjYt7hGab+GsJ247Ny3EvOutb3hk9wrPhVwg4
 GH9T3zjk1m9IVDvF8TuFur39roKVAlXUxIWnh47tMYfvClc3EKOjWitUlMfKvSB1gEycb3CYA0h
 ZDY8yuMydptGUgNnOXHZuFJgjH1SsJhS+lQBKm
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id
 5b1f17b1804b1-4bb88809950mr508408325e9.17.1795791608267; 
 Fri, 27 Nov 2026 07:00:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm54731215f8f.24.2026.11.27.07.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 07:00:07 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 15:00:07 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7aa7e2f15d63e8e5dc2449c46db075e179627ced
X-Gerrit-Change-Number: 2364
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2364?usp=email>
X-Gerrit-Commit: 16fdb69610255055eec11a639bc0d4161dd3d515
References: <gerrit.1795791606000.I7aa7e2f15d63e8e5dc2449c46db075e179627ced@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkxNjA2MDAwLkk3YWE3ZTJmMTVkNjNlOGU1ZGMyNDQ5YzQ2ZGIwNzVlMTc5NjI3Y2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5fe12b8b10a62620a5dda3d9bf5bd11135596558-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxQt-000000003gy-0yeU
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pkcs11_openssl:
 free the BIO in pkcs11_certificate_serial()
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
Content-Type: multipart/mixed; boundary="===============7420597595699661964=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7420597595699661964==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kkxn6kO+N+U="; charset=UTF-8

--Kkxn6kO+N+U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2364?usp=3Demail

to review the following change=2E
=


Change subject: pkcs11_openssl: free the BIO in pkcs11_certificate_serial=
()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

pkcs11_ope=
nssl: free the BIO in pkcs11_certificate_serial()

The memory BIO holding t=
he serial number was never freed, leaking it
for every certificate listed b=
y --show-pkcs11-ids=2E

Change-Id: I7aa7e2f15d63e8e5dc2449c46db075e179627ce=
d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/=
pkcs11_openssl=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/2364/1

dif=
f --git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec
i=
ndex c5974fce=2E=2Eebf13f5 100644
--- a/src/openvpn/pkcs11_openssl=2Ec
+++ =
b/src/openvpn/pkcs11_openssl=2Ec
@@ -442,6 +442,7 @@
     ret =3D 0;
 
 cle=
anup:
+    BIO_free(bio);
     X509_free(x509);
     x509 =3D NULL;
 

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2364?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7aa7e2f15d63e8e5dc244=
9c46db075e179627ced
Gerrit-Change-Number: 2364
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>

--Kkxn6kO+N+U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2364?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">pkcs11_openssl: free the BIO in pkcs11_certificate_seri=
al()<br><br>The memory BIO holding the serial number was never freed, leaki=
ng it<br>for every certificate listed by --show-pkcs11-ids=2E<br><br>Change=
-Id: I7aa7e2f15d63e8e5dc2449c46db075e179627ced<br>Signed-off-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/pkcs11_openssl=
=2Ec<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/=
2364/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pk=
cs11_openssl=2Ec</span><br><span>index c5974fce=2E=2Eebf13f5 100644</span><=
br><span>--- a/src/openvpn/pkcs11_openssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/pkcs11_openssl=2Ec</span><br><span>@@ -442,6 +442,7 @@</span><br><span=
>     ret =3D 0;</span><br><span> </span><br><span> cleanup:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    BIO_free(bio);</span><br><span=
>     X509_free(x509);</span><br><span>     x509 =3D NULL;</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/236=
4?usp=3Demail">change 2364</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2364?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchan=
ge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I7aa7e2f15d63e8e5dc2449c46db075e179627ced </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2364 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerr=
it-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>

</body></html>
--Kkxn6kO+N+U=--


--===============7420597595699661964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7420597595699661964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7420597595699661964==--

