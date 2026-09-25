Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FCBC98324
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PER6SsZX05NOVTiIC1yGYiqKKW/zocgNCi9NzOe19pQ=; b=IhmEAn0RWRkUMZFKvX5u6NJIBc
	DlygS96/R2xVJ+Z6oHGQGqrATcnVhcfEKXoaDlg6tlNWz7PQd6EjENs4uYgYKH0ulX0m6+ieWUM+4
	HWJHDs1la9I9OUYyayDkKiEqLQGlIoJNLnXQObj77CHBwXYon73OUOcD0jEAFmrodk0E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9vsD-0007vj-Ln;
	Fri, 25 Sep 2026 02:41:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9vsB-0007uI-3I
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:41:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=I/wIuImz0O6lvVvFgf508sXJ3bWfxHnnn5Qx1dRw064=; b=YvL43KztW+ddnSmDKU7ffVJNlZ
 X5sy26xfSSCdfxoKj3Li3g2GT8uYDb4ul0SwgsnIxWBF01GwJ43EGnPi8Y6dqY5eAp6aNAB371mGY
 hs9JBvhfqlEhUT3/LCs7qu+jnXlEYiQwAi7pzbJRTg5Inxe3M/CVywMAOLi0u70uP6ko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I/wIuImz0O6lvVvFgf508sXJ3bWfxHnnn5Qx1dRw064=; b=d
 gwelCBckXs+ZebCKfYZGqjOJ99Yn6LnMgLfP6H+k0TNNrBRV5HsvXkPkwi0Tyc2sjQqibl8cNcdc8
 iCQn/ypTyYm+GKAgKDpetyiV6DeKZLk9l7/cvPyH1e753d4zFk1ienyPAInjZX/JoNYexXgO7NkZW
 kCEe6+3n1ajBrzkU=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9vs0-0001CR-NM for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:41:05 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so2249285e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790304058; x=1790908858; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I/wIuImz0O6lvVvFgf508sXJ3bWfxHnnn5Qx1dRw064=;
 b=VLKnGQltqAJfltCtLnI13XkAK43ON8LiIOGx3fbaRwoBs7rQuK/Qwd7Bw8qAwkKdcy
 mhSYwy/BVj9cfLxjCi6W6gdCfFJgH1BzITm7ZUEYaj9kwA0BcmfRJ1F9wVAiRrA0eEjq
 1Lm48lAeYhnO+yX97IjWFIwXB4qA2h/UZHokll6emc282Vh98GVs7QCwaFWm2T+Pk9/i
 gRiaHr/vBEP7etT/U7yY/hXxYs1CtrLBDkuxz1rsIuE+yuB6BnAOpWYCElhein8S2Mog
 kpaolppsyjAaNs4RgeN6xJBN9lZ88LtSl91D5KZMqpSwJqsH2ZXPjVsHSoY0DAMnRORS
 9J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790304058; x=1790908858;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I/wIuImz0O6lvVvFgf508sXJ3bWfxHnnn5Qx1dRw064=;
 b=dwSOcVYIYClsdEZlwUoSjTZsXlq4GzvTCUmW6E333BqP92Fljm6btrJB6luWGbe4CS
 zlkUcd/3toY6ZhxU148ljWoWoEJTiwU0b+Ruh/2OIIiLnfvdwnt+vIPS+42kayY1ZL9a
 E86YbjTWnE78krrI94hu+dl0EjxGtKPvvtWbXC8bTP00lCvXbhKg1G7kYenYdwXx36KB
 p4kOqQ9GjNgA0a/qteZzz030mnUzkdZJLNTEP4iW6V3O9h7/Zd3/KEI5kwvz6Z5JoWtv
 EdFtZkGOvJQzX5MvMkuQyCLZIBJ5gdXLL2KFzyGLLMHl5sg1ObM60gAQCkX8OvpbbQE/
 fVvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6O9qbiDvsB287OniI8W02WMDn+VqzvnX9nEec25cAyUKwBj0N+oFtUP/K/MHcFCDDfqGD9RLqdvYawflF@lists.sourceforge.net
