Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B6CC5DF66
	for <openvpn-devel@archiver.kernel.org>; Sun, 16 Aug 2026 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ulw0YEflBwdQaq7LCs3kaz9RW203Kjt+Bcvxj65q2EA=; b=lTG1RQnwev8bETQyA7LO/0wQKC
	LWY3+tst+etZz3eGkR6EYdKBo4LQV71PjVtz+6FrpKaU5JpkURIIrhwCFImDvMYVxKnFSqwEQ7wIW
	m5LJHoyGklPgBZGS1teyGS3VEIw3k6MM9m/9ne09zgIA2DJ0MVFzh3aOyMOx2lKxUikk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvZqi-0003JF-P8;
	Sun, 16 Aug 2026 12:20:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvZqf-0003J8-DN
 for openvpn-devel@lists.sourceforge.net;
 Sun, 16 Aug 2026 12:20:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WwA6anwNOILH0i5OuZ4tHpKYGpJuXVXH7xbnK/knkPU=; b=CG95LKakmZ2EVs+jzoZR/zBY8m
 BNq57D7Dx7bbj0JtrPzWVmx+9AtIa4qQFprWIP42oRFEkkPwX8/QnqdN8kkQ2mfNX5AjhFt0RG9I0
 5fmlKotGoxe7M+F4CVtu5MFvBi+YVJ/XRYQCsdHLQfcH7lvmu1Nf49MGlqQm7gx0RH5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WwA6anwNOILH0i5OuZ4tHpKYGpJuXVXH7xbnK/knkPU=; b=F
 EdiNXbgHj03mP7+JUwXctKzEuZSNldkkGxLVUDjCD88HSOlXpr9+eOyaIU5UvlWBtEUd1po55+nof
 McSjrDtw60Yt+fYBGOeOGMlm/4xWXBNFhNmFMIGzzp25T0EPvKqLtkWBi4DvLS4RDufGZSh4Y5gVp
 dYo/UWqRigzJOAxI=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvZqf-00013C-62 for openvpn-devel@lists.sourceforge.net;
 Sun, 16 Aug 2026 12:20:18 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso18115515e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 16 Aug 2026 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786882811; x=1787487611; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WwA6anwNOILH0i5OuZ4tHpKYGpJuXVXH7xbnK/knkPU=;
 b=Ir6Jk3hvypbBt5UeWP/BgzdYbojJxrve7hxs6Hp+bw8WCDrz2Q1W72Ksz/N57TWPSG
 5O9UUwUTO9pAIBZhP+olQSigr/n1Tsf369AXNEtAPQbWQNeM+SGKlYVEiHlsK9x4A2xT
 Bn4RzUA/xcsr+f6onG/akOkAfSgfIv1QSFK7tBQ+4b1Jc4MqsJnicFGYHAlHCzHDmiip
 7Xuqrxg4p++2mhclbNdhyVjV31+0UBrYyoa7MXDhLEUCvDx8WLq/WRVqf9dGVWEsMPaN
 WTCEOtc4xzZRydPqU6d6t2acsppTb5ApHhKbcUHtOcyKUczsKY4/A/dRJDGK8Ah0w/DU
 V4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786882811; x=1787487611;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WwA6anwNOILH0i5OuZ4tHpKYGpJuXVXH7xbnK/knkPU=;
 b=Or0V4QglJo1jPK+TKLFsuuSZx3ELzdOX2K9BTJVGKUhi9BIF3rPdpHia+JkWXNKEPa
 /myPvs6Uis282rchEdeRYIxi0C5avgH+kLU6FH5Wplm/e1fHAQ7iWJmi3CZv2yLDRhFj
 y/eo/PN9StjuKj4AUYsSELDANAHce8rNOoL8NgNyVh6xS+qMnbQVfgCg6/w8KG6ZL1Mg
 LWwsQhnddtT26ipt8vIN3dn1PnGrdqfLr8KrjHVh2zeU7+tbgxWJXw7MfudMpX7FQnrO
 wzLZ21HtTxUSn4slenXBhBayUt86wAkG8svsHKcOhAJKtWkjDE20eI7jQncBHGHZbR5w
 9wAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCoCHmk8OfaMqo0F1t0IaD5ahH6Uz4PfUs1sA2pfcQjAPT6JvSS7ISOP/acXouD8iDmS8nsg5EPZFBt5lV@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzFo/IkHokIuTItGkd7BWGKc0bOwhkeh7aLDTJah3b7laqmyiQc
 eQl6RHqao28tGkeIuaqLAOxSoQ+479N4taKm/ht3A5sFATVqBOexBG37Xg36KLXpM+JsoBRshNF
 W9jKJrV3F+RMwXO9mugzdNpo7SISCbrexZwd8KVb4UGEubSoUBjw9HbqkvzBlLKN4IEHXoT7VB/
 9pn1pxWw==
