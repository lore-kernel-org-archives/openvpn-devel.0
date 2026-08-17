Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ED5C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bes8zMAPu6NUB2hSIx8WwhK972CHG5eLznyXc22mOL0=; b=Wb8GSDbmW+5rJa454yhEYxQVPk
	4NPS0NqYgI6j6BJIqD9tSqKRS8IMH59SYVSC2Xu5n6vMm4mYhUrkuNFdq/D9V6vxisJsRcuDmVS8B
	/JBwAi4siZ8Wa2WUrlkwhVXWw6ezCLNhgsS5fQWcgc9qwJJeocpXFtIj0Sr2jIW638Gg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvw9m-0002Tv-W6;
	Mon, 17 Aug 2026 12:09:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvw9l-0002TR-02
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:09:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=s9/J3NBMd+y+lV3Tr+GunPclbwRzyExHmduuBbVMnXs=; b=OZo9VuY9H1S/c/p93c7sIBHKv0
 lRHzwF/SbzNEq5hWUKJlUxZlByjfIejt20dUjRJ6rCkJp2QDDQZs+QXaqpMNFr3euQh346TxT9wn9
 FeSu8tWgXeFwxboCI0w7LJEasz4dNNZ8FC9pW32EqCyS9dGhLay0JDhcdwnMOxKmYd3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s9/J3NBMd+y+lV3Tr+GunPclbwRzyExHmduuBbVMnXs=; b=A
 iCBoSdL9QmoelusuRIJy0oPwI2SIiP/dkk3nH/CeJd26FPed43IXc/TtxjE2Q01Z1HmYA2o6yAib9
 9U8k+2mFN1OXPxtuHgngzr7h5lA8op9tyifl3BRE829byRbwHI6zPIpvij9bOoE0d7QRtH4Zl275J
 5AVFEzoPXk/y/LxM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvw9n-0001rW-IO for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:09:33 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso17006535e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786968565; x=1787573365; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s9/J3NBMd+y+lV3Tr+GunPclbwRzyExHmduuBbVMnXs=;
 b=LRP2WOOCmf1tqf5ktrd+Vj2DsrmDJO0cqMi9XStS6+JUSEl2ltiwoUUg+4126HnIo9
 Hc7DU9DJXT4zpDLyDlEmnj/APJ5hLtn3MVxKegQRyq+WmAlXaEs9Jxn/zz+jYGfj4pML
 ZN5ZWj1kFZeYD1MY1PweAGfiMlop48JgkLw5tkeQibHJAIuJspazq7Hc1ncdKsxbb4gT
 eqnXYIjpWZZgnQk4/iMJIDT/BjjiN8UXIK2wMQrl3E3PC1QKCf8n/mtI0WQb1ykkTBNU
 ZB5buQeD2vXe+1GyjbgljYt1V8SIJ4hmTANoPe+THerdyLpKyb35gOnpG6Yez02OdGB3
 ww5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968565; x=1787573365;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s9/J3NBMd+y+lV3Tr+GunPclbwRzyExHmduuBbVMnXs=;
 b=MCqVgIRh0XqbGb4zRbaAmStJUAn4/YI1ga0nTp6U40fYLsYmIS5hP6Ico+octiWqfJ
 4JNJ4NhP/epn5Nbx6e8cEsXNs7eJpscxU6W9QpggBs+Sb9yqe0Ke5hOVNSUARhIA8dAq
 8D+4miuTz0c2vYq8ObaqnKDoPpvZbYAhu+2RfeWAjhEbsXMKT7JRejKQRNltOJbCTFIr
 wjHJmXk5quSND5U5PVMoKKk8WXrfWfJEQZ0qFe0pS5IZayB86sbPWOLMDpaMoAA93Xqm
 Mr6upB5ZDUFSFDzuXvoYPJv0FANVaQi0FQdXmCefCRODqwv9xNVBhI+qKOn4bJGK2k/f
 RWZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrslDB0yb0V56R+b6kWio3MjF0Mkhyf8OMUfNT/xo9z086WNNWSve4r/rI8xocXw+3I+TxuFn2tavvXs8a@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxzGXV/0FP8ePKJFvkFsuhiY2REu+afPzhw00YXAwkIAlnjJmnt
 aYL6bgfp7/pCsGofWlD3aOC1cLxBKepVOH7Jk396MMpeJJuLWvP1p7+lBWAzyqhQsfbzs3lmDcd
 lah0jd88FRdSENyjU87kjPOUolxGERuBWAe8lDzeE2b12gRDT/W7xNAJ0ifonT5f2NAMDfeo7/q
 BZsx69cA==
