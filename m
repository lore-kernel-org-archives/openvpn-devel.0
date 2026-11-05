Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B6606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HElQ+y16;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mB9tIkng;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CNMS3Biu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ccOEECQq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VcmzlvW+EaMEa8EsQuesmMcfcLMhmzyOyX0ixC5RvpE=; b=HElQ+y16F148QjPuTD257jGRRY
	PtIQQXgoQCmgfXE3gLV27+M1fdvXPk06eMeB6n6tYKb4Knu91Ai+Wya/SqWm4S8A1MEwGqRp0/WB6
	0l1Cch8F0MlTXzCxF77vV2s83UjfdkSYWM3pdyMTig89JJ3aVmvW6WAw3SY1s8zwRlkA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOt7e-000000001C6-0M6m;
	Thu, 05 Nov 2026 08:47:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOt7Y-000000001Am-3C3A
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 08:46:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0P3z3ts47Mie3AAOPdENnL9wsYdj5uzwKoj94p5A4mY=; b=mB9tIkngyz8Eo6bbsLse5vOYkc
 SJhW8DR6Iiuneu4fY5XT4HWOoGuoUL8bs0iwlF63592tCGgpD2G5RkV7qB4oUyjs3uSGBW/IalIps
 TQDj2aPx7g/U60k8t8uTF/u7BsAfuO4BAaF8UDvFUZMRB4TNsdtMcmPUduzclDSd7FOo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0P3z3ts47Mie3AAOPdENnL9wsYdj5uzwKoj94p5A4mY=; b=CNMS3BiubkSusQEOQOJ4WsB/kv
 8pTbcZnl27x86ZXPTnYEoaysalhQh65MfTUw9oAGveSw5LstyKo5hhIaQZsJNkH7JGU/YqZZtUpYL
 XvaVYTya1NX7Q1sUus3iEUDgBYlqyUQU1Mk3uNQsnfxCYlsQtTF0FvAUjzKafdkf7PMg=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOt7V-000000000bK-34GZ for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 08:46:56 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so1045947f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 00:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793868407; x=1794473207; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0P3z3ts47Mie3AAOPdENnL9wsYdj5uzwKoj94p5A4mY=;
 b=ccOEECQqlgNMGtOTezPYub1ynqUIZuk1JWtURrTswZ0OehWvgn+WlACbdhM60jPZvU
 QA0IHRjEAqi/1zrBcu+mUK4bX7pGPr0+bjMJWNKKBxrCm4UHKEusJ4jkznRUjQOa0YbN
 e6LKV0Vdft2D0EUCBl/RRD4AAH7C92lnQRNOZezXijL7ZM+9zkteplZ9cBgWWh/rkY7T
 OPfbVd7sA/sDJQ85fGDofj2vpP2sThtGWyZhJ5DMi45DOBS2iM5nvMEuYViCJGIi63C8
 /LUD+A/+KfiVVYK8k1CjIT0XFnNgQFj58QqKbO9IbPW7DTDbsOMHcqm3Q7saSSRaNNZN
 gx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793868407; x=1794473207;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0P3z3ts47Mie3AAOPdENnL9wsYdj5uzwKoj94p5A4mY=;
 b=n81ZZAKo4t62aUkOBmy4dI7+7XzU5gZKwwk8AF+YyAefLPhHziGc+J00IZAAHxaqIf
 7Rw5Nb1RqkgdNCkyvn7v7XDJRyh5PP3YsNe6QlA7JaHBJQxjZyvr84DTrHr9oamhd2cf
 Rd1FpBdUIiKq/VS0lAHVilyqCy5YgFy55dr58zonKS+HC+f9TUVu2wXtHTLt8mJU9PUO
 TA/eatJb7oodYl+JNnImaHmPRYC0lvnXrRwozlgzLIwmfmvTkL88X4EivPfz0ttF7Sh6
 TlDsGM0P+Bgz5x4ml4h71omU6hbEBeRc6oFHOFaQQmeaF29fPbkbSeyP89ukOnnZP6u6
 UwIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBwvTPrkXqpoflw3mesPgJKfOPeAdYhBEAXVOWJg1l7FKmxh9ebfH5/56oWouTh03bZoXqOR4gfuLKUJ8i@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+uCjIAUkUAzf7ELuflvUApVgOsO+eg1tl9OGgjXjmosLVt29tM
 NxwpGdEs9UnvGSnZ/nQq4k4jYwhK4tBpR099489rNywOFbPL+UPgtSifSheyKv3kRJtvfTlfxqJ
 MT7+UJqjtONYa117fURfmyAUcnq5Bc/pM+Exj2v47OPuss+MnB/zPq2ROMe1mmrhg9Jd36V9J0R
 pxvLS5lw==
