Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB35C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i0naUgLr4JYYNdLtEXRHery89ijAqC0q1/YYWUpyUhs=; b=C0DOIvb3yrcSZwxk75c8w9L/yn
	aM5iMzBfsYU7EFX/Zy7JeJBN96spFxMk2SD7sbCpOwHwL/cX4+VEIfFes6I+olvskaLGN3XmwoCvt
	lPIbLLY8rLKjvyS5w16ZYQ9kl6xBeiuHGv8jtoqtOIZXkbFfUfA9sYGvLNS3H4b4kvVc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiXg-00042t-98;
	Wed, 19 Aug 2026 15:49:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiXd-00042l-OV
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:49:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4D81oqQN+hGOnPkk+9aZ6pglWEreHwhfcujFM6rI44k=; b=AM7Fr3uLH6a1sVzjNGRx7VfX9I
 V67wAQk0obPJEGg3dqeqLvABqfgn/+OsbBGkOJyrLL1+BrpvQRPfFDOV6FmYWdndawlUEEkPNKNmO
 UyJcfjfhzVfjgaqR0y+nYD3jV2Hs15qomcy/F2kiTXRS70HCbsRIcGhBXfqysKtmeNgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4D81oqQN+hGOnPkk+9aZ6pglWEreHwhfcujFM6rI44k=; b=j
 fKspeb1uOaD3s6EeVoH87WMabSS5pA3/sOwdlOouc7CziE6YaFdjtP0YQuZ3BOSADSHopkZqAa9SY
 +/LbIDIof7//ffLR2sV7d1/1KutCQZ8WYllW37SRAqXdjOn4tnTyqFcXZ1qw01Su5WdVjOnr8g+eQ
 Z2yusbwdWjUfxuu8=;
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiXb-0008Hl-7W for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:49:23 +0000
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c2074710751so205434866b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787154556; x=1787759356; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4D81oqQN+hGOnPkk+9aZ6pglWEreHwhfcujFM6rI44k=;
 b=ffGWPD6ekzywM9pxHnW4G3ZW3pkutRoMlHQweyh++4aZTxgZPkapBGqkitYqIpjDXh
 473oN2MyVShIZqoeEwaj+eSaaStQOb4kOP98rgDfiNku/fXjDz2pt6CfTQ2CabypMSjr
 hN0RC02EJHHYyYvsCDg1rXI35bmM/yKeA5J/JyedfO3wx5JgbCsRf0BGx1UunOOHO+z8
 VgOYSxC3oBXWsisf8uB6+KMV8l/P/uHQj+9VebG+9d05cvk9a+wQC8tPuQeQeNwlX53t
 +cRsULTqQeEoz9+LynioeYw5B3bzO/20o5yi8NM/46EF2GNcFCkwxClaUhfeCjE29HZk
 CY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154556; x=1787759356;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4D81oqQN+hGOnPkk+9aZ6pglWEreHwhfcujFM6rI44k=;
 b=bJ299r/6jBi2F0RMoFp7DAdjIIO1eIZVmCA2ZfGKC8MMHTqSF/47tevts/DE75CeZG
 7ItIFZP8lwqunz5IRWOrF2JLjNn5hcEnVtXzeI/Ih1rqKqsrt3wMVThEDKDS7qAE81WZ
 0Rfo4ZDgeaqXlRQX35AegVMdKCptwwllfmtL4LQS7p28RoAgzA+/F/p1tNLkUUziFOlx
 8DzIZz2vuZTN5ou/ct0He+1FtYtkAWiqK83NIvaZyQUws1Oz/sMmZbG4l2w0kOkcyudc
 82oEcB4EwAYqey+3f6grPcHg5L2OZ8aOyTDGAHDflYxdacPWoyt4zhZvh80D54F62h1/
 xj3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8qJwI693TekMm+G4xXtCMdDm0LrC6ydwX1t64Zcu1PCPpzM8HA74On/ND4Kp219EkPQBml7hQDxRfThVO@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyMGOh4KTpKgR/Weiiat+dVk6bVpWUsTI/C0l9PQxed0ftD1wH9
 CKQ/zQ7DdBUamac++dlzoxlqGXMfd9PNx9nYOYCJOoKu/z7hTNir0HxqEGfp/M2PVGtj0f6+cb7
 YOSIdMpYQ9TDmkUO0Q+Uykkdz5iT26puFdvING8bmfs6bUfvwG6uYJSyy7/Zp+vyAiDJzgWir5X
 Uk5A41eQ==
