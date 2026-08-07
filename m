Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D701C5AC80
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K0d7JjwzBXa7CBZNgTQCCLxkZHD8vGqa/uqH0uW8VOU=; b=cs4oztAhB5vZE0MbauOok7NV2e
	ExyxzeS75/w+ApPBxlnElRWTsRc1AIu3svJ0bYrKju1251kdGJV8e1dE0h5nndpU4y57LJsrwbk+R
	i6QR+5G9fyD1EJSJINk7ABJ2pkd2aCxnaAs9geNxN37s5dcEgK3vjHLivTH+qRzZEXDM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsItY-0000Sw-Jo;
	Fri, 07 Aug 2026 11:37:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsIt7-0000Sa-Ew
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:37:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/uDUL22yrfOdFDBvH24ixolsQIemx4eKJTVAL/VpqeI=; b=eT7vxW9F1I143ZKbNUtI2SmY68
 KkQhsk6II3FheO5whSuoZAxEVKftID63mvLBHtXaxRAoqzOoMJ1xLifg9Hn5gWcIgdJT2KunVdZNx
 UqL1Vh7awJN+amS6GZpT2/ABwWc69Ne4tLoYJdMeygQJZoQkMvH5JCl02xOW4BO3kZLI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/uDUL22yrfOdFDBvH24ixolsQIemx4eKJTVAL/VpqeI=; b=e
 3CRikavwAKmXT79qdS0lAlwLTsy/QeFHqbo07ERX93LwIzUX3w/Mko5PXNNfapeNc/6AWscJqGLLJ
 QYXjLGVxU1Sv6qoCp3sp3lp5aC8HsgHohs30FHN+1RAr+FEty7p+5gxli/H+OcYbX7MybCluYDeyN
 v2IxlHI62z7Hj/ns=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsIt4-000523-Me for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:37:18 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2269659f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786102628; x=1786707428; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/uDUL22yrfOdFDBvH24ixolsQIemx4eKJTVAL/VpqeI=;
 b=hN/YGoVgeaXjOpx75Ml8e5cXGGn+BHNmfCfs3RZjghTQ/9T0QT4+Caf0l05WU5zWK3
 fTjHJ8cMUxPqKnwUfv5D7XNZUgUFx7Nv9hM0MqC4aWcNRGtsX2PXwZUxP5xIl2JSNQxW
 6ud7Tk0G1V1PVeVX5qVKud0ZxU6OaWhjrRcmFSffaiOPI9V2b1t53qlyJ6TvQIVykczV
 c8k99pAY3EnIo2Bq1/a52z5YliqgQodB5LzHYbYUbNS4s3mSrwCSlj81SI07+Y4dLKul
 ciuNhFf8czsoVy/4gz6NsngKsyw6oDfMYtl3xmlO8sJCORFJ4vSVhAuwqh7ENZEeRXoh
 LSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102628; x=1786707428;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/uDUL22yrfOdFDBvH24ixolsQIemx4eKJTVAL/VpqeI=;
 b=q87ieH1bv1KeZ5qbc7mTJibHDwRlag6blmPgxOpUM5LX1Q9Bw8bN/lkjPhRNNewLue
 KA1JbnYkcMNYvvYMibQQ9xUW84OKBrMrwhcvXGZdcqoMrQYKNSFjt9Qw/gkoCu/g6Jiv
 JYFUQ4fMlgtyplx9SZ4Fd7xcrZT4ezzRXSu1KuG7vs8KU0FNQZLHCwAF5Aoa07Yta3/h
 xJdMDh98DxGhfuqC2SoZVc6hJvM6lq8VaZonUBj9kIPt058f1cAzvYnDqVMq4EQSzh/m
 DMCruGaC1iCzrPhIk2jYh/bz4dIAA3WAvdilGPP2cgMIFhDEHAWY21zhYP3kpJ900fEX
 HT4A==
X-Gm-Message-State: AOJu0Yy264No9cnDo38gLZG7/PDc/x4jM7BDuIfOFCtA+w/BNUXRimEK
 ulpo6KWiMuzLRbSDa/RqhgpS2Mipkh0xmCX4xB6aVnoejTI5FPvKdwGuCfdOcUNIUS6RYo9F/xF
 pWrGYlUl92imzHpVzUTdremp7pWkoZIZIbIq3+dQLYAC6dCyThfJEPjnea6WWi2TxndaL1NbbZn
 Avcd6r5w==
X-Gm-Gg: AR+sD10W5Is7lAnNq3Cpe7/6Fmao4UFZNjUUZqkxZ9vjrtZfiOq4qKurGtXkQJiaLZn
 6cNEEhsMJh0ybWNfPhWXSQugZt1KK+gPokmMWKVAlxZzYIFUrYjlmoeoUHRcX2PqjANpfVttr+u
 L4YXlAJs7k+MnBi2XDpZ/xk2vmewAGqqzTqXqjjqq4rgK0+yHIFEey/Nn6i36/htMiJw/+rn9It
 DXd8Zs85GPts46cQUTvzB68v4pu9+nDtydOfp6rmAqnhePjncZ0fZTTSjMmlO/Nx1qFhET+s9uy
 9q9z24/vcQfztePVqyUqwV+FAiDZyBsUOaqYnxRjF4iP7c5Zig9b5b9GmpP0z2qYVZ5MK+MjIvc
 SrqTT7kb9QNVkbF7TU/aZgU1zH/n1PvlKO4UwTT0ItxAysEtdgVBSqEPFWV4qk8P6YnXQv2ANjF
 o7eUfzUYFqmTzB4e+emFO90szW47s6CaRyuINu9T0gLIAbhluZTmQuoloSmEJBMIccAYxgz+v+P
 cAn4fXRKqzMs0SY0TNwz0wpeiLx0LUlO7cl9ViYL213ze3aUvZb6KAF9AGlokgRhPcF42ElqAal
 MYRD1Tr7f2KEQnSIPJfsEPHtuk/qvvjbxU2gIIWtStoblnmtMrOelV9Ycmg+Bg==
X-Received: by 2002:a05:6000:4813:b0:45e:73eb:5119 with SMTP id
 ffacd0b85a97d-480026d7fa6mr5006679f8f.22.1786102628381; 
 Fri, 07 Aug 2026 04:37:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f93acsm5404500f8f.29.2026.08.07.04.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:37:07 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 11:37:05 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f
X-Gerrit-Change-Number: 1791
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1791?usp=email>
X-Gerrit-Commit: 1ea34b87395217ac3f3524fce65c7944eb0e45f8
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 11:37:05 +0000
In-Reply-To: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
References: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MjkwNTczMDAwLkliNjk1NmMzYThiMzMyODY2YTU5YjQxYzE4NmNjZTRlMGJjNWYwNzhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <208c60966c3562e48e966fe1c33808c4d159b456-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsIt4-000523-Me
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.rc-sample:
 Add missing documentation for FPING_ARGS_x
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0165623416592718928=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0165623416592718928==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Aq0InyIQoos="; charset=UTF-8

--Aq0InyIQoos=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1791?usp=3Demail )

Change subject: t_client=2Erc-sample: Add =
missing documentation for FPING_ARGS_x
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f=

Gerrit-Change-Number: 1791
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Fri, 07 Aug 2026 11:37:05 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--Aq0InyIQoos=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 2:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail">change 1791</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib6956c3a8b3328=
66a59b41c186cce4e0bc5f078f </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1791 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Fri, 07 Aug 2026 11:37:05 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--Aq0InyIQoos=--


--===============0165623416592718928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0165623416592718928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0165623416592718928==--

