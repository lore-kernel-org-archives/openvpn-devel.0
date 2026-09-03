Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EABC61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZIpox9NXVUP/7us6acQFDQNVuYvO6MURssmAG7w8ks=; b=iM5Mt2B65q7Ny+UQWuccgT/oCP
	CtjmFpeGx2sEe3NVMeiSxNPVOzXkF1vSZrcCRskZzFiKDXL/wLIIsKE4p12cBDNsKyOkjwASngBEc
	E3VneAHnXu68Y17PdLYsRGDWMZWdJwiA3sUFYFIYeJtdc+q63E1OxYz8ywUsebFHG65E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2Eoo-0000ZQ-Uj;
	Thu, 03 Sep 2026 21:17:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2Eon-0000ZK-O1
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 21:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ncSc2+wCiZARYr1G672TTw/jGOjjwFcgxGs3Vz5UIA0=; b=RTEHoAV/Wty45ehDut9ClllCng
 LOUFDLDZ2ljser/crbmoAoZm1xvhm/uiH4nJ57n9JDE3bjUO046BPhADB67SNWoZfg8XPLY2hfXjV
 9SbPpRHXm527/vIa3B21SOhGSr7mQBhAcMPnHkPKEEK/imXa+ehBn2szl269qtUpId5w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ncSc2+wCiZARYr1G672TTw/jGOjjwFcgxGs3Vz5UIA0=; b=M
 V9do3FgCbZeYTl8wmHr3Et4YLl7B2QiPbYjOjs0TCdDTsNK1I8dmAU74vJ9AxwJKaQ3VcVax0MCYz
 DXDbD1RzgeiEEVhL9GS5wfBnfP5tY1wkUAqUyzU1TxrQPPFLLjkXltCzIkSVsi3hR/l1lvzc2Fyiy
 DIc9GLTkruFfLnOk=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2Eon-0006kQ-GW for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 21:17:58 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49557167508so3917095e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788470271; x=1789075071; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ncSc2+wCiZARYr1G672TTw/jGOjjwFcgxGs3Vz5UIA0=;
 b=AhRdnrITEbq3WcnEIKmSQH55KnBlLjjwEXsQnmZi42sYD5MLEZDLFFIcYW3+uyRKGH
 5m/zPaDXHsyKuhOKsMcvSHZ/6jw4e4C8chvBWeLrAtcWdExL8ZgER0lSG+RVFVjhm6e4
 PReaH/G+FnP8jJfdn13A7FiKjmjz64dV8CqrZIUke96GBYfJJ6jEugEaMX+p87/jrnEx
 FmH2qKehLNelE0dr98pDeKCjcTG5hB0In1gkMBFKgB/MRHlqpdm/AvkRQ3BjMo3r7VY2
 QjYbvXXVV9+qVaexYOAFp1fbjInpVAJ52CqUVnCZdkRh8X/tF/pi7YMrmvs7OA1IELQP
 B7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788470271; x=1789075071;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ncSc2+wCiZARYr1G672TTw/jGOjjwFcgxGs3Vz5UIA0=;
 b=stxE9GvXu1pOtR0GZhWr1mEGcXFkQiF8RAFv0HQ0cctLGmDFiJq4soOCYt+7Vpc9Mn
 5t8PLztkShQ70sWBm+Bzmpe9foCzGJKYX2YffFdejh9M876BLgr+wjoh12x7KpakQwZX
 2D8PpxRR/UZd+/19L98S2jFKbK4ZlF9SniavHs3dHrwq655tDoeF7pidLJXrXRZUUBEy
 HLs2y3ESQD296JSgkubI2RnAPsMitZXLF/ioPoSHLhxbA/OXnbdfsApSwuscWDhhGpD8
 7JcuduqcLErw4bNIXgBp31pr4UBEuoGUdI/stp4zduScCkJBBGoHXs67mbJtbF4Ecjw2
 Ynyg==
