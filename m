Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34700606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A08cpgbs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DJ9pcoGQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y3KXDkBl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M+rTImvk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wgEiwuLICfKAC3dJZuPorHgNjT6q23MbqM25oBSy5MU=; b=A08cpgbsokEcIbgx0RcyszgV+j
	Mz/q1b2+JJqVB1VTtDbMjVlk6L58oM4YpFADmOBsOLdyCr4Sv4uX1NhcWv2/4+rWoZ9d3xHAUIt5e
	gYYxDHSgrthQ55wYx3Mfh82MMzmTYcjikmVCsS/Hm9V9jckl6zMBp5NQf+oXo9NFCEto=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxJQ-000000002zt-1vUw;
	Fri, 27 Nov 2026 14:52:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxJH-000000002zi-2bp8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XfoMg6dqQAujE+4laZvldvSU9ZUljh0VHQ9wf/mrm3Q=; b=DJ9pcoGQ9IcE5vI/ITwVru61xt
 WxiA8tZfLipPqxhbg0MyQWPQo7SqKmCEyT4sikP7DOgV0f7gNQYnh9vRCzQBXhA70LW5OnHJEhRJk
 TqBI88xniCeQzJfyiAjolpBt1VYW4iMke3jo9tGVAHK8UVxB2uP3AmNL0s6GUoQ80kcg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XfoMg6dqQAujE+4laZvldvSU9ZUljh0VHQ9wf/mrm3Q=; b=Y3KXDkBliMmg0vWC3aZ9xhZSzc
 Sb735U2xhRFMr1oNOAFFonDgtKtu2b8fSRdyYTbe5QD1QoljF7hTPSGAXGH80OdEKMGX2/7wFY2vO
 CGPlvXFfhvcnJC/bSBKNAIkHG42vKNcfyVGIKSX9S1g1P72XFHm+3OZGSavQeswFlPHg=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxJE-000000003Vt-2iKt for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:52:21 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4acb44dcd7bso7370230f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 06:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795791134; x=1796395934; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XfoMg6dqQAujE+4laZvldvSU9ZUljh0VHQ9wf/mrm3Q=;
 b=M+rTImvkwjoA/E7naNgSENbfOVHXgkWuO1eesXZ6GP2R0UtECfm/O/PycNue0nExKF
 NJAboAbd+c3J5X4YhRYzXhlPl+mhNn1+phn+sBu2zm+KWi7K5p3409g4ULE6OZ5vFWOZ
 k/oF5K0EXNRjPezgdj4LgAXr7klm+larosheGJ64XOQXsT6G2Abz+baxrAiDmmJnz6w1
 wF9OFBg0iZjJhDUGwq6aJUS2zrHDH6wPtdZ9mUvppmpmCNQAhBiQJpf9AH91k6QpDHXF
 9QdpzyAGkztdfXoEJRTTvU40wpXKHQO+BT5Zalhh1qU4akJWe3jE/YlVKmFoIe/JxLBR
 MK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791134; x=1796395934;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XfoMg6dqQAujE+4laZvldvSU9ZUljh0VHQ9wf/mrm3Q=;
 b=09/Lwa4/cV5xkcJourmhq6bPzrJZJmKngcd1AuqEv65s6+h6S7bJdc/2QZFc4qPXMa
 yAoiZc7D7FG/IFomZjEfw9O6kEZLqGJneuILydJRI8+UIrtKaG+wMU0hXvyKfbRSlRHO
 L7dk2YLVWRw3Ko8yeMMZ7h5hRcHD57d3tAX/Z8lziGPs4cfwIo3/dqbMthfHbhU4hrFM
 cHg7JIQQupOhGpSRjdOlhBWjnOBfMbh09hyJoZDZL98K5G+AukAl3LqZd7aFxBNMC1jo
 H0kROP2S5khWgQqHKTnURoK7uIALU08YygKpcrOMtzs8ku27HqU5axeKFWO/jVfljIiv
 rRcg==