X-Gm-Gg: AYBFou27nOUK4FurrXgECj7PnZ2ONJuD6aIy/K98rH56c9T8J6LqVMg9JLwCyCaxWE/
 RBuL5kyiXwZgHPm0Zv1KL5uxRbfjapTHlFx2WOTaTOT53Ot2/mDltI2JoTzQrqi/gAuqRJfbrs3
 9R2BRm63PRKOMC2cM4zJn7yk+DRp+mOrmurMHn+v5RYkP592oLxq9YrPP9PxfOdHeQCZHcizClM
 sg9trIdXSDX9MoRDlDitMy69EFepdvA2m7JDX6z/Y7s19kdsi12AcSLIzQy+5xXV6ruuq5W+hej
 mm5EXtNd7xhOubMtxZBqUbEz18NuGlBs8s6lyuEF5HPHY+HiadooPcUjz5EiyUHzlWQ8/0PDFBx
 xFN5yNEha3V0hzvPkA6SZCO6xpb/Yi6DlU3V8EewAZ13albrL7Aaxw+pKUX4m/JuhvvdIj7wrqv
 B1Bmztbv47+feUyu/CaMVivYlBkfk72ZryeW84otu0VXsnTN4y15/MlXyzydf5aBzfOZ9t83T9Y
 xqgoWrVF+26aRd48+5z+MevwOTPZbXMFFDpTA/5k3dz2FbQG51LzYe390olABYC48XYKW6QR1t4
 GvIBJVUxPM6/sdVoO8V0hY94a/eeu3RWCFaQRo9UiLvM0MvVGekdysx5rP1u4ehGke0j1mssMyr
 JFn7gs+BXS6XDNO8Y+avzF1wDxiNa0/H5E7/UajgJy6hnOelPlo7AFP7QXXP7frVhRwO8LWonbe
 5T+WdH3Fkh7pqllg==
X-Received: by 2002:a05:600c:a012:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4ac17b2ce18mr397406925e9.27.1793868407072; 
 Thu, 05 Nov 2026 00:46:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56b78d656sm56010685e9.0.2026.11.05.00.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:46:46 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 08:46:44 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic4243377c96a3b460d69050386cddcb30535de27
X-Gerrit-Change-Number: 2078
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2078?usp=email>
X-Gerrit-Commit: 30fed23777f60a5c177d45143363f507246c2044
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 08:46:44 +0000
In-Reply-To: <gerrit.1793580377000.Ic4243377c96a3b460d69050386cddcb30535de27@gerrit.openvpn.net>
References: <gerrit.1793580377000.Ic4243377c96a3b460d69050386cddcb30535de27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNTgwMzc3MDAwLkljNDI0MzM3N2M5NmEzYjQ2MGQ2OTA1MDM4NmNkZGNiMzA1MzVkZTI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c03bab7f229d7054bce8af731db09f071b8e0038-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOt7V-000000000bK-34GZ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: Wipe the
 struct key_parameters copies after use
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, hansaemw@gmail.com
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6202821215230217632=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6202821215230217632==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TLuUCb/F/gg="; charset=UTF-8

--TLuUCb/F/gg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi=2E

Steffan =
Karger has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=3Demail )

Change subject: crypto: Wi=
pe the struct key_parameters copies after use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic4243377c96a3b460d69050386cd=
dcb30535de27
Gerrit-Change-Number: 2078
Gerrit-PatchSet: 1
Gerrit-Owner: Ha=
nsaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 2026 08:46:44 +000=
0
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--TLuUCb/F/gg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi=2E </p>
<p>Steffan Karger ha=
s posted comments on this change by Hansaem Wi=2E</p><p>Patch set 1:<span s=
tyle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: =
4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=3Demail">change 207=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic=
4243377c96a3b460d69050386cddcb30535de27 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2078 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;ha=
nsaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Nov 2026 0=
8:46:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--TLuUCb/F/gg=--


--===============6202821215230217632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6202821215230217632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6202821215230217632==--

