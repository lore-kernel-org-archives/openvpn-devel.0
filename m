Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18EBC531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g3CiigR2wILr7pYvyux0nSJvqoCgx9jyf1k+kaRgPvk=; b=VW41zifC6jCI774dnPKCHsIge2
	jj/JMsce6+D9S/OE+hs/R3O+p9MoIV09iANiCgfbVuqPH8aNPgesBqYugiQZzPRt3Vx57WGbNr0U2
	Liotei4IeAMQm9opZLOco0OT3k/U9/Mg36YuIE2xzKq5ZwJseDHiJ4iVfTk+K62yIfUs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIip-0007u9-K7;
	Fri, 24 Jul 2026 16:26:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIio-0007u3-33
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:26:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CODWozgHIJiXXFxn437cQRV/bTTHyT5MT3WktJd6diw=; b=gxwnwMk7mkuOEZ1E4k4gS9wq1Q
 t/EJlc73j/LpYMTQV2Ff//1VHj8uFrr/hEwaAAThT6896PHBrQQO7twlxwjS3DOlZT1cPCj00s6C8
 ohVjPSvISCztKy6q2tsL0rAt7M+SflIhGtzyLRNYj5cSlablN8zWg/cXVXoLqd9svs/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CODWozgHIJiXXFxn437cQRV/bTTHyT5MT3WktJd6diw=; b=B
 ZW3R5/DZvPlNzCkaV24uyZNr0ec5LVl90u7EoeZhg1QwI7vlICNeGRYB3OXEPQeq9WCtUNvoWDQ1T
 gwnBsKljOdJi1tv/PFPkG6QF+Df0cZ7TgKvMd5hRWOVKON16yP22p412SzeoDzUwkwRkWS3fijPlF
 mTZ1RbfZDg2KAb6o=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIin-0001pv-C8 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:26:02 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so579140f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784910355; x=1785515155; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CODWozgHIJiXXFxn437cQRV/bTTHyT5MT3WktJd6diw=;
 b=Dmgn3HWF37mKGpdeWhphOOlD+AUXVmgwzv/Xs0PL3MRqI7tNpSqtWDStvT0vfFOamr
 +aXp+y4hBmnFCGpU/mRJghLUDzgL6c/m37fQPKsrr7ajbzQwX6IZUR18oFbOqpdjJMb8
 XtdRaUqsJLwv0fkrXLoXBip8TEqiGnYL6XUgKZSs6N1OwgzeZtCo6k29LBGLIDiaF1gR
 mKtcn84HiXXIB3QQFLTfq2xaXybDUU2tJkB6Jwgh04lek6q9LMacnqIRzQ0NJ1Qia8zg
 psmjPH3MLWZ4ieMnL3IsI2RwHsPrqDduGHTlMe7ellWbdqc9lfK8G3nnMdm3cPq6Zhe/
 A8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784910355; x=1785515155;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CODWozgHIJiXXFxn437cQRV/bTTHyT5MT3WktJd6diw=;
 b=bg0K+eC8WiXxG80WLDHjQ3Ejn//IBLjHVNE9R9hxhtH8FufqV4y4cd1cbsSG+K/+oJ
 BII6dfgU5JdeRLPZpNSmnihTrnn4ocX/Bb8qhjQTqR6/2K+qXDXc43NEUWL78RU5zo6X
 Jdv41cOYwsTCeFEN2Xn59cxU/MC77guzNZ043V5eYCJmgZdaVrAujpO4g30LCz34w05Z
 XpcWcDxxMq1neEwKzFc5isOqTcwhmuHA3UjMjb2emhnAsdeyvjZX4QOqHLNFCCE27tCd
 g/QUwUQ2iEgbWwU9YNIpxReF8QHQofdpDrtuM8tZw18MPoLdArJfuJbxCPEGlS2WHxXZ
 oC7g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1Awwb5shEXJirvDWBsVojyvzHA4B1hxauP9HhhNSdiV2UOHTmXVwV6RZNOI+WJsiFCNbKBw3Ht7aa1FwR@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzYrHQqA8IPG9iprLnPB3tIoTaBP7XieLQf0UCUnCUocEyj0XZ8
 0BqeTJL7mzZjNkHBzyJ4UNBMlRP+jlCuCe9A/KoG87NWUkoS3bdLpZ69TRmLIF71yD4ukn46+Wd
 28Om0mIKJsc4ah9RBzePU2TAWESejQKYVmHGwMG5V+QODVBmp5lfTLG80BjBudMtzt7DfGhRrZJ
 bCSXxtbg==
