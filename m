Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2069C9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pytDnVc0h6f0KWHnfkegHljds01tyMrOrQS9cE7uvXM=; b=OCNTdzAd5fAq2I4rk4SOMnT83B
	iZ3LrOpz70MaFqjjJ2p+dF8oBf1Tn40GeeV5QViluLqGiCBqGckM3VJic8iInMn0q4sTZv9fKRbDb
	fR0AhS0FG8T8RfzP2RK0xkDLapQymK+tKXBFl0TlTAC4YdebwzO/gPbv8AXR0RtF6Kgg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA9zz-0003hi-4Z;
	Fri, 25 Sep 2026 17:46:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA9zv-0003hZ-OR
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 17:46:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=snxm49TXsFtfYUBzSmtQIafZr1huFs65wPAjOwjEnyo=; b=fQvdtWpSwwuPbShHhGC5MyfF3Y
 sFRA1njZNMtSpc+0AMg8H+NlEEyma0ljBusX1P4Prd86354jCHeqPkprK/XU5EJmgk8ifNbTj1CJc
 gaBtMGgqw8CwPxDclmvFSZgg0xWFYvTIWcj+9f5F6dReq5ZXHE6hUEvBTkOYyWFTpYxI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=snxm49TXsFtfYUBzSmtQIafZr1huFs65wPAjOwjEnyo=; b=f
 Mw/v8NL97d0ILskpxqgzEDWGrWVnqAUkPLPtU6ELmM8sZZJ8bVnTibcnlrKMuYBebkgm8Vs/Oysnx
 xjakLNMKDIvs0tsy0hfqhZW9J7P/gtn6DvTvVijcSihOEKg08vMvuwusCiYtTOmmTsoFBS/jbyfMe
 q6KkG+WQlZ+2w21s=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA9zs-0003yJ-Am for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 17:46:09 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so7188975e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790358362; x=1790963162; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=snxm49TXsFtfYUBzSmtQIafZr1huFs65wPAjOwjEnyo=;
 b=eP58BFVux9A0USHRZ/ep+yg4q/MfKSbHUU/FkZKeptZ7iLU+/vinWjbaq2CpXo4FJd
 zKsCcWfEtQyOmcfzjw/XaLzPhBog63uN79A6X2NOjpRkNMSUolsrtaWhU0UZpFSWCChQ
 LITr+Q6kn1XGsCcRPurzkTQoWAp+pfG6F3A9MjLdzrAEOnJTvrW6WBzwzxuI1XJ59ekX
 DlAcbjJCo+R9SX8OrGJvKwUMxAA5S/lF6qKEJpvd59sO4SU98UFbBi99CNU4U5sfZG1C
 lkArJp3JRV/dzrW+V7GKj/2zlEay8/5VmwRoXTNSGjqNBogM0sGYokEpXDjgg1PC0E5o
 TGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358362; x=1790963162;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=snxm49TXsFtfYUBzSmtQIafZr1huFs65wPAjOwjEnyo=;
 b=D7KdIgI8alosV56mvAc4lYlGMDAuY1KfwLXI0bQ8YU2CrUBtpO0RyFePAg4K53rT1J
 ghd9Jafq9c7b0bb1gSwGj9v9SnEAMSYbzLYI9QNB1ctZpVaiGLGxGKly7JXQe/1rp1Xm
 pONH+f25KxFDOWH11YEIG15CQag5fnS1uPsBz9f+NFarUP/pW9cEUFyAUwDZiMEdVrwu
 DwUVm6HsRSSJXxe59gHd+TQOwYiRxoxx6GNLjWt+1ElUgw95PoNm9usE9i4k4WASj98q
 s8lDOeeEmPZ+++KvmAF2jnTGxag09ip0c7KcRNOqgjNdB+rfigt0OAryqe3yQZUXVHwa
 yhjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3+mZY7zoW5dd8a3xgxAbfeB4mj6E3O0TpY5lIEicbt6stov2tqD4p74OIAATvpKwoqzL0p9v9gwNkr/6l@lists.sourceforge.net
