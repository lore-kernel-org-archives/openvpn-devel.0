Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27BEC44515
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rajiNLCctdS9aW/caCcoW6D2giI/OMFrVl3Q/nnSxkM=; b=HdBKij+Vo6GGQfWUhAxOAXNiG/
	FI5frBQ0qVEE2hp5WHwzA/66T5EFeEeTPzWCJsYm1/J4sO+xX9qnC61HGCJG4ZLAaS4ijhT9N3rp8
	9V7XfGKdZW43WzyWHhKP5sWqmoQkGHgMBQb5XsBk6D9neUi++Yp13VQg5Ln2Ilqt6uPU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wloPD-0004UN-KV;
	Mon, 20 Jul 2026 13:51:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wloPC-0004UH-Dw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:51:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GekP1nv7aQ1CbL+GjpNHzxFyaBG0XKyB6pC1O606CzE=; b=g/4kWMQGHYHf1f+A64wYk8T0y3
 GJxXmQ8sZHeY5uLtfeNggIN2h+D4CZmzP/whseyjTYqFmJRNQ4YyROXA11diq9+XST2Fvn2HV0VRW
 GLk6piz845efzrgts0jXE/u3dsriJLHAKsuuipm8UWvO5+apywKgYpSnFCOjp88MkBIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GekP1nv7aQ1CbL+GjpNHzxFyaBG0XKyB6pC1O606CzE=; b=W
 J5sKdh9/sxAGG3/67yXZJCDdcHzvd3LxQiNWNxDRPxy5LfivptnrxigfCOyshjUhhPXhzPhcidKGG
 JkhGYs7lmEGV/SSPRY5PWzT8XEIHV2GNWViYcTEXVZybm3uwpkg6SmVdEogbCcMFkZ5WAVfzhOQWj
 tEi2Jx0HkzZ1i9/U=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wloPB-0003VB-Hr for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:51:39 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso12060025e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784555491; x=1785160291; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GekP1nv7aQ1CbL+GjpNHzxFyaBG0XKyB6pC1O606CzE=;
 b=QY9zZ4Ld3RXpeGlWVQJQbaOz9cpkfwF0lZA+ne2yF6OvJ6appLsPHbrBWbl541udQV
 C01D+Wh7EIorgcU2cwvVAilwntB1rrooGOuHjT8li10sM1Se8iflpSa+Un/zYU+aI8h2
 A4aHvSs52Dymz/8D4TTS3wxA0R12GZYTfIRRlfHSayTU6IflN4LnEN0bc7dUodiJEhwE
 jdbn+PUn34cN+AGyJA9cnKqj5PMQJCKJhxxVv/FVa/lhmzLX+P7vk/pp1bvVSDUN/fHJ
 FDS1mV+tpScGkBJSd5vRyJm7EtKIDknqvdsMASfI71BmZxiR5xHcUmI4N460FDyLQrvu
 twWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784555491; x=1785160291;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GekP1nv7aQ1CbL+GjpNHzxFyaBG0XKyB6pC1O606CzE=;
 b=h5HjDLMoErhbJrV88OvaQcEqdccYDA90cpmUQHwM/jSUCLmZbvHwsySx4JmvAutVWW
 iIEGbtCnUpce/r397Dk1+c6zrRjVqkpbu9U8VoNgCn2kau3r2PKupVHEodJV19bp6TM7
 ZqD2U2pJZtEyDSOUvBApgYCebHm9Cg08N3cGeiae4GwXWsHgFyMIO3r0FyX2xdjKitoj
 27guds9+/w4k93/4Ph7XlxatM9tHKD00cUgP4VytaDbmsshF4FgUHi6VHmpnHjo9l6Lk
 h6qfL8+TO0wwCJYYHw9aeReFZH5BMtjkT3J7hH6qOSjagA4hBbaKgJuEYP+Ym7MX4WoL
 COeA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4Yq8mYpvsEGgNFgnlBH5oMhun+wlJIdk+B8jdvmkcA7vpqZaFAPzaA29JDeq3ieJWCjCnUyADNH2GObMu@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzbMImRdpem6fdJHgP+LPpQafbK5KHAjJ9JdVXHQv2UsIoTzUlp
 e26Dutxyf5xGBUKNPi+9CXuYigslWKHTaadP5Hz1i+fMvI3wqr1MZFxZvqeEPs3HwQvxWaon2o1
 yomUOewXo8XYurUPoB8fJ2NjftnE1xuHb1OY+WWAEdx/6CCTpxXGr5tzmsYzP32SWZ+CVD3Zm3F
 e/GuSsJg==
