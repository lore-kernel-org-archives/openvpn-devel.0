Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135E606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a5QHQtpD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YGmqLTmR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k0SMe6Mk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FSubexY/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gDw6j33R49ZnjFTriFopBv74MOeoGugHik2vk/GfvyE=; b=a5QHQtpDPWcf5acJ6hX+60WrTv
	LyDss4KCoornyGR3ojuCn6b1YBoqVeq13bjZ8Ka2IP/fThQAZ0ozG2HLXN/bxot9uJXo3VEy7FAKn
	12WnV9qhtqEt/LVcvYQV9nC7Dm5tAmNeeDXfCRjYcv/ud/jr5kcJEgUpcZiov2P812j4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrrq-0000000034A-14oD;
	Mon, 02 Nov 2026 13:14:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrrp-0000000033y-0aXZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6PGyqZv25CyQpAW4yd5mY5b69Hv2zLu4/EpB+llqAcM=; b=YGmqLTmRMi9CZS4ITtre0ZXerm
 Rb5QDRP0Ms73+WooRnVwYwWNY4oa3FdoJ0Mpo5TVna1qFI8Rzc5jtLapBJVYqAZRmD7mqFanzX0X9
 zEbTlhefnoGPPkIiQAZF8u2iqQjp0xWdfQDYHhTNh05Lk1fidiEnZHUMhlSrV8JvbN8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6PGyqZv25CyQpAW4yd5mY5b69Hv2zLu4/EpB+llqAcM=; b=k0SMe6Mk4I3LyvcKVYZSkyD2mc
 aObjgvz20YdbXbIBuQnohJD6CucsyNBsm/nSAZF7mgkxJPsHEwwsCeUuBfFGf4gsAIBKjj+ujKPYu
 5B/Ao6HtDQwGdFjmVkgSgi7Y4yjOk8sYnTk7kpm9ApePvTQVt46NHNxN2uBXiI7laJrE=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrrn-00000000811-2JDI for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:14:29 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso2092641f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793625261; x=1794230061; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6PGyqZv25CyQpAW4yd5mY5b69Hv2zLu4/EpB+llqAcM=;
 b=FSubexY/hMKVykpeQSOK7n1zruV93kAuS7XdQygTf5B2U+YkJSG216nlAlb+aE0x0S
 c0iXgPSFRuKYjo0o66jBPOaEyY7QvHfKCPrGLNDirO4GGIOLtgVDfmpijApo6b9xRJqz
 PnEfquUh8tmWLxWW4ntjbGD5z+HW7ATGYXMk2F0w63TAcOKz2vUxb1ID642/xte6pXKQ
 y6+qOBcv+bZzFY3G0y/439gQwQjEuzUU2uPipxfxYVgcHmaHGz9cTdhHXXjwmy4Cq1u4
 o+wiOCBgVBdOujvEIW+y8XJ+jNX3yIwO1lhR/bPhyNsyYOpv6k8jHZLn2EGbc4Qj6CPN
 zZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625261; x=1794230061;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6PGyqZv25CyQpAW4yd5mY5b69Hv2zLu4/EpB+llqAcM=;
 b=rLWuat8SdiRbM7Px2ssjs6iVAt7qP3UvPAAvmNf1dXYHcVoQlYU3HHR+WzGyMGUzGm
 vxw/1gZ/yYYKuVV6/tXJreb7Isui0WFOCpfA6skAiJJwbh011LxromSb6Ne1JN1TJ7ZR
 uYFfpp3LpT9hSI/D4L8g1idSoejpLqUrPnzGHXMapy7KSUUP7xB2V+a2DuECi8HMcYzI
 9oKO2wbg8ALHr9zIJ5XyzyYb5OJLvJP86Iw1Y2MUTkT7En5+rZyLbt29hT2EQirtT5ot
 AxmkXA+EOdw4bzTnTu8Pe+NIgcHyiCq7at9nvgJ/uR0D0StKcrJFmdtt97psWJy97eus
 dwrg==
