Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0122C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nlQLeoyjylVSpDK950NK8qjlPFh4TobTOSnR3I3BON8=; b=Bhjl5pHFYC1mvMb95oQ7FQD4qH
	4fQY28PyXuMx2vSY17owgOeuT+WujbFpbJYaooa8VX2RGAaW8e/jmdbNS+/IgnaOb8m5BU+GsokiA
	XayEQY+/te6+6R7ACf7VjI6dHIt+cU00saazepCNduie+AoTglExZfDxV2IgkbsjvMd0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylVx-0003rz-2C;
	Tue, 25 Aug 2026 07:24:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wylVv-0003rq-54
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6u7fvM2KMlgY6M9Qhn7VWDEGMGMnEwfv60d5Rx7GaqM=; b=MqCY/qXP+j7U3B0+cTbcMrATfG
 qdlZwu2BGUAfTkp8W4SUdj50WmAQuJ1PgJSzwVDZiD0g9HVvXUzxguaKKPatJY7CiXxYQrJFIhg3u
 WbbY90NQ1gfvkLlCVpkyOq0scYaQvTidxcekirBg6sVno2tFAvQs5NSkDeSwGYHuZ15E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6u7fvM2KMlgY6M9Qhn7VWDEGMGMnEwfv60d5Rx7GaqM=; b=F
 s5zK6Fa9MYoiVA6PLMXJKrBxEIojNSmopTZkErn+GQX5i8KFuPST4LFRK6Cbp3Qnr2WKmj+c3gbiA
 LDc2WQ9d/SzWrwnnempG+U5Q6araiHN7hEVGR0XIeO/iYJVkCKF1xTE7Gvu3LMaQTP8c1VuaTBgae
 VH5yiQWoIVbsLpl8=;
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wylVt-0006vV-NX for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:24:07 +0000
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6a18e24ad25so5937155a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787642639; x=1788247439; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6u7fvM2KMlgY6M9Qhn7VWDEGMGMnEwfv60d5Rx7GaqM=;
 b=K8FU/n4TTnz6wDHAqBE8ugAynGBjKgDCTnkd3m41l2yYyVPVar5Ihc69uRIv8Vu1Pw
 y93JLOw5Owp4WvfwqNbWE2hF1uXCqQJEla40q5T1TJOloL9pkPBHj+LkqCODSi9wJIBY
 se3t7zCyx7WZzwbZG/3ETYA6qXlVzFf/YuI6aOjhITPKf2j4DHLrX8EKEIeeLAEn/hwn
 VthBFF5b5xjOnOTXFu30uYzLvrsV6vK31O9E8KFrQG18CIfW7FDKBkmxSuDN5vYQ7Nq3
 fDbOj774l21Xsw/IGW2KljmNP8RYAG+fiaCiNJnxcBaQnVI6E4IjBsQCT3tz5GWD2FAM
 F9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787642639; x=1788247439;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6u7fvM2KMlgY6M9Qhn7VWDEGMGMnEwfv60d5Rx7GaqM=;
 b=rSVUW6fYkVHi8nLayXDzyoq2wdQIcnbBXmN2uxXZpA4w+uAHcrNuYHBmpatcPl0Rq9
 hH81UAeRWvTP8cMgevf9INXMwkldXvfbKGa6XhhYdb6L3V2yD9Z9bBfWY2090xm0nZX5
 5mscjSQg/Q+4GKJSz0XIkrxxBYBkeWYMyPm83NqtkUYehftm0GOmSU0GoYK8OB+5+FNd
 Qp0uKEgWHKtlgGrabFVt3WV8zIaY+oLniZzxAHkFPXw2/jlK/9hiEHRx1noQ4NyKlE7u
 6NQBdt2r2e+CG2dk2G4218QB4Iva4IABO9qnx1hdolhmLLxaeJyjrlmJhu+55RghQhJg
 WHtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4GlIK872qv6j1yc2coaPjRiyLxmgfCugWKPuEfQqCGgHnsfbW+95YD2LJxWJRTgOARdpZd+EPAd0v+QJW@lists.sourceforge.net
X-Gm-Message-State: AFuF++kMWO0/qlP5qVnKb0HpXomehOKOolmej+/TjHFI2sdttWuujbRL
 y7yB4AZX6gwiHlzJxvpf74tpBUAY9fQfCNSvIFW192QRKbW5BWyLpSw1p4jtZg9gviTaciOsuVz
 bMePPMa+1yAL/33eQ1slTOcbCPIOuF0voxUGxcgwWhSCMS6uWM6+/CA/DwF99KYKcKXVsO3Yx5B
 pJVF9mXA==
