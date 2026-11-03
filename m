Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32266606D82A
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Bq/siqLC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ewptq5zc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Vm5y7WQZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cQ1/vWua
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nG+5878x2DoKvsIMn2NWs1cG2NrNZ+BIAoTw3dG40mo=; b=Bq/siqLCthXzsZsbHaq3CEFKJD
	ubUzh/QBQNI1KrOlJE47QHrqnzrnBYM+EKDVPwP1PtJ5pwl/Rz2VZIUVbjJOM0BmLJ2pz38ySOLb9
	rVmBnJdXAb15sSiavNB8c7+/Mqi/+1kDYld6UN0KFS4/Bq52XxhB+ljvPXQ+7TzCvhss=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBQD-000000005VC-3u6D;
	Tue, 03 Nov 2026 10:07:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBQ1-000000005Uo-3arb
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:07:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l4+GyEFisfY+BGM2hgm/ec584WxozQbzLi1nagA6iJk=; b=ewptq5zcSy8eWAgvRDZfKhPknh
 AJ/oJIPM/q+Y8OT/0AgdazTMphKVR8UMLL2oYQHCY4UcGphYcgw8UA4GOSBb6bdsm+kxCXqtmMjmy
 LUhtO7Y47m7plo6vv4GDWpSIRPleBCHQnRr+DRptMyQ7lvGnx0ChlobBh0l4Mg/IZKbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l4+GyEFisfY+BGM2hgm/ec584WxozQbzLi1nagA6iJk=; b=Vm5y7WQZOaIGI0EGX2DqkgQug4
 ondYRf/1JymeYMbltAejIFOQ6sH/geVJKm88ezAxKVMGXtnv65C4TH7OKYH0gQ2/g2DXnXkZtWWxv
 fRyf1Y++sV0fn9QyQryokCljfPAhFqt9zlXn+X8Qoq2tPLLwZWgoFbYdETntDQ19wbaY=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBQ0-000000007Y6-14tU for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:07:05 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2368473f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793700418; x=1794305218; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l4+GyEFisfY+BGM2hgm/ec584WxozQbzLi1nagA6iJk=;
 b=cQ1/vWuavMe322nKYCj33QpU5uwmCLG6bcH8pJjCmgC42vL5I75+9+zc1/gWZCb9TX
 3rKSZChMZ5PwDXhOcAGHyURMTW+Ev8o7bQP2Pnn6+JAjwgDKWOq1eFmJY57iRqRIcY/Z
 cwc2eGO4v+uX7yVmcXqKO/YW3H0y1K8QtZHMUDTLRp6HCsU9CPv9ysZFpQYWGCRQdl28
 bBWYeoSJHG/MNozoFbkrWGspN7FvgOLbhB1vbHmna871IYU8vAFJuEbML7IeEUtGDZ3J
 xB9jwBHT5TU2joAHCi1+omUnbOlkLuUQQrAx4Gs/vyTdfm41uF25bBE963+6BubiT3xr
 XNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793700418; x=1794305218;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l4+GyEFisfY+BGM2hgm/ec584WxozQbzLi1nagA6iJk=;
 b=yNs1nDrjmRUFpYvEAlRlzHXtfkUFos+fJz/T3Y4CMeiI2uvMxXzVN4HfQ2hLw987Ve
 F9XQD2ul8uo5I+uKRx0ZTvGO3ERrAb7Xec5OcPAaQXA164+mZ5MdS1gvh7FTcg2CyfkG
 ZQXdoGtuBjz32ydWBeqyGhr60EIOGsSpxhgKX9r7lSXJW7rcfSRdf3ijRiibXS1pJNRf
 n6nkIvj6OA8V8PAxTKEcUUgsKmpx5XTcEZe0SXt93RYoweKqr32JXnjAJ3geVc2YLNtV
 ADAWFNWqqCF748YbjW7kyiQgEVGWpi4UvTMk/YI9UrrDqtFrrbbdHjjN3NPhrJ1asp4c
 mlBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtMrZdXjmTTKxZCbzHDkA+VkIs1/BoIZ42mkMZB3vbbbbKpOPJC9Yp8iiqyv4ePBaCzAhiljY0T0cgFLUQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z90/qSqxLTlrcixxBqIYYbkZ8rgFCMpLhf9obfFml7yJk5BBGK1
 r0gKcl2ekIcLbPSlxDyHOnb2xgs3kItX6a7OiZzIuIcug+apNYegKRBEKOus4x9SlBZPXn59MON
 E747hloBiwxSVqO0rktRn42sXY/IFTxg8lgOrmLkNrsLJkuZ7QhWhAX9Te5zsdhzfFuEz