X-Gm-Message-State: AFuF++k9CE6WgzOvtPDaUlRn6Zv2o26/6UMAjQ5WG05On9ZOpJ4Pz55t
 aGbyXIKYfe5hUFL/q1kgmnyo7Cf72qsvKfFYqNfJBUEsq3oVeG46ltzm+Mx1aU5XaH3YVCOe6CQ
 jCnGJZSIoMJuOrt6irTMSKy2JU5pRP8mZyOAi3m+ezKRN48JeLdWemG5rEZF1PXgXo5O6
X-Gm-Gg: AYBFou0sDskE9VZBJ32GRh7ptZkBnojjd+6mLISc4f/4VOr0PmezDHjujSMT9ssgXw9
 uJ4PBhX200Q2HEMcyd/qNT11XHp0vRvvWkZGCSkVw3yJUAltHefE6aTMRvwQoxKXA188H4eEsPx
 JwK5h3G4/4tqLY+fsJkPicKpKLe5LUJbZ+SVI7YnmeOiMDP4G7jsZSk8zfEV/kV+eaiAVsbtJT8
 14l0IR1ikFiHQuyjDloCZ64hQRD+gih4wIg6F/C8P2H0b71/znNwK5inKeVjnWAZngM2X+1IAtw
 evi+ffPhvRNSFxxpVOdcEOvud+0FV30KEnbRsv9WpGHVJ5i289o21vWe6sFFWz1n/unIw6xzG1O
 OKwEGNRXrS1eVeGrB39Gnv5uTFuh9Ei0qqhoWGqsYGbjzCQ74JNwGCY6Jp6+Zxmp59Lcn1phAVn
 uSUnfr/bkmfvzIGrkFSy9FUtts6JFpQCFx42h8Bao9YZyHWB/c8avhSwsMK0yxkcwv9P9Be7KY3
 T8FJVhJ0TY5+4hxomttLxyLRZxR9fYbSzcP4rX6nzwROXedNf1z+Bz6Bl2/8OG5ia3nL/uZOBVn
 6bU2fr/1+Qo1QlL7K8zEPHx4WbibNVU6EqNr1oyA9rnrxPOO+tqIsFtbgpww
X-Received: by 2002:a05:600c:348a:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-49fe6705942mr108255725e9.30.1790358361651; 
 Fri, 25 Sep 2026 10:46:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff06bdd11sm77626785e9.9.2026.09.25.10.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:46:01 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 17:45:59 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
X-Gerrit-Change-Number: 1953
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1953?usp=email>
X-Gerrit-Commit: 3262f93a6a2b812f996b2686ad87b5d993cbfb1b
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 17:45:59 +0000
In-Reply-To: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
References: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzUyNTc3MDAwLkllMDZkMzU0M2QwYTVkNGNhM2QzZmQ2ZjQxNDk4ZTY5MTdhYjRjOGE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e9a81f6d0891ccb3cf7be9831274d90caab36c5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA9zs-0003yJ-Am
Subject: [Openvpn-devel] [L] Change in openvpn[master]: cppcheck: Clean up
 suppressions to not annoy developers
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0440595818071946612=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0440595818071946612==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jeJNGre4xxY="; charset=UTF-8

--jeJNGre4xxY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1953?usp=3Demail )

Change subject: cppcheck: Clean u=
p suppressions to not annoy developers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9=

Gerrit-Change-Number: 1953
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Comment-Date: Fri, 25 Sep 2026 17:45:59 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--jeJNGre4xxY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc has posted=
 comments on this change by flichtenheld=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Demail">change 1953</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie06d3543=
d0a5d4ca3d3fd6f41498e6917ab4c8a9 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1953 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Fri, 25 Sep 2026 17:45:59 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--jeJNGre4xxY=--


--===============0440595818071946612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0440595818071946612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0440595818071946612==--

