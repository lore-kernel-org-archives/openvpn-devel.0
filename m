Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F964606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dSSF6Oaz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fjarZ1kP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WIgd1yNB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H641mpxv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EqUyR6BFsMh+gAbNcPJhVY64jviRfFqZHQgbxBnFc1A=; b=dSSF6Oaz3IPETtLhk17P/Xlr8h
	PVt/4QJ0esTbWDW63oVIDFiwO3YkVMK5Tfbx3PjUISywB27Rp0ufFEnxyubgTv/kUPB76Gto/u2C3
	itu0FZAcErC9mDgkbPSLaqI90pX6fAEJogBCLbgjUQe4WjCVqNJIXFeIaUFoZeGev0r4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOa66-000000008E4-1Boa;
	Wed, 04 Nov 2026 12:28:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOa65-000000008Dx-24Oi
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:28:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ScfmsFmurhCCeTO7T5fOYbXyNIxI3IhZAARFtLHtvxU=; b=fjarZ1kPmoFuu4dGz/KqSbctJm
 HDoOw/S081NsAps2U/YRtg+YFdpgE38NjX0fWf/CBqYT5Vixwwyn6HeZLT2WKk9UeP4u+xYMgi4Dt
 gskmUawKVp3wlvw9Qx3w2wGwp7kK7oJsi7SbrKMlyXUYaPt898O92aMpvm0An6t9VU/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ScfmsFmurhCCeTO7T5fOYbXyNIxI3IhZAARFtLHtvxU=; b=WIgd1yNBlmDsK40EPfFSZtbJ6t
 wgzi+sBa/hGyn5+PWOwq6iR5l5lxUfhtVmQ1+fcdiR+PSk5u4+UoZ01MVlQ+aQtqJTQK0PtmN5xiD
 QjeZTDCtdfIGHygoLjHbiZD9ZD4WCiWYLeUVTRrQNPHWlZqgbGd174tzAVA0ewyKRv0A=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOa62-000000008LZ-1blj for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:28:07 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so3927675e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793795280; x=1794400080; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ScfmsFmurhCCeTO7T5fOYbXyNIxI3IhZAARFtLHtvxU=;
 b=H641mpxvp0gkGTMJSqsh4vDjb2TNgzyVBt2kt/w9/+HEJQqFnnBitkzZLPNmtz362R
 m7Z8Emh5O9RL4yeWSq0usPBtEDt7lWCxcaAlptEv31HsgOupOKE1Gp7KsR9BXHRU1iF9
 TiU9PgVf+lxatAlr5InAPJAj2M72C3NQpg9yTPXCqmB5NDIRoZbv44pfrOCI03+HSsLm
 mHAjU22MPxS6rZdkEVkjJ+B0BcPKLnOGtDd5TmDjGaPBib/wiRhlzAjhyxLDlPo12JNu
 oB8TkvWiVcBlz6+dKtWZMoTy1BrbKE8JL7xzaXjM04i+66aHf/GC1fg2BHp9t30LDaWv
 /CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795280; x=1794400080;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ScfmsFmurhCCeTO7T5fOYbXyNIxI3IhZAARFtLHtvxU=;
 b=JD7JnISiGHiBfUqls2arypEDmR76t7idznhUUVqI1zSvqE9Xe4noFqaj/jxYFXtdgs
 qHZq6RF/WZyuoQR2roUXBlFqA8BMvN7XOE/ansofP2x3oEeyj9Wh47t5jQclXCbDl+1p
 lFdvcjbxA1B4K21KeSQT8eCcHa11Kmdi7ExTyLsTITaZvhvDcBnkBCjESyfUHgDSjEkc
 vKKdYC88jMKh10phX5hAOKeOQcaqXVIjnbmTX60GpgmJHdK5/oqvR14Kevk9s1GND5lB
 BOT6HNaTI3629S7qZ1ZZ0tubY3I7IwLq+LAp+YKD45M+CGcMnpzK3IxpfUGtyuAseyjV
 8YIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfwvUTX2crRwnR1xSROv3Gwgn5cISMF/9JVoAUsz99oes4cbTAVEr0QiyBBGI2PSCPMjh6IirY/WPDSNnv@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/J/1VHwFQyItgu/qESH+/K3I1g6ackdhfgW1tlgGqkEUe2VTU0
 6lPDUTM1lzclD0EV/NZeVhfb/i4wX59HC3lfi7EC2HS7K3xQHTSJWZf3E93CnwZPb5brQPfkJqx
 AjlRhkDEvuWKS3ngyYb4pvOJnvbjibAOCdhrG7Hu7AWfU40D0A3EJvopdi50x7xtfAPgq
