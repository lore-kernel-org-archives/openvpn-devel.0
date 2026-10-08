Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEB0CA600D
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+XgT50gw2JYojYhjLGY0qynB657m+4lNRTInwd8KUSU=; b=bXs4dmzmK7fyoErfvm7osUsPNn
	rtc6T0ksly/MoF4XcJGx56NizYaZt/SByDFqb5kLO/A8CGeWfKxfE1eMZo1MGqaSJWKAcJbDiVfv8
	31up9ghSY17JZvuoUAdTDa3CS3MrIMH/2Amrqn0mW3ta2OOnGCEgXhPO7EhadUGGoW5M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEqaT-0006KA-D1;
	Thu, 08 Oct 2026 16:03:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEqaR-0006IG-Ua
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:03:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wy7Irv8JnNhUGhY6l4NRVRd3HPy6U+Oh8xvb4nWLkQA=; b=foDSqRfTzg78HxqZYz/5gqWRal
 mQd4K8OKWwtOhgekXtT7od8rbR6+/wgChD1ElBtxRbtsALQgbJrA8O5zYGbWKPt8XAhgy4P8qCZIT
 dZT/L/iOj/vL7Kx5Ljvx6NOlVKuyiwWw37DYiVcCAt2j4AAt3XZmGjQKSFIIxZpqE3l8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wy7Irv8JnNhUGhY6l4NRVRd3HPy6U+Oh8xvb4nWLkQA=; b=F
 F4wNc3nHRiUd3No8VBQ4wcnLuHZMtJoMt5+sGBUdfhHeh4dNC4/SM9+szmdEtOQIlhDbyzqQsT758
 JQITKFVjS4MHj6RVayY1VvmGJSFzQopRlGc/tgYoFjpPXHz3/IpJk+lUB4H+Vrrjl7fPKqwWcfHW1
 BfhLhNPBa/GnogsY=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEqa4-0006ZY-Li for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:02:55 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso5319482f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791475366; x=1792080166; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wy7Irv8JnNhUGhY6l4NRVRd3HPy6U+Oh8xvb4nWLkQA=;
 b=dn8ZzeFy6KqHTTEGXC8C9fg79lr1Y6v3S2nh13C4dlR9xMFQY8y7K5KDg3u7iLaz2O
 aU+UhHKY0E3besxeUfo2fIwTvIEJJurjdDmnOWZ6RE5K3gPtEuLbySMdjVDXK/QmteEm
 0IRujuIK2pnWr/Au/HOFZns40L7jr3B/emVb59O4hs8ZrKmonFPJ66vqa0Z2oOl8sWh1
 zrnArgNGfl2RkukOj7f05wZPqxVN9NRBAskcpCQKt83gwP8w8cTAQNr9CKk3uNBpQYg5
 jFgz5pHXo8OsC9Dfhb8LnsJ0QR74aUVrP4fzCEoEeIfgzFW+x5F5sEyb8CSI9aFJpi9p
 /QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791475366; x=1792080166;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wy7Irv8JnNhUGhY6l4NRVRd3HPy6U+Oh8xvb4nWLkQA=;
 b=zLBZfwNIGnwqwJd0PfnmPjuD7MAesiDii0udz+vAS4iebw7sET01hweKGb6Y4KqWSe
 UOo3lfZABra+kkwoyBbALTiA5WIVEcRhQrAsinFRtPQuByWIVe1+WOMmtbh+I4gcsIzv
 GqrEVCOYC4YXtrCPAHeguRwvPC9T9ic2P9Wdap18lw2qB5hI++mUo8fNQUXQlihOE2SF
 HO4G9utWOEYd9nIXPAPlP20c+eBEJhNIvab1KcTJztljKKnDJ77cTCZx4BY7Euk6NQX/
 dy3NVCeZABIMvn0otK0/itMElm8QMq61Aqn7cAf1n4axJxe5LvwxICC30KjARw0LaLHC
 gh4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+quW0tEUyZUHRwTiOk7j9dmlF2F3lR5J+suOXltlaKt/ZdK6QAde1irOvm8+6g4dbphvh7DKBZkHoSHGp@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLX235UalQ0sv9EgrKgQJhDBdiWhWFikWMHN3CzzwnX6ncuqw+P
 jIOxbPpiO7noazkxIbomofXNCgngUks4gw8BrtHCOLbmI1O+ZVqQt3i09CR262Frp6N1ooI23S6
 asw7fMXgpkGTFOuXFysGbPp/LXE9sBEZBsmtNp4C44YmTamweK03XoQK9XeBRxZm0Xn9p
