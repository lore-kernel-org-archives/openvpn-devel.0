Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D320606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bj5LStz+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iuXVXx80;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TlTAV6cL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SKkzHGwj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R4Pz6ilgWOX7IrVYVccnSS3tT8+ndAG19C1TjJ7VUZI=; b=bj5LStz+ZMzAr8MN00IpNGJ4Iv
	h47FoKnSAqmgwS7s5m8+QJt+RyZQ00LmWwLzlW/dg8ZglIlKyyzXl19/EKAktDZG8ladX2XeMr/Fu
	McGMPOfdisXdluUd/xSZZBGeP2pejRGZ9hGndmhlzE7MV3b9gi3vjX/HVKfCLXr8sjvw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM5ST-000000002Ii-1ugV;
	Wed, 28 Oct 2026 15:20:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM5SS-000000002IW-10Tq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:20:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/zLQ8kZKV/OKXzubeWYXVfQSpCEEpAWGinAw3ZN4BoM=; b=iuXVXx80vHJpDY7DGodRonu1+R
 9Q9pAacYP0EWOVepFnhJRKPOY4TDnIafWP29OHWSUORA7vaVjbMXwe76WTI7atRfFDA/jVY0fzb1t
 xnUN3VMKRBiIeNMms6NQ/Y9HZppImhZjLgHajvpAW5dDvfsSogONoEXaP/SN48eF7Kck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/zLQ8kZKV/OKXzubeWYXVfQSpCEEpAWGinAw3ZN4BoM=; b=TlTAV6cLugLYXA9JwaazPNAIqB
 tJ9abTwYyZBkaEYZ6BMO6gv+D76up4UzCQOAwIjkyRWWDxRutxfxR4X1hty/0cb2tEJY5XQmbekFd
 aUk3VOP19fmF/rfCxwDlXHAGzsrBiNhlItxw8A4dRqm+wC69xxzsk5tlVxUgWw7FGhYM=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5SP-000000002hz-2c9w for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:20:55 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so11662235e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793200847; x=1793805647; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/zLQ8kZKV/OKXzubeWYXVfQSpCEEpAWGinAw3ZN4BoM=;
 b=SKkzHGwjNMTSZ767/JarjGuzTJeYvnPaCPx4e5KT6qLD2/GVWu0sHgnSjGxZSWmtDE
 AwRHRAH0I05nRPOHnkt9jClgZeNN90GWGkNUsVKoSZh6Wwby5QyuJaVIP3OLgaDL/ZeG
 /D8OYwpcgIbnmTtKduCQ3gFGfpWhoyvOBTHrE4yFMMp+lTVvYoM5imkOWI8k4ac1DMrM
 QwGV06fomPFnPwstJzCSQxNyPk6aBl727kYWwv/0HeD4O7ub38vR0qiC0C5K0SPljU4I
 R0Qb9HFk6beG8czMO74awlPgGgNT6zlM697hplpeWUkQBhMQ4Y92s05rTBAnW5V5HfWY
 gq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793200847; x=1793805647;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/zLQ8kZKV/OKXzubeWYXVfQSpCEEpAWGinAw3ZN4BoM=;
 b=ZzL6/UQEXBM19qqE7fDFYs7ydF+wHtFIs9vq+sbadk2pcMsWifgeOHZEhKDZzPnVUi
 d/6l7FnYbGQV936a0u60mj57bH0J2J3dibVclISNu1zyr6e7jzErWr+RHgdR5dI+q3Y1
 d0ic3WmR/WUYxyEwvFftZcnZnioKrkF7kEQc0FmX+s9NoorBm9V62d/QCPYlEGpbFwdx
 P/jjsTSTtG92BPrNBF4/w7uHd6JmZhoys2eQn9T89S2NJC5VGJ96S30wIGXVHpH+QikA
 jpPvKmsbWhgCR5XK2SatJ75cN0qT/s3JMkKfcXhFxywSXbGV1PE2wmZ0m+a1UShMrO3g
 Lv2w==
