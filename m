Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701ADC44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3E4/JAJFz/kWkDZJWoxW+3XJLK99fhRVBhkVjSex/s=; b=a8eaT4WvICiyotD4LrnUwh0zb7
	vFZQG8Yty2igYzV3+VjceYMNY9P37iz+WFmxGTr58ubeINSrxubs5vhEO9aEqcyRyDyhmovZWPdrn
	4nlDoST4d+pogMv1OMovHmDsbGfD4GGTKYuaKrNGWrIWc50XgnOXaWw4uZ8hoPCVLF2s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1CV-0004ib-8h;
	Wed, 15 Jul 2026 15:07:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1CU-0004ho-I8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:07:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9jtRewJdmlGSxb9KgwSty2fSqJzkGAEF7kQKLc4SnT8=; b=dzE0zQ2RzjPAWh1zPvo9NoMIXn
 09vEtFcj+RZWDoWS/DNpAq236K2qHwze+1sQToGrhGUrNdiTjfU1lFZo/UyDJFekNu0j2x2W5Wp+i
 WTnDSBwlpcL8gL7Dtnqc3bC88yw4CNvWCPSxe6ejCGE3gIFyw142unnqYgUc0+phaG5w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9jtRewJdmlGSxb9KgwSty2fSqJzkGAEF7kQKLc4SnT8=; b=f
 +og04EOoqhXqyX3IAJ2yNAHoPKb0yF8leh5vvIoq5pL8f8Tn5NqtpGevIH0yQ6FdqrNnaCAcEWUjN
 zEda4byga1IMOZphclv8MlvH6ONNlFVVa/2eDkCznQDlbK9uIXvZWQj1qiHY/NJX/3KcmJzOL6skG
 tIndfyV2c1lxU/S8=;
