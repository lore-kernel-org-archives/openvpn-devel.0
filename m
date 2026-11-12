Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68546606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KXJ8n8SB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZmZahMcj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nGOwfn1w;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dAQ9jhVB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RbLtLMYKlvTivVyqsFblUb4J7No63RmFCpu8A/+53EE=; b=KXJ8n8SBfG0BtvhAddH+2lvBF8
	ZXQz71v1xPEOMv/45TMCT4pfViA6EM7pXNaszFb6ATA1Vpv7LR9rhmqxvbCqKWpaa3FQAQtS67kht
	Wff0BGINIqq5N0GPxa/dBqGxlNwCJWdGFpkOMG3hMqEuQMms2nF4efEeEqWXs+vFTmrk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRb2P-000000005up-0WCx;
	Thu, 12 Nov 2026 20:04:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRb2N-000000005uh-0maO
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 20:04:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tSqD6XpGxffMmVae2CQ4bFij7u0TOxPePiJdwNPwqv4=; b=ZmZahMcjNNHHmJoD3/0cwzf3XE
 T8/SNfqvbAAax8bOvK/8S4MndtXRPpSDNtHZLd5PnZXo7ToE9YEc+i9qPxodjnphCV37Q2/QWEqCX
 hH5qs87TVXfmQvUofzt/3klX1lxk2HYPyCOWd+XCllUbfKMofEb6f8/NsMvVWXhf+Cvo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tSqD6XpGxffMmVae2CQ4bFij7u0TOxPePiJdwNPwqv4=; b=nGOwfn1wz5aaVh42PNSXE3pKsG
 akwKE6w+tDzUW00A3wtGxyxvXWrzB36ELpg5WeQbJZtXrOLyEZipPnV1dMsNjs9CO4jmg3lS8FO4P
 jgwziPH96KxbozjXZkB1aG9qSrrY0wNbH2bjYCpD0GszhCOStDNeGP7jzEVA+LfGXSFY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRb2M-000000007UB-2Jh5 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 20:04:47 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so1370665e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 12:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794513880; x=1795118680; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tSqD6XpGxffMmVae2CQ4bFij7u0TOxPePiJdwNPwqv4=;
 b=dAQ9jhVBZMSOmNhdcOFfxF5Sc8+lgOcnEJIJocKIRBA75X1B4WeQhyyNRIhex6o6KW
 vosWAtkvPHtF7jl4AY33ReCoyJzyvjQOg49pMTkqVoT9yWZkgmcJAMtDKkLcFtFrthB0
 k+IjefiCqaYsMQ60H5GFvNFS/xo1a6FgjVFS4sxKuAWlIsUKbcGmNEtjHaNjcFMTt4A+
 wc60ExzXBSF5j1f9XdiVLn3CuqtLYjsXutri2Zx5RaM7EjDi4D7J4sMvxS2YoV9IPz6j
 ti4orbFzu7zHHiQEZ/HG1UOcJ1gHwxyGiowGc5pDqdOE8y3mFeQ/sUhRtWWmjDU02GxZ
 h5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794513880; x=1795118680;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tSqD6XpGxffMmVae2CQ4bFij7u0TOxPePiJdwNPwqv4=;
 b=nTZLyVulBNjf9NsR8SZ32hYTyeKsq9/x95OOflzzx6PJv27H3jVFNy/sBxy5lvKBG0
 9tHVUP3aJKdA9cPBfPmQB/J65vtfX53CPK2GhDxpxoUVjtXheKwqu0mr7c3vqIe0TJET
 6iY4otW4I9zgfCgrhvMvujLSiSItIM84N9f2H9aRECnMUSxF/xaH08aFtAyVD5xCG3yr
 ab2mMC4dHM3smnqaKD/CHmMPmb4O1roTAUr8f2/rKOrpPkj/5BA8YinCfnmw7jJPiQtL
 dQlRiCewL+z0cGurmOp5DVGqMp1lxHc3Vr+DowDPsiZJTKiRvamW1QZQQhWEpHynkheM
 SrPg==
X-Forwarded-Encrypted: i=1;
 AL+hErE0bE3ZfI7G8zg/NEWMHRd7eCda5ibxVr+PQwBJwCQ/veyyIH8I0VTxwl2cYAYr7s0DnOfKscrZgt7znGZU@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/86csniYx0dhnC8XZwT7B+nVljDmWD25QLUDWrawAS7UQSXyJl
 99XdoVNzAsuujdPtsOROMNIyAVeA4JjrcahqjmXcg427q5sQNrs99phyuFLSv013/jFf0Fl96CU
 MsO7lGDvjsH7VtRRW7ZN6V7rToCA+HWdXoO7Xj+lG9vmo6McRHedrhVuN24wrAnfUhEjX
