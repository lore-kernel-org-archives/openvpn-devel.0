Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71A9CA9ED2
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4P7pT0WuJaJf32H82Ca0BLxBxaO4MhoypSb/3Fc1GZU=; b=IKKOryRAaiAUAL7zOqbhU6Ce+1
	P4Z5NMBfuNyNDt3kzURet+L+OwbEl3qGxQpnI7lyh8mvCe1QafIUh8mAUnY4dlPyq4HFkSdTTHqNW
	Q8LmXI4mYauiBbhYCJksdCkAnOtm/6isKv4ELnnRFHw534Pc+LhLqroQ8SpL5J/5Z3jo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGa3R-0004bQ-LN;
	Tue, 13 Oct 2026 10:48:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGa3Q-0004bJ-PE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:48:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VYqCel4wZYEeh5v4hWs+dlWG443ETn6n5RY3HP6fMSs=; b=NCiWlWCTloyUx0jaQJfww8evMJ
 J+REN1dPRPsrcS1cI+IR+Eoht/lisblu9sVRrN4ZmeWMeJdlkLpyJSIh/2PZx5SgCboNNCCqrMyEd
 AfTz94jLL+2SOcIOGawBTYo64ui1yOLQENjxPu96oWXL0h7n2pPKJNF+CuIBXNOyteX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VYqCel4wZYEeh5v4hWs+dlWG443ETn6n5RY3HP6fMSs=; b=Q
 VgoGmNFdOly0C9D1n0EJd6Z7tH5Ur6dbKUUH1o15pEfjBEHj1rtrbh8xn0k+X9UV2zEyZg18Yy5dA
 /IEaOXffnWL0pTmMSe49lUdtTVOryKRhinIu1HrpiuurKXd7FPFe36603L7PlOa8x62QmB7xFWzdM
 n9vlucYeakwDhFX4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGa3N-0003aS-5n for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:48:18 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so24264835e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791888491; x=1792493291; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VYqCel4wZYEeh5v4hWs+dlWG443ETn6n5RY3HP6fMSs=;
 b=QxnGFEXmZv2KaYFh/pZ1qthsQQFLTJ9vQsDhccfeAX9NoXrRCMK8oEtrZelfKWPwoD
 DJIDUdTPyMENwLM9KzCGI4IBZyRXUyc63tVVrFuROqtiy2xJZmndrCZY8m7ZLdMlud+0
 oxI/XdulucT1ukomcjUWLpAgq4HetYXFHOjkZzwP2JuSdR9H/ge5KiVjKOeWMNvE6PJo
 LbSrfEbY1BbNDMUZ3kogTQVaxU//vD6cLp7mpIPV+xpxayptojDJbR8h4RaqDagWk2lb
 qR6yt2e6st0kWh5UNCaYgYZIe7LbfhKUI5ICByYFbrnO7QDN2fxuRqJbvKC367IZ7ydy
 WHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888491; x=1792493291;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VYqCel4wZYEeh5v4hWs+dlWG443ETn6n5RY3HP6fMSs=;
 b=c3Wwe37olB9E+NNo2hQrGFwncO6e6ERfzINVGYMzLLHr5M8a2QBtIGo7fXC66bzGry
 BXJteEivteKpL1iIf9/J/Ec1k3y8r7KlQggZoUaRbtFAa/tE8N28ttsy1GN+dA9SDzmw
 gs57EkximznLpCUzTgqYra+spnC+jrC0PZTYpIU/W6afmY6FK9f/TuCLy+rEf97tRxr/
 2W+2ikYi0aSvZGg2ff0X+D74ksRYO0PH3e/W6rlhGD24XIJZCecoGUA40AHKCV0rCeRz
 rYUbkIXY96NVVHRmlvm7Gi9gwwZ5LDp7yaNgjKpV58qp+iOsR9S/pa9m9JKzpa841/kP
 wEHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoHQO4uG2PGJ95gbnGOy/V6vAjp1Ur/OQQXQV9iehcfHl32tJvdolZMG+R2XzHzMX9Zo3kHuUDMutsJRNX@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLu9qwBvf81Hn5RnR+2yTT9cmFZVJqqSvarC8MTxFSJEi3wCNVi
 stGBHr0HlIy4Z1FEYDjI+UvhgGg3bgsDTsLcg1lAPL8un2gEfsvNgFvQCb5AOEPJF4C2x5134Iy
 b4Gjo3VG5vmi675sj8KlyYwVIGQi7AL1HfXJrVAyUMj0Zj/nX52V8pkBF3O05LU5CAvK84tdQvZ
 kODEboKg==
X-Gm-Gg: AYBFou0SajsplTw4a5P6MBVLG6lTyoORaTsDtNY9JF4hsFSSEb5e3OgQFziF2MZNKUv
 kP4ubgqoBMeJGioTzPTlE3+HQg/IYw9MzddRJl5WGWN2qk6c5soxlbNmk56Y4er8UAlQibRFooI
 A91UBQMevQPLnAORLza9H+KSMf3+ic/7ZMIZEAaXSOP22xM3F8+feSt9YePbN0IUNFQmEi8Wa70
 zDtkSO7zXTv44ATWIKa/ESLE/cmvOsHwN6PfY5wl0eUU4cdKZ0KgWipccLMYDx/5pvNYyMFNu21
 fvFH3K+2sCoLITlL7Rog9IJM0rQPJ8Ft/+WUsI1hTQJCwD0ccB+HkXZZFPFIfnVU6b3XIsA+pgk
 1D4gc56RflQyJ/RlK4yMUJNbcRJhzLMAQ7XtJnj595dkoERZ1VqMLyvYTXabOjKfZlHrRNj+OW9
 mq7qdy1INZ/OA95+rWS3DjWct7rL4ztHXN45QtwePg7G1qrXCFCDrWQuHcvib2QDfQAncvyoSOc
 NQMoYKXrnPHxkgW8nBulFWAUhD5xvHA8xNpBK5GX16QNErZ+kwOtFjhPuaiEN6Erao5OGxdTgmN
 snPd0q6VBztFHB+/kTPMpaZTA0tP63l/WHHlT2qkSpT+Av2QyN+CUeDOLig2
X-Received: by 2002:a05:600c:3f06:b0:49f:ce78:356f with SMTP id
 5b1f17b1804b1-4a18e4ca2acmr237252565e9.32.1791888490418; 
 Tue, 13 Oct 2026 03:48:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0514ab1sm5920354f8f.0.2026.10.13.03.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:48:10 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 10:48:08 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: b4004c28690cdc057f33573ca50e018eaebe0baf
X-Gerrit-Comment-Date: Tue, 13 Oct 2026 10:48:08 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c3548cfd55de4ce0d8df186fd4a2c98218d2649-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGa3N-0003aS-5n
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2180579876526731414=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2180579876526731414==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hfCx2A7tt8E="; charset=UTF-8

--hfCx2A7tt8E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Antonio Q=
uartulli has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c=
94099fb0
Gerrit-Change-Number: 1991
Gerrit-PatchSet: 1
Gerrit-Owner: Ralf L=
ici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mand=
elbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 13 Oct 2026 10:48:08 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--hfCx2A7tt8E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Antonio Quartulli =
has posted comments on this change by Ralf Lici=2E</p><p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">change 19=
91</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I97c55e211f9113d090808724ab43cb3c94099fb0 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1991 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Ralf Lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue=
, 13 Oct 2026 10:48:08 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>

</body></html>
--hfCx2A7tt8E=--


--===============2180579876526731414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2180579876526731414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2180579876526731414==--

