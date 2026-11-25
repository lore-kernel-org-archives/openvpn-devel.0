Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D4606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FH2gJ6r3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=O9/CBhsw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jbzqHLn9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bz2zVc0h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/7x8tJVRh1OYEVCmXu/oe9wAlAX6t+SFZ83mhiazVJk=; b=FH2gJ6r3KKfDEhbcZttgicx66n
	BUgG6Cz6TIpvLap/elgPfKAA1vcaTme7XeKaKJoQU2iZUNKzGPeTgxEWah1gNVWqpFRebe7g9p6VD
	cg2EHQKSgx28mhokNijQ/NSFdf0bQt3WUjZW3Xr9eOpSxcwSnFpK5IIZ+mxF5lwPmUfU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWBDh-000000005Db-2IK7;
	Wed, 25 Nov 2026 11:31:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWBDg-000000005DV-0eGh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 11:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ou10d4xvYtKbyUK15I6f2LUD9W9CreQ+m4/FjIJymJ0=; b=O9/CBhswDmjcdwan1zWtdarhLG
 DR+8zSV5dsBdyp+ZvePfpuCcwk9I0ULcwlQ7yQ8wMKIglf67dy1K8ZlemAm1nkra3oDqezB8pa7eG
 9ZMy7w3LhaDT+LuSNaoKfzG26Ux1LZ78AYmx2um6wO1XhlX3473LxKMGNI6QgYdPEPjY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ou10d4xvYtKbyUK15I6f2LUD9W9CreQ+m4/FjIJymJ0=; b=jbzqHLn9vJVmFskzZ20XK4gIqK
 ByO6/q7r1G/3z0sRDFhco/UFNHEfCk39TgWXQN0Gt4QPNXBQbqgeZu5uNpgsEgI5R9q4ClYocIWnB
 vECoE67nlMTImbtL4QS1Bv52hh2bxn204ehJAtrEun9khspYoETXRcbwskMMSsYzV4Yc=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWBDe-000000008Va-3AfK for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 11:31:24 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso4279417f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 03:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795606276; x=1796211076; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ou10d4xvYtKbyUK15I6f2LUD9W9CreQ+m4/FjIJymJ0=;
 b=Bz2zVc0hUksK8Z13RCYaqj8znNdmtxWmwZjjGBQ9YlH4Pheih8AjJahE+kH8v2hZ+W
 Y0LZaMKqEB6oclkzM44J87wK8oqNS8F+4xsk+fi/ZuZ1z6HHHdiW90Oo8wRnCRdz/YOg
 dI7aXl8ss1qNarzBpXllplybBr20MUQWJKgq8x6VttactFvPUCJhQ/gbfQqpMsM962e9
 WGPxdQ0as/SAJNB/VU3D+b/JG5xxIU5icpsXrn1Tb2dsWDNcA37TAWjjWICEEiFmLg7q
 USr3pUkIaL2RksKqBwApehDJ6wzyI7C7oKzbWc+bHHFQ8yt5vBcqMYupx6tXpEKVz++F
 fWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606276; x=1796211076;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ou10d4xvYtKbyUK15I6f2LUD9W9CreQ+m4/FjIJymJ0=;
 b=H7ujcpuZXdtedzsqKaTO5y80ei1c6qBwU0nuvy3e6RfFmR2QQUOZKTAPu9o1/57+I1
 aGt9ehvh5zcGr25uOoDN9XBr4xFm4iwhRFr/Ef4Lpx2qAlVbaiUApbwWvI9y2Ne63VEM
 8hvFp0S9f3y4ODmHLZuOQA6ITa5MpRtXkoj9mEAvp58x9hFdWH2kYsHxuzicmLjxiX7W
 NpdfB8zHFV0nAFrFcFE2TfTef7ID9F2+JaPrOIzPb7hSRTyROVV8S12sSgHxhik5Qbgv
 Pgbp9KmfeD15DSMTGq6FjdnA7egFfOqMwrDCdjXWmRKHDqckF8VsLYC2QLARoq16FX20
 /owA==
