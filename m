Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0440CC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8l+VHY8HbBZFYqQ+cyYRRWX6TiImdyld+Y6zDTQizY=; b=LoQGxx/8PG1oyRAxe3PHFolmmW
	3wR8fR5ANltBtAQyq6boc9mUmdRIhdBJ4Q3gBcGd8S0KZtfzMMeC2yr2pAW1+H4+7rDh34iKqpsSl
	VtGpl7aK6QnHKNkR/8qiEdwdEqQKz7oZ2m6YSK1l+Mme6sNc9KO5kMR9Zx/mO9WFQaVc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvuGf-0005yu-Td;
	Mon, 17 Aug 2026 10:08:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvuGf-0005yn-9C
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 10:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5XDwPnylWbK5EO3iO9y2LQ6WK5s9KZOwJ56zTx5Y704=; b=jFavQbR8QwyQuk32u+Rd76ecIF
 UdzWtfoJu/e4kTGOLZfVeW7ti8VhhusxCaEHxrPChI0XdKdBeA41r9zBcjoYCwtirk6iuV1OR+HNV
 CnQgYy0Ayz7+I1AvF+QxRLEPSld0p5dQsb4eHro9F69p6RFncFmldXkYhC1qd+PraQ/4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5XDwPnylWbK5EO3iO9y2LQ6WK5s9KZOwJ56zTx5Y704=; b=B
 5GFTD6kI/fiDBYdSli2ix+txVnhivSmBZFnb7K38XET7fOF5JNuwjL37pVIqbwyqsS951FgsqlLgD
 lXheWvCx4omkEubwvEYcw4RJXHDLU2dX16tfDlf0n36kJSYy4kmETSExnSFvQ2hp60pH0yLZHiuDZ
 o59xqimUIuG+2SsI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvuGd-0004Ff-Gl for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 10:08:30 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so25800215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786961301; x=1787566101; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5XDwPnylWbK5EO3iO9y2LQ6WK5s9KZOwJ56zTx5Y704=;
 b=ZaH9Y/t8VBUsxvG20yfSDa0CJvb6nxy6ZhEnVqR7d9on89zOn6JdoiJ7tFWFqCKyni
 qRErPXcVeHVarj3EVN4mzD9N6j3bZ2ESTLicK9NpBhzF1ghiYZ6ExxrXju/ViwZfDXzT
 XEEyxln0BtmtTSXvNxWOxD3V0TGiPuvCUxqzLYOQBfRDT6qRsc/Src3egWWVXZ2JmSIf
 3e5iqvMytC0pB9SolOjmf3T8xwWUcEhGJvDo/H5RGuqq9WWKx1gDLhB5F86cKA5IbuiF
 /CTCo42r/YvyCsDSqy21gWI23fnekF/h5muY1NwFoXVCWlKT8DpmZ/KGfEIs6NC0atPg
 EYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786961301; x=1787566101;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5XDwPnylWbK5EO3iO9y2LQ6WK5s9KZOwJ56zTx5Y704=;
 b=W4UDKvR8y7Dn0Z1y0yMCycmxgRV/i7UubtaqTY1NXlhdN1n8rtho6bzjMiqoPkcLxl
 OtQmr6wpQc4ZPC5wBTt23G+lYf2ans0unU9agDgNrLtzgH9ycId70nmpgRHZXS6nJZ10
 eZzT7Tq03UgomqAqIf4bAtw2oLlhG7w+BSq0WoEyyZXr7pJ8oKdVIqC49rMFoI1YXxvY
 27MYi1LpvAItt5qmnTVwRE9VflDuFjHC0hfBsysTv+JR64HA+3lX4V2+X2166R0lCdQ4
 7Sfk96mBa6+RmBtJMqxJ8MH2Otu5uwNKVoXyGwMwu/0Z/DcI/GTCJUkz5AECcGwt6p1l
 HjBA==
X-Gm-Message-State: AOJu0Yw73Dg+ZzoYi1djHKyyTTswLgll/ovDEfI0tCavC0BGLWTGx8BK
 0EfXWQbKeIn9r7RoQnQJhlZt2tHoxZ6wE+txvjdS8i5YN+ZwI/SLL7dh73DCUa9+vJMYJYuknED
 X+1U22WrCCixhXq+0TrxVqrmoZdOfhLq7aaobiGeS3pvCkCPocQoXg4m5b5COkuGLXlqZ
