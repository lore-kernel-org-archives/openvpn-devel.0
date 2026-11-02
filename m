Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFE606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E+5BM/kE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BeJ43rip;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AgsHDZz6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QnN3KLjI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EbGS58dg6LUVIeV0i6GupndxOpjZRq2xbHYfCP0/3Ho=; b=E+5BM/kEUEM0Fr9ybv3bxgpO67
	CHJVpg2fZqUeMBtyPjfZ/8Ijry4agSrR221BwxtWvytIwHC2uaQBJJuWrtHFipt3hcGYBtmDuOGNq
	mAYKgwpjiTkSnHNikurCkcOWqr5FWJIw6KKgOnqH04lyGxqUq4E4M7Ku1uULtWuN8hF0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqVE-000000004vf-2WMa;
	Mon, 02 Nov 2026 11:47:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqVD-000000004vU-0hHv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:47:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rh8wfo5Iu9y2QANCa+dZvuSsQJd8Z6SKY+T4M8j+P7U=; b=BeJ43ripQt5B5VXLLQNdc17yuk
 Z6aofGebgiWfmEVvaRE3lBVonsjSsW0SZtn3Bvow4CIfquowPmDC7HzwbI5GKoy5z8YMUk4ZRcuhC
 HaKF2KuS4apGccBeewW7vBPiyRSrrqTTCeVgEWfBADn1rm591ptUI2E3ZaYFSmJmrP9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rh8wfo5Iu9y2QANCa+dZvuSsQJd8Z6SKY+T4M8j+P7U=; b=AgsHDZz6dr8j9Tb6MG+n0BrFc8
 sbR7TK2sHPTa8vFYu5sE0QAEaZRUFCFLP29ngy46UIJUTVfifVHhOhnbCsZXvpujdLacjZtks8EkR
 iBIL/742KxkNejcn5iV7lg3z9gjmfEUMtiMoRRElXBfKTENB8v58D+//QXlvWMQ1d0is=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqVB-000000005Zp-2Fe8 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:47:03 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so29551025e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793620015; x=1794224815; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rh8wfo5Iu9y2QANCa+dZvuSsQJd8Z6SKY+T4M8j+P7U=;
 b=QnN3KLjImTHoYLEM2btjDsYbyYZLxUWq38Oy+QW7+l8MU63pSB8l/ESf+ZeNsFz90/
 V6kdQ0do5Ss3AeARQhNTh6a3H9zjZ8RFVpztjm3HgZ6Tn5hlnpQ+nHtn1W4CbEvJExHs
 s7yEl5RU9u7fxy8kS4ep43WdXnwH/nMJasC4nGRYGyBwAEG6wtx5fpK9W33s+TgCIGrj
 aQjoXD7S/cFVbG3nGlZLY7+gRptdx7lRB61mapkhibTI+fvE6XS2BCfz5r4nh+kX1NlP
 udPxWmQrHmyGJPOIWBXuYiIoRVcQ5i9u+NK/n4/m2f+MzO2jhXlA7coLvUORvZB9maz0
 r58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620015; x=1794224815;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Rh8wfo5Iu9y2QANCa+dZvuSsQJd8Z6SKY+T4M8j+P7U=;
 b=hkexxnMy8i0Rr3w5F1HPa3iT48Dq4reYnke40Q8vikPesbFhQjfVa2lVoSAXzEAH3p
 S0oGh1BpSHvNvfpVbq4th/4IZ230VoNTeZSLVIAFUFK53Z+Gd+LmvACGbcQBLTAVtfL0
 u3dtTcWvqj+uqQdpbIomMaZMN7cdkwo82WIwrSx2J6WkEsZxbRX1UM6Wz+/THnptvs+C
 tUlFHL8wMo6fafaJzM4F2SBiiVdQzOOJbXw2QIqCOpysEtrxMF94j8c1Vr8HiSlZUT3/
 0oycJp2uoawcUDZep+KrIiRvntCK+dXuDT5+wD4zz0amZ3UyH+gpTWr4Ax+GQYqwxs0Q
 jpDQ==