X-Gm-Gg: AYBFou2UQK2YGBlB32daaUHWu3oJ5Jk4AVdKTDHWAK1taHH8w8FDX2hSCuMjzkNO1L4
 l329R1adjyaqFreFVhRm+lc2LxOkbhWzrSF7XDxv0UppQs4iwzEt1ircCTiz15Ge4y8Iow4yOxL
 Zkci3WoaXrEYTsASLTICJs89rAoGrVjQzGDQGY7uJ689HlDg97j4jAGNAejwCN/hnCI6DwjaNDp
 ok7fABqZwwKvL4Nasm9hzCWgyo9cZmS4kk2ovJaGfORRRUyGDfKiEvfiicLbh+IDLhUlCOblmPK
 ntTuG12JXK6gK7DQu0CP+Yc6Z/vCpQDPPpXRYRKJwu5VVAeKyNpw9rmgqKf4nSp1cNIWLrLnk57
 Duikxs4xVC0B34G32oxyONFhi2pKxujJCnpxRCsf4v8GTOcTTL8f3HrDReDeK1jdl9g0PTw9cTz
 HluSZIWi8N6joUZY1AJ2+Ho9N5qbXRShQJvTCGDRGRqqsfRtXsTb9rDPPgNxILmt9tE4GB62kcr
 xqSSCTWzVW9bI6JmgwSIl94tASBlY+vLIAG+cbq4OgZEOUCkCzsZjk+QZn9syoUGQZXWbjfq3tJ
 wVVnovSdp+BXCIWkdrB1kdsKSH6KH4aIWJ2BuVMYRiSPoxhkyLG3erm7s0IoAmFf4dDCSU8zu1y
 wqVuMZo5n6uceWJPYMQBO3xV0Ay+C+0dx8t4oObOdvXr2/nN1V+S9i4ihIRnoOnx9doH9sdqDQT
 RL0dstrxZjlfONDA==
X-Received: by 2002:adf:e007:0:20b0:48d:fdd0:6ce8 with SMTP id
 ffacd0b85a97d-48e6e2bc847mr21447123f8f.3.1793700417488; 
 Tue, 03 Nov 2026 02:06:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7270asm24343187f8f.11.2026.11.03.02.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:06:57 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 10:06:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: bdffcbf4c648ffabd4d06de8fd5263ae4b71d203
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 10:06:55 +0000
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f774b2d5b1a34af3c2683c3abdbc65de27d8da2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOBQ0-000000007Y6-14tU
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0038779262982771829=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0038779262982771829==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eeJ1aIti6/k="; charset=UTF-8

--eeJ1aIti6/k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering=2E

R=C4=83zvan Cojocaru has posted comments on this change by Arn=
e Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail =
)

Change subject: Introduce get_key_by_management_key_id helper function
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 14=
: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1856?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4=
2d8785959c24bf688190965e58b9b98251b8557
Gerrit-Change-Number: 1856
Gerrit-P=
atchSet: 14
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Attention=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 03 =
Nov 2026 10:06:55 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--eeJ1aIti6/k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=
=2E</p><p>Patch set 14:<span style=3D"border-radius: 3px; display: inline-b=
lock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +=
2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?u=
sp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;">=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1856?usp=3Demail">change 1856</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1856?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1856 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Tue, 03 Nov 2026 10:06:55 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--eeJ1aIti6/k=--


--===============0038779262982771829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0038779262982771829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0038779262982771829==--

