Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B8606A32A
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kd9qB0Q1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W8cFxVGy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gInT4FWf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KZCgP4Lg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aRrJWb9UhF49jdQdw8VGLXdyRMg4XLCjp/xPPmyL59M=; b=kd9qB0Q15tLU3F5Rb7nUNhVZ9I
	scpTlVhLmQ1q5fObTJETrPk9c/oT+d19cYwwHFIF599kZMf5EQccgTi1uiqhasVVo0TEMJZ0XsvUl
	eDH+8QiS8CF4pT5VJPC50raY1aNzGCApa6jRFropOKiHYfI1rkVbfIN0JlY/hx6QerDI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWZ0l-000000004FK-0Pl6;
	Thu, 26 Nov 2026 12:55:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWZ0h-000000004FB-1FsU
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:55:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0bgs0O2yd8t9WU4ShpOBscGmrZXxVmD7h59MBTHaw6Y=; b=W8cFxVGyWVVI3OPpkfS/Hy1Wq7
 0F50Hm8/utLWg3M2TKZV4HhcWlE+d5u9paeFVaA05xs5gxtdvbCvju7b+CiIMpP/TjYm3N2ur109Z
 rKS0d6Rqwj3KqPfwyW0vbKH3y1wflfGEUWtvCsMmzh7mdxxjpFuGU97UTUim6v1MRLgU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0bgs0O2yd8t9WU4ShpOBscGmrZXxVmD7h59MBTHaw6Y=; b=gInT4FWf6Rxc2NsA93uYXSX8yM
 enXcM1qKJ86kbT1sV+jIETkU4N4OYivXXrWcvITospFj6a9Pm6WWmxjZqdLEnzXI38RFJJmsldIue
 bhTvqnBudBER/pvTmwzsxk9u/nVCmwHehj+7iFnAz/XYCBBZLPdD8nQWyswQLdwAF7S0=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWZ0g-000000007ch-1rXP for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:55:35 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso6135010f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 04:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795697728; x=1796302528; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0bgs0O2yd8t9WU4ShpOBscGmrZXxVmD7h59MBTHaw6Y=;
 b=KZCgP4LguDhi7kAuvQ6qMbuZIZh5mSbGh/u4RTODYb9IGaCiXtzIi2JfNCoSbNb2fh
 RaIgFC/Dqae/Kc2WcR7uF+ebvEpIgmysCoWNKpQ4EEXz8KlbJLGuroSOp2ppzcxFUq/w
 c/9ofBGvQ4Maf2mm43eaGRdyiWsX5tNlfxP+KQUgqGOzOXB3a4GIXA33q/VW7VXw5GuW
 JQ2+kl+uPzqCDQ15occuxp8nR5xev4D9QetnyhNyrfDdFPbg+fJJ9vyakMHi4WT3MOkl
 k7N1RCaJGo0kRPb6GEgYC35+Z3arjuVn3HAmOfWKo3BlFmh1cgrQC8+4L+sK38PfFrAp
 PX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795697728; x=1796302528;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0bgs0O2yd8t9WU4ShpOBscGmrZXxVmD7h59MBTHaw6Y=;
 b=jxxql+goagIHERtSLXhTfNmFYr20SecXHtE8qQukFdVQE6yEZ4Ms7zri0jDFZFvtkm
 +eBSu+CaAGBkAhsjJXVTHLao7NnRo9jIgliNReP1iE953JCkstxthsSB6MeH8hfEPIt6
 4mu0C9ERaz8FoDs2BQmoR5xlDYsSjsCYr0uKBBXoGSrofZ6l0SlQMCN1uM9CI9JFzFP/
 V1kJ2ZvIz0bgaAOjHbetUaCG531WVX4f4CjhFm8c9c1hTeeehlRgtdEv+4oug6polUBS
 XFnnPye1QXu9X3Ru8BfXGWymHwB6geAD1e9deT29V8jgihvnzlXAU89e4eGiaXLk9b5a
 2t5w==
