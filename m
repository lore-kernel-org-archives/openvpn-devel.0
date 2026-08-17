Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEC0C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mh7f9pBd8SBRdXty+nvy3A3fjL3CtO/B4Z5ZIQQqnzk=; b=YjLt4yS+5cB7xqqYbvlcSijoks
	EeX2wvEsZ+aaPLONDBL/toW/Uhm+j0w6zVTIchwhdBYyBnxi/hI3CdbKuVidU7DaeS8pMCjrZXrlw
	NVMJXprUhSNpxqeDsVOgd8P9b6vH6myIWh6Df/zfKlljo6HrbyS1AsS9NAN9NetOTVPk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww24v-00019r-4N;
	Mon, 17 Aug 2026 18:28:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ww24u-00019l-Q1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 18:28:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1pAeES4I7Kc0Vxbed90fylEtqu/R9+kYLhmD5aiIJMk=; b=Y9fpXe2Nvb+CI+FcmwmOxPUOeA
 n5lmjb/rF9SHlIbjOGHOTpudd25T2jgD0ydpjqH7ImqhB+vX3IBkjdLq22rhoAoAeHMzSuo4yDrnr
 DgvFZqg5TuBJ+sS3NMX3jG1NIDvh/l0NTNtIvwCKutqIWvBZmS+LlcSUu+qqpJFwHoqA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1pAeES4I7Kc0Vxbed90fylEtqu/R9+kYLhmD5aiIJMk=; b=g
 3pluwejZSlBXgc2LP0aj7yN2Fzq5ID8hdKaIfWv2yd9OEWGVWVJHBgR9aiYj0uhjGJegJbgo2YDM7
 DOXyX7edupUg3g0JnL7be7gWCoEzrUPqhIs7uy6hfY3SLAySnPUrCcEUW2FwJOJyeT96/78/7TswJ
 k0RmRFyUN5TWTTdY=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww24w-0004g0-Iz for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 18:28:56 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-472326ca506so2625945f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786991328; x=1787596128; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1pAeES4I7Kc0Vxbed90fylEtqu/R9+kYLhmD5aiIJMk=;
 b=KydC4j4OhL3D6oirUzI0sF1eDdtqc2ziImZ2Eo16KrDl4pWImdik188u0M47wmrUZF
 7HZkR2Ei5c2WLxDW19jP/50fiAi7IeBSVXNP6ESA+s8/u84mA90F3o4pCKa4m1W6tHn3
 Y8n80zNDET1/k2x5sAxhG/updCimc/RBQ5sJJQ92pmHVZiOHPfcINyjS8ZemyRPkI7UK
 G5u7x1k5cIA/5j1CbHON+SGdOqVaFQ5zuHTMql5q1URXEA03ov66dlcj1zs2Ttc6m2Y3
 q1DLFwwfGRo5olszq/s9oEVMZhBKdKfHv2SUM0UeWoc0vS1niEfY3J77pSy3qBLAmOc9
 D8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786991328; x=1787596128;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1pAeES4I7Kc0Vxbed90fylEtqu/R9+kYLhmD5aiIJMk=;
 b=jeNrWnY/H4cs1HxkUrIctbqUGy+jZbqmgBgoaYR/FSz4luOPTSdeVfKJiGO3BSNsQK
 vQxsGPfP4NOOxqX2pkvJ+GsmiLfaQsfgk2wWlQ3oIkOhGBxvByNM136Crcm4HdsBpqIR
 0XQ8+QwgsaP3tY15Ko7s1tkXGxupD0S0pLzqvZygFXtZCVhVanD17LkqK3JxnpOQBXUv
 gXSTCdk5SD6fUoU/GA6ibMh4NkSUiRq64bpsTtm6NKx8I8kTijOWrerNaZUrlKT4eDbU
 aGy6HBEuXR8mfIJ827uP7YfQ+Rf+pq7QQTmDCrvRFrFdNw3yE1uWJ/HEvpyuI4Zj9M/z
 glag==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKTDdeiU25F6uoW11GuvbttZyZoxuRdl0G11xwNNCtBgqu7ICtWAZhD3nYHVzg8KMDbpRL6sbO3PhQcSiF@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxfavhXRdYdm6OplvQImtCV2Etpm/D456e5t0icj/HM699LYezr
 86BbEvfzm60SwoRifNN70N4/Fu/7LRb7HMKrb8ex0M9wFmL2EswgskkkSghYzWapr+V4Q1To+tY
 aGwEVcFGXIiz18IA8Z2KbUaRap/nhYVOnqwnPL24i4t1vB+3fXP+f0SQeFSEdl/iCCHpItJRQQl
 DsK0KF/A==
