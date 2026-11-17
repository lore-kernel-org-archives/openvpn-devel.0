Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38019606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TsSvLUuY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b+VEEQCE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nVaG+oQL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GuxUTJHH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5HIC8FarhXooUWHztFQ/l7H3JgdK4e84Y2vP2JDJdKs=; b=TsSvLUuYUBWCbhY0Pj0ld+zjs2
	+HNazskVWE6UMCv5sSihpD5gdM+zWmZUFMBGlSP5z4N60CwEdfhZDSQzaIXl9//l/VuyJs2g2Ymcs
	+FKm3diL/cBCgN3YXia2dSaM79MTMk4KTtwtwGgo/hZ+N1JKz0ktzSnWlo6RTjpQj6VM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTEzc-000000007gp-2Der;
	Tue, 17 Nov 2026 08:56:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTEza-000000007gX-2RSU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AFu6WgnhQ/RuyHmNTXfxncav7bgrkNEC1SZziGqeU2E=; b=b+VEEQCEV8TkxtTeJb0Udo5KYr
 W1QkGVz4hbqzQSejpyHsOKb3ZnBK6dwTz4ZZnQ8XqY+Sflp/pNHWjhJFcXram7/6Iz/1yTCoIsgmz
 ocxRi98c7QYA8PXNZCI/Xs0+9CPcQEX0+Ie5Hyzuc1bm5a4tn6VUGADuswUAEDyU/rF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AFu6WgnhQ/RuyHmNTXfxncav7bgrkNEC1SZziGqeU2E=; b=nVaG+oQLUVJgXJCpJ0OeOkzk1d
 1SPlj3QNb4IH8PDjU7uOdCI+SkYOVl0zvhUMp3zpqJ2ZAF0CpqC/8URMx5quiyyqXIAdB2cfB8gdO
 +Fdx8SLI0EfOKza+KD1facKFjWxvAxKze+FNjkql0U5ov8Y19Sfx6ckaAD/j1vnBhHic=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTEzY-000000006qf-3DiW for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:56:42 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so47319715e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 00:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794905794; x=1795510594; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AFu6WgnhQ/RuyHmNTXfxncav7bgrkNEC1SZziGqeU2E=;
 b=GuxUTJHHJUrwDYkinhprxVATfckI4ODoYR0LqEzzpsecKpJ8QdX1qIf6s1D7a5GB+n
 OxSL3Vi5dL+RXdWkXbL3mYVVDURgW0E3aW4HAaFfPE3tXSj5l2gI7BTnZhAULr+v+gVZ
 QVcvxvfH2E+N4NhVdfOO0yU0HgRpKT+f054AsatHIOPmkwXuLtgCWuCjX42kEJk2MsFU
 TWge1EPcZ2m6LUGQncjionfHz9D38jFOOzI+ygo8EHLlTrqzAVn7lWb56iyjcF5oVBYu
 lPeXw5nK15SFUaae2UgNQl98sDX6bH7hyi/jvVPpUG1qUtlbrva7qq0l3CKG0se2b9r9
 086Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794905794; x=1795510594;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AFu6WgnhQ/RuyHmNTXfxncav7bgrkNEC1SZziGqeU2E=;
 b=WOjb9ZzmoK/LRdVCEh+vISq3/ZFtOfG/UiO/HSpUZepL5Um+ToD+Vcz3tsZ9y77oBL
 Bg3twRU91TbIZ9epCU1ZRn8735YuHoxgIl8I/0VKq32Ajx7VDVMddTSHAG0pIsq2GC70
 Eu2/6LJ7NyKvQJvccSQlHyW8TftmFWPCy9YvTHb8CYRSmoQATTIkrfDQ6ztywhwpW+6C
 P3efr89Xeh3ChhJ5Br3flcTgmXAUpYVd3fM2hMKHhZhWW0mAQOWYAslHmErtjrNMMQ0g
 qhIH1OgnLY+nUGuJ0JCZanED3Vvyr0J2xXyh7TRecSYIcEcyuk6j7jfRa8dy96RBq0QY
 R1Mg==
X-Forwarded-Encrypted: i=1;
 AL+hErHkBkIvnBeJXA7o9/YiKt6/IaBqiCTs/0NKIl4MG6nxYIEkRUdXYv/lzF7hjN9Wil4tP/RWIIP0/nl0MLuy@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Wl6U/b1Dy6V1Qn+VKVAm0o5oFgdNdR2f44G7ooEcZplJN/pvt
 iSDP985fWAxjcGuSqur5ywnwfEFxywfZ5gbq6AduLNSroMSQO9KaRvkTKLyB+c175aS6/j383Zd
 1mcXlfSaRGXG3KaS9loHU5AvF1J8+T7OuruvnuL90x66F7J51DpGPAV4bs0vrGPxysZZ75vVDQ2
 CklQPptw==
