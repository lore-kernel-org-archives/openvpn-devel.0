Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA0606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nOs90lvh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VaC2Tz7S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L0yDrcBo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IPValhLN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pD8zfhM4qIid2bDwUWJQWt6osFpbwDFVPYv45q4jBwU=; b=nOs90lvhNPYNjDI59p21YaiPrx
	ie5JiZiUmf+L117TaGPQ7ZH6ieja9Y7yNXnnigU3t4bwsgrG6ssTsMab62BRSpoM9sLgbdnb9iBE0
	EjfTjMfY8DfcWITO+ATrOJ98Vxkw7v4gjyyh/auwA+PPKp3Cp5NRtpSkn4dFdtV0rYfM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQnBJ-000000004kT-2SBo;
	Tue, 10 Nov 2026 14:50:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQnBI-000000004kM-1UhN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kZSrVjsCgYlb5rtM0ckL5dtgMhjE13QiJoDm7pVdBAU=; b=VaC2Tz7SWI03N1mH7yGVnj9zUB
 MQnYmsjxiY2VeBmbs8ipbs5vb/BZBKlJVjyX8fF+nDL+DIDC6sNHXcQEBdu1ZjAji9O1S3D/nSfno
 /jHI30P0U8avOEIO+Tu5Ni2Pf4TRs5FNWZqItg8Sc2SLThhwqn31xwIxQGrhjSAcnOlw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kZSrVjsCgYlb5rtM0ckL5dtgMhjE13QiJoDm7pVdBAU=; b=L0yDrcBoCO2DNL7Y/OzcJFfVDQ
 oKihUGMclSRrMrpGxs2ZehuXFclf8F8COJ0yT6r3SPI8gTtTV9IYwVEmAGGUvNE2RP1+w1qXOv95x
 zosMLgJjnXt+uia5buc7r1pJjgAkc3nTmz4NPN1fioUkAWZ9YEQ7UO0Is22bHzKSsjEI=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQnBG-000000000ft-3Fqn for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:50:40 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4919a880834so1318704f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794322232; x=1794927032; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kZSrVjsCgYlb5rtM0ckL5dtgMhjE13QiJoDm7pVdBAU=;
 b=IPValhLNUctuWj1vlxNV0pD8Ma5eECJM+lf8aakU/007LDy/5JA0QfWbl5GUnII2m4
 iVWyFYRRDyEO0XHsdLMxHT75W+m0jSFja9PzERVNU/WquVwE9W3jN46d12RF00ztiQp2
 CME5UMvPWspzvkh81jRId4BGiR4Nxg5jBxjiTGgHY4Zc8PCnCRM4pX14XrQgszuaGiWY
 nuBiasbe9WPTpFy74aTZn3ZomOElq2ZPi5T8o/X8tfVtpNPo9YzhMrlIJpobGEDpz6VB
 PxUxfx6fvdLmpqnAmktt8UWbQf3FGrSRTmPmPDKc0Zn67R5mddOitvUtuSfQoAv9XZlK
 gxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322232; x=1794927032;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kZSrVjsCgYlb5rtM0ckL5dtgMhjE13QiJoDm7pVdBAU=;
 b=RESRkos+EpoNfAryZcDgBKMBSYVlJnaRSuwJ1jjCdM4Av20k/UZ2BywHS3PFfa+HFB
 wgwrsPYvOet1IM5EkkdYJ8eqZGVERVMJmy81S2KTZq3tAOIZ5PyV/4i0roKKbEClb1m8
 WMVSMqMNIH6Z2ckEwrv1YY7u/QvDEkq76Xcy3gEiwNdn47Hpjj9BPj2roZ0SoyG5zNIg
 OIndD+i/TzI1RQtkaZ02mCflf8voLi8qYOUZ6KtT26KNI/z0rkyOEzK22cKGXB6lHXa0
 GWlONSMQjLXo89EflFjPeG0cntlb6hs/aMhMHxygPg0y/kFR4bMu0UkKQGk1Uj/MFmpi
 9Djw==
