Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA53606A31B
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gL27B/nR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LY/02DtE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GLQaaa2e;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VXpQhGGv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/Fh0mLnJFiwQdSnp5398R4w97xxTJt5Cm6MBTWX4cnY=; b=gL27B/nReoukbS46ofKdm9njwf
	UKDxWK+jDmlGvTyvCgQymV6tpXizkrNkcgMM41Z6m4H7vNyjUlVtLw4H935f1gHdySAo5TI6G4MJh
	+zThVLiOxXCpLiGtk0dqFcq5xypuHHbEdlrI3nHtWNuhuvrqK9oSFqjVMSsi+ybibW5g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLITc-000000004en-3yiB;
	Mon, 26 Oct 2026 11:02:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLITb-000000004eb-1diB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:02:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0UOtHb4N/NP0E5lEaS4Yr0RVPk2VuRbNb1afFrbGy2o=; b=LY/02DtEPorRdpKRq9bCfJ8nFO
 33euOFnnv4MADE8Ni7yN7zV21wM5bLDDvl2gU9BIofPN+TeV7aXNuoLS/fWpdyTdRSp4OdM2MS1v1
 1Jz55FLxKRfdOCd+ph8G9KPzT3HFyjWbeXgh7VMF818CfQ0kRG9U/PBmrr71Yj5mlb+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0UOtHb4N/NP0E5lEaS4Yr0RVPk2VuRbNb1afFrbGy2o=; b=GLQaaa2eCP6uo+2MVXsnwJ3b4p
 8orid3maGaKALDvr7nhjz2Ud9lEhyHLYS4z81cKCPWtADAzWNM4DKe9eBCuFw5GWq8N5nxCXgBzjF
 wCfHn6NsjwVAoQjduH/hwftKzpcrEq6Vao7wgaJG/IKGc23agmNS2YZkWL6RY1kjX0TU=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLITa-000000006d9-3480 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:02:51 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so2114605f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 04:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793012564; x=1793617364; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0UOtHb4N/NP0E5lEaS4Yr0RVPk2VuRbNb1afFrbGy2o=;
 b=VXpQhGGv+ZM3gr+u/avAj4P4n+BIHq1kQBtDwcjTXcMqIJ3q5pA7CiJKjjS/vVb9oH
 QUjeUXZ/TKeZRTJ/WoO26dhOECxh96+q7GBmfhlj9A3fV7y2KeW+vEy7zYYtkA/Z26mN
 81lHFTvn8fK6neDHtKpeCuFfWma9VCIQ7SabEysxeq6KMxwNWpcPmtQSth1c9HgXWPpI
 ZFvIijwKiVxZnnUSClUQPWJ9scrnYmmpj1lu2njrZPoRmDYSuzbCPoZ88X6B2Fnwb1XV
 o166leF43e9q1BAgRMN/FtMiohyfZ+DXJfPdZAiCRM2mRR7qoiaFB36z3SV6yuaGpT4B
 aMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793012564; x=1793617364;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0UOtHb4N/NP0E5lEaS4Yr0RVPk2VuRbNb1afFrbGy2o=;
 b=kNwhkEa+mxlYrr2IX01fWqBr6pxrim0+ERvoFww21CzPDvfK454Vt6PqHkqlW1hP87
 O2BDwgrvLkhdUeZgQjAAjXbQXAaRfw3KD4KOMfFJuZHL7ZzXzT/g/Rv7+Y1eACgE6I4u
 DyGTO/6LPyOKrYRd+XHGl1i/7wLcGncApo9k7ArBIvy/7kRuZfhqtTMEvvVH0mftpgKV
 7FXO9Ba9TtjFvnVrLjnSvxDs1pvXc+jBzBc4bOBVo3b8ZK1+03zWLj00VDZldfhxILyr
 a/nG6Xp3DrU8G7+imj8kdRvaLhuMC986Pw/oPNJhrQt0AJwVRUJfK3E5crIbKcPG8wGw
 k/qA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwE3YKv9F/3IhvT7uCpIQ0iPDuJzNDXhdEMM+6SlMImhbtgQzzN5qTvtNmWzwx5UhDCpWfcbCZpCyCvjpw6@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJo/HcJQh1nkdF0lwRrhW/9XWoSr3agklU7SbaZlq0fHLoqdvfG
 tHs0vbQoctvHgVSDm6szsRYaEIIb/Z2eCpxobP5y8yeA/TIQmSz0fd95KFM+FhL2I0EuPbjrNkP
 fjaxSup2Sp0Hd84rjUbNRaU0MzbC9PxoIqAIkVSzw1GR3Yts1Ru3mBfJ4hr/vdBgqqPRr
