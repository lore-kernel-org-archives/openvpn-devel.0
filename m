Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40375C5DF66
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=om9a6hhj2c/7E3BRmKna8ApWojyDGC+jPkRPFFpLiVI=; b=h2Igg27l6WboNWkTAeOynfcKHR
	MnEjy2Qgw95ZzLnQ11iTYOXeA2WohxUavPTm0Qd7ElFufo/iQIWcp4t4giW8fvs9H2MN1xO765Er2
	qaaSzhg72k8Hdk/DNpyht/9V0iwVcyCFQtJncrvXfJCVMAj0YR+RLn7hnHzdpBWjwy5c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuUrb-0005lX-6S;
	Thu, 13 Aug 2026 12:48:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuUrW-0005lO-Bl
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 12:48:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UDxtG/hRKTuwO8YNURJo78LdO06UobKiwpzt8GJFViE=; b=DoNB6KTlq/TVI9eUdHEcbNOyv1
 GMwQeSxRSG1alALtA2udDRS35zWCQ/2JXp2yW7UrRs0DiSbXKG32zXCQHJcmflUYZdAYMbRSvsOHI
 b5J559JS2d3lTFo9NPMxfEvMCnPQHJxtYYFGPN3RHBRA+8tCY2fzonUBCRaaJ3zUMUuk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UDxtG/hRKTuwO8YNURJo78LdO06UobKiwpzt8GJFViE=; b=X
 rgdante8Pf/hYtuw7400trQg5l+Wj1yQEbgW2FWdLoKAeeKSHjaa/Sq0ryfDvlng0fXf0d6LHRkln
 72vAt4x96U/Wbl14D3EikW9rISo5bgsEQMO08i7W9gtWd/e6pIQIOFOpn4lW7uO183Uoti5a8Bkvm
 tvvGC0P+YNqxSrTM=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuUrP-0006CU-B5 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 12:48:43 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so15100475e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786625313; x=1787230113; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UDxtG/hRKTuwO8YNURJo78LdO06UobKiwpzt8GJFViE=;
 b=KG8UezVohiVBnpsj5bUdi4wK8ysiEVWfdqbdlQMdN8JG3hcIUCceT5nqLHXG+TNe3C
 Kc79zybYeSTNv5VlwJEVjX1+U/hIf4yu6Ov0xxFMKTDXGAepItYtmXv5UGnlV7MjUx/1
 JSXyB2G8iKVepDDhrOHs9O7MZkF/aOa8cKCDtMTcAqLjRK1jX53SEcBvOd0nuh8Dengj
 3zfhFSmznzxe93JhO66iQA54TOAqAkGTpaFNStDdvvkic6uR7O6lYfcgYfG+75d3TjIT
 rTNmQrPm2j30rPWbS40cSggn2BceQfih1PlWknoUP6uOVdUKbD/S6PGzpJYSeeY/85Ly
 2wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786625313; x=1787230113;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UDxtG/hRKTuwO8YNURJo78LdO06UobKiwpzt8GJFViE=;
 b=iuWaWzPzQM6wBrjsGY+MDGUumQIGcG1JB/y2R0wySE0bE0csrcyprNysclffaHbMmb
 Xa1DurxrwAKjwHGUQlUyHtrYP0Huf72jrl2m6UVkIA+9RWFJZ40eGZyG+q9X97RiokKx
 KuUyFjyOQn2UFszhhx/cm5MYRWo1/S2nd8MQtR376cBRRDa9/TkJIvf1YLFyoXqmpKOn
 IJncqO13zsfit2cuJbfchvz6oMWGAj3/+x4MuvYAFGqVdb7Y1IWMl/qtqlUjH/xErJF8
 5LX0+Wglydx5SK2/IidoAS7XYiU+Iru+LgObBs/R06/VCDYPCqI0q+DbbWpUnOyiKNkz
 aXHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnZGIspLdxDMsgpyu211/pSwOe3Cc4vosfjxGXoUBUG0GGAPeVAU6QOVxiEpmzXiR87yWSEox5+uwe4tQ6@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw5X9hvCpLAbHY5nVzTMO6KNGrtO7jw/OkFFxwPZvX2aDsedekI
 GLkdwnXdowrzmeIgo4bBn3IU4Gq4Tgz1xw+wjxtKpEtDspdG7n6LEIXCnS/LRPhIhhd9obM132V
 HVP7MscLPEcr1s1kbu2HgdBy7A359dQUbFWXJXUNL9a7cEB3AAfSyPkmqHmAikIc2W4PT