X-Gm-Gg: AYBFou2H6EcVKSYne/VepJiFb658jfA6aRQ0rI7nT9r+CJqx9eaJNH+aT+m27+OZuSw
 THK/TCfyKZEh6PZAnxviayw1rebSCB9r/CLluWKVAz37wgYUMYSHKBdXMPZCoRo3GpC1NBWin8v
 fbIFIKu4QmGyRrrDL7kAEJYITHUBo76ek+j0cLNwpFigh3kRSIPFN0llBSU+3OgbQtx5kz75tj/
 TfMHNl6f7ubNZ5ZRFdmlROoFN4j3tyBsBbhvsvW5RE/q+pAfh2pFOIsTmpJtlVk4AjFwCmF9gH+
 L99bMj2nSDoP2ZBK0mMvGwzvYJIeSVGla8/n9Hve38NN3G9Xrrr/efz/ui+ElWRTQxHa8zsYgt4
 67W+7s3kVIPMPCUjVTDLDpBuVy3MhkrhP8RzMFdBKkfQgM9jUN97mDWsPU49BhP4hl44jz4ZYZl
 OU1FwWwD/t+yr4FXKNnV2T5VO/jDznMjEhJH235pyLwyofJi0WxmU7dPKs0ys2LnrK6R0UYySz+
 gSQQ0TlPrRVCi2UBnKpJ0JWvUs/2kD705WhgdYQd6Joigf67uk6kImJT3r9pH9EypNaa5cUlRj6
 eDig/ufA/tFUH5lMyb5mNMqfWt09nqy4NlMYjgzxHJ42UUvpiRwlXa3VTG5vq0+Ppt4lfNfLP1T
 8bUo+H69HpyhA/aYXctoPOD0NQh/Cyj5TOXinpS/H5lABMWxnitwWLb8IM3+iJ4vtW2oXB214wI
 bHoiCyVqU4TttHkA==
X-Received: by 2002:a05:600c:1c06:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4ac121940c8mr470429025e9.0.1793795279567; 
 Wed, 04 Nov 2026 04:27:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b452cd020csm47434275e9.4.2026.11.04.04.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:27:59 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:27:58 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2
X-Gerrit-Change-Number: 2125
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2125?usp=email>
X-Gerrit-Commit: a003e1bde535265e928f2a91d79fa6205f1fc53f
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:27:58 +0000
In-Reply-To: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
References: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5OTAwMDAwLkk0MDA1OWViOWFmODQ1YTUwNzBlYmI4Y2FmZjc0MWIwNzk0NjMyZGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c2b99dea346000e2ef7c6350840de0f4853febc4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOa62-000000008LZ-1blj
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: drop unused
 input parameter of management_query_multiline()
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
Content-Type: multipart/mixed; boundary="===============2033979207494081115=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2033979207494081115==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MPdDPnxNYrI="; charset=UTF-8

--MPdDPnxNYrI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=3Demail )

Cha=
nge subject: manage: drop unused input parameter of management_query_multil=
ine()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2125?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I40059eb9af845a5070ebb8caff741b0794632de2
Gerrit-Change-Number: 2125
Ger=
rit-PatchSet: 1
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
Gerrit-Comment-Date: Wed, 04 Nov 2026 12:27:58 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--MPdDPnxNYrI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?=
usp=3Demail">change 2125</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2125?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2125 </div>
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
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 12:27:58 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--MPdDPnxNYrI=--


--===============2033979207494081115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2033979207494081115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2033979207494081115==--

