Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F052C5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xizayZH3faI00H3ilpymJXNKFa40LO9BQqIdTxG9e2U=; b=JeRbUs5PT6KtXW1UaCo9+yToyD
	BGZ+dJGjoQ1qWrpIkHlIdjS904u0KqoeeV75Cu+UNu7RGdf9akfU99cbfm5diHaRTm0i7q2IH28n7
	fqHxfgkVj56PTbGHswVy7MgHvmYTLD2v8C3Y3fZnyKpJQMdpfDtT6c3qc3VQJlT3Trp4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWaq-00023x-Nu;
	Mon, 24 Aug 2026 15:28:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWap-00023q-Jc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:28:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=P5TDvlQp6/TZPetcm26UN/jXws1GNF4uAUWvwLKlPTo=; b=Q96J0YSCiKxYoMRtm4NBuyoki7
 dmDiMrFtGYRnFJ9hZRflUII5S3byO7CzkIjt6A1DargDxl1sGQOQHOZschDsP6UnHbkrOGWXY2hHU
 HPSWezAVK2T4SNrf6rJzv/5AkjtPRKcRM+VYRP/gkXnwEQKukhDov5kVL8tw2DaM4gGU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=P5TDvlQp6/TZPetcm26UN/jXws1GNF4uAUWvwLKlPTo=; b=g
 //5xPfyBGglPD2nR1gbfqypnhu2beJKn7NbSMZIH+lHR+f86MchHGYAzzTJz0Ehnc8SbsJZP3K/lU
 +UmWmuvzxIyq/ygIq/aFG+ppsddf5LfvK5N/pLq3L+josVgz6UZD0rHez4AIGKaXG6np//gUuDTxE
 WvxRFp7iobKGzwig=;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWao-0005aa-RL for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:28:12 +0000
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a17211b9ecso9063196a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787585284; x=1788190084; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P5TDvlQp6/TZPetcm26UN/jXws1GNF4uAUWvwLKlPTo=;
 b=GBA4ulHJob5bPm/qO5aImRkuz8GVh4JO2Hl17/xM4mpx9pFXyuN+SWwju6LtviWdw8
 5LukxwUm6qOKM/FeVTWVDXAV/6MFcRtu7wbfs9lyCCbaykfTTx5qGM1H0fCdsKmtSCij
 M3WSqHl7adlcU3TfeDK5i4Q8/EHP5p0w01vVReVAqk8lCzUwlknUy85Slkbtimokwtq0
 bOZj4lPfpmCllc36NFYzxFkxoXv6H93/4u9nyyRJTdCua1tmYlquZcsnagCIAzJVKX/X
 rAOVYJ9snNsCYuZ8j1GLmJiGmrYsfOHvwwObNpWyfB6aFeSSnfkeICdk0F+9UhhwMdOz
 a3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585284; x=1788190084;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P5TDvlQp6/TZPetcm26UN/jXws1GNF4uAUWvwLKlPTo=;
 b=VfTmavxXuWwCR+hxCRQ73KUDSzVP/CJY855XzNg7aYdwSgRmib5hxB+eCFffg+VCZu
 PT2rirUwQlNZIN1nX9B6g1ZUWDvPGvYAXxRpScamlZ88Qc2Dom9QQdP0+rZlNBRFtlzB
 a+rQ7zft6fzB2VF44ncIOW/QcbkiIoyABh5RtU19muse7eNpz1t2DuWGOvtaqjEjmkww
 J4klJthdazEjpgkZeWVJpfT+IFZ8Q+MexgtvnQAocj7nyxfUNu2xt9iCOtz0F7ZxFApG
 Zpf6v23KiHXpEIZGsc3Rm9AMjm6urtmbbKXQyGG+pfRQZ49f3ZLsm8p2FlRFTBoIvC7f
 SJAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpR1il2tay/Y44k/c8L+Q0iA+zdG8qx42AjinAe8nLK0j4RgcGTqO1Lqej91f0ZZh0EIDj4bmPSqajLX6Qr@lists.sourceforge.net
X-Gm-Message-State: AFuF++lX7ve0HxE7YTEIYHu0qRpLiAmepIAFDDKOw7tpGkfpa7TgN6uQ
 ePkkgFzTwoFOEcu16kDJwa8rDqkQpwlqzWRczuFfUsLJFQUUnUbUhtBqW5rSY/gM7QPpm7iMCwt
 VKFecP97e7ybHQntAQ3kXCusuPXogCXZlMNYYqwBDDda//w3uNaDv70+lswd0/GY34HBS
