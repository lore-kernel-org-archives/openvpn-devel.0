Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765F606A327
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lJcqyCmQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ho8kwFAm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j3BYHv60;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AqQv/nGL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=znVv69wTdIfGP+jLo0n6qkEcGefgC+o21lr2LLccB8Y=; b=lJcqyCmQOz4VLZugjw1MiZo4NJ
	Sr8YvD5pxSmkE4RSZ2rcYhcE3yhx6659kEkOBSAUsyeUFTT+y1hCM6Du1+dG9Ge2Navjuv6a3p9Vx
	aVFnYWY5BYcv/htDdNBbVQ9BQKZZSGXnlBcSQtc2X+kYwtx5pJcQ2dIDLgojGF6mjxkI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVTha-000000002f0-2DkH;
	Mon, 23 Nov 2026 13:03:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVThY-000000002eg-46t1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:03:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B/2vK/KV6eQmFiyspgRuStTm/ahuNN50UZ0E0vY3Qjs=; b=ho8kwFAmRq2+idrUtsXOKibgh6
 1IyGtnbqvKA77PZh80q9dTkmWZ06rjVFlvFWFBbrcTAJWGBqgBOGcI+WmFlZ3mNS+y7Yup1RVd0ix
 BoCkNhBWmWT0ePtpRTHVOYaWcLUdresY5mCA24yV7Qg7j40SeTp6a9LOL7RcBVMtJMt8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B/2vK/KV6eQmFiyspgRuStTm/ahuNN50UZ0E0vY3Qjs=; b=j3BYHv60kCSBp/BqZFsey0sXUu
 LfUw2NIHhxgjpJg/Kmx1gVQQglvAF57xsCFLReLHZeZfwznuoqvR+KV2yq6tGiggGwVx51d29DSNE
 +jFUbs5gUq9FUM+ligFT/AdeUYYkwRC54074dn+BTgTb+gVvltFtzVUR4iqDoECx9JhY=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVThG-000000001gZ-4434 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:03:04 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso24117805e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 05:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795438976; x=1796043776; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B/2vK/KV6eQmFiyspgRuStTm/ahuNN50UZ0E0vY3Qjs=;
 b=AqQv/nGLie2eNtrOJ16khfI9b/lQ4qktsVY2OChy6xoFaoc3fN+bqldV8iPsXruEe8
 IixvuJTS6K2TzcIv72ZC8RnuD6YVioX16qZk8jWtXrOt4DtggOLtIeLHTwfDp5BiIo0n
 vdQ9+S0UcPxdi8qh+1KPjl7YuRxZF74J66YKREOsLPuEQL7PoGr58nGZndF0GwAs3HSU
 XJ4AMtd+8nMH7pJD/kK0TjHcbmQIyot87KUIe0H5yWPqPOCwso8SmWZbA69cuxsjUy1d
 UYb+YI4s4Hpde73crHe8jGjG5gFtLS4DgobajwmLiVW+DgWkK8V0K4FD5JwuBmnybrXv
 0+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438976; x=1796043776;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B/2vK/KV6eQmFiyspgRuStTm/ahuNN50UZ0E0vY3Qjs=;
 b=1XpN/4nBY5PYCQ3JwpPRp3BSHEngQmGxifFBD4ZbDGQM6PUwA0qbftc7gYalz5wQ6y
 bY4nLmvUQXNTByDjCZ88GAuDHKQcpposcGzn1ZHl7ASLeG9saLCinSHzbWAauTUH/FZP
 9/NYxpTKFzcSbF7YRLoXyo5H8uKL8TMP/ji6ODNRqfhhMbWqG2gI+jheRtSmDKZPLpxx
 XJlxF8dV6qv8EXn2TpERqfkd4Yftct4Wr9Oyt0sknUTQbl84flu3ilJT3lmuhbkipYsG
 joV+SZ4Gh94B6TzhdH49Lqd8tSL0Qd16x1XZdpguO5WSO9q0TI9pbehhSCEnOjpBFeJh
 zs2A==
