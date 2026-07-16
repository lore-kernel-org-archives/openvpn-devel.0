Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713B7C44501
	for <openvpn-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEM16AItjuRuUcBfulH+A/LsYL64f29y0XBxcIrYrlY=; b=krMn1uqf9uAiGXa/mZsRtshGWC
	cVGTApYAy2T4nWE4gdXUHs5yOYL+mBpjf6DUQorLRuHBxJ8GhG6fIvFKGZrUejBNWAGaHPNgFw4qe
	MVW55B9xmDOzsBFGcaIUo1Va8nazIqNclhN5OapjUj8lsJRYQ0yLiMhjxpVTYv5vmCLc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkJv2-0003Xt-8j;
	Thu, 16 Jul 2026 11:06:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkJv0-0003Xf-OD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 11:06:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZPRj1QpvYzyfqYeOzcl4pg7buwnCho6qDBAj7VJdgDY=; b=jvCafjAT4Rz5LZzKcLcJa+Anrq
 2V59tvQxcJ0MuQ3S1Z8nVKnXzRMdZ3nLxdjEwdt5MEi7Otyu8PURSfLBenAj+eB10TwiYBVmJod+b
 MiBKyZz3XukA5CmjJ7uB4YrNMj+U+Aqlrm4TTeqCpY4g+ajOzw433sNA/ajAy90hC+kc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZPRj1QpvYzyfqYeOzcl4pg7buwnCho6qDBAj7VJdgDY=; b=Y
 cq/W5BGccFWeYotzvYAo40vTZ5ZaSraabIaxIvQsAKt0l4/bnPkt5NF/Y7Rf8zVC4Hzhz4OuS6IxX
 dSuK+gZrGXEpKzuRfOPOHm6xb6GNmtLpeqOzsxTQtwvdCf9hXyB7rAvVcVFIEqEC1upMsTH19qq1h
 ktJQ1wds7zhPOT1A=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkJv0-00019R-R4 for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 11:06:19 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso390359f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2026 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784199967; x=1784804767; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZPRj1QpvYzyfqYeOzcl4pg7buwnCho6qDBAj7VJdgDY=;
 b=Wfc7k96rCMyCfUT7OK3eSECD9p4EvEQVgoswrTErXnFZnddN+ciaefppcshtmz0m6q
 KWSaJLP0lZ3nxmWCp3teWCZaodQ3b+NKhK1oodeBhGzaiDqhWs0/UEaB36xy0k3u8+lU
 e+D9xWUeZ1OWVnxXFmO6e2noi5FEJQCopL1BdGDFEjBlym5bB6Bcz4Idg65IGJftGPoP
 P8Rjp7TmScSkj65gunXWGUrV9PXU9a0hR4nQ910cNQ2gFLrzq6LwfOkVy9pWVJyDHhNM
 pT3T8Uo8HaI59o0tOiBqSosid0GccJ0BVyo4p1TfHifXU+A5Jqb+0ToobIqrgf+/c9EQ
 f5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199967; x=1784804767;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZPRj1QpvYzyfqYeOzcl4pg7buwnCho6qDBAj7VJdgDY=;
 b=VVGudGp6gfD1bmuUu6CUR+x90jT5JtvV1Akk3zVm2+Xizq9cXi1kCZpH3Z7UGlczQt
 4vwkK6El2hCugyd187JFPxavuzoMgE5Zl1BhfDvLyus+e9V70PtjLLhgmtRHxJ4XOxTu
 120DwZ0KLg98QIbHcJGxd6PARvfo9N4GplNYakNMxgJ71SgGHWf3AyfjWu/rHh6CWXGP
 wHho6NbjIoa/RO++H6GYiixa4x9CspFSgbQPAxHuAro9Gucrgjl1iZs/Oy6PCAKjNInj
 cFqeFF3m7wBU6x8AqZtZHzOXhjACO7I3JsbUj5+kDff88RCTbiLw7SBNAboTdZTkaR7I
 y/uw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxuSGJVmfc48Hlvvy/x9gZSRSoY7XVfv7spl/qLZJa3nrhrVuXoLVuV3QDzprBMSrExTIeUiZuCxoV+LrD@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx3g6o/HFWj2iuG2lYkyFjAqdTkrW2McDpiYC6ZqljBmnqyRyJY
 YLiB7df5HuORD21PkwjiUpoYkh1B+9DafwTLm3oby8ZFOFXNzaWAPUjgFRA4hhBAbTNJPgjLQF0
 985La6yWlTm0VddOOtsbyVH1l2tGsr5b+n+NkRGvn80NfLUpkVAMnUGva3KzBY0he2Fv/
