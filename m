Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8155606FAEE
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SGTttNS6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QHseulg/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ks7PPSov;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aNsjL4LX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=DoTOoFxvSrSG4DzgjHqVPwfNvm8dnVmSByXWvnt8OeU=; b=SGTttNS6UHKRpbayxnjQuVr35H
	o6CAXKmO1D2U7aqQehjjkxah63SLohL0uOb06oAtnq6T2U4iQQv4Tg83x/AquwXtDPQEcJ7xy4ec3
	Vy5a6Yds9RGb8RV6azecrRS0qTvmXEu06pnbeY8Ol8f0tuOTwOC25DooPxCNDCckLixU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCRn-000000001mF-1rXP;
	Tue, 03 Nov 2026 11:12:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCRl-000000001m8-2HDw
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B7e5DLcm3R/Lb/bn/NEZIl142Foye1ADNahfMrMYMj0=; b=QHseulg/6qXHViibegnF0+yyXD
 OdVo9e4i79xI7yBdZbCJuGEhaAe32nj+8hgOvwjnUjemNlvCzbnlcp/JU6kjLtfWt/SACiskLeqZo
 N6oGT+IBKLdIusxfp0XcFG1Awmy5zN3HlCoKxVjOqxA/RUIGVYGkZnzhOtULJh+JvzfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B7e5DLcm3R/Lb/bn/NEZIl142Foye1ADNahfMrMYMj0=; b=ks7PPSovQR/8QOqlKs/I2rsGf6
 87vN16OgVIcy5L36fOp/C7fVLDzYTLuo2vDtQtiXvQPHOkOsvCIBd6NYHyDZ/KjENVo1wfCxwF+9i
 f8etxeZ9ihcrLGsP0KP55JaZwO8E1VqroxV6gKGKONdpuCCQDHJlzFgEKOa30fs/ir30=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCRk-000000000UI-3orF for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:12:57 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so25303005e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793704370; x=1794309170; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B7e5DLcm3R/Lb/bn/NEZIl142Foye1ADNahfMrMYMj0=;
 b=aNsjL4LXHq8e1wdq2YFOZf/oNMf0WHiA+UUSKXE0v5dBxfLIsMuA7AVSm3QMjEK42H
 hkkKodLG3X+fStFyXHTPQSWct4n4KPTrUJMHJ9Ghypc8/q6ebAKzG5kuLSb8vYZf8QJS
 fFaEPonFxlAwo/ixWETG2D7dOcLHzwis9IrfMaetKRN8kuU8Hdhdtl9csu+sqytSfHSF
 JfLoUaaQ/slgn90n3dv78CyXzgZEWgpBSs5Vij2DH4cMMZDTxEWCNPTtrLVKJDLgGx9D
 i7VVOfqYgqO6X3mRIpr341W94JfoiXAmYkhqWtmMT9An9wFN6JjGFa/t2znOuygyCMvd
 nMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793704370; x=1794309170;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B7e5DLcm3R/Lb/bn/NEZIl142Foye1ADNahfMrMYMj0=;
 b=k3DYzjbc21xistcOpRFqBgmNBo/itR3ms/Iz3Csq68zEUyaET4ZaVwlZwk0GhGEbnx
 5MzgrFiXzJMiCKwxU0I1wlpMm/UW36ji5eRMVoCR7KI+62NZS8Ts/8IgfOuMWa1hvLy4
 ZoGWJm5AfViTE4d6830nRivCjcBgYUc2Ig8ELIBhAqdsgOrK5JUUgdkN3Ic8QEbJifjS
 JqGgC/VReXpgp+N/x8+kQk7R8sJiq8ujTa55wMGOfMnWC5r7zY2ASH3e02BRiliNrajT
 RicI5S7xq8ikZEh0dCjVkJIvjU8kIKSKXl2loM7TiG8wzTyasC0Qc5IHllqy1a/vFhxh
 4V/w==
X-Gm-Message-State: APuU4Z9DEqh3NXKjbmXt4aX1g1AvaSacjlc0j1LRhiQRYzzVW0dmeCG0
 ioGmnvAy86x8tt0etU6EwE+YHTh8glo29iphOXahtYfnG69RHAR8OwMBqxwaJ8LkP+nHmf+74IZ
 qoP7x4Hhidy8dTpAs7XKBZ5hOgtrvcS+eWDTDP5cBK0V/tG13RuD1H2t5Ca/ZfEKZSeDdHNubGU
 SoZc1Fyg==
