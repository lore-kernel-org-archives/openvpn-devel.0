Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1969FC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZeTq8yCWlrpHdf845ybmL9c6oLUzUTHuUqpKH6h4VCM=; b=Kbok5jtKIZNuIF67XYCNnd6XdK
	oj5WQnHAo7x5gW1eGLErwkjSBDC43K3goHytumKzkjUJEGaWS6fJ5ycUY0ZiPeRkm4SJjtFVREeG+
	fVQT5iMj2W2SCMgIEs2MifiRZLAoj8N4OfAkl70wpn/Xb3j6mdMjtGBuHNqvYcPynLEg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwmJ-0005xL-Rn;
	Mon, 17 Aug 2026 12:49:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwmI-0005xE-9f
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:49:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YQZt5rKFKTqX2C0VTMj3fsv7OOGgVbc3FVl7nypPhxA=; b=dJWGA4zabArtcXF9OjR9imqc2S
 mtG8kWPktJxMqabvjoUXFAybBvoZlEkzhv+2AkG9pnmv8CyjSyo6aCbp5VrcMv2FMcjAV2hhhmQU7
 7jHDSVsVXxBXqa0cirD3aWyQ1qZDvvFhx6XZ3edPbrmmiP7yLKpU7UutWNLTxL8P1cXQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YQZt5rKFKTqX2C0VTMj3fsv7OOGgVbc3FVl7nypPhxA=; b=c
 z8OaTkQgRYDa3A09gjY/r/29yTBomf8Z5JqStL1EAN//YuZADaeVgFvEd9ncpZy86g7hmgQ6TjNYf
 M6IveyAI3ovJB/UqvvY51dR/ONprS+jhRmZbtqm84YNGix4VGMp7Yz6GA3iqMldzuR3c8zD9zB7HD
 rRU2O926sw+irvQ4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwmL-0003r9-3u for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:49:22 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2054943f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786970955; x=1787575755; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YQZt5rKFKTqX2C0VTMj3fsv7OOGgVbc3FVl7nypPhxA=;
 b=V8LtLdsNu/whSzqdDdnXCfj2Nqiv/tHiQSWQvCCnP9WdWOT9Dxl4g+RYTgn5BVEM12
 qKdVeqFC3w2YDYabY4X+rkpGnK3svtJop9SmecbLbKXkjbJ9TrwqN8sxPDUneEgigk9f
 xiemAe6Ja/elNNS9VjHuO6x3gGXEJetXgqO21XbeWnKNabzaccCIA/K0C1vAvz2FfzmW
 wfvjZ2blvxeCMKc53C66hdgUUMHfJ3CuO2AdWXkvkoEHtefdL9+uj7roE6/qKEUjSKfe
 jLWw7q/dwRqDNPW9gOm6p5gGo9scwBkv/3EeA9kCU8Ld7c73b70EylwfzlWo5CdgKUsR
 YNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970955; x=1787575755;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YQZt5rKFKTqX2C0VTMj3fsv7OOGgVbc3FVl7nypPhxA=;
 b=TpvEjpjw85nSQMB7fB1pM94/Djoou/mE+SohgmFL65mocWSfpUnbThushIqLB6zTw9
 1th50G62AO1spGkXPpXVnmhe+9SxN+EHh9maEiRLjx1McMu91OgiuS/gfO7xtS7kWYCT
 C3VZUa5XtCrPBqshVrFYnLGk6Ah39eTm9kKSff14fXagYdeqSKFgpwYcGE7X5w/+XcIH
 4okpBfelEh2bmUqFXXY1omrucwcfXu7yZSx+ZVtHEZEdoO4/lUycuw431AJt3a/LS1fG
 dpE38Woc5ZGJdPwjppiNtPhMf1UJtdrhc4eYI5YEJypo9+ZEOL4PKKS6jdJi0iiO/7Mt
 0asQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfEFzYX4K7kDKNatBSHfhRId0u2/H+t+J8qeswpa0zFJplWkJ6oieesVrWgku9bhUXWXXtXpVfoSbYEnFj@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwX7zfXjYPreD1iwTGe6lsZ73Y1+DkMiMLQ06lXAid2HMV6vwEs
 +32nxgOaaHq2wFVJIzelpBR6thZilLs3BKeVjLq8cz9/NXAPBys56D72Amhwda4WueH/oGKIISt
 oMw79l+og9mBObAhV6utZYVGOzag6v/NHpEn6+hheifARXqDP/nLRHss8F8vO9ceCpmyX
