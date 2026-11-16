Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B8606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QHTdmrho;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZdoJ1+qi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DkN7wbk7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QyehaiJ3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=nKUAH28JG8ZTfvKSU+Cs8Wdgcw/V9Fh6/WGMLZ7FZ1o=; b=QHTdmrhoESijVbUby+ucc53N5t
	yIrKXAEwPxHL4yudCug8CB2nC37pewlzmxuKCAnPSnBLWgXVnpIUG5/PuNjThiJBSZ9TYzkh7fzZC
	1EgTOuymZ12v3Va9j/B+gYI3g2AE2gKFjCW8NZqIBYKHKNoTGv85M7Q087BOjHe278sA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSvUt-000000001oz-0PjR;
	Mon, 16 Nov 2026 12:07:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSvUr-000000001ot-1y9t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:07:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WN6SYrNCQ5Dx2uX2qDewHfc5NWZ9Lzd2+y2bKRq3YgI=; b=ZdoJ1+qiP2cqhv97qd+0QkbhNb
 93mz6ylcEIcdCIO6W+aYKyF++qOfBeWoVr4DPBUOnAZ26WvtFJAcP+0ApX3QfADVQKEnwnCBiU2a2
 xE0bnkF5n8I80vRBppDr1NWagEhsSXC5DGVZoep3BLRcrkJZSP6NLVPBot61fx8iAY8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WN6SYrNCQ5Dx2uX2qDewHfc5NWZ9Lzd2+y2bKRq3YgI=; b=DkN7wbk7rnd7FkA7SsUlpT5PwN
 CUx5wu1GNr4+FXiPuAtBDXAUX8h7sXxI+ofdlpK7qCHimDZ/y3ghiefO0lzGS89MNmb0L07Jh1kDD
 VBbm8eqc7QSDuExMiPtZ0GOCN4wCgdUix3g+ZlkKHJooaOcaVVF8zOtl5/VVqMP8h1dg=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSvUo-0000000030K-2ouu for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:07:41 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so9070975e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794830852; x=1795435652; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WN6SYrNCQ5Dx2uX2qDewHfc5NWZ9Lzd2+y2bKRq3YgI=;
 b=QyehaiJ3JsqRYoDdxEoRJ5xneJ0Zaq3QTNx9zlSyEJIT+d+E3L/g87n6qmCvhjkh0p
 HAVAM3nsBbuNJlMCAkrrGn+7mw/YwJbEkKFyFrba+KzwyMkic8ID1hKAgZL0G9pbtJGs
 Za4ILsQ7FNemJMi+TpLwwfABwZPXQOyijzJlzLRjuhSDTldlfgODBWb9jiiZegLhcvk+
 MYnsP1zMx99F0yiria+jB78pbjPuQdLZJMFIWUtgpI10lqq8/OyWsspoWZeUEuXx1Dpr
 I1XPT7p49mju4d1gkJfCPzqQcVRMnWGz8XA7SPIcXVXJi5V9ERGXJWWduEhM5qceEEo3
 holw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794830852; x=1795435652;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WN6SYrNCQ5Dx2uX2qDewHfc5NWZ9Lzd2+y2bKRq3YgI=;
 b=vpF34vYhwjw7qdO4mVF18TaIA3csgh6VWve6VAOK/mInm7347cLEXQdodBA9HXWzug
 D72IHHxJf03CN63xyQb6NlK9AZ5atieD4hp2VN43U9dcTXjMOcJ+Twp3SfRudERgmbI8
 hWNm/j+HkbJoE9TC42Crs/STsfhUsBWwPx6otzvqauUhYo4r24AHZ5AZwZocBwZQTQH3
 h+ZNFHAmraOTiARrh8aB7SDOjUF+1R6Y/skWiNFnYPmhcG0i/BQqR7gBQWSDbsuui1nM
 CHjgJyIdW/ZyNvxrfsbJCbICZLUyb83sChL23Kd0Um8ihrARFUHXFOAxP50n2dGZDLog
 BDRw==
X-Gm-Message-State: APuU4Z8eV0vX1lxZ65YeZkgbpohLWyuPS/QnKSAUWW+3aFld/OKzd49M
 0MPCYs228luWeN5EnFVNrLSg0ALWPXEL7mgfHAvw7+k56KIfqHRhcnSU6v0cj6aMn99awmLcnZw
 DQ8h1q04XThvber7wRmORG6bdlXXpVHbtXQMo+IiWeedBuYnsT8v11uCJ+75gY7Qm4qry21zRzW
 GPPveJvw==
