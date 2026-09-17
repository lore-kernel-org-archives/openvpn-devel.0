Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A46C982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZ1CtrRa6OrLwwu54fzu2dyDHW2Cr31TqHYcehDTwZw=; b=nTEywlKm7oN+qd/eivULnQ9Ue4
	vDpfYecX6p8D7pRpJWjFzhxEgd8Ouxkccz3HK+8F+sAp/+OqBy49/k7lz/BRI4Z2aC217T9QiAp2j
	+FJNEEMJLuLDlR5us+w6DFqDKtST+36OJZ2VnloJJocDKGDCWQLya3P4n7QGRW+0tixk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7AJS-0004Il-55;
	Thu, 17 Sep 2026 11:29:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7AJR-0004Ie-9g
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 11:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8rFy+V8+cwDE09AjeAmbIJ8y3WICiFFO3ITF/4/lwjw=; b=jMjWxgw0D4jhTp9vs3sWtAsy6g
 Z1C2QV615FGcBNNFogUvsJysmAHrhrIzFZW0etg8cbWu8XIWbWc86XuCzpLspVBr8T5D0qViPlzdf
 Z9ppIsOpjZhLFyCa1YsCgnsWV+qcSVlfith88zv2wMLwb0wX8BDUHNrPov1poWJpYvdg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8rFy+V8+cwDE09AjeAmbIJ8y3WICiFFO3ITF/4/lwjw=; b=V
 frbXHa4p/O1o80CjzLfwjrxYoOBri6h92yzU35QJdBZse+uKhK6VlZumyICUWZj7YA3mEBXLqoGQn
 4MvxOhdsrRnAuOHLslTvGGGvH8sCzR6Aic8Zk4w+lKBnxfUnJNYrvKeeiSsQPvwlaV2CMBISv6o/e
 bi5iIEtVxpiQEzbs=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7AJM-0006lD-UH for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 11:29:57 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so5221775e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789644586; x=1790249386; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8rFy+V8+cwDE09AjeAmbIJ8y3WICiFFO3ITF/4/lwjw=;
 b=FyxfbopUs2k8mM7X6PjlsQqiu2OhzrPjriUZOrEObkQm3Lft5iWXA2MFlzw0RUqclS
 LhZ8jkVvW7E3JTGEddBbNwOJVIEC1ZOWxUONvFj8zKsLtQj0X31Bgs1eUXR2+WbAWo0+
 MR5rQ2BTXDhQYAd8EmOSHPaz3TKb5pNY8zK3wihioScFolI7KQTd/B818iVPTJ5Rmzty
 b1KRCEG/1oWxVjkSOl6OEhvspy2lK/zoVubbsK4cGfJ0iD80nP9f2veCTyU/4/o8DP1O
 VJ0ASiD5y6AMtv2ekiuPgbNCwuTOTNJ1uP1SDsmqTZhYC4ZHQJ4ORgaDJ3LPZYKpQMAX
 2rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789644586; x=1790249386;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8rFy+V8+cwDE09AjeAmbIJ8y3WICiFFO3ITF/4/lwjw=;
 b=v75Gj6MRDX+0iEDL1vNzg1mvqtd2Qm213OlozP0rKPZMSaPmQW074c+hgx07AqFDQ9
 6br5hcrjDeW5puefEBgfI9Jez7ECPdtQjPnwHeuU7N5gJ0MLjo6adeAp9xclnu9yvD37
 +mTZxXSK1nZz9yaNApI/bXIGU2vosbisTjR6s3jkTNrnLZkyJpaKabisz0UWFX6QG/TL
 aC3TNRvZi3qnV8m6W7J6PCq61kmdqF0uLt+Cb96x08wp27pKIFN+J09uB0MslOlhNiRc
 SaNcjyu4DUzezETL9RwU+/9d7eCSCghUuKrZs1YBpnoNxeqvXGQ0RSeKScoLYMNLmY6x
 8eQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw71DeuxdC89zxUp94xTYrok/T1l0AnpqOafDHisNmIshqoXy3TeVacH68rwCBug8aPMj/6TbxUmUwkuyBW@lists.sourceforge.net
X-Gm-Message-State: AFuF++kh611K6FM81RiA9RQx3pM6g4dMmyhoWpQsFFrNAGqWXeV3wpFW
 yQ/ceF1ycFjz3PCgigYvCx3ap04XbnxR6S5a1Pndr6Hp3TrJBEbhwMgTIfCEVHEzMzLKqc56E6T
 2HgQFjpLBnncbxnj3Qsw/8zaNpRHVZwcsFe5m4V8KLBbdNEmIzOnYrRRgvZrcrlkY5d5kMtcDpS
 OwT8T7Yg==
