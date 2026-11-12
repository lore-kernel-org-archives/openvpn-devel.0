Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C2606A330
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UqHziKqN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AMzLHQNz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TqEhvg0+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bn/uETqp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=K1PxF3Yshevzdyra/UXOTpBQ7KrZ3PgbcSNgzfc6Z2o=; b=UqHziKqND67Cvfp4KMV/bmUrK5
	MQH8Ovre9yvRrkxrFFssqC5bfjTXd52pw1BaClBhl8soVUv5zxSggeUbM1wVCphh14t7j8u42DthG
	cVV6mAX2keKhqX/7kZwieZPLFtgtPub4t+IL6u6NtXPTH7oKSTH0pcSXZ26NDDWOvEac=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRVcF-000000005mv-10iB;
	Thu, 12 Nov 2026 14:17:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRVcE-000000005mm-2MJG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:17:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fHuJdq/3G4744j7Me4hTr+50CRXRQpQtV+ZqPyADMRg=; b=AMzLHQNzkVBG1lAyVZ0Tk5nHcC
 ETSP53CncP/a96lU7j8/ok87GWeMdlqmrZ2gZf3qYZcqvl+SgxMx6k3TizD/29b6msdt6/Ik40/TB
 sNEVD7HZT/JGkIUexpBYC+p9FlHj90z46t3s6RIZ1aF3lCB3/NVQJL9tVdsxu5snngYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fHuJdq/3G4744j7Me4hTr+50CRXRQpQtV+ZqPyADMRg=; b=TqEhvg0+uXJdYoRYhRjB8EUWQ6
 cZUM/2gPQdraJQ6RgIoO0IxYHyEgWY/aPtSVWfVW7/bz039XI1JcdqSyDZQzVc0DUFGq3jWcCkzgD
 yUm9sZI9NppjNmEs4IcCSDQBYo7KmO0H+ULPJsAuCYDuvk8+iZ+cgW0E2ocSuZcsnUBc=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVcA-000000007Kz-3ACh for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:17:26 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso34105775e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794493036; x=1795097836; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fHuJdq/3G4744j7Me4hTr+50CRXRQpQtV+ZqPyADMRg=;
 b=Bn/uETqpVl7K/7DHqRVVBCgHI+tJSatJlQV5xpOmBX57bSdSPBVHGI2vFZ8Bc0jTjH
 Z7O6B/o51VMMEs1o/Ge/a6V/Y/7xUqYcTn4UDZ5bm9M55/bqi+LyQyLXIYFnSib+ZDGi
 loe7Af345j3vIgGUNcsIgr5Tw9smMx01sGWFtq/adJpCJ0DDsaroXdHnRBn6U77RS6ik
 iJEyVM/ltw9SbsW9JhVPFkEhlxdbfnEj6heDLzXJsAzj1j+66KWIopo3sxB4QYAhprVa
 tVz6EklUig7av9xVRpSqry2nGe+6c9VOKpi0sOco0/IHoYPIcst/5VNyG+DBk4iyoknU
 DAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794493036; x=1795097836;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fHuJdq/3G4744j7Me4hTr+50CRXRQpQtV+ZqPyADMRg=;
 b=BabxoUYr1G7AYPAYoZsoX6ASpvRqiyrJQEB0SbOEoTrk5CMkc9q1pktWfUlUuZ2BVX
 AYanhzE7B8cemVJ+uiQsQQcGRKiymAJYhhpfwIHJzodBMA0phu30hbbyNoQrRsxTNu7N
 MHl3k5oNE1503/LhJXPXEHzni601lhAa/FIUF6+srDeCIBffJrYpAVZmzCBG3TetB1G0
 hWrc/zqgWPWCjhzVNORCcLnvOr6H3PTEHhfSOGEl6R/FGWLAGMIVAjUP0WtyfIQkw+Wc
 JgHFKWAFn1x9o1koj2wSDuPHfmQ1bIZ2//2WK/C+VlFESMNRPEHJ8KDuqTdJO8VZAnby
 8P1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErE4RNg3GKfe5GrKmFTSVqRximZX61q2OUhlyaf65jgCq6ya/N1r9qMQ0Tn9CCyIs4RGU4RVfefbunDoK1z5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Ek08zErA18nraRn1xNRSAHLqTilxRvDKWaqVrUX7DeodOvffJ
 90KG8kdmflC4Fh3CyMH9jnebEMpZeDu+Mcol3nqk05wsscibV60AzFkWxHNmkaUCFtnzUUtlmgr
 RRL5mm0b7bPRJyO1GxyaR+S08WM05kBrssFr4hCPiMtxlQ/2HUtn0+ASEYP8bJ56LYtC/FJQ/dS
 mB2TCOMg==
