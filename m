Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16754CCA464
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lsp6ysc0PsVHNuq4OKZjF8Zm1pyG7j7sEdZYzstlN9w=; b=VhG3EhTZR1GQnzRdyNVs94zlHi
	ye/TZxXimpsas9VxYNe131BiMxo90GZNzMYVpxmwuCQZrE9PoKpEq/BhtZeCJ6R/r4oqszpr77xuh
	sCiH4lsAjo/469ORQm1xStFxLR3CfDQjr9KjjMmuDy38Bygs+TfOXI6lIPSdVRBjm9hw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHdfg-0003hF-Tb;
	Fri, 16 Oct 2026 08:52:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHdfg-0003h9-DD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:52:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zaGt0qEeKApyx96Le0P1bW6jBV3lRzab072AdKZE/e4=; b=FX2Q/HT6YuoHd5diCpAx56qaLl
 OcH5pL4fc1iPbLe0E/QH5KRXziBz4HbsjBfdAttphs6FLqlyR9vVFWTQ6zZ3ltluf71OT3stAcVhi
 V4Cre/k4Cp7MF/g51G+qAlfWO69FplJSe8+GLRFYF3UmsIDNvL/Kz+BXdeA4CfTN851k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zaGt0qEeKApyx96Le0P1bW6jBV3lRzab072AdKZE/e4=; b=b
 WYMI3Pl+xgJHjHW2KnvvAzknbhuDGBaykG9H3ZYHS6ehp4XDSNlVGM9KOOqOrTZ6zecRzVoV6wE67
 dlB8KkJ4ZvyqYRIhRF5j6gJw/D1ts4FH2CFYiPcaSobYpWj4HLYuZEBgsdvtLyfhOenLF+smxQ2c7
 f+/CKl16m4WAhlMM=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHdfd-0001gl-PP for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:52:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so55837445e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792140723; x=1792745523; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zaGt0qEeKApyx96Le0P1bW6jBV3lRzab072AdKZE/e4=;
 b=GzHGpBND4vxOjhen180k6jO6387F8ZZ5gIDoxRQjNlsnSi4pshRh/FW43OyD78CcSZ
 sd6mrGbpf59ofPuya97SXjYSWSEU/GQ10qWnhtHt0oQJeBiGaEfHTtUpCQVhGbH9Dr5W
 ebrGoDQ0Gk6qw3Kc+yRyiH8Z0B9JbpjVvN3/UM54G+B82tGVpeKq2nJe+brR9Ot9x3zg
 VNLhIcbK5T0Hv+wX4nxLE6FfGklMWOO13IREK5AeCTtyU4motDALBTTLa+r8pj5Mhwu5
 /8ZG9vEzONiJCqsH3BAiGAAQxDfpJss5pQcK5/bIlEkZ3CvUEmBt24RCZhASuUOa58A4
 0qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792140723; x=1792745523;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zaGt0qEeKApyx96Le0P1bW6jBV3lRzab072AdKZE/e4=;
 b=m/6lLzHExHTBzTHk0ILf+TcpZs2OYB/WIoH3kPnPAC42LGBg866zuKLYL0/ipx64Ke
 LdM8erUE1v3+HLhJBydPqOpQPjXfuF9yvvCUSh16WhRWcvl6uH/HVsCrW03nWwwygpsv
 qGDX1GEG5yiSP6+B2oIb4H0AreSl3nGA1tE7CBZH+zDwSsxnmll1mHdoGh/cEInKjOpg
 oadKc2m1Fhvim1Pj7CpxKCE5/ySZhn3fu/ATSep8cxp4SaDfYTK21WEG5wyK+WkC3zVC
 g/49VoaGJkaNdVy4cKeuzfF+SG4X2m/b89yxdGvYd/sQ05jY47p9MseFRbyMPWXDjwny
 Jlew==