X-Gm-Gg: AYBFou0I5m7n3ro10ig9V0wijGytDbACZmG9F2xNH56mFze4tly+J0s+mUBY7byBzJ0
 RgJzNvOKC05onTpAWSHryJo2KVXa5Lujb7F90z9d19f+h74o0ptbAqWjUMbAG9rW2aNJ4OFCW0l
 JQd7fXHyyadN2vImqHblcF8oyYlmLMtoKtw9wnHyayfu6DmXIPiUUvCRtItp+cCzma4Zrf2lCxw
 ol9NQZa86D4wH8xsriFGFoE1i+1EVhxDgMlmg/4foLPQCFYjvU8lyFO3pFnaBUo/2DzGF4xQHql
 98NmpMWt/XAhJl5qkifOJCsiCsX5GIa8YTb+MO/zCLiq5Aq5Vy/NGP8MDs4qdFgL/FJpoJY0xgR
 aQ05RoLnDN8val/YPDPzeMfJR5wOqAIl6UZQcaHj5LT8XGom5g49Kkegw+1FL+cBpYA6g82eZLg
 GddvE0yuqqSi23r3iFUrTu2ZF051zKVnJg+brutghoQpG255RJj6afet6OPRuQ1gflinud7n4u/
 IMeXrxdy9fPO/5vHfW3oQPpfCK+7r02RNI6fhDC8Ot0m2qgam+w9+0nk69H+B92kawj7qUcfA6E
 Y/0ZWgapLJf9UQAjxgbsqCQJcrKyq9uZTmJDobt8asMeScwpHV8MTdfl7k2RFdxb2WQEQY1OQA=
 =
X-Received: by 2002:a05:600c:8819:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-49eb732b40emr69414275e9.26.1789644586240; 
 Thu, 17 Sep 2026 04:29:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd247809sm116332885e9.11.2026.09.17.04.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 04:29:45 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 11:29:44 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: 16e2b183c7a230baef16215f37843c2e4cc37788
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 11:29:44 +0000
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <049a9da64d0ff0c58543f30d31c8567ffc90def9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7AJM-0006lD-UH
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 probe-result ranking for server selection
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
 ralf@mandelbit.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0819538650276197291=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0819538650276197291==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QBVMYe5Hdjs="; charset=UTF-8

--QBVMYe5Hdjs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici, stipa=2E

plaisthos has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1746?usp=3Demail )

Change subject: oob: Add probe-result ranking=
 for server selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 18: Code-Review-1

(1 comment)

File src/openvpn/oob=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746/comment/87cc0443_3bb7=
2d0a?usp=3Demail :
PS14, Line 253: announcing 0 asks not to be
            =
  :          * compared on weight
> You are right=2E Advertising 0 only mea=
ns "I am a candidate only if I am the fastest"=2E [=E2=80=A6]
Okay we seem =
to have very different understanding what max_latency_diff is used=2E You a=
re using the max_latency_diff of all server and ignoring the one of the fas=
test server while I described in the RFC that we should ignore all other ma=
x_latency_diff and only use the one of the fastest du see if there are any =
other servers that are similar=2E I am not sure which one is better/more co=
rrect but we should agree on one and either change the implementation or th=
e RFC=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
46?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I55da68cc3=
41bcfc707fd34ca2f84ff9b6a55501f
Gerrit-Change-Number: 1746
Gerrit-PatchSet:=
 18
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lst=
ipakov@gmail=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2026 11:29:44 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: ralf_lici=
 <ralf@mandelbit=2Ecom>
Comment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--QBVMYe5Hdjs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici, stipa=2E </p>
<p>Patch set 18:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1746/comment/87cc0443_3bb72d0a?usp=3Demail">Patch Set #14, Line 253:</a>=
 </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;"><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">announcing 0 asks not to be<br>         * co=
mpared on weight<br></pre></blockquote></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">You are right=2E Adv=
ertising 0 only means &quot;I am a candidate only if I am the fastest&quot;=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Okay we seem to have very different unders=
tanding what max_latency_diff is used=2E You are using the max_latency_diff=
 of all server and ignoring the one of the fastest server while I described=
 in the RFC that we should ignore all other max_latency_diff and only use t=
he one of the fastest du see if there are any other servers that are simila=
r=2E I am not sure which one is better/more correct but we should agree on =
one and either change the implementation or the RFC=2E</p></li></ul></li></=
ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
746?usp=3Demail">change 1746</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1746?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1746 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 18 </div>
<div style=3D"display:none"> Gerri=
t-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Sep 202=
6 11:29:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;l=
stipakov@gmail=2Ecom&gt; </div>

</body></html>
--QBVMYe5Hdjs=--


--===============0819538650276197291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0819538650276197291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0819538650276197291==--

