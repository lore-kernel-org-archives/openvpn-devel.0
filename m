Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0223606CB2D
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QAYEcKWt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iZmnuGHx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WZMR80oQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bgSWSiAz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=F+4M25HOgyfJnnE0SxVugwohVG39NZJmF2K1qmliZWI=; b=QAYEcKWt4hgU2yTKovpMY69Bl6
	TutHF7X9x0a7balDVXO7HrzEcdNpv9C+F/ZkQ9eYsOxAPUyDvyLUraItVFUIz9c1wQMyZfaueNEgy
	lbcVlxmHmbY16jihkEXAfx1qnvCfXQ7RaLcGN4KcSh4CNE2FcKj9hcI3u9sEJW1celvA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLgJJ-000000002gV-0Wdx;
	Tue, 27 Oct 2026 12:29:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLgJH-000000002gJ-3wKL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=svq3+bwQoXd8yIeJJQATkMrN7tCveZdptb1mZtkgEvg=; b=iZmnuGHxdCBBFjGpjXP/8UiyIc
 /w11v9giOmgcn/eoLbZ9+sVfuII/LUS4kL9cgaNTPCzwtsyMshZ01lHJJX9E805qL/icZQHrq1sK+
 p9eFMsSd4SEXSGhz/pStkcfaJNPUypeJBKsmiM+n/aoKThckF3AI+kNRJgCIFx+ru9C0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=svq3+bwQoXd8yIeJJQATkMrN7tCveZdptb1mZtkgEvg=; b=WZMR80oQ8OCdfz3I83TyoU9DhH
 XaTjp9meUVPxvIXLnYHoCNi54dW8iuaZ821Xdl+ydj5Ap27zFc3V++FydPMs4mng5QKmgaUKJUckL
 MDfXPA4E461lig3hyqUz7rxq0XWGVXBmKM24DdoPKETBhsG2wneKJxAltsuKJQUkN2kM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLgJG-000000005Kp-3lzr for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:29:47 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so16072695e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793104180; x=1793708980; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=svq3+bwQoXd8yIeJJQATkMrN7tCveZdptb1mZtkgEvg=;
 b=bgSWSiAzmYFko5hRG3Gz4q7DqMvG1Scq6R1nDw6oAkcdtAVMjd9OWppxThogpvUB6y
 jJMdzhqTPSSjITGIdoFjPOX2gRp1ayPRi7EmPb+0onQCy+WgMFhjW64VFet2MLH/YDxM
 1eWo7jwkCa507dIptNRHjSOFQOj05kqAuUXS8zeRYWr3xASz7pzbw94KJoUxPy2IX4A6
 TfSAnAMP7harheXPhDFSleiykKerj4XWrRP+sl6evBxfHH9idkGrBV/Y79zfjY2UQu9O
 ullHqxEF6lE6HUCdEMpDeb+IkdedwPpGisNGohOmsppZ4e1G2vcAPMQH1mL9ZwGeOFjn
 fbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104180; x=1793708980;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=svq3+bwQoXd8yIeJJQATkMrN7tCveZdptb1mZtkgEvg=;
 b=SG16imxFmPHrxY0DLw0FoxXb6L8XhNim6N3YvlKtpZHUuhbjwyz33Atyd7atF3ZYgg
 aX7QgYMdfJnC8tKH+E89Gh2CGWas8J4P539pqVcaIXBtEcuwLURdHOoaYBck0DLO+9Rq
 I57vsl/bxFUALzaOq20XJLq/pZklCrr2xLQ4LJ4aG+gXZZ3EwKh9JbA2knzQcMNKXgPu
 CfeaEAlEh8RSlaexMBRj/yzhO1DxrizY8Aa+7AFRsGK/XRUhhfxjW8SreQAmnpjNXKuV
 zSsnxRfo0/tZhHw/tWynca4y/3nJi1bG6FU9Scs+s+8jL14xRSx1rHP196pgFd/4FT9W
 TMoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVgjACAHI1tCRjg+S++JITZ72Sh6QRg/RwchV8MUQhxyItI69vwtsuq3amEsn8ot0Ud1W6WJb01plOA30P@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIBXRLpzmWPvAaZ3GUX03x9p9ao3NLGbJIq/7foCzOePRHnYOBG
 /SVoB8+LTR9q92Fj0BghCV2gUYQ8ei9J3V8OfY1SJa1N9nzd5nV+UBJVjyDVifkKqG7aQ6S0ScE
 KxUvQsamESzUromM0ac6Cqb6dj6/GrH//iROfT1H2O7EjmVNXEQqL039yVzIM8Kj46FOxh4XWxt
 P8zlUIsA==
