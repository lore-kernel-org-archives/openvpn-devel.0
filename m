Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14118CDE001
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQsqPZbvXf8JfaiDufWGQL6rzh9eiMlxDDZU9GdhE2U=; b=FhaGTYidR6MWE7qEe1plrf8xAO
	r/san27MXFroKAAXOzu35h2DV7eKEQx60TLn3hX6kcetN0I3f8XeFgayhHipg1eBOCu4JzHBCLZPx
	tFYbn1BchDwmFjWXp5lGI+8lSkVjnFFNsu1x1/YemcOv2vvOVqRoFVsLLsmB/41RHkgs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wck4L-0000zL-9W;
	Thu, 25 Jun 2026 13:24:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wck4K-0000zF-9t
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oiDgC7P/oQR0LbwpxDRz8qVcqKbLR8ImDiFZc5JUOJg=; b=DHctlxXhm6TJtWVlwtCIR6ZfIk
 GlJXPJ85wmN2MVTNI2ANRSuSxpE2qWKOgh5CVSqGdiicojsLRSY6qW7b3TnJoC3/Lnq2GbWgUUgh3
 3Oi7yXYwA5XPJu1XgTe5cpLp0g2z/jKLj51SwUy2F/KW9p5t25DWEfUSYOA7wmsiGeRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oiDgC7P/oQR0LbwpxDRz8qVcqKbLR8ImDiFZc5JUOJg=; b=X
 Ybn5Sxbk1qho0rnwDG0woCr3RF0dQF0hjBsQtglt4xg+6LXnmwZABwDGIQg149UYAweoFWcEfIJP4
 if1AkiFuxxgBOpmtARy2alEmiLzn9bWOdPgxVNcWsH8rlSQbFp9so/+xGGgRPWDY9qIOlAUKB53+K
 tXkLRhvqWd65gzoA=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wck4I-0000ey-Ar for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:24:36 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so19473345e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782393863; x=1782998663; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oiDgC7P/oQR0LbwpxDRz8qVcqKbLR8ImDiFZc5JUOJg=;
 b=OXGm1LR8FkO8kyVbLMuDifaPdjfCvgEi+7O/M24LILfT3pbSmXRHq1dLb0AW/sFBzM
 //gRg0lEUaShvK2OLG+Hfp2quzp+GeNUebGbLSSTH47mQybKdZPghI1/l9fE42gVNmvE
 yrpGTXOQyHXeb0oHnXZSljWLrVWdEih88DEy4+UnjchlkCJQ78FpmA3pI+YY79PgLYVb
 Jqupsfnrn+W/1oPGyt1tFJSbXgSOI6jmPfxPj9Dra3Km3v3yyMNaQTt+an8XJwxFLS++
 wyxeBNjYnGVgx9rfSQcmYDpbMOC/TsFnWWEGEJeT386FUvZcyX86un28vr8Bkhtxgyk9
 8vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782393863; x=1782998663;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oiDgC7P/oQR0LbwpxDRz8qVcqKbLR8ImDiFZc5JUOJg=;
 b=JFEFgx2UHOro+G2jSSqog6xrBTCAWm7+gbXZr5OyVpdJ80I/NKKMfzx40g/rbc/w2y
 6cD/uY9h20zcH1H+iRxplDzuPZYmyptNkWIOprbUfr/XfPk562C2THR1xdBYbzxOOPPn
 HoIOC6tzmO04EgcxLxQvq0HRguy3ZwJtqurDz8yzie0RujlbGJzL/FPSij52gedXNdlO
 dXih5vmNfNNVK6c45sRlj0FHYZmSGIdA36OPCgvRm5wm+h52TCq+R732pOuo7TlHN21y
 X1sUB7yetw+llIU6AsCH8zck3YndxLxJOCYnb3666PsYqDM5cZPIMwqtRspDQ4Y4GQsa
 FRlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iLD/P10W0zk16IMCQLHqu4VifMuNwW2Ap85LDJwl2lr9yszYQ3hfIiScAHdriP+6AIxVTjpiWLobcLAei@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxMimKW3NyK3pzcT6jWHfnQS8K6CEqfN2wMqRdX6BbChk1G/MxM
 OoqYw6HBmBJwaCx9tCKT2nYFuIDvRakuu06/MEKx0QY/nDc3aWTUl1mj1iInWn9uUhfSs/fZTzo
 SboKmfincciObVFj1sDfVZaYQNLAwsH1TapRUjQPxxHj+WCnQtnr+pU8XkJjcMG+aIuSvDKextr
 QKq4Ulyw==
