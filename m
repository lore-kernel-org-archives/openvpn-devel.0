Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8961C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yKAh+ImzAyWKuW92gEOqHgGdfwlSr93jYhaKgKd0chE=; b=I0kt7PbLnGRYRDtDbU31VKyfnR
	EqRtaFx4uKkI4orBfu9YqqP7DdGDVS1doyxner52En5DDGs9S7Ecyy1GK5itRyCR7togmqEE/MFZb
	isvmlkLX/TP2lrun+SdNiPExNnycy59fzQsiW80TyUvbc+MPgt/W2iZGcm63wz2Va8kw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whlQB-00011Q-HN;
	Thu, 09 Jul 2026 09:51:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whlQA-00011K-UW
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 09:51:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tL5SRk8WiZv3M8Wu9FHfSq3oOh9HHoc1cryVyY1v9KM=; b=FomqKChIMOd+Q3Dzgpe+SkHrIX
 tEKtJCFVzlMQQVgbY1xoS5CJwbrxOaBgjlRUoeRDkH6Fqwxy5Pel3sFn12AP6cxH1zWrOQt+xR286
 EaSr7DJE733oE17nd0dMLbmALkl+S29Xn53lbVA5PuzI0BMmlHsiGHSvLLQcSZpeGv3w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tL5SRk8WiZv3M8Wu9FHfSq3oOh9HHoc1cryVyY1v9KM=; b=D
 aob/T6cU4H0gfvrJ487IxvGJy5nbEC54Fr1zrpxJaec9Sd1ivfDVepP+mQAR6A+VUQiJsCrsRboeN
 UygCT92hWCXULb+WXPXm7+gxqnKszloeUH9dVvDwBgXSW8CovtXtG5fTWz0LC9BblR8EUSwIg6s3O
 10BoOljfrTB4J8Zc=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whlQ9-0001M4-HC for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 09:51:55 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493b786d6c0so8747155e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783590707; x=1784195507; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tL5SRk8WiZv3M8Wu9FHfSq3oOh9HHoc1cryVyY1v9KM=;
 b=dtue0DPQ8mPejv2xKZFRAu/7Zxia+ALBo9u2UYIFcp1FXK9/O2Cft3S45lMucm5hWk
 0hZi23gAArIcX/XTxb83UbdROgU29YYJ0xXML/mcj1Nh21HQ2A+uzbMpT4s/K0/bzJjy
 8esGaAOtUj67WBDYXhoJHLxKIxqigdAbl3X8XWP7PBH8uexKvj/p8a4uKmPfrQCrGH5P
 X+LCojVHShX+PbB92eEOGLp+2qiUItrz5otu4U29s0M7AO4lKLfchaNglpw4zPb/sw15
 8VxzzCnSukeXThydA5qom9X1ZAlfiZX1hvJa/j4Bp4Of2nCkpktzkjjb+avgwEEM4tSW
 eVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783590707; x=1784195507;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tL5SRk8WiZv3M8Wu9FHfSq3oOh9HHoc1cryVyY1v9KM=;
 b=X203uwPAQ3mKqF3K9ix/5jyJGpa4jUlXmUdmirQ0QlP3/8lGFOtm/T+C5VA2kd0Hzv
 yE0rgAyv3kY6a8gXKAnAYe8HLxFyirHGEl86sgwncOon+nTfeyn5L4VlYMBEG+Elu1Qz
 LLY4kLfyWjInYGcvivfp3S3IR9K2lzFtq1WNg1WAhIUBedjreieVp03QeAWLi3AFJ5aB
 EjVBXOoGPtDxJ2pIZIC5kw3kU0xIzaLhn4uglUmnOiF82jXZ2GHIxMYvPLqyfaDWkdP/
 E5pBatmC0tt4yvIVYGJXWxkg9r9XRQjENI0yj1Qd8w2oirN1WuzL0t2TVFDlEoVDm2QA
 atBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUZ+D/5+qVjJyqcaDwNxQLilz7ltZzavniQFEbgvbzro/EFSH2qQF2XbiZsrScpsQhsjIUd7DKl53JYGRZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyjcoV8ejPWJkWvBdp0WXzZj3MIfpqFZOUKNULx1v3EI6/gDNJB
 Yt9f0o92NQV3lkDGrOZleMDFtrBn++WKN7gZBwRlAs4LtyCo7y4Zp30GGc2LFxJ29oAHoI7zh58
 +ET6b4PkvEauNSrGbdnVrcw7RiY6Ip8IeFQBHYaG/Go/ecZW3oIZeSSMFl5GQZuAzCk20
