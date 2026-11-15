Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133E606A336
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l7MPkz1l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jBO8yQHM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hqsk5ag1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hPBU7vOA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lhfewUwCvN6GGd38HZh59mrsDS4ngFlVBQ0NWONb6BM=; b=l7MPkz1lzOONMWU7gUL9lFmfVX
	e9Pgi03yThd/NOKbb0BSXwSMO4otfR7hFsCl7EARyY1dGQdBnyW3FAaG9vUlEyca95rgS27u5Paul
	Gy20Atr/vLDv6y8jZPPCyzlBuRuMDnjToRZ2CuBy+CraAiXWsws6bZSqNo9NWSqwxjEM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSR9A-000000000iR-0z2W;
	Sun, 15 Nov 2026 03:43:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSR98-000000000iK-3KMm
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 03:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98XwxTHPPVqfSp9V3LU+zaH/CDGIWKOONGIwYugYjm8=; b=jBO8yQHMr6Y5WykfVs0MhbD9Ip
 KNSGddRds8e41gj35tg57nhxejGvN1gWeYJzi8KHiKRAu6228fQoglPzmTCFEd+yuF2L35dlTBFJm
 //oeiiT+7W51NAZtNZj5qKwfNUYSvnXY3iME8NYK9q4eEgsk+WSYLX5nu4ptgr45C9ig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98XwxTHPPVqfSp9V3LU+zaH/CDGIWKOONGIwYugYjm8=; b=Hqsk5ag12qn9R/kUCnoie1balT
 Po10WJHNhmSqBZVIE6lDCIPVD52vEsQGlTefiO5Gg8D5pXe2IpX5V5W6H0o/wofoJz0Wl7pNdQzDH
 +57GStHQOuo5nGOojhK+QieLnbtewUCcIcSMUBRGBWI94R9ISw6yiM3YoExBMwpiZ4Yk=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSR98-000000003NV-0yKK for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 03:43:14 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so2645903f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 19:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794714188; x=1795318988; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=98XwxTHPPVqfSp9V3LU+zaH/CDGIWKOONGIwYugYjm8=;
 b=hPBU7vOAdyUyzQi9mwpIBmNc9ZDe03NagxzRwmG4r8bncj/1cPnl7xA4Q73vSxyRUB
 6ltUwVG6p7F3FA8q/haO/i/KXftC5bAAc/mIBYt5SQLSHaf7HtHllTUqf/qURpst9hCy
 Mb2Z+uI2fzUSMYYLe9jVlEeKOAtDbouPbQwRygN54J7a0G8vzDw4wZvvAHkctTWns71W
 W3WF/ofaDsK9vG20E9McFmRBRCKbBlCYTmiv+zZiz8xPfjiBdzePzt33Qfpz/zNiP5BJ
 ys0ZEaXjTJ+T92o/hcMfAfapTRzkMfHe8IVRZbKzQp0oUzcaX1B3uAK35eQ9E9XMQEre
 JgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794714188; x=1795318988;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=98XwxTHPPVqfSp9V3LU+zaH/CDGIWKOONGIwYugYjm8=;
 b=Xclzm8fEZvGy/9rdU+1XMclAvJHuGW9E+cQhCtlA2cTPGpI9JGfPjb/fQQx3q8qVDJ
 4aV8+szoNBnAD/IeiTP9vXJjN+5e97aVGu9zsl2I/Y97T3Ju6pIrndWd1ps4vUOPsJB9
 ZqFHVUc04KHOQEF2XdsfYQ3cRoICpYHM3SFPO+ZEwALICs4Xqz5ODo0It/P7pdlnwx7v
 eluBEdMJcXMIHhIoBmneUZcPoCBgwczWX3N8zLrAjpNvrc4dqSd7YOk3Eb40ED4RYQGU
 p5baKPNQHOLUULurVy1GWS2vp08C9gzJiDmomNvKoV/HzGvos8h+LILrixPiediwDKEh
 Lf3w==
X-Forwarded-Encrypted: i=1;
 AL+hErE5ePLOQNjgBTyWOuTEjaYxP4Inxr4Ud41FLPfW/tFJYnLAWP3m6zC2wLNmkfbX/KBdffn7mRXJVLIJ/WxJ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/czZeCQTuoBxkTUNaXoMm3ocRF9uAk/4S5NJshV2ppZQeQ7k7G
 T5PYyj+SHXX5Aps7Ri5V5PWSumFIbluYArfK8OTnTolK/OaiA8/vvWaDCiRScblO5a9FXMEQSV0
 lBwW5UvY5N8tekADpJuaiOu2uW0Q3YQvYTaixJbcAqdRsZTakH8Re46ScdGMDE3B0OAiL
