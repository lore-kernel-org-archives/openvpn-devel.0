Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F06FC53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T52UZeAK7rJKPbW14SPwevCFgu+pgMMXJ2txImx3iSw=; b=dXezVYCeQOkVmDkMAoLq2JEVJu
	X4QHIgYB2JtK7+RelQXDXsUJKjNCWqbeSA/BNO3ZUh3o/MyYfaKSB9ASQzPCzcFKLS7yFA4MLR9j9
	6w8fsbLlWyA2EofFlh0rcYtuzacsTE1v6B7SAGoxSgTCIheKyFhpON357zZ8kJ7ZDb0w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogji-0003Sr-NP;
	Tue, 28 Jul 2026 12:16:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wogjg-0003Sl-Ul
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:16:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=I+4WKZG9uQCUQnL8IWYfusIT8o9rP39/v2lYT7R4NEA=; b=fcsieRun3J7DbxDYe3bF/XYH0K
 wkkFIjC0ZhlZX/dUdXEvqIGR9+MB0uqRqSGMSWn7iQSO3Pz/7QRcY8kJBWX6lvY6kJtrfQfbqk5jJ
 ptSX/Ei6MP1jElZ+jikPHj2PT7Nce1a3QRKhn2NEvqiXSoxBB/CCEYhn0b1nDIU7CDIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I+4WKZG9uQCUQnL8IWYfusIT8o9rP39/v2lYT7R4NEA=; b=E
 U6jLqWmo8WvSl8zmgwOW46dOMCkB4iX2Nlc5QT/BPAWXOosXQnWhTXdm7y27Xi53J3lsXbtEGEFa9
 LPnw/BOn2g+ZXu8vogo/0dJ5Sb2HZCIk+UqtsPHEscW12V50yoHb08LkOH6rOozV2n8xt0DkKBKwl
 k4kc8Ih1lMaDUItY=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wogjg-0003nL-5c for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:16:40 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f97d310caso2667240f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 05:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785240994; x=1785845794; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I+4WKZG9uQCUQnL8IWYfusIT8o9rP39/v2lYT7R4NEA=;
 b=MP+Z8GAIuhZWLET/2RbKY0bVHdSQglbe+Jah4e6vtWiM3+AGtZ0A38NmJEuzBz3zaY
 OOi08AoQ6LH4CVjC77YLiNOR0DpsaXps6Oyf0oiPMJiqd9FE63YnJvLs7SsGY92W1E5q
 zQPubYPKUZIMaDhG0r/kDYbJh5M6JpuPkgRqVHcpIuEUZk++eniCbhbDHZlSTl4ayNfb
 nggu5LzEN7bO7QLjXSBr5o6Tm1YMqko7IUJZ1laXVsmRKgxxes2h3PuahSnTVNZBoFkh
 ONeLz5Oh2FIhaRe8ZJxTzmPwHP8HdqoyB4z0QU/pdAe7RQd6NdHDadxIqW8xwiyxDnP/
 x8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240994; x=1785845794;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I+4WKZG9uQCUQnL8IWYfusIT8o9rP39/v2lYT7R4NEA=;
 b=kyuotcmHpSFABHYIu3Faz/8iuR/9VPpQocX+HfUY3eQuR0BtRW7MmQxd0wdWKGfg6v
 3MfdQi4sVbBt5LhbHIsKNHyJluAGBNKWSvgvdz+cWNx9Mx5YE/owm8BhQkEDmTmFomcJ
 zlpj7WmGdsVx5gdXBYPYka7O1G4tdodU+xJNpcAx48m8H9eNWyMfE0APMEDO4oH/YQ5y
 2chop5ktTU2/N7+cSD0Ay80dml+GkMUtOooGuqxcTZi4+sKMtvE8iLPARbMViT/DZK+q
 MiWz3P0x3oM1ll7ZhA5H8N9BgQsWpXNWWyy+U/mFUtPCpHkKqcLaN0p+6yR7/inYFbv8
 WeAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIr6Tro7wfqhNjUGA/h/Azn9/YlXwBrEfJQ8V4Dv5FIX+R/8Mh/6BoMFc2HnrYI1OaSiU44AWNPiUEibhH@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzR2Iprcj7apNlSEvdEXRbF3oilFDQ69eGlLKpGWMvT/jrid+YP
 S70wYBPq01D2fSMRb3mYVS9PtNr9g4ul5GS/lCg/5UfW8LsRoXmouGaSZM3arYaA315lT0olckU
 3gJoRZoFRvSwefUd5h9RWFd6BsNLW1Bc1hYcurEIqtFaMHxIqLnu1WlSxdi7xq96+cUCajT8WBY
 iRL7tDag==