X-Gm-Gg: AYBFou3zB9KQajryvbPUHZxz26+rT1Ag8B7K3UbbR9rfqYJtZXqV+rMzWRbyKS5vN4F
 sH6QRzA6FyV+k5A95riZg6yEDIG62bpuKZ3F8ETYvK3+NHVaP0X5liEvw2ZurbkytcRefSfP8uW
 KXEhRu83sOfcUPFxaWbIJMqx0tu7gAfV8RQC88/ySyu6FhWWZrvOB8eDpJmwDixbHd6xYrTbehh
 a2YEltHsLNoc+4HLX8bQaNq3UssjhWw/DKbqvHga6q4m92oXrh6Xqv9dwvFACiHeZnSaDE7Ys8v
 t3mv/qVAW0jYcHqAr1T2raug8BbhqgbW989fnnUpDdLE7a8E1w/DV5bHx25+roefhrVNhIk1NI2
 Ai39yr7/VHIBH4NozinOJCd335ME5cLT03YK4wkepRymNCjnF39+hXbAFGGmDGUvq6w2PJosZf2
 0LnJFCYDzcn/4V6a0hzfLjgy7v61PiKPY/D5htB4sKrfcqEqmKBvYwUb9mdaIXmwEbAdKatW+xK
 bjGJWht6pBAHfCkjE0Aioj4PS1iKAxE4Cf3qF0iNCv9AZo+T/UAAptBbHo7R041cpcyFMKsc5aX
 W9vVqZxZrvJ22JPDwtQTXts/S+ltDn0sbbzfmnTuNYUGvk2CDuQtWg68gwkf6PIiuzO40Pvikwx
 3DV+8XkKVs0xuuPUhkli9EAhGQeQOY8GY0XMrFZS+eXsBjdMQ+gqTowhcLjtaRSE=
X-Received: by 2002:a05:600c:c171:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4a35ac94717mr180987415e9.17.1793104179552; 
 Tue, 27 Oct 2026 05:29:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a55e99fsm276742515e9.4.2026.10.27.05.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:29:39 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 12:29:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 1a0beff41115a8b57eff4c8aa856392cf8f5de70
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 12:29:36 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <731e4313f4ef8debc7dc297fa0a96f89b968c19b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xLgJG-000000005Kp-3lzr
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============3950864037715129304=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3950864037715129304==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OOxw83wWC60="; charset=UTF-8

--OOxw83wWC60=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13:

=
(1 comment)

Patchset:

PS13: 
Yes=2E For the server path the ACC protocol =
notification message does not really work well with the management interfac=
e or the code paths involved, so management/server now gets these via envir=
onment variables like all other things concerning the client=2E

I fix the =
double gc_free, the unit test and the difference in len vs length=2E

I am =
not sure what the problem with "to facility the pending authentication" is=
=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15=
896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 13=

Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 27=
 Oct 2026 12:29:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--OOxw83wWC60=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858?tab=3Dcomments&amp;usp=3Demail">Patch Set #13:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes=2E For=
 the server path the ACC protocol notification message does not really work=
 well with the management interface or the code paths involved, so manageme=
nt/server now gets these via environment variables like all other things co=
ncerning the client=2E</p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">I fix the double gc_free, the unit test and the =
difference in len vs length=2E</p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">I am not sure what the problem with &quo=
t;to facility the pending authentication&quot; is=2E</p></li></ul></li></ul=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
58?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 =
12:29:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></=
html>
--OOxw83wWC60=--


--===============3950864037715129304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3950864037715129304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3950864037715129304==--

