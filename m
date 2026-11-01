Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BB606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dJ8rglj1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QRpHXPHO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g8f5zvA0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Brc3ivT0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=G+IZvrffZrGPLoxlCNe8pL6yVMogRgtNU6LpRrO12Qo=; b=dJ8rglj1L0yXQH2Sik7K1F/dWc
	IBRA9lpDeaubIOKcf9fN7DbcBXv9IQ/+o/XVp8mm4FKdZ5VKjZBzJ4f+/wyOxxmYVYD/Wdq8QC1WB
	fOuoi9oUT41RBiGUjGel+1gw/9B9cS7rAnF+1Prt0nUz+OpLlplg24jGHeMQjyQuPuJw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNKRm-000000003aK-0m7s;
	Sun, 01 Nov 2026 01:33:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNKRk-000000003ZN-3Qh8
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 01:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6/7At82u27SRtsCNckgg8L2xrAdcoxKLPrXRstX0YM8=; b=QRpHXPHOQLPIxGAFnwccszOLLa
 vQXr765a90ppDAZDF9ywGBTf47lOADmYM+kWlCIP16nHT2/0cVoaJbIuBN2d04Ioj7V/miNGbg7W4
 0FEcU2wI/cQOG/aRuMuVGfqeddhATcLpBBfuNilQ6FNov7vbwuhH8uW6cR7h7mTclAi0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6/7At82u27SRtsCNckgg8L2xrAdcoxKLPrXRstX0YM8=; b=g8f5zvA05nXnuOIdxdfWHrXv42
 x9hNDLducFDlj/3sbani4J5OAN8j7mbULoUHHXCQP7zwKXZOECdBn5zt/5QSbgpHORHv6Mhac72UN
 1I7uM1x0/NlemOcVCQTi/S9KlMVFNmr0U4t6X6pF9VZvOktxA6uxLt8sgvjgGrf2anlc=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNKRa-000000004ju-3XCe for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 01:33:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so14505265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793496784; x=1794101584; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6/7At82u27SRtsCNckgg8L2xrAdcoxKLPrXRstX0YM8=;
 b=Brc3ivT0TEFfF/J6AVTafJ+CCtklxsI6Src8YoX7W2U07d5m0i9jQ1wPsCxF65HrHd
 FvqjHpKmo+qBDE+xCEeB6++42WaCSgRF1t+xlnXTiixLSOI4NE204cygZycQZRXeJPG4
 9G34YvKD6uV3AfuMXpU5jH1BR1GyrFSNiw7443/AJXFl3aLiGndYdrMWEn3btXbwru9T
 WmqHf+kx4+6gNBDVF09ihso6WDrfcC5eMI9/PVj5BtXixalIQnH1tcu8jw8xCHXxZUNl
 Z3dL3xmYtEi/8CfnGr1gH+EgLT9jymSTx/6UyEL2l0PQSKtefJ0/J8NP+6MszORmFvFd
 f6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793496784; x=1794101584;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6/7At82u27SRtsCNckgg8L2xrAdcoxKLPrXRstX0YM8=;
 b=i1m/caTpGnrJdhlheaXbTIA/QoGWaAZtDwlyiY3kHX/tnEPSF1H149dy2XiGs7P9KJ
 99E9n/uDXSzv07fxiaqrWXyQDfPTv9qfMJRMeSXZhlPGd2FBploGrnqGGqvd/2rl9T1P
 Yl7KsBA6x/zIf+EhPdIJ4puiKYTrZgVLadrUxsJDWT8xzbrcRpBNBZzPuT7q/uBIuxdD
 9/HwRvaWZRZdJYJsTrM5WbJ4MJx8+tZTz5rT9/n0nGjObJYLaN74DbM/TpDkUBxJyDgk
 1can8eq/df3AzVtwfFOpTs80/wiPx+/GZu7IOu97uZkzB0WH1A60FaXWjQH8daMs4XEA
 O/EA==
X-Gm-Message-State: AFq9FYJLurpjlQOKcTH7GEmUZbPi1OWhS6wdBHSfo5ymAJKHASQcEh1a
 iKbiqvAI8TbO8wfbLHZybA1aKLnZ8hTvhMG8JnClSE6s1xlMwPtPLmLgMhuDT4T695CcbVBVaJJ
 7IYz/1CODucafCTz611AcB1vxlpoM1zzxffv9eAFFGmd9SHC/MfKgdROBn25ur/8cPx/O
