Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EC8C624D3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HRtaO88aHvv3udF6v1pJcET2GdX5gdNqlfWn0o+rtTM=; b=aFJA3O+vnzAbc9ZNjrjwx1y1vc
	OIBcVr7gLWTIHeTDZjI+goiGDEsv2bjQE43aVTgKoXv+AIqB9eE1O4mwkEjqU4jpaZDHMrbf30taT
	X0I4ruC02Z90xw6zeVYHXmJ7dYAEkqyhiISmxk9eu95JdHvonx6vU4KKw/lgNVe7WfMU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Pv7-0008GS-2Q;
	Tue, 01 Sep 2026 14:57:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1Pv6-0008GK-Iq
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:57:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1cdv4ui40WIdKC2+TJGg3VNZa5HEmkii4N4ZGUsw69Q=; b=boV3CNiyhcbFJGCNpmOaxJnbST
 e+aJR86Ji6mbTFLz017BM930LKlqdjG+hjZuTyxXspbHeReLh0a5eyXA/AX6010bNo51h31ssvji7
 DkBAvD4mVvU/aWJTQCWeNJ2iSLrztgtFB3IckuHgnUjEIuhtplBU+1vy5Y3jfowk5PcU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1cdv4ui40WIdKC2+TJGg3VNZa5HEmkii4N4ZGUsw69Q=; b=E
 7f79+UVVuhyMQAL2lX6UMtnTKmXu4ANPP7Nq0M5YCAz0C1d32cWEO/jZlwndtNTkNl0wsfpCW9EH3
 GxvPYO2p56TgTP32E3+JXAv0B03Xt3eaNvI1nqFRQ9ZGfM/nwrQpYrHchyTlAI6Z6AnrgV2ay16pW
 eU7nimVn46xA2q8E=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1Pv6-0004WQ-Os for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:57:05 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49b8be0409fso8272305e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788274618; x=1788879418; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1cdv4ui40WIdKC2+TJGg3VNZa5HEmkii4N4ZGUsw69Q=;
 b=PAXMYTYBiiIbBH0V23z+3NmDhUBFW2n8y8/ZpVoQ/Qdw1NYNC4v64Ki5iXIPggtD2O
 qcqogLcsjqRo3bTD5dBXilp08Zn58eqA2yrW/oLSYYW2EtdTmBZ/+1pY2mE5NIN9ce9N
 W/gHBNxbg78y7Ox1vM1N7dRWb3IaxfMbwqfL0CDOY7erd0ibdbssh6ymhEh62aJ/3AEO
 e87AREKPMo5vaKEpwChWYnqE2RVnFKQzp/A943iEIJ8R25qbihX5niCcy1iI5L1rYvvo
 o/lhE8UGyPBer7NXtU8PdrjHJISQoM4siqvK0cC146SkWt6o3xWlaxcyD7KR0SC24RSP
 GfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788274618; x=1788879418;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1cdv4ui40WIdKC2+TJGg3VNZa5HEmkii4N4ZGUsw69Q=;
 b=CDD/CxbojhaTfKGvJ1E3kd0+jqG00SE6QOMLYVGypHNZn7p/1TbXATHcxDURI4kYp5
 1Jc7EzhoR6qRNq1VxUimUuGJ3gVR/kw2VPITg1RatE1q/PAoXYFr8eq3ucpqsMr4R9Z2
 gIyzPoVxQy3m63yEM/g7UAtZtZXI3sscmdAZEOAG64UleyqiVQiGPih+Nb38nBxXCY3o
 EIg2HqRlF8zv+Z0j20l+OY6BMvHIDNrIQnUVu1M866zgXOY3KlRgl9iSd6EXRQw6kn2C
 z9SyyNr/ZpyHCDCuOzD+c+Sz6iVKVe/fFyQ1nT/ss3zTI4ZOyKGIuvinNhLV0lhKCD3p
 n9Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSKDvoJ3nkI7Tvx1mmR/b+FQ3i6yKN7xq+xdky9nxh2qYdcm2mH7UsCE9arxqpk7+ROlkY0QsmYstBS2hC@lists.sourceforge.net
