Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA92CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ED4vB+x1qZyZyBxNYaO3qcSmb0Cp/qB3qGDgwzFteAM=; b=SU0zxWJY+vFz3Prig1LLhz8+n7
	y22jjs6blzUDMrzaeTHMYHjcr+EARoa5/VdssfQ0WS48CBDP06uiBLGeUyf0/bYn04ytsTF/KNR3P
	ttyMLwdZILxYAOeRCCsI9aYFQbHuUJ1s9R42e2ntqDs4RrmZI3sJOAoJZEyWCJCSU4NU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgsi-0003gp-Mt;
	Mon, 22 Jun 2026 15:48:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgsP-0003ch-6d
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:47:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UOmZxqATLte017Nbwzdb+UqYjyrOxfqii4I/LIrXvPo=; b=j/WVRX0i5Q1EMQRa3qalco8HYP
 tANiOJbPyloT8pvr1mrKXn3A7LLXj2NdrWmTiLTYzI0FT3vfW3y6AhGh3LWxbLFslvkbYM3O5kTQG
 ktP3f133G+lhWAy5KJStUESId7ppnTB1oFy4kERKKUGJvI6wIrlQLLn3Uj0I94RMYHpI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UOmZxqATLte017Nbwzdb+UqYjyrOxfqii4I/LIrXvPo=; b=C
 BrfcI7q/tCNqyhQsWDYSKFWIIUG9DgII2YfyqVIUZAt6cMlF1BrjKy78Zrx7Pp/ZrG6/L3DOAaLl5
 a9krNBMOucqpnK2SJdCjsDfRhyfxUUPmypI+SAmPNwlPV1h1OC0toHMTniMTPXbRtCkXtwB+QeR8n
 G358jucibCMWb1jg=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgsH-00005s-1Q for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:47:50 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4631679f204so15009f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782143258; x=1782748058; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UOmZxqATLte017Nbwzdb+UqYjyrOxfqii4I/LIrXvPo=;
 b=eR8NWRuWzQl7FcD9oal5wEQGe3wfgOLqEOirSwqmCd51v1gcxRd5/zv+pfHogS77el
 0hdL7VX+2lWdxaGjoinbDUFY9CTwbf5bd2cRz+PyqVA5zT0hvZW9nZR2SSie3eSsK5ih
 mFliJj/VyrYfFN1B156CGu5vm0is0p2THq6tai4XBWagLrBCSpf9UUD+AEz47HxDvBte
 Z21RLn+1r18uuan5xXgBbCq4qcZeizK23Nf5w+Xpcw4HV2RIcJaHxIy/KfGMp2YtdQsx
 agoq4TpYmoP+FYtbAZDrpWzoPq2XTNsw89ARSUjvUjQ+aI1rvMYpz/aejtLFkENzq7gL
 nhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782143258; x=1782748058;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UOmZxqATLte017Nbwzdb+UqYjyrOxfqii4I/LIrXvPo=;
 b=A4DyrPNwlj1m+XA+6iDgdOAjostUVAM/U0vpDtT85VojvyYCIxaBLi2//nzPr97Y9l
 U3WGaQlptQvVgu/y00eWxnJEgyJnsxJ4wDVhBsxfzqJfbIq956aCPYi6Oy+7F2lcljpX
 tNMc5fZp80Cl5ml1A3TcBwR8mdLtceSAtSj5TkRdewwJd/JKTwve4zlXDR+E0scqVcPs
 pkwPGr8PHyMCBzk3mcXc/dGwC73tEAvcBfCTbfW3RhrFcoUJBKS7P1XzKJ2VX2pRP/dG
 /qAmamdvnCs6DpAzawfKi/7frjV9CEl4uRmERkc3bNKWR/zwGr7pvPs9SM8N4lvOGO5R
 TS6w==
X-Gm-Message-State: AOJu0Yw3k3GABnQi9/AIpQhapPQlergeL+ir0GBKTTJIfhP1y6JORPdu
 2be75z6UH9VOYqxlvV3tmAPHMnzBXeJzArqhBrwavUrh2qmJfM1y1H3WM+Pvwi7U/JGxX2YQRLk
 8mUeylN0oaW/L52GLcFZh2OPky21bfz26cGi2wH01MZhLhoZA2K/cY2+eWmrdwRLnDGx0
X-Gm-Gg: AfdE7cmOFJu2g+zzpQRb79hyyCzfNIjfGq4eq//04zLDpo+frvGnRzG0l+w0OGRldG3
 jl82xao7qrxZjogZb0ltE9UqVNdEo01KC1LqWsgmMrm6vl3a1aTEmJ1LiK/NMS0kCg50udIaOWp
 /yF3vT2RErxUPrvJQM2gWMh/MtNr0zX0yHXVEqlSKhQqDiLsoHNVskXbULiuIfkAFPY23aE4w/x
 yu/vieU1zxgfgVPWdOWbMcAs336S6qf3SNJ+w8AnbZYKJ5q/IIoVWfNH6Iar0FxIje9t5Yb060s
 lyQWIU1oQUeV2Il3PGfBCzbwxsdgWZdttH+Wa3lLl2m6p73d27xlGykJ9F8+Z2ctBYQv07pvK0L
 QCNpb4cFppSYeh0hb/L7Jmqn7JOop2wgZ9UqV02DFBD8TqE7Smpyxq/E9cG+NMve1WQuHneCxHg
 AFtkVQ81sK7pBYL45eDulQEDffcs0Wo7tGcT6mXpnX7I72E3034yS82sEttC4I/fNdQCDfQgUqC
 SZ7DrbC2LZxFc1hEVPYZWwdULUZxB5GLnRgtk0QWup2p3VqLl3b1s3/YkgY2iNRkwzSXMPNPJcX
 484=
X-Received: by 2002:a05:6000:4284:b0:464:fff6:489a with SMTP id
 ffacd0b85a97d-46a7e9f3eacmr105432f8f.6.1782143257464; 
 Mon, 22 Jun 2026 08:47:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c4fd2sm26799330f8f.14.2026.06.22.08.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:47:37 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:47:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I401aab94993b62bf18e66561532085f99e62f745
X-Gerrit-Change-Number: 1721
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1721?usp=email>
X-Gerrit-Commit: 2b51b6550dbcecfd5a98a37962c99efa4dbcf22c
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:47:36 +0000
In-Reply-To: <gerrit.1782134588000.I401aab94993b62bf18e66561532085f99e62f745@gerrit.openvpn.net>
References: <gerrit.1782134588000.I401aab94993b62bf18e66561532085f99e62f745@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk0MDFhYWI5NDk5M2I2MmJmMThlNjY1NjE1MzIwODVmOTllNjJmNzQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aba085e22224cc3996d6814915041451a6b15e32-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgsH-00005s-1Q
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove an indention
 layer from multi_process_incoming_link
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0794929208687762100=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0794929208687762100==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EgyDlDssOY4="; charset=UTF-8

--EgyDlDssOY4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1721?usp=3Demail )

Change subject: Remove an indention layer fro=
m multi_process_incoming_link
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I401aab94993b62bf18e66561532085f99e62f745
Gerrit=
-Change-Number: 1721
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 2=
2 Jun 2026 15:47:36 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--EgyDlDssOY4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1721?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demail">change 1721</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I401aab94993b62bf1=
8e66561532085f99e62f745 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1721 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 22 Jun 2026 15:47:36 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--EgyDlDssOY4=--


--===============0794929208687762100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0794929208687762100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0794929208687762100==--

