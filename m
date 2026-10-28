Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B221606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WprEZrfq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FWEQo3z6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MVeMEPZ8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=G57NXZd3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uNZiWb/64ZrsB/DKtLV3COZj9/bKm7/guYNYjxRdm3k=; b=WprEZrfqeO/97d8e7NG/D9fjWu
	wmaHO88oJ5bXPlNdVce9rvzJr6iKzrN7d2goB16M+Niq6qdhOiYSZXN47+ooXn9mWEv8HAaWgYYji
	96e3BTOo5uGdjYgXo7OZQ0xhJo4MN9B1YT5hbUdo0dKjobwkjTg/wmjxX47rDn7EBSDo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM3su-0000000050n-2z7C;
	Wed, 28 Oct 2026 13:40:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM3sa-000000004zk-2ZYs
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:39:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kDlyHCtldaQ/EAcQa7pAnTJ7PU3pvvPm2D0qtyPG3QQ=; b=FWEQo3z6UA1VXz6d4xMxSCGgXm
 J0oFUl2jPyTrY9dOq+faW1C84N9swNxTEM1aI/3ziKgVEZhNKZ7jHtTTTA+A1LSR5nrX/AGlfU1ov
 wQ3CUooODkh/srgp1lor531BFceXfawpacdsD6Dv04k4qUEuhOrNzaIZAr1PqLickM/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kDlyHCtldaQ/EAcQa7pAnTJ7PU3pvvPm2D0qtyPG3QQ=; b=MVeMEPZ8+q7YP8fTsNI+Af18zf
 2VBL9ABrTH65t5gK/nS3/RJcJgVR02sbJghO0s+XTfldRERYomKDefZt5Srf4iwQxFnMW8TPoU/Gf
 cVIFrUNi0mWq3fixVNaXagHX0vRW/Im0LumMx3GdCC1decXNWS1pHuanYs+Fv+isvSso=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM3sZ-000000008DE-3WSd for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:39:48 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48dfb76b304so160613f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793194781; x=1793799581; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kDlyHCtldaQ/EAcQa7pAnTJ7PU3pvvPm2D0qtyPG3QQ=;
 b=G57NXZd3rZ8d54/jQ9D+8sY+UmFOjpnQQZ7Ar0Mu/oqJnO5KGWOHetviSt0OHxVQQM
 laOoYDt8/AvANtLgp9SDQF3swjPgm36xJQwy0li0NC4cidGuYX007J6rErYiXE2FT2vF
 ikP01VweJjhWx3wlDOgSBhTEZL5825ZvMzL9ZB0co1FjVC8oVhrzbQ5HcvN6XFEIowAZ
 w8NvAw/baQhbc+or4UGrq8ikD+f3LBaClkzV3I+kOMoYElSlJJhwiJgca61nt0V9kzMC
 Wj8w1KGd/C184ovUNo++SJqdxWRERxq+dif7/K4riYqvto7YE339HOe6M03jnjySIUi+
 AqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194781; x=1793799581;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kDlyHCtldaQ/EAcQa7pAnTJ7PU3pvvPm2D0qtyPG3QQ=;
 b=V1SUhyftwzeC/OteGCU/HYFFrfvs+djfVmpvlk8TI9vyXrniKO/0iy46ZElPTlvfcX
 Zn6vQHa6GD6ETYYo80WI4Xd0EztZ5o+SEt98WJ4BVuxv9tZopK5beYgOArvZOCMPPW9x
 hPN6ZrH94bHSF8+20w3PRzm2Rw2xg3n3x6i+hnb4xNd9Totg2kDwXpslqmhZ+n9d/YMz
 Hd9APCGkz4DUwyFovpYaBu0HcmGzfcWV4G9SiCwX/34M8LRBsoUiSaHGv3fyY3QnJ+tY
 vTeerabQNgUVr+8tkdeaJrjw/IBkImOziQtnAQpsMy9AxHMzPLC/3jwGVOPkvsT+TfRo
 dWPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByO6oi0kRhU50S2HOg59Mnmp781yofCKHh6F3bACwHVIr9GCp6d7KnuGkF+2DWgVCArtGlAipv740G5iA8Z@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLKWyQZPikFnUuSd3yIab5R/gCUtp6OMrUC8rXTaP4qtE7D6gPU
 C+kdu6vMRdUtmunWc83Qjxt/1+JJ/xd0hEUKeYPC7CAFTQRWNGV726Wl1pdfjr+MAMelrJYz4B6
 HjkCm3SRo4nK00dBcl9BwaZfoR5CLFZYa4Q1b1gxWNevihmCruqrqUSGgJwOz3bQj/D6/
