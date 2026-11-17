Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E062606A329
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MRtyQocv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=C24wJMiM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FyLoKOqi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ajxGDwjy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vQh617yhnBx/wjMHkt9pZ3+nUcmy4y1q2Ti/mSsL3d0=; b=MRtyQocvBoLny3jqVgiAlPyZay
	+EVWlvtVPnSMxsLR7xEamL58qf2nDUhzx+KttCmb5R0VF2BLirfIMISr6BOT95m7PoxLpWMu7sbLA
	zVry1mezv/EO/5W9ke7JcgITAbG1vek1yWnlfNm0WmvMxheaFehsbrS1UjK5g0VYItIU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTHYx-00000000758-3Oh1;
	Tue, 17 Nov 2026 11:41:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTHYx-00000000752-0WQ9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:41:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lyb2TTfjeYxZZu/33cv6LK/x5fX/LMo/nXb5AAMIykQ=; b=C24wJMiMWQemM2ClHFKASqttp/
 pWNDSkAFuW5hLNdLNEq7QlpP75symAVSpwksQBb9/iEp21lPbG4GyUGP29/QDG8h92jEMgDGKyHCp
 ihNNwf3geQEyN1Es8TA9zhSEXZN3NcKkhJxIy/ts5+UdAbGt5DDmLSGnW9jIY4Mt0Qfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lyb2TTfjeYxZZu/33cv6LK/x5fX/LMo/nXb5AAMIykQ=; b=FyLoKOqiP7cAAl1nG1snkk+frm
 352AlKqlTKeWcDAsBgDMLaxgWMosNS1tcKiw3LMls3XPSHFF/EsDXeeAlTPBGvmRKKtDtw8w+LM2A
 EEvbHSzrl68NWziSlo847NWzkYMDI7wpr3KK67WG6EgTjNHGlpKeAcsQke7PanJubgPo=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTHYu-0000000080x-1EQo for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:41:23 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so32453325e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 03:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794915674; x=1795520474; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lyb2TTfjeYxZZu/33cv6LK/x5fX/LMo/nXb5AAMIykQ=;
 b=ajxGDwjy/JHROS5rBasF02mNDG/A/w3fTUgoG0Kh2xrLnJjk1uKXv9C1kPHg+8tkFP
 Rtr6SkhQ53Fee7LbtU3GjQJSGTNvspUs+Y+dT76JX0ji6JPwNDsbRjSP4ji7zo2gAWz5
 dOceAFw4Xx2/T8RdLsKlEMM0o+9EvoJooL8qAnjqDBZs9AGtrRsWQIISnq6IKRQI2LHW
 rqmh4bSEH18QtR2pQMYdrVb3bnSShldl0wPtsVl0nXKLa65X3Fj7WCb5DsPJcDWZ/At9
 ftb0EFplBq3hoFXw3QojfO6TFih1lX1MxXGHsEeG86+6fLNU4HKTuoOLHJMQd751xQUu
 gHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794915674; x=1795520474;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Lyb2TTfjeYxZZu/33cv6LK/x5fX/LMo/nXb5AAMIykQ=;
 b=nc+ddRQVzEswZtJJLQ7h4mOXNAf7J0T8kafJxJJtXR+FPlumvbgRmLBp7BiGoI1L5z
 X70HEeAIAFOEdYeBuDYPRCfIYlnlW9MiCWmom+YF3rCbnS9bT0r2e424/VGrMWJTpQeg
 MIPG/rhwzfFWaZx9td6iyZMAOl488DWVonDufDAadlejAj0tT9ph9FjxIOMecOasipMG
 3AaLU5RfYZA7dE8P1mDCzd0h6bCDwl4Ep5TBC59y7K82useZktMUPtsCRRLLDHEOb6np
 1344i4sTYANVOBEmHLvdNNF5LmXBbn+uaoHrrjnGdHnh/5JpQUek8bXUjx3vLv5B0yVl
 8LkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHpBpn4iiy3JC2zKparKAjY6uUBxEbKFUxmMvnMiSiL1kwu5Muj3yz86nPkXd6NQPsnxtDfBz54NI5F4w3c@lists.sourceforge.net
X-Gm-Message-State: APuU4Z//qCQ/7+oYtj+HN7tSDR5paDjRZdjaTdUhEgUNxLevnA4Pye4r
 XKv4KqhhfH3h+oD7FAfDuHkgBbQopCv/OfmItXjyR/ca2eRdnb2yUQLZ1K4Qxp50jJ/vTc9uRwN
 RtBXw8L4gEIMfPzDAQMgPrOvIAuRGHy+L3s4c+gWrN9DiI16xkCbmqRRIqIQaUBS7qa8IBv2zm1
 st542Okw==
