Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6233606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JUkziFV7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lRJfAc6t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Es0Rj/4f;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fm+dGII+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZzgW50d35pDY1Ssq1rDIfxwGgUEKK7fFMe2ceBlygVo=; b=JUkziFV7I3cdgWWUzJw4Qmg+Kw
	bMQSkW/bqJQzyIRze9gB2tcESrKwZnTAmBU0aQ9M43LuJjT7tWR4vnAk+q01SNnm91w6X3hEgqHAt
	ke7HxSkoOfd5BS2uLqJAnz2UBE0sxs3KQHeMvqRmOBtwq7aReP1TBdK1pWK0UU1czIIs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLhG2-000000003ZA-3pwS;
	Tue, 27 Oct 2026 13:30:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLhG1-000000003Z4-49kI
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:30:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s0s4WS6SHfCE7phCkeL7e/mwpoXB7CaJAFBZEK9ZX1c=; b=lRJfAc6tePRvFm017Z7GeQLANO
 7PywWUWc6bDbfC2sSinlsqsbzgRPcsK3+3przqCEdYXBoYf1rQmzbOdVy4MWOvq5WVvJBgaDHMf6T
 0E5bXSmQcX025ZDFzYv/MD/bh81uB3EYEHq1L6j0BL9xokzVzjPGrtc2Ln+MFxUQ1FqM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s0s4WS6SHfCE7phCkeL7e/mwpoXB7CaJAFBZEK9ZX1c=; b=Es0Rj/4fB4FoyTnkqH+ghS9FeG
 Hh7rCuvv70mfRoMsKVVy721feuHCo0eOZ56Nb0L0D0JnO6CL5iCbf0rXApnmWBjbokLgoJuuDmiJq
 AooqchNZEv4j4N+XP65dfsT20oXL1KGFdymSnBsl237BGej6ffcXQBFW+MuMqrm6Xxyo=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLhG1-000000007IZ-1Ln7 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:30:29 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso2684208f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793107823; x=1793712623; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s0s4WS6SHfCE7phCkeL7e/mwpoXB7CaJAFBZEK9ZX1c=;
 b=fm+dGII+k8DRr0cySkM9cd6i+HNmtp5p7C4VPPNG7kkzYmheECDpaH5Gpuqj3R/6+5
 g7CPNzmU43KZAGQWPEgy5lMrpTAFdZHuGToYKxu8RjF8Y/OG8+ki8zo18Ql4wmkF5UTE
 6HbGYIc3v0HqolpA6416TUSu7TC7UB6HbvsBU9yUo638AUNec1QoLCi8ztzI1ahWpctk
 KEKikjFvJeHAyfL4LBlN6pONRP6zMui1wgt6oPh1x31V/XNCxqy30DyEGk1kImfO7YwB
 n2I26I3T6QZIJRqJRekPL2vYu0YoRYBJlOjQidDzDGn4iblMvv/FxqProhvM/DmP66Re
 UY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793107823; x=1793712623;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=s0s4WS6SHfCE7phCkeL7e/mwpoXB7CaJAFBZEK9ZX1c=;
 b=YQXwnCrlsFRv9buu8Smm1/TzEe4AC1vC1Cn5r5SYIio37+EFCFOJeojDlgUdJ1SFyA
 r6I9opHeXC5asFKJnQdThU7qdjqpHeZJNtLS07iTjfJL/VJ/G3nwCJbmUOKLOKmpSB1C
 6q9LlOg6NlNBg4YgpqiiIJcCx+nTRntYAVkie7bmUZb2ejqph7k5GWwX3d/QyQ0hE37K
 NjYuBNGRM9juOnFCsisdeEnxYTg+UmoO4VR3aYnTYYkPSsfjDY7FpsUsghdEaBPI0r5u
 m3UADIVx68yrSGG1FrXazyFF/5DWFDv+fbbXGGXkHZxKhhZgSgwnlXjuzhgf45kSGv8n
 XLvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7UCpwCSjXZCMD7LeQlOQW0U6PCldO4nZjdBleVdaLQMeJ1p8SKt351/GLo/N+6N9GCdhNfL7yCZSwjvaF@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLXlKtYzM9eRztwHoiOMLvbwPzqL+afHNKXvCYpX0lFJ357dAar
 CUBbpK9+yqa/V6kPbZ/2ONYnivxMtEd2AfoDGSJh+bqsnXgbkLTdI7XURJ6AnCSXO3dMopmhNeF
 WdqBDS1nhi8FJ8MGNkZaHdEIljbyfxLpQMuayKwPDwb1x6covK8niZ1I8wBypw5bGsKKU
X-Gm-Gg: AYBFou3EfOH6ppnYX0Lm4SEpaCUuOXmdPH/KUP6Ab4VZM9Ly7Oi68eiKvivGSH7Lpw3
 2MCbQrWus4NWaKr7Izrxx0mlQQAYXXpNnUTGk3N6LfdPVApeOh2nsN8kVkGYkoHmxgZ77UsErhH
 YeBUAMmBUYlZxz6+MexaZuQNJRAaCopsqTSdhebHKRbtRLja2seORh08b4pR6yp8sjG0rvZIHGY
 bJ62sOnO642Gc2bhzU5LtrbQh/4bn+r1pmdlNo5dUfFyGTlL1aaBy8l26jVTPu78VvreeoJF4sq
 oCW0pv7PIhCegqmugZwes6ZWFrWNjdJNetqZaKqEzQNoVH03WdSEkcBtnqTE1g/lrB/7XGxaun0
 C0003qKdiLctCEKHP6UZ04vn6fpKjMRl+lDp1S9RpKGcgZOPCO27aeWb6LAE2xSOk1aTSpR5LX7
 mvs1V6TOtbtYMfin1PkDPp368ujdz79coP8xTi0Z6BJs+p6g7V9si5JRDQ+ZUpprCeD/uvy7TlB
 KB1V0g7ocTiaIKwwGZumhIQYQ1I1SHTdqZwE//MnO9b9AFc2u7m/e+j6r7VlGcDTiwoLC3ykzc9
 FIlGJmjm3tlvIxy0rfLvE2euzbNnE4Z366xJ1XMXd+Si76ij8smfU8J3liLvrfSs8RBd5xPpdCz
 rbMUyuwzGM1FQN3z68ES2L7D2NDesCkR6MsjXdEVzQA==
X-Received: by 2002:a05:600c:5253:b0:4a1:d537:1c8d with SMTP id
 5b1f17b1804b1-4a35acafddcmr193793115e9.19.1793107822605; 
 Tue, 27 Oct 2026 06:30:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a56992dsm254433115e9.6.2026.10.27.06.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:30:22 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 13:30:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 8747b625499828f3ffebaa38270409a05846e4ac
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 13:30:18 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <782f2153aacbbdb3468916763abf06137f3f2e7d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLhG1-000000007IZ-1Ln7
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============3486070778617610375=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3486070778617610375==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tfJ3ZycGiDA="; charset=UTF-8

--tfJ3ZycGiDA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15: C=
ode-Review+1


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1858?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a=
6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-Patc=
hSet: 15
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@op=
envpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tu=
e, 27 Oct 2026 13:30:18 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--tfJ3ZycGiDA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 15:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3De=
mail">change 1858</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 13:30:18 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--tfJ3ZycGiDA=--


--===============3486070778617610375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3486070778617610375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3486070778617610375==--

