Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AEAC982FA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p1MMr3Q9iMhLNpiKXD5BE6sSXV2FH5eg2GF63Oyk0jQ=; b=bqOGyG0yvuAlns5Q4zR2jhNEsu
	sHyeGuDBRyx10gNfm0t9doqlNrWewX7AIm8fcOauqTrGwP9RcBw+rIIjr5rRSI/V6lEGHfR8msGwS
	ByYbWkKU0s5sJrDng18dLygK/1KwhLMyeZS7bJ8fDStKl5xnSe1fgol+M0RnCpcr+fwI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9KKz-0006ux-P0;
	Wed, 23 Sep 2026 10:36:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9KKz-0006ur-3z
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 10:36:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HcSgaVM0iqKuqNesUa+O+i22gZ2nu73z15EzW6u6D9o=; b=D2a9XcRF4mc5idpg+o9RrGRPM3
 /bPEjVdf2o2poxvrMx1mHumjYOwf4dAjHv1niwLE5j/Qn++QXy53zsypokmwfPCD5RrUYNZxfhn6u
 vC91hcCQ0jl/iqOtyKhtHvaZlD2q+ML8XM2oBN886AUPnM7KWtLYQIK0gQZ6YaO/QCnk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HcSgaVM0iqKuqNesUa+O+i22gZ2nu73z15EzW6u6D9o=; b=B
 TmN5dU1PwKLkfRDf9Jd1WJgC1tYaCLZik4qwIp8zkQO+GG9S5lGl4Db9KJKHk1VWdKvquMYtxYvXI
 wXKJN0Q1IZLr1X3KFOpZhb1pmBD6C/WsV9Mcqgq151Fj8oKzCbJbj8oYckp4RVQ46GrAj4h16/cYz
 SNeMa6yD/KyUibYI=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9KKv-0006Kq-Fq for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 10:36:26 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so6331835e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790159779; x=1790764579; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HcSgaVM0iqKuqNesUa+O+i22gZ2nu73z15EzW6u6D9o=;
 b=M4dfQ3RK2L4EBNJvn4C0q+39yxCusNnhi+GFf8W1gxFrmojvrum89jS0y11H/CyYrt
 xTHBvrb9PGLK964FbM+usTFvp3w2UZFN7O+Ic5y/rmdXk2rLg6/nBWe9n07NDX7WGG5V
 V0WRmq1qWO8NXIi2JCLrRBchlLhYhiLvBaGQr9b0keVmqUGewkV4ebJt/CRiIg/y6Gtq
 G5RbVxFYlnQlXfP0miGHPW2XYd3DHqRdYBHGXS15GvVSAR5uCL0IWB9SDLErhFjxLf1f
 j0ojySEcZuEoNdoN6WGoxrGh/A+8A+CWbZnr9KemWf/4QFoApSWVtzOS68kiaYeroDGB
 UxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159779; x=1790764579;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HcSgaVM0iqKuqNesUa+O+i22gZ2nu73z15EzW6u6D9o=;
 b=didh/1kvNnZVOs3vqfrH1Asq+JEW1xqfBF83z535+kp0j7FKzqQUfpoR3qSc0dPrVQ
 PuwQ7kJInturbnBwGThOMmampMp+3mDAFUvfRoNyE6Ui6XXIgzwNk/2ojrOvC6v/JMyU
 FU2AISFggudD5YuvYlFL2PwbsmpqgtvVrTOTVF3INT338fWN3Mx9At6RmBFT5VSfUSaJ
 rBx1RdsNGqWPcv4yWtvm6wKfGyxCKu2QbyK+wbQ+koQ4904ByGAroNFzG8gGPVE5qGtI
 1Eo/iTBvhUtgMREb2WagW0y3QMYYjivudP7l2X+qzfz/0JTuIf1ipom+k2QJx+5zqYm2
 vNcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+VAOHBbKD2jdhVMyYqVYP52DhbQEt28w4b/+ShZgLuOGkI6CQDwRNOldIyucl8CzcdvJBXNGbY3g4sBbq@lists.sourceforge.net
