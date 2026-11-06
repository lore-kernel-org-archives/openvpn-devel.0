Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0F606D803
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dh141vg2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bc/wcNcm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iABkhFaO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PDProkJv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=e/UFU/iaAFBoWO+U/q+TYRWKKrMLA/PZssBGOTnalF8=; b=dh141vg2MzAJVoV9muzOVWAoXC
	ce0JkKxo0ef0Dxdlw14jMrBtsvMudBhmD0CqJn7AauwcYm91AzmchRkA1iGRsyr4wfxtbQkDKklF5
	Xg7g3WkvZvubyROh0nx2A+VnVYwtp6W8Mi0FPjefasaOZ58sJUb0CGuPdnf0qkYsOZV0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPLz0-000000001hr-3H8y;
	Fri, 06 Nov 2026 15:36:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPLyy-000000001ha-1LGX
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 15:36:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=12TKcQz78JgNdXs0CVJcXolEdbJXlp5Vt3G2vE+GfuA=; b=bc/wcNcmzlU5//bmV4rgwXPZxA
 t40umL8fH2BIqfOjXrMpQ22dDc5xy1U2nMpaH2ei15Z5Uvq59Uzg5nmtwLTmb9/j/wsyEa5W7TDfT
 DaiLwK1PosvnodMfDLHpQPPButSNdT69lPeHg8+4y5HGV4yPYT8w1T+VmD5s2ZBcwEDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=12TKcQz78JgNdXs0CVJcXolEdbJXlp5Vt3G2vE+GfuA=; b=iABkhFaONEhTv+VBakqH8fVDzG
 vFETA0K7y8Ek6RxDG5NL3eYkpBXJnO8cteF68pYvpff74WZ0pZ5gA31pgxostVjp0wUghCP2vzvmw
 AemsDBI0hd94OT1kJtKUZM9tdyFnM36J8ZbQrnWcFNsY3qk2EiEUDGRXrLB5l9jAwvZA=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPLyw-000000006Lu-3qTs for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 15:36:00 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so793026f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 07:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793979352; x=1794584152; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=12TKcQz78JgNdXs0CVJcXolEdbJXlp5Vt3G2vE+GfuA=;
 b=PDProkJvYuRxcRROXxqmCOHkBgw6mzPPYyRNnwcHAGIAcFbFz5xP3A6W0qLJcq7uCz
 PBNBBaJ1EkOeOCtOS1+jt8qGKvYEAg/VXGNK0AyASbkljEf5R6miSRiqeeEuicqJBDss
 csxdoWYNCMgQo8uoJqOnVBkfsVuHo6b5C1j4gQbBb4FCL1LvW2kljtlv0N4kATsBCFMq
 7ZONRE8x5cViBhiECtN179Vq9OKc1s33cgb1dBuwdRczHOdRhBQVotGNIAY88Df3/gq+
 37UdItzmwI0j8WVdLXGrnpyoRabh6up46jOb++NgSASpkPIz/ckEuvTOu7h76dmUJBEn
 t4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793979352; x=1794584152;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=12TKcQz78JgNdXs0CVJcXolEdbJXlp5Vt3G2vE+GfuA=;
 b=G9L/HLa0wi3tkIlWvAV6ghsUeoJ3w9rR8kZRjR3GAzBU7ksGv/iVcVyBAfhYZJFykA
 EmjP+MUTPoRgTZHRZTlk2qA+FZnVw49xxgPrZQGEhd1iDwnJo5Eg3IXV3p0f7PY3YexY
 9BBCKtBQ3tuIa3rwszweDj8d7m85yAdE+e/ytz5k9A7BCdmRJsWGyDAJMn9PwqnVwgwr
 fGmhlDQSQ3cGd9c5GWNgeLq8MtbZQDKOxqUUNlrsUYNcKREYFN0FNP0VKb1vX63cD5kL
 5KjfUtCKm8cDAMY3oUolMFR5GMbyOnu8txN9dI5ibYNGFUJgmXyatO+SUBbzr96tKG95
 4N5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGHyi2PWKVTZe4QJdFmmMgH7y8edlU6c5vKIKD5TFR/Kr8Dg0JMYe9hvE9I/HynqAg+lQiGBnBj8cYiDRig@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9MBV6+ie0W1AruO+7V3MWFvU8qPDYnPeEhDhhSxtmPdum9j6HI
 lPawvc1k6pPcpU1KaOAQAo5HAspoOXMp40fWdNgO8mfjeu0PdQnvCvwuoKmwP2lLsnQQUlbZAtR
 +T70vbOaaT8ynOBKoFocQuC3DT4SDPYCA4eQGSLsq/YbRomWjqkqutaCWEjqt1n+6+7aLJgGu1e
 q4KmWSnA==
