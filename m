Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF76606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kxT2vVkr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=POkuSfpm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Agl1/qS6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fmyfl80O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m4C/45c52DNeO7niVP7Y17+IV2r9rC4JkJKGEd06u2I=; b=kxT2vVkrl2LhNvNCqYKpUpfGCO
	L8XlT/Wu0LsUnhFHR93Sk2OzgQTbMDiHfPEAHVSuCCDFltkd+3HctWUWc/euZPIO3z7nZHg1RKoOH
	j3iWE/j7YAemhARFYTsIYbAaagkP8ZErs9q/W1rgSyu9mxVvF3Rgi1LSBhmGm/zxUNCw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP1MS-000000007g4-01be;
	Thu, 05 Nov 2026 17:34:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP1MQ-000000007fv-10FP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:34:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XvnMPjli/+K8D7lqm/zgXe0l9zvtvRxsnpTKTL9w8Ak=; b=POkuSfpmTxN1pjq1SDyVzaJbAo
 /gOglGYAYM0GTHeywVS+0xCNOkcPa0ZuYB3XM0+uxqF6dqCn2QZHavwjxAQYJXr/cMEHOfTZDZ908
 yrEGhMtl7RKp8oivgL4aKW7SZZrlrC8vYIxyysf2fB8Pox1nX7DxkQbqwpUzkWYQpWJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XvnMPjli/+K8D7lqm/zgXe0l9zvtvRxsnpTKTL9w8Ak=; b=Agl1/qS6EhcA7FXXmygscAsPZ5
 laE9FfPoumCDsJbkxUYYRnz/Izs40EgkgaDLpOEeiqo01LbsKAmdt2iTuCaBPsZXjhOeRAcnKEonP
 +vy4ul9v8cdeCZ7aaa3R8BKTaW91vKbj8VxfoWpotUW/h4rW/wtalBVTqNYSfljxoQlI=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP1MO-000000008Mp-3AIl for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:34:50 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so1527971f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 09:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793900082; x=1794504882; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XvnMPjli/+K8D7lqm/zgXe0l9zvtvRxsnpTKTL9w8Ak=;
 b=fmyfl80OmrsEh84YMXV5L95/PB0TiimGa8vdRmpjnGgueN/WVmBKloPKokVLaqbu+z
 8M2Mg8M4pEUJ7379/Mjba5XqMAWtK8QSe0iKlMiLGcDLOe0VTSVVNsI3xH/lX6IeTmTH
 yTeIlKXDyxjnkjbJFQQVFJGHH/r0V3DyhdO+dHsV2/arPpzU5bEvaGdfkP9mUY30Pml0
 j8YrHHndGsUsX3k16wQO8wZKArU0DDx3nli4XmVUnROUWlcI21J0UJGMe/CSaQZkX1NE
 mOCc1hpc2vJXYIvPyOgsNtlXKKlRp9vAld0HTx+uYDne44teG2zTjaaHZjKjA1gVNp/M
 i+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793900082; x=1794504882;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XvnMPjli/+K8D7lqm/zgXe0l9zvtvRxsnpTKTL9w8Ak=;
 b=gvFaLUbDWmj/gLfAotOh+UqW2/ktOjYK3P7QJQdqPPx8SzB0+5+ktwLhKyZ3jmrQiK
 8+pz85fsL0VR2elgCoJH6WnVMww505W+U9TZ8+1LjgkyRWAyVfk8GvOAb1g+OEgV7V1n
 3+7yi1e5m5N8CG/n3TNSKYQeNBex0VNFn4NLQN0IYsR2UA41a+rVit4ocOP5j+AkbDpd
 J/g6KKqExH0cpqbOW5nnc4X2w0WxiF/u7FPDjoXtFuo0l3+IK74XIvm5YTn9QPdQf6XR
 69hCRmFVSTyBpQrXvHy30D2c8+H823TYPJCuVcM1JOWfqL1ESpNNPvR2J2GwuLy/bTpa
 BkDQ==
X-Gm-Message-State: APuU4Z+shrgMIPJ3jRSLxYrYLdR6Qc/WI23joS6JFDwJSGbS8nvrUR9W
 +bpqO4O7p3MbjlH2Im83neni0Z648ix8qw/8lKnqhnXwGLndkd7U8Rxa6Bo4z5LMEs50IHl/u+Q
 GAJFK47LhQcSMJ4rxzW18kmz1gie/DprmggiejeVgS0oNu7Tn+BDHlI8tmMKoDPacwsna
