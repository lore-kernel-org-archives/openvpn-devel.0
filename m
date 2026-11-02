Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FC2606B1E0
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CDt2n50N;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j3HS5ZPl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iPHJMgZl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XozDRF5M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bCw4cp/VWux05ClIlalVN5OUCe04pZ21XV72hbg9ezw=; b=CDt2n50NqO/YSSzaDqtDrNsx0R
	a8YEmNVUzTy9iyppHfNFohrUbkkIB5Ha9He/oAQGDOTNlEt20vypR2LVEwdsVE+UcN3QRZwUJJluo
	1HE6t+/QwbDum7IwVehQuDnucAMyGXq9simf4CuiAHFjA20d7RD8LDn3cBM/HvI3nJ4Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvCB-000000000ta-3H6x;
	Mon, 02 Nov 2026 16:47:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNvCA-000000000tO-2nAI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:47:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dnGpiXx1r/YjREr2vqgtgMCj6kEaIxyxmQXpmVz8M+E=; b=j3HS5ZPltFer/jwFgRYM1l38QH
 uagYxlyXm4kXfxtAI4kJo/aQ+5/VDKvsG9ZryO2wt/em2WZJtIR9N/mYqJ/ruceVokID4znrXA4m0
 RO7zQSqsT1Vb17Dg3u1BeT1TGiqhulqRqbUuuTl2K3+3y+Xg4ExVpFAS+OSWdQ6fhx2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dnGpiXx1r/YjREr2vqgtgMCj6kEaIxyxmQXpmVz8M+E=; b=iPHJMgZlEkZIpo6Vmo2XGXjjLp
 257hf+oKt1HjGm9IMbiNH0uNlJKt1wVrw+KhMLosYLgYMjr1+dYNYXLKzcNGDIhWiiQDTNNbsTlme
 pwXqLBS4t1oXtEapG2jrbZih2T5k8cI8XDQHKhWkywg3zN068tBhaONKBG2jB4JRUJCo=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNvC9-000000005nl-39Cc for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:47:42 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so1918664f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 08:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793638055; x=1794242855; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dnGpiXx1r/YjREr2vqgtgMCj6kEaIxyxmQXpmVz8M+E=;
 b=XozDRF5M7G6scBairsE8Wq6L7bi2ZBz6VYxNzzd14RYCYtM5oeV5WlUMoEVjbPmdyX
 6xk6WDS9DhxaNL+8p+E5ZPoGzaEsu3jXxCQ8CKLM+DxtHdj/bCBi34/qUpqWtrsqSRoW
 IA1l1Yh/psimS+QmsIZb1lhxVk3/CglcIHEFvoswPSQRNMF1B6h4EKGVqt31L8UWgIiz
 KOq5mQYQEvf7d8x7Ni609DBzDCVsdwYbxb8MvydyDB9odhCH0Yjq6lMLTEvoL/Qn5JTA
 pvtkLvpQdnDs8q9CSAl+seA4xclxqt9tz6RF/uh45lcl1IYJ06rMtAVUjIIQd5X50zq+
 kF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793638055; x=1794242855;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dnGpiXx1r/YjREr2vqgtgMCj6kEaIxyxmQXpmVz8M+E=;
 b=ix2TkaKngHNraovWSqKG9mVd3WjZvSI7wWxE9TobLjWxtpETOqrkHt+/2Pdg9/zTIl
 JG7+o4MnOX37KRQbAGTq+sQ9VfK/SeLzVV2JXQUbN2WGwpxL3UPdsGMLrRRkxJYfsB7F
 n93mZCHZx0ob05zb25k9hDtWFiaWiVcv02s3d+qgtRBzJswGm6fJNiwyZmv6H85E3fPc
 Son5ZIJ9MILPUKcqLNMYf4bhrlMxlUIiOqVdm1Gjk91U/qy+va649ifjwteVm+lF0/41
 jJH7sjMXw4dTMqdkX9MujXW7CSAxDB1Uz1A5UUe6Ov2kYUbILrTALcYrTLEmSM9YAIwp
 Bvug==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkQtSQpvU5yHHiGLGVrQlEsGXfPCC/jbqo6Crmyst5Jb8CMStiJyr6WextCtgfQFKBYlntFiJWgwJWwwb+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z81wH/pp9T8YvugT/nNKdx5BEkO6vyPmadl94REyeTvMAWSndyD
 fQaqPCyAJ79mAy7RsjjvNx/yFscLuJcj5N8dXaFgVCqkgAcfrfinp6X+Rfw1XEDK556V33P9Js0
 LHRVSvnX2tevaK7jqjv97uqERO0gUKfHHHEOR3+4ZjWaZT1enWCeqZK09lnLyADTUEn1Zx9pS3n
 f1K3JOgQ==
