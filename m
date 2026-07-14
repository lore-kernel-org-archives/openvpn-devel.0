Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082E5C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jRkju1wy1CZhiB0WalSezW4q8BA16CT/mQhNkzd9A6c=; b=k0/SUidIQdp6Y4+plJ8HPUe99o
	Vk3AmHiam11BkSROaHvUw8UCd7jfJEcD3dto63RkBXx/NO6fouTGyvDH3iN5i1/LzSl8L315K5wIY
	qRrpCl0CiOPkBtsL+65s8v0ty7WFuBxXe1m+tBiMsGjIOttZr6z6dkF6lmBD+j3LY0aM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjaoX-0001iT-84;
	Tue, 14 Jul 2026 10:56:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjaoW-0001iM-0v
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 10:56:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Lqjz0VKwth1rgBanDSRRHDGydW4mC5zy2HcfoMkbYGI=; b=V7EizRF0poqpG+wcBivPXklqrb
 DhyXyvfL1jLPN2ahXrsbzfF1xCaNaw6uth332vhkxCBxt1LFWqsWsPRbzqNWUSqkn+5NeiiVQ5AgK
 iJIhPo3glN8nwl1wDO6zKzTetVXmyd5bJL30qec4exALYs8Y68fjaqYbgE1GtiukFK24=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Lqjz0VKwth1rgBanDSRRHDGydW4mC5zy2HcfoMkbYGI=; b=R
 lenbRx31yO0YPN7/B0K9y66emhEwnQgAcwBFiSV0g2lwh48TQVpjaluEiAwljP2z/0NaC+tbob6LS
 9xrP38JuJWAt1QCu/hYYlvix7PSC+OCxdJd4/1DJdVS+DWR3KEiAdq1SNXEGFyTBPm9sWsf/S0U8j
 Z6bizBai7u0/IWgc=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjaoS-0001qU-Qd for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 10:56:33 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f45e206dso4725695e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 03:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784026586; x=1784631386; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lqjz0VKwth1rgBanDSRRHDGydW4mC5zy2HcfoMkbYGI=;
 b=Q0aVXJc2+m+d5KhWWpkuRMG1iymQdS9jScWSKzZ2jGXwhAiXcvfb1yTsX8FoPCUp49
 xnzcQj2CCniF4cXuiymvIe9+eUt3jAF5BYessRGBewgGYRtLIe1JGEtZZpokup/jLRKf
 kwRl6MOHU0WiJXddNPNvr0oG1VIkdIC+mlhWQr2rYAZtPM4nkwSsshrxn5HaxBQ6TBz8
 m9wbBh0Rp/C+L3MMuDO5AYnzAw9DzO3X9PTwrWiC4S6fetyeJvZfrTBlKt/Q1G+ZVPIE
 7UN8lCGawMKUfr3zTQ+2JAm4cx2EmxWmELGVelIrebqY6AXvHRNyVa6ElPJ8edm1EVH1
 ZVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026586; x=1784631386;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Lqjz0VKwth1rgBanDSRRHDGydW4mC5zy2HcfoMkbYGI=;
 b=lKufR9ZAy6ffmU9K/v5Qn7MMee7rZZt+ywpSQ9yHKUrYQqJ+SV991kW772cgxKYz6t
 6twwPzpbVBbxyKwOQ2ACIS0oT4WhBsAyIsRb3pa4cEkplkpA1nFaZYnwsAVcpQG2zPg6
 U1InqF3sYGK7RSYiXHTEWxVP4GiV4LwgqE7HPLFx+wrJ2i38G01l9Nj0VotjU1lul1oD
 iNOvwYzO5VaX1TG2R0G+4kFh7rkK0AMExivP/+pckFOZtcEJV4ADzX+CtuSVBWYk099d
 of8HWWHEljoetGYuCMPRNYGwbYkTFR+hN+w87uLgCO6seBu5L2xIlIcBXiuJyT2jmdqX
 S7KQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8ioOH9imKgG8MWA/Qo7nCsAhdfoZLolQ/CKRWlVxL0PcXul8cDD0FWqp3soafj7q7tT70Wp9IKCZxQITQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwVEsYqrMCCoVtrIk/uRt+2Uj/UaoS5bENtxW25zHDDi8HM9Apg
 UatnXdkv/+GVDbFOYEvdPCce9eWRpEhmbf3sMs5lrcdaCvApn0bH66dVZZq6N5u9kUifqDCCkjg
 ZS7+84a1T2sJ6W4aXWY8uZDQfNydbICaHL7d+8A2/yKE7MFYfkpLeJeOJKYt62xRc9/LU
X-Gm-Gg: AfdE7cn3Ruk9Q6jCeh4JAOjEr3SUbHPfMB1KbcNLIjDzZ9UXV7Inqejqd4wACfQkOQ9
 8TcZEKWRb+vDlxZFlLMaVoAZMi5KEhWuuSC5L7SYJxXMOCBI7cNSkj6cJTfhFeXTaL8c3BYWMRY
 zluzhz97+NVbKj4nD1x8JkC+UF/Ui7eamIQjKXTLIjA1AFev0hKIzecFypg8z/dA2gVxMQ8CGCB
 qsdYoKflyFOizIN27PduPgpa8Mw2fzxKJLN5c6UqKHI53pPCVw8cT2aix4iFR4l2yUwoSr6m5BL
 4I7clvsrWC2gavGE2BaZVNFyF9oV/b3to5YGB0A+0jGqvFMjh1PgPCw20WkAO4UwzJNLZivZQGh
 Ct+sNFM2tPOLjiIyDyFBK7XIo8lWCXAxi1Tq0/EipeYaB07CEADwPkBuGlOw9CaD6bIeOPhbGGQ
 MJpW8ErUS/xRcgC+EsjGT6OrZDAp5IfUm2JdtSsAhjWsAgNucp1MeGi/BwOVBao1xNod/6zmPhx
 tlXi3Lk3EtxKQtVwkPxD7KdShLkNiFRGrMCqguztDaIJXSdnxpN5o6+s0Ddm9r6rPSekmCs+kKa
 CH0=
X-Received: by 2002:a05:600c:37c9:b0:495:3a52:71b1 with SMTP id
 5b1f17b1804b1-4953a5271e3mr2000465e9.5.1784026586225; 
 Tue, 14 Jul 2026 03:56:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f86556acsm236485305e9.1.2026.07.14.03.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:56:25 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 10:56:23 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 71a6b89896a36a08adac3b61bcccd949bcf149c1
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 10:56:23 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <edc5bb508c915fc07d7ed3c9face0c5e4c169309-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjaoS-0001qU-Qd
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7003429408106089544=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7003429408106089544==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nCHHCmNJMqI="; charset=UTF-8

--nCHHCmNJMqI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan=2E

plaisthos=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introdu=
ce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 18: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Chang=
e-Number: 1089
Gerrit-PatchSet: 18
Gerrit-Owner: its_Giaan <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: T=
ue, 14 Jul 2026 10:56:23 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Ye=
s

--nCHHCmNJMqI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan=2E </p>
<p>Patch set 18:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 108=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a1=
3ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gian=
marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Tue, 14 Jul 2026 10:56:23 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--nCHHCmNJMqI=--


--===============7003429408106089544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7003429408106089544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7003429408106089544==--

