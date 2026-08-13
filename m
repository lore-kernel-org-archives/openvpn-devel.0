Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF93BC5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V7Xc4HS1h7riqWZZxVtH7CzIlj7jeW/oNUdB3EaprOQ=; b=jZycbv91l2K7DmJqHQM4mVjg7Q
	UD4sVGPo5e7NQh16Hm8q/ArSeCP4lxk+OxclNXEOfZNVe+tjXO40hsBRcjNcLRXGweT5b4j4QFmCv
	X5FZU06Z38j/pTg+ij/5UH8tsMDTSt1c+KyWF6Px+1Dsi5gGR4tsUQ2VsSwxCfH+HHYE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuZO4-0000f5-I7;
	Thu, 13 Aug 2026 17:38:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuZO4-0000ex-3B
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:38:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2A5RublFoZ1RsU5ehJdY5BoKd2488U4DsFTLEFNbfsw=; b=m6/9mldKbv8H+SieVyngSbI48g
 zClM4G6cB9DFtjXF0P3wbLvxta3Ws2Cn00dTsqxUdl7mriDrPoUOCpaaTO+SaD0p739At2JmjeLeF
 8RrWDmMZAiw2mRyEVOFfb/9mh7pbVQtHg7sosOKrFrzHKzncEz4wzEEWVEQQragtio6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2A5RublFoZ1RsU5ehJdY5BoKd2488U4DsFTLEFNbfsw=; b=d
 xaBm8MclkjsWs+Op1/fsNsHqpEZNUiZAGx/716u6It455Uu+WDfcy1deSnhVOA/8bb+b8Gw5fbfe9
 FqMaqShA/1zqm7uoCMBwKlpx+6HexvTZZNdAdY4zLob/ypR6rCSARkCMLlA5JtHkB1wz580/4wV34
 /wEW0rwRN4RSyCdk=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuZO2-0000YH-Uz for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:38:36 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-476a130c138so94197f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786642709; x=1787247509; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2A5RublFoZ1RsU5ehJdY5BoKd2488U4DsFTLEFNbfsw=;
 b=GG5LkT3C4vnUxEE+rpE0haPy5hHjEAeMlroJw3sJ8TA1RiN6/+dYMt+PqzlsHEElAY
 4na6+1hhO6wxYc3CuNbD5wlBsOLqID8gqqdUuqiMRQc5GtL12YPE1GG5urx5ei3eHVSk
 HQGIfkPL001sSJUSNZ2H58BEWJcylKo7wGHOOJc5TOOjhMX+zDpNdj/XCppd6sC7JXfF
 Bt2NrQqpmG4lkCT/tlFTPhi/Q2lAo91RNueXYl0Lj727QfmTCbsDklTI03mTg8S3wKr1
 PFviyyxknsSb8TU1lsxx778AaKX2wJR5eDz5HJPxmcUZdKPlXF+t97vuTl1wapRgkFjQ
 6lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786642709; x=1787247509;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2A5RublFoZ1RsU5ehJdY5BoKd2488U4DsFTLEFNbfsw=;
 b=jmQqhZ8J5uATbqfF65WIrSbJf7bzHkR0YHlI2hIbTi2eNNrGpKP9T8MOyNHKBqQAju
 4MUp9uNmafq4P1hSKGGmlYEKGkqxSQcObiIJnDZecKunqX0HL9Ruy99iqeK08oc/ia2C
 Egt9ixInEtkkSCBB5BQ+cWmIKYrc3NzTzAEtNaLkGs/5l2zP+OXYyxwPAdyDxRbJu8HB
 8BSrAps8UzYtool4QIKk5alTaE3Gu00fGzEZWWkz7Eral4qoqLL55K9YwH4JRwUBsBIc
 nxyQjKKATBbyJBJWxNTAGTlZomGeI9V+Tmb8+eG8uKmPa+80DQbp6Ohff7SheDNZ/1Vw
 6HJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RolpphdIshDMXOsN0HYp5rZqwt6Kqpdu49zw8L3i3Q+GTbws9d/+dCvC6k4mOubNI/9cKovhcT6JGMA/+P2@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxgaSiGdBuQNmUIpux7Szr6vgpMfrxNTGAxysHWgpzXEH5qa0Dr
 rczq9aoKgrZCtQSOKOq8VlVQUcmVDiYTTfCGFrE39WzpaqqUeT00I/LU5bTfDDSNtmZO4yIj+d9
 j8R/L8tEv2CNcosIz5Uo7kOzeBJJxoH66IQHFAmJ+1wPrPyP5L8zuDBUxAslssZLVqefO