X-Gm-Gg: AYBFou3c6gKxgj/7t5gmJ7CIxCRaKqsB0hN4zct5hhHWMghSUGp3nUGE/f4YM8+f4TB
 gQWdrK8G8B+iSbgSOdtFHmyfbu9R2NvnfM41CaPBdeQRwK9+WfNg2jJDavtQgCZJH+wK6UnbwgJ
 +JOwHwzsX7MAxm3bOABR3C9oGvWxcFcu06spRu3fBwvq2xnI8I4S5y8U/J9iPigcJ16FtGwN8S0
 2jjVDasBUVlLWTy8ctVVAJppVCpuon/U3abaA/VlDDSzorkICxiwvGYtOzKnfmCx4qxSNcKycwP
 hwD9nNndKIR5yEtRPL6kIOw4RZWFTVIQh0y+hEbN3BeNqE2+xXrQCldWw4HD+DsisRWOoNnrv7Z
 zM1UMjiaquUeAOLjiTBL2skLv6TOyUt8Fcao2UILC3VpW6DZnegGBQoqPkKJwB+h7643QglZRK1
 kYLvfq5/k67l4pN3GuUVL5L+Tle0PMW141de0SfHfKEdzUjZz1E3TqmS3QopLbj9HWmfgOYjK9w
 9IbvTdycLRs1y8NWRhoAOMq+60BK98k05IlxCmhmTZOdlgwpFZhaMLFkPD6oGt4c8rW78bZNNe0
 GKIkDsfpFdUDQ/ua8GicqQLMnuhKFUKXyAckDYhjHD1m7v1vX7kbXkHlqjWlJbdmIziZk/ctMAd
 UJZ7up4w4YWiasdZV2R2O2W9+RNcll3mKUFhNAB+rrNh8VO/e0hmsOdz1lJthFJKlba8ipnOCiw
 /rmwx64lahH9pwZiGsXM67Ue58DxsJr9qfRl0=
X-Received: by 2002:a05:6000:4203:b0:48e:6145:498f with SMTP id
 ffacd0b85a97d-48e6e4faee1mr23320240f8f.55.1793638055048; 
 Mon, 02 Nov 2026 08:47:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba4ac6sm22266264f8f.52.2026.11.02.08.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:47:34 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 16:47:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9
X-Gerrit-Change-Number: 2093
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2093?usp=email>
X-Gerrit-Commit: cc31b4c3b5a9ec1deb40214270a0b181f58be0d8
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 16:47:32 +0000
In-Reply-To: <gerrit.1793636884000.Ia0304e5ef5f8a553262a32d78ed21577973ee2e9@gerrit.openvpn.net>
References: <gerrit.1793636884000.Ia0304e5ef5f8a553262a32d78ed21577973ee2e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjM2ODg0MDAwLklhMDMwNGU1ZWY1ZjhhNTUzMjYyYTMyZDc4ZWQyMTU3Nzk3M2VlMmU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1f29b61149e4df7172d2f54cf7edb33489a26945-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNvC9-000000005nl-39Cc
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: close socket
 in Haiku get_default_gateway()
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
Content-Type: multipart/mixed; boundary="===============8161992505787637875=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8161992505787637875==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TCRbBSYU+qE="; charset=UTF-8

--TCRbBSYU+qE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093?usp=3Demail )

Cha=
nge subject: route: close socket in Haiku get_default_gateway()
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia0304e5ef5f=
8a553262a32d78ed21577973ee2e9
Gerrit-Change-Number: 2093
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
t-Comment-Date: Mon, 02 Nov 2026 16:47:32 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--TCRbBSYU+qE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093?=
usp=3Demail">change 2093</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2093?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2093 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 16:47:32 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--TCRbBSYU+qE=--


--===============8161992505787637875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8161992505787637875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8161992505787637875==--