X-Gm-Gg: AYBFou07HHDWwg9I/BIr7B7je8BQogbV8ZoQud2zDS6sL+TGgziZd3hX7LpYfHfZrJn
 EAtYegfwpxZUOUb68Vf21tXRY5UfUCRjgczEd6eldNTt4Em8stMQWsi8qVn0DMXdWGiU2plGzm3
 6AGrKJC5ZRjvZtgAJCOFYWZl4pdUwtiHHe3kEcojcSnOF6BIA4Zm6bZYqIkFLswsEAyaO03JIL9
 Ices39jk+58Cb6/KP3EkDAO80BO94fwyIzrU8C9xVwtyBEa66TlXJvssPyFNaQuriSRU00JINjZ
 rz2SxUdhOnMQ8XNlovZFJDNs4b2dT7qBiaWx4TpgcMeo974vMb5even0EmN2+32jcp+1cmnF2mF
 r5UDHy0KS8U1ShjxkhGgQ9sfwlxYbdf6MYNM+6jZBesOptyesQrsxIhIvk7P+eZBY/+Y3VxyPUv
 K3fI+VXzIUXorYVUwfBbfCWc//3zJS1z8EHvP9xZ3G0Ewqua2VaaSGpoz0II6f+5HMnGP9qC6Ek
 5k+gyrkYIp6TR3xVfISXwLPw5PJM9sUvVhASP4sephnA5+AuFf+H5MiTGSEG78jaQOuuHQCf/Z+
 U71BZ99lL774ewDSpxNK5VoTiH/zPGvAPcFMy63Exm81uwkGNLtekI72rn08KtcAUGHNiW8nAbW
 kLdA+ZfSrsPlK5JckMj8Fi6vIsxad76GGC8SrfRl+BulxS8PMDvL1RJMPMGflRXFbyz/XZsHiTv
 5CUcZDQU6OJ0npiA==
X-Received: by 2002:a05:600c:6383:b0:4a2:ebb:397b with SMTP id
 5b1f17b1804b1-4ac17ffb050mr134799005e9.11.1793496784192; 
 Sat, 31 Oct 2026 18:33:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b289f7sm164831495e9.5.2026.10.31.18.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 18:33:03 -0700 (PDT)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 01:33:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
X-Gerrit-Change-Number: 2077
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2077?usp=email>
X-Gerrit-Commit: b12b34a656ea278e4b660274caacae14fdcfcd85
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzgyMDAwLkk2YjQyNzg1ZGU5OWVlMWU2YjU1NWQ4YzVlNjFlYmUyYWU3ODQ1MTBlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2f5ff01a79dced06fb2cd4f9b3adde01170b45a8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNKRa-000000004ju-3XCe
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_openssl:
 Clear PEM decoded key data before freeing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Hansaem Wi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: hansaemw@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2457912308346673506=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2457912308346673506==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BEx8Fm947Mk="; charset=UTF-8

--BEx8Fm947Mk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2077?usp=3Demail

to review the following change=2E
=


Change subject: crypto_openssl: Clear PEM decoded key data before freeing=
 it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

crypto_=
openssl: Clear PEM decoded key data before freeing it

crypto_pem_decode() =
decodes the tls-crypt-v2 client and server keys
and the auth-token key, and=
 frees the decoded key bytes it got from
PEM_read_bio() with OPENSSL_free()=
=2E Use OPENSSL_clear_free() instead=2E

Assisted-by: Claude Code:claude-op=
us-5-5
Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
Signed-off-by: =
Hansaem Wi <hansaemw@gmail=2Ecom>
---
M src/openvpn/crypto_openssl=2Ec
1 fi=
le changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/77/2077/1

diff --git a/src/openvpn/cr=
ypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index e6abd8f=2E=2Ee6873b=
b 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_open=
ssl=2Ec
@@ -528,7 +528,7 @@
 cleanup:
     OPENSSL_free(name_read);
     OP=
ENSSL_free(header_read);
-    OPENSSL_free(data_read);
+    OPENSSL_clear_f=
ree(data_read, data_read_len);
     if (!BIO_free(bio))
     {
         ret=
 =3D false;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2077?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b42=
785de99ee1e6b555d8c5e61ebe2ae784510e
Gerrit-Change-Number: 2077
Gerrit-Patc=
hSet: 1
Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>

--BEx8Fm947Mk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Hansaem Wi would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">crypto_openssl: Clear PEM decoded key data before freeing it<br><=
br>crypto_pem_decode() decodes the tls-crypt-v2 client and server keys<br>a=
nd the auth-token key, and frees the decoded key bytes it got from<br>PEM_r=
ead_bio() with OPENSSL_free()=2E Use OPENSSL_clear_free() instead=2E<br><br=
>Assisted-by: Claude Code:claude-opus-5-5<br>Change-Id: I6b42785de99ee1e6b5=
55d8c5e61ebe2ae784510e<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Eco=
m&gt;<br>---<br>M src/openvpn/crypto_openssl=2Ec<br>1 file changed, 1 inser=
tion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/77/2077/1</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span=
>index e6abd8f=2E=2Ee6873bb 100644</span><br><span>--- a/src/openvpn/crypto=
_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br=
><span>@@ -528,7 +528,7 @@</span><br><span> cleanup:</span><br><span>     O=
PENSSL_free(name_read);</span><br><span>     OPENSSL_free(header_read);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    OPENSSL_free(data_rea=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OPENSSL_clea=
r_free(data_read, data_read_len);</span><br><span>     if (!BIO_free(bio))<=
/span><br><span>     {</span><br><span>         ret =3D false;</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2077?usp=3Demail">change 2077</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2077?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2077 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--BEx8Fm947Mk=--


--===============2457912308346673506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2457912308346673506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2457912308346673506==--

