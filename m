Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AD4C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/06NksyG/4B5IMkqBtakTfIMZC4NgO8TT71mRMlVgdQ=; b=MPwz4qG4j5NtMVN77c4yBAk9Bw
	+usDB7uRIRZTKUm3sCDuoAT1/4ap8XPlqZlQdEKPN6q+tfTxl4QNJQpMdUbqWhKctzKngXaDz0Hed
	JL5H5+OFecUfI1pODvlDdb30E0PpcR8UI4MTbjwuNHDS3nauAP7VWStlvSjKN7mvTYao=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiDs-0005ti-HS;
	Wed, 19 Aug 2026 15:29:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiDq-0005tb-P4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:28:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Q/k5TFm6rMb9FQFQo/7ivIImRoG8MpCoBm3ED5uOcxA=; b=lxyHzZOstbb4izWhibOOzYTus3
 77kJ7PxerzspIXBNbrdDaN66VJ5mh7YjiMp04S643lxX6z19jNUIYEiZSO7sp0+Lkq8PJUhhdJeWa
 VTZrCQGjONmH+nzHlj00OtDiuCH9fgQnqmvpCTEzjJslEwVoJqYKRBUd7ffmZqigchIQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q/k5TFm6rMb9FQFQo/7ivIImRoG8MpCoBm3ED5uOcxA=; b=V
 gzXkfPfToalx5PN+ibvSnkh+qm6D/k/pr+mwkOKs/WQxBZi7l4AvSTM1LAMZcXvXA+4t6A4ueC+bA
 nU3RsnGABMo1+5cNBepc3lVjKJMCJT5dWk7akywNxel7imOaBAvb1IQekLqt7V4OFQTiRzt0K5qcm
 jWzfTLSsSri/58uQ=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiDq-00079p-M2 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:28:59 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so939762f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787153332; x=1787758132; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q/k5TFm6rMb9FQFQo/7ivIImRoG8MpCoBm3ED5uOcxA=;
 b=NDSxT2aZZiDa2eKctJ66MU99OGC1PHAN1017wCUNjjUaoOuF6hZtohzcbISrySEq0L
 9kPs4Ix3LSdmkyvzuXrM4jd1+tPD/D0XWe7VgjD1fuu5ggSfu8lHClqeVuIgRsBTr3Ep
 WotVrG2AMi+m+6xScgjbRbTw5myYN09Po7AxZdUfZgxeulhsaM5ffqSokUIvzjCjiAen
 HMxgJlOiXAPSbVZwQKA1X3hdOKi6DjF79vVjuL5LEourhTXGAadnkR7C+ZR334UCDRPc
 yWLysc7aI9uH0pUmLTwDX1E/EKtStdlcndpx5Z/P+pXbJWFj0ojsb+dWwGkIK8A0zRXO
 E6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153332; x=1787758132;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q/k5TFm6rMb9FQFQo/7ivIImRoG8MpCoBm3ED5uOcxA=;
 b=d5pGyWxlhbBp9v4YfGWQDWLOJ9rBGJxk0YRLCphchWMNR0WIcvsQn+vHAMJbEizXOV
 59mzeskWvcjWOaau494gxAxvd+IED2tdIY/Um9INCU6Ry59rOwxlFrNYmWPNzGR+Vh8X
 4UJ8A36UgfqoLmfO2cYSRH1odc+8P1Sh7ZLS84VpbRpMWj26dHwK+brZCgfnzPNHGR9k
 mgxKbl2V3J5w6dRfQnGSSdFfvhHHxVsaguTdUYcQeTQtYAEvDQLF2a3Gh43c8+TP51Cr
 9w2BrMDQ3cta8Xb9dwHjZL6AyWT8Vw1L22VUMSfhS/QChzvX78zklU0SLhHD8tNMpL1U
 uktQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUEkSCNEe5FACrbz/G4uWz8VODmVsllOdSa44qhDq4//m0zWLDCAHkXuj637OnNT/LfqVGum8jjVtt7+y9@lists.sourceforge.net