X-Gm-Gg: AR+sD11EK2RpOma1N+iEwPtwhc+jdkRkjj6IiZHcaauHsx9xt+rMkSJxxtm0+Rj0cDn
 tYVWHqe+Ov7W8Ncs9fnVHJp5rkRhZ6cz6T0akUoNetZXaxY+3HcBRY7SQfy9epRGTlFhqt0nyHt
 QUavVbqEmbDMcwiVD8vpGmTZAKIHRWXAOxF5yHjFIYsmC+q9zjh5qi9ZYiGwKtc3fwRlXh4ln83
 YMYed6qbqeRxUW/SYD3b82YXIPkmFbgCdyPC8eI4bDsWouGBAAdFYjKGfN9jg+prQYALpYerGHj
 XAt4A7VIOGp3WSX8q2Q2uf48OughAicfXgGOugVqOqbj7DLTYGCBqVghiEgFbkwEaHd6hd0sMY9
 pKevr1n/TpeWwGI3FR5E1EWHy+KwXZjQZ7RlO8rGnxOqIhyPhuuOlB0FdPWXOPaOW2AGIKxw307
 xH1CD6h5X7yeXxUn7AT+iI9Ok96dUJnOsgqGBrzb0lnRoeA65EZqxwfBLISvs6ENg3gHtyrGW31
 650NTZInvs4Bkv9Q+uqwKdD50/hhNskitPjjDxsrhsrXSZU1ouPzyrJln4WSZiQgcoJgIPZeZ/3
 6Uje7Pr4xHR9uqmsxYOWaNvYRqWgMfKBqYH46kt02hkheaY5tXQ=
X-Received: by 2002:a05:6402:505b:b0:69c:811f:8f5 with SMTP id
 4fb4d7f45d1cf-6a42f1b9325mr31793104a12.6.1787585284172; 
 Mon, 24 Aug 2026 08:28:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2e2826sm9171762a12.31.2026.08.24.08.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:28:03 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:28:01 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
X-Gerrit-Change-Number: 1861
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1861?usp=email>
X-Gerrit-Commit: 4cccdf6e27b97d01e33a9b95ddc6ea1f1252dc24
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 15:28:01 +0000
In-Reply-To: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
References: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NDM4OTEzMDAwLkllYzM5MmE0NzEyM2Q2MThjMGRiYzNhNTI0MWMzOWRhNGFjODNkODgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3772e741eb7e62a2aa1b1a3aa48b9df79e1cc3f1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWao-0005aa-RL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: fix log
 lines format string
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0841612250927162514=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0841612250927162514==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BsYuE9MxIpY="; charset=UTF-8

--BsYuE9MxIpY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

d12fk has post=
ed comments on this change by d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1861?usp=3Demail )

Change subject: openvpnserv: fix log lines form=
at string
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

File src/openvpnserv/interactive=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1861/comment/7669db36_0e096c45?usp=3Demail=
 :
PS1, Line 1228:         MsgToEventLog(M_ERR, L"%S: failed to convert itf=
 alias '%s'", __func__, wide_name);
> This is probably correct and Windows =
can deal with it, but `wide_name` _can_ be `NULL` here (especia [=E2=80=A6]=

Yeah, spent a thought on this, but vswprintf() (called in MsgToEventLog) h=
andles NULL arguments and prints "(null)"=2E Only the _s version of the fun=
ctions halts the program=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1861?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
Gerrit-Change-Number: =
1861
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 24 Aug 20=
26 15:28:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-=
Reply-To: razvanc <razvanc@mailbox=2Eorg>

--BsYuE9MxIpY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpnserv/interactive=2Ec:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1861/comment/7669db36_0e096c45?usp=3Demail">Patch Set #1, Line 12=
28:</a> <code style=3D"font-family:monospace,monospace">        MsgToEventL=
og(M_ERR, L&quot;%S: failed to convert itf alias &#39;%s&#39;&quot;, __func=
__, wide_name);</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">This is probably correct and Windows =
can deal with it, but `wide_name` _can_ be `NULL` here (especia [=E2=80=A6]=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Yeah, spent a thought on this, but vswprintf() (called in=
 MsgToEventLog) handles NULL arguments and prints &quot;(null)&quot;=2E Onl=
y the _s version of the functions halts the program=2E</p></li></ul></li></=
ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
861?usp=3Demail">change 1861</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1861?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1861 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Aug 2026 =
15:28:01 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>

</body></html>
--BsYuE9MxIpY=--


--===============0841612250927162514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0841612250927162514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0841612250927162514==--