X-Gm-Message-State: AFuF++lxaz4gUXtu9+KFMIe4XkepngH3de4EX/sd69I45D8wcOyKcL27
 Lk+TDzPEMRX/uTJ1CKVSsEpP4AiN0p7f4wPEgwKbwXGN5pevQ7WkdMH2oTfi6anQ9UYNQOwKr7C
 az2fcMLNLKyaByPu1/H9T5o99kYVs2Oem01W/ItPuN+DJZ+nXdhW0IU29n+l8pcTyTVoZ
X-Gm-Gg: AYBFou1mqSmcIgIcLFLFKQZnwBXN8U2q36vWhUXlREv+k2Se6VSFeGv5mFIfdeiHxiK
 8/GTVZow02xPVHbWakRzGq85Hy5Ymh66gN6VYwJ3cABO0S10yq4aE83ds0/vy9uD5Nt8tMm70Nj
 Q56x0dpR0FOYGKOB8RpR2MkDxIhICr/uyMzwL5+FYCqNlko2ysNIZsyFSYxjUtJkOD5wq04y/Hl
 AtpwlFLIN0Jwy/JplnJ/XJMVUWl+nuzRHVi20Y1gciRa0Crc4QkAWLsVQ+r+N9Xgj0m9DkaOvng
 1nZTOzT0A/wBUUqHvlEGvtF9x3DBXg2zZS8o+Nlwf2mf13MKYmNLHdO01GEDJ4sigBYS6azwVDc
 vTHU6jLmqeGW29FU1twKHSxw5etVgNAfP/izPqMtCly1goxigZeIYoRua68cRnSm/CyiVjP3WhN
 veZu1QrayxfRFc96OvjxZt8Y5p0gaGhUrS/Hrvo8zQR4CiWGQQyAAIh5xtUVPJ4uWQR7WwWx38b
 JRtspH5X5ZSoz7TPjMd1LYra4clUE/EqpJr6ff/t+7ZEuMKfwPMiASM/sa1nRg+QttBJNSQOQa9
 3mGB8/PBIm/uMT4+wdfsmSkGzoFwgDOPvo+awQ0dZRFnCUpfsSxMSQdjmcgBSElqtqb06B4=
X-Received: by 2002:a05:600c:1c0e:b0:49d:797:83bf with SMTP id
 5b1f17b1804b1-49fdf12b442mr32488555e9.21.1790159778873; 
 Wed, 23 Sep 2026 03:36:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde134739sm63324985e9.0.2026.09.23.03.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:36:17 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 10:36:15 +0000
To: srkyn <david@srkyn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: 67bc78c7f97e197fe98ce901e36edb13709376c2
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 10:36:15 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <265f144767370a0196d21271e242bfcf6db9e8ce-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9KKv-0006Kq-Fq
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, david@srkyn.com,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3996311429901399244=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3996311429901399244==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M04KTcPBnjw="; charset=UTF-8

--M04KTcPBnjw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, srkyn=2E

flichtenheld has pos=
ted comments on this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1881?usp=3Demail )

Change subject: compat: close all unrelated fd=
s in forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 5:

(1 comment)

Patchset:

PS5: 
> Thanks for the +2=2E=
 [=E2=80=A6]
Nothing you can do about the buildbot checks=2E This needs to =
be run by maintainers=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1881?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
Gerrit-Change-Number: 1881
=
Gerrit-PatchSet: 5
Gerrit-Owner: srkyn <david@srkyn=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: srkyn <david@srkyn=2Ecom>
Gerrit-=
Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 23 Sep=
 2026 10:36:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-=
In-Reply-To: srkyn <david@srkyn=2Ecom>

--M04KTcPBnjw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, srkyn=2E </p>
<p>flichtenheld has posted comme=
nts on this change by srkyn=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1881?usp=3Demail">View Change</a></p><p>1 comment:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;">=
<p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?tab=3Dcomments&amp;usp=3Dema=
il">Patch Set #5:</a> </p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">Thanks for the +2=2E [=E2=80=A6]</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Nothing you can do about the buildbot checks=2E This needs to =
be run by maintainers=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">change 1881=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacd5=
6d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1881 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: srkyn &lt;david@srky=
n=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Sep 2026 10:36:15 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: srkyn &lt;david@srkyn=2Ecom&gt; </div>

</body=
></html>
--M04KTcPBnjw=--


--===============3996311429901399244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3996311429901399244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3996311429901399244==--

