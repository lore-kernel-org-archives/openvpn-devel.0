Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C06C54FDF
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CD1pet3BaaIHMxC96Je+CTZfGbkNIgyLNIM0dvF7Lxc=; b=McAzgGKdUP1/suq9+IpsllJ84N
	N4iaoHnE/2qHnEZW/U+Fbh0vu9hknMgmwKw/5j/lEzZgRsmYBUS3xJ0LAT2eBpGcOu2owUQZIp1/u
	b1j2HI7fEb+lYdESnJOQzB7XENau0ydRmD8eqK3+QKuK7YjdmF/xhcxIuerKwtHoMD+8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpN4N-0003r1-Ex;
	Thu, 30 Jul 2026 09:28:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpN4M-0003qv-J7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 09:28:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Pb6KeQpsc7d8CrjLr5VVdbEr/PlLxfG2OGup+YtlblQ=; b=gv7OCj+D/PSXbhagDjhBms1DPu
 BosyubAxuBmIQYhGYUnUJrurI4CkhKxox7gi2x3/G6l9qRblJhAuNliGwzdUOn6YGDHcdk+imectm
 XiPFj5nkvntjle717ew/YhnrwI6eH3o6n7BYm4Z9NL6uxh4A/IKhCfMkFLrfx0Sjc2Oo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Pb6KeQpsc7d8CrjLr5VVdbEr/PlLxfG2OGup+YtlblQ=; b=b
 hkooOlOHiFqpP8d5Cbr2T6ZbHcRWnPwf14ukCJDnDCSZmmPojLv17mLGvzj1OQ+qKl1ij2tl/+0eQ
 X4iAFtuZEQFkCmGx9OcbvEpoyNr9Wdvy/0I+nql/rDofS0gwjij20sER/jFH9rRbP0SKBUk0tpPso
 B2h1omTec5Tz7jDQ=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpN4M-0002dB-8I for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 09:28:48 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so8584495e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785403720; x=1786008520; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Pb6KeQpsc7d8CrjLr5VVdbEr/PlLxfG2OGup+YtlblQ=;
 b=b5lfbkNzLPiiOvOvp4RBPeR55vK974AO4EClPHLQ/ifV/ggK13eQHmcIUBkahkM9wo
 7y2Ol7D8yKardTfPPge76S2UM11gYL/JRuYDBT6F0j6nSUUF+PY4WYxP1kLFa9ZTmgPA
 r4yqlY0eymXVu41rSqmPWFmu5Z3OBJ10eLsYaNtFoFRqY3+LDMRWuMrDALEZ0PJAA6Lt
 B+h6yGenyACA/Fw7J5lfxXzYh/3xWys9/DK+TPc8smI7rK4az/PQb1KpYu3qsDDPdHe2
 YcjPSPTkyhvIH0hueIY6sImxMAm8AKQoD98UkHWsSl0aFKSrwAEE7gU3QC/11WZREwhr
 ETdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785403720; x=1786008520;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Pb6KeQpsc7d8CrjLr5VVdbEr/PlLxfG2OGup+YtlblQ=;
 b=H0hnkOvK3MXiuRIlkVebKEzptJUdx8/9eMqar/CDzgc7Bs3VswARX78rnPtecsmaxE
 ue37Ukp16EFyfRO2HNPCE6AM2O5ltDJdLKs3nGZ4P9751/AryUMDNODSN0BQYu2zTYEj
 9F5uLpcfwN7S3w5pQOH6W5BbzeKoT+d6omznIbAq435qEPVKAddUAe2rivIEe9P6noCl
 qDsqS5zYgAE5VSYd1pkDe5XAOY1i9ANQci97XgkU3+gLIcJKR1H+8Hcujmv5yh693quE
 jWlbLMrSxK5Onxa+P4ajt57xCNnIpGJ8fIelfe7z1rxAoBGpYz1cWFa7Vg3jE9Z55z0O
 WDWA==