X-Gm-Message-State: AFuF++muhZaGOd5AtJFFWSVuknconNQE3SbW/WqRh4M4M+TwnYMYlkU+
 y9zgbLe55/zh9T9uYYfALtDRQLMxPr/H2q1dtfdDdRsNWYZEjyh1d4fUk/kIAhrUut/8vnJhQ5/
 scKSousokxkzn6Ye81+GIucXOoyaYar7k4PKTcQTfHabITviBdDePl0honi4j9g0UNOG+
X-Gm-Gg: AR+sD11JFmehXaUDCGsOonhZ5t+hJQ5tIR1fz2wN4Y+n0hyLrpEs8JsPASJF12I/AYM
 IQHhplU57eIEACuZcsYOQWKU2aJGtvuiNEyS/z7c4RSe17B3ta7Q/LtPR2izDuN0uCrS69J5KM3
 oLsp8cKhSPQbxIvPLo3gN6VuRxtQmS8Mmq0UxwXWaxEvqLDC8qilbjG3guINpORN7s1Jl0kryDD
 O5OzhRDM6I6j6RLJDLlBuHahwbAwubmpd5BEIdeD0BlzhxyGhi1r6G1wo4TOgtei4md/cMgmjFJ
 axDDp+2LM3x87jtN22kOsCBXrZ8eosOrra+jMXJhOphdLGHejohsRlkWND6zv9kOd1Sy8g969Ov
 d6TmOF5/OQ/0V9Km6KN+WJcOaKU/BFuzkwTm1/9JMU9BLUps7yttFYphDpRTVqsnecLwtBGzDSe
 b14nukt93aRYP8fbbycbeGu9F6TwhtvX/fSG1zweKUsBxTIln4jmDmwqbjUL6BsMxIOLDnrCgSN
 oQiyeotwUVjac7IiUFYpGARZGg/FuFxXiS3RY+2t7RxY6wbB1kf36kVQ5HYmYTLCimxw7mAdht6
 otwW23UHlM0nYhO74wqIJotz+axoKzoNdU01oW3+aP/UVifRRPbLINU0aRr4I2M=
X-Received: by 2002:a05:600c:1549:b0:49c:d294:41e5 with SMTP id
 5b1f17b1804b1-49cd294439fmr300648305e9.8.1788274618010; 
 Tue, 01 Sep 2026 07:56:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce0b456sm82628765e9.2.2026.09.01.07.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:56:57 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 14:56:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
X-Gerrit-Change-Number: 1782
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1782?usp=email>
X-Gerrit-Commit: 2d51d6444e7d1fb73223752b9031a79006ee62ab
X-Gerrit-Comment-Date: Tue, 1 Sep 2026 14:56:56 +0000
In-Reply-To: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTc3NzIzMDAwLkllNzM1MmRkMTM2Y2NjZGEyYmQ2YjZlMWEzNmRiMWE1ZjI3YWZkOGY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <713cb528e0af037e26cb30665c7081a63555523f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1Pv6-0004WQ-Os
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 validate netlink replies against the request
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8399944463218198803=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8399944463218198803==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5xXK7Qq86qM="; charset=UTF-8

--5xXK7Qq86qM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

ralf_lici has po=
sted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1782?usp=3Demail )

Change subject: networking_sitnl: validate ne=
tlink replies against the request
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
Ge=
rrit-Change-Number: 1782
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerri=
t-Comment-Date: Tue, 01 Sep 2026 14:56:56 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--5xXK7Qq86qM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">change 1782</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7352dd1=
36cccda2bd6b6e1a36db1a5f27afd8f7 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1782 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Tue, 01 Sep 2026 14:56:56 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--5xXK7Qq86qM=--


--===============8399944463218198803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8399944463218198803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8399944463218198803==--

