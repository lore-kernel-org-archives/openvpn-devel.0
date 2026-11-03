Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2709606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M9aYGAzw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ajdEmxq5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=guAmaU+M;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZBJsD8sM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Fe8VwtEK77omFgNwyuhWfq8YGquPLsno8lEpTjrXz2w=; b=M9aYGAzw6+TMnZIPaLiXBzqnKh
	KcnJcdQrnAYP/d2+rhYRD0QI1G9O8MwxhBt0OXhIUBZUbFY9xgdzH5yrhN3glvww5HzoJTisPhk9F
	ckNVeWmz2As30GfEJVw6dT7xl93R8DMZ3xF9qLInkE1MBqq15iowQ4F5Ckr7ulTa+eSs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODXa-000000003LF-23h9;
	Tue, 03 Nov 2026 12:23:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODXY-000000003Kq-3ASW
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EeF/2uBRFdQGGUIEYn38/A6GS6uBdJ+N7t7TqOCdqqg=; b=ajdEmxq5loUAIOK7uVU7tRDGRv
 qdHkP3VwuC7ZLr1VkJhAtL073jWUnn7FL3cSoO/jONU232uOFA8SqMgP8KscouhqTz1XD1X9lkFAd
 591xBY/tXKNtjSqveNVn5u8xIW5I4UHJoRhW8dczU+dw6UwdomrSVEr+dxKEzb3gz78Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EeF/2uBRFdQGGUIEYn38/A6GS6uBdJ+N7t7TqOCdqqg=; b=guAmaU+M6/5Hei8fRWg4oC92Ua
 lqLpGEi/m6qZ4qdssuxAfylVZA6tLPbob8qyNPi23iAwedMMLMGTpI4Jf0u7owh+ZLGcV9XgzwuFp
 Ajsn01VSzuXZvLGV7esNt15dGhfFs1OYQRKYiU+3978/88QJSqsD+kqc6MrFMaTzAMaM=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODXO-000000003JG-3362 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:22:51 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so26397305e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793708564; x=1794313364; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EeF/2uBRFdQGGUIEYn38/A6GS6uBdJ+N7t7TqOCdqqg=;
 b=ZBJsD8sMRlrlOmQRP/925L8fvnZ6eIZi6q9hvfDWzXugFSKLO4xtrwQfWx900M1iZF
 gpuBpVoxuVsUc4zMzNIHw/RH7x5hvNzkstoBZQxfAWZSxoMitQ3Cna+Vgs/Zr22XGO6K
 k+JkiJ/wvvJCAprmMVD5iqlbqDeBjCOn9RPwou2AtoJjl/WrmiMdh5sIqt6esfLF2GP0
 3AZxap4YueOfXFlWLXEUJ8JYq1mdph4bsicUr8AzJhDIsr+5WuNu4tLnR/t7JWPEHQtP
 uRgxYY8AW3g9ibGtHt+VxCwhpQOrbAB2IJFVOQ31K48fV8QuIE7VG273OQGVVo6AY4sG
 8S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793708564; x=1794313364;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EeF/2uBRFdQGGUIEYn38/A6GS6uBdJ+N7t7TqOCdqqg=;
 b=Hccyq1+qFyYGENdLr7x4h3oGqeIg2RMbpqxzstAtwmABMiS0FqlCKx+sj4URzClOxz
 d7iY/PM6eTIQ0ChbmUzV8Gx0DN5AlYncZ5CeJIOSyFNGkWfNypInPosqs5wuBUs+ycAq
 /g6or7URi6Sk11SIWAaggGaoNDeaEFU7iyMd6t6QQvfboL4795dZQEAS7hQ5Q6JU6LLn
 Dgqoa7BqXi8pI3+8zVwJ7JWFJMarCQ0VzoF3DKqeD6Ra9JpwRE7LUUPbaP0RY0EQIQhl
 Q0MVkWep+ZIDZXOlDzZ8pFwVFZJpyjmTlTAaHC9tuzJr9X59p+fnKDEXhW3rLwB1gW15
 Vl5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBymQaIcDGKanV4vQUXxKDUEYBsNy8WekWhyoZ18KZ47sLB6KTsywDMBM8DCMrDH4J/qj1rLua+uZ+E7sMf/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/6CPQqnvSMy7/LlnmPTa0EtmRRLNSg4RpIXEmBNEi6j/swSv0s
 v6i+Zxh8EC3S5DxnBtgri4zhmN+SVc1E7M4L6wt9ukzyQuWALm7uOE4exImhy3wH+CMJFn/3TdP
 LU7vPgkEWc8dCAnAsK59k7cNDuBObQAG/v5paUGEdNvhecKWxMsZr0fbfkWr8YZCN2+FN