X-Gm-Message-State: AFq9FYLP4Smt4uHlUYF1M2kq9lnLQrn7joABEOCbEKei9h5h/R4Lzuqe
 2nVdwRzy+ySRjuNpKN6W24bFeqTpS8hnm1mbhKVfeWIJ1XgCn2+zgNv82OlzB83ZX7FzHQQ6lcj
 xxv+fIEmVSNBuqFg1Mcpr+UTBOLsjxStQYH7T2f4w2jMYJghPIMF3+bUHl+7h/pV5RpG8
X-Gm-Gg: AYBFou1GI1FT4AvheqtzwpOC5xgtSXV1LXm8k4ij3dcIwICdrNlTrNiFxJkAS56v7Zk
 nYtqsf6ZpZdX9J7aUpQpck6i2H2EzVmZTTCZ17hT/rZv0gSrnN/avJhkz12s21wgTh0O+RW2izJ
 3BbH8YsSxFNTU66xReUTN8stebDJwT2j8qH+TM8EbfqsuWUGryvM4w6X505azkn7MYjWBBwx6wm
 sum9r0YNblgNccfknu+A6B2GIxgpBLI4hauFQS5Rd9nzl6s3goXpCIUEc8bt+SrxQzAGTVlKhgZ
 YACjuVG/WdoIe6+diOUTrQMFwuKCeW9ZcxEktoXAJkhF76cv7g2F/1D01+zcTRKwoQeIyx3FVNI
 vEt/X68biDFSJ6wYqf4s3u8Bo/ke5Q7qczn3UoMAYnpiQNMhi0NxreNBm3hPvRLozJ2tUU8jtvm
 TeLyg6mui3I+OLS2onUINamUCfGM39vhENTQX9AtXaGFIMElSC6LK2UsYq06CfT59qwb2k1/8+D
 84VV4uEKinnEaeEivWxcCp5QJkvyxiY90gqicHfqGnPN4NRYOFOGdj0QPdEV3khE3tSlchUaKI4
 lzbIdwSunrsUZk5naEU9N1ybi5LWW4WfS/Fw5x/K3AVt4VwlkUYle/NI9ENSEqCDhZlUf4sSFEL
 5yKho5dIprKSJMw11WgABxA4shz/E4CaoxzmRSiG3TiR/xVDv4yQEqN5oD1B17kcpNU3V7aHKJV
 fZ7/PXHdfiiy926z6a8k1kFG58Z6lH3Vy+G6C6
X-Received: by 2002:a05:600c:1c17:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4a965dd3247mr61350155e9.6.1793200846743; 
 Wed, 28 Oct 2026 08:20:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96989ab11sm32567695e9.1.2026.10.28.08.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:20:46 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 15:20:44 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d
X-Gerrit-Change-Number: 2048
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2048?usp=email>
X-Gerrit-Commit: b81e08f05de7470cde113f6d1bf0f3822b43429e
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 15:20:44 +0000
In-Reply-To: <gerrit.1793094393000.Ie3384ba46347801a6dea11b97cdf9edc17632c4d@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ie3384ba46347801a6dea11b97cdf9edc17632c4d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkllMzM4NGJhNDYzNDc4MDFhNmRlYTExYjk3Y2RmOWVkYzE3NjMyYzRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ebf6b1efd1f2168b9084a65dacb0f389fab872f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5SP-000000002hz-2c9w
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: remove
 m->pending
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
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5707900412691370323=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5707900412691370323==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2XRDs4C3RYY="; charset=UTF-8

--2XRDs4C3RYY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gianmarco De Gregori=2E

Arne Schwabe=
 has posted comments on this change by Gianmarco De Gregori=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demail )

Change subject: multi:=
 remove m->pending
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2048?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d
Gerrit-Change-N=
umber: 2048
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarc=
o@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Commen=
t-Date: Wed, 28 Oct 2026 15:20:44 +0000
Gerrit-HasComments: No
Gerrit-Has-L=
abels: Yes

--2XRDs4C3RYY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gianmarco De Gregori=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by Gianmarco De Gregori=2E</p><p>Patch set 1:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demail">change=
 2048</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2048 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco =
De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 15:20:44 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--2XRDs4C3RYY=--


--===============5707900412691370323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5707900412691370323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5707900412691370323==--

