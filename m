Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A6606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ePnfClAn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Tapd9eiJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Yfk9BAIi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Xc5JZebQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uDttUbnLyhaD9bN+UprEjt85HkEYaCYd7ktaPAQujxw=; b=ePnfClAnUx19qgXItpXw67OEGe
	iuaF77n296prtHORqezEC7CF61LRx/vO3Fx5EiD/kW069kyvlzfryQ+ld5Wff+PiMkZ5ZzuyeybcP
	VDZE+4O6zRw+0pO8JezJreNpcuvZeyzRRx+NlgesNg+HFPl7AtTR4uSi+Uu8z+BzvBW8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWcKV-000000005F1-10N9;
	Thu, 26 Nov 2026 16:28:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWcKT-000000005Ev-2kNp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 16:28:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KH/tZHtB8DmAMqkoXeFeqiCjmhgV3EGxeveR+Usdz4M=; b=Tapd9eiJbMHVd9fmmHBjFuIvgi
 PBwSzkQiFJd1ungFKHIDGDgLaN9LH+gLiPvog0uEOBXzhQoASM3VyDNyQw2GsPF2adQKl4gzAd6qX
 40WcN+shUMsrQYA0Wx2KQocUnbxlVMUd7aN6t0nlAlsREhS0dOwkaqEHXjDmqlApAbfU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KH/tZHtB8DmAMqkoXeFeqiCjmhgV3EGxeveR+Usdz4M=; b=Yfk9BAIinxckPJXIlKmbu710Uy
 G/TI8vp8fXfjkCsrUuMTeYCG1GrY5Gg71DpzX5ymsmmr1jb9xKX/2jV1CAwz0tzRdpPuIg/AAxnhX
 et09eIHmejxjQXjPvnqoplAigcmWCpAULTCuTSTWxh4baN+tCBAs1qVfPQrGeqH7Yxxw=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWcKS-000000004Pn-131b for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 16:28:13 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso4147155f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795710486; x=1796315286; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KH/tZHtB8DmAMqkoXeFeqiCjmhgV3EGxeveR+Usdz4M=;
 b=Xc5JZebQh19vHK9lECLvL+6ZyzX4wl8bW/yplHXZBybS1NvKoJCHiLJgIm0Ongm0lM
 YhpzdaqgfcS/BrZrI8NAAY9FTfwmLPZjkARgGw+rvN8hP/1qfNP7fCwIvj+hD7LAtNFa
 Mb+8vI69RxCZoXX7IqH4NOnBIpeqWWgVKDQO3z5IZe7pDxBEIStG7o+8eFXa2s8grAww
 mPIAk1ZGn3MhAz52k87JLTX1QDNXA6WVogLFXEh4U60/lQjsXpeeqFeG1ZjQ+jiqaMhV
 kzxvLL6KnKsjBUSQhNCkZ+75OJGp+1PeLnFvS5DCo7OavuIB5opj6G+gMU4b4Q2MGHih
 kNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795710486; x=1796315286;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KH/tZHtB8DmAMqkoXeFeqiCjmhgV3EGxeveR+Usdz4M=;
 b=MZpWWRPILr6kQL1dznvjhQCnMn7vXM/7flu/Yj8LFEZWb0/tS/MZDcVvS2upCI/09W
 vhZ/LIvLO7dmmYZEt7BW4vdpMGujO5zDf2giKlbY653SSPYBV4Wkq7fLD9qT19dgAM3S
 cymn11w4fnnqEK9rwk2xq5jxTBcyOOljlpvtIPR0/KERly9YjAWCA0Ov3xorxq2uqCF/
 wmJboBOzerO+OzR5Fqge+bR2fhdSC+XklzzALsqI03kwCxSKm3P6EXGFVIDPW2IpkB9z
 xW577b//amlOe12wpvjCk8S4/t7B0nS2TCOy0kO0MbHlk72y4CRJ+hc4JInx2XymHqAs
 6CBg==