X-Gm-Gg: AfdE7cmrwNiep58nv9PnNaUMumc0oSuWkUnhBy/QMpNpGRcGvwiS93qEkguHQ8WpN18
 PLt/moB9XSVjolXk4FE98lznNpzAvxKQnHXb6Z6b1/7C9wEJLCf6h3hbm+db4fMya83QTYu6uKh
 8VOmGY6+E4x2GLrIEV+gklfPIaPd2W+PeHn70lKpCLg3AIm7EHenh5bQpvWNnSSb4UU80DVZ/qB
 qVsMTwPnK+UFA7ng2vq5a7AOdhWIGqRKu4tz+ayOMOsjuRpEQA8G0i1pXZ8HOIstAEUeaK2OcFM
 I62yp+arKfY9mPrBqmGmqYtYUF7pH6DVCQ7lQrd9+1FXqP7xGXtNISQEEEJj2OW3yte5v6yqz7W
 LzIgq9y0+5ceIAlL/B6eCOS0Balx/3+bpnhyE9g8egF94jY+JwtwFDxck0+8MgK+05esxOh9BoU
 vpsrhUURpSyX/kX3nQhycoNb9o+tuchWDNG5IVZzxjgDmk/USefEv3hdyTlBNFQMfGgE6ioTHn/
 g79R6Y9bCGeFEtWk5xZpm5g9qyc7AtsbMkCRnjEDmBbT+1ED4+9OJ3Ol85zTSfjp30iiypfJ7YT
 dGw=
X-Received: by 2002:a05:600d:8444:10b0:493:ba6b:b6e6 with SMTP id
 5b1f17b1804b1-493e689b0bemr48551565e9.31.1783590706745; 
 Thu, 09 Jul 2026 02:51:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e582d4f7sm109733975e9.2.2026.07.09.02.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 02:51:46 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 09:51:43 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: 7f5cd4fa48a346b91bbc1e7c52c1d6351e8cc61c
X-Gerrit-Comment-Date: Thu, 9 Jul 2026 09:51:43 +0000
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <774ca4e2cede3e921b004169330e90203f28e58d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whlQ9-0001M4-HC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mudp: extract
 send_standalone_reply() helper
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0963089288460166885=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0963089288460166885==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WC6b8r5ak48="; charset=UTF-8

--WC6b8r5ak48=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1743?usp=3Demail )

Change subject: mudp: extract send_standal=
one_reply() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3: Code-Review-1

(1 comment)

File src/openvpn/mudp=2Ec=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743/comment/f40916a5_183437f1=
?usp=3Demail :
PS3, Line 40: /* Send an already-built standalone control pa=
cket back to the peer that just
Mark as doxygen



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
Gerr=
it-Change-Number: 1743
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerri=
t-Comment-Date: Thu, 09 Jul 2026 09:51:43 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--WC6b8r5ak48=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1743/comment/f40916a5_183437f1?usp=3Demail">Patch Set #3, Line 40:</a> <=
code style=3D"font-family:monospace,monospace">/* Send an already-built sta=
ndalone control packet back to the peer that just</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Mark as doxyge=
n</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1743?usp=3Demail">change 1743</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653d=
f268bba33889c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 174=
3 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Thu, 09 Jul 2026 09:51:43 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: Yes </div>

</body></html>
--WC6b8r5ak48=--


--===============0963089288460166885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0963089288460166885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0963089288460166885==--