X-Gm-Gg: AYBFou264BT/3J3Nke6skwLvOzTDre8ou4uEiSA9lNVs0GeAfkHKXs6CgDDt0ln+Rp7
 vmjAIUFN2Y7Gtp1jUckP0NmUpmsBPvThEwEPaM1ob+vOKH+sw8iyusBxxM9V+2nS3+hQ9EAc73c
 Y8IAIWqj0ApdImZijng2pzEwRTFhiePP6rtVevqY8XmRFMxdy/37GImd3NqMbaM7JiiPCxXT42k
 Brg4dn2/IgCEp6VVaagHLnkrykkirIv3Kw4/0fxkTcssR/ghd1SCEbvczLrCNm3ciO3ZtBco1SR
 02eJ+NZeMTcyYodUz+iO94cPDmm1E/INlM3m+9DV1ds/c9bF18Xb5GksPDrO5kxT15BzY+9Smcb
 lT+oHNxlycWl3a7q9SJiMor60RaFXmFRKKX0sqElR0iwXbepQxRvm9eitYAMDQeP3OnJGTv0xHj
 0puRPPDzkHVGUm0kHv3gBcoO03jCS+Mnh38d4QJH96G5jXGFM8Ht4jSTyn89VbxDVbT3bEGxF0z
 +faspPRuB9gQskxr4EnYSlQqvEZRsHU/dBkgUeFLLCt/kMmExRfLZmT3xVI9jk1RU7Bz5vdWGQ6
 kTEjJ3AmAlR4+HDy9zOLBkoa8lyll7IVSLl80Ugs/uITgSO9y2QXiZDSt37q4jIR4ER2MO9s3z1
 XYFfnTfg2Xj4X0d/rWjBj3gsPfDVS59egPlyeIH/7t93PGeTdBlvph1pF5FirC+lvlayak8yJRP
 VeKcck3MOZEGDv7+mM5s0u7cHlp4t3hCA4sNiI
X-Received: by 2002:a05:600c:8b82:b0:4bb:6814:7391 with SMTP id
 5b1f17b1804b1-4bb681476a8mr124468645e9.25.1794830850079; 
 Mon, 16 Nov 2026 04:07:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb729b2801sm67250005e9.5.2026.11.16.04.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:07:29 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 12:07:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891
X-Gerrit-Change-Number: 2191
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2191?usp=email>
X-Gerrit-Commit: b252559ec6fc5ea9de624b7d2ba5e69bd8775ad3
References: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMwODQ3MDAwLklmYmQ2YmFkYWIzMWE0ODY1M2ZhMGJjYTdmMDg2ZGIwNThmODNmODkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6af83366f4dfbb9d840308b00a57bd47f2d31a01-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSvUo-0000000030K-2ouu
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: remove
 --client-crresponse temp file
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
Content-Type: multipart/mixed; boundary="===============8761896506792480908=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8761896506792480908==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WuEnjG0frh0="; charset=UTF-8

--WuEnjG0frh0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2191?usp=3Demail

to review the following change=2E
=


Change subject: ssl_verify: remove --client-crresponse temp file
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_verify: remove =
--client-crresponse temp file

The file holding the client's challenge resp=
onse was never deleted,
although the manual says it is removed after the sc=
ript returns=2E
Unlink it on every exit path=2E

Change-Id: Ifbd6badab31a48=
653fa0bca7f086db058f83f891
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
---
M src/openvpn/ssl_verify=2Ec
1 file changed, 4 insertions(+), 0=
 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/91/2191/1

diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/s=
sl_verify=2Ec
index 8641d15=2E=2E6792d91 100644
--- a/src/openvpn/ssl_verif=
y=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1487,6 +1487,10 @@
         tls_=
deauthenticate(multi);
     }
 done:
+    if (tmp_file)
+    {
+        pla=
tform_unlink(tmp_file);
+    }
     argv_free(&argv);
     gc_free(&gc);
 }=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbd6badab31a486=
53fa0bca7f086db058f83f891
Gerrit-Change-Number: 2191
Gerrit-PatchSet: 1
Ger=
rit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>

--WuEnjG0frh0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_verify: remove --client-crresponse temp file<br><br=
>The file holding the client&#39;s challenge response was never deleted,<br=
>although the manual says it is removed after the script returns=2E<br>Unli=
nk it on every exit path=2E<br><br>Change-Id: Ifbd6badab31a48653fa0bca7f086=
db058f83f891<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>---<br>M src/openvpn/ssl_verify=2Ec<br>1 file changed, 4 insertions(+)=
, 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/91/2191/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 8641d15=
=2E=2E6792d91 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span=
><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1487,6 +148=
7,10 @@</span><br><span>         tls_deauthenticate(multi);</span><br><span=
>     }</span><br><span> done:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (tmp_file)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   platform_unlink(tmp_file);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span>     argv_free(&amp;argv);</span><br><span>=
     gc_free(&amp;gc);</span><br><span> }</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail">ch=
ange 2191</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2191 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--WuEnjG0frh0=--


--===============8761896506792480908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8761896506792480908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8761896506792480908==--