X-Gm-Gg: AR+sD11SxSG6IaLaO68lfXusS8R8L1P9yqevD+GInC8QXa/h065LiHkcRSQ1m0vkZau
 m2BXt+WOq32H2HUF83xFpCwE3+pteG0iHxVu49b4g51A8VtaASSIlklXNPHbtRe0+bJ6ABk86FD
 KwpoX5x1ht4WqDFh9F7lrW3eoeUazA6H5IGDNfMHxsvTkKw6J+uVnVykCU7GX59YiML+ydxsdFc
 PUKHfl8uUtMfEVq5I7sDx5RS5CtBcEA0Uex5NnKhh4ZjPhQdjj0vgAiWQabX/SvM31mgqGRD7aU
 QOmv/8ZteHo+or+RPjsV5JEVMa+lA49U8QEs+gyabIa0NDU0LvHbuhgioAIeTa8WdZCDtdzQCpg
 GI/cMPuVml7TufITTPq8z3usQsLJO2KV9B9bNkYt4pY8bwg0jBaAQDAto9V2yjV15mqA7G5f8ej
 IPW4l/2hKwAUVEeh61OMcAmtF4cLtc5wxoFS5pYh1imObBGRS50m/Kyr5gtRLNxRWoLMp3uUch7
 EpOrKWNgoLxaCa2JrPXgRYA2eG29yDa73xLUbZxlJzDura/lNsizLysaMFd1Dvlovd0
X-Received: by 2002:a05:6000:2585:b0:47f:941a:796d with SMTP id
 ffacd0b85a97d-47f941a7d14mr7281523f8f.12.1784910354518; 
 Fri, 24 Jul 2026 09:25:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm25000507f8f.30.2026.07.24.09.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:25:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:25:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517
X-Gerrit-Change-Number: 1731
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1731?usp=email>
X-Gerrit-Commit: b66d266e2ce556b3364769361586ccac0f66afe5
In-Reply-To: <gerrit.1782390484000.I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517@gerrit.openvpn.net>
References: <gerrit.1782390484000.I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMzkwNDg0MDAwLkk5NmQzNjk4NjAxYmI1YWFjM2EwZDdhYzZhYzViNWRkMjNjOTc1NTE3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a61b8db3d49bb9de07bbc34f1acbe9e5089c4cb7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIin-0001pv-C8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Silence warning
 with gcc 15 and O0/01
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1917673391816245642=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1917673391816245642==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aqGHW4gfJNY="; charset=UTF-8

--aqGHW4gfJNY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1731?usp=3Demail )

Change subject: Silence warning with gcc 15 and O0/=
01
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Silence wa=
rning with gcc 15 and O0/01

When compiling with low optimisation level gcc=
 complains

   route=2Ec:1783:44: error: conversion from =E2=80=98int=E2=80=
=99 to =E2=80=98uint8_t=E2=80=99 {aka =E2=80=98unsigned char=E2=80=99} may =
change value [-Werror=3Dconversion]
    1783 |             r6->network=2Es6=
_addr[byte--] &=3D (0xff << bits_to_clear);

With higher it apparently dete=
cts that this is cannot be and does not
trigger the warning=2E Explicitly c=
ast to uint8_t to silence this warning

Change-Id: I96d3698601bb5aac3a0d7ac=
6ac5b5dd23c975517
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1731
Message-Id: <20260723180445=2E17392-1-gert@g=
reenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg37816=2Ehtml
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
---
M src/openvpn/route=2Ec
1 file changed, 1 insertion(+)=
, 1 deletion(-)




diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec
index 81ce867=2E=2E8ea745d 100644
--- a/src/openvpn/route=2Ec
+++ b/sr=
c/openvpn/route=2Ec
@@ -1780,7 +1780,7 @@
         }
         else
        =
 {
-            r6->network=2Es6_addr[byte--] &=3D (0xff << bits_to_clear);=

+            r6->network=2Es6_addr[byte--] &=3D (uint8_t)(0xff << bits_to_=
clear);
             bits_to_clear =3D 0;
         }
     }

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c97=
5517
Gerrit-Change-Number: 1731
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--aqGHW4gfJNY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1731?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Silence warning with gcc 15 and O0/01<br><=
br>When compiling with low optimisation level gcc complains<br><br>   route=
=2Ec:1783:44: error: conversion from =E2=80=98int=E2=80=99 to =E2=80=98uint=
8_t=E2=80=99 {aka =E2=80=98unsigned char=E2=80=99} may change value [-Werro=
r=3Dconversion]<br>    1783 |             r6-&gt;network=2Es6_addr[byte--] =
&amp;=3D (0xff &lt;&lt; bits_to_clear);<br><br>With higher it apparently de=
tects that this is cannot be and does not<br>trigger the warning=2E Explici=
tly cast to uint8_t to silence this warning<br><br>Change-Id: I96d3698601bb=
5aac3a0d7ac6ac5b5dd23c975517<br>Signed-off-by: Arne Schwabe &lt;arne@rfc254=
9=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1731<br>Message-I=
d: &lt;20260723180445=2E17392-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37816=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/route=2Ec<br>1 file changed, 1 insertion(+), 1 deletion=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec</span><br><span>index 81ce867=2E=2E8ea745d 100644</span><br><span>--- =
a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><=
br><span>@@ -1780,7 +1780,7 @@</span><br><span>         }</span><br><span> =
        else</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            r6-&gt;network=2Es6_addr[byte--] &amp;=3D (0x=
ff &lt;&lt; bits_to_clear);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            r6-&gt;network=2Es6_addr[byte--] &amp;=3D (uint8_t)(0xf=
f &lt;&lt; bits_to_clear);</span><br><span>             bits_to_clear =3D 0=
;</span><br><span>         }</span><br><span>     }</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1731?usp=3Demail">change 1731</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1731?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1731 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--aqGHW4gfJNY=--


--===============1917673391816245642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1917673391816245642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1917673391816245642==--

