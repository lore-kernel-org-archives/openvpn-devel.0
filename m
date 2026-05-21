Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE44CD5BA4
	for <openvpn-devel@archiver.kernel.org>; Thu, 21 May 2026 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lF1XkwZ3iCqTDAe3+m5euhxM/7AZXEGU00vdCZFIgPA=; b=Wn4ICx0GfTTJrFfcYx0v+e0ut0
	YyxkC4FW3m+EK7OeSlcd2w24LUDfoQMSgsI/RvDcOCKykeq8mDsNGJGTLuo2m0xuMpRcIKAoNgvAf
	V0nankft/6SnE9jZGB80AXBgzftj2vpPlK/0qRp7oCJ3uFwja9v/Y+SNYFX6rbSqo9WQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQ2Ja-0008IH-W1;
	Thu, 21 May 2026 12:15:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQ2JZ-0008IA-Jg
 for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 12:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CcaW9hwO2xJqpxeqFn8RVP3sgEoRVXLE4ZjdiGVrPbU=; b=Ft0LhpUXi55YrQ5OBVwDBa+Hrf
 R4f43eokHVyZ41PrWNASGg1wcMuna6/jgdF6C4/eoIpZUYFBxTwHs6NySrLaujX55nnLFO2VMJjEl
 N55az63B1JKgLx+HBYuUdKbo6dquoJilZryRqj/RtOGfJ2JC+y/P4TQhxePpk8EEKL0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CcaW9hwO2xJqpxeqFn8RVP3sgEoRVXLE4ZjdiGVrPbU=; b=S
 tpUdV+v9pT0wfhfxzJ1RUSD0EfOWroL7LNwVXTV8w7+zxemNZP23A6dAmoh2D5pq6BZ0UHDve8Tzx
 ba3zwufSaXM+QHgTZFw5PWBniFTcTWpEQBP2UZpvz3/HP+sJQ2xY1imup0XyIXcSeMFgnczkoT8ey
 Tdwc2vmsahMT0lE0=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQ2JW-0007Ij-Nm for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 12:15:49 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-44b330c5cc6so4491496f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 21 May 2026 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779365736; x=1779970536; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CcaW9hwO2xJqpxeqFn8RVP3sgEoRVXLE4ZjdiGVrPbU=;
 b=RWg2xg8+s4YxateQVixuwCW0RTBDPOIs2fEXvMwxA6ZeFCvY8Dt8cQInFw6tlP0Hgl
 rO3A2lrEgq4p8SovvN2BxFcOvOSxfVpZQIG54KEg7CUQpe+MKNXKy9OXw6OXplRoSski
 4JdJXe69Bvdr7EWt6fs8tS9BEUWDZbDJX/KPKIHxucMfREUr2zwHlvwyN/vA8vNQWB3D
 7O6+++YIkqBRWQULX6yk6kabnyz/G5w1VInhnDVn3wifd7H6kPvhchUem3UvQbcRs8i/
 2c8qU16g7AineqcCXCZQANm+15jA4S7UPmgTDkK6hcprApBM3p7tG1O7PKbXo25xfoBD
 1a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779365736; x=1779970536;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CcaW9hwO2xJqpxeqFn8RVP3sgEoRVXLE4ZjdiGVrPbU=;
 b=n/B3O5k46fSgb0hd1ce025ELBkI7UN4GIPoT+Vl/ti35v/JpSpcBrXVEYiKKwTASX+
 Sw8v7LytyXMIW0FsKzlg1aF8I3YIciQzgZB2EPofjpFaG++c5TfNOpicobmxPPWTTUfC
 XK/aQAVTcTD5XdsAKxwJ3KC6saZguaaM8R6ilSvIzMWlIUs8r5+MjBTr1T+DOu0HlP6F
 XvSdtZJpUYfwQjxs/ihY9FzdK9LgOkbzc1DN6ktpMql2COuVhR0tLS/pbX4c4z6X4w+b
 r0epdB+h5/VAavq7QK/LLfHetketSPHT2b5v5mbeW/fygNY173vDvo+tEI1FsWLO/dBX
 ASwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8taOamK397jX6JAyeSETqq958z7mdzKwi9lq76dcqcXEzrLYp7OPkwIQktLPQzH7IfYWatf1BnbE6mC7Rq@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxwpWKoeLeufw4yyqG0xjx4gp6tJoVFpLsPio2WtxtcliVkWSz3
 9/wwwp3IECDNGWCOt0AKA7+FslKDDnu8rcvHu/NwbY07YfzJ4ITFd4NzgeNqsQtvcrvuYLYyEGG
 qFVMLFOiVW7Eqj/h7acS1aAXxbznrQIFEoXImN1MrHpcpbvElO4PdX3R8RRb8elX0Hy1AvwYf78
 kGEwWuag==