X-Gm-Gg: AR+sD10XkoaFweww9C2TxGsNV9WkbT+zd1LWuqfuEiGdST/ic7aO/98F38iAN9ZKu+I
 6IJVjNRmOwNdJ4x+UcIYRZvs0sryeUVSzUB2eK+HyZ7As7uVoEDbXY8ZLMIH2j0SvsEVXWc0liK
 NESWnojphhbxdsEnyAgP45QljukStTlt0fhg7Bm1YwXdfLj499gASNg+Y5Y+50Cn5GiyxMLhEnS
 5w9AU8X2I1GPcTgoFI0QCkWBVsyt0GFoKZZXLi//cz17bjuk6jnWBeRwGYMs1DdtOzpj1qt1cGw
 xwPtKrETd6J4HhN9FxUnbumzVhGzxxzA+9jHKdeBbs6PCC13QeRtTwpD9VqII6Hs9x7V+2Eogsg
 J53J9pF2HIty/NCv6m0t9uAokh8n/9sMkkIwk+iy2ai8U55nEzuQPUZf5+XLaKf+QY/e2+pIEk4
 Syyi2Wll9YEms/didq1dpmAxIgb8+/RU2yne6XctgvL6OSYZ7CWFebEoaGW5AKV4UWpWu3+QLqX
 9fT0/4SZOsgGP4d+dkc62i+0qf0IJV4T797yiSz8Bud+pAZhPnGJOJNBNH1KooACLsaK1OeNzqU
 VtIb2jVbUyn/vMO/Dt1ASoYKkCdHcJ3bgsAFZIfK1rv+exFFqc0=
X-Received: by 2002:a05:600c:1908:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-499aa17d6d8mr97938355e9.1.1787154226737; 
 Wed, 19 Aug 2026 08:43:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17f202sm63691605e9.13.2026.08.19.08.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:43:46 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:43:42 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
X-Gerrit-Change-Number: 1661
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1661?usp=email>
X-Gerrit-Commit: 51097ce2f882c92214ff03a390ee0ed543617c4c
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:43:42 +0000
In-Reply-To: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
References: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDEzNjAxMDAwLkkyYjcxZGFlMzdlYmU2M2MyNmE2Njc2MWY4NzdiMjVkMzI2ZWQxNDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e07663dddaba6cb3135115058273cbb7fba5b49a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiXb-0008Hl-7W
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constVariable/constVariablePointer cppcheck warnings
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6131869845661738452=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6131869845661738452==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CJUDACcqm34="; charset=UTF-8

--CJUDACcqm34=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail )

Change subject: Remove ins=
tances of constVariable/constVariablePointer cppcheck warnings
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13: Code-Revie=
w+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b71dae37ebe63c=
26a66761f877b25d326ed140f
Gerrit-Change-Number: 1661
Gerrit-PatchSet: 13
Ge=
rrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-D=
ate: Wed, 19 Aug 2026 15:43:42 +0000
Gerrit-HasComments: No
Gerrit-Has-Labe=
ls: Yes

--CJUDACcqm34=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail">cha=
nge 1661</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1661 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Wed, 19 Aug 2026 15:43:42 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--CJUDACcqm34=--


--===============6131869845661738452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6131869845661738452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6131869845661738452==--