X-Gm-Gg: AR+sD13sGAWqFEcEwHAJhqJJqT/3X49Svz4mPuyAF5cGV6wSsd1bwQuUb88iEPFyRxT
 DZCrcG5lYIeV1NBhS+drUJ1d7suygp3H3U9TMxB4YlGwKktzn6o+oR4rls6XT224JC3ymiy3OF+
 lQ0o9Q7/YdCFQzXNNpzEghnjqQRxFDhOSMWRnVCwI5ZyJYCPXOujwjxok4JrpbO76VrEoBdz4Se
 FP1X0Ybi42lxwq/6nXVfMaBv4cLbHu8BiqIgu3GEOR9pImH20X62Xa95ZMtHEZ8+7rqEbi0kToe
 puy0ggs/QcD2W6ktK0l9KaNvlva4e2JDYykIOfPtoBgDgFf4HmU8B5PlmYjPKdbprBpCnhvqjif
 YQmyCkUOCghB/aYMF9Zbtcx3Zw/7f6MjEvuUHNgvA6tp0Xw/hXSMeQlKEhMs3kADm0dHTk+P+NT
 DppE2CemwbQ+Obp+95DuBGJMCodAvagXHNwCNfhOyX9WKiNHxa9upzYyN+slElVXrc2zmE7ZP3u
 hHlCG6n4iGXcFa8LVm6XBQnjpPMXq2slDbOI+qgVBncdKZtnEvo1sqgxzvCzq9WqG6j643lqIdK
 J/ZWBZ+Ci8ZHibm2Xy2CBQEOGZLm7aCGm+MGDJ/NkYOA434FXWA=
X-Received: by 2002:a05:600c:c165:b0:499:4892:d022 with SMTP id
 5b1f17b1804b1-4998795bca6mr429018925e9.8.1786968564350; 
 Mon, 17 Aug 2026 05:09:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998777d428sm163428165e9.0.2026.08.17.05.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:09:23 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:09:21 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 16f746e22115b096bb1e6f1723cb4f63f0f6885c
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:09:21 +0000
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff03993f226dc9fd85140b76cacee646afbae06c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvw9n-0001rW-IO
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 options display code from options.c
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
Content-Type: multipart/mixed; boundary="===============7989408012067377929=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7989408012067377929==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XkSxDKXaV2I="; charset=UTF-8

--XkSxDKXaV2I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail )

Change subject: options: Factor o=
ut options display code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(3 comments)

File src/openvpn/=
options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772/comment/8ef319=
8d_1b6bc81a?usp=3Demail :
PS2, Line 931: static void
> This function is now=
 preceeded by 2 blank lines=2E
Done


File src/openvpn/options_show=2Eh:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772/comment/5e592a64_359f6cdc?usp=
=3Demail :
PS2, Line 42: #endif
> Nit: missing `/* OPTIONS_SHOW_H */`
Done
=


File src/openvpn/options_show=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1772/comment/4c10fd49_2a754157?usp=3Demail :
PS2, Line 25: #endif
> Do=
n't we want to #include "options_show=2Eh" here, and include config=2E [=E2=
=80=A6]
Have added the #include there=2E But not sure whether I should incl=
ude options_show=2Eh here=2E We do not need anything from it?



-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f=
7472b5149
Gerrit-Change-Number: 1772
Gerrit-PatchSet: 3
Gerrit-Owner: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Comment-Date: Mon, 17 Aug 2026 12:09:21 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailb=
ox=2Eorg>

--XkSxDKXaV2I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p><p>3 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1772/comment/8ef3198d_1b6bc81a?usp=3Demail">Patch Set #2, Line 931:</a> =
<code style=3D"font-family:monospace,monospace">static void</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">This function is now preceeded by 2 blank lines=2E</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/options_show=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772/comment/5e592a64_3=
59f6cdc?usp=3Demail">Patch Set #2, Line 42:</a> <code style=3D"font-family:=
monospace,monospace">#endif</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Nit: missing `/* OPTIONS_=
SHOW_H */`</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/options_show=2Ec:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1772/comment/4c10fd49_2a754157?usp=3Demail">Patch Set #2, Line 25:</a>=
 <code style=3D"font-family:monospace,monospace">#endif</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Don&#39;t we want to #include &quot;options_show=2Eh&quot; here, and inc=
lude config=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Have added the #include there=
=2E But not sure whether I should include options_show=2Eh here=2E We do no=
t need anything from it?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">change 1772=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6176=
2374c141662d596bbf88b64ca7f7472b5149 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1772 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 12:09:21 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body=
></html>
--XkSxDKXaV2I=--


--===============7989408012067377929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7989408012067377929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7989408012067377929==--

