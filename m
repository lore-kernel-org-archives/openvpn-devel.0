Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D4606A329
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OSra9U0u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IXGZ8wSm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k9WuIYiv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ENgfzgei
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fCcaoE+ZQtZhC/bkIbzqCDxobnHGedc90LmoPcmNLUM=; b=OSra9U0umVF50GL/9AVryu4iPF
	51sRYchq0HsYQwBndAk4jtoKCNCOGU9J0nPwwD11lA1MlYu/wsT5+U8i7lQdZyncHZcidHtYbcDg9
	xtPRqRIdU+heRoBguYCKjvPGve4vVnItjJG7MVCjWnbfsDSHQi0xc4vV78JjyABRH92w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSJBA-000000007PX-3Ihy;
	Sat, 14 Nov 2026 19:12:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSJB9-000000007PR-2wv2
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 19:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b/pf63O1zsuogCaABblg3XE6xI7miGlB9fcomQxvGQQ=; b=IXGZ8wSmTLWZA3kqdozhGiYyKn
 E2Xq4z/pR4Qn+i76TcNsNn77Mj+C5WJexqHNLemTg/56g0xzmQ9dG1gE9LPrbSOKf4yAW3qtHabXc
 JGYOPXcrZuI5C7ORs59o3Pjk59pVIUPQIGz9vAZmp7vSiSIVfmuOmT5zGw1O+Dpg1SFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b/pf63O1zsuogCaABblg3XE6xI7miGlB9fcomQxvGQQ=; b=k9WuIYivVGDU1u6kvZiHS5JNDE
 KLVmMD7+eDDBNP4s9QI1MobNXx6ytSauYBT183ZjcTHtrCjBrgpmgiLXIih2ToeFooMjRXlak6oNS
 M8z5wFlNb4s1jOG0Xnf8aOIfiNNSj686ZnfkwIbemU2uXOEzEKMxaBPycCwtYSCYHc+Y=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSJB8-0000000040l-2wEd for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 19:12:47 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so947603f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 11:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794683560; x=1795288360; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b/pf63O1zsuogCaABblg3XE6xI7miGlB9fcomQxvGQQ=;
 b=ENgfzgeinPFFpWJSHHV51SshxMjWUHzEh9g3irAd+//KyYKznGonaE2CKB6MQrypWq
 sI7cUSZyXM52TkFLOfMBa3wt7xWtGlmjPrrY8PjqbxpTcNQBPTsd+4EwBslorc1ab0Sb
 7y8349nujaClYgzIYRbXRVF92XTPXn9ZO1sNvpM+a1sCG3UVADEW9ECnnEL/X6QupGDr
 /SPIY7jPtdq26owFxnbTbsqIyXIcvPPvc7yLrvyt4wcbAXi3SfnXw211mSMHhMrrDBLW
 zs3FRb3Jcen48o7NVQDwAE1xIx8EIbroyRkYrG8u4tRPHncbi0V/H8E3ToYHntV8J05g
 LYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794683560; x=1795288360;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b/pf63O1zsuogCaABblg3XE6xI7miGlB9fcomQxvGQQ=;
 b=cxyeHeE6gATBi3kTHC4fNVU4RxZXtS73BPxt1cH6KDOd9XU8z1m6Q3vGb3Womzg9P/
 hRRxdzQXKDy5ul6MpE1DK1olmYfxVG8AeB4igOTmP/La7SGnhIHCdEq02Ol3PRhNU4Vo
 970nCij5Jw49ytDNfMPKneBV4+unY1QXTS+Y1FQBLIlLAGh/mHrp62E+E8BoiacRx3iZ
 IzuicDtvI0SkPSWtnq0bLaWUnECeFG6iE7rA5H4Q7QwyUiPQUmpdHRBY8HG6ifDRWF/2
 jWB4EKyOpVfNOgO53uzkD40wTok68iRpkEpw8akkZpeMdPIzgkAPBV+XQ8ohuoEzsmSs
 8Z9Q==