X-Gm-Gg: AR+sD12nwOD2zBY0/snD4Vz98Dsv0LVSUbedFlRkXefvCrwc6QiucuNXCT4uSNm/R/K
 hPRUBBNo/OaF4eLkr+exyLuCWaYxlXAKJc0tnNkc+Gqms6u3sBaKA3ShE2luhK3mvvSIAeRPgr/
 BA0zRBdNonKFpD93CLXTmw6O1ykAnml7ItJOhC4hYV4Y4BYlTI/VUFxkICj2tuJXv453sSy2Bfj
 0K3CIgjPxyA2XFyfMUtFSzJ2KSDREii3cd1Pmcf+P+3n7RH4v0ADb83fNUi5VVUX6YHYgUAXf6a
 9qFCO1ZFxv+zU2axHWTiVDHZT6m/9MwakNEFlcXhNvbZT2oZeJB4jJMHpnBglPF88cnNylEdSO/
 L8E8xOK7N+x9zwzqOBROLYys7Kic/v7Hp53498lN9wpewOjZysIRnB4qdcUt3eSx2fid7y68oTQ
 /a/+BnaXnvxNTIkNr41CcYAIXBVVi/8DuzuUPBfWnn/zHpPTcb6lyRFjJpCGHbiTt4NiFSqWxpR
 9XybwfTKQyoZZU3iG7GoCObTWSXHO9OmGG7y2jvcYW/qJrh+2O34SXrjnFp4g37Y2htrdMXaysE
 0K4s4gJ614//R3IH8HD1FkgAPM2jLsMpJN1HkWx39sGZ0kwE0bz8JT1NI0fGGg==
X-Received: by 2002:a05:6000:29cf:b0:481:5d18:eb9e with SMTP id
 ffacd0b85a97d-481607833ecmr30615109f8f.17.1786970953911; 
 Mon, 17 Aug 2026 05:49:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b783basm3828266f8f.30.2026.08.17.05.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:49:13 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:49:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 16f746e22115b096bb1e6f1723cb4f63f0f6885c
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:49:12 +0000
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2a4853de5a55965249ece7c990df17236786cac4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwmL-0003r9-3u
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 options display code from options.c
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7604978940324430088=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7604978940324430088==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZIqGKirKFOM="; charset=UTF-8

--ZIqGKirKFOM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail )

Change subject: options: Factor o=
ut options display code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/o=
ptions_show=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772/comment/ba=
b5dfb8_9d14d59b?usp=3Demail :
PS3, Line 29: #include "syshead=2Eh"
> ``` [=
=E2=80=A6]
I mean "recent"=2E=2E=2E



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1772?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
Gerrit-Change-Nu=
mber: 1772
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Da=
te: Mon, 17 Aug 2026 12:49:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-=
In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--ZIqGKirKFOM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/options_show=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1772/comment/bab5dfb8_9d14d59b?usp=3Demail">Patch Set #3, Line 29:</=
a> <code style=3D"font-family:monospace,monospace">#include &quot;syshead=
=2Eh&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">``` [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I mean =
&quot;recent&quot;=2E=2E=2E</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">change 177=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I617=
62374c141662d596bbf88b64ca7f7472b5149 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1772 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 12:49:12 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailb=
ox=2Eorg&gt; </div>

</body></html>
--ZIqGKirKFOM=--


--===============7604978940324430088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7604978940324430088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7604978940324430088==--

