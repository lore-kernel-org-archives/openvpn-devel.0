Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887C606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T++DnDpo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jwb1wv6R;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=P7Z3GjWX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hAJ3J4Lq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=cqO1HVinE/BHRqrpiHuwZ+fCHmnmZ1mRjw8YL2EFqNs=; b=T++DnDpoo+8ife5HSm7KMhmdm+
	hY5RR2OuZqCL5hhJObZb1OildRvyQCX8JjcT9Jrx84n7hJYTFahkP2ilnPDcNrTxwA29HS0vKpK9A
	IPjVJ26++myaxtme8o9mO2VLvOo4bGnUidgf57d2BJ9NUj4PmZGaU7gjk88hgdCH/aSU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxM1-0000000038t-3LD5;
	Fri, 27 Nov 2026 14:55:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxLs-0000000038h-3Ed8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:55:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ozqNpb/wDxa44ad0JLZAReCzoG0GFu9nV1jJN8DPoKI=; b=jwb1wv6RU7O/RTgjfI6dbDvRM9
 vt7FhuIOAAF0IWXRqybgu4Sfu/Wsf1CLT5voUCDYB+//P81ELpUIcjjqZVJ/tgwZhQ1ttA95m9rW7
 rVGeOD1iyz/bW//qfTf+2NwWkndCaQlWEsQJIxbYVndr+5URw/n+PSkAhqv725NlnaVA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ozqNpb/wDxa44ad0JLZAReCzoG0GFu9nV1jJN8DPoKI=; b=P7Z3GjWXVf8Wn9YZpdivS5IO5l
 3PP1LWwghOWMEK0copCSU/uKRTrPJ7TKjn4e/aMGQvr72kNm++x2UGk42ErGGCdaRIrI5HWF7RwyX
 d4eRTMX1SXSS6GRgtCF2v1JQ1nuJY7HLvBJMskf15o87dhauC8dHHNBDEV8CuulYWMGY=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxLs-000000006bW-0DBk for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:55:04 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so75221915e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 06:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795791297; x=1796396097; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ozqNpb/wDxa44ad0JLZAReCzoG0GFu9nV1jJN8DPoKI=;
 b=hAJ3J4LqnEnh/mCv1yGG9hfQCzfq7hHQCY35JtuvOjyiDG/qBzuzBbJGAtgdY+HSeO
 pXIxWawjXvjOAKDvU15iVNzXRb2H/o0GAxUk1JWy6/GPcy50Ne1WFUadNkHU0rCdLIdZ
 OrKZhbcLPbV8srvqPQN7rCSOP7w+aEAVt523OCZ0EMfmzEu7f0CEnntiP97tV8Uxl8SL
 j/dAeuIpox5o3ye0P93jX3CHah2yHrW7d57VUK3gBmnnB+HZAldBg4wcti2OibzoIY+o
 8JWYja3ClThj+Pbm9P5uLspb2oaJVlGz2lEgwZ9yiHJGVsiuDshEeYMJUF2bO0ZAmioq
 0h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791297; x=1796396097;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ozqNpb/wDxa44ad0JLZAReCzoG0GFu9nV1jJN8DPoKI=;
 b=GLFT1iFCkosaM+3QO5PZRYXPHZIvlEazGDrKN+MWbOlnLRfM0IiPDQ7mtXmaS6OVWy
 iaEgZJKfOWIGUlv5Tw4J6P6lE2zzE2s4VtD0GWU3zjzPMvLTNILvmZdq0tat94LQlE63
 hwzMS9L4laklL0G5QNZ7acNyiVZRvZ4/d5RI4pIAeIcag0Y//RMRqZkONZrYfzWqHfVe
 rD0AJ8pKxvVqiAmOSXQUSwpKdJqpu3zik4uGDZrdXmKKoCOZ1SRXYPD/gqtyGuV3qs3w
 HdLViusqF4dpLLcuy0cLZZlQTHcI1mzNFcU+3irUPovr/WRW0VootqBfnnKv6sNqnPem
 5/1w==
X-Gm-Message-State: APuU4Z9M3f8mj1D5o3BsuwGe8quK0tul2Fau14+JJhuHjzy4y/hnEVuo
 fQ3kgbZD+tXWHi5ecEPozI3TWp1ugGSYlQwW/cRHkz8JgOL+lDpx2hy4qDCdEZB0+VUDPvzPBuY
 m9bE8obL6qlFOdmblr/1cYhqLpEJsECPoMOUPvmI88fkFj+h/7jd0QCWQW8uN15v5coUK