X-Gm-Gg: AR+sD12F7N6cZD/yq2/4ecwg0wemM+Wuu9Txjspyfh6eWW4gI9X/eBcg7zglBZWIrGq
 hh+q1zqWQGmkhB18JCrg/h7UoAUDNtTy3YL4dOpxlTRVn2o0qmO3cYeaN8w9kJrwQaDe/ebiu8A
 dGR0z56Z4RYIuO1bpkqnDrgeDyIvjjK03BWP2a83VTMrKbxKMILL+zsb58xdWQLTtlGmf9kmpQL
 7iZjpkGAJgGMru7Skm0FwOL0MrpZzqc+WRy72rBgZhYOkj+TSsjQV81m7cJEKnYLUofz/Dv8RiT
 ptdBt75sJFmtNKQOryqlEPcpHQYgcyd0yZZUw1REmpGh5Dhk7vaFPbE9nFkCM+/wQHSe8TPTKUo
 mvI6glUkf7/SxSBX6hJOZ5n3TtvomU096CHh/PEQkfKES6S+hv01Cq1f3h1Q2+mkLaD0wSw7Fxb
 TbFf6wJ9SxC2z6k8KyfiAIgtcMhIA4RIrCvJTGE7O2qHaFYhcyqCVAfRv7jsmovX6ZjpFwg95eK
 qe1xkLe1qG0y1ZseXdItGmuj4J4lq1v1Krmh97VE3WxuZPO/v4LiVyol2p0+j/DcY8XNfzrE+Ly
 OLvsnvQ7speL5Tfu+lyx2VgbakTGkq8F6Z6Lkuf3jo+I3t02NNY=
X-Received: by 2002:a05:600c:5307:b0:499:8c68:a3aa with SMTP id
 5b1f17b1804b1-4998c68a830mr239537395e9.13.1786882810904; 
 Sun, 16 Aug 2026 05:20:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610e381sm60163545e9.9.2026.08.16.05.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 05:20:10 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 16 Aug 2026 12:20:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: 929f70e5dd6518319e1348cbcc6cadd719bac374
X-Gerrit-Comment-Date: Sun, 16 Aug 2026 12:20:06 +0000
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d0a58805f539fc267ee3aeff555f571e148cac0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvZqf-00013C-62
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 options_string code from options.c
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6973180587650119793=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6973180587650119793==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G0ejjen8dOc="; charset=UTF-8

--G0ejjen8dOc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1773?usp=3Demail )

Change subject: options: Factor o=
ut options_string code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

Patchset:

PS2: 
=
There seems to be an include guard copy-paste issue here=2E


File src/open=
vpn/options_string=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773/com=
ment/0dbef915_b41ba38a?usp=3Demail :
PS2, Line 24: #define OPTIONS_SHOW_H
T=
his looks wrong=2E A previous patch in this series already uses this includ=
e guard name in the options_show=2Eh header, which now makes including both=
 headers in the same compilation unit problematic=2E



-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85=

Gerrit-Change-Number: 1773
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Sun, 16 Aug 2026 12:20:06 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--G0ejjen8dOc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">There seems to be an includ=
e guard copy-paste issue here=2E</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/options_string=2Eh:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1773/comment/0dbef915_b41ba38a?usp=3Demail">Patch Set #2, Line 24:</=
a> <code style=3D"font-family:monospace,monospace">#define OPTIONS_SHOW_H</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">This looks wrong=2E A previous patch in this series already uses =
this include guard name in the options_show=2Eh header, which now makes inc=
luding both headers in the same compilation unit problematic=2E</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1773?usp=3Demail">change 1773</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1773?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243=
d85 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1773 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Sun, 16 Aug 2026 12:20:06 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>

</body></html>
--G0ejjen8dOc=--


--===============6973180587650119793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6973180587650119793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6973180587650119793==--

