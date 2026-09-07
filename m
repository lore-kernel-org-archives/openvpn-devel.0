Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EE9C79F9E
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0PpoGhi2TZjYYlP7z1wXPRk/+YA10jhhDwEYsqfkvvA=; b=A6USD77xk0+S0JwJGN0yzGMsvr
	Bxphhb7MHxkQHZY/Go7/9PVfhobE9lb57sa4n2XzF9YLHq9ECWas2Hz9TNw1RfeQRG4nVMsMupGqg
	iVgQz5uL/XZJuUYe9fQ2Hsf0Stn66hjBn2ZwNiessaXGw8hcChtV+fkDEZf8lqAhXrTA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3Yrm-0004YJ-72;
	Mon, 07 Sep 2026 12:54:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3Yrl-0004YD-82
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 12:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QSHLKjUpkvZGcCNLlNjU8pfLPnKSQhUultCU9rxfBDs=; b=GHOVjTMsYsb5fXl8GWIJg0dPoq
 XJTH1r35XgVYY+ZLlfd6WuUSfH0PacWXScKsjyVymSp6nI/OTL4Q08MkL+bzMSWRItzf/d5CKbdu+
 hRUuHYUybmZtgl7Ud7tXc+0WqsEg29Dho6CkOQZttpjOcZJDGvTOep3xK5MdlSpdj7lY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QSHLKjUpkvZGcCNLlNjU8pfLPnKSQhUultCU9rxfBDs=; b=Q
 l0Cldf9M+RcHiT8xw806Sah4LQWAonwXZ5q1ixRXzrC0VmJ2jZTeMrpXNBtps8eNMYmD6bf9CyNT2
 s6QpTDBrvSwXHpo4vC1k6Hqxckoz0YoQl15xo34m6w0yNTCttNRhss877SrQU0CVWoN0oWKXMN0aR
 0849d8ariLxoeNbk=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3Yrk-0000Xq-8E for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 12:54:29 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso13786535e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788785662; x=1789390462; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QSHLKjUpkvZGcCNLlNjU8pfLPnKSQhUultCU9rxfBDs=;
 b=Ru1MCIYhLfPQBVVPNdmNjJ5SkDBCOQ8v7KTkdN1mE9jBTsTKc8+n+ldx0KSAmbg44h
 XoKB82IkFdQJrMisyMAF8KriJ+4aNQLkT0NMAxhVs1NVZNKlNzLoqTfbA5ko+3LFUpKc
 2nEam9yktB0LcWOBYEpX+uTrfmCwIuLqlX/VKoYwibKZ5fdYQ3mR+LsStz/kPwPjS9vI
 OoTP9jdkC3VbE11Hs5wrcuNDecWMofq032E1VyrMZOX02si5p0LUeEVHZ4v/qutPhXRl
 FxhRjikwxz/iALDc+AgdzwNL4pcmYyaL1e61PI3rUzRHw7gBo7O+gykKtdoo5xe8M1dB
 W06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788785662; x=1789390462;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QSHLKjUpkvZGcCNLlNjU8pfLPnKSQhUultCU9rxfBDs=;
 b=QblO01GWxYVlwOpT1dpMY0T8ccPvskJfCsFMSxzXGzC7oJ65jXh0xATDx9zMW59EUY
 R+GaXHXJZQp63NZVseP3rerMUDm9/a13MtAWW2wVSv2eXqqITePxWom0hZAswpviZvJp
 0W7lxWO9aMN6IySGeRuXwBys4+6Ef34L/eM2fW3b0AiyVaKEcOlesiFUsYA6RjKSnIXQ
 EppR+gzAOH2+z7PpdPp2a5T0zHeBQbSjWondGnrgpUW+zaEerJRF2yHeket5NG2yP22+
 ZA8H6lR3WA7u5Io8l+9E8iv4kGKvlBVXZcMo2F985A8SE4gYEXzTpWxVh6YqLhPSaprS
 ge/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4tqd6e8pHT530pIB30/UHTNG/aIa2y6nAkCnURXjw73/IWymN1kkVdAHp0lPyDAVnAG7ITHclBMBJ58Uk@lists.sourceforge.net
