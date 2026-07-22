Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146F8C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G7bGP6cGKurTpigW0cyHcEBelf819jDVvnxYKpkAuws=; b=RMResBwXb2QNQl/4Hb2a7lIKTV
	ES8DiTpWuCS3R0GsHMtdGhB2XS/3vM/BZ+RAHlO49USxSKLqmBY6RyiYl6VupygKOLdb63qRVMj1L
	RaSj2uu9sqGMkyQuvuJlPwHTRn/qb4LA2SlDMFncck/u20ASzzYJHX/ZzOLtDwydzxPw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmWg6-0007p3-OT;
	Wed, 22 Jul 2026 13:08:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmWg3-0007oo-Rh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:07:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fQcvXG4QSuLZO7G5yTPRLBmsQ/R+vtOJFWGCbGi0BaU=; b=edYYNlJd3GLY8gp+mmX+2gwpIz
 ULCYSslF3Bp2T12qmuwshVRcEmxlRenqoO/QYKaF15k3DTeEjD9xgXInCIzWpw3mBVr9AgqWGaaIq
 hB8BNcx/gcEWeVkqAPo9ZfeAiUxVMbZNFl73mOGpAp3FOE7myCoOojPwGJyhdpCYkPTg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fQcvXG4QSuLZO7G5yTPRLBmsQ/R+vtOJFWGCbGi0BaU=; b=M
 LOMrZuv5MbEAJIFzP38SGKyZxO2sazqZ+hz5rnD0Bodox+K0aYMzyRRAO4SdmYYV+Z/bUD5Wljuea
 PrulVnjEuzx55NFoqKG+nIH7/5uQnlhuFInzfxC6T5ZB2yhyWcPIdFB+H9ttUISV0ucZkSzSnqepR
 kO+CO+s9hnDYsspk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmWg3-0006Ur-2N for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:07:59 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso21479025e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784725667; x=1785330467; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fQcvXG4QSuLZO7G5yTPRLBmsQ/R+vtOJFWGCbGi0BaU=;
 b=DQ6nk1wgPbNBHZHLHVuV2FNrD+hVHiXTO/dHtWTnIA7bzm+4Jdx5pW3Lvh8M1VZ5gv
 lLT72ur7QxrfnzpzK75QqWAyCrH4xs2uBDQJxnfioIK87/L+6xPjZDKDBicwRpzXC/yy
 IQHAofm2dPWXUzUrAPdb6ePP2Dd3tVC3/p8KHV+HfXHSZWCKCoMf6pEoIM6voHuRCNbT
 Vwr5IYiKTOiCrtzGy/CwK1UT+tijpEiubw0ZPj0Xf90KUPbj5mBoDJRxM8x8lInNAiMP
 Fc6i+XlByycwu+PY4a7A91kDlbUhNSUcwHN3b+bNhQf9xZtNB4bIiONJWjrzSE8tSDyo
 n0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784725667; x=1785330467;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fQcvXG4QSuLZO7G5yTPRLBmsQ/R+vtOJFWGCbGi0BaU=;
 b=dUu5ppb9TYAoy43X2Ti2M58je5ndNdi8NkNoiLnbGVxEDC8CMKNe5cSdKRUqndkcRv
 TQMX3ZMUswXVwzEkWLo4XhqdWNVl4DjgCVikrn4/nfiMNbI5y2vWhK0y+7lMHJhuqfq0
 x7WxjiI2L0ea5jCRAk3tyu/dEu0B8UUCetZ7k3b0Fy0JZcRKamFOsuKlqopyO8unHJdY
 5gEg9MjtoSjWaLc0XZlresQHXbKSJ96TtZ8CZQU4o7SjnFjX1AftZnD9Fad74BvZk9vl
 +rpsze75LRkcS3VyYLySmzwgUWeMU2qCFlqPM2bkL4Cvb1JpZrRRy78cKMQdbPej4dQR
 kdow==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZvf9eoaNTPGJwv4Bc6RFmyvYFkjYDvuj+4Bp1o/W6bEUKRA3zp8Oi132g8/y5IIatBchsu7LC8GY8zP1O@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzXV7ugEDVDRoVRh+5QFukpUhqSlxfvKO2I3aH6aIVTCgBoNhKW
 8hrw2SE9JHb76ijw7nfK5C2gqDVEEzicsk7NtQTf4AFO1gYifuM7fG4DC+Fw5ktNqe+QtypVQ3z
 HZDMKOs2RgY3w+t93QrTU0e7jmCxZLzJAx9X6KNf+lambENw85lKqsn6rt1yVbWj77dRg
