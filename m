Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9071C79FB7
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p2Sr/v2w9kOd6YWer/GB5Q3ipeSWwuTGx6+oPoZ126U=; b=CrZucdoSTjUXl3hZmuS1IRJ5se
	HPHvhWCxICZHxqIwr38v4LtkyQ4ytRe4gkZXLCZYPcZ5w27qg0+4Nh4cTwRRq0afTHNqxiTJTOAjZ
	U28ATZkNoqdhuZSxvSPqNoRbkxaBK1lNSWX66zs8wDhc9p8OP2QVlFS1O2HagppTlnOc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4LUV-0006kZ-8h;
	Wed, 09 Sep 2026 16:49:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4LUT-0006kR-Qr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 16:49:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=e39U6+Wbw+LR2lNUDha2k9yTS7lkl0fs7/TgvAnsZZE=; b=VyCgR9RJTmj0Rn41n2UgU74ETN
 i/LwNmFSwq8RmlrNx8AwFvGdkVcAAlYNHva4ay1xIfyv8sfYCv4apwecAnxXd+mMnQn6X2rbwgeio
 eC+03bu+enPtubg+I1jCoMMkLoQnqzTfhKR3xe4Hplr1Ogm0x+2YfidW3bROOEDhmG1Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e39U6+Wbw+LR2lNUDha2k9yTS7lkl0fs7/TgvAnsZZE=; b=k
 HvlPUMxO15I3FTKYEaZYKEQV4OxlnXBdVuJP61RA2aZB21b2jZ2vB1pDGbWoE7n2VvXVHQhjRC9Ho
 104PJwkp6NVqAxgCmwTFaxsOdPdIHkE9+7kFSVFm87FczoCyw6MUNH5BFPsaBnZr7/dDDSc159vgp
 bhsLl6YD0uc1qD50=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4LUP-0000kO-CT for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 16:49:39 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-485aca32ab7so218331f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788972571; x=1789577371; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e39U6+Wbw+LR2lNUDha2k9yTS7lkl0fs7/TgvAnsZZE=;
 b=Jrf+AubPhEvZ9p9RCXYFJUFPugqcNI8AaMAsDS3sL3FfHeHFs6WT/RNdRg1zmoJ/iW
 wdxH/07oHWlOzeNihjqzGVDdEOOMkpCC3/CUKYRPEc3/W8nxdrDIGorvTzP/0FR5f9QV
 X9+098tdWUGv0ROWjZEWJVbD0gFq6WjrmXGpIFAwQzFeetWlqzaAVbi9Se2kY6+7RzpB
 Yjkl7Im63vJh3KPcaz4DfyBaST2QMwcV48V9LkrTS+sIEQ6aHp9mLJmnJOgxQnZHfkkP
 As4cyZmPjH6o5Tr0ANyvEDEFuuFcnFZzbivKsMue2/TtC1f2NoAlibDI1h3Km9x+/Hm6
 8z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788972571; x=1789577371;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e39U6+Wbw+LR2lNUDha2k9yTS7lkl0fs7/TgvAnsZZE=;
 b=XX8KZ0qggje6ExFkkqUmSWz5vgWr3TX3DqkQZVWO3rWICee3VQ2qjy2CuA9xd2IyHW
 rw8m/NHzKQIaZUUOOeZQ1MCwRbD3tVjc1eVBLFV592QcQVUigXGSyRwvDOzbuc6PDOP7
 9ktjkbAQ6QW/281nUX+wI2q0eVhOmswmtWGcCMX3D+NhIk4AVVmqo0g03SjP2eb+pCL4
 Drka3FgZnrt3Piri2jVM90EQxN3KPDtvVzGnSYMGKnZDYPPFWLWSw1AguP8dlsSlJTIe
 K1QDRckeZ3OyduS6cUSV5u5NPbLG3gGHAvMUqFfKQyQH9xW83/caRxn4QSoGxEIs2ALg
 gGIg==
X-Gm-Message-State: AFuF++kho7rWBNPwbEdTVjLOfCy8m0Gth87Tf2rfmRpQhemiPmhiplh1
 muwri8TrjCL4KRhylkP0HgUdiytYc8GogAgRNfuSI9P6Kmv3nuOhj8YIno6/LAT1cEIfTrkBJ8H
 aAt8gr/9pGP+Nkt9Evls09CatIV+/4swyak/Ma2cb7MEL3KGcF936scnQfs7buw922PXB
X-Gm-Gg: AYBFou3A06mAbBiVWjVUIoXUJmQGkjvhMCJVwU6Y2fhfaAySu2dstU/D1JzIkk99LHE
 OWVSynJ6f5q/DqlDeTtjtjSCfT6bp2cGVc1raXXWqAIP3SfF4udFF6h+uxkxcpdp9alUtKEVnIf
 op9Yi5wUSUUSeTudUtQuephKnK/8aSCY6e+ujD5vZK6eKykOEoxHafnqKEM635+KAo6ME5Q04zZ
 6a/Ye5yFSW6T5J7HTD5S5aHWOQZeuCdGacWxX3Ix3PRmB8Mz1kGUWSBD8JErcQQmtnuqYiFmQZH
 0xSJtKHI45QDuKK9iNDYwn1QEyb271c5ZxReqRCOofo5J+jfqLIhfARy5KbfXvb9GJ6mzYjPp/k
 wDxqvCXklMWV7f10GYXqwEIVppxVEpfCkm8sAwL8dY2ehLOSBJ4StGuaRq2lDD0IR087jgRHYKd
 pOcKIB85DGmKzwmpg5CazcB8GxEUJ7pcRvd8Y9XmJci25p4YTNeiEmTifxBKux6qSfBDLf/z7Rx
 vewrcOrk4PT77awEocHpSwFeSwNPFPyRVoaNUDLqBvBg+GcExy8QQNF4i9rFakAfSOcLMxUYA6L
 cOtrqYiOZs0v2NcFWkhvcncHpuuBgUkWLRchhHSc0RLDJk/p9WABSUBGJtcjJA==
X-Received: by 2002:a05:6000:2907:b0:485:b0a2:6e09 with SMTP id
 ffacd0b85a97d-485b0a26f76mr4567491f8f.20.1788972570574; 
 Wed, 09 Sep 2026 09:49:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48591eb3d3bsm30180192f8f.0.2026.09.09.09.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 09:49:30 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 16:49:28 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1907
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1907?usp=email>
X-Gerrit-Commit: a453210da741209545b1b6d026a6487151789341
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 16:49:28 +0000
In-Reply-To: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
References: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjQwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2985e1527c6ee180312c53f5059ad1e8a25092d7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4LUP-0000kO-CT
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: openvpnserv:
 harden CheckConfigPath() a bit more
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org,
 max@max-fillinger.net, gert@greenie.muc.de
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 plaisthos <arne-openvpn@rfc2549.org>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2169324076362707155=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2169324076362707155==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rDl1vCNqj+g="; charset=UTF-8

--rDl1vCNqj+g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, plaisthos, razvanc=2E

d=
12fk has posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1907?usp=3Demail )

Change subject: openvpnserv: harden=
 CheckConfigPath() a bit more
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: release/2=2E6
Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182=

Gerrit-Change-Number: 1907
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@max-=
fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Re=
viewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: Wed, 09 Sep 202=
6 16:49:28 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--rDl1vCNqj+g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, cron2, plaisthos, razvanc=2E </p>
<p>Patch set =
3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail">cha=
nge 1907</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1907 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Max=
F &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Wed, 09 Sep 2026 16:49:28 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--rDl1vCNqj+g=--


--===============2169324076362707155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2169324076362707155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2169324076362707155==--