X-Gm-Message-State: AFq9FYIwilvaxxqxox4sU9TA9YmHqzru+xuN2B0/ElDO5oO9U6A4OACy
 nGKQ7NBW9l8Y4qgnGEkbCL2xYXy+YdwStZy8uiVfKSy8euydovLqLsz6R6FX/I/3nJqe1qx6ACJ
 CuNAEm3LWRTh6uOFevxdhoOksXMM4N+9EnAE7aHK6bGcbWbFnXznZwLt2DCQpaTZWjsw/EO8aX5
 QH+hEl0w==
X-Gm-Gg: AYBFou2UVxmghi+SflwxqIg/99sGSUJw7wCinro2U0p8w9NlRjYb6yk8+2D9e3uhdlK
 JQO3F9lpdVRLpDvm9Crwh72Fautp9zYcCxOKQOuQbLScarhA+RUPcP3cbJVPW8v9nH09E3jtuyY
 Bvg3EoyufEqn2enjd/6IOA8v9ML8OvCXq6Q9TbdOc2ZFxjEHVf/UXP0xm+fl1H6rfZXg/R1v/+R
 1C8HZcqrmw/U3udM6Mpo0Ecy6PdqQD5wFx4AKXjbnBDkL7uBGhQ5PQ56/C96g+TJ9RwPpFFJJnP
 JGmmGTpbTO1OXdSEqj4IfsRxMX++46TvQLCN4vrGwCJKNAkVlsdUQDDU3MkmV78iuoOOQOziuCf
 nMmr1vYZaJzhg9shk1CNZEUEDkEcHPYpeTWZeoQv7cTAxYXTDmLSWqiivmOw+caVRw1zE45gN7L
 +oMGx6JBiBDlQWePCDVy/sbsEZXz/FQhHBwqRL+m5XEjKFmDF7HTCidGT1WGIT+jwvXwol9lQrK
 dgncQeP5T6uu6lT/bP7YXM1Ptmmp/mKZpEudKN8j2EpPKBrpPEN1BZzOifhFO9FX9+TnJ3upibX
 gLdP6qBJrD0QGaNH3dre3AI5vKoELLsmegUiJkZCOCBeH31NeoXlBhey7t4HLmV/cKLP0s0aAj4
 wYb0tCk/rcDX3YMk5Eyj94cN4brG5I6/uqFCqAxuvjoq13mBNdOc+yUlMKCFBqTyRRHHmG+QuIf
 sWMC/wdABBV62EWGabYLjBq3g4lqI3gYkIl+I=
X-Received: by 2002:a05:600c:8708:b0:4a6:42cc:bf7b with SMTP id
 5b1f17b1804b1-4ac150b2176mr241033775e9.3.1793620014959; 
 Mon, 02 Nov 2026 03:46:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf0b36853sm253156745e9.0.2026.11.02.03.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:46:54 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:46:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
X-Gerrit-Change-Number: 2080
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2080?usp=email>
X-Gerrit-Commit: 2de62e2fe5ed7b35cfb8bc64155e9256d4b7954f
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 11:46:53 +0000
In-Reply-To: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljNWNmNWVmNzIzYTMzYWQzMDRiMDgwZWYxOWRiMmU0YTBmNGJiMmViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eb8668b6e9168c4fe6542585beea3d5e9851db7a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNqVB-000000005Zp-2Fe8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Clean up weak key
 check
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7072137051746191487=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7072137051746191487==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5Y8zXNNzbh8="; charset=UTF-8

--5Y8zXNNzbh8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2080?usp=3Demail )

Change subject: Clean up weak key=
 check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review-1

(1 comment)

Patchset:

PS1: 
cppcheck issue needs=
 fixing



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
80?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic5cf5ef7=
23a33ad304b080ef19db2e4a0f4bb2eb
Gerrit-Change-Number: 2080
Gerrit-PatchSet=
: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 11:46:53 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--5Y8zXNNzbh8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?tab=3Dcomm=
ents&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">cppcheck issue needs fixing</p=
></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2080?usp=3Demail">change 2080</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db=
2e4a0f4bb2eb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2080=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Mon, 02 Nov 2026 11:46:53 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--5Y8zXNNzbh8=--


--===============7072137051746191487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7072137051746191487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7072137051746191487==--