X-Gm-Message-State: AFuF++kOXKpE2An664ApLzY3piWksgErJFJZFQAg3zqdAreps9qTqmTi
 l80XuTryWbnGeBgN5mz8JECAfYoP3KLhUK/rynYHIcjvvQDWX7zrTdQP+tJ6RXl1bRQKMuGqa5w
 e2Ay2rhN42gbT6V6rKdpnO4Ilasbo1VwD112iKDttAyetswILqnIueXeR2kDrc32YR8vJMt/Og4
 qu5hMF6Q==
X-Gm-Gg: AYBFou3IWJUXnazB8RNZrKWI/XT9FsJh1Gr7Stk8zZTrBwieBuBTTNdJcz//ltI/bjm
 bSu6RaIlVse0sipT92FVCW5QuiwRUjUoVlDxmGzSVJp2BRKeSaXQ8lh/1NCp5k1w3XCRdDheAlB
 gBR0IOAqZxedYYiBMLXIsSvVU24fwazK8Pbaa/NVq6pmOWQgfp5mkn77u8jzX8oj53JCsxl8ZJC
 LJ/KIFI+jF9mK9ElX1PhB1tLDx7VjoJGRDVY3TO6kpUzxm8KLZ8bxR4phdg+g5imaP5xa2lvRVv
 7tnp2ZMr6FeN3MZiXGSqoz2mAhsoMEbsqjaI3G4EHLA3NhkQHfT+WAApOIKefAs5QePar2QsGTi
 5ImRgt7jNrMK0aS3X6N3K84FijSB6dV5MY25JDmlzsN+aWlMvXAarB4ZFw3B6H++90NLCbhQ24k
 j90iBxEAoVxYnltZX/oLEdFQGk/8iLV3XbjZsX99arIFNuoUgSpErfHv9yhS9dqXhqVgLX8thtj
 a5PB8r2kYjygGuHfmkAAQpC/0RCUB6OkerrNAeNGS776SfJxmJeGlYOMMaoZJHZt0pPsYkqazM4
 i5ESW1ylyS7myVWwWhPZc5AdWV/diz6PI3vNDL7SOMCQiKw4rcw=
X-Received: by 2002:a05:600c:6087:b0:49c:d52e:d0ea with SMTP id
 5b1f17b1804b1-49cf81e3454mr15129865e9.4.1788470270867; 
 Thu, 03 Sep 2026 14:17:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7710aa5sm14524905e9.7.2026.09.03.14.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:17:50 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 21:17:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
X-Gerrit-Change-Number: 1894
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1894?usp=email>
X-Gerrit-Commit: 287f1ca39cc776ca7491d1196e2500a61bf1faef
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 21:17:49 +0000
In-Reply-To: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
References: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDE2MjA5MDAwLkkzYzZhZDI0NzYxNGZiMjA0YTI3OWI3M2U5OGY4YzQ3MDRlMTZkYTJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bcc7eb8364b6af8c8f46b2a79908b9371fc30869-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2Eon-0006kQ-GW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: add unit
 tests for ACK and backoff DoS hardening
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1564492270673908907=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1564492270673908907==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="++uIem+85NI="; charset=UTF-8

--++uIem+85NI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

plaisthos has posted commen=
ts on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
894?usp=3Demail )

Change subject: reliable: add unit tests for ACK and bac=
koff DoS hardening
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2: Code-Review-1

(1 comment)

Patchset:

PS2: 
Do we re=
ally need yet another unit test for packet id related stuff when the other =
tests are already in test_packet_id? :/

Did an AI just generate a new unit=
 test file here?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1894?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3=
c6ad247614fb204a279b73e98f8c4704e16da2a
Gerrit-Change-Number: 1894
Gerrit-P=
atchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: c=
ron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: =
Thu, 03 Sep 2026 21:17:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
Yes

--++uIem+85NI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p>Patch set 2:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1894?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Do we really need yet another unit test fo=
r packet id related stuff when the other tests are already in test_packet_i=
d? :/</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Did an AI just generate a new unit test file here?</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1894?usp=3Demail">change 1894</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1894?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1894 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 03 Sep 2026 21:17:49=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--++uIem+85NI=--


--===============1564492270673908907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1564492270673908907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1564492270673908907==--

