Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDA0C4451C
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gULniggJ4+F6ogEwhUsh6fKfdmTs+q/rGmY4EfG6DaU=; b=UfbDvDE4lFkWIQ6mnihhhKYZVP
	tJ5BBqP066HraU5ikPlqiIcXGXhxgXSdm7q633aXbXpWXzvOs7WDEfhAwMRwNi4qTWPedmUz7UHNw
	8VLqRH5oiuDR5qP6vDyqg88nWJioytzmqLiYhrrF8eUxGpBx9jgN89AI0VsZ764OF1Gg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjdw-0005aP-Gs;
	Fri, 17 Jul 2026 14:34:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkjdv-0005aI-7F
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tdWlVaD2lNMrUXukwdRUM9J8Jg9RK6bQINoVXBEN42M=; b=XA4HH24H7RVeGVZecPzdfrRero
 Jq4n+qgukEYk+9Wpsc2a4MrEWMAT81Gb/kKpjLZAjRHCQPUhT0CqVo23PMTqEOxScXb3af6Lnyt/D
 ON6T8dOJ9kLEkK0v8KToDBF8Fvv4YMr+3LJY8E02xhQSXOb6A7mioBdc2U8eEC4Bnvyc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tdWlVaD2lNMrUXukwdRUM9J8Jg9RK6bQINoVXBEN42M=; b=P
 ejRWrdTYbYG4+n0pvrYXl81K/oVPecpd9srdV0TpkOBDIS9+qwu72qBXmptumjB6uS50fqqqxY0WB
 gQj7WY1FwXiAy2n2x1QDEk7gTCXk7QBCZvPVacHLaBBMI3HT7vO6kwa6ItfunoEmBMXuY+2Izp5Jk
 YhzCxO587YxGNMZ0=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkjdu-0005Sy-Ek for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:34:23 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso7419538f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784298856; x=1784903656; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tdWlVaD2lNMrUXukwdRUM9J8Jg9RK6bQINoVXBEN42M=;
 b=SspBXTL/N4hEp87Q7YdqMarl543XiZ4fnV3VeJPaBfRA8exRTenIMPCM1I9KcXXx3y
 EiG6Aun5Z5BloXXBrI/7yGdJaDuHuHWb1ekXlHRqQu6of4gVJJb1ahGvVmKJjAsmOiJt
 Cdwzs3U2+Lg0C0KftQ1Zm+84404K0MzAEgutnT6zUtxzIU22aSNao4wRuhpy6ypF6fIO
 9vkU4nVKY2JZEpYbJzMytSX7mGCv5mBwoX/NEDoEQs+djEzpf1vzeDeMvemVGuQuCUNp
 2n2BsBnbr6VKURBFTUSoXo97w3V3vrVu9HQH6jaVlkWqTJExnBMJTdaCEQ6TQMFlfRHO
 s4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784298856; x=1784903656;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tdWlVaD2lNMrUXukwdRUM9J8Jg9RK6bQINoVXBEN42M=;
 b=PkJCBhbvbfroTsfxnKI/7lv9U9M5Gtw9J9bJfP5E6B8PanysZY9JsHC/yz+25xmRpF
 jeJHF+yHN8Q9Hz9ssAkwZvSiaW6egTSoG6xgld0g6tRJkhti7H14XNCa0hlK6Iq4cILe
 2CTTJ4aOBEMt3hROO0MtuAQtf0Iy0L6fUkW65XfRkKCzTplDZw0tZvWoGT/IQxAO45qs
 fh6RSAC95nb+xGrJgu0G6BQacHEC1835KzC6VbPkJ5qzFk1csO0gSpEWtlgolcstlJ0u
 y0vSvzDcVusMa0wCBTxVxKBpA68ei0M4/Fc6+5T417IwFeSXauL6Lom4EOsQ1scsiEOo
 HuvQ==
X-Gm-Message-State: AOJu0YzzPIgkZ5L1gsEanULlxY7lnGCEZNAk8comTn3trCQvHzSLQ3kJ
 bTP2ZRw0wMUg7CCM6nRPKfvz1Ks8/56VaE2GMGNMWgi6PTsXWTisY/q/Qdqinc627VPGcsTym/D
 t4uVhJgOl4H4/vQZVYgHh/rP9XKolFNYJ7hMAyTawLtxOutEuZl3jatQbDLHQUL9LiO3v
X-Gm-Gg: AfdE7ckO4ign87zZzza/Db9hsKEX43/Bmo38cuuei+g65Oq8z4xOg4nDuT8qg4EOkXP
 pOzUdx0y/gNg0/Ra/xZ8qmpdKOMcj0XEPsO1ddHvz1uynKhFmuaBRVPbtqn8ztiBbO7pRSF/1DK
 tOT05/KHmsTihDpl49ZO06JY+1aXJPJSyQ+ZC+iW8YmkHfsgfEcAIH9Yk2yJKCDghcMSc3YsA9M
 c8TMx7eo1I0+gbHALYGVBXUj/AGcEiVy1ci6qvYULH1AC9av5Zl2hggG+mpKfBBifY/Jw1VBA6N
 SIXW7UDNcoWEWAy4XLadNkHm8cjmraMoEBi1W2oofn9Q69PwF0+ZwwqOpnFSTlErTfQ8nT3mjjJ
 ri6+hMzw1o9G7NgOis3ZYSZVcvDU3Qhm3KfcmHBBu8pHrvEcM9AsL6xzYrobGMi3ij856RoWv6r
 Ajz4EE73Ja/L/4Lugzq3PD5AV442lhmKh3f9cGIKPrNlzXwEeoBqa0WQV9HHkz3ipOQsqjV6Iap
 z2i5S3M2tf6WJ4+hYyr73ta0y0JYWF2bnK5KUQWPpEE129l3w8iq8SFbXMGb15V4God
X-Received: by 2002:adf:e19b:0:b0:46d:d90b:bbe4 with SMTP id
 ffacd0b85a97d-47f6232c546mr3512459f8f.40.1784298855435; 
 Fri, 17 Jul 2026 07:34:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7f55sm3966411f8f.18.2026.07.17.07.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:34:15 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 14:34:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 6e4746b5ad1e73d7bf95b650d780b7a07e7a7506
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 14:34:13 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6438bbdb5b99aee24392dd402832639acf5dd181-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkjdu-0005Sy-Ek
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
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
Content-Type: multipart/mixed; boundary="===============6035408870517222982=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6035408870517222982==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7H7vvm4Ew30="; charset=UTF-8

--7H7vvm4Ew30=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a dynamical=
ly allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 10:

(1 comment)

File src/openvpn/list=2Eh:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/9d04d567_f5eeb4db?usp=3Demail :
P=
S5, Line 106: void *hash_func_new_ctx(void);
> This is removed again in #15=
73
Acknowledged



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1571?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If4=
7c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Number: 1571
Gerrit-Pa=
tchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026 14:34:13 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenhel=
d <frank@lichtenheld=2Ecom>

--7H7vvm4Ew30=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/list=2Eh:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comme=
nt/9d04d567_f5eeb4db?usp=3Demail">Patch Set #5, Line 106:</a> <code style=
=3D"font-family:monospace,monospace">void *hash_func_new_ctx(void);</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">This is removed again in #1573</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde82=
1899839324d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1571 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 17=
 Jul 2026 14:34:13 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>

</body></html>
--7H7vvm4Ew30=--


--===============6035408870517222982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6035408870517222982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6035408870517222982==--