X-Gm-Gg: AYBFou1uqUoeueM8oCmYClo9FAM2KRNNO8mV0rRDxgbVHfsO5U2rLdAaKd+hAoIA7q/
 ehIWCanMukgLEbPk3MxfPuWr1xKN08jSozrnmSuJGmoW+4tknPVIvTF0GiIv53Yl+mB4QSRkTmw
 InSXmlCcfOPVKFgnXQVVRyPrEdcz5kSetrKR2+S8Ab2oEQywzYPqhVlWduXrpyWy2evSGEe+sJg
 SbzerD6KD9HJFGNheDpus5d2YAGPEjv+Q5PVNSQEn71Ls4RHz5J47Ft12/SfupWmBcvwIXB7oVF
 HECD9D3O+rZe6wv9SFZPohR3oBBJIDSoRWlv8qnr7Ht0STj/xld97L9jbALMkMoHgmEJS65wH2x
 n5CyalgqOAjtgBFWQmzEAxJ/Cf6fdVHTaAnblV5R+gLAD/CYPlJIM1v27kdzrBR5yvDSh7/3DCn
 xOwgLQO3v5o+ASqNBTHXzhOXgYBCBGwF5QDj1N52YCz5P7fF7ppFpF4HiE2DVzzOWSDVQ339wKQ
 0o5LAo9OhwJ7aYqFgjud+fdzCSEZ95uje1CbWWO1qPLCT70CfN6U4LlQWoKYLCIATEmQj5nzMBl
 VIafImLC3dfwZF0sVYDjhQy1knZTJJePtOzXD9rf+iWyxA7Uwe72Q24HYXRuLUrWKqJ4zfN/kgE
 TNtfS5WfO78XnQdQ49yiOJf6loQmqU+wbk9zNRFk2OQ==
X-Received: by 2002:a05:6000:2481:b0:48e:4e29:5c63 with SMTP id
 ffacd0b85a97d-48e4e295cb5mr5853160f8f.27.1793012563584; 
 Mon, 26 Oct 2026 04:02:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e412cc164sm14722782f8f.7.2026.10.26.04.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:02:43 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 11:02:41 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: ba8d6bec6cc54fe12ed373e0f52d46fc526763d1
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 11:02:41 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2dddb6facde1e8bfa5fb446388b2a0d71283f6a9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLITa-000000006d9-3480
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
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
 charlie.vigue@openvpn.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4614834425294847524=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4614834425294847524==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qn9FO30MZNQ="; charset=UTF-8

--Qn9FO30MZNQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, chug=
ly=2E

R=C4=83zvan Cojocaru has posted comments on this change by chugly=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail )

Change su=
bject: tests: add unit tests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f0=
85574dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 6
Gerrit-Owner: chugly=
 <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Comment-Date: Mon, 26 Oct 2026 11:02:41 +0000
Gerrit-HasC=
omments: No
Gerrit-Has-Labels: Yes

--Qn9FO30MZNQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, chugly=2E </p>
<p>R=
=C4=83zvan Cojocaru has posted comments on this change by chugly=2E</p><p>P=
atch set 6:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=
=3Demail">change 1946</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1946?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1946 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: chug=
ly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Mon, 26 Oct 2026 11:02:41 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
Yes </div>

</body></html>
--Qn9FO30MZNQ=--


--===============4614834425294847524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4614834425294847524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4614834425294847524==--