Received: from mail-lj1-f178.google.com ([209.85.208.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1CM-00078n-1B for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:06:59 +0000
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-39ca0a30148so44710611fa.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784128006; x=1784732806; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9jtRewJdmlGSxb9KgwSty2fSqJzkGAEF7kQKLc4SnT8=;
 b=H4UsKXxzfQCX/iKJuqgJnb5VYjOOwyTJHhfoaBWtCG0OAWXsMOxIoQuY0tGm531Pbr
 W4WdU1BoSXbAfDz3/gGZB6fyWptNkE8NLTwJLs7u3Jl2KRIFRM17Apj7Ne92m2DFinKa
 xQMB4ZaLiZN7xaOQkdadP+ycPOksReDqjErk3pd7yrX0YoQy7aLBXLcJ16d79hZ2CO4z
 eE3ULz0z16tfFuuIGy6DKK6+MSjQF0myWbvUCl0UmioOl04+aadtVshgfu/88YiSFElO
 Z9+lsGzk5taMg+QgbUvjVS+vwJDMZAxoXN38Vhqbo5BQvoqBIw3q7A9M2KqRRAI4VGqc
 2Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128006; x=1784732806;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9jtRewJdmlGSxb9KgwSty2fSqJzkGAEF7kQKLc4SnT8=;
 b=re754AWA7N/CBihlAzb0XZHf4jP6SZ9Tc4i2XLddIB3DiQMU5sPIShI9lfPS2TTZ+L
 lbde/Ar0m0pt0nSMD2cc/UiqftZha662DRkzckheLc3Sr0bHWNkixuG70fFHZGGEDbc3
 AQrH4TQRo3k75lq9/iWjHqLHhXlvxCB0nOtpyPRnfWWBWBa8tsjd69xe1hLoshzfMh48
 oZ3mKY3SNbPOKA8PcMXwKTX+hU4nIxbRFNa8w5QgpmbG3ORc34TMyzS4QC9tpu2qcnbX
 c75CRnl8Q3EwrYq7VAQ6KTtEjKWA497pyuK1gTxQvpnuEe0d6dDnVqd3Y/gtWdC9ttaT
 LXzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpH2MeJyT8xcIuWT0wY8kY+VyO2YUj0XNCm1ROXmBHtSN6TzSQtwNbROnDohMwnKh121mAw0gJMaD00vhCY@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw78Qy3NtWwhytI7PekSOXOJRMEeSWENffUSnXkZawIG+WGnCcb
 dtfa/uopUABf8zuiQFZo6wrf+FSBMuz5VzKDtp1CQMd4Uy1wONdGjZ2cHityz/+GMfBwtR9giDy
 r48zvbiVReyepMgqB3dEQMdKQcpObfQotzRF+TkOJ0MeuZpftBxk6vAvY3dusMcOcaJMMQOztGT
 xWPcxpTA==
X-Gm-Gg: AfdE7cmpEG5GZuu0Ba7zgMrlEj4FSHlpvrDxZascpOmMdCig35ASZAZUuctLbxuR0JO
 23LjQSQMAecr7ZPlZSMRNComX37TwQSScvBzp7s9FZCNwBBviMg+b0kvwHDiRzhR/Z22UBV1UZj
 NwojhvYVQBXTD2ojsho65/x1v6HVcOWLzprzcfr+0obnfNcoOq2Jn6RTeFqOh12TEvEsw52ltgl
 g19r3gFMgpMRrYToscEFx4KU/cT7kPK1zm140g2FI19kAvakQV0A7GY6NjWgWBeF3bEI+KsEovc
 JKuAaXs6VxS4GjYeX5qHEgZip2aT++pWAoOc+1y+0B8K3mwLliQFyUnTiLUDBmVsbIr5DzWbJMp
 0ugfOllNbtcCcRY1TbCSpImt1ifVdXtvjYLjuVsFF8rqY3AsU3RcaUvN59lXcZzO7N6nadRsHCq
 mGb9lz5HC8A4/TAHnUIUj9gK6PZw3kG0UY0Uu8Lt9TcuDlMOrkCNJF8hY7EBIFSEwHthq1nMWYX
 9ehdvy6xkHS3hcV5v51CKsYezBFEpYwWmATm/WcwraGAnxG0jxUARsXRmKMvlRs0Mtr9YhZfzCs
 PbQ=
X-Received: by 2002:a05:6000:1863:b0:475:f0c2:75a5 with SMTP id
 ffacd0b85a97d-47f4fd2b7a5mr3246659f8f.54.1784121883647; 
 Wed, 15 Jul 2026 06:24:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c4320sm16045664f8f.32.2026.07.15.06.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:24:42 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 13:24:41 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: e81f65f2b97d657d6747bef40e2911b19ea1a938
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 13:24:41 +0000
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c9a56cca49e4ecc0ba06d8965e5c8c34bc12f62-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1CM-00078n-1B
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign
 clients from a named, tagged subnet-pool
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3992400739450076843=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3992400739450076843==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X+mcCKqUj9g="; charset=UTF-8

--X+mcCKqUj9g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ordex has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1783?usp=3Demail )

Change subject: multi: assign clients from=
 a named, tagged subnet-pool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/options=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783/comment/0dca37ab_e0e5aa1c?u=
sp=3Demail :
PS1, Line 7634:     else if (streq(p[0], "subnet-pool") && p[1=
] && p[2] && p[3] && !p[5])
> Please add new options also to usage string
D=
one



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7db95615d99=
ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-PatchSet: 3
Ge=
rrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 15 Jul 202=
6 13:24:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-R=
eply-To: flichtenheld <frank@lichtenheld=2Ecom>

--X+mcCKqUj9g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1783/comment/0dca37ab_e0e5aa1c?usp=3Demail">Patch Set #1, Line 7634:=
</a> <code style=3D"font-family:monospace,monospace">    else if (streq(p[0=
], &quot;subnet-pool&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3]=
 &amp;&amp; !p[5])</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Please add new options also to usa=
ge string</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">change=
 1783</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ia1e7db95615d99ef9687de7c4e996dc8033e2631 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1783 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Jul 2026 =
13:24:41 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--X+mcCKqUj9g=--


--===============3992400739450076843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3992400739450076843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3992400739450076843==--

