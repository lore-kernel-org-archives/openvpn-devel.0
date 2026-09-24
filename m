Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56045C9830E
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2usMbdOFiiCjXL2/JeiIj6t0wht8dF631cYaelGjpg=; b=PiuPmcuZFVWxhtPPD7kDD8+r0o
	Z39nUP2lWj3CDX91aVHLAQlgVTx4tpjHPtXmucW0LO/OmJV82g429439Q9q+0obCWZdJi8sgJ3Fgf
	D0z7bkcKqM/RWxcbY5C/Li/mvsj4Ak2lk2A8iz9N2kEu4hw6rY5dh7VBiG/JGgsSSv7s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9g98-0002vm-2A;
	Thu, 24 Sep 2026 09:53:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9g8g-0002ts-On
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 09:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oOJeGR+PglP5oxZqCFkXexJBobwo/juVxl9QqTMZylg=; b=DUHA5iQsWZlvYtLxm60kP6MBzT
 Fob6S9n80YG/bwh9TSXzKjg401LWkxt7HUOMQ4HApVyDU5ko5zF0EV28y+ZKivBFRFYSFOr5Q9wUG
 6LqQM8+kmr4yaEavRuvvk5cdofyJo3FCqm1BitAYnWKd/uJQAsKb3xUVEoaOjPuDj2S8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oOJeGR+PglP5oxZqCFkXexJBobwo/juVxl9QqTMZylg=; b=Q
 GqJvEtTeOFSKaVi2fI00Psw5SxeG9RBD7fgkRhIJoH0fgt2fBK9hsXuDo46PnQYX4EWpxb6/NnwXi
 6pGCADNSZ3YmPvMyce9N7dYiQSCniJaWFdTAf1k3tjaSoOKQ3PXYuPCEnkMGpT0uqRw31I+jqpQxj
 BYkvmsI3v9YA6ujg=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9g8c-000371-FM for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 09:53:12 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-484366874b0so1164748f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790243584; x=1790848384; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oOJeGR+PglP5oxZqCFkXexJBobwo/juVxl9QqTMZylg=;
 b=RPITM2C+FrgIBshRe7aVjzmtPCaJknH7tzhoW9FkDZKgdZH52nRWVqU28uN6iJ7NWr
 1fYv248N0McsmKwFhawXAqM/3fhF0+KUkbcIzDLJAOPZt087la/jOEh5ilDd9i2pIZTz
 BkQ7TfWHSFipxEL/3N3TGiTApVsNk/VDOxIcCB52UJqnGZv7SEPEj6jI2FKbhrBWoFtx
 +I5zjpds10zJD4sniFBawMouXbNwhrIsoakwYFUprqTcwHeBgzn0gG7Om7D58FSzG4ys
 /4B2vJLPuQP8dEfB3w2n063HBuHA9K2LbWQuI+WTxRdBABhV0HfQmqU7f/3vySEdeelR
 roPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790243584; x=1790848384;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oOJeGR+PglP5oxZqCFkXexJBobwo/juVxl9QqTMZylg=;
 b=Jh4P0ixfOC4RqLtCM/dRxhCXJZ7xJihc9rUU3uNYQSxGHqJVXQsapO6ZkATLxFe35H
 Pv8ztxvSTYWjtmvZgYOL4w9EX/FK1HrPfSB7BY7thFten2QIG4M4g9LGO2AAQtqh38NM
 3vG76pPZPEZfp8Qyi47o4wITwDOR0ON1byCrdF6/pZ5v1XwPkr9Q8H9LUa8le3APamt4
 31ciDyReBPcwW/vdcSSbtSEf8v0EZ+XO5ss87gDj25V3flmlyDCEzXBPzffvTQi16buz
 bP3tX1+mR0pVh8czU3zxPgNcvAX0PGM7deFOyjMAwnSoNZfhRkNCMKr7q+7u0cRgdvMq
 K2Rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+VjGqIVlijhZaj04FyFP43/LTnPMWzfW2ySSX7IhHf7bZ50FtDv7PvfoMIpe8B4EWceOMuKXnWisGz0lw@lists.sourceforge.net