X-Gm-Gg: AR+sD12FJqQkUxngpNdocWNYSzqFRgvaU5NyEQ96kxwRiFSabDH5sNDLJ2HAyi/VV5u
 m8FkZigs+oeH8gIsXyBRiygZvxmH4iAZxFt4GNLQxw7naWNyQjDAOQzM+7eHchRrdbOBVV8qk8m
 7ZMhTLWqxAsG/ipqIsyVnNjG9+dO+Dz1YsM0M0gLlBCT19P+nvWaqrlg5N6A+wk6XtdxFwxVofA
 n4CrsSBpSZPsGY99mlFDMU7JcuW2G/q7VewWofm+0vZ9Q0OGgyF2fijRNDMbius1MYfgyrZRZ+Z
 PHyDSdeINjVdxDxiTqTgjlxvtLB4daUGAaGEGbfW51VFeoPx71t+i6VVDReBEkM2dKqo6+RC/9/
 0wTcoO2Gm+M3Vd4IszJtfjkHkUEagFOGw4ERu35L/SNwWMiNrjxfGi4SVx0cfyBVAxB2x8nJ28u
 n4rEKKkaCDWOqqIYI3rieO/nQEic80mXCSZ5oPkS/CjONB6BVvBIT+OFGBR4qPwR9PInNeoz4oq
 m5WXJ7jMkYTOYx1x0Q7GWcbkMM9gGsB7ihs9LkcN4eENV0w4EyeHIP/JL9/pLJ8J3c14oip7BJB
 WgyJpdVLtmopyAozFRpgEfzJvmCf3saV9iYuKIE2mftEdv73ysOaWKKeiuxDZg==
X-Received: by 2002:a05:6000:144c:b0:47f:96e6:70a with SMTP id
 ffacd0b85a97d-482a8f86438mr4209332f8f.0.1786991328439; 
 Mon, 17 Aug 2026 11:28:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482aa084a64sm703018f8f.17.2026.08.17.11.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:28:48 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 18:28:46 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: 0d0de000525c3d103c6eae574e74cff21402e107
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 18:28:46 +0000
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d11bb516d7fdcc80c89d108d4393eb2a0f8e49f4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ww24w-0004g0-Iz
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 options_string code from options.c
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8510265628542555464=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8510265628542555464==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EJzW1fZ2uW0="; charset=UTF-8

--EJzW1fZ2uW0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1773?usp=3Demail )

Change subject: options: Factor o=
ut options_string code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(2 comments)

File src/openvpn/=
options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773/comment/1e0307=
44_23dbf499?usp=3Demail :
PS4, Line 3739:  */
Should such Doxygen go to the=
 header instead?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773/comment/e=
0501fb3_9668768f?usp=3Demail :
PS4, Line 3932:  */
I _think_ the newline be=
tween this and the function below orphans the comment=2E



-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a24=
3d85
Gerrit-Change-Number: 1773
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Mon, 17 Aug 2026 18:28:46 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No

--EJzW1fZ2uW0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1773/comment/1e030744_23dbf499?usp=3Demail">Patch Set #4, Line 3739=
:</a> <code style=3D"font-family:monospace,monospace"> */</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Should=
 such Doxygen go to the header instead?</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1773/comment/e0501fb3_9668768f?usp=3Demail">P=
atch Set #4, Line 3932:</a> <code style=3D"font-family:monospace,monospace"=
> */</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">I _think_ the newline between this and the function below o=
rphans the comment=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">change 1773</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6824058f=
c9c4efd48ceeb32d4164f97b2a243d85 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1773 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 18:28:46 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--EJzW1fZ2uW0=--


--===============8510265628542555464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8510265628542555464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8510265628542555464==--