X-Gm-Message-State: AFuF++mtKcgMiOsrXxG4KYo5E50f8EgpyrVIIQoY1AhmQ/yGnHaoHBzM
 zi2hOzkMVKd2egO9gpdSBaATAHGL8cVe0fJ5syUV6de9ZZSzQKavuRUxhGtuer8Mb4EBmNdLLOO
 jbxsdeQkwhMPzGOiDbRkatuc7AkCZiIS3THatZuSy4B1g5Z9X2QHJYZLYf2xsqDpAqcxz
X-Gm-Gg: AR+sD12hhS5J5cNhl8d1KrMiw6n5/R7Ij+esT7FiC6U3TqbYi7ozhsOPUAU1V9qSVtM
 pqnJcyiP8Rsirn2dG/cIl4LbsbUktRxQalV9XW1nvhoIRpkvaxJG3YClBrnOMv45jSDtce5A+DZ
 T9cgDUCaZCGyq9iRRJP3RiJGT9kRP7QS/HMc8M4/63Tz6eyCTut4Bb/R0s5z9ijLcahWp0Bgrwk
 FbTNSgsRQ6h6DzQBxiPWV1L1hdkfgIKtIt2g1uAFyrnF9GLhyMy9bpUA3LQo05UvlwaRMqPHznJ
 nKPqiTGaXJ8pCxv8HgsVIvj8+pUxr8Lf5wjQxrxjcxjOgAjdyThNYkWAnMPXKk9XNqSBtzmFxuL
 9txHeLRvhtF1QkOJ86s4PewiWj2re7HxwR2mW2fFP7CzC8/XzzMVTxjTeqf+9V3C9C7nv6yRO5n
 xZF60z4tl8inssiHnyc/LBt4QVP3sGd6M6bRLl2BlJPabQyZtqGkMW/34gFyyY+CESkseGM2BPm
 60mvUv2NOlJI3AITOdtTMoNdJDuBxn75NCdYdEmhKpgAjGPj2TNvzutyGusO2vKSTBXli1s01K8
 LXCt3NISnyRvNF/hDsVLCGdqMTmPAL6ztPC9R00cqTvnqlBawJI=
X-Received: by 2002:a05:6000:491d:b0:47f:96e3:5309 with SMTP id
 ffacd0b85a97d-482b1e94f4fmr10077870f8f.9.1787153332028; 
 Wed, 19 Aug 2026 08:28:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d9783sm6150542f8f.37.2026.08.19.08.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:28:51 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:28:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: 871b80b3d7079145d0bb580e6601b4e6791ac753
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:28:49 +0000
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <03f60ecfa2e8aacd53286cd1f4fe576e1182b291-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiDq-00079p-M2
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove various
 unused functions
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3791966715455655334=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3791966715455655334==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uNQ945nEnq4="; charset=UTF-8

--uNQ945nEnq4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1610?usp=3Demail )

Change subject: Remove various unus=
ed functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 14:

(1 comment)

File src/openvpn/multi_io=2Ec:

http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1610/comment/9e8f1d19_57348a79?usp=3Demail :
=
PS12, Line 666: multi_io_delete_event(struct multi_io *multi_io, event_t ev=
ent)
> multi_io=2E [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-Change-Nu=
mber: 1610
Gerrit-PatchSet: 14
Gerrit-Owner: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-D=
ate: Wed, 19 Aug 2026 15:28:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Lab=
els: No
Comment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--uNQ945nEnq4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/multi_io=2Ec:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1610/comment/9e8f1d19_57348a79?usp=3Demail">Patch Set #12, Line 666:</a>=
 <code style=3D"font-family:monospace,monospace">multi_io_delete_event(stru=
ct multi_io *multi_io, event_t event)</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">multi_io=2E [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">chang=
e 1610</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I82a4e82ff876fab715e052de1903c65b835360b5 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1610 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 15:=
28:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>

</body></html>
--uNQ945nEnq4=--


--===============3791966715455655334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3791966715455655334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3791966715455655334==--