X-Gm-Gg: AYBFou1zqLkiTjaCKlNPVsVvAC7hBIMN3XXr5yvhRgWU5s/YNWgNi0SgkE7e+GEOVFq
 wX9Qsk8fMCXGDOeTqLM67qm9xyxnqLYqLm2Q9y0r8WJyd3u6fE1+fCcj++jdZ7sysV3A7ff8avj
 dkfMkjfGbGM8exv9e1C1j6znhC/j2UGXJsMiiGOMBkmF41YqmPl7LAXd+7iYymIN4CKHT30XIid
 4usTIe0+BwDKwELOWCQhHEJVQeMRi7gbQXFm/nYX4S7eVolttLozcoaWKWok4NdCz7m2a+Fk37e
 YJB5TSTmIhWSni5eYhZPl61l5LW2mJSbDu5T+SWH72odduz8BmpdzD8cAPvtbK8tClj/HBg9oSg
 28XCtVD3LM0ZGKWsIEmz99ISiO77kEnxBD+XCz1382SWGcY1f3xYe1Xh4TEDaIKPZPhAHKZ01ut
 HQHLG9/0zfH6ZJFcWqYErh1YyCFTlKcDWEOgmOcYiRxNHKKwPIpD0iIaFZHcVGzbZVw5LCZgpua
 W6IsC4VElM3EJhRlz+R0ix0mQuoe4LNgRpFKan4TNOukHHDUjfz0iUrA7hUj1mmxDfihZ+JF3t6
 eNmvNDBV16sTYa40H2C8KY6UeK6QZI1Me5hfsQD5x19pNlzq40jh7h4H9AGN9MCIwRAvB0/fmT1
 GfJ80CXUfuWQN55JWcTQuoqFahUXzdG6EqKR3n7VRxSzLfU9QWOglFM+jIjzayvIs+AcBjgnfX7
 xowracpAE/xnwHYG5f
X-Received: by 2002:a05:600c:6548:b0:4b0:c1ae:829 with SMTP id
 5b1f17b1804b1-4bb55a8d621mr200911135e9.30.1794905794028; 
 Tue, 17 Nov 2026 00:56:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783c2650sm58388525e9.14.2026.11.17.00.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:56:33 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 08:56:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibd316e5c3e6a0fb600ec4817aa079554464fd942
X-Gerrit-Change-Number: 2208
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2208?usp=email>
X-Gerrit-Commit: 7ed989888bbf2b223cac7c153608e78ff8e5ded0
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 08:56:32 +0000
In-Reply-To: <gerrit.1794904611000.Ibd316e5c3e6a0fb600ec4817aa079554464fd942@gerrit.openvpn.net>
References: <gerrit.1794904611000.Ibd316e5c3e6a0fb600ec4817aa079554464fd942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTA0NjExMDAwLkliZDMxNmU1YzNlNmEwZmI2MDBlYzQ4MTdhYTA3OTU1NDQ2NGZkOTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3f3e62c5dab5343aabe58ab088da392bfdce0fd-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTEzY-000000006qf-3DiW
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clinat: locate the
 TCP/UDP header via the IP header length
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5649127958397265860=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5649127958397265860==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H2zvuJz8OcE="; charset=UTF-8

--H2zvuJz8OcE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2208?usp=3Demail )

Cha=
nge subject: clinat: locate the TCP/UDP header via the IP header length
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2

(1 comment)

Patchset:

PS1: 
yick, been there since 2012!
FTR=
 when the UDP port or the TCP flags/seqnum/acknum/source port was modified,=
 the checksum was still properly computed and the packet was *delivered*=2E=
 which makes this a bit more impactful than what the commit says=2E Definit=
ely worth backporting=2E

@razvanc@mailbox=2Eorg dhcp_extract_router_msg() =
still assumes a 20-byte IP header, maybe you want to create another patch f=
or that? =F0=9F=98=8E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2208?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ibd316e5c3e6a0fb600ec4817aa079554464fd942
Gerrit-Change-Number: 2208
G=
errit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Comment-Date: Tue, 17 Nov 2026 08:56:32 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: Yes

--H2zvuJz8OcE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2208?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2208?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
yick, been there since 2012!<br>FTR when the UDP port or the TCP flags/seqn=
um/acknum/source port was modified, the checksum was still properly compute=
d and the packet was *delivered*=2E which makes this a bit more impactful t=
han what the commit says=2E Definitely worth backporting=2E</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">@razvanc@ma=
ilbox=2Eorg dhcp_extract_router_msg() still assumes a 20-byte IP header, ma=
ybe you want to create another patch for that? =F0=9F=98=8E</p></li></ul></=
li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2208?usp=3Demail">change 2208</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2208?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: Ibd316e5c3e6a0fb600ec4817aa079554464fd942 </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 2208 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"=
> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 08:56:32 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--H2zvuJz8OcE=--


--===============5649127958397265860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5649127958397265860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5649127958397265860==--