X-Gm-Gg: AYBFou1vRViD8HOacewGWqS3qjuTY2ngp4tTYQnp/+TltVsJcDBwgMqwwL1TbsaiuWl
 MP1i8CDwmDtch+uVvuy5xBRd22VKPBxXu66gia0CLj+c8lBVyhPrVvi85ZooKIpCgKKOv/EA+2u
 FLgLQeOc7pUpM6b17liuDcRc0Dk1LO2E9CYr6nCGcvXTq/8/ZHy507MtdYkUcyXPmo6LRtnqlvT
 ZPtxLcVdW/NB0IkLxbuWAQ2R/5kANtwudpBzGMJ2U/+vzt6Th8GJvfeixxlJk4Vospv+7Mw0S4U
 K9Qj1LV5OKl90++TPX1gXArw5yB6+fRmh+wbC3XcVXM8MsEJ6VBxo5qgrd/jEgYujxadZpmjdRW
 UaJuH8qLWLyr17bX/mDupcMH9c/YgM9LMhoNZEphY+t7apNRWOKw63qtovNfjoba3+cJ7bEIVQs
 D1XkITxia+H1DuWgLfvjcI//c00oqIdVFFYJQshVJHznSf0OQbw6HF/XpdvLutXVwD1X43te/3C
 yj7Cdso7u/uo02J3Awd8Eq/m/qhsazsP06MqgVfutHUHzHEJXoG29M2CNDH+HnKdAzc0R924HlQ
 pXkzOKOEdvdQUFurGzSLDbZvOJ9n9mnf/cxPWPaPlbWfCBoyGMhUHuMconvnSVRUHw1xv8cT7Rk
 eIDeaPdRbfb/8wX4yod0t/aEMgNnF5+YUeESUwB8TJCv8McaPyOVeHWvzWzfvWBUPpB69x5Yq67
 Y2+UHzE7T0/oFsTq8=
X-Received: by 2002:a05:600c:a30e:b0:4a6:42cc:bf66 with SMTP id
 5b1f17b1804b1-4bb55a5d63fmr5642305e9.11.1794513879740; 
 Thu, 12 Nov 2026 12:04:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e294420sm88004195e9.9.2026.11.12.12.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 12:04:39 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 20:04:38 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: e4663828f40e1184bff8ec0801bc7f1b2ae3cf28
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 20:04:38 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cded6e5062972072374a246f075fe8378a5311ec-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRb2M-000000007UB-2Jh5
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: reject
 a config file passed without --config
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5051228111633978522=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5051228111633978522==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LL9HUgBWYoM="; charset=UTF-8

--LL9HUgBWYoM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Heiko Hund has posted comments on this change by R=C4=
=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail )

Change subject: openvpnserv: reject a config file passed withou=
t --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 7: Code-Review+2

(1 comment)

File src/openvpnserv/interactive=
=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159/comment/43eba92d_e6d=
b2908?usp=3Demail :
PS6, Line 361:  * no other arguments, and takes non-opt=
ions after --msg-channel <handle> as
the brackets can be \-escaped for doxy=
gen also, jfyi



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2159?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5=
7469ca50c551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-P=
atchSet: 7
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@=
ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Eco=
m>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu=
, 12 Nov 2026 20:04:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes=


--LL9HUgBWYoM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>Heiko Hund has posted comments on this change by R=C4=83zvan Co=
jocaru=2E</p><p>Patch set 7:<span style=3D"border-radius: 3px; display: inl=
ine-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Rev=
iew +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
159?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpnserv/interactive=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159/comment/43eba92=
d_e6db2908?usp=3Demail">Patch Set #6, Line 361:</a> <code style=3D"font-fam=
ily:monospace,monospace"> * no other arguments, and takes non-options after=
 --msg-channel &lt;handle&gt; as</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">the brackets can be \-escaped f=
or doxygen also, jfyi</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail">change 2159</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I57469=
ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2159 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Heiko Hund =
&lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;ant=
onio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Nov=
 2026 20:04:38 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--LL9HUgBWYoM=--


--===============5051228111633978522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5051228111633978522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5051228111633978522==--

