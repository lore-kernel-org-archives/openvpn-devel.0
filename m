Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077D606A326
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Oj3ZLkvr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=enrLn9Kt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F43y3SC0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Nc0vgOTH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BiLV6g2k97biIxfv5fageNC8pZ2R0/vY0mneK8h/wu0=; b=Oj3ZLkvrqrfS6BDo5nq54LHsgw
	nBvyzOfgm975oQhC5fCdgffzy0kwpDw/nUtqU+0DMLb0jwIdFp5zfvm+uTzR+aAbZVNFElsFS3CIO
	o1H97i9dwxO35O0FU979hXTWFvb+KT/6hQi97gCO2bbIj0Y7hd9m23nKuuj4uccz+Ick=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU0BV-000000000zc-1PBf;
	Thu, 19 Nov 2026 11:20:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU0BQ-000000000zT-2qYq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kslADltds3bP83c++OTvj2VaW8EoqQNRlcbVX67TLec=; b=enrLn9KtXb0BluErkDPXCUP8JG
 v0VNMYzUpNQWQ+GOyJIN/Ibp5nnglRijXnK1z44zdFhdB587hf/7T6gwooOVC/xrBy/raDvk5tOk4
 tGhlxfrUQ2d/mY9Il46o4qi9dUPj8VuhFAFV9BhFD6iLipLGIZ6hgzPyapFDi+IADgVU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kslADltds3bP83c++OTvj2VaW8EoqQNRlcbVX67TLec=; b=F43y3SC0Mre/b6zOOESJlrzACU
 PjhIUMFDiMjslki761jy6Mr6RKrX+v6vI95d3iuH0is1ehzO3byF9T2peU1WqcmmR4Q+iblnYID6X
 JP/GOaSvmQh4t7mg+Bty1sajLLMLR5yBAwlpU0vYW+/DjNBgHRFDfhVNLSQ7rLZXUUnE=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU0BO-000000006XH-1wbP for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:20:04 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso1343905f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 03:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795087196; x=1795691996; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kslADltds3bP83c++OTvj2VaW8EoqQNRlcbVX67TLec=;
 b=Nc0vgOTHvqg6pxrarmdKWAmS5rSv7gFVtJIn+Qk8YJCYDjJrssslibzJDHFW6sZdrl
 g0xP3ZNaeLyoiB4YdeJk3K3/tycJGjMofhKzdZinzCQ6ha0+h1cf5Qo4CfCQv8elURkG
 +gjIT2MheA8nAUk3en3kqjqhOKFYLqAFEVqRpRr5AYujsvkRE6DZ1CFk+P60no8COGPg
 J5zwV+9UpzqC45+WO2/jpxYaN5IUnT8Dm05MBc1o5L8fd01Gi70S2SlkUsN+tcG50K08
 UXmxPdeXEK876ZVk/uwPCw9ErAa9WQwTxes0yCQZwopbFpziCpbBrF65X9yw6kiXLq2r
 xReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087196; x=1795691996;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kslADltds3bP83c++OTvj2VaW8EoqQNRlcbVX67TLec=;
 b=1ItUcshNL6tqUmLrU6dFAAHotUcxnW8Qw6ZgtIT3A/H/btk37TtsyX21DGRApm0pGm
 1skSIWy5F1uAbOV7ERlfuKJkrQ21ZCYzE1wek7oibTlGsLbbjeTIec7WmXQ4tgwjAggY
 CaKBOJrbkPfsslW2Z2yrr+EAVLhIgi+5ZYxfZhNA14Gl/qsaVe2XKBiFQO7P32Zt9rk9
 kmnbZPrliGa8squ5bpA+kCYN2XQXfyR9l4KCP3nYNqX118VttmQsniH0dUwuVT7vScV8
 jd20/YnhXtnxFJcKVfG3LoHSBYkQbYU9sXA7qyLLi0aS6XY4uACiV+iVOR+YJtiiqrLn
 H11w==
X-Forwarded-Encrypted: i=1;
 AL+hErH+mGgNhfn+20pBFHyHy+vCIrXGhvh4Xfgdvy9MTZ4LD3JfrT6+xon16a9spCNItWjtpcWw+6rLLyTQLuhV@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9XUVOEqlpRCB6CZ3UTE2n8DeNxAwD8fmZn8EG4xU02BPcVf8jp
 t4aCeO2lTWi47cOa4c5HQ0XJXh3y7GZVNfAuRXTbf/6MdUiF/r1O/tFXBweizy98S4ZWiA2hX/q
 qfV/O7MHQ7A/PuaCzxfbOKG5vTNIZyAreQCIAG7Wqsk9ig5/yusReT3v796jVe7duG2Kn
