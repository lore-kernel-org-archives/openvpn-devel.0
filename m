Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9560A382E
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ewGmTPPF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aNdUt6SE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M9/3Y8aQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KWwg9R2D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uSOoJH7KZd8Y13Tsp4jydl4vN//c+Tlf9+LJqKzmugQ=; b=ewGmTPPF6kU6zsRIHdPKpqAv2E
	gDY0ERsGQ++FHyeixXTHzgjhNWBet/HH5gBfoaUgLQmLxi4PFZct6ZAbq31LFpTi6D7WlS+qsgiX4
	oSlpoQcq5dacpt87/bEA+76EUWHREs9tDQKA5jNraDPwKWlwlBh8IsTEdqMUtrcMRMcs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTnA1-000000002Qo-3n3X;
	Wed, 18 Nov 2026 21:25:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTnA1-000000002Qd-0iBn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 21:25:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tci3plRWhLcRouefHFfPC6b2cBDQazkZFVrGf7Kzays=; b=aNdUt6SE8+T5ztyGiRtLgZZ538
 x7Fck2pK5re5/sY9SKHem+Qq45bOD4AgNfguHOiP0VoysY4bjuUlFLUtCRQqkZNZujLuI1MN1MJcg
 wZbS5ue/YsmISjDEV2U+O5X175Cel//q0WA4oAvqEUfuyP865V7svzOFIxs/8o9hbYLc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tci3plRWhLcRouefHFfPC6b2cBDQazkZFVrGf7Kzays=; b=M9/3Y8aQvKDk6Jkxygx50+18nh
 CnwCRaTt/RVcULs3D5bYHRF8N/iYsWRCEUNfgxxObZVM9dRAdADlp+GfIZGFlaTa20MSs/t2LQPHl
 g1POX+ocHt/74dqgD/nW1VxvpGp3tGROT+YlO6PO2SeQv7vVbfHNZnJXS9+nlkzHWjM4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTnA0-000000002Sy-1LXt for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 21:25:45 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso12072885e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 13:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795037138; x=1795641938; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tci3plRWhLcRouefHFfPC6b2cBDQazkZFVrGf7Kzays=;
 b=KWwg9R2DbM5+wsCR7ZHCXf/uxhwO7Vne4dGo0lE3L6DId9jg8/BFzt/M/5VWCidRBS
 E76siLgjPtSqTAVoT7dmqRwgdjUgHDpNjUGVfXRhu3JPL9g4TxuI981EQahkXzF9XCgy
 mrovujJQxrqV2Otd3b62rgP2tSTlYCkyY4vG/YIJjjszLi4ply8Dzr5S4p+aWPU3kqQe
 bitkziymEZHqyz3qfBRIPPEQIwNSpeed53PUrX8qGkAHgA88jwpdIoWzveyP/dbmUCnp
 ZXBIN1qb345D8YbF0LLiMHjVPOLwxymPxMh1F/YllTrroMHGL0ga1krcLTAK1q6QOm7k
 GTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795037138; x=1795641938;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Tci3plRWhLcRouefHFfPC6b2cBDQazkZFVrGf7Kzays=;
 b=B0pk+qPZu2qsuCHtfI/19vPWDvqarneZGk2VgumNt/5Ol2P3jMcbF9lPPsaWkIRedM
 coGaYONFdaXN6XuWCCO6UhK5gXp5nszLYjfX1JXHWW2c+ErkUBcINTstky+4UZOHxTQr
 WCyhLRQoqNXE5hYIEPmFZ2yTBdUvtOnPFH7Mx2hS/ucU03F55AgXlBxBGVmhOuCduQfs
 cQC+jqCUHBDl/PaQkeaCDbSDofcBe8ttBAWfJDS75JcepK17kfLcxXsFGM7yqvCG6yyA
 6bO2FALNhYAYbkHQG7mpltBKJ+Y70Wcn70hlTiz1yREYEwiE8fnbD+Rwysy0gt6KVNTN
 M2qg==