X-Gm-Gg: AYBFou1G472rUhZfuiGzY5SjD4yFPqfXDFgpcMkflVIXcRE8A4Z2GgJV55KfegCYR6Y
 1ZF2RdENc+aTiyzodyHzRkuwhy620OFRPmXdUSah2oF9KqjrXha1syc0BmfmXKeil/j5sXHVAXN
 j93NriEmdVTQk/rVjUfN0Ss6xAAYFUKLsNy8BYz4/yctRrseQJB5NP6W5KAXTHq3W5DePmdo0sg
 knTAhGhjGlMjJqy/NPMrOk/+LUPtEHKoqKVcoBlDV96l8SyPZfvyW2DsnLDWLq8NTNBQ+h0NwLJ
 wBvf8To7D/tVNQI/aYgFCJs+na10+A7H/MiFJtefhauyy3opv1XR/ErzvAQd0tpE7QQhT578MpF
 fmTK7GA8Di3C9rAnfsZ0aJLkIqBqhIb385RK2uN4V3IjQjoPuvaMLpqxkiVWYovdPgbsh7rV3li
 r2Ld9tdqxNCe/2KSS9HFRY9dVNQ2wGZPLXyviT0LBjAYgAVNJcMMbuav8l+eF+4mu8EH9X5Roz3
 Ae5TrUyQ7HGPCr8eGd6ysWCBDz2jkutTNxRokZolPlN5ij8NsOF66rYnuNjqTp8bxMKO8UjCqVB
 3HJQ3qRd+250D/mqvx42Ttuuy8VzwlyNqpee5KPYvEAjJ00C0Q0qD+SXkPboObixtulWLUoKemK
 DqDvSgLYSjwimPYznYMrlXWxlNirF1kf91PVUpfR/y0kfjAQXmGXkHh1e8R6ak/QI/QXpSOrfvl
 xmQP71lxZGWqPf3zM=
X-Received: by 2002:a05:600c:474f:b0:4bb:76d6:1f5d with SMTP id
 5b1f17b1804b1-4bb76d61fb0mr83773425e9.2.1794915673542; 
 Tue, 17 Nov 2026 03:41:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb732a2a9csm117979465e9.3.2026.11.17.03.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 03:41:11 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 11:41:09 +0000
To: Alejandro <alepacheco99@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: f76f976134a1bb257fda97ccde77d6c06ce1b612
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 11:41:09 +0000
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c00b189dff45e8a98076836c6a19c9f02e5fc049-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xTHYu-0000000080x-1EQo
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, alepacheco99@gmail.com,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4260103936918297948=="
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4260103936918297948==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aVRB22PhgmA="; charset=UTF-8

--aVRB22PhgmA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Alejandro, Antonio Quartulli, Arne Sc=
hwabe, Steffan Karger=2E

R=C4=83zvan Cojocaru has posted comments on this =
change by Alejandro=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?us=
p=3Demail )

Change subject: Keep the outgoing control packet in a buffer o=
wned by tls_multi
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2: Code-Review+1


-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2002?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
Gerrit-Change-Numb=
er: 2002
Gerrit-PatchSet: 2
Gerrit-Owner: Alejandro <alepacheco99@gmail=2Ec=
om>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffa=
n@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Alejandro <alepacheco99@gmail=2Ecom>
Gerrit-Atten=
tion: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Steffan=
 Karger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 17 Nov 2026 11:41:09 +0000
Gerrit-=
HasComments: No
Gerrit-Has-Labels: Yes

--aVRB22PhgmA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Alejandro, Antonio Quartulli, Arne Schwabe, Steffan K=
arger=2E </p>
<p>R=C4=83zvan Cojocaru has posted comments on this change by=
 Alejandro=2E</p><p>Patch set 2:<span style=3D"border-radius: 3px; display:=
 inline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code=
-Review +1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2002?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padd=
ing: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2002?usp=3Demail">change 2002</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2002?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e=
793 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2002 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Alejandro &lt;alepacheco99@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steff=
an@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Alejandro &lt;alepacheco99@gmail=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 202=
6 11:41:09 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body>=
</html>
--aVRB22PhgmA=--


--===============4260103936918297948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4260103936918297948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4260103936918297948==--