X-Gm-Gg: AfdE7ckjPnNX7/5vqD2hLo+pgld3MNYogUVZE8hE01MlTYjEMn6S2bpzCCA+vNy4GZu
 O68w7Epm/VmOSiJw09mZ7IdrtOlDtVwpANMnTexadIPchEpKf9RSPrA9mUJFmPvqglNExXdbXLr
 i9isiNPmajDaeDJQCI7gWwWldNPz6YZwadZujLV/RUZO6Ta5pdIhjKK+MFRZiW+5b+8ty0acEyP
 F3uouj+hp0CnvLVyIlZmSiPUYYW2CEDzYXKRIfmR7bQoCGIbDk1a2kDXRyFNsNo5On9AITIh69M
 4VZpb8jwnr/KT+qWyfwBkdKPhAQuSu/Pjfikkt0+tyLs6ZAyu799SCl+YqL4SSMTw+m5BPyL7xp
 iWMnwVPR2SmFeqyZVSUjla/4ZlEIDC19fz7e0iQ2HwT0ZZIp22XaE3Ia9493IfHxr5NM6Ix+Gar
 QHMLxcq4FtJ6Sy68L31mZ8D6a2yW72BAzRpPBIvTAIkhmQGNZ3QYGMKIGR/CLtlwK19drKW1ixV
 VsugKjVsQgVhH+6BtQIZ30l94tvUE69TIxwPB7mC2Axs6TK/x8xtHEM3HslXkaBvsgg55FUMyCg
 v7w=
X-Received: by 2002:a05:600c:6386:b0:490:ba61:7981 with SMTP id
 5b1f17b1804b1-49266885895mr35421715e9.23.1782393863066; 
 Thu, 25 Jun 2026 06:24:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660724e8sm36592245e9.2.2026.06.25.06.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:24:22 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:24:21 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
X-Gerrit-Change-Number: 1719
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1719?usp=email>
X-Gerrit-Commit: c0541eaa980ef834b0c33d23aa466d7582ea877b
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 13:24:21 +0000
In-Reply-To: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZjM1NDVmNzAzMTI2ZGJlOTZmODA5ZTY5YWQzNTE3NDliMTRiMWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1443d27dce4a1e73340594f0a3aa28e02680e27e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wck4I-0000ey-Ar
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support p2p NCP
 negotiation in p2mp mode
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
Content-Type: multipart/mixed; boundary="===============4040601230063164954=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4040601230063164954==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MhllIBXXSlE="; charset=UTF-8

--MhllIBXXSlE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1719?usp=3Demail )

Change subject: Support p2p NCP negotiation i=
n p2mp mode
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2:

(2 comments)

Commit Message:

http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1719/comment/65184261_a64bbbd2?usp=3Demail :
PS2, Line 10: dete=
cted=2E This is currently make little difference as peer-id/DATAv2 does
> "=
makes"
Done


File src/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1719/comment/a20fb3db_b6bdafc6?usp=3Demail :
PS2, Line 2339:       =
          /* If the peer is using NCP P2P we also use p2p to make connectin=
g
> How is enabling sending peer_info "using p2p"? This comment doesn't mak=
e sense to me=2E
I reworded that sentence to make more sense=2E



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad3=
51749b14b1e1
Gerrit-Change-Number: 1719
Gerrit-PatchSet: 2
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-C=
omment-Date: Thu, 25 Jun 2026 13:24:21 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>=


--MhllIBXXSlE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1719?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719/comment/6518=
4261_a64bbbd2?usp=3Demail">Patch Set #2, Line 10:</a> <code style=3D"font-f=
amily:monospace,monospace">detected=2E This is currently make little differ=
ence as peer-id/DATAv2 does</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;makes&quot;</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719/comment/a20fb3db_=
b6bdafc6?usp=3Demail">Patch Set #2, Line 2339:</a> <code style=3D"font-fami=
ly:monospace,monospace">                /* If the peer is using NCP P2P we =
also use p2p to make connecting</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">How is enabling sendi=
ng peer_info &quot;using p2p&quot;? This comment doesn&#39;t make sense to =
me=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">I reworded that sentence to make more sense=2E</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1719?usp=3Demail">change 1719</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b=
14b1e1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1719 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 25 Jun 2026 =
13:24:21 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--MhllIBXXSlE=--


--===============4040601230063164954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4040601230063164954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4040601230063164954==--

