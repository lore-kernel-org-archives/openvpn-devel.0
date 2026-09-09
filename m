Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73499C79FAD
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/WHlg6ssy5F2JvFnMLTdhuGQMHFlGAXSE4bQbhn+bdA=; b=eskK6OxEw10asHjyKkUMU2DeyM
	IJGgJfns3T2FPhOu5/1zCs1R0pdTYYIbpx+LBOLR76MFnBr9fGv7Fcy1pFpkb66peJzrYzPJXVZXp
	KoNN593BKxgqby2/zzz8/xC84+gCrsQFhjMHcvbvRTm2Lqa7K/FEBCbPA6iQYgsLZk8k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Drk-0006jv-R2;
	Wed, 09 Sep 2026 08:41:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Drd-0006jj-RO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 08:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yswBWbNd1Y2is0k28H9dbk9kcF3aqrdfBWoy3QVXvsQ=; b=hlidLXqANxOvTlw4KTEiCx69Dm
 GSxa3/nhGC7Sssm/j+2mb2FNlbgKVNfh37V/42oY+dr118AUa0C+SvFHFRdOZn2zwoRCd7b8cjyu5
 pbEq2gJgp15HcD8UXP0HuH0/2BItWIxhOfN0FYsm+dIM9XNhzBms8yEMu5BW4YVj0BgQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yswBWbNd1Y2is0k28H9dbk9kcF3aqrdfBWoy3QVXvsQ=; b=m
 aH7A32WX/0SUKy+OA7+WtuNDyv818lT44wlF+LlZ3SG/a26yFG7HO1d8eQS2iaj08Cl+UyGcjRWeO
 Uju90JWsx1gvVdEY4Y5ZpM3jRWssJ2JgLWLllyDz/CSPsV8XuWRS/zOOgs2YhTMMkVe4gBGVAhPRB
 SetT79VTnvxfj/HM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Drb-0002eE-MK for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 08:41:05 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so430330f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788943257; x=1789548057; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yswBWbNd1Y2is0k28H9dbk9kcF3aqrdfBWoy3QVXvsQ=;
 b=fSpQPhudo9+Rj0F8hIkDK8aVz3gHbu6NMOw8RFHlyZ4srwkLPHerhAf9Lxvuz7pWvP
 Q13Ntsoc04D++/PGr5GKwO6NH8nl3OrCKdH8tvDA6VV1QhvG0d6Hc8YyvrLmdAw5evWJ
 VHWx3UeVqs6WMP/vDcoMx7ewngPD6JwlOursfyz06TuaDhw2vk0p2cT4D7pX3GF1Q7KK
 7bjmTC8wSZhAXNsCyvI3hkF+5cq1pwn3Aqz+lKHLahKB55fgLm/rd5AJDCati6XHrWm6
 t935/Hr/gtv7+2V+kt9J3BIKN9ipET4YPctcPeYS3+wOWxeEeQ7pdNCBjoH1llKJo7Ho
 kO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943257; x=1789548057;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yswBWbNd1Y2is0k28H9dbk9kcF3aqrdfBWoy3QVXvsQ=;
 b=dc0lSoocUaaiRGv5Sm0d9yuWw6gOOviUKCgGMaQgFzUEEvkRiE0M4+rW1+4naC+a9X
 0rIbrIwwIICu15A+EbWCJEaVHiSN3EtQYbX8T8i25KR7OCkA/pDsUK2EE+JMzcI5NmSX
 27ukA8icBXugUmFTz2imdGpD/xVuwsriYnfdYbbHouDECg4DH88TPm38LF/z/DKCQhpt
 sgjJGfS2kYaAjAXPz5CBClCyrN5A0RwjVTlVaiMuHDlzLF58e3pTDw48fTztG3CpbJU1
 0HHjJqC9Ic+cV+bHqUNlgBiYo3iN6qlYyqNtjmeOXaN54R0VyaWTChwVOQP7zKbNMlZu
 Setg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd4g7JFpcS2qDZKiXfWKEEN2Vgj65bcI35mNC2UI6jPrVTx5p/mzxveFUaILcsN5kwRMfQGDb+j0GXoIez@lists.sourceforge.net