X-Gm-Message-State: AFuF++nw4715duOvnqRaWkP8kDBA3pscmjihC51F3GiRUy72u/jJqCct
 veRUpzfk+sITfewSgsChEzKFrzGIBySfYslTDD/eWlVe3rLJbNJD6JuE4AAJF9/XVuIVAKROkOC
 u6whAdujEnLlEu+kRTOO5jgElPvTUK+uTc+tpW56PEfcTJA/ihzcqDpKcH3oCYFlWvJg1h9WzZC
 CtWzWC7w==
X-Gm-Gg: AYBFou1eMswt8/DBfn4R+SfaqMlqSwkghKvA5qtvmhOP2XeJXijPTPoe6JiAQ+g8+Kg
 Q7qGxU5doqYxoOl56SmBZ8UUegXDBAZx6fU6c4Fw7c3rl4gN9XN6RHRJD5wFyN9SE2oybezrO6o
 zor+ngX1wNVwO2tuCdrFPzyV35swL8+lbse3A3DB1ksNR5EK7MTGddDCQ1eyi5UaI8RtsO+Rkmi
 yVUZEcGM85nmu8O8SuWdYZAc1rb1IAN3ZM+Ncae2o458z36vEbq9D3+hQ5dxdpl+1LSicSFeBSm
 GYVQcjpj/YOpKBYsXiMVKXnfjk3tggdaZKEaErXMiedm6WLCBedZh3qaKTU/MMETpCpiqd4yxTs
 0xZoFkj+/0ni2CEuC0NAP58r4By3T+iz0Jq8rS021vxmlrN9/lqSY2PfUSF2KmeC/r6RKE2+rw8
 YcUOTFy1pCDEsQpBfXAtzcPY8bzhFjOE30oJaeQ7FyGt/ekcN+u3vd59ef183BEgnfSaFN8Up8k
 AXsuVGeXB/j6gceYxlZVmdHpbWgB/gGtGlO3ilBh/Fs+yGq0Se628iILkp3gqT272yvRh6NNLHu
 rhPW4hWI0xcUIFldR1SVR5NB2IACuV4/yHMHYUERMlio4VIFAKjaenwYCuDT3w==
X-Received: by 2002:a05:600c:3b17:b0:49c:fc6e:8cb1 with SMTP id
 5b1f17b1804b1-49cfc6e8db3mr168665445e9.21.1788785661574; 
 Mon, 07 Sep 2026 05:54:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883acd33sm27311762f8f.18.2026.09.07.05.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 05:54:21 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 12:54:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: efb1f77d28be164260bf4235949ee81f9aff5124
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 12:54:20 +0000
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1ae08a821712faa72373048af254765d7653b39-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3Yrk-0000Xq-8E
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.7]: Check for
 null-bytes in certificate subjects
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8881391135238293940=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8881391135238293940==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8MwNJGYmWjk="; charset=UTF-8

--8MwNJGYmWjk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, syzzer=2E

MaxF has posted=
 comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1902?usp=3Demail )

Change subject: Check for null-bytes in certificat=
e subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

File src/openvpn/ssl_verify_openssl=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902/comment/ff834928_84e03501?usp=3Dem=
ail :
PS1, Line 389:                            | ASN1_STRFLGS_ESC_CTRL);
>=
 Why remove the ESC_CTRL?
I did the same thing in the master branch=2E This=
 flag was escaping null bytes to '\\0', so the check after it wouldn't work=
=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: Iea1481e=
94ba1abe18c39d81cd797187c88427571
Gerrit-Change-Number: 1902
Gerrit-PatchSe=
t: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <steffan@karger=2Eme=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: syzzer <steffan@karger=2Eme>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 07 Sep 2026 12:54:20 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: syzzer =
<steffan@karger=2Eme>

--8MwNJGYmWjk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, syzzer=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/ssl_verify_openssl=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1902/comment/ff834928_84e03501?usp=3Demail">Patch Set #1, Line =
389:</a> <code style=3D"font-family:monospace,monospace">                  =
         | ASN1_STRFLGS_ESC_CTRL);</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why remove the ESC=
_CTRL?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">I did the same thing in the master branch=2E This f=
lag was escaping null bytes to &#39;\\0&#39;, so the check after it wouldn&=
#39;t work=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">change 1902</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: rele=
ase/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea1481e94b=
a1abe18c39d81cd797187c88427571 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1902 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;stef=
fan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Mon, 07 Sep 2026 12:54:20 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: syzzer &lt;steffan@karger=2Eme&gt; </div>

</body></html>
--8MwNJGYmWjk=--


--===============8881391135238293940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8881391135238293940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8881391135238293940==--

