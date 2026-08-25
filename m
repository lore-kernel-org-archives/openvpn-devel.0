Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA765C5DF94
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M3wVDniExFeUQ2/43SNkFFSRK7TsbxIJoQXCPK9MFmY=; b=A9nl1w3fFzSzcuyfx07CAYqgCv
	vy3nftZQtJus4cMzJrZpvB2OVIhHje/5uTw9HAH2/oAyjk3yE3KvqCUbad0Sj2TYN/wlqVu9G70kw
	zkRUMy26ISTHoEVxNTQ+tKhucy8MOOOsdToxIZgnbWH2b92czMTnGCseq8mH+0X0FyA4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylIp-0003Zn-7s;
	Tue, 25 Aug 2026 07:10:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wylIn-0003Zh-OA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:10:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=t4bJJBJ1RFPx6O57I6w3ePKqe1tMmYFFghfgk1tazK0=; b=U2fhq2zJ3ltdzZ6MnBnqwCOfT+
 LSilM7LuYba/UdnCB7QC9nN3MMNulWpHV6NiUJmA9YQck6Rc6RgIUUN8PMiYvW7+gfEishY2sR46B
 ImwDuJvDwVoLRznevKZAP8wUnTu1IK0cQI46VImEdb1aDR4qQDgPt4czFmC20BOItl5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=t4bJJBJ1RFPx6O57I6w3ePKqe1tMmYFFghfgk1tazK0=; b=g
 H2m2zHvmJeRQwzawFkeEkBgzq9WQeddwnbm12jvMRkm7Zs3odsB0u1NbDpQxyd8XMr6GHF7FKEnE8
 p1UhDDPs81g+zMy/dyNIQKePcdnD3U8GQgNMTkjB1wPaqp3qTImW5mzDOict+xsA7B/ran6UFO9gJ
 pzPrkIEEgw0jKCK4=;
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wylIl-00087C-4t for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:10:34 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so664386566b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787641824; x=1788246624; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t4bJJBJ1RFPx6O57I6w3ePKqe1tMmYFFghfgk1tazK0=;
 b=AasTU4Fz0Is7OvfUfd4vP4KJUyS7hehaOcsnF15CVGYggkT/HvbNBql695xh/kaf/X
 jh6Mof0UHNg1pAq7YZOG6FKWgnc8Z9HGZogf+OuCinT0vkKDh6l954O8FPKCXLVz9mUF
 6evZSrHITUdWeGe5Ud50C28o9WT9y5TnAaMGPk9mau4xvOpvDFiD4hHt//euJGjfsLB3
 fQLRkmQf2A12iRsAE+3RS1eAJXja0eSXrRHe9cR10eIIonARoqqc7Cms8tEcvPf5iiVu
 j3RSA3VoFM+KWch0HTmgyiPu3lpNQBtDOSZHI+3mQWZHrUfL71J/NzBo/AdeDtIQjxP3
 kPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787641824; x=1788246624;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t4bJJBJ1RFPx6O57I6w3ePKqe1tMmYFFghfgk1tazK0=;
 b=b2mnwzzDMk3/sizlhxZ2ODSFbQIfFLNdPj57EizgZQGbK+dmTSh6xt80pyJJAfpwu5
 Fnmph7lH3uW46zpSyXSXJqn+PpTglJsRChdM80mgjWBHCkK4dmOnPpNYCqJYIiw+DMTR
 oqnXJCSFeoKMafiibTJwg5eXcHVzUvu4LRcH2hHicIluAjNAqKZtI5yCF7s2lTPlWBFy
 TgSC9dFcP3Y3Q85DT3mS8gmqtlxIDsg1M/l8xic7hsC8Ojvxqg8hJV2zplJWTms2Vk6W
 BmBQvfnmDXu+pElMeCEQCC4PnLY8mR73NgX8TA7yzymch1C5zadzwpKPFfrBBi4XUlv8
 /Ddw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrl+4owvtvQSZDlw6FiwhX7SPZlgkR5K3VrNoKOMO/EvGg5UGbgJu4ORcMxg99IPqX7A4C0dPgQG9VM3Qrp@lists.sourceforge.net
