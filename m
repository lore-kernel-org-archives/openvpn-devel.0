Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584A606C3CD
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YgLmvt2v;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N6UK4C+F;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ho5yRuZx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DIkOo8gJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dxR/Rq2JXk4mXzhWQc7nBEvlLRjjoUem5Y2QYrJUONk=; b=YgLmvt2vrrK+vOrwqQV7B0AvDA
	jdFYbE4uc8G+xTlEbpKCgZUeguj/Q9bGITNoLDSwQB2PKdY7ob50DKdGHSZL9jss47UagoU037/G/
	zLRXh/yrH3Ni9g1WrUJc0eVMPvtkQXMNpq/uxn4aVyu5puhbDITMi92GJIQJR/aTekfQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvQR-000000001IM-1ulf;
	Mon, 02 Nov 2026 17:02:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNvQQ-000000001IG-3HCN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1yN2onzBOUK1IBFxaZ166Jdhu7AOTCIVQb1gCVl2s5A=; b=N6UK4C+Fm7sucjJBO9AnLb0m+X
 bLlUzW0l6nLE3ZWQDDJCefitQDFiOH4GmsMEdpNLY5QxtxJhafDJmBRg9eZGpCLCzP//2Y6AGyjo9
 NajXD5tC4JVggJMprgl1gi/+UIEzwS/OthvWgUe3dqv3Sj7UpZr7xD2tluC80TfefEKo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1yN2onzBOUK1IBFxaZ166Jdhu7AOTCIVQb1gCVl2s5A=; b=Ho5yRuZxzDcbfz86aG18zt1NSs
 INRgI5C9NhdDii0hXP/RfllwdCxmF2NdsctAgzZ+z8+G/CWRa8mV0PJO2roEpeaS8WlFfsoChgfSM
 yap2d9nG7a1dcTSTza55n2Z9kBD+gpfVGopOrSdR6cbyBkEr02pDZq3CdvM2JT7CWsh0=;
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNvQN-0000000060E-3vZb for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:02:26 +0000
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c43373ae89aso494589866b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 09:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793638937; x=1794243737; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1yN2onzBOUK1IBFxaZ166Jdhu7AOTCIVQb1gCVl2s5A=;
 b=DIkOo8gJHbOJExbcrT3FVseijbzSzv0PaBhnaixgtBrEVAG2MYfddXh0fK4pfnC8Gq
 8LW6Ia5c1+ZFTlBnLL5D7MO+cvAUfuu1VHX1X/3hc/3dcDzU7RmxMWTxa/6TJVKte7wn
 lpnHvgDaNP21MO1nkMxmeKOFh63u9DoFxwW8oFLBOnX/kh9OWhkv5sWqhBQe1zNAgJ+C
 IX0QySn7Hd0yPcKbm51IkfYsnGMSl3CkdFAKEboOiJkLX6MJm+PpG/XGj9gaD+Dhrl/K
 ariWG3GqII9wdIcwlJ7iaSzev6E6e6F/zTyjPkBRZcVXegaxw6D3esvPMzR3Ai3SSsw1
 QyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793638937; x=1794243737;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1yN2onzBOUK1IBFxaZ166Jdhu7AOTCIVQb1gCVl2s5A=;
 b=CWqlwuOKPWEkX3Oy8EvC/1nnsVE/WaeBnufRDoquw5qcs+qdxlnEZLgEjm3xKNEfV+
 PD3rFxwphj4wv/pPvS1om4Om2OWjnqDmxlDCEW0fzSuTqHBlkugKPItVXPFaKblWJFNo
 ROBAh6TVCcQ+W+orq5fzw4spqabW47WstfrSIiM08gGvLDGSfT1xxupckphw8yZalEZj
 CIfEHHda5UbyYUBYy/YksYn4ABAO1+jxWtLVVdkYSV+378JxAZM1tq9cdd/kGuV716lD
 lBmPRtvA76b6Kfl3apZg6vy2holTvC/5YtPUnIfW80RZMagN3pgvxdt88AeerCsFbDGu
 qjzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc/MIhRJ29sCyxyXkQGXcbDtE0SftIJK4bMU2z5vBHzythkAVRxh3dfEAY5Ci2/VQVBFWDRmjgjYN+tcEk@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJAq6zlMh1R9jPjOW1b2Ftc/8+LLJ9gAuvgBgN9HFJdaT+PXFAc
 OEUzNqca3RjQRZDD21pdZv5O3D3QcF0ouqOwES4KnS+rDELKfT+PjQQS4PLqsIRRQ14WI/aLy39
 x0emkl3GIj1I+1sbcnwaJHBHg1U5RQT0YSadVk0YxSaU/gse3VBzEZe0agi1l69ZOhjEF