X-Gm-Message-State: AFuF++ku3/zmqmRLshhmHgcMhXKd02CeNF+NWknvmp9wRBImiEPqUXxf
 l7EAFjuSs7l7JY/HwleOW68OcyuCeyUUdUP0qlwLIzd+D3AvDj7Hdm6nJQVFPTnkPlsrKRV9pSO
 7kMOfgQZImqCNzO4OpuJnJLbkWssO5veFjpz9WM5T5GhH+3SqKZgYvbaEp4qaWuPGqFaf
X-Gm-Gg: AYBFou0DE16CWyK0RezqAvo1kaqV+khRjuMrycspYj5yfLTPqG/53tT0j6IKUy6Tw9a
 NtXJ0meHsrVCs+OH1KRxjBc+9x1Qh64R00vuUXlaT1K1nTk9cwTCVsCBsQTEV43EEEx+si4rFvU
 DsebHJTKSrxG6g6SOSV7DBQNNeFira+kbHmYPx/CtMEgrZdkVuBruKEfCTv4qhnYXlrXj2bhLoQ
 PPr+zzKrgqfYSaivfcXqrrZydCMsutOaXCqjOIF1fRrEU3KRgF6kMsNua8HUkXmxSswne9muBY7
 OhgqAR1s3fXKb9JC/NUkpsP8fgHc5B1+3Upo6IHrgL+4Kl+C8HCoqfTbZVZ52s39M6YOlfVvqbP
 KUBrKrYn6bylVZuHZOSjdNKPHJZGEakPRUoU98s65z7IbzQ0Hk5/KwpaO9szllO5B1beJXbf9vf
 w0YBbkNKwSMkyyZFig2LIYEohGwFXWhidfadI+Y7kgwmKq057PG92VPMR1T/Hx6oxxOPsaSlIWR
 pDnCsntuWFaF8TmxOurjfiRPAQoCPkK4outQtGNzeW353EgPpuvZpfZAjj+ug3hx/9SK7fUA81X
 bBQyhWZSX4cZLt5HEqsxJso6G70fm7hynEPe8enLH9Rtn8YH5YLH9qZTiZWs
X-Received: by 2002:a05:600c:4e14:b0:49f:ce78:3563 with SMTP id
 5b1f17b1804b1-49fe66f1a7bmr68574635e9.20.1790304058141; 
 Thu, 24 Sep 2026 19:40:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff27eabc1sm8377485e9.15.2026.09.24.19.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 19:40:57 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 02:40:55 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: b5a04e7484242f1d3ac861ce929773c19fd58732
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 02:40:55 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3810fc69b9a0878d0633ebccbcddad4326eea096-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9vs0-0001CR-NM
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tests: add a unit
 test driver for route.c
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7747225630574600769=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7747225630574600769==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U3VAaEp0p+A="; charset=UTF-8

--U3VAaEp0p+A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

chugly has pos=
ted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1946?usp=3Demail )

Change subject: tests: add a unit test driver=
 for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2:

You are right, thanks=2E The stubs in the driver only matc=
h the Linux code
path in route=2Ec, so it could never have linked on BSD=2E=
 Restricted it to
Linux in both Makefile=2Eam and CMakeLists=2Etxt, the sam=
e way test_networking
is=2E

The three helper tests are platform independen=
t and it would be nice to
keep them running everywhere=2E That would mean f=
actoring those helpers out
of route=2Ec, along the lines of options_parse=
=2Ec=2E Happy to look at that
separately if it is wanted=2E


-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085=
574dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 2
Gerrit-Owner: chugly <=
charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026 02:40:55 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: No

--U3VAaEp0p+A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>chugly has posted comme=
nts on this change by chugly=2E</p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">You are right, thanks=2E The stubs in t=
he driver only match the Linux code<br>path in route=2Ec, so it could never=
 have linked on BSD=2E Restricted it to<br>Linux in both Makefile=2Eam and =
CMakeLists=2Etxt, the same way test_networking<br>is=2E</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The three helpe=
r tests are platform independent and it would be nice to<br>keep them runni=
ng everywhere=2E That would mean factoring those helpers out<br>of route=2E=
c, along the lines of options_parse=2Ec=2E Happy to look at that<br>separat=
ely if it is wanted=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1946?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; =
padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1946?usp=3Demail">change 1946</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085=
574dde </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1946 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Fri, 25 Sep 2026 02:40:55 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: No </div>

</body></html>
--U3VAaEp0p+A=--


--===============7747225630574600769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7747225630574600769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7747225630574600769==--

