Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946BACA5FEF
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rVUynByyhaXwK79CyVSGEZjOAGWytCEt3HS5+uDeD6M=; b=IyQKNfHqKs/stfKLZJtfQuDcOA
	oY0mvuV39B5kLZzEDRxX59BhLPY9ib287grWobqKcztvcwdJhpTNuQwrvbLOsiEQaVHxOvazJuqIN
	8bT/PftSTIMMyTdKy/ie1NoLH3VTcr2htzoCgwGx3bKcAk8KlZSBFA594DR/5WiXRMlI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDP2h-00085Q-Sx;
	Sun, 04 Oct 2026 16:26:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDP2g-00085I-5v
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 16:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QVxLk3BRv4qsxUKXPdanKLr9cnBCG+MFlMJh1TsdPl8=; b=BWBeOs3NX4Husr5gF+GyQyrohe
 7+hRs6lUYBkQFqaiT0TiuBbFHML23ZYUnc5UUsGrh1D1azctRZql38g+714J73yQ5FK2COZUeYuRT
 v9LbcuPuq9hLoAJLsAIZuH7LijOYvMfYARwP0AojOuxZtl4DpDEjtaPYTGnciEE84tzo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QVxLk3BRv4qsxUKXPdanKLr9cnBCG+MFlMJh1TsdPl8=; b=Y
 e2lzRjN8Drq265QOJSkHR67VaWePPoGj/b+ygsgoH3HIZcTjL/Fr7AdxNg1KrFFyi1IxNrd7UJjPZ
 p01pSscJGaPSOZrl4AF3rAStr3bEb0KlhKUh5hm3Kn223FPYzARKu9Lg8Gx0TDNgaSNs0PcItGt6W
 BzbPqO7ddFOnj1s8=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDP2f-0001XJ-Ka for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 16:26:26 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so6458745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791131179; x=1791735979; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QVxLk3BRv4qsxUKXPdanKLr9cnBCG+MFlMJh1TsdPl8=;
 b=N4FfrgdJ15/bDQYLSGiOZSvmYvIPkKgCtHHPHF/NLUqujzLUkl6cadWQh4ouLx9AxN
 rk3bt/bekvvY9ZyVQM9tlzoYt9U4Tji9yYAf7yI0+TdUriIDHxEWy2qev1ZzSQNrMj0k
 ctVNEm9VKcO8Aft1qMrfiGMnTtQyq4sqnec1R97dWCRbJniCP7oqxM7asyw4YO+FhLlC
 EJqzKRXmuXTolrFteHWioMqxfwR7A/LK0swrtD/nN8iRywNvJxcBX7iMNfpNQA10x0t+
 eO7m/XWdEtxoAvQIKMD9NqBHZrnH15RjOx8iLn8o+BwJXVMRRG4+0OXaPq6W/grThsaE
 n2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131179; x=1791735979;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QVxLk3BRv4qsxUKXPdanKLr9cnBCG+MFlMJh1TsdPl8=;
 b=2JRvimdudNgVW+5qFofYeltAfwe+u/3wSWk4ZAoYlp63uTvsCGXWC8HfoorxQPCKh7
 2qUBMstloP0iUq+7yGr9al942zuzkpBXa4T6MIcr/ax0pdEbi3J6kJqPos51D0tdkiUn
 pLxLxTz/Cph4E9FvboNvtFq4ToGkLtDKbyfXnqZ+LYQBEa9wvi0VH9r1NZUvHiTGTNRM
 gfNubtNtNrrvrhS6rVqKKlZGaO5+Djas2dWTMK1maKTQ5EVC4cJDUHC9DG3qV66eYAb1
 7wYSoLB1CO+uSJhU+ikuO1ip5y+K6UvxjDyh8bC/qr07Wb5upFRu4McCYyE9OMlGtCp6
 aNsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJK6hzPXahPg3cvKSAzlLe65irmNTmBCfNOHyLIfk0vBSfRVh4H0yrw4UWbBKPiDEaUXmRmOcXiAbvl4AC@lists.sourceforge.net
X-Gm-Message-State: AFuF++lam7rWR/6BIk/zt4CzrT4q/mXRuOjbQBYOIgYV0dofrUvb09NN
 a0rEVcg7SMS5WlXhotXbY2An5rDRd9UXS8Y4esOoCXW12yQddfby0UCqsST0tQXIGQWaeFZxVh3
 Q/GiTvFmxOpwMlCtZSttwu6Ul2FuFYMtPVvCk34JTCaJ+lBlLG+8AvZaIA/1lafsY4LYR
