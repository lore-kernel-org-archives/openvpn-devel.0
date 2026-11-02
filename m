Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E0606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aY3eb2Ts;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=l2vN5uBT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y6M0O2Zr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eYuVobvn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XEjv70Z4XBwUHzvwse0wfVK3tBNnwL1bmsF3LzpVTSM=; b=aY3eb2TsdA5FC277DJmakVYGX/
	RxqnGo9ibWFQLNCJzAl7PxVuDfoflLvf7pqTJq7sgSN3vYuQIz0lK9NclhlsFoousWDfdBEoKbf4L
	QdHdrKMTzUMK3do1tljuIecHI96bI0QjFWkHRxhM1omtSZpB1q01ly+3uIrV0apcbIxo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNp1E-000000001nG-3yj2;
	Mon, 02 Nov 2026 10:12:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNp1C-000000001n7-2VPa
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:11:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0scpkKJ3bTbSrBdyXRfMWCbhrW3k6LBg0y/caKSmoaM=; b=l2vN5uBTKHcP/+WPUgvXqzQb3D
 llIpTpUWS3wLzKoOrHbIevbT1Yq7+Nt7rsxxIk4TNk4r276F7dEgiaU/CAjUx+OzK5RVuZpZVTouA
 EzTLayAujzInNcgP7SqtAW2L6LtK/nRmktNS7aYPHZ6nq5zTNpcFIU5Swx4df2cuUzz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0scpkKJ3bTbSrBdyXRfMWCbhrW3k6LBg0y/caKSmoaM=; b=Y6M0O2ZrnvyH76CTAUbrkF0d9x
 i2tAwS92Pp5Wafn5w6DqjRJeb8w4zanMCzdH15Ug8fzzZJKdlduKehPmPjDP5OHKn7KVuFJk9XrUk
 AgFHBhta3VgaTC6Rnp3zwJFMa7zeii0pL9wLF4fWzBFCHXFtIYb4i5VuvIkPY71zJZfc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNp19-000000002nQ-2l3h for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:11:58 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so20972235e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 02:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793614309; x=1794219109; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0scpkKJ3bTbSrBdyXRfMWCbhrW3k6LBg0y/caKSmoaM=;
 b=eYuVobvn3fqSpo8ih4hLMoIq6ogzagZdTU8YRnuW/g6VrJXVmiwEjSSgzvLT3Gq48/
 R4CpeO5r84dEXShwo/QhHos60B7IPBWiSZo2wdijSN8gIOyTTp5xBrXCj8rYGqAjVzkf
 cbvhpPP06F+VHxKZGF1puFPj6VgnNdj8IdT9vNm7RXtK900KOKydREGfF6i72eMnwMGK
 4mv1A3ZID+ggjjVxXMQpgYC1AtEQbdqqdnAFIxhhcBbz5iOsNsGAlHH48YsHHHlD4cNb
 xkPbb13Djc9Wrk/y2Pr/48VCZ4Q6UHfHT/vRxJDtGKw+GAbS/mlwbakrbIJRO+bN+shF
 Fu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793614309; x=1794219109;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0scpkKJ3bTbSrBdyXRfMWCbhrW3k6LBg0y/caKSmoaM=;
 b=DKN0dfxCP6mur4+kM5A67B7MdVU1a5Mdi930sbWRJN6NXB+JXVVPUL5/YBVfC4Dy0Q
 TEmmDhnDqNUf4m685cjJhTyCuS2wcggMt0bhj0GPQjwDSFU0OdjmnSahVwnFMsTqAbN2
 GeP2OYXXcJ58twccv7sdrJdfobkaBJnOoPwOdUss8B3yo0q8hJsIIrAkn1mUwITcEIgV
 sojw1dw3liIVSaSRE0oIfMYhtgs/mm3/U7Q6T66/xHBLUKWSXYxu7lmYvu4tVn5fmr/8
 2PLPEwgEM54xWeT0yGh36rogpbpFY/ivfappp5wmQfnzIP5/wP4rGUDBHO+/q9Dws8mi
 4mZw==
X-Forwarded-Encrypted: i=1;
 AKwUvByNwBMhTjyHhspUowoVvxg3zibB8duucXNAeDgJ2q/9TTsWZiIe4tPA0EmnvUechH6DchwYGdrVIHSxumGy@lists.sourceforge.net
X-Gm-Message-State: AFq9FYISAHnEi1CbAFk7u1wuwBDn8R25MKebv0X8JpAMp88mBBvFaTfM
 2jcaGk4MAB0G8okekh9wTqpkRd8OtPXGDeTK9MWBvX2xmyA5HVxsqgLCinC9qYEqsJMPCuyb5Xk
 HoDsJ6NChgMpas2tTpshH8u/WdPE9T/EvkDFW8Ty6XmSK2MfBoXedkJmiFS4IE56mvXyW