X-Gm-Gg: AYBFou0ZMZXH9j+l2RF2GP3guO6d2kXbWbSiIRP8wuPRF5MjcW5BFxCHHe3pClPfnkV
 PDmBs4ZqqkqXa+cEAj1rLFg02CfSSrfQ1UeMDs6bdjtgQoDPvXYY1XgvCAR7COG2RPueldsT2Zu
 3BqWkkfhSO+0SmyOZ/RzNUgDLfN5NlnU1VrwPHRCL4rhfAEpVsQh64DAZ4A8iHQy6/hP+eq/z8S
 GIvP95UYSOhTfUsZzJ/4upVfOPGXCEK/Ui5UyT69N2/1yYUQobfwLI+CTvTFFihPUiaiHKEpuA7
 KBYlpot6C1s1Q5kS62m85sK0V1KpaoZ5+piX2WKP9BeqVPJV816rjf8JnPGx87xLRZx3aUOiWFs
 aSmi56IHwBLBDI4uRRg+uTS5pvL8+5nxiTTeI6lBSzwhpIBy5AVvw7e2D+fRfAclvCBIvInfhPJ
 GX9u4E4epf2GEG5g/bNmCuHgYhxDQUMi0K7LRNY7zjL/X6Ud+rpRliNHxhuPPZKo1R12ZZEyu1q
 9aMzQ33CBFHwn2MgmKnAe92w08Wg5iOVPjAcLm2N3n4RgINWrwztucmjjjja+pVeSNNFMeeSYqW
 Vte3dAaLQWKbXp1ylR/SdaivYzefkpvtDRkKGkR/e7K7IUt1fbuveRwTIGn2LcX00EoAJpgYpbQ
 MUekzIKCIoBGUiaPR14LSTUCquEPjBJatBGepFN6mFGN8sHXP1YETGotUQ1bHwkWVn4bmPjVX8s
 e/mvUuE2qze9yBF1o3nvgltaNk/XYZXC/cARs=
X-Received: by 2002:a05:6000:1861:b0:493:803e:800f with SMTP id
 ffacd0b85a97d-493803e802cmr2327899f8f.29.1793979352147; 
 Fri, 06 Nov 2026 07:35:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d72335e3sm4253383f8f.31.2026.11.06.07.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 07:35:51 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 15:35:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926
X-Gerrit-Change-Number: 2144
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2144?usp=email>
X-Gerrit-Commit: 746f40f2de8f58b38c0c5ea1793a26013cc3081e
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 15:35:49 +0000
In-Reply-To: <gerrit.1793955802000.Ib7b9f2994ca828ea699bc6e5b08193dd30965926@gerrit.openvpn.net>
References: <gerrit.1793955802000.Ib7b9f2994ca828ea699bc6e5b08193dd30965926@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1ODAyMDAwLkliN2I5ZjI5OTRjYTgyOGVhNjk5YmM2ZTViMDgxOTNkZDMwOTY1OTI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <56f415cf5e3d6bcb8bf21459d1e7d94ab0cdc27c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPLyw-000000006Lu-3qTs
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: close
 the NRPT base key in HandleDNSConfigNrptMessage()
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
Content-Type: multipart/mixed; boundary="===============1751165020460153092=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1751165020460153092==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KIEIyYIVSB8="; charset=UTF-8

--KIEIyYIVSB8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?usp=3Demail )

Cha=
nge subject: openvpnserv: close the NRPT base key in HandleDNSConfigNrptMes=
sage()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2144?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926
Gerrit-Change-Number: 2144
=
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Comment-Date: Fri, 06 Nov 2026 15:35:49 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--KIEIyYIVSB8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?=
usp=3Demail">change 2144</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2144?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2144 </div>
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
"display:none"> Gerrit-Comment-Date: Fri, 06 Nov 2026 15:35:49 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--KIEIyYIVSB8=--


--===============1751165020460153092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1751165020460153092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1751165020460153092==--

