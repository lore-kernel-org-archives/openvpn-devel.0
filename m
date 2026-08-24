Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6096EC5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c6X6D/Pd+zmEfIVj1DFmYku1WDWPRz6fZsuxRsNsNBg=; b=D/I0kqEyAjnRX8dJsHKKvouloZ
	DDKTIroF2YF/n5KSLhhqQuB3CbOki5B9CExFnLYZKIFT39KzyoCrqYPJPUxbSwgg6JKV6MfnbUk3F
	Npcm4uV0EHbsZHHKc7s31ST8xwE1WK5O8SzqAM4gc4am7s8CwrK3rzURDqHgZUF/8sJo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWGg-0001YG-Vv;
	Mon, 24 Aug 2026 15:07:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWGf-0001Xu-As
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:07:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=D1ntVSgy15eKu2z9M4XrELsSFWmxY1SnAlj7LbKRVb0=; b=BdiwzxDBQRkrjuXoAURMZglbdR
 visLGQY89mmuMF7s61y/xZz0GkZtres+Am0Q6j8I//unR1ESJFEZ81CRQO0hv8vIJivZkQUfhCYn9
 z4U2Bq5kUzLPU3zFswQqvA6BkRcZzyrMQ8FFpLG5RTx4c/sorM7NaYqYmV33D/shxwsQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D1ntVSgy15eKu2z9M4XrELsSFWmxY1SnAlj7LbKRVb0=; b=M
 vLHfwJq4pcyyM2nWGQScTWb3W0mFp+gLZ0sL2hCcBdvFjz3l1NQG1cf03bE0eywU8hmYO1UE2T3hZ
 jqON6m9q/5H1BYb/swrVpqY+TGqnLZkkQkXjyZB61uvUgVQNTUrFv4sSP9hiXULDf9v7axjHDJWOq
 +E3E//dU/PbbrIJE=;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWGc-0004Ew-T2 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:07:19 +0000
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a3fda88184so5598838a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787584032; x=1788188832; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D1ntVSgy15eKu2z9M4XrELsSFWmxY1SnAlj7LbKRVb0=;
 b=JYDiG3jksiDcfuOkX1D5htHPa+Gtg1EmFhB3FkBvhFsqQTKZ5vGj2ruys5ZFu+Fatl
 Zpm7Zn10oCxOXWL1PAQmd+XRcskPE5YSAjVM1a8OoUsiBgpEUoYyJ15p5a40BDMTrqb+
 /BVWO8rukWanYFW0a2/QPQB8DK06eu0zBnFxVOBkpoEsKy8bXhzIxzGOTIbhC1mMm3cQ
 1VHs5SGeu+DkHo5+SWMCN4MJDfKhQuj1jDdb7IaOfN0Lm0ejL4NxJzFk6ZqtXRKbDsHP
 5Dv7CI33kITcrD2+CDjgAu9AuAVh0t7APFp5z0WQ1hNhiBwukLO2jFBPv5d81XFdEFTL
 jkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584032; x=1788188832;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D1ntVSgy15eKu2z9M4XrELsSFWmxY1SnAlj7LbKRVb0=;
 b=K4BTJFAKSGeP5b/OGAQFid6XYJtH+qRIq1UwFFGkaqcw7SaUnqno3p9v2hEGvJ9WeV
 QTeGqbDpOwEafY8QjPkLSZMNmRoX1mUThfwdfm5RiXhtvStiF1SRWQpTkdwniN38JbTX
 yFL8d93EgsT6afQIiLPZtRB+eNiRqUa6g8yKNstZygFKqgW2PPdeNJGVzw3uZ7pcvGlt
 1PRSYK+lTTrJwGdFpuIdXNbuM5mY4KIDsQWp5we8phX9pUKHkpzEOA2TT54O25o3BZkM
 V71m5LV9EpjgDj+RZMLLGdH+wcVKS7Ve8ODkYqETv2wN2QxiBvhUvRU1Nt9UY9IzAjpj
 qMfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpivSP6X2Ls2gHjfxy5UIxYxDldTD1P82IsUi1O+xKbBxRLwLYXvTeU/IPGqzneEaxBhtpOk64kRX9LvYJr@lists.sourceforge.net