X-Gm-Gg: AR+sD122MbcmaoLXHH1G5ZLMioaUURl3hZiceJFe+O0XJIYP2gXhKS3Zps5Co42ZyvY
 ajyyXfGbjaTw5/lub69KAAgnXIrIuT70DE5Wei4Le5c5G3PEd6NbbdItzzDFTjB3505ixI+g3RP
 UsNuOCfBMW0HF5sV6EGeufhhuD4PXsHaERvKw2aiKi1JSNDwWSMpRIoJlhsp8zm0YvGqGpwdUzj
 GvZmBt1z3c7ye92XxYkcxq/uLcPbKJzyMDwEx28/CCeYPnYkUD+aZr6HQjZQ9ZOI84hbcHdA2+b
 RcwDVWL8wdtO1VsKJH8JiuGNVnLjxM5cbUbkEziYu4PsU+QyUxRJN1kZplVzQTfmyjk4h1c23WL
 1wQudkdWnR+YKACot3r+XwEov3ZGjD9qKYkAc50cVpVV+hiYK6W8SMXHUFX6JcT17SJzO5fd2+N
 vN0DLxLQG5Qzo26/22XyBLEBBhVH5R9rLIA8/CX5y3FW5Il3pG9xc09hBsr4tAyTMjDE5exPqSt
 D2tH38bjn0eUusqvk8a1/AqEz/i4973VlWddiloU5b3UCj1nrn5oGmlxsAAkskizleg8gUZ4Si8
 8gOuEqBwoIjlttMhIteGy2YjYsbXud7LPIb0+7qMfFXvB6Qr9sRrn+PJOVN/pw==
X-Received: by 2002:a05:600c:4e8a:b0:499:7a4f:d13d with SMTP id
 5b1f17b1804b1-499879441bdmr341448345e9.4.1786961301175; 
 Mon, 17 Aug 2026 03:08:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm300950695e9.13.2026.08.17.03.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:08:20 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 10:08:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: c35df952df85077d28b8b848f00ef5d450ce84ad
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 10:08:18 +0000
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee53bc3e22552ea4d97047c13493a149592fb75d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvuGd-0004Ff-Gl
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Reduce number of
 future epoch keys from 16 to 4
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
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1636933986526812091=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1636933986526812091==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uoXRfiJp7xI="; charset=UTF-8

--uoXRfiJp7xI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1844?usp=3Demail )

Change subject: Reduce number of future epoch keys=
 from 16 to 4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1:

(2 comments)

Patchset:

PS1: 
Is this a squash gone wrong=
? The patch does a lot more than the stated commit message, and the part wh=
ere it does more doesn't build=2E


File src/openvpn/ssl=2Ec:

http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1844/comment/f2a53ae7_00e7b2f9?usp=3Demail :
=
PS1, Line 2000:                 buf_printf(&out, "P=3D%d\n", session->opt->=
ping_rec_timeout);
This actually does not build:

ssl=2Ec: In function =E2=
=80=98push_peer_info=E2=80=99:
ssl=2Ec:1998:31: error: =E2=80=98struct tls_=
options=E2=80=99 has no member named =E2=80=98ping_rec_timeout=E2=80=99; di=
d you mean =E2=80=98packet_timeout=E2=80=99?
 1998 |             if (sessio=
n->opt->ping_rec_timeout)
      |                               ^~~~~~~~~~~=
~~~~~
      |                               packet_timeout
ssl=2Ec:2000:58:=
 error: =E2=80=98struct tls_options=E2=80=99 has no member named =E2=80=98p=
ing_rec_timeout=E2=80=99; did you mean =E2=80=98packet_timeout=E2=80=99?
 2=
000 |                 buf_printf(&out, "P=3D%d\n", session->opt->ping_rec_t=
imeout);
      |                                                          ^=
~~~~~~~~~~~~~~~
      |                                                    =
      packet_timeout



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1844?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Id3c6681b29026c2920a62a0ea570fd098649e197
Gerrit-Change-Number: 1844
Gerr=
it-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Mon, 17 Aug 2026 10:08:18 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No

--uoXRfiJp7xI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><p>2 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Is this a squash gone wrong? The patch do=
es a lot more than the stated commit message, and the part where it does mo=
re doesn&#39;t build=2E</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844/comment/=
f2a53ae7_00e7b2f9?usp=3Demail">Patch Set #1, Line 2000:</a> <code style=3D"=
font-family:monospace,monospace">                buf_printf(&amp;out, &quot=
;P=3D%d\n&quot;, session-&gt;opt-&gt;ping_rec_timeout);</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This ac=
tually does not build:</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">ssl=2Ec: In function =E2=80=98push_=
peer_info=E2=80=99:<br>ssl=2Ec:1998:31: error: =E2=80=98struct tls_options=
=E2=80=99 has no member named =E2=80=98ping_rec_timeout=E2=80=99; did you m=
ean =E2=80=98packet_timeout=E2=80=99?<br> 1998 |             if (session-&g=
t;opt-&gt;ping_rec_timeout)<br>      |                               ^~~~~~=
~~~~~~~~~~<br>      |                               packet_timeout<br>ssl=
=2Ec:2000:58: error: =E2=80=98struct tls_options=E2=80=99 has no member nam=
ed =E2=80=98ping_rec_timeout=E2=80=99; did you mean =E2=80=98packet_timeout=
=E2=80=99?<br> 2000 |                 buf_printf(&amp;out, &quot;P=3D%d\n&q=
uot;, session-&gt;opt-&gt;ping_rec_timeout);<br>      |                    =
                                      ^~~~~~~~~~~~~~~~<br>      |          =
                                                packet_timeout</pre></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1844?usp=3Demail">change 1844</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1844?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e=
197 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1844 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ra=
zvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 10:08:18 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--uoXRfiJp7xI=--


--===============1636933986526812091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1636933986526812091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1636933986526812091==--