X-Gm-Message-State: APuU4Z+svYJPM2I9QnhRn53xPtq3sAGgGIIaZylU/Fg0+g98nXmrl7CM
 Rwg6V1htYtR+l+M+1J7sJOJ+bFklJhe9zSvHAYqmgFpqW9RSDhKnYMyIZTidXanTP/bIW/angf/
 UUy6XcrOPzWXdADvd21+Ynhgf/zwdZOM0GBS2igfTA+t3BA+YBygERFnBhfyT7Q2u2UHDgDOVAp
 t8s/4eHg==
X-Gm-Gg: AYBFou2woL4Yswt+NXeoj0HOvhVl/IU02teMRKZZpSlYDyACsr5Jp0w/KVn9nLotE4T
 tDNbf1WLJlJPg/vsd2xZjmW8IdfH7IjqViAINfPXCnchke86yENLmgjvpR8/oKphjzjamCEi64H
 BG1p+3JB7pd+f/oQ+pEoXNoUKKkP3cOQ8dtb9+Rh8zBGvYq0DzaH7cwLmiUuho/753eS/qOJ+Ib
 G7Ok1yj3puDfUjnoGHZb2PM2s6Mg1ogw/0EG4JwNrziZW6EIypxpYlm3eRYQresijwHnbPCk2Qc
 7zBUUlN5t7n9qCBig/sF43UET2vWb2fNTOK5uqAKOP2maAreGvvZM0e7knplgUuX1YdkUnuwRvI
 2qzcT/BzgY4ZQHMp3Bq7LOgqu0Ddt5PMU+Dy49d8G4VFJ15sW3lKeUffVjlPxzFt4SWd4skNu10
 qESdloFeA3oHK360am/JwoneqMygYnjyLQNh/TwUHHFoZ5nqRUfiPR2IsIyxjHD7jZhG3paKgef
 Obh2Ww26rUj7qghpB3ZQdFAEGvKyWTWRuhQkxPc64NFLxQXxNXDcxHxFsw0lD+qUUTzOH8gcGRJ
 GZWMIzAjTSoe244CfV+0bsu/iE8x8tYTffYXHxdG7boRn788inJGR716ZbBArS48lJ0mbxu/Y+T
 JqtC7ftw7fmkqeOVAu/rNRJyJiUkxbane+qnMZZzxYcWV/O9Vsmawqz4p+A2MgaHC5M1zbWXLuu
 AEvw6gp3AaReElDA==
X-Received: by 2002:a5d:64e4:0:b0:48d:fbf4:8961 with SMTP id
 ffacd0b85a97d-48e7377d134mr20154142f8f.23.1793625260620; 
 Mon, 02 Nov 2026 05:14:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80306sm21521026f8f.33.2026.11.02.05.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:14:20 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:14:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915
X-Gerrit-Change-Number: 2083
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2083?usp=email>
X-Gerrit-Commit: 30b20ffbe71b4d293ecb48c0e3b3551137beef75
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:14:18 +0000
In-Reply-To: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
References: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4NDc5MDAwLkllMGY5MDJhZTVhYThlNTQ5Zjc2ZjJjZjMyZmFjZGE0M2VhYzE4OTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0178756294a26843fea4a832f358a9a1bbb31a8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrrn-00000000811-2JDI
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: append
 cipher final output at buffer end
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8601005907355636393=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8601005907355636393==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yAJj6hMJMMw="; charset=UTF-8

--yAJj6hMJMMw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail )

Change subject: tls_cr=
ypt: append cipher final output at buffer end
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32fac=
da43eac18915
Gerrit-Change-Number: 2083
Gerrit-PatchSet: 1
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 13:14:18 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--yAJj6hMJMMw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 1:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail">change=
 2083</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2083 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 13:14:18 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--yAJj6hMJMMw=--


--===============8601005907355636393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8601005907355636393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8601005907355636393==--