X-Gm-Message-State: AFuF++l/0MPSEAaPnDFPmtCCO+lpXZZ6NZte9wftQSOGvSAHTtKghirg
 gwISTMzlx339fpXCIT+zM1D7NiPyeWwMML9XV+fXc5xf2lDGb7V3SymmPWV4xDjA1x2SXJADIpZ
 3H22oFIMRNjnEjpU1VyhHMQaz6qOgwrfQ69MvVdggTsJARuX08Q0Lx6y6l9agBHL+1SmY
X-Gm-Gg: AR+sD1234u/IWLiUDTeHXPKMtaqwHKRHQB8TjkjK1fSMCBB7u7AB6VATPUQxVl7lcdL
 6EmvqU6YHPKfO+Y2ECJq8576bDOfn7lwxSCuWE0ln4DQD7ns25Kg04WxBAndf1JMRRhO20suxiF
 IaI2lgCH8wh2LQ6+LsnOjnIuffVcj+L9wJC0l9A2mKjJW8Lqs39u9mzZTSE4uAdbC2bTNL10WDx
 FTN4XqpoLhXZNXSVzjjZG4g7mz85L4Hbs1XoliztYS2TlEYGINzbZEz8B03o5bQxW7uAOkVx/Md
 jIUIXR54lN/4JvdJVmAKCU45HQlYDGW5K1GvA/L18fddc0bZinVGaYy8/FP3isq+s+1SoLJjTB5
 fJXVEjnGKS8Zf7OiXdjA86JjJ83JV58efGOb4sOM9ZUcI5hsmE3uVXRGQYTwJo7pMAL/KlLlZZU
 HEhN1BGDOADt2/gCLazz0HT1BGPXz1LrIjgPCJ639c4lRZ4kddqM34U7rNzpHbYwOPkKxObghDz
 +IQCEcMNTXAE//OUKfs+g1D+p371AIAkcTkoRclU/BxHyVOq5vxxz7MJ0HcFeVDiSwRnmwSgkPC
 dxI/e6MpjHgJ5ZNm6DtM3QVYhZQoFm51rZBLZMvCGIuiClTm/Xw=
X-Received: by 2002:a17:907:934d:b0:c20:9447:bd5e with SMTP id
 a640c23a62f3a-c246a5f6d65mr3585240266b.9.1787641824390; 
 Tue, 25 Aug 2026 00:10:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e00129fsm15194909a12.1.2026.08.25.00.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:10:23 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:10:19 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
X-Gerrit-Change-Number: 1585
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1585?usp=email>
X-Gerrit-Commit: 191008d2ddc2c92f584bb9484bceb4193eaaf661
X-Gerrit-Comment-Date: Tue, 25 Aug 2026 07:10:19 +0000
In-Reply-To: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
References: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0MjY4NDg2MDAwLkk1Mjc3Mzc2NGUwZjQwNTZmZTUzNjc5MThhOWIyZTY3MjBiMTY1YzIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c46118c11fa4f5435047a629d2b23d6ebe19ed36-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wylIl-00087C-4t
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dev-tools: Add new
 script to convert mails to Gerrit patches
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
Content-Type: multipart/mixed; boundary="===============3259799241838027373=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3259799241838027373==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rq1qhVTsnnk="; charset=UTF-8

--rq1qhVTsnnk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1585?usp=3Demail )

Change subject: dev-tools: Add ne=
w script to convert mails to Gerrit patches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b=
165c21
Gerrit-Change-Number: 1585
Gerrit-PatchSet: 2
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 25 Aug 2026 07:10:19 +0000
Gerri=
t-HasComments: No
Gerrit-Has-Labels: Yes

--rq1qhVTsnnk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail">change 1585=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5277=
3764e0f4056fe5367918a9b2e6720b165c21 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1585 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 25 Aug 2026 07:=
10:19 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--rq1qhVTsnnk=--


--===============3259799241838027373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3259799241838027373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3259799241838027373==--