X-Gm-Gg: AYBFou2MGg6qIbJmigVZ0GU1LK4ECtqZr3F73FvF0LxNay1k1wR7uEXY9uzLhBmqJXB
 OkpSBRZ5/fGHfS7HBI+WZv60K7FmIV7vYmagxAPrab6lRAjjkBpfzx2FqCgv74iztgSM9Dc3ui1
 fOW7dfnQGtsMx3ZVhylvZZ1s8Bn8vD+K7bIt6/eblEiA7dJLc7fvXadClVZqlPYt5F8+p9HAYSW
 XtF+9zRXY89ZrQca5dRzfe1xkj8u+LnvICdFhEajqE8HuOUofaSIk1ob5KP3tuBpShQE1bY2E2R
 DdoO+xp5THaCwhW38Zz+h5MNrPJF3vf/cj8zxKbvsfos2tdq9Qu9KTbe2wz+qL/KjY9dVcuRcSy
 8BjJhE/pEhL8rfm07pX6AkynXTM0DZAFvP85OcQRhcSa6B9sDdnj8/Q/aawXRAku0FcC9vVf+De
 8WsJlM90WXdBxowCXZf/eZ/yulD+DL+S7SyNwuWfM53hJ5vPDR+jSLpgzoB7WbFO4bONN0sZdxs
 T5+fr2jbnxPvaZVdrhTooAkyIym7eznt1CSNkxsDCFfUP6sr/GteUeVEHsr1I2htPAllpJFEjM1
 wYjPZUz/tEhDlKPFt1sdN/L25YhSPz48nJzw8mGRO/rSVHpNuojfwD5MRAkl6ponQyWax/+h5v0
 PrvIcQUi8Ca/flCM4n/LWdueVzU47BoOkN6aYJBCBSdRhN6/QDAuA9/MTZqkt/qN2V+/IltZWTr
 2TFNyJORLGNuE1Nw==
X-Received: by 2002:a05:600c:3556:b0:4a7:6bc7:f778 with SMTP id
 5b1f17b1804b1-4ac1932a355mr203629175e9.30.1793614308952; 
 Mon, 02 Nov 2026 02:11:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm359617345e9.1.2026.11.02.02.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:11:48 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 10:11:46 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907557c0
X-Gerrit-Change-Number: 2079
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2079?usp=email>
X-Gerrit-Commit: 7f3b66366055c7e45c4256969f2497496df91a88
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 10:11:46 +0000
In-Reply-To: <gerrit.1793594388000.I8e02b4cf39cc431f1f2c058db95997c8907557c0@gerrit.openvpn.net>
References: <gerrit.1793594388000.I8e02b4cf39cc431f1f2c058db95997c8907557c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNTk0Mzg4MDAwLkk4ZTAyYjRjZjM5Y2M0MzFmMWYyYzA1OGRiOTU5OTdjODkwNzU1N2MwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <83a94205c7df9b0a9b1394e2edce1ca386a0a22f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNp19-000000002nQ-2l3h
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: Wipe the
 tls-crypt-v2 client key copies
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
Content-Type: multipart/mixed; boundary="===============0880133724300576668=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0880133724300576668==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H7gFecXK5ZY="; charset=UTF-8

--H7gFecXK5ZY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi=2E

Steffan =
Karger has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail )

Change subject: tls_crypt:=
 Wipe the tls-crypt-v2 client key copies
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

Patc=
hset:

PS1: 
Welcome hardening=2E In particular the tls_crypt_v2_client_key=
() one, the others are only used when generating keys, which only runs loca=
lly and hands back the memory to the kernel shortly after=2E



-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e02b4cf39cc431f1f2c058db959=
97c8907557c0
Gerrit-Change-Number: 2079
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
Gerrit-Comment-Date: Mon, 02 Nov 2026 10:11:46 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--H7gFecXK5ZY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi=2E </p>
<p>Steffan Karger ha=
s posted comments on this change by Hansaem Wi=2E</p><p>Patch set 1:<span s=
tyle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: =
4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Welcome hardening=2E In=
 particular the tls_crypt_v2_client_key() one, the others are only used whe=
n generating keys, which only runs locally and hands back the memory to the=
 kernel shortly after=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail">change 207=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8=
e02b4cf39cc431f1f2c058db95997c8907557c0 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2079 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 1=
0:11:46 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></=
html>
--H7gFecXK5ZY=--


--===============0880133724300576668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0880133724300576668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0880133724300576668==--