X-Gm-Message-State: APuU4Z9CxG7MkQpYXaMkAV1hzAqr93YCdxfbDxUKCxNg73qL74BedAwn
 EYoXyyoL3CC1AWW8IJ9/PQnzRKWugxpIC4v3QOepYuXE5bDA/fVmMVlCw+JC5zhtQ/e6g+baXVE
 TCupM7IBryRdb28o+thfSNvQ7trF5q/NvEZY2B+s0JnhARU8qVDHtzUGtfzMtCJTCqyliZVF8JY
 gGDW4Afg==
X-Gm-Gg: AYBFou0S5ihlRnDMcxgloxgHNvDRIHNLhGuy4FJXY2SlD7bxZV9dHsB/6nidFADLZfM
 ZGNsZILTaV0XPM0icx2T4xrWdoVY5BMZBw4aCkRmy6bFLQts6PwVbSSOeK6gg7+u0QSahKNlfHn
 j2nuFaWnAmJkvbRsjEn8LPmaH5Q/6Xo9UYmlV6qhRln2fSAOc/wPZ/frRoAHc5L7TKgPL2VnPLW
 Gud1+WPNjdmNthsi1jHrgYnyzntht/7QUajQXnbgmUB7uedHH3qS0UxY+LuL13MOY+hg+i2ZuLG
 DZrDHyFFZhd7PiNFNXJ4YHQ8d21gF/FATYe2jjQDbLFs/zHhSi5j+JQ34YirfQfMVtZa+DHbShl
 qvciBwuK71HMYmJfd7u8u1tFP58pFjPq3U142etoohtsaNbuxvUBLPAE4VseLIV+8Eqr+6TKLn1
 5M4L1548ufc5Nw2CrccJ9NSSTy6/LOUaFO9pp1BMokka6GZhlaG8JrWvTfanv347q31h55crwbA
 p8x5Zw5EDvKKBLCttxBOoF0Kr1KA6Gtje29L56wFL9jy9ZhiJeWaF/e2ixB2l44/EXwU30xlago
 tMlwhDPLaOgC/nJJt5r0hLcuB5JjiPzRnx73WHXY/+CteecR8QT/Dg88U3oTmaMru4mJvMYXm+w
 RMXjU6vEQC3vzji5gnapboxyoEtFQnNtwHiYBOysX8bnV0TZ0W8mXCBoQ1eyyi9iNKygsxzubb/
 ZTtUy5IlgwzZ+V7w4=
X-Received: by 2002:a05:600c:3115:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4bb55aa4935mr131592295e9.32.1794683558919; 
 Sat, 14 Nov 2026 11:12:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c77393700sm11398118f8f.18.2026.11.14.11.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 11:12:38 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 19:12:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d
X-Gerrit-Change-Number: 2126
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2126?usp=email>
X-Gerrit-Commit: af0a34c160f03ea97af19b58ec16fa4b6e8f6116
X-Gerrit-Comment-Date: Sat, 14 Nov 2026 19:12:36 +0000
In-Reply-To: <gerrit.1793781037000.I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d@gerrit.openvpn.net>
References: <gerrit.1793781037000.I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgxMDM3MDAwLkkwZjhlYTRmYTU3MmY4NGU2ZGNjOWIwODA2YzIzOTc3YzY0ZWE2NDVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <faef555595036fc6d2fe3c51e53844a9de69903b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSJB8-0000000040l-2wEd
Subject: [Openvpn-devel] [M] Change in openvpn[master]: pool: reuse
 handle-to-address helpers in ifconfig_pool_acquire()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5010684390066704761=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5010684390066704761==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GNRyJW4w5xM="; charset=UTF-8

--GNRyJW4w5xM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Antonio Quar=
tulli has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail )

Change subject: p=
ool: reuse handle-to-address helpers in ifconfig_pool_acquire()
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f8ea4fa572=
f84e6dcc9b0806c23977c64ea645d
Gerrit-Change-Number: 2126
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Comment-Date: Sat, 14 Nov 2026 19:12:36 +0000
Gerrit-HasComments: N=
o
Gerrit-Has-Labels: Yes

--GNRyJW4w5xM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Antonio Quartulli has=
 posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set =
1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail">View Chan=
ge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail">c=
hange 2126</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2126 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 14 Nov 2026=
 19:12:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--GNRyJW4w5xM=--


--===============5010684390066704761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5010684390066704761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5010684390066704761==--