X-Gm-Message-State: AOJu0Yy7cg146nNJJ2RcG7JS7U28vtwrTx+QZ9iHRqMVKDLL9gLOA1Jy
 s2ixGUN81Sg1DbcjmF1yK1egC0lEsAb5mnqBKj3KW26LLFiBSvAs7i9pwLq8eZN2o74vmbVFhhX
 z04cbsUfLt9hpS3SXa8LlYxYg4UwDAn2MjfSsMOz2LlhbOHydAbsxNo7B+kxdHvq2PUD0
X-Gm-Gg: AR+sD11hy1td5V1dbiLaCODPZOQnRKGBttNGkEqM7YYozMSctQQCsHzfOd046rkpeX/
 NTMkh49leU1LtXuXVBHV+hEfb35wXcNwNT+ybBJhjE7xE37VpNR40hAzEmgYbZhotzR5QTYb5MD
 FcGGVt2PMkph5NXHOePc3lzcukfjDtLLQghI414fBea4Ete+9bQpw5nHEt7vrludgipVJBYA10L
 LmSghnOENVFDnSL2j1ycNvAvUUxIJRmTHgFdAZFDqudJemkUMiTB/M9DNitHLYLQfMTfXNiGowB
 vi09xnXuz0U85lstGTqW1iaHXC3D/HPjxgwVo2Tgs4kiy033a81G8JR0L+g4epr/WvrPHpTNDuM
 qxSMYKHn2csG/vCYMrQTO+1opyWc8rZWSQdU71Hngbt8Gx06S9Z9/44OT+DlcYqTYXA/tUgl7ta
 PV9Mg2B3uY00qs/hjsWU6ESP87ik5umordhhc56cARC/7WU8yc4/Sf8Kudb93Y0xRGXlwwyXXXc
 VhOP8htFiYkgLyMfnVpB3mGumA0mr7wpjoTbEADjUAT2or64UXM5A/fnjTyCQ3Ofsg8GGV3Ta8K
 NzcHtORSgAiCIx5MFNrgYrM4wuNWhzs7cvAXw9eQaEt/CI9VE8chsxEnK/0HhFw=
X-Received: by 2002:a05:600c:3509:b0:495:5858:8101 with SMTP id
 5b1f17b1804b1-49800e776c7mr23061065e9.15.1785403720048; 
 Thu, 30 Jul 2026 02:28:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011f2b45sm43354055e9.4.2026.07.30.02.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:28:39 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 09:28:38 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 124613f88855cf4b97c403de5d5ca145d5cd44f5
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 09:28:38 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c0d6c2283e109295c6e3dfc6530aadf57bbe736-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpN4M-0002dB-8I
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 be a fixed sized array
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3622847466081035770=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3622847466081035770==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HzYvIYcmAGg="; charset=UTF-8

--HzYvIYcmAGg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a be a fixe=
d sized array
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 20: Code-Review+2

(2 comments)

File src/openvpn/list=2Ec:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/8f17200a_f4d143cb?usp=
=3Demail :
PS19, Line 425: hash_func_new_ctx(void)
> forgot to remove?
Done=



File src/openvpn/multi=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
571/comment/ee868554_f789ca22?usp=3Demail :
PS19, Line 313:      * value an=
d function for the context parameters=2E
> comment is obsolete
Done



-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fc=
de821899839324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 20
Gerrit-Owner=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Thu, 30 Jul 2026 09:28:38 +0000
Gerrit-HasComments: Yes
Ge=
rrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=
=2Ecom>

--HzYvIYcmAGg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 20:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>2 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/list=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571=
/comment/8f17200a_f4d143cb?usp=3Demail">Patch Set #19, Line 425:</a> <code =
style=3D"font-family:monospace,monospace">hash_func_new_ctx(void)</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">forgot to remove?</blockquote></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1571/comment/ee868554_f789ca22?usp=3Demail">Patch Set #1=
9, Line 313:</a> <code style=3D"font-family:monospace,monospace">     * val=
ue and function for the context parameters=2E</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">comment=
 is obsolete</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">cha=
nge 1571</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: If47c7d920b2fa4047b7db03fcde821899839324d </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1571 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Thu, 30 Jul 2026 09:28:38 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html=
>
--HzYvIYcmAGg=--


--===============3622847466081035770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3622847466081035770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3622847466081035770==--