X-Gm-Gg: AYBFou3Atj5cbBtiMh2ZWJ5N05GW2WbcVMnCaHAXIayf63+P/RFMS3iV3I7/W6RqjmA
 9iVv/5d4UCCRY6tKF6TQc4CVequjthXCMi3O8w4ZjBImJK6XRnG8Wut2Eq1YrgOGYmgVzAkc+DK
 f04HdIQ+rL0kJZMJVlOR0rel702DvycZrKIw6clhMl7yh6M8RxodQP8IDT0AkfF1JIkkLLRk8l3
 BoiY6s7DdMmirGYfXqu9KK/TZoOfowVNThD8Bug2PCkUpPfsq+6LTphfNzk4fbk6ssnlLbK4s5v
 dnxfrX2yxSHRq9tMoMJ50WAU10s5T/CnOz4MfZo2tbBe/zBrvDl0suf89S1Lc1xH6mmL9O/8BDs
 XLN7sAq8D3xfsoCB6kMDjTfvpGeNLV7BrA5aWYgASvBL5Z10oG0YfRI9DA5QHinbuvoEthzfHy8
 0mBkE/RoN70Zigt9mWbO2FExofc4LQAvXiviYyxJmA0aO1QxMerDBw1DJWhbk5sj8GCX90ik2r5
 djgF/v/+Fnb4kX9BB7wMdA0fTqjvKJ2d4OFA3V19YTwD/dry5hB9gKEyVxKd/VUTzXpEbJdX7G0
 1GM1dZKs+O8/cWxjtrK4vC+HwXtRgXQxi4I3C6CGffMpuVcwwai4I4rTG3RzUgSTnskhDSWM13P
 arszBKHYw7GpkK/m2Ldp14vlX++BSVy9YgQ4hVla0TWVZnSznX9QA+seLzi3ubfXBJm25TspqEr
 RWL+EtJMxIqWtbf88sk8Fz+KgxBi+ux0tpw/k=
X-Received: by 2002:a05:600c:5249:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4ac1228b5bfmr289975055e9.0.1793708564062; 
 Tue, 03 Nov 2026 04:22:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cebdbsm59285995e9.3.2026.11.03.04.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:22:43 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:22:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0
X-Gerrit-Change-Number: 2098
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2098?usp=email>
X-Gerrit-Commit: 4d5e235ada21144164aa2feebd0a54d5f8e5c798
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 12:22:42 +0000
In-Reply-To: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
References: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2NjE4MDAwLkllNmMxZmE2NjM5NzhlZWRjYTIzOTFmMTI1MDEyOWJjNDY3MzhmYWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f5d5f2be3fa05015a821220844351dd4c823eb0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xODXO-000000003JG-3362
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove unused local
 variables
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
Content-Type: multipart/mixed; boundary="===============8115045273175688552=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8115045273175688552==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UUJ6Z6aOzx4="; charset=UTF-8

--UUJ6Z6aOzx4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Demail )

Cha=
nge subject: Remove unused local variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Ie6c1fa663978eedca2391f1250129bc4=
6738faa0
Gerrit-Change-Number: 2098
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue=
, 03 Nov 2026 12:22:42 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--UUJ6Z6aOzx4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?=
usp=3Demail">change 2098</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2098?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2098 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 12:22:42 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--UUJ6Z6aOzx4=--


--===============8115045273175688552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8115045273175688552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8115045273175688552==--

