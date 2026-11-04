Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AF606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VkJE2m93;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hJOcAhFL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TJcSuRyt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=G0jPC1IE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Rdr6/GzD6K4UeMlBEvO3gYALDpIT6M2/2fN5CCoqj4I=; b=VkJE2m93/R/zIRKds6KbdhQtD+
	MyOTY1+7350D1KD5k78QUGonuvX7V0x/EtSeBXitzEGU+L8M53SieeDHqkGw2g3MInpvd/z3Urv+O
	tLa47G6tGLjajrNZBFUig+TC2v1rrJxOnEzg5l4ldODnZOZRbrOBR81B7sc5YK6pWs8Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYdB-000000004bH-1cOK;
	Wed, 04 Nov 2026 10:54:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOYd6-000000004b8-0PwD
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:54:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BOH1DQjmUJv6Qr4/OSPF5SMmMQDXo2ALyoXVnRM5llw=; b=hJOcAhFLVVy18NP6Wb9Cp6NZrG
 EVwN5WhFiJSmE6FR5csm3UNVtfBYKdsO+nM50r4rnZKXn4jHANPg8Al/cedZG4b35BqW67NZpQoP+
 mFhfx92k/nwmlYXJtSW6GniiF63Jl6/0qzshHT+3AU9O/w2pxube9CDMxwSBM/BLf7ks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BOH1DQjmUJv6Qr4/OSPF5SMmMQDXo2ALyoXVnRM5llw=; b=TJcSuRytgPQo/M7EE3bxqWtG3H
 VcYexM4uBSb/D87yIXkf1MRV9UBrrPcxUwzLxccDrThRS36+IDKIJ8Uamj2i6Gn6xJXHOISaXjT1M
 Ma+09rl2mOXNV4yhcEIP1qY5+be44T4Qnqu9JHTQrSKsrWwiIzxIsLWIzZDuw28Kve54=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOYd4-000000008Ls-09ur for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:54:07 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso4793755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 02:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793789639; x=1794394439; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BOH1DQjmUJv6Qr4/OSPF5SMmMQDXo2ALyoXVnRM5llw=;
 b=G0jPC1IEikXNFltyuCsJrdu1+exoC9jVaEfZGQGEiEQMSPrXGoCbm7g7mHzDuicyDH
 5hIGWGMmOgX93P5MiQup43+X6wU1xROd9UgJGxGnQ1QYJmxDVUWmGd9eNlKjw3hWBsZy
 I0yDkojsFsU/waRqdPvOK1/7+8fXSYlkCd8OJQXDz1AN2axp4kqyooqGVIxJwFNd+RTD
 Itrp7R7iJd9PAf64ifTPVRObhRUSbUudqC5RFzLMrIazn6MaZRnUWVFZEVnp/qP0+RYU
 zweNQ4S7lapzItTeEeFOtNvDpRlLfRlOUsZEL1H7gHxjiVvc8QjZxFM2q6KSNm8EVkip
 NiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789639; x=1794394439;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BOH1DQjmUJv6Qr4/OSPF5SMmMQDXo2ALyoXVnRM5llw=;
 b=w5gnxHFXIcH8tioKh2VyFuS/qD4iREgEF1YyzaVwKY0ePGL8B5locubwEt2Mn7W0Xj
 CmQqUD5JIp35LEyuqQmodzD0+No1slnmtePrDNBJkGMCLBg/JP2OEz6FuS3u8R/OUg80
 7IFu+FWrvhJZB416sEwDIJYOpgz/yumOGius5kJde8aMd303VWEEGtmAH3zVC5+Pioei
 oG5NjharjI1JTkkd2lW1hn09St4m3P1RZtHANAEWiftFQ4wBZyXYAtOH4gG1ayaNd6DZ
 gu98/yPT083Vw3tAW6KDKfsEbDLPQMq4LfvK50ELUsKK3npBBu7qIj7em3ewNoWsC+HK
 yOOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7tt8t7aCeXjiSD+emFYPq2FglCipLsJKgqc7WPr6DhBU4ZNU2DuOTVjEtl+QEi+g6a9YFeH0VxHKhjoCS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z//XiXmS01RqTB+91731gv4ParY/7EcBHTiXFBBTR6rt+tQgiAF
 oPtY81WyISfAZXyqREbIyhw5Ga/obVTPYmC023kayN2CeciQIQw3XDvtsSPV+ABSvYigiu9q6cC
 SGeZKZ/+1b5BlbqTAJM3FBAtaTUIcdi2rwYux87W5WpWtk+FUo11BJq10zX8rqACTBlfMNXtZYB
 ZkHy3s4g==
