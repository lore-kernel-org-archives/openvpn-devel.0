Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C933DCA601D
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VzK0xkIfJcyIzkzKs5ZIlWL1ZFkDGpkEbNCkZs7+W4U=; b=OVj4mpkVod6D87X57m125vCm11
	vTTHYKMtVDFjLtqDf1P4V2m9DK/B6W0kIuCkXLj9cB8IkkTrkYCAPwBQk/nPc+zu042pSKr5W2SHH
	HL0oPaynBDAKwVQ57mbH8HjNkVSD1S5X0Bz2hobFPplUCy03HMzlCXi2F1htlKA3/d0I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFCAE-0002FD-C6;
	Fri, 09 Oct 2026 15:05:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFCAD-0002F6-B0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UzVpyFiNpMH3c7vurnuocD6WOVA4vEiAecHe6mxQ79c=; b=hhR5D7raa+zJWTQzllL/1DquIy
 ZF0uV1ir2FnKUWLgte0u01VODkmpMk0Kho0oU3Xqnw1ExDzCPniOR35hYjttWx7YcA2/qKoQWohG8
 PrK+Zstsy1tJLbRSUEeDGF2ykPmgbsb3HrZv6EzijWWn8bFiC2Uo9ZiCwihZfbcjnaLc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UzVpyFiNpMH3c7vurnuocD6WOVA4vEiAecHe6mxQ79c=; b=J
 SptKa2ZRxvSoImXZ5759MIB6UwrBtQAQ0dMJhkeVd2JRAu2PKTtriGJIl00ziZ9u0bRuNLmLtqlFJ
 MuDa08egXQaouvxlCx+cMYnT8zb2yG3D4L0rqnJygppQlszNTIPiCKrnGFJ8oCbCkuFzh8SyMrJxz
 ChSy14beSSt27osY=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFCAC-000207-KL for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:05:37 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48dc202a60eso32560f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791558330; x=1792163130; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UzVpyFiNpMH3c7vurnuocD6WOVA4vEiAecHe6mxQ79c=;
 b=FjO00KCy40ZHSvIJgyiJisNEL2h9z9sEx2+UZff4mA5GwBOn3JE9pPYQatDOp27SGF
 EQfpakyHbdyV8iTkeuum6r5cYtT+texpmgQy64zeCAulTfe663xJ/kml2FYXQoeqkcsp
 BJhGnGgEycFQiXDj9BTNmlTaWKzxjmsP27X0EdiVRsnEvUc4vJergbdufzCODSPa8yWc
 jpVQ4QWMnYdsw8HLHutsI9JKET0WcdE90l7X3kJFyUxfVrA0NnhYdM7nx7gsFDbk2NcE
 3d2qHPRhXEAgYYnBqcTIuiIgfGwV+OuSxlb3/5RY6JezRmYDjrKREe9D9Hyjmah9EboU
 7hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791558330; x=1792163130;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UzVpyFiNpMH3c7vurnuocD6WOVA4vEiAecHe6mxQ79c=;
 b=hJBycP4yeSbxG3NK+PPLtMiS3K9wuLgKL5jC+cdShNWUz4guoraJU+HK6XdvN4eO0X
 ehXm3jVrJfKNVIaOfkiOK3op0TxDQyC6nwa2HhNkD6jAhK78Ek3+VuCBtAZU98jXGyCv
 SPYr8qWxhhKpjtNZGIFZzJb8acryhy73sq7vH7J1Vwp+FppVVSGYaFbs2HWaJdXKDM1i
 CN892ILXui9GFchEiN1FDR2nn7ES4tx2V5RzsRWWOhmtJvm+Hif3fOtvkjnqFxTwnSGM
 4JXGPfLfUaodf0FMapttHpL5LToGEW3IFYjvJ2Fn/C138BVZ2fKJD87Z3vI0HBHKRQgt
 nlAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7eMVgL9Z+cmtI89Xu9HK1T06RZKNRmcTZhECO+UH0iAiyf7pZUtaMowR8/eLURIoMIVymE+AuiaTVQk1l@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIwXHmOjVNkWZnjMiNsXTs6iht45ESeLLMjigiykL/tWosWWwQ8
 e30NjIHdapSn+pNZSsr9FL0tUDz4X18FNmx3zA2qYfpkRkYeB2JnQ0JysoBpYunlf0t7bE+x2bz
 xuw3qJzw8vrpGOK0ELFmyZcfZXiIJ02QbDVG9jZS8DVWSNsNBCYjvP19wgOnrvt61jySjk5k4vR
 boupABNg==
