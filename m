Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A422CD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xRjrMNzMlTF4MQwnWSfaMMuhWttPh+Iriv199NaOprI=; b=arzrLuh7WKUTqhT/nKFL3wHSDY
	+LLnHeZ9WWvW7r/yQ19Ryrrl+XiUrnehanh25KNPuPOKdSHt9DXdZoZoH+ZVbt5Mu/cebETfuu0b1
	AyyHzBJ5UwaAgJrGH5psFVxP4Rtsn+LNLcG9Ug2P55yYzOKBxX73j6r/cLyf4sIX5e1o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxRk-0004Fv-Gp;
	Tue, 09 Jun 2026 14:28:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxRj-0004Fo-GP
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YfFw92qYZ4fgOdBCqBKSw1ndtYC3za39W75pRBcGc/8=; b=d0I66h2ltmA5piliNJKFe6j0aW
 qP+l37jx5lo0IdXRNgYTE5SKl5Y8HjxGGJ8xAbn3RFKOEW3XUlFT6fHuPlzoHpg14KjE+wKlFpbGA
 zlyBpgpd1z+IJeN/KdZmGzBVzXZtgRzB9MPtasUFRnPvVy+Nve/xWer4bZoGlY8pkKeE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YfFw92qYZ4fgOdBCqBKSw1ndtYC3za39W75pRBcGc/8=; b=f
 DdC40jBdHk6l4yAXNliD0N4wc4snhUh3hFkG3tQ64uyhUr0TmQqFBiubm4ShVQCefYBjoryRYPKtV
 umz/MQrjOYf4O5w6ET9fwjN336UAXWniubi0DCuWT6fg/1MnzloDBNaTF1ie047Gi2Sr8ZTmqVqM8
 I5GlZS83iO61iaAw=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxRh-00039t-59 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:28:52 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4600ddc4017so3952177f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781015318; x=1781620118; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YfFw92qYZ4fgOdBCqBKSw1ndtYC3za39W75pRBcGc/8=;
 b=V4HU0LboyEE0XxB3uPUYnKRetKF8Kt6KpB7w/sR46Cj3rH216GJKor2hAFRtgJlKFZ
 f22loToOYbV8wkEUFrxvNgVWRrQ4f3QXZ9hem3clYOrVyP02MWJK7QtA1ffSc5ELtSpn
 nkCNsalZqn2kTC2+p5BLnRFEnVdcnZJQ3CaT1iNn0oL8VcNUIYtwBmlpg0BnX19bWotS
 mDLps9XgkFQFDu5g1cOMyZR9bf77JZ0nDu6YvU1EjaxnV2w2Ea01AIB/tLicmEFoMwq+
 fy+4wpoOVzikbDkRaHAyu+iXWipIXGP2DdujD5uVkCAKu9iKCk40OqJddo6awrTitxCh
 R8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015318; x=1781620118;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YfFw92qYZ4fgOdBCqBKSw1ndtYC3za39W75pRBcGc/8=;
 b=SOSKJHB7ybnT0/g8hVEuuKzOFgTZJC2nVqD+/gLqMlHVzhvO34nS2LBdzKTXbSYOcC
 2ihe3skAXTIQwz6RWRRl4MSbcpyXoc9uBV7yT08zcItaB/VupbApjg71uqSO90HpFIra
 6sYXul+3oMXQUgYiMIpUeaI+wbfGPT+4TUMYbit4SADVV66ZlNuqrCH+ts8kVyUdWnLB
 mBkQuoa+vuhNx2XHCQU50p2/cdjD6Oqxu0qNStCOaZBiqgI4KBTehnkhk4KAICtgJ1NV
 dtO9Qil/eIzgMnXrDZ2Y6IfsNKHKU/z0LQobkSaJSNU7GRzOVyci1o6C9mK/EkylPc7S
 28Bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CWMWTzdK6zvLwuHAkgNz3xM2sSyCjwGVuRJn6flAHO/CL4ty1VAHTyMIlsLt571ZammWDep73b6BvsGBk@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxS3dll3ylJ3ieCQAz7/SH19HYoslPoyvcTQQ5HUsRzM3nj+IN/
 jpydRqSFcvfXgVzfXNGQs39TYyYqw+Qcwn7YthClJ/GvU/87TpaPkRztC2afJefm6sTaZ7Hh9eP
 qZ91qAp+PmOgDvVDpG8lGG6qgdcgg/ELMHrT3cZupo7hXS7ohi52xh8xG1US8p8euPodYszDNVT
 xPaLKeQQ==
