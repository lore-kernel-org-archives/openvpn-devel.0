Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD6EC9832A
	for <openvpn-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bkxdxg1d4s5Kbr3b6RmsUntX8xucCpIJ0B5OVmX/Kck=; b=ZC4Plc+mloios6OY57zYgRqv4n
	R0QMeP+IRitVuUgs04q7Kq4Rs7nsvRJzsFtmA0lvPBK/SZdsxLbrywMxYW5riYmH2ZZ84kZRxH9aM
	LG3z1XdFiDvPqV4sIF0OA1VDiHKRo9bMCBF65o0tFXstzuOTKmKTxPK6ms94GbiUX470=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xAXa6-0000tE-K6;
	Sat, 26 Sep 2026 18:57:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xAXa1-0000t2-QX
 for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 18:57:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+35UXpKBEK8X7fODErPRYMC3BCNS9rgEt/T4PRaBBP0=; b=R+EjT87v/tpXIaYAlYfTiU6fDD
 mU5Zz2qq7PVktEz1tUtmMIilA4EgdnIMaElz5E5p2+yTgZoEIENok71AFzMIaeEbBYgK9CoNsCl9d
 eTLTFwnVPEnkd9l+on2pD1phzzHXIIw6uzznGljVuSO/m3VFozuUOw3JM88AsadslHYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+35UXpKBEK8X7fODErPRYMC3BCNS9rgEt/T4PRaBBP0=; b=L
 QorOtCIS5rkdBjOXydrb5+mK5roL69rbyH19mPSpuOHZQY9pk98BUCE33xb/a9YT+KDLHhWOg2We/
 4+RmOZRHI3ySg0NDJLcfcOTIxd+JekuW0Iypl+RfJWFMxpVuVHS6DPAvGgp6uDaaeQiqyIX8J/OWr
 FF+SZ2PcZ8kNGf3s=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xAXa1-0007zY-CV for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 18:57:02 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so10770665e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 26 Sep 2026 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790449015; x=1791053815; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+35UXpKBEK8X7fODErPRYMC3BCNS9rgEt/T4PRaBBP0=;
 b=Y1BCMXd5iubVaL/rbfRgWdoA6Lst9H6K6VLUAXFvFpcKg9OHCKLxYnQ4n2d+QygVsD
 W20dVVOY0OO1C1SlXRfkSJ8eu9djv3/y8LlGMQPGODQXDFR5P2F3/64V38lZiYEE7TFM
 rGDwkVFezDafOroUGHaUKEWcikRt8YxhjMpnBfAE1iWMb8NFphJ+gMX+Mv1s9cbu34yS
 kWqJjGGO/2m1hlLJna3FmALtLYtg1k7rU2sx8TqEwVSC09Y1Cs8g4OrT9L5IVCsHeCuN
 KOYn4NLF+nP8Jdm4A5T049murAor9F4H0C/CauUG3xf16aDTR5kClbaj5XESI1rIxCFf
 kDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790449015; x=1791053815;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+35UXpKBEK8X7fODErPRYMC3BCNS9rgEt/T4PRaBBP0=;
 b=SEuwDTrUqGzAZSYiHtlJrA6ouF//A1GBnoKbzmKh4ixBuCE6e7IkAaE0RjaC8cOUqX
 YeA+fyVEug8sPLqQzBtJJEDQ3vQZuSnqJeieWar4OZMUqmgsOnBOrY1NMJ5bst+5Agmh
 uGhc/F5E2vRhduL67lY+3ZQg4saLlyt1txM0ToRSnAHWHuRHTwdiZbYfkBIzy5yp0vrA
 I+oyOHlbOKvtIgbdnesIxBYLNSOCRBPtoNEUGxH31+SSrBR5h5yioNIxYCQF2nZLKLNr
 1AeJuMhvDRp+JPokKmHBiB+/YhyTONr8nNMyBSJtzqmjROfiNucv9hD4uz5DN58tsZzW
 jqiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpn/aQinsh/Mky6YKhFIVXkh0WDJmw1JBCWK6E0g5sLuHuVIzvW6bABO1pF/jXSzPrkhgeTVkmBRSi5UI4@lists.sourceforge.net