X-Gm-Gg: AYBFou0AtA/VlJv0NN1zHL4PgDP6v+3nQMqTS9wnABBJov+5g80QSS1KKI8cgXLsytU
 MT2Q075PBG5vaLK9tmkj5lzESsQ3RJkJNVTASpWiGGyjH6OiwUoVzZDzdev7RMIDtt2esPimbWG
 Eg5kZG7IS+s+KNDo4KxUG0TzAzaBgeUySPoxk3cWZpoeFpwqM3H2OVVEtz/4A0IlXD+oxpG6sQ3
 M8G7pjL1XOQvWYTlzJpB9kmOBhxpGpgi1aFvxZUP3Gqn0+6E3LB8WATJL6VaIINZdAHdxCoxKee
 WTBtmWwcNXh66sLRA0/uVnJJxuzA/JGiqBezFrJmo3/w9dydPRPO1XdyIlsbxTfWMpC0QmpuNbU
 dHMU7STugj0Qfrd2MM3/7Hmq+CP2ATBM5o/WvXEWlgTSBbhcFLI7JZ9cxak54l272T52C7xF34T
 NyFF2tvABHqMZPWBPU4gGfIvCKKEO82EcP+MhXprqZluhaxc9HGa8OeUtv4skaB7nQbKo3rikL2
 QP+98q47NG5BOiF2pR1zAO/k/DqogiWVxpPGLwWPwSn9HP1N+lG3/ys+XPTKQU6RlMZQ85HNlfP
 T7CIctTcCocttjdPfgBhMtpQtpdQ2dAFMY3s9fEfIpu6u0O1DdQthQ//I5virH8xhaahpTy3dlp
 pA4zio6+Wbqew9a7cKYOwflwmgY4f2h8S8Elyn+YqgUrAF8wL2ET++7as3JWcMH+1Vmb+5plIkV
 Tj/qyl2X9vzxWfpf8=
X-Received: by 2002:a05:600c:190a:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ba0931ed17mr111077865e9.2.1794493035890; 
 Thu, 12 Nov 2026 06:17:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08ddbe68sm222917415e9.0.2026.11.12.06.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 06:17:15 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 14:17:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I793327150883ea0207bcb9724341e750bab92474
X-Gerrit-Change-Number: 2179
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2179?usp=email>
X-Gerrit-Commit: bbe3bf4a2299f15dae70f8fd12977c04f99a8399
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 14:17:14 +0000
In-Reply-To: <gerrit.1794486687000.I793327150883ea0207bcb9724341e750bab92474@gerrit.openvpn.net>
References: <gerrit.1794486687000.I793327150883ea0207bcb9724341e750bab92474@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg2Njg3MDAwLkk3OTMzMjcxNTA4ODNlYTAyMDdiY2I5NzI0MzQxZTc1MGJhYjkyNDc0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <307e367e6aa017c6de3490fac1fd516be371f929-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRVcA-000000007Kz-3ACh
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: wipe and
 free partial responses on conversation failure
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
Content-Type: multipart/mixed; boundary="===============8670280139389850466=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8670280139389850466==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lFflY+6jF6k="; charset=UTF-8

--lFflY+6jF6k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179?usp=3Demail )

Cha=
nge subject: auth-pam: wipe and free partial responses on conversation fail=
ure
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2179?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I793327150883ea0207bcb9724341e750bab92474
Gerrit-Change-Number: 2179
Ger=
rit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Thu, 12 Nov 2026 14:17:14 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--lFflY+6jF6k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179?=
usp=3Demail">change 2179</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2179?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I793327150883ea0207bcb9724341e750bab92474 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2179 </div>
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
"display:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 14:17:14 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--lFflY+6jF6k=--


--===============8670280139389850466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8670280139389850466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8670280139389850466==--

