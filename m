Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F360A3803
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eTvzDFH4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WZ9XAmum;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Wy4Qx7iS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gBwmP4Yd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ILNyLdOAAlYhDMGl22S+5yQ+3I1Bl/x/RxnbYYsaWj0=; b=eTvzDFH4bmrOxW+U+phA3iobr8
	DzPWgQo8asU1OmpzrfBhwiHd7dLL2s5EK4Qev/f9sqJNHPTUvIF8rNJ0XBXUQyGf3bk+Bgt+YOuQk
	zf/vZnAPUJgoGh1kwEt3mtDn2MNEndTz86eCblxOdbu7v7SjlAvjTqh6JRZecTgTzFLQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU4wl-000000007sy-1Lja;
	Thu, 19 Nov 2026 16:25:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU4wk-000000007so-08PZ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HynAwhE/D2iO0aCNBKKvIo0iOiTLFVh6+J7JDvWiho8=; b=WZ9XAmumqRu/ky1o2GBtmdK6yn
 HrikdpbmegyUCMODBZgmpXT4W8BAJKoQff1RBCA2WaAM+euNl5G4Fz6nqCx8cXP7HIlYaeby2r437
 bGblOqyTBXevLvCuigDvT3KgWakWLaAPYCChsMuB1lWUgkT0ZZHYI8p9DIzPriDXtwsY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HynAwhE/D2iO0aCNBKKvIo0iOiTLFVh6+J7JDvWiho8=; b=Wy4Qx7iSfX45KNEEJYKe7saNv3
 X2z5Z523r/szTbR5be2RZfNpLFsHOR0iNapCvD1SybTjjfptxaYoGLyrivldlEzzMXiLhD210whJ4
 yR5xmkIcIU6OLqQTW06ISev8tL39ebtu3cvLMxbLa2wOot2/xBbrKsXP174GeKII3980=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU4wi-0000000067p-2TOl for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:25:13 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-49a92144733so1219832f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795105506; x=1795710306; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HynAwhE/D2iO0aCNBKKvIo0iOiTLFVh6+J7JDvWiho8=;
 b=gBwmP4YduoPp3i8U++p+h5t5DW3Q0nuRt+ul5xALwZW6j413hcPfLp9CGmFy24ZQYR
 7QhEFn7GRLKpeKvzviTGt+O66yRsqEjrNEjgxARfy18vbgqxxIJQmoCYMoGQzfFkUK9W
 IOF/RaLYkhNxXNrE2iDkb8Tnln36NLA/Sn+7lILqmx+l4cJtUtVJuvaVe1ekrn9DTxVa
 qibxxQDuCsYOptLXGNcO8Dua1OPz/k524jlkVgbEWRnMLyXKnQFbhiQz1KXjdjWKQ+sk
 6hA2EmGeJvA6e5w6NoCiCM5ZQCNrlkc/XAWT7P0OKl5bcOBcbSQGTSzC18QDeOIrAHWY
 +emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795105506; x=1795710306;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HynAwhE/D2iO0aCNBKKvIo0iOiTLFVh6+J7JDvWiho8=;
 b=AtdgfraQbeG4gCMljf3vx4psGHgtM0rnrUPYif2ZirrKyNnpVzpiE4Rje7XaEBOGOO
 BODpLvMs8UwpxC6MzGYsmQty7xfOOQLsrYIA8s6StyeaAyncUCKVhyu/7pT9kaU410RP
 Xj2nD0PCnJ24BWqp3s8pLIbHwfLo7KEW3PMATJIiJv29OYoMeKDtqLMxOKHLDZVx1Fi/
 1FP3Sp2VxTqG7o7NOEwCW4NhoTES70mZ8ek1iImYjc6xiSDECRgt+OK/1N/vqDpXXX7z
 qLAuKWx9hPLXHzsM4E7CjryN9zNN0RJr4Z/8jqu1LCerPf+zedYIbI676f7kqw8/hItU
 wnXg==