X-Forwarded-Encrypted: i=1;
 AL+hErFtr+1tlcZzO143QiiyjsWUBJQNEem3x2bPFDtILxYeHk6Rf9eLICl0Xjczq3/S4f9XYqvSInMzZb78E8T/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9xyfuHgispo8Z3o1ZLJ6B4f6UJpeekc4kseqwAEX3hIPr2G5GH
 kM9hlrfGIhJwkpdT3eVwP3wKrBIEMPt7UaobQ98eQjCgjWZx1MU074H0XBFDFLX2NXcVJ6cLt67
 ozw50xDMtk6Anw8m4MnYuZKIbtrCWAyqUUcTm2OS3+Rl9exSn7pgjbtW9t1LNI0UJjPWnWybdB5
 1Q26xcRg==
X-Gm-Gg: AZFdTZcBreIUiHLjHlWHA1HOutXuVE0fBJXaimJIlxtWK83xVeBv/R0Rh7fUYdZNmyZ
 Xn/p98j+rKE2dr4gDipLhrXPwXxGuV7SheZjfHj0k0/s0niU5rjpo3Sqn5cvT5lah+dumB37FVy
 6wAeST8zAV71hpgKPg8IFLRbfBdh2m3qKModKjTe451TRt3blTsXrjlw5BumYSrwmSA8A8Ihh1b
 o958kpf71R/3HkkqK7hJD4QT/NIoZhq3/sBedNKCmhH3kxni1+Kpg3yxcz+v3gvpmaEElNls0SB
 1tER5wnq2oH59YhG2XSR5P5gVLw3htJ95i9ZF8V5VerkHXcVlcWuy60exvXFTv0C4F/AxQqMnSZ
 2MrGrmcBCv84D8pCf47jLG2X/O3f+MWwYqVrvWOeeYbzZ1hX1FCxnlVUEGsyNASlRjoPfX2wYfp
 CeCKeozvID3vB1rFhl70/7W367+LTzD92oq5eTYH94wC84e96cnrUr/a0Q0N9+sMtsDo84FLnKe
 elu9QPr1/FvUfKJ6Dio+N8C1TGm0iR+Jv6jC7LY+4ctqyQT1+rXdEczw5Zk8Qp+/mZTH9fmh8Be
 tstjBCmpBgdBGPicD6gRgH/80QHeyKgh8lrsb/WN6wh4ZJf/zwEhu7AihwfrPCQRMjQdgpB7Zo/
 mRkau4WCFdzahrDhH691Y/6SEkZRNOCbIAkkH2c5zQwwjH9vduHX/OPTvfwsASrTbzNXcoag8vp
 ffmWxnbWQoCmKbP/g=
X-Received: by 2002:a5d:5e8f:0:b0:48f:bf71:2ad9 with SMTP id
 ffacd0b85a97d-4abb400bcb1mr44454340f8f.41.1795710485516; 
 Thu, 26 Nov 2026 08:28:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm41823177f8f.41.2026.11.26.08.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 08:28:05 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 16:28:03 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
X-Gerrit-Change-Number: 2355
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2355?usp=email>
X-Gerrit-Commit: 9673b2028574e8d6b5e9461400e6b8da1cc83d60
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 16:28:03 +0000
In-Reply-To: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
References: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njk5MjA2MDAwLkkxZjc3NTk0MGMxM2NmOTg5Y2Y4MDRiZjYzN2Q0YTYzYzNmZTVhYWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36a3a03b73cceebf583fded0dd72680d2fe5bf8c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWcKS-000000004Pn-131b
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Cleaning up Windows
 error handling for sign conversion
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5401265709239534282=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5401265709239534282==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O23JVJRRoGI="; charset=UTF-8

--O23JVJRRoGI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail )

Change=
 subject: Cleaning up Windows error handling for sign conversion
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1f775940c13=
cf989cf804bf637d4a63c3fe5aaaf
Gerrit-Change-Number: 2355
Gerrit-PatchSet: 2=

Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date:=
 Thu, 26 Nov 2026 16:28:03 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
Yes

--O23JVJRRoGI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=
=3Demail">change 2355</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2355?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2355 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Nov 202=
6 16:28:03 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body>=
</html>
--O23JVJRRoGI=--


--===============5401265709239534282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5401265709239534282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5401265709239534282==--