X-Forwarded-Encrypted: i=1;
 AL+hErHImcbdiw9UTkzbVfYHrKTT4mWIK82Mh1zMEZBpFcYgf5IAwZ0G8uhYYdEXiM+47vrW8cYQYYPnetCi+o0x@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9j4/FY6pnKZMWgsMieTAlQpiUgRXTlGYvaFsdAqHdZUDoK2uyP
 SSuVKzmuIrPjy5Wqu4L4muxSso5rlviARlwpQEeeqEqktZNo3cZm8W0Js/wc8Ualip4CPSzGyED
 bQLDmTMmKyuzXYlhJCwLqzFb02MGtXDhB8A9S8iNlt4E+151KiZbJ8hk7Z/atY2RpQdk24FIHKA
 epAYIhHA==
X-Gm-Gg: AYBFou2Xrg2xqH+8b5CKT3/oV0+a704ohDnpQ8mfJGfRZjAnGTfv9ADUIcgcPIw16Me
 UccOD+QIoTdijN4ZeF2QSLBcbSiOir+pBC6/d/h/ggnccGPbCavuysxtyvOHuFoKbTceO0HmK2C
 pzRl/TszZd16OWByt70uNRarUyTvdG6XhtP4t3pTiKE2GWUQKa+9cX3+pnyfZkXPDA5NShiKjsO
 uNfGYUKsBg6tqusvNTiBxSw9Np73rbimMZLJtEeAuPBgPS4trPsquZj34AtlW1qBsWXvNCL2f33
 QJTpYbr2sAtxjNYldpua4gs7I8ioc9pRpkEQkgu5pEs9LgJuB7UHme5rUekAEJrdIsQcszmAvZ/
 fTz5MWe6NNknmJqtij45QnEa+HlxulkEmCo6U7V66V32JFufZuoD7n4Vzu9MzR9p6FCLwOUuNY9
 0+ekiJsN/PF0FbWmwqcfhhGxHP530xk6FQX30T//fuOMvTXj6B4OVlKllnkLTpTs9FbGstDihI0
 uLX95zXy4dyLyEmxoIxCuZUaY/zoMnpSWAHfwoXmPxiA8qFzkrbJXo2wwfNbm3ues3FvOI4VzDB
 tyINSjo8+Uo8WLvE0PZTZWDMoxorRmwzS1WUD16CIiMmTjKR7MxutzyPXarSexuIYNGgcpC1g7G
 xVz8KRBeXbM1yc80iET5C8jbOJEVE3PXl+edEwCNmSANEuecxsE2DAWc0FqdjLt1j3u9WeTzzPy
 tvylhsnENyIJ43xRk=
X-Received: by 2002:a05:600c:3ba3:b0:4bb:6991:2330 with SMTP id
 5b1f17b1804b1-4bb7da349efmr90224385e9.22.1795037137586; 
 Wed, 18 Nov 2026 13:25:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8327e689sm17233535e9.4.2026.11.18.13.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:25:37 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 21:25:36 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 2a6784b2e2ae52b53379945fc5a88fb33a30142d
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 21:25:36 +0000
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <685f5968c51c32ec6ceb7da1ccaa304b200a40d2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.9 (/)
X-Headers-End: 1xTnA0-000000002Sy-1LXt
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Name of user not set \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5788027106087905846=="
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	TRACKER_ID autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5788027106087905846==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oREM1iXY+/0="; charset=UTF-8

--oREM1iXY+/0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Name of user not set #1000056 has posted comments on this change by Arne Sc=
hwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail )

C=
hange subject: Extract tls_pre_decrypt_extract_session_id and pre_decrypt_f=
ind_session
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 5:

(1 comment)

Patchset:

PS5: 
2a6784b2e2ae52b53379945fc5a88fb=
33a30142d



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2175?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I230b3b=
2483e15477b179b277dc8f7c91c53fa0c0
Gerrit-Change-Number: 2175
Gerrit-PatchS=
et: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Name of user not set #1000056
Gerrit-Reviewer: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Comment-Date: Wed, 18 Nov 2026 21:25:36 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: No

--oREM1iXY+/0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Name of user not =
set #1000056 has posted comments on this change by Arne Schwabe=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2175?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">2a6784b2e2=
ae52b53379945fc5a88fb33a30142d</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">change=
 2175</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2175 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Name of user not set #1000056 </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Wed, 18 Nov 2026 21:25:36 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: No </div>

</body></html>
--oREM1iXY+/0=--


--===============5788027106087905846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5788027106087905846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5788027106087905846==--

