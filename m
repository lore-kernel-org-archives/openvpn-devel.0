Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C26C5CFDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YPrJgeKoUox2qzJoBZBBdC/uhChhn9iBbIgvDFwVYdI=; b=BTUVQanSD5jLz5gAFDgCT0baD1
	Fl4YNEYBsEP+7nVgVt2PhPvL5/uYotH5W4ukyGp4CE7pCUI0Kj3ixaY2BnhMIqwHQjD7SCAXantYw
	4vNvUFIM9rC2PWoD8xdh7xJ5cKfBhpb+VSaUFainVpzjP9iam66/zDITNstgKtMJp0Bo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wur73-0002Z5-ST;
	Fri, 14 Aug 2026 12:34:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wur73-0002Yz-0n
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 12:34:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=skRFIR7jwQl/CfZVS6+h5fGIO4ZFjT90gJ0oB/iESSI=; b=gEta3ydirWr2ozGt4iVy2lPB+y
 kVf2/8UwkPF3toM6DVg4Ti/rxWsTlali8byjXsWVnhl6Koyo0ANpPRaclkDcpuuz6Qnl//2hWMBuk
 DRLLqA6yzZ3RJJcmVoXAcO0+2BRf5oGtl7ELJf9K9IxIGMeeXNh689a0vRxW21lsOJ6M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=skRFIR7jwQl/CfZVS6+h5fGIO4ZFjT90gJ0oB/iESSI=; b=N
 oZXdNexiaMOigQJfNfiXtBI5h5EwplmAVOsx0BUwSazOhPN8X1ypfh2rYgRN39pF6mmFkExQTyTvX
 GV5Do2vtudv47bLLmuRpagL9uqgEILGL5Bo3bxIV/Ko50N5swB3h4TGf1sqZZyonM7ok/WXVBFLpG
 WgrwE3Ucw91FsO68=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wur70-00072n-PC for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 12:34:14 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so515356f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786710845; x=1787315645; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=skRFIR7jwQl/CfZVS6+h5fGIO4ZFjT90gJ0oB/iESSI=;
 b=Bc3Mj0O41t6CSvG1MZOWgqVJiuya68YnmgiavM7L4r3wbXzmhyMJo3eaUkN4dWkos1
 rcg5h1IVQ3smGzNVdSn8dmKM1lcWxiPCEPEUWAOl6asLHyUoKAukRTqxwRqBd5HRIh/V
 z/fvaL1p19R7I6YwB0GWMJJf610FnywyOJPODZZL9HgrtMZMiIWGw96S8+yn3R+76SjQ
 sMlww/RLu1eyBI2MTsF+ie6API6NVFFyg600XBsygZ/03JKzulNf4qp/HeInmqfSyEKt
 Ljw0gV/n5EIdOLFsbhFmrvf6cNNvwPmsz/Uoua8RN9hJWGqB/tPD9Cop/uSYfyIdVZEN
 sclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786710845; x=1787315645;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=skRFIR7jwQl/CfZVS6+h5fGIO4ZFjT90gJ0oB/iESSI=;
 b=iBnMT0LB8y/myPcfSCoXysnpKbdo8Mh/xC79JAmf/yx1w4JkPFCT1A8rq5ejpodblj
 j1+gQXil7nTmX72+Ifxdx5VstssMC5C1OyHGkoGHn4omYgRTZfaeD4+wKCmsvZbyYbLU
 4WWT933hSkDGMJpcrYbWLv5FM009Kc9zCPB73evLqw/cBgPtJxYPVll2PDHYBYHIxLOH
 kRzS3Zw8vD8YdWo+dOtZJJkG/rGb48eRgxJ02lh0a2DvAL/K/g897Nnw8HR/jF9N/E5z
 9wuVtU+cLHbh3vYECjnWBOV81twm7ZVO4mTjJAS6ri+UzMnLGr393sJCz6WiA8THhUg6
 MKjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rotv20HWGabfJoXNhIiash3VTtxKPM2XaXAw8cH7g98lTCByhDr7QtsJdy6iTZNK5O2BbCJx/x/KZbi6THL@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz8qwHGdL6bVgKpBJp/UMPAc7S62N9w8USyf0voUuNQFBhi4Ycl
 HTw6zFGBr2DgBN5708FTzoy2g+smvHyndGJhVOLX7x/WtK65wUGpqtdUMzTtay8tr4KKy9YBnjq
 FsoFWjILcoLFLYtIEI+HaXd43AAhRoe+PfG8t5f62dhzx4RXbEZipkYrvS8DOr/MJM+sw+FdCuE
 BQGd4Dxw==
