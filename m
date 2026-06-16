Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF492CD98E1
	for <openvpn-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuuaN0DOubOKll7cfzPqd5IHvFri8UNI7dj2FCmbyyc=; b=HR4I8vtjvci9M+jJTnJM3eNgZM
	ZKk98rnb+73iOuAynL8GeQpHNfgZV0QH+zQpkOBxfRjFKRCL4zrItgys1/7LpGEbPoKGoSrJGFNc/
	3pHdn55L6UxJjDmuXEsSO79xHk5HJ4EsEf0Y+sFGeAU+A44ke9OuLmjkZN/WafeiXBQ4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZWXa-0003l0-Ih;
	Tue, 16 Jun 2026 16:21:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZWXY-0003kt-W2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 16:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=c1D2W7Vl5NEoTR4dxCNRNgDmqSkuFH0QwtIHHG2L144=; b=KSR7MAbefAhNqFMUlHfNEI0/Ap
 T5vQGPZzqsvzdHQktLloJNStbG+612xtJLkM+yCawDlDUyKtcKwQEd6tf2p7ZCS109I0tXPpXJpjj
 KsTgJOYkOMSmq4mBRKoPGWGvtmlOTi3OFhtY5tOisi+xRBaaRFgTxYb4Upu+2sMBMWDo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=c1D2W7Vl5NEoTR4dxCNRNgDmqSkuFH0QwtIHHG2L144=; b=h
 YNyp3gzvsL+v2QIbZhlXkBap1aigiE/KUkp7L3Nj/oMBzo8lobCUk8pljXvovBqxZvfZQ6L8HRdj/
 5JQBkG4FOijKeMQUwEVSRxh0ZEK4a3DLuae8wl8BwuLIBygXGlahhBOpAEpN4/UPWHcQTbSgyNm5I
 5U0jhvGcgEtxWnmc=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZWXS-0002nX-G3 for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 16:21:26 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so26946f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781626876; x=1782231676; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c1D2W7Vl5NEoTR4dxCNRNgDmqSkuFH0QwtIHHG2L144=;
 b=Jt8hruyF/Dzvs9nRULIQEfGW40dnROsDDHS6XIbws7JYK0EtshDGJo3kohLSj4GmL8
 +hJIVWsjCAQvtZXMQp6q4gPIhRP40JUSk+Ta88SqoIRAyD5z4RUXEAQMYak9WeGwKkBz
 HaTbx/08SpsHQ+Ab1ARoW4kW7dqvs1DervRr9tHDqZ9dYvSxv2WQrRORxN8KKkBOv3i9
 4VQQJHeejUbfsOpIa70AL9YN5282xVkjRthN4Vc7WXBoPW6aj96J19ZJ8zK86qbiseEv
 bX1QBRLWv7DNFs7SolDo5BnzSnDmQ0vGQE9sUKNpiULVQrddjp10XJDoKutzYOjW08h4
 2bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781626876; x=1782231676;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c1D2W7Vl5NEoTR4dxCNRNgDmqSkuFH0QwtIHHG2L144=;
 b=DzdI+tDmWtfAfWjwZkoi1xv+LnLx6jUP0Q1F/XFbMsAsNfOlsHnWyu7+ZXhorxp1sv
 2RKwfxc+/KIsIzryCwyYCuM6XaWHI2M8iqtlcaAiXRHCgR4X5D042EN+VJvYber9EPk7
 tSwEsGCdQ1TVE3PxgFk3sGvwucwbc/zvNHz1oytlIv+0XPLFXd4z9mrCd9edHEVEFnFV
 lBshZ2zkV8Gv6MAxXc683ssCF/7mZNnXk6SnmHfwiK0KTeoCdWQPhiknxPSdsUU2Zr7X
 ERlV/Kc22hrmE/3287ADiG7VptM1e+LADG2c/3RvkJO4qP07boS7buYwymh00etehEX7
 c3YA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9J12ZoNFde5OgRc/s/hQ5uWSb0BWn/nM/oNLVEhxEOTjyhDdgTTOdA8n+dwPTE/w8y3ZwUw9X0OKJNYCcO@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwVpXUecuOS26m4paLWGfMjSU5y4vBZxnwglmdd+AicQcC5DQMc
 f8Z10wprD7RVf/tlwdNxRTwjVR61YrWgasPxDsj45BdAkIixIKjsD96asulAYBaHCgQkl4Y6keG
 DMcPSelO8cHrA4lhp7SBxKIKKnTcyyxWvFOZI7NuFcb3mm9+zZl62cY65ul85TJiiWRH+wWMqbZ
 FZsF42SA==
