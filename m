Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EC606A32E
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RwAwtgfj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GMjpQ3+W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TcIghvXf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IR/fwSWg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NVIeJI8Z/Yy1XHpeHiCqfkS7N6H1w41GJwYGBrYmf0U=; b=RwAwtgfj+bwurE07k4P0Xc8+g5
	Kyd/ghFbb28Q8vkM5uPa88swK08iGW0HelTOySixmOotqxUEMv8ZfE5kQU89T2qXThRhk2MASctZw
	ElxbZxKR2y0c3ZLmmAqFGDcK1Z4BYJF2dZIUjYz3Zwab5zQNj8FFNIB+5jb7qpQNC4LA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP1Gc-00000000686-1g4j;
	Thu, 05 Nov 2026 17:28:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP1Gb-0000000067z-0ddt
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:28:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Oa8s2KFxVEkWNSHwlzP1WH0/ECrntXM849SfnCD2C5Q=; b=GMjpQ3+WfWf6yyL4oXy0b0uD6O
 ZYdOrfop35EnJoFWmuHw1CCgIBNK688r97ZAqf+HXfXfh6LHkyOqXWFb/ajcGxo6ZDcURUtXg01r8
 yt7Jj76xMBFa8MehqAzn7BkVBls3t5NAjCS/7kwoFaSgLapW09OXa6M+8xROaO2WpZyo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Oa8s2KFxVEkWNSHwlzP1WH0/ECrntXM849SfnCD2C5Q=; b=TcIghvXfTp/v9ZRi4GqgO0uvmu
 3caO2Oze8B+xVoFuTPg2Ezj+35AdR1DZ+xcrmKDlILFQDGLn1FMdRvETkuGJelXSewMcg2GhO6vpv
 dY1jKy7YFzbPMvXC89sxyJtAnhkli8GoKN3vuns2wUXBwa80jzne+6eL7JinTKnSjTlI=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP1GZ-000000008F2-3m5x for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:28:49 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so19697855e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 09:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793899721; x=1794504521; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Oa8s2KFxVEkWNSHwlzP1WH0/ECrntXM849SfnCD2C5Q=;
 b=IR/fwSWg2cTfyhA+4k4VZfXBw+fadpgiZGtWC7tCHcH/bvHzjA9wEB5bedfqyei3SB
 K0f6xMUinRtkzcvcxGPzl4HVFGcPnM3tMLxty7UC9cVU2e3WvjpVEk2kQuI2thj5BBxb
 aZMohpXbQcrJNZlNi+gP7+tVPPU6tsztvQyhShSyqOuY/TS2CKYKGA665im7NuLcTXAO
 31zA4feMLyQ3EISu8slhPNhVuUGMv+lBzYMxBaM8D2DrxsgNksvhrntNCUreX/JVh5rv
 8leLj+8fdVpQvIKGaU1GqRPUErdnWkYguSbvwigCEPyM6l+j5h0uPXR4k7uInBgudfmy
 4TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899721; x=1794504521;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Oa8s2KFxVEkWNSHwlzP1WH0/ECrntXM849SfnCD2C5Q=;
 b=O6QUCDd6DCuBBBZ6Mx/zc23HKGaq5if1v/eMTOW6RfVgCQwn3Wco5QDcnHKt9NtfVY
 PsCZrDT+4rGmW5b1S1lJMk9a5bsUYiOnQ9snCNYm5SUVEuhqRojuu5BFbaDe4daPhJzf
 9UJk0YOFYZSS6DZXQDb+w8XX4Hi9hhQAfgzpS5K5d8R6IC5+MoDJkOl3QYd1+DcygsSF
 1OEWPFwZugZiRzquUchz72OqBWMbnyQ2AlNem7ehpXJ5CX/RN8R6BZ66eLacr8YVjW5a
 Epg0UWyU+wzZVmgCiBSk4rGBhz7nHvHE0dxmo4fZaLozwaDQ2YCK5mOTYQuwtSGLI0pY
 gf4w==