X-Forwarded-Encrypted: i=1;
 AL+hErEW5vusMXl0tEZq+R/kL8fuMoegmlyCL+K8Wx8AKXJRwKQ1djaEFenmjz9vEGK8mrhSstg1S1mOwcASu080@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8MjEhZi52nLyU/Qnz9bs2iFj3eyAu5PhKrRqcN3nOJEPPDHVxs
 YT2x4JklWdwT5N2Xzf9zmZs1dP9iUayRsU+5ayXYCYcAwWSLSbmxllHmsyqSktB6sjUwpzWVoBj
 WWEVcBVpU43JZZ0RUOkyxz5wHDhvGEj8dmIz9EnxYaloK2VmOfP6HuPAakfhf650QgRzhQEQcCW
 PCfe+q2w==
X-Gm-Gg: AZFdTZcWOjlDUvEnTjlFTnpPysdSeSrUIB44xQQSbQy0S2PhF83SJ7/t88pBff/kYAI
 2uoKgVKNr72hhqEVroHlRV8DzmBFyh6S6sxDzDKm+j32tfjogCeeH8ccAJrHzT0ys793RDezkYr
 4lhW28lJsV/KKaC7IEh64kIBEgcX7o9yssdE6VsuUsNqBMZGwUfgOI/uRiSC1nZ25T3AcYA0aBQ
 i7fkTS4WAB2itNwimnjd9DWVJwNl3XGdwgwEPjmOHK04K7SoIiFzGP0u71wBGkjnEwW6nICEyeR
 /0ig51BZtm8q0kCCUuHW5utjx8Qr+76lojQ84WuuKU7+6GVJ/CyjWoAEgBN+1c5IP8X0fF+iu29
 8XtWdPWqTFKGELIAZfHTnwBlQVTMnB50R9zoNaJacB7nzDgGj4MYe8o2jgnyKvozImIo3gPq6xH
 BKFLa9SPvwUZURF5GZ/FbGszNPCtfy65S6sb9wfbPvHddCgDMRVPxIlE6SPcj3y9sSe309Sehs1
 quCEXLqv8NSXgZbJ2sP7oYWv8aqH/sRnmCizhEHQaQccF+rrTLVtkFsab+DwDYR6vh+UnR47iHj
 XjQhiqG7ZiFOQBflMWOnyqUNcckUxfIE2uceJ/wqsi/PwfqGjvGcaTUqavcpYcIMaQhOaGdX+D0
 hx3C7+P949DrJfdg2VGs52lofcOSWDOJGUMGKanHSHeIG363QJqbXVuSL+o5n1ZPufQbJFe6RIJ
 dMv5swH4ucegg4/1GAdDOfvU4=
X-Received: by 2002:a05:600c:828e:b0:4a1:e6a9:4086 with SMTP id
 5b1f17b1804b1-4bb88785a99mr220310265e9.0.1795438975224; 
 Mon, 23 Nov 2026 05:02:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm544818895e9.14.2026.11.23.05.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:02:54 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 13:02:54 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
X-Gerrit-Change-Number: 2237
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2237?usp=email>
X-Gerrit-Commit: a7ad863b2d13ed0d364704d5ae9223502a6f765b
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 13:02:54 +0000
In-Reply-To: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
References: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjUwNTk0MDAwLkk0OGQzMTVhMzhhNjUzYWVkNGIzM2QzMjc3NDMzY2I4YTY1OTY5NDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9627e451be917f9e74d9ca22ef1d42d5de97fbaa-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVThG-000000001gZ-4434
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: free
 ext_cert_input in man_connection_close()
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
Content-Type: multipart/mixed; boundary="===============2586592687011977895=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2586592687011977895==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+Fa2KRyiWMg="; charset=UTF-8

--+Fa2KRyiWMg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail )

Cha=
nge subject: manage: free ext_cert_input in man_connection_close()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/22=
37?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I48d315a3=
8a653aed4b33d3277433cb8a6596942d
Gerrit-Change-Number: 2237
Gerrit-PatchSet=
: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Mon, 23 Nov 2026 13:02:54 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--+Fa2KRyiWMg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?=
usp=3Demail">change 2237</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2237?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2237 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 13:02:54 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--+Fa2KRyiWMg=--


--===============2586592687011977895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2586592687011977895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2586592687011977895==--