X-Gm-Gg: AYBFou1lF7T8+3R6XZhMgUqGJXeLBVrq1F9CPPiTiLbTVUO0NSauAalbJIRPGwzPoM7
 XUCVUrf6eXL0E0G9gS/PmvpB+HI1jNqCDrD5HyttHBdM+pS/ve1zQ9U2E9I3CiizF5IqeiM6UrB
 aAUW8eAmv2UeWB3Qknk+jb9V2QrW9eIrg6SHVEGeZ4q99e25wS/Gpw/A2I6kXL/9X/Yw9WauSB9
 vEVj0yEcuqMptzbFlVeEjKXxJrYZot40bT0PNyxIqx1ntCuPGcYE/I+oeSauicBUQ8CGvrAJh9I
 q4wembWesOnQ9pAIaM2zHQnoLaSd2xFTGekUusX/GmyON9yITOZNBtJNvwsCu3chM9du2R6cdjJ
 6o/wECDNhMXcENjZSOCz3Xm1SSMI6lL7FhBT2+47JFclVLQSDF3jU6cCisYro7L685sgZVDygAO
 dKzxPIc6d2MvTP7rHGsdj9Y/l82aVC7Jwsue0oQmDmdHzdEtJcBbH7OZM1r8pLBOD1nzZDucRn9
 VhRdQiCWplzCHnFSrOqci/0ceAgi96dAdJB4Shir01dM8/pHsTv2dBzTwg8CeE1hnXLI9nipiJb
 m/xDWZWC1L2tN292eG+rFP8eTo+GDm7aa1fDnu2eOhI45tbJHvCI2U7b4qqFfY8qQywXNJZAjXQ
 8eLSanVT9rXU+DRhNdS2r1qotXwDwL33NPyPDhR7TN8ETUr3ziT+6UMp7W44Kw7Chk3SEwD+gay
 4smDSjKRXWLam2lw==
X-Received: by 2002:a05:6000:400d:b0:48e:38e:3102 with SMTP id
 ffacd0b85a97d-49276698813mr674992f8f.29.1793900082000; 
 Thu, 05 Nov 2026 09:34:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d8e29sm11886787f8f.19.2026.11.05.09.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:34:41 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 17:34:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 6e50bb1d2c9a151a25a3ebdec30e88c37bd787f5
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 17:34:39 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad85dafffd5d3671b92d7dc461524c0bc5e98fd7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP1MO-000000008Mp-3AIl
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7399765830087026056=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7399765830087026056==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xs6k4+Ik3q8="; charset=UTF-8

--xs6k4+Ik3q8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Ralf Lici has posted=
 comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1860?usp=3Demail )

Change subject: Add python scripts that d=
emonstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8:

(1 comment)

Patchset:

PS8: 
> ht=
tps://sashiko=2E [=E2=80=A6]
Sorry, this is for the other patch (2037)=2E G=
ot confused by the similar names=2E

This is the right link: https://sashik=
o=2Edev/#/patchset/88655f5ac15a8d9e5b463d616eff63ce4fb9445d-EmailReplacePat=
chSet-HTML@gerrit=2Eopenvpn=2Enet?part=3D1



-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
Gerrit=
-Change-Number: 1860
Gerrit-PatchSet: 8
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: Ra=
lf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 2026 17:34:39 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Ralf Lici <ralf@mandel=
bit=2Ecom>

--xs6k4+Ik3q8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Ralf Lici has posted comments=
 on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></p><p>1 comment:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #8:</a> </p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">https://sashiko=2E [=E2=80=A6]=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Sorry, this is for the other patch (2037)=2E Got confused=
 by the similar names=2E</p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">This is the right link: https://sashiko=2Edev/=
#/patchset/88655f5ac15a8d9e5b463d616eff63ce4fb9445d-EmailReplacePatchSet-HT=
ML@gerrit=2Eopenvpn=2Enet?part=3D1</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">ch=
ange 1860</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: Name of user not set #1000061 </div>
<div style=3D"display:none=
"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Comment-Date: Thu, 05 Nov 2026 17:34:39 +0000 </div>
<div style=3D"d=
isplay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> G=
errit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-T=
o: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--xs6k4+Ik3q8=--


--===============7399765830087026056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7399765830087026056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7399765830087026056==--