X-Gm-Gg: AYBFou3GOaKV8sM+i+OG3PTlDL3LkxQZnHqrgiaxLELbz0nyIhOLA3kiiEDpRNcolSf
 n7qRQX+RWwNfUnTZb1Duzyrz6pWZc7TN1qvtqlM/98wiXaI3sM9XTKRmcM1Ctv94o9xoXCuvp/A
 fvBvy2FT0xyy+vb6g2NrUcRv8FCIEG1NfM8vt4b8kPpZkiwn8QEgZnsXCeuoAQBy2f1KWx+hoAP
 yhxTvpYwbHZ8twD+zzbBzrQfVDWQL570lOptM9fkkvUNrmZeGwf87pIK76XKjCPrf86GVqBW8xi
 0V9lxlazzAbpNh8cobp7lMi0EMRHvXditWqwAgTN/fX4agqh6lkxuCWmKHBYM80K49k6YHvWdFB
 y2BNp0nhDAPJOHoN5E8EE/MYqlILvo9Pf3EfTwV1nDYXCKq6uE37gq+2mUYcNpTwdh/UTVe4W1I
 zk075rTAKZNrzTdaGj34kohANkiWrgAxGnHqkHUuYIVRw3c+jfkNuv/zDrbfkuexNd373/jMxxF
 FkFkLbsnHkQS3RYc3Y0pSykuDpEafJnYLMyj4s6Hac/r/iPralnu8wDr7QyegZlHGOQt8Q6yv7b
 cxMqJgTLTG1j+oc2QulkuHBhtqdAY4dOWXzEs3MHrik10eFDV7fva/ftTugToqzS7014aBxPaCG
 YqYr1s7nRO0OaREP7oIOkD4tCgHCYu8NI/uReMvhnelrlC11nNq6J+MNQzIYUurBDKR1MWUtCg3
 dTIBQEU5xTUnE6vA==
X-Received: by 2002:a05:600c:19d2:b0:4a4:4d57:8487 with SMTP id
 5b1f17b1804b1-4ac1737c51dmr348295085e9.5.1793789639253; 
 Wed, 04 Nov 2026 02:53:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43da9825bsm44346115e9.15.2026.11.04.02.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:53:58 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 10:53:57 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582
X-Gerrit-Change-Number: 2062
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2062?usp=email>
X-Gerrit-Commit: bf43addf953ddd0b8a22c69683114cf2e6ea5386
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 10:53:57 +0000
In-Reply-To: <gerrit.1793194671000.I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582@gerrit.openvpn.net>
References: <gerrit.1793194671000.I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkxMzNlOTM2OGY5ZGZhOWYxMGI0ZGY4ZTUwM2MzY2Y0MmYzYTZkNTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea994cb1cd67b8d50265d9171e1046e8d052b7e9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOYd4-000000008Ls-09ur
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: add an API to
 update peer virtual addresses on Linux
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5828370915251301698=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5828370915251301698==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rSzSZElQbAI="; charset=UTF-8

--rSzSZElQbAI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Demail )

Change subject: dc=
o: add an API to update peer virtual addresses on Linux
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I133e9368f9dfa9f10b=
4df8e503c3cf42f3a6d582
Gerrit-Change-Number: 2062
Gerrit-PatchSet: 1
Gerrit=
-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04=
 Nov 2026 10:53:57 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--rSzSZElQbAI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 1=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Demail">ch=
ange 2062</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2062 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Ba=
ffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Wed, 04 Nov 2026 10:53:57 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--rSzSZElQbAI=--


--===============5828370915251301698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5828370915251301698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5828370915251301698==--

