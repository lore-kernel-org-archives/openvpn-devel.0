Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2FF606A327
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=h13FPhGn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JzbUOGDR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Lf32LGMP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aKmMJ+UO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NYGw5H+3Flhdc2KwtjKU/9vGfEmBsJ6Flu6VN2yUUYE=; b=h13FPhGngM+V38IlZkBdy9YpzP
	SmAsLo/r8C5X3w5AFNebpQTvV+0jw58qWdEMmAUYUb4uUQ+1mSsaz8TXL23nzSU1NiZDPm2OvZQER
	WmFAqYBO01MWawSDnMZR0A7FgdudocLVyn36ghdtZCDiBNL3kgw3Q0xKtBFaNiMjTTTk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWG7W-000000003lP-35lu;
	Wed, 25 Nov 2026 16:45:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWG6t-000000003js-4AsH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:44:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bfP6E5bX0B2T84wyhrAI44+0gr05Mow67tAd5MlIF10=; b=JzbUOGDRdulcP2vwwHDIj5sNY2
 WkfxjJ3Nmo3jPWn5lIRy3z75kQrxS0NzxLwcBVfuSBXWTqp2DdtILujWwQTyHmg6j5vZOrh8af3yU
 o4WNkf5t68ySdDsbL3TuKIMpYFnmt2UT+OKUVPg18hOhZjG9OgtnS4dZHexluqQ+fcuw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bfP6E5bX0B2T84wyhrAI44+0gr05Mow67tAd5MlIF10=; b=Lf32LGMP8l9GatHFPXTqqlT8Ph
 zdxYu9SHlbGUCO0TgUDPPDBijKZwcK5WLXQqvsyIbwEqywClFnq/o2yYWf0ebmN35uIICk2FUHuND
 vRXeaV2ZrnNapjSUCWdPPXhtKM69RrOYeyx0oguPWL07aPHb8fVXK792J3tEs68RAQ4U=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWG6s-000000004nU-2Lki for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:44:43 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so55000735e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795625076; x=1796229876; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bfP6E5bX0B2T84wyhrAI44+0gr05Mow67tAd5MlIF10=;
 b=aKmMJ+UOnmv2lYq0mUjQguNVzL+1ejhuIkFWNqNf618M3D0zeE0N//hlcx2wQWKc7Q
 CvVSb4dVIqTcmhpFEGaZjlsbZWFS7P5l0wE+xyaA6iuSfciqJZfmkcTKPezT0Gmu1pZK
 mY9gg2hsv1XjftQ50C7q3g71zcnk3+V2G+n8NQo/B3YCmrGtxxV3eyutBbRCA8pnAe/4
 rfWum8GqjM+mVyaVsPE49XdDuOxZZEPrkxl4uWZk6e27Mh3fDRiiTxd2WXDDbgbriE/Q
 wVuZ2OUv/BS5o8KSmrE3gpyN3eqpFvA5ea5Hm9l8kS/nJz31eh82rFK9xIOqCQgY0bcq
 H+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795625076; x=1796229876;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bfP6E5bX0B2T84wyhrAI44+0gr05Mow67tAd5MlIF10=;
 b=AqbxXGHC5QSG9O5XMz78YdvPYj5+mvQaD9yuTlm4FKaBwZ8/IwRcAN2WZkBaz9EyqI
 npxP/jE0PjlwbygZhjmV9HU/PGZEWr6nU9HuQr/IuWi2PlT6AT8j5F48W0XeTsg7oXKc
 7hIrZ1dPbkld2DjLjVel1fJVkUlgu1enUIzKzf7DIp0uqMtPz9BPoiiH+9GxaVZx1u2Y
 UDyeI7hjj0amyVbAhrYGcbxnrybe6ovJWykntdP40Kl+XctLi0mTS6yMh1nUoa9DSrrV
 i5zL8iN00yNyUKCk7dTfJWwjG0aMXB0PdMIFUiu25/lXoSFYw2CvZAONlSkTCY34huC8
 rTVQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHVFLTGbXRR2/ahygBBjQeDOZVG8ejWVGbqJ3gtQ5w/isCS9XAvxt0/f0Pobe6ph3xAP4tmUThkibX4TqAx@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8bhYmBvdcWYnuy8jUZK16U9t4lLv/9fhNuVgGZjG/TBg2JBlLe
 tk62yWLfHujfXthSlmYMqUtGHaq4NZqM7XsRWbsQhbVIspJvdF6nTY9GTqjbMxo4szoRvlFM0Wg
 fKvN6Xq/mYVEjDLyEqWwChu0O0B3s1Sj7Xa8N1L7iUimqFIM62G+b+NlqXQdjaNADevxbWUHCTZ
 Pm2qPb3w==