X-Gm-Gg: Acq92OFGr6BJGsQxI7mXdiwN5qXGbsDjnSX5ISJEF9yOgJfRk6+mWznlBf9pN0MZBfO
 xwZavYK0pvGDlzcfX373ojlLtBUwPJwhHEZQzwfWchk11LjnB3uiocCKMR0MABEf9spmh2uXgfo
 zfrRTlkyiRoV4eo8FhUCpt9NXk/zuyrUAefbliAXZ/RGhJxknOUA4ZAY5EM8aHSTC0PrweYCRqV
 AWchAnipghuPUwdU+ARfp+LUiNPguG/ocy7Ufdxx9Oe+y6xau0cD0ywB+TEosXHUp4UcEwXLRPB
 dCRWHEt2gSTwTq59/UwmrNBwq/4f/GE280zbErQa9SY6IXkt3eQQ8J4GRwLpkPqE1DK3LLEaZX+
 RxPGjcReu+Y3uOHxU+b0q6/uqPBg8kQneT2/44bSxo+kK0ldJ7Pj21UeirUP+S9rtmUQnKBpq34
 neC3/WTCHQiSti7c2sJegdGEQW9KPlKXsu8BY4fFrds+oAKwSushFi2aTj5rwm93E5H2LainsNd
 xVhClg664jkCSQZ2idMky0gsqU1fC2L7ScI2wu/YPMdPfxWFVyaDYcPyp8vWxz1mixbiD6N6TNT
 zJsaEXYYLVjmMzxPnsK7vcVT
X-Received: by 2002:a05:600c:5248:b0:490:cb90:3e00 with SMTP id
 5b1f17b1804b1-490cb903f1emr164212535e9.14.1780990004897; 
 Tue, 09 Jun 2026 00:26:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3d6c65sm449559415e9.12.2026.06.09.00.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:26:44 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 07:26:43 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 813856dba54347167bcd041b67ed831479cf37b7
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 07:26:43 +0000
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9123f489f7e44a1b3b282ae0062f9e0802d3c1c6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxRh-00039t-59
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mudp: send HMAC
 reset reply synchronously
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0562012132763644961=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0562012132763644961==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AKW7CIL9CCg="; charset=UTF-8

--AKW7CIL9CCg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex=2E

cron2 has posted=
 comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1702?usp=3Demail )

Change subject: mudp: send HMAC reset reply s=
ynchronously
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/mudp=2Ec:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702/comment/6862dd78_2dcdbb54?usp=
=3Demail :
PS1, Line 70:     msg(D_MULTI_DEBUG, "Reset packet from client, =
sending HMAC based reset challenge");
having this `msg()` *after* we alread=
y sent out the packet does not make sense -> this should go upwards, either=
 before or after the `msg_set_prefix()` but definitely before the `process_=
outgoing_link()`=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1702?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I2df0fec786184b9fcf9b7c56c74816325cdb6942
Gerrit-Change-Number: 1702
Gerri=
t-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Re=
viewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex <antonio@man=
delbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: ordex <antonio=
@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 09 Jun 2026 07:26:43 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: Yes

--AKW7CIL9CCg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, ordex=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1702/comment/6862dd78_2dcdbb54?usp=3Demail">Patch Set #1, Line 70:</a> <=
code style=3D"font-family:monospace,monospace">    msg(D_MULTI_DEBUG, &quot=
;Reset packet from client, sending HMAC based reset challenge&quot;);</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">having this `msg()` *after* we already sent out the packet does not m=
ake sense -&gt; this should go upwards, either before or after the `msg_set=
_prefix()` but definitely before the `process_outgoing_link()`=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1702?usp=3Demail">change 1702</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1702?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6=
942 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1702 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gi=
anmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Tue, 09 Jun 2026 07:26:43 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: Yes </div>

</body></html>
--AKW7CIL9CCg=--


--===============0562012132763644961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0562012132763644961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0562012132763644961==--