X-Gm-Gg: AYBFou0xAJKfQl6p0j12FlnFUIO5oDPCZ1eqtXLkigcIkyFXFjMYzUPPEn2IRvQnXB8
 qClhcn4Ar15oiS0yz++yrdpFtRvb6td44h1gugZQ/7D0Ll/VLZ1dWzlC3HIsFw4K81cdq1f2Vmi
 UOKtjozcS3GR5uWrNudofoa6qqUe+awap/bq+74fma1+y7jYuUIyJnajo/YjFcShLibLb93nrsz
 W5YM5XSqz2r1S+95lKp/I0E22NGq1mrL2MdY/+Ntx8LVpkdxi8G6LBIXqSqXY+eQn1aKoPac8DI
 PHHfCLSakquCImFUjdG16pegmIqXv9ngeyKowSUeWMUo6sOk20U9arGt0o245aTdB0gYZ6CgM3l
 3GpniMqa9CEhI5SbA1Ntz1wQguo6b9yjbDVjoWtgTCQnctMElW+3Hl9loPhZcbgd3bXwkK8+wcr
 sWFCikY9wZDfs3qqe5+jPgrAVAg6p8/dygTJGT18eVUSIuRMqqvuLJP10ZKPyuAvTfAVEsFR1bX
 /JuLpatA38+TLj7hS3BIRSp+rnf6O+m1qJM/42dBk5ymmE2Z2SjbwLWVynR4IV8M5HujyIdkodH
 ShU5kpBB1ZIwdFvD5OFPk1NBLmRv+B8TEoc3CdLxxXdyZwuMSq3uNSqMSGdYau5A4sQnTCpcn8n
 sBtQ64JdBA4WJ4Z2Gfkj9ADkh6mt1o2xShte6EHN1DcVbAAwvZXfD7JTaFSv+MgNn3xKCCSobsN
 IQk8TeBB6l/DLVAJI=
X-Received: by 2002:a05:6000:29d7:b0:48e:e2a:4093 with SMTP id
 ffacd0b85a97d-48e5d5c277cmr4001571f8f.19.1793194781082; 
 Wed, 28 Oct 2026 06:39:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm28185282f8f.42.2026.10.28.06.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:39:40 -0700 (PDT)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 13:39:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297
X-Gerrit-Change-Number: 1450
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1450?usp=email>
X-Gerrit-Commit: 26a4059c325c565d529cbb6772bfa480c81ea9da
In-Reply-To: <gerrit.1766071205000.I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297@gerrit.openvpn.net>
References: <gerrit.1766071205000.I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY2MDcxMjA1MDAwLkk4OGYzN2U0NzAyNmE3ZDdlYTBmN2M2YmRlMWQ3OWQzMmMxNGU1Mjk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0aadadea7eab076fee7f535464fdba18e8141a2e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM3sZ-000000008DE-3WSd
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: add DCO
 and iroutes support on server
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6099603748977563648=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6099603748977563648==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Fs9C0txwVhg="; charset=UTF-8

--Fs9C0txwVhg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Marco Baffo has abandoned this change=2E ( https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1450?usp=3Demail )

Change subject: PUSH_UPDATE: add DCO and iro=
utes support on server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Abandoned

Split the patch in smaller patches [2059-2063]
-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1450?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: abandon
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88f37e47026a7d7ea0f7c6bd=
e1d79d32c14e5297
Gerrit-Change-Number: 1450
Gerrit-PatchSet: 13
Gerrit-Owne=
r: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--Fs9C0txwVhg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Marco Baffo <stro=
ng>abandoned</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1450?usp=3Demail">View Change</a></p><div style=3D"wh=
ite-space:pre-wrap">Abandoned

Split the patch in smaller patches [2059-206=
3]</div><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1450?usp=3Demail">change 1450</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1450?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 abandon </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297 </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 1450 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Fs9C0txwVhg=--


--===============6099603748977563648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6099603748977563648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6099603748977563648==--

