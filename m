Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96573C44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s6LfNB8uKRx3MLsn36PpiGoGc9/LaE+FiYTpd9D2+ys=; b=mAVEDm7ntX87wlfZ6/mqZxd+JZ
	JGueoWy3kuw0otQh9GlgDZdXDcH6HUMq/kqmoduvDvE7d3gh2JFNwWIKbElygrFSkiRXblC/J0b8D
	6wg41fLTZdbYl2BizqvrKk2w0tkva9UEDqLh+AUoem3dqt5BoeJG7wbIwBggg7glWoHU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk18p-0007k5-6d;
	Wed, 15 Jul 2026 15:03:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk18o-0007jr-Hr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:03:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6yQUsvKBlY0raovWRRE9vHofDvAOR1rrOsZnenBLCXE=; b=hMa1D7l/tC2dpu8E0QhwOVPio1
 f1mbgFpVZ8WGgVwl2Scxx3gxCDP602QDhVfkbLz4OlXktc7b5ZG+P+NDmSSmtRHi4g5BHNv5zEAIw
 niWPcKxQgrIfCYNy9hopCXOqYLb3qe9FMR1r8ZscP+gr0qOICgpr1yjNpPEFV2CFUYyY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6yQUsvKBlY0raovWRRE9vHofDvAOR1rrOsZnenBLCXE=; b=I
 9ytEVUmPaBS/MrW9y0jiGsms44qwkeM4soP/bGX7gJGyn8nFhirY3/9+btd5p9hgTV/nveHAep1nT
 +FBgrXtsPqL55NwHlj0Jf+7pySdO4OB+xD7V8bRTkgejAVjwOi/AMPwu8S3L/XSCS3o2HE3RQUofD
 2MmFS+25fIdE4by8=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk18a-0006u3-Vw for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:03:05 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso1253661a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784127773; x=1784732573; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6yQUsvKBlY0raovWRRE9vHofDvAOR1rrOsZnenBLCXE=;
 b=QnuL742L8iN1AqcWIICq5uffx2Mu5gk1MDlmGm0cErzc0lGweOrSIL85UJt01ENL1A
 0mypqDixxRlNQnpjzDCPHCRImajzlC1bAb2TRsQsLNiTCEK0WSTAIQ0CUaa1PjH6nOeu
 AaGstHUVfTq9CPNh9T7thDM9BYbCRjDi5OS0CvVtNDVLqmtGa4F+FjY2prqaVmCU0Idt
 z9wJa+GC3H03+ZKwdsHvd2MalO0R2lZ3OMhvfUHMDmwsN38izvkatKRKnB6i5C/24E5t
 jbRVW/fWIdmoZ32O1Gx9ePmv0+rwre1dbXbHm3gmtva9zjmAjY+PVIo3Uyk+3PgL88vI
 cIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784127773; x=1784732573;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6yQUsvKBlY0raovWRRE9vHofDvAOR1rrOsZnenBLCXE=;
 b=T3dJntFOjEuEry2ksw9lNBHfHEZlPREOCFpWJ1hC+mRVu4B7+HqfJDzgjsGyptfc7f
 51sy4PtM7bftinmTuJn22AEQlTzjwef8slU3UcWVkxdqSVFjj0Y3CN0xrRUVDPTNzd+/
 RydOvqTHyH4ITZ5D59r4DNdozi94ii9goXzLpo3Ys5STSWWgqxUGQyBC88vIdiQoVI5z
 hDP20TM76pFBx4vL7tUwpWDdcDC8hzy4ciL7guD51O83+X8wifmETnCXKln/U0Bkgnau
 EXPpzqhsYOW4l+1CFfdCYcj6IY4yNDQKrpuS72QNNzn95kgoUU5+UuPkqhDC6aiOsYdI
 8exQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHdkbOeMfFlV1gJcJbHuBH4EXJElVJ93K2O2Cse1NQqCqxlrAH9K4haEffqcCrQpn1BQ7rKSvICvfwKHNA@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxkH+dsMSSnTCKKnFmmGoCUwbiysBS2GqOHkXkcAOfkh9a3/0ft
 IuUTZnnDaEsY6JJ8PTjSuN9XdvSgVM6cAkYNTmtM3aO4OvmjmYEv7xIvYi1hMcY+K4Zq3zlGKVx
 HCgeOKC5aZ03XPD3HR2xuMv2B7x0csaEHu09go/t12nzLBwkiSghzpWBg0WeDXsAcop0JidjpVD
 gW3ume0Q==