X-Gm-Gg: AfdE7clr6N57Ystd2QdWsLDqwKsoiBbIL2zrHSjz7HK3T/QAhcTV8PjpJI2gZJil+L8
 XJ46iC2HqwbPnQ1PUO8HHkPH6Ob6hqBg4P3i1RdntgsUHTXzwvxlIqx7tqJsih3+GfYOUUCMYHR
 MHk6BIMznBAvHnZhxm5SJieGmuCtbkjMoHr1/S2bkvRDsahQyjG+gHC2rYSAB5wAoFkGRXTBcue
 mKgwvQ+vfm65ynnEZ1vkEbwc4FcKHXuVxqyicypTuEfHxkliGhAefp9zGWs5q/+zUde/jNFufSo
 xK5ZYsoNkEwa7IJTg3GrOGYqrsCOv+wB57Otv4gzetDeunTtz9t9Ajy59wqntYYr8U1OtrEfjyb
 XHrCM+reLL9pESrKGy4l5GIVFON9yqB33RhAxZJU/kV0gUKgl1JUe1l7r9TJRyfeBelnMmD59XN
 PmSVrCFq3NJEA/oVerXfEbAI+7Gfl7P/mG12fed/yRa7akDmyzcWI3H4diwPxRO2KhjfaVKPyZF
 Us52Fyf0PCjKTX56fMdZTJuoUENnIFwP64lndFJosiYGlMQfMzfnQmzx71LZvUjaf+6+GoXwu0o
 BjI=
X-Received: by 2002:a05:600c:a42:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-4954a3ee98emr173478985e9.3.1784555490735; 
 Mon, 20 Jul 2026 06:51:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563969482sm43064465e9.3.2026.07.20.06.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:51:30 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 13:51:28 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 341208223ac405eb0e06a049255f4923dac766bd
X-Gerrit-Comment-Date: Mon, 20 Jul 2026 13:51:28 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a573a069919e2973cad08b54878ba0c194689a13-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wloPB-0003VB-Hr
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 SERVER_PROBE parsing and the probe-reply decision
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9112984866409048902=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9112984866409048902==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9cnxBBa7N3k="; charset=UTF-8

--9cnxBBa7N3k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1742?usp=3Demail )

Change subject: oob: Add SERVER_PROBE pars=
ing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review-1

(3 comments)

Patchset:

P=
S7: 
nitpicks


File src/openvpn/oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1742/comment/bbc91768_1d8bca0a?usp=3Demail :
PS7, Line 187:     w=
hile (BLEN(payload) >=3D 4)
Instead of hardcoding that 4 why not do `while(=
oob_tlv_read_header(=2E=2E=2E))`?


http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1742/comment/03e61d54_edfd82ef?usp=3Demail :
PS7, Line 232:     memset(r=
eply, 0, sizeof(*reply));
Should probably use CLEAR() macro



-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c=
2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: 7
Gerrit-Owner: stipa <=
lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Comment-Date: Mon, 20 Jul 2026 13:51:28 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--9cnxBBa7N3k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 7:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><p>3=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #7:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">nitpicks</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1742/comment/bbc91768_1d8bca0a?usp=3Demail">Patch Set #7=
, Line 187:</a> <code style=3D"font-family:monospace,monospace">    while (=
BLEN(payload) &gt;=3D 4)</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Instead of hardcoding that 4 why not do=
 `while(oob_tlv_read_header(=2E=2E=2E))`?</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/03e61d54_edfd82ef?usp=3Demail"=
>Patch Set #7, Line 232:</a> <code style=3D"font-family:monospace,monospace=
">    memset(reply, 0, sizeof(*reply));</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Should probably use CLEA=
R() macro</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">change 1742</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f57=
52e9de810a8c2f68c30 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1742 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div =
style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Mon, 20 Jul 2026 13:51:28 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9cnxBBa7N3k=--


--===============9112984866409048902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9112984866409048902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9112984866409048902==--