X-Gm-Message-State: AFuF++msVoUTrcv9tG4idKQm1qNvYRxGT86lMTFno4V0BxxWOLgGJn+I
 Ts7GQgipQ0YpCayARcuiVtRm4ZcCSpo79sJG7NMXZirJQ0R+IHEM3W/U4V/Rpyr6j2JgBhXCppz
 iTB7CjbDP65fl9uQFjtNyaUzTzS/XZ3KuGzguruQN5RfRJ+6LvNgJh9TNKexVBrL6aAgeWsadbH
 Zdim4CAQ==
X-Gm-Gg: AYBFou0GNVLgZc3984g7ktw3Vxq5SFMvydrJtoF0fONNZRtBksdpd0r2PzIsexMrBUn
 P94kgrFwm+z4n5jJ6ZD89xz8nCs8WJ53DtLMZenZ4Px9xKNUWtkBpkkcueRVHrZyqNgSE28gh/f
 +bmRkCY6iD7+S0qgFQaafMcNYcBEpMZ4jQTPfIssiS5mtatpJ32cAes8xtK7Y97RHDqKJK9mC7G
 yg9/azedTgy7wNdRnnLz/Ij5hAhZK/1R0Mz1CsLHEKB7hmRFGB6e7eRzL2JuyH/4xC51mZxwYbY
 Flt0tjY30Kp1cECSBYnMutIrn/+jahVsiAPcIzLtZ7jIZnymdJxmGVaYv9UuK30nqPbuS91aMnG
 J0vbgzyl/yDXuAs+Ptxih03zgMvIIpLdGDuE1JiT5D3wgRMRaomqslodPzFSSJuEi0Z/7+dlEcJ
 5dA4D+nAoZ0FQL1cQ/DhXO1ld0wdRWhfqGBPNxhid2SFKi2lUIXF6uhebtht7CT5w/GQ7BmEAxX
 Q2IF+ZDQm4kvcUqPlhQtkF4rf5ep6xMRulXqmtTybNsb/vuwW9p+pPN/V4wh8+VzonUd/ZFJM72
 EAe94uYRzmg3Q5WM/O2s/FdjN/Zg4UgTYJbRt8G/DDWO/nWrb7w5WPD9FevpGlR+VmGbozSb
X-Received: by 2002:a05:6000:4311:b0:485:943c:886d with SMTP id
 ffacd0b85a97d-485aad9dec3mr9132852f8f.7.1788943256931; 
 Wed, 09 Sep 2026 01:40:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859162f354sm34957502f8f.20.2026.09.09.01.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:40:56 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 08:40:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1905
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1905?usp=email>
X-Gerrit-Commit: 83a0276cbe830f8e28fe239cef35a83bb75d1001
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 08:40:54 +0000
In-Reply-To: <gerrit.1788885150000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
References: <gerrit.1788885150000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MTUwMDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <082104359286b81f545fc7788a61c17c1d63c1be-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Drb-0002eE-MK
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: dhcp: Fix
 off-by-one in write_dhcp_search_str() temp buffer guard
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3285117262581595258=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3285117262581595258==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vdg5nxoFqsc="; charset=UTF-8

--vdg5nxoFqsc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, razvanc=2E

MaxF ha=
s posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1905?usp=3Demail )

Change subject: dhcp: Fix off-by-one in wr=
ite_dhcp_search_str() temp buffer guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
>=
 My tree claims that this is already in, as commit cedf9bc20f1af01c544489e6=
2da6ff2c7ca82488
Oops, you're right! I'm abandoning this one=2E



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1905?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: I6a886a1cac2d4725859da=
b2325cd362312ddc659
Gerrit-Change-Number: 1905
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2E=
muc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Atte=
ntion: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 09 Sep 202=
6 08:40:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-R=
eply-To: cron2 <gert@greenie=2Emuc=2Ede>

--vdg5nxoFqsc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, razvanc=2E </p>
<p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1905?usp=3Demail">View Change</a></p><=
p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1905?tab=3D=
comments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">My tree claims =
that this is already in, as commit cedf9bc20f1af01c544489e62da6ff2c7ca82488=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Oops, you&#39;re right! I&#39;m abandoning this one=2E</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1905?usp=3Demail">change 1905</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1905?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a886a1cac2d4725859dab=
2325cd362312ddc659 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1905 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 09 Sep 2026 08:4=
0:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"=
display:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>

</body></html>
--vdg5nxoFqsc=--


--===============3285117262581595258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3285117262581595258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3285117262581595258==--

