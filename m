Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A662DCD98F2
	for <openvpn-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxQ5rTbZzR8zjjhgH1dnyPNsE1JlWdum42cfrACHR80=; b=iN4EDBXf2Jfmhw1Yq5lnR2TjPx
	0P0gT6JwkKE276tCET57JOet3NJO/3baZrgapf8nfH1xoymNseRIFXzuvN5VGlKK15/99nIV1Hbo8
	eRC8IxJkD52AfNdEa6ne0mFJXitf5chYb3NZk08thDMzglKx+EOh8nijM0BDi1Hjgti4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZvPH-0000ZU-Mm;
	Wed, 17 Jun 2026 18:54:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZvP0-0000ZD-GT
 for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 18:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jJLecE0N6gSNisgucGEjqkREUDSTTXeK3DHKvIStfVM=; b=B9+NgR7DmN4yTGTlWE5KA19mdH
 ORio1lMss3AUbHNoiKEZByQ86bV/IgPyDGGcnFrNnv7B0Mm+eMLiukBTv5h2hPDj59JoER5rHGvQ4
 v6fEghOJkQWHmfaZNXXeYDfF1ZJZyJ57+5XRCTgJXdANfyHAhiQoXSTzo+i3aRC67UmI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jJLecE0N6gSNisgucGEjqkREUDSTTXeK3DHKvIStfVM=; b=c
 2MepEgnnxiR4+7kSdqeL1FsZzyFJQPwK6rpVYMaYxOyKqy0D/DMynbmSQH7yEOBolUb2Xr2ND/6TY
 /sB8/Zvj9fb3Of6tg/F/gznb0fiCZe0ySBTmdyWjYgez4gZHrUFioe+w9i26zjU/HH01+15M760YY
 cCm0ZvkukTldORXQ=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZvOw-0001VA-FK for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 18:54:15 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4619990ca5fso124269f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781722443; x=1782327243; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJLecE0N6gSNisgucGEjqkREUDSTTXeK3DHKvIStfVM=;
 b=I0LJ32zAPzF2i4YLE220GkK8u0IgB5vYcwB1MGfV6G2nVM6gf2q40IMYmjtDbiu5ea
 IHdGvQctV0lCuJB+CadV5A7F7PdvvcGYy64/KfHEz7Gq8Xib1Ru0m8SWmP8Rl1SekX8s
 5lrA3S8dDUJcOta+mypUItItwO8Y3FB/MhnL+iRG/A6yK4EV95Ji1WmaZZeXJF/3x5Rc
 boFcKby3iJ/t2mfgG81ZQUXVd4Jnl9rjfgnhBHCeEOgA9v0PvQc8rtlL+M4aoxIS1pp1
 G8RkFcS/WiVHUXvaOQETxyM2QA/uYNxu4U8sl5yRjeMmBot8yICs28OR5HG4gxrhei+G
 W4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781722443; x=1782327243;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jJLecE0N6gSNisgucGEjqkREUDSTTXeK3DHKvIStfVM=;
 b=rETSFJ8jV3JaYo4HQ/se7dBvz9QWEtAuOX6l4B8gxcTMTSN9Er5uaqunrvNWcIYFLw
 vfryTJJzmkG38OtkMyjmTXU2Ys1B2kxVmnFMYCxLfSQCadb+HavkFIwSv+hPF4Mraae2
 YBd4qY0j0CnHWlPVsoY0loBnmrgwCoSRAZ95sTiQEEjq0DBoyQkkjvZ8GdbWUWn2PzMN
 FcYQjGaVemWfYCz6KHpm3ThH53EEb9RKiFhIItnsZ1XxIOv151PIdqCCNHNLue5jWt7S
 hIbMF2U+8o/olN2KqiQbwQVcb99ycgoprNVz3Pzlx1LReBMIk6bj7hAEjQ+UMfxhh1EV
 bA+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xJuqQOuc/F0muT6vhJSjZM/BlELihGDPH7jdB7gnwSHK8tjW6jvH8ehfw0tDy+ybToH4HV6bcdcoBVuzH@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw+cHQhLy5bUE5Pxa4t1W/0g9cT+K1oszLYIu4gqurDflcOyFUZ
 TcFAhiOpLXq995QX2juxPZxv5D+FxK41OcQXSx74HJR7aRNsOcwj/ArqmyiqWtjuMXnmD0FFagb
 a77ngKL+5/QOvuFo69eAD1J89blD7eNelIMJ+S51uuWSC2zRIDazf0o2GQ/XYNLYcuz73
X-Gm-Gg: AfdE7ckXmX9I0xyQgfa7a1LEoD42ocuef83taVK5J10ZNoq66y3MrdAP8oRUicCDDyd
 Oso5QidwhquWvcbzKz41kINIjLN6RzydHLTQ1MNg031HgyAauJLPH9VzieJqdiZ7jH6MXWuBvq1
 M0/lTY00eged3P2rDPVAuj7e+n8QU9ZvXZ2Aev6acy6cKyq4slxb9diTZnzD4A6Lr3bgpAm/xNW
 kiefq0/rkAt3C8dMCmfV2ug8EzyWLARyEXOsIGIXaan9vuByyZH9PY+AfVmdKQAD7G0vfqxokyd
 LKCCKPg2rieP5od/unPL9dT4tDoC5f74UbqZR04aGgTrmcWAtUevTjsdD3PCr2hZFJFP6ssnuxU
 wJ479xIHEhVjc0LOBc4UrABfbKzHyC4P9qIaw8i89e7rKEONsSElx7JBoi8jDCnY9zJfPyzYAgA
 frH7tgpn/+cMrosGpVnOr54ux947bvqriIuRcoPIkZCdbu/uHeD+Zj0z9UACkPGWInRVukazhwI
 bqVzrW7ckk09ng3bkskhKXuIdw+3Ary6Ts2++EwhBy/rn+/uaRgUgCWBAC/HT3ug0TU/pgwAfh7
 o9iEDKBp3dHRtg==
X-Received: by 2002:a05:6000:2505:b0:45e:f266:f4c4 with SMTP id
 ffacd0b85a97d-463ad3e2c35mr611838f8f.29.1781722443213; 
 Wed, 17 Jun 2026 11:54:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d275sm12765123f8f.2.2026.06.17.11.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 11:53:57 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 17 Jun 2026 18:53:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
X-Gerrit-Change-Number: 1712
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1712?usp=email>
X-Gerrit-Commit: 98434caa86b9fbee586d14b65c82cf0274661155
X-Gerrit-Comment-Date: Wed, 17 Jun 2026 18:53:53 +0000
In-Reply-To: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
References: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE0NTMzMDAwLkk3ZWMzMThjODZhZjk5NDI4NGQxYzYyNzJlM2JiZTJiMWVkZTE2MGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1439111087d4bce688f20933dc9117fe023a98bd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZvOw-0001VA-FK
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: Fix memory
 leak in dns_server_addr_parse
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0951981806875983323=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0951981806875983323==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DrAHPRZ1Bbc="; charset=UTF-8

--DrAHPRZ1Bbc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

d12fk has posted=
 comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1712?usp=3Demail )

Change subject: dns: Fix memory leak in dns_serve=
r_addr_parse
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1712?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
Gerrit-Change-Number: =
1712
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerri=
t-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 17 J=
un 2026 18:53:53 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--DrAHPRZ1Bbc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail">change 1712</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7ec318c8=
6af994284d1c6272e3bbe2b1ede160fd </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1712 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk =
&lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Wed, 17 Jun 2026 18:53:53 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--DrAHPRZ1Bbc=--


--===============0951981806875983323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0951981806875983323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0951981806875983323==--