X-Gm-Message-State: APuU4Z/pN2kdSPhW6SPWCbkDX8Z5/tUF1W4G1+7OFitD2umw/SeznRYq
 Jg7UcTRjUPytjwxrvRsWy4x7oOSRRzNXWop4NSgelWMABAlgR4d5r7M3V0ZnJdVp7ibg9CrbP2n
 hTsA2Ncx2TPWqrQqGXfFDZz+2I/3eHjsTGFcqjujqQX+f2BBgWOPa3y0ai0QT8sH4GTiI
X-Gm-Gg: AYBFou0w8c1CW2FUJpU4mnYmkvjek3GORRbsWloHbG1MKxbED4tfjZc55qsyN7LPwkG
 eIyDg8JCJKFyhHIPRyQ2OD4ZYse2Z2Lprw5oVBsQZerC6vi2ai12KBFylUdPVqznpYResRGa3ga
 jJaQLmIOdkv65IXt9OoNs2bkpBUmMy/Y8MPjnvqpa3H1yoYKjmFpN75E3Wi5/uruTbPBhqPhzER
 TG8Q9OgHpReHFLYYDR5prIIV1Ooqmbqy0ssso1eajDvpXCxfzii94SNOaDqVpDQVgd3K2i3ud4g
 3cNGDPQPSAJb7LEaFwJSHQCfxszWrVoZ4djKz6MYD8/WTukcuEX7SZHDTtnfJc5rlB6TXydF+4V
 NQay9SJuoHKwkFNFtnn2nItMHaJl9hqiHXS0UmqENRwVrqKBAJDW9gwG6QoVBjFxYGhlYUFRWyW
 mZv1Jv2fuW1t2yGMV96TUn/kOCPZm2Q9ZfDxw4bts51Ww9NPc3R5+pB3egFjNaVT50nUXg+qOPf
 tO4CDGKrnlB/1dQvS1Fym4FYjaeW2E6oWbnXRpbdLtJRBFjBzZZQgmz7i+PgtqLZmngx83tsFMS
 O4+djAim/jnS1VFFtXODZ2fA6VJLYk3hL1lVOM4dgdJKovOou9U/CCqaGUCaf8C3+gHZMGZH/hc
 4kq4ELSBKF/N1KLlMQQTu/vmxLUB9GmDJazmraB3jnpfDHyyGgIvjsuTmDkNQwcqIDP5l8knhYw
 WV/i8YYhMjImhTGg==
X-Received: by 2002:a05:600c:8b46:b0:4a0:4a8:d444 with SMTP id
 5b1f17b1804b1-4ac18c73238mr443161655e9.33.1793899721205; 
 Thu, 05 Nov 2026 09:28:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed5521c7sm10932220f8f.39.2026.11.05.09.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:28:40 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 17:28:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 6e50bb1d2c9a151a25a3ebdec30e88c37bd787f5
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 17:28:38 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <29d4c98a0a0ca91b3a08a49fc73ea92246190e7f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP1GZ-000000008F2-3m5x
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1050349126318732872=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1050349126318732872==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RVLmI7FVZPs="; charset=UTF-8

--RVLmI7FVZPs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Ralf Lici has posted=
 comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1860?usp=3Demail )

Change subject: Add python scripts that d=
emonstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8:

(1 comment)

Patchset:

PS8: 
http=
s://sashiko=2Edev/#/patchset/67d1d819918ba106750d9248c7e7a1d89e0ba088-Email=
ReplacePatchSet-HTML@gerrit=2Eopenvpn=2Enet?part=3D1



-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c=
22
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 8
Gerrit-Owner: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerr=
it-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 2026 17:28:38 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: No

--RVLmI7FVZPs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Ralf Lici has posted comments=
 on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></p><p>1 comment:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #8:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">https://sashiko=2Edev/#/patchset/67d1d819=
918ba106750d9248c7e7a1d89e0ba088-EmailReplacePatchSet-HTML@gerrit=2Eopenvpn=
=2Enet?part=3D1</p></li></ul></li></ul><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">change 1860</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie20289737d50=
2a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1860 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of =
user not set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: Ralf L=
ici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Thu, 05 Nov 2026 17:28:38 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No=
 </div>

</body></html>
--RVLmI7FVZPs=--


--===============1050349126318732872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1050349126318732872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1050349126318732872==--

