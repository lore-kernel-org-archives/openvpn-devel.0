Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05310C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DMiacJ9uUItweuUousOafMwtlNi/Lieo8r5Qckw8wz8=; b=dddWaBOGY8dLZHwzmRA2fevoZ4
	f6wRVKvmZX/XJyuJJCm/wDeF9GaiABUZ3aTnzbvwYlnw/tNh1c/A+9h/zJV/7Oje9JXZZLopPuK88
	15hgexyHAIbVtXQwerFrzOW/THHGF9mBKq4vmuQSnxociTSjTncP+rJUMJ16uutcwoaM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwejA-0001Hs-4b;
	Wed, 19 Aug 2026 11:45:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwej9-0001Hl-4Q
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Wv5maSy2Is1xRWCVpqTCdERQVSFXicdVoGJGlpadsc4=; b=iqOKWFf4NwSMhH5ZxuGz4ayCz8
 U1Frw8wKMxA07NRa3Jn2MH2RB/zMHNXB95ikeOlfSBhGFgmMH65BksJe8+81U2rStYKDjCbDg//MW
 hzUJp2XRVzFwcKXTAj6n0OGuvUkVg6kGud8csLtl9uvhZmTz142XSX2UObBob+QXpWzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Wv5maSy2Is1xRWCVpqTCdERQVSFXicdVoGJGlpadsc4=; b=e
 3vZYJu3aEEZBEP0li4Pky/k2fajMzdnRSnV1vF+hP+93YeJdBafKiOrLZgXMk+ejQ3FwkCHU0Nkx9
 clNxsSmZwhZfXCzgoRDvzTE6eUj0fHDH4/TcvJeJmb2xaOX/3JUE5/WbdBQZyc+xfztT3T1+yowQV
 NJdcUaRp2y9LilCg=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwejB-00074z-E6 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:45:03 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4956869750eso5676725e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787139895; x=1787744695; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wv5maSy2Is1xRWCVpqTCdERQVSFXicdVoGJGlpadsc4=;
 b=Eic+QPNcbmzooOQGNGfEHkXAQZfM0wFfYRBs6UpZO5skTp6xIr37tmRrWJrFC4EQuN
 urOKVMvA+fmYrF47Y9h2QepboNy6peWcrk7hbWSEw0inBrM/697ikH0uhpKXOcHLRs46
 Ej8lhv9yrTtK/j+deol9sBsFh/JWyXHHV/n7IdulzHNnoM/Apg1i+2vgh/JNAU+lUGwr
 Q3Aaq8TVlgbEG0TuDiw48HrNF7JRb+nF7hgOtb2EHhc6tKJlvMBbyHX2yjIp+EUBzH7q
 EWG7689uAlsP0AzUSlnF0Moq/Y4C/wKHhdeVSvlJZViY0DdECnLMJNEL/IdBWVr88CBr
 JZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787139895; x=1787744695;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wv5maSy2Is1xRWCVpqTCdERQVSFXicdVoGJGlpadsc4=;
 b=DCjA55kbwSl5tUd42Mr02eBUyayrN15NtyBTc6Oc+dvAUCPg8v8alLKOfg8FQXyYT3
 kbY2NxSEtza4w5iCJ0kwTOobLCWbyyLGXPNo7+oaTi4jIW12G6RZxIFe5Kq34pCEiUdh
 YJy5CqsmXl6toQLP1Q3isgd+DuJoFu7BYw1EWrC0LYMCQ/B8ORxvknxcTdiLvAc7NWFB
 x7l0/8wuhJnvv4cQEqGGlxnhGdzSYfkWfiGq0eTJxzZOtriFxfYuNCDciG/vcyAmgqUp
 XgPKEm5bkxyNu1/lhjZjUM5Y9OboMTrPDIpRDsSse5iWaG9bOAZTVRSPvuo674LhARn/
 qXVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqE5dHtrMwfik/yKDgSCMkdVlf4Gt2cvIa7d03Fc6txB7QQMk1b2+QxkmISFD3iZ7yeBlF/YIkfcCbub9Qe@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywa51ToHPZyzhT4E8OjA4lBZLnbRA64ibc85tOFG01kBq5qRyHy
 WmZ1FsLsNR121xokL8yytjeQFShvF0vFgFCFUvKOTRRtvlhu+bfV24U2Gd5GZ4cypSQt7181WHh
 07QbngGU4Y6vk4yW4ktKGlEr12HXwxEm6OZASZDGojScumLzcoDzPUw1YnoDdTJpRxFrK
