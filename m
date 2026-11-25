Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736E606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MrxV1mS2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EYGPLOrH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MKZz2Ttf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XOhNuzcQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EYeP5JX3g4U5JYb/oPzFiswqVSPt4Fijn/g2Fet3ceU=; b=MrxV1mS2CzEN1t1X/pucSyhwYO
	3hpvQpD0S3bd5Q3bag2z041jtIAFWXGnT67u+7eAvQ1Xxd5CeD1GidhCEXTuYUZoq7ZL12FWHBdr6
	Lxa4f3UfEBD/5R5SQqKTpuh0VLtoqQeHewSHhvXTer5DmF5k9/edohKqGijCAmQ7ypj0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWDWC-000000008Bv-1Lxr;
	Wed, 25 Nov 2026 13:58:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWDW7-000000008Ap-09JJ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:58:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HCTAaZTFls8S71AU/SWWk1xol7EWjqh8xao2ZfemzmA=; b=EYGPLOrHjfqkGEU39oqll+20Ud
 L+3hzHUUUDtYUZI+GhlQk8yUHUoflkmrhAzcPzYmiwzFX40vYbhFQXYeDpk7lVrh36Y58OlZ6M2Oy
 BVrpB+X79afbKnpFVeD2IaXFU8ZHIC2FhqPkC6t8bB/z7/4jXBDKRNZHuZTuPfAkMyaM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HCTAaZTFls8S71AU/SWWk1xol7EWjqh8xao2ZfemzmA=; b=MKZz2TtfCBwF4YWySfIvoUGcmM
 kNMWx42sxdw+GuQO8pAGrDf5AoBqwhLIy6Cu2inKx7xvbkHqe8qj4e1k4b46vC3yyy/r9UIZowPZU
 s3x4BKMUg8mevtyndqJv86kNxeElu3x88yLqct9OxixF3o5+hLmvszdNTj/yt60YgeFM=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWDVd-000000003N1-3TvR for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:58:07 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso5118296f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 05:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795615079; x=1796219879; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HCTAaZTFls8S71AU/SWWk1xol7EWjqh8xao2ZfemzmA=;
 b=XOhNuzcQ21C7lQHvwu9PFJWoXEuj51wJH54nlaUOVH//i8xe7qzGHEUDGy4sM6Nbc+
 WKgkO6cHcgkfMPnF+pWK6yZLcbBW19vYJeM/GM2Vqc5eBbgiwhge7/aVLAV1TrK/XQ62
 ClCnhtG38MylbFBHwg0gdMKKfB0Pb1xMy4V9j9PiosnOEn31Fl8q2+PmA1Q5rjPY3Eqn
 2TKpNxgKvSoB5f9Oy9Gxk936AeXhMw+BeHZTlMits+FDrXTEf/F28ffaNLIfgscdARxQ
 JcAHDEQuaSqfx6B1TvYfFGYUdnztHzkYqROEMp1D/h3/tzUxAf8639JxWgOhkleDWX1x
 XNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795615079; x=1796219879;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HCTAaZTFls8S71AU/SWWk1xol7EWjqh8xao2ZfemzmA=;
 b=ftdF66uAILMewFfjpLhpoFKyUkDNAq2tcdjLwv2vZFC5pQ6VhUTtTGWD7RmlviqKi4
 lyl3QHZzDVxrCkp27ywI59Fr+bGYFHUB3ypSV9cMVT91WIwBtTQqeeZ5skOPyXlvHyD5
 lqDNX7Qa9Lu7+DQczurzONXjOsGsWhQTvh66+3BEvCjvXtpvGN1MPGwN/svm9wbBJntQ
 3wkayTiZg1LX561QrOlfaCpJhoVBzK6HXlbFiFYhAR/7H/pntqn0vLUiTmVKNcVCeTP9
 SsZdcoIVGxqdXRcdZY7dggs1RWLXK6usr+XlwRGt3cMMbauVa2K80+FJ2Ll3zz2rvdoq
 kr4Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHKGwWWTaixbp2eq48Z/9+Voo4oCnin34IggNWngiYlKepC11zBHJKMLqL+Tz34fchlypNHyXMQK6jrAar1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z84BTipTjui1Tc1X2iPpRqEXz2fpmo9arM3B6pgqmSjSTqScOQ/
 gPhxxR/0uC/YCeUmWflH6YY0rEcN+Lo+/ZKCiVZ43rGmcuyBzK3y4FZ9ND+NMB4c8MGLxIyyVvG
 uEL54LGag+AamvS5KNg11YSgWyKgnwx4D2Pj+AGVmHoSZ5+RBeMWD8c8F5DmJPpkqnH/t