X-Forwarded-Encrypted: i=1;
 AL+hErFIKXHhdsy7Hquoo47rZfolarvBSzlnHGxA/kfcm0qiaW4rvKIpfIJiPxR+CSffdKbwqAlipwXxRwtzPHOG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8A1J5iZfY0pkytnYZZfmC4pXZNgHTWv3wu+11+1Tv2N2F6grBp
 M0hox2wc9W9L6Qsv5tal/5KhllBxRPmSx5hn4DTv+xjCn2aPEQw34H3Ebju9lFNo9uYvWYf2j2r
 0uKYYrB+Cl+DyYPS8ej0OnuzOOG0KgJRFtCrRfEE46MJCseNMvn2Pqd5WaggE7cnX5AE8JKG6TH
 nUTTPOTQ==
X-Gm-Gg: AZFdTZdJgAfL+me+n6wIR1Z23Cd78/jOUJm+JbMomT3jyRzJKeo/x3+s4O4lm4BwiWu
 ttPREcLxQPEDnTolZU9vev77cSa6lmpry1JIgnid4zB14RDsxdkf/GbvRXFZjhp731OM1nCFmtw
 dXz4X+gm1CWbrPYIUCLXjudHike89QUy1CYU5PUMiLdOsyg9weRBWhBFzpnLNnM+hulaWSczGVq
 7EkkkGir88mefQyeGN/U7/khYn9KDgdNikk7GIaXrhc13exw/VAo+xSGosbeUeRa4ucp/Pv0SB3
 lvIo4aLNy+ggJJl0HPNGWZiVgeUig/vYDVGdWYzCTINLVn4Gc4jRXRVZDzKu5nm/iwZ5PDOMBNZ
 rhwXKh/VB9dBXuh/A/91ZqRMRhyFLC//m+1OOn36w6cV1e0igEhXGu8ZOgdH8U4xm7Zy7L5rnKw
 E9FhkCf0mGW95jRn+dRQNLAmtaAIi5VJnHmxlPH6FmRPctUa4wcYesQU0v9G3M/ajS1sH1sWYlj
 JyT+WLgTkAtJvD1w00FVHuGSQUi6/An123jbewCeYrQ9qTxF9ZPOJVe0Vxi7DNS+RiwUuqkM61Y
 S/IKUFFZF4qdNqjp/9Ua7KD2Nord2cfbZBuQGyXLrTrsTVX40L7Hl0VD9s0J/VHKlDPMuMR1uIk
 QJLD0ppl8WLW6q29J+bWb9XpRisXncZvywC849aYLxQZb2+2lGMRLvaBIArVD6TjiY0Iwd0Anis
 /6Ad2fYgsuv/O846I=
X-Received: by 2002:a05:6000:26ca:b0:4aa:8fc3:2909 with SMTP id
 ffacd0b85a97d-4abad5ac730mr37502302f8f.2.1795697727641; 
 Thu, 26 Nov 2026 04:55:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf685asm40807605f8f.20.2026.11.26.04.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 04:55:27 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 12:55:25 +0000
To: Aravind O R <aravindor@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: 28db47113dd19df5188c5f995d49c648e2c54c0a
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 12:55:25 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2661924bc15b28b17281c4c4acbb25609381fd3c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWZ0g-000000007ch-1rXP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
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
Reply-To: frank@lichtenheld.com, aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4720105156756925297=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4720105156756925297==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KH3ifG28UkM="; charset=UTF-8

--KH3ifG28UkM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Aravind O R, Arne Schwabe=2E

Frank L=
ichtenheld has posted comments on this change by Aravind O R=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail )

Change subject: confi=
gure: add compiler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Build-Request+1


-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824=
ed2fe307e29e2
Gerrit-Change-Number: 2213
Gerrit-PatchSet: 2
Gerrit-Owner: A=
ravind O R <aravindor@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Aravind O R <aravindor@gmail=2Ecom>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 26 Nov 2026 1=
2:55:25 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--KH3ifG28UkM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Aravind O R, Arne Schwabe=2E </p>
<p>Frank Lichtenhel=
d has posted comments on this change by Aravind O R=2E</p><p>Patch set 2:<s=
pan style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padd=
ing: 4px;background-color: #d4ffd4;">Build-Request +1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">ch=
ange 2213</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2213 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Aravind =
O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Thu, 26 Nov 2026 12:55:25 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Ye=
s </div>

</body></html>
--KH3ifG28UkM=--


--===============4720105156756925297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4720105156756925297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4720105156756925297==--