X-Gm-Gg: AYBFou2HBkB9YYlRT2VvsbjIWgry6ebAnV5Gn25UzNN9SibSNLgWS97aTBwUE+CZzL/
 MuGV5oYeY3zpXkPyzYviOX2qnS5sk+GybXtqK8eWhpLsjB4GpkldURG7mcxASHjsUjmQtBLlRDH
 NBpXgzHfF0L2ja0p0a0aa8i8fex15bpE8T5RRYyOn0uKcjl5+VTIjVBZLqvTM0INEsnYb9WNRZh
 S3blJSQTRS4gl5l+K2yP/TiL18N3SdrmCCfLJ0x16cAtj2ZFn0AjYgctErsfGQhsSgGaps3lmfO
 w5heweNcsSgRlnBc7Kxx8SX3htuqCGLnnuQippj1ATLcZFrxUrZzdLox6XlU13DqUXS4VwTbrg/
 CIt75sPYwHLEo/uvm7b2vB9HbZugYiSir63jXmYXA0JN2Nh02Gev4h2C1CJGH+mpsApAFFErODz
 jumOJ6ztaFR3Jp5egskdtYKR8HQCYnbZvxtAsk1nEMmaDNwJXNsAHY8nPTAmQgDV+ruKvRN6yaH
 Jyeglai959lutnvJV/SwZQdmn0GC0f41ane62asLoq662gPhljwtA6bSG4DMSPY4ShMABsZp5IQ
 CyQzaiVp9wrvOMohZWzPGLV/Vd+QPqHTMoHPGlXEuE+OwRv7dODXi8rQHdyM
X-Received: by 2002:a05:6000:4a06:b0:48c:a08:5858 with SMTP id
 ffacd0b85a97d-48c7288f864mr11541984f8f.23.1791475365698; 
 Thu, 08 Oct 2026 09:02:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db63ce485sm377859f8f.8.2026.10.08.09.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 09:02:45 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 16:02:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
X-Gerrit-Change-Number: 1987
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1987?usp=email>
X-Gerrit-Commit: 86829f5cd9d89561c5eae4bb556b27432bc11f79
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 16:02:43 +0000
In-Reply-To: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
References: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDcwMTY2MDAwLkk0N2UwNzQxYzc1ODMyYThmM2ZlMTYxNzY5ZmViMjdkZGJmYmEzY2RkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad71c2f619d87b41aee19ce05ede9f4a8fa270bd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEqa4-0006ZY-Li
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Clean up
 rm_trailing_chars
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1559609278176130522=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1559609278176130522==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HBo2PP/94ZA="; charset=UTF-8

--HBo2PP/94ZA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail )

Change=
 subject: buffer: Clean up rm_trailing_chars
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

Patchset:

PS1=
: 
> Actually on a second look, `chomp()` appears to be the only caller of =
`rm_trailing_chars()`=2E [=E2=80=A6]
I would leave it=2E I think with how i=
t uses strchr it is a natural generalization=2E But don't have a strong opi=
nion=2E


File src/openvpn/buffer=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1987/comment/e9267163_9a6ce16e?usp=3Demail :
PS1, Line 606:     }
>=
 This can be compacted further to: [=E2=80=A6]
Done



-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cd=
d
Gerrit-Change-Number: 1987
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 08 Oct =
2026 16:02:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-I=
n-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--HBo2PP/94ZA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1987?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Actually on a second look, `chomp()` appears to be the only caller of =
`rm_trailing_chars()`=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">I would leave it=2E I=
 think with how it uses strchr it is a natural generalization=2E But don&#3=
9;t have a strong opinion=2E</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/buffer=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987=
/comment/e9267163_9a6ce16e?usp=3Demail">Patch Set #1, Line 606:</a> <code s=
tyle=3D"font-family:monospace,monospace">    }</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This c=
an be compacted further to: [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1987?usp=3Demail">change 1987</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1987?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3=
cdd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1987 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 08 Oct 2026 16:02:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>

</body></html>
--HBo2PP/94ZA=--


--===============1559609278176130522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1559609278176130522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1559609278176130522==--