X-Gm-Gg: AYBFou0qXHwuB/GjAW3Nw+ZggQrjiL62uAauqoErB2YVz+1L+c6DarSeEEptZ3ZUIvD
 XdPXSJhTqhXoNdgsyNtr1fNQ3N4e7dUgl97d/XPH+pNmkV/pYPu5e3uVtVwdx2k27Vt6pqjTHGo
 cE4L5lFeYMtCSZZsDqeBePxT671SYdQ6YogPHV5Zos75bqssMg3ctZEtX2GUIVrGo5bNe7N19nb
 4sRhl8iepDUN//Ktp+UkITrhfwI7oCJYQ7VMLZZC2xkgkjM1JOPzLGG5BpYcexcVzwCnrQQGAb3
 aN2LJRvtd+WEyt9E+Kfr+3AorLAZKlMTYWrkmevOyBh6Au5iOV39e8tz9uMgjaodJ3etYxgNSfE
 M0dcjBJTQGoi6S5gShmvsA6ny1H+vnvBHSkI70OMfPX05kUd1Bz8/Ym9fPAvFVw/1RysmXvby9Z
 jz6MMmhPa6oCPFBVLuBb0tQK+6SfhY4d7JtgZyqDn2/+Db2SMbEeHL3x+2otwWOnO/CBE488WI2
 ssiagZY/cIrUdQ7y4aMQT0T2MECw5nw8+QE04CcXq7EFfgt3VXqF9zIrEmpL6z92bP2DJHOL7Hw
 Izmd5I02hkaYL5UukrslJExRv0fDs7JAAoOzCHQr6MIKz0uKMwC0NJzvRCRO
X-Received: by 2002:a5d:5e86:0:b0:48a:f454:3d4 with SMTP id
 ffacd0b85a97d-48dbaceeecamr4218355f8f.53.1791558329810; 
 Fri, 09 Oct 2026 08:05:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e3545sm4344012f8f.17.2026.10.09.08.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 08:05:29 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 9 Oct 2026 15:05:28 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
X-Gerrit-Change-Number: 1882
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1882?usp=email>
X-Gerrit-Commit: 3cf7029e67253a95792cd3d320a1dad53ac4a8e7
X-Gerrit-Comment-Date: Fri, 9 Oct 2026 15:05:28 +0000
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3OTI4MzU3MDAwLkkwN2IzNzM4NTExNzVkODY1YWJkYjE1MTNmOTA2NTViM2ZhMzFkNWZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2440ad348d020393d2f6063148bc9ea45f2e9129-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFCAC-000207-KL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Check whether addresses are in "tentative" state
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1395325640362139676=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1395325640362139676==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lh71+0P5QLE="; charset=UTF-8

--Lh71+0P5QLE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering=2E

R=C4=83zvan Cojocaru has posted comments on this change by Fra=
nk Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3De=
mail )

Change subject: t_client=2Esh=2Ein: Check whether addresses are in =
"tentative" state
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1882?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
Gerrit-Change-Numb=
er: 1882
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Gert Do=
ering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-At=
tention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: F=
ri, 09 Oct 2026 15:05:28 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Ye=
s

--Lh71+0P5QLE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Frank Lichte=
nheld=2E</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inli=
ne-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Revi=
ew +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
82?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: =
0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1882?usp=3Demail">change 1882</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1882?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1882 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Fri, 09 Oct 2026 15:05:28 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--Lh71+0P5QLE=--


--===============1395325640362139676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1395325640362139676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1395325640362139676==--