X-Forwarded-Encrypted: i=1;
 AL+hErFuNl3DZas1mgxBHDWi7CbZmVGLI2pMO1zgB0Fhlix1aEHEtFj/M1mCphV5FGFFC4lVOPnrj8JAr11eK+z7@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8JHIouZMVdDEcC0ixW1CxyKFuT/BSl1hGrLdlA3M4n7Mfvt2WB
 I9HgRQ7aAP8Xu1lDXyqRRevEgvKRBKVTE16Kx7+cT9b3ekn7a0fCk4eHNutUNMlTk74HIgZPrNG
 5Sa2fgVB/b4hdpm7Yfl+ubZLT+4GoqSd8bGGC1h3+LW/RPCxkdYy3Ju9+vHeXoqeFkLTK
X-Gm-Gg: AZFdTZcKQNNSU7HV0AglkZG7k4gpKMWMtjad3cHxHRAFUeeKtHdNiKfL5ueq7kOoRZV
 42htwbqX5pUl+R32LWpvne5mNgAbr61Dwr18SY+n1pV4OpHdmbX2njlsMNI4LKBNKBYsTQHd4gK
 PDAqY40oWJMlmuzPtRgJh40AwDvQXKXtkAz/hT5RsBYHKgl4ZUHrtzekyHqGxm3UFIfOH8LQOUY
 o/fDYDKQFzRoE74lxG1BOQs38bQ2e8Ke32xWG6oHRhco8F9LIlgvw1cLgmwAYpDL33V98WVdg20
 zje4kVvARpTB/AJRMoe77uQnLXPwfJd0d6Wep1c5eOSbXzCa36z1n6a2vJ+ePszQlGEIUP/YTeg
 KQXnTx6kHbT0i64Z3HDsDqkmc3fy+FPgvLKo95UXjyQQ5LkZq9avu1WV5W8OwBvfxSKpy6momjn
 joYSMNO4eZPGLxtzMNd+zCMI1dqJuZSNKHJF90PPo0jnW84o7E+354AMxlTKOEpzBhnq7Dp02Am
 c3pZsjjCRCwnCS6n0oDsO+kG7YvLAEuM+PP4vHaYx0gHog+t9flI4/zxUXF8Zhb74hRGVEOidcn
 /t7ZYFvzq3tl/+OaiZdb1MXRsXR7fJZAwHmLFH8sy899g1nsON7A7nr9x4hxAxEoxwLlKAevlCR
 0+eD0V7lZ02u1elYW6m35p93ERuVJHN8/qRn4FoJQLmjgoJuKUbMrLj+/UitqGV4hUykJ9iWecl
 ckNwDTr+5XybpcMU8=
X-Received: by 2002:a05:6000:2910:b0:48d:f0e4:27a4 with SMTP id
 ffacd0b85a97d-4a63984c562mr14429336f8f.24.1795105505749; 
 Thu, 19 Nov 2026 08:25:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm531901f8f.8.2026.11.19.08.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:25:05 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 16:25:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: 36f8ddaeb2cd952fb137a9322d5340b47799c9ea
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 16:25:04 +0000
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec11bbea4da9e87db101ae704387983349812714-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xU4wi-0000000067p-2TOl
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dhcp: locate the UDP
 header via the IP header length
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
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2921499401337991827=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2921499401337991827==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="55037pRFNZo="; charset=UTF-8

--55037pRFNZo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov=2E

R=C4=83zvan Cojocaru has posted comments on this change by R=
=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?us=
p=3Demail )

Change subject: dhcp: locate the UDP header via the IP header =
length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2: -Code-Review


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2209?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
Gerrit-Change-Number: 2209
G=
errit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 19 Nov 2026 16:25:04 +=
0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--55037pRFNZo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan =
Cojocaru=2E</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: i=
nline-block; margin: 0 2px; padding: 4px;background-color: #ddd;">-Code-Rev=
iew</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209=
?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;=
"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2209?usp=3Demail">change 2209</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2209?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2209 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev S=
tipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Thu, 19 Nov 2026 16:25:04 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--55037pRFNZo=--


--===============2921499401337991827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2921499401337991827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2921499401337991827==--