X-Gm-Gg: AR+sD12I+z0Q1qXcT3yPYH/Z9kMehyC3w9I4rKpXzRFkynGR7oX7d7gmbtKdbXbtFVP
 Xy3IN7imyiA6nxrsDGV2Ik7jTQauW4njqwqj9xFqTdu1ZO0aJsSqCqJFST7R0znDv9GnUoob0r1
 V0DaQCmpThCiXG8RRxHrTz+9O5zYuZOv0sIBLp2BaC2WXz7svdLJOIywWPP7kek0i/55PHESvwz
 zZCrBu52nqVUj2IBPzygVi9aKUTcJ9i5UXttdt3LaKxG7KyXEOS+gVTWRcs8z6WaZhu5VOiW7OA
 gYt4LnZUuBBAPpJLRI047yxKoTL1E/2DjuEytt2+D8/1+1qg5y0Owcyb5GuUAshlPqqkyEIxsJ3
 Fff0CF34GV+t5+raoSvYUdViNkfSMlm9JJnGXkbscGY2+FjCjiPaLhooHP+X01aDUVjf+9f0TbP
 GPg0ZHJvYCcSRHAjGSL1azO8dPPzjs0svRF5/rRocTJriy8WkK1aS1oSQANdVuv/u8JlfZkO8VD
 YWl0TPd3Eu1Dok1Pt9IeD11o1HAus6630E7n5AHKqUAOIN2b2h3tEWwgKOpgT69n+rz
X-Received: by 2002:a05:600c:4747:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-4956a4a14ecmr46734795e9.0.1784725667093; 
 Wed, 22 Jul 2026 06:07:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956d475e24sm36302655e9.0.2026.07.22.06.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:07:46 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 13:07:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 1ec92ed73b843478ad10411fc63aa76cc3f1b3a8
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 13:07:45 +0000
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <86007280563e7c945a82f2d160904f7bc645db6d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmWg3-0006Ur-2N
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove --providers
 option for Mbed TLS
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5186727775318091364=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5186727775318091364==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f6spddSe56Y="; charset=UTF-8

--f6spddSe56Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

MaxF has posted comment=
s on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/179=
9?usp=3Demail )

Change subject: Remove --providers option for Mbed TLS
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(=
1 comment)

Patchset:

PS1: 
> Ignoring it and only print a warning was by =
design so you could share config files more easily betwe [=E2=80=A6]
Not re=
ally=2E Mainly, I wanted to remove the option from the --help text because =
it's not working=2E And then I thought, I might as well remove it completel=
y=2E

Are you ok with removing the help text only?



-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
G=
errit-Change-Number: 1799
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fi=
llinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 22 Jul 2026 13:07:45 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--f6spddSe56Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1799?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Ignoring it and only print a wa=
rning was by design so you could share config files more easily betwe [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Not really=2E Mainly, I wanted to remove the optio=
n from the --help text because it&#39;s not working=2E And then I thought, =
I might as well remove it completely=2E</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Are you ok with removing the he=
lp text only?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail">change 1799</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f56ca69efae0ca37=
6eb9eae064a893c8768188e </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1799 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gre=
enie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Wed, 22 Jul 2026 13:07:45 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--f6spddSe56Y=--


--===============5186727775318091364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5186727775318091364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5186727775318091364==--