X-Forwarded-Encrypted: i=1;
 AL+hErGSIb7+L53VgEX+2r+cB3g+TUs2eQuay75wU0VsKvzcYdHjB/gzEAW98sLN9FsCULt/dKqtqUhWU5F9Amae@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/G4AF0k8FRioT3U8HIRKXyD+M/FDfjHF+IOkatWeexTIUROFnR
 I099T6K030dFBPouu06bZV6G6rzVLAvqQGLSNRfFqfaX227XDVzj0nSjOM2h+L6iK1F1skWzHcm
 TS2rBLETqZ9AdlRlbsj+ASNkIgNFrk6hZKDNQ+flUsC2n3yZ+FS/OlKhA9ZD6uZNq9ePs/RoN4j
 Dk6gejPQ==
X-Gm-Gg: AYBFou1IK8iRbPWR8FmI1cvB00Rr9OxAG213M485fCcp74LFsqxoljGrdwAv7SRWLZI
 6IjiZj7Yo7YzgvC8rdrnLvrBVSNBxybAGN908ADcKBupvn7OYZwO+KM6GymsIDWCOwqhwIyOiXP
 Uxjau/qEHV2EezuY9ZXdQJQQRRzwiEUtxCadtFtmqY5GekfCLtQ+7Ambq9/vI1xPFSfvgKIzTB/
 QqniydxYE99PDtK2XhEeRGwWnQIn/7Sm7KJ1FHgbIkYwchf2zwiw/zQq8//SNW5y+6SDW9uNVx8
 sRLLCZooUSgYvANQ9tCBvFm5uXX7N4/AWQd3S+1gZvR2xnsCireIDpCHqJS8xF5JldG9wknZXu9
 /LjBika8cZdiBxzJDysRp2FMKehT0c6V0snxdW3U+TEltrb9s2uo9cSKq/RNxnBsjut/EQwdaBH
 hNbmFOSpX/ZgIF4GXTH3EChYtbGxFGoup1YaYE7ne/cd1opdgrlwb5Wk9z0qQ5XcCCXaHOccXUD
 7wal7sbLPPkxH5mTQqX5dq3S60gGWNGsimx4ExhGBkM5VD5ANyOPUywrP4zM0Uu5S4dDWgCRx1M
 tB3W8eE5A+vwagIIHZ305hVy06trv3ks4gr77nBp2VKujQXttecdHryZI0FGJxv9y8tp4YgIGPX
 uZGM8ZH6MqHin5QIpPrs97ODTrfXFvSgo2hChHzvmPA1lik92E2vFAMqc9Gjl4Vw0kgZizFdYMB
 b3DYcXf/eyovgs70s=
X-Received: by 2002:a5d:5c05:0:b0:48e:932:aefa with SMTP id
 ffacd0b85a97d-4982efd4e12mr6162515f8f.26.1794322231734; 
 Tue, 10 Nov 2026 06:50:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498362eb14asm5135846f8f.34.2026.11.10.06.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:50:31 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 14:50:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5a827f4c6d169420504a48e13ee6eb28053dbc4c
X-Gerrit-Change-Number: 2167
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2167?usp=email>
X-Gerrit-Commit: 41bde54e60b80823124880697168fc4844d3523e
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 14:50:30 +0000
In-Reply-To: <gerrit.1794320197000.I5a827f4c6d169420504a48e13ee6eb28053dbc4c@gerrit.openvpn.net>
References: <gerrit.1794320197000.I5a827f4c6d169420504a48e13ee6eb28053dbc4c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzIwMTk3MDAwLkk1YTgyN2Y0YzZkMTY5NDIwNTA0YTQ4ZTEzZWU2ZWIyODA1M2RiYzRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2072fe8dd0a8d1da649355ca5306c1f0ed6f91c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQnBG-000000000ft-3Fqn
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: drop dead
 code in inherit_context_child()
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
Content-Type: multipart/mixed; boundary="===============4486614461598518996=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4486614461598518996==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hoEaGtUJ8Tk="; charset=UTF-8

--hoEaGtUJ8Tk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3Demail )

Cha=
nge subject: init: drop dead code in inherit_context_child()
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a827f4c6d1694=
20504a48e13ee6eb28053dbc4c
Gerrit-Change-Number: 2167
Gerrit-PatchSet: 1
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Tue, 10 Nov 2026 14:50:30 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--hoEaGtUJ8Tk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?=
usp=3Demail">change 2167</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2167?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I5a827f4c6d169420504a48e13ee6eb28053dbc4c </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2167 </div>
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
"display:none"> Gerrit-Comment-Date: Tue, 10 Nov 2026 14:50:30 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--hoEaGtUJ8Tk=--


--===============4486614461598518996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4486614461598518996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4486614461598518996==--