X-Gm-Gg: AfdE7ckfJ5+xqF2GLro2meWfhNnFZOE/DWax7LrkqU0/6oZPgASQax6a9nGq0C/3CNK
 i/epDmQssJ+qBAnc0kT6tEz79bLt5nRX3oFtDFDOHOsE+yeEk7nUN/C1r8zDl8NONCQ+h221xpU
 16i2OTmt9Ca7LsshDOTCYGsb+sP6y8uevjy52crv9KcJMpX0uPi/mVByDFju/0ncVJCjUibE1by
 HiyRg5+uJSZLPiJ1HuygOyRtmUtXQNi4zDh5FRp/8KzL5cxXb4oi0oCiwF2LDRMh8zcFsRR7sDp
 RXwju5GD0mE9srMeqQG2Sto4Sor32r4ymxollX1kb8PxrS6sz4TGRWtrqqkyOMNYGuZn4Cep3EL
 9hDu3s3HTmD6vqKLd6aHvh9ivozoWjvnrlvqNaVCaBtMeQxHDh246lxagO9SErBG6rGvWYdFGkf
 rHcjH8XLb4KulJStjxnhnrbifmz5fJ/iWl2pZyN9sqXrk1KMUYQ1d00H4Pvj/vH8P5T1kdJpSv+
 UJZP1uok39mu7Jdx7La8eP03kAfjtcHRQTlDDEKf3kGv6oVUsq7EbOxEVtXoz6gBLe4
X-Received: by 2002:a5d:5f49:0:b0:473:5bbe:780a with SMTP id
 ffacd0b85a97d-47f5a67a858mr2638416f8f.31.1784199966998; 
 Thu, 16 Jul 2026 04:06:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e036sm26921398f8f.5.2026.07.16.04.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:06:06 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 16 Jul 2026 11:06:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: 17d00ffc7d8c5851bc10f3b1c03e5c3c2badabef
X-Gerrit-Comment-Date: Thu, 16 Jul 2026 11:06:03 +0000
In-Reply-To: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <31fd3479b1eda244b6220d4bc5a0ea630479a49c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkJv0-00019R-R4
Subject: [Openvpn-devel] [L] Change in openvpn[master]: pool,
 multi: persist subnet pools via --ifconfig-pool-persist
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
Content-Type: multipart/mixed; boundary="===============6752062818756931346=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6752062818756931346==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5VoIeGriIh4="; charset=UTF-8

--5VoIeGriIh4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ordex has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1790?usp=3Demail )

Change subject: pool, multi: persist subne=
t pools via --ifconfig-pool-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File tests/unit_tests/op=
envpn/test_pool=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790/commen=
t/6b462472_71b664c0?usp=3Demail :
PS1, Line 226:     int fd =3D mkstemp(tem=
plate);
> ``` [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1790?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
Gerrit-Change-Number:=
 1790
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerr=
it-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Thu, 16 Jul 2026 11:06:03 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--5VoIeGriIh4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_pool=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1790/comment/6b462472_71b664c0?usp=3Demail">Patch Set=
 #1, Line 226:</a> <code style=3D"font-family:monospace,monospace">    int =
fd =3D mkstemp(template);</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">``` [=E2=80=A6]</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">change 1790</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I0bff8d0a549a65b7da01=
ea0e785b7ec8bea17f05 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1790 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Thu, 16 Jul 2026 11:06:03 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</b=
ody></html>
--5VoIeGriIh4=--


--===============6752062818756931346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6752062818756931346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6752062818756931346==--

