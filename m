Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EAAC982FF
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSThHWM2wkInqP32Oz4Qblvgn8HSCCxF67Bm1vxxISE=; b=YXMXrpZTBgQR/0tw0o2ynJ3zy2
	ZOG8L8T+EGNIcsWizO68wzzhEDA9bSIEvstDboczXdT0exvW/ueSC7hRIydm/nJWRZdrZY4sXAjya
	Lt43eo06uDTN/cZDQX6KvTEkAn63zuPX+JYLsAhP3ntpkzWxGrRVtcAbi/C+fYWcRgJI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x90KG-0000xJ-Vo;
	Tue, 22 Sep 2026 13:14:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x90KF-0000xA-AG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:14:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PpO4lPpigLPl9BWuLyVtCiEUJ4J5BG7z5tV/W8GzW2w=; b=ZYc998TsnL+Ifcg8Gl9DxRz95v
 7C/yobyMzlNH0CsRzMSBTwObHDql0qgPs/1STy0prRjrI42f5lxkdYa6+mxZ5w4HuxPEEuI9rXSJB
 TmcezTbJ+1O5JOtb1tnmULy0G4O53G4GgOjCnLBBzh7WCt7tsKHMmFQrCTPLgqqz7FLQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PpO4lPpigLPl9BWuLyVtCiEUJ4J5BG7z5tV/W8GzW2w=; b=e
 OVwv9PdQfv0Ir07pRHncM22N2j8kVY7U4vLnhAcA6u9QTP+AdO8gt919oqC2u5e2E4CPjkpnNjaeD
 CkMZPObbyHet2khabSzNG0P6O5S+47aPjYiGEjwGacjMOUNCS9nsynmETJgZs59YRqU/qA8sIaFaR
 ex8Qrisps12pgjSw=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x90KD-0000jk-3G for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:14:22 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so22517095e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790082854; x=1790687654; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PpO4lPpigLPl9BWuLyVtCiEUJ4J5BG7z5tV/W8GzW2w=;
 b=At0l5H/6hrmTJXL/5sJD3ZAhK/IrDFIvijsQF+qf893kZCv6kfGmTKfDID+SU7n91R
 gE3GsKvFtNJM8nuQ9zF2w80FQ4XirtVeQa2H5f8wSW8yTJcYbqcnVCKGgJhV6YFt8PiE
 xHm25g4LqApnLp8Uqy2yNoaJ9oGCESIWRrrL6mKA8j7MassDcmK3NUwyWatEEDuyv2ir
 oe5euO6s/mWcdHZ2xCIrGl7St9LZVDydwe2H+HpU80LRnv/xgWSvqF02zYbdIu0vNWKJ
 o9Ja+F77AldVb7ZkSUYO9257mnM2kFhhcWcDpS8vr8pekAJScEQDlXUOmgLBzJlum+HB
 +7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790082854; x=1790687654;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PpO4lPpigLPl9BWuLyVtCiEUJ4J5BG7z5tV/W8GzW2w=;
 b=NzW1jD5AXh41+i/UM3KqxdDbzWsE+k7pDghhstZhvLLIK/+yf8SnznZi18KsRFK1tf
 QvM9i6bgfMO1iMTKqfocDjD/CBUjI7m9kh3ex6pM5yzC6ybY8jbe9BmJN6gqq9l0v3m4
 nKMn5PQUGCYb/+BJVw82B+SRcKcyDdo/DId1N7yzqcxUyf2DtA7UK0dfnZMFD/rXH3Si
 nEQerM1LOugVVkyPWCkyG9ip06sNgwJza2qgkaEmz1VDEuE5FioUBW4gC6YD0TiFtWbY
 oPTyUonJWIwPmdYnRB7z9lcCGZoZcT87t7DMy9QO4vwswfa20jgMBKjcVIqzIWYaOTse
 Z4ZQ==