X-Gm-Gg: AZFdTZf2OxZEsZu7KC2/KJrEbIW+z3kMWbOJ0JmzeKkc+3TomLZQuuTiHl8GpOzrqFy
 QOyKNhDGi80hy03MFZ0BbNcNHsuv+UAYumeZf4rXS5Nb6QzsS4I6PmFk3ntJCJ6wjDfNKk2enOn
 mttnVRi0U3mYfAxl13DyzMSYKOevGuth0vcW/j84UkvEcM56ydXwkM8JkKbJ/aDZq8qraXDdDW7
 TSwc6caXbPZtwQFj+anE0qevOfq5+PcKnxfIJudo9FXEyjzRd5QAynjGca6/yH/ujTrvzTyWPLq
 /IWnzBMPwWRN8Q0DTS/An5XX7PaqD15+dJKhNIufj2FCjWkMovxh3Q+CnnGybDkzjXxr93ZDxNc
 VRFgBHJFqI7b+Pnak5Yj2Oga8PreJ69pwt3JcB9KlyXvDIx4b6Ug7z+ZZDsxTf2wIWGwD0B2dik
 pxQQRuRFrrFy4hRW1qI39Hcyk2qUL336zdbPRc2H7L55K20AnWGZu00e3E6f15FtlTpETltbsPY
 6JkzMO90R+pQKAoaUaNhVO/y1OYX9pf/h/y84BlnODvo+TTuYmiTiJ8QrrsKHlnaeelrE/3P+KV
 cGUwrtvh49vvXgd4WBV6h3P0pSRUFsAxpMlGaINlzz9XHHV60W2XrH4WaTSa261q92XqRnO7cQt
 UCV+eC9GFeHsRU+L0CigiluWWaerSEj5IxpzN1hAnch7SOaCm2vOuhS6mYcLyAHqB5fgcfjApri
 2GGfBG8jJwBHUl1AkAipFvm+lLRY4Vi2vTZ53/
X-Received: by 2002:a05:600c:8b11:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4bb8881d194mr387179165e9.27.1795625075815; 
 Wed, 25 Nov 2026 08:44:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm977813135e9.4.2026.11.25.08.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:44:35 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:44:34 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b
X-Gerrit-Change-Number: 2346
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2346?usp=email>
X-Gerrit-Commit: 347dc16f2c3b30ed94bf0c75562ea6276bf694fa
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 16:44:34 +0000
In-Reply-To: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
References: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjI0MTMzMDAwLkkxZTg0NTI1MGI2ZTYwNmZmYjQ5ZmE1ZmUxYmZkMDM0YmU3ZWFhZjJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3bdbb8570ce22d4327bb0139b5f86764c178938-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWG6s-000000004nU-2Lki
Subject: [Openvpn-devel] [L] Change in openvpn[master]: push: check INFO_PRE
 length before sending AUTH_PENDING
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3178186683449582576=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3178186683449582576==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n0EAGS2EyM4="; charset=UTF-8

--n0EAGS2EyM4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail )

Cha=
nge subject: push: check INFO_PRE length before sending AUTH_PENDING
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review-1

(1 comment)

File tests/unit_tests/openvpn/test_push=2Ec:

https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346/comment/2314eb82_989ceabc?usp=3De=
mail :
PS1, Line 58: #ifdef ENABLE_MANAGEMENT
Why can't this use mock_manag=
ement=2Ec?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2346?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e845=
250b6e606ffb49fa5fe1bfd034be7eaaf2b
Gerrit-Change-Number: 2346
Gerrit-Patch=
Set: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Wed, 25 Nov 2026 16:44:34 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: Yes

--n0EAGS2EyM4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/ope=
nvpn/test_push=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346/comment/2314eb82_989=
ceabc?usp=3Demail">Patch Set #1, Line 58:</a> <code style=3D"font-family:mo=
nospace,monospace">#ifdef ENABLE_MANAGEMENT</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Why can&#39;t this u=
se mock_management=2Ec?</p></li></ul></li></ul><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail">change 2346</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e8=
45250b6e606ffb49fa5fe1bfd034be7eaaf2b </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2346 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Wed, 25 Nov 2026 16:44:34 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--n0EAGS2EyM4=--


--===============3178186683449582576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3178186683449582576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3178186683449582576==--