X-Gm-Gg: AR+sD11FkTXkfOCFvqMUcceKZo/wPyW12X2KQwi/vVzvYaPMjOAohNiMBUZlkz5auSS
 uSecCPR+newd0FRk3uravMPBCsN9x6hhDJ7kYv6jdtIPx7oCNPjFv0qITpLhBZzZngKpbDCJh8V
 fjQrdm1N+CikQdrtn62wlk3uX+KpqpyUYjAj8tQfeBXzTVRNebi8Pq2nIUw3W7aIxMGlmktIYi9
 W03+C5l81cTNCTjkOCtYvzWjvlNs4GL5ZZ76vQmmoBnMOSBldj37xaQjwEdaPoSWmBTmKXXWJ1S
 c1DIHOyScxHH484cAc/VfI/OoECh91Lfvin5UkpeYq0R5P/Mkt/+mBmn0ESR87Oa5nCboQumX6o
 BMCdu7C5nsHHVTUDDUG2tZrMUIzzjxRrSt0E/whjg+s0an2qjwRd02To/Xocs3h9fud3SQ+encX
 0rx8wCDTpGVt9+4Z6mBtMSc9SR3eUdK4K9ZcKDc+U7beybquxNxpJUolwrxFeilbhfqdIWd1JF1
 z5n/mKqnUmaUPfvrR2w9V5igmBHswtlNhPhcUtavIYl6SE1a2k4JIjUgG544YZ8Bs8nnBeLthdP
 ViRKYdrsuzD3JGhLlrFduRBsXnBMewRQshS9yEVkEAwtniGkNpc=
X-Received: by 2002:a05:600c:358b:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-499821c2ffdmr69451085e9.13.1786625312579; 
 Thu, 13 Aug 2026 05:48:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e3d3d9sm40892255e9.3.2026.08.13.05.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 05:48:32 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 12:48:28 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 217af18cbca9c5fe2aa6794c9f4f6633f150205a
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 12:48:28 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <952ed3baa7fc6e5e6bb5a3ed82a773a365e6b2ad-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuUrP-0006CU-B5
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4691784331109490157=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4691784331109490157==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9KwwPyaun5U="; charset=UTF-8

--9KwwPyaun5U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1826?usp=3Demail )

Change subject: Make required action=
 returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review-1

(3 comme=
nts)

File src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1826/comment/37634b9b_6d626d52?usp=3Demail :
PS6, Line 219:         return=
 PRE_DECRYPT_CREATE_SESSION_SKIP;
If I got this right, before we returned F=
ALSE for invalid/missing SID or wrong pid, and the calling code did nothing=
=2E Now we only log "ret" and return PRE_DECRYPT_CREATE_SESSION_SKIP, which=
 makes calling code create multi_instance and call session_skip_to_pre_star=
t() with attacker-supplied session-id=2E 

What about

return ret ? PRE_DEC=
RYPT_CREATE_SESSION_SKIP : PRE_DECRYPT_NO_ACTION;


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1826/comment/903eb032_918042cd?usp=3Demail :
PS6, Line 2=
49:         return NULL;
here we leak gc


http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1826/comment/234941b8_caa0d072?usp=3Demail :
PS6, Line 280:      =
               mi->context=2Ec2=2Etls_multi->n_sessions++;
previously we on=
ly incremented sessions when we skipped to pre_start and now we do it for C=
REATE_SESSION as well, is this intended?



-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
Gerrit-Chan=
ge-Number: 1826
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Thu, 13 Aug 2026 12:48:28 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: Yes

--9KwwPyaun5U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 6:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p=
><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1826/comment/37634b9b_6d626d52?usp=3Demail">Patch Set #6, Line 219=
:</a> <code style=3D"font-family:monospace,monospace">        return PRE_DE=
CRYPT_CREATE_SESSION_SKIP;</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">If I got this right, before we return=
ed FALSE for invalid/missing SID or wrong pid, and the calling code did not=
hing=2E Now we only log &quot;ret&quot; and return PRE_DECRYPT_CREATE_SESSI=
ON_SKIP, which makes calling code create multi_instance and call session_sk=
ip_to_pre_start() with attacker-supplied session-id=2E </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">What about</p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
return ret ? PRE_DECRYPT_CREATE_SESSION_SKIP : PRE_DECRYPT_NO_ACTION;</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/90=
3eb032_918042cd?usp=3Demail">Patch Set #6, Line 249:</a> <code style=3D"fon=
t-family:monospace,monospace">        return NULL;</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">here we leak =
gc</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/co=
mment/234941b8_caa0d072?usp=3Demail">Patch Set #6, Line 280:</a> <code styl=
e=3D"font-family:monospace,monospace">                    mi-&gt;context=2E=
c2=2Etls_multi-&gt;n_sessions++;</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">previously we only incremented =
sessions when we skipped to pre_start and now we do it for CREATE_SESSION a=
s well, is this intended?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">change 1826=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iccdd=
4cfad090c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1826 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 12:48:2=
8 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9KwwPyaun5U=--


--===============4691784331109490157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4691784331109490157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4691784331109490157==--