X-Gm-Gg: AZFdTZc22FJaEsQepaDGoDRTwc5x99hRdIpvtfJTvw22bTHU8oo7S4R555VrZGRGTwd
 oXFBOITZAFyqTxVN3HC2p4olXzLEEOj4nI4DYGsciddF1BQ0BX1hIgC2iW/PCTa7CmpGiMTxdF6
 eSkJKB7Cxf4DMzigQKFU+F4Lht7s7RmGI7m+iRcruNk6N+HtAp3oqzEmfk9gvNR7NdpnPyk1Xso
 5xpFoqtNqJ1ePH/08b9rJcM/jMDgA6VE8ZL1owDbIPg1yc1aqAEkJv/rVenxD+EsbvsfISLPk8w
 a4bKVDKwDLQ8ZLmF/rT3WsZM4EYEOO7IICMTnVy3xavT4UcIl/sb8Rcii6A+7TLjgiv+mDQCLob
 nRo1uyd2zKDo8WYZCQmgAS4a0GQPl4Y+1N2nv9uVvUQieEIMbCHgSoAniWmqP3YC9FkDSnRmQ13
 mRQyCYKlKVKVutOiR8gx0HiBq7CbdFzHXrsK04AFjdBH86+mTBRDiPyzO3ubRCcF0OZi5EB2MLq
 uWKU7dRj7CMJxQ3MHm0x1FZ7veGWuKVUh6GEwRi4B9JW61Sz3IpxJyxSu+iiMtrOw8sZowCWlmo
 Rh7y1Ail4ee66hSm08W09kNpbFUIVt/52fC5RTC0A8N1LO/Fs229391WvU468+UvnxNrbcjByop
 4BtY8UEz1TmU8BgIM+5ptDYj9ol1lGUk99KhuyL8iM0Q2dPHSR8Ao2Ykj6Kyp9Yrw5188/0VQ0k
 Jxbj4bCVUiNMar/hs=
X-Received: by 2002:a5d:4492:0:b0:4a8:1b63:215d with SMTP id
 ffacd0b85a97d-4abb6eed6e7mr26407496f8f.27.1795615078888; 
 Wed, 25 Nov 2026 05:57:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c4353d6sm33397317f8f.56.2026.11.25.05.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:57:58 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 13:57:57 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a
X-Gerrit-Change-Number: 2343
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2343?usp=email>
X-Gerrit-Commit: 0b99b1351ba3803055b067ed1ed059e315aa9340
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 13:57:57 +0000
In-Reply-To: <gerrit.1795613903000.I8d081c87af0d746a5e3a2382567f04332639622a@gerrit.openvpn.net>
References: <gerrit.1795613903000.I8d081c87af0d746a5e3a2382567f04332639622a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjEzOTAzMDAwLkk4ZDA4MWM4N2FmMGQ3NDZhNWUzYTIzODI1NjdmMDQzMzI2Mzk2MjJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <41cbc845058c40cfc80b74f429272397bd2b65d2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWDVd-000000003N1-3TvR
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Add more
 printf-style functions
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
Content-Type: multipart/mixed; boundary="===============1475274744343318263=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1475274744343318263==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qoa6hjYu45A="; charset=UTF-8

--qoa6hjYu45A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2343?usp=3Demail )

Change=
 subject: cppcheck: Add more printf-style functions
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2343?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8d081c87af0d746a5e3a238=
2567f04332639622a
Gerrit-Change-Number: 2343
Gerrit-PatchSet: 1
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Wed, 25 Nov 2026 13:57:57 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--qoa6hjYu45A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2343?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2343?usp=
=3Demail">change 2343</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2343?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2343 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 13:57:57 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--qoa6hjYu45A=--


--===============1475274744343318263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1475274744343318263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1475274744343318263==--