X-Gm-Gg: AYBFou2+zBjBfveDfZMhKkS2kJRN/1eggLrRGwEkdHkxuId8Yupb1S4zsbCtx7J39mi
 3okBClHOsLkfORWxWjN+/vJC5OWjJgJf3bCqzpRmfrapiMHmAq00IILR9z1ragc0om/IFbSVBGO
 Eg+E8wXnkjyb9mzGKSmSBRhvpNnsKX5y/8e95467TxEw5hVXf/ESEYVu+rptld1Te3ESxYSkqfE
 7AdoHlRixU21nMsHWm7d6tq/jgsXlaEs8nW2v1sAkFc14CH3s7Q4R9uPdVJZGJkJ6KwtrOG/I3R
 YJmZXqMYHcDO+0M63ZL20FcjajvZbPr+ANCrX7CnyyZvWYcvjUJPLGNaBPfxSkxHAVjOFaqdWdw
 fJkTkMd0GZtQCDAFwWndtJ21lwxMretfnhCgIZ4OLmIP6/vxw7e7RiWOqHLFYRPfkyDuhtx4oSs
 dJDv0fhzybrPMEriaw08d0XXPmjO0jOkAmmlO983/7QKateC+/ZGctdqehV8/MJ0ITUfxE1TTV0
 B1hKxlNZZm8RQpbhqLh7U/mCZYW9ezogEavmLhBTn72yVjrV3slDwBi+NKevOhX1Q8K4eHrkq0C
 ZJNawle2i7pAlImibL11kJFMCmpOkIUJWcZoujhcti5TSeY5YiNyJO4H4/IS4aR3pbuZWucvWB8
 txTyjOKWQ4NtS0AGd/WCi1sag3yswr4foSFLJ1y1JwqGvYt/cuvCFKUQqzAGea5rRTryEKKW+ST
 MxyGItnfu/qN+j59DvjiQy5o4+XwZsdZgTyx8=
X-Received: by 2002:a17:907:a785:b0:c41:30be:4f84 with SMTP id
 a640c23a62f3a-c4ca7aee94cmr906371266b.9.1793638937066; 
 Mon, 02 Nov 2026 09:02:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a5a7sm22073337f8f.37.2026.11.02.09.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:02:16 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 17:02:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
X-Gerrit-Change-Number: 2090
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2090?usp=email>
X-Gerrit-Commit: 933eea433751afe05cc00d2c4951dc52a5c793d3
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 17:02:14 +0000
In-Reply-To: <gerrit.1793624563000.I97a14086258c08b47e37f07f103460a9d0bb9afd@gerrit.openvpn.net>
References: <gerrit.1793624563000.I97a14086258c08b47e37f07f103460a9d0bb9afd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI0NTYzMDAwLkk5N2ExNDA4NjI1OGMwOGI0N2UzN2YwN2YxMDM0NjBhOWQwYmI5YWZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d02c68026456eb325abbc20f7256442c7c399a15-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNvQN-0000000060E-3vZb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 inverted inet_ntop() check in GetItfDnsServersV6()
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
Content-Type: multipart/mixed; boundary="===============9207675802029081336=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9207675802029081336==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w+yFS3rt45w="; charset=UTF-8

--w+yFS3rt45w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090?usp=3Demail )

Cha=
nge subject: openvpnserv: fix inverted inet_ntop() check in GetItfDnsServer=
sV6()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2090?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I97a14086258c08b47e37f07f103460a9d0bb9afd
Gerrit-Change-Number: 2090
Ger=
rit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 17:02:14 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--w+yFS3rt45w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090?=
usp=3Demail">change 2090</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2090?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2090 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 17:02:14 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--w+yFS3rt45w=--


--===============9207675802029081336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9207675802029081336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9207675802029081336==--