X-Gm-Gg: AZFdTZcDbq+leTbV+ospFiUCs+jLqS0gUKLnfvHWlpE8hBW9SOxXfJTXTji6Wdenc/Q
 5adlBMAxYag6kxmRq5FvL+B0aFfB8ht6fDa0QPkIyutjntDxj9jSuIIT9M6wHVySnLTizFK3LMv
 FJ3HBkR94qbg6KrMRJbF+tOILajZH62GQGLWCB2D92Uh7+hhge3gmUvxl/KcbUjn42Ez2GV9uF5
 qCBrDWGvd99y/PS4FrJ9Kaxyo8xf0kyFVtw5pRv8Zam+S9le0G/6NQfRgX0ROWykjN9LLtDiVZM
 HRz5kL3cFwU0Duz3eUNZeCFOJoshWw7ZHvadHXTi1dERSKTgaKtRHnJU+61UMzqQwmUqoHCKxoQ
 /36Kc2KlvJJMpLZJsHr1ct/xm3KVl8r0tAQePMpVz156nstUEsKaSDeJpA1KtEA4jlqcBdZReyY
 9cT7PZ+qM+4WinnFp9HQqCkn9pI7y4FMEGWs68hx7Xs94vmJad2PS7Uuv2i0g1LvqupqRzWRRyq
 6yQSXy2wvXbooximmZDf91UsH4apGKI9zXyNdqdxSzN+M17ZqKUtEYZd0oKHKoztF23cXCaEBwU
 TxfKuZvhACVXchN0en/SYbQ5f/m574h47X9n0yhgAc4jRXS6fUxPf4V6+1Z/C3Ztfs5kb5r2uYy
 ikVzgpD3IE2m6h8w9ixvXlsbZudFkUlrWRzkEMSXLpneMi/idPsiO0DOd+DPz98gewMdobunAe+
 UrOHRYc1EMdtJ5xQ8=
X-Received: by 2002:a05:600c:4e87:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4bb88922c81mr495802645e9.32.1795791297287; 
 Fri, 27 Nov 2026 06:54:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a12acsm728667005e9.8.2026.11.27.06.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:54:57 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 14:54:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b
X-Gerrit-Change-Number: 2363
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2363?usp=email>
X-Gerrit-Commit: fa5e73dfb6f41ccdcf160708bf09f1b9e485873f
References: <gerrit.1795791294000.I8a1b576401313f826a188dc40f226726f378066b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkxMjk0MDAwLkk4YTFiNTc2NDAxMzEzZjgyNmExODhkYzQwZjIyNjcyNmYzNzgwNjZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bfa68bc928cb40afcb8d31be83c307aea33aa9e5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxLs-000000006bW-0DBk
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: xkey_provider: free
 the signing context when sign init fails
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
Content-Type: multipart/mixed; boundary="===============7699838634019554849=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7699838634019554849==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fX60tSIDeT0="; charset=UTF-8

--fX60tSIDeT0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2363?usp=3Demail

to review the following change=2E
=


Change subject: xkey_provider: free the signing context when sign init fa=
ils
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

xkey_pr=
ovider: free the signing context when sign init fails

xkey_native_sign() r=
eturned without EVP_PKEY_CTX_free() when
EVP_PKEY_sign_init_ex() failed=2E
=

Change-Id: I8a1b576401313f826a188dc40f226726f378066b
Signed-off-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/xkey_provider=2Ec
1 fil=
e changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/63/2363/1

diff --git a/src/openvpn/xk=
ey_provider=2Ec b/src/openvpn/xkey_provider=2Ec
index 9211c11=2E=2E7cabaf4 =
100644
--- a/src/openvpn/xkey_provider=2Ec
+++ b/src/openvpn/xkey_provider=
=2Ec
@@ -1140,6 +1140,7 @@
     if (EVP_PKEY_sign_init_ex(ectx, NULL) !=3D =
1)
     {
         msg(M_WARN, "WARN: xkey test_sign: call to EVP_PKEY_sign=
_init failed");
+        EVP_PKEY_CTX_free(ectx);
         return 0;
     }=

     EVP_PKEY_CTX_set_params(ectx, params);

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b
Gerr=
it-Change-Number: 2363
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--fX60tSIDeT0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">xkey_provider: free the signing context when sign init =
fails<br><br>xkey_native_sign() returned without EVP_PKEY_CTX_free() when<b=
r>EVP_PKEY_sign_init_ex() failed=2E<br><br>Change-Id: I8a1b576401313f826a18=
8dc40f226726f378066b<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>---<br>M src/openvpn/xkey_provider=2Ec<br>1 file changed, 1 i=
nsertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2363/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/xkey_provider=2Ec b/src/openvpn/xkey_provider=2Ec</span><br><s=
pan>index 9211c11=2E=2E7cabaf4 100644</span><br><span>--- a/src/openvpn/xke=
y_provider=2Ec</span><br><span>+++ b/src/openvpn/xkey_provider=2Ec</span><b=
r><span>@@ -1140,6 +1140,7 @@</span><br><span>     if (EVP_PKEY_sign_init_e=
x(ectx, NULL) !=3D 1)</span><br><span>     {</span><br><span>         msg(M=
_WARN, &quot;WARN: xkey test_sign: call to EVP_PKEY_sign_init failed&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        EVP_PKEY_C=
TX_free(ectx);</span><br><span>         return 0;</span><br><span>     }</s=
pan><br><span>     EVP_PKEY_CTX_set_params(ectx, params);</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363=
?usp=3Demail">change 2363</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2363?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2363 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--fX60tSIDeT0=--


--===============7699838634019554849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7699838634019554849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7699838634019554849==--