X-Gm-Message-State: AFuF++kxVLLv+osKeHzT+1m3fUJLR4VToxH1ozAVPaRR42qwtgAJbzvL
 Q7P7rK+P5v+uHEUBcjynF/ExsxOQfwj3fILKxoXkkZPLlcSOkESvf+gDAjPftEoFzxufT0ubE2T
 s50jVCAeqSELwONsIiuMLF2Q4OVlRTmq7vZFgqdM9ECGbSnTmRyrxmQ7whF9wCoKrrx0l
X-Gm-Gg: AYBFou1VcAFHPbRu9j5EpfY2Xq4ch4HOJ9WCo8ChKB7PDOCcGM0Dho8F+3xoQibgXvF
 iF+HcdVyzf8dDCkFznLVsYdHlNCbWrfXAWwDkcOiFpWCiprmPa5kUqXTfBxiytzd8ofSIBOyctH
 VjRiRduzzDPu/DUx/UqkPZSwS+da21e+P0qjXkESlwa4Uq2jdP/6zXUNbEv7agiGT757DKzs501
 64R08C0jksmFykxyq3/oOUXrphPjNs82focgtqcq0GQz/tVT+3bFT8g+SwVO639AngmGal1taRX
 K1cIMeYmPuSBuhqCgCaT+Sna8WNbFj+k/JdJoNa86OBgfJ0/LTc0sqGbm6OiT9SGsURlrKkUYdA
 ws1dRij5Xfvo+1oT4OrPcPR0sNCVrQoSyBqGRKvrJq5ugMOjdtefbo5mYKASph6qGc9zEozA6Aw
 Dq4n6NPyq+B6m6hNBrJa6qTFG0cXy1U4xn/Sdz2n+0wQvjJKs8v09boLSEOBdtAgk8b1eolziuN
 MG2wcKBU0mLdFJQ1PBwpW7SpDW85B2+LkReq8m/5SRqA95UcMuggrZev9epPJWgYfzL5AIkF4K9
 7aB4lS47c5nPRUluPwHrn49ml9VfbUPA32fObaU3gllqloiBcffiapLYapLF
X-Received: by 2002:a05:600c:468f:b0:49c:fa20:cc02 with SMTP id
 5b1f17b1804b1-49fe66f4fc6mr149001735e9.25.1790449014750; 
 Sat, 26 Sep 2026 11:56:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ffd66aa24sm46308495e9.14.2026.09.26.11.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:56:54 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 26 Sep 2026 18:56:51 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
X-Gerrit-Change-Number: 1952
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1952?usp=email>
X-Gerrit-Commit: 62781dc17328af91c589e6aa2b3c276188e2383a
X-Gerrit-Comment-Date: Sat, 26 Sep 2026 18:56:51 +0000
In-Reply-To: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzQ0MzM2MDAwLkljNTM1YmIxZjBkYTE3MzlmODdlOWQ2YmVmNmZkMTA2MTI0N2IwNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b429b448aade161b04bb1d3afbb86e154fbd69d3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xAXa1-0007zY-CV
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: stop fetching
 peer stats during client disconnect
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7580541113738145868=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7580541113738145868==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aDRApJTuHmo="; charset=UTF-8

--aDRApJTuHmo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1952?usp=3Demail )

Change subject: dco: stop fetching peer s=
tats during client disconnect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
Gerrit=
-Change-Number: 1952
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@mande=
lbit=2Ecom>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 26 Sep 2=
026 18:56:51 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--aDRApJTuHmo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>ordex has posted comm=
ents on this change by ralf_lici=2E</p><p>Patch set 2:<span style=3D"border=
-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background=
-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1952?usp=3Demail">View Change</a></p><ul style=3D"l=
ist-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail">change 1952</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic535bb1f0da1739f8=
7e9d6bef6fd1061247b05de </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1952 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Sat, 26 Sep 2026 18:56:51 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--aDRApJTuHmo=--


--===============7580541113738145868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7580541113738145868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7580541113738145868==--