X-Gm-Gg: AR+sD12CIGh6VM1HbZ2jxT3f8U1toZ1siQJ6o92SVPjiBa9c59wMLSTJVJwVYkXEBUc
 0IA64Ntk+o6rkmvAml9FF+tQf7SO2YMFCPVY9GcuKQt22G2i4ab9x5jktoSuEQDgirPDMKF+wIa
 tRXteDQQBo7mO4TXWdakbE9MIYCIewZ92ZM6EMCN/SdKKv1ku97Qf4kFHUYN3csK3p2jux2FTSR
 Uf9c8O8jnqO5BMpRB8xBqWSaUlur/0lD3sIrHZeeEkGwVq+iqxxDrrQwcpBCjKdrpFpPhAw9lNR
 y6MOZtKnNv5y6R6kcnCws5ROPqP3wpWV5xdJ8AtWBlqlksfhLdVA58iyrQbbPcp21Xdloo7XffZ
 iM17DWuI4exCGR6BSXJN2is5nvk8J8nRW7++/7WuHi8DWaafDZ+lq44HrmW8jg8tH3o+6C1akHu
 pRtFOO7GbKjAZ4bySJhJa0CCoiZUKIKNeeIYA5qbIYKNsIpnbOXFqYrm4T1gfdtfpsYKQ26AHt9
 AA/zf1Da1xoOHmYz/AQQ1GEgy7QYnPDCiqIwdVjZJaqY902GMskzgZHyW5T3yTVMrCKd2xOfKmA
 73v9cXRVeX58pYBsZh1hUBNXy8QbkuzxmiWtI68cF/2nk1bjRFk=
X-Received: by 2002:a05:6402:a517:10b0:6a5:d3a1:3426 with SMTP id
 4fb4d7f45d1cf-6a5d3a1376amr845306a12.16.1787642638914; 
 Tue, 25 Aug 2026 00:23:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e001305sm13190097a12.4.2026.08.25.00.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:23:58 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:23:56 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: b60ab3c9f41d033dd44c5b0f70f23a0da11224a9
X-Gerrit-Comment-Date: Tue, 25 Aug 2026 07:23:56 +0000
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb98e50dc351b6ce57a4d6625f8b40d4516cf5ee-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wylVt-0006vV-NX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_client.sh.in: Add
 support for expected test failures
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
Content-Type: multipart/mixed; boundary="===============3477193434606939678=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3477193434606939678==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LoPSwdfizd0="; charset=UTF-8

--LoPSwdfizd0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1755?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Add support for expected test failures
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(3 comments)

File tests/t_clie=
nt=2Esh=2Ein:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/ec2bf=
e4b_d246d881?usp=3Demail :
PS5, Line 379:     $RUN_SUDO "${openvpn}" $openv=
pn_conf >>$LOGDIR/$SUF:openvpn=2Elog &
Should we make sure we don't also in=
clude these two synthetic lines in the grep input to prevent false positive=
s?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/9f820460_22e83d=
d1?usp=3Demail :
PS5, Line 389:             grep "$expect_fail" $LOGDIR/$SU=
F:openvpn=2Elog >/dev/null
If we're not allowing for regular expressions, d=
o we want this to be `grep -F`?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1755/comment/e37a40a4_bab6d266?usp=3Demail :
PS5, Line 434:             co=
ntinue
This `else` branch does not kill the OpenVPN process like the branch=
 above does (i=2Ee=2E `$RUN_SUDO $KILL_EXEC $sudopid`)=2E



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bf=
cb844
Gerrit-Change-Number: 1755
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Comment-Date: Tue, 25 Aug 2026 07:23:56 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No

--LoPSwdfizd0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p><p>=
3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1755/comment/ec2bfe4b_d246d881?usp=3Demail">Patch Set #5, Line 379=
:</a> <code style=3D"font-family:monospace,monospace">    $RUN_SUDO &quot;$=
{openvpn}&quot; $openvpn_conf &gt;&gt;$LOGDIR/$SUF:openvpn=2Elog &amp;</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Should we make sure we don&#39;t also include these two synthetic li=
nes in the grep input to prevent false positives?</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/9f820460_22e83dd1?usp=
=3Demail">Patch Set #5, Line 389:</a> <code style=3D"font-family:monospace,=
monospace">            grep &quot;$expect_fail&quot; $LOGDIR/$SUF:openvpn=
=2Elog &gt;/dev/null</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">If we&#39;re not allowing for regular expre=
ssions, do we want this to be `grep -F`?</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/e37a40a4_bab6d266?usp=3Demail">=
Patch Set #5, Line 434:</a> <code style=3D"font-family:monospace,monospace"=
>            continue</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">This `else` branch does not kill the OpenV=
PN process like the branch above does (i=2Ee=2E `$RUN_SUDO $KILL_EXEC $sudo=
pid`)=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">change 1755</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c51bcdda5666e0dab2ad=
cdaff28408c9bfcb844 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1755 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Tue, 25 Aug 2026 07:23:56 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: No </div>

</body></html>
--LoPSwdfizd0=--


--===============3477193434606939678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3477193434606939678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3477193434606939678==--