X-Forwarded-Encrypted: i=1;
 AL+hErFMzWVX8Ic8FxPeMpGqL/hIo4mWrI92mL6I72uRPvPGhoAIKy7Ec6BZ7B3HJSuqNfq7ysciZb5UQycSNyi1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8cQ6MsVTb0FQMdrPwmfZ7obcEbPg1xp1OROGcphnA0NpxjL2Lo
 fwfzOyOueHpIQ4188BtDSzueP+dJaMU19I1JsU42XGGT/zrIElT6jJOZCcReRIyM8+WOjGVjB2U
 F1JdkDODlDtBep9Q9NtG+2foLiHZsGfojmk49jcvqSw8PmRHp1qgabs44ypfUgU3kLD2r
X-Gm-Gg: AZFdTZd9yEJx/pVxviCZF9yr57a5IXg/kEwK7OPk49YMjm+d4SJxTDZF3ZBxtkGS5NH
 2Uu57x1TNqwz1wIi+24KhDqT/pPB1N45xnyxkBfZyLeJdgBU9sXQj/Ee8odTgTZ8DuRGjdHxDMg
 /YoZGvpHMLzBC82cx1jeg+lRvFRBOpPy+wm3S5nmQxy/BgKTmM+pGDFkkplLv/sfZkhngIArb2b
 fGLbLc1PYuuJviULDaI3kZfnB9jfYol2f0pyAHHhi2QSr+yKJIgR2dMlHye/f4IMIgGAgMkYquI
 FyEp87Cukm6WUz1CHKZWrzTPIumZWW/79dM5yk1PtgFqyFD9I434eOK1T1kr8zPEi31P5CQ42xr
 0c/vZnXPv1J/0W6yL3QBu/BIZLBFSPFK0DWXtLVeylucaWJy1M6/hzntAJi1uysm7c5SQAd9pTf
 2wnz8RWG4I0Iu0NdwMsOkEms/xZ8B4hkjhKG4+BkVW9DMT2Zz3F3F4b9TtTMaehc7z7erA3e2S0
 OSp7bYpWqNNjyRtR1RUPmnXMlEQiEQWE7LFprSAlcRQDTjiMpCjo1omarEUa5110PWCE63a7fUi
 185NgibEIuDaAedb7mqu5QH+hkcgXyJcrEWtFfl+TaU5tzFCgiQgJLEfhHJh8eql4Sb+BNj4jVR
 vvkzO71hFOCXjH1mb65SwfXnCzit6QVS4WqzpN1H7DSDXIG6K3iVwiIdrweas7GPovUt9UxK+LF
 1gUgVE4xN8Z7Rxk2RhiAyKw3Akh9kVAXjAEn+G
X-Received: by 2002:a05:6000:2c13:b0:4a7:9630:7b57 with SMTP id
 ffacd0b85a97d-4abb43dece6mr48830140f8f.44.1795791133845; 
 Fri, 27 Nov 2026 06:52:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b9add26sm48097745f8f.44.2026.11.27.06.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:52:13 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 14:52:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016
X-Gerrit-Change-Number: 2362
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2362?usp=email>
X-Gerrit-Commit: 86f7541de5be622aeb4c6398b120df634109e7a5
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 14:52:12 +0000
In-Reply-To: <gerrit.1795790938000.Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016@gerrit.openvpn.net>
References: <gerrit.1795790938000.Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkwOTM4MDAwLklhNjczMWY0ZThlYmU4YjVhYzc4ZWMxNzA0NWI1MTViNmNjOWVhMDE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ed02222c370abcced8cae90b358e15e0089531b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxJE-000000003Vt-2iKt
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpn: unload
 providers before freeing the options
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
Content-Type: multipart/mixed; boundary="===============2806669065844311455=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2806669065844311455==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+OiXwq3tvHI="; charset=UTF-8

--+OiXwq3tvHI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2362?usp=3Demail )

Cha=
nge subject: openvpn: unload providers before freeing the options
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2362?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia6731f4e8eb=
e8b5ac78ec17045b515b6cc9ea016
Gerrit-Change-Number: 2362
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Fri, 27 Nov 2026 14:52:12 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--+OiXwq3tvHI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2362?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2362?=
usp=3Demail">change 2362</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2362?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ia6731f4e8ebe8b5ac78ec17045b515b6cc9ea016 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2362 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
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
"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 14:52:12 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--+OiXwq3tvHI=--


--===============2806669065844311455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2806669065844311455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2806669065844311455==--