X-Gm-Message-State: AFuF++nKhvzKKEiEfHXbwncxvQts09yPJIQ5dCiylTVfsREVjrTJ+zCc
 YUKntUvxM7ysFjgG0cD7LfN+PRtDhtTv6moJwOjtQakmhcT6gJvRmRALVSW96tdj6VVmtk25pBL
 bccmrd+jyO5T9kqq3hJA9B+P3g9UBPmIqz85WQLgJzzuJjzaMRZh+f/1DrlQIBS4bWs+a
X-Gm-Gg: AYBFou3GrGAgNPOv8iETIjwe9WcfcDA65Hajq0HeuzDu1Yjj1rba7g/bHSyitTSJQAW
 57jCV+5A0w2NRyXmYW7lm1YTpyoF3+FvnGEwC5DJckJxRWDJsSzzm8HW2nqwo1srXkLvl3IWxiz
 DaMOK03KsviQtNbsRvLX3AzUQaxAeTx33IbcTnQ8bSTqlg/7RLCk8uHdqmhCnb9sgkwAeHPFX0m
 0pWOfj4WT4LV684K/UnBZLIrh4RroqVQUkDhIojRgB492Yi2XEGv7O5ZiuYUK++/wiSRavWemSR
 cCltKmlYdvRIHVrEb6+GfB127r79FpeBofLK+1TVyzzxm5CCLgH+r6grWjoGhhJ7FvFDdHqUkBU
 J50ZsgZD1bubzcwWBH8gbRvEWiQTemJe41QLp8Hg8bTh/7DTFdvhQMY3mgJNL9sk2wr6AM6Rloh
 kmMUKIgxYljcbD37KX3yqypmgijIbl/GTdosjT3S5zC3GZx5KDET0QXwKhrVnivEdlwovl0s53T
 W5vGTxOmHg8oTWATZ36rKnAUD8Q73KvKzsBQC1P83KrM0g2sr43H6ZswFU1YQy9HBJ/V9IY8zdI
 Y2I+KZGG+KZkPfuhWWytwfCk9O62sBzVtGfdxq/bm/88bpVEst/uJalb9PWW
X-Received: by 2002:a05:600c:548e:b0:49f:ddc0:6e8f with SMTP id
 5b1f17b1804b1-49fe66c86a2mr28979325e9.5.1790243583705; 
 Thu, 24 Sep 2026 02:53:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868266822sm14422549f8f.5.2026.09.24.02.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 02:53:02 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 09:53:00 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6
X-Gerrit-Change-Number: 1948
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1948?usp=email>
X-Gerrit-Commit: 9d30ccd17c7f0ae71488d9929531e0834018ec38
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 09:53:00 +0000
In-Reply-To: <gerrit.1790212215000.I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6@gerrit.openvpn.net>
References: <gerrit.1790212215000.I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkkwNDk3NGFjZjY0ZjU0YjIxMmJiNWYyY2RhYThhNzQ1ZmMzZGNmNWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <196343dea5fbb126d8ba0bb54bf7cb0e4ab73c18-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9g8c-000371-FM
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: doc: document
 net_gateway_ipv6 for --route-ipv6
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
 openvpn-devel@lists.sourceforge.net, charlie.vigue@openvpn.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0501789309441438594=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0501789309441438594==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="587gC0kml34="; charset=UTF-8

--587gC0kml34=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, plaisthos=2E

flichtenheld ha=
s posted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1948?usp=3Demail )

Change subject: doc: document net_gatewa=
y_ipv6 for --route-ipv6
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 1: Code-Review-2

(1 comment)

Patchset:

PS1: 
This =
should be folded into the patch implementing the option=2E I see no reason =
to split them



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1948?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0497=
4acf64f54b212bb5f2cdaa8a745fc3dcf5e6
Gerrit-Change-Number: 1948
Gerrit-Patc=
hSet: 1
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue@openvpn=2Ecom>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: =
Thu, 24 Sep 2026 09:53:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
Yes

--587gC0kml34=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, plaisthos=2E </p>
<p>flichtenheld has posted =
comments on this change by chugly=2E</p><p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1948?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1948?tab=3Dcomments&amp=
;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">This should be folded into the patch i=
mplementing the option=2E I see no reason to split them</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1948?usp=3Demail">change 1948</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1948?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1948 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@openvpn=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Thu, 24 Sep 2026 09:53:00 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--587gC0kml34=--


--===============0501789309441438594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0501789309441438594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0501789309441438594==--