X-Gm-Gg: AR+sD12Ga8rYBtKc3WPApnoKLalWcDajFhorVA3Bvu1/FbC275Fy854iGtxdLMnnMQz
 iWUbbzO5Uvr8TUdtdN2DODkuoFcuEtuVHI1kzo78R0JsA6QWwUfSHAzctnx0odMronmFFCGcZyA
 OLjmBOn5XTy6HCl3TdmwWdDyBtuBasSycpvIuBUlf4De/u0AfpGKWTd3xcLrxIHbnCPCyuICcNm
 EuKnJnl+Rl+OamgnvGPMxR1KS6vw5O0r8Eb12k3Tqeyg3GpvgZojkvqqm12RoWsyU9t3LgX4WAn
 1sK67xE1KaY5JOLm9uQYQhQe5tRmBMZBj3LCyoS+F1TXodRh+j0YXjl095bGbmuLJwTqke3zi+8
 L4C0vAUBNuTVrrhJgnRFEPZUL2CRnPycCedtnCDLEHZTVRudrC9DZEKWq7wW/3NKpSHgsKnRm9I
 j/dUz0TVU01xn7ilPcl3ptLA6ARLnnUwFzKdxV+EP+6i9jmKK6pHVo9/qaxanVMAvs5OJbtMVkV
 +U52DrihncVsz38vnLelElOkO/kXusjK1WaO17B9kWcBZvitFa3hCAClQYG7N+XmYzUtk3pS965
 AUFEeUgxY4WZFoa3KElh9oQ40cPb4G+8GMnB2W+cVLarFd0dGU8=
X-Received: by 2002:a05:6000:2203:b0:47f:6981:a043 with SMTP id
 ffacd0b85a97d-48160781cf5mr8131581f8f.26.1786710844460; 
 Fri, 14 Aug 2026 05:34:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2cdc9fsm7795275f8f.37.2026.08.14.05.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 05:34:04 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 12:34:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: ed759afec30cf6e1ce9c06af92679a17afdc89f1
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 12:34:02 +0000
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <850f3250d4ed7d0ecbdf54c76c9945b80d0a1a52-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wur70-00072n-PC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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
Content-Type: multipart/mixed; boundary="===============8282769126317086288=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8282769126317086288==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QiRjxn6ZgLo="; charset=UTF-8

--QiRjxn6ZgLo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1618?usp=3Demail )

Change subject: Rename variables =
that shadow other variables or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13:

(2 comments)

File src/openvpn=
/options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/89261=
cd5_3a939032?usp=3Demail :
PS13, Line 3670:             struct dns_domain *=
new =3D *entry;
Ouch! It might be a good idea to have an official guideline=
 to not use C++ keywords as variable names, so we won't have to do special =
macro tricks if we need to `#include` OpenVPN C code in C++ code=2E


File =
src/openvpn/ps=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment=
/76b9fc9f_6e56ef87?usp=3Demail :
PS13, Line 878:             msg(M_ERR, "PO=
RT SHARE: unexpected init recv_control status=3D%d", status);
But now we ar=
e probably printing the wrong `status` variable here=2E A change like this =
needs to carefully check if removing the shadow warning doesn't make subseq=
uent code wrongly reference the "parent" variable=2E



-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33=

Gerrit-Change-Number: 1618
Gerrit-PatchSet: 13
Gerrit-Owner: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Fri, 14 Aug 2026 12:34:02 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--QiRjxn6ZgLo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1618/comment/89261cd5_3a939032?usp=3Demail">Patch Set #13, Line 367=
0:</a> <code style=3D"font-family:monospace,monospace">            struct d=
ns_domain *new =3D *entry;</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Ouch! It might be a good idea to have=
 an official guideline to not use C++ keywords as variable names, so we won=
&#39;t have to do special macro tricks if we need to `#include` OpenVPN C c=
ode in C++ code=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/ps=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/76b9fc=
9f_6e56ef87?usp=3Demail">Patch Set #13, Line 878:</a> <code style=3D"font-f=
amily:monospace,monospace">            msg(M_ERR, &quot;PORT SHARE: unexpec=
ted init recv_control status=3D%d&quot;, status);</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">But now we are=
 probably printing the wrong `status` variable here=2E A change like this n=
eeds to carefully check if removing the shadow warning doesn&#39;t make sub=
sequent code wrongly reference the &quot;parent&quot; variable=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1618?usp=3Demail">change 1618</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1618?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2=
e33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1618 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Fri, 14 Aug 2026 12:34:02 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>

</body></html>
--QiRjxn6ZgLo=--


--===============8282769126317086288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8282769126317086288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8282769126317086288==--