X-Gm-Gg: AR+sD10GFf1DQVmHwQT6eXLG82w7qSh7LPKUSbfMcrnYL71ppJMt26TwxttTQVP4Fwx
 ddbzmZD244/bmeL0yMwzYQzmukz9yRASYWM+JcHuFQeukG1j4M7GAeLlGy+ZWWIRUTSGN7oMcMg
 Mon9SqtpWWgFLrirr4Vk6heFMbIMK2vtoAGDCIKTXsCQ39TVr3wbO+Vyyiu0THOoDlmCROQI0s3
 4p1ZghznydwJMZZPLicUlePBRPEblSj937DnER2vrem9NggIeTVtnrsXU2c37ZH0aHkXOmLm14n
 bhRMvklERoCIE/wwTwYgDmEjfK1XbDgA4PbT2zUw/i9K3AiV/xySOGh+xpMGxIIFED976IXcM9L
 a3B9IqpNOAbyoFtdLwcDExCV6iN51MgOC6Ekk28fwwsAWQ8wpBjVopirFTbhiipI8fKPZjuNtoZ
 DUbJQDQMNeVUofE+/9h7MPKWnjV9o9Tez/rO9/+d/lRNRD3j85lw436DTIWbQRBD494viErD+Vd
 +qltfdPkeEk5nJcmGXBS2rfeIKaXagCaBkSfJ29UQc/67nkjFEaV3lJrdRWD1AvnRJxi7Tebigg
 zITwKe7Q8jFszO6zKF0+SBiBDiwujaDJjCspP6J133z746OsWo5E7mKDnmLcvQ==
X-Received: by 2002:a05:600c:1908:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-499aa17d6d8mr65324855e9.1.1787139895093; 
 Wed, 19 Aug 2026 04:44:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0e473dsm49245755e9.15.2026.08.19.04.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 04:44:54 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 11:44:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
X-Gerrit-Change-Number: 1793
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1793?usp=email>
X-Gerrit-Commit: be3746bcb7cda97e180e3ebc82d1cc49b816f64e
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 11:44:52 +0000
In-Reply-To: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk3NmNkMzhmYzRmNDNjMmI3NWVkNGNhNmI5YTVjOWZmZGJmMzMyYTBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <12b2e88de08384289cba81f3acd4d096f2978cae-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwejB-00074z-E6
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Reformat all
 shell-scripts with shfmt
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7275615374176635247=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7275615374176635247==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qXAA/qXIzHw="; charset=UTF-8

--qXAA/qXIzHw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1793?usp=3Demail )

Change subject: Reformat all shel=
l-scripts with shfmt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3:

(1 comment)

File dev-tools/gen-release-tarballs=2Es=
h:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793/comment/4ecfe3fe_a773040=
8?usp=3Demail :
PS2, Line 72:     res=3D"$(find =2E -maxdepth 1 -type f -na=
me \"$wildcard\" | head -n1 | cut -d/ -f2-)"
> This doesn't have the same m=
eaning as before=2E [=E2=80=A6]
Made the fix in a separate change #1847 sin=
ce this commit should only contain the result of the automated script run=
=2E

This was not noticed since there are no current users for this script=
=2E I considered whether I should remove it instead, but the issues I found=
 when testing it seemed
too small to warrant that=2E



-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f=

Gerrit-Change-Number: 1793
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-Comment-Date: Wed, 19 Aug 2026 11:44:52 +0000
Gerrit-HasComments: Ye=
s
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg=
>

--qXAA/qXIzHw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File dev-tools/gen-release-tarballs=2Esh:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1793/comment/4ecfe3fe_a7730408?usp=3Demail">Patch Set #2, Lin=
e 72:</a> <code style=3D"font-family:monospace,monospace">    res=3D&quot;$=
(find =2E -maxdepth 1 -type f -name \&quot;$wildcard\&quot; | head -n1 | cu=
t -d/ -f2-)&quot;</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">This doesn&#39;t have the same mean=
ing as before=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Made the fix in a separate ch=
ange #1847 since this commit should only contain the result of the automate=
d script run=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">This was not noticed since there are no current users f=
or this script=2E I considered whether I should remove it instead, but the =
issues I found when testing it seemed<br>too small to warrant that=2E</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1793?usp=3Demail">change 1793</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf=
332a0f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1793 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Wed, 19 Aug 2026 11:44:52 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc =
&lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--qXAA/qXIzHw=--


--===============7275615374176635247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7275615374176635247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7275615374176635247==--