X-Forwarded-Encrypted: i=1;
 AL+hErF6KR/HhfKoLvQq5a31DM7ME1RKvkTc+kTILkmg3cTOLGQhjHLurcjoMKwyiuS/S8cl2S8DVz+A7u7OmU48@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/hOA9MJY5Z1PlICJvAw2pcoC0Rm88nQf5wrno18yvgdLij+2TJ
 Owcx/azfITALe6LxAsTXEHzTJy4bZ5AaK9UEqptG9DLi1hYB1tlR6CLoLMxRKxofOGpBC/DlFbl
 S/LovOxS7eVky7QhrJeZdTUl3c8psO031VTJ+iyv4MXmbpZufjtTicPpDnQULoElwKixK
X-Gm-Gg: AZFdTZcSvCMXT5O6OOp3gT7XzjiJ+u17lIWlPYPG5Uzdi0hyrGHrSXpshhOz2T15jJp
 kRlCSIAOKkm2ICuiosAPM6n/XupKOP5FWi1OebSbB7IUBx+U6oQiwqKA8N3Qm8A0PPjKQrw8rPu
 gZJVuH+iksfyjzUWOEY+pX8rj9kGSaCh1+2wL08hiLEW/qZm40kcQPK49v77PXLxYuduOZFbceX
 RLn1tPxmQ/SOsRjTx9QP2HhG2fcFAzrFMYoY6B1on1Q9KL3z6dVA4czkwl+6pRccLIK1Z/FIbcb
 dC2n3ha5lovOpVCCHkppDcOB/idBL0Pc2+/19zUlnn8tbDpc4OeGgnMy8iXQGLh1CCut25wVMyj
 o/onPDRlIlaPnbnH45n5up/DUgB8gPoztH2HyDYa1NvkQeuPxeiL3h/MYCzmhq7LhkTDb/dHCY3
 CypyBRmXG7VZK02fX31O2AfD1HdLPxOH+om3cd47E0shCDm6sCNStJ6m/o/nI6BSwaAD0acW4RM
 gMnPI3GdWhjnRefPUzMy9HzXThdNvpypNpZ/vX7VSMeTLGrU4Ia9fxObOWzAAQ8IK15tZ0e5tpV
 cvu0ykEHGcc4j31aKLk2zTC864srFN9wlemMWX4TZ37Np5YhbAXDF96ymHW3TR+tKymDWs81foh
 h/IYoBic7eCgtpyAKQTkORIjQgfsWAK5NThlxkJqikCv2BUOFJXUnw+E95dQMJUS8PqR6c8UI3f
 FgvviIOcLr/FPKjwU=
X-Received: by 2002:a5d:59c3:0:b0:4b5:b60:4814 with SMTP id
 ffacd0b85a97d-4b50b60487bmr16055030f8f.54.1795606276036; 
 Wed, 25 Nov 2026 03:31:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f1b2sm31179650f8f.25.2026.11.25.03.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:31:15 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 11:31:14 +0000
To: Deri Haerudi <abcderyscreenprinting@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: cafe4eab2d6f519bde8d4ebef000ab02a8e66006
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 11:31:14 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <360637cb7baa79c0afd24048b0f29f360d1b083e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWBDe-000000008Va-3AfK
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
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
 openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5746059454890305028=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5746059454890305028==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yRsJd5iCifg="; charset=UTF-8

--yRsJd5iCifg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Deri Haerudi=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Deri Haerudi=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject=
: dns-scripts: parse dns_vars_file as data instead of sourcing it
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id05f3e4e32a=
eb806d762858e754adc82f42d4371
Gerrit-Change-Number: 2341
Gerrit-PatchSet: 3=

Gerrit-Owner: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Deri Haerudi <abcderyscreenpri=
nting@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Wed, 25 Nov 2026 11:31:14 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--yRsJd5iCifg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Deri Haerudi=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Deri Haerudi=2E</p><p>Patch set=
 3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">View Cha=
nge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">=
change 2341</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/234=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2341 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Deri Ha=
erudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Deri Haerudi &lt;abcderyscreenprin=
ting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 11:31:14 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--yRsJd5iCifg=--


--===============5746059454890305028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5746059454890305028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5746059454890305028==--

