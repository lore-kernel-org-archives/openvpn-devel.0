Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAC6C43602
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCh+ULnQpKoKEHzQzmk3AhkAqyp0Ogc705ChK+4m1vk=; b=VMrNUpwjx4K60lOT9Kuqf1zlBR
	OaMt4dtLsv9a7QsuP5AfOQT95cethKRgqFH4+PymY+UpICCdNv7bYTSKxBhaGrwCqCBIsDLoxlkgW
	osgWmki/ShYb+qU81k+UIAYEWVuEa7Qze4ylz9M6ectSgDmJm64wdIzvq9/H/6Kh0DYg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfEKG-0003Mg-7L;
	Thu, 02 Jul 2026 10:07:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfEJw-0003MF-MH
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TlGzgr+7nGbZ5yt226TfZ8IOif7RqYrQLX3EIkeeyTM=; b=cwEoxLDH0ASg/8FrjYyrMhOkXk
 OS7eiC1aUuQjgj40gkizGbc0WZ2X83SBAqKJ8pmMSE5bnRjgdzPPRFMUvymNIBBgxFuBz8tw88JBo
 rTSc3ieu7zFW4h4Pal4uhnrVc3PiOSJ5uzHUWtrWZY+vOrTOp1f15eJ0tNCI5498OhF8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TlGzgr+7nGbZ5yt226TfZ8IOif7RqYrQLX3EIkeeyTM=; b=X
 NYKRQX/B3RQXf5RcWn9ahtyIJo9k1HtsMw0OCSGDerNMzc/grnWqqryrQT4tJnX8tOVG9GbX01Tw1
 EX8IPutVgQZZ47g4HKTwZha4IoQwE5aDf0JrOrbe4mXDYvqsQU7bvQHLwqV3kqjsYkzAEQghOPrQf
 qor4qXm0AsMAKbTM=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfEJu-00074Y-4J for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:06:59 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so1531784f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782986807; x=1783591607; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TlGzgr+7nGbZ5yt226TfZ8IOif7RqYrQLX3EIkeeyTM=;
 b=g2n30J/K/NTrP/pRUV7x73yGu/ge9BYBNTPtUh07CdknorC2GzqbbQ6SCKfTGCR2Mg
 TdMZ4aBD44st9hWLnFP2XVDOKFBv9qQCZyKOj8ZobCUpFiNdgkJGXAoJ9u7JVjhBZcQZ
 DwR3dHWx1xIixY2ZPbH6KNiHwjXHFUPnINIzyxMZIarJIJu0CeytcrAg9m2o656p2O9m
 zX37f/KcEVyLlNo30tVSu7EzMR9bh6i3KfsGTZheAFf5BFCXJDFxc79zTAdS/2L83ObX
 xzanWzfnqO03FqjufFhCDwg7TlUThGGQsROMceipNQypyiOlXmZzTmi04RC5dofCtgQv
 4ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782986807; x=1783591607;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TlGzgr+7nGbZ5yt226TfZ8IOif7RqYrQLX3EIkeeyTM=;
 b=kqMC5XVVpW4Bs51F2LHBjB+QdluEjPtWEc26QTm047kbANetd6jSPgYcsRM4gf3Qrr
 rLBwKJdcGHqptKcDMYkrTUtXyOFgxjum/RFphFX1wOQoNJCcmlRaAMbcWuqTttH/2BiS
 /H3YavkZqxJOM0c28SJfx+OaCyQC0b+jtDd/U727pN1HGhlsuVqUvvIYVl6H6/HP6rJc
 frT3zXwSxNwBqkZJKrFnZvSkZFRxN0M0Tyoj4+lZqfVroGJ4tzvRoZaDu40U+x5zxQVm
 adZa6UNZD/4D8hff2VvtT+zG3dnLqPh2ruJp5g0nXOAmmBP3+kYp+BSTr9PDoR0FZ30H
 SjDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdAsVGgtvMl2XBacGDuvSvpOIqV7YmGdmx8m718r+FYeC0WyzdnAzebbpE1PhA40E/cDw7lGY+g3/mxYJZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzEPmwtptOD9PFCVgOPWWG1Mg1EWXn3DAcwmrgBTERfCR4jlwob
 WaEgNy/rUgyzI+Xi1RwppUHdQ+BfUkxSXbWZXbtZB+/QmADCxK26IZtNzY6P6C6ShWU/WvjIiko
 db1EPXMolbZSVL3ItiWf2571bTH1Kz3YE7+w26tHsY3d/uDb4AKZYcD794RfmWitSsPuQMdnFdb
 LxRSNPKQ==