X-Gm-Gg: AZFdTZeRgA6ZYhE3Ljq/L0Ub5FHp1AFtf91YlmJmF0rh0IrBHQ82Gow6cVeHpZOiciV
 k8YyjIDA13VuCKleaqxg/Dd2L4ElwvlkbTvyTJWaX6w85Eazt8SLOO1h0axkzVPjoHpDMczfEZj
 tS78JCEG02Xyp7Wj5Tq+oVhykilKarKXLCBeL5Jclg5xw7F2FJS6OiUFsrIugQBwaVl09+WVDue
 GVnkgSQTBb0rZ11QxRzlgtQ/0k1JfnJfFOkQcIVMCwUDklcSlkW8OpDCurn5sKauhcdwguDu/tM
 +p8JALW6tSOC4sAzRi+IkGDhOzqPxu41gR6TPJiwQLYFMsjj7o/n136AvW35iUsmFTYswvojOKn
 mzpTfH+xe4pGv7KJkpoWaw3w7Uvzi2hSr8q6AI+P3vAy493WlBkrGO8PEh2RaUgNXD0+/zYSe6B
 lBOWc+jhY6XFcEv8oZWGpDqy/wrgSO59oEjGNiKMe8KynaDdFvJ7T0ushpKEzuyYCmTv5ee2pkw
 J0RZkDNqQA+Twr7LMIC/PSqb3WLgUGaHLX1mYgqWu0VmXqjCx3NhwWnshD8rXeBxcwQHG0tjJSC
 vuuT1WUtOHekv9/oQ9yKfQhsIV4EiOULDS19Cu6ry2dBPDL1Nz0mwfn0k5indkt0aaWmtAjM19b
 VK2MxYzfcvOrox1e7rQYXA9HKDqyGXc3eVgkt6/cEPsNRm44X+Tbr5Adb67NvFW/bVi0gSIJ6Be
 SmmcFif7cykrqfGdc=
X-Received: by 2002:a05:6000:41c9:b0:4a3:777a:a964 with SMTP id
 ffacd0b85a97d-4a62d6d4875mr11850690f8f.0.1795087195560; 
 Thu, 19 Nov 2026 03:19:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656933956sm10434485f8f.44.2026.11.19.03.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:19:55 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 11:19:53 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
X-Gerrit-Change-Number: 2220
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2220?usp=email>
X-Gerrit-Commit: 6131a57429a2bd74c378bb73cf696be4482e79f0
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 11:19:53 +0000
In-Reply-To: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
References: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDI0NjMwMDAwLkk5YTc4ZTU3Y2ZmODA1ZTE4OTZkNzlhMTdmYmNkNDEzMmM1YTRiMWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a34d59b47e867c554622eb9213ba2058e1cee9e7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU0BO-000000006XH-1wbP
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: fix MSVC C4047
 in key_method_2_read()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4823873124579751544=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4823873124579751544==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hJBeqnEwv4I="; charset=UTF-8

--hJBeqnEwv4I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail )

Change=
 subject: ssl: fix MSVC C4047 in key_method_2_read()
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchs=
et:

PS1: 
The change is obviously fine, but I cannot reproduce the warning=
:

CL=2Eexe /c =2E=2E=2E /W3 /WX /diagnostics:column /sdl =2E=2E=2E /std:c1=
1 =2E=2E=2E /TC /wd4018 /wd4267 /wd4244 =2E=2E=2E
  ssl=2Ec
  =2E=2E=2E
   =
 0 Errores



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2220?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9a78e=
57cff805e1896d79a17fbcd4132c5a4b1b3
Gerrit-Change-Number: 2220
Gerrit-Patch=
Set: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Lev Stipakov <=
lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comme=
nt-Date: Thu, 19 Nov 2026 11:19:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has=
-Labels: No

--hJBeqnEwv4I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2220?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The cha=
nge is obviously fine, but I cannot reproduce the warning:</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>CL=2Eexe /c =2E=2E=2E /W3 /WX /diagnostics:column /sdl =2E=2E=2E /std:c11 =
=2E=2E=2E /TC /wd4018 /wd4267 /wd4244 =2E=2E=2E<br>  ssl=2Ec<br>  =2E=2E=2E=
<br>    0 Errores</pre></li></ul></li></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail">change 2220</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a78e=
57cff805e1896d79a17fbcd4132c5a4b1b3 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2220 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu,=
 19 Nov 2026 11:19:53 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>

</body></html>
--hJBeqnEwv4I=--


--===============4823873124579751544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4823873124579751544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4823873124579751544==--