X-Gm-Gg: AYBFou3GnKMq1y+uEKO6CaSrCltL/xgr0hCsSELr46gC8xpf26ekKgHDn2KGCmJKMPl
 7TUoxPRBS3utbi4ZL4jzV1OB7G4pmQs2YcbwsKKJDUUB402I7zuTEKFc72JVY6UVvKLr/wENpZw
 fXeuAK6dmXi9XCy8nvTnFku0l9FEgAlQixbTljLFLAoxR78ZH94Hi+8zOeNtIqYXjFJeqwH2wB+
 jrdITVLLwi18VesZIVfKU0Fc2P993zT+jybdHSAFPBXVWLOQeQUYQDUnDCWk+1Lzv82Mqlo/5h2
 PUahcywMDHU6tjPak0RiR0JeC3avkLqdt+NkVOn3ESvSROEcID0aWAX51k+AsVxcV3+0rawRTrT
 1t/A+7vuOueNOsLNVRnUDUCh+ShlukcwAFG7clHil3JFysSGK/sJIe/ejEvHGcTcY61tlUCPt7O
 PJ9onrMSB3rBVkq8EOLfC8O03y6ESwyOrIGc6m3g+h8XJKdgZ9cxUMBOYuAGSkqVQiN0ljFZ0c1
 0gzq0U9myOjjxhaq5iAgFH3Kz2Ffo2OfLokC0Xr9xv3g18JA2FejrvstxTzYWux3Oh+cd93NIL/
 UBfDYtyfKDamkA+jhaNvK1NSQvhhrBnpdCI1b9BXSAaySkMCC0TEnzNBn4RJ
X-Received: by 2002:a05:600c:1c0e:b0:4a0:2391:6533 with SMTP id
 5b1f17b1804b1-4a02759bbf7mr169215855e9.21.1791131178900; 
 Sun, 04 Oct 2026 09:26:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380fac3csm19505797f8f.21.2026.10.04.09.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:26:18 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 16:26:16 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ea90594493ab5cb858f7495f773e080b379e8e8
X-Gerrit-Change-Number: 1332
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1332?usp=email>
X-Gerrit-Commit: 5c89829607648f1177649dab0ad395c1bb625509
X-Gerrit-Comment-Date: Sun, 4 Oct 2026 16:26:16 +0000
In-Reply-To: <gerrit.1761818969000.I5ea90594493ab5cb858f7495f773e080b379e8e8@gerrit.openvpn.net>
References: <gerrit.1761818969000.I5ea90594493ab5cb858f7495f773e080b379e8e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzYxODE4OTY5MDAwLkk1ZWE5MDU5NDQ5M2FiNWNiODU4Zjc0OTVmNzczZTA4MGIzNzllOGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2dfec6ef6a936ab1d523610ff984a65441a3755e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDP2f-0001XJ-Ka
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win32: ensure plugin
 dir has the trailing slash
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3704610479659524238=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3704610479659524238==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XuTzWLh8AEk="; charset=UTF-8

--XuTzWLh8AEk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Lev Stipakov, plai=
sthos=2E

Gert Doering has posted comments on this change by Lev Stipakov=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1332?usp=3Demail )

Change=
 subject: win32: ensure plugin dir has the trailing slash
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

=
Patchset:

PS2: 
Is this still relevant with the recent pathname validation=
 fixes?  If not, we should mark it as "abandoned"=2E  Thanks :-)



-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1332?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ea90594493ab5cb858f7495f7=
73e080b379e8e8
Gerrit-Change-Number: 1332
Gerrit-PatchSet: 2
Gerrit-Owner: =
Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2E=
de>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: selvanair <s=
elva=2Enair@gmail=2Ecom>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2E=
com>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, =
04 Oct 2026 16:26:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--XuTzWLh8AEk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov, plaisthos=2E </p>
<p=
>Gert Doering has posted comments on this change by Lev Stipakov=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1332?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1332?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Is this=
 still relevant with the recent pathname validation fixes?  If not, we shou=
ld mark it as &quot;abandoned&quot;=2E  Thanks :-)</p></li></ul></li></ul><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1332=
?usp=3Demail">change 1332</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1332?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I5ea90594493ab5cb858f7495f773e080b379e8e8 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1332 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva=
=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Sun, 04 Oct 2026 16:26:16 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>

</body></html>
--XuTzWLh8AEk=--


--===============3704610479659524238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3704610479659524238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3704610479659524238==--