X-Gm-Gg: AfdE7ckAqN+3MH6Nx9p4g1tiQrFTRt8H/CQHJmZ4TufLPSEeB2+y1UlIzd+UaIFcCfW
 TIqq6FkEE18mIATkUCOqjeUXVndvhr1Q+ZBogDODMdl7SjhsDMlfATxYy98oPRcI2e6m5TDIFcn
 VnxeqENlG5losS0EZVTlzMmYnjaUUGZnI824Ie00RH1/cHymOqLB8emMQnvEyQIl497SkS+yeyk
 KNBIGe3gth1PJrWOLQbQM3uYxPTXYmZ9c9SD/YELLBQJytE5MNCphCWMQ9fcHvVJCfvzi0ad8SZ
 3iwvEb6a+RrodImSBjGKMVgGMi0lrVQ1RposJ6qEMnclFVZsrj8rgzSfD/0vHRw4WkHwQ2ck+Qr
 mcwAsp5qfbCIRavn6AqQ9a3TLXvQiF6zjMp1PTOymJEkvPC1YeV43dp+nbcnfrl7EfsJ+wBji59
 tZTCYgPJE9jw4BGcXQzO+zabl7P+O0F3rwMn1HQVXynrwojWwv5q5/phvTqxH3rZbxVb/g2T49Q
 K7NoNM8dN9jFbonY89A+/8b8mohopWkUS9dUzNhX8+4Jxga3sKHZ/ytZAJOrEOMxjlYhSzlHHK3
 Qvo=
X-Received: by 2002:a05:6000:220e:b0:475:da0e:744d with SMTP id
 ffacd0b85a97d-47f2dc85696mr21965462f8f.8.1784117831904; 
 Wed, 15 Jul 2026 05:17:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4829896asm14220583f8f.23.2026.07.15.05.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:17:11 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 12:17:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: 4a81c72f784f0878124a097af3574c29ff185564
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 12:17:09 +0000
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cbdb9db5bb64a5f3445670d5280d7807ae4b42d4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk18a-0006u3-Vw
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Split
 multi_get_create_instance_udp into data and control parts
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0543112194746939982=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0543112194746939982==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ejXUlrI7lnw="; charset=UTF-8

--ejXUlrI7lnw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1726?usp=3Demail )

Change subject: Split multi_get_create_instan=
ce_udp into data and control parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File src/openvpn/mudp=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/comment/8b863414_2e4c433=
f?usp=3Demail :
PS4, Line 364:     if (!mroute_extract_openvpn_sockaddr(&re=
al, &m->top=2Ec2=2Efrom=2Edest, true) || m->top=2Ec2=2Ebuf=2Elen =3D=3D 0)
=
> This check is too late now and it is wrong=2E In t_server testbed we see =
segfaults: [=E2=80=A6]
Yes I overlooked that || m->top=2Ec2=2Ebuf=2Elen =3D=
=3D 0) part during refactor being critical=2E 

I moved it to a more explic=
it and logical place=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1726?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
Gerrit-Change-Number: 1726
G=
errit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 15 Jul 2026 12:17:09 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flic=
htenheld <frank@lichtenheld=2Ecom>

--ejXUlrI7lnw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/co=
mment/8b863414_2e4c433f?usp=3Demail">Patch Set #4, Line 364:</a> <code styl=
e=3D"font-family:monospace,monospace">    if (!mroute_extract_openvpn_socka=
ddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) || m-&gt;top=2Ec2=
=2Ebuf=2Elen =3D=3D 0)</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">This check is too late now and=
 it is wrong=2E In t_server testbed we see segfaults: [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Yes I overlooked that || m-&gt;top=2Ec2=2Ebuf=2Elen =3D=3D 0) part =
during refactor being critical=2E </p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">I moved it to a more explicit and lo=
gical place=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">change 1726</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e9923b51b77f184=
c7d49d697004cb02d2b5cfc3 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1726 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Wed, 15 Jul 2026 12:17:09 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No=
 </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ejXUlrI7lnw=--


--===============0543112194746939982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0543112194746939982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0543112194746939982==--