X-Gm-Message-State: AFuF++nim5hE5KFmDzjo40eY/QoqQnNDUvVxGMKlUFKFpi/WqcEOlE+h
 h63/uVfPnBRKhgTBwXlmeBzbLDEdklLO2Lp9pQa9QikS9PLx6+JgTBxoV8Ib6Ntim25e9R2ydeE
 uy3M+MCe3kty+aYfyAzhQ0Pdy10H6ygb6aoKdTiwaN9H2umnoSn5j8aECWKjsihQDOuJZHGZngD
 MTD/MxRA==
X-Gm-Gg: AYBFou14soo27Frlv8NCwC6RqeEuvt76Pnpn0gnmHpFYDX0FWEPhJRexBV2B7b1ZPcW
 4NPziaqw9khKq99FcHoIlTkOObRaQs778cDEbfoSsn2vCh1Eb0ZNMZW61SMjNzu5pNn7bYbB6V+
 /QosTG1j+O2J88mwXozvG0GGBsSZAE16aeh9nsOjkUpcj+6/f82CHZzE4vurfFWHAk5BXIlqxzl
 2h7aUSJNmJNQBzYCwn0ZLVT09KJsZuuiQS+Qu6p4vjaA6ZooTDf4j33tyrHcANUHpkQxdYS1Ixb
 c6UuILzHM9S9+rhoBSgSi7rI+19+BG5JTFYd26ugqLnnEzrIu8oMzYvt9P6JZl9ewtKekJ7Pp2I
 fRWXIj1+S7G3Z/nv0CyUgi0vCS2d+xtUXXW/edtMPvra4C2ObpPEz6SBg3A3BbchABqiajdOJTl
 ClZceoSQbWsoBwTXibnLSplisG2TtXeo7GiNdy0hcA5ggO+y5aVnwkd3w1Xa4IVDIsEI2iPH0Q5
 O5B/i6istDFDcHrXcjlIttkp5ogWy8jyABTpL4QPMw767/q4qLL2URbf7zz1ha7hT8HAZnE+voh
 riMwULfeJhGiMMEio4uxMfm7VY3Q64XlBOp7vkddpwId4KsbsTqaUFO0gTzc5A==
X-Received: by 2002:a05:600c:470d:b0:49f:ce78:356b with SMTP id
 5b1f17b1804b1-49fce7836bdmr138360805e9.28.1790082854345; 
 Tue, 22 Sep 2026 06:14:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdab8ae6dsm107124605e9.0.2026.09.22.06.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:14:14 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 13:14:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib31928529d10c7722e1f08e9ca7ff596bdebe840
X-Gerrit-Change-Number: 1943
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1943?usp=email>
X-Gerrit-Commit: 734ac19b1953b4b09993bbd72e7271245e8dd613
In-Reply-To: <gerrit.1790079868000.Ib31928529d10c7722e1f08e9ca7ff596bdebe840@gerrit.openvpn.net>
References: <gerrit.1790079868000.Ib31928529d10c7722e1f08e9ca7ff596bdebe840@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkliMzE5Mjg1MjlkMTBjNzcyMmUxZjA4ZTljYTdmZjU5NmJkZWJlODQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45d1aaf535f43962dae6c6429dafe81570107b67-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x90KD-0000jk-3G
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Rename
 --enable-debug to --enable-developer-debug and turn it off
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8592019082368082460=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8592019082368082460==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lyihpd+UQsc="; charset=UTF-8

--Lyihpd+UQsc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1943?usp=3Demail )

Change subject: Rename --enable-debug to --enab=
le-developer-debug and turn it off
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Abandoned

Merged into #1942
-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1943?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: abandon
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ib31928529d10c7722e1f08e9ca7ff596bdebe840
Ge=
rrit-Change-Number: 1943
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--Lyihpd+UQsc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>abandoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1943?usp=3Demail">View Change</a></p><div style=3D"white=
-space:pre-wrap">Abandoned

Merged into #1942</div><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1943?usp=3Demail">change 194=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1943?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: abandon </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib31=
928529d10c7722e1f08e9ca7ff596bdebe840 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1943 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--Lyihpd+UQsc=--


--===============8592019082368082460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8592019082368082460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8592019082368082460==--