X-Gm-Gg: AR+sD11Iwr/tFQS+u3lXnWl7PIzgGCOlDaS+n9v27q/NdkFukxohijA/mxBrKFyBJWx
 eaHe6Y0vT48o+FmiSotjX0FWY8IaLoWvdkm7cQ/aH5o6eA82ftHPEU4g1aNRp4UezI/cLGoG1vW
 E1yqDctz/99ZV94Vu3U56Y82qYhXO5qWPd2vUb65sahCJAYFu3UsDNXnk9voS6s8a0rE+iTHbrO
 yRQomsWnJogs3S1TErhnmDfTGTjAxskZA9+a+cHxOo02HGmFopen4TM1rslqiDaoK4GPdnWjBJX
 QVw/f9gK/46ngbPL6G757/gpD/7CNca7a4acgeiiVW8/IjIF4Yz6VlBexKU44gKyjxwz90FOMN4
 XM7GCVHlfbOsC5pF66NcNs5vAmZWHV1BFqUZGQ+YyuYjDTzhLIdoimlbrBWc62E1g9/MkMYphgD
 Po70bjkYXyTBiDlVhwHya4x6fpLJGewOFYDU5knpPie9inYXpJ6PiXM6z0lo+sf4a6s+LX7F676
 /EVFzssTYTI7NTWeix8l0B5Yym0z+gxJNXW1aXT7DyzGDOIF5qSOUVsPAJqRX6/MpXr2llADGAr
 ShRCIBTLO8MKRZsHYBPMElawLzmhlZWAV92wEuDPRTuvGalO49nP5f7jlDxknQ==
X-Received: by 2002:a05:6000:25e2:b0:47f:673c:42cc with SMTP id
 ffacd0b85a97d-4815a005d9emr11812829f8f.27.1786642708279; 
 Thu, 13 Aug 2026 10:38:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c1307sm887630f8f.27.2026.08.13.10.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:38:27 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 17:38:26 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881
X-Gerrit-Change-Number: 1480
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1480?usp=email>
X-Gerrit-Commit: c5a2a246de3ce11e6d856e4a2b078a2359673d83
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 17:38:26 +0000
In-Reply-To: <gerrit.1768911587000.Iac4af315c6d7798f09a27383fc0a755a874b9881@gerrit.openvpn.net>
References: <gerrit.1768911587000.Iac4af315c6d7798f09a27383fc0a755a874b9881@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4OTExNTg3MDAwLklhYzRhZjMxNWM2ZDc3OThmMDlhMjczODNmYzBhNzU1YTg3NGI5ODgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <586074badadd7912e96820ad88784de8f50b613c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuZO2-0000YH-Uz
Subject: [Openvpn-devel] [S] Change in openvpn[master]: reliable: Avoid
 conversion warning in reliable_send_timeout
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
Content-Type: multipart/mixed; boundary="===============8642128890728982149=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8642128890728982149==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YxhhA3Ewipw="; charset=UTF-8

--YxhhA3Ewipw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1480?usp=3Demail )

Change subject: reliable: Avoid c=
onversion warning in reliable_send_timeout
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Iac4af315c6d7798f09a27383fc0a755a87=
4b9881
Gerrit-Change-Number: 1480
Gerrit-PatchSet: 3
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
Gerrit-Comment-Date: Thu, 13 Aug 2026 17:38:26 +0000
Gerri=
t-HasComments: No
Gerrit-Has-Labels: Yes

--YxhhA3Ewipw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3Demail">change 1480=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac4a=
f315c6d7798f09a27383fc0a755a874b9881 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1480 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 17:=
38:26 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--YxhhA3Ewipw=--


--===============8642128890728982149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8642128890728982149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8642128890728982149==--

