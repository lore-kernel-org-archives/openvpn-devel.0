Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4427DCD8C8C
	for <openvpn-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=efcChHvsqvQ0LcMbomAqYtguyJvNqZaFdmqO6yvoPDk=; b=TStRtTS3k/gTVhT0+y8kRNLLZu
	mA1CCrwxjuWLQUCDoCHW59VSQkQ7DBnuUWulx44FQBEzTN13X5ByMZ30p6b07/LNTAt+VZo4ZQvaF
	MP8kRGiA7LVgQZZCcjjEFpOjn9GKxpF5/j0VkizhfbC4Kv7ciY4QmjF9/1uXwJk3fwoA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWKsW-0003QJ-73;
	Sun, 07 Jun 2026 21:17:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWKsV-0003QB-2x
 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 21:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0SF2j0qokeRgjaH0qEI6Ttgh1aa3aM0JQCuBrmOHK78=; b=NNOtJOu75+Z8dKIRS65JNNIe03
 DASKUmOtEz7CcphJvvNAvboXCnH90V9oM/obNbs6G9yTcN/vxJzIZV6D+lzMznTndfSlkuITaPuKy
 6JW0kyl1bXWgZXA5oSAl/nlKf7mCMMzuhtKnBUf8+lP3Xbvzko2AJtKYy9BJdU01f1KY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0SF2j0qokeRgjaH0qEI6Ttgh1aa3aM0JQCuBrmOHK78=; b=c
 4SlZROEUPWY730C2OpnymV9t3mDGShQ1a3ztBY5/m+NOaAEVbbHG++MtEkIYNQjhm70QInD3JOdt+
 rRP157WBFK6lnYLkBGlfbxBhvw1C9lbYLqlm2Vexpl6tpToLSeKhHGaX0eEnKPuQAYosURyKZK1ze
 0XErFUuNpF/AfY8E=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWKsQ-0006yG-9x for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 21:17:52 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ef29c5561so1862634f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 07 Jun 2026 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780867059; x=1781471859; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0SF2j0qokeRgjaH0qEI6Ttgh1aa3aM0JQCuBrmOHK78=;
 b=Z7xUXsW7DSfx2eUAK0m+weKLPGRPrcuJazfs1FesAbs3I26Wo8s0fNusJwOHh0x7gU
 zjAEWyqSfK0wSzTA86BaDTNZBg8RMmkR8TzuWhkvopH0Yp0LnuVV4loKs9XF5OQdgPa1
 dqKe4HnAvbFLWVgoQK/9nEYwAfArFnKzG3lveidn03cjIeuHhQjay993baYkosb/pYZB
 /F6xUgni0a3q4vN5f0kc4/UO12eg+uuO8+4tJ7x1/SbDcHipkBA0onsaNEHvGOIGYOTu
 9WUC770HNmdRFQjiMj3GhlSB0m89ssE5WXl7XBP8UDoOeWXHxAzd0Yqtvi0ggUjCT3Oq
 VR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780867059; x=1781471859;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0SF2j0qokeRgjaH0qEI6Ttgh1aa3aM0JQCuBrmOHK78=;
 b=IExJOSBeMqhZtgn5HxEIvP+krwoCj/QFKS1lySTfrOslq+rJVf26I0LB3U2hC3Ab5u
 8qLhB2sZybxt7bMIKyzMcANOpXMfVD1m2cgHe5BeCYKJ4/w8B82HA8ojj5CGhySHcyId
 /QvBMkjSc512YGITZGO0yuVbHhjnzaA8fkcJiYj59/GpNjjr498fazf41qaDLuky+yAp
 7rfsKgQFZUdKT64mHRg6/8hJXjZwlV56ja7x8SkFroWOiHsyFragAn89jpRXEuMpw/2l
 5WVWD2ywwrMzsRXxJ8c7eIakaWpUMM3TELH3Dy1orxKxp0vILzCpj3VHCbfMcC/gw97v
 GMJA==
X-Gm-Message-State: AOJu0Yxh/JWGWXG4sUUg1wgHMHmSCFYVhKezcEkpmTT8FkMc5G1oNRmc
 muxMCX6GldZ0KeLqvHGby5KDRAekAf1mKersrO60OCjTDHRZEsyxHmvH+WdFs14puOWxb6Qo83c
 J1+Gt+mRrYWojYeqsTAq/4n6qqAMS2gdyQaHjYXd/oWsMHiovua4Oovdv2qlUiwV3GgvDDonpB8
 BwTgpLyQ==
X-Gm-Gg: Acq92OFxwPne4VBNEAzOYndMvi5I+fV08K64Yvzuf2dJ5hBwmi8ErgCj3nci7NKE6TU
 yE9hgrYolxYAy/Y0Ub932cDzbV/HM97lz1TBhjyCLJ/Wm87obAWmATFay7nQhMRp6I4elhEQSyb
 R0eu/EknJ37n7Uz7555M1Cj4qIqqwKxAxMJfTA2T3kjDZMNw95aeuLrudkRfy1SFkxm3M9pgTRB
 iSu8zdGqUIKvd5G8DwzCCKwZkKAOXkmREEPjiibdiduR+1ZpB9hA8nkyu0FVmNWvz8ctv8UzeL5
 8ySaMk5rKM7PIvV7nrXA/UNYjxP1SzKD3cjKBNN6qRai8azBASnWlryMvR5mUsrE7RFxwpskq12
 N7XvLywshaXQsniLQi6GKPGrYBrQPFdvq/IW/IMRc5iGmPV0FU8fkHlHqgVPHxfJ+Tgc0WTRq8K
 g40aQjkBUkvU5vaB6IJDQq2KrhyreFtoOuEXh+Rt8cEbK28C+XrX3w0nRYAcQo88+KalzYdRWBt
 YuTDxxClzO00VcpSZ7aAj4D4ppPDWghewV48qHVO5ubNUdGzdiNl7LmnJx9TybsFuG0xq24DSVj
 LTyVbxgWNu3MOhU/tyGszrNy
X-Received: by 2002:a05:6000:1211:b0:45e:f073:d2fc with SMTP id
 ffacd0b85a97d-460302e445dmr14442595f8f.11.1780867058723; 
 Sun, 07 Jun 2026 14:17:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm82484303f8f.27.2026.06.07.14.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:17:37 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 7 Jun 2026 21:17:33 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 813856dba54347167bcd041b67ed831479cf37b7
X-Gerrit-Comment-Date: Sun, 7 Jun 2026 21:17:33 +0000
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5eb4c44cdde78d5c64fbfb429f9cce2b4f68a467-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWKsQ-0006yG-9x
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8520260421078801927=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8520260421078801927==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dKnApdrj2Tg="; charset=UTF-8

--dKnApdrj2Tg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex=2E

plaisthos has po=
sted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1702?usp=3Demail )

Change subject: mudp: send HMAC reset rep=
ly synchronously
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1702?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
Gerrit-Change-Number=
: 1702
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Eco=
m>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=
=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Da=
te: Sun, 07 Jun 2026 21:17:33 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--dKnApdrj2Tg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, ordex=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">change 1702</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2df0fec7=
86184b9fcf9b7c56c74816325cdb6942 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1702 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: or=
dex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its=
_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Sun, 07 Jun 2026 21:17:33 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--dKnApdrj2Tg=--


--===============8520260421078801927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8520260421078801927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8520260421078801927==--