X-Gm-Gg: AYBFou1baKlVVktJwecKxlV8hLs3ilL8wG1YbAc1vrihnsQ0DIwH7XoBHm8IHrV+Pkc
 DzgoQmLJ2dgLOhj2q+rIvQRwotxzhMxmSFgHNSCwKCImYwl7fO5ZYHwF73My3oGE/7AXWzxu/Li
 tWjKs6x9Vd9Ks/aOQwu5c7tBq8aOsThqvYyW3VXMB0YyW2H4jPxexqL18dzfTTFkPaRv9ABnLnl
 0uC0dcniY8fTC4j6L3K0huVKecMyOWoBrvVmch/wumEaxFGZvwRDdxyQn89pootIalqgPrNnONX
 +C59F0FU+PFXictE0IXG4vCnUv8Kv8TT2afYz4jUd2p5x0mucv7wpNBkxa7sCeaZYjBW8NAmZvE
 OLL/NRi9HlWxmDhczfbuUNw6vlU21tjfys6FRwuaEG4yxoCaHcDO8IzurpfWA1lfTvQt8uV2pzQ
 OP0YBUJ/vnkloSokHxY2ejVG0ARRRM54+tpkJxxHKrLHt7QhJJe9nWqs0agyVn0bLWMkM+KeYX1
 dhUpj+sCPXua0/5jigRAL6lK6LsXx//hSUmduxP6PNjbT2lWWWafjf/mvHyZk+sANhc7hxJEyJI
 0JmQ/3Me9F7VIUeMlSzBHeyVaumLjs+kfYsXUCI4rl1F07ocd+ebInHfeiRmAmfuq9WZjq0yxlf
 +xm9tBhCKTfAqt4e/aVgJET3T8X7IKhKt3BskdXSJ0ruSH1Ubxl4KgFxR2BnU3CIQgSGi+n0KxJ
 7oRukEucPTxy+0kIY=
X-Received: by 2002:a5d:5d0a:0:b0:491:6b1b:7f25 with SMTP id
 ffacd0b85a97d-49c72e85578mr15405417f8f.45.1794714187516; 
 Sat, 14 Nov 2026 19:43:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6020bb0fsm13429713f8f.34.2026.11.14.19.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 19:43:06 -0800 (PST)
X-Google-Original-From: "Alejandro (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 03:43:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: f76f976134a1bb257fda97ccde77d6c06ce1b612
X-Gerrit-Comment-Date: Sun, 15 Nov 2026 03:43:05 +0000
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <61ac1c33407016e8aee47a8ab2221074b03ba4b4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.3 (++)
X-Headers-End: 1xSR98-000000003NV-0yKK
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alejandro \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: alepacheco99@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Alejandro \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4730955492405693330=="
X-Spam-Status: No, score=0.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4730955492405693330==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DL6U1uaa0MA="; charset=UTF-8

--DL6U1uaa0MA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

A=
lejandro has posted comments on this change by Alejandro=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail )

Change subject: Keep the =
outgoing control packet in a buffer owned by tls_multi
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

Patch Set 2: reb=
ased onto current master=2E It conflicted with "tls: reject incoming reneg =
request if primary key is not fully valid" in tls_pre_decrypt(): that check=
 is kept as it is, now followed by the one-argument key_state_soft_reset()=
=2E The new lines that -Wsign-conversion flags now convert explicitly=2E It=
 builds with gcc and clang with -Werror, and the unit tests, t_lpback=2Esh =
and t_cltsrv=2Esh pass=2E Arne, Antonio, would one of you have time to revi=
ew it? Thanks!


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2002?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I37=
9c36e1557178d22d3ee27cd6ed51b5c3a2e793
Gerrit-Change-Number: 2002
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: Alejandro <alepacheco99@gmail=2Ecom>
Gerrit-Reviewe=
r: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Sun, 15 Nov 2026 03:43:05 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: No

--DL6U1uaa0MA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Alejandro =
has posted comments on this change by Alejandro=2E</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Patch Set 2: rebased=
 onto current master=2E It conflicted with &quot;tls: reject incoming reneg=
 request if primary key is not fully valid&quot; in tls_pre_decrypt(): that=
 check is kept as it is, now followed by the one-argument key_state_soft_re=
set()=2E The new lines that -Wsign-conversion flags now convert explicitly=
=2E It builds with gcc and clang with -Werror, and the unit tests, t_lpback=
=2Esh and t_cltsrv=2Esh pass=2E Arne, Antonio, would one of you have time t=
o review it? Thanks!</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2002?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; p=
adding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2002?usp=3Demail">change 2002</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3=
a2e793 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2002 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Alejandro &lt;alepacheco99@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartul=
li &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Sun, 15 Nov 2026 03:43:05 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--DL6U1uaa0MA=--


--===============4730955492405693330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4730955492405693330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4730955492405693330==--