X-Gm-Gg: Acq92OHt30iMzxVzOLY8gAyEaddxiBxrY+JDnDcAS31Sg0jYZV8hKKtxqyJHgwDFg3E
 HdYB94vZn8jctJGauccutV3wDZQ9BxfustuTb+TMOZDGXzRcmnXU8bEZ4GpYZczndLzIiVkdiJc
 h4DGHwT7D1LOt/LMAGRXRV3K71aO+/DTNzzgIygz874m4009FEMbJcw7RmvD5f7JfAX9bomnPJ2
 mtRNlg7Yk8EXc/EeutfdFabRZOx3qRNY92W4kQU8GDTV/nUNg8sTn22RvRbXMCIb13Wg+2n7TqK
 DLzP70T80DBMvX+u9wK04gTJnOabfCC2aRVyWwMUX6gwrMrqVuS8lMu/fhS0TNw3b58U3DXIqrS
 CBuNlsnXBwuqc4RIJaGK9pQGZyAFqm1zTAQbcGrnR7Mt4Wp5+ncCdYpywc1kxwTe8tK9uqbLIoi
 YjewvoqABDGzKLpgySmyLIndP/Q3u/Ne/O1yo9bYC9CIPDugwML4siImqdfmMir06fnw7rqmC0Y
 Ban1/mh983lFXkZon0eXZCwWu8ZiqoWIpmLILZ2W+czj4wK+lVaGKxw0L5qgCIfEK4OzvfSkNEG
 RcEDPVhWwMcjo6ZvO50UsXQe
X-Received: by 2002:a5d:6d4b:0:b0:45e:f93a:2069 with SMTP id
 ffacd0b85a97d-4619f31369fmr5754007f8f.23.1781626876265; 
 Tue, 16 Jun 2026 09:21:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm48607357f8f.36.2026.06.16.09.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 09:21:15 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 16 Jun 2026 16:21:12 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 9293beb911e4618a0cdaa9a81384a96b4acb46fd
X-Gerrit-Comment-Date: Tue, 16 Jun 2026 16:21:12 +0000
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bc3e23889371f5516b069311089b9b96538ec467-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZWXS-0002nX-G3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Multisocket: use
 event engine rwflags for UDP I/O
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5667685027702635252=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5667685027702635252==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V0LeQP4iueU="; charset=UTF-8

--V0LeQP4iueU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos=2E

cron2=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1635?usp=3Demail )

Change subject: Multisocket: use e=
vent engine rwflags for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Gerri=
t-Change-Number: 1635
Gerrit-PatchSet: 7
Gerrit-Owner: its_Giaan <gianmarco=
@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: ordex=
 <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 16 Jun 2026 16:21:12 +=
0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--V0LeQP4iueU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, ordex, plaisthos=2E </p>
<p>Patch set 7:<s=
pan style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padd=
ing: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">change =
1635</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
6b303805a3688b6f6363140c76853a58badecd8f </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1635 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gi=
anmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &=
lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Tue, 16 Jun 2026 16:21:12 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: Yes </div>

</body></html>
--V0LeQP4iueU=--


--===============5667685027702635252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5667685027702635252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5667685027702635252==--