X-Gm-Message-State: AFuF++ntIBtbXMKAY9UQdysAILLEkdHeuUnKGzz090CXB17VIYZDezS5
 SE+UZjvX5A3bibtfAwin9suLsfhWrlXwUfI3Iiwd19pIpas3BvgP3iChsbWpyBCgv/xjW9TjP9x
 72lhMXxWaSB2eWiJDdWUvMdVdwibpVawDvumPi8doEDAxJNI/A+Ij0Y55nRxndaLgt4Hg
X-Gm-Gg: AR+sD10/vFzEU23DxIEwtcSLAvyA9jdh1bcfbFk/DLKWKym02w14YUAtGXaUj5LwtnL
 FuPMCC08XSe5M5oGKSywkNVdS0f6vcdn5+SlISbivzf+0fNLKMHkkZG5qSOa6TNPiAf6YtHleph
 XK7XJzJHrfYQpoFMm8TNwUA1xRHxodLsMz1BOOLuZypegxwQWCs7HZbiD3ebTI9hBN1ccTreMxD
 ohZnHwmDFVZ2Jn9vBYpWJFcPsr9vZRax0QGquXn1sgQ3dpZrMn/NejV080bJqHKmYbuFt+dPa9g
 0n0JdZ+xb6GeqjTo3md3zrKrSpTM4lYYVMzFPtsL7IZ40U9pvEFEsmJqjtd3kuUMalY6xsBIyA6
 JvoH972v3PGQbYfaErVJ10YNzdzTgwUvbi3S1VE4yMRwIbum0Q8Ti60LihwEeqGuYuHO8L7PFPx
 JRd8mQDuA6c+orG/1nzeGd3XmDHscW13MNyzPKJERJCa1GGIp+vRjz8ZfSMZRTNjDOjoyTMUh2n
 7zw/sazAxygU1err3UNJX0I/hV0gfeFid0az63RRP7VO2dit5hvXsINvIY2OmBXc5DwofC+JIGl
 czNhoWT/AIRI1LF6n+KdSjceBwspE/iUoUohQf4/86bTBQuP4QA=
X-Received: by 2002:a05:6402:4590:b0:6a0:a4ce:1b8e with SMTP id
 4fb4d7f45d1cf-6a42ee7b805mr31977750a12.0.1787584032179; 
 Mon, 24 Aug 2026 08:07:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e199ad5sm9279864a12.18.2026.08.24.08.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:07:11 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:07:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
X-Gerrit-Change-Number: 1756
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1756?usp=email>
X-Gerrit-Commit: d11705d04e99bdfd2027108761d6cb0c4974f081
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 15:07:10 +0000
In-Reply-To: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
References: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLklhNGE5YTZiYWZiNmJjYjNmZTMzMWE5MmNmYmI2NGJlNzhmNmFhMzNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c7b3f08e9db4f62eba8245e3758d128d5530115a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWGc-0004Ew-T2
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Allow to override the location of t_client_ips.rc
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6379888497209756916=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6379888497209756916==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JLzHM3x1WVE="; charset=UTF-8

--JLzHM3x1WVE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1756?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Allow to override the location of t_client_ips=2Erc
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

Fil=
e tests/update_t_client_ips=2Esh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1756/comment/b7eb4262_7a7a195d?usp=3Demail :
PS3, Line 4: # for later use=
=2E
> We probably want to keep a blank line between the comment describing =
the file and the grep below, ot [=E2=80=A6]
Done



-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
Ger=
rit-Change-Number: 1756
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-Comment-Date: Mon, 24 Aug 2026 15:07:10 +0000
Gerrit-HasComments: Ye=
s
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg=
>

--JLzHM3x1WVE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File tests/update_t_client_ips=2Esh:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1756/comment/b7eb4262_7a7a195d?usp=3Demail">Patch Set #3, Line 4:<=
/a> <code style=3D"font-family:monospace,monospace"># for later use=2E</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">We probably want to keep a blank line between the comment=
 describing the file and the grep below, ot [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1756?usp=3Demail">change 1756</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb=
64be78f6aa33a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 175=
6 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Mon, 24 Aug 2026 15:07:10 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--JLzHM3x1WVE=--


--===============6379888497209756916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6379888497209756916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6379888497209756916==--

