Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178F0C5DF70
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F+acpinToacycZcxTUnrpzks90LKTNDT1msAB68027M=; b=ki9hP8aGBuQkilXLmYavtC3bj4
	LwcNpU9WOakDX7yjGSdgDPkHcRuUbQ38jJR62q6xM94h4ONuMwVYgTEby1isk6F8wOdKs0CSHsKO+
	Do9ApO8K7DiyBTSGpK6quJjLLl0PwNU2ZxJklsmz6dvmNKvvuJYqLZz/ar9H/LHgV/hs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww2JT-0004Xx-Ff;
	Mon, 17 Aug 2026 18:44:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ww2JS-0004Xq-A1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 18:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kATsus73GP6PNty7qKi4Mzei7pmaL/uPAAdwCnyqTQ0=; b=SNRqmUxY5NUhDqD9/B9YvSy+Rc
 IYG2nNKqUlE/ASnwp7gfBesatDS1rMd8j7EOjYJJ5uaiPlQSQ4C1a155nFEqa7dX/YFKu8JgQoX40
 urZYL81JP9VNXFftSx6Ug9pVMQcMZTx1ovhsmDQ0irOrcJk9TzBF5iQwgp+mNWohX5Qw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kATsus73GP6PNty7qKi4Mzei7pmaL/uPAAdwCnyqTQ0=; b=j
 jVi//JjUZvV3aiEZ2o+2+USvCT4IuX39tCob6T8YaJWrnCdJMRbvx03VhwYUkqGgNlNRWdWv13Qzz
 xqNWL/grBr2yeYJU1hrBR+/g0hScmD+tO+Ht427h50Zl4h6bE4IxrdecbwzN6LuWhIESLOJbJChZK
 Hv1hgIR9zcFJqecg=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww2JQ-0000O7-E8 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 18:43:58 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso47963375e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786992230; x=1787597030; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kATsus73GP6PNty7qKi4Mzei7pmaL/uPAAdwCnyqTQ0=;
 b=NWsNlnKvBSg8Av/800ajMiyNj+58tVTDng9N5Mnnwk0LbWXt5iioY38gMw9j9u+FV7
 AF51Rd1Yp9KqTkxmrvA9KFqF+VXoEx0E/CG2ujDxd9D6ylwYq4BihCF3cpoAET+mYoCf
 hApTiXSpC88ZCyvLtMefrGmVlv4yXohsZLuH/6sMGzacErutHtc7PipqKawmvYE32Lnn
 NfOWbvQZfghUHqWZAJIRYdvZHOx44rR/nzBOBb7UaFNEj9nnZjyuHnLcNFhXTFSkEG5X
 UwsLoGyTfRfCIUDeKjNWI7Q9UohmiHlm5wwEsX62z6MENDQ4p9Z3hCO73gYNM9jevNjR
 KgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786992230; x=1787597030;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kATsus73GP6PNty7qKi4Mzei7pmaL/uPAAdwCnyqTQ0=;
 b=LDn1yzB8J01da5eL4qRg85OvoOlVaj2RaQYt0gTODswZRNKcv8cf4pIiHk0fUIlv2O
 6MIGbj+CldqPpgZLdjA391lGiT4uRg4oKdegJv0+DT3jHWyelJ7vVSriyJ26zWc6hDSk
 aKtSrKNxvYZzRgcMMH/LYmbDwfKyokdE2Er4PZ0a31r/HGrcTMRXdGm/ux+2Y4+ESls5
 Y/BUhnLz8MXOVB9uaZREMiEZ2tjpebuANOFcIpu8MQizFvgWz/MwfeUfGmzO12xB+GEZ
 O2rT88pPMn+kapHgeruWWd9rpYlKRPH/ifEaExBosQEcP+1YJLUtDFUBMbkLGppT5dkG
 3eGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqX3/gB4pIEjP2pUtvvxOt/YRSQQW5ll9AVMwEjASozcj6hWEDHNGtRBWN9GNOP/HSrJLz4kRbhdSYdxb5s@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwNbGq66wpA81gxCvZM13YCguz8uHiJByj1Lcr+8W/Q27G0BPtG
 sZgn78cctNsNxg8DW7XtHF9IaZV92RPDVM1QI5xlJFD1PQfdlUTPGgxUVWx/z5R1gaxqvhzTXCG
 L7oexGI7RXAuIqex7RII+EYDvlXPnYLpfIS0sVB7ZpyVQUW97A9t7JsqImDZIaIwil+73
X-Gm-Gg: AR+sD12g7Kn6PS/zVTla6FnhGf9ptWRZ5kOIKNVDt7a/9ZQvwJgQ7/w0aPjOTsX+dAT
 CbiFAcTPyh4hTUUvW+th1IP4gh7zPYEifdAVyo+yMSsWvu6RGYL4PsAu8Qrafyn8aQoVC/jc2nV
 1+f4rRZRqiZeFdE/uP3I3kdTjchlCUt/TibaKlV4Us5R6OgLdn3lOqLgIQASU2FZmbMvbmUQVE/
 DxCuusfTp7VyJqGBWmw0kFJgdJdFOIdH1ztXKO7inUCH0KRqb8rYD6Vn8/6l/PYb7J/lCMmQRAM
 bSruW0vv8pbDiOlYE9MhXgpkXtzlOIJLcC0sTnIyWuoKPKH/LUdHgdp1Vx4KCujoeP0bbOqG7kM
 Oqt18S9zmxKxEgekTU5Q9QUNExDvVaiYcrWCg8Drf8jNqzYy4E6XxGurQlqgbYAHYos5wOy6t1q
 xXxZXeFQ+h31wccllhJTE5rlJfm/RYJKA/VDScUzNcaQo5UXzCGRJxJetwBMqN9BlpDTkGKqiJu
 /E3Fy2v50XKpdwZe0gf3gXlPMU3s7y+lWU7HrbSZ5o4h7ouYMv7BoAl5BXD+7y+HoCd68E85NnM
 5mk/C0OLb3egM8R416zQTV3z0F6LCCUkGq6K3ZNF1nriReJWEt4=
X-Received: by 2002:a05:600c:4ed3:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4998d4feb4fmr327074605e9.13.1786992229858; 
 Mon, 17 Aug 2026 11:43:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610966dsm219937675e9.5.2026.08.17.11.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:43:49 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 18:43:48 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: 8535abbeca3e048d7a90af0e14bd5d812649fe86
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 18:43:48 +0000
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e57a53e6062d5cf9afbb1e3b404649091fdefab-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ww2JQ-0000O7-E8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
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
Content-Type: multipart/mixed; boundary="===============8890529223813866523=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8890529223813866523==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q62GCUkNlXE="; charset=UTF-8

--q62GCUkNlXE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1407?usp=3Demail )

Change subject: packet_id: Avoid =
conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 8: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1407?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Gerrit-Change-Num=
ber: 1407
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Comment-Date: Mon, 17 Aug 2026 18:43:48 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--q62GCUkNlXE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 8:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail">change 1407=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib058=
4e8728701cca10ac5675c9cb0e6f5eb901ac </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1407 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 18:=
43:48 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--q62GCUkNlXE=--


--===============8890529223813866523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8890529223813866523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8890529223813866523==--