X-Forwarded-Encrypted: i=1;
 AKwUvByJukWtYy1PLmEzHvNBrrovJ/VsHxSkzGHWFxVvHwmM4wzzJk2nMiv01bFvA41YOROXf/x95Q5jRoKwE8bY@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLR33CtMAYJenqhrjH8fnCWuIC+O4Kv+GiPWrU/RNBcxR+WO6+i
 oyMSk7DACcxX+N4Ty1Y3G6vEvWl+AzeXbs6BBjViOut3+4hpJ6GTTotxAcTTvZGBiQiHCopHa/0
 LTJznMMmkkZT41Gr07xflAzZZW9iScA2mwk+2JYYsg9BtU0pNjCkoP1yzXEtcbIk5w+Ni
X-Gm-Gg: AYBFou3wrIcwt9ZosjfRD8QCdIZOQYZdLOzmmzJlZPaT2OJlnww1ih+2YyPIGbhWuhA
 irQek/tCuIWenLKyENvJJb+Un6QczNOT5t4WrplwLxme1PYlKPbAKWfAAA0CxuhRfxeFhpgbvA9
 JzsyzF6bJfvP676CI52JiRGgilUNIR7Y0rJ0rSKtKDXXWkrhgkks7YgIpYLGcWDJRgHmwZ2ATu3
 wKcPwDk3a3tbOkwKFc8QCr2TMO5YxKDYWX9CM7QfC1dlCY0cns/a7+d+mMZYio9HcErwSCIaZs6
 lkuV8X1mz/Lkb28ee0yE0R3fm4e0LMHVirxmp0pt62qqlgTNj1lMzGl2SKwkJQOW7eMOOjpWQxx
 G/Rfy0AYZA3BRnPSuoJXMEEM6fQriLYnbTJ45J8lA+F9Ld9EIFrE2wOqMbDm9/pH5qKaHiaY/k1
 ucdAaY2ijh8qGKtMq0X5U0gi/1wDTy+mB8A5OCz7z9ZGqW2kIWLH5pGCjpUnu2qPa2SHEXobg5b
 fUzNERik1GP7AXUaNEJNX6JOegx8RoiDmKbyhAyugFQIzLy4GNp16K1oz8XKvfk5yn+Y68fFMdi
 Ke0ju02/RSO0n04Wq/QHv9BBYXSL9CQbUZgYz6ophtPp/LMOODaVe8a5Mc8E
X-Received: by 2002:a05:600c:8b51:b0:49f:d6f0:6f24 with SMTP id
 5b1f17b1804b1-4a18e443b3fmr445553885e9.2.1792140722855; 
 Fri, 16 Oct 2026 01:52:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ac4c70sm32920325e9.2.2026.10.16.01.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:52:02 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 08:52:01 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
X-Gerrit-Change-Number: 1994
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1994?usp=email>
X-Gerrit-Commit: 62776994cb146315c7d1ee6a83edad3f0ff54ea4
X-Gerrit-Comment-Date: Fri, 16 Oct 2026 08:52:01 +0000
In-Reply-To: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
References: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk5MDZiM2ZhZDVkNTIxZTFlNGIwZjE1YWZmNzYzY2Y0ZDRkOGJjMzVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b92142f485629d4c7bed57f8bf03aa1894f28026-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHdfd-0001gl-PP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: compat: Add strlcpy
 and strlcat
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5271486383243930892=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5271486383243930892==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E7JwZHp6tlA="; charset=UTF-8

--E7JwZHp6tlA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=3Demail )

Change=
 subject: compat: Add strlcpy and strlcat
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

Comm=
it Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994/comment/90ab03=
3e_61b2ce74?usp=3Demail :
PS2, Line 9: Avaibable on most systems (Linux sin=
ce
"Available"



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1994?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9=
06b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
Gerrit-Change-Number: 1994
Gerrit-P=
atchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Fri, 16 Oct 2026 08:52:01 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--E7JwZHp6tlA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1994/comment/90ab033e_61b2ce74?usp=3Demail">Patch Set #2=
, Line 9:</a> <code style=3D"font-family:monospace,monospace">Avaibable on =
most systems (Linux since</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">&quot;Available&quot;</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1994?usp=3Demail">change 1994</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1994?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1994 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Fri, 16 Oct 2026 08:52:01 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--E7JwZHp6tlA=--


--===============5271486383243930892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5271486383243930892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5271486383243930892==--