X-Gm-Gg: AR+sD13ep3C/ZB51ws8XEMytmGB45eRvqes1jeSou+gikSFFpkwsCPHal/0gWVEnDQR
 ty5bbbzg09p8o0JWiTtN2XrT+P3ToiR3qMrEsMPYEmJc6J9INMPJOyKbyiI9mHPrqa5SJRPPXgs
 gSlkFMh0PmDfXZwDc1shTo/jvAkIQh14q2CQJvT9VczM0VFOLIjxUGIrBb/QafzBRBuiIv0q88s
 88w73VTs46pxtoJ2FSPjuS7NNkElXtoc3uJyPjEkC7Nv0iFrqJ90dmpG4fqvphi5GEZL6Rni9YC
 B5H9YUimOFIAiB3mwL8M3jgcUE56aJzq2AWkPNNthvjgnZViGPUPjy9QlSWVNaljOmJoGu7fiiW
 KXRtpD6gZGHb/L6xNlyshQ6SyJlbfsHiKJuwbOu4xKFuwRPjWFO8SS75SCLP/jXTrXqP7wmW9Tu
 tZHlAL2jP6jCVgeh/5IDkGCr/Ie0dTCD40NFKi+6j2jmVTjA0ZDFgTEIYPSLXQcRVC26RK/0nxG
 T0XhkJS8EZB75zNvBwXTxexNCWyfi4sjCRGNYzFCUMpnnpKh0n7j2SdgmOl0qA4fypl
X-Received: by 2002:a05:6000:5c8:b0:47f:8112:f793 with SMTP id
 ffacd0b85a97d-47fb1e9273dmr2914616f8f.13.1785240993438; 
 Tue, 28 Jul 2026 05:16:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm61047881f8f.31.2026.07.28.05.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:16:32 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 12:16:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: 0c96106fa08237e4500526924ff073372406f9c7
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 12:16:30 +0000
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4b88c8bb14262a1eb21fe96eb46822bf1156086-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wogjg-0003nL-5c
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move schedule test
 to a unit test
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7032708248728422965=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7032708248728422965==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N3ZxrCkOJ0Q="; charset=UTF-8

--N3ZxrCkOJ0Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1828?usp=3Demail )

Change subject: Move schedule test to a unit =
test
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2:

(3 comments)

Patchset:

PS1: 
> why did you decide to include this=
 test in test_misc instead of creating its own runner? You did cre [=E2=80=
=A6]
I don't think we need more test runners=2E We already have a quite a l=
ot=2E But I still wanted to have it in its own C file to seperate the code=
=2E


File tests/unit_tests/openvpn/Makefile=2Eam:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1828/comment/480750f8_e68355c4?usp=3Demail :
PS1, Line 3=
73:     test_schedule=2Ec test_schedule=2Eh \
> wrong whitespace
Done


Fil=
e tests/unit_tests/openvpn/test_schedule=2Eh:

http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1828/comment/c822d468_63f4382d?usp=3Demail :
PS1, Line 23:  *=
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
> old style=
 header, please use current one
Done



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1828?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
Gerrit-Change-N=
umber: 1828
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 28 Jul 202=
6 12:16:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-R=
eply-To: flichtenheld <frank@lichtenheld=2Ecom>

--N3ZxrCkOJ0Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><p>3 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?tab=3Dcomments&amp=
;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">why did you decide to inclu=
de this test in test_misc instead of creating its own runner? You did cre [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">I don&#39;t think we need more test runners=2E =
We already have a quite a lot=2E But I still wanted to have it in its own C=
 file to seperate the code=2E</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File tests/unit_tests/openvpn/Makefile=2Eam:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1828/comment/480750f8_e68355c4?usp=3Demail">Patch Set #1, Line =
373:</a> <code style=3D"font-family:monospace,monospace">    test_schedule=
=2Ec test_schedule=2Eh \</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">wrong whitespace</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File t=
ests/unit_tests/openvpn/test_schedule=2Eh:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/182=
8/comment/c822d468_63f4382d?usp=3Demail">Patch Set #1, Line 23:</a> <code s=
tyle=3D"font-family:monospace,monospace"> *  51 Franklin Street, Fifth Floo=
r, Boston, MA 02110-1301 USA=2E</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">old style header, ple=
ase use current one</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Dema=
il">change 1828</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
828?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1828 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 12:16:30 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-=
Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></htm=
l>
--N3ZxrCkOJ0Q=--


--===============7032708248728422965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7032708248728422965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7032708248728422965==--