X-Gm-Gg: AYBFou0GwX9HFgE5btIg32n7NoC99pWCYMXvOK6HalBGVUj9luo+vdRWX0R2wXSOHQO
 YttlzVsU/klJuPB3J5nY9iJGacLYhEeFojQ5T6FqbWXQYvXcmnLSS+/3e+YolGSz2r9Sunn07YS
 3490kLOfG4olSabpsSbQOTHd26ztpP2Wqpmhva6pgKpZ3b0KLM361U+4mTYZN/VQE94Sx049nDe
 Q3FWEoEa23ZQmhEZ6JX3ZnYbdyhuQ0ufXU/6T12NwIPXi5I0EwXMbWrh0m8bw5ALT/VDyN0VhYc
 Tf8vIr1OEWWcqeOHbqorYge+6V6dQJgdRQ50RZ/Zu4b+7pdgbi2UI5MDrc3vrTn+UE7RpyQeDJD
 AMS8FNPyZkAintm79dV7xnAOX6HPE69Yjzt9Pw8SpCjA39E/1d8KS7ephBXbCkB+8a9dZm0UYDh
 UZ9thi/lKQdId3lwTIxHdI6B48KdqE0IV4uS1S/1XVICz68DPXMwT7lZg2mrUyQY6jcTZ4wEJWq
 C8EzWLbenTXfesseG9D31fmjnijJpkAKkzfY7MvsHaNVKjKcxLayE8AvvokfbPZF4NfWiZjJ2v9
 IqWGi2w/r69eLcf6QEnIbx1rgJ+IKTA5b3VzcwadjLeJ76SC5Z15bMQmGUGliCrq7uwURyv/XfE
 eOn8M7AeV5NUNC9DkJ8SYNuLVYGvAQ0iE1juSJxwTFZtwXC5hf49ASADuEh7Nt/TONg9CmrcTHs
 Bq3XV0fpOC3r49Fg==
X-Received: by 2002:a05:600c:698d:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4ac185bd1e2mr292737025e9.16.1793704370268; 
 Tue, 03 Nov 2026 03:12:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cebdbsm54717745e9.3.2026.11.03.03.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:12:50 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:12:49 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I88ea70e88c3ec133261210e0404f324bbf025d9b
X-Gerrit-Change-Number: 2104
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2104?usp=email>
X-Gerrit-Commit: 2e4286ed1029e47637279a5fb585c1a3e6fa96cc
References: <gerrit.1793704368000.I88ea70e88c3ec133261210e0404f324bbf025d9b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA0MzY4MDAwLkk4OGVhNzBlODhjM2VjMTMzMjYxMjEwZTA0MDRmMzI0YmJmMDI1ZDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38753ffddf168e0411df82a373941bfdc2d94aaf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOCRk-000000000UI-3orF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proxy: free
 proxy_authenticate in http_proxy_close()
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
Content-Type: multipart/mixed; boundary="===============7138729624286471806=="
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7138729624286471806==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rWeJnXE1Xmk="; charset=UTF-8

--rWeJnXE1Xmk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2104?usp=3Demail

to review the following change=2E
=


Change subject: proxy: free proxy_authenticate in http_proxy_close()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

proxy: free prox=
y_authenticate in http_proxy_close()

The Digest challenge stored by store_=
proxy_authenticate() was never
freed when the proxy info was released=2E

R=
eported-by: hz86 https://github=2Ecom/OpenVPN/openvpn/issues/1134

GitHub: =
closes OpenVPN/openvpn#1134
Change-Id: I88ea70e88c3ec133261210e0404f324bbf0=
25d9b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/open=
vpn/proxy=2Ec
1 file changed, 4 insertions(+), 0 deletions(-)



  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/2104/1

diff --=
git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index c3ad7de=2E=2E7b5a=
289 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -523,=
6 +523,10 @@
 void
 http_proxy_close(struct http_proxy_info *hp)
 {
+    if=
 (hp)
+    {
+        free(hp->proxy_authenticate);
+    }
     free(hp);
 =
}
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88ea70e88c3e=
c133261210e0404f324bbf025d9b
Gerrit-Change-Number: 2104
Gerrit-PatchSet: 1
=
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>

--rWeJnXE1Xmk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">proxy: free proxy_authenticate in http_proxy_close()<br=
><br>The Digest challenge stored by store_proxy_authenticate() was never<br=
>freed when the proxy info was released=2E<br><br>Reported-by: hz86 https:/=
/github=2Ecom/OpenVPN/openvpn/issues/1134<br><br>GitHub: closes OpenVPN/ope=
nvpn#1134<br>Change-Id: I88ea70e88c3ec133261210e0404f324bbf025d9b<br>Signed=
-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/open=
vpn/proxy=2Ec<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/04/2104/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/p=
roxy=2Ec</span><br><span>index c3ad7de=2E=2E7b5a289 100644</span><br><span>=
--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec</sp=
an><br><span>@@ -523,6 +523,10 @@</span><br><span> void</span><br><span> ht=
tp_proxy_close(struct http_proxy_info *hp)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (hp)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        free(hp-&gt;proxy_authenticate);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     free(hp=
);</span><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?usp=3Demail">change 2104</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88ea70e88c3=
ec133261210e0404f324bbf025d9b </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2104 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--rWeJnXE1Xmk=--


--===============7138729624286471806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7138729624286471806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7138729624286471806==--