X-Gm-Gg: AfdE7cm/0J/3BZFRO5f7XdVsAysXXacIPf7PhMEADw79RPE32An8fRr2a+gkCiiWf4v
 6sxRbcL6hOE7CxXSztdgTl/P/GTEw5O4CB0tHufDkGNuhifhU53+JtcZlIQT5nmoogXbwb0EMVK
 XefDkwiy+USvZLTd3JShfj6DV9gjxaNerVq/t32YzAT5GxhuMZI4tTk33csWDTNs/k6f+ACMgVE
 TcoW499+8T5zlP2Sva/VTCXeXuM+Er+wa6WhKdjI3/YGxkCbq/du19kzmNFNk63wi7IoMzWwYV3
 x5IpXEdLZeg6uA5yUZ+MIzM0FEVIFhb4MIFiecXNAz+oP2xufD5oYv31RkJzlRHVnwIjn4280r9
 JTx8VXEUqtHbWE7Yjrfopt6cSddXpquJhp5slU9gTlUgZVJr+cuwIeoZSbrMKeDbZuDAhlsHXuG
 y/wg5f+coVVbR2zVjx3HGTFG4FwlY9GpnMrA1TPxQTFrk2yOuJjThp580jy+D3FzTS61W2nfIwv
 FQUDj2kQ7ryIuQcpbigYF8n0Y0VlsxkVGMSgD9I8ZyQUv8LlTLgSHt0k41aT79rikuvnjRzp5gq
 VIY=
X-Received: by 2002:a5d:4563:0:b0:474:d23e:fa8d with SMTP id
 ffacd0b85a97d-4775c3c9a88mr6499285f8f.40.1782986806801; 
 Thu, 02 Jul 2026 03:06:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3db964sm7299722f8f.8.2026.07.02.03.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 03:06:46 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 10:06:44 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7
X-Gerrit-Change-Number: 1765
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1765?usp=email>
X-Gerrit-Commit: 26690394b5de8bc95140331a0308f515f5de80f8
X-Gerrit-Comment-Date: Thu, 2 Jul 2026 10:06:44 +0000
In-Reply-To: <gerrit.1782986182000.I20cc89a546b69aceadcd1630828de407d530d7c7@gerrit.openvpn.net>
References: <gerrit.1782986182000.I20cc89a546b69aceadcd1630828de407d530d7c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTg2MTgyMDAwLkkyMGNjODlhNTQ2YjY5YWNlYWRjZDE2MzA4MjhkZTQwN2Q1MzBkN2M3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cc8c07ed1b495a7f50a7ed1400b6533ee63a4e0f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfEJu-00074Y-4J
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_pkt: Fix
 doxygen warning about read_control_auth
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3850712806251424929=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3850712806251424929==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jXz194bC2BI="; charset=UTF-8

--jXz194bC2BI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1765?usp=3Demail )

Change subject: ssl_pkt: Fix doxyge=
n warning about read_control_auth
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7
Ge=
rrit-Change-Number: 1765
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Thu, 02 Jul 2026 10:06:44 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--jXz194bC2BI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3Demail">change 1765=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I20cc=
89a546b69aceadcd1630828de407d530d7c7 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1765 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 02 Jul 2026 10:=
06:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--jXz194bC2BI=--


--===============3850712806251424929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3850712806251424929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3850712806251424929==--