X-Gm-Gg: Acq92OGGWXIqaciSNQV1gspxFC7cv0ReAgtrs0bSp9tcj9DQ5offfQ9Ir3uq7RPA/px
 Zd5nPmh76L38THCsJXjYlawmaChfc3CEnwazxCz+xlMADrtL0ObTBOiTYp+AyBwDhn3pUE5RMrd
 hlLqU+Qg1IFk0wE2TVc9lsYWdhqg8ikNkQYZ+gQUbl6sm/mffaU68JxlI/km/Sq+HX78WBP8nFR
 RQ/pexPqahNxJj2TpAfYf042qn1HRRFNKuyQJ9+dVm6vCV2JPryEDP6uHGaNUr6eD6d4fl2nSqq
 aA4TCIINUjzJDG9IqAB994HUCc5UCe0zWI2sEe5wMs5bMlt8gEEnTzhlh6v2e6pndoppafVUSEm
 6HynLnxOLmTgsWbZoMvLE88YHWn68WE+3/jtwH5sktANwuew81GjwGNPbMhmGIMbiKvqWDNWyJI
 k/0sGhKS4f12lVA1SO4jlvOrv/7q5aDpTo8zuzJQsVAubYbC7EVs9WfeUNvbCjv79P5Mo6RZPPH
 b1db0rm1mYNCqP7WbCYCi99rNN8UTRc4/8CwHcAsh0HkwsaiVfpEm0PfB1UDNtFimwrtYmXqD1E
 wVpajjtXLxKfEg==
X-Received: by 2002:a05:6000:1863:b0:43d:7946:baee with SMTP id
 ffacd0b85a97d-45ea3aeba8emr4044411f8f.23.1779365735394; 
 Thu, 21 May 2026 05:15:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92de72sm2437668f8f.21.2026.05.21.05.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:15:34 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 21 May 2026 12:15:32 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 6ba94fe192fc58331f740bae631c15ab08827439
X-Gerrit-Comment-Date: Thu, 21 May 2026 12:15:32 +0000
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e473e9d6331733e07772e9459fad9b772b7dff46-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQ2JW-0007Ij-Nm
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: remove iroute
 at client exit time instead of delayed exit
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5080304855109433710=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5080304855109433710==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f+yqy/OmINs="; charset=UTF-8

--f+yqy/OmINs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ordex has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1683?usp=3Demail )

Change subject: dco: remove iroute at clie=
nt exit time instead of delayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(2 comments)

Commit Message:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683/comment/ca3ac453_08ace230?usp=
=3Demail :
PS4, Line 28: 
> I think it would be helpful to add a short comm=
ent on why this is a DCO-specific problem=2E [=E2=80=A6]
ok, I'll add a bri=
ef explanation in the commit message


File src/openvpn/forward=2Ec:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683/comment/f77e6242_754fb714?usp=3De=
mail :
PS4, Line 537:     /* DCO iroutes must be removed now, because the d=
elay introduced by this
> You might even consider adding that explanation o=
n why it is DCO-only here in the comment?
yap, will replicate the explanati=
on here too



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1683?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ba723=
d12d433e6e020588b7b0c3ba10bcf8c44f
Gerrit-Change-Number: 1683
Gerrit-PatchS=
et: 4
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 21=
 May 2026 12:15:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--f+yqy/OmINs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683/c=
omment/ca3ac453_08ace230?usp=3Demail">Patch Set #4, Line 28:</a> <code styl=
e=3D"font-family:monospace,monospace"></code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I think it wou=
ld be helpful to add a short comment on why this is a DCO-specific problem=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">ok, I&#39;ll add a brief explanation in th=
e commit message</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File src/openvpn/forward=2Ec:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683/comment/f77=
e6242_754fb714?usp=3Demail">Patch Set #4, Line 537:</a> <code style=3D"font=
-family:monospace,monospace">    /* DCO iroutes must be removed now, becaus=
e the delay introduced by this</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">You might even conside=
r adding that explanation on why it is DCO-only here in the comment?</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">yap, will replicate the explanation here too</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1683?usp=3Demail">change 1683</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1683?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1683 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerri=
t-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Thu, 21 May 2026 12:15:32 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--f+yqy/OmINs=--


--===============5080304855109433710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5080304855109433710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5080304855109433710==--

